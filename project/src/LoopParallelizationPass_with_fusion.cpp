#include "llvm/ADT/DenseMap.h"
#include "llvm/ADT/SmallPtrSet.h"
#include "llvm/ADT/SmallVector.h"
#include "llvm/ADT/STLExtras.h"

#include "llvm/Analysis/AliasAnalysis.h"
#include "llvm/Analysis/LoopAccessAnalysis.h"
#include "llvm/Analysis/LoopInfo.h"
#include "llvm/Analysis/ScalarEvolution.h"
#include "llvm/Analysis/TargetTransformInfo.h"
#include "llvm/Analysis/TargetLibraryInfo.h"
#include "llvm/Analysis/AssumptionCache.h"
#include "llvm/Analysis/OptimizationRemarkEmitter.h"

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
#include "llvm/Transforms/Utils/LoopUtils.h"
#include "llvm/Transforms/Utils/Cloning.h"

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
// Helpers for ordering + CFG chain
// -------------------------------
static DenseMap<BasicBlock *, unsigned> computeBlockOrder(Function &F) {
  DenseMap<BasicBlock *, unsigned> Order;
  unsigned idx = 0;
  for (BasicBlock &BB : F) {
    Order[&BB] = idx++;
  }
  return Order;
}

// Allow: phi nodes, dbg/lifetime intrinsics, and the terminator.
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
    return false;
  }
  return true;
}

// Follow a chain of empty blocks with unconditional branches.
// Return true iff From reaches To through only such blocks.
static bool reachesViaEmptyUncondChain(BasicBlock *From, BasicBlock *To,
                                      BasicBlock **LastBeforeTo = nullptr,
                                      unsigned Limit = 8) {
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

// Match "Next = phi + 1" (possibly with trivial casts).
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

  // If Next is a forwarding PHI, chase once.
  if (auto *P = dyn_cast<PHINode>(Next)) {
    if (P->getNumIncomingValues() == 1) {
      Value *Only = stripTrivialCasts(P->getIncomingValue(0));
      if (auto *I = dyn_cast<Instruction>(Only))
        if (isPlusOne(I)) return true;
    }
  }
  return false;
}

// Prefer latch terminator compare.
static ICmpInst *findLoopCmp(Loop *L) {
  if (BasicBlock *Latch = L->getLoopLatch()) {
    if (auto *Br = dyn_cast<BranchInst>(Latch->getTerminator())) {
      if (Br->isConditional()) {
        return dyn_cast<ICmpInst>(stripTrivialCasts(Br->getCondition()));
      }
    }
  }
  // Fallback: scan header
  if (BasicBlock *Header = L->getHeader()) {
    for (Instruction &I : *Header) {
      if (auto *C = dyn_cast<ICmpInst>(&I)) return C;
    }
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

    // Print version once per process to verify you're loading the right dylib.
    static bool Printed = false;
    if (!Printed) {
      errs() << "FUSION_PASS_VERSION=0.3_fusion_only\n";
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
    std::vector<std::pair<Loop*, Loop*>> LoopsToFuse;

    unsigned FusionCandidates = 0;
    unsigned FusionAttempts   = 0;
    unsigned FusionSucceeded  = 0;

    // --------------------------------------------------------------------------
    // Step 1: Identify fusible top-level consecutive loops
    // --------------------------------------------------------------------------
    if (EnableLoopFusion) {
      std::vector<Loop *> TopLevelLoops;
      for (Loop *L : LI)
        TopLevelLoops.push_back(L);

      auto Order = computeBlockOrder(F);
      llvm::sort(TopLevelLoops, [&](Loop *A, Loop *B) {
        return Order.lookup(A->getHeader()) < Order.lookup(B->getHeader());
      });

      errs() << "FUSION_LOOP_ORDER function=" << F.getName() << " [";
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
    // Step 2: Fuse
    // --------------------------------------------------------------------------
    for (auto &P : LoopsToFuse) {
      ++FusionAttempts;
      if (fuseLoops(P.first, P.second, F, SE, LI, DT)) {
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
    // Step 3: Collect parallelizable loops (best-effort; analyses may be stale post-fusion)
    // --------------------------------------------------------------------------
    for (Loop *L : LI) {
      if (isLoopParallelizable(L, F, SE, LI, DT, TTI, AA, AC, TLI)) {
        LoopsToParallelize.push_back(L);
        errs() << "Found parallelizable loop in function: " << F.getName() << "\n";
      }
    }

    // --------------------------------------------------------------------------
    // Step 4: Parallelize loops (per-loop OpenMPIRBuilder; NON-shared)
    // --------------------------------------------------------------------------
    for (Loop *L : LoopsToParallelize) {
      if (parallelizeLoop(L, F, SE, LI, DT)) {
        Changed = true;
        errs() << "Successfully parallelized loop in function: " << F.getName() << "\n";
      }
    }

    return Changed ? PreservedAnalyses::none() : PreservedAnalyses::all();
  }

private:
  // --------------------------------------------------------------------------
  // Parallelizability check
  // --------------------------------------------------------------------------
  bool isLoopParallelizable(Loop *L, Function &F, ScalarEvolution &SE,
                           LoopInfo &LI, DominatorTree &DT,
                           TargetTransformInfo &TTI, AAResults &AA,
                           AssumptionCache &AC, TargetLibraryInfo &TLI) {
    if (!L->getLoopPreheader() || !L->getLoopLatch()) {
      LLVM_DEBUG(dbgs() << "Loop doesn't have preheader or latch\n");
      return false;
    }

    if (L->getBlocks().size() > 10) {
      LLVM_DEBUG(dbgs() << "Loop too complex (too many blocks)\n");
      return false;
    }

    // NOTE: LoopAccessInfo ctor signature varies across LLVM versions.
    LoopAccessInfo LAI(L, &SE, &TTI, &TLI, &AA, &DT, &LI);

    if (!LAI.canVectorizeMemory()) {
      LLVM_DEBUG(dbgs() << "Loop has unsafe memory dependencies\n");
      return false;
    }

    const MemoryDepChecker &DepChecker = LAI.getDepChecker();
    const SmallVectorImpl<MemoryDepChecker::Dependence> *Deps =
        DepChecker.getDependences();

    if (Deps && !Deps->empty()) {
      LLVM_DEBUG(dbgs() << "Loop has memory dependencies (" << Deps->size() << ")\n");
      return false;
    }

    return true;
  }

  // --------------------------------------------------------------------------
  // Parallelize loop (per-loop OpenMPIRBuilder; keeps your original approach)
  // --------------------------------------------------------------------------
  bool parallelizeLoop(Loop *L, Function &F, ScalarEvolution &SE,
                       LoopInfo &LI, DominatorTree &DT) {
    Module *M = F.getParent();

    BasicBlock *Preheader = L->getLoopPreheader();
    BasicBlock *Header = L->getHeader();
    BasicBlock *Latch = L->getLoopLatch();
    if (!Preheader || !Header || !Latch) return false;

    PHINode *IndVar = L->getCanonicalInductionVariable();
    if (!IndVar) return false;

    const SCEV *TripCountSCEV = SE.getBackedgeTakenCount(L);
    if (isa<SCEVCouldNotCompute>(TripCountSCEV)) return false;

    Value *StartVal = IndVar->getIncomingValueForBlock(Preheader);
    Value *EndVal = nullptr;

    auto *LatchBr = dyn_cast<BranchInst>(Latch->getTerminator());
    if (!LatchBr || !LatchBr->isConditional()) return false;

    auto *Cmp = dyn_cast<ICmpInst>(LatchBr->getCondition());
    if (!Cmp) return false;

    if (Cmp->getOperand(0) == IndVar) EndVal = Cmp->getOperand(1);
    else if (Cmp->getOperand(1) == IndVar) EndVal = Cmp->getOperand(0);
    else return false;

    OpenMPIRBuilder OMPBuilder(*M);
    OMPBuilder.initialize();

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
            if (isa<PHINode>(&I) || I.isTerminator()) continue;
            Instruction *ClonedI = I.clone();
            for (unsigned i = 0; i < ClonedI->getNumOperands(); ++i) {
              Value *Op = ClonedI->getOperand(i);
              if (VMap.count(Op)) ClonedI->setOperand(i, VMap[Op]);
            }
            Builder.Insert(ClonedI);
            VMap[&I] = ClonedI;
          }

          for (BasicBlock *BB : L->getBlocks()) {
            if (BB == Header || BB == Latch) continue;
            for (Instruction &I : *BB) {
              if (I.isTerminator()) continue;
              Instruction *ClonedI = I.clone();
              for (unsigned i = 0; i < ClonedI->getNumOperands(); ++i) {
                Value *Op = ClonedI->getOperand(i);
                if (VMap.count(Op)) ClonedI->setOperand(i, VMap[Op]);
              }
              Builder.Insert(ClonedI);
              VMap[&I] = ClonedI;
            }
          }

          return Error::success();
        },
        NumIters,
        "parallel_loop");

    if (!CLIOrError) return false;

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

    if (!ResultOrError) return false;

    BasicBlock *Exit = L->getExitBlock();
    if (Exit) {
      Preheader->getTerminator()->eraseFromParent();
      Builder.SetInsertPoint(Preheader);
      Builder.CreateBr(CLI->getPreheader());

      CLI->getAfter()->getTerminator()->eraseFromParent();
      Builder.SetInsertPoint(CLI->getAfter());
      Builder.CreateBr(Exit);

      for (BasicBlock *BB : L->getBlocks()) BB->dropAllReferences();
      for (BasicBlock *BB : L->getBlocks()) BB->eraseFromParent();
    }

    return true;
  }

  // --------------------------------------------------------------------------
  // Fusion legality
  // --------------------------------------------------------------------------
  bool canFuseLoops(Loop *L1, Loop *L2, Function &F, ScalarEvolution &SE,
                    LoopInfo &LI, DominatorTree &DT, TargetTransformInfo &TTI,
                    AAResults &AA, AssumptionCache &AC,
                    TargetLibraryInfo &TLI) {
    if (!L1 || !L2) return false;

    errs() << "FUSION_CHECK function=" << F.getName()
           << " L1_header="; L1->getHeader()->printAsOperand(errs(), false);
    errs() << " L2_header="; L2->getHeader()->printAsOperand(errs(), false);
    errs() << "\n";

    if (!isLoopParallelizable(L1, F, SE, LI, DT, TTI, AA, AC, TLI)) {
      errs() << "FUSION_REJECT reason=L1_not_parallelizable\n";
      return false;
    }
    if (!isLoopParallelizable(L2, F, SE, LI, DT, TTI, AA, AC, TLI)) {
      errs() << "FUSION_REJECT reason=L2_not_parallelizable\n";
      return false;
    }

    // Tripcount check (semantic, not pointer identity).
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
      errs() << "FUSION_REJECT reason=missing_exit_or_preheader\n";
      return false;
    }

    SmallVector<BasicBlock*, 8> Exits;
    L1->getExitBlocks(Exits);
    if (Exits.empty()) {
      errs() << "FUSION_REJECT reason=missing_exit_or_preheader\n";
      return false;
    }

    errs() << "FUSION_CFG L2Pre="; L2Pre->printAsOperand(errs(), false);
    errs() << " L1Exits={";
    for (BasicBlock *EB : Exits) { EB->printAsOperand(errs(), false); errs() << " "; }
    errs() << "}\n";

    bool Consecutive = false;
    for (BasicBlock *EB : Exits) {
      if (reachesViaEmptyUncondChain(EB, L2Pre, nullptr)) {
        Consecutive = true;
        break;
      }
    }
    if (!Consecutive) {
      errs() << "FUSION_REJECT reason=not_consecutive_cfg\n";
      return false;
    }

    // Conservative dependence check: reject if any store in L1 may alias any load in L2.
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
  // Simple canonical loop info (accepts `icmp eq (i+1), N` style)
  // --------------------------------------------------------------------------
  struct SimpleLoopInfo {
    PHINode *IndVar       = nullptr;
    BasicBlock *Preheader = nullptr;
    BasicBlock *Header    = nullptr;
    BasicBlock *Latch     = nullptr;
    BasicBlock *Exit      = nullptr; // unique exit outside loop (if any)
    Value *Start          = nullptr;
    Value *End            = nullptr;
    ICmpInst::Predicate Pred = ICmpInst::BAD_ICMP_PREDICATE;
    // Whether the compare is on (Next == End) rather than (Phi < End).
    bool CompareOnNext = false;
  };

  // If L2 has any SSA values used outside L2, we bail.
  bool loopHasLiveOutSSA(Loop *L2) {
    SmallPtrSet<BasicBlock*, 16> Blocks;
    for (BasicBlock *BB : L2->getBlocks()) Blocks.insert(BB);

    for (BasicBlock *BB : L2->getBlocks()) {
      for (Instruction &I : *BB) {
        if (I.getType()->isVoidTy()) continue;
        for (User *U : I.users()) {
          auto *UI = dyn_cast<Instruction>(U);
          if (!UI) continue;
          if (!Blocks.contains(UI->getParent())) {
            return true;
          }
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
    BasicBlock *Exit      = L->getExitBlock(); // requires unique exit if non-null

    if (!Preheader || !Header || !Latch) {
      errs() << "FUSION_REJECT reason=not_simple_canonical missing_blocks\n";
      return false;
    }
    Out.Exit = Exit; // may be null; we’ll require non-null later in fuseLoops.

    if (L->getNumBackEdges() != 1) {
      errs() << "FUSION_REJECT reason=not_simple_canonical backedges\n";
      return false;
    }

    ICmpInst *Cmp = findLoopCmp(L);
    if (!Cmp) {
      errs() << "FUSION_REJECT reason=not_simple_canonical no_cmp\n";
      return false;
    }

    // Pick an induction PHI in header:
    // - integer
    // - incoming from preheader and latch
    // - latch incoming is (phi + 1)
    PHINode *IndPhi = nullptr;
    Value *Start = nullptr;
    Value *Next  = nullptr;

    for (PHINode &PN : Header->phis()) {
      if (!PN.getType()->isIntegerTy()) continue;

      int preIdx = PN.getBasicBlockIndex(Preheader);
      int latIdx = PN.getBasicBlockIndex(Latch);
      if (preIdx < 0 || latIdx < 0) continue;

      Value *S = stripTrivialCasts(PN.getIncomingValue(preIdx));
      Value *N = stripTrivialCasts(PN.getIncomingValue(latIdx));
      if (!matchStepPlusOne(N, &PN)) continue;

      // Require compare uses either PN or Next (clang often compares Next==N)
      Value *Op0 = stripTrivialCasts(Cmp->getOperand(0));
      Value *Op1 = stripTrivialCasts(Cmp->getOperand(1));

      bool UsesPhi = (Op0 == &PN) || (Op1 == &PN);
      bool UsesNext = (Op0 == N) || (Op1 == N);

      if (!UsesPhi && !UsesNext) continue;

      IndPhi = &PN;
      Start  = S;
      Next   = N;
      Out.CompareOnNext = UsesNext && !UsesPhi;
      break;
    }

    if (!IndPhi) {
      errs() << "FUSION_REJECT reason=not_simple_canonical no_induction_phi\n";
      return false;
    }

    // Determine End (the non-(phi/next) operand).
    Value *Op0 = stripTrivialCasts(Cmp->getOperand(0));
    Value *Op1 = stripTrivialCasts(Cmp->getOperand(1));

    Value *Key = Out.CompareOnNext ? Next : (Value*)IndPhi;
    Value *End = nullptr;

    if (Op0 == Key) End = Op1;
    else if (Op1 == Key) End = Op0;
    else {
      errs() << "FUSION_REJECT reason=not_simple_canonical cmp_not_on_iv\n";
      return false;
    }

    // Accept predicates: relational OR eq/ne (clang uses eq for “done”).
    auto Pred = Cmp->getPredicate();
    if (!(Cmp->isRelational() || Pred == ICmpInst::ICMP_EQ || Pred == ICmpInst::ICMP_NE)) {
      errs() << "FUSION_REJECT reason=not_simple_canonical bad_pred\n";
      return false;
    }

    Out.IndVar    = IndPhi;
    Out.Preheader = Preheader;
    Out.Header    = Header;
    Out.Latch     = Latch;
    Out.Start     = Start;
    Out.End       = End;
    Out.Pred      = Pred;
    return true;
  }

  // --------------------------------------------------------------------------
  // Fusion implementation (restricted; same as your working shared version)
  // --------------------------------------------------------------------------
  bool fuseLoops(Loop *L1, Loop *L2, Function &F, ScalarEvolution &SE,
                 LoopInfo &LI, DominatorTree &DT) {
    SimpleLoopInfo Info1, Info2;
    if (!getSimpleLoopInfo(L1, SE, Info1) || !getSimpleLoopInfo(L2, SE, Info2)) {
      errs() << "FUSION_REJECT reason=not_simple_canonical\n";
      return false;
    }

    // Require same “semantic” bounds.
    if (Info1.Start != Info2.Start || Info1.End != Info2.End) {
      errs() << "FUSION_REJECT reason=bounds_differ\n";
      return false;
    }

    // If one compares on Next and the other compares on Phi, we still allow fusion,
    // because we only clone L2 body into L1; L1’s control remains.
    // But we do require the same predicate class (eq vs relational) to avoid surprises.
    auto isEqLike = [](ICmpInst::Predicate P) {
      return P == ICmpInst::ICMP_EQ || P == ICmpInst::ICMP_NE;
    };
    if (isEqLike(Info1.Pred) != isEqLike(Info2.Pred)) {
      errs() << "FUSION_REJECT reason=cmp_form_mismatch\n";
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

    // Find a connector: some L1 exit that reaches L2Pre via empty/uncond chain.
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

    // Require connector is trivially empty and uncond (micro-tests).
    if (!isTriviallyEmptyBlock(Connector)) {
      errs() << "FUSION_REJECT reason=connector_not_empty\n";
      return false;
    }
    auto *ConnBr = dyn_cast<BranchInst>(Connector->getTerminator());
    if (!ConnBr || ConnBr->isConditional()) {
      errs() << "FUSION_REJECT reason=connector_not_uncond\n";
      return false;
    }

    // Require L2Pre is trivially empty/uncond.
    if (!isTriviallyEmptyBlock(L2Pre)) {
      errs() << "FUSION_REJECT reason=L2_preheader_not_empty\n";
      return false;
    }
    auto *PreBr = dyn_cast<BranchInst>(L2Pre->getTerminator());
    if (!PreBr || PreBr->isConditional()) {
      errs() << "FUSION_REJECT reason=L2_preheader_not_uncond\n";
      return false;
    }

    // 1) Clone L2 body into L1 header before terminator
    IRBuilder<> Builder(Info1.Header->getTerminator());
    ValueToValueMapTy VMap;
    VMap[Info2.IndVar] = Info1.IndVar;

    auto cloneBlockIntoL1Header = [&](BasicBlock *BB) {
      for (Instruction &I : *BB) {
        if (isa<PHINode>(&I) || I.isTerminator()) continue;
        if (isa<DbgInfoIntrinsic>(&I)) continue;

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

    cloneBlockIntoL1Header(Info2.Header);
    for (BasicBlock *BB : L2->getBlocks()) {
      if (BB == Info2.Header || BB == Info2.Latch) continue;
      cloneBlockIntoL1Header(BB);
    }

    // 2) Bypass L2 by rewiring connector to jump directly to L2Exit
    ConnBr->setSuccessor(0, L2Exit);

    // 3) Delete L2 loop blocks
    SmallVector<BasicBlock*, 16> L2Blocks(L2->block_begin(), L2->block_end());
    for (BasicBlock *BB : L2Blocks) BB->dropAllReferences();
    for (BasicBlock *BB : L2Blocks) BB->eraseFromParent();

    // Try to remove L2Pre if it became unreachable and isn’t the connector.
    if (L2Pre != Connector) {
      if (pred_empty(L2Pre)) {
        L2Pre->dropAllReferences();
        L2Pre->eraseFromParent();
      }
    }

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
          "0.3_fusion_only",
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
