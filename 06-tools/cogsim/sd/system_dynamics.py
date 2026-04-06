"""
CogSim System Dynamics Module
Models aggregate-level dynamics: financial flows, evidence strength, and case outcomes.
"""

from dataclasses import dataclass, field
from typing import List, Dict, Optional, Set, Callable, Any, Tuple
from enum import Enum, auto
import math

from ..core.base import BaseEngine, Event, DataCollector, LogLevel


# =============================================================================
# System Dynamics Components
# =============================================================================

@dataclass
class Stock:
    """
    Stock (accumulator) in the system dynamics model.
    Represents quantities that accumulate over time.
    """
    name: str
    initial_value: float = 0.0
    value: float = 0.0
    min_value: float = float('-inf')
    max_value: float = float('inf')
    
    # Flows
    inflows: List[str] = field(default_factory=list)
    outflows: List[str] = field(default_factory=list)
    
    # History
    history: List[Tuple[float, float]] = field(default_factory=list)
    
    def __post_init__(self):
        self.value = self.initial_value
    
    def update(self, net_flow: float, dt: float) -> float:
        """Update stock value based on net flow."""
        new_value = self.value + net_flow * dt
        self.value = max(self.min_value, min(self.max_value, new_value))
        return self.value
    
    def record(self, time: float) -> None:
        """Record current value in history."""
        self.history.append((time, self.value))
    
    def reset(self) -> None:
        """Reset to initial value."""
        self.value = self.initial_value
        self.history.clear()


@dataclass
class Flow:
    """
    Flow in the system dynamics model.
    Represents rates of change between stocks.
    """
    name: str
    rate_function: Callable[[Dict[str, float], float], float] = None
    base_rate: float = 0.0
    
    # Current rate
    current_rate: float = 0.0
    
    # History
    history: List[Tuple[float, float]] = field(default_factory=list)
    
    def calculate(self, variables: Dict[str, float], time: float) -> float:
        """Calculate flow rate."""
        if self.rate_function:
            self.current_rate = self.rate_function(variables, time)
        else:
            self.current_rate = self.base_rate
        return self.current_rate
    
    def record(self, time: float) -> None:
        """Record current rate in history."""
        self.history.append((time, self.current_rate))


@dataclass
class Auxiliary:
    """
    Auxiliary variable in the system dynamics model.
    Represents calculated values based on other variables.
    """
    name: str
    calculation: Callable[[Dict[str, float], float], float] = None
    value: float = 0.0
    
    # History
    history: List[Tuple[float, float]] = field(default_factory=list)
    
    def calculate(self, variables: Dict[str, float], time: float) -> float:
        """Calculate auxiliary value."""
        if self.calculation:
            self.value = self.calculation(variables, time)
        return self.value
    
    def record(self, time: float) -> None:
        """Record current value in history."""
        self.history.append((time, self.value))


@dataclass
class Parameter:
    """
    Parameter (constant) in the system dynamics model.
    """
    name: str
    value: float = 0.0
    description: str = ""


# =============================================================================
# Legal Case SD Model
# =============================================================================

class LegalCaseSDModel:
    """
    System Dynamics model for the legal case.
    Models financial flows, evidence accumulation, and case outcomes.
    """
    
    def __init__(self):
        # Stocks
        self.stocks: Dict[str, Stock] = {}
        
        # Flows
        self.flows: Dict[str, Flow] = {}
        
        # Auxiliaries
        self.auxiliaries: Dict[str, Auxiliary] = {}
        
        # Parameters
        self.parameters: Dict[str, Parameter] = {}
        
        # Initialize the model
        self._initialize_model()
    
    def _initialize_model(self) -> None:
        """Initialize the legal case SD model."""
        
        # === STOCKS ===
        
        # Financial stocks
        self.stocks["total_losses"] = Stock(
            name="total_losses",
            initial_value=0.0,
            min_value=0.0
        )
        
        self.stocks["revenue_losses"] = Stock(
            name="revenue_losses",
            initial_value=0.0,
            min_value=0.0
        )
        
        self.stocks["trust_losses"] = Stock(
            name="trust_losses",
            initial_value=0.0,
            min_value=0.0
        )
        
        self.stocks["diverted_funds"] = Stock(
            name="diverted_funds",
            initial_value=0.0,
            min_value=0.0
        )
        
        # Evidence stocks
        self.stocks["evidence_strength"] = Stock(
            name="evidence_strength",
            initial_value=0.0,
            min_value=0.0,
            max_value=1.0
        )
        
        self.stocks["destroyed_evidence"] = Stock(
            name="destroyed_evidence",
            initial_value=0.0,
            min_value=0.0
        )
        
        # Case outcome stocks
        self.stocks["applicant_case_strength"] = Stock(
            name="applicant_case_strength",
            initial_value=0.5,
            min_value=0.0,
            max_value=1.0
        )
        
        self.stocks["respondent_case_strength"] = Stock(
            name="respondent_case_strength",
            initial_value=0.5,
            min_value=0.0,
            max_value=1.0
        )
        
        self.stocks["criminal_referral_likelihood"] = Stock(
            name="criminal_referral_likelihood",
            initial_value=0.0,
            min_value=0.0,
            max_value=1.0
        )
        
        # Perpetrator stocks
        self.stocks["culpability_score"] = Stock(
            name="culpability_score",
            initial_value=0.0,
            min_value=0.0,
            max_value=1.0
        )
        
        self.stocks["consciousness_of_guilt"] = Stock(
            name="consciousness_of_guilt",
            initial_value=0.0,
            min_value=0.0,
            max_value=1.0
        )
        
        # === FLOWS ===
        
        # Financial flows
        self.flows["revenue_theft_rate"] = Flow(
            name="revenue_theft_rate",
            rate_function=self._revenue_theft_rate
        )
        
        self.flows["fund_diversion_rate"] = Flow(
            name="fund_diversion_rate",
            rate_function=self._fund_diversion_rate
        )
        
        # Evidence flows
        self.flows["evidence_accumulation_rate"] = Flow(
            name="evidence_accumulation_rate",
            rate_function=self._evidence_accumulation_rate
        )
        
        self.flows["evidence_destruction_rate"] = Flow(
            name="evidence_destruction_rate",
            rate_function=self._evidence_destruction_rate
        )
        
        # Case strength flows
        self.flows["applicant_strength_change"] = Flow(
            name="applicant_strength_change",
            rate_function=self._applicant_strength_change
        )
        
        self.flows["respondent_strength_change"] = Flow(
            name="respondent_strength_change",
            rate_function=self._respondent_strength_change
        )
        
        # === PARAMETERS ===
        
        self.parameters["civil_threshold"] = Parameter(
            name="civil_threshold",
            value=0.51,
            description="Balance of probabilities threshold"
        )
        
        self.parameters["criminal_threshold"] = Parameter(
            name="criminal_threshold",
            value=0.95,
            description="Beyond reasonable doubt threshold"
        )
        
        self.parameters["evidence_decay_rate"] = Parameter(
            name="evidence_decay_rate",
            value=0.001,
            description="Rate at which evidence value decays"
        )
        
        self.parameters["third_party_evidence_bonus"] = Parameter(
            name="third_party_evidence_bonus",
            value=0.15,
            description="Bonus weight for third-party evidence"
        )
        
        # === AUXILIARIES ===
        
        self.auxiliaries["net_evidence_change"] = Auxiliary(
            name="net_evidence_change",
            calculation=self._net_evidence_change
        )
        
        self.auxiliaries["case_outcome_probability"] = Auxiliary(
            name="case_outcome_probability",
            calculation=self._case_outcome_probability
        )
    
    # === FLOW RATE FUNCTIONS ===
    
    def _revenue_theft_rate(self, variables: Dict[str, float], time: float) -> float:
        """Calculate revenue theft rate based on criminal phase."""
        # Higher rate during cover-up phase (after May 2025)
        if time > 3000:  # Approximately May 2025 from Jan 2017
            return 50000.0  # R50K per day during active theft
        return 5000.0  # R5K per day baseline
    
    def _fund_diversion_rate(self, variables: Dict[str, float], time: float) -> float:
        """Calculate fund diversion rate."""
        base_rate = 10000.0
        # Increase during escalation phases
        if time > 2500:
            return base_rate * 2.0
        return base_rate
    
    def _evidence_accumulation_rate(self, variables: Dict[str, float], time: float) -> float:
        """Calculate evidence accumulation rate."""
        # Evidence accumulates faster after fraud discovery
        fraud_discovery_time = 3050  # Approximately May 15, 2025
        if time > fraud_discovery_time:
            return 0.02  # 2% per day after discovery
        return 0.001  # 0.1% per day baseline
    
    def _evidence_destruction_rate(self, variables: Dict[str, float], time: float) -> float:
        """Calculate evidence destruction rate."""
        # Spike during cover-up phase
        shopify_destruction_time = 3057  # May 22, 2025
        if abs(time - shopify_destruction_time) < 7:
            return 0.1  # 10% destruction during active cover-up
        return 0.0
    
    def _applicant_strength_change(self, variables: Dict[str, float], time: float) -> float:
        """Calculate change in applicant's case strength."""
        evidence_strength = variables.get("evidence_strength", 0.5)
        # Applicant strength decreases as evidence against them accumulates
        return -0.01 * evidence_strength
    
    def _respondent_strength_change(self, variables: Dict[str, float], time: float) -> float:
        """Calculate change in respondent's case strength."""
        evidence_strength = variables.get("evidence_strength", 0.5)
        # Respondent strength increases with evidence
        return 0.01 * evidence_strength
    
    # === AUXILIARY CALCULATIONS ===
    
    def _net_evidence_change(self, variables: Dict[str, float], time: float) -> float:
        """Calculate net change in evidence."""
        accumulation = variables.get("evidence_accumulation_rate", 0.0)
        destruction = variables.get("evidence_destruction_rate", 0.0)
        return accumulation - destruction
    
    def _case_outcome_probability(self, variables: Dict[str, float], time: float) -> float:
        """Calculate probability of favorable case outcome for respondents."""
        respondent_strength = variables.get("respondent_case_strength", 0.5)
        applicant_strength = variables.get("applicant_case_strength", 0.5)
        
        if respondent_strength + applicant_strength == 0:
            return 0.5
        
        return respondent_strength / (respondent_strength + applicant_strength)
    
    def get_variables(self) -> Dict[str, float]:
        """Get all current variable values."""
        variables = {}
        
        for name, stock in self.stocks.items():
            variables[name] = stock.value
        
        for name, flow in self.flows.items():
            variables[name] = flow.current_rate
        
        for name, aux in self.auxiliaries.items():
            variables[name] = aux.value
        
        for name, param in self.parameters.items():
            variables[name] = param.value
        
        return variables


# =============================================================================
# SD Engine
# =============================================================================

class SDEngine(BaseEngine):
    """
    System Dynamics engine for legal case simulation.
    Uses numerical integration to solve the SD model.
    """
    
    def __init__(self, name: str = "SD Simulation", seed: int = None,
                 dt: float = 1.0, integration_method: str = "euler"):
        super().__init__(name, seed)
        
        # Time step
        self.dt = dt
        self.integration_method = integration_method
        
        # SD Model
        self.model = LegalCaseSDModel()
        
        # Data collectors for each stock
        for stock_name in self.model.stocks:
            self.create_collector(f"stock_{stock_name}")
        
        for flow_name in self.model.flows:
            self.create_collector(f"flow_{flow_name}")
    
    def step(self) -> bool:
        """Execute one simulation step using numerical integration."""
        # Get current variables
        variables = self.model.get_variables()
        
        # Calculate all flows
        for flow in self.model.flows.values():
            flow.calculate(variables, self.current_time)
        
        # Calculate all auxiliaries
        for aux in self.model.auxiliaries.values():
            aux.calculate(variables, self.current_time)
        
        # Update stocks based on integration method
        if self.integration_method == "euler":
            self._euler_step()
        elif self.integration_method == "rk4":
            self._rk4_step()
        else:
            self._euler_step()
        
        # Record values
        self._record_values()
        
        # Advance time
        self.current_time += self.dt
        
        return self.current_time < self.end_time
    
    def _euler_step(self) -> None:
        """Euler integration step."""
        # Update financial stocks
        self.model.stocks["revenue_losses"].update(
            self.model.flows["revenue_theft_rate"].current_rate,
            self.dt
        )
        
        self.model.stocks["diverted_funds"].update(
            self.model.flows["fund_diversion_rate"].current_rate,
            self.dt
        )
        
        # Update evidence stocks
        net_evidence = (
            self.model.flows["evidence_accumulation_rate"].current_rate -
            self.model.flows["evidence_destruction_rate"].current_rate
        )
        self.model.stocks["evidence_strength"].update(net_evidence, self.dt)
        
        self.model.stocks["destroyed_evidence"].update(
            self.model.flows["evidence_destruction_rate"].current_rate,
            self.dt
        )
        
        # Update case strength stocks
        self.model.stocks["applicant_case_strength"].update(
            self.model.flows["applicant_strength_change"].current_rate,
            self.dt
        )
        
        self.model.stocks["respondent_case_strength"].update(
            self.model.flows["respondent_strength_change"].current_rate,
            self.dt
        )
        
        # Update total losses
        total = (
            self.model.stocks["revenue_losses"].value +
            self.model.stocks["trust_losses"].value +
            self.model.stocks["diverted_funds"].value
        )
        self.model.stocks["total_losses"].value = total
        
        # Update criminal referral likelihood
        evidence = self.model.stocks["evidence_strength"].value
        consciousness = self.model.stocks["consciousness_of_guilt"].value
        self.model.stocks["criminal_referral_likelihood"].value = min(
            1.0, evidence * 0.5 + consciousness * 0.5
        )
    
    def _rk4_step(self) -> None:
        """Runge-Kutta 4th order integration step."""
        # Simplified RK4 - for full implementation, would need derivatives
        self._euler_step()  # Fallback to Euler for now
    
    def _record_values(self) -> None:
        """Record current values to collectors."""
        for stock_name, stock in self.model.stocks.items():
            stock.record(self.current_time)
            collector = self.data_collectors.get(f"stock_{stock_name}")
            if collector:
                collector.record(self.current_time, stock.value, label=stock_name)
        
        for flow_name, flow in self.model.flows.items():
            flow.record(self.current_time)
            collector = self.data_collectors.get(f"flow_{flow_name}")
            if collector:
                collector.record(self.current_time, flow.current_rate, label=flow_name)
    
    def inject_event(self, event_type: str, magnitude: float) -> None:
        """Inject an external event into the SD model."""
        if event_type == "evidence_destruction":
            self.model.stocks["destroyed_evidence"].value += magnitude
            self.model.stocks["consciousness_of_guilt"].value = min(
                1.0, self.model.stocks["consciousness_of_guilt"].value + 0.2
            )
        elif event_type == "fraud_discovery":
            self.model.stocks["evidence_strength"].value = min(
                1.0, self.model.stocks["evidence_strength"].value + magnitude
            )
        elif event_type == "fund_diversion":
            self.model.stocks["diverted_funds"].value += magnitude
    
    def get_results(self) -> Dict:
        """Get simulation results with SD-specific metrics."""
        base_results = super().get_results()
        
        # Add final stock values
        base_results["final_stocks"] = {
            name: stock.value
            for name, stock in self.model.stocks.items()
        }
        
        # Add case outcome analysis
        variables = self.model.get_variables()
        base_results["case_analysis"] = {
            "applicant_case_strength": variables.get("applicant_case_strength", 0),
            "respondent_case_strength": variables.get("respondent_case_strength", 0),
            "criminal_referral_likelihood": variables.get("criminal_referral_likelihood", 0),
            "total_losses": variables.get("total_losses", 0),
            "evidence_strength": variables.get("evidence_strength", 0),
            "meets_civil_threshold": variables.get("respondent_case_strength", 0) > 0.51,
            "meets_criminal_threshold": variables.get("criminal_referral_likelihood", 0) > 0.95
        }
        
        return base_results
