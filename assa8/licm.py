import copy
import helpers
import ssa
import out_of_ssa as oossa


PURE_OPS = {
"add","sub","mul","fadd","fsub","fmul","idiv","fdiv",
"eq","feq","lt","le","gt","ge","and","or","not","xor","shr","shl",
"id","fptosi","sitofp","itob","btoi","ptradd","const"
}

SIDE_EFFECT_OPS = {"print","br","jmp","ret","store","free","alloc","call"}


def is_value(instr):
    return 'dest' in instr and 'op' in instr


def is_pure(instr):
    op = instr.get('op')
    return op in PURE_OPS and op not in SIDE_EFFECT_OPS


def build_maps(blocks):
    def_block = {}
    for bi, block in enumerate(blocks):
        for ins in block:
            d = ins.get('dest')
            if d:
                def_block[d] = bi
    return def_block


def dominates(dom, a, b):
    return a in dom[b]


def build_def_block_map(blocks):
    m = {}
    for bi, block in enumerate(blocks):
        for ins in block:
            d = ins.get("dest")
            if d:
                m[d] = bi
    return m




def find_back_edges(dom, succs):
    edges = []
    for u, outs in enumerate(succs):
        for v in outs:
            if v in dom[u]:
                edges.append((u, v))
    return edges


def loop_nodes_from_backedge(preds, tail, head):
    loop = {head}
    stack = [tail]
    while stack:
        x = stack.pop()
        if x in loop:
            continue
        loop.add(x)
        for p in preds[x]:
            stack.append(p)
    return loop




def ensure_preheader(blocks, succs, preds, header, loop_nodes):
    # predecessors of the header outside the loop
    outside_preds = [p for p in preds[header] if p not in loop_nodes]
    if len(outside_preds) == 1:
        return outside_preds[0], blocks, succs, preds

    # create a preheader block that jumps to the header's label
    hdr_label = helpers.block_label(blocks[header]) or f".B{header}"
    pre_label = f"{hdr_label}_pre"
    pre_block = [{"label": pre_label}, {"op": "jmp", "labels": [hdr_label]}]

    # insert preheader right before 'header' t
    insert_at = header
    new_blocks = blocks[:insert_at] + [pre_block] + blocks[insert_at:]

    # rebuild CFG 
    new_succs, new_preds, _ = helpers.build_cfg(new_blocks)

    new_header_idx = header + 1

    # redirect all predecessors of the shifted header 
    for p in list(new_preds[new_header_idx]):
        if p not in loop_nodes:
            term = new_blocks[p][-1] if new_blocks[p] else None
            if term and term.get("op") in {"br", "jmp"}:
                term["labels"] = [pre_label if l == hdr_label else l
                                  for l in term.get("labels", [])]

    final_succs, final_preds, _ = helpers.build_cfg(new_blocks)

    pre_idx = insert_at  
    return pre_idx, new_blocks, final_succs, final_preds


def licm_function(func, out_of_ssa=False):

    # to ssa
    f_ssa = ssa.to_ssa(func)
    blocks = helpers.split_blocks(f_ssa["instrs"])
    succs, preds, _ = helpers.build_cfg(blocks)
    dom, _ = helpers.compute_dominators(0, succs, preds)

    # get loops
    loops = []
    for tail, head in find_back_edges(dom, succs):
        nodes = loop_nodes_from_backedge(preds, tail, head)
        loops.append((nodes, head))

    # apply licm per loop
    for loop_nodes, header in loops:
        pre_idx, blocks, succs, preds = ensure_preheader(blocks, succs, preds, header, loop_nodes)
        dom, _ = helpers.compute_dominators(0, succs, preds)  

        def_block = build_def_block_map(blocks)
        # loop exits: blocks in loop with an edge to outside
        exit_blocks = {b for b in loop_nodes for s in succs[b] if s not in loop_nodes}

        hoist_list = []  
        for bi in sorted(loop_nodes):
            for ii, ins in enumerate(blocks[bi]):
                if not is_value(ins):
                    continue
                if not is_pure(ins):
                    continue
                args_outside_loop = True
                for a in ins.get("args", []):
                    if isinstance(a, (int, float, bool)): 
                        continue
                    db = def_block.get(a)
                    if db is not None and db in loop_nodes:
                        args_outside_loop = False
                        break
                if not args_outside_loop:
                    continue
                if not all(dominates(dom, bi, eb) for eb in exit_blocks):
                    continue
                hoist_list.append((bi, ii))

        if not hoist_list:
            continue

        pre_block = blocks[pre_idx]
        insert_at = len(pre_block) - 1 if (pre_block and helpers.is_term(pre_block[-1])) else len(pre_block)

        hoist_list.sort()  
        hoisted = [copy.deepcopy(blocks[bi][ii]) for (bi, ii) in hoist_list]
        pre_block[insert_at:insert_at] = hoisted

        # remove originals 
        for bi in sorted({b for b, _ in hoist_list}):
            idxs = [ii for b, ii in hoist_list if b == bi]
            for ii in sorted(idxs, reverse=True):
                del blocks[bi][ii]

        # update cfg
        succs, preds, _ = helpers.build_cfg(blocks)
        dom, _ = helpers.compute_dominators(0, succs, preds)

    new_func = dict(f_ssa)
    new_func["instrs"] = [ins for b in blocks for ins in b]

    if out_of_ssa:
        new_func = oossa.out_of_ssa(new_func)

    return new_func

