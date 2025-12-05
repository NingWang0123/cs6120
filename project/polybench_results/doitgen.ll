; ModuleID = './polybench/linear-algebra/kernels/doitgen/doitgen.c'
source_filename = "./polybench/linear-algebra/kernels/doitgen/doitgen.c"
target datalayout = "e-m:o-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-n32:64-S128-Fn32"
target triple = "arm64-apple-macosx15.0.0"

@__stderrp = external local_unnamed_addr global ptr, align 8
@.str.1 = private unnamed_addr constant [23 x i8] c"==BEGIN DUMP_ARRAYS==\0A\00", align 1
@.str.2 = private unnamed_addr constant [15 x i8] c"begin dump: %s\00", align 1
@.str.3 = private unnamed_addr constant [2 x i8] c"A\00", align 1
@.str.5 = private unnamed_addr constant [8 x i8] c"%0.2lf \00", align 1
@.str.6 = private unnamed_addr constant [17 x i8] c"\0Aend   dump: %s\0A\00", align 1
@.str.7 = private unnamed_addr constant [23 x i8] c"==END   DUMP_ARRAYS==\0A\00", align 1

; Function Attrs: nofree norecurse nosync nounwind ssp memory(argmem: readwrite) uwtable(sync)
define void @kernel_doitgen(i32 noundef %0, i32 noundef %1, i32 noundef %2, ptr noundef captures(none) %3, ptr noundef readonly captures(none) %4, ptr noundef captures(none) %5) local_unnamed_addr #0 {
  %7 = icmp sgt i32 %0, 0
  br i1 %7, label %8, label %80

8:                                                ; preds = %6
  %9 = ptrtoint ptr %3 to i64
  %10 = ptrtoint ptr %5 to i64
  %11 = icmp sgt i32 %1, 0
  %12 = icmp sgt i32 %2, 0
  %13 = zext nneg i32 %0 to i64
  %14 = zext nneg i32 %1 to i64
  %15 = zext i32 %2 to i64
  %16 = zext nneg i32 %2 to i64
  %17 = sub i64 %9, %10
  %18 = icmp ult i32 %2, 8
  %19 = and i64 %15, 2147483640
  %20 = icmp eq i64 %19, %15
  br label %21

21:                                               ; preds = %8, %77
  %22 = phi i64 [ 0, %8 ], [ %78, %77 ]
  %23 = mul nuw nsw i64 %22, 4800
  %24 = add i64 %17, %23
  br i1 %11, label %25, label %77

25:                                               ; preds = %21, %74
  %26 = phi i64 [ %75, %74 ], [ 0, %21 ]
  %27 = mul nuw nsw i64 %26, 240
  %28 = add i64 %24, %27
  br i1 %12, label %51, label %74

29:                                               ; preds = %64
  %30 = icmp ult i64 %28, 64
  %31 = select i1 %18, i1 true, i1 %30
  br i1 %31, label %49, label %32

32:                                               ; preds = %29, %32
  %33 = phi i64 [ %46, %32 ], [ 0, %29 ]
  %34 = getelementptr inbounds nuw double, ptr %5, i64 %33
  %35 = getelementptr inbounds nuw i8, ptr %34, i64 16
  %36 = getelementptr inbounds nuw i8, ptr %34, i64 32
  %37 = getelementptr inbounds nuw i8, ptr %34, i64 48
  %38 = load <2 x double>, ptr %34, align 8, !tbaa !6
  %39 = load <2 x double>, ptr %35, align 8, !tbaa !6
  %40 = load <2 x double>, ptr %36, align 8, !tbaa !6
  %41 = load <2 x double>, ptr %37, align 8, !tbaa !6
  %42 = getelementptr inbounds nuw [20 x [30 x double]], ptr %3, i64 %22, i64 %26, i64 %33
  %43 = getelementptr inbounds nuw i8, ptr %42, i64 16
  %44 = getelementptr inbounds nuw i8, ptr %42, i64 32
  %45 = getelementptr inbounds nuw i8, ptr %42, i64 48
  store <2 x double> %38, ptr %42, align 8, !tbaa !6
  store <2 x double> %39, ptr %43, align 8, !tbaa !6
  store <2 x double> %40, ptr %44, align 8, !tbaa !6
  store <2 x double> %41, ptr %45, align 8, !tbaa !6
  %46 = add nuw i64 %33, 8
  %47 = icmp eq i64 %46, %19
  br i1 %47, label %48, label %32, !llvm.loop !10

48:                                               ; preds = %32
  br i1 %20, label %74, label %49

49:                                               ; preds = %29, %48
  %50 = phi i64 [ 0, %29 ], [ %19, %48 ]
  br label %67

51:                                               ; preds = %25, %64
  %52 = phi i64 [ %65, %64 ], [ 0, %25 ]
  %53 = getelementptr inbounds nuw double, ptr %5, i64 %52
  store double 0.000000e+00, ptr %53, align 8, !tbaa !6
  br label %54

54:                                               ; preds = %51, %54
  %55 = phi i64 [ 0, %51 ], [ %62, %54 ]
  %56 = phi double [ 0.000000e+00, %51 ], [ %61, %54 ]
  %57 = getelementptr inbounds nuw [20 x [30 x double]], ptr %3, i64 %22, i64 %26, i64 %55
  %58 = load double, ptr %57, align 8, !tbaa !6
  %59 = getelementptr inbounds nuw [30 x double], ptr %4, i64 %55, i64 %52
  %60 = load double, ptr %59, align 8, !tbaa !6
  %61 = tail call double @llvm.fmuladd.f64(double %58, double %60, double %56)
  store double %61, ptr %53, align 8, !tbaa !6
  %62 = add nuw nsw i64 %55, 1
  %63 = icmp eq i64 %62, %15
  br i1 %63, label %64, label %54, !llvm.loop !14

64:                                               ; preds = %54
  %65 = add nuw nsw i64 %52, 1
  %66 = icmp eq i64 %65, %15
  br i1 %66, label %29, label %51, !llvm.loop !15

67:                                               ; preds = %49, %67
  %68 = phi i64 [ %72, %67 ], [ %50, %49 ]
  %69 = getelementptr inbounds nuw double, ptr %5, i64 %68
  %70 = load double, ptr %69, align 8, !tbaa !6
  %71 = getelementptr inbounds nuw [20 x [30 x double]], ptr %3, i64 %22, i64 %26, i64 %68
  store double %70, ptr %71, align 8, !tbaa !6
  %72 = add nuw nsw i64 %68, 1
  %73 = icmp eq i64 %72, %16
  br i1 %73, label %74, label %67, !llvm.loop !16

74:                                               ; preds = %67, %48, %25
  %75 = add nuw nsw i64 %26, 1
  %76 = icmp eq i64 %75, %14
  br i1 %76, label %77, label %25, !llvm.loop !17

77:                                               ; preds = %74, %21
  %78 = add nuw nsw i64 %22, 1
  %79 = icmp eq i64 %78, %13
  br i1 %79, label %80, label %21, !llvm.loop !18

80:                                               ; preds = %77, %6
  ret void
}

; Function Attrs: mustprogress nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare double @llvm.fmuladd.f64(double, double, double) #1

; Function Attrs: nounwind ssp uwtable(sync)
define noundef i32 @main(i32 noundef %0, ptr noundef readonly captures(none) %1) local_unnamed_addr #2 {
  %3 = tail call ptr @polybench_alloc_data(i64 noundef 15000, i32 noundef 8) #7
  %4 = tail call ptr @polybench_alloc_data(i64 noundef 30, i32 noundef 8) #7
  %5 = tail call ptr @polybench_alloc_data(i64 noundef 900, i32 noundef 8) #7
  br label %6

6:                                                ; preds = %123, %2
  %7 = phi i64 [ 0, %2 ], [ %124, %123 ]
  br label %8

8:                                                ; preds = %8, %6
  %9 = phi i64 [ 0, %6 ], [ %121, %8 ]
  %10 = mul nuw nsw i64 %9, %7
  %11 = insertelement <2 x i64> poison, i64 %10, i64 0
  %12 = shufflevector <2 x i64> %11, <2 x i64> poison, <2 x i32> zeroinitializer
  %13 = trunc <2 x i64> %12 to <2 x i32>
  %14 = add <2 x i32> %13, <i32 0, i32 1>
  %15 = trunc <2 x i64> %12 to <2 x i32>
  %16 = add <2 x i32> %15, <i32 2, i32 3>
  %17 = trunc <2 x i64> %12 to <2 x i32>
  %18 = add <2 x i32> %17, <i32 4, i32 5>
  %19 = trunc <2 x i64> %12 to <2 x i32>
  %20 = add <2 x i32> %19, <i32 6, i32 7>
  %21 = urem <2 x i32> %14, splat (i32 30)
  %22 = urem <2 x i32> %16, splat (i32 30)
  %23 = urem <2 x i32> %18, splat (i32 30)
  %24 = urem <2 x i32> %20, splat (i32 30)
  %25 = uitofp nneg <2 x i32> %21 to <2 x double>
  %26 = uitofp nneg <2 x i32> %22 to <2 x double>
  %27 = uitofp nneg <2 x i32> %23 to <2 x double>
  %28 = uitofp nneg <2 x i32> %24 to <2 x double>
  %29 = fdiv <2 x double> %25, splat (double 3.000000e+01)
  %30 = fdiv <2 x double> %26, splat (double 3.000000e+01)
  %31 = fdiv <2 x double> %27, splat (double 3.000000e+01)
  %32 = fdiv <2 x double> %28, splat (double 3.000000e+01)
  %33 = getelementptr inbounds nuw [20 x [30 x double]], ptr %3, i64 %7, i64 %9, i64 0
  %34 = getelementptr inbounds nuw i8, ptr %33, i64 16
  %35 = getelementptr inbounds nuw i8, ptr %33, i64 32
  %36 = getelementptr inbounds nuw i8, ptr %33, i64 48
  store <2 x double> %29, ptr %33, align 8, !tbaa !6
  store <2 x double> %30, ptr %34, align 8, !tbaa !6
  store <2 x double> %31, ptr %35, align 8, !tbaa !6
  store <2 x double> %32, ptr %36, align 8, !tbaa !6
  %37 = trunc <2 x i64> %12 to <2 x i32>
  %38 = add <2 x i32> %37, <i32 8, i32 9>
  %39 = trunc <2 x i64> %12 to <2 x i32>
  %40 = add <2 x i32> %39, <i32 10, i32 11>
  %41 = trunc <2 x i64> %12 to <2 x i32>
  %42 = add <2 x i32> %41, <i32 12, i32 13>
  %43 = trunc <2 x i64> %12 to <2 x i32>
  %44 = add <2 x i32> %43, <i32 14, i32 15>
  %45 = urem <2 x i32> %38, splat (i32 30)
  %46 = urem <2 x i32> %40, splat (i32 30)
  %47 = urem <2 x i32> %42, splat (i32 30)
  %48 = urem <2 x i32> %44, splat (i32 30)
  %49 = uitofp nneg <2 x i32> %45 to <2 x double>
  %50 = uitofp nneg <2 x i32> %46 to <2 x double>
  %51 = uitofp nneg <2 x i32> %47 to <2 x double>
  %52 = uitofp nneg <2 x i32> %48 to <2 x double>
  %53 = fdiv <2 x double> %49, splat (double 3.000000e+01)
  %54 = fdiv <2 x double> %50, splat (double 3.000000e+01)
  %55 = fdiv <2 x double> %51, splat (double 3.000000e+01)
  %56 = fdiv <2 x double> %52, splat (double 3.000000e+01)
  %57 = getelementptr inbounds nuw [20 x [30 x double]], ptr %3, i64 %7, i64 %9, i64 8
  %58 = getelementptr inbounds nuw i8, ptr %57, i64 16
  %59 = getelementptr inbounds nuw i8, ptr %57, i64 32
  %60 = getelementptr inbounds nuw i8, ptr %57, i64 48
  store <2 x double> %53, ptr %57, align 8, !tbaa !6
  store <2 x double> %54, ptr %58, align 8, !tbaa !6
  store <2 x double> %55, ptr %59, align 8, !tbaa !6
  store <2 x double> %56, ptr %60, align 8, !tbaa !6
  %61 = trunc <2 x i64> %12 to <2 x i32>
  %62 = add <2 x i32> %61, <i32 16, i32 17>
  %63 = trunc <2 x i64> %12 to <2 x i32>
  %64 = add <2 x i32> %63, <i32 18, i32 19>
  %65 = trunc <2 x i64> %12 to <2 x i32>
  %66 = add <2 x i32> %65, <i32 20, i32 21>
  %67 = trunc <2 x i64> %12 to <2 x i32>
  %68 = add <2 x i32> %67, <i32 22, i32 23>
  %69 = urem <2 x i32> %62, splat (i32 30)
  %70 = urem <2 x i32> %64, splat (i32 30)
  %71 = urem <2 x i32> %66, splat (i32 30)
  %72 = urem <2 x i32> %68, splat (i32 30)
  %73 = uitofp nneg <2 x i32> %69 to <2 x double>
  %74 = uitofp nneg <2 x i32> %70 to <2 x double>
  %75 = uitofp nneg <2 x i32> %71 to <2 x double>
  %76 = uitofp nneg <2 x i32> %72 to <2 x double>
  %77 = fdiv <2 x double> %73, splat (double 3.000000e+01)
  %78 = fdiv <2 x double> %74, splat (double 3.000000e+01)
  %79 = fdiv <2 x double> %75, splat (double 3.000000e+01)
  %80 = fdiv <2 x double> %76, splat (double 3.000000e+01)
  %81 = getelementptr inbounds nuw [20 x [30 x double]], ptr %3, i64 %7, i64 %9, i64 16
  %82 = getelementptr inbounds nuw i8, ptr %81, i64 16
  %83 = getelementptr inbounds nuw i8, ptr %81, i64 32
  %84 = getelementptr inbounds nuw i8, ptr %81, i64 48
  store <2 x double> %77, ptr %81, align 8, !tbaa !6
  store <2 x double> %78, ptr %82, align 8, !tbaa !6
  store <2 x double> %79, ptr %83, align 8, !tbaa !6
  store <2 x double> %80, ptr %84, align 8, !tbaa !6
  %85 = trunc i64 %10 to i32
  %86 = add i32 %85, 24
  %87 = urem i32 %86, 30
  %88 = uitofp nneg i32 %87 to double
  %89 = fdiv double %88, 3.000000e+01
  %90 = getelementptr inbounds nuw [20 x [30 x double]], ptr %3, i64 %7, i64 %9, i64 24
  store double %89, ptr %90, align 8, !tbaa !6
  %91 = trunc i64 %10 to i32
  %92 = add i32 %91, 25
  %93 = urem i32 %92, 30
  %94 = uitofp nneg i32 %93 to double
  %95 = fdiv double %94, 3.000000e+01
  %96 = getelementptr inbounds nuw [20 x [30 x double]], ptr %3, i64 %7, i64 %9, i64 25
  store double %95, ptr %96, align 8, !tbaa !6
  %97 = trunc i64 %10 to i32
  %98 = add i32 %97, 26
  %99 = urem i32 %98, 30
  %100 = uitofp nneg i32 %99 to double
  %101 = fdiv double %100, 3.000000e+01
  %102 = getelementptr inbounds nuw [20 x [30 x double]], ptr %3, i64 %7, i64 %9, i64 26
  store double %101, ptr %102, align 8, !tbaa !6
  %103 = trunc i64 %10 to i32
  %104 = add i32 %103, 27
  %105 = urem i32 %104, 30
  %106 = uitofp nneg i32 %105 to double
  %107 = fdiv double %106, 3.000000e+01
  %108 = getelementptr inbounds nuw [20 x [30 x double]], ptr %3, i64 %7, i64 %9, i64 27
  store double %107, ptr %108, align 8, !tbaa !6
  %109 = trunc i64 %10 to i32
  %110 = add i32 %109, 28
  %111 = urem i32 %110, 30
  %112 = uitofp nneg i32 %111 to double
  %113 = fdiv double %112, 3.000000e+01
  %114 = getelementptr inbounds nuw [20 x [30 x double]], ptr %3, i64 %7, i64 %9, i64 28
  store double %113, ptr %114, align 8, !tbaa !6
  %115 = trunc i64 %10 to i32
  %116 = add i32 %115, 29
  %117 = urem i32 %116, 30
  %118 = uitofp nneg i32 %117 to double
  %119 = fdiv double %118, 3.000000e+01
  %120 = getelementptr inbounds nuw [20 x [30 x double]], ptr %3, i64 %7, i64 %9, i64 29
  store double %119, ptr %120, align 8, !tbaa !6
  %121 = add nuw nsw i64 %9, 1
  %122 = icmp eq i64 %121, 20
  br i1 %122, label %123, label %8, !llvm.loop !19

123:                                              ; preds = %8
  %124 = add nuw nsw i64 %7, 1
  %125 = icmp eq i64 %124, 25
  br i1 %125, label %126, label %6, !llvm.loop !20

126:                                              ; preds = %123, %142
  %127 = phi i64 [ %143, %142 ], [ 0, %123 ]
  %128 = insertelement <2 x i64> poison, i64 %127, i64 0
  %129 = shufflevector <2 x i64> %128, <2 x i64> poison, <2 x i32> zeroinitializer
  br label %130

130:                                              ; preds = %130, %126
  %131 = phi i64 [ 0, %126 ], [ %139, %130 ]
  %132 = phi <2 x i64> [ <i64 0, i64 1>, %126 ], [ %140, %130 ]
  %133 = mul nuw nsw <2 x i64> %132, %129
  %134 = trunc nuw nsw <2 x i64> %133 to <2 x i32>
  %135 = urem <2 x i32> %134, splat (i32 30)
  %136 = uitofp nneg <2 x i32> %135 to <2 x double>
  %137 = fdiv <2 x double> %136, splat (double 3.000000e+01)
  %138 = getelementptr inbounds nuw [30 x double], ptr %5, i64 %127, i64 %131
  store <2 x double> %137, ptr %138, align 8, !tbaa !6
  %139 = add nuw i64 %131, 2
  %140 = add <2 x i64> %132, splat (i64 2)
  %141 = icmp eq i64 %139, 30
  br i1 %141, label %142, label %130, !llvm.loop !21

142:                                              ; preds = %130
  %143 = add nuw nsw i64 %127, 1
  %144 = icmp eq i64 %143, 30
  br i1 %144, label %145, label %126, !llvm.loop !22

145:                                              ; preds = %142
  tail call void @polybench_timer_start() #7
  %146 = getelementptr inbounds nuw i8, ptr %4, i64 8
  %147 = getelementptr inbounds nuw i8, ptr %4, i64 16
  %148 = getelementptr inbounds nuw i8, ptr %4, i64 24
  %149 = getelementptr inbounds nuw i8, ptr %4, i64 32
  %150 = getelementptr inbounds nuw i8, ptr %4, i64 40
  %151 = getelementptr inbounds nuw i8, ptr %4, i64 48
  %152 = getelementptr inbounds nuw i8, ptr %4, i64 56
  %153 = getelementptr inbounds nuw i8, ptr %4, i64 64
  %154 = getelementptr inbounds nuw i8, ptr %4, i64 72
  %155 = getelementptr inbounds nuw i8, ptr %4, i64 80
  %156 = getelementptr inbounds nuw i8, ptr %4, i64 88
  %157 = getelementptr inbounds nuw i8, ptr %4, i64 96
  %158 = getelementptr inbounds nuw i8, ptr %4, i64 104
  %159 = getelementptr inbounds nuw i8, ptr %4, i64 112
  %160 = getelementptr inbounds nuw i8, ptr %4, i64 120
  %161 = getelementptr inbounds nuw i8, ptr %4, i64 128
  %162 = getelementptr inbounds nuw i8, ptr %4, i64 136
  %163 = getelementptr inbounds nuw i8, ptr %4, i64 144
  %164 = getelementptr inbounds nuw i8, ptr %4, i64 152
  %165 = getelementptr inbounds nuw i8, ptr %4, i64 160
  %166 = getelementptr inbounds nuw i8, ptr %4, i64 168
  %167 = getelementptr inbounds nuw i8, ptr %4, i64 176
  %168 = getelementptr inbounds nuw i8, ptr %4, i64 184
  %169 = getelementptr inbounds nuw i8, ptr %4, i64 192
  %170 = getelementptr inbounds nuw i8, ptr %4, i64 200
  %171 = getelementptr inbounds nuw i8, ptr %4, i64 208
  %172 = getelementptr inbounds nuw i8, ptr %4, i64 216
  %173 = getelementptr inbounds nuw i8, ptr %4, i64 224
  %174 = getelementptr inbounds nuw i8, ptr %4, i64 232
  br label %175

175:                                              ; preds = %258, %145
  %176 = phi i64 [ 0, %145 ], [ %259, %258 ]
  br label %177

177:                                              ; preds = %195, %175
  %178 = phi i64 [ %256, %195 ], [ 0, %175 ]
  br label %179

179:                                              ; preds = %192, %177
  %180 = phi i64 [ %193, %192 ], [ 0, %177 ]
  %181 = getelementptr inbounds nuw double, ptr %4, i64 %180
  store double 0.000000e+00, ptr %181, align 8, !tbaa !6
  br label %182

182:                                              ; preds = %182, %179
  %183 = phi i64 [ 0, %179 ], [ %190, %182 ]
  %184 = phi double [ 0.000000e+00, %179 ], [ %189, %182 ]
  %185 = getelementptr inbounds nuw [20 x [30 x double]], ptr %3, i64 %176, i64 %178, i64 %183
  %186 = load double, ptr %185, align 8, !tbaa !6
  %187 = getelementptr inbounds nuw [30 x double], ptr %5, i64 %183, i64 %180
  %188 = load double, ptr %187, align 8, !tbaa !6
  %189 = tail call double @llvm.fmuladd.f64(double %186, double %188, double %184)
  store double %189, ptr %181, align 8, !tbaa !6
  %190 = add nuw nsw i64 %183, 1
  %191 = icmp eq i64 %190, 30
  br i1 %191, label %192, label %182, !llvm.loop !14

192:                                              ; preds = %182
  %193 = add nuw nsw i64 %180, 1
  %194 = icmp eq i64 %193, 30
  br i1 %194, label %195, label %179, !llvm.loop !15

195:                                              ; preds = %192
  %196 = load double, ptr %4, align 8, !tbaa !6
  %197 = getelementptr inbounds nuw [20 x [30 x double]], ptr %3, i64 %176, i64 %178, i64 0
  store double %196, ptr %197, align 8, !tbaa !6
  %198 = load double, ptr %146, align 8, !tbaa !6
  %199 = getelementptr inbounds nuw [20 x [30 x double]], ptr %3, i64 %176, i64 %178, i64 1
  store double %198, ptr %199, align 8, !tbaa !6
  %200 = load double, ptr %147, align 8, !tbaa !6
  %201 = getelementptr inbounds nuw [20 x [30 x double]], ptr %3, i64 %176, i64 %178, i64 2
  store double %200, ptr %201, align 8, !tbaa !6
  %202 = load double, ptr %148, align 8, !tbaa !6
  %203 = getelementptr inbounds nuw [20 x [30 x double]], ptr %3, i64 %176, i64 %178, i64 3
  store double %202, ptr %203, align 8, !tbaa !6
  %204 = load double, ptr %149, align 8, !tbaa !6
  %205 = getelementptr inbounds nuw [20 x [30 x double]], ptr %3, i64 %176, i64 %178, i64 4
  store double %204, ptr %205, align 8, !tbaa !6
  %206 = load double, ptr %150, align 8, !tbaa !6
  %207 = getelementptr inbounds nuw [20 x [30 x double]], ptr %3, i64 %176, i64 %178, i64 5
  store double %206, ptr %207, align 8, !tbaa !6
  %208 = load double, ptr %151, align 8, !tbaa !6
  %209 = getelementptr inbounds nuw [20 x [30 x double]], ptr %3, i64 %176, i64 %178, i64 6
  store double %208, ptr %209, align 8, !tbaa !6
  %210 = load double, ptr %152, align 8, !tbaa !6
  %211 = getelementptr inbounds nuw [20 x [30 x double]], ptr %3, i64 %176, i64 %178, i64 7
  store double %210, ptr %211, align 8, !tbaa !6
  %212 = load double, ptr %153, align 8, !tbaa !6
  %213 = getelementptr inbounds nuw [20 x [30 x double]], ptr %3, i64 %176, i64 %178, i64 8
  store double %212, ptr %213, align 8, !tbaa !6
  %214 = load double, ptr %154, align 8, !tbaa !6
  %215 = getelementptr inbounds nuw [20 x [30 x double]], ptr %3, i64 %176, i64 %178, i64 9
  store double %214, ptr %215, align 8, !tbaa !6
  %216 = load double, ptr %155, align 8, !tbaa !6
  %217 = getelementptr inbounds nuw [20 x [30 x double]], ptr %3, i64 %176, i64 %178, i64 10
  store double %216, ptr %217, align 8, !tbaa !6
  %218 = load double, ptr %156, align 8, !tbaa !6
  %219 = getelementptr inbounds nuw [20 x [30 x double]], ptr %3, i64 %176, i64 %178, i64 11
  store double %218, ptr %219, align 8, !tbaa !6
  %220 = load double, ptr %157, align 8, !tbaa !6
  %221 = getelementptr inbounds nuw [20 x [30 x double]], ptr %3, i64 %176, i64 %178, i64 12
  store double %220, ptr %221, align 8, !tbaa !6
  %222 = load double, ptr %158, align 8, !tbaa !6
  %223 = getelementptr inbounds nuw [20 x [30 x double]], ptr %3, i64 %176, i64 %178, i64 13
  store double %222, ptr %223, align 8, !tbaa !6
  %224 = load double, ptr %159, align 8, !tbaa !6
  %225 = getelementptr inbounds nuw [20 x [30 x double]], ptr %3, i64 %176, i64 %178, i64 14
  store double %224, ptr %225, align 8, !tbaa !6
  %226 = load double, ptr %160, align 8, !tbaa !6
  %227 = getelementptr inbounds nuw [20 x [30 x double]], ptr %3, i64 %176, i64 %178, i64 15
  store double %226, ptr %227, align 8, !tbaa !6
  %228 = load double, ptr %161, align 8, !tbaa !6
  %229 = getelementptr inbounds nuw [20 x [30 x double]], ptr %3, i64 %176, i64 %178, i64 16
  store double %228, ptr %229, align 8, !tbaa !6
  %230 = load double, ptr %162, align 8, !tbaa !6
  %231 = getelementptr inbounds nuw [20 x [30 x double]], ptr %3, i64 %176, i64 %178, i64 17
  store double %230, ptr %231, align 8, !tbaa !6
  %232 = load double, ptr %163, align 8, !tbaa !6
  %233 = getelementptr inbounds nuw [20 x [30 x double]], ptr %3, i64 %176, i64 %178, i64 18
  store double %232, ptr %233, align 8, !tbaa !6
  %234 = load double, ptr %164, align 8, !tbaa !6
  %235 = getelementptr inbounds nuw [20 x [30 x double]], ptr %3, i64 %176, i64 %178, i64 19
  store double %234, ptr %235, align 8, !tbaa !6
  %236 = load double, ptr %165, align 8, !tbaa !6
  %237 = getelementptr inbounds nuw [20 x [30 x double]], ptr %3, i64 %176, i64 %178, i64 20
  store double %236, ptr %237, align 8, !tbaa !6
  %238 = load double, ptr %166, align 8, !tbaa !6
  %239 = getelementptr inbounds nuw [20 x [30 x double]], ptr %3, i64 %176, i64 %178, i64 21
  store double %238, ptr %239, align 8, !tbaa !6
  %240 = load double, ptr %167, align 8, !tbaa !6
  %241 = getelementptr inbounds nuw [20 x [30 x double]], ptr %3, i64 %176, i64 %178, i64 22
  store double %240, ptr %241, align 8, !tbaa !6
  %242 = load double, ptr %168, align 8, !tbaa !6
  %243 = getelementptr inbounds nuw [20 x [30 x double]], ptr %3, i64 %176, i64 %178, i64 23
  store double %242, ptr %243, align 8, !tbaa !6
  %244 = load double, ptr %169, align 8, !tbaa !6
  %245 = getelementptr inbounds nuw [20 x [30 x double]], ptr %3, i64 %176, i64 %178, i64 24
  store double %244, ptr %245, align 8, !tbaa !6
  %246 = load double, ptr %170, align 8, !tbaa !6
  %247 = getelementptr inbounds nuw [20 x [30 x double]], ptr %3, i64 %176, i64 %178, i64 25
  store double %246, ptr %247, align 8, !tbaa !6
  %248 = load double, ptr %171, align 8, !tbaa !6
  %249 = getelementptr inbounds nuw [20 x [30 x double]], ptr %3, i64 %176, i64 %178, i64 26
  store double %248, ptr %249, align 8, !tbaa !6
  %250 = load double, ptr %172, align 8, !tbaa !6
  %251 = getelementptr inbounds nuw [20 x [30 x double]], ptr %3, i64 %176, i64 %178, i64 27
  store double %250, ptr %251, align 8, !tbaa !6
  %252 = load double, ptr %173, align 8, !tbaa !6
  %253 = getelementptr inbounds nuw [20 x [30 x double]], ptr %3, i64 %176, i64 %178, i64 28
  store double %252, ptr %253, align 8, !tbaa !6
  %254 = load double, ptr %174, align 8, !tbaa !6
  %255 = getelementptr inbounds nuw [20 x [30 x double]], ptr %3, i64 %176, i64 %178, i64 29
  store double %254, ptr %255, align 8, !tbaa !6
  %256 = add nuw nsw i64 %178, 1
  %257 = icmp eq i64 %256, 20
  br i1 %257, label %258, label %177, !llvm.loop !17

258:                                              ; preds = %195
  %259 = add nuw nsw i64 %176, 1
  %260 = icmp eq i64 %259, 25
  br i1 %260, label %261, label %175, !llvm.loop !18

261:                                              ; preds = %258
  tail call void @polybench_timer_stop() #7
  tail call void @polybench_timer_print() #7
  %262 = icmp sgt i32 %0, 42
  br i1 %262, label %263, label %306

263:                                              ; preds = %261
  %264 = load ptr, ptr %1, align 8, !tbaa !23
  %265 = load i8, ptr %264, align 1
  %266 = icmp eq i8 %265, 0
  br i1 %266, label %267, label %306

267:                                              ; preds = %263
  %268 = load ptr, ptr @__stderrp, align 8, !tbaa !26
  %269 = tail call i64 @fwrite(ptr nonnull @.str.1, i64 22, i64 1, ptr %268)
  %270 = load ptr, ptr @__stderrp, align 8, !tbaa !26
  %271 = tail call i32 (ptr, ptr, ...) @fprintf(ptr noundef %270, ptr noundef nonnull @.str.2, ptr noundef nonnull @.str.3) #7
  br label %272

272:                                              ; preds = %298, %267
  %273 = phi i64 [ 0, %267 ], [ %299, %298 ]
  %274 = mul nuw nsw i64 %273, 600
  br label %275

275:                                              ; preds = %295, %272
  %276 = phi i64 [ 0, %272 ], [ %296, %295 ]
  %277 = mul nuw nsw i64 %276, 30
  %278 = add nuw nsw i64 %277, %274
  br label %279

279:                                              ; preds = %288, %275
  %280 = phi i64 [ 0, %275 ], [ %293, %288 ]
  %281 = add nuw nsw i64 %278, %280
  %282 = trunc nuw nsw i64 %281 to i32
  %283 = urem i32 %282, 20
  %284 = icmp eq i32 %283, 0
  br i1 %284, label %285, label %288

285:                                              ; preds = %279
  %286 = load ptr, ptr @__stderrp, align 8, !tbaa !26
  %287 = tail call i32 @fputc(i32 10, ptr %286)
  br label %288

288:                                              ; preds = %285, %279
  %289 = load ptr, ptr @__stderrp, align 8, !tbaa !26
  %290 = getelementptr inbounds nuw [20 x [30 x double]], ptr %3, i64 %273, i64 %276, i64 %280
  %291 = load double, ptr %290, align 8, !tbaa !6
  %292 = tail call i32 (ptr, ptr, ...) @fprintf(ptr noundef %289, ptr noundef nonnull @.str.5, double noundef %291) #7
  %293 = add nuw nsw i64 %280, 1
  %294 = icmp eq i64 %293, 30
  br i1 %294, label %295, label %279, !llvm.loop !28

295:                                              ; preds = %288
  %296 = add nuw nsw i64 %276, 1
  %297 = icmp eq i64 %296, 20
  br i1 %297, label %298, label %275, !llvm.loop !29

298:                                              ; preds = %295
  %299 = add nuw nsw i64 %273, 1
  %300 = icmp eq i64 %299, 25
  br i1 %300, label %301, label %272, !llvm.loop !30

301:                                              ; preds = %298
  %302 = load ptr, ptr @__stderrp, align 8, !tbaa !26
  %303 = tail call i32 (ptr, ptr, ...) @fprintf(ptr noundef %302, ptr noundef nonnull @.str.6, ptr noundef nonnull @.str.3) #7
  %304 = load ptr, ptr @__stderrp, align 8, !tbaa !26
  %305 = tail call i64 @fwrite(ptr nonnull @.str.7, i64 22, i64 1, ptr %304)
  br label %306

306:                                              ; preds = %301, %263, %261
  tail call void @free(ptr noundef nonnull %3)
  tail call void @free(ptr noundef %4)
  tail call void @free(ptr noundef %5)
  ret i32 0
}

declare ptr @polybench_alloc_data(i64 noundef, i32 noundef) local_unnamed_addr #3

declare void @polybench_timer_start(...) local_unnamed_addr #3

declare void @polybench_timer_stop(...) local_unnamed_addr #3

declare void @polybench_timer_print(...) local_unnamed_addr #3

; Function Attrs: mustprogress nounwind willreturn allockind("free") memory(argmem: readwrite, inaccessiblemem: readwrite)
declare void @free(ptr allocptr noundef captures(none)) local_unnamed_addr #4

; Function Attrs: nofree nounwind
declare noundef i32 @fprintf(ptr noundef captures(none), ptr noundef readonly captures(none), ...) local_unnamed_addr #5

; Function Attrs: nofree nounwind
declare noundef i64 @fwrite(ptr noundef readonly captures(none), i64 noundef, i64 noundef, ptr noundef captures(none)) local_unnamed_addr #6

; Function Attrs: nofree nounwind
declare noundef i32 @fputc(i32 noundef, ptr noundef captures(none)) local_unnamed_addr #6

attributes #0 = { nofree norecurse nosync nounwind ssp memory(argmem: readwrite) uwtable(sync) "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+ccpp,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a" }
attributes #1 = { mustprogress nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #2 = { nounwind ssp uwtable(sync) "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+ccpp,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a" }
attributes #3 = { "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+ccpp,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a" }
attributes #4 = { mustprogress nounwind willreturn allockind("free") memory(argmem: readwrite, inaccessiblemem: readwrite) "alloc-family"="malloc" "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+ccpp,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a" }
attributes #5 = { nofree nounwind "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+ccpp,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a" }
attributes #6 = { nofree nounwind }
attributes #7 = { nounwind }

!llvm.module.flags = !{!0, !1, !2, !3, !4}
!llvm.ident = !{!5}

!0 = !{i32 2, !"SDK Version", [2 x i32] [i32 15, i32 2]}
!1 = !{i32 1, !"wchar_size", i32 4}
!2 = !{i32 8, !"PIC Level", i32 2}
!3 = !{i32 7, !"uwtable", i32 1}
!4 = !{i32 7, !"frame-pointer", i32 1}
!5 = !{!"Homebrew clang version 21.1.2"}
!6 = !{!7, !7, i64 0}
!7 = !{!"double", !8, i64 0}
!8 = !{!"omnipotent char", !9, i64 0}
!9 = !{!"Simple C/C++ TBAA"}
!10 = distinct !{!10, !11, !12, !13}
!11 = !{!"llvm.loop.mustprogress"}
!12 = !{!"llvm.loop.isvectorized", i32 1}
!13 = !{!"llvm.loop.unroll.runtime.disable"}
!14 = distinct !{!14, !11}
!15 = distinct !{!15, !11}
!16 = distinct !{!16, !11, !12}
!17 = distinct !{!17, !11}
!18 = distinct !{!18, !11}
!19 = distinct !{!19, !11}
!20 = distinct !{!20, !11}
!21 = distinct !{!21, !11, !12, !13}
!22 = distinct !{!22, !11}
!23 = !{!24, !24, i64 0}
!24 = !{!"p1 omnipotent char", !25, i64 0}
!25 = !{!"any pointer", !8, i64 0}
!26 = !{!27, !27, i64 0}
!27 = !{!"p1 _ZTS7__sFILE", !25, i64 0}
!28 = distinct !{!28, !11}
!29 = distinct !{!29, !11}
!30 = distinct !{!30, !11}
