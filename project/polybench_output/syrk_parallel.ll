; ModuleID = 'polybench_output/syrk.ll'
source_filename = "./polybench/linear-algebra/blas/syrk/syrk.c"
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
  %3 = tail call ptr @polybench_alloc_data(i64 noundef 6400, i32 noundef 8) #6
  %4 = tail call ptr @polybench_alloc_data(i64 noundef 4800, i32 noundef 8) #6
  br label %5

5:                                                ; preds = %22, %2
  %6 = phi i64 [ 0, %2 ], [ %23, %22 ]
  %7 = insertelement <2 x i64> poison, i64 %6, i64 0
  %8 = shufflevector <2 x i64> %7, <2 x i64> poison, <2 x i32> zeroinitializer
  br label %9

9:                                                ; preds = %9, %5
  %10 = phi i64 [ 0, %5 ], [ %19, %9 ]
  %11 = phi <2 x i64> [ <i64 0, i64 1>, %5 ], [ %20, %9 ]
  %12 = mul nuw nsw <2 x i64> %11, %8
  %13 = trunc <2 x i64> %12 to <2 x i32>
  %14 = add <2 x i32> %13, splat (i32 1)
  %15 = urem <2 x i32> %14, splat (i32 80)
  %16 = uitofp nneg <2 x i32> %15 to <2 x double>
  %17 = fdiv <2 x double> %16, splat (double 8.000000e+01)
  %18 = getelementptr inbounds nuw [60 x double], ptr %4, i64 %6, i64 %10
  store <2 x double> %17, ptr %18, align 8, !tbaa !6
  %19 = add nuw i64 %10, 2
  %20 = add <2 x i64> %11, splat (i64 2)
  %21 = icmp eq i64 %19, 60
  br i1 %21, label %22, label %9, !llvm.loop !10

22:                                               ; preds = %9
  %23 = add nuw nsw i64 %6, 1
  %24 = icmp eq i64 %23, 80
  br i1 %24, label %.preheader, label %5, !llvm.loop !14

.preheader:                                       ; preds = %22
  br label %25

25:                                               ; preds = %.preheader, %42
  %26 = phi i64 [ %43, %42 ], [ 0, %.preheader ]
  %27 = insertelement <2 x i64> poison, i64 %26, i64 0
  %28 = shufflevector <2 x i64> %27, <2 x i64> poison, <2 x i32> zeroinitializer
  br label %29

29:                                               ; preds = %29, %25
  %30 = phi i64 [ 0, %25 ], [ %39, %29 ]
  %31 = phi <2 x i64> [ <i64 0, i64 1>, %25 ], [ %40, %29 ]
  %32 = mul nuw nsw <2 x i64> %31, %28
  %33 = trunc <2 x i64> %32 to <2 x i32>
  %34 = add <2 x i32> %33, splat (i32 2)
  %35 = urem <2 x i32> %34, splat (i32 60)
  %36 = uitofp nneg <2 x i32> %35 to <2 x double>
  %37 = fdiv <2 x double> %36, splat (double 6.000000e+01)
  %38 = getelementptr inbounds nuw [80 x double], ptr %3, i64 %26, i64 %30
  store <2 x double> %37, ptr %38, align 8, !tbaa !6
  %39 = add nuw i64 %30, 2
  %40 = add <2 x i64> %31, splat (i64 2)
  %41 = icmp eq i64 %39, 80
  br i1 %41, label %42, label %29, !llvm.loop !15

42:                                               ; preds = %29
  %43 = add nuw nsw i64 %26, 1
  %44 = icmp eq i64 %43, 80
  br i1 %44, label %45, label %25, !llvm.loop !16

45:                                               ; preds = %42
  tail call void @polybench_timer_start() #6
  br label %46

46:                                               ; preds = %97, %45
  %47 = phi i64 [ 0, %45 ], [ %98, %97 ]
  %48 = phi i64 [ 1, %45 ], [ %99, %97 ]
  %49 = icmp samesign ult i64 %48, 8
  br i1 %49, label %70, label %50

50:                                               ; preds = %46
  %51 = and i64 %48, 9223372036854775800
  br label %52

52:                                               ; preds = %52, %50
  %53 = phi i64 [ 0, %50 ], [ %66, %52 ]
  %54 = getelementptr inbounds nuw [80 x double], ptr %3, i64 %47, i64 %53
  %55 = getelementptr inbounds nuw i8, ptr %54, i64 16
  %56 = getelementptr inbounds nuw i8, ptr %54, i64 32
  %57 = getelementptr inbounds nuw i8, ptr %54, i64 48
  %58 = load <2 x double>, ptr %54, align 8, !tbaa !6
  %59 = load <2 x double>, ptr %55, align 8, !tbaa !6
  %60 = load <2 x double>, ptr %56, align 8, !tbaa !6
  %61 = load <2 x double>, ptr %57, align 8, !tbaa !6
  %62 = fmul <2 x double> %58, splat (double 1.200000e+00)
  %63 = fmul <2 x double> %59, splat (double 1.200000e+00)
  %64 = fmul <2 x double> %60, splat (double 1.200000e+00)
  %65 = fmul <2 x double> %61, splat (double 1.200000e+00)
  store <2 x double> %62, ptr %54, align 8, !tbaa !6
  store <2 x double> %63, ptr %55, align 8, !tbaa !6
  store <2 x double> %64, ptr %56, align 8, !tbaa !6
  store <2 x double> %65, ptr %57, align 8, !tbaa !6
  %66 = add nuw i64 %53, 8
  %67 = icmp eq i64 %66, %51
  br i1 %67, label %68, label %52, !llvm.loop !17

68:                                               ; preds = %52
  %69 = icmp eq i64 %48, %51
  br i1 %69, label %79, label %70

70:                                               ; preds = %68, %46
  %71 = phi i64 [ 0, %46 ], [ %51, %68 ]
  br label %72

72:                                               ; preds = %72, %70
  %73 = phi i64 [ %77, %72 ], [ %71, %70 ]
  %74 = getelementptr inbounds nuw [80 x double], ptr %3, i64 %47, i64 %73
  %75 = load double, ptr %74, align 8, !tbaa !6
  %76 = fmul double %75, 1.200000e+00
  store double %76, ptr %74, align 8, !tbaa !6
  %77 = add nuw nsw i64 %73, 1
  %78 = icmp eq i64 %77, %48
  br i1 %78, label %.loopexit, label %72, !llvm.loop !18

.loopexit:                                        ; preds = %72
  br label %79

79:                                               ; preds = %.loopexit, %68
  br label %80

80:                                               ; preds = %94, %79
  %81 = phi i64 [ %95, %94 ], [ 0, %79 ]
  %82 = getelementptr inbounds nuw [60 x double], ptr %4, i64 %47, i64 %81
  br label %83

83:                                               ; preds = %83, %80
  %84 = phi i64 [ 0, %80 ], [ %92, %83 ]
  %85 = load double, ptr %82, align 8, !tbaa !6
  %86 = fmul double %85, 1.500000e+00
  %87 = getelementptr inbounds nuw [60 x double], ptr %4, i64 %84, i64 %81
  %88 = load double, ptr %87, align 8, !tbaa !6
  %89 = getelementptr inbounds nuw [80 x double], ptr %3, i64 %47, i64 %84
  %90 = load double, ptr %89, align 8, !tbaa !6
  %91 = tail call double @llvm.fmuladd.f64(double %86, double %88, double %90)
  store double %91, ptr %89, align 8, !tbaa !6
  %92 = add nuw nsw i64 %84, 1
  %93 = icmp eq i64 %92, %48
  br i1 %93, label %94, label %83, !llvm.loop !19

94:                                               ; preds = %83
  %95 = add nuw nsw i64 %81, 1
  %96 = icmp eq i64 %95, 60
  br i1 %96, label %97, label %80, !llvm.loop !20

97:                                               ; preds = %94
  %98 = add nuw nsw i64 %47, 1
  %99 = add nuw nsw i64 %48, 1
  %100 = icmp eq i64 %98, 80
  br i1 %100, label %101, label %46, !llvm.loop !21

101:                                              ; preds = %97
  tail call void @polybench_timer_stop() #6
  tail call void @polybench_timer_print() #6
  %102 = icmp sgt i32 %0, 42
  br i1 %102, label %103, label %139

103:                                              ; preds = %101
  %104 = load ptr, ptr %1, align 8, !tbaa !22
  %105 = load i8, ptr %104, align 1
  %106 = icmp eq i8 %105, 0
  br i1 %106, label %107, label %139

107:                                              ; preds = %103
  %108 = load ptr, ptr @__stderrp, align 8, !tbaa !25
  %109 = tail call i64 @fwrite(ptr nonnull @.str.1, i64 22, i64 1, ptr %108)
  %110 = load ptr, ptr @__stderrp, align 8, !tbaa !25
  %111 = tail call i32 (ptr, ptr, ...) @fprintf(ptr noundef %110, ptr noundef nonnull @.str.2, ptr noundef nonnull @.str.3) #6
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
  %126 = getelementptr inbounds nuw [80 x double], ptr %3, i64 %113, i64 %116
  %127 = load double, ptr %126, align 8, !tbaa !6
  %128 = tail call i32 (ptr, ptr, ...) @fprintf(ptr noundef %125, ptr noundef nonnull @.str.5, double noundef %127) #6
  %129 = add nuw nsw i64 %116, 1
  %130 = icmp eq i64 %129, 80
  br i1 %130, label %131, label %115, !llvm.loop !27

131:                                              ; preds = %124
  %132 = add nuw nsw i64 %113, 1
  %133 = icmp eq i64 %132, 80
  br i1 %133, label %134, label %112, !llvm.loop !28

134:                                              ; preds = %131
  %135 = load ptr, ptr @__stderrp, align 8, !tbaa !25
  %136 = tail call i32 (ptr, ptr, ...) @fprintf(ptr noundef %135, ptr noundef nonnull @.str.6, ptr noundef nonnull @.str.3) #6
  %137 = load ptr, ptr @__stderrp, align 8, !tbaa !25
  %138 = tail call i64 @fwrite(ptr nonnull @.str.7, i64 22, i64 1, ptr %137)
  br label %139

139:                                              ; preds = %134, %103, %101
  tail call void @free(ptr noundef nonnull %3)
  tail call void @free(ptr noundef %4)
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
!14 = distinct !{!14, !11}
!15 = distinct !{!15, !11, !12, !13}
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
