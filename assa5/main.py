from helpers import split_blocks,build_cfg,block_label
import sys, json
from collections import Counter
import networkx as nx
import matplotlib.pyplot as plt
from dom_algo import compute_dominators,compute_idom,build_dom_tree,compute_dom_frontier
from visualizer import plot_cfg,plot_dom_tree,plot_dom_frontier


def function_dominance_report(instrs):
    blocks = split_blocks(instrs)
    succs, preds, label2id = build_cfg(blocks)
    entry = 0  
    dom, rset = compute_dominators(entry, succs, preds)
    idom = compute_idom(entry, dom)
    dom_tree = build_dom_tree(idom)
    df = compute_dom_frontier(succs, preds, idom)

    id2label = {}
    for i, b in enumerate(blocks):
        lb = block_label(b)
        id2label[i] = lb if lb is not None else f"b{i}"

    def name_set(s):
        return sorted(id2label[i] for i in s)

    report = {
        "blocks": [id2label[i] for i in range(len(blocks))],
        "reachable_blocks": [id2label[i] for i in sorted(rset)],
        "dominators": {id2label[i]: name_set(dom[i]) for i in range(len(blocks))},
        "idom": {id2label[i]: (id2label[idom[i]] if idom[i] is not None else None)
                 for i in range(len(blocks))},
        "dom_tree_children": {id2label[i]: [id2label[c] for c in dom_tree[i]]
                              for i in range(len(blocks))},
        "dominance_frontier": {id2label[i]: name_set(df[i]) for i in range(len(blocks))},
    }
    return report

def plot_dominance_artifacts(instrs):
    blocks = split_blocks(instrs)
    succs, preds, label2id = build_cfg(blocks)
    entry = 0
    dom, rset = compute_dominators(entry, succs, preds)
    idom = compute_idom(entry, dom)
    dom_tree = build_dom_tree(idom)
    DF = compute_dom_frontier(succs, preds, idom)

    id2label = {}
    for i, b in enumerate(blocks):
        lb = block_label(b)
        id2label[i] = lb if lb is not None else f"b{i}"

    # Make the three plots
    plot_cfg(succs, id2label)
    plot_dom_tree(dom_tree, id2label)
    plot_dom_frontier(DF, id2label)
    plt.show()

def _read_prog_from_stdin():
    prog = json.load(sys.stdin)
    if "functions" in prog:
        fn = prog["functions"][0]
        instrs = fn.get("instrs", [])
    else:
        instrs = prog.get("instrs", [])
    return instrs



if __name__ == "__main__":
    instrs = _read_prog_from_stdin()
    rep = function_dominance_report(instrs)
    json.dump(rep, sys.stdout, indent=2)
    print()
    plot_dominance_artifacts(instrs)


# bril2json < grad_desc.bril | python3 main.py 