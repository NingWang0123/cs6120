; ModuleID = 'polybench_results/floyd-warshall.ll'
source_filename = "./polybench/medley/floyd-warshall/floyd-warshall.c"
target datalayout = "e-m:o-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-n32:64-S128-Fn32"
target triple = "arm64-apple-macosx15.0.0"

@__stderrp = external local_unnamed_addr global ptr, align 8
@.str.1 = private unnamed_addr constant [23 x i8] c"==BEGIN DUMP_ARRAYS==\0A\00", align 1
@.str.2 = private unnamed_addr constant [15 x i8] c"begin dump: %s\00", align 1
@.str.3 = private unnamed_addr constant [5 x i8] c"path\00", align 1
@.str.5 = private unnamed_addr constant [4 x i8] c"%d \00", align 1
@.str.6 = private unnamed_addr constant [17 x i8] c"\0Aend   dump: %s\0A\00", align 1
@.str.7 = private unnamed_addr constant [23 x i8] c"==END   DUMP_ARRAYS==\0A\00", align 1

; Function Attrs: nounwind ssp uwtable(sync)
define noundef i32 @main(i32 noundef %0, ptr noundef readonly captures(none) %1) local_unnamed_addr #0 {
  %3 = tail call ptr @polybench_alloc_data(i64 noundef 32400, i32 noundef 4) #6
  br label %4

4:                                                ; preds = %30, %2
  %5 = phi i64 [ 0, %2 ], [ %31, %30 ]
  %6 = insertelement <4 x i64> poison, i64 %5, i64 0
  %7 = shufflevector <4 x i64> %6, <4 x i64> poison, <4 x i32> zeroinitializer
  br label %8

8:                                                ; preds = %8, %4
  %9 = phi i64 [ 0, %4 ], [ %27, %8 ]
  %10 = phi <4 x i64> [ <i64 0, i64 1, i64 2, i64 3>, %4 ], [ %28, %8 ]
  %11 = mul nuw nsw <4 x i64> %10, %7
  %12 = trunc nuw nsw <4 x i64> %11 to <4 x i32>
  %13 = urem <4 x i32> %12, splat (i32 7)
  %14 = add nuw nsw <4 x i32> %13, splat (i32 1)
  %15 = getelementptr inbounds nuw [180 x i32], ptr %3, i64 %5, i64 %9
  %16 = add nuw nsw <4 x i64> %10, %7
  %17 = trunc nuw nsw <4 x i64> %16 to <4 x i32>
  %18 = urem <4 x i32> %17, splat (i32 13)
  %19 = icmp eq <4 x i32> %18, zeroinitializer
  %20 = urem <4 x i32> %17, splat (i32 7)
  %21 = icmp eq <4 x i32> %20, zeroinitializer
  %22 = or <4 x i1> %19, %21
  %23 = urem <4 x i32> %17, splat (i32 11)
  %24 = icmp eq <4 x i32> %23, zeroinitializer
  %25 = or <4 x i1> %24, %22
  %26 = select <4 x i1> %25, <4 x i32> splat (i32 999), <4 x i32> %14
  store <4 x i32> %26, ptr %15, align 4, !tbaa !6
  %27 = add nuw i64 %9, 4
  %28 = add <4 x i64> %10, splat (i64 4)
  %29 = icmp eq i64 %27, 180
  br i1 %29, label %30, label %8, !llvm.loop !10

30:                                               ; preds = %8
  %31 = add nuw nsw i64 %5, 1
  %32 = icmp eq i64 %31, 180
  br i1 %32, label %33, label %4, !llvm.loop !14

33:                                               ; preds = %30
  tail call void @polybench_timer_start() #6
  %34 = getelementptr i8, ptr %3, i64 129600
  %35 = getelementptr i8, ptr %3, i64 128884
  %36 = getelementptr i8, ptr %3, i64 720
  br label %37

37:                                               ; preds = %111, %33
  %38 = phi i64 [ 0, %33 ], [ %112, %111 ]
  %39 = shl nuw nsw i64 %38, 2
  %40 = getelementptr nuw i8, ptr %3, i64 %39
  %41 = getelementptr i8, ptr %35, i64 %39
  %42 = mul nuw nsw i64 %38, 720
  %43 = getelementptr i8, ptr %3, i64 %42
  %44 = getelementptr i8, ptr %36, i64 %42
  %45 = icmp ult ptr %3, %41
  %46 = icmp ult ptr %40, %34
  %47 = and i1 %45, %46
  %48 = icmp ult ptr %3, %44
  %49 = icmp ult ptr %43, %34
  %50 = and i1 %48, %49
  %51 = or i1 %47, %50
  %52 = getelementptr inbounds nuw [180 x i32], ptr %3, i64 %38, i64 176
  br label %53

53:                                               ; preds = %108, %37
  %54 = phi i64 [ 0, %37 ], [ %109, %108 ]
  %55 = getelementptr inbounds nuw [180 x i32], ptr %3, i64 %54, i64 %38
  br i1 %51, label %.preheader, label %56

.preheader:                                       ; preds = %53
  br label %97

56:                                               ; preds = %53
  %57 = load i32, ptr %55, align 4, !tbaa !6, !alias.scope !15
  %58 = insertelement <4 x i32> poison, i32 %57, i64 0
  %59 = shufflevector <4 x i32> %58, <4 x i32> poison, <4 x i32> zeroinitializer
  br label %60

60:                                               ; preds = %60, %56
  %61 = phi i64 [ %86, %60 ], [ 0, %56 ]
  %62 = getelementptr inbounds nuw [180 x i32], ptr %3, i64 %54, i64 %61
  %63 = getelementptr inbounds nuw i8, ptr %62, i64 16
  %64 = getelementptr inbounds nuw i8, ptr %62, i64 32
  %65 = getelementptr inbounds nuw i8, ptr %62, i64 48
  %66 = load <4 x i32>, ptr %62, align 4, !tbaa !6, !alias.scope !18, !noalias !20
  %67 = load <4 x i32>, ptr %63, align 4, !tbaa !6, !alias.scope !18, !noalias !20
  %68 = load <4 x i32>, ptr %64, align 4, !tbaa !6, !alias.scope !18, !noalias !20
  %69 = load <4 x i32>, ptr %65, align 4, !tbaa !6, !alias.scope !18, !noalias !20
  %70 = getelementptr inbounds nuw [180 x i32], ptr %3, i64 %38, i64 %61
  %71 = getelementptr inbounds nuw i8, ptr %70, i64 16
  %72 = getelementptr inbounds nuw i8, ptr %70, i64 32
  %73 = getelementptr inbounds nuw i8, ptr %70, i64 48
  %74 = load <4 x i32>, ptr %70, align 4, !tbaa !6, !alias.scope !22
  %75 = load <4 x i32>, ptr %71, align 4, !tbaa !6, !alias.scope !22
  %76 = load <4 x i32>, ptr %72, align 4, !tbaa !6, !alias.scope !22
  %77 = load <4 x i32>, ptr %73, align 4, !tbaa !6, !alias.scope !22
  %78 = add nsw <4 x i32> %74, %59
  %79 = add nsw <4 x i32> %75, %59
  %80 = add nsw <4 x i32> %76, %59
  %81 = add nsw <4 x i32> %77, %59
  %82 = tail call <4 x i32> @llvm.smin.v4i32(<4 x i32> %66, <4 x i32> %78)
  %83 = tail call <4 x i32> @llvm.smin.v4i32(<4 x i32> %67, <4 x i32> %79)
  %84 = tail call <4 x i32> @llvm.smin.v4i32(<4 x i32> %68, <4 x i32> %80)
  %85 = tail call <4 x i32> @llvm.smin.v4i32(<4 x i32> %69, <4 x i32> %81)
  store <4 x i32> %82, ptr %62, align 4, !tbaa !6, !alias.scope !18, !noalias !20
  store <4 x i32> %83, ptr %63, align 4, !tbaa !6, !alias.scope !18, !noalias !20
  store <4 x i32> %84, ptr %64, align 4, !tbaa !6, !alias.scope !18, !noalias !20
  store <4 x i32> %85, ptr %65, align 4, !tbaa !6, !alias.scope !18, !noalias !20
  %86 = add nuw i64 %61, 16
  %87 = icmp eq i64 %86, 176
  br i1 %87, label %88, label %60, !llvm.loop !23

88:                                               ; preds = %60
  %89 = getelementptr inbounds nuw [180 x i32], ptr %3, i64 %54, i64 176
  %90 = load <4 x i32>, ptr %89, align 4, !tbaa !6, !alias.scope !18, !noalias !20
  %91 = load i32, ptr %55, align 4, !tbaa !6, !alias.scope !15
  %92 = insertelement <4 x i32> poison, i32 %91, i64 0
  %93 = shufflevector <4 x i32> %92, <4 x i32> poison, <4 x i32> zeroinitializer
  %94 = load <4 x i32>, ptr %52, align 4, !tbaa !6, !alias.scope !22
  %95 = add nsw <4 x i32> %94, %93
  %96 = tail call <4 x i32> @llvm.smin.v4i32(<4 x i32> %90, <4 x i32> %95)
  store <4 x i32> %96, ptr %89, align 4, !tbaa !6, !alias.scope !18, !noalias !20
  br label %108

97:                                               ; preds = %.preheader, %97
  %98 = phi i64 [ %106, %97 ], [ 0, %.preheader ]
  %99 = getelementptr inbounds nuw [180 x i32], ptr %3, i64 %54, i64 %98
  %100 = load i32, ptr %99, align 4, !tbaa !6
  %101 = load i32, ptr %55, align 4, !tbaa !6
  %102 = getelementptr inbounds nuw [180 x i32], ptr %3, i64 %38, i64 %98
  %103 = load i32, ptr %102, align 4, !tbaa !6
  %104 = add nsw i32 %103, %101
  %105 = tail call i32 @llvm.smin.i32(i32 %100, i32 %104)
  store i32 %105, ptr %99, align 4, !tbaa !6
  %106 = add nuw nsw i64 %98, 1
  %107 = icmp eq i64 %106, 180
  br i1 %107, label %.loopexit, label %97, !llvm.loop !24

.loopexit:                                        ; preds = %97
  br label %108

108:                                              ; preds = %.loopexit, %88
  %109 = add nuw nsw i64 %54, 1
  %110 = icmp eq i64 %109, 180
  br i1 %110, label %111, label %53, !llvm.loop !25

111:                                              ; preds = %108
  %112 = add nuw nsw i64 %38, 1
  %113 = icmp eq i64 %112, 180
  br i1 %113, label %114, label %37, !llvm.loop !26

114:                                              ; preds = %111
  tail call void @polybench_timer_stop() #6
  tail call void @polybench_timer_print() #6
  %115 = icmp sgt i32 %0, 42
  br i1 %115, label %116, label %152

116:                                              ; preds = %114
  %117 = load ptr, ptr %1, align 8, !tbaa !27
  %118 = load i8, ptr %117, align 1
  %119 = icmp eq i8 %118, 0
  br i1 %119, label %120, label %152

120:                                              ; preds = %116
  %121 = load ptr, ptr @__stderrp, align 8, !tbaa !30
  %122 = tail call i64 @fwrite(ptr nonnull @.str.1, i64 22, i64 1, ptr %121)
  %123 = load ptr, ptr @__stderrp, align 8, !tbaa !30
  %124 = tail call i32 (ptr, ptr, ...) @fprintf(ptr noundef %123, ptr noundef nonnull @.str.2, ptr noundef nonnull @.str.3) #6
  br label %125

125:                                              ; preds = %144, %120
  %126 = phi i64 [ 0, %120 ], [ %145, %144 ]
  %127 = mul nuw nsw i64 %126, 180
  br label %128

128:                                              ; preds = %137, %125
  %129 = phi i64 [ 0, %125 ], [ %142, %137 ]
  %130 = add nuw nsw i64 %129, %127
  %131 = trunc nuw nsw i64 %130 to i32
  %132 = urem i32 %131, 20
  %133 = icmp eq i32 %132, 0
  br i1 %133, label %134, label %137

134:                                              ; preds = %128
  %135 = load ptr, ptr @__stderrp, align 8, !tbaa !30
  %136 = tail call i32 @fputc(i32 10, ptr %135)
  br label %137

137:                                              ; preds = %134, %128
  %138 = load ptr, ptr @__stderrp, align 8, !tbaa !30
  %139 = getelementptr inbounds nuw [180 x i32], ptr %3, i64 %126, i64 %129
  %140 = load i32, ptr %139, align 4, !tbaa !6
  %141 = tail call i32 (ptr, ptr, ...) @fprintf(ptr noundef %138, ptr noundef nonnull @.str.5, i32 noundef %140) #6
  %142 = add nuw nsw i64 %129, 1
  %143 = icmp eq i64 %142, 180
  br i1 %143, label %144, label %128, !llvm.loop !32

144:                                              ; preds = %137
  %145 = add nuw nsw i64 %126, 1
  %146 = icmp eq i64 %145, 180
  br i1 %146, label %147, label %125, !llvm.loop !33

147:                                              ; preds = %144
  %148 = load ptr, ptr @__stderrp, align 8, !tbaa !30
  %149 = tail call i32 (ptr, ptr, ...) @fprintf(ptr noundef %148, ptr noundef nonnull @.str.6, ptr noundef nonnull @.str.3) #6
  %150 = load ptr, ptr @__stderrp, align 8, !tbaa !30
  %151 = tail call i64 @fwrite(ptr nonnull @.str.7, i64 22, i64 1, ptr %150)
  br label %152

152:                                              ; preds = %147, %116, %114
  tail call void @free(ptr noundef nonnull %3)
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

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.smin.i32(i32, i32) #5

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare <4 x i32> @llvm.smin.v4i32(<4 x i32>, <4 x i32>) #5

attributes #0 = { nounwind ssp uwtable(sync) "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+ccpp,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a" }
attributes #1 = { "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+ccpp,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a" }
attributes #2 = { mustprogress nounwind willreturn allockind("free") memory(argmem: readwrite, inaccessiblemem: readwrite) "alloc-family"="malloc" "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+ccpp,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a" }
attributes #3 = { nofree nounwind "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+ccpp,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a" }
attributes #4 = { nofree nounwind }
attributes #5 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
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
!7 = !{!"int", !8, i64 0}
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
!20 = !{!16, !21}
!21 = distinct !{!21, !17}
!22 = !{!21}
!23 = distinct !{!23, !11, !12, !13}
!24 = distinct !{!24, !11, !12}
!25 = distinct !{!25, !11}
!26 = distinct !{!26, !11}
!27 = !{!28, !28, i64 0}
!28 = !{!"p1 omnipotent char", !29, i64 0}
!29 = !{!"any pointer", !8, i64 0}
!30 = !{!31, !31, i64 0}
!31 = !{!"p1 _ZTS7__sFILE", !29, i64 0}
!32 = distinct !{!32, !11}
!33 = distinct !{!33, !11}
