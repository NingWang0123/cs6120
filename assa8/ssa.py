import helpers
import sys, json
from collections import Counter,defaultdict

def is_term(instr):
    return instr.get('op') in helpers.terminators

def instr_defs(instr):
    return instr.get('dest')

def instr_uses(instr):
    return list(instr.get('args', []))

def replace_uses(instr, mapper):
    if 'args' in instr:
        instr['args'] = [mapper.get(a, a) for a in instr['args']]

def replace_def(instr, newname):
    if 'dest' in instr:
        instr['dest'] = newname

def is_label(instr):
    return 'label' in instr

#Assumes phi nodes are grouped at the head after an optional label.
def block_head_phi_list(block):
    i = 0
    if block and is_label(block[0]):
        i = 1
    j = i
    phis = []
    while j < len(block) and block[j].get('op') == 'phi':
        phis.append((j, block[j]))
        j += 1
    return i, phis, j


def infer_type_for_var(blocks, v):
    # scan for a def carrying type info
    for block in blocks:
        for instr in block:
            if instr_defs(instr) == v and 'type' in instr:
                return instr['type']
    # fallback, scan any version of the var
    base = v.split('.', 1)[0]
    for block in blocks:
        for instr in block:
            d = instr_defs(instr)
            if d and d.startswith(base + '.') and 'type' in instr:
                return instr['type']
            
    # default int
    return 'int' 

def collect_vars(blocks):
    vars_read = [set() for _ in blocks]
    vars_written = [set() for _ in blocks]
    for bi, block in enumerate(blocks):
        for instr in block:
            for a in instr_uses(instr):
                vars_read[bi].add(a)
            d = instr_defs(instr)
            if d:
                vars_written[bi].add(d)
    all_vars = sorted(set().union(*vars_read, *vars_written))
    return all_vars, vars_read, vars_written


def place_phi_nodes(blocks, idom):
    n = len(blocks)
    all_vars, _, vars_written = collect_vars(blocks)
    DF = helpers.compute_dom_frontier(*helpers.build_cfg(blocks)[:2], idom)  

    phis_at = [dict() for _ in range(n)]  # block -> {v: phi_instr}

    for v in all_vars:
        Defs = {b for b in range(n) if v in vars_written[b]}
        work = list(Defs)
        placed = set()
        while work:
            d = work.pop()
            for y in DF[d]:
                if (y, v) in placed:
                    continue
                phi_instr = {
                    'op': 'phi',
                    'dest': v,          
                    'type': infer_type_for_var(blocks, v),
                    'labels': [],
                    'args': [],
                }
                phis_at[y][v] = phi_instr
                placed.add((y, v))
                if v not in vars_written[y]:
                    vars_written[y].add(v)
                    work.append(y)

    # splice phis at block heads
    new_blocks = []
    for bi, block in enumerate(blocks):
        insert_at = 1 if (block and is_label(block[0])) else 0
        head = block[:insert_at]
        tail = block[insert_at:]
        phis = [dict(ph) for _, ph in phis_at[bi].items()]
        new_blocks.append(head + phis + tail)
    return new_blocks


def fresh(counters, v: str) -> str:
    counters[v] += 1
    return f"{v}.{counters[v]}"

def top(name_stacks, x: str) -> str:
    return name_stacks[x][-1] if name_stacks[x] else x

def bid_label(blocks, helpers, bi: int) -> str:
    lb = helpers.block_label(blocks[bi])
    return lb if lb is not None else f".B{bi}"

def seed_name_stacks_with_version_zero(blocks, collect_vars):
    name_stacks = defaultdict(list)
    counters = defaultdict(int)
    all_vars, _, _ = collect_vars(blocks)
    for v in all_vars:
        name_stacks[v].append(f"{v}.0")
    return name_stacks, counters

def rename_block(
    bi: int,
    blocks,
    succs,
    dom_tree,
    name_stacks,
    counters,
    helpers,
    block_head_phi_list,
    replace_def,
    instr_defs,
):
    block = blocks[bi]

    # 1) rename phi destinations at block head
    insert_at, phis, body_start = block_head_phi_list(block)
    pushed_phi = []
    for _, phi in phis:
        base = phi['dest']
        new = fresh(counters, base)
        replace_def(phi, new)
        name_stacks[base].append(new)
        pushed_phi.append(base)

    # 2) rename instruction arguments/defs in block body
    pushed_body = []
    for i in range(body_start, len(block)):
        ins = block[i]
        if 'args' in ins:
            ins['args'] = [top(name_stacks, a) for a in ins['args']]
        d = instr_defs(ins)
        if d:
            new = fresh(counters, d)
            replace_def(ins, new)
            name_stacks[d].append(new)
            pushed_body.append(d)

    # 3) wire current names into successor phis
    for s in succs[bi]:
        s_block = blocks[s]
        _, s_phis, _ = block_head_phi_list(s_block)
        pred_lb = bid_label(blocks, helpers, bi)
        for _, phi in s_phis:
            base = phi['dest'].rsplit('.', 1)[0]
            arg = name_stacks[base][-1] if name_stacks[base] else f"{base}.0"
            phi.setdefault('labels', []).append(pred_lb)
            phi.setdefault('args', []).append(arg)

    # 4) recurse down dominator tree
    for child in dom_tree[bi]:
        rename_block(
            child, blocks, succs, dom_tree, name_stacks, counters,
            helpers, block_head_phi_list, replace_def, instr_defs
        )

    # 5) pop defs in reverse to restore stacks
    for d in reversed(pushed_body):
        name_stacks[d].pop()
    for base in reversed(pushed_phi):
        name_stacks[base].pop()


def to_ssa(func):
    instrs = [dict(i) for i in func['instrs']]

    # Handle function arguments: insert id instructions at the start
    # to initialize .0 versions from the original argument names
    # This allows SSA to use arg.0 throughout while brili provides the original arg names
    if 'args' in func and func['args']:
        arg_init_instrs = []
        for arg in func['args']:
            arg_name = arg['name']
            arg_type = arg['type']
            # Insert: arg_name.0 = id arg_name
            arg_init_instrs.append({
                'op': 'id',
                'dest': f'{arg_name}.0',
                'type': arg_type,
                'args': [arg_name]
            })
        instrs = arg_init_instrs + instrs

    blocks = helpers.split_blocks(instrs)
    succs, preds, label2bid = helpers.build_cfg(blocks)

    entry = 0
    dom, _ = helpers.compute_dominators(entry, succs, preds)
    idom = helpers.compute_idom(entry, dom)

    # 1) Place phi nodes
    blocks = place_phi_nodes(blocks, idom)
    succs, preds, _ = helpers.build_cfg(blocks)

    # Recompute dominance after inserting phis
    dom, _ = helpers.compute_dominators(entry, succs, preds)
    idom = helpers.compute_idom(entry, dom)
    dom_tree = helpers.build_dom_tree(idom)

    # 2) Rename with stacks
    name_stacks, counters = seed_name_stacks_with_version_zero(blocks, collect_vars)

    rename_block(
        entry, blocks, succs, dom_tree, name_stacks, counters,
        helpers, block_head_phi_list, replace_def, instr_defs
    )

    # 3) Materialize explicit 'undef'
    for bi, block in enumerate(blocks):
        _, phis, _ = block_head_phi_list(block)
        if not phis:
            continue

        need = set(preds[bi])
        # map labels -> pred ids (rebuild for robustness after mutation)
        _, _, _label2 = helpers.build_cfg(blocks)
        lbl2id = {helpers.block_label(blocks[p]) or f".B{p}": p for p in preds[bi]}

        have = set()
        for _, phi in phis:
            for lb in phi.get('labels', []):
                if lb in lbl2id:
                    have.add(lbl2id[lb])

        missing = need - have
        for p in missing:
            lb = helpers.block_label(blocks[p]) or f".B{p}"
            for _, phi in phis:
                base = phi['dest'].rsplit('.', 1)[0]
                phi.setdefault('labels', []).append(lb)
                phi.setdefault('args', []).append(f"{base}.0")

    new_instrs = [ins for b in blocks for ins in b]
    new_func = dict(func)
    new_func['instrs'] = new_instrs
    return new_func
