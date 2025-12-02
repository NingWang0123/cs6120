#!/usr/bin/env python3

import re
import matplotlib.pyplot as plt
import numpy as np
from collections import defaultdict

def parse_benchmark_results(filename):
    """Parse benchmark results from text file."""
    results = defaultdict(lambda: defaultdict(list))

    with open(filename, 'r') as f:
        lines = f.readlines()

    current_config = None

    for line in lines:
        # Detect configuration
        if 'Serial (Original) Version:' in line:
            current_config = 'Serial'
        elif 'Parallelized Version (' in line and 'threads' in line:
            match = re.search(r'(\d+) threads', line)
            if match:
                current_config = f'{match.group(1)} threads'

        # Parse timing data
        if current_config:
            if 'Array ops:' in line:
                match = re.search(r'Array ops: ([\d.]+) seconds', line)
                if match:
                    results['Array ops'][current_config].append(float(match.group(1)))

            elif 'Scale offset:' in line:
                match = re.search(r'Scale offset: ([\d.]+) seconds', line)
                if match:
                    results['Scale offset'][current_config].append(float(match.group(1)))

            elif 'Elementwise:' in line:
                match = re.search(r'Elementwise: ([\d.]+) seconds', line)
                if match:
                    results['Elementwise'][current_config].append(float(match.group(1)))

    return results

def calculate_statistics(times):
    """Calculate mean and standard deviation."""
    if not times:
        return 0, 0
    return np.mean(times), np.std(times)

def plot_results(results, output_file='results/performance_comparison.png'):
    """Create visualization of benchmark results."""
    benchmarks = list(results.keys())

    if not benchmarks:
        print("No benchmark data found!")
        return

    # Extract configurations and sort them
    configs = set()
    for bench in benchmarks:
        configs.update(results[bench].keys())

    # Sort: Serial first, then by thread count
    configs = sorted(configs, key=lambda x: (
        0 if x == 'Serial' else 1,
        int(re.search(r'(\d+)', x).group(1)) if re.search(r'(\d+)', x) else 0
    ))

    # Create subplots
    fig, axes = plt.subplots(1, len(benchmarks), figsize=(15, 5))
    if len(benchmarks) == 1:
        axes = [axes]

    for idx, benchmark in enumerate(benchmarks):
        ax = axes[idx]

        means = []
        stds = []
        labels = []

        for config in configs:
            if config in results[benchmark] and results[benchmark][config]:
                mean, std = calculate_statistics(results[benchmark][config])
                means.append(mean)
                stds.append(std)
                labels.append(config)

        if not means:
            continue

        x = np.arange(len(labels))
        bars = ax.bar(x, means, yerr=stds, capsize=5, alpha=0.7)

        # Color: serial=red, parallel=green
        if labels:
            bars[0].set_color('red')
            for i in range(1, len(bars)):
                bars[i].set_color('green')

        ax.set_xlabel('Configuration')
        ax.set_ylabel('Time (seconds)')
        ax.set_title(f'{benchmark}')
        ax.set_xticks(x)
        ax.set_xticklabels(labels, rotation=45, ha='right')
        ax.grid(axis='y', alpha=0.3)

        # Add speedup annotations
        if len(means) > 1 and means[0] > 0:
            for i, (label, mean) in enumerate(zip(labels[1:], means[1:]), start=1):
                if mean > 0:
                    speedup = means[0] / mean
                    ax.text(i, mean, f'{speedup:.2f}x', ha='center', va='bottom', fontsize=8)

    plt.tight_layout()
    plt.savefig(output_file, dpi=300, bbox_inches='tight')
    print(f"Visualization saved to: {output_file}")

    # Create speedup chart
    if len(configs) > 1:
        fig, ax = plt.subplots(figsize=(10, 6))

        thread_counts = []
        speedups_by_benchmark = defaultdict(list)

        for config in configs[1:]:  # Skip serial
            match = re.search(r'(\d+)', config)
            if match:
                threads = int(match.group(1))
                thread_counts.append(threads)

                for benchmark in benchmarks:
                    if config in results[benchmark] and 'Serial' in results[benchmark]:
                        if results[benchmark][config] and results[benchmark]['Serial']:
                            serial_mean, _ = calculate_statistics(results[benchmark]['Serial'])
                            parallel_mean, _ = calculate_statistics(results[benchmark][config])

                            if parallel_mean > 0 and serial_mean > 0:
                                speedup = serial_mean / parallel_mean
                                speedups_by_benchmark[benchmark].append(speedup)

        if thread_counts:
            for benchmark in benchmarks:
                if speedups_by_benchmark[benchmark]:
                    ax.plot(thread_counts, speedups_by_benchmark[benchmark],
                           marker='o', label=benchmark, linewidth=2, markersize=8)

            # Plot ideal speedup
            ax.plot(thread_counts, thread_counts, 'k--', label='Ideal Speedup', alpha=0.5)

            ax.set_xlabel('Number of Threads', fontsize=12)
            ax.set_ylabel('Speedup', fontsize=12)
            ax.set_title('Parallel Speedup vs Thread Count', fontsize=14)
            ax.legend(fontsize=10)
            ax.grid(True, alpha=0.3)
            ax.set_xticks(thread_counts)

            plt.tight_layout()
            plt.savefig('results/speedup_analysis.png', dpi=300, bbox_inches='tight')
            print(f"Speedup analysis saved to: results/speedup_analysis.png")

def generate_report(results, output_file='results/performance_report.txt'):
    """Generate a detailed text report."""
    with open(output_file, 'w') as f:
        f.write("=" * 60 + "\n")
        f.write("Loop Parallelization Performance Report\n")
        f.write("=" * 60 + "\n\n")

        for benchmark in results:
            f.write(f"\n{benchmark}:\n")
            f.write("-" * 40 + "\n")

            serial_mean = 0
            configs = sorted(results[benchmark].keys(),
                           key=lambda x: (0 if x == 'Serial' else 1,
                                        int(re.search(r'(\d+)', x).group(1))
                                        if re.search(r'(\d+)', x) else 0))

            for config in configs:
                if results[benchmark][config]:
                    mean, std = calculate_statistics(results[benchmark][config])

                    if config == 'Serial':
                        serial_mean = mean
                        f.write(f"  {config:20s}: {mean:.6f} ± {std:.6f} seconds\n")
                    else:
                        speedup = serial_mean / mean if mean > 0 and serial_mean > 0 else 0
                        f.write(f"  {config:20s}: {mean:.6f} ± {std:.6f} seconds "
                               f"(Speedup: {speedup:.2f}x)\n")

        f.write("\n" + "=" * 60 + "\n")
        f.write("Analysis Summary:\n")
        f.write("=" * 60 + "\n")

        # Calculate average speedups
        for benchmark in results:
            f.write(f"\n{benchmark}:\n")
            if 'Serial' in results[benchmark] and results[benchmark]['Serial']:
                serial_mean, _ = calculate_statistics(results[benchmark]['Serial'])

                if serial_mean > 0:
                    for config in results[benchmark]:
                        if config != 'Serial' and results[benchmark][config]:
                            parallel_mean, _ = calculate_statistics(results[benchmark][config])
                            if parallel_mean > 0:
                                speedup = serial_mean / parallel_mean
                                match = re.search(r'(\d+)', config)
                                if match:
                                    threads = int(match.group(1))
                                    efficiency = (speedup / threads) * 100
                                    f.write(f"  {config}: Speedup = {speedup:.2f}x, "
                                           f"Efficiency = {efficiency:.1f}%\n")

    print(f"Performance report saved to: {output_file}")

if __name__ == '__main__':
    import sys
    import os

    results_file = 'results/benchmark_results.txt'

    if not os.path.exists(results_file):
        print(f"Error: Results file not found: {results_file}")
        print("Please run './run_benchmarks.sh' first.")
        sys.exit(1)

    print("Parsing benchmark results...")
    results = parse_benchmark_results(results_file)

    if not results:
        print("No results found in file!")
        sys.exit(1)

    print(f"Found {len(results)} benchmarks with data")
    for bench, configs in results.items():
        print(f"  {bench}: {len(configs)} configurations")
        for config, times in configs.items():
            print(f"    {config}: {len(times)} data points")

    print("\nGenerating visualizations...")
    plot_results(results)

    print("Generating performance report...")
    generate_report(results)

    print("\nDone! Check the results/ directory for outputs.")
