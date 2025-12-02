#!/bin/bash

# Benchmark script for loop parallelization

set -e

CLANG=${CLANG:-clang}
OPT=${OPT:-opt}
PASS_LIB="./LoopParallelizationPass.dylib"

echo "=========================================="
echo "Loop Parallelization Benchmarks"
echo "=========================================="

# Check if pass library exists
if [ ! -f "$PASS_LIB" ]; then
    echo "Error: Pass library not found. Please run 'make build' first."
    exit 1
fi

# Create output directory
mkdir -p output
mkdir -p results

# Compile benchmark
echo "Compiling benchmark program..."
$CLANG -S -emit-llvm -O2 tests/benchmark.c -o output/benchmark.ll

# Create parallelized version
echo "Creating parallelized version..."
$OPT -passes="loop-simplify,loop-parallelize" -load-pass-plugin="$PASS_LIB" \
    -enable-loop-parallel=true output/benchmark.ll -S -o output/benchmark_parallel.ll

# Compile executables
$CLANG -O2 output/benchmark.ll -o output/bench_orig
$CLANG -O2 output/benchmark_parallel.ll -o output/bench_parallel -fopenmp

echo ""
echo "Running benchmarks..."
echo "=========================================="

# Create results file
RESULTS_FILE="results/benchmark_results.txt"
echo "Loop Parallelization Benchmark Results" > $RESULTS_FILE
echo "Date: $(date)" >> $RESULTS_FILE
echo "=========================================" >> $RESULTS_FILE
echo "" >> $RESULTS_FILE

# Run original version multiple times
echo "Original (Serial) Version:" | tee -a $RESULTS_FILE
echo "--------------------------" | tee -a $RESULTS_FILE
for i in {1..5}; do
    echo "Run $i:" | tee -a $RESULTS_FILE
    ./output/bench_orig | tee -a $RESULTS_FILE
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
