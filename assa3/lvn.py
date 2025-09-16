import sys
import json

from tdce import (
    split_blocks, join_blocks,
    remove_locally_killed, remove_global_unused,
    terminators,is_label  
)

commutative = {"add", "mul"}


def const_key(ty, value):
    return ("const", ty, value)


def copy_key(ty, src_num):
    return ("copy", ty, src_num)


def fold_const(op, vals, ty):
    try:
        if ty == "int":
            if op == "add": return vals[0] + vals[1]
            if op == "sub": return vals[0] - vals[1]
            if op == "mul": return vals[0] * vals[1]
            if op == "div" and vals[1] != 0: return vals[0] // vals[1]
            if op == "eq": return bool(vals[0] == vals[1])
            if op == "lt": return bool(vals[0] < vals[1])
            if op == "le": return bool(vals[0] <= vals[1])
            if op == "gt": return bool(vals[0] > vals[1])
            if op == "ge": return bool(vals[0] >= vals[1])
        if ty == "bool":
            if op == "and": return bool(vals[0]) and bool(vals[1])
            if op == "or": return bool(vals[0]) or bool(vals[1])
            if op == "not": return not bool(vals[0])
            if op == "eq": return bool(vals[0] == vals[1])
    except Exception:
        pass
    return None

def freeze_type(ty):
    """Helper to ensure type is hashable"""
    return ty if isinstance(ty, str) else "int"

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

def get_block_inputs(block):
    """Find variables read before written in a block"""
    read_vars = set()
    written_vars = set()
    
    for instr in block:
        if 'args' in instr:
            for arg in instr['args']:
                if arg not in written_vars:
                    read_vars.add(arg)
        if 'dest' in instr:
            written_vars.add(instr['dest'])
    
    return read_vars

def lvn_block(block):
    """Optimize a single block using LVN"""
    var2num = {}
    
    num2var = {}
    
    value2num = {}
    
    num2const = {}
    
    next_num = [0]
    
    def fresh_num():
        n = next_num[0]
        next_num[0] += 1
        return n
    
    # initialize with input variables
    for var in get_block_inputs(block):
        num = fresh_num()
        var2num[var] = num
        num2var[num] = var
    
    # process each instruction
    optimized = []
    
    for instr in block:
        # skip labels
        if is_label(instr):
            optimized.append(instr)
            continue
        
        # get value numbers for arguments
        if 'args' in instr:
            arg_nums = []
            canonical_args = []
            
            for arg in instr['args']:
                if arg not in var2num:
                    # fresh variable, assign new number
                    num = fresh_num()
                    var2num[arg] = num
                    num2var[num] = arg
                
                num = var2num[arg]
                arg_nums.append(num)
                canonical_args.append(num2var[num])
            
            # update instr with canonical arguments
            instr = dict(instr)
            instr['args'] = canonical_args
        
        # process the instruction based on its operation
        if 'dest' in instr:
            if instr['op'] == 'const':

                num = fresh_num()
                var2num[instr['dest']] = num
                num2var[num] = instr['dest']
                num2const[num] = instr['value']
                
                # check seen before
                const_key = ("const", freeze_type(instr.get('type', 'int')), instr['value'])
                if const_key in value2num:
                    old_num = value2num[const_key]
                    var2num[instr['dest']] = old_num
                    # Replace with copy
                    instr = {
                        'op': 'id',
                        'dest': instr['dest'],
                        'args': [num2var[old_num]]
                    }
                    if 'type' in instr:
                        instr['type'] = instr['type']
                else:
                    value2num[const_key] = num
                
                optimized.append(instr)
                
            elif instr['op'] == 'id':
                # copy inst
                src_num = var2num[instr['args'][0]]
                var2num[instr['dest']] = src_num
                optimized.append(instr)
                
            elif instr['op'] == 'call':
                num = fresh_num()
                var2num[instr['dest']] = num
                num2var[num] = instr['dest']
                optimized.append(instr)
                
            else:

                ty = freeze_type(instr.get('type', 'int'))
                
                norm_key = normalize_key(instr['op'], ty, arg_nums, num2const)
                
                # check normalized 
                if norm_key[0] == "const":

                    _, ty, val = norm_key
                    num = fresh_num()
                    var2num[instr['dest']] = num
                    num2var[num] = instr['dest']
                    num2const[num] = val
                    
                    new_instr = {
                        'op': 'const',
                        'dest': instr['dest'],
                        'value': val
                    }
                    if ty:
                        new_instr['type'] = ty
                    optimized.append(new_instr)
                    
                elif norm_key[0] == "copy":

                    _, ty, src_num = norm_key
                    var2num[instr['dest']] = src_num
                    
                    new_instr = {
                        'op': 'id',
                        'dest': instr['dest'],
                        'args': [num2var[src_num]]
                    }
                    if ty:
                        new_instr['type'] = ty
                    optimized.append(new_instr)
                    
                else:

                    if norm_key in value2num:

                        existing_num = value2num[norm_key]
                        var2num[instr['dest']] = existing_num
                        
                        # replace with copy or constant
                        if existing_num in num2const:
                            new_instr = {
                                'op': 'const',
                                'dest': instr['dest'],
                                'value': num2const[existing_num]
                            }
                            if ty:
                                new_instr['type'] = ty
                        else:
                            new_instr = {
                                'op': 'id',
                                'dest': instr['dest'],
                                'args': [num2var[existing_num]]
                            }
                            if ty:
                                new_instr['type'] = ty
                        optimized.append(new_instr)
                    else:
                        num = fresh_num()
                        var2num[instr['dest']] = num
                        num2var[num] = instr['dest']
                        value2num[norm_key] = num
                        optimized.append(instr)
        else:
            optimized.append(instr)
    
    return optimized

def lvn_func(prog):
    
    for func in prog.get('functions', []):
        blocks = split_blocks(func['instrs'])
        optimized_blocks = []
        
        for block in blocks:
            optimized_block = lvn_block(block)
            optimized_blocks.append(optimized_block)
        
        func['instrs'] = join_blocks(optimized_blocks)

        changed = True
        while changed:
            c1 = remove_locally_killed(func)
            c2 = remove_global_unused(func)
            changed = c1 or c2
    
    return prog



# def lvn_func(func):
#     blocks = split_blocks(func["instrs"])
#     out_blocks = []
#     temp_counter = [0]
#     for b in blocks:
#         out_blocks.append(lvn_block(b, temp_counter))
#     func["instrs"] = join_blocks(out_blocks)

#     changed = True
#     while changed:
#         c1 = remove_locally_killed(func)
#         c2 = remove_global_unused(func)
#         changed = c1 or c2

#     return func

# Main entry point
if __name__ == "__main__":

    prog = json.load(sys.stdin)
    optimized = lvn_func(prog)
    json.dump(optimized, sys.stdout, indent=2, sort_keys=True)
