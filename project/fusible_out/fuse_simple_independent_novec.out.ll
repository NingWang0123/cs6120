; ModuleID = '../fusible_out/fuse_simple_independent_novec.ll'
source_filename = "fusible_tests/fuse_simple_independent_novec.c"
target datalayout = "e-m:o-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-n32:64-S128-Fn32"
target triple = "arm64-apple-macosx26.0.0"

; Function Attrs: nofree norecurse nosync nounwind ssp memory(argmem: write) uwtable(sync)
define void @fuse_simple_independent_novec(ptr noalias noundef writeonly captures(none) %0, ptr noalias noundef writeonly captures(none) %1, i32 noundef %2) local_unnamed_addr #0 {
  %4 = icmp sgt i32 %2, 0
  br i1 %4, label %5, label %17

5:                                                ; preds = %3
  %6 = zext nneg i32 %2 to i64
  br label %9

7:                                                ; preds = %9
  %8 = zext nneg i32 %2 to i64
  br label %18

9:                                                ; preds = %9, %5
  %10 = phi i64 [ 0, %5 ], [ %15, %9 ]
  %11 = trunc nuw nsw i64 %10 to i32
  %12 = uitofp nneg i32 %11 to float
  %13 = fmul float %12, 2.000000e+00
  %14 = getelementptr inbounds nuw float, ptr %0, i64 %10
  store float %13, ptr %14, align 4, !tbaa !6
  %15 = add nuw nsw i64 %10, 1
  %16 = icmp eq i64 %15, %6
  br i1 %16, label %7, label %9, !llvm.loop !10

.loopexit:                                        ; preds = %18
  br label %17

17:                                               ; preds = %.loopexit, %3
  ret void

18:                                               ; preds = %18, %7
  %19 = phi i64 [ 0, %7 ], [ %24, %18 ]
  %20 = trunc nuw nsw i64 %19 to i32
  %21 = uitofp nneg i32 %20 to float
  %22 = fadd float %21, 1.000000e+00
  %23 = getelementptr inbounds nuw float, ptr %1, i64 %19
  store float %22, ptr %23, align 4, !tbaa !6
  %24 = add nuw nsw i64 %19, 1
  %25 = icmp eq i64 %24, %8
  br i1 %25, label %.loopexit, label %18, !llvm.loop !15
}

attributes #0 = { nofree norecurse nosync nounwind ssp memory(argmem: write) uwtable(sync) "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+ccpp,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a" }

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
