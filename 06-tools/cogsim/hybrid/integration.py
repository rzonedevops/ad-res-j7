"""
CogSim Hybrid Integration Module
Combines ABM, DES, and System Dynamics for comprehensive legal case simulation.
"""

from dataclasses import dataclass, field
from typing import List, Dict, Optional, Set, Callable, Any, Tuple
from datetime import datetime
import json

from ..core.base import BaseEngine, Event, DataCollector, LogLevel, date_to_sim_time
from ..abm.agent import ABMEngine, LegalCaseAgent, PerpetratorAgent, VictimAgent, AgentState
from ..des.engine import DESEngine, CaseEvent
from ..sd.system_dynamics import SDEngine, LegalCaseSDModel
from ..legal_case.entities import (
    Actor, ActorRole, ActorType, Evidence, EvidenceType, Claim, ClaimStatus,
    TimelineEvent, CrimeCategory, CriminalPhase, CaseSummary, BurdenOfProof
)


# =============================================================================
# Hybrid Engine
# =============================================================================

class HybridEngine(BaseEngine):
    """
    Hybrid simulation engine combining ABM, DES, and System Dynamics.
    Synchronizes the three paradigms for comprehensive legal case analysis.
    """
    
    def __init__(self, name: str = "Hybrid Legal Case Simulation", 
                 seed: int = None, start_date: datetime = None):
        super().__init__(name, seed)
        
        # Reference date
        self.start_date = start_date or datetime(2017, 1, 1)
        
        # Sub-engines
        self.abm_engine = ABMEngine(name="ABM", seed=seed)
        self.des_engine = DESEngine(name="DES", seed=seed, start_date=self.start_date)
        self.sd_engine = SDEngine(name="SD", seed=seed)
        
        # Case data
        self.case_summary: Optional[CaseSummary] = None
        self.evidence: Dict[str, Evidence] = {}
        self.claims: Dict[str, Claim] = {}
        
        # Coupling parameters
        self.coupling_interval: float = 1.0  # Days between coupling updates
        self.last_coupling_time: float = 0.0
        
        # Results aggregation
        self.iteration_results: List[Dict] = []
        
        # Data collectors
        self.outcome_collector = self.create_collector("outcomes")
        self.claim_collector = self.create_collector("claims")
    
    def load_case_data(self, forensic_data: Dict) -> None:
        """Load case data from forensic events JSON."""
        # Create case summary
        self.case_summary = CaseSummary(
            case_number=forensic_data.get("caseNumber", ""),
            case_name=forensic_data.get("caseName", ""),
            applicant="Peter Andrew Faucitt",
            respondents=["Jacqueline Faucitt", "Daniel James Faucitt"]
        )
        
        # Parse total losses
        losses = forensic_data.get("totalLosses", {})
        self.case_summary.total_revenue_loss = self._parse_amount(losses.get("revenue", "0"))
        self.case_summary.total_trust_loss = self._parse_amount(losses.get("trust", "0"))
        self.case_summary.total_financial_loss = self._parse_amount(losses.get("financial", "0"))
        self.case_summary.calculate_totals()
        
        # Load timeline events into DES
        self.des_engine.load_from_json(forensic_data)
        
        # Create agents from perpetrators in events
        self._create_agents_from_events(forensic_data.get("events", []))
        
        # Load evidence
        self._load_evidence()
        
        # Load claims
        self._load_claims()
    
    def _parse_amount(self, amount_str: str) -> float:
        """Parse monetary amount string."""
        if not amount_str:
            return 0.0
        cleaned = amount_str.replace("R", "").replace(",", "").replace("+", "").strip()
        try:
            return float(cleaned)
        except ValueError:
            return 0.0
    
    def _create_agents_from_events(self, events: List[Dict]) -> None:
        """Create agents from event perpetrators."""
        perpetrator_names = set()
        for event in events:
            for perp in event.get("perpetrators", []):
                perpetrator_names.add(perp)
        
        # Create perpetrator agents
        for name in perpetrator_names:
            agent_id = name.lower().replace(" ", "_")
            
            actor = Actor(
                actor_id=agent_id,
                name=name,
                actor_type=ActorType.INDIVIDUAL,
                roles=[ActorRole.CO_CONSPIRATOR],
                is_perpetrator=True
            )
            
            agent = PerpetratorAgent(
                agent_id=agent_id,
                name=name,
                actor=actor,
                state=AgentState.EXECUTING,
                risk_tolerance=0.7,
                coordination_level=0.8
            )
            
            self.abm_engine.add_agent(agent)
        
        # Create victim agents
        victims = [
            ("daniel_faucitt", "Daniel James Faucitt"),
            ("jacqueline_faucitt", "Jacqueline Faucitt"),
            ("regima_zone_ltd", "RegimA Zone Ltd")
        ]
        
        for agent_id, name in victims:
            actor = Actor(
                actor_id=agent_id,
                name=name,
                actor_type=ActorType.INDIVIDUAL if "faucitt" in agent_id else ActorType.COMPANY,
                roles=[ActorRole.RESPONDENT, ActorRole.VICTIM],
                is_victim=True
            )
            
            agent = VictimAgent(
                agent_id=agent_id,
                name=name,
                actor=actor,
                state=AgentState.DEFENDING,
                credibility_score=0.9
            )
            
            self.abm_engine.add_agent(agent)
    
    def _load_evidence(self) -> None:
        """Load evidence items."""
        evidence_items = [
            Evidence(
                evidence_id="JF1_shopify_email",
                name="Shopify Account Email",
                evidence_type=EvidenceType.THIRD_PARTY_DOCUMENTARY,
                source="Shopify Inc.",
                source_type="third_party",
                weight=0.95,
                credibility=0.98,
                alterability=0.0,
                supports_party="respondent",
                refutes_claims=["head_office_control", "no_independent_operations", "delusional_claim"],
                criminal_significance=True
            ),
            Evidence(
                evidence_id="JF9_timeline_evidence_destruction",
                name="Evidence Destruction Timeline",
                evidence_type=EvidenceType.CHRONOLOGICAL_ANALYSIS,
                source="Forensic Analysis",
                source_type="expert",
                weight=0.85,
                credibility=0.90,
                alterability=0.0,
                supports_party="respondent",
                demonstrates=["consciousness_of_guilt", "evidence_destruction"],
                criminal_significance=True
            ),
            Evidence(
                evidence_id="JF11_medical_records",
                name="Medical Records",
                evidence_type=EvidenceType.MEDICAL_DOCUMENTARY,
                source="Medical Professionals",
                source_type="third_party",
                weight=0.90,
                credibility=0.95,
                alterability=0.0,
                supports_party="respondent",
                refutes_claims=["dementia_claim"]
            ),
            Evidence(
                evidence_id="JF4_bank_records",
                name="Bank Records",
                evidence_type=EvidenceType.FINANCIAL_DOCUMENTARY,
                source="Financial Institutions",
                source_type="third_party",
                weight=0.88,
                credibility=0.92,
                alterability=0.0,
                supports_party="respondent",
                refutes_claims=["financial_misconduct"]
            ),
            Evidence(
                evidence_id="JF3_financial_analysis",
                name="Financial Analysis",
                evidence_type=EvidenceType.ACCOUNTING_RECORDS,
                source="Expert Analysis",
                source_type="expert",
                weight=0.82,
                credibility=0.88,
                alterability=0.0,
                supports_party="respondent"
            )
        ]
        
        for evidence in evidence_items:
            self.evidence[evidence.evidence_id] = evidence
    
    def _load_claims(self) -> None:
        """Load legal claims."""
        # Applicant claims
        applicant_claims = [
            Claim(
                claim_id="head_office_control",
                description="All operations controlled by centralized head office",
                claimant="applicant",
                base_strength=0.30,
                strength_with_rebuttal=0.05,
                evidence_against=["JF1_shopify_email", "JF2_shopify_reports"]
            ),
            Claim(
                claim_id="no_independent_operations",
                description="Daniel and Kayla never operated independent businesses",
                claimant="applicant",
                base_strength=0.35,
                strength_with_rebuttal=0.03,
                evidence_against=["JF1_shopify_email", "JF2_shopify_reports", "JF3_financial_analysis"]
            ),
            Claim(
                claim_id="delusional_claim",
                description="Daniel is delusional about his role",
                claimant="applicant",
                base_strength=0.25,
                strength_with_rebuttal=0.02,
                evidence_against=["JF1_shopify_email", "JF9_timeline_evidence_destruction"]
            ),
            Claim(
                claim_id="dementia_claim",
                description="Jacqui has dementia and testimony unreliable",
                claimant="applicant",
                base_strength=0.20,
                strength_with_rebuttal=0.01,
                evidence_against=["JF11_medical_records"]
            ),
            Claim(
                claim_id="financial_misconduct",
                description="Financial misconduct and misappropriation",
                claimant="applicant",
                base_strength=0.40,
                strength_with_rebuttal=0.08,
                evidence_against=["JF4_bank_records", "JF3_financial_analysis"]
            )
        ]
        
        # Respondent claims
        respondent_claims = [
            Claim(
                claim_id="independent_operations_proven",
                description="Daniel and Kayla operated independent businesses",
                claimant="respondent",
                base_strength=0.92,
                evidence_for=["JF1_shopify_email", "JF2_shopify_reports", "JF3_financial_analysis"]
            ),
            Claim(
                claim_id="evidence_destruction",
                description="Applicant destroyed evidence on 22 May 2025",
                claimant="respondent",
                base_strength=0.85,
                evidence_for=["JF9_timeline_evidence_destruction"],
                criminal_significance=True
            ),
            Claim(
                claim_id="consciousness_of_guilt",
                description="Evidence destruction demonstrates consciousness of guilt",
                claimant="respondent",
                base_strength=0.80,
                evidence_for=["JF9_timeline_evidence_destruction"],
                criminal_significance=True
            ),
            Claim(
                claim_id="gaslighting_exposed",
                description="Dementia and delusion claims are false gaslighting",
                claimant="respondent",
                base_strength=0.88,
                evidence_for=["JF11_medical_records", "JF1_shopify_email"]
            ),
            Claim(
                claim_id="identity_theft",
                description="Phone number appropriation constitutes identity theft",
                claimant="respondent",
                base_strength=0.78,
                evidence_for=["JF1_shopify_email", "JF9_timeline_evidence_destruction"],
                criminal_significance=True
            )
        ]
        
        for claim in applicant_claims + respondent_claims:
            self.claims[claim.claim_id] = claim
    
    def step(self) -> bool:
        """Execute one hybrid simulation step."""
        # Step each sub-engine
        abm_continue = self.abm_engine.step()
        des_continue = self.des_engine.step()
        sd_continue = self.sd_engine.step()
        
        # Coupling between engines
        if self.current_time - self.last_coupling_time >= self.coupling_interval:
            self._couple_engines()
            self.last_coupling_time = self.current_time
        
        # Advance time
        self.current_time += 1.0
        
        # Sync sub-engine times
        self.abm_engine.current_time = self.current_time
        self.sd_engine.current_time = self.current_time
        
        return des_continue or (self.current_time < self.end_time)
    
    def _couple_engines(self) -> None:
        """Couple the three simulation engines."""
        # ABM -> SD: Agent actions affect system dynamics
        for agent in self.abm_engine.perpetrators.values():
            if agent.diverted_funds > 0:
                self.sd_engine.inject_event("fund_diversion", agent.diverted_funds)
            
            if agent.destroyed_evidence_count > 0:
                self.sd_engine.inject_event("evidence_destruction", 0.1)
        
        # DES -> SD: Timeline events affect system dynamics
        for case_event in self.des_engine.processed_events:
            if not case_event.processed:
                continue
            event = case_event.event
            
            if event.category == CrimeCategory.EVIDENCE_DESTRUCTION:
                self.sd_engine.inject_event("evidence_destruction", 0.2)
            
            if event.financial_impact > 0:
                self.sd_engine.model.stocks["total_losses"].value += event.financial_impact
        
        # SD -> ABM: System state affects agent behavior
        sd_vars = self.sd_engine.model.get_variables()
        evidence_strength = sd_vars.get("evidence_strength", 0)
        
        for agent in self.abm_engine.perpetrators.values():
            agent.evidence_awareness = evidence_strength
            
            # Trigger cover-up behavior when evidence accumulates
            if evidence_strength > 0.5:
                agent.state = AgentState.COVERING_UP
    
    def simulate_judge_evaluation(self, iteration: int) -> Dict:
        """Simulate a judge's evaluation of the case."""
        # Judge characteristics (vary slightly per iteration)
        judge_profile = {
            "evidence_weight_preference": self.rng.uniform(0.7, 0.95),
            "procedural_strictness": self.rng.uniform(0.6, 0.9),
            "criminal_standard_threshold": 0.85,
            "civil_standard_threshold": 0.55,
            "gaslighting_sensitivity": self.rng.uniform(0.6, 0.9),
            "third_party_evidence_bonus": self.rng.uniform(0.05, 0.15)
        }
        
        # Evaluate claims
        applicant_results = {}
        respondent_results = {}
        
        for claim_id, claim in self.claims.items():
            strength = claim.evaluate(self.evidence)
            
            # Apply judge preferences
            if claim.claimant == "applicant":
                # Applicant claims weakened by evidence
                strength *= (1 - judge_profile["evidence_weight_preference"] * 0.5)
                
                # Gaslighting claims get additional penalty
                if claim_id in ["dementia_claim", "delusional_claim"]:
                    strength *= (1 - judge_profile["gaslighting_sensitivity"] * 0.3)
                
                applicant_results[claim_id] = {
                    "strength": max(0.0, min(1.0, strength)),
                    "succeeds_civil": strength > judge_profile["civil_standard_threshold"],
                    "succeeds_criminal": strength > judge_profile["criminal_standard_threshold"]
                }
            else:
                # Respondent claims strengthened by evidence
                strength *= (0.8 + judge_profile["evidence_weight_preference"] * 0.2)
                
                # Third-party evidence bonus
                for ev_id in claim.evidence_for:
                    if ev_id in self.evidence:
                        ev = self.evidence[ev_id]
                        if ev.source_type == "third_party":
                            strength += judge_profile["third_party_evidence_bonus"]
                
                respondent_results[claim_id] = {
                    "strength": min(1.0, strength),
                    "succeeds_civil": strength > judge_profile["civil_standard_threshold"],
                    "succeeds_criminal": strength > judge_profile["criminal_standard_threshold"] if claim.criminal_significance else None
                }
        
        # Calculate success rates
        applicant_success = sum(
            1 for r in applicant_results.values() if r["succeeds_civil"]
        ) / len(applicant_results) if applicant_results else 0
        
        respondent_success = sum(
            1 for r in respondent_results.values() if r["succeeds_civil"]
        ) / len(respondent_results) if respondent_results else 0
        
        # Determine outcome
        if respondent_success > 0.7 and applicant_success < 0.3:
            outcome = "application_dismissed_with_costs"
            outcome_confidence = respondent_success
        elif respondent_success > 0.5:
            outcome = "application_dismissed"
            outcome_confidence = respondent_success
        else:
            outcome = "partial_success"
            outcome_confidence = 0.5
        
        # Criminal referral likelihood
        criminal_claims = [
            r for r in respondent_results.values()
            if r.get("succeeds_criminal") is True
        ]
        criminal_referral_likelihood = len(criminal_claims) / 3 if criminal_claims else 0
        
        return {
            "iteration": iteration,
            "judge_profile": judge_profile,
            "applicant_claims": applicant_results,
            "respondent_claims": respondent_results,
            "applicant_success_rate": applicant_success,
            "respondent_success_rate": respondent_success,
            "outcome": outcome,
            "outcome_confidence": outcome_confidence,
            "criminal_referral": criminal_referral_likelihood > 0.5,
            "criminal_referral_likelihood": criminal_referral_likelihood,
            "costs_awarded_to": "respondents" if outcome.endswith("costs") else "none"
        }
    
    def run_monte_carlo(self, iterations: int = 100) -> Dict:
        """Run Monte Carlo simulation of case outcomes."""
        outcomes = {}
        criminal_referrals = 0
        costs_to_respondents = 0
        
        for i in range(iterations):
            result = self.simulate_judge_evaluation(i + 1)
            self.iteration_results.append(result)
            
            # Aggregate outcomes
            outcome = result["outcome"]
            outcomes[outcome] = outcomes.get(outcome, 0) + 1
            
            if result["criminal_referral"]:
                criminal_referrals += 1
            
            if result["costs_awarded_to"] == "respondents":
                costs_to_respondents += 1
        
        # Calculate statistics
        avg_applicant_success = sum(
            r["applicant_success_rate"] for r in self.iteration_results
        ) / iterations
        
        avg_respondent_success = sum(
            r["respondent_success_rate"] for r in self.iteration_results
        ) / iterations
        
        avg_criminal_likelihood = sum(
            r["criminal_referral_likelihood"] for r in self.iteration_results
        ) / iterations
        
        return {
            "case_number": self.case_summary.case_number if self.case_summary else "",
            "iterations": iterations,
            "timestamp": datetime.now().isoformat(),
            "outcomes": outcomes,
            "criminal_referrals": criminal_referrals,
            "costs_to_respondents": costs_to_respondents,
            "statistics": {
                "applicant_avg_success_rate": avg_applicant_success,
                "respondents_avg_success_rate": avg_respondent_success,
                "avg_criminal_referral_likelihood": avg_criminal_likelihood
            }
        }
    
    def get_results(self) -> Dict:
        """Get comprehensive simulation results."""
        base_results = super().get_results()
        
        # Add sub-engine results
        base_results["abm_results"] = self.abm_engine.get_results()
        base_results["des_results"] = self.des_engine.get_results()
        base_results["sd_results"] = self.sd_engine.get_results()
        
        # Add case summary
        if self.case_summary:
            base_results["case_summary"] = {
                "case_number": self.case_summary.case_number,
                "case_name": self.case_summary.case_name,
                "total_losses": self.case_summary.total_losses,
                "revenue_losses": self.case_summary.total_revenue_loss,
                "trust_losses": self.case_summary.total_trust_loss,
                "financial_losses": self.case_summary.total_financial_loss
            }
        
        # Add Monte Carlo results if available
        if self.iteration_results:
            base_results["monte_carlo_results"] = self.run_monte_carlo(len(self.iteration_results))
        
        return base_results
