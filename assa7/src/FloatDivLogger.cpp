#include "llvm/ADT/StringRef.h"
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
class FloatDivLoggerPass : public PassInfoMixin<FloatDivLoggerPass> {
public:
  PreservedAnalyses run(Module &M, ModuleAnalysisManager &) {
    LLVMContext &Ctx = M.getContext();


    FunctionCallee PrintfCallee = M.getOrInsertFunction(
        "printf",
        FunctionType::get(
            IntegerType::getInt32Ty(Ctx),
            {PointerType::get(IntegerType::getInt8Ty(Ctx), /*AS=*/0)},  // i8*
            /*isVarArg=*/true));

    IRBuilder<> Builder(Ctx);

    

    auto makeI8Ptr = [&](GlobalVariable *GV) -> Value * {
      Value *Zero = Builder.getInt32(0);
      Value *Idxs[] = {Zero, Zero};
      return Builder.CreateInBoundsGEP(GV->getValueType(), GV, Idxs);
    };


    GlobalVariable *FmtGV = nullptr;
    auto getFmtPtr = [&]() -> Value * {
      if (!FmtGV) {
        FmtGV = Builder.CreateGlobalString("Float div in %s, basic block %s\n",
                                           "fdiv_fmt");
      }
      return makeI8Ptr(FmtGV); // i8*
    };


    auto makeCStringPtr = [&](StringRef S, const Twine &Name) -> Value * {
      GlobalVariable *GV = Builder.CreateGlobalString(S, Name);
      return makeI8Ptr(GV);
    };

    bool Changed = false;

    for (Function &F : M) {
      if (F.isDeclaration())
        continue;

      for (BasicBlock &BB : F) {
        for (Instruction &I : BB) {
          if (I.getOpcode() == Instruction::FDiv) {
            Builder.SetInsertPoint(&I);

            Value *Fmt = getFmtPtr();

            // Function name
            Value *FuncName = makeCStringPtr(F.getName(), F.getName() + ".name");

            // Basic block name (or "(anon)")
            StringRef BBNameRef =
                BB.hasName() ? BB.getName() : StringRef("(anon)");
            Value *BBName = makeCStringPtr(BBNameRef,
                                           (BB.hasName() ? BB.getName()
                                                         : Twine("bb.anon")));


            Builder.CreateCall(PrintfCallee, {Fmt, FuncName, BBName});
            Changed = true;
          }
        }
      }
    }

    return Changed ? PreservedAnalyses::none() : PreservedAnalyses::all();
  }
};
} // namespace

extern "C" LLVM_ATTRIBUTE_WEAK ::llvm::PassPluginLibraryInfo
llvmGetPassPluginInfo() {
  return {LLVM_PLUGIN_API_VERSION, "FloatDivLogger", "0.1",
          [](PassBuilder &PB) {
            PB.registerPipelineParsingCallback(
                [](StringRef Name, ModulePassManager &MPM,
                   ArrayRef<PassBuilder::PipelineElement>) {
                  if (Name == "float-div-log") {
                    MPM.addPass(FloatDivLoggerPass());
                    return true;
                  }
                  return false;
                });

          }};
}

