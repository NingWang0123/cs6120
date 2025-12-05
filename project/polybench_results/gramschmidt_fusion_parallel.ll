; ModuleID = 'polybench_results/gramschmidt.ll'
source_filename = "./polybench/linear-algebra/solvers/gramschmidt/gramschmidt.c"
target datalayout = "e-m:o-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-n32:64-S128-Fn32"
target triple = "arm64-apple-macosx15.0.0"

@__stderrp = external local_unnamed_addr global ptr, align 8
@.str.1 = private unnamed_addr constant [23 x i8] c"==BEGIN DUMP_ARRAYS==\0A\00", align 1
@.str.2 = private unnamed_addr constant [15 x i8] c"begin dump: %s\00", align 1
@.str.3 = private unnamed_addr constant [2 x i8] c"R\00", align 1
@.str.5 = private unnamed_addr constant [8 x i8] c"%0.2lf \00", align 1
@.str.6 = private unnamed_addr constant [17 x i8] c"\0Aend   dump: %s\0A\00", align 1
@.str.7 = private unnamed_addr constant [2 x i8] c"Q\00", align 1
@.str.8 = private unnamed_addr constant [23 x i8] c"==END   DUMP_ARRAYS==\0A\00", align 1

; Function Attrs: nounwind ssp uwtable(sync)
define noundef i32 @main(i32 noundef %0, ptr noundef readonly captures(none) %1) local_unnamed_addr #0 {
  %3 = tail call ptr @polybench_alloc_data(i64 noundef 4800, i32 noundef 8) #7
  %4 = ptrtoint ptr %3 to i64
  %5 = tail call ptr @polybench_alloc_data(i64 noundef 6400, i32 noundef 8) #7
  %6 = tail call ptr @polybench_alloc_data(i64 noundef 4800, i32 noundef 8) #7
  %7 = ptrtoint ptr %6 to i64
  %8 = sub i64 %7, %4
  %9 = icmp ult i64 %8, 16
  br label %10

10:                                               ; preds = %41, %2
  %11 = phi i64 [ 0, %2 ], [ %42, %41 ]
  br i1 %9, label %.preheader2, label %12

.preheader2:                                      ; preds = %10
  br label %29

12:                                               ; preds = %10
  %13 = insertelement <2 x i64> poison, i64 %11, i64 0
  %14 = shufflevector <2 x i64> %13, <2 x i64> poison, <2 x i32> zeroinitializer
  br label %15

15:                                               ; preds = %15, %12
  %16 = phi i64 [ 0, %12 ], [ %26, %15 ]
  %17 = phi <2 x i64> [ <i64 0, i64 1>, %12 ], [ %27, %15 ]
  %18 = mul nuw nsw <2 x i64> %17, %14
  %19 = trunc nuw nsw <2 x i64> %18 to <2 x i32>
  %20 = urem <2 x i32> %19, splat (i32 60)
  %21 = uitofp nneg <2 x i32> %20 to <2 x double>
  %22 = fdiv <2 x double> %21, splat (double 6.000000e+01)
  %23 = tail call <2 x double> @llvm.fmuladd.v2f64(<2 x double> %22, <2 x double> splat (double 1.000000e+02), <2 x double> splat (double 1.000000e+01))
  %24 = getelementptr inbounds nuw [80 x double], ptr %3, i64 %11, i64 %16
  store <2 x double> %23, ptr %24, align 8, !tbaa !6
  %25 = getelementptr inbounds nuw [80 x double], ptr %6, i64 %11, i64 %16
  store <2 x double> zeroinitializer, ptr %25, align 8, !tbaa !6
  %26 = add nuw i64 %16, 2
  %27 = add <2 x i64> %17, splat (i64 2)
  %28 = icmp eq i64 %26, 80
  br i1 %28, label %.loopexit4, label %15, !llvm.loop !10

29:                                               ; preds = %.preheader2, %29
  %30 = phi i64 [ %39, %29 ], [ 0, %.preheader2 ]
  %31 = mul nuw nsw i64 %30, %11
  %32 = trunc nuw nsw i64 %31 to i32
  %33 = urem i32 %32, 60
  %34 = uitofp nneg i32 %33 to double
  %35 = fdiv double %34, 6.000000e+01
  %36 = tail call double @llvm.fmuladd.f64(double %35, double 1.000000e+02, double 1.000000e+01)
  %37 = getelementptr inbounds nuw [80 x double], ptr %3, i64 %11, i64 %30
  store double %36, ptr %37, align 8, !tbaa !6
  %38 = getelementptr inbounds nuw [80 x double], ptr %6, i64 %11, i64 %30
  store double 0.000000e+00, ptr %38, align 8, !tbaa !6
  %39 = add nuw nsw i64 %30, 1
  %40 = icmp eq i64 %39, 80
  br i1 %40, label %.loopexit3, label %29, !llvm.loop !14

.loopexit3:                                       ; preds = %29
  br label %41

.loopexit4:                                       ; preds = %15
  br label %41

41:                                               ; preds = %.loopexit4, %.loopexit3
  %42 = add nuw nsw i64 %11, 1
  %43 = icmp eq i64 %42, 60
  br i1 %43, label %44, label %10, !llvm.loop !15

44:                                               ; preds = %41
  tail call void @llvm.memset.p0.i64(ptr noundef nonnull align 8 dereferenceable(51200) %5, i8 0, i64 51200, i1 false), !tbaa !6
  tail call void @polybench_timer_start() #7
  br label %48

.loopexit:                                        ; preds = %98
  br label %45

45:                                               ; preds = %.loopexit, %71
  %46 = add nuw nsw i64 %50, 1
  %47 = icmp eq i64 %72, 80
  br i1 %47, label %101, label %48, !llvm.loop !16

48:                                               ; preds = %45, %44
  %49 = phi i64 [ 0, %44 ], [ %72, %45 ]
  %50 = phi i64 [ 1, %44 ], [ %46, %45 ]
  br label %51

51:                                               ; preds = %51, %48
  %52 = phi i64 [ 0, %48 ], [ %57, %51 ]
  %53 = phi double [ 0.000000e+00, %48 ], [ %56, %51 ]
  %54 = getelementptr inbounds nuw [80 x double], ptr %3, i64 %52, i64 %49
  %55 = load double, ptr %54, align 8, !tbaa !6
  %56 = tail call double @llvm.fmuladd.f64(double %55, double %55, double %53)
  %57 = add nuw nsw i64 %52, 1
  %58 = icmp eq i64 %57, 60
  br i1 %58, label %59, label %51, !llvm.loop !17

59:                                               ; preds = %51
  %60 = tail call double @llvm.sqrt.f64(double %56)
  %61 = getelementptr inbounds nuw [80 x double], ptr %5, i64 %49, i64 %49
  store double %60, ptr %61, align 8, !tbaa !6
  br label %62

62:                                               ; preds = %62, %59
  %63 = phi i64 [ 0, %59 ], [ %69, %62 ]
  %64 = getelementptr inbounds nuw [80 x double], ptr %3, i64 %63, i64 %49
  %65 = load double, ptr %64, align 8, !tbaa !6
  %66 = load double, ptr %61, align 8, !tbaa !6
  %67 = fdiv double %65, %66
  %68 = getelementptr inbounds nuw [80 x double], ptr %6, i64 %63, i64 %49
  store double %67, ptr %68, align 8, !tbaa !6
  %69 = add nuw nsw i64 %63, 1
  %70 = icmp eq i64 %69, 60
  br i1 %70, label %71, label %62, !llvm.loop !18

71:                                               ; preds = %62
  %72 = add nuw nsw i64 %49, 1
  %73 = icmp samesign ult i64 %49, 79
  br i1 %73, label %.preheader1, label %45

.preheader1:                                      ; preds = %71
  br label %74

74:                                               ; preds = %.preheader1, %98
  %75 = phi i64 [ %99, %98 ], [ %50, %.preheader1 ]
  %76 = getelementptr inbounds nuw [80 x double], ptr %5, i64 %49, i64 %75
  store double 0.000000e+00, ptr %76, align 8, !tbaa !6
  br label %77

77:                                               ; preds = %77, %74
  %78 = phi i64 [ 0, %74 ], [ %85, %77 ]
  %79 = phi double [ 0.000000e+00, %74 ], [ %84, %77 ]
  %80 = getelementptr inbounds nuw [80 x double], ptr %6, i64 %78, i64 %49
  %81 = load double, ptr %80, align 8, !tbaa !6
  %82 = getelementptr inbounds nuw [80 x double], ptr %3, i64 %78, i64 %75
  %83 = load double, ptr %82, align 8, !tbaa !6
  %84 = tail call double @llvm.fmuladd.f64(double %81, double %83, double %79)
  store double %84, ptr %76, align 8, !tbaa !6
  %85 = add nuw nsw i64 %78, 1
  %86 = icmp eq i64 %85, 60
  br i1 %86, label %.preheader, label %77, !llvm.loop !19

.preheader:                                       ; preds = %77
  br label %87

87:                                               ; preds = %.preheader, %87
  %88 = phi i64 [ %96, %87 ], [ 0, %.preheader ]
  %89 = getelementptr inbounds nuw [80 x double], ptr %3, i64 %88, i64 %75
  %90 = load double, ptr %89, align 8, !tbaa !6
  %91 = getelementptr inbounds nuw [80 x double], ptr %6, i64 %88, i64 %49
  %92 = load double, ptr %91, align 8, !tbaa !6
  %93 = load double, ptr %76, align 8, !tbaa !6
  %94 = fneg double %92
  %95 = tail call double @llvm.fmuladd.f64(double %94, double %93, double %90)
  store double %95, ptr %89, align 8, !tbaa !6
  %96 = add nuw nsw i64 %88, 1
  %97 = icmp eq i64 %96, 60
  br i1 %97, label %98, label %87, !llvm.loop !20

98:                                               ; preds = %87
  %99 = add nuw nsw i64 %75, 1
  %100 = icmp eq i64 %99, 80
  br i1 %100, label %.loopexit, label %74, !llvm.loop !21

101:                                              ; preds = %45
  tail call void @polybench_timer_stop() #7
  tail call void @polybench_timer_print() #7
  %102 = icmp sgt i32 %0, 42
  br i1 %102, label %103, label %166

103:                                              ; preds = %101
  %104 = load ptr, ptr %1, align 8, !tbaa !22
  %105 = load i8, ptr %104, align 1
  %106 = icmp eq i8 %105, 0
  br i1 %106, label %107, label %166

107:                                              ; preds = %103
  %108 = load ptr, ptr @__stderrp, align 8, !tbaa !25
  %109 = tail call i64 @fwrite(ptr nonnull @.str.1, i64 22, i64 1, ptr %108)
  %110 = load ptr, ptr @__stderrp, align 8, !tbaa !25
  %111 = tail call i32 (ptr, ptr, ...) @fprintf(ptr noundef %110, ptr noundef nonnull @.str.2, ptr noundef nonnull @.str.3) #7
  br label %112

112:                                              ; preds = %131, %107
  %113 = phi i64 [ 0, %107 ], [ %132, %131 ]
  %114 = mul nuw nsw i64 %113, 80
  br label %115

115:                                              ; preds = %124, %112
  %116 = phi i64 [ 0, %112 ], [ %129, %124 ]
  %117 = add nuw nsw i64 %116, %114
  %118 = trunc nuw nsw i64 %117 to i32
  %119 = urem i32 %118, 20
  %120 = icmp eq i32 %119, 0
  br i1 %120, label %121, label %124

121:                                              ; preds = %115
  %122 = load ptr, ptr @__stderrp, align 8, !tbaa !25
  %123 = tail call i32 @fputc(i32 10, ptr %122)
  br label %124

124:                                              ; preds = %121, %115
  %125 = load ptr, ptr @__stderrp, align 8, !tbaa !25
  %126 = getelementptr inbounds nuw [80 x double], ptr %5, i64 %113, i64 %116
  %127 = load double, ptr %126, align 8, !tbaa !6
  %128 = tail call i32 (ptr, ptr, ...) @fprintf(ptr noundef %125, ptr noundef nonnull @.str.5, double noundef %127) #7
  %129 = add nuw nsw i64 %116, 1
  %130 = icmp eq i64 %129, 80
  br i1 %130, label %131, label %115, !llvm.loop !27

131:                                              ; preds = %124
  %132 = add nuw nsw i64 %113, 1
  %133 = icmp eq i64 %132, 80
  br i1 %133, label %134, label %112, !llvm.loop !28

134:                                              ; preds = %131
  %135 = load ptr, ptr @__stderrp, align 8, !tbaa !25
  %136 = tail call i32 (ptr, ptr, ...) @fprintf(ptr noundef %135, ptr noundef nonnull @.str.6, ptr noundef nonnull @.str.3) #7
  %137 = load ptr, ptr @__stderrp, align 8, !tbaa !25
  %138 = tail call i32 (ptr, ptr, ...) @fprintf(ptr noundef %137, ptr noundef nonnull @.str.2, ptr noundef nonnull @.str.7) #7
  br label %139

139:                                              ; preds = %158, %134
  %140 = phi i64 [ 0, %134 ], [ %159, %158 ]
  %141 = mul nuw nsw i64 %140, 80
  br label %142

142:                                              ; preds = %151, %139
  %143 = phi i64 [ 0, %139 ], [ %156, %151 ]
  %144 = add nuw nsw i64 %143, %141
  %145 = trunc nuw nsw i64 %144 to i32
  %146 = urem i32 %145, 20
  %147 = icmp eq i32 %146, 0
  br i1 %147, label %148, label %151

148:                                              ; preds = %142
  %149 = load ptr, ptr @__stderrp, align 8, !tbaa !25
  %150 = tail call i32 @fputc(i32 10, ptr %149)
  br label %151

151:                                              ; preds = %148, %142
  %152 = load ptr, ptr @__stderrp, align 8, !tbaa !25
  %153 = getelementptr inbounds nuw [80 x double], ptr %6, i64 %140, i64 %143
  %154 = load double, ptr %153, align 8, !tbaa !6
  %155 = tail call i32 (ptr, ptr, ...) @fprintf(ptr noundef %152, ptr noundef nonnull @.str.5, double noundef %154) #7
  %156 = add nuw nsw i64 %143, 1
  %157 = icmp eq i64 %156, 80
  br i1 %157, label %158, label %142, !llvm.loop !29

158:                                              ; preds = %151
  %159 = add nuw nsw i64 %140, 1
  %160 = icmp eq i64 %159, 60
  br i1 %160, label %161, label %139, !llvm.loop !30

161:                                              ; preds = %158
  %162 = load ptr, ptr @__stderrp, align 8, !tbaa !25
  %163 = tail call i32 (ptr, ptr, ...) @fprintf(ptr noundef %162, ptr noundef nonnull @.str.6, ptr noundef nonnull @.str.7) #7
  %164 = load ptr, ptr @__stderrp, align 8, !tbaa !25
  %165 = tail call i64 @fwrite(ptr nonnull @.str.8, i64 22, i64 1, ptr %164)
  br label %166

166:                                              ; preds = %161, %103, %101
  tail call void @free(ptr noundef %3)
  tail call void @free(ptr noundef %5)
  tail call void @free(ptr noundef nonnull %6)
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

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare double @llvm.sqrt.f64(double) #3

; Function Attrs: nofree nounwind
declare noundef i32 @fprintf(ptr noundef captures(none), ptr noundef readonly captures(none), ...) local_unnamed_addr #4

; Function Attrs: nofree nounwind
declare noundef i64 @fwrite(ptr noundef readonly captures(none), i64 noundef, i64 noundef, ptr noundef captures(none)) local_unnamed_addr #5

; Function Attrs: nofree nounwind
declare noundef i32 @fputc(i32 noundef, ptr noundef captures(none)) local_unnamed_addr #5

; Function Attrs: nocallback nofree nounwind willreturn memory(argmem: write)
declare void @llvm.memset.p0.i64(ptr writeonly captures(none), i8, i64, i1 immarg) #6

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare <2 x double> @llvm.fmuladd.v2f64(<2 x double>, <2 x double>, <2 x double>) #3

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
!29 = distinct !{!29, !11}
!30 = distinct !{!30, !11}
