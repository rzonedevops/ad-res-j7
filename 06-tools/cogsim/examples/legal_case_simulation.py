#!/usr/bin/env python3
"""
CogSim Legal Case Simulation Example
Case 2025-137857: Peter Faucitt v. Jacqueline Faucitt et al.

This example demonstrates the hybrid multi-paradigm simulation combining:
- Agent-Based Modeling (ABM) for actor behaviors
- Discrete-Event Simulation (DES) for timeline events
- System Dynamics (SD) for financial flows and case outcomes
"""

import json
import os
from datetime import datetime
from pathlib import Path

# Add parent directory to path for imports
import sys
sys.path.insert(0, str(Path(__file__).parent.parent.parent))

from cogsim.hybrid.integration import HybridEngine
from cogsim.core.base import LogLevel


def load_forensic_data(file_path: str) -> dict:
    """Load forensic events data from JSON file."""
    with open(file_path, 'r') as f:
        return json.load(f)


def run_simulation(forensic_data: dict, iterations: int = 100) -> dict:
    """
    Run the complete legal case simulation.
    
    Args:
        forensic_data: Dictionary containing forensic events data
        iterations: Number of Monte Carlo iterations
    
    Returns:
        Dictionary containing simulation results
    """
    # Initialize hybrid engine
    engine = HybridEngine(
        name="Case 2025-137857 Simulation",
        seed=42,
        start_date=datetime(2017, 1, 1)
    )
    
    # Set log level
    engine.log_level = LogLevel.INFO
    
    # Load case data
    engine.load_case_data(forensic_data)
    
    # Run the timeline simulation
    print("Running timeline simulation...")
    engine.run(end_time=3200)  # ~8.7 years from 2017
    
    # Run Monte Carlo analysis
    print(f"Running Monte Carlo simulation ({iterations} iterations)...")
    monte_carlo_results = engine.run_monte_carlo(iterations)
    
    # Get comprehensive results
    results = engine.get_results()
    results["monte_carlo_summary"] = monte_carlo_results
    
    return results


def print_summary(results: dict) -> None:
    """Print a summary of simulation results."""
    print("\n" + "="*60)
    print("LEGAL CASE SIMULATION RESULTS")
    print("="*60)
    
    # Case summary
    case_summary = results.get("case_summary", {})
    print(f"\nCase Number: {case_summary.get('case_number', 'N/A')}")
    print(f"Case Name: {case_summary.get('case_name', 'N/A')}")
    
    # Financial losses
    print(f"\nTotal Losses: R{case_summary.get('total_losses', 0):,.2f}")
    print(f"  - Revenue Losses: R{case_summary.get('revenue_losses', 0):,.2f}")
    print(f"  - Trust Losses: R{case_summary.get('trust_losses', 0):,.2f}")
    print(f"  - Financial Losses: R{case_summary.get('financial_losses', 0):,.2f}")
    
    # Monte Carlo results
    mc_results = results.get("monte_carlo_summary", {})
    print(f"\nMonte Carlo Analysis ({mc_results.get('iterations', 0)} iterations):")
    print(f"  Outcomes:")
    for outcome, count in mc_results.get("outcomes", {}).items():
        print(f"    - {outcome}: {count}")
    
    stats = mc_results.get("statistics", {})
    print(f"\n  Statistics:")
    print(f"    - Applicant Avg Success Rate: {stats.get('applicant_avg_success_rate', 0):.2%}")
    print(f"    - Respondent Avg Success Rate: {stats.get('respondents_avg_success_rate', 0):.2%}")
    print(f"    - Avg Criminal Referral Likelihood: {stats.get('avg_criminal_referral_likelihood', 0):.2%}")
    
    print(f"\n  Criminal Referrals: {mc_results.get('criminal_referrals', 0)}")
    print(f"  Costs to Respondents: {mc_results.get('costs_to_respondents', 0)}")
    
    # SD Model final state
    sd_results = results.get("sd_results", {})
    case_analysis = sd_results.get("case_analysis", {})
    print(f"\nSystem Dynamics Final State:")
    print(f"  - Evidence Strength: {case_analysis.get('evidence_strength', 0):.2%}")
    print(f"  - Respondent Case Strength: {case_analysis.get('respondent_case_strength', 0):.2%}")
    print(f"  - Criminal Referral Likelihood: {case_analysis.get('criminal_referral_likelihood', 0):.2%}")
    
    # ABM Network metrics
    abm_results = results.get("abm_results", {})
    network = abm_results.get("network_metrics", {})
    print(f"\nAgent-Based Model Metrics:")
    print(f"  - Total Agents: {network.get('total_agents', 0)}")
    print(f"  - Perpetrators: {network.get('perpetrators', 0)}")
    print(f"  - Victims: {network.get('victims', 0)}")
    print(f"  - Total Diverted Funds: R{network.get('total_diverted_funds', 0):,.2f}")
    
    # DES Timeline summary
    des_results = results.get("des_results", {})
    timeline = des_results.get("timeline_summary", {})
    print(f"\nDiscrete-Event Simulation:")
    print(f"  - Total Events: {timeline.get('total_events', 0)}")
    print(f"  - Processed Events: {timeline.get('processed_events', 0)}")
    print(f"  - Current Phase: {timeline.get('current_phase', 'N/A')}")
    
    print("\n" + "="*60)


def main():
    """Main entry point for the simulation."""
    # Find the forensic data file
    script_dir = Path(__file__).parent.parent.parent
    forensic_data_path = script_dir / "forensic-events-data.json"
    
    if not forensic_data_path.exists():
        print(f"Error: Forensic data file not found at {forensic_data_path}")
        print("Creating sample data...")
        
        # Create sample forensic data
        forensic_data = {
            "caseNumber": "2025-137857",
            "caseName": "Peter Faucitt v. Jacqueline Faucitt et al.",
            "totalLosses": {
                "revenue": "R3,141,647.70",
                "trust": "R2,851,247.35",
                "financial": "R4,276,832.85",
                "total": "R10,269,727.90"
            },
            "events": [
                {
                    "id": 1,
                    "date": "2025-03-15",
                    "title": "Trust Structure Establishment",
                    "category": "trust",
                    "perpetrators": ["Peter Faucitt"],
                    "crimeType": "Fraudulent trust establishment",
                    "description": "Fraudulent trust establishment with intentional structural flaws.",
                    "impact": "Foundation for R2.85M+ trust violations",
                    "legalSignificance": "Initial documentation of trust structure manipulation",
                    "shopifyConnection": False,
                    "evidenceReferences": []
                },
                {
                    "id": 2,
                    "date": "2025-04-14",
                    "title": "Bank Account Change Letter",
                    "category": "revenue",
                    "perpetrators": ["Rynette Farrar"],
                    "crimeType": "Fraudulent redirection of funds",
                    "description": "Rynette Farrar sends fraudulent letter to clients redirecting payments.",
                    "impact": "R3,141,647.70",
                    "legalSignificance": "First documented act in coordinated scheme",
                    "shopifyConnection": True,
                    "shopifyNote": "Bank changes targeted revenue from Shopify platform",
                    "evidenceReferences": []
                },
                {
                    "id": 3,
                    "date": "2025-05-22",
                    "title": "Shopify Audit Trail Hijacking",
                    "category": "revenue",
                    "perpetrators": ["Coordinated action"],
                    "crimeType": "Evidence destruction, computer fraud",
                    "description": "Complete destruction of Shopify audit trails.",
                    "impact": "R1,000,000",
                    "legalSignificance": "Central evidence destruction event",
                    "shopifyConnection": True,
                    "shopifyNote": "CRITICAL: Audit trail destroyed",
                    "evidenceReferences": []
                }
            ]
        }
    else:
        forensic_data = load_forensic_data(str(forensic_data_path))
    
    # Run simulation
    print("Starting Legal Case Simulation...")
    print(f"Case: {forensic_data.get('caseNumber', 'Unknown')}")
    
    results = run_simulation(forensic_data, iterations=100)
    
    # Print summary
    print_summary(results)
    
    # Save results
    output_path = script_dir / "cogsim_simulation_results.json"
    with open(output_path, 'w') as f:
        # Convert non-serializable objects
        def default_serializer(obj):
            if hasattr(obj, '__dict__'):
                return obj.__dict__
            elif hasattr(obj, 'value'):
                return obj.value
            return str(obj)
        
        json.dump(results, f, indent=2, default=default_serializer)
    
    print(f"\nResults saved to: {output_path}")
    
    return results


if __name__ == "__main__":
    main()
