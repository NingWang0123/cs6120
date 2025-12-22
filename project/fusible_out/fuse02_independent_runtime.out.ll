; ModuleID = '../fusible_out/fuse02_independent_runtime.ll'
source_filename = "../fusible_tests/fuse02_independent_runtime.c"
target datalayout = "e-m:o-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-n32:64-S128-Fn32"
target triple = "arm64-apple-macosx26.0.0"

; Function Attrs: nofree noinline norecurse nosync nounwind ssp memory(argmem: write) uwtable(sync)
define void @fuse02_independent_runtime(ptr noalias noundef writeonly captures(none) %0, ptr noalias noundef writeonly captures(none) %1, i32 noundef %2) local_unnamed_addr #0 {
  %4 = icmp sgt i32 %2, 0
  br i1 %4, label %5, label %7

5:                                                ; preds = %3
  %6 = zext nneg i32 %2 to i64
  br label %11

.loopexit1:                                       ; preds = %11
  br label %7

7:                                                ; preds = %.loopexit1, %3
  %8 = icmp sgt i32 %2, 0
  br i1 %8, label %9, label %18

9:                                                ; preds = %7
  %10 = zext nneg i32 %2 to i64
  br label %19

11:                                               ; preds = %11, %5
  %12 = phi i64 [ 0, %5 ], [ %16, %11 ]
  %13 = trunc nuw nsw i64 %12 to i32
  %14 = uitofp nneg i32 %13 to float
  %15 = getelementptr inbounds nuw float, ptr %0, i64 %12
  store float %14, ptr %15, align 4, !tbaa !6
  %16 = add nuw nsw i64 %12, 1
  %17 = icmp eq i64 %16, %6
  br i1 %17, label %.loopexit1, label %11, !llvm.loop !10

.loopexit:                                        ; preds = %19
  br label %18

18:                                               ; preds = %.loopexit, %7
  ret void

19:                                               ; preds = %19, %9
  %20 = phi i64 [ 0, %9 ], [ %24, %19 ]
  %21 = trunc nuw nsw i64 %20 to i32
  %22 = uitofp nneg i32 %21 to float
  %23 = getelementptr inbounds nuw float, ptr %1, i64 %20
  store float %22, ptr %23, align 4, !tbaa !6
  %24 = add nuw nsw i64 %20, 1
  %25 = icmp eq i64 %24, %10
  br i1 %25, label %.loopexit, label %19, !llvm.loop !15
}

attributes #0 = { nofree noinline norecurse nosync nounwind ssp memory(argmem: write) uwtable(sync) "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+ccpp,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a" }

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
