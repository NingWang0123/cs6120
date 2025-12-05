; ModuleID = 'polybench_results/fdtd-2d.ll'
source_filename = "./polybench/stencils/fdtd-2d/fdtd-2d.c"
target datalayout = "e-m:o-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-n32:64-S128-Fn32"
target triple = "arm64-apple-macosx15.0.0"

@__stderrp = external local_unnamed_addr global ptr, align 8
@.str.1 = private unnamed_addr constant [23 x i8] c"==BEGIN DUMP_ARRAYS==\0A\00", align 1
@.str.2 = private unnamed_addr constant [15 x i8] c"begin dump: %s\00", align 1
@.str.3 = private unnamed_addr constant [3 x i8] c"ex\00", align 1
@.str.5 = private unnamed_addr constant [8 x i8] c"%0.2lf \00", align 1
@.str.6 = private unnamed_addr constant [17 x i8] c"\0Aend   dump: %s\0A\00", align 1
@.str.7 = private unnamed_addr constant [23 x i8] c"==END   DUMP_ARRAYS==\0A\00", align 1
@.str.8 = private unnamed_addr constant [3 x i8] c"ey\00", align 1
@.str.9 = private unnamed_addr constant [3 x i8] c"hz\00", align 1

; Function Attrs: nounwind ssp uwtable(sync)
define noundef i32 @main(i32 noundef %0, ptr noundef readonly captures(none) %1) local_unnamed_addr #0 {
  %3 = tail call ptr @polybench_alloc_data(i64 noundef 4800, i32 noundef 8) #6
  %4 = tail call ptr @polybench_alloc_data(i64 noundef 4800, i32 noundef 8) #6
  %5 = tail call ptr @polybench_alloc_data(i64 noundef 4800, i32 noundef 8) #6
  %6 = tail call ptr @polybench_alloc_data(i64 noundef 40, i32 noundef 8) #6
  store <2 x double> <double 0.000000e+00, double 1.000000e+00>, ptr %6, align 8, !tbaa !6
  %7 = getelementptr inbounds nuw i8, ptr %6, i64 16
  store <2 x double> <double 2.000000e+00, double 3.000000e+00>, ptr %7, align 8, !tbaa !6
  %8 = getelementptr inbounds nuw i8, ptr %6, i64 32
  store <2 x double> <double 4.000000e+00, double 5.000000e+00>, ptr %8, align 8, !tbaa !6
  %9 = getelementptr inbounds nuw i8, ptr %6, i64 48
  store <2 x double> <double 6.000000e+00, double 7.000000e+00>, ptr %9, align 8, !tbaa !6
  %10 = getelementptr inbounds nuw i8, ptr %6, i64 64
  store <2 x double> <double 8.000000e+00, double 9.000000e+00>, ptr %10, align 8, !tbaa !6
  %11 = getelementptr inbounds nuw i8, ptr %6, i64 80
  store <2 x double> <double 1.000000e+01, double 1.100000e+01>, ptr %11, align 8, !tbaa !6
  %12 = getelementptr inbounds nuw i8, ptr %6, i64 96
  store <2 x double> <double 1.200000e+01, double 1.300000e+01>, ptr %12, align 8, !tbaa !6
  %13 = getelementptr inbounds nuw i8, ptr %6, i64 112
  store <2 x double> <double 1.400000e+01, double 1.500000e+01>, ptr %13, align 8, !tbaa !6
  %14 = getelementptr inbounds nuw i8, ptr %6, i64 128
  store <2 x double> <double 1.600000e+01, double 1.700000e+01>, ptr %14, align 8, !tbaa !6
  %15 = getelementptr inbounds nuw i8, ptr %6, i64 144
  store <2 x double> <double 1.800000e+01, double 1.900000e+01>, ptr %15, align 8, !tbaa !6
  %16 = getelementptr inbounds nuw i8, ptr %6, i64 160
  store <2 x double> <double 2.000000e+01, double 2.100000e+01>, ptr %16, align 8, !tbaa !6
  %17 = getelementptr inbounds nuw i8, ptr %6, i64 176
  store <2 x double> <double 2.200000e+01, double 2.300000e+01>, ptr %17, align 8, !tbaa !6
  %18 = getelementptr inbounds nuw i8, ptr %6, i64 192
  store <2 x double> <double 2.400000e+01, double 2.500000e+01>, ptr %18, align 8, !tbaa !6
  %19 = getelementptr inbounds nuw i8, ptr %6, i64 208
  store <2 x double> <double 2.600000e+01, double 2.700000e+01>, ptr %19, align 8, !tbaa !6
  %20 = getelementptr inbounds nuw i8, ptr %6, i64 224
  store <2 x double> <double 2.800000e+01, double 2.900000e+01>, ptr %20, align 8, !tbaa !6
  %21 = getelementptr inbounds nuw i8, ptr %6, i64 240
  store <2 x double> <double 3.000000e+01, double 3.100000e+01>, ptr %21, align 8, !tbaa !6
  %22 = getelementptr inbounds nuw i8, ptr %6, i64 256
  store <2 x double> <double 3.200000e+01, double 3.300000e+01>, ptr %22, align 8, !tbaa !6
  %23 = getelementptr inbounds nuw i8, ptr %6, i64 272
  store <2 x double> <double 3.400000e+01, double 3.500000e+01>, ptr %23, align 8, !tbaa !6
  %24 = getelementptr inbounds nuw i8, ptr %6, i64 288
  store <2 x double> <double 3.600000e+01, double 3.700000e+01>, ptr %24, align 8, !tbaa !6
  %25 = getelementptr inbounds nuw i8, ptr %6, i64 304
  store <2 x double> <double 3.800000e+01, double 3.900000e+01>, ptr %25, align 8, !tbaa !6
  br label %26

26:                                               ; preds = %49, %2
  %27 = phi i64 [ 0, %2 ], [ %50, %49 ]
  br label %28

28:                                               ; preds = %28, %26
  %29 = phi i64 [ 0, %26 ], [ %30, %28 ]
  %30 = add nuw nsw i64 %29, 1
  %31 = mul nuw nsw i64 %30, %27
  %32 = trunc nuw nsw i64 %31 to i32
  %33 = uitofp nneg i32 %32 to double
  %34 = fdiv double %33, 6.000000e+01
  %35 = getelementptr inbounds nuw [80 x double], ptr %3, i64 %27, i64 %29
  store double %34, ptr %35, align 8, !tbaa !6
  %36 = add nuw nsw i64 %29, 2
  %37 = mul nuw nsw i64 %36, %27
  %38 = trunc nuw nsw i64 %37 to i32
  %39 = uitofp nneg i32 %38 to double
  %40 = fdiv double %39, 8.000000e+01
  %41 = getelementptr inbounds nuw [80 x double], ptr %4, i64 %27, i64 %29
  store double %40, ptr %41, align 8, !tbaa !6
  %42 = add nuw nsw i64 %29, 3
  %43 = mul nuw nsw i64 %42, %27
  %44 = trunc nuw nsw i64 %43 to i32
  %45 = uitofp nneg i32 %44 to double
  %46 = fdiv double %45, 6.000000e+01
  %47 = getelementptr inbounds nuw [80 x double], ptr %5, i64 %27, i64 %29
  store double %46, ptr %47, align 8, !tbaa !6
  %48 = icmp eq i64 %30, 80
  br i1 %48, label %49, label %28, !llvm.loop !10

49:                                               ; preds = %28
  %50 = add nuw nsw i64 %27, 1
  %51 = icmp eq i64 %50, 60
  br i1 %51, label %52, label %26, !llvm.loop !12

52:                                               ; preds = %49
  tail call void @polybench_timer_start() #6
  %53 = getelementptr i8, ptr %5, i64 -640
  %54 = getelementptr i8, ptr %4, i64 640
  %55 = getelementptr i8, ptr %5, i64 37752
  %56 = getelementptr i8, ptr %3, i64 37760
  %57 = getelementptr i8, ptr %4, i64 38392
  %58 = getelementptr i8, ptr %3, i64 8
  %59 = getelementptr i8, ptr %3, i64 38400
  %60 = getelementptr i8, ptr %5, i64 38400
  %61 = getelementptr i8, ptr %4, i64 38400
  %62 = getelementptr inbounds nuw i8, ptr %4, i64 16
  %63 = getelementptr inbounds nuw i8, ptr %4, i64 32
  %64 = getelementptr inbounds nuw i8, ptr %4, i64 48
  %65 = getelementptr inbounds nuw i8, ptr %4, i64 64
  %66 = getelementptr inbounds nuw i8, ptr %4, i64 80
  %67 = getelementptr inbounds nuw i8, ptr %4, i64 96
  %68 = getelementptr inbounds nuw i8, ptr %4, i64 112
  %69 = getelementptr inbounds nuw i8, ptr %4, i64 128
  %70 = getelementptr inbounds nuw i8, ptr %4, i64 144
  %71 = getelementptr inbounds nuw i8, ptr %4, i64 160
  %72 = getelementptr inbounds nuw i8, ptr %4, i64 176
  %73 = getelementptr inbounds nuw i8, ptr %4, i64 192
  %74 = getelementptr inbounds nuw i8, ptr %4, i64 208
  %75 = getelementptr inbounds nuw i8, ptr %4, i64 224
  %76 = getelementptr inbounds nuw i8, ptr %4, i64 240
  %77 = getelementptr inbounds nuw i8, ptr %4, i64 256
  %78 = getelementptr inbounds nuw i8, ptr %4, i64 272
  %79 = getelementptr inbounds nuw i8, ptr %4, i64 288
  %80 = getelementptr inbounds nuw i8, ptr %4, i64 304
  %81 = getelementptr inbounds nuw i8, ptr %4, i64 320
  %82 = getelementptr inbounds nuw i8, ptr %4, i64 336
  %83 = getelementptr inbounds nuw i8, ptr %4, i64 352
  %84 = getelementptr inbounds nuw i8, ptr %4, i64 368
  %85 = getelementptr inbounds nuw i8, ptr %4, i64 384
  %86 = getelementptr inbounds nuw i8, ptr %4, i64 400
  %87 = getelementptr inbounds nuw i8, ptr %4, i64 416
  %88 = getelementptr inbounds nuw i8, ptr %4, i64 432
  %89 = getelementptr inbounds nuw i8, ptr %4, i64 448
  %90 = getelementptr inbounds nuw i8, ptr %4, i64 464
  %91 = getelementptr inbounds nuw i8, ptr %4, i64 480
  %92 = getelementptr inbounds nuw i8, ptr %4, i64 496
  %93 = getelementptr inbounds nuw i8, ptr %4, i64 512
  %94 = getelementptr inbounds nuw i8, ptr %4, i64 528
  %95 = getelementptr inbounds nuw i8, ptr %4, i64 544
  %96 = getelementptr inbounds nuw i8, ptr %4, i64 560
  %97 = getelementptr inbounds nuw i8, ptr %4, i64 576
  %98 = getelementptr inbounds nuw i8, ptr %4, i64 592
  %99 = getelementptr inbounds nuw i8, ptr %4, i64 608
  %100 = getelementptr inbounds nuw i8, ptr %4, i64 624
  %101 = icmp ult ptr %54, %60
  %102 = icmp ult ptr %5, %61
  %103 = and i1 %101, %102
  %104 = icmp ult ptr %58, %60
  %105 = icmp ult ptr %5, %59
  %106 = and i1 %104, %105
  %107 = icmp ult ptr %5, %56
  %108 = icmp ult ptr %3, %55
  %109 = and i1 %107, %108
  %110 = icmp ult ptr %5, %57
  %111 = icmp ult ptr %4, %55
  %112 = and i1 %110, %111
  %113 = or i1 %109, %112
  br label %114

114:                                              ; preds = %316, %52
  %115 = phi i64 [ 0, %52 ], [ %317, %316 ]
  %116 = getelementptr inbounds nuw double, ptr %6, i64 %115
  %117 = load double, ptr %116, align 8, !tbaa !6
  %118 = insertelement <2 x double> poison, double %117, i64 0
  %119 = shufflevector <2 x double> %118, <2 x double> poison, <2 x i32> zeroinitializer
  store <2 x double> %119, ptr %4, align 8, !tbaa !6
  store <2 x double> %119, ptr %62, align 8, !tbaa !6
  store <2 x double> %119, ptr %63, align 8, !tbaa !6
  store <2 x double> %119, ptr %64, align 8, !tbaa !6
  store <2 x double> %119, ptr %65, align 8, !tbaa !6
  store <2 x double> %119, ptr %66, align 8, !tbaa !6
  store <2 x double> %119, ptr %67, align 8, !tbaa !6
  store <2 x double> %119, ptr %68, align 8, !tbaa !6
  store <2 x double> %119, ptr %69, align 8, !tbaa !6
  store <2 x double> %119, ptr %70, align 8, !tbaa !6
  store <2 x double> %119, ptr %71, align 8, !tbaa !6
  store <2 x double> %119, ptr %72, align 8, !tbaa !6
  store <2 x double> %119, ptr %73, align 8, !tbaa !6
  store <2 x double> %119, ptr %74, align 8, !tbaa !6
  store <2 x double> %119, ptr %75, align 8, !tbaa !6
  store <2 x double> %119, ptr %76, align 8, !tbaa !6
  store <2 x double> %119, ptr %77, align 8, !tbaa !6
  store <2 x double> %119, ptr %78, align 8, !tbaa !6
  store <2 x double> %119, ptr %79, align 8, !tbaa !6
  store <2 x double> %119, ptr %80, align 8, !tbaa !6
  store <2 x double> %119, ptr %81, align 8, !tbaa !6
  store <2 x double> %119, ptr %82, align 8, !tbaa !6
  store <2 x double> %119, ptr %83, align 8, !tbaa !6
  store <2 x double> %119, ptr %84, align 8, !tbaa !6
  store <2 x double> %119, ptr %85, align 8, !tbaa !6
  store <2 x double> %119, ptr %86, align 8, !tbaa !6
  store <2 x double> %119, ptr %87, align 8, !tbaa !6
  store <2 x double> %119, ptr %88, align 8, !tbaa !6
  store <2 x double> %119, ptr %89, align 8, !tbaa !6
  store <2 x double> %119, ptr %90, align 8, !tbaa !6
  store <2 x double> %119, ptr %91, align 8, !tbaa !6
  store <2 x double> %119, ptr %92, align 8, !tbaa !6
  store <2 x double> %119, ptr %93, align 8, !tbaa !6
  store <2 x double> %119, ptr %94, align 8, !tbaa !6
  store <2 x double> %119, ptr %95, align 8, !tbaa !6
  store <2 x double> %119, ptr %96, align 8, !tbaa !6
  store <2 x double> %119, ptr %97, align 8, !tbaa !6
  store <2 x double> %119, ptr %98, align 8, !tbaa !6
  store <2 x double> %119, ptr %99, align 8, !tbaa !6
  store <2 x double> %119, ptr %100, align 8, !tbaa !6
  br label %120

120:                                              ; preds = %170, %114
  %121 = phi i64 [ %171, %170 ], [ 1, %114 ]
  br i1 %103, label %.preheader3, label %.preheader5

.preheader5:                                      ; preds = %120
  br label %122

.preheader3:                                      ; preds = %120
  br label %158

122:                                              ; preds = %.preheader5, %122
  %123 = phi i64 [ %156, %122 ], [ 0, %.preheader5 ]
  %124 = getelementptr inbounds nuw [80 x double], ptr %4, i64 %121, i64 %123
  %125 = getelementptr inbounds nuw i8, ptr %124, i64 16
  %126 = getelementptr inbounds nuw i8, ptr %124, i64 32
  %127 = getelementptr inbounds nuw i8, ptr %124, i64 48
  %128 = load <2 x double>, ptr %124, align 8, !tbaa !6, !alias.scope !13, !noalias !16
  %129 = load <2 x double>, ptr %125, align 8, !tbaa !6, !alias.scope !13, !noalias !16
  %130 = load <2 x double>, ptr %126, align 8, !tbaa !6, !alias.scope !13, !noalias !16
  %131 = load <2 x double>, ptr %127, align 8, !tbaa !6, !alias.scope !13, !noalias !16
  %132 = getelementptr inbounds nuw [80 x double], ptr %5, i64 %121, i64 %123
  %133 = getelementptr inbounds nuw i8, ptr %132, i64 16
  %134 = getelementptr inbounds nuw i8, ptr %132, i64 32
  %135 = getelementptr inbounds nuw i8, ptr %132, i64 48
  %136 = load <2 x double>, ptr %132, align 8, !tbaa !6, !alias.scope !16
  %137 = load <2 x double>, ptr %133, align 8, !tbaa !6, !alias.scope !16
  %138 = load <2 x double>, ptr %134, align 8, !tbaa !6, !alias.scope !16
  %139 = load <2 x double>, ptr %135, align 8, !tbaa !6, !alias.scope !16
  %140 = getelementptr [80 x double], ptr %53, i64 %121, i64 %123
  %141 = getelementptr i8, ptr %140, i64 16
  %142 = getelementptr i8, ptr %140, i64 32
  %143 = getelementptr i8, ptr %140, i64 48
  %144 = load <2 x double>, ptr %140, align 8, !tbaa !6, !alias.scope !16
  %145 = load <2 x double>, ptr %141, align 8, !tbaa !6, !alias.scope !16
  %146 = load <2 x double>, ptr %142, align 8, !tbaa !6, !alias.scope !16
  %147 = load <2 x double>, ptr %143, align 8, !tbaa !6, !alias.scope !16
  %148 = fsub <2 x double> %136, %144
  %149 = fsub <2 x double> %137, %145
  %150 = fsub <2 x double> %138, %146
  %151 = fsub <2 x double> %139, %147
  %152 = tail call <2 x double> @llvm.fmuladd.v2f64(<2 x double> %148, <2 x double> splat (double -5.000000e-01), <2 x double> %128)
  %153 = tail call <2 x double> @llvm.fmuladd.v2f64(<2 x double> %149, <2 x double> splat (double -5.000000e-01), <2 x double> %129)
  %154 = tail call <2 x double> @llvm.fmuladd.v2f64(<2 x double> %150, <2 x double> splat (double -5.000000e-01), <2 x double> %130)
  %155 = tail call <2 x double> @llvm.fmuladd.v2f64(<2 x double> %151, <2 x double> splat (double -5.000000e-01), <2 x double> %131)
  store <2 x double> %152, ptr %124, align 8, !tbaa !6, !alias.scope !13, !noalias !16
  store <2 x double> %153, ptr %125, align 8, !tbaa !6, !alias.scope !13, !noalias !16
  store <2 x double> %154, ptr %126, align 8, !tbaa !6, !alias.scope !13, !noalias !16
  store <2 x double> %155, ptr %127, align 8, !tbaa !6, !alias.scope !13, !noalias !16
  %156 = add nuw i64 %123, 8
  %157 = icmp eq i64 %156, 80
  br i1 %157, label %.loopexit6, label %122, !llvm.loop !18

158:                                              ; preds = %.preheader3, %158
  %159 = phi i64 [ %168, %158 ], [ 0, %.preheader3 ]
  %160 = getelementptr inbounds nuw [80 x double], ptr %4, i64 %121, i64 %159
  %161 = load double, ptr %160, align 8, !tbaa !6
  %162 = getelementptr inbounds nuw [80 x double], ptr %5, i64 %121, i64 %159
  %163 = load double, ptr %162, align 8, !tbaa !6
  %164 = getelementptr [80 x double], ptr %53, i64 %121, i64 %159
  %165 = load double, ptr %164, align 8, !tbaa !6
  %166 = fsub double %163, %165
  %167 = tail call double @llvm.fmuladd.f64(double %166, double -5.000000e-01, double %161)
  store double %167, ptr %160, align 8, !tbaa !6
  %168 = add nuw nsw i64 %159, 1
  %169 = icmp eq i64 %168, 80
  br i1 %169, label %.loopexit4, label %158, !llvm.loop !21

.loopexit4:                                       ; preds = %158
  br label %170

.loopexit6:                                       ; preds = %122
  br label %170

170:                                              ; preds = %.loopexit6, %.loopexit4
  %171 = add nuw nsw i64 %121, 1
  %172 = icmp eq i64 %171, 60
  br i1 %172, label %.preheader8, label %120, !llvm.loop !22

.preheader8:                                      ; preds = %170
  br label %173

173:                                              ; preds = %.preheader8, %227
  %174 = phi i64 [ %228, %227 ], [ 0, %.preheader8 ]
  br i1 %106, label %212, label %.preheader1

.preheader1:                                      ; preds = %173
  br label %175

175:                                              ; preds = %.preheader1, %175
  %176 = phi i64 [ %210, %175 ], [ 0, %.preheader1 ]
  %177 = or disjoint i64 %176, 1
  %178 = getelementptr inbounds nuw [80 x double], ptr %3, i64 %174, i64 %177
  %179 = getelementptr inbounds nuw i8, ptr %178, i64 16
  %180 = getelementptr inbounds nuw i8, ptr %178, i64 32
  %181 = getelementptr inbounds nuw i8, ptr %178, i64 48
  %182 = load <2 x double>, ptr %178, align 8, !tbaa !6, !alias.scope !23, !noalias !26
  %183 = load <2 x double>, ptr %179, align 8, !tbaa !6, !alias.scope !23, !noalias !26
  %184 = load <2 x double>, ptr %180, align 8, !tbaa !6, !alias.scope !23, !noalias !26
  %185 = load <2 x double>, ptr %181, align 8, !tbaa !6, !alias.scope !23, !noalias !26
  %186 = getelementptr inbounds nuw [80 x double], ptr %5, i64 %174, i64 %177
  %187 = getelementptr inbounds nuw i8, ptr %186, i64 16
  %188 = getelementptr inbounds nuw i8, ptr %186, i64 32
  %189 = getelementptr inbounds nuw i8, ptr %186, i64 48
  %190 = load <2 x double>, ptr %186, align 8, !tbaa !6, !alias.scope !26
  %191 = load <2 x double>, ptr %187, align 8, !tbaa !6, !alias.scope !26
  %192 = load <2 x double>, ptr %188, align 8, !tbaa !6, !alias.scope !26
  %193 = load <2 x double>, ptr %189, align 8, !tbaa !6, !alias.scope !26
  %194 = getelementptr inbounds [80 x double], ptr %5, i64 %174, i64 %176
  %195 = getelementptr inbounds nuw i8, ptr %194, i64 16
  %196 = getelementptr inbounds nuw i8, ptr %194, i64 32
  %197 = getelementptr inbounds nuw i8, ptr %194, i64 48
  %198 = load <2 x double>, ptr %194, align 8, !tbaa !6, !alias.scope !26
  %199 = load <2 x double>, ptr %195, align 8, !tbaa !6, !alias.scope !26
  %200 = load <2 x double>, ptr %196, align 8, !tbaa !6, !alias.scope !26
  %201 = load <2 x double>, ptr %197, align 8, !tbaa !6, !alias.scope !26
  %202 = fsub <2 x double> %190, %198
  %203 = fsub <2 x double> %191, %199
  %204 = fsub <2 x double> %192, %200
  %205 = fsub <2 x double> %193, %201
  %206 = tail call <2 x double> @llvm.fmuladd.v2f64(<2 x double> %202, <2 x double> splat (double -5.000000e-01), <2 x double> %182)
  %207 = tail call <2 x double> @llvm.fmuladd.v2f64(<2 x double> %203, <2 x double> splat (double -5.000000e-01), <2 x double> %183)
  %208 = tail call <2 x double> @llvm.fmuladd.v2f64(<2 x double> %204, <2 x double> splat (double -5.000000e-01), <2 x double> %184)
  %209 = tail call <2 x double> @llvm.fmuladd.v2f64(<2 x double> %205, <2 x double> splat (double -5.000000e-01), <2 x double> %185)
  store <2 x double> %206, ptr %178, align 8, !tbaa !6, !alias.scope !23, !noalias !26
  store <2 x double> %207, ptr %179, align 8, !tbaa !6, !alias.scope !23, !noalias !26
  store <2 x double> %208, ptr %180, align 8, !tbaa !6, !alias.scope !23, !noalias !26
  store <2 x double> %209, ptr %181, align 8, !tbaa !6, !alias.scope !23, !noalias !26
  %210 = add nuw i64 %176, 8
  %211 = icmp eq i64 %210, 72
  br i1 %211, label %.loopexit2, label %175, !llvm.loop !28

.loopexit2:                                       ; preds = %175
  br label %212

212:                                              ; preds = %.loopexit2, %173
  %213 = phi i64 [ 1, %173 ], [ 73, %.loopexit2 ]
  br label %214

214:                                              ; preds = %214, %212
  %215 = phi i64 [ %225, %214 ], [ %213, %212 ]
  %216 = getelementptr inbounds nuw [80 x double], ptr %3, i64 %174, i64 %215
  %217 = load double, ptr %216, align 8, !tbaa !6
  %218 = getelementptr inbounds nuw [80 x double], ptr %5, i64 %174, i64 %215
  %219 = load double, ptr %218, align 8, !tbaa !6
  %220 = add nsw i64 %215, -1
  %221 = getelementptr inbounds [80 x double], ptr %5, i64 %174, i64 %220
  %222 = load double, ptr %221, align 8, !tbaa !6
  %223 = fsub double %219, %222
  %224 = tail call double @llvm.fmuladd.f64(double %223, double -5.000000e-01, double %217)
  store double %224, ptr %216, align 8, !tbaa !6
  %225 = add nuw nsw i64 %215, 1
  %226 = icmp eq i64 %225, 80
  br i1 %226, label %227, label %214, !llvm.loop !29

227:                                              ; preds = %214
  %228 = add nuw nsw i64 %174, 1
  %229 = icmp eq i64 %228, 60
  br i1 %229, label %.preheader7, label %173, !llvm.loop !30

.preheader7:                                      ; preds = %227
  br label %230

230:                                              ; preds = %.preheader7, %313
  %231 = phi i64 [ %314, %313 ], [ 0, %.preheader7 ]
  br i1 %113, label %293, label %.preheader

.preheader:                                       ; preds = %230
  br label %232

232:                                              ; preds = %.preheader, %232
  %233 = phi i64 [ %291, %232 ], [ 0, %.preheader ]
  %234 = getelementptr inbounds nuw [80 x double], ptr %5, i64 %231, i64 %233
  %235 = getelementptr inbounds nuw i8, ptr %234, i64 16
  %236 = getelementptr inbounds nuw i8, ptr %234, i64 32
  %237 = getelementptr inbounds nuw i8, ptr %234, i64 48
  %238 = load <2 x double>, ptr %234, align 8, !tbaa !6, !alias.scope !31, !noalias !34
  %239 = load <2 x double>, ptr %235, align 8, !tbaa !6, !alias.scope !31, !noalias !34
  %240 = load <2 x double>, ptr %236, align 8, !tbaa !6, !alias.scope !31, !noalias !34
  %241 = load <2 x double>, ptr %237, align 8, !tbaa !6, !alias.scope !31, !noalias !34
  %242 = or disjoint i64 %233, 1
  %243 = getelementptr inbounds nuw [80 x double], ptr %3, i64 %231, i64 %242
  %244 = getelementptr inbounds nuw i8, ptr %243, i64 16
  %245 = getelementptr inbounds nuw i8, ptr %243, i64 32
  %246 = getelementptr inbounds nuw i8, ptr %243, i64 48
  %247 = load <2 x double>, ptr %243, align 8, !tbaa !6, !alias.scope !37
  %248 = load <2 x double>, ptr %244, align 8, !tbaa !6, !alias.scope !37
  %249 = load <2 x double>, ptr %245, align 8, !tbaa !6, !alias.scope !37
  %250 = load <2 x double>, ptr %246, align 8, !tbaa !6, !alias.scope !37
  %251 = getelementptr inbounds nuw [80 x double], ptr %3, i64 %231, i64 %233
  %252 = getelementptr inbounds nuw i8, ptr %251, i64 16
  %253 = getelementptr inbounds nuw i8, ptr %251, i64 32
  %254 = getelementptr inbounds nuw i8, ptr %251, i64 48
  %255 = load <2 x double>, ptr %251, align 8, !tbaa !6, !alias.scope !37
  %256 = load <2 x double>, ptr %252, align 8, !tbaa !6, !alias.scope !37
  %257 = load <2 x double>, ptr %253, align 8, !tbaa !6, !alias.scope !37
  %258 = load <2 x double>, ptr %254, align 8, !tbaa !6, !alias.scope !37
  %259 = fsub <2 x double> %247, %255
  %260 = fsub <2 x double> %248, %256
  %261 = fsub <2 x double> %249, %257
  %262 = fsub <2 x double> %250, %258
  %263 = getelementptr inbounds nuw [80 x double], ptr %54, i64 %231, i64 %233
  %264 = getelementptr inbounds nuw i8, ptr %263, i64 16
  %265 = getelementptr inbounds nuw i8, ptr %263, i64 32
  %266 = getelementptr inbounds nuw i8, ptr %263, i64 48
  %267 = load <2 x double>, ptr %263, align 8, !tbaa !6, !alias.scope !38
  %268 = load <2 x double>, ptr %264, align 8, !tbaa !6, !alias.scope !38
  %269 = load <2 x double>, ptr %265, align 8, !tbaa !6, !alias.scope !38
  %270 = load <2 x double>, ptr %266, align 8, !tbaa !6, !alias.scope !38
  %271 = fadd <2 x double> %259, %267
  %272 = fadd <2 x double> %260, %268
  %273 = fadd <2 x double> %261, %269
  %274 = fadd <2 x double> %262, %270
  %275 = getelementptr inbounds nuw [80 x double], ptr %4, i64 %231, i64 %233
  %276 = getelementptr inbounds nuw i8, ptr %275, i64 16
  %277 = getelementptr inbounds nuw i8, ptr %275, i64 32
  %278 = getelementptr inbounds nuw i8, ptr %275, i64 48
  %279 = load <2 x double>, ptr %275, align 8, !tbaa !6, !alias.scope !38
  %280 = load <2 x double>, ptr %276, align 8, !tbaa !6, !alias.scope !38
  %281 = load <2 x double>, ptr %277, align 8, !tbaa !6, !alias.scope !38
  %282 = load <2 x double>, ptr %278, align 8, !tbaa !6, !alias.scope !38
  %283 = fsub <2 x double> %271, %279
  %284 = fsub <2 x double> %272, %280
  %285 = fsub <2 x double> %273, %281
  %286 = fsub <2 x double> %274, %282
  %287 = tail call <2 x double> @llvm.fmuladd.v2f64(<2 x double> %283, <2 x double> splat (double 0xBFE6666666666666), <2 x double> %238)
  %288 = tail call <2 x double> @llvm.fmuladd.v2f64(<2 x double> %284, <2 x double> splat (double 0xBFE6666666666666), <2 x double> %239)
  %289 = tail call <2 x double> @llvm.fmuladd.v2f64(<2 x double> %285, <2 x double> splat (double 0xBFE6666666666666), <2 x double> %240)
  %290 = tail call <2 x double> @llvm.fmuladd.v2f64(<2 x double> %286, <2 x double> splat (double 0xBFE6666666666666), <2 x double> %241)
  store <2 x double> %287, ptr %234, align 8, !tbaa !6, !alias.scope !31, !noalias !34
  store <2 x double> %288, ptr %235, align 8, !tbaa !6, !alias.scope !31, !noalias !34
  store <2 x double> %289, ptr %236, align 8, !tbaa !6, !alias.scope !31, !noalias !34
  store <2 x double> %290, ptr %237, align 8, !tbaa !6, !alias.scope !31, !noalias !34
  %291 = add nuw i64 %233, 8
  %292 = icmp eq i64 %291, 72
  br i1 %292, label %.loopexit, label %232, !llvm.loop !39

.loopexit:                                        ; preds = %232
  br label %293

293:                                              ; preds = %.loopexit, %230
  %294 = phi i64 [ 0, %230 ], [ 72, %.loopexit ]
  br label %295

295:                                              ; preds = %295, %293
  %296 = phi i64 [ %299, %295 ], [ %294, %293 ]
  %297 = getelementptr inbounds nuw [80 x double], ptr %5, i64 %231, i64 %296
  %298 = load double, ptr %297, align 8, !tbaa !6
  %299 = add nuw nsw i64 %296, 1
  %300 = getelementptr inbounds nuw [80 x double], ptr %3, i64 %231, i64 %299
  %301 = load double, ptr %300, align 8, !tbaa !6
  %302 = getelementptr inbounds nuw [80 x double], ptr %3, i64 %231, i64 %296
  %303 = load double, ptr %302, align 8, !tbaa !6
  %304 = fsub double %301, %303
  %305 = getelementptr inbounds nuw [80 x double], ptr %54, i64 %231, i64 %296
  %306 = load double, ptr %305, align 8, !tbaa !6
  %307 = fadd double %304, %306
  %308 = getelementptr inbounds nuw [80 x double], ptr %4, i64 %231, i64 %296
  %309 = load double, ptr %308, align 8, !tbaa !6
  %310 = fsub double %307, %309
  %311 = tail call double @llvm.fmuladd.f64(double %310, double 0xBFE6666666666666, double %298)
  store double %311, ptr %297, align 8, !tbaa !6
  %312 = icmp eq i64 %299, 79
  br i1 %312, label %313, label %295, !llvm.loop !40

313:                                              ; preds = %295
  %314 = add nuw nsw i64 %231, 1
  %315 = icmp eq i64 %314, 59
  br i1 %315, label %316, label %230, !llvm.loop !41

316:                                              ; preds = %313
  %317 = add nuw nsw i64 %115, 1
  %318 = icmp eq i64 %317, 40
  br i1 %318, label %319, label %114, !llvm.loop !42

319:                                              ; preds = %316
  tail call void @polybench_timer_stop() #6
  tail call void @polybench_timer_print() #6
  %320 = icmp sgt i32 %0, 42
  br i1 %320, label %321, label %411

321:                                              ; preds = %319
  %322 = load ptr, ptr %1, align 8, !tbaa !43
  %323 = load i8, ptr %322, align 1
  %324 = icmp eq i8 %323, 0
  br i1 %324, label %325, label %411

325:                                              ; preds = %321
  %326 = load ptr, ptr @__stderrp, align 8, !tbaa !46
  %327 = tail call i64 @fwrite(ptr nonnull @.str.1, i64 22, i64 1, ptr %326)
  %328 = load ptr, ptr @__stderrp, align 8, !tbaa !46
  %329 = tail call i32 (ptr, ptr, ...) @fprintf(ptr noundef %328, ptr noundef nonnull @.str.2, ptr noundef nonnull @.str.3) #6
  br label %330

330:                                              ; preds = %349, %325
  %331 = phi i64 [ 0, %325 ], [ %350, %349 ]
  %332 = mul nuw nsw i64 %331, 60
  br label %333

333:                                              ; preds = %342, %330
  %334 = phi i64 [ 0, %330 ], [ %347, %342 ]
  %335 = add nuw nsw i64 %334, %332
  %336 = trunc nuw nsw i64 %335 to i32
  %337 = urem i32 %336, 20
  %338 = icmp eq i32 %337, 0
  br i1 %338, label %339, label %342

339:                                              ; preds = %333
  %340 = load ptr, ptr @__stderrp, align 8, !tbaa !46
  %341 = tail call i32 @fputc(i32 10, ptr %340)
  br label %342

342:                                              ; preds = %339, %333
  %343 = load ptr, ptr @__stderrp, align 8, !tbaa !46
  %344 = getelementptr inbounds nuw [80 x double], ptr %3, i64 %331, i64 %334
  %345 = load double, ptr %344, align 8, !tbaa !6
  %346 = tail call i32 (ptr, ptr, ...) @fprintf(ptr noundef %343, ptr noundef nonnull @.str.5, double noundef %345) #6
  %347 = add nuw nsw i64 %334, 1
  %348 = icmp eq i64 %347, 80
  br i1 %348, label %349, label %333, !llvm.loop !48

349:                                              ; preds = %342
  %350 = add nuw nsw i64 %331, 1
  %351 = icmp eq i64 %350, 60
  br i1 %351, label %352, label %330, !llvm.loop !49

352:                                              ; preds = %349
  %353 = load ptr, ptr @__stderrp, align 8, !tbaa !46
  %354 = tail call i32 (ptr, ptr, ...) @fprintf(ptr noundef %353, ptr noundef nonnull @.str.6, ptr noundef nonnull @.str.3) #6
  %355 = load ptr, ptr @__stderrp, align 8, !tbaa !46
  %356 = tail call i64 @fwrite(ptr nonnull @.str.7, i64 22, i64 1, ptr %355)
  %357 = load ptr, ptr @__stderrp, align 8, !tbaa !46
  %358 = tail call i32 (ptr, ptr, ...) @fprintf(ptr noundef %357, ptr noundef nonnull @.str.2, ptr noundef nonnull @.str.8) #6
  br label %359

359:                                              ; preds = %378, %352
  %360 = phi i64 [ 0, %352 ], [ %379, %378 ]
  %361 = mul nuw nsw i64 %360, 60
  br label %362

362:                                              ; preds = %371, %359
  %363 = phi i64 [ 0, %359 ], [ %376, %371 ]
  %364 = add nuw nsw i64 %363, %361
  %365 = trunc nuw nsw i64 %364 to i32
  %366 = urem i32 %365, 20
  %367 = icmp eq i32 %366, 0
  br i1 %367, label %368, label %371

368:                                              ; preds = %362
  %369 = load ptr, ptr @__stderrp, align 8, !tbaa !46
  %370 = tail call i32 @fputc(i32 10, ptr %369)
  br label %371

371:                                              ; preds = %368, %362
  %372 = load ptr, ptr @__stderrp, align 8, !tbaa !46
  %373 = getelementptr inbounds nuw [80 x double], ptr %4, i64 %360, i64 %363
  %374 = load double, ptr %373, align 8, !tbaa !6
  %375 = tail call i32 (ptr, ptr, ...) @fprintf(ptr noundef %372, ptr noundef nonnull @.str.5, double noundef %374) #6
  %376 = add nuw nsw i64 %363, 1
  %377 = icmp eq i64 %376, 80
  br i1 %377, label %378, label %362, !llvm.loop !50

378:                                              ; preds = %371
  %379 = add nuw nsw i64 %360, 1
  %380 = icmp eq i64 %379, 60
  br i1 %380, label %381, label %359, !llvm.loop !51

381:                                              ; preds = %378
  %382 = load ptr, ptr @__stderrp, align 8, !tbaa !46
  %383 = tail call i32 (ptr, ptr, ...) @fprintf(ptr noundef %382, ptr noundef nonnull @.str.6, ptr noundef nonnull @.str.8) #6
  %384 = load ptr, ptr @__stderrp, align 8, !tbaa !46
  %385 = tail call i32 (ptr, ptr, ...) @fprintf(ptr noundef %384, ptr noundef nonnull @.str.2, ptr noundef nonnull @.str.9) #6
  br label %386

386:                                              ; preds = %405, %381
  %387 = phi i64 [ 0, %381 ], [ %406, %405 ]
  %388 = mul nuw nsw i64 %387, 60
  br label %389

389:                                              ; preds = %398, %386
  %390 = phi i64 [ 0, %386 ], [ %403, %398 ]
  %391 = add nuw nsw i64 %390, %388
  %392 = trunc nuw nsw i64 %391 to i32
  %393 = urem i32 %392, 20
  %394 = icmp eq i32 %393, 0
  br i1 %394, label %395, label %398

395:                                              ; preds = %389
  %396 = load ptr, ptr @__stderrp, align 8, !tbaa !46
  %397 = tail call i32 @fputc(i32 10, ptr %396)
  br label %398

398:                                              ; preds = %395, %389
  %399 = load ptr, ptr @__stderrp, align 8, !tbaa !46
  %400 = getelementptr inbounds nuw [80 x double], ptr %5, i64 %387, i64 %390
  %401 = load double, ptr %400, align 8, !tbaa !6
  %402 = tail call i32 (ptr, ptr, ...) @fprintf(ptr noundef %399, ptr noundef nonnull @.str.5, double noundef %401) #6
  %403 = add nuw nsw i64 %390, 1
  %404 = icmp eq i64 %403, 80
  br i1 %404, label %405, label %389, !llvm.loop !52

405:                                              ; preds = %398
  %406 = add nuw nsw i64 %387, 1
  %407 = icmp eq i64 %406, 60
  br i1 %407, label %408, label %386, !llvm.loop !53

408:                                              ; preds = %405
  %409 = load ptr, ptr @__stderrp, align 8, !tbaa !46
  %410 = tail call i32 (ptr, ptr, ...) @fprintf(ptr noundef %409, ptr noundef nonnull @.str.6, ptr noundef nonnull @.str.9) #6
  br label %411

411:                                              ; preds = %408, %321, %319
  tail call void @free(ptr noundef %3)
  tail call void @free(ptr noundef %4)
  tail call void @free(ptr noundef nonnull %5)
  tail call void @free(ptr noundef %6)
  ret i32 0
}

declare ptr @polybench_alloc_data(i64 noundef, i32 noundef) local_unnamed_addr #1

declare void @polybench_timer_start(...) local_unnamed_addr #1

declare void @polybench_timer_stop(...) local_unnamed_addr #1

declare void @polybench_timer_print(...) local_unnamed_addr #1

; Function Attrs: mustprogress nounwind willreturn allockind("free") memory(argmem: readwrite, inaccessiblemem: readwrite)
declare void @free(ptr allocptr noundef captures(none)) local_unnamed_addr #2

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare double @llvm.fmuladd.f64(double, double, double) #3

; Function Attrs: nofree nounwind
declare noundef i32 @fprintf(ptr noundef captures(none), ptr noundef readonly captures(none), ...) local_unnamed_addr #4

; Function Attrs: nofree nounwind
declare noundef i64 @fwrite(ptr noundef readonly captures(none), i64 noundef, i64 noundef, ptr noundef captures(none)) local_unnamed_addr #5

; Function Attrs: nofree nounwind
declare noundef i32 @fputc(i32 noundef, ptr noundef captures(none)) local_unnamed_addr #5

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare <2 x double> @llvm.fmuladd.v2f64(<2 x double>, <2 x double>, <2 x double>) #3

attributes #0 = { nounwind ssp uwtable(sync) "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+ccpp,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a" }
attributes #1 = { "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+ccpp,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a" }
attributes #2 = { mustprogress nounwind willreturn allockind("free") memory(argmem: readwrite, inaccessiblemem: readwrite) "alloc-family"="malloc" "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+ccpp,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a" }
attributes #3 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #4 = { nofree nounwind "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+ccpp,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a" }
attributes #5 = { nofree nounwind }
attributes #6 = { nounwind }

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
!10 = distinct !{!10, !11}
!11 = !{!"llvm.loop.mustprogress"}
!12 = distinct !{!12, !11}
!13 = !{!14}
!14 = distinct !{!14, !15}
!15 = distinct !{!15, !"LVerDomain"}
!16 = !{!17}
!17 = distinct !{!17, !15}
!18 = distinct !{!18, !11, !19, !20}
!19 = !{!"llvm.loop.isvectorized", i32 1}
!20 = !{!"llvm.loop.unroll.runtime.disable"}
!21 = distinct !{!21, !11, !19}
!22 = distinct !{!22, !11}
!23 = !{!24}
!24 = distinct !{!24, !25}
!25 = distinct !{!25, !"LVerDomain"}
!26 = !{!27}
!27 = distinct !{!27, !25}
!28 = distinct !{!28, !11, !19, !20}
!29 = distinct !{!29, !11, !19}
!30 = distinct !{!30, !11}
!31 = !{!32}
!32 = distinct !{!32, !33}
!33 = distinct !{!33, !"LVerDomain"}
!34 = !{!35, !36}
!35 = distinct !{!35, !33}
!36 = distinct !{!36, !33}
!37 = !{!35}
!38 = !{!36}
!39 = distinct !{!39, !11, !19, !20}
!40 = distinct !{!40, !11, !19}
!41 = distinct !{!41, !11}
!42 = distinct !{!42, !11}
!43 = !{!44, !44, i64 0}
!44 = !{!"p1 omnipotent char", !45, i64 0}
!45 = !{!"any pointer", !8, i64 0}
!46 = !{!47, !47, i64 0}
!47 = !{!"p1 _ZTS7__sFILE", !45, i64 0}
!48 = distinct !{!48, !11}
!49 = distinct !{!49, !11}
!50 = distinct !{!50, !11}
!51 = distinct !{!51, !11}
!52 = distinct !{!52, !11}
!53 = distinct !{!53, !11}
