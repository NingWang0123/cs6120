; ModuleID = 'polybench_output/syr2k.ll'
source_filename = "./polybench/linear-algebra/blas/syr2k/syr2k.c"
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
  %5 = ptrtoint ptr %4 to i64
  %6 = tail call ptr @polybench_alloc_data(i64 noundef 4800, i32 noundef 8) #6
  %7 = ptrtoint ptr %6 to i64
  %8 = sub i64 %7, %5
  %9 = icmp ult i64 %8, 16
  br label %10

10:                                               ; preds = %49, %2
  %11 = phi i64 [ 0, %2 ], [ %50, %49 ]
  br i1 %9, label %.preheader1, label %12

.preheader1:                                      ; preds = %10
  br label %33

12:                                               ; preds = %10
  %13 = insertelement <2 x i64> poison, i64 %11, i64 0
  %14 = shufflevector <2 x i64> %13, <2 x i64> poison, <2 x i32> zeroinitializer
  br label %15

15:                                               ; preds = %15, %12
  %16 = phi i64 [ 0, %12 ], [ %30, %15 ]
  %17 = phi <2 x i64> [ <i64 0, i64 1>, %12 ], [ %31, %15 ]
  %18 = mul nuw nsw <2 x i64> %17, %14
  %19 = trunc <2 x i64> %18 to <2 x i32>
  %20 = add <2 x i32> %19, splat (i32 1)
  %21 = urem <2 x i32> %20, splat (i32 80)
  %22 = uitofp nneg <2 x i32> %21 to <2 x double>
  %23 = fdiv <2 x double> %22, splat (double 8.000000e+01)
  %24 = getelementptr inbounds nuw [60 x double], ptr %4, i64 %11, i64 %16
  store <2 x double> %23, ptr %24, align 8, !tbaa !6
  %25 = add <2 x i32> %19, splat (i32 2)
  %26 = urem <2 x i32> %25, splat (i32 60)
  %27 = uitofp nneg <2 x i32> %26 to <2 x double>
  %28 = fdiv <2 x double> %27, splat (double 6.000000e+01)
  %29 = getelementptr inbounds nuw [60 x double], ptr %6, i64 %11, i64 %16
  store <2 x double> %28, ptr %29, align 8, !tbaa !6
  %30 = add nuw i64 %16, 2
  %31 = add <2 x i64> %17, splat (i64 2)
  %32 = icmp eq i64 %30, 60
  br i1 %32, label %.loopexit3, label %15, !llvm.loop !10

33:                                               ; preds = %.preheader1, %33
  %34 = phi i64 [ %47, %33 ], [ 0, %.preheader1 ]
  %35 = mul nuw nsw i64 %34, %11
  %36 = trunc i64 %35 to i32
  %37 = add i32 %36, 1
  %38 = urem i32 %37, 80
  %39 = uitofp nneg i32 %38 to double
  %40 = fdiv double %39, 8.000000e+01
  %41 = getelementptr inbounds nuw [60 x double], ptr %4, i64 %11, i64 %34
  store double %40, ptr %41, align 8, !tbaa !6
  %42 = add i32 %36, 2
  %43 = urem i32 %42, 60
  %44 = uitofp nneg i32 %43 to double
  %45 = fdiv double %44, 6.000000e+01
  %46 = getelementptr inbounds nuw [60 x double], ptr %6, i64 %11, i64 %34
  store double %45, ptr %46, align 8, !tbaa !6
  %47 = add nuw nsw i64 %34, 1
  %48 = icmp eq i64 %47, 60
  br i1 %48, label %.loopexit2, label %33, !llvm.loop !14

.loopexit2:                                       ; preds = %33
  br label %49

.loopexit3:                                       ; preds = %15
  br label %49

49:                                               ; preds = %.loopexit3, %.loopexit2
  %50 = add nuw nsw i64 %11, 1
  %51 = icmp eq i64 %50, 80
  br i1 %51, label %.preheader, label %10, !llvm.loop !15

.preheader:                                       ; preds = %49
  br label %52

52:                                               ; preds = %.preheader, %69
  %53 = phi i64 [ %70, %69 ], [ 0, %.preheader ]
  %54 = insertelement <2 x i64> poison, i64 %53, i64 0
  %55 = shufflevector <2 x i64> %54, <2 x i64> poison, <2 x i32> zeroinitializer
  br label %56

56:                                               ; preds = %56, %52
  %57 = phi i64 [ 0, %52 ], [ %66, %56 ]
  %58 = phi <2 x i64> [ <i64 0, i64 1>, %52 ], [ %67, %56 ]
  %59 = mul nuw nsw <2 x i64> %58, %55
  %60 = trunc <2 x i64> %59 to <2 x i32>
  %61 = add <2 x i32> %60, splat (i32 3)
  %62 = urem <2 x i32> %61, splat (i32 80)
  %63 = uitofp nneg <2 x i32> %62 to <2 x double>
  %64 = fdiv <2 x double> %63, splat (double 6.000000e+01)
  %65 = getelementptr inbounds nuw [80 x double], ptr %3, i64 %53, i64 %57
  store <2 x double> %64, ptr %65, align 8, !tbaa !6
  %66 = add nuw i64 %57, 2
  %67 = add <2 x i64> %58, splat (i64 2)
  %68 = icmp eq i64 %66, 80
  br i1 %68, label %69, label %56, !llvm.loop !16

69:                                               ; preds = %56
  %70 = add nuw nsw i64 %53, 1
  %71 = icmp eq i64 %70, 80
  br i1 %71, label %72, label %52, !llvm.loop !17

72:                                               ; preds = %69
  tail call void @polybench_timer_start() #6
  br label %73

73:                                               ; preds = %131, %72
  %74 = phi i64 [ 0, %72 ], [ %132, %131 ]
  %75 = phi i64 [ 1, %72 ], [ %133, %131 ]
  %76 = icmp samesign ult i64 %75, 8
  br i1 %76, label %97, label %77

77:                                               ; preds = %73
  %78 = and i64 %75, 9223372036854775800
  br label %79

79:                                               ; preds = %79, %77
  %80 = phi i64 [ 0, %77 ], [ %93, %79 ]
  %81 = getelementptr inbounds nuw [80 x double], ptr %3, i64 %74, i64 %80
  %82 = getelementptr inbounds nuw i8, ptr %81, i64 16
  %83 = getelementptr inbounds nuw i8, ptr %81, i64 32
  %84 = getelementptr inbounds nuw i8, ptr %81, i64 48
  %85 = load <2 x double>, ptr %81, align 8, !tbaa !6
  %86 = load <2 x double>, ptr %82, align 8, !tbaa !6
  %87 = load <2 x double>, ptr %83, align 8, !tbaa !6
  %88 = load <2 x double>, ptr %84, align 8, !tbaa !6
  %89 = fmul <2 x double> %85, splat (double 1.200000e+00)
  %90 = fmul <2 x double> %86, splat (double 1.200000e+00)
  %91 = fmul <2 x double> %87, splat (double 1.200000e+00)
  %92 = fmul <2 x double> %88, splat (double 1.200000e+00)
  store <2 x double> %89, ptr %81, align 8, !tbaa !6
  store <2 x double> %90, ptr %82, align 8, !tbaa !6
  store <2 x double> %91, ptr %83, align 8, !tbaa !6
  store <2 x double> %92, ptr %84, align 8, !tbaa !6
  %93 = add nuw i64 %80, 8
  %94 = icmp eq i64 %93, %78
  br i1 %94, label %95, label %79, !llvm.loop !18

95:                                               ; preds = %79
  %96 = icmp eq i64 %75, %78
  br i1 %96, label %106, label %97

97:                                               ; preds = %95, %73
  %98 = phi i64 [ 0, %73 ], [ %78, %95 ]
  br label %99

99:                                               ; preds = %99, %97
  %100 = phi i64 [ %104, %99 ], [ %98, %97 ]
  %101 = getelementptr inbounds nuw [80 x double], ptr %3, i64 %74, i64 %100
  %102 = load double, ptr %101, align 8, !tbaa !6
  %103 = fmul double %102, 1.200000e+00
  store double %103, ptr %101, align 8, !tbaa !6
  %104 = add nuw nsw i64 %100, 1
  %105 = icmp eq i64 %104, %75
  br i1 %105, label %.loopexit, label %99, !llvm.loop !19

.loopexit:                                        ; preds = %99
  br label %106

106:                                              ; preds = %.loopexit, %95
  br label %107

107:                                              ; preds = %128, %106
  %108 = phi i64 [ %129, %128 ], [ 0, %106 ]
  %109 = getelementptr inbounds nuw [60 x double], ptr %6, i64 %74, i64 %108
  %110 = getelementptr inbounds nuw [60 x double], ptr %4, i64 %74, i64 %108
  br label %111

111:                                              ; preds = %111, %107
  %112 = phi i64 [ 0, %107 ], [ %126, %111 ]
  %113 = getelementptr inbounds nuw [60 x double], ptr %4, i64 %112, i64 %108
  %114 = load double, ptr %113, align 8, !tbaa !6
  %115 = fmul double %114, 1.500000e+00
  %116 = load double, ptr %109, align 8, !tbaa !6
  %117 = getelementptr inbounds nuw [60 x double], ptr %6, i64 %112, i64 %108
  %118 = load double, ptr %117, align 8, !tbaa !6
  %119 = fmul double %118, 1.500000e+00
  %120 = load double, ptr %110, align 8, !tbaa !6
  %121 = fmul double %119, %120
  %122 = tail call double @llvm.fmuladd.f64(double %115, double %116, double %121)
  %123 = getelementptr inbounds nuw [80 x double], ptr %3, i64 %74, i64 %112
  %124 = load double, ptr %123, align 8, !tbaa !6
  %125 = fadd double %124, %122
  store double %125, ptr %123, align 8, !tbaa !6
  %126 = add nuw nsw i64 %112, 1
  %127 = icmp eq i64 %126, %75
  br i1 %127, label %128, label %111, !llvm.loop !20

128:                                              ; preds = %111
  %129 = add nuw nsw i64 %108, 1
  %130 = icmp eq i64 %129, 60
  br i1 %130, label %131, label %107, !llvm.loop !21

131:                                              ; preds = %128
  %132 = add nuw nsw i64 %74, 1
  %133 = add nuw nsw i64 %75, 1
  %134 = icmp eq i64 %132, 80
  br i1 %134, label %135, label %73, !llvm.loop !22

135:                                              ; preds = %131
  tail call void @polybench_timer_stop() #6
  tail call void @polybench_timer_print() #6
  %136 = icmp sgt i32 %0, 42
  br i1 %136, label %137, label %173

137:                                              ; preds = %135
  %138 = load ptr, ptr %1, align 8, !tbaa !23
  %139 = load i8, ptr %138, align 1
  %140 = icmp eq i8 %139, 0
  br i1 %140, label %141, label %173

141:                                              ; preds = %137
  %142 = load ptr, ptr @__stderrp, align 8, !tbaa !26
  %143 = tail call i64 @fwrite(ptr nonnull @.str.1, i64 22, i64 1, ptr %142)
  %144 = load ptr, ptr @__stderrp, align 8, !tbaa !26
  %145 = tail call i32 (ptr, ptr, ...) @fprintf(ptr noundef %144, ptr noundef nonnull @.str.2, ptr noundef nonnull @.str.3) #6
  br label %146

146:                                              ; preds = %165, %141
  %147 = phi i64 [ 0, %141 ], [ %166, %165 ]
  %148 = mul nuw nsw i64 %147, 80
  br label %149

149:                                              ; preds = %158, %146
  %150 = phi i64 [ 0, %146 ], [ %163, %158 ]
  %151 = add nuw nsw i64 %150, %148
  %152 = trunc nuw nsw i64 %151 to i32
  %153 = urem i32 %152, 20
  %154 = icmp eq i32 %153, 0
  br i1 %154, label %155, label %158

155:                                              ; preds = %149
  %156 = load ptr, ptr @__stderrp, align 8, !tbaa !26
  %157 = tail call i32 @fputc(i32 10, ptr %156)
  br label %158

158:                                              ; preds = %155, %149
  %159 = load ptr, ptr @__stderrp, align 8, !tbaa !26
  %160 = getelementptr inbounds nuw [80 x double], ptr %3, i64 %147, i64 %150
  %161 = load double, ptr %160, align 8, !tbaa !6
  %162 = tail call i32 (ptr, ptr, ...) @fprintf(ptr noundef %159, ptr noundef nonnull @.str.5, double noundef %161) #6
  %163 = add nuw nsw i64 %150, 1
  %164 = icmp eq i64 %163, 80
  br i1 %164, label %165, label %149, !llvm.loop !28

165:                                              ; preds = %158
  %166 = add nuw nsw i64 %147, 1
  %167 = icmp eq i64 %166, 80
  br i1 %167, label %168, label %146, !llvm.loop !29

168:                                              ; preds = %165
  %169 = load ptr, ptr @__stderrp, align 8, !tbaa !26
  %170 = tail call i32 (ptr, ptr, ...) @fprintf(ptr noundef %169, ptr noundef nonnull @.str.6, ptr noundef nonnull @.str.3) #6
  %171 = load ptr, ptr @__stderrp, align 8, !tbaa !26
  %172 = tail call i64 @fwrite(ptr nonnull @.str.7, i64 22, i64 1, ptr %171)
  br label %173

173:                                              ; preds = %168, %137, %135
  tail call void @free(ptr noundef nonnull %3)
  tail call void @free(ptr noundef %4)
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
!14 = distinct !{!14, !11, !12}
!15 = distinct !{!15, !11}
!16 = distinct !{!16, !11, !12, !13}
!17 = distinct !{!17, !11}
!18 = distinct !{!18, !11, !12, !13}
!19 = distinct !{!19, !11, !13, !12}
!20 = distinct !{!20, !11}
!21 = distinct !{!21, !11}
!22 = distinct !{!22, !11}
!23 = !{!24, !24, i64 0}
!24 = !{!"p1 omnipotent char", !25, i64 0}
!25 = !{!"any pointer", !8, i64 0}
!26 = !{!27, !27, i64 0}
!27 = !{!"p1 _ZTS7__sFILE", !25, i64 0}
!28 = distinct !{!28, !11}
!29 = distinct !{!29, !11}
