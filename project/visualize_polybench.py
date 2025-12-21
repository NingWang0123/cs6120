#!/usr/bin/env python3
"""
Visualize PolyBench results comparing implementations
with thread counts (2, 4, 8) against serial baseline.

Robust to N/A / missing values in some columns.
"""

import pandas as pd
import matplotlib.pyplot as plt
from pathlib import Path

RESULTS_DIR = "polybench_results"
OUTPUT_DIR = RESULTS_DIR

THREAD_COUNTS = [2, 4, 8]
IMPL_COLORS = {
    "Original": "#3498db",
    "Fusion": "#2ecc71",
    "Fusion+Shared": "#e74c3c",
    "SharedOnly": "#9b59b6",
}

def load_data():
    csv_file = Path(RESULTS_DIR) / "results.csv"
    if not csv_file.exists():
        print(f"Error: {csv_file} not found")
        print("Please run './run_polybench.sh' first.")
        return None

    # Treat "N/A" as missing
    df = pd.read_csv(csv_file, na_values=["N/A", ""])

    # Require serial_time to exist (otherwise nothing meaningful)
    if "serial_time" not in df.columns:
        print("Error: results.csv missing 'serial_time' column.")
        return None

    df["serial_time"] = pd.to_numeric(df["serial_time"], errors="coerce")
    df = df.dropna(subset=["serial_time"])

    # Convert expected numeric columns if present
    maybe_numeric = [
        "parallel_2t","speedup_2t",
        "parallel_4t","speedup_4t",
        "parallel_8t","speedup_8t",
        "parallelizable_loops",
        "fusion_succeeded_pairs","fusion_candidates","fusion_attempts",
    ]
    for col in maybe_numeric:
        if col in df.columns:
            df[col] = pd.to_numeric(df[col], errors="coerce")

    return df

def plot_implementation_speedup_comparison(df):
    implementations = sorted(df["implementation"].unique())

    df_parallel = df.copy()
    if "parallelizable_loops" in df_parallel.columns:
        df_parallel = df_parallel[df_parallel["parallelizable_loops"].fillna(0) > 0]

    if len(df_parallel) == 0:
        print("No parallelizable benchmarks found (parallelizable_loops > 0).")
        return

    fig, axes = plt.subplots(1, 3, figsize=(18, 6))

    for idx, threads in enumerate(THREAD_COUNTS):
        ax = axes[idx]
        speedup_col = f"speedup_{threads}t"
        if speedup_col not in df_parallel.columns:
            continue

        data_by_impl = []
        labels = []

        for impl in implementations:
            s = df_parallel[df_parallel["implementation"] == impl][speedup_col].dropna()
            if len(s) > 0:
                data_by_impl.append(s)
                labels.append(impl)

        if not data_by_impl:
            ax.set_title(f"{threads} threads: no valid speedups")
            continue

        bp = ax.boxplot(
            data_by_impl, labels=labels, patch_artist=True,
            showmeans=True, meanline=True
        )

        for patch, label in zip(bp["boxes"], labels):
            patch.set_facecolor(IMPL_COLORS.get(label, "#95a5a6"))
            patch.set_alpha(0.7)

        ax.axhline(y=1.0, color="red", linestyle="--", linewidth=2, alpha=0.5)
        ax.set_ylabel("Speedup")
        ax.set_title(f"Speedup Distribution ({threads} Threads)")
        ax.grid(axis="y", alpha=0.3)

        # Mean text labels
        for i, (series, label) in enumerate(zip(data_by_impl, labels)):
            mean_val = series.mean()
            ax.text(i + 1, mean_val, f"{mean_val:.2f}x",
                    ha="center", va="bottom", fontsize=9, weight="bold")

    plt.tight_layout()
    out = Path(OUTPUT_DIR) / "implementation_speedup_comparison.png"
    plt.savefig(out, dpi=300, bbox_inches="tight")
    print(f"Saved: {out}")

def plot_speedup_scaling(df):
    implementations = sorted(df["implementation"].unique())

    df_parallel = df.copy()
    if "parallelizable_loops" in df_parallel.columns:
        df_parallel = df_parallel[df_parallel["parallelizable_loops"].fillna(0) > 0]

    if len(df_parallel) == 0:
        print("No parallelizable benchmarks found (parallelizable_loops > 0).")
        return

    fig, ax = plt.subplots(figsize=(10, 7))

    for impl in implementations:
        impl_data = df_parallel[df_parallel["implementation"] == impl]
        means = []
        stds = []

        for threads in THREAD_COUNTS:
            col = f"speedup_{threads}t"
            if col not in impl_data.columns:
                means.append(float("nan"))
                stds.append(float("nan"))
                continue

            vals = impl_data[col].dropna()
            means.append(vals.mean() if len(vals) else float("nan"))
            stds.append(vals.std() if len(vals) else float("nan"))

        ax.errorbar(
            THREAD_COUNTS, means, yerr=stds, marker="o", linewidth=2,
            markersize=10, label=impl, capsize=5, alpha=0.8,
            color=IMPL_COLORS.get(impl, None)
        )

    ax.plot(THREAD_COUNTS, THREAD_COUNTS, "k--", linewidth=2, alpha=0.5, label="Ideal Speedup")
    ax.axhline(y=1.0, color="red", linestyle=":", linewidth=1, alpha=0.5)

    ax.set_xlabel("Number of Threads")
    ax.set_ylabel("Average Speedup")
    ax.set_title("Speedup Scaling Across Thread Counts (parallelizable only)")
    ax.set_xticks(THREAD_COUNTS)
    ax.legend()
    ax.grid(True, alpha=0.3)

    plt.tight_layout()
    out = Path(OUTPUT_DIR) / "speedup_scaling.png"
    plt.savefig(out, dpi=300, bbox_inches="tight")
    print(f"Saved: {out}")

def plot_parallelizable_coverage(df):
    implementations = sorted(df["implementation"].unique())
    fig, (ax1, ax2) = plt.subplots(1, 2, figsize=(14, 6))

    # If column missing, treat as 0
    if "parallelizable_loops" not in df.columns:
        df["parallelizable_loops"] = 0

    counts = []
    labels = []
    for impl in implementations:
        impl_data = df[df["implementation"] == impl]
        parallelizable = (impl_data["parallelizable_loops"].fillna(0) > 0).sum()
        total = len(impl_data)
        counts.append(parallelizable)
        labels.append(f"{impl}\n({parallelizable}/{total})")

    bars = ax1.bar(range(len(implementations)), counts, alpha=0.8, edgecolor="black")
    ax1.set_xticks(range(len(implementations)))
    ax1.set_xticklabels(labels)
    ax1.set_ylabel("Number of Parallelizable Benchmarks")
    ax1.set_title("Parallelizable Benchmark Count by Implementation")
    ax1.grid(axis="y", alpha=0.3)

    for bar, c in zip(bars, counts):
        ax1.text(bar.get_x() + bar.get_width()/2., bar.get_height(), f"{c}",
                 ha="center", va="bottom", fontsize=12, weight="bold")

    # Histogram of loop counts
    for impl in implementations:
        impl_data = df[df["implementation"] == impl]
        loops = impl_data[impl_data["parallelizable_loops"].fillna(0) > 0]["parallelizable_loops"].dropna()
        if len(loops):
            ax2.hist(loops, bins=20, alpha=0.6, label=impl, edgecolor="black",
                     color=IMPL_COLORS.get(impl, None))

    ax2.set_xlabel("Number of Parallelizable Loops")
    ax2.set_ylabel("Frequency")
    ax2.set_title("Distribution of Parallelizable Loops")
    ax2.legend()
    ax2.grid(axis="y", alpha=0.3)

    plt.tight_layout()
    out = Path(OUTPUT_DIR) / "parallelizable_coverage.png"
    plt.savefig(out, dpi=300, bbox_inches="tight")
    print(f"Saved: {out}")

def generate_summary_report(df):
    out = Path(OUTPUT_DIR) / "summary.txt"
    implementations = sorted(df["implementation"].unique())

    if "parallelizable_loops" not in df.columns:
        df["parallelizable_loops"] = 0

    with open(out, "w") as f:
        f.write("=" * 80 + "\n")
        f.write("PolyBench Loop Parallelization Summary\n")
        f.write("=" * 80 + "\n\n")

        f.write(f"Unique benchmarks: {len(df['benchmark'].unique())}\n")
        f.write(f"Implementations: {', '.join(implementations)}\n\n")

        for impl in implementations:
            impl_data = df[df["implementation"] == impl]
            par = (impl_data["parallelizable_loops"].fillna(0) > 0).sum()
            f.write(f"{impl}:\n")
            f.write(f"  Rows: {len(impl_data)}\n")
            f.write(f"  Parallelizable: {par}/{len(impl_data)}\n")

            for threads in THREAD_COUNTS:
                col = f"speedup_{threads}t"
                if col in impl_data.columns:
                    vals = impl_data[impl_data["parallelizable_loops"].fillna(0) > 0][col].dropna()
                    if len(vals):
                        f.write(f"  {threads}t mean speedup: {vals.mean():.2f}x  (n={len(vals)})\n")
            f.write("\n")

    print(f"Saved: {out}")

if __name__ == "__main__":
    print("Loading PolyBench results...")
    df = load_data()

    if df is None or len(df) == 0:
        print("No valid results found!")
        raise SystemExit(1)

    print(f"Loaded {len(df)} rows")
    print(f"Unique benchmarks: {len(df['benchmark'].unique())}")
    print(f"Implementations: {', '.join(sorted(df['implementation'].unique()))}")
    print()

    print("Generating visualizations...")
    plot_implementation_speedup_comparison(df)
    plot_speedup_scaling(df)
    plot_parallelizable_coverage(df)

    print("Generating summary report...")
    generate_summary_report(df)

    print(f"\nDone! Check {RESULTS_DIR}/ directory for outputs.")
