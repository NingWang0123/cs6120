; ModuleID = '../fusible_tests/fuse16_struct_store.c'
source_filename = "../fusible_tests/fuse16_struct_store.c"
target datalayout = "e-m:o-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-n32:64-S128-Fn32"
target triple = "arm64-apple-macosx26.0.0"

%struct.S = type { float, float, i32 }

; Function Attrs: nofree noinline norecurse nosync nounwind ssp memory(argmem: write) uwtable(sync)
define void @fuse16_struct_store(ptr noalias noundef writeonly captures(none) %0, ptr noalias noundef writeonly captures(none) %1) local_unnamed_addr #0 {
  br label %3

3:                                                ; preds = %2, %3
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
  %13 = icmp eq i64 %12, 4096
  br i1 %13, label %15, label %3, !llvm.loop !14

14:                                               ; preds = %15
  ret void

15:                                               ; preds = %3, %15
  %16 = phi i64 [ %26, %15 ], [ 0, %3 ]
  %17 = trunc nuw nsw i64 %16 to i32
  %18 = uitofp nneg i32 %17 to float
  %19 = fmul float %18, 3.000000e+00
  %20 = getelementptr inbounds nuw %struct.S, ptr %1, i64 %16
  store float %19, ptr %20, align 4, !tbaa !6
  %21 = fmul float %18, 4.000000e+00
  %22 = getelementptr inbounds nuw i8, ptr %20, i64 4
  store float %21, ptr %22, align 4, !tbaa !12
  %23 = trunc nuw nsw i64 %16 to i32
  %24 = xor i32 %23, 12345
  %25 = getelementptr inbounds nuw i8, ptr %20, i64 8
  store i32 %24, ptr %25, align 4, !tbaa !13
  %26 = add nuw nsw i64 %16, 1
  %27 = icmp eq i64 %26, 4096
  br i1 %27, label %14, label %15, !llvm.loop !19
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
!19 = distinct !{!19, !15, !16, !17, !18}
