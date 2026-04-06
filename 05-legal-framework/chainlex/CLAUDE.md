# CLAUDE.md — ChainLex

## Overview

ChainLex is a legal reasoning framework implementing a multi-level inference system for South African law. It provides hierarchical knowledge representation of legal principles and rules across 8 major legal branches using Scheme-based definitions, hypergraph structures, and a Python API.

## Project Structure

```
chainlex/
├── chainlex_api.py           # Main Python API (ChainLex, PrinciplesAPI, RulesAPI, InferenceAPI)
├── framework_index.py        # Framework indexing and navigation
├── framework_validator.py    # Validates framework consistency
├── domain_helpers.py         # Domain-specific query helpers
├── enhanced_hypergraph.py    # Enhanced hypergraph integration
├── demo.py                   # Demonstration script
├── demo_helpers.py           # Helper utilities for demos
├── test_suite.py             # Comprehensive unit tests (unittest)
├── lv1/                      # Level 1: First-order principles (60+ maxims, core utilities)
├── civ/za/                   # Civil Law (South Africa)
├── cri/za/                   # Criminal Law
├── con/za/                   # Constitutional Law
├── lab/za/                   # Labour Law
├── env/za/                   # Environmental Law
├── adm/za/                   # Administrative Law
├── cst/za/                   # Construction Law
├── int/za/                   # International Law
├── hypergraph/               # Graph-based legal reasoning subsystem
│   ├── build_hypergraph.py   # Build NetworkX hypergraph from Scheme files
│   ├── query_hypergraph.py   # Query and traversal interface
│   ├── extract_tuples.py     # Extract entities from Scheme files
│   ├── visualize_hypergraph.py
│   ├── gnn_legal_reasoning.py # Graph Neural Network models (GCN, GAT)
│   ├── graphql_schema.py     # GraphQL query interface
│   └── db_integration.py     # PostgreSQL/Supabase integration
├── exports/                  # Export utilities
└── framework_index.json      # Pre-built index of all frameworks
```

## Languages

- **Python 3.6+** — Primary implementation (~2,700 LOC)
- **Scheme** — Legal knowledge representation (22 `.scm` files)

## Key Commands

```bash
# Run tests
python3 test_suite.py

# Run demo
python3 demo.py

# Rebuild framework index
python3 framework_index.py

# Validate framework consistency
python3 framework_validator.py

# Use the API
python3 chainlex_api.py
```

## Dependencies

Core library uses Python standard library only (`json`, `pathlib`, `typing`, `re`, `pickle`, `unittest`).

Optional dependencies for advanced features:
- `networkx` — hypergraph building/queries
- `torch` — GNN models
- `sqlalchemy` / `psycopg2` — PostgreSQL integration

## Architecture

### Multi-Level Inference
- **Level 1**: First-order legal principles (60+ maxims in `lv1/known_laws.scm`)
- **Level 2+**: Derived rules across 8 jurisdictional domains
- Rules chain from principles through confidence-based inference

### Legal Domains
8 branches of South African law, each in its own directory with Scheme definitions:
`civ`, `cri`, `con`, `lab`, `env`, `adm`, `cst`, `int`

### Hypergraph System
Graph-based representation of legal knowledge with 2,300+ nodes, supporting NetworkX traversal, Neo4j export, and GNN-based reasoning.

## Key Statistics

| Metric | Count |
|--------|-------|
| Legal Nodes | 2,306 |
| Level 1 Principles | 63 |
| Level 2+ Rules | 2,215+ |
| Legal Domains | 28+ |
| Scheme Files | 22 |

## Conventions

- Legal rules are defined as Scheme S-expressions with structured headers
- Each framework file includes metadata: domain, level, confidence scores
- The `framework_index.json` maps all rules for fast lookup
- Python API follows a layered pattern: `ChainLex` → `PrinciplesAPI` / `RulesAPI` / `InferenceAPI`
