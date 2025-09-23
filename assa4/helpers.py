import sys, json
from collections import Counter

terminators = {"jmp", "br", "ret"}

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


def format_instruction(instr):
    """Format a single instruction for display"""
    if 'label' in instr:
        return f".{instr['label']}:"

    op = instr.get('op', '?')
    dest = instr.get('dest', '')
    args = instr.get('args', [])

    if dest:
        if args:
            return f"{dest} = {op} {' '.join(map(str, args))}"
        else:
            value = instr.get('value', '')
            if value != '':
                return f"{dest} = {op} {value}"
            else:
                return f"{dest} = {op}"
    else:
        if args:
            return f"{op} {' '.join(map(str, args))}"
        else:
            return op


def format_block_summary(block, max_instrs=3):
    """Create a short summary of block instructions"""
    summary = []
    non_label_instrs = [instr for instr in block if 'label' not in instr]

    for i, instr in enumerate(non_label_instrs[:max_instrs]):
        summary.append(format_instruction(instr))

    if len(non_label_instrs) > max_instrs:
        summary.append("...")

    return "; ".join(summary) if summary else "empty"


def fmt_set(s):
    """Format a set nicely for display"""
    if not s:
        return "∅"
    if isinstance(s, set):
        if all(isinstance(x, tuple) for x in s):
            # Handle reaching definitions format: (var, (block, instr))
            items = []
            for var, (bi, ii) in sorted(s):
                items.append(f"{var}@B{bi}.{ii}")
            return "{" + ", ".join(items) + "}"
        else:
            # Handle simple variable sets
            return "{" + ", ".join(sorted(map(str, s))) + "}"
    return str(s)


def print_analysis_table(blocks, succs, preds, IN_sets, OUT_sets, analysis_name):
    """Print a formatted table showing dataflow analysis results"""
    print(f"\n{'='*80}")
    print(f"{analysis_name:^80}")
    print(f"{'='*80}")

    # Calculate column widths
    max_block_width = max(len(format_block_summary(block)) for block in blocks)
    max_block_width = min(max_block_width, 35)  # Cap the width

    # Header
    header = f"{'Block':<8} | {'Instructions':<{max_block_width}} | {'IN':<20} | {'OUT':<20}"
    print(header)
    print("-" * len(header))

    # Data rows
    for i, block in enumerate(blocks):
        label = block_label(block)
        if label:
            block_name = f"B{i}(.{label})"
        else:
            block_name = f"B{i}"

        instrs = format_block_summary(block)
        if len(instrs) > max_block_width:
            instrs = instrs[:max_block_width-3] + "..."

        in_str = fmt_set(IN_sets[i])
        if len(in_str) > 20:
            in_str = in_str[:17] + "..."

        out_str = fmt_set(OUT_sets[i])
        if len(out_str) > 20:
            out_str = out_str[:17] + "..."

        print(f"{block_name:<8} | {instrs:<{max_block_width}} | {in_str:<20} | {out_str:<20}")

    # CFG info
    print(f"\n{'CFG Edges:':<15}")
    for i, successors in enumerate(succs):
        if successors:
            succ_str = " → ".join(f"B{s}" for s in successors)
            print(f"  B{i} → {succ_str}")


def generate_dot_graph(blocks, succs, IN_sets, OUT_sets, analysis_name):
    """Generate Graphviz DOT format for CFG visualization"""
    dot_lines = [
        "digraph CFG {",
        "  rankdir=TB;",
        "  node [shape=box, style=filled, fillcolor=lightblue];",
        ""
    ]

    # Add nodes
    for i, block in enumerate(blocks):
        label_parts = []

        # Block identifier
        if 'label' in block[0]:
            label_parts.append(f"B{i} (.{block[0]['label']})")
        else:
            label_parts.append(f"B{i}")

        # Instructions (simplified)
        instrs = format_block_summary(block, max_instrs=2)
        label_parts.append(instrs)

        # Analysis results
        label_parts.append(f"IN: {fmt_set(IN_sets[i])}")
        label_parts.append(f"OUT: {fmt_set(OUT_sets[i])}")

        label = "\\n".join(label_parts)
        dot_lines.append(f'  {i} [label="{label}"];')

    dot_lines.append("")

    # Add edges
    for i, successors in enumerate(succs):
        for succ in successors:
            dot_lines.append(f"  {i} -> {succ};")

    dot_lines.append("}")

    return "\n".join(dot_lines)