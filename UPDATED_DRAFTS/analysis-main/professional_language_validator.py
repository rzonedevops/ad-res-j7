#!/usr/bin/env python3
"""
Professional Language Validator
Ensures all statements are truthful, sincere, and maintain professional standards
"""

import re
from pathlib import Path
from typing import Dict, List, Any
from datetime import datetime


class ProfessionalLanguageValidator:
    """Validates content for professional communication standards"""
    
    def __init__(self):
        # Core principles for professional communication
        self.core_principles = {
            'truthfulness': 'All statements must be backed by documented evidence',
            'sincerity': 'All statements must reflect honest interpretation of facts',
            'professionalism': 'Language must remain neutral and respectful',
            'factual_basis': 'Claims must be supported by verifiable evidence',
            'neutrality': 'Avoid emotional or inflammatory language'
        }
        
        # Prohibited language patterns
        self.prohibited_patterns = [
            # Personal attacks and name-calling
            r'\b(?:stupid|idiot|moron|fool|dumb|liar|crook|scammer|fraudster)\b',
            # Derogatory characterizations
            r'\b(?:incompetent|dishonest|corrupt|criminal|evil|malicious)\b',
            r'\b(?:vindictive|spiteful|hateful|despicable|deplorable)\b',
            r'\b(?:pathetic|disgusting|revolting|appalling|outrageous)\b',
            # Inflammatory accusations without evidence
            r'\bdeliberate(?:ly)?\s+(?:lies?|lying|deception|fraud)\b',
            r'\bmalicious(?:ly)?\s+(?:intent|purpose|design|attack)\b',
            # Emotional language that lacks objectivity
            r'\b(?:shocking|scandalous|outrageous|despicable)\s+(?:behavior|conduct|actions?)\b',
            # Speculation presented as fact
            r'\b(?:clearly|obviously|undoubtedly)\s+(?:intended to|designed to|meant to)\b',
            # False accusations without evidence
            r'\b(?:knowingly|deliberately|intentionally)\s+(?:misled|deceived|lied)\b'
        ]
        
        # Required professional alternatives
        self.professional_replacements = {
            'shocking': 'documented as inconsistent with standard procedures',
            'outrageous': 'contrary to established protocols',
            'scandalous': 'not in accordance with policy requirements',
            'appalling': 'inappropriate per professional standards',
            'disgusting': 'improper according to established guidelines',
            'despicable': 'contrary to expected professional conduct',
            'evil': 'unauthorized and contrary to stated purpose',
            'malicious intent': 'actions contrary to stated representations',
            'deliberate deception': 'actions inconsistent with documented statements',
            'obvious fraud': 'actions not in accordance with documented agreements',
            'clearly lying': 'statements inconsistent with documented evidence',
            'vindictive': 'retaliatory in nature',
            'corrupt': 'non-compliant with regulatory requirements'
        }
        
        # Evidence-based language requirements
        self.evidence_requirements = [
            r'(?:according to|as documented in|per|as shown in|recorded in)',
            r'(?:documented evidence shows|records indicate|official documents state)',
            r'(?:court filings demonstrate|financial records show|contracts specify)',
            r'(?:bank statement|court document|financial record|invoice)',
            r'(?:dated|entry dated|document|filing|statement)'
        ]
        
    def validate_content(self, content: str) -> Dict[str, Any]:
        """Validate content against professional communication standards"""
        
        validation_result = {
            'is_professional': True,
            'violations': [],
            'suggestions': [],
            'professionalism_score': 1.0,
            'truthfulness_score': 1.0,
            'evidence_backing': 0.0
        }
        
        # Check for prohibited language
        for pattern in self.prohibited_patterns:
            matches = re.finditer(pattern, content, re.IGNORECASE)
            for match in matches:
                validation_result['is_professional'] = False
                validation_result['violations'].append({
                    'type': 'unprofessional_language',
                    'text': match.group(),
                    'position': match.start(),
                    'context': self._get_context(content, match.start(), match.end()),
                    'severity': 'high',
                    'principle_violated': 'professionalism'
                })
        
        # Check for evidence backing
        evidence_ratio = self._calculate_evidence_ratio(content)
        validation_result['evidence_backing'] = evidence_ratio
        
        if evidence_ratio < 0.5:
            validation_result['violations'].append({
                'type': 'insufficient_evidence',
                'text': 'Content lacks sufficient evidence backing',
                'severity': 'medium',
                'principle_violated': 'factual_basis'
            })
        
        # Generate suggestions for improvements
        validation_result['suggestions'] = self._generate_suggestions(content)
        
        # Calculate scores
        high_severity_count = len([v for v in validation_result['violations'] if v.get('severity') == 'high'])
        
        validation_result['professionalism_score'] = max(0.1, 1.0 - (high_severity_count * 0.3))
        validation_result['truthfulness_score'] = max(0.1, evidence_ratio)
        
        return validation_result
    
    def _get_context(self, content: str, start: int, end: int, window: int = 80) -> str:
        """Extract context around a match"""
        context_start = max(0, start - window)
        context_end = min(len(content), end + window)
        return content[context_start:context_end].strip()
    
    def _calculate_evidence_ratio(self, content: str) -> float:
        """Calculate the ratio of evidence-backed statements to total statements"""
        
        # Count sentences with evidence backing
        sentences = re.split(r'[.!?]+', content)
        evidence_backed = 0
        total_sentences = len([s for s in sentences if s.strip()])
        
        if total_sentences == 0:
            return 0.0
        
        for sentence in sentences:
            if any(re.search(pattern, sentence, re.IGNORECASE) for pattern in self.evidence_requirements):
                evidence_backed += 1
        
        return evidence_backed / total_sentences
    
    def _generate_suggestions(self, content: str) -> List[Dict[str, str]]:
        """Generate suggestions for improving professional standards"""
        
        suggestions = []
        
        # Check for each prohibited pattern and suggest alternatives
        for pattern in self.prohibited_patterns:
            matches = re.finditer(pattern, content, re.IGNORECASE)
            for match in matches:
                original_text = match.group().lower()
                
                # Find appropriate professional alternative
                for problematic, professional in self.professional_replacements.items():
                    if any(word in original_text for word in problematic.split()):
                        suggestions.append({
                            'original': match.group(),
                            'suggestion': professional,
                            'reason': 'Maintains professional standards while preserving factual accuracy',
                            'principle': 'Professional neutrality and evidence-based communication'
                        })
                        break
                else:
                    # Generic professional suggestion
                    suggestions.append({
                        'original': match.group(),
                        'suggestion': 'factual description based on documented evidence',
                        'reason': 'Removes subjective characterization, focuses on documented facts',
                        'principle': 'Objective, evidence-based communication'
                    })
        
        return suggestions
    
    def generate_professional_report(self, content: str, file_path: str = None) -> str:
        """Generate a report on professional communication standards compliance"""
        
        validation = self.validate_content(content)
        
        report = f"""# Professional Communication Standards Report
*Generated: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}*
*File: {file_path or 'Content Analysis'}*

## Core Principles Assessment

### Truthfulness and Sincerity
- **Evidence Backing**: {validation['evidence_backing']:.2f} ({validation['evidence_backing']*100:.1f}% of statements have evidence support)
- **Truthfulness Score**: {validation['truthfulness_score']:.2f}
- **Standard**: All statements must be backed by documented evidence and reflect honest interpretation of facts

### Professionalism and Neutrality  
- **Professionalism Score**: {validation['professionalism_score']:.2f}
- **Professional Language**: {'✅ Compliant' if validation['is_professional'] else '❌ Violations Found'}
- **Standard**: Language must remain neutral, respectful, and free from derogatory characterizations

## Compliance Status: {'✅ COMPLIANT' if validation['is_professional'] and validation['evidence_backing'] > 0.5 else '❌ REQUIRES REVISION'}

"""
        
        if validation['violations']:
            report += "## Violations Identified\n\n"
            for i, violation in enumerate(validation['violations'], 1):
                report += f"### Violation {i}: {violation['type'].replace('_', ' ').title()}\n"
                if violation.get('text'):
                    report += f"**Text**: {violation['text']}\n"
                if violation.get('context'):
                    report += f"**Context**: ...{violation['context']}...\n"
                report += f"**Severity**: {violation['severity'].title()}\n"
                report += f"**Principle Violated**: {violation['principle_violated']}\n\n"
        
        if validation['suggestions']:
            report += "## Professional Improvement Suggestions\n\n"
            for i, suggestion in enumerate(validation['suggestions'], 1):
                report += f"### Suggestion {i}\n"
                report += f"**Original**: {suggestion['original']}\n"
                report += f"**Professional Alternative**: {suggestion['suggestion']}\n"
                report += f"**Reason**: {suggestion['reason']}\n"
                report += f"**Principle**: {suggestion['principle']}\n\n"
        
        report += """
## Professional Standards Requirements

### ✅ Must Include:
- Documented evidence for all factual claims
- Neutral, objective language
- Truthful and sincere interpretation of facts
- Professional tone throughout
- Focus on material evidence and documented facts

### ❌ Must Avoid:
- Speculation without evidence backing
- Personal attacks or name-calling
- Derogatory characterizations
- Inflammatory language
- False accusations
- Emotional or subjective language

## Governing Principles
Above all else, ensure that statements are truthful and sincere and represent an honest interpretation of the available facts in light of governing laws. Avoid speculative claims and regardless of the harmful nature of any actions by the opposition, never resort to insults, name-calling, false accusations, or derogatory language. Remain professional and neutral at all times and allow the facts and evidence to speak for themselves.

*This report ensures compliance with the highest standards of professional communication while maintaining factual accuracy and legal admissibility.*
"""
        
        return report


def main():
    """Main execution function for professional language validation"""
    validator = ProfessionalLanguageValidator()
    
    print("=== PROFESSIONAL LANGUAGE VALIDATOR ===")
    print("Validating content for professional communication standards...")
    
    # Example usage - could be extended to scan repository files
    workspace_path = Path(".")
    
    # Scan key files for professional standards
    key_files = [
        'FACT_VERIFICATION_COMPLETION_REPORT.md',
        'MATERIAL_EVIDENCE_REPORT.md',
        'EVIDENCE_BASED_REPORT.md'
    ]
    
    results = {}
    
    for file_name in key_files:
        file_path = workspace_path / file_name
        if file_path.exists():
            try:
                content = file_path.read_text(encoding='utf-8')
                validation = validator.validate_content(content)
                results[file_name] = validation
                
                # Generate individual report
                report = validator.generate_professional_report(content, file_name)
                report_file = workspace_path / f"{file_name}_PROFESSIONAL_STANDARDS_REPORT.md"
                report_file.write_text(report)
                
                print(f"✅ Professional standards report for {file_name} saved to {report_file}")
                
            except Exception as e:
                print(f"❌ Error processing {file_name}: {e}")
    
    # Generate summary
    total_files = len(results)
    compliant_files = len([r for r in results.values() if r['is_professional'] and r['evidence_backing'] > 0.5])
    
    print("\n=== PROFESSIONAL STANDARDS SUMMARY ===")
    print(f"Files analyzed: {total_files}")
    print(f"Fully compliant: {compliant_files}")
    print(f"Requiring revision: {total_files - compliant_files}")
    
    return results


if __name__ == "__main__":
    main()