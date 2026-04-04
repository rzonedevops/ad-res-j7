#!/usr/bin/env python3
"""
Comprehensive Legal Aspects Analysis and Lex Refinement Script
Analyzes AD paragraphs, identifies legal aspects, and generates refined lex schemes
"""

import os
import json
import re
from datetime import datetime
from collections import defaultdict
from pathlib import Path

# Configuration
BASE_DIR = Path("/home/ubuntu/ad-res-j7")
LEX_DIR = BASE_DIR / "lex"
JAX_DAN_DIR = BASE_DIR / "jax-dan-response"
AD_DIR = JAX_DAN_DIR / "AD"
OUTPUT_DIR = LEX_DIR

# Legal issue patterns
LEGAL_PATTERNS = {
    "sabotage": r"\b(sabotage|sabotaging|interference|disruption|obstruction)\b",
    "bad_faith": r"\b(bad faith|malicious|ulterior motive|improper purpose|abuse of process)\b",
    "fraud": r"\b(fraud|fraudulent|misrepresentation|deception|concealment)\b",
    "breach": r"\b(breach of duty|breach of trust|breach of fiduciary|breach of contract)\b",
    "manufactured_crisis": r"\b(manufactured|artificial urgency|contrived|fabricated crisis)\b",
    "unjust_enrichment": r"\b(unjust enrichment|uncompensated|without payment|no consideration)\b",
    "conflict_of_interest": r"\b(conflict of interest|conflicting roles|dual capacity|incompatible)\b",
    "coercion": r"\b(coercion|duress|pressure|forced|compelled)\b",
    "retaliation": r"\b(retaliation|retaliatory|revenge|punitive)\b",
    "temporal_bad_faith": r"\b(timing|immediately after|coincidence|strategic timing)\b",
}

# Entity patterns
ENTITY_PATTERNS = {
    "natural_persons": [
        "Peter Faucitt", "Jacqueline Faucitt", "Daniel Faucitt",
        "Rynette Farrar", "Daniel Bantjies", "Gee"
    ],
    "juristic_persons": [
        "Faucitt Family Trust", "FFT",
        "RegimA Skin Treatments", "RST",
        "RegimA Worldwide Distribution", "RWD",
        "RegimA Zone Ltd", "RZL"
    ]
}

# Date pattern
DATE_PATTERN = r'\b(\d{1,2}\s+(?:Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec)[a-z]*\s+\d{4})\b'

def analyze_file(filepath):
    """Analyze a single markdown file for legal aspects"""
    with open(filepath, 'r', encoding='utf-8') as f:
        content = f.read()
    
    analysis = {
        "file": filepath.name,
        "entities": {"natural_persons": set(), "juristic_persons": set()},
        "dates": set(),
        "legal_issues": set(),
        "events": [],
        "relations": []
    }
    
    # Extract entities
    for person in ENTITY_PATTERNS["natural_persons"]:
        if person in content:
            analysis["entities"]["natural_persons"].add(person)
    
    for entity in ENTITY_PATTERNS["juristic_persons"]:
        if entity in content:
            analysis["entities"]["juristic_persons"].add(entity)
    
    # Extract dates
    dates = re.findall(DATE_PATTERN, content, re.IGNORECASE)
    analysis["dates"] = set(dates)
    
    # Identify legal issues
    for issue, pattern in LEGAL_PATTERNS.items():
        if re.search(pattern, content, re.IGNORECASE):
            analysis["legal_issues"].add(issue)
    
    # Convert sets to lists for JSON serialization
    analysis["entities"]["natural_persons"] = sorted(list(analysis["entities"]["natural_persons"]))
    analysis["entities"]["juristic_persons"] = sorted(list(analysis["entities"]["juristic_persons"]))
    analysis["dates"] = sorted(list(analysis["dates"]))
    analysis["legal_issues"] = sorted(list(analysis["legal_issues"]))
    
    return analysis

def analyze_all_ad_files():
    """Analyze all AD files across priority levels"""
    all_analyses = []
    
    for priority_dir in sorted(AD_DIR.iterdir()):
        if priority_dir.is_dir() and not priority_dir.name.startswith('.'):
            print(f"\nAnalyzing: {priority_dir.name}")
            print("-" * 80)
            
            for md_file in sorted(priority_dir.glob("*.md")):
                if md_file.name != "README.md":
                    analysis = analyze_file(md_file)
                    analysis["priority"] = priority_dir.name
                    all_analyses.append(analysis)
                    print(f"  {md_file.name}")
                    print(f"    Natural persons: {len(analysis['entities']['natural_persons'])}")
                    print(f"    Juristic persons: {len(analysis['entities']['juristic_persons'])}")
                    print(f"    Dates: {len(analysis['dates'])}")
                    print(f"    Legal issues: {analysis['legal_issues']}")
    
    return all_analyses

def generate_summary_statistics(analyses):
    """Generate summary statistics from all analyses"""
    stats = {
        "total_files": len(analyses),
        "natural_persons": set(),
        "juristic_persons": set(),
        "dates": set(),
        "legal_issues": defaultdict(int),
        "files_by_priority": defaultdict(int)
    }
    
    for analysis in analyses:
        stats["natural_persons"].update(analysis["entities"]["natural_persons"])
        stats["juristic_persons"].update(analysis["entities"]["juristic_persons"])
        stats["dates"].update(analysis["dates"])
        stats["files_by_priority"][analysis["priority"]] += 1
        
        for issue in analysis["legal_issues"]:
            stats["legal_issues"][issue] += 1
    
    # Convert sets to sorted lists
    stats["natural_persons"] = sorted(list(stats["natural_persons"]))
    stats["juristic_persons"] = sorted(list(stats["juristic_persons"]))
    stats["dates"] = sorted(list(stats["dates"]))
    stats["legal_issues"] = dict(sorted(stats["legal_issues"].items(), key=lambda x: x[1], reverse=True))
    
    return stats

def generate_refinement_recommendations(stats):
    """Generate lex refinement recommendations based on analysis"""
    recommendations = []
    
    # Recommendation 1: Entity-specific schemes
    recommendations.append({
        "type": "entity_modeling",
        "priority": "high",
        "description": "Create agent-based entity models for all identified persons",
        "entities": {
            "natural_persons": stats["natural_persons"],
            "juristic_persons": stats["juristic_persons"]
        },
        "implementation": "Extend south_african_civil_law_case_2025_137857_optimized.scm with complete agent definitions"
    })
    
    # Recommendation 2: Legal issue frameworks
    recommendations.append({
        "type": "legal_frameworks",
        "priority": "critical",
        "description": "Implement resolution frameworks for all identified legal issues",
        "legal_issues": list(stats["legal_issues"].keys()),
        "implementation": "Create resolve-* functions for each legal issue with evidence mapping"
    })
    
    # Recommendation 3: Temporal analysis
    recommendations.append({
        "type": "temporal_analysis",
        "priority": "high",
        "description": "Implement temporal pattern detection for all timeline dates",
        "date_count": len(stats["dates"]),
        "implementation": "Enhance temporal analysis functions to detect retaliation patterns"
    })
    
    # Recommendation 4: Evidence mapping
    recommendations.append({
        "type": "evidence_mapping",
        "priority": "high",
        "description": "Map evidence to legal principles for each AD paragraph",
        "implementation": "Create evidence-strength calculation functions"
    })
    
    return recommendations

def main():
    """Main execution function"""
    print("=" * 80)
    print("COMPREHENSIVE LEGAL ASPECTS ANALYSIS AND LEX REFINEMENT")
    print("=" * 80)
    print(f"Timestamp: {datetime.now().isoformat()}")
    print(f"Repository: {BASE_DIR}")
    print()
    
    # Analyze all AD files
    analyses = analyze_all_ad_files()
    
    # Generate statistics
    print("\n" + "=" * 80)
    print("SUMMARY STATISTICS")
    print("=" * 80)
    stats = generate_summary_statistics(analyses)
    
    print(f"\nTotal files analyzed: {stats['total_files']}")
    print(f"\nNatural persons identified: {len(stats['natural_persons'])}")
    for person in stats["natural_persons"]:
        print(f"  - {person}")
    
    print(f"\nJuristic persons identified: {len(stats['juristic_persons'])}")
    for entity in stats["juristic_persons"]:
        print(f"  - {entity}")
    
    print(f"\nDates extracted: {len(stats['dates'])}")
    print(f"Date range: {stats['dates'][0] if stats['dates'] else 'N/A'} to {stats['dates'][-1] if stats['dates'] else 'N/A'}")
    
    print(f"\nLegal issues by frequency:")
    for issue, count in stats["legal_issues"].items():
        print(f"  {issue}: {count} occurrences")
    
    print(f"\nFiles by priority:")
    for priority, count in stats["files_by_priority"].items():
        print(f"  {priority}: {count} files")
    
    # Generate recommendations
    print("\n" + "=" * 80)
    print("LEX REFINEMENT RECOMMENDATIONS")
    print("=" * 80)
    recommendations = generate_refinement_recommendations(stats)
    
    for i, rec in enumerate(recommendations, 1):
        print(f"\n{i}. {rec['type'].upper().replace('_', ' ')}")
        print(f"   Priority: {rec['priority']}")
        print(f"   Description: {rec['description']}")
        print(f"   Implementation: {rec['implementation']}")
    
    # Save results
    output_file = OUTPUT_DIR / f"LEGAL_ASPECTS_ANALYSIS_{datetime.now().strftime('%Y-%m-%d')}.json"
    output_data = {
        "timestamp": datetime.now().isoformat(),
        "statistics": stats,
        "recommendations": recommendations,
        "detailed_analyses": analyses
    }
    
    with open(output_file, 'w', encoding='utf-8') as f:
        json.dump(output_data, f, indent=2, ensure_ascii=False)
    
    print(f"\n\nResults saved to: {output_file}")
    print("\nAnalysis complete!")

if __name__ == "__main__":
    main()
