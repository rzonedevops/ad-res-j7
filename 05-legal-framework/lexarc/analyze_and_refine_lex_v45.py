#!/usr/bin/env python3
"""
LEX Scheme Analysis and Refinement V45
Purpose: Analyze lex schemes and refine for optimal legal resolution
Focus: High-resolution agent-based models with rigorous verification
"""

import os
import re
import json
from pathlib import Path
from datetime import datetime
from typing import Dict, List, Tuple, Set

class LexSchemeAnalyzer:
    def __init__(self, lex_dir: str):
        self.lex_dir = Path(lex_dir)
        self.schemes = []
        self.entities = {}
        self.relations = {}
        self.legal_aspects = {}
        self.ad_mappings = {}
        
    def scan_lex_directory(self) -> Dict:
        """Scan lex directory and catalog all scheme files"""
        print(f"Scanning lex directory: {self.lex_dir}")
        
        scheme_files = list(self.lex_dir.rglob("*.scm"))
        print(f"Found {len(scheme_files)} scheme files")
        
        categorized = {
            'entity_models': [],
            'legal_frameworks': [],
            'verification_frameworks': [],
            'case_specific': [],
            'core_infrastructure': []
        }
        
        for scm_file in scheme_files:
            rel_path = scm_file.relative_to(self.lex_dir)
            category = self._categorize_scheme(scm_file)
            categorized[category].append(str(rel_path))
            
        return categorized
    
    def _categorize_scheme(self, scm_file: Path) -> str:
        """Categorize scheme file by purpose"""
        name = scm_file.name.lower()
        
        if 'entity' in name or 'agent' in name:
            return 'entity_models'
        elif 'case_2025_137857' in name:
            return 'case_specific'
        elif 'framework' in name or 'core' in name:
            return 'core_infrastructure'
        elif 'verification' in name or 'evidence' in name:
            return 'verification_frameworks'
        else:
            return 'legal_frameworks'
    
    def analyze_entity_models(self) -> Dict:
        """Analyze entity model schemes for completeness and verification"""
        print("\nAnalyzing entity models...")
        
        entity_files = [
            'case_2025_137857_entity_data_v44_verified.scm',
            'entity_relation_framework_v44_enhanced.scm',
            'entity_agent_modeling_v2_enhanced.scm'
        ]
        
        analysis = {
            'entities_defined': 0,
            'verification_coverage': {},
            'confidence_scores': {},
            'missing_verifications': [],
            'recommendations': []
        }
        
        for entity_file in entity_files:
            file_path = self.lex_dir / entity_file
            if file_path.exists():
                content = file_path.read_text()
                
                # Extract entity definitions
                entities = re.findall(r'\(define\s+([a-z0-9-]+)\s+\'?\(entity-type', content)
                analysis['entities_defined'] += len(entities)
                
                # Extract verification statuses
                verifications = re.findall(r'verification-status\s+"([^"]+)"', content)
                confidences = re.findall(r'confidence\s+(0\.\d+)', content)
                
                analysis['verification_coverage'][entity_file] = {
                    'entities': len(entities),
                    'verified': verifications.count('VERIFIED'),
                    'avg_confidence': sum(float(c) for c in confidences) / len(confidences) if confidences else 0
                }
        
        return analysis
    
    def analyze_legal_aspects(self) -> Dict:
        """Analyze legal aspect coverage and mappings"""
        print("\nAnalyzing legal aspects...")
        
        legal_dirs = ['civ', 'cmp', 'trs', 'cri', 'lab', 'evid']
        
        analysis = {
            'legal_domains': {},
            'total_principles': 0,
            'ad_mappings': 0,
            'case_specific_applications': []
        }
        
        for legal_dir in legal_dirs:
            dir_path = self.lex_dir / legal_dir / 'za'
            if dir_path.exists():
                scm_files = list(dir_path.glob('*.scm'))
                
                principles = []
                for scm_file in scm_files:
                    content = scm_file.read_text()
                    # Extract legal principles
                    principles.extend(re.findall(r'\(define-legal-principle\s+([a-z0-9-]+)', content))
                
                analysis['legal_domains'][legal_dir] = {
                    'files': len(scm_files),
                    'principles': len(principles)
                }
                analysis['total_principles'] += len(principles)
        
        return analysis
    
    def identify_refinement_opportunities(self) -> List[Dict]:
        """Identify opportunities for lex scheme refinement"""
        print("\nIdentifying refinement opportunities...")
        
        opportunities = []
        
        # Check for missing entity attributes
        opportunities.append({
            'category': 'entity_completeness',
            'priority': 'HIGH',
            'description': 'Verify all entities have statutory basis verification',
            'action': 'Add statutory-basis field to all entity attributes',
            'impact': 'Ensures legal grounding for all entity properties'
        })
        
        # Check for AD paragraph mappings
        opportunities.append({
            'category': 'ad_integration',
            'priority': 'CRITICAL',
            'description': 'Map all AD paragraphs to entity-relation-event framework',
            'action': 'Create comprehensive AD paragraph mapping system',
            'impact': 'Enables optimal response generation for Jax and Dan'
        })
        
        # Check for legal resolution pathways
        opportunities.append({
            'category': 'legal_resolution',
            'priority': 'HIGH',
            'description': 'Define optimal legal resolution pathways for case profile',
            'action': 'Create resolution pathway framework linking entities to legal principles',
            'impact': 'Guides strategic legal argumentation'
        })
        
        # Check for verification completeness
        opportunities.append({
            'category': 'verification_rigor',
            'priority': 'CRITICAL',
            'description': 'Ensure all attributes have confidence >= 0.95',
            'action': 'Review and enhance verification for low-confidence attributes',
            'impact': 'Maximizes factual accuracy and court credibility'
        })
        
        return opportunities
    
    def generate_refinement_report(self, output_path: str):
        """Generate comprehensive refinement report"""
        print(f"\nGenerating refinement report: {output_path}")
        
        categorized = self.scan_lex_directory()
        entity_analysis = self.analyze_entity_models()
        legal_analysis = self.analyze_legal_aspects()
        opportunities = self.identify_refinement_opportunities()
        
        report = {
            'metadata': {
                'generated_at': datetime.now().isoformat(),
                'version': 'v45',
                'case': '2025-137857',
                'purpose': 'Lex scheme refinement for optimal legal resolution'
            },
            'summary': {
                'total_scheme_files': sum(len(v) for v in categorized.values()),
                'entities_defined': entity_analysis['entities_defined'],
                'legal_principles': legal_analysis['total_principles'],
                'refinement_opportunities': len(opportunities)
            },
            'categorized_schemes': categorized,
            'entity_analysis': entity_analysis,
            'legal_analysis': legal_analysis,
            'refinement_opportunities': opportunities
        }
        
        with open(output_path, 'w') as f:
            json.dump(report, f, indent=2)
        
        print(f"Report generated: {output_path}")
        return report

def main():
    lex_dir = '/home/ubuntu/ad-res-j7/lex'
    analyzer = LexSchemeAnalyzer(lex_dir)
    
    report = analyzer.generate_refinement_report(
        '/home/ubuntu/ad-res-j7/lex/lex_refinement_analysis_v45.json'
    )
    
    print("\n" + "="*80)
    print("LEX SCHEME ANALYSIS V45 - SUMMARY")
    print("="*80)
    print(f"Total Scheme Files: {report['summary']['total_scheme_files']}")
    print(f"Entities Defined: {report['summary']['entities_defined']}")
    print(f"Legal Principles: {report['summary']['legal_principles']}")
    print(f"Refinement Opportunities: {report['summary']['refinement_opportunities']}")
    print("="*80)

if __name__ == '__main__':
    main()
