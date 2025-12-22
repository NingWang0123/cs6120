; ModuleID = '../fusible_tests/fuse20_two_out_two_in.c'
source_filename = "../fusible_tests/fuse20_two_out_two_in.c"
target datalayout = "e-m:o-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-n32:64-S128-Fn32"
target triple = "arm64-apple-macosx26.0.0"

; Function Attrs: nofree noinline norecurse nosync nounwind ssp memory(argmem: readwrite) uwtable(sync)
define void @fuse20_two_out_two_in(ptr noalias noundef writeonly captures(none) %0, ptr noalias noundef writeonly captures(none) %1, ptr noalias noundef readonly captures(none) %2, ptr noalias noundef readonly captures(none) %3) local_unnamed_addr #0 {
  br label %5

5:                                                ; preds = %4, %5
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
  br i1 %14, label %16, label %5, !llvm.loop !10

15:                                               ; preds = %16
  ret void

16:                                               ; preds = %5, %16
  %17 = phi i64 [ %25, %16 ], [ 0, %5 ]
  %18 = getelementptr inbounds nuw float, ptr %3, i64 %17
  %19 = load float, ptr %18, align 4, !tbaa !6
  %20 = trunc nuw nsw i64 %17 to i32
  %21 = uitofp nneg i32 %20 to float
  %22 = fneg float %21
  %23 = tail call float @llvm.fmuladd.f32(float %19, float 0x3FECCCCCC0000000, float %22)
  %24 = getelementptr inbounds nuw float, ptr %1, i64 %17
  store float %23, ptr %24, align 4, !tbaa !6
  %25 = add nuw nsw i64 %17, 1
  %26 = icmp eq i64 %25, 4096
  br i1 %26, label %15, label %16, !llvm.loop !15
}

; Function Attrs: mustprogress nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare float @llvm.fmuladd.f32(float, float, float) #1

attributes #0 = { nofree noinline norecurse nosync nounwind ssp memory(argmem: readwrite) uwtable(sync) "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+ccpp,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a" }
attributes #1 = { mustprogress nocallback nofree nosync nounwind speculatable willreturn memory(none) }

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
!15 = distinct !{!15, !11, !12, !13, !14}
