import sys, json, argparse
import helpers
import reach_defs
import live_vars
import initialized_variables
import generic_solver

def main():
    parser = argparse.ArgumentParser(description='Data Flow Analysis Tool')
    parser.add_argument('--analysis', choices=['all', 'live', 'reach', 'init'], default='all',
                       help='Which analysis to run (default: all)')
    args = parser.parse_args()

    prog = json.load(sys.stdin)
    for f in prog.get("functions", []):
        name = f.get("name", "<anon>")
        print(f"\nFunction: {name}")
        print("=" * (10 + len(name)))

        instrs = f.get("instrs", [])
        blocks = helpers.split_blocks(instrs)
        succs, preds, label_to_block_id = helpers.build_cfg(blocks)

        # Run analyses based on user choice
        if args.analysis in ['all', 'live']:
            lv_problem = live_vars.make_live_vars_problem(blocks)
            IN_LV, OUT_LV = generic_solver.solve_dataflow(blocks, succs, preds, lv_problem)

            print("\n=== Live Variables ===")
            for i in range(len(blocks)):
                print(f"[B{i}] IN={helpers.fmt_set(IN_LV[i])}  OUT={helpers.fmt_set(OUT_LV[i])}")

        if args.analysis in ['all', 'reach']:
            rd_problem = reach_defs.make_reaching_defs_problem(blocks)
            IN_RD, OUT_RD = generic_solver.solve_dataflow(blocks, succs, preds, rd_problem)

            print("\n=== Reaching Definitions ===")
            for i in range(len(blocks)):
                print(f"[B{i}] IN={helpers.fmt_set(IN_RD[i])}  OUT={helpers.fmt_set(OUT_RD[i])}")

        if args.analysis in ['all', 'init']:
            init_problem = initialized_variables.make_initialized_variables_problem(blocks)
            IN_INIT, OUT_INIT = generic_solver.solve_dataflow(blocks, succs, preds, init_problem)

            print("\n=== Definitely Initialized Variables ===")
            for i in range(len(blocks)):
                print(f"[B{i}] IN={helpers.fmt_set(IN_INIT[i])}  OUT={helpers.fmt_set(OUT_INIT[i])}")

            # Check for definite uninitialized variable uses
            errors = initialized_variables.find_uninitialized_uses(blocks, IN_INIT)
            if errors:
                print("\n❌ Definite Uninitialized Variable Uses:")
                for block_id, instr_id, var in errors:
                    instr = blocks[block_id][instr_id]
                    print(f"  B{block_id}.{instr_id}: Variable '{var}' used in '{helpers.format_instruction(instr)}'")

if __name__ == "__main__":
    main()