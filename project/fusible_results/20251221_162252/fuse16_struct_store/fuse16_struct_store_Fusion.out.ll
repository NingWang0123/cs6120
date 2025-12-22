; ModuleID = '/Users/wangning/Desktop/cornell_repos/cs6120/project/fusible_results/20251221_162252/fuse16_struct_store/fuse16_struct_store.ll'
source_filename = "/Users/wangning/Desktop/cornell_repos/cs6120/project/fusible_tests/fuse16_struct_store.c"
target datalayout = "e-m:o-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-n32:64-S128-Fn32"
target triple = "arm64-apple-macosx26.0.0"

%struct.S = type { float, float, i32 }

; Function Attrs: nofree noinline norecurse nosync nounwind ssp memory(argmem: write) uwtable(sync)
define void @fuse16_struct_store(ptr noalias noundef writeonly captures(none) %0, ptr noalias noundef writeonly captures(none) %1) local_unnamed_addr #0 {
  br label %3

3:                                                ; preds = %3, %2
  %4 = phi i64 [ 0, %2 ], [ %12, %3 ]
  %5 = trunc nuw nsw i64 %4 to i32
  %6 = uitofp nneg i32 %5 to float
  %7 = getelementptr inbounds nuw %struct.S, ptr %0, i64 %4
  store float %6, ptr %7, align 4, !tbaa !6
  %8 = fmul float %6, 2.000000e+00
  %9 = getelementptr inbounds nuw i8, ptr %7, i64 4
  store float %8, ptr %9, align 4, !tbaa !12
  %10 = getelementptr inbounds nuw i8, ptr %7, i64 8
  %11 = trunc nuw nsw i64 %4 to i32
  store i32 %11, ptr %10, align 4, !tbaa !13
  %12 = add nuw nsw i64 %4, 1
  %13 = icmp eq i64 %12, 1048576
  %14 = trunc nuw nsw i64 %4 to i32
  %15 = uitofp nneg i32 %14 to float
  %16 = fmul float %15, 3.000000e+00
  %17 = getelementptr inbounds nuw %struct.S, ptr %1, i64 %4
  store float %16, ptr %17, align 4, !tbaa !6
  %18 = fmul float %15, 4.000000e+00
  %19 = getelementptr inbounds nuw i8, ptr %17, i64 4
  store float %18, ptr %19, align 4, !tbaa !12
  %20 = trunc nuw nsw i64 %4 to i32
  %21 = xor i32 %20, 12345
  %22 = getelementptr inbounds nuw i8, ptr %17, i64 8
  store i32 %21, ptr %22, align 4, !tbaa !13
  %23 = add nuw nsw i64 %4, 1
  %24 = icmp eq i64 %23, 1048576
  br i1 %13, label %.preheader, label %3, !llvm.loop !14

.preheader:                                       ; preds = %3
  br label %25

25:                                               ; preds = %.preheader
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
!6 = !{!7, !8, i64 0}
!7 = !{!"", !8, i64 0, !8, i64 4, !11, i64 8}
!8 = !{!"float", !9, i64 0}
!9 = !{!"omnipotent char", !10, i64 0}
!10 = !{!"Simple C/C++ TBAA"}
!11 = !{!"int", !9, i64 0}
!12 = !{!7, !8, i64 4}
!13 = !{!7, !11, i64 8}
!14 = distinct !{!14, !15, !16, !17, !18}
!15 = !{!"llvm.loop.mustprogress"}
!16 = !{!"llvm.loop.unroll.disable"}
!17 = !{!"llvm.loop.vectorize.width", i32 1}
!18 = !{!"llvm.loop.interleave.count", i32 1}
