"""
Analyze brench results and calculate performance improvements.
"""

import csv
import sys
from collections import defaultdict
import matplotlib.pyplot as plt
import numpy as np

def analyze_results(csv_file):
    """Analyze the brench CSV results."""
    results = defaultdict(dict)
    
    with open(csv_file, 'r') as f:
        reader = csv.DictReader(f)
        for row in reader:
            benchmark = row['benchmark']
            run = row['run']
            result = row['result']
            
            if result not in ['missing', 'incorrect', 'timeout']:
                try:
                    results[benchmark][run] = int(result)
                except ValueError:
                    continue  # Skip non-numeric results
    
    # Calculate improvements
    improvements = []
    print("Benchmark Performance Analysis")
    print("=" * 50)
    print(f"{'Benchmark':<20} {'Baseline':<10} {'TDCE':<10} {'LVN':<10} {'Combined':<10} {'Best Reduction':<15}")
    print("-" * 90)
    
    for benchmark, runs in results.items():
        if 'baseline' in runs and len(runs) >= 2:
            baseline = runs['baseline']
            line = f"{benchmark:<20} {baseline:<10}"
            
            best_reduction = 0
            for opt_name in ['tdce', 'lvn', 'combined']:
                if opt_name in runs:
                    optimized = runs[opt_name]
                    reduction = ((baseline - optimized) / baseline) * 100
                    best_reduction = max(best_reduction, reduction)
                    line += f" {optimized:<10}"
                else:
                    line += f" {'N/A':<10}"
            
            line += f" {best_reduction:.1f}%"
            print(line)
            
            if 'combined' in runs:
                improvements.append({
                    'benchmark': benchmark,
                    'baseline': baseline,
                    'combined': runs['combined'],
                    'reduction': ((baseline - runs['combined']) / baseline) * 100
                })
    
    # Summary statistics
    if improvements:
        reductions = [imp['reduction'] for imp in improvements]
        avg_reduction = sum(reductions) / len(reductions)
        max_reduction = max(reductions)
        
        print(f"\nSummary:")
        print(f"Benchmarks analyzed: {len(improvements)}")
        print(f"Average instruction reduction: {avg_reduction:.1f}%")
        print(f"Maximum instruction reduction: {max_reduction:.1f}%")
        
        # Show top improvements
        improvements.sort(key=lambda x: x['reduction'], reverse=True)
        print(f"\nTop 5 improvements:")
        for i, imp in enumerate(improvements[:5]):
            print(f"{i+1}. {imp['benchmark']}: {imp['baseline']} → {imp['combined']} ({imp['reduction']:.1f}% reduction)")
        
        # Generate visualizations
        generate_figures(results, improvements)

def generate_figures(results, improvements):
    """Generate visualization figures."""
    
    # Create figure with subplots
    fig, ((ax1, ax2), (ax3, ax4)) = plt.subplots(2, 2, figsize=(15, 12))
    fig.suptitle('TDCE + LVN Optimization Results', fontsize=16, fontweight='bold')
    
    # 1. Reduction percentage histogram
    reductions = [imp['reduction'] for imp in improvements]
    ax1.hist(reductions, bins=15, alpha=0.7, color='skyblue', edgecolor='black')
    ax1.set_xlabel('Instruction Reduction (%)')
    ax1.set_ylabel('Number of Benchmarks')
    ax1.set_title('Distribution of Optimization Improvements')
    ax1.grid(True, alpha=0.3)
    
    # 2. Before vs After scatter plot (log scale for better visibility)
    baselines = [imp['baseline'] for imp in improvements]
    optimized = [imp['combined'] for imp in improvements]
    
    ax2.scatter(baselines, optimized, alpha=0.7, color='red', s=50)
    ax2.set_xscale('log')
    ax2.set_yscale('log')
    ax2.set_xlabel('Baseline Instructions (log scale)')
    ax2.set_ylabel('Optimized Instructions (log scale)')
    ax2.set_title('Before vs After Optimization')
    
    # Add diagonal line (y=x) to show no improvement line
    min_val = min(min(baselines), min(optimized))
    max_val = max(max(baselines), max(optimized))
    ax2.plot([min_val, max_val], [min_val, max_val], 'k--', alpha=0.5, label='No improvement')
    ax2.legend()
    ax2.grid(True, alpha=0.3)
    
    # 3. Top 10 benchmarks improvement bar chart
    top_10 = improvements[:10]
    benchmark_names = [imp['benchmark'][:15] for imp in top_10]  # Truncate long names
    reduction_values = [imp['reduction'] for imp in top_10]
    
    bars = ax3.bar(range(len(top_10)), reduction_values, color='lightgreen', alpha=0.8)
    ax3.set_xlabel('Benchmark')
    ax3.set_ylabel('Instruction Reduction (%)')
    ax3.set_title('Top 10 Optimization Improvements')
    ax3.set_xticks(range(len(top_10)))
    ax3.set_xticklabels(benchmark_names, rotation=45, ha='right')
    ax3.grid(True, alpha=0.3)
    
    # Add value labels on bars
    for i, bar in enumerate(bars):
        height = bar.get_height()
        ax3.text(bar.get_x() + bar.get_width()/2., height,
                f'{height:.1f}%', ha='center', va='bottom', fontsize=8)
    
    # 4. Comparison of optimization techniques
    opt_comparison = defaultdict(list)
    for benchmark, runs in results.items():
        if 'baseline' in runs:
            baseline = runs['baseline']
            for opt_name in ['tdce', 'lvn', 'combined']:
                if opt_name in runs:
                    reduction = ((baseline - runs[opt_name]) / baseline) * 100
                    opt_comparison[opt_name].append(reduction)
    
    # Box plot of optimization techniques
    opt_data = []
    opt_labels = []
    for opt_name in ['tdce', 'lvn', 'combined']:
        if opt_name in opt_comparison:
            opt_data.append(opt_comparison[opt_name])
            opt_labels.append(opt_name.upper())
    
    if opt_data:
        bp = ax4.boxplot(opt_data, labels=opt_labels, patch_artist=True)
        colors = ['lightcoral', 'lightblue', 'lightgreen']
        for patch, color in zip(bp['boxes'], colors):
            patch.set_facecolor(color)
        
        ax4.set_ylabel('Instruction Reduction (%)')
        ax4.set_title('Optimization Technique Comparison')
        ax4.grid(True, alpha=0.3)
    
    plt.tight_layout()
    plt.savefig('optimization_results.png', dpi=300, bbox_inches='tight')
    print(f"\nFigures saved as 'optimization_results.png'")
    
    # Create a separate detailed comparison figure
    create_detailed_comparison(results)

def create_detailed_comparison(results):
    """Create a detailed comparison chart showing all optimization passes."""
    
    # Prepare data for detailed comparison
    benchmarks = []
    baseline_values = []
    tdce_values = []
    lvn_values = []
    combined_values = []
    
    for benchmark, runs in results.items():
        if 'baseline' in runs and 'combined' in runs:
            benchmarks.append(benchmark[:20])  # Truncate names
            baseline_values.append(runs['baseline'])
            tdce_values.append(runs.get('tdce', runs['baseline']))
            lvn_values.append(runs.get('lvn', runs['baseline']))
            combined_values.append(runs['combined'])
    
    # Sort by improvement (combined vs baseline)
    improvements = [(baseline_values[i] - combined_values[i]) / baseline_values[i] 
                   for i in range(len(benchmarks))]
    sorted_indices = sorted(range(len(improvements)), key=lambda i: improvements[i], reverse=True)
    
    # Take top 15 for readability
    top_n = 15
    sorted_indices = sorted_indices[:top_n]
    
    benchmarks = [benchmarks[i] for i in sorted_indices]
    baseline_values = [baseline_values[i] for i in sorted_indices]
    tdce_values = [tdce_values[i] for i in sorted_indices]
    lvn_values = [lvn_values[i] for i in sorted_indices]
    combined_values = [combined_values[i] for i in sorted_indices]
    
    # Create the detailed comparison chart
    fig, ax = plt.subplots(1, 1, figsize=(15, 8))
    
    x = np.arange(len(benchmarks))
    width = 0.2
    
    bars1 = ax.bar(x - 1.5*width, baseline_values, width, label='Baseline', alpha=0.8)
    bars2 = ax.bar(x - 0.5*width, tdce_values, width, label='TDCE', alpha=0.8)
    bars3 = ax.bar(x + 0.5*width, lvn_values, width, label='LVN', alpha=0.8)
    bars4 = ax.bar(x + 1.5*width, combined_values, width, label='Combined', alpha=0.8)
    
    ax.set_xlabel('Benchmark')
    ax.set_ylabel('Dynamic Instructions')
    ax.set_title(f'Optimization Comparison - Top {top_n} Improved Benchmarks')
    ax.set_xticks(x)
    ax.set_xticklabels(benchmarks, rotation=45, ha='right')
    ax.legend()
    ax.grid(True, alpha=0.3)
    
    # Use log scale if values vary significantly
    if max(baseline_values) / min([v for v in combined_values if v > 0]) > 100:
        ax.set_yscale('log')
        ax.set_ylabel('Dynamic Instructions (log scale)')
    
    plt.tight_layout()
    plt.savefig('detailed_comparison.png', dpi=300, bbox_inches='tight')
    print(f"Detailed comparison saved as 'detailed_comparison.png'")

if __name__ == "__main__":
    # Check if matplotlib is available
    try:
        import matplotlib.pyplot as plt
        import numpy as np
    except ImportError:
        print("Warning: matplotlib not available. Install with: pip install matplotlib")
        print("Running analysis without figures...")
        # Remove matplotlib imports and figure generation
        import importlib
        import sys
        current_module = sys.modules[__name__]
        
        # Redefine generate_figures as a no-op
        def generate_figures(results, improvements):
            print("\nFigure generation skipped (matplotlib not installed)")
        
        current_module.generate_figures = generate_figures
    
    analyze_results("results.csv")