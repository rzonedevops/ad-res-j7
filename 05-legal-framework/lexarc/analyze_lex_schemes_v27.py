#!/usr/bin/env python3
"""
LEX Scheme Analysis V27 - Comprehensive Analysis for Optimal Law Resolution
Analyzes all .scm files in lex/ to identify refinement opportunities
"""

import os
import re
import json
from pathlib import Path
from collections import defaultdict, Counter
from datetime import datetime

class LexSchemeAnalyzerV27:
    def __init__(self, lex_dir):
        self.lex_dir = Path(lex_dir)
        self.scheme_files = []
        self.analysis_results = {
            'timestamp': datetime.now().isoformat(),
            'total_files': 0,
            'legal_principles': [],
            'entity_agents': [],
            'temporal_patterns': [],
            'evidence_mappings': [],
            'optimization_opportunities': []
        }
        
    def find_scheme_files(self):
        """Find all .scm files in lex directory"""
        self.scheme_files = list(self.lex_dir.rglob('*.scm'))
        self.analysis_results['total_files'] = len(self.scheme_files)
        return self.scheme_files
    
    def extract_legal_principles(self, content):
        """Extract legal principle definitions from scheme content"""
        principles = []
        
        # Pattern: (define principle-name ...)
        define_pattern = r'\(define\s+([a-z0-9\-]+)'
        defines = re.findall(define_pattern, content)
        
        # Pattern: (define-record-type <type-name> ...)
        record_pattern = r'\(define-record-type\s+<([a-z0-9\-]+)>'
        records = re.findall(record_pattern, content)
        
        # Pattern: exported functions
        export_pattern = r'#:export\s+\(([\s\S]*?)\)\)'
        exports_match = re.search(export_pattern, content)
        exports = []
        if exports_match:
            exports_text = exports_match.group(1)
            exports = re.findall(r'([a-z0-9\-]+)', exports_text)
        
        return {
            'defines': defines,
            'records': records,
            'exports': exports
        }
    
    def extract_entity_agents(self, content):
        """Extract entity agent definitions"""
        agents = []
        
        # Pattern: (define entity-agent-v26 ...)
        agent_pattern = r'\(define\s+([a-z0-9\-]*agent[a-z0-9\-]*)\s+'
        agents = re.findall(agent_pattern, content)
        
        # Pattern: (make-legal-agent ...)
        make_agent_pattern = r"'name\s+\"([^\"]+)\""
        agent_names = re.findall(make_agent_pattern, content)
        
        return {
            'agent_vars': agents,
            'agent_names': agent_names
        }
    
    def extract_temporal_patterns(self, content):
        """Extract temporal causation patterns"""
        patterns = []
        
        # Pattern: dates in comments or strings
        date_pattern = r'20\d{2}-\d{2}-\d{2}'
        dates = re.findall(date_pattern, content)
        
        # Pattern: temporal-related functions
        temporal_funcs = re.findall(r'(temporal-[a-z0-9\-]+)', content)
        
        return {
            'dates': list(set(dates)),
            'temporal_functions': list(set(temporal_funcs))
        }
    
    def extract_evidence_mappings(self, content):
        """Extract evidence-to-principle mappings"""
        mappings = []
        
        # Pattern: annexure references
        annexure_pattern = r'[A-Z]{2,3}\d+'
        annexures = re.findall(annexure_pattern, content)
        
        # Pattern: evidence-related functions
        evidence_funcs = re.findall(r'(evidence-[a-z0-9\-]+|annexure-[a-z0-9\-]+)', content)
        
        return {
            'annexure_refs': list(set(annexures)),
            'evidence_functions': list(set(evidence_funcs))
        }
    
    def analyze_file(self, filepath):
        """Analyze a single scheme file"""
        try:
            with open(filepath, 'r', encoding='utf-8') as f:
                content = f.read()
            
            relative_path = filepath.relative_to(self.lex_dir)
            
            analysis = {
                'file': str(relative_path),
                'size': len(content),
                'lines': content.count('\n'),
                'principles': self.extract_legal_principles(content),
                'agents': self.extract_entity_agents(content),
                'temporal': self.extract_temporal_patterns(content),
                'evidence': self.extract_evidence_mappings(content)
            }
            
            return analysis
        except Exception as e:
            return {
                'file': str(filepath),
                'error': str(e)
            }
    
    def identify_optimization_opportunities(self, analyses):
        """Identify optimization opportunities across all files"""
        opportunities = []
        
        # Aggregate statistics
        all_principles = []
        all_agents = []
        all_temporal_funcs = []
        all_evidence_funcs = []
        
        for analysis in analyses:
            if 'error' in analysis:
                continue
            
            all_principles.extend(analysis['principles']['exports'])
            all_agents.extend(analysis['agents']['agent_names'])
            all_temporal_funcs.extend(analysis['temporal']['temporal_functions'])
            all_evidence_funcs.extend(analysis['evidence']['evidence_functions'])
        
        # Opportunity 1: Missing entity agents
        expected_entities = ['Daniel Faucitt', 'Jacqueline Faucitt', 'Peter Faucitt', 
                            'Rynette Farrar', 'RWD', 'RST', 'RegimA Zone Ltd']
        missing_entities = [e for e in expected_entities if e not in all_agents]
        
        if missing_entities:
            opportunities.append({
                'type': 'missing_entity_agents',
                'priority': 'HIGH',
                'description': f'Missing entity agent definitions for: {", ".join(missing_entities)}',
                'recommendation': 'Create comprehensive agent profiles with role taxonomy'
            })
        
        # Opportunity 2: Temporal causation coverage
        if len(all_temporal_funcs) < 10:
            opportunities.append({
                'type': 'temporal_causation_enhancement',
                'priority': 'HIGH',
                'description': f'Only {len(all_temporal_funcs)} temporal functions found',
                'recommendation': 'Implement retaliation cascade detection, temporal proximity scoring'
            })
        
        # Opportunity 3: Evidence mapping
        if len(all_evidence_funcs) < 5:
            opportunities.append({
                'type': 'evidence_mapping_enhancement',
                'priority': 'HIGH',
                'description': f'Only {len(all_evidence_funcs)} evidence functions found',
                'recommendation': 'Create annexure-to-principle mapping, evidence strength scoring'
            })
        
        # Opportunity 4: V27 integration
        v27_files = [a for a in analyses if 'v27' in a.get('file', '').lower()]
        if len(v27_files) == 0:
            opportunities.append({
                'type': 'v27_scheme_creation',
                'priority': 'CRITICAL',
                'description': 'No V27 scheme files found',
                'recommendation': 'Create south_african_civil_law_case_2025_137857_refined_v27.scm'
            })
        
        return opportunities
    
    def generate_report(self):
        """Generate comprehensive analysis report"""
        print("=" * 80)
        print("LEX SCHEME ANALYSIS V27 - COMPREHENSIVE REPORT")
        print("=" * 80)
        print()
        print(f"Timestamp: {self.analysis_results['timestamp']}")
        print(f"Total Scheme Files: {self.analysis_results['total_files']}")
        print()
        
        # Analyze all files
        analyses = []
        for filepath in self.scheme_files:
            analysis = self.analyze_file(filepath)
            analyses.append(analysis)
        
        # Identify opportunities
        opportunities = self.identify_optimization_opportunities(analyses)
        
        print("=" * 80)
        print("OPTIMIZATION OPPORTUNITIES")
        print("=" * 80)
        print()
        
        for i, opp in enumerate(opportunities, 1):
            print(f"{i}. [{opp['priority']}] {opp['type']}")
            print(f"   Description: {opp['description']}")
            print(f"   Recommendation: {opp['recommendation']}")
            print()
        
        # Save detailed results
        output_file = self.lex_dir / 'LEX_SCHEME_ANALYSIS_V27_OUTPUT.json'
        with open(output_file, 'w') as f:
            json.dump({
                'timestamp': self.analysis_results['timestamp'],
                'total_files': self.analysis_results['total_files'],
                'analyses': analyses,
                'optimization_opportunities': opportunities
            }, f, indent=2)
        
        print(f"Detailed analysis saved to: {output_file}")
        
        return opportunities

def main():
    lex_dir = '/home/ubuntu/ad-res-j7/lex'
    analyzer = LexSchemeAnalyzerV27(lex_dir)
    
    print("Finding scheme files...")
    analyzer.find_scheme_files()
    
    print(f"Found {len(analyzer.scheme_files)} scheme files")
    print()
    
    opportunities = analyzer.generate_report()
    
    return opportunities

if __name__ == '__main__':
    main()
