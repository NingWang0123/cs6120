#!/bin/bash

echo "Running benchmarks..."
echo

# Run original version 10 times
echo "Original -O0:"
total=0
for i in {1..10}; do
    time=$(./bench_O0_orig 2>&1 | grep "Elapsed" | awk '{print $3}')
    echo "  Run $i: $time seconds"
    total=$(echo "$total + $time" | bc)
done
avg_orig=$(echo "scale=6; $total / 10" | bc)
echo "  Average: $avg_orig seconds"
echo

# Run optimized version 10 times
echo "Optimized -O0:"
total=0
for i in {1..10}; do
    time=$(./bench_O0_opt 2>&1 | grep "Elapsed" | awk '{print $3}')
    echo "  Run $i: $time seconds"
    total=$(echo "$total + $time" | bc)
done
avg_opt=$(echo "scale=6; $total / 10" | bc)
echo "  Average: $avg_opt seconds"
echo

# Calculate speedup
speedup=$(echo "scale=4; $avg_orig / $avg_opt" | bc)
improvement=$(echo "scale=2; ($avg_orig - $avg_opt) / $avg_orig * 100" | bc)

echo "Summary:"
echo "  Original average: $avg_orig seconds"
echo "  Optimized average: $avg_opt seconds"
echo "  Speedup: ${speedup}x"
echo "  Improvement: ${improvement}%"
