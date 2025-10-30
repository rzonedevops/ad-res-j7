#!/usr/bin/env python3
"""
Multi-Repository Hypergraph Visualizer
======================================

Creates visualizations for the multi-repository hypergraph, showing:
- Repository distribution and statistics
- Cross-repository relationships
- Shared concepts and frameworks
- Unified metrics dashboard
"""

import json
import logging
import sys
from pathlib import Path
from typing import Any, Dict, List

import matplotlib.pyplot as plt
import matplotlib.patches as mpatches
import numpy as np

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)


class MultiRepoHypergraphVisualizer:
    """Visualizes multi-repository hypergraph data"""

    def __init__(self, hypergraph_file: str):
        self.hypergraph_file = Path(hypergraph_file)
        self.hypergraph = None
        self.output_dir = self.hypergraph_file.parent

    def load(self) -> bool:
        """Load hypergraph data from JSON file"""
        try:
            with open(self.hypergraph_file, "r") as f:
                self.hypergraph = json.load(f)
            logger.info(f"✅ Loaded multi-repo hypergraph from {self.hypergraph_file}")
            return True
        except Exception as e:
            logger.error(f"❌ Failed to load hypergraph: {e}")
            return False

    def visualize(self):
        """Create all visualizations"""
        if not self.hypergraph:
            logger.error("No hypergraph loaded")
            return

        logger.info("🎨 Creating visualizations...")

        # 1. Repository statistics comparison
        self._visualize_repo_comparison()

        # 2. Cross-repository relationships
        self._visualize_cross_repo_relationships()

        # 3. Unified metrics dashboard
        self._visualize_unified_metrics()

        # 4. Shared concepts network
        if self.hypergraph.get("cross_repo_nodes"):
            self._visualize_shared_concepts()

        logger.info("✅ All visualizations created")

    def _visualize_repo_comparison(self):
        """Create bar chart comparing repositories"""
        repos = self.hypergraph.get("repositories", {})
        if not repos:
            return

        repo_names = list(repos.keys())
        node_counts = [repos[r]["statistics"]["node_count"] for r in repo_names]
        edge_counts = [repos[r]["statistics"]["edge_count"] for r in repo_names]

        # Shorten repo names for display
        display_names = [name.split("/")[-1] for name in repo_names]

        fig, (ax1, ax2) = plt.subplots(1, 2, figsize=(14, 6))

        # Nodes comparison
        colors = plt.cm.Set3(np.linspace(0, 1, len(repo_names)))
        ax1.bar(display_names, node_counts, color=colors)
        ax1.set_xlabel("Repository", fontsize=12, fontweight="bold")
        ax1.set_ylabel("Node Count", fontsize=12, fontweight="bold")
        ax1.set_title("Repository Node Counts", fontsize=14, fontweight="bold")
        ax1.tick_params(axis="x", rotation=45)
        ax1.grid(axis="y", alpha=0.3)

        # Edges comparison
        ax2.bar(display_names, edge_counts, color=colors)
        ax2.set_xlabel("Repository", fontsize=12, fontweight="bold")
        ax2.set_ylabel("Edge Count", fontsize=12, fontweight="bold")
        ax2.set_title("Repository Edge Counts", fontsize=14, fontweight="bold")
        ax2.tick_params(axis="x", rotation=45)
        ax2.grid(axis="y", alpha=0.3)

        plt.tight_layout()
        output_file = self.output_dir / "multi_repo_comparison.png"
        plt.savefig(output_file, dpi=300, bbox_inches="tight")
        plt.close()

        logger.info(f"   📊 Repository comparison saved to {output_file}")

    def _visualize_cross_repo_relationships(self):
        """Visualize cross-repository relationships as a network"""
        metrics = self.hypergraph.get("unified_metrics", {})

        fig, ax = plt.subplots(figsize=(10, 8))

        # Create simple statistics display
        stats_text = f"""
Multi-Repository Hypergraph Statistics

Total Repositories: {metrics.get('total_repositories', 0)}
Total Nodes: {metrics.get('total_nodes', 0)}
Total Edges: {metrics.get('total_edges', 0)}

Cross-Repository Metrics:
• Cross-Repo Nodes: {metrics.get('cross_repo_nodes', 0)}
• Cross-Repo Edges: {metrics.get('cross_repo_edges', 0)}

Repositories Analyzed:
"""

        for i, repo in enumerate(metrics.get("repositories_analyzed", [])):
            stats_text += f"  {i+1}. {repo}\n"

        ax.text(
            0.1,
            0.5,
            stats_text,
            fontsize=11,
            family="monospace",
            verticalalignment="center",
            bbox=dict(boxstyle="round", facecolor="wheat", alpha=0.5),
        )
        ax.axis("off")

        plt.tight_layout()
        output_file = self.output_dir / "multi_repo_relationships.png"
        plt.savefig(output_file, dpi=300, bbox_inches="tight")
        plt.close()

        logger.info(f"   🔗 Cross-repo relationships saved to {output_file}")

    def _visualize_unified_metrics(self):
        """Create unified metrics dashboard"""
        metrics = self.hypergraph.get("unified_metrics", {})

        fig = plt.figure(figsize=(14, 10))

        # Create grid for subplots
        gs = fig.add_gridspec(3, 2, hspace=0.3, wspace=0.3)

        # 1. Overall statistics
        ax1 = fig.add_subplot(gs[0, :])
        stats_data = {
            "Repositories": metrics.get("total_repositories", 0),
            "Total Nodes": metrics.get("total_nodes", 0),
            "Total Edges": metrics.get("total_edges", 0),
            "Cross-Repo\nNodes": metrics.get("cross_repo_nodes", 0),
            "Cross-Repo\nEdges": metrics.get("cross_repo_edges", 0),
        }
        colors = ["#FF6B6B", "#4ECDC4", "#45B7D1", "#FFA07A", "#98D8C8"]
        ax1.bar(stats_data.keys(), stats_data.values(), color=colors)
        ax1.set_title("Overall Statistics", fontsize=14, fontweight="bold")
        ax1.set_ylabel("Count", fontsize=12, fontweight="bold")
        ax1.grid(axis="y", alpha=0.3)

        # 2. Node types distribution
        ax2 = fig.add_subplot(gs[1, 0])
        node_types = metrics.get("node_types", {})
        if node_types:
            # Top 10 node types
            sorted_types = sorted(node_types.items(), key=lambda x: x[1], reverse=True)[
                :10
            ]
            types, counts = zip(*sorted_types) if sorted_types else ([], [])

            ax2.barh(
                range(len(types)),
                counts,
                color=plt.cm.Pastel1(np.linspace(0, 1, len(types))),
            )
            ax2.set_yticks(range(len(types)))
            ax2.set_yticklabels(types, fontsize=9)
            ax2.set_xlabel("Count", fontsize=11, fontweight="bold")
            ax2.set_title("Top 10 Node Types", fontsize=12, fontweight="bold")
            ax2.grid(axis="x", alpha=0.3)

        # 3. Edge types distribution
        ax3 = fig.add_subplot(gs[1, 1])
        edge_types = metrics.get("edge_types", {})
        if edge_types:
            types, counts = zip(*edge_types.items()) if edge_types else ([], [])
            colors = plt.cm.Set2(np.linspace(0, 1, len(types)))
            ax3.pie(
                counts, labels=types, autopct="%1.1f%%", colors=colors, startangle=90
            )
            ax3.set_title("Edge Type Distribution", fontsize=12, fontweight="bold")

        # 4. Repository breakdown
        ax4 = fig.add_subplot(gs[2, :])
        repos = self.hypergraph.get("repositories", {})
        if repos:
            repo_names = [name.split("/")[-1] for name in repos.keys()]
            repo_nodes = [repos[r]["statistics"]["node_count"] for r in repos.keys()]
            repo_edges = [repos[r]["statistics"]["edge_count"] for r in repos.keys()]

            x = np.arange(len(repo_names))
            width = 0.35

            ax4.bar(x - width / 2, repo_nodes, width, label="Nodes", color="#4ECDC4")
            ax4.bar(x + width / 2, repo_edges, width, label="Edges", color="#45B7D1")

            ax4.set_xlabel("Repository", fontsize=12, fontweight="bold")
            ax4.set_ylabel("Count", fontsize=12, fontweight="bold")
            ax4.set_title("Repository Breakdown", fontsize=14, fontweight="bold")
            ax4.set_xticks(x)
            ax4.set_xticklabels(repo_names, rotation=45, ha="right")
            ax4.legend()
            ax4.grid(axis="y", alpha=0.3)

        plt.suptitle(
            "Multi-Repository Hypergraph Metrics Dashboard",
            fontsize=16,
            fontweight="bold",
            y=0.995,
        )

        output_file = self.output_dir / "multi_repo_metrics_dashboard.png"
        plt.savefig(output_file, dpi=300, bbox_inches="tight")
        plt.close()

        logger.info(f"   📊 Metrics dashboard saved to {output_file}")

    def _visualize_shared_concepts(self):
        """Visualize shared concepts across repositories"""
        cross_nodes = self.hypergraph.get("cross_repo_nodes", {})
        if not cross_nodes:
            return

        # Sort by instance count
        sorted_concepts = sorted(
            cross_nodes.values(), key=lambda x: x["instance_count"], reverse=True
        )[
            :15
        ]  # Top 15

        if not sorted_concepts:
            return

        fig, ax = plt.subplots(figsize=(12, 8))

        concept_names = [c["name"] for c in sorted_concepts]
        instance_counts = [c["instance_count"] for c in sorted_concepts]

        colors = plt.cm.viridis(np.linspace(0, 1, len(concept_names)))
        bars = ax.barh(range(len(concept_names)), instance_counts, color=colors)

        ax.set_yticks(range(len(concept_names)))
        ax.set_yticklabels(concept_names, fontsize=10)
        ax.set_xlabel("Number of Repositories", fontsize=12, fontweight="bold")
        ax.set_title(
            "Top Shared Concepts Across Repositories", fontsize=14, fontweight="bold"
        )
        ax.grid(axis="x", alpha=0.3)

        # Add value labels on bars
        for i, (bar, count) in enumerate(zip(bars, instance_counts)):
            width = bar.get_width()
            ax.text(
                width + 0.1,
                bar.get_y() + bar.get_height() / 2,
                f"{count}",
                ha="left",
                va="center",
                fontsize=9,
            )

        plt.tight_layout()
        output_file = self.output_dir / "multi_repo_shared_concepts.png"
        plt.savefig(output_file, dpi=300, bbox_inches="tight")
        plt.close()

        logger.info(f"   🔗 Shared concepts visualization saved to {output_file}")


def main():
    """Main execution function"""
    import argparse

    parser = argparse.ArgumentParser(
        description="Visualize multi-repository hypergraph"
    )
    parser.add_argument(
        "hypergraph_file",
        type=str,
        help="Path to multi-repository hypergraph JSON file",
    )

    args = parser.parse_args()

    visualizer = MultiRepoHypergraphVisualizer(args.hypergraph_file)

    if not visualizer.load():
        return 1

    visualizer.visualize()

    logger.info("\n✅ Visualization complete!")
    return 0


if __name__ == "__main__":
    sys.exit(main())
