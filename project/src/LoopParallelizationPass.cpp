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

  // Fuse two consecutive loops
  bool fuseLoops(Loop *L1, Loop *L2, Function &F, ScalarEvolution &SE,
                 LoopInfo &LI, DominatorTree &DT) {
    // For simplicity, mark that fusion is possible but don't actually transform
    // Full loop fusion is complex and would require:
    // 1. Merging loop headers
    // 2. Combining loop bodies
    // 3. Updating PHI nodes
    // 4. Fixing dominance tree

    // Instead, we'll just log it and let parallelization handle each loop
    LLVM_DEBUG(dbgs() << "Loop fusion identified (not transformed in this version)\n");
    return false; // Don't claim we changed anything
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
