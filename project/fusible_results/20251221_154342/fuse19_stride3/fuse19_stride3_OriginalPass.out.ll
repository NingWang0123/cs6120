; ModuleID = '/Users/wangning/Desktop/cornell_repos/cs6120/project/fusible_results/20251221_154342/fuse19_stride3/fuse19_stride3.ll'
source_filename = "/Users/wangning/Desktop/cornell_repos/cs6120/project/fusible_tests/fuse19_stride3.c"
target datalayout = "e-m:o-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-n32:64-S128-Fn32"
target triple = "arm64-apple-macosx26.0.0"

; Function Attrs: nofree noinline norecurse nosync nounwind ssp memory(argmem: write) uwtable(sync)
define void @fuse19_stride3(ptr noalias noundef writeonly captures(none) %0, ptr noalias noundef writeonly captures(none) %1) local_unnamed_addr #0 {
  br label %3

3:                                                ; preds = %3, %2
  %4 = phi i64 [ 0, %2 ], [ %10, %3 ]
  %5 = trunc nuw nsw i64 %4 to i32
  %6 = uitofp nneg i32 %5 to float
  %7 = fmul float %6, 2.000000e+00
  %8 = mul nuw nsw i64 %4, 12
  %9 = getelementptr inbounds nuw i8, ptr %0, i64 %8
  store float %7, ptr %9, align 4, !tbaa !6
  %10 = add nuw nsw i64 %4, 1
  %11 = icmp eq i64 %10, 1048576
  br i1 %11, label %.preheader, label %3, !llvm.loop !10

.preheader:                                       ; preds = %3
  br label %13

12:                                               ; preds = %13
  ret void

13:                                               ; preds = %.preheader, %13
  %14 = phi i64 [ %20, %13 ], [ 0, %.preheader ]
  %15 = trunc nuw nsw i64 %14 to i32
  %16 = uitofp nneg i32 %15 to float
  %17 = fadd float %16, 1.000000e+00
  %18 = mul nuw nsw i64 %14, 12
  %19 = getelementptr inbounds nuw i8, ptr %1, i64 %18
  store float %17, ptr %19, align 4, !tbaa !6
  %20 = add nuw nsw i64 %14, 1
  %21 = icmp eq i64 %20, 1048576
  br i1 %21, label %12, label %13, !llvm.loop !15
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
!15 = distinct !{!15, !11, !12, !13, !14}
