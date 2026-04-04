#!/usr/bin/env python3
"""
HyperGraphQL Project Resolvers
===============================

GraphQL resolvers for the project hypergraph queries and mutations.
Implements all query types defined in project_hypergraph_schema.graphql:
- Node and edge retrieval with filtering
- Layer-based navigation
- Graph traversal (neighbors, shortest path, subgraphs)
- Analysis queries (metrics, community detection)
- Search functionality
"""

import logging
from typing import Any, Dict, List, Optional

from ariadne import QueryType, MutationType, ObjectType, EnumType
from graphql import GraphQLError

try:
    import community as community_louvain
    COMMUNITY_AVAILABLE = True
except ImportError:
    COMMUNITY_AVAILABLE = False

from hypergraphql_project import (
    get_project_loader
)

logger = logging.getLogger(__name__)

# Initialize resolver objects
query = QueryType()
mutation = MutationType()
project_node = ObjectType("ProjectNode")
project_hyperedge = ObjectType("ProjectHyperEdge")
project_layer = ObjectType("ProjectLayer")

# Enum resolvers
project_node_type_enum = EnumType("ProjectNodeType", {
    "DIRECTORY": "directory",
    "MODULE": "module", 
    "PYTHON_FILE": "python_file",
    "FUNCTION": "function",
    "CLASS": "class",
    "DATABASE_TABLE": "database_table",
    "DATABASE_INDEX": "database_index",
    "GRAPHQL_TYPE": "graphql_type",
    "DEPENDENCY": "dependency",
    "DOCUMENTATION": "documentation",
    "CONFIGURATION": "configuration",
    "TEST_FILE": "test_file",
})

project_edge_type_enum = EnumType("ProjectEdgeType", {
    "CONTAINS": "contains",
    "DEFINES": "defines",
    "DOCUMENTATION_CATEGORY": "documentation_category",
})

project_layer_type_enum = EnumType("ProjectLayerType", {
    "FILESYSTEM": "filesystem",
    "PYTHON_CODE": "python_code",
    "DATABASE": "database",
    "API": "api",
    "DEPENDENCIES": "dependencies",
    "DOCUMENTATION": "documentation",
    "CONFIGURATION": "configuration",
    "TESTS": "tests",
})


# Query resolvers
@query.field("projectNode")
def resolve_project_node(_, info, id: str) -> Optional[Dict[str, Any]]:
    """Resolve a single project node by ID"""
    try:
        node_id = int(id)
        loader = get_project_loader()
        node = loader.get_node(node_id)
        return node.to_graphql_dict() if node else None
    except (ValueError, Exception) as e:
        logger.error(f"Error resolving project node {id}: {e}")
        return None


@query.field("projectHyperedge")
def resolve_project_hyperedge(_, info, id: str) -> Optional[Dict[str, Any]]:
    """Resolve a single project hyperedge by ID"""
    try:
        edge_id = int(id)
        loader = get_project_loader()
        edge = loader.get_hyperedge(edge_id)
        return edge.to_graphql_dict() if edge else None
    except (ValueError, Exception) as e:
        logger.error(f"Error resolving project hyperedge {id}: {e}")
        return None


@query.field("projectNodes")
def resolve_project_nodes(
    _, info, 
    type: Optional[str] = None, 
    layer: Optional[str] = None,
    limit: int = 100,
    offset: int = 0
) -> List[Dict[str, Any]]:
    """Resolve project nodes with optional filtering"""
    try:
        loader = get_project_loader()
        nodes = loader.get_nodes(node_type=type, layer=layer)
        
        # Apply pagination
        nodes = nodes[offset:offset + limit]
        
        return [node.to_graphql_dict() for node in nodes]
    except Exception as e:
        logger.error(f"Error resolving project nodes: {e}")
        return []


@query.field("projectNodesByName")
def resolve_project_nodes_by_name(_, info, name: str) -> List[Dict[str, Any]]:
    """Resolve project nodes by name pattern"""
    try:
        loader = get_project_loader()
        nodes = loader.get_nodes_by_name(name)
        return [node.to_graphql_dict() for node in nodes]
    except Exception as e:
        logger.error(f"Error resolving project nodes by name {name}: {e}")
        return []


@query.field("projectHyperedges")
def resolve_project_hyperedges(
    _, info, 
    type: Optional[str] = None,
    limit: int = 100,
    offset: int = 0
) -> List[Dict[str, Any]]:
    """Resolve project hyperedges with optional filtering"""
    try:
        loader = get_project_loader()
        edges = loader.get_hyperedges(edge_type=type)
        
        # Apply pagination
        edges = edges[offset:offset + limit]
        
        return [edge.to_graphql_dict() for edge in edges]
    except Exception as e:
        logger.error(f"Error resolving project hyperedges: {e}")
        return []


@query.field("projectLayer")
def resolve_project_layer(_, info, name: str) -> Optional[Dict[str, Any]]:
    """Resolve a project layer by name"""
    try:
        loader = get_project_loader()
        layer = loader.get_layer(name)
        if layer:
            # Convert nodes to GraphQL format
            layer["nodes"] = [node.to_graphql_dict() for node in layer["nodes"]]
            # Extract node types
            layer["nodeTypes"] = list(set(node["type"] for node in layer["nodes"]))
        return layer
    except Exception as e:
        logger.error(f"Error resolving project layer {name}: {e}")
        return None


@query.field("projectLayers")
def resolve_project_layers(_, info) -> List[Dict[str, Any]]:
    """Resolve all project layers"""
    try:
        loader = get_project_loader()
        layers = loader.get_all_layers()
        result = []
        for layer in layers:
            if layer:
                layer["nodes"] = [node.to_graphql_dict() for node in layer["nodes"]]
                layer["nodeTypes"] = list(set(node["type"] for node in layer["nodes"]))
                result.append(layer)
        return result
    except Exception as e:
        logger.error(f"Error resolving project layers: {e}")
        return []


@query.field("projectNeighbors")
def resolve_project_neighbors(_, info, nodeId: str, depth: int = 1) -> List[Dict[str, Any]]:
    """Resolve neighboring nodes with optional depth"""
    try:
        node_id = int(nodeId)
        loader = get_project_loader()
        neighbors = loader.get_neighbors(node_id, depth)
        return [node.to_graphql_dict() for node in neighbors]
    except (ValueError, Exception) as e:
        logger.error(f"Error resolving project neighbors for {nodeId}: {e}")
        return []


@query.field("projectShortestPath")
def resolve_project_shortest_path(_, info, fromId: str, toId: str) -> List[Dict[str, Any]]:
    """Resolve shortest path between two nodes"""
    try:
        from_id = int(fromId)
        to_id = int(toId)
        loader = get_project_loader()
        path_nodes = loader.get_shortest_path(from_id, to_id)
        return [node.to_graphql_dict() for node in path_nodes]
    except (ValueError, Exception) as e:
        logger.error(f"Error resolving shortest path from {fromId} to {toId}: {e}")
        return []


@query.field("projectSubgraph")
def resolve_project_subgraph(_, info, nodeIds: List[str]) -> Dict[str, Any]:
    """Resolve subgraph containing specified nodes"""
    try:
        node_ids = [int(nid) for nid in nodeIds]
        loader = get_project_loader()
        subgraph = loader.get_subgraph(node_ids)
        
        # Convert to GraphQL format
        result = {
            "nodes": [node.to_graphql_dict() for node in subgraph["nodes"]],
            "edges": [edge.to_graphql_dict() for edge in subgraph["edges"]],
            "nodeCount": subgraph["nodeCount"],
            "edgeCount": subgraph["edgeCount"]
        }
        return result
    except (ValueError, Exception) as e:
        logger.error(f"Error resolving project subgraph: {e}")
        return {"nodes": [], "edges": [], "nodeCount": 0, "edgeCount": 0}


@query.field("projectMetrics")
def resolve_project_metrics(_, info) -> Dict[str, Any]:
    """Resolve overall hypergraph metrics"""
    try:
        loader = get_project_loader()
        metrics = loader.get_hypergraph_metrics()
        
        # Ensure all required fields are present
        return {
            "totalNodes": metrics.get("total_nodes", 0),
            "totalHyperedges": metrics.get("total_hyperedges", 0), 
            "totalLayers": metrics.get("total_layers", 0),
            "nodeTypes": metrics.get("node_types", {}),
            "edgeTypes": metrics.get("edge_types", {}),
            "layerSizes": metrics.get("layer_sizes", {}),
            "density": metrics.get("density", 0.0),
            "averageDegree": metrics.get("average_degree", 0.0)
        }
    except Exception as e:
        logger.error(f"Error resolving project metrics: {e}")
        return {
            "totalNodes": 0, "totalHyperedges": 0, "totalLayers": 0,
            "nodeTypes": {}, "edgeTypes": {}, "layerSizes": {},
            "density": 0.0, "averageDegree": 0.0
        }


@query.field("projectNodeMetrics")
def resolve_project_node_metrics(_, info, nodeId: str) -> Optional[Dict[str, Any]]:
    """Resolve metrics for a specific node"""
    try:
        node_id = int(nodeId)
        loader = get_project_loader()
        metrics = loader.get_node_metrics(node_id)
        return metrics if metrics else None
    except (ValueError, Exception) as e:
        logger.error(f"Error resolving node metrics for {nodeId}: {e}")
        return None


@query.field("projectCommunityDetection")
def resolve_project_community_detection(_, info, algorithm: str = "louvain") -> List[Dict[str, Any]]:
    """Resolve community detection results"""
    try:
        if not COMMUNITY_AVAILABLE:
            logger.warning("Community detection library not available")
            return []
            
        loader = get_project_loader()
        loader.load()  # Ensure data is loaded
        
        if algorithm.lower() == "louvain":
            # Use Louvain algorithm for community detection
            partition = community_louvain.best_partition(loader.graph)
            
            # Group nodes by community
            communities = {}
            for node_id, community_id in partition.items():
                if community_id not in communities:
                    communities[community_id] = []
                communities[community_id].append(node_id)
            
            # Convert to GraphQL format
            result = []
            for community_id, node_ids in communities.items():
                nodes = [loader.nodes[nid].to_graphql_dict() for nid in node_ids if nid in loader.nodes]
                
                # Calculate community density
                subgraph = loader.graph.subgraph(node_ids)
                n = len(node_ids)
                m = subgraph.number_of_edges()
                density = (2.0 * m) / (n * (n - 1)) if n > 1 else 0.0
                
                result.append({
                    "id": community_id,
                    "nodes": nodes,
                    "size": len(nodes),
                    "density": density
                })
                
            return result
        else:
            logger.warning(f"Unsupported community detection algorithm: {algorithm}")
            return []
            
    except Exception as e:
        logger.error(f"Error in community detection: {e}")
        return []


@query.field("searchProjectNodes")
def resolve_search_project_nodes(
    _, info, 
    query: str, 
    type: Optional[str] = None,
    layer: Optional[str] = None,
    limit: int = 50
) -> List[Dict[str, Any]]:
    """Search project nodes by query string"""
    try:
        loader = get_project_loader()
        
        # Start with all nodes
        nodes = loader.get_nodes(node_type=type, layer=layer)
        
        # Filter by query string (search in name and properties)
        query_lower = query.lower()
        matching_nodes = []
        
        for node in nodes:
            if query_lower in node.name.lower():
                matching_nodes.append(node)
            elif any(query_lower in str(v).lower() for v in node.properties.values() if v):
                matching_nodes.append(node)
        
        # Apply limit
        matching_nodes = matching_nodes[:limit]
        
        return [node.to_graphql_dict() for node in matching_nodes]
        
    except Exception as e:
        logger.error(f"Error searching project nodes: {e}")
        return []


# Object type resolvers for computed fields
@project_node.field("degree")
def resolve_node_degree(node: Dict[str, Any], info) -> int:
    """Resolve node degree"""
    try:
        node_id = int(node["id"])
        loader = get_project_loader()
        metrics = loader.get_node_metrics(node_id)
        return metrics.get("degree", 0)
    except Exception as e:
        logger.error(f"Error resolving node degree: {e}")
        return 0


@project_node.field("neighbors")
def resolve_node_neighbors(node: Dict[str, Any], info, depth: int = 1) -> List[Dict[str, Any]]:
    """Resolve node neighbors"""
    try:
        node_id = int(node["id"])
        loader = get_project_loader()
        neighbors = loader.get_neighbors(node_id, depth)
        return [n.to_graphql_dict() for n in neighbors]
    except Exception as e:
        logger.error(f"Error resolving node neighbors: {e}")
        return []


@project_node.field("connectedEdges")
def resolve_node_connected_edges(node: Dict[str, Any], info) -> List[Dict[str, Any]]:
    """Resolve edges connected to this node"""
    try:
        node_id = int(node["id"])
        loader = get_project_loader()
        loader.load()
        
        connected_edges = []
        for edge in loader.edges.values():
            if node_id in edge.nodes:
                connected_edges.append(edge.to_graphql_dict())
        
        return connected_edges
    except Exception as e:
        logger.error(f"Error resolving connected edges: {e}")
        return []


@project_hyperedge.field("nodes")
def resolve_hyperedge_nodes(edge: Dict[str, Any], info) -> List[Dict[str, Any]]:
    """Resolve nodes in a hyperedge"""
    try:
        node_ids = [int(nid) for nid in edge["nodes"]]
        loader = get_project_loader()
        
        nodes = []
        for node_id in node_ids:
            node = loader.get_node(node_id)
            if node:
                nodes.append(node.to_graphql_dict())
        
        return nodes
    except Exception as e:
        logger.error(f"Error resolving hyperedge nodes: {e}")
        return []


@project_hyperedge.field("size")
def resolve_hyperedge_size(edge: Dict[str, Any], info) -> int:
    """Resolve hyperedge size (number of nodes)"""
    try:
        return len(edge.get("nodes", []))
    except Exception:
        return 0


@project_hyperedge.field("nodeIds")
def resolve_hyperedge_node_ids(edge: Dict[str, Any], info) -> List[str]:
    """Resolve hyperedge node IDs"""
    return edge.get("nodes", [])


# Basic mutation resolvers (for future extension)
@mutation.field("addProjectNode")
def resolve_add_project_node(_, info, input: Dict[str, Any]) -> Dict[str, Any]:
    """Add a new project node (placeholder)"""
    raise GraphQLError("Mutations not yet implemented for project hypergraph")


@mutation.field("updateProjectNode") 
def resolve_update_project_node(_, info, id: str, input: Dict[str, Any]) -> Dict[str, Any]:
    """Update a project node (placeholder)"""
    raise GraphQLError("Mutations not yet implemented for project hypergraph")


@mutation.field("deleteProjectNode")
def resolve_delete_project_node(_, info, id: str) -> bool:
    """Delete a project node (placeholder)"""
    raise GraphQLError("Mutations not yet implemented for project hypergraph")


# Export resolvers for schema creation
resolvers = [
    query,
    mutation,
    project_node,
    project_hyperedge,
    project_layer,
    project_node_type_enum,
    project_edge_type_enum,  
    project_layer_type_enum
]