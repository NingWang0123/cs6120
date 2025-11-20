import sys, json
from tracer_helpers import (
    as_bool, find_func, build_label_map, parse_kv_args
)

def run_and_trace_once(prog, args_dict=None, trace_limit=10000):
    main = find_func(prog, "main")
    if main is None:
        raise RuntimeError("no main")

    instrs = main["instrs"]
    labels = build_label_map(instrs)

    env = {}
    if args_dict:
        env.update(args_dict)

    pc = 0
    trace = []
    steps = 0

    def read_var(x):
        if isinstance(x, (int, bool)):
            return x
        return env.get(x, 0)

    while pc < len(instrs):
        ins = instrs[pc]
        steps += 1
        if steps > trace_limit:
            break

        if "label" in ins:
            pc += 1
            continue

        op = ins.get("op")
        if op == "const":
            env[ins["dest"]] = ins["value"]
            trace.append(dict(ins))
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
            trace.append(dict(ins))
            pc += 1

        elif op == "jmp":
            tgt = ins.get("labels", [None])[0]
            if tgt is None:
                raise RuntimeError("jmp without label")
            pc = labels[tgt]

        elif op == "br":
            c = as_bool(read_var(ins["args"][0]))
            trace.append({"op": "guard", "args": [ins["args"][0]], "labels": []})
            t, f = ins.get("labels", [None, None])[:2]
            pc = labels[t] if c else labels[f]

        elif op == "call":
            trace.append(dict(ins))
            if "dest" in ins:
                env[ins["dest"]] = 0
            pc += 1

        elif op == "ret":
            trace.append(dict(ins))
            break

        else:
            break

    return {
        "name": "trace_main",
        "type": "func",
        "args": main.get("args", []),
        "ret": main.get("ret"),
        "instrs": trace
    }

def main():
    if len(sys.argv) < 2:
        print("usage: tracer_interpreter.py program.json [argK=v ...] > trace.json", file=sys.stderr)
        sys.exit(1)

    with open(sys.argv[1]) as f:
        prog = json.load(f)

    args_dict = parse_kv_args(sys.argv[2:])
    trace_fn = run_and_trace_once(prog, args_dict=args_dict)
    json.dump(trace_fn, sys.stdout, indent=2)
    print()

if __name__ == "__main__":
    main()
