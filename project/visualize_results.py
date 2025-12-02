#!/usr/bin/env python3

import re
import matplotlib.pyplot as plt
import numpy as np
from collections import defaultdict

def parse_benchmark_results(filename):
    """Parse benchmark results from text file."""
    results = defaultdict(lambda: defaultdict(list))

    with open(filename, 'r') as f:
        content = f.read()

    # Parse different sections
    sections = re.split(r'(?:Original|Parallelized)', content)

    current_config = None
    for section in sections:
        if 'Serial' in section or 'Version' in section:
            # Original serial version
            current_config = 'Serial'
            times = re.findall(r'Array ops: ([\d.]+) seconds', section)
            if times:
                results['Array ops'][current_config].extend([float(t) for t in times])

            times = re.findall(r'Scale offset: ([\d.]+) seconds', section)
            if times:
                results['Scale offset'][current_config].extend([float(t) for t in times])

            times = re.findall(r'Elementwise: ([\d.]+) seconds', section)
            if times:
                results['Elementwise'][current_config].extend([float(t) for t in times])

        elif 'threads' in section:
            # Parallel version with thread count
            match = re.search(r'(\d+) threads', section)
            if match:
                num_threads = match.group(1)
                current_config = f'{num_threads} threads'

                times = re.findall(r'Array ops: ([\d.]+) seconds', section)
                if times:
                    results['Array ops'][current_config].extend([float(t) for t in times])

                times = re.findall(r'Scale offset: ([\d.]+) seconds', section)
                if times:
                    results['Scale offset'][current_config].extend([float(t) for t in times])

                times = re.findall(r'Elementwise: ([\d.]+) seconds', section)
                if times:
                    results['Elementwise'][current_config].extend([float(t) for t in times])

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

    # Extract configurations
    configs = set()
    for bench in benchmarks:
        configs.update(results[bench].keys())

    # Sort configurations: Serial first, then by thread count
    configs = sorted(configs, key=lambda x: (
        0 if x == 'Serial' else 1,
        int(re.search(r'(\d+)', x).group(1)) if re.search(r'(\d+)', x) else 0
    ))

    fig, axes = plt.subplots(1, len(benchmarks), figsize=(15, 5))
    if len(benchmarks) == 1:
        axes = [axes]

    for idx, benchmark in enumerate(benchmarks):
        ax = axes[idx]

        means = []
        stds = []
        labels = []

        for config in configs:
            if config in results[benchmark]:
                mean, std = calculate_statistics(results[benchmark][config])
                means.append(mean)
                stds.append(std)
                labels.append(config)

        if not means:
            continue

        x = np.arange(len(labels))
        bars = ax.bar(x, means, yerr=stds, capsize=5, alpha=0.7)

        # Color serial differently
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
        if means and means[0] > 0:
            for i, (label, mean) in enumerate(zip(labels[1:], means[1:]), start=1):
                speedup = means[0] / mean if mean > 0 else 0
                ax.text(i, mean, f'{speedup:.2f}x', ha='center', va='bottom', fontsize=8)

    plt.tight_layout()
    plt.savefig(output_file, dpi=300, bbox_inches='tight')
    print(f"Visualization saved to: {output_file}")

    # Create speedup chart
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
                    serial_mean, _ = calculate_statistics(results[benchmark]['Serial'])
                    parallel_mean, _ = calculate_statistics(results[benchmark][config])

                    if parallel_mean > 0:
                        speedup = serial_mean / parallel_mean
                        speedups_by_benchmark[benchmark].append(speedup)

    if thread_counts:
        for benchmark in benchmarks:
            if speedups_by_benchmark[benchmark]:
                ax.plot(thread_counts, speedups_by_benchmark[benchmark],
                       marker='o', label=benchmark, linewidth=2)

        # Plot ideal speedup
        ax.plot(thread_counts, thread_counts, 'k--', label='Ideal Speedup', alpha=0.5)

        ax.set_xlabel('Number of Threads')
        ax.set_ylabel('Speedup')
        ax.set_title('Parallel Speedup vs Thread Count')
        ax.legend()
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
            for config in sorted(results[benchmark].keys(),
                               key=lambda x: (0 if x == 'Serial' else 1,
                                            int(re.search(r'(\d+)', x).group(1))
                                            if re.search(r'(\d+)', x) else 0)):
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
            serial_mean, _ = calculate_statistics(results[benchmark].get('Serial', []))

            if serial_mean > 0:
                for config in results[benchmark]:
                    if config != 'Serial':
                        parallel_mean, _ = calculate_statistics(results[benchmark][config])
                        if parallel_mean > 0:
                            speedup = serial_mean / parallel_mean
                            efficiency = (speedup / int(re.search(r'(\d+)', config).group(1))) * 100 \
                                       if re.search(r'(\d+)', config) else 0
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

    print("Generating visualizations...")
    plot_results(results)

    print("Generating performance report...")
    generate_report(results)

    print("\nDone! Check the results/ directory for outputs.")
