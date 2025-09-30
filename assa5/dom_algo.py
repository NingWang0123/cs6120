from helpers import split_blocks,build_cfg,block_label
import sys, json
from collections import Counter
import networkx as nx
import matplotlib.pyplot as plt

# DFS from entry over succs to collect all nodes can reach
def reachable_from(entry, succs):
    seen = set()
    stack = [entry]
    while stack:
        u = stack.pop()
        if u in seen: 
            continue
        seen.add(u)
        for v in succs[u]:
            if v not in seen:
                stack.append(v)

    return seen

# Recursive DFS that appends each node after exploring children

def dfs(seen,succs,order,u):
    seen.add(u)
    for v in succs[u]:
        if v not in seen:
            dfs(seen,succs,order,v)
    order.append(u)

def _postorder(start, succs):
    seen = set()
    order = []
    dfs(seen,succs,order,start)

    return order 

# reverses the postorder
def reverse_postorder(start, succs):
    return list(reversed(_postorder(start, succs)))


# compute the dominance sets dom[b] = set of nodes that dominate b

def compute_dominators(entry, succs, preds):
    n = len(succs)
    rset = reachable_from(entry, succs)

    # Initialize
    # for reachable nodes, start with top except it dominates itslef
    dom = [set(range(n)) for _ in range(n)]
    for b in range(n):
        # unreachable nodes get null set
        if b not in rset:
            dom[b] = set()                
    dom[entry] = {entry}
    rpo = [b for b in reverse_postorder(entry, succs) if b in rset]


    # dom[b] = {b} ∪ ⋂_{p ∈ preds[b]} dom[p]
    changed = True
    while changed:
        changed = False
        for b in rpo:
            if b == entry:
                continue
            pred_doms = [dom[p] for p in preds[b] if p in rset]
            if not pred_doms:
                new = {b} 
            else:
                new = set.intersection(*pred_doms)
                new.add(b)
            if new != dom[b]:
                dom[b] = new
                changed = True
    return dom, rset


# immediate dominator of each node: the unique strict dominator closest to b
def compute_idom(entry, dom):
    n = len(dom)
    idom = [None] * n
    for b in range(n):
        if b == entry or not dom[b]:
            idom[b] = None
            continue
        # candidates are strict dominators of b
        cands = dom[b] - {b}
        # pick the one not dominated by any other candidate
        best = None
        for d in cands:
            # d is idom if there is no other c in cands, c != d, such that d in dom[c]
            if all(d not in dom[c] or c == d for c in cands):
                best = d
                break
        idom[b] = best
    return idom

# converts idom parent pointers into a dominator tree adjacency list children[p]
def build_dom_tree(idom):
    n = len(idom)
    tree = [[] for _ in range(n)]
    for b, p in enumerate(idom):
        if p is not None:
            tree[p].append(b)
    return tree

# cooper–Harvey–Kennedy method for dominance frontier
def compute_dom_frontier(succs, preds, idom):
    n = len(succs)
    DF = [set() for _ in range(n)]
    for y in range(n):
        if len(preds[y]) >= 2:
            for p in preds[y]:
                runner = p
                while runner is not None and runner != idom[y]:
                    DF[runner].add(y)
                    runner = idom[runner]
    return DF

# try to reach B from entry while skipping A
def dominates_naive(entry, A, B, succs):
    if A == B:
        return True
    # BFS from entry while skipping A
    target = B
    seen, q = set(), [entry]
    while q:
        u = q.pop()
        if u == A:
            continue
        if u == target:
            return False  # found a path entry->B that skips A
        for v in succs[u]:
            if v not in seen:
                seen.add(v)
                q.append(v)
    return True