#!/bin/bash

# PolyBench evaluation script - Compare 4 implementations
# Tests with 2, 4, and 8 threads against serial baseline

set -euo pipefail

LLVM_DIR="/opt/homebrew/opt/llvm/bin"
CLANG="${CLANG:-${LLVM_DIR}/clang}"
OPT="${OPT:-${LLVM_DIR}/opt}"

# macOS SDK (fix missing std headers / wrong sysroot)
SDKROOT="$(xcrun --show-sdk-path)"

POLYBENCH_DIR="./polybench"
UTILITIES_DIR="$POLYBENCH_DIR/utilities"
RESULTS_DIR="polybench_results"
THREAD_COUNTS=(2 4 8)

# Color output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m'

echo -e "${CYAN}========================================${NC}"
echo -e "${CYAN}  PolyBench Implementation Comparison${NC}"
echo -e "${CYAN}========================================${NC}"
echo ""

# Check dependencies
if [ ! -d "$POLYBENCH_DIR" ]; then
    echo -e "${RED}Error: PolyBench not found.${NC}"
    echo "Clone it with: git clone https://github.com/MatthiasJReisinger/PolyBenchC-4.2.1.git polybench"
    exit 1
fi

# Create output directories
rm -rf "$RESULTS_DIR"
mkdir -p "$RESULTS_DIR"

# Find all benchmark C files
BENCHMARK_FILES=()
while IFS= read -r line; do
    BENCHMARK_FILES+=("$line")
done < <(find "$POLYBENCH_DIR" -name "*.c" -type f | \
    grep -v polybench.c | grep -v template | grep -v ".orig" | sort)

echo -e "Found ${YELLOW}${#BENCHMARK_FILES[@]}${NC} PolyBench benchmarks"
echo ""

# ------------------------------------------------------------------------------
# Step 1: Build all implementations
# ------------------------------------------------------------------------------

echo -e "${YELLOW}Step 1: Building implementations${NC}"
echo ""

build_implementation() {
    local name=$1
    local src_file=$2
    local output_file=$3

    echo -e "${BLUE}Building: ${name}${NC}"
    # Point CMake to the right pass source
    sed -i '' "s|src/LoopParallelizationPass.*\.cpp|${src_file}|g" CMakeLists.txt

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

BUILD_SUCCESS=0

# Original
if build_implementation \
    "Original (No Fusion)" \
    "src/LoopParallelizationPass.cpp" \
    "pass_original"; then
    ORIGINAL_BUILT=1
    BUILD_SUCCESS=$((BUILD_SUCCESS + 1))
else
    ORIGINAL_BUILT=0
fi

# Fusion
if build_implementation \
    "With Loop Fusion" \
    "src/LoopParallelizationPass_with_fusion.cpp" \
    "pass_fusion"; then
    FUSION_BUILT=1
    BUILD_SUCCESS=$((BUILD_SUCCESS + 1))
else
    FUSION_BUILT=0
fi

# Fusion + Shared
if build_implementation \
    "Fusion + Shared Builder" \
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

# ------------------------------------------------------------------------------
# Step 2: Compiling and running benchmarks
# ------------------------------------------------------------------------------

echo -e "${YELLOW}Step 2: Compiling and running benchmarks${NC}"
echo ""

# CSV header (added fusion columns)
echo "benchmark,implementation,serial_time,parallel_2t,speedup_2t,parallel_4t,speedup_4t,parallel_8t,speedup_8t,parallelizable_loops,fusion_succeeded_pairs,fusion_candidates,fusion_attempts" > "${RESULTS_DIR}/results.csv"

run_benchmark() {
    local benchmark_file=$1
    local pass_name=$2
    local pass_file=$3
    local impl_name=$4
    local enable_fusion=$5

    local benchmark_name
    benchmark_name=$(basename "$benchmark_file" .c)

    # ------------------------------------------------------------------
    # 1) Compile serial version (no pass) with correct SDK
    # ------------------------------------------------------------------
    "${CLANG}" -isysroot "${SDKROOT}" -O2 \
        -I"${UTILITIES_DIR}" -DPOLYBENCH_TIME -DSMALL_DATASET \
        "${UTILITIES_DIR}/polybench.c" "$benchmark_file" \
        -o "${RESULTS_DIR}/${benchmark_name}_serial" -lm 2>/dev/null

    if [ ! -f "${RESULTS_DIR}/${benchmark_name}_serial" ]; then
        return 1
    fi

    # Run serial version (3 times, average)
    serial_sum=0
    serial_runs=0
    for run in {1..3}; do
        if output=$("${RESULTS_DIR}/${benchmark_name}_serial" 2>&1); then
            time_val=$(echo "$output" | grep -oE '[0-9]+\.[0-9]+' | head -1)
            if [ -n "$time_val" ]; then
                serial_sum=$(echo "$serial_sum + $time_val" | bc)
                serial_runs=$((serial_runs + 1))
            fi
        fi
    done

    if [ $serial_runs -eq 0 ]; then
        serial_time="N/A"
    else
        serial_time=$(echo "scale=6; $serial_sum / $serial_runs" | bc)
    fi

    # ------------------------------------------------------------------
    # 2) Generate LLVM IR for benchmark file only
    # ------------------------------------------------------------------
    if ! "${CLANG}" -isysroot "${SDKROOT}" -S -emit-llvm -O2 \
        -I"${UTILITIES_DIR}" -DPOLYBENCH_TIME -DSMALL_DATASET \
        "$benchmark_file" \
        -o "${RESULTS_DIR}/${benchmark_name}.ll" \
        2>"${RESULTS_DIR}/${benchmark_name}_ir.log"; then
        echo "${benchmark_name},${impl_name},${serial_time},N/A,N/A,N/A,N/A,N/A,N/A,0,0,0,0" >> "${RESULTS_DIR}/results.csv"
        return 1
    fi

    # ------------------------------------------------------------------
    # 3) Apply parallelization pass with proper fusion flag
    # ------------------------------------------------------------------
    "${OPT}" -passes="loop-simplify,loop-parallelize" \
        -load-pass-plugin="${pass_file}" \
        -enable-loop-parallel=true \
        -enable-loop-fusion="${enable_fusion}" \
        "${RESULTS_DIR}/${benchmark_name}.ll" \
        -S -o "${RESULTS_DIR}/${benchmark_name}_${pass_name}_parallel.ll" \
        2>"${RESULTS_DIR}/${benchmark_name}_${pass_name}_pass.log"

    pass_log="${RESULTS_DIR}/${benchmark_name}_${pass_name}_pass.log"

    # Count parallelizable loops
    loop_count=$(grep -c "Found parallelizable loop" \
        "$pass_log" 2>/dev/null || echo "0")

    # NEW: Fusion metrics from unambiguous markers
    fusion_succeeded_pairs=$(grep -c '^FUSION_APPLIED ' "$pass_log" 2>/dev/null || echo "0")
    fusion_candidates=$(grep -m1 '^LOOP_FUSION_SUMMARY ' "$pass_log" | sed -n 's/.*candidates=\([0-9]\+\).*/\1/p')
    fusion_attempts=$(grep -m1 '^LOOP_FUSION_SUMMARY ' "$pass_log" | sed -n 's/.*attempts=\([0-9]\+\).*/\1/p')
    fusion_candidates=${fusion_candidates:-0}
    fusion_attempts=${fusion_attempts:-0}

    # ------------------------------------------------------------------
    # 4) Compile parallel version (with PolyBench utilities, OpenMP, SDK)
    # ------------------------------------------------------------------
    "${CLANG}" -isysroot "${SDKROOT}" -O2 \
        -I"${UTILITIES_DIR}" -DPOLYBENCH_TIME -DSMALL_DATASET \
        "${RESULTS_DIR}/${benchmark_name}_${pass_name}_parallel.ll" \
        "${UTILITIES_DIR}/polybench.c" \
        -o "${RESULTS_DIR}/${benchmark_name}_${pass_name}_parallel" \
        -fopenmp -L/opt/homebrew/opt/libomp/lib -lm \
        2>"${RESULTS_DIR}/${benchmark_name}_${pass_name}_compile.log"

    if [ ! -f "${RESULTS_DIR}/${benchmark_name}_${pass_name}_parallel" ]; then
        echo "${benchmark_name},${impl_name},${serial_time},N/A,N/A,N/A,N/A,N/A,N/A,${loop_count},${fusion_succeeded_pairs},${fusion_candidates},${fusion_attempts}" >> "${RESULTS_DIR}/results.csv"
        return 1
    fi

    # ------------------------------------------------------------------
    # 5) Run parallel version for each thread count (3 runs, average)
    # ------------------------------------------------------------------
    parallel_times=()
    speedups=()

    for threads in "${THREAD_COUNTS[@]}"; do
        parallel_sum=0
        parallel_runs=0
        for run in {1..3}; do
            if output=$(OMP_NUM_THREADS=$threads "${RESULTS_DIR}/${benchmark_name}_${pass_name}_parallel" 2>&1); then
                time_val=$(echo "$output" | grep -oE '[0-9]+\.[0-9]+' | head -1)
                if [ -n "$time_val" ]; then
                    parallel_sum=$(echo "$parallel_sum + $time_val" | bc)
                    parallel_runs=$((parallel_runs + 1))
                fi
            fi
        done

        if [ $parallel_runs -eq 0 ] || [ "$serial_time" = "N/A" ]; then
            parallel_times+=("N/A")
            speedups+=("N/A")
        else
            parallel_time=$(echo "scale=6; $parallel_sum / $parallel_runs" | bc)
            parallel_times+=("$parallel_time")
            if [ "$(echo "$parallel_time > 0" | bc)" -eq 1 ]; then
                speedup=$(echo "scale=2; $serial_time / $parallel_time" | bc)
                speedups+=("$speedup")
            else
                speedups+=("N/A")
            fi
        fi
    done

    # ------------------------------------------------------------------
    # 6) Save results row (added fusion columns)
    # ------------------------------------------------------------------
    echo "${benchmark_name},${impl_name},${serial_time},${parallel_times[0]},${speedups[0]},${parallel_times[1]},${speedups[1]},${parallel_times[2]},${speedups[2]},${loop_count},${fusion_succeeded_pairs},${fusion_candidates},${fusion_attempts}" >> "${RESULTS_DIR}/results.csv"
}

# Run each benchmark with each implementation
total_benchmarks=${#BENCHMARK_FILES[@]}
current=0

for benchmark_file in "${BENCHMARK_FILES[@]}"; do
    current=$((current + 1))
    benchmark_name=$(basename "$benchmark_file" .c)

    echo -e "${CYAN}[${current}/${total_benchmarks}]${NC} ${benchmark_name}"

    # Original: no fusion
    if [ ${ORIGINAL_BUILT:-0} -eq 1 ]; then
        echo -n "  Original... "
        if run_benchmark "$benchmark_file" "original" \
            "${RESULTS_DIR}/pass_original.dylib" "Original" "false"; then
            echo -e "${GREEN}✓${NC}"
        else
            echo -e "${YELLOW}⚠${NC}"
        fi
    fi

    # Fusion: fusion enabled
    if [ ${FUSION_BUILT:-0} -eq 1 ]; then
        echo -n "  Fusion... "
        if run_benchmark "$benchmark_file" "fusion" \
            "${RESULTS_DIR}/pass_fusion.dylib" "Fusion" "true"; then
            echo -e "${GREEN}✓${NC}"
        else
            echo -e "${YELLOW}⚠${NC}"
        fi
    fi

    # Fusion+Shared: fusion enabled
    if [ ${FUSION_SHARED_BUILT:-0} -eq 1 ]; then
        echo -n "  Fusion+Shared... "
        if run_benchmark "$benchmark_file" "fusion_shared" \
            "${RESULTS_DIR}/pass_fusion_shared.dylib" "Fusion+Shared" "true"; then
            echo -e "${GREEN}✓${NC}"
        else
            echo -e "${YELLOW}⚠${NC}"
        fi
    fi

done

# ------------------------------------------------------------------------------
# Step 3: Visualization
# ------------------------------------------------------------------------------

echo ""
echo -e "${YELLOW}Step 3: Generating visualizations${NC}"
echo ""

if command -v python3 &> /dev/null; then
    echo -e "${CYAN}Running Python visualization script...${NC}"
    python3 visualize_polybench.py
    if [ $? -eq 0 ]; then
        echo -e "  ${GREEN}✓ Visualizations created${NC}"
    else
        echo -e "  ${YELLOW}⚠ Visualization script encountered issues${NC}"
    fi
else
    echo -e "  ${YELLOW}⚠ Python3 not found. Skipping visualizations.${NC}"
fi

echo -e "${CYAN}Analyzing whether fusion helped...${NC}"
python3 analyze_fusion_help.py || true

echo ""
echo -e "${CYAN}========================================${NC}"
echo -e "${CYAN}      Evaluation Complete!${NC}"
echo -e "${CYAN}========================================${NC}"
echo ""
echo -e "Results saved in: ${YELLOW}${RESULTS_DIR}/${NC}"
echo ""
echo "Generated files:"
echo "  - results.csv          : All benchmark results"
echo "  - pass_*.dylib         : Built implementations"
echo "  - *_pass.log           : Pass execution logs"
echo "  - *.png                : Visualization charts"
echo ""
