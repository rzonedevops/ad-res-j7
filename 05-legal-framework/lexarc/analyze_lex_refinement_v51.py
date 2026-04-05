#!/usr/bin/env python3
"""
LEX Scheme Refinement Analysis V51
Purpose: Analyze lex/* schemes to identify refinement opportunities for optimal law resolution
Focus: AD-RES-J7 case profile optimization
"""

import os
import json
import re
from pathlib import Path
from collections import defaultdict
from datetime import datetime

class LexSchemeAnalyzer:
    def __init__(self, lex_dir="/home/ubuntu/ad-res-j7/lex"):
        self.lex_dir = Path(lex_dir)
        self.schemes = []
        self.legal_domains = defaultdict(list)
        self.principles = []
        self.refinement_opportunities = []
        
    def scan_schemes(self):
        """Scan all .scm files in lex directory"""
        print(f"Scanning {self.lex_dir} for scheme files...")
        
        for scm_file in self.lex_dir.rglob("*.scm"):
            rel_path = scm_file.relative_to(self.lex_dir)
            
            # Parse domain from directory structure
            parts = list(rel_path.parts)
            domain = parts[0] if len(parts) > 1 else "root"
            
            scheme_info = {
                "path": str(rel_path),
                "full_path": str(scm_file),
                "domain": domain,
                "size": scm_file.stat().st_size,
                "name": scm_file.stem
            }
            
            self.schemes.append(scheme_info)
            self.legal_domains[domain].append(scheme_info)
            
        print(f"Found {len(self.schemes)} scheme files across {len(self.legal_domains)} domains")
        
    def extract_principles(self, content):
        """Extract legal principles from scheme content"""
        principles = []
        
        # Pattern for (define-principle ...) or (make-principle ...)
        principle_pattern = r'\((?:define-principle|make-principle)\s+([^\)]+)'
        matches = re.finditer(principle_pattern, content, re.MULTILINE | re.DOTALL)
        
        for match in matches:
            principle_block = match.group(1)
            
            # Extract name
            name_match = re.search(r"['\"]?name['\"]?\s+['\"]?([a-z0-9\-]+)", principle_block)
            name = name_match.group(1) if name_match else "unknown"
            
            # Extract confidence
            conf_match = re.search(r"confidence\s+(0\.\d+)", principle_block)
            confidence = float(conf_match.group(1)) if conf_match else 0.0
            
            # Extract domain
            domain_match = re.search(r"domain\s+['\(]([^'\)]+)", principle_block)
            domain = domain_match.group(1) if domain_match else ""
            
            principles.append({
                "name": name,
                "confidence": confidence,
                "domain": domain
            })
            
        return principles
        
    def analyze_scheme_file(self, scheme_info):
        """Analyze individual scheme file for refinement opportunities"""
        try:
            with open(scheme_info["full_path"], 'r', encoding='utf-8') as f:
                content = f.read()
                
            # Extract principles
            principles = self.extract_principles(content)
            scheme_info["principles"] = principles
            scheme_info["principle_count"] = len(principles)
            
            # Check for version indicators
            version_match = re.search(r'[vV](\d+)', scheme_info["name"])
            scheme_info["version"] = int(version_match.group(1)) if version_match else 0
            
            # Check for case-specific references
            scheme_info["case_specific"] = bool(re.search(r'2025-137857|AD-RES-J7|case_2025', content, re.IGNORECASE))
            
            # Check for temporal analysis
            scheme_info["has_temporal"] = bool(re.search(r'temporal|timing|cascade|sequence', content, re.IGNORECASE))
            
            # Check for agent modeling
            scheme_info["has_agents"] = bool(re.search(r'agent|behavioral|motive', content, re.IGNORECASE))
            
            # Check for verification/confidence scoring
            scheme_info["has_verification"] = bool(re.search(r'verification|confidence|source', content, re.IGNORECASE))
            
            self.principles.extend(principles)
            
        except Exception as e:
            print(f"Error analyzing {scheme_info['path']}: {e}")
            
    def identify_refinement_opportunities(self):
        """Identify areas for refinement"""
        print("\n=== IDENTIFYING REFINEMENT OPPORTUNITIES ===\n")
        
        # 1. Find schemes without version numbers
        unversioned = [s for s in self.schemes if s.get("version", 0) == 0]
        if unversioned:
            self.refinement_opportunities.append({
                "type": "versioning",
                "priority": "medium",
                "description": f"{len(unversioned)} schemes lack version numbers",
                "schemes": [s["path"] for s in unversioned[:5]]
            })
            
        # 2. Find schemes without temporal analysis in relevant domains
        temporal_domains = ["civ-proc", "lab", "evid", "frn"]
        missing_temporal = []
        for domain in temporal_domains:
            domain_schemes = self.legal_domains.get(domain, [])
            for scheme in domain_schemes:
                if not scheme.get("has_temporal", False):
                    missing_temporal.append(scheme)
                    
        if missing_temporal:
            self.refinement_opportunities.append({
                "type": "temporal_analysis",
                "priority": "high",
                "description": f"{len(missing_temporal)} schemes in temporal-relevant domains lack temporal analysis",
                "schemes": [s["path"] for s in missing_temporal[:5]]
            })
            
        # 3. Find schemes without agent modeling
        agent_relevant = ["civ", "cmp", "trs"]
        missing_agents = []
        for domain in agent_relevant:
            domain_schemes = self.legal_domains.get(domain, [])
            for scheme in domain_schemes:
                if not scheme.get("has_agents", False):
                    missing_agents.append(scheme)
                    
        if missing_agents:
            self.refinement_opportunities.append({
                "type": "agent_modeling",
                "priority": "high",
                "description": f"{len(missing_agents)} schemes lack agent-based behavioral modeling",
                "schemes": [s["path"] for s in missing_agents[:5]]
            })
            
        # 4. Find principles with low confidence scores
        low_confidence = [p for p in self.principles if 0 < p["confidence"] < 0.85]
        if low_confidence:
            self.refinement_opportunities.append({
                "type": "confidence_improvement",
                "priority": "medium",
                "description": f"{len(low_confidence)} principles have confidence < 0.85",
                "examples": [f"{p['name']}: {p['confidence']}" for p in low_confidence[:5]]
            })
            
        # 5. Find schemes without verification framework
        missing_verification = [s for s in self.schemes if not s.get("has_verification", False)]
        if missing_verification:
            self.refinement_opportunities.append({
                "type": "verification_framework",
                "priority": "critical",
                "description": f"{len(missing_verification)} schemes lack verification/source attribution",
                "schemes": [s["path"] for s in missing_verification[:10]]
            })
            
        # 6. Identify domain coverage gaps
        expected_domains = ["civ", "civ-proc", "cmp", "cri", "trs", "lab", "evid", "frn", "eth", "prof-eth"]
        missing_domains = [d for d in expected_domains if d not in self.legal_domains]
        if missing_domains:
            self.refinement_opportunities.append({
                "type": "domain_coverage",
                "priority": "low",
                "description": f"Missing legal domains: {', '.join(missing_domains)}",
                "domains": missing_domains
            })
            
        # 7. Find outdated versions (not v50+)
        outdated = [s for s in self.schemes if s.get("version", 0) > 0 and s["version"] < 50 and s.get("case_specific", False)]
        if outdated:
            self.refinement_opportunities.append({
                "type": "version_upgrade",
                "priority": "high",
                "description": f"{len(outdated)} case-specific schemes need upgrade to v50+",
                "schemes": [f"{s['path']} (v{s['version']})" for s in outdated[:10]]
            })
            
    def generate_report(self):
        """Generate comprehensive refinement report"""
        report = {
            "analysis_date": datetime.now().isoformat(),
            "repository": "cogpy/ad-res-j7",
            "case": "2025-137857",
            "version": "51.0",
            "summary": {
                "total_schemes": len(self.schemes),
                "total_domains": len(self.legal_domains),
                "total_principles": len(self.principles),
                "refinement_opportunities": len(self.refinement_opportunities)
            },
            "domains": {domain: len(schemes) for domain, schemes in self.legal_domains.items()},
            "refinement_opportunities": self.refinement_opportunities,
            "top_schemes_by_size": sorted(
                [{"path": s["path"], "size": s["size"], "principles": s.get("principle_count", 0)} 
                 for s in self.schemes],
                key=lambda x: x["size"],
                reverse=True
            )[:10]
        }
        
        return report
        
    def run_analysis(self):
        """Run complete analysis"""
        print("=" * 80)
        print("LEX SCHEME REFINEMENT ANALYSIS V51")
        print("=" * 80)
        
        self.scan_schemes()
        
        print("\nAnalyzing individual scheme files...")
        for scheme in self.schemes:
            self.analyze_scheme_file(scheme)
            
        print(f"\nExtracted {len(self.principles)} legal principles")
        
        self.identify_refinement_opportunities()
        
        report = self.generate_report()
        
        # Save report
        output_file = self.lex_dir / "lex_refinement_analysis_v51.json"
        with open(output_file, 'w') as f:
            json.dump(report, f, indent=2)
            
        print(f"\n✓ Analysis complete. Report saved to: {output_file}")
        
        return report

if __name__ == "__main__":
    analyzer = LexSchemeAnalyzer()
    report = analyzer.run_analysis()
    
    print("\n" + "=" * 80)
    print("SUMMARY")
    print("=" * 80)
    print(f"Total Schemes: {report['summary']['total_schemes']}")
    print(f"Total Domains: {report['summary']['total_domains']}")
    print(f"Total Principles: {report['summary']['total_principles']}")
    print(f"Refinement Opportunities: {report['summary']['refinement_opportunities']}")
    
    print("\n=== REFINEMENT OPPORTUNITIES (BY PRIORITY) ===\n")
    for opp in sorted(report['refinement_opportunities'], 
                     key=lambda x: {"critical": 0, "high": 1, "medium": 2, "low": 3}[x["priority"]]):
        print(f"[{opp['priority'].upper()}] {opp['type']}")
        print(f"  → {opp['description']}")
        print()
