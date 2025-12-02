; ModuleID = 'polybench_output/correlation.ll'
source_filename = "./polybench/datamining/correlation/correlation.c"
target datalayout = "e-m:o-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-n32:64-S128-Fn32"
target triple = "arm64-apple-macosx15.0.0"

@__stderrp = external local_unnamed_addr global ptr, align 8
@.str.1 = private unnamed_addr constant [23 x i8] c"==BEGIN DUMP_ARRAYS==\0A\00", align 1
@.str.2 = private unnamed_addr constant [15 x i8] c"begin dump: %s\00", align 1
@.str.3 = private unnamed_addr constant [5 x i8] c"corr\00", align 1
@.str.5 = private unnamed_addr constant [8 x i8] c"%0.2lf \00", align 1
@.str.6 = private unnamed_addr constant [17 x i8] c"\0Aend   dump: %s\0A\00", align 1
@.str.7 = private unnamed_addr constant [23 x i8] c"==END   DUMP_ARRAYS==\0A\00", align 1

; Function Attrs: nounwind ssp uwtable(sync)
define noundef i32 @main(i32 noundef %0, ptr noundef readonly captures(none) %1) local_unnamed_addr #0 {
  %3 = tail call ptr @polybench_alloc_data(i64 noundef 8000, i32 noundef 8) #6
  %4 = tail call ptr @polybench_alloc_data(i64 noundef 6400, i32 noundef 8) #6
  %5 = tail call ptr @polybench_alloc_data(i64 noundef 80, i32 noundef 8) #6
  %6 = tail call ptr @polybench_alloc_data(i64 noundef 80, i32 noundef 8) #6
  br label %7

7:                                                ; preds = %42, %2
  %8 = phi i64 [ 0, %2 ], [ %43, %42 ]
  %9 = trunc nuw nsw i64 %8 to i32
  %10 = uitofp nneg i32 %9 to double
  br label %11

11:                                               ; preds = %11, %7
  %12 = phi i64 [ 0, %7 ], [ %40, %11 ]
  %13 = or disjoint i64 %12, 1
  %14 = or disjoint i64 %12, 2
  %15 = or disjoint i64 %12, 3
  %16 = mul nuw nsw i64 %12, %8
  %17 = mul nuw nsw i64 %13, %8
  %18 = mul nuw nsw i64 %14, %8
  %19 = mul nuw nsw i64 %15, %8
  %20 = trunc nuw nsw i64 %16 to i32
  %21 = trunc nuw nsw i64 %17 to i32
  %22 = trunc nuw nsw i64 %18 to i32
  %23 = trunc nuw nsw i64 %19 to i32
  %24 = uitofp nneg i32 %20 to double
  %25 = uitofp nneg i32 %21 to double
  %26 = uitofp nneg i32 %22 to double
  %27 = uitofp nneg i32 %23 to double
  %28 = fdiv double %24, 8.000000e+01
  %29 = fdiv double %25, 8.000000e+01
  %30 = fdiv double %26, 8.000000e+01
  %31 = fdiv double %27, 8.000000e+01
  %32 = fadd double %28, %10
  %33 = fadd double %29, %10
  %34 = fadd double %30, %10
  %35 = fadd double %31, %10
  %36 = getelementptr inbounds nuw [80 x double], ptr %3, i64 %8, i64 %12
  %37 = getelementptr inbounds nuw [80 x double], ptr %3, i64 %8, i64 %13
  %38 = getelementptr inbounds nuw [80 x double], ptr %3, i64 %8, i64 %14
  %39 = getelementptr inbounds nuw [80 x double], ptr %3, i64 %8, i64 %15
  store double %32, ptr %36, align 8, !tbaa !6
  store double %33, ptr %37, align 8, !tbaa !6
  store double %34, ptr %38, align 8, !tbaa !6
  store double %35, ptr %39, align 8, !tbaa !6
  %40 = add nuw i64 %12, 4
  %41 = icmp eq i64 %40, 80
  br i1 %41, label %42, label %11, !llvm.loop !10

42:                                               ; preds = %11
  %43 = add nuw nsw i64 %8, 1
  %44 = icmp eq i64 %43, 100
  br i1 %44, label %45, label %7, !llvm.loop !14

45:                                               ; preds = %42
  tail call void @polybench_timer_start() #6
  br label %46

46:                                               ; preds = %57, %45
  %47 = phi i64 [ 0, %45 ], [ %59, %57 ]
  %48 = getelementptr inbounds nuw double, ptr %5, i64 %47
  store double 0.000000e+00, ptr %48, align 8, !tbaa !6
  br label %49

49:                                               ; preds = %49, %46
  %50 = phi i64 [ 0, %46 ], [ %55, %49 ]
  %51 = phi double [ 0.000000e+00, %46 ], [ %54, %49 ]
  %52 = getelementptr inbounds nuw [80 x double], ptr %3, i64 %50, i64 %47
  %53 = load double, ptr %52, align 8, !tbaa !6
  %54 = fadd double %51, %53
  store double %54, ptr %48, align 8, !tbaa !6
  %55 = add nuw nsw i64 %50, 1
  %56 = icmp eq i64 %55, 100
  br i1 %56, label %57, label %49, !llvm.loop !15

57:                                               ; preds = %49
  %58 = fdiv double %54, 1.000000e+02
  store double %58, ptr %48, align 8, !tbaa !6
  %59 = add nuw nsw i64 %47, 1
  %60 = icmp eq i64 %59, 80
  br i1 %60, label %.preheader4, label %46, !llvm.loop !16

.preheader4:                                      ; preds = %57
  br label %61

61:                                               ; preds = %.preheader4, %75
  %62 = phi i64 [ %80, %75 ], [ 0, %.preheader4 ]
  %63 = getelementptr inbounds nuw double, ptr %6, i64 %62
  store double 0.000000e+00, ptr %63, align 8, !tbaa !6
  %64 = getelementptr inbounds nuw double, ptr %5, i64 %62
  br label %65

65:                                               ; preds = %65, %61
  %66 = phi double [ 0.000000e+00, %61 ], [ %72, %65 ]
  %67 = phi i64 [ 0, %61 ], [ %73, %65 ]
  %68 = getelementptr inbounds nuw [80 x double], ptr %3, i64 %67, i64 %62
  %69 = load double, ptr %68, align 8, !tbaa !6
  %70 = load double, ptr %64, align 8, !tbaa !6
  %71 = fsub double %69, %70
  %72 = tail call double @llvm.fmuladd.f64(double %71, double %71, double %66)
  store double %72, ptr %63, align 8, !tbaa !6
  %73 = add nuw nsw i64 %67, 1
  %74 = icmp eq i64 %73, 100
  br i1 %74, label %75, label %65, !llvm.loop !17

75:                                               ; preds = %65
  %76 = fdiv double %72, 1.000000e+02
  %77 = tail call double @llvm.sqrt.f64(double %76)
  %78 = fcmp ugt double %77, 1.000000e-01
  %79 = select i1 %78, double %77, double 1.000000e+00
  store double %79, ptr %63, align 8, !tbaa !6
  %80 = add nuw nsw i64 %62, 1
  %81 = icmp eq i64 %80, 80
  br i1 %81, label %82, label %61, !llvm.loop !18

82:                                               ; preds = %75
  %83 = getelementptr i8, ptr %3, i64 64000
  %84 = getelementptr i8, ptr %5, i64 640
  %85 = getelementptr i8, ptr %6, i64 640
  %86 = icmp ult ptr %3, %84
  %87 = icmp ult ptr %5, %83
  %88 = and i1 %86, %87
  %89 = icmp ult ptr %3, %85
  %90 = icmp ult ptr %6, %83
  %91 = and i1 %89, %90
  %92 = or i1 %88, %91
  br label %93

93:                                               ; preds = %130, %82
  %94 = phi i64 [ %131, %130 ], [ 0, %82 ]
  br i1 %92, label %.preheader1, label %.preheader2

.preheader2:                                      ; preds = %93
  br label %95

.preheader1:                                      ; preds = %93
  br label %117

95:                                               ; preds = %.preheader2, %95
  %96 = phi i64 [ %115, %95 ], [ 0, %.preheader2 ]
  %97 = getelementptr inbounds nuw double, ptr %5, i64 %96
  %98 = getelementptr inbounds nuw i8, ptr %97, i64 16
  %99 = load <2 x double>, ptr %97, align 8, !tbaa !6, !alias.scope !19
  %100 = load <2 x double>, ptr %98, align 8, !tbaa !6, !alias.scope !19
  %101 = getelementptr inbounds nuw [80 x double], ptr %3, i64 %94, i64 %96
  %102 = getelementptr inbounds nuw i8, ptr %101, i64 16
  %103 = load <2 x double>, ptr %101, align 8, !tbaa !6, !alias.scope !22, !noalias !24
  %104 = load <2 x double>, ptr %102, align 8, !tbaa !6, !alias.scope !22, !noalias !24
  %105 = fsub <2 x double> %103, %99
  %106 = fsub <2 x double> %104, %100
  store <2 x double> %105, ptr %101, align 8, !tbaa !6, !alias.scope !22, !noalias !24
  store <2 x double> %106, ptr %102, align 8, !tbaa !6, !alias.scope !22, !noalias !24
  %107 = getelementptr inbounds nuw double, ptr %6, i64 %96
  %108 = getelementptr inbounds nuw i8, ptr %107, i64 16
  %109 = load <2 x double>, ptr %107, align 8, !tbaa !6, !alias.scope !26
  %110 = load <2 x double>, ptr %108, align 8, !tbaa !6, !alias.scope !26
  %111 = fmul <2 x double> %109, splat (double 1.000000e+01)
  %112 = fmul <2 x double> %110, splat (double 1.000000e+01)
  %113 = fdiv <2 x double> %105, %111
  %114 = fdiv <2 x double> %106, %112
  store <2 x double> %113, ptr %101, align 8, !tbaa !6, !alias.scope !22, !noalias !24
  store <2 x double> %114, ptr %102, align 8, !tbaa !6, !alias.scope !22, !noalias !24
  %115 = add nuw i64 %96, 4
  %116 = icmp eq i64 %115, 80
  br i1 %116, label %.loopexit3, label %95, !llvm.loop !27

117:                                              ; preds = %.preheader1, %117
  %118 = phi i64 [ %128, %117 ], [ 0, %.preheader1 ]
  %119 = getelementptr inbounds nuw double, ptr %5, i64 %118
  %120 = load double, ptr %119, align 8, !tbaa !6
  %121 = getelementptr inbounds nuw [80 x double], ptr %3, i64 %94, i64 %118
  %122 = load double, ptr %121, align 8, !tbaa !6
  %123 = fsub double %122, %120
  store double %123, ptr %121, align 8, !tbaa !6
  %124 = getelementptr inbounds nuw double, ptr %6, i64 %118
  %125 = load double, ptr %124, align 8, !tbaa !6
  %126 = fmul double %125, 1.000000e+01
  %127 = fdiv double %123, %126
  store double %127, ptr %121, align 8, !tbaa !6
  %128 = add nuw nsw i64 %118, 1
  %129 = icmp eq i64 %128, 80
  br i1 %129, label %.loopexit, label %117, !llvm.loop !28

.loopexit:                                        ; preds = %117
  br label %130

.loopexit3:                                       ; preds = %95
  br label %130

130:                                              ; preds = %.loopexit3, %.loopexit
  %131 = add nuw nsw i64 %94, 1
  %132 = icmp eq i64 %131, 100
  br i1 %132, label %.preheader, label %93, !llvm.loop !29

.preheader:                                       ; preds = %130
  br label %137

133:                                              ; preds = %154
  %134 = add nuw nsw i64 %138, 1
  %135 = add nuw nsw i64 %139, 1
  %136 = icmp eq i64 %134, 79
  br i1 %136, label %158, label %137, !llvm.loop !30

137:                                              ; preds = %.preheader, %133
  %138 = phi i64 [ %134, %133 ], [ 0, %.preheader ]
  %139 = phi i64 [ %135, %133 ], [ 1, %.preheader ]
  %140 = getelementptr inbounds nuw [80 x double], ptr %4, i64 %138, i64 %138
  store double 1.000000e+00, ptr %140, align 8, !tbaa !6
  br label %141

141:                                              ; preds = %154, %137
  %142 = phi i64 [ %139, %137 ], [ %156, %154 ]
  %143 = getelementptr inbounds nuw [80 x double], ptr %4, i64 %138, i64 %142
  store double 0.000000e+00, ptr %143, align 8, !tbaa !6
  br label %144

144:                                              ; preds = %144, %141
  %145 = phi i64 [ 0, %141 ], [ %152, %144 ]
  %146 = phi double [ 0.000000e+00, %141 ], [ %151, %144 ]
  %147 = getelementptr inbounds nuw [80 x double], ptr %3, i64 %145, i64 %138
  %148 = load double, ptr %147, align 8, !tbaa !6
  %149 = getelementptr inbounds nuw [80 x double], ptr %3, i64 %145, i64 %142
  %150 = load double, ptr %149, align 8, !tbaa !6
  %151 = tail call double @llvm.fmuladd.f64(double %148, double %150, double %146)
  store double %151, ptr %143, align 8, !tbaa !6
  %152 = add nuw nsw i64 %145, 1
  %153 = icmp eq i64 %152, 100
  br i1 %153, label %154, label %144, !llvm.loop !31

154:                                              ; preds = %144
  %155 = getelementptr inbounds nuw [80 x double], ptr %4, i64 %142, i64 %138
  store double %151, ptr %155, align 8, !tbaa !6
  %156 = add nuw nsw i64 %142, 1
  %157 = icmp eq i64 %156, 80
  br i1 %157, label %133, label %141, !llvm.loop !32

158:                                              ; preds = %133
  %159 = getelementptr inbounds nuw i8, ptr %4, i64 51192
  store double 1.000000e+00, ptr %159, align 8, !tbaa !6
  tail call void @polybench_timer_stop() #6
  tail call void @polybench_timer_print() #6
  %160 = icmp sgt i32 %0, 42
  br i1 %160, label %161, label %197

161:                                              ; preds = %158
  %162 = load ptr, ptr %1, align 8, !tbaa !33
  %163 = load i8, ptr %162, align 1
  %164 = icmp eq i8 %163, 0
  br i1 %164, label %165, label %197

165:                                              ; preds = %161
  %166 = load ptr, ptr @__stderrp, align 8, !tbaa !36
  %167 = tail call i64 @fwrite(ptr nonnull @.str.1, i64 22, i64 1, ptr %166)
  %168 = load ptr, ptr @__stderrp, align 8, !tbaa !36
  %169 = tail call i32 (ptr, ptr, ...) @fprintf(ptr noundef %168, ptr noundef nonnull @.str.2, ptr noundef nonnull @.str.3) #6
  br label %170

170:                                              ; preds = %189, %165
  %171 = phi i64 [ 0, %165 ], [ %190, %189 ]
  %172 = mul nuw nsw i64 %171, 80
  br label %173

173:                                              ; preds = %182, %170
  %174 = phi i64 [ 0, %170 ], [ %187, %182 ]
  %175 = add nuw nsw i64 %174, %172
  %176 = trunc nuw nsw i64 %175 to i32
  %177 = urem i32 %176, 20
  %178 = icmp eq i32 %177, 0
  br i1 %178, label %179, label %182

179:                                              ; preds = %173
  %180 = load ptr, ptr @__stderrp, align 8, !tbaa !36
  %181 = tail call i32 @fputc(i32 10, ptr %180)
  br label %182

182:                                              ; preds = %179, %173
  %183 = load ptr, ptr @__stderrp, align 8, !tbaa !36
  %184 = getelementptr inbounds nuw [80 x double], ptr %4, i64 %171, i64 %174
  %185 = load double, ptr %184, align 8, !tbaa !6
  %186 = tail call i32 (ptr, ptr, ...) @fprintf(ptr noundef %183, ptr noundef nonnull @.str.5, double noundef %185) #6
  %187 = add nuw nsw i64 %174, 1
  %188 = icmp eq i64 %187, 80
  br i1 %188, label %189, label %173, !llvm.loop !38

189:                                              ; preds = %182
  %190 = add nuw nsw i64 %171, 1
  %191 = icmp eq i64 %190, 80
  br i1 %191, label %192, label %170, !llvm.loop !39

192:                                              ; preds = %189
  %193 = load ptr, ptr @__stderrp, align 8, !tbaa !36
  %194 = tail call i32 (ptr, ptr, ...) @fprintf(ptr noundef %193, ptr noundef nonnull @.str.6, ptr noundef nonnull @.str.3) #6
  %195 = load ptr, ptr @__stderrp, align 8, !tbaa !36
  %196 = tail call i64 @fwrite(ptr nonnull @.str.7, i64 22, i64 1, ptr %195)
  br label %197

197:                                              ; preds = %192, %161, %158
  tail call void @free(ptr noundef %3)
  tail call void @free(ptr noundef nonnull %4)
  tail call void @free(ptr noundef %5)
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

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare double @llvm.sqrt.f64(double) #3

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
!15 = distinct !{!15, !11}
!16 = distinct !{!16, !11}
!17 = distinct !{!17, !11}
!18 = distinct !{!18, !11}
!19 = !{!20}
!20 = distinct !{!20, !21}
!21 = distinct !{!21, !"LVerDomain"}
!22 = !{!23}
!23 = distinct !{!23, !21}
!24 = !{!20, !25}
!25 = distinct !{!25, !21}
!26 = !{!25}
!27 = distinct !{!27, !11, !12, !13}
!28 = distinct !{!28, !11, !12}
!29 = distinct !{!29, !11}
!30 = distinct !{!30, !11}
!31 = distinct !{!31, !11}
!32 = distinct !{!32, !11}
!33 = !{!34, !34, i64 0}
!34 = !{!"p1 omnipotent char", !35, i64 0}
!35 = !{!"any pointer", !8, i64 0}
!36 = !{!37, !37, i64 0}
!37 = !{!"p1 _ZTS7__sFILE", !35, i64 0}
!38 = distinct !{!38, !11}
!39 = distinct !{!39, !11}
