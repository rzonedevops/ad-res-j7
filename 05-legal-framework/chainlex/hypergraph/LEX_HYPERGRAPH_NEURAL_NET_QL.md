# Lex-HyperGraph-Neural-Net-QL

**Version:** 1.0  
**Date:** October 23, 2025  
**Status:** ✅ Complete

## Overview

**Lex-HyperGraph-Neural-Net-QL** is a neural network-powered legal reasoning system that integrates weighted hypergraph representations with Graph Neural Networks (GNNs) and GraphQL query capabilities. The system enables sophisticated legal reasoning by learning patterns from the legal knowledge graph and providing a flexible query interface.

## Architecture

```
┌─────────────────────────────────────────────────────────────┐
│                    GraphQL Query Layer                       │
│  (example_queries.graphql, graphql_schema.py)               │
└─────────────────────────────────────────────────────────────┘
                          ↓
┌─────────────────────────────────────────────────────────────┐
│              Graph Neural Network Layer                      │
│  (gnn_legal_reasoning.py, LegalGNNModel, LegalGATModel)     │
└─────────────────────────────────────────────────────────────┘
                          ↓
┌─────────────────────────────────────────────────────────────┐
│              Weighted Hypergraph Layer                       │
│  (weighted_hypergraph.pkl, analyze_edge_weights.py)         │
└─────────────────────────────────────────────────────────────┘
                          ↓
┌─────────────────────────────────────────────────────────────┐
│              Original Hypergraph Layer                       │
│  (scmlex_hypergraph.pkl, build_hypergraph.py)               │
└─────────────────────────────────────────────────────────────┘
                          ↓
┌─────────────────────────────────────────────────────────────┐
│              Legal Knowledge Base                            │
│  (known_laws.scm, south_african_*.scm)                      │
└─────────────────────────────────────────────────────────────┘
```

## Key Features

### 1. Weighted Edge Integration ✅

**Problem:** Multiple instances of same-typed edges between nodes create redundancy and complicate analysis.

**Solution:** Aggregate edge repetitions into weighted edges with computed weights based on:
- **Repetition count** - Number of times the edge appears
- **Average confidence** - Mean confidence across all instances
- **Average strength** - Mean strength across all instances
- **Final weight** = repetition_count × avg_confidence × avg_strength

**Implementation:** `analyze_edge_weights.py`

**Results:**
- Original edges: 80
- Weighted edges: 80 (no repetitions in current dataset)
- Weight range: [0.9000, 0.9500]
- Average weight: 0.9131

### 2. Graph Neural Network Architecture ✅

**Models Implemented:**

**a) LegalGNNModel (Graph Convolutional Network)**
- 3 GCN layers with batch normalization
- Hidden dimension: 64
- Dropout: 0.5
- Output: Confidence prediction

**b) LegalGATModel (Graph Attention Network)**
- 3 GAT layers with multi-head attention
- Number of heads: 4
- Dropout: 0.6
- Output: Confidence prediction

**Node Features (6 dimensions):**
1. Node type (one-hot, 4 dims): principle, rule, concept, domain
2. Level (1 dim): Hierarchy level in legal system
3. Confidence (1 dim): Confidence score

**Edge Features (6 dimensions):**
1. Edge type (one-hot, 3 dims): derivation, relationship, domain_membership
2. Weight (1 dim): Computed weighted edge value
3. Repetition count (1 dim): Number of edge instances
4. Average confidence (1 dim): Mean confidence across instances

**Implementation:** `gnn_legal_reasoning.py`

**Training:**
- Loss function: MSE (Mean Squared Error)
- Optimizer: Adam (lr=0.01, weight_decay=5e-4)
- Epochs: 200
- Task: Confidence prediction

### 3. GraphQL Query Interface ✅

**Schema Components:**

**a) LegalNode**
```graphql
type LegalNode {
  id: String!
  name: String
  nodeType: String
  level: Int
  confidence: Float
  domain: String
  jurisdiction: String
  provenance: String
  embedding: [Float]
  predictedConfidence: Float
  reasoningScore: Float
}
```

**b) LegalEdge**
```graphql
type LegalEdge {
  source: String!
  target: String!
  edgeType: String
  weight: Float
  repetitionCount: Int
  avgConfidence: Float
  inferenceTypes: String
  relationshipNames: String
}
```

**c) InferenceChain**
```graphql
type InferenceChain {
  source: String!
  target: String!
  path: [String]
  confidence: Float
  reasoningSteps: [String]
  gnnScore: Float
}
```

**Query Types:**

1. **Node Queries**
   - `node(id)` - Get single node
   - `nodesByType(nodeType)` - Filter by type
   - `nodesByDomain(domain)` - Filter by domain
   - `nodesByJurisdiction(jurisdiction)` - Filter by jurisdiction

2. **Edge Queries**
   - `edgesFromNode(nodeId)` - Outgoing edges
   - `edgesToNode(nodeId)` - Incoming edges
   - `edgesByType(edgeType)` - Filter by type

3. **Inference Queries**
   - `inferenceChain(source, target)` - Find reasoning path
   - `similarNodes(nodeId, limit)` - GNN-powered similarity search

4. **GNN-Powered Queries**
   - `predictConfidence(nodeId)` - Predict node confidence
   - `reasoningScore(source, target)` - Score reasoning link

**Implementation:** `graphql_schema.py`

## Directory Structure

```
hypergraph/
├── LEX_HYPERGRAPH_NEURAL_NET_QL.md    # This file
├── SCHEMA.md                           # Original hypergraph schema
├── README.md                           # Original hypergraph README
│
├── extract_tuples.py                   # Extract entities from .scm files
├── build_hypergraph.py                 # Build original hypergraph
├── query_hypergraph.py                 # Query original hypergraph
├── visualize_hypergraph.py             # Visualize hypergraph
├── db_integration.py                   # Database integration
│
├── analyze_edge_weights.py             # ✨ Weighted edge analysis
├── gnn_legal_reasoning.py              # ✨ GNN implementation
├── graphql_schema.py                   # ✨ GraphQL interface
│
├── weighted/                           # ✨ Weighted hypergraph outputs
│   ├── weighted_hypergraph.pkl         # Weighted graph (pickle)
│   ├── weighted_hypergraph.json        # Weighted graph (JSON)
│   ├── weighted_hypergraph.graphml     # Weighted graph (GraphML)
│   ├── weighted_stats.json             # Weight statistics
│   └── analysis_report.md              # Analysis report
│
├── gnn/                                # ✨ GNN training data
│   ├── node_features.npy               # Node feature matrix
│   ├── edge_index.npy                  # Edge index matrix
│   ├── edge_weights.npy                # Edge weight vector
│   ├── node_mapping.json               # Node ID mapping
│   └── pytorch_data.pt                 # PyTorch Data object (if available)
│
├── graphql/                            # ✨ GraphQL interface
│   ├── README.md                       # GraphQL documentation
│   └── example_queries.graphql         # Example queries
│
├── visualizations/                     # Original visualizations
│   ├── domain_distribution.png
│   ├── node_types.png
│   ├── principle_network.png
│   ├── level_hierarchy.png
│   └── statistics_dashboard.png
│
└── database/                           # Database integration
    ├── schema.sql                      # PostgreSQL schema
    └── sample_queries.sql              # Sample SQL queries
```

## Usage Examples

### 1. Weighted Edge Analysis

```bash
python3 analyze_edge_weights.py \
  /path/to/scmlex_hypergraph.pkl \
  /path/to/output/weighted/
```

**Output:**
- Weighted hypergraph in multiple formats
- Edge weight statistics
- Analysis report

### 2. GNN Training Data Preparation

```bash
python3 gnn_legal_reasoning.py \
  /path/to/weighted_hypergraph.pkl \
  /path/to/output/gnn/
```

**Output:**
- Node feature matrix (NumPy)
- Edge index matrix (NumPy)
- Edge weight vector (NumPy)
- Node mapping (JSON)
- PyTorch Data object (if PyTorch available)

### 3. GraphQL Interface Setup

```bash
python3 graphql_schema.py \
  /path/to/weighted_hypergraph.pkl \
  /path/to/gnn/ \
  /path/to/output/graphql/
```

**Output:**
- GraphQL schema definition
- Example queries
- Documentation

### 4. Example GraphQL Queries

**Find all contract law principles:**
```graphql
query {
  nodesByDomain(domain: "contract") {
    id
    name
    nodeType
    confidence
  }
}
```

**Find inference chain:**
```graphql
query {
  inferenceChain(
    source: "pacta-sunt-servanda",
    target: "contract-valid?"
  ) {
    path
    confidence
    reasoningSteps
  }
}
```

**Find similar principles (GNN-powered):**
```graphql
query {
  similarNodes(
    nodeId: "pacta-sunt-servanda",
    limit: 5
  ) {
    id
    name
    reasoningScore
  }
}
```

## Data Flow

### 1. Ingestion Pipeline

```
.scm files → extract_tuples.py → tuples.json
```

### 2. Hypergraph Construction

```
tuples.json → build_hypergraph.py → scmlex_hypergraph.pkl
```

### 3. Weighted Edge Aggregation

```
scmlex_hypergraph.pkl → analyze_edge_weights.py → weighted_hypergraph.pkl
```

### 4. GNN Feature Extraction

```
weighted_hypergraph.pkl → gnn_legal_reasoning.py → node_features.npy, edge_index.npy
```

### 5. Query Interface

```
weighted_hypergraph.pkl + gnn/ → graphql_schema.py → GraphQL API
```

## Weight Computation Algorithm

```python
def compute_edge_weight(edge_instances):
    """
    Compute weight for aggregated edge
    
    Args:
        edge_instances: List of edge instances between same (source, target, type)
    
    Returns:
        weight: Computed weight value
    """
    repetition_count = len(edge_instances)
    
    # Average confidence across instances
    avg_confidence = sum(e.confidence for e in edge_instances) / repetition_count
    
    # Average strength across instances
    avg_strength = sum(e.strength for e in edge_instances) / repetition_count
    
    # Final weight = count × confidence × strength
    weight = repetition_count * avg_confidence * avg_strength
    
    return weight
```

## GNN Training Algorithm

```python
def train_gnn(data, model, epochs=200, lr=0.01):
    """
    Train GNN for confidence prediction
    
    Args:
        data: PyTorch Geometric Data object
        model: GNN model (LegalGNNModel or LegalGATModel)
        epochs: Number of training epochs
        lr: Learning rate
    
    Returns:
        losses: Training loss history
    """
    optimizer = Adam(model.parameters(), lr=lr, weight_decay=5e-4)
    criterion = MSELoss()
    
    for epoch in range(epochs):
        # Forward pass
        out = model(data.x, data.edge_index, data.edge_attr)
        
        # Compute loss (predict node confidence)
        loss = criterion(out.squeeze(), data.y)
        
        # Backward pass
        optimizer.zero_grad()
        loss.backward()
        optimizer.step()
    
    return losses
```

## Performance Metrics

### Weighted Hypergraph

| Metric | Value |
|:-------|------:|
| Nodes | 2,306 |
| Original Edges | 80 |
| Weighted Edges | 80 |
| Reduction Ratio | 1.0 (no repetitions) |
| Min Weight | 0.9000 |
| Max Weight | 0.9500 |
| Mean Weight | 0.9131 |
| Median Weight | 0.9000 |

### GNN Features

| Metric | Value |
|:-------|------:|
| Node Feature Dim | 6 |
| Edge Feature Dim | 6 |
| Total Nodes | 2,306 |
| Total Edges | 80 |
| Feature Matrix Size | 2,306 × 6 |
| Edge Index Size | 2 × 80 |

### GraphQL API

| Metric | Value |
|:-------|------:|
| Node Query Types | 4 |
| Edge Query Types | 3 |
| Inference Query Types | 2 |
| GNN Query Types | 2 |
| Total Query Types | 11 |

## Integration with Database

The system integrates with PostgreSQL (Neon/Supabase) for persistent storage and querying.

**Schema Tables:**
- `nodes` - Legal nodes (principles, rules, concepts)
- `edges` - Weighted edges with relationships
- `node_embeddings` - GNN-computed embeddings
- `inference_chains` - Pre-computed reasoning paths

**Key Indexes:**
- `nodes(node_type)` - Fast type filtering
- `nodes(domain)` - Fast domain filtering
- `edges(source, target)` - Fast edge lookup
- `node_embeddings(node_id)` - Fast embedding retrieval

See `database/schema.sql` for complete schema.

## Future Enhancements

### 1. Advanced GNN Architectures
- **GraphSAGE** - Inductive learning on large graphs
- **GIN** - Graph Isomorphism Networks for better expressiveness
- **HGT** - Heterogeneous Graph Transformer for multi-type nodes

### 2. Attention Mechanisms
- **Legal Attention** - Learn which principles are most relevant
- **Cross-Domain Attention** - Transfer knowledge across legal domains
- **Temporal Attention** - Account for legal precedent evolution

### 3. Multi-Task Learning
- **Confidence Prediction** - Predict rule confidence
- **Link Prediction** - Predict missing relationships
- **Node Classification** - Classify legal concepts
- **Graph Classification** - Classify legal scenarios

### 4. Explainable AI
- **Attention Visualization** - Show which nodes influence decisions
- **Reasoning Path Extraction** - Extract human-readable reasoning
- **Counterfactual Analysis** - "What if" scenario analysis

### 5. Real-Time Updates
- **Incremental Learning** - Update GNN with new legal rules
- **Online Learning** - Adapt to new case law
- **Transfer Learning** - Apply to new jurisdictions

## Dependencies

### Core Dependencies
- `networkx` - Graph operations
- `numpy` - Numerical computing
- `pickle` - Serialization

### Optional Dependencies
- `torch` - PyTorch for GNN training
- `torch-geometric` - Graph neural network library
- `graphene` - GraphQL schema and queries

### Installation

```bash
# Core dependencies (required)
pip install networkx numpy

# GNN dependencies (optional, for training)
pip install torch torch-geometric

# GraphQL dependencies (optional, for API)
pip install graphene
```

## References

1. **Graph Neural Networks**
   - Kipf & Welling (2017). "Semi-Supervised Classification with Graph Convolutional Networks"
   - Veličković et al. (2018). "Graph Attention Networks"
   - Hamilton et al. (2017). "Inductive Representation Learning on Large Graphs"

2. **Legal AI**
   - Zhong et al. (2020). "JEC-QA: A Legal-Domain Question Answering Dataset"
   - Chalkidis et al. (2019). "Neural Legal Judgment Prediction in English"
   - Xiao et al. (2018). "CAIL2018: A Large-Scale Legal Dataset for Judgment Prediction"

3. **Hypergraph Learning**
   - Feng et al. (2019). "Hypergraph Neural Networks"
   - Yadati et al. (2019). "HyperGCN: A New Method For Training Graph Convolutional Networks on Hypergraphs"

4. **GraphQL**
   - GraphQL Foundation. "GraphQL Specification"
   - Apollo GraphQL. "GraphQL Best Practices"

## License

See repository LICENSE file.

## Contributors

- ChainLex Team
- Manus AI

---

**Last Updated:** October 23, 2025  
**Version:** 1.0  
**Status:** ✅ Production Ready

