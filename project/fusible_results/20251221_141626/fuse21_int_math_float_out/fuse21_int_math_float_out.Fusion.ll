; ModuleID = '/Users/wangning/Desktop/cornell_repos/cs6120/project/fusible_results/20251221_141626/fuse21_int_math_float_out/fuse21_int_math_float_out.driver.c'
source_filename = "/Users/wangning/Desktop/cornell_repos/cs6120/project/fusible_results/20251221_141626/fuse21_int_math_float_out/fuse21_int_math_float_out.driver.c"
target datalayout = "e-m:o-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-n32:64-S128-Fn32"
target triple = "arm64-apple-macosx26.0.0"

%struct.timespec = type { i64, i64 }

@.str = private unnamed_addr constant [6 x i8] c"%.6f\0A\00", align 1

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
  %12 = icmp eq i64 %11, 1048576
  br i1 %12, label %14, label %3, !llvm.loop !10

13:                                               ; preds = %14
  ret void

14:                                               ; preds = %3, %14
  %15 = phi i64 [ %23, %14 ], [ 0, %3 ]
  %16 = trunc nuw nsw i64 %15 to i32
  %17 = mul i32 %16, 91661
  %18 = add i32 %17, 193375
  %19 = lshr i32 %18, 8
  %20 = and i32 %19, 1023
  %21 = uitofp nneg i32 %20 to float
  %22 = getelementptr inbounds nuw float, ptr %1, i64 %15
  store float %21, ptr %22, align 4, !tbaa !6
  %23 = add nuw nsw i64 %15, 1
  %24 = icmp eq i64 %23, 1048576
  br i1 %24, label %13, label %14, !llvm.loop !15
}

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.start.p0(i64 immarg, ptr captures(none)) #1

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.end.p0(i64 immarg, ptr captures(none)) #1

; Function Attrs: noinline nounwind ssp uwtable(sync)
define range(i32 0, 3) i32 @main() local_unnamed_addr #2 {
  %1 = tail call align 64 dereferenceable_or_null(4194304) ptr @aligned_alloc(i64 noundef 64, i64 noundef 4194304) #8
  %2 = tail call align 64 dereferenceable_or_null(4194304) ptr @aligned_alloc(i64 noundef 64, i64 noundef 4194304) #8
  %3 = icmp ne ptr %1, null
  %4 = icmp ne ptr %2, null
  %5 = and i1 %3, %4
  br i1 %5, label %6, label %11

6:                                                ; preds = %0
  tail call void @fuse21_int_math_float_out(ptr noundef nonnull %1, ptr noundef nonnull %2)
  %7 = tail call fastcc double @now_sec()
  tail call void @fuse21_int_math_float_out(ptr noundef nonnull %1, ptr noundef nonnull %2)
  %8 = tail call fastcc double @now_sec()
  %9 = fsub double %8, %7
  %10 = tail call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str, double noundef %9)
  tail call void @free(ptr noundef nonnull %1)
  tail call void @free(ptr noundef nonnull %2)
  br label %11

11:                                               ; preds = %0, %6
  %12 = phi i32 [ 0, %6 ], [ 2, %0 ]
  ret i32 %12
}

; Function Attrs: mustprogress nofree nounwind willreturn allockind("alloc,uninitialized,aligned") allocsize(1) memory(inaccessiblemem: readwrite)
declare noalias noundef ptr @aligned_alloc(i64 allocalign noundef, i64 noundef) local_unnamed_addr #3

; Function Attrs: noinline nounwind ssp uwtable(sync)
define internal fastcc double @now_sec() unnamed_addr #2 {
  %1 = alloca %struct.timespec, align 8
  call void @llvm.lifetime.start.p0(i64 16, ptr nonnull %1) #9
  %2 = call i32 @clock_gettime(i32 noundef 6, ptr noundef nonnull %1) #9
  %3 = load i64, ptr %1, align 8, !tbaa !16
  %4 = sitofp i64 %3 to double
  %5 = getelementptr inbounds nuw i8, ptr %1, i64 8
  %6 = load i64, ptr %5, align 8, !tbaa !19
  %7 = sitofp i64 %6 to double
  %8 = call double @llvm.fmuladd.f64(double %7, double 1.000000e-09, double %4)
  call void @llvm.lifetime.end.p0(i64 16, ptr nonnull %1) #9
  ret double %8
}

; Function Attrs: nofree nounwind
declare noundef i32 @printf(ptr noundef readonly captures(none), ...) local_unnamed_addr #4

; Function Attrs: mustprogress nounwind willreturn allockind("free") memory(argmem: readwrite, inaccessiblemem: readwrite)
declare void @free(ptr allocptr noundef captures(none)) local_unnamed_addr #5

declare i32 @clock_gettime(i32 noundef, ptr noundef) local_unnamed_addr #6

; Function Attrs: mustprogress nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare double @llvm.fmuladd.f64(double, double, double) #7

attributes #0 = { nofree noinline norecurse nosync nounwind ssp memory(argmem: write) uwtable(sync) "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+ccpp,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a" }
attributes #1 = { mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: readwrite) }
attributes #2 = { noinline nounwind ssp uwtable(sync) "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+ccpp,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a" }
attributes #3 = { mustprogress nofree nounwind willreturn allockind("alloc,uninitialized,aligned") allocsize(1) memory(inaccessiblemem: readwrite) "alloc-family"="malloc" "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+ccpp,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a" }
attributes #4 = { nofree nounwind "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+ccpp,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a" }
attributes #5 = { mustprogress nounwind willreturn allockind("free") memory(argmem: readwrite, inaccessiblemem: readwrite) "alloc-family"="malloc" "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+ccpp,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a" }
attributes #6 = { "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+ccpp,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a" }
attributes #7 = { mustprogress nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #8 = { allocsize(1) }
attributes #9 = { nounwind }

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
!16 = !{!17, !18, i64 0}
!17 = !{!"timespec", !18, i64 0, !18, i64 8}
!18 = !{!"long", !8, i64 0}
!19 = !{!17, !18, i64 8}
