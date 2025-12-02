; ModuleID = 'polybench_output/mvt.ll'
source_filename = "./polybench/linear-algebra/kernels/mvt/mvt.c"
target datalayout = "e-m:o-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-n32:64-S128-Fn32"
target triple = "arm64-apple-macosx15.0.0"

@__stderrp = external local_unnamed_addr global ptr, align 8
@.str.1 = private unnamed_addr constant [23 x i8] c"==BEGIN DUMP_ARRAYS==\0A\00", align 1
@.str.2 = private unnamed_addr constant [15 x i8] c"begin dump: %s\00", align 1
@.str.3 = private unnamed_addr constant [3 x i8] c"x1\00", align 1
@.str.5 = private unnamed_addr constant [8 x i8] c"%0.2lf \00", align 1
@.str.6 = private unnamed_addr constant [17 x i8] c"\0Aend   dump: %s\0A\00", align 1
@.str.7 = private unnamed_addr constant [3 x i8] c"x2\00", align 1
@.str.8 = private unnamed_addr constant [23 x i8] c"==END   DUMP_ARRAYS==\0A\00", align 1

; Function Attrs: nounwind ssp uwtable(sync)
define noundef i32 @main(i32 noundef %0, ptr noundef readonly captures(none) %1) local_unnamed_addr #0 {
  %3 = tail call ptr @polybench_alloc_data(i64 noundef 14400, i32 noundef 8) #6
  %4 = tail call ptr @polybench_alloc_data(i64 noundef 120, i32 noundef 8) #6
  %5 = tail call ptr @polybench_alloc_data(i64 noundef 120, i32 noundef 8) #6
  %6 = tail call ptr @polybench_alloc_data(i64 noundef 120, i32 noundef 8) #6
  %7 = tail call ptr @polybench_alloc_data(i64 noundef 120, i32 noundef 8) #6
  br label %8

8:                                                ; preds = %47, %2
  %9 = phi i64 [ 0, %2 ], [ %14, %47 ]
  %10 = trunc nuw nsw i64 %9 to i32
  %11 = uitofp nneg i32 %10 to double
  %12 = fdiv double %11, 1.200000e+02
  %13 = getelementptr inbounds nuw double, ptr %4, i64 %9
  store double %12, ptr %13, align 8, !tbaa !6
  %14 = add nuw nsw i64 %9, 1
  %15 = icmp eq i64 %14, 120
  %16 = trunc nuw nsw i64 %14 to i32
  %17 = uitofp nneg i32 %16 to double
  %18 = fdiv double %17, 1.200000e+02
  %19 = select i1 %15, double 0.000000e+00, double %18
  %20 = getelementptr inbounds nuw double, ptr %5, i64 %9
  store double %19, ptr %20, align 8, !tbaa !6
  %21 = icmp samesign ult i64 %9, 117
  %22 = select i1 %21, i32 3, i32 -117
  %23 = add nsw i32 %22, %10
  %24 = uitofp nneg i32 %23 to double
  %25 = fdiv double %24, 1.200000e+02
  %26 = getelementptr inbounds nuw double, ptr %6, i64 %9
  store double %25, ptr %26, align 8, !tbaa !6
  %27 = icmp samesign ult i64 %9, 116
  %28 = select i1 %27, i32 4, i32 -116
  %29 = add nsw i32 %28, %10
  %30 = uitofp nneg i32 %29 to double
  %31 = fdiv double %30, 1.200000e+02
  %32 = getelementptr inbounds nuw double, ptr %7, i64 %9
  store double %31, ptr %32, align 8, !tbaa !6
  %33 = insertelement <2 x i64> poison, i64 %9, i64 0
  %34 = shufflevector <2 x i64> %33, <2 x i64> poison, <2 x i32> zeroinitializer
  br label %35

35:                                               ; preds = %35, %8
  %36 = phi i64 [ 0, %8 ], [ %44, %35 ]
  %37 = phi <2 x i64> [ <i64 0, i64 1>, %8 ], [ %45, %35 ]
  %38 = mul nuw nsw <2 x i64> %37, %34
  %39 = trunc nuw nsw <2 x i64> %38 to <2 x i32>
  %40 = urem <2 x i32> %39, splat (i32 120)
  %41 = uitofp nneg <2 x i32> %40 to <2 x double>
  %42 = fdiv <2 x double> %41, splat (double 1.200000e+02)
  %43 = getelementptr inbounds nuw [120 x double], ptr %3, i64 %9, i64 %36
  store <2 x double> %42, ptr %43, align 8, !tbaa !6
  %44 = add nuw i64 %36, 2
  %45 = add <2 x i64> %37, splat (i64 2)
  %46 = icmp eq i64 %44, 120
  br i1 %46, label %47, label %35, !llvm.loop !10

47:                                               ; preds = %35
  br i1 %15, label %48, label %8, !llvm.loop !14

48:                                               ; preds = %47
  tail call void @polybench_timer_start() #6
  %49 = getelementptr i8, ptr %4, i64 960
  %50 = getelementptr i8, ptr %3, i64 115200
  %51 = getelementptr i8, ptr %6, i64 960
  %52 = icmp ult ptr %4, %50
  %53 = icmp ult ptr %3, %49
  %54 = and i1 %52, %53
  %55 = icmp ult ptr %4, %51
  %56 = icmp ult ptr %6, %49
  %57 = and i1 %55, %56
  %58 = or i1 %54, %57
  br label %59

59:                                               ; preds = %103, %48
  %60 = phi i64 [ 0, %48 ], [ %104, %103 ]
  %61 = getelementptr inbounds nuw double, ptr %4, i64 %60
  %62 = load double, ptr %61, align 8, !tbaa !6
  br i1 %58, label %.preheader1, label %.preheader2

.preheader2:                                      ; preds = %59
  br label %63

.preheader1:                                      ; preds = %59
  br label %93

63:                                               ; preds = %.preheader2, %63
  %64 = phi i64 [ %90, %63 ], [ 0, %.preheader2 ]
  %65 = phi double [ %89, %63 ], [ %62, %.preheader2 ]
  %66 = getelementptr inbounds nuw [120 x double], ptr %3, i64 %60, i64 %64
  %67 = getelementptr inbounds nuw i8, ptr %66, i64 16
  %68 = getelementptr inbounds nuw i8, ptr %66, i64 32
  %69 = getelementptr inbounds nuw i8, ptr %66, i64 48
  %70 = load <2 x double>, ptr %66, align 8, !tbaa !6, !alias.scope !15
  %71 = load <2 x double>, ptr %67, align 8, !tbaa !6, !alias.scope !15
  %72 = load <2 x double>, ptr %68, align 8, !tbaa !6, !alias.scope !15
  %73 = load <2 x double>, ptr %69, align 8, !tbaa !6, !alias.scope !15
  %74 = getelementptr inbounds nuw double, ptr %6, i64 %64
  %75 = getelementptr inbounds nuw i8, ptr %74, i64 16
  %76 = getelementptr inbounds nuw i8, ptr %74, i64 32
  %77 = getelementptr inbounds nuw i8, ptr %74, i64 48
  %78 = load <2 x double>, ptr %74, align 8, !tbaa !6, !alias.scope !18
  %79 = load <2 x double>, ptr %75, align 8, !tbaa !6, !alias.scope !18
  %80 = load <2 x double>, ptr %76, align 8, !tbaa !6, !alias.scope !18
  %81 = load <2 x double>, ptr %77, align 8, !tbaa !6, !alias.scope !18
  %82 = fmul <2 x double> %70, %78
  %83 = fmul <2 x double> %71, %79
  %84 = fmul <2 x double> %72, %80
  %85 = fmul <2 x double> %73, %81
  %86 = tail call double @llvm.vector.reduce.fadd.v2f64(double %65, <2 x double> %82)
  %87 = tail call double @llvm.vector.reduce.fadd.v2f64(double %86, <2 x double> %83)
  %88 = tail call double @llvm.vector.reduce.fadd.v2f64(double %87, <2 x double> %84)
  %89 = tail call double @llvm.vector.reduce.fadd.v2f64(double %88, <2 x double> %85)
  %90 = add nuw i64 %64, 8
  %91 = icmp eq i64 %90, 120
  br i1 %91, label %92, label %63, !llvm.loop !20

92:                                               ; preds = %63
  store double %89, ptr %61, align 8, !tbaa !6, !alias.scope !21, !noalias !23
  br label %103

93:                                               ; preds = %.preheader1, %93
  %94 = phi i64 [ %101, %93 ], [ 0, %.preheader1 ]
  %95 = phi double [ %100, %93 ], [ %62, %.preheader1 ]
  %96 = getelementptr inbounds nuw [120 x double], ptr %3, i64 %60, i64 %94
  %97 = load double, ptr %96, align 8, !tbaa !6
  %98 = getelementptr inbounds nuw double, ptr %6, i64 %94
  %99 = load double, ptr %98, align 8, !tbaa !6
  %100 = tail call double @llvm.fmuladd.f64(double %97, double %99, double %95)
  store double %100, ptr %61, align 8, !tbaa !6
  %101 = add nuw nsw i64 %94, 1
  %102 = icmp eq i64 %101, 120
  br i1 %102, label %.loopexit, label %93, !llvm.loop !24

.loopexit:                                        ; preds = %93
  br label %103

103:                                              ; preds = %.loopexit, %92
  %104 = add nuw nsw i64 %60, 1
  %105 = icmp eq i64 %104, 120
  br i1 %105, label %.preheader, label %59, !llvm.loop !25

.preheader:                                       ; preds = %103
  br label %106

106:                                              ; preds = %.preheader, %120
  %107 = phi i64 [ %121, %120 ], [ 0, %.preheader ]
  %108 = getelementptr inbounds nuw double, ptr %5, i64 %107
  %109 = load double, ptr %108, align 8, !tbaa !6
  br label %110

110:                                              ; preds = %110, %106
  %111 = phi i64 [ 0, %106 ], [ %118, %110 ]
  %112 = phi double [ %109, %106 ], [ %117, %110 ]
  %113 = getelementptr inbounds nuw [120 x double], ptr %3, i64 %111, i64 %107
  %114 = load double, ptr %113, align 8, !tbaa !6
  %115 = getelementptr inbounds nuw double, ptr %7, i64 %111
  %116 = load double, ptr %115, align 8, !tbaa !6
  %117 = tail call double @llvm.fmuladd.f64(double %114, double %116, double %112)
  store double %117, ptr %108, align 8, !tbaa !6
  %118 = add nuw nsw i64 %111, 1
  %119 = icmp eq i64 %118, 120
  br i1 %119, label %120, label %110, !llvm.loop !26

120:                                              ; preds = %110
  %121 = add nuw nsw i64 %107, 1
  %122 = icmp eq i64 %121, 120
  br i1 %122, label %123, label %106, !llvm.loop !27

123:                                              ; preds = %120
  tail call void @polybench_timer_stop() #6
  tail call void @polybench_timer_print() #6
  %124 = icmp sgt i32 %0, 42
  br i1 %124, label %125, label %174

125:                                              ; preds = %123
  %126 = load ptr, ptr %1, align 8, !tbaa !28
  %127 = load i8, ptr %126, align 1
  %128 = icmp eq i8 %127, 0
  br i1 %128, label %129, label %174

129:                                              ; preds = %125
  %130 = load ptr, ptr @__stderrp, align 8, !tbaa !31
  %131 = tail call i64 @fwrite(ptr nonnull @.str.1, i64 22, i64 1, ptr %130)
  %132 = load ptr, ptr @__stderrp, align 8, !tbaa !31
  %133 = tail call i32 (ptr, ptr, ...) @fprintf(ptr noundef %132, ptr noundef nonnull @.str.2, ptr noundef nonnull @.str.3) #6
  br label %134

134:                                              ; preds = %142, %129
  %135 = phi i64 [ 0, %129 ], [ %147, %142 ]
  %136 = trunc i64 %135 to i8
  %137 = urem i8 %136, 20
  %138 = icmp eq i8 %137, 0
  br i1 %138, label %139, label %142

139:                                              ; preds = %134
  %140 = load ptr, ptr @__stderrp, align 8, !tbaa !31
  %141 = tail call i32 @fputc(i32 10, ptr %140)
  br label %142

142:                                              ; preds = %139, %134
  %143 = load ptr, ptr @__stderrp, align 8, !tbaa !31
  %144 = getelementptr inbounds nuw double, ptr %4, i64 %135
  %145 = load double, ptr %144, align 8, !tbaa !6
  %146 = tail call i32 (ptr, ptr, ...) @fprintf(ptr noundef %143, ptr noundef nonnull @.str.5, double noundef %145) #6
  %147 = add nuw nsw i64 %135, 1
  %148 = icmp eq i64 %147, 120
  br i1 %148, label %149, label %134, !llvm.loop !33

149:                                              ; preds = %142
  %150 = load ptr, ptr @__stderrp, align 8, !tbaa !31
  %151 = tail call i32 (ptr, ptr, ...) @fprintf(ptr noundef %150, ptr noundef nonnull @.str.6, ptr noundef nonnull @.str.3) #6
  %152 = load ptr, ptr @__stderrp, align 8, !tbaa !31
  %153 = tail call i32 (ptr, ptr, ...) @fprintf(ptr noundef %152, ptr noundef nonnull @.str.2, ptr noundef nonnull @.str.7) #6
  br label %154

154:                                              ; preds = %162, %149
  %155 = phi i64 [ 0, %149 ], [ %167, %162 ]
  %156 = trunc i64 %155 to i8
  %157 = urem i8 %156, 20
  %158 = icmp eq i8 %157, 0
  br i1 %158, label %159, label %162

159:                                              ; preds = %154
  %160 = load ptr, ptr @__stderrp, align 8, !tbaa !31
  %161 = tail call i32 @fputc(i32 10, ptr %160)
  br label %162

162:                                              ; preds = %159, %154
  %163 = load ptr, ptr @__stderrp, align 8, !tbaa !31
  %164 = getelementptr inbounds nuw double, ptr %5, i64 %155
  %165 = load double, ptr %164, align 8, !tbaa !6
  %166 = tail call i32 (ptr, ptr, ...) @fprintf(ptr noundef %163, ptr noundef nonnull @.str.5, double noundef %165) #6
  %167 = add nuw nsw i64 %155, 1
  %168 = icmp eq i64 %167, 120
  br i1 %168, label %169, label %154, !llvm.loop !34

169:                                              ; preds = %162
  %170 = load ptr, ptr @__stderrp, align 8, !tbaa !31
  %171 = tail call i32 (ptr, ptr, ...) @fprintf(ptr noundef %170, ptr noundef nonnull @.str.6, ptr noundef nonnull @.str.7) #6
  %172 = load ptr, ptr @__stderrp, align 8, !tbaa !31
  %173 = tail call i64 @fwrite(ptr nonnull @.str.8, i64 22, i64 1, ptr %172)
  br label %174

174:                                              ; preds = %169, %125, %123
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

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare double @llvm.vector.reduce.fadd.v2f64(double, <2 x double>) #3

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
!15 = !{!16}
!16 = distinct !{!16, !17}
!17 = distinct !{!17, !"LVerDomain"}
!18 = !{!19}
!19 = distinct !{!19, !17}
!20 = distinct !{!20, !11, !12, !13}
!21 = !{!22}
!22 = distinct !{!22, !17}
!23 = !{!16, !19}
!24 = distinct !{!24, !11, !12}
!25 = distinct !{!25, !11}
!26 = distinct !{!26, !11}
!27 = distinct !{!27, !11}
!28 = !{!29, !29, i64 0}
!29 = !{!"p1 omnipotent char", !30, i64 0}
!30 = !{!"any pointer", !8, i64 0}
!31 = !{!32, !32, i64 0}
!32 = !{!"p1 _ZTS7__sFILE", !30, i64 0}
!33 = distinct !{!33, !11}
!34 = distinct !{!34, !11}
