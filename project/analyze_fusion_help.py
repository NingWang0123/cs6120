#!/usr/bin/env python3
"""
Analyze whether fusion helps (vs baselines) and draw plots.

Inputs:
  polybench_results/results.csv

Outputs:
  polybench_results/fusion_help.csv
  polybench_results/fusion_helps_counts.png
  polybench_results/fusion_helps_by_threads.png
  polybench_results/fusion_delta_speedup_box.png
"""

import math
from pathlib import Path

import pandas as pd
import matplotlib.pyplot as plt

IN = "polybench_results/results.csv"
OUT = "polybench_results/fusion_help.csv"
OUT_DIR = Path("polybench_results")

# ----------------------------
# Parsing helpers
# ----------------------------
def to_float(x):
    try:
        if pd.isna(x):
            return math.nan
        x = str(x).strip()
        if x.upper() == "N/A" or x == "":
            return math.nan
        return float(x)
    except Exception:
        return math.nan

# ----------------------------
# Load + normalize
# ----------------------------
df = pd.read_csv(IN)

num_cols = [
    "serial_time",
    "parallel_2t", "speedup_2t",
    "parallel_4t", "speedup_4t",
    "parallel_8t", "speedup_8t",
    "parallelizable_loops",
    "fusion_succeeded_pairs", "fusion_candidates", "fusion_attempts",
]
for c in num_cols:
    if c in df.columns:
        df[c] = df[c].apply(to_float)

# Index by (benchmark, implementation)
idx = {(r["benchmark"], r["implementation"]): r for _, r in df.iterrows()}

def compare(bench, impl_a, impl_b):
    """
    Compare candidate impl_b vs baseline impl_a for one benchmark.

    Returns dict with:
      - delta_speedup_{2t,4t,8t} = speedup_b - speedup_a (positive is better)
      - time_ratio_{2t,4t,8t} = time_a / time_b ( >1 means candidate faster)
      - fusion_helps_any: fusion applied AND improvement in any thread count
      - fusion_helps_{2t,4t,8t}: per-thread help flags
    """
    ra = idx.get((bench, impl_a))
    rb = idx.get((bench, impl_b))
    if ra is None or rb is None:
        return None

    fused_pairs = rb.get("fusion_succeeded_pairs", math.nan)

    require_fusion = impl_b in ("Fusion", "Fusion+Shared")
    fusion_applied = (not math.isnan(fused_pairs)) and (fused_pairs > 0)

    out = {
        "benchmark": bench,
        "baseline": impl_a,
        "candidate": impl_b,
        "fusion_applied_pairs": fused_pairs if not math.isnan(fused_pairs) else 0.0,
        "fusion_applied": int(fusion_applied) if require_fusion else 0,
    }

    helps_any = False
    for t in ("2t", "4t", "8t"):
        sa = ra.get(f"speedup_{t}", math.nan)
        sb = rb.get(f"speedup_{t}", math.nan)
        ds = (sb - sa) if (not math.isnan(sa) and not math.isnan(sb)) else math.nan
        out[f"delta_speedup_{t}"] = ds

        ta = ra.get(f"parallel_{t}", math.nan)
        tb = rb.get(f"parallel_{t}", math.nan)
        tr = (ta / tb) if (not math.isnan(ta) and not math.isnan(tb) and tb > 0) else math.nan
        out[f"time_ratio_{t}"] = tr

        helps_t = False
        if require_fusion and fusion_applied:
            if (not math.isnan(ds) and ds > 0) or (not math.isnan(tr) and tr > 1.0):
                helps_t = True
        out[f"fusion_helps_{t}"] = int(helps_t)
        helps_any = helps_any or helps_t

    out["fusion_helps_any"] = int(helps_any)
    return out

rows = []
benchmarks = sorted(set(df["benchmark"].tolist()))

# Main comparisons
for b in benchmarks:
    c1 = compare(b, "Original", "Fusion")
    if c1: rows.append(c1)
    c2 = compare(b, "Original", "Fusion+Shared")
    if c2: rows.append(c2)
    # Optional: isolate “shared builder” effect
    c3 = compare(b, "Fusion", "Fusion+Shared")
    if c3: rows.append(c3)

out_df = pd.DataFrame(rows)
out_df.to_csv(OUT, index=False)
print(f"Wrote {OUT} with {len(out_df)} rows.")

# ----------------------------
# Plotting helpers
# ----------------------------
def safe_mean(series: pd.Series):
    s = pd.to_numeric(series, errors="coerce").dropna()
    return float(s.mean()) if len(s) else float("nan")

def plot_fusion_help_counts(out_df: pd.DataFrame):
    """
    Bar chart: for each comparison, count how many benchmarks:
      - fusion applied
      - fusion helps (any thread)
      - fusion applied but did not help
    """
    dfp = out_df.copy()

    # Only comparisons where candidate is a fusion impl
    dfp = dfp[dfp["candidate"].isin(["Fusion", "Fusion+Shared"])]

    if len(dfp) == 0:
        print("No Fusion/Fusion+Shared rows to plot.")
        return

    groups = []
    applied_counts = []
    helps_counts = []
    not_help_counts = []

    for (baseline, cand), g in dfp.groupby(["baseline", "candidate"]):
        label = f"{cand} vs {baseline}"
        groups.append(label)

        applied = int((g["fusion_applied"] == 1).sum())
        helps = int(((g["fusion_applied"] == 1) & (g["fusion_helps_any"] == 1)).sum())
        not_help = int(((g["fusion_applied"] == 1) & (g["fusion_helps_any"] == 0)).sum())

        applied_counts.append(applied)
        helps_counts.append(helps)
        not_help_counts.append(not_help)

    x = range(len(groups))
    width = 0.25

    plt.figure(figsize=(12, 6))
    plt.bar([i - width for i in x], applied_counts, width=width, label="Fusion applied (pairs>0)")
    plt.bar([i for i in x], helps_counts, width=width, label="Fusion helps (any thread)")
    plt.bar([i + width for i in x], not_help_counts, width=width, label="Applied but no help")

    plt.xticks(list(x), groups, rotation=15, ha="right")
    plt.ylabel("Number of benchmarks")
    plt.title("How often fusion applied vs helped")
    plt.legend()
    plt.grid(axis="y", alpha=0.3)

    out = OUT_DIR / "fusion_helps_counts.png"
    plt.tight_layout()
    plt.savefig(out, dpi=300, bbox_inches="tight")
    print(f"Saved: {out}")

def plot_fusion_help_by_threads(out_df: pd.DataFrame):
    """
    For each comparison, plot counts of fusion_helps_{2t,4t,8t}.
    """
    dfp = out_df.copy()
    dfp = dfp[dfp["candidate"].isin(["Fusion", "Fusion+Shared"])]

    if len(dfp) == 0:
        print("No Fusion/Fusion+Shared rows to plot.")
        return

    groups = []
    h2, h4, h8 = [], [], []

    for (baseline, cand), g in dfp.groupby(["baseline", "candidate"]):
        label = f"{cand} vs {baseline}"
        groups.append(label)

        # Only consider benchmarks where fusion actually applied
        gg = g[g["fusion_applied"] == 1]
        h2.append(int((gg["fusion_helps_2t"] == 1).sum()))
        h4.append(int((gg["fusion_helps_4t"] == 1).sum()))
        h8.append(int((gg["fusion_helps_8t"] == 1).sum()))

    x = range(len(groups))
    width = 0.25

    plt.figure(figsize=(12, 6))
    plt.bar([i - width for i in x], h2, width=width, label="Helps @ 2 threads")
    plt.bar([i for i in x], h4, width=width, label="Helps @ 4 threads")
    plt.bar([i + width for i in x], h8, width=width, label="Helps @ 8 threads")

    plt.xticks(list(x), groups, rotation=15, ha="right")
    plt.ylabel("Number of benchmarks (fusion applied)")
    plt.title("Fusion helps counts by thread count")
    plt.legend()
    plt.grid(axis="y", alpha=0.3)

    out = OUT_DIR / "fusion_helps_by_threads.png"
    plt.tight_layout()
    plt.savefig(out, dpi=300, bbox_inches="tight")
    print(f"Saved: {out}")

def plot_delta_speedup_box(out_df: pd.DataFrame):
    """
    Box plot of delta_speedup_8t (and 2t/4t) for fusion comparisons,
    considering only benchmarks where fusion applied.
    """
    dfp = out_df.copy()
    dfp = dfp[dfp["candidate"].isin(["Fusion", "Fusion+Shared"])]

    if len(dfp) == 0:
        print("No Fusion/Fusion+Shared rows to plot.")
        return

    # Only where fusion actually applied
    dfp = dfp[dfp["fusion_applied"] == 1]
    if len(dfp) == 0:
        print("Fusion never applied (pairs>0) in these rows; nothing to plot.")
        return

    comps = []
    data_2, data_4, data_8 = [], [], []

    for (baseline, cand), g in dfp.groupby(["baseline", "candidate"]):
        label = f"{cand} vs {baseline}"
        comps.append(label)

        data_2.append(pd.to_numeric(g["delta_speedup_2t"], errors="coerce").dropna())
        data_4.append(pd.to_numeric(g["delta_speedup_4t"], errors="coerce").dropna())
        data_8.append(pd.to_numeric(g["delta_speedup_8t"], errors="coerce").dropna())

    # Plot 8t by default (most interesting), but include 2t/4t as separate boxes per comp
    # We'll make grouped boxplots: [comp1-2t, comp1-4t, comp1-8t, comp2-2t, ...]
    labels = []
    series_list = []
    for comp, s2, s4, s8 in zip(comps, data_2, data_4, data_8):
        labels.extend([f"{comp}\n2t", f"{comp}\n4t", f"{comp}\n8t"])
        series_list.extend([s2, s4, s8])

    plt.figure(figsize=(max(12, 2 * len(labels)), 6))
    plt.boxplot(series_list, labels=labels, showmeans=True, meanline=True)
    plt.axhline(y=0.0, linestyle="--", linewidth=1)
    plt.ylabel("Delta speedup (candidate - baseline)")
    plt.title("Distribution of delta speedup where fusion applied")
    plt.grid(axis="y", alpha=0.3)

    out = OUT_DIR / "fusion_delta_speedup_box.png"
    plt.tight_layout()
    plt.savefig(out, dpi=300, bbox_inches="tight")
    print(f"Saved: {out}")

# ----------------------------
# Make plots
# ----------------------------
plot_fusion_help_counts(out_df)
plot_fusion_help_by_threads(out_df)
plot_delta_speedup_box(out_df)

print("Done. Check polybench_results/ for fusion_help.csv and plots.")
