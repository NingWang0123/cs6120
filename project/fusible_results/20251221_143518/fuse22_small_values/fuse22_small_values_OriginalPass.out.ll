; ModuleID = '/Users/wangning/Desktop/cornell_repos/cs6120/project/fusible_results/20251221_143518/fuse22_small_values/fuse22_small_values.ll'
source_filename = "/Users/wangning/Desktop/cornell_repos/cs6120/project/fusible_tests/fuse22_small_values.c"
target datalayout = "e-m:o-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-n32:64-S128-Fn32"
target triple = "arm64-apple-macosx26.0.0"

; Function Attrs: nofree noinline norecurse nosync nounwind ssp memory(argmem: write) uwtable(sync)
define void @fuse22_small_values(ptr noalias noundef writeonly captures(none) %0, ptr noalias noundef writeonly captures(none) %1) local_unnamed_addr #0 {
  br label %3

3:                                                ; preds = %3, %2
  %4 = phi i64 [ 0, %2 ], [ %13, %3 ]
  %5 = and i64 %4, 1
  %6 = icmp eq i64 %5, 0
  %7 = select i1 %6, i32 7, i32 3
  %8 = trunc nuw nsw i64 %4 to i32
  %9 = lshr i32 %8, 5
  %10 = add nuw nsw i32 %9, %7
  %11 = uitofp nneg i32 %10 to float
  %12 = getelementptr inbounds nuw float, ptr %0, i64 %4
  store float %11, ptr %12, align 4, !tbaa !6
  %13 = add nuw nsw i64 %4, 1
  %14 = icmp eq i64 %13, 1048576
  br i1 %14, label %.preheader, label %3, !llvm.loop !10

.preheader:                                       ; preds = %3
  br label %16

15:                                               ; preds = %16
  ret void

16:                                               ; preds = %.preheader, %16
  %17 = phi i64 [ %26, %16 ], [ 0, %.preheader ]
  %18 = trunc nuw nsw i64 %17 to i32
  %19 = and i32 %18, 3
  %20 = uitofp nneg i32 %19 to float
  %21 = trunc nuw nsw i64 %17 to i32
  %22 = lshr i32 %21, 6
  %23 = uitofp nneg i32 %22 to float
  %24 = tail call float @llvm.fmuladd.f32(float %20, float 2.500000e-01, float %23)
  %25 = getelementptr inbounds nuw float, ptr %1, i64 %17
  store float %24, ptr %25, align 4, !tbaa !6
  %26 = add nuw nsw i64 %17, 1
  %27 = icmp eq i64 %26, 1048576
  br i1 %27, label %15, label %16, !llvm.loop !15
}

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare float @llvm.fmuladd.f32(float, float, float) #1

attributes #0 = { nofree noinline norecurse nosync nounwind ssp memory(argmem: write) uwtable(sync) "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+ccpp,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a" }
attributes #1 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }

!llvm.module.flags = !{!0, !1, !2, !3, !4}
!llvm.ident = !{!5}

!0 = !{i32 2, !"SDK Version", [2 x i32] [i32 26, i32 2]}
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
