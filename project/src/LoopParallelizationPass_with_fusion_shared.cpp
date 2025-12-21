#include "llvm/ADT/DenseMap.h"
#include "llvm/ADT/SmallPtrSet.h"
#include "llvm/ADT/SmallVector.h"
#include "llvm/ADT/STLExtras.h"

#include "llvm/Analysis/AliasAnalysis.h"
#include "llvm/Analysis/AssumptionCache.h"
#include "llvm/Analysis/LoopAccessAnalysis.h"
#include "llvm/Analysis/LoopInfo.h"
#include "llvm/Analysis/OptimizationRemarkEmitter.h"
#include "llvm/Analysis/ScalarEvolution.h"
#include "llvm/Analysis/TargetLibraryInfo.h"
#include "llvm/Analysis/TargetTransformInfo.h"

#include "llvm/Frontend/OpenMP/OMPIRBuilder.h"

#include "llvm/IR/Dominators.h"
#include "llvm/IR/IRBuilder.h"
#include "llvm/IR/IntrinsicInst.h"
#include "llvm/IR/PassManager.h"

#include "llvm/Passes/PassBuilder.h"
#include "llvm/Passes/PassPlugin.h"

#include "llvm/Support/CommandLine.h"
#include "llvm/Support/Debug.h"
#include "llvm/Support/raw_ostream.h"

#include "llvm/Transforms/Scalar/LoopPassManager.h"
#include "llvm/Transforms/Utils/Cloning.h"
#include "llvm/Transforms/Utils/LoopUtils.h"

#include <vector>

using namespace llvm;

#define DEBUG_TYPE "loop-parallelization"

// Command line options
static cl::opt<bool> EnableParallelization(
    "enable-loop-parallel",
    cl::desc("Enable automatic loop parallelization"),
    cl::init(true));

static cl::opt<bool> EnableLoopFusion(
    "enable-loop-fusion",
    cl::desc("Enable loop fusion before parallelization"),
    cl::init(true));

static cl::opt<unsigned> NumThreads(
    "parallel-threads",
    cl::desc("Number of threads for parallel execution (0 = auto)"),
    cl::init(0));

namespace {

// -------------------------------
// Helpers: function block order
// -------------------------------
static DenseMap<BasicBlock *, unsigned> computeBlockOrder(Function &F) {
  DenseMap<BasicBlock *, unsigned> Order;
  unsigned idx = 0;
  for (BasicBlock &BB : F)
    Order[&BB] = idx++;
  return Order;
}

// -------------------------------
// Helpers: "trivially empty block"
// -------------------------------
static bool isTriviallyEmptyBlock(const BasicBlock *BB) {
  for (const Instruction &I : *BB) {
    if (isa<PHINode>(&I)) continue;
    if (I.isTerminator()) continue;
    if (isa<DbgInfoIntrinsic>(&I)) continue;

    if (auto *II = dyn_cast<IntrinsicInst>(&I)) {
      if (II->getIntrinsicID() == Intrinsic::lifetime_start ||
          II->getIntrinsicID() == Intrinsic::lifetime_end) {
        continue;
      }
    }

    // Any other instruction -> not empty
    return false;
  }
  return true;
}

// Follow a chain of empty blocks with unconditional branches.
// Return true iff From reaches To through only such blocks.
// Optionally returns the predecessor of To inside the chain (LastBeforeTo).
static bool reachesViaEmptyUncondChain(BasicBlock *From, BasicBlock *To,
                                      BasicBlock **LastBeforeTo = nullptr,
                                      unsigned Limit = 12) {
  BasicBlock *Cur = From;
  BasicBlock *Prev = nullptr;

  for (unsigned steps = 0; steps < Limit && Cur; ++steps) {
    if (Cur == To) {
      if (LastBeforeTo) *LastBeforeTo = Prev;
      return true;
    }

    auto *Br = dyn_cast<BranchInst>(Cur->getTerminator());
    if (!Br || Br->isConditional()) return false;

    if (!isTriviallyEmptyBlock(Cur)) return false;

    Prev = Cur;
    Cur = Br->getSuccessor(0);
  }

  if (Cur == To) {
    if (LastBeforeTo) *LastBeforeTo = Prev;
    return true;
  }
  return false;
}

// Compare SCEVs "semantically" in a cheap way: textual print equality.
static bool scevSemanticallyEqual(const SCEV *A, const SCEV *B) {
  if (A == B) return true;
  if (!A || !B) return false;
  SmallString<128> SA, SB;
  raw_svector_ostream OSA(SA), OSB(SB);
  A->print(OSA);
  B->print(OSB);
  return SA == SB;
}

// -------------------------------
// Helpers: IV pattern matching
// -------------------------------
static Value *stripTrivialCasts(Value *V) {
  while (true) {
    if (auto *Z = dyn_cast<ZExtInst>(V)) { V = Z->getOperand(0); continue; }
    if (auto *S = dyn_cast<SExtInst>(V)) { V = S->getOperand(0); continue; }
    if (auto *T = dyn_cast<TruncInst>(V)) { V = T->getOperand(0); continue; }
    if (auto *BC = dyn_cast<BitCastInst>(V)) { V = BC->getOperand(0); continue; }
    break;
  }
  return V;
}

static bool matchStepPlusOne(Value *Next, PHINode *Phi) {
  Next = stripTrivialCasts(Next);

  auto isPlusOne = [&](Instruction *I) -> bool {
    if (!I) return false;
    if (I->getOpcode() != Instruction::Add) return false;
    Value *A = stripTrivialCasts(I->getOperand(0));
    Value *B = stripTrivialCasts(I->getOperand(1));
    auto *CA = dyn_cast<ConstantInt>(A);
    auto *CB = dyn_cast<ConstantInt>(B);

    if (A == Phi && CB && CB->isOne()) return true;
    if (B == Phi && CA && CA->isOne()) return true;
    return false;
  };

  if (auto *I = dyn_cast<Instruction>(Next))
    if (isPlusOne(I)) return true;

  // If Next is a forwarding PHI, chase it (rare but possible).
  if (auto *P = dyn_cast<PHINode>(Next)) {
    if (P->getNumIncomingValues() == 1) {
      Value *Only = stripTrivialCasts(P->getIncomingValue(0));
      if (auto *I = dyn_cast<Instruction>(Only))
        if (isPlusOne(I)) return true;
    }
  }

  return false;
}

static ICmpInst *findLoopCmp(Loop *L) {
  // Prefer latch terminator condition.
  if (BasicBlock *Latch = L->getLoopLatch()) {
    if (auto *Br = dyn_cast<BranchInst>(Latch->getTerminator())) {
      if (Br->isConditional()) {
        return dyn_cast<ICmpInst>(stripTrivialCasts(Br->getCondition()));
      }
    }
  }
  // Fall back: scan header for a compare.
  if (BasicBlock *Header = L->getHeader()) {
    for (Instruction &I : *Header)
      if (auto *C = dyn_cast<ICmpInst>(&I))
        return C;
  }
  return nullptr;
}

// -------------------------------
// The pass
// -------------------------------
class LoopParallelizationPass : public PassInfoMixin<LoopParallelizationPass> {
public:
  PreservedAnalyses run(Function &F, FunctionAnalysisManager &FAM) {
    if (!EnableParallelization)
      return PreservedAnalyses::all();

    // Print once per opt invocation to sanity-check you're loading the right dylib.
    static bool Printed = false;
    if (!Printed) {
      errs() << "FUSION_PASS_VERSION=0.3\n";
      Printed = true;
    }

    auto &LI  = FAM.getResult<LoopAnalysis>(F);
    auto &SE  = FAM.getResult<ScalarEvolutionAnalysis>(F);
    auto &DT  = FAM.getResult<DominatorTreeAnalysis>(F);
    auto &TTI = FAM.getResult<TargetIRAnalysis>(F);
    auto &AA  = FAM.getResult<AAManager>(F);
    auto &AC  = FAM.getResult<AssumptionAnalysis>(F);
    auto &TLI = FAM.getResult<TargetLibraryAnalysis>(F);

    auto &ORE = FAM.getResult<OptimizationRemarkEmitterAnalysis>(F);
    (void)ORE;

    bool Changed = false;
    std::vector<Loop *> LoopsToParallelize;
    std::vector<std::pair<Loop *, Loop *>> LoopsToFuse;

    unsigned FusionCandidates = 0;
    unsigned FusionAttempts   = 0;
    unsigned FusionSucceeded  = 0;

    // --------------------------------------------------------------------------
    // Step 1: Identify fusible loop pairs
    // --------------------------------------------------------------------------
    if (EnableLoopFusion) {
      std::vector<Loop *> TopLevelLoops;
      for (Loop *L : LI)
        TopLevelLoops.push_back(L);

      // Stable order by header position in function.
      auto Order = computeBlockOrder(F);
      llvm::sort(TopLevelLoops, [&](Loop *A, Loop *B) {
        return Order.lookup(A->getHeader()) < Order.lookup(B->getHeader());
      });

      // Helpful ordering log
      errs() << "FUSION_LOOP_ORDER function=" << F.getName() << " [ ";
      for (Loop *L : TopLevelLoops) errs() << L->getHeader()->getName() << " ";
      errs() << "]\n";

      for (size_t i = 0; i + 1 < TopLevelLoops.size(); i++) {
        Loop *L1 = TopLevelLoops[i];
        Loop *L2 = TopLevelLoops[i + 1];

        if (canFuseLoops(L1, L2, F, SE, LI, DT, TTI, AA, AC, TLI)) {
          LoopsToFuse.push_back({L1, L2});
          ++FusionCandidates;
          errs() << "Found fusible loops in function: " << F.getName() << "\n";
        }
      }
    }

    // --------------------------------------------------------------------------
    // Step 2: Perform fusion
    // --------------------------------------------------------------------------
    for (auto &LoopPair : LoopsToFuse) {
      ++FusionAttempts;
      if (fuseLoops(LoopPair.first, LoopPair.second, F, SE, LI, DT)) {
        Changed = true;
        ++FusionSucceeded;
        errs() << "FUSION_APPLIED function=" << F.getName()
               << " fused_pairs_total=" << FusionSucceeded << "\n";
      }
    }

    if (EnableLoopFusion) {
      errs() << "LOOP_FUSION_SUMMARY function=" << F.getName()
             << " candidates=" << FusionCandidates
             << " attempts=" << FusionAttempts
             << " succeeded=" << FusionSucceeded << "\n";
    }

    // --------------------------------------------------------------------------
    // Step 3: Collect parallelizable loops
    // NOTE: Analyses can be stale after IR changes. For your course project
    // it’s usually OK; if you see weirdness, split fusion/parallelization into
    // separate pipeline stages so analyses are recomputed.
    // --------------------------------------------------------------------------
    for (Loop *L : LI) {
      if (isLoopParallelizable(L, F, SE, LI, DT, TTI, AA, AC, TLI)) {
        LoopsToParallelize.push_back(L);
        errs() << "Found parallelizable loop in function: " << F.getName() << "\n";
      }
    }

    // --------------------------------------------------------------------------
    // Step 4: Shared OpenMPIRBuilder
    // --------------------------------------------------------------------------
    Module *M = F.getParent();
    OpenMPIRBuilder OMPBuilder(*M);
    OMPBuilder.initialize();

    // --------------------------------------------------------------------------
    // Step 5: Parallelize loops (worksharing)
    // --------------------------------------------------------------------------
    for (Loop *L : LoopsToParallelize) {
      if (parallelizeLoopWithWorksharing(L, F, SE, LI, DT, OMPBuilder)) {
        Changed = true;
        errs() << "Successfully parallelized loop in function: " << F.getName() << "\n";
      }
    }

    return Changed ? PreservedAnalyses::none() : PreservedAnalyses::all();
  }

private:
  // --------------------------------------------------------------------------
  // Parallelizability check (conservative)
  // --------------------------------------------------------------------------
  bool isLoopParallelizable(Loop *L, Function &F, ScalarEvolution &SE,
                           LoopInfo &LI, DominatorTree &DT,
                           TargetTransformInfo &TTI, AAResults &AA,
                           AssumptionCache &AC, TargetLibraryInfo &TLI) {
    if (!L->getLoopPreheader() || !L->getLoopLatch())
      return false;

    // Keep it simple for course project.
    if (L->getBlocks().size() > 10)
      return false;

    // LoopAccessInfo ctor signature varies; this matches your LLVM.
    LoopAccessInfo LAI(L, &SE, &TTI, &TLI, &AA, &DT, &LI);

    if (!LAI.canVectorizeMemory())
      return false;

    const MemoryDepChecker &DepChecker = LAI.getDepChecker();
    const SmallVectorImpl<MemoryDepChecker::Dependence> *Deps =
        DepChecker.getDependences();

    if (Deps && !Deps->empty())
      return false;

    return true;
  }

  // --------------------------------------------------------------------------
  // OpenMP worksharing parallelization (shared builder)
  // --------------------------------------------------------------------------
  bool parallelizeLoopWithWorksharing(Loop *L, Function &F, ScalarEvolution &SE,
                                      LoopInfo &LI, DominatorTree &DT,
                                      OpenMPIRBuilder &OMPBuilder) {
    BasicBlock *Preheader = L->getLoopPreheader();
    BasicBlock *Header = L->getHeader();
    BasicBlock *Latch = L->getLoopLatch();
    if (!Preheader || !Header || !Latch)
      return false;

    PHINode *IndVar = L->getCanonicalInductionVariable();
    if (!IndVar)
      return false;

    const SCEV *TripCountSCEV = SE.getBackedgeTakenCount(L);
    if (isa<SCEVCouldNotCompute>(TripCountSCEV))
      return false;

    Value *StartVal = IndVar->getIncomingValueForBlock(Preheader);
    Value *EndVal = nullptr;

    auto *LatchBr = dyn_cast<BranchInst>(Latch->getTerminator());
    if (!LatchBr || !LatchBr->isConditional())
      return false;

    auto *Cmp = dyn_cast<ICmpInst>(LatchBr->getCondition());
    if (!Cmp)
      return false;

    if (Cmp->getOperand(0) == IndVar)
      EndVal = Cmp->getOperand(1);
    else if (Cmp->getOperand(1) == IndVar)
      EndVal = Cmp->getOperand(0);
    else
      return false;

    IRBuilder<> Builder(Preheader->getTerminator());
    OpenMPIRBuilder::LocationDescription Loc(Builder);

    Value *NumIters = Builder.CreateSub(EndVal, StartVal, "num_iters");

    auto CLIOrError = OMPBuilder.createCanonicalLoop(
        Loc,
        [&](IRBuilderBase::InsertPoint IP, Value *IV) -> llvm::Error {
          Builder.restoreIP(IP);

          ValueToValueMapTy VMap;
          VMap[IndVar] = IV;

          for (Instruction &I : *Header) {
            if (isa<PHINode>(&I) || I.isTerminator())
              continue;

            Instruction *ClonedI = I.clone();
            for (unsigned i = 0; i < ClonedI->getNumOperands(); ++i) {
              Value *Op = ClonedI->getOperand(i);
              if (VMap.count(Op))
                ClonedI->setOperand(i, VMap[Op]);
            }
            Builder.Insert(ClonedI);
            VMap[&I] = ClonedI;
          }

          for (BasicBlock *BB : L->getBlocks()) {
            if (BB == Header || BB == Latch)
              continue;

            for (Instruction &I : *BB) {
              if (I.isTerminator())
                continue;

              Instruction *ClonedI = I.clone();
              for (unsigned i = 0; i < ClonedI->getNumOperands(); ++i) {
                Value *Op = ClonedI->getOperand(i);
                if (VMap.count(Op))
                  ClonedI->setOperand(i, VMap[Op]);
              }
              Builder.Insert(ClonedI);
              VMap[&I] = ClonedI;
            }
          }

          return Error::success();
        },
        NumIters,
        "parallel_loop");

    if (!CLIOrError)
      return false;

    CanonicalLoopInfo *CLI = *CLIOrError;

    IRBuilderBase::InsertPoint AllocaIP(
        &F.getEntryBlock(), F.getEntryBlock().getFirstInsertionPt());

    auto ResultOrError = OMPBuilder.applyWorkshareLoop(
        DebugLoc(), CLI, AllocaIP,
        /*NeedsBarrier*/ true,
        /*SchedKind*/ llvm::omp::OMP_SCHEDULE_Static,
        /*ChunkSize*/ nullptr,
        /*HasSimdModifier*/ false,
        /*HasMonotonicModifier*/ false,
        /*HasNonmonotonicModifier*/ false,
        /*HasOrderedClause*/ false,
        /*LoopType*/ llvm::omp::WorksharingLoopType::ForStaticLoop);

    if (!ResultOrError)
      return false;

    BasicBlock *Exit = L->getExitBlock();
    if (Exit) {
      Preheader->getTerminator()->eraseFromParent();
      Builder.SetInsertPoint(Preheader);
      Builder.CreateBr(CLI->getPreheader());

      CLI->getAfter()->getTerminator()->eraseFromParent();
      Builder.SetInsertPoint(CLI->getAfter());
      Builder.CreateBr(Exit);

      for (BasicBlock *BB : L->getBlocks())
        BB->dropAllReferences();
      for (BasicBlock *BB : L->getBlocks())
        BB->eraseFromParent();
    }

    return true;
  }

  // --------------------------------------------------------------------------
  // Fusion legality: conservative + fixes "not_consecutive_cfg" false negatives
  // --------------------------------------------------------------------------
  bool canFuseLoops(Loop *L1, Loop *L2, Function &F, ScalarEvolution &SE,
                    LoopInfo &LI, DominatorTree &DT, TargetTransformInfo &TTI,
                    AAResults &AA, AssumptionCache &AC,
                    TargetLibraryInfo &TLI) {
    if (!L1 || !L2) return false;

    errs() << "FUSION_CHECK function=" << F.getName()
           << " L1_header=";
    L1->getHeader()->printAsOperand(errs(), false);
    errs() << " L2_header=";
    L2->getHeader()->printAsOperand(errs(), false);
    errs() << "\n";

    if (!isLoopParallelizable(L1, F, SE, LI, DT, TTI, AA, AC, TLI)) {
      errs() << "FUSION_REJECT reason=L1_not_parallelizable\n";
      return false;
    }
    if (!isLoopParallelizable(L2, F, SE, LI, DT, TTI, AA, AC, TLI)) {
      errs() << "FUSION_REJECT reason=L2_not_parallelizable\n";
      return false;
    }

    // Compare backedge taken count semantically.
    const SCEV *TC1 = SE.getBackedgeTakenCount(L1);
    const SCEV *TC2 = SE.getBackedgeTakenCount(L2);
    if (isa<SCEVCouldNotCompute>(TC1) || isa<SCEVCouldNotCompute>(TC2)) {
      errs() << "FUSION_REJECT reason=tripcount_unknown\n";
      return false;
    }
    if (!scevSemanticallyEqual(TC1, TC2)) {
      SmallString<128> SA, SB;
      raw_svector_ostream OSA(SA), OSB(SB);
      TC1->print(OSA); TC2->print(OSB);
      errs() << "FUSION_REJECT reason=tripcount_mismatch tc1=" << SA
             << " tc2=" << SB << "\n";
      return false;
    }

    BasicBlock *L2Pre = L2->getLoopPreheader();
    if (!L2Pre) {
      errs() << "FUSION_REJECT reason=missing_L2_preheader\n";
      return false;
    }

    // Find ANY exit of L1 that reaches L2Pre via empty uncond chain.
    SmallVector<BasicBlock*, 8> L1Exits;
    L1->getExitBlocks(L1Exits);
    if (L1Exits.empty()) {
      errs() << "FUSION_REJECT reason=missing_L1_exitblocks\n";
      return false;
    }

    errs() << "FUSION_CFG L2Pre=";
    L2Pre->printAsOperand(errs(), false);
    errs() << " L1Exits={";
    for (BasicBlock *EB : L1Exits) { EB->printAsOperand(errs(), false); errs() << " "; }
    errs() << "}\n";

    bool Consecutive = false;
    for (BasicBlock *EB : L1Exits) {
      if (reachesViaEmptyUncondChain(EB, L2Pre, nullptr)) {
        Consecutive = true;
        break;
      }
    }
    if (!Consecutive) {
      errs() << "FUSION_REJECT reason=not_consecutive_cfg\n";
      return false;
    }

    // Very conservative dependence check: if L2 loads may-alias a store in L1 -> reject.
    for (BasicBlock *BB1 : L1->getBlocks()) {
      for (Instruction &I1 : *BB1) {
        auto *SI = dyn_cast<StoreInst>(&I1);
        if (!SI) continue;
        if (SI->isVolatile()) {
          errs() << "FUSION_REJECT reason=volatile_store\n";
          return false;
        }
        Value *Ptr1 = SI->getPointerOperand();

        for (BasicBlock *BB2 : L2->getBlocks()) {
          for (Instruction &I2 : *BB2) {
            auto *LI2 = dyn_cast<LoadInst>(&I2);
            if (!LI2) continue;
            if (LI2->isVolatile()) {
              errs() << "FUSION_REJECT reason=volatile_load\n";
              return false;
            }
            Value *Ptr2 = LI2->getPointerOperand();
            if (AA.alias(Ptr1, Ptr2) != AliasResult::NoAlias) {
              errs() << "FUSION_REJECT reason=alias_store_to_load\n";
              return false;
            }
          }
        }
      }
    }

    errs() << "FUSION_ACCEPT\n";
    return true;
  }

  // --------------------------------------------------------------------------
  // Simple canonical-ish loop info (relaxed)
  // --------------------------------------------------------------------------
  struct SimpleLoopInfo {
    PHINode *IndVar       = nullptr;
    BasicBlock *Preheader = nullptr;
    BasicBlock *Header    = nullptr;
    BasicBlock *Latch     = nullptr;
    BasicBlock *Exit      = nullptr; // requires unique exit for the fusion rewrite
    Value *Start          = nullptr;
    Value *End            = nullptr;
    ICmpInst::Predicate Pred = ICmpInst::BAD_ICMP_PREDICATE;

    bool CmpOnNext = false; // NEW
  };

  // If L2 defines any non-void SSA value used outside L2 blocks, we bail.
  bool loopHasLiveOutSSA(Loop *L2) {
    SmallPtrSet<BasicBlock*, 16> Blocks;
    for (BasicBlock *BB : L2->getBlocks())
      Blocks.insert(BB);

    for (BasicBlock *BB : L2->getBlocks()) {
      for (Instruction &I : *BB) {
        if (I.getType()->isVoidTy()) continue;
        for (User *U : I.users()) {
          auto *UI = dyn_cast<Instruction>(U);
          if (!UI) continue;
          if (!Blocks.contains(UI->getParent()))
            return true;
        }
      }
    }
    return false;
  }

  bool getSimpleLoopInfo(Loop *L, ScalarEvolution &SE, SimpleLoopInfo &Out) {
    Out = SimpleLoopInfo();

    BasicBlock *Preheader = L->getLoopPreheader();
    BasicBlock *Header    = L->getHeader();
    BasicBlock *Latch     = L->getLoopLatch();
    BasicBlock *Exit      = L->getExitBlock(); // must be unique for rewrite

    if (!Preheader || !Header || !Latch) {
      errs() << "FUSION_REJECT reason=not_simple_canonical missing_blocks\n";
      return false;
    }
    if (!Exit) {
      errs() << "FUSION_REJECT reason=not_simple_canonical no_unique_exit\n";
      return false;
    }

    if (L->getNumBackEdges() != 1) {
      errs() << "FUSION_REJECT reason=not_simple_canonical backedges\n";
      return false;
    }

    ICmpInst *Cmp = findLoopCmp(L);
    if (!Cmp) {
      errs() << "FUSION_REJECT reason=not_simple_canonical no_cmp\n";
      return false;
    }

    // NOTE: clang -O1 often uses `icmp eq (i+1), End`. That is NOT "relational".
    // So we do NOT require Cmp->isRelational().

    // Find a header PHI that looks like an induction variable:
    //   phi = start (from preheader)
    //   next = phi + 1 (from latch)
    // And the loop compare uses either phi OR next.
    PHINode *IndPhi = nullptr;
    Value *Start = nullptr;
    Value *End   = nullptr;
    bool   CmpOnNext = false;

    Value *Cmp0 = stripTrivialCasts(Cmp->getOperand(0));
    Value *Cmp1 = stripTrivialCasts(Cmp->getOperand(1));

    for (PHINode &PN : Header->phis()) {
      if (!PN.getType()->isIntegerTy()) continue;

      int preIdx = PN.getBasicBlockIndex(Preheader);
      int latIdx = PN.getBasicBlockIndex(Latch);
      if (preIdx < 0 || latIdx < 0) continue;

      Value *S = stripTrivialCasts(PN.getIncomingValue(preIdx));
      Value *N = stripTrivialCasts(PN.getIncomingValue(latIdx));

      // Must be `next = phi + 1` (or forwarding PHI of that)
      if (!matchStepPlusOne(N, &PN)) continue;

      // Compare may be on PN (i < End) OR on N (next == End) as clang often emits.
      bool usesPhi  = (Cmp0 == &PN) || (Cmp1 == &PN);
      bool usesNext = (Cmp0 == N)   || (Cmp1 == N);

      if (!usesPhi && !usesNext) continue;

      // Determine End as the other operand
      Value *LocalEnd = nullptr;
      if (usesPhi) {
        LocalEnd = (Cmp0 == &PN) ? Cmp1 : Cmp0;
      } else {
        LocalEnd = (Cmp0 == N) ? Cmp1 : Cmp0;
      }

      IndPhi = &PN;
      Start = S;
      End = LocalEnd;
      CmpOnNext = usesNext;
      break;
    }

    if (!IndPhi || !Start || !End) {
      errs() << "FUSION_REJECT reason=not_simple_canonical no_induction_phi\n";
      return false;
    }

    Out.IndVar    = IndPhi;
    Out.Preheader = Preheader;
    Out.Header    = Header;
    Out.Latch     = Latch;
    Out.Exit      = Exit;
    Out.Start     = Start;
    Out.End       = End;
    Out.Pred      = Cmp->getPredicate();
    Out.CmpOnNext = CmpOnNext;
    return true;
  }


  // --------------------------------------------------------------------------
  // Fusion implementation (restricted but should fuse your micro-tests)
  // --------------------------------------------------------------------------
  bool fuseLoops(Loop *L1, Loop *L2, Function &F, ScalarEvolution &SE,
                 LoopInfo &LI, DominatorTree &DT) {
    SimpleLoopInfo Info1, Info2;
    if (!getSimpleLoopInfo(L1, SE, Info1) || !getSimpleLoopInfo(L2, SE, Info2)) {
      errs() << "FUSION_REJECT reason=not_simple_canonical\n";
      return false;
    }

    // Restrict to straight-line-ish loops so “clone into header” is meaningful.
    // Many clang -O1 loops become single-block loops (header==latch).
    if (L1->getBlocks().size() > 2 || L2->getBlocks().size() > 2) {
      errs() << "FUSION_REJECT reason=loop_too_complex_for_fuser\n";
      return false;
    }

    // Require same bounds & predicate (by pointer; micro-tests typically match).
    // If you want more robust, you can compare printed forms here too.
    // if (Info1.Start != Info2.Start || Info1.End != Info2.End || Info1.Pred != Info2.Pred) {
    //   errs() << "FUSION_REJECT reason=bounds_differ\n";
    //   return false;
    // }

    if (Info1.Start != Info2.Start ||
        Info1.End != Info2.End ||
        Info1.Pred != Info2.Pred ||
        Info1.CmpOnNext != Info2.CmpOnNext) {
      errs() << "FUSION_REJECT reason=bounds_differ\n";
      return false;
    }


    if (L1->getParentLoop() || L2->getParentLoop()) {
      errs() << "FUSION_REJECT reason=nested_loop\n";
      return false;
    }

    if (loopHasLiveOutSSA(L2)) {
      errs() << "FUSION_REJECT reason=L2_has_liveout_ssa\n";
      return false;
    }

    BasicBlock *L2Pre  = Info2.Preheader;
    BasicBlock *L2Exit = Info2.Exit;
    if (!L2Pre || !L2Exit) {
      errs() << "FUSION_REJECT reason=missing_L2_pre_or_exit\n";
      return false;
    }

    // Find a connector: some L1 exit block that reaches L2Pre via empty-uncond chain.
    SmallVector<BasicBlock*, 8> L1Exits;
    L1->getExitBlocks(L1Exits);

    BasicBlock *Connector = nullptr;
    for (BasicBlock *EB : L1Exits) {
      if (reachesViaEmptyUncondChain(EB, L2Pre, nullptr)) {
        Connector = EB;
        break;
      }
    }
    if (!Connector) {
      errs() << "FUSION_REJECT reason=no_connector\n";
      return false;
    }

    // Require connector is trivially empty + unconditional.
    if (!isTriviallyEmptyBlock(Connector)) {
      errs() << "FUSION_REJECT reason=connector_not_empty\n";
      return false;
    }
    auto *ConnBr = dyn_cast<BranchInst>(Connector->getTerminator());
    if (!ConnBr || ConnBr->isConditional()) {
      errs() << "FUSION_REJECT reason=connector_not_uncond\n";
      return false;
    }

    // Require L2 preheader is also trivially empty + unconditional.
    if (!isTriviallyEmptyBlock(L2Pre)) {
      errs() << "FUSION_REJECT reason=L2_preheader_not_empty\n";
      return false;
    }
    auto *PreBr = dyn_cast<BranchInst>(L2Pre->getTerminator());
    if (!PreBr || PreBr->isConditional()) {
      errs() << "FUSION_REJECT reason=L2_preheader_not_uncond\n";
      return false;
    }

    // 1) Clone L2 body instructions into L1 header before terminator.
    IRBuilder<> Builder(Info1.Header->getTerminator());

    ValueToValueMapTy VMap;
    VMap[Info2.IndVar] = Info1.IndVar;

    auto cloneBlockIntoL1Header = [&](BasicBlock *BB) {
      for (Instruction &I : *BB) {
        if (isa<PHINode>(&I) || I.isTerminator())
          continue;
        if (isa<DbgInfoIntrinsic>(&I))
          continue;

        Instruction *NewI = I.clone();
        for (unsigned op = 0; op < NewI->getNumOperands(); ++op) {
          Value *OldOp = NewI->getOperand(op);
          auto It = VMap.find(OldOp);
          if (It != VMap.end())
            NewI->setOperand(op, It->second);
        }
        Builder.Insert(NewI);
        VMap[&I] = NewI;
      }
    };

    // Clone L2 header (minus PHIs/terminator)
    cloneBlockIntoL1Header(Info2.Header);

    // Clone any other L2 blocks except latch (usually none for micro-tests)
    for (BasicBlock *BB : L2->getBlocks()) {
      if (BB == Info2.Header || BB == Info2.Latch)
        continue;
      cloneBlockIntoL1Header(BB);
    }

    // 2) Bypass L2: rewire connector to jump directly to L2Exit.
    ConnBr->setSuccessor(0, L2Exit);

    // 3) Erase L2 loop blocks.
    SmallVector<BasicBlock*, 16> L2Blocks(L2->block_begin(), L2->block_end());
    for (BasicBlock *BB : L2Blocks)
      BB->dropAllReferences();
    for (BasicBlock *BB : L2Blocks)
      BB->eraseFromParent();

    // If L2Pre is now unreachable and distinct, delete it too.
    if (L2Pre != Connector) {
      if (pred_empty(L2Pre)) {
        L2Pre->dropAllReferences();
        L2Pre->eraseFromParent();
      }
    }

    // Best-effort LoopInfo update.
    LI.erase(L2);

    errs() << "FUSED_OK function=" << F.getName() << "\n";
    return true;
  }
};

} // anonymous namespace

// Plugin registration
extern "C" LLVM_ATTRIBUTE_WEAK ::llvm::PassPluginLibraryInfo
llvmGetPassPluginInfo() {
  return {LLVM_PLUGIN_API_VERSION,
          "LoopParallelization",
          "0.3",
          [](PassBuilder &PB) {
            PB.registerPipelineParsingCallback(
                [](StringRef Name, FunctionPassManager &FPM,
                   ArrayRef<PassBuilder::PipelineElement>) {
                  if (Name == "loop-parallelize") {
                    FPM.addPass(LoopParallelizationPass());
                    return true;
                  }
                  return false;
                });
          }};
}

