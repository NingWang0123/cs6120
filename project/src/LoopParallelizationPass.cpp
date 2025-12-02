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

    // Collect parallelizable loops (only top-level loops for now)
    for (Loop *L : LI) {
      if (isLoopParallelizable(L, F, SE, LI, DT, TTI, AA, AC, TLI)) {
        LoopsToParallelize.push_back(L);
        errs() << "Found parallelizable loop in function: " << F.getName() << "\n";
      }
    }

    // Parallelize the loops
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
