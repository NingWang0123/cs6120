; ModuleID = './polybench/linear-algebra/kernels/3mm/3mm.c'
source_filename = "./polybench/linear-algebra/kernels/3mm/3mm.c"
target datalayout = "e-m:o-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-n32:64-S128-Fn32"
target triple = "arm64-apple-macosx15.0.0"

@__stderrp = external local_unnamed_addr global ptr, align 8
@.str.1 = private unnamed_addr constant [23 x i8] c"==BEGIN DUMP_ARRAYS==\0A\00", align 1
@.str.2 = private unnamed_addr constant [15 x i8] c"begin dump: %s\00", align 1
@.str.3 = private unnamed_addr constant [2 x i8] c"G\00", align 1
@.str.5 = private unnamed_addr constant [8 x i8] c"%0.2lf \00", align 1
@.str.6 = private unnamed_addr constant [17 x i8] c"\0Aend   dump: %s\0A\00", align 1
@.str.7 = private unnamed_addr constant [23 x i8] c"==END   DUMP_ARRAYS==\0A\00", align 1

; Function Attrs: nounwind ssp uwtable(sync)
define noundef i32 @main(i32 noundef %0, ptr noundef readonly captures(none) %1) local_unnamed_addr #0 {
  %3 = tail call ptr @polybench_alloc_data(i64 noundef 2000, i32 noundef 8) #6
  %4 = tail call ptr @polybench_alloc_data(i64 noundef 2400, i32 noundef 8) #6
  %5 = tail call ptr @polybench_alloc_data(i64 noundef 3000, i32 noundef 8) #6
  %6 = tail call ptr @polybench_alloc_data(i64 noundef 3500, i32 noundef 8) #6
  %7 = tail call ptr @polybench_alloc_data(i64 noundef 4000, i32 noundef 8) #6
  %8 = tail call ptr @polybench_alloc_data(i64 noundef 5600, i32 noundef 8) #6
  %9 = tail call ptr @polybench_alloc_data(i64 noundef 2800, i32 noundef 8) #6
  br label %10

10:                                               ; preds = %2, %27
  %11 = phi i64 [ 0, %2 ], [ %28, %27 ]
  %12 = insertelement <2 x i64> poison, i64 %11, i64 0
  %13 = shufflevector <2 x i64> %12, <2 x i64> poison, <2 x i32> zeroinitializer
  br label %14

14:                                               ; preds = %14, %10
  %15 = phi i64 [ 0, %10 ], [ %24, %14 ]
  %16 = phi <2 x i64> [ <i64 0, i64 1>, %10 ], [ %25, %14 ]
  %17 = mul nuw nsw <2 x i64> %16, %13
  %18 = trunc <2 x i64> %17 to <2 x i32>
  %19 = add <2 x i32> %18, splat (i32 1)
  %20 = urem <2 x i32> %19, splat (i32 40)
  %21 = uitofp nneg <2 x i32> %20 to <2 x double>
  %22 = fdiv <2 x double> %21, splat (double 2.000000e+02)
  %23 = getelementptr inbounds nuw [60 x double], ptr %4, i64 %11, i64 %15
  store <2 x double> %22, ptr %23, align 8, !tbaa !6
  %24 = add nuw i64 %15, 2
  %25 = add <2 x i64> %16, splat (i64 2)
  %26 = icmp eq i64 %24, 60
  br i1 %26, label %27, label %14, !llvm.loop !10

27:                                               ; preds = %14
  %28 = add nuw nsw i64 %11, 1
  %29 = icmp eq i64 %28, 40
  br i1 %29, label %30, label %10, !llvm.loop !14

30:                                               ; preds = %27, %48
  %31 = phi i64 [ %49, %48 ], [ 0, %27 ]
  %32 = insertelement <2 x i64> poison, i64 %31, i64 0
  %33 = shufflevector <2 x i64> %32, <2 x i64> poison, <2 x i32> zeroinitializer
  br label %34

34:                                               ; preds = %34, %30
  %35 = phi i64 [ 0, %30 ], [ %45, %34 ]
  %36 = phi <2 x i64> [ <i64 0, i64 1>, %30 ], [ %46, %34 ]
  %37 = add nuw nsw <2 x i64> %36, splat (i64 1)
  %38 = mul nuw nsw <2 x i64> %37, %33
  %39 = trunc <2 x i64> %38 to <2 x i32>
  %40 = add <2 x i32> %39, splat (i32 2)
  %41 = urem <2 x i32> %40, splat (i32 50)
  %42 = uitofp nneg <2 x i32> %41 to <2 x double>
  %43 = fdiv <2 x double> %42, splat (double 2.500000e+02)
  %44 = getelementptr inbounds nuw [50 x double], ptr %5, i64 %31, i64 %35
  store <2 x double> %43, ptr %44, align 8, !tbaa !6
  %45 = add nuw i64 %35, 2
  %46 = add <2 x i64> %36, splat (i64 2)
  %47 = icmp eq i64 %45, 50
  br i1 %47, label %48, label %34, !llvm.loop !15

48:                                               ; preds = %34
  %49 = add nuw nsw i64 %31, 1
  %50 = icmp eq i64 %49, 60
  br i1 %50, label %51, label %30, !llvm.loop !16

51:                                               ; preds = %48, %68
  %52 = phi i64 [ %69, %68 ], [ 0, %48 ]
  %53 = insertelement <2 x i64> poison, i64 %52, i64 0
  %54 = shufflevector <2 x i64> %53, <2 x i64> poison, <2 x i32> zeroinitializer
  br label %55

55:                                               ; preds = %55, %51
  %56 = phi i64 [ 0, %51 ], [ %65, %55 ]
  %57 = phi <2 x i64> [ <i64 0, i64 1>, %51 ], [ %66, %55 ]
  %58 = add nuw nsw <2 x i64> %57, splat (i64 3)
  %59 = mul nuw nsw <2 x i64> %58, %54
  %60 = trunc nuw nsw <2 x i64> %59 to <2 x i32>
  %61 = urem <2 x i32> %60, splat (i32 70)
  %62 = uitofp nneg <2 x i32> %61 to <2 x double>
  %63 = fdiv <2 x double> %62, splat (double 3.500000e+02)
  %64 = getelementptr inbounds nuw [80 x double], ptr %7, i64 %52, i64 %56
  store <2 x double> %63, ptr %64, align 8, !tbaa !6
  %65 = add nuw i64 %56, 2
  %66 = add <2 x i64> %57, splat (i64 2)
  %67 = icmp eq i64 %65, 80
  br i1 %67, label %68, label %55, !llvm.loop !17

68:                                               ; preds = %55
  %69 = add nuw nsw i64 %52, 1
  %70 = icmp eq i64 %69, 50
  br i1 %70, label %71, label %51, !llvm.loop !18

71:                                               ; preds = %68, %89
  %72 = phi i64 [ %90, %89 ], [ 0, %68 ]
  %73 = insertelement <2 x i64> poison, i64 %72, i64 0
  %74 = shufflevector <2 x i64> %73, <2 x i64> poison, <2 x i32> zeroinitializer
  br label %75

75:                                               ; preds = %75, %71
  %76 = phi i64 [ 0, %71 ], [ %86, %75 ]
  %77 = phi <2 x i64> [ <i64 0, i64 1>, %71 ], [ %87, %75 ]
  %78 = add nuw nsw <2 x i64> %77, splat (i64 2)
  %79 = mul nuw nsw <2 x i64> %78, %74
  %80 = trunc <2 x i64> %79 to <2 x i32>
  %81 = add <2 x i32> %80, splat (i32 2)
  %82 = urem <2 x i32> %81, splat (i32 60)
  %83 = uitofp nneg <2 x i32> %82 to <2 x double>
  %84 = fdiv <2 x double> %83, splat (double 3.000000e+02)
  %85 = getelementptr inbounds nuw [70 x double], ptr %8, i64 %72, i64 %76
  store <2 x double> %84, ptr %85, align 8, !tbaa !6
  %86 = add nuw i64 %76, 2
  %87 = add <2 x i64> %77, splat (i64 2)
  %88 = icmp eq i64 %86, 70
  br i1 %88, label %89, label %75, !llvm.loop !19

89:                                               ; preds = %75
  %90 = add nuw nsw i64 %72, 1
  %91 = icmp eq i64 %90, 80
  br i1 %91, label %92, label %71, !llvm.loop !20

92:                                               ; preds = %89
  tail call void @polybench_timer_start() #6
  br label %93

93:                                               ; preds = %111, %92
  %94 = phi i64 [ 0, %92 ], [ %112, %111 ]
  br label %95

95:                                               ; preds = %108, %93
  %96 = phi i64 [ 0, %93 ], [ %109, %108 ]
  %97 = getelementptr inbounds nuw [50 x double], ptr %3, i64 %94, i64 %96
  store double 0.000000e+00, ptr %97, align 8, !tbaa !6
  br label %98

98:                                               ; preds = %98, %95
  %99 = phi i64 [ 0, %95 ], [ %106, %98 ]
  %100 = phi double [ 0.000000e+00, %95 ], [ %105, %98 ]
  %101 = getelementptr inbounds nuw [60 x double], ptr %4, i64 %94, i64 %99
  %102 = load double, ptr %101, align 8, !tbaa !6
  %103 = getelementptr inbounds nuw [50 x double], ptr %5, i64 %99, i64 %96
  %104 = load double, ptr %103, align 8, !tbaa !6
  %105 = tail call double @llvm.fmuladd.f64(double %102, double %104, double %100)
  store double %105, ptr %97, align 8, !tbaa !6
  %106 = add nuw nsw i64 %99, 1
  %107 = icmp eq i64 %106, 60
  br i1 %107, label %108, label %98, !llvm.loop !21

108:                                              ; preds = %98
  %109 = add nuw nsw i64 %96, 1
  %110 = icmp eq i64 %109, 50
  br i1 %110, label %111, label %95, !llvm.loop !22

111:                                              ; preds = %108
  %112 = add nuw nsw i64 %94, 1
  %113 = icmp eq i64 %112, 40
  br i1 %113, label %114, label %93, !llvm.loop !23

114:                                              ; preds = %111, %132
  %115 = phi i64 [ %133, %132 ], [ 0, %111 ]
  br label %116

116:                                              ; preds = %129, %114
  %117 = phi i64 [ 0, %114 ], [ %130, %129 ]
  %118 = getelementptr inbounds nuw [70 x double], ptr %6, i64 %115, i64 %117
  store double 0.000000e+00, ptr %118, align 8, !tbaa !6
  br label %119

119:                                              ; preds = %119, %116
  %120 = phi i64 [ 0, %116 ], [ %127, %119 ]
  %121 = phi double [ 0.000000e+00, %116 ], [ %126, %119 ]
  %122 = getelementptr inbounds nuw [80 x double], ptr %7, i64 %115, i64 %120
  %123 = load double, ptr %122, align 8, !tbaa !6
  %124 = getelementptr inbounds nuw [70 x double], ptr %8, i64 %120, i64 %117
  %125 = load double, ptr %124, align 8, !tbaa !6
  %126 = tail call double @llvm.fmuladd.f64(double %123, double %125, double %121)
  store double %126, ptr %118, align 8, !tbaa !6
  %127 = add nuw nsw i64 %120, 1
  %128 = icmp eq i64 %127, 80
  br i1 %128, label %129, label %119, !llvm.loop !24

129:                                              ; preds = %119
  %130 = add nuw nsw i64 %117, 1
  %131 = icmp eq i64 %130, 70
  br i1 %131, label %132, label %116, !llvm.loop !25

132:                                              ; preds = %129
  %133 = add nuw nsw i64 %115, 1
  %134 = icmp eq i64 %133, 50
  br i1 %134, label %135, label %114, !llvm.loop !26

135:                                              ; preds = %132, %153
  %136 = phi i64 [ %154, %153 ], [ 0, %132 ]
  br label %137

137:                                              ; preds = %150, %135
  %138 = phi i64 [ 0, %135 ], [ %151, %150 ]
  %139 = getelementptr inbounds nuw [70 x double], ptr %9, i64 %136, i64 %138
  store double 0.000000e+00, ptr %139, align 8, !tbaa !6
  br label %140

140:                                              ; preds = %140, %137
  %141 = phi i64 [ 0, %137 ], [ %148, %140 ]
  %142 = phi double [ 0.000000e+00, %137 ], [ %147, %140 ]
  %143 = getelementptr inbounds nuw [50 x double], ptr %3, i64 %136, i64 %141
  %144 = load double, ptr %143, align 8, !tbaa !6
  %145 = getelementptr inbounds nuw [70 x double], ptr %6, i64 %141, i64 %138
  %146 = load double, ptr %145, align 8, !tbaa !6
  %147 = tail call double @llvm.fmuladd.f64(double %144, double %146, double %142)
  store double %147, ptr %139, align 8, !tbaa !6
  %148 = add nuw nsw i64 %141, 1
  %149 = icmp eq i64 %148, 50
  br i1 %149, label %150, label %140, !llvm.loop !27

150:                                              ; preds = %140
  %151 = add nuw nsw i64 %138, 1
  %152 = icmp eq i64 %151, 70
  br i1 %152, label %153, label %137, !llvm.loop !28

153:                                              ; preds = %150
  %154 = add nuw nsw i64 %136, 1
  %155 = icmp eq i64 %154, 40
  br i1 %155, label %156, label %135, !llvm.loop !29

156:                                              ; preds = %153
  tail call void @polybench_timer_stop() #6
  tail call void @polybench_timer_print() #6
  %157 = icmp sgt i32 %0, 42
  br i1 %157, label %158, label %194

158:                                              ; preds = %156
  %159 = load ptr, ptr %1, align 8, !tbaa !30
  %160 = load i8, ptr %159, align 1
  %161 = icmp eq i8 %160, 0
  br i1 %161, label %162, label %194

162:                                              ; preds = %158
  %163 = load ptr, ptr @__stderrp, align 8, !tbaa !33
  %164 = tail call i64 @fwrite(ptr nonnull @.str.1, i64 22, i64 1, ptr %163)
  %165 = load ptr, ptr @__stderrp, align 8, !tbaa !33
  %166 = tail call i32 (ptr, ptr, ...) @fprintf(ptr noundef %165, ptr noundef nonnull @.str.2, ptr noundef nonnull @.str.3) #6
  br label %167

167:                                              ; preds = %186, %162
  %168 = phi i64 [ 0, %162 ], [ %187, %186 ]
  %169 = mul nuw nsw i64 %168, 40
  br label %170

170:                                              ; preds = %179, %167
  %171 = phi i64 [ 0, %167 ], [ %184, %179 ]
  %172 = add nuw nsw i64 %171, %169
  %173 = trunc nuw nsw i64 %172 to i32
  %174 = urem i32 %173, 20
  %175 = icmp eq i32 %174, 0
  br i1 %175, label %176, label %179

176:                                              ; preds = %170
  %177 = load ptr, ptr @__stderrp, align 8, !tbaa !33
  %178 = tail call i32 @fputc(i32 10, ptr %177)
  br label %179

179:                                              ; preds = %176, %170
  %180 = load ptr, ptr @__stderrp, align 8, !tbaa !33
  %181 = getelementptr inbounds nuw [70 x double], ptr %9, i64 %168, i64 %171
  %182 = load double, ptr %181, align 8, !tbaa !6
  %183 = tail call i32 (ptr, ptr, ...) @fprintf(ptr noundef %180, ptr noundef nonnull @.str.5, double noundef %182) #6
  %184 = add nuw nsw i64 %171, 1
  %185 = icmp eq i64 %184, 70
  br i1 %185, label %186, label %170, !llvm.loop !35

186:                                              ; preds = %179
  %187 = add nuw nsw i64 %168, 1
  %188 = icmp eq i64 %187, 40
  br i1 %188, label %189, label %167, !llvm.loop !36

189:                                              ; preds = %186
  %190 = load ptr, ptr @__stderrp, align 8, !tbaa !33
  %191 = tail call i32 (ptr, ptr, ...) @fprintf(ptr noundef %190, ptr noundef nonnull @.str.6, ptr noundef nonnull @.str.3) #6
  %192 = load ptr, ptr @__stderrp, align 8, !tbaa !33
  %193 = tail call i64 @fwrite(ptr nonnull @.str.7, i64 22, i64 1, ptr %192)
  br label %194

194:                                              ; preds = %189, %158, %156
  tail call void @free(ptr noundef %3)
  tail call void @free(ptr noundef %4)
  tail call void @free(ptr noundef %5)
  tail call void @free(ptr noundef %6)
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
!27 = distinct !{!27, !11}
!28 = distinct !{!28, !11}
!29 = distinct !{!29, !11}
!30 = !{!31, !31, i64 0}
!31 = !{!"p1 omnipotent char", !32, i64 0}
!32 = !{!"any pointer", !8, i64 0}
!33 = !{!34, !34, i64 0}
!34 = !{!"p1 _ZTS7__sFILE", !32, i64 0}
!35 = distinct !{!35, !11}
!36 = distinct !{!36, !11}
