#!/usr/bin/env python3
"""
Multi-Repository Hypergraph Demo
=================================

Demonstrates the multi-repository hypergraph integration capabilities.
Shows how to analyze multiple related repositories and extract insights.
"""

import json
import sys
from pathlib import Path

# Add parent directory to path for imports
sys.path.insert(0, str(Path(__file__).parent.parent))

from construct_multi_repo_hypergraph import (
    MultiRepoHypergraphConstructor,
    RepositoryConfig,
    DEFAULT_REPOSITORIES,
)


def demo_basic_analysis():
    """Demonstrate basic multi-repo analysis"""
    print("=" * 80)
    print("DEMO 1: Basic Multi-Repository Analysis")
    print("=" * 80)
    
    # Create constructor with subset of repositories
    repositories = [
        RepositoryConfig("rzonedevops", "analysis", "Python", "Evidence automation"),
    ]
    
    print(f"\n📦 Analyzing {len(repositories)} repository(ies)...")
    
    constructor = MultiRepoHypergraphConstructor(repositories)
    
    # Build hypergraph (skip clone to use local repo)
    hypergraph = constructor.construct(skip_clone=True)
    
    # Display summary
    constructor.print_summary()
    
    return hypergraph


def demo_cross_repo_insights(hypergraph):
    """Demonstrate extracting cross-repository insights"""
    print("\n" + "=" * 80)
    print("DEMO 2: Cross-Repository Insights")
    print("=" * 80)
    
    # Extract shared concepts
    cross_nodes = hypergraph.get('cross_repo_nodes', {})
    
    if cross_nodes:
        print(f"\n🔗 Shared Concepts Found: {len(cross_nodes)}")
        for node in list(cross_nodes.values())[:5]:
            print(f"\n   • {node['name']} ({node['type']})")
            print(f"     - Found in {node['instance_count']} location(s)")
            print(f"     - Repositories: {', '.join(node['repositories'][:3])}")
    else:
        print("\n⚠️  No cross-repository nodes found (single repo analysis)")
    
    # Show repository statistics
    print(f"\n📊 Repository Statistics:")
    for repo_name, repo_data in hypergraph.get('repositories', {}).items():
        stats = repo_data['statistics']
        print(f"\n   {repo_name}:")
        print(f"     - Language: {repo_data['metadata']['language']}")
        print(f"     - Nodes: {stats['node_count']}")
        print(f"     - Edges: {stats['edge_count']}")
        print(f"     - Node Types: {len(stats['node_types'])}")


def demo_unified_metrics(hypergraph):
    """Demonstrate unified metrics across repositories"""
    print("\n" + "=" * 80)
    print("DEMO 3: Unified Metrics")
    print("=" * 80)
    
    metrics = hypergraph.get('unified_metrics', {})
    
    print(f"\n📈 Ecosystem-Wide Metrics:")
    print(f"   Total Repositories: {metrics.get('total_repositories', 0)}")
    print(f"   Total Nodes: {metrics.get('total_nodes', 0)}")
    print(f"   Total Edges: {metrics.get('total_edges', 0)}")
    print(f"   Cross-Repo Nodes: {metrics.get('cross_repo_nodes', 0)}")
    print(f"   Cross-Repo Edges: {metrics.get('cross_repo_edges', 0)}")
    
    # Node type distribution
    node_types = metrics.get('node_types', {})
    if node_types:
        print(f"\n🏷️  Top Node Types:")
        sorted_types = sorted(node_types.items(), key=lambda x: x[1], reverse=True)[:5]
        for node_type, count in sorted_types:
            print(f"   • {node_type}: {count}")


def demo_repository_comparison(hypergraph):
    """Demonstrate repository comparison capabilities"""
    print("\n" + "=" * 80)
    print("DEMO 4: Repository Comparison")
    print("=" * 80)
    
    repositories = hypergraph.get('repositories', {})
    
    if len(repositories) > 1:
        print(f"\n📊 Comparing {len(repositories)} Repositories:")
        
        # Create comparison table
        print(f"\n{'Repository':<30} {'Nodes':<10} {'Edges':<10} {'Language':<15}")
        print("-" * 70)
        
        for repo_name, repo_data in repositories.items():
            stats = repo_data['statistics']
            language = repo_data['metadata']['language']
            print(f"{repo_name:<30} {stats['node_count']:<10} {stats['edge_count']:<10} {language:<15}")
    else:
        print("\n⚠️  Only one repository available for comparison")


def demo_programmatic_usage():
    """Demonstrate programmatic usage of the API"""
    print("\n" + "=" * 80)
    print("DEMO 5: Programmatic Usage Examples")
    print("=" * 80)
    
    print("\n🔧 Example 1: Custom Repository Configuration")
    print("```python")
    print("from construct_multi_repo_hypergraph import RepositoryConfig")
    print("")
    print("custom_repos = [")
    print("    RepositoryConfig('owner1', 'repo1', 'Python', 'Description'),")
    print("    RepositoryConfig('owner2', 'repo2', 'JavaScript', 'Description'),")
    print("]")
    print("```")
    
    print("\n🔧 Example 2: Filtering Repository Nodes")
    print("```python")
    print("# Load hypergraph")
    print("with open('multi_repo_hypergraph.json') as f:")
    print("    data = json.load(f)")
    print("")
    print("# Find all framework nodes")
    print("for repo_name, repo_data in data['repositories'].items():")
    print("    for node in repo_data['nodes'].values():")
    print("        if node['type'] == 'framework':")
    print("            print(f'{repo_name}: {node['name']}')")
    print("```")
    
    print("\n🔧 Example 3: Analyzing Shared Dependencies")
    print("```python")
    print("# Find shared frameworks")
    print("for node in data['cross_repo_nodes'].values():")
    print("    if node['type'] == 'cross_repo_framework':")
    print("        repos = ', '.join(node['repositories'])")
    print("        print(f'{node['name']}: used in {repos}')")
    print("```")


def main():
    """Run all demos"""
    print("🚀" * 30)
    print("   MULTI-REPOSITORY HYPERGRAPH DEMONSTRATION")
    print("🚀" * 30)
    print(f"Purpose: Demonstrate cross-repository analysis capabilities")
    print(f"Repositories: Analysis ecosystem")
    
    try:
        # Demo 1: Basic analysis
        hypergraph = demo_basic_analysis()
        
        # Demo 2: Cross-repo insights
        demo_cross_repo_insights(hypergraph)
        
        # Demo 3: Unified metrics
        demo_unified_metrics(hypergraph)
        
        # Demo 4: Repository comparison
        demo_repository_comparison(hypergraph)
        
        # Demo 5: Programmatic usage
        demo_programmatic_usage()
        
        print("\n" + "=" * 80)
        print("✅ All demos completed successfully!")
        print("=" * 80)
        
        print("\n📋 Next Steps:")
        print("   • Analyze all repositories: python3 construct_multi_repo_hypergraph.py")
        print("   • Generate visualizations: python3 visualize_multi_repo_hypergraph.py <file>")
        print("   • Read documentation: MULTI_REPO_HYPERGRAPH_INTEGRATION.md")
        
        return 0
        
    except Exception as e:
        print(f"\n❌ Demo failed: {e}")
        import traceback
        traceback.print_exc()
        return 1


if __name__ == "__main__":
    sys.exit(main())
