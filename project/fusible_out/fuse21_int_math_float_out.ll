; ModuleID = '../fusible_tests/fuse21_int_math_float_out.c'
source_filename = "../fusible_tests/fuse21_int_math_float_out.c"
target datalayout = "e-m:o-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-n32:64-S128-Fn32"
target triple = "arm64-apple-macosx26.0.0"

; Function Attrs: nofree noinline norecurse nosync nounwind ssp memory(argmem: write) uwtable(sync)
define void @fuse21_int_math_float_out(ptr noalias noundef writeonly captures(none) %0, ptr noalias noundef writeonly captures(none) %1) local_unnamed_addr #0 {
  br label %3

3:                                                ; preds = %2, %3
  %4 = phi i64 [ 0, %2 ], [ %11, %3 ]
  %5 = trunc i64 %4 to i32
  %6 = mul i32 %5, 621
  %7 = add i32 %6, 57
  %8 = and i32 %7, 1023
  %9 = uitofp nneg i32 %8 to float
  %10 = getelementptr inbounds nuw float, ptr %0, i64 %4
  store float %9, ptr %10, align 4, !tbaa !6
  %11 = add nuw nsw i64 %4, 1
  %12 = icmp eq i64 %11, 4096
  br i1 %12, label %14, label %3, !llvm.loop !10

13:                                               ; preds = %14
  ret void

14:                                               ; preds = %3, %14
  %15 = phi i64 [ %23, %14 ], [ 0, %3 ]
  %16 = trunc i64 %15 to i32
  %17 = mul i32 %16, 91661
  %18 = add i32 %17, 193375
  %19 = lshr i32 %18, 8
  %20 = and i32 %19, 1023
  %21 = uitofp nneg i32 %20 to float
  %22 = getelementptr inbounds nuw float, ptr %1, i64 %15
  store float %21, ptr %22, align 4, !tbaa !6
  %23 = add nuw nsw i64 %15, 1
  %24 = icmp eq i64 %23, 4096
  br i1 %24, label %13, label %14, !llvm.loop !15
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
