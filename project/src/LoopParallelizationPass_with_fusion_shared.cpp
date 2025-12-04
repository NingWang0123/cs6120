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
#include "llvm/IR/PassManager.h"
#include "llvm/Passes/PassBuilder.h"
#include "llvm/Passes/PassPlugin.h"
#include "llvm/Support/CommandLine.h"
#include "llvm/Support/Debug.h"
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

class LoopParallelizationPass : public PassInfoMixin<LoopParallelizationPass> {
public:
  PreservedAnalyses run(Function &F, FunctionAnalysisManager &FAM) {
    if (!EnableParallelization)
      return PreservedAnalyses::all();

    auto &LI  = FAM.getResult<LoopAnalysis>(F);
    auto &SE  = FAM.getResult<ScalarEvolutionAnalysis>(F);
    auto &DT  = FAM.getResult<DominatorTreeAnalysis>(F);
    auto &TTI = FAM.getResult<TargetIRAnalysis>(F);
    auto &AA  = FAM.getResult<AAManager>(F);
    auto &AC  = FAM.getResult<AssumptionAnalysis>(F);
    auto &TLI = FAM.getResult<TargetLibraryAnalysis>(F);

    bool Changed = false;
    std::vector<Loop *> LoopsToParallelize;
    std::vector<std::pair<Loop *, Loop *>> LoopsToFuse;

    // Step 1: Identify fusible loop pairs (consecutive independent loops)
    if (EnableLoopFusion) {
      std::vector<Loop *> TopLevelLoops;
      for (Loop *L : LI)
        TopLevelLoops.push_back(L);

      for (size_t i = 0; i + 1 < TopLevelLoops.size(); i++) {
        Loop *L1 = TopLevelLoops[i];
        Loop *L2 = TopLevelLoops[i + 1];

        if (canFuseLoops(L1, L2, F, SE, LI, DT, TTI, AA, AC, TLI)) {
          LoopsToFuse.push_back({L1, L2});
          errs() << "Found fusible loops in function: " << F.getName() << "\n";
        }
      }
    }

    // Step 2: Perform loop fusion (simple restricted version)
    for (auto &LoopPair : LoopsToFuse) {
      if (fuseLoops(LoopPair.first, LoopPair.second, F, SE, LI, DT)) {
        Changed = true;
        errs() << "Fused loops in function: " << F.getName() << "\n";
      }
    }

    // Step 3: Collect parallelizable loops (after fusion)
    for (Loop *L : LI) {
      if (isLoopParallelizable(L, F, SE, LI, DT, TTI, AA, AC, TLI)) {
        LoopsToParallelize.push_back(L);
        errs() << "Found parallelizable loop in function: " << F.getName()
               << "\n";
      }
    }

    if (LoopsToParallelize.empty()) {
      return Changed ? PreservedAnalyses::none() : PreservedAnalyses::all();
    }

    // NEW STEP: Build a single OpenMPIRBuilder per module / function
    Module *M = F.getParent();
    LLVMContext &Ctx = M->getContext();
    OpenMPIRBuilder OMPBuilder(*M);
    OMPBuilder.initialize();

    // NEW: Wrap the function body in a single parallel region + single region.
    // This reduces fork/join overhead: one team per function.
    bool Wrapped = wrapFunctionInParallelSingle(F, OMPBuilder, Ctx);
    if (!Wrapped) {
      LLVM_DEBUG(dbgs() << "Failed to wrap function in parallel region; "
                        << "falling back to per-loop parallelization\n");
    } else {
      Changed = true;
    }


    // Step 4: Parallelize the loops using the shared OpenMPIRBuilder
    for (Loop *L : LoopsToParallelize) {
      if (parallelizeLoop(L, F, SE, LI, DT, OMPBuilder)) {
        Changed = true;
        errs() << "Successfully parallelized loop in function: "
               << F.getName() << "\n";
      }
    }

    return Changed ? PreservedAnalyses::none() : PreservedAnalyses::all();
  }

private:
  // --------------------------------------------------------------------------
  //  Parallelizability check
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

    // NOTE: The exact argument order for LoopAccessInfo may differ by LLVM version.
    // You may need to adjust &TTI/&TLI depending on your local headers.
    LoopAccessInfo LAI(L, &SE, &TTI, &TLI, &AA, &DT, &LI);

    if (!LAI.canVectorizeMemory()) {
      LLVM_DEBUG(dbgs() << "Loop has unsafe memory dependencies\n");
      return false;
    }

    const MemoryDepChecker &DepChecker = LAI.getDepChecker();
    const SmallVectorImpl<MemoryDepChecker::Dependence> *Deps =
        DepChecker.getDependences();

    if (Deps && !Deps->empty()) {
      LLVM_DEBUG(dbgs() << "Loop has memory dependencies (" << Deps->size()
                        << ")\n");
      return false;
    }

    LLVM_DEBUG(
        dbgs() << "Loop is safe to parallelize (no unsafe memory dependences)\n");
    return true;
  }

  // --------------------------------------------------------------------------
  //  Wrap function body in:   parallel { single { original body } }
  // --------------------------------------------------------------------------
  bool wrapFunctionInParallelSingle(Function &F,
                                    OpenMPIRBuilder &OMPBuilder,
                                    LLVMContext &Ctx) {
    // We only support non-empty functions with a normal entry.
    if (F.empty())
      return false;

    BasicBlock &EntryBB = F.getEntryBlock();

    // Split the entry block so we can insert the parallel region in the original
    // entry, and branch into the "real" code from inside the single region.
    Instruction *SplitPt = EntryBB.getFirstNonPHI();
    if (!SplitPt)
      return false;

    BasicBlock *OrigEntry =
        EntryBB.splitBasicBlock(SplitPt, "omp.orig.entry");

    // Now EntryBB ends with an unconditional branch to OrigEntry. We will
    // erase that branch and replace it with the OpenMP parallel region.
    Instruction *OldTerm = EntryBB.getTerminator();
    if (!OldTerm)
      return false;
    OldTerm->eraseFromParent();

    IRBuilder<> Builder(&EntryBB);
    Builder.SetInsertPoint(&EntryBB);

    OpenMPIRBuilder::LocationDescription Loc(Builder);

    // Optional num_threads clause
    Value *NumThreadsVal = nullptr;
    if (NumThreads.getValue() != 0) {
      NumThreadsVal =
          ConstantInt::get(Type::getInt32Ty(Ctx), NumThreads.getValue());
    }

    // Build the parallel region: parallel { single { br OrigEntry } }
    OMPBuilder.createParallel(
        Loc,
        [&](OpenMPIRBuilder::InsertPointTy AllocaIP,
            OpenMPIRBuilder::InsertPointTy CodeGenIP, BasicBlock &ExitBB) {
          // Body of the parallel region
          IRBuilder<> BodyBuilder(CodeGenIP.getBlock(),
                                  CodeGenIP.getPoint());
          OpenMPIRBuilder::LocationDescription BodyLoc(BodyBuilder);

          // Single region so only one thread executes the original CFG.
          OMPBuilder.createSingle(
              BodyLoc,
              [&](OpenMPIRBuilder::InsertPointTy SingleIP,
                  BasicBlock &SingleContBB) {
                IRBuilder<> SingleBuilder(SingleIP.getBlock(),
                                          SingleIP.getPoint());
                // Jump into the original entry (which now holds all the real code)
                SingleBuilder.CreateBr(OrigEntry);
              },
              /*IsNowait=*/false);

          // After single ends, control flows to SingleContBB and then through
          // the rest of the parallel region into ExitBB. We don't need special
          // handling here; returns are inside the original CFG.
        },
        /*IfCondition=*/nullptr,
        /*NumThreads=*/NumThreadsVal,
        /*ProcBind=*/omp::OMP_PROC_BIND_unknown,
        /*IsCancellable=*/false);

    return true;
  }

  // --------------------------------------------------------------------------
  //  Loop parallelization using a shared OpenMPIRBuilder
  // --------------------------------------------------------------------------
  bool parallelizeLoop(Loop *L, Function &F, ScalarEvolution &SE,
                       LoopInfo &LI, DominatorTree &DT,
                       OpenMPIRBuilder &OMPBuilder) {
    Module *M = F.getParent();

    BasicBlock *Preheader = L->getLoopPreheader();
    BasicBlock *Header    = L->getHeader();
    BasicBlock *Latch     = L->getLoopLatch();

    if (!Preheader || !Header || !Latch)
      return false;

    PHINode *IndVar = L->getCanonicalInductionVariable();
    if (!IndVar) {
      LLVM_DEBUG(dbgs() << "No canonical induction variable found\n");
      return false;
    }

    const SCEV *TripCountSCEV = SE.getBackedgeTakenCount(L);
    if (isa<SCEVCouldNotCompute>(TripCountSCEV)) {
      LLVM_DEBUG(dbgs() << "Could not compute trip count\n");
      return false;
    }

    Value *StartVal = IndVar->getIncomingValueForBlock(Preheader);
    Value *EndVal   = nullptr;

    BranchInst *LatchBr = dyn_cast<BranchInst>(Latch->getTerminator());
    if (!LatchBr || !LatchBr->isConditional())
      return false;

    ICmpInst *Cmp = dyn_cast<ICmpInst>(LatchBr->getCondition());
    if (!Cmp)
      return false;

    if (Cmp->getOperand(0) == IndVar)
      EndVal = Cmp->getOperand(1);
    else if (Cmp->getOperand(1) == IndVar)
      EndVal = Cmp->getOperand(0);
    else
      return false;

    // IMPORTANT: For true correctness, you'd want to map IV = StartVal + IV.
    // Here we keep the original approximation: IV ~ [0, NumIters).
    IRBuilder<> Builder(Preheader->getTerminator());
    OpenMPIRBuilder::LocationDescription Loc(Builder);

    Value *NumIters = Builder.CreateSub(EndVal, StartVal, "num_iters");

    auto CLIOrError = OMPBuilder.createCanonicalLoop(
        Loc,
        [&](IRBuilderBase::InsertPoint IP, Value *IV) -> Error {
          Builder.restoreIP(IP);

          ValueToValueMapTy VMap;
          VMap[IndVar] = IV;

          // Clone instructions from header (after PHIs)
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

          // Clone loop body blocks (excluding header and latch)
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

    if (!CLIOrError) {
      LLVM_DEBUG(dbgs() << "Failed to create canonical loop\n");
      return false;
    }

    CanonicalLoopInfo *CLI = *CLIOrError;

    IRBuilderBase::InsertPoint AllocaIP(
        &F.getEntryBlock(), F.getEntryBlock().getFirstInsertionPt());

    auto ResultOrError = OMPBuilder.applyWorkshareLoop(
        DebugLoc(), CLI, AllocaIP,
        /*NeedsBarrier=*/true,
        /*SchedKind=*/llvm::omp::OMP_SCHEDULE_Static,
        /*ChunkSize=*/nullptr,
        /*HasSimdModifier=*/false,
        /*HasMonotonicModifier=*/false,
        /*HasNonmonotonicModifier=*/false,
        /*HasOrderedClause=*/false,
        /*LoopType=*/llvm::omp::WorksharingLoopType::ForStaticLoop);

    if (!ResultOrError) {
      LLVM_DEBUG(dbgs() << "Failed to apply workshare loop\n");
      return false;
    }

    // Redirect control flow
    BasicBlock *Exit = L->getExitBlock();
    if (Exit) {
      Preheader->getTerminator()->eraseFromParent();
      Builder.SetInsertPoint(Preheader);
      Builder.CreateBr(CLI->getPreheader());

      CLI->getAfter()->getTerminator()->eraseFromParent();
      Builder.SetInsertPoint(CLI->getAfter());
      Builder.CreateBr(Exit);

      // Delete old loop blocks
      for (BasicBlock *BB : L->getBlocks())
        BB->dropAllReferences();
      for (BasicBlock *BB : L->getBlocks())
        BB->eraseFromParent();
    }

    return true;
  }

  bool canFuseLoops(Loop *L1, Loop *L2, Function &F, ScalarEvolution &SE,
                    LoopInfo &LI, DominatorTree &DT, TargetTransformInfo &TTI,
                    AAResults &AA, AssumptionCache &AC,
                    TargetLibraryInfo &TLI) {
    if (!L1 || !L2)
      return false;

    if (!isLoopParallelizable(L1, F, SE, LI, DT, TTI, AA, AC, TLI))
      return false;
    if (!isLoopParallelizable(L2, F, SE, LI, DT, TTI, AA, AC, TLI))
      return false;

    const SCEV *TC1 = SE.getBackedgeTakenCount(L1);
    const SCEV *TC2 = SE.getBackedgeTakenCount(L2);
    if (isa<SCEVCouldNotCompute>(TC1) || isa<SCEVCouldNotCompute>(TC2))
      return false;
    if (TC1 != TC2)
      return false;

    BasicBlock *L1Exit       = L1->getExitBlock();
    BasicBlock *L2Preheader  = L2->getLoopPreheader();
    if (!L1Exit || !L2Preheader)
      return false;

    BranchInst *BR = dyn_cast<BranchInst>(L1Exit->getTerminator());
    if (!BR || BR->isConditional())
      return false;
    if (BR->getSuccessor(0) != L2Preheader)
      return false;

    for (BasicBlock *BB1 : L1->getBlocks()) {
      for (Instruction &I1 : *BB1) {
        if (StoreInst *SI = dyn_cast<StoreInst>(&I1)) {
          Value *Ptr1 = SI->getPointerOperand();
          for (BasicBlock *BB2 : L2->getBlocks()) {
            for (Instruction &I2 : *BB2) {
              if (LoadInst *LI2 = dyn_cast<LoadInst>(&I2)) {
                Value *Ptr2 = LI2->getPointerOperand();
                if (AA.alias(Ptr1, Ptr2) != AliasResult::NoAlias) {
                  LLVM_DEBUG(
                      dbgs() << "Loop fusion blocked: L2 reads from L1\n");
                  return false;
                }
              }
            }
          }
        }
      }
    }

    LLVM_DEBUG(dbgs() << "Loops can be fused\n");
    return true;
  }


  struct SimpleLoopInfo {
    PHINode *IndVar      = nullptr;
    BasicBlock *Preheader = nullptr;
    BasicBlock *Header    = nullptr;
    BasicBlock *Latch     = nullptr;
    BasicBlock *Exit      = nullptr;
    Value *Start          = nullptr;
    Value *End            = nullptr;
    ICmpInst::Predicate Pred;
  };

  bool getSimpleLoopInfo(Loop *L, ScalarEvolution &SE, SimpleLoopInfo &Out) {
    Out = SimpleLoopInfo();

    BasicBlock *Preheader = L->getLoopPreheader();
    BasicBlock *Header    = L->getHeader();
    BasicBlock *Latch     = L->getLoopLatch();
    BasicBlock *Exit      = L->getExitBlock();

    if (!Preheader || !Header || !Latch || !Exit)
      return false;

    PHINode *IndVar = L->getCanonicalInductionVariable();
    if (!IndVar)
      return false;

    if (L->getNumBackEdges() != 1)
      return false;

    Value *Start = IndVar->getIncomingValueForBlock(Preheader);

    auto *LatchBr = dyn_cast<BranchInst>(Latch->getTerminator());
    if (!LatchBr || !LatchBr->isConditional())
      return false;

    auto *Cmp = dyn_cast<ICmpInst>(LatchBr->getCondition());
    if (!Cmp)
      return false;

    Value *Op0 = Cmp->getOperand(0);
    Value *Op1 = Cmp->getOperand(1);
    Value *End = nullptr;
    if (Op0 == IndVar)
      End = Op1;
    else if (Op1 == IndVar)
      End = Op0;
    else
      return false;

    if (!Cmp->isRelational())
      return false;

    Instruction *IndUpdate = nullptr;
    for (Instruction &I : *Latch) {
      if (auto *BO = dyn_cast<BinaryOperator>(&I)) {
        if (BO->getOpcode() == Instruction::Add &&
            (BO->getOperand(0) == IndVar || BO->getOperand(1) == IndVar)) {
          IndUpdate = BO;
          break;
        }
      }
    }
    if (!IndUpdate)
      return false;

    if (IndVar->getIncomingValueForBlock(Latch) != IndUpdate)
      return false;

    Out.IndVar    = IndVar;
    Out.Preheader = Preheader;
    Out.Header    = Header;
    Out.Latch     = Latch;
    Out.Exit      = Exit;
    Out.Start     = Start;
    Out.End       = End;
    Out.Pred      = Cmp->getPredicate();
    return true;
  }

  bool fuseLoops(Loop *L1, Loop *L2, Function &F, ScalarEvolution &SE,
                 LoopInfo &LI, DominatorTree &DT) {
    LLVM_DEBUG(dbgs() << "Trying to fuse loops\n");

    SimpleLoopInfo Info1, Info2;
    if (!getSimpleLoopInfo(L1, SE, Info1) ||
        !getSimpleLoopInfo(L2, SE, Info2)) {
      LLVM_DEBUG(dbgs()
                 << "  Not simple canonical loops; skip fusion\n");
      return false;
    }

    if (Info1.Start != Info2.Start ||
        Info1.End   != Info2.End   ||
        Info1.Pred  != Info2.Pred) {
      LLVM_DEBUG(dbgs() << "  Loop bounds differ; skip fusion\n");
      return false;
    }

    if (L1->getParentLoop() || L2->getParentLoop()) {
      LLVM_DEBUG(dbgs() << "  Nested loops not handled; skip fusion\n");
      return false;
    }

    BasicBlock *Preheader1 = Info1.Preheader;
    BasicBlock *Header1    = Info1.Header;
    BasicBlock *Latch1     = Info1.Latch;
    BasicBlock *Exit1      = Info1.Exit;

    BasicBlock *Preheader2 = Info2.Preheader;
    BasicBlock *Header2    = Info2.Header;
    BasicBlock *Latch2     = Info2.Latch;
    BasicBlock *Exit2      = Info2.Exit;

    if (Exit1 != Preheader2) {
      LLVM_DEBUG(dbgs()
                 << "  Not directly consecutive in CFG; skip fusion\n");
      return false;
    }

    LLVMContext &Ctx = F.getContext();
    IRBuilder<> Builder(Ctx);

    ValueToValueMapTy VMap;
    VMap[Info2.IndVar] = Info1.IndVar;

    Instruction *InsertPt = Header1->getTerminator();
    Builder.SetInsertPoint(InsertPt);

    auto cloneBlockIntoHeader = [&](BasicBlock *BB) {
      for (Instruction &I : *BB) {
        if (isa<PHINode>(&I) || I.isTerminator())
          continue;

        Instruction *NewI = I.clone();
        for (unsigned op = 0; op < NewI->getNumOperands(); ++op) {
          Value *OldOp = NewI->getOperand(op);
          auto It      = VMap.find(OldOp);
          if (It != VMap.end())
            NewI->setOperand(op, It->second);
        }
        Builder.Insert(NewI);
        VMap[&I] = NewI;
      }
    };

    cloneBlockIntoHeader(Header2);
    for (BasicBlock *BB : L2->getBlocks()) {
      if (BB == Header2 || BB == Latch2 || BB == Exit2)
        continue;
      cloneBlockIntoHeader(BB);
    }

    if (Exit2 != Exit1) {
      LLVM_DEBUG(dbgs() << "  Different exits; not handled\n");
      return false;
    }

    for (BasicBlock *BB : L2->getBlocks())
      BB->dropAllReferences();
    for (BasicBlock *BB : L2->getBlocks())
      BB->eraseFromParent();

    LI.erase(L2);

    LLVM_DEBUG(dbgs() << "  Successfully fused loops\n");
    return true;
  }
};

} // anonymous namespace

// Plugin registration
extern "C" LLVM_ATTRIBUTE_WEAK ::llvm::PassPluginLibraryInfo
llvmGetPassPluginInfo() {
  return {LLVM_PLUGIN_API_VERSION,
          "LoopParallelization",
          "0.2",
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
