# LLVM Loop Parallelization Pass

An LLVM compiler pass that automatically parallelizes loops using OpenMP.

## Quick Start

### 1. Install Dependencies

```bash
brew install llvm libomp
pip3 install matplotlib numpy pandas seaborn  # For visualizations
```

### 2. Build

```bash
make build
```

This creates `LoopParallelizationPass.dylib`.

### 3. Run Benchmarks

```bash
# Run simple test benchmarks (compares 3 implementations with 2, 4, 8 threads)
./run_tests.sh

# Run PolyBench real-world benchmarks (compares 3 implementations with 2, 4, 8 threads)
./run_polybench.sh
```

This will:
- Build all 3 implementations
- Run benchmarks with serial baseline and multiple thread counts (2, 4, 8)
- Generate visualization charts automatically
- Create comprehensive performance reports

## What It Does

This pass:
1. Detects loops that can be safely parallelized using LLVM's `LoopAccessAnalysis`
2. Checks for loop fusion opportunities (consecutive independent loops)
3. Transforms loops to parallel form using `OpenMPIRBuilder`
4. Compares 3 different implementations
5. Measures performance improvements across multiple thread counts

## Implementation Variants

The project includes three implementations:

### 1. Original (LoopParallelizationPass.cpp)
- Basic parallelization
- Fusion detection only (doesn't actually fuse)
- Each loop gets separate parallel region

### 2. Fusion (LoopParallelizationPass_with_fusion.cpp)
- Actually implements loop fusion
- Merges consecutive independent loops
- Reduced loop overhead, better cache locality

### 3. Fusion+Shared (LoopParallelizationPass_with_fusion_shared.cpp)
- Loop fusion + shared parallel region
- Minimal fork/join overhead

## Results Organization

### Simple Test Benchmarks
After running `./run_tests.sh`:
- `tests_results/raw_data.csv` - All benchmark data
- `tests_results/performance_comparison.png` - Implementation comparison
- `tests_results/speedup_analysis.png` - Speedup curves
- `tests_results/performance_report.txt` - Statistical analysis

### PolyBench Benchmarks
After running `./run_polybench.sh`:
- `polybench_results/results.csv` - All benchmark results
- `polybench_results/implementation_speedup_comparison.png` - Speedup distributions
- `polybench_results/speedup_scaling.png` - Scaling across thread counts
- `polybench_results/parallelizable_coverage.png` - Coverage analysis
- `polybench_results/summary.txt` - Comprehensive report

## How It Works

### Safety Check
Uses `LoopAccessAnalysis` to ensure no unsafe memory dependences:
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
/opt/homebrew/opt/llvm/bin/clang -S -emit-llvm -O2 mycode.c -o mycode.ll

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
├── src/
│   ├── LoopParallelizationPass.cpp                      # Original implementation
│   ├── LoopParallelizationPass_with_fusion.cpp          # With loop fusion
│   └── LoopParallelizationPass_with_fusion_shared.cpp   # Fusion + shared region
├── tests/
│   ├── verify_correctness.c         # Correctness tests
│   ├── benchmark.c                  # Performance benchmarks
│   └── manual_parallel.c            # Manual OpenMP comparison
├── polybench/                       # PolyBench/C benchmark suite (clone separately)
├── run_tests.sh                     # Simple test benchmark runner
├── run_polybench.sh                 # PolyBench benchmark runner
├── visualize_results.py             # Test benchmark visualizations
├── visualize_polybench.py           # PolyBench visualizations
├── tests_results/                   # Test benchmark results (generated)
├── polybench_results/               # PolyBench results (generated)
├── build/                           # Build artifacts (generated)
└── README.md                        # This file
```

## Switching Between Implementations

The benchmark scripts automatically build and test all three implementations. To use a specific implementation manually, edit `CMakeLists.txt` line 20:

```cmake
# For original:
add_library(LoopParallelizationPass MODULE
  src/LoopParallelizationPass.cpp
)

# For fusion:
add_library(LoopParallelizationPass MODULE
  src/LoopParallelizationPass_with_fusion.cpp
)

# For fusion+shared:
add_library(LoopParallelizationPass MODULE
  src/LoopParallelizationPass_with_fusion_shared.cpp
)
```

Then rebuild:
```bash
make clean
make build
```

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

## References

- [LLVM LoopAccessAnalysis](https://llvm.org/doxygen/classllvm_1_1LoopAccessInfo.html)
- [OpenMP IR Builder](https://llvm.org/doxygen/classllvm_1_1OpenMPIRBuilder.html)
- [LLVM Pass Writing](https://llvm.org/docs/WritingAnLLVMNewPMPass.html)
- [PolyBench/C Benchmark Suite](https://github.com/MatthiasJReisinger/PolyBenchC-4.2.1)

## License

CS 6120: Advanced Compilers - Course Project
