from copy import deepcopy

def as_bool(v):
    if isinstance(v, bool):
        return v
    if isinstance(v, int):
        return v != 0
    raise TypeError(f"not a bool: {v}")

def deepcopy_env(env):
    return deepcopy(env)

def find_func(prog, name):
    funcs = prog["functions"] if isinstance(prog, dict) and "functions" in prog else prog
    for f in funcs:
        if f.get("name") == name:
            return f
    return None

def build_label_map(instrs):
    m = {}
    for i, ins in enumerate(instrs):
        if "label" in ins:
            m[ins["label"]] = i
    return m

def collect_labels(instrs):
    return {ins["label"] for ins in instrs if "label" in ins}

def fresh_label(existing, base):
    i = 0
    s = base
    while s in existing:
        i += 1
        s = f"{base}_{i}"
    return s

def parse_kv_args(argv):
    out = {}
    for tok in argv:
        if "=" not in tok:
            continue
        k, v = tok.split("=", 1)
        vl = v.lower()
        if vl in ("true", "false"):
            out[k] = (vl == "true")
            continue
        try:
            out[k] = int(v)
        except ValueError:
            out[k] = v
    return out
