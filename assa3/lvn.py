import sys, json, itertools
from copy import deepcopy

COMMUTATIVE = {"add", "mul", "and", "or", "eq"}  # extend per language
TERMINATORS = {"jmp", "br", "ret"}
EFFECT_BARRIERS = {"call", "store", "free", "print", "jmp", "br", "ret"}

def split_blocks(instrs):
    blocks, cur = [], []
    for ins in instrs:
        start_new = ("label" in ins and "op" not in ins) or (cur and cur[-1].get("op") in TERMINATORS)
        if start_new and cur:
            blocks.append(cur); cur = []
        cur.append(ins)
    if cur: blocks.append(cur)
    return blocks

def join_blocks(blocks):
    out = []
    for b in blocks: out.extend(b)
    return out

def will_be_overwritten_later(idx, dest, block):
    for j in range(idx+1, len(block)):
        ins = block[j]
        if ins.get("dest") == dest: return True
        if ins.get("op") in TERMINATORS: return False
    return False

def is_effect_barrier(ins):
    return ins.get("op") in EFFECT_BARRIERS

def fold_const(op, vs):
    try:
        if op == "add": return vs[0] + vs[1]
        if op == "sub": return vs[0] - vs[1]
        if op == "mul": return vs[0] * vs[1]
        if op == "div": return vs[0] // vs[1]  # int division for core Bril
        if op == "and": return int(bool(vs[0]) and bool(vs[1]))
        if op == "or":  return int(bool(vs[0]) or bool(vs[1]))
        if op == "not": return 0 if vs[0] else 1
        if op == "eq":  return int(vs[0] == vs[1])
        if op == "lt":  return int(vs[0] <  vs[1])
        if op == "le":  return int(vs[0] <= vs[1])
        if op == "gt":  return int(vs[0] >  vs[1])
        if op == "ge":  return int(vs[0] >= vs[1])
    except Exception:
        pass
    return None

def normalize(op, arg_nums, num2const):
    # algebraic identities (simple)
    if op == "add":
        # x+0 -> x
        if len(arg_nums)==2:
            a,b = arg_nums
            ca, cb = num2const.get(a), num2const.get(b)
            if ca == 0: return ("copy", (b,))
            if cb == 0: return ("copy", (a,))
    if op == "mul":
        if len(arg_nums)==2:
            a,b = arg_nums
            ca, cb = num2const.get(a), num2const.get(b)
            if ca == 0 or cb == 0: return ("const", (0,))
            if ca == 1: return ("copy", (b,))
            if cb == 1: return ("copy", (a,))
    if op in COMMUTATIVE:
        arg_nums = tuple(sorted(arg_nums))
    return (op, tuple(arg_nums))

def lvn_block(block, temp_gen):
    table = {}         # key -> (num, canon_var)
    var2num = {}       # var -> num
    num2var = {}       # num -> canon var
    num2const = {}     # num -> const int/bool
    next_num = [1]
    def fresh_num():
        n = next_num[0]; next_num[0]+=1; return n

    # seed live-ins with unknown numbers to allow canonicalization
    # we’ll lazily assign numbers when we see a var

    out = []
    # Precompute overwrites
    future_defs = {}
    seen = set()
    for i, ins in enumerate(block):
        d = ins.get("dest")
        if d:
            if d in seen:
                future_defs.setdefault(i, set()).add(d)
            seen.add(d)
    for i, ins in enumerate(block):
        d = ins.get("dest")
        if d:
            # mark if overwritten later (simple lookahead)
            pass

    def num_for_var(v):
        if v not in var2num:
            n = fresh_num()
            var2num[v] = n
            num2var[n] = v
        return var2num[v]

    i = 0
    while i < len(block):
        ins = deepcopy(block[i])
        op = ins.get("op")
        if op is None:  # label
            out.append(ins); i += 1; continue

        if is_effect_barrier(ins):
            # Barrier: keep as-is, but ensure args canonicalized (safe) and update dest number if any
            if "args" in ins:
                ins["args"] = [num2var.get(num_for_var(a), a) for a in ins["args"]]
            d = ins.get("dest")
            if d is not None:
                n = fresh_num()
                var2num[d] = n
                num2var[n] = d
            out.append(ins); i += 1; continue

        # Canonicalize args
        args = ins.get("args", [])
        arg_nums = [num_for_var(a) for a in args]
        canon_args = [num2var[num] for num in arg_nums]
        ins["args"] = canon_args

        # Special cases: const/copy
        if op == "const":
            cval = ins.get("value")
            key = ("const", (cval,))
        elif op == "id":
            key = ("copy", (arg_nums[0],))
        else:
            # normalization + constant folding
            key = normalize(op, tuple(arg_nums), num2const)
            if key[0] not in {"const", "copy"}:
                # fold if possible
                vals = [num2const.get(n) for n in key[1]]
                if all(v is not None for v in vals):
                    fv = fold_const(key[0], vals)
                    if fv is not None:
                        key = ("const", (fv,))

        # If we have seen this value, replace with copy
        if key[0] == "const":
            # materialize or reuse an existing const number
            cval = key[1][0]
            # make a synthetic number for this constant key
            if key in table:
                num, canon = table[key]
            else:
                num = fresh_num()
                # choose a temp name to hold const if reused
                canon = ins.get("dest") or f"t{num}"
                table[key] = (num, canon)
                num2const[num] = cval
                num2var[num] = canon
            # rewrite as const to the chosen dest; if another site already holds the same const under some canon var,
            # we can do copy-to-canon to enable more CSE.
            dest = ins.get("dest")
            if dest is None or dest == canon:
                # emit a single const assignment
                out.append({"op":"const","type":ins.get("type","int"),"dest":canon,"value":cval})
            else:
                out.append({"op":"id","type":ins.get("type","int"),"dest":dest,"args":[canon]})
            var2num[dest or canon] = num
            i += 1; continue

        if key[0] == "copy":
            src_num = key[1][0]
            src = num2var[src_num]
            dest = ins.get("dest")
            if dest is None or dest == src:
                # redundant; drop
                i += 1; continue
            out.append({"op":"id","type":ins.get("type","int"),"dest":dest,"args":[src]})
            var2num[dest] = src_num
            i += 1; continue

        # General value
        if key in table:
            num, canon = table[key]
            dest = ins.get("dest")
            if dest is None or dest == canon:
                # whole instruction becomes a copy is redundant; drop
                # if dest is None, nothing to do; if equal to canon, also redundant
                if dest is not None:
                    # just ensure mapping
                    var2num[dest] = num
                # else nothing
            else:
                out.append({"op":"id","type":ins.get("type","int"),"dest":dest,"args":[canon]})
                var2num[dest] = num
        else:
            num = itertools.count(start=1)  # dummy to force unique? We'll just fresh.
            num = 0  # shadowed; overwritten below
            num = len({**table}) + len(out) + 1  # simple monotone fresh; fine for one block
            # pick dest (rename if overwritten later)
            dest = ins.get("dest")
            if dest is None:  # should not happen for value ops
                dest = f"t{num}"
                ins["dest"] = dest
            if will_be_overwritten_later(i, dest, block):
                canon = f"t{num}"
                ins["dest"] = canon
            else:
                canon = dest
            # record and emit
            table[key] = (num, canon)
            # set num maps; constant map stays empty
            # (replacing args already done)
            out.append(ins)
            var2num[canon] = num
            # if we renamed, ensure dest gets a copy
            if canon != dest:
                out.append({"op":"id","type":ins.get("type","int"),"dest":dest,"args":[canon]})
                var2num[dest] = num
            # track canonical var
            # find a name to remember for this num
        i += 1
    return out

def tdce_local(instrs):
    # quick local kill after LVN (reuses logic from tdce.py, compact)
    blocks = split_blocks(instrs)
    cleaned = []
    for b in blocks:
        last_def, used, keep = {}, {}, [True]*len(b)
        for idx, ins in enumerate(b):
            for a in ins.get("args", []):
                if a in used: used[a] = True
            d = ins.get("dest")
            pure = (ins.get("op") not in {"print","jmp","br","ret","call","store","free"})
            if d:
                if d in last_def and not used.get(d, False) and pure:
                    keep[last_def[d]] = False
                last_def[d] = idx
                used[d] = False
        cleaned.extend([x for x,k in zip(b, keep) if k])
    return cleaned

def lvn_function(func):
    blocks = split_blocks(func["instrs"])
    out_blocks = []
    for b in blocks:
        # generate unique temps with a closure (here just pass a counter through)
        out_b = lvn_block(b, None)
        out_b = tdce_local(out_b)
        out_blocks.append(out_b)
    func["instrs"] = join_blocks(out_blocks)
    return func

def main():
    prog = json.load(sys.stdin)
    prog = deepcopy(prog)
    for f in prog["functions"]:
        lvn_function(f)
    json.dump(prog, sys.stdout, indent=2)

if __name__ == "__main__":
    main()