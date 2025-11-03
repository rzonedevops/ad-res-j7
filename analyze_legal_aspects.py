#!/usr/bin/env python3
"""
Analyze AD elements and identify relevant legal aspects using lex framework
"""

import os
import json
import re
from pathlib import Path
from collections import defaultdict

# Repository paths
REPO_ROOT = Path("/home/ubuntu/ad-res-j7")
LEX_DIR = REPO_ROOT / "lex"
JAX_DAN_DIR = REPO_ROOT / "jax-dan-response"
AD_DIR = JAX_DAN_DIR / "AD"

def scan_ad_paragraphs():
    """Scan all AD paragraph files and extract key information"""
    paragraphs = []
    
    for priority_dir in AD_DIR.iterdir():
        if not priority_dir.is_dir():
            continue
            
        priority = priority_dir.name
        
        for file_path in priority_dir.glob("*.md"):
            # Extract paragraph number from filename
            match = re.search(r'PARA_([0-9_]+)', file_path.name)
            if match:
                para_num = match.group(1).replace('_', '.')
                
                # Try to find corresponding JSON file
                json_path = file_path.with_suffix('.json')
                metadata = {}
                if json_path.exists():
                    try:
                        with open(json_path) as f:
                            metadata = json.load(f)
                    except:
                        pass
                
                # Read markdown content
                with open(file_path) as f:
                    content = f.read()
                
                paragraphs.append({
                    'para_num': para_num,
                    'priority': priority,
                    'file_path': str(file_path),
                    'metadata': metadata,
                    'content': content[:500]  # First 500 chars
                })
    
    return sorted(paragraphs, key=lambda x: x['para_num'])

def identify_entities_from_content(paragraphs):
    """Identify entities mentioned in AD paragraphs"""
    entities = defaultdict(int)
    
    # Key entities to track
    entity_patterns = {
        'Peter Faucitt': r'Peter\s+Faucitt|Applicant|Peter',
        'Jacqueline Faucitt': r'Jacqueline\s+Faucitt|Jax|First\s+Respondent',
        'Daniel Faucitt': r'Daniel\s+Faucitt|Dan|Second\s+Respondent',
        'Rynette Farrar': r'Rynette\s+Farrar|Rynette|Bantjies',
        'Danie Bantjies': r'Danie\s+Bantjies|Bantjies',
        'Faucitt Family Trust': r'Faucitt\s+Family\s+Trust|FFT|Trust',
        'RegimA Skin Treatments': r'RegimA\s+Skin\s+Treatments|RST',
        'RegimA Worldwide': r'RegimA\s+Worldwide|RWD',
        'Strategic Logistics': r'Strategic\s+Logistics|SLG',
        'Villa Via': r'Villa\s+Via',
        'RegimA Zone Ltd': r'RegimA\s+Zone\s+Ltd',
        'Rezonance': r'Rezonance',
    }
    
    for para in paragraphs:
        content = para['content'] + para['metadata'].get('claim', '')
        for entity, pattern in entity_patterns.items():
            if re.search(pattern, content, re.IGNORECASE):
                entities[entity] += 1
    
    return entities

def identify_events_from_content(paragraphs):
    """Identify key events mentioned in AD paragraphs"""
    events = []
    
    # Date pattern
    date_pattern = r'(\d{1,2}\s+(?:Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec)[a-z]*\s+\d{4})'
    
    for para in paragraphs:
        content = para['content']
        dates = re.findall(date_pattern, content, re.IGNORECASE)
        
        if dates:
            # Extract context around dates
            for date in dates:
                # Get 100 chars before and after
                idx = content.lower().find(date.lower())
                if idx != -1:
                    context_start = max(0, idx - 100)
                    context_end = min(len(content), idx + len(date) + 100)
                    context = content[context_start:context_end].strip()
                    
                    events.append({
                        'date': date,
                        'para_num': para['para_num'],
                        'context': context,
                        'priority': para['priority']
                    })
    
    return events

def identify_relations():
    """Identify key legal relations between entities"""
    relations = [
        {
            'type': 'Director-Company',
            'entities': ['Peter Faucitt', 'RegimA Skin Treatments'],
            'lex_principles': ['fiduciary-duty', 'director-self-dealing-prohibition']
        },
        {
            'type': 'Trustee-Beneficiary',
            'entities': ['Peter Faucitt', 'Jacqueline Faucitt'],
            'lex_principles': ['fiduciary-duty', 'beneficiary-adverse-action-prohibition']
        },
        {
            'type': 'Trustee-Beneficiary',
            'entities': ['Peter Faucitt', 'Daniel Faucitt'],
            'lex_principles': ['fiduciary-duty', 'beneficiary-protection-when-attacked']
        },
        {
            'type': 'Related Party Transaction',
            'entities': ['RegimA Skin Treatments', 'Villa Via'],
            'lex_principles': ['director-self-dealing-prohibition', 'excessive-profit-extraction-test']
        },
        {
            'type': 'Platform Provider-User',
            'entities': ['RegimA Zone Ltd', 'RegimA Worldwide'],
            'lex_principles': ['unjust-enrichment-test', 'quantum-meruit']
        },
        {
            'type': 'Accountant-Company',
            'entities': ['Rynette Farrar', 'RegimA Skin Treatments'],
            'lex_principles': ['accountant-professional-duty', 'conflict-of-interest-prohibition']
        },
    ]
    
    return relations

def scan_lex_principles():
    """Scan lex scheme files to identify available principles"""
    principles = []
    
    for scm_file in LEX_DIR.rglob("*.scm"):
        try:
            with open(scm_file) as f:
                content = f.read()
            
            # Extract principle definitions (simplified pattern matching)
            # Look for (define-principle ...) patterns
            principle_pattern = r'\(define-principle\s+([a-z0-9-]+)'
            matches = re.findall(principle_pattern, content)
            
            for principle_name in matches:
                principles.append({
                    'name': principle_name,
                    'file': str(scm_file.relative_to(REPO_ROOT)),
                    'domain': scm_file.parent.parent.name  # e.g., 'civ', 'cmp', 'trs'
                })
        except:
            pass
    
    return principles

def generate_analysis_report():
    """Generate comprehensive legal aspects analysis report"""
    
    print("Scanning AD paragraphs...")
    paragraphs = scan_ad_paragraphs()
    
    print("Identifying entities...")
    entities = identify_entities_from_content(paragraphs)
    
    print("Identifying events...")
    events = identify_events_from_content(paragraphs)
    
    print("Identifying relations...")
    relations = identify_relations()
    
    print("Scanning lex principles...")
    lex_principles = scan_lex_principles()
    
    # Generate report
    report = []
    report.append("# Legal Aspects Analysis - AD Elements")
    report.append(f"**Generated:** {Path.cwd()}")
    report.append(f"**Date:** November 3, 2025")
    report.append("")
    report.append("## Executive Summary")
    report.append("")
    report.append(f"- **AD Paragraphs Analyzed:** {len(paragraphs)}")
    report.append(f"- **Entities Identified:** {len(entities)}")
    report.append(f"- **Events Extracted:** {len(events)}")
    report.append(f"- **Relations Mapped:** {len(relations)}")
    report.append(f"- **Lex Principles Available:** {len(lex_principles)}")
    report.append("")
    
    # Entities section
    report.append("## Entities Identified")
    report.append("")
    report.append("| Entity | Mentions | Type |")
    report.append("|--------|----------|------|")
    for entity, count in sorted(entities.items(), key=lambda x: -x[1]):
        entity_type = "Natural Person" if "Faucitt" in entity or "Farrar" in entity or "Bantjies" in entity else "Juristic Person"
        report.append(f"| {entity} | {count} | {entity_type} |")
    report.append("")
    
    # AD Paragraphs by priority
    report.append("## AD Paragraphs by Priority")
    report.append("")
    priority_counts = defaultdict(int)
    for para in paragraphs:
        priority_counts[para['priority']] += 1
    
    for priority in sorted(priority_counts.keys()):
        report.append(f"### {priority}")
        report.append(f"**Count:** {priority_counts[priority]}")
        report.append("")
        
        # List paragraphs in this priority
        priority_paras = [p for p in paragraphs if p['priority'] == priority]
        for para in priority_paras[:10]:  # Show first 10
            topic = para['metadata'].get('topic', 'No topic')
            report.append(f"- **PARA {para['para_num']}**: {topic}")
        
        if len(priority_paras) > 10:
            report.append(f"- ... and {len(priority_paras) - 10} more")
        report.append("")
    
    # Relations section
    report.append("## Key Legal Relations")
    report.append("")
    for rel in relations:
        report.append(f"### {rel['type']}")
        report.append(f"**Entities:** {' ↔ '.join(rel['entities'])}")
        report.append(f"**Applicable Lex Principles:** {', '.join(rel['lex_principles'])}")
        report.append("")
    
    # Lex principles by domain
    report.append("## Lex Principles by Domain")
    report.append("")
    domain_principles = defaultdict(list)
    for principle in lex_principles:
        domain_principles[principle['domain']].append(principle)
    
    for domain in sorted(domain_principles.keys()):
        report.append(f"### {domain.upper()} Domain")
        report.append(f"**Principles:** {len(domain_principles[domain])}")
        report.append("")
        
        # Show first 20 principles
        for principle in domain_principles[domain][:20]:
            report.append(f"- `{principle['name']}` ({principle['file']})")
        
        if len(domain_principles[domain]) > 20:
            report.append(f"- ... and {len(domain_principles[domain]) - 20} more")
        report.append("")
    
    # Timeline events
    report.append("## Timeline Events (Sample)")
    report.append("")
    report.append("| Date | Paragraph | Context |")
    report.append("|------|-----------|---------|")
    for event in events[:30]:  # Show first 30 events
        context = event['context'][:80].replace('\n', ' ').replace('|', '\\|')
        report.append(f"| {event['date']} | {event['para_num']} | {context}... |")
    report.append("")
    
    return '\n'.join(report)

if __name__ == "__main__":
    report = generate_analysis_report()
    
    # Save report
    output_path = REPO_ROOT / "LEGAL_ASPECTS_ANALYSIS_2025-11-03.md"
    with open(output_path, 'w') as f:
        f.write(report)
    
    print(f"\n✅ Analysis complete! Report saved to: {output_path}")
    print(f"\nReport length: {len(report)} characters")
