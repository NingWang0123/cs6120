#!/usr/bin/env python3

import csv
import matplotlib.pyplot as plt
import numpy as np
from collections import defaultdict

def read_polybench_results(csv_file='polybench_results/results.csv'):
    """Read PolyBench results from CSV with multiple thread configurations."""
    data = {
        'benchmarks': [],
        'loops': [],
        'serial_times': [],
        'parallel_times': {1: [], 2: [], 4: [], 8: []},
        'speedups': {1: [], 2: [], 4: [], 8: []}
    }

    with open(csv_file, 'r') as f:
        reader = csv.DictReader(f)
        for row in reader:
            try:
                loop_count = int(row['Parallelizable Loops'])
                serial = float(row['Serial Time (s)'])

                # Read all thread configurations
                valid = True
                for threads in [1, 2, 4, 8]:
                    parallel = float(row[f'Parallel {threads}T (s)'])
                    speedup = float(row[f'Speedup {threads}T'])
                    if serial > 0 and parallel > 0 and speedup > 0:
                        data['parallel_times'][threads].append(parallel)
                        data['speedups'][threads].append(speedup)
                    else:
                        valid = False
                        break

                if valid:
                    data['benchmarks'].append(row['Benchmark'])
                    data['loops'].append(loop_count)
                    data['serial_times'].append(serial)

            except (ValueError, KeyError) as e:
                continue

    return data

def plot_parallelizable_overview(data, output='polybench_results/parallelizable_overview.png'):
    """Plot showing how many benchmarks are parallelizable vs total."""
    total = len(data['benchmarks'])
    parallelizable = sum(1 for l in data['loops'] if l > 0)
    non_parallelizable = total - parallelizable

    fig, (ax1, ax2) = plt.subplots(1, 2, figsize=(14, 6))

    # Pie chart
    sizes = [parallelizable, non_parallelizable]
    labels = [f'Parallelizable\n({parallelizable} benchmarks)',
              f'Not Parallelizable\n({non_parallelizable} benchmarks)']
    colors = ['#2ecc71', '#e74c3c']
    explode = (0.05, 0)

    ax1.pie(sizes, explode=explode, labels=labels, colors=colors, autopct='%1.1f%%',
            shadow=True, startangle=90, textprops={'fontsize': 12, 'weight': 'bold'})
    ax1.set_title(f'Loop Parallelization Coverage\n(Total: {total} benchmarks)',
                  fontsize=14, weight='bold')

    # Bar chart showing loop counts
    loop_counts = defaultdict(int)
    for loops in data['loops']:
        loop_counts[loops] += 1

    x_vals = sorted(loop_counts.keys())
    y_vals = [loop_counts[x] for x in x_vals]
    colors_bar = ['#e74c3c' if x == 0 else '#2ecc71' for x in x_vals]

    ax2.bar(x_vals, y_vals, color=colors_bar, alpha=0.7, edgecolor='black', width=0.6)
    ax2.set_xlabel('Number of Parallelizable Loops', fontsize=12, weight='bold')
    ax2.set_ylabel('Number of Benchmarks', fontsize=12, weight='bold')
    ax2.set_title('Distribution of Parallelizable Loops', fontsize=14, weight='bold')
    ax2.grid(axis='y', alpha=0.3)

    # Add value labels on bars
    for i, (x, y) in enumerate(zip(x_vals, y_vals)):
        ax2.text(x, y + 0.5, str(y), ha='center', va='bottom', fontsize=10, weight='bold')

    plt.tight_layout()
    plt.savefig(output, dpi=300, bbox_inches='tight')
    print(f"Saved: {output}")

def plot_speedup_by_threads(data, output='polybench_results/speedup_by_threads.png'):
    """Plot speedup for ONLY parallelizable benchmarks with improvements."""
    # Filter: only parallelizable benchmarks (loops > 0) with any speedup > 1.0
    filtered_benchmarks = []
    filtered_speedups = {1: [], 2: [], 4: [], 8: []}

    for i, (bench, loops) in enumerate(zip(data['benchmarks'], data['loops'])):
        if loops > 0:  # Only parallelizable
            # Check if any thread count shows improvement
            has_improvement = any(data['speedups'][t][i] > 1.0 for t in [1, 2, 4, 8])
            if has_improvement:
                filtered_benchmarks.append(bench)
                for threads in [1, 2, 4, 8]:
                    filtered_speedups[threads].append(data['speedups'][threads][i])

    if not filtered_benchmarks:
        print("No parallelizable benchmarks with improvements found!")
        return

    fig, ax = plt.subplots(figsize=(12, 8))

    x = np.arange(len(filtered_benchmarks))
    width = 0.2

    colors = ['#3498db', '#2ecc71', '#f39c12', '#e74c3c']
    for i, threads in enumerate([1, 2, 4, 8]):
        offset = (i - 1.5) * width
        bars = ax.bar(x + offset, filtered_speedups[threads], width,
                     label=f'{threads} thread{"s" if threads > 1 else ""}',
                     color=colors[i], alpha=0.8, edgecolor='black')

    ax.set_ylabel('Speedup', fontsize=12, weight='bold')
    ax.set_title(f'Speedup by Thread Count\n(Parallelizable Benchmarks with Improvements, n={len(filtered_benchmarks)})',
                 fontsize=14, weight='bold')
    ax.set_xticks(x)
    ax.set_xticklabels(filtered_benchmarks, rotation=45, ha='right', fontsize=10)
    ax.axhline(y=1.0, color='red', linestyle='--', linewidth=2, alpha=0.7, label='No speedup')
    ax.legend(fontsize=10)
    ax.grid(axis='y', alpha=0.3)

    plt.tight_layout()
    plt.savefig(output, dpi=300, bbox_inches='tight')
    print(f"Saved: {output}")

def plot_speedup_scaling(data, output='polybench_results/speedup_scaling.png'):
    """Plot speedup scaling across thread counts for parallelizable benchmarks."""
    # Filter: only parallelizable benchmarks
    parallelizable_idx = [i for i, l in enumerate(data['loops']) if l > 0]

    if not parallelizable_idx:
        print("No parallelizable benchmarks found!")
        return

    fig, ax = plt.subplots(figsize=(10, 7))

    thread_counts = [1, 2, 4, 8]
    colors_map = plt.cm.tab10(np.linspace(0, 1, len(parallelizable_idx)))

    for idx, bench_idx in enumerate(parallelizable_idx):
        bench_name = data['benchmarks'][bench_idx]
        speedups = [data['speedups'][t][bench_idx] for t in thread_counts]
        ax.plot(thread_counts, speedups, marker='o', linewidth=2,
               label=bench_name, color=colors_map[idx], markersize=8)

    # Ideal speedup line
    ax.plot(thread_counts, thread_counts, 'k--', linewidth=2, alpha=0.5, label='Ideal Speedup')

    ax.set_xlabel('Number of Threads', fontsize=12, weight='bold')
    ax.set_ylabel('Speedup', fontsize=12, weight='bold')
    ax.set_title(f'Speedup Scaling with Thread Count\n(Parallelizable Benchmarks Only, n={len(parallelizable_idx)})',
                 fontsize=14, weight='bold')
    ax.set_xticks(thread_counts)
    ax.grid(True, alpha=0.3)
    ax.legend(fontsize=9, loc='upper left')
    ax.axhline(y=1.0, color='red', linestyle='--', alpha=0.5)

    plt.tight_layout()
    plt.savefig(output, dpi=300, bbox_inches='tight')
    print(f"Saved: {output}")

def plot_end_to_end_comparison(data, output='polybench_results/end_to_end_comparison.png'):
    """Plot end-to-end execution time comparison: parallelizable benchmarks only with log scale."""
    fig, (ax1, ax2) = plt.subplots(2, 1, figsize=(14, 10))

    # Filter to only parallelizable benchmarks
    parallelizable_idx = [i for i, l in enumerate(data['loops']) if l > 0]
    benchmarks_filtered = [data['benchmarks'][i] for i in parallelizable_idx]
    serial_times_filtered = [data['serial_times'][i] for i in parallelizable_idx]
    parallel_times_4t = [data['parallel_times'][4][i] for i in parallelizable_idx]
    parallel_times_8t = [data['parallel_times'][8][i] for i in parallelizable_idx]

    x = np.arange(len(benchmarks_filtered))
    width = 0.25

    # Top plot: Individual benchmark times with log scale
    bars1 = ax1.bar(x - width, serial_times_filtered, width, label='Serial',
                   color='#3498db', alpha=0.8, edgecolor='black')
    bars2 = ax1.bar(x, parallel_times_4t, width, label='Parallel (4 threads)',
                   color='#2ecc71', alpha=0.8, edgecolor='black')
    bars3 = ax1.bar(x + width, parallel_times_8t, width, label='Parallel (8 threads)',
                   color='#e74c3c', alpha=0.8, edgecolor='black')

    ax1.set_yscale('log')
    ax1.set_ylabel('Execution Time (s) [Log Scale]', fontsize=12, weight='bold')
    ax1.set_title(f'End-to-End Execution Time: Parallelizable Benchmarks Only (n={len(benchmarks_filtered)})',
                  fontsize=14, weight='bold')
    ax1.set_xticks(x)
    ax1.set_xticklabels(benchmarks_filtered, rotation=45, ha='right', fontsize=10)
    ax1.legend(fontsize=10)
    ax1.grid(axis='y', alpha=0.3, which='both')

    # Bottom plot: Total cumulative time (use all benchmarks for end-to-end total)
    total_serial = sum(data['serial_times'])
    total_parallel = {t: sum(data['parallel_times'][t]) for t in [1, 2, 4, 8]}

    categories = ['Serial', '1 Thread', '2 Threads', '4 Threads', '8 Threads']
    totals = [total_serial, total_parallel[1], total_parallel[2], total_parallel[4], total_parallel[8]]
    speedups_total = [1.0] + [total_serial/total_parallel[t] for t in [1, 2, 4, 8]]

    colors_bars = ['#e74c3c', '#3498db', '#2ecc71', '#f39c12', '#9b59b6']
    bars = ax2.bar(categories, totals, color=colors_bars, alpha=0.8, edgecolor='black')

    # Add time and speedup labels
    for bar, total, speedup in zip(bars, totals, speedups_total):
        height = bar.get_height()
        ax2.text(bar.get_x() + bar.get_width()/2., height,
                f'{total:.4f}s\n({speedup:.2f}x)',
                ha='center', va='bottom', fontsize=10, weight='bold')

    ax2.set_ylabel('Total Execution Time (s)', fontsize=12, weight='bold')
    ax2.set_title(f'Total End-to-End Time Across All {len(data["benchmarks"])} Benchmarks',
                  fontsize=14, weight='bold')
    ax2.grid(axis='y', alpha=0.3)

    plt.tight_layout()
    plt.savefig(output, dpi=300, bbox_inches='tight')
    print(f"Saved: {output}")

def generate_summary_report(data, output='polybench_results/summary.txt'):
    """Generate comprehensive text summary."""
    with open(output, 'w') as f:
        f.write("=" * 70 + "\n")
        f.write("PolyBench Loop Parallelization Summary\n")
        f.write("=" * 70 + "\n\n")

        total = len(data['benchmarks'])
        parallelizable = sum(1 for l in data['loops'] if l > 0)

        f.write(f"Total benchmarks: {total}\n")
        f.write(f"Benchmarks with parallelizable loops: {parallelizable} ({100*parallelizable/total:.1f}%)\n")
        f.write(f"Benchmarks without parallelizable loops: {total - parallelizable}\n\n")

        # Speedup statistics for each thread count
        for threads in [1, 2, 4, 8]:
            speedups = data['speedups'][threads]
            f.write(f"Speedup Statistics ({threads} thread{'s' if threads > 1 else ''}):\n")
            f.write(f"  Mean: {np.mean(speedups):.2f}x\n")
            f.write(f"  Median: {np.median(speedups):.2f}x\n")
            f.write(f"  Min: {np.min(speedups):.2f}x\n")
            f.write(f"  Max: {np.max(speedups):.2f}x\n")
            f.write(f"  Std Dev: {np.std(speedups):.2f}\n")
            improved = sum(1 for s in speedups if s > 1.0)
            f.write(f"  Benchmarks with speedup > 1.0: {improved} ({100*improved/len(speedups):.1f}%)\n\n")

        # End-to-end timing
        f.write("End-to-End Total Times:\n")
        total_serial = sum(data['serial_times'])
        f.write(f"  Serial: {total_serial:.4f}s\n")
        for threads in [1, 2, 4, 8]:
            total_parallel = sum(data['parallel_times'][threads])
            speedup = total_serial / total_parallel
            f.write(f"  {threads} thread{'s' if threads > 1 else ''}: {total_parallel:.4f}s ({speedup:.2f}x)\n")
        f.write("\n")

        # Top performers at 4 threads
        f.write("Top 10 Speedups (4 threads):\n")
        speedups_4t = data['speedups'][4]
        sorted_indices = np.argsort(speedups_4t)[::-1][:10]
        for i, idx in enumerate(sorted_indices, 1):
            bench = data['benchmarks'][idx]
            loops = data['loops'][idx]
            speedup = speedups_4t[idx]
            f.write(f"  {i}. {bench}: {speedup:.2f}x ({loops} loop{'s' if loops != 1 else ''})\n")

    print(f"Saved: {output}")

if __name__ == '__main__':
    import sys
    import os

    csv_file = 'polybench_results/results.csv'

    if not os.path.exists(csv_file):
        print(f"Error: {csv_file} not found.")
        print("Run './run_polybench.sh' first.")
        sys.exit(1)

    print("Reading PolyBench results...")
    data = read_polybench_results(csv_file)

    if not data['benchmarks']:
        print("No valid results found!")
        sys.exit(1)

    print(f"Loaded {len(data['benchmarks'])} benchmark results")
    print("\nGenerating visualizations...")

    plot_parallelizable_overview(data)
    plot_speedup_by_threads(data)
    plot_speedup_scaling(data)
    plot_end_to_end_comparison(data)
    generate_summary_report(data)

    print("\nDone! Check polybench_results/ directory.")
