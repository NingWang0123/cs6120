; ModuleID = './polybench/linear-algebra/solvers/trisolv/trisolv.c'
source_filename = "./polybench/linear-algebra/solvers/trisolv/trisolv.c"
target datalayout = "e-m:o-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-n32:64-S128-Fn32"
target triple = "arm64-apple-macosx15.0.0"

@__stderrp = external local_unnamed_addr global ptr, align 8
@.str.1 = private unnamed_addr constant [23 x i8] c"==BEGIN DUMP_ARRAYS==\0A\00", align 1
@.str.2 = private unnamed_addr constant [15 x i8] c"begin dump: %s\00", align 1
@.str.3 = private unnamed_addr constant [2 x i8] c"x\00", align 1
@.str.4 = private unnamed_addr constant [8 x i8] c"%0.2lf \00", align 1
@.str.6 = private unnamed_addr constant [17 x i8] c"\0Aend   dump: %s\0A\00", align 1
@.str.7 = private unnamed_addr constant [23 x i8] c"==END   DUMP_ARRAYS==\0A\00", align 1

; Function Attrs: nounwind ssp uwtable(sync)
define noundef i32 @main(i32 noundef %0, ptr noundef readonly captures(none) %1) local_unnamed_addr #0 {
  %3 = tail call ptr @polybench_alloc_data(i64 noundef 14400, i32 noundef 8) #6
  %4 = tail call ptr @polybench_alloc_data(i64 noundef 120, i32 noundef 8) #6
  %5 = tail call ptr @polybench_alloc_data(i64 noundef 120, i32 noundef 8) #6
  br label %6

6:                                                ; preds = %71, %2
  %7 = phi i64 [ 0, %2 ], [ %72, %71 ]
  %8 = phi i64 [ 1, %2 ], [ %73, %71 ]
  %9 = getelementptr inbounds nuw double, ptr %4, i64 %7
  store double -9.990000e+02, ptr %9, align 8, !tbaa !6
  %10 = trunc nuw nsw i64 %7 to i32
  %11 = uitofp nneg i32 %10 to double
  %12 = getelementptr inbounds nuw double, ptr %5, i64 %7
  store double %11, ptr %12, align 8, !tbaa !6
  %13 = add nuw nsw i64 %7, 120
  %14 = icmp samesign ult i64 %8, 8
  br i1 %14, label %58, label %15

15:                                               ; preds = %6
  %16 = and i64 %8, 9223372036854775800
  %17 = insertelement <2 x i64> poison, i64 %13, i64 0
  %18 = shufflevector <2 x i64> %17, <2 x i64> poison, <2 x i32> zeroinitializer
  br label %19

19:                                               ; preds = %19, %15
  %20 = phi i64 [ 0, %15 ], [ %53, %19 ]
  %21 = phi <2 x i64> [ <i64 0, i64 1>, %15 ], [ %54, %19 ]
  %22 = add <2 x i64> %21, splat (i64 2)
  %23 = add <2 x i64> %21, splat (i64 4)
  %24 = add <2 x i64> %21, splat (i64 6)
  %25 = sub nuw nsw <2 x i64> %18, %21
  %26 = sub nuw nsw <2 x i64> %18, %22
  %27 = sub nuw nsw <2 x i64> %18, %23
  %28 = sub nuw nsw <2 x i64> %18, %24
  %29 = trunc <2 x i64> %25 to <2 x i32>
  %30 = trunc <2 x i64> %26 to <2 x i32>
  %31 = trunc <2 x i64> %27 to <2 x i32>
  %32 = trunc <2 x i64> %28 to <2 x i32>
  %33 = shl <2 x i32> %29, splat (i32 1)
  %34 = shl <2 x i32> %30, splat (i32 1)
  %35 = shl <2 x i32> %31, splat (i32 1)
  %36 = shl <2 x i32> %32, splat (i32 1)
  %37 = add <2 x i32> %33, splat (i32 2)
  %38 = add <2 x i32> %34, splat (i32 2)
  %39 = add <2 x i32> %35, splat (i32 2)
  %40 = add <2 x i32> %36, splat (i32 2)
  %41 = uitofp nneg <2 x i32> %37 to <2 x double>
  %42 = uitofp nneg <2 x i32> %38 to <2 x double>
  %43 = uitofp nneg <2 x i32> %39 to <2 x double>
  %44 = uitofp nneg <2 x i32> %40 to <2 x double>
  %45 = fdiv <2 x double> %41, splat (double 1.200000e+02)
  %46 = fdiv <2 x double> %42, splat (double 1.200000e+02)
  %47 = fdiv <2 x double> %43, splat (double 1.200000e+02)
  %48 = fdiv <2 x double> %44, splat (double 1.200000e+02)
  %49 = getelementptr inbounds nuw [120 x double], ptr %3, i64 %7, i64 %20
  %50 = getelementptr inbounds nuw i8, ptr %49, i64 16
  %51 = getelementptr inbounds nuw i8, ptr %49, i64 32
  %52 = getelementptr inbounds nuw i8, ptr %49, i64 48
  store <2 x double> %45, ptr %49, align 8, !tbaa !6
  store <2 x double> %46, ptr %50, align 8, !tbaa !6
  store <2 x double> %47, ptr %51, align 8, !tbaa !6
  store <2 x double> %48, ptr %52, align 8, !tbaa !6
  %53 = add nuw i64 %20, 8
  %54 = add <2 x i64> %21, splat (i64 8)
  %55 = icmp eq i64 %53, %16
  br i1 %55, label %56, label %19, !llvm.loop !10

56:                                               ; preds = %19
  %57 = icmp eq i64 %8, %16
  br i1 %57, label %71, label %58

58:                                               ; preds = %6, %56
  %59 = phi i64 [ 0, %6 ], [ %16, %56 ]
  br label %60

60:                                               ; preds = %58, %60
  %61 = phi i64 [ %69, %60 ], [ %59, %58 ]
  %62 = sub nuw nsw i64 %13, %61
  %63 = trunc i64 %62 to i32
  %64 = shl i32 %63, 1
  %65 = add i32 %64, 2
  %66 = uitofp nneg i32 %65 to double
  %67 = fdiv double %66, 1.200000e+02
  %68 = getelementptr inbounds nuw [120 x double], ptr %3, i64 %7, i64 %61
  store double %67, ptr %68, align 8, !tbaa !6
  %69 = add nuw nsw i64 %61, 1
  %70 = icmp eq i64 %69, %8
  br i1 %70, label %71, label %60, !llvm.loop !14

71:                                               ; preds = %60, %56
  %72 = add nuw nsw i64 %7, 1
  %73 = add nuw nsw i64 %8, 1
  %74 = icmp eq i64 %72, 120
  br i1 %74, label %75, label %6, !llvm.loop !15

75:                                               ; preds = %71
  tail call void @polybench_timer_start() #6
  br label %76

76:                                               ; preds = %93, %75
  %77 = phi i64 [ 0, %75 ], [ %98, %93 ]
  %78 = getelementptr inbounds nuw double, ptr %5, i64 %77
  %79 = load double, ptr %78, align 8, !tbaa !6
  %80 = getelementptr inbounds nuw double, ptr %4, i64 %77
  store double %79, ptr %80, align 8, !tbaa !6
  %81 = icmp eq i64 %77, 0
  br i1 %81, label %93, label %82

82:                                               ; preds = %76, %82
  %83 = phi i64 [ %91, %82 ], [ 0, %76 ]
  %84 = phi double [ %90, %82 ], [ %79, %76 ]
  %85 = getelementptr inbounds nuw [120 x double], ptr %3, i64 %77, i64 %83
  %86 = load double, ptr %85, align 8, !tbaa !6
  %87 = getelementptr inbounds nuw double, ptr %4, i64 %83
  %88 = load double, ptr %87, align 8, !tbaa !6
  %89 = fneg double %86
  %90 = tail call double @llvm.fmuladd.f64(double %89, double %88, double %84)
  store double %90, ptr %80, align 8, !tbaa !6
  %91 = add nuw nsw i64 %83, 1
  %92 = icmp eq i64 %91, %77
  br i1 %92, label %93, label %82, !llvm.loop !16

93:                                               ; preds = %82, %76
  %94 = phi double [ %79, %76 ], [ %90, %82 ]
  %95 = getelementptr inbounds nuw [120 x double], ptr %3, i64 %77, i64 %77
  %96 = load double, ptr %95, align 8, !tbaa !6
  %97 = fdiv double %94, %96
  store double %97, ptr %80, align 8, !tbaa !6
  %98 = add nuw nsw i64 %77, 1
  %99 = icmp eq i64 %98, 120
  br i1 %99, label %100, label %76, !llvm.loop !17

100:                                              ; preds = %93
  tail call void @polybench_timer_stop() #6
  tail call void @polybench_timer_print() #6
  %101 = icmp sgt i32 %0, 42
  br i1 %101, label %102, label %131

102:                                              ; preds = %100
  %103 = load ptr, ptr %1, align 8, !tbaa !18
  %104 = load i8, ptr %103, align 1
  %105 = icmp eq i8 %104, 0
  br i1 %105, label %106, label %131

106:                                              ; preds = %102
  %107 = load ptr, ptr @__stderrp, align 8, !tbaa !21
  %108 = tail call i64 @fwrite(ptr nonnull @.str.1, i64 22, i64 1, ptr %107)
  %109 = load ptr, ptr @__stderrp, align 8, !tbaa !21
  %110 = tail call i32 (ptr, ptr, ...) @fprintf(ptr noundef %109, ptr noundef nonnull @.str.2, ptr noundef nonnull @.str.3) #6
  br label %111

111:                                              ; preds = %123, %106
  %112 = phi i64 [ 0, %106 ], [ %124, %123 ]
  %113 = load ptr, ptr @__stderrp, align 8, !tbaa !21
  %114 = getelementptr inbounds nuw double, ptr %4, i64 %112
  %115 = load double, ptr %114, align 8, !tbaa !6
  %116 = tail call i32 (ptr, ptr, ...) @fprintf(ptr noundef %113, ptr noundef nonnull @.str.4, double noundef %115) #6
  %117 = trunc i64 %112 to i8
  %118 = urem i8 %117, 20
  %119 = icmp eq i8 %118, 0
  br i1 %119, label %120, label %123

120:                                              ; preds = %111
  %121 = load ptr, ptr @__stderrp, align 8, !tbaa !21
  %122 = tail call i32 @fputc(i32 10, ptr %121)
  br label %123

123:                                              ; preds = %120, %111
  %124 = add nuw nsw i64 %112, 1
  %125 = icmp eq i64 %124, 120
  br i1 %125, label %126, label %111, !llvm.loop !23

126:                                              ; preds = %123
  %127 = load ptr, ptr @__stderrp, align 8, !tbaa !21
  %128 = tail call i32 (ptr, ptr, ...) @fprintf(ptr noundef %127, ptr noundef nonnull @.str.6, ptr noundef nonnull @.str.3) #6
  %129 = load ptr, ptr @__stderrp, align 8, !tbaa !21
  %130 = tail call i64 @fwrite(ptr nonnull @.str.7, i64 22, i64 1, ptr %129)
  br label %131

131:                                              ; preds = %126, %102, %100
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
!14 = distinct !{!14, !11, !13, !12}
!15 = distinct !{!15, !11}
!16 = distinct !{!16, !11}
!17 = distinct !{!17, !11}
!18 = !{!19, !19, i64 0}
!19 = !{!"p1 omnipotent char", !20, i64 0}
!20 = !{!"any pointer", !8, i64 0}
!21 = !{!22, !22, i64 0}
!22 = !{!"p1 _ZTS7__sFILE", !20, i64 0}
!23 = distinct !{!23, !11}
