#!/usr/bin/env python3
"""
Legal Aspects Analysis Script
Extracts entities, relations, events, and timelines from AD paragraphs
"""

import os
import json
import re
from pathlib import Path
from datetime import datetime
from collections import defaultdict

# Repository paths
REPO_ROOT = Path("/home/ubuntu/ad-res-j7")
AD_DIR = REPO_ROOT / "jax-dan-response" / "AD"
LEX_DIR = REPO_ROOT / "lex"

# Entity types
ENTITIES = {
    "natural_persons": [
        "Peter Faucitt",
        "Jacqueline Faucitt", "Jax",
        "Daniel Faucitt", "Dan",
        "Danie Bantjies",
        "Rynette Farrar"
    ],
    "juristic_persons": [
        "Faucitt Family Trust", "FFT",
        "RegimA Skin Treatments", "RST",
        "RegimA Worldwide Distribution", "RWD",
        "Strategic Logistics Group", "SLG",
        "Villa Via",
        "RegimA Zone Ltd",
        "Adderory",
        "Rezonance"
    ]
}

# Date pattern
DATE_PATTERN = r'\b(\d{1,2}\s+(?:Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec)[a-z]*\s+\d{4}|\d{4}-\d{2}-\d{2})\b'

def extract_dates_from_text(text):
    """Extract dates from text"""
    dates = re.findall(DATE_PATTERN, text, re.IGNORECASE)
    return dates

def extract_entities_from_text(text):
    """Extract entity mentions from text"""
    found_entities = defaultdict(list)
    
    for entity_type, entities in ENTITIES.items():
        for entity in entities:
            if entity.lower() in text.lower():
                found_entities[entity_type].append(entity)
    
    return dict(found_entities)

def analyze_ad_paragraph(file_path):
    """Analyze a single AD paragraph file"""
    with open(file_path, 'r', encoding='utf-8') as f:
        content = f.read()
    
    # Extract metadata
    priority_match = re.search(r'Priority:\s*(\d+)\s*-\s*(\w+)', content, re.IGNORECASE)
    topic_match = re.search(r'Topic:\s*(.+)', content, re.IGNORECASE)
    
    priority = priority_match.groups() if priority_match else (None, None)
    topic = topic_match.group(1).strip() if topic_match else None
    
    # Extract entities
    entities = extract_entities_from_text(content)
    
    # Extract dates
    dates = extract_dates_from_text(content)
    
    # Extract legal issues (look for keywords)
    legal_keywords = [
        "fiduciary duty", "breach", "fraud", "unjust enrichment",
        "self-dealing", "conflict of interest", "bad faith",
        "abuse of process", "constitutional", "delict",
        "coercion", "manufactured crisis", "retaliation"
    ]
    
    found_legal_issues = [kw for kw in legal_keywords if kw.lower() in content.lower()]
    
    return {
        "file": str(file_path.relative_to(REPO_ROOT)),
        "priority": priority,
        "topic": topic,
        "entities": entities,
        "dates": dates,
        "legal_issues": found_legal_issues,
        "content_length": len(content)
    }

def main():
    """Main analysis function"""
    print("=" * 80)
    print("LEGAL ASPECTS ANALYSIS - ENTITIES, RELATIONS, EVENTS, TIMELINES")
    print("=" * 80)
    print()
    
    # Analyze all AD paragraphs
    all_analyses = []
    
    for priority_dir in sorted(AD_DIR.glob("*-*")):
        if not priority_dir.is_dir():
            continue
        
        print(f"\nAnalyzing: {priority_dir.name}")
        print("-" * 80)
        
        for md_file in sorted(priority_dir.glob("PARA_*.md")):
            analysis = analyze_ad_paragraph(md_file)
            all_analyses.append(analysis)
            
            print(f"  {md_file.name}")
            print(f"    Priority: {analysis['priority']}")
            print(f"    Topic: {analysis['topic']}")
            print(f"    Entities: {len(analysis['entities'])} types")
            print(f"    Dates: {len(analysis['dates'])} found")
            print(f"    Legal Issues: {len(analysis['legal_issues'])} identified")
    
    # Aggregate statistics
    print("\n" + "=" * 80)
    print("AGGREGATE STATISTICS")
    print("=" * 80)
    
    all_entities = defaultdict(set)
    all_dates = set()
    all_legal_issues = defaultdict(int)
    
    for analysis in all_analyses:
        for entity_type, entities in analysis['entities'].items():
            all_entities[entity_type].update(entities)
        all_dates.update(analysis['dates'])
        for issue in analysis['legal_issues']:
            all_legal_issues[issue] += 1
    
    print(f"\nTotal AD Paragraphs Analyzed: {len(all_analyses)}")
    print(f"\nEntities Identified:")
    for entity_type, entities in all_entities.items():
        print(f"  {entity_type}: {len(entities)} unique")
        for entity in sorted(entities):
            print(f"    - {entity}")
    
    print(f"\nTimeline Events: {len(all_dates)} unique dates")
    print(f"\nLegal Issues (by frequency):")
    for issue, count in sorted(all_legal_issues.items(), key=lambda x: x[1], reverse=True):
        print(f"  {issue}: {count} mentions")
    
    # Save results
    output_file = LEX_DIR / f"LEGAL_ASPECTS_ANALYSIS_{datetime.now().strftime('%Y-%m-%d')}.json"
    with open(output_file, 'w', encoding='utf-8') as f:
        json.dump({
            "timestamp": datetime.now().isoformat(),
            "analyses": all_analyses,
            "aggregates": {
                "total_paragraphs": len(all_analyses),
                "entities": {k: list(v) for k, v in all_entities.items()},
                "dates": sorted(list(all_dates)),
                "legal_issues": dict(all_legal_issues)
            }
        }, f, indent=2)
    
    print(f"\nResults saved to: {output_file}")

if __name__ == "__main__":
    main()
