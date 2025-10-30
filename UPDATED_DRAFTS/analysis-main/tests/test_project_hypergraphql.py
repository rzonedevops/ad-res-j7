#!/usr/bin/env python3
"""
Tests for Project HyperGraphQL Implementation
==============================================

Tests the core functionality of the project hypergraph GraphQL integration.
"""

import sys
import unittest
from pathlib import Path

# Add src to path
sys.path.insert(0, str(Path(__file__).parent.parent))

from src.api.hypergraphql_project import (
    ProjectHypergraphLoader, 
    ProjectNode, 
    ProjectHyperEdge,
    get_project_loader
)


class TestProjectHypergraphLoader(unittest.TestCase):
    """Test the project hypergraph loader"""
    
    def setUp(self):
        """Set up test fixtures"""
        self.loader = get_project_loader()
        self.loader.load()
    
    def test_loader_initialization(self):
        """Test that loader initializes correctly"""
        self.assertIsInstance(self.loader, ProjectHypergraphLoader)
        self.assertTrue(self.loader._loaded)
    
    def test_hypergraph_data_loaded(self):
        """Test that hypergraph data is loaded"""
        self.assertGreater(len(self.loader.nodes), 0)
        self.assertGreater(len(self.loader.edges), 0)
        self.assertGreater(len(self.loader.layers), 0)
        
        # Verify expected counts from project
        self.assertEqual(len(self.loader.nodes), 985)
        self.assertEqual(len(self.loader.edges), 532)
        self.assertEqual(len(self.loader.layers), 8)
    
    def test_node_types(self):
        """Test node type distribution"""
        node_types = set(node.type for node in self.loader.nodes.values())
        expected_types = {
            'directory', 'module', 'python_file', 'function', 'class',
            'database_table', 'database_index', 'graphql_type', 
            'dependency', 'documentation', 'configuration', 'test_file'
        }
        self.assertEqual(node_types, expected_types)
    
    def test_edge_types(self):
        """Test edge type distribution"""
        edge_types = set(edge.type for edge in self.loader.edges.values())
        expected_types = {'contains', 'defines', 'documentation_category'}
        self.assertEqual(edge_types, expected_types)
    
    def test_layer_names(self):
        """Test layer names"""
        layer_names = set(self.loader.layers.keys())
        expected_layers = {
            'filesystem', 'python_code', 'database', 'api', 
            'dependencies', 'documentation', 'configuration', 'tests'
        }
        self.assertEqual(layer_names, expected_layers)
    
    def test_get_node(self):
        """Test single node retrieval"""
        # Get first node
        first_node_id = list(self.loader.nodes.keys())[0]
        node = self.loader.get_node(first_node_id)
        
        self.assertIsInstance(node, ProjectNode)
        self.assertEqual(node.id, first_node_id)
        self.assertIsNotNone(node.name)
        self.assertIsNotNone(node.type)
    
    def test_get_nodes_by_type(self):
        """Test node filtering by type"""
        python_files = self.loader.get_nodes(node_type="python_file")
        self.assertGreater(len(python_files), 0)
        
        for node in python_files:
            self.assertEqual(node.type, "python_file")
    
    def test_get_nodes_by_layer(self):
        """Test node filtering by layer"""
        api_nodes = self.loader.get_nodes(layer="api")
        
        for node in api_nodes:
            self.assertEqual(node._infer_layer(), "api")
    
    def test_get_nodes_by_name(self):
        """Test name-based search"""
        hypergraph_nodes = self.loader.get_nodes_by_name("hypergraph")
        self.assertGreater(len(hypergraph_nodes), 0)
        
        for node in hypergraph_nodes:
            self.assertIn("hypergraph", node.name.lower())
    
    def test_get_layer(self):
        """Test layer retrieval"""
        filesystem_layer = self.loader.get_layer("filesystem")
        
        self.assertIsNotNone(filesystem_layer)
        self.assertEqual(filesystem_layer["name"], "filesystem")
        self.assertGreater(filesystem_layer["nodeCount"], 0)
        self.assertIsInstance(filesystem_layer["nodes"], list)
    
    def test_get_neighbors(self):
        """Test neighbor retrieval"""
        # Test with a node that should have neighbors
        first_node_id = list(self.loader.nodes.keys())[0]
        neighbors = self.loader.get_neighbors(first_node_id, depth=1)
        
        # Neighbors should be a list (might be empty)
        self.assertIsInstance(neighbors, list)
    
    def test_get_metrics(self):
        """Test metrics retrieval"""
        metrics = self.loader.get_hypergraph_metrics()
        
        self.assertIsInstance(metrics, dict)
        self.assertIn('total_nodes', metrics)
        self.assertIn('total_hyperedges', metrics)
        self.assertEqual(metrics['total_nodes'], 985)
        self.assertEqual(metrics['total_hyperedges'], 532)
    
    def test_node_to_graphql_dict(self):
        """Test node GraphQL conversion"""
        first_node = list(self.loader.nodes.values())[0]
        graphql_dict = first_node.to_graphql_dict()
        
        self.assertIsInstance(graphql_dict, dict)
        self.assertIn('id', graphql_dict)
        self.assertIn('name', graphql_dict)
        self.assertIn('type', graphql_dict)
        self.assertIn('properties', graphql_dict)
        self.assertIn('layer', graphql_dict)
    
    def test_edge_to_graphql_dict(self):
        """Test edge GraphQL conversion"""
        first_edge = list(self.loader.edges.values())[0]
        graphql_dict = first_edge.to_graphql_dict()
        
        self.assertIsInstance(graphql_dict, dict)
        self.assertIn('id', graphql_dict)
        self.assertIn('type', graphql_dict)
        self.assertIn('nodes', graphql_dict)
        self.assertIn('properties', graphql_dict)


class TestProjectHypergraphIntegration(unittest.TestCase):
    """Test the integration functionality"""
    
    def setUp(self):
        """Set up test fixtures"""
        self.loader = get_project_loader()
    
    def test_loader_singleton(self):
        """Test that get_project_loader returns same instance"""
        loader1 = get_project_loader()
        loader2 = get_project_loader()
        self.assertIs(loader1, loader2)
    
    def test_subgraph_extraction(self):
        """Test subgraph extraction"""
        # Get first few node IDs
        node_ids = list(self.loader.nodes.keys())[:3]
        int_node_ids = [int(nid) for nid in node_ids]
        
        subgraph = self.loader.get_subgraph(int_node_ids)
        
        self.assertIsInstance(subgraph, dict)
        self.assertIn('nodes', subgraph)
        self.assertIn('edges', subgraph)
        self.assertIn('nodeCount', subgraph)
        self.assertIn('edgeCount', subgraph)
        self.assertEqual(subgraph['nodeCount'], len(subgraph['nodes']))
    
    def test_shortest_path(self):
        """Test shortest path finding"""
        # Try to find path between first two nodes
        node_ids = list(self.loader.nodes.keys())[:2]
        if len(node_ids) >= 2:
            from_id = int(node_ids[0])
            to_id = int(node_ids[1])
            
            path = self.loader.get_shortest_path(from_id, to_id)
            # Path should be a list (might be empty if no path exists)
            self.assertIsInstance(path, list)


if __name__ == '__main__':
    # Run tests
    unittest.main(verbosity=2)