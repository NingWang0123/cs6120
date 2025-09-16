"""
Combined TDCE + LVN optimization pass.
Iteratively applies trivial dead code elimination and local value numbering
until convergence, as different optimizations can enable each other.
"""

import sys
import json
from copy import deepcopy

from tdce import tdce_func, remove_locally_killed, remove_global_unused
from lvn import lvn_func


def combined_optimize_func(func):
    """
    Apply TDCE and LVN iteratively until convergence.
    Returns True if any changes were made.
    """
    changed = False
    iteration = 0
    max_iterations = 10  # Safety limit to prevent infinite loops
    
    while iteration < max_iterations:
        iteration_changed = False
        
        # Apply LVN first to potentially create copy instructions and constants
        original_instrs = len(func["instrs"])
        lvn_func({"functions": [func]})
        if len(func["instrs"]) != original_instrs:
            iteration_changed = True
        
        # Apply TDCE to remove any dead code created by LVN
        if tdce_func(func):
            iteration_changed = True
        
        if not iteration_changed:
            break
            
        changed = True
        iteration += 1
    
    return changed


def combined_optimize_program(prog):
    """
    Apply combined optimization to all functions in the program.
    """
    out = deepcopy(prog)
    for func in out.get("functions", []):
        combined_optimize_func(func)
    return out


def main():
    """Main entry point for the combined optimization."""
    prog = json.load(sys.stdin)
    optimized = combined_optimize_program(prog)
    json.dump(optimized, sys.stdout, indent=2, sort_keys=True)


if __name__ == "__main__":
    main()