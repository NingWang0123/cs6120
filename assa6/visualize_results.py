#!/usr/bin/env python3
"""
Visualization script for SSA transformation overhead analysis.

Creates several visualizations:
1. Bar chart of overhead per program
2. Histogram of overhead percentage distribution
3. Scatter plot of original size vs overhead
4. Summary statistics table
"""

import json
import sys
import matplotlib.pyplot as plt
import matplotlib.patches as mpatches
from pathlib import Path
import numpy as np


def load_results(results_file):
    """Load test results from JSON file."""
    with open(results_file, 'r') as f:
        return json.load(f)


def plot_overhead_per_program(results, output_file='overhead_per_program.png'):
    """Bar chart showing overhead for each program."""
    # Filter successful results
    successful = [r for r in results if r['round_trip_success'] and not r['error']]

    # Sort by overhead percentage
    successful.sort(key=lambda x: (x['static_overhead'] / x['static_original'] * 100) if x['static_original'] > 0 else 0)

    names = [Path(r['file']).stem for r in successful]
    overheads = [r['static_overhead'] for r in successful]
    percentages = [(r['static_overhead'] / r['static_original'] * 100) if r['static_original'] > 0 else 0 for r in successful]

    # Color code by overhead level
    colors = ['green' if p == 0 else 'yellow' if p < 50 else 'orange' if p < 100 else 'red' for p in percentages]

    fig, ax = plt.subplots(figsize=(16, 10))
    bars = ax.bar(range(len(names)), overheads, color=colors, alpha=0.7)

    ax.set_xlabel('Program', fontsize=12)
    ax.set_ylabel('Static Instruction Overhead', fontsize=12)
    ax.set_title('SSA Transformation Static Overhead per Program', fontsize=14, fontweight='bold')
    ax.set_xticks(range(len(names)))
    ax.set_xticklabels(names, rotation=90, ha='right', fontsize=8)

    # Add legend
    green_patch = mpatches.Patch(color='green', label='0% overhead')
    yellow_patch = mpatches.Patch(color='yellow', label='<50% overhead')
    orange_patch = mpatches.Patch(color='orange', label='50-100% overhead')
    red_patch = mpatches.Patch(color='red', label='>100% overhead')
    ax.legend(handles=[green_patch, yellow_patch, orange_patch, red_patch], loc='upper left')

    plt.tight_layout()
    plt.savefig(output_file, dpi=150, bbox_inches='tight')
    print(f"Saved {output_file}")
    plt.close()


def plot_overhead_histogram(results, output_file='overhead_histogram.png'):
    """Histogram of overhead percentage distribution."""
    successful = [r for r in results if r['round_trip_success'] and not r['error']]
    percentages = [(r['static_overhead'] / r['static_original'] * 100) if r['static_original'] > 0 else 0 for r in successful]

    fig, ax = plt.subplots(figsize=(12, 7))
    n, bins, patches = ax.hist(percentages, bins=20, color='steelblue', edgecolor='black', alpha=0.7)

    # Color code bins
    for i, patch in enumerate(patches):
        if bins[i] == 0:
            patch.set_facecolor('green')
        elif bins[i] < 50:
            patch.set_facecolor('yellow')
        elif bins[i] < 100:
            patch.set_facecolor('orange')
        else:
            patch.set_facecolor('red')

    ax.set_xlabel('Overhead Percentage (%)', fontsize=12)
    ax.set_ylabel('Number of Programs', fontsize=12)
    ax.set_title('Distribution of SSA Transformation Overhead', fontsize=14, fontweight='bold')

    # Add statistics text
    mean_pct = np.mean(percentages)
    median_pct = np.median(percentages)
    max_pct = np.max(percentages)
    min_pct = np.min(percentages)

    stats_text = f'Mean: {mean_pct:.1f}%\nMedian: {median_pct:.1f}%\nMin: {min_pct:.1f}%\nMax: {max_pct:.1f}%'
    ax.text(0.95, 0.95, stats_text, transform=ax.transAxes, fontsize=10,
            verticalalignment='top', horizontalalignment='right',
            bbox=dict(boxstyle='round', facecolor='wheat', alpha=0.5))

    plt.tight_layout()
    plt.savefig(output_file, dpi=150, bbox_inches='tight')
    print(f"Saved {output_file}")
    plt.close()


def plot_size_vs_overhead(results, output_file='size_vs_overhead.png'):
    """Scatter plot of original program size vs overhead."""
    successful = [r for r in results if r['round_trip_success'] and not r['error']]

    sizes = [r['static_original'] for r in successful]
    overheads = [r['static_overhead'] for r in successful]
    percentages = [(r['static_overhead'] / r['static_original'] * 100) if r['static_original'] > 0 else 0 for r in successful]

    fig, (ax1, ax2) = plt.subplots(1, 2, figsize=(16, 6))

    # Absolute overhead vs size
    scatter1 = ax1.scatter(sizes, overheads, c=percentages, cmap='RdYlGn_r', alpha=0.6, s=100)
    ax1.set_xlabel('Original Program Size (instructions)', fontsize=12)
    ax1.set_ylabel('Static Instruction Overhead', fontsize=12)
    ax1.set_title('Program Size vs Absolute Overhead', fontsize=13, fontweight='bold')
    ax1.grid(True, alpha=0.3)
    plt.colorbar(scatter1, ax=ax1, label='Overhead %')

    # Percentage overhead vs size
    scatter2 = ax2.scatter(sizes, percentages, c=percentages, cmap='RdYlGn_r', alpha=0.6, s=100)
    ax2.set_xlabel('Original Program Size (instructions)', fontsize=12)
    ax2.set_ylabel('Overhead Percentage (%)', fontsize=12)
    ax2.set_title('Program Size vs Relative Overhead', fontsize=13, fontweight='bold')
    ax2.grid(True, alpha=0.3)
    plt.colorbar(scatter2, ax=ax2, label='Overhead %')

    plt.tight_layout()
    plt.savefig(output_file, dpi=150, bbox_inches='tight')
    print(f"Saved {output_file}")
    plt.close()


def plot_summary_statistics(results, output_file='summary_stats.png'):
    """Create a summary statistics visualization."""
    successful = [r for r in results if r['round_trip_success'] and not r['error']]

    total_original = sum(r['static_original'] for r in successful)
    total_overhead = sum(r['static_overhead'] for r in successful)
    percentages = [(r['static_overhead'] / r['static_original'] * 100) if r['static_original'] > 0 else 0 for r in successful]

    # Count by overhead category
    zero_overhead = sum(1 for p in percentages if p == 0)
    low_overhead = sum(1 for p in percentages if 0 < p < 50)
    medium_overhead = sum(1 for p in percentages if 50 <= p < 100)
    high_overhead = sum(1 for p in percentages if p >= 100)

    fig, ((ax1, ax2), (ax3, ax4)) = plt.subplots(2, 2, figsize=(14, 10))

    # Pie chart of overhead categories
    categories = ['Zero\nOverhead', 'Low\n(<50%)', 'Medium\n(50-100%)', 'High\n(>100%)']
    counts = [zero_overhead, low_overhead, medium_overhead, high_overhead]
    colors_pie = ['green', 'yellow', 'orange', 'red']

    ax1.pie(counts, labels=categories, autopct='%1.1f%%', colors=colors_pie, startangle=90)
    ax1.set_title('Programs by Overhead Category', fontweight='bold')

    # Bar chart of summary stats
    stats_labels = ['Total\nPrograms', 'Passed\nTests', 'Failed\nTests', 'Zero\nOverhead']
    stats_values = [len(results), len(successful), len(results) - len(successful), zero_overhead]
    bars = ax2.bar(stats_labels, stats_values, color=['steelblue', 'green', 'red', 'green'], alpha=0.7)
    ax2.set_ylabel('Count', fontsize=12)
    ax2.set_title('Test Summary Statistics', fontweight='bold')

    for bar, value in zip(bars, stats_values):
        height = bar.get_height()
        ax2.text(bar.get_x() + bar.get_width()/2., height,
                f'{int(value)}', ha='center', va='bottom', fontsize=10, fontweight='bold')

    # Text summary
    ax3.axis('off')
    summary_text = f"""
SSA TRANSFORMATION ANALYSIS SUMMARY

Total Programs Tested: {len(results)}
Successful Transformations: {len(successful)}
Failed Transformations: {len(results) - len(successful)}

INSTRUCTION COUNTS:
  Total Original Instructions: {total_original:,}
  Total Overhead Instructions: {total_overhead:,}
  Overall Overhead: +{(total_overhead/total_original*100):.2f}%

OVERHEAD STATISTICS:
  Mean Overhead: {np.mean(percentages):.2f}%
  Median Overhead: {np.median(percentages):.2f}%
  Std Dev: {np.std(percentages):.2f}%
  Min Overhead: {np.min(percentages):.2f}%
  Max Overhead: {np.max(percentages):.2f}%

AVERAGE PER PROGRAM:
  Avg Original Size: {total_original/len(successful):.1f} instructions
  Avg Overhead: {total_overhead/len(successful):.1f} instructions
    """

    ax3.text(0.1, 0.9, summary_text, transform=ax3.transAxes, fontsize=11,
            verticalalignment='top', fontfamily='monospace',
            bbox=dict(boxstyle='round', facecolor='lightgray', alpha=0.8))

    # Box plot of overhead distribution
    ax4.boxplot(percentages, vert=True, patch_artist=True,
               boxprops=dict(facecolor='lightblue', alpha=0.7),
               medianprops=dict(color='red', linewidth=2))
    ax4.set_ylabel('Overhead Percentage (%)', fontsize=12)
    ax4.set_title('Overhead Distribution (Box Plot)', fontweight='bold')
    ax4.grid(True, alpha=0.3, axis='y')
    ax4.set_xticklabels(['All Programs'])

    plt.tight_layout()
    plt.savefig(output_file, dpi=150, bbox_inches='tight')
    print(f"Saved {output_file}")
    plt.close()


def generate_all_visualizations(results_file, output_dir='.'):
    """Generate all visualizations."""
    results = load_results(results_file)
    output_path = Path(output_dir)

    print(f"\nGenerating visualizations from {results_file}...")
    print(f"Output directory: {output_path.absolute()}\n")

    plot_overhead_per_program(results, output_path / 'overhead_per_program.png')
    plot_overhead_histogram(results, output_path / 'overhead_histogram.png')
    plot_size_vs_overhead(results, output_path / 'size_vs_overhead.png')
    plot_summary_statistics(results, output_path / 'summary_stats.png')

    print(f"\n✓ All visualizations generated successfully!")


if __name__ == '__main__':
    import argparse

    parser = argparse.ArgumentParser(description='Visualize SSA transformation overhead results')
    parser.add_argument('results_file', help='JSON file with test results')
    parser.add_argument('-o', '--output-dir', default='.', help='Output directory for visualizations')

    args = parser.parse_args()

    generate_all_visualizations(args.results_file, args.output_dir)
