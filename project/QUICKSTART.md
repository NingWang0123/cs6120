# Quick Start Guide

## 5-Minute Setup and Demo

### Step 1: Install Dependencies (if not already installed)

```bash
brew install llvm libomp
```

### Step 2: Build the Pass

```bash
cd /path/to/project
make build
```

Expected output:
```
[100%] Built target LoopParallelizationPass
Build complete: LoopParallelizationPass.dylib
```

### Step 3: Run the Demo

```bash
# Compile and test the manual OpenMP demonstration
/opt/homebrew/opt/llvm/bin/clang -O2 tests/manual_parallel.c \
    -o demo -fopenmp \
    -L/opt/homebrew/opt/libomp/lib \
    -I/opt/homebrew/opt/libomp/include

# Run serial version
echo "=== Serial ===" && ./demo 0

# Run parallel version with 4 threads
echo "=== Parallel (4 threads) ===" && OMP_NUM_THREADS=4 ./demo 1
```

Expected results:
```
=== Serial ===
Running SERIAL version
Serial time: ~0.046 seconds

=== Parallel (4 threads) ===
Running PARALLEL version with 4 threads
Parallel time: ~0.012 seconds
```

**Speedup: ~3.7x on 4 cores!**

### Step 4: Test the LLVM Pass

```bash
# Generate LLVM IR
/opt/homebrew/opt/llvm/bin/clang -S -emit-llvm -O1 \
    tests/test_simple.c -o test.ll

# Apply the parallelization pass
/opt/homebrew/opt/llvm/bin/opt \
    -passes="loop-simplify,loop-parallelize" \
    -load-pass-plugin=./LoopParallelizationPass.dylib \
    -enable-loop-parallel=true \
    test.ll -S -o test_parallel.ll
```

Expected output:
```
Found parallelizable loop in function: array_add
Found parallelizable loop in function: main
```

## What Just Happened?

1. **Built an LLVM pass** that detects parallelizable loops using `LoopAccessAnalysis`
2. **Demonstrated OpenMP parallelization** with 3.7x speedup on simple array operations
3. **Ran the pass** and confirmed it detects parallelizable loops correctly

## Next Steps

- Read [README.md](README.md) for full documentation
- Read [PROJECT_SUMMARY.md](PROJECT_SUMMARY.md) for technical details
- Explore the source code in `src/LoopParallelizationPass.cpp`
- Try the pass on your own C code!

## Common Issues

### Issue: "Command not found: clang" or "Command not found: opt"

**Solution**: Use the full path to LLVM tools:
```bash
/opt/homebrew/opt/llvm/bin/clang
/opt/homebrew/opt/llvm/bin/opt
```

### Issue: OpenMP library not found

**Solution**: Install libomp and add library paths:
```bash
brew install libomp
export LDFLAGS="-L/opt/homebrew/opt/libomp/lib"
export CPPFLAGS="-I/opt/homebrew/opt/libomp/include"
```

### Issue: Pass doesn't load

**Solution**: Check that the .dylib file exists:
```bash
ls -lh LoopParallelizationPass.dylib
```

If not, rebuild:
```bash
make clean && make build
```

## Performance Tips

For best parallel performance:
- Use large data sizes (N > 1,000,000)
- Set thread count to match your CPU cores: `OMP_NUM_THREADS=4`
- Use `-O2` or `-O3` optimization levels
- Test with different thread counts to find optimal configuration

## Questions?

Check the [README.md](README.md) for detailed information about:
- How the pass works internally
- What loops can be parallelized
- Performance characteristics
- Limitations and future work
