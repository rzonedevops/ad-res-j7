#!/usr/bin/env python3
"""
LEX SCHEME ANALYSIS V65
Comprehensive analysis of all lex scheme files to identify:
1. Entity-relation framework completeness
2. Legal aspects coverage
3. Verification gaps
4. AD paragraph integration
5. JR-DR synergy optimization opportunities
"""

import os
import re
import json
from pathlib import Path
from collections import defaultdict

def analyze_scheme_file(filepath):
    """Analyze a single scheme file for key metrics"""
    with open(filepath, 'r', encoding='utf-8') as f:
        content = f.read()
    
    analysis = {
        'filepath': str(filepath),
        'filename': os.path.basename(filepath),
        'size': len(content),
        'lines': len(content.split('\n')),
        'entities': [],
        'relations': [],
        'legal_aspects': [],
        'ad_paragraphs': [],
        'verification_level': None,
        'confidence_scores': [],
        'agent_states': [],
        'temporal_chains': []
    }
    
    # Extract entities (AGENT-* patterns)
    entities = re.findall(r'AGENT-[A-Z]+-\d+-V\d+', content)
    analysis['entities'] = list(set(entities))
    
    # Extract relations (REL-* patterns)
    relations = re.findall(r'REL-\d+-V\d+', content)
    analysis['relations'] = list(set(relations))
    
    # Extract legal aspects (LEGAL-ASPECT-* patterns)
    legal_aspects = re.findall(r'LEGAL-ASPECT-\d+-V\d+', content)
    analysis['legal_aspects'] = list(set(legal_aspects))
    
    # Extract AD paragraph references
    ad_refs = re.findall(r'(?:AD|ad-paragraph)["\s]+(\d+(?:\.\d+)?)', content)
    analysis['ad_paragraphs'] = sorted(list(set(ad_refs)))
    
    # Extract verification level
    ver_match = re.search(r'verification-level["\s]+(\d+)', content)
    if ver_match:
        analysis['verification_level'] = int(ver_match.group(1))
    
    # Extract confidence scores
    conf_scores = re.findall(r'confidence["\s]+(\d+\.\d+)', content)
    analysis['confidence_scores'] = [float(s) for s in conf_scores]
    
    # Extract agent state dimensions
    dimensions = re.findall(r'dimension["\s]+"([^"]+)"', content)
    analysis['agent_states'] = list(set(dimensions))
    
    # Extract temporal chains
    temporal = re.findall(r'temporal-(?:event|chain|causation)', content)
    analysis['temporal_chains'] = len(temporal)
    
    return analysis

def main():
    lex_dir = Path('/home/ubuntu/ad-res-j7/lex')
    
    # Find all .scm files
    scheme_files = list(lex_dir.glob('*.scm'))
    
    print(f"Found {len(scheme_files)} scheme files")
    
    all_analyses = []
    
    for filepath in sorted(scheme_files):
        try:
            analysis = analyze_scheme_file(filepath)
            all_analyses.append(analysis)
        except Exception as e:
            print(f"Error analyzing {filepath}: {e}")
    
    # Aggregate statistics
    stats = {
        'total_files': len(all_analyses),
        'total_entities': sum(len(a['entities']) for a in all_analyses),
        'total_relations': sum(len(a['relations']) for a in all_analyses),
        'total_legal_aspects': sum(len(a['legal_aspects']) for a in all_analyses),
        'unique_entities': set(),
        'unique_relations': set(),
        'unique_legal_aspects': set(),
        'ad_paragraph_coverage': set(),
        'avg_confidence': 0,
        'verification_levels': defaultdict(int),
        'agent_state_dimensions': set(),
        'files_by_version': defaultdict(list)
    }
    
    all_confidences = []
    
    for analysis in all_analyses:
        stats['unique_entities'].update(analysis['entities'])
        stats['unique_relations'].update(analysis['relations'])
        stats['unique_legal_aspects'].update(analysis['legal_aspects'])
        stats['ad_paragraph_coverage'].update(analysis['ad_paragraphs'])
        all_confidences.extend(analysis['confidence_scores'])
        stats['agent_state_dimensions'].update(analysis['agent_states'])
        
        if analysis['verification_level']:
            stats['verification_levels'][analysis['verification_level']] += 1
        
        # Extract version from filename
        ver_match = re.search(r'_v(\d+)_', analysis['filename'])
        if ver_match:
            version = int(ver_match.group(1))
            stats['files_by_version'][version].append(analysis['filename'])
    
    if all_confidences:
        stats['avg_confidence'] = sum(all_confidences) / len(all_confidences)
    
    # Convert sets to sorted lists for JSON serialization
    stats['unique_entities'] = sorted(list(stats['unique_entities']))
    stats['unique_relations'] = sorted(list(stats['unique_relations']))
    stats['unique_legal_aspects'] = sorted(list(stats['unique_legal_aspects']))
    stats['ad_paragraph_coverage'] = sorted(list(stats['ad_paragraph_coverage']))
    stats['agent_state_dimensions'] = sorted(list(stats['agent_state_dimensions']))
    stats['verification_levels'] = dict(stats['verification_levels'])
    stats['files_by_version'] = dict(stats['files_by_version'])
    
    # Find latest version files
    latest_version = max(stats['files_by_version'].keys()) if stats['files_by_version'] else 0
    latest_files = stats['files_by_version'].get(latest_version, [])
    
    # Generate report
    report = {
        'analysis_date': '2026-01-11',
        'analysis_version': '65.0',
        'summary': stats,
        'latest_version': latest_version,
        'latest_files': latest_files,
        'detailed_analyses': all_analyses
    }
    
    # Save report
    output_path = lex_dir / 'lex_analysis_report_v65.json'
    with open(output_path, 'w', encoding='utf-8') as f:
        json.dump(report, f, indent=2)
    
    print(f"\n=== LEX SCHEME ANALYSIS V65 ===")
    print(f"Total files analyzed: {stats['total_files']}")
    print(f"Latest version: v{latest_version}")
    print(f"Latest files: {len(latest_files)}")
    print(f"\nUnique entities: {len(stats['unique_entities'])}")
    print(f"Unique relations: {len(stats['unique_relations'])}")
    print(f"Unique legal aspects: {len(stats['unique_legal_aspects'])}")
    print(f"AD paragraph coverage: {len(stats['ad_paragraph_coverage'])} paragraphs")
    print(f"Average confidence: {stats['avg_confidence']:.3f}")
    print(f"Agent state dimensions: {len(stats['agent_state_dimensions'])}")
    print(f"\nVerification levels:")
    for level, count in sorted(stats['verification_levels'].items()):
        print(f"  Level {level}: {count} instances")
    
    print(f"\nReport saved to: {output_path}")
    
    return report

if __name__ == '__main__':
    main()
