import sys, json
from copy import deepcopy
import itertools


terminators = {"jmp", "br", "ret"}

def is_label(instr): 
    return "label" in instr and "op" not in instr


# reusing from the assa 2

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



# helpers
def join_blocks(blocks):
    out = []
    for b in blocks: out.extend(b)
    return out

def has_dest(ins):
    return "dest" in ins

def compute_use_counts(instrs):
    uses = {}
    for ins in instrs:
        for a in ins.get("args", []):
            uses[a] = uses.get(a, 0) + 1
    return uses


def remove_global_unused(func):
    changed = False
    instrs = list(func["instrs"])
    while True:
        uses = compute_use_counts(instrs)
        keep = []
        any_del = False
        for ins in instrs:
            if has_dest(ins):
                d = ins["dest"]
                # check using counts
                if uses.get(d, 0) == 0:
                    any_del = True
                    # drop ins
                    continue
            keep.append(ins)
        instrs = keep
        if not any_del:
            break
        changed = True
    func["instrs"] = instrs
    return changed


def remove_locally_killed(func):

    changed = False
    blocks = split_blocks(func["instrs"])
    new_blocks = []

    for b in blocks:
        last_def_idx = {}    
        used_since = {}     
        keep = [True] * len(b)
        i =0

        for instr in b:
            # mark used
            for a in instr.get("args", []):
                if a in used_since:
                    used_since[a] = True

            if has_dest(instr):
                def_index = instr["dest"]
                # check if there was a previous def not used since
                if def_index in last_def_idx and not used_since.get(def_index, False):
                    prev_def_index = last_def_idx[def_index]

                    # check previous def is not effectful and has dest
                    if not has_dest(b[prev_def_index]):

                        # remove the prev def
                        keep[prev_def_index] = False
                        changed = True

                # record current def and reset used_since
                last_def_idx[def_index] = i
                used_since[def_index] = False

            i+=1

        nb = [ins for ins, k in zip(b, keep) if k]
        new_blocks.append(nb)

    func["instrs"] = join_blocks(new_blocks)
    return changed



def tdce_func(func):

    changed = False
    while True:
        c1 = remove_locally_killed(func)   # within-block kills first
        c2 = remove_global_unused(func)    # then whole-function unused
        if not (c1 or c2):
            break
        changed |= (c1 or c2)
    return changed


def tdce_program(prog):

    out = deepcopy(prog)
    for f in out.get("functions", []):
        tdce_func(f)  # modifies in place

    return out



def main():
    prog = json.load(sys.stdin)
    prog = tdce_program(prog)
    json.dump(prog, sys.stdout, indent=2, sort_keys=True)

if __name__ == "__main__":
    main()