import sys, json
from tracer_helpers import (
    as_bool, find_func, build_label_map, parse_kv_args, deepcopy_env
)

def run_main(prog, args_dict=None, count_only=False):
    main = find_func(prog, "main")
    if main is None:
        raise RuntimeError("no main")

    instrs = main["instrs"]
    labels = build_label_map(instrs)

    env = {}
    if args_dict:
        env.update(args_dict)

    pc = 0
    instr_count = 0
    snapshot = None
    ret_value = None

    def read_var(x):
        if isinstance(x, (int, bool)):
            return x
        return env.get(x, 0)

    while pc < len(instrs):
        ins = instrs[pc]
        if "label" in ins:
            pc += 1
            continue

        op = ins.get("op")
        instr_count += 1

        if op == "const":
            env[ins["dest"]] = ins["value"]
            pc += 1

        elif op in {"id", "add", "sub", "mul", "div",
                    "eq", "lt", "gt", "le", "ge", "and", "or", "not"}:
            out = ins.get("dest")
            a = ins.get("args", [])
            if op == "id":
                env[out] = read_var(a[0])
            elif op == "not":
                env[out] = (not as_bool(read_var(a[0])))
            elif op == "add":
                env[out] = int(read_var(a[0])) + int(read_var(a[1]))
            elif op == "sub":
                env[out] = int(read_var(a[0])) - int(read_var(a[1]))
            elif op == "mul":
                env[out] = int(read_var(a[0])) * int(read_var(a[1]))
            elif op == "div":
                env[out] = int(read_var(a[0])) // int(read_var(a[1]))
            elif op == "eq":
                env[out] = (read_var(a[0]) == read_var(a[1]))
            elif op == "lt":
                env[out] = (int(read_var(a[0])) < int(read_var(a[1])))
            elif op == "gt":
                env[out] = (int(read_var(a[0])) > int(read_var(a[1])))
            elif op == "le":
                env[out] = (int(read_var(a[0])) <= int(read_var(a[1])))
            elif op == "ge":
                env[out] = (int(read_var(a[0])) >= int(read_var(a[1])))
            elif op == "and":
                env[out] = bool(read_var(a[0])) and bool(read_var(a[1]))
            elif op == "or":
                env[out] = bool(read_var(a[0])) or bool(read_var(a[1]))
            pc += 1

        elif op == "jmp":
            tgt = ins.get("labels", [None])[0]
            if tgt is None:
                raise RuntimeError("jmp without label")
            pc = labels[tgt]

        elif op == "br":
            c = as_bool(read_var(ins["args"][0]))
            t, f = ins.get("labels", [None, None])[:2]
            pc = labels[t] if c else labels[f]

        elif op == "call":
            # Simple stubbed call: return 0 if a dest exists.
            if "dest" in ins:
                env[ins["dest"]] = 0
            pc += 1

        elif op == "print":
            if not count_only:
                out = []
                for a in ins.get("args", []):
                    v = read_var(a)
                    if isinstance(v, bool):
                        out.append("true" if v else "false")
                    else:
                        out.append(str(v))
                print(" ".join(out))
            pc += 1

        elif op == "nop":
            pc += 1

        elif op == "ret":
            a = ins.get("args", [])
            ret_value = read_var(a[0]) if a else None
            break

        elif op == "speculate":
            snapshot = {"env": deepcopy_env(env)}
            pc += 1

        elif op == "guard":
            cond_var = ins.get("args", [None])[0]
            cond = as_bool(read_var(cond_var))
            if cond:
                pc += 1
            else:
                labs = ins.get("labels", [])
                if not snapshot:
                    raise RuntimeError("guard without speculate")
                env = deepcopy_env(snapshot["env"])
                if not labs:
                    raise RuntimeError("guard without fail label")
                pc = labels[labs[0]]

        elif op == "commit":
            snapshot = None
            pc += 1

        else:
            raise RuntimeError(f"unsupported op: {op}")

    if count_only:
        return instr_count
    return ret_value, instr_count

def main():
    if len(sys.argv) < 2:
        print("usage: spec_brili.py program.json [argK=v ...]", file=sys.stderr)
        sys.exit(1)

    with open(sys.argv[1]) as f:
        prog = json.load(f)

    args_dict = parse_kv_args(sys.argv[2:])
    ret, cnt = run_main(prog, args_dict=args_dict, count_only=False)
    print(json.dumps({"return": ret, "instr_count": cnt}))

if __name__ == "__main__":
    main()



# make -f Makefile.mak eval PROG=grad_desc.bril