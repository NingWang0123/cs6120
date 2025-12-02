; ModuleID = './polybench/medley/deriche/deriche.c'
source_filename = "./polybench/medley/deriche/deriche.c"
target datalayout = "e-m:o-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-n32:64-S128-Fn32"
target triple = "arm64-apple-macosx15.0.0"

@__stderrp = external local_unnamed_addr global ptr, align 8
@.str.1 = private unnamed_addr constant [23 x i8] c"==BEGIN DUMP_ARRAYS==\0A\00", align 1
@.str.2 = private unnamed_addr constant [15 x i8] c"begin dump: %s\00", align 1
@.str.3 = private unnamed_addr constant [7 x i8] c"imgOut\00", align 1
@.str.5 = private unnamed_addr constant [7 x i8] c"%0.2f \00", align 1
@.str.6 = private unnamed_addr constant [17 x i8] c"\0Aend   dump: %s\0A\00", align 1
@.str.7 = private unnamed_addr constant [23 x i8] c"==END   DUMP_ARRAYS==\0A\00", align 1

; Function Attrs: nounwind ssp uwtable(sync)
define noundef i32 @main(i32 noundef %0, ptr noundef readonly captures(none) %1) local_unnamed_addr #0 {
  %3 = tail call ptr @polybench_alloc_data(i64 noundef 24576, i32 noundef 4) #6
  %4 = tail call ptr @polybench_alloc_data(i64 noundef 24576, i32 noundef 4) #6
  %5 = ptrtoint ptr %4 to i64
  %6 = tail call ptr @polybench_alloc_data(i64 noundef 24576, i32 noundef 4) #6
  %7 = ptrtoint ptr %6 to i64
  %8 = tail call ptr @polybench_alloc_data(i64 noundef 24576, i32 noundef 4) #6
  %9 = ptrtoint ptr %8 to i64
  br label %10

10:                                               ; preds = %2, %28
  %11 = phi i64 [ 0, %2 ], [ %29, %28 ]
  %12 = mul nuw nsw i64 %11, 313
  %13 = insertelement <4 x i64> poison, i64 %12, i64 0
  %14 = shufflevector <4 x i64> %13, <4 x i64> poison, <4 x i32> zeroinitializer
  br label %15

15:                                               ; preds = %15, %10
  %16 = phi i64 [ 0, %10 ], [ %25, %15 ]
  %17 = phi <4 x i64> [ <i64 0, i64 1, i64 2, i64 3>, %10 ], [ %26, %15 ]
  %18 = mul nuw nsw <4 x i64> %17, splat (i64 991)
  %19 = add nuw nsw <4 x i64> %18, %14
  %20 = trunc nuw nsw <4 x i64> %19 to <4 x i32>
  %21 = and <4 x i32> %20, splat (i32 65535)
  %22 = uitofp nneg <4 x i32> %21 to <4 x float>
  %23 = fdiv <4 x float> %22, splat (float 6.553500e+04)
  %24 = getelementptr inbounds nuw [128 x float], ptr %3, i64 %11, i64 %16
  store <4 x float> %23, ptr %24, align 4, !tbaa !6
  %25 = add nuw i64 %16, 4
  %26 = add <4 x i64> %17, splat (i64 4)
  %27 = icmp eq i64 %25, 128
  br i1 %27, label %28, label %15, !llvm.loop !10

28:                                               ; preds = %15
  %29 = add nuw nsw i64 %11, 1
  %30 = icmp eq i64 %29, 192
  br i1 %30, label %31, label %10, !llvm.loop !14

31:                                               ; preds = %28
  tail call void @polybench_timer_start() #6
  br label %32

32:                                               ; preds = %49, %31
  %33 = phi i64 [ 0, %31 ], [ %50, %49 ]
  br label %34

34:                                               ; preds = %34, %32
  %35 = phi i64 [ 0, %32 ], [ %47, %34 ]
  %36 = phi float [ 0.000000e+00, %32 ], [ %46, %34 ]
  %37 = phi float [ 0.000000e+00, %32 ], [ %44, %34 ]
  %38 = phi float [ 0.000000e+00, %32 ], [ %37, %34 ]
  %39 = getelementptr inbounds nuw [128 x float], ptr %3, i64 %33, i64 %35
  %40 = load float, ptr %39, align 4, !tbaa !6
  %41 = fmul float %36, 0x3FBC36A980000000
  %42 = tail call float @llvm.fmuladd.f32(float %40, float 0xBFC826B880000000, float %41)
  %43 = tail call float @llvm.fmuladd.f32(float %37, float 0x3FEAE89FA0000000, float %42)
  %44 = tail call float @llvm.fmuladd.f32(float %38, float 0xBFE368B300000000, float %43)
  %45 = getelementptr inbounds nuw [128 x float], ptr %6, i64 %33, i64 %35
  store float %44, ptr %45, align 4, !tbaa !6
  %46 = load float, ptr %39, align 4, !tbaa !6
  %47 = add nuw nsw i64 %35, 1
  %48 = icmp eq i64 %47, 128
  br i1 %48, label %49, label %34, !llvm.loop !15

49:                                               ; preds = %34
  %50 = add nuw nsw i64 %33, 1
  %51 = icmp eq i64 %50, 192
  br i1 %51, label %52, label %32, !llvm.loop !16

52:                                               ; preds = %49, %69
  %53 = phi i64 [ %70, %69 ], [ 0, %49 ]
  br label %54

54:                                               ; preds = %54, %52
  %55 = phi i64 [ 127, %52 ], [ %67, %54 ]
  %56 = phi float [ 0.000000e+00, %52 ], [ %66, %54 ]
  %57 = phi float [ 0.000000e+00, %52 ], [ %56, %54 ]
  %58 = phi float [ 0.000000e+00, %52 ], [ %63, %54 ]
  %59 = phi float [ 0.000000e+00, %52 ], [ %58, %54 ]
  %60 = fmul float %57, 0x3FBD4C0500000000
  %61 = tail call float @llvm.fmuladd.f32(float %56, float 0xBFC782E280000000, float %60)
  %62 = tail call float @llvm.fmuladd.f32(float %58, float 0x3FEAE89FA0000000, float %61)
  %63 = tail call float @llvm.fmuladd.f32(float %59, float 0xBFE368B300000000, float %62)
  %64 = getelementptr inbounds nuw [128 x float], ptr %8, i64 %53, i64 %55
  store float %63, ptr %64, align 4, !tbaa !6
  %65 = getelementptr inbounds nuw [128 x float], ptr %3, i64 %53, i64 %55
  %66 = load float, ptr %65, align 4, !tbaa !6
  %67 = add nsw i64 %55, -1
  %68 = icmp eq i64 %55, 0
  br i1 %68, label %69, label %54, !llvm.loop !17

69:                                               ; preds = %54
  %70 = add nuw nsw i64 %53, 1
  %71 = icmp eq i64 %70, 192
  br i1 %71, label %72, label %52, !llvm.loop !18

72:                                               ; preds = %69
  %73 = sub i64 %5, %7
  %74 = sub i64 %5, %9
  %75 = icmp ult i64 %73, 64
  %76 = icmp ult i64 %74, 64
  %77 = or i1 %75, %76
  br label %78

78:                                               ; preds = %283, %72
  %79 = phi i64 [ %284, %283 ], [ 0, %72 ]
  br i1 %77, label %273, label %80

80:                                               ; preds = %78
  %81 = getelementptr inbounds nuw [128 x float], ptr %6, i64 %79, i64 0
  %82 = getelementptr inbounds nuw i8, ptr %81, i64 16
  %83 = getelementptr inbounds nuw i8, ptr %81, i64 32
  %84 = getelementptr inbounds nuw i8, ptr %81, i64 48
  %85 = load <4 x float>, ptr %81, align 4, !tbaa !6
  %86 = load <4 x float>, ptr %82, align 4, !tbaa !6
  %87 = load <4 x float>, ptr %83, align 4, !tbaa !6
  %88 = load <4 x float>, ptr %84, align 4, !tbaa !6
  %89 = getelementptr inbounds nuw [128 x float], ptr %8, i64 %79, i64 0
  %90 = getelementptr inbounds nuw i8, ptr %89, i64 16
  %91 = getelementptr inbounds nuw i8, ptr %89, i64 32
  %92 = getelementptr inbounds nuw i8, ptr %89, i64 48
  %93 = load <4 x float>, ptr %89, align 4, !tbaa !6
  %94 = load <4 x float>, ptr %90, align 4, !tbaa !6
  %95 = load <4 x float>, ptr %91, align 4, !tbaa !6
  %96 = load <4 x float>, ptr %92, align 4, !tbaa !6
  %97 = fadd <4 x float> %85, %93
  %98 = fadd <4 x float> %86, %94
  %99 = fadd <4 x float> %87, %95
  %100 = fadd <4 x float> %88, %96
  %101 = getelementptr inbounds nuw [128 x float], ptr %4, i64 %79, i64 0
  %102 = getelementptr inbounds nuw i8, ptr %101, i64 16
  %103 = getelementptr inbounds nuw i8, ptr %101, i64 32
  %104 = getelementptr inbounds nuw i8, ptr %101, i64 48
  store <4 x float> %97, ptr %101, align 4, !tbaa !6
  store <4 x float> %98, ptr %102, align 4, !tbaa !6
  store <4 x float> %99, ptr %103, align 4, !tbaa !6
  store <4 x float> %100, ptr %104, align 4, !tbaa !6
  %105 = getelementptr inbounds nuw [128 x float], ptr %6, i64 %79, i64 16
  %106 = getelementptr inbounds nuw i8, ptr %105, i64 16
  %107 = getelementptr inbounds nuw i8, ptr %105, i64 32
  %108 = getelementptr inbounds nuw i8, ptr %105, i64 48
  %109 = load <4 x float>, ptr %105, align 4, !tbaa !6
  %110 = load <4 x float>, ptr %106, align 4, !tbaa !6
  %111 = load <4 x float>, ptr %107, align 4, !tbaa !6
  %112 = load <4 x float>, ptr %108, align 4, !tbaa !6
  %113 = getelementptr inbounds nuw [128 x float], ptr %8, i64 %79, i64 16
  %114 = getelementptr inbounds nuw i8, ptr %113, i64 16
  %115 = getelementptr inbounds nuw i8, ptr %113, i64 32
  %116 = getelementptr inbounds nuw i8, ptr %113, i64 48
  %117 = load <4 x float>, ptr %113, align 4, !tbaa !6
  %118 = load <4 x float>, ptr %114, align 4, !tbaa !6
  %119 = load <4 x float>, ptr %115, align 4, !tbaa !6
  %120 = load <4 x float>, ptr %116, align 4, !tbaa !6
  %121 = fadd <4 x float> %109, %117
  %122 = fadd <4 x float> %110, %118
  %123 = fadd <4 x float> %111, %119
  %124 = fadd <4 x float> %112, %120
  %125 = getelementptr inbounds nuw [128 x float], ptr %4, i64 %79, i64 16
  %126 = getelementptr inbounds nuw i8, ptr %125, i64 16
  %127 = getelementptr inbounds nuw i8, ptr %125, i64 32
  %128 = getelementptr inbounds nuw i8, ptr %125, i64 48
  store <4 x float> %121, ptr %125, align 4, !tbaa !6
  store <4 x float> %122, ptr %126, align 4, !tbaa !6
  store <4 x float> %123, ptr %127, align 4, !tbaa !6
  store <4 x float> %124, ptr %128, align 4, !tbaa !6
  %129 = getelementptr inbounds nuw [128 x float], ptr %6, i64 %79, i64 32
  %130 = getelementptr inbounds nuw i8, ptr %129, i64 16
  %131 = getelementptr inbounds nuw i8, ptr %129, i64 32
  %132 = getelementptr inbounds nuw i8, ptr %129, i64 48
  %133 = load <4 x float>, ptr %129, align 4, !tbaa !6
  %134 = load <4 x float>, ptr %130, align 4, !tbaa !6
  %135 = load <4 x float>, ptr %131, align 4, !tbaa !6
  %136 = load <4 x float>, ptr %132, align 4, !tbaa !6
  %137 = getelementptr inbounds nuw [128 x float], ptr %8, i64 %79, i64 32
  %138 = getelementptr inbounds nuw i8, ptr %137, i64 16
  %139 = getelementptr inbounds nuw i8, ptr %137, i64 32
  %140 = getelementptr inbounds nuw i8, ptr %137, i64 48
  %141 = load <4 x float>, ptr %137, align 4, !tbaa !6
  %142 = load <4 x float>, ptr %138, align 4, !tbaa !6
  %143 = load <4 x float>, ptr %139, align 4, !tbaa !6
  %144 = load <4 x float>, ptr %140, align 4, !tbaa !6
  %145 = fadd <4 x float> %133, %141
  %146 = fadd <4 x float> %134, %142
  %147 = fadd <4 x float> %135, %143
  %148 = fadd <4 x float> %136, %144
  %149 = getelementptr inbounds nuw [128 x float], ptr %4, i64 %79, i64 32
  %150 = getelementptr inbounds nuw i8, ptr %149, i64 16
  %151 = getelementptr inbounds nuw i8, ptr %149, i64 32
  %152 = getelementptr inbounds nuw i8, ptr %149, i64 48
  store <4 x float> %145, ptr %149, align 4, !tbaa !6
  store <4 x float> %146, ptr %150, align 4, !tbaa !6
  store <4 x float> %147, ptr %151, align 4, !tbaa !6
  store <4 x float> %148, ptr %152, align 4, !tbaa !6
  %153 = getelementptr inbounds nuw [128 x float], ptr %6, i64 %79, i64 48
  %154 = getelementptr inbounds nuw i8, ptr %153, i64 16
  %155 = getelementptr inbounds nuw i8, ptr %153, i64 32
  %156 = getelementptr inbounds nuw i8, ptr %153, i64 48
  %157 = load <4 x float>, ptr %153, align 4, !tbaa !6
  %158 = load <4 x float>, ptr %154, align 4, !tbaa !6
  %159 = load <4 x float>, ptr %155, align 4, !tbaa !6
  %160 = load <4 x float>, ptr %156, align 4, !tbaa !6
  %161 = getelementptr inbounds nuw [128 x float], ptr %8, i64 %79, i64 48
  %162 = getelementptr inbounds nuw i8, ptr %161, i64 16
  %163 = getelementptr inbounds nuw i8, ptr %161, i64 32
  %164 = getelementptr inbounds nuw i8, ptr %161, i64 48
  %165 = load <4 x float>, ptr %161, align 4, !tbaa !6
  %166 = load <4 x float>, ptr %162, align 4, !tbaa !6
  %167 = load <4 x float>, ptr %163, align 4, !tbaa !6
  %168 = load <4 x float>, ptr %164, align 4, !tbaa !6
  %169 = fadd <4 x float> %157, %165
  %170 = fadd <4 x float> %158, %166
  %171 = fadd <4 x float> %159, %167
  %172 = fadd <4 x float> %160, %168
  %173 = getelementptr inbounds nuw [128 x float], ptr %4, i64 %79, i64 48
  %174 = getelementptr inbounds nuw i8, ptr %173, i64 16
  %175 = getelementptr inbounds nuw i8, ptr %173, i64 32
  %176 = getelementptr inbounds nuw i8, ptr %173, i64 48
  store <4 x float> %169, ptr %173, align 4, !tbaa !6
  store <4 x float> %170, ptr %174, align 4, !tbaa !6
  store <4 x float> %171, ptr %175, align 4, !tbaa !6
  store <4 x float> %172, ptr %176, align 4, !tbaa !6
  %177 = getelementptr inbounds nuw [128 x float], ptr %6, i64 %79, i64 64
  %178 = getelementptr inbounds nuw i8, ptr %177, i64 16
  %179 = getelementptr inbounds nuw i8, ptr %177, i64 32
  %180 = getelementptr inbounds nuw i8, ptr %177, i64 48
  %181 = load <4 x float>, ptr %177, align 4, !tbaa !6
  %182 = load <4 x float>, ptr %178, align 4, !tbaa !6
  %183 = load <4 x float>, ptr %179, align 4, !tbaa !6
  %184 = load <4 x float>, ptr %180, align 4, !tbaa !6
  %185 = getelementptr inbounds nuw [128 x float], ptr %8, i64 %79, i64 64
  %186 = getelementptr inbounds nuw i8, ptr %185, i64 16
  %187 = getelementptr inbounds nuw i8, ptr %185, i64 32
  %188 = getelementptr inbounds nuw i8, ptr %185, i64 48
  %189 = load <4 x float>, ptr %185, align 4, !tbaa !6
  %190 = load <4 x float>, ptr %186, align 4, !tbaa !6
  %191 = load <4 x float>, ptr %187, align 4, !tbaa !6
  %192 = load <4 x float>, ptr %188, align 4, !tbaa !6
  %193 = fadd <4 x float> %181, %189
  %194 = fadd <4 x float> %182, %190
  %195 = fadd <4 x float> %183, %191
  %196 = fadd <4 x float> %184, %192
  %197 = getelementptr inbounds nuw [128 x float], ptr %4, i64 %79, i64 64
  %198 = getelementptr inbounds nuw i8, ptr %197, i64 16
  %199 = getelementptr inbounds nuw i8, ptr %197, i64 32
  %200 = getelementptr inbounds nuw i8, ptr %197, i64 48
  store <4 x float> %193, ptr %197, align 4, !tbaa !6
  store <4 x float> %194, ptr %198, align 4, !tbaa !6
  store <4 x float> %195, ptr %199, align 4, !tbaa !6
  store <4 x float> %196, ptr %200, align 4, !tbaa !6
  %201 = getelementptr inbounds nuw [128 x float], ptr %6, i64 %79, i64 80
  %202 = getelementptr inbounds nuw i8, ptr %201, i64 16
  %203 = getelementptr inbounds nuw i8, ptr %201, i64 32
  %204 = getelementptr inbounds nuw i8, ptr %201, i64 48
  %205 = load <4 x float>, ptr %201, align 4, !tbaa !6
  %206 = load <4 x float>, ptr %202, align 4, !tbaa !6
  %207 = load <4 x float>, ptr %203, align 4, !tbaa !6
  %208 = load <4 x float>, ptr %204, align 4, !tbaa !6
  %209 = getelementptr inbounds nuw [128 x float], ptr %8, i64 %79, i64 80
  %210 = getelementptr inbounds nuw i8, ptr %209, i64 16
  %211 = getelementptr inbounds nuw i8, ptr %209, i64 32
  %212 = getelementptr inbounds nuw i8, ptr %209, i64 48
  %213 = load <4 x float>, ptr %209, align 4, !tbaa !6
  %214 = load <4 x float>, ptr %210, align 4, !tbaa !6
  %215 = load <4 x float>, ptr %211, align 4, !tbaa !6
  %216 = load <4 x float>, ptr %212, align 4, !tbaa !6
  %217 = fadd <4 x float> %205, %213
  %218 = fadd <4 x float> %206, %214
  %219 = fadd <4 x float> %207, %215
  %220 = fadd <4 x float> %208, %216
  %221 = getelementptr inbounds nuw [128 x float], ptr %4, i64 %79, i64 80
  %222 = getelementptr inbounds nuw i8, ptr %221, i64 16
  %223 = getelementptr inbounds nuw i8, ptr %221, i64 32
  %224 = getelementptr inbounds nuw i8, ptr %221, i64 48
  store <4 x float> %217, ptr %221, align 4, !tbaa !6
  store <4 x float> %218, ptr %222, align 4, !tbaa !6
  store <4 x float> %219, ptr %223, align 4, !tbaa !6
  store <4 x float> %220, ptr %224, align 4, !tbaa !6
  %225 = getelementptr inbounds nuw [128 x float], ptr %6, i64 %79, i64 96
  %226 = getelementptr inbounds nuw i8, ptr %225, i64 16
  %227 = getelementptr inbounds nuw i8, ptr %225, i64 32
  %228 = getelementptr inbounds nuw i8, ptr %225, i64 48
  %229 = load <4 x float>, ptr %225, align 4, !tbaa !6
  %230 = load <4 x float>, ptr %226, align 4, !tbaa !6
  %231 = load <4 x float>, ptr %227, align 4, !tbaa !6
  %232 = load <4 x float>, ptr %228, align 4, !tbaa !6
  %233 = getelementptr inbounds nuw [128 x float], ptr %8, i64 %79, i64 96
  %234 = getelementptr inbounds nuw i8, ptr %233, i64 16
  %235 = getelementptr inbounds nuw i8, ptr %233, i64 32
  %236 = getelementptr inbounds nuw i8, ptr %233, i64 48
  %237 = load <4 x float>, ptr %233, align 4, !tbaa !6
  %238 = load <4 x float>, ptr %234, align 4, !tbaa !6
  %239 = load <4 x float>, ptr %235, align 4, !tbaa !6
  %240 = load <4 x float>, ptr %236, align 4, !tbaa !6
  %241 = fadd <4 x float> %229, %237
  %242 = fadd <4 x float> %230, %238
  %243 = fadd <4 x float> %231, %239
  %244 = fadd <4 x float> %232, %240
  %245 = getelementptr inbounds nuw [128 x float], ptr %4, i64 %79, i64 96
  %246 = getelementptr inbounds nuw i8, ptr %245, i64 16
  %247 = getelementptr inbounds nuw i8, ptr %245, i64 32
  %248 = getelementptr inbounds nuw i8, ptr %245, i64 48
  store <4 x float> %241, ptr %245, align 4, !tbaa !6
  store <4 x float> %242, ptr %246, align 4, !tbaa !6
  store <4 x float> %243, ptr %247, align 4, !tbaa !6
  store <4 x float> %244, ptr %248, align 4, !tbaa !6
  %249 = getelementptr inbounds nuw [128 x float], ptr %6, i64 %79, i64 112
  %250 = getelementptr inbounds nuw i8, ptr %249, i64 16
  %251 = getelementptr inbounds nuw i8, ptr %249, i64 32
  %252 = getelementptr inbounds nuw i8, ptr %249, i64 48
  %253 = load <4 x float>, ptr %249, align 4, !tbaa !6
  %254 = load <4 x float>, ptr %250, align 4, !tbaa !6
  %255 = load <4 x float>, ptr %251, align 4, !tbaa !6
  %256 = load <4 x float>, ptr %252, align 4, !tbaa !6
  %257 = getelementptr inbounds nuw [128 x float], ptr %8, i64 %79, i64 112
  %258 = getelementptr inbounds nuw i8, ptr %257, i64 16
  %259 = getelementptr inbounds nuw i8, ptr %257, i64 32
  %260 = getelementptr inbounds nuw i8, ptr %257, i64 48
  %261 = load <4 x float>, ptr %257, align 4, !tbaa !6
  %262 = load <4 x float>, ptr %258, align 4, !tbaa !6
  %263 = load <4 x float>, ptr %259, align 4, !tbaa !6
  %264 = load <4 x float>, ptr %260, align 4, !tbaa !6
  %265 = fadd <4 x float> %253, %261
  %266 = fadd <4 x float> %254, %262
  %267 = fadd <4 x float> %255, %263
  %268 = fadd <4 x float> %256, %264
  %269 = getelementptr inbounds nuw [128 x float], ptr %4, i64 %79, i64 112
  %270 = getelementptr inbounds nuw i8, ptr %269, i64 16
  %271 = getelementptr inbounds nuw i8, ptr %269, i64 32
  %272 = getelementptr inbounds nuw i8, ptr %269, i64 48
  store <4 x float> %265, ptr %269, align 4, !tbaa !6
  store <4 x float> %266, ptr %270, align 4, !tbaa !6
  store <4 x float> %267, ptr %271, align 4, !tbaa !6
  store <4 x float> %268, ptr %272, align 4, !tbaa !6
  br label %283

273:                                              ; preds = %78, %273
  %274 = phi i64 [ %281, %273 ], [ 0, %78 ]
  %275 = getelementptr inbounds nuw [128 x float], ptr %6, i64 %79, i64 %274
  %276 = load float, ptr %275, align 4, !tbaa !6
  %277 = getelementptr inbounds nuw [128 x float], ptr %8, i64 %79, i64 %274
  %278 = load float, ptr %277, align 4, !tbaa !6
  %279 = fadd float %276, %278
  %280 = getelementptr inbounds nuw [128 x float], ptr %4, i64 %79, i64 %274
  store float %279, ptr %280, align 4, !tbaa !6
  %281 = add nuw nsw i64 %274, 1
  %282 = icmp eq i64 %281, 128
  br i1 %282, label %283, label %273, !llvm.loop !19

283:                                              ; preds = %273, %80
  %284 = add nuw nsw i64 %79, 1
  %285 = icmp eq i64 %284, 192
  br i1 %285, label %286, label %78, !llvm.loop !20

286:                                              ; preds = %283, %303
  %287 = phi i64 [ %304, %303 ], [ 0, %283 ]
  br label %288

288:                                              ; preds = %288, %286
  %289 = phi i64 [ 0, %286 ], [ %301, %288 ]
  %290 = phi float [ 0.000000e+00, %286 ], [ %300, %288 ]
  %291 = phi float [ 0.000000e+00, %286 ], [ %298, %288 ]
  %292 = phi float [ 0.000000e+00, %286 ], [ %291, %288 ]
  %293 = getelementptr inbounds nuw [128 x float], ptr %4, i64 %289, i64 %287
  %294 = load float, ptr %293, align 4, !tbaa !6
  %295 = fmul float %290, 0x3FBC36A980000000
  %296 = tail call float @llvm.fmuladd.f32(float %294, float 0xBFC826B880000000, float %295)
  %297 = tail call float @llvm.fmuladd.f32(float %291, float 0x3FEAE89FA0000000, float %296)
  %298 = tail call float @llvm.fmuladd.f32(float %292, float 0xBFE368B300000000, float %297)
  %299 = getelementptr inbounds nuw [128 x float], ptr %6, i64 %289, i64 %287
  store float %298, ptr %299, align 4, !tbaa !6
  %300 = load float, ptr %293, align 4, !tbaa !6
  %301 = add nuw nsw i64 %289, 1
  %302 = icmp eq i64 %301, 192
  br i1 %302, label %303, label %288, !llvm.loop !21

303:                                              ; preds = %288
  %304 = add nuw nsw i64 %287, 1
  %305 = icmp eq i64 %304, 128
  br i1 %305, label %306, label %286, !llvm.loop !22

306:                                              ; preds = %303, %323
  %307 = phi i64 [ %324, %323 ], [ 0, %303 ]
  br label %308

308:                                              ; preds = %308, %306
  %309 = phi i64 [ 191, %306 ], [ %321, %308 ]
  %310 = phi float [ 0.000000e+00, %306 ], [ %320, %308 ]
  %311 = phi float [ 0.000000e+00, %306 ], [ %310, %308 ]
  %312 = phi float [ 0.000000e+00, %306 ], [ %317, %308 ]
  %313 = phi float [ 0.000000e+00, %306 ], [ %312, %308 ]
  %314 = fmul float %311, 0x3FBD4C0500000000
  %315 = tail call float @llvm.fmuladd.f32(float %310, float 0xBFC782E280000000, float %314)
  %316 = tail call float @llvm.fmuladd.f32(float %312, float 0x3FEAE89FA0000000, float %315)
  %317 = tail call float @llvm.fmuladd.f32(float %313, float 0xBFE368B300000000, float %316)
  %318 = getelementptr inbounds nuw [128 x float], ptr %8, i64 %309, i64 %307
  store float %317, ptr %318, align 4, !tbaa !6
  %319 = getelementptr inbounds nuw [128 x float], ptr %4, i64 %309, i64 %307
  %320 = load float, ptr %319, align 4, !tbaa !6
  %321 = add nsw i64 %309, -1
  %322 = icmp eq i64 %309, 0
  br i1 %322, label %323, label %308, !llvm.loop !23

323:                                              ; preds = %308
  %324 = add nuw nsw i64 %307, 1
  %325 = icmp eq i64 %324, 128
  br i1 %325, label %326, label %306, !llvm.loop !24

326:                                              ; preds = %323
  %327 = sub i64 %5, %7
  %328 = sub i64 %5, %9
  %329 = icmp ult i64 %327, 64
  %330 = icmp ult i64 %328, 64
  %331 = or i1 %329, %330
  br label %332

332:                                              ; preds = %537, %326
  %333 = phi i64 [ %538, %537 ], [ 0, %326 ]
  br i1 %331, label %527, label %334

334:                                              ; preds = %332
  %335 = getelementptr inbounds nuw [128 x float], ptr %6, i64 %333, i64 0
  %336 = getelementptr inbounds nuw i8, ptr %335, i64 16
  %337 = getelementptr inbounds nuw i8, ptr %335, i64 32
  %338 = getelementptr inbounds nuw i8, ptr %335, i64 48
  %339 = load <4 x float>, ptr %335, align 4, !tbaa !6
  %340 = load <4 x float>, ptr %336, align 4, !tbaa !6
  %341 = load <4 x float>, ptr %337, align 4, !tbaa !6
  %342 = load <4 x float>, ptr %338, align 4, !tbaa !6
  %343 = getelementptr inbounds nuw [128 x float], ptr %8, i64 %333, i64 0
  %344 = getelementptr inbounds nuw i8, ptr %343, i64 16
  %345 = getelementptr inbounds nuw i8, ptr %343, i64 32
  %346 = getelementptr inbounds nuw i8, ptr %343, i64 48
  %347 = load <4 x float>, ptr %343, align 4, !tbaa !6
  %348 = load <4 x float>, ptr %344, align 4, !tbaa !6
  %349 = load <4 x float>, ptr %345, align 4, !tbaa !6
  %350 = load <4 x float>, ptr %346, align 4, !tbaa !6
  %351 = fadd <4 x float> %339, %347
  %352 = fadd <4 x float> %340, %348
  %353 = fadd <4 x float> %341, %349
  %354 = fadd <4 x float> %342, %350
  %355 = getelementptr inbounds nuw [128 x float], ptr %4, i64 %333, i64 0
  %356 = getelementptr inbounds nuw i8, ptr %355, i64 16
  %357 = getelementptr inbounds nuw i8, ptr %355, i64 32
  %358 = getelementptr inbounds nuw i8, ptr %355, i64 48
  store <4 x float> %351, ptr %355, align 4, !tbaa !6
  store <4 x float> %352, ptr %356, align 4, !tbaa !6
  store <4 x float> %353, ptr %357, align 4, !tbaa !6
  store <4 x float> %354, ptr %358, align 4, !tbaa !6
  %359 = getelementptr inbounds nuw [128 x float], ptr %6, i64 %333, i64 16
  %360 = getelementptr inbounds nuw i8, ptr %359, i64 16
  %361 = getelementptr inbounds nuw i8, ptr %359, i64 32
  %362 = getelementptr inbounds nuw i8, ptr %359, i64 48
  %363 = load <4 x float>, ptr %359, align 4, !tbaa !6
  %364 = load <4 x float>, ptr %360, align 4, !tbaa !6
  %365 = load <4 x float>, ptr %361, align 4, !tbaa !6
  %366 = load <4 x float>, ptr %362, align 4, !tbaa !6
  %367 = getelementptr inbounds nuw [128 x float], ptr %8, i64 %333, i64 16
  %368 = getelementptr inbounds nuw i8, ptr %367, i64 16
  %369 = getelementptr inbounds nuw i8, ptr %367, i64 32
  %370 = getelementptr inbounds nuw i8, ptr %367, i64 48
  %371 = load <4 x float>, ptr %367, align 4, !tbaa !6
  %372 = load <4 x float>, ptr %368, align 4, !tbaa !6
  %373 = load <4 x float>, ptr %369, align 4, !tbaa !6
  %374 = load <4 x float>, ptr %370, align 4, !tbaa !6
  %375 = fadd <4 x float> %363, %371
  %376 = fadd <4 x float> %364, %372
  %377 = fadd <4 x float> %365, %373
  %378 = fadd <4 x float> %366, %374
  %379 = getelementptr inbounds nuw [128 x float], ptr %4, i64 %333, i64 16
  %380 = getelementptr inbounds nuw i8, ptr %379, i64 16
  %381 = getelementptr inbounds nuw i8, ptr %379, i64 32
  %382 = getelementptr inbounds nuw i8, ptr %379, i64 48
  store <4 x float> %375, ptr %379, align 4, !tbaa !6
  store <4 x float> %376, ptr %380, align 4, !tbaa !6
  store <4 x float> %377, ptr %381, align 4, !tbaa !6
  store <4 x float> %378, ptr %382, align 4, !tbaa !6
  %383 = getelementptr inbounds nuw [128 x float], ptr %6, i64 %333, i64 32
  %384 = getelementptr inbounds nuw i8, ptr %383, i64 16
  %385 = getelementptr inbounds nuw i8, ptr %383, i64 32
  %386 = getelementptr inbounds nuw i8, ptr %383, i64 48
  %387 = load <4 x float>, ptr %383, align 4, !tbaa !6
  %388 = load <4 x float>, ptr %384, align 4, !tbaa !6
  %389 = load <4 x float>, ptr %385, align 4, !tbaa !6
  %390 = load <4 x float>, ptr %386, align 4, !tbaa !6
  %391 = getelementptr inbounds nuw [128 x float], ptr %8, i64 %333, i64 32
  %392 = getelementptr inbounds nuw i8, ptr %391, i64 16
  %393 = getelementptr inbounds nuw i8, ptr %391, i64 32
  %394 = getelementptr inbounds nuw i8, ptr %391, i64 48
  %395 = load <4 x float>, ptr %391, align 4, !tbaa !6
  %396 = load <4 x float>, ptr %392, align 4, !tbaa !6
  %397 = load <4 x float>, ptr %393, align 4, !tbaa !6
  %398 = load <4 x float>, ptr %394, align 4, !tbaa !6
  %399 = fadd <4 x float> %387, %395
  %400 = fadd <4 x float> %388, %396
  %401 = fadd <4 x float> %389, %397
  %402 = fadd <4 x float> %390, %398
  %403 = getelementptr inbounds nuw [128 x float], ptr %4, i64 %333, i64 32
  %404 = getelementptr inbounds nuw i8, ptr %403, i64 16
  %405 = getelementptr inbounds nuw i8, ptr %403, i64 32
  %406 = getelementptr inbounds nuw i8, ptr %403, i64 48
  store <4 x float> %399, ptr %403, align 4, !tbaa !6
  store <4 x float> %400, ptr %404, align 4, !tbaa !6
  store <4 x float> %401, ptr %405, align 4, !tbaa !6
  store <4 x float> %402, ptr %406, align 4, !tbaa !6
  %407 = getelementptr inbounds nuw [128 x float], ptr %6, i64 %333, i64 48
  %408 = getelementptr inbounds nuw i8, ptr %407, i64 16
  %409 = getelementptr inbounds nuw i8, ptr %407, i64 32
  %410 = getelementptr inbounds nuw i8, ptr %407, i64 48
  %411 = load <4 x float>, ptr %407, align 4, !tbaa !6
  %412 = load <4 x float>, ptr %408, align 4, !tbaa !6
  %413 = load <4 x float>, ptr %409, align 4, !tbaa !6
  %414 = load <4 x float>, ptr %410, align 4, !tbaa !6
  %415 = getelementptr inbounds nuw [128 x float], ptr %8, i64 %333, i64 48
  %416 = getelementptr inbounds nuw i8, ptr %415, i64 16
  %417 = getelementptr inbounds nuw i8, ptr %415, i64 32
  %418 = getelementptr inbounds nuw i8, ptr %415, i64 48
  %419 = load <4 x float>, ptr %415, align 4, !tbaa !6
  %420 = load <4 x float>, ptr %416, align 4, !tbaa !6
  %421 = load <4 x float>, ptr %417, align 4, !tbaa !6
  %422 = load <4 x float>, ptr %418, align 4, !tbaa !6
  %423 = fadd <4 x float> %411, %419
  %424 = fadd <4 x float> %412, %420
  %425 = fadd <4 x float> %413, %421
  %426 = fadd <4 x float> %414, %422
  %427 = getelementptr inbounds nuw [128 x float], ptr %4, i64 %333, i64 48
  %428 = getelementptr inbounds nuw i8, ptr %427, i64 16
  %429 = getelementptr inbounds nuw i8, ptr %427, i64 32
  %430 = getelementptr inbounds nuw i8, ptr %427, i64 48
  store <4 x float> %423, ptr %427, align 4, !tbaa !6
  store <4 x float> %424, ptr %428, align 4, !tbaa !6
  store <4 x float> %425, ptr %429, align 4, !tbaa !6
  store <4 x float> %426, ptr %430, align 4, !tbaa !6
  %431 = getelementptr inbounds nuw [128 x float], ptr %6, i64 %333, i64 64
  %432 = getelementptr inbounds nuw i8, ptr %431, i64 16
  %433 = getelementptr inbounds nuw i8, ptr %431, i64 32
  %434 = getelementptr inbounds nuw i8, ptr %431, i64 48
  %435 = load <4 x float>, ptr %431, align 4, !tbaa !6
  %436 = load <4 x float>, ptr %432, align 4, !tbaa !6
  %437 = load <4 x float>, ptr %433, align 4, !tbaa !6
  %438 = load <4 x float>, ptr %434, align 4, !tbaa !6
  %439 = getelementptr inbounds nuw [128 x float], ptr %8, i64 %333, i64 64
  %440 = getelementptr inbounds nuw i8, ptr %439, i64 16
  %441 = getelementptr inbounds nuw i8, ptr %439, i64 32
  %442 = getelementptr inbounds nuw i8, ptr %439, i64 48
  %443 = load <4 x float>, ptr %439, align 4, !tbaa !6
  %444 = load <4 x float>, ptr %440, align 4, !tbaa !6
  %445 = load <4 x float>, ptr %441, align 4, !tbaa !6
  %446 = load <4 x float>, ptr %442, align 4, !tbaa !6
  %447 = fadd <4 x float> %435, %443
  %448 = fadd <4 x float> %436, %444
  %449 = fadd <4 x float> %437, %445
  %450 = fadd <4 x float> %438, %446
  %451 = getelementptr inbounds nuw [128 x float], ptr %4, i64 %333, i64 64
  %452 = getelementptr inbounds nuw i8, ptr %451, i64 16
  %453 = getelementptr inbounds nuw i8, ptr %451, i64 32
  %454 = getelementptr inbounds nuw i8, ptr %451, i64 48
  store <4 x float> %447, ptr %451, align 4, !tbaa !6
  store <4 x float> %448, ptr %452, align 4, !tbaa !6
  store <4 x float> %449, ptr %453, align 4, !tbaa !6
  store <4 x float> %450, ptr %454, align 4, !tbaa !6
  %455 = getelementptr inbounds nuw [128 x float], ptr %6, i64 %333, i64 80
  %456 = getelementptr inbounds nuw i8, ptr %455, i64 16
  %457 = getelementptr inbounds nuw i8, ptr %455, i64 32
  %458 = getelementptr inbounds nuw i8, ptr %455, i64 48
  %459 = load <4 x float>, ptr %455, align 4, !tbaa !6
  %460 = load <4 x float>, ptr %456, align 4, !tbaa !6
  %461 = load <4 x float>, ptr %457, align 4, !tbaa !6
  %462 = load <4 x float>, ptr %458, align 4, !tbaa !6
  %463 = getelementptr inbounds nuw [128 x float], ptr %8, i64 %333, i64 80
  %464 = getelementptr inbounds nuw i8, ptr %463, i64 16
  %465 = getelementptr inbounds nuw i8, ptr %463, i64 32
  %466 = getelementptr inbounds nuw i8, ptr %463, i64 48
  %467 = load <4 x float>, ptr %463, align 4, !tbaa !6
  %468 = load <4 x float>, ptr %464, align 4, !tbaa !6
  %469 = load <4 x float>, ptr %465, align 4, !tbaa !6
  %470 = load <4 x float>, ptr %466, align 4, !tbaa !6
  %471 = fadd <4 x float> %459, %467
  %472 = fadd <4 x float> %460, %468
  %473 = fadd <4 x float> %461, %469
  %474 = fadd <4 x float> %462, %470
  %475 = getelementptr inbounds nuw [128 x float], ptr %4, i64 %333, i64 80
  %476 = getelementptr inbounds nuw i8, ptr %475, i64 16
  %477 = getelementptr inbounds nuw i8, ptr %475, i64 32
  %478 = getelementptr inbounds nuw i8, ptr %475, i64 48
  store <4 x float> %471, ptr %475, align 4, !tbaa !6
  store <4 x float> %472, ptr %476, align 4, !tbaa !6
  store <4 x float> %473, ptr %477, align 4, !tbaa !6
  store <4 x float> %474, ptr %478, align 4, !tbaa !6
  %479 = getelementptr inbounds nuw [128 x float], ptr %6, i64 %333, i64 96
  %480 = getelementptr inbounds nuw i8, ptr %479, i64 16
  %481 = getelementptr inbounds nuw i8, ptr %479, i64 32
  %482 = getelementptr inbounds nuw i8, ptr %479, i64 48
  %483 = load <4 x float>, ptr %479, align 4, !tbaa !6
  %484 = load <4 x float>, ptr %480, align 4, !tbaa !6
  %485 = load <4 x float>, ptr %481, align 4, !tbaa !6
  %486 = load <4 x float>, ptr %482, align 4, !tbaa !6
  %487 = getelementptr inbounds nuw [128 x float], ptr %8, i64 %333, i64 96
  %488 = getelementptr inbounds nuw i8, ptr %487, i64 16
  %489 = getelementptr inbounds nuw i8, ptr %487, i64 32
  %490 = getelementptr inbounds nuw i8, ptr %487, i64 48
  %491 = load <4 x float>, ptr %487, align 4, !tbaa !6
  %492 = load <4 x float>, ptr %488, align 4, !tbaa !6
  %493 = load <4 x float>, ptr %489, align 4, !tbaa !6
  %494 = load <4 x float>, ptr %490, align 4, !tbaa !6
  %495 = fadd <4 x float> %483, %491
  %496 = fadd <4 x float> %484, %492
  %497 = fadd <4 x float> %485, %493
  %498 = fadd <4 x float> %486, %494
  %499 = getelementptr inbounds nuw [128 x float], ptr %4, i64 %333, i64 96
  %500 = getelementptr inbounds nuw i8, ptr %499, i64 16
  %501 = getelementptr inbounds nuw i8, ptr %499, i64 32
  %502 = getelementptr inbounds nuw i8, ptr %499, i64 48
  store <4 x float> %495, ptr %499, align 4, !tbaa !6
  store <4 x float> %496, ptr %500, align 4, !tbaa !6
  store <4 x float> %497, ptr %501, align 4, !tbaa !6
  store <4 x float> %498, ptr %502, align 4, !tbaa !6
  %503 = getelementptr inbounds nuw [128 x float], ptr %6, i64 %333, i64 112
  %504 = getelementptr inbounds nuw i8, ptr %503, i64 16
  %505 = getelementptr inbounds nuw i8, ptr %503, i64 32
  %506 = getelementptr inbounds nuw i8, ptr %503, i64 48
  %507 = load <4 x float>, ptr %503, align 4, !tbaa !6
  %508 = load <4 x float>, ptr %504, align 4, !tbaa !6
  %509 = load <4 x float>, ptr %505, align 4, !tbaa !6
  %510 = load <4 x float>, ptr %506, align 4, !tbaa !6
  %511 = getelementptr inbounds nuw [128 x float], ptr %8, i64 %333, i64 112
  %512 = getelementptr inbounds nuw i8, ptr %511, i64 16
  %513 = getelementptr inbounds nuw i8, ptr %511, i64 32
  %514 = getelementptr inbounds nuw i8, ptr %511, i64 48
  %515 = load <4 x float>, ptr %511, align 4, !tbaa !6
  %516 = load <4 x float>, ptr %512, align 4, !tbaa !6
  %517 = load <4 x float>, ptr %513, align 4, !tbaa !6
  %518 = load <4 x float>, ptr %514, align 4, !tbaa !6
  %519 = fadd <4 x float> %507, %515
  %520 = fadd <4 x float> %508, %516
  %521 = fadd <4 x float> %509, %517
  %522 = fadd <4 x float> %510, %518
  %523 = getelementptr inbounds nuw [128 x float], ptr %4, i64 %333, i64 112
  %524 = getelementptr inbounds nuw i8, ptr %523, i64 16
  %525 = getelementptr inbounds nuw i8, ptr %523, i64 32
  %526 = getelementptr inbounds nuw i8, ptr %523, i64 48
  store <4 x float> %519, ptr %523, align 4, !tbaa !6
  store <4 x float> %520, ptr %524, align 4, !tbaa !6
  store <4 x float> %521, ptr %525, align 4, !tbaa !6
  store <4 x float> %522, ptr %526, align 4, !tbaa !6
  br label %537

527:                                              ; preds = %332, %527
  %528 = phi i64 [ %535, %527 ], [ 0, %332 ]
  %529 = getelementptr inbounds nuw [128 x float], ptr %6, i64 %333, i64 %528
  %530 = load float, ptr %529, align 4, !tbaa !6
  %531 = getelementptr inbounds nuw [128 x float], ptr %8, i64 %333, i64 %528
  %532 = load float, ptr %531, align 4, !tbaa !6
  %533 = fadd float %530, %532
  %534 = getelementptr inbounds nuw [128 x float], ptr %4, i64 %333, i64 %528
  store float %533, ptr %534, align 4, !tbaa !6
  %535 = add nuw nsw i64 %528, 1
  %536 = icmp eq i64 %535, 128
  br i1 %536, label %537, label %527, !llvm.loop !25

537:                                              ; preds = %527, %334
  %538 = add nuw nsw i64 %333, 1
  %539 = icmp eq i64 %538, 192
  br i1 %539, label %540, label %332, !llvm.loop !26

540:                                              ; preds = %537
  tail call void @polybench_timer_stop() #6
  tail call void @polybench_timer_print() #6
  %541 = icmp sgt i32 %0, 42
  br i1 %541, label %542, label %579

542:                                              ; preds = %540
  %543 = load ptr, ptr %1, align 8, !tbaa !27
  %544 = load i8, ptr %543, align 1
  %545 = icmp eq i8 %544, 0
  br i1 %545, label %546, label %579

546:                                              ; preds = %542
  %547 = load ptr, ptr @__stderrp, align 8, !tbaa !30
  %548 = tail call i64 @fwrite(ptr nonnull @.str.1, i64 22, i64 1, ptr %547)
  %549 = load ptr, ptr @__stderrp, align 8, !tbaa !30
  %550 = tail call i32 (ptr, ptr, ...) @fprintf(ptr noundef %549, ptr noundef nonnull @.str.2, ptr noundef nonnull @.str.3) #6
  br label %551

551:                                              ; preds = %571, %546
  %552 = phi i64 [ 0, %546 ], [ %572, %571 ]
  %553 = shl nuw nsw i64 %552, 7
  br label %554

554:                                              ; preds = %563, %551
  %555 = phi i64 [ 0, %551 ], [ %569, %563 ]
  %556 = add nuw nsw i64 %555, %553
  %557 = trunc nuw nsw i64 %556 to i32
  %558 = urem i32 %557, 20
  %559 = icmp eq i32 %558, 0
  br i1 %559, label %560, label %563

560:                                              ; preds = %554
  %561 = load ptr, ptr @__stderrp, align 8, !tbaa !30
  %562 = tail call i32 @fputc(i32 10, ptr %561)
  br label %563

563:                                              ; preds = %560, %554
  %564 = load ptr, ptr @__stderrp, align 8, !tbaa !30
  %565 = getelementptr inbounds nuw [128 x float], ptr %4, i64 %552, i64 %555
  %566 = load float, ptr %565, align 4, !tbaa !6
  %567 = fpext float %566 to double
  %568 = tail call i32 (ptr, ptr, ...) @fprintf(ptr noundef %564, ptr noundef nonnull @.str.5, double noundef %567) #6
  %569 = add nuw nsw i64 %555, 1
  %570 = icmp eq i64 %569, 128
  br i1 %570, label %571, label %554, !llvm.loop !32

571:                                              ; preds = %563
  %572 = add nuw nsw i64 %552, 1
  %573 = icmp eq i64 %572, 192
  br i1 %573, label %574, label %551, !llvm.loop !33

574:                                              ; preds = %571
  %575 = load ptr, ptr @__stderrp, align 8, !tbaa !30
  %576 = tail call i32 (ptr, ptr, ...) @fprintf(ptr noundef %575, ptr noundef nonnull @.str.6, ptr noundef nonnull @.str.3) #6
  %577 = load ptr, ptr @__stderrp, align 8, !tbaa !30
  %578 = tail call i64 @fwrite(ptr nonnull @.str.7, i64 22, i64 1, ptr %577)
  br label %579

579:                                              ; preds = %574, %542, %540
  tail call void @free(ptr noundef %3)
  tail call void @free(ptr noundef nonnull %4)
  tail call void @free(ptr noundef %6)
  tail call void @free(ptr noundef %8)
  ret i32 0
}

declare ptr @polybench_alloc_data(i64 noundef, i32 noundef) local_unnamed_addr #1

declare void @polybench_timer_start(...) local_unnamed_addr #1

declare void @polybench_timer_stop(...) local_unnamed_addr #1

declare void @polybench_timer_print(...) local_unnamed_addr #1

; Function Attrs: mustprogress nounwind willreturn allockind("free") memory(argmem: readwrite, inaccessiblemem: readwrite)
declare void @free(ptr allocptr noundef captures(none)) local_unnamed_addr #2

; Function Attrs: mustprogress nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare float @llvm.fmuladd.f32(float, float, float) #3

; Function Attrs: nofree nounwind
declare noundef i32 @fprintf(ptr noundef captures(none), ptr noundef readonly captures(none), ...) local_unnamed_addr #4

; Function Attrs: nofree nounwind
declare noundef i64 @fwrite(ptr noundef readonly captures(none), i64 noundef, i64 noundef, ptr noundef captures(none)) local_unnamed_addr #5

; Function Attrs: nofree nounwind
declare noundef i32 @fputc(i32 noundef, ptr noundef captures(none)) local_unnamed_addr #5

attributes #0 = { nounwind ssp uwtable(sync) "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+ccpp,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a" }
attributes #1 = { "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+ccpp,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a" }
attributes #2 = { mustprogress nounwind willreturn allockind("free") memory(argmem: readwrite, inaccessiblemem: readwrite) "alloc-family"="malloc" "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+ccpp,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a" }
attributes #3 = { mustprogress nocallback nofree nosync nounwind speculatable willreturn memory(none) }
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
!7 = !{!"float", !8, i64 0}
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
!19 = distinct !{!19, !11, !12}
!20 = distinct !{!20, !11}
!21 = distinct !{!21, !11}
!22 = distinct !{!22, !11}
!23 = distinct !{!23, !11}
!24 = distinct !{!24, !11}
!25 = distinct !{!25, !11, !12}
!26 = distinct !{!26, !11}
!27 = !{!28, !28, i64 0}
!28 = !{!"p1 omnipotent char", !29, i64 0}
!29 = !{!"any pointer", !8, i64 0}
!30 = !{!31, !31, i64 0}
!31 = !{!"p1 _ZTS7__sFILE", !29, i64 0}
!32 = distinct !{!32, !11}
!33 = distinct !{!33, !11}
