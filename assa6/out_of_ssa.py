import helpers
import ssa

def type_of_name(blocks, varname):
    for b in blocks:
        for ins in b:
            if ins.get('dest') == varname and 'type' in ins:
                return ins['type']
    base = varname.rsplit('.', 1)[0]
    for b in blocks:
        for ins in b:
            d = ins.get('dest')
            if d and d.startswith(base + '.') and 'type' in ins:
                return ins['type']
    return 'int'


def schedule_parallel_copies(pairs, typeof):
    moves = []
    pending = {d: s for d, s in pairs if d != s}
    used_as_src = set(pending.values())

    def fresh_temp_like(x):
        base = x.rsplit('.', 1)[0]
        i = 1
        while True:
            t = f"__tmp_{base}_{i}"
            if t not in pending and t not in used_as_src:
                return t
            i += 1

    # acyclic first
    progress = True
    while progress:
        progress = False
        for d, s in list(pending.items()):
            if d not in used_as_src:
                moves.append({'op':'id','args':[s],'dest':d,'type': typeof(d)})
                used_as_src.discard(s)
                del pending[d]
                progress = True

    # cycles
    while pending:
        d0, s0 = next(iter(pending.items()))
        t = fresh_temp_like(d0)
        moves.append({'op':'id','args':[s0],'dest':t,'type': typeof(d0)})
        cur_dst = d0
        cur_src = s0
        while True:
            nxt_dst = None
            nxt_src = None
            for d, s in pending.items():
                if d == cur_src:
                    nxt_dst, nxt_src = d, s
                    break
            if nxt_dst is None:
                break
            moves.append({'op':'id','args':[nxt_src],'dest':cur_dst,'type': typeof(cur_dst)})
            del pending[nxt_dst]
            used_as_src.discard(nxt_src)
            cur_dst, cur_src = nxt_dst, nxt_src
            if cur_dst == d0:
                break
        moves.append({'op':'id','args':[t],'dest':cur_dst,'type': typeof(cur_dst)})
    return moves


def out_of_ssa(func):
    instrs = [dict(i) for i in func['instrs']]
    blocks = helpers.split_blocks(instrs)
    succs, preds, label2bid = helpers.build_cfg(blocks)

    # collect phis and insert copies at preds
    for bi, block in enumerate(blocks):
        insert_at, phis, body_start = ssa.block_head_phi_list(block)
        if not phis:
            continue
        # map pred -> list of (dst, src)
        copies_per_pred = {p: [] for p in preds[bi]}
        for _, phi in phis:
            dest = phi['dest']
            labs = phi.get('labels', [])
            args = phi.get('args', [])
            for lb, src in zip(labs, args):
                p = label2bid.get(lb)
                if p is not None:
                    copies_per_pred[p].append((dest, src))
        # schedule and splice before predecessor terminators
        for p, pairs in copies_per_pred.items():
            if not pairs:
                continue
            typeof = lambda v: type_of_name(blocks, v)
            moves = schedule_parallel_copies(pairs, typeof)
            p_block = blocks[p]
            # insert before terminator
            k = len(p_block)
            term_idx = k - 1 if k > 0 and helpers.is_term(p_block[-1]) else k
            blocks[p] = p_block[:term_idx] + moves + p_block[term_idx:]
        # drop phis in this block
        lo, _, hi = ssa.block_head_phi_list(blocks[bi])
        blocks[bi] = blocks[bi][:lo] + blocks[bi][hi:]

    new_instrs = [ins for b in blocks for ins in b]
    new_func = dict(func)
    new_func['instrs'] = new_instrs
    return new_func