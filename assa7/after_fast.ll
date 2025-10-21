; ModuleID = 'before_fast.ll'
source_filename = "test.c"
target datalayout = "e-m:o-i64:64-i128:128-n32:64-S128"
target triple = "arm64-apple-macosx15.0.0"

@.str = private unnamed_addr constant [33 x i8] c"r1=%.6f r2=%.6f r3=%.6f r4=%.6f\0A\00", align 1, !dbg !0

; Function Attrs: nofree norecurse nosync nounwind ssp memory(argmem: read) uwtable(sync)
define nofpclass(nan inf) float @loop_div_sum(ptr noundef readonly captures(none) %0, i32 noundef %1, float noundef nofpclass(nan inf) %2) local_unnamed_addr #0 !dbg !19 {
    #dbg_value(ptr %0, !26, !DIExpression(), !35)
    #dbg_value(i32 %1, !27, !DIExpression(), !35)
    #dbg_value(float %2, !28, !DIExpression(), !35)
    #dbg_value(float 0.000000e+00, !29, !DIExpression(), !35)
    #dbg_value(i32 0, !30, !DIExpression(), !36)
    #dbg_value(float 0.000000e+00, !29, !DIExpression(), !35)
    #dbg_value(i32 0, !30, !DIExpression(), !36)
  %4 = icmp sgt i32 %1, 0, !dbg !37
  br i1 %4, label %5, label %7, !dbg !38

5:                                                ; preds = %3
  %6 = zext i32 %1 to i64, !dbg !37
  %rcp = fdiv fast float 1.000000e+00, %2
  %div.mul = fmul fast float 1.000000e+00, %rcp
  %div.mul1 = fmul fast float 1.000000e+00, %rcp
  br label %9, !dbg !38

7:                                                ; preds = %9, %3
  %8 = phi float [ 0.000000e+00, %3 ], [ %22, %9 ], !dbg !35
  ret float %8, !dbg !39

9:                                                ; preds = %9, %5
  %10 = phi i64 [ 0, %5 ], [ %23, %9 ]
  %11 = phi float [ 0.000000e+00, %5 ], [ %22, %9 ]
    #dbg_value(float %11, !29, !DIExpression(), !35)
    #dbg_value(i64 %10, !30, !DIExpression(), !36)
  %12 = getelementptr inbounds float, ptr %0, i64 %10, !dbg !40
  %13 = load float, ptr %12, align 4, !dbg !40, !tbaa !41
  %14 = trunc i64 %10 to i32, !dbg !45
  %15 = sitofp i32 %14 to float, !dbg !45
  %16 = fmul fast float %15, 5.000000e-01, !dbg !46
  %17 = fadd fast float %13, %16, !dbg !47
    #dbg_value(float %17, !32, !DIExpression(), !48)
  %18 = fmul fast float %17, %div.mul
  %19 = fadd fast float %18, %11, !dbg !49
    #dbg_value(float %19, !29, !DIExpression(), !35)
  %20 = fadd fast float %17, 1.000000e+00, !dbg !50
  %21 = fmul fast float %20, %div.mul1
  %22 = fadd fast float %19, %21, !dbg !51
    #dbg_value(float %22, !29, !DIExpression(), !35)
  %23 = add nuw nsw i64 %10, 1, !dbg !52
    #dbg_value(i64 %23, !30, !DIExpression(), !36)
  %24 = icmp eq i64 %23, %6, !dbg !37
  br i1 %24, label %7, label %9, !dbg !38, !llvm.loop !53
}

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.start.p0(i64 immarg, ptr captures(none)) #1

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.end.p0(i64 immarg, ptr captures(none)) #1

; Function Attrs: mustprogress nofree norecurse nosync nounwind ssp willreturn memory(none) uwtable(sync)
define nofpclass(nan inf) float @branchy(float noundef nofpclass(nan inf) %0, float noundef nofpclass(nan inf) %1, float noundef nofpclass(nan inf) %2) local_unnamed_addr #2 !dbg !57 {
    #dbg_value(float %0, !61, !DIExpression(), !73)
    #dbg_value(float %1, !62, !DIExpression(), !73)
    #dbg_value(float %2, !63, !DIExpression(), !73)
    #dbg_value(float poison, !64, !DIExpression(), !73)
    #dbg_value(float 0.000000e+00, !65, !DIExpression(), !73)
  %4 = fcmp fast ogt float %0, %1, !dbg !74
  %5 = fadd fast float %1, %0, !dbg !75
  %6 = select i1 %4, float %5, float -0.000000e+00, !dbg !75
  %7 = fadd fast float %6, %0, !dbg !75
  %8 = fadd fast float %2, 2.500000e-01, !dbg !76
    #dbg_value(float %8, !64, !DIExpression(), !73)
  %rcp = fdiv fast float 1.000000e+00, %8, !dbg !77
  %div.mul = fmul fast float %7, %rcp, !dbg !77
    #dbg_value(float %div.mul, !65, !DIExpression(), !73)
  ret float %div.mul, !dbg !78
}

; Function Attrs: nofree nounwind ssp uwtable(sync)
define i32 @main() local_unnamed_addr #3 !dbg !79 {
  %1 = alloca [8 x float], align 4
    #dbg_value(float 1.000000e+01, !83, !DIExpression(), !96)
    #dbg_value(float 2.000000e+00, !84, !DIExpression(), !96)
    #dbg_value(float 1.500000e+00, !85, !DIExpression(), !96)
  call void @llvm.lifetime.start.p0(i64 32, ptr nonnull %1) #5, !dbg !97
    #dbg_declare(ptr %1, !86, !DIExpression(), !98)
    #dbg_value(i32 0, !90, !DIExpression(), !99)
  br label %19, !dbg !100

2:                                                ; preds = %19, %2
  %3 = phi i64 [ %14, %2 ], [ 0, %19 ]
  %4 = phi float [ %13, %2 ], [ 0.000000e+00, %19 ]
    #dbg_value(float %4, !29, !DIExpression(), !101)
    #dbg_value(i64 %3, !30, !DIExpression(), !103)
  %5 = getelementptr inbounds float, ptr %1, i64 %3, !dbg !104
  %6 = load float, ptr %5, align 4, !dbg !104, !tbaa !41
  %7 = trunc i64 %3 to i32, !dbg !105
  %8 = sitofp i32 %7 to float, !dbg !105
  %9 = fmul fast float %8, 5.000000e-01, !dbg !106
  %10 = fadd fast float %9, %6, !dbg !107
    #dbg_value(float %10, !32, !DIExpression(), !108)
    #dbg_value(float poison, !29, !DIExpression(), !101)
  %11 = fmul fast float %10, 0x3FD99999A0000000
  %12 = fadd fast float %4, 0x3FC99999A0000000, !dbg !109
  %13 = fadd fast float %12, %11, !dbg !110
    #dbg_value(float %13, !29, !DIExpression(), !101)
  %14 = add nuw nsw i64 %3, 1, !dbg !111
    #dbg_value(i64 %14, !30, !DIExpression(), !103)
  %15 = icmp eq i64 %14, 8, !dbg !112
  br i1 %15, label %16, label %2, !dbg !113, !llvm.loop !114

16:                                               ; preds = %2
    #dbg_value(float %13, !94, !DIExpression(), !96)
    #dbg_value(float 0x4029249240000000, !95, !DIExpression(), !96)
  %17 = fpext float %13 to double, !dbg !116
  %18 = tail call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) @.str, double noundef nofpclass(nan inf) 0x402AEAAAA0000000, double noundef nofpclass(nan inf) 0x4035555560000000, double noundef nofpclass(nan inf) %17, double noundef nofpclass(nan inf) 0x4029249240000000), !dbg !117
  call void @llvm.lifetime.end.p0(i64 32, ptr nonnull %1) #5, !dbg !118
  ret i32 0, !dbg !119

19:                                               ; preds = %19, %0
  %20 = phi i64 [ 0, %0 ], [ %26, %19 ]
    #dbg_value(i64 %20, !90, !DIExpression(), !99)
  %21 = trunc i64 %20 to i32, !dbg !120
  %22 = sitofp i32 %21 to float, !dbg !120
  %23 = fmul fast float %22, 2.500000e-01, !dbg !122
  %24 = fadd fast float %23, 1.000000e+00, !dbg !123
  %25 = getelementptr inbounds [8 x float], ptr %1, i64 0, i64 %20, !dbg !124
  store float %24, ptr %25, align 4, !dbg !125, !tbaa !41
  %26 = add nuw nsw i64 %20, 1, !dbg !126
    #dbg_value(i64 %26, !90, !DIExpression(), !99)
  %27 = icmp eq i64 %26, 8, !dbg !127
  br i1 %27, label %2, label %19, !dbg !100, !llvm.loop !128
}

; Function Attrs: nofree nounwind
declare !dbg !130 noundef i32 @printf(ptr noundef readonly captures(none), ...) local_unnamed_addr #4

attributes #0 = { nofree norecurse nosync nounwind ssp memory(argmem: read) uwtable(sync) "approx-func-fp-math"="true" "frame-pointer"="non-leaf" "no-infs-fp-math"="true" "no-nans-fp-math"="true" "no-signed-zeros-fp-math"="true" "no-trapping-math"="true" "probe-stack"="__chkstk_darwin" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+crc,+dotprod,+fp-armv8,+fp16fml,+fullfp16,+lse,+neon,+ras,+rcpc,+rdm,+sha2,+sha3,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8.5a,+v8a,+zcm,+zcz" "unsafe-fp-math"="true" }
attributes #1 = { nocallback nofree nosync nounwind willreturn memory(argmem: readwrite) }
attributes #2 = { mustprogress nofree norecurse nosync nounwind ssp willreturn memory(none) uwtable(sync) "approx-func-fp-math"="true" "frame-pointer"="non-leaf" "no-infs-fp-math"="true" "no-nans-fp-math"="true" "no-signed-zeros-fp-math"="true" "no-trapping-math"="true" "probe-stack"="__chkstk_darwin" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+crc,+dotprod,+fp-armv8,+fp16fml,+fullfp16,+lse,+neon,+ras,+rcpc,+rdm,+sha2,+sha3,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8.5a,+v8a,+zcm,+zcz" "unsafe-fp-math"="true" }
attributes #3 = { nofree nounwind ssp uwtable(sync) "approx-func-fp-math"="true" "frame-pointer"="non-leaf" "no-infs-fp-math"="true" "no-nans-fp-math"="true" "no-signed-zeros-fp-math"="true" "no-trapping-math"="true" "probe-stack"="__chkstk_darwin" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+crc,+dotprod,+fp-armv8,+fp16fml,+fullfp16,+lse,+neon,+ras,+rcpc,+rdm,+sha2,+sha3,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8.5a,+v8a,+zcm,+zcz" "unsafe-fp-math"="true" }
attributes #4 = { nofree nounwind "approx-func-fp-math"="true" "frame-pointer"="non-leaf" "no-infs-fp-math"="true" "no-nans-fp-math"="true" "no-signed-zeros-fp-math"="true" "no-trapping-math"="true" "probe-stack"="__chkstk_darwin" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+crc,+dotprod,+fp-armv8,+fp16fml,+fullfp16,+lse,+neon,+ras,+rcpc,+rdm,+sha2,+sha3,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8.5a,+v8a,+zcm,+zcz" "unsafe-fp-math"="true" }
attributes #5 = { nounwind }

!llvm.module.flags = !{!7, !8, !9, !10, !11, !12, !13}
!llvm.dbg.cu = !{!14}
!llvm.ident = !{!18}

!0 = !DIGlobalVariableExpression(var: !1, expr: !DIExpression())
!1 = distinct !DIGlobalVariable(scope: null, file: !2, line: 62, type: !3, isLocal: true, isDefinition: true)
!2 = !DIFile(filename: "test.c", directory: "/Users/jl4492/Projects/cs6120/cs6120-group-work/assa7", checksumkind: CSK_MD5, checksum: "2b73dc0551246f33b78b865059e2944f")
!3 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 264, elements: !5)
!4 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!5 = !{!6}
!6 = !DISubrange(count: 33)
!7 = !{i32 2, !"SDK Version", [2 x i32] [i32 15, i32 2]}
!8 = !{i32 7, !"Dwarf Version", i32 5}
!9 = !{i32 2, !"Debug Info Version", i32 3}
!10 = !{i32 1, !"wchar_size", i32 4}
!11 = !{i32 8, !"PIC Level", i32 2}
!12 = !{i32 7, !"uwtable", i32 1}
!13 = !{i32 7, !"frame-pointer", i32 1}
!14 = distinct !DICompileUnit(language: DW_LANG_C11, file: !2, producer: "Apple clang version 16.0.0 (clang-1600.0.26.6)", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, retainedTypes: !15, globals: !17, splitDebugInlining: false, nameTableKind: Apple, sysroot: "/Library/Developer/CommandLineTools/SDKs/MacOSX.sdk", sdk: "MacOSX.sdk")
!15 = !{!16}
!16 = !DIBasicType(name: "float", size: 32, encoding: DW_ATE_float)
!17 = !{!0}
!18 = !{!"Apple clang version 16.0.0 (clang-1600.0.26.6)"}
!19 = distinct !DISubprogram(name: "loop_div_sum", scope: !2, file: !2, line: 26, type: !20, scopeLine: 26, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !14, retainedNodes: !25)
!20 = !DISubroutineType(types: !21)
!21 = !{!16, !22, !24, !16}
!22 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !23, size: 64)
!23 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !16)
!24 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!25 = !{!26, !27, !28, !29, !30, !32}
!26 = !DILocalVariable(name: "arr", arg: 1, scope: !19, file: !2, line: 26, type: !22)
!27 = !DILocalVariable(name: "n", arg: 2, scope: !19, file: !2, line: 26, type: !24)
!28 = !DILocalVariable(name: "den", arg: 3, scope: !19, file: !2, line: 26, type: !16)
!29 = !DILocalVariable(name: "acc", scope: !19, file: !2, line: 27, type: !16)
!30 = !DILocalVariable(name: "i", scope: !31, file: !2, line: 28, type: !24)
!31 = distinct !DILexicalBlock(scope: !19, file: !2, line: 28, column: 5)
!32 = !DILocalVariable(name: "num", scope: !33, file: !2, line: 29, type: !16)
!33 = distinct !DILexicalBlock(scope: !34, file: !2, line: 28, column: 33)
!34 = distinct !DILexicalBlock(scope: !31, file: !2, line: 28, column: 5)
!35 = !DILocation(line: 0, scope: !19)
!36 = !DILocation(line: 0, scope: !31)
!37 = !DILocation(line: 28, column: 23, scope: !34)
!38 = !DILocation(line: 28, column: 5, scope: !31)
!39 = !DILocation(line: 33, column: 5, scope: !19)
!40 = !DILocation(line: 29, column: 21, scope: !33)
!41 = !{!42, !42, i64 0}
!42 = !{!"float", !43, i64 0}
!43 = !{!"omnipotent char", !44, i64 0}
!44 = !{!"Simple C/C++ TBAA"}
!45 = !DILocation(line: 29, column: 30, scope: !33)
!46 = !DILocation(line: 29, column: 39, scope: !33)
!47 = !DILocation(line: 29, column: 28, scope: !33)
!48 = !DILocation(line: 0, scope: !33)
!49 = !DILocation(line: 30, column: 13, scope: !33)
!50 = !DILocation(line: 31, column: 21, scope: !33)
!51 = !DILocation(line: 31, column: 13, scope: !33)
!52 = !DILocation(line: 28, column: 29, scope: !34)
!53 = distinct !{!53, !38, !54, !55, !56}
!54 = !DILocation(line: 32, column: 5, scope: !31)
!55 = !{!"llvm.loop.mustprogress"}
!56 = !{!"llvm.loop.unroll.disable"}
!57 = distinct !DISubprogram(name: "branchy", scope: !2, file: !2, line: 37, type: !58, scopeLine: 37, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !14, retainedNodes: !60)
!58 = !DISubroutineType(types: !59)
!59 = !{!16, !16, !16, !16}
!60 = !{!61, !62, !63, !64, !65, !66, !69, !70, !72}
!61 = !DILocalVariable(name: "a", arg: 1, scope: !57, file: !2, line: 37, type: !16)
!62 = !DILocalVariable(name: "b", arg: 2, scope: !57, file: !2, line: 37, type: !16)
!63 = !DILocalVariable(name: "c", arg: 3, scope: !57, file: !2, line: 37, type: !16)
!64 = !DILocalVariable(name: "den", scope: !57, file: !2, line: 38, type: !16)
!65 = !DILocalVariable(name: "r", scope: !57, file: !2, line: 39, type: !16)
!66 = !DILocalVariable(name: "t1", scope: !67, file: !2, line: 41, type: !16)
!67 = distinct !DILexicalBlock(scope: !68, file: !2, line: 40, column: 16)
!68 = distinct !DILexicalBlock(scope: !57, file: !2, line: 40, column: 9)
!69 = !DILocalVariable(name: "t2", scope: !67, file: !2, line: 42, type: !16)
!70 = !DILocalVariable(name: "t1", scope: !71, file: !2, line: 45, type: !16)
!71 = distinct !DILexicalBlock(scope: !68, file: !2, line: 44, column: 12)
!72 = !DILocalVariable(name: "t2", scope: !71, file: !2, line: 46, type: !16)
!73 = !DILocation(line: 0, scope: !57)
!74 = !DILocation(line: 40, column: 11, scope: !68)
!75 = !DILocation(line: 40, column: 9, scope: !57)
!76 = !DILocation(line: 38, column: 19, scope: !57)
!77 = !DILocation(line: 0, scope: !68)
!78 = !DILocation(line: 49, column: 5, scope: !57)
!79 = distinct !DISubprogram(name: "main", scope: !2, file: !2, line: 52, type: !80, scopeLine: 52, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !14, retainedNodes: !82)
!80 = !DISubroutineType(types: !81)
!81 = !{!24}
!82 = !{!83, !84, !85, !86, !90, !92, !93, !94, !95}
!83 = !DILocalVariable(name: "a", scope: !79, file: !2, line: 53, type: !16)
!84 = !DILocalVariable(name: "b", scope: !79, file: !2, line: 53, type: !16)
!85 = !DILocalVariable(name: "c", scope: !79, file: !2, line: 53, type: !16)
!86 = !DILocalVariable(name: "arr", scope: !79, file: !2, line: 54, type: !87)
!87 = !DICompositeType(tag: DW_TAG_array_type, baseType: !16, size: 256, elements: !88)
!88 = !{!89}
!89 = !DISubrange(count: 8)
!90 = !DILocalVariable(name: "i", scope: !91, file: !2, line: 55, type: !24)
!91 = distinct !DILexicalBlock(scope: !79, file: !2, line: 55, column: 5)
!92 = !DILocalVariable(name: "r1", scope: !79, file: !2, line: 57, type: !16)
!93 = !DILocalVariable(name: "r2", scope: !79, file: !2, line: 58, type: !16)
!94 = !DILocalVariable(name: "r3", scope: !79, file: !2, line: 59, type: !16)
!95 = !DILocalVariable(name: "r4", scope: !79, file: !2, line: 60, type: !16)
!96 = !DILocation(line: 0, scope: !79)
!97 = !DILocation(line: 54, column: 5, scope: !79)
!98 = !DILocation(line: 54, column: 11, scope: !79)
!99 = !DILocation(line: 0, scope: !91)
!100 = !DILocation(line: 55, column: 5, scope: !91)
!101 = !DILocation(line: 0, scope: !19, inlinedAt: !102)
!102 = distinct !DILocation(line: 59, column: 16, scope: !79)
!103 = !DILocation(line: 0, scope: !31, inlinedAt: !102)
!104 = !DILocation(line: 29, column: 21, scope: !33, inlinedAt: !102)
!105 = !DILocation(line: 29, column: 30, scope: !33, inlinedAt: !102)
!106 = !DILocation(line: 29, column: 39, scope: !33, inlinedAt: !102)
!107 = !DILocation(line: 29, column: 28, scope: !33, inlinedAt: !102)
!108 = !DILocation(line: 0, scope: !33, inlinedAt: !102)
!109 = !DILocation(line: 30, column: 13, scope: !33, inlinedAt: !102)
!110 = !DILocation(line: 31, column: 13, scope: !33, inlinedAt: !102)
!111 = !DILocation(line: 28, column: 29, scope: !34, inlinedAt: !102)
!112 = !DILocation(line: 28, column: 23, scope: !34, inlinedAt: !102)
!113 = !DILocation(line: 28, column: 5, scope: !31, inlinedAt: !102)
!114 = distinct !{!114, !113, !115, !55, !56}
!115 = !DILocation(line: 32, column: 5, scope: !31, inlinedAt: !102)
!116 = !DILocation(line: 62, column: 57, scope: !79)
!117 = !DILocation(line: 62, column: 5, scope: !79)
!118 = !DILocation(line: 64, column: 1, scope: !79)
!119 = !DILocation(line: 63, column: 5, scope: !79)
!120 = !DILocation(line: 55, column: 50, scope: !121)
!121 = distinct !DILexicalBlock(scope: !91, file: !2, line: 55, column: 5)
!122 = !DILocation(line: 55, column: 48, scope: !121)
!123 = !DILocation(line: 55, column: 52, scope: !121)
!124 = !DILocation(line: 55, column: 33, scope: !121)
!125 = !DILocation(line: 55, column: 40, scope: !121)
!126 = !DILocation(line: 55, column: 29, scope: !121)
!127 = !DILocation(line: 55, column: 23, scope: !121)
!128 = distinct !{!128, !100, !129, !55, !56}
!129 = !DILocation(line: 55, column: 54, scope: !91)
!130 = !DISubprogram(name: "printf", scope: !131, file: !131, line: 31, type: !132, flags: DIFlagPrototyped, spFlags: DISPFlagOptimized)
!131 = !DIFile(filename: "/Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/_printf.h", directory: "", checksumkind: CSK_MD5, checksum: "1dbdc20fec1369d4ad4aa87b19eddb1b")
!132 = !DISubroutineType(types: !133)
!133 = !{!24, !134, null}
!134 = !DIDerivedType(tag: DW_TAG_restrict_type, baseType: !135)
!135 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !136, size: 64)
!136 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !4)
