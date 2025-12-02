; ModuleID = 'polybench_output/trmm.ll'
source_filename = "./polybench/linear-algebra/blas/trmm/trmm.c"
target datalayout = "e-m:o-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-n32:64-S128-Fn32"
target triple = "arm64-apple-macosx15.0.0"

@__stderrp = external local_unnamed_addr global ptr, align 8
@.str.1 = private unnamed_addr constant [23 x i8] c"==BEGIN DUMP_ARRAYS==\0A\00", align 1
@.str.2 = private unnamed_addr constant [15 x i8] c"begin dump: %s\00", align 1
@.str.3 = private unnamed_addr constant [2 x i8] c"B\00", align 1
@.str.5 = private unnamed_addr constant [8 x i8] c"%0.2lf \00", align 1
@.str.6 = private unnamed_addr constant [17 x i8] c"\0Aend   dump: %s\0A\00", align 1
@.str.7 = private unnamed_addr constant [23 x i8] c"==END   DUMP_ARRAYS==\0A\00", align 1

; Function Attrs: nounwind ssp uwtable(sync)
define noundef i32 @main(i32 noundef %0, ptr noundef readonly captures(none) %1) local_unnamed_addr #0 {
  %3 = tail call ptr @polybench_alloc_data(i64 noundef 3600, i32 noundef 8) #6
  %4 = tail call ptr @polybench_alloc_data(i64 noundef 4800, i32 noundef 8) #6
  br label %5

5:                                                ; preds = %99, %2
  %6 = phi i64 [ 0, %2 ], [ %100, %99 ]
  %7 = icmp eq i64 %6, 0
  br i1 %7, label %61, label %8

8:                                                ; preds = %5
  %9 = icmp samesign ult i64 %6, 8
  br i1 %9, label %49, label %10

10:                                               ; preds = %8
  %11 = and i64 %6, 9223372036854775800
  %12 = insertelement <2 x i64> poison, i64 %6, i64 0
  %13 = shufflevector <2 x i64> %12, <2 x i64> poison, <2 x i32> zeroinitializer
  %14 = add <2 x i64> splat (i64 2), %13
  %15 = add <2 x i64> splat (i64 4), %13
  %16 = add <2 x i64> splat (i64 6), %13
  br label %17

17:                                               ; preds = %17, %10
  %18 = phi i64 [ 0, %10 ], [ %44, %17 ]
  %19 = phi <2 x i64> [ <i64 0, i64 1>, %10 ], [ %45, %17 ]
  %20 = add nuw nsw <2 x i64> %19, %13
  %21 = add <2 x i64> %19, %14
  %22 = add <2 x i64> %19, %15
  %23 = add <2 x i64> %19, %16
  %24 = trunc nuw nsw <2 x i64> %20 to <2 x i32>
  %25 = trunc nuw nsw <2 x i64> %21 to <2 x i32>
  %26 = trunc nuw nsw <2 x i64> %22 to <2 x i32>
  %27 = trunc nuw nsw <2 x i64> %23 to <2 x i32>
  %28 = urem <2 x i32> %24, splat (i32 60)
  %29 = urem <2 x i32> %25, splat (i32 60)
  %30 = urem <2 x i32> %26, splat (i32 60)
  %31 = urem <2 x i32> %27, splat (i32 60)
  %32 = uitofp nneg <2 x i32> %28 to <2 x double>
  %33 = uitofp nneg <2 x i32> %29 to <2 x double>
  %34 = uitofp nneg <2 x i32> %30 to <2 x double>
  %35 = uitofp nneg <2 x i32> %31 to <2 x double>
  %36 = fdiv <2 x double> %32, splat (double 6.000000e+01)
  %37 = fdiv <2 x double> %33, splat (double 6.000000e+01)
  %38 = fdiv <2 x double> %34, splat (double 6.000000e+01)
  %39 = fdiv <2 x double> %35, splat (double 6.000000e+01)
  %40 = getelementptr inbounds nuw [60 x double], ptr %3, i64 %6, i64 %18
  %41 = getelementptr inbounds nuw i8, ptr %40, i64 16
  %42 = getelementptr inbounds nuw i8, ptr %40, i64 32
  %43 = getelementptr inbounds nuw i8, ptr %40, i64 48
  store <2 x double> %36, ptr %40, align 8, !tbaa !6
  store <2 x double> %37, ptr %41, align 8, !tbaa !6
  store <2 x double> %38, ptr %42, align 8, !tbaa !6
  store <2 x double> %39, ptr %43, align 8, !tbaa !6
  %44 = add nuw i64 %18, 8
  %45 = add <2 x i64> %19, splat (i64 8)
  %46 = icmp eq i64 %44, %11
  br i1 %46, label %47, label %17, !llvm.loop !10

47:                                               ; preds = %17
  %48 = icmp eq i64 %6, %11
  br i1 %48, label %61, label %49

49:                                               ; preds = %47, %8
  %50 = phi i64 [ 0, %8 ], [ %11, %47 ]
  br label %51

51:                                               ; preds = %51, %49
  %52 = phi i64 [ %59, %51 ], [ %50, %49 ]
  %53 = add nuw nsw i64 %52, %6
  %54 = trunc nuw nsw i64 %53 to i32
  %55 = urem i32 %54, 60
  %56 = uitofp nneg i32 %55 to double
  %57 = fdiv double %56, 6.000000e+01
  %58 = getelementptr inbounds nuw [60 x double], ptr %3, i64 %6, i64 %52
  store double %57, ptr %58, align 8, !tbaa !6
  %59 = add nuw nsw i64 %52, 1
  %60 = icmp eq i64 %59, %6
  br i1 %60, label %.loopexit1, label %51, !llvm.loop !14

.loopexit1:                                       ; preds = %51
  br label %61

61:                                               ; preds = %.loopexit1, %47, %5
  %62 = getelementptr inbounds nuw [60 x double], ptr %3, i64 %6, i64 %6
  store double 1.000000e+00, ptr %62, align 8, !tbaa !6
  %63 = add nuw nsw i64 %6, 80
  %64 = insertelement <2 x i64> poison, i64 %63, i64 0
  %65 = shufflevector <2 x i64> %64, <2 x i64> poison, <2 x i32> zeroinitializer
  br label %66

66:                                               ; preds = %66, %61
  %67 = phi i64 [ 0, %61 ], [ %96, %66 ]
  %68 = phi <2 x i64> [ <i64 0, i64 1>, %61 ], [ %97, %66 ]
  %69 = add <2 x i64> %68, splat (i64 2)
  %70 = add <2 x i64> %68, splat (i64 4)
  %71 = add <2 x i64> %68, splat (i64 6)
  %72 = sub nuw nsw <2 x i64> %65, %68
  %73 = sub nuw nsw <2 x i64> %65, %69
  %74 = sub nuw nsw <2 x i64> %65, %70
  %75 = sub nuw nsw <2 x i64> %65, %71
  %76 = trunc nuw nsw <2 x i64> %72 to <2 x i32>
  %77 = trunc nuw nsw <2 x i64> %73 to <2 x i32>
  %78 = trunc nuw nsw <2 x i64> %74 to <2 x i32>
  %79 = trunc nuw nsw <2 x i64> %75 to <2 x i32>
  %80 = urem <2 x i32> %76, splat (i32 80)
  %81 = urem <2 x i32> %77, splat (i32 80)
  %82 = urem <2 x i32> %78, splat (i32 80)
  %83 = urem <2 x i32> %79, splat (i32 80)
  %84 = uitofp nneg <2 x i32> %80 to <2 x double>
  %85 = uitofp nneg <2 x i32> %81 to <2 x double>
  %86 = uitofp nneg <2 x i32> %82 to <2 x double>
  %87 = uitofp nneg <2 x i32> %83 to <2 x double>
  %88 = fdiv <2 x double> %84, splat (double 8.000000e+01)
  %89 = fdiv <2 x double> %85, splat (double 8.000000e+01)
  %90 = fdiv <2 x double> %86, splat (double 8.000000e+01)
  %91 = fdiv <2 x double> %87, splat (double 8.000000e+01)
  %92 = getelementptr inbounds nuw [80 x double], ptr %4, i64 %6, i64 %67
  %93 = getelementptr inbounds nuw i8, ptr %92, i64 16
  %94 = getelementptr inbounds nuw i8, ptr %92, i64 32
  %95 = getelementptr inbounds nuw i8, ptr %92, i64 48
  store <2 x double> %88, ptr %92, align 8, !tbaa !6
  store <2 x double> %89, ptr %93, align 8, !tbaa !6
  store <2 x double> %90, ptr %94, align 8, !tbaa !6
  store <2 x double> %91, ptr %95, align 8, !tbaa !6
  %96 = add nuw i64 %67, 8
  %97 = add <2 x i64> %68, splat (i64 8)
  %98 = icmp eq i64 %96, 80
  br i1 %98, label %99, label %66, !llvm.loop !15

99:                                               ; preds = %66
  %100 = add nuw nsw i64 %6, 1
  %101 = icmp eq i64 %100, 60
  br i1 %101, label %102, label %5, !llvm.loop !16

102:                                              ; preds = %99
  tail call void @polybench_timer_start() #6
  br label %103

103:                                              ; preds = %125, %102
  %104 = phi i64 [ 0, %102 ], [ %126, %125 ]
  %105 = icmp samesign ult i64 %104, 59
  br label %106

106:                                              ; preds = %120, %103
  %107 = phi i64 [ 0, %103 ], [ %123, %120 ]
  %108 = getelementptr inbounds nuw [80 x double], ptr %4, i64 %104, i64 %107
  %109 = load double, ptr %108, align 8, !tbaa !6
  br i1 %105, label %.preheader, label %120

.preheader:                                       ; preds = %106
  br label %110

110:                                              ; preds = %.preheader, %110
  %111 = phi i64 [ %113, %110 ], [ %104, %.preheader ]
  %112 = phi double [ %118, %110 ], [ %109, %.preheader ]
  %113 = add nuw nsw i64 %111, 1
  %114 = getelementptr inbounds nuw [60 x double], ptr %3, i64 %113, i64 %104
  %115 = load double, ptr %114, align 8, !tbaa !6
  %116 = getelementptr inbounds nuw [80 x double], ptr %4, i64 %113, i64 %107
  %117 = load double, ptr %116, align 8, !tbaa !6
  %118 = tail call double @llvm.fmuladd.f64(double %115, double %117, double %112)
  store double %118, ptr %108, align 8, !tbaa !6
  %119 = icmp eq i64 %113, 59
  br i1 %119, label %.loopexit, label %110, !llvm.loop !17

.loopexit:                                        ; preds = %110
  br label %120

120:                                              ; preds = %.loopexit, %106
  %121 = phi double [ %109, %106 ], [ %118, %.loopexit ]
  %122 = fmul double %121, 1.500000e+00
  store double %122, ptr %108, align 8, !tbaa !6
  %123 = add nuw nsw i64 %107, 1
  %124 = icmp eq i64 %123, 80
  br i1 %124, label %125, label %106, !llvm.loop !18

125:                                              ; preds = %120
  %126 = add nuw nsw i64 %104, 1
  %127 = icmp eq i64 %126, 60
  br i1 %127, label %128, label %103, !llvm.loop !19

128:                                              ; preds = %125
  tail call void @polybench_timer_stop() #6
  tail call void @polybench_timer_print() #6
  %129 = icmp sgt i32 %0, 42
  br i1 %129, label %130, label %166

130:                                              ; preds = %128
  %131 = load ptr, ptr %1, align 8, !tbaa !20
  %132 = load i8, ptr %131, align 1
  %133 = icmp eq i8 %132, 0
  br i1 %133, label %134, label %166

134:                                              ; preds = %130
  %135 = load ptr, ptr @__stderrp, align 8, !tbaa !23
  %136 = tail call i64 @fwrite(ptr nonnull @.str.1, i64 22, i64 1, ptr %135)
  %137 = load ptr, ptr @__stderrp, align 8, !tbaa !23
  %138 = tail call i32 (ptr, ptr, ...) @fprintf(ptr noundef %137, ptr noundef nonnull @.str.2, ptr noundef nonnull @.str.3) #6
  br label %139

139:                                              ; preds = %158, %134
  %140 = phi i64 [ 0, %134 ], [ %159, %158 ]
  %141 = mul nuw nsw i64 %140, 60
  br label %142

142:                                              ; preds = %151, %139
  %143 = phi i64 [ 0, %139 ], [ %156, %151 ]
  %144 = add nuw nsw i64 %143, %141
  %145 = trunc nuw nsw i64 %144 to i32
  %146 = urem i32 %145, 20
  %147 = icmp eq i32 %146, 0
  br i1 %147, label %148, label %151

148:                                              ; preds = %142
  %149 = load ptr, ptr @__stderrp, align 8, !tbaa !23
  %150 = tail call i32 @fputc(i32 10, ptr %149)
  br label %151

151:                                              ; preds = %148, %142
  %152 = load ptr, ptr @__stderrp, align 8, !tbaa !23
  %153 = getelementptr inbounds nuw [80 x double], ptr %4, i64 %140, i64 %143
  %154 = load double, ptr %153, align 8, !tbaa !6
  %155 = tail call i32 (ptr, ptr, ...) @fprintf(ptr noundef %152, ptr noundef nonnull @.str.5, double noundef %154) #6
  %156 = add nuw nsw i64 %143, 1
  %157 = icmp eq i64 %156, 80
  br i1 %157, label %158, label %142, !llvm.loop !25

158:                                              ; preds = %151
  %159 = add nuw nsw i64 %140, 1
  %160 = icmp eq i64 %159, 60
  br i1 %160, label %161, label %139, !llvm.loop !26

161:                                              ; preds = %158
  %162 = load ptr, ptr @__stderrp, align 8, !tbaa !23
  %163 = tail call i32 (ptr, ptr, ...) @fprintf(ptr noundef %162, ptr noundef nonnull @.str.6, ptr noundef nonnull @.str.3) #6
  %164 = load ptr, ptr @__stderrp, align 8, !tbaa !23
  %165 = tail call i64 @fwrite(ptr nonnull @.str.7, i64 22, i64 1, ptr %164)
  br label %166

166:                                              ; preds = %161, %130, %128
  tail call void @free(ptr noundef %3)
  tail call void @free(ptr noundef nonnull %4)
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
!14 = distinct !{!14, !11, !13, !12}
!15 = distinct !{!15, !11, !12, !13}
!16 = distinct !{!16, !11}
!17 = distinct !{!17, !11}
!18 = distinct !{!18, !11}
!19 = distinct !{!19, !11}
!20 = !{!21, !21, i64 0}
!21 = !{!"p1 omnipotent char", !22, i64 0}
!22 = !{!"any pointer", !8, i64 0}
!23 = !{!24, !24, i64 0}
!24 = !{!"p1 _ZTS7__sFILE", !22, i64 0}
!25 = distinct !{!25, !11}
!26 = distinct !{!26, !11}
