"""
CogSim Discrete-Event Simulation Module
Models the timeline of events in the legal case.
"""

from dataclasses import dataclass, field
from typing import List, Dict, Optional, Set, Callable, Any, Tuple
from enum import Enum, auto
from datetime import datetime, timedelta
import heapq

from ..core.base import (
    BaseEngine, Event, EventType, EventQueue, 
    DataCollector, LogLevel, date_to_sim_time, sim_time_to_date, parse_date
)
from ..legal_case.entities import (
    TimelineEvent, CrimeCategory, CriminalPhase,
    Evidence, Claim, Actor, FinancialFlow, LossCategory
)


# =============================================================================
# DES-Specific Entities
# =============================================================================

class ProcessState(Enum):
    """States for legal processes."""
    PENDING = auto()
    IN_PROGRESS = auto()
    COMPLETED = auto()
    BLOCKED = auto()
    FAILED = auto()


@dataclass
class LegalProcess:
    """
    Represents a legal process or procedure.
    """
    process_id: str
    name: str
    process_type: str  # "civil", "criminal", "regulatory"
    
    # State
    state: ProcessState = ProcessState.PENDING
    
    # Timing
    start_time: Optional[float] = None
    end_time: Optional[float] = None
    duration: float = 0.0
    
    # Requirements
    required_evidence: List[str] = field(default_factory=list)
    required_claims: List[str] = field(default_factory=list)
    
    # Outcomes
    outcome: str = ""
    success_probability: float = 0.5
    
    # Dependencies
    depends_on: List[str] = field(default_factory=list)
    blocks: List[str] = field(default_factory=list)


@dataclass
class CaseEvent:
    """
    Wrapper for timeline events in the DES.
    """
    event: TimelineEvent
    sim_time: float
    processed: bool = False
    
    # Impact tracking
    financial_impact_realized: float = 0.0
    evidence_generated: List[str] = field(default_factory=list)
    triggered_events: List[str] = field(default_factory=list)


# =============================================================================
# DES Engine
# =============================================================================

class DESEngine(BaseEngine):
    """
    Discrete-Event Simulation engine for legal case timeline.
    Processes events chronologically and tracks impacts.
    """
    
    def __init__(self, name: str = "DES Simulation", seed: int = None,
                 start_date: datetime = None):
        super().__init__(name, seed)
        
        # Timeline reference
        self.start_date = start_date or datetime(2017, 1, 1)
        
        # Case events
        self.case_events: Dict[str, CaseEvent] = {}
        self.processed_events: List[CaseEvent] = []
        
        # Legal processes
        self.processes: Dict[str, LegalProcess] = {}
        
        # Financial tracking
        self.financial_flows: List[FinancialFlow] = []
        self.cumulative_losses: Dict[str, float] = {
            "revenue": 0.0,
            "trust": 0.0,
            "financial": 0.0
        }
        
        # Evidence tracking
        self.evidence_timeline: List[Tuple[float, str]] = []
        
        # Phase tracking
        self.current_phase: CriminalPhase = CriminalPhase.FOUNDATION
        self.phase_transitions: List[Tuple[float, CriminalPhase]] = []
        
        # Data collectors
        self.event_collector = self.create_collector("events")
        self.loss_collector = self.create_collector("losses")
        self.phase_collector = self.create_collector("phases")
        self.evidence_collector = self.create_collector("evidence")
    
    def load_timeline_events(self, events: List[TimelineEvent]) -> None:
        """Load timeline events into the simulation."""
        for event in events:
            sim_time = date_to_sim_time(event.date, self.start_date)
            case_event = CaseEvent(event=event, sim_time=sim_time)
            self.case_events[event.event_id] = case_event
            
            # Schedule the event
            self.schedule_at(
                sim_time,
                self._process_timeline_event,
                description=event.title,
                data={"event_id": event.event_id}
            )
    
    def load_from_json(self, data: Dict) -> None:
        """Load timeline events from JSON data."""
        # Category mapping from JSON to enum
        category_map = {
            "revenue": CrimeCategory.REVENUE_THEFT,
            "trust": CrimeCategory.TRUST_VIOLATION,
            "financial": CrimeCategory.FINANCIAL_FRAUD,
            "identity": CrimeCategory.IDENTITY_THEFT,
            "evidence": CrimeCategory.EVIDENCE_DESTRUCTION,
            "popia": CrimeCategory.POPIA_VIOLATION,
            "computer": CrimeCategory.COMPUTER_FRAUD,
            "conspiracy": CrimeCategory.CONSPIRACY
        }
        
        events = []
        for event_data in data.get("events", []):
            cat_str = event_data.get("category", "financial").lower()
            category = category_map.get(cat_str, CrimeCategory.FINANCIAL_FRAUD)
            
            event = TimelineEvent(
                event_id=str(event_data.get("id", "")),
                date=parse_date(event_data.get("date", "2017-01-01")),
                title=event_data.get("title", ""),
                description=event_data.get("description", ""),
                category=category,
                criminal_phase=CriminalPhase.FOUNDATION,
                perpetrators=event_data.get("perpetrators", []),
                crime_type=event_data.get("crimeType", ""),
                financial_impact=self._parse_amount(event_data.get("impact", "0")),
                impact_description=event_data.get("impact", ""),
                legal_significance=event_data.get("legalSignificance", ""),
                evidence_references=event_data.get("evidenceReferences", []),
                shopify_connection=event_data.get("shopifyConnection", False),
                shopify_note=event_data.get("shopifyNote", ""),
                shopify_revelation=event_data.get("shopifyRevelation", "")
            )
            events.append(event)
        
        self.load_timeline_events(events)
    
    def _parse_amount(self, amount_str: str) -> float:
        """Parse a monetary amount string."""
        if not amount_str:
            return 0.0
        # Remove currency symbols and commas
        cleaned = amount_str.replace("R", "").replace(",", "").replace("+", "").strip()
        try:
            return float(cleaned)
        except ValueError:
            return 0.0
    
    def _process_timeline_event(self, engine: 'DESEngine', event: Event) -> Optional[Event]:
        """Process a timeline event."""
        event_id = event.data.get("event_id")
        if event_id not in self.case_events:
            return None
        
        case_event = self.case_events[event_id]
        timeline_event = case_event.event
        
        # Mark as processed
        case_event.processed = True
        self.processed_events.append(case_event)
        
        # Log the event
        self.log(
            f"Event: {timeline_event.title}",
            LogLevel.INFO,
            {
                "category": timeline_event.category.value,
                "perpetrators": timeline_event.perpetrators,
                "impact": timeline_event.financial_impact
            }
        )
        
        # Record event
        self.event_collector.record(
            self.current_time,
            timeline_event.title,
            label=timeline_event.category.value
        )
        
        # Process financial impact
        if timeline_event.financial_impact > 0:
            self._process_financial_impact(timeline_event)
        
        # Check for phase transition
        self._check_phase_transition(timeline_event)
        
        # Generate evidence
        self._generate_evidence(timeline_event)
        
        return None
    
    def _process_financial_impact(self, event: TimelineEvent) -> None:
        """Process financial impact of an event."""
        category = event.category.value
        amount = event.financial_impact
        
        if category == "revenue_theft":
            self.cumulative_losses["revenue"] += amount
        elif category == "trust_violation":
            self.cumulative_losses["trust"] += amount
        else:
            self.cumulative_losses["financial"] += amount
        
        total_loss = sum(self.cumulative_losses.values())
        
        self.loss_collector.record(
            self.current_time,
            total_loss,
            label="total",
            metadata={"category": category, "amount": amount}
        )
    
    def _check_phase_transition(self, event: TimelineEvent) -> None:
        """Check if event triggers a phase transition."""
        # Define phase transition triggers based on event dates
        event_year = event.date.year
        
        new_phase = None
        if event_year <= 2018:
            new_phase = CriminalPhase.FOUNDATION
        elif event_year <= 2020:
            new_phase = CriminalPhase.STRUCTURE
        elif event_year <= 2021:
            new_phase = CriminalPhase.EXPANSION
        elif event_year <= 2022:
            new_phase = CriminalPhase.INFILTRATION
        elif event_year <= 2023:
            new_phase = CriminalPhase.ESCALATION
        elif event_year <= 2024:
            new_phase = CriminalPhase.POSITIONING
        else:
            new_phase = CriminalPhase.COVERUP
        
        if new_phase != self.current_phase:
            self.current_phase = new_phase
            self.phase_transitions.append((self.current_time, new_phase))
            
            self.phase_collector.record(
                self.current_time,
                new_phase.value,
                label="phase_transition"
            )
            
            self.log(
                f"Phase transition to: {new_phase.value}",
                LogLevel.INFO
            )
    
    def _generate_evidence(self, event: TimelineEvent) -> None:
        """Generate evidence from an event."""
        for ref in event.evidence_references:
            self.evidence_timeline.append((self.current_time, ref))
            self.evidence_collector.record(
                self.current_time,
                ref,
                label=event.category.value
            )
    
    def step(self) -> bool:
        """Execute one simulation step."""
        # Process all events at current time
        while not self.event_queue.is_empty():
            event = self.event_queue.peek()
            if event.time > self.current_time:
                break
            
            event = self.event_queue.pop()
            result = event.execute(self)
            
            if result:
                self.schedule_event(result)
        
        # Advance time to next event
        if not self.event_queue.is_empty():
            next_event = self.event_queue.peek()
            self.current_time = next_event.time
        else:
            return False
        
        return self.current_time < self.end_time
    
    def run_to_date(self, end_date: datetime) -> Dict:
        """Run simulation to a specific date."""
        end_time = date_to_sim_time(end_date, self.start_date)
        return self.run(end_time=end_time)
    
    def get_events_by_category(self, category: CrimeCategory) -> List[CaseEvent]:
        """Get all events in a category."""
        return [
            ce for ce in self.case_events.values()
            if ce.event.category == category
        ]
    
    def get_events_by_phase(self, phase: CriminalPhase) -> List[CaseEvent]:
        """Get all events in a criminal phase."""
        return [
            ce for ce in self.case_events.values()
            if ce.event.criminal_phase == phase
        ]
    
    def get_timeline_summary(self) -> Dict:
        """Get a summary of the timeline."""
        return {
            "total_events": len(self.case_events),
            "processed_events": len(self.processed_events),
            "events_by_category": {
                cat.value: len(self.get_events_by_category(cat))
                for cat in CrimeCategory
            },
            "cumulative_losses": self.cumulative_losses,
            "total_losses": sum(self.cumulative_losses.values()),
            "phase_transitions": [
                {"time": t, "phase": p.value}
                for t, p in self.phase_transitions
            ],
            "current_phase": self.current_phase.value
        }
    
    def get_results(self) -> Dict:
        """Get simulation results with DES-specific metrics."""
        base_results = super().get_results()
        base_results["timeline_summary"] = self.get_timeline_summary()
        base_results["evidence_timeline"] = [
            {"time": t, "reference": ref}
            for t, ref in self.evidence_timeline[:100]  # Limit output
        ]
        return base_results
