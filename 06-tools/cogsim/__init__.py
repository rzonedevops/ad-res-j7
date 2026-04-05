"""
CogSim: Multi-Paradigm Simulation Framework for Legal Case Analysis

A Python-based simulation framework implementing three primary modeling paradigms:
- Agent-Based Modeling (ABM)
- Discrete-Event Simulation (DES)
- System Dynamics (SD)

Designed for Case 2025-137857 analysis with hybrid multi-method integration.
"""

__version__ = "1.0.0"
__author__ = "CogPy"

from .core.base import (
    BaseEngine,
    Event,
    EventQueue,
    DataCollector,
    SimulationState,
    EventType,
    LogLevel
)

from .legal_case.entities import (
    Actor,
    ActorRole,
    ActorType,
    Evidence,
    EvidenceType,
    Claim,
    ClaimStatus,
    TimelineEvent,
    CrimeCategory,
    CriminalPhase,
    BurdenOfProof,
    CaseSummary
)

from .abm.agent import (
    ABMEngine,
    LegalCaseAgent,
    PerpetratorAgent,
    VictimAgent,
    AgentState,
    BehaviorType
)

from .des.engine import (
    DESEngine,
    CaseEvent,
    LegalProcess,
    ProcessState
)

from .sd.system_dynamics import (
    SDEngine,
    LegalCaseSDModel,
    Stock,
    Flow,
    Auxiliary,
    Parameter
)

from .hybrid.integration import HybridEngine

__all__ = [
    # Core
    "BaseEngine",
    "Event",
    "EventQueue",
    "DataCollector",
    "SimulationState",
    "EventType",
    "LogLevel",
    
    # Legal Case Entities
    "Actor",
    "ActorRole",
    "ActorType",
    "Evidence",
    "EvidenceType",
    "Claim",
    "ClaimStatus",
    "TimelineEvent",
    "CrimeCategory",
    "CriminalPhase",
    "BurdenOfProof",
    "CaseSummary",
    
    # ABM
    "ABMEngine",
    "LegalCaseAgent",
    "PerpetratorAgent",
    "VictimAgent",
    "AgentState",
    "BehaviorType",
    
    # DES
    "DESEngine",
    "CaseEvent",
    "LegalProcess",
    "ProcessState",
    
    # SD
    "SDEngine",
    "LegalCaseSDModel",
    "Stock",
    "Flow",
    "Auxiliary",
    "Parameter",
    
    # Hybrid
    "HybridEngine"
]
