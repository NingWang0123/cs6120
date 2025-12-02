; ModuleID = 'output/benchmark.ll'
source_filename = "tests/benchmark.c"
target datalayout = "e-m:o-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-n32:64-S128-Fn32"
target triple = "arm64-apple-macosx15.0.0"

%struct.timeval = type { i64, i32 }

@.str = private unnamed_addr constant [30 x i8] c"Running benchmarks with N=%d\0A\00", align 1
@.str.1 = private unnamed_addr constant [25 x i8] c"Array ops: %.6f seconds\0A\00", align 1
@.str.2 = private unnamed_addr constant [28 x i8] c"Scale offset: %.6f seconds\0A\00", align 1
@.str.3 = private unnamed_addr constant [27 x i8] c"Elementwise: %.6f seconds\0A\00", align 1
@.str.4 = private unnamed_addr constant [51 x i8] c"Sample results: c[0]=%.4f, c[%d]=%.4f, c[%d]=%.4f\0A\00", align 1

; Function Attrs: nofree nounwind ssp uwtable(sync)
define double @get_wall_time() local_unnamed_addr #0 {
  %1 = alloca %struct.timeval, align 8
  call void @llvm.lifetime.start.p0(i64 16, ptr nonnull %1) #8
  %2 = call i32 @gettimeofday(ptr noundef nonnull %1, ptr noundef null)
  %3 = load i64, ptr %1, align 8, !tbaa !6
  %4 = sitofp i64 %3 to double
  %5 = getelementptr inbounds nuw i8, ptr %1, i64 8
  %6 = load i32, ptr %5, align 8, !tbaa !12
  %7 = sitofp i32 %6 to double
  %8 = tail call double @llvm.fmuladd.f64(double %7, double 0x3EB0C6F7A0B5ED8D, double %4)
  call void @llvm.lifetime.end.p0(i64 16, ptr nonnull %1) #8
  ret double %8
}

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.start.p0(i64 immarg, ptr captures(none)) #1

; Function Attrs: nofree nounwind
declare noundef i32 @gettimeofday(ptr noundef captures(none), ptr noundef captures(none)) local_unnamed_addr #2

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare double @llvm.fmuladd.f64(double, double, double) #3

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.end.p0(i64 immarg, ptr captures(none)) #1

; Function Attrs: nofree norecurse nosync nounwind ssp memory(argmem: readwrite) uwtable(sync)
define void @test_array_ops(ptr noundef readonly captures(none) %0, ptr noundef readonly captures(none) %1, ptr noundef writeonly captures(none) %2, i32 noundef %3) local_unnamed_addr #4 {
  %5 = ptrtoint ptr %1 to i64
  %6 = ptrtoint ptr %0 to i64
  %7 = ptrtoint ptr %2 to i64
  %8 = icmp sgt i32 %3, 0
  br i1 %8, label %9, label %77

9:                                                ; preds = %4
  %10 = zext nneg i32 %3 to i64
  %11 = icmp ult i32 %3, 4
  br i1 %11, label %12, label %14

12:                                               ; preds = %75, %58, %14, %9
  %13 = phi i64 [ 0, %9 ], [ 0, %14 ], [ %23, %58 ], [ %63, %75 ]
  br label %78

14:                                               ; preds = %9
  %15 = sub i64 %7, %6
  %16 = icmp ult i64 %15, 64
  %17 = sub i64 %7, %5
  %18 = icmp ult i64 %17, 64
  %19 = or i1 %16, %18
  br i1 %19, label %12, label %20

20:                                               ; preds = %14
  %21 = icmp ult i32 %3, 16
  br i1 %21, label %61, label %22

22:                                               ; preds = %20
  %23 = and i64 %10, 2147483632
  br label %24

24:                                               ; preds = %24, %22
  %25 = phi i64 [ 0, %22 ], [ %54, %24 ]
  %26 = getelementptr inbounds nuw float, ptr %0, i64 %25
  %27 = getelementptr inbounds nuw i8, ptr %26, i64 16
  %28 = getelementptr inbounds nuw i8, ptr %26, i64 32
  %29 = getelementptr inbounds nuw i8, ptr %26, i64 48
  %30 = load <4 x float>, ptr %26, align 4, !tbaa !13
  %31 = load <4 x float>, ptr %27, align 4, !tbaa !13
  %32 = load <4 x float>, ptr %28, align 4, !tbaa !13
  %33 = load <4 x float>, ptr %29, align 4, !tbaa !13
  %34 = getelementptr inbounds nuw float, ptr %1, i64 %25
  %35 = getelementptr inbounds nuw i8, ptr %34, i64 16
  %36 = getelementptr inbounds nuw i8, ptr %34, i64 32
  %37 = getelementptr inbounds nuw i8, ptr %34, i64 48
  %38 = load <4 x float>, ptr %34, align 4, !tbaa !13
  %39 = load <4 x float>, ptr %35, align 4, !tbaa !13
  %40 = load <4 x float>, ptr %36, align 4, !tbaa !13
  %41 = load <4 x float>, ptr %37, align 4, !tbaa !13
  %42 = fmul <4 x float> %38, splat (float 3.000000e+00)
  %43 = fmul <4 x float> %39, splat (float 3.000000e+00)
  %44 = fmul <4 x float> %40, splat (float 3.000000e+00)
  %45 = fmul <4 x float> %41, splat (float 3.000000e+00)
  %46 = tail call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %30, <4 x float> splat (float 2.000000e+00), <4 x float> %42)
  %47 = tail call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %31, <4 x float> splat (float 2.000000e+00), <4 x float> %43)
  %48 = tail call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %32, <4 x float> splat (float 2.000000e+00), <4 x float> %44)
  %49 = tail call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %33, <4 x float> splat (float 2.000000e+00), <4 x float> %45)
  %50 = getelementptr inbounds nuw float, ptr %2, i64 %25
  %51 = getelementptr inbounds nuw i8, ptr %50, i64 16
  %52 = getelementptr inbounds nuw i8, ptr %50, i64 32
  %53 = getelementptr inbounds nuw i8, ptr %50, i64 48
  store <4 x float> %46, ptr %50, align 4, !tbaa !13
  store <4 x float> %47, ptr %51, align 4, !tbaa !13
  store <4 x float> %48, ptr %52, align 4, !tbaa !13
  store <4 x float> %49, ptr %53, align 4, !tbaa !13
  %54 = add nuw i64 %25, 16
  %55 = icmp eq i64 %54, %23
  br i1 %55, label %56, label %24, !llvm.loop !15

56:                                               ; preds = %24
  %57 = icmp eq i64 %23, %10
  br i1 %57, label %77, label %58

58:                                               ; preds = %56
  %59 = and i64 %10, 12
  %60 = icmp eq i64 %59, 0
  br i1 %60, label %12, label %61

61:                                               ; preds = %58, %20
  %62 = phi i64 [ %23, %58 ], [ 0, %20 ]
  %63 = and i64 %10, 2147483644
  br label %64

64:                                               ; preds = %64, %61
  %65 = phi i64 [ %62, %61 ], [ %73, %64 ]
  %66 = getelementptr inbounds nuw float, ptr %0, i64 %65
  %67 = load <4 x float>, ptr %66, align 4, !tbaa !13
  %68 = getelementptr inbounds nuw float, ptr %1, i64 %65
  %69 = load <4 x float>, ptr %68, align 4, !tbaa !13
  %70 = fmul <4 x float> %69, splat (float 3.000000e+00)
  %71 = tail call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %67, <4 x float> splat (float 2.000000e+00), <4 x float> %70)
  %72 = getelementptr inbounds nuw float, ptr %2, i64 %65
  store <4 x float> %71, ptr %72, align 4, !tbaa !13
  %73 = add nuw i64 %65, 4
  %74 = icmp eq i64 %73, %63
  br i1 %74, label %75, label %64, !llvm.loop !19

75:                                               ; preds = %64
  %76 = icmp eq i64 %63, %10
  br i1 %76, label %77, label %12

.loopexit:                                        ; preds = %78
  br label %77

77:                                               ; preds = %.loopexit, %75, %56, %4
  ret void

78:                                               ; preds = %78, %12
  %79 = phi i64 [ %87, %78 ], [ %13, %12 ]
  %80 = getelementptr inbounds nuw float, ptr %0, i64 %79
  %81 = load float, ptr %80, align 4, !tbaa !13
  %82 = getelementptr inbounds nuw float, ptr %1, i64 %79
  %83 = load float, ptr %82, align 4, !tbaa !13
  %84 = fmul float %83, 3.000000e+00
  %85 = tail call float @llvm.fmuladd.f32(float %81, float 2.000000e+00, float %84)
  %86 = getelementptr inbounds nuw float, ptr %2, i64 %79
  store float %85, ptr %86, align 4, !tbaa !13
  %87 = add nuw nsw i64 %79, 1
  %88 = icmp eq i64 %87, %10
  br i1 %88, label %.loopexit, label %78, !llvm.loop !20
}

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare float @llvm.fmuladd.f32(float, float, float) #3

; Function Attrs: nofree norecurse nosync nounwind ssp memory(argmem: readwrite) uwtable(sync)
define void @test_scale_offset(ptr noundef readonly captures(none) %0, ptr noundef writeonly captures(none) %1, i32 noundef %2, float noundef %3, float noundef %4) local_unnamed_addr #4 {
  %6 = icmp sgt i32 %2, 0
  br i1 %6, label %7, label %67

7:                                                ; preds = %5
  %8 = ptrtoint ptr %1 to i64
  %9 = ptrtoint ptr %0 to i64
  %10 = zext nneg i32 %2 to i64
  %11 = icmp ult i32 %2, 4
  %12 = sub i64 %8, %9
  %13 = icmp ult i64 %12, 64
  %14 = or i1 %11, %13
  br i1 %14, label %15, label %17

15:                                               ; preds = %65, %47, %7
  %16 = phi i64 [ 0, %7 ], [ %20, %47 ], [ %52, %65 ]
  br label %68

17:                                               ; preds = %7
  %18 = icmp ult i32 %2, 16
  br i1 %18, label %50, label %19

19:                                               ; preds = %17
  %20 = and i64 %10, 2147483632
  %21 = insertelement <4 x float> poison, float %3, i64 0
  %22 = shufflevector <4 x float> %21, <4 x float> poison, <4 x i32> zeroinitializer
  %23 = insertelement <4 x float> poison, float %4, i64 0
  %24 = shufflevector <4 x float> %23, <4 x float> poison, <4 x i32> zeroinitializer
  br label %25

25:                                               ; preds = %25, %19
  %26 = phi i64 [ 0, %19 ], [ %43, %25 ]
  %27 = getelementptr inbounds nuw float, ptr %0, i64 %26
  %28 = getelementptr inbounds nuw i8, ptr %27, i64 16
  %29 = getelementptr inbounds nuw i8, ptr %27, i64 32
  %30 = getelementptr inbounds nuw i8, ptr %27, i64 48
  %31 = load <4 x float>, ptr %27, align 4, !tbaa !13
  %32 = load <4 x float>, ptr %28, align 4, !tbaa !13
  %33 = load <4 x float>, ptr %29, align 4, !tbaa !13
  %34 = load <4 x float>, ptr %30, align 4, !tbaa !13
  %35 = tail call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %31, <4 x float> %22, <4 x float> %24)
  %36 = tail call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %32, <4 x float> %22, <4 x float> %24)
  %37 = tail call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %33, <4 x float> %22, <4 x float> %24)
  %38 = tail call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %34, <4 x float> %22, <4 x float> %24)
  %39 = getelementptr inbounds nuw float, ptr %1, i64 %26
  %40 = getelementptr inbounds nuw i8, ptr %39, i64 16
  %41 = getelementptr inbounds nuw i8, ptr %39, i64 32
  %42 = getelementptr inbounds nuw i8, ptr %39, i64 48
  store <4 x float> %35, ptr %39, align 4, !tbaa !13
  store <4 x float> %36, ptr %40, align 4, !tbaa !13
  store <4 x float> %37, ptr %41, align 4, !tbaa !13
  store <4 x float> %38, ptr %42, align 4, !tbaa !13
  %43 = add nuw i64 %26, 16
  %44 = icmp eq i64 %43, %20
  br i1 %44, label %45, label %25, !llvm.loop !21

45:                                               ; preds = %25
  %46 = icmp eq i64 %20, %10
  br i1 %46, label %67, label %47

47:                                               ; preds = %45
  %48 = and i64 %10, 12
  %49 = icmp eq i64 %48, 0
  br i1 %49, label %15, label %50

50:                                               ; preds = %47, %17
  %51 = phi i64 [ %20, %47 ], [ 0, %17 ]
  %52 = and i64 %10, 2147483644
  %53 = insertelement <4 x float> poison, float %3, i64 0
  %54 = shufflevector <4 x float> %53, <4 x float> poison, <4 x i32> zeroinitializer
  %55 = insertelement <4 x float> poison, float %4, i64 0
  %56 = shufflevector <4 x float> %55, <4 x float> poison, <4 x i32> zeroinitializer
  br label %57

57:                                               ; preds = %57, %50
  %58 = phi i64 [ %51, %50 ], [ %63, %57 ]
  %59 = getelementptr inbounds nuw float, ptr %0, i64 %58
  %60 = load <4 x float>, ptr %59, align 4, !tbaa !13
  %61 = tail call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %60, <4 x float> %54, <4 x float> %56)
  %62 = getelementptr inbounds nuw float, ptr %1, i64 %58
  store <4 x float> %61, ptr %62, align 4, !tbaa !13
  %63 = add nuw i64 %58, 4
  %64 = icmp eq i64 %63, %52
  br i1 %64, label %65, label %57, !llvm.loop !22

65:                                               ; preds = %57
  %66 = icmp eq i64 %52, %10
  br i1 %66, label %67, label %15

.loopexit:                                        ; preds = %68
  br label %67

67:                                               ; preds = %.loopexit, %65, %45, %5
  ret void

68:                                               ; preds = %68, %15
  %69 = phi i64 [ %74, %68 ], [ %16, %15 ]
  %70 = getelementptr inbounds nuw float, ptr %0, i64 %69
  %71 = load float, ptr %70, align 4, !tbaa !13
  %72 = tail call float @llvm.fmuladd.f32(float %71, float %3, float %4)
  %73 = getelementptr inbounds nuw float, ptr %1, i64 %69
  store float %72, ptr %73, align 4, !tbaa !13
  %74 = add nuw nsw i64 %69, 1
  %75 = icmp eq i64 %74, %10
  br i1 %75, label %.loopexit, label %68, !llvm.loop !23
}

; Function Attrs: nofree norecurse nosync nounwind ssp memory(argmem: readwrite) uwtable(sync)
define void @test_elementwise(ptr noundef readonly captures(none) %0, ptr noundef readonly captures(none) %1, ptr noundef writeonly captures(none) %2, i32 noundef %3) local_unnamed_addr #4 {
  %5 = ptrtoint ptr %1 to i64
  %6 = ptrtoint ptr %0 to i64
  %7 = ptrtoint ptr %2 to i64
  %8 = icmp sgt i32 %3, 0
  br i1 %8, label %9, label %82

9:                                                ; preds = %4
  %10 = zext nneg i32 %3 to i64
  %11 = icmp ult i32 %3, 4
  br i1 %11, label %12, label %14

12:                                               ; preds = %80, %62, %14, %9
  %13 = phi i64 [ 0, %9 ], [ 0, %14 ], [ %23, %62 ], [ %67, %80 ]
  br label %83

14:                                               ; preds = %9
  %15 = sub i64 %7, %6
  %16 = icmp ult i64 %15, 64
  %17 = sub i64 %7, %5
  %18 = icmp ult i64 %17, 64
  %19 = or i1 %16, %18
  br i1 %19, label %12, label %20

20:                                               ; preds = %14
  %21 = icmp ult i32 %3, 16
  br i1 %21, label %65, label %22

22:                                               ; preds = %20
  %23 = and i64 %10, 2147483632
  br label %24

24:                                               ; preds = %24, %22
  %25 = phi i64 [ 0, %22 ], [ %58, %24 ]
  %26 = getelementptr inbounds nuw float, ptr %0, i64 %25
  %27 = getelementptr inbounds nuw i8, ptr %26, i64 16
  %28 = getelementptr inbounds nuw i8, ptr %26, i64 32
  %29 = getelementptr inbounds nuw i8, ptr %26, i64 48
  %30 = load <4 x float>, ptr %26, align 4, !tbaa !13
  %31 = load <4 x float>, ptr %27, align 4, !tbaa !13
  %32 = load <4 x float>, ptr %28, align 4, !tbaa !13
  %33 = load <4 x float>, ptr %29, align 4, !tbaa !13
  %34 = getelementptr inbounds nuw float, ptr %1, i64 %25
  %35 = getelementptr inbounds nuw i8, ptr %34, i64 16
  %36 = getelementptr inbounds nuw i8, ptr %34, i64 32
  %37 = getelementptr inbounds nuw i8, ptr %34, i64 48
  %38 = load <4 x float>, ptr %34, align 4, !tbaa !13
  %39 = load <4 x float>, ptr %35, align 4, !tbaa !13
  %40 = load <4 x float>, ptr %36, align 4, !tbaa !13
  %41 = load <4 x float>, ptr %37, align 4, !tbaa !13
  %42 = fadd <4 x float> %30, %38
  %43 = fadd <4 x float> %31, %39
  %44 = fadd <4 x float> %32, %40
  %45 = fadd <4 x float> %33, %41
  %46 = fsub <4 x float> %30, %38
  %47 = fsub <4 x float> %31, %39
  %48 = fsub <4 x float> %32, %40
  %49 = fsub <4 x float> %33, %41
  %50 = fmul <4 x float> %42, %46
  %51 = fmul <4 x float> %43, %47
  %52 = fmul <4 x float> %44, %48
  %53 = fmul <4 x float> %45, %49
  %54 = getelementptr inbounds nuw float, ptr %2, i64 %25
  %55 = getelementptr inbounds nuw i8, ptr %54, i64 16
  %56 = getelementptr inbounds nuw i8, ptr %54, i64 32
  %57 = getelementptr inbounds nuw i8, ptr %54, i64 48
  store <4 x float> %50, ptr %54, align 4, !tbaa !13
  store <4 x float> %51, ptr %55, align 4, !tbaa !13
  store <4 x float> %52, ptr %56, align 4, !tbaa !13
  store <4 x float> %53, ptr %57, align 4, !tbaa !13
  %58 = add nuw i64 %25, 16
  %59 = icmp eq i64 %58, %23
  br i1 %59, label %60, label %24, !llvm.loop !24

60:                                               ; preds = %24
  %61 = icmp eq i64 %23, %10
  br i1 %61, label %82, label %62

62:                                               ; preds = %60
  %63 = and i64 %10, 12
  %64 = icmp eq i64 %63, 0
  br i1 %64, label %12, label %65

65:                                               ; preds = %62, %20
  %66 = phi i64 [ %23, %62 ], [ 0, %20 ]
  %67 = and i64 %10, 2147483644
  br label %68

68:                                               ; preds = %68, %65
  %69 = phi i64 [ %66, %65 ], [ %78, %68 ]
  %70 = getelementptr inbounds nuw float, ptr %0, i64 %69
  %71 = load <4 x float>, ptr %70, align 4, !tbaa !13
  %72 = getelementptr inbounds nuw float, ptr %1, i64 %69
  %73 = load <4 x float>, ptr %72, align 4, !tbaa !13
  %74 = fadd <4 x float> %71, %73
  %75 = fsub <4 x float> %71, %73
  %76 = fmul <4 x float> %74, %75
  %77 = getelementptr inbounds nuw float, ptr %2, i64 %69
  store <4 x float> %76, ptr %77, align 4, !tbaa !13
  %78 = add nuw i64 %69, 4
  %79 = icmp eq i64 %78, %67
  br i1 %79, label %80, label %68, !llvm.loop !25

80:                                               ; preds = %68
  %81 = icmp eq i64 %67, %10
  br i1 %81, label %82, label %12

.loopexit:                                        ; preds = %83
  br label %82

82:                                               ; preds = %.loopexit, %80, %60, %4
  ret void

83:                                               ; preds = %83, %12
  %84 = phi i64 [ %93, %83 ], [ %13, %12 ]
  %85 = getelementptr inbounds nuw float, ptr %0, i64 %84
  %86 = load float, ptr %85, align 4, !tbaa !13
  %87 = getelementptr inbounds nuw float, ptr %1, i64 %84
  %88 = load float, ptr %87, align 4, !tbaa !13
  %89 = fadd float %86, %88
  %90 = fsub float %86, %88
  %91 = fmul float %89, %90
  %92 = getelementptr inbounds nuw float, ptr %2, i64 %84
  store float %91, ptr %92, align 4, !tbaa !13
  %93 = add nuw nsw i64 %84, 1
  %94 = icmp eq i64 %93, %10
  br i1 %94, label %.loopexit, label %83, !llvm.loop !26
}

; Function Attrs: nounwind ssp uwtable(sync)
define noundef i32 @main(i32 noundef %0, ptr noundef readnone captures(none) %1) local_unnamed_addr #5 {
  %3 = alloca %struct.timeval, align 8
  %4 = alloca %struct.timeval, align 8
  %5 = alloca %struct.timeval, align 8
  %6 = alloca %struct.timeval, align 8
  %7 = alloca %struct.timeval, align 8
  %8 = alloca %struct.timeval, align 8
  %9 = tail call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str, i32 noundef 50000000)
  %10 = tail call dereferenceable_or_null(200000000) ptr @malloc(i64 noundef 200000000) #9
  %11 = tail call dereferenceable_or_null(200000000) ptr @malloc(i64 noundef 200000000) #9
  %12 = tail call dereferenceable_or_null(200000000) ptr @malloc(i64 noundef 200000000) #9
  br label %13

13:                                               ; preds = %13, %2
  %14 = phi i64 [ 0, %2 ], [ %48, %13 ]
  %15 = phi <4 x i32> [ <i32 0, i32 1, i32 2, i32 3>, %2 ], [ %49, %13 ]
  %16 = phi <4 x i32> [ <i32 0, i32 1, i32 2, i32 3>, %2 ], [ %50, %13 ]
  %17 = add <4 x i32> %15, splat (i32 4)
  %18 = add <4 x i32> %15, splat (i32 8)
  %19 = add <4 x i32> %15, splat (i32 12)
  %20 = uitofp nneg <4 x i32> %15 to <4 x float>
  %21 = uitofp nneg <4 x i32> %17 to <4 x float>
  %22 = uitofp nneg <4 x i32> %18 to <4 x float>
  %23 = uitofp nneg <4 x i32> %19 to <4 x float>
  %24 = fdiv <4 x float> %20, splat (float 5.000000e+07)
  %25 = fdiv <4 x float> %21, splat (float 5.000000e+07)
  %26 = fdiv <4 x float> %22, splat (float 5.000000e+07)
  %27 = fdiv <4 x float> %23, splat (float 5.000000e+07)
  %28 = getelementptr inbounds nuw float, ptr %10, i64 %14
  %29 = getelementptr inbounds nuw i8, ptr %28, i64 16
  %30 = getelementptr inbounds nuw i8, ptr %28, i64 32
  %31 = getelementptr inbounds nuw i8, ptr %28, i64 48
  store <4 x float> %24, ptr %28, align 4, !tbaa !13
  store <4 x float> %25, ptr %29, align 4, !tbaa !13
  store <4 x float> %26, ptr %30, align 4, !tbaa !13
  store <4 x float> %27, ptr %31, align 4, !tbaa !13
  %32 = sub <4 x i32> splat (i32 50000000), %16
  %33 = sub <4 x i32> splat (i32 49999996), %16
  %34 = sub <4 x i32> splat (i32 49999992), %16
  %35 = sub <4 x i32> splat (i32 49999988), %16
  %36 = uitofp nneg <4 x i32> %32 to <4 x float>
  %37 = uitofp nneg <4 x i32> %33 to <4 x float>
  %38 = uitofp nneg <4 x i32> %34 to <4 x float>
  %39 = uitofp nneg <4 x i32> %35 to <4 x float>
  %40 = fdiv <4 x float> %36, splat (float 5.000000e+07)
  %41 = fdiv <4 x float> %37, splat (float 5.000000e+07)
  %42 = fdiv <4 x float> %38, splat (float 5.000000e+07)
  %43 = fdiv <4 x float> %39, splat (float 5.000000e+07)
  %44 = getelementptr inbounds nuw float, ptr %11, i64 %14
  %45 = getelementptr inbounds nuw i8, ptr %44, i64 16
  %46 = getelementptr inbounds nuw i8, ptr %44, i64 32
  %47 = getelementptr inbounds nuw i8, ptr %44, i64 48
  store <4 x float> %40, ptr %44, align 4, !tbaa !13
  store <4 x float> %41, ptr %45, align 4, !tbaa !13
  store <4 x float> %42, ptr %46, align 4, !tbaa !13
  store <4 x float> %43, ptr %47, align 4, !tbaa !13
  %48 = add nuw i64 %14, 16
  %49 = add <4 x i32> %15, splat (i32 16)
  %50 = add <4 x i32> %16, splat (i32 16)
  %51 = icmp eq i64 %48, 50000000
  br i1 %51, label %52, label %13, !llvm.loop !27

52:                                               ; preds = %13
  call void @llvm.lifetime.start.p0(i64 16, ptr nonnull %8) #8
  %53 = call i32 @gettimeofday(ptr noundef nonnull %8, ptr noundef null)
  %54 = load i64, ptr %8, align 8, !tbaa !6
  %55 = getelementptr inbounds nuw i8, ptr %8, i64 8
  %56 = load i32, ptr %55, align 8, !tbaa !12
  call void @llvm.lifetime.end.p0(i64 16, ptr nonnull %8) #8
  br label %57

57:                                               ; preds = %57, %52
  %58 = phi i64 [ 0, %52 ], [ %87, %57 ]
  %59 = getelementptr inbounds nuw float, ptr %10, i64 %58
  %60 = getelementptr inbounds nuw i8, ptr %59, i64 16
  %61 = getelementptr inbounds nuw i8, ptr %59, i64 32
  %62 = getelementptr inbounds nuw i8, ptr %59, i64 48
  %63 = load <4 x float>, ptr %59, align 4, !tbaa !13
  %64 = load <4 x float>, ptr %60, align 4, !tbaa !13
  %65 = load <4 x float>, ptr %61, align 4, !tbaa !13
  %66 = load <4 x float>, ptr %62, align 4, !tbaa !13
  %67 = getelementptr inbounds nuw float, ptr %11, i64 %58
  %68 = getelementptr inbounds nuw i8, ptr %67, i64 16
  %69 = getelementptr inbounds nuw i8, ptr %67, i64 32
  %70 = getelementptr inbounds nuw i8, ptr %67, i64 48
  %71 = load <4 x float>, ptr %67, align 4, !tbaa !13
  %72 = load <4 x float>, ptr %68, align 4, !tbaa !13
  %73 = load <4 x float>, ptr %69, align 4, !tbaa !13
  %74 = load <4 x float>, ptr %70, align 4, !tbaa !13
  %75 = fmul <4 x float> %71, splat (float 3.000000e+00)
  %76 = fmul <4 x float> %72, splat (float 3.000000e+00)
  %77 = fmul <4 x float> %73, splat (float 3.000000e+00)
  %78 = fmul <4 x float> %74, splat (float 3.000000e+00)
  %79 = tail call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %63, <4 x float> splat (float 2.000000e+00), <4 x float> %75)
  %80 = tail call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %64, <4 x float> splat (float 2.000000e+00), <4 x float> %76)
  %81 = tail call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %65, <4 x float> splat (float 2.000000e+00), <4 x float> %77)
  %82 = tail call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %66, <4 x float> splat (float 2.000000e+00), <4 x float> %78)
  %83 = getelementptr inbounds nuw float, ptr %12, i64 %58
  %84 = getelementptr inbounds nuw i8, ptr %83, i64 16
  %85 = getelementptr inbounds nuw i8, ptr %83, i64 32
  %86 = getelementptr inbounds nuw i8, ptr %83, i64 48
  store <4 x float> %79, ptr %83, align 4, !tbaa !13
  store <4 x float> %80, ptr %84, align 4, !tbaa !13
  store <4 x float> %81, ptr %85, align 4, !tbaa !13
  store <4 x float> %82, ptr %86, align 4, !tbaa !13
  %87 = add nuw i64 %58, 16
  %88 = icmp eq i64 %87, 50000000
  br i1 %88, label %89, label %57, !llvm.loop !28

89:                                               ; preds = %57
  %90 = sitofp i64 %54 to double
  %91 = sitofp i32 %56 to double
  %92 = tail call double @llvm.fmuladd.f64(double %91, double 0x3EB0C6F7A0B5ED8D, double %90)
  call void @llvm.lifetime.start.p0(i64 16, ptr nonnull %7) #8
  %93 = call i32 @gettimeofday(ptr noundef nonnull %7, ptr noundef null)
  %94 = load i64, ptr %7, align 8, !tbaa !6
  %95 = sitofp i64 %94 to double
  %96 = getelementptr inbounds nuw i8, ptr %7, i64 8
  %97 = load i32, ptr %96, align 8, !tbaa !12
  %98 = sitofp i32 %97 to double
  %99 = tail call double @llvm.fmuladd.f64(double %98, double 0x3EB0C6F7A0B5ED8D, double %95)
  call void @llvm.lifetime.end.p0(i64 16, ptr nonnull %7) #8
  %100 = fsub double %99, %92
  %101 = tail call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.1, double noundef %100)
  call void @llvm.lifetime.start.p0(i64 16, ptr nonnull %6) #8
  %102 = call i32 @gettimeofday(ptr noundef nonnull %6, ptr noundef null)
  %103 = load i64, ptr %6, align 8, !tbaa !6
  %104 = getelementptr inbounds nuw i8, ptr %6, i64 8
  %105 = load i32, ptr %104, align 8, !tbaa !12
  call void @llvm.lifetime.end.p0(i64 16, ptr nonnull %6) #8
  br label %106

106:                                              ; preds = %106, %89
  %107 = phi i64 [ 0, %89 ], [ %124, %106 ]
  %108 = getelementptr inbounds nuw float, ptr %10, i64 %107
  %109 = getelementptr inbounds nuw i8, ptr %108, i64 16
  %110 = getelementptr inbounds nuw i8, ptr %108, i64 32
  %111 = getelementptr inbounds nuw i8, ptr %108, i64 48
  %112 = load <4 x float>, ptr %108, align 4, !tbaa !13
  %113 = load <4 x float>, ptr %109, align 4, !tbaa !13
  %114 = load <4 x float>, ptr %110, align 4, !tbaa !13
  %115 = load <4 x float>, ptr %111, align 4, !tbaa !13
  %116 = tail call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %112, <4 x float> splat (float 2.500000e+00), <4 x float> splat (float 1.000000e+00))
  %117 = tail call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %113, <4 x float> splat (float 2.500000e+00), <4 x float> splat (float 1.000000e+00))
  %118 = tail call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %114, <4 x float> splat (float 2.500000e+00), <4 x float> splat (float 1.000000e+00))
  %119 = tail call <4 x float> @llvm.fmuladd.v4f32(<4 x float> %115, <4 x float> splat (float 2.500000e+00), <4 x float> splat (float 1.000000e+00))
  %120 = getelementptr inbounds nuw float, ptr %12, i64 %107
  %121 = getelementptr inbounds nuw i8, ptr %120, i64 16
  %122 = getelementptr inbounds nuw i8, ptr %120, i64 32
  %123 = getelementptr inbounds nuw i8, ptr %120, i64 48
  store <4 x float> %116, ptr %120, align 4, !tbaa !13
  store <4 x float> %117, ptr %121, align 4, !tbaa !13
  store <4 x float> %118, ptr %122, align 4, !tbaa !13
  store <4 x float> %119, ptr %123, align 4, !tbaa !13
  %124 = add nuw i64 %107, 16
  %125 = icmp eq i64 %124, 50000000
  br i1 %125, label %126, label %106, !llvm.loop !29

126:                                              ; preds = %106
  %127 = sitofp i64 %103 to double
  %128 = sitofp i32 %105 to double
  %129 = tail call double @llvm.fmuladd.f64(double %128, double 0x3EB0C6F7A0B5ED8D, double %127)
  call void @llvm.lifetime.start.p0(i64 16, ptr nonnull %5) #8
  %130 = call i32 @gettimeofday(ptr noundef nonnull %5, ptr noundef null)
  %131 = load i64, ptr %5, align 8, !tbaa !6
  %132 = sitofp i64 %131 to double
  %133 = getelementptr inbounds nuw i8, ptr %5, i64 8
  %134 = load i32, ptr %133, align 8, !tbaa !12
  %135 = sitofp i32 %134 to double
  %136 = tail call double @llvm.fmuladd.f64(double %135, double 0x3EB0C6F7A0B5ED8D, double %132)
  call void @llvm.lifetime.end.p0(i64 16, ptr nonnull %5) #8
  %137 = fsub double %136, %129
  %138 = tail call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.2, double noundef %137)
  call void @llvm.lifetime.start.p0(i64 16, ptr nonnull %4) #8
  %139 = call i32 @gettimeofday(ptr noundef nonnull %4, ptr noundef null)
  %140 = load i64, ptr %4, align 8, !tbaa !6
  %141 = getelementptr inbounds nuw i8, ptr %4, i64 8
  %142 = load i32, ptr %141, align 8, !tbaa !12
  call void @llvm.lifetime.end.p0(i64 16, ptr nonnull %4) #8
  br label %143

143:                                              ; preds = %143, %126
  %144 = phi i64 [ 0, %126 ], [ %177, %143 ]
  %145 = getelementptr inbounds nuw float, ptr %10, i64 %144
  %146 = getelementptr inbounds nuw i8, ptr %145, i64 16
  %147 = getelementptr inbounds nuw i8, ptr %145, i64 32
  %148 = getelementptr inbounds nuw i8, ptr %145, i64 48
  %149 = load <4 x float>, ptr %145, align 4, !tbaa !13
  %150 = load <4 x float>, ptr %146, align 4, !tbaa !13
  %151 = load <4 x float>, ptr %147, align 4, !tbaa !13
  %152 = load <4 x float>, ptr %148, align 4, !tbaa !13
  %153 = getelementptr inbounds nuw float, ptr %11, i64 %144
  %154 = getelementptr inbounds nuw i8, ptr %153, i64 16
  %155 = getelementptr inbounds nuw i8, ptr %153, i64 32
  %156 = getelementptr inbounds nuw i8, ptr %153, i64 48
  %157 = load <4 x float>, ptr %153, align 4, !tbaa !13
  %158 = load <4 x float>, ptr %154, align 4, !tbaa !13
  %159 = load <4 x float>, ptr %155, align 4, !tbaa !13
  %160 = load <4 x float>, ptr %156, align 4, !tbaa !13
  %161 = fadd <4 x float> %149, %157
  %162 = fadd <4 x float> %150, %158
  %163 = fadd <4 x float> %151, %159
  %164 = fadd <4 x float> %152, %160
  %165 = fsub <4 x float> %149, %157
  %166 = fsub <4 x float> %150, %158
  %167 = fsub <4 x float> %151, %159
  %168 = fsub <4 x float> %152, %160
  %169 = fmul <4 x float> %161, %165
  %170 = fmul <4 x float> %162, %166
  %171 = fmul <4 x float> %163, %167
  %172 = fmul <4 x float> %164, %168
  %173 = getelementptr inbounds nuw float, ptr %12, i64 %144
  %174 = getelementptr inbounds nuw i8, ptr %173, i64 16
  %175 = getelementptr inbounds nuw i8, ptr %173, i64 32
  %176 = getelementptr inbounds nuw i8, ptr %173, i64 48
  store <4 x float> %169, ptr %173, align 4, !tbaa !13
  store <4 x float> %170, ptr %174, align 4, !tbaa !13
  store <4 x float> %171, ptr %175, align 4, !tbaa !13
  store <4 x float> %172, ptr %176, align 4, !tbaa !13
  %177 = add nuw i64 %144, 16
  %178 = icmp eq i64 %177, 50000000
  br i1 %178, label %179, label %143, !llvm.loop !30

179:                                              ; preds = %143
  %180 = sitofp i32 %142 to double
  %181 = sitofp i64 %140 to double
  %182 = tail call double @llvm.fmuladd.f64(double %180, double 0x3EB0C6F7A0B5ED8D, double %181)
  call void @llvm.lifetime.start.p0(i64 16, ptr nonnull %3) #8
  %183 = call i32 @gettimeofday(ptr noundef nonnull %3, ptr noundef null)
  %184 = load i64, ptr %3, align 8, !tbaa !6
  %185 = sitofp i64 %184 to double
  %186 = getelementptr inbounds nuw i8, ptr %3, i64 8
  %187 = load i32, ptr %186, align 8, !tbaa !12
  %188 = sitofp i32 %187 to double
  %189 = tail call double @llvm.fmuladd.f64(double %188, double 0x3EB0C6F7A0B5ED8D, double %185)
  call void @llvm.lifetime.end.p0(i64 16, ptr nonnull %3) #8
  %190 = fsub double %189, %182
  %191 = tail call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.3, double noundef %190)
  %192 = load float, ptr %12, align 4, !tbaa !13
  %193 = fpext float %192 to double
  %194 = getelementptr inbounds nuw i8, ptr %12, i64 100000000
  %195 = load float, ptr %194, align 4, !tbaa !13
  %196 = fpext float %195 to double
  %197 = getelementptr inbounds nuw i8, ptr %12, i64 199999996
  %198 = load float, ptr %197, align 4, !tbaa !13
  %199 = fpext float %198 to double
  %200 = tail call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.4, double noundef %193, i32 noundef 25000000, double noundef %196, i32 noundef 49999999, double noundef %199)
  tail call void @free(ptr noundef nonnull %10)
  tail call void @free(ptr noundef nonnull %11)
  tail call void @free(ptr noundef nonnull %12)
  ret i32 0
}

; Function Attrs: nofree nounwind
declare noundef i32 @printf(ptr noundef readonly captures(none), ...) local_unnamed_addr #2

; Function Attrs: mustprogress nofree nounwind willreturn allockind("alloc,uninitialized") allocsize(0) memory(inaccessiblemem: readwrite)
declare noalias noundef ptr @malloc(i64 noundef) local_unnamed_addr #6

; Function Attrs: mustprogress nounwind willreturn allockind("free") memory(argmem: readwrite, inaccessiblemem: readwrite)
declare void @free(ptr allocptr noundef captures(none)) local_unnamed_addr #7

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare <4 x float> @llvm.fmuladd.v4f32(<4 x float>, <4 x float>, <4 x float>) #3

attributes #0 = { nofree nounwind ssp uwtable(sync) "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+ccpp,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a" }
attributes #1 = { nocallback nofree nosync nounwind willreturn memory(argmem: readwrite) }
attributes #2 = { nofree nounwind "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+ccpp,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a" }
attributes #3 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #4 = { nofree norecurse nosync nounwind ssp memory(argmem: readwrite) uwtable(sync) "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+ccpp,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a" }
attributes #5 = { nounwind ssp uwtable(sync) "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+ccpp,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a" }
attributes #6 = { mustprogress nofree nounwind willreturn allockind("alloc,uninitialized") allocsize(0) memory(inaccessiblemem: readwrite) "alloc-family"="malloc" "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+ccpp,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a" }
attributes #7 = { mustprogress nounwind willreturn allockind("free") memory(argmem: readwrite, inaccessiblemem: readwrite) "alloc-family"="malloc" "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+ccpp,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a" }
attributes #8 = { nounwind }
attributes #9 = { allocsize(0) }

!llvm.module.flags = !{!0, !1, !2, !3, !4}
!llvm.ident = !{!5}

!0 = !{i32 2, !"SDK Version", [2 x i32] [i32 15, i32 2]}
!1 = !{i32 1, !"wchar_size", i32 4}
!2 = !{i32 8, !"PIC Level", i32 2}
!3 = !{i32 7, !"uwtable", i32 1}
!4 = !{i32 7, !"frame-pointer", i32 1}
!5 = !{!"Homebrew clang version 21.1.2"}
!6 = !{!7, !8, i64 0}
!7 = !{!"timeval", !8, i64 0, !11, i64 8}
!8 = !{!"long", !9, i64 0}
!9 = !{!"omnipotent char", !10, i64 0}
!10 = !{!"Simple C/C++ TBAA"}
!11 = !{!"int", !9, i64 0}
!12 = !{!7, !11, i64 8}
!13 = !{!14, !14, i64 0}
!14 = !{!"float", !9, i64 0}
!15 = distinct !{!15, !16, !17, !18}
!16 = !{!"llvm.loop.mustprogress"}
!17 = !{!"llvm.loop.isvectorized", i32 1}
!18 = !{!"llvm.loop.unroll.runtime.disable"}
!19 = distinct !{!19, !16, !17, !18}
!20 = distinct !{!20, !16, !17}
!21 = distinct !{!21, !16, !17, !18}
!22 = distinct !{!22, !16, !17, !18}
!23 = distinct !{!23, !16, !17}
!24 = distinct !{!24, !16, !17, !18}
!25 = distinct !{!25, !16, !17, !18}
!26 = distinct !{!26, !16, !17}
!27 = distinct !{!27, !16, !17, !18}
!28 = distinct !{!28, !16, !17, !18}
!29 = distinct !{!29, !16, !17, !18}
!30 = distinct !{!30, !16, !17, !18}
