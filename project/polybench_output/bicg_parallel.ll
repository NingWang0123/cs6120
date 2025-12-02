; ModuleID = 'polybench_output/bicg.ll'
source_filename = "./polybench/linear-algebra/kernels/bicg/bicg.c"
target datalayout = "e-m:o-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-n32:64-S128-Fn32"
target triple = "arm64-apple-macosx15.0.0"

@__stderrp = external local_unnamed_addr global ptr, align 8
@.str.1 = private unnamed_addr constant [23 x i8] c"==BEGIN DUMP_ARRAYS==\0A\00", align 1
@.str.2 = private unnamed_addr constant [15 x i8] c"begin dump: %s\00", align 1
@.str.3 = private unnamed_addr constant [2 x i8] c"s\00", align 1
@.str.5 = private unnamed_addr constant [8 x i8] c"%0.2lf \00", align 1
@.str.6 = private unnamed_addr constant [17 x i8] c"\0Aend   dump: %s\0A\00", align 1
@.str.7 = private unnamed_addr constant [2 x i8] c"q\00", align 1
@.str.8 = private unnamed_addr constant [23 x i8] c"==END   DUMP_ARRAYS==\0A\00", align 1

; Function Attrs: nounwind ssp uwtable(sync)
define noundef i32 @main(i32 noundef %0, ptr noundef readonly captures(none) %1) local_unnamed_addr #0 {
  %3 = tail call ptr @polybench_alloc_data(i64 noundef 14384, i32 noundef 8) #7
  %4 = tail call ptr @polybench_alloc_data(i64 noundef 116, i32 noundef 8) #7
  %5 = tail call ptr @polybench_alloc_data(i64 noundef 124, i32 noundef 8) #7
  %6 = tail call ptr @polybench_alloc_data(i64 noundef 116, i32 noundef 8) #7
  %7 = tail call ptr @polybench_alloc_data(i64 noundef 124, i32 noundef 8) #7
  br label %8

8:                                                ; preds = %8, %2
  %9 = phi i64 [ 0, %2 ], [ %26, %8 ]
  %10 = phi <2 x i32> [ <i32 0, i32 1>, %2 ], [ %27, %8 ]
  %11 = add <2 x i32> %10, splat (i32 2)
  %12 = add <2 x i32> %10, splat (i32 4)
  %13 = add <2 x i32> %10, splat (i32 6)
  %14 = uitofp nneg <2 x i32> %10 to <2 x double>
  %15 = uitofp nneg <2 x i32> %11 to <2 x double>
  %16 = uitofp nneg <2 x i32> %12 to <2 x double>
  %17 = uitofp nneg <2 x i32> %13 to <2 x double>
  %18 = fdiv <2 x double> %14, splat (double 1.160000e+02)
  %19 = fdiv <2 x double> %15, splat (double 1.160000e+02)
  %20 = fdiv <2 x double> %16, splat (double 1.160000e+02)
  %21 = fdiv <2 x double> %17, splat (double 1.160000e+02)
  %22 = getelementptr inbounds nuw double, ptr %6, i64 %9
  %23 = getelementptr inbounds nuw i8, ptr %22, i64 16
  %24 = getelementptr inbounds nuw i8, ptr %22, i64 32
  %25 = getelementptr inbounds nuw i8, ptr %22, i64 48
  store <2 x double> %18, ptr %22, align 8, !tbaa !6
  store <2 x double> %19, ptr %23, align 8, !tbaa !6
  store <2 x double> %20, ptr %24, align 8, !tbaa !6
  store <2 x double> %21, ptr %25, align 8, !tbaa !6
  %26 = add nuw i64 %9, 8
  %27 = add <2 x i32> %10, splat (i32 8)
  %28 = icmp eq i64 %26, 112
  br i1 %28, label %29, label %8, !llvm.loop !10

29:                                               ; preds = %8
  %30 = getelementptr inbounds nuw i8, ptr %6, i64 896
  store double 0x3FEEE58469EE5847, ptr %30, align 8, !tbaa !6
  %31 = getelementptr inbounds nuw i8, ptr %6, i64 904
  store double 0x3FEF2C234F72C235, ptr %31, align 8, !tbaa !6
  %32 = getelementptr inbounds nuw i8, ptr %6, i64 912
  store double 0x3FEF72C234F72C23, ptr %32, align 8, !tbaa !6
  %33 = getelementptr inbounds nuw i8, ptr %6, i64 920
  store double 0x3FEFB9611A7B9612, ptr %33, align 8, !tbaa !6
  br label %34

34:                                               ; preds = %55, %29
  %35 = phi i64 [ %56, %55 ], [ 0, %29 ]
  %36 = trunc nuw nsw i64 %35 to i32
  %37 = uitofp nneg i32 %36 to double
  %38 = fdiv double %37, 1.240000e+02
  %39 = getelementptr inbounds nuw double, ptr %7, i64 %35
  store double %38, ptr %39, align 8, !tbaa !6
  %40 = insertelement <2 x i64> poison, i64 %35, i64 0
  %41 = shufflevector <2 x i64> %40, <2 x i64> poison, <2 x i32> zeroinitializer
  br label %42

42:                                               ; preds = %42, %34
  %43 = phi i64 [ 0, %34 ], [ %52, %42 ]
  %44 = phi <2 x i64> [ <i64 0, i64 1>, %34 ], [ %53, %42 ]
  %45 = add nuw nsw <2 x i64> %44, splat (i64 1)
  %46 = mul nuw nsw <2 x i64> %45, %41
  %47 = trunc nuw nsw <2 x i64> %46 to <2 x i32>
  %48 = urem <2 x i32> %47, splat (i32 124)
  %49 = uitofp nneg <2 x i32> %48 to <2 x double>
  %50 = fdiv <2 x double> %49, splat (double 1.240000e+02)
  %51 = getelementptr inbounds nuw [116 x double], ptr %3, i64 %35, i64 %43
  store <2 x double> %50, ptr %51, align 8, !tbaa !6
  %52 = add nuw i64 %43, 2
  %53 = add <2 x i64> %44, splat (i64 2)
  %54 = icmp eq i64 %52, 116
  br i1 %54, label %55, label %42, !llvm.loop !14

55:                                               ; preds = %42
  %56 = add nuw nsw i64 %35, 1
  %57 = icmp eq i64 %56, 124
  br i1 %57, label %58, label %34, !llvm.loop !15

58:                                               ; preds = %55
  tail call void @polybench_timer_start() #7
  tail call void @llvm.memset.p0.i64(ptr noundef nonnull align 8 dereferenceable(928) %4, i8 0, i64 928, i1 false), !tbaa !6
  br label %59

59:                                               ; preds = %78, %58
  %60 = phi i64 [ 0, %58 ], [ %79, %78 ]
  %61 = getelementptr inbounds nuw double, ptr %5, i64 %60
  store double 0.000000e+00, ptr %61, align 8, !tbaa !6
  %62 = getelementptr inbounds nuw double, ptr %7, i64 %60
  br label %63

63:                                               ; preds = %63, %59
  %64 = phi i64 [ 0, %59 ], [ %76, %63 ]
  %65 = getelementptr inbounds nuw double, ptr %4, i64 %64
  %66 = load double, ptr %65, align 8, !tbaa !6
  %67 = load double, ptr %62, align 8, !tbaa !6
  %68 = getelementptr inbounds nuw [116 x double], ptr %3, i64 %60, i64 %64
  %69 = load double, ptr %68, align 8, !tbaa !6
  %70 = tail call double @llvm.fmuladd.f64(double %67, double %69, double %66)
  store double %70, ptr %65, align 8, !tbaa !6
  %71 = load double, ptr %61, align 8, !tbaa !6
  %72 = load double, ptr %68, align 8, !tbaa !6
  %73 = getelementptr inbounds nuw double, ptr %6, i64 %64
  %74 = load double, ptr %73, align 8, !tbaa !6
  %75 = tail call double @llvm.fmuladd.f64(double %72, double %74, double %71)
  store double %75, ptr %61, align 8, !tbaa !6
  %76 = add nuw nsw i64 %64, 1
  %77 = icmp eq i64 %76, 116
  br i1 %77, label %78, label %63, !llvm.loop !16

78:                                               ; preds = %63
  %79 = add nuw nsw i64 %60, 1
  %80 = icmp eq i64 %79, 124
  br i1 %80, label %81, label %59, !llvm.loop !17

81:                                               ; preds = %78
  tail call void @polybench_timer_stop() #7
  tail call void @polybench_timer_print() #7
  %82 = icmp sgt i32 %0, 42
  br i1 %82, label %83, label %132

83:                                               ; preds = %81
  %84 = load ptr, ptr %1, align 8, !tbaa !18
  %85 = load i8, ptr %84, align 1
  %86 = icmp eq i8 %85, 0
  br i1 %86, label %87, label %132

87:                                               ; preds = %83
  %88 = load ptr, ptr @__stderrp, align 8, !tbaa !21
  %89 = tail call i64 @fwrite(ptr nonnull @.str.1, i64 22, i64 1, ptr %88)
  %90 = load ptr, ptr @__stderrp, align 8, !tbaa !21
  %91 = tail call i32 (ptr, ptr, ...) @fprintf(ptr noundef %90, ptr noundef nonnull @.str.2, ptr noundef nonnull @.str.3) #7
  br label %92

92:                                               ; preds = %100, %87
  %93 = phi i64 [ 0, %87 ], [ %105, %100 ]
  %94 = trunc i64 %93 to i8
  %95 = urem i8 %94, 20
  %96 = icmp eq i8 %95, 0
  br i1 %96, label %97, label %100

97:                                               ; preds = %92
  %98 = load ptr, ptr @__stderrp, align 8, !tbaa !21
  %99 = tail call i32 @fputc(i32 10, ptr %98)
  br label %100

100:                                              ; preds = %97, %92
  %101 = load ptr, ptr @__stderrp, align 8, !tbaa !21
  %102 = getelementptr inbounds nuw double, ptr %4, i64 %93
  %103 = load double, ptr %102, align 8, !tbaa !6
  %104 = tail call i32 (ptr, ptr, ...) @fprintf(ptr noundef %101, ptr noundef nonnull @.str.5, double noundef %103) #7
  %105 = add nuw nsw i64 %93, 1
  %106 = icmp eq i64 %105, 116
  br i1 %106, label %107, label %92, !llvm.loop !23

107:                                              ; preds = %100
  %108 = load ptr, ptr @__stderrp, align 8, !tbaa !21
  %109 = tail call i32 (ptr, ptr, ...) @fprintf(ptr noundef %108, ptr noundef nonnull @.str.6, ptr noundef nonnull @.str.3) #7
  %110 = load ptr, ptr @__stderrp, align 8, !tbaa !21
  %111 = tail call i32 (ptr, ptr, ...) @fprintf(ptr noundef %110, ptr noundef nonnull @.str.2, ptr noundef nonnull @.str.7) #7
  br label %112

112:                                              ; preds = %120, %107
  %113 = phi i64 [ 0, %107 ], [ %125, %120 ]
  %114 = trunc i64 %113 to i8
  %115 = urem i8 %114, 20
  %116 = icmp eq i8 %115, 0
  br i1 %116, label %117, label %120

117:                                              ; preds = %112
  %118 = load ptr, ptr @__stderrp, align 8, !tbaa !21
  %119 = tail call i32 @fputc(i32 10, ptr %118)
  br label %120

120:                                              ; preds = %117, %112
  %121 = load ptr, ptr @__stderrp, align 8, !tbaa !21
  %122 = getelementptr inbounds nuw double, ptr %5, i64 %113
  %123 = load double, ptr %122, align 8, !tbaa !6
  %124 = tail call i32 (ptr, ptr, ...) @fprintf(ptr noundef %121, ptr noundef nonnull @.str.5, double noundef %123) #7
  %125 = add nuw nsw i64 %113, 1
  %126 = icmp eq i64 %125, 124
  br i1 %126, label %127, label %112, !llvm.loop !24

127:                                              ; preds = %120
  %128 = load ptr, ptr @__stderrp, align 8, !tbaa !21
  %129 = tail call i32 (ptr, ptr, ...) @fprintf(ptr noundef %128, ptr noundef nonnull @.str.6, ptr noundef nonnull @.str.7) #7
  %130 = load ptr, ptr @__stderrp, align 8, !tbaa !21
  %131 = tail call i64 @fwrite(ptr nonnull @.str.8, i64 22, i64 1, ptr %130)
  br label %132

132:                                              ; preds = %127, %83, %81
  tail call void @free(ptr noundef %3)
  tail call void @free(ptr noundef %4)
  tail call void @free(ptr noundef nonnull %5)
  tail call void @free(ptr noundef %6)
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
!14 = distinct !{!14, !11, !12, !13}
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
