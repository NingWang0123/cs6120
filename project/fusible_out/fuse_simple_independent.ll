; ModuleID = 'fusible_tests/fuse_simple_independent.c'
source_filename = "fusible_tests/fuse_simple_independent.c"
target datalayout = "e-m:o-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-n32:64-S128-Fn32"
target triple = "arm64-apple-macosx26.0.0"

; Function Attrs: nofree norecurse nosync nounwind ssp memory(argmem: readwrite) uwtable(sync)
define void @fuse_simple_independent(ptr noalias noundef captures(none) %0, ptr noalias noundef captures(none) %1, ptr noalias noundef writeonly captures(address_is_null) %2, i32 noundef %3) local_unnamed_addr #0 {
  %5 = icmp sgt i32 %3, 0
  br i1 %5, label %6, label %134

6:                                                ; preds = %4
  %7 = zext nneg i32 %3 to i64
  %8 = icmp ult i32 %3, 4
  br i1 %8, label %9, label %11

9:                                                ; preds = %38, %57, %6
  %10 = phi i64 [ 0, %6 ], [ %14, %38 ], [ %43, %57 ]
  br label %112

11:                                               ; preds = %6
  %12 = icmp ult i32 %3, 16
  br i1 %12, label %41, label %13

13:                                               ; preds = %11
  %14 = and i64 %7, 2147483632
  br label %15

15:                                               ; preds = %15, %13
  %16 = phi i64 [ 0, %13 ], [ %33, %15 ]
  %17 = phi <4 x i32> [ <i32 0, i32 1, i32 2, i32 3>, %13 ], [ %34, %15 ]
  %18 = add <4 x i32> %17, splat (i32 4)
  %19 = add <4 x i32> %17, splat (i32 8)
  %20 = add <4 x i32> %17, splat (i32 12)
  %21 = uitofp nneg <4 x i32> %17 to <4 x float>
  %22 = uitofp nneg <4 x i32> %18 to <4 x float>
  %23 = uitofp nneg <4 x i32> %19 to <4 x float>
  %24 = uitofp nneg <4 x i32> %20 to <4 x float>
  %25 = fmul <4 x float> %21, splat (float 2.000000e+00)
  %26 = fmul <4 x float> %22, splat (float 2.000000e+00)
  %27 = fmul <4 x float> %23, splat (float 2.000000e+00)
  %28 = fmul <4 x float> %24, splat (float 2.000000e+00)
  %29 = getelementptr inbounds nuw float, ptr %0, i64 %16
  %30 = getelementptr inbounds nuw i8, ptr %29, i64 16
  %31 = getelementptr inbounds nuw i8, ptr %29, i64 32
  %32 = getelementptr inbounds nuw i8, ptr %29, i64 48
  store <4 x float> %25, ptr %29, align 4, !tbaa !6
  store <4 x float> %26, ptr %30, align 4, !tbaa !6
  store <4 x float> %27, ptr %31, align 4, !tbaa !6
  store <4 x float> %28, ptr %32, align 4, !tbaa !6
  %33 = add nuw i64 %16, 16
  %34 = add <4 x i32> %17, splat (i32 16)
  %35 = icmp eq i64 %33, %14
  br i1 %35, label %36, label %15, !llvm.loop !10

36:                                               ; preds = %15
  %37 = icmp eq i64 %14, %7
  br i1 %37, label %59, label %38

38:                                               ; preds = %36
  %39 = and i64 %7, 12
  %40 = icmp eq i64 %39, 0
  br i1 %40, label %9, label %41

41:                                               ; preds = %38, %11
  %42 = phi i64 [ %14, %38 ], [ 0, %11 ]
  %43 = and i64 %7, 2147483644
  %44 = trunc nuw nsw i64 %42 to i32
  %45 = insertelement <4 x i32> poison, i32 %44, i64 0
  %46 = shufflevector <4 x i32> %45, <4 x i32> poison, <4 x i32> zeroinitializer
  %47 = or disjoint <4 x i32> %46, <i32 0, i32 1, i32 2, i32 3>
  br label %48

48:                                               ; preds = %48, %41
  %49 = phi i64 [ %42, %41 ], [ %54, %48 ]
  %50 = phi <4 x i32> [ %47, %41 ], [ %55, %48 ]
  %51 = uitofp nneg <4 x i32> %50 to <4 x float>
  %52 = fmul <4 x float> %51, splat (float 2.000000e+00)
  %53 = getelementptr inbounds nuw float, ptr %0, i64 %49
  store <4 x float> %52, ptr %53, align 4, !tbaa !6
  %54 = add nuw i64 %49, 4
  %55 = add <4 x i32> %50, splat (i32 4)
  %56 = icmp eq i64 %54, %43
  br i1 %56, label %57, label %48, !llvm.loop !14

57:                                               ; preds = %48
  %58 = icmp eq i64 %43, %7
  br i1 %58, label %59, label %9

59:                                               ; preds = %112, %57, %36
  %60 = zext nneg i32 %3 to i64
  %61 = icmp ult i32 %3, 4
  br i1 %61, label %62, label %64

62:                                               ; preds = %91, %110, %59
  %63 = phi i64 [ 0, %59 ], [ %67, %91 ], [ %96, %110 ]
  br label %122

64:                                               ; preds = %59
  %65 = icmp ult i32 %3, 16
  br i1 %65, label %94, label %66

66:                                               ; preds = %64
  %67 = and i64 %7, 2147483632
  br label %68

68:                                               ; preds = %68, %66
  %69 = phi i64 [ 0, %66 ], [ %86, %68 ]
  %70 = phi <4 x i32> [ <i32 0, i32 1, i32 2, i32 3>, %66 ], [ %87, %68 ]
  %71 = add <4 x i32> %70, splat (i32 4)
  %72 = add <4 x i32> %70, splat (i32 8)
  %73 = add <4 x i32> %70, splat (i32 12)
  %74 = uitofp nneg <4 x i32> %70 to <4 x float>
  %75 = uitofp nneg <4 x i32> %71 to <4 x float>
  %76 = uitofp nneg <4 x i32> %72 to <4 x float>
  %77 = uitofp nneg <4 x i32> %73 to <4 x float>
  %78 = fadd <4 x float> %74, splat (float 1.000000e+00)
  %79 = fadd <4 x float> %75, splat (float 1.000000e+00)
  %80 = fadd <4 x float> %76, splat (float 1.000000e+00)
  %81 = fadd <4 x float> %77, splat (float 1.000000e+00)
  %82 = getelementptr inbounds nuw float, ptr %1, i64 %69
  %83 = getelementptr inbounds nuw i8, ptr %82, i64 16
  %84 = getelementptr inbounds nuw i8, ptr %82, i64 32
  %85 = getelementptr inbounds nuw i8, ptr %82, i64 48
  store <4 x float> %78, ptr %82, align 4, !tbaa !6
  store <4 x float> %79, ptr %83, align 4, !tbaa !6
  store <4 x float> %80, ptr %84, align 4, !tbaa !6
  store <4 x float> %81, ptr %85, align 4, !tbaa !6
  %86 = add nuw i64 %69, 16
  %87 = add <4 x i32> %70, splat (i32 16)
  %88 = icmp eq i64 %86, %67
  br i1 %88, label %89, label %68, !llvm.loop !15

89:                                               ; preds = %68
  %90 = icmp eq i64 %67, %7
  br i1 %90, label %120, label %91

91:                                               ; preds = %89
  %92 = and i64 %7, 12
  %93 = icmp eq i64 %92, 0
  br i1 %93, label %62, label %94

94:                                               ; preds = %91, %64
  %95 = phi i64 [ %67, %91 ], [ 0, %64 ]
  %96 = and i64 %7, 2147483644
  %97 = trunc nuw nsw i64 %95 to i32
  %98 = insertelement <4 x i32> poison, i32 %97, i64 0
  %99 = shufflevector <4 x i32> %98, <4 x i32> poison, <4 x i32> zeroinitializer
  %100 = or disjoint <4 x i32> %99, <i32 0, i32 1, i32 2, i32 3>
  br label %101

101:                                              ; preds = %101, %94
  %102 = phi i64 [ %95, %94 ], [ %107, %101 ]
  %103 = phi <4 x i32> [ %100, %94 ], [ %108, %101 ]
  %104 = uitofp nneg <4 x i32> %103 to <4 x float>
  %105 = fadd <4 x float> %104, splat (float 1.000000e+00)
  %106 = getelementptr inbounds nuw float, ptr %1, i64 %102
  store <4 x float> %105, ptr %106, align 4, !tbaa !6
  %107 = add nuw i64 %102, 4
  %108 = add <4 x i32> %103, splat (i32 4)
  %109 = icmp eq i64 %107, %96
  br i1 %109, label %110, label %101, !llvm.loop !16

110:                                              ; preds = %101
  %111 = icmp eq i64 %96, %7
  br i1 %111, label %120, label %62

112:                                              ; preds = %9, %112
  %113 = phi i64 [ %118, %112 ], [ %10, %9 ]
  %114 = trunc nuw nsw i64 %113 to i32
  %115 = uitofp nneg i32 %114 to float
  %116 = fmul float %115, 2.000000e+00
  %117 = getelementptr inbounds nuw float, ptr %0, i64 %113
  store float %116, ptr %117, align 4, !tbaa !6
  %118 = add nuw nsw i64 %113, 1
  %119 = icmp eq i64 %118, %7
  br i1 %119, label %59, label %112, !llvm.loop !17

120:                                              ; preds = %122, %110, %89
  %121 = icmp eq ptr %2, null
  br i1 %121, label %134, label %130

122:                                              ; preds = %62, %122
  %123 = phi i64 [ %128, %122 ], [ %63, %62 ]
  %124 = trunc nuw nsw i64 %123 to i32
  %125 = uitofp nneg i32 %124 to float
  %126 = fadd float %125, 1.000000e+00
  %127 = getelementptr inbounds nuw float, ptr %1, i64 %123
  store float %126, ptr %127, align 4, !tbaa !6
  %128 = add nuw nsw i64 %123, 1
  %129 = icmp eq i64 %128, %60
  br i1 %129, label %120, label %122, !llvm.loop !18

130:                                              ; preds = %120
  %131 = load float, ptr %0, align 4, !tbaa !6
  %132 = load float, ptr %1, align 4, !tbaa !6
  %133 = fadd float %131, %132
  store float %133, ptr %2, align 4, !tbaa !6
  br label %134

134:                                              ; preds = %4, %130, %120
  ret void
}

attributes #0 = { nofree norecurse nosync nounwind ssp memory(argmem: readwrite) uwtable(sync) "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+ccpp,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a" }

!llvm.module.flags = !{!0, !1, !2, !3, !4}
!llvm.ident = !{!5}

!0 = !{i32 2, !"SDK Version", [2 x i32] [i32 26, i32 2]}
!1 = !{i32 1, !"wchar_size", i32 4}
!2 = !{i32 8, !"PIC Level", i32 2}
!3 = !{i32 7, !"uwtable", i32 1}
!4 = !{i32 7, !"frame-pointer", i32 1}
!5 = !{!"Homebrew clang version 21.1.6"}
!6 = !{!7, !7, i64 0}
!7 = !{!"float", !8, i64 0}
!8 = !{!"omnipotent char", !9, i64 0}
!9 = !{!"Simple C/C++ TBAA"}
!10 = distinct !{!10, !11, !12, !13}
!11 = !{!"llvm.loop.mustprogress"}
!12 = !{!"llvm.loop.isvectorized", i32 1}
!13 = !{!"llvm.loop.unroll.runtime.disable"}
!14 = distinct !{!14, !11, !12, !13}
!15 = distinct !{!15, !11, !12, !13}
!16 = distinct !{!16, !11, !12, !13}
!17 = distinct !{!17, !11, !13, !12}
!18 = distinct !{!18, !11, !13, !12}
