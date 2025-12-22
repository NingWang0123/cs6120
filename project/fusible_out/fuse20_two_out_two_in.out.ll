; ModuleID = '../fusible_out/fuse20_two_out_two_in.ll'
source_filename = "../fusible_tests/fuse20_two_out_two_in.c"
target datalayout = "e-m:o-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-n32:64-S128-Fn32"
target triple = "arm64-apple-macosx26.0.0"

; Function Attrs: nofree noinline norecurse nosync nounwind ssp memory(argmem: readwrite) uwtable(sync)
define void @fuse20_two_out_two_in(ptr noalias noundef writeonly captures(none) %0, ptr noalias noundef writeonly captures(none) %1, ptr noalias noundef readonly captures(none) %2, ptr noalias noundef readonly captures(none) %3) local_unnamed_addr #0 {
  br label %5

5:                                                ; preds = %5, %4
  %6 = phi i64 [ 0, %4 ], [ %13, %5 ]
  %7 = getelementptr inbounds nuw float, ptr %2, i64 %6
  %8 = load float, ptr %7, align 4, !tbaa !6
  %9 = trunc nuw nsw i64 %6 to i32
  %10 = uitofp nneg i32 %9 to float
  %11 = tail call float @llvm.fmuladd.f32(float %8, float 0x3FF19999A0000000, float %10)
  %12 = getelementptr inbounds nuw float, ptr %0, i64 %6
  store float %11, ptr %12, align 4, !tbaa !6
  %13 = add nuw nsw i64 %6, 1
  %14 = icmp eq i64 %13, 4096
  %15 = getelementptr inbounds nuw float, ptr %3, i64 %6
  %16 = load float, ptr %15, align 4, !tbaa !6
  %17 = trunc nuw nsw i64 %6 to i32
  %18 = uitofp nneg i32 %17 to float
  %19 = fneg float %18
  %20 = tail call float @llvm.fmuladd.f32(float %16, float 0x3FECCCCCC0000000, float %19)
  %21 = getelementptr inbounds nuw float, ptr %1, i64 %6
  store float %20, ptr %21, align 4, !tbaa !6
  %22 = add nuw nsw i64 %6, 1
  %23 = icmp eq i64 %22, 4096
  br i1 %14, label %.preheader, label %5, !llvm.loop !10

.preheader:                                       ; preds = %5
  br label %24

24:                                               ; preds = %.preheader
  ret void
}

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare float @llvm.fmuladd.f32(float, float, float) #1

attributes #0 = { nofree noinline norecurse nosync nounwind ssp memory(argmem: readwrite) uwtable(sync) "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+ccpp,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a" }
attributes #1 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }

!llvm.module.flags = !{!0, !1, !2, !3, !4}
!llvm.ident = !{!5}

!0 = !{i32 2, !"SDK Version", [1 x i32] [i32 26]}
!1 = !{i32 1, !"wchar_size", i32 4}
!2 = !{i32 8, !"PIC Level", i32 2}
!3 = !{i32 7, !"uwtable", i32 1}
!4 = !{i32 7, !"frame-pointer", i32 1}
!5 = !{!"Homebrew clang version 21.1.6"}
!6 = !{!7, !7, i64 0}
!7 = !{!"float", !8, i64 0}
!8 = !{!"omnipotent char", !9, i64 0}
!9 = !{!"Simple C/C++ TBAA"}
!10 = distinct !{!10, !11, !12, !13, !14}
!11 = !{!"llvm.loop.mustprogress"}
!12 = !{!"llvm.loop.unroll.disable"}
!13 = !{!"llvm.loop.vectorize.width", i32 1}
!14 = !{!"llvm.loop.interleave.count", i32 1}
