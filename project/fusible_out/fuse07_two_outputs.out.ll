; ModuleID = '../fusible_out/fuse07_two_outputs.ll'
source_filename = "../fusible_tests/fuse07_two_outputs.c"
target datalayout = "e-m:o-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-n32:64-S128-Fn32"
target triple = "arm64-apple-macosx26.0.0"

; Function Attrs: nofree noinline norecurse nosync nounwind ssp memory(argmem: write) uwtable(sync)
define void @fuse07_two_outputs(ptr noalias noundef writeonly captures(none) %0, ptr noalias noundef writeonly captures(none) %1, float noundef %2, float noundef %3) local_unnamed_addr #0 {
  br label %5

5:                                                ; preds = %5, %4
  %6 = phi i64 [ 0, %4 ], [ %11, %5 ]
  %7 = trunc nuw nsw i64 %6 to i32
  %8 = uitofp nneg i32 %7 to float
  %9 = fadd float %2, %8
  %10 = getelementptr inbounds nuw float, ptr %0, i64 %6
  store float %9, ptr %10, align 4, !tbaa !6
  %11 = add nuw nsw i64 %6, 1
  %12 = icmp eq i64 %11, 1024
  %13 = trunc nuw nsw i64 %6 to i32
  %14 = uitofp nneg i32 %13 to float
  %15 = fsub float %3, %14
  %16 = getelementptr inbounds nuw float, ptr %1, i64 %6
  store float %15, ptr %16, align 4, !tbaa !6
  %17 = add nuw nsw i64 %6, 1
  %18 = icmp eq i64 %17, 1024
  br i1 %12, label %.preheader, label %5, !llvm.loop !10

.preheader:                                       ; preds = %5
  br label %19

19:                                               ; preds = %.preheader
  ret void
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
