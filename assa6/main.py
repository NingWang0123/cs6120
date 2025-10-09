import ssa
import out_of_ssa
import json
import sys 

def static_instr_count(func):
    return sum(1 for ins in func['instrs'] if 'op' in ins)


def round_trip_overhead(func):
    s0 = static_instr_count(func)
    ssa = ssa.to_ssa(func)
    back = out_of_ssa.out_of_ssa(ssa)
    s1 = static_instr_count(back)
    return {"static_before": s0, "static_after": s1, "delta": s1 - s0}


if __name__ == '__main__':
    data = json.load(sys.stdin)
    if 'functions' in data:
        funcs = data['functions']
    else:
        funcs = [data]

    mode = sys.argv[1] if len(sys.argv) > 1 else 'to-ssa'
    out_funcs = []
    for f in funcs:
        if mode == 'to-ssa':
            out_funcs.append(ssa.to_ssa(f))
        elif mode == 'out-of-ssa':
            out_funcs.append(out_of_ssa.out_of_ssa(f))
        elif mode == 'overhead':
            print(round_trip_overhead(f))
            out_funcs.append(f)
        else:
            raise SystemExit("Usage: python ssa_toolkit.py [to-ssa|out-of-ssa|overhead] < prog.json > out.json")

    out = {"functions": out_funcs} if 'functions' in data else out_funcs[0]
    json.dump(out, sys.stdout, indent=2)



# bril2json < grad_desc.bril | python3 main.py