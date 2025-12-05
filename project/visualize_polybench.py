#!/usr/bin/env python3

"""
Visualize PolyBench results comparing 3 implementations
with thread counts (2, 4, 8) against serial baseline
"""

import pandas as pd
import matplotlib.pyplot as plt
import numpy as np
import seaborn as sns
from pathlib import Path

# Set style
sns.set_style("whitegrid")
plt.rcParams['font.size'] = 10

RESULTS_DIR = "polybench_results"
OUTPUT_DIR = RESULTS_DIR

def load_data():
    """Load PolyBench results from CSV."""
    csv_file = Path(RESULTS_DIR) / "results.csv"
    if not csv_file.exists():
        print(f"Error: {csv_file} not found")
        print("Please run './run_polybench.sh' first.")
        return None

    df = pd.read_csv(csv_file)

    # Filter out error rows
    df = df[df['serial_time'] != 'N/A']

    # Convert to numeric
    for col in ['serial_time', 'parallel_2t', 'speedup_2t', 'parallel_4t',
                'speedup_4t', 'parallel_8t', 'speedup_8t', 'parallelizable_loops']:
        df[col] = pd.to_numeric(df[col], errors='coerce')

    # Drop rows with any NaN values
    df = df.dropna()

    return df

def plot_implementation_speedup_comparison(df):
    """Compare speedups across all 3 implementations for each thread count."""

    implementations = sorted(df['implementation'].unique())
    thread_counts = [2, 4, 8]

    # Filter to only parallelizable benchmarks
    df_parallel = df[df['parallelizable_loops'] > 0]

    if len(df_parallel) == 0:
        print("No parallelizable benchmarks found!")
        return

    fig, axes = plt.subplots(1, 3, figsize=(18, 6))

    colors = {'Original': '#3498db', 'Fusion': '#2ecc71', 'Fusion+Shared': '#e74c3c'}

    for idx, threads in enumerate(thread_counts):
        ax = axes[idx]

        speedup_col = f'speedup_{threads}t'

        # Get data for each implementation
        data_by_impl = []
        labels = []

        for impl in implementations:
            impl_data = df_parallel[df_parallel['implementation'] == impl][speedup_col]
            if len(impl_data) > 0:
                data_by_impl.append(impl_data)
                labels.append(impl)

        if not data_by_impl:
            continue

        # Create box plot
        bp = ax.boxplot(data_by_impl, labels=labels, patch_artist=True,
                        showmeans=True, meanline=True)

        # Color the boxes
        for patch, label in zip(bp['boxes'], labels):
            patch.set_facecolor(colors.get(label, '#95a5a6'))
            patch.set_alpha(0.7)

        ax.axhline(y=1.0, color='red', linestyle='--', linewidth=2, alpha=0.5,
                  label='No Speedup')

        ax.set_ylabel('Speedup', fontsize=12, weight='bold')
        ax.set_title(f'Speedup Distribution ({threads} Threads)\nn={len(df_parallel)//len(implementations)} benchmarks',
                    fontsize=14, weight='bold')
        ax.grid(axis='y', alpha=0.3)
        ax.legend()

        # Add mean values as text
        for i, (data, label) in enumerate(zip(data_by_impl, labels)):
            mean_val = data.mean()
            ax.text(i+1, mean_val, f'{mean_val:.2f}x',
                   ha='center', va='bottom', fontsize=9, weight='bold')

    plt.tight_layout()
    output_file = Path(OUTPUT_DIR) / 'implementation_speedup_comparison.png'
    plt.savefig(output_file, dpi=300, bbox_inches='tight')
    print(f"Saved: {output_file}")

def plot_speedup_scaling(df):
    """Plot how speedup scales with thread count for each implementation."""

    implementations = sorted(df['implementation'].unique())
    thread_counts = [2, 4, 8]

    # Filter to only parallelizable benchmarks
    df_parallel = df[df['parallelizable_loops'] > 0]

    if len(df_parallel) == 0:
        print("No parallelizable benchmarks found!")
        return

    fig, ax = plt.subplots(figsize=(10, 7))

    colors = {'Original': '#3498db', 'Fusion': '#2ecc71', 'Fusion+Shared': '#e74c3c'}

    for impl in implementations:
        impl_data = df_parallel[df_parallel['implementation'] == impl]

        mean_speedups = []
        std_speedups = []

        for threads in thread_counts:
            speedup_col = f'speedup_{threads}t'
            speedups = impl_data[speedup_col]
            mean_speedups.append(speedups.mean())
            std_speedups.append(speedups.std())

        ax.errorbar(thread_counts, mean_speedups, yerr=std_speedups,
                   marker='o', linewidth=2, markersize=10,
                   label=impl, color=colors.get(impl, '#95a5a6'),
                   capsize=5, alpha=0.8)

    # Ideal speedup line
    ax.plot(thread_counts, thread_counts, 'k--', linewidth=2, alpha=0.5,
           label='Ideal Speedup')

    ax.axhline(y=1.0, color='red', linestyle=':', linewidth=1, alpha=0.5)

    ax.set_xlabel('Number of Threads', fontsize=12, weight='bold')
    ax.set_ylabel('Average Speedup', fontsize=12, weight='bold')
    ax.set_title(f'Speedup Scaling Across Thread Counts\n(Parallelizable Benchmarks, n={len(df_parallel)//len(implementations)})',
                fontsize=14, weight='bold')
    ax.set_xticks(thread_counts)
    ax.legend(fontsize=11)
    ax.grid(True, alpha=0.3)

    plt.tight_layout()
    output_file = Path(OUTPUT_DIR) / 'speedup_scaling.png'
    plt.savefig(output_file, dpi=300, bbox_inches='tight')
    print(f"Saved: {output_file}")

def plot_parallelizable_coverage(df):
    """Show which benchmarks are parallelizable by each implementation."""

    implementations = sorted(df['implementation'].unique())

    fig, (ax1, ax2) = plt.subplots(1, 2, figsize=(14, 6))

    # Count parallelizable benchmarks per implementation
    impl_counts = []
    impl_labels = []

    for impl in implementations:
        impl_data = df[df['implementation'] == impl]
        parallelizable = len(impl_data[impl_data['parallelizable_loops'] > 0])
        total = len(impl_data)
        impl_counts.append(parallelizable)
        impl_labels.append(f'{impl}\n({parallelizable}/{total})')

    colors = ['#3498db', '#2ecc71', '#e74c3c']

    # Bar chart
    bars = ax1.bar(range(len(implementations)), impl_counts,
                   color=colors[:len(implementations)], alpha=0.8, edgecolor='black')
    ax1.set_xticks(range(len(implementations)))
    ax1.set_xticklabels(impl_labels, fontsize=11)
    ax1.set_ylabel('Number of Parallelizable Benchmarks', fontsize=12, weight='bold')
    ax1.set_title('Parallelizable Benchmark Count by Implementation',
                 fontsize=14, weight='bold')
    ax1.grid(axis='y', alpha=0.3)

    # Add value labels
    for bar, count in zip(bars, impl_counts):
        height = bar.get_height()
        ax1.text(bar.get_x() + bar.get_width()/2., height,
                f'{count}', ha='center', va='bottom', fontsize=12, weight='bold')

    # Distribution of loop counts
    for impl, color in zip(implementations, colors):
        impl_data = df[df['implementation'] == impl]
        loop_counts = impl_data[impl_data['parallelizable_loops'] > 0]['parallelizable_loops']

        if len(loop_counts) > 0:
            ax2.hist(loop_counts, bins=range(1, int(loop_counts.max())+2),
                    alpha=0.6, label=impl, color=color, edgecolor='black')

    ax2.set_xlabel('Number of Parallelizable Loops', fontsize=12, weight='bold')
    ax2.set_ylabel('Frequency', fontsize=12, weight='bold')
    ax2.set_title('Distribution of Parallelizable Loops', fontsize=14, weight='bold')
    ax2.legend(fontsize=10)
    ax2.grid(axis='y', alpha=0.3)

    plt.tight_layout()
    output_file = Path(OUTPUT_DIR) / 'parallelizable_coverage.png'
    plt.savefig(output_file, dpi=300, bbox_inches='tight')
    print(f"Saved: {output_file}")

def generate_summary_report(df):
    """Generate comprehensive text summary."""

    output_file = Path(OUTPUT_DIR) / 'summary.txt'
    implementations = sorted(df['implementation'].unique())
    thread_counts = [2, 4, 8]

    with open(output_file, 'w') as f:
        f.write("=" * 80 + "\n")
        f.write("PolyBench Loop Parallelization Summary\n")
        f.write("Comparing 3 Implementations\n")
        f.write("=" * 80 + "\n\n")

        # Overall statistics
        total_benchmarks = len(df['benchmark'].unique())
        f.write(f"Total unique benchmarks: {total_benchmarks}\n\n")

        for impl in implementations:
            impl_data = df[df['implementation'] == impl]
            parallelizable = len(impl_data[impl_data['parallelizable_loops'] > 0])

            f.write(f"\n{impl} Implementation:\n")
            f.write("-" * 80 + "\n")
            f.write(f"  Parallelizable benchmarks: {parallelizable}/{len(impl_data)} ")
            f.write(f"({100*parallelizable/len(impl_data):.1f}%)\n")

            if parallelizable > 0:
                total_loops = impl_data[impl_data['parallelizable_loops'] > 0]['parallelizable_loops'].sum()
                avg_loops = total_loops / parallelizable
                f.write(f"  Total parallelizable loops: {int(total_loops)}\n")
                f.write(f"  Average loops per benchmark: {avg_loops:.2f}\n")

            f.write("\n  Speedup Statistics:\n")
            for threads in thread_counts:
                speedup_col = f'speedup_{threads}t'
                speedups = impl_data[impl_data['parallelizable_loops'] > 0][speedup_col]

                if len(speedups) > 0:
                    f.write(f"    {threads} threads:\n")
                    f.write(f"      Mean: {speedups.mean():.2f}x\n")
                    f.write(f"      Median: {speedups.median():.2f}x\n")
                    f.write(f"      Max: {speedups.max():.2f}x\n")
                    f.write(f"      Min: {speedups.min():.2f}x\n")
                    improved = len(speedups[speedups > 1.0])
                    f.write(f"      Speedup > 1.0: {improved}/{len(speedups)} ")
                    f.write(f"({100*improved/len(speedups):.1f}%)\n")

        # Best performers
        f.write("\n" + "=" * 80 + "\n")
        f.write("Top 10 Speedups at 8 Threads (across all implementations)\n")
        f.write("=" * 80 + "\n")

        df_8t = df[df['parallelizable_loops'] > 0].copy()
        df_8t = df_8t.sort_values('speedup_8t', ascending=False).head(10)

        for i, (_, row) in enumerate(df_8t.iterrows(), 1):
            f.write(f"{i:2d}. {row['benchmark']:30s} ({row['implementation']:15s}): ")
            f.write(f"{row['speedup_8t']:.2f}x ({int(row['parallelizable_loops'])} loops)\n")

        # Implementation comparison
        f.write("\n" + "=" * 80 + "\n")
        f.write("Average Speedup Comparison (parallelizable benchmarks only)\n")
        f.write("=" * 80 + "\n\n")

        for threads in thread_counts:
            f.write(f"{threads} Threads:\n")
            speedup_col = f'speedup_{threads}t'

            for impl in implementations:
                impl_data = df[(df['implementation'] == impl) &
                             (df['parallelizable_loops'] > 0)]
                if len(impl_data) > 0:
                    mean_speedup = impl_data[speedup_col].mean()
                    f.write(f"  {impl:20s}: {mean_speedup:.2f}x\n")
            f.write("\n")

    print(f"Saved: {output_file}")

if __name__ == '__main__':
    import sys

    print("Loading PolyBench results...")
    df = load_data()

    if df is None or len(df) == 0:
        print("No valid results found!")
        sys.exit(1)

    print(f"Loaded {len(df)} benchmark results")
    print(f"Implementations: {', '.join(sorted(df['implementation'].unique()))}")
    print(f"Unique benchmarks: {len(df['benchmark'].unique())}")
    print()

    print("Generating visualizations...")
    plot_implementation_speedup_comparison(df)
    plot_speedup_scaling(df)
    plot_parallelizable_coverage(df)

    print("Generating summary report...")
    generate_summary_report(df)

    print(f"\nDone! Check {RESULTS_DIR}/ directory for outputs.")
