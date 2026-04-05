#!/usr/bin/env python3
"""
LEX SCHEME OPTIMIZATION ANALYSIS V50
Comprehensive analysis of lex scheme representations for optimal law resolution
Focus: Entity-relation frameworks, legal domain coverage, temporal causation
"""

import os
import json
import re
from pathlib import Path
from collections import defaultdict
from datetime import datetime

class LexOptimizationAnalyzer:
    def __init__(self, lex_dir):
        self.lex_dir = Path(lex_dir)
        self.schemes = defaultdict(list)
        self.legal_domains = defaultdict(list)
        self.entity_relations = []
        self.optimization_opportunities = []
        
    def analyze_all_schemes(self):
        """Analyze all scheme files in the lex directory"""
        print("=" * 80)
        print("LEX SCHEME OPTIMIZATION ANALYSIS V50")
        print("=" * 80)
        print(f"Analyzing directory: {self.lex_dir}")
        print()
        
        # Find all .scm files
        scm_files = list(self.lex_dir.rglob("*.scm"))
        print(f"Found {len(scm_files)} scheme files")
        print()
        
        # Categorize by legal domain
        for scm_file in scm_files:
            rel_path = scm_file.relative_to(self.lex_dir)
            parts = rel_path.parts
            
            if len(parts) > 0:
                domain = parts[0]
                self.legal_domains[domain].append(scm_file)
                
        # Analyze each domain
        self.analyze_domain_coverage()
        self.analyze_entity_relation_schemes()
        self.analyze_temporal_schemes()
        self.identify_optimization_opportunities()
        
        return self.generate_report()
        
    def analyze_domain_coverage(self):
        """Analyze legal domain coverage"""
        print("LEGAL DOMAIN COVERAGE ANALYSIS")
        print("-" * 80)
        
        domain_stats = {}
        for domain, files in sorted(self.legal_domains.items()):
            domain_stats[domain] = {
                'file_count': len(files),
                'files': [f.name for f in files]
            }
            print(f"{domain:20s} : {len(files):3d} files")
            
        print()
        return domain_stats
        
    def analyze_entity_relation_schemes(self):
        """Analyze entity-relation framework schemes"""
        print("ENTITY-RELATION FRAMEWORK ANALYSIS")
        print("-" * 80)
        
        er_files = list(self.lex_dir.glob("entity_relation_framework_v*.scm"))
        er_files.sort()
        
        if er_files:
            print(f"Found {len(er_files)} entity-relation framework versions")
            latest = er_files[-1]
            print(f"Latest version: {latest.name}")
            
            # Analyze latest version
            content = latest.read_text()
            
            # Extract entity definitions
            entities = re.findall(r'\(define-entity\s+([a-zA-Z0-9_-]+)', content)
            print(f"  - Entities defined: {len(entities)}")
            
            # Extract relation definitions
            relations = re.findall(r'\(define-relation\s+([a-zA-Z0-9_-]+)', content)
            print(f"  - Relations defined: {len(relations)}")
            
            # Extract event definitions
            events = re.findall(r'\(define-event\s+([a-zA-Z0-9_-]+)', content)
            print(f"  - Events defined: {len(events)}")
            
            # Extract motive definitions
            motives = re.findall(r'\(define-motive\s+([a-zA-Z0-9_-]+)', content)
            print(f"  - Motives defined: {len(motives)}")
            
            self.entity_relations.append({
                'version': latest.name,
                'entities': entities,
                'relations': relations,
                'events': events,
                'motives': motives
            })
        else:
            print("No entity-relation framework files found")
            
        print()
        
    def analyze_temporal_schemes(self):
        """Analyze temporal causation schemes"""
        print("TEMPORAL CAUSATION ANALYSIS")
        print("-" * 80)
        
        temporal_files = list(self.lex_dir.rglob("*temporal*.scm"))
        print(f"Found {len(temporal_files)} temporal scheme files:")
        for tf in temporal_files:
            print(f"  - {tf.relative_to(self.lex_dir)}")
            
        print()
        
    def identify_optimization_opportunities(self):
        """Identify optimization opportunities for law resolution"""
        print("OPTIMIZATION OPPORTUNITIES")
        print("-" * 80)
        
        opportunities = []
        
        # Check for missing integrations
        core_files = list(self.lex_dir.glob("core/*.scm"))
        if not any("v43_integration" in f.name for f in core_files):
            opportunities.append({
                'type': 'missing_integration',
                'priority': 'high',
                'description': 'Core v43 integration may need updating to v49+'
            })
            
        # Check for entity-relation completeness
        if self.entity_relations:
            latest_er = self.entity_relations[-1]
            if len(latest_er['entities']) < 15:
                opportunities.append({
                    'type': 'entity_coverage',
                    'priority': 'medium',
                    'description': f"Only {len(latest_er['entities'])} entities defined - may need expansion"
                })
                
        # Check for legal domain gaps
        expected_domains = ['civ', 'cri', 'cmp', 'trs', 'lab', 'evid']
        missing_domains = [d for d in expected_domains if d not in self.legal_domains]
        if missing_domains:
            opportunities.append({
                'type': 'domain_gap',
                'priority': 'low',
                'description': f"Missing or minimal coverage in: {', '.join(missing_domains)}"
            })
            
        # Check for temporal causation integration
        temporal_count = len(list(self.lex_dir.rglob("*temporal*.scm")))
        if temporal_count < 3:
            opportunities.append({
                'type': 'temporal_integration',
                'priority': 'high',
                'description': 'Limited temporal causation schemes - need more event chain analysis'
            })
            
        self.optimization_opportunities = opportunities
        
        for i, opp in enumerate(opportunities, 1):
            print(f"{i}. [{opp['priority'].upper()}] {opp['type']}")
            print(f"   {opp['description']}")
            print()
            
    def generate_report(self):
        """Generate comprehensive optimization report"""
        report = {
            'timestamp': datetime.now().isoformat(),
            'analysis_version': 'v50',
            'lex_directory': str(self.lex_dir),
            'domain_coverage': {
                domain: len(files) 
                for domain, files in self.legal_domains.items()
            },
            'entity_relation_frameworks': self.entity_relations,
            'optimization_opportunities': self.optimization_opportunities,
            'recommendations': self.generate_recommendations()
        }
        
        return report
        
    def generate_recommendations(self):
        """Generate specific recommendations for optimization"""
        recommendations = []
        
        recommendations.append({
            'area': 'Entity-Relation Framework',
            'action': 'Upgrade core integration from v43 to v49',
            'rationale': 'v49 includes R18.75M motive integration',
            'priority': 'critical'
        })
        
        recommendations.append({
            'area': 'Agent-Based Modeling',
            'action': 'Develop high-resolution agent models for all entities',
            'rationale': 'Enable behavioral analysis and motive inference',
            'priority': 'high'
        })
        
        recommendations.append({
            'area': 'Temporal Causation',
            'action': 'Expand temporal chain analysis with confidence scoring',
            'rationale': 'Strengthen causal inference for legal arguments',
            'priority': 'high'
        })
        
        recommendations.append({
            'area': 'Evidence Mapping',
            'action': 'Create evidence-to-principle direct mappings',
            'rationale': 'Optimize law resolution by linking evidence to legal principles',
            'priority': 'high'
        })
        
        recommendations.append({
            'area': 'Legal Domain Coverage',
            'action': 'Enhance civil procedure and evidence law schemes',
            'rationale': 'Critical for interdict and fraud analysis',
            'priority': 'medium'
        })
        
        return recommendations

if __name__ == "__main__":
    analyzer = LexOptimizationAnalyzer("/home/ubuntu/ad-res-j7/lex")
    report = analyzer.analyze_all_schemes()
    
    # Save report
    output_file = "/home/ubuntu/ad-res-j7/lex/LEX_OPTIMIZATION_ANALYSIS_V50.json"
    with open(output_file, 'w') as f:
        json.dump(report, f, indent=2)
    
    print("=" * 80)
    print(f"Report saved to: {output_file}")
    print("=" * 80)
