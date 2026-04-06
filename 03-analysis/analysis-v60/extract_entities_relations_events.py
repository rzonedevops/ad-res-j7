#!/usr/bin/env python3
"""
Extract Entities, Relations, Events, and Timelines from Lex Schemes
Version: 60.0
Date: 2026-01-06
Purpose: Comprehensive extraction and analysis of entities, relations, events, and timelines
         from existing lex scheme files to enable high-resolution agent-based modeling
"""

import json
import re
import os
from pathlib import Path
from datetime import datetime
from collections import defaultdict

class SchemeAnalyzer:
    def __init__(self, lex_dir):
        self.lex_dir = Path(lex_dir)
        self.entities = {}
        self.relations = {}
        self.events = {}
        self.timelines = {}
        self.legal_aspects = {}
        self.ad_paragraphs = {}
        self.agents = {}
        
    def extract_from_scheme_file(self, filepath):
        """Extract structured data from a Scheme file"""
        with open(filepath, 'r', encoding='utf-8') as f:
            content = f.read()
        
        # Extract entities
        entity_pattern = r'\(define-entity\s+([^\s]+)\s*\n(.*?)\n\s*\)'
        entities = re.findall(entity_pattern, content, re.DOTALL)
        
        for entity_id, entity_body in entities:
            entity_data = self._parse_entity(entity_id, entity_body)
            if entity_data:
                self.entities[entity_id] = entity_data
        
        # Extract relations
        relation_pattern = r'\(define-relation\s+([^\s]+)\s*\n(.*?)\n\s*\)'
        relations = re.findall(relation_pattern, content, re.DOTALL)
        
        for relation_id, relation_body in relations:
            relation_data = self._parse_relation(relation_id, relation_body)
            if relation_data:
                self.relations[relation_id] = relation_data
        
        # Extract events
        event_pattern = r'\(define-event\s+([^\s]+)\s*\n(.*?)\n\s*\)'
        events = re.findall(event_pattern, content, re.DOTALL)
        
        for event_id, event_body in events:
            event_data = self._parse_event(event_id, event_body)
            if event_data:
                self.events[event_id] = event_data
        
        # Extract legal aspects
        aspect_pattern = r'\(define\s+ASPECT-([^\s]+)\s*\n(.*?)\n\s*\)\)'
        aspects = re.findall(aspect_pattern, content, re.DOTALL)
        
        for aspect_id, aspect_body in aspects:
            aspect_data = self._parse_legal_aspect(f"ASPECT-{aspect_id}", aspect_body)
            if aspect_data:
                self.legal_aspects[f"ASPECT-{aspect_id}"] = aspect_data
        
        # Extract agents
        agent_pattern = r'\(define-agent\s+([^\s]+)\s*\n(.*?)\n\s*\)'
        agents = re.findall(agent_pattern, content, re.DOTALL)
        
        for agent_id, agent_body in agents:
            agent_data = self._parse_agent(agent_id, agent_body)
            if agent_data:
                self.agents[agent_id] = agent_data
    
    def _parse_entity(self, entity_id, body):
        """Parse entity definition"""
        entity = {
            'id': entity_id,
            'type': self._extract_field(body, 'type'),
            'name': self._extract_field(body, 'name'),
            'legal_status': self._extract_field(body, 'legal-status'),
            'attributes': {},
            'roles': [],
            'relationships': []
        }
        
        # Extract attributes
        attr_pattern = r'\(([a-z\-]+)\s+"([^"]+)"\)'
        attributes = re.findall(attr_pattern, body)
        for attr_name, attr_value in attributes:
            entity['attributes'][attr_name] = attr_value
        
        return entity
    
    def _parse_relation(self, relation_id, body):
        """Parse relation definition"""
        relation = {
            'id': relation_id,
            'type': self._extract_field(body, 'type'),
            'source': self._extract_field(body, 'source'),
            'target': self._extract_field(body, 'target'),
            'nature': self._extract_field(body, 'nature'),
            'temporal': self._extract_field(body, 'temporal'),
            'evidence': [],
            'legal_implications': []
        }
        
        return relation
    
    def _parse_event(self, event_id, body):
        """Parse event definition"""
        event = {
            'id': event_id,
            'type': self._extract_field(body, 'type'),
            'date': self._extract_field(body, 'date'),
            'actors': self._extract_list(body, 'actors'),
            'description': self._extract_field(body, 'description'),
            'evidence': self._extract_list(body, 'evidence'),
            'legal_significance': self._extract_field(body, 'legal-significance'),
            'causation': []
        }
        
        return event
    
    def _parse_legal_aspect(self, aspect_id, body):
        """Parse legal aspect definition"""
        aspect = {
            'id': aspect_id,
            'domain': self._extract_field(body, 'domain'),
            'name': self._extract_field(body, 'name'),
            'definition': self._extract_field(body, 'definition'),
            'case_law': [],
            'statutory_basis': [],
            'elements': [],
            'ad_paragraphs': [],
            'evidence_strength': 0.0
        }
        
        return aspect
    
    def _parse_agent(self, agent_id, body):
        """Parse agent definition"""
        agent = {
            'id': agent_id,
            'name': self._extract_field(body, 'name'),
            'type': self._extract_field(body, 'type'),
            'roles': self._extract_list(body, 'roles'),
            'knowledge_state': {},
            'capability_state': {},
            'motive_state': {},
            'opportunity_state': {},
            'legal_awareness': {},
            'actions': [],
            'relationships': []
        }
        
        return agent
    
    def _extract_field(self, text, field_name):
        """Extract a single field value"""
        pattern = rf'\({field_name}\s+"([^"]+)"\)'
        match = re.search(pattern, text)
        if match:
            return match.group(1)
        
        # Try without quotes
        pattern = rf'\({field_name}\s+([^\)]+)\)'
        match = re.search(pattern, text)
        if match:
            return match.group(1).strip()
        
        return None
    
    def _extract_list(self, text, field_name):
        """Extract a list field"""
        pattern = rf'\({field_name}\s+\(list([^\)]*)\)\)'
        match = re.search(pattern, text)
        if match:
            items = re.findall(r'"([^"]+)"', match.group(1))
            return items
        return []
    
    def analyze_all_schemes(self):
        """Analyze all scheme files in lex directory"""
        scheme_files = list(self.lex_dir.glob('*.scm'))
        
        print(f"Found {len(scheme_files)} scheme files")
        
        for filepath in scheme_files:
            print(f"Analyzing: {filepath.name}")
            try:
                self.extract_from_scheme_file(filepath)
            except Exception as e:
                print(f"Error processing {filepath.name}: {e}")
        
        return {
            'entities': self.entities,
            'relations': self.relations,
            'events': self.events,
            'agents': self.agents,
            'legal_aspects': self.legal_aspects,
            'statistics': {
                'total_entities': len(self.entities),
                'total_relations': len(self.relations),
                'total_events': len(self.events),
                'total_agents': len(self.agents),
                'total_legal_aspects': len(self.legal_aspects)
            }
        }
    
    def generate_report(self, output_file):
        """Generate comprehensive analysis report"""
        results = self.analyze_all_schemes()
        
        with open(output_file, 'w', encoding='utf-8') as f:
            json.dump(results, f, indent=2, ensure_ascii=False)
        
        print(f"\nAnalysis complete!")
        print(f"Total Entities: {results['statistics']['total_entities']}")
        print(f"Total Relations: {results['statistics']['total_relations']}")
        print(f"Total Events: {results['statistics']['total_events']}")
        print(f"Total Agents: {results['statistics']['total_agents']}")
        print(f"Total Legal Aspects: {results['statistics']['total_legal_aspects']}")
        print(f"\nResults saved to: {output_file}")
        
        return results

def main():
    lex_dir = Path(__file__).parent.parent / 'lex'
    output_file = Path(__file__).parent / 'extracted_entities_relations_events_v60.json'
    
    analyzer = SchemeAnalyzer(lex_dir)
    results = analyzer.generate_report(output_file)
    
    # Generate summary markdown
    summary_file = Path(__file__).parent / 'extraction_summary_v60.md'
    with open(summary_file, 'w', encoding='utf-8') as f:
        f.write("# Entity, Relation, Event Extraction Summary V60\n\n")
        f.write(f"**Date:** {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}\n\n")
        f.write("## Statistics\n\n")
        f.write(f"- **Total Entities:** {results['statistics']['total_entities']}\n")
        f.write(f"- **Total Relations:** {results['statistics']['total_relations']}\n")
        f.write(f"- **Total Events:** {results['statistics']['total_events']}\n")
        f.write(f"- **Total Agents:** {results['statistics']['total_agents']}\n")
        f.write(f"- **Total Legal Aspects:** {results['statistics']['total_legal_aspects']}\n\n")
        
        if results['entities']:
            f.write("## Sample Entities\n\n")
            for i, (entity_id, entity) in enumerate(list(results['entities'].items())[:5]):
                f.write(f"### {entity_id}\n")
                f.write(f"- **Type:** {entity.get('type', 'N/A')}\n")
                f.write(f"- **Name:** {entity.get('name', 'N/A')}\n\n")
        
        if results['agents']:
            f.write("## Sample Agents\n\n")
            for i, (agent_id, agent) in enumerate(list(results['agents'].items())[:5]):
                f.write(f"### {agent_id}\n")
                f.write(f"- **Name:** {agent.get('name', 'N/A')}\n")
                f.write(f"- **Type:** {agent.get('type', 'N/A')}\n")
                f.write(f"- **Roles:** {', '.join(agent.get('roles', []))}\n\n")
    
    print(f"Summary saved to: {summary_file}")

if __name__ == '__main__':
    main()
