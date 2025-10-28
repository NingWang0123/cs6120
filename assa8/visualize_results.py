#!/usr/bin/env python3
"""
Visualization script for LICM optimization analysis.

Creates several visualizations:
1. Bar chart showing programs where LICM was applied
2. Speedup comparison
3. Dynamic instruction reduction
4. Summary statistics
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


def plot_speedup_comparison(results, output_file='speedup_comparison.png'):
    """Bar chart showing speedup for optimized programs."""
    # Filter to programs where LICM was applied
    optimized = [r for r in results if r.get('dynamic_reduction', 0) > 0 and r['correctness_passed']]

    if not optimized:
        print("No optimized programs to visualize")
        return

    # Sort by speedup
    optimized.sort(key=lambda x: x.get('speedup', 1.0), reverse=True)

    names = [Path(r['file']).stem for r in optimized]
    speedups = [r.get('speedup', 1.0) for r in optimized]
    reductions = [r.get('dynamic_reduction', 0) for r in optimized]

    fig, (ax1, ax2) = plt.subplots(1, 2, figsize=(16, 6))

    # Speedup bar chart
    colors = ['green' if s > 1.0 else 'red' for s in speedups]
    bars1 = ax1.barh(names, speedups, color=colors, alpha=0.7)
    ax1.axvline(x=1.0, color='black', linestyle='--', linewidth=1, label='No speedup')
    ax1.set_xlabel('Speedup (higher is better)', fontsize=12)
    ax1.set_title('LICM Speedup by Program', fontsize=14, fontweight='bold')
    ax1.set_xlim(0.95, max(speedups) * 1.05)
    ax1.legend()

    # Add speedup values on bars
    for bar, speedup in zip(bars1, speedups):
        width = bar.get_width()
        ax1.text(width, bar.get_y() + bar.get_height()/2,
                f' {speedup:.3f}x', va='center', fontsize=9)

    # Dynamic instruction reduction
    bars2 = ax2.barh(names, reductions, color='steelblue', alpha=0.7)
    ax2.set_xlabel('Dynamic Instructions Saved', fontsize=12)
    ax2.set_title('Dynamic Instruction Reduction', fontsize=14, fontweight='bold')

    # Add values on bars
    for bar, reduction in zip(bars2, reductions):
        width = bar.get_width()
        ax2.text(width, bar.get_y() + bar.get_height()/2,
                f' {int(reduction)}', va='center', fontsize=9)

    plt.tight_layout()
    plt.savefig(output_file, dpi=150, bbox_inches='tight')
    print(f"Saved {output_file}")
    plt.close()


def plot_optimization_summary(results, output_file='optimization_summary.png'):
    """Summary statistics visualization."""
    optimized = [r for r in results if r.get('dynamic_reduction', 0) > 0 and r['correctness_passed']]

    fig, ((ax1, ax2), (ax3, ax4)) = plt.subplots(2, 2, figsize=(14, 10))

    # Bar chart: instruction savings by program
    names = [Path(r['file']).stem for r in optimized]
    savings = [r.get('dynamic_reduction', 0) for r in optimized]

    # Sort by savings
    sorted_pairs = sorted(zip(names, savings), key=lambda x: x[1], reverse=True)
    names, savings = zip(*sorted_pairs) if sorted_pairs else ([], [])

    bars = ax1.barh(names, savings, color='steelblue', alpha=0.7)
    ax1.set_xlabel('Dynamic Instructions Saved', fontsize=12)
    ax1.set_title('Instruction Savings by Program', fontweight='bold', fontsize=13)
    ax1.grid(True, alpha=0.3, axis='x')

    for bar, saving in zip(bars, savings):
        width = bar.get_width()
        ax1.text(width, bar.get_y() + bar.get_height()/2,
                f' {int(saving)}', va='center', fontsize=9)

    # Bar chart: speedup by program
    names_speedup = [Path(r['file']).stem for r in optimized]
    speedups = [r.get('speedup', 1.0) for r in optimized]

    # Sort by speedup
    sorted_pairs2 = sorted(zip(names_speedup, speedups), key=lambda x: x[1], reverse=True)
    names_speedup, speedups = zip(*sorted_pairs2) if sorted_pairs2 else ([], [])

    colors = ['darkgreen' if s > 1.05 else 'green' for s in speedups]
    bars2 = ax2.barh(names_speedup, speedups, color=colors, alpha=0.7)
    ax2.axvline(x=1.0, color='black', linestyle='--', linewidth=1)
    ax2.set_xlabel('Speedup', fontsize=12)
    ax2.set_title('Speedup by Program', fontweight='bold', fontsize=13)
    ax2.grid(True, alpha=0.3, axis='x')

    for bar, speedup in zip(bars2, speedups):
        width = bar.get_width()
        ax2.text(width, bar.get_y() + bar.get_height()/2,
                f' {speedup:.3f}x', va='center', fontsize=9)

    # Text summary
    ax3.axis('off')

    total_orig_dynamic = sum(r.get('dynamic_original', 0) for r in optimized)
    total_opt_dynamic = sum(r.get('dynamic_optimized', 0) for r in optimized)
    total_reduction = sum(r.get('dynamic_reduction', 0) for r in optimized)
    avg_speedup = np.mean([r.get('speedup', 1.0) for r in optimized])
    max_speedup_prog = max(optimized, key=lambda r: r.get('speedup', 1.0))
    min_speedup_prog = min(optimized, key=lambda r: r.get('speedup', 1.0))

    summary_text = f"""
LICM OPTIMIZATION RESULTS

Programs Successfully Optimized: {len(optimized)}

DYNAMIC INSTRUCTION SAVINGS:
  Total Original: {total_orig_dynamic:,}
  Total Optimized: {total_opt_dynamic:,}
  Total Saved: {total_reduction:,}
  Reduction Rate: {(total_reduction/total_orig_dynamic*100):.2f}%

SPEEDUP STATISTICS:
  Average Speedup: {avg_speedup:.3f}x
  Best Speedup: {max_speedup_prog.get('speedup', 1.0):.3f}x
    Program: {Path(max_speedup_prog['file']).stem}
  Lowest Speedup: {min_speedup_prog.get('speedup', 1.0):.3f}x
    Program: {Path(min_speedup_prog['file']).stem}

INSTRUCTION SAVINGS:
  Average per program: {total_reduction/len(optimized):.1f}
  Maximum: {max(r.get('dynamic_reduction', 0) for r in optimized):,}
  Minimum: {min(r.get('dynamic_reduction', 0) for r in optimized):,}
    """

    ax3.text(0.1, 0.9, summary_text, transform=ax3.transAxes, fontsize=11,
            verticalalignment='top', fontfamily='monospace',
            bbox=dict(boxstyle='round', facecolor='lightgreen', alpha=0.3))

    # Scatter: instruction savings vs speedup
    savings_data = [r.get('dynamic_reduction', 0) for r in optimized]
    speedup_data = [r.get('speedup', 1.0) for r in optimized]

    scatter = ax4.scatter(savings_data, speedup_data, c=speedup_data, cmap='RdYlGn',
                         s=200, alpha=0.7, edgecolors='black', linewidths=1.5)
    ax4.set_xlabel('Dynamic Instructions Saved', fontsize=12)
    ax4.set_ylabel('Speedup', fontsize=12)
    ax4.set_title('Instruction Savings vs Speedup', fontweight='bold', fontsize=13)
    ax4.axhline(y=1.0, color='gray', linestyle='--', linewidth=1, alpha=0.5)
    ax4.grid(True, alpha=0.3)

    # Add colorbar
    cbar = plt.colorbar(scatter, ax=ax4, label='Speedup')

    # Annotate points
    for i, (sav, speed, r) in enumerate(zip(savings_data, speedup_data, optimized)):
        name = Path(r['file']).stem
        ax4.annotate(name, (sav, speed), fontsize=7, ha='right',
                    xytext=(-5, 5), textcoords='offset points')

    plt.tight_layout()
    plt.savefig(output_file, dpi=150, bbox_inches='tight')
    print(f"Saved {output_file}")
    plt.close()


def plot_instruction_analysis(results, output_file='instruction_analysis.png'):
    """Analyze static vs dynamic instruction counts."""
    successful = [r for r in results if r['correctness_passed'] and not r.get('error')]
    optimized = [r for r in successful if r.get('dynamic_reduction', 0) > 0]

    if not optimized:
        print("No optimized programs for instruction analysis")
        return

    fig, (ax1, ax2) = plt.subplots(1, 2, figsize=(14, 6))

    names = [Path(r['file']).stem for r in optimized]
    static_orig = [r.get('static_original', 0) for r in optimized]
    static_opt = [r.get('static_optimized', 0) for r in optimized]
    dynamic_orig = [r.get('dynamic_original', 0) for r in optimized]
    dynamic_opt = [r.get('dynamic_optimized', 0) for r in optimized]

    # Static instruction comparison
    x = np.arange(len(names))
    width = 0.35

    bars1 = ax1.bar(x - width/2, static_orig, width, label='Original', color='lightblue', alpha=0.7)
    bars2 = ax1.bar(x + width/2, static_opt, width, label='After LICM', color='darkblue', alpha=0.7)

    ax1.set_xlabel('Program', fontsize=11)
    ax1.set_ylabel('Static Instruction Count', fontsize=11)
    ax1.set_title('Static Instructions: Original vs LICM', fontweight='bold', fontsize=12)
    ax1.set_xticks(x)
    ax1.set_xticklabels(names, rotation=45, ha='right', fontsize=9)
    ax1.legend()
    ax1.grid(True, alpha=0.3, axis='y')

    # Dynamic instruction comparison (logarithmic scale for large differences)
    bars3 = ax2.bar(x - width/2, dynamic_orig, width, label='Original', color='lightcoral', alpha=0.7)
    bars4 = ax2.bar(x + width/2, dynamic_opt, width, label='After LICM', color='darkred', alpha=0.7)

    ax2.set_xlabel('Program', fontsize=11)
    ax2.set_ylabel('Dynamic Instruction Count (log scale)', fontsize=11)
    ax2.set_title('Dynamic Instructions: Original vs LICM', fontweight='bold', fontsize=12)
    ax2.set_xticks(x)
    ax2.set_xticklabels(names, rotation=45, ha='right', fontsize=9)
    ax2.set_yscale('log')
    ax2.legend()
    ax2.grid(True, alpha=0.3, axis='y')

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

    plot_speedup_comparison(results, output_path / 'speedup_comparison.png')
    plot_optimization_summary(results, output_path / 'optimization_summary.png')
    plot_instruction_analysis(results, output_path / 'instruction_analysis.png')

    print(f"\n✓ All visualizations generated successfully!")


if __name__ == '__main__':
    import argparse

    parser = argparse.ArgumentParser(description='Visualize LICM optimization results')
    parser.add_argument('results_file', help='JSON file with test results')
    parser.add_argument('-o', '--output-dir', default='.', help='Output directory for visualizations')

    args = parser.parse_args()

    generate_all_visualizations(args.results_file, args.output_dir)
