; ModuleID = 'polybench_results/gemm.ll'
source_filename = "./polybench/linear-algebra/blas/gemm/gemm.c"
target datalayout = "e-m:o-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-n32:64-S128-Fn32"
target triple = "arm64-apple-macosx15.0.0"

@__stderrp = external local_unnamed_addr global ptr, align 8
@.str.1 = private unnamed_addr constant [23 x i8] c"==BEGIN DUMP_ARRAYS==\0A\00", align 1
@.str.2 = private unnamed_addr constant [15 x i8] c"begin dump: %s\00", align 1
@.str.3 = private unnamed_addr constant [2 x i8] c"C\00", align 1
@.str.5 = private unnamed_addr constant [8 x i8] c"%0.2lf \00", align 1
@.str.6 = private unnamed_addr constant [17 x i8] c"\0Aend   dump: %s\0A\00", align 1
@.str.7 = private unnamed_addr constant [23 x i8] c"==END   DUMP_ARRAYS==\0A\00", align 1

; Function Attrs: nounwind ssp uwtable(sync)
define noundef i32 @main(i32 noundef %0, ptr noundef readonly captures(none) %1) local_unnamed_addr #0 {
  %3 = tail call ptr @polybench_alloc_data(i64 noundef 4200, i32 noundef 8) #6
  %4 = tail call ptr @polybench_alloc_data(i64 noundef 4800, i32 noundef 8) #6
  %5 = tail call ptr @polybench_alloc_data(i64 noundef 5600, i32 noundef 8) #6
  br label %6

6:                                                ; preds = %23, %2
  %7 = phi i64 [ 0, %2 ], [ %24, %23 ]
  %8 = insertelement <2 x i64> poison, i64 %7, i64 0
  %9 = shufflevector <2 x i64> %8, <2 x i64> poison, <2 x i32> zeroinitializer
  br label %10

10:                                               ; preds = %10, %6
  %11 = phi i64 [ 0, %6 ], [ %20, %10 ]
  %12 = phi <2 x i64> [ <i64 0, i64 1>, %6 ], [ %21, %10 ]
  %13 = mul nuw nsw <2 x i64> %12, %9
  %14 = trunc <2 x i64> %13 to <2 x i32>
  %15 = add <2 x i32> %14, splat (i32 1)
  %16 = urem <2 x i32> %15, splat (i32 60)
  %17 = uitofp nneg <2 x i32> %16 to <2 x double>
  %18 = fdiv <2 x double> %17, splat (double 6.000000e+01)
  %19 = getelementptr inbounds nuw [70 x double], ptr %3, i64 %7, i64 %11
  store <2 x double> %18, ptr %19, align 8, !tbaa !6
  %20 = add nuw i64 %11, 2
  %21 = add <2 x i64> %12, splat (i64 2)
  %22 = icmp eq i64 %20, 70
  br i1 %22, label %23, label %10, !llvm.loop !10

23:                                               ; preds = %10
  %24 = add nuw nsw i64 %7, 1
  %25 = icmp eq i64 %24, 60
  br i1 %25, label %.preheader1, label %6, !llvm.loop !14

.preheader1:                                      ; preds = %23
  br label %26

26:                                               ; preds = %.preheader1, %43
  %27 = phi i64 [ %44, %43 ], [ 0, %.preheader1 ]
  %28 = insertelement <2 x i64> poison, i64 %27, i64 0
  %29 = shufflevector <2 x i64> %28, <2 x i64> poison, <2 x i32> zeroinitializer
  br label %30

30:                                               ; preds = %30, %26
  %31 = phi i64 [ 0, %26 ], [ %40, %30 ]
  %32 = phi <2 x i64> [ <i64 0, i64 1>, %26 ], [ %41, %30 ]
  %33 = add nuw nsw <2 x i64> %32, splat (i64 1)
  %34 = mul nuw nsw <2 x i64> %33, %29
  %35 = trunc nuw nsw <2 x i64> %34 to <2 x i32>
  %36 = urem <2 x i32> %35, splat (i32 80)
  %37 = uitofp nneg <2 x i32> %36 to <2 x double>
  %38 = fdiv <2 x double> %37, splat (double 8.000000e+01)
  %39 = getelementptr inbounds nuw [80 x double], ptr %4, i64 %27, i64 %31
  store <2 x double> %38, ptr %39, align 8, !tbaa !6
  %40 = add nuw i64 %31, 2
  %41 = add <2 x i64> %32, splat (i64 2)
  %42 = icmp eq i64 %40, 80
  br i1 %42, label %43, label %30, !llvm.loop !15

43:                                               ; preds = %30
  %44 = add nuw nsw i64 %27, 1
  %45 = icmp eq i64 %44, 60
  br i1 %45, label %.preheader, label %26, !llvm.loop !16

.preheader:                                       ; preds = %43
  br label %46

46:                                               ; preds = %.preheader, %63
  %47 = phi i64 [ %64, %63 ], [ 0, %.preheader ]
  %48 = insertelement <2 x i64> poison, i64 %47, i64 0
  %49 = shufflevector <2 x i64> %48, <2 x i64> poison, <2 x i32> zeroinitializer
  br label %50

50:                                               ; preds = %50, %46
  %51 = phi i64 [ 0, %46 ], [ %60, %50 ]
  %52 = phi <2 x i64> [ <i64 0, i64 1>, %46 ], [ %61, %50 ]
  %53 = add nuw nsw <2 x i64> %52, splat (i64 2)
  %54 = mul nuw nsw <2 x i64> %53, %49
  %55 = trunc nuw nsw <2 x i64> %54 to <2 x i32>
  %56 = urem <2 x i32> %55, splat (i32 70)
  %57 = uitofp nneg <2 x i32> %56 to <2 x double>
  %58 = fdiv <2 x double> %57, splat (double 7.000000e+01)
  %59 = getelementptr inbounds nuw [70 x double], ptr %5, i64 %47, i64 %51
  store <2 x double> %58, ptr %59, align 8, !tbaa !6
  %60 = add nuw i64 %51, 2
  %61 = add <2 x i64> %52, splat (i64 2)
  %62 = icmp eq i64 %60, 70
  br i1 %62, label %63, label %50, !llvm.loop !17

63:                                               ; preds = %50
  %64 = add nuw nsw i64 %47, 1
  %65 = icmp eq i64 %64, 80
  br i1 %65, label %66, label %46, !llvm.loop !18

66:                                               ; preds = %63
  tail call void @polybench_timer_start() #6
  %67 = getelementptr i8, ptr %5, i64 44800
  %68 = getelementptr i8, ptr %3, i64 560
  %69 = getelementptr i8, ptr %4, i64 640
  br label %70

70:                                               ; preds = %250, %66
  %71 = phi i64 [ 0, %66 ], [ %251, %250 ]
  %72 = mul nuw nsw i64 %71, 560
  %73 = getelementptr i8, ptr %3, i64 %72
  %74 = getelementptr i8, ptr %68, i64 %72
  %75 = mul nuw nsw i64 %71, 640
  %76 = getelementptr i8, ptr %4, i64 %75
  %77 = getelementptr i8, ptr %69, i64 %75
  %78 = getelementptr inbounds nuw [70 x double], ptr %3, i64 %71, i64 0
  %79 = getelementptr inbounds nuw i8, ptr %78, i64 16
  %80 = getelementptr inbounds nuw i8, ptr %78, i64 32
  %81 = getelementptr inbounds nuw i8, ptr %78, i64 48
  %82 = load <2 x double>, ptr %78, align 8, !tbaa !6
  %83 = load <2 x double>, ptr %79, align 8, !tbaa !6
  %84 = load <2 x double>, ptr %80, align 8, !tbaa !6
  %85 = load <2 x double>, ptr %81, align 8, !tbaa !6
  %86 = fmul <2 x double> %82, splat (double 1.200000e+00)
  %87 = fmul <2 x double> %83, splat (double 1.200000e+00)
  %88 = fmul <2 x double> %84, splat (double 1.200000e+00)
  %89 = fmul <2 x double> %85, splat (double 1.200000e+00)
  store <2 x double> %86, ptr %78, align 8, !tbaa !6
  store <2 x double> %87, ptr %79, align 8, !tbaa !6
  store <2 x double> %88, ptr %80, align 8, !tbaa !6
  store <2 x double> %89, ptr %81, align 8, !tbaa !6
  %90 = getelementptr inbounds nuw [70 x double], ptr %3, i64 %71, i64 8
  %91 = getelementptr inbounds nuw i8, ptr %90, i64 16
  %92 = getelementptr inbounds nuw i8, ptr %90, i64 32
  %93 = getelementptr inbounds nuw i8, ptr %90, i64 48
  %94 = load <2 x double>, ptr %90, align 8, !tbaa !6
  %95 = load <2 x double>, ptr %91, align 8, !tbaa !6
  %96 = load <2 x double>, ptr %92, align 8, !tbaa !6
  %97 = load <2 x double>, ptr %93, align 8, !tbaa !6
  %98 = fmul <2 x double> %94, splat (double 1.200000e+00)
  %99 = fmul <2 x double> %95, splat (double 1.200000e+00)
  %100 = fmul <2 x double> %96, splat (double 1.200000e+00)
  %101 = fmul <2 x double> %97, splat (double 1.200000e+00)
  store <2 x double> %98, ptr %90, align 8, !tbaa !6
  store <2 x double> %99, ptr %91, align 8, !tbaa !6
  store <2 x double> %100, ptr %92, align 8, !tbaa !6
  store <2 x double> %101, ptr %93, align 8, !tbaa !6
  %102 = getelementptr inbounds nuw [70 x double], ptr %3, i64 %71, i64 16
  %103 = getelementptr inbounds nuw i8, ptr %102, i64 16
  %104 = getelementptr inbounds nuw i8, ptr %102, i64 32
  %105 = getelementptr inbounds nuw i8, ptr %102, i64 48
  %106 = load <2 x double>, ptr %102, align 8, !tbaa !6
  %107 = load <2 x double>, ptr %103, align 8, !tbaa !6
  %108 = load <2 x double>, ptr %104, align 8, !tbaa !6
  %109 = load <2 x double>, ptr %105, align 8, !tbaa !6
  %110 = fmul <2 x double> %106, splat (double 1.200000e+00)
  %111 = fmul <2 x double> %107, splat (double 1.200000e+00)
  %112 = fmul <2 x double> %108, splat (double 1.200000e+00)
  %113 = fmul <2 x double> %109, splat (double 1.200000e+00)
  store <2 x double> %110, ptr %102, align 8, !tbaa !6
  store <2 x double> %111, ptr %103, align 8, !tbaa !6
  store <2 x double> %112, ptr %104, align 8, !tbaa !6
  store <2 x double> %113, ptr %105, align 8, !tbaa !6
  %114 = getelementptr inbounds nuw [70 x double], ptr %3, i64 %71, i64 24
  %115 = getelementptr inbounds nuw i8, ptr %114, i64 16
  %116 = getelementptr inbounds nuw i8, ptr %114, i64 32
  %117 = getelementptr inbounds nuw i8, ptr %114, i64 48
  %118 = load <2 x double>, ptr %114, align 8, !tbaa !6
  %119 = load <2 x double>, ptr %115, align 8, !tbaa !6
  %120 = load <2 x double>, ptr %116, align 8, !tbaa !6
  %121 = load <2 x double>, ptr %117, align 8, !tbaa !6
  %122 = fmul <2 x double> %118, splat (double 1.200000e+00)
  %123 = fmul <2 x double> %119, splat (double 1.200000e+00)
  %124 = fmul <2 x double> %120, splat (double 1.200000e+00)
  %125 = fmul <2 x double> %121, splat (double 1.200000e+00)
  store <2 x double> %122, ptr %114, align 8, !tbaa !6
  store <2 x double> %123, ptr %115, align 8, !tbaa !6
  store <2 x double> %124, ptr %116, align 8, !tbaa !6
  store <2 x double> %125, ptr %117, align 8, !tbaa !6
  %126 = getelementptr inbounds nuw [70 x double], ptr %3, i64 %71, i64 32
  %127 = getelementptr inbounds nuw i8, ptr %126, i64 16
  %128 = getelementptr inbounds nuw i8, ptr %126, i64 32
  %129 = getelementptr inbounds nuw i8, ptr %126, i64 48
  %130 = load <2 x double>, ptr %126, align 8, !tbaa !6
  %131 = load <2 x double>, ptr %127, align 8, !tbaa !6
  %132 = load <2 x double>, ptr %128, align 8, !tbaa !6
  %133 = load <2 x double>, ptr %129, align 8, !tbaa !6
  %134 = fmul <2 x double> %130, splat (double 1.200000e+00)
  %135 = fmul <2 x double> %131, splat (double 1.200000e+00)
  %136 = fmul <2 x double> %132, splat (double 1.200000e+00)
  %137 = fmul <2 x double> %133, splat (double 1.200000e+00)
  store <2 x double> %134, ptr %126, align 8, !tbaa !6
  store <2 x double> %135, ptr %127, align 8, !tbaa !6
  store <2 x double> %136, ptr %128, align 8, !tbaa !6
  store <2 x double> %137, ptr %129, align 8, !tbaa !6
  %138 = getelementptr inbounds nuw [70 x double], ptr %3, i64 %71, i64 40
  %139 = getelementptr inbounds nuw i8, ptr %138, i64 16
  %140 = getelementptr inbounds nuw i8, ptr %138, i64 32
  %141 = getelementptr inbounds nuw i8, ptr %138, i64 48
  %142 = load <2 x double>, ptr %138, align 8, !tbaa !6
  %143 = load <2 x double>, ptr %139, align 8, !tbaa !6
  %144 = load <2 x double>, ptr %140, align 8, !tbaa !6
  %145 = load <2 x double>, ptr %141, align 8, !tbaa !6
  %146 = fmul <2 x double> %142, splat (double 1.200000e+00)
  %147 = fmul <2 x double> %143, splat (double 1.200000e+00)
  %148 = fmul <2 x double> %144, splat (double 1.200000e+00)
  %149 = fmul <2 x double> %145, splat (double 1.200000e+00)
  store <2 x double> %146, ptr %138, align 8, !tbaa !6
  store <2 x double> %147, ptr %139, align 8, !tbaa !6
  store <2 x double> %148, ptr %140, align 8, !tbaa !6
  store <2 x double> %149, ptr %141, align 8, !tbaa !6
  %150 = getelementptr inbounds nuw [70 x double], ptr %3, i64 %71, i64 48
  %151 = getelementptr inbounds nuw i8, ptr %150, i64 16
  %152 = getelementptr inbounds nuw i8, ptr %150, i64 32
  %153 = getelementptr inbounds nuw i8, ptr %150, i64 48
  %154 = load <2 x double>, ptr %150, align 8, !tbaa !6
  %155 = load <2 x double>, ptr %151, align 8, !tbaa !6
  %156 = load <2 x double>, ptr %152, align 8, !tbaa !6
  %157 = load <2 x double>, ptr %153, align 8, !tbaa !6
  %158 = fmul <2 x double> %154, splat (double 1.200000e+00)
  %159 = fmul <2 x double> %155, splat (double 1.200000e+00)
  %160 = fmul <2 x double> %156, splat (double 1.200000e+00)
  %161 = fmul <2 x double> %157, splat (double 1.200000e+00)
  store <2 x double> %158, ptr %150, align 8, !tbaa !6
  store <2 x double> %159, ptr %151, align 8, !tbaa !6
  store <2 x double> %160, ptr %152, align 8, !tbaa !6
  store <2 x double> %161, ptr %153, align 8, !tbaa !6
  %162 = getelementptr inbounds nuw [70 x double], ptr %3, i64 %71, i64 56
  %163 = getelementptr inbounds nuw i8, ptr %162, i64 16
  %164 = getelementptr inbounds nuw i8, ptr %162, i64 32
  %165 = getelementptr inbounds nuw i8, ptr %162, i64 48
  %166 = load <2 x double>, ptr %162, align 8, !tbaa !6
  %167 = load <2 x double>, ptr %163, align 8, !tbaa !6
  %168 = load <2 x double>, ptr %164, align 8, !tbaa !6
  %169 = load <2 x double>, ptr %165, align 8, !tbaa !6
  %170 = fmul <2 x double> %166, splat (double 1.200000e+00)
  %171 = fmul <2 x double> %167, splat (double 1.200000e+00)
  %172 = fmul <2 x double> %168, splat (double 1.200000e+00)
  %173 = fmul <2 x double> %169, splat (double 1.200000e+00)
  store <2 x double> %170, ptr %162, align 8, !tbaa !6
  store <2 x double> %171, ptr %163, align 8, !tbaa !6
  store <2 x double> %172, ptr %164, align 8, !tbaa !6
  store <2 x double> %173, ptr %165, align 8, !tbaa !6
  %174 = getelementptr inbounds nuw [70 x double], ptr %3, i64 %71, i64 64
  %175 = load double, ptr %174, align 8, !tbaa !6
  %176 = fmul double %175, 1.200000e+00
  store double %176, ptr %174, align 8, !tbaa !6
  %177 = getelementptr inbounds nuw [70 x double], ptr %3, i64 %71, i64 65
  %178 = load double, ptr %177, align 8, !tbaa !6
  %179 = fmul double %178, 1.200000e+00
  store double %179, ptr %177, align 8, !tbaa !6
  %180 = getelementptr inbounds nuw [70 x double], ptr %3, i64 %71, i64 66
  %181 = load double, ptr %180, align 8, !tbaa !6
  %182 = fmul double %181, 1.200000e+00
  store double %182, ptr %180, align 8, !tbaa !6
  %183 = getelementptr inbounds nuw [70 x double], ptr %3, i64 %71, i64 67
  %184 = load double, ptr %183, align 8, !tbaa !6
  %185 = fmul double %184, 1.200000e+00
  store double %185, ptr %183, align 8, !tbaa !6
  %186 = getelementptr inbounds nuw [70 x double], ptr %3, i64 %71, i64 68
  %187 = load double, ptr %186, align 8, !tbaa !6
  %188 = fmul double %187, 1.200000e+00
  store double %188, ptr %186, align 8, !tbaa !6
  %189 = getelementptr inbounds nuw [70 x double], ptr %3, i64 %71, i64 69
  %190 = load double, ptr %189, align 8, !tbaa !6
  %191 = fmul double %190, 1.200000e+00
  store double %191, ptr %189, align 8, !tbaa !6
  %192 = icmp ult ptr %73, %77
  %193 = icmp ult ptr %76, %74
  %194 = and i1 %192, %193
  %195 = icmp ult ptr %73, %67
  %196 = icmp ult ptr %5, %74
  %197 = and i1 %195, %196
  %198 = or i1 %194, %197
  br label %199

199:                                              ; preds = %247, %70
  %200 = phi i64 [ %248, %247 ], [ 0, %70 ]
  %201 = getelementptr inbounds nuw [80 x double], ptr %4, i64 %71, i64 %200
  br i1 %198, label %234, label %202

202:                                              ; preds = %199
  %203 = load double, ptr %201, align 8, !tbaa !6, !alias.scope !19
  %204 = insertelement <2 x double> poison, double %203, i64 0
  %205 = shufflevector <2 x double> %204, <2 x double> poison, <2 x i32> zeroinitializer
  %206 = fmul <2 x double> %205, splat (double 1.500000e+00)
  %207 = fmul <2 x double> %205, splat (double 1.500000e+00)
  %208 = fmul <2 x double> %205, splat (double 1.500000e+00)
  %209 = fmul <2 x double> %205, splat (double 1.500000e+00)
  br label %210

210:                                              ; preds = %210, %202
  %211 = phi i64 [ %232, %210 ], [ 0, %202 ]
  %212 = getelementptr inbounds nuw [70 x double], ptr %5, i64 %200, i64 %211
  %213 = getelementptr inbounds nuw i8, ptr %212, i64 16
  %214 = getelementptr inbounds nuw i8, ptr %212, i64 32
  %215 = getelementptr inbounds nuw i8, ptr %212, i64 48
  %216 = load <2 x double>, ptr %212, align 8, !tbaa !6, !alias.scope !22
  %217 = load <2 x double>, ptr %213, align 8, !tbaa !6, !alias.scope !22
  %218 = load <2 x double>, ptr %214, align 8, !tbaa !6, !alias.scope !22
  %219 = load <2 x double>, ptr %215, align 8, !tbaa !6, !alias.scope !22
  %220 = getelementptr inbounds nuw [70 x double], ptr %3, i64 %71, i64 %211
  %221 = getelementptr inbounds nuw i8, ptr %220, i64 16
  %222 = getelementptr inbounds nuw i8, ptr %220, i64 32
  %223 = getelementptr inbounds nuw i8, ptr %220, i64 48
  %224 = load <2 x double>, ptr %220, align 8, !tbaa !6, !alias.scope !24, !noalias !26
  %225 = load <2 x double>, ptr %221, align 8, !tbaa !6, !alias.scope !24, !noalias !26
  %226 = load <2 x double>, ptr %222, align 8, !tbaa !6, !alias.scope !24, !noalias !26
  %227 = load <2 x double>, ptr %223, align 8, !tbaa !6, !alias.scope !24, !noalias !26
  %228 = tail call <2 x double> @llvm.fmuladd.v2f64(<2 x double> %206, <2 x double> %216, <2 x double> %224)
  %229 = tail call <2 x double> @llvm.fmuladd.v2f64(<2 x double> %207, <2 x double> %217, <2 x double> %225)
  %230 = tail call <2 x double> @llvm.fmuladd.v2f64(<2 x double> %208, <2 x double> %218, <2 x double> %226)
  %231 = tail call <2 x double> @llvm.fmuladd.v2f64(<2 x double> %209, <2 x double> %219, <2 x double> %227)
  store <2 x double> %228, ptr %220, align 8, !tbaa !6, !alias.scope !24, !noalias !26
  store <2 x double> %229, ptr %221, align 8, !tbaa !6, !alias.scope !24, !noalias !26
  store <2 x double> %230, ptr %222, align 8, !tbaa !6, !alias.scope !24, !noalias !26
  store <2 x double> %231, ptr %223, align 8, !tbaa !6, !alias.scope !24, !noalias !26
  %232 = add nuw i64 %211, 8
  %233 = icmp eq i64 %232, 64
  br i1 %233, label %.loopexit, label %210, !llvm.loop !27

.loopexit:                                        ; preds = %210
  br label %234

234:                                              ; preds = %.loopexit, %199
  %235 = phi i64 [ 0, %199 ], [ 64, %.loopexit ]
  br label %236

236:                                              ; preds = %236, %234
  %237 = phi i64 [ %245, %236 ], [ %235, %234 ]
  %238 = load double, ptr %201, align 8, !tbaa !6
  %239 = fmul double %238, 1.500000e+00
  %240 = getelementptr inbounds nuw [70 x double], ptr %5, i64 %200, i64 %237
  %241 = load double, ptr %240, align 8, !tbaa !6
  %242 = getelementptr inbounds nuw [70 x double], ptr %3, i64 %71, i64 %237
  %243 = load double, ptr %242, align 8, !tbaa !6
  %244 = tail call double @llvm.fmuladd.f64(double %239, double %241, double %243)
  store double %244, ptr %242, align 8, !tbaa !6
  %245 = add nuw nsw i64 %237, 1
  %246 = icmp eq i64 %245, 70
  br i1 %246, label %247, label %236, !llvm.loop !28

247:                                              ; preds = %236
  %248 = add nuw nsw i64 %200, 1
  %249 = icmp eq i64 %248, 80
  br i1 %249, label %250, label %199, !llvm.loop !29

250:                                              ; preds = %247
  %251 = add nuw nsw i64 %71, 1
  %252 = icmp eq i64 %251, 60
  br i1 %252, label %253, label %70, !llvm.loop !30

253:                                              ; preds = %250
  tail call void @polybench_timer_stop() #6
  tail call void @polybench_timer_print() #6
  %254 = icmp sgt i32 %0, 42
  br i1 %254, label %255, label %291

255:                                              ; preds = %253
  %256 = load ptr, ptr %1, align 8, !tbaa !31
  %257 = load i8, ptr %256, align 1
  %258 = icmp eq i8 %257, 0
  br i1 %258, label %259, label %291

259:                                              ; preds = %255
  %260 = load ptr, ptr @__stderrp, align 8, !tbaa !34
  %261 = tail call i64 @fwrite(ptr nonnull @.str.1, i64 22, i64 1, ptr %260)
  %262 = load ptr, ptr @__stderrp, align 8, !tbaa !34
  %263 = tail call i32 (ptr, ptr, ...) @fprintf(ptr noundef %262, ptr noundef nonnull @.str.2, ptr noundef nonnull @.str.3) #6
  br label %264

264:                                              ; preds = %283, %259
  %265 = phi i64 [ 0, %259 ], [ %284, %283 ]
  %266 = mul nuw nsw i64 %265, 60
  br label %267

267:                                              ; preds = %276, %264
  %268 = phi i64 [ 0, %264 ], [ %281, %276 ]
  %269 = add nuw nsw i64 %268, %266
  %270 = trunc nuw nsw i64 %269 to i32
  %271 = urem i32 %270, 20
  %272 = icmp eq i32 %271, 0
  br i1 %272, label %273, label %276

273:                                              ; preds = %267
  %274 = load ptr, ptr @__stderrp, align 8, !tbaa !34
  %275 = tail call i32 @fputc(i32 10, ptr %274)
  br label %276

276:                                              ; preds = %273, %267
  %277 = load ptr, ptr @__stderrp, align 8, !tbaa !34
  %278 = getelementptr inbounds nuw [70 x double], ptr %3, i64 %265, i64 %268
  %279 = load double, ptr %278, align 8, !tbaa !6
  %280 = tail call i32 (ptr, ptr, ...) @fprintf(ptr noundef %277, ptr noundef nonnull @.str.5, double noundef %279) #6
  %281 = add nuw nsw i64 %268, 1
  %282 = icmp eq i64 %281, 70
  br i1 %282, label %283, label %267, !llvm.loop !36

283:                                              ; preds = %276
  %284 = add nuw nsw i64 %265, 1
  %285 = icmp eq i64 %284, 60
  br i1 %285, label %286, label %264, !llvm.loop !37

286:                                              ; preds = %283
  %287 = load ptr, ptr @__stderrp, align 8, !tbaa !34
  %288 = tail call i32 (ptr, ptr, ...) @fprintf(ptr noundef %287, ptr noundef nonnull @.str.6, ptr noundef nonnull @.str.3) #6
  %289 = load ptr, ptr @__stderrp, align 8, !tbaa !34
  %290 = tail call i64 @fwrite(ptr nonnull @.str.7, i64 22, i64 1, ptr %289)
  br label %291

291:                                              ; preds = %286, %255, %253
  tail call void @free(ptr noundef nonnull %3)
  tail call void @free(ptr noundef %4)
  tail call void @free(ptr noundef %5)
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
!10 = distinct !{!10, !11, !12, !13}
!11 = !{!"llvm.loop.mustprogress"}
!12 = !{!"llvm.loop.isvectorized", i32 1}
!13 = !{!"llvm.loop.unroll.runtime.disable"}
!14 = distinct !{!14, !11}
!15 = distinct !{!15, !11, !12, !13}
!16 = distinct !{!16, !11}
!17 = distinct !{!17, !11, !12, !13}
!18 = distinct !{!18, !11}
!19 = !{!20}
!20 = distinct !{!20, !21}
!21 = distinct !{!21, !"LVerDomain"}
!22 = !{!23}
!23 = distinct !{!23, !21}
!24 = !{!25}
!25 = distinct !{!25, !21}
!26 = !{!20, !23}
!27 = distinct !{!27, !11, !12, !13}
!28 = distinct !{!28, !11, !12}
!29 = distinct !{!29, !11}
!30 = distinct !{!30, !11}
!31 = !{!32, !32, i64 0}
!32 = !{!"p1 omnipotent char", !33, i64 0}
!33 = !{!"any pointer", !8, i64 0}
!34 = !{!35, !35, i64 0}
!35 = !{!"p1 _ZTS7__sFILE", !33, i64 0}
!36 = distinct !{!36, !11}
!37 = distinct !{!37, !11}
