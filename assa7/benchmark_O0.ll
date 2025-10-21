; ModuleID = 'benchmark.c'
source_filename = "benchmark.c"
target datalayout = "e-m:o-i64:64-i128:128-n32:64-S128"
target triple = "arm64-apple-macosx15.0.0"

%struct.timespec = type { i64, i64 }

@.str = private unnamed_addr constant [14 x i8] c"Result: %.6f\0A\00", align 1
@.str.1 = private unnamed_addr constant [28 x i8] c"Elapsed time: %.6f seconds\0A\00", align 1

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define float @loop_div_sum(ptr noundef %0, i32 noundef %1, float noundef %2) #0 {
  %4 = alloca ptr, align 8
  %5 = alloca i32, align 4
  %6 = alloca float, align 4
  %7 = alloca float, align 4
  %8 = alloca i32, align 4
  %9 = alloca float, align 4
  store ptr %0, ptr %4, align 8
  store i32 %1, ptr %5, align 4
  store float %2, ptr %6, align 4
  store float 0.000000e+00, ptr %7, align 4
  store i32 0, ptr %8, align 4
  br label %10

10:                                               ; preds = %34, %3
  %11 = load i32, ptr %8, align 4
  %12 = load i32, ptr %5, align 4
  %13 = icmp slt i32 %11, %12
  br i1 %13, label %14, label %37

14:                                               ; preds = %10
  %15 = load ptr, ptr %4, align 8
  %16 = load i32, ptr %8, align 4
  %17 = sext i32 %16 to i64
  %18 = getelementptr inbounds float, ptr %15, i64 %17
  %19 = load float, ptr %18, align 4
  %20 = load i32, ptr %8, align 4
  %21 = sitofp i32 %20 to float
  %22 = call float @llvm.fmuladd.f32(float %21, float 5.000000e-01, float %19)
  store float %22, ptr %9, align 4
  %23 = load float, ptr %9, align 4
  %24 = load float, ptr %6, align 4
  %25 = fdiv float %23, %24
  %26 = load float, ptr %7, align 4
  %27 = fadd float %26, %25
  store float %27, ptr %7, align 4
  %28 = load float, ptr %9, align 4
  %29 = fadd float %28, 1.000000e+00
  %30 = load float, ptr %6, align 4
  %31 = fdiv float %29, %30
  %32 = load float, ptr %7, align 4
  %33 = fadd float %32, %31
  store float %33, ptr %7, align 4
  br label %34

34:                                               ; preds = %14
  %35 = load i32, ptr %8, align 4
  %36 = add nsw i32 %35, 1
  store i32 %36, ptr %8, align 4
  br label %10, !llvm.loop !6

37:                                               ; preds = %10
  %38 = load float, ptr %7, align 4
  ret float %38
}

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare float @llvm.fmuladd.f32(float, float, float) #1

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define float @branchy(float noundef %0, float noundef %1, float noundef %2) #0 {
  %4 = alloca float, align 4
  %5 = alloca float, align 4
  %6 = alloca float, align 4
  %7 = alloca float, align 4
  %8 = alloca float, align 4
  %9 = alloca float, align 4
  %10 = alloca float, align 4
  %11 = alloca float, align 4
  %12 = alloca float, align 4
  store float %0, ptr %4, align 4
  store float %1, ptr %5, align 4
  store float %2, ptr %6, align 4
  %13 = load float, ptr %6, align 4
  %14 = fadd float %13, 2.500000e-01
  store float %14, ptr %7, align 4
  store float 0.000000e+00, ptr %8, align 4
  %15 = load float, ptr %4, align 4
  %16 = load float, ptr %5, align 4
  %17 = fcmp ogt float %15, %16
  br i1 %17, label %18, label %30

18:                                               ; preds = %3
  %19 = load float, ptr %4, align 4
  %20 = load float, ptr %7, align 4
  %21 = fdiv float %19, %20
  store float %21, ptr %9, align 4
  %22 = load float, ptr %4, align 4
  %23 = load float, ptr %5, align 4
  %24 = fadd float %22, %23
  %25 = load float, ptr %7, align 4
  %26 = fdiv float %24, %25
  store float %26, ptr %10, align 4
  %27 = load float, ptr %9, align 4
  %28 = load float, ptr %10, align 4
  %29 = fadd float %27, %28
  store float %29, ptr %8, align 4
  br label %42

30:                                               ; preds = %3
  %31 = load float, ptr %5, align 4
  %32 = load float, ptr %7, align 4
  %33 = fdiv float %31, %32
  store float %33, ptr %11, align 4
  %34 = load float, ptr %5, align 4
  %35 = load float, ptr %4, align 4
  %36 = fsub float %34, %35
  %37 = load float, ptr %7, align 4
  %38 = fdiv float %36, %37
  store float %38, ptr %12, align 4
  %39 = load float, ptr %11, align 4
  %40 = load float, ptr %12, align 4
  %41 = fsub float %39, %40
  store float %41, ptr %8, align 4
  br label %42

42:                                               ; preds = %30, %18
  %43 = load float, ptr %8, align 4
  ret float %43
}

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define i32 @main() #0 {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  %3 = alloca float, align 4
  %4 = alloca float, align 4
  %5 = alloca float, align 4
  %6 = alloca [8 x float], align 4
  %7 = alloca i32, align 4
  %8 = alloca %struct.timespec, align 8
  %9 = alloca %struct.timespec, align 8
  %10 = alloca float, align 4
  %11 = alloca i32, align 4
  %12 = alloca float, align 4
  %13 = alloca float, align 4
  %14 = alloca float, align 4
  %15 = alloca float, align 4
  %16 = alloca double, align 8
  store i32 0, ptr %1, align 4
  store i32 10000000, ptr %2, align 4
  store float 1.000000e+01, ptr %3, align 4
  store float 2.000000e+00, ptr %4, align 4
  store float 1.500000e+00, ptr %5, align 4
  store i32 0, ptr %7, align 4
  br label %17

17:                                               ; preds = %27, %0
  %18 = load i32, ptr %7, align 4
  %19 = icmp slt i32 %18, 8
  br i1 %19, label %20, label %30

20:                                               ; preds = %17
  %21 = load i32, ptr %7, align 4
  %22 = sitofp i32 %21 to float
  %23 = call float @llvm.fmuladd.f32(float 2.500000e-01, float %22, float 1.000000e+00)
  %24 = load i32, ptr %7, align 4
  %25 = sext i32 %24 to i64
  %26 = getelementptr inbounds [8 x float], ptr %6, i64 0, i64 %25
  store float %23, ptr %26, align 4
  br label %27

27:                                               ; preds = %20
  %28 = load i32, ptr %7, align 4
  %29 = add nsw i32 %28, 1
  store i32 %29, ptr %7, align 4
  br label %17, !llvm.loop !8

30:                                               ; preds = %17
  %31 = call i32 @clock_gettime(i32 noundef 6, ptr noundef %8)
  store volatile float 0.000000e+00, ptr %10, align 4
  store i32 0, ptr %11, align 4
  br label %32

32:                                               ; preds = %59, %30
  %33 = load i32, ptr %11, align 4
  %34 = icmp slt i32 %33, 10000000
  br i1 %34, label %35, label %62

35:                                               ; preds = %32
  %36 = load float, ptr %3, align 4
  %37 = call float @compute_constants(float noundef %36)
  store float %37, ptr %12, align 4
  %38 = load float, ptr %3, align 4
  %39 = load float, ptr %4, align 4
  %40 = load float, ptr %5, align 4
  %41 = call float @reuse_same_den(float noundef %38, float noundef %39, float noundef %40)
  store float %41, ptr %13, align 4
  %42 = getelementptr inbounds [8 x float], ptr %6, i64 0, i64 0
  %43 = load float, ptr %4, align 4
  %44 = fadd float %43, 3.000000e+00
  %45 = call float @loop_div_sum(ptr noundef %42, i32 noundef 8, float noundef %44)
  store float %45, ptr %14, align 4
  %46 = load float, ptr %3, align 4
  %47 = load float, ptr %4, align 4
  %48 = load float, ptr %5, align 4
  %49 = call float @branchy(float noundef %46, float noundef %47, float noundef %48)
  store float %49, ptr %15, align 4
  %50 = load float, ptr %12, align 4
  %51 = load float, ptr %13, align 4
  %52 = fadd float %50, %51
  %53 = load float, ptr %14, align 4
  %54 = fadd float %52, %53
  %55 = load float, ptr %15, align 4
  %56 = fadd float %54, %55
  %57 = load volatile float, ptr %10, align 4
  %58 = fadd float %57, %56
  store volatile float %58, ptr %10, align 4
  br label %59

59:                                               ; preds = %35
  %60 = load i32, ptr %11, align 4
  %61 = add nsw i32 %60, 1
  store i32 %61, ptr %11, align 4
  br label %32, !llvm.loop !9

62:                                               ; preds = %32
  %63 = call i32 @clock_gettime(i32 noundef 6, ptr noundef %9)
  %64 = getelementptr inbounds %struct.timespec, ptr %9, i32 0, i32 0
  %65 = load i64, ptr %64, align 8
  %66 = getelementptr inbounds %struct.timespec, ptr %8, i32 0, i32 0
  %67 = load i64, ptr %66, align 8
  %68 = sub nsw i64 %65, %67
  %69 = sitofp i64 %68 to double
  %70 = getelementptr inbounds %struct.timespec, ptr %9, i32 0, i32 1
  %71 = load i64, ptr %70, align 8
  %72 = getelementptr inbounds %struct.timespec, ptr %8, i32 0, i32 1
  %73 = load i64, ptr %72, align 8
  %74 = sub nsw i64 %71, %73
  %75 = sitofp i64 %74 to double
  %76 = fdiv double %75, 1.000000e+09
  %77 = fadd double %69, %76
  store double %77, ptr %16, align 8
  %78 = load volatile float, ptr %10, align 4
  %79 = fpext float %78 to double
  %80 = call i32 (ptr, ...) @printf(ptr noundef @.str, double noundef %79)
  %81 = load double, ptr %16, align 8
  %82 = call i32 (ptr, ...) @printf(ptr noundef @.str.1, double noundef %81)
  ret i32 0
}

declare i32 @clock_gettime(i32 noundef, ptr noundef) #2

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define internal float @compute_constants(float noundef %0) #0 {
  %2 = alloca float, align 4
  %3 = alloca float, align 4
  store float %0, ptr %2, align 4
  store float 0.000000e+00, ptr %3, align 4
  %4 = load float, ptr %2, align 4
  %5 = fdiv float %4, 2.000000e+00
  %6 = load float, ptr %3, align 4
  %7 = fadd float %6, %5
  store float %7, ptr %3, align 4
  %8 = load float, ptr %2, align 4
  %9 = fdiv float %8, 3.000000e+00
  %10 = load float, ptr %3, align 4
  %11 = fadd float %10, %9
  store float %11, ptr %3, align 4
  %12 = load float, ptr %2, align 4
  %13 = fdiv float %12, 5.000000e+00
  %14 = load float, ptr %3, align 4
  %15 = fadd float %14, %13
  store float %15, ptr %3, align 4
  %16 = load float, ptr %2, align 4
  %17 = fadd float %16, 1.000000e+00
  %18 = fdiv float %17, 4.000000e+00
  %19 = load float, ptr %3, align 4
  %20 = fadd float %19, %18
  store float %20, ptr %3, align 4
  %21 = load float, ptr %2, align 4
  %22 = fsub float %21, 7.000000e+00
  %23 = fdiv float %22, 8.000000e+00
  %24 = load float, ptr %3, align 4
  %25 = fadd float %24, %23
  store float %25, ptr %3, align 4
  %26 = load float, ptr %3, align 4
  ret float %26
}

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define internal float @reuse_same_den(float noundef %0, float noundef %1, float noundef %2) #0 {
  %4 = alloca float, align 4
  %5 = alloca float, align 4
  %6 = alloca float, align 4
  %7 = alloca float, align 4
  %8 = alloca float, align 4
  %9 = alloca float, align 4
  %10 = alloca float, align 4
  store float %0, ptr %4, align 4
  store float %1, ptr %5, align 4
  store float %2, ptr %6, align 4
  %11 = load float, ptr %4, align 4
  %12 = load float, ptr %6, align 4
  %13 = fdiv float %11, %12
  store float %13, ptr %7, align 4
  %14 = load float, ptr %5, align 4
  %15 = load float, ptr %6, align 4
  %16 = fdiv float %14, %15
  store float %16, ptr %8, align 4
  %17 = load float, ptr %4, align 4
  %18 = load float, ptr %5, align 4
  %19 = fadd float %17, %18
  %20 = load float, ptr %6, align 4
  %21 = fdiv float %19, %20
  store float %21, ptr %9, align 4
  %22 = load float, ptr %4, align 4
  %23 = load float, ptr %5, align 4
  %24 = fsub float %22, %23
  %25 = load float, ptr %6, align 4
  %26 = fdiv float %24, %25
  store float %26, ptr %10, align 4
  %27 = load float, ptr %7, align 4
  %28 = load float, ptr %8, align 4
  %29 = fadd float %27, %28
  %30 = load float, ptr %9, align 4
  %31 = fadd float %29, %30
  %32 = load float, ptr %10, align 4
  %33 = fadd float %31, %32
  ret float %33
}

declare i32 @printf(ptr noundef, ...) #2

attributes #0 = { noinline nounwind optnone ssp uwtable(sync) "frame-pointer"="non-leaf" "no-trapping-math"="true" "probe-stack"="__chkstk_darwin" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+crc,+dotprod,+fp-armv8,+fp16fml,+fullfp16,+lse,+neon,+ras,+rcpc,+rdm,+sha2,+sha3,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8.5a,+v8a,+zcm,+zcz" }
attributes #1 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #2 = { "frame-pointer"="non-leaf" "no-trapping-math"="true" "probe-stack"="__chkstk_darwin" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+crc,+dotprod,+fp-armv8,+fp16fml,+fullfp16,+lse,+neon,+ras,+rcpc,+rdm,+sha2,+sha3,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8.5a,+v8a,+zcm,+zcz" }

!llvm.module.flags = !{!0, !1, !2, !3, !4}
!llvm.ident = !{!5}

!0 = !{i32 2, !"SDK Version", [2 x i32] [i32 15, i32 2]}
!1 = !{i32 1, !"wchar_size", i32 4}
!2 = !{i32 8, !"PIC Level", i32 2}
!3 = !{i32 7, !"uwtable", i32 1}
!4 = !{i32 7, !"frame-pointer", i32 1}
!5 = !{!"Apple clang version 16.0.0 (clang-1600.0.26.6)"}
!6 = distinct !{!6, !7}
!7 = !{!"llvm.loop.mustprogress"}
!8 = distinct !{!8, !7}
!9 = distinct !{!9, !7}
