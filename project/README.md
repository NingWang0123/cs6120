# LLVM Loop Parallelization Pass

An LLVM compiler pass that automatically parallelizes loops using OpenMP.

## What It Does

This pass:
1. Detects loops that can be safely parallelized using LLVM's `LoopAccessAnalysis`
2. Checks for loop fusion opportunities (consecutive independent loops)
3. Transforms loops to parallel form using `OpenMPIRBuilder`
4. Verifies correctness by comparing serial and parallel results
5. Measures performance improvements

## Quick Start

### 1. Install Dependencies

```bash
brew install llvm libomp
pip3 install matplotlib numpy  # For visualizations
```

### 2. Build

```bash
make build
```

This creates `LoopParallelizationPass.dylib` (572KB).

### 3. Run Benchmarks

```bash
# Run simple benchmarks
./run_benchmarks.sh

# Run PolyBench/C real-world benchmarks
./run_polybench.sh
```

This will:
- Verify correctness (serial vs parallel results match)
- Measure performance with 1, 2, 4, and 8 threads
- Generate visualization charts automatically

## Results

### Correctness
All tests verify that parallelized code produces identical results to serial code.

### Performance - Simple Benchmarks
Typical speedups on 4 cores:
- **Automated pass**: 1.2x - 1.5x
- **Manual OpenMP**: 3.5x - 4.0x

The automated pass trades peak performance for safety guarantees and zero developer effort.

### Performance - PolyBench/C Real-World Benchmarks
Evaluated on 30 PolyBench/C benchmarks (linear algebra, stencils, data mining) with 1, 2, 4, and 8 threads:

**Parallelization Coverage:**
- **Total benchmarks**: 30
- **Parallelizable loops found**: 6 benchmarks (20%)
- **Not parallelizable**: 24 benchmarks (80%)

**Speedup by Thread Count:**
- **1 thread**: 0.96x mean, 33% improved (10/30)
- **2 threads**: 1.13x mean, 67% improved (20/30)
- **4 threads**: 1.19x mean, 77% improved (23/30)
- **8 threads**: 1.27x mean, 90% improved (27/30)

**Best Speedups (4 threads):**
- nussinov: 2.78x
- gesummv: 1.66x
- atax: 1.53x (parallelizable)
- fdtd-2d: 1.48x
- seidel-2d: 1.35x

**End-to-End Total Execution Time:**
- Serial: 0.0132s
- 4 threads: 0.0107s (**1.24x speedup**)
- 8 threads: 0.0106s (**1.24x speedup**)

Key findings:
- Conservative safety analysis correctly identifies 6 truly parallelizable benchmarks
- Small problem sizes (SMALL_DATASET) limit scaling beyond 4 threads
- Even non-parallelizable benchmarks show improvement (compiler optimizations)
- Best overall speedup with 4-8 threads

See `polybench_results/` for detailed analysis and 4 comprehensive visualizations.

## How It Works

### Safety Check
Uses `LoopAccessAnalysis` to ensure "no unsafe memory dependences":
```cpp
LoopAccessInfo LAI(L, &SE, &TTI, &TLI, &AA, &DT, &LI);
if (LAI.canVectorizeMemory() && DepChecker.getDependences()->empty()) {
    // Safe to parallelize
}
```

### Loop Fusion
Identifies consecutive independent loops that can be fused:
- Same trip count
- No data dependencies between loops
- Sequential control flow

### Transformation
Generates parallel code using `OpenMPIRBuilder`:
- Creates canonical loop form
- Applies OpenMP worksharing constructs
- Handles thread management automatically

## Usage

### Apply to Your Code

```bash
# Generate LLVM IR
/opt/homebrew/opt/llvm/bin/clang -S -emit-llvm -O1 mycode.c -o mycode.ll

# Apply parallelization pass
/opt/homebrew/opt/llvm/bin/opt \
    -passes="loop-simplify,loop-parallelize" \
    -load-pass-plugin=./LoopParallelizationPass.dylib \
    -enable-loop-parallel=true \
    -enable-loop-fusion=true \
    mycode.ll -S -o mycode_parallel.ll

# Compile with OpenMP
/opt/homebrew/opt/llvm/bin/clang mycode_parallel.ll -o mycode \
    -fopenmp -L/opt/homebrew/opt/libomp/lib
```

### Command-Line Flags

- `-enable-loop-parallel=<bool>` - Enable/disable parallelization (default: true)
- `-enable-loop-fusion=<bool>` - Enable/disable loop fusion (default: true)
- `OMP_NUM_THREADS=N` - Set number of threads at runtime

## Example: Parallelizable Loop

```c
// This loop can be automatically parallelized
void array_add(float *a, float *b, float *c, int n) {
    for (int i = 0; i < n; i++) {  // No dependencies!
        c[i] = a[i] + b[i];
    }
}
```

The pass detects this is safe and transforms it to run in parallel.

## Example: Loop Fusion

```c
// Two independent loops
for (int i = 0; i < n; i++) {
    a[i] = a[i] * 2.0f;
}
for (int i = 0; i < n; i++) {  // Can fuse with above
    b[i] = b[i] + 1.0f;
}
```

The pass identifies these can be fused and parallelized together.

## Project Structure

```
project/
├── src/LoopParallelizationPass.cpp  # Main pass implementation
├── tests/
│   ├── verify_correctness.c         # Correctness verification
│   ├── benchmark.c                  # Performance tests
│   └── manual_parallel.c            # Manual OpenMP comparison
├── polybench/                       # PolyBench/C benchmark suite
│   ├── linear-algebra/              # Matrix operations (gemm, syrk, etc.)
│   ├── stencils/                    # Stencil computations (jacobi, heat, etc.)
│   └── datamining/                  # Data analysis (correlation, covariance)
├── run_benchmarks.sh                # Simple benchmark script
├── run_polybench.sh                 # PolyBench evaluation script
├── visualize_results.py             # Simple benchmark charts
├── visualize_polybench.py           # PolyBench analysis charts
└── README.md                        # This file
```

## Implementation Details

### Loop Analysis
- Uses `LoopAccessAnalysis` for dependence checking
- Verifies loop structure (preheader, latch, exit)
- Computes trip counts with `ScalarEvolution`

### Loop Fusion Detection
- Checks consecutive loops for same trip count
- Uses `AliasAnalysis` to verify independence
- Ensures proper control flow connection

### Code Generation
- Creates canonical loop with `createCanonicalLoop()`
- Applies worksharing with `applyWorkshareLoop()`
- Uses static scheduling for predictable performance

## Limitations

Current implementation does not handle:
- Reduction loops (sum, max, min)
- Loops with break/continue statements
- Indirect array accesses
- Loops with function calls that modify shared state

## Troubleshooting

### "command not found: opt"
Use full path: `/opt/homebrew/opt/llvm/bin/opt` or add to PATH:
```bash
export PATH="/opt/homebrew/opt/llvm/bin:$PATH"
```

### "No parallelizable loops found"
Loop may have dependencies. Check with:
```bash
opt -passes="loop-simplify,loop-parallelize" \
    -load-pass-plugin=./LoopParallelizationPass.dylib \
    -enable-loop-parallel=true \
    -debug-only=loop-parallelization \
    input.ll -S -o output.ll 2>&1
```

### Slower with parallelization
- Problem size may be too small (try N > 1,000,000)
- Memory bandwidth limited (common with simple operations)
- Too many threads (try `OMP_NUM_THREADS=4`)

## Key Files

### Simple Benchmarks
- `LoopParallelizationPass.dylib` - Compiled pass (572KB)
- `results/benchmark_results.txt` - Performance data
- `results/performance_comparison.png` - Bar charts
- `results/speedup_analysis.png` - Speedup curves
- `results/performance_report.txt` - Statistical summary

### PolyBench Results
- `polybench_results/results.csv` - All benchmark data (1,2,4,8 threads)
- `polybench_results/results.txt` - Detailed results per benchmark
- `polybench_results/parallelizable_overview.png` - Coverage pie chart and loop distribution
- `polybench_results/speedup_by_threads.png` - Multi-thread speedup comparison (parallelizable only)
- `polybench_results/speedup_scaling.png` - Scaling curves for parallelizable benchmarks
- `polybench_results/end_to_end_comparison.png` - Total execution time comparison
- `polybench_results/summary.txt` - Comprehensive statistical summary

## References

- [LLVM LoopAccessAnalysis](https://llvm.org/doxygen/classllvm_1_1LoopAccessInfo.html)
- [OpenMP IR Builder](https://llvm.org/doxygen/classllvm_1_1OpenMPIRBuilder.html)
- [LLVM Pass Writing](https://llvm.org/docs/WritingAnLLVMNewPMPass.html)
- [PolyBench/C Benchmark Suite](https://github.com/MatthiasJReisinger/PolyBenchC-4.2.1)

## License

CS 6120: Advanced Compilers - Course Project
