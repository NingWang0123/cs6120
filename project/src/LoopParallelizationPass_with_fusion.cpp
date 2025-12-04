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
    if (!EnableParallelization) {
      return PreservedAnalyses::all();
    }

    auto &LI = FAM.getResult<LoopAnalysis>(F);
    auto &SE = FAM.getResult<ScalarEvolutionAnalysis>(F);
    auto &DT = FAM.getResult<DominatorTreeAnalysis>(F);
    auto &TTI = FAM.getResult<TargetIRAnalysis>(F);
    auto &AA = FAM.getResult<AAManager>(F);
    auto &AC = FAM.getResult<AssumptionAnalysis>(F);
    auto &TLI = FAM.getResult<TargetLibraryAnalysis>(F);

    bool Changed = false;
    std::vector<Loop *> LoopsToParallelize;
    std::vector<std::pair<Loop*, Loop*>> LoopsToFuse;

    // Step 1: Identify fusible loop pairs (consecutive independent loops)
    if (EnableLoopFusion) {
      std::vector<Loop *> TopLevelLoops;
      for (Loop *L : LI) {
        TopLevelLoops.push_back(L);
      }

      // Check consecutive loops for fusion opportunities
      for (size_t i = 0; i + 1 < TopLevelLoops.size(); i++) {
        Loop *L1 = TopLevelLoops[i];
        Loop *L2 = TopLevelLoops[i + 1];

        if (canFuseLoops(L1, L2, F, SE, LI, DT, TTI, AA, AC, TLI)) {
          LoopsToFuse.push_back({L1, L2});
          errs() << "Found fusible loops in function: " << F.getName() << "\n";
        }
      }
    }

    // Step 2: Perform loop fusion
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
        errs() << "Found parallelizable loop in function: " << F.getName() << "\n";
      }
    }

    // Step 4: Parallelize the loops
    for (Loop *L : LoopsToParallelize) {
      if (parallelizeLoop(L, F, SE, LI, DT)) {
        Changed = true;
        errs() << "Successfully parallelized loop in function: " << F.getName() << "\n";
      }
    }

    return Changed ? PreservedAnalyses::none() : PreservedAnalyses::all();
  }

private:
  bool isLoopParallelizable(Loop *L, Function &F, ScalarEvolution &SE,
                           LoopInfo &LI, DominatorTree &DT,
                           TargetTransformInfo &TTI, AAResults &AA,
                           AssumptionCache &AC, TargetLibraryInfo &TLI) {
    // Check if loop has a preheader and latch
    if (!L->getLoopPreheader() || !L->getLoopLatch()) {
      LLVM_DEBUG(dbgs() << "Loop doesn't have preheader or latch\n");
      return false;
    }

    // Check for simple loop structure
    if (L->getBlocks().size() > 10) {
      LLVM_DEBUG(dbgs() << "Loop too complex (too many blocks)\n");
      return false;
    }

    // Use LoopAccessAnalysis to check for memory dependencies
    // Create LoopAccessInfo with correct API
    LoopAccessInfo LAI(L, &SE, &TTI, &TLI, &AA, &DT, &LI);

    // Check if loop can be vectorized (which means no unsafe dependencies)
    if (!LAI.canVectorizeMemory()) {
      LLVM_DEBUG(dbgs() << "Loop has unsafe memory dependencies\n");
      return false;
    }

    // Check the dependency checker
    const MemoryDepChecker &DepChecker = LAI.getDepChecker();
    const SmallVectorImpl<MemoryDepChecker::Dependence> *Deps = DepChecker.getDependences();

    if (Deps && !Deps->empty()) {
      LLVM_DEBUG(dbgs() << "Loop has memory dependencies (" << Deps->size() << ")\n");
      return false;
    }

    LLVM_DEBUG(dbgs() << "Loop is safe to parallelize (no unsafe memory dependences)\n");
    return true;
  }

  bool parallelizeLoop(Loop *L, Function &F, ScalarEvolution &SE,
                      LoopInfo &LI, DominatorTree &DT) {
    Module *M = F.getParent();
    LLVMContext &Ctx = M->getContext();

    // Get loop components
    BasicBlock *Preheader = L->getLoopPreheader();
    BasicBlock *Header = L->getHeader();
    BasicBlock *Latch = L->getLoopLatch();

    if (!Preheader || !Header || !Latch) {
      return false;
    }

    // Find the induction variable
    PHINode *IndVar = L->getCanonicalInductionVariable();
    if (!IndVar) {
      LLVM_DEBUG(dbgs() << "No canonical induction variable found\n");
      return false;
    }

    // Get trip count
    const SCEV *TripCountSCEV = SE.getBackedgeTakenCount(L);
    if (isa<SCEVCouldNotCompute>(TripCountSCEV)) {
      LLVM_DEBUG(dbgs() << "Could not compute trip count\n");
      return false;
    }

    // Get the start and end values
    Value *StartVal = IndVar->getIncomingValueForBlock(Preheader);
    Value *EndVal = nullptr;

    // Extract end value from loop exit condition
    BranchInst *LatchBr = dyn_cast<BranchInst>(Latch->getTerminator());
    if (!LatchBr || !LatchBr->isConditional()) {
      return false;
    }

    ICmpInst *Cmp = dyn_cast<ICmpInst>(LatchBr->getCondition());
    if (!Cmp) {
      return false;
    }

    // Determine the end value from the comparison
    if (Cmp->getOperand(0) == IndVar) {
      EndVal = Cmp->getOperand(1);
    } else if (Cmp->getOperand(1) == IndVar) {
      EndVal = Cmp->getOperand(0);
    } else {
      return false;
    }

    // Create OpenMP IR Builder
    OpenMPIRBuilder OMPBuilder(*M);
    OMPBuilder.initialize();

    // Create the parallel loop using OpenMPIRBuilder
    IRBuilder<> Builder(Preheader->getTerminator());
    OpenMPIRBuilder::LocationDescription Loc(Builder);

    // Calculate number of iterations
    Value *NumIters = Builder.CreateSub(EndVal, StartVal, "num_iters");

    // Create a canonical loop using the simpler API
    auto CLIOrError = OMPBuilder.createCanonicalLoop(
        Loc,
        [&](IRBuilderBase::InsertPoint IP, Value *IV) -> llvm::Error {
          Builder.restoreIP(IP);

          // Clone loop body instructions for this iteration
          ValueToValueMapTy VMap;
          VMap[IndVar] = IV;

          // Clone instructions from header (after PHI nodes)
          for (Instruction &I : *Header) {
            if (isa<PHINode>(&I) || I.isTerminator()) continue;

            Instruction *ClonedI = I.clone();
            for (unsigned i = 0; i < ClonedI->getNumOperands(); ++i) {
              Value *Op = ClonedI->getOperand(i);
              if (VMap.count(Op)) {
                ClonedI->setOperand(i, VMap[Op]);
              }
            }
            Builder.Insert(ClonedI);
            VMap[&I] = ClonedI;
          }

          // Clone loop body blocks (excluding header and latch)
          for (BasicBlock *BB : L->getBlocks()) {
            if (BB == Header || BB == Latch) continue;

            for (Instruction &I : *BB) {
              if (I.isTerminator()) continue;

              Instruction *ClonedI = I.clone();
              for (unsigned i = 0; i < ClonedI->getNumOperands(); ++i) {
                Value *Op = ClonedI->getOperand(i);
                if (VMap.count(Op)) {
                  ClonedI->setOperand(i, VMap[Op]);
                }
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

    // Apply OpenMP worksharing schedule
    IRBuilderBase::InsertPoint AllocaIP(
        &F.getEntryBlock(), F.getEntryBlock().getFirstInsertionPt());

    auto ResultOrError = OMPBuilder.applyWorkshareLoop(
        DebugLoc(), CLI, AllocaIP,
        /* NeedsBarrier */ true,
        /* SchedKind */ llvm::omp::OMP_SCHEDULE_Static,
        /* ChunkSize */ nullptr,
        /* HasSimdModifier */ false,
        /* HasMonotonicModifier */ false,
        /* HasNonmonotonicModifier */ false,
        /* HasOrderedClause */ false,
        /* LoopType */ llvm::omp::WorksharingLoopType::ForStaticLoop);

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
      for (BasicBlock *BB : L->getBlocks()) {
        BB->dropAllReferences();
      }
      for (BasicBlock *BB : L->getBlocks()) {
        BB->eraseFromParent();
      }
    }

    return true;
  }

  // Check if two loops can be fused
  bool canFuseLoops(Loop *L1, Loop *L2, Function &F, ScalarEvolution &SE,
                    LoopInfo &LI, DominatorTree &DT, TargetTransformInfo &TTI,
                    AAResults &AA, AssumptionCache &AC, TargetLibraryInfo &TLI) {
    // Both loops must be valid
    if (!L1 || !L2) return false;

    // Both must be parallelizable independently
    if (!isLoopParallelizable(L1, F, SE, LI, DT, TTI, AA, AC, TLI)) return false;
    if (!isLoopParallelizable(L2, F, SE, LI, DT, TTI, AA, AC, TLI)) return false;

    // Must have same trip count
    const SCEV *TC1 = SE.getBackedgeTakenCount(L1);
    const SCEV *TC2 = SE.getBackedgeTakenCount(L2);
    if (isa<SCEVCouldNotCompute>(TC1) || isa<SCEVCouldNotCompute>(TC2)) return false;
    if (TC1 != TC2) return false;

    // Check that L2 comes immediately after L1 in control flow
    BasicBlock *L1Exit = L1->getExitBlock();
    BasicBlock *L2Preheader = L2->getLoopPreheader();
    if (!L1Exit || !L2Preheader) return false;

    // Simple check: L1 exit should branch to L2 preheader
    BranchInst *BR = dyn_cast<BranchInst>(L1Exit->getTerminator());
    if (!BR || BR->isConditional()) return false;
    if (BR->getSuccessor(0) != L2Preheader) return false;

    // Check for dependencies between L1 and L2
    // For simplicity, we check if L2 reads what L1 writes
    for (BasicBlock *BB1 : L1->getBlocks()) {
      for (Instruction &I1 : *BB1) {
        if (StoreInst *SI = dyn_cast<StoreInst>(&I1)) {
          Value *Ptr1 = SI->getPointerOperand();

          // Check if any load in L2 aliases with this store
          for (BasicBlock *BB2 : L2->getBlocks()) {
            for (Instruction &I2 : *BB2) {
              if (LoadInst *LI = dyn_cast<LoadInst>(&I2)) {
                Value *Ptr2 = LI->getPointerOperand();
                if (AA.alias(Ptr1, Ptr2) != AliasResult::NoAlias) {
                  LLVM_DEBUG(dbgs() << "Loop fusion blocked: L2 reads from L1\n");
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
    PHINode *IndVar = nullptr;
    BasicBlock *Preheader = nullptr;
    BasicBlock *Header = nullptr;
    BasicBlock *Latch = nullptr;
    BasicBlock *Exit = nullptr;
    Value *Start = nullptr;
    Value *End = nullptr;
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
      LLVM_DEBUG(dbgs() << "  Not simple canonical loops; skip fusion\n");
      return false;
    }

    // Require same start and end and predicate and step (we checked step=1).
    if (Info1.Start != Info2.Start ||
        Info1.End   != Info2.End   ||
        Info1.Pred  != Info2.Pred) {
      LLVM_DEBUG(dbgs() << "  Loop bounds differ; skip fusion\n");
      return false;
    }

    // For now, only fuse if both loops are top-level and non-nested.
    if (L1->getParentLoop() || L2->getParentLoop()) {
      LLVM_DEBUG(dbgs() << "  Nested loops not handled; skip fusion\n");
      return false;
    }

    // We know control flow: L1.Exit is L2.Preheader (already checked in canFuseLoops)
    BasicBlock *Preheader1 = Info1.Preheader;
    BasicBlock *Header1    = Info1.Header;
    BasicBlock *Latch1     = Info1.Latch;
    BasicBlock *Exit1      = Info1.Exit;

    BasicBlock *Preheader2 = Info2.Preheader;
    BasicBlock *Header2    = Info2.Header;
    BasicBlock *Latch2     = Info2.Latch;
    BasicBlock *Exit2      = Info2.Exit;

    if (Exit1 != Preheader2) {
      LLVM_DEBUG(dbgs() << "  Not directly consecutive in CFG; skip fusion\n");
      return false;
    }

    // We will:
    //  - Keep L1’s header/latch/IV as the fused loop.
    //  - Move (clone) the body of L2 inside L1’s loop body.
    //  - Remove L2’s loop blocks.

    LLVMContext &Ctx = F.getContext();
    IRBuilder<> Builder(Ctx);

    // Build a map from old values in L2 to new values in L1. For the IV, both share
    // the same logical iteration index, which is Info1.IndVar.
    ValueToValueMapTy VMap;
    VMap[Info2.IndVar] = Info1.IndVar;

    // Clone all non-PHI, non-terminator instructions from L2’s header and body
    // into L1’s header, *after* existing instructions.
    Instruction *InsertPt = Header1->getTerminator();
    Builder.SetInsertPoint(InsertPt);

    auto cloneBlockIntoHeader = [&](BasicBlock *BB) {
      for (Instruction &I : *BB) {
        if (isa<PHINode>(&I) || I.isTerminator())
          continue;

        Instruction *NewI = I.clone();
        // Remap operands
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

    // Very conservative body selection: only fuse the header of L2 and any blocks
    // that are *inside* L2 and not its latch/exit. (We already rejected complex loops).
    cloneBlockIntoHeader(Header2);
    for (BasicBlock *BB : L2->getBlocks()) {
      if (BB == Header2 || BB == Latch2 || BB == Exit2)
        continue;
      cloneBlockIntoHeader(BB);
    }

    // Redirect L1’s exit to go directly to L2’s exit (which should be the same or
    // fall-through); in practice, if L2’s exit == L1’s exit, there’s nothing to change.
    if (Exit2 != Exit1) {
      // This is a more complex CFG case; bail for now.
      LLVM_DEBUG(dbgs() << "  Different exits; not handled\n");
      return false;
    }

    // Now remove L2’s blocks from the function. First, drop references, then erase.
    for (BasicBlock *BB : L2->getBlocks())
      BB->dropAllReferences();
    for (BasicBlock *BB : L2->getBlocks())
      BB->eraseFromParent();

    // Update LoopInfo: erase L2, keep L1 as-is.
    LI.erase(L2);

    // DominatorTree is now stale; this pass returns PreservedAnalyses::none(),
    // so we don't need to fix it inside the pass, but we must not use DT after this.
    LLVM_DEBUG(dbgs() << "  Successfully fused loops\n");
    return true;
  }
};

} // anonymous namespace

// Plugin registration
extern "C" LLVM_ATTRIBUTE_WEAK ::llvm::PassPluginLibraryInfo
llvmGetPassPluginInfo() {
  return {
      LLVM_PLUGIN_API_VERSION, "LoopParallelization", "0.1",
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
