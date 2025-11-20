import sys, json
from collections import Counter

terminators = {"jmp", "br", "ret"}

def is_term(instr):
    return instr.get('op') in terminators

# samilar ideas from the class (from_blocks and blocks_map)
def split_blocks(instrs):
    blocks, cur_block, start_new = [], [], True

    for instr in instrs:
        # check block boundary
        if 'label' in instr or start_new:
            if cur_block:
                blocks.append(cur_block)

            cur_block = []
            start_new = False

        cur_block.append(instr)

        # split block when the op is one of terminators
        if instr.get('op') in terminators:
            blocks.append(cur_block)
            cur_block = []
            start_new = True

    # for the last current block, add if it is not empty
    if cur_block:
        blocks.append(cur_block)
    return blocks


def block_label(block):
    # Return the first label in the block if present
    for instr in block:
        if 'label' in instr:
            return instr['label']
    return None

# add edge for succsessors and predssors
def add_edge(u, v, succs, preds):
    if v not in succs[u]:
        succs[u].append(v)
    if u not in preds[v]:
        preds[v].append(u)


# samilar ideas from the class get_cfg
def build_cfg(blocks):
    n = len(blocks)
    label_to_block_id = {}

    i = 0
    for b in blocks:
        lb = block_label(b)
        if lb is not None:
            label_to_block_id[lb] = i
        i+=1

    succs = [[] for _ in range(n)]
    preds = [[] for _ in range(n)]

    # reset i
    i = 0
    for b in blocks:
        last_b =  b[-1]
        last_op = last_b.get('op')

        if last_op == 'jmp':
            # jump target
            tgt = last_b.get('labels', [None])[0]
            if tgt in label_to_block_id:
                add_edge(i, label_to_block_id[tgt], succs, preds)

        elif last_op == 'br':
            # true target + false target
            t, f = last_b.get('labels', [None, None])[:2]
            for lbl in {t, f} - {None}:
                if lbl in label_to_block_id:
                    add_edge(i, label_to_block_id[lbl], succs, preds)

        elif last_op != 'ret':
            # fall-through to next block if exists
            if i + 1 < n:
                add_edge(i, i + 1, succs, preds)
        i+=1

    return succs, preds, label_to_block_id


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