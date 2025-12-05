; ModuleID = 'polybench_results/cholesky.ll'
source_filename = "./polybench/linear-algebra/solvers/cholesky/cholesky.c"
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
  %3 = tail call ptr @polybench_alloc_data(i64 noundef 14400, i32 noundef 8) #7
  %4 = ptrtoint ptr %3 to i64
  %5 = getelementptr i8, ptr %3, i64 8
  br label %6

6:                                                ; preds = %60, %2
  %7 = phi i64 [ 1, %2 ], [ %62, %60 ]
  %8 = phi i64 [ 0, %2 ], [ %53, %60 ]
  %9 = icmp samesign ult i64 %7, 8
  br i1 %9, label %40, label %10

10:                                               ; preds = %6
  %11 = and i64 %7, 9223372036854775800
  br label %12

12:                                               ; preds = %12, %10
  %13 = phi i64 [ 0, %10 ], [ %35, %12 ]
  %14 = phi <2 x i32> [ <i32 0, i32 1>, %10 ], [ %36, %12 ]
  %15 = sub <2 x i32> zeroinitializer, %14
  %16 = sub <2 x i32> splat (i32 -2), %14
  %17 = sub <2 x i32> splat (i32 -4), %14
  %18 = sub <2 x i32> splat (i32 -6), %14
  %19 = sitofp <2 x i32> %15 to <2 x double>
  %20 = sitofp <2 x i32> %16 to <2 x double>
  %21 = sitofp <2 x i32> %17 to <2 x double>
  %22 = sitofp <2 x i32> %18 to <2 x double>
  %23 = fdiv <2 x double> %19, splat (double 1.200000e+02)
  %24 = fdiv <2 x double> %20, splat (double 1.200000e+02)
  %25 = fdiv <2 x double> %21, splat (double 1.200000e+02)
  %26 = fdiv <2 x double> %22, splat (double 1.200000e+02)
  %27 = fadd <2 x double> %23, splat (double 1.000000e+00)
  %28 = fadd <2 x double> %24, splat (double 1.000000e+00)
  %29 = fadd <2 x double> %25, splat (double 1.000000e+00)
  %30 = fadd <2 x double> %26, splat (double 1.000000e+00)
  %31 = getelementptr inbounds nuw [120 x double], ptr %3, i64 %8, i64 %13
  %32 = getelementptr inbounds nuw i8, ptr %31, i64 16
  %33 = getelementptr inbounds nuw i8, ptr %31, i64 32
  %34 = getelementptr inbounds nuw i8, ptr %31, i64 48
  store <2 x double> %27, ptr %31, align 8, !tbaa !6
  store <2 x double> %28, ptr %32, align 8, !tbaa !6
  store <2 x double> %29, ptr %33, align 8, !tbaa !6
  store <2 x double> %30, ptr %34, align 8, !tbaa !6
  %35 = add nuw i64 %13, 8
  %36 = add <2 x i32> %14, splat (i32 8)
  %37 = icmp eq i64 %35, %11
  br i1 %37, label %38, label %12, !llvm.loop !10

38:                                               ; preds = %12
  %39 = icmp eq i64 %7, %11
  br i1 %39, label %52, label %40

40:                                               ; preds = %38, %6
  %41 = phi i64 [ 0, %6 ], [ %11, %38 ]
  br label %42

42:                                               ; preds = %42, %40
  %43 = phi i64 [ %50, %42 ], [ %41, %40 ]
  %44 = trunc i64 %43 to i32
  %45 = sub i32 0, %44
  %46 = sitofp i32 %45 to double
  %47 = fdiv double %46, 1.200000e+02
  %48 = fadd double %47, 1.000000e+00
  %49 = getelementptr inbounds nuw [120 x double], ptr %3, i64 %8, i64 %43
  store double %48, ptr %49, align 8, !tbaa !6
  %50 = add nuw nsw i64 %43, 1
  %51 = icmp eq i64 %50, %7
  br i1 %51, label %.loopexit5, label %42, !llvm.loop !14

.loopexit5:                                       ; preds = %42
  br label %52

52:                                               ; preds = %.loopexit5, %38
  %53 = add nuw nsw i64 %8, 1
  %54 = icmp samesign ult i64 %8, 119
  br i1 %54, label %55, label %60

55:                                               ; preds = %52
  %56 = shl nuw nsw i64 %8, 3
  %57 = sub nsw i64 952, %56
  %58 = mul nuw nsw i64 %8, 968
  %59 = getelementptr i8, ptr %5, i64 %58
  tail call void @llvm.memset.p0.i64(ptr noundef nonnull align 8 dereferenceable(1) %59, i8 0, i64 %57, i1 false), !tbaa !6
  br label %60

60:                                               ; preds = %55, %52
  %61 = getelementptr inbounds nuw [120 x double], ptr %3, i64 %8, i64 %8
  store double 1.000000e+00, ptr %61, align 8, !tbaa !6
  %62 = add nuw nsw i64 %7, 1
  %63 = icmp eq i64 %53, 120
  br i1 %63, label %64, label %6, !llvm.loop !15

64:                                               ; preds = %60
  %65 = tail call ptr @polybench_alloc_data(i64 noundef 14400, i32 noundef 8) #7
  %66 = ptrtoint ptr %65 to i64
  tail call void @llvm.memset.p0.i64(ptr noundef nonnull align 8 dereferenceable(115200) %65, i8 0, i64 115200, i1 false), !tbaa !6
  br label %67

67:                                               ; preds = %85, %64
  %68 = phi i64 [ 0, %64 ], [ %86, %85 ]
  br label %69

69:                                               ; preds = %82, %67
  %70 = phi i64 [ 0, %67 ], [ %83, %82 ]
  %71 = getelementptr inbounds nuw [120 x double], ptr %3, i64 %70, i64 %68
  br label %72

72:                                               ; preds = %72, %69
  %73 = phi i64 [ 0, %69 ], [ %80, %72 ]
  %74 = load double, ptr %71, align 8, !tbaa !6
  %75 = getelementptr inbounds nuw [120 x double], ptr %3, i64 %73, i64 %68
  %76 = load double, ptr %75, align 8, !tbaa !6
  %77 = getelementptr inbounds nuw [120 x [120 x double]], ptr %65, i64 0, i64 %70, i64 %73
  %78 = load double, ptr %77, align 8, !tbaa !6
  %79 = tail call double @llvm.fmuladd.f64(double %74, double %76, double %78)
  store double %79, ptr %77, align 8, !tbaa !6
  %80 = add nuw nsw i64 %73, 1
  %81 = icmp eq i64 %80, 120
  br i1 %81, label %82, label %72, !llvm.loop !16

82:                                               ; preds = %72
  %83 = add nuw nsw i64 %70, 1
  %84 = icmp eq i64 %83, 120
  br i1 %84, label %85, label %69, !llvm.loop !17

85:                                               ; preds = %82
  %86 = add nuw nsw i64 %68, 1
  %87 = icmp eq i64 %86, 120
  br i1 %87, label %88, label %67, !llvm.loop !18

88:                                               ; preds = %85
  %89 = sub i64 %4, %66
  %90 = icmp ult i64 %89, 64
  br label %91

91:                                               ; preds = %116, %88
  %92 = phi i64 [ %117, %116 ], [ 0, %88 ]
  br i1 %90, label %.preheader, label %.preheader3

.preheader3:                                      ; preds = %91
  br label %93

.preheader:                                       ; preds = %91
  br label %109

93:                                               ; preds = %.preheader3, %93
  %94 = phi i64 [ %107, %93 ], [ 0, %.preheader3 ]
  %95 = getelementptr inbounds nuw [120 x [120 x double]], ptr %65, i64 0, i64 %92, i64 %94
  %96 = getelementptr inbounds nuw i8, ptr %95, i64 16
  %97 = getelementptr inbounds nuw i8, ptr %95, i64 32
  %98 = getelementptr inbounds nuw i8, ptr %95, i64 48
  %99 = load <2 x double>, ptr %95, align 8, !tbaa !6
  %100 = load <2 x double>, ptr %96, align 8, !tbaa !6
  %101 = load <2 x double>, ptr %97, align 8, !tbaa !6
  %102 = load <2 x double>, ptr %98, align 8, !tbaa !6
  %103 = getelementptr inbounds nuw [120 x double], ptr %3, i64 %92, i64 %94
  %104 = getelementptr inbounds nuw i8, ptr %103, i64 16
  %105 = getelementptr inbounds nuw i8, ptr %103, i64 32
  %106 = getelementptr inbounds nuw i8, ptr %103, i64 48
  store <2 x double> %99, ptr %103, align 8, !tbaa !6
  store <2 x double> %100, ptr %104, align 8, !tbaa !6
  store <2 x double> %101, ptr %105, align 8, !tbaa !6
  store <2 x double> %102, ptr %106, align 8, !tbaa !6
  %107 = add nuw i64 %94, 8
  %108 = icmp eq i64 %107, 120
  br i1 %108, label %.loopexit4, label %93, !llvm.loop !19

109:                                              ; preds = %.preheader, %109
  %110 = phi i64 [ %114, %109 ], [ 0, %.preheader ]
  %111 = getelementptr inbounds nuw [120 x [120 x double]], ptr %65, i64 0, i64 %92, i64 %110
  %112 = load double, ptr %111, align 8, !tbaa !6
  %113 = getelementptr inbounds nuw [120 x double], ptr %3, i64 %92, i64 %110
  store double %112, ptr %113, align 8, !tbaa !6
  %114 = add nuw nsw i64 %110, 1
  %115 = icmp eq i64 %114, 120
  br i1 %115, label %.loopexit2, label %109, !llvm.loop !20

.loopexit2:                                       ; preds = %109
  br label %116

.loopexit4:                                       ; preds = %93
  br label %116

116:                                              ; preds = %.loopexit4, %.loopexit2
  %117 = add nuw nsw i64 %92, 1
  %118 = icmp eq i64 %117, 120
  br i1 %118, label %119, label %91, !llvm.loop !21

119:                                              ; preds = %116
  tail call void @free(ptr noundef nonnull %65)
  tail call void @polybench_timer_start() #7
  br label %120

120:                                              ; preds = %166, %119
  %121 = phi i64 [ 0, %119 ], [ %170, %166 ]
  %122 = icmp eq i64 %121, 0
  br i1 %122, label %125, label %123

123:                                              ; preds = %120
  %124 = getelementptr inbounds nuw [120 x double], ptr %3, i64 %121, i64 0
  br label %130

125:                                              ; preds = %120
  %126 = load double, ptr %3, align 8, !tbaa !6
  br label %166

127:                                              ; preds = %149
  %128 = getelementptr inbounds nuw [120 x double], ptr %3, i64 %121, i64 %121
  %129 = load double, ptr %128, align 8, !tbaa !6
  br label %157

130:                                              ; preds = %149, %123
  %131 = phi i64 [ 0, %123 ], [ %155, %149 ]
  %132 = icmp eq i64 %131, 0
  br i1 %132, label %133, label %135

133:                                              ; preds = %130
  %134 = load double, ptr %124, align 8, !tbaa !6
  br label %149

135:                                              ; preds = %130
  %136 = getelementptr inbounds nuw [120 x double], ptr %3, i64 %121, i64 %131
  %137 = load double, ptr %136, align 8, !tbaa !6
  br label %138

138:                                              ; preds = %138, %135
  %139 = phi i64 [ 0, %135 ], [ %147, %138 ]
  %140 = phi double [ %137, %135 ], [ %146, %138 ]
  %141 = getelementptr inbounds nuw [120 x double], ptr %3, i64 %121, i64 %139
  %142 = load double, ptr %141, align 8, !tbaa !6
  %143 = getelementptr inbounds nuw [120 x double], ptr %3, i64 %131, i64 %139
  %144 = load double, ptr %143, align 8, !tbaa !6
  %145 = fneg double %142
  %146 = tail call double @llvm.fmuladd.f64(double %145, double %144, double %140)
  store double %146, ptr %136, align 8, !tbaa !6
  %147 = add nuw nsw i64 %139, 1
  %148 = icmp eq i64 %147, %131
  br i1 %148, label %.loopexit, label %138, !llvm.loop !22

.loopexit:                                        ; preds = %138
  br label %149

149:                                              ; preds = %.loopexit, %133
  %150 = phi double [ %134, %133 ], [ %146, %.loopexit ]
  %151 = getelementptr inbounds nuw [120 x double], ptr %3, i64 %131, i64 %131
  %152 = load double, ptr %151, align 8, !tbaa !6
  %153 = getelementptr inbounds nuw [120 x double], ptr %3, i64 %121, i64 %131
  %154 = fdiv double %150, %152
  store double %154, ptr %153, align 8, !tbaa !6
  %155 = add nuw nsw i64 %131, 1
  %156 = icmp eq i64 %155, %121
  br i1 %156, label %127, label %130, !llvm.loop !23

157:                                              ; preds = %157, %127
  %158 = phi i64 [ 0, %127 ], [ %164, %157 ]
  %159 = phi double [ %129, %127 ], [ %163, %157 ]
  %160 = getelementptr inbounds nuw [120 x double], ptr %3, i64 %121, i64 %158
  %161 = load double, ptr %160, align 8, !tbaa !6
  %162 = fneg double %161
  %163 = tail call double @llvm.fmuladd.f64(double %162, double %161, double %159)
  store double %163, ptr %128, align 8, !tbaa !6
  %164 = add nuw nsw i64 %158, 1
  %165 = icmp eq i64 %164, %121
  br i1 %165, label %.loopexit1, label %157, !llvm.loop !24

.loopexit1:                                       ; preds = %157
  br label %166

166:                                              ; preds = %.loopexit1, %125
  %167 = phi double [ %126, %125 ], [ %163, %.loopexit1 ]
  %168 = getelementptr inbounds nuw [120 x double], ptr %3, i64 %121, i64 %121
  %169 = tail call double @llvm.sqrt.f64(double %167)
  store double %169, ptr %168, align 8, !tbaa !6
  %170 = add nuw nsw i64 %121, 1
  %171 = icmp eq i64 %170, 120
  br i1 %171, label %172, label %120, !llvm.loop !25

172:                                              ; preds = %166
  tail call void @polybench_timer_stop() #7
  tail call void @polybench_timer_print() #7
  %173 = icmp sgt i32 %0, 42
  br i1 %173, label %174, label %212

174:                                              ; preds = %172
  %175 = load ptr, ptr %1, align 8, !tbaa !26
  %176 = load i8, ptr %175, align 1
  %177 = icmp eq i8 %176, 0
  br i1 %177, label %178, label %212

178:                                              ; preds = %174
  %179 = load ptr, ptr @__stderrp, align 8, !tbaa !29
  %180 = tail call i64 @fwrite(ptr nonnull @.str.1, i64 22, i64 1, ptr %179)
  %181 = load ptr, ptr @__stderrp, align 8, !tbaa !29
  %182 = tail call i32 (ptr, ptr, ...) @fprintf(ptr noundef %181, ptr noundef nonnull @.str.2, ptr noundef nonnull @.str.3) #7
  br label %183

183:                                              ; preds = %203, %178
  %184 = phi i64 [ 0, %178 ], [ %204, %203 ]
  %185 = phi i64 [ 1, %178 ], [ %205, %203 ]
  %186 = mul nuw nsw i64 %184, 120
  br label %187

187:                                              ; preds = %196, %183
  %188 = phi i64 [ 0, %183 ], [ %201, %196 ]
  %189 = add nuw nsw i64 %188, %186
  %190 = trunc nuw nsw i64 %189 to i32
  %191 = urem i32 %190, 20
  %192 = icmp eq i32 %191, 0
  br i1 %192, label %193, label %196

193:                                              ; preds = %187
  %194 = load ptr, ptr @__stderrp, align 8, !tbaa !29
  %195 = tail call i32 @fputc(i32 10, ptr %194)
  br label %196

196:                                              ; preds = %193, %187
  %197 = load ptr, ptr @__stderrp, align 8, !tbaa !29
  %198 = getelementptr inbounds nuw [120 x double], ptr %3, i64 %184, i64 %188
  %199 = load double, ptr %198, align 8, !tbaa !6
  %200 = tail call i32 (ptr, ptr, ...) @fprintf(ptr noundef %197, ptr noundef nonnull @.str.5, double noundef %199) #7
  %201 = add nuw nsw i64 %188, 1
  %202 = icmp eq i64 %201, %185
  br i1 %202, label %203, label %187, !llvm.loop !31

203:                                              ; preds = %196
  %204 = add nuw nsw i64 %184, 1
  %205 = add nuw nsw i64 %185, 1
  %206 = icmp eq i64 %204, 120
  br i1 %206, label %207, label %183, !llvm.loop !32

207:                                              ; preds = %203
  %208 = load ptr, ptr @__stderrp, align 8, !tbaa !29
  %209 = tail call i32 (ptr, ptr, ...) @fprintf(ptr noundef %208, ptr noundef nonnull @.str.6, ptr noundef nonnull @.str.3) #7
  %210 = load ptr, ptr @__stderrp, align 8, !tbaa !29
  %211 = tail call i64 @fwrite(ptr nonnull @.str.7, i64 22, i64 1, ptr %210)
  br label %212

212:                                              ; preds = %207, %174, %172
  tail call void @free(ptr noundef nonnull %3)
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
!14 = distinct !{!14, !11, !13, !12}
!15 = distinct !{!15, !11}
!16 = distinct !{!16, !11}
!17 = distinct !{!17, !11}
!18 = distinct !{!18, !11}
!19 = distinct !{!19, !11, !12, !13}
!20 = distinct !{!20, !11, !12}
!21 = distinct !{!21, !11}
!22 = distinct !{!22, !11}
!23 = distinct !{!23, !11}
!24 = distinct !{!24, !11}
!25 = distinct !{!25, !11}
!26 = !{!27, !27, i64 0}
!27 = !{!"p1 omnipotent char", !28, i64 0}
!28 = !{!"any pointer", !8, i64 0}
!29 = !{!30, !30, i64 0}
!30 = !{!"p1 _ZTS7__sFILE", !28, i64 0}
!31 = distinct !{!31, !11}
!32 = distinct !{!32, !11}
