; ModuleID = '/Users/wangning/Desktop/cornell_repos/cs6120/project/fusible_results/20251221_154342/fuse17_flat_2d/fuse17_flat_2d.ll'
source_filename = "/Users/wangning/Desktop/cornell_repos/cs6120/project/fusible_tests/fuse17_flat_2d.c"
target datalayout = "e-m:o-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-n32:64-S128-Fn32"
target triple = "arm64-apple-macosx26.0.0"

; Function Attrs: nofree noinline norecurse nosync nounwind ssp memory(argmem: write) uwtable(sync)
define void @fuse17_flat_2d(ptr noalias noundef writeonly captures(none) %0, ptr noalias noundef writeonly captures(none) %1) local_unnamed_addr #0 {
  br label %3

3:                                                ; preds = %3, %2
  %4 = phi i64 [ 0, %2 ], [ %12, %3 ]
  %5 = trunc nuw nsw i64 %4 to i32
  %6 = and i32 %5, 127
  %7 = trunc nuw nsw i64 %4 to i32
  %8 = lshr i32 %7, 7
  %9 = add nuw nsw i32 %6, %8
  %10 = uitofp nneg i32 %9 to float
  %11 = getelementptr inbounds nuw float, ptr %0, i64 %4
  store float %10, ptr %11, align 4, !tbaa !6
  %12 = add nuw nsw i64 %4, 1
  %13 = icmp eq i64 %12, 16384
  %14 = trunc nuw nsw i64 %4 to i32
  %15 = and i32 %14, 127
  %16 = trunc nuw nsw i64 %4 to i32
  %17 = lshr i32 %16, 7
  %18 = sub nsw i32 %15, %17
  %19 = sitofp i32 %18 to float
  %20 = getelementptr inbounds nuw float, ptr %1, i64 %4
  store float %19, ptr %20, align 4, !tbaa !6
  %21 = add nuw nsw i64 %4, 1
  %22 = icmp eq i64 %21, 16384
  br i1 %13, label %.preheader, label %3, !llvm.loop !10

.preheader:                                       ; preds = %3
  br label %23

23:                                               ; preds = %.preheader
  ret void
}

attributes #0 = { nofree noinline norecurse nosync nounwind ssp memory(argmem: write) uwtable(sync) "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+ccpp,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a" }

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
