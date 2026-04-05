"""
CogSim Agent-Based Modeling Module
Simulates actor behaviors and interactions in the legal case.
"""

from dataclasses import dataclass, field
from typing import List, Dict, Optional, Set, Callable, Any, Tuple
from enum import Enum, auto
import random
import math

from ..core.base import BaseEngine, Event, EventType, DataCollector, LogLevel
from ..legal_case.entities import (
    Actor, ActorRole, ActorType, Evidence, Claim, 
    TimelineEvent, CrimeCategory, CriminalPhase
)


# =============================================================================
# Agent States and Behaviors
# =============================================================================

class AgentState(Enum):
    """Possible states for an agent."""
    IDLE = auto()
    PLANNING = auto()
    EXECUTING = auto()
    COVERING_UP = auto()
    COOPERATING = auto()
    DEFENDING = auto()
    FLEEING = auto()


class BehaviorType(Enum):
    """Types of agent behaviors."""
    LEGITIMATE = auto()
    FRAUDULENT = auto()
    DEFENSIVE = auto()
    AGGRESSIVE = auto()
    COOPERATIVE = auto()
    EVASIVE = auto()


# =============================================================================
# Legal Case Agent
# =============================================================================

@dataclass
class LegalCaseAgent:
    """
    Agent representing an actor in the legal case simulation.
    Implements behavior patterns based on evidence and timeline.
    """
    agent_id: str
    name: str
    actor: Actor
    
    # State
    state: AgentState = AgentState.IDLE
    behavior_type: BehaviorType = BehaviorType.LEGITIMATE
    
    # Position (for visualization)
    x: float = 0.0
    y: float = 0.0
    
    # Attributes
    risk_tolerance: float = 0.5  # 0-1 scale
    coordination_level: float = 0.5  # 0-1 scale
    evidence_awareness: float = 0.5  # 0-1 awareness of evidence against them
    
    # Resources
    financial_resources: float = 0.0
    legal_resources: float = 0.0
    
    # Relationships
    allies: List[str] = field(default_factory=list)
    adversaries: List[str] = field(default_factory=list)
    
    # History
    actions_taken: List[Dict] = field(default_factory=list)
    evidence_destroyed: List[str] = field(default_factory=list)
    
    # Metrics
    culpability_score: float = 0.0
    credibility_score: float = 0.5
    
    def decide_action(self, context: Dict) -> str:
        """Decide next action based on current state and context."""
        if self.state == AgentState.COVERING_UP:
            return self._covering_up_action(context)
        elif self.state == AgentState.DEFENDING:
            return self._defensive_action(context)
        elif self.state == AgentState.EXECUTING:
            return self._executing_action(context)
        else:
            return "wait"
    
    def _covering_up_action(self, context: Dict) -> str:
        """Actions when in cover-up mode."""
        if self.evidence_awareness > 0.7:
            return "destroy_evidence"
        elif self.coordination_level > 0.5:
            return "coordinate_with_allies"
        else:
            return "hide_assets"
    
    def _defensive_action(self, context: Dict) -> str:
        """Actions when in defensive mode."""
        if self.legal_resources > 0.5:
            return "file_legal_action"
        else:
            return "deny_allegations"
    
    def _executing_action(self, context: Dict) -> str:
        """Actions when executing a plan."""
        if self.risk_tolerance > 0.7:
            return "aggressive_action"
        else:
            return "cautious_action"
    
    def update_state(self, new_state: AgentState) -> None:
        """Update agent state."""
        self.state = new_state
    
    def record_action(self, action: str, time: float, details: Dict = None) -> None:
        """Record an action taken by the agent."""
        self.actions_taken.append({
            "action": action,
            "time": time,
            "details": details or {}
        })
    
    def calculate_culpability(self, evidence_list: List[Evidence]) -> float:
        """Calculate culpability based on evidence."""
        score = 0.0
        for evidence in evidence_list:
            if self.agent_id in evidence.refutes_claims:
                score += evidence.calculate_effective_weight() * 0.2
        self.culpability_score = min(1.0, score)
        return self.culpability_score


# =============================================================================
# Perpetrator Agent (Specialized)
# =============================================================================

@dataclass
class PerpetratorAgent(LegalCaseAgent):
    """
    Specialized agent for perpetrators in the case.
    Models criminal behavior patterns.
    """
    # Criminal enterprise attributes
    criminal_phase: CriminalPhase = CriminalPhase.FOUNDATION
    escalation_level: int = 1
    
    # Fraud-specific
    diverted_funds: float = 0.0
    destroyed_evidence_count: int = 0
    
    # Control
    accounts_controlled: List[str] = field(default_factory=list)
    systems_controlled: List[str] = field(default_factory=list)
    
    # Conspiracy
    conspiracy_members: List[str] = field(default_factory=list)
    
    def escalate_criminal_activity(self) -> None:
        """Escalate to next criminal phase."""
        phases = list(CriminalPhase)
        current_idx = phases.index(self.criminal_phase)
        if current_idx < len(phases) - 1:
            self.criminal_phase = phases[current_idx + 1]
            self.escalation_level = min(10, self.escalation_level + 1)
    
    def divert_funds(self, amount: float, source: str, destination: str) -> Dict:
        """Record fund diversion."""
        self.diverted_funds += amount
        return {
            "type": "fund_diversion",
            "amount": amount,
            "source": source,
            "destination": destination
        }
    
    def destroy_evidence(self, evidence_id: str) -> Dict:
        """Record evidence destruction."""
        self.destroyed_evidence_count += 1
        self.evidence_destroyed.append(evidence_id)
        return {
            "type": "evidence_destruction",
            "evidence_id": evidence_id
        }


# =============================================================================
# Victim Agent (Specialized)
# =============================================================================

@dataclass
class VictimAgent(LegalCaseAgent):
    """
    Specialized agent for victims in the case.
    Models response to criminal activity.
    """
    # Losses
    financial_losses: float = 0.0
    reputational_damage: float = 0.0
    
    # Discovery
    fraud_discovery_date: Optional[float] = None
    evidence_collected: List[str] = field(default_factory=list)
    
    # Response
    has_reported_to_authorities: bool = False
    has_filed_civil_action: bool = False
    
    def discover_fraud(self, time: float) -> None:
        """Record fraud discovery."""
        self.fraud_discovery_date = time
        self.state = AgentState.DEFENDING
    
    def collect_evidence(self, evidence_id: str) -> None:
        """Collect evidence."""
        if evidence_id not in self.evidence_collected:
            self.evidence_collected.append(evidence_id)
    
    def report_to_authorities(self) -> Dict:
        """Report fraud to authorities."""
        self.has_reported_to_authorities = True
        return {
            "type": "authority_report",
            "evidence_count": len(self.evidence_collected)
        }


# =============================================================================
# ABM Engine
# =============================================================================

class ABMEngine(BaseEngine):
    """
    Agent-Based Modeling engine for legal case simulation.
    Manages agents and their interactions.
    """
    
    def __init__(self, name: str = "ABM Simulation", seed: int = None):
        super().__init__(name, seed)
        
        # Agent management
        self.agents: Dict[str, LegalCaseAgent] = {}
        self.perpetrators: Dict[str, PerpetratorAgent] = {}
        self.victims: Dict[str, VictimAgent] = {}
        
        # Interaction tracking
        self.interactions: List[Dict] = []
        
        # Spatial parameters (for visualization)
        self.world_width: float = 100.0
        self.world_height: float = 100.0
        
        # Data collectors
        self.agent_states_collector = self.create_collector("agent_states")
        self.culpability_collector = self.create_collector("culpability")
        self.fund_diversion_collector = self.create_collector("fund_diversions")
    
    def add_agent(self, agent: LegalCaseAgent) -> None:
        """Add an agent to the simulation."""
        self.agents[agent.agent_id] = agent
        
        if isinstance(agent, PerpetratorAgent):
            self.perpetrators[agent.agent_id] = agent
        elif isinstance(agent, VictimAgent):
            self.victims[agent.agent_id] = agent
    
    def get_agent(self, agent_id: str) -> Optional[LegalCaseAgent]:
        """Get an agent by ID."""
        return self.agents.get(agent_id)
    
    def step(self) -> bool:
        """Execute one simulation step."""
        # Process scheduled events
        while not self.event_queue.is_empty():
            event = self.event_queue.peek()
            if event.time > self.current_time:
                break
            
            event = self.event_queue.pop()
            result = event.execute(self)
            
            if result:
                self.schedule_event(result)
        
        # Update all agents
        for agent in self.agents.values():
            self._update_agent(agent)
        
        # Record state
        self._record_state()
        
        # Advance time
        self.current_time += 1.0  # 1 day per step
        
        return self.current_time < self.end_time
    
    def _update_agent(self, agent: LegalCaseAgent) -> None:
        """Update a single agent."""
        context = {
            "time": self.current_time,
            "other_agents": [a for a in self.agents.values() if a.agent_id != agent.agent_id]
        }
        
        action = agent.decide_action(context)
        
        if action != "wait":
            agent.record_action(action, self.current_time)
            self._process_action(agent, action)
    
    def _process_action(self, agent: LegalCaseAgent, action: str) -> None:
        """Process an agent action."""
        if action == "destroy_evidence" and isinstance(agent, PerpetratorAgent):
            self.log(f"{agent.name} destroying evidence", LogLevel.WARNING)
            
        elif action == "divert_funds" and isinstance(agent, PerpetratorAgent):
            self.fund_diversion_collector.record(
                self.current_time,
                agent.diverted_funds,
                label=agent.agent_id
            )
    
    def _record_state(self) -> None:
        """Record current simulation state."""
        for agent in self.agents.values():
            self.agent_states_collector.record(
                self.current_time,
                agent.state.name,
                label=agent.agent_id
            )
            
            self.culpability_collector.record(
                self.current_time,
                agent.culpability_score,
                label=agent.agent_id
            )
    
    def calculate_network_metrics(self) -> Dict:
        """Calculate network metrics for agents."""
        metrics = {
            "total_agents": len(self.agents),
            "perpetrators": len(self.perpetrators),
            "victims": len(self.victims),
            "total_diverted_funds": sum(
                p.diverted_funds for p in self.perpetrators.values()
            ),
            "total_destroyed_evidence": sum(
                p.destroyed_evidence_count for p in self.perpetrators.values()
            ),
            "avg_culpability": sum(
                a.culpability_score for a in self.agents.values()
            ) / len(self.agents) if self.agents else 0
        }
        return metrics
    
    def get_results(self) -> Dict:
        """Get simulation results with ABM-specific metrics."""
        base_results = super().get_results()
        base_results["network_metrics"] = self.calculate_network_metrics()
        base_results["agent_summary"] = {
            agent_id: {
                "name": agent.name,
                "state": agent.state.name,
                "culpability": agent.culpability_score,
                "actions_count": len(agent.actions_taken)
            }
            for agent_id, agent in self.agents.items()
        }
        return base_results
