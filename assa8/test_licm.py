#!/usr/bin/env python3
"""
Comprehensive LICM (Loop Invariant Code Motion) testing script.

Tests:
1. Verify correctness (output should be identical)
2. Measure static instruction reduction (instructions hoisted out of loops)
3. Measure dynamic instruction reduction (actual execution savings)
"""

import json
import sys
import os
import subprocess
from pathlib import Path
import licm


BRILI_CMD = ["deno", "run", "--allow-read", "/Users/jl4492/Projects/cs6120/bril/brili.ts"]
BRIL2JSON_CMD = "bril2json"


def static_instr_count(func):
    """Count static instructions (excluding labels)."""
    return sum(1 for ins in func['instrs'] if 'op' in ins)


def run_brili(prog_json, args=None, profiling=False):
    """Run a Bril program with brili and return output and dynamic instruction count."""
    cmd = BRILI_CMD.copy()
    if profiling:
        cmd.append("-p")
    if args:
        cmd.extend(args)

    proc = subprocess.run(
        cmd,
        input=json.dumps(prog_json),
        stdout=subprocess.PIPE,
        stderr=subprocess.PIPE,
        text=True
    )

    if proc.returncode != 0:
        raise RuntimeError(f"brili failed: {proc.stderr}")

    output = proc.stdout
    dynamic_count = 0

    if profiling:
        # brili -p outputs to stderr
        lines = proc.stderr.strip().split('\n')
        if lines and lines[-1].startswith('total_dyn_inst:'):
            dynamic_count = int(lines[-1].split(':')[1].strip())

    return output, dynamic_count


def count_hoisted_instructions(original_func, optimized_func):
    """Count how many instructions were hoisted (reduction in loop bodies)."""
    # This is an approximation - we count the reduction in static instructions
    original_count = static_instr_count(original_func)
    optimized_count = static_instr_count(optimized_func)
    return original_count - optimized_count


def extract_args_from_bril(bril_path):
    """Extract ARGS from comments in the .bril file."""
    with open(bril_path, 'r') as f:
        for line in f:
            if line.strip().startswith('# ARGS:'):
                args_str = line.strip()[7:].strip()  # Remove '# ARGS:' prefix
                return args_str.split() if args_str else []
    return []


def test_single_file(bril_path, args=None):
    """Test a single Bril file through LICM optimization."""
    result = {
        'file': str(bril_path),
        'has_loops': False,
        'correctness_passed': False,
        'static_original': 0,
        'static_optimized': 0,
        'static_reduction': 0,
        'dynamic_original': 0,
        'dynamic_optimized': 0,
        'dynamic_reduction': 0,
        'dynamic_reduction_pct': 0.0,
        'speedup': 0.0,
        'error': None
    }

    try:
        # Read and parse the original Bril file
        proc = subprocess.run(
            [BRIL2JSON_CMD],
            stdin=open(bril_path, 'r'),
            stdout=subprocess.PIPE,
            stderr=subprocess.PIPE,
            text=True
        )

        if proc.returncode != 0:
            result['error'] = f"bril2json failed: {proc.stderr}"
            return result

        original_prog = json.loads(proc.stdout)

        # Check if program has loops by looking for back edges
        # Simple heuristic: if there are labels that could form loops
        has_labels = any('label' in ins for func in original_prog.get('functions', [])
                        for ins in func.get('instrs', []))
        has_branches = any(ins.get('op') in ['br', 'jmp']
                          for func in original_prog.get('functions', [])
                          for ins in func.get('instrs', []))
        result['has_loops'] = has_labels and has_branches

        # Apply LICM optimization with out-of-ssa
        optimized_funcs = []
        for func in original_prog['functions']:
            result['static_original'] += static_instr_count(func)
            optimized_func = licm.licm_function(func, out_of_ssa=True)
            optimized_funcs.append(optimized_func)
            result['static_optimized'] += static_instr_count(optimized_func)

        optimized_prog = dict(original_prog)
        optimized_prog['functions'] = optimized_funcs

        # Calculate static reduction
        result['static_reduction'] = result['static_original'] - result['static_optimized']

        # Extract args from the bril file
        bril_args = extract_args_from_bril(bril_path)

        original_output, original_dynamic = run_brili(original_prog, bril_args, profiling=True)
        result['dynamic_original'] = original_dynamic

        # Run optimized program and get output + dynamic count
        optimized_output, optimized_dynamic = run_brili(optimized_prog, bril_args, profiling=True)
        result['dynamic_optimized'] = optimized_dynamic

        # Check correctness
        result['correctness_passed'] = (original_output == optimized_output)

        # Calculate dynamic reduction
        result['dynamic_reduction'] = original_dynamic - optimized_dynamic
        if original_dynamic > 0:
            result['dynamic_reduction_pct'] = (result['dynamic_reduction'] / original_dynamic) * 100
            result['speedup'] = original_dynamic / optimized_dynamic if optimized_dynamic > 0 else 0.0

    except Exception as e:
        result['error'] = str(e)

    return result


def run_tests(benchmark_dir, output_file=None, limit=None):
    """Run tests on all benchmark files."""
    benchmark_path = Path(benchmark_dir)
    bril_files = sorted(benchmark_path.glob('*.bril'))

    if limit:
        bril_files = bril_files[:limit]

    print(f"Testing {len(bril_files)} files with LICM optimization...")
    print()

    results = []
    passed = 0
    failed = 0
    optimized = 0

    for bril_file in bril_files:
        result = test_single_file(bril_file)
        results.append(result)

        # Print progress
        filename = Path(result['file']).name

        if result['error']:
            status = "✗"
            print(f"{status} {filename:30} ERROR: {result['error']}")
            failed += 1
        elif not result['correctness_passed']:
            status = "✗"
            print(f"{status} {filename:30} FAILED: Output mismatch")
            failed += 1
        else:
            status = "✓"
            if result['dynamic_reduction'] > 0:
                print(f"{status} {filename:30} OK (Dynamic: -{result['dynamic_reduction']:,} instrs, "
                      f"{result['dynamic_reduction_pct']:+.1f}%, speedup: {result['speedup']:.3f}x)")
                optimized += 1
            elif result['has_loops']:
                print(f"{status} {filename:30} OK (No optimization opportunity)")
            else:
                print(f"{status} {filename:30} OK (No loops detected)")
            passed += 1

    print()
    print(f"Summary: {passed} passed, {failed} failed out of {len(bril_files)} tests")
    print(f"Programs with optimization: {optimized}")

    # Calculate aggregate statistics
    successful_results = [r for r in results if r['correctness_passed'] and not r['error']]
    loop_programs = [r for r in successful_results if r['has_loops']]
    optimized_programs = [r for r in successful_results if r['dynamic_reduction'] > 0]

    if successful_results:
        total_orig_dynamic = sum(r['dynamic_original'] for r in successful_results)
        total_optimized_dynamic = sum(r['dynamic_optimized'] for r in successful_results)
        total_reduction = total_orig_dynamic - total_optimized_dynamic

        print()
        print(f"Total programs tested: {len(successful_results)}")
        print(f"Programs with loops: {len(loop_programs)}")
        print(f"Programs optimized: {len(optimized_programs)}")
        print(f"Total dynamic instructions (original): {total_orig_dynamic:,}")
        print(f"Total dynamic instructions (optimized): {total_optimized_dynamic:,}")
        print(f"Total dynamic reduction: {total_reduction:,} ({(total_reduction/total_orig_dynamic*100):.2f}%)")

        if optimized_programs:
            avg_speedup = sum(r['speedup'] for r in optimized_programs) / len(optimized_programs)
            max_speedup_prog = max(optimized_programs, key=lambda r: r['speedup'])
            print(f"\nAverage speedup (optimized programs): {avg_speedup:.3f}x")
            print(f"Best speedup: {max_speedup_prog['speedup']:.3f}x ({Path(max_speedup_prog['file']).name})")

    # Save results to JSON if requested
    if output_file:
        with open(output_file, 'w') as f:
            json.dump(results, f, indent=2)
        print(f"\nDetailed results saved to {output_file}")

    return results


if __name__ == '__main__':
    import argparse

    parser = argparse.ArgumentParser(description='Test LICM optimization')
    parser.add_argument('benchmark_dir', help='Directory containing .bril benchmark files')
    parser.add_argument('-o', '--output', help='Output JSON file for detailed results')
    parser.add_argument('-l', '--limit', type=int, help='Limit number of files to test')

    args = parser.parse_args()

    results = run_tests(args.benchmark_dir, args.output, args.limit)

    # Exit with error code if any tests failed
    failed = sum(1 for r in results if r['error'] or not r['correctness_passed'])
    sys.exit(0 if failed == 0 else 1)
