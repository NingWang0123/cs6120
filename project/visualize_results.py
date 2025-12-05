#!/usr/bin/env python3

"""
Visualize benchmark results comparing 3 loop parallelization implementations
with multiple thread counts (2, 4, 8) against serial baseline
"""

import pandas as pd
import matplotlib.pyplot as plt
import numpy as np
import seaborn as sns
from pathlib import Path

# Set style
sns.set_style("whitegrid")
plt.rcParams['font.size'] = 10

RESULTS_DIR = "tests_results"
OUTPUT_DIR = RESULTS_DIR

def load_data():
    """Load benchmark results from CSV."""
    csv_file = Path(RESULTS_DIR) / "raw_data.csv"
    if not csv_file.exists():
        print(f"Error: {csv_file} not found")
        print("Please run './run_benchmarks.sh' first.")
        return None

    df = pd.read_csv(csv_file)
    return df

def plot_implementation_comparison(df):
    """Compare all 3 implementations across benchmarks and thread counts."""

    # Get unique implementations and benchmarks
    implementations = df['implementation'].unique()
    benchmarks = ['array_ops', 'scale_offset', 'elementwise']
    thread_counts = sorted(df['threads'].unique())

    # Create figure with subplots for each benchmark
    fig, axes = plt.subplots(1, 3, figsize=(18, 6))

    colors = {'Original': '#3498db', 'Fusion': '#2ecc71', 'Fusion+Shared': '#e74c3c'}

    for idx, benchmark in enumerate(benchmarks):
        ax = axes[idx]

        # Get serial baseline (average across implementations since they should be same)
        serial_data = df[(df['mode'] == 'Serial') & (df['threads'] == 1)]
        serial_mean = serial_data[benchmark].mean()

        # Plot each implementation
        x = np.arange(len(thread_counts))
        width = 0.25

        for i, impl in enumerate(implementations):
            impl_data = df[(df['mode'] == 'Parallel') & (df['implementation'] == impl)]
            means = []
            stds = []

            for threads in thread_counts:
                thread_data = impl_data[impl_data['threads'] == threads][benchmark]
                if len(thread_data) > 0:
                    means.append(thread_data.mean())
                    stds.append(thread_data.std())
                else:
                    means.append(0)
                    stds.append(0)

            offset = (i - 1) * width
            bars = ax.bar(x + offset, means, width, yerr=stds,
                         label=impl, color=colors.get(impl, '#95a5a6'),
                         alpha=0.8, capsize=5, edgecolor='black')

        # Add serial baseline as horizontal line
        ax.axhline(y=serial_mean, color='red', linestyle='--',
                  linewidth=2, alpha=0.7, label='Serial Baseline')

        ax.set_xlabel('Number of Threads', fontsize=12, weight='bold')
        ax.set_ylabel('Time (seconds)', fontsize=12, weight='bold')
        ax.set_title(f'{benchmark.replace("_", " ").title()}',
                    fontsize=14, weight='bold')
        ax.set_xticks(x)
        ax.set_xticklabels([f'{t}T' for t in thread_counts])
        ax.legend(fontsize=9)
        ax.grid(axis='y', alpha=0.3)

    plt.tight_layout()
    output_file = Path(OUTPUT_DIR) / 'performance_comparison.png'
    plt.savefig(output_file, dpi=300, bbox_inches='tight')
    print(f"Saved: {output_file}")

def plot_speedup_analysis(df):
    """Plot speedup for each implementation across thread counts."""

    implementations = df['implementation'].unique()
    benchmarks = ['array_ops', 'scale_offset', 'elementwise']
    thread_counts = sorted(df[df['mode'] == 'Parallel']['threads'].unique())

    fig, axes = plt.subplots(1, 3, figsize=(18, 6))

    colors = {'Original': '#3498db', 'Fusion': '#2ecc71', 'Fusion+Shared': '#e74c3c'}

    for idx, benchmark in enumerate(benchmarks):
        ax = axes[idx]

        # Get serial baseline
        serial_data = df[(df['mode'] == 'Serial')][benchmark]
        serial_mean = serial_data.mean()

        # Calculate speedups for each implementation
        for impl in implementations:
            speedups = []
            speedup_stds = []

            for threads in thread_counts:
                parallel_data = df[(df['mode'] == 'Parallel') &
                                  (df['implementation'] == impl) &
                                  (df['threads'] == threads)][benchmark]

                if len(parallel_data) > 0 and serial_mean > 0:
                    # Calculate speedup for each run
                    run_speedups = serial_mean / parallel_data
                    speedups.append(run_speedups.mean())
                    speedup_stds.append(run_speedups.std())
                else:
                    speedups.append(0)
                    speedup_stds.append(0)

            ax.errorbar(thread_counts, speedups, yerr=speedup_stds,
                       marker='o', linewidth=2, markersize=8,
                       label=impl, color=colors.get(impl, '#95a5a6'),
                       capsize=5, alpha=0.8)

        # Plot ideal speedup
        ax.plot(thread_counts, thread_counts, 'k--',
               linewidth=2, alpha=0.5, label='Ideal Speedup')

        ax.axhline(y=1.0, color='red', linestyle=':',
                  linewidth=1, alpha=0.5)

        ax.set_xlabel('Number of Threads', fontsize=12, weight='bold')
        ax.set_ylabel('Speedup', fontsize=12, weight='bold')
        ax.set_title(f'{benchmark.replace("_", " ").title()} Speedup',
                    fontsize=14, weight='bold')
        ax.legend(fontsize=9)
        ax.grid(True, alpha=0.3)
        ax.set_xticks(thread_counts)

    plt.tight_layout()
    output_file = Path(OUTPUT_DIR) / 'speedup_analysis.png'
    plt.savefig(output_file, dpi=300, bbox_inches='tight')
    print(f"Saved: {output_file}")

def generate_report(df):
    """Generate detailed text report."""

    output_file = Path(OUTPUT_DIR) / 'performance_report.txt'

    implementations = sorted(df['implementation'].unique())
    benchmarks = ['array_ops', 'scale_offset', 'elementwise']
    thread_counts = sorted(df[df['mode'] == 'Parallel']['threads'].unique())

    with open(output_file, 'w') as f:
        f.write("=" * 70 + "\n")
        f.write("Loop Parallelization Performance Report\n")
        f.write("Comparing 3 Implementations\n")
        f.write("=" * 70 + "\n\n")

        # Serial baseline
        f.write("Serial Baseline (averaged across all runs):\n")
        f.write("-" * 70 + "\n")
        serial_data = df[df['mode'] == 'Serial']
        for benchmark in benchmarks:
            mean = serial_data[benchmark].mean()
            std = serial_data[benchmark].std()
            f.write(f"  {benchmark:20s}: {mean:.6f} ± {std:.6f} seconds\n")
        f.write("\n")

        # Each implementation
        for impl in implementations:
            f.write(f"\n{impl} Implementation:\n")
            f.write("=" * 70 + "\n")

            impl_data = df[(df['mode'] == 'Parallel') & (df['implementation'] == impl)]

            for benchmark in benchmarks:
                f.write(f"\n{benchmark.replace('_', ' ').title()}:\n")
                f.write("-" * 70 + "\n")

                serial_mean = df[df['mode'] == 'Serial'][benchmark].mean()

                for threads in thread_counts:
                    thread_data = impl_data[impl_data['threads'] == threads][benchmark]

                    if len(thread_data) > 0:
                        mean = thread_data.mean()
                        std = thread_data.std()
                        speedup = serial_mean / mean if mean > 0 else 0
                        efficiency = (speedup / threads) * 100 if threads > 0 else 0

                        f.write(f"  {threads} threads: {mean:.6f} ± {std:.6f} seconds\n")
                        f.write(f"    Speedup: {speedup:.2f}x, Efficiency: {efficiency:.1f}%\n")

        # Summary comparison
        f.write("\n" + "=" * 70 + "\n")
        f.write("Summary: Best Speedups at 8 Threads\n")
        f.write("=" * 70 + "\n\n")

        max_threads = max(thread_counts)
        for benchmark in benchmarks:
            f.write(f"{benchmark.replace('_', ' ').title()}:\n")
            serial_mean = df[df['mode'] == 'Serial'][benchmark].mean()

            for impl in implementations:
                impl_data = df[(df['mode'] == 'Parallel') &
                             (df['implementation'] == impl) &
                             (df['threads'] == max_threads)][benchmark]

                if len(impl_data) > 0:
                    mean = impl_data.mean()
                    speedup = serial_mean / mean if mean > 0 else 0
                    f.write(f"  {impl:20s}: {speedup:.2f}x\n")
            f.write("\n")

    print(f"Saved: {output_file}")

if __name__ == '__main__':
    import sys
    import os

    print("Loading benchmark results...")
    df = load_data()

    if df is None or len(df) == 0:
        print("No results found!")
        sys.exit(1)

    print(f"Loaded {len(df)} data points")
    print(f"Implementations: {', '.join(df['implementation'].unique())}")
    print(f"Thread counts: {sorted(df['threads'].unique())}")
    print()

    print("Generating visualizations...")
    plot_implementation_comparison(df)
    plot_speedup_analysis(df)

    print("Generating performance report...")
    generate_report(df)

    print("\nDone! Check the results/ directory for outputs.")
