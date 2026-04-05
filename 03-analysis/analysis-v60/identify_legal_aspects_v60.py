#!/usr/bin/env python3
"""
Identify Legal Aspects and Refine Lex Scheme Representations V60
Version: 60.0
Date: 2026-01-06
Purpose: Identify all legal aspects from AD paragraphs, entities, relations, and events
         then refine lex scheme representations for optimal law resolution
"""

import json
import re
from pathlib import Path
from datetime import datetime
from collections import defaultdict

class LegalAspectIdentifier:
    def __init__(self, repo_dir):
        self.repo_dir = Path(repo_dir)
        self.ad_dir = self.repo_dir / 'jax-response' / 'AD'
        self.lex_dir = self.repo_dir / 'lex'
        
        # Legal domain taxonomy
        self.legal_domains = {
            'trust-law': [
                'beneficiary-trustee-conflict',
                'abuse-of-trustee-powers',
                'trust-distribution-obligations',
                'fiduciary-duty-breach',
                'trust-administration-failure'
            ],
            'civil-procedure': [
                'material-non-disclosure-ex-parte',
                'abuse-of-process',
                'manufactured-urgency',
                'forum-shopping',
                'improper-ex-parte-application'
            ],
            'company-law': [
                'director-duties-breach',
                'nominal-director-without-control',
                'business-judgment-rule',
                'corporate-governance-failure',
                'director-loan-account-structure'
            ],
            'criminal-law': [
                'fraud',
                'theft',
                'misrepresentation',
                'criminal-enterprise',
                'revenue-hijacking'
            ],
            'administrative-law': [
                'regulatory-compliance-failure',
                'statutory-duties-breach',
                'whistleblower-retaliation'
            ],
            'family-law': [
                'curatorship-fraud',
                'mental-capacity-manipulation',
                'medical-testing-weaponization',
                'family-court-jurisdiction-abuse'
            ]
        }
        
        # Identified legal aspects from AD paragraphs
        self.identified_aspects = []
        
        # Entity and agent tracking
        self.entities = {}
        self.agents = {}
        
    def analyze_ad_paragraphs(self):
        """Analyze all AD paragraphs to identify legal aspects"""
        print("\n" + "="*80)
        print("ANALYZING AD PARAGRAPHS FOR LEGAL ASPECTS")
        print("="*80)
        
        # Priority directories
        priority_dirs = [
            '1-Critical',
            '2-High-Priority',
            '3-Medium-Priority',
            '4-Low-Priority',
            '5-Meaningless'
        ]
        
        for priority_dir in priority_dirs:
            dir_path = self.ad_dir / priority_dir
            if not dir_path.exists():
                continue
            
            print(f"\nAnalyzing {priority_dir}...")
            
            # Find all PARA files (excluding DAN perspective files)
            para_files = [f for f in dir_path.glob('PARA_*.md') if '_DAN_' not in f.name]
            
            for para_file in para_files:
                print(f"  Processing: {para_file.name}")
                self._analyze_para_file(para_file, priority_dir)
        
        print(f"\n{'='*80}")
        print(f"IDENTIFIED {len(self.identified_aspects)} LEGAL ASPECTS")
        print(f"{'='*80}")
        
        return self.identified_aspects
    
    def _analyze_para_file(self, para_file, priority):
        """Analyze a single AD paragraph file"""
        with open(para_file, 'r', encoding='utf-8') as f:
            content = f.read()
        
        # Extract paragraph number
        para_match = re.search(r'# AD PARAGRAPH ([0-9_\-\.]+)', content)
        para_number = para_match.group(1) if para_match else para_file.stem
        
        # Extract topic
        topic_match = re.search(r'## Topic: (.+)', content)
        topic = topic_match.group(1) if topic_match else "Unknown"
        
        # Extract Peter's claim
        claim_match = re.search(r"## Peter's Claim: (.+)", content)
        claim = claim_match.group(1) if claim_match else "Unknown"
        
        # Identify legal domains and aspects
        identified_domains = self._identify_legal_domains(content, topic, claim)
        
        # Extract entities mentioned
        entities = self._extract_entities(content)
        
        # Create legal aspect entry
        aspect = {
            'ad_paragraph': para_number,
            'priority': priority,
            'topic': topic,
            'peters_claim': claim,
            'identified_domains': identified_domains,
            'entities_involved': entities,
            'confidence': self._calculate_confidence(identified_domains, content)
        }
        
        self.identified_aspects.append(aspect)
    
    def _identify_legal_domains(self, content, topic, claim):
        """Identify applicable legal domains based on content"""
        domains = []
        
        content_lower = content.lower()
        topic_lower = topic.lower()
        claim_lower = claim.lower()
        
        # Trust law indicators
        if any(keyword in content_lower for keyword in ['trust', 'trustee', 'beneficiary', 'fiduciary']):
            domains.append({
                'domain': 'trust-law',
                'aspects': self._identify_trust_aspects(content_lower, topic_lower, claim_lower)
            })
        
        # Civil procedure indicators
        if any(keyword in content_lower for keyword in ['ex parte', 'urgency', 'interdict', 'disclosure', 'forum']):
            domains.append({
                'domain': 'civil-procedure',
                'aspects': self._identify_civil_procedure_aspects(content_lower, topic_lower, claim_lower)
            })
        
        # Company law indicators
        if any(keyword in content_lower for keyword in ['director', 'company', 'corporate', 'governance', 'business judgment']):
            domains.append({
                'domain': 'company-law',
                'aspects': self._identify_company_law_aspects(content_lower, topic_lower, claim_lower)
            })
        
        # Criminal law indicators
        if any(keyword in content_lower for keyword in ['fraud', 'theft', 'criminal', 'misrepresentation', 'hijacking']):
            domains.append({
                'domain': 'criminal-law',
                'aspects': self._identify_criminal_law_aspects(content_lower, topic_lower, claim_lower)
            })
        
        # Administrative law indicators
        if any(keyword in content_lower for keyword in ['regulatory', 'compliance', 'statutory', 'whistleblower']):
            domains.append({
                'domain': 'administrative-law',
                'aspects': self._identify_administrative_law_aspects(content_lower, topic_lower, claim_lower)
            })
        
        # Family law indicators
        if any(keyword in content_lower for keyword in ['curatorship', 'mental', 'capacity', 'medical testing', 'family court']):
            domains.append({
                'domain': 'family-law',
                'aspects': self._identify_family_law_aspects(content_lower, topic_lower, claim_lower)
            })
        
        return domains
    
    def _identify_trust_aspects(self, content, topic, claim):
        """Identify specific trust law aspects"""
        aspects = []
        
        if 'beneficiary' in content and 'trustee' in content and 'conflict' in content:
            aspects.append('beneficiary-trustee-conflict')
        
        if 'abuse' in content and ('power' in content or 'trustee' in content):
            aspects.append('abuse-of-trustee-powers')
        
        if 'distribution' in content or 'payout' in content:
            aspects.append('trust-distribution-obligations')
        
        if 'fiduciary' in content and ('duty' in content or 'breach' in content):
            aspects.append('fiduciary-duty-breach')
        
        return aspects
    
    def _identify_civil_procedure_aspects(self, content, topic, claim):
        """Identify specific civil procedure aspects"""
        aspects = []
        
        if 'ex parte' in content and ('disclosure' in content or 'material' in content):
            aspects.append('material-non-disclosure-ex-parte')
        
        if 'abuse' in content and 'process' in content:
            aspects.append('abuse-of-process')
        
        if 'urgency' in content or 'urgent' in content:
            aspects.append('manufactured-urgency')
        
        if 'forum' in content and ('shopping' in content or 'selection' in content or 'court' in content):
            aspects.append('forum-shopping')
        
        return aspects
    
    def _identify_company_law_aspects(self, content, topic, claim):
        """Identify specific company law aspects"""
        aspects = []
        
        if 'director' in content and ('duty' in content or 'duties' in content):
            aspects.append('director-duties-breach')
        
        if 'nominal' in content or ('director' in content and 'control' in content):
            aspects.append('nominal-director-without-control')
        
        if 'business judgment' in content:
            aspects.append('business-judgment-rule')
        
        if 'loan account' in content or 'director loan' in content:
            aspects.append('director-loan-account-structure')
        
        return aspects
    
    def _identify_criminal_law_aspects(self, content, topic, claim):
        """Identify specific criminal law aspects"""
        aspects = []
        
        if 'fraud' in content:
            aspects.append('fraud')
        
        if 'theft' in content or 'stealing' in content:
            aspects.append('theft')
        
        if 'misrepresent' in content:
            aspects.append('misrepresentation')
        
        if 'hijack' in content or 'revenue hijack' in content:
            aspects.append('revenue-hijacking')
        
        return aspects
    
    def _identify_administrative_law_aspects(self, content, topic, claim):
        """Identify specific administrative law aspects"""
        aspects = []
        
        if 'regulatory' in content or 'compliance' in content:
            aspects.append('regulatory-compliance-failure')
        
        if 'whistleblower' in content or 'retaliation' in content:
            aspects.append('whistleblower-retaliation')
        
        return aspects
    
    def _identify_family_law_aspects(self, content, topic, claim):
        """Identify specific family law aspects"""
        aspects = []
        
        if 'curatorship' in content:
            aspects.append('curatorship-fraud')
        
        if 'mental' in content and 'capacity' in content:
            aspects.append('mental-capacity-manipulation')
        
        if 'medical testing' in content or 'medical test' in content:
            aspects.append('medical-testing-weaponization')
        
        if 'family court' in content:
            aspects.append('family-court-jurisdiction-abuse')
        
        return aspects
    
    def _extract_entities(self, content):
        """Extract entities mentioned in the content"""
        entities = []
        
        # Common entity patterns
        entity_patterns = [
            r'Peter\s+Faucitt',
            r'Jacqueline\s+Faucitt',
            r'Daniel\s+Faucitt',
            r'Rynette\s+Faucitt',
            r'Faucitt\s+Family\s+Trust',
            r'RegimA\s+(?:SA|Zone|Skin)',
            r'RWD\s+(?:Pty|Ltd)?',
            r'Ketoni',
            r'Bantjies'
        ]
        
        for pattern in entity_patterns:
            matches = re.findall(pattern, content, re.IGNORECASE)
            entities.extend(matches)
        
        return list(set(entities))
    
    def _calculate_confidence(self, domains, content):
        """Calculate confidence score for legal aspect identification"""
        if not domains:
            return 0.0
        
        # Base confidence on number of domains and evidence strength
        base_confidence = 0.7
        
        # Increase confidence if multiple domains identified
        domain_bonus = min(len(domains) * 0.05, 0.15)
        
        # Increase confidence if evidence keywords present
        evidence_keywords = ['annexure', 'evidence', 'bank statement', 'email', 'document']
        evidence_count = sum(1 for keyword in evidence_keywords if keyword in content.lower())
        evidence_bonus = min(evidence_count * 0.03, 0.15)
        
        confidence = base_confidence + domain_bonus + evidence_bonus
        
        return min(confidence, 1.0)
    
    def generate_report(self, output_file):
        """Generate comprehensive legal aspects report"""
        aspects = self.analyze_ad_paragraphs()
        
        report = {
            'version': '60.0',
            'date': datetime.now().isoformat(),
            'total_ad_paragraphs_analyzed': len(aspects),
            'legal_aspects': aspects,
            'domain_summary': self._generate_domain_summary(aspects),
            'priority_summary': self._generate_priority_summary(aspects)
        }
        
        with open(output_file, 'w', encoding='utf-8') as f:
            json.dump(report, f, indent=2, ensure_ascii=False)
        
        print(f"\nReport saved to: {output_file}")
        
        return report
    
    def _generate_domain_summary(self, aspects):
        """Generate summary by legal domain"""
        domain_counts = defaultdict(int)
        
        for aspect in aspects:
            for domain_info in aspect.get('identified_domains', []):
                domain_counts[domain_info['domain']] += 1
        
        return dict(domain_counts)
    
    def _generate_priority_summary(self, aspects):
        """Generate summary by priority"""
        priority_counts = defaultdict(int)
        
        for aspect in aspects:
            priority_counts[aspect['priority']] += 1
        
        return dict(priority_counts)

def main():
    repo_dir = Path(__file__).parent.parent
    output_file = Path(__file__).parent / 'legal_aspects_identified_v60.json'
    
    identifier = LegalAspectIdentifier(repo_dir)
    report = identifier.generate_report(output_file)
    
    # Generate markdown summary
    summary_file = Path(__file__).parent / 'legal_aspects_summary_v60.md'
    with open(summary_file, 'w', encoding='utf-8') as f:
        f.write("# Legal Aspects Identification Summary V60\n\n")
        f.write(f"**Date:** {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}\n\n")
        f.write("## Statistics\n\n")
        f.write(f"- **Total AD Paragraphs Analyzed:** {report['total_ad_paragraphs_analyzed']}\n")
        f.write(f"- **Total Legal Aspects Identified:** {len(report['legal_aspects'])}\n\n")
        
        f.write("## Domain Summary\n\n")
        for domain, count in sorted(report['domain_summary'].items(), key=lambda x: x[1], reverse=True):
            f.write(f"- **{domain}:** {count} occurrences\n")
        
        f.write("\n## Priority Summary\n\n")
        for priority, count in sorted(report['priority_summary'].items()):
            f.write(f"- **{priority}:** {count} paragraphs\n")
        
        f.write("\n## Sample Legal Aspects\n\n")
        for aspect in report['legal_aspects'][:10]:
            f.write(f"### AD PARAGRAPH {aspect['ad_paragraph']}\n")
            f.write(f"- **Priority:** {aspect['priority']}\n")
            f.write(f"- **Topic:** {aspect['topic']}\n")
            f.write(f"- **Peter's Claim:** {aspect['peters_claim']}\n")
            f.write(f"- **Confidence:** {aspect['confidence']:.2f}\n")
            f.write(f"- **Domains:** {', '.join([d['domain'] for d in aspect['identified_domains']])}\n\n")
    
    print(f"Summary saved to: {summary_file}")

if __name__ == '__main__':
    main()
