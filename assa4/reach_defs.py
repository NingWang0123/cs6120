from collections import defaultdict
from generic_solver import DataFlowProblem

def instr_defs(instr):
    d = instr.get('dest')
    return {d} if d is not None else set()


def enumerate_defs(blocks):
    all_defs = set()  
    defs_per_var = defaultdict(set)
    for bi, block in enumerate(blocks):
        for ii, ins in enumerate(block):
            for v in instr_defs(ins):
                d = (v, (bi, ii))
                all_defs.add(d)
                defs_per_var[v].add(d)
    return all_defs, defs_per_var

def gen_kill(blocks):
    _, defs_per_var = enumerate_defs(blocks)
    GEN = [set() for _ in range(len(blocks))]
    KILL = [set() for _ in range(len(blocks))]
    for bi, block in enumerate(blocks):
        last_def = {}  
        for ii, ins in enumerate(block):
            for v in instr_defs(ins):
                last_def[v] = (v, (bi, ii))
        # GEN[B_i] by last_def
        GEN[bi] = set(last_def.values())
        # KILL[B_i] by all other defs
        kill = set()
        for v in last_def:
            kill |= defs_per_var[v]
        KILL[bi] = kill - GEN[bi]
    return GEN, KILL


# OUT[B_i]= GEN[B_i] ∪ (OUT[B_(i-1)]−KILL[B_i])
def make_reaching_defs_problem(blocks):
    GEN, KILL = gen_kill(blocks)

    def merge_union(values):
        out = set()
        for v in values: out |= v
        return out

    def transfer(bi, INb) -> set:
        return GEN[bi] | (INb - KILL[bi])

    return DataFlowProblem(direction="forward",
                           init=set(),
                           merge=merge_union,
                           transfer=transfer)