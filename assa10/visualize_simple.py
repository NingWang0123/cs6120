#!/usr/bin/env python3
"""Generate simplified visualization showing only dynamic instruction counts."""

import json
import matplotlib.pyplot as plt
import numpy as np

# Load results
with open("build/evaluation_summary.json") as f:
    data = json.load(f)

results = data["results"]

# Prepare data for plotting - all test cases
all_labels = []
all_baseline = []
all_traced = []

for bench_name, bench_data in results.items():
    for i, test in enumerate(bench_data['tests']):
        # Create label like "grad-desc (1)", "grad-desc (2)", etc.
        label = f"{bench_name.replace('_', '-')}\n({i+1})"
        all_labels.append(label)
        all_baseline.append(test['baseline'])
        all_traced.append(test['traced'])

# Create figure
fig, ax = plt.subplots(figsize=(12, 6))

x = np.arange(len(all_labels))
width = 0.35

# Create bars
bars1 = ax.bar(x - width/2, all_baseline, width, label='Baseline', color='#2ecc71', alpha=0.8)
bars2 = ax.bar(x + width/2, all_traced, width, label='Traced', color='#e67e22', alpha=0.8)

# Formatting
ax.set_ylabel('Dynamic Instruction Count', fontsize=13, fontweight='bold')
ax.set_xlabel('Benchmark (Test Case)', fontsize=13, fontweight='bold')
ax.set_title('Dynamic Instruction Counts: Baseline vs Traced', fontsize=15, fontweight='bold')
ax.set_xticks(x)
ax.set_xticklabels(all_labels, fontsize=10)
ax.legend(fontsize=12)
ax.grid(axis='y', alpha=0.3)

# Add value labels on bars
for bar in bars1:
    height = bar.get_height()
    ax.text(bar.get_x() + bar.get_width()/2., height,
            f'{int(height)}',
            ha='center', va='bottom', fontsize=8)

for bar in bars2:
    height = bar.get_height()
    ax.text(bar.get_x() + bar.get_width()/2., height,
            f'{int(height)}',
            ha='center', va='bottom', fontsize=8)

plt.tight_layout()
plt.savefig('build/performance_comparison.png', dpi=300, bbox_inches='tight')
print("Visualization saved to: build/performance_comparison.png")
print("✓ Visualization generated successfully!")
