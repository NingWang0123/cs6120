#!/usr/bin/env python3
"""
Comprehensive evaluation script for trace-based speculation optimizer.
Tests multiple benchmarks with different inputs to evaluate correctness and performance.
"""

import json
import subprocess
import sys
from pathlib import Path

# Test configurations: (benchmark_file, trace_input, test_inputs)
TESTS = [
    {
        "name": "grad_desc",
        "file": "grad_desc.bril",
        "trace_args": {"w": 6000, "t": 2000, "lr": 100, "steps": 20},
        "test_cases": [
            {"w": 6000, "t": 2000, "lr": 100, "steps": 20},  # Same as trace
            {"w": 8000, "t": 3000, "lr": 150, "steps": 30},  # Different input
        ]
    },
    {
        "name": "loopfact",
        "file": "/Users/jl4492/Projects/cs6120/bril/benchmarks/core/loopfact.bril",
        "trace_args": {"input": 8},
        "test_cases": [
            {"input": 8},   # Same as trace
            {"input": 12},  # Different input
            {"input": 5},   # Smaller input
        ]
    },
    {
        "name": "collatz",
        "file": "/Users/jl4492/Projects/cs6120/bril/benchmarks/core/collatz.bril",
        "trace_args": {"x": 7},
        "test_cases": [
            {"x": 7},   # Same as trace
            {"x": 13},  # Different path
            {"x": 5},   # Another input
        ]
    },
    {
        "name": "check-primes",
        "file": "/Users/jl4492/Projects/cs6120/bril/benchmarks/core/check-primes.bril",
        "trace_args": {"n": 20},
        "test_cases": [
            {"n": 20},  # Same as trace
            {"n": 30},  # Larger input
        ]
    },
]

def args_to_str(args_dict):
    """Convert args dict to command line arguments."""
    return " ".join(f"{k}={v}" for k, v in args_dict.items())

def run_command(cmd):
    """Run a shell command and return output."""
    result = subprocess.run(cmd, shell=True, capture_output=True, text=True)
    if result.returncode != 0:
        print(f"Error running: {cmd}", file=sys.stderr)
        print(result.stderr, file=sys.stderr)
        return None
    return result.stdout

def run_spec(prog_json, args_dict):
    """Run spec.py and parse the result."""
    args_str = args_to_str(args_dict)
    cmd = f"python3 spec.py {prog_json} {args_str}"
    output = run_command(cmd)
    if not output:
        return None, None

    lines = output.strip().split('\n')
    # Last line should be JSON with instr_count
    try:
        result = json.loads(lines[-1])
        printed_output = '\n'.join(lines[:-1])
        return printed_output, result.get('instr_count')
    except:
        return None, None

def main():
    results = []

    for test in TESTS:
        print(f"\n{'='*60}")
        print(f"Testing: {test['name']}")
        print(f"{'='*60}")

        # Step 1: Convert to JSON
        print(f"[1] Converting {test['file']} to JSON...")
        if test['file'].endswith('.bril'):
            cmd = f"bril2json < {test['file']} > build/prog.json"
            if not run_command(cmd):
                print(f"Failed to convert {test['file']}")
                continue
        else:
            # Already JSON
            cmd = f"cp {test['file']} build/prog.json"
            run_command(cmd)

        # Step 2: Generate trace
        print(f"[2] Generating trace with args: {test['trace_args']}...")
        trace_args_str = args_to_str(test['trace_args'])
        cmd = f"python3 tracer_dynamic.py build/prog.json {trace_args_str} > build/trace.json"
        if not run_command(cmd):
            print(f"Failed to generate trace")
            continue

        # Step 3: Inject trace
        print(f"[3] Injecting trace into program...")
        cmd = "python3 inject.py build/prog.json build/trace.json > build/stitched.json"
        if not run_command(cmd):
            print(f"Failed to inject trace")
            continue

        # Step 4: Test all cases
        print(f"[4] Testing {len(test['test_cases'])} test cases...")
        test_results = {
            "name": test['name'],
            "trace_args": test['trace_args'],
            "cases": []
        }

        for i, test_case in enumerate(test['test_cases']):
            print(f"\n  Test case {i+1}: {test_case}")

            # Run baseline
            baseline_out, baseline_count = run_spec("build/prog.json", test_case)
            if baseline_count is None:
                print(f"    Failed to run baseline")
                continue

            # Run traced
            traced_out, traced_count = run_spec("build/stitched.json", test_case)
            if traced_count is None:
                print(f"    Failed to run traced")
                continue

            # Check correctness
            correct = (baseline_out == traced_out)
            overhead = traced_count - baseline_count
            overhead_pct = (overhead / baseline_count * 100) if baseline_count > 0 else 0

            print(f"    Baseline: {baseline_count} instrs")
            print(f"    Traced:   {traced_count} instrs")
            print(f"    Overhead: {overhead:+d} instrs ({overhead_pct:+.1f}%)")
            print(f"    Correct:  {correct}")

            test_results["cases"].append({
                "args": test_case,
                "baseline_count": baseline_count,
                "traced_count": traced_count,
                "overhead": overhead,
                "overhead_pct": overhead_pct,
                "correct": correct
            })

        results.append(test_results)

    # Summary
    print(f"\n{'='*60}")
    print("SUMMARY")
    print(f"{'='*60}")

    with open("build/eval_results.json", "w") as f:
        json.dump(results, f, indent=2)

    print("\nResults saved to build/eval_results.json")

    # Print summary table
    print("\n{:<20} {:<15} {:<12} {:<12} {:<12}".format(
        "Benchmark", "Input", "Baseline", "Traced", "Overhead"))
    print("-" * 75)

    for test_result in results:
        for case in test_result["cases"]:
            input_str = str(case["args"])[:13]
            print("{:<20} {:<15} {:<12} {:<12} {:>+5d} ({:+.1f}%)".format(
                test_result["name"],
                input_str,
                case["baseline_count"],
                case["traced_count"],
                case["overhead"],
                case["overhead_pct"]
            ))

if __name__ == "__main__":
    main()
