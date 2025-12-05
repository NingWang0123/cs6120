; ModuleID = './polybench/linear-algebra/blas/gemver/gemver.c'
source_filename = "./polybench/linear-algebra/blas/gemver/gemver.c"
target datalayout = "e-m:o-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-n32:64-S128-Fn32"
target triple = "arm64-apple-macosx15.0.0"

@__stderrp = external local_unnamed_addr global ptr, align 8
@.str.1 = private unnamed_addr constant [23 x i8] c"==BEGIN DUMP_ARRAYS==\0A\00", align 1
@.str.2 = private unnamed_addr constant [15 x i8] c"begin dump: %s\00", align 1
@.str.3 = private unnamed_addr constant [2 x i8] c"w\00", align 1
@.str.5 = private unnamed_addr constant [8 x i8] c"%0.2lf \00", align 1
@.str.6 = private unnamed_addr constant [17 x i8] c"\0Aend   dump: %s\0A\00", align 1
@.str.7 = private unnamed_addr constant [23 x i8] c"==END   DUMP_ARRAYS==\0A\00", align 1

; Function Attrs: nounwind ssp uwtable(sync)
define noundef i32 @main(i32 noundef %0, ptr noundef readonly captures(none) %1) local_unnamed_addr #0 {
  %3 = tail call ptr @polybench_alloc_data(i64 noundef 14400, i32 noundef 8) #7
  %4 = tail call ptr @polybench_alloc_data(i64 noundef 120, i32 noundef 8) #7
  %5 = tail call ptr @polybench_alloc_data(i64 noundef 120, i32 noundef 8) #7
  %6 = tail call ptr @polybench_alloc_data(i64 noundef 120, i32 noundef 8) #7
  %7 = tail call ptr @polybench_alloc_data(i64 noundef 120, i32 noundef 8) #7
  %8 = tail call ptr @polybench_alloc_data(i64 noundef 120, i32 noundef 8) #7
  %9 = tail call ptr @polybench_alloc_data(i64 noundef 120, i32 noundef 8) #7
  %10 = tail call ptr @polybench_alloc_data(i64 noundef 120, i32 noundef 8) #7
  %11 = tail call ptr @polybench_alloc_data(i64 noundef 120, i32 noundef 8) #7
  br label %12

12:                                               ; preds = %47, %2
  %13 = phi i64 [ 0, %2 ], [ %17, %47 ]
  %14 = trunc nuw nsw i64 %13 to i32
  %15 = uitofp nneg i32 %14 to double
  %16 = getelementptr inbounds nuw double, ptr %4, i64 %13
  store double %15, ptr %16, align 8, !tbaa !6
  %17 = add nuw nsw i64 %13, 1
  %18 = trunc nuw nsw i64 %17 to i32
  %19 = uitofp nneg i32 %18 to double
  %20 = fdiv double %19, 1.200000e+02
  %21 = fmul double %20, 5.000000e-01
  %22 = getelementptr inbounds nuw double, ptr %6, i64 %13
  store double %21, ptr %22, align 8, !tbaa !6
  %23 = fmul double %20, 2.500000e-01
  %24 = getelementptr inbounds nuw double, ptr %5, i64 %13
  store double %23, ptr %24, align 8, !tbaa !6
  %25 = fdiv double %20, 6.000000e+00
  %26 = getelementptr inbounds nuw double, ptr %7, i64 %13
  store double %25, ptr %26, align 8, !tbaa !6
  %27 = fmul double %20, 1.250000e-01
  %28 = getelementptr inbounds nuw double, ptr %10, i64 %13
  store double %27, ptr %28, align 8, !tbaa !6
  %29 = fdiv double %20, 9.000000e+00
  %30 = getelementptr inbounds nuw double, ptr %11, i64 %13
  store double %29, ptr %30, align 8, !tbaa !6
  %31 = getelementptr inbounds nuw double, ptr %9, i64 %13
  store double 0.000000e+00, ptr %31, align 8, !tbaa !6
  %32 = getelementptr inbounds nuw double, ptr %8, i64 %13
  store double 0.000000e+00, ptr %32, align 8, !tbaa !6
  %33 = insertelement <2 x i64> poison, i64 %13, i64 0
  %34 = shufflevector <2 x i64> %33, <2 x i64> poison, <2 x i32> zeroinitializer
  br label %35

35:                                               ; preds = %35, %12
  %36 = phi i64 [ 0, %12 ], [ %44, %35 ]
  %37 = phi <2 x i64> [ <i64 0, i64 1>, %12 ], [ %45, %35 ]
  %38 = mul nuw nsw <2 x i64> %37, %34
  %39 = trunc nuw nsw <2 x i64> %38 to <2 x i32>
  %40 = urem <2 x i32> %39, splat (i32 120)
  %41 = uitofp nneg <2 x i32> %40 to <2 x double>
  %42 = fdiv <2 x double> %41, splat (double 1.200000e+02)
  %43 = getelementptr inbounds nuw [120 x double], ptr %3, i64 %13, i64 %36
  store <2 x double> %42, ptr %43, align 8, !tbaa !6
  %44 = add nuw i64 %36, 2
  %45 = add <2 x i64> %37, splat (i64 2)
  %46 = icmp eq i64 %44, 120
  br i1 %46, label %47, label %35, !llvm.loop !10

47:                                               ; preds = %35
  %48 = icmp eq i64 %17, 120
  br i1 %48, label %49, label %12, !llvm.loop !14

49:                                               ; preds = %47
  tail call void @polybench_timer_start() #7
  %50 = getelementptr i8, ptr %3, i64 115200
  %51 = getelementptr i8, ptr %4, i64 960
  %52 = getelementptr i8, ptr %5, i64 960
  %53 = getelementptr i8, ptr %6, i64 960
  %54 = getelementptr i8, ptr %7, i64 960
  %55 = icmp ult ptr %3, %51
  %56 = icmp ult ptr %4, %50
  %57 = and i1 %55, %56
  %58 = icmp ult ptr %3, %52
  %59 = icmp ult ptr %5, %50
  %60 = and i1 %58, %59
  %61 = or i1 %57, %60
  %62 = icmp ult ptr %3, %53
  %63 = icmp ult ptr %6, %50
  %64 = and i1 %62, %63
  %65 = or i1 %61, %64
  %66 = icmp ult ptr %3, %54
  %67 = icmp ult ptr %7, %50
  %68 = and i1 %66, %67
  %69 = or i1 %65, %68
  br label %70

70:                                               ; preds = %131, %49
  %71 = phi i64 [ 0, %49 ], [ %132, %131 ]
  %72 = getelementptr inbounds nuw double, ptr %4, i64 %71
  %73 = getelementptr inbounds nuw double, ptr %6, i64 %71
  br i1 %69, label %117, label %74

74:                                               ; preds = %70
  %75 = load double, ptr %72, align 8, !tbaa !6, !alias.scope !15
  %76 = insertelement <2 x double> poison, double %75, i64 0
  %77 = shufflevector <2 x double> %76, <2 x double> poison, <2 x i32> zeroinitializer
  %78 = load double, ptr %73, align 8, !tbaa !6, !alias.scope !18
  %79 = insertelement <2 x double> poison, double %78, i64 0
  %80 = shufflevector <2 x double> %79, <2 x double> poison, <2 x i32> zeroinitializer
  br label %81

81:                                               ; preds = %74, %81
  %82 = phi i64 [ %115, %81 ], [ 0, %74 ]
  %83 = getelementptr inbounds nuw [120 x double], ptr %3, i64 %71, i64 %82
  %84 = getelementptr inbounds nuw i8, ptr %83, i64 16
  %85 = getelementptr inbounds nuw i8, ptr %83, i64 32
  %86 = getelementptr inbounds nuw i8, ptr %83, i64 48
  %87 = load <2 x double>, ptr %83, align 8, !tbaa !6, !alias.scope !20, !noalias !22
  %88 = load <2 x double>, ptr %84, align 8, !tbaa !6, !alias.scope !20, !noalias !22
  %89 = load <2 x double>, ptr %85, align 8, !tbaa !6, !alias.scope !20, !noalias !22
  %90 = load <2 x double>, ptr %86, align 8, !tbaa !6, !alias.scope !20, !noalias !22
  %91 = getelementptr inbounds nuw double, ptr %5, i64 %82
  %92 = getelementptr inbounds nuw i8, ptr %91, i64 16
  %93 = getelementptr inbounds nuw i8, ptr %91, i64 32
  %94 = getelementptr inbounds nuw i8, ptr %91, i64 48
  %95 = load <2 x double>, ptr %91, align 8, !tbaa !6, !alias.scope !25
  %96 = load <2 x double>, ptr %92, align 8, !tbaa !6, !alias.scope !25
  %97 = load <2 x double>, ptr %93, align 8, !tbaa !6, !alias.scope !25
  %98 = load <2 x double>, ptr %94, align 8, !tbaa !6, !alias.scope !25
  %99 = tail call <2 x double> @llvm.fmuladd.v2f64(<2 x double> %77, <2 x double> %95, <2 x double> %87)
  %100 = tail call <2 x double> @llvm.fmuladd.v2f64(<2 x double> %77, <2 x double> %96, <2 x double> %88)
  %101 = tail call <2 x double> @llvm.fmuladd.v2f64(<2 x double> %77, <2 x double> %97, <2 x double> %89)
  %102 = tail call <2 x double> @llvm.fmuladd.v2f64(<2 x double> %77, <2 x double> %98, <2 x double> %90)
  %103 = getelementptr inbounds nuw double, ptr %7, i64 %82
  %104 = getelementptr inbounds nuw i8, ptr %103, i64 16
  %105 = getelementptr inbounds nuw i8, ptr %103, i64 32
  %106 = getelementptr inbounds nuw i8, ptr %103, i64 48
  %107 = load <2 x double>, ptr %103, align 8, !tbaa !6, !alias.scope !26
  %108 = load <2 x double>, ptr %104, align 8, !tbaa !6, !alias.scope !26
  %109 = load <2 x double>, ptr %105, align 8, !tbaa !6, !alias.scope !26
  %110 = load <2 x double>, ptr %106, align 8, !tbaa !6, !alias.scope !26
  %111 = tail call <2 x double> @llvm.fmuladd.v2f64(<2 x double> %80, <2 x double> %107, <2 x double> %99)
  %112 = tail call <2 x double> @llvm.fmuladd.v2f64(<2 x double> %80, <2 x double> %108, <2 x double> %100)
  %113 = tail call <2 x double> @llvm.fmuladd.v2f64(<2 x double> %80, <2 x double> %109, <2 x double> %101)
  %114 = tail call <2 x double> @llvm.fmuladd.v2f64(<2 x double> %80, <2 x double> %110, <2 x double> %102)
  store <2 x double> %111, ptr %83, align 8, !tbaa !6, !alias.scope !20, !noalias !22
  store <2 x double> %112, ptr %84, align 8, !tbaa !6, !alias.scope !20, !noalias !22
  store <2 x double> %113, ptr %85, align 8, !tbaa !6, !alias.scope !20, !noalias !22
  store <2 x double> %114, ptr %86, align 8, !tbaa !6, !alias.scope !20, !noalias !22
  %115 = add nuw i64 %82, 8
  %116 = icmp eq i64 %115, 120
  br i1 %116, label %131, label %81, !llvm.loop !27

117:                                              ; preds = %70, %117
  %118 = phi i64 [ %129, %117 ], [ 0, %70 ]
  %119 = getelementptr inbounds nuw [120 x double], ptr %3, i64 %71, i64 %118
  %120 = load double, ptr %119, align 8, !tbaa !6
  %121 = load double, ptr %72, align 8, !tbaa !6
  %122 = getelementptr inbounds nuw double, ptr %5, i64 %118
  %123 = load double, ptr %122, align 8, !tbaa !6
  %124 = tail call double @llvm.fmuladd.f64(double %121, double %123, double %120)
  %125 = load double, ptr %73, align 8, !tbaa !6
  %126 = getelementptr inbounds nuw double, ptr %7, i64 %118
  %127 = load double, ptr %126, align 8, !tbaa !6
  %128 = tail call double @llvm.fmuladd.f64(double %125, double %127, double %124)
  store double %128, ptr %119, align 8, !tbaa !6
  %129 = add nuw nsw i64 %118, 1
  %130 = icmp eq i64 %129, 120
  br i1 %130, label %131, label %117, !llvm.loop !28

131:                                              ; preds = %81, %117
  %132 = add nuw nsw i64 %71, 1
  %133 = icmp eq i64 %132, 120
  br i1 %133, label %134, label %70, !llvm.loop !29

134:                                              ; preds = %131, %149
  %135 = phi i64 [ %150, %149 ], [ 0, %131 ]
  %136 = getelementptr inbounds nuw double, ptr %9, i64 %135
  %137 = load double, ptr %136, align 8, !tbaa !6
  br label %138

138:                                              ; preds = %138, %134
  %139 = phi i64 [ 0, %134 ], [ %147, %138 ]
  %140 = phi double [ %137, %134 ], [ %146, %138 ]
  %141 = getelementptr inbounds nuw [120 x double], ptr %3, i64 %139, i64 %135
  %142 = load double, ptr %141, align 8, !tbaa !6
  %143 = fmul double %142, 1.200000e+00
  %144 = getelementptr inbounds nuw double, ptr %10, i64 %139
  %145 = load double, ptr %144, align 8, !tbaa !6
  %146 = tail call double @llvm.fmuladd.f64(double %143, double %145, double %140)
  store double %146, ptr %136, align 8, !tbaa !6
  %147 = add nuw nsw i64 %139, 1
  %148 = icmp eq i64 %147, 120
  br i1 %148, label %149, label %138, !llvm.loop !30

149:                                              ; preds = %138
  %150 = add nuw nsw i64 %135, 1
  %151 = icmp eq i64 %150, 120
  br i1 %151, label %152, label %134, !llvm.loop !31

152:                                              ; preds = %149
  %153 = getelementptr i8, ptr %9, i64 960
  %154 = getelementptr i8, ptr %11, i64 960
  %155 = icmp ult ptr %9, %154
  %156 = icmp ult ptr %11, %153
  %157 = and i1 %155, %156
  br i1 %157, label %182, label %158

158:                                              ; preds = %152, %158
  %159 = phi i64 [ %180, %158 ], [ 0, %152 ]
  %160 = getelementptr inbounds nuw double, ptr %9, i64 %159
  %161 = getelementptr inbounds nuw i8, ptr %160, i64 16
  %162 = getelementptr inbounds nuw i8, ptr %160, i64 32
  %163 = getelementptr inbounds nuw i8, ptr %160, i64 48
  %164 = load <2 x double>, ptr %160, align 8, !tbaa !6, !alias.scope !32, !noalias !35
  %165 = load <2 x double>, ptr %161, align 8, !tbaa !6, !alias.scope !32, !noalias !35
  %166 = load <2 x double>, ptr %162, align 8, !tbaa !6, !alias.scope !32, !noalias !35
  %167 = load <2 x double>, ptr %163, align 8, !tbaa !6, !alias.scope !32, !noalias !35
  %168 = getelementptr inbounds nuw double, ptr %11, i64 %159
  %169 = getelementptr inbounds nuw i8, ptr %168, i64 16
  %170 = getelementptr inbounds nuw i8, ptr %168, i64 32
  %171 = getelementptr inbounds nuw i8, ptr %168, i64 48
  %172 = load <2 x double>, ptr %168, align 8, !tbaa !6, !alias.scope !35
  %173 = load <2 x double>, ptr %169, align 8, !tbaa !6, !alias.scope !35
  %174 = load <2 x double>, ptr %170, align 8, !tbaa !6, !alias.scope !35
  %175 = load <2 x double>, ptr %171, align 8, !tbaa !6, !alias.scope !35
  %176 = fadd <2 x double> %164, %172
  %177 = fadd <2 x double> %165, %173
  %178 = fadd <2 x double> %166, %174
  %179 = fadd <2 x double> %167, %175
  store <2 x double> %176, ptr %160, align 8, !tbaa !6, !alias.scope !32, !noalias !35
  store <2 x double> %177, ptr %161, align 8, !tbaa !6, !alias.scope !32, !noalias !35
  store <2 x double> %178, ptr %162, align 8, !tbaa !6, !alias.scope !32, !noalias !35
  store <2 x double> %179, ptr %163, align 8, !tbaa !6, !alias.scope !32, !noalias !35
  %180 = add nuw i64 %159, 8
  %181 = icmp eq i64 %180, 120
  br i1 %181, label %191, label %158, !llvm.loop !37

182:                                              ; preds = %152, %182
  %183 = phi i64 [ %189, %182 ], [ 0, %152 ]
  %184 = getelementptr inbounds nuw double, ptr %9, i64 %183
  %185 = load double, ptr %184, align 8, !tbaa !6
  %186 = getelementptr inbounds nuw double, ptr %11, i64 %183
  %187 = load double, ptr %186, align 8, !tbaa !6
  %188 = fadd double %185, %187
  store double %188, ptr %184, align 8, !tbaa !6
  %189 = add nuw nsw i64 %183, 1
  %190 = icmp eq i64 %189, 120
  br i1 %190, label %191, label %182, !llvm.loop !38

191:                                              ; preds = %158, %182
  %192 = getelementptr i8, ptr %8, i64 960
  %193 = getelementptr i8, ptr %3, i64 115200
  %194 = getelementptr i8, ptr %9, i64 960
  %195 = icmp ult ptr %8, %193
  %196 = icmp ult ptr %3, %192
  %197 = and i1 %195, %196
  %198 = icmp ult ptr %8, %194
  %199 = icmp ult ptr %9, %192
  %200 = and i1 %198, %199
  %201 = or i1 %197, %200
  br label %202

202:                                              ; preds = %191, %251
  %203 = phi i64 [ %252, %251 ], [ 0, %191 ]
  %204 = getelementptr inbounds nuw double, ptr %8, i64 %203
  %205 = load double, ptr %204, align 8, !tbaa !6
  br i1 %201, label %240, label %206

206:                                              ; preds = %202, %206
  %207 = phi i64 [ %237, %206 ], [ 0, %202 ]
  %208 = phi double [ %236, %206 ], [ %205, %202 ]
  %209 = getelementptr inbounds nuw [120 x double], ptr %3, i64 %203, i64 %207
  %210 = getelementptr inbounds nuw i8, ptr %209, i64 16
  %211 = getelementptr inbounds nuw i8, ptr %209, i64 32
  %212 = getelementptr inbounds nuw i8, ptr %209, i64 48
  %213 = load <2 x double>, ptr %209, align 8, !tbaa !6, !alias.scope !39
  %214 = load <2 x double>, ptr %210, align 8, !tbaa !6, !alias.scope !39
  %215 = load <2 x double>, ptr %211, align 8, !tbaa !6, !alias.scope !39
  %216 = load <2 x double>, ptr %212, align 8, !tbaa !6, !alias.scope !39
  %217 = fmul <2 x double> %213, splat (double 1.500000e+00)
  %218 = fmul <2 x double> %214, splat (double 1.500000e+00)
  %219 = fmul <2 x double> %215, splat (double 1.500000e+00)
  %220 = fmul <2 x double> %216, splat (double 1.500000e+00)
  %221 = getelementptr inbounds nuw double, ptr %9, i64 %207
  %222 = getelementptr inbounds nuw i8, ptr %221, i64 16
  %223 = getelementptr inbounds nuw i8, ptr %221, i64 32
  %224 = getelementptr inbounds nuw i8, ptr %221, i64 48
  %225 = load <2 x double>, ptr %221, align 8, !tbaa !6, !alias.scope !42
  %226 = load <2 x double>, ptr %222, align 8, !tbaa !6, !alias.scope !42
  %227 = load <2 x double>, ptr %223, align 8, !tbaa !6, !alias.scope !42
  %228 = load <2 x double>, ptr %224, align 8, !tbaa !6, !alias.scope !42
  %229 = fmul <2 x double> %217, %225
  %230 = fmul <2 x double> %218, %226
  %231 = fmul <2 x double> %219, %227
  %232 = fmul <2 x double> %220, %228
  %233 = tail call double @llvm.vector.reduce.fadd.v2f64(double %208, <2 x double> %229)
  %234 = tail call double @llvm.vector.reduce.fadd.v2f64(double %233, <2 x double> %230)
  %235 = tail call double @llvm.vector.reduce.fadd.v2f64(double %234, <2 x double> %231)
  %236 = tail call double @llvm.vector.reduce.fadd.v2f64(double %235, <2 x double> %232)
  %237 = add nuw i64 %207, 8
  %238 = icmp eq i64 %237, 120
  br i1 %238, label %239, label %206, !llvm.loop !44

239:                                              ; preds = %206
  store double %236, ptr %204, align 8, !tbaa !6, !alias.scope !45, !noalias !47
  br label %251

240:                                              ; preds = %202, %240
  %241 = phi i64 [ %249, %240 ], [ 0, %202 ]
  %242 = phi double [ %248, %240 ], [ %205, %202 ]
  %243 = getelementptr inbounds nuw [120 x double], ptr %3, i64 %203, i64 %241
  %244 = load double, ptr %243, align 8, !tbaa !6
  %245 = fmul double %244, 1.500000e+00
  %246 = getelementptr inbounds nuw double, ptr %9, i64 %241
  %247 = load double, ptr %246, align 8, !tbaa !6
  %248 = tail call double @llvm.fmuladd.f64(double %245, double %247, double %242)
  store double %248, ptr %204, align 8, !tbaa !6
  %249 = add nuw nsw i64 %241, 1
  %250 = icmp eq i64 %249, 120
  br i1 %250, label %251, label %240, !llvm.loop !48

251:                                              ; preds = %240, %239
  %252 = add nuw nsw i64 %203, 1
  %253 = icmp eq i64 %252, 120
  br i1 %253, label %254, label %202, !llvm.loop !49

254:                                              ; preds = %251
  tail call void @polybench_timer_stop() #7
  tail call void @polybench_timer_print() #7
  %255 = icmp sgt i32 %0, 42
  br i1 %255, label %256, label %285

256:                                              ; preds = %254
  %257 = load ptr, ptr %1, align 8, !tbaa !50
  %258 = load i8, ptr %257, align 1
  %259 = icmp eq i8 %258, 0
  br i1 %259, label %260, label %285

260:                                              ; preds = %256
  %261 = load ptr, ptr @__stderrp, align 8, !tbaa !53
  %262 = tail call i64 @fwrite(ptr nonnull @.str.1, i64 22, i64 1, ptr %261)
  %263 = load ptr, ptr @__stderrp, align 8, !tbaa !53
  %264 = tail call i32 (ptr, ptr, ...) @fprintf(ptr noundef %263, ptr noundef nonnull @.str.2, ptr noundef nonnull @.str.3) #7
  br label %265

265:                                              ; preds = %273, %260
  %266 = phi i64 [ 0, %260 ], [ %278, %273 ]
  %267 = trunc i64 %266 to i8
  %268 = urem i8 %267, 20
  %269 = icmp eq i8 %268, 0
  br i1 %269, label %270, label %273

270:                                              ; preds = %265
  %271 = load ptr, ptr @__stderrp, align 8, !tbaa !53
  %272 = tail call i32 @fputc(i32 10, ptr %271)
  br label %273

273:                                              ; preds = %270, %265
  %274 = load ptr, ptr @__stderrp, align 8, !tbaa !53
  %275 = getelementptr inbounds nuw double, ptr %8, i64 %266
  %276 = load double, ptr %275, align 8, !tbaa !6
  %277 = tail call i32 (ptr, ptr, ...) @fprintf(ptr noundef %274, ptr noundef nonnull @.str.5, double noundef %276) #7
  %278 = add nuw nsw i64 %266, 1
  %279 = icmp eq i64 %278, 120
  br i1 %279, label %280, label %265, !llvm.loop !55

280:                                              ; preds = %273
  %281 = load ptr, ptr @__stderrp, align 8, !tbaa !53
  %282 = tail call i32 (ptr, ptr, ...) @fprintf(ptr noundef %281, ptr noundef nonnull @.str.6, ptr noundef nonnull @.str.3) #7
  %283 = load ptr, ptr @__stderrp, align 8, !tbaa !53
  %284 = tail call i64 @fwrite(ptr nonnull @.str.7, i64 22, i64 1, ptr %283)
  br label %285

285:                                              ; preds = %280, %256, %254
  tail call void @free(ptr noundef %3)
  tail call void @free(ptr noundef %4)
  tail call void @free(ptr noundef %5)
  tail call void @free(ptr noundef %6)
  tail call void @free(ptr noundef %7)
  tail call void @free(ptr noundef nonnull %8)
  tail call void @free(ptr noundef %9)
  tail call void @free(ptr noundef %10)
  tail call void @free(ptr noundef %11)
  ret i32 0
}

declare ptr @polybench_alloc_data(i64 noundef, i32 noundef) local_unnamed_addr #1

declare void @polybench_timer_start(...) local_unnamed_addr #1

declare void @polybench_timer_stop(...) local_unnamed_addr #1

declare void @polybench_timer_print(...) local_unnamed_addr #1

; Function Attrs: mustprogress nounwind willreturn allockind("free") memory(argmem: readwrite, inaccessiblemem: readwrite)
declare void @free(ptr allocptr noundef captures(none)) local_unnamed_addr #2

; Function Attrs: mustprogress nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare double @llvm.fmuladd.f64(double, double, double) #3

; Function Attrs: nofree nounwind
declare noundef i32 @fprintf(ptr noundef captures(none), ptr noundef readonly captures(none), ...) local_unnamed_addr #4

; Function Attrs: nofree nounwind
declare noundef i64 @fwrite(ptr noundef readonly captures(none), i64 noundef, i64 noundef, ptr noundef captures(none)) local_unnamed_addr #5

; Function Attrs: nofree nounwind
declare noundef i32 @fputc(i32 noundef, ptr noundef captures(none)) local_unnamed_addr #5

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare <2 x double> @llvm.fmuladd.v2f64(<2 x double>, <2 x double>, <2 x double>) #6

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare double @llvm.vector.reduce.fadd.v2f64(double, <2 x double>) #6

attributes #0 = { nounwind ssp uwtable(sync) "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+ccpp,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a" }
attributes #1 = { "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+ccpp,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a" }
attributes #2 = { mustprogress nounwind willreturn allockind("free") memory(argmem: readwrite, inaccessiblemem: readwrite) "alloc-family"="malloc" "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+ccpp,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a" }
attributes #3 = { mustprogress nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #4 = { nofree nounwind "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+ccpp,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a" }
attributes #5 = { nofree nounwind }
attributes #6 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
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
!15 = !{!16}
!16 = distinct !{!16, !17}
!17 = distinct !{!17, !"LVerDomain"}
!18 = !{!19}
!19 = distinct !{!19, !17}
!20 = !{!21}
!21 = distinct !{!21, !17}
!22 = !{!16, !23, !19, !24}
!23 = distinct !{!23, !17}
!24 = distinct !{!24, !17}
!25 = !{!23}
!26 = !{!24}
!27 = distinct !{!27, !11, !12, !13}
!28 = distinct !{!28, !11, !12}
!29 = distinct !{!29, !11}
!30 = distinct !{!30, !11}
!31 = distinct !{!31, !11}
!32 = !{!33}
!33 = distinct !{!33, !34}
!34 = distinct !{!34, !"LVerDomain"}
!35 = !{!36}
!36 = distinct !{!36, !34}
!37 = distinct !{!37, !11, !12, !13}
!38 = distinct !{!38, !11, !12}
!39 = !{!40}
!40 = distinct !{!40, !41}
!41 = distinct !{!41, !"LVerDomain"}
!42 = !{!43}
!43 = distinct !{!43, !41}
!44 = distinct !{!44, !11, !12, !13}
!45 = !{!46}
!46 = distinct !{!46, !41}
!47 = !{!40, !43}
!48 = distinct !{!48, !11, !12}
!49 = distinct !{!49, !11}
!50 = !{!51, !51, i64 0}
!51 = !{!"p1 omnipotent char", !52, i64 0}
!52 = !{!"any pointer", !8, i64 0}
!53 = !{!54, !54, i64 0}
!54 = !{!"p1 _ZTS7__sFILE", !52, i64 0}
!55 = distinct !{!55, !11}
