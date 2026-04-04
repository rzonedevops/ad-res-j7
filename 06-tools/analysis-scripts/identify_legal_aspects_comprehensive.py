#!/usr/bin/env python3
"""
Comprehensive Legal Aspects Identification for AD-RES-J7
Analyzes entities, relations, events, and timelines from lex and AD files
"""

import json
import re
from pathlib import Path
from datetime import datetime
from collections import defaultdict

class LegalAspectsIdentifier:
    def __init__(self, repo_path="/home/ubuntu/ad-res-j7"):
        self.repo_path = Path(repo_path)
        self.entities = {
            "natural_persons": set(),
            "juristic_persons": set()
        }
        self.relations = []
        self.events = []
        self.timeline = []
        self.legal_issues = defaultdict(int)
        
    def analyze_json_file(self, json_path):
        """Analyze existing legal aspects JSON"""
        with open(json_path, 'r') as f:
            data = json.load(f)
        
        for analysis in data.get('analyses', []):
            # Extract entities
            entities = analysis.get('entities', {})
            for person in entities.get('natural_persons', []):
                self.entities['natural_persons'].add(person)
            for entity in entities.get('juristic_persons', []):
                self.entities['juristic_persons'].add(entity)
            
            # Extract dates
            for date in analysis.get('dates', []):
                self.timeline.append({
                    'date': date,
                    'source': analysis['file'],
                    'topic': analysis.get('topic', '')
                })
            
            # Extract legal issues
            for issue in analysis.get('legal_issues', []):
                self.legal_issues[issue] += 1
    
    def identify_entity_relations(self):
        """Identify relationships between entities based on known structure"""
        relations = []
        
        # Peter Faucitt relations
        relations.append({
            'entity': 'Peter Faucitt',
            'role': 'Founder',
            'target': 'Faucitt Family Trust',
            'type': 'trust_relationship',
            'legal_aspect': 'fiduciary_duty'
        })
        relations.append({
            'entity': 'Peter Faucitt',
            'role': 'Trustee',
            'target': 'Faucitt Family Trust',
            'type': 'trust_relationship',
            'legal_aspect': 'fiduciary_duty',
            'conflict': 'founder_trustee_power_concentration'
        })
        relations.append({
            'entity': 'Peter Faucitt',
            'role': 'Director',
            'target': 'RegimA Worldwide Distribution',
            'type': 'corporate_relationship',
            'legal_aspect': 'director_duties'
        })
        
        # Jax relations
        relations.append({
            'entity': 'Jacqueline Faucitt',
            'role': 'CEO',
            'target': 'RegimA Skin Treatments',
            'type': 'corporate_relationship',
            'legal_aspect': 'executive_duties'
        })
        relations.append({
            'entity': 'Jacqueline Faucitt',
            'role': 'Beneficiary',
            'target': 'Faucitt Family Trust',
            'type': 'trust_relationship',
            'legal_aspect': 'beneficiary_rights'
        })
        
        # Dan relations
        relations.append({
            'entity': 'Daniel Faucitt',
            'role': 'CIO',
            'target': 'RegimA Skin Treatments',
            'type': 'corporate_relationship',
            'legal_aspect': 'executive_duties'
        })
        relations.append({
            'entity': 'Daniel Faucitt',
            'role': 'Owner',
            'target': 'RegimA Zone Ltd',
            'type': 'corporate_relationship',
            'legal_aspect': 'ownership_rights'
        })
        relations.append({
            'entity': 'Daniel Faucitt',
            'role': 'Beneficiary',
            'target': 'Faucitt Family Trust',
            'type': 'trust_relationship',
            'legal_aspect': 'beneficiary_rights'
        })
        
        # Rynette Farrar relations (conflict of interest)
        relations.append({
            'entity': 'Rynette Farrar',
            'role': 'Accountant',
            'target': 'RegimA Skin Treatments',
            'type': 'professional_relationship',
            'legal_aspect': 'professional_duty',
            'conflict': 'accountant_trustee_conflict'
        })
        relations.append({
            'entity': 'Rynette Farrar',
            'role': 'Trustee',
            'target': 'Faucitt Family Trust',
            'type': 'trust_relationship',
            'legal_aspect': 'fiduciary_duty',
            'conflict': 'accountant_trustee_conflict'
        })
        relations.append({
            'entity': 'Rynette Farrar',
            'role': 'Director',
            'target': 'Rezonance',
            'type': 'corporate_relationship',
            'legal_aspect': 'director_duties',
            'conflict': 'creditor_accountant_conflict'
        })
        relations.append({
            'entity': 'Rezonance',
            'role': 'Creditor',
            'target': 'RegimA Skin Treatments',
            'type': 'creditor_debtor',
            'legal_aspect': 'debt_obligation',
            'amount': 'R1,035,000',
            'conflict': 'creditor_control_conflict'
        })
        
        # Daniel Bantjies relations (conflict of interest)
        relations.append({
            'entity': 'Daniel Bantjies',
            'role': 'Accountant',
            'target': 'RegimA Worldwide Distribution',
            'type': 'professional_relationship',
            'legal_aspect': 'professional_duty',
            'conflict': 'accountant_trustee_conflict'
        })
        relations.append({
            'entity': 'Daniel Bantjies',
            'role': 'Trustee',
            'target': 'Faucitt Family Trust',
            'type': 'trust_relationship',
            'legal_aspect': 'fiduciary_duty',
            'conflict': 'accountant_trustee_conflict'
        })
        
        # Trust ownership relations
        relations.append({
            'entity': 'Faucitt Family Trust',
            'role': 'Owner',
            'target': 'RegimA Worldwide Distribution',
            'type': 'ownership',
            'legal_aspect': 'trust_asset'
        })
        
        # Platform ownership relation (unjust enrichment issue)
        relations.append({
            'entity': 'RegimA Zone Ltd',
            'role': 'Platform Owner',
            'target': 'RegimA Worldwide Distribution',
            'type': 'service_provider',
            'legal_aspect': 'unjust_enrichment',
            'conflict': 'platform_usage_without_payment'
        })
        
        self.relations = relations
        return relations
    
    def identify_critical_events(self):
        """Identify critical legal events from timeline"""
        events = [
            {
                'date': '2021-01-15',
                'event': 'Business operations commence',
                'entities': ['RegimA Skin Treatments', 'RegimA Worldwide Distribution'],
                'legal_aspect': 'contract_formation'
            },
            {
                'date': '2025-06-06',
                'event': 'Fraud report submission',
                'entities': ['Peter Faucitt'],
                'legal_aspect': 'fraud_allegation',
                'significance': 'Triggers subsequent actions'
            },
            {
                'date': '2025-06-07',
                'event': 'Card cancellation (1 day after fraud report)',
                'entities': ['Peter Faucitt', 'Daniel Faucitt'],
                'legal_aspect': 'power_abuse',
                'significance': 'Temporal correlation suggests bad faith',
                'temporal_pattern': 'immediate_retaliation'
            },
            {
                'date': '2025-07-16',
                'event': 'R500K payment to Jax',
                'entities': ['Jacqueline Faucitt', 'RegimA Skin Treatments'],
                'legal_aspect': 'trust_distribution',
                'disputed': True
            },
            {
                'date': '2025-08-14',
                'event': 'Confrontation event',
                'entities': ['Peter Faucitt', 'Jacqueline Faucitt', 'Daniel Faucitt'],
                'legal_aspect': 'coercion',
                'significance': 'Witness accounts available'
            },
            {
                'date': '2025-08-19',
                'event': 'Interdict filing',
                'entities': ['Peter Faucitt'],
                'legal_aspect': 'litigation_as_weapon',
                'significance': 'Despite having absolute trust powers'
            },
            {
                'date': '2025-09-11',
                'event': 'Account emptying',
                'entities': ['Peter Faucitt', 'RegimA Worldwide Distribution'],
                'legal_aspect': 'power_abuse',
                'significance': 'Financial harm to beneficiaries'
            }
        ]
        
        self.events = events
        return events
    
    def generate_report(self):
        """Generate comprehensive legal aspects report"""
        report = {
            'timestamp': datetime.now().isoformat(),
            'repository': 'cogpy/ad-res-j7',
            'case': '2025-137857 (Peter Faucitt v. Jacqueline & Daniel Faucitt)',
            'entities': {
                'natural_persons': sorted(list(self.entities['natural_persons'])),
                'juristic_persons': sorted(list(self.entities['juristic_persons'])),
                'total_natural': len(self.entities['natural_persons']),
                'total_juristic': len(self.entities['juristic_persons'])
            },
            'relations': {
                'total': len(self.relations),
                'by_type': self._group_relations_by_type(),
                'conflicts_identified': self._identify_conflicts(),
                'details': self.relations
            },
            'events': {
                'total': len(self.events),
                'critical_events': self.events,
                'temporal_patterns': self._identify_temporal_patterns()
            },
            'timeline': {
                'total_dates': len(self.timeline),
                'date_range': self._get_date_range(),
                'concentration_periods': self._identify_concentration_periods()
            },
            'legal_issues': {
                'by_frequency': dict(sorted(self.legal_issues.items(), 
                                           key=lambda x: x[1], reverse=True)),
                'total_unique': len(self.legal_issues)
            }
        }
        
        return report
    
    def _group_relations_by_type(self):
        """Group relations by type"""
        by_type = defaultdict(int)
        for rel in self.relations:
            by_type[rel['type']] += 1
        return dict(by_type)
    
    def _identify_conflicts(self):
        """Identify conflict of interest situations"""
        conflicts = []
        for rel in self.relations:
            if 'conflict' in rel:
                conflicts.append({
                    'entity': rel['entity'],
                    'conflict_type': rel['conflict'],
                    'roles': [rel['role'], rel.get('target')]
                })
        return conflicts
    
    def _identify_temporal_patterns(self):
        """Identify temporal patterns suggesting coordination"""
        patterns = []
        
        # Fraud report → Card cancellation (1 day)
        patterns.append({
            'pattern': 'immediate_retaliation',
            'events': ['Fraud report (2025-06-06)', 'Card cancellation (2025-06-07)'],
            'interval': '1 day',
            'significance': 'Suggests premeditated response'
        })
        
        # Crisis manufacturing period (May-Aug 2025)
        patterns.append({
            'pattern': 'crisis_manufacturing',
            'period': 'May-August 2025',
            'events': ['Multiple coordinated actions'],
            'significance': 'Concentrated period of adverse actions'
        })
        
        return patterns
    
    def _get_date_range(self):
        """Get date range from timeline"""
        if not self.timeline:
            return None
        dates = [t['date'] for t in self.timeline if t['date']]
        if dates:
            return {
                'earliest': min(dates),
                'latest': max(dates)
            }
        return None
    
    def _identify_concentration_periods(self):
        """Identify periods with concentrated activity"""
        # Simplified - would need proper date parsing for full implementation
        return [
            {
                'period': 'May-August 2025',
                'description': 'Crisis manufacturing period',
                'event_count': 'High'
            }
        ]

def main():
    identifier = LegalAspectsIdentifier()
    
    # Analyze existing JSON
    json_path = Path("/home/ubuntu/ad-res-j7/lex/LEGAL_ASPECTS_ANALYSIS_2025-11-10.json")
    if json_path.exists():
        print("Analyzing existing legal aspects JSON...")
        identifier.analyze_json_file(json_path)
    
    # Identify relations
    print("Identifying entity relations...")
    identifier.identify_entity_relations()
    
    # Identify critical events
    print("Identifying critical events...")
    identifier.identify_critical_events()
    
    # Generate report
    print("Generating comprehensive report...")
    report = identifier.generate_report()
    
    # Save report
    output_path = Path("/home/ubuntu/ad-res-j7/lex/LEGAL_ASPECTS_COMPREHENSIVE_2025-11-11.json")
    with open(output_path, 'w') as f:
        json.dump(report, f, indent=2)
    
    print(f"\n{'='*80}")
    print("COMPREHENSIVE LEGAL ASPECTS IDENTIFICATION")
    print(f"{'='*80}")
    print(f"\nEntities:")
    print(f"  Natural Persons: {report['entities']['total_natural']}")
    print(f"  Juristic Persons: {report['entities']['total_juristic']}")
    print(f"\nRelations: {report['relations']['total']}")
    print(f"  Conflicts Identified: {len(report['relations']['conflicts_identified'])}")
    print(f"\nEvents: {report['events']['total']}")
    print(f"\nLegal Issues:")
    for issue, count in list(report['legal_issues']['by_frequency'].items())[:5]:
        print(f"  {issue}: {count}")
    print(f"\nReport saved to: {output_path}")
    print(f"{'='*80}\n")
    
    return report

if __name__ == "__main__":
    main()
