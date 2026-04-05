#!/usr/bin/env python3
"""
Comprehensive Extraction from Lex Schemes V60
Version: 60.0
Date: 2026-01-06
Purpose: Extract all entities, relations, events, legal aspects, and agent models
         from the actual scheme structure used in the repository
"""

import json
import re
from pathlib import Path
from datetime import datetime
from collections import defaultdict

class ComprehensiveSchemeExtractor:
    def __init__(self, lex_dir):
        self.lex_dir = Path(lex_dir)
        self.legal_aspects = []
        self.agents = []
        self.entities = []
        self.relations = []
        self.events = []
        self.ad_paragraphs = {}
        self.case_law = []
        self.statutory_basis = []
        
    def extract_legal_aspects(self, content):
        """Extract legal aspects using actual structure"""
        # Pattern for define-legal-aspect
        pattern = r'\(define-legal-aspect\s+([A-Z\-0-9]+)\s*\n(.*?)(?=\n\(define-legal-aspect|\Z)'
        matches = re.findall(pattern, content, re.DOTALL)
        
        for aspect_id, aspect_body in matches:
            aspect = self._parse_legal_aspect_body(aspect_id, aspect_body)
            if aspect:
                self.legal_aspects.append(aspect)
        
        return len(matches)
    
    def _parse_legal_aspect_body(self, aspect_id, body):
        """Parse the body of a legal aspect definition"""
        aspect = {
            'id': aspect_id,
            'version': self._extract_value(body, 'version'),
            'domain': self._extract_value(body, 'domain'),
            'name': self._extract_value(body, 'name'),
            'definition': self._extract_value(body, 'definition'),
            'case_law': self._extract_case_law(body),
            'statutory_basis': self._extract_statutory_basis(body),
            'required_elements': self._extract_required_elements(body),
            'application_to_case': self._extract_application(body),
            'ad_paragraphs': self._extract_ad_paragraphs(body),
            'agent_involvement': self._extract_agent_involvement(body),
            'temporal_causation': self._extract_temporal_causation(body),
            'optimal_resolution': self._extract_optimal_resolution(body),
            'evidence_strength': self._extract_evidence_strength(body),
            'confidence': self._extract_confidence(body)
        }
        
        return aspect
    
    def _extract_value(self, text, field_name):
        """Extract a simple field value"""
        # Try quoted string
        pattern = rf'\({field_name}\s+"([^"]+)"\)'
        match = re.search(pattern, text, re.DOTALL)
        if match:
            return match.group(1).strip()
        
        # Try unquoted value
        pattern = rf'\({field_name}\s+([^\)]+)\)'
        match = re.search(pattern, text)
        if match:
            value = match.group(1).strip()
            # Remove quotes if present
            value = value.strip('"')
            return value
        
        return None
    
    def _extract_case_law(self, text):
        """Extract case law citations"""
        case_law = []
        
        # Find case-law section
        case_law_section = re.search(r'\(case-law\s*\n(.*?)\n\s*\)', text, re.DOTALL)
        if not case_law_section:
            return case_law
        
        case_section = case_law_section.group(1)
        
        # Extract individual cases
        case_pattern = r'\(case-\d+\s*\n(.*?)\n\s*\)'
        cases = re.findall(case_pattern, case_section, re.DOTALL)
        
        for case_body in cases:
            case = {
                'citation': self._extract_value(case_body, 'citation'),
                'court': self._extract_value(case_body, 'court'),
                'year': self._extract_value(case_body, 'year'),
                'principle': self._extract_value(case_body, 'principle'),
                'relevance': self._extract_value(case_body, 'relevance'),
                'confidence': self._extract_value(case_body, 'confidence')
            }
            case_law.append(case)
        
        return case_law
    
    def _extract_statutory_basis(self, text):
        """Extract statutory basis"""
        statutory = []
        
        # Find statutory-basis section
        statutory_section = re.search(r'\(statutory-basis\s*\n(.*?)\n\s*\)\)', text, re.DOTALL)
        if not statutory_section:
            return statutory
        
        statute_section = statutory_section.group(1)
        
        # Extract individual statutes
        statute_pattern = r'\(statute-\d+\s*\n(.*?)\n\s*\)'
        statutes = re.findall(statute_pattern, statute_section, re.DOTALL)
        
        for statute_body in statutes:
            statute = {
                'act': self._extract_value(statute_body, 'act'),
                'section': self._extract_value(statute_body, 'section'),
                'provision': self._extract_value(statute_body, 'provision'),
                'relevance': self._extract_value(statute_body, 'relevance'),
                'confidence': self._extract_value(statute_body, 'confidence')
            }
            statutory.append(statute)
        
        return statutory
    
    def _extract_required_elements(self, text):
        """Extract required elements"""
        elements = []
        
        # Find required-elements section
        elements_section = re.search(r'\(required-elements\s*\n(.*?)\n\s*\)', text, re.DOTALL)
        if not elements_section:
            return elements
        
        element_section = elements_section.group(1)
        
        # Extract individual elements
        element_pattern = r'\(element-\d+\s*\n(.*?)\n\s*\)'
        element_matches = re.findall(element_pattern, element_section, re.DOTALL)
        
        for element_body in element_matches:
            element = {
                'name': self._extract_value(element_body, 'name'),
                'description': self._extract_value(element_body, 'description'),
                'evidence_required': self._extract_value(element_body, 'evidence-required'),
                'verification_level': self._extract_value(element_body, 'verification-level'),
                'current_evidence': self._extract_value(element_body, 'current-evidence'),
                'evidence_strength': self._extract_value(element_body, 'evidence-strength'),
                'element_satisfied': self._extract_value(element_body, 'element-satisfied')
            }
            elements.append(element)
        
        return elements
    
    def _extract_application(self, text):
        """Extract application to case"""
        app_section = re.search(r'\(application-to-case\s*\n(.*?)\n\s*\)', text, re.DOTALL)
        if not app_section:
            return None
        
        app_body = app_section.group(1)
        
        return {
            'case_number': self._extract_value(app_body, 'case-number'),
            'applicability': self._extract_value(app_body, 'applicability'),
            'strength': self._extract_value(app_body, 'strength'),
            'description': self._extract_value(app_body, 'description'),
            'confidence': self._extract_value(app_body, 'confidence')
        }
    
    def _extract_ad_paragraphs(self, text):
        """Extract AD paragraph references"""
        ad_paras = []
        
        # Find ad-paragraphs section
        ad_section = re.search(r'\(ad-paragraphs\s*\n(.*?)\n\s*\)', text, re.DOTALL)
        if not ad_section:
            return ad_paras
        
        ad_body = ad_section.group(1)
        
        # Extract individual paragraphs
        para_pattern = r'\(para-\d+\s+"([^"]+)"\s+"([^"]+)"\)'
        paras = re.findall(para_pattern, ad_body)
        
        for para_ref, para_desc in paras:
            ad_paras.append({
                'reference': para_ref,
                'description': para_desc
            })
        
        return ad_paras
    
    def _extract_agent_involvement(self, text):
        """Extract agent involvement"""
        agent_section = re.search(r'\(agent-involvement\s*\n(.*?)\n\s*\)', text, re.DOTALL)
        if not agent_section:
            return None
        
        agent_body = agent_section.group(1)
        
        # Extract primary agent
        primary_pattern = r'\(primary-agent\s+"([^"]+)"\s+"([^"]+)"\s+"([^"]+)"\)'
        primary_match = re.search(primary_pattern, agent_body)
        
        primary_agent = None
        if primary_match:
            primary_agent = {
                'id': primary_match.group(1),
                'name': primary_match.group(2),
                'role': primary_match.group(3)
            }
        
        # Extract affected agents
        affected_agents = []
        affected_pattern = r'\("([^"]+)"\s+"([^"]+)"\s+"([^"]+)"\)'
        affected_matches = re.findall(affected_pattern, agent_body)
        
        for agent_id, agent_name, agent_role in affected_matches:
            if agent_id != (primary_agent['id'] if primary_agent else None):
                affected_agents.append({
                    'id': agent_id,
                    'name': agent_name,
                    'role': agent_role
                })
        
        return {
            'primary_agent': primary_agent,
            'affected_agents': affected_agents
        }
    
    def _extract_temporal_causation(self, text):
        """Extract temporal causation chains"""
        chains = []
        
        # Find temporal-causation section
        temporal_section = re.search(r'\(temporal-causation\s*\n(.*?)\n\s*\)', text, re.DOTALL)
        if not temporal_section:
            return chains
        
        temporal_body = temporal_section.group(1)
        
        # Extract chains
        chain_pattern = r'\(chain-\d+\s*\n(.*?)\n\s*\)'
        chain_matches = re.findall(chain_pattern, temporal_body, re.DOTALL)
        
        for chain_body in chain_matches:
            chain = {
                'id': self._extract_value(chain_body, 'id'),
                'description': self._extract_value(chain_body, 'description'),
                'events': self._extract_events_from_chain(chain_body),
                'reasoning': self._extract_value(chain_body, 'reasoning'),
                'confidence': self._extract_value(chain_body, 'confidence')
            }
            chains.append(chain)
        
        return chains
    
    def _extract_events_from_chain(self, text):
        """Extract events from a temporal chain"""
        events = []
        
        # Find events section
        events_section = re.search(r'\(events\s*\n(.*?)\n\s*\)', text, re.DOTALL)
        if not events_section:
            return events
        
        events_body = events_section.group(1)
        
        # Extract individual events
        event_pattern = r'\(event-\d+\s+"([^"]+)"\s+"([^"]+)"\)'
        event_matches = re.findall(event_pattern, events_body)
        
        for event_date, event_desc in event_matches:
            events.append({
                'date': event_date,
                'description': event_desc
            })
        
        return events
    
    def _extract_optimal_resolution(self, text):
        """Extract optimal resolution pathway"""
        resolution_section = re.search(r'\(optimal-resolution\s*\n(.*?)\n\s*\)', text, re.DOTALL)
        if not resolution_section:
            return None
        
        resolution_body = resolution_section.group(1)
        
        # Extract JR approach
        jr_section = re.search(r'\(JR-approach\s*\n(.*?)\n\s*\)', resolution_body, re.DOTALL)
        jr_approach = None
        if jr_section:
            jr_body = jr_section.group(1)
            jr_approach = {
                'focus': self._extract_value(jr_body, 'focus'),
                'key_points': self._extract_key_points(jr_body),
                'evidence_annexures': self._extract_annexures(jr_body),
                'tone': self._extract_value(jr_body, 'tone'),
                'confidence': self._extract_value(jr_body, 'confidence')
            }
        
        # Extract DR approach
        dr_section = re.search(r'\(DR-approach\s*\n(.*?)\n\s*\)', resolution_body, re.DOTALL)
        dr_approach = None
        if dr_section:
            dr_body = dr_section.group(1)
            dr_approach = {
                'focus': self._extract_value(dr_body, 'focus'),
                'key_points': self._extract_key_points(dr_body),
                'evidence_annexures': self._extract_annexures(dr_body),
                'tone': self._extract_value(dr_body, 'tone'),
                'confidence': self._extract_value(dr_body, 'confidence')
            }
        
        # Extract synergy mechanism
        synergy_section = re.search(r'\(synergy-mechanism\s*\n(.*?)\n\s*\)', resolution_body, re.DOTALL)
        synergy = None
        if synergy_section:
            synergy_body = synergy_section.group(1)
            synergy = {
                'type': self._extract_value(synergy_body, 'type'),
                'description': self._extract_value(synergy_body, 'description'),
                'synergy_strength': self._extract_value(synergy_body, 'synergy-strength'),
                'emergence_effect': self._extract_value(synergy_body, 'emergence-effect')
            }
        
        return {
            'pathway_type': self._extract_value(resolution_body, 'pathway-type'),
            'strategy': self._extract_value(resolution_body, 'strategy'),
            'jr_approach': jr_approach,
            'dr_approach': dr_approach,
            'synergy_mechanism': synergy
        }
    
    def _extract_key_points(self, text):
        """Extract key points"""
        points = []
        
        # Find key-points section
        points_section = re.search(r'\(key-points\s*\n(.*?)\n\s*\)', text, re.DOTALL)
        if not points_section:
            return points
        
        points_body = points_section.group(1)
        
        # Extract individual points
        point_pattern = r'\(point-\d+\s+"([^"]+)"\)'
        point_matches = re.findall(point_pattern, points_body)
        
        return point_matches
    
    def _extract_annexures(self, text):
        """Extract evidence annexures"""
        annexures = []
        
        # Find evidence-annexures section
        annexures_section = re.search(r'\(evidence-annexures\s*\n(.*?)\n\s*\)', text, re.DOTALL)
        if not annexures_section:
            return annexures
        
        annexures_body = annexures_section.group(1)
        
        # Extract individual annexures
        annexure_pattern = r'\("([^"]+)"\s+"([^"]+)"\)'
        annexure_matches = re.findall(annexure_pattern, annexures_body)
        
        for annexure_id, annexure_desc in annexure_matches:
            annexures.append({
                'id': annexure_id,
                'description': annexure_desc
            })
        
        return annexures
    
    def _extract_evidence_strength(self, text):
        """Extract evidence strength assessment"""
        strength_section = re.search(r'\(evidence-strength\s*\n(.*?)\n\s*\)', text, re.DOTALL)
        if not strength_section:
            return None
        
        strength_body = strength_section.group(1)
        
        return {
            'overall_strength': self._extract_value(strength_body, 'overall-strength'),
            'weakest_element': self._extract_value(strength_body, 'weakest-element')
        }
    
    def _extract_confidence(self, text):
        """Extract overall confidence"""
        # Look for standalone confidence field
        pattern = r'\(confidence\s+([0-9.]+)\)'
        match = re.search(pattern, text)
        if match:
            return float(match.group(1))
        return None
    
    def analyze_all_files(self):
        """Analyze all scheme files"""
        results = {
            'legal_aspects': [],
            'agents': [],
            'entities': [],
            'relations': [],
            'events': [],
            'statistics': {}
        }
        
        # Process entity relation framework files
        framework_files = list(self.lex_dir.glob('entity_relation_framework_v*.scm'))
        legal_aspect_files = list(self.lex_dir.glob('legal_aspects_comprehensive_v*.scm'))
        
        print(f"\nProcessing {len(framework_files)} entity relation framework files...")
        print(f"Processing {len(legal_aspect_files)} legal aspect files...")
        
        all_files = framework_files + legal_aspect_files
        
        for filepath in all_files:
            print(f"  Analyzing: {filepath.name}")
            try:
                with open(filepath, 'r', encoding='utf-8') as f:
                    content = f.read()
                
                # Extract legal aspects
                num_aspects = self.extract_legal_aspects(content)
                if num_aspects > 0:
                    print(f"    Found {num_aspects} legal aspects")
                
            except Exception as e:
                print(f"    Error: {e}")
        
        results['legal_aspects'] = self.legal_aspects
        results['statistics'] = {
            'total_legal_aspects': len(self.legal_aspects),
            'total_agents': len(self.agents),
            'total_entities': len(self.entities),
            'total_relations': len(self.relations),
            'total_events': len(self.events)
        }
        
        return results
    
    def generate_report(self, output_file):
        """Generate comprehensive analysis report"""
        print("\n" + "="*80)
        print("COMPREHENSIVE SCHEME EXTRACTION V60")
        print("="*80)
        
        results = self.analyze_all_files()
        
        # Save JSON results
        with open(output_file, 'w', encoding='utf-8') as f:
            json.dump(results, f, indent=2, ensure_ascii=False)
        
        print(f"\n{'='*80}")
        print("EXTRACTION COMPLETE")
        print(f"{'='*80}")
        print(f"Total Legal Aspects: {results['statistics']['total_legal_aspects']}")
        print(f"Total Agents: {results['statistics']['total_agents']}")
        print(f"Total Entities: {results['statistics']['total_entities']}")
        print(f"Total Relations: {results['statistics']['total_relations']}")
        print(f"Total Events: {results['statistics']['total_events']}")
        print(f"\nResults saved to: {output_file}")
        
        return results

def main():
    lex_dir = Path(__file__).parent.parent / 'lex'
    output_file = Path(__file__).parent / 'comprehensive_extraction_v60.json'
    
    extractor = ComprehensiveSchemeExtractor(lex_dir)
    results = extractor.generate_report(output_file)
    
    # Generate summary markdown
    summary_file = Path(__file__).parent / 'comprehensive_extraction_summary_v60.md'
    with open(summary_file, 'w', encoding='utf-8') as f:
        f.write("# Comprehensive Scheme Extraction Summary V60\n\n")
        f.write(f"**Date:** {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}\n\n")
        f.write("## Statistics\n\n")
        f.write(f"- **Total Legal Aspects:** {results['statistics']['total_legal_aspects']}\n")
        f.write(f"- **Total Agents:** {results['statistics']['total_agents']}\n")
        f.write(f"- **Total Entities:** {results['statistics']['total_entities']}\n")
        f.write(f"- **Total Relations:** {results['statistics']['total_relations']}\n")
        f.write(f"- **Total Events:** {results['statistics']['total_events']}\n\n")
        
        if results['legal_aspects']:
            f.write("## Legal Aspects Summary\n\n")
            for aspect in results['legal_aspects'][:10]:  # First 10
                f.write(f"### {aspect['id']}\n")
                f.write(f"- **Domain:** {aspect.get('domain', 'N/A')}\n")
                f.write(f"- **Name:** {aspect.get('name', 'N/A')}\n")
                f.write(f"- **Confidence:** {aspect.get('confidence', 'N/A')}\n")
                
                if aspect.get('ad_paragraphs'):
                    f.write(f"- **AD Paragraphs:** {len(aspect['ad_paragraphs'])} references\n")
                
                if aspect.get('case_law'):
                    f.write(f"- **Case Law:** {len(aspect['case_law'])} citations\n")
                
                f.write("\n")
    
    print(f"Summary saved to: {summary_file}")

if __name__ == '__main__':
    main()
