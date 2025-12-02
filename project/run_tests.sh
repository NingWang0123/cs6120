#!/bin/bash

# Script to test the loop parallelization pass

set -e

# Use Homebrew LLVM tools
LLVM_DIR="/opt/homebrew/opt/llvm/bin"
CLANG="${CLANG:-${LLVM_DIR}/clang}"
OPT="${OPT:-${LLVM_DIR}/opt}"
LLC="${LLC:-${LLVM_DIR}/llc}"
PASS_LIB="./LoopParallelizationPass.dylib"

echo "=========================================="
echo "Testing Loop Parallelization Pass"
echo "=========================================="

# Check if pass library exists
if [ ! -f "$PASS_LIB" ]; then
    echo "Error: Pass library not found. Please run 'make build' first."
    exit 1
fi

# Create output directory
mkdir -p output

# Test 1: Simple array operations
echo ""
echo "Test 1: Simple Array Addition"
echo "------------------------------"
$CLANG -S -emit-llvm -O1 tests/test_simple.c -o output/test_simple.ll
echo "Original IR generated: output/test_simple.ll"

$OPT -passes="loop-simplify,loop-parallelize" -load-pass-plugin="$PASS_LIB" \
    -enable-loop-parallel=true output/test_simple.ll -S -o output/test_simple_parallel.ll
echo "Parallelized IR: output/test_simple_parallel.ll"

# Compile both versions
$CLANG output/test_simple.ll -o output/test_simple_orig -fopenmp
$CLANG output/test_simple_parallel.ll -o output/test_simple_parallel -fopenmp

echo "Running original version..."
./output/test_simple_orig

echo ""
echo "Running parallelized version..."
./output/test_simple_parallel

# Test 2: Matrix operations
echo ""
echo "Test 2: Matrix Multiplication"
echo "------------------------------"
$CLANG -S -emit-llvm -O1 tests/test_matrix.c -o output/test_matrix.ll
echo "Original IR generated: output/test_matrix.ll"

$OPT -passes="loop-simplify,loop-parallelize" -load-pass-plugin="$PASS_LIB" \
    -enable-loop-parallel=true output/test_matrix.ll -S -o output/test_matrix_parallel.ll
echo "Parallelized IR: output/test_matrix_parallel.ll"

$CLANG output/test_matrix.ll -o output/test_matrix_orig -fopenmp
$CLANG output/test_matrix_parallel.ll -o output/test_matrix_parallel -fopenmp

echo "Running original version..."
./output/test_matrix_orig

echo ""
echo "Running parallelized version..."
./output/test_matrix_parallel

# Test 3: Reduction (should not parallelize)
echo ""
echo "Test 3: Reduction Test"
echo "----------------------"
$CLANG -S -emit-llvm -O1 tests/test_reduction.c -o output/test_reduction.ll
echo "Original IR generated: output/test_reduction.ll"

$OPT -passes="loop-simplify,loop-parallelize" -load-pass-plugin="$PASS_LIB" \
    -enable-loop-parallel=true output/test_reduction.ll -S -o output/test_reduction_parallel.ll
echo "Parallelized IR: output/test_reduction_parallel.ll"

$CLANG output/test_reduction.ll -o output/test_reduction_orig -fopenmp
$CLANG output/test_reduction_parallel.ll -o output/test_reduction_parallel -fopenmp

echo "Running original version..."
./output/test_reduction_orig

echo ""
echo "Running parallelized version..."
./output/test_reduction_parallel

echo ""
echo "=========================================="
echo "All tests completed!"
echo "=========================================="
echo "Check output/ directory for generated IR files"
