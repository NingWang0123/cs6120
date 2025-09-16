import sys
import json
from copy import deepcopy

from tdce import (
    split_blocks, join_blocks,
    remove_locally_killed, remove_global_unused,
    terminators,  # imported but only barrier uses effectful_ops
)

commutative = {"add", "mul"}
# barrier_ops = set(effectful_ops)  # set() if you want no barriers


# same idea from the video
def will_be_overwritten_later(block, i, dest):
    for j in range(i + 1, len(block)):
        instr = block[j]
        if instr.get("dest") == dest:
            return True
    return False


def fold_const(op, vals, ty):
    try:
        if ty == "int":
            if op == "add": return vals[0] + vals[1]
            if op == "sub": return vals[0] - vals[1]
            if op == "mul": return vals[0] * vals[1]
            if op == "div" and vals[1] != 0: return vals[0] // vals[1]
            if op == "eq":  return bool(vals[0] == vals[1])
            if op == "lt":  return bool(vals[0] <  vals[1])
            if op == "le":  return bool(vals[0] <= vals[1])
            if op == "gt":  return bool(vals[0] >  vals[1])
            if op == "ge":  return bool(vals[0] >= vals[1])
        if ty == "bool":
            if op == "and": return bool(vals[0]) and bool(vals[1])
            if op == "or":  return bool(vals[0]) or  bool(vals[1])
            if op == "not": return not bool(vals[0])
            if op == "eq":  return bool(vals[0] == vals[1])
    except Exception:
        pass
    return None


def normalize_key(op, ty, arg_nums, num2const):
    """
    Normalized LVN key:
      ("const", ty, value)
      ("copy", ty, src_num)
      ("op", ty, op, tuple(arg_nums))
    """
    # commutativity
    if op in commutative:
        arg_nums = tuple(sorted(arg_nums))
    else:
        arg_nums = tuple(arg_nums)

    # algebraic identities (safe subset)
    if op == "add" and len(arg_nums) == 2:
        a, b = arg_nums
        ca, cb = num2const.get(a), num2const.get(b)
        # x + 0 / 0 + x
        if ca == 0: return ("copy", ty, b)
        if cb == 0: return ("copy", ty, a)
        if ca == 0 and cb == 0: return ("const", ty, 0)

    if op == "mul" and len(arg_nums) == 2:
        a, b = arg_nums
        ca, cb = num2const.get(a), num2const.get(b)
        if ca == 0 or cb == 0: return ("const", ty, 0)
        # x * 1 / 1 * x
        if ca == 1: return ("copy", ty, b)
        if cb == 1: return ("copy", ty, a)

    if op == "sub" and len(arg_nums) == 2:
        a, b = arg_nums
        ca, cb = num2const.get(a), num2const.get(b)
        # x - 0
        if cb == 0: return ("copy", ty, a)
        if ca == 0 and cb == 0: return ("const", ty, 0)

    # constant folding
    vals = [num2const.get(n) for n in arg_nums]
    if all(v is not None for v in vals):
        base_ty = "bool" if any(isinstance(v, bool) for v in vals) else "int"
        fv = fold_const(op, vals, ty)
        if fv is not None:
            out_ty = "bool" if isinstance(fv, bool) else base_ty
            return ("const", freeze_type(out_ty), fv)

    return ("op", ty, op, arg_nums)


def const_key(ty, value):
    return ("const", ty, value)


def copy_key(ty, src_num):
    return ("copy", ty, src_num)


# lvn helpers
def generate_fresh_num(next_num):
    n = next_num[0]
    next_num[0] += 1
    return n


def generate_fresh_temp(temp_counter):
    t = f"lvn_t{temp_counter[0]}"
    temp_counter[0] += 1
    return t


def num_for_var(a, next_num, var2num, num2var):
    if a not in var2num:
        n = generate_fresh_num(next_num)
        var2num[a] = n
        num2var[n] = a
    return var2num[a]


def freeze_type(ty):
    if isinstance(ty, (dict, list)):
        return json.dumps(ty, sort_keys=True)  
    return ty

# lvn for one block
def lvn_block(block, temp_counter):
    table = {}       # key -> (num, canonical_var)
    var2num = {}     # var -> num
    num2var = {}     # num -> var
    num2const = {}   # num -> constant value
    next_num = [1]

    out = []
    i = 0
    while i < len(block):
        instr = deepcopy(block[i])
        i += 1

        if "op" not in instr:
            out.append(instr)
            continue

        op = instr["op"]
        ty = instr.get("type")
        ty_key = freeze_type(ty)

        # canonicalize arguments
        args = instr.get("args", [])
        arg_nums = [num_for_var(a, next_num, var2num, num2var) for a in args]
        canon_args = [num2var[n] for n in arg_nums]
        instr["args"] = canon_args

        # build key
        if op == "const":
            key = const_key(freeze_type(instr.get("type", ty)), instr.get("value"))
        if op == "id":
            key = copy_key(ty_key, arg_nums[0])
        else:
            key = normalize_key(op, ty_key, arg_nums, num2const)

        # case: constant
        if key[0] == "const":
            _, cty_key, cval = key
            dest = instr.get("dest")

            if key in table:
                num, canon = table[key]
                if dest is None or dest == canon:
                    if dest is not None:
                        var2num[canon] = num
                    continue
                out.append({"op": "id", "type": ty, "dest": dest, "args": [canon]})
                var2num[dest] = num
                continue

            num = generate_fresh_num(next_num)
            canon = instr.get("dest") or generate_fresh_temp(temp_counter)
            table[key] = (num, canon)
            num2const[num] = cval
            num2var[num] = canon
            var2num[canon] = num

            out.append({"op": "const", "type": instr.get("type", ty), "dest": canon, "value": cval})

            if dest is not None and dest != canon:
                out.append({"op": "id", "type": instr.get("type", ty), "dest": dest, "args": [canon]})
                var2num[dest] = num
            continue

        # case: copy
        if key[0] == "copy":
            _, _cty_key, src_num = key
            src = num2var[src_num]
            dest = instr.get("dest")
            if dest is None or dest == src:
                if dest is not None:
                    var2num[dest] = src_num
                continue
            out.append({"op": "id", "type": ty, "dest": dest, "args": [src]})
            var2num[dest] = src_num
            continue

        # case: general op
        _, kty_key, _kop, _kargs = key
        kty_out = ty  

        if key in table:
            num, canon = table[key]
            dest = instr.get("dest")
            if dest is None or dest == canon:
                if dest is not None:
                    var2num[dest] = num
                continue
            out.append({"op": "id", "type": kty_out, "dest": dest, "args": [canon]})
            var2num[dest] = num
        else:
            num = generate_fresh_num(next_num)
            dest = instr.get("dest")
            if dest is None:
                dest = generate_fresh_temp(temp_counter)
                instr["dest"] = dest

            if will_be_overwritten_later(block, i - 1, dest):
                canon = generate_fresh_temp(temp_counter)
                instr["dest"] = canon
                out.append(instr)
                out.append({"op": "id", "type": kty_out, "dest": dest, "args": [canon]})
            else:
                canon = dest
                out.append(instr)

            table[key] = (num, canon)
            num2var[num] = canon
            var2num[canon] = num
            var2num[dest] = num

    return out


def lvn_function(func):
    blocks = split_blocks(func["instrs"])
    out_blocks = []
    temp_counter = [0]
    for b in blocks:
        out_b = lvn_block(b, temp_counter)
        out_blocks.append(out_b)
    func["instrs"] = join_blocks(out_blocks)

    # changed = True
    # while changed:
    #     c1 = remove_locally_killed(func)
    #     c2 = remove_global_unused(func)
    #     changed = c1 or c2

    return func


def lvn_program(prog):
    prog = deepcopy(prog)
    for f in prog.get("functions", []):
        lvn_function(f)
    return prog


def main():
    prog = json.load(sys.stdin)
    prog = lvn_program(prog)
    json.dump(prog, sys.stdout, indent=2)




if __name__ == "__main__":
    main()

