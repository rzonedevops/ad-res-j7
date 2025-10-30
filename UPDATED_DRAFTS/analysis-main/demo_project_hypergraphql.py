#!/usr/bin/env python3
"""
Project HyperGraphQL Demo
=========================

Demonstrates the new HyperGraphQL integration with the project hypergraph.
Shows querying capabilities for the actual project structure:
- 985 nodes across 12 types
- 532 hyperedges across 3 types  
- 8-layer architecture
"""

import json
import logging
import sys
from pathlib import Path

# Add src to path for imports
sys.path.insert(0, str(Path(__file__).parent / "src"))

from src.api.hypergraphql_project import get_project_loader, ProjectNodeType, ProjectEdgeType
from src.api.hypergraphql_project_resolvers import (
    resolve_project_nodes, resolve_project_layers, resolve_project_metrics,
    resolve_project_neighbors, resolve_project_shortest_path
)

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)


def demo_basic_queries():
    """Demonstrate basic hypergraph queries"""
    print("=" * 60)
    print("DEMO 1: Basic Project Hypergraph Queries")
    print("=" * 60)
    
    try:
        # Load the project hypergraph
        loader = get_project_loader()
        loader.load()
        
        print(f"\n✅ Loaded project hypergraph:")
        print(f"   📊 Nodes: {len(loader.nodes)}")
        print(f"   🔗 Hyperedges: {len(loader.edges)}")
        print(f"   📚 Layers: {len(loader.layers)}")
        
        # Get metrics
        metrics = loader.get_hypergraph_metrics()
        print(f"\n📈 Hypergraph Metrics:")
        print(f"   🔢 Total nodes: {metrics['total_nodes']}")
        print(f"   🔗 Total hyperedges: {metrics['total_hyperedges']}")
        print(f"   📊 Density: {metrics['density']:.4f}")
        print(f"   🎯 Average degree: {metrics['average_degree']:.2f}")
        
        # Show node type distribution
        print(f"\n🏷️ Node Types:")
        for node_type, count in metrics['node_types'].items():
            print(f"   • {node_type}: {count}")
            
        # Show layer distribution  
        print(f"\n📚 Layer Sizes:")
        for layer, size in metrics['layer_sizes'].items():
            print(f"   • {layer}: {size} nodes")
            
    except Exception as e:
        print(f"❌ Error in basic queries: {e}")
        return False
    
    return True


def demo_node_queries():
    """Demonstrate node-specific queries"""
    print("\n" + "=" * 60)
    print("DEMO 2: Node Queries and Filtering")
    print("=" * 60)
    
    try:
        loader = get_project_loader()
        
        # Get Python files
        python_files = loader.get_nodes(node_type="python_file")
        print(f"\n🐍 Python Files: {len(python_files)} found")
        for i, node in enumerate(python_files[:5]):  # Show first 5
            print(f"   {i+1}. {node.name} (ID: {node.id})")
        if len(python_files) > 5:
            print(f"   ... and {len(python_files) - 5} more")
        
        # Get functions
        functions = loader.get_nodes(node_type="function")
        print(f"\n🔧 Functions: {len(functions)} found")
        for i, node in enumerate(functions[:3]):  # Show first 3
            print(f"   {i+1}. {node.name} (ID: {node.id})")
            if node.properties:
                print(f"      Properties: {dict(list(node.properties.items())[:2])}")
        
        # Search by name
        hypergraph_nodes = loader.get_nodes_by_name("hypergraph")
        print(f"\n🔍 Nodes with 'hypergraph' in name: {len(hypergraph_nodes)}")
        for node in hypergraph_nodes[:3]:
            print(f"   • {node.name} ({node.type})")
        
        # Get nodes by layer
        api_nodes = loader.get_nodes(layer="api")
        print(f"\n🌐 API Layer Nodes: {len(api_nodes)}")
        for node in api_nodes[:3]:
            print(f"   • {node.name} ({node.type})")
            
    except Exception as e:
        print(f"❌ Error in node queries: {e}")
        return False
    
    return True


def demo_graph_traversal():
    """Demonstrate graph traversal operations"""
    print("\n" + "=" * 60)
    print("DEMO 3: Graph Traversal and Analysis")
    print("=" * 60)
    
    try:
        loader = get_project_loader()
        
        # Find a well-connected node (likely a module or directory)
        test_node = None
        for node in loader.nodes.values():
            if node.type == "module" and "api" in node.name.lower():
                test_node = node
                break
        
        if not test_node:
            # Fallback to any module
            modules = loader.get_nodes(node_type="module")
            if modules:
                test_node = modules[0]
        
        if test_node:
            print(f"\n🎯 Analyzing node: {test_node.name} (ID: {test_node.id})")
            
            # Get neighbors
            neighbors = loader.get_neighbors(test_node.id, depth=1)
            print(f"\n👥 Direct neighbors: {len(neighbors)}")
            for neighbor in neighbors[:5]:
                print(f"   • {neighbor.name} ({neighbor.type})")
            
            # Get 2-hop neighbors
            extended_neighbors = loader.get_neighbors(test_node.id, depth=2)
            print(f"\n🌐 2-hop neighbors: {len(extended_neighbors)}")
            
            # Node metrics
            metrics = loader.get_node_metrics(test_node.id)
            print(f"\n📊 Node Metrics:")
            print(f"   🔗 Degree: {metrics.get('degree', 0)}")
            print(f"   🏷️ Type: {metrics.get('type', 'unknown')}")
            print(f"   📚 Layer: {metrics.get('layer', 'unknown')}")
            
            # Try to find a path to another node
            if len(neighbors) > 0:
                target_node = neighbors[0]
                path = loader.get_shortest_path(test_node.id, target_node.id)
                print(f"\n🛤️ Shortest path to {target_node.name}:")
                for i, path_node in enumerate(path):
                    print(f"   {i+1}. {path_node.name} ({path_node.type})")
        
        else:
            print("⚠️ No suitable test node found")
            
    except Exception as e:
        print(f"❌ Error in graph traversal: {e}")
        return False
    
    return True


def demo_layer_analysis():
    """Demonstrate layer-based analysis"""
    print("\n" + "=" * 60)
    print("DEMO 4: Layer-Based Analysis")
    print("=" * 60)
    
    try:
        loader = get_project_loader()
        
        # Analyze each layer
        for layer_name in loader.layers.keys():
            layer_info = loader.get_layer(layer_name)
            if layer_info:
                nodes = layer_info["nodes"]
                print(f"\n📚 Layer: {layer_name}")
                print(f"   📊 Total nodes: {len(nodes)}")
                
                # Count node types in this layer
                type_counts = {}
                for node in nodes:
                    node_type = node.type
                    type_counts[node_type] = type_counts.get(node_type, 0) + 1
                
                print("   🏷️ Node types:")
                for node_type, count in sorted(type_counts.items()):
                    print(f"      • {node_type}: {count}")
                    
                # Show some example nodes
                print("   📝 Example nodes:")
                for node in nodes[:3]:
                    print(f"      • {node.name} ({node.type})")
                    
    except Exception as e:
        print(f"❌ Error in layer analysis: {e}")
        return False
    
    return True


def demo_subgraph_extraction():
    """Demonstrate subgraph extraction"""
    print("\n" + "=" * 60)
    print("DEMO 5: Subgraph Extraction")
    print("=" * 60)
    
    try:
        loader = get_project_loader()
        
        # Find some interesting nodes for subgraph extraction
        api_nodes = loader.get_nodes(layer="api")[:3]
        if not api_nodes:
            api_nodes = list(loader.nodes.values())[:3]
        
        node_ids = [node.id for node in api_nodes]
        print(f"\n🎯 Extracting subgraph for nodes: {[node.name for node in api_nodes]}")
        
        subgraph = loader.get_subgraph(node_ids)
        print(f"\n📊 Subgraph Statistics:")
        print(f"   📊 Nodes: {subgraph['nodeCount']}")
        print(f"   🔗 Edges: {subgraph['edgeCount']}")
        
        print(f"\n📝 Subgraph Nodes:")
        for node in subgraph["nodes"]:
            print(f"   • {node.name} ({node.type})")
            
        print(f"\n🔗 Subgraph Edges:")
        for edge in subgraph["edges"]:
            print(f"   • {edge.type}: connects {len(edge.nodes)} nodes")
            
    except Exception as e:
        print(f"❌ Error in subgraph extraction: {e}")
        return False
    
    return True


def demo_graphql_resolvers():
    """Demonstrate GraphQL resolver functionality"""
    print("\n" + "=" * 60)
    print("DEMO 6: GraphQL Resolver Testing")
    print("=" * 60)
    
    try:
        # Test some resolvers directly
        print("\n🧪 Testing GraphQL Resolvers:")
        
        # Test project nodes resolver
        nodes_result = resolve_project_nodes(None, None, type="python_file", limit=3)
        print(f"\n🐍 Python files (via resolver): {len(nodes_result)} found")
        for node in nodes_result:
            print(f"   • {node['name']} (ID: {node['id']})")
        
        # Test layers resolver
        layers_result = resolve_project_layers(None, None)
        print(f"\n📚 Layers (via resolver): {len(layers_result)} found")
        for layer in layers_result:
            print(f"   • {layer['name']}: {layer['nodeCount']} nodes")
        
        # Test metrics resolver
        metrics_result = resolve_project_metrics(None, None)
        print(f"\n📊 Metrics (via resolver):")
        print(f"   🔢 Total nodes: {metrics_result['totalNodes']}")
        print(f"   🔗 Total hyperedges: {metrics_result['totalHyperedges']}")
        print(f"   📊 Density: {metrics_result['density']:.4f}")
        
    except Exception as e:
        print(f"❌ Error testing GraphQL resolvers: {e}")
        return False
    
    return True


def main():
    """Run all demos"""
    print("🚀" * 30)
    print("   PROJECT HYPERGRAPHQL DEMONSTRATION")  
    print("🚀" * 30)
    print(f"Project: rzonedevops/analysis v0.6.0")
    print(f"Hypergraph: project_hypergraph.json")
    print(f"Purpose: Demonstrate GraphQL integration with project structure")
    
    demos = [
        demo_basic_queries,
        demo_node_queries, 
        demo_graph_traversal,
        demo_layer_analysis,
        demo_subgraph_extraction,
        demo_graphql_resolvers
    ]
    
    success_count = 0
    for demo in demos:
        try:
            if demo():
                success_count += 1
        except Exception as e:
            print(f"❌ Demo failed: {e}")
    
    print("\n" + "=" * 60)
    print(f"✅ DEMO RESULTS: {success_count}/{len(demos)} demos successful")
    print("=" * 60)
    
    if success_count == len(demos):
        print("\n🎉 All demos completed successfully!")
        print("🚀 Project HyperGraphQL integration is working!")
        print("\n📋 Next steps:")
        print("   • Start GraphQL server: python src/api/hypergraphql_project_server.py")
        print("   • Open GraphQL Playground: http://localhost:8000/graphql")
        print("   • Try some queries in the playground!")
    else:
        print(f"\n⚠️ Some demos failed. Please check the logs above.")
    
    return success_count == len(demos)


if __name__ == "__main__":
    success = main()
    sys.exit(0 if success else 1)