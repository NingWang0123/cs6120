; ModuleID = './polybench/medley/nussinov/nussinov.c'
source_filename = "./polybench/medley/nussinov/nussinov.c"
target datalayout = "e-m:o-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-n32:64-S128-Fn32"
target triple = "arm64-apple-macosx15.0.0"

@__stderrp = external local_unnamed_addr global ptr, align 8
@.str.1 = private unnamed_addr constant [23 x i8] c"==BEGIN DUMP_ARRAYS==\0A\00", align 1
@.str.2 = private unnamed_addr constant [15 x i8] c"begin dump: %s\00", align 1
@.str.3 = private unnamed_addr constant [6 x i8] c"table\00", align 1
@.str.5 = private unnamed_addr constant [4 x i8] c"%d \00", align 1
@.str.6 = private unnamed_addr constant [17 x i8] c"\0Aend   dump: %s\0A\00", align 1
@.str.7 = private unnamed_addr constant [23 x i8] c"==END   DUMP_ARRAYS==\0A\00", align 1

; Function Attrs: nounwind ssp uwtable(sync)
define noundef i32 @main(i32 noundef %0, ptr noundef readonly captures(none) %1) local_unnamed_addr #0 {
  %3 = tail call ptr @polybench_alloc_data(i64 noundef 180, i32 noundef 1) #7
  %4 = tail call ptr @polybench_alloc_data(i64 noundef 32400, i32 noundef 4) #7
  %5 = getelementptr inbounds nuw i8, ptr %3, i64 16
  store <16 x i8> <i8 1, i8 2, i8 3, i8 0, i8 1, i8 2, i8 3, i8 0, i8 1, i8 2, i8 3, i8 0, i8 1, i8 2, i8 3, i8 0>, ptr %3, align 1, !tbaa !6
  store <16 x i8> <i8 1, i8 2, i8 3, i8 0, i8 1, i8 2, i8 3, i8 0, i8 1, i8 2, i8 3, i8 0, i8 1, i8 2, i8 3, i8 0>, ptr %5, align 1, !tbaa !6
  %6 = getelementptr inbounds nuw i8, ptr %3, i64 32
  %7 = getelementptr inbounds nuw i8, ptr %3, i64 48
  store <16 x i8> <i8 1, i8 2, i8 3, i8 0, i8 1, i8 2, i8 3, i8 0, i8 1, i8 2, i8 3, i8 0, i8 1, i8 2, i8 3, i8 0>, ptr %6, align 1, !tbaa !6
  store <16 x i8> <i8 1, i8 2, i8 3, i8 0, i8 1, i8 2, i8 3, i8 0, i8 1, i8 2, i8 3, i8 0, i8 1, i8 2, i8 3, i8 0>, ptr %7, align 1, !tbaa !6
  %8 = getelementptr inbounds nuw i8, ptr %3, i64 64
  %9 = getelementptr inbounds nuw i8, ptr %3, i64 80
  store <16 x i8> <i8 1, i8 2, i8 3, i8 0, i8 1, i8 2, i8 3, i8 0, i8 1, i8 2, i8 3, i8 0, i8 1, i8 2, i8 3, i8 0>, ptr %8, align 1, !tbaa !6
  store <16 x i8> <i8 1, i8 2, i8 3, i8 0, i8 1, i8 2, i8 3, i8 0, i8 1, i8 2, i8 3, i8 0, i8 1, i8 2, i8 3, i8 0>, ptr %9, align 1, !tbaa !6
  %10 = getelementptr inbounds nuw i8, ptr %3, i64 96
  %11 = getelementptr inbounds nuw i8, ptr %3, i64 112
  store <16 x i8> <i8 1, i8 2, i8 3, i8 0, i8 1, i8 2, i8 3, i8 0, i8 1, i8 2, i8 3, i8 0, i8 1, i8 2, i8 3, i8 0>, ptr %10, align 1, !tbaa !6
  store <16 x i8> <i8 1, i8 2, i8 3, i8 0, i8 1, i8 2, i8 3, i8 0, i8 1, i8 2, i8 3, i8 0, i8 1, i8 2, i8 3, i8 0>, ptr %11, align 1, !tbaa !6
  %12 = getelementptr inbounds nuw i8, ptr %3, i64 128
  %13 = getelementptr inbounds nuw i8, ptr %3, i64 144
  store <16 x i8> <i8 1, i8 2, i8 3, i8 0, i8 1, i8 2, i8 3, i8 0, i8 1, i8 2, i8 3, i8 0, i8 1, i8 2, i8 3, i8 0>, ptr %12, align 1, !tbaa !6
  store <16 x i8> <i8 1, i8 2, i8 3, i8 0, i8 1, i8 2, i8 3, i8 0, i8 1, i8 2, i8 3, i8 0, i8 1, i8 2, i8 3, i8 0>, ptr %13, align 1, !tbaa !6
  %14 = getelementptr inbounds nuw i8, ptr %3, i64 160
  store <16 x i8> <i8 1, i8 2, i8 3, i8 0, i8 1, i8 2, i8 3, i8 0, i8 1, i8 2, i8 3, i8 0, i8 1, i8 2, i8 3, i8 0>, ptr %14, align 1, !tbaa !6
  %15 = getelementptr inbounds nuw i8, ptr %3, i64 176
  store i8 1, ptr %15, align 1, !tbaa !6
  %16 = getelementptr inbounds nuw i8, ptr %3, i64 177
  store i8 2, ptr %16, align 1, !tbaa !6
  %17 = getelementptr inbounds nuw i8, ptr %3, i64 178
  store i8 3, ptr %17, align 1, !tbaa !6
  %18 = getelementptr inbounds nuw i8, ptr %3, i64 179
  store i8 0, ptr %18, align 1, !tbaa !6
  tail call void @llvm.memset.p0.i64(ptr noundef nonnull align 4 dereferenceable(129600) %4, i8 0, i64 129600, i1 false), !tbaa !9
  tail call void @polybench_timer_start() #7
  br label %19

19:                                               ; preds = %68, %2
  %20 = phi i64 [ 179, %2 ], [ %69, %68 ]
  %21 = phi i64 [ 180, %2 ], [ %71, %68 ]
  %22 = add nuw nsw i64 %20, 1
  %23 = icmp samesign ult i64 %20, 179
  br i1 %23, label %24, label %68

24:                                               ; preds = %19
  %25 = getelementptr inbounds nuw i8, ptr %3, i64 %20
  br label %26

26:                                               ; preds = %65, %24
  %27 = phi i64 [ %21, %24 ], [ %66, %65 ]
  %28 = add nsw i64 %27, -1
  %29 = getelementptr inbounds nuw [180 x i32], ptr %4, i64 %20, i64 %27
  %30 = load i32, ptr %29, align 4, !tbaa !9
  %31 = getelementptr inbounds nuw [180 x i32], ptr %4, i64 %20, i64 %28
  %32 = load i32, ptr %31, align 4, !tbaa !9
  %33 = tail call i32 @llvm.smax.i32(i32 %30, i32 %32)
  %34 = getelementptr inbounds nuw [180 x i32], ptr %4, i64 %22, i64 %27
  %35 = load i32, ptr %34, align 4, !tbaa !9
  %36 = tail call i32 @llvm.smax.i32(i32 %33, i32 %35)
  store i32 %36, ptr %29, align 4, !tbaa !9
  %37 = icmp samesign ult i64 %20, %28
  %38 = getelementptr inbounds nuw [180 x i32], ptr %4, i64 %22, i64 %28
  %39 = load i32, ptr %38, align 4, !tbaa !9
  br i1 %37, label %40, label %50

40:                                               ; preds = %26
  %41 = load i8, ptr %25, align 1, !tbaa !6
  %42 = sext i8 %41 to i32
  %43 = getelementptr inbounds nuw i8, ptr %3, i64 %27
  %44 = load i8, ptr %43, align 1, !tbaa !6
  %45 = sext i8 %44 to i32
  %46 = add nsw i32 %45, %42
  %47 = icmp eq i32 %46, 3
  %48 = zext i1 %47 to i32
  %49 = add nsw i32 %39, %48
  br label %50

50:                                               ; preds = %40, %26
  %51 = phi i32 [ %49, %40 ], [ %39, %26 ]
  %52 = tail call i32 @llvm.smax.i32(i32 %36, i32 %51)
  store i32 %52, ptr %29, align 4, !tbaa !9
  %53 = icmp samesign ult i64 %22, %27
  br i1 %53, label %54, label %65

54:                                               ; preds = %50, %54
  %55 = phi i64 [ %59, %54 ], [ %21, %50 ]
  %56 = phi i32 [ %63, %54 ], [ %52, %50 ]
  %57 = getelementptr inbounds nuw [180 x i32], ptr %4, i64 %20, i64 %55
  %58 = load i32, ptr %57, align 4, !tbaa !9
  %59 = add nuw nsw i64 %55, 1
  %60 = getelementptr inbounds nuw [180 x i32], ptr %4, i64 %59, i64 %27
  %61 = load i32, ptr %60, align 4, !tbaa !9
  %62 = add nsw i32 %61, %58
  %63 = tail call i32 @llvm.smax.i32(i32 %56, i32 %62)
  store i32 %63, ptr %29, align 4, !tbaa !9
  %64 = icmp eq i64 %59, %27
  br i1 %64, label %65, label %54, !llvm.loop !11

65:                                               ; preds = %54, %50
  %66 = add nuw nsw i64 %27, 1
  %67 = icmp eq i64 %66, 180
  br i1 %67, label %68, label %26, !llvm.loop !13

68:                                               ; preds = %65, %19
  %69 = add nsw i64 %20, -1
  %70 = icmp eq i64 %20, 0
  %71 = add nsw i64 %21, -1
  br i1 %70, label %72, label %19, !llvm.loop !14

72:                                               ; preds = %68
  tail call void @polybench_timer_stop() #7
  tail call void @polybench_timer_print() #7
  %73 = icmp sgt i32 %0, 42
  br i1 %73, label %74, label %113

74:                                               ; preds = %72
  %75 = load ptr, ptr %1, align 8, !tbaa !15
  %76 = load i8, ptr %75, align 1
  %77 = icmp eq i8 %76, 0
  br i1 %77, label %78, label %113

78:                                               ; preds = %74
  %79 = load ptr, ptr @__stderrp, align 8, !tbaa !18
  %80 = tail call i64 @fwrite(ptr nonnull @.str.1, i64 22, i64 1, ptr %79)
  %81 = load ptr, ptr @__stderrp, align 8, !tbaa !18
  %82 = tail call i32 (ptr, ptr, ...) @fprintf(ptr noundef %81, ptr noundef nonnull @.str.2, ptr noundef nonnull @.str.3) #7
  br label %83

83:                                               ; preds = %103, %78
  %84 = phi i32 [ 180, %78 ], [ %106, %103 ]
  %85 = phi i64 [ 0, %78 ], [ %105, %103 ]
  %86 = phi i32 [ 0, %78 ], [ %104, %103 ]
  br label %87

87:                                               ; preds = %95, %83
  %88 = phi i64 [ %85, %83 ], [ %101, %95 ]
  %89 = phi i32 [ %86, %83 ], [ %100, %95 ]
  %90 = srem i32 %89, 20
  %91 = icmp eq i32 %90, 0
  br i1 %91, label %92, label %95

92:                                               ; preds = %87
  %93 = load ptr, ptr @__stderrp, align 8, !tbaa !18
  %94 = tail call i32 @fputc(i32 10, ptr %93)
  br label %95

95:                                               ; preds = %92, %87
  %96 = load ptr, ptr @__stderrp, align 8, !tbaa !18
  %97 = getelementptr inbounds nuw [180 x i32], ptr %4, i64 %85, i64 %88
  %98 = load i32, ptr %97, align 4, !tbaa !9
  %99 = tail call i32 (ptr, ptr, ...) @fprintf(ptr noundef %96, ptr noundef nonnull @.str.5, i32 noundef %98) #7
  %100 = add nsw i32 %89, 1
  %101 = add nuw nsw i64 %88, 1
  %102 = icmp eq i64 %101, 180
  br i1 %102, label %103, label %87, !llvm.loop !20

103:                                              ; preds = %95
  %104 = add i32 %86, %84
  %105 = add nuw nsw i64 %85, 1
  %106 = add nsw i32 %84, -1
  %107 = icmp eq i64 %105, 180
  br i1 %107, label %108, label %83, !llvm.loop !21

108:                                              ; preds = %103
  %109 = load ptr, ptr @__stderrp, align 8, !tbaa !18
  %110 = tail call i32 (ptr, ptr, ...) @fprintf(ptr noundef %109, ptr noundef nonnull @.str.6, ptr noundef nonnull @.str.3) #7
  %111 = load ptr, ptr @__stderrp, align 8, !tbaa !18
  %112 = tail call i64 @fwrite(ptr nonnull @.str.7, i64 22, i64 1, ptr %111)
  br label %113

113:                                              ; preds = %108, %74, %72
  tail call void @free(ptr noundef %3)
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

; Function Attrs: nocallback nofree nounwind willreturn memory(argmem: write)
declare void @llvm.memset.p0.i64(ptr writeonly captures(none), i8, i64, i1 immarg) #5

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.smax.i32(i32, i32) #6

attributes #0 = { nounwind ssp uwtable(sync) "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+ccpp,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a" }
attributes #1 = { "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+ccpp,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a" }
attributes #2 = { mustprogress nounwind willreturn allockind("free") memory(argmem: readwrite, inaccessiblemem: readwrite) "alloc-family"="malloc" "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+ccpp,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a" }
attributes #3 = { nofree nounwind "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+ccpp,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a" }
attributes #4 = { nofree nounwind }
attributes #5 = { nocallback nofree nounwind willreturn memory(argmem: write) }
attributes #6 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
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
!7 = !{!"omnipotent char", !8, i64 0}
!8 = !{!"Simple C/C++ TBAA"}
!9 = !{!10, !10, i64 0}
!10 = !{!"int", !7, i64 0}
!11 = distinct !{!11, !12}
!12 = !{!"llvm.loop.mustprogress"}
!13 = distinct !{!13, !12}
!14 = distinct !{!14, !12}
!15 = !{!16, !16, i64 0}
!16 = !{!"p1 omnipotent char", !17, i64 0}
!17 = !{!"any pointer", !7, i64 0}
!18 = !{!19, !19, i64 0}
!19 = !{!"p1 _ZTS7__sFILE", !17, i64 0}
!20 = distinct !{!20, !12}
!21 = distinct !{!21, !12}
