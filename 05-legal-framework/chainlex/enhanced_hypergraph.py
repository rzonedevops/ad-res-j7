#!/usr/bin/env python3
"""
ChainLex Enhanced Hypergraph Integration

Provides seamless integration between the ChainLex API and the hypergraph
system, enabling advanced graph-based legal reasoning and queries.

Features:
- Unified interface combining API and hypergraph
- Advanced path finding algorithms
- Multi-hop inference chains
- Confidence propagation through graphs
- Subgraph extraction by domain
- Network analysis and metrics
"""

import pickle
from pathlib import Path
from typing import List, Dict, Any, Optional, Set, Tuple
from collections import defaultdict

try:
    import networkx as nx
    NETWORKX_AVAILABLE = True
except ImportError:
    NETWORKX_AVAILABLE = False
    print("⚠️  NetworkX not available. Install with: pip install networkx")

from datetime import datetime
from chainlex_api import ChainLex


class EnhancedHypergraphAPI:
    """Enhanced hypergraph integration for ChainLex"""
    
    def __init__(self, chainlex: ChainLex, hypergraph_file: Optional[str] = None):
        """
        Initialize enhanced hypergraph integration
        
        Args:
            chainlex: ChainLex API instance
            hypergraph_file: Path to hypergraph pickle file
        """
        self.chainlex = chainlex
        self.graph = None
        self.hyperedges = None
        self.node_index = None
        
        if not NETWORKX_AVAILABLE:
            print("⚠️  Enhanced hypergraph features disabled (NetworkX not available)")
            return
        
        # Load hypergraph
        if hypergraph_file is None:
            hypergraph_file = Path(chainlex.base_path) / "hypergraph" / "scmlex_hypergraph.pkl"
        
        if Path(hypergraph_file).exists():
            self._load_hypergraph(hypergraph_file)
        else:
            print(f"⚠️  Hypergraph file not found: {hypergraph_file}")
    
    def _load_hypergraph(self, file_path: str):
        """Load hypergraph from pickle file"""
        try:
            print(f"Loading hypergraph from {file_path}...")
            with open(file_path, 'rb') as f:
                data = pickle.load(f)
            
            self.graph = data['graph']
            self.hyperedges = data['hyperedges']
            self.node_index = data['node_index']
            
            print(f"✅ Loaded hypergraph: {self.graph.number_of_nodes()} nodes, {self.graph.number_of_edges()} edges")
        except Exception as e:
            print(f"❌ Failed to load hypergraph: {e}")
    
    def is_available(self) -> bool:
        """Check if hypergraph is available"""
        return self.graph is not None
    
    def find_path(self, start: str, end: str) -> Optional[List[str]]:
        """
        Find shortest path between two nodes
        
        Args:
            start: Start node name
            end: End node name
        
        Returns:
            List of node names in path, or None if no path found
        """
        if not self.is_available():
            return None
        
        start_id = self.node_index.get(start)
        end_id = self.node_index.get(end)
        
        if not start_id or not end_id:
            return None
        
        try:
            path = nx.shortest_path(self.graph, start_id, end_id)
            # Convert node IDs to names
            return [self.graph.nodes[node_id].get('name', node_id) for node_id in path]
        except nx.NetworkXNoPath:
            return None
    
    def find_all_paths(self, start: str, end: str, max_length: int = 5) -> List[List[str]]:
        """
        Find all paths between two nodes up to max_length
        
        Args:
            start: Start node name
            end: End node name
            max_length: Maximum path length
        
        Returns:
            List of paths (each path is a list of node names)
        """
        if not self.is_available():
            return []
        
        start_id = self.node_index.get(start)
        end_id = self.node_index.get(end)
        
        if not start_id or not end_id:
            return []
        
        try:
            paths = nx.all_simple_paths(self.graph, start_id, end_id, cutoff=max_length)
            result = []
            for path in paths:
                node_names = [self.graph.nodes[node_id].get('name', node_id) for node_id in path]
                result.append(node_names)
            return result
        except nx.NetworkXNoPath:
            return []
    
    def compute_path_confidence(self, path: List[str]) -> float:
        """
        Compute confidence for a path through the graph
        
        Args:
            path: List of node names
        
        Returns:
            Overall confidence (0.0-1.0)
        """
        if not self.is_available() or len(path) < 2:
            return 0.0
        
        confidence = 1.0
        
        for i in range(len(path) - 1):
            node_id = self.node_index.get(path[i])
            next_id = self.node_index.get(path[i+1])
            
            if node_id and next_id and self.graph.has_edge(node_id, next_id):
                edge_data = self.graph[node_id][next_id]
                
                # Get inference type and apply factor
                inference_type = edge_data.get('inference_type', 'deductive')
                factors = {
                    'deductive': 0.95,
                    'inductive': 0.80,
                    'abductive': 0.70,
                    'analogical': 0.65
                }
                confidence *= factors.get(inference_type, 0.95)
        
        return round(confidence, 4)
    
    def extract_subgraph(self, domain: str) -> Optional[Any]:
        """
        Extract subgraph for a specific domain
        
        Args:
            domain: Domain name
        
        Returns:
            NetworkX subgraph or None
        """
        if not self.is_available():
            return None
        
        # Find all nodes in domain
        domain_nodes = []
        for node_id, data in self.graph.nodes(data=True):
            domains = data.get('domains', [])
            if isinstance(domains, str):
                domains = domains.split(',')
            if domain in domains or data.get('legal_domain') == domain:
                domain_nodes.append(node_id)
        
        if not domain_nodes:
            return None
        
        return self.graph.subgraph(domain_nodes)
    
    def get_node_neighbors(self, node_name: str, direction: str = 'both') -> List[Dict]:
        """
        Get neighbors of a node
        
        Args:
            node_name: Node name
            direction: 'in', 'out', or 'both'
        
        Returns:
            List of neighbor nodes with metadata
        """
        if not self.is_available():
            return []
        
        node_id = self.node_index.get(node_name)
        if not node_id:
            return []
        
        neighbors = []
        
        if direction in ['out', 'both']:
            for neighbor_id in self.graph.successors(node_id):
                neighbor_data = self.graph.nodes[neighbor_id]
                edge_data = self.graph[node_id][neighbor_id]
                neighbors.append({
                    'name': neighbor_data.get('name', neighbor_id),
                    'type': neighbor_data.get('node_type', 'unknown'),
                    'direction': 'outgoing',
                    'edge_type': edge_data.get('edge_type', 'unknown')
                })
        
        if direction in ['in', 'both']:
            for neighbor_id in self.graph.predecessors(node_id):
                neighbor_data = self.graph.nodes[neighbor_id]
                edge_data = self.graph[neighbor_id][node_id]
                neighbors.append({
                    'name': neighbor_data.get('name', neighbor_id),
                    'type': neighbor_data.get('node_type', 'unknown'),
                    'direction': 'incoming',
                    'edge_type': edge_data.get('edge_type', 'unknown')
                })
        
        return neighbors
    
    def find_related_nodes(self, node_name: str, max_distance: int = 2) -> List[Dict]:
        """
        Find all nodes related to a given node within max_distance
        
        Args:
            node_name: Node name
            max_distance: Maximum distance to search
        
        Returns:
            List of related nodes with distances
        """
        if not self.is_available():
            return []
        
        node_id = self.node_index.get(node_name)
        if not node_id:
            return []
        
        # Find all nodes within max_distance
        related = []
        try:
            lengths = nx.single_source_shortest_path_length(
                self.graph.to_undirected(),
                node_id,
                cutoff=max_distance
            )
            
            for target_id, distance in lengths.items():
                if distance > 0:  # Exclude the node itself
                    target_data = self.graph.nodes[target_id]
                    related.append({
                        'name': target_data.get('name', target_id),
                        'type': target_data.get('node_type', 'unknown'),
                        'distance': distance,
                        'confidence': target_data.get('confidence', 0.95)
                    })
            
            # Sort by distance
            related.sort(key=lambda x: x['distance'])
            
        except Exception as e:
            print(f"Error finding related nodes: {e}")
        
        return related
    
    def analyze_node_centrality(self, top_n: int = 10) -> List[Dict]:
        """
        Analyze node centrality to find most important nodes
        
        Args:
            top_n: Number of top nodes to return
        
        Returns:
            List of nodes with centrality scores
        """
        if not self.is_available():
            return []
        
        try:
            # Compute various centrality measures
            degree_centrality = nx.degree_centrality(self.graph)
            betweenness_centrality = nx.betweenness_centrality(self.graph)
            
            # Combine scores
            combined = defaultdict(dict)
            for node_id, score in degree_centrality.items():
                node_data = self.graph.nodes[node_id]
                combined[node_id]['name'] = node_data.get('name', node_id)
                combined[node_id]['type'] = node_data.get('node_type', 'unknown')
                combined[node_id]['degree'] = score
            
            for node_id, score in betweenness_centrality.items():
                combined[node_id]['betweenness'] = score
                # Combined score
                combined[node_id]['centrality'] = (
                    combined[node_id].get('degree', 0) * 0.5 +
                    score * 0.5
                )
            
            # Sort by combined centrality
            results = list(combined.values())
            results.sort(key=lambda x: x.get('centrality', 0), reverse=True)
            
            return results[:top_n]
            
        except Exception as e:
            print(f"Error analyzing centrality: {e}")
            return []
    
    def find_financial_communication_paths(self, entity_id: str) -> List[Dict[str, Any]]:
        """
        Find paths between financial and communication evidence for an entity.

        Locates all financial_record and communication_record nodes associated
        with the given entity and returns the shortest paths connecting them,
        enabling discovery of financial-communication correlations.

        Args:
            entity_id: The entity identifier to search for

        Returns:
            List of dicts, each with 'financial_node', 'communication_node',
            'path' (list of node names), and 'confidence'.
        """
        if not self.is_available():
            return []

        # Collect financial and communication nodes linked to the entity
        financial_nodes = []
        communication_nodes = []

        for node_id, data in self.graph.nodes(data=True):
            node_type = data.get('node_type', '')
            # Match nodes that reference the entity (via entity_ref or entity_id attribute)
            linked_entity = data.get('entity_ref', data.get('entity_id', ''))
            if linked_entity != entity_id:
                continue
            if node_type == 'financial_record':
                financial_nodes.append(node_id)
            elif node_type == 'communication_record':
                communication_nodes.append(node_id)

        # Find shortest paths between each financial-communication pair
        results = []
        for fin_id in financial_nodes:
            for comm_id in communication_nodes:
                try:
                    path = nx.shortest_path(self.graph, fin_id, comm_id)
                    node_names = [
                        self.graph.nodes[nid].get('name', nid) for nid in path
                    ]
                    confidence = self.compute_path_confidence(node_names)
                    results.append({
                        'financial_node': self.graph.nodes[fin_id].get('name', fin_id),
                        'communication_node': self.graph.nodes[comm_id].get('name', comm_id),
                        'path': node_names,
                        'confidence': confidence
                    })
                except nx.NetworkXNoPath:
                    continue

        # Sort by confidence descending
        results.sort(key=lambda x: x['confidence'], reverse=True)
        return results

    def get_temporal_correlations(self, start_date: str, end_date: str) -> List[Dict[str, Any]]:
        """
        Query nodes within a date range and return temporal correlations.

        Finds all nodes whose 'created_at' or 'timestamp' falls within
        [start_date, end_date] and groups them by type, enabling discovery
        of temporal proximity between financial and communication records.

        Args:
            start_date: ISO-format start date (e.g. '2025-01-01')
            end_date:   ISO-format end date   (e.g. '2025-12-31')

        Returns:
            List of dicts with 'node_name', 'node_type', 'timestamp', and any
            'temporal_proximity_edges' linking to other nodes in the range.
        """
        if not self.is_available():
            return []

        try:
            dt_start = datetime.fromisoformat(start_date)
            dt_end = datetime.fromisoformat(end_date)
        except ValueError:
            return []

        # Collect nodes within the date range
        in_range_ids: Set[str] = set()
        in_range_nodes: List[Dict[str, Any]] = []

        for node_id, data in self.graph.nodes(data=True):
            ts_raw = data.get('timestamp', data.get('created_at'))
            if ts_raw is None:
                continue
            try:
                if isinstance(ts_raw, str):
                    ts = datetime.fromisoformat(ts_raw)
                elif isinstance(ts_raw, (int, float)):
                    ts = datetime.fromtimestamp(ts_raw)
                else:
                    continue
            except (ValueError, OSError):
                continue

            if dt_start <= ts <= dt_end:
                in_range_ids.add(node_id)
                in_range_nodes.append({
                    'node_id': node_id,
                    'node_name': data.get('name', node_id),
                    'node_type': data.get('node_type', 'unknown'),
                    'timestamp': ts.isoformat(),
                    'temporal_proximity_edges': []
                })

        # For each in-range node, find temporal_proximity edges to other in-range nodes
        node_lookup = {n['node_id']: n for n in in_range_nodes}
        for node_id in in_range_ids:
            for neighbor_id in self.graph.successors(node_id):
                if neighbor_id not in in_range_ids:
                    continue
                edge_data = self.graph[node_id][neighbor_id]
                if edge_data.get('edge_type') == 'temporal_proximity':
                    node_lookup[node_id]['temporal_proximity_edges'].append({
                        'target': self.graph.nodes[neighbor_id].get('name', neighbor_id),
                        'strength': edge_data.get('strength', 0.0)
                    })

        # Remove internal node_id before returning
        for entry in in_range_nodes:
            del entry['node_id']

        return in_range_nodes

    def get_domain_statistics(self, domain: str) -> Dict[str, Any]:
        """
        Get comprehensive statistics for a domain
        
        Args:
            domain: Domain name
        
        Returns:
            Dictionary with domain statistics
        """
        if not self.is_available():
            return {}
        
        subgraph = self.extract_subgraph(domain)
        if not subgraph:
            return {'error': f'No nodes found for domain: {domain}'}
        
        stats = {
            'domain': domain,
            'node_count': subgraph.number_of_nodes(),
            'edge_count': subgraph.number_of_edges(),
            'node_types': defaultdict(int),
            'average_degree': 0,
            'density': 0
        }
        
        # Count node types
        for node_id, data in subgraph.nodes(data=True):
            node_type = data.get('node_type', 'unknown')
            stats['node_types'][node_type] += 1
        
        # Compute network metrics
        if stats['node_count'] > 0:
            stats['average_degree'] = sum(dict(subgraph.degree()).values()) / stats['node_count']
            stats['density'] = nx.density(subgraph)
        
        stats['node_types'] = dict(stats['node_types'])
        
        return stats


class UnifiedChainLexAPI(ChainLex):
    """
    Unified ChainLex API with enhanced hypergraph integration
    
    Extends the base ChainLex API with advanced hypergraph capabilities.
    """
    
    def __init__(self, base_path: str = ".", load_hypergraph: bool = True):
        """Initialize unified API"""
        super().__init__(base_path, load_hypergraph=False)
        
        # Initialize enhanced hypergraph
        self.enhanced_graph = EnhancedHypergraphAPI(self) if load_hypergraph else None
    
    def find_inference_path(self, start: str, end: str) -> Optional[Dict[str, Any]]:
        """
        Find inference path with full details
        
        Args:
            start: Start node name
            end: End node name
        
        Returns:
            Dictionary with path, confidence, and explanation
        """
        if not self.enhanced_graph or not self.enhanced_graph.is_available():
            # Fallback to simple inference chain
            chain = self.inference.chain(start, end)
            if chain:
                return {
                    'path': [node.get('node', node.get('name')) for node in chain],
                    'confidence': self.inference.confidence(chain),
                    'explanation': self.inference.explain(chain),
                    'method': 'simple'
                }
            return None
        
        # Use hypergraph path finding
        path = self.enhanced_graph.find_path(start, end)
        if path:
            confidence = self.enhanced_graph.compute_path_confidence(path)
            
            # Generate explanation
            explanation = []
            for i, node in enumerate(path):
                explanation.append(f"Level {i+1}: {node}")
                if i < len(path) - 1:
                    explanation.append("   ↓ (inference)")
            
            return {
                'path': path,
                'confidence': confidence,
                'explanation': '\n'.join(explanation),
                'method': 'hypergraph'
            }
        
        return None
    
    def explore_concept(self, concept: str, depth: int = 2) -> Dict[str, Any]:
        """
        Comprehensively explore a legal concept
        
        Args:
            concept: Concept name
            depth: Exploration depth
        
        Returns:
            Dictionary with comprehensive concept information
        """
        result = {
            'concept': concept,
            'search_results': self.search(concept),
            'neighbors': [],
            'related_concepts': [],
            'inference_chains': []
        }
        
        # Add hypergraph information if available
        if self.enhanced_graph and self.enhanced_graph.is_available():
            result['neighbors'] = self.enhanced_graph.get_node_neighbors(concept)
            result['related_concepts'] = self.enhanced_graph.find_related_nodes(concept, depth)
        
        return result


def main():
    """Demo of enhanced hypergraph integration"""
    print("Initializing Unified ChainLex API...")
    api = UnifiedChainLexAPI(load_hypergraph=True)
    
    if not api.enhanced_graph or not api.enhanced_graph.is_available():
        print("\n⚠️  Hypergraph not available. Showing basic API features only.")
        print("\nTo use hypergraph features:")
        print("1. Install NetworkX: pip install networkx")
        print("2. Ensure hypergraph/scmlex_hypergraph.pkl exists")
        return
    
    print("\n" + "="*70)
    print("Example 1: Find Inference Path")
    print("="*70)
    result = api.find_inference_path("pacta-sunt-servanda", "contract-valid?")
    if result:
        print(f"\nMethod: {result['method']}")
        print(f"Path: {' → '.join(result['path'])}")
        print(f"Confidence: {result['confidence']}")
    else:
        print("No path found")
    
    print("\n" + "="*70)
    print("Example 2: Explore a Concept")
    print("="*70)
    exploration = api.explore_concept("contract", depth=1)
    print(f"\nFound {len(exploration['search_results']['rules'])} rules")
    print(f"Found {len(exploration['neighbors'])} neighbors")
    print(f"Found {len(exploration['related_concepts'])} related concepts")
    
    print("\n" + "="*70)
    print("Example 3: Domain Statistics")
    print("="*70)
    stats = api.enhanced_graph.get_domain_statistics("contract")
    if stats:
        print(f"\nDomain: {stats.get('domain', 'unknown')}")
        print(f"Nodes: {stats.get('node_count', 0)}")
        print(f"Edges: {stats.get('edge_count', 0)}")
        print(f"Density: {stats.get('density', 0):.4f}")
    
    print("\n" + "="*70)


if __name__ == "__main__":
    main()
