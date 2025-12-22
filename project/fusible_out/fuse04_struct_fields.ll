; ModuleID = '../fusible_tests/fuse04_struct_fields.c'
source_filename = "../fusible_tests/fuse04_struct_fields.c"
target datalayout = "e-m:o-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-n32:64-S128-Fn32"
target triple = "arm64-apple-macosx26.0.0"

%struct.P = type { float, float }

; Function Attrs: nofree noinline norecurse nosync nounwind ssp memory(argmem: write) uwtable(sync)
define void @fuse04_struct_fields(ptr noalias noundef writeonly captures(none) %0) local_unnamed_addr #0 {
  br label %2

2:                                                ; preds = %1, %2
  %3 = phi i64 [ 0, %1 ], [ %7, %2 ]
  %4 = trunc nuw nsw i64 %3 to i32
  %5 = uitofp nneg i32 %4 to float
  %6 = getelementptr inbounds nuw %struct.P, ptr %0, i64 %3
  store float %5, ptr %6, align 4, !tbaa !6
  %7 = add nuw nsw i64 %3, 1
  %8 = icmp eq i64 %7, 1024
  br i1 %8, label %10, label %2, !llvm.loop !11

9:                                                ; preds = %10
  ret void

10:                                               ; preds = %2, %10
  %11 = phi i64 [ %16, %10 ], [ 0, %2 ]
  %12 = trunc nuw nsw i64 %11 to i32
  %13 = uitofp nneg i32 %12 to float
  %14 = fmul float %13, 3.000000e+00
  %15 = getelementptr inbounds nuw %struct.P, ptr %0, i64 %11, i32 1
  store float %14, ptr %15, align 4, !tbaa !16
  %16 = add nuw nsw i64 %11, 1
  %17 = icmp eq i64 %16, 1024
  br i1 %17, label %9, label %10, !llvm.loop !17
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
!6 = !{!7, !8, i64 0}
!7 = !{!"", !8, i64 0, !8, i64 4}
!8 = !{!"float", !9, i64 0}
!9 = !{!"omnipotent char", !10, i64 0}
!10 = !{!"Simple C/C++ TBAA"}
!11 = distinct !{!11, !12, !13, !14, !15}
!12 = !{!"llvm.loop.mustprogress"}
!13 = !{!"llvm.loop.unroll.disable"}
!14 = !{!"llvm.loop.vectorize.width", i32 1}
!15 = !{!"llvm.loop.interleave.count", i32 1}
!16 = !{!7, !8, i64 4}
!17 = distinct !{!17, !12, !13, !14, !15}
