; ModuleID = 'tests/benchmark.ll'
source_filename = "tests/benchmark.c"
target datalayout = "e-m:o-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-n32:64-S128-Fn32"
target triple = "arm64-apple-macosx15.0.0"

%struct.timeval = type { i64, i32 }

@.str = private unnamed_addr constant [30 x i8] c"Running benchmarks with N=%d\0A\00", align 1
@.str.1 = private unnamed_addr constant [25 x i8] c"Array ops: %.6f seconds\0A\00", align 1
@.str.2 = private unnamed_addr constant [28 x i8] c"Scale offset: %.6f seconds\0A\00", align 1
@.str.3 = private unnamed_addr constant [27 x i8] c"Elementwise: %.6f seconds\0A\00", align 1
@.str.4 = private unnamed_addr constant [51 x i8] c"Sample results: c[0]=%.4f, c[%d]=%.4f, c[%d]=%.4f\0A\00", align 1

; Function Attrs: nofree nounwind ssp uwtable(sync)
define double @get_wall_time() local_unnamed_addr #0 {
  %1 = alloca %struct.timeval, align 8
  call void @llvm.lifetime.start.p0(i64 16, ptr nonnull %1) #8
  %2 = call i32 @gettimeofday(ptr noundef nonnull %1, ptr noundef null)
  %3 = load i64, ptr %1, align 8, !tbaa !6
  %4 = sitofp i64 %3 to double
  %5 = getelementptr inbounds nuw i8, ptr %1, i64 8
  %6 = load i32, ptr %5, align 8, !tbaa !12
  %7 = sitofp i32 %6 to double
  %8 = tail call double @llvm.fmuladd.f64(double %7, double 0x3EB0C6F7A0B5ED8D, double %4)
  call void @llvm.lifetime.end.p0(i64 16, ptr nonnull %1) #8
  ret double %8
}

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.start.p0(i64 immarg, ptr captures(none)) #1

; Function Attrs: nofree nounwind
declare noundef i32 @gettimeofday(ptr noundef captures(none), ptr noundef captures(none)) local_unnamed_addr #2

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare double @llvm.fmuladd.f64(double, double, double) #3

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.end.p0(i64 immarg, ptr captures(none)) #1

; Function Attrs: nofree norecurse nosync nounwind ssp memory(argmem: readwrite) uwtable(sync)
define void @test_array_ops(ptr noundef readonly captures(none) %0, ptr noundef readonly captures(none) %1, ptr noundef writeonly captures(none) %2, i32 noundef %3) local_unnamed_addr #4 {
  %5 = icmp sgt i32 %3, 0
  br i1 %5, label %6, label %8

6:                                                ; preds = %4
  %7 = zext nneg i32 %3 to i64
  br label %9

.loopexit:                                        ; preds = %9
  br label %8

8:                                                ; preds = %.loopexit, %4
  ret void

9:                                                ; preds = %9, %6
  %10 = phi i64 [ 0, %6 ], [ %18, %9 ]
  %11 = getelementptr inbounds nuw float, ptr %0, i64 %10
  %12 = load float, ptr %11, align 4, !tbaa !13
  %13 = getelementptr inbounds nuw float, ptr %1, i64 %10
  %14 = load float, ptr %13, align 4, !tbaa !13
  %15 = fmul float %14, 3.000000e+00
  %16 = tail call float @llvm.fmuladd.f32(float %12, float 2.000000e+00, float %15)
  %17 = getelementptr inbounds nuw float, ptr %2, i64 %10
  store float %16, ptr %17, align 4, !tbaa !13
  %18 = add nuw nsw i64 %10, 1
  %19 = icmp eq i64 %18, %7
  br i1 %19, label %.loopexit, label %9, !llvm.loop !15
}

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare float @llvm.fmuladd.f32(float, float, float) #3

; Function Attrs: nofree norecurse nosync nounwind ssp memory(argmem: readwrite) uwtable(sync)
define void @test_scale_offset(ptr noundef readonly captures(none) %0, ptr noundef writeonly captures(none) %1, i32 noundef %2, float noundef %3, float noundef %4) local_unnamed_addr #4 {
  %6 = icmp sgt i32 %2, 0
  br i1 %6, label %7, label %9

7:                                                ; preds = %5
  %8 = zext nneg i32 %2 to i64
  br label %10

.loopexit:                                        ; preds = %10
  br label %9

9:                                                ; preds = %.loopexit, %5
  ret void

10:                                               ; preds = %10, %7
  %11 = phi i64 [ 0, %7 ], [ %16, %10 ]
  %12 = getelementptr inbounds nuw float, ptr %0, i64 %11
  %13 = load float, ptr %12, align 4, !tbaa !13
  %14 = tail call float @llvm.fmuladd.f32(float %13, float %3, float %4)
  %15 = getelementptr inbounds nuw float, ptr %1, i64 %11
  store float %14, ptr %15, align 4, !tbaa !13
  %16 = add nuw nsw i64 %11, 1
  %17 = icmp eq i64 %16, %8
  br i1 %17, label %.loopexit, label %10, !llvm.loop !18
}

; Function Attrs: nofree norecurse nosync nounwind ssp memory(argmem: readwrite) uwtable(sync)
define void @test_elementwise(ptr noundef readonly captures(none) %0, ptr noundef readonly captures(none) %1, ptr noundef writeonly captures(none) %2, i32 noundef %3) local_unnamed_addr #4 {
  %5 = icmp sgt i32 %3, 0
  br i1 %5, label %6, label %8

6:                                                ; preds = %4
  %7 = zext nneg i32 %3 to i64
  br label %9

.loopexit:                                        ; preds = %9
  br label %8

8:                                                ; preds = %.loopexit, %4
  ret void

9:                                                ; preds = %9, %6
  %10 = phi i64 [ 0, %6 ], [ %19, %9 ]
  %11 = getelementptr inbounds nuw float, ptr %0, i64 %10
  %12 = load float, ptr %11, align 4, !tbaa !13
  %13 = getelementptr inbounds nuw float, ptr %1, i64 %10
  %14 = load float, ptr %13, align 4, !tbaa !13
  %15 = fadd float %12, %14
  %16 = fsub float %12, %14
  %17 = fmul float %15, %16
  %18 = getelementptr inbounds nuw float, ptr %2, i64 %10
  store float %17, ptr %18, align 4, !tbaa !13
  %19 = add nuw nsw i64 %10, 1
  %20 = icmp eq i64 %19, %7
  br i1 %20, label %.loopexit, label %9, !llvm.loop !19
}

; Function Attrs: nounwind ssp uwtable(sync)
define noundef i32 @main(i32 noundef %0, ptr noundef readnone captures(none) %1) local_unnamed_addr #5 {
  %3 = alloca %struct.timeval, align 8
  %4 = alloca %struct.timeval, align 8
  %5 = alloca %struct.timeval, align 8
  %6 = alloca %struct.timeval, align 8
  %7 = alloca %struct.timeval, align 8
  %8 = alloca %struct.timeval, align 8
  %9 = tail call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str, i32 noundef 50000000)
  %10 = tail call dereferenceable_or_null(200000000) ptr @malloc(i64 noundef 200000000) #9
  %11 = tail call dereferenceable_or_null(200000000) ptr @malloc(i64 noundef 200000000) #9
  %12 = tail call dereferenceable_or_null(200000000) ptr @malloc(i64 noundef 200000000) #9
  br label %105

13:                                               ; preds = %105
  call void @llvm.lifetime.start.p0(i64 16, ptr nonnull %8) #8
  %14 = call i32 @gettimeofday(ptr noundef nonnull %8, ptr noundef null)
  %15 = load i64, ptr %8, align 8, !tbaa !6
  %16 = getelementptr inbounds nuw i8, ptr %8, i64 8
  %17 = load i32, ptr %16, align 8, !tbaa !12
  call void @llvm.lifetime.end.p0(i64 16, ptr nonnull %8) #8
  br label %18

18:                                               ; preds = %18, %13
  %19 = phi i64 [ 0, %13 ], [ %27, %18 ]
  %20 = getelementptr inbounds nuw float, ptr %10, i64 %19
  %21 = load float, ptr %20, align 4, !tbaa !13
  %22 = getelementptr inbounds nuw float, ptr %11, i64 %19
  %23 = load float, ptr %22, align 4, !tbaa !13
  %24 = fmul float %23, 3.000000e+00
  %25 = tail call float @llvm.fmuladd.f32(float %21, float 2.000000e+00, float %24)
  %26 = getelementptr inbounds nuw float, ptr %12, i64 %19
  store float %25, ptr %26, align 4, !tbaa !13
  %27 = add nuw nsw i64 %19, 1
  %28 = icmp eq i64 %27, 50000000
  br i1 %28, label %29, label %18, !llvm.loop !15

29:                                               ; preds = %18
  %30 = sitofp i64 %15 to double
  %31 = sitofp i32 %17 to double
  %32 = tail call double @llvm.fmuladd.f64(double %31, double 0x3EB0C6F7A0B5ED8D, double %30)
  call void @llvm.lifetime.start.p0(i64 16, ptr nonnull %7) #8
  %33 = call i32 @gettimeofday(ptr noundef nonnull %7, ptr noundef null)
  %34 = load i64, ptr %7, align 8, !tbaa !6
  %35 = sitofp i64 %34 to double
  %36 = getelementptr inbounds nuw i8, ptr %7, i64 8
  %37 = load i32, ptr %36, align 8, !tbaa !12
  %38 = sitofp i32 %37 to double
  %39 = tail call double @llvm.fmuladd.f64(double %38, double 0x3EB0C6F7A0B5ED8D, double %35)
  call void @llvm.lifetime.end.p0(i64 16, ptr nonnull %7) #8
  %40 = fsub double %39, %32
  %41 = tail call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.1, double noundef %40)
  call void @llvm.lifetime.start.p0(i64 16, ptr nonnull %6) #8
  %42 = call i32 @gettimeofday(ptr noundef nonnull %6, ptr noundef null)
  %43 = load i64, ptr %6, align 8, !tbaa !6
  %44 = getelementptr inbounds nuw i8, ptr %6, i64 8
  %45 = load i32, ptr %44, align 8, !tbaa !12
  call void @llvm.lifetime.end.p0(i64 16, ptr nonnull %6) #8
  br label %46

46:                                               ; preds = %46, %29
  %47 = phi i64 [ 0, %29 ], [ %52, %46 ]
  %48 = getelementptr inbounds nuw float, ptr %10, i64 %47
  %49 = load float, ptr %48, align 4, !tbaa !13
  %50 = tail call float @llvm.fmuladd.f32(float %49, float 2.500000e+00, float 1.000000e+00)
  %51 = getelementptr inbounds nuw float, ptr %12, i64 %47
  store float %50, ptr %51, align 4, !tbaa !13
  %52 = add nuw nsw i64 %47, 1
  %53 = icmp eq i64 %52, 50000000
  br i1 %53, label %54, label %46, !llvm.loop !18

54:                                               ; preds = %46
  %55 = sitofp i64 %43 to double
  %56 = sitofp i32 %45 to double
  %57 = tail call double @llvm.fmuladd.f64(double %56, double 0x3EB0C6F7A0B5ED8D, double %55)
  call void @llvm.lifetime.start.p0(i64 16, ptr nonnull %5) #8
  %58 = call i32 @gettimeofday(ptr noundef nonnull %5, ptr noundef null)
  %59 = load i64, ptr %5, align 8, !tbaa !6
  %60 = sitofp i64 %59 to double
  %61 = getelementptr inbounds nuw i8, ptr %5, i64 8
  %62 = load i32, ptr %61, align 8, !tbaa !12
  %63 = sitofp i32 %62 to double
  %64 = tail call double @llvm.fmuladd.f64(double %63, double 0x3EB0C6F7A0B5ED8D, double %60)
  call void @llvm.lifetime.end.p0(i64 16, ptr nonnull %5) #8
  %65 = fsub double %64, %57
  %66 = tail call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.2, double noundef %65)
  call void @llvm.lifetime.start.p0(i64 16, ptr nonnull %4) #8
  %67 = call i32 @gettimeofday(ptr noundef nonnull %4, ptr noundef null)
  %68 = load i64, ptr %4, align 8, !tbaa !6
  %69 = getelementptr inbounds nuw i8, ptr %4, i64 8
  %70 = load i32, ptr %69, align 8, !tbaa !12
  call void @llvm.lifetime.end.p0(i64 16, ptr nonnull %4) #8
  br label %71

71:                                               ; preds = %71, %54
  %72 = phi i64 [ 0, %54 ], [ %81, %71 ]
  %73 = getelementptr inbounds nuw float, ptr %10, i64 %72
  %74 = load float, ptr %73, align 4, !tbaa !13
  %75 = getelementptr inbounds nuw float, ptr %11, i64 %72
  %76 = load float, ptr %75, align 4, !tbaa !13
  %77 = fadd float %74, %76
  %78 = fsub float %74, %76
  %79 = fmul float %77, %78
  %80 = getelementptr inbounds nuw float, ptr %12, i64 %72
  store float %79, ptr %80, align 4, !tbaa !13
  %81 = add nuw nsw i64 %72, 1
  %82 = icmp eq i64 %81, 50000000
  br i1 %82, label %83, label %71, !llvm.loop !19

83:                                               ; preds = %71
  %84 = sitofp i32 %70 to double
  %85 = sitofp i64 %68 to double
  %86 = tail call double @llvm.fmuladd.f64(double %84, double 0x3EB0C6F7A0B5ED8D, double %85)
  call void @llvm.lifetime.start.p0(i64 16, ptr nonnull %3) #8
  %87 = call i32 @gettimeofday(ptr noundef nonnull %3, ptr noundef null)
  %88 = load i64, ptr %3, align 8, !tbaa !6
  %89 = sitofp i64 %88 to double
  %90 = getelementptr inbounds nuw i8, ptr %3, i64 8
  %91 = load i32, ptr %90, align 8, !tbaa !12
  %92 = sitofp i32 %91 to double
  %93 = tail call double @llvm.fmuladd.f64(double %92, double 0x3EB0C6F7A0B5ED8D, double %89)
  call void @llvm.lifetime.end.p0(i64 16, ptr nonnull %3) #8
  %94 = fsub double %93, %86
  %95 = tail call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.3, double noundef %94)
  %96 = load float, ptr %12, align 4, !tbaa !13
  %97 = fpext float %96 to double
  %98 = getelementptr inbounds nuw i8, ptr %12, i64 100000000
  %99 = load float, ptr %98, align 4, !tbaa !13
  %100 = fpext float %99 to double
  %101 = getelementptr inbounds nuw i8, ptr %12, i64 199999996
  %102 = load float, ptr %101, align 4, !tbaa !13
  %103 = fpext float %102 to double
  %104 = tail call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.4, double noundef %97, i32 noundef 25000000, double noundef %100, i32 noundef 49999999, double noundef %103)
  tail call void @free(ptr noundef %10)
  tail call void @free(ptr noundef %11)
  tail call void @free(ptr noundef %12)
  ret i32 0

105:                                              ; preds = %105, %2
  %106 = phi i64 [ 0, %2 ], [ %116, %105 ]
  %107 = trunc nuw nsw i64 %106 to i32
  %108 = uitofp nneg i32 %107 to float
  %109 = fdiv float %108, 5.000000e+07
  %110 = getelementptr inbounds nuw float, ptr %10, i64 %106
  store float %109, ptr %110, align 4, !tbaa !13
  %111 = trunc i64 %106 to i32
  %112 = sub i32 50000000, %111
  %113 = uitofp nneg i32 %112 to float
  %114 = fdiv float %113, 5.000000e+07
  %115 = getelementptr inbounds nuw float, ptr %11, i64 %106
  store float %114, ptr %115, align 4, !tbaa !13
  %116 = add nuw nsw i64 %106, 1
  %117 = icmp eq i64 %116, 50000000
  br i1 %117, label %13, label %105, !llvm.loop !20
}

; Function Attrs: nofree nounwind
declare noundef i32 @printf(ptr noundef readonly captures(none), ...) local_unnamed_addr #2

; Function Attrs: mustprogress nofree nounwind willreturn allockind("alloc,uninitialized") allocsize(0) memory(inaccessiblemem: readwrite)
declare noalias noundef ptr @malloc(i64 noundef) local_unnamed_addr #6

; Function Attrs: mustprogress nounwind willreturn allockind("free") memory(argmem: readwrite, inaccessiblemem: readwrite)
declare void @free(ptr allocptr noundef captures(none)) local_unnamed_addr #7

attributes #0 = { nofree nounwind ssp uwtable(sync) "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+ccpp,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a" }
attributes #1 = { nocallback nofree nosync nounwind willreturn memory(argmem: readwrite) }
attributes #2 = { nofree nounwind "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+ccpp,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a" }
attributes #3 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #4 = { nofree norecurse nosync nounwind ssp memory(argmem: readwrite) uwtable(sync) "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+ccpp,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a" }
attributes #5 = { nounwind ssp uwtable(sync) "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+ccpp,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a" }
attributes #6 = { mustprogress nofree nounwind willreturn allockind("alloc,uninitialized") allocsize(0) memory(inaccessiblemem: readwrite) "alloc-family"="malloc" "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+ccpp,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a" }
attributes #7 = { mustprogress nounwind willreturn allockind("free") memory(argmem: readwrite, inaccessiblemem: readwrite) "alloc-family"="malloc" "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+ccpp,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a" }
attributes #8 = { nounwind }
attributes #9 = { allocsize(0) }

!llvm.module.flags = !{!0, !1, !2, !3, !4}
!llvm.ident = !{!5}

!0 = !{i32 2, !"SDK Version", [2 x i32] [i32 15, i32 2]}
!1 = !{i32 1, !"wchar_size", i32 4}
!2 = !{i32 8, !"PIC Level", i32 2}
!3 = !{i32 7, !"uwtable", i32 1}
!4 = !{i32 7, !"frame-pointer", i32 1}
!5 = !{!"Homebrew clang version 21.1.2"}
!6 = !{!7, !8, i64 0}
!7 = !{!"timeval", !8, i64 0, !11, i64 8}
!8 = !{!"long", !9, i64 0}
!9 = !{!"omnipotent char", !10, i64 0}
!10 = !{!"Simple C/C++ TBAA"}
!11 = !{!"int", !9, i64 0}
!12 = !{!7, !11, i64 8}
!13 = !{!14, !14, i64 0}
!14 = !{!"float", !9, i64 0}
!15 = distinct !{!15, !16, !17}
!16 = !{!"llvm.loop.mustprogress"}
!17 = !{!"llvm.loop.unroll.disable"}
!18 = distinct !{!18, !16, !17}
!19 = distinct !{!19, !16, !17}
!20 = distinct !{!20, !16, !17}
