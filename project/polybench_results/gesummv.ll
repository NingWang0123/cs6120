; ModuleID = './polybench/linear-algebra/blas/gesummv/gesummv.c'
source_filename = "./polybench/linear-algebra/blas/gesummv/gesummv.c"
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
  %3 = tail call ptr @polybench_alloc_data(i64 noundef 8100, i32 noundef 8) #6
  %4 = ptrtoint ptr %3 to i64
  %5 = tail call ptr @polybench_alloc_data(i64 noundef 8100, i32 noundef 8) #6
  %6 = ptrtoint ptr %5 to i64
  %7 = tail call ptr @polybench_alloc_data(i64 noundef 90, i32 noundef 8) #6
  %8 = tail call ptr @polybench_alloc_data(i64 noundef 90, i32 noundef 8) #6
  %9 = tail call ptr @polybench_alloc_data(i64 noundef 90, i32 noundef 8) #6
  %10 = sub i64 %6, %4
  %11 = icmp ult i64 %10, 16
  br label %12

12:                                               ; preds = %55, %2
  %13 = phi i64 [ 0, %2 ], [ %56, %55 ]
  %14 = trunc nuw nsw i64 %13 to i32
  %15 = uitofp nneg i32 %14 to double
  %16 = fdiv double %15, 9.000000e+01
  %17 = getelementptr inbounds nuw double, ptr %8, i64 %13
  store double %16, ptr %17, align 8, !tbaa !6
  br i1 %11, label %39, label %18

18:                                               ; preds = %12
  %19 = insertelement <2 x i64> poison, i64 %13, i64 0
  %20 = shufflevector <2 x i64> %19, <2 x i64> poison, <2 x i32> zeroinitializer
  br label %21

21:                                               ; preds = %21, %18
  %22 = phi i64 [ 0, %18 ], [ %36, %21 ]
  %23 = phi <2 x i64> [ <i64 0, i64 1>, %18 ], [ %37, %21 ]
  %24 = mul nuw nsw <2 x i64> %23, %20
  %25 = trunc <2 x i64> %24 to <2 x i32>
  %26 = add <2 x i32> %25, splat (i32 1)
  %27 = urem <2 x i32> %26, splat (i32 90)
  %28 = uitofp nneg <2 x i32> %27 to <2 x double>
  %29 = fdiv <2 x double> %28, splat (double 9.000000e+01)
  %30 = getelementptr inbounds nuw [90 x double], ptr %3, i64 %13, i64 %22
  store <2 x double> %29, ptr %30, align 8, !tbaa !6
  %31 = add <2 x i32> %25, splat (i32 2)
  %32 = urem <2 x i32> %31, splat (i32 90)
  %33 = uitofp nneg <2 x i32> %32 to <2 x double>
  %34 = fdiv <2 x double> %33, splat (double 9.000000e+01)
  %35 = getelementptr inbounds nuw [90 x double], ptr %5, i64 %13, i64 %22
  store <2 x double> %34, ptr %35, align 8, !tbaa !6
  %36 = add nuw i64 %22, 2
  %37 = add <2 x i64> %23, splat (i64 2)
  %38 = icmp eq i64 %36, 90
  br i1 %38, label %55, label %21, !llvm.loop !10

39:                                               ; preds = %12, %39
  %40 = phi i64 [ %53, %39 ], [ 0, %12 ]
  %41 = mul nuw nsw i64 %40, %13
  %42 = trunc i64 %41 to i32
  %43 = add i32 %42, 1
  %44 = urem i32 %43, 90
  %45 = uitofp nneg i32 %44 to double
  %46 = fdiv double %45, 9.000000e+01
  %47 = getelementptr inbounds nuw [90 x double], ptr %3, i64 %13, i64 %40
  store double %46, ptr %47, align 8, !tbaa !6
  %48 = add i32 %42, 2
  %49 = urem i32 %48, 90
  %50 = uitofp nneg i32 %49 to double
  %51 = fdiv double %50, 9.000000e+01
  %52 = getelementptr inbounds nuw [90 x double], ptr %5, i64 %13, i64 %40
  store double %51, ptr %52, align 8, !tbaa !6
  %53 = add nuw nsw i64 %40, 1
  %54 = icmp eq i64 %53, 90
  br i1 %54, label %55, label %39, !llvm.loop !14

55:                                               ; preds = %21, %39
  %56 = add nuw nsw i64 %13, 1
  %57 = icmp eq i64 %56, 90
  br i1 %57, label %58, label %12, !llvm.loop !15

58:                                               ; preds = %55
  tail call void @polybench_timer_start() #6
  br label %59

59:                                               ; preds = %78, %58
  %60 = phi i64 [ 0, %58 ], [ %82, %78 ]
  %61 = getelementptr inbounds nuw double, ptr %7, i64 %60
  store double 0.000000e+00, ptr %61, align 8, !tbaa !6
  %62 = getelementptr inbounds nuw double, ptr %9, i64 %60
  store double 0.000000e+00, ptr %62, align 8, !tbaa !6
  br label %63

63:                                               ; preds = %63, %59
  %64 = phi i64 [ 0, %59 ], [ %76, %63 ]
  %65 = getelementptr inbounds nuw [90 x double], ptr %3, i64 %60, i64 %64
  %66 = load double, ptr %65, align 8, !tbaa !6
  %67 = getelementptr inbounds nuw double, ptr %8, i64 %64
  %68 = load double, ptr %67, align 8, !tbaa !6
  %69 = load double, ptr %61, align 8, !tbaa !6
  %70 = tail call double @llvm.fmuladd.f64(double %66, double %68, double %69)
  store double %70, ptr %61, align 8, !tbaa !6
  %71 = getelementptr inbounds nuw [90 x double], ptr %5, i64 %60, i64 %64
  %72 = load double, ptr %71, align 8, !tbaa !6
  %73 = load double, ptr %67, align 8, !tbaa !6
  %74 = load double, ptr %62, align 8, !tbaa !6
  %75 = tail call double @llvm.fmuladd.f64(double %72, double %73, double %74)
  store double %75, ptr %62, align 8, !tbaa !6
  %76 = add nuw nsw i64 %64, 1
  %77 = icmp eq i64 %76, 90
  br i1 %77, label %78, label %63, !llvm.loop !16

78:                                               ; preds = %63
  %79 = load double, ptr %61, align 8, !tbaa !6
  %80 = fmul double %75, 1.200000e+00
  %81 = tail call double @llvm.fmuladd.f64(double %79, double 1.500000e+00, double %80)
  store double %81, ptr %62, align 8, !tbaa !6
  %82 = add nuw nsw i64 %60, 1
  %83 = icmp eq i64 %82, 90
  br i1 %83, label %84, label %59, !llvm.loop !17

84:                                               ; preds = %78
  tail call void @polybench_timer_stop() #6
  tail call void @polybench_timer_print() #6
  %85 = icmp sgt i32 %0, 42
  br i1 %85, label %86, label %115

86:                                               ; preds = %84
  %87 = load ptr, ptr %1, align 8, !tbaa !18
  %88 = load i8, ptr %87, align 1
  %89 = icmp eq i8 %88, 0
  br i1 %89, label %90, label %115

90:                                               ; preds = %86
  %91 = load ptr, ptr @__stderrp, align 8, !tbaa !21
  %92 = tail call i64 @fwrite(ptr nonnull @.str.1, i64 22, i64 1, ptr %91)
  %93 = load ptr, ptr @__stderrp, align 8, !tbaa !21
  %94 = tail call i32 (ptr, ptr, ...) @fprintf(ptr noundef %93, ptr noundef nonnull @.str.2, ptr noundef nonnull @.str.3) #6
  br label %95

95:                                               ; preds = %103, %90
  %96 = phi i64 [ 0, %90 ], [ %108, %103 ]
  %97 = trunc i64 %96 to i8
  %98 = urem i8 %97, 20
  %99 = icmp eq i8 %98, 0
  br i1 %99, label %100, label %103

100:                                              ; preds = %95
  %101 = load ptr, ptr @__stderrp, align 8, !tbaa !21
  %102 = tail call i32 @fputc(i32 10, ptr %101)
  br label %103

103:                                              ; preds = %100, %95
  %104 = load ptr, ptr @__stderrp, align 8, !tbaa !21
  %105 = getelementptr inbounds nuw double, ptr %9, i64 %96
  %106 = load double, ptr %105, align 8, !tbaa !6
  %107 = tail call i32 (ptr, ptr, ...) @fprintf(ptr noundef %104, ptr noundef nonnull @.str.5, double noundef %106) #6
  %108 = add nuw nsw i64 %96, 1
  %109 = icmp eq i64 %108, 90
  br i1 %109, label %110, label %95, !llvm.loop !23

110:                                              ; preds = %103
  %111 = load ptr, ptr @__stderrp, align 8, !tbaa !21
  %112 = tail call i32 (ptr, ptr, ...) @fprintf(ptr noundef %111, ptr noundef nonnull @.str.6, ptr noundef nonnull @.str.3) #6
  %113 = load ptr, ptr @__stderrp, align 8, !tbaa !21
  %114 = tail call i64 @fwrite(ptr nonnull @.str.7, i64 22, i64 1, ptr %113)
  br label %115

115:                                              ; preds = %110, %86, %84
  tail call void @free(ptr noundef %3)
  tail call void @free(ptr noundef %5)
  tail call void @free(ptr noundef %7)
  tail call void @free(ptr noundef %8)
  tail call void @free(ptr noundef nonnull %9)
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
!14 = distinct !{!14, !11, !12}
!15 = distinct !{!15, !11}
!16 = distinct !{!16, !11}
!17 = distinct !{!17, !11}
!18 = !{!19, !19, i64 0}
!19 = !{!"p1 omnipotent char", !20, i64 0}
!20 = !{!"any pointer", !8, i64 0}
!21 = !{!22, !22, i64 0}
!22 = !{!"p1 _ZTS7__sFILE", !20, i64 0}
!23 = distinct !{!23, !11}
