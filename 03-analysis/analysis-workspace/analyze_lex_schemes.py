#!/usr/bin/env python3
"""
Comprehensive Lex Scheme Analysis and Optimization
Purpose: Analyze all .scm files in lex/ directory to identify optimization opportunities
         for optimal law resolution in case 2025-137857
Date: 2025-12-23
"""

import os
import json
import re
from pathlib import Path
from collections import defaultdict
from datetime import datetime

class LexSchemeAnalyzer:
    def __init__(self, lex_dir):
        self.lex_dir = Path(lex_dir)
        self.schemes = []
        self.analysis_results = {
            'timestamp': datetime.now().isoformat(),
            'total_schemes': 0,
            'schemes_by_domain': defaultdict(list),
            'schemes_by_jurisdiction': defaultdict(list),
            'entity_definitions': defaultdict(list),
            'relation_definitions': defaultdict(list),
            'legal_principles': defaultdict(list),
            'verification_patterns': defaultdict(int),
            'optimization_opportunities': [],
            'coverage_gaps': [],
            'refinement_recommendations': []
        }
    
    def analyze_all_schemes(self):
        """Analyze all .scm files in lex directory"""
        scm_files = list(self.lex_dir.rglob('*.scm'))
        self.analysis_results['total_schemes'] = len(scm_files)
        
        print(f"Found {len(scm_files)} scheme files")
        
        for scm_file in scm_files:
            self.analyze_scheme_file(scm_file)
        
        self.identify_optimization_opportunities()
        self.identify_coverage_gaps()
        self.generate_refinement_recommendations()
        
        return self.analysis_results
    
    def analyze_scheme_file(self, scm_file):
        """Analyze individual scheme file"""
        relative_path = scm_file.relative_to(self.lex_dir)
        
        try:
            with open(scm_file, 'r', encoding='utf-8') as f:
                content = f.read()
            
            scheme_info = {
                'path': str(relative_path),
                'full_path': str(scm_file),
                'size': len(content),
                'lines': len(content.split('\n'))
            }
            
            # Extract domain from path
            parts = str(relative_path).split('/')
            if len(parts) > 1:
                domain = parts[0]
                scheme_info['domain'] = domain
                self.analysis_results['schemes_by_domain'][domain].append(str(relative_path))
            
            # Extract jurisdiction
            if '/za/' in str(relative_path):
                scheme_info['jurisdiction'] = 'South Africa'
                self.analysis_results['schemes_by_jurisdiction']['South Africa'].append(str(relative_path))
            
            # Analyze content patterns
            self.extract_entity_definitions(content, scheme_info)
            self.extract_relation_definitions(content, scheme_info)
            self.extract_legal_principles(content, scheme_info)
            self.analyze_verification_patterns(content, scheme_info)
            
            self.schemes.append(scheme_info)
            
        except Exception as e:
            print(f"Error analyzing {scm_file}: {e}")
    
    def extract_entity_definitions(self, content, scheme_info):
        """Extract entity definitions from scheme content"""
        # Look for entity definition patterns
        entity_patterns = [
            r'\(define\s+(\w+[-\w]*)\s+\'?\(\(entity-id\s+\.\s+"([^"]+)"\)',
            r'\(entity-type\s+\.\s+"([^"]+)"\)',
            r'<verified-entity>',
            r'<verified-natural-person>',
            r'<verified-juristic-person>'
        ]
        
        for pattern in entity_patterns:
            matches = re.findall(pattern, content)
            if matches:
                for match in matches:
                    entity_id = match if isinstance(match, str) else match[0]
                    self.analysis_results['entity_definitions'][scheme_info['path']].append(entity_id)
    
    def extract_relation_definitions(self, content, scheme_info):
        """Extract relation definitions from scheme content"""
        # Look for relation patterns
        relation_patterns = [
            r'\(relation-type\s+\.\s+"([^"]+)"\)',
            r'\(relationship\s+',
            r'\(from-entity\s+',
            r'\(to-entity\s+'
        ]
        
        for pattern in relation_patterns:
            matches = re.findall(pattern, content)
            if matches:
                for match in matches:
                    relation = match if isinstance(match, str) else 'relationship'
                    self.analysis_results['relation_definitions'][scheme_info['path']].append(relation)
    
    def extract_legal_principles(self, content, scheme_info):
        """Extract legal principles and statutory references"""
        # Look for legal principle patterns
        principle_patterns = [
            r'\(legal-principle\s+"([^"]+)"\)',
            r'\(statutory-basis\s+"([^"]+)"\)',
            r'\(act\s+"([^"]+)"\)',
            r'\(section\s+"([^"]+)"\)'
        ]
        
        for pattern in principle_patterns:
            matches = re.findall(pattern, content)
            if matches:
                for match in matches:
                    self.analysis_results['legal_principles'][scheme_info['path']].append(match)
    
    def analyze_verification_patterns(self, content, scheme_info):
        """Analyze verification and confidence scoring patterns"""
        verification_keywords = [
            'verification-record',
            'confidence-score',
            'evidence-support',
            'verified-by',
            'cross-check',
            'factual-accuracy'
        ]
        
        for keyword in verification_keywords:
            count = content.count(keyword)
            if count > 0:
                self.analysis_results['verification_patterns'][keyword] += count
    
    def identify_optimization_opportunities(self):
        """Identify opportunities for optimization"""
        opportunities = []
        
        # Check for schemes without verification patterns
        for scheme in self.schemes:
            path = scheme['path']
            has_verification = any(
                path in self.analysis_results['verification_patterns']
                for _ in ['verification-record', 'confidence-score']
            )
            
            if not has_verification and scheme['size'] > 1000:
                opportunities.append({
                    'type': 'missing-verification',
                    'path': path,
                    'recommendation': 'Add verification records and confidence scoring'
                })
        
        # Check for entity definitions without relations
        for path, entities in self.analysis_results['entity_definitions'].items():
            if entities and path not in self.analysis_results['relation_definitions']:
                opportunities.append({
                    'type': 'missing-relations',
                    'path': path,
                    'entities': len(entities),
                    'recommendation': 'Add relation definitions for identified entities'
                })
        
        # Check for large schemes that might need splitting
        for scheme in self.schemes:
            if scheme['lines'] > 1000:
                opportunities.append({
                    'type': 'large-scheme',
                    'path': scheme['path'],
                    'lines': scheme['lines'],
                    'recommendation': 'Consider splitting into modular components'
                })
        
        self.analysis_results['optimization_opportunities'] = opportunities
    
    def identify_coverage_gaps(self):
        """Identify gaps in legal coverage"""
        gaps = []
        
        # Check domain coverage
        expected_domains = ['civ', 'cri', 'cmp', 'trs', 'lab', 'evid']
        for domain in expected_domains:
            if domain not in self.analysis_results['schemes_by_domain']:
                gaps.append({
                    'type': 'missing-domain',
                    'domain': domain,
                    'recommendation': f'Add {domain} domain coverage'
                })
        
        # Check for temporal analysis coverage
        temporal_schemes = [s for s in self.schemes if 'temporal' in s['path'].lower()]
        if len(temporal_schemes) < 3:
            gaps.append({
                'type': 'limited-temporal-analysis',
                'current_count': len(temporal_schemes),
                'recommendation': 'Expand temporal causation analysis coverage'
            })
        
        self.analysis_results['coverage_gaps'] = gaps
    
    def generate_refinement_recommendations(self):
        """Generate specific refinement recommendations"""
        recommendations = []
        
        # Recommendation 1: Unified verification framework
        recommendations.append({
            'priority': 'CRITICAL',
            'category': 'verification-framework',
            'title': 'Implement Unified Verification Framework',
            'description': 'Create a standardized verification framework across all scheme files',
            'benefits': [
                'Consistent confidence scoring',
                'Rigorous cross-checking',
                'Factual accuracy guarantee'
            ],
            'implementation': 'Extend entity_agent_modeling_v2_enhanced.scm patterns to all domains'
        })
        
        # Recommendation 2: Entity-relation completeness
        recommendations.append({
            'priority': 'HIGH',
            'category': 'entity-relation-completeness',
            'title': 'Ensure Complete Entity-Relation Mapping',
            'description': 'Every entity must have defined relations with confidence scores',
            'benefits': [
                'Complete network analysis',
                'Coordination pattern detection',
                'Multi-actor analysis capability'
            ],
            'implementation': 'Audit all entity definitions and add missing relations'
        })
        
        # Recommendation 3: Temporal causation chains
        recommendations.append({
            'priority': 'HIGH',
            'category': 'temporal-analysis',
            'title': 'Enhance Temporal Causation Chain Analysis',
            'description': 'Strengthen temporal analysis with precise timing and causation links',
            'benefits': [
                'Immediate retaliation detection',
                'Settlement trojan horse pattern identification',
                'Multi-stage coordination evidence'
            ],
            'implementation': 'Expand relation_tracking_temporal_v1.scm with causation chains'
        })
        
        # Recommendation 4: AD element integration
        recommendations.append({
            'priority': 'CRITICAL',
            'category': 'ad-integration',
            'title': 'Complete AD Element to Entity-Relation Mapping',
            'description': 'Map every AD paragraph to specific entities, relations, and legal principles',
            'benefits': [
                'Optimal response strategy',
                'Evidence-to-allegation mapping',
                'Priority-based resource allocation'
            ],
            'implementation': 'Create AD-to-lex mapping scheme with priority classification'
        })
        
        # Recommendation 5: Legal principle resolution optimization
        recommendations.append({
            'priority': 'HIGH',
            'category': 'legal-resolution',
            'title': 'Optimize Legal Principle Resolution Engine',
            'description': 'Enhance statutory basis identification and application',
            'benefits': [
                'Faster legal principle lookup',
                'Comprehensive statutory coverage',
                'Jurisdictional accuracy'
            ],
            'implementation': 'Expand lv1/known_laws.scm with resolution algorithms'
        })
        
        self.analysis_results['refinement_recommendations'] = recommendations
    
    def save_results(self, output_file):
        """Save analysis results to JSON file"""
        with open(output_file, 'w', encoding='utf-8') as f:
            json.dump(self.analysis_results, f, indent=2, default=str)
        print(f"Analysis results saved to {output_file}")


def main():
    lex_dir = Path('/home/ubuntu/ad-res-j7/lex')
    output_file = Path('/home/ubuntu/ad-res-j7/analysis-workspace/lex_scheme_analysis_results.json')
    
    analyzer = LexSchemeAnalyzer(lex_dir)
    results = analyzer.analyze_all_schemes()
    analyzer.save_results(output_file)
    
    # Print summary
    print("\n" + "="*80)
    print("LEX SCHEME ANALYSIS SUMMARY")
    print("="*80)
    print(f"Total Schemes Analyzed: {results['total_schemes']}")
    print(f"Domains Covered: {len(results['schemes_by_domain'])}")
    print(f"Optimization Opportunities: {len(results['optimization_opportunities'])}")
    print(f"Coverage Gaps: {len(results['coverage_gaps'])}")
    print(f"Refinement Recommendations: {len(results['refinement_recommendations'])}")
    print("="*80)


if __name__ == '__main__':
    main()
