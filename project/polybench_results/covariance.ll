; ModuleID = './polybench/datamining/covariance/covariance.c'
source_filename = "./polybench/datamining/covariance/covariance.c"
target datalayout = "e-m:o-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-n32:64-S128-Fn32"
target triple = "arm64-apple-macosx15.0.0"

@__stderrp = external local_unnamed_addr global ptr, align 8
@.str.1 = private unnamed_addr constant [23 x i8] c"==BEGIN DUMP_ARRAYS==\0A\00", align 1
@.str.2 = private unnamed_addr constant [15 x i8] c"begin dump: %s\00", align 1
@.str.3 = private unnamed_addr constant [4 x i8] c"cov\00", align 1
@.str.5 = private unnamed_addr constant [8 x i8] c"%0.2lf \00", align 1
@.str.6 = private unnamed_addr constant [17 x i8] c"\0Aend   dump: %s\0A\00", align 1
@.str.7 = private unnamed_addr constant [23 x i8] c"==END   DUMP_ARRAYS==\0A\00", align 1

; Function Attrs: nounwind ssp uwtable(sync)
define noundef i32 @main(i32 noundef %0, ptr noundef readonly captures(none) %1) local_unnamed_addr #0 {
  %3 = tail call ptr @polybench_alloc_data(i64 noundef 8000, i32 noundef 8) #6
  %4 = tail call ptr @polybench_alloc_data(i64 noundef 6400, i32 noundef 8) #6
  %5 = tail call ptr @polybench_alloc_data(i64 noundef 80, i32 noundef 8) #6
  br label %6

6:                                                ; preds = %2, %35
  %7 = phi i64 [ 0, %2 ], [ %36, %35 ]
  br label %8

8:                                                ; preds = %8, %6
  %9 = phi i64 [ 0, %6 ], [ %33, %8 ]
  %10 = or disjoint i64 %9, 1
  %11 = or disjoint i64 %9, 2
  %12 = or disjoint i64 %9, 3
  %13 = mul nuw nsw i64 %9, %7
  %14 = mul nuw nsw i64 %10, %7
  %15 = mul nuw nsw i64 %11, %7
  %16 = mul nuw nsw i64 %12, %7
  %17 = trunc nuw nsw i64 %13 to i32
  %18 = trunc nuw nsw i64 %14 to i32
  %19 = trunc nuw nsw i64 %15 to i32
  %20 = trunc nuw nsw i64 %16 to i32
  %21 = uitofp nneg i32 %17 to double
  %22 = uitofp nneg i32 %18 to double
  %23 = uitofp nneg i32 %19 to double
  %24 = uitofp nneg i32 %20 to double
  %25 = fdiv double %21, 8.000000e+01
  %26 = fdiv double %22, 8.000000e+01
  %27 = fdiv double %23, 8.000000e+01
  %28 = fdiv double %24, 8.000000e+01
  %29 = getelementptr inbounds nuw [80 x double], ptr %3, i64 %7, i64 %9
  %30 = getelementptr inbounds nuw [80 x double], ptr %3, i64 %7, i64 %10
  %31 = getelementptr inbounds nuw [80 x double], ptr %3, i64 %7, i64 %11
  %32 = getelementptr inbounds nuw [80 x double], ptr %3, i64 %7, i64 %12
  store double %25, ptr %29, align 8, !tbaa !6
  store double %26, ptr %30, align 8, !tbaa !6
  store double %27, ptr %31, align 8, !tbaa !6
  store double %28, ptr %32, align 8, !tbaa !6
  %33 = add nuw i64 %9, 4
  %34 = icmp eq i64 %33, 80
  br i1 %34, label %35, label %8, !llvm.loop !10

35:                                               ; preds = %8
  %36 = add nuw nsw i64 %7, 1
  %37 = icmp eq i64 %36, 100
  br i1 %37, label %38, label %6, !llvm.loop !14

38:                                               ; preds = %35
  tail call void @polybench_timer_start() #6
  br label %39

39:                                               ; preds = %50, %38
  %40 = phi i64 [ 0, %38 ], [ %52, %50 ]
  %41 = getelementptr inbounds nuw double, ptr %5, i64 %40
  store double 0.000000e+00, ptr %41, align 8, !tbaa !6
  br label %42

42:                                               ; preds = %42, %39
  %43 = phi i64 [ 0, %39 ], [ %48, %42 ]
  %44 = phi double [ 0.000000e+00, %39 ], [ %47, %42 ]
  %45 = getelementptr inbounds nuw [80 x double], ptr %3, i64 %43, i64 %40
  %46 = load double, ptr %45, align 8, !tbaa !6
  %47 = fadd double %44, %46
  store double %47, ptr %41, align 8, !tbaa !6
  %48 = add nuw nsw i64 %43, 1
  %49 = icmp eq i64 %48, 100
  br i1 %49, label %50, label %42, !llvm.loop !15

50:                                               ; preds = %42
  %51 = fdiv double %47, 1.000000e+02
  store double %51, ptr %41, align 8, !tbaa !6
  %52 = add nuw nsw i64 %40, 1
  %53 = icmp eq i64 %52, 80
  br i1 %53, label %54, label %39, !llvm.loop !16

54:                                               ; preds = %50
  %55 = getelementptr i8, ptr %3, i64 64000
  %56 = getelementptr i8, ptr %5, i64 640
  %57 = icmp ult ptr %3, %56
  %58 = icmp ult ptr %5, %55
  %59 = and i1 %57, %58
  %60 = getelementptr inbounds nuw i8, ptr %5, i64 16
  %61 = getelementptr inbounds nuw i8, ptr %5, i64 32
  %62 = getelementptr inbounds nuw i8, ptr %5, i64 48
  %63 = getelementptr inbounds nuw i8, ptr %5, i64 64
  %64 = getelementptr inbounds nuw i8, ptr %5, i64 80
  %65 = getelementptr inbounds nuw i8, ptr %5, i64 96
  %66 = getelementptr inbounds nuw i8, ptr %5, i64 112
  %67 = getelementptr inbounds nuw i8, ptr %5, i64 128
  %68 = getelementptr inbounds nuw i8, ptr %5, i64 144
  %69 = getelementptr inbounds nuw i8, ptr %5, i64 160
  %70 = getelementptr inbounds nuw i8, ptr %5, i64 176
  %71 = getelementptr inbounds nuw i8, ptr %5, i64 192
  %72 = getelementptr inbounds nuw i8, ptr %5, i64 208
  %73 = getelementptr inbounds nuw i8, ptr %5, i64 224
  %74 = getelementptr inbounds nuw i8, ptr %5, i64 240
  %75 = getelementptr inbounds nuw i8, ptr %5, i64 256
  %76 = getelementptr inbounds nuw i8, ptr %5, i64 272
  %77 = getelementptr inbounds nuw i8, ptr %5, i64 288
  %78 = getelementptr inbounds nuw i8, ptr %5, i64 304
  %79 = getelementptr inbounds nuw i8, ptr %5, i64 320
  %80 = getelementptr inbounds nuw i8, ptr %5, i64 336
  %81 = getelementptr inbounds nuw i8, ptr %5, i64 352
  %82 = getelementptr inbounds nuw i8, ptr %5, i64 368
  %83 = getelementptr inbounds nuw i8, ptr %5, i64 384
  %84 = getelementptr inbounds nuw i8, ptr %5, i64 400
  %85 = getelementptr inbounds nuw i8, ptr %5, i64 416
  %86 = getelementptr inbounds nuw i8, ptr %5, i64 432
  %87 = getelementptr inbounds nuw i8, ptr %5, i64 448
  %88 = getelementptr inbounds nuw i8, ptr %5, i64 464
  %89 = getelementptr inbounds nuw i8, ptr %5, i64 480
  %90 = getelementptr inbounds nuw i8, ptr %5, i64 496
  %91 = getelementptr inbounds nuw i8, ptr %5, i64 512
  %92 = getelementptr inbounds nuw i8, ptr %5, i64 528
  %93 = getelementptr inbounds nuw i8, ptr %5, i64 544
  %94 = getelementptr inbounds nuw i8, ptr %5, i64 560
  %95 = getelementptr inbounds nuw i8, ptr %5, i64 576
  %96 = getelementptr inbounds nuw i8, ptr %5, i64 592
  %97 = getelementptr inbounds nuw i8, ptr %5, i64 608
  %98 = getelementptr inbounds nuw i8, ptr %5, i64 624
  br label %99

99:                                               ; preds = %271, %54
  %100 = phi i64 [ %272, %271 ], [ 0, %54 ]
  br i1 %59, label %262, label %101

101:                                              ; preds = %99
  %102 = load <2 x double>, ptr %5, align 8, !tbaa !6, !alias.scope !17
  %103 = load <2 x double>, ptr %60, align 8, !tbaa !6, !alias.scope !17
  %104 = load <2 x double>, ptr %61, align 8, !tbaa !6, !alias.scope !17
  %105 = load <2 x double>, ptr %62, align 8, !tbaa !6, !alias.scope !17
  %106 = getelementptr inbounds nuw [80 x double], ptr %3, i64 %100, i64 0
  %107 = getelementptr inbounds nuw i8, ptr %106, i64 16
  %108 = getelementptr inbounds nuw i8, ptr %106, i64 32
  %109 = getelementptr inbounds nuw i8, ptr %106, i64 48
  %110 = load <2 x double>, ptr %106, align 8, !tbaa !6, !alias.scope !20, !noalias !17
  %111 = load <2 x double>, ptr %107, align 8, !tbaa !6, !alias.scope !20, !noalias !17
  %112 = load <2 x double>, ptr %108, align 8, !tbaa !6, !alias.scope !20, !noalias !17
  %113 = load <2 x double>, ptr %109, align 8, !tbaa !6, !alias.scope !20, !noalias !17
  %114 = fsub <2 x double> %110, %102
  %115 = fsub <2 x double> %111, %103
  %116 = fsub <2 x double> %112, %104
  %117 = fsub <2 x double> %113, %105
  store <2 x double> %114, ptr %106, align 8, !tbaa !6, !alias.scope !20, !noalias !17
  store <2 x double> %115, ptr %107, align 8, !tbaa !6, !alias.scope !20, !noalias !17
  store <2 x double> %116, ptr %108, align 8, !tbaa !6, !alias.scope !20, !noalias !17
  store <2 x double> %117, ptr %109, align 8, !tbaa !6, !alias.scope !20, !noalias !17
  %118 = load <2 x double>, ptr %63, align 8, !tbaa !6, !alias.scope !17
  %119 = load <2 x double>, ptr %64, align 8, !tbaa !6, !alias.scope !17
  %120 = load <2 x double>, ptr %65, align 8, !tbaa !6, !alias.scope !17
  %121 = load <2 x double>, ptr %66, align 8, !tbaa !6, !alias.scope !17
  %122 = getelementptr inbounds nuw [80 x double], ptr %3, i64 %100, i64 8
  %123 = getelementptr inbounds nuw i8, ptr %122, i64 16
  %124 = getelementptr inbounds nuw i8, ptr %122, i64 32
  %125 = getelementptr inbounds nuw i8, ptr %122, i64 48
  %126 = load <2 x double>, ptr %122, align 8, !tbaa !6, !alias.scope !20, !noalias !17
  %127 = load <2 x double>, ptr %123, align 8, !tbaa !6, !alias.scope !20, !noalias !17
  %128 = load <2 x double>, ptr %124, align 8, !tbaa !6, !alias.scope !20, !noalias !17
  %129 = load <2 x double>, ptr %125, align 8, !tbaa !6, !alias.scope !20, !noalias !17
  %130 = fsub <2 x double> %126, %118
  %131 = fsub <2 x double> %127, %119
  %132 = fsub <2 x double> %128, %120
  %133 = fsub <2 x double> %129, %121
  store <2 x double> %130, ptr %122, align 8, !tbaa !6, !alias.scope !20, !noalias !17
  store <2 x double> %131, ptr %123, align 8, !tbaa !6, !alias.scope !20, !noalias !17
  store <2 x double> %132, ptr %124, align 8, !tbaa !6, !alias.scope !20, !noalias !17
  store <2 x double> %133, ptr %125, align 8, !tbaa !6, !alias.scope !20, !noalias !17
  %134 = load <2 x double>, ptr %67, align 8, !tbaa !6, !alias.scope !17
  %135 = load <2 x double>, ptr %68, align 8, !tbaa !6, !alias.scope !17
  %136 = load <2 x double>, ptr %69, align 8, !tbaa !6, !alias.scope !17
  %137 = load <2 x double>, ptr %70, align 8, !tbaa !6, !alias.scope !17
  %138 = getelementptr inbounds nuw [80 x double], ptr %3, i64 %100, i64 16
  %139 = getelementptr inbounds nuw i8, ptr %138, i64 16
  %140 = getelementptr inbounds nuw i8, ptr %138, i64 32
  %141 = getelementptr inbounds nuw i8, ptr %138, i64 48
  %142 = load <2 x double>, ptr %138, align 8, !tbaa !6, !alias.scope !20, !noalias !17
  %143 = load <2 x double>, ptr %139, align 8, !tbaa !6, !alias.scope !20, !noalias !17
  %144 = load <2 x double>, ptr %140, align 8, !tbaa !6, !alias.scope !20, !noalias !17
  %145 = load <2 x double>, ptr %141, align 8, !tbaa !6, !alias.scope !20, !noalias !17
  %146 = fsub <2 x double> %142, %134
  %147 = fsub <2 x double> %143, %135
  %148 = fsub <2 x double> %144, %136
  %149 = fsub <2 x double> %145, %137
  store <2 x double> %146, ptr %138, align 8, !tbaa !6, !alias.scope !20, !noalias !17
  store <2 x double> %147, ptr %139, align 8, !tbaa !6, !alias.scope !20, !noalias !17
  store <2 x double> %148, ptr %140, align 8, !tbaa !6, !alias.scope !20, !noalias !17
  store <2 x double> %149, ptr %141, align 8, !tbaa !6, !alias.scope !20, !noalias !17
  %150 = load <2 x double>, ptr %71, align 8, !tbaa !6, !alias.scope !17
  %151 = load <2 x double>, ptr %72, align 8, !tbaa !6, !alias.scope !17
  %152 = load <2 x double>, ptr %73, align 8, !tbaa !6, !alias.scope !17
  %153 = load <2 x double>, ptr %74, align 8, !tbaa !6, !alias.scope !17
  %154 = getelementptr inbounds nuw [80 x double], ptr %3, i64 %100, i64 24
  %155 = getelementptr inbounds nuw i8, ptr %154, i64 16
  %156 = getelementptr inbounds nuw i8, ptr %154, i64 32
  %157 = getelementptr inbounds nuw i8, ptr %154, i64 48
  %158 = load <2 x double>, ptr %154, align 8, !tbaa !6, !alias.scope !20, !noalias !17
  %159 = load <2 x double>, ptr %155, align 8, !tbaa !6, !alias.scope !20, !noalias !17
  %160 = load <2 x double>, ptr %156, align 8, !tbaa !6, !alias.scope !20, !noalias !17
  %161 = load <2 x double>, ptr %157, align 8, !tbaa !6, !alias.scope !20, !noalias !17
  %162 = fsub <2 x double> %158, %150
  %163 = fsub <2 x double> %159, %151
  %164 = fsub <2 x double> %160, %152
  %165 = fsub <2 x double> %161, %153
  store <2 x double> %162, ptr %154, align 8, !tbaa !6, !alias.scope !20, !noalias !17
  store <2 x double> %163, ptr %155, align 8, !tbaa !6, !alias.scope !20, !noalias !17
  store <2 x double> %164, ptr %156, align 8, !tbaa !6, !alias.scope !20, !noalias !17
  store <2 x double> %165, ptr %157, align 8, !tbaa !6, !alias.scope !20, !noalias !17
  %166 = load <2 x double>, ptr %75, align 8, !tbaa !6, !alias.scope !17
  %167 = load <2 x double>, ptr %76, align 8, !tbaa !6, !alias.scope !17
  %168 = load <2 x double>, ptr %77, align 8, !tbaa !6, !alias.scope !17
  %169 = load <2 x double>, ptr %78, align 8, !tbaa !6, !alias.scope !17
  %170 = getelementptr inbounds nuw [80 x double], ptr %3, i64 %100, i64 32
  %171 = getelementptr inbounds nuw i8, ptr %170, i64 16
  %172 = getelementptr inbounds nuw i8, ptr %170, i64 32
  %173 = getelementptr inbounds nuw i8, ptr %170, i64 48
  %174 = load <2 x double>, ptr %170, align 8, !tbaa !6, !alias.scope !20, !noalias !17
  %175 = load <2 x double>, ptr %171, align 8, !tbaa !6, !alias.scope !20, !noalias !17
  %176 = load <2 x double>, ptr %172, align 8, !tbaa !6, !alias.scope !20, !noalias !17
  %177 = load <2 x double>, ptr %173, align 8, !tbaa !6, !alias.scope !20, !noalias !17
  %178 = fsub <2 x double> %174, %166
  %179 = fsub <2 x double> %175, %167
  %180 = fsub <2 x double> %176, %168
  %181 = fsub <2 x double> %177, %169
  store <2 x double> %178, ptr %170, align 8, !tbaa !6, !alias.scope !20, !noalias !17
  store <2 x double> %179, ptr %171, align 8, !tbaa !6, !alias.scope !20, !noalias !17
  store <2 x double> %180, ptr %172, align 8, !tbaa !6, !alias.scope !20, !noalias !17
  store <2 x double> %181, ptr %173, align 8, !tbaa !6, !alias.scope !20, !noalias !17
  %182 = load <2 x double>, ptr %79, align 8, !tbaa !6, !alias.scope !17
  %183 = load <2 x double>, ptr %80, align 8, !tbaa !6, !alias.scope !17
  %184 = load <2 x double>, ptr %81, align 8, !tbaa !6, !alias.scope !17
  %185 = load <2 x double>, ptr %82, align 8, !tbaa !6, !alias.scope !17
  %186 = getelementptr inbounds nuw [80 x double], ptr %3, i64 %100, i64 40
  %187 = getelementptr inbounds nuw i8, ptr %186, i64 16
  %188 = getelementptr inbounds nuw i8, ptr %186, i64 32
  %189 = getelementptr inbounds nuw i8, ptr %186, i64 48
  %190 = load <2 x double>, ptr %186, align 8, !tbaa !6, !alias.scope !20, !noalias !17
  %191 = load <2 x double>, ptr %187, align 8, !tbaa !6, !alias.scope !20, !noalias !17
  %192 = load <2 x double>, ptr %188, align 8, !tbaa !6, !alias.scope !20, !noalias !17
  %193 = load <2 x double>, ptr %189, align 8, !tbaa !6, !alias.scope !20, !noalias !17
  %194 = fsub <2 x double> %190, %182
  %195 = fsub <2 x double> %191, %183
  %196 = fsub <2 x double> %192, %184
  %197 = fsub <2 x double> %193, %185
  store <2 x double> %194, ptr %186, align 8, !tbaa !6, !alias.scope !20, !noalias !17
  store <2 x double> %195, ptr %187, align 8, !tbaa !6, !alias.scope !20, !noalias !17
  store <2 x double> %196, ptr %188, align 8, !tbaa !6, !alias.scope !20, !noalias !17
  store <2 x double> %197, ptr %189, align 8, !tbaa !6, !alias.scope !20, !noalias !17
  %198 = load <2 x double>, ptr %83, align 8, !tbaa !6, !alias.scope !17
  %199 = load <2 x double>, ptr %84, align 8, !tbaa !6, !alias.scope !17
  %200 = load <2 x double>, ptr %85, align 8, !tbaa !6, !alias.scope !17
  %201 = load <2 x double>, ptr %86, align 8, !tbaa !6, !alias.scope !17
  %202 = getelementptr inbounds nuw [80 x double], ptr %3, i64 %100, i64 48
  %203 = getelementptr inbounds nuw i8, ptr %202, i64 16
  %204 = getelementptr inbounds nuw i8, ptr %202, i64 32
  %205 = getelementptr inbounds nuw i8, ptr %202, i64 48
  %206 = load <2 x double>, ptr %202, align 8, !tbaa !6, !alias.scope !20, !noalias !17
  %207 = load <2 x double>, ptr %203, align 8, !tbaa !6, !alias.scope !20, !noalias !17
  %208 = load <2 x double>, ptr %204, align 8, !tbaa !6, !alias.scope !20, !noalias !17
  %209 = load <2 x double>, ptr %205, align 8, !tbaa !6, !alias.scope !20, !noalias !17
  %210 = fsub <2 x double> %206, %198
  %211 = fsub <2 x double> %207, %199
  %212 = fsub <2 x double> %208, %200
  %213 = fsub <2 x double> %209, %201
  store <2 x double> %210, ptr %202, align 8, !tbaa !6, !alias.scope !20, !noalias !17
  store <2 x double> %211, ptr %203, align 8, !tbaa !6, !alias.scope !20, !noalias !17
  store <2 x double> %212, ptr %204, align 8, !tbaa !6, !alias.scope !20, !noalias !17
  store <2 x double> %213, ptr %205, align 8, !tbaa !6, !alias.scope !20, !noalias !17
  %214 = load <2 x double>, ptr %87, align 8, !tbaa !6, !alias.scope !17
  %215 = load <2 x double>, ptr %88, align 8, !tbaa !6, !alias.scope !17
  %216 = load <2 x double>, ptr %89, align 8, !tbaa !6, !alias.scope !17
  %217 = load <2 x double>, ptr %90, align 8, !tbaa !6, !alias.scope !17
  %218 = getelementptr inbounds nuw [80 x double], ptr %3, i64 %100, i64 56
  %219 = getelementptr inbounds nuw i8, ptr %218, i64 16
  %220 = getelementptr inbounds nuw i8, ptr %218, i64 32
  %221 = getelementptr inbounds nuw i8, ptr %218, i64 48
  %222 = load <2 x double>, ptr %218, align 8, !tbaa !6, !alias.scope !20, !noalias !17
  %223 = load <2 x double>, ptr %219, align 8, !tbaa !6, !alias.scope !20, !noalias !17
  %224 = load <2 x double>, ptr %220, align 8, !tbaa !6, !alias.scope !20, !noalias !17
  %225 = load <2 x double>, ptr %221, align 8, !tbaa !6, !alias.scope !20, !noalias !17
  %226 = fsub <2 x double> %222, %214
  %227 = fsub <2 x double> %223, %215
  %228 = fsub <2 x double> %224, %216
  %229 = fsub <2 x double> %225, %217
  store <2 x double> %226, ptr %218, align 8, !tbaa !6, !alias.scope !20, !noalias !17
  store <2 x double> %227, ptr %219, align 8, !tbaa !6, !alias.scope !20, !noalias !17
  store <2 x double> %228, ptr %220, align 8, !tbaa !6, !alias.scope !20, !noalias !17
  store <2 x double> %229, ptr %221, align 8, !tbaa !6, !alias.scope !20, !noalias !17
  %230 = load <2 x double>, ptr %91, align 8, !tbaa !6, !alias.scope !17
  %231 = load <2 x double>, ptr %92, align 8, !tbaa !6, !alias.scope !17
  %232 = load <2 x double>, ptr %93, align 8, !tbaa !6, !alias.scope !17
  %233 = load <2 x double>, ptr %94, align 8, !tbaa !6, !alias.scope !17
  %234 = getelementptr inbounds nuw [80 x double], ptr %3, i64 %100, i64 64
  %235 = getelementptr inbounds nuw i8, ptr %234, i64 16
  %236 = getelementptr inbounds nuw i8, ptr %234, i64 32
  %237 = getelementptr inbounds nuw i8, ptr %234, i64 48
  %238 = load <2 x double>, ptr %234, align 8, !tbaa !6, !alias.scope !20, !noalias !17
  %239 = load <2 x double>, ptr %235, align 8, !tbaa !6, !alias.scope !20, !noalias !17
  %240 = load <2 x double>, ptr %236, align 8, !tbaa !6, !alias.scope !20, !noalias !17
  %241 = load <2 x double>, ptr %237, align 8, !tbaa !6, !alias.scope !20, !noalias !17
  %242 = fsub <2 x double> %238, %230
  %243 = fsub <2 x double> %239, %231
  %244 = fsub <2 x double> %240, %232
  %245 = fsub <2 x double> %241, %233
  store <2 x double> %242, ptr %234, align 8, !tbaa !6, !alias.scope !20, !noalias !17
  store <2 x double> %243, ptr %235, align 8, !tbaa !6, !alias.scope !20, !noalias !17
  store <2 x double> %244, ptr %236, align 8, !tbaa !6, !alias.scope !20, !noalias !17
  store <2 x double> %245, ptr %237, align 8, !tbaa !6, !alias.scope !20, !noalias !17
  %246 = load <2 x double>, ptr %95, align 8, !tbaa !6, !alias.scope !17
  %247 = load <2 x double>, ptr %96, align 8, !tbaa !6, !alias.scope !17
  %248 = load <2 x double>, ptr %97, align 8, !tbaa !6, !alias.scope !17
  %249 = load <2 x double>, ptr %98, align 8, !tbaa !6, !alias.scope !17
  %250 = getelementptr inbounds nuw [80 x double], ptr %3, i64 %100, i64 72
  %251 = getelementptr inbounds nuw i8, ptr %250, i64 16
  %252 = getelementptr inbounds nuw i8, ptr %250, i64 32
  %253 = getelementptr inbounds nuw i8, ptr %250, i64 48
  %254 = load <2 x double>, ptr %250, align 8, !tbaa !6, !alias.scope !20, !noalias !17
  %255 = load <2 x double>, ptr %251, align 8, !tbaa !6, !alias.scope !20, !noalias !17
  %256 = load <2 x double>, ptr %252, align 8, !tbaa !6, !alias.scope !20, !noalias !17
  %257 = load <2 x double>, ptr %253, align 8, !tbaa !6, !alias.scope !20, !noalias !17
  %258 = fsub <2 x double> %254, %246
  %259 = fsub <2 x double> %255, %247
  %260 = fsub <2 x double> %256, %248
  %261 = fsub <2 x double> %257, %249
  store <2 x double> %258, ptr %250, align 8, !tbaa !6, !alias.scope !20, !noalias !17
  store <2 x double> %259, ptr %251, align 8, !tbaa !6, !alias.scope !20, !noalias !17
  store <2 x double> %260, ptr %252, align 8, !tbaa !6, !alias.scope !20, !noalias !17
  store <2 x double> %261, ptr %253, align 8, !tbaa !6, !alias.scope !20, !noalias !17
  br label %271

262:                                              ; preds = %99, %262
  %263 = phi i64 [ %269, %262 ], [ 0, %99 ]
  %264 = getelementptr inbounds nuw double, ptr %5, i64 %263
  %265 = load double, ptr %264, align 8, !tbaa !6
  %266 = getelementptr inbounds nuw [80 x double], ptr %3, i64 %100, i64 %263
  %267 = load double, ptr %266, align 8, !tbaa !6
  %268 = fsub double %267, %265
  store double %268, ptr %266, align 8, !tbaa !6
  %269 = add nuw nsw i64 %263, 1
  %270 = icmp eq i64 %269, 80
  br i1 %270, label %271, label %262, !llvm.loop !22

271:                                              ; preds = %262, %101
  %272 = add nuw nsw i64 %100, 1
  %273 = icmp eq i64 %272, 100
  br i1 %273, label %274, label %99, !llvm.loop !23

274:                                              ; preds = %271, %294
  %275 = phi i64 [ %295, %294 ], [ 0, %271 ]
  br label %276

276:                                              ; preds = %289, %274
  %277 = phi i64 [ %275, %274 ], [ %292, %289 ]
  %278 = getelementptr inbounds nuw [80 x double], ptr %4, i64 %275, i64 %277
  store double 0.000000e+00, ptr %278, align 8, !tbaa !6
  br label %279

279:                                              ; preds = %279, %276
  %280 = phi i64 [ 0, %276 ], [ %287, %279 ]
  %281 = phi double [ 0.000000e+00, %276 ], [ %286, %279 ]
  %282 = getelementptr inbounds nuw [80 x double], ptr %3, i64 %280, i64 %275
  %283 = load double, ptr %282, align 8, !tbaa !6
  %284 = getelementptr inbounds nuw [80 x double], ptr %3, i64 %280, i64 %277
  %285 = load double, ptr %284, align 8, !tbaa !6
  %286 = tail call double @llvm.fmuladd.f64(double %283, double %285, double %281)
  store double %286, ptr %278, align 8, !tbaa !6
  %287 = add nuw nsw i64 %280, 1
  %288 = icmp eq i64 %287, 100
  br i1 %288, label %289, label %279, !llvm.loop !24

289:                                              ; preds = %279
  %290 = fdiv double %286, 9.900000e+01
  store double %290, ptr %278, align 8, !tbaa !6
  %291 = getelementptr inbounds nuw [80 x double], ptr %4, i64 %277, i64 %275
  store double %290, ptr %291, align 8, !tbaa !6
  %292 = add nuw nsw i64 %277, 1
  %293 = icmp eq i64 %292, 80
  br i1 %293, label %294, label %276, !llvm.loop !25

294:                                              ; preds = %289
  %295 = add nuw nsw i64 %275, 1
  %296 = icmp eq i64 %295, 80
  br i1 %296, label %297, label %274, !llvm.loop !26

297:                                              ; preds = %294
  tail call void @polybench_timer_stop() #6
  tail call void @polybench_timer_print() #6
  %298 = icmp sgt i32 %0, 42
  br i1 %298, label %299, label %335

299:                                              ; preds = %297
  %300 = load ptr, ptr %1, align 8, !tbaa !27
  %301 = load i8, ptr %300, align 1
  %302 = icmp eq i8 %301, 0
  br i1 %302, label %303, label %335

303:                                              ; preds = %299
  %304 = load ptr, ptr @__stderrp, align 8, !tbaa !30
  %305 = tail call i64 @fwrite(ptr nonnull @.str.1, i64 22, i64 1, ptr %304)
  %306 = load ptr, ptr @__stderrp, align 8, !tbaa !30
  %307 = tail call i32 (ptr, ptr, ...) @fprintf(ptr noundef %306, ptr noundef nonnull @.str.2, ptr noundef nonnull @.str.3) #6
  br label %308

308:                                              ; preds = %327, %303
  %309 = phi i64 [ 0, %303 ], [ %328, %327 ]
  %310 = mul nuw nsw i64 %309, 80
  br label %311

311:                                              ; preds = %320, %308
  %312 = phi i64 [ 0, %308 ], [ %325, %320 ]
  %313 = add nuw nsw i64 %312, %310
  %314 = trunc nuw nsw i64 %313 to i32
  %315 = urem i32 %314, 20
  %316 = icmp eq i32 %315, 0
  br i1 %316, label %317, label %320

317:                                              ; preds = %311
  %318 = load ptr, ptr @__stderrp, align 8, !tbaa !30
  %319 = tail call i32 @fputc(i32 10, ptr %318)
  br label %320

320:                                              ; preds = %317, %311
  %321 = load ptr, ptr @__stderrp, align 8, !tbaa !30
  %322 = getelementptr inbounds nuw [80 x double], ptr %4, i64 %309, i64 %312
  %323 = load double, ptr %322, align 8, !tbaa !6
  %324 = tail call i32 (ptr, ptr, ...) @fprintf(ptr noundef %321, ptr noundef nonnull @.str.5, double noundef %323) #6
  %325 = add nuw nsw i64 %312, 1
  %326 = icmp eq i64 %325, 80
  br i1 %326, label %327, label %311, !llvm.loop !32

327:                                              ; preds = %320
  %328 = add nuw nsw i64 %309, 1
  %329 = icmp eq i64 %328, 80
  br i1 %329, label %330, label %308, !llvm.loop !33

330:                                              ; preds = %327
  %331 = load ptr, ptr @__stderrp, align 8, !tbaa !30
  %332 = tail call i32 (ptr, ptr, ...) @fprintf(ptr noundef %331, ptr noundef nonnull @.str.6, ptr noundef nonnull @.str.3) #6
  %333 = load ptr, ptr @__stderrp, align 8, !tbaa !30
  %334 = tail call i64 @fwrite(ptr nonnull @.str.7, i64 22, i64 1, ptr %333)
  br label %335

335:                                              ; preds = %330, %299, %297
  tail call void @free(ptr noundef %3)
  tail call void @free(ptr noundef nonnull %4)
  tail call void @free(ptr noundef %5)
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
!17 = !{!18}
!18 = distinct !{!18, !19}
!19 = distinct !{!19, !"LVerDomain"}
!20 = !{!21}
!21 = distinct !{!21, !19}
!22 = distinct !{!22, !11, !12}
!23 = distinct !{!23, !11}
!24 = distinct !{!24, !11}
!25 = distinct !{!25, !11}
!26 = distinct !{!26, !11}
!27 = !{!28, !28, i64 0}
!28 = !{!"p1 omnipotent char", !29, i64 0}
!29 = !{!"any pointer", !8, i64 0}
!30 = !{!31, !31, i64 0}
!31 = !{!"p1 _ZTS7__sFILE", !29, i64 0}
!32 = distinct !{!32, !11}
!33 = distinct !{!33, !11}
