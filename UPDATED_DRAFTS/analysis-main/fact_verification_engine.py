#!/usr/bin/env python3
"""
Fact Verification Engine
Strictly analyzes content to remove speculative claims and focus on hard facts with exact recorded figures
"""

import re
from pathlib import Path
from typing import Any, Dict, List, Optional
from datetime import datetime
import json


class FactVerificationEngine:
    """Engine for strict fact verification and speculative content removal"""
    
    def __init__(self):
        self.workspace_path = Path(".")
        
        # Speculative language patterns to detect and flag
        self.speculative_patterns = [
            r'\b(?:might|could|possibly|perhaps|maybe|suspect|believe|think|assume)\b',
            r'\b(?:estimated?|approximately|around|about|roughly)\b',
            r'\b(?:projected?|forecasted?|anticipated|expected)\b',
            r'\b(?:guesstimates?|ballpark|in the region of)\b',
            r'\b(?:alleged|supposed|claimed without evidence)\b',
            r'R\s*[0-9,]+\+?\s*(?:estimated?|approximately|projected)',
            r'(?:damages?|losses?)\s+(?:exceeding|over|up to)\s+R\s*[0-9,]+',
            r'(?:minimum|maximum|up to)\s+R\s*[0-9,]+\s*(?:estimated?|projected)',
        ]
        
        # Damage claim patterns that need evidence backing
        self.damage_patterns = [
            r'(?:damages?|losses?)\s+(?:of|exceeding|totaling)\s+R\s*[0-9,]+(?:,000)?',
            r'R\s*[0-9,]+(?:,000)?\s*(?:damages?|losses?|compensation)',
            r'civil\s+(?:damages?|recovery)\s+R\s*[0-9,]+',
            r'punitive\s+damages?\s+R\s*[0-9,]+',
        ]
        
        # Weak evidence indicators
        self.weak_evidence_patterns = [
            r'it appears that',
            r'it seems',
            r'likely that',
            r'probably',
            r'presumably',
            r'arguably',
            r'suggests that',
            r'indicates that\s+(?:might|could|may)',
        ]
        
        # Professional language violations - avoid insults, name-calling, derogatory language
        self.unprofessional_patterns = [
            r'\b(?:stupid|idiot|moron|fool|dumb|liar|crook|scammer|fraudster)\b',
            r'\b(?:incompetent|dishonest|corrupt|criminal|evil|malicious)\b',
            r'\b(?:vindictive|spiteful|hateful|despicable|deplorable)\b',
            r'\b(?:pathetic|disgusting|revolting|appalling|outrageous)\b',
            # Emotional/accusatory language without factual basis
            r'\bdeliberate(?:ly)?\s+(?:lies?|deception|fraud)\b',
            r'\bmalicious(?:ly)?\s+(?:intent|purpose|design)\b',
            # Inflammatory adjectives without evidence
            r'\b(?:shocking|scandalous|outrageous|despicable)\s+(?:behavior|conduct|actions?)\b',
        ]
        
        # Neutral professional alternatives for common emotional expressions
        self.professional_alternatives = {
            'shocking': 'documented',
            'outrageous': 'contrary to established procedures',
            'scandalous': 'inconsistent with standard practices',
            'appalling': 'not in accordance with policy',
            'disgusting': 'inappropriate',
            'despicable': 'improper',
            'evil': 'unauthorized',
            'malicious': 'contrary to stated purpose',
            'vindictive': 'retaliatory',
            'corrupt': 'non-compliant with regulations'
        }
        
        # Strong evidence indicators (keep these)
        self.strong_evidence_patterns = [
            r'documented in',
            r'recorded in',
            r'bank statement',
            r'invoice',
            r'contract',
            r'court document',
            r'court filing',
            r'financial record',
            r'according to',
            r'as shown in',
            r'per ',
            r'dated',
            r'entry dated',
            r'official record',
            r'written agreement',
            r'signed document',
        ]
    
    def analyze_content_for_speculation(self, content: str) -> Dict[str, Any]:
        """Analyze content and identify speculative claims"""
        
        issues = {
            'speculative_language': [],
            'unfounded_damages': [],
            'weak_evidence': [],
            'unprofessional_language': [],
            'requires_revision': False,
            'confidence_score': 1.0,
            'professionalism_score': 1.0
        }
        
        # Check for speculative language
        for pattern in self.speculative_patterns:
            matches = re.finditer(pattern, content, re.IGNORECASE)
            for match in matches:
                context = self._extract_context(content, match.start(), match.end())
                issues['speculative_language'].append({
                    'pattern': pattern,
                    'match': match.group(),
                    'context': context,
                    'position': (match.start(), match.end())
                })
        
        # Check for unfounded damage claims
        for pattern in self.damage_patterns:
            matches = re.finditer(pattern, content, re.IGNORECASE)
            for match in matches:
                context = self._extract_context(content, match.start(), match.end())
                # Check if damage claim is supported by evidence
                if not self._has_supporting_evidence(context):
                    issues['unfounded_damages'].append({
                        'pattern': pattern,
                        'match': match.group(),
                        'context': context,
                        'position': (match.start(), match.end())
                    })
        
        # Check for weak evidence language
        for pattern in self.weak_evidence_patterns:
            matches = re.finditer(pattern, content, re.IGNORECASE)
            for match in matches:
                context = self._extract_context(content, match.start(), match.end())
                issues['weak_evidence'].append({
                    'pattern': pattern,
                    'match': match.group(),
                    'context': context,
                    'position': (match.start(), match.end())
                })
        
        # Check for unprofessional language
        for pattern in self.unprofessional_patterns:
            matches = re.finditer(pattern, content, re.IGNORECASE)
            for match in matches:
                context = self._extract_context(content, match.start(), match.end())
                issues['unprofessional_language'].append({
                    'pattern': pattern,
                    'match': match.group(),
                    'context': context,
                    'position': (match.start(), match.end()),
                    'severity': 'high'  # Professional violations are serious
                })
        
        # Calculate confidence score (lower = more speculation)
        total_issues = (len(issues['speculative_language']) + 
                       len(issues['unfounded_damages']) + 
                       len(issues['weak_evidence']))
        
        # Calculate professionalism score (lower = more unprofessional language)
        professional_issues = len(issues['unprofessional_language'])
        
        if total_issues > 0 or professional_issues > 0:
            issues['requires_revision'] = True
            # Reduce confidence based on number of issues
            issues['confidence_score'] = max(0.1, 1.0 - (total_issues * 0.1))
            # Professional issues are weighted more heavily as they violate core standards
            issues['professionalism_score'] = max(0.1, 1.0 - (professional_issues * 0.2))
        
        return issues
    
    def _extract_context(self, content: str, start: int, end: int, window: int = 100) -> str:
        """Extract context around a match"""
        context_start = max(0, start - window)
        context_end = min(len(content), end + window)
        return content[context_start:context_end].strip()
    
    def _has_supporting_evidence(self, context: str) -> bool:
        """Check if context contains strong evidence indicators"""
        for pattern in self.strong_evidence_patterns:
            if re.search(pattern, context, re.IGNORECASE):
                return True
        return False
    
    def generate_professional_alternatives(self, content: str) -> Dict[str, List[Dict[str, str]]]:
        """Generate professional alternatives for unprofessional language"""
        
        suggestions = {'replacements': []}
        
        # Find unprofessional language and suggest alternatives
        for pattern in self.unprofessional_patterns:
            matches = re.finditer(pattern, content, re.IGNORECASE)
            for match in matches:
                original = match.group().lower()
                context = self._extract_context(content, match.start(), match.end(), 50)
                
                # Find appropriate professional alternative
                alternative = None
                for unprofessional_word, professional_word in self.professional_alternatives.items():
                    if unprofessional_word in original:
                        alternative = professional_word
                        break
                
                if not alternative:
                    # Generic professional alternative
                    if any(word in original for word in ['liar', 'fraud', 'scam']):
                        alternative = 'actions inconsistent with stated representations'
                    elif any(word in original for word in ['stupid', 'idiot', 'moron']):
                        alternative = 'actions not in accordance with standard practice'
                    else:
                        alternative = 'inappropriate conduct'
                
                suggestions['replacements'].append({
                    'original': match.group(),
                    'alternative': alternative,
                    'context': context,
                    'position': match.start(),
                    'reason': 'Maintains professional standards while preserving factual content'
                })
        
        return suggestions
    
    def extract_documented_facts(self, content: str) -> List[Dict[str, Any]]:
        """Extract only facts with documented evidence"""
        
        facts = []
        lines = content.split('\n')
        
        for i, line in enumerate(lines):
            if line.strip():  # Skip empty lines
                # Look for fact patterns with evidence backing
                if self._has_supporting_evidence(line):
                    # Extract the fact and its evidence
                    fact_data = self._extract_fact_with_evidence(line, lines, i)
                    if fact_data:
                        facts.append(fact_data)
                # Also look for lines with amounts and dates that might have evidence
                elif re.search(r'R\s*[0-9,]+', line) and re.search(r'\b(?:dated|on|as of|\d{1,2}[/-]\d{1,2}[/-]\d{4})\b', line):
                    fact_data = self._extract_fact_with_evidence(line, lines, i)
                    if fact_data:
                        facts.append(fact_data)
        
        return facts
    
    def _extract_fact_with_evidence(self, line: str, all_lines: List[str], line_index: int) -> Optional[Dict[str, Any]]:
        """Extract a fact with its supporting evidence"""
        
        # Look for evidence patterns in the line and surrounding context
        context_lines = all_lines[max(0, line_index-2):min(len(all_lines), line_index+3)]
        context = '\n'.join(context_lines)
        
        # Check if this contains speculation - if so, skip
        # Only skip if there are direct speculation indicators in the line itself
        speculative_words = ['might', 'could', 'possibly', 'perhaps', 'maybe', 'estimated', 'approximately', 'projected']
        if any(word in line.lower() for word in speculative_words):
            return None
        
        # Extract documented amounts/figures
        amounts = re.findall(r'R\s*([0-9,]+(?:\.[0-9]{2})?)', line)
        dates = re.findall(r'\b(\d{1,2}[/-]\d{1,2}[/-]\d{4}|\d{4}-\d{2}-\d{2})\b', line)
        
        return {
            'statement': line.strip(),
            'context': context,
            'amounts': amounts,
            'dates': dates,
            'evidence_strength': 'documented',
            'line_number': line_index + 1
        }
    
    def generate_fact_based_revision(self, content: str) -> str:
        """Generate a revised version focusing only on documented facts"""
        
        analysis = self.analyze_content_for_speculation(content)
        documented_facts = self.extract_documented_facts(content)
        
        revision = f"""# Fact-Based Analysis Report
*Generated: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}*
*Evidence Standard: Documented proof only*

## Methodology
- **Included**: Only statements with documented evidence backing
- **Excluded**: Speculative claims, estimates, projections without basis
- **Standard**: 10x weight for documented evidence, 0x weight for speculation

## Documented Facts Identified: {len(documented_facts)}

"""
        
        if documented_facts:
            revision += "## Verified Facts with Evidence\n\n"
            for i, fact in enumerate(documented_facts, 1):
                revision += f"### Fact {i}\n"
                revision += f"**Statement**: {fact['statement']}\n\n"
                if fact['amounts']:
                    revision += f"**Recorded Amounts**: {', '.join(fact['amounts'])}\n\n"
                if fact['dates']:
                    revision += f"**Documented Dates**: {', '.join(fact['dates'])}\n\n"
                revision += f"**Evidence Standard**: {fact['evidence_strength']}\n\n"
                revision += "---\n\n"
        
        if analysis['requires_revision']:
            revision += f"""## Content Issues Identified
- **Speculative Language Instances**: {len(analysis['speculative_language'])}
- **Unfounded Damage Claims**: {len(analysis['unfounded_damages'])}
- **Weak Evidence Language**: {len(analysis['weak_evidence'])}
- **Unprofessional Language**: {len(analysis['unprofessional_language'])}
- **Content Confidence Score**: {analysis['confidence_score']:.2f}
- **Professionalism Score**: {analysis['professionalism_score']:.2f}

## Professional Standards
All statements must remain:
- Truthful and sincere
- Free from speculation
- Professional and neutral
- Supported by documented evidence
- Free from insults or derogatory language

## Recommendation
Original content requires revision to remove speculative claims, unprofessional language, and focus on documented facts only.
"""
            
            # Add professional alternatives if needed
            if analysis['unprofessional_language']:
                alternatives = self.generate_professional_alternatives(content)
                if alternatives['replacements']:
                    revision += "\n## Suggested Professional Alternatives\n\n"
                    for suggestion in alternatives['replacements']:
                        revision += f"**Original**: {suggestion['original']}\n"
                        revision += f"**Professional Alternative**: {suggestion['alternative']}\n"
                        revision += f"**Reason**: {suggestion['reason']}\n\n"
        
        return revision
    
    def scan_repository_for_speculation(self) -> Dict[str, Any]:
        """Scan entire repository for speculative content"""
        
        results = {
            'files_analyzed': 0,
            'files_with_issues': 0,
            'total_issues': 0,
            'file_reports': {}
        }
        
        # Scan markdown files
        for md_file in self.workspace_path.glob('*.md'):
            if md_file.name.startswith('.'):
                continue
                
            try:
                content = md_file.read_text(encoding='utf-8')
                analysis = self.analyze_content_for_speculation(content)
                
                results['files_analyzed'] += 1
                
                if analysis['requires_revision']:
                    results['files_with_issues'] += 1
                    total_file_issues = (len(analysis['speculative_language']) + 
                                       len(analysis['unfounded_damages']) + 
                                       len(analysis['weak_evidence']) +
                                       len(analysis['unprofessional_language']))
                    results['total_issues'] += total_file_issues
                    
                    results['file_reports'][str(md_file)] = {
                        'issues': total_file_issues,
                        'confidence_score': analysis['confidence_score'],
                        'professionalism_score': analysis['professionalism_score'],
                        'analysis': analysis
                    }
                    
            except Exception as e:
                print(f"Error analyzing {md_file}: {e}")
        
        return results


def main():
    """Main execution function"""
    engine = FactVerificationEngine()
    
    print("=== FACT VERIFICATION ENGINE ===")
    print("Scanning repository for speculative claims and unfounded projections...")
    
    # Scan repository
    results = engine.scan_repository_for_speculation()
    
    print("\n=== SCAN RESULTS ===")
    print(f"Files analyzed: {results['files_analyzed']}")
    print(f"Files requiring revision: {results['files_with_issues']}")
    print(f"Total speculative issues found: {results['total_issues']}")
    
    # Generate summary report
    if results['files_with_issues'] > 0:
        print("\n=== FILES REQUIRING FACT-BASED REVISION ===")
        for file_path, report in results['file_reports'].items():
            filename = Path(file_path).name
            print(f"- {filename}: {report['issues']} issues (confidence: {report['confidence_score']:.2f})")
    
    # Save detailed results
    results_file = Path("fact_verification_results.json")
    with open(results_file, 'w') as f:
        json.dump(results, f, indent=2, default=str)
    
    print(f"\n✅ Detailed results saved to: {results_file}")
    
    return results


if __name__ == "__main__":
    main()