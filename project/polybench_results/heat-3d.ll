; ModuleID = './polybench/stencils/heat-3d/heat-3d.c'
source_filename = "./polybench/stencils/heat-3d/heat-3d.c"
target datalayout = "e-m:o-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-n32:64-S128-Fn32"
target triple = "arm64-apple-macosx15.0.0"

@__stderrp = external local_unnamed_addr global ptr, align 8
@.str.1 = private unnamed_addr constant [23 x i8] c"==BEGIN DUMP_ARRAYS==\0A\00", align 1
@.str.2 = private unnamed_addr constant [15 x i8] c"begin dump: %s\00", align 1
@.str.3 = private unnamed_addr constant [2 x i8] c"A\00", align 1
@.str.5 = private unnamed_addr constant [8 x i8] c"%0.2lf \00", align 1
@.str.6 = private unnamed_addr constant [17 x i8] c"\0Aend   dump: %s\0A\00", align 1
@.str.7 = private unnamed_addr constant [23 x i8] c"==END   DUMP_ARRAYS==\0A\00", align 1

; Function Attrs: nounwind ssp uwtable(sync)
define noundef i32 @main(i32 noundef %0, ptr noundef readonly captures(none) %1) local_unnamed_addr #0 {
  %3 = tail call ptr @polybench_alloc_data(i64 noundef 8000, i32 noundef 8) #7
  %4 = ptrtoint ptr %3 to i64
  %5 = tail call ptr @polybench_alloc_data(i64 noundef 8000, i32 noundef 8) #7
  %6 = ptrtoint ptr %5 to i64
  %7 = sub i64 %4, %6
  %8 = icmp ult i64 %7, 64
  br label %9

9:                                                ; preds = %90, %2
  %10 = phi i64 [ 0, %2 ], [ %91, %90 ]
  %11 = add nuw nsw i64 %10, 20
  br label %12

12:                                               ; preds = %87, %9
  %13 = phi i64 [ 0, %9 ], [ %88, %87 ]
  %14 = add nuw nsw i64 %11, %13
  br i1 %8, label %74, label %15

15:                                               ; preds = %12
  %16 = insertelement <2 x i64> poison, i64 %14, i64 0
  %17 = shufflevector <2 x i64> %16, <2 x i64> poison, <2 x i32> zeroinitializer
  %18 = trunc <2 x i64> %17 to <2 x i32>
  %19 = add <2 x i32> %18, <i32 0, i32 -1>
  %20 = trunc <2 x i64> %17 to <2 x i32>
  %21 = add <2 x i32> %20, <i32 -2, i32 -3>
  %22 = trunc <2 x i64> %17 to <2 x i32>
  %23 = add <2 x i32> %22, <i32 -4, i32 -5>
  %24 = trunc <2 x i64> %17 to <2 x i32>
  %25 = add <2 x i32> %24, <i32 -6, i32 -7>
  %26 = sitofp <2 x i32> %19 to <2 x double>
  %27 = sitofp <2 x i32> %21 to <2 x double>
  %28 = sitofp <2 x i32> %23 to <2 x double>
  %29 = sitofp <2 x i32> %25 to <2 x double>
  %30 = fmul <2 x double> %26, splat (double 1.000000e+01)
  %31 = fmul <2 x double> %27, splat (double 1.000000e+01)
  %32 = fmul <2 x double> %28, splat (double 1.000000e+01)
  %33 = fmul <2 x double> %29, splat (double 1.000000e+01)
  %34 = fdiv <2 x double> %30, splat (double 2.000000e+01)
  %35 = fdiv <2 x double> %31, splat (double 2.000000e+01)
  %36 = fdiv <2 x double> %32, splat (double 2.000000e+01)
  %37 = fdiv <2 x double> %33, splat (double 2.000000e+01)
  %38 = getelementptr inbounds nuw [20 x [20 x double]], ptr %5, i64 %10, i64 %13, i64 0
  %39 = getelementptr inbounds nuw i8, ptr %38, i64 16
  %40 = getelementptr inbounds nuw i8, ptr %38, i64 32
  %41 = getelementptr inbounds nuw i8, ptr %38, i64 48
  store <2 x double> %34, ptr %38, align 8, !tbaa !6
  store <2 x double> %35, ptr %39, align 8, !tbaa !6
  store <2 x double> %36, ptr %40, align 8, !tbaa !6
  store <2 x double> %37, ptr %41, align 8, !tbaa !6
  %42 = getelementptr inbounds nuw [20 x [20 x double]], ptr %3, i64 %10, i64 %13, i64 0
  %43 = getelementptr inbounds nuw i8, ptr %42, i64 16
  %44 = getelementptr inbounds nuw i8, ptr %42, i64 32
  %45 = getelementptr inbounds nuw i8, ptr %42, i64 48
  store <2 x double> %34, ptr %42, align 8, !tbaa !6
  store <2 x double> %35, ptr %43, align 8, !tbaa !6
  store <2 x double> %36, ptr %44, align 8, !tbaa !6
  store <2 x double> %37, ptr %45, align 8, !tbaa !6
  %46 = trunc <2 x i64> %17 to <2 x i32>
  %47 = add <2 x i32> %46, <i32 -8, i32 -9>
  %48 = trunc <2 x i64> %17 to <2 x i32>
  %49 = add <2 x i32> %48, <i32 -10, i32 -11>
  %50 = trunc <2 x i64> %17 to <2 x i32>
  %51 = add <2 x i32> %50, <i32 -12, i32 -13>
  %52 = trunc <2 x i64> %17 to <2 x i32>
  %53 = add <2 x i32> %52, <i32 -14, i32 -15>
  %54 = sitofp <2 x i32> %47 to <2 x double>
  %55 = sitofp <2 x i32> %49 to <2 x double>
  %56 = sitofp <2 x i32> %51 to <2 x double>
  %57 = sitofp <2 x i32> %53 to <2 x double>
  %58 = fmul <2 x double> %54, splat (double 1.000000e+01)
  %59 = fmul <2 x double> %55, splat (double 1.000000e+01)
  %60 = fmul <2 x double> %56, splat (double 1.000000e+01)
  %61 = fmul <2 x double> %57, splat (double 1.000000e+01)
  %62 = fdiv <2 x double> %58, splat (double 2.000000e+01)
  %63 = fdiv <2 x double> %59, splat (double 2.000000e+01)
  %64 = fdiv <2 x double> %60, splat (double 2.000000e+01)
  %65 = fdiv <2 x double> %61, splat (double 2.000000e+01)
  %66 = getelementptr inbounds nuw [20 x [20 x double]], ptr %5, i64 %10, i64 %13, i64 8
  %67 = getelementptr inbounds nuw i8, ptr %66, i64 16
  %68 = getelementptr inbounds nuw i8, ptr %66, i64 32
  %69 = getelementptr inbounds nuw i8, ptr %66, i64 48
  store <2 x double> %62, ptr %66, align 8, !tbaa !6
  store <2 x double> %63, ptr %67, align 8, !tbaa !6
  store <2 x double> %64, ptr %68, align 8, !tbaa !6
  store <2 x double> %65, ptr %69, align 8, !tbaa !6
  %70 = getelementptr inbounds nuw [20 x [20 x double]], ptr %3, i64 %10, i64 %13, i64 8
  %71 = getelementptr inbounds nuw i8, ptr %70, i64 16
  %72 = getelementptr inbounds nuw i8, ptr %70, i64 32
  %73 = getelementptr inbounds nuw i8, ptr %70, i64 48
  store <2 x double> %62, ptr %70, align 8, !tbaa !6
  store <2 x double> %63, ptr %71, align 8, !tbaa !6
  store <2 x double> %64, ptr %72, align 8, !tbaa !6
  store <2 x double> %65, ptr %73, align 8, !tbaa !6
  br label %74

74:                                               ; preds = %15, %12
  %75 = phi i64 [ 0, %12 ], [ 16, %15 ]
  br label %76

76:                                               ; preds = %74, %76
  %77 = phi i64 [ %85, %76 ], [ %75, %74 ]
  %78 = sub nuw nsw i64 %14, %77
  %79 = trunc nuw nsw i64 %78 to i32
  %80 = sitofp i32 %79 to double
  %81 = fmul double %80, 1.000000e+01
  %82 = fdiv double %81, 2.000000e+01
  %83 = getelementptr inbounds nuw [20 x [20 x double]], ptr %5, i64 %10, i64 %13, i64 %77
  store double %82, ptr %83, align 8, !tbaa !6
  %84 = getelementptr inbounds nuw [20 x [20 x double]], ptr %3, i64 %10, i64 %13, i64 %77
  store double %82, ptr %84, align 8, !tbaa !6
  %85 = add nuw nsw i64 %77, 1
  %86 = icmp eq i64 %85, 20
  br i1 %86, label %87, label %76, !llvm.loop !10

87:                                               ; preds = %76
  %88 = add nuw nsw i64 %13, 1
  %89 = icmp eq i64 %88, 20
  br i1 %89, label %90, label %12, !llvm.loop !13

90:                                               ; preds = %87
  %91 = add nuw nsw i64 %10, 1
  %92 = icmp eq i64 %91, 20
  br i1 %92, label %93, label %9, !llvm.loop !14

93:                                               ; preds = %90
  tail call void @polybench_timer_start() #7
  %94 = getelementptr i8, ptr %5, i64 3368
  %95 = getelementptr i8, ptr %5, i64 6232
  %96 = getelementptr i8, ptr %3, i64 168
  %97 = getelementptr i8, ptr %3, i64 9432
  %98 = getelementptr i8, ptr %3, i64 3368
  %99 = getelementptr i8, ptr %3, i64 6232
  %100 = getelementptr i8, ptr %5, i64 168
  %101 = getelementptr i8, ptr %5, i64 9432
  br label %102

102:                                              ; preds = %274, %93
  %103 = phi i32 [ 1, %93 ], [ %275, %274 ]
  br label %104

104:                                              ; preds = %185, %102
  %105 = phi i64 [ %188, %185 ], [ 0, %102 ]
  %106 = phi i64 [ %186, %185 ], [ 1, %102 ]
  %107 = mul nuw nsw i64 %105, 3200
  %108 = getelementptr i8, ptr %94, i64 %107
  %109 = getelementptr i8, ptr %95, i64 %107
  %110 = getelementptr i8, ptr %96, i64 %107
  %111 = getelementptr i8, ptr %97, i64 %107
  %112 = getelementptr inbounds nuw [20 x [20 x double]], ptr %3, i64 %106
  %113 = getelementptr inbounds nuw i8, ptr %112, i64 3200
  %114 = getelementptr i8, ptr %112, i64 -3200
  %115 = icmp ult ptr %108, %111
  %116 = icmp ult ptr %110, %109
  %117 = and i1 %115, %116
  br label %118

118:                                              ; preds = %183, %104
  %119 = phi i64 [ 1, %104 ], [ %120, %183 ]
  %120 = add nuw nsw i64 %119, 1
  %121 = add nsw i64 %119, -1
  br i1 %117, label %153, label %122

122:                                              ; preds = %118, %122
  %123 = phi i64 [ %151, %122 ], [ 0, %118 ]
  %124 = or disjoint i64 %123, 1
  %125 = getelementptr inbounds nuw [20 x [20 x double]], ptr %113, i64 0, i64 %119, i64 %124
  %126 = load <2 x double>, ptr %125, align 8, !tbaa !6, !alias.scope !15
  %127 = getelementptr inbounds nuw [20 x [20 x double]], ptr %3, i64 %106, i64 %119, i64 %124
  %128 = load <2 x double>, ptr %127, align 8, !tbaa !6, !alias.scope !15
  %129 = tail call <2 x double> @llvm.fmuladd.v2f64(<2 x double> %128, <2 x double> splat (double -2.000000e+00), <2 x double> %126)
  %130 = getelementptr inbounds nuw [20 x [20 x double]], ptr %114, i64 0, i64 %119, i64 %124
  %131 = load <2 x double>, ptr %130, align 8, !tbaa !6, !alias.scope !15
  %132 = fadd <2 x double> %129, %131
  %133 = getelementptr inbounds nuw [20 x [20 x double]], ptr %3, i64 %106, i64 %120, i64 %124
  %134 = load <2 x double>, ptr %133, align 8, !tbaa !6, !alias.scope !15
  %135 = tail call <2 x double> @llvm.fmuladd.v2f64(<2 x double> %128, <2 x double> splat (double -2.000000e+00), <2 x double> %134)
  %136 = getelementptr inbounds [20 x [20 x double]], ptr %3, i64 %106, i64 %121, i64 %124
  %137 = load <2 x double>, ptr %136, align 8, !tbaa !6, !alias.scope !15
  %138 = fadd <2 x double> %135, %137
  %139 = fmul <2 x double> %138, splat (double 1.250000e-01)
  %140 = tail call <2 x double> @llvm.fmuladd.v2f64(<2 x double> %132, <2 x double> splat (double 1.250000e-01), <2 x double> %139)
  %141 = add nuw nsw i64 %123, 2
  %142 = getelementptr inbounds nuw [20 x [20 x double]], ptr %3, i64 %106, i64 %119, i64 %141
  %143 = load <2 x double>, ptr %142, align 8, !tbaa !6, !alias.scope !15
  %144 = tail call <2 x double> @llvm.fmuladd.v2f64(<2 x double> %128, <2 x double> splat (double -2.000000e+00), <2 x double> %143)
  %145 = getelementptr inbounds [20 x [20 x double]], ptr %3, i64 %106, i64 %119, i64 %123
  %146 = load <2 x double>, ptr %145, align 8, !tbaa !6, !alias.scope !15
  %147 = fadd <2 x double> %144, %146
  %148 = tail call <2 x double> @llvm.fmuladd.v2f64(<2 x double> %147, <2 x double> splat (double 1.250000e-01), <2 x double> %140)
  %149 = fadd <2 x double> %128, %148
  %150 = getelementptr inbounds nuw [20 x [20 x double]], ptr %5, i64 %106, i64 %119, i64 %124
  store <2 x double> %149, ptr %150, align 8, !tbaa !6, !alias.scope !18, !noalias !15
  %151 = add nuw i64 %123, 2
  %152 = icmp eq i64 %151, 18
  br i1 %152, label %183, label %122, !llvm.loop !20

153:                                              ; preds = %118, %153
  %154 = phi i64 [ %171, %153 ], [ 1, %118 ]
  %155 = getelementptr inbounds nuw [20 x [20 x double]], ptr %113, i64 0, i64 %119, i64 %154
  %156 = load double, ptr %155, align 8, !tbaa !6
  %157 = getelementptr inbounds nuw [20 x [20 x double]], ptr %3, i64 %106, i64 %119, i64 %154
  %158 = load double, ptr %157, align 8, !tbaa !6
  %159 = tail call double @llvm.fmuladd.f64(double %158, double -2.000000e+00, double %156)
  %160 = getelementptr inbounds nuw [20 x [20 x double]], ptr %114, i64 0, i64 %119, i64 %154
  %161 = load double, ptr %160, align 8, !tbaa !6
  %162 = fadd double %159, %161
  %163 = getelementptr inbounds nuw [20 x [20 x double]], ptr %3, i64 %106, i64 %120, i64 %154
  %164 = load double, ptr %163, align 8, !tbaa !6
  %165 = tail call double @llvm.fmuladd.f64(double %158, double -2.000000e+00, double %164)
  %166 = getelementptr inbounds [20 x [20 x double]], ptr %3, i64 %106, i64 %121, i64 %154
  %167 = load double, ptr %166, align 8, !tbaa !6
  %168 = fadd double %165, %167
  %169 = fmul double %168, 1.250000e-01
  %170 = tail call double @llvm.fmuladd.f64(double %162, double 1.250000e-01, double %169)
  %171 = add nuw nsw i64 %154, 1
  %172 = getelementptr inbounds nuw [20 x [20 x double]], ptr %3, i64 %106, i64 %119, i64 %171
  %173 = load double, ptr %172, align 8, !tbaa !6
  %174 = tail call double @llvm.fmuladd.f64(double %158, double -2.000000e+00, double %173)
  %175 = add nsw i64 %154, -1
  %176 = getelementptr inbounds [20 x [20 x double]], ptr %3, i64 %106, i64 %119, i64 %175
  %177 = load double, ptr %176, align 8, !tbaa !6
  %178 = fadd double %174, %177
  %179 = tail call double @llvm.fmuladd.f64(double %178, double 1.250000e-01, double %170)
  %180 = fadd double %158, %179
  %181 = getelementptr inbounds nuw [20 x [20 x double]], ptr %5, i64 %106, i64 %119, i64 %154
  store double %180, ptr %181, align 8, !tbaa !6
  %182 = icmp eq i64 %171, 19
  br i1 %182, label %183, label %153, !llvm.loop !22

183:                                              ; preds = %122, %153
  %184 = icmp eq i64 %120, 19
  br i1 %184, label %185, label %118, !llvm.loop !23

185:                                              ; preds = %183
  %186 = add nuw nsw i64 %106, 1
  %187 = icmp eq i64 %186, 19
  %188 = add i64 %105, 1
  br i1 %187, label %189, label %104, !llvm.loop !24

189:                                              ; preds = %185, %270
  %190 = phi i64 [ %273, %270 ], [ 0, %185 ]
  %191 = phi i64 [ %271, %270 ], [ 1, %185 ]
  %192 = mul nuw nsw i64 %190, 3200
  %193 = getelementptr i8, ptr %98, i64 %192
  %194 = getelementptr i8, ptr %99, i64 %192
  %195 = getelementptr i8, ptr %100, i64 %192
  %196 = getelementptr i8, ptr %101, i64 %192
  %197 = getelementptr inbounds nuw [20 x [20 x double]], ptr %5, i64 %191
  %198 = getelementptr inbounds nuw i8, ptr %197, i64 3200
  %199 = getelementptr i8, ptr %197, i64 -3200
  %200 = icmp ult ptr %193, %196
  %201 = icmp ult ptr %195, %194
  %202 = and i1 %200, %201
  br label %203

203:                                              ; preds = %268, %189
  %204 = phi i64 [ 1, %189 ], [ %205, %268 ]
  %205 = add nuw nsw i64 %204, 1
  %206 = add nsw i64 %204, -1
  br i1 %202, label %238, label %207

207:                                              ; preds = %203, %207
  %208 = phi i64 [ %236, %207 ], [ 0, %203 ]
  %209 = or disjoint i64 %208, 1
  %210 = getelementptr inbounds nuw [20 x [20 x double]], ptr %198, i64 0, i64 %204, i64 %209
  %211 = load <2 x double>, ptr %210, align 8, !tbaa !6, !alias.scope !25
  %212 = getelementptr inbounds nuw [20 x [20 x double]], ptr %5, i64 %191, i64 %204, i64 %209
  %213 = load <2 x double>, ptr %212, align 8, !tbaa !6, !alias.scope !25
  %214 = tail call <2 x double> @llvm.fmuladd.v2f64(<2 x double> %213, <2 x double> splat (double -2.000000e+00), <2 x double> %211)
  %215 = getelementptr inbounds nuw [20 x [20 x double]], ptr %199, i64 0, i64 %204, i64 %209
  %216 = load <2 x double>, ptr %215, align 8, !tbaa !6, !alias.scope !25
  %217 = fadd <2 x double> %214, %216
  %218 = getelementptr inbounds nuw [20 x [20 x double]], ptr %5, i64 %191, i64 %205, i64 %209
  %219 = load <2 x double>, ptr %218, align 8, !tbaa !6, !alias.scope !25
  %220 = tail call <2 x double> @llvm.fmuladd.v2f64(<2 x double> %213, <2 x double> splat (double -2.000000e+00), <2 x double> %219)
  %221 = getelementptr inbounds [20 x [20 x double]], ptr %5, i64 %191, i64 %206, i64 %209
  %222 = load <2 x double>, ptr %221, align 8, !tbaa !6, !alias.scope !25
  %223 = fadd <2 x double> %220, %222
  %224 = fmul <2 x double> %223, splat (double 1.250000e-01)
  %225 = tail call <2 x double> @llvm.fmuladd.v2f64(<2 x double> %217, <2 x double> splat (double 1.250000e-01), <2 x double> %224)
  %226 = add nuw nsw i64 %208, 2
  %227 = getelementptr inbounds nuw [20 x [20 x double]], ptr %5, i64 %191, i64 %204, i64 %226
  %228 = load <2 x double>, ptr %227, align 8, !tbaa !6, !alias.scope !25
  %229 = tail call <2 x double> @llvm.fmuladd.v2f64(<2 x double> %213, <2 x double> splat (double -2.000000e+00), <2 x double> %228)
  %230 = getelementptr inbounds [20 x [20 x double]], ptr %5, i64 %191, i64 %204, i64 %208
  %231 = load <2 x double>, ptr %230, align 8, !tbaa !6, !alias.scope !25
  %232 = fadd <2 x double> %229, %231
  %233 = tail call <2 x double> @llvm.fmuladd.v2f64(<2 x double> %232, <2 x double> splat (double 1.250000e-01), <2 x double> %225)
  %234 = fadd <2 x double> %213, %233
  %235 = getelementptr inbounds nuw [20 x [20 x double]], ptr %3, i64 %191, i64 %204, i64 %209
  store <2 x double> %234, ptr %235, align 8, !tbaa !6, !alias.scope !28, !noalias !25
  %236 = add nuw i64 %208, 2
  %237 = icmp eq i64 %236, 18
  br i1 %237, label %268, label %207, !llvm.loop !30

238:                                              ; preds = %203, %238
  %239 = phi i64 [ %256, %238 ], [ 1, %203 ]
  %240 = getelementptr inbounds nuw [20 x [20 x double]], ptr %198, i64 0, i64 %204, i64 %239
  %241 = load double, ptr %240, align 8, !tbaa !6
  %242 = getelementptr inbounds nuw [20 x [20 x double]], ptr %5, i64 %191, i64 %204, i64 %239
  %243 = load double, ptr %242, align 8, !tbaa !6
  %244 = tail call double @llvm.fmuladd.f64(double %243, double -2.000000e+00, double %241)
  %245 = getelementptr inbounds nuw [20 x [20 x double]], ptr %199, i64 0, i64 %204, i64 %239
  %246 = load double, ptr %245, align 8, !tbaa !6
  %247 = fadd double %244, %246
  %248 = getelementptr inbounds nuw [20 x [20 x double]], ptr %5, i64 %191, i64 %205, i64 %239
  %249 = load double, ptr %248, align 8, !tbaa !6
  %250 = tail call double @llvm.fmuladd.f64(double %243, double -2.000000e+00, double %249)
  %251 = getelementptr inbounds [20 x [20 x double]], ptr %5, i64 %191, i64 %206, i64 %239
  %252 = load double, ptr %251, align 8, !tbaa !6
  %253 = fadd double %250, %252
  %254 = fmul double %253, 1.250000e-01
  %255 = tail call double @llvm.fmuladd.f64(double %247, double 1.250000e-01, double %254)
  %256 = add nuw nsw i64 %239, 1
  %257 = getelementptr inbounds nuw [20 x [20 x double]], ptr %5, i64 %191, i64 %204, i64 %256
  %258 = load double, ptr %257, align 8, !tbaa !6
  %259 = tail call double @llvm.fmuladd.f64(double %243, double -2.000000e+00, double %258)
  %260 = add nsw i64 %239, -1
  %261 = getelementptr inbounds [20 x [20 x double]], ptr %5, i64 %191, i64 %204, i64 %260
  %262 = load double, ptr %261, align 8, !tbaa !6
  %263 = fadd double %259, %262
  %264 = tail call double @llvm.fmuladd.f64(double %263, double 1.250000e-01, double %255)
  %265 = fadd double %243, %264
  %266 = getelementptr inbounds nuw [20 x [20 x double]], ptr %3, i64 %191, i64 %204, i64 %239
  store double %265, ptr %266, align 8, !tbaa !6
  %267 = icmp eq i64 %256, 19
  br i1 %267, label %268, label %238, !llvm.loop !31

268:                                              ; preds = %207, %238
  %269 = icmp eq i64 %205, 19
  br i1 %269, label %270, label %203, !llvm.loop !32

270:                                              ; preds = %268
  %271 = add nuw nsw i64 %191, 1
  %272 = icmp eq i64 %271, 19
  %273 = add i64 %190, 1
  br i1 %272, label %274, label %189, !llvm.loop !33

274:                                              ; preds = %270
  %275 = add nuw nsw i32 %103, 1
  %276 = icmp eq i32 %275, 41
  br i1 %276, label %277, label %102, !llvm.loop !34

277:                                              ; preds = %274
  tail call void @polybench_timer_stop() #7
  tail call void @polybench_timer_print() #7
  %278 = icmp sgt i32 %0, 42
  br i1 %278, label %279, label %322

279:                                              ; preds = %277
  %280 = load ptr, ptr %1, align 8, !tbaa !35
  %281 = load i8, ptr %280, align 1
  %282 = icmp eq i8 %281, 0
  br i1 %282, label %283, label %322

283:                                              ; preds = %279
  %284 = load ptr, ptr @__stderrp, align 8, !tbaa !38
  %285 = tail call i64 @fwrite(ptr nonnull @.str.1, i64 22, i64 1, ptr %284)
  %286 = load ptr, ptr @__stderrp, align 8, !tbaa !38
  %287 = tail call i32 (ptr, ptr, ...) @fprintf(ptr noundef %286, ptr noundef nonnull @.str.2, ptr noundef nonnull @.str.3) #7
  br label %288

288:                                              ; preds = %314, %283
  %289 = phi i64 [ 0, %283 ], [ %315, %314 ]
  %290 = mul nuw nsw i64 %289, 400
  br label %291

291:                                              ; preds = %311, %288
  %292 = phi i64 [ 0, %288 ], [ %312, %311 ]
  %293 = mul nuw nsw i64 %292, 20
  %294 = add nuw nsw i64 %293, %290
  br label %295

295:                                              ; preds = %304, %291
  %296 = phi i64 [ 0, %291 ], [ %309, %304 ]
  %297 = add nuw nsw i64 %294, %296
  %298 = trunc nuw nsw i64 %297 to i32
  %299 = urem i32 %298, 20
  %300 = icmp eq i32 %299, 0
  br i1 %300, label %301, label %304

301:                                              ; preds = %295
  %302 = load ptr, ptr @__stderrp, align 8, !tbaa !38
  %303 = tail call i32 @fputc(i32 10, ptr %302)
  br label %304

304:                                              ; preds = %301, %295
  %305 = load ptr, ptr @__stderrp, align 8, !tbaa !38
  %306 = getelementptr inbounds nuw [20 x [20 x double]], ptr %3, i64 %289, i64 %292, i64 %296
  %307 = load double, ptr %306, align 8, !tbaa !6
  %308 = tail call i32 (ptr, ptr, ...) @fprintf(ptr noundef %305, ptr noundef nonnull @.str.5, double noundef %307) #7
  %309 = add nuw nsw i64 %296, 1
  %310 = icmp eq i64 %309, 20
  br i1 %310, label %311, label %295, !llvm.loop !40

311:                                              ; preds = %304
  %312 = add nuw nsw i64 %292, 1
  %313 = icmp eq i64 %312, 20
  br i1 %313, label %314, label %291, !llvm.loop !41

314:                                              ; preds = %311
  %315 = add nuw nsw i64 %289, 1
  %316 = icmp eq i64 %315, 20
  br i1 %316, label %317, label %288, !llvm.loop !42

317:                                              ; preds = %314
  %318 = load ptr, ptr @__stderrp, align 8, !tbaa !38
  %319 = tail call i32 (ptr, ptr, ...) @fprintf(ptr noundef %318, ptr noundef nonnull @.str.6, ptr noundef nonnull @.str.3) #7
  %320 = load ptr, ptr @__stderrp, align 8, !tbaa !38
  %321 = tail call i64 @fwrite(ptr nonnull @.str.7, i64 22, i64 1, ptr %320)
  br label %322

322:                                              ; preds = %317, %279, %277
  tail call void @free(ptr noundef nonnull %3)
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
!10 = distinct !{!10, !11, !12}
!11 = !{!"llvm.loop.mustprogress"}
!12 = !{!"llvm.loop.isvectorized", i32 1}
!13 = distinct !{!13, !11}
!14 = distinct !{!14, !11}
!15 = !{!16}
!16 = distinct !{!16, !17}
!17 = distinct !{!17, !"LVerDomain"}
!18 = !{!19}
!19 = distinct !{!19, !17}
!20 = distinct !{!20, !11, !12, !21}
!21 = !{!"llvm.loop.unroll.runtime.disable"}
!22 = distinct !{!22, !11, !12}
!23 = distinct !{!23, !11}
!24 = distinct !{!24, !11}
!25 = !{!26}
!26 = distinct !{!26, !27}
!27 = distinct !{!27, !"LVerDomain"}
!28 = !{!29}
!29 = distinct !{!29, !27}
!30 = distinct !{!30, !11, !12, !21}
!31 = distinct !{!31, !11, !12}
!32 = distinct !{!32, !11}
!33 = distinct !{!33, !11}
!34 = distinct !{!34, !11}
!35 = !{!36, !36, i64 0}
!36 = !{!"p1 omnipotent char", !37, i64 0}
!37 = !{!"any pointer", !8, i64 0}
!38 = !{!39, !39, i64 0}
!39 = !{!"p1 _ZTS7__sFILE", !37, i64 0}
!40 = distinct !{!40, !11}
!41 = distinct !{!41, !11}
!42 = distinct !{!42, !11}
