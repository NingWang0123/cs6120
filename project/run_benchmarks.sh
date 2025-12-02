#!/bin/bash

# Benchmark script for loop parallelization with correctness verification

set -e

# Use Homebrew LLVM tools
LLVM_DIR="/opt/homebrew/opt/llvm/bin"
CLANG="${CLANG:-${LLVM_DIR}/clang}"
OPT="${OPT:-${LLVM_DIR}/opt}"
PASS_LIB="./LoopParallelizationPass.dylib"

echo "=========================================="
echo "Loop Parallelization Benchmarks"
echo "=========================================="

# Check if pass library exists
if [ ! -f "$PASS_LIB" ]; then
    echo "Error: Pass library not found. Please run 'make build' first."
    exit 1
fi

# Create output directories
mkdir -p output
mkdir -p results

echo ""
echo "Step 1: Correctness Verification"
echo "====================================="

# Compile correctness test - serial version
echo "Compiling serial version..."
$CLANG -O2 tests/verify_correctness.c -o output/verify_serial

# Generate IR and apply pass
echo "Generating parallelized version..."
$CLANG -S -emit-llvm -O2 tests/verify_correctness.c -o output/verify.ll
$OPT -passes="loop-simplify,loop-parallelize" -load-pass-plugin="$PASS_LIB" \
    -enable-loop-parallel=true -enable-loop-fusion=true \
    output/verify.ll -S -o output/verify_parallel.ll 2>&1 | grep -E "(Found|Fused|Successfully)" || true

# Compile parallelized version
$CLANG -O2 output/verify_parallel.ll -o output/verify_parallel -fopenmp \
    -L/opt/homebrew/opt/libomp/lib

echo ""
echo "Running serial version:"
./output/verify_serial

echo ""
echo "Running parallelized version:"
OMP_NUM_THREADS=4 ./output/verify_parallel

echo ""
echo "Step 2: Performance Benchmarking"
echo "====================================="

# Compile benchmark
echo "Compiling benchmark program..."
$CLANG -S -emit-llvm -O2 tests/benchmark.c -o output/benchmark.ll

# Create parallelized version
echo "Creating parallelized version..."
$OPT -passes="loop-simplify,loop-parallelize" -load-pass-plugin="$PASS_LIB" \
    -enable-loop-parallel=true -enable-loop-fusion=true \
    output/benchmark.ll -S -o output/benchmark_parallel.ll 2>&1 | grep -E "(Found|Fused|Successfully)" || true

# Compile executables
$CLANG -O2 output/benchmark.ll -o output/bench_serial
$CLANG -O2 output/benchmark_parallel.ll -o output/bench_parallel -fopenmp \
    -L/opt/homebrew/opt/libomp/lib

echo ""
echo "Running benchmarks..."
echo "=========================================="

# Create results file
RESULTS_FILE="results/benchmark_results.txt"
echo "Loop Parallelization Benchmark Results" > $RESULTS_FILE
echo "Date: $(date)" >> $RESULTS_FILE
echo "=========================================" >> $RESULTS_FILE
echo "" >> $RESULTS_FILE

# Run serial version multiple times
echo "Serial (Original) Version:" | tee -a $RESULTS_FILE
echo "--------------------------" | tee -a $RESULTS_FILE
for i in {1..5}; do
    echo "Run $i:" | tee -a $RESULTS_FILE
    ./output/bench_serial | tee -a $RESULTS_FILE
    echo "" >> $RESULTS_FILE
done

echo "" | tee -a $RESULTS_FILE

# Run parallelized version with different thread counts
for THREADS in 1 2 4 8; do
    echo "Parallelized Version (${THREADS} threads):" | tee -a $RESULTS_FILE
    echo "--------------------------------------" | tee -a $RESULTS_FILE
    export OMP_NUM_THREADS=$THREADS
    for i in {1..5}; do
        echo "Run $i:" | tee -a $RESULTS_FILE
        ./output/bench_parallel | tee -a $RESULTS_FILE
        echo "" >> $RESULTS_FILE
    done
    echo "" | tee -a $RESULTS_FILE
done

echo "=========================================="
echo "Benchmarks complete!"
echo "Results saved to: $RESULTS_FILE"
echo "=========================================="

# Step 3: Generate visualizations
echo ""
echo "Step 3: Generating Visualizations"
echo "====================================="

if command -v python3 &> /dev/null; then
    if python3 -c "import matplotlib, numpy" 2>/dev/null; then
        echo "Running visualization script..."
        python3 visualize_results.py
        echo ""
        echo "=========================================="
        echo "✓ Visualizations generated!"
        echo "  - results/performance_comparison.png"
        echo "  - results/speedup_analysis.png"
        echo "  - results/performance_report.txt"
        echo "=========================================="
    else
        echo "Warning: Python packages (matplotlib, numpy) not found."
        echo "Install with: pip3 install matplotlib numpy"
    fi
else
    echo "Warning: python3 not found. Skipping visualization."
fi

echo ""
echo "=========================================="
echo "All tasks complete!"
echo "=========================================="
