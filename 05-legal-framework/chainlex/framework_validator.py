#!/usr/bin/env python3
"""
ChainLex Framework Validation Tool

Validates the consistency and completeness of legal frameworks, ensuring
optimal grip through quality assurance.

Validation Checks:
- Framework structure integrity
- Cross-reference validity
- Function naming consistency
- Docstring completeness
- Domain coverage
- Principle-rule linkages
"""

import re
from pathlib import Path
from typing import List, Dict, Any, Tuple
from collections import defaultdict
from framework_index import FrameworkIndex


class FrameworkValidator:
    """Validates ChainLex legal frameworks"""
    
    def __init__(self, base_path: str = "."):
        self.base_path = Path(base_path)
        self.index = FrameworkIndex(str(base_path))
        self.errors = []
        self.warnings = []
        self.info = []
    
    def validate_all(self) -> Dict[str, Any]:
        """Run all validation checks"""
        print("Running ChainLex Framework Validation...")
        print("="*70)
        
        # Run checks
        self.check_framework_structure()
        self.check_cross_references()
        self.check_naming_conventions()
        self.check_docstrings()
        self.check_domain_coverage()
        self.check_principle_linkages()
        
        # Compile results
        results = {
            'passed': len(self.errors) == 0,
            'total_checks': len(self.errors) + len(self.warnings) + len(self.info),
            'errors': self.errors,
            'warnings': self.warnings,
            'info': self.info,
            'summary': self._generate_summary()
        }
        
        return results
    
    def check_framework_structure(self):
        """Validate framework directory structure"""
        print("\n✓ Checking framework structure...")
        
        expected_frameworks = ['lv1', 'civ', 'cri', 'con', 'adm', 'lab', 'env', 'cst', 'int']
        
        for code in expected_frameworks:
            if code not in self.index.frameworks:
                self.errors.append({
                    'check': 'structure',
                    'severity': 'error',
                    'message': f'Missing framework: {code}'
                })
            else:
                framework = self.index.frameworks[code]
                if not framework['files']:
                    self.warnings.append({
                        'check': 'structure',
                        'severity': 'warning',
                        'message': f'No .scm files found in framework: {code}'
                    })
                else:
                    self.info.append({
                        'check': 'structure',
                        'message': f'Framework {code}: {len(framework["files"])} files, {framework["function_count"]} functions'
                    })
    
    def check_cross_references(self):
        """Validate cross-references between principles and rules"""
        print("✓ Checking cross-references...")
        
        # Get all principle names
        principle_names = set(self.index.principle_index.keys())
        
        # Check each function's cross-references
        invalid_refs = []
        for func_name, func_data in self.index.function_index.items():
            cross_refs = func_data.get('cross_references', [])
            for ref in cross_refs:
                # Skip non-principle references (e.g., "Level 1", "Level 2")
                if ref.lower() in ['level', 'l1', 'l2', '1', '2']:
                    continue
                
                # Check if reference exists
                if ref not in principle_names and ref not in self.index.function_index:
                    invalid_refs.append({
                        'function': func_name,
                        'invalid_ref': ref
                    })
        
        if invalid_refs:
            # Sample first 5
            for item in invalid_refs[:5]:
                self.warnings.append({
                    'check': 'cross_references',
                    'severity': 'warning',
                    'message': f'Function {item["function"]} references unknown principle: {item["invalid_ref"]}'
                })
            if len(invalid_refs) > 5:
                self.warnings.append({
                    'check': 'cross_references',
                    'severity': 'warning',
                    'message': f'... and {len(invalid_refs) - 5} more invalid references'
                })
        else:
            self.info.append({
                'check': 'cross_references',
                'message': 'All cross-references valid'
            })
    
    def check_naming_conventions(self):
        """Check function naming conventions"""
        print("✓ Checking naming conventions...")
        
        issues = []
        
        for func_name, func_data in self.index.function_index.items():
            name = func_data['name']
            
            # Check for consistent naming patterns
            # Functions should be kebab-case with optional ?
            if not re.match(r'^[a-z][a-z0-9-]*\??$', name):
                issues.append({
                    'function': func_name,
                    'issue': 'Non-standard naming (expected kebab-case)'
                })
            
            # Predicates should end with ?
            predicate_words = ['is', 'has', 'can', 'valid', 'exists', 'applicable']
            if any(word in name for word in predicate_words) and not name.endswith('?'):
                issues.append({
                    'function': func_name,
                    'issue': 'Predicate function should end with ?'
                })
        
        if issues:
            for issue in issues[:5]:
                self.warnings.append({
                    'check': 'naming',
                    'severity': 'warning',
                    'message': f'{issue["function"]}: {issue["issue"]}'
                })
            if len(issues) > 5:
                self.warnings.append({
                    'check': 'naming',
                    'severity': 'warning',
                    'message': f'... and {len(issues) - 5} more naming issues'
                })
        else:
            self.info.append({
                'check': 'naming',
                'message': 'All function names follow conventions'
            })
    
    def check_docstrings(self):
        """Check docstring completeness"""
        print("✓ Checking docstrings...")
        
        missing_docs = []
        
        for func_name, func_data in self.index.function_index.items():
            docstring = func_data.get('docstring', '')
            if not docstring or len(docstring.strip()) < 10:
                missing_docs.append(func_name)
        
        if missing_docs:
            percentage = (len(missing_docs) / len(self.index.function_index)) * 100
            self.warnings.append({
                'check': 'docstrings',
                'severity': 'warning',
                'message': f'{len(missing_docs)} functions ({percentage:.1f}%) lack adequate docstrings'
            })
        else:
            self.info.append({
                'check': 'docstrings',
                'message': 'All functions have docstrings'
            })
    
    def check_domain_coverage(self):
        """Check domain coverage and balance"""
        print("✓ Checking domain coverage...")
        
        domain_stats = {}
        for domain, func_names in self.index.domain_index.items():
            domain_stats[domain] = len(func_names)
        
        if not domain_stats:
            self.errors.append({
                'check': 'domains',
                'severity': 'error',
                'message': 'No domains found'
            })
            return
        
        # Check for empty domains
        for domain, count in domain_stats.items():
            if count == 0:
                self.warnings.append({
                    'check': 'domains',
                    'severity': 'warning',
                    'message': f'Domain {domain} has no functions'
                })
        
        # Report coverage
        total_functions = sum(domain_stats.values())
        self.info.append({
            'check': 'domains',
            'message': f'{len(domain_stats)} domains covering {total_functions} function references'
        })
    
    def check_principle_linkages(self):
        """Check linkages between Level 1 principles and Level 2+ rules"""
        print("✓ Checking principle linkages...")
        
        # Count how many rules each principle links to
        principle_usage = defaultdict(int)
        
        for func_name, func_data in self.index.function_index.items():
            # Skip Level 1 principles themselves
            if func_data.get('framework') == 'lv1':
                continue
            
            cross_refs = func_data.get('cross_references', [])
            for ref in cross_refs:
                if ref in self.index.principle_index:
                    principle_usage[ref] += 1
        
        # Find unused principles
        unused_principles = []
        for principle_name in self.index.principle_index.keys():
            if principle_name not in principle_usage:
                unused_principles.append(principle_name)
        
        if unused_principles:
            self.warnings.append({
                'check': 'linkages',
                'severity': 'warning',
                'message': f'{len(unused_principles)} Level 1 principles not referenced by any rules'
            })
        
        # Report most-used principles
        if principle_usage:
            top_principles = sorted(
                principle_usage.items(),
                key=lambda x: x[1],
                reverse=True
            )[:5]
            
            self.info.append({
                'check': 'linkages',
                'message': f'Most referenced principles: {", ".join([f"{p}({c})" for p, c in top_principles])}'
            })
    
    def _generate_summary(self) -> str:
        """Generate validation summary"""
        lines = [
            "\n" + "="*70,
            "Validation Summary",
            "="*70,
        ]
        
        if self.errors:
            lines.append(f"\n❌ ERRORS: {len(self.errors)}")
            for error in self.errors[:5]:
                lines.append(f"  • {error['message']}")
        else:
            lines.append("\n✅ No errors found")
        
        if self.warnings:
            lines.append(f"\n⚠️  WARNINGS: {len(self.warnings)}")
            for warning in self.warnings[:5]:
                lines.append(f"  • {warning['message']}")
        
        if self.info:
            lines.append(f"\n📋 INFO: {len(self.info)}")
            for info in self.info[:5]:
                lines.append(f"  • {info['message']}")
        
        lines.append("\n" + "="*70)
        
        return "\n".join(lines)
    
    def print_results(self, results: Dict[str, Any]):
        """Print validation results"""
        print(results['summary'])
        
        if results['passed']:
            print("\n🎉 All validation checks passed!")
        else:
            print("\n⚠️  Validation completed with issues")
        
        print(f"\nTotal checks: {results['total_checks']}")
        print(f"Errors: {len(results['errors'])}")
        print(f"Warnings: {len(results['warnings'])}")
        print(f"Info: {len(results['info'])}")


def main():
    """Main validation entry point"""
    validator = FrameworkValidator()
    results = validator.validate_all()
    validator.print_results(results)
    
    # Return exit code based on results
    return 0 if results['passed'] else 1


if __name__ == "__main__":
    exit(main())
