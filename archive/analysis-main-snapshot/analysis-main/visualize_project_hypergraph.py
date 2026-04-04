#!/usr/bin/env python3.11
"""
Project Hypergraph Visualization
Creates visual representations of the project hypergraph using matplotlib and networkx.
"""

import json
import matplotlib.pyplot as plt
import matplotlib.patches as mpatches
from collections import defaultdict
import logging

# Configure logging
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

# Try to import networkx
try:
    import networkx as nx
    HAS_NETWORKX = True
except ImportError:
    HAS_NETWORKX = False
    logger.warning("networkx not available, will create simplified visualizations")


def load_hypergraph(file_path: str):
    """Load hypergraph from JSON file"""
    with open(file_path, 'r') as f:
        return json.load(f)


def create_layer_distribution_chart(hypergraph, output_file):
    """Create a bar chart showing node distribution across layers"""
    logger.info("Creating layer distribution chart...")
    
    layers = hypergraph['metrics']['layer_sizes']
    
    fig, ax = plt.subplots(figsize=(12, 6))
    
    layer_names = list(layers.keys())
    layer_counts = list(layers.values())
    
    colors = plt.cm.Set3(range(len(layer_names)))
    bars = ax.bar(layer_names, layer_counts, color=colors, edgecolor='black', linewidth=1.5)
    
    ax.set_xlabel('Layers', fontsize=12, fontweight='bold')
    ax.set_ylabel('Number of Nodes', fontsize=12, fontweight='bold')
    ax.set_title('Project Hypergraph: Node Distribution Across Layers', 
                 fontsize=14, fontweight='bold', pad=20)
    ax.grid(axis='y', alpha=0.3, linestyle='--')
    
    # Add value labels on bars
    for bar in bars:
        height = bar.get_height()
        ax.text(bar.get_x() + bar.get_width()/2., height,
                f'{int(height)}',
                ha='center', va='bottom', fontweight='bold')
    
    plt.xticks(rotation=45, ha='right')
    plt.tight_layout()
    plt.savefig(output_file, dpi=300, bbox_inches='tight')
    logger.info(f"Saved layer distribution chart to {output_file}")
    plt.close()


def create_node_type_pie_chart(hypergraph, output_file):
    """Create a pie chart showing node type distribution"""
    logger.info("Creating node type distribution chart...")
    
    node_types = hypergraph['metrics']['node_types']
    
    fig, ax = plt.subplots(figsize=(12, 8))
    
    labels = list(node_types.keys())
    sizes = list(node_types.values())
    
    # Create color palette
    colors = plt.cm.Set3(range(len(labels)))
    
    # Create pie chart
    wedges, texts, autotexts = ax.pie(sizes, labels=labels, autopct='%1.1f%%',
                                       colors=colors, startangle=90,
                                       textprops={'fontsize': 10, 'weight': 'bold'})
    
    # Enhance text
    for autotext in autotexts:
        autotext.set_color('white')
        autotext.set_fontsize(9)
        autotext.set_weight('bold')
    
    ax.set_title('Project Hypergraph: Node Type Distribution', 
                 fontsize=14, fontweight='bold', pad=20)
    
    plt.tight_layout()
    plt.savefig(output_file, dpi=300, bbox_inches='tight')
    logger.info(f"Saved node type pie chart to {output_file}")
    plt.close()


def create_metrics_summary(hypergraph, output_file):
    """Create a visual summary of hypergraph metrics"""
    logger.info("Creating metrics summary...")
    
    metrics = hypergraph['metrics']
    
    fig, ((ax1, ax2), (ax3, ax4)) = plt.subplots(2, 2, figsize=(14, 10))
    fig.suptitle('Project Hypergraph: Comprehensive Metrics', 
                 fontsize=16, fontweight='bold')
    
    # 1. Overall Statistics
    ax1.axis('off')
    stats_text = f"""
    OVERALL STATISTICS
    
    Total Nodes: {metrics['total_nodes']}
    Total Hyperedges: {metrics['total_hyperedges']}
    Total Layers: {metrics['total_layers']}
    
    Density: {metrics['density']:.4f}
    Average Degree: {metrics['average_degree']:.2f}
    """
    ax1.text(0.1, 0.5, stats_text, fontsize=12, family='monospace',
             verticalalignment='center', bbox=dict(boxstyle='round', 
             facecolor='lightblue', alpha=0.5))
    
    # 2. Layer Sizes Bar Chart
    layers = metrics['layer_sizes']
    ax2.barh(list(layers.keys()), list(layers.values()), 
             color=plt.cm.Set3(range(len(layers))))
    ax2.set_xlabel('Number of Nodes', fontweight='bold')
    ax2.set_title('Nodes per Layer', fontweight='bold')
    ax2.grid(axis='x', alpha=0.3)
    
    # 3. Node Types Distribution
    node_types = metrics['node_types']
    top_types = dict(sorted(node_types.items(), key=lambda x: x[1], reverse=True)[:8])
    ax3.bar(range(len(top_types)), list(top_types.values()), 
            color=plt.cm.Pastel1(range(len(top_types))))
    ax3.set_xticks(range(len(top_types)))
    ax3.set_xticklabels(list(top_types.keys()), rotation=45, ha='right')
    ax3.set_ylabel('Count', fontweight='bold')
    ax3.set_title('Top Node Types', fontweight='bold')
    ax3.grid(axis='y', alpha=0.3)
    
    # 4. Edge Types Distribution
    edge_types = metrics.get('edge_types', {})
    if edge_types:
        ax4.bar(range(len(edge_types)), list(edge_types.values()),
                color=plt.cm.Pastel2(range(len(edge_types))))
        ax4.set_xticks(range(len(edge_types)))
        ax4.set_xticklabels(list(edge_types.keys()), rotation=45, ha='right')
        ax4.set_ylabel('Count', fontweight='bold')
        ax4.set_title('Hyperedge Types', fontweight='bold')
        ax4.grid(axis='y', alpha=0.3)
    else:
        ax4.axis('off')
        ax4.text(0.5, 0.5, 'No edge type data available', 
                ha='center', va='center', fontsize=12)
    
    plt.tight_layout()
    plt.savefig(output_file, dpi=300, bbox_inches='tight')
    logger.info(f"Saved metrics summary to {output_file}")
    plt.close()


def create_network_graph(hypergraph, output_file):
    """Create a network graph visualization (if networkx available)"""
    if not HAS_NETWORKX:
        logger.warning("Skipping network graph - networkx not available")
        return
    
    logger.info("Creating network graph visualization...")
    
    # Create graph
    G = nx.Graph()
    
    # Add nodes (sample for visualization)
    node_sample = list(hypergraph['nodes'].items())[:200]  # Limit for clarity
    
    node_colors = {
        'directory': '#FF6B6B',
        'module': '#4ECDC4',
        'python_file': '#45B7D1',
        'class': '#FFA07A',
        'function': '#98D8C8',
        'database_table': '#F7DC6F',
        'dependency': '#BB8FCE',
        'documentation': '#85C1E2',
        'configuration': '#F8B739',
        'test_file': '#52B788'
    }
    
    for node_id, node_data in node_sample:
        G.add_node(node_id, 
                  type=node_data['type'],
                  name=node_data['name'][:20])  # Truncate long names
    
    # Add edges (sample)
    edge_sample = hypergraph['hyperedges'][:300]
    for edge in edge_sample:
        nodes = edge['nodes']
        if len(nodes) == 2 and all(n in G.nodes() for n in nodes):
            G.add_edge(nodes[0], nodes[1])
    
    # Create visualization
    fig, ax = plt.subplots(figsize=(16, 12))
    
    # Layout
    pos = nx.spring_layout(G, k=0.5, iterations=50, seed=42)
    
    # Draw nodes by type
    for node_type, color in node_colors.items():
        nodelist = [n for n, d in G.nodes(data=True) if d.get('type') == node_type]
        nx.draw_networkx_nodes(G, pos, nodelist=nodelist, 
                              node_color=color, node_size=100, 
                              alpha=0.8, ax=ax, label=node_type)
    
    # Draw edges
    nx.draw_networkx_edges(G, pos, alpha=0.2, width=0.5, ax=ax)
    
    ax.set_title('Project Hypergraph: Network Visualization (Sample)', 
                 fontsize=14, fontweight='bold', pad=20)
    ax.axis('off')
    
    # Legend
    ax.legend(loc='upper left', fontsize=9, framealpha=0.9)
    
    plt.tight_layout()
    plt.savefig(output_file, dpi=300, bbox_inches='tight')
    logger.info(f"Saved network graph to {output_file}")
    plt.close()


def main():
    """Main execution function"""
    logger.info("=" * 80)
    logger.info("PROJECT HYPERGRAPH VISUALIZATION")
    logger.info("=" * 80)
    
    # Load hypergraph
    hypergraph_file = '/home/ubuntu/analysis/project_hypergraph.json'
    hypergraph = load_hypergraph(hypergraph_file)
    
    # Create visualizations
    create_layer_distribution_chart(hypergraph, 
        '/home/ubuntu/analysis/hypergraph_layer_distribution.png')
    
    create_node_type_pie_chart(hypergraph,
        '/home/ubuntu/analysis/hypergraph_node_types.png')
    
    create_metrics_summary(hypergraph,
        '/home/ubuntu/analysis/hypergraph_metrics_summary.png')
    
    create_network_graph(hypergraph,
        '/home/ubuntu/analysis/hypergraph_network_visualization.png')
    
    logger.info("\n✅ All visualizations created successfully!")
    logger.info("=" * 80)


if __name__ == "__main__":
    main()

