#!/usr/bin/env python3
"""
plot_fusible_results.py

Plots fusible micro-bench results from run_fusible_bench.sh.

What it does:
- Loads a results.csv (default: latest fusible_results/*/results.csv)
- Drops non-working rows (time is N/A / non-numeric)
- Aggregates per (benchmark, implementation) using the BEST (minimum) time across threads
  - NoPass is treated as serial baseline (thread=1)
  - Pass implementations choose best among tested thread counts
- Produces:
  1) speedup_vs_originalpass.png  (Fusion / Fusion+Shared vs OriginalPass)
  2) times_best_log.png           (absolute times, log scale)
  3) speedup_vs_nopass.png        (Fusion / Fusion+Shared / OriginalPass vs NoPass)

Also prints a list of "not-working" benchmarks (missing any required implementation after filtering),
so you can move them out of fusible_tests if you want.
"""

import argparse
import glob
import os
from pathlib import Path
from typing import Optional, Tuple

import numpy as np
import pandas as pd
import matplotlib.pyplot as plt


REQUIRED_IMPLS = ["NoPass", "OriginalPass", "Fusion", "Fusion+Shared"]


def find_latest_results_csv(fusible_results_dir: str) -> str:
    patt = os.path.join(fusible_results_dir, "*", "results.csv")
    files = sorted(glob.glob(patt), key=os.path.getmtime, reverse=True)
    if not files:
        raise FileNotFoundError(f"No results.csv found under: {patt}")
    return files[0]


def to_float_or_nan(x) -> float:
    try:
        return float(x)
    except Exception:
        return np.nan


def load_and_filter(csv_path: str) -> pd.DataFrame:
    df = pd.read_csv(csv_path)

    # Normalize column names defensively
    df.columns = [c.strip() for c in df.columns]

    if "time" not in df.columns:
        raise ValueError("CSV missing required column: time")

    df["time_s"] = df["time"].map(to_float_or_nan)
    df = df.dropna(subset=["time_s"]).copy()

    # Keep only implementations we care about (others are fine too, but for clean plots filter)
    if "implementation" in df.columns:
        df["implementation"] = df["implementation"].astype(str).str.strip()
    else:
        raise ValueError("CSV missing required column: implementation")

    if "benchmark" in df.columns:
        df["benchmark"] = df["benchmark"].astype(str).str.strip()
    else:
        raise ValueError("CSV missing required column: benchmark")

    # Threads might be missing or string; make numeric where possible
    if "threads" in df.columns:
        df["threads_i"] = pd.to_numeric(df["threads"], errors="coerce")
    else:
        df["threads_i"] = np.nan

    return df


def best_time_by_impl(df: pd.DataFrame) -> pd.DataFrame:
    """
    Returns a table with columns:
      benchmark, implementation, best_time_s
    where best_time_s is the minimum time observed across thread counts.
    """
    g = df.groupby(["benchmark", "implementation"], as_index=False)["time_s"].min()
    g = g.rename(columns={"time_s": "best_time_s"})
    return g


def pivot_best_times(best: pd.DataFrame) -> pd.DataFrame:
    """
    Returns wide table: index=benchmark, columns=implementation, values=best_time_s
    """
    wide = best.pivot(index="benchmark", columns="implementation", values="best_time_s")
    # Keep only relevant implementations if present
    keep_cols = [c for c in REQUIRED_IMPLS if c in wide.columns]
    wide = wide[keep_cols].copy()
    return wide


def report_not_working(wide: pd.DataFrame) -> Tuple[pd.DataFrame, list]:
    """
    A benchmark is "working" if it has ALL required impls after filtering.
    """
    missing = []
    for b in wide.index:
        row = wide.loc[b]
        if any(pd.isna(row.get(impl, np.nan)) for impl in REQUIRED_IMPLS):
            missing.append(b)
    working = wide.drop(index=missing, errors="ignore")
    return working, missing


def plot_speedup_vs_originalpass(working: pd.DataFrame, out_png: str) -> None:
    """
    Bar plot: speedup = OriginalPass_time / Impl_time (best times).
    """
    if "OriginalPass" not in working.columns:
        print("[warn] OriginalPass missing; skipping speedup_vs_originalpass.")
        return

    base = working["OriginalPass"]
    data = {}
    for impl in ["Fusion", "Fusion+Shared"]:
        if impl in working.columns:
            data[impl] = base / working[impl]

    if not data:
        print("[warn] Fusion columns missing; skipping speedup_vs_originalpass.")
        return

    # Sort by Fusion+Shared if present else Fusion
    sort_key = "Fusion+Shared" if "Fusion+Shared" in data else "Fusion"
    order = pd.Series(data[sort_key]).sort_values(ascending=False).index.tolist()

    x = np.arange(len(order))
    width = 0.35 if len(data) == 2 else 0.5

    plt.figure(figsize=(max(10, len(order) * 0.5), 5))
    offsets = np.linspace(-width / 2, width / 2, num=len(data))

    for i, (impl, sp) in enumerate(data.items()):
        plt.bar(x + offsets[i], sp.loc[order].values, width=width / len(data), label=impl)

    plt.axhline(1.0, linewidth=1)
    plt.xticks(x, order, rotation=45, ha="right")
    plt.ylabel("Speedup vs OriginalPass (OriginalPass / Impl)")
    plt.title("Fusible micro-bench: speedup vs OriginalPass (best time across threads)")
    plt.legend()
    plt.tight_layout()
    plt.savefig(out_png, dpi=200)
    plt.close()


def plot_times_best_log(working: pd.DataFrame, out_png: str) -> None:
    """
    Line plot of best times per impl (log scale).
    """
    impls = [c for c in ["NoPass", "OriginalPass", "Fusion", "Fusion+Shared"] if c in working.columns]
    if not impls:
        print("[warn] No implementations found; skipping times_best_log.")
        return

    # Sort by NoPass or OriginalPass
    sort_col = "NoPass" if "NoPass" in impls else impls[0]
    order = working[sort_col].sort_values(ascending=False).index.tolist()

    plt.figure(figsize=(max(10, len(order) * 0.5), 5))
    x = np.arange(len(order))
    for impl in impls:
        plt.plot(x, working.loc[order, impl].values, marker="o", label=impl)

    plt.yscale("log")
    plt.xticks(x, order, rotation=45, ha="right")
    plt.ylabel("Best time (seconds, log scale)")
    plt.title("Fusible micro-bench: best time per implementation (min across threads)")
    plt.legend()
    plt.tight_layout()
    plt.savefig(out_png, dpi=200)
    plt.close()


def plot_speedup_vs_nopass(working: pd.DataFrame, out_png: str) -> None:
    """
    Bar plot: speedup = NoPass_time / Impl_time (best times).
    """
    if "NoPass" not in working.columns:
        print("[warn] NoPass missing; skipping speedup_vs_nopass.")
        return

    base = working["NoPass"]
    data = {}
    for impl in ["OriginalPass", "Fusion", "Fusion+Shared"]:
        if impl in working.columns:
            data[impl] = base / working[impl]

    if not data:
        print("[warn] No pass impl columns found; skipping speedup_vs_nopass.")
        return

    # Sort by best available
    sort_key = "Fusion+Shared" if "Fusion+Shared" in data else list(data.keys())[0]
    order = pd.Series(data[sort_key]).sort_values(ascending=False).index.tolist()

    x = np.arange(len(order))
    width = 0.7

    plt.figure(figsize=(max(10, len(order) * 0.5), 5))
    offsets = np.linspace(-0.25, 0.25, num=len(data))

    for i, (impl, sp) in enumerate(data.items()):
        plt.bar(x + offsets[i], sp.loc[order].values, width=width / max(1, len(data)), label=impl)

    plt.axhline(1.0, linewidth=1)
    plt.xticks(x, order, rotation=45, ha="right")
    plt.ylabel("Speedup vs NoPass (NoPass / Impl)")
    plt.title("Fusible micro-bench: speedup vs NoPass (best time across threads)")
    plt.legend()
    plt.tight_layout()
    plt.savefig(out_png, dpi=200)
    plt.close()


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--csv", default=None, help="Path to results.csv (default: latest under fusible_results/)")
    ap.add_argument("--fusible-results-dir", default="fusible_results", help="Directory containing timestamped runs")
    ap.add_argument("--out-dir", default=None, help="Output directory (default: alongside the csv)")
    ap.add_argument("--write-filtered-csv", action="store_true", help="Write a filtered 'working_only.csv'")
    args = ap.parse_args()

    csv_path = args.csv or find_latest_results_csv(args.fusible_results_dir)
    csv_path = str(Path(csv_path).resolve())
    out_dir = args.out_dir or str(Path(csv_path).parent)
    Path(out_dir).mkdir(parents=True, exist_ok=True)

    print(f"[info] Using CSV: {csv_path}")
    print(f"[info] Output dir: {out_dir}")

    df = load_and_filter(csv_path)

    best = best_time_by_impl(df)
    wide = pivot_best_times(best)
    working, missing = report_not_working(wide)

    if missing:
        print("\n[not-working benchmarks] (missing at least one of: "
              + ", ".join(REQUIRED_IMPLS) + ")")
        for b in missing:
            print("  -", b)

    if working.empty:
        raise SystemExit("[error] No working benchmarks after filtering.")

    if args.write_filtered_csv:
        out_csv = os.path.join(out_dir, "working_only.csv")
        working.reset_index().to_csv(out_csv, index=False)
        print(f"[info] Wrote: {out_csv}")

    # Plots
    p1 = os.path.join(out_dir, "speedup_vs_originalpass.png")
    p2 = os.path.join(out_dir, "times_best_log.png")
    p3 = os.path.join(out_dir, "speedup_vs_nopass.png")

    plot_speedup_vs_originalpass(working, p1)
    plot_times_best_log(working, p2)
    plot_speedup_vs_nopass(working, p3)

    print("\n[done] Wrote plots:")
    for p in [p1, p2, p3]:
        if os.path.exists(p):
            print("  -", p)


if __name__ == "__main__":
    main()

