"""
CogSim Legal Case Entities
Comprehensive entity definitions for Case 2025-137857 simulation.
Includes actors, evidence, claims, and timeline events.
"""

from dataclasses import dataclass, field
from enum import Enum, auto
from typing import List, Dict, Optional, Set, Callable, Any
from datetime import datetime


# =============================================================================
# Enumerations
# =============================================================================

class ActorRole(Enum):
    """Roles of actors in the legal case."""
    APPLICANT = "applicant"
    RESPONDENT = "respondent"
    WITNESS = "witness"
    CO_CONSPIRATOR = "co_conspirator"
    VICTIM = "victim"
    BENEFICIARY = "beneficiary"
    TRUSTEE = "trustee"
    DIRECTOR = "director"
    EMPLOYEE = "employee"
    THIRD_PARTY = "third_party"


class ActorType(Enum):
    """Types of actors."""
    INDIVIDUAL = "individual"
    COMPANY = "company"
    TRUST = "trust"
    GOVERNMENT = "government"


class EvidenceType(Enum):
    """Types of evidence in the case."""
    THIRD_PARTY_DOCUMENTARY = "third_party_documentary"
    MEDICAL_DOCUMENTARY = "medical_documentary"
    FINANCIAL_DOCUMENTARY = "financial_documentary"
    CHRONOLOGICAL_ANALYSIS = "chronological_analysis"
    CORRESPONDENCE = "correspondence"
    BUSINESS_RECORDS = "business_records"
    PROCEDURAL_RECORDS = "procedural_records"
    VISUAL_EVIDENCE = "visual_evidence"
    ACCOUNTING_RECORDS = "accounting_records"
    DIGITAL_FORENSIC = "digital_forensic"
    WITNESS_TESTIMONY = "witness_testimony"


class CrimeCategory(Enum):
    """Categories of criminal conduct."""
    REVENUE_THEFT = "revenue_theft"
    TRUST_VIOLATION = "trust_violation"
    FINANCIAL_FRAUD = "financial_fraud"
    IDENTITY_THEFT = "identity_theft"
    EVIDENCE_DESTRUCTION = "evidence_destruction"
    POPIA_VIOLATION = "popia_violation"
    COMPUTER_FRAUD = "computer_fraud"
    CONSPIRACY = "conspiracy"


class ClaimStatus(Enum):
    """Status of legal claims."""
    PENDING = "pending"
    SUPPORTED = "supported"
    REFUTED = "refuted"
    PARTIALLY_SUPPORTED = "partially_supported"


class BurdenOfProof(Enum):
    """Legal burden of proof standards."""
    BALANCE_OF_PROBABILITIES = 0.51  # Civil standard
    CLEAR_AND_CONVINCING = 0.75
    BEYOND_REASONABLE_DOUBT = 0.95  # Criminal standard


class CriminalPhase(Enum):
    """Phases of the criminal enterprise evolution."""
    FOUNDATION = "foundation"           # 2017: Legitimate business establishment
    STRUCTURE = "structure"             # 2019-2020: Complex financial structure
    EXPANSION = "expansion"             # 2020: International expansion
    INFILTRATION = "infiltration"       # 2022: Automation and staff infiltration
    ESCALATION = "escalation"           # 2023: Debt accumulation, violence
    POSITIONING = "positioning"         # 2024: Authority positioning
    COVERUP = "coverup"                 # 2025: Evidence destruction, legal warfare


# =============================================================================
# Actor Entities
# =============================================================================

@dataclass
class Actor:
    """
    Represents an actor in the legal case.
    Can be an individual, company, or trust.
    """
    actor_id: str
    name: str
    actor_type: ActorType
    roles: List[ActorRole] = field(default_factory=list)
    
    # Relationships
    related_actors: Dict[str, str] = field(default_factory=dict)  # actor_id -> relationship
    affiliated_entities: List[str] = field(default_factory=list)
    
    # Case-specific attributes
    is_perpetrator: bool = False
    is_victim: bool = False
    credibility_score: float = 0.5  # 0-1 scale
    
    # Financial attributes
    financial_control: List[str] = field(default_factory=list)  # List of accounts/entities controlled
    
    # Timeline of involvement
    involvement_start: Optional[datetime] = None
    involvement_end: Optional[datetime] = None
    
    # Evidence references
    evidence_against: List[str] = field(default_factory=list)
    evidence_supporting: List[str] = field(default_factory=list)
    
    def add_role(self, role: ActorRole) -> None:
        """Add a role to the actor."""
        if role not in self.roles:
            self.roles.append(role)
    
    def calculate_culpability(self) -> float:
        """Calculate culpability score based on evidence."""
        if not self.evidence_against:
            return 0.0
        base_score = len(self.evidence_against) * 0.1
        return min(1.0, base_score)


@dataclass
class Company(Actor):
    """Company entity with additional business attributes."""
    registration_number: str = ""
    registration_date: Optional[datetime] = None
    directors: List[str] = field(default_factory=list)  # Actor IDs
    shareholders: Dict[str, float] = field(default_factory=dict)  # actor_id -> percentage
    
    # Financial metrics
    annual_revenue: float = 0.0
    total_losses: float = 0.0
    inter_company_debt: Dict[str, float] = field(default_factory=dict)  # company_id -> amount
    
    # Operational status
    is_active: bool = True
    is_expense_dumping_target: bool = False
    is_profit_extraction_vehicle: bool = False


@dataclass
class Trust(Actor):
    """Trust entity with trust-specific attributes."""
    trust_number: str = ""
    trustees: List[str] = field(default_factory=list)  # Actor IDs
    beneficiaries: List[str] = field(default_factory=list)  # Actor IDs
    
    # Trust assets
    assets: Dict[str, float] = field(default_factory=dict)
    
    # Violations
    violations: List[Dict] = field(default_factory=list)


# =============================================================================
# Evidence Entities
# =============================================================================

@dataclass
class Evidence:
    """
    Represents a piece of evidence in the case.
    """
    evidence_id: str
    name: str
    evidence_type: EvidenceType
    
    # Source and credibility
    source: str
    source_type: str  # "third_party", "party", "expert"
    date_created: Optional[datetime] = None
    date_obtained: Optional[datetime] = None
    
    # Weight and credibility
    weight: float = 0.5  # 0-1 scale
    credibility: float = 0.5  # 0-1 scale
    alterability: float = 0.5  # 0-1 scale (0 = cannot be altered)
    
    # Relationships
    supports_party: str = ""  # "applicant", "respondent", "neutral"
    refutes_claims: List[str] = field(default_factory=list)
    supports_claims: List[str] = field(default_factory=list)
    corroborates: List[str] = field(default_factory=list)  # Other evidence IDs
    
    # Criminal significance
    criminal_significance: bool = False
    demonstrates: List[str] = field(default_factory=list)  # What it demonstrates
    
    # File references
    file_path: str = ""
    annexure_reference: str = ""
    
    def calculate_effective_weight(self) -> float:
        """Calculate effective weight considering all factors."""
        base_weight = self.weight * self.credibility
        
        # Third-party evidence bonus
        if self.source_type == "third_party":
            base_weight *= 1.15
        
        # Unalterable evidence bonus
        if self.alterability == 0:
            base_weight *= 1.1
        
        return min(1.0, base_weight)


# =============================================================================
# Claim Entities
# =============================================================================

@dataclass
class Claim:
    """
    Represents a legal claim in the case.
    """
    claim_id: str
    description: str
    claimant: str  # Actor ID
    
    # Claim strength
    base_strength: float = 0.5
    strength_with_rebuttal: float = 0.0
    
    # Evidence relationships
    evidence_for: List[str] = field(default_factory=list)
    evidence_against: List[str] = field(default_factory=list)
    
    # Status
    status: ClaimStatus = ClaimStatus.PENDING
    
    # Legal standards
    meets_civil_standard: bool = False
    meets_criminal_standard: bool = False
    
    # Criminal significance
    criminal_significance: bool = False
    
    def evaluate(self, evidence_dict: Dict[str, Evidence]) -> float:
        """Evaluate claim strength based on evidence."""
        strength = self.base_strength
        
        # Apply evidence against
        for ev_id in self.evidence_against:
            if ev_id in evidence_dict:
                ev = evidence_dict[ev_id]
                strength *= (1 - ev.calculate_effective_weight())
        
        # Apply evidence for
        for ev_id in self.evidence_for:
            if ev_id in evidence_dict:
                ev = evidence_dict[ev_id]
                strength += ev.calculate_effective_weight() * 0.1
        
        return max(0.0, min(1.0, strength))


# =============================================================================
# Timeline Event Entities
# =============================================================================

@dataclass
class TimelineEvent:
    """
    Represents an event in the case timeline.
    """
    event_id: str
    date: datetime
    title: str
    description: str
    
    # Categorization
    category: CrimeCategory
    criminal_phase: CriminalPhase
    
    # Actors involved
    perpetrators: List[str] = field(default_factory=list)  # Actor IDs
    victims: List[str] = field(default_factory=list)  # Actor IDs
    
    # Crime details
    crime_type: str = ""
    
    # Impact
    financial_impact: float = 0.0
    impact_description: str = ""
    
    # Legal significance
    legal_significance: str = ""
    escalation_level: int = 1  # 1-10 scale
    
    # Evidence
    evidence_references: List[str] = field(default_factory=list)
    
    # Shopify connection (specific to this case)
    shopify_connection: bool = False
    shopify_note: str = ""
    shopify_revelation: str = ""
    
    # Coordination indicators
    coordination_indicators: List[str] = field(default_factory=list)
    
    def days_from_start(self, start_date: datetime) -> int:
        """Calculate days from a start date."""
        return (self.date - start_date).days


# =============================================================================
# Financial Flow Entities
# =============================================================================

@dataclass
class FinancialFlow:
    """
    Represents a financial transaction or flow.
    """
    flow_id: str
    date: datetime
    
    # Parties
    source_entity: str  # Actor/Company ID
    destination_entity: str  # Actor/Company ID
    
    # Amount
    amount: float
    currency: str = "ZAR"
    
    # Classification
    is_legitimate: bool = True
    is_diverted: bool = False
    is_unauthorized: bool = False
    
    # Description
    description: str = ""
    purpose: str = ""
    
    # Evidence
    evidence_reference: str = ""
    
    # Fraud indicators
    fraud_indicators: List[str] = field(default_factory=list)


@dataclass
class LossCategory:
    """
    Represents a category of financial losses.
    """
    category_id: str
    name: str
    description: str
    
    # Amounts
    total_loss: float = 0.0
    currency: str = "ZAR"
    
    # Events contributing to loss
    contributing_events: List[str] = field(default_factory=list)
    
    # Evidence
    evidence_references: List[str] = field(default_factory=list)


# =============================================================================
# Case Summary Entity
# =============================================================================

@dataclass
class CaseSummary:
    """
    Summary of the entire case with aggregated metrics.
    """
    case_number: str
    case_name: str
    
    # Parties
    applicant: str
    respondents: List[str] = field(default_factory=list)
    
    # Timeline
    start_date: Optional[datetime] = None
    end_date: Optional[datetime] = None
    active_criminal_days: int = 0
    
    # Financial summary
    total_revenue_loss: float = 0.0
    total_trust_loss: float = 0.0
    total_financial_loss: float = 0.0
    total_losses: float = 0.0
    
    # Event counts
    total_events: int = 0
    events_by_category: Dict[str, int] = field(default_factory=dict)
    
    # Evidence summary
    total_evidence: int = 0
    evidence_by_type: Dict[str, int] = field(default_factory=dict)
    
    # Claim outcomes
    applicant_claims_success_rate: float = 0.0
    respondent_claims_success_rate: float = 0.0
    
    # Criminal referral
    criminal_referral_likelihood: float = 0.0
    
    def calculate_totals(self) -> None:
        """Calculate total losses."""
        self.total_losses = (
            self.total_revenue_loss + 
            self.total_trust_loss + 
            self.total_financial_loss
        )
