; ModuleID = 'before.ll'
source_filename = "test.c"
target datalayout = "e-m:o-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-n32:64-S128-Fn32"
target triple = "arm64-apple-macosx13.3.0"

@.str = private unnamed_addr constant [33 x i8] c"r1=%.6f r2=%.6f r3=%.6f r4=%.6f\0A\00", align 1, !dbg !0

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define float @loop_div_sum(ptr noundef %0, i32 noundef %1, float noundef %2) #0 !dbg !19 {
  %4 = alloca ptr, align 8
  %5 = alloca i32, align 4
  %6 = alloca float, align 4
  %7 = alloca float, align 4
  %8 = alloca i32, align 4
  %9 = alloca float, align 4
  store ptr %0, ptr %4, align 8
    #dbg_declare(ptr %4, !26, !DIExpression(), !27)
  store i32 %1, ptr %5, align 4
    #dbg_declare(ptr %5, !28, !DIExpression(), !29)
  store float %2, ptr %6, align 4
    #dbg_declare(ptr %6, !30, !DIExpression(), !31)
    #dbg_declare(ptr %7, !32, !DIExpression(), !33)
  store float 0.000000e+00, ptr %7, align 4, !dbg !33
    #dbg_declare(ptr %8, !34, !DIExpression(), !36)
  store i32 0, ptr %8, align 4, !dbg !36
  br label %10, !dbg !37

10:                                               ; preds = %34, %3
  %11 = load i32, ptr %8, align 4, !dbg !38
  %12 = load i32, ptr %5, align 4, !dbg !40
  %13 = icmp slt i32 %11, %12, !dbg !41
  br i1 %13, label %14, label %37, !dbg !42

14:                                               ; preds = %10
    #dbg_declare(ptr %9, !43, !DIExpression(), !45)
  %15 = load ptr, ptr %4, align 8, !dbg !46
  %16 = load i32, ptr %8, align 4, !dbg !47
  %17 = sext i32 %16 to i64, !dbg !46
  %18 = getelementptr inbounds float, ptr %15, i64 %17, !dbg !46
  %19 = load float, ptr %18, align 4, !dbg !46
  %20 = load i32, ptr %8, align 4, !dbg !48
  %21 = sitofp i32 %20 to float, !dbg !49
  %22 = call float @llvm.fmuladd.f32(float %21, float 5.000000e-01, float %19), !dbg !50
  store float %22, ptr %9, align 4, !dbg !45
  %23 = load float, ptr %9, align 4, !dbg !51
  %24 = load float, ptr %6, align 4, !dbg !52
  %25 = fdiv float %23, %24, !dbg !53
  %26 = load float, ptr %7, align 4, !dbg !54
  %27 = fadd float %26, %25, !dbg !54
  store float %27, ptr %7, align 4, !dbg !54
  %28 = load float, ptr %9, align 4, !dbg !55
  %29 = fadd float %28, 1.000000e+00, !dbg !56
  %30 = load float, ptr %6, align 4, !dbg !57
  %31 = fdiv float %29, %30, !dbg !58
  %32 = load float, ptr %7, align 4, !dbg !59
  %33 = fadd float %32, %31, !dbg !59
  store float %33, ptr %7, align 4, !dbg !59
  br label %34, !dbg !60

34:                                               ; preds = %14
  %35 = load i32, ptr %8, align 4, !dbg !61
  %36 = add nsw i32 %35, 1, !dbg !61
  store i32 %36, ptr %8, align 4, !dbg !61
  br label %10, !dbg !62, !llvm.loop !63

37:                                               ; preds = %10
  %38 = load float, ptr %7, align 4, !dbg !66
  ret float %38, !dbg !67
}

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare float @llvm.fmuladd.f32(float, float, float) #1

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define float @branchy(float noundef %0, float noundef %1, float noundef %2) #0 !dbg !68 {
  %4 = alloca float, align 4
  %5 = alloca float, align 4
  %6 = alloca float, align 4
  %7 = alloca float, align 4
  %8 = alloca float, align 4
  %9 = alloca float, align 4
  %10 = alloca float, align 4
  %11 = alloca float, align 4
  %12 = alloca float, align 4
  store float %0, ptr %4, align 4
    #dbg_declare(ptr %4, !71, !DIExpression(), !72)
  store float %1, ptr %5, align 4
    #dbg_declare(ptr %5, !73, !DIExpression(), !74)
  store float %2, ptr %6, align 4
    #dbg_declare(ptr %6, !75, !DIExpression(), !76)
    #dbg_declare(ptr %7, !77, !DIExpression(), !78)
  %13 = load float, ptr %6, align 4, !dbg !79
  %14 = fadd float %13, 2.500000e-01, !dbg !80
  store float %14, ptr %7, align 4, !dbg !78
    #dbg_declare(ptr %8, !81, !DIExpression(), !82)
  store float 0.000000e+00, ptr %8, align 4, !dbg !82
  %15 = load float, ptr %4, align 4, !dbg !83
  %16 = load float, ptr %5, align 4, !dbg !85
  %17 = fcmp ogt float %15, %16, !dbg !86
  br i1 %17, label %18, label %30, !dbg !86

18:                                               ; preds = %3
    #dbg_declare(ptr %9, !87, !DIExpression(), !89)
  %19 = load float, ptr %4, align 4, !dbg !90
  %20 = load float, ptr %7, align 4, !dbg !91
  %21 = fdiv float %19, %20, !dbg !92
  store float %21, ptr %9, align 4, !dbg !89
    #dbg_declare(ptr %10, !93, !DIExpression(), !94)
  %22 = load float, ptr %4, align 4, !dbg !95
  %23 = load float, ptr %5, align 4, !dbg !96
  %24 = fadd float %22, %23, !dbg !97
  %25 = load float, ptr %7, align 4, !dbg !98
  %26 = fdiv float %24, %25, !dbg !99
  store float %26, ptr %10, align 4, !dbg !94
  %27 = load float, ptr %9, align 4, !dbg !100
  %28 = load float, ptr %10, align 4, !dbg !101
  %29 = fadd float %27, %28, !dbg !102
  store float %29, ptr %8, align 4, !dbg !103
  br label %42, !dbg !104

30:                                               ; preds = %3
    #dbg_declare(ptr %11, !105, !DIExpression(), !107)
  %31 = load float, ptr %5, align 4, !dbg !108
  %32 = load float, ptr %7, align 4, !dbg !109
  %33 = fdiv float %31, %32, !dbg !110
  store float %33, ptr %11, align 4, !dbg !107
    #dbg_declare(ptr %12, !111, !DIExpression(), !112)
  %34 = load float, ptr %5, align 4, !dbg !113
  %35 = load float, ptr %4, align 4, !dbg !114
  %36 = fsub float %34, %35, !dbg !115
  %37 = load float, ptr %7, align 4, !dbg !116
  %38 = fdiv float %36, %37, !dbg !117
  store float %38, ptr %12, align 4, !dbg !112
  %39 = load float, ptr %11, align 4, !dbg !118
  %40 = load float, ptr %12, align 4, !dbg !119
  %41 = fsub float %39, %40, !dbg !120
  store float %41, ptr %8, align 4, !dbg !121
  br label %42

42:                                               ; preds = %30, %18
  %43 = load float, ptr %8, align 4, !dbg !122
  ret float %43, !dbg !123
}

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define i32 @main() #0 !dbg !124 {
  %1 = alloca i32, align 4
  %2 = alloca float, align 4
  %3 = alloca float, align 4
  %4 = alloca float, align 4
  %5 = alloca [8 x float], align 4
  %6 = alloca i32, align 4
  %7 = alloca float, align 4
  %8 = alloca float, align 4
  %9 = alloca float, align 4
  %10 = alloca float, align 4
  store i32 0, ptr %1, align 4
    #dbg_declare(ptr %2, !127, !DIExpression(), !128)
  store float 1.000000e+01, ptr %2, align 4, !dbg !128
    #dbg_declare(ptr %3, !129, !DIExpression(), !130)
  store float 2.000000e+00, ptr %3, align 4, !dbg !130
    #dbg_declare(ptr %4, !131, !DIExpression(), !132)
  store float 1.500000e+00, ptr %4, align 4, !dbg !132
    #dbg_declare(ptr %5, !133, !DIExpression(), !137)
    #dbg_declare(ptr %6, !138, !DIExpression(), !140)
  store i32 0, ptr %6, align 4, !dbg !140
  br label %11, !dbg !141

11:                                               ; preds = %21, %0
  %12 = load i32, ptr %6, align 4, !dbg !142
  %13 = icmp slt i32 %12, 8, !dbg !144
  br i1 %13, label %14, label %24, !dbg !145

14:                                               ; preds = %11
  %15 = load i32, ptr %6, align 4, !dbg !146
  %16 = sitofp i32 %15 to float, !dbg !146
  %17 = call float @llvm.fmuladd.f32(float 2.500000e-01, float %16, float 1.000000e+00), !dbg !147
  %18 = load i32, ptr %6, align 4, !dbg !148
  %19 = sext i32 %18 to i64, !dbg !149
  %20 = getelementptr inbounds [8 x float], ptr %5, i64 0, i64 %19, !dbg !149
  store float %17, ptr %20, align 4, !dbg !150
  br label %21, !dbg !149

21:                                               ; preds = %14
  %22 = load i32, ptr %6, align 4, !dbg !151
  %23 = add nsw i32 %22, 1, !dbg !151
  store i32 %23, ptr %6, align 4, !dbg !151
  br label %11, !dbg !152, !llvm.loop !153

24:                                               ; preds = %11
    #dbg_declare(ptr %7, !155, !DIExpression(), !156)
  %25 = load float, ptr %2, align 4, !dbg !157
  %26 = call float @compute_constants(float noundef %25), !dbg !158
  store float %26, ptr %7, align 4, !dbg !156
    #dbg_declare(ptr %8, !159, !DIExpression(), !160)
  %27 = load float, ptr %2, align 4, !dbg !161
  %28 = load float, ptr %3, align 4, !dbg !162
  %29 = load float, ptr %4, align 4, !dbg !163
  %30 = call float @reuse_same_den(float noundef %27, float noundef %28, float noundef %29), !dbg !164
  store float %30, ptr %8, align 4, !dbg !160
    #dbg_declare(ptr %9, !165, !DIExpression(), !166)
  %31 = getelementptr inbounds [8 x float], ptr %5, i64 0, i64 0, !dbg !167
  %32 = load float, ptr %3, align 4, !dbg !168
  %33 = fadd float %32, 3.000000e+00, !dbg !169
  %34 = call float @loop_div_sum(ptr noundef %31, i32 noundef 8, float noundef %33), !dbg !170
  store float %34, ptr %9, align 4, !dbg !166
    #dbg_declare(ptr %10, !171, !DIExpression(), !172)
  %35 = load float, ptr %2, align 4, !dbg !173
  %36 = load float, ptr %3, align 4, !dbg !174
  %37 = load float, ptr %4, align 4, !dbg !175
  %38 = call float @branchy(float noundef %35, float noundef %36, float noundef %37), !dbg !176
  store float %38, ptr %10, align 4, !dbg !172
  %39 = load float, ptr %7, align 4, !dbg !177
  %40 = fpext float %39 to double, !dbg !177
  %41 = load float, ptr %8, align 4, !dbg !178
  %42 = fpext float %41 to double, !dbg !178
  %43 = load float, ptr %9, align 4, !dbg !179
  %44 = fpext float %43 to double, !dbg !179
  %45 = load float, ptr %10, align 4, !dbg !180
  %46 = fpext float %45 to double, !dbg !180
  %47 = call i32 (ptr, ...) @printf(ptr noundef @.str, double noundef %40, double noundef %42, double noundef %44, double noundef %46), !dbg !181
  ret i32 0, !dbg !182
}

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define internal float @compute_constants(float noundef %0) #0 !dbg !183 {
  %2 = alloca float, align 4
  %3 = alloca float, align 4
  store float %0, ptr %2, align 4
    #dbg_declare(ptr %2, !186, !DIExpression(), !187)
    #dbg_declare(ptr %3, !188, !DIExpression(), !189)
  store float 0.000000e+00, ptr %3, align 4, !dbg !189
  %4 = load float, ptr %2, align 4, !dbg !190
  %div.mul = fmul float %4, 5.000000e-01, !dbg !191
  %5 = load float, ptr %3, align 4, !dbg !192
  %6 = fadd float %5, %div.mul, !dbg !192
  store float %6, ptr %3, align 4, !dbg !192
  %7 = load float, ptr %2, align 4, !dbg !193
  %div.mul1 = fmul float %7, 0x3FD5555560000000, !dbg !194
  %8 = load float, ptr %3, align 4, !dbg !195
  %9 = fadd float %8, %div.mul1, !dbg !195
  store float %9, ptr %3, align 4, !dbg !195
  %10 = load float, ptr %2, align 4, !dbg !196
  %div.mul2 = fmul float %10, 0x3FC99999A0000000, !dbg !197
  %11 = load float, ptr %3, align 4, !dbg !198
  %12 = fadd float %11, %div.mul2, !dbg !198
  store float %12, ptr %3, align 4, !dbg !198
  %13 = load float, ptr %2, align 4, !dbg !199
  %14 = fadd float %13, 1.000000e+00, !dbg !200
  %div.mul3 = fmul float %14, 2.500000e-01, !dbg !201
  %15 = load float, ptr %3, align 4, !dbg !202
  %16 = fadd float %15, %div.mul3, !dbg !202
  store float %16, ptr %3, align 4, !dbg !202
  %17 = load float, ptr %2, align 4, !dbg !203
  %18 = fsub float %17, 7.000000e+00, !dbg !204
  %div.mul4 = fmul float %18, 1.250000e-01, !dbg !205
  %19 = load float, ptr %3, align 4, !dbg !206
  %20 = fadd float %19, %div.mul4, !dbg !206
  store float %20, ptr %3, align 4, !dbg !206
  %21 = load float, ptr %3, align 4, !dbg !207
  ret float %21, !dbg !208
}

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define internal float @reuse_same_den(float noundef %0, float noundef %1, float noundef %2) #0 !dbg !209 {
  %4 = alloca float, align 4
  %5 = alloca float, align 4
  %6 = alloca float, align 4
  %7 = alloca float, align 4
  %8 = alloca float, align 4
  %9 = alloca float, align 4
  %10 = alloca float, align 4
  store float %0, ptr %4, align 4
    #dbg_declare(ptr %4, !210, !DIExpression(), !211)
  store float %1, ptr %5, align 4
    #dbg_declare(ptr %5, !212, !DIExpression(), !213)
  store float %2, ptr %6, align 4
    #dbg_declare(ptr %6, !214, !DIExpression(), !215)
    #dbg_declare(ptr %7, !216, !DIExpression(), !217)
  %11 = load float, ptr %4, align 4, !dbg !218
  %12 = load float, ptr %6, align 4, !dbg !219
  %13 = fdiv float %11, %12, !dbg !220
  store float %13, ptr %7, align 4, !dbg !217
    #dbg_declare(ptr %8, !221, !DIExpression(), !222)
  %14 = load float, ptr %5, align 4, !dbg !223
  %15 = load float, ptr %6, align 4, !dbg !224
  %16 = fdiv float %14, %15, !dbg !225
  store float %16, ptr %8, align 4, !dbg !222
    #dbg_declare(ptr %9, !226, !DIExpression(), !227)
  %17 = load float, ptr %4, align 4, !dbg !228
  %18 = load float, ptr %5, align 4, !dbg !229
  %19 = fadd float %17, %18, !dbg !230
  %20 = load float, ptr %6, align 4, !dbg !231
  %21 = fdiv float %19, %20, !dbg !232
  store float %21, ptr %9, align 4, !dbg !227
    #dbg_declare(ptr %10, !233, !DIExpression(), !234)
  %22 = load float, ptr %4, align 4, !dbg !235
  %23 = load float, ptr %5, align 4, !dbg !236
  %24 = fsub float %22, %23, !dbg !237
  %25 = load float, ptr %6, align 4, !dbg !238
  %26 = fdiv float %24, %25, !dbg !239
  store float %26, ptr %10, align 4, !dbg !234
  %27 = load float, ptr %7, align 4, !dbg !240
  %28 = load float, ptr %8, align 4, !dbg !241
  %29 = fadd float %27, %28, !dbg !242
  %30 = load float, ptr %9, align 4, !dbg !243
  %31 = fadd float %29, %30, !dbg !244
  %32 = load float, ptr %10, align 4, !dbg !245
  %33 = fadd float %31, %32, !dbg !246
  ret float %33, !dbg !247
}

declare i32 @printf(ptr noundef, ...) #2

attributes #0 = { noinline nounwind optnone ssp uwtable(sync) "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+ccpp,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a" }
attributes #1 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #2 = { "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+altnzcv,+ccdp,+ccidx,+ccpp,+complxnum,+crc,+dit,+dotprod,+flagm,+fp-armv8,+fp16fml,+fptoint,+fullfp16,+jsconv,+lse,+neon,+pauth,+perfmon,+predres,+ras,+rcpc,+rdm,+sb,+sha2,+sha3,+specrestrict,+ssbs,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8a" }

!llvm.module.flags = !{!7, !8, !9, !10, !11, !12, !13}
!llvm.dbg.cu = !{!14}
!llvm.ident = !{!18}

!0 = !DIGlobalVariableExpression(var: !1, expr: !DIExpression())
!1 = distinct !DIGlobalVariable(scope: null, file: !2, line: 62, type: !3, isLocal: true, isDefinition: true)
!2 = !DIFile(filename: "test.c", directory: "/Users/wangning/Desktop/cornell_repos/cs6120/assa7")
!3 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 264, elements: !5)
!4 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!5 = !{!6}
!6 = !DISubrange(count: 33)
!7 = !{i32 2, !"SDK Version", [2 x i32] [i32 13, i32 3]}
!8 = !{i32 7, !"Dwarf Version", i32 4}
!9 = !{i32 2, !"Debug Info Version", i32 3}
!10 = !{i32 1, !"wchar_size", i32 4}
!11 = !{i32 8, !"PIC Level", i32 2}
!12 = !{i32 7, !"uwtable", i32 1}
!13 = !{i32 7, !"frame-pointer", i32 1}
!14 = distinct !DICompileUnit(language: DW_LANG_C11, file: !2, producer: "Homebrew clang version 21.1.3", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, retainedTypes: !15, globals: !17, splitDebugInlining: false, nameTableKind: Apple, sysroot: "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX13.3.sdk", sdk: "MacOSX13.3.sdk")
!15 = !{!16}
!16 = !DIBasicType(name: "float", size: 32, encoding: DW_ATE_float)
!17 = !{!0}
!18 = !{!"Homebrew clang version 21.1.3"}
!19 = distinct !DISubprogram(name: "loop_div_sum", scope: !2, file: !2, line: 26, type: !20, scopeLine: 26, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !14, retainedNodes: !25)
!20 = !DISubroutineType(types: !21)
!21 = !{!16, !22, !24, !16}
!22 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !23, size: 64)
!23 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !16)
!24 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!25 = !{}
!26 = !DILocalVariable(name: "arr", arg: 1, scope: !19, file: !2, line: 26, type: !22)
!27 = !DILocation(line: 26, column: 33, scope: !19)
!28 = !DILocalVariable(name: "n", arg: 2, scope: !19, file: !2, line: 26, type: !24)
!29 = !DILocation(line: 26, column: 42, scope: !19)
!30 = !DILocalVariable(name: "den", arg: 3, scope: !19, file: !2, line: 26, type: !16)
!31 = !DILocation(line: 26, column: 51, scope: !19)
!32 = !DILocalVariable(name: "acc", scope: !19, file: !2, line: 27, type: !16)
!33 = !DILocation(line: 27, column: 11, scope: !19)
!34 = !DILocalVariable(name: "i", scope: !35, file: !2, line: 28, type: !24)
!35 = distinct !DILexicalBlock(scope: !19, file: !2, line: 28, column: 5)
!36 = !DILocation(line: 28, column: 14, scope: !35)
!37 = !DILocation(line: 28, column: 10, scope: !35)
!38 = !DILocation(line: 28, column: 21, scope: !39)
!39 = distinct !DILexicalBlock(scope: !35, file: !2, line: 28, column: 5)
!40 = !DILocation(line: 28, column: 25, scope: !39)
!41 = !DILocation(line: 28, column: 23, scope: !39)
!42 = !DILocation(line: 28, column: 5, scope: !35)
!43 = !DILocalVariable(name: "num", scope: !44, file: !2, line: 29, type: !16)
!44 = distinct !DILexicalBlock(scope: !39, file: !2, line: 28, column: 33)
!45 = !DILocation(line: 29, column: 15, scope: !44)
!46 = !DILocation(line: 29, column: 21, scope: !44)
!47 = !DILocation(line: 29, column: 25, scope: !44)
!48 = !DILocation(line: 29, column: 37, scope: !44)
!49 = !DILocation(line: 29, column: 30, scope: !44)
!50 = !DILocation(line: 29, column: 28, scope: !44)
!51 = !DILocation(line: 30, column: 16, scope: !44)
!52 = !DILocation(line: 30, column: 22, scope: !44)
!53 = !DILocation(line: 30, column: 20, scope: !44)
!54 = !DILocation(line: 30, column: 13, scope: !44)
!55 = !DILocation(line: 31, column: 17, scope: !44)
!56 = !DILocation(line: 31, column: 21, scope: !44)
!57 = !DILocation(line: 31, column: 31, scope: !44)
!58 = !DILocation(line: 31, column: 29, scope: !44)
!59 = !DILocation(line: 31, column: 13, scope: !44)
!60 = !DILocation(line: 32, column: 5, scope: !44)
!61 = !DILocation(line: 28, column: 29, scope: !39)
!62 = !DILocation(line: 28, column: 5, scope: !39)
!63 = distinct !{!63, !42, !64, !65}
!64 = !DILocation(line: 32, column: 5, scope: !35)
!65 = !{!"llvm.loop.mustprogress"}
!66 = !DILocation(line: 33, column: 12, scope: !19)
!67 = !DILocation(line: 33, column: 5, scope: !19)
!68 = distinct !DISubprogram(name: "branchy", scope: !2, file: !2, line: 37, type: !69, scopeLine: 37, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !14, retainedNodes: !25)
!69 = !DISubroutineType(types: !70)
!70 = !{!16, !16, !16, !16}
!71 = !DILocalVariable(name: "a", arg: 1, scope: !68, file: !2, line: 37, type: !16)
!72 = !DILocation(line: 37, column: 21, scope: !68)
!73 = !DILocalVariable(name: "b", arg: 2, scope: !68, file: !2, line: 37, type: !16)
!74 = !DILocation(line: 37, column: 30, scope: !68)
!75 = !DILocalVariable(name: "c", arg: 3, scope: !68, file: !2, line: 37, type: !16)
!76 = !DILocation(line: 37, column: 39, scope: !68)
!77 = !DILocalVariable(name: "den", scope: !68, file: !2, line: 38, type: !16)
!78 = !DILocation(line: 38, column: 11, scope: !68)
!79 = !DILocation(line: 38, column: 17, scope: !68)
!80 = !DILocation(line: 38, column: 19, scope: !68)
!81 = !DILocalVariable(name: "r", scope: !68, file: !2, line: 39, type: !16)
!82 = !DILocation(line: 39, column: 11, scope: !68)
!83 = !DILocation(line: 40, column: 9, scope: !84)
!84 = distinct !DILexicalBlock(scope: !68, file: !2, line: 40, column: 9)
!85 = !DILocation(line: 40, column: 13, scope: !84)
!86 = !DILocation(line: 40, column: 11, scope: !84)
!87 = !DILocalVariable(name: "t1", scope: !88, file: !2, line: 41, type: !16)
!88 = distinct !DILexicalBlock(scope: !84, file: !2, line: 40, column: 16)
!89 = !DILocation(line: 41, column: 15, scope: !88)
!90 = !DILocation(line: 41, column: 20, scope: !88)
!91 = !DILocation(line: 41, column: 24, scope: !88)
!92 = !DILocation(line: 41, column: 22, scope: !88)
!93 = !DILocalVariable(name: "t2", scope: !88, file: !2, line: 42, type: !16)
!94 = !DILocation(line: 42, column: 15, scope: !88)
!95 = !DILocation(line: 42, column: 21, scope: !88)
!96 = !DILocation(line: 42, column: 25, scope: !88)
!97 = !DILocation(line: 42, column: 23, scope: !88)
!98 = !DILocation(line: 42, column: 30, scope: !88)
!99 = !DILocation(line: 42, column: 28, scope: !88)
!100 = !DILocation(line: 43, column: 13, scope: !88)
!101 = !DILocation(line: 43, column: 18, scope: !88)
!102 = !DILocation(line: 43, column: 16, scope: !88)
!103 = !DILocation(line: 43, column: 11, scope: !88)
!104 = !DILocation(line: 44, column: 5, scope: !88)
!105 = !DILocalVariable(name: "t1", scope: !106, file: !2, line: 45, type: !16)
!106 = distinct !DILexicalBlock(scope: !84, file: !2, line: 44, column: 12)
!107 = !DILocation(line: 45, column: 15, scope: !106)
!108 = !DILocation(line: 45, column: 20, scope: !106)
!109 = !DILocation(line: 45, column: 24, scope: !106)
!110 = !DILocation(line: 45, column: 22, scope: !106)
!111 = !DILocalVariable(name: "t2", scope: !106, file: !2, line: 46, type: !16)
!112 = !DILocation(line: 46, column: 15, scope: !106)
!113 = !DILocation(line: 46, column: 21, scope: !106)
!114 = !DILocation(line: 46, column: 25, scope: !106)
!115 = !DILocation(line: 46, column: 23, scope: !106)
!116 = !DILocation(line: 46, column: 30, scope: !106)
!117 = !DILocation(line: 46, column: 28, scope: !106)
!118 = !DILocation(line: 47, column: 13, scope: !106)
!119 = !DILocation(line: 47, column: 18, scope: !106)
!120 = !DILocation(line: 47, column: 16, scope: !106)
!121 = !DILocation(line: 47, column: 11, scope: !106)
!122 = !DILocation(line: 49, column: 12, scope: !68)
!123 = !DILocation(line: 49, column: 5, scope: !68)
!124 = distinct !DISubprogram(name: "main", scope: !2, file: !2, line: 52, type: !125, scopeLine: 52, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !14, retainedNodes: !25)
!125 = !DISubroutineType(types: !126)
!126 = !{!24}
!127 = !DILocalVariable(name: "a", scope: !124, file: !2, line: 53, type: !16)
!128 = !DILocation(line: 53, column: 11, scope: !124)
!129 = !DILocalVariable(name: "b", scope: !124, file: !2, line: 53, type: !16)
!130 = !DILocation(line: 53, column: 22, scope: !124)
!131 = !DILocalVariable(name: "c", scope: !124, file: !2, line: 53, type: !16)
!132 = !DILocation(line: 53, column: 32, scope: !124)
!133 = !DILocalVariable(name: "arr", scope: !124, file: !2, line: 54, type: !134)
!134 = !DICompositeType(tag: DW_TAG_array_type, baseType: !16, size: 256, elements: !135)
!135 = !{!136}
!136 = !DISubrange(count: 8)
!137 = !DILocation(line: 54, column: 11, scope: !124)
!138 = !DILocalVariable(name: "i", scope: !139, file: !2, line: 55, type: !24)
!139 = distinct !DILexicalBlock(scope: !124, file: !2, line: 55, column: 5)
!140 = !DILocation(line: 55, column: 14, scope: !139)
!141 = !DILocation(line: 55, column: 10, scope: !139)
!142 = !DILocation(line: 55, column: 21, scope: !143)
!143 = distinct !DILexicalBlock(scope: !139, file: !2, line: 55, column: 5)
!144 = !DILocation(line: 55, column: 23, scope: !143)
!145 = !DILocation(line: 55, column: 5, scope: !139)
!146 = !DILocation(line: 55, column: 50, scope: !143)
!147 = !DILocation(line: 55, column: 52, scope: !143)
!148 = !DILocation(line: 55, column: 37, scope: !143)
!149 = !DILocation(line: 55, column: 33, scope: !143)
!150 = !DILocation(line: 55, column: 40, scope: !143)
!151 = !DILocation(line: 55, column: 29, scope: !143)
!152 = !DILocation(line: 55, column: 5, scope: !143)
!153 = distinct !{!153, !145, !154, !65}
!154 = !DILocation(line: 55, column: 54, scope: !139)
!155 = !DILocalVariable(name: "r1", scope: !124, file: !2, line: 57, type: !16)
!156 = !DILocation(line: 57, column: 11, scope: !124)
!157 = !DILocation(line: 57, column: 34, scope: !124)
!158 = !DILocation(line: 57, column: 16, scope: !124)
!159 = !DILocalVariable(name: "r2", scope: !124, file: !2, line: 58, type: !16)
!160 = !DILocation(line: 58, column: 11, scope: !124)
!161 = !DILocation(line: 58, column: 31, scope: !124)
!162 = !DILocation(line: 58, column: 34, scope: !124)
!163 = !DILocation(line: 58, column: 37, scope: !124)
!164 = !DILocation(line: 58, column: 16, scope: !124)
!165 = !DILocalVariable(name: "r3", scope: !124, file: !2, line: 59, type: !16)
!166 = !DILocation(line: 59, column: 11, scope: !124)
!167 = !DILocation(line: 59, column: 29, scope: !124)
!168 = !DILocation(line: 59, column: 37, scope: !124)
!169 = !DILocation(line: 59, column: 39, scope: !124)
!170 = !DILocation(line: 59, column: 16, scope: !124)
!171 = !DILocalVariable(name: "r4", scope: !124, file: !2, line: 60, type: !16)
!172 = !DILocation(line: 60, column: 11, scope: !124)
!173 = !DILocation(line: 60, column: 24, scope: !124)
!174 = !DILocation(line: 60, column: 27, scope: !124)
!175 = !DILocation(line: 60, column: 30, scope: !124)
!176 = !DILocation(line: 60, column: 16, scope: !124)
!177 = !DILocation(line: 62, column: 49, scope: !124)
!178 = !DILocation(line: 62, column: 53, scope: !124)
!179 = !DILocation(line: 62, column: 57, scope: !124)
!180 = !DILocation(line: 62, column: 61, scope: !124)
!181 = !DILocation(line: 62, column: 5, scope: !124)
!182 = !DILocation(line: 63, column: 5, scope: !124)
!183 = distinct !DISubprogram(name: "compute_constants", scope: !2, file: !2, line: 5, type: !184, scopeLine: 5, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !14, retainedNodes: !25)
!184 = !DISubroutineType(types: !185)
!185 = !{!16, !16}
!186 = !DILocalVariable(name: "x", arg: 1, scope: !183, file: !2, line: 5, type: !16)
!187 = !DILocation(line: 5, column: 45, scope: !183)
!188 = !DILocalVariable(name: "y", scope: !183, file: !2, line: 6, type: !16)
!189 = !DILocation(line: 6, column: 11, scope: !183)
!190 = !DILocation(line: 7, column: 10, scope: !183)
!191 = !DILocation(line: 7, column: 12, scope: !183)
!192 = !DILocation(line: 7, column: 7, scope: !183)
!193 = !DILocation(line: 8, column: 10, scope: !183)
!194 = !DILocation(line: 8, column: 12, scope: !183)
!195 = !DILocation(line: 8, column: 7, scope: !183)
!196 = !DILocation(line: 9, column: 10, scope: !183)
!197 = !DILocation(line: 9, column: 12, scope: !183)
!198 = !DILocation(line: 9, column: 7, scope: !183)
!199 = !DILocation(line: 10, column: 11, scope: !183)
!200 = !DILocation(line: 10, column: 13, scope: !183)
!201 = !DILocation(line: 10, column: 21, scope: !183)
!202 = !DILocation(line: 10, column: 7, scope: !183)
!203 = !DILocation(line: 11, column: 11, scope: !183)
!204 = !DILocation(line: 11, column: 13, scope: !183)
!205 = !DILocation(line: 11, column: 21, scope: !183)
!206 = !DILocation(line: 11, column: 7, scope: !183)
!207 = !DILocation(line: 12, column: 12, scope: !183)
!208 = !DILocation(line: 12, column: 5, scope: !183)
!209 = distinct !DISubprogram(name: "reuse_same_den", scope: !2, file: !2, line: 17, type: !69, scopeLine: 17, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !14, retainedNodes: !25)
!210 = !DILocalVariable(name: "a", arg: 1, scope: !209, file: !2, line: 17, type: !16)
!211 = !DILocation(line: 17, column: 42, scope: !209)
!212 = !DILocalVariable(name: "b", arg: 2, scope: !209, file: !2, line: 17, type: !16)
!213 = !DILocation(line: 17, column: 51, scope: !209)
!214 = !DILocalVariable(name: "d", arg: 3, scope: !209, file: !2, line: 17, type: !16)
!215 = !DILocation(line: 17, column: 60, scope: !209)
!216 = !DILocalVariable(name: "s1", scope: !209, file: !2, line: 18, type: !16)
!217 = !DILocation(line: 18, column: 11, scope: !209)
!218 = !DILocation(line: 18, column: 16, scope: !209)
!219 = !DILocation(line: 18, column: 20, scope: !209)
!220 = !DILocation(line: 18, column: 18, scope: !209)
!221 = !DILocalVariable(name: "s2", scope: !209, file: !2, line: 19, type: !16)
!222 = !DILocation(line: 19, column: 11, scope: !209)
!223 = !DILocation(line: 19, column: 16, scope: !209)
!224 = !DILocation(line: 19, column: 20, scope: !209)
!225 = !DILocation(line: 19, column: 18, scope: !209)
!226 = !DILocalVariable(name: "s3", scope: !209, file: !2, line: 20, type: !16)
!227 = !DILocation(line: 20, column: 11, scope: !209)
!228 = !DILocation(line: 20, column: 17, scope: !209)
!229 = !DILocation(line: 20, column: 21, scope: !209)
!230 = !DILocation(line: 20, column: 19, scope: !209)
!231 = !DILocation(line: 20, column: 26, scope: !209)
!232 = !DILocation(line: 20, column: 24, scope: !209)
!233 = !DILocalVariable(name: "s4", scope: !209, file: !2, line: 21, type: !16)
!234 = !DILocation(line: 21, column: 11, scope: !209)
!235 = !DILocation(line: 21, column: 17, scope: !209)
!236 = !DILocation(line: 21, column: 21, scope: !209)
!237 = !DILocation(line: 21, column: 19, scope: !209)
!238 = !DILocation(line: 21, column: 26, scope: !209)
!239 = !DILocation(line: 21, column: 24, scope: !209)
!240 = !DILocation(line: 22, column: 12, scope: !209)
!241 = !DILocation(line: 22, column: 17, scope: !209)
!242 = !DILocation(line: 22, column: 15, scope: !209)
!243 = !DILocation(line: 22, column: 22, scope: !209)
!244 = !DILocation(line: 22, column: 20, scope: !209)
!245 = !DILocation(line: 22, column: 27, scope: !209)
!246 = !DILocation(line: 22, column: 25, scope: !209)
!247 = !DILocation(line: 22, column: 5, scope: !209)
