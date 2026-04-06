#!/usr/bin/env python3
"""
Weighted Edge Analysis for Lex-HyperGraph-Neural-Net-QL

Analyzes edge repetitions and aggregates them into weighted edges for GNN training.
Multiple instances of same-typed edges between nodes are combined with weights.
"""

import json
import pickle
import networkx as nx
from pathlib import Path
from typing import Dict, List, Tuple, Set
from collections import defaultdict, Counter

class WeightedEdgeAnalyzer:
    """Analyze and aggregate edge repetitions into weighted edges"""
    
    def __init__(self, hypergraph_file: str):
        """Load existing hypergraph"""
        print(f"Loading hypergraph from {hypergraph_file}...")
        with open(hypergraph_file, 'rb') as f:
            data = pickle.load(f)
        
        self.graph = data['graph']
        self.hyperedges = data['hyperedges']
        self.node_index = data['node_index']
        
        # Initialize weighted graph
        self.weighted_graph = nx.MultiDiGraph()
        
        # Edge statistics
        self.edge_repetitions = defaultdict(list)
        self.edge_weights = {}
        self.edge_features = {}
        
        print(f"✅ Loaded: {self.graph.number_of_nodes()} nodes, {self.graph.number_of_edges()} edges")
    
    def analyze_edge_repetitions(self):
        """Analyze repetitions of same-typed edges between node pairs"""
        print("\nAnalyzing edge repetitions...")
        
        # Group edges by (source, target, edge_type)
        edge_groups = defaultdict(list)
        
        for source, target, key, data in self.graph.edges(keys=True, data=True):
            edge_type = data.get('edge_type', 'unknown')
            edge_key = (source, target, edge_type)
            edge_groups[edge_key].append(data)
        
        # Analyze repetitions
        repetition_stats = {
            'total_edge_groups': len(edge_groups),
            'repeated_edges': 0,
            'max_repetitions': 0,
            'total_repetitions': 0
        }
        
        for edge_key, edges in edge_groups.items():
            count = len(edges)
            self.edge_repetitions[edge_key] = edges
            
            if count > 1:
                repetition_stats['repeated_edges'] += 1
                repetition_stats['total_repetitions'] += count
                repetition_stats['max_repetitions'] = max(repetition_stats['max_repetitions'], count)
        
        print(f"  Total edge groups: {repetition_stats['total_edge_groups']}")
        print(f"  Repeated edges: {repetition_stats['repeated_edges']}")
        print(f"  Max repetitions: {repetition_stats['max_repetitions']}")
        print(f"  Total repetitions: {repetition_stats['total_repetitions']}")
        
        return repetition_stats
    
    def compute_edge_weights(self):
        """Compute weights for edges based on repetitions and features"""
        print("\nComputing edge weights...")
        
        for edge_key, edges in self.edge_repetitions.items():
            source, target, edge_type = edge_key
            
            # Base weight: count of repetitions (normalized)
            repetition_count = len(edges)
            base_weight = repetition_count
            
            # Feature-based weights
            confidence_sum = sum(e.get('confidence_impact', 1.0) for e in edges)
            strength_sum = sum(e.get('strength', 1.0) for e in edges)
            
            # Compute final weight
            # Weight = repetition_count × avg_confidence × avg_strength
            avg_confidence = confidence_sum / repetition_count if repetition_count > 0 else 1.0
            avg_strength = strength_sum / repetition_count if repetition_count > 0 else 1.0
            
            final_weight = base_weight * avg_confidence * avg_strength
            
            # Store weight
            self.edge_weights[edge_key] = {
                'weight': final_weight,
                'repetition_count': repetition_count,
                'avg_confidence': avg_confidence,
                'avg_strength': avg_strength,
                'normalized_weight': final_weight / max(1, repetition_count)
            }
            
            # Extract features for GNN
            self.edge_features[edge_key] = {
                'edge_type': edge_type,
                'repetition_count': repetition_count,
                'avg_confidence': avg_confidence,
                'avg_strength': avg_strength,
                'inference_types': [e.get('inference_type', 'unknown') for e in edges],
                'relationship_names': [e.get('relationship_name', 'unknown') for e in edges]
            }
        
        print(f"  Computed weights for {len(self.edge_weights)} edge groups")
        
        # Statistics
        weights = [w['weight'] for w in self.edge_weights.values()]
        if weights:
            print(f"  Weight range: [{min(weights):.4f}, {max(weights):.4f}]")
            print(f"  Average weight: {sum(weights)/len(weights):.4f}")
    
    def build_weighted_graph(self):
        """Build weighted graph with aggregated edges"""
        print("\nBuilding weighted graph...")
        
        # Copy all nodes
        for node_id, data in self.graph.nodes(data=True):
            self.weighted_graph.add_node(node_id, **data)
        
        # Add weighted edges
        for edge_key, weight_data in self.edge_weights.items():
            source, target, edge_type = edge_key
            features = self.edge_features[edge_key]
            
            # Add single weighted edge instead of multiple edges
            self.weighted_graph.add_edge(
                source,
                target,
                edge_type=edge_type,
                weight=weight_data['weight'],
                repetition_count=weight_data['repetition_count'],
                avg_confidence=weight_data['avg_confidence'],
                avg_strength=weight_data['avg_strength'],
                normalized_weight=weight_data['normalized_weight'],
                inference_types=','.join(set(features['inference_types'])),
                relationship_names=','.join(set(features['relationship_names']))
            )
        
        print(f"  Nodes: {self.weighted_graph.number_of_nodes()}")
        print(f"  Weighted edges: {self.weighted_graph.number_of_edges()}")
        print(f"  Reduction: {self.graph.number_of_edges()} → {self.weighted_graph.number_of_edges()}")
    
    def extract_gnn_features(self):
        """Extract features for Graph Neural Network"""
        print("\nExtracting GNN features...")
        
        node_features = {}
        edge_features_list = []
        
        # Node features
        for node_id, data in self.weighted_graph.nodes(data=True):
            node_type = data.get('node_type', 'unknown')
            level = data.get('level', 0)
            confidence = data.get('confidence', 1.0)
            
            # One-hot encode node type
            node_type_encoding = {
                'principle': [1, 0, 0, 0],
                'rule': [0, 1, 0, 0],
                'concept': [0, 0, 1, 0],
                'domain': [0, 0, 0, 1]
            }.get(node_type, [0, 0, 0, 0])
            
            # Create feature vector
            features = node_type_encoding + [level, confidence]
            
            node_features[node_id] = {
                'features': features,
                'node_type': node_type,
                'level': level,
                'confidence': confidence
            }
        
        # Edge features
        for source, target, data in self.weighted_graph.edges(data=True):
            edge_type = data.get('edge_type', 'unknown')
            weight = data.get('weight', 1.0)
            repetition_count = data.get('repetition_count', 1)
            avg_confidence = data.get('avg_confidence', 1.0)
            
            # One-hot encode edge type
            edge_type_encoding = {
                'derivation': [1, 0, 0],
                'relationship': [0, 1, 0],
                'domain_membership': [0, 0, 1]
            }.get(edge_type, [0, 0, 0])
            
            # Create feature vector
            features = edge_type_encoding + [weight, repetition_count, avg_confidence]
            
            edge_features_list.append({
                'source': source,
                'target': target,
                'features': features,
                'edge_type': edge_type,
                'weight': weight
            })
        
        print(f"  Node features: {len(node_features)} nodes × {len(next(iter(node_features.values()))['features'])} features")
        print(f"  Edge features: {len(edge_features_list)} edges × {len(edge_features_list[0]['features']) if edge_features_list else 0} features")
        
        return node_features, edge_features_list
    
    def export_weighted_graph(self, output_dir: Path):
        """Export weighted graph in multiple formats"""
        print("\nExporting weighted graph...")
        
        output_dir = Path(output_dir)
        output_dir.mkdir(exist_ok=True)
        
        # Export as pickle
        weighted_data = {
            'graph': self.weighted_graph,
            'edge_weights': self.edge_weights,
            'edge_features': self.edge_features,
            'node_index': self.node_index
        }
        
        with open(output_dir / 'weighted_hypergraph.pkl', 'wb') as f:
            pickle.dump(weighted_data, f)
        print(f"  ✅ Pickle: {output_dir / 'weighted_hypergraph.pkl'}")
        
        # Export as JSON
        json_data = {
            'nodes': [],
            'edges': []
        }
        
        for node_id, data in self.weighted_graph.nodes(data=True):
            node_dict = {'id': node_id}
            node_dict.update({k: v for k, v in data.items() if not isinstance(v, (list, dict))})
            json_data['nodes'].append(node_dict)
        
        for source, target, data in self.weighted_graph.edges(data=True):
            edge_dict = {'source': source, 'target': target}
            edge_dict.update({k: v for k, v in data.items() if not isinstance(v, (list, dict))})
            json_data['edges'].append(edge_dict)
        
        with open(output_dir / 'weighted_hypergraph.json', 'w') as f:
            json.dump(json_data, f, indent=2)
        print(f"  ✅ JSON: {output_dir / 'weighted_hypergraph.json'}")
        
        # Export as GraphML (convert lists to strings)
        graph_copy = self.weighted_graph.copy()
        for node, data in graph_copy.nodes(data=True):
            for key, value in list(data.items()):
                if isinstance(value, list):
                    data[key] = ','.join(str(v) for v in value)
        for u, v, data in graph_copy.edges(data=True):
            for key, value in list(data.items()):
                if isinstance(value, list):
                    data[key] = ','.join(str(v) for v in value)
        nx.write_graphml(graph_copy, str(output_dir / 'weighted_hypergraph.graphml'))
        print(f"  ✅ GraphML: {output_dir / 'weighted_hypergraph.graphml'}")
        
        # Export statistics
        stats = {
            'nodes': self.weighted_graph.number_of_nodes(),
            'edges': self.weighted_graph.number_of_edges(),
            'original_edges': self.graph.number_of_edges(),
            'reduction_ratio': self.weighted_graph.number_of_edges() / max(1, self.graph.number_of_edges()),
            'weight_statistics': {
                'min': min(w['weight'] for w in self.edge_weights.values()),
                'max': max(w['weight'] for w in self.edge_weights.values()),
                'mean': sum(w['weight'] for w in self.edge_weights.values()) / len(self.edge_weights),
                'median': sorted(w['weight'] for w in self.edge_weights.values())[len(self.edge_weights)//2]
            }
        }
        
        with open(output_dir / 'weighted_stats.json', 'w') as f:
            json.dump(stats, f, indent=2)
        print(f"  ✅ Statistics: {output_dir / 'weighted_stats.json'}")
    
    def generate_report(self, output_file: str):
        """Generate analysis report"""
        print(f"\nGenerating report: {output_file}")
        
        report = []
        report.append("# Weighted Edge Analysis Report")
        report.append(f"\n## Overview\n")
        report.append(f"- **Original Edges:** {self.graph.number_of_edges()}")
        report.append(f"- **Weighted Edges:** {self.weighted_graph.number_of_edges()}")
        report.append(f"- **Reduction:** {(1 - self.weighted_graph.number_of_edges()/max(1, self.graph.number_of_edges()))*100:.1f}%")
        
        report.append(f"\n## Edge Weight Distribution\n")
        weights = sorted([w['weight'] for w in self.edge_weights.values()])
        report.append(f"- **Min Weight:** {min(weights):.4f}")
        report.append(f"- **Max Weight:** {max(weights):.4f}")
        report.append(f"- **Mean Weight:** {sum(weights)/len(weights):.4f}")
        report.append(f"- **Median Weight:** {weights[len(weights)//2]:.4f}")
        
        report.append(f"\n## Top 10 Weighted Edges\n")
        top_edges = sorted(self.edge_weights.items(), key=lambda x: x[1]['weight'], reverse=True)[:10]
        for (source, target, edge_type), weight_data in top_edges:
            source_name = self.graph.nodes[source].get('name', source)[:30]
            target_name = self.graph.nodes[target].get('name', target)[:30]
            report.append(f"- **{source_name}** → **{target_name}** ({edge_type})")
            report.append(f"  - Weight: {weight_data['weight']:.4f}")
            report.append(f"  - Repetitions: {weight_data['repetition_count']}")
            report.append(f"  - Avg Confidence: {weight_data['avg_confidence']:.4f}")
        
        with open(output_file, 'w') as f:
            f.write('\n'.join(report))
        
        print(f"  ✅ Report saved")

def main():
    """Main analysis pipeline"""
    import sys
    
    input_file = sys.argv[1] if len(sys.argv) > 1 else "/home/ubuntu/chainlex/hypergraph/scmlex_hypergraph.pkl"
    output_dir = Path(sys.argv[2]) if len(sys.argv) > 2 else Path("/home/ubuntu/chainlex/hypergraph/weighted")
    
    print("="*60)
    print("WEIGHTED EDGE ANALYSIS FOR LEX-HYPERGRAPH-NEURAL-NET-QL")
    print("="*60)
    
    # Initialize analyzer
    analyzer = WeightedEdgeAnalyzer(input_file)
    
    # Analyze edge repetitions
    analyzer.analyze_edge_repetitions()
    
    # Compute weights
    analyzer.compute_edge_weights()
    
    # Build weighted graph
    analyzer.build_weighted_graph()
    
    # Extract GNN features
    node_features, edge_features = analyzer.extract_gnn_features()
    
    # Export
    analyzer.export_weighted_graph(output_dir)
    
    # Generate report
    analyzer.generate_report(str(output_dir / "analysis_report.md"))
    
    print("\n" + "="*60)
    print("✅ Weighted edge analysis complete!")
    print(f"   Output directory: {output_dir}")
    print("="*60)

if __name__ == "__main__":
    main()

