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
  br i1 %4, label %5, label %90

5:                                                ; preds = %3
  %6 = zext i32 %1 to i64
  %7 = icmp ult i32 %1, 16
  br i1 %7, label %85, label %8

8:                                                ; preds = %5
  %9 = and i64 %6, 4294967280
  %10 = insertelement <4 x float> poison, float %2, i64 0
  %11 = shufflevector <4 x float> %10, <4 x float> poison, <4 x i32> zeroinitializer
  %12 = insertelement <4 x float> poison, float %2, i64 0
  %13 = shufflevector <4 x float> %12, <4 x float> poison, <4 x i32> zeroinitializer
  %14 = insertelement <4 x float> poison, float %2, i64 0
  %15 = shufflevector <4 x float> %14, <4 x float> poison, <4 x i32> zeroinitializer
  %16 = insertelement <4 x float> poison, float %2, i64 0
  %17 = shufflevector <4 x float> %16, <4 x float> poison, <4 x i32> zeroinitializer
  %18 = fdiv fast <4 x float> <float 1.000000e+00, float 1.000000e+00, float 1.000000e+00, float 1.000000e+00>, %11
  %19 = fdiv fast <4 x float> <float 1.000000e+00, float 1.000000e+00, float 1.000000e+00, float 1.000000e+00>, %13
  %20 = fdiv fast <4 x float> <float 1.000000e+00, float 1.000000e+00, float 1.000000e+00, float 1.000000e+00>, %15
  %21 = fdiv fast <4 x float> <float 1.000000e+00, float 1.000000e+00, float 1.000000e+00, float 1.000000e+00>, %17
  %22 = fdiv fast <4 x float> <float 1.000000e+00, float 1.000000e+00, float 1.000000e+00, float 1.000000e+00>, %11
  %23 = fdiv fast <4 x float> <float 1.000000e+00, float 1.000000e+00, float 1.000000e+00, float 1.000000e+00>, %13
  %24 = fdiv fast <4 x float> <float 1.000000e+00, float 1.000000e+00, float 1.000000e+00, float 1.000000e+00>, %15
  %25 = fdiv fast <4 x float> <float 1.000000e+00, float 1.000000e+00, float 1.000000e+00, float 1.000000e+00>, %17
  br label %26

26:                                               ; preds = %26, %8
  %27 = phi i64 [ 0, %8 ], [ %76, %26 ]
  %28 = phi <4 x float> [ zeroinitializer, %8 ], [ %72, %26 ]
  %29 = phi <4 x float> [ zeroinitializer, %8 ], [ %73, %26 ]
  %30 = phi <4 x float> [ zeroinitializer, %8 ], [ %74, %26 ]
  %31 = phi <4 x float> [ zeroinitializer, %8 ], [ %75, %26 ]
  %32 = phi <4 x i32> [ <i32 0, i32 1, i32 2, i32 3>, %8 ], [ %77, %26 ]
  %33 = add <4 x i32> %32, <i32 4, i32 4, i32 4, i32 4>
  %34 = add <4 x i32> %32, <i32 8, i32 8, i32 8, i32 8>
  %35 = add <4 x i32> %32, <i32 12, i32 12, i32 12, i32 12>
  %36 = getelementptr inbounds float, ptr %0, i64 %27
  %37 = load <4 x float>, ptr %36, align 4, !tbaa !6
  %38 = getelementptr inbounds float, ptr %36, i64 4
  %39 = load <4 x float>, ptr %38, align 4, !tbaa !6
  %40 = getelementptr inbounds float, ptr %36, i64 8
  %41 = load <4 x float>, ptr %40, align 4, !tbaa !6
  %42 = getelementptr inbounds float, ptr %36, i64 12
  %43 = load <4 x float>, ptr %42, align 4, !tbaa !6
  %44 = sitofp <4 x i32> %32 to <4 x float>
  %45 = sitofp <4 x i32> %33 to <4 x float>
  %46 = sitofp <4 x i32> %34 to <4 x float>
  %47 = sitofp <4 x i32> %35 to <4 x float>
  %48 = fmul fast <4 x float> %44, <float 5.000000e-01, float 5.000000e-01, float 5.000000e-01, float 5.000000e-01>
  %49 = fmul fast <4 x float> %45, <float 5.000000e-01, float 5.000000e-01, float 5.000000e-01, float 5.000000e-01>
  %50 = fmul fast <4 x float> %46, <float 5.000000e-01, float 5.000000e-01, float 5.000000e-01, float 5.000000e-01>
  %51 = fmul fast <4 x float> %47, <float 5.000000e-01, float 5.000000e-01, float 5.000000e-01, float 5.000000e-01>
  %52 = fadd fast <4 x float> %37, %48
  %53 = fadd fast <4 x float> %39, %49
  %54 = fadd fast <4 x float> %41, %50
  %55 = fadd fast <4 x float> %43, %51
  %56 = fmul fast <4 x float> %52, %18
  %57 = fmul fast <4 x float> %53, %19
  %58 = fmul fast <4 x float> %54, %20
  %59 = fmul fast <4 x float> %55, %21
  %60 = fadd fast <4 x float> %56, %28
  %61 = fadd fast <4 x float> %57, %29
  %62 = fadd fast <4 x float> %58, %30
  %63 = fadd fast <4 x float> %59, %31
  %64 = fadd fast <4 x float> %52, <float 1.000000e+00, float 1.000000e+00, float 1.000000e+00, float 1.000000e+00>
  %65 = fadd fast <4 x float> %53, <float 1.000000e+00, float 1.000000e+00, float 1.000000e+00, float 1.000000e+00>
  %66 = fadd fast <4 x float> %54, <float 1.000000e+00, float 1.000000e+00, float 1.000000e+00, float 1.000000e+00>
  %67 = fadd fast <4 x float> %55, <float 1.000000e+00, float 1.000000e+00, float 1.000000e+00, float 1.000000e+00>
  %68 = fmul fast <4 x float> %64, %22
  %69 = fmul fast <4 x float> %65, %23
  %70 = fmul fast <4 x float> %66, %24
  %71 = fmul fast <4 x float> %67, %25
  %72 = fadd fast <4 x float> %60, %68
  %73 = fadd fast <4 x float> %61, %69
  %74 = fadd fast <4 x float> %62, %70
  %75 = fadd fast <4 x float> %63, %71
  %76 = add nuw i64 %27, 16
  %77 = add <4 x i32> %32, <i32 16, i32 16, i32 16, i32 16>
  %78 = icmp eq i64 %76, %9
  br i1 %78, label %79, label %26, !llvm.loop !10

79:                                               ; preds = %26
  %80 = fadd fast <4 x float> %73, %72
  %81 = fadd fast <4 x float> %74, %80
  %82 = fadd fast <4 x float> %75, %81
  %83 = tail call fast float @llvm.vector.reduce.fadd.v4f32(float -0.000000e+00, <4 x float> %82)
  %84 = icmp eq i64 %9, %6
  br i1 %84, label %90, label %85

85:                                               ; preds = %5, %79
  %86 = phi i64 [ 0, %5 ], [ %9, %79 ]
  %87 = phi float [ 0.000000e+00, %5 ], [ %83, %79 ]
  %88 = fdiv fast float 1.000000e+00, %2
  %89 = fdiv fast float 1.000000e+00, %2
  br label %92

90:                                               ; preds = %92, %79, %3
  %91 = phi float [ 0.000000e+00, %3 ], [ %83, %79 ], [ %105, %92 ]
  ret float %91

92:                                               ; preds = %85, %92
  %93 = phi i64 [ %106, %92 ], [ %86, %85 ]
  %94 = phi float [ %105, %92 ], [ %87, %85 ]
  %95 = getelementptr inbounds float, ptr %0, i64 %93
  %96 = load float, ptr %95, align 4, !tbaa !6
  %97 = trunc i64 %93 to i32
  %98 = sitofp i32 %97 to float
  %99 = fmul fast float %98, 5.000000e-01
  %100 = fadd fast float %96, %99
  %101 = fmul fast float %100, %88
  %102 = fadd fast float %101, %94
  %103 = fadd fast float %100, 1.000000e+00
  %104 = fmul fast float %103, %89
  %105 = fadd fast float %102, %104
  %106 = add nuw nsw i64 %93, 1
  %107 = icmp eq i64 %106, %6
  br i1 %107, label %90, label %92, !llvm.loop !14
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
  %1 = alloca %struct.timespec, align 8
  %2 = alloca %struct.timespec, align 8
  %3 = alloca float, align 4
  call void @llvm.lifetime.start.p0(i64 16, ptr nonnull %1) #7
  call void @llvm.lifetime.start.p0(i64 16, ptr nonnull %2) #7
  %4 = call i32 @clock_gettime(i32 noundef 6, ptr noundef nonnull %1) #7
  call void @llvm.lifetime.start.p0(i64 4, ptr nonnull %3)
  store volatile float 0.000000e+00, ptr %3, align 4, !tbaa !6
  br label %5

5:                                                ; preds = %0, %5
  %6 = phi i32 [ 0, %0 ], [ %9, %5 ]
  %7 = load volatile float, ptr %3, align 4, !tbaa !6
  %8 = fadd fast float %7, 0x404E481380000000
  store volatile float %8, ptr %3, align 4, !tbaa !6
  %9 = add nuw nsw i32 %6, 1
  %10 = icmp eq i32 %9, 10000000
  br i1 %10, label %11, label %5, !llvm.loop !15

11:                                               ; preds = %5
  %12 = call i32 @clock_gettime(i32 noundef 6, ptr noundef nonnull %2) #7
  %13 = load i64, ptr %2, align 8, !tbaa !16
  %14 = load i64, ptr %1, align 8, !tbaa !16
  %15 = sub nsw i64 %13, %14
  %16 = sitofp i64 %15 to double
  %17 = getelementptr inbounds %struct.timespec, ptr %2, i64 0, i32 1
  %18 = load i64, ptr %17, align 8, !tbaa !19
  %19 = getelementptr inbounds %struct.timespec, ptr %1, i64 0, i32 1
  %20 = load i64, ptr %19, align 8, !tbaa !19
  %21 = sub nsw i64 %18, %20
  %22 = sitofp i64 %21 to double
  %23 = fmul fast double %22, 1.000000e-09
  %24 = fadd fast double %23, %16
  %25 = load volatile float, ptr %3, align 4, !tbaa !6
  %26 = fpext float %25 to double
  %27 = call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str, double noundef nofpclass(nan inf) %26)
  %28 = call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.1, double noundef nofpclass(nan inf) %24)
  call void @llvm.lifetime.end.p0(i64 4, ptr nonnull %3)
  call void @llvm.lifetime.end.p0(i64 16, ptr nonnull %2) #7
  call void @llvm.lifetime.end.p0(i64 16, ptr nonnull %1) #7
  ret i32 0
}

declare i32 @clock_gettime(i32 noundef, ptr noundef) local_unnamed_addr #4

; Function Attrs: nofree nounwind
declare noundef i32 @printf(ptr nocapture noundef readonly, ...) local_unnamed_addr #5

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare float @llvm.vector.reduce.fadd.v4f32(float, <4 x float>) #6

attributes #0 = { nofree norecurse nosync nounwind ssp memory(argmem: read) uwtable(sync) "approx-func-fp-math"="true" "frame-pointer"="non-leaf" "no-infs-fp-math"="true" "no-nans-fp-math"="true" "no-signed-zeros-fp-math"="true" "no-trapping-math"="true" "probe-stack"="__chkstk_darwin" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+crc,+dotprod,+fp-armv8,+fp16fml,+fullfp16,+lse,+neon,+ras,+rcpc,+rdm,+sha2,+sha3,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8.5a,+v8a,+zcm,+zcz" "unsafe-fp-math"="true" }
attributes #1 = { mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: readwrite) }
attributes #2 = { mustprogress nofree norecurse nosync nounwind ssp willreturn memory(none) uwtable(sync) "approx-func-fp-math"="true" "frame-pointer"="non-leaf" "no-infs-fp-math"="true" "no-nans-fp-math"="true" "no-signed-zeros-fp-math"="true" "no-trapping-math"="true" "probe-stack"="__chkstk_darwin" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+crc,+dotprod,+fp-armv8,+fp16fml,+fullfp16,+lse,+neon,+ras,+rcpc,+rdm,+sha2,+sha3,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8.5a,+v8a,+zcm,+zcz" "unsafe-fp-math"="true" }
attributes #3 = { nounwind ssp uwtable(sync) "approx-func-fp-math"="true" "frame-pointer"="non-leaf" "no-infs-fp-math"="true" "no-nans-fp-math"="true" "no-signed-zeros-fp-math"="true" "no-trapping-math"="true" "probe-stack"="__chkstk_darwin" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+crc,+dotprod,+fp-armv8,+fp16fml,+fullfp16,+lse,+neon,+ras,+rcpc,+rdm,+sha2,+sha3,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8.5a,+v8a,+zcm,+zcz" "unsafe-fp-math"="true" }
attributes #4 = { "approx-func-fp-math"="true" "frame-pointer"="non-leaf" "no-infs-fp-math"="true" "no-nans-fp-math"="true" "no-signed-zeros-fp-math"="true" "no-trapping-math"="true" "probe-stack"="__chkstk_darwin" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+crc,+dotprod,+fp-armv8,+fp16fml,+fullfp16,+lse,+neon,+ras,+rcpc,+rdm,+sha2,+sha3,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8.5a,+v8a,+zcm,+zcz" "unsafe-fp-math"="true" }
attributes #5 = { nofree nounwind "approx-func-fp-math"="true" "frame-pointer"="non-leaf" "no-infs-fp-math"="true" "no-nans-fp-math"="true" "no-signed-zeros-fp-math"="true" "no-trapping-math"="true" "probe-stack"="__chkstk_darwin" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+crc,+dotprod,+fp-armv8,+fp16fml,+fullfp16,+lse,+neon,+ras,+rcpc,+rdm,+sha2,+sha3,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8.5a,+v8a,+zcm,+zcz" "unsafe-fp-math"="true" }
attributes #6 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #7 = { nounwind }

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
!10 = distinct !{!10, !11, !12, !13}
!11 = !{!"llvm.loop.mustprogress"}
!12 = !{!"llvm.loop.isvectorized", i32 1}
!13 = !{!"llvm.loop.unroll.runtime.disable"}
!14 = distinct !{!14, !11, !13, !12}
!15 = distinct !{!15, !11}
!16 = !{!17, !18, i64 0}
!17 = !{!"timespec", !18, i64 0, !18, i64 8}
!18 = !{!"long", !8, i64 0}
!19 = !{!17, !18, i64 8}
