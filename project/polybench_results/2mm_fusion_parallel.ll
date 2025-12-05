; ModuleID = 'polybench_results/2mm.ll'
source_filename = "./polybench/linear-algebra/kernels/2mm/2mm.c"
target datalayout = "e-m:o-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-n32:64-S128-Fn32"
target triple = "arm64-apple-macosx15.0.0"

@__stderrp = external local_unnamed_addr global ptr, align 8
@.str.1 = private unnamed_addr constant [23 x i8] c"==BEGIN DUMP_ARRAYS==\0A\00", align 1
@.str.2 = private unnamed_addr constant [15 x i8] c"begin dump: %s\00", align 1
@.str.3 = private unnamed_addr constant [2 x i8] c"D\00", align 1
@.str.5 = private unnamed_addr constant [8 x i8] c"%0.2lf \00", align 1
@.str.6 = private unnamed_addr constant [17 x i8] c"\0Aend   dump: %s\0A\00", align 1
@.str.7 = private unnamed_addr constant [23 x i8] c"==END   DUMP_ARRAYS==\0A\00", align 1

; Function Attrs: nounwind ssp uwtable(sync)
define noundef i32 @main(i32 noundef %0, ptr noundef readonly captures(none) %1) local_unnamed_addr #0 {
  %3 = tail call ptr @polybench_alloc_data(i64 noundef 2000, i32 noundef 8) #6
  %4 = tail call ptr @polybench_alloc_data(i64 noundef 2800, i32 noundef 8) #6
  %5 = tail call ptr @polybench_alloc_data(i64 noundef 3500, i32 noundef 8) #6
  %6 = tail call ptr @polybench_alloc_data(i64 noundef 4000, i32 noundef 8) #6
  %7 = tail call ptr @polybench_alloc_data(i64 noundef 3200, i32 noundef 8) #6
  br label %8

8:                                                ; preds = %25, %2
  %9 = phi i64 [ 0, %2 ], [ %26, %25 ]
  %10 = insertelement <2 x i64> poison, i64 %9, i64 0
  %11 = shufflevector <2 x i64> %10, <2 x i64> poison, <2 x i32> zeroinitializer
  br label %12

12:                                               ; preds = %12, %8
  %13 = phi i64 [ 0, %8 ], [ %22, %12 ]
  %14 = phi <2 x i64> [ <i64 0, i64 1>, %8 ], [ %23, %12 ]
  %15 = mul nuw nsw <2 x i64> %14, %11
  %16 = trunc <2 x i64> %15 to <2 x i32>
  %17 = add <2 x i32> %16, splat (i32 1)
  %18 = urem <2 x i32> %17, splat (i32 40)
  %19 = uitofp nneg <2 x i32> %18 to <2 x double>
  %20 = fdiv <2 x double> %19, splat (double 4.000000e+01)
  %21 = getelementptr inbounds nuw [70 x double], ptr %4, i64 %9, i64 %13
  store <2 x double> %20, ptr %21, align 8, !tbaa !6
  %22 = add nuw i64 %13, 2
  %23 = add <2 x i64> %14, splat (i64 2)
  %24 = icmp eq i64 %22, 70
  br i1 %24, label %25, label %12, !llvm.loop !10

25:                                               ; preds = %12
  %26 = add nuw nsw i64 %9, 1
  %27 = icmp eq i64 %26, 40
  br i1 %27, label %.preheader3, label %8, !llvm.loop !14

.preheader3:                                      ; preds = %25
  br label %28

28:                                               ; preds = %.preheader3, %45
  %29 = phi i64 [ %46, %45 ], [ 0, %.preheader3 ]
  %30 = insertelement <2 x i64> poison, i64 %29, i64 0
  %31 = shufflevector <2 x i64> %30, <2 x i64> poison, <2 x i32> zeroinitializer
  br label %32

32:                                               ; preds = %32, %28
  %33 = phi i64 [ 0, %28 ], [ %42, %32 ]
  %34 = phi <2 x i64> [ <i64 0, i64 1>, %28 ], [ %43, %32 ]
  %35 = add nuw nsw <2 x i64> %34, splat (i64 1)
  %36 = mul nuw nsw <2 x i64> %35, %31
  %37 = trunc nuw nsw <2 x i64> %36 to <2 x i32>
  %38 = urem <2 x i32> %37, splat (i32 50)
  %39 = uitofp nneg <2 x i32> %38 to <2 x double>
  %40 = fdiv <2 x double> %39, splat (double 5.000000e+01)
  %41 = getelementptr inbounds nuw [50 x double], ptr %5, i64 %29, i64 %33
  store <2 x double> %40, ptr %41, align 8, !tbaa !6
  %42 = add nuw i64 %33, 2
  %43 = add <2 x i64> %34, splat (i64 2)
  %44 = icmp eq i64 %42, 50
  br i1 %44, label %45, label %32, !llvm.loop !15

45:                                               ; preds = %32
  %46 = add nuw nsw i64 %29, 1
  %47 = icmp eq i64 %46, 70
  br i1 %47, label %.preheader2, label %28, !llvm.loop !16

.preheader2:                                      ; preds = %45
  br label %48

48:                                               ; preds = %.preheader2, %66
  %49 = phi i64 [ %67, %66 ], [ 0, %.preheader2 ]
  %50 = insertelement <2 x i64> poison, i64 %49, i64 0
  %51 = shufflevector <2 x i64> %50, <2 x i64> poison, <2 x i32> zeroinitializer
  br label %52

52:                                               ; preds = %52, %48
  %53 = phi i64 [ 0, %48 ], [ %63, %52 ]
  %54 = phi <2 x i64> [ <i64 0, i64 1>, %48 ], [ %64, %52 ]
  %55 = add nuw nsw <2 x i64> %54, splat (i64 3)
  %56 = mul nuw nsw <2 x i64> %55, %51
  %57 = trunc <2 x i64> %56 to <2 x i32>
  %58 = add <2 x i32> %57, splat (i32 1)
  %59 = urem <2 x i32> %58, splat (i32 80)
  %60 = uitofp nneg <2 x i32> %59 to <2 x double>
  %61 = fdiv <2 x double> %60, splat (double 8.000000e+01)
  %62 = getelementptr inbounds nuw [80 x double], ptr %6, i64 %49, i64 %53
  store <2 x double> %61, ptr %62, align 8, !tbaa !6
  %63 = add nuw i64 %53, 2
  %64 = add <2 x i64> %54, splat (i64 2)
  %65 = icmp eq i64 %63, 80
  br i1 %65, label %66, label %52, !llvm.loop !17

66:                                               ; preds = %52
  %67 = add nuw nsw i64 %49, 1
  %68 = icmp eq i64 %67, 50
  br i1 %68, label %.preheader1, label %48, !llvm.loop !18

.preheader1:                                      ; preds = %66
  br label %69

69:                                               ; preds = %.preheader1, %86
  %70 = phi i64 [ %87, %86 ], [ 0, %.preheader1 ]
  %71 = insertelement <2 x i64> poison, i64 %70, i64 0
  %72 = shufflevector <2 x i64> %71, <2 x i64> poison, <2 x i32> zeroinitializer
  br label %73

73:                                               ; preds = %73, %69
  %74 = phi i64 [ 0, %69 ], [ %83, %73 ]
  %75 = phi <2 x i64> [ <i64 0, i64 1>, %69 ], [ %84, %73 ]
  %76 = add nuw nsw <2 x i64> %75, splat (i64 2)
  %77 = mul nuw nsw <2 x i64> %76, %72
  %78 = trunc nuw nsw <2 x i64> %77 to <2 x i32>
  %79 = urem <2 x i32> %78, splat (i32 70)
  %80 = uitofp nneg <2 x i32> %79 to <2 x double>
  %81 = fdiv <2 x double> %80, splat (double 7.000000e+01)
  %82 = getelementptr inbounds nuw [80 x double], ptr %7, i64 %70, i64 %74
  store <2 x double> %81, ptr %82, align 8, !tbaa !6
  %83 = add nuw i64 %74, 2
  %84 = add <2 x i64> %75, splat (i64 2)
  %85 = icmp eq i64 %83, 80
  br i1 %85, label %86, label %73, !llvm.loop !19

86:                                               ; preds = %73
  %87 = add nuw nsw i64 %70, 1
  %88 = icmp eq i64 %87, 40
  br i1 %88, label %89, label %69, !llvm.loop !20

89:                                               ; preds = %86
  tail call void @polybench_timer_start() #6
  br label %90

90:                                               ; preds = %109, %89
  %91 = phi i64 [ 0, %89 ], [ %110, %109 ]
  br label %92

92:                                               ; preds = %106, %90
  %93 = phi i64 [ 0, %90 ], [ %107, %106 ]
  %94 = getelementptr inbounds nuw [50 x double], ptr %3, i64 %91, i64 %93
  store double 0.000000e+00, ptr %94, align 8, !tbaa !6
  br label %95

95:                                               ; preds = %95, %92
  %96 = phi i64 [ 0, %92 ], [ %104, %95 ]
  %97 = phi double [ 0.000000e+00, %92 ], [ %103, %95 ]
  %98 = getelementptr inbounds nuw [70 x double], ptr %4, i64 %91, i64 %96
  %99 = load double, ptr %98, align 8, !tbaa !6
  %100 = fmul double %99, 1.500000e+00
  %101 = getelementptr inbounds nuw [50 x double], ptr %5, i64 %96, i64 %93
  %102 = load double, ptr %101, align 8, !tbaa !6
  %103 = tail call double @llvm.fmuladd.f64(double %100, double %102, double %97)
  store double %103, ptr %94, align 8, !tbaa !6
  %104 = add nuw nsw i64 %96, 1
  %105 = icmp eq i64 %104, 70
  br i1 %105, label %106, label %95, !llvm.loop !21

106:                                              ; preds = %95
  %107 = add nuw nsw i64 %93, 1
  %108 = icmp eq i64 %107, 50
  br i1 %108, label %109, label %92, !llvm.loop !22

109:                                              ; preds = %106
  %110 = add nuw nsw i64 %91, 1
  %111 = icmp eq i64 %110, 40
  br i1 %111, label %.preheader, label %90, !llvm.loop !23

.preheader:                                       ; preds = %109
  br label %112

112:                                              ; preds = %.preheader, %132
  %113 = phi i64 [ %133, %132 ], [ 0, %.preheader ]
  br label %114

114:                                              ; preds = %129, %112
  %115 = phi i64 [ 0, %112 ], [ %130, %129 ]
  %116 = getelementptr inbounds nuw [80 x double], ptr %7, i64 %113, i64 %115
  %117 = load double, ptr %116, align 8, !tbaa !6
  %118 = fmul double %117, 1.200000e+00
  store double %118, ptr %116, align 8, !tbaa !6
  br label %119

119:                                              ; preds = %119, %114
  %120 = phi i64 [ 0, %114 ], [ %127, %119 ]
  %121 = phi double [ %118, %114 ], [ %126, %119 ]
  %122 = getelementptr inbounds nuw [50 x double], ptr %3, i64 %113, i64 %120
  %123 = load double, ptr %122, align 8, !tbaa !6
  %124 = getelementptr inbounds nuw [80 x double], ptr %6, i64 %120, i64 %115
  %125 = load double, ptr %124, align 8, !tbaa !6
  %126 = tail call double @llvm.fmuladd.f64(double %123, double %125, double %121)
  store double %126, ptr %116, align 8, !tbaa !6
  %127 = add nuw nsw i64 %120, 1
  %128 = icmp eq i64 %127, 50
  br i1 %128, label %129, label %119, !llvm.loop !24

129:                                              ; preds = %119
  %130 = add nuw nsw i64 %115, 1
  %131 = icmp eq i64 %130, 80
  br i1 %131, label %132, label %114, !llvm.loop !25

132:                                              ; preds = %129
  %133 = add nuw nsw i64 %113, 1
  %134 = icmp eq i64 %133, 40
  br i1 %134, label %135, label %112, !llvm.loop !26

135:                                              ; preds = %132
  tail call void @polybench_timer_stop() #6
  tail call void @polybench_timer_print() #6
  %136 = icmp sgt i32 %0, 42
  br i1 %136, label %137, label %173

137:                                              ; preds = %135
  %138 = load ptr, ptr %1, align 8, !tbaa !27
  %139 = load i8, ptr %138, align 1
  %140 = icmp eq i8 %139, 0
  br i1 %140, label %141, label %173

141:                                              ; preds = %137
  %142 = load ptr, ptr @__stderrp, align 8, !tbaa !30
  %143 = tail call i64 @fwrite(ptr nonnull @.str.1, i64 22, i64 1, ptr %142)
  %144 = load ptr, ptr @__stderrp, align 8, !tbaa !30
  %145 = tail call i32 (ptr, ptr, ...) @fprintf(ptr noundef %144, ptr noundef nonnull @.str.2, ptr noundef nonnull @.str.3) #6
  br label %146

146:                                              ; preds = %165, %141
  %147 = phi i64 [ 0, %141 ], [ %166, %165 ]
  %148 = mul nuw nsw i64 %147, 40
  br label %149

149:                                              ; preds = %158, %146
  %150 = phi i64 [ 0, %146 ], [ %163, %158 ]
  %151 = add nuw nsw i64 %150, %148
  %152 = trunc nuw nsw i64 %151 to i32
  %153 = urem i32 %152, 20
  %154 = icmp eq i32 %153, 0
  br i1 %154, label %155, label %158

155:                                              ; preds = %149
  %156 = load ptr, ptr @__stderrp, align 8, !tbaa !30
  %157 = tail call i32 @fputc(i32 10, ptr %156)
  br label %158

158:                                              ; preds = %155, %149
  %159 = load ptr, ptr @__stderrp, align 8, !tbaa !30
  %160 = getelementptr inbounds nuw [80 x double], ptr %7, i64 %147, i64 %150
  %161 = load double, ptr %160, align 8, !tbaa !6
  %162 = tail call i32 (ptr, ptr, ...) @fprintf(ptr noundef %159, ptr noundef nonnull @.str.5, double noundef %161) #6
  %163 = add nuw nsw i64 %150, 1
  %164 = icmp eq i64 %163, 80
  br i1 %164, label %165, label %149, !llvm.loop !32

165:                                              ; preds = %158
  %166 = add nuw nsw i64 %147, 1
  %167 = icmp eq i64 %166, 40
  br i1 %167, label %168, label %146, !llvm.loop !33

168:                                              ; preds = %165
  %169 = load ptr, ptr @__stderrp, align 8, !tbaa !30
  %170 = tail call i32 (ptr, ptr, ...) @fprintf(ptr noundef %169, ptr noundef nonnull @.str.6, ptr noundef nonnull @.str.3) #6
  %171 = load ptr, ptr @__stderrp, align 8, !tbaa !30
  %172 = tail call i64 @fwrite(ptr nonnull @.str.7, i64 22, i64 1, ptr %171)
  br label %173

173:                                              ; preds = %168, %137, %135
  tail call void @free(ptr noundef %3)
  tail call void @free(ptr noundef %4)
  tail call void @free(ptr noundef %5)
  tail call void @free(ptr noundef %6)
  tail call void @free(ptr noundef nonnull %7)
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
!18 = distinct !{!18, !11}
!19 = distinct !{!19, !11, !12, !13}
!20 = distinct !{!20, !11}
!21 = distinct !{!21, !11}
!22 = distinct !{!22, !11}
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
