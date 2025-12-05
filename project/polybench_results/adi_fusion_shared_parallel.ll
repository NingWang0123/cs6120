; ModuleID = 'polybench_results/adi.ll'
source_filename = "./polybench/stencils/adi/adi.c"
target datalayout = "e-m:o-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-n32:64-S128-Fn32"
target triple = "arm64-apple-macosx15.0.0"

@__stderrp = external local_unnamed_addr global ptr, align 8
@.str.1 = private unnamed_addr constant [23 x i8] c"==BEGIN DUMP_ARRAYS==\0A\00", align 1
@.str.2 = private unnamed_addr constant [15 x i8] c"begin dump: %s\00", align 1
@.str.3 = private unnamed_addr constant [2 x i8] c"u\00", align 1
@.str.5 = private unnamed_addr constant [8 x i8] c"%0.2lf \00", align 1
@.str.6 = private unnamed_addr constant [17 x i8] c"\0Aend   dump: %s\0A\00", align 1
@.str.7 = private unnamed_addr constant [23 x i8] c"==END   DUMP_ARRAYS==\0A\00", align 1

; Function Attrs: nounwind ssp uwtable(sync)
define noundef i32 @main(i32 noundef %0, ptr noundef readonly captures(none) %1) local_unnamed_addr #0 {
  %3 = tail call ptr @polybench_alloc_data(i64 noundef 3600, i32 noundef 8) #6
  %4 = tail call ptr @polybench_alloc_data(i64 noundef 3600, i32 noundef 8) #6
  %5 = tail call ptr @polybench_alloc_data(i64 noundef 3600, i32 noundef 8) #6
  %6 = tail call ptr @polybench_alloc_data(i64 noundef 3600, i32 noundef 8) #6
  br label %7

7:                                                ; preds = %41, %2
  %8 = phi i64 [ 0, %2 ], [ %62, %41 ]
  %9 = add nuw nsw i64 %8, 60
  %10 = insertelement <2 x i64> poison, i64 %9, i64 0
  %11 = shufflevector <2 x i64> %10, <2 x i64> poison, <2 x i32> zeroinitializer
  br label %12

12:                                               ; preds = %12, %7
  %13 = phi i64 [ 0, %7 ], [ %38, %12 ]
  %14 = phi <2 x i64> [ <i64 0, i64 1>, %7 ], [ %39, %12 ]
  %15 = add <2 x i64> %14, splat (i64 2)
  %16 = add <2 x i64> %14, splat (i64 4)
  %17 = add <2 x i64> %14, splat (i64 6)
  %18 = sub nuw nsw <2 x i64> %11, %14
  %19 = sub nuw nsw <2 x i64> %11, %15
  %20 = sub nuw nsw <2 x i64> %11, %16
  %21 = sub nuw nsw <2 x i64> %11, %17
  %22 = trunc nuw nsw <2 x i64> %18 to <2 x i32>
  %23 = trunc nuw nsw <2 x i64> %19 to <2 x i32>
  %24 = trunc nuw nsw <2 x i64> %20 to <2 x i32>
  %25 = trunc nuw nsw <2 x i64> %21 to <2 x i32>
  %26 = uitofp nneg <2 x i32> %22 to <2 x double>
  %27 = uitofp nneg <2 x i32> %23 to <2 x double>
  %28 = uitofp nneg <2 x i32> %24 to <2 x double>
  %29 = uitofp nneg <2 x i32> %25 to <2 x double>
  %30 = fdiv <2 x double> %26, splat (double 6.000000e+01)
  %31 = fdiv <2 x double> %27, splat (double 6.000000e+01)
  %32 = fdiv <2 x double> %28, splat (double 6.000000e+01)
  %33 = fdiv <2 x double> %29, splat (double 6.000000e+01)
  %34 = getelementptr inbounds nuw [60 x double], ptr %3, i64 %8, i64 %13
  %35 = getelementptr inbounds nuw i8, ptr %34, i64 16
  %36 = getelementptr inbounds nuw i8, ptr %34, i64 32
  %37 = getelementptr inbounds nuw i8, ptr %34, i64 48
  store <2 x double> %30, ptr %34, align 8, !tbaa !6
  store <2 x double> %31, ptr %35, align 8, !tbaa !6
  store <2 x double> %32, ptr %36, align 8, !tbaa !6
  store <2 x double> %33, ptr %37, align 8, !tbaa !6
  %38 = add nuw i64 %13, 8
  %39 = add <2 x i64> %14, splat (i64 8)
  %40 = icmp eq i64 %38, 56
  br i1 %40, label %41, label %12, !llvm.loop !10

41:                                               ; preds = %12
  %42 = trunc i64 %8 to i32
  %43 = add i32 %42, 4
  %44 = uitofp nneg i32 %43 to double
  %45 = fdiv double %44, 6.000000e+01
  %46 = getelementptr inbounds nuw [60 x double], ptr %3, i64 %8, i64 56
  store double %45, ptr %46, align 8, !tbaa !6
  %47 = trunc i64 %8 to i32
  %48 = add i32 %47, 3
  %49 = uitofp nneg i32 %48 to double
  %50 = fdiv double %49, 6.000000e+01
  %51 = getelementptr inbounds nuw [60 x double], ptr %3, i64 %8, i64 57
  store double %50, ptr %51, align 8, !tbaa !6
  %52 = trunc i64 %8 to i32
  %53 = add i32 %52, 2
  %54 = uitofp nneg i32 %53 to double
  %55 = fdiv double %54, 6.000000e+01
  %56 = getelementptr inbounds nuw [60 x double], ptr %3, i64 %8, i64 58
  store double %55, ptr %56, align 8, !tbaa !6
  %57 = trunc i64 %8 to i32
  %58 = add i32 %57, 1
  %59 = uitofp nneg i32 %58 to double
  %60 = fdiv double %59, 6.000000e+01
  %61 = getelementptr inbounds nuw [60 x double], ptr %3, i64 %8, i64 59
  store double %60, ptr %61, align 8, !tbaa !6
  %62 = add nuw nsw i64 %8, 1
  %63 = icmp eq i64 %62, 60
  br i1 %63, label %64, label %7, !llvm.loop !14

64:                                               ; preds = %41
  tail call void @polybench_timer_start() #6
  %65 = getelementptr inbounds nuw i8, ptr %4, i64 28320
  %66 = getelementptr inbounds nuw i8, ptr %4, i64 480
  br label %67

67:                                               ; preds = %247, %64
  %68 = phi i32 [ 1, %64 ], [ %248, %247 ]
  br label %69

69:                                               ; preds = %155, %67
  %70 = phi i64 [ %157, %155 ], [ 0, %67 ]
  %71 = phi i64 [ %84, %155 ], [ 1, %67 ]
  %72 = mul nuw nsw i64 %70, 480
  %73 = add nuw i64 %72, 480
  %74 = getelementptr nuw i8, ptr %5, i64 %73
  %75 = add nuw i64 %72, 952
  %76 = getelementptr i8, ptr %5, i64 %75
  %77 = getelementptr nuw i8, ptr %6, i64 %73
  %78 = getelementptr i8, ptr %6, i64 %75
  %79 = getelementptr inbounds nuw [60 x double], ptr %4, i64 0, i64 %71
  store double 1.000000e+00, ptr %79, align 8, !tbaa !6
  %80 = getelementptr inbounds nuw [60 x double], ptr %5, i64 %71
  store double 0.000000e+00, ptr %80, align 8, !tbaa !6
  %81 = load double, ptr %79, align 8, !tbaa !6
  %82 = getelementptr inbounds nuw [60 x double], ptr %6, i64 %71
  store double %81, ptr %82, align 8, !tbaa !6
  %83 = add nsw i64 %71, -1
  %84 = add nuw nsw i64 %71, 1
  %85 = icmp ult ptr %74, %78
  %86 = icmp ult ptr %77, %76
  %87 = and i1 %85, %86
  br i1 %87, label %.preheader2, label %112

.preheader2:                                      ; preds = %69
  br label %88

88:                                               ; preds = %.preheader2, %88
  %89 = phi i64 [ %110, %88 ], [ 1, %.preheader2 ]
  %90 = add nsw i64 %89, -1
  %91 = getelementptr inbounds [60 x double], ptr %5, i64 %71, i64 %90
  %92 = load double, ptr %91, align 8, !tbaa !6
  %93 = tail call double @llvm.fmuladd.f64(double %92, double -9.000000e+01, double 1.810000e+02)
  %94 = fdiv double 9.000000e+01, %93
  %95 = getelementptr inbounds nuw [60 x double], ptr %5, i64 %71, i64 %89
  store double %94, ptr %95, align 8, !tbaa !6
  %96 = getelementptr inbounds [60 x double], ptr %3, i64 %89, i64 %83
  %97 = load double, ptr %96, align 8, !tbaa !6
  %98 = getelementptr inbounds nuw [60 x double], ptr %3, i64 %89, i64 %71
  %99 = load double, ptr %98, align 8, !tbaa !6
  %100 = fmul double %99, -8.900000e+01
  %101 = tail call double @llvm.fmuladd.f64(double %97, double 4.500000e+01, double %100)
  %102 = getelementptr inbounds nuw [60 x double], ptr %3, i64 %89, i64 %84
  %103 = load double, ptr %102, align 8, !tbaa !6
  %104 = tail call double @llvm.fmuladd.f64(double %103, double 4.500000e+01, double %101)
  %105 = getelementptr inbounds [60 x double], ptr %6, i64 %71, i64 %90
  %106 = load double, ptr %105, align 8, !tbaa !6
  %107 = tail call double @llvm.fmuladd.f64(double %106, double 9.000000e+01, double %104)
  %108 = fdiv double %107, %93
  %109 = getelementptr inbounds nuw [60 x double], ptr %6, i64 %71, i64 %89
  store double %108, ptr %109, align 8, !tbaa !6
  %110 = add nuw nsw i64 %89, 1
  %111 = icmp eq i64 %110, 59
  br i1 %111, label %.loopexit3, label %88, !llvm.loop !15

112:                                              ; preds = %69
  %113 = mul nuw nsw i64 %70, 480
  %114 = add nuw i64 %113, 480
  %115 = getelementptr nuw i8, ptr %6, i64 %114
  %116 = getelementptr nuw i8, ptr %5, i64 %114
  %117 = load double, ptr %116, align 8
  %118 = load double, ptr %115, align 8
  br label %119

119:                                              ; preds = %119, %112
  %120 = phi double [ %118, %112 ], [ %136, %119 ]
  %121 = phi double [ %117, %112 ], [ %124, %119 ]
  %122 = phi i64 [ 1, %112 ], [ %138, %119 ]
  %123 = tail call double @llvm.fmuladd.f64(double %121, double -9.000000e+01, double 1.810000e+02)
  %124 = fdiv double 9.000000e+01, %123
  %125 = getelementptr inbounds nuw [60 x double], ptr %5, i64 %71, i64 %122
  store double %124, ptr %125, align 8, !tbaa !6
  %126 = getelementptr inbounds [60 x double], ptr %3, i64 %122, i64 %83
  %127 = load double, ptr %126, align 8, !tbaa !6
  %128 = getelementptr inbounds nuw [60 x double], ptr %3, i64 %122, i64 %71
  %129 = load double, ptr %128, align 8, !tbaa !6
  %130 = fmul double %129, -8.900000e+01
  %131 = tail call double @llvm.fmuladd.f64(double %127, double 4.500000e+01, double %130)
  %132 = getelementptr inbounds nuw [60 x double], ptr %3, i64 %122, i64 %84
  %133 = load double, ptr %132, align 8, !tbaa !6
  %134 = tail call double @llvm.fmuladd.f64(double %133, double 4.500000e+01, double %131)
  %135 = tail call double @llvm.fmuladd.f64(double %120, double 9.000000e+01, double %134)
  %136 = fdiv double %135, %123
  %137 = getelementptr inbounds nuw [60 x double], ptr %6, i64 %71, i64 %122
  store double %136, ptr %137, align 8, !tbaa !6
  %138 = add nuw nsw i64 %122, 1
  %139 = icmp eq i64 %138, 59
  br i1 %139, label %.loopexit4, label %119, !llvm.loop !15

.loopexit3:                                       ; preds = %88
  br label %140

.loopexit4:                                       ; preds = %119
  br label %140

140:                                              ; preds = %.loopexit4, %.loopexit3
  %141 = getelementptr inbounds nuw [60 x double], ptr %65, i64 0, i64 %71
  store double 1.000000e+00, ptr %141, align 8, !tbaa !6
  %142 = getelementptr inbounds nuw [60 x double], ptr %66, i64 0, i64 %71
  br label %143

143:                                              ; preds = %143, %140
  %144 = phi i64 [ 58, %140 ], [ %153, %143 ]
  %145 = getelementptr inbounds nuw [60 x double], ptr %5, i64 %71, i64 %144
  %146 = load double, ptr %145, align 8, !tbaa !6
  %147 = getelementptr inbounds nuw [60 x double], ptr %142, i64 %144
  %148 = load double, ptr %147, align 8, !tbaa !6
  %149 = getelementptr inbounds nuw [60 x double], ptr %6, i64 %71, i64 %144
  %150 = load double, ptr %149, align 8, !tbaa !6
  %151 = tail call double @llvm.fmuladd.f64(double %146, double %148, double %150)
  %152 = getelementptr inbounds nuw [60 x double], ptr %4, i64 %144, i64 %71
  store double %151, ptr %152, align 8, !tbaa !6
  %153 = add nsw i64 %144, -1
  %154 = icmp samesign ugt i64 %144, 1
  br i1 %154, label %143, label %155, !llvm.loop !16

155:                                              ; preds = %143
  %156 = icmp eq i64 %84, 59
  %157 = add i64 %70, 1
  br i1 %156, label %.preheader5, label %69, !llvm.loop !17

.preheader5:                                      ; preds = %155
  br label %158

158:                                              ; preds = %.preheader5, %243
  %159 = phi i64 [ %246, %243 ], [ 0, %.preheader5 ]
  %160 = phi i64 [ %244, %243 ], [ 1, %.preheader5 ]
  %161 = mul nuw nsw i64 %159, 480
  %162 = add nuw i64 %161, 480
  %163 = getelementptr nuw i8, ptr %5, i64 %162
  %164 = add nuw i64 %161, 952
  %165 = getelementptr i8, ptr %5, i64 %164
  %166 = getelementptr nuw i8, ptr %6, i64 %162
  %167 = getelementptr i8, ptr %6, i64 %164
  %168 = getelementptr inbounds nuw [60 x double], ptr %3, i64 %160
  store double 1.000000e+00, ptr %168, align 8, !tbaa !6
  %169 = getelementptr inbounds nuw [60 x double], ptr %5, i64 %160
  store double 0.000000e+00, ptr %169, align 8, !tbaa !6
  %170 = load double, ptr %168, align 8, !tbaa !6
  %171 = getelementptr inbounds nuw [60 x double], ptr %6, i64 %160
  store double %170, ptr %171, align 8, !tbaa !6
  %172 = getelementptr [60 x double], ptr %4, i64 %160
  %173 = getelementptr i8, ptr %172, i64 -480
  %174 = getelementptr inbounds nuw i8, ptr %172, i64 480
  %175 = icmp ult ptr %163, %167
  %176 = icmp ult ptr %166, %165
  %177 = and i1 %175, %176
  br i1 %177, label %.preheader, label %202

.preheader:                                       ; preds = %158
  br label %178

178:                                              ; preds = %.preheader, %178
  %179 = phi i64 [ %200, %178 ], [ 1, %.preheader ]
  %180 = add nsw i64 %179, -1
  %181 = getelementptr inbounds [60 x double], ptr %5, i64 %160, i64 %180
  %182 = load double, ptr %181, align 8, !tbaa !6
  %183 = tail call double @llvm.fmuladd.f64(double %182, double -4.500000e+01, double 9.100000e+01)
  %184 = fdiv double 4.500000e+01, %183
  %185 = getelementptr inbounds nuw [60 x double], ptr %5, i64 %160, i64 %179
  store double %184, ptr %185, align 8, !tbaa !6
  %186 = getelementptr inbounds nuw [60 x double], ptr %173, i64 0, i64 %179
  %187 = load double, ptr %186, align 8, !tbaa !6
  %188 = getelementptr inbounds nuw [60 x double], ptr %4, i64 %160, i64 %179
  %189 = load double, ptr %188, align 8, !tbaa !6
  %190 = fmul double %189, -1.790000e+02
  %191 = tail call double @llvm.fmuladd.f64(double %187, double 9.000000e+01, double %190)
  %192 = getelementptr inbounds nuw [60 x double], ptr %174, i64 0, i64 %179
  %193 = load double, ptr %192, align 8, !tbaa !6
  %194 = tail call double @llvm.fmuladd.f64(double %193, double 9.000000e+01, double %191)
  %195 = getelementptr inbounds [60 x double], ptr %6, i64 %160, i64 %180
  %196 = load double, ptr %195, align 8, !tbaa !6
  %197 = tail call double @llvm.fmuladd.f64(double %196, double 4.500000e+01, double %194)
  %198 = fdiv double %197, %183
  %199 = getelementptr inbounds nuw [60 x double], ptr %6, i64 %160, i64 %179
  store double %198, ptr %199, align 8, !tbaa !6
  %200 = add nuw nsw i64 %179, 1
  %201 = icmp eq i64 %200, 59
  br i1 %201, label %.loopexit, label %178, !llvm.loop !18

202:                                              ; preds = %158
  %203 = mul nuw nsw i64 %159, 480
  %204 = add nuw i64 %203, 480
  %205 = getelementptr nuw i8, ptr %6, i64 %204
  %206 = getelementptr nuw i8, ptr %5, i64 %204
  %207 = load double, ptr %206, align 8
  %208 = load double, ptr %205, align 8
  br label %209

209:                                              ; preds = %209, %202
  %210 = phi double [ %208, %202 ], [ %226, %209 ]
  %211 = phi double [ %207, %202 ], [ %214, %209 ]
  %212 = phi i64 [ 1, %202 ], [ %228, %209 ]
  %213 = tail call double @llvm.fmuladd.f64(double %211, double -4.500000e+01, double 9.100000e+01)
  %214 = fdiv double 4.500000e+01, %213
  %215 = getelementptr inbounds nuw [60 x double], ptr %5, i64 %160, i64 %212
  store double %214, ptr %215, align 8, !tbaa !6
  %216 = getelementptr inbounds nuw [60 x double], ptr %173, i64 0, i64 %212
  %217 = load double, ptr %216, align 8, !tbaa !6
  %218 = getelementptr inbounds nuw [60 x double], ptr %4, i64 %160, i64 %212
  %219 = load double, ptr %218, align 8, !tbaa !6
  %220 = fmul double %219, -1.790000e+02
  %221 = tail call double @llvm.fmuladd.f64(double %217, double 9.000000e+01, double %220)
  %222 = getelementptr inbounds nuw [60 x double], ptr %174, i64 0, i64 %212
  %223 = load double, ptr %222, align 8, !tbaa !6
  %224 = tail call double @llvm.fmuladd.f64(double %223, double 9.000000e+01, double %221)
  %225 = tail call double @llvm.fmuladd.f64(double %210, double 4.500000e+01, double %224)
  %226 = fdiv double %225, %213
  %227 = getelementptr inbounds nuw [60 x double], ptr %6, i64 %160, i64 %212
  store double %226, ptr %227, align 8, !tbaa !6
  %228 = add nuw nsw i64 %212, 1
  %229 = icmp eq i64 %228, 59
  br i1 %229, label %.loopexit1, label %209, !llvm.loop !18

.loopexit:                                        ; preds = %178
  br label %230

.loopexit1:                                       ; preds = %209
  br label %230

230:                                              ; preds = %.loopexit1, %.loopexit
  %231 = getelementptr inbounds nuw i8, ptr %168, i64 472
  store double 1.000000e+00, ptr %231, align 8, !tbaa !6
  br label %232

232:                                              ; preds = %232, %230
  %233 = phi double [ 1.000000e+00, %230 ], [ %239, %232 ]
  %234 = phi i64 [ 58, %230 ], [ %241, %232 ]
  %235 = getelementptr inbounds nuw [60 x double], ptr %5, i64 %160, i64 %234
  %236 = load double, ptr %235, align 8, !tbaa !6
  %237 = getelementptr inbounds nuw [60 x double], ptr %6, i64 %160, i64 %234
  %238 = load double, ptr %237, align 8, !tbaa !6
  %239 = tail call double @llvm.fmuladd.f64(double %236, double %233, double %238)
  %240 = getelementptr inbounds nuw [60 x double], ptr %3, i64 %160, i64 %234
  store double %239, ptr %240, align 8, !tbaa !6
  %241 = add nsw i64 %234, -1
  %242 = icmp samesign ugt i64 %234, 1
  br i1 %242, label %232, label %243, !llvm.loop !19

243:                                              ; preds = %232
  %244 = add nuw nsw i64 %160, 1
  %245 = icmp eq i64 %244, 59
  %246 = add i64 %159, 1
  br i1 %245, label %247, label %158, !llvm.loop !20

247:                                              ; preds = %243
  %248 = add nuw nsw i32 %68, 1
  %249 = icmp eq i32 %248, 41
  br i1 %249, label %250, label %67, !llvm.loop !21

250:                                              ; preds = %247
  tail call void @polybench_timer_stop() #6
  tail call void @polybench_timer_print() #6
  %251 = icmp sgt i32 %0, 42
  br i1 %251, label %252, label %288

252:                                              ; preds = %250
  %253 = load ptr, ptr %1, align 8, !tbaa !22
  %254 = load i8, ptr %253, align 1
  %255 = icmp eq i8 %254, 0
  br i1 %255, label %256, label %288

256:                                              ; preds = %252
  %257 = load ptr, ptr @__stderrp, align 8, !tbaa !25
  %258 = tail call i64 @fwrite(ptr nonnull @.str.1, i64 22, i64 1, ptr %257)
  %259 = load ptr, ptr @__stderrp, align 8, !tbaa !25
  %260 = tail call i32 (ptr, ptr, ...) @fprintf(ptr noundef %259, ptr noundef nonnull @.str.2, ptr noundef nonnull @.str.3) #6
  br label %261

261:                                              ; preds = %280, %256
  %262 = phi i64 [ 0, %256 ], [ %281, %280 ]
  %263 = mul nuw nsw i64 %262, 60
  br label %264

264:                                              ; preds = %273, %261
  %265 = phi i64 [ 0, %261 ], [ %278, %273 ]
  %266 = add nuw nsw i64 %265, %263
  %267 = trunc nuw nsw i64 %266 to i32
  %268 = urem i32 %267, 20
  %269 = icmp eq i32 %268, 0
  br i1 %269, label %270, label %273

270:                                              ; preds = %264
  %271 = load ptr, ptr @__stderrp, align 8, !tbaa !25
  %272 = tail call i32 @fputc(i32 10, ptr %271)
  br label %273

273:                                              ; preds = %270, %264
  %274 = load ptr, ptr @__stderrp, align 8, !tbaa !25
  %275 = getelementptr inbounds nuw [60 x double], ptr %3, i64 %262, i64 %265
  %276 = load double, ptr %275, align 8, !tbaa !6
  %277 = tail call i32 (ptr, ptr, ...) @fprintf(ptr noundef %274, ptr noundef nonnull @.str.5, double noundef %276) #6
  %278 = add nuw nsw i64 %265, 1
  %279 = icmp eq i64 %278, 60
  br i1 %279, label %280, label %264, !llvm.loop !27

280:                                              ; preds = %273
  %281 = add nuw nsw i64 %262, 1
  %282 = icmp eq i64 %281, 60
  br i1 %282, label %283, label %261, !llvm.loop !28

283:                                              ; preds = %280
  %284 = load ptr, ptr @__stderrp, align 8, !tbaa !25
  %285 = tail call i32 (ptr, ptr, ...) @fprintf(ptr noundef %284, ptr noundef nonnull @.str.6, ptr noundef nonnull @.str.3) #6
  %286 = load ptr, ptr @__stderrp, align 8, !tbaa !25
  %287 = tail call i64 @fwrite(ptr nonnull @.str.7, i64 22, i64 1, ptr %286)
  br label %288

288:                                              ; preds = %283, %252, %250
  tail call void @free(ptr noundef nonnull %3)
  tail call void @free(ptr noundef %4)
  tail call void @free(ptr noundef %5)
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
!15 = distinct !{!15, !11}
!16 = distinct !{!16, !11}
!17 = distinct !{!17, !11}
!18 = distinct !{!18, !11}
!19 = distinct !{!19, !11}
!20 = distinct !{!20, !11}
!21 = distinct !{!21, !11}
!22 = !{!23, !23, i64 0}
!23 = !{!"p1 omnipotent char", !24, i64 0}
!24 = !{!"any pointer", !8, i64 0}
!25 = !{!26, !26, i64 0}
!26 = !{!"p1 _ZTS7__sFILE", !24, i64 0}
!27 = distinct !{!27, !11}
!28 = distinct !{!28, !11}
