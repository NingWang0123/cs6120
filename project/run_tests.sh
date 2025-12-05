#!/bin/bash

# Benchmark script for comparing all 3 loop parallelization implementations
# Tests with 2, 4, and 8 threads against serial baseline

set -e

LLVM_DIR="/opt/homebrew/opt/llvm/bin"
CLANG="${CLANG:-${LLVM_DIR}/clang}"
OPT="${OPT:-${LLVM_DIR}/opt}"
RESULTS_DIR="tests_results"
THREAD_COUNTS=(2 4 8)
ITERATIONS=5

# Color output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m'

echo -e "${CYAN}========================================${NC}"
echo -e "${CYAN}  Loop Parallelization Benchmarks${NC}"
echo -e "${CYAN}========================================${NC}"
echo ""
echo -e "Configuration:"
echo -e "  Iterations per test: ${YELLOW}${ITERATIONS}${NC}"
echo -e "  Thread counts: ${YELLOW}${THREAD_COUNTS[@]}${NC}"
echo -e "  Implementations: ${YELLOW}3${NC} (Original, Fusion, Fusion+Shared)"
echo ""

# Create results directory
mkdir -p "$RESULTS_DIR"

# Function to build a specific implementation
build_implementation() {
    local name=$1
    local src_file=$2
    local output_file=$3

    echo -e "${BLUE}Building: ${name}${NC}"

    # Update CMakeLists.txt
    sed -i '' "s|src/LoopParallelizationPass.*\.cpp|${src_file}|g" CMakeLists.txt

    # Clean and build
    rm -rf build
    mkdir -p build
    cd build

    if cmake .. > "../${RESULTS_DIR}/build_${output_file}.log" 2>&1; then
        if make > "../${RESULTS_DIR}/make_${output_file}.log" 2>&1; then
            if [ -f "LoopParallelizationPass.dylib" ]; then
                cd ..
                cp "build/LoopParallelizationPass.dylib" "${RESULTS_DIR}/${output_file}.dylib"
                echo -e "  ${GREEN}✓ Success${NC}"
                return 0
            fi
        fi
    fi

    cd ..
    echo -e "  ${RED}✗ Build failed${NC}"
    return 1
}

# Function to compile benchmark with specific pass
compile_benchmark() {
    local pass_file=$1
    local output_prefix=$2
    local enable_parallel=$3

    # Generate LLVM IR
    ${CLANG} -S -emit-llvm -O2 tests/benchmark.c -o ${RESULTS_DIR}/benchmark.ll

    if [ "$enable_parallel" = "true" ]; then
        # Apply parallelization pass
        ${OPT} \
            -passes="loop-simplify,loop-parallelize" \
            -load-pass-plugin="./${pass_file}" \
            -enable-loop-parallel=true \
            -enable-loop-fusion=true \
            ${RESULTS_DIR}/benchmark.ll -S -o ${RESULTS_DIR}/benchmark_parallel.ll 2>/dev/null

        # Compile with OpenMP
        ${CLANG} -O2 ${RESULTS_DIR}/benchmark_parallel.ll -o "${output_prefix}" \
            -fopenmp -L/opt/homebrew/opt/libomp/lib
    else
        # Compile without parallelization (serial)
        ${CLANG} -O2 ${RESULTS_DIR}/benchmark.ll -o "${output_prefix}"
    fi
}

# Function to run benchmark and extract times
run_benchmark_once() {
    local binary=$1
    local threads=$2

    export OMP_NUM_THREADS=$threads
    output=$(./"$binary" 2>/dev/null)

    array_ops=$(echo "$output" | grep "Array ops:" | awk '{print $3}')
    scale_offset=$(echo "$output" | grep "Scale offset:" | awk '{print $3}')
    elementwise=$(echo "$output" | grep "Elementwise:" | awk '{print $2}')

    echo "$array_ops,$scale_offset,$elementwise"
}

# Function to benchmark an implementation
benchmark_implementation() {
    local name=$1
    local pass_file=$2
    local prefix=$3

    echo -e "${BLUE}Benchmarking: ${name}${NC}"

    # Compile serial version (baseline)
    echo -e "  ${CYAN}Compiling serial version...${NC}"
    compile_benchmark "$pass_file" "${RESULTS_DIR}/${prefix}_serial" "false"

    # Compile parallel version
    echo -e "  ${CYAN}Compiling parallel version...${NC}"
    compile_benchmark "$pass_file" "${RESULTS_DIR}/${prefix}_parallel" "true"

    # Run serial baseline
    echo -e "  ${CYAN}Running serial baseline (${ITERATIONS} iterations)...${NC}"
    for i in $(seq 1 $ITERATIONS); do
        times=$(run_benchmark_once "${RESULTS_DIR}/${prefix}_serial" 1)
        echo "Serial,$name,$i,1,$times" >> "${RESULTS_DIR}/raw_data.csv"
    done

    # Run parallel with different thread counts
    for threads in "${THREAD_COUNTS[@]}"; do
        echo -e "  ${CYAN}Running parallel with ${threads} threads (${ITERATIONS} iterations)...${NC}"
        for i in $(seq 1 $ITERATIONS); do
            times=$(run_benchmark_once "${RESULTS_DIR}/${prefix}_parallel" $threads)
            echo "Parallel,$name,$i,$threads,$times" >> "${RESULTS_DIR}/raw_data.csv"
        done
    done

    echo -e "  ${GREEN}✓ Benchmarking completed${NC}"
    echo ""
}

echo -e "${YELLOW}Step 1: Building all implementations${NC}"
echo ""

BUILD_SUCCESS=0

if build_implementation \
    "Original (No Fusion)" \
    "src/LoopParallelizationPass.cpp" \
    "pass_original"; then
    ORIGINAL_BUILT=1
    BUILD_SUCCESS=$((BUILD_SUCCESS + 1))
else
    ORIGINAL_BUILT=0
fi

echo ""

if build_implementation \
    "With Loop Fusion" \
    "src/LoopParallelizationPass_with_fusion.cpp" \
    "pass_fusion"; then
    FUSION_BUILT=1
    BUILD_SUCCESS=$((BUILD_SUCCESS + 1))
else
    FUSION_BUILT=0
fi

echo ""

if build_implementation \
    "Fusion + Shared OpenMP Builder" \
    "src/LoopParallelizationPass_with_fusion_shared.cpp" \
    "pass_fusion_shared"; then
    FUSION_SHARED_BUILT=1
    BUILD_SUCCESS=$((BUILD_SUCCESS + 1))
else
    FUSION_SHARED_BUILT=0
fi

echo ""
echo -e "${CYAN}Build Summary: ${BUILD_SUCCESS}/3 succeeded${NC}"
echo ""

if [ $BUILD_SUCCESS -eq 0 ]; then
    echo -e "${RED}All builds failed. Exiting.${NC}"
    exit 1
fi

echo -e "${YELLOW}Step 2: Running benchmarks${NC}"
echo ""

# Initialize CSV file
echo "mode,implementation,iteration,threads,array_ops,scale_offset,elementwise" > "${RESULTS_DIR}/raw_data.csv"

BENCH_SUCCESS=0

if [ $ORIGINAL_BUILT -eq 1 ]; then
    if benchmark_implementation \
        "Original" \
        "${RESULTS_DIR}/pass_original.dylib" \
        "original"; then
        BENCH_SUCCESS=$((BENCH_SUCCESS + 1))
    fi
fi

if [ $FUSION_BUILT -eq 1 ]; then
    if benchmark_implementation \
        "Fusion" \
        "${RESULTS_DIR}/pass_fusion.dylib" \
        "fusion"; then
        BENCH_SUCCESS=$((BENCH_SUCCESS + 1))
    fi
fi

if [ $FUSION_SHARED_BUILT -eq 1 ]; then
    if benchmark_implementation \
        "Fusion+Shared" \
        "${RESULTS_DIR}/pass_fusion_shared.dylib" \
        "fusion_shared"; then
        BENCH_SUCCESS=$((BENCH_SUCCESS + 1))
    fi
fi

echo -e "${CYAN}Benchmark Summary: ${BENCH_SUCCESS}/${BUILD_SUCCESS} succeeded${NC}"
echo ""

echo -e "${YELLOW}Step 3: Generating visualizations${NC}"
echo ""

if command -v python3 &> /dev/null; then
    echo -e "${CYAN}Running Python visualization script...${NC}"
    python3 visualize_results.py
    if [ $? -eq 0 ]; then
        echo -e "  ${GREEN}✓ Visualizations created${NC}"
    else
        echo -e "  ${YELLOW}⚠ Visualization script encountered issues${NC}"
    fi
else
    echo -e "  ${YELLOW}⚠ Python3 not found. Skipping visualizations.${NC}"
    echo -e "    Install Python 3 and run: python3 visualize_results.py"
fi

echo ""
echo -e "${CYAN}========================================${NC}"
echo -e "${CYAN}      Benchmarks Complete!${NC}"
echo -e "${CYAN}========================================${NC}"
echo ""
echo -e "Results saved in: ${YELLOW}${RESULTS_DIR}/${NC}"
echo ""
echo "Generated files:"
echo "  - raw_data.csv             : Raw benchmark data"
echo "  - performance_*.png        : Visualization charts"
echo "  - performance_report.txt   : Detailed analysis"
echo ""
