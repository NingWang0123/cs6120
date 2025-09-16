import sys, json
from copy import deepcopy

from tdce import (
    split_blocks, join_blocks,
    remove_locally_killed, remove_global_unused,
    effectful_ops, terminators
)


commutative = {"add", "mul", "and", "or", "eq"}
barrier_ops = set(effectful_ops)

# same idea from the video
def will_be_overwritten_later(block, i, dest):
    for j in range(i + 1, len(block)):
        instr = block[j]
        if instr.get("dest") == dest:
            return True
    return False

def fold_const(op, vals, type):
    try:
        if type == "int":
            if op == "add": return vals[0] + vals[1]
            if op == "sub": return vals[0] - vals[1]
            if op == "mul": return vals[0] * vals[1]
            if op == "div" and vals[1] != 0: return vals[0] // vals[1]
            if op == "eq":  return bool(vals[0] == vals[1])
            if op == "lt":  return bool(vals[0] <  vals[1])
            if op == "le":  return bool(vals[0] <= vals[1])
            if op == "gt":  return bool(vals[0] >  vals[1])
            if op == "ge":  return bool(vals[0] >= vals[1])
        if type == "bool":
            if op == "and": return bool(vals[0]) and bool(vals[1])
            if op == "or":  return bool(vals[0]) or  bool(vals[1])
            if op == "not": return not bool(vals[0])
            if op == "eq":  return bool(vals[0] == vals[1])
    except Exception:
        pass
    return None



def normalize_key(op, type, arg_nums, num2const):
    """
      ("const", type, value)
      ("copy", type, src_num)
      ("op", type, op, tuple(arg_nums))
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
        # add 0 return orginal number 
        if ca == 0:  return ("copy", type, b)
        if cb == 0:  return ("copy", type, a)
        # 0+0 = 0 
        if ca ==0 and cb==0: return ("const", type, 0)
    if op == "mul" and len(arg_nums) == 2:
        a, b = arg_nums
        ca, cb = num2const.get(a), num2const.get(b)
        if ca == 0 or cb == 0: return ("const", type, 0)
        # multiplied by 1 return orginal number 
        if ca == 1: return ("copy", type, b)
        if cb == 1: return ("copy", type, a)
    if op == "sub" and len(arg_nums) == 2:
        a, b = arg_nums
        ca, cb = num2const.get(a), num2const.get(b)
        # sub 0 return orginal number 
        if cb == 0: return ("copy", type, a)
        # 0-0 = 0 
        if ca ==0 and cb==0: return ("const", type, 0)

    # constant folding 
    vals = [num2const.get(n) for n in arg_nums]
    if all(v is not None for v in vals):
        fv = fold_const(op, vals, type)
        if fv is not None:
            return ("const", "bool" if isinstance(fv, bool) else type, fv)

    return ("op", type, op, arg_nums)

def const_key(type, value):
    return ("const", type, value)

def copy_key(type, src_num):
    return ("copy", type, src_num)




# lvn helpers


def generate_fresh_num(next_num):
    n = next_num[0]
    next_num[0] += 1
    return n


def generate_fresh_temp(temp_counter):
    t = f"lvn_t{temp_counter[0]}"
    temp_counter[0] += 1
    return t


def num_for_var(a,next_num,var2num,num2var):
    if a not in var2num:
        n = generate_fresh_num(next_num)
        var2num[a] = n
        num2var[n] = a
    return var2num[a]


# lvn for one block
def lvn_block(block, temp_counter):

    table = {}       
    var2num = {}      
    num2var = {}     
    num2const = {}    
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
        type = instr.get("type")

        # Treat effectful ops as barriers
        if op in barrier_ops:
            if "args" in instr:
                instr["args"] = [num2var.get(num_for_var(a,next_num,var2num,num2var), a) for a in instr["args"]]
            # If they define a dest, assign a fresh number.
            if "dest" in instr:
                d = instr["dest"]
                n = generate_fresh_num(next_num)
                var2num[d] = n
                num2var[n] = d
            out.append(instr)
            continue

        # canonicalize arguments
        args = instr.get("args", [])
        arg_nums = [num_for_var(a,next_num,var2num,num2var) for a in args]
        canon_args = [num2var[n] for n in arg_nums]
        instr["args"] = canon_args

        # build key
        if op == "const":
            key = const_key(instr.get("type", type), instr.get("value"))
        elif op == "id":
            key = copy_key(type, arg_nums[0])
        else:
            key = normalize_key(op, type, arg_nums, num2const)

        # case: constant
        if key[0] == "const":
            _, cty, cval = key
            # reuse const if seen
            if key in table:
                num, canon = table[key]
            else:
                num = generate_fresh_num(next_num)
                canon = instr.get("dest") or generate_fresh_temp(temp_counter)
                table[key] = (num, canon)
                num2const[num] = cval
                num2var[num] = canon

            dest = instr.get("dest")
            if dest is None or dest == canon:
                out.append({"op": "const", "type": cty, "dest": canon, "value": cval})
            else:
                out.append({"op": "id", "type": cty, "dest": dest, "args": [canon]})
            var2num[dest or canon] = table[key][0]
            continue

        # case: copy
        if key[0] == "copy":
            _, cty, src_num = key
            src = num2var[src_num]
            dest = instr.get("dest")
            if dest is None or dest == src:
                continue
            out.append({"op": "id", "type": cty, "dest": dest, "args": [src]})
            var2num[dest] = src_num
            continue

        # case: op
        _, kty, kop, kargs = key
        if key in table:
            # Reuse: replace with copy of canonical var
            num, canon = table[key]
            dest = instr.get("dest")
            if dest is None or dest == canon:
                if dest is not None:
                    var2num[dest] = num
                continue
            out.append({"op": "id", "type": kty, "dest": dest, "args": [canon]})
            var2num[dest] = num
        else:
            # first time seeing this value
            num = generate_fresh_num(next_num)
            dest = instr.get("dest")
            if dest is None:
                dest = generate_fresh_temp(temp_counter)
                instr["dest"] = dest

            # if dest will be redefined later, keep a stable canonical temp
            if will_be_overwritten_later(block, i - 1, dest):
                canon = generate_fresh_temp(temp_counter)
                instr["dest"] = canon
                out.append(instr)                  
                out.append({"op": "id", "type": kty, "dest": dest, "args": [canon]})
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

    changed = True
    while changed:
        c1 = remove_locally_killed(func)
        c2 = remove_global_unused(func)
        changed = c1 or c2
    return func

def lvn_program(prog):
    prog = deepcopy(prog)
    for f in prog.get("functions", []):
        lvn_function(f)
    return prog


def main():
    data = sys.stdin.read()
    if not data.strip():
        sys.exit("lvn.py: no input on stdin.\nUsage: bril2json < file.bril | python3 lvn.py | bril2txt")
    prog = json.loads(data)
    prog = lvn_program(prog)
    json.dump(prog, sys.stdout, indent=2)

if __name__ == "__main__":
    main()