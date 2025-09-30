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