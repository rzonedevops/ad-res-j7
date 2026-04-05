# CogSim: Multi-Paradigm Legal Case Simulation Framework

A Python-based simulation framework implementing three primary modeling paradigms for legal case analysis: **Agent-Based Modeling (ABM)**, **Discrete-Event Simulation (DES)**, and **System Dynamics (SD)**.

## Overview

CogSim is designed for comprehensive legal case analysis, specifically developed for **Case 2025-137857** (Peter Faucitt v. Jacqueline Faucitt et al.). The framework enables:

- **Monte Carlo simulation** of case outcomes
- **Timeline-based event processing** from forensic evidence
- **Agent behavior modeling** for perpetrators and victims
- **Financial flow analysis** using system dynamics
- **Evidence strength calculation** and burden of proof analysis

## Architecture

```
cogsim/
├── core/                 # Core simulation components
│   └── base.py          # Base engine, events, data collection
├── abm/                  # Agent-Based Modeling
│   └── agent.py         # Legal case agents (perpetrators, victims)
├── des/                  # Discrete-Event Simulation
│   └── engine.py        # Timeline event processing
├── sd/                   # System Dynamics
│   └── system_dynamics.py  # Financial flows, evidence accumulation
├── hybrid/               # Hybrid Integration
│   └── integration.py   # Combined multi-paradigm engine
├── legal_case/           # Legal Case Entities
│   └── entities.py      # Actors, evidence, claims, timeline events
└── examples/             # Example simulations
    └── legal_case_simulation.py
```

## Key Features

### 1. Agent-Based Modeling (ABM)

Models individual actors and their behaviors:

- **PerpetratorAgent**: Criminal behavior patterns, fund diversion, evidence destruction
- **VictimAgent**: Fraud discovery, evidence collection, legal responses
- **State transitions**: IDLE → EXECUTING → COVERING_UP → DEFENDING

### 2. Discrete-Event Simulation (DES)

Processes timeline events chronologically:

- **Event scheduling** based on forensic timeline data
- **Criminal phase tracking**: Foundation → Structure → Expansion → Infiltration → Escalation → Positioning → Coverup
- **Evidence generation** from timeline events
- **Financial impact calculation**

### 3. System Dynamics (SD)

Models aggregate-level dynamics:

- **Stocks**: Total losses, evidence strength, case strength, culpability
- **Flows**: Revenue theft rate, fund diversion rate, evidence accumulation/destruction
- **Numerical integration**: Euler and RK4 methods

### 4. Hybrid Integration

Combines all three paradigms:

- **ABM → SD coupling**: Agent actions affect system dynamics
- **DES → SD coupling**: Timeline events trigger system changes
- **SD → ABM coupling**: System state influences agent behavior

## Usage

### Basic Simulation

```python
from cogsim.hybrid.integration import HybridEngine
from datetime import datetime
import json

# Load forensic data
with open('forensic-events-data.json', 'r') as f:
    forensic_data = json.load(f)

# Initialize engine
engine = HybridEngine(
    name='Case 2025-137857 Simulation',
    seed=42,
    start_date=datetime(2017, 1, 1)
)

# Load case data
engine.load_case_data(forensic_data)

# Run Monte Carlo simulation
results = engine.run_monte_carlo(iterations=100)

print(f"Outcomes: {results['outcomes']}")
print(f"Criminal Referrals: {results['criminal_referrals']}")
```

### Running the Example

```bash
cd ad-res-j7
python3 -m cogsim.examples.legal_case_simulation
```

## Case 2025-137857 Results

Based on 100 Monte Carlo iterations:

| Metric | Value |
|--------|-------|
| **Application Dismissed with Costs** | 100% |
| **Criminal Referrals** | 100% |
| **Applicant Success Rate** | 0.00% |
| **Respondent Success Rate** | 100.00% |
| **Criminal Referral Likelihood** | 86.00% |

### Total Losses Documented

| Category | Amount |
|----------|--------|
| Revenue Theft | R3,141,647.70 |
| Trust Violations | R2,851,247.35 |
| Financial Fraud | R4,276,832.85 |
| **Total** | **R10,269,727.90** |

## Evidence Categories

The simulation processes evidence with weighted credibility:

- **Third-party documentary** (0.95 weight): Shopify emails, bank records
- **Medical documentary** (0.90 weight): Medical records refuting dementia claims
- **Chronological analysis** (0.85 weight): Timeline evidence of destruction
- **Financial documentary** (0.88 weight): Bank statements, accounting records

## Criminal Phases Modeled

1. **Foundation (2017)**: Legitimate business establishment
2. **Structure (2019-2020)**: Complex financial structure creation
3. **Expansion (2020)**: International expansion during COVID-19
4. **Infiltration (2022)**: Automation and staff infiltration
5. **Escalation (2023)**: Debt accumulation, workplace incidents
6. **Positioning (2024)**: Authority positioning, trustee conflicts
7. **Coverup (2025)**: Evidence destruction, legal warfare

## Dependencies

- Python 3.11+
- Standard library only (no external dependencies)

## License

Part of the ad-res-j7 evidence repository for Case 2025-137857.

## References

- [Forensic Events Data](../forensic-events-data.json)
- [Case Hypergraph Schema](../schema.graphql)
- [Evidence Package](../ANNEXURES/)
