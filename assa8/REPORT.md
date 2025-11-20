### Team Members
Ning Wang (nw366), Jiale Lao (jl4492)

### Source Code
https://github.com/NingWang0123/cs6120/tree/main/assa8

## Implementation Summary

We implemented **Loop Invariant Code Motion (LICM)**, a classic loop optimization that hoists loop-invariant computations out of loops to reduce redundant work. The implementation works on Bril programs in SSA form.

### Key Components

- **`ssa.py`**: Converts Bril programs to SSA form using dominance frontiers for phi node placement and variable renaming.

- **`out_of_ssa.py`**: Converts programs out of SSA form using parallel copy scheduling to handle phi nodes, including cycle detection.

- **`licm.py`**: Implements the LICM optimization with the following steps:
  1. Convert function to SSA form
  2. Find natural loops using back-edge detection in the dominator tree
  3. Ensure each loop has a unique preheader block
  4. Identify loop-invariant instructions (pure operations with all operands defined outside the loop)
  5. Hoist instructions that dominate all loop exits to the preheader
  6. Convert back out of SSA form

- **`helpers.py`**: Provides CFG construction, dominance analysis, and utility functions

- **`main.py`**: Driver program that applies LICM to Bril programs

## Testing Methodology

We tested the implementation on programs from the Bril benchmark suite (`bril/benchmarks/core/`) that contain loop-invariant computations suitable for LICM optimization. Our testing approach includes:

1. **Correctness Verification**: Compare output of original vs optimized programs to ensure semantic equivalence
2. **Dynamic Instruction Counting**: Use brili's profiling mode to measure actual instruction execution counts
3. **Performance Measurement**: Calculate speedup as `original_instructions / optimized_instructions`

## Evaluation Results

We successfully optimized **8 benchmark programs** that contain loop-invariant computations. All optimizations preserved program correctness while achieving measurable performance improvements.

### Benchmark Results

| Program | Dynamic Instructions Saved | Speedup | Description |
|---------|---------------------------|---------|-------------|
| **quadratic.bril** | **76** | **1.107x** | Quadratic formula in loop with constant computations |
| **sum-sq-diff.bril** | **199** | **1.070x** | Sum of squares computation with invariant operations |
| **sum-to-ten.bril** | **10** | **1.075x** | Simple counting loop with hoistable arithmetic |
| loopfact.bril | 7 | 1.064x | Factorial with loop-invariant comparisons |
| check-primes.bril | 364 | 1.045x | Prime checking with repeated computations |
| sum-digits.bril | 9 | 1.043x | Digit extraction with invariant operations |
| pascals-row.bril | 4 | 1.028x | Pascal's triangle row generation |
| permutation.bril | 2 | 1.016x | Permutation counting |

**Aggregate Performance:**
- **Total Dynamic Instructions Saved**: 671 instructions
- **Average Speedup**: 1.056x (5.6% improvement)
- **Best Speedup**: 1.107x on quadratic.bril (10.7% improvement)
- **Speedup Range**: 1.016x to 1.107x

## Challenges
We selected to use Bril so there are not many challenges when implementating these codes: we are already familiar with Bril.
Reviewing other discussions about LLVM, seems like this modern compiler is both complex and elegant.
Next time we should try to implement these functions in LLVM.

## Visualizations Using GenAI

We generated a visualization of the LICM optimization results:

### Speedup Comparison 
Shows the speedup achieved for each of the 8 successfully optimized programs, with:
- Horizontal bar charts comparing speedup ratios
- Dynamic instruction reduction for each program
- Best performer: quadratic.bril at 1.107x speedup

### Michelin Star

We have correct implementations, comprehensive tests, evaluations, and visualizations. We think we deserve a michelin star. 