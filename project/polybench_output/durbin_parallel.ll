; ModuleID = 'polybench_output/durbin.ll'
source_filename = "./polybench/linear-algebra/solvers/durbin/durbin.c"
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
  %3 = alloca [120 x double], align 8
  %4 = tail call ptr @polybench_alloc_data(i64 noundef 120, i32 noundef 8) #8
  %5 = tail call ptr @polybench_alloc_data(i64 noundef 120, i32 noundef 8) #8
  br label %6

6:                                                ; preds = %6, %2
  %7 = phi i64 [ 0, %2 ], [ %21, %6 ]
  %8 = phi <2 x i32> [ <i32 0, i32 1>, %2 ], [ %22, %6 ]
  %9 = sub <2 x i32> splat (i32 121), %8
  %10 = sub <2 x i32> splat (i32 119), %8
  %11 = sub <2 x i32> splat (i32 117), %8
  %12 = sub <2 x i32> splat (i32 115), %8
  %13 = uitofp nneg <2 x i32> %9 to <2 x double>
  %14 = uitofp nneg <2 x i32> %10 to <2 x double>
  %15 = uitofp nneg <2 x i32> %11 to <2 x double>
  %16 = uitofp nneg <2 x i32> %12 to <2 x double>
  %17 = getelementptr inbounds nuw double, ptr %4, i64 %7
  %18 = getelementptr inbounds nuw i8, ptr %17, i64 16
  %19 = getelementptr inbounds nuw i8, ptr %17, i64 32
  %20 = getelementptr inbounds nuw i8, ptr %17, i64 48
  store <2 x double> %13, ptr %17, align 8, !tbaa !6
  store <2 x double> %14, ptr %18, align 8, !tbaa !6
  store <2 x double> %15, ptr %19, align 8, !tbaa !6
  store <2 x double> %16, ptr %20, align 8, !tbaa !6
  %21 = add nuw i64 %7, 8
  %22 = add <2 x i32> %8, splat (i32 8)
  %23 = icmp eq i64 %21, 120
  br i1 %23, label %24, label %6, !llvm.loop !10

24:                                               ; preds = %6
  tail call void @polybench_timer_start() #8
  call void @llvm.lifetime.start.p0(i64 960, ptr nonnull %3) #8
  %25 = load double, ptr %4, align 8, !tbaa !6
  %26 = fneg double %25
  store double %26, ptr %5, align 8, !tbaa !6
  %27 = load double, ptr %4, align 8, !tbaa !6
  %28 = fneg double %27
  br label %29

29:                                               ; preds = %153, %24
  %30 = phi i64 [ 1, %24 ], [ %156, %153 ]
  %31 = phi i64 [ 0, %24 ], [ %157, %153 ]
  %32 = phi double [ 1.000000e+00, %24 ], [ %93, %153 ]
  %33 = phi double [ %28, %24 ], [ %97, %153 ]
  %34 = getelementptr double, ptr %4, i64 %30
  %35 = icmp samesign ult i64 %30, 8
  br i1 %35, label %75, label %36

36:                                               ; preds = %29
  %37 = and i64 %30, 9223372036854775800
  br label %38

38:                                               ; preds = %38, %36
  %39 = phi i64 [ 0, %36 ], [ %71, %38 ]
  %40 = phi double [ 0.000000e+00, %36 ], [ %70, %38 ]
  %41 = xor i64 %39, -1
  %42 = getelementptr double, ptr %34, i64 %41
  %43 = getelementptr i8, ptr %42, i64 -8
  %44 = getelementptr i8, ptr %42, i64 -24
  %45 = getelementptr i8, ptr %42, i64 -40
  %46 = getelementptr i8, ptr %42, i64 -56
  %47 = load <2 x double>, ptr %43, align 8, !tbaa !6
  %48 = shufflevector <2 x double> %47, <2 x double> poison, <2 x i32> <i32 1, i32 0>
  %49 = load <2 x double>, ptr %44, align 8, !tbaa !6
  %50 = shufflevector <2 x double> %49, <2 x double> poison, <2 x i32> <i32 1, i32 0>
  %51 = load <2 x double>, ptr %45, align 8, !tbaa !6
  %52 = shufflevector <2 x double> %51, <2 x double> poison, <2 x i32> <i32 1, i32 0>
  %53 = load <2 x double>, ptr %46, align 8, !tbaa !6
  %54 = shufflevector <2 x double> %53, <2 x double> poison, <2 x i32> <i32 1, i32 0>
  %55 = getelementptr inbounds nuw double, ptr %5, i64 %39
  %56 = getelementptr inbounds nuw i8, ptr %55, i64 16
  %57 = getelementptr inbounds nuw i8, ptr %55, i64 32
  %58 = getelementptr inbounds nuw i8, ptr %55, i64 48
  %59 = load <2 x double>, ptr %55, align 8, !tbaa !6
  %60 = load <2 x double>, ptr %56, align 8, !tbaa !6
  %61 = load <2 x double>, ptr %57, align 8, !tbaa !6
  %62 = load <2 x double>, ptr %58, align 8, !tbaa !6
  %63 = fmul <2 x double> %48, %59
  %64 = fmul <2 x double> %50, %60
  %65 = fmul <2 x double> %52, %61
  %66 = fmul <2 x double> %54, %62
  %67 = tail call double @llvm.vector.reduce.fadd.v2f64(double %40, <2 x double> %63)
  %68 = tail call double @llvm.vector.reduce.fadd.v2f64(double %67, <2 x double> %64)
  %69 = tail call double @llvm.vector.reduce.fadd.v2f64(double %68, <2 x double> %65)
  %70 = tail call double @llvm.vector.reduce.fadd.v2f64(double %69, <2 x double> %66)
  %71 = add nuw i64 %39, 8
  %72 = icmp eq i64 %71, %37
  br i1 %72, label %73, label %38, !llvm.loop !14

73:                                               ; preds = %38
  %74 = icmp eq i64 %30, %37
  br i1 %74, label %89, label %75

75:                                               ; preds = %73, %29
  %76 = phi i64 [ 0, %29 ], [ %37, %73 ]
  %77 = phi double [ 0.000000e+00, %29 ], [ %70, %73 ]
  br label %78

78:                                               ; preds = %78, %75
  %79 = phi i64 [ %87, %78 ], [ %76, %75 ]
  %80 = phi double [ %86, %78 ], [ %77, %75 ]
  %81 = xor i64 %79, -1
  %82 = getelementptr double, ptr %34, i64 %81
  %83 = load double, ptr %82, align 8, !tbaa !6
  %84 = getelementptr inbounds nuw double, ptr %5, i64 %79
  %85 = load double, ptr %84, align 8, !tbaa !6
  %86 = tail call double @llvm.fmuladd.f64(double %83, double %85, double %80)
  %87 = add nuw nsw i64 %79, 1
  %88 = icmp eq i64 %87, %30
  br i1 %88, label %.loopexit1, label %78, !llvm.loop !15

.loopexit1:                                       ; preds = %78
  br label %89

89:                                               ; preds = %.loopexit1, %73
  %90 = phi double [ %70, %73 ], [ %86, %.loopexit1 ]
  %91 = fneg double %33
  %92 = tail call double @llvm.fmuladd.f64(double %91, double %33, double 1.000000e+00)
  %93 = fmul double %32, %92
  %94 = load double, ptr %34, align 8, !tbaa !6
  %95 = fadd double %90, %94
  %96 = fneg double %95
  %97 = fdiv double %96, %93
  %98 = getelementptr double, ptr %5, i64 %30
  %99 = icmp samesign ult i64 %30, 8
  br i1 %99, label %140, label %100

100:                                              ; preds = %89
  %101 = and i64 %30, 9223372036854775800
  %102 = insertelement <2 x double> poison, double %97, i64 0
  %103 = shufflevector <2 x double> %102, <2 x double> poison, <2 x i32> zeroinitializer
  br label %104

104:                                              ; preds = %104, %100
  %105 = phi i64 [ 0, %100 ], [ %136, %104 ]
  %106 = getelementptr inbounds nuw double, ptr %5, i64 %105
  %107 = getelementptr inbounds nuw i8, ptr %106, i64 16
  %108 = getelementptr inbounds nuw i8, ptr %106, i64 32
  %109 = getelementptr inbounds nuw i8, ptr %106, i64 48
  %110 = load <2 x double>, ptr %106, align 8, !tbaa !6
  %111 = load <2 x double>, ptr %107, align 8, !tbaa !6
  %112 = load <2 x double>, ptr %108, align 8, !tbaa !6
  %113 = load <2 x double>, ptr %109, align 8, !tbaa !6
  %114 = xor i64 %105, -1
  %115 = getelementptr double, ptr %98, i64 %114
  %116 = getelementptr i8, ptr %115, i64 -8
  %117 = getelementptr i8, ptr %115, i64 -24
  %118 = getelementptr i8, ptr %115, i64 -40
  %119 = getelementptr i8, ptr %115, i64 -56
  %120 = load <2 x double>, ptr %116, align 8, !tbaa !6
  %121 = shufflevector <2 x double> %120, <2 x double> poison, <2 x i32> <i32 1, i32 0>
  %122 = load <2 x double>, ptr %117, align 8, !tbaa !6
  %123 = shufflevector <2 x double> %122, <2 x double> poison, <2 x i32> <i32 1, i32 0>
  %124 = load <2 x double>, ptr %118, align 8, !tbaa !6
  %125 = shufflevector <2 x double> %124, <2 x double> poison, <2 x i32> <i32 1, i32 0>
  %126 = load <2 x double>, ptr %119, align 8, !tbaa !6
  %127 = shufflevector <2 x double> %126, <2 x double> poison, <2 x i32> <i32 1, i32 0>
  %128 = tail call <2 x double> @llvm.fmuladd.v2f64(<2 x double> %103, <2 x double> %121, <2 x double> %110)
  %129 = tail call <2 x double> @llvm.fmuladd.v2f64(<2 x double> %103, <2 x double> %123, <2 x double> %111)
  %130 = tail call <2 x double> @llvm.fmuladd.v2f64(<2 x double> %103, <2 x double> %125, <2 x double> %112)
  %131 = tail call <2 x double> @llvm.fmuladd.v2f64(<2 x double> %103, <2 x double> %127, <2 x double> %113)
  %132 = getelementptr inbounds nuw [120 x double], ptr %3, i64 0, i64 %105
  %133 = getelementptr inbounds nuw i8, ptr %132, i64 16
  %134 = getelementptr inbounds nuw i8, ptr %132, i64 32
  %135 = getelementptr inbounds nuw i8, ptr %132, i64 48
  store <2 x double> %128, ptr %132, align 8, !tbaa !6
  store <2 x double> %129, ptr %133, align 8, !tbaa !6
  store <2 x double> %130, ptr %134, align 8, !tbaa !6
  store <2 x double> %131, ptr %135, align 8, !tbaa !6
  %136 = add nuw i64 %105, 8
  %137 = icmp eq i64 %136, %101
  br i1 %137, label %138, label %104, !llvm.loop !16

138:                                              ; preds = %104
  %139 = icmp eq i64 %30, %101
  br i1 %139, label %153, label %140

140:                                              ; preds = %138, %89
  %141 = phi i64 [ 0, %89 ], [ %101, %138 ]
  br label %142

142:                                              ; preds = %142, %140
  %143 = phi i64 [ %151, %142 ], [ %141, %140 ]
  %144 = getelementptr inbounds nuw double, ptr %5, i64 %143
  %145 = load double, ptr %144, align 8, !tbaa !6
  %146 = xor i64 %143, -1
  %147 = getelementptr double, ptr %98, i64 %146
  %148 = load double, ptr %147, align 8, !tbaa !6
  %149 = tail call double @llvm.fmuladd.f64(double %97, double %148, double %145)
  %150 = getelementptr inbounds nuw [120 x double], ptr %3, i64 0, i64 %143
  store double %149, ptr %150, align 8, !tbaa !6
  %151 = add nuw nsw i64 %143, 1
  %152 = icmp eq i64 %151, %30
  br i1 %152, label %.loopexit, label %142, !llvm.loop !17

.loopexit:                                        ; preds = %142
  br label %153

153:                                              ; preds = %.loopexit, %138
  %154 = shl nuw nsw i64 %31, 3
  %155 = add nuw nsw i64 %154, 8
  call void @llvm.memcpy.p0.p0.i64(ptr noundef nonnull align 8 dereferenceable(1) %5, ptr noundef nonnull align 8 dereferenceable(1) %3, i64 %155, i1 false), !tbaa !6
  store double %97, ptr %98, align 8, !tbaa !6
  %156 = add nuw nsw i64 %30, 1
  %157 = add nuw nsw i64 %31, 1
  %158 = icmp eq i64 %157, 119
  br i1 %158, label %159, label %29, !llvm.loop !18

159:                                              ; preds = %153
  call void @llvm.lifetime.end.p0(i64 960, ptr nonnull %3) #8
  tail call void @polybench_timer_stop() #8
  tail call void @polybench_timer_print() #8
  %160 = icmp sgt i32 %0, 42
  br i1 %160, label %161, label %190

161:                                              ; preds = %159
  %162 = load ptr, ptr %1, align 8, !tbaa !19
  %163 = load i8, ptr %162, align 1
  %164 = icmp eq i8 %163, 0
  br i1 %164, label %165, label %190

165:                                              ; preds = %161
  %166 = load ptr, ptr @__stderrp, align 8, !tbaa !22
  %167 = tail call i64 @fwrite(ptr nonnull @.str.1, i64 22, i64 1, ptr %166)
  %168 = load ptr, ptr @__stderrp, align 8, !tbaa !22
  %169 = tail call i32 (ptr, ptr, ...) @fprintf(ptr noundef %168, ptr noundef nonnull @.str.2, ptr noundef nonnull @.str.3) #8
  br label %170

170:                                              ; preds = %178, %165
  %171 = phi i64 [ 0, %165 ], [ %183, %178 ]
  %172 = trunc i64 %171 to i8
  %173 = urem i8 %172, 20
  %174 = icmp eq i8 %173, 0
  br i1 %174, label %175, label %178

175:                                              ; preds = %170
  %176 = load ptr, ptr @__stderrp, align 8, !tbaa !22
  %177 = tail call i32 @fputc(i32 10, ptr %176)
  br label %178

178:                                              ; preds = %175, %170
  %179 = load ptr, ptr @__stderrp, align 8, !tbaa !22
  %180 = getelementptr inbounds nuw double, ptr %5, i64 %171
  %181 = load double, ptr %180, align 8, !tbaa !6
  %182 = tail call i32 (ptr, ptr, ...) @fprintf(ptr noundef %179, ptr noundef nonnull @.str.5, double noundef %181) #8
  %183 = add nuw nsw i64 %171, 1
  %184 = icmp eq i64 %183, 120
  br i1 %184, label %185, label %170, !llvm.loop !24

185:                                              ; preds = %178
  %186 = load ptr, ptr @__stderrp, align 8, !tbaa !22
  %187 = tail call i32 (ptr, ptr, ...) @fprintf(ptr noundef %186, ptr noundef nonnull @.str.6, ptr noundef nonnull @.str.3) #8
  %188 = load ptr, ptr @__stderrp, align 8, !tbaa !22
  %189 = tail call i64 @fwrite(ptr nonnull @.str.7, i64 22, i64 1, ptr %188)
  br label %190

190:                                              ; preds = %185, %161, %159
  tail call void @free(ptr noundef %4)
  tail call void @free(ptr noundef nonnull %5)
  ret i32 0
}

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.start.p0(i64 immarg, ptr captures(none)) #1

declare ptr @polybench_alloc_data(i64 noundef, i32 noundef) local_unnamed_addr #2

declare void @polybench_timer_start(...) local_unnamed_addr #2

declare void @polybench_timer_stop(...) local_unnamed_addr #2

declare void @polybench_timer_print(...) local_unnamed_addr #2

; Function Attrs: mustprogress nounwind willreturn allockind("free") memory(argmem: readwrite, inaccessiblemem: readwrite)
declare void @free(ptr allocptr noundef captures(none)) local_unnamed_addr #3

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.end.p0(i64 immarg, ptr captures(none)) #1

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare double @llvm.fmuladd.f64(double, double, double) #4

; Function Attrs: nofree nounwind
declare noundef i32 @fprintf(ptr noundef captures(none), ptr noundef readonly captures(none), ...) local_unnamed_addr #5

; Function Attrs: nofree nounwind
declare noundef i64 @fwrite(ptr noundef readonly captures(none), i64 noundef, i64 noundef, ptr noundef captures(none)) local_unnamed_addr #6

; Function Attrs: nofree nounwind
declare noundef i32 @fputc(i32 noundef, ptr noundef captures(none)) local_unnamed_addr #6

; Function Attrs: nocallback nofree nounwind willreturn memory(argmem: readwrite)
declare void @llvm.memcpy.p0.p0.i64(ptr noalias writeonly captures(none), ptr noalias readonly captures(none), i64, i1 immarg) #7

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare <2 x double> @llvm.fmuladd.v2f64(<2 x double>, <2 x double>, <2 x double>) #4

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare double @llvm.vector.reduce.fadd.v2f64(double, <2 x double>) #4

attributes #0 = { nounwind ssp uwtable(sync) "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+ccpp,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a" }
attributes #1 = { nocallback nofree nosync nounwind willreturn memory(argmem: readwrite) }
attributes #2 = { "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+ccpp,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a" }
attributes #3 = { mustprogress nounwind willreturn allockind("free") memory(argmem: readwrite, inaccessiblemem: readwrite) "alloc-family"="malloc" "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+ccpp,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a" }
attributes #4 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #5 = { nofree nounwind "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+ccpp,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a" }
attributes #6 = { nofree nounwind }
attributes #7 = { nocallback nofree nounwind willreturn memory(argmem: readwrite) }
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
!15 = distinct !{!15, !11, !13, !12}
!16 = distinct !{!16, !11, !12, !13}
!17 = distinct !{!17, !11, !13, !12}
!18 = distinct !{!18, !11}
!19 = !{!20, !20, i64 0}
!20 = !{!"p1 omnipotent char", !21, i64 0}
!21 = !{!"any pointer", !8, i64 0}
!22 = !{!23, !23, i64 0}
!23 = !{!"p1 _ZTS7__sFILE", !21, i64 0}
!24 = distinct !{!24, !11}
