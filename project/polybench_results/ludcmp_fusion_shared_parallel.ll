; ModuleID = 'polybench_results/ludcmp.ll'
source_filename = "./polybench/linear-algebra/solvers/ludcmp/ludcmp.c"
target datalayout = "e-m:o-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-n32:64-S128-Fn32"
target triple = "arm64-apple-macosx15.0.0"

@__stderrp = external local_unnamed_addr global ptr, align 8
@.str.1 = private unnamed_addr constant [23 x i8] c"==BEGIN DUMP_ARRAYS==\0A\00", align 1
@.str.2 = private unnamed_addr constant [15 x i8] c"begin dump: %s\00", align 1
@.str.3 = private unnamed_addr constant [2 x i8] c"x\00", align 1
@.str.5 = private unnamed_addr constant [8 x i8] c"%0.2lf \00", align 1
@.str.6 = private unnamed_addr constant [17 x i8] c"\0Aend   dump: %s\0A\00", align 1
@.str.7 = private unnamed_addr constant [23 x i8] c"==END   DUMP_ARRAYS==\0A\00", align 1

; Function Attrs: nounwind ssp uwtable(sync)
define noundef i32 @main(i32 noundef %0, ptr noundef readonly captures(none) %1) local_unnamed_addr #0 {
  %3 = tail call ptr @polybench_alloc_data(i64 noundef 14400, i32 noundef 8) #7
  %4 = ptrtoint ptr %3 to i64
  %5 = tail call ptr @polybench_alloc_data(i64 noundef 120, i32 noundef 8) #7
  %6 = tail call ptr @polybench_alloc_data(i64 noundef 120, i32 noundef 8) #7
  %7 = tail call ptr @polybench_alloc_data(i64 noundef 120, i32 noundef 8) #7
  %8 = ptrtoint ptr %7 to i64
  %9 = ptrtoint ptr %6 to i64
  %10 = ptrtoint ptr %5 to i64
  %11 = sub i64 %8, %9
  %12 = icmp ult i64 %11, 64
  %13 = sub i64 %10, %9
  %14 = icmp ult i64 %13, 64
  %15 = or i1 %12, %14
  %16 = sub i64 %10, %8
  %17 = icmp ult i64 %16, 64
  %18 = or i1 %15, %17
  br i1 %18, label %.preheader14, label %.preheader16

.preheader16:                                     ; preds = %2
  br label %19

.preheader14:                                     ; preds = %2
  br label %61

19:                                               ; preds = %.preheader16, %19
  %20 = phi i64 [ %58, %19 ], [ 0, %.preheader16 ]
  %21 = phi <2 x i64> [ %59, %19 ], [ <i64 0, i64 1>, %.preheader16 ]
  %22 = getelementptr inbounds nuw double, ptr %6, i64 %20
  %23 = getelementptr inbounds nuw i8, ptr %22, i64 16
  %24 = getelementptr inbounds nuw i8, ptr %22, i64 32
  %25 = getelementptr inbounds nuw i8, ptr %22, i64 48
  store <2 x double> zeroinitializer, ptr %22, align 8, !tbaa !6
  store <2 x double> zeroinitializer, ptr %23, align 8, !tbaa !6
  store <2 x double> zeroinitializer, ptr %24, align 8, !tbaa !6
  store <2 x double> zeroinitializer, ptr %25, align 8, !tbaa !6
  %26 = getelementptr inbounds nuw double, ptr %7, i64 %20
  %27 = getelementptr inbounds nuw i8, ptr %26, i64 16
  %28 = getelementptr inbounds nuw i8, ptr %26, i64 32
  %29 = getelementptr inbounds nuw i8, ptr %26, i64 48
  store <2 x double> zeroinitializer, ptr %26, align 8, !tbaa !6
  store <2 x double> zeroinitializer, ptr %27, align 8, !tbaa !6
  store <2 x double> zeroinitializer, ptr %28, align 8, !tbaa !6
  store <2 x double> zeroinitializer, ptr %29, align 8, !tbaa !6
  %30 = trunc <2 x i64> %21 to <2 x i32>
  %31 = add <2 x i32> %30, splat (i32 1)
  %32 = trunc <2 x i64> %21 to <2 x i32>
  %33 = add <2 x i32> %32, splat (i32 3)
  %34 = trunc <2 x i64> %21 to <2 x i32>
  %35 = add <2 x i32> %34, splat (i32 5)
  %36 = trunc <2 x i64> %21 to <2 x i32>
  %37 = add <2 x i32> %36, splat (i32 7)
  %38 = uitofp nneg <2 x i32> %31 to <2 x double>
  %39 = uitofp nneg <2 x i32> %33 to <2 x double>
  %40 = uitofp nneg <2 x i32> %35 to <2 x double>
  %41 = uitofp nneg <2 x i32> %37 to <2 x double>
  %42 = fdiv <2 x double> %38, splat (double 1.200000e+02)
  %43 = fdiv <2 x double> %39, splat (double 1.200000e+02)
  %44 = fdiv <2 x double> %40, splat (double 1.200000e+02)
  %45 = fdiv <2 x double> %41, splat (double 1.200000e+02)
  %46 = fmul <2 x double> %42, splat (double 5.000000e-01)
  %47 = fmul <2 x double> %43, splat (double 5.000000e-01)
  %48 = fmul <2 x double> %44, splat (double 5.000000e-01)
  %49 = fmul <2 x double> %45, splat (double 5.000000e-01)
  %50 = fadd <2 x double> %46, splat (double 4.000000e+00)
  %51 = fadd <2 x double> %47, splat (double 4.000000e+00)
  %52 = fadd <2 x double> %48, splat (double 4.000000e+00)
  %53 = fadd <2 x double> %49, splat (double 4.000000e+00)
  %54 = getelementptr inbounds nuw double, ptr %5, i64 %20
  %55 = getelementptr inbounds nuw i8, ptr %54, i64 16
  %56 = getelementptr inbounds nuw i8, ptr %54, i64 32
  %57 = getelementptr inbounds nuw i8, ptr %54, i64 48
  store <2 x double> %50, ptr %54, align 8, !tbaa !6
  store <2 x double> %51, ptr %55, align 8, !tbaa !6
  store <2 x double> %52, ptr %56, align 8, !tbaa !6
  store <2 x double> %53, ptr %57, align 8, !tbaa !6
  %58 = add nuw i64 %20, 8
  %59 = add <2 x i64> %21, splat (i64 8)
  %60 = icmp eq i64 %58, 120
  br i1 %60, label %.loopexit17, label %19, !llvm.loop !10

61:                                               ; preds = %.preheader14, %61
  %62 = phi i64 [ %65, %61 ], [ 0, %.preheader14 ]
  %63 = getelementptr inbounds nuw double, ptr %6, i64 %62
  store double 0.000000e+00, ptr %63, align 8, !tbaa !6
  %64 = getelementptr inbounds nuw double, ptr %7, i64 %62
  store double 0.000000e+00, ptr %64, align 8, !tbaa !6
  %65 = add nuw nsw i64 %62, 1
  %66 = trunc nuw nsw i64 %65 to i32
  %67 = uitofp nneg i32 %66 to double
  %68 = fdiv double %67, 1.200000e+02
  %69 = fmul double %68, 5.000000e-01
  %70 = fadd double %69, 4.000000e+00
  %71 = getelementptr inbounds nuw double, ptr %5, i64 %62
  store double %70, ptr %71, align 8, !tbaa !6
  %72 = icmp eq i64 %65, 120
  br i1 %72, label %.loopexit15, label %61, !llvm.loop !14

.loopexit15:                                      ; preds = %61
  br label %73

.loopexit17:                                      ; preds = %19
  br label %73

73:                                               ; preds = %.loopexit17, %.loopexit15
  %74 = getelementptr i8, ptr %3, i64 8
  br label %75

75:                                               ; preds = %129, %73
  %76 = phi i64 [ 1, %73 ], [ %131, %129 ]
  %77 = phi i64 [ 0, %73 ], [ %122, %129 ]
  %78 = icmp samesign ult i64 %76, 8
  br i1 %78, label %109, label %79

79:                                               ; preds = %75
  %80 = and i64 %76, 9223372036854775800
  br label %81

81:                                               ; preds = %81, %79
  %82 = phi i64 [ 0, %79 ], [ %104, %81 ]
  %83 = phi <2 x i32> [ <i32 0, i32 1>, %79 ], [ %105, %81 ]
  %84 = sub <2 x i32> zeroinitializer, %83
  %85 = sub <2 x i32> splat (i32 -2), %83
  %86 = sub <2 x i32> splat (i32 -4), %83
  %87 = sub <2 x i32> splat (i32 -6), %83
  %88 = sitofp <2 x i32> %84 to <2 x double>
  %89 = sitofp <2 x i32> %85 to <2 x double>
  %90 = sitofp <2 x i32> %86 to <2 x double>
  %91 = sitofp <2 x i32> %87 to <2 x double>
  %92 = fdiv <2 x double> %88, splat (double 1.200000e+02)
  %93 = fdiv <2 x double> %89, splat (double 1.200000e+02)
  %94 = fdiv <2 x double> %90, splat (double 1.200000e+02)
  %95 = fdiv <2 x double> %91, splat (double 1.200000e+02)
  %96 = fadd <2 x double> %92, splat (double 1.000000e+00)
  %97 = fadd <2 x double> %93, splat (double 1.000000e+00)
  %98 = fadd <2 x double> %94, splat (double 1.000000e+00)
  %99 = fadd <2 x double> %95, splat (double 1.000000e+00)
  %100 = getelementptr inbounds nuw [120 x double], ptr %3, i64 %77, i64 %82
  %101 = getelementptr inbounds nuw i8, ptr %100, i64 16
  %102 = getelementptr inbounds nuw i8, ptr %100, i64 32
  %103 = getelementptr inbounds nuw i8, ptr %100, i64 48
  store <2 x double> %96, ptr %100, align 8, !tbaa !6
  store <2 x double> %97, ptr %101, align 8, !tbaa !6
  store <2 x double> %98, ptr %102, align 8, !tbaa !6
  store <2 x double> %99, ptr %103, align 8, !tbaa !6
  %104 = add nuw i64 %82, 8
  %105 = add <2 x i32> %83, splat (i32 8)
  %106 = icmp eq i64 %104, %80
  br i1 %106, label %107, label %81, !llvm.loop !15

107:                                              ; preds = %81
  %108 = icmp eq i64 %76, %80
  br i1 %108, label %121, label %109

109:                                              ; preds = %107, %75
  %110 = phi i64 [ 0, %75 ], [ %80, %107 ]
  br label %111

111:                                              ; preds = %111, %109
  %112 = phi i64 [ %119, %111 ], [ %110, %109 ]
  %113 = trunc i64 %112 to i32
  %114 = sub i32 0, %113
  %115 = sitofp i32 %114 to double
  %116 = fdiv double %115, 1.200000e+02
  %117 = fadd double %116, 1.000000e+00
  %118 = getelementptr inbounds nuw [120 x double], ptr %3, i64 %77, i64 %112
  store double %117, ptr %118, align 8, !tbaa !6
  %119 = add nuw nsw i64 %112, 1
  %120 = icmp eq i64 %119, %76
  br i1 %120, label %.loopexit13, label %111, !llvm.loop !16

.loopexit13:                                      ; preds = %111
  br label %121

121:                                              ; preds = %.loopexit13, %107
  %122 = add nuw nsw i64 %77, 1
  %123 = icmp samesign ult i64 %77, 119
  br i1 %123, label %124, label %129

124:                                              ; preds = %121
  %125 = shl nuw nsw i64 %77, 3
  %126 = sub nsw i64 952, %125
  %127 = mul nuw nsw i64 %77, 968
  %128 = getelementptr i8, ptr %74, i64 %127
  tail call void @llvm.memset.p0.i64(ptr noundef nonnull align 8 dereferenceable(1) %128, i8 0, i64 %126, i1 false), !tbaa !6
  br label %129

129:                                              ; preds = %124, %121
  %130 = getelementptr inbounds nuw [120 x double], ptr %3, i64 %77, i64 %77
  store double 1.000000e+00, ptr %130, align 8, !tbaa !6
  %131 = add nuw nsw i64 %76, 1
  %132 = icmp eq i64 %122, 120
  br i1 %132, label %133, label %75, !llvm.loop !17

133:                                              ; preds = %129
  %134 = tail call ptr @polybench_alloc_data(i64 noundef 14400, i32 noundef 8) #7
  %135 = ptrtoint ptr %134 to i64
  tail call void @llvm.memset.p0.i64(ptr noundef nonnull align 8 dereferenceable(115200) %134, i8 0, i64 115200, i1 false), !tbaa !6
  br label %136

136:                                              ; preds = %154, %133
  %137 = phi i64 [ 0, %133 ], [ %155, %154 ]
  br label %138

138:                                              ; preds = %151, %136
  %139 = phi i64 [ 0, %136 ], [ %152, %151 ]
  %140 = getelementptr inbounds nuw [120 x double], ptr %3, i64 %139, i64 %137
  br label %141

141:                                              ; preds = %141, %138
  %142 = phi i64 [ 0, %138 ], [ %149, %141 ]
  %143 = load double, ptr %140, align 8, !tbaa !6
  %144 = getelementptr inbounds nuw [120 x double], ptr %3, i64 %142, i64 %137
  %145 = load double, ptr %144, align 8, !tbaa !6
  %146 = getelementptr inbounds nuw [120 x [120 x double]], ptr %134, i64 0, i64 %139, i64 %142
  %147 = load double, ptr %146, align 8, !tbaa !6
  %148 = tail call double @llvm.fmuladd.f64(double %143, double %145, double %147)
  store double %148, ptr %146, align 8, !tbaa !6
  %149 = add nuw nsw i64 %142, 1
  %150 = icmp eq i64 %149, 120
  br i1 %150, label %151, label %141, !llvm.loop !18

151:                                              ; preds = %141
  %152 = add nuw nsw i64 %139, 1
  %153 = icmp eq i64 %152, 120
  br i1 %153, label %154, label %138, !llvm.loop !19

154:                                              ; preds = %151
  %155 = add nuw nsw i64 %137, 1
  %156 = icmp eq i64 %155, 120
  br i1 %156, label %157, label %136, !llvm.loop !20

157:                                              ; preds = %154
  %158 = sub i64 %4, %135
  %159 = icmp ult i64 %158, 64
  br label %160

160:                                              ; preds = %185, %157
  %161 = phi i64 [ %186, %185 ], [ 0, %157 ]
  br i1 %159, label %.preheader9, label %.preheader11

.preheader11:                                     ; preds = %160
  br label %162

.preheader9:                                      ; preds = %160
  br label %178

162:                                              ; preds = %.preheader11, %162
  %163 = phi i64 [ %176, %162 ], [ 0, %.preheader11 ]
  %164 = getelementptr inbounds nuw [120 x [120 x double]], ptr %134, i64 0, i64 %161, i64 %163
  %165 = getelementptr inbounds nuw i8, ptr %164, i64 16
  %166 = getelementptr inbounds nuw i8, ptr %164, i64 32
  %167 = getelementptr inbounds nuw i8, ptr %164, i64 48
  %168 = load <2 x double>, ptr %164, align 8, !tbaa !6
  %169 = load <2 x double>, ptr %165, align 8, !tbaa !6
  %170 = load <2 x double>, ptr %166, align 8, !tbaa !6
  %171 = load <2 x double>, ptr %167, align 8, !tbaa !6
  %172 = getelementptr inbounds nuw [120 x double], ptr %3, i64 %161, i64 %163
  %173 = getelementptr inbounds nuw i8, ptr %172, i64 16
  %174 = getelementptr inbounds nuw i8, ptr %172, i64 32
  %175 = getelementptr inbounds nuw i8, ptr %172, i64 48
  store <2 x double> %168, ptr %172, align 8, !tbaa !6
  store <2 x double> %169, ptr %173, align 8, !tbaa !6
  store <2 x double> %170, ptr %174, align 8, !tbaa !6
  store <2 x double> %171, ptr %175, align 8, !tbaa !6
  %176 = add nuw i64 %163, 8
  %177 = icmp eq i64 %176, 120
  br i1 %177, label %.loopexit12, label %162, !llvm.loop !21

178:                                              ; preds = %.preheader9, %178
  %179 = phi i64 [ %183, %178 ], [ 0, %.preheader9 ]
  %180 = getelementptr inbounds nuw [120 x [120 x double]], ptr %134, i64 0, i64 %161, i64 %179
  %181 = load double, ptr %180, align 8, !tbaa !6
  %182 = getelementptr inbounds nuw [120 x double], ptr %3, i64 %161, i64 %179
  store double %181, ptr %182, align 8, !tbaa !6
  %183 = add nuw nsw i64 %179, 1
  %184 = icmp eq i64 %183, 120
  br i1 %184, label %.loopexit10, label %178, !llvm.loop !22

.loopexit10:                                      ; preds = %178
  br label %185

.loopexit12:                                      ; preds = %162
  br label %185

185:                                              ; preds = %.loopexit12, %.loopexit10
  %186 = add nuw nsw i64 %161, 1
  %187 = icmp eq i64 %186, 120
  br i1 %187, label %188, label %160, !llvm.loop !23

188:                                              ; preds = %185
  tail call void @free(ptr noundef nonnull %134)
  tail call void @polybench_timer_start() #7
  br label %189

189:                                              ; preds = %235, %188
  %190 = phi i64 [ 0, %188 ], [ %236, %235 ]
  %191 = icmp eq i64 %190, 0
  br i1 %191, label %215, label %.preheader7

.preheader7:                                      ; preds = %189
  br label %192

192:                                              ; preds = %.preheader7, %208
  %193 = phi i64 [ %213, %208 ], [ 0, %.preheader7 ]
  %194 = getelementptr inbounds nuw [120 x double], ptr %3, i64 %190, i64 %193
  %195 = load double, ptr %194, align 8, !tbaa !6
  %196 = icmp eq i64 %193, 0
  br i1 %196, label %208, label %.preheader5

.preheader5:                                      ; preds = %192
  br label %197

197:                                              ; preds = %.preheader5, %197
  %198 = phi i64 [ %206, %197 ], [ 0, %.preheader5 ]
  %199 = phi double [ %205, %197 ], [ %195, %.preheader5 ]
  %200 = getelementptr inbounds nuw [120 x double], ptr %3, i64 %190, i64 %198
  %201 = load double, ptr %200, align 8, !tbaa !6
  %202 = getelementptr inbounds nuw [120 x double], ptr %3, i64 %198, i64 %193
  %203 = load double, ptr %202, align 8, !tbaa !6
  %204 = fneg double %201
  %205 = tail call double @llvm.fmuladd.f64(double %204, double %203, double %199)
  %206 = add nuw nsw i64 %198, 1
  %207 = icmp eq i64 %206, %193
  br i1 %207, label %.loopexit6, label %197, !llvm.loop !24

.loopexit6:                                       ; preds = %197
  br label %208

208:                                              ; preds = %.loopexit6, %192
  %209 = phi double [ %195, %192 ], [ %205, %.loopexit6 ]
  %210 = getelementptr inbounds nuw [120 x double], ptr %3, i64 %193, i64 %193
  %211 = load double, ptr %210, align 8, !tbaa !6
  %212 = fdiv double %209, %211
  store double %212, ptr %194, align 8, !tbaa !6
  %213 = add nuw nsw i64 %193, 1
  %214 = icmp eq i64 %213, %190
  br i1 %214, label %.loopexit8, label %192, !llvm.loop !25

.loopexit8:                                       ; preds = %208
  br label %215

215:                                              ; preds = %.loopexit8, %189
  br label %216

216:                                              ; preds = %231, %215
  %217 = phi i64 [ %233, %231 ], [ %190, %215 ]
  %218 = getelementptr inbounds nuw [120 x double], ptr %3, i64 %190, i64 %217
  %219 = load double, ptr %218, align 8, !tbaa !6
  br i1 %191, label %231, label %.preheader3

.preheader3:                                      ; preds = %216
  br label %220

220:                                              ; preds = %.preheader3, %220
  %221 = phi i64 [ %229, %220 ], [ 0, %.preheader3 ]
  %222 = phi double [ %228, %220 ], [ %219, %.preheader3 ]
  %223 = getelementptr inbounds nuw [120 x double], ptr %3, i64 %190, i64 %221
  %224 = load double, ptr %223, align 8, !tbaa !6
  %225 = getelementptr inbounds nuw [120 x double], ptr %3, i64 %221, i64 %217
  %226 = load double, ptr %225, align 8, !tbaa !6
  %227 = fneg double %224
  %228 = tail call double @llvm.fmuladd.f64(double %227, double %226, double %222)
  %229 = add nuw nsw i64 %221, 1
  %230 = icmp eq i64 %229, %190
  br i1 %230, label %.loopexit4, label %220, !llvm.loop !26

.loopexit4:                                       ; preds = %220
  br label %231

231:                                              ; preds = %.loopexit4, %216
  %232 = phi double [ %219, %216 ], [ %228, %.loopexit4 ]
  store double %232, ptr %218, align 8, !tbaa !6
  %233 = add nuw nsw i64 %217, 1
  %234 = icmp eq i64 %233, 120
  br i1 %234, label %235, label %216, !llvm.loop !27

235:                                              ; preds = %231
  %236 = add nuw nsw i64 %190, 1
  %237 = icmp eq i64 %236, 120
  br i1 %237, label %.preheader2, label %189, !llvm.loop !28

.preheader2:                                      ; preds = %235
  br label %238

238:                                              ; preds = %.preheader2, %296
  %239 = phi i64 [ %299, %296 ], [ 0, %.preheader2 ]
  %240 = getelementptr inbounds nuw double, ptr %5, i64 %239
  %241 = load double, ptr %240, align 8, !tbaa !6
  %242 = icmp eq i64 %239, 0
  br i1 %242, label %296, label %243

243:                                              ; preds = %238
  %244 = icmp samesign ult i64 %239, 8
  br i1 %244, label %282, label %245

245:                                              ; preds = %243
  %246 = and i64 %239, 9223372036854775800
  br label %247

247:                                              ; preds = %247, %245
  %248 = phi i64 [ 0, %245 ], [ %278, %247 ]
  %249 = phi double [ %241, %245 ], [ %277, %247 ]
  %250 = getelementptr inbounds nuw [120 x double], ptr %3, i64 %239, i64 %248
  %251 = getelementptr inbounds nuw i8, ptr %250, i64 16
  %252 = getelementptr inbounds nuw i8, ptr %250, i64 32
  %253 = getelementptr inbounds nuw i8, ptr %250, i64 48
  %254 = load <2 x double>, ptr %250, align 8, !tbaa !6
  %255 = load <2 x double>, ptr %251, align 8, !tbaa !6
  %256 = load <2 x double>, ptr %252, align 8, !tbaa !6
  %257 = load <2 x double>, ptr %253, align 8, !tbaa !6
  %258 = getelementptr inbounds nuw double, ptr %7, i64 %248
  %259 = getelementptr inbounds nuw i8, ptr %258, i64 16
  %260 = getelementptr inbounds nuw i8, ptr %258, i64 32
  %261 = getelementptr inbounds nuw i8, ptr %258, i64 48
  %262 = load <2 x double>, ptr %258, align 8, !tbaa !6
  %263 = load <2 x double>, ptr %259, align 8, !tbaa !6
  %264 = load <2 x double>, ptr %260, align 8, !tbaa !6
  %265 = load <2 x double>, ptr %261, align 8, !tbaa !6
  %266 = fneg <2 x double> %254
  %267 = fneg <2 x double> %255
  %268 = fneg <2 x double> %256
  %269 = fneg <2 x double> %257
  %270 = fmul <2 x double> %262, %266
  %271 = fmul <2 x double> %263, %267
  %272 = fmul <2 x double> %264, %268
  %273 = fmul <2 x double> %265, %269
  %274 = tail call double @llvm.vector.reduce.fadd.v2f64(double %249, <2 x double> %270)
  %275 = tail call double @llvm.vector.reduce.fadd.v2f64(double %274, <2 x double> %271)
  %276 = tail call double @llvm.vector.reduce.fadd.v2f64(double %275, <2 x double> %272)
  %277 = tail call double @llvm.vector.reduce.fadd.v2f64(double %276, <2 x double> %273)
  %278 = add nuw i64 %248, 8
  %279 = icmp eq i64 %278, %246
  br i1 %279, label %280, label %247, !llvm.loop !29

280:                                              ; preds = %247
  %281 = icmp eq i64 %239, %246
  br i1 %281, label %296, label %282

282:                                              ; preds = %280, %243
  %283 = phi i64 [ 0, %243 ], [ %246, %280 ]
  %284 = phi double [ %241, %243 ], [ %277, %280 ]
  br label %285

285:                                              ; preds = %285, %282
  %286 = phi i64 [ %294, %285 ], [ %283, %282 ]
  %287 = phi double [ %293, %285 ], [ %284, %282 ]
  %288 = getelementptr inbounds nuw [120 x double], ptr %3, i64 %239, i64 %286
  %289 = load double, ptr %288, align 8, !tbaa !6
  %290 = getelementptr inbounds nuw double, ptr %7, i64 %286
  %291 = load double, ptr %290, align 8, !tbaa !6
  %292 = fneg double %289
  %293 = tail call double @llvm.fmuladd.f64(double %292, double %291, double %287)
  %294 = add nuw nsw i64 %286, 1
  %295 = icmp eq i64 %294, %239
  br i1 %295, label %.loopexit1, label %285, !llvm.loop !30

.loopexit1:                                       ; preds = %285
  br label %296

296:                                              ; preds = %.loopexit1, %280, %238
  %297 = phi double [ %241, %238 ], [ %277, %280 ], [ %293, %.loopexit1 ]
  %298 = getelementptr inbounds nuw double, ptr %7, i64 %239
  store double %297, ptr %298, align 8, !tbaa !6
  %299 = add nuw nsw i64 %239, 1
  %300 = icmp eq i64 %299, 120
  br i1 %300, label %.preheader, label %238, !llvm.loop !31

.preheader:                                       ; preds = %296
  br label %301

301:                                              ; preds = %.preheader, %363
  %302 = phi i64 [ %371, %363 ], [ 0, %.preheader ]
  %303 = phi i64 [ %369, %363 ], [ 119, %.preheader ]
  %304 = getelementptr inbounds nuw double, ptr %7, i64 %303
  %305 = load double, ptr %304, align 8, !tbaa !6
  %306 = icmp samesign ult i64 %303, 119
  br i1 %306, label %307, label %363

307:                                              ; preds = %301
  %308 = icmp ult i64 %302, 8
  br i1 %308, label %349, label %309

309:                                              ; preds = %307
  %310 = and i64 %302, -8
  %311 = add i64 %303, %310
  %312 = add i64 %303, 1
  br label %313

313:                                              ; preds = %313, %309
  %314 = phi i64 [ 0, %309 ], [ %345, %313 ]
  %315 = phi double [ %305, %309 ], [ %344, %313 ]
  %316 = add i64 %314, %312
  %317 = getelementptr inbounds nuw [120 x double], ptr %3, i64 %303, i64 %316
  %318 = getelementptr inbounds nuw i8, ptr %317, i64 16
  %319 = getelementptr inbounds nuw i8, ptr %317, i64 32
  %320 = getelementptr inbounds nuw i8, ptr %317, i64 48
  %321 = load <2 x double>, ptr %317, align 8, !tbaa !6
  %322 = load <2 x double>, ptr %318, align 8, !tbaa !6
  %323 = load <2 x double>, ptr %319, align 8, !tbaa !6
  %324 = load <2 x double>, ptr %320, align 8, !tbaa !6
  %325 = getelementptr inbounds nuw double, ptr %6, i64 %316
  %326 = getelementptr inbounds nuw i8, ptr %325, i64 16
  %327 = getelementptr inbounds nuw i8, ptr %325, i64 32
  %328 = getelementptr inbounds nuw i8, ptr %325, i64 48
  %329 = load <2 x double>, ptr %325, align 8, !tbaa !6
  %330 = load <2 x double>, ptr %326, align 8, !tbaa !6
  %331 = load <2 x double>, ptr %327, align 8, !tbaa !6
  %332 = load <2 x double>, ptr %328, align 8, !tbaa !6
  %333 = fneg <2 x double> %321
  %334 = fneg <2 x double> %322
  %335 = fneg <2 x double> %323
  %336 = fneg <2 x double> %324
  %337 = fmul <2 x double> %329, %333
  %338 = fmul <2 x double> %330, %334
  %339 = fmul <2 x double> %331, %335
  %340 = fmul <2 x double> %332, %336
  %341 = tail call double @llvm.vector.reduce.fadd.v2f64(double %315, <2 x double> %337)
  %342 = tail call double @llvm.vector.reduce.fadd.v2f64(double %341, <2 x double> %338)
  %343 = tail call double @llvm.vector.reduce.fadd.v2f64(double %342, <2 x double> %339)
  %344 = tail call double @llvm.vector.reduce.fadd.v2f64(double %343, <2 x double> %340)
  %345 = add nuw i64 %314, 8
  %346 = icmp eq i64 %345, %310
  br i1 %346, label %347, label %313, !llvm.loop !32

347:                                              ; preds = %313
  %348 = icmp eq i64 %302, %310
  br i1 %348, label %363, label %349

349:                                              ; preds = %347, %307
  %350 = phi i64 [ %303, %307 ], [ %311, %347 ]
  %351 = phi double [ %305, %307 ], [ %344, %347 ]
  br label %352

352:                                              ; preds = %352, %349
  %353 = phi i64 [ %355, %352 ], [ %350, %349 ]
  %354 = phi double [ %361, %352 ], [ %351, %349 ]
  %355 = add nuw nsw i64 %353, 1
  %356 = getelementptr inbounds nuw [120 x double], ptr %3, i64 %303, i64 %355
  %357 = load double, ptr %356, align 8, !tbaa !6
  %358 = getelementptr inbounds nuw double, ptr %6, i64 %355
  %359 = load double, ptr %358, align 8, !tbaa !6
  %360 = fneg double %357
  %361 = tail call double @llvm.fmuladd.f64(double %360, double %359, double %354)
  %362 = icmp eq i64 %355, 119
  br i1 %362, label %.loopexit, label %352, !llvm.loop !33

.loopexit:                                        ; preds = %352
  br label %363

363:                                              ; preds = %.loopexit, %347, %301
  %364 = phi double [ %305, %301 ], [ %344, %347 ], [ %361, %.loopexit ]
  %365 = getelementptr inbounds nuw [120 x double], ptr %3, i64 %303, i64 %303
  %366 = load double, ptr %365, align 8, !tbaa !6
  %367 = fdiv double %364, %366
  %368 = getelementptr inbounds nuw double, ptr %6, i64 %303
  store double %367, ptr %368, align 8, !tbaa !6
  %369 = add nsw i64 %303, -1
  %370 = icmp eq i64 %303, 0
  %371 = add i64 %302, 1
  br i1 %370, label %372, label %301, !llvm.loop !34

372:                                              ; preds = %363
  tail call void @polybench_timer_stop() #7
  tail call void @polybench_timer_print() #7
  %373 = icmp sgt i32 %0, 42
  br i1 %373, label %374, label %403

374:                                              ; preds = %372
  %375 = load ptr, ptr %1, align 8, !tbaa !35
  %376 = load i8, ptr %375, align 1
  %377 = icmp eq i8 %376, 0
  br i1 %377, label %378, label %403

378:                                              ; preds = %374
  %379 = load ptr, ptr @__stderrp, align 8, !tbaa !38
  %380 = tail call i64 @fwrite(ptr nonnull @.str.1, i64 22, i64 1, ptr %379)
  %381 = load ptr, ptr @__stderrp, align 8, !tbaa !38
  %382 = tail call i32 (ptr, ptr, ...) @fprintf(ptr noundef %381, ptr noundef nonnull @.str.2, ptr noundef nonnull @.str.3) #7
  br label %383

383:                                              ; preds = %391, %378
  %384 = phi i64 [ 0, %378 ], [ %396, %391 ]
  %385 = trunc i64 %384 to i8
  %386 = urem i8 %385, 20
  %387 = icmp eq i8 %386, 0
  br i1 %387, label %388, label %391

388:                                              ; preds = %383
  %389 = load ptr, ptr @__stderrp, align 8, !tbaa !38
  %390 = tail call i32 @fputc(i32 10, ptr %389)
  br label %391

391:                                              ; preds = %388, %383
  %392 = load ptr, ptr @__stderrp, align 8, !tbaa !38
  %393 = getelementptr inbounds nuw double, ptr %6, i64 %384
  %394 = load double, ptr %393, align 8, !tbaa !6
  %395 = tail call i32 (ptr, ptr, ...) @fprintf(ptr noundef %392, ptr noundef nonnull @.str.5, double noundef %394) #7
  %396 = add nuw nsw i64 %384, 1
  %397 = icmp eq i64 %396, 120
  br i1 %397, label %398, label %383, !llvm.loop !40

398:                                              ; preds = %391
  %399 = load ptr, ptr @__stderrp, align 8, !tbaa !38
  %400 = tail call i32 (ptr, ptr, ...) @fprintf(ptr noundef %399, ptr noundef nonnull @.str.6, ptr noundef nonnull @.str.3) #7
  %401 = load ptr, ptr @__stderrp, align 8, !tbaa !38
  %402 = tail call i64 @fwrite(ptr nonnull @.str.7, i64 22, i64 1, ptr %401)
  br label %403

403:                                              ; preds = %398, %374, %372
  tail call void @free(ptr noundef %3)
  tail call void @free(ptr noundef %5)
  tail call void @free(ptr noundef nonnull %6)
  tail call void @free(ptr noundef %7)
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

; Function Attrs: nocallback nofree nounwind willreturn memory(argmem: write)
declare void @llvm.memset.p0.i64(ptr writeonly captures(none), i8, i64, i1 immarg) #6

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare double @llvm.vector.reduce.fadd.v2f64(double, <2 x double>) #3

attributes #0 = { nounwind ssp uwtable(sync) "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+ccpp,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a" }
attributes #1 = { "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+ccpp,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a" }
attributes #2 = { mustprogress nounwind willreturn allockind("free") memory(argmem: readwrite, inaccessiblemem: readwrite) "alloc-family"="malloc" "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+ccpp,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a" }
attributes #3 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #4 = { nofree nounwind "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+ccpp,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a" }
attributes #5 = { nofree nounwind }
attributes #6 = { nocallback nofree nounwind willreturn memory(argmem: write) }
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
!14 = distinct !{!14, !11, !12}
!15 = distinct !{!15, !11, !12, !13}
!16 = distinct !{!16, !11, !13, !12}
!17 = distinct !{!17, !11}
!18 = distinct !{!18, !11}
!19 = distinct !{!19, !11}
!20 = distinct !{!20, !11}
!21 = distinct !{!21, !11, !12, !13}
!22 = distinct !{!22, !11, !12}
!23 = distinct !{!23, !11}
!24 = distinct !{!24, !11}
!25 = distinct !{!25, !11}
!26 = distinct !{!26, !11}
!27 = distinct !{!27, !11}
!28 = distinct !{!28, !11}
!29 = distinct !{!29, !11, !12, !13}
!30 = distinct !{!30, !11, !13, !12}
!31 = distinct !{!31, !11}
!32 = distinct !{!32, !11, !12, !13}
!33 = distinct !{!33, !11, !13, !12}
!34 = distinct !{!34, !11}
!35 = !{!36, !36, i64 0}
!36 = !{!"p1 omnipotent char", !37, i64 0}
!37 = !{!"any pointer", !8, i64 0}
!38 = !{!39, !39, i64 0}
!39 = !{!"p1 _ZTS7__sFILE", !37, i64 0}
!40 = distinct !{!40, !11}
