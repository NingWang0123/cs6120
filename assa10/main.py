import sys
import json
from trace import inject_speculation_into_main

def main():
    if len(sys.argv) > 1 and sys.argv[1] != "-":
        with open(sys.argv[1]) as f:
            prog = json.load(f)
    else:
        prog = json.load(sys.stdin)

    inject_speculation_into_main(prog, func_name="main")

    json.dump(prog, sys.stdout, indent=2)
    print()  

if __name__ == "__main__":
    main()
