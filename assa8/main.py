import sys
import json
import argparse
import licm  

def main():
    ap = argparse.ArgumentParser(description="Bril LICM driver")
    ap.add_argument(
        "--out-of-ssa",
        action="store_true",
        help="After licm, convert back out of SSA"
    )
    args = ap.parse_args()

    prog = json.load(sys.stdin)
    out_funcs = []
    for f in prog.get("functions", []):
        out_funcs.append(licm.licm_function(f, out_of_ssa=args.out_of_ssa))
    prog["functions"] = out_funcs

    json.dump(prog, sys.stdout, indent=2)
    sys.stdout.write("\n")

if __name__ == "__main__":
    main()
