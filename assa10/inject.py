import sys, json
from tracer_helpers import (
    find_func, collect_labels, fresh_label
)

def inject_trace(prog, trace_fn):
    main = find_func(prog, "main")
    if main is None:
        raise RuntimeError("no main")

    orig = list(main.get("instrs", []))
    if not orig:
        return prog

    existing = collect_labels(orig)
    fast_entry = fresh_label(existing, "__trace_entry")
    slow_entry = fresh_label(existing, "__slow_path")

    trace_body = []
    for ins in trace_fn["instrs"]:
        if "label" in ins:
            continue
        if ins.get("op") == "guard":
            wired = dict(ins)
            wired["labels"] = [slow_entry]
            trace_body.append(wired)
        else:
            trace_body.append(ins)

    new_instrs = []
    new_instrs.append({"label": fast_entry})
    new_instrs.append({"op": "speculate"})

    ends_with_ret = (len(trace_body) > 0 and trace_body[-1].get("op") == "ret")
    if ends_with_ret:
        for ins in trace_body[:-1]:
            new_instrs.append(ins)
        new_instrs.append({"op": "commit"})
        new_instrs.append(trace_body[-1])
    else:
        for ins in trace_body:
            new_instrs.append(ins)
        new_instrs.append({"op": "commit"})
        new_instrs.append({"op": "jmp", "labels": [slow_entry]})

    new_instrs.append({"label": slow_entry})
    new_instrs.extend(orig)

    main["instrs"] = new_instrs
    return prog

def main():
    if len(sys.argv) < 3:
        print("usage: inject_trace.py program.json trace.json > stitched.json", file=sys.stderr)
        sys.exit(1)

    with open(sys.argv[1]) as f:
        prog = json.load(f)
    with open(sys.argv[2]) as f:
        trace_fn = json.load(f)

    stitched = inject_trace(prog, trace_fn)
    json.dump(stitched, sys.stdout, indent=2)
    print()

if __name__ == "__main__":
    main()
