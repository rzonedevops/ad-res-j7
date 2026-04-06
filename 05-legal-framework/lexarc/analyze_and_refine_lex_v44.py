#!/usr/bin/env python3
"""
LEX FRAMEWORK ANALYSIS AND REFINEMENT V44
Comprehensive analysis and refinement of lex scheme representations
for optimal law resolution in case 2025-137857
"""

import os
import json
import re
from datetime import datetime
from pathlib import Path
from typing import Dict, List, Tuple, Set

class LexFrameworkAnalyzerV44:
    def __init__(self, lex_dir: str = "/home/ubuntu/ad-res-j7/lex"):
        self.lex_dir = Path(lex_dir)
        self.scheme_files = []
        self.analysis_results = {
            "timestamp": datetime.now().isoformat(),
            "total_schemes": 0,
            "legal_domains": {},
            "entity_models": {},
            "relation_models": {},
            "event_models": {},
            "legal_aspects": {},
            "optimization_opportunities": [],
            "refinement_recommendations": []
        }
        
    def find_all_scheme_files(self) -> List[Path]:
        """Find all .scm files in the lex directory"""
        scheme_files = list(self.lex_dir.rglob("*.scm"))
        self.scheme_files = scheme_files
        self.analysis_results["total_schemes"] = len(scheme_files)
        return scheme_files
    
    def analyze_legal_domains(self):
        """Analyze legal domain coverage"""
        domains = {
            "civ": {"name": "Civil Law", "files": [], "principles": []},
            "cri": {"name": "Criminal Law", "files": [], "principles": []},
            "cmp": {"name": "Company Law", "files": [], "principles": []},
            "trs": {"name": "Trust Law", "files": [], "principles": []},
            "lab": {"name": "Labour Law", "files": [], "principles": []},
            "civ-proc": {"name": "Civil Procedure", "files": [], "principles": []},
            "evid": {"name": "Evidence Law", "files": [], "principles": []},
            "prof-eth": {"name": "Professional Ethics", "files": [], "principles": []},
            "adm": {"name": "Administrative Law", "files": [], "principles": []},
            "cst": {"name": "Construction Law", "files": [], "principles": []},
            "env": {"name": "Environmental Law", "files": [], "principles": []},
            "int": {"name": "International Law", "files": [], "principles": []},
            "frn": {"name": "Forensic Analysis", "files": [], "principles": []}
        }
        
        for scheme_file in self.scheme_files:
            for domain_code, domain_info in domains.items():
                if f"/{domain_code}/" in str(scheme_file) or scheme_file.parent.name == domain_code:
                    domain_info["files"].append(str(scheme_file.relative_to(self.lex_dir)))
        
        self.analysis_results["legal_domains"] = domains
        return domains
    
    def analyze_entity_models(self):
        """Analyze entity-relation framework models"""
        entity_files = [
            "entity_agent_modeling_v1.scm",
            "entity_agent_modeling_v2_enhanced.scm",
            "entity_relation_framework_v3_comprehensive.scm",
            "entity_relation_framework_v43_comprehensive.scm",
            "case_2025_137857_entity_data_v43_verified.scm",
            "case_2025_137857_entity_relation_data_v1.scm"
        ]
        
        entities_found = {}
        for entity_file in entity_files:
            file_path = self.lex_dir / entity_file
            if file_path.exists():
                content = file_path.read_text()
                # Extract entity definitions
                entity_patterns = [
                    r'\(define-entity\s+([^\s)]+)',
                    r'\(make-agent-entity[^\s]*\s+["\']([^"\']+)',
                    r'<([a-z-]+agent[^>]*)>',
                    r'\(entity-id\s+["\']([^"\']+)'
                ]
                
                for pattern in entity_patterns:
                    matches = re.findall(pattern, content)
                    for match in matches:
                        if match not in entities_found:
                            entities_found[match] = {
                                "source_file": entity_file,
                                "occurrences": 1
                            }
                        else:
                            entities_found[match]["occurrences"] += 1
        
        self.analysis_results["entity_models"] = entities_found
        return entities_found
    
    def analyze_relation_models(self):
        """Analyze relation tracking and temporal chains"""
        relation_files = [
            "relation_tracking_temporal_v1.scm",
            "relationship_query_analysis_v1.scm"
        ]
        
        relations_found = {}
        for relation_file in relation_files:
            file_path = self.lex_dir / relation_file
            if file_path.exists():
                content = file_path.read_text()
                # Extract relation definitions
                relation_patterns = [
                    r'\(define-relation\s+([^\s)]+)',
                    r'\(relation-type\s+["\']([^"\']+)',
                    r'<([a-z-]+relation[^>]*)>'
                ]
                
                for pattern in relation_patterns:
                    matches = re.findall(pattern, content)
                    for match in matches:
                        if match not in relations_found:
                            relations_found[match] = {
                                "source_file": relation_file,
                                "occurrences": 1
                            }
                        else:
                            relations_found[match]["occurrences"] += 1
        
        self.analysis_results["relation_models"] = relations_found
        return relations_found
    
    def identify_optimization_opportunities(self):
        """Identify opportunities for lex framework optimization"""
        opportunities = []
        
        # Check for missing entity definitions
        critical_entities = [
            "Peter-Faucitt", "Jacqueline-Faucitt", "Daniel-Faucitt",
            "Bantjies", "Rynette-Farrar",
            "RWD", "RST", "SLG", "FFT", "RZL"
        ]
        
        entities_found = self.analysis_results.get("entity_models", {})
        for entity in critical_entities:
            if entity not in entities_found:
                opportunities.append({
                    "priority": "HIGH",
                    "type": "missing_entity",
                    "entity": entity,
                    "recommendation": f"Create comprehensive agent model for {entity} with verified attributes"
                })
        
        # Check for legal domain coverage gaps
        domains = self.analysis_results.get("legal_domains", {})
        for domain_code, domain_info in domains.items():
            if len(domain_info["files"]) == 0:
                opportunities.append({
                    "priority": "MEDIUM",
                    "type": "missing_domain",
                    "domain": domain_code,
                    "recommendation": f"Add {domain_info['name']} principles and rules"
                })
        
        # Check for temporal causation chains
        if not any("temporal" in str(f).lower() for f in self.scheme_files):
            opportunities.append({
                "priority": "HIGH",
                "type": "missing_temporal_analysis",
                "recommendation": "Add temporal causation chain analysis for manufactured crisis detection"
            })
        
        self.analysis_results["optimization_opportunities"] = opportunities
        return opportunities
    
    def generate_refinement_recommendations(self):
        """Generate specific refinement recommendations"""
        recommendations = []
        
        # Recommendation 1: Enhanced entity verification
        recommendations.append({
            "id": "R44-001",
            "priority": "CRITICAL",
            "category": "Entity Verification",
            "title": "Implement rigorous entity attribute verification with confidence scoring",
            "description": "All entity attributes must be verified against statutory basis and evidence chains with confidence scores >= 0.95",
            "implementation": [
                "Add verification-evidence-v43 records for each attribute",
                "Implement statutory basis verification per Trust Property Control Act 57/1988",
                "Add evidence chain verification with completeness scoring",
                "Cross-check all attributes against annexure evidence"
            ],
            "affected_files": [
                "entity_relation_framework_v43_comprehensive.scm",
                "case_2025_137857_entity_data_v43_verified.scm"
            ]
        })
        
        # Recommendation 2: Control hierarchy modeling
        recommendations.append({
            "id": "R44-002",
            "priority": "CRITICAL",
            "category": "Control Hierarchy",
            "title": "Model three-level control hierarchy (Bantjies → Rynette → Peter)",
            "description": "Explicit modeling of control hierarchy with evidence of Peter's lack of actual control",
            "implementation": [
                "Create control-hierarchy-v44 record type",
                "Map Level 1 (Bantjies) as ultimate controller via trustee role",
                "Map Level 2 (Rynette) as operational executor via financial controller",
                "Map Level 3 (Peter) as nominal applicant without actual control",
                "Add evidence: account access logs, email metadata, instruction chains"
            ],
            "affected_files": [
                "entity_relation_framework_v43_comprehensive.scm",
                "cmp/za/juristic_person_agent_modeling_v36.scm"
            ]
        })
        
        # Recommendation 3: Temporal causation chains
        recommendations.append({
            "id": "R44-003",
            "priority": "HIGH",
            "category": "Temporal Analysis",
            "title": "Enhance temporal causation chains for manufactured crisis detection",
            "description": "Comprehensive temporal analysis of retaliation patterns and multi-actor coordination",
            "implementation": [
                "Add immediate retaliation detection (<24h: June 6-7, 2025)",
                "Add extended retaliation pattern (64-73 days: August 13-14, 2025)",
                "Model settlement trojan horse pattern (165-day precision)",
                "Detect multi-stage coordination evidence",
                "Calculate temporal synchronization confidence scores"
            ],
            "affected_files": [
                "civ/za/south_african_civil_law_temporal_causation_v24.scm",
                "lab/za/immediate_retaliation_detection_v38.scm"
            ]
        })
        
        # Recommendation 4: Legal aspect mapping
        recommendations.append({
            "id": "R44-004",
            "priority": "HIGH",
            "category": "Legal Aspect Mapping",
            "title": "Map all entities, relations, and events to relevant legal aspects",
            "description": "Comprehensive mapping of case elements to legal principles for optimal resolution",
            "implementation": [
                "Map each entity to applicable legal principles",
                "Map each relation to fiduciary duties, control patterns, coordination",
                "Map each event to causation chains, bad faith indicators, retaliation",
                "Identify optimal legal resolution pathways per AD paragraph",
                "Generate jax-response and dan-response framework integration"
            ],
            "affected_files": [
                "entity_relation_framework_v43_comprehensive.scm",
                "lv1/legal_aspects_taxonomy_v17.scm"
            ]
        })
        
        # Recommendation 5: AD paragraph integration
        recommendations.append({
            "id": "R44-005",
            "priority": "HIGH",
            "category": "AD Integration",
            "title": "Map AD paragraphs to entities, relations, events with priority classification",
            "description": "Complete AD paragraph taxonomy with entity-relation-event mapping",
            "implementation": [
                "Classify all AD paragraphs by priority (Critical, High, Medium, Low, Meaningless)",
                "Map each AD paragraph to relevant entities",
                "Map each AD paragraph to relevant relations",
                "Map each AD paragraph to relevant events",
                "Generate response framework for jax-response and dan-response",
                "Identify synergy opportunities between JR and DR responses"
            ],
            "affected_files": [
                "entity_relation_framework_v43_comprehensive.scm",
                "JAX_DAN_RESPONSE_IMPROVEMENTS_V43_COMPREHENSIVE.md"
            ]
        })
        
        self.analysis_results["refinement_recommendations"] = recommendations
        return recommendations
    
    def generate_report(self, output_file: str = "LEX_ANALYSIS_REFINEMENT_V44_REPORT.md"):
        """Generate comprehensive analysis and refinement report"""
        report_lines = [
            "# LEX FRAMEWORK ANALYSIS AND REFINEMENT V44 - COMPREHENSIVE REPORT",
            "",
            f"**Date:** {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}",
            f"**Case:** 2025-137857 (Peter Faucitt v. Jacqueline & Daniel Faucitt)",
            f"**Purpose:** Comprehensive analysis and refinement of lex scheme representations for optimal law resolution",
            "",
            "---",
            "",
            "## EXECUTIVE SUMMARY",
            "",
            f"**Total Scheme Files Analyzed:** {self.analysis_results['total_schemes']}",
            f"**Legal Domains Covered:** {len([d for d in self.analysis_results['legal_domains'].values() if len(d['files']) > 0])}",
            f"**Entity Models Identified:** {len(self.analysis_results['entity_models'])}",
            f"**Relation Models Identified:** {len(self.analysis_results['relation_models'])}",
            f"**Optimization Opportunities:** {len(self.analysis_results['optimization_opportunities'])}",
            f"**Refinement Recommendations:** {len(self.analysis_results['refinement_recommendations'])}",
            "",
            "---",
            "",
            "## PART 1: LEGAL DOMAIN COVERAGE ANALYSIS",
            ""
        ]
        
        # Add legal domain analysis
        domains = self.analysis_results["legal_domains"]
        for domain_code, domain_info in sorted(domains.items()):
            if len(domain_info["files"]) > 0:
                report_lines.append(f"### {domain_info['name']} ({domain_code})")
                report_lines.append(f"**Files:** {len(domain_info['files'])}")
                report_lines.append("")
                for file in sorted(domain_info["files"])[:5]:  # Show first 5
                    report_lines.append(f"- {file}")
                if len(domain_info["files"]) > 5:
                    report_lines.append(f"- ... and {len(domain_info['files']) - 5} more")
                report_lines.append("")
        
        report_lines.extend([
            "---",
            "",
            "## PART 2: ENTITY MODEL ANALYSIS",
            ""
        ])
        
        # Add entity model analysis
        entities = self.analysis_results["entity_models"]
        if entities:
            report_lines.append("### Entities Identified")
            report_lines.append("")
            for entity, info in sorted(entities.items())[:20]:  # Show first 20
                report_lines.append(f"- **{entity}** (Source: {info['source_file']}, Occurrences: {info['occurrences']})")
            report_lines.append("")
        
        report_lines.extend([
            "---",
            "",
            "## PART 3: OPTIMIZATION OPPORTUNITIES",
            ""
        ])
        
        # Add optimization opportunities
        opportunities = self.analysis_results["optimization_opportunities"]
        for i, opp in enumerate(opportunities, 1):
            report_lines.append(f"### Opportunity {i}: {opp.get('type', 'Unknown')}")
            report_lines.append(f"**Priority:** {opp.get('priority', 'MEDIUM')}")
            report_lines.append(f"**Recommendation:** {opp.get('recommendation', 'N/A')}")
            report_lines.append("")
        
        report_lines.extend([
            "---",
            "",
            "## PART 4: REFINEMENT RECOMMENDATIONS",
            ""
        ])
        
        # Add refinement recommendations
        recommendations = self.analysis_results["refinement_recommendations"]
        for rec in recommendations:
            report_lines.append(f"### {rec['id']}: {rec['title']}")
            report_lines.append(f"**Priority:** {rec['priority']}")
            report_lines.append(f"**Category:** {rec['category']}")
            report_lines.append("")
            report_lines.append(f"**Description:** {rec['description']}")
            report_lines.append("")
            report_lines.append("**Implementation Steps:**")
            for step in rec['implementation']:
                report_lines.append(f"- {step}")
            report_lines.append("")
            report_lines.append("**Affected Files:**")
            for file in rec['affected_files']:
                report_lines.append(f"- `{file}`")
            report_lines.append("")
            report_lines.append("---")
            report_lines.append("")
        
        # Write report
        output_path = self.lex_dir / output_file
        output_path.write_text("\n".join(report_lines))
        print(f"✅ Report generated: {output_path}")
        
        # Also save JSON
        json_output = self.lex_dir / "LEX_ANALYSIS_REFINEMENT_V44_DATA.json"
        with open(json_output, 'w') as f:
            json.dump(self.analysis_results, f, indent=2)
        print(f"✅ JSON data saved: {json_output}")
        
        return output_path
    
    def run_full_analysis(self):
        """Run complete analysis pipeline"""
        print("=" * 80)
        print("LEX FRAMEWORK ANALYSIS AND REFINEMENT V44")
        print("=" * 80)
        print()
        
        print("Step 1: Finding scheme files...")
        self.find_all_scheme_files()
        print(f"✅ Found {len(self.scheme_files)} scheme files")
        print()
        
        print("Step 2: Analyzing legal domains...")
        self.analyze_legal_domains()
        domains_with_files = len([d for d in self.analysis_results['legal_domains'].values() if len(d['files']) > 0])
        print(f"✅ Analyzed {domains_with_files} legal domains")
        print()
        
        print("Step 3: Analyzing entity models...")
        self.analyze_entity_models()
        print(f"✅ Identified {len(self.analysis_results['entity_models'])} entities")
        print()
        
        print("Step 4: Analyzing relation models...")
        self.analyze_relation_models()
        print(f"✅ Identified {len(self.analysis_results['relation_models'])} relations")
        print()
        
        print("Step 5: Identifying optimization opportunities...")
        self.identify_optimization_opportunities()
        print(f"✅ Identified {len(self.analysis_results['optimization_opportunities'])} opportunities")
        print()
        
        print("Step 6: Generating refinement recommendations...")
        self.generate_refinement_recommendations()
        print(f"✅ Generated {len(self.analysis_results['refinement_recommendations'])} recommendations")
        print()
        
        print("Step 7: Generating comprehensive report...")
        report_path = self.generate_report()
        print()
        
        print("=" * 80)
        print("ANALYSIS COMPLETE")
        print("=" * 80)
        print()
        print(f"📄 Report: {report_path}")
        print(f"📊 JSON Data: {self.lex_dir / 'LEX_ANALYSIS_REFINEMENT_V44_DATA.json'}")
        print()
        
        return self.analysis_results

if __name__ == "__main__":
    analyzer = LexFrameworkAnalyzerV44()
    results = analyzer.run_full_analysis()
