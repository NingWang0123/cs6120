#!/usr/bin/env python3
"""
Comprehensive test runner for dominance analysis.
Runs all test cases, generates visualizations, and validates results.
"""

import os
import sys
import json
import subprocess
from pathlib import Path
import matplotlib.pyplot as plt

from helpers import split_blocks, build_cfg, block_label
from dom_algo import compute_dominators, compute_idom, build_dom_tree, compute_dom_frontier
from visualizer import plot_cfg, plot_dom_tree, plot_dom_frontier, plot_combined_analysis


def run_bril_test(test_file):
    """Convert a .bril file to JSON and parse instructions."""
    try:
        # Use python directly to run the bril parser
        bril_txt_path = "/Users/jl4492/Projects/cs6120/bril/bril-txt/briltxt.py"
        # Import and use briltxt directly
        import sys
        sys.path.insert(0, "/Users/jl4492/Projects/cs6120/bril/bril-txt")
        import briltxt

        with open(test_file, 'r') as f:
            bril_text = f.read()

        json_output = briltxt.parse_bril(bril_text)
        prog = json.loads(json_output)

        if "functions" in prog:
            fn = prog["functions"][0]
            instrs = fn.get("instrs", [])
        else:
            instrs = prog.get("instrs", [])

        return instrs
    except (subprocess.CalledProcessError, FileNotFoundError, json.JSONDecodeError) as e:
        print(f"Error processing {test_file}: {e}")
        print("Make sure the bril parser is available")
        return None


def analyze_test(test_file, output_dir):
    """Run dominance analysis on a test file and generate visualizations."""
    test_name = Path(test_file).stem
    print(f"\n=== Analyzing {test_name} ===")

    instrs = run_bril_test(test_file)
    if instrs is None:
        return None

    # Perform dominance analysis
    blocks = split_blocks(instrs)
    succs, preds, label2id = build_cfg(blocks)
    entry = 0
    dom, rset = compute_dominators(entry, succs, preds)
    idom = compute_idom(entry, dom)
    dom_tree = build_dom_tree(idom)
    DF = compute_dom_frontier(succs, preds, idom)

    # Create id2label mapping
    id2label = {}
    for i, b in enumerate(blocks):
        lb = block_label(b)
        id2label[i] = lb if lb is not None else f"b{i}"

    # Generate individual visualizations
    test_output_dir = os.path.join(output_dir, test_name)
    os.makedirs(test_output_dir, exist_ok=True)

    # CFG
    cfg_path = os.path.join(test_output_dir, "cfg.png")
    plot_cfg(succs, id2label, f"CFG - {test_name}", save_path=cfg_path)
    plt.close()

    # Dominator Tree
    dom_tree_path = os.path.join(test_output_dir, "dom_tree.png")
    plot_dom_tree(dom_tree, id2label, f"Dominator Tree - {test_name}", save_path=dom_tree_path)
    plt.close()

    # Dominance Frontier
    dom_frontier_path = os.path.join(test_output_dir, "dom_frontier.png")
    plot_dom_frontier(DF, id2label, f"Dominance Frontier - {test_name}", save_path=dom_frontier_path)
    plt.close()

    # Combined analysis
    try:
        plot_combined_analysis(succs, dom_tree, DF, id2label, save_dir=test_output_dir)
        plt.close()
    except Exception as e:
        print(f"Warning: Combined analysis failed for {test_name}: {e}")
        print(f"Debug info: succs={len(succs)}, dom_tree={len(dom_tree)}, DF={len(DF)}")
        plt.close()

    # Generate analysis report
    def name_set(s):
        return sorted(id2label[i] for i in s)

    report = {
        "test_name": test_name,
        "blocks": [id2label[i] for i in range(len(blocks))],
        "reachable_blocks": [id2label[i] for i in sorted(rset)],
        "dominators": {id2label[i]: name_set(dom[i]) for i in range(len(blocks))},
        "idom": {id2label[i]: (id2label[idom[i]] if idom[i] is not None else None)
                 for i in range(len(blocks))},
        "dom_tree_children": {id2label[i]: [id2label[c] for c in dom_tree[i]]
                              for i in range(len(blocks))},
        "dominance_frontier": {id2label[i]: name_set(DF[i]) for i in range(len(blocks))},
        "stats": {
            "total_blocks": len(blocks),
            "reachable_blocks": len(rset),
            "cfg_edges": sum(len(vs) for vs in succs),
            "dom_tree_edges": sum(len(vs) for vs in dom_tree),
            "dom_frontier_edges": sum(len(vs) for vs in DF)
        }
    }

    # Save report as JSON
    report_path = os.path.join(test_output_dir, "analysis_report.json")
    with open(report_path, 'w') as f:
        json.dump(report, f, indent=2)

    print(f"Analysis complete for {test_name}")
    print(f"  Blocks: {len(blocks)}, Reachable: {len(rset)}")
    print(f"  CFG edges: {sum(len(vs) for vs in succs)}")
    print(f"  Results saved to: {test_output_dir}")

    return report


def validate_dominance_properties(report):
    """Validate basic dominance properties for correctness."""
    errors = []

    # Every block should dominate itself
    for block, dominators in report["dominators"].items():
        if block not in dominators:
            errors.append(f"Block {block} does not dominate itself")

    # Entry block should dominate all reachable blocks
    entry_doms = set(report["dominators"].get("b0", []))
    for block in report["reachable_blocks"]:
        if "b0" not in report["dominators"].get(block, []):
            errors.append(f"Entry block does not dominate reachable block {block}")

    # Each block should have at most one immediate dominator
    for block, idom in report["idom"].items():
        if block == "b0" and idom is not None:
            errors.append(f"Entry block {block} should not have an immediate dominator")

    return errors


def main():
    """Run all tests and generate comprehensive analysis."""
    # Setup directories
    base_dir = Path(__file__).parent
    tests_dir = base_dir / "tests"
    figures_dir = base_dir / "figures"
    figures_dir.mkdir(exist_ok=True)

    # Find all test files
    test_files = list(tests_dir.glob("*.bril"))
    if not test_files:
        print("No .bril test files found in tests/ directory")
        return

    print(f"Found {len(test_files)} test files")

    all_reports = []

    # Run analysis on each test file
    for test_file in sorted(test_files):
        report = analyze_test(test_file, figures_dir)
        if report:
            all_reports.append(report)

            # Validate properties
            errors = validate_dominance_properties(report)
            if errors:
                print(f"VALIDATION ERRORS for {report['test_name']}:")
                for error in errors:
                    print(f"  - {error}")
            else:
                print(f"✓ Validation passed for {report['test_name']}")

    # Generate summary report
    summary = {
        "total_tests": len(all_reports),
        "tests": [r["test_name"] for r in all_reports],
        "aggregate_stats": {
            "total_blocks": sum(r["stats"]["total_blocks"] for r in all_reports),
            "total_cfg_edges": sum(r["stats"]["cfg_edges"] for r in all_reports),
            "total_dom_tree_edges": sum(r["stats"]["dom_tree_edges"] for r in all_reports),
            "total_dom_frontier_edges": sum(r["stats"]["dom_frontier_edges"] for r in all_reports)
        }
    }

    summary_path = figures_dir / "test_summary.json"
    with open(summary_path, 'w') as f:
        json.dump(summary, f, indent=2)

    print(f"\n=== SUMMARY ===")
    print(f"Processed {len(all_reports)} test cases")
    print(f"Total blocks analyzed: {summary['aggregate_stats']['total_blocks']}")
    print(f"Results saved to: {figures_dir}")
    print(f"Summary report: {summary_path}")


if __name__ == "__main__":
    main()