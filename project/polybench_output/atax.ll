; ModuleID = './polybench/linear-algebra/kernels/atax/atax.c'
source_filename = "./polybench/linear-algebra/kernels/atax/atax.c"
target datalayout = "e-m:o-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-n32:64-S128-Fn32"
target triple = "arm64-apple-macosx15.0.0"

@__stderrp = external local_unnamed_addr global ptr, align 8
@.str.1 = private unnamed_addr constant [23 x i8] c"==BEGIN DUMP_ARRAYS==\0A\00", align 1
@.str.2 = private unnamed_addr constant [15 x i8] c"begin dump: %s\00", align 1
@.str.3 = private unnamed_addr constant [2 x i8] c"y\00", align 1
@.str.5 = private unnamed_addr constant [8 x i8] c"%0.2lf \00", align 1
@.str.6 = private unnamed_addr constant [17 x i8] c"\0Aend   dump: %s\0A\00", align 1
@.str.7 = private unnamed_addr constant [23 x i8] c"==END   DUMP_ARRAYS==\0A\00", align 1

; Function Attrs: nounwind ssp uwtable(sync)
define noundef i32 @main(i32 noundef %0, ptr noundef readonly captures(none) %1) local_unnamed_addr #0 {
  %3 = tail call ptr @polybench_alloc_data(i64 noundef 14384, i32 noundef 8) #8
  %4 = tail call ptr @polybench_alloc_data(i64 noundef 124, i32 noundef 8) #8
  %5 = tail call ptr @polybench_alloc_data(i64 noundef 124, i32 noundef 8) #8
  %6 = tail call ptr @polybench_alloc_data(i64 noundef 116, i32 noundef 8) #8
  br label %7

7:                                                ; preds = %7, %2
  %8 = phi i64 [ 0, %2 ], [ %29, %7 ]
  %9 = phi <2 x i32> [ <i32 0, i32 1>, %2 ], [ %30, %7 ]
  %10 = add <2 x i32> %9, splat (i32 2)
  %11 = add <2 x i32> %9, splat (i32 4)
  %12 = add <2 x i32> %9, splat (i32 6)
  %13 = uitofp nneg <2 x i32> %9 to <2 x double>
  %14 = uitofp nneg <2 x i32> %10 to <2 x double>
  %15 = uitofp nneg <2 x i32> %11 to <2 x double>
  %16 = uitofp nneg <2 x i32> %12 to <2 x double>
  %17 = fdiv <2 x double> %13, splat (double 1.240000e+02)
  %18 = fdiv <2 x double> %14, splat (double 1.240000e+02)
  %19 = fdiv <2 x double> %15, splat (double 1.240000e+02)
  %20 = fdiv <2 x double> %16, splat (double 1.240000e+02)
  %21 = fadd <2 x double> %17, splat (double 1.000000e+00)
  %22 = fadd <2 x double> %18, splat (double 1.000000e+00)
  %23 = fadd <2 x double> %19, splat (double 1.000000e+00)
  %24 = fadd <2 x double> %20, splat (double 1.000000e+00)
  %25 = getelementptr inbounds nuw double, ptr %4, i64 %8
  %26 = getelementptr inbounds nuw i8, ptr %25, i64 16
  %27 = getelementptr inbounds nuw i8, ptr %25, i64 32
  %28 = getelementptr inbounds nuw i8, ptr %25, i64 48
  store <2 x double> %21, ptr %25, align 8, !tbaa !6
  store <2 x double> %22, ptr %26, align 8, !tbaa !6
  store <2 x double> %23, ptr %27, align 8, !tbaa !6
  store <2 x double> %24, ptr %28, align 8, !tbaa !6
  %29 = add nuw i64 %8, 8
  %30 = add <2 x i32> %9, splat (i32 8)
  %31 = icmp eq i64 %29, 120
  br i1 %31, label %32, label %7, !llvm.loop !10

32:                                               ; preds = %7
  %33 = getelementptr inbounds nuw i8, ptr %4, i64 960
  store double 0x3FFF7BDEF7BDEF7C, ptr %33, align 8, !tbaa !6
  %34 = getelementptr inbounds nuw i8, ptr %4, i64 968
  store double 0x3FFF9CE739CE739D, ptr %34, align 8, !tbaa !6
  %35 = getelementptr inbounds nuw i8, ptr %4, i64 976
  store double 0x3FFFBDEF7BDEF7BE, ptr %35, align 8, !tbaa !6
  %36 = getelementptr inbounds nuw i8, ptr %4, i64 984
  store double 0x3FFFDEF7BDEF7BDF, ptr %36, align 8, !tbaa !6
  br label %37

37:                                               ; preds = %32, %74
  %38 = phi i64 [ %99, %74 ], [ 0, %32 ]
  %39 = insertelement <2 x i64> poison, i64 %38, i64 0
  %40 = shufflevector <2 x i64> %39, <2 x i64> poison, <2 x i32> zeroinitializer
  %41 = add <2 x i64> splat (i64 2), %40
  %42 = add <2 x i64> splat (i64 4), %40
  %43 = add <2 x i64> splat (i64 6), %40
  br label %44

44:                                               ; preds = %44, %37
  %45 = phi i64 [ 0, %37 ], [ %71, %44 ]
  %46 = phi <2 x i64> [ <i64 0, i64 1>, %37 ], [ %72, %44 ]
  %47 = add nuw nsw <2 x i64> %46, %40
  %48 = add <2 x i64> %46, %41
  %49 = add <2 x i64> %46, %42
  %50 = add <2 x i64> %46, %43
  %51 = trunc nuw nsw <2 x i64> %47 to <2 x i32>
  %52 = trunc nuw nsw <2 x i64> %48 to <2 x i32>
  %53 = trunc nuw nsw <2 x i64> %49 to <2 x i32>
  %54 = trunc nuw nsw <2 x i64> %50 to <2 x i32>
  %55 = urem <2 x i32> %51, splat (i32 124)
  %56 = urem <2 x i32> %52, splat (i32 124)
  %57 = urem <2 x i32> %53, splat (i32 124)
  %58 = urem <2 x i32> %54, splat (i32 124)
  %59 = uitofp nneg <2 x i32> %55 to <2 x double>
  %60 = uitofp nneg <2 x i32> %56 to <2 x double>
  %61 = uitofp nneg <2 x i32> %57 to <2 x double>
  %62 = uitofp nneg <2 x i32> %58 to <2 x double>
  %63 = fdiv <2 x double> %59, splat (double 5.800000e+02)
  %64 = fdiv <2 x double> %60, splat (double 5.800000e+02)
  %65 = fdiv <2 x double> %61, splat (double 5.800000e+02)
  %66 = fdiv <2 x double> %62, splat (double 5.800000e+02)
  %67 = getelementptr inbounds nuw [124 x double], ptr %3, i64 %38, i64 %45
  %68 = getelementptr inbounds nuw i8, ptr %67, i64 16
  %69 = getelementptr inbounds nuw i8, ptr %67, i64 32
  %70 = getelementptr inbounds nuw i8, ptr %67, i64 48
  store <2 x double> %63, ptr %67, align 8, !tbaa !6
  store <2 x double> %64, ptr %68, align 8, !tbaa !6
  store <2 x double> %65, ptr %69, align 8, !tbaa !6
  store <2 x double> %66, ptr %70, align 8, !tbaa !6
  %71 = add nuw i64 %45, 8
  %72 = add <2 x i64> %46, splat (i64 8)
  %73 = icmp eq i64 %71, 120
  br i1 %73, label %74, label %44, !llvm.loop !14

74:                                               ; preds = %44
  %75 = trunc i64 %38 to i32
  %76 = add i32 %75, 120
  %77 = urem i32 %76, 124
  %78 = uitofp nneg i32 %77 to double
  %79 = fdiv double %78, 5.800000e+02
  %80 = getelementptr inbounds nuw [124 x double], ptr %3, i64 %38, i64 120
  store double %79, ptr %80, align 8, !tbaa !6
  %81 = trunc i64 %38 to i32
  %82 = add i32 %81, 121
  %83 = urem i32 %82, 124
  %84 = uitofp nneg i32 %83 to double
  %85 = fdiv double %84, 5.800000e+02
  %86 = getelementptr inbounds nuw [124 x double], ptr %3, i64 %38, i64 121
  store double %85, ptr %86, align 8, !tbaa !6
  %87 = trunc i64 %38 to i32
  %88 = add i32 %87, 122
  %89 = urem i32 %88, 124
  %90 = uitofp nneg i32 %89 to double
  %91 = fdiv double %90, 5.800000e+02
  %92 = getelementptr inbounds nuw [124 x double], ptr %3, i64 %38, i64 122
  store double %91, ptr %92, align 8, !tbaa !6
  %93 = trunc i64 %38 to i32
  %94 = add i32 %93, 123
  %95 = urem i32 %94, 124
  %96 = uitofp nneg i32 %95 to double
  %97 = fdiv double %96, 5.800000e+02
  %98 = getelementptr inbounds nuw [124 x double], ptr %3, i64 %38, i64 123
  store double %97, ptr %98, align 8, !tbaa !6
  %99 = add nuw nsw i64 %38, 1
  %100 = icmp eq i64 %99, 116
  br i1 %100, label %101, label %37, !llvm.loop !15

101:                                              ; preds = %74
  tail call void @polybench_timer_start() #8
  tail call void @llvm.memset.p0.i64(ptr noundef nonnull align 8 dereferenceable(992) %5, i8 0, i64 992, i1 false), !tbaa !6
  %102 = getelementptr i8, ptr %5, i64 992
  %103 = getelementptr i8, ptr %3, i64 115072
  %104 = getelementptr i8, ptr %6, i64 928
  %105 = getelementptr i8, ptr %4, i64 992
  %106 = icmp ult ptr %6, %103
  %107 = icmp ult ptr %3, %104
  %108 = and i1 %106, %107
  %109 = icmp ult ptr %6, %105
  %110 = icmp ult ptr %4, %104
  %111 = and i1 %109, %110
  %112 = or i1 %108, %111
  %113 = icmp ult ptr %5, %103
  %114 = icmp ult ptr %3, %102
  %115 = and i1 %113, %114
  %116 = icmp ult ptr %5, %104
  %117 = icmp ult ptr %6, %102
  %118 = and i1 %116, %117
  %119 = or i1 %115, %118
  br label %120

120:                                              ; preds = %207, %101
  %121 = phi i64 [ 0, %101 ], [ %208, %207 ]
  %122 = getelementptr inbounds nuw double, ptr %6, i64 %121
  store double 0.000000e+00, ptr %122, align 8, !tbaa !6
  br i1 %112, label %153, label %123

123:                                              ; preds = %120, %123
  %124 = phi i64 [ %150, %123 ], [ 0, %120 ]
  %125 = phi double [ %149, %123 ], [ 0.000000e+00, %120 ]
  %126 = getelementptr inbounds nuw [124 x double], ptr %3, i64 %121, i64 %124
  %127 = getelementptr inbounds nuw i8, ptr %126, i64 16
  %128 = getelementptr inbounds nuw i8, ptr %126, i64 32
  %129 = getelementptr inbounds nuw i8, ptr %126, i64 48
  %130 = load <2 x double>, ptr %126, align 8, !tbaa !6, !alias.scope !16
  %131 = load <2 x double>, ptr %127, align 8, !tbaa !6, !alias.scope !16
  %132 = load <2 x double>, ptr %128, align 8, !tbaa !6, !alias.scope !16
  %133 = load <2 x double>, ptr %129, align 8, !tbaa !6, !alias.scope !16
  %134 = getelementptr inbounds nuw double, ptr %4, i64 %124
  %135 = getelementptr inbounds nuw i8, ptr %134, i64 16
  %136 = getelementptr inbounds nuw i8, ptr %134, i64 32
  %137 = getelementptr inbounds nuw i8, ptr %134, i64 48
  %138 = load <2 x double>, ptr %134, align 8, !tbaa !6, !alias.scope !19
  %139 = load <2 x double>, ptr %135, align 8, !tbaa !6, !alias.scope !19
  %140 = load <2 x double>, ptr %136, align 8, !tbaa !6, !alias.scope !19
  %141 = load <2 x double>, ptr %137, align 8, !tbaa !6, !alias.scope !19
  %142 = fmul <2 x double> %130, %138
  %143 = fmul <2 x double> %131, %139
  %144 = fmul <2 x double> %132, %140
  %145 = fmul <2 x double> %133, %141
  %146 = tail call double @llvm.vector.reduce.fadd.v2f64(double %125, <2 x double> %142)
  %147 = tail call double @llvm.vector.reduce.fadd.v2f64(double %146, <2 x double> %143)
  %148 = tail call double @llvm.vector.reduce.fadd.v2f64(double %147, <2 x double> %144)
  %149 = tail call double @llvm.vector.reduce.fadd.v2f64(double %148, <2 x double> %145)
  %150 = add nuw i64 %124, 8
  %151 = icmp eq i64 %150, 120
  br i1 %151, label %152, label %123, !llvm.loop !21

152:                                              ; preds = %123
  store double %149, ptr %122, align 8, !tbaa !6, !alias.scope !22, !noalias !24
  br label %153

153:                                              ; preds = %152, %120
  %154 = phi i64 [ 0, %120 ], [ 120, %152 ]
  %155 = phi double [ 0.000000e+00, %120 ], [ %149, %152 ]
  br label %156

156:                                              ; preds = %153, %156
  %157 = phi i64 [ %164, %156 ], [ %154, %153 ]
  %158 = phi double [ %163, %156 ], [ %155, %153 ]
  %159 = getelementptr inbounds nuw [124 x double], ptr %3, i64 %121, i64 %157
  %160 = load double, ptr %159, align 8, !tbaa !6
  %161 = getelementptr inbounds nuw double, ptr %4, i64 %157
  %162 = load double, ptr %161, align 8, !tbaa !6
  %163 = tail call double @llvm.fmuladd.f64(double %160, double %162, double %158)
  store double %163, ptr %122, align 8, !tbaa !6
  %164 = add nuw nsw i64 %157, 1
  %165 = icmp eq i64 %164, 124
  br i1 %165, label %166, label %156, !llvm.loop !25

166:                                              ; preds = %156
  br i1 %119, label %195, label %167

167:                                              ; preds = %166
  %168 = load double, ptr %122, align 8, !tbaa !6, !alias.scope !26
  %169 = insertelement <2 x double> poison, double %168, i64 0
  %170 = shufflevector <2 x double> %169, <2 x double> poison, <2 x i32> zeroinitializer
  br label %171

171:                                              ; preds = %167, %171
  %172 = phi i64 [ %193, %171 ], [ 0, %167 ]
  %173 = getelementptr inbounds nuw double, ptr %5, i64 %172
  %174 = getelementptr inbounds nuw i8, ptr %173, i64 16
  %175 = getelementptr inbounds nuw i8, ptr %173, i64 32
  %176 = getelementptr inbounds nuw i8, ptr %173, i64 48
  %177 = load <2 x double>, ptr %173, align 8, !tbaa !6, !alias.scope !29, !noalias !31
  %178 = load <2 x double>, ptr %174, align 8, !tbaa !6, !alias.scope !29, !noalias !31
  %179 = load <2 x double>, ptr %175, align 8, !tbaa !6, !alias.scope !29, !noalias !31
  %180 = load <2 x double>, ptr %176, align 8, !tbaa !6, !alias.scope !29, !noalias !31
  %181 = getelementptr inbounds nuw [124 x double], ptr %3, i64 %121, i64 %172
  %182 = getelementptr inbounds nuw i8, ptr %181, i64 16
  %183 = getelementptr inbounds nuw i8, ptr %181, i64 32
  %184 = getelementptr inbounds nuw i8, ptr %181, i64 48
  %185 = load <2 x double>, ptr %181, align 8, !tbaa !6, !alias.scope !33
  %186 = load <2 x double>, ptr %182, align 8, !tbaa !6, !alias.scope !33
  %187 = load <2 x double>, ptr %183, align 8, !tbaa !6, !alias.scope !33
  %188 = load <2 x double>, ptr %184, align 8, !tbaa !6, !alias.scope !33
  %189 = tail call <2 x double> @llvm.fmuladd.v2f64(<2 x double> %185, <2 x double> %170, <2 x double> %177)
  %190 = tail call <2 x double> @llvm.fmuladd.v2f64(<2 x double> %186, <2 x double> %170, <2 x double> %178)
  %191 = tail call <2 x double> @llvm.fmuladd.v2f64(<2 x double> %187, <2 x double> %170, <2 x double> %179)
  %192 = tail call <2 x double> @llvm.fmuladd.v2f64(<2 x double> %188, <2 x double> %170, <2 x double> %180)
  store <2 x double> %189, ptr %173, align 8, !tbaa !6, !alias.scope !29, !noalias !31
  store <2 x double> %190, ptr %174, align 8, !tbaa !6, !alias.scope !29, !noalias !31
  store <2 x double> %191, ptr %175, align 8, !tbaa !6, !alias.scope !29, !noalias !31
  store <2 x double> %192, ptr %176, align 8, !tbaa !6, !alias.scope !29, !noalias !31
  %193 = add nuw i64 %172, 8
  %194 = icmp eq i64 %193, 120
  br i1 %194, label %195, label %171, !llvm.loop !34

195:                                              ; preds = %171, %166
  %196 = phi i64 [ 0, %166 ], [ 120, %171 ]
  br label %197

197:                                              ; preds = %195, %197
  %198 = phi i64 [ %205, %197 ], [ %196, %195 ]
  %199 = getelementptr inbounds nuw double, ptr %5, i64 %198
  %200 = load double, ptr %199, align 8, !tbaa !6
  %201 = getelementptr inbounds nuw [124 x double], ptr %3, i64 %121, i64 %198
  %202 = load double, ptr %201, align 8, !tbaa !6
  %203 = load double, ptr %122, align 8, !tbaa !6
  %204 = tail call double @llvm.fmuladd.f64(double %202, double %203, double %200)
  store double %204, ptr %199, align 8, !tbaa !6
  %205 = add nuw nsw i64 %198, 1
  %206 = icmp eq i64 %205, 124
  br i1 %206, label %207, label %197, !llvm.loop !35

207:                                              ; preds = %197
  %208 = add nuw nsw i64 %121, 1
  %209 = icmp eq i64 %208, 116
  br i1 %209, label %210, label %120, !llvm.loop !36

210:                                              ; preds = %207
  tail call void @polybench_timer_stop() #8
  tail call void @polybench_timer_print() #8
  %211 = icmp sgt i32 %0, 42
  br i1 %211, label %212, label %241

212:                                              ; preds = %210
  %213 = load ptr, ptr %1, align 8, !tbaa !37
  %214 = load i8, ptr %213, align 1
  %215 = icmp eq i8 %214, 0
  br i1 %215, label %216, label %241

216:                                              ; preds = %212
  %217 = load ptr, ptr @__stderrp, align 8, !tbaa !40
  %218 = tail call i64 @fwrite(ptr nonnull @.str.1, i64 22, i64 1, ptr %217)
  %219 = load ptr, ptr @__stderrp, align 8, !tbaa !40
  %220 = tail call i32 (ptr, ptr, ...) @fprintf(ptr noundef %219, ptr noundef nonnull @.str.2, ptr noundef nonnull @.str.3) #8
  br label %221

221:                                              ; preds = %229, %216
  %222 = phi i64 [ 0, %216 ], [ %234, %229 ]
  %223 = trunc i64 %222 to i8
  %224 = urem i8 %223, 20
  %225 = icmp eq i8 %224, 0
  br i1 %225, label %226, label %229

226:                                              ; preds = %221
  %227 = load ptr, ptr @__stderrp, align 8, !tbaa !40
  %228 = tail call i32 @fputc(i32 10, ptr %227)
  br label %229

229:                                              ; preds = %226, %221
  %230 = load ptr, ptr @__stderrp, align 8, !tbaa !40
  %231 = getelementptr inbounds nuw double, ptr %5, i64 %222
  %232 = load double, ptr %231, align 8, !tbaa !6
  %233 = tail call i32 (ptr, ptr, ...) @fprintf(ptr noundef %230, ptr noundef nonnull @.str.5, double noundef %232) #8
  %234 = add nuw nsw i64 %222, 1
  %235 = icmp eq i64 %234, 124
  br i1 %235, label %236, label %221, !llvm.loop !42

236:                                              ; preds = %229
  %237 = load ptr, ptr @__stderrp, align 8, !tbaa !40
  %238 = tail call i32 (ptr, ptr, ...) @fprintf(ptr noundef %237, ptr noundef nonnull @.str.6, ptr noundef nonnull @.str.3) #8
  %239 = load ptr, ptr @__stderrp, align 8, !tbaa !40
  %240 = tail call i64 @fwrite(ptr nonnull @.str.7, i64 22, i64 1, ptr %239)
  br label %241

241:                                              ; preds = %236, %212, %210
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

; Function Attrs: mustprogress nocallback nofree nosync nounwind speculatable willreturn memory(none)
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
declare <2 x double> @llvm.fmuladd.v2f64(<2 x double>, <2 x double>, <2 x double>) #7

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare double @llvm.vector.reduce.fadd.v2f64(double, <2 x double>) #7

attributes #0 = { nounwind ssp uwtable(sync) "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+ccpp,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a" }
attributes #1 = { "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+ccpp,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a" }
attributes #2 = { mustprogress nounwind willreturn allockind("free") memory(argmem: readwrite, inaccessiblemem: readwrite) "alloc-family"="malloc" "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+ccpp,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a" }
attributes #3 = { mustprogress nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #4 = { nofree nounwind "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+ccpp,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a" }
attributes #5 = { nofree nounwind }
attributes #6 = { nocallback nofree nounwind willreturn memory(argmem: write) }
attributes #7 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #8 = { nounwind }

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
!14 = distinct !{!14, !11, !12, !13}
!15 = distinct !{!15, !11}
!16 = !{!17}
!17 = distinct !{!17, !18}
!18 = distinct !{!18, !"LVerDomain"}
!19 = !{!20}
!20 = distinct !{!20, !18}
!21 = distinct !{!21, !11, !12, !13}
!22 = !{!23}
!23 = distinct !{!23, !18}
!24 = !{!17, !20}
!25 = distinct !{!25, !11, !12}
!26 = !{!27}
!27 = distinct !{!27, !28}
!28 = distinct !{!28, !"LVerDomain"}
!29 = !{!30}
!30 = distinct !{!30, !28}
!31 = !{!32, !27}
!32 = distinct !{!32, !28}
!33 = !{!32}
!34 = distinct !{!34, !11, !12, !13}
!35 = distinct !{!35, !11, !12}
!36 = distinct !{!36, !11}
!37 = !{!38, !38, i64 0}
!38 = !{!"p1 omnipotent char", !39, i64 0}
!39 = !{!"any pointer", !8, i64 0}
!40 = !{!41, !41, i64 0}
!41 = !{!"p1 _ZTS7__sFILE", !39, i64 0}
!42 = distinct !{!42, !11}
