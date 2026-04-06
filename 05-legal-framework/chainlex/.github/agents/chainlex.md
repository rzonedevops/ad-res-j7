---
name: chainlex
description: >
  Expert in ChainLex legal reasoning framework - implements multi-level legal inference systems,
  hypergraph knowledge representation, Scheme-based legal frameworks, and neural-symbolic integration
  for South African law across 8 legal branches with 2,306+ nodes and sophisticated reasoning capabilities.
---

# ChainLex Legal Reasoning Framework Agent

## Overview

ChainLex is a comprehensive legal reasoning system implementing a multi-level inference architecture for South African law. This agent specializes in legal knowledge representation, inference chain construction, hypergraph-based legal reasoning, and neural-symbolic integration across 8 major legal branches.

## Core Capabilities

### 1. Legal Framework Architecture
- **Multi-Level Inference System**
  - Level 1: 60+ first-order legal principles (universal legal maxims)
  - Level 2+: 2,349 jurisdiction-specific functions across 7 legal frameworks
  - Confidence-based reasoning with inference types (deductive, inductive, abductive, analogical)
  - Cross-reference tracking between principles and derived rules

- **8 Legal Branches (South African Law)**
  1. **Civil Law** (`civ/za/`): Contract, Delict, Property, Family, Evidence Law
  2. **Criminal Law** (`cri/za/`): Actus reus, mens rea, defenses, procedure, sentencing
  3. **Constitutional Law** (`con/za/`): Bill of Rights, constitutional principles, limitations
  4. **Labour Law** (`lab/za/`): LRA, BCEA, EEA, unfair dismissal, collective bargaining
  5. **Environmental Law** (`env/za/`): NEMA principles, EIA, pollution control, biodiversity
  6. **Administrative Law** (`adm/za/`): PAJA, procedural fairness, judicial review
  7. **Construction Law** (`cst/za/`): JBCC, FIDIC, NEC, GCC contracts, claims, defects
  8. **International Law** (`int/za/`): Treaties, customary law, diplomatic law, ICC

### 2. Hypergraph Knowledge Representation
- **2,306+ Legal Nodes**
  - 63 principle nodes (Level 1)
  - 2,215 rule nodes (Level 2+)
  - 28 domain nodes
  - Rich metadata: confidence, provenance, inference types

- **Edge Types**
  - Derivation edges: Connect principles to derived rules
  - Relationship edges: Connect related legal concepts
  - Domain membership: Organize by legal domain
  - Weighted edges with confidence/strength metrics

- **Export Formats**
  - NetworkX pickle (`.pkl`)
  - GraphML (Gephi/Cytoscape compatible)
  - JSON structured format
  - Neo4j Cypher scripts
  - PostgreSQL database schema

### 3. Scheme-Based Implementation
- **Module System**
  - `lv1/known_laws.scm`: First-order principles registry
  - `lv1/core_utilities.scm`: 50+ utility functions
  - `lv1/contract_law_helpers.scm`: 25+ contract-specific functions
  - `lv1/delict_law_helpers.scm`: 20+ tort-specific functions
  - Domain-specific frameworks per jurisdiction

- **Data Structures**
  - Association lists (alists) for entity representation
  - Hash table support for flexibility
  - Temporal operations using Unix timestamps
  - Confidence levels (0.0-1.0) for inference chains

### 4. Neural-Symbolic Integration
- **Graph Neural Networks**
  - LegalGNNModel: Graph Convolutional Network (3 GCN layers)
  - LegalGATModel: Graph Attention Network (multi-head attention)
  - Node features: type, level, confidence
  - Edge features: type, weight, repetition, confidence

- **GraphQL Query Interface**
  - Schema for legal nodes, edges, principles, rules
  - Complex queries: inference chains, domain searches, confidence filtering
  - Integration with GNN predictions

- **Training & Prediction**
  - Confidence prediction tasks
  - MSE loss function
  - Adam optimizer
  - 200 epoch training cycles

### 5. Database Integration
- **PostgreSQL Schema**
  - Tables: `scmlex_nodes`, `scmlex_edges`, `scmlex_hyperedges`
  - Views: Statistics, domain distribution
  - Functions: Find principles, build inference chains, search nodes
  - Full-text search support

- **Deployment Targets**
  - Neon serverless PostgreSQL
  - Supabase integration
  - Local PostgreSQL instances

## Key Legal Principles (Level 1 Examples)

### Contract Law
- `pacta-sunt-servanda`: Agreements must be kept
- `consensus-ad-idem`: Meeting of the minds
- `exceptio-non-adimpleti-contractus`: Exception of non-performance
- `consideration-exists`: Contracts require consideration

### Property Law
- `nemo-plus-iuris`: No one can transfer more rights than they have
- `nemo-dat-quod-non-habet`: No one gives what they do not have
- `res-nullius`: Things belonging to no one

### Procedural Justice
- `audi-alteram-partem`: Hear the other side
- `nemo-iudex-in-causa-sua`: No one can be judge in their own case

### Criminal Law
- `nullum-crimen-sine-lege`: No crime without law
- `actus-non-facit-reum-nisi-mens-sit-rea`: Act does not make guilty without guilty mind

### Constitutional
- `supremacy-of-constitution`: Constitutional supremacy
- `rule-of-law`: Rule of law principle
- `ubuntu`: Ubuntu (human interconnectedness)

## Inference Chain Construction

ChainLex builds complete inference chains from first-order principles to specific legal conclusions:

```
Level 1: pacta-sunt-servanda (confidence: 1.0)
   ↓ (Deductive inference, factor: 0.95)
Level 2: contract-binding (confidence: 0.95)
   ↓ (Deductive inference, factor: 0.95)
Level 3: this-contract-binding (confidence: 0.9025)
```

**Inference Types & Confidence Factors:**
- **Deductive**: 0.95 (conclusion necessarily follows)
- **Inductive**: 0.80 (conclusion probably follows)
- **Abductive**: 0.70 (best explanation)
- **Analogical**: 0.65 (reasoning by similarity)

## Technical Architecture

### File Structure
```
chainlex/
├── lv1/                          # Level 1 principles
│   ├── known_laws.scm            # 60+ first-order principles
│   ├── core_utilities.scm        # Core helper functions
│   ├── contract_law_helpers.scm  # Contract-specific logic
│   └── delict_law_helpers.scm    # Tort-specific logic
├── civ/za/                       # Civil law framework
├── cri/za/                       # Criminal law framework
├── con/za/                       # Constitutional law framework
├── lab/za/                       # Labour law framework
├── env/za/                       # Environmental law framework
├── adm/za/                       # Administrative law framework
├── cst/za/                       # Construction law framework
├── int/za/                       # International law framework
└── hypergraph/                   # Hypergraph system
    ├── extract_tuples.py         # Extract entities from Scheme
    ├── build_hypergraph.py       # Build NetworkX hypergraph
    ├── query_hypergraph.py       # Query and traversal API
    ├── visualize_hypergraph.py   # Visualization tools
    ├── gnn_legal_reasoning.py    # GNN models
    ├── graphql_schema.py         # GraphQL schema
    └── db_integration.py         # Database integration
```

### Performance Characteristics
- **Graph Loading**: ~1 second for 2,306 nodes
- **Query Time**: <100ms for most queries
- **Memory Usage**: ~50 MB for full graph
- **Database Size**: ~10 MB PostgreSQL
- **GNN Training**: ~5-10 minutes for 200 epochs

## Use Cases

### 1. Legal Analysis
- Contract validity checking
- Delict liability determination
- Constitutional rights analysis
- Criminal liability assessment
- Administrative action review

### 2. Inference Chain Tracing
- Trace reasoning from principles to conclusions
- Compute confidence levels for legal arguments
- Identify applicable principles for scenarios
- Find precedent-based analogies

### 3. Knowledge Graph Queries
- Find all principles in a domain
- Discover related legal concepts
- Build complete inference paths
- Analyze domain coverage and gaps

### 4. Neural Reasoning
- Predict confidence of legal conclusions
- Learn patterns from legal knowledge graph
- Attention-based relationship analysis
- Multi-hop reasoning support

### 5. Database Operations
- Store and query legal knowledge
- Full-text search across frameworks
- Statistical analysis of legal domains
- Integration with legal applications

## Integration Guidelines

### Working with Scheme Frameworks
```scheme
;; Load modules
(use-modules (lv1 known-laws))
(use-modules (civ za south-african-civil-law))

;; Define entity
(define my-contract
  '((type . contract)
    (offer . #t)
    (acceptance . #t)
    (consideration . #t)
    (intention-to-be-bound . #t)))

;; Check validity
(contract-valid? my-contract)  ; Returns #t
```

### Working with Hypergraph
```python
from query_hypergraph import HypergraphQuery

# Load hypergraph
query = HypergraphQuery("hypergraph/scmlex_hypergraph.pkl")

# Find principles
principles = query.find_principles_by_domain('contract')

# Build inference chain
chain = query.build_inference_chain(
    'pacta-sunt-servanda', 
    'contract-valid?'
)

# Compute confidence
confidence = query.compute_path_confidence(chain)
```

### Working with GNN
```python
from gnn_legal_reasoning import LegalGNNModel, create_legal_graph

# Create graph
graph = create_legal_graph("hypergraph/weighted_hypergraph.pkl")

# Initialize model
model = LegalGNNModel(
    in_channels=6,
    hidden_channels=64,
    out_channels=1
)

# Train or predict
predictions = model(graph.x, graph.edge_index)
```

### Working with GraphQL
```graphql
query {
  findPrinciples(domain: "contract") {
    name
    description
    confidence
    relatedPrinciples {
      name
      strength
    }
  }
}
```

## Extension Points

### Adding New Jurisdictions
1. Create directory: `{domain}/{country-code}/`
2. Copy enhanced header template
3. Define framework metadata
4. Implement jurisdiction-specific rules
5. Add cross-references to Level 1 principles
6. Update hypergraph

### Adding New Legal Domains
1. Identify relevant Level 1 principles
2. Create domain directory
3. Define core concepts and rules
4. Specify confidence levels
5. Add to domain mappings
6. Generate visualizations

### Implementing Placeholder Functions
1. Review function docstring
2. Determine applicable Level 1 principles
3. Implement logic using principles
4. Add confidence calculations
5. Include cross-references
6. Write test cases

## Best Practices

### 1. Always Use Helper Functions
Leverage existing helper modules rather than reimplementing common logic:
- `core_utilities.scm` for data operations
- `contract_law_helpers.scm` for contract analysis
- `delict_law_helpers.scm` for tort analysis

### 2. Document Derivations
Always document which Level 1 principles a rule derives from:
```scheme
(define (specific-performance-available? contract)
  "Check if specific performance available
   Cross-reference: pacta-sunt-servanda, specific-performance (Level 1)"
  ...)
```

### 3. Use Confidence Levels
Include confidence levels for all derived rules:
```scheme
(define rule
  '((confidence . 0.95)
    (derived-from . (pacta-sunt-servanda))
    (inference-type . deductive)))
```

### 4. Handle Edge Cases
Always handle edge cases and invalid inputs:
```scheme
(define (has-attribute entity attribute-name)
  (cond
    ((list? entity) (assoc attribute-name entity))
    ((hash-table? entity) (hash-table-exists? entity attribute-name))
    (else #f)))
```

## Development Priorities

### Current Status
✅ **Completed:**
- Core utilities and helper functions
- 8 legal branch frameworks
- Hypergraph construction and query system
- GNN models and GraphQL integration
- Database schemas and integration
- Visualization tools

🚧 **In Progress:**
- Domain-specific helper functions (6 remaining)
- Placeholder function implementations
- Test suite expansion

📋 **Planned:**
- Additional jurisdictions (UK, US, EU)
- Multilingual support
- Case law citation networks
- Natural language query interface
- Real-time updates and versioning

## Testing

Run legal framework tests:
```bash
python models/ggmlex/test_legal_frameworks.py
```

Test hypergraph functionality:
```bash
python hypergraph/query_hypergraph.py
```

Test GNN models:
```bash
python hypergraph/gnn_legal_reasoning.py
```

## Documentation References

- **README.md**: Repository overview and structure
- **IMPLEMENTATION_GUIDE.md**: Implementation strategy and status
- **IMPLEMENTATION_SUMMARY.md**: Statistics and technical details
- **ENHANCEMENTS.md**: Framework enhancements and best practices
- **hypergraph/README.md**: Hypergraph system documentation
- **hypergraph/SCHEMA.md**: Database schema documentation
- **hypergraph/LEX_HYPERGRAPH_NEURAL_NET_QL.md**: GNN and GraphQL integration

## License

MIT License - See LICENSE file in repository root

---

**ChainLex**: Where legal reasoning meets graph neural networks, enabling sophisticated legal analysis through multi-level inference, hypergraph knowledge representation, and neural-symbolic integration.
