#!/usr/bin/env python3
"""
HyperGraphQL Project Integration
==================================

Integrates the project hypergraph (from project_hypergraph.json) with HyperGraphQL.
Provides GraphQL schema and resolvers specifically for the project structure:
- 985 nodes across 8 layers (filesystem, python_code, database, etc.)
- 532 hyperedges with relationships (contains, defines, documentation_category)
- Layer-based queries and graph analysis

Node types: directory, module, python_file, function, class, database_table,
           database_index, graphql_type, dependency, documentation, configuration, test_file
Edge types: contains, defines, documentation_category
"""

import json
import logging
from pathlib import Path
from typing import Any, Dict, List, Optional
from dataclasses import dataclass
from enum import Enum

import networkx as nx

logger = logging.getLogger(__name__)


class ProjectNodeType(Enum):
    """Project-specific node types from the hypergraph"""
    DIRECTORY = "directory"
    MODULE = "module" 
    PYTHON_FILE = "python_file"
    FUNCTION = "function"
    CLASS = "class"
    DATABASE_TABLE = "database_table"
    DATABASE_INDEX = "database_index"
    GRAPHQL_TYPE = "graphql_type"
    DEPENDENCY = "dependency"
    DOCUMENTATION = "documentation"
    CONFIGURATION = "configuration"
    TEST_FILE = "test_file"


class ProjectEdgeType(Enum):
    """Project-specific edge types from the hypergraph"""
    CONTAINS = "contains"
    DEFINES = "defines" 
    DOCUMENTATION_CATEGORY = "documentation_category"


class ProjectLayerType(Enum):
    """Project layers from the 8-layer architecture"""
    FILESYSTEM = "filesystem"
    PYTHON_CODE = "python_code"
    DATABASE = "database"
    API = "api"
    DEPENDENCIES = "dependencies"
    DOCUMENTATION = "documentation"
    CONFIGURATION = "configuration"
    TESTS = "tests"


@dataclass
class ProjectNode:
    """Represents a node in the project hypergraph"""
    id: int
    type: str
    name: str
    properties: Dict[str, Any]
    layer: Optional[str] = None

    @classmethod
    def from_json(cls, node_data: Dict[str, Any]) -> "ProjectNode":
        """Create a ProjectNode from JSON data"""
        return cls(
            id=node_data["id"],
            type=node_data["type"],
            name=node_data["name"],
            properties=node_data.get("properties", {}),
            layer=node_data.get("layer")
        )

    def to_graphql_dict(self) -> Dict[str, Any]:
        """Convert to GraphQL-compatible dictionary"""
        return {
            "id": str(self.id),
            "type": self.type,
            "name": self.name,
            "properties": self.properties,
            "layer": self.layer or self._infer_layer()
        }

    def _infer_layer(self) -> str:
        """Infer layer based on node type"""
        type_to_layer = {
            "directory": "filesystem",
            "module": "filesystem",
            "python_file": "python_code",
            "function": "python_code",
            "class": "python_code",
            "database_table": "database",
            "database_index": "database",
            "graphql_type": "api",
            "dependency": "dependencies",
            "documentation": "documentation",
            "configuration": "configuration",
            "test_file": "tests"
        }
        return type_to_layer.get(self.type, "unknown")


@dataclass 
class ProjectHyperEdge:
    """Represents a hyperedge in the project hypergraph"""
    id: int
    type: str
    nodes: List[int]
    properties: Dict[str, Any]

    @classmethod
    def from_json(cls, edge_data: Dict[str, Any]) -> "ProjectHyperEdge":
        """Create a ProjectHyperEdge from JSON data"""
        return cls(
            id=edge_data["id"],
            type=edge_data["type"],
            nodes=edge_data["nodes"],
            properties=edge_data.get("properties", {})
        )

    def to_graphql_dict(self) -> Dict[str, Any]:
        """Convert to GraphQL-compatible dictionary"""
        return {
            "id": str(self.id),
            "type": self.type,
            "nodes": [str(n) for n in self.nodes],
            "properties": self.properties
        }


class ProjectHypergraphLoader:
    """Loads and manages the project hypergraph data"""
    
    def __init__(self, data_path: str = "project_hypergraph.json"):
        self.data_path = Path(data_path)
        self.nodes: Dict[int, ProjectNode] = {}
        self.edges: Dict[int, ProjectHyperEdge] = {}
        self.layers: Dict[str, Dict[str, Any]] = {}
        self.metrics: Dict[str, Any] = {}
        self.graph: nx.Graph = nx.Graph()
        self._loaded = False

    def load(self) -> None:
        """Load the project hypergraph data"""
        if self._loaded:
            return

        logger.info(f"Loading project hypergraph from {self.data_path}")
        
        if not self.data_path.exists():
            raise FileNotFoundError(f"Project hypergraph file not found: {self.data_path}")

        with open(self.data_path, 'r') as f:
            data = json.load(f)

        # Load nodes
        for node_id, node_data in data["nodes"].items():
            node = ProjectNode.from_json(node_data)
            self.nodes[node.id] = node
            self.graph.add_node(node.id, **node.to_graphql_dict())

        # Load hyperedges 
        for i, edge_data in enumerate(data["hyperedges"]):
            edge = ProjectHyperEdge.from_json(edge_data)
            self.edges[edge.id] = edge
            
            # Add edges to NetworkX graph (for binary connections)
            if len(edge.nodes) == 2:
                self.graph.add_edge(edge.nodes[0], edge.nodes[1], **edge.to_graphql_dict())

        # Load layers and metrics
        self.layers = data.get("layers", {})
        self.metrics = data.get("metrics", {})
        
        self._loaded = True
        logger.info(f"Loaded {len(self.nodes)} nodes, {len(self.edges)} hyperedges, {len(self.layers)} layers")

    def get_node(self, node_id: int) -> Optional[ProjectNode]:
        """Get a node by ID"""
        self.load()
        return self.nodes.get(node_id)

    def get_nodes(self, node_type: Optional[str] = None, layer: Optional[str] = None) -> List[ProjectNode]:
        """Get nodes with optional filtering"""
        self.load()
        nodes = list(self.nodes.values())
        
        if node_type:
            nodes = [n for n in nodes if n.type == node_type]
        
        if layer:
            nodes = [n for n in nodes if n._infer_layer() == layer]
            
        return nodes

    def get_nodes_by_name(self, name_pattern: str) -> List[ProjectNode]:
        """Get nodes by name pattern"""
        self.load()
        return [n for n in self.nodes.values() if name_pattern.lower() in n.name.lower()]

    def get_hyperedge(self, edge_id: int) -> Optional[ProjectHyperEdge]:
        """Get a hyperedge by ID"""
        self.load()
        return self.edges.get(edge_id)

    def get_hyperedges(self, edge_type: Optional[str] = None) -> List[ProjectHyperEdge]:
        """Get hyperedges with optional filtering"""
        self.load()
        edges = list(self.edges.values())
        
        if edge_type:
            edges = [e for e in edges if e.type == edge_type]
            
        return edges

    def get_layer(self, layer_name: str) -> Optional[Dict[str, Any]]:
        """Get layer information"""
        self.load()
        if layer_name not in self.layers:
            return None
            
        layer_nodes = [n for n in self.nodes.values() if n._infer_layer() == layer_name]
        return {
            "name": layer_name,
            "description": self.layers[layer_name].get("description", f"{layer_name} layer"),
            "nodes": layer_nodes,
            "nodeCount": len(layer_nodes)
        }

    def get_all_layers(self) -> List[Dict[str, Any]]:
        """Get all layers"""
        self.load()
        return [self.get_layer(layer_name) for layer_name in self.layers.keys()]

    def get_neighbors(self, node_id: int, depth: int = 1) -> List[ProjectNode]:
        """Get neighboring nodes up to specified depth"""
        self.load()
        
        if node_id not in self.nodes:
            return []
            
        # Use NetworkX for neighbor traversal
        if depth == 1:
            neighbor_ids = list(self.graph.neighbors(node_id))
        else:
            # Use BFS for multi-hop neighbors
            neighbor_ids = []
            visited = set([node_id])
            queue = [(node_id, 0)]
            
            while queue:
                current_id, current_depth = queue.pop(0)
                if current_depth < depth:
                    for neighbor_id in self.graph.neighbors(current_id):
                        if neighbor_id not in visited:
                            visited.add(neighbor_id)
                            neighbor_ids.append(neighbor_id)
                            queue.append((neighbor_id, current_depth + 1))
        
        return [self.nodes[nid] for nid in neighbor_ids if nid in self.nodes]

    def get_shortest_path(self, from_id: int, to_id: int) -> List[ProjectNode]:
        """Find shortest path between two nodes"""
        self.load()
        
        try:
            path_ids = nx.shortest_path(self.graph, from_id, to_id)
            return [self.nodes[nid] for nid in path_ids if nid in self.nodes]
        except (nx.NetworkXNoPath, KeyError):
            return []

    def get_subgraph(self, node_ids: List[int]) -> Dict[str, Any]:
        """Extract subgraph containing specified nodes"""
        self.load()
        
        # Filter existing nodes
        valid_node_ids = [nid for nid in node_ids if nid in self.nodes]
        subgraph_nodes = [self.nodes[nid] for nid in valid_node_ids]
        
        # Find edges connecting these nodes
        subgraph_edges = []
        for edge in self.edges.values():
            if all(nid in valid_node_ids for nid in edge.nodes):
                subgraph_edges.append(edge)
        
        return {
            "nodes": subgraph_nodes,
            "edges": subgraph_edges,
            "nodeCount": len(subgraph_nodes),
            "edgeCount": len(subgraph_edges)
        }

    def get_node_metrics(self, node_id: int) -> Dict[str, Any]:
        """Get metrics for a specific node"""
        self.load()
        
        if node_id not in self.nodes:
            return {}
            
        node = self.nodes[node_id]
        degree = self.graph.degree(node_id) if self.graph.has_node(node_id) else 0
        
        return {
            "nodeId": str(node_id),
            "degree": degree,
            "type": node.type,
            "layer": node._infer_layer()
        }

    def get_hypergraph_metrics(self) -> Dict[str, Any]:
        """Get overall hypergraph metrics"""
        self.load()
        return self.metrics


# Global loader instance
_project_loader = None

def get_project_loader() -> ProjectHypergraphLoader:
    """Get the global project loader instance"""
    global _project_loader
    if _project_loader is None:
        _project_loader = ProjectHypergraphLoader()
    return _project_loader