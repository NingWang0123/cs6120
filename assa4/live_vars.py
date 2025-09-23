from generic_solver import DataFlowProblem

def instr_uses(instr):
    return set(instr.get('args', []))

def instr_defs(instr):
    d = instr.get('dest')
    return {d} if d is not None else set()


def block_USE_DEF(block):
    seen_defs = set()
    USE = set()
    DEF = set()
    for ins in block:
        u = instr_uses(ins)
        # USE: vars read before any definition in block
        USE |= {v for v in u if v not in seen_defs}
        #DEF: vars defined in b
        d = instr_defs(ins)
        DEF |= d
        seen_defs |= d
    return USE, DEF

# IN[b] = USE[b] ∪ (OUT[b] − DEF[b])
def make_live_vars_problem(blocks):
    USE = []
    DEF = []
    for b in blocks:
        u, d = block_USE_DEF(b)
        USE.append(u)
        DEF.append(d)

    def merge_union(values):
        out = set()
        for v in values: out |= v
        return out

    def transfer(bi, OUTb) -> set:
        return USE[bi] | (OUTb - DEF[bi])

    return DataFlowProblem(direction="backward",
                           init=set(),
                           merge=merge_union,
                           transfer=transfer)