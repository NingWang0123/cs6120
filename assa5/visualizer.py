import networkx as nx
import matplotlib.pyplot as plt


def _hierarchy_pos(G, root, width=1.0, vert_gap=0.3, vert_loc=0, xcenter=0.5, pos=None, parent=None):
    """Recursively compute positions for a tree layout (top-down)."""
    if pos is None:
        pos = {}
    pos[root] = (xcenter, vert_loc)
    children = list(G.successors(root))
    if len(children) != 0:
        dx = width / len(children)
        nextx = xcenter - width/2 - dx/2
        for child in children:
            nextx += dx
            pos = _hierarchy_pos(G, child, width=dx, vert_gap=vert_gap,
                                 vert_loc=vert_loc-vert_gap, xcenter=nextx,
                                 pos=pos, parent=root)
    return pos

def _draw_labeled_digraph(G, id2label, title, layout="spring", root=None):
    plt.figure(figsize=(7,6))
    
    if layout == "tree" and root is not None:
        pos = _hierarchy_pos(G, root)
    else:
        pos = nx.spring_layout(G, seed=42, k=0.7)  
    
    labels = {n: id2label.get(n, str(n)) for n in G.nodes}
    node_colors = ["#ff9999" if n == 0 else "#87CEEB" for n in G.nodes]  
    
    nx.draw_networkx_nodes(G, pos, node_size=1400, node_color=node_colors, 
                           edgecolors="black", linewidths=1.2, alpha=0.9)
    nx.draw_networkx_edges(G, pos, arrows=True, arrowstyle="->", 
                           arrowsize=18, connectionstyle="arc3,rad=0.1")
    nx.draw_networkx_labels(G, pos, labels, font_size=12, font_weight="bold")
    
    plt.title(title, fontsize=16, weight="bold")
    plt.axis("off")
    plt.tight_layout()

def plot_cfg(succs, id2label, title="Control-Flow Graph"):
    G = nx.DiGraph()
    for u, vs in enumerate(succs):
        G.add_node(u)
        for v in vs:
            G.add_edge(u, v)
    _draw_labeled_digraph(G, id2label, title, layout="spring")

def plot_dom_tree(children, id2label, title="Dominator Tree"):
    T = nx.DiGraph()
    for p, vs in enumerate(children):
        for c in vs:
            T.add_edge(p, c)
    _draw_labeled_digraph(T, id2label, title, layout="tree", root=0)

def plot_dom_frontier(DF, id2label, title="Dominance Frontier"):
    H = nx.DiGraph()
    for u, vs in enumerate(DF):
        for v in vs:
            H.add_edge(u, v)
    _draw_labeled_digraph(H, id2label, title, layout="spring")
