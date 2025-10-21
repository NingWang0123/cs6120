; ModuleID = 'benchmark.c'
source_filename = "benchmark.c"
target datalayout = "e-m:o-i64:64-i128:128-n32:64-S128"
target triple = "arm64-apple-macosx15.0.0"

%struct.timespec = type { i64, i64 }

@.str = private unnamed_addr constant [14 x i8] c"Result: %.6f\0A\00", align 1
@.str.1 = private unnamed_addr constant [28 x i8] c"Elapsed time: %.6f seconds\0A\00", align 1

; Function Attrs: nofree norecurse nosync nounwind ssp memory(argmem: read) uwtable(sync)
define nofpclass(nan inf) float @loop_div_sum(ptr nocapture noundef readonly %0, i32 noundef %1, float noundef nofpclass(nan inf) %2) local_unnamed_addr #0 {
  %4 = icmp sgt i32 %1, 0
  br i1 %4, label %5, label %9

5:                                                ; preds = %3
  %6 = zext i32 %1 to i64
  %7 = fdiv fast float 1.000000e+00, %2
  %8 = fdiv fast float 1.000000e+00, %2
  br label %11

9:                                                ; preds = %11, %3
  %10 = phi float [ 0.000000e+00, %3 ], [ %24, %11 ]
  ret float %10

11:                                               ; preds = %5, %11
  %12 = phi i64 [ 0, %5 ], [ %25, %11 ]
  %13 = phi float [ 0.000000e+00, %5 ], [ %24, %11 ]
  %14 = getelementptr inbounds float, ptr %0, i64 %12
  %15 = load float, ptr %14, align 4, !tbaa !6
  %16 = trunc i64 %12 to i32
  %17 = sitofp i32 %16 to float
  %18 = fmul fast float %17, 5.000000e-01
  %19 = fadd fast float %15, %18
  %20 = fmul fast float %19, %7
  %21 = fadd fast float %20, %13
  %22 = fadd fast float %19, 1.000000e+00
  %23 = fmul fast float %22, %8
  %24 = fadd fast float %21, %23
  %25 = add nuw nsw i64 %12, 1
  %26 = icmp eq i64 %25, %6
  br i1 %26, label %9, label %11, !llvm.loop !10
}

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.start.p0(i64 immarg, ptr nocapture) #1

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.end.p0(i64 immarg, ptr nocapture) #1

; Function Attrs: mustprogress nofree norecurse nosync nounwind ssp willreturn memory(none) uwtable(sync)
define nofpclass(nan inf) float @branchy(float noundef nofpclass(nan inf) %0, float noundef nofpclass(nan inf) %1, float noundef nofpclass(nan inf) %2) local_unnamed_addr #2 {
  %4 = fcmp fast ogt float %0, %1
  %5 = fadd fast float %1, %0
  %6 = select i1 %4, float %5, float -0.000000e+00
  %7 = fadd fast float %6, %0
  %8 = fadd fast float %2, 2.500000e-01
  %9 = fdiv fast float %7, %8
  ret float %9
}

; Function Attrs: nounwind ssp uwtable(sync)
define i32 @main() local_unnamed_addr #3 {
  %1 = alloca [8 x float], align 4
  %2 = alloca %struct.timespec, align 8
  %3 = alloca %struct.timespec, align 8
  %4 = alloca float, align 4
  call void @llvm.lifetime.start.p0(i64 32, ptr nonnull %1) #6
  br label %7

5:                                                ; preds = %7
  call void @llvm.lifetime.start.p0(i64 16, ptr nonnull %2) #6
  call void @llvm.lifetime.start.p0(i64 16, ptr nonnull %3) #6
  %6 = call i32 @clock_gettime(i32 noundef 6, ptr noundef nonnull %2) #6
  call void @llvm.lifetime.start.p0(i64 4, ptr nonnull %4)
  store volatile float 0.000000e+00, ptr %4, align 4, !tbaa !6
  br label %16

7:                                                ; preds = %0, %7
  %8 = phi i64 [ 0, %0 ], [ %14, %7 ]
  %9 = trunc i64 %8 to i32
  %10 = sitofp i32 %9 to float
  %11 = fmul fast float %10, 2.500000e-01
  %12 = fadd fast float %11, 1.000000e+00
  %13 = getelementptr inbounds [8 x float], ptr %1, i64 0, i64 %8
  store float %12, ptr %13, align 4, !tbaa !6
  %14 = add nuw nsw i64 %8, 1
  %15 = icmp eq i64 %14, 8
  br i1 %15, label %5, label %7, !llvm.loop !13

16:                                               ; preds = %5, %50
  %17 = phi i32 [ 0, %5 ], [ %54, %50 ]
  br label %36

18:                                               ; preds = %50
  %19 = call i32 @clock_gettime(i32 noundef 6, ptr noundef nonnull %3) #6
  %20 = load i64, ptr %3, align 8, !tbaa !14
  %21 = load i64, ptr %2, align 8, !tbaa !14
  %22 = sub nsw i64 %20, %21
  %23 = sitofp i64 %22 to double
  %24 = getelementptr inbounds %struct.timespec, ptr %3, i64 0, i32 1
  %25 = load i64, ptr %24, align 8, !tbaa !17
  %26 = getelementptr inbounds %struct.timespec, ptr %2, i64 0, i32 1
  %27 = load i64, ptr %26, align 8, !tbaa !17
  %28 = sub nsw i64 %25, %27
  %29 = sitofp i64 %28 to double
  %30 = fmul fast double %29, 1.000000e-09
  %31 = fadd fast double %30, %23
  %32 = load volatile float, ptr %4, align 4, !tbaa !6
  %33 = fpext float %32 to double
  %34 = call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str, double noundef nofpclass(nan inf) %33)
  %35 = call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.1, double noundef nofpclass(nan inf) %31)
  call void @llvm.lifetime.end.p0(i64 4, ptr nonnull %4)
  call void @llvm.lifetime.end.p0(i64 16, ptr nonnull %3) #6
  call void @llvm.lifetime.end.p0(i64 16, ptr nonnull %2) #6
  call void @llvm.lifetime.end.p0(i64 32, ptr nonnull %1) #6
  ret i32 0

36:                                               ; preds = %16, %36
  %37 = phi i64 [ %48, %36 ], [ 0, %16 ]
  %38 = phi float [ %47, %36 ], [ 0.000000e+00, %16 ]
  %39 = getelementptr inbounds float, ptr %1, i64 %37
  %40 = load float, ptr %39, align 4, !tbaa !6
  %41 = trunc i64 %37 to i32
  %42 = sitofp i32 %41 to float
  %43 = fmul fast float %42, 5.000000e-01
  %44 = fadd fast float %43, %40
  %45 = fmul fast float %44, 0x3FD99999A0000000
  %46 = fadd fast float %38, 0x3FC99999A0000000
  %47 = fadd fast float %46, %45
  %48 = add nuw nsw i64 %37, 1
  %49 = icmp eq i64 %48, 8
  br i1 %49, label %50, label %36, !llvm.loop !10

50:                                               ; preds = %36
  %51 = fadd fast float %47, 0x4047AE7A00000000
  %52 = load volatile float, ptr %4, align 4, !tbaa !6
  %53 = fadd fast float %51, %52
  store volatile float %53, ptr %4, align 4, !tbaa !6
  %54 = add nuw nsw i32 %17, 1
  %55 = icmp eq i32 %54, 10000000
  br i1 %55, label %18, label %16, !llvm.loop !18
}

declare i32 @clock_gettime(i32 noundef, ptr noundef) local_unnamed_addr #4

; Function Attrs: nofree nounwind
declare noundef i32 @printf(ptr nocapture noundef readonly, ...) local_unnamed_addr #5

attributes #0 = { nofree norecurse nosync nounwind ssp memory(argmem: read) uwtable(sync) "approx-func-fp-math"="true" "frame-pointer"="non-leaf" "no-infs-fp-math"="true" "no-nans-fp-math"="true" "no-signed-zeros-fp-math"="true" "no-trapping-math"="true" "probe-stack"="__chkstk_darwin" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+crc,+dotprod,+fp-armv8,+fp16fml,+fullfp16,+lse,+neon,+ras,+rcpc,+rdm,+sha2,+sha3,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8.5a,+v8a,+zcm,+zcz" "unsafe-fp-math"="true" }
attributes #1 = { mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: readwrite) }
attributes #2 = { mustprogress nofree norecurse nosync nounwind ssp willreturn memory(none) uwtable(sync) "approx-func-fp-math"="true" "frame-pointer"="non-leaf" "no-infs-fp-math"="true" "no-nans-fp-math"="true" "no-signed-zeros-fp-math"="true" "no-trapping-math"="true" "probe-stack"="__chkstk_darwin" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+crc,+dotprod,+fp-armv8,+fp16fml,+fullfp16,+lse,+neon,+ras,+rcpc,+rdm,+sha2,+sha3,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8.5a,+v8a,+zcm,+zcz" "unsafe-fp-math"="true" }
attributes #3 = { nounwind ssp uwtable(sync) "approx-func-fp-math"="true" "frame-pointer"="non-leaf" "no-infs-fp-math"="true" "no-nans-fp-math"="true" "no-signed-zeros-fp-math"="true" "no-trapping-math"="true" "probe-stack"="__chkstk_darwin" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+crc,+dotprod,+fp-armv8,+fp16fml,+fullfp16,+lse,+neon,+ras,+rcpc,+rdm,+sha2,+sha3,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8.5a,+v8a,+zcm,+zcz" "unsafe-fp-math"="true" }
attributes #4 = { "approx-func-fp-math"="true" "frame-pointer"="non-leaf" "no-infs-fp-math"="true" "no-nans-fp-math"="true" "no-signed-zeros-fp-math"="true" "no-trapping-math"="true" "probe-stack"="__chkstk_darwin" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+crc,+dotprod,+fp-armv8,+fp16fml,+fullfp16,+lse,+neon,+ras,+rcpc,+rdm,+sha2,+sha3,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8.5a,+v8a,+zcm,+zcz" "unsafe-fp-math"="true" }
attributes #5 = { nofree nounwind "approx-func-fp-math"="true" "frame-pointer"="non-leaf" "no-infs-fp-math"="true" "no-nans-fp-math"="true" "no-signed-zeros-fp-math"="true" "no-trapping-math"="true" "probe-stack"="__chkstk_darwin" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+crc,+dotprod,+fp-armv8,+fp16fml,+fullfp16,+lse,+neon,+ras,+rcpc,+rdm,+sha2,+sha3,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8.5a,+v8a,+zcm,+zcz" "unsafe-fp-math"="true" }
attributes #6 = { nounwind }

!llvm.module.flags = !{!0, !1, !2, !3, !4}
!llvm.ident = !{!5}

!0 = !{i32 2, !"SDK Version", [2 x i32] [i32 15, i32 2]}
!1 = !{i32 1, !"wchar_size", i32 4}
!2 = !{i32 8, !"PIC Level", i32 2}
!3 = !{i32 7, !"uwtable", i32 1}
!4 = !{i32 7, !"frame-pointer", i32 1}
!5 = !{!"Apple clang version 16.0.0 (clang-1600.0.26.6)"}
!6 = !{!7, !7, i64 0}
!7 = !{!"float", !8, i64 0}
!8 = !{!"omnipotent char", !9, i64 0}
!9 = !{!"Simple C/C++ TBAA"}
!10 = distinct !{!10, !11, !12}
!11 = !{!"llvm.loop.mustprogress"}
!12 = !{!"llvm.loop.unroll.disable"}
!13 = distinct !{!13, !11, !12}
!14 = !{!15, !16, i64 0}
!15 = !{!"timespec", !16, i64 0, !16, i64 8}
!16 = !{!"long", !8, i64 0}
!17 = !{!15, !16, i64 8}
!18 = distinct !{!18, !11, !12}
