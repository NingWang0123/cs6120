#!/usr/bin/env python3
"""
Visualization script for LLVM Float Division Optimization Pass results.
Compares instruction counts and execution times between original and optimized versions.
"""

import matplotlib.pyplot as plt
import numpy as np

# Data from benchmarks
programs = {
    'test.c': {
        'original_fdiv': 15,
        'optimized_fdiv': 5,
        'optimized_fmul': 10,
    },
    'benchmark.c': {
        'original_fdiv': 16,
        'optimized_fdiv': 10,
        'optimized_fmul': 12,
    }
}

# Timing data (in seconds, averaged over 10 runs)
timing_data = {
    'Original (-O0)': 0.267413,
    'Optimized (-O0)': 0.255862,
}

# Create figure with two subplots
fig, (ax1, ax2) = plt.subplots(1, 2, figsize=(14, 5))

# ========== Plot 1: Instruction Count Comparison ==========
programs_list = list(programs.keys())
x = np.arange(len(programs_list))
width = 0.25

original_fdiv = [programs[p]['original_fdiv'] for p in programs_list]
optimized_fdiv = [programs[p]['optimized_fdiv'] for p in programs_list]
optimized_fmul = [programs[p]['optimized_fmul'] for p in programs_list]

bars1 = ax1.bar(x - width, original_fdiv, width, label='Original fdiv', color='#e74c3c', alpha=0.8)
bars2 = ax1.bar(x, optimized_fdiv, width, label='Optimized fdiv', color='#3498db', alpha=0.8)
bars3 = ax1.bar(x + width, optimized_fmul, width, label='fdiv → fmul', color='#2ecc71', alpha=0.8)

ax1.set_xlabel('Program', fontsize=12, fontweight='bold')
ax1.set_ylabel('Instruction Count', fontsize=12, fontweight='bold')
ax1.set_title('Instruction Count: Original vs Optimized', fontsize=14, fontweight='bold', pad=20)
ax1.set_xticks(x)
ax1.set_xticklabels(programs_list)
ax1.legend(loc='upper right', framealpha=0.9)
ax1.grid(axis='y', alpha=0.3, linestyle='--')

# Add value labels on bars
for bars in [bars1, bars2, bars3]:
    for bar in bars:
        height = bar.get_height()
        ax1.text(bar.get_x() + bar.get_width()/2., height,
                f'{int(height)}',
                ha='center', va='bottom', fontsize=10, fontweight='bold')

# ========== Plot 2: Execution Time Comparison ==========
labels = list(timing_data.keys())
times = list(timing_data.values())
colors = ['#e74c3c', '#2ecc71']

bars = ax2.bar(labels, times, color=colors, alpha=0.8, width=0.6)

ax2.set_ylabel('Execution Time (seconds)', fontsize=12, fontweight='bold')
ax2.set_title('Execution Time: Original vs Optimized\n(10M iterations, averaged over 10 runs)',
              fontsize=14, fontweight='bold', pad=20)
ax2.grid(axis='y', alpha=0.3, linestyle='--')

# Add value labels and percentage improvement
for i, (bar, time) in enumerate(zip(bars, times)):
    ax2.text(bar.get_x() + bar.get_width()/2., bar.get_height(),
            f'{time:.4f}s',
            ha='center', va='bottom', fontsize=11, fontweight='bold')

# Add speedup annotation
speedup = timing_data['Original (-O0)'] / timing_data['Optimized (-O0)']
improvement = (timing_data['Original (-O0)'] - timing_data['Optimized (-O0)']) / timing_data['Original (-O0)'] * 100

ax2.text(0.5, max(times) * 0.5,
         f'Speedup: {speedup:.3f}x\nImprovement: {improvement:.2f}%',
         ha='center', va='center',
         bbox=dict(boxstyle='round,pad=0.8', facecolor='yellow', alpha=0.3, edgecolor='black', linewidth=2),
         fontsize=13, fontweight='bold')

# Adjust layout
plt.tight_layout()

# Save figure
output_file = 'optimization_results.png'
plt.savefig(output_file, dpi=300, bbox_inches='tight', facecolor='white')
print(f"Visualization saved to {output_file}")

# Show summary statistics
print("\n" + "="*60)
print("OPTIMIZATION SUMMARY")
print("="*60)
print(f"\nInstruction Count Reduction (test.c):")
print(f"  Original fdiv: {programs['test.c']['original_fdiv']}")
print(f"  Optimized fdiv: {programs['test.c']['optimized_fdiv']} ({programs['test.c']['optimized_fdiv']/programs['test.c']['original_fdiv']*100:.1f}%)")
print(f"  Converted to fmul: {programs['test.c']['optimized_fmul']} ({programs['test.c']['optimized_fmul']/programs['test.c']['original_fdiv']*100:.1f}%)")

print(f"\nInstruction Count Reduction (benchmark.c):")
print(f"  Original fdiv: {programs['benchmark.c']['original_fdiv']}")
print(f"  Optimized fdiv: {programs['benchmark.c']['optimized_fdiv']} ({programs['benchmark.c']['optimized_fdiv']/programs['benchmark.c']['original_fdiv']*100:.1f}%)")
print(f"  Converted to fmul: {programs['benchmark.c']['optimized_fmul']} ({programs['benchmark.c']['optimized_fmul']/programs['benchmark.c']['original_fdiv']*100:.1f}%)")

print(f"\nExecution Time:")
print(f"  Original: {timing_data['Original (-O0)']:.6f} seconds")
print(f"  Optimized: {timing_data['Optimized (-O0)']:.6f} seconds")
print(f"  Speedup: {speedup:.4f}x")
print(f"  Improvement: {improvement:.2f}%")
print("="*60)
