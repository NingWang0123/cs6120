; ModuleID = 'tests/test_simple.c'
source_filename = "tests/test_simple.c"
target datalayout = "e-m:o-i64:64-i128:128-n32:64-S128"
target triple = "arm64-apple-macosx15.0.0"

@.str = private unnamed_addr constant [18 x i8] c"Time: %f seconds\0A\00", align 1
@.str.1 = private unnamed_addr constant [29 x i8] c"Error at index %d: %d != %d\0A\00", align 1
@str = private unnamed_addr constant [21 x i8] c"Verification passed!\00", align 1

; Function Attrs: nofree norecurse nosync nounwind ssp memory(argmem: readwrite) uwtable(sync)
define void @array_add(ptr nocapture noundef readonly %0, ptr nocapture noundef readonly %1, ptr nocapture noundef writeonly %2, i32 noundef %3) local_unnamed_addr #0 {
  %5 = icmp sgt i32 %3, 0
  br i1 %5, label %6, label %8

6:                                                ; preds = %4
  %7 = zext i32 %3 to i64
  br label %9

8:                                                ; preds = %9, %4
  ret void

9:                                                ; preds = %6, %9
  %10 = phi i64 [ 0, %6 ], [ %17, %9 ]
  %11 = getelementptr inbounds i32, ptr %0, i64 %10
  %12 = load i32, ptr %11, align 4, !tbaa !6
  %13 = getelementptr inbounds i32, ptr %1, i64 %10
  %14 = load i32, ptr %13, align 4, !tbaa !6
  %15 = add nsw i32 %14, %12
  %16 = getelementptr inbounds i32, ptr %2, i64 %10
  store i32 %15, ptr %16, align 4, !tbaa !6
  %17 = add nuw nsw i64 %10, 1
  %18 = icmp eq i64 %17, %7
  br i1 %18, label %8, label %9, !llvm.loop !10
}

; Function Attrs: nounwind ssp uwtable(sync)
define i32 @main() local_unnamed_addr #1 {
  %1 = tail call dereferenceable_or_null(40000000) ptr @malloc(i64 noundef 40000000) #7
  %2 = tail call dereferenceable_or_null(40000000) ptr @malloc(i64 noundef 40000000) #7
  %3 = tail call dereferenceable_or_null(40000000) ptr @malloc(i64 noundef 40000000) #7
  br label %22

4:                                                ; preds = %22
  %5 = tail call i64 @"\01_clock"() #8
  br label %6

6:                                                ; preds = %6, %4
  %7 = phi i64 [ 0, %4 ], [ %14, %6 ]
  %8 = getelementptr inbounds i32, ptr %1, i64 %7
  %9 = load i32, ptr %8, align 4, !tbaa !6
  %10 = getelementptr inbounds i32, ptr %2, i64 %7
  %11 = load i32, ptr %10, align 4, !tbaa !6
  %12 = add nsw i32 %11, %9
  %13 = getelementptr inbounds i32, ptr %3, i64 %7
  store i32 %12, ptr %13, align 4, !tbaa !6
  %14 = add nuw nsw i64 %7, 1
  %15 = icmp eq i64 %14, 10000000
  br i1 %15, label %16, label %6, !llvm.loop !10

16:                                               ; preds = %6
  %17 = tail call i64 @"\01_clock"() #8
  %18 = sub i64 %17, %5
  %19 = uitofp i64 %18 to double
  %20 = fdiv double %19, 1.000000e+06
  %21 = tail call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str, double noundef %20)
  br label %32

22:                                               ; preds = %0, %22
  %23 = phi i64 [ 0, %0 ], [ %28, %22 ]
  %24 = getelementptr inbounds i32, ptr %1, i64 %23
  %25 = trunc i64 %23 to i32
  store i32 %25, ptr %24, align 4, !tbaa !6
  %26 = getelementptr inbounds i32, ptr %2, i64 %23
  %27 = shl i32 %25, 1
  store i32 %27, ptr %26, align 4, !tbaa !6
  %28 = add nuw nsw i64 %23, 1
  %29 = icmp eq i64 %28, 10000000
  br i1 %29, label %4, label %22, !llvm.loop !13

30:                                               ; preds = %47
  %31 = icmp eq i32 %48, 0
  br i1 %31, label %53, label %55

32:                                               ; preds = %16, %47
  %33 = phi i64 [ 0, %16 ], [ %49, %47 ]
  %34 = phi i32 [ 0, %16 ], [ %48, %47 ]
  %35 = getelementptr inbounds i32, ptr %3, i64 %33
  %36 = load i32, ptr %35, align 4, !tbaa !6
  %37 = getelementptr inbounds i32, ptr %1, i64 %33
  %38 = load i32, ptr %37, align 4, !tbaa !6
  %39 = getelementptr inbounds i32, ptr %2, i64 %33
  %40 = load i32, ptr %39, align 4, !tbaa !6
  %41 = add nsw i32 %40, %38
  %42 = icmp eq i32 %36, %41
  br i1 %42, label %47, label %43

43:                                               ; preds = %32
  %44 = trunc i64 %33 to i32
  %45 = tail call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str.1, i32 noundef %44, i32 noundef %36, i32 noundef %41)
  %46 = add nsw i32 %34, 1
  br label %47

47:                                               ; preds = %32, %43
  %48 = phi i32 [ %46, %43 ], [ %34, %32 ]
  %49 = add nuw nsw i64 %33, 1
  %50 = icmp ult i64 %33, 9999999
  %51 = icmp slt i32 %48, 10
  %52 = select i1 %50, i1 %51, i1 false
  br i1 %52, label %32, label %30, !llvm.loop !14

53:                                               ; preds = %30
  %54 = tail call i32 @puts(ptr nonnull dereferenceable(1) @str)
  br label %55

55:                                               ; preds = %53, %30
  tail call void @free(ptr noundef %1)
  tail call void @free(ptr noundef %2)
  tail call void @free(ptr noundef %3)
  ret i32 0
}

; Function Attrs: mustprogress nofree nounwind willreturn allockind("alloc,uninitialized") allocsize(0) memory(inaccessiblemem: readwrite)
declare noalias noundef ptr @malloc(i64 noundef) local_unnamed_addr #2

declare i64 @"\01_clock"() local_unnamed_addr #3

; Function Attrs: nofree nounwind
declare noundef i32 @printf(ptr nocapture noundef readonly, ...) local_unnamed_addr #4

; Function Attrs: mustprogress nounwind willreturn allockind("free") memory(argmem: readwrite, inaccessiblemem: readwrite)
declare void @free(ptr allocptr nocapture noundef) local_unnamed_addr #5

; Function Attrs: nofree nounwind
declare noundef i32 @puts(ptr nocapture noundef readonly) local_unnamed_addr #6

attributes #0 = { nofree norecurse nosync nounwind ssp memory(argmem: readwrite) uwtable(sync) "frame-pointer"="non-leaf" "no-trapping-math"="true" "probe-stack"="__chkstk_darwin" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+crc,+dotprod,+fp-armv8,+fp16fml,+fullfp16,+lse,+neon,+ras,+rcpc,+rdm,+sha2,+sha3,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8.5a,+v8a,+zcm,+zcz" }
attributes #1 = { nounwind ssp uwtable(sync) "frame-pointer"="non-leaf" "no-trapping-math"="true" "probe-stack"="__chkstk_darwin" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+crc,+dotprod,+fp-armv8,+fp16fml,+fullfp16,+lse,+neon,+ras,+rcpc,+rdm,+sha2,+sha3,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8.5a,+v8a,+zcm,+zcz" }
attributes #2 = { mustprogress nofree nounwind willreturn allockind("alloc,uninitialized") allocsize(0) memory(inaccessiblemem: readwrite) "alloc-family"="malloc" "frame-pointer"="non-leaf" "no-trapping-math"="true" "probe-stack"="__chkstk_darwin" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+crc,+dotprod,+fp-armv8,+fp16fml,+fullfp16,+lse,+neon,+ras,+rcpc,+rdm,+sha2,+sha3,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8.5a,+v8a,+zcm,+zcz" }
attributes #3 = { "frame-pointer"="non-leaf" "no-trapping-math"="true" "probe-stack"="__chkstk_darwin" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+crc,+dotprod,+fp-armv8,+fp16fml,+fullfp16,+lse,+neon,+ras,+rcpc,+rdm,+sha2,+sha3,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8.5a,+v8a,+zcm,+zcz" }
attributes #4 = { nofree nounwind "frame-pointer"="non-leaf" "no-trapping-math"="true" "probe-stack"="__chkstk_darwin" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+crc,+dotprod,+fp-armv8,+fp16fml,+fullfp16,+lse,+neon,+ras,+rcpc,+rdm,+sha2,+sha3,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8.5a,+v8a,+zcm,+zcz" }
attributes #5 = { mustprogress nounwind willreturn allockind("free") memory(argmem: readwrite, inaccessiblemem: readwrite) "alloc-family"="malloc" "frame-pointer"="non-leaf" "no-trapping-math"="true" "probe-stack"="__chkstk_darwin" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+crc,+dotprod,+fp-armv8,+fp16fml,+fullfp16,+lse,+neon,+ras,+rcpc,+rdm,+sha2,+sha3,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8.5a,+v8a,+zcm,+zcz" }
attributes #6 = { nofree nounwind }
attributes #7 = { allocsize(0) }
attributes #8 = { nounwind }

!llvm.module.flags = !{!0, !1, !2, !3, !4}
!llvm.ident = !{!5}

!0 = !{i32 2, !"SDK Version", [2 x i32] [i32 15, i32 2]}
!1 = !{i32 1, !"wchar_size", i32 4}
!2 = !{i32 8, !"PIC Level", i32 2}
!3 = !{i32 7, !"uwtable", i32 1}
!4 = !{i32 7, !"frame-pointer", i32 1}
!5 = !{!"Apple clang version 16.0.0 (clang-1600.0.26.6)"}
!6 = !{!7, !7, i64 0}
!7 = !{!"int", !8, i64 0}
!8 = !{!"omnipotent char", !9, i64 0}
!9 = !{!"Simple C/C++ TBAA"}
!10 = distinct !{!10, !11, !12}
!11 = !{!"llvm.loop.mustprogress"}
!12 = !{!"llvm.loop.unroll.disable"}
!13 = distinct !{!13, !11, !12}
!14 = distinct !{!14, !11, !12}
