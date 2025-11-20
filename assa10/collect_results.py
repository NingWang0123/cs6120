#!/usr/bin/env python3
"""Collect and analyze evaluation results from manual tests."""

import json

# Manual test results collected from runs
results = {
    "grad_desc": {
        "description": "Gradient descent optimization",
        "trace_input": "w=6000 t=2000 lr=100 steps=20",
        "tests": [
            {
                "input": "w=6000 t=2000 lr=100 steps=20",
                "baseline": 229,
                "traced": 434,
                "output_baseline": "2048\n2304",
                "output_traced": "2048\n2304"
            },
            {
                "input": "w=8000 t=3000 lr=150 steps=30",
                "baseline": 339,
                "traced": 548,
                "output_baseline": "3003\n9",
                "output_traced": "3003\n9"
            }
        ]
    },
    "loopfact": {
        "description": "Iterative factorial",
        "trace_input": "input=8",
        "tests": [
            {
                "input": "input=8",
                "baseline": 116,
                "traced": 222,
                "output_baseline": "40320",
                "output_traced": "40320"
            },
            {
                "input": "input=12",
                "baseline": 168,
                "traced": 277,
                "output_baseline": "479001600",
                "output_traced": "479001600"
            }
        ]
    },
    "collatz": {
        "description": "Collatz conjecture sequence",
        "trace_input": "x=7",
        "tests": [
            {
                "input": "x=7",
                "baseline": 169,
                "traced": 175,
                "output_baseline": "7\n22\n11\n34\n17\n52\n26\n13\n40\n20\n10\n5\n16\n8\n4\n2\n1",
                "output_traced": "7\n22\n11\n34\n17\n52\n26\n13\n40\n20\n10\n5\n16\n8\n4\n2\n1"
            },
            {
                "input": "x=13",
                "baseline": 99,
                "traced": 105,
                "output_baseline": "13\n40\n20\n10\n5\n16\n8\n4\n2\n1",
                "output_traced": "13\n40\n20\n10\n5\n16\n8\n4\n2\n1"
            }
        ]
    },
    "check_primes": {
        "description": "Prime number checker",
        "trace_input": "n=20",
        "tests": [
            {
                "input": "n=20",
                "baseline": 329,
                "traced": 341,
                "output_baseline": "19 zeros",
                "output_traced": "19 zeros"
            },
            {
                "input": "n=30",
                "baseline": 499,
                "traced": 511,
                "output_baseline": "29 zeros",
                "output_traced": "29 zeros"
            }
        ]
    }
}

def analyze_results():
    """Analyze the results and compute statistics."""

    print("=" * 80)
    print("TRACE-BASED SPECULATIVE OPTIMIZATION - EVALUATION RESULTS")
    print("=" * 80)

    all_correct = True
    total_overhead = 0
    num_tests = 0

    for bench_name, bench_data in results.items():
        print(f"\n{bench_name.upper()}: {bench_data['description']}")
        print(f"Trace generated from: {bench_data['trace_input']}")
        print("-" * 80)
        print(f"{'Input':<40} {'Baseline':>10} {'Traced':>10} {'Overhead':>12} {'Correct':>8}")
        print("-" * 80)

        for test in bench_data['tests']:
            overhead = test['traced'] - test['baseline']
            overhead_pct = (overhead / test['baseline']) * 100
            correct = test['output_baseline'] == test['output_traced']
            all_correct = all_correct and correct

            total_overhead += overhead
            num_tests += 1

            correct_mark = "✓" if correct else "✗"
            print(f"{test['input']:<40} {test['baseline']:>10} {test['traced']:>10} "
                  f"{overhead:>+6} ({overhead_pct:>+5.1f}%) {correct_mark:>7}")

    # Summary statistics
    print("\n" + "=" * 80)
    print("SUMMARY STATISTICS")
    print("=" * 80)
    print(f"Total test cases: {num_tests}")
    print(f"All outputs correct: {'YES ✓' if all_correct else 'NO ✗'}")
    print(f"Total instruction overhead: {total_overhead:+d} instructions")
    print(f"Average overhead per test: {total_overhead / num_tests:+.1f} instructions")

    # Analysis by benchmark
    print("\n" + "=" * 80)
    print("ANALYSIS BY BENCHMARK")
    print("=" * 80)

    for bench_name, bench_data in results.items():
        tests = bench_data['tests']
        trace_test = tests[0]  # First test uses trace input
        other_tests = tests[1:]

        print(f"\n{bench_name}:")
        print(f"  Traced input overhead: {trace_test['traced'] - trace_test['baseline']:+d} "
              f"({(trace_test['traced'] - trace_test['baseline']) / trace_test['baseline'] * 100:+.1f}%)")

        if other_tests:
            avg_other_overhead = sum(t['traced'] - t['baseline'] for t in other_tests) / len(other_tests)
            avg_other_pct = sum((t['traced'] - t['baseline']) / t['baseline'] * 100 for t in other_tests) / len(other_tests)
            print(f"  Other inputs avg overhead: {avg_other_overhead:+.1f} ({avg_other_pct:+.1f}%)")

    # Save to JSON
    output = {
        "results": results,
        "summary": {
            "total_tests": num_tests,
            "all_correct": all_correct,
            "total_overhead": total_overhead,
            "avg_overhead": total_overhead / num_tests
        }
    }

    with open("build/evaluation_summary.json", "w") as f:
        json.dump(output, f, indent=2)

    print(f"\n\nDetailed results saved to: build/evaluation_summary.json")

if __name__ == "__main__":
    analyze_results()
