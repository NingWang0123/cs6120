import networkx as nx
import matplotlib.pyplot as plt
import os


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

def _draw_labeled_digraph(G, id2label, title, layout="spring", root=None, save_path=None):
    plt.figure(figsize=(12, 10))

    # Handle empty graphs
    if not G.nodes:
        plt.text(0.5, 0.5, "Empty Graph", ha='center', va='center',
                transform=plt.gca().transAxes, fontsize=16)
        plt.title(title, fontsize=18, weight="bold", pad=20)
        plt.axis("off")
        if save_path:
            plt.savefig(save_path, dpi=300, bbox_inches='tight')
            print(f"Saved visualization to {save_path}")
        return plt.gcf()

    # Compute positions based on layout with better spacing
    if layout == "tree" and root is not None and root in G.nodes:
        pos = _hierarchy_pos(G, root, width=3.0, vert_gap=1.0)
    elif layout == "circular":
        pos = nx.circular_layout(G, scale=2.0)
    else:
        pos = nx.spring_layout(G, seed=42, k=3.0, iterations=100)

    # Ensure all nodes have positions
    for node in G.nodes:
        if node not in pos:
            pos[node] = (0, 0)  # Default position for missing nodes

    labels = {n: id2label.get(n, str(n)) for n in G.nodes}

    # Enhanced color scheme
    node_colors = []
    for n in G.nodes:
        if n == 0:
            node_colors.append("#ff6b6b")  # Entry node - red
        elif "unreachable" in labels[n]:
            node_colors.append("#adb5bd")  # Unreachable - gray
        else:
            node_colors.append("#4dabf7")  # Regular nodes - blue

    # Draw nodes with proper sizing to prevent overlap
    node_size = max(3000, 800 * len(str(max(labels.values(), key=len))))
    nx.draw_networkx_nodes(G, pos, node_size=node_size, node_color=node_colors,
                           edgecolors="#2d3436", linewidths=2.5, alpha=0.9)

    # Draw edges with proper sizing
    if layout == "tree":
        edge_color = "#6c5ce7"
        edge_style = "-"
        arrow_size = 25
        connection_style = "arc3,rad=0"
    else:
        edge_color = "#2d3436"
        edge_style = "-"
        arrow_size = 25
        connection_style = "arc3,rad=0.15"

    if G.edges:
        # Calculate node radius based on node size for proper arrow positioning
        node_radius = (node_size / 100) ** 0.5 * 6  # Approximate radius
        nx.draw_networkx_edges(G, pos, arrows=True, arrowstyle="->",
                               arrowsize=arrow_size, edge_color=edge_color,
                               connectionstyle=connection_style, width=2.5,
                               style=edge_style, alpha=0.8,
                               min_source_margin=node_radius, min_target_margin=node_radius)

    # Enhanced labels with better font sizing
    font_size = max(10, min(14, 120 // len(str(max(labels.values(), key=len)))))
    nx.draw_networkx_labels(G, pos, labels, font_size=font_size, font_weight="bold",
                           font_color="white", font_family="sans-serif")

    plt.title(title, fontsize=20, weight="bold", pad=30)
    plt.axis("off")

    # Add more padding around the plot
    ax = plt.gca()
    ax.margins(0.2)

    plt.tight_layout(pad=2.0)

    if save_path:
        plt.savefig(save_path, dpi=300, bbox_inches='tight',
                   facecolor='white', edgecolor='none', pad_inches=0.3)
        print(f"Saved visualization to {save_path}")

    return plt.gcf()

def plot_cfg(succs, id2label, title="Control-Flow Graph", save_path=None):
    G = nx.DiGraph()
    for u, vs in enumerate(succs):
        G.add_node(u)
        for v in vs:
            G.add_edge(u, v)
    return _draw_labeled_digraph(G, id2label, title, layout="spring", save_path=save_path)

def plot_dom_tree(children, id2label, title="Dominator Tree", save_path=None):
    T = nx.DiGraph()
    for p, vs in enumerate(children):
        T.add_node(p)  # Ensure all nodes exist
        for c in vs:
            T.add_edge(p, c)
    return _draw_labeled_digraph(T, id2label, title, layout="tree", root=0, save_path=save_path)

def plot_dom_frontier(DF, id2label, title="Dominance Frontier", save_path=None):
    H = nx.DiGraph()
    # Add all nodes first
    for u in range(len(DF)):
        H.add_node(u)
    # Then add edges for dominance frontier relationships
    for u, vs in enumerate(DF):
        for v in vs:
            H.add_edge(u, v)
    return _draw_labeled_digraph(H, id2label, title, layout="circular", save_path=save_path)

def plot_combined_analysis(succs, dom_tree, DF, id2label, save_dir=None):
    """Create a comprehensive visualization showing all dominance relationships."""
    fig, axes = plt.subplots(2, 2, figsize=(20, 16))

    labels = {n: id2label.get(n, str(n)) for n in range(len(succs))}
    node_colors = ["#ff6b6b" if n == 0 else "#4dabf7" for n in range(len(succs))]

    # CFG
    plt.sca(axes[0, 0])
    G = nx.DiGraph()
    for u, vs in enumerate(succs):
        G.add_node(u)
        for v in vs:
            G.add_edge(u, v)
    if G.nodes:
        pos = nx.spring_layout(G, seed=42, k=2.0, iterations=50)
        nx.draw_networkx_nodes(G, pos, node_color=node_colors, node_size=2000,
                              edgecolors='black', linewidths=2)
        if G.edges:
            nx.draw_networkx_edges(G, pos, arrows=True, arrowstyle="->",
                                  arrowsize=20, edge_color='black',
                                  connectionstyle="arc3,rad=0.1", width=2,
                                  min_source_margin=20, min_target_margin=20)
        nx.draw_networkx_labels(G, pos, labels, font_size=11, font_weight='bold',
                               font_color='white')
    axes[0, 0].set_title("Control Flow Graph", fontsize=16, weight="bold", pad=20)
    axes[0, 0].axis('off')

    # Dominator Tree
    plt.sca(axes[0, 1])
    T = nx.DiGraph()
    for p, vs in enumerate(dom_tree):
        T.add_node(p)
        for c in vs:
            T.add_edge(p, c)
    if T.nodes:
        if 0 in T.nodes:
            pos_tree = _hierarchy_pos(T, 0, width=2.0, vert_gap=0.8)
        else:
            pos_tree = nx.spring_layout(T, k=2.0)
        nx.draw_networkx_nodes(T, pos_tree, node_color=node_colors, node_size=2000,
                              edgecolors='black', linewidths=2)
        if T.edges:
            nx.draw_networkx_edges(T, pos_tree, arrows=True, arrowstyle="->",
                                  arrowsize=20, edge_color='#6c5ce7',
                                  width=2, min_source_margin=20, min_target_margin=20)
        nx.draw_networkx_labels(T, pos_tree, labels, font_size=11, font_weight='bold',
                               font_color='white')
    axes[0, 1].set_title("Dominator Tree", fontsize=16, weight="bold", pad=20)
    axes[0, 1].axis('off')

    # Dominance Frontier
    plt.sca(axes[1, 0])
    H = nx.DiGraph()
    for u in range(len(DF)):
        H.add_node(u)
    for u, vs in enumerate(DF):
        for v in vs:
            H.add_edge(u, v)
    if H.nodes:
        if H.edges:
            pos_df = nx.circular_layout(H, scale=1.5)
        else:
            pos_df = nx.spring_layout(H, k=2.0)
        nx.draw_networkx_nodes(H, pos_df, node_color=node_colors, node_size=2000,
                              edgecolors='black', linewidths=2)
        if H.edges:
            nx.draw_networkx_edges(H, pos_df, arrows=True, arrowstyle="->",
                                  arrowsize=20, edge_color='#e74c3c',
                                  connectionstyle="arc3,rad=0.2", width=2,
                                  min_source_margin=20, min_target_margin=20)
        nx.draw_networkx_labels(H, pos_df, labels, font_size=11, font_weight='bold',
                               font_color='white')
    axes[1, 0].set_title("Dominance Frontier", fontsize=16, weight="bold", pad=20)
    axes[1, 0].axis('off')

    # Summary statistics
    plt.sca(axes[1, 1])
    axes[1, 1].axis('off')
    stats_text = f"""Dominance Analysis Summary

Total Blocks: {len(succs)}
Entry Block: {id2label.get(0, 'b0')}
CFG Edges: {sum(len(vs) for vs in succs)}
Tree Edges: {sum(len(vs) for vs in dom_tree)}
DF Edges: {sum(len(vs) for vs in DF)}

Reachable Blocks: {len([i for i in range(len(succs)) if len(succs[i]) > 0 or any(i in vs for vs in succs)])}
    """
    axes[1, 1].text(0.1, 0.5, stats_text, fontsize=14,
                    verticalalignment='center', fontfamily='monospace',
                    bbox=dict(boxstyle="round,pad=0.5", facecolor="#f8f9fa",
                             edgecolor="#dee2e6", linewidth=2))

    plt.tight_layout(pad=3.0)

    if save_dir:
        save_path = os.path.join(save_dir, "combined_analysis.png")
        plt.savefig(save_path, dpi=300, bbox_inches='tight', pad_inches=0.5)
        print(f"Saved combined analysis to {save_path}")

    return fig
