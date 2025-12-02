; ModuleID = 'polybench_output/jacobi-2d.ll'
source_filename = "./polybench/stencils/jacobi-2d/jacobi-2d.c"
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
  %3 = tail call ptr @polybench_alloc_data(i64 noundef 8100, i32 noundef 8) #6
  %4 = ptrtoint ptr %3 to i64
  %5 = tail call ptr @polybench_alloc_data(i64 noundef 8100, i32 noundef 8) #6
  %6 = ptrtoint ptr %5 to i64
  %7 = sub i64 %6, %4
  %8 = icmp ult i64 %7, 64
  br label %9

9:                                                ; preds = %79, %2
  %10 = phi i64 [ 0, %2 ], [ %80, %79 ]
  %11 = trunc nuw nsw i64 %10 to i32
  %12 = uitofp nneg i32 %11 to double
  br i1 %8, label %62, label %13

13:                                               ; preds = %9
  %14 = insertelement <2 x double> poison, double %12, i64 0
  %15 = shufflevector <2 x double> %14, <2 x double> poison, <2 x i32> zeroinitializer
  br label %16

16:                                               ; preds = %16, %13
  %17 = phi i64 [ 0, %13 ], [ %59, %16 ]
  %18 = phi <2 x i32> [ <i32 0, i32 1>, %13 ], [ %60, %16 ]
  %19 = add <2 x i32> %18, splat (i32 2)
  %20 = add <2 x i32> %18, splat (i32 4)
  %21 = add <2 x i32> %18, splat (i32 6)
  %22 = add <2 x i32> %18, splat (i32 8)
  %23 = uitofp nneg <2 x i32> %19 to <2 x double>
  %24 = uitofp nneg <2 x i32> %20 to <2 x double>
  %25 = uitofp nneg <2 x i32> %21 to <2 x double>
  %26 = uitofp nneg <2 x i32> %22 to <2 x double>
  %27 = tail call <2 x double> @llvm.fmuladd.v2f64(<2 x double> %15, <2 x double> %23, <2 x double> splat (double 2.000000e+00))
  %28 = tail call <2 x double> @llvm.fmuladd.v2f64(<2 x double> %15, <2 x double> %24, <2 x double> splat (double 2.000000e+00))
  %29 = tail call <2 x double> @llvm.fmuladd.v2f64(<2 x double> %15, <2 x double> %25, <2 x double> splat (double 2.000000e+00))
  %30 = tail call <2 x double> @llvm.fmuladd.v2f64(<2 x double> %15, <2 x double> %26, <2 x double> splat (double 2.000000e+00))
  %31 = fdiv <2 x double> %27, splat (double 9.000000e+01)
  %32 = fdiv <2 x double> %28, splat (double 9.000000e+01)
  %33 = fdiv <2 x double> %29, splat (double 9.000000e+01)
  %34 = fdiv <2 x double> %30, splat (double 9.000000e+01)
  %35 = getelementptr inbounds nuw [90 x double], ptr %3, i64 %10, i64 %17
  %36 = getelementptr inbounds nuw i8, ptr %35, i64 16
  %37 = getelementptr inbounds nuw i8, ptr %35, i64 32
  %38 = getelementptr inbounds nuw i8, ptr %35, i64 48
  store <2 x double> %31, ptr %35, align 8, !tbaa !6
  store <2 x double> %32, ptr %36, align 8, !tbaa !6
  store <2 x double> %33, ptr %37, align 8, !tbaa !6
  store <2 x double> %34, ptr %38, align 8, !tbaa !6
  %39 = add <2 x i32> %18, splat (i32 3)
  %40 = add <2 x i32> %18, splat (i32 5)
  %41 = add <2 x i32> %18, splat (i32 7)
  %42 = add <2 x i32> %18, splat (i32 9)
  %43 = uitofp nneg <2 x i32> %39 to <2 x double>
  %44 = uitofp nneg <2 x i32> %40 to <2 x double>
  %45 = uitofp nneg <2 x i32> %41 to <2 x double>
  %46 = uitofp nneg <2 x i32> %42 to <2 x double>
  %47 = tail call <2 x double> @llvm.fmuladd.v2f64(<2 x double> %15, <2 x double> %43, <2 x double> splat (double 3.000000e+00))
  %48 = tail call <2 x double> @llvm.fmuladd.v2f64(<2 x double> %15, <2 x double> %44, <2 x double> splat (double 3.000000e+00))
  %49 = tail call <2 x double> @llvm.fmuladd.v2f64(<2 x double> %15, <2 x double> %45, <2 x double> splat (double 3.000000e+00))
  %50 = tail call <2 x double> @llvm.fmuladd.v2f64(<2 x double> %15, <2 x double> %46, <2 x double> splat (double 3.000000e+00))
  %51 = fdiv <2 x double> %47, splat (double 9.000000e+01)
  %52 = fdiv <2 x double> %48, splat (double 9.000000e+01)
  %53 = fdiv <2 x double> %49, splat (double 9.000000e+01)
  %54 = fdiv <2 x double> %50, splat (double 9.000000e+01)
  %55 = getelementptr inbounds nuw [90 x double], ptr %5, i64 %10, i64 %17
  %56 = getelementptr inbounds nuw i8, ptr %55, i64 16
  %57 = getelementptr inbounds nuw i8, ptr %55, i64 32
  %58 = getelementptr inbounds nuw i8, ptr %55, i64 48
  store <2 x double> %51, ptr %55, align 8, !tbaa !6
  store <2 x double> %52, ptr %56, align 8, !tbaa !6
  store <2 x double> %53, ptr %57, align 8, !tbaa !6
  store <2 x double> %54, ptr %58, align 8, !tbaa !6
  %59 = add nuw i64 %17, 8
  %60 = add <2 x i32> %18, splat (i32 8)
  %61 = icmp eq i64 %59, 88
  br i1 %61, label %.loopexit8, label %16, !llvm.loop !10

.loopexit8:                                       ; preds = %16
  br label %62

62:                                               ; preds = %.loopexit8, %9
  %63 = phi i64 [ 0, %9 ], [ 88, %.loopexit8 ]
  br label %64

64:                                               ; preds = %64, %62
  %65 = phi i64 [ %77, %64 ], [ %63, %62 ]
  %66 = trunc i64 %65 to i32
  %67 = add i32 %66, 2
  %68 = uitofp nneg i32 %67 to double
  %69 = tail call double @llvm.fmuladd.f64(double %12, double %68, double 2.000000e+00)
  %70 = fdiv double %69, 9.000000e+01
  %71 = getelementptr inbounds nuw [90 x double], ptr %3, i64 %10, i64 %65
  store double %70, ptr %71, align 8, !tbaa !6
  %72 = add i32 %66, 3
  %73 = uitofp nneg i32 %72 to double
  %74 = tail call double @llvm.fmuladd.f64(double %12, double %73, double 3.000000e+00)
  %75 = fdiv double %74, 9.000000e+01
  %76 = getelementptr inbounds nuw [90 x double], ptr %5, i64 %10, i64 %65
  store double %75, ptr %76, align 8, !tbaa !6
  %77 = add nuw nsw i64 %65, 1
  %78 = icmp eq i64 %77, 90
  br i1 %78, label %79, label %64, !llvm.loop !14

79:                                               ; preds = %64
  %80 = add nuw nsw i64 %10, 1
  %81 = icmp eq i64 %80, 90
  br i1 %81, label %82, label %9, !llvm.loop !15

82:                                               ; preds = %79
  tail call void @polybench_timer_start() #6
  %83 = getelementptr i8, ptr %3, i64 728
  %84 = getelementptr i8, ptr %3, i64 64072
  %85 = getelementptr i8, ptr %5, i64 8
  %86 = getelementptr i8, ptr %5, i64 64792
  %87 = getelementptr i8, ptr %5, i64 728
  %88 = getelementptr i8, ptr %5, i64 64072
  %89 = getelementptr i8, ptr %3, i64 8
  %90 = getelementptr i8, ptr %3, i64 64792
  %91 = icmp ult ptr %87, %90
  %92 = icmp ult ptr %89, %88
  %93 = and i1 %91, %92
  %94 = icmp ult ptr %83, %86
  %95 = icmp ult ptr %85, %84
  %96 = and i1 %94, %95
  br label %97

97:                                               ; preds = %297, %82
  %98 = phi i32 [ 0, %82 ], [ %298, %297 ]
  br label %99

99:                                               ; preds = %195, %97
  %100 = phi i64 [ 1, %97 ], [ %196, %195 ]
  %101 = getelementptr inbounds nuw [90 x double], ptr %3, i64 %100
  %102 = getelementptr inbounds nuw i8, ptr %101, i64 720
  %103 = getelementptr i8, ptr %101, i64 -720
  br i1 %93, label %.preheader3, label %.preheader5

.preheader5:                                      ; preds = %99
  br label %104

.preheader3:                                      ; preds = %99
  br label %174

104:                                              ; preds = %.preheader5, %104
  %105 = phi i64 [ %172, %104 ], [ 0, %.preheader5 ]
  %106 = or disjoint i64 %105, 1
  %107 = getelementptr inbounds nuw [90 x double], ptr %3, i64 %100, i64 %106
  %108 = getelementptr inbounds nuw i8, ptr %107, i64 16
  %109 = getelementptr inbounds nuw i8, ptr %107, i64 32
  %110 = getelementptr inbounds nuw i8, ptr %107, i64 48
  %111 = load <2 x double>, ptr %107, align 8, !tbaa !6, !alias.scope !16
  %112 = load <2 x double>, ptr %108, align 8, !tbaa !6, !alias.scope !16
  %113 = load <2 x double>, ptr %109, align 8, !tbaa !6, !alias.scope !16
  %114 = load <2 x double>, ptr %110, align 8, !tbaa !6, !alias.scope !16
  %115 = getelementptr inbounds [90 x double], ptr %3, i64 %100, i64 %105
  %116 = getelementptr inbounds nuw i8, ptr %115, i64 16
  %117 = getelementptr inbounds nuw i8, ptr %115, i64 32
  %118 = getelementptr inbounds nuw i8, ptr %115, i64 48
  %119 = load <2 x double>, ptr %115, align 8, !tbaa !6, !alias.scope !16
  %120 = load <2 x double>, ptr %116, align 8, !tbaa !6, !alias.scope !16
  %121 = load <2 x double>, ptr %117, align 8, !tbaa !6, !alias.scope !16
  %122 = load <2 x double>, ptr %118, align 8, !tbaa !6, !alias.scope !16
  %123 = fadd <2 x double> %111, %119
  %124 = fadd <2 x double> %112, %120
  %125 = fadd <2 x double> %113, %121
  %126 = fadd <2 x double> %114, %122
  %127 = or disjoint i64 %105, 2
  %128 = getelementptr inbounds nuw [90 x double], ptr %3, i64 %100, i64 %127
  %129 = getelementptr inbounds nuw i8, ptr %128, i64 16
  %130 = getelementptr inbounds nuw i8, ptr %128, i64 32
  %131 = getelementptr inbounds nuw i8, ptr %128, i64 48
  %132 = load <2 x double>, ptr %128, align 8, !tbaa !6, !alias.scope !16
  %133 = load <2 x double>, ptr %129, align 8, !tbaa !6, !alias.scope !16
  %134 = load <2 x double>, ptr %130, align 8, !tbaa !6, !alias.scope !16
  %135 = load <2 x double>, ptr %131, align 8, !tbaa !6, !alias.scope !16
  %136 = fadd <2 x double> %123, %132
  %137 = fadd <2 x double> %124, %133
  %138 = fadd <2 x double> %125, %134
  %139 = fadd <2 x double> %126, %135
  %140 = getelementptr inbounds nuw [90 x double], ptr %102, i64 0, i64 %106
  %141 = getelementptr inbounds nuw i8, ptr %140, i64 16
  %142 = getelementptr inbounds nuw i8, ptr %140, i64 32
  %143 = getelementptr inbounds nuw i8, ptr %140, i64 48
  %144 = load <2 x double>, ptr %140, align 8, !tbaa !6, !alias.scope !16
  %145 = load <2 x double>, ptr %141, align 8, !tbaa !6, !alias.scope !16
  %146 = load <2 x double>, ptr %142, align 8, !tbaa !6, !alias.scope !16
  %147 = load <2 x double>, ptr %143, align 8, !tbaa !6, !alias.scope !16
  %148 = fadd <2 x double> %136, %144
  %149 = fadd <2 x double> %137, %145
  %150 = fadd <2 x double> %138, %146
  %151 = fadd <2 x double> %139, %147
  %152 = getelementptr inbounds nuw [90 x double], ptr %103, i64 0, i64 %106
  %153 = getelementptr inbounds nuw i8, ptr %152, i64 16
  %154 = getelementptr inbounds nuw i8, ptr %152, i64 32
  %155 = getelementptr inbounds nuw i8, ptr %152, i64 48
  %156 = load <2 x double>, ptr %152, align 8, !tbaa !6, !alias.scope !16
  %157 = load <2 x double>, ptr %153, align 8, !tbaa !6, !alias.scope !16
  %158 = load <2 x double>, ptr %154, align 8, !tbaa !6, !alias.scope !16
  %159 = load <2 x double>, ptr %155, align 8, !tbaa !6, !alias.scope !16
  %160 = fadd <2 x double> %148, %156
  %161 = fadd <2 x double> %149, %157
  %162 = fadd <2 x double> %150, %158
  %163 = fadd <2 x double> %151, %159
  %164 = fmul <2 x double> %160, splat (double 2.000000e-01)
  %165 = fmul <2 x double> %161, splat (double 2.000000e-01)
  %166 = fmul <2 x double> %162, splat (double 2.000000e-01)
  %167 = fmul <2 x double> %163, splat (double 2.000000e-01)
  %168 = getelementptr inbounds nuw [90 x double], ptr %5, i64 %100, i64 %106
  %169 = getelementptr inbounds nuw i8, ptr %168, i64 16
  %170 = getelementptr inbounds nuw i8, ptr %168, i64 32
  %171 = getelementptr inbounds nuw i8, ptr %168, i64 48
  store <2 x double> %164, ptr %168, align 8, !tbaa !6, !alias.scope !19, !noalias !16
  store <2 x double> %165, ptr %169, align 8, !tbaa !6, !alias.scope !19, !noalias !16
  store <2 x double> %166, ptr %170, align 8, !tbaa !6, !alias.scope !19, !noalias !16
  store <2 x double> %167, ptr %171, align 8, !tbaa !6, !alias.scope !19, !noalias !16
  %172 = add nuw i64 %105, 8
  %173 = icmp eq i64 %172, 88
  br i1 %173, label %.loopexit6, label %104, !llvm.loop !21

174:                                              ; preds = %.preheader3, %174
  %175 = phi i64 [ %182, %174 ], [ 1, %.preheader3 ]
  %176 = getelementptr inbounds nuw [90 x double], ptr %3, i64 %100, i64 %175
  %177 = load double, ptr %176, align 8, !tbaa !6
  %178 = add nsw i64 %175, -1
  %179 = getelementptr inbounds [90 x double], ptr %3, i64 %100, i64 %178
  %180 = load double, ptr %179, align 8, !tbaa !6
  %181 = fadd double %177, %180
  %182 = add nuw nsw i64 %175, 1
  %183 = getelementptr inbounds nuw [90 x double], ptr %3, i64 %100, i64 %182
  %184 = load double, ptr %183, align 8, !tbaa !6
  %185 = fadd double %181, %184
  %186 = getelementptr inbounds nuw [90 x double], ptr %102, i64 0, i64 %175
  %187 = load double, ptr %186, align 8, !tbaa !6
  %188 = fadd double %185, %187
  %189 = getelementptr inbounds nuw [90 x double], ptr %103, i64 0, i64 %175
  %190 = load double, ptr %189, align 8, !tbaa !6
  %191 = fadd double %188, %190
  %192 = fmul double %191, 2.000000e-01
  %193 = getelementptr inbounds nuw [90 x double], ptr %5, i64 %100, i64 %175
  store double %192, ptr %193, align 8, !tbaa !6
  %194 = icmp eq i64 %182, 89
  br i1 %194, label %.loopexit4, label %174, !llvm.loop !22

.loopexit4:                                       ; preds = %174
  br label %195

.loopexit6:                                       ; preds = %104
  br label %195

195:                                              ; preds = %.loopexit6, %.loopexit4
  %196 = add nuw nsw i64 %100, 1
  %197 = icmp eq i64 %196, 89
  br i1 %197, label %.preheader7, label %99, !llvm.loop !23

.preheader7:                                      ; preds = %195
  br label %198

198:                                              ; preds = %.preheader7, %294
  %199 = phi i64 [ %295, %294 ], [ 1, %.preheader7 ]
  %200 = getelementptr inbounds nuw [90 x double], ptr %5, i64 %199
  %201 = getelementptr inbounds nuw i8, ptr %200, i64 720
  %202 = getelementptr i8, ptr %200, i64 -720
  br i1 %96, label %.preheader, label %.preheader1

.preheader1:                                      ; preds = %198
  br label %203

.preheader:                                       ; preds = %198
  br label %273

203:                                              ; preds = %.preheader1, %203
  %204 = phi i64 [ %271, %203 ], [ 0, %.preheader1 ]
  %205 = or disjoint i64 %204, 1
  %206 = getelementptr inbounds nuw [90 x double], ptr %5, i64 %199, i64 %205
  %207 = getelementptr inbounds nuw i8, ptr %206, i64 16
  %208 = getelementptr inbounds nuw i8, ptr %206, i64 32
  %209 = getelementptr inbounds nuw i8, ptr %206, i64 48
  %210 = load <2 x double>, ptr %206, align 8, !tbaa !6, !alias.scope !24
  %211 = load <2 x double>, ptr %207, align 8, !tbaa !6, !alias.scope !24
  %212 = load <2 x double>, ptr %208, align 8, !tbaa !6, !alias.scope !24
  %213 = load <2 x double>, ptr %209, align 8, !tbaa !6, !alias.scope !24
  %214 = getelementptr inbounds [90 x double], ptr %5, i64 %199, i64 %204
  %215 = getelementptr inbounds nuw i8, ptr %214, i64 16
  %216 = getelementptr inbounds nuw i8, ptr %214, i64 32
  %217 = getelementptr inbounds nuw i8, ptr %214, i64 48
  %218 = load <2 x double>, ptr %214, align 8, !tbaa !6, !alias.scope !24
  %219 = load <2 x double>, ptr %215, align 8, !tbaa !6, !alias.scope !24
  %220 = load <2 x double>, ptr %216, align 8, !tbaa !6, !alias.scope !24
  %221 = load <2 x double>, ptr %217, align 8, !tbaa !6, !alias.scope !24
  %222 = fadd <2 x double> %210, %218
  %223 = fadd <2 x double> %211, %219
  %224 = fadd <2 x double> %212, %220
  %225 = fadd <2 x double> %213, %221
  %226 = or disjoint i64 %204, 2
  %227 = getelementptr inbounds nuw [90 x double], ptr %5, i64 %199, i64 %226
  %228 = getelementptr inbounds nuw i8, ptr %227, i64 16
  %229 = getelementptr inbounds nuw i8, ptr %227, i64 32
  %230 = getelementptr inbounds nuw i8, ptr %227, i64 48
  %231 = load <2 x double>, ptr %227, align 8, !tbaa !6, !alias.scope !24
  %232 = load <2 x double>, ptr %228, align 8, !tbaa !6, !alias.scope !24
  %233 = load <2 x double>, ptr %229, align 8, !tbaa !6, !alias.scope !24
  %234 = load <2 x double>, ptr %230, align 8, !tbaa !6, !alias.scope !24
  %235 = fadd <2 x double> %222, %231
  %236 = fadd <2 x double> %223, %232
  %237 = fadd <2 x double> %224, %233
  %238 = fadd <2 x double> %225, %234
  %239 = getelementptr inbounds nuw [90 x double], ptr %201, i64 0, i64 %205
  %240 = getelementptr inbounds nuw i8, ptr %239, i64 16
  %241 = getelementptr inbounds nuw i8, ptr %239, i64 32
  %242 = getelementptr inbounds nuw i8, ptr %239, i64 48
  %243 = load <2 x double>, ptr %239, align 8, !tbaa !6, !alias.scope !24
  %244 = load <2 x double>, ptr %240, align 8, !tbaa !6, !alias.scope !24
  %245 = load <2 x double>, ptr %241, align 8, !tbaa !6, !alias.scope !24
  %246 = load <2 x double>, ptr %242, align 8, !tbaa !6, !alias.scope !24
  %247 = fadd <2 x double> %235, %243
  %248 = fadd <2 x double> %236, %244
  %249 = fadd <2 x double> %237, %245
  %250 = fadd <2 x double> %238, %246
  %251 = getelementptr inbounds nuw [90 x double], ptr %202, i64 0, i64 %205
  %252 = getelementptr inbounds nuw i8, ptr %251, i64 16
  %253 = getelementptr inbounds nuw i8, ptr %251, i64 32
  %254 = getelementptr inbounds nuw i8, ptr %251, i64 48
  %255 = load <2 x double>, ptr %251, align 8, !tbaa !6, !alias.scope !24
  %256 = load <2 x double>, ptr %252, align 8, !tbaa !6, !alias.scope !24
  %257 = load <2 x double>, ptr %253, align 8, !tbaa !6, !alias.scope !24
  %258 = load <2 x double>, ptr %254, align 8, !tbaa !6, !alias.scope !24
  %259 = fadd <2 x double> %247, %255
  %260 = fadd <2 x double> %248, %256
  %261 = fadd <2 x double> %249, %257
  %262 = fadd <2 x double> %250, %258
  %263 = fmul <2 x double> %259, splat (double 2.000000e-01)
  %264 = fmul <2 x double> %260, splat (double 2.000000e-01)
  %265 = fmul <2 x double> %261, splat (double 2.000000e-01)
  %266 = fmul <2 x double> %262, splat (double 2.000000e-01)
  %267 = getelementptr inbounds nuw [90 x double], ptr %3, i64 %199, i64 %205
  %268 = getelementptr inbounds nuw i8, ptr %267, i64 16
  %269 = getelementptr inbounds nuw i8, ptr %267, i64 32
  %270 = getelementptr inbounds nuw i8, ptr %267, i64 48
  store <2 x double> %263, ptr %267, align 8, !tbaa !6, !alias.scope !27, !noalias !24
  store <2 x double> %264, ptr %268, align 8, !tbaa !6, !alias.scope !27, !noalias !24
  store <2 x double> %265, ptr %269, align 8, !tbaa !6, !alias.scope !27, !noalias !24
  store <2 x double> %266, ptr %270, align 8, !tbaa !6, !alias.scope !27, !noalias !24
  %271 = add nuw i64 %204, 8
  %272 = icmp eq i64 %271, 88
  br i1 %272, label %.loopexit2, label %203, !llvm.loop !29

273:                                              ; preds = %.preheader, %273
  %274 = phi i64 [ %281, %273 ], [ 1, %.preheader ]
  %275 = getelementptr inbounds nuw [90 x double], ptr %5, i64 %199, i64 %274
  %276 = load double, ptr %275, align 8, !tbaa !6
  %277 = add nsw i64 %274, -1
  %278 = getelementptr inbounds [90 x double], ptr %5, i64 %199, i64 %277
  %279 = load double, ptr %278, align 8, !tbaa !6
  %280 = fadd double %276, %279
  %281 = add nuw nsw i64 %274, 1
  %282 = getelementptr inbounds nuw [90 x double], ptr %5, i64 %199, i64 %281
  %283 = load double, ptr %282, align 8, !tbaa !6
  %284 = fadd double %280, %283
  %285 = getelementptr inbounds nuw [90 x double], ptr %201, i64 0, i64 %274
  %286 = load double, ptr %285, align 8, !tbaa !6
  %287 = fadd double %284, %286
  %288 = getelementptr inbounds nuw [90 x double], ptr %202, i64 0, i64 %274
  %289 = load double, ptr %288, align 8, !tbaa !6
  %290 = fadd double %287, %289
  %291 = fmul double %290, 2.000000e-01
  %292 = getelementptr inbounds nuw [90 x double], ptr %3, i64 %199, i64 %274
  store double %291, ptr %292, align 8, !tbaa !6
  %293 = icmp eq i64 %281, 89
  br i1 %293, label %.loopexit, label %273, !llvm.loop !30

.loopexit:                                        ; preds = %273
  br label %294

.loopexit2:                                       ; preds = %203
  br label %294

294:                                              ; preds = %.loopexit2, %.loopexit
  %295 = add nuw nsw i64 %199, 1
  %296 = icmp eq i64 %295, 89
  br i1 %296, label %297, label %198, !llvm.loop !31

297:                                              ; preds = %294
  %298 = add nuw nsw i32 %98, 1
  %299 = icmp eq i32 %298, 40
  br i1 %299, label %300, label %97, !llvm.loop !32

300:                                              ; preds = %297
  tail call void @polybench_timer_stop() #6
  tail call void @polybench_timer_print() #6
  %301 = icmp sgt i32 %0, 42
  br i1 %301, label %302, label %338

302:                                              ; preds = %300
  %303 = load ptr, ptr %1, align 8, !tbaa !33
  %304 = load i8, ptr %303, align 1
  %305 = icmp eq i8 %304, 0
  br i1 %305, label %306, label %338

306:                                              ; preds = %302
  %307 = load ptr, ptr @__stderrp, align 8, !tbaa !36
  %308 = tail call i64 @fwrite(ptr nonnull @.str.1, i64 22, i64 1, ptr %307)
  %309 = load ptr, ptr @__stderrp, align 8, !tbaa !36
  %310 = tail call i32 (ptr, ptr, ...) @fprintf(ptr noundef %309, ptr noundef nonnull @.str.2, ptr noundef nonnull @.str.3) #6
  br label %311

311:                                              ; preds = %330, %306
  %312 = phi i64 [ 0, %306 ], [ %331, %330 ]
  %313 = mul nuw nsw i64 %312, 90
  br label %314

314:                                              ; preds = %323, %311
  %315 = phi i64 [ 0, %311 ], [ %328, %323 ]
  %316 = add nuw nsw i64 %315, %313
  %317 = trunc nuw nsw i64 %316 to i32
  %318 = urem i32 %317, 20
  %319 = icmp eq i32 %318, 0
  br i1 %319, label %320, label %323

320:                                              ; preds = %314
  %321 = load ptr, ptr @__stderrp, align 8, !tbaa !36
  %322 = tail call i32 @fputc(i32 10, ptr %321)
  br label %323

323:                                              ; preds = %320, %314
  %324 = load ptr, ptr @__stderrp, align 8, !tbaa !36
  %325 = getelementptr inbounds nuw [90 x double], ptr %3, i64 %312, i64 %315
  %326 = load double, ptr %325, align 8, !tbaa !6
  %327 = tail call i32 (ptr, ptr, ...) @fprintf(ptr noundef %324, ptr noundef nonnull @.str.5, double noundef %326) #6
  %328 = add nuw nsw i64 %315, 1
  %329 = icmp eq i64 %328, 90
  br i1 %329, label %330, label %314, !llvm.loop !38

330:                                              ; preds = %323
  %331 = add nuw nsw i64 %312, 1
  %332 = icmp eq i64 %331, 90
  br i1 %332, label %333, label %311, !llvm.loop !39

333:                                              ; preds = %330
  %334 = load ptr, ptr @__stderrp, align 8, !tbaa !36
  %335 = tail call i32 (ptr, ptr, ...) @fprintf(ptr noundef %334, ptr noundef nonnull @.str.6, ptr noundef nonnull @.str.3) #6
  %336 = load ptr, ptr @__stderrp, align 8, !tbaa !36
  %337 = tail call i64 @fwrite(ptr nonnull @.str.7, i64 22, i64 1, ptr %336)
  br label %338

338:                                              ; preds = %333, %302, %300
  tail call void @free(ptr noundef nonnull %3)
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
!14 = distinct !{!14, !11, !12}
!15 = distinct !{!15, !11}
!16 = !{!17}
!17 = distinct !{!17, !18}
!18 = distinct !{!18, !"LVerDomain"}
!19 = !{!20}
!20 = distinct !{!20, !18}
!21 = distinct !{!21, !11, !12, !13}
!22 = distinct !{!22, !11, !12}
!23 = distinct !{!23, !11}
!24 = !{!25}
!25 = distinct !{!25, !26}
!26 = distinct !{!26, !"LVerDomain"}
!27 = !{!28}
!28 = distinct !{!28, !26}
!29 = distinct !{!29, !11, !12, !13}
!30 = distinct !{!30, !11, !12}
!31 = distinct !{!31, !11}
!32 = distinct !{!32, !11}
!33 = !{!34, !34, i64 0}
!34 = !{!"p1 omnipotent char", !35, i64 0}
!35 = !{!"any pointer", !8, i64 0}
!36 = !{!37, !37, i64 0}
!37 = !{!"p1 _ZTS7__sFILE", !35, i64 0}
!38 = distinct !{!38, !11}
!39 = distinct !{!39, !11}
