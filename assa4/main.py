import sys, json
import helpers         
import reach_defs
import live_vars
import generic_solver



def fmt_set(s):
    return "{" + ", ".join(sorted(map(str, s))) + "}"

def main():
    prog = json.load(sys.stdin)
    for f in prog.get("functions", []):
        name = f.get("name", "<anon>")
        instrs = f.get("instrs", [])
        blocks = helpers.split_blocks(instrs)
        succs, preds, label_to_block_id = helpers.build_cfg(blocks)

        lv_problem = live_vars.make_live_vars_problem(blocks)
        IN_LV, OUT_LV = generic_solver.solve_dataflow(blocks, succs, preds, lv_problem)

        rd_problem = reach_defs.make_reaching_defs_problem(blocks)
        IN_RD, OUT_RD = generic_solver.solve_dataflow(blocks, succs, preds, rd_problem)

        for i in range(len(blocks)):
            print(f"[B{i}] LV  IN={fmt_set(IN_LV[i])}  OUT={fmt_set(OUT_LV[i])}")
        for i in range(len(blocks)):
            print(f"[B{i}] RD  IN={fmt_set(IN_RD[i])}  OUT={fmt_set(OUT_RD[i])}")

if __name__ == "__main__":
    main()
