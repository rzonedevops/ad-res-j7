#!/usr/bin/env python3
"""
Comprehensive Legal Aspects Analysis for AD-RES-J7
Extracts entities, relations, events, and timelines from case documents
"""

import json
import re
from pathlib import Path
from datetime import datetime
from collections import defaultdict

# Define entity patterns
NATURAL_PERSONS = {
    "Peter Faucitt": ["Peter", "Peter Faucitt", "Applicant"],
    "Jacqueline Faucitt": ["Jacqueline", "Jax", "Jacqueline Faucitt"],
    "Daniel Faucitt": ["Daniel", "Dan", "Daniel Faucitt", "CIO"],
    "Rynette Farrar": ["Rynette", "Rynette Farrar"],
    "Daniel Bantjies": ["Bantjies", "Daniel Bantjies"],
    "Linda": ["Linda"],
    "Gee": ["Gee"]
}

JURISTIC_PERSONS = {
    "RegimA Skin Treatments": ["RST", "RegimA Skin Treatments"],
    "RegimA Worldwide Distribution": ["RWD", "RegimA Worldwide Distribution", "RegimA Worldwide"],
    "RegimA Zone Ltd": ["RegimA Zone Ltd", "UK company"],
    "Faucitt Family Trust": ["FFT", "Faucitt Family Trust", "Trust"],
    "Villa Via": ["Villa Via"],
    "Strategic Logistics": ["SLG", "Strategic Logistics"],
    "Rezonance": ["Rezonance"],
    "Adderory": ["Adderory"]
}

# Define relation patterns
RELATIONS = {
    "trustee_of": r"(trustee|Trustee)\s+(?:of|for)\s+(\w+)",
    "director_of": r"(director|Director)\s+(?:of|for)\s+(\w+)",
    "beneficiary_of": r"(beneficiary|Beneficiary)\s+(?:of|for)\s+(\w+)",
    "accountant_for": r"(accountant|Accountant)\s+(?:of|for)\s+(\w+)",
    "owner_of": r"(owner|Owner|owns)\s+(?:of)?\s*(\w+)",
    "ceo_of": r"CEO\s+(?:of|for)\s+(\w+)",
    "cio_of": r"CIO\s+(?:of|for)\s+(\w+)"
}

# Define legal issue patterns
LEGAL_ISSUES = {
    "fraud": r"\b(fraud|fraudulent|defraud)\b",
    "breach": r"\b(breach|breached|breaching)\b",
    "bad faith": r"\b(bad faith|mala fide)\b",
    "unjust enrichment": r"\b(unjust enrichment|enriched unjustly)\b",
    "coercion": r"\b(coercion|coerced|coercive)\b",
    "manufactured crisis": r"\b(manufactured crisis|crisis manufacturing)\b",
    "fiduciary duty": r"\b(fiduciary duty|fiduciary breach)\b",
    "conflict of interest": r"\b(conflict of interest|conflicted)\b",
    "abuse of power": r"\b(abuse of power|power abuse)\b",
    "revenue hijacking": r"\b(revenue hijacking|hijacking revenue)\b",
    "sabotage": r"\b(sabotage|sabotaged)\b"
}

# Define event patterns
EVENT_PATTERNS = {
    "payment": r"(?:payment|paid|transfer)\s+(?:of\s+)?R?([\d,]+)",
    "cancellation": r"cancel(?:led|lation)\s+(?:of\s+)?(\w+)",
    "diversion": r"divert(?:ed|ion)\s+(?:of\s+)?(\w+)",
    "discovery": r"discover(?:ed|y)\s+(?:of\s+)?(\w+)",
    "confrontation": r"confrontation|confronted",
    "interdict": r"interdict|interdicted"
}

def extract_dates(text):
    """Extract dates from text"""
    dates = []
    # Pattern: DD MMM YYYY or DD Month YYYY
    pattern1 = r'\b(\d{1,2})\s+(Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec)[a-z]*\s+(\d{4})\b'
    # Pattern: YYYY-MM-DD
    pattern2 = r'\b(\d{4})-(\d{2})-(\d{2})\b'
    
    for match in re.finditer(pattern1, text, re.IGNORECASE):
        dates.append(f"{match.group(1)} {match.group(2)} {match.group(3)}")
    
    for match in re.finditer(pattern2, text):
        dates.append(f"{match.group(1)}-{match.group(2)}-{match.group(3)}")
    
    return dates

def extract_entities(text):
    """Extract natural and juristic persons from text"""
    natural = set()
    juristic = set()
    
    for canonical, variants in NATURAL_PERSONS.items():
        for variant in variants:
            if re.search(r'\b' + re.escape(variant) + r'\b', text, re.IGNORECASE):
                natural.add(canonical)
                break
    
    for canonical, variants in JURISTIC_PERSONS.items():
        for variant in variants:
            if re.search(r'\b' + re.escape(variant) + r'\b', text, re.IGNORECASE):
                juristic.add(canonical)
                break
    
    return list(natural), list(juristic)

def extract_relations(text):
    """Extract relations between entities"""
    relations = []
    
    for rel_type, pattern in RELATIONS.items():
        for match in re.finditer(pattern, text, re.IGNORECASE):
            relations.append({
                "type": rel_type,
                "text": match.group(0)
            })
    
    return relations

def extract_legal_issues(text):
    """Extract legal issues from text"""
    issues = set()
    
    for issue, pattern in LEGAL_ISSUES.items():
        if re.search(pattern, text, re.IGNORECASE):
            issues.add(issue)
    
    return list(issues)

def extract_events(text, dates):
    """Extract events with associated dates"""
    events = []
    
    for event_type, pattern in EVENT_PATTERNS.items():
        for match in re.finditer(pattern, text, re.IGNORECASE):
            events.append({
                "type": event_type,
                "text": match.group(0),
                "value": match.group(1) if match.lastindex else None
            })
    
    return events

def analyze_file(filepath):
    """Analyze a single file for legal aspects"""
    try:
        with open(filepath, 'r', encoding='utf-8') as f:
            content = f.read()
        
        # Extract priority from filename or content
        priority_match = re.search(r'Priority:\s*(\d+)\s*-\s*(\w+)', content)
        priority = priority_match.groups() if priority_match else (None, None)
        
        # Extract topic
        topic_match = re.search(r'Topic:\s*(.+)', content)
        topic = topic_match.group(1).strip() if topic_match else "Unknown"
        
        # Extract all aspects
        natural_persons, juristic_persons = extract_entities(content)
        dates = extract_dates(content)
        relations = extract_relations(content)
        legal_issues = extract_legal_issues(content)
        events = extract_events(content, dates)
        
        return {
            "file": str(Path(filepath).name),
            "priority": priority,
            "topic": topic,
            "entities": {
                "natural_persons": sorted(natural_persons),
                "juristic_persons": sorted(juristic_persons)
            },
            "dates": sorted(set(dates)),
            "relations": relations,
            "legal_issues": sorted(legal_issues),
            "events": events,
            "content_length": len(content)
        }
    except Exception as e:
        print(f"Error analyzing {filepath}: {e}")
        return None

def main():
    """Main analysis function"""
    base_dir = Path("jax-dan-response/AD")
    
    if not base_dir.exists():
        print(f"Error: Directory {base_dir} not found")
        return
    
    results = {
        "timestamp": datetime.now().isoformat(),
        "analyses": [],
        "summary": {
            "total_files": 0,
            "natural_persons": set(),
            "juristic_persons": set(),
            "legal_issues": defaultdict(int),
            "total_dates": 0,
            "total_relations": 0,
            "total_events": 0
        }
    }
    
    # Analyze all markdown files
    for md_file in sorted(base_dir.rglob("*.md")):
        if md_file.name == "README.md":
            continue
        
        analysis = analyze_file(md_file)
        if analysis:
            results["analyses"].append(analysis)
            results["summary"]["total_files"] += 1
            results["summary"]["natural_persons"].update(analysis["entities"]["natural_persons"])
            results["summary"]["juristic_persons"].update(analysis["entities"]["juristic_persons"])
            results["summary"]["total_dates"] += len(analysis["dates"])
            results["summary"]["total_relations"] += len(analysis["relations"])
            results["summary"]["total_events"] += len(analysis["events"])
            
            for issue in analysis["legal_issues"]:
                results["summary"]["legal_issues"][issue] += 1
    
    # Convert sets to lists for JSON serialization
    results["summary"]["natural_persons"] = sorted(results["summary"]["natural_persons"])
    results["summary"]["juristic_persons"] = sorted(results["summary"]["juristic_persons"])
    results["summary"]["legal_issues"] = dict(results["summary"]["legal_issues"])
    
    # Save results
    output_file = "lex/COMPREHENSIVE_LEGAL_ASPECTS_ANALYSIS_ENHANCED.json"
    with open(output_file, 'w', encoding='utf-8') as f:
        json.dump(results, f, indent=2, ensure_ascii=False)
    
    print(f"\n{'='*80}")
    print("COMPREHENSIVE LEGAL ASPECTS ANALYSIS COMPLETE")
    print(f"{'='*80}")
    print(f"\nTotal Files Analyzed: {results['summary']['total_files']}")
    print(f"\nNatural Persons ({len(results['summary']['natural_persons'])}):")
    for person in results['summary']['natural_persons']:
        print(f"  - {person}")
    print(f"\nJuristic Persons ({len(results['summary']['juristic_persons'])}):")
    for entity in results['summary']['juristic_persons']:
        print(f"  - {entity}")
    print(f"\nLegal Issues:")
    for issue, count in sorted(results['summary']['legal_issues'].items(), key=lambda x: x[1], reverse=True):
        print(f"  - {issue}: {count} occurrences")
    print(f"\nTotal Dates: {results['summary']['total_dates']}")
    print(f"Total Relations: {results['summary']['total_relations']}")
    print(f"Total Events: {results['summary']['total_events']}")
    print(f"\nResults saved to: {output_file}")

if __name__ == "__main__":
    main()
