#!/usr/bin/env python3
"""
Graph Neural Network for Legal Reasoning (Lex-HyperGraph-Neural-Net-QL)

Implements a GNN architecture for learning legal reasoning patterns from the weighted hypergraph.
Uses message passing to propagate information through the legal knowledge graph.
"""

import json
import pickle
import numpy as np
import networkx as nx
from pathlib import Path
from typing import Dict, List, Tuple, Optional
from collections import defaultdict

# Try to import PyTorch (optional dependency)
try:
    import torch
    import torch.nn as nn
    import torch.nn.functional as F
    from torch_geometric.nn import GCNConv, GATConv, SAGEConv
    from torch_geometric.data import Data
    TORCH_AVAILABLE = True
except ImportError:
    TORCH_AVAILABLE = False
    print("⚠️  PyTorch not available. Install with: pip install torch torch-geometric")

class LegalReasoningGNN:
    """Graph Neural Network for legal reasoning on weighted hypergraph"""
    
    def __init__(self, weighted_graph_file: str):
        """Load weighted hypergraph"""
        print(f"Loading weighted hypergraph from {weighted_graph_file}...")
        with open(weighted_graph_file, 'rb') as f:
            data = pickle.load(f)
        
        self.graph = data['graph']
        self.edge_weights = data['edge_weights']
        self.edge_features = data['edge_features']
        self.node_index = data['node_index']
        
        # Create node ID mapping
        self.node_to_idx = {node: idx for idx, node in enumerate(self.graph.nodes())}
        self.idx_to_node = {idx: node for node, idx in self.node_to_idx.items()}
        
        print(f"✅ Loaded: {self.graph.number_of_nodes()} nodes, {self.graph.number_of_edges()} edges")
    
    def extract_node_features(self) -> np.ndarray:
        """Extract node feature matrix"""
        print("\nExtracting node features...")
        
        num_nodes = self.graph.number_of_nodes()
        feature_dim = 6  # [node_type(4), level(1), confidence(1)]
        
        features = np.zeros((num_nodes, feature_dim))
        
        for node, idx in self.node_to_idx.items():
            data = self.graph.nodes[node]
            node_type = data.get('node_type', 'unknown')
            level = data.get('level', 0)
            confidence = data.get('confidence', 1.0)
            
            # One-hot encode node type
            type_encoding = {
                'principle': [1, 0, 0, 0],
                'rule': [0, 1, 0, 0],
                'concept': [0, 0, 1, 0],
                'domain': [0, 0, 0, 1]
            }.get(node_type, [0, 0, 0, 0])
            
            features[idx] = type_encoding + [level, confidence]
        
        print(f"  Feature matrix: {features.shape}")
        return features
    
    def extract_edge_index(self) -> Tuple[np.ndarray, np.ndarray]:
        """Extract edge index and edge weights"""
        print("\nExtracting edge index...")
        
        edge_list = []
        edge_weights = []
        
        for source, target, data in self.graph.edges(data=True):
            source_idx = self.node_to_idx[source]
            target_idx = self.node_to_idx[target]
            weight = data.get('weight', 1.0)
            
            edge_list.append([source_idx, target_idx])
            edge_weights.append(weight)
        
        edge_index = np.array(edge_list).T  # Shape: [2, num_edges]
        edge_weights = np.array(edge_weights)
        
        print(f"  Edge index: {edge_index.shape}")
        print(f"  Edge weights: {edge_weights.shape}")
        
        return edge_index, edge_weights
    
    def create_pytorch_data(self) -> Optional['Data']:
        """Create PyTorch Geometric Data object"""
        if not TORCH_AVAILABLE:
            print("⚠️  PyTorch not available, skipping PyTorch data creation")
            return None
        
        print("\nCreating PyTorch Geometric Data...")
        
        # Extract features
        node_features = self.extract_node_features()
        edge_index, edge_weights = self.extract_edge_index()
        
        # Convert to PyTorch tensors
        x = torch.FloatTensor(node_features)
        edge_index_tensor = torch.LongTensor(edge_index)
        edge_weight_tensor = torch.FloatTensor(edge_weights)
        
        # Create labels (for supervised learning)
        # Label: confidence level of each node
        y = torch.FloatTensor([
            self.graph.nodes[self.idx_to_node[idx]].get('confidence', 1.0)
            for idx in range(len(self.idx_to_node))
        ])
        
        # Create Data object
        data = Data(
            x=x,
            edge_index=edge_index_tensor,
            edge_attr=edge_weight_tensor.unsqueeze(1),
            y=y
        )
        
        print(f"  ✅ PyTorch Data created")
        print(f"     Nodes: {data.num_nodes}")
        print(f"     Edges: {data.num_edges}")
        print(f"     Features: {data.num_node_features}")
        
        return data
    
    def export_for_training(self, output_dir: Path):
        """Export data for GNN training"""
        print("\nExporting for GNN training...")
        
        output_dir = Path(output_dir)
        output_dir.mkdir(exist_ok=True)
        
        # Extract features
        node_features = self.extract_node_features()
        edge_index, edge_weights = self.extract_edge_index()
        
        # Save as numpy arrays
        np.save(output_dir / 'node_features.npy', node_features)
        np.save(output_dir / 'edge_index.npy', edge_index)
        np.save(output_dir / 'edge_weights.npy', edge_weights)
        
        print(f"  ✅ Numpy arrays: {output_dir}")
        
        # Save node mapping
        with open(output_dir / 'node_mapping.json', 'w') as f:
            json.dump({
                'node_to_idx': {str(k): v for k, v in self.node_to_idx.items()},
                'idx_to_node': {str(k): v for k, v in self.idx_to_node.items()}
            }, f, indent=2)
        
        print(f"  ✅ Node mapping: {output_dir / 'node_mapping.json'}")
        
        # Create PyTorch data if available
        if TORCH_AVAILABLE:
            data = self.create_pytorch_data()
            if data is not None:
                torch.save(data, output_dir / 'pytorch_data.pt')
                print(f"  ✅ PyTorch data: {output_dir / 'pytorch_data.pt'}")

class LegalGNNModel(nn.Module if TORCH_AVAILABLE else object):
    """GNN model for legal reasoning"""
    
    def __init__(self, input_dim: int, hidden_dim: int, output_dim: int, num_layers: int = 3):
        if not TORCH_AVAILABLE:
            raise ImportError("PyTorch is required for GNN model")
        
        super().__init__()
        
        self.num_layers = num_layers
        
        # Graph convolution layers
        self.convs = nn.ModuleList()
        self.convs.append(GCNConv(input_dim, hidden_dim))
        for _ in range(num_layers - 2):
            self.convs.append(GCNConv(hidden_dim, hidden_dim))
        self.convs.append(GCNConv(hidden_dim, output_dim))
        
        # Batch normalization
        self.batch_norms = nn.ModuleList()
        for _ in range(num_layers - 1):
            self.batch_norms.append(nn.BatchNorm1d(hidden_dim))
        
        # Dropout
        self.dropout = nn.Dropout(0.5)
    
    def forward(self, x, edge_index, edge_weight=None):
        """Forward pass"""
        for i in range(self.num_layers - 1):
            x = self.convs[i](x, edge_index, edge_weight)
            x = self.batch_norms[i](x)
            x = F.relu(x)
            x = self.dropout(x)
        
        # Final layer (no activation)
        x = self.convs[-1](x, edge_index, edge_weight)
        
        return x

class LegalGATModel(nn.Module if TORCH_AVAILABLE else object):
    """Graph Attention Network for legal reasoning"""
    
    def __init__(self, input_dim: int, hidden_dim: int, output_dim: int, num_heads: int = 4, num_layers: int = 3):
        if not TORCH_AVAILABLE:
            raise ImportError("PyTorch is required for GAT model")
        
        super().__init__()
        
        self.num_layers = num_layers
        
        # Graph attention layers
        self.convs = nn.ModuleList()
        self.convs.append(GATConv(input_dim, hidden_dim, heads=num_heads, dropout=0.6))
        for _ in range(num_layers - 2):
            self.convs.append(GATConv(hidden_dim * num_heads, hidden_dim, heads=num_heads, dropout=0.6))
        self.convs.append(GATConv(hidden_dim * num_heads, output_dim, heads=1, concat=False, dropout=0.6))
    
    def forward(self, x, edge_index):
        """Forward pass"""
        for i in range(self.num_layers - 1):
            x = self.convs[i](x, edge_index)
            x = F.elu(x)
        
        # Final layer
        x = self.convs[-1](x, edge_index)
        
        return x

def train_gnn_model(data: 'Data', model, epochs: int = 200, lr: float = 0.01):
    """Train GNN model"""
    if not TORCH_AVAILABLE:
        print("⚠️  PyTorch not available, skipping training")
        return None
    
    print(f"\nTraining GNN model for {epochs} epochs...")
    
    optimizer = torch.optim.Adam(model.parameters(), lr=lr, weight_decay=5e-4)
    criterion = nn.MSELoss()
    
    model.train()
    losses = []
    
    for epoch in range(epochs):
        optimizer.zero_grad()
        
        # Forward pass
        out = model(data.x, data.edge_index, data.edge_attr)
        
        # Compute loss
        loss = criterion(out.squeeze(), data.y)
        
        # Backward pass
        loss.backward()
        optimizer.step()
        
        losses.append(loss.item())
        
        if (epoch + 1) % 20 == 0:
            print(f"  Epoch {epoch+1}/{epochs}, Loss: {loss.item():.4f}")
    
    print(f"  ✅ Training complete")
    print(f"     Final loss: {losses[-1]:.4f}")
    
    return losses

def main():
    """Main GNN pipeline"""
    import sys
    
    input_file = sys.argv[1] if len(sys.argv) > 1 else "/home/ubuntu/chainlex/hypergraph/weighted/weighted_hypergraph.pkl"
    output_dir = Path(sys.argv[2]) if len(sys.argv) > 2 else Path("/home/ubuntu/chainlex/hypergraph/gnn")
    
    print("="*60)
    print("LEX-HYPERGRAPH-NEURAL-NET-QL: GNN FOR LEGAL REASONING")
    print("="*60)
    
    # Initialize GNN
    gnn = LegalReasoningGNN(input_file)
    
    # Export for training
    gnn.export_for_training(output_dir)
    
    # Train model if PyTorch is available
    if TORCH_AVAILABLE:
        print("\n" + "="*60)
        print("TRAINING GNN MODEL")
        print("="*60)
        
        # Load data
        data = torch.load(output_dir / 'pytorch_data.pt')
        
        # Create model
        model = LegalGNNModel(
            input_dim=data.num_node_features,
            hidden_dim=64,
            output_dim=1,
            num_layers=3
        )
        
        print(f"\nModel architecture:")
        print(model)
        
        # Train
        losses = train_gnn_model(data, model, epochs=200, lr=0.01)
        
        # Save model
        torch.save(model.state_dict(), output_dir / 'legal_gnn_model.pt')
        print(f"\n✅ Model saved: {output_dir / 'legal_gnn_model.pt'}")
        
        # Save training losses
        np.save(output_dir / 'training_losses.npy', np.array(losses))
    
    print("\n" + "="*60)
    print("✅ GNN pipeline complete!")
    print(f"   Output directory: {output_dir}")
    print("="*60)

if __name__ == "__main__":
    main()

