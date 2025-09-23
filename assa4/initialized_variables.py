from generic_solver import DataFlowProblem

def instr_defs(instr):
    """Get variables defined by an instruction"""
    dest = instr.get('dest')
    return {dest} if dest is not None else set()


def instr_uses(instr):
    """Get variables used by an instruction"""
    return set(instr.get('args', []))


def block_defs(block):
    """Get all variables defined in a block"""
    defs = set()
    for instr in block:
        defs.update(instr_defs(instr))
    return defs


def block_uses_before_def(block):
    """Get variables used before they are defined in this block"""
    defined_so_far = set()
    uses_before_def = set()

    for instr in block:
        # Check uses first
        uses = instr_uses(instr)
        for var in uses:
            if var not in defined_so_far:
                uses_before_def.add(var)

        # Then record definitions
        defs = instr_defs(instr)
        defined_so_far.update(defs)

    return uses_before_def


def make_initialized_variables_problem(blocks):

    DEF = []
    for block in blocks:
        DEF.append(block_defs(block))

    def merge_intersection(values):
        if not values:
            return set()  # No predecessors = empty set

        # Start with first set, then intersect with all others
        result = set(values[0])
        for value_set in values[1:]:
            result.intersection_update(value_set)
        return result

    def transfer(block_id, in_set):
        return in_set.union(DEF[block_id])

    return DataFlowProblem(
        direction="forward",
        init=set(),  # No variables initialized at program start
        merge=merge_intersection,
        transfer=transfer
    )


def find_uninitialized_uses(blocks, IN_sets):
    errors = []

    for block_id, block in enumerate(blocks):
        initialized_in_block = set(IN_sets[block_id])

        for instr_id, instr in enumerate(block):
            # Check if instruction uses any uninitialized variables
            uses = instr_uses(instr)
            for var in uses:
                if var not in initialized_in_block:
                    errors.append((block_id, instr_id, var))

            # Update initialized set as we process instructions
            defs = instr_defs(instr)
            initialized_in_block.update(defs)

    return errors


def analyze_initialization_patterns(blocks, IN_sets, OUT_sets):
    all_vars = set()
    always_init = set()
    never_init = set()

    # Collect all variables mentioned in the program
    for block in blocks:
        for instr in block:
            all_vars.update(instr_defs(instr))
            all_vars.update(instr_uses(instr))

    for var in all_vars:
        init_in_all_outs = all(var in out_set for out_set in OUT_sets)
        init_in_no_outs = all(var not in out_set for out_set in OUT_sets)

        if init_in_all_outs:
            always_init.add(var)
        elif init_in_no_outs:
            never_init.add(var)

    return {
        'total_variables': len(all_vars),
        'always_initialized': always_init,
        'never_initialized': never_init,
        'conditionally_initialized': all_vars - always_init - never_init
    }


# For integration with main.py, provide a simple interface
def check_initialization_errors(blocks, verbose=False):
    from generic_solver import solve_dataflow

    problem = make_initialized_variables_problem(blocks)
    raise NotImplementedError("Use make_initialized_variables_problem with existing solver")