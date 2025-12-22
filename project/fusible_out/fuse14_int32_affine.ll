; ModuleID = '../fusible_tests/fuse14_int32_affine.c'
source_filename = "../fusible_tests/fuse14_int32_affine.c"
target datalayout = "e-m:o-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-n32:64-S128-Fn32"
target triple = "arm64-apple-macosx26.0.0"

; Function Attrs: nofree noinline norecurse nosync nounwind ssp memory(argmem: write) uwtable(sync)
define void @fuse14_int32_affine(ptr noalias noundef writeonly captures(none) %0, ptr noalias noundef writeonly captures(none) %1) local_unnamed_addr #0 {
  br label %3

3:                                                ; preds = %2, %3
  %4 = phi i64 [ 0, %2 ], [ %9, %3 ]
  %5 = getelementptr inbounds nuw i32, ptr %0, i64 %4
  %6 = trunc i64 %4 to i32
  %7 = mul i32 %6, 3
  %8 = add i32 %7, 7
  store i32 %8, ptr %5, align 4, !tbaa !6
  %9 = add nuw nsw i64 %4, 1
  %10 = icmp eq i64 %9, 4096
  br i1 %10, label %12, label %3, !llvm.loop !10

11:                                               ; preds = %12
  ret void

12:                                               ; preds = %3, %12
  %13 = phi i64 [ %18, %12 ], [ 0, %3 ]
  %14 = getelementptr inbounds nuw i32, ptr %1, i64 %13
  %15 = trunc i64 %13 to i32
  %16 = mul i32 %15, 5
  %17 = add i32 %16, -11
  store i32 %17, ptr %14, align 4, !tbaa !6
  %18 = add nuw nsw i64 %13, 1
  %19 = icmp eq i64 %18, 4096
  br i1 %19, label %11, label %12, !llvm.loop !15
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
!7 = !{!"int", !8, i64 0}
!8 = !{!"omnipotent char", !9, i64 0}
!9 = !{!"Simple C/C++ TBAA"}
!10 = distinct !{!10, !11, !12, !13, !14}
!11 = !{!"llvm.loop.mustprogress"}
!12 = !{!"llvm.loop.unroll.disable"}
!13 = !{!"llvm.loop.vectorize.width", i32 1}
!14 = !{!"llvm.loop.interleave.count", i32 1}
!15 = distinct !{!15, !11, !12, !13, !14}
