#include "llvm/ADT/DenseMap.h"
#include "llvm/ADT/StringRef.h"
#include "llvm/IR/Constants.h"
#include "llvm/IR/IRBuilder.h"
#include "llvm/IR/InstIterator.h"
#include "llvm/IR/Instructions.h"
#include "llvm/IR/Module.h"
#include "llvm/IR/PassManager.h"
#include "llvm/IR/Type.h"
#include "llvm/Passes/PassBuilder.h"
#include "llvm/Passes/PassPlugin.h"
#include "llvm/Support/raw_ostream.h"

using namespace llvm;

namespace {

static Constant *splatIfVector(Constant *C, Type *Ty) {
  if (auto *VTy = dyn_cast<VectorType>(Ty)) {
    return ConstantVector::getSplat(VTy->getElementCount(), C);
  }
  return C;
}

class FloatDivOptPass : public PassInfoMixin<FloatDivOptPass> {
public:
  PreservedAnalyses run(Module &M, ModuleAnalysisManager &) {
    bool Changed = false;

    for (Function &F : M) {
      if (F.isDeclaration())
        continue;

      for (BasicBlock &BB : F) {
        DenseMap<Value *, Value *> RcpCache; // per-BB cache

        for (auto It = BB.begin(), E = BB.end(); It != E; ) {
          Instruction &I = *It++;
          if (I.getOpcode() != Instruction::FDiv)
            continue;

          Type *Ty = I.getType();
          if (!Ty->isFPOrFPVectorTy())
            continue;

          Value *Num = I.getOperand(0);
          Value *Den = I.getOperand(1);

          IRBuilder<> B(&I);
          B.SetCurrentDebugLocation(I.getDebugLoc());

          FastMathFlags FMF = I.getFastMathFlags();
          B.setFastMathFlags(FMF);

          // ---- Case A: x / C  ->  x * (1/C)  (always safe if C!=0 and not NaN) ----
          if (auto *CFP = dyn_cast<ConstantFP>(Den)) {
            if (!CFP->isZero() && !CFP->isNaN()) {
              APFloat Rec = APFloat(CFP->getValueAPF().getSemantics(), 1);
              (void)Rec.divide(CFP->getValueAPF(), APFloat::rmNearestTiesToEven);

              Constant *RecScalar = ConstantFP::get(CFP->getContext(), Rec);
              Constant *RecConst  = splatIfVector(RecScalar, Ty);

              Value *Mul = B.CreateFMul(Num, RecConst, I.getName().empty() ? "div.mul" : I.getName() + ".mul");

              if (auto *MI = dyn_cast<Instruction>(Mul)) {
                MI->copyFastMathFlags(FMF);
                MI->setDebugLoc(I.getDebugLoc());
              }

              I.replaceAllUsesWith(Mul);
              I.eraseFromParent();
              Changed = true;
              continue;
            }
          }

          // ---- Case B: x / y  ->  x * (1/y), only if fast-math allows reciprocal ----
          if (!(FMF.allowReciprocal() || I.isFast())) {
            continue;
          }

          Value *Rcp = nullptr;
          if (auto ItR = RcpCache.find(Den); ItR != RcpCache.end()) {
            Rcp = ItR->second;
          } else {
            Type *EltTy = Ty->isVectorTy() ? cast<VectorType>(Ty)->getElementType() : Ty;
            Constant *OneScalar = ConstantFP::get(EltTy, 1.0);
            Constant *One       = splatIfVector(OneScalar, Ty);

            Value *R = B.CreateFDiv(One, Den, "rcp");
            if (auto *RI = dyn_cast<Instruction>(R)) {
              RI->copyFastMathFlags(FMF);
              RI->setDebugLoc(I.getDebugLoc());
            }
            Rcp = R;
            RcpCache[Den] = Rcp;
          }

          Value *Mul = B.CreateFMul(Num, Rcp, I.getName().empty() ? "div.mul" : I.getName() + ".mul");
          if (auto *MI = dyn_cast<Instruction>(Mul)) {
            MI->copyFastMathFlags(FMF);
            MI->setDebugLoc(I.getDebugLoc());
          }

          I.replaceAllUsesWith(Mul);
          I.eraseFromParent();
          Changed = true;
        }
      }
    }

    return Changed ? PreservedAnalyses::none() : PreservedAnalyses::all();
  }
};

} // namespace

extern "C" LLVM_ATTRIBUTE_WEAK ::llvm::PassPluginLibraryInfo
llvmGetPassPluginInfo() {
  return {LLVM_PLUGIN_API_VERSION, "FloatDivOpt", "0.1",
          [](PassBuilder &PB) {
            PB.registerPipelineParsingCallback(
                [](StringRef Name, ModulePassManager &MPM,
                   ArrayRef<PassBuilder::PipelineElement>) {
                  if (Name == "float-div-opt") {
                    MPM.addPass(FloatDivOptPass());
                    return true;
                  }
                  return false;
                });
          }};
}
