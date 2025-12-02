#!/bin/bash

# PolyBench evaluation script - ALL benchmarks

set -e

LLVM_DIR="/opt/homebrew/opt/llvm/bin"
CLANG="${CLANG:-${LLVM_DIR}/clang}"
OPT="${OPT:-${LLVM_DIR}/opt}"
PASS_LIB="./LoopParallelizationPass.dylib"
POLYBENCH_DIR="./polybench"
UTILITIES_DIR="$POLYBENCH_DIR/utilities"

echo "=========================================="
echo "PolyBench Loop Parallelization Evaluation"
echo "=========================================="

# Check dependencies
if [ ! -f "$PASS_LIB" ]; then
    echo "Error: Pass library not found. Run 'make build' first."
    exit 1
fi

if [ ! -d "$POLYBENCH_DIR" ]; then
    echo "Error: PolyBench not found. Run git clone first."
    exit 1
fi

# Create output directories
mkdir -p polybench_results
mkdir -p polybench_output

# Find all benchmark C files (exclude utilities and templates)
BENCHMARK_FILES=()
while IFS= read -r line; do
    BENCHMARK_FILES+=("$line")
done < <(find "$POLYBENCH_DIR" -name "*.c" -type f | \
    grep -v polybench.c | grep -v template | grep -v ".orig" | sort)

echo "Found ${#BENCHMARK_FILES[@]} benchmarks"
echo ""

# Results files
RESULTS_FILE="polybench_results/results.txt"
CSV_FILE="polybench_results/results.csv"

echo "PolyBench Loop Parallelization Results" > $RESULTS_FILE
echo "Date: $(date)" >> $RESULTS_FILE
echo "Total Benchmarks: ${#BENCHMARK_FILES[@]}" >> $RESULTS_FILE
echo "=========================================" >> $RESULTS_FILE
echo "" >> $RESULTS_FILE

echo "Benchmark,Parallelizable Loops,Serial Time (s),Parallel 1T (s),Speedup 1T,Parallel 2T (s),Speedup 2T,Parallel 4T (s),Speedup 4T,Parallel 8T (s),Speedup 8T" > $CSV_FILE

# Counters
total=0
successful=0
parallelized=0

for c_file in "${BENCHMARK_FILES[@]}"; do
    total=$((total + 1))

    # Extract benchmark name and category
    bench_name=$(basename "$c_file" .c)
    bench_dir=$(dirname "$c_file")
    category=$(echo "$bench_dir" | sed "s|$POLYBENCH_DIR/||" | cut -d'/' -f1)

    echo "[$total/${#BENCHMARK_FILES[@]}] $category/$bench_name"
    echo "-------------------------------------------"

    # Compile serial version
    echo "  [1/6] Compiling serial..."
    if ! $CLANG -O2 -I"$UTILITIES_DIR" -DPOLYBENCH_TIME \
        -DSMALL_DATASET \
        "$c_file" "$UTILITIES_DIR/polybench.c" \
        -o "polybench_output/${bench_name}_serial" \
        -lm 2>"polybench_output/${bench_name}_serial.err"; then
        echo "  ✗ Serial compilation failed"
        echo "$bench_name: COMPILE_ERROR" >> $RESULTS_FILE
        echo "$bench_name,0,0,0,0" >> $CSV_FILE
        echo ""
        continue
    fi

    # Generate LLVM IR (only for benchmark file)
    echo "  [2/6] Generating IR..."
    if ! $CLANG -S -emit-llvm -O2 -I"$UTILITIES_DIR" -DPOLYBENCH_TIME \
        -DSMALL_DATASET \
        "$c_file" \
        -o "polybench_output/${bench_name}.ll" \
        2>"polybench_output/${bench_name}_ir.err"; then
        echo "  ✗ IR generation failed"
        continue
    fi

    # Compile polybench utility separately
    if ! $CLANG -c -O2 -I"$UTILITIES_DIR" -DPOLYBENCH_TIME \
        "$UTILITIES_DIR/polybench.c" \
        -o "polybench_output/polybench.o" \
        2>/dev/null; then
        echo "  ✗ Utility compilation failed"
        continue
    fi

    # Apply parallelization pass
    echo "  [3/6] Applying pass..."
    $OPT -passes="loop-simplify,loop-parallelize" \
        -load-pass-plugin="$PASS_LIB" \
        -enable-loop-parallel=true -enable-loop-fusion=true \
        "polybench_output/${bench_name}.ll" \
        -S -o "polybench_output/${bench_name}_parallel.ll" \
        2>&1 | tee "polybench_output/${bench_name}_pass.log" | \
        grep -E "(Found|Fused)" || true

    # Count parallelizable loops
    loop_count=$(grep -c "Found parallelizable loop" \
        "polybench_output/${bench_name}_pass.log" 2>/dev/null || echo "0")
    loop_count=$(echo "$loop_count" | tr -d '\n\r ')

    if [ "$loop_count" -gt 0 ]; then
        parallelized=$((parallelized + 1))
        echo "  ✓ Found $loop_count parallelizable loops"
    else
        echo "  - No parallelizable loops found"
    fi

    # Compile parallel version (link with polybench.o)
    echo "  [4/6] Compiling parallel..."
    if ! $CLANG -O2 "polybench_output/${bench_name}_parallel.ll" \
        "polybench_output/polybench.o" \
        -o "polybench_output/${bench_name}_parallel" \
        -fopenmp -L/opt/homebrew/opt/libomp/lib -lm \
        2>"polybench_output/${bench_name}_parallel.err"; then
        echo "  ✗ Parallel compilation failed"
        echo "$bench_name: PARALLEL_COMPILE_ERROR (loops: $loop_count)" >> $RESULTS_FILE
        echo "$bench_name,$loop_count,0,0,0" >> $CSV_FILE
        echo ""
        continue
    fi

    # Run serial version (3 times, take average)
    echo "  [5/6] Running serial (3 runs)..."
    serial_sum=0
    serial_runs=0
    for run in {1..3}; do
        if output=$("polybench_output/${bench_name}_serial" 2>&1); then
            time_val=$(echo "$output" | grep -oE '[0-9]+\.[0-9]+' | head -1)
            if [ -n "$time_val" ]; then
                serial_sum=$(echo "$serial_sum + $time_val" | bc)
                serial_runs=$((serial_runs + 1))
            fi
        fi
    done

    if [ $serial_runs -eq 0 ]; then
        echo "  ✗ Serial execution failed"
        echo "$bench_name: SERIAL_RUN_ERROR" >> $RESULTS_FILE
        echo "$bench_name,$loop_count,0,0,0" >> $CSV_FILE
        echo ""
        continue
    fi

    serial_time=$(echo "scale=6; $serial_sum / $serial_runs" | bc)
    echo "    Serial: ${serial_time}s"

    # Run parallel version with different thread counts
    echo "  [6/6] Running parallel (3 runs per thread count)..."

    # Run with 1 thread
    parallel_sum=0
    parallel_runs=0
    for run in {1..3}; do
        if output=$(OMP_NUM_THREADS=1 "polybench_output/${bench_name}_parallel" 2>&1); then
            time_val=$(echo "$output" | grep -oE '[0-9]+\.[0-9]+' | head -1)
            if [ -n "$time_val" ]; then
                parallel_sum=$(echo "$parallel_sum + $time_val" | bc)
                parallel_runs=$((parallel_runs + 1))
            fi
        fi
    done
    parallel_time_1t=$([ $parallel_runs -eq 0 ] && echo "0" || echo "scale=6; $parallel_sum / $parallel_runs" | bc)
    speedup_1t=$([ "$parallel_time_1t" = "0" ] && echo "0" || echo "scale=2; $serial_time / $parallel_time_1t" | bc)
    echo "    1T: ${parallel_time_1t}s (${speedup_1t}x)"

    # Run with 2 threads
    parallel_sum=0
    parallel_runs=0
    for run in {1..3}; do
        if output=$(OMP_NUM_THREADS=2 "polybench_output/${bench_name}_parallel" 2>&1); then
            time_val=$(echo "$output" | grep -oE '[0-9]+\.[0-9]+' | head -1)
            if [ -n "$time_val" ]; then
                parallel_sum=$(echo "$parallel_sum + $time_val" | bc)
                parallel_runs=$((parallel_runs + 1))
            fi
        fi
    done
    parallel_time_2t=$([ $parallel_runs -eq 0 ] && echo "0" || echo "scale=6; $parallel_sum / $parallel_runs" | bc)
    speedup_2t=$([ "$parallel_time_2t" = "0" ] && echo "0" || echo "scale=2; $serial_time / $parallel_time_2t" | bc)
    echo "    2T: ${parallel_time_2t}s (${speedup_2t}x)"

    # Run with 4 threads
    parallel_sum=0
    parallel_runs=0
    for run in {1..3}; do
        if output=$(OMP_NUM_THREADS=4 "polybench_output/${bench_name}_parallel" 2>&1); then
            time_val=$(echo "$output" | grep -oE '[0-9]+\.[0-9]+' | head -1)
            if [ -n "$time_val" ]; then
                parallel_sum=$(echo "$parallel_sum + $time_val" | bc)
                parallel_runs=$((parallel_runs + 1))
            fi
        fi
    done
    parallel_time_4t=$([ $parallel_runs -eq 0 ] && echo "0" || echo "scale=6; $parallel_sum / $parallel_runs" | bc)
    speedup_4t=$([ "$parallel_time_4t" = "0" ] && echo "0" || echo "scale=2; $serial_time / $parallel_time_4t" | bc)
    echo "    4T: ${parallel_time_4t}s (${speedup_4t}x)"

    # Run with 8 threads
    parallel_sum=0
    parallel_runs=0
    for run in {1..3}; do
        if output=$(OMP_NUM_THREADS=8 "polybench_output/${bench_name}_parallel" 2>&1); then
            time_val=$(echo "$output" | grep -oE '[0-9]+\.[0-9]+' | head -1)
            if [ -n "$time_val" ]; then
                parallel_sum=$(echo "$parallel_sum + $time_val" | bc)
                parallel_runs=$((parallel_runs + 1))
            fi
        fi
    done
    parallel_time_8t=$([ $parallel_runs -eq 0 ] && echo "0" || echo "scale=6; $parallel_sum / $parallel_runs" | bc)
    speedup_8t=$([ "$parallel_time_8t" = "0" ] && echo "0" || echo "scale=2; $serial_time / $parallel_time_8t" | bc)
    echo "    8T: ${parallel_time_8t}s (${speedup_8t}x)"

    successful=$((successful + 1))

    # Log results
    echo "$bench_name:" >> $RESULTS_FILE
    echo "  Category: $category" >> $RESULTS_FILE
    echo "  Parallelizable loops: $loop_count" >> $RESULTS_FILE
    echo "  Serial: ${serial_time}s" >> $RESULTS_FILE
    echo "  Parallel (1T): ${parallel_time_1t}s (${speedup_1t}x)" >> $RESULTS_FILE
    echo "  Parallel (2T): ${parallel_time_2t}s (${speedup_2t}x)" >> $RESULTS_FILE
    echo "  Parallel (4T): ${parallel_time_4t}s (${speedup_4t}x)" >> $RESULTS_FILE
    echo "  Parallel (8T): ${parallel_time_8t}s (${speedup_8t}x)" >> $RESULTS_FILE
    echo "" >> $RESULTS_FILE

    echo "$bench_name,$loop_count,$serial_time,$parallel_time_1t,$speedup_1t,$parallel_time_2t,$speedup_2t,$parallel_time_4t,$speedup_4t,$parallel_time_8t,$speedup_8t" >> $CSV_FILE
    echo ""
done

# Summary
echo "=========================================="
echo "Evaluation Complete!"
echo "=========================================="
echo "Total benchmarks: $total"
echo "Successfully run: $successful"
echo "With parallelizable loops: $parallelized"
echo ""
echo "Results saved to:"
echo "  - $RESULTS_FILE (detailed)"
echo "  - $CSV_FILE (CSV format)"
echo ""

# Generate summary statistics
echo "" >> $RESULTS_FILE
echo "=========================================" >> $RESULTS_FILE
echo "Summary Statistics" >> $RESULTS_FILE
echo "=========================================" >> $RESULTS_FILE
echo "Total benchmarks: $total" >> $RESULTS_FILE
echo "Successfully run: $successful" >> $RESULTS_FILE
echo "With parallelizable loops: $parallelized" >> $RESULTS_FILE
echo "" >> $RESULTS_FILE

# Calculate average speedup for parallelized benchmarks
if [ $parallelized -gt 0 ]; then
    avg_speedup=$(awk -F',' 'NR>1 && $2>0 && $5>0 {sum+=$5; count++} END {if(count>0) printf "%.2f", sum/count; else print "0"}' "$CSV_FILE")
    echo "Average speedup (parallelized only): ${avg_speedup}x" >> $RESULTS_FILE
    echo "Average speedup (parallelized): ${avg_speedup}x"
fi

echo ""
echo "To visualize results: python3 visualize_polybench.py"
