# Assignment 4: Data Flow Analysis Framework

A comprehensive implementation of data flow analysis for the Bril intermediate language, featuring a generic solver that supports multiple analyses.

## Overview

This project implements a modular data flow analysis framework with three different analyses:

1. **Live Variables Analysis** - Identifies variables that are live (will be used in the future)
2. **Reaching Definitions Analysis** - Tracks which definitions reach each program point
3. **Definitely Initialized Variables Analysis** - Java-style definite assignment checking

## Usage

### Basic Usage

```bash
# Run all analyses (default)
cat program.bril | bril2json | python3 main.py

# Run specific analysis
cat program.bril | bril2json | python3 main.py --analysis live
cat program.bril | bril2json | python3 main.py --analysis reach
cat program.bril | bril2json | python3 main.py --analysis init
```

### Output Format

```
Function: main
==============

=== Live Variables ===
[B0] IN=∅  OUT={a, b}
[B1] IN={a, b}  OUT={c, d}

=== Reaching Definitions ===
[B0] IN=∅  OUT={a@B0.0, b@B0.1}
[B1] IN={a@B0.0, b@B0.1}  OUT={a@B0.0, b@B0.1, c@B1.0}

=== Definitely Initialized Variables ===
[B0] IN=∅  OUT={a, b}
[B1] IN={a, b}  OUT={a, b, c}

❌ Definite Uninitialized Variable Uses:
  B0.1: Variable 'x' used in 'y = add x five'
```

## Testing

### Running Tests

```bash
# Run the test suite
python3 test_runner.py

# Test individual files
cat tests/branch.bril | python3 -m bril2json | python3 main.py
```

### Test Coverage

Our test suite covers:

- **Linear Control Flow** - Simple sequential programs
- **Conditional Branches** - If-then-else constructs
- **Loops** - While loops and iteration
- **Dead Code** - Unreachable and unused code
- **Error Cases** - Uninitialized variable usage

### Expected Outputs

The test runner validates that:
- All analyses complete without errors
- Control flow is handled correctly
- Fixpoint convergence occurs for loops
- Error detection works for uninitialized variables

## Analysis Details

### Live Variables Analysis

**Purpose**: Identify variables that will be used in the future
**Direction**: Backward
**Use Case**: Dead code elimination, register allocation


### Reaching Definitions Analysis

**Purpose**: Track which definitions reach each program point
**Direction**: Forward
**Use Case**: Constant propagation, optimization

### Definitely Initialized Variables Analysis

**Purpose**: Java-style definite assignment checking
**Direction**: Forward
**Use Case**: Compile-time error detection, static analysis