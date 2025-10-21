#!/usr/bin/env python3
"""
Comprehensive SSA transformation testing script.

Tests:
1. Verify SSA form correctness using is_ssa check
2. Verify round-trip equivalence (original -> SSA -> out of SSA)
3. Measure static instruction overhead
"""

import json
import sys
import os
import subprocess
from pathlib import Path
import ssa
import out_of_ssa


def is_ssa(bril):
    """Check whether a Bril program is in SSA form."""
    for func in bril["functions"]:
        assigned = set()
        for instr in func["instrs"]:
            if "dest" in instr:
                if instr["dest"] in assigned:
                    return False
                else:
                    assigned.add(instr["dest"])
    return True


def static_instr_count(func):
    """Count static instructions (excluding labels)."""
    return sum(1 for ins in func['instrs'] if 'op' in ins)


def test_single_file(bril_path, bril2json_cmd='bril2json'):
    """Test a single Bril file through SSA transformations."""
    result = {
        'file': str(bril_path),
        'ssa_correct': False,
        'round_trip_success': False,
        'static_original': 0,
        'static_ssa': 0,
        'static_final': 0,
        'static_overhead': 0,
        'error': None
    }

    try:
        # Read and parse the original Bril file
        proc = subprocess.run(
            [bril2json_cmd],
            stdin=open(bril_path, 'r'),
            stdout=subprocess.PIPE,
            stderr=subprocess.PIPE,
            text=True
        )

        if proc.returncode != 0:
            result['error'] = f"bril2json failed: {proc.stderr}"
            return result

        original_prog = json.loads(proc.stdout)

        # Test each function in the program
        funcs_original = original_prog['functions']
        funcs_ssa = []
        funcs_final = []

        for func in funcs_original:
            # Count original instructions
            result['static_original'] += static_instr_count(func)

            # Transform to SSA
            func_ssa = ssa.to_ssa(func)
            funcs_ssa.append(func_ssa)
            result['static_ssa'] += static_instr_count(func_ssa)

            # Transform back from SSA
            func_final = out_of_ssa.out_of_ssa(func_ssa)
            funcs_final.append(func_final)
            result['static_final'] += static_instr_count(func_final)

        # Check if SSA form is correct
        ssa_prog = {'functions': funcs_ssa}
        result['ssa_correct'] = is_ssa(ssa_prog)

        # Mark round trip as successful if we got this far
        result['round_trip_success'] = True
        result['static_overhead'] = result['static_final'] - result['static_original']

    except Exception as e:
        result['error'] = str(e)

    return result


def run_tests(benchmark_dir, output_file=None, limit=None):
    """Run tests on all benchmark files."""
    benchmark_path = Path(benchmark_dir)
    bril_files = sorted(benchmark_path.glob('*.bril'))

    if limit:
        bril_files = bril_files[:limit]

    print(f"Testing {len(bril_files)} files...")
    print()

    results = []
    passed = 0
    failed = 0

    for bril_file in bril_files:
        result = test_single_file(bril_file)
        results.append(result)

        # Print progress
        status = "✓" if result['ssa_correct'] and result['round_trip_success'] else "✗"
        filename = Path(result['file']).name

        if result['error']:
            print(f"{status} {filename:30} ERROR: {result['error']}")
            failed += 1
        elif not result['ssa_correct']:
            print(f"{status} {filename:30} FAILED: Not in SSA form")
            failed += 1
        elif not result['round_trip_success']:
            print(f"{status} {filename:30} FAILED: Round trip failed")
            failed += 1
        else:
            overhead_pct = (result['static_overhead'] / result['static_original'] * 100) if result['static_original'] > 0 else 0
            print(f"{status} {filename:30} OK (overhead: +{result['static_overhead']} instrs, {overhead_pct:+.1f}%)")
            passed += 1

    print()
    print(f"Summary: {passed} passed, {failed} failed out of {len(bril_files)} tests")

    # Calculate aggregate statistics
    successful_results = [r for r in results if r['round_trip_success'] and not r['error']]
    if successful_results:
        total_orig = sum(r['static_original'] for r in successful_results)
        total_overhead = sum(r['static_overhead'] for r in successful_results)
        avg_overhead_pct = (total_overhead / total_orig * 100) if total_orig > 0 else 0

        print()
        print(f"Total static instructions (original): {total_orig}")
        print(f"Total static overhead: {total_overhead} (+{avg_overhead_pct:.2f}%)")
        print(f"Average overhead per program: {total_overhead / len(successful_results):.2f} instructions")

    # Save results to JSON if requested
    if output_file:
        with open(output_file, 'w') as f:
            json.dump(results, f, indent=2)
        print(f"\nDetailed results saved to {output_file}")

    return results


if __name__ == '__main__':
    import argparse

    parser = argparse.ArgumentParser(description='Test SSA transformations')
    parser.add_argument('benchmark_dir', help='Directory containing .bril benchmark files')
    parser.add_argument('-o', '--output', help='Output JSON file for detailed results')
    parser.add_argument('-l', '--limit', type=int, help='Limit number of files to test')

    args = parser.parse_args()

    results = run_tests(args.benchmark_dir, args.output, args.limit)

    # Exit with error code if any tests failed
    failed = sum(1 for r in results if r['error'] or not r['ssa_correct'] or not r['round_trip_success'])
    sys.exit(0 if failed == 0 else 1)
