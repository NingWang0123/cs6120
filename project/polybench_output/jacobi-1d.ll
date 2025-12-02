; ModuleID = './polybench/stencils/jacobi-1d/jacobi-1d.c'
source_filename = "./polybench/stencils/jacobi-1d/jacobi-1d.c"
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
  %3 = tail call ptr @polybench_alloc_data(i64 noundef 120, i32 noundef 8) #5
  %4 = tail call ptr @polybench_alloc_data(i64 noundef 120, i32 noundef 8) #5
  %5 = ptrtoint ptr %4 to i64
  %6 = ptrtoint ptr %3 to i64
  %7 = sub i64 %5, %6
  %8 = icmp ult i64 %7, 64
  br i1 %8, label %47, label %9

9:                                                ; preds = %2, %9
  %10 = phi i64 [ %44, %9 ], [ 0, %2 ]
  %11 = phi <2 x i32> [ %45, %9 ], [ <i32 0, i32 1>, %2 ]
  %12 = add <2 x i32> %11, splat (i32 2)
  %13 = add <2 x i32> %11, splat (i32 4)
  %14 = add <2 x i32> %11, splat (i32 6)
  %15 = add <2 x i32> %11, splat (i32 8)
  %16 = uitofp nneg <2 x i32> %12 to <2 x double>
  %17 = uitofp nneg <2 x i32> %13 to <2 x double>
  %18 = uitofp nneg <2 x i32> %14 to <2 x double>
  %19 = uitofp nneg <2 x i32> %15 to <2 x double>
  %20 = fdiv <2 x double> %16, splat (double 1.200000e+02)
  %21 = fdiv <2 x double> %17, splat (double 1.200000e+02)
  %22 = fdiv <2 x double> %18, splat (double 1.200000e+02)
  %23 = fdiv <2 x double> %19, splat (double 1.200000e+02)
  %24 = getelementptr inbounds nuw double, ptr %3, i64 %10
  %25 = getelementptr inbounds nuw i8, ptr %24, i64 16
  %26 = getelementptr inbounds nuw i8, ptr %24, i64 32
  %27 = getelementptr inbounds nuw i8, ptr %24, i64 48
  store <2 x double> %20, ptr %24, align 8, !tbaa !6
  store <2 x double> %21, ptr %25, align 8, !tbaa !6
  store <2 x double> %22, ptr %26, align 8, !tbaa !6
  store <2 x double> %23, ptr %27, align 8, !tbaa !6
  %28 = add <2 x i32> %11, splat (i32 3)
  %29 = add <2 x i32> %11, splat (i32 5)
  %30 = add <2 x i32> %11, splat (i32 7)
  %31 = add <2 x i32> %11, splat (i32 9)
  %32 = uitofp nneg <2 x i32> %28 to <2 x double>
  %33 = uitofp nneg <2 x i32> %29 to <2 x double>
  %34 = uitofp nneg <2 x i32> %30 to <2 x double>
  %35 = uitofp nneg <2 x i32> %31 to <2 x double>
  %36 = fdiv <2 x double> %32, splat (double 1.200000e+02)
  %37 = fdiv <2 x double> %33, splat (double 1.200000e+02)
  %38 = fdiv <2 x double> %34, splat (double 1.200000e+02)
  %39 = fdiv <2 x double> %35, splat (double 1.200000e+02)
  %40 = getelementptr inbounds nuw double, ptr %4, i64 %10
  %41 = getelementptr inbounds nuw i8, ptr %40, i64 16
  %42 = getelementptr inbounds nuw i8, ptr %40, i64 32
  %43 = getelementptr inbounds nuw i8, ptr %40, i64 48
  store <2 x double> %36, ptr %40, align 8, !tbaa !6
  store <2 x double> %37, ptr %41, align 8, !tbaa !6
  store <2 x double> %38, ptr %42, align 8, !tbaa !6
  store <2 x double> %39, ptr %43, align 8, !tbaa !6
  %44 = add nuw i64 %10, 8
  %45 = add <2 x i32> %11, splat (i32 8)
  %46 = icmp eq i64 %44, 120
  br i1 %46, label %60, label %9, !llvm.loop !10

47:                                               ; preds = %2, %47
  %48 = phi i64 [ %58, %47 ], [ 0, %2 ]
  %49 = trunc i64 %48 to i32
  %50 = add i32 %49, 2
  %51 = uitofp nneg i32 %50 to double
  %52 = fdiv double %51, 1.200000e+02
  %53 = getelementptr inbounds nuw double, ptr %3, i64 %48
  store double %52, ptr %53, align 8, !tbaa !6
  %54 = add i32 %49, 3
  %55 = uitofp nneg i32 %54 to double
  %56 = fdiv double %55, 1.200000e+02
  %57 = getelementptr inbounds nuw double, ptr %4, i64 %48
  store double %56, ptr %57, align 8, !tbaa !6
  %58 = add nuw nsw i64 %48, 1
  %59 = icmp eq i64 %58, 120
  br i1 %59, label %60, label %47, !llvm.loop !14

60:                                               ; preds = %9, %47
  tail call void @polybench_timer_start() #5
  %61 = getelementptr i8, ptr %3, i64 8
  %62 = getelementptr i8, ptr %3, i64 952
  %63 = getelementptr i8, ptr %4, i64 960
  %64 = getelementptr i8, ptr %4, i64 8
  %65 = getelementptr i8, ptr %4, i64 952
  %66 = getelementptr i8, ptr %3, i64 960
  %67 = icmp ult ptr %64, %66
  %68 = icmp ult ptr %3, %65
  %69 = and i1 %67, %68
  %70 = icmp ult ptr %61, %63
  %71 = icmp ult ptr %4, %62
  %72 = and i1 %70, %71
  br label %73

73:                                               ; preds = %60, %200
  %74 = phi i32 [ 0, %60 ], [ %201, %200 ]
  br i1 %69, label %121, label %75

75:                                               ; preds = %73, %75
  %76 = phi i64 [ %119, %75 ], [ 0, %73 ]
  %77 = or disjoint i64 %76, 1
  %78 = getelementptr double, ptr %3, i64 %77
  %79 = getelementptr i8, ptr %78, i64 -8
  %80 = getelementptr i8, ptr %78, i64 8
  %81 = getelementptr i8, ptr %78, i64 24
  %82 = getelementptr i8, ptr %78, i64 40
  %83 = load <2 x double>, ptr %79, align 8, !tbaa !6, !alias.scope !15
  %84 = load <2 x double>, ptr %80, align 8, !tbaa !6, !alias.scope !15
  %85 = load <2 x double>, ptr %81, align 8, !tbaa !6, !alias.scope !15
  %86 = load <2 x double>, ptr %82, align 8, !tbaa !6, !alias.scope !15
  %87 = getelementptr i8, ptr %78, i64 16
  %88 = getelementptr i8, ptr %78, i64 32
  %89 = getelementptr i8, ptr %78, i64 48
  %90 = load <2 x double>, ptr %78, align 8, !tbaa !6, !alias.scope !15
  %91 = load <2 x double>, ptr %87, align 8, !tbaa !6, !alias.scope !15
  %92 = load <2 x double>, ptr %88, align 8, !tbaa !6, !alias.scope !15
  %93 = load <2 x double>, ptr %89, align 8, !tbaa !6, !alias.scope !15
  %94 = fadd <2 x double> %83, %90
  %95 = fadd <2 x double> %84, %91
  %96 = fadd <2 x double> %85, %92
  %97 = fadd <2 x double> %86, %93
  %98 = getelementptr inbounds nuw double, ptr %3, i64 %76
  %99 = getelementptr inbounds nuw i8, ptr %98, i64 16
  %100 = getelementptr inbounds nuw i8, ptr %98, i64 32
  %101 = getelementptr inbounds nuw i8, ptr %98, i64 48
  %102 = getelementptr inbounds nuw i8, ptr %98, i64 64
  %103 = load <2 x double>, ptr %99, align 8, !tbaa !6, !alias.scope !15
  %104 = load <2 x double>, ptr %100, align 8, !tbaa !6, !alias.scope !15
  %105 = load <2 x double>, ptr %101, align 8, !tbaa !6, !alias.scope !15
  %106 = load <2 x double>, ptr %102, align 8, !tbaa !6, !alias.scope !15
  %107 = fadd <2 x double> %94, %103
  %108 = fadd <2 x double> %95, %104
  %109 = fadd <2 x double> %96, %105
  %110 = fadd <2 x double> %97, %106
  %111 = fmul <2 x double> %107, splat (double 3.333300e-01)
  %112 = fmul <2 x double> %108, splat (double 3.333300e-01)
  %113 = fmul <2 x double> %109, splat (double 3.333300e-01)
  %114 = fmul <2 x double> %110, splat (double 3.333300e-01)
  %115 = getelementptr inbounds nuw double, ptr %4, i64 %77
  %116 = getelementptr inbounds nuw i8, ptr %115, i64 16
  %117 = getelementptr inbounds nuw i8, ptr %115, i64 32
  %118 = getelementptr inbounds nuw i8, ptr %115, i64 48
  store <2 x double> %111, ptr %115, align 8, !tbaa !6, !alias.scope !18, !noalias !15
  store <2 x double> %112, ptr %116, align 8, !tbaa !6, !alias.scope !18, !noalias !15
  store <2 x double> %113, ptr %117, align 8, !tbaa !6, !alias.scope !18, !noalias !15
  store <2 x double> %114, ptr %118, align 8, !tbaa !6, !alias.scope !18, !noalias !15
  %119 = add nuw i64 %76, 8
  %120 = icmp eq i64 %119, 112
  br i1 %120, label %121, label %75, !llvm.loop !20

121:                                              ; preds = %75, %73
  %122 = phi i64 [ 1, %73 ], [ 113, %75 ]
  br label %123

123:                                              ; preds = %121, %123
  %124 = phi i64 [ %130, %123 ], [ %122, %121 ]
  %125 = getelementptr double, ptr %3, i64 %124
  %126 = getelementptr i8, ptr %125, i64 -8
  %127 = load double, ptr %126, align 8, !tbaa !6
  %128 = load double, ptr %125, align 8, !tbaa !6
  %129 = fadd double %127, %128
  %130 = add nuw nsw i64 %124, 1
  %131 = getelementptr inbounds nuw double, ptr %3, i64 %130
  %132 = load double, ptr %131, align 8, !tbaa !6
  %133 = fadd double %129, %132
  %134 = fmul double %133, 3.333300e-01
  %135 = getelementptr inbounds nuw double, ptr %4, i64 %124
  store double %134, ptr %135, align 8, !tbaa !6
  %136 = icmp eq i64 %130, 119
  br i1 %136, label %137, label %123, !llvm.loop !21

137:                                              ; preds = %123
  br i1 %72, label %184, label %138

138:                                              ; preds = %137, %138
  %139 = phi i64 [ %182, %138 ], [ 0, %137 ]
  %140 = or disjoint i64 %139, 1
  %141 = getelementptr double, ptr %4, i64 %140
  %142 = getelementptr i8, ptr %141, i64 -8
  %143 = getelementptr i8, ptr %141, i64 8
  %144 = getelementptr i8, ptr %141, i64 24
  %145 = getelementptr i8, ptr %141, i64 40
  %146 = load <2 x double>, ptr %142, align 8, !tbaa !6, !alias.scope !22
  %147 = load <2 x double>, ptr %143, align 8, !tbaa !6, !alias.scope !22
  %148 = load <2 x double>, ptr %144, align 8, !tbaa !6, !alias.scope !22
  %149 = load <2 x double>, ptr %145, align 8, !tbaa !6, !alias.scope !22
  %150 = getelementptr i8, ptr %141, i64 16
  %151 = getelementptr i8, ptr %141, i64 32
  %152 = getelementptr i8, ptr %141, i64 48
  %153 = load <2 x double>, ptr %141, align 8, !tbaa !6, !alias.scope !22
  %154 = load <2 x double>, ptr %150, align 8, !tbaa !6, !alias.scope !22
  %155 = load <2 x double>, ptr %151, align 8, !tbaa !6, !alias.scope !22
  %156 = load <2 x double>, ptr %152, align 8, !tbaa !6, !alias.scope !22
  %157 = fadd <2 x double> %146, %153
  %158 = fadd <2 x double> %147, %154
  %159 = fadd <2 x double> %148, %155
  %160 = fadd <2 x double> %149, %156
  %161 = getelementptr inbounds nuw double, ptr %4, i64 %139
  %162 = getelementptr inbounds nuw i8, ptr %161, i64 16
  %163 = getelementptr inbounds nuw i8, ptr %161, i64 32
  %164 = getelementptr inbounds nuw i8, ptr %161, i64 48
  %165 = getelementptr inbounds nuw i8, ptr %161, i64 64
  %166 = load <2 x double>, ptr %162, align 8, !tbaa !6, !alias.scope !22
  %167 = load <2 x double>, ptr %163, align 8, !tbaa !6, !alias.scope !22
  %168 = load <2 x double>, ptr %164, align 8, !tbaa !6, !alias.scope !22
  %169 = load <2 x double>, ptr %165, align 8, !tbaa !6, !alias.scope !22
  %170 = fadd <2 x double> %157, %166
  %171 = fadd <2 x double> %158, %167
  %172 = fadd <2 x double> %159, %168
  %173 = fadd <2 x double> %160, %169
  %174 = fmul <2 x double> %170, splat (double 3.333300e-01)
  %175 = fmul <2 x double> %171, splat (double 3.333300e-01)
  %176 = fmul <2 x double> %172, splat (double 3.333300e-01)
  %177 = fmul <2 x double> %173, splat (double 3.333300e-01)
  %178 = getelementptr inbounds nuw double, ptr %3, i64 %140
  %179 = getelementptr inbounds nuw i8, ptr %178, i64 16
  %180 = getelementptr inbounds nuw i8, ptr %178, i64 32
  %181 = getelementptr inbounds nuw i8, ptr %178, i64 48
  store <2 x double> %174, ptr %178, align 8, !tbaa !6, !alias.scope !25, !noalias !22
  store <2 x double> %175, ptr %179, align 8, !tbaa !6, !alias.scope !25, !noalias !22
  store <2 x double> %176, ptr %180, align 8, !tbaa !6, !alias.scope !25, !noalias !22
  store <2 x double> %177, ptr %181, align 8, !tbaa !6, !alias.scope !25, !noalias !22
  %182 = add nuw i64 %139, 8
  %183 = icmp eq i64 %182, 112
  br i1 %183, label %184, label %138, !llvm.loop !27

184:                                              ; preds = %138, %137
  %185 = phi i64 [ 1, %137 ], [ 113, %138 ]
  br label %186

186:                                              ; preds = %184, %186
  %187 = phi i64 [ %193, %186 ], [ %185, %184 ]
  %188 = getelementptr double, ptr %4, i64 %187
  %189 = getelementptr i8, ptr %188, i64 -8
  %190 = load double, ptr %189, align 8, !tbaa !6
  %191 = load double, ptr %188, align 8, !tbaa !6
  %192 = fadd double %190, %191
  %193 = add nuw nsw i64 %187, 1
  %194 = getelementptr inbounds nuw double, ptr %4, i64 %193
  %195 = load double, ptr %194, align 8, !tbaa !6
  %196 = fadd double %192, %195
  %197 = fmul double %196, 3.333300e-01
  %198 = getelementptr inbounds nuw double, ptr %3, i64 %187
  store double %197, ptr %198, align 8, !tbaa !6
  %199 = icmp eq i64 %193, 119
  br i1 %199, label %200, label %186, !llvm.loop !28

200:                                              ; preds = %186
  %201 = add nuw nsw i32 %74, 1
  %202 = icmp eq i32 %201, 40
  br i1 %202, label %203, label %73, !llvm.loop !29

203:                                              ; preds = %200
  tail call void @polybench_timer_stop() #5
  tail call void @polybench_timer_print() #5
  %204 = icmp sgt i32 %0, 42
  br i1 %204, label %205, label %234

205:                                              ; preds = %203
  %206 = load ptr, ptr %1, align 8, !tbaa !30
  %207 = load i8, ptr %206, align 1
  %208 = icmp eq i8 %207, 0
  br i1 %208, label %209, label %234

209:                                              ; preds = %205
  %210 = load ptr, ptr @__stderrp, align 8, !tbaa !33
  %211 = tail call i64 @fwrite(ptr nonnull @.str.1, i64 22, i64 1, ptr %210)
  %212 = load ptr, ptr @__stderrp, align 8, !tbaa !33
  %213 = tail call i32 (ptr, ptr, ...) @fprintf(ptr noundef %212, ptr noundef nonnull @.str.2, ptr noundef nonnull @.str.3) #5
  br label %214

214:                                              ; preds = %222, %209
  %215 = phi i64 [ 0, %209 ], [ %227, %222 ]
  %216 = trunc i64 %215 to i8
  %217 = urem i8 %216, 20
  %218 = icmp eq i8 %217, 0
  br i1 %218, label %219, label %222

219:                                              ; preds = %214
  %220 = load ptr, ptr @__stderrp, align 8, !tbaa !33
  %221 = tail call i32 @fputc(i32 10, ptr %220)
  br label %222

222:                                              ; preds = %219, %214
  %223 = load ptr, ptr @__stderrp, align 8, !tbaa !33
  %224 = getelementptr inbounds nuw double, ptr %3, i64 %215
  %225 = load double, ptr %224, align 8, !tbaa !6
  %226 = tail call i32 (ptr, ptr, ...) @fprintf(ptr noundef %223, ptr noundef nonnull @.str.5, double noundef %225) #5
  %227 = add nuw nsw i64 %215, 1
  %228 = icmp eq i64 %227, 120
  br i1 %228, label %229, label %214, !llvm.loop !35

229:                                              ; preds = %222
  %230 = load ptr, ptr @__stderrp, align 8, !tbaa !33
  %231 = tail call i32 (ptr, ptr, ...) @fprintf(ptr noundef %230, ptr noundef nonnull @.str.6, ptr noundef nonnull @.str.3) #5
  %232 = load ptr, ptr @__stderrp, align 8, !tbaa !33
  %233 = tail call i64 @fwrite(ptr nonnull @.str.7, i64 22, i64 1, ptr %232)
  br label %234

234:                                              ; preds = %229, %205, %203
  tail call void @free(ptr noundef nonnull %3)
  tail call void @free(ptr noundef %4)
  ret i32 0
}

declare ptr @polybench_alloc_data(i64 noundef, i32 noundef) local_unnamed_addr #1

declare void @polybench_timer_start(...) local_unnamed_addr #1

declare void @polybench_timer_stop(...) local_unnamed_addr #1

declare void @polybench_timer_print(...) local_unnamed_addr #1

; Function Attrs: mustprogress nounwind willreturn allockind("free") memory(argmem: readwrite, inaccessiblemem: readwrite)
declare void @free(ptr allocptr noundef captures(none)) local_unnamed_addr #2

; Function Attrs: nofree nounwind
declare noundef i32 @fprintf(ptr noundef captures(none), ptr noundef readonly captures(none), ...) local_unnamed_addr #3

; Function Attrs: nofree nounwind
declare noundef i64 @fwrite(ptr noundef readonly captures(none), i64 noundef, i64 noundef, ptr noundef captures(none)) local_unnamed_addr #4

; Function Attrs: nofree nounwind
declare noundef i32 @fputc(i32 noundef, ptr noundef captures(none)) local_unnamed_addr #4

attributes #0 = { nounwind ssp uwtable(sync) "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+ccpp,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a" }
attributes #1 = { "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+ccpp,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a" }
attributes #2 = { mustprogress nounwind willreturn allockind("free") memory(argmem: readwrite, inaccessiblemem: readwrite) "alloc-family"="malloc" "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+ccpp,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a" }
attributes #3 = { nofree nounwind "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+ccpp,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a" }
attributes #4 = { nofree nounwind }
attributes #5 = { nounwind }

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
!15 = !{!16}
!16 = distinct !{!16, !17}
!17 = distinct !{!17, !"LVerDomain"}
!18 = !{!19}
!19 = distinct !{!19, !17}
!20 = distinct !{!20, !11, !12, !13}
!21 = distinct !{!21, !11, !12}
!22 = !{!23}
!23 = distinct !{!23, !24}
!24 = distinct !{!24, !"LVerDomain"}
!25 = !{!26}
!26 = distinct !{!26, !24}
!27 = distinct !{!27, !11, !12, !13}
!28 = distinct !{!28, !11, !12}
!29 = distinct !{!29, !11}
!30 = !{!31, !31, i64 0}
!31 = !{!"p1 omnipotent char", !32, i64 0}
!32 = !{!"any pointer", !8, i64 0}
!33 = !{!34, !34, i64 0}
!34 = !{!"p1 _ZTS7__sFILE", !32, i64 0}
!35 = distinct !{!35, !11}
