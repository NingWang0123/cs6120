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
                print(cur_block)
                blocks.append(cur_block)

            cur_block = []
            start_new = False

        cur_block.append(instr)

        # split block when the op is one of terminators
        if instr.get('op') in terminators:
            print(cur_block)
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


# count the edges
def cfg_edges_count(blocks):
    edges = 0
    n = len(blocks)
    i = 0

    for b in blocks:
        last_op = b[-1].get('op')

        if last_op == 'jmp':
            # jump target
            edges += 1
        elif last_op == 'br':
            # true target + false target
            edges += 2
        elif last_op != 'ret' and i < n - 1:
            # fall through edge to the next block
            edges += 1  
        i+=1

    return edges

# count the edges
def new_cfg_edges_count(blocks):
    succs, _, _ = build_cfg(blocks)
    return sum(len(s) for s in succs)

def main():
    prog = json.load(sys.stdin)
    total_op_counts = Counter()
    per_func_counts = {}
    per_func_b = {}
    per_func_edges = {}

    for f in prog.get("functions", []):
        name = f.get("name", "<anon>")
        instrs = f.get("instrs", [])
        op_counts = Counter(inst.get("op") for inst in instrs if "op" in inst)
        total_op_counts.update(op_counts)
        per_func_counts[name] = dict(op_counts)

        blocks = split_blocks(instrs)
        per_func_b[name] = len(blocks)
        per_func_edges[name] = new_cfg_edges_count(blocks)

    # check two methods are return the same
    print(cfg_edges_count(blocks) == new_cfg_edges_count(blocks))

    print("== Bril Stats ==")
    print("\nPer-function instruction counts:")
    for fn, counts in per_func_counts.items():
        print(f"  {fn}: {counts}")
    print("\nPer-function blocks:")
    for fn, bb in per_func_b.items():
        print(f"  {fn}: {bb}")
    print("\nPer-function CFG edge counts:")
    for fn, ec in per_func_edges.items():
        print(f"  {fn}: {ec}")
    print("\nTotal instruction counts:")
    print(dict(total_op_counts))

if __name__ == "__main__":
    main()