; ModuleID = 'output/verify.ll'
source_filename = "tests/verify_correctness.c"
target datalayout = "e-m:o-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-n32:64-S128-Fn32"
target triple = "arm64-apple-macosx15.0.0"

@.str = private unnamed_addr constant [52 x i8] c"ERROR in %s at index %d: %.6f != %.6f (diff: %.6e)\0A\00", align 1
@.str.2 = private unnamed_addr constant [26 x i8] c"Array size: %d elements\0A\0A\00", align 1
@.str.4 = private unnamed_addr constant [10 x i8] c"array_add\00", align 1
@.str.5 = private unnamed_addr constant [27 x i8] c"  Result: %s (%d errors)\0A\0A\00", align 1
@.str.6 = private unnamed_addr constant [5 x i8] c"PASS\00", align 1
@.str.7 = private unnamed_addr constant [5 x i8] c"FAIL\00", align 1
@.str.9 = private unnamed_addr constant [12 x i8] c"array_scale\00", align 1
@.str.11 = private unnamed_addr constant [15 x i8] c"array_multiply\00", align 1
@.str.14 = private unnamed_addr constant [29 x i8] c"\E2\9C\97 FAILED: %d total errors\0A\00", align 1
@str = private unnamed_addr constant [38 x i8] c"=== Correctness Verification Test ===\00", align 1
@str.15 = private unnamed_addr constant [23 x i8] c"Test 1: Array Addition\00", align 1
@str.16 = private unnamed_addr constant [22 x i8] c"Test 2: Array Scaling\00", align 1
@str.17 = private unnamed_addr constant [30 x i8] c"Test 3: Element-wise Multiply\00", align 1
@str.19 = private unnamed_addr constant [21 x i8] c"\E2\9C\93 ALL TESTS PASSED\00", align 1
@str.20 = private unnamed_addr constant [34 x i8] c"=================================\00", align 1

; Function Attrs: nofree norecurse nosync nounwind ssp memory(argmem: readwrite) uwtable(sync)
define void @array_add(ptr noundef readonly captures(none) %0, ptr noundef readonly captures(none) %1, ptr noundef writeonly captures(none) %2, i32 noundef %3) local_unnamed_addr #0 {
  %5 = ptrtoint ptr %1 to i64
  %6 = ptrtoint ptr %0 to i64
  %7 = ptrtoint ptr %2 to i64
  %8 = icmp sgt i32 %3, 0
  br i1 %8, label %9, label %72

9:                                                ; preds = %4
  %10 = zext nneg i32 %3 to i64
  %11 = icmp ult i32 %3, 4
  br i1 %11, label %12, label %14

12:                                               ; preds = %70, %54, %14, %9
  %13 = phi i64 [ 0, %9 ], [ 0, %14 ], [ %23, %54 ], [ %59, %70 ]
  br label %73

14:                                               ; preds = %9
  %15 = sub i64 %7, %6
  %16 = icmp ult i64 %15, 64
  %17 = sub i64 %7, %5
  %18 = icmp ult i64 %17, 64
  %19 = or i1 %16, %18
  br i1 %19, label %12, label %20

20:                                               ; preds = %14
  %21 = icmp ult i32 %3, 16
  br i1 %21, label %57, label %22

22:                                               ; preds = %20
  %23 = and i64 %10, 2147483632
  br label %24

24:                                               ; preds = %24, %22
  %25 = phi i64 [ 0, %22 ], [ %50, %24 ]
  %26 = getelementptr inbounds nuw float, ptr %0, i64 %25
  %27 = getelementptr inbounds nuw i8, ptr %26, i64 16
  %28 = getelementptr inbounds nuw i8, ptr %26, i64 32
  %29 = getelementptr inbounds nuw i8, ptr %26, i64 48
  %30 = load <4 x float>, ptr %26, align 4, !tbaa !6
  %31 = load <4 x float>, ptr %27, align 4, !tbaa !6
  %32 = load <4 x float>, ptr %28, align 4, !tbaa !6
  %33 = load <4 x float>, ptr %29, align 4, !tbaa !6
  %34 = getelementptr inbounds nuw float, ptr %1, i64 %25
  %35 = getelementptr inbounds nuw i8, ptr %34, i64 16
  %36 = getelementptr inbounds nuw i8, ptr %34, i64 32
  %37 = getelementptr inbounds nuw i8, ptr %34, i64 48
  %38 = load <4 x float>, ptr %34, align 4, !tbaa !6
  %39 = load <4 x float>, ptr %35, align 4, !tbaa !6
  %40 = load <4 x float>, ptr %36, align 4, !tbaa !6
  %41 = load <4 x float>, ptr %37, align 4, !tbaa !6
  %42 = fadd <4 x float> %30, %38
  %43 = fadd <4 x float> %31, %39
  %44 = fadd <4 x float> %32, %40
  %45 = fadd <4 x float> %33, %41
  %46 = getelementptr inbounds nuw float, ptr %2, i64 %25
  %47 = getelementptr inbounds nuw i8, ptr %46, i64 16
  %48 = getelementptr inbounds nuw i8, ptr %46, i64 32
  %49 = getelementptr inbounds nuw i8, ptr %46, i64 48
  store <4 x float> %42, ptr %46, align 4, !tbaa !6
  store <4 x float> %43, ptr %47, align 4, !tbaa !6
  store <4 x float> %44, ptr %48, align 4, !tbaa !6
  store <4 x float> %45, ptr %49, align 4, !tbaa !6
  %50 = add nuw i64 %25, 16
  %51 = icmp eq i64 %50, %23
  br i1 %51, label %52, label %24, !llvm.loop !10

52:                                               ; preds = %24
  %53 = icmp eq i64 %23, %10
  br i1 %53, label %72, label %54

54:                                               ; preds = %52
  %55 = and i64 %10, 12
  %56 = icmp eq i64 %55, 0
  br i1 %56, label %12, label %57

57:                                               ; preds = %54, %20
  %58 = phi i64 [ %23, %54 ], [ 0, %20 ]
  %59 = and i64 %10, 2147483644
  br label %60

60:                                               ; preds = %60, %57
  %61 = phi i64 [ %58, %57 ], [ %68, %60 ]
  %62 = getelementptr inbounds nuw float, ptr %0, i64 %61
  %63 = load <4 x float>, ptr %62, align 4, !tbaa !6
  %64 = getelementptr inbounds nuw float, ptr %1, i64 %61
  %65 = load <4 x float>, ptr %64, align 4, !tbaa !6
  %66 = fadd <4 x float> %63, %65
  %67 = getelementptr inbounds nuw float, ptr %2, i64 %61
  store <4 x float> %66, ptr %67, align 4, !tbaa !6
  %68 = add nuw i64 %61, 4
  %69 = icmp eq i64 %68, %59
  br i1 %69, label %70, label %60, !llvm.loop !14

70:                                               ; preds = %60
  %71 = icmp eq i64 %59, %10
  br i1 %71, label %72, label %12

.loopexit:                                        ; preds = %73
  br label %72

72:                                               ; preds = %.loopexit, %70, %52, %4
  ret void

73:                                               ; preds = %73, %12
  %74 = phi i64 [ %81, %73 ], [ %13, %12 ]
  %75 = getelementptr inbounds nuw float, ptr %0, i64 %74
  %76 = load float, ptr %75, align 4, !tbaa !6
  %77 = getelementptr inbounds nuw float, ptr %1, i64 %74
  %78 = load float, ptr %77, align 4, !tbaa !6
  %79 = fadd float %76, %78
  %80 = getelementptr inbounds nuw float, ptr %2, i64 %74
  store float %79, ptr %80, align 4, !tbaa !6
  %81 = add nuw nsw i64 %74, 1
  %82 = icmp eq i64 %81, %10
  br i1 %82, label %.loopexit, label %73, !llvm.loop !15
}

; Function Attrs: nofree norecurse nosync nounwind ssp memory(argmem: readwrite) uwtable(sync)
define void @array_scale(ptr noundef readonly captures(none) %0, ptr noundef writeonly captures(none) %1, i32 noundef %2, float noundef %3) local_unnamed_addr #0 {
  %5 = icmp sgt i32 %2, 0
  br i1 %5, label %6, label %62

6:                                                ; preds = %4
  %7 = ptrtoint ptr %1 to i64
  %8 = ptrtoint ptr %0 to i64
  %9 = zext nneg i32 %2 to i64
  %10 = icmp ult i32 %2, 4
  %11 = sub i64 %7, %8
  %12 = icmp ult i64 %11, 64
  %13 = or i1 %10, %12
  br i1 %13, label %14, label %16

14:                                               ; preds = %60, %44, %6
  %15 = phi i64 [ 0, %6 ], [ %19, %44 ], [ %49, %60 ]
  br label %63

16:                                               ; preds = %6
  %17 = icmp ult i32 %2, 16
  br i1 %17, label %47, label %18

18:                                               ; preds = %16
  %19 = and i64 %9, 2147483632
  %20 = insertelement <4 x float> poison, float %3, i64 0
  %21 = shufflevector <4 x float> %20, <4 x float> poison, <4 x i32> zeroinitializer
  br label %22

22:                                               ; preds = %22, %18
  %23 = phi i64 [ 0, %18 ], [ %40, %22 ]
  %24 = getelementptr inbounds nuw float, ptr %0, i64 %23
  %25 = getelementptr inbounds nuw i8, ptr %24, i64 16
  %26 = getelementptr inbounds nuw i8, ptr %24, i64 32
  %27 = getelementptr inbounds nuw i8, ptr %24, i64 48
  %28 = load <4 x float>, ptr %24, align 4, !tbaa !6
  %29 = load <4 x float>, ptr %25, align 4, !tbaa !6
  %30 = load <4 x float>, ptr %26, align 4, !tbaa !6
  %31 = load <4 x float>, ptr %27, align 4, !tbaa !6
  %32 = fmul <4 x float> %21, %28
  %33 = fmul <4 x float> %21, %29
  %34 = fmul <4 x float> %21, %30
  %35 = fmul <4 x float> %21, %31
  %36 = getelementptr inbounds nuw float, ptr %1, i64 %23
  %37 = getelementptr inbounds nuw i8, ptr %36, i64 16
  %38 = getelementptr inbounds nuw i8, ptr %36, i64 32
  %39 = getelementptr inbounds nuw i8, ptr %36, i64 48
  store <4 x float> %32, ptr %36, align 4, !tbaa !6
  store <4 x float> %33, ptr %37, align 4, !tbaa !6
  store <4 x float> %34, ptr %38, align 4, !tbaa !6
  store <4 x float> %35, ptr %39, align 4, !tbaa !6
  %40 = add nuw i64 %23, 16
  %41 = icmp eq i64 %40, %19
  br i1 %41, label %42, label %22, !llvm.loop !16

42:                                               ; preds = %22
  %43 = icmp eq i64 %19, %9
  br i1 %43, label %62, label %44

44:                                               ; preds = %42
  %45 = and i64 %9, 12
  %46 = icmp eq i64 %45, 0
  br i1 %46, label %14, label %47

47:                                               ; preds = %44, %16
  %48 = phi i64 [ %19, %44 ], [ 0, %16 ]
  %49 = and i64 %9, 2147483644
  %50 = insertelement <4 x float> poison, float %3, i64 0
  %51 = shufflevector <4 x float> %50, <4 x float> poison, <4 x i32> zeroinitializer
  br label %52

52:                                               ; preds = %52, %47
  %53 = phi i64 [ %48, %47 ], [ %58, %52 ]
  %54 = getelementptr inbounds nuw float, ptr %0, i64 %53
  %55 = load <4 x float>, ptr %54, align 4, !tbaa !6
  %56 = fmul <4 x float> %51, %55
  %57 = getelementptr inbounds nuw float, ptr %1, i64 %53
  store <4 x float> %56, ptr %57, align 4, !tbaa !6
  %58 = add nuw i64 %53, 4
  %59 = icmp eq i64 %58, %49
  br i1 %59, label %60, label %52, !llvm.loop !17

60:                                               ; preds = %52
  %61 = icmp eq i64 %49, %9
  br i1 %61, label %62, label %14

.loopexit:                                        ; preds = %63
  br label %62

62:                                               ; preds = %.loopexit, %60, %42, %4
  ret void

63:                                               ; preds = %63, %14
  %64 = phi i64 [ %69, %63 ], [ %15, %14 ]
  %65 = getelementptr inbounds nuw float, ptr %0, i64 %64
  %66 = load float, ptr %65, align 4, !tbaa !6
  %67 = fmul float %3, %66
  %68 = getelementptr inbounds nuw float, ptr %1, i64 %64
  store float %67, ptr %68, align 4, !tbaa !6
  %69 = add nuw nsw i64 %64, 1
  %70 = icmp eq i64 %69, %9
  br i1 %70, label %.loopexit, label %63, !llvm.loop !18
}

; Function Attrs: nofree norecurse nosync nounwind ssp memory(argmem: readwrite) uwtable(sync)
define void @array_multiply(ptr noundef readonly captures(none) %0, ptr noundef readonly captures(none) %1, ptr noundef writeonly captures(none) %2, i32 noundef %3) local_unnamed_addr #0 {
  %5 = ptrtoint ptr %1 to i64
  %6 = ptrtoint ptr %0 to i64
  %7 = ptrtoint ptr %2 to i64
  %8 = icmp sgt i32 %3, 0
  br i1 %8, label %9, label %72

9:                                                ; preds = %4
  %10 = zext nneg i32 %3 to i64
  %11 = icmp ult i32 %3, 4
  br i1 %11, label %12, label %14

12:                                               ; preds = %70, %54, %14, %9
  %13 = phi i64 [ 0, %9 ], [ 0, %14 ], [ %23, %54 ], [ %59, %70 ]
  br label %73

14:                                               ; preds = %9
  %15 = sub i64 %7, %6
  %16 = icmp ult i64 %15, 64
  %17 = sub i64 %7, %5
  %18 = icmp ult i64 %17, 64
  %19 = or i1 %16, %18
  br i1 %19, label %12, label %20

20:                                               ; preds = %14
  %21 = icmp ult i32 %3, 16
  br i1 %21, label %57, label %22

22:                                               ; preds = %20
  %23 = and i64 %10, 2147483632
  br label %24

24:                                               ; preds = %24, %22
  %25 = phi i64 [ 0, %22 ], [ %50, %24 ]
  %26 = getelementptr inbounds nuw float, ptr %0, i64 %25
  %27 = getelementptr inbounds nuw i8, ptr %26, i64 16
  %28 = getelementptr inbounds nuw i8, ptr %26, i64 32
  %29 = getelementptr inbounds nuw i8, ptr %26, i64 48
  %30 = load <4 x float>, ptr %26, align 4, !tbaa !6
  %31 = load <4 x float>, ptr %27, align 4, !tbaa !6
  %32 = load <4 x float>, ptr %28, align 4, !tbaa !6
  %33 = load <4 x float>, ptr %29, align 4, !tbaa !6
  %34 = getelementptr inbounds nuw float, ptr %1, i64 %25
  %35 = getelementptr inbounds nuw i8, ptr %34, i64 16
  %36 = getelementptr inbounds nuw i8, ptr %34, i64 32
  %37 = getelementptr inbounds nuw i8, ptr %34, i64 48
  %38 = load <4 x float>, ptr %34, align 4, !tbaa !6
  %39 = load <4 x float>, ptr %35, align 4, !tbaa !6
  %40 = load <4 x float>, ptr %36, align 4, !tbaa !6
  %41 = load <4 x float>, ptr %37, align 4, !tbaa !6
  %42 = fmul <4 x float> %30, %38
  %43 = fmul <4 x float> %31, %39
  %44 = fmul <4 x float> %32, %40
  %45 = fmul <4 x float> %33, %41
  %46 = getelementptr inbounds nuw float, ptr %2, i64 %25
  %47 = getelementptr inbounds nuw i8, ptr %46, i64 16
  %48 = getelementptr inbounds nuw i8, ptr %46, i64 32
  %49 = getelementptr inbounds nuw i8, ptr %46, i64 48
  store <4 x float> %42, ptr %46, align 4, !tbaa !6
  store <4 x float> %43, ptr %47, align 4, !tbaa !6
  store <4 x float> %44, ptr %48, align 4, !tbaa !6
  store <4 x float> %45, ptr %49, align 4, !tbaa !6
  %50 = add nuw i64 %25, 16
  %51 = icmp eq i64 %50, %23
  br i1 %51, label %52, label %24, !llvm.loop !19

52:                                               ; preds = %24
  %53 = icmp eq i64 %23, %10
  br i1 %53, label %72, label %54

54:                                               ; preds = %52
  %55 = and i64 %10, 12
  %56 = icmp eq i64 %55, 0
  br i1 %56, label %12, label %57

57:                                               ; preds = %54, %20
  %58 = phi i64 [ %23, %54 ], [ 0, %20 ]
  %59 = and i64 %10, 2147483644
  br label %60

60:                                               ; preds = %60, %57
  %61 = phi i64 [ %58, %57 ], [ %68, %60 ]
  %62 = getelementptr inbounds nuw float, ptr %0, i64 %61
  %63 = load <4 x float>, ptr %62, align 4, !tbaa !6
  %64 = getelementptr inbounds nuw float, ptr %1, i64 %61
  %65 = load <4 x float>, ptr %64, align 4, !tbaa !6
  %66 = fmul <4 x float> %63, %65
  %67 = getelementptr inbounds nuw float, ptr %2, i64 %61
  store <4 x float> %66, ptr %67, align 4, !tbaa !6
  %68 = add nuw i64 %61, 4
  %69 = icmp eq i64 %68, %59
  br i1 %69, label %70, label %60, !llvm.loop !20

70:                                               ; preds = %60
  %71 = icmp eq i64 %59, %10
  br i1 %71, label %72, label %12

.loopexit:                                        ; preds = %73
  br label %72

72:                                               ; preds = %.loopexit, %70, %52, %4
  ret void

73:                                               ; preds = %73, %12
  %74 = phi i64 [ %81, %73 ], [ %13, %12 ]
  %75 = getelementptr inbounds nuw float, ptr %0, i64 %74
  %76 = load float, ptr %75, align 4, !tbaa !6
  %77 = getelementptr inbounds nuw float, ptr %1, i64 %74
  %78 = load float, ptr %77, align 4, !tbaa !6
  %79 = fmul float %76, %78
  %80 = getelementptr inbounds nuw float, ptr %2, i64 %74
  store float %79, ptr %80, align 4, !tbaa !6
  %81 = add nuw nsw i64 %74, 1
  %82 = icmp eq i64 %81, %10
  br i1 %82, label %.loopexit, label %73, !llvm.loop !21
}

; Function Attrs: nofree nounwind ssp uwtable(sync)
define i32 @compare_arrays(ptr noundef readonly captures(none) %0, ptr noundef readonly captures(none) %1, i32 noundef %2, ptr noundef %3) local_unnamed_addr #1 {
  %5 = icmp sgt i32 %2, 0
  br i1 %5, label %6, label %8

6:                                                ; preds = %4
  %7 = zext nneg i32 %2 to i64
  br label %10

.loopexit:                                        ; preds = %30
  br label %8

8:                                                ; preds = %.loopexit, %4
  %9 = phi i32 [ 0, %4 ], [ %31, %.loopexit ]
  ret i32 %9

10:                                               ; preds = %30, %6
  %11 = phi i64 [ 0, %6 ], [ %32, %30 ]
  %12 = phi i32 [ 0, %6 ], [ %31, %30 ]
  %13 = getelementptr inbounds nuw float, ptr %0, i64 %11
  %14 = load float, ptr %13, align 4, !tbaa !6
  %15 = getelementptr inbounds nuw float, ptr %1, i64 %11
  %16 = load float, ptr %15, align 4, !tbaa !6
  %17 = fsub float %14, %16
  %18 = tail call float @llvm.fabs.f32(float %17)
  %19 = fpext float %18 to double
  %20 = fcmp ogt double %19, 1.000000e-05
  br i1 %20, label %21, label %30

21:                                               ; preds = %10
  %22 = icmp slt i32 %12, 10
  br i1 %22, label %23, label %28

23:                                               ; preds = %21
  %24 = fpext float %14 to double
  %25 = fpext float %16 to double
  %26 = trunc nuw nsw i64 %11 to i32
  %27 = tail call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str, ptr noundef %3, i32 noundef %26, double noundef %24, double noundef %25, double noundef %19)
  br label %28

28:                                               ; preds = %23, %21
  %29 = add nsw i32 %12, 1
  br label %30

30:                                               ; preds = %28, %10
  %31 = phi i32 [ %29, %28 ], [ %12, %10 ]
  %32 = add nuw nsw i64 %11, 1
  %33 = icmp eq i64 %32, %7
  br i1 %33, label %.loopexit, label %10, !llvm.loop !22
}

; Function Attrs: nofree nounwind
declare noundef i32 @printf(ptr noundef readonly captures(none), ...) local_unnamed_addr #2

; Function Attrs: nounwind ssp uwtable(sync)
define range(i32 0, 2) i32 @main() local_unnamed_addr #3 {
  %1 = tail call i32 @puts(ptr nonnull dereferenceable(1) @str)
  %2 = tail call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.2, i32 noundef 10000000)
  %3 = tail call dereferenceable_or_null(40000000) ptr @malloc(i64 noundef 40000000) #9
  %4 = tail call dereferenceable_or_null(40000000) ptr @malloc(i64 noundef 40000000) #9
  %5 = tail call dereferenceable_or_null(40000000) ptr @malloc(i64 noundef 40000000) #9
  %6 = tail call dereferenceable_or_null(40000000) ptr @malloc(i64 noundef 40000000) #9
  br label %7

7:                                                ; preds = %7, %0
  %8 = phi i64 [ 0, %0 ], [ %41, %7 ]
  %9 = phi <4 x i32> [ <i32 0, i32 1, i32 2, i32 3>, %0 ], [ %42, %7 ]
  %10 = add <4 x i32> %9, splat (i32 4)
  %11 = add <4 x i32> %9, splat (i32 8)
  %12 = add <4 x i32> %9, splat (i32 12)
  %13 = uitofp nneg <4 x i32> %9 to <4 x float>
  %14 = uitofp nneg <4 x i32> %10 to <4 x float>
  %15 = uitofp nneg <4 x i32> %11 to <4 x float>
  %16 = uitofp nneg <4 x i32> %12 to <4 x float>
  %17 = fdiv <4 x float> %13, splat (float 1.000000e+03)
  %18 = fdiv <4 x float> %14, splat (float 1.000000e+03)
  %19 = fdiv <4 x float> %15, splat (float 1.000000e+03)
  %20 = fdiv <4 x float> %16, splat (float 1.000000e+03)
  %21 = getelementptr inbounds nuw float, ptr %3, i64 %8
  %22 = getelementptr inbounds nuw i8, ptr %21, i64 16
  %23 = getelementptr inbounds nuw i8, ptr %21, i64 32
  %24 = getelementptr inbounds nuw i8, ptr %21, i64 48
  store <4 x float> %17, ptr %21, align 4, !tbaa !6
  store <4 x float> %18, ptr %22, align 4, !tbaa !6
  store <4 x float> %19, ptr %23, align 4, !tbaa !6
  store <4 x float> %20, ptr %24, align 4, !tbaa !6
  %25 = urem <4 x i32> %9, splat (i32 1000)
  %26 = urem <4 x i32> %10, splat (i32 1000)
  %27 = urem <4 x i32> %11, splat (i32 1000)
  %28 = urem <4 x i32> %12, splat (i32 1000)
  %29 = uitofp nneg <4 x i32> %25 to <4 x float>
  %30 = uitofp nneg <4 x i32> %26 to <4 x float>
  %31 = uitofp nneg <4 x i32> %27 to <4 x float>
  %32 = uitofp nneg <4 x i32> %28 to <4 x float>
  %33 = fdiv <4 x float> %29, splat (float 1.000000e+02)
  %34 = fdiv <4 x float> %30, splat (float 1.000000e+02)
  %35 = fdiv <4 x float> %31, splat (float 1.000000e+02)
  %36 = fdiv <4 x float> %32, splat (float 1.000000e+02)
  %37 = getelementptr inbounds nuw float, ptr %4, i64 %8
  %38 = getelementptr inbounds nuw i8, ptr %37, i64 16
  %39 = getelementptr inbounds nuw i8, ptr %37, i64 32
  %40 = getelementptr inbounds nuw i8, ptr %37, i64 48
  store <4 x float> %33, ptr %37, align 4, !tbaa !6
  store <4 x float> %34, ptr %38, align 4, !tbaa !6
  store <4 x float> %35, ptr %39, align 4, !tbaa !6
  store <4 x float> %36, ptr %40, align 4, !tbaa !6
  %41 = add nuw i64 %8, 16
  %42 = add <4 x i32> %9, splat (i32 16)
  %43 = icmp eq i64 %41, 10000000
  br i1 %43, label %44, label %7, !llvm.loop !23

44:                                               ; preds = %7
  %45 = tail call i32 @puts(ptr nonnull dereferenceable(1) @str.15)
  br label %46

46:                                               ; preds = %46, %44
  %47 = phi i64 [ 0, %44 ], [ %72, %46 ]
  %48 = getelementptr inbounds nuw float, ptr %3, i64 %47
  %49 = getelementptr inbounds nuw i8, ptr %48, i64 16
  %50 = getelementptr inbounds nuw i8, ptr %48, i64 32
  %51 = getelementptr inbounds nuw i8, ptr %48, i64 48
  %52 = load <4 x float>, ptr %48, align 4, !tbaa !6
  %53 = load <4 x float>, ptr %49, align 4, !tbaa !6
  %54 = load <4 x float>, ptr %50, align 4, !tbaa !6
  %55 = load <4 x float>, ptr %51, align 4, !tbaa !6
  %56 = getelementptr inbounds nuw float, ptr %4, i64 %47
  %57 = getelementptr inbounds nuw i8, ptr %56, i64 16
  %58 = getelementptr inbounds nuw i8, ptr %56, i64 32
  %59 = getelementptr inbounds nuw i8, ptr %56, i64 48
  %60 = load <4 x float>, ptr %56, align 4, !tbaa !6
  %61 = load <4 x float>, ptr %57, align 4, !tbaa !6
  %62 = load <4 x float>, ptr %58, align 4, !tbaa !6
  %63 = load <4 x float>, ptr %59, align 4, !tbaa !6
  %64 = fadd <4 x float> %52, %60
  %65 = fadd <4 x float> %53, %61
  %66 = fadd <4 x float> %54, %62
  %67 = fadd <4 x float> %55, %63
  %68 = getelementptr inbounds nuw float, ptr %6, i64 %47
  %69 = getelementptr inbounds nuw i8, ptr %68, i64 16
  %70 = getelementptr inbounds nuw i8, ptr %68, i64 32
  %71 = getelementptr inbounds nuw i8, ptr %68, i64 48
  store <4 x float> %64, ptr %68, align 4, !tbaa !6
  store <4 x float> %65, ptr %69, align 4, !tbaa !6
  store <4 x float> %66, ptr %70, align 4, !tbaa !6
  store <4 x float> %67, ptr %71, align 4, !tbaa !6
  %72 = add nuw i64 %47, 16
  %73 = icmp eq i64 %72, 10000000
  br i1 %73, label %74, label %46, !llvm.loop !24

74:                                               ; preds = %46
  tail call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 1 dereferenceable(40000000) %5, ptr noundef nonnull align 1 dereferenceable(40000000) %6, i64 noundef 40000000, i1 noundef false) #10
  br label %75

75:                                               ; preds = %75, %74
  %76 = phi i64 [ 0, %74 ], [ %101, %75 ]
  %77 = getelementptr inbounds nuw float, ptr %3, i64 %76
  %78 = getelementptr inbounds nuw i8, ptr %77, i64 16
  %79 = getelementptr inbounds nuw i8, ptr %77, i64 32
  %80 = getelementptr inbounds nuw i8, ptr %77, i64 48
  %81 = load <4 x float>, ptr %77, align 4, !tbaa !6
  %82 = load <4 x float>, ptr %78, align 4, !tbaa !6
  %83 = load <4 x float>, ptr %79, align 4, !tbaa !6
  %84 = load <4 x float>, ptr %80, align 4, !tbaa !6
  %85 = getelementptr inbounds nuw float, ptr %4, i64 %76
  %86 = getelementptr inbounds nuw i8, ptr %85, i64 16
  %87 = getelementptr inbounds nuw i8, ptr %85, i64 32
  %88 = getelementptr inbounds nuw i8, ptr %85, i64 48
  %89 = load <4 x float>, ptr %85, align 4, !tbaa !6
  %90 = load <4 x float>, ptr %86, align 4, !tbaa !6
  %91 = load <4 x float>, ptr %87, align 4, !tbaa !6
  %92 = load <4 x float>, ptr %88, align 4, !tbaa !6
  %93 = fadd <4 x float> %81, %89
  %94 = fadd <4 x float> %82, %90
  %95 = fadd <4 x float> %83, %91
  %96 = fadd <4 x float> %84, %92
  %97 = getelementptr inbounds nuw float, ptr %5, i64 %76
  %98 = getelementptr inbounds nuw i8, ptr %97, i64 16
  %99 = getelementptr inbounds nuw i8, ptr %97, i64 32
  %100 = getelementptr inbounds nuw i8, ptr %97, i64 48
  store <4 x float> %93, ptr %97, align 4, !tbaa !6
  store <4 x float> %94, ptr %98, align 4, !tbaa !6
  store <4 x float> %95, ptr %99, align 4, !tbaa !6
  store <4 x float> %96, ptr %100, align 4, !tbaa !6
  %101 = add nuw i64 %76, 16
  %102 = icmp eq i64 %101, 10000000
  br i1 %102, label %.preheader4, label %75, !llvm.loop !25

.preheader4:                                      ; preds = %75
  br label %103

103:                                              ; preds = %.preheader4, %123
  %104 = phi i64 [ %125, %123 ], [ 0, %.preheader4 ]
  %105 = phi i32 [ %124, %123 ], [ 0, %.preheader4 ]
  %106 = getelementptr inbounds nuw float, ptr %6, i64 %104
  %107 = load float, ptr %106, align 4, !tbaa !6
  %108 = getelementptr inbounds nuw float, ptr %5, i64 %104
  %109 = load float, ptr %108, align 4, !tbaa !6
  %110 = fsub float %107, %109
  %111 = tail call float @llvm.fabs.f32(float %110)
  %112 = fpext float %111 to double
  %113 = fcmp ogt double %112, 1.000000e-05
  br i1 %113, label %114, label %123

114:                                              ; preds = %103
  %115 = icmp slt i32 %105, 10
  br i1 %115, label %116, label %121

116:                                              ; preds = %114
  %117 = fpext float %107 to double
  %118 = fpext float %109 to double
  %119 = trunc nuw nsw i64 %104 to i32
  %120 = tail call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str, ptr noundef nonnull @.str.4, i32 noundef %119, double noundef %117, double noundef %118, double noundef %112)
  br label %121

121:                                              ; preds = %116, %114
  %122 = add nsw i32 %105, 1
  br label %123

123:                                              ; preds = %121, %103
  %124 = phi i32 [ %122, %121 ], [ %105, %103 ]
  %125 = add nuw nsw i64 %104, 1
  %126 = icmp eq i64 %125, 10000000
  br i1 %126, label %127, label %103, !llvm.loop !22

127:                                              ; preds = %123
  %128 = icmp eq i32 %124, 0
  %129 = select i1 %128, ptr @.str.6, ptr @.str.7
  %130 = tail call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.5, ptr noundef nonnull %129, i32 noundef %124)
  %131 = tail call i32 @puts(ptr nonnull dereferenceable(1) @str.16)
  br label %132

132:                                              ; preds = %132, %127
  %133 = phi i64 [ 0, %127 ], [ %150, %132 ]
  %134 = getelementptr inbounds nuw float, ptr %3, i64 %133
  %135 = getelementptr inbounds nuw i8, ptr %134, i64 16
  %136 = getelementptr inbounds nuw i8, ptr %134, i64 32
  %137 = getelementptr inbounds nuw i8, ptr %134, i64 48
  %138 = load <4 x float>, ptr %134, align 4, !tbaa !6
  %139 = load <4 x float>, ptr %135, align 4, !tbaa !6
  %140 = load <4 x float>, ptr %136, align 4, !tbaa !6
  %141 = load <4 x float>, ptr %137, align 4, !tbaa !6
  %142 = fmul <4 x float> %138, splat (float 2.500000e+00)
  %143 = fmul <4 x float> %139, splat (float 2.500000e+00)
  %144 = fmul <4 x float> %140, splat (float 2.500000e+00)
  %145 = fmul <4 x float> %141, splat (float 2.500000e+00)
  %146 = getelementptr inbounds nuw float, ptr %6, i64 %133
  %147 = getelementptr inbounds nuw i8, ptr %146, i64 16
  %148 = getelementptr inbounds nuw i8, ptr %146, i64 32
  %149 = getelementptr inbounds nuw i8, ptr %146, i64 48
  store <4 x float> %142, ptr %146, align 4, !tbaa !6
  store <4 x float> %143, ptr %147, align 4, !tbaa !6
  store <4 x float> %144, ptr %148, align 4, !tbaa !6
  store <4 x float> %145, ptr %149, align 4, !tbaa !6
  %150 = add nuw i64 %133, 16
  %151 = icmp eq i64 %150, 10000000
  br i1 %151, label %.preheader3, label %132, !llvm.loop !26

.preheader3:                                      ; preds = %132
  br label %152

152:                                              ; preds = %.preheader3, %152
  %153 = phi i64 [ %170, %152 ], [ 0, %.preheader3 ]
  %154 = getelementptr inbounds nuw float, ptr %3, i64 %153
  %155 = getelementptr inbounds nuw i8, ptr %154, i64 16
  %156 = getelementptr inbounds nuw i8, ptr %154, i64 32
  %157 = getelementptr inbounds nuw i8, ptr %154, i64 48
  %158 = load <4 x float>, ptr %154, align 4, !tbaa !6
  %159 = load <4 x float>, ptr %155, align 4, !tbaa !6
  %160 = load <4 x float>, ptr %156, align 4, !tbaa !6
  %161 = load <4 x float>, ptr %157, align 4, !tbaa !6
  %162 = fmul <4 x float> %158, splat (float 2.500000e+00)
  %163 = fmul <4 x float> %159, splat (float 2.500000e+00)
  %164 = fmul <4 x float> %160, splat (float 2.500000e+00)
  %165 = fmul <4 x float> %161, splat (float 2.500000e+00)
  %166 = getelementptr inbounds nuw float, ptr %5, i64 %153
  %167 = getelementptr inbounds nuw i8, ptr %166, i64 16
  %168 = getelementptr inbounds nuw i8, ptr %166, i64 32
  %169 = getelementptr inbounds nuw i8, ptr %166, i64 48
  store <4 x float> %162, ptr %166, align 4, !tbaa !6
  store <4 x float> %163, ptr %167, align 4, !tbaa !6
  store <4 x float> %164, ptr %168, align 4, !tbaa !6
  store <4 x float> %165, ptr %169, align 4, !tbaa !6
  %170 = add nuw i64 %153, 16
  %171 = icmp eq i64 %170, 10000000
  br i1 %171, label %.preheader2, label %152, !llvm.loop !27

.preheader2:                                      ; preds = %152
  br label %172

172:                                              ; preds = %.preheader2, %192
  %173 = phi i64 [ %194, %192 ], [ 0, %.preheader2 ]
  %174 = phi i32 [ %193, %192 ], [ 0, %.preheader2 ]
  %175 = getelementptr inbounds nuw float, ptr %6, i64 %173
  %176 = load float, ptr %175, align 4, !tbaa !6
  %177 = getelementptr inbounds nuw float, ptr %5, i64 %173
  %178 = load float, ptr %177, align 4, !tbaa !6
  %179 = fsub float %176, %178
  %180 = tail call float @llvm.fabs.f32(float %179)
  %181 = fpext float %180 to double
  %182 = fcmp ogt double %181, 1.000000e-05
  br i1 %182, label %183, label %192

183:                                              ; preds = %172
  %184 = icmp slt i32 %174, 10
  br i1 %184, label %185, label %190

185:                                              ; preds = %183
  %186 = fpext float %176 to double
  %187 = fpext float %178 to double
  %188 = trunc nuw nsw i64 %173 to i32
  %189 = tail call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str, ptr noundef nonnull @.str.9, i32 noundef %188, double noundef %186, double noundef %187, double noundef %181)
  br label %190

190:                                              ; preds = %185, %183
  %191 = add nsw i32 %174, 1
  br label %192

192:                                              ; preds = %190, %172
  %193 = phi i32 [ %191, %190 ], [ %174, %172 ]
  %194 = add nuw nsw i64 %173, 1
  %195 = icmp eq i64 %194, 10000000
  br i1 %195, label %196, label %172, !llvm.loop !22

196:                                              ; preds = %192
  %197 = icmp eq i32 %193, 0
  %198 = select i1 %197, ptr @.str.6, ptr @.str.7
  %199 = tail call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.5, ptr noundef nonnull %198, i32 noundef %193)
  %200 = tail call i32 @puts(ptr nonnull dereferenceable(1) @str.17)
  br label %201

201:                                              ; preds = %201, %196
  %202 = phi i64 [ 0, %196 ], [ %227, %201 ]
  %203 = getelementptr inbounds nuw float, ptr %3, i64 %202
  %204 = getelementptr inbounds nuw i8, ptr %203, i64 16
  %205 = getelementptr inbounds nuw i8, ptr %203, i64 32
  %206 = getelementptr inbounds nuw i8, ptr %203, i64 48
  %207 = load <4 x float>, ptr %203, align 4, !tbaa !6
  %208 = load <4 x float>, ptr %204, align 4, !tbaa !6
  %209 = load <4 x float>, ptr %205, align 4, !tbaa !6
  %210 = load <4 x float>, ptr %206, align 4, !tbaa !6
  %211 = getelementptr inbounds nuw float, ptr %4, i64 %202
  %212 = getelementptr inbounds nuw i8, ptr %211, i64 16
  %213 = getelementptr inbounds nuw i8, ptr %211, i64 32
  %214 = getelementptr inbounds nuw i8, ptr %211, i64 48
  %215 = load <4 x float>, ptr %211, align 4, !tbaa !6
  %216 = load <4 x float>, ptr %212, align 4, !tbaa !6
  %217 = load <4 x float>, ptr %213, align 4, !tbaa !6
  %218 = load <4 x float>, ptr %214, align 4, !tbaa !6
  %219 = fmul <4 x float> %207, %215
  %220 = fmul <4 x float> %208, %216
  %221 = fmul <4 x float> %209, %217
  %222 = fmul <4 x float> %210, %218
  %223 = getelementptr inbounds nuw float, ptr %6, i64 %202
  %224 = getelementptr inbounds nuw i8, ptr %223, i64 16
  %225 = getelementptr inbounds nuw i8, ptr %223, i64 32
  %226 = getelementptr inbounds nuw i8, ptr %223, i64 48
  store <4 x float> %219, ptr %223, align 4, !tbaa !6
  store <4 x float> %220, ptr %224, align 4, !tbaa !6
  store <4 x float> %221, ptr %225, align 4, !tbaa !6
  store <4 x float> %222, ptr %226, align 4, !tbaa !6
  %227 = add nuw i64 %202, 16
  %228 = icmp eq i64 %227, 10000000
  br i1 %228, label %.preheader1, label %201, !llvm.loop !28

.preheader1:                                      ; preds = %201
  br label %229

229:                                              ; preds = %.preheader1, %229
  %230 = phi i64 [ %255, %229 ], [ 0, %.preheader1 ]
  %231 = getelementptr inbounds nuw float, ptr %3, i64 %230
  %232 = getelementptr inbounds nuw i8, ptr %231, i64 16
  %233 = getelementptr inbounds nuw i8, ptr %231, i64 32
  %234 = getelementptr inbounds nuw i8, ptr %231, i64 48
  %235 = load <4 x float>, ptr %231, align 4, !tbaa !6
  %236 = load <4 x float>, ptr %232, align 4, !tbaa !6
  %237 = load <4 x float>, ptr %233, align 4, !tbaa !6
  %238 = load <4 x float>, ptr %234, align 4, !tbaa !6
  %239 = getelementptr inbounds nuw float, ptr %4, i64 %230
  %240 = getelementptr inbounds nuw i8, ptr %239, i64 16
  %241 = getelementptr inbounds nuw i8, ptr %239, i64 32
  %242 = getelementptr inbounds nuw i8, ptr %239, i64 48
  %243 = load <4 x float>, ptr %239, align 4, !tbaa !6
  %244 = load <4 x float>, ptr %240, align 4, !tbaa !6
  %245 = load <4 x float>, ptr %241, align 4, !tbaa !6
  %246 = load <4 x float>, ptr %242, align 4, !tbaa !6
  %247 = fmul <4 x float> %235, %243
  %248 = fmul <4 x float> %236, %244
  %249 = fmul <4 x float> %237, %245
  %250 = fmul <4 x float> %238, %246
  %251 = getelementptr inbounds nuw float, ptr %5, i64 %230
  %252 = getelementptr inbounds nuw i8, ptr %251, i64 16
  %253 = getelementptr inbounds nuw i8, ptr %251, i64 32
  %254 = getelementptr inbounds nuw i8, ptr %251, i64 48
  store <4 x float> %247, ptr %251, align 4, !tbaa !6
  store <4 x float> %248, ptr %252, align 4, !tbaa !6
  store <4 x float> %249, ptr %253, align 4, !tbaa !6
  store <4 x float> %250, ptr %254, align 4, !tbaa !6
  %255 = add nuw i64 %230, 16
  %256 = icmp eq i64 %255, 10000000
  br i1 %256, label %.preheader, label %229, !llvm.loop !29

.preheader:                                       ; preds = %229
  br label %257

257:                                              ; preds = %.preheader, %277
  %258 = phi i64 [ %279, %277 ], [ 0, %.preheader ]
  %259 = phi i32 [ %278, %277 ], [ 0, %.preheader ]
  %260 = getelementptr inbounds nuw float, ptr %6, i64 %258
  %261 = load float, ptr %260, align 4, !tbaa !6
  %262 = getelementptr inbounds nuw float, ptr %5, i64 %258
  %263 = load float, ptr %262, align 4, !tbaa !6
  %264 = fsub float %261, %263
  %265 = tail call float @llvm.fabs.f32(float %264)
  %266 = fpext float %265 to double
  %267 = fcmp ogt double %266, 1.000000e-05
  br i1 %267, label %268, label %277

268:                                              ; preds = %257
  %269 = icmp slt i32 %259, 10
  br i1 %269, label %270, label %275

270:                                              ; preds = %268
  %271 = fpext float %261 to double
  %272 = fpext float %263 to double
  %273 = trunc nuw nsw i64 %258 to i32
  %274 = tail call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str, ptr noundef nonnull @.str.11, i32 noundef %273, double noundef %271, double noundef %272, double noundef %266)
  br label %275

275:                                              ; preds = %270, %268
  %276 = add nsw i32 %259, 1
  br label %277

277:                                              ; preds = %275, %257
  %278 = phi i32 [ %276, %275 ], [ %259, %257 ]
  %279 = add nuw nsw i64 %258, 1
  %280 = icmp eq i64 %279, 10000000
  br i1 %280, label %281, label %257, !llvm.loop !22

281:                                              ; preds = %277
  %282 = add nsw i32 %193, %124
  %283 = icmp eq i32 %278, 0
  %284 = select i1 %283, ptr @.str.6, ptr @.str.7
  %285 = tail call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.5, ptr noundef nonnull %284, i32 noundef %278)
  %286 = add nsw i32 %282, %278
  %287 = tail call i32 @puts(ptr nonnull dereferenceable(1) @str.20)
  %288 = icmp eq i32 %286, 0
  br i1 %288, label %289, label %291

289:                                              ; preds = %281
  %290 = tail call i32 @puts(ptr nonnull dereferenceable(1) @str.19)
  br label %293

291:                                              ; preds = %281
  %292 = tail call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.14, i32 noundef %286)
  br label %293

293:                                              ; preds = %291, %289
  %294 = tail call i32 @puts(ptr nonnull dereferenceable(1) @str.20)
  tail call void @free(ptr noundef %3)
  tail call void @free(ptr noundef %4)
  tail call void @free(ptr noundef nonnull %5)
  tail call void @free(ptr noundef nonnull %6)
  %295 = icmp sgt i32 %286, 0
  %296 = zext i1 %295 to i32
  ret i32 %296
}

; Function Attrs: mustprogress nofree nounwind willreturn allockind("alloc,uninitialized") allocsize(0) memory(inaccessiblemem: readwrite)
declare noalias noundef ptr @malloc(i64 noundef) local_unnamed_addr #4

; Function Attrs: mustprogress nounwind willreturn allockind("free") memory(argmem: readwrite, inaccessiblemem: readwrite)
declare void @free(ptr allocptr noundef captures(none)) local_unnamed_addr #5

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare float @llvm.fabs.f32(float) #6

; Function Attrs: nofree nounwind
declare noundef i32 @puts(ptr noundef readonly captures(none)) local_unnamed_addr #7

; Function Attrs: nocallback nofree nounwind willreturn memory(argmem: readwrite)
declare void @llvm.memcpy.p0.p0.i64(ptr noalias writeonly captures(none), ptr noalias readonly captures(none), i64, i1 immarg) #8

attributes #0 = { nofree norecurse nosync nounwind ssp memory(argmem: readwrite) uwtable(sync) "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+ccpp,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a" }
attributes #1 = { nofree nounwind ssp uwtable(sync) "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+ccpp,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a" }
attributes #2 = { nofree nounwind "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+ccpp,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a" }
attributes #3 = { nounwind ssp uwtable(sync) "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+ccpp,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a" }
attributes #4 = { mustprogress nofree nounwind willreturn allockind("alloc,uninitialized") allocsize(0) memory(inaccessiblemem: readwrite) "alloc-family"="malloc" "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+ccpp,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a" }
attributes #5 = { mustprogress nounwind willreturn allockind("free") memory(argmem: readwrite, inaccessiblemem: readwrite) "alloc-family"="malloc" "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+ccpp,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a" }
attributes #6 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #7 = { nofree nounwind }
attributes #8 = { nocallback nofree nounwind willreturn memory(argmem: readwrite) }
attributes #9 = { allocsize(0) }
attributes #10 = { nounwind }

!llvm.module.flags = !{!0, !1, !2, !3, !4}
!llvm.ident = !{!5}

!0 = !{i32 2, !"SDK Version", [2 x i32] [i32 15, i32 2]}
!1 = !{i32 1, !"wchar_size", i32 4}
!2 = !{i32 8, !"PIC Level", i32 2}
!3 = !{i32 7, !"uwtable", i32 1}
!4 = !{i32 7, !"frame-pointer", i32 1}
!5 = !{!"Homebrew clang version 21.1.2"}
!6 = !{!7, !7, i64 0}
!7 = !{!"float", !8, i64 0}
!8 = !{!"omnipotent char", !9, i64 0}
!9 = !{!"Simple C/C++ TBAA"}
!10 = distinct !{!10, !11, !12, !13}
!11 = !{!"llvm.loop.mustprogress"}
!12 = !{!"llvm.loop.isvectorized", i32 1}
!13 = !{!"llvm.loop.unroll.runtime.disable"}
!14 = distinct !{!14, !11, !12, !13}
!15 = distinct !{!15, !11, !12}
!16 = distinct !{!16, !11, !12, !13}
!17 = distinct !{!17, !11, !12, !13}
!18 = distinct !{!18, !11, !12}
!19 = distinct !{!19, !11, !12, !13}
!20 = distinct !{!20, !11, !12, !13}
!21 = distinct !{!21, !11, !12}
!22 = distinct !{!22, !11}
!23 = distinct !{!23, !11, !12, !13}
!24 = distinct !{!24, !11, !12, !13}
!25 = distinct !{!25, !11, !12, !13}
!26 = distinct !{!26, !11, !12, !13}
!27 = distinct !{!27, !11, !12, !13}
!28 = distinct !{!28, !11, !12, !13}
!29 = distinct !{!29, !11, !12, !13}
