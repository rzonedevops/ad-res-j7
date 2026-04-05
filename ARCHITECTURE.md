# Lex Framework Architecture

## Overview

The Lex Framework is a comprehensive legal reasoning and analysis system that combines modal logic, multi-head attention mechanisms, evidence-based inference, and grip optimization for legal case analysis.

## Version 1.2.0 Architecture

```
ad-res-j7/
├── lex/                          # Core Lex Framework
│   ├── __init__.py               # Unified exports (v1.2.0)
│   ├── core/                     # Core components
│   │   ├── base.py               # Base types and enums
│   │   ├── unified_attention.py  # Consolidated attention engine (NEW)
│   │   ├── grip_optimizer.py     # Unified grip optimization (NEW)
│   │   └── orchestrator.py       # Skill and entity management
│   ├── attention/                # Legacy attention (backward compat)
│   │   └── engine.py             # Original attention implementation
│   ├── analysis/                 # Case analysis tools
│   │   └── case_analyzer.py      # Case evaluation
│   ├── rules/                    # Jurisdiction-specific rules
│   │   └── south_africa.py       # SA legal rules
│   ├── integration/              # Cross-module integration
│   │   ├── __init__.py           # Integration exports
│   │   ├── cogsim_bridge.py      # CogSim integration
│   │   └── unified_bridge.py     # Cross-language bridge (NEW)
│   └── hypergraph/               # Graph-based reasoning
├── lex-inference-engine/         # Inference engine module
├── db/                           # Database managers
├── tests/                        # Test suite
└── ARCHITECTURE.md               # This file
```

## Core Components

### 1. Unified Legal Attention Engine

**Location:** `lex/core/unified_attention.py`

The canonical attention implementation consolidating:
- `legal_attention_engine.py` (root)
- `lex/attention/engine.py`
- `lex-inference-engine/legal_attention_transform.py`

**Features:**
- 7 specialized legal lenses (Fiduciary, Causation, Necessity, Proportionality, Procedural, Temporal, Evidentiary)
- Multi-dimensional positional encoding (temporal, causal, epistemic, deontic)
- Cross-attention for counterfactual reasoning
- Integrated grip metrics

**Usage:**
```python
from lex import create_attention_engine, LegalElement

engine = create_attention_engine()
engine.add_element(LegalElement(
    element_id="action_001",
    element_type="action",
    content="Defendant transferred funds",
    agent_id="defendant",
    legal_significance=0.9
))
output = engine.compute_attention("action_001", LegalLens.FIDUCIARY)
```

### 2. Unified Grip Optimizer

**Location:** `lex/core/grip_optimizer.py`

Consolidates grip calculation from:
- `legal_attention_grip_optimizer.py`
- `db/grip-manager.js`
- `lex/core/base.py`

**Features:**
- 8 grip dimensions (Relevance, Coherence, Completeness, Confidence, Coverage, Salience, Temporal, Causal)
- Configuration space coverage analysis
- Multiple optimization strategies
- Optimal path generation

**Usage:**
```python
from lex import create_optimizer, GripDimension, WayOfKnowing

optimizer = create_optimizer()
optimizer.add_evidence(
    element_id="doc_001",
    dimension=GripDimension.RELEVANCE,
    score=0.85,
    way_of_knowing=WayOfKnowing.DIRECT_EVIDENCE
)
result = optimizer.optimize(OptimizationStrategy.BALANCE_DIMENSIONS)
```

### 3. Unified Integration Bridge

**Location:** `lex/integration/unified_bridge.py`

Cross-module coordination layer connecting:
- Python attention mechanisms
- JavaScript database managers
- Scheme grammar definitions
- GraphQL hypergraph queries

**Features:**
- Automatic serialization/deserialization
- Cross-language function calls
- Event-driven coordination
- State synchronization

**Usage:**
```python
from lex import create_bridge, BridgeTarget, OperationType

bridge = create_bridge()
result = bridge.execute(
    OperationType.SYNC,
    BridgeTarget.JAVASCRIPT,
    {"data": engine_state}
)
sync_status = bridge.sync_all()
```

## Data Flow

```
┌─────────────────────────────────────────────────────────────────┐
│                     Legal Elements Input                         │
└─────────────────────────────────────────────────────────────────┘
                              │
                              ▼
┌─────────────────────────────────────────────────────────────────┐
│              Unified Legal Attention Engine                      │
│  ┌─────────┐ ┌─────────┐ ┌─────────┐ ┌─────────┐ ┌─────────┐   │
│  │Fiduciary│ │Causation│ │Necessity│ │Temporal │ │Evidentiary│  │
│  └────┬────┘ └────┬────┘ └────┬────┘ └────┬────┘ └────┬────┘   │
│       └───────────┴───────────┴───────────┴───────────┘         │
│                              │                                   │
│                    Attention Scores                              │
└─────────────────────────────────────────────────────────────────┘
                              │
                              ▼
┌─────────────────────────────────────────────────────────────────┐
│                    Grip Optimizer                                │
│  ┌──────────┐ ┌──────────┐ ┌──────────┐ ┌──────────┐           │
│  │Relevance │ │Coherence │ │Coverage  │ │Confidence│           │
│  └────┬─────┘ └────┬─────┘ └────┬─────┘ └────┬─────┘           │
│       └────────────┴────────────┴────────────┘                  │
│                              │                                   │
│                    Grip Assessment                               │
└─────────────────────────────────────────────────────────────────┘
                              │
                              ▼
┌─────────────────────────────────────────────────────────────────┐
│                    Unified Bridge                                │
│  ┌──────────┐ ┌──────────┐ ┌──────────┐ ┌──────────┐           │
│  │JavaScript│ │  Scheme  │ │ GraphQL  │ │ Database │           │
│  └────┬─────┘ └────┬─────┘ └────┬─────┘ └────┬─────┘           │
│       └────────────┴────────────┴────────────┘                  │
│                              │                                   │
│                    Synchronized State                            │
└─────────────────────────────────────────────────────────────────┘
```

## Import Patterns

### Recommended (v1.2.0+)

```python
# Use unified components
from lex import (
    # Attention
    create_attention_engine,
    UnifiedLegalAttentionEngine,
    LegalElement,
    
    # Grip
    create_optimizer,
    GripOptimizer,
    GripDimension,
    
    # Bridge
    create_bridge,
    UnifiedBridge
)

# Or use convenience aliases
from lex import AttentionEngine, Optimizer, Bridge
```

### Legacy (backward compatible)

```python
# Still works for existing code
from lex import (
    LegalLens,
    AttentionOutput,
    LegalAttentionEngine,
    GripAssessment,
    WayOfKnowing
)
```

## Configuration Space Model

The Lex Framework operates on a configuration space defined by:

| Dimension | Description | Components |
|-----------|-------------|------------|
| Agents | Legal actors | Defendants, plaintiffs, witnesses |
| Actions | Legal actions | Transfers, communications, omissions |
| Events | Timeline events | Dated occurrences with causal links |
| Outcomes | Legal outcomes | Liability, damages, remedies |
| Evidence | Supporting evidence | Documents, testimony, expert opinions |

## Grip Dimensions

| Dimension | Weight | Description |
|-----------|--------|-------------|
| Relevance | 1.5 | How relevant is the evidence |
| Completeness | 1.4 | Coverage of required elements |
| Confidence | 1.3 | Certainty of conclusions |
| Causal | 1.3 | Causal chain integrity |
| Coherence | 1.2 | How well elements fit together |
| Coverage | 1.1 | Configuration space coverage |
| Salience | 1.0 | Attention-weighted importance |
| Temporal | 0.9 | Temporal consistency |

## Legal Lenses

| Lens | Focus | Use Case |
|------|-------|----------|
| Fiduciary | Trust and duty | Breach of fiduciary duty |
| Causation | Cause-effect | Establishing liability |
| Necessity | Modal necessity | Essential elements |
| Proportionality | Balance | Reasonableness tests |
| Procedural | Process | Compliance verification |
| Temporal | Time-based | Sequence analysis |
| Evidentiary | Evidence weight | Proof assessment |

## Testing

```bash
# Run Python tests
python -m pytest tests/

# Run JavaScript tests
npm test

# Run unified test suite
python tests/unified_runner.py
```

## Migration Guide

### From v1.0.0 to v1.2.0

1. **Attention Engine**: Replace direct imports with factory functions
   ```python
   # Old
   from legal_attention_engine import LegalAttentionEngine
   
   # New
   from lex import create_attention_engine
   engine = create_attention_engine()
   ```

2. **Grip Optimization**: Use unified optimizer
   ```python
   # Old
   from legal_attention_grip_optimizer import GripOptimizer
   
   # New
   from lex import create_optimizer
   optimizer = create_optimizer()
   ```

3. **Cross-module calls**: Use unified bridge
   ```python
   # New
   from lex import create_bridge
   bridge = create_bridge()
   bridge.sync_all()
   ```

## Contributing

When adding new components:
1. Add to appropriate subdirectory under `lex/`
2. Export from module `__init__.py`
3. Add to main `lex/__init__.py`
4. Update this architecture document
5. Add tests to `tests/`

---

*Architecture document for Lex Framework v1.2.0*
*Last updated: 2026-02-04*
