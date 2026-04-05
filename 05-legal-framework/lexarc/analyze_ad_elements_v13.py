#!/usr/bin/env python3
"""
Comprehensive AD Element Analysis for Lex Scheme v13 Refinement
Analyzes entities, relations, events, timelines, and legal aspects
to identify optimization opportunities for case 2025-137857
"""

import os
import re
import json
from pathlib import Path
from collections import defaultdict
from datetime import datetime

class ADElementAnalyzer:
    def __init__(self, repo_path):
        self.repo_path = Path(repo_path)
        self.jax_dan_response_path = self.repo_path / "jax-dan-response"
        
        # Data structures
        self.entities = defaultdict(lambda: {"type": None, "mentions": 0, "contexts": [], "legal_significance": []})
        self.relations = []
        self.events = []
        self.timelines = []
        self.legal_aspects = defaultdict(int)
        self.ad_paragraphs = {}
        
        # Patterns
        self.date_pattern = re.compile(r'\b(20\d{2}[-/](0[1-9]|1[0-2])[-/](0[1-9]|[12]\d|3[01]))\b')
        self.entity_patterns = {
            "natural_persons": [
                "Peter Faucitt", "Jacqueline Faucitt", "Jacqui", "Jax",
                "Daniel Faucitt", "Dan", "Rynette Farrar", "Danie Bantjies"
            ],
            "juristic_persons": [
                "Faucitt Family Trust", "FFT", "RegimA Skin Treatments", "RST",
                "RegimA Worldwide Distribution", "RWD", "RegimA Zone Ltd",
                "Strategic Logistics Group", "SLG", "Villa Via", "Adderory",
                "Rezonance"
            ]
        }
        self.legal_aspect_keywords = [
            "bad faith", "bad-faith", "fraud", "fiduciary duty", "breach",
            "manufactured crisis", "retaliation", "unjust enrichment",
            "abuse of process", "delict", "coercion", "self-dealing",
            "conflict of interest", "whistleblowing", "temporal proximity"
        ]
        
    def analyze_all(self):
        """Run comprehensive analysis"""
        print("=" * 80)
        print("AD ELEMENT ANALYSIS FOR LEX SCHEME v13 REFINEMENT")
        print("=" * 80)
        print()
        
        # Analyze AD response files
        self.analyze_ad_responses()
        
        # Generate reports
        self.report_entities()
        self.report_relations()
        self.report_timeline_events()
        self.report_legal_aspects()
        self.report_optimization_opportunities()
        
    def analyze_ad_responses(self):
        """Analyze all AD paragraph response files"""
        ad_dir = self.jax_dan_response_path / "AD"
        
        if not ad_dir.exists():
            print(f"ERROR: AD directory not found at {ad_dir}")
            return
            
        priority_dirs = ["1-Critical", "2-High-Priority", "3-Medium-Priority", "4-Low-Priority", "5-Meaningless"]
        
        for priority_dir in priority_dirs:
            priority_path = ad_dir / priority_dir
            if not priority_path.exists():
                continue
                
            print(f"\nAnalyzing: {priority_dir}")
            print("-" * 80)
            
            for md_file in sorted(priority_path.glob("PARA_*.md")):
                self.analyze_file(md_file, priority_dir)
                
    def analyze_file(self, file_path, priority):
        """Analyze a single AD response file"""
        try:
            with open(file_path, 'r', encoding='utf-8') as f:
                content = f.read()
                
            # Extract AD paragraph number
            para_match = re.search(r'PARA[_\s]+([\d_\-\.]+)', file_path.stem)
            if para_match:
                para_num = para_match.group(1).replace('_', '.')
                
                # Store paragraph info
                self.ad_paragraphs[para_num] = {
                    "file": str(file_path.relative_to(self.repo_path)),
                    "priority": priority,
                    "entities": [],
                    "dates": [],
                    "legal_aspects": []
                }
                
                # Extract entities
                for entity_type, entity_list in self.entity_patterns.items():
                    for entity in entity_list:
                        if entity.lower() in content.lower():
                            self.entities[entity]["type"] = entity_type
                            self.entities[entity]["mentions"] += content.lower().count(entity.lower())
                            self.entities[entity]["contexts"].append(para_num)
                            self.ad_paragraphs[para_num]["entities"].append(entity)
                
                # Extract dates
                dates = self.date_pattern.findall(content)
                if dates:
                    self.ad_paragraphs[para_num]["dates"] = dates
                    for date in dates:
                        self.events.append({
                            "date": date,
                            "paragraph": para_num,
                            "priority": priority,
                            "file": str(file_path.name)
                        })
                
                # Extract legal aspects
                for aspect in self.legal_aspect_keywords:
                    if aspect.lower() in content.lower():
                        self.legal_aspects[aspect] += content.lower().count(aspect.lower())
                        self.ad_paragraphs[para_num]["legal_aspects"].append(aspect)
                        
        except Exception as e:
            print(f"  ERROR analyzing {file_path.name}: {e}")
            
    def report_entities(self):
        """Report entity analysis"""
        print("\n" + "=" * 80)
        print("ENTITY REGISTRY ANALYSIS")
        print("=" * 80)
        
        # Natural persons
        print("\nNATURAL PERSONS:")
        for entity, data in sorted(self.entities.items(), key=lambda x: x[1]["mentions"], reverse=True):
            if data["type"] == "natural_persons":
                print(f"  • {entity}: {data['mentions']} mentions across {len(set(data['contexts']))} paragraphs")
                
        # Juristic persons
        print("\nJURISTIC PERSONS:")
        for entity, data in sorted(self.entities.items(), key=lambda x: x[1]["mentions"], reverse=True):
            if data["type"] == "juristic_persons":
                print(f"  • {entity}: {data['mentions']} mentions across {len(set(data['contexts']))} paragraphs")
                
    def report_relations(self):
        """Report entity relationship analysis"""
        print("\n" + "=" * 80)
        print("ENTITY RELATIONSHIP PATTERNS")
        print("=" * 80)
        
        # Co-occurrence analysis
        co_occurrences = defaultdict(int)
        for para_num, para_data in self.ad_paragraphs.items():
            entities = set(para_data["entities"])
            if len(entities) >= 2:
                for e1 in entities:
                    for e2 in entities:
                        if e1 < e2:  # Avoid duplicates
                            co_occurrences[(e1, e2)] += 1
                            
        print("\nTOP ENTITY CO-OCCURRENCES (potential relations):")
        for (e1, e2), count in sorted(co_occurrences.items(), key=lambda x: x[1], reverse=True)[:15]:
            print(f"  • {e1} ↔ {e2}: {count} co-occurrences")
            
    def report_timeline_events(self):
        """Report timeline event analysis"""
        print("\n" + "=" * 80)
        print("TIMELINE EVENT ANALYSIS")
        print("=" * 80)
        
        # Sort events by date
        sorted_events = sorted(self.events, key=lambda x: x["date"])
        
        # Handle tuple dates from regex findall
        all_dates = [e['date'][0] if isinstance(e['date'], tuple) else e['date'] for e in sorted_events]
        print(f"\nTotal unique dates identified: {len(set(all_dates))}")
        print(f"Total event mentions: {len(sorted_events)}")
        
        # Group by priority
        by_priority = defaultdict(list)
        for event in sorted_events:
            by_priority[event["priority"]].append(event)
            
        print("\nEVENTS BY PRIORITY:")
        for priority in ["1-Critical", "2-High-Priority", "3-Medium-Priority"]:
            if priority in by_priority:
                print(f"\n{priority}: {len(by_priority[priority])} event mentions")
                # Show unique dates
                unique_dates = sorted(set(e["date"][0] if isinstance(e["date"], tuple) else e["date"] for e in by_priority[priority]))
                print(f"  Unique dates: {', '.join(unique_dates[:10])}" + 
                      (" ..." if len(unique_dates) > 10 else ""))
                      
    def report_legal_aspects(self):
        """Report legal aspect frequency analysis"""
        print("\n" + "=" * 80)
        print("LEGAL ASPECTS FREQUENCY ANALYSIS")
        print("=" * 80)
        
        print("\nLEGAL ASPECT MENTIONS (sorted by frequency):")
        for aspect, count in sorted(self.legal_aspects.items(), key=lambda x: x[1], reverse=True):
            print(f"  • {aspect}: {count} mentions")
            
        # Legal aspects by priority
        print("\nLEGAL ASPECTS BY PARAGRAPH PRIORITY:")
        by_priority = defaultdict(lambda: defaultdict(int))
        for para_num, para_data in self.ad_paragraphs.items():
            priority = para_data["priority"]
            for aspect in para_data["legal_aspects"]:
                by_priority[priority][aspect] += 1
                
        for priority in ["1-Critical", "2-High-Priority", "3-Medium-Priority"]:
            if priority in by_priority:
                print(f"\n{priority}:")
                for aspect, count in sorted(by_priority[priority].items(), key=lambda x: x[1], reverse=True)[:10]:
                    print(f"  • {aspect}: {count}")
                    
    def report_optimization_opportunities(self):
        """Report optimization opportunities for lex schemes"""
        print("\n" + "=" * 80)
        print("LEX SCHEME OPTIMIZATION OPPORTUNITIES (v13)")
        print("=" * 80)
        
        print("\n1. ENTITY-RELATION NETWORK ENHANCEMENTS:")
        print("   • Implement co-occurrence confidence scoring")
        print("   • Add entity-paragraph mapping for evidence tracing")
        print("   • Create entity role taxonomy (trustee, beneficiary, creditor, etc.)")
        
        print("\n2. TEMPORAL CAUSATION IMPROVEMENTS:")
        print("   • Enhance date extraction with context (event type)")
        print("   • Implement causation chain detection algorithms")
        print("   • Add temporal proximity scoring for retaliation patterns")
        
        print("\n3. LEGAL ASPECT TAXONOMY REFINEMENTS:")
        print("   • Update frequency counts based on actual AD analysis")
        print("   • Add priority-weighted confidence scoring")
        print("   • Implement cross-paragraph pattern detection")
        
        print("\n4. EVIDENCE-LEX-PRINCIPLE MAPPING:")
        print("   • Create annexure-to-legal-principle mapping")
        print("   • Implement evidence strength scoring")
        print("   • Add JR/DR response indexing support")
        
        print("\n5. MULTI-ACTOR COORDINATION DETECTION:")
        print("   • Enhance Peter-Rynette coordination evidence")
        print("   • Add temporal synchronization analysis")
        print("   • Implement coordination confidence scoring")
        
        # Save analysis results
        self.save_results()
        
    def save_results(self):
        """Save analysis results to JSON"""
        output_file = self.repo_path / "lex" / "AD_ELEMENT_ANALYSIS_V13.json"
        
        results = {
            "analysis_date": datetime.now().isoformat(),
            "entities": dict(self.entities),
            "ad_paragraphs": self.ad_paragraphs,
            "legal_aspects": dict(self.legal_aspects),
            "total_events": len(self.events),
            "unique_dates": len(set(e["date"] for e in self.events))
        }
        
        with open(output_file, 'w', encoding='utf-8') as f:
            json.dump(results, f, indent=2, ensure_ascii=False)
            
        print(f"\n\nAnalysis results saved to: {output_file}")

if __name__ == "__main__":
    analyzer = ADElementAnalyzer("/home/ubuntu/ad-res-j7")
    analyzer.analyze_all()
