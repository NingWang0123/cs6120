
class DataFlowProblem:
    def __init__(self,
                 direction,
                 init,
                 merge,
                 transfer):
        
        assert direction in ("forward", "backward")
        self.direction = direction
        self.init = init
        self.merge = merge
        self.transfer = transfer

def solve_dataflow(blocks,
                   succs,
                   preds,
                   problem):
    n = len(blocks)
    IN  = [problem.init for _ in range(n)]
    OUT = [problem.init for _ in range(n)]

    # seed worklist with all blocks
    worklist = list(range(n))
    in_wl = [True]*n

    while worklist:
        b = worklist.pop()
        in_wl[b] = False

        if problem.direction == "forward":
            # IN[b] = merge over preds
            in_new = problem.merge([OUT[p] for p in preds[b]]) if preds[b] else problem.init
            if in_new != IN[b]:
                IN[b] = in_new
            # OUT[b] = transfer(IN[b])
            out_new = problem.transfer(b, IN[b])
            if out_new != OUT[b]:
                OUT[b] = out_new
                # successors depend on OUT[b]
                for s in succs[b]:
                    if not in_wl[s]:
                        worklist.append(s); in_wl[s] = True

        # backward
        else:  
            # OUT[b] = merge over succs
            out_new = problem.merge([IN[s] for s in succs[b]]) if succs[b] else problem.init
            if out_new != OUT[b]:
                OUT[b] = out_new
            # IN[b] = transfer(OUT[b])
            in_new = problem.transfer(b, OUT[b])
            if in_new != IN[b]:
                IN[b] = in_new
                # predecessors depend on IN[b]
                for p in preds[b]:
                    if not in_wl[p]:
                        worklist.append(p); in_wl[p] = True

    return IN, OUT