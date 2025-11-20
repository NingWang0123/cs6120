from helpers import split_blocks,build_cfg
import json


def find_function(prog, name):
    if isinstance(prog, dict) and "functions" in prog:
        funcs = prog["functions"]
    else:
        funcs = prog
    for f in funcs:
        if f.get("name") == name:
            return f
    return None

def collect_existing_labels(instrs):
    labels = set()
    for instr in instrs:
        if "label" in instr:
            labels.add(instr["label"])
    return labels

def fresh_label(existing, base):
    lbl = base
    i = 0
    while lbl in existing:
        i += 1
        lbl = f"{base}_{i}"
    return lbl

def choose_trace_block_path(entry, succs):
    path = []
    visited = set()
    b = entry
    while True:
        if b in visited:
            break
        path.append(b)
        visited.add(b)
        if not succs[b]:
            break
        # pick the first successor
        b = succs[b][0]
    return path

def build_trace_instrs(blocks, path_blocks):
    trace_instrs = []
    for bi in path_blocks:
        block = blocks[bi]
        for instr in block:
            if "label" in instr:
                # labels not needed inside the trace
                continue
            op = instr.get("op")
            if op is None:
                continue
            if op == "jmp":
                # fall through in the trace
                continue
            elif op == "br":
                # assume the first successor was taken, so we just guard on cond.
                cond = instr.get("args", [None])[0]
                guard_instr = {
                    "op": "guard",
                    "args": [cond],
                    "labels": []
                }
                trace_instrs.append(guard_instr)
            else:
                trace_instrs.append(instr)
                if op == "ret":
                    return trace_instrs
    return trace_instrs

def inject_speculation_into_main(prog, func_name="main"):
    func = find_function(prog, func_name)
    if func is None:
        return 

    orig_instrs = list(func.get("instrs", []))
    if not orig_instrs:
        return

    blocks = split_blocks(orig_instrs)
    succs, preds, label_map = build_cfg(blocks)

     # assume entry is first block
    entry_block = 0 
    path_blocks = choose_trace_block_path(entry_block, succs)
    trace_instrs = build_trace_instrs(blocks, path_blocks)

    if not trace_instrs:
        return

    # collect labels
    existing_labels = collect_existing_labels(orig_instrs)

    fast_entry = fresh_label(existing_labels, "__trace_entry")
    slow_entry = fresh_label(existing_labels, "__slow_path")

    # fill in guard failure label
    for instr in trace_instrs:
        if instr.get("op") == "guard":
            instr["labels"] = [slow_entry]

    new_instrs = []

    new_instrs.append({"label": fast_entry})
    new_instrs.append({"op": "speculate"})

    # separate last ret if present
    body = trace_instrs
    last = body[-1]
    ends_with_ret = last.get("op") == "ret"

    if ends_with_ret:
        body_without_ret = body[:-1]
        for instr in body_without_ret:
            new_instrs.append(instr)
        new_instrs.append({"op": "commit"})
        new_instrs.append(last)
    else:
        # no ret in trace
        for instr in body:
            new_instrs.append(instr)
        new_instrs.append({"op": "commit"})
        # then jump to original body
        new_instrs.append({"op": "jmp", "labels": [slow_entry]})

    # slow path 
    new_instrs.append({"label": slow_entry})
    new_instrs.extend(orig_instrs)

    func["instrs"] = new_instrs
