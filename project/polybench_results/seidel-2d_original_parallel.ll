; ModuleID = 'polybench_results/seidel-2d.ll'
source_filename = "./polybench/stencils/seidel-2d/seidel-2d.c"
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
  %3 = tail call ptr @polybench_alloc_data(i64 noundef 14400, i32 noundef 8) #6
  br label %4

4:                                                ; preds = %36, %2
  %5 = phi i64 [ 0, %2 ], [ %37, %36 ]
  %6 = trunc nuw nsw i64 %5 to i32
  %7 = uitofp nneg i32 %6 to double
  %8 = insertelement <2 x double> poison, double %7, i64 0
  %9 = shufflevector <2 x double> %8, <2 x double> poison, <2 x i32> zeroinitializer
  br label %10

10:                                               ; preds = %10, %4
  %11 = phi i64 [ 0, %4 ], [ %33, %10 ]
  %12 = phi <2 x i32> [ <i32 0, i32 1>, %4 ], [ %34, %10 ]
  %13 = add <2 x i32> %12, splat (i32 2)
  %14 = add <2 x i32> %12, splat (i32 4)
  %15 = add <2 x i32> %12, splat (i32 6)
  %16 = add <2 x i32> %12, splat (i32 8)
  %17 = uitofp nneg <2 x i32> %13 to <2 x double>
  %18 = uitofp nneg <2 x i32> %14 to <2 x double>
  %19 = uitofp nneg <2 x i32> %15 to <2 x double>
  %20 = uitofp nneg <2 x i32> %16 to <2 x double>
  %21 = tail call <2 x double> @llvm.fmuladd.v2f64(<2 x double> %9, <2 x double> %17, <2 x double> splat (double 2.000000e+00))
  %22 = tail call <2 x double> @llvm.fmuladd.v2f64(<2 x double> %9, <2 x double> %18, <2 x double> splat (double 2.000000e+00))
  %23 = tail call <2 x double> @llvm.fmuladd.v2f64(<2 x double> %9, <2 x double> %19, <2 x double> splat (double 2.000000e+00))
  %24 = tail call <2 x double> @llvm.fmuladd.v2f64(<2 x double> %9, <2 x double> %20, <2 x double> splat (double 2.000000e+00))
  %25 = fdiv <2 x double> %21, splat (double 1.200000e+02)
  %26 = fdiv <2 x double> %22, splat (double 1.200000e+02)
  %27 = fdiv <2 x double> %23, splat (double 1.200000e+02)
  %28 = fdiv <2 x double> %24, splat (double 1.200000e+02)
  %29 = getelementptr inbounds nuw [120 x double], ptr %3, i64 %5, i64 %11
  %30 = getelementptr inbounds nuw i8, ptr %29, i64 16
  %31 = getelementptr inbounds nuw i8, ptr %29, i64 32
  %32 = getelementptr inbounds nuw i8, ptr %29, i64 48
  store <2 x double> %25, ptr %29, align 8, !tbaa !6
  store <2 x double> %26, ptr %30, align 8, !tbaa !6
  store <2 x double> %27, ptr %31, align 8, !tbaa !6
  store <2 x double> %28, ptr %32, align 8, !tbaa !6
  %33 = add nuw i64 %11, 8
  %34 = add <2 x i32> %12, splat (i32 8)
  %35 = icmp eq i64 %33, 120
  br i1 %35, label %36, label %10, !llvm.loop !10

36:                                               ; preds = %10
  %37 = add nuw nsw i64 %5, 1
  %38 = icmp eq i64 %37, 120
  br i1 %38, label %39, label %4, !llvm.loop !14

39:                                               ; preds = %36
  tail call void @polybench_timer_start() #6
  br label %40

40:                                               ; preds = %85, %39
  %41 = phi i32 [ 0, %39 ], [ %86, %85 ]
  br label %42

42:                                               ; preds = %82, %40
  %43 = phi i64 [ 1, %40 ], [ %83, %82 ]
  %44 = getelementptr [120 x double], ptr %3, i64 %43
  %45 = getelementptr i8, ptr %44, i64 -960
  %46 = getelementptr inbounds nuw i8, ptr %44, i64 960
  %47 = load double, ptr %45, align 8, !tbaa !6
  %48 = getelementptr i8, ptr %44, i64 -952
  %49 = load double, ptr %48, align 8, !tbaa !6
  %50 = load double, ptr %44, align 8, !tbaa !6
  %51 = getelementptr inbounds nuw [120 x double], ptr %3, i64 %43, i64 1
  %52 = load double, ptr %51, align 8, !tbaa !6
  %53 = load double, ptr %46, align 8, !tbaa !6
  %54 = getelementptr inbounds nuw i8, ptr %44, i64 968
  %55 = load double, ptr %54, align 8, !tbaa !6
  br label %56

56:                                               ; preds = %56, %42
  %57 = phi double [ %55, %42 ], [ %78, %56 ]
  %58 = phi double [ %53, %42 ], [ %57, %56 ]
  %59 = phi double [ %52, %42 ], [ %73, %56 ]
  %60 = phi double [ %50, %42 ], [ %80, %56 ]
  %61 = phi double [ %49, %42 ], [ %67, %56 ]
  %62 = phi double [ %47, %42 ], [ %61, %56 ]
  %63 = phi i64 [ 1, %42 ], [ %65, %56 ]
  %64 = fadd double %61, %62
  %65 = add nuw nsw i64 %63, 1
  %66 = getelementptr inbounds nuw [120 x double], ptr %45, i64 0, i64 %65
  %67 = load double, ptr %66, align 8, !tbaa !6
  %68 = fadd double %64, %67
  %69 = fadd double %60, %68
  %70 = getelementptr inbounds nuw [120 x double], ptr %3, i64 %43, i64 %63
  %71 = fadd double %59, %69
  %72 = getelementptr inbounds nuw [120 x double], ptr %3, i64 %43, i64 %65
  %73 = load double, ptr %72, align 8, !tbaa !6
  %74 = fadd double %73, %71
  %75 = fadd double %58, %74
  %76 = fadd double %57, %75
  %77 = getelementptr inbounds nuw [120 x double], ptr %46, i64 0, i64 %65
  %78 = load double, ptr %77, align 8, !tbaa !6
  %79 = fadd double %78, %76
  %80 = fdiv double %79, 9.000000e+00
  store double %80, ptr %70, align 8, !tbaa !6
  %81 = icmp eq i64 %65, 119
  br i1 %81, label %82, label %56, !llvm.loop !15

82:                                               ; preds = %56
  %83 = add nuw nsw i64 %43, 1
  %84 = icmp eq i64 %83, 119
  br i1 %84, label %85, label %42, !llvm.loop !16

85:                                               ; preds = %82
  %86 = add nuw nsw i32 %41, 1
  %87 = icmp eq i32 %86, 40
  br i1 %87, label %88, label %40, !llvm.loop !17

88:                                               ; preds = %85
  tail call void @polybench_timer_stop() #6
  tail call void @polybench_timer_print() #6
  %89 = icmp sgt i32 %0, 42
  br i1 %89, label %90, label %126

90:                                               ; preds = %88
  %91 = load ptr, ptr %1, align 8, !tbaa !18
  %92 = load i8, ptr %91, align 1
  %93 = icmp eq i8 %92, 0
  br i1 %93, label %94, label %126

94:                                               ; preds = %90
  %95 = load ptr, ptr @__stderrp, align 8, !tbaa !21
  %96 = tail call i64 @fwrite(ptr nonnull @.str.1, i64 22, i64 1, ptr %95)
  %97 = load ptr, ptr @__stderrp, align 8, !tbaa !21
  %98 = tail call i32 (ptr, ptr, ...) @fprintf(ptr noundef %97, ptr noundef nonnull @.str.2, ptr noundef nonnull @.str.3) #6
  br label %99

99:                                               ; preds = %118, %94
  %100 = phi i64 [ 0, %94 ], [ %119, %118 ]
  %101 = mul nuw nsw i64 %100, 120
  br label %102

102:                                              ; preds = %111, %99
  %103 = phi i64 [ 0, %99 ], [ %116, %111 ]
  %104 = add nuw nsw i64 %103, %101
  %105 = trunc nuw nsw i64 %104 to i32
  %106 = urem i32 %105, 20
  %107 = icmp eq i32 %106, 0
  br i1 %107, label %108, label %111

108:                                              ; preds = %102
  %109 = load ptr, ptr @__stderrp, align 8, !tbaa !21
  %110 = tail call i32 @fputc(i32 10, ptr %109)
  br label %111

111:                                              ; preds = %108, %102
  %112 = load ptr, ptr @__stderrp, align 8, !tbaa !21
  %113 = getelementptr inbounds nuw [120 x double], ptr %3, i64 %100, i64 %103
  %114 = load double, ptr %113, align 8, !tbaa !6
  %115 = tail call i32 (ptr, ptr, ...) @fprintf(ptr noundef %112, ptr noundef nonnull @.str.5, double noundef %114) #6
  %116 = add nuw nsw i64 %103, 1
  %117 = icmp eq i64 %116, 120
  br i1 %117, label %118, label %102, !llvm.loop !23

118:                                              ; preds = %111
  %119 = add nuw nsw i64 %100, 1
  %120 = icmp eq i64 %119, 120
  br i1 %120, label %121, label %99, !llvm.loop !24

121:                                              ; preds = %118
  %122 = load ptr, ptr @__stderrp, align 8, !tbaa !21
  %123 = tail call i32 (ptr, ptr, ...) @fprintf(ptr noundef %122, ptr noundef nonnull @.str.6, ptr noundef nonnull @.str.3) #6
  %124 = load ptr, ptr @__stderrp, align 8, !tbaa !21
  %125 = tail call i64 @fwrite(ptr nonnull @.str.7, i64 22, i64 1, ptr %124)
  br label %126

126:                                              ; preds = %121, %90, %88
  tail call void @free(ptr noundef nonnull %3)
  ret i32 0
}

declare ptr @polybench_alloc_data(i64 noundef, i32 noundef) local_unnamed_addr #1

declare void @polybench_timer_start(...) local_unnamed_addr #1

declare void @polybench_timer_stop(...) local_unnamed_addr #1

declare void @polybench_timer_print(...) local_unnamed_addr #1

; Function Attrs: mustprogress nounwind willreturn allockind("free") memory(argmem: readwrite, inaccessiblemem: readwrite)
declare void @free(ptr allocptr noundef captures(none)) local_unnamed_addr #2

; Function Attrs: nofree nounwind
declare noundef i32 @fprintf(ptr noundef captures(none), ptr noundef readonly captures(none), ...) local_unnamed_addr #3

; Function Attrs: nofree nounwind
declare noundef i64 @fwrite(ptr noundef readonly captures(none), i64 noundef, i64 noundef, ptr noundef captures(none)) local_unnamed_addr #4

; Function Attrs: nofree nounwind
declare noundef i32 @fputc(i32 noundef, ptr noundef captures(none)) local_unnamed_addr #4

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare <2 x double> @llvm.fmuladd.v2f64(<2 x double>, <2 x double>, <2 x double>) #5

attributes #0 = { nounwind ssp uwtable(sync) "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+ccpp,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a" }
attributes #1 = { "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+ccpp,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a" }
attributes #2 = { mustprogress nounwind willreturn allockind("free") memory(argmem: readwrite, inaccessiblemem: readwrite) "alloc-family"="malloc" "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+ccpp,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a" }
attributes #3 = { nofree nounwind "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+ccpp,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a" }
attributes #4 = { nofree nounwind }
attributes #5 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
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
!17 = distinct !{!17, !11}
!18 = !{!19, !19, i64 0}
!19 = !{!"p1 omnipotent char", !20, i64 0}
!20 = !{!"any pointer", !8, i64 0}
!21 = !{!22, !22, i64 0}
!22 = !{!"p1 _ZTS7__sFILE", !20, i64 0}
!23 = distinct !{!23, !11}
!24 = distinct !{!24, !11}
