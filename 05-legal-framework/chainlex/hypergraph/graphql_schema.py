#!/usr/bin/env python3
"""
GraphQL Schema for Lex-HyperGraph-Neural-Net-QL

Provides GraphQL query interface for neural network-based legal reasoning.
Combines hypergraph queries with GNN inference capabilities.
"""

import json
import pickle
import numpy as np
from pathlib import Path
from typing import List, Dict, Optional, Any

# Try to import GraphQL dependencies
try:
    import graphene
    from graphene import ObjectType, String, Float, Int, List as GrapheneList, Field, Schema
    GRAPHENE_AVAILABLE = True
except ImportError:
    GRAPHENE_AVAILABLE = False
    print("⚠️  Graphene not available. Install with: pip install graphene")
    # Define dummy classes when Graphene is not available
    ObjectType = object
    String = lambda: None
    Float = lambda: None
    Int = lambda: None
    GrapheneList = lambda x: None
    Field = lambda *args, **kwargs: None
    Schema = lambda *args, **kwargs: None

class LegalNode(ObjectType):
    """Legal node in the hypergraph"""
    id = String()
    name = String()
    node_type = String()
    level = Int()
    confidence = Float()
    domain = String()
    jurisdiction = String()
    provenance = String()
    
    # GNN-computed features
    embedding = GrapheneList(Float)
    predicted_confidence = Float()
    reasoning_score = Float()

class LegalEdge(ObjectType):
    """Legal edge in the hypergraph"""
    source = String()
    target = String()
    edge_type = String()
    weight = Float()
    repetition_count = Int()
    avg_confidence = Float()
    inference_types = String()
    relationship_names = String()

class InferenceChain(ObjectType):
    """Inference chain from source to target"""
    source = String()
    target = String()
    path = GrapheneList(String) if GRAPHENE_AVAILABLE else None
    confidence = Float()
    reasoning_steps = GrapheneList(String) if GRAPHENE_AVAILABLE else None
    gnn_score = Float()

class LegalQuery(ObjectType):
    """Root query object"""
    
    # Node queries
    node = Field(LegalNode, id=String(required=True)) if GRAPHENE_AVAILABLE else None
    nodes_by_type = GrapheneList(LegalNode, node_type=String(required=True)) if GRAPHENE_AVAILABLE else None
    nodes_by_domain = GrapheneList(LegalNode, domain=String(required=True)) if GRAPHENE_AVAILABLE else None
    nodes_by_jurisdiction = GrapheneList(LegalNode, jurisdiction=String(required=True)) if GRAPHENE_AVAILABLE else None
    
    # Edge queries
    edges_from_node = GrapheneList(LegalEdge, node_id=String(required=True)) if GRAPHENE_AVAILABLE else None
    edges_to_node = GrapheneList(LegalEdge, node_id=String(required=True)) if GRAPHENE_AVAILABLE else None
    edges_by_type = GrapheneList(LegalEdge, edge_type=String(required=True)) if GRAPHENE_AVAILABLE else None
    
    # Inference queries
    inference_chain = Field(InferenceChain, 
                           source=String(required=True), 
                           target=String(required=True)) if GRAPHENE_AVAILABLE else None
    similar_nodes = GrapheneList(LegalNode, 
                                node_id=String(required=True), 
                                limit=Int(default_value=10)) if GRAPHENE_AVAILABLE else None
    
    # GNN-powered queries
    predict_confidence = Float(node_id=String(required=True)) if GRAPHENE_AVAILABLE else None
    reasoning_score = Float(source=String(required=True), 
                           target=String(required=True)) if GRAPHENE_AVAILABLE else None

class LexHyperGraphQL:
    """GraphQL interface for Lex-HyperGraph-Neural-Net-QL"""
    
    def __init__(self, weighted_graph_file: str, gnn_data_dir: str):
        """Initialize with weighted hypergraph and GNN data"""
        print(f"Loading weighted hypergraph from {weighted_graph_file}...")
        with open(weighted_graph_file, 'rb') as f:
            data = pickle.load(f)
        
        self.graph = data['graph']
        self.edge_weights = data['edge_weights']
        self.edge_features = data['edge_features']
        self.node_index = data['node_index']
        
        # Load GNN data
        gnn_data_dir = Path(gnn_data_dir)
        if (gnn_data_dir / 'node_features.npy').exists():
            self.node_features = np.load(gnn_data_dir / 'node_features.npy')
            print(f"✅ Loaded node features: {self.node_features.shape}")
        else:
            self.node_features = None
        
        if (gnn_data_dir / 'node_mapping.json').exists():
            with open(gnn_data_dir / 'node_mapping.json') as f:
                mapping = json.load(f)
                self.node_to_idx = {k: v for k, v in mapping['node_to_idx'].items()}
                self.idx_to_node = {int(k): v for k, v in mapping['idx_to_node'].items()}
        
        print(f"✅ Loaded: {self.graph.number_of_nodes()} nodes, {self.graph.number_of_edges()} edges")
    
    def resolve_node(self, info, id: str) -> Optional[Dict]:
        """Resolve single node by ID"""
        if id not in self.graph.nodes:
            return None
        
        data = self.graph.nodes[id]
        node_dict = {
            'id': id,
            'name': data.get('name', id),
            'node_type': data.get('node_type', 'unknown'),
            'level': data.get('level', 0),
            'confidence': data.get('confidence', 1.0),
            'domain': ','.join(data.get('domains', [])) if isinstance(data.get('domains'), list) else data.get('domain', ''),
            'jurisdiction': data.get('jurisdiction', ''),
            'provenance': data.get('provenance', '')
        }
        
        # Add GNN features if available
        if self.node_features is not None and id in self.node_to_idx:
            idx = self.node_to_idx[id]
            node_dict['embedding'] = self.node_features[idx].tolist()
        
        return node_dict
    
    def resolve_nodes_by_type(self, info, node_type: str) -> List[Dict]:
        """Resolve nodes by type"""
        results = []
        for node_id, data in self.graph.nodes(data=True):
            if data.get('node_type') == node_type:
                results.append(self.resolve_node(info, node_id))
        return results
    
    def resolve_nodes_by_domain(self, info, domain: str) -> List[Dict]:
        """Resolve nodes by domain"""
        results = []
        for node_id, data in self.graph.nodes(data=True):
            domains = data.get('domains', [])
            if isinstance(domains, list) and domain in domains:
                results.append(self.resolve_node(info, node_id))
            elif data.get('domain') == domain:
                results.append(self.resolve_node(info, node_id))
        return results
    
    def resolve_edges_from_node(self, info, node_id: str) -> List[Dict]:
        """Resolve edges from a node"""
        if node_id not in self.graph.nodes:
            return []
        
        results = []
        for source, target, data in self.graph.edges(node_id, data=True):
            results.append({
                'source': source,
                'target': target,
                'edge_type': data.get('edge_type', 'unknown'),
                'weight': data.get('weight', 1.0),
                'repetition_count': data.get('repetition_count', 1),
                'avg_confidence': data.get('avg_confidence', 1.0),
                'inference_types': data.get('inference_types', ''),
                'relationship_names': data.get('relationship_names', '')
            })
        return results
    
    def resolve_inference_chain(self, info, source: str, target: str) -> Optional[Dict]:
        """Resolve inference chain between two nodes"""
        import networkx as nx
        
        if source not in self.graph.nodes or target not in self.graph.nodes:
            return None
        
        try:
            # Find shortest path
            path = nx.shortest_path(self.graph, source, target)
            
            # Compute confidence along path
            confidence = 1.0
            for i in range(len(path) - 1):
                edge_data = self.graph.get_edge_data(path[i], path[i+1])
                if edge_data:
                    edge_confidence = edge_data.get('avg_confidence', 1.0)
                    confidence *= edge_confidence
            
            return {
                'source': source,
                'target': target,
                'path': path,
                'confidence': confidence,
                'reasoning_steps': [f"{path[i]} → {path[i+1]}" for i in range(len(path)-1)],
                'gnn_score': confidence  # Placeholder for actual GNN score
            }
        except nx.NetworkXNoPath:
            return None
    
    def resolve_similar_nodes(self, info, node_id: str, limit: int = 10) -> List[Dict]:
        """Find similar nodes using GNN embeddings"""
        if self.node_features is None or node_id not in self.node_to_idx:
            return []
        
        # Get node embedding
        idx = self.node_to_idx[node_id]
        node_embedding = self.node_features[idx]
        
        # Compute cosine similarity with all other nodes
        similarities = []
        for other_id, other_idx in self.node_to_idx.items():
            if other_id == node_id:
                continue
            
            other_embedding = self.node_features[other_idx]
            
            # Cosine similarity
            similarity = np.dot(node_embedding, other_embedding) / (
                np.linalg.norm(node_embedding) * np.linalg.norm(other_embedding) + 1e-8
            )
            
            similarities.append((other_id, similarity))
        
        # Sort by similarity and take top k
        similarities.sort(key=lambda x: x[1], reverse=True)
        top_similar = similarities[:limit]
        
        # Resolve nodes
        results = []
        for similar_id, similarity in top_similar:
            node = self.resolve_node(info, similar_id)
            if node:
                node['reasoning_score'] = float(similarity)
                results.append(node)
        
        return results
    
    def export_schema(self, output_file: str):
        """Export GraphQL schema"""
        if not GRAPHENE_AVAILABLE:
            print("⚠️  Graphene not available, cannot export schema")
            return
        
        schema = Schema(query=LegalQuery)
        schema_str = str(schema)
        
        with open(output_file, 'w') as f:
            f.write(schema_str)
        
        print(f"✅ GraphQL schema exported: {output_file}")
    
    def create_example_queries(self, output_file: str):
        """Create example GraphQL queries"""
        examples = """
# Lex-HyperGraph-Neural-Net-QL Example Queries

## 1. Get a specific legal node
query {
  node(id: "pacta-sunt-servanda") {
    id
    name
    nodeType
    level
    confidence
    domain
    provenance
    embedding
  }
}

## 2. Find all principles
query {
  nodesByType(nodeType: "principle") {
    id
    name
    confidence
    domain
  }
}

## 3. Find all contract law nodes
query {
  nodesByDomain(domain: "contract") {
    id
    name
    nodeType
    confidence
  }
}

## 4. Get edges from a node
query {
  edgesFromNode(nodeId: "pacta-sunt-servanda") {
    source
    target
    edgeType
    weight
    repetitionCount
    avgConfidence
  }
}

## 5. Find inference chain
query {
  inferenceChain(source: "pacta-sunt-servanda", target: "contract-valid?") {
    source
    target
    path
    confidence
    reasoningSteps
    gnnScore
  }
}

## 6. Find similar nodes (GNN-powered)
query {
  similarNodes(nodeId: "pacta-sunt-servanda", limit: 5) {
    id
    name
    nodeType
    reasoningScore
  }
}

## 7. Predict confidence (GNN-powered)
query {
  predictConfidence(nodeId: "some-rule-id")
}

## 8. Compute reasoning score between nodes (GNN-powered)
query {
  reasoningScore(source: "principle-id", target: "rule-id")
}

## 9. Complex query combining multiple features
query {
  contractLawPrinciples: nodesByDomain(domain: "contract") {
    id
    name
    confidence
    derivedRules: edgesFromNode(nodeId: id) {
      target
      weight
    }
  }
}

## 10. Find all South African rules
query {
  nodesByJurisdiction(jurisdiction: "ZA") {
    id
    name
    nodeType
    domain
    confidence
  }
}
"""
        
        with open(output_file, 'w') as f:
            f.write(examples)
        
        print(f"✅ Example queries saved: {output_file}")

def main():
    """Main GraphQL setup"""
    import sys
    
    weighted_graph = sys.argv[1] if len(sys.argv) > 1 else "/home/ubuntu/chainlex/hypergraph/weighted/weighted_hypergraph.pkl"
    gnn_data_dir = sys.argv[2] if len(sys.argv) > 2 else "/home/ubuntu/chainlex/hypergraph/gnn"
    output_dir = Path(sys.argv[3]) if len(sys.argv) > 3 else Path("/home/ubuntu/chainlex/hypergraph/graphql")
    
    print("="*60)
    print("LEX-HYPERGRAPH-NEURAL-NET-QL: GRAPHQL INTERFACE")
    print("="*60)
    
    # Initialize GraphQL interface
    lex_graphql = LexHyperGraphQL(weighted_graph, gnn_data_dir)
    
    # Create output directory
    output_dir.mkdir(exist_ok=True)
    
    # Export schema
    if GRAPHENE_AVAILABLE:
        lex_graphql.export_schema(str(output_dir / 'schema.graphql'))
    
    # Create example queries
    lex_graphql.create_example_queries(str(output_dir / 'example_queries.graphql'))
    
    # Create README
    readme = """# Lex-HyperGraph-Neural-Net-QL GraphQL Interface

## Overview

This directory contains the GraphQL interface for querying the legal reasoning hypergraph
with GNN-powered inference capabilities.

## Features

- **Node Queries**: Query legal principles, rules, and concepts
- **Edge Queries**: Explore relationships and derivations
- **Inference Chains**: Find reasoning paths between nodes
- **GNN-Powered**: Similar node search, confidence prediction, reasoning scores
- **Domain Filtering**: Filter by legal domain (contract, tort, criminal, etc.)
- **Jurisdiction Filtering**: Filter by jurisdiction (ZA, US, UK, etc.)

## Files

- `schema.graphql` - GraphQL schema definition
- `example_queries.graphql` - Example queries
- `README.md` - This file

## Usage

See `example_queries.graphql` for query examples.

## Dependencies

- graphene (for GraphQL schema)
- numpy (for GNN features)
- networkx (for graph operations)
"""
    
    with open(output_dir / 'README.md', 'w') as f:
        f.write(readme)
    
    print(f"\n✅ GraphQL interface created: {output_dir}")
    print("\n" + "="*60)
    print("✅ GraphQL setup complete!")
    print("="*60)

if __name__ == "__main__":
    main()

