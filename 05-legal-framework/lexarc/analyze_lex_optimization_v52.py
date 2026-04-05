#!/usr/bin/env python3
"""
LEX SCHEME OPTIMIZATION ANALYSIS V52
Purpose: Analyze all lex scheme representations for optimization opportunities
Focus: Law resolution optimization for case 2025-137857 profile
"""

import os
import json
import re
from pathlib import Path
from collections import defaultdict

def analyze_scheme_file(filepath):
    """Analyze a single scheme file for structure and content"""
    try:
        with open(filepath, 'r', encoding='utf-8') as f:
            content = f.read()
        
        analysis = {
            'filepath': str(filepath),
            'size': len(content),
            'lines': len(content.split('\n')),
            'definitions': [],
            'legal_principles': [],
            'case_references': [],
            'verification_level': None,
            'confidence_scores': [],
            'entity_relations': [],
            'temporal_chains': [],
            'optimization_opportunities': []
        }
        
        # Extract define- statements
        define_pattern = r'\(define-(\w+)\s+([^\s]+)'
        for match in re.finditer(define_pattern, content):
            analysis['definitions'].append({
                'type': match.group(1),
                'name': match.group(2)
            })
        
        # Extract legal principles
        legal_pattern = r'\(legal-principle\s+"([^"]+)"'
        analysis['legal_principles'] = re.findall(legal_pattern, content)
        
        # Extract case references
        case_pattern = r'\*([^*]+v\.[^*]+)\*'
        analysis['case_references'] = re.findall(case_pattern, content)
        
        # Extract verification levels
        verification_pattern = r'\(verification-(?:source|level)\s+"?([^")\n]+)'
        verifications = re.findall(verification_pattern, content)
        if verifications:
            analysis['verification_level'] = 'present'
        
        # Extract confidence scores
        confidence_pattern = r'\(confidence\s+([\d.]+)\)'
        analysis['confidence_scores'] = [float(c) for c in re.findall(confidence_pattern, content)]
        
        # Extract entity relations
        relation_pattern = r'\(relation\s+([^\s]+)'
        analysis['entity_relations'] = re.findall(relation_pattern, content)
        
        # Extract temporal chains
        temporal_pattern = r'\(temporal-chain|event-\d+|date\s+"([^"]+)"'
        if 'temporal' in content.lower():
            analysis['temporal_chains'].append('present')
        
        # Identify optimization opportunities
        if not analysis['verification_level']:
            analysis['optimization_opportunities'].append('add-verification-metadata')
        
        if not analysis['confidence_scores']:
            analysis['optimization_opportunities'].append('add-confidence-scoring')
        
        if 'case-2025-137857' in content and not analysis['entity_relations']:
            analysis['optimization_opportunities'].append('add-entity-relation-links')
        
        if 'peter' in content.lower() and not analysis['temporal_chains']:
            analysis['optimization_opportunities'].append('add-temporal-analysis')
        
        # Check for outdated patterns
        if 'v1' in str(filepath) or 'v2' in str(filepath):
            analysis['optimization_opportunities'].append('version-outdated-check-for-updates')
        
        return analysis
        
    except Exception as e:
        return {'filepath': str(filepath), 'error': str(e)}

def main():
    lex_dir = Path('/home/ubuntu/ad-res-j7/lex')
    
    # Find all scheme files
    scheme_files = list(lex_dir.rglob('*.scm'))
    
    print(f"Analyzing {len(scheme_files)} scheme files...")
    
    results = {
        'total_files': len(scheme_files),
        'by_category': defaultdict(list),
        'optimization_summary': defaultdict(int),
        'verification_status': {'with_verification': 0, 'without_verification': 0},
        'confidence_status': {'with_confidence': 0, 'without_confidence': 0},
        'files': []
    }
    
    for filepath in scheme_files:
        analysis = analyze_scheme_file(filepath)
        results['files'].append(analysis)
        
        # Categorize by directory
        rel_path = filepath.relative_to(lex_dir)
        category = str(rel_path.parts[0]) if len(rel_path.parts) > 1 else 'root'
        results['by_category'][category].append(str(filepath.name))
        
        # Track optimization opportunities
        for opp in analysis.get('optimization_opportunities', []):
            results['optimization_summary'][opp] += 1
        
        # Track verification status
        if analysis.get('verification_level'):
            results['verification_status']['with_verification'] += 1
        else:
            results['verification_status']['without_verification'] += 1
        
        # Track confidence status
        if analysis.get('confidence_scores'):
            results['confidence_status']['with_confidence'] += 1
        else:
            results['confidence_status']['without_confidence'] += 1
    
    # Save results
    output_file = lex_dir / 'lex_optimization_analysis_v52.json'
    with open(output_file, 'w', encoding='utf-8') as f:
        json.dump(results, f, indent=2)
    
    print(f"\nAnalysis complete. Results saved to: {output_file}")
    print(f"\nSummary:")
    print(f"  Total files: {results['total_files']}")
    print(f"  With verification: {results['verification_status']['with_verification']}")
    print(f"  Without verification: {results['verification_status']['without_verification']}")
    print(f"  With confidence scores: {results['confidence_status']['with_confidence']}")
    print(f"  Without confidence scores: {results['confidence_status']['without_confidence']}")
    print(f"\nTop optimization opportunities:")
    for opp, count in sorted(results['optimization_summary'].items(), key=lambda x: x[1], reverse=True)[:5]:
        print(f"  {opp}: {count} files")
    
    return results

if __name__ == '__main__':
    main()
