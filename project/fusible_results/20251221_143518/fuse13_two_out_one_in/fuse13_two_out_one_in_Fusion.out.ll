; ModuleID = '/Users/wangning/Desktop/cornell_repos/cs6120/project/fusible_results/20251221_143518/fuse13_two_out_one_in/fuse13_two_out_one_in.ll'
source_filename = "/Users/wangning/Desktop/cornell_repos/cs6120/project/fusible_tests/fuse13_two_out_one_in.c"
target datalayout = "e-m:o-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-n32:64-S128-Fn32"
target triple = "arm64-apple-macosx26.0.0"

; Function Attrs: nofree noinline norecurse nosync nounwind ssp memory(argmem: readwrite) uwtable(sync)
define void @fuse13_two_out_one_in(ptr noalias noundef writeonly captures(none) %0, ptr noalias noundef writeonly captures(none) %1, ptr noalias noundef readonly captures(none) %2) local_unnamed_addr #0 {
  br label %4

4:                                                ; preds = %4, %3
  %5 = phi i64 [ 0, %3 ], [ %12, %4 ]
  %6 = getelementptr inbounds nuw float, ptr %2, i64 %5
  %7 = load float, ptr %6, align 4, !tbaa !6
  %8 = trunc nuw nsw i64 %5 to i32
  %9 = uitofp nneg i32 %8 to float
  %10 = tail call float @llvm.fmuladd.f32(float %7, float 2.000000e+00, float %9)
  %11 = getelementptr inbounds nuw float, ptr %0, i64 %5
  store float %10, ptr %11, align 4, !tbaa !6
  %12 = add nuw nsw i64 %5, 1
  %13 = icmp eq i64 %12, 1048576
  %14 = getelementptr inbounds nuw float, ptr %2, i64 %5
  %15 = load float, ptr %14, align 4, !tbaa !6
  %16 = trunc nuw nsw i64 %5 to i32
  %17 = uitofp nneg i32 %16 to float
  %18 = fneg float %17
  %19 = tail call float @llvm.fmuladd.f32(float %15, float 5.000000e-01, float %18)
  %20 = getelementptr inbounds nuw float, ptr %1, i64 %5
  store float %19, ptr %20, align 4, !tbaa !6
  %21 = add nuw nsw i64 %5, 1
  %22 = icmp eq i64 %21, 1048576
  br i1 %13, label %.preheader, label %4, !llvm.loop !10

.preheader:                                       ; preds = %4
  br label %23

23:                                               ; preds = %.preheader
  ret void
}

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare float @llvm.fmuladd.f32(float, float, float) #1

attributes #0 = { nofree noinline norecurse nosync nounwind ssp memory(argmem: readwrite) uwtable(sync) "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+ccpp,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a" }
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
