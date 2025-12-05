; ModuleID = 'polybench_results/symm.ll'
source_filename = "./polybench/linear-algebra/blas/symm/symm.c"
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
  %3 = tail call ptr @polybench_alloc_data(i64 noundef 4800, i32 noundef 8) #7
  %4 = ptrtoint ptr %3 to i64
  %5 = tail call ptr @polybench_alloc_data(i64 noundef 3600, i32 noundef 8) #7
  %6 = tail call ptr @polybench_alloc_data(i64 noundef 4800, i32 noundef 8) #7
  %7 = ptrtoint ptr %6 to i64
  %8 = sub i64 %7, %4
  %9 = icmp ult i64 %8, 16
  br label %10

10:                                               ; preds = %52, %2
  %11 = phi i64 [ 0, %2 ], [ %53, %52 ]
  %12 = add nuw nsw i64 %11, 80
  br i1 %9, label %.preheader, label %13

.preheader:                                       ; preds = %10
  br label %36

13:                                               ; preds = %10
  %14 = insertelement <2 x i64> poison, i64 %11, i64 0
  %15 = shufflevector <2 x i64> %14, <2 x i64> poison, <2 x i32> zeroinitializer
  %16 = insertelement <2 x i64> poison, i64 %12, i64 0
  %17 = shufflevector <2 x i64> %16, <2 x i64> poison, <2 x i32> zeroinitializer
  br label %18

18:                                               ; preds = %18, %13
  %19 = phi i64 [ 0, %13 ], [ %33, %18 ]
  %20 = phi <2 x i64> [ <i64 0, i64 1>, %13 ], [ %34, %18 ]
  %21 = add nuw nsw <2 x i64> %20, %15
  %22 = trunc nuw nsw <2 x i64> %21 to <2 x i32>
  %23 = urem <2 x i32> %22, splat (i32 100)
  %24 = uitofp nneg <2 x i32> %23 to <2 x double>
  %25 = fdiv <2 x double> %24, splat (double 6.000000e+01)
  %26 = getelementptr inbounds nuw [80 x double], ptr %3, i64 %11, i64 %19
  store <2 x double> %25, ptr %26, align 8, !tbaa !6
  %27 = sub nuw nsw <2 x i64> %17, %20
  %28 = trunc nuw nsw <2 x i64> %27 to <2 x i32>
  %29 = urem <2 x i32> %28, splat (i32 100)
  %30 = uitofp nneg <2 x i32> %29 to <2 x double>
  %31 = fdiv <2 x double> %30, splat (double 6.000000e+01)
  %32 = getelementptr inbounds nuw [80 x double], ptr %6, i64 %11, i64 %19
  store <2 x double> %31, ptr %32, align 8, !tbaa !6
  %33 = add nuw i64 %19, 2
  %34 = add <2 x i64> %20, splat (i64 2)
  %35 = icmp eq i64 %33, 80
  br i1 %35, label %.loopexit3, label %18, !llvm.loop !10

36:                                               ; preds = %.preheader, %36
  %37 = phi i64 [ %50, %36 ], [ 0, %.preheader ]
  %38 = add nuw nsw i64 %37, %11
  %39 = trunc nuw nsw i64 %38 to i32
  %40 = urem i32 %39, 100
  %41 = uitofp nneg i32 %40 to double
  %42 = fdiv double %41, 6.000000e+01
  %43 = getelementptr inbounds nuw [80 x double], ptr %3, i64 %11, i64 %37
  store double %42, ptr %43, align 8, !tbaa !6
  %44 = sub nuw nsw i64 %12, %37
  %45 = trunc nuw nsw i64 %44 to i32
  %46 = urem i32 %45, 100
  %47 = uitofp nneg i32 %46 to double
  %48 = fdiv double %47, 6.000000e+01
  %49 = getelementptr inbounds nuw [80 x double], ptr %6, i64 %11, i64 %37
  store double %48, ptr %49, align 8, !tbaa !6
  %50 = add nuw nsw i64 %37, 1
  %51 = icmp eq i64 %50, 80
  br i1 %51, label %.loopexit2, label %36, !llvm.loop !14

.loopexit2:                                       ; preds = %36
  br label %52

.loopexit3:                                       ; preds = %18
  br label %52

52:                                               ; preds = %.loopexit3, %.loopexit2
  %53 = add nuw nsw i64 %11, 1
  %54 = icmp eq i64 %53, 60
  br i1 %54, label %55, label %10, !llvm.loop !15

55:                                               ; preds = %52
  %56 = getelementptr i8, ptr %5, i64 8
  br label %60

57:                                               ; preds = %118, %115
  %58 = add nuw nsw i64 %61, 1
  %59 = icmp eq i64 %116, 60
  br i1 %59, label %122, label %60, !llvm.loop !16

60:                                               ; preds = %57, %55
  %61 = phi i64 [ 1, %55 ], [ %58, %57 ]
  %62 = phi i64 [ 0, %55 ], [ %116, %57 ]
  %63 = icmp samesign ult i64 %61, 8
  br i1 %63, label %103, label %64

64:                                               ; preds = %60
  %65 = and i64 %61, 9223372036854775800
  %66 = insertelement <2 x i64> poison, i64 %62, i64 0
  %67 = shufflevector <2 x i64> %66, <2 x i64> poison, <2 x i32> zeroinitializer
  %68 = add <2 x i64> splat (i64 2), %67
  %69 = add <2 x i64> splat (i64 4), %67
  %70 = add <2 x i64> splat (i64 6), %67
  br label %71

71:                                               ; preds = %71, %64
  %72 = phi i64 [ 0, %64 ], [ %98, %71 ]
  %73 = phi <2 x i64> [ <i64 0, i64 1>, %64 ], [ %99, %71 ]
  %74 = add nuw nsw <2 x i64> %73, %67
  %75 = add <2 x i64> %73, %68
  %76 = add <2 x i64> %73, %69
  %77 = add <2 x i64> %73, %70
  %78 = trunc nuw nsw <2 x i64> %74 to <2 x i32>
  %79 = trunc nuw nsw <2 x i64> %75 to <2 x i32>
  %80 = trunc nuw nsw <2 x i64> %76 to <2 x i32>
  %81 = trunc nuw nsw <2 x i64> %77 to <2 x i32>
  %82 = urem <2 x i32> %78, splat (i32 100)
  %83 = urem <2 x i32> %79, splat (i32 100)
  %84 = urem <2 x i32> %80, splat (i32 100)
  %85 = urem <2 x i32> %81, splat (i32 100)
  %86 = uitofp nneg <2 x i32> %82 to <2 x double>
  %87 = uitofp nneg <2 x i32> %83 to <2 x double>
  %88 = uitofp nneg <2 x i32> %84 to <2 x double>
  %89 = uitofp nneg <2 x i32> %85 to <2 x double>
  %90 = fdiv <2 x double> %86, splat (double 6.000000e+01)
  %91 = fdiv <2 x double> %87, splat (double 6.000000e+01)
  %92 = fdiv <2 x double> %88, splat (double 6.000000e+01)
  %93 = fdiv <2 x double> %89, splat (double 6.000000e+01)
  %94 = getelementptr inbounds nuw [60 x double], ptr %5, i64 %62, i64 %72
  %95 = getelementptr inbounds nuw i8, ptr %94, i64 16
  %96 = getelementptr inbounds nuw i8, ptr %94, i64 32
  %97 = getelementptr inbounds nuw i8, ptr %94, i64 48
  store <2 x double> %90, ptr %94, align 8, !tbaa !6
  store <2 x double> %91, ptr %95, align 8, !tbaa !6
  store <2 x double> %92, ptr %96, align 8, !tbaa !6
  store <2 x double> %93, ptr %97, align 8, !tbaa !6
  %98 = add nuw i64 %72, 8
  %99 = add <2 x i64> %73, splat (i64 8)
  %100 = icmp eq i64 %98, %65
  br i1 %100, label %101, label %71, !llvm.loop !17

101:                                              ; preds = %71
  %102 = icmp eq i64 %61, %65
  br i1 %102, label %115, label %103

103:                                              ; preds = %101, %60
  %104 = phi i64 [ 0, %60 ], [ %65, %101 ]
  br label %105

105:                                              ; preds = %105, %103
  %106 = phi i64 [ %113, %105 ], [ %104, %103 ]
  %107 = add nuw nsw i64 %106, %62
  %108 = trunc nuw nsw i64 %107 to i32
  %109 = urem i32 %108, 100
  %110 = uitofp nneg i32 %109 to double
  %111 = fdiv double %110, 6.000000e+01
  %112 = getelementptr inbounds nuw [60 x double], ptr %5, i64 %62, i64 %106
  store double %111, ptr %112, align 8, !tbaa !6
  %113 = add nuw nsw i64 %106, 1
  %114 = icmp eq i64 %113, %61
  br i1 %114, label %.loopexit1, label %105, !llvm.loop !18

.loopexit1:                                       ; preds = %105
  br label %115

115:                                              ; preds = %.loopexit1, %101
  %116 = add nuw nsw i64 %62, 1
  %117 = icmp samesign ult i64 %62, 59
  br i1 %117, label %118, label %57

118:                                              ; preds = %115
  %119 = sub nuw nsw i64 59, %62
  %120 = mul nuw nsw i64 %62, 488
  %121 = getelementptr i8, ptr %56, i64 %120
  tail call void @llvm.experimental.memset.pattern.p0.f64.i64(ptr align 8 %121, double -9.990000e+02, i64 %119, i1 false), !tbaa !6
  br label %57

122:                                              ; preds = %57
  tail call void @polybench_timer_start() #7
  br label %123

123:                                              ; preds = %160, %122
  %124 = phi i64 [ 0, %122 ], [ %161, %160 ]
  %125 = icmp eq i64 %124, 0
  %126 = getelementptr inbounds nuw [60 x double], ptr %5, i64 %124, i64 %124
  br label %127

127:                                              ; preds = %147, %123
  %128 = phi i64 [ 0, %123 ], [ %158, %147 ]
  br i1 %125, label %147, label %129

129:                                              ; preds = %127
  %130 = getelementptr inbounds nuw [80 x double], ptr %6, i64 %124, i64 %128
  br label %131

131:                                              ; preds = %131, %129
  %132 = phi i64 [ 0, %129 ], [ %145, %131 ]
  %133 = phi double [ 0.000000e+00, %129 ], [ %144, %131 ]
  %134 = load double, ptr %130, align 8, !tbaa !6
  %135 = fmul double %134, 1.500000e+00
  %136 = getelementptr inbounds nuw [60 x double], ptr %5, i64 %124, i64 %132
  %137 = load double, ptr %136, align 8, !tbaa !6
  %138 = getelementptr inbounds nuw [80 x double], ptr %3, i64 %132, i64 %128
  %139 = load double, ptr %138, align 8, !tbaa !6
  %140 = tail call double @llvm.fmuladd.f64(double %135, double %137, double %139)
  store double %140, ptr %138, align 8, !tbaa !6
  %141 = getelementptr inbounds nuw [80 x double], ptr %6, i64 %132, i64 %128
  %142 = load double, ptr %141, align 8, !tbaa !6
  %143 = load double, ptr %136, align 8, !tbaa !6
  %144 = tail call double @llvm.fmuladd.f64(double %142, double %143, double %133)
  %145 = add nuw nsw i64 %132, 1
  %146 = icmp eq i64 %145, %124
  br i1 %146, label %.loopexit, label %131, !llvm.loop !19

.loopexit:                                        ; preds = %131
  br label %147

147:                                              ; preds = %.loopexit, %127
  %148 = phi double [ 0.000000e+00, %127 ], [ %144, %.loopexit ]
  %149 = getelementptr inbounds nuw [80 x double], ptr %3, i64 %124, i64 %128
  %150 = load double, ptr %149, align 8, !tbaa !6
  %151 = getelementptr inbounds nuw [80 x double], ptr %6, i64 %124, i64 %128
  %152 = load double, ptr %151, align 8, !tbaa !6
  %153 = fmul double %152, 1.500000e+00
  %154 = load double, ptr %126, align 8, !tbaa !6
  %155 = fmul double %153, %154
  %156 = tail call double @llvm.fmuladd.f64(double %150, double 1.200000e+00, double %155)
  %157 = tail call double @llvm.fmuladd.f64(double %148, double 1.500000e+00, double %156)
  store double %157, ptr %149, align 8, !tbaa !6
  %158 = add nuw nsw i64 %128, 1
  %159 = icmp eq i64 %158, 80
  br i1 %159, label %160, label %127, !llvm.loop !20

160:                                              ; preds = %147
  %161 = add nuw nsw i64 %124, 1
  %162 = icmp eq i64 %161, 60
  br i1 %162, label %163, label %123, !llvm.loop !21

163:                                              ; preds = %160
  tail call void @polybench_timer_stop() #7
  tail call void @polybench_timer_print() #7
  %164 = icmp sgt i32 %0, 42
  br i1 %164, label %165, label %201

165:                                              ; preds = %163
  %166 = load ptr, ptr %1, align 8, !tbaa !22
  %167 = load i8, ptr %166, align 1
  %168 = icmp eq i8 %167, 0
  br i1 %168, label %169, label %201

169:                                              ; preds = %165
  %170 = load ptr, ptr @__stderrp, align 8, !tbaa !25
  %171 = tail call i64 @fwrite(ptr nonnull @.str.1, i64 22, i64 1, ptr %170)
  %172 = load ptr, ptr @__stderrp, align 8, !tbaa !25
  %173 = tail call i32 (ptr, ptr, ...) @fprintf(ptr noundef %172, ptr noundef nonnull @.str.2, ptr noundef nonnull @.str.3) #7
  br label %174

174:                                              ; preds = %193, %169
  %175 = phi i64 [ 0, %169 ], [ %194, %193 ]
  %176 = mul nuw nsw i64 %175, 60
  br label %177

177:                                              ; preds = %186, %174
  %178 = phi i64 [ 0, %174 ], [ %191, %186 ]
  %179 = add nuw nsw i64 %178, %176
  %180 = trunc nuw nsw i64 %179 to i32
  %181 = urem i32 %180, 20
  %182 = icmp eq i32 %181, 0
  br i1 %182, label %183, label %186

183:                                              ; preds = %177
  %184 = load ptr, ptr @__stderrp, align 8, !tbaa !25
  %185 = tail call i32 @fputc(i32 10, ptr %184)
  br label %186

186:                                              ; preds = %183, %177
  %187 = load ptr, ptr @__stderrp, align 8, !tbaa !25
  %188 = getelementptr inbounds nuw [80 x double], ptr %3, i64 %175, i64 %178
  %189 = load double, ptr %188, align 8, !tbaa !6
  %190 = tail call i32 (ptr, ptr, ...) @fprintf(ptr noundef %187, ptr noundef nonnull @.str.5, double noundef %189) #7
  %191 = add nuw nsw i64 %178, 1
  %192 = icmp eq i64 %191, 80
  br i1 %192, label %193, label %177, !llvm.loop !27

193:                                              ; preds = %186
  %194 = add nuw nsw i64 %175, 1
  %195 = icmp eq i64 %194, 60
  br i1 %195, label %196, label %174, !llvm.loop !28

196:                                              ; preds = %193
  %197 = load ptr, ptr @__stderrp, align 8, !tbaa !25
  %198 = tail call i32 (ptr, ptr, ...) @fprintf(ptr noundef %197, ptr noundef nonnull @.str.6, ptr noundef nonnull @.str.3) #7
  %199 = load ptr, ptr @__stderrp, align 8, !tbaa !25
  %200 = tail call i64 @fwrite(ptr nonnull @.str.7, i64 22, i64 1, ptr %199)
  br label %201

201:                                              ; preds = %196, %165, %163
  tail call void @free(ptr noundef nonnull %3)
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

; Function Attrs: nocallback nofree nounwind willreturn memory(argmem: write)
declare void @llvm.experimental.memset.pattern.p0.f64.i64(ptr writeonly captures(none), double, i64, i1 immarg) #6

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
!15 = distinct !{!15, !11}
!16 = distinct !{!16, !11}
!17 = distinct !{!17, !11, !12, !13}
!18 = distinct !{!18, !11, !13, !12}
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
