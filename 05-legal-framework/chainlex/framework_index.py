#!/usr/bin/env python3
"""
ChainLex Framework Index and Navigation System

Provides comprehensive indexing, search, and navigation capabilities for the
legal frameworks, enabling optimal grip on the 2,306 nodes across 8 legal branches.

Features:
- Fast function lookup across all frameworks
- Domain-based principle search
- Cross-reference mapping between Level 1 and Level 2+
- Inference chain discovery
- Framework statistics and analytics
"""

import json
import re
from pathlib import Path
from typing import List, Dict, Any, Optional, Set
from collections import defaultdict
import pickle


class FrameworkIndex:
    """Comprehensive index for ChainLex legal frameworks"""
    
    def __init__(self, base_path: str = "."):
        """Initialize the framework index"""
        self.base_path = Path(base_path)
        self.frameworks = {}
        self.function_index = {}
        self.principle_index = {}
        self.domain_index = defaultdict(list)
        self.cross_references = defaultdict(list)
        
        # Load all frameworks
        self._load_frameworks()
        self._build_indices()
    
    def _load_frameworks(self):
        """Load all legal framework definitions"""
        framework_defs = {
            'lv1': {'path': 'lv1', 'name': 'Level 1 Principles', 'level': 1},
            'civ': {'path': 'civ/za', 'name': 'Civil Law (ZA)', 'level': 2, 'domains': ['contract', 'delict', 'property', 'family']},
            'cri': {'path': 'cri/za', 'name': 'Criminal Law (ZA)', 'level': 2, 'domains': ['criminal']},
            'con': {'path': 'con/za', 'name': 'Constitutional Law (ZA)', 'level': 2, 'domains': ['constitutional']},
            'adm': {'path': 'adm/za', 'name': 'Administrative Law (ZA)', 'level': 2, 'domains': ['administrative']},
            'lab': {'path': 'lab/za', 'name': 'Labour Law (ZA)', 'level': 2, 'domains': ['labour', 'employment']},
            'env': {'path': 'env/za', 'name': 'Environmental Law (ZA)', 'level': 2, 'domains': ['environmental']},
            'cst': {'path': 'cst/za', 'name': 'Construction Law (ZA)', 'level': 2, 'domains': ['construction']},
            'int': {'path': 'int/za', 'name': 'International Law (ZA)', 'level': 2, 'domains': ['international']}
        }
        
        for code, info in framework_defs.items():
            path = self.base_path / info['path']
            if path.exists():
                self.frameworks[code] = {
                    'code': code,
                    'name': info['name'],
                    'level': info['level'],
                    'path': str(path),
                    'domains': info.get('domains', []),
                    'files': list(path.glob('*.scm')),
                    'functions': []
                }
    
    def _extract_functions_from_file(self, file_path: Path) -> List[Dict]:
        """Extract function definitions from a Scheme file"""
        try:
            with open(file_path, 'r', encoding='utf-8') as f:
                content = f.read()
            
            functions = []
            # Match define statements with optional lambda
            pattern = r'\(define\s+\(?(\w[\w-]*\??)\s*(?:\(lambda|\)?)'
            
            for match in re.finditer(pattern, content):
                func_name = match.group(1)
                start_pos = match.start()
                
                # Extract docstring if present
                docstring = ""
                doc_match = re.search(r'"([^"]*)"', content[match.end():match.end()+500])
                if doc_match:
                    docstring = doc_match.group(1)
                
                # Extract cross-references
                cross_refs = []
                cross_ref_match = re.search(
                    r'Cross-reference:\s*([^\n]+)',
                    content[match.end():match.end()+1000]
                )
                if cross_ref_match:
                    refs = cross_ref_match.group(1)
                    # Extract principle names
                    cross_refs = [r.strip() for r in re.findall(r'[\w-]+', refs) if r.strip()]
                
                # Determine if this is a principle or rule
                is_principle = 'Level 1' in content[match.end():match.end()+1000]
                
                functions.append({
                    'name': func_name,
                    'docstring': docstring,
                    'cross_references': cross_refs,
                    'is_principle': is_principle,
                    'file': file_path.name
                })
            
            return functions
        except Exception as e:
            print(f"Error processing {file_path}: {e}")
            return []
    
    def _build_indices(self):
        """Build comprehensive indices for fast lookup"""
        for code, framework in self.frameworks.items():
            all_functions = []
            
            for scm_file in framework['files']:
                functions = self._extract_functions_from_file(scm_file)
                all_functions.extend(functions)
                
                # Index each function
                for func in functions:
                    func_full_name = f"{code}:{func['name']}"
                    self.function_index[func_full_name] = {
                        'framework': code,
                        'framework_name': framework['name'],
                        **func
                    }
                    
                    # Index by domain
                    for domain in framework.get('domains', []):
                        self.domain_index[domain].append(func_full_name)
                    
                    # Index cross-references
                    for ref in func.get('cross_references', []):
                        self.cross_references[ref].append(func_full_name)
                    
                    # Index principles
                    if func.get('is_principle') or framework['level'] == 1:
                        self.principle_index[func['name']] = {
                            'framework': code,
                            **func
                        }
            
            framework['functions'] = all_functions
            framework['function_count'] = len(all_functions)
    
    def search_functions(self, query: str, domain: Optional[str] = None) -> List[Dict]:
        """
        Search for functions by name or description
        
        Args:
            query: Search query (function name or keyword)
            domain: Optional domain filter
        
        Returns:
            List of matching functions with metadata
        """
        results = []
        query_lower = query.lower()
        
        for func_name, func_data in self.function_index.items():
            # Check domain filter
            if domain:
                framework_code = func_data['framework']
                framework_domains = self.frameworks[framework_code].get('domains', [])
                if domain not in framework_domains:
                    continue
            
            # Check name match
            if query_lower in func_data['name'].lower():
                results.append({
                    'relevance': 'exact' if query_lower == func_data['name'].lower() else 'partial',
                    **func_data
                })
            # Check docstring match
            elif query_lower in func_data.get('docstring', '').lower():
                results.append({
                    'relevance': 'description',
                    **func_data
                })
        
        # Sort by relevance
        relevance_order = {'exact': 0, 'partial': 1, 'description': 2}
        results.sort(key=lambda x: relevance_order.get(x.get('relevance', 'description'), 3))
        
        return results
    
    def find_principles_by_domain(self, domain: str) -> List[Dict]:
        """Find all Level 1 principles applicable to a domain"""
        principles = []
        
        for principle_name, principle_data in self.principle_index.items():
            # Check cross-references from domain functions
            domain_funcs = self.domain_index.get(domain, [])
            for func_name in domain_funcs:
                func = self.function_index.get(func_name, {})
                if principle_name in func.get('cross_references', []):
                    if principle_name not in [p['name'] for p in principles]:
                        principles.append({
                            'name': principle_name,
                            'framework': principle_data.get('framework', 'lv1'),
                            'docstring': principle_data.get('docstring', ''),
                            'file': principle_data.get('file', '')
                        })
                        break
        
        return principles
    
    def find_derived_rules(self, principle_name: str) -> List[Dict]:
        """Find all Level 2+ rules derived from a Level 1 principle"""
        return [
            self.function_index[func_name]
            for func_name in self.cross_references.get(principle_name, [])
        ]
    
    def get_framework_stats(self) -> Dict:
        """Get comprehensive statistics about all frameworks"""
        stats = {
            'total_frameworks': len(self.frameworks),
            'total_functions': len(self.function_index),
            'total_principles': len(self.principle_index),
            'frameworks': {},
            'domains': {}
        }
        
        for code, framework in self.frameworks.items():
            stats['frameworks'][code] = {
                'name': framework['name'],
                'level': framework['level'],
                'function_count': framework['function_count'],
                'domains': framework.get('domains', [])
            }
        
        for domain, funcs in self.domain_index.items():
            stats['domains'][domain] = {
                'function_count': len(funcs),
                'principles': len(self.find_principles_by_domain(domain))
            }
        
        return stats
    
    def build_inference_chain(self, start_principle: str, end_function: str) -> Optional[List[Dict]]:
        """
        Build inference chain from a Level 1 principle to a specific function
        
        Args:
            start_principle: Name of Level 1 principle
            end_function: Name of target function
        
        Returns:
            List of nodes in the inference chain, or None if no path found
        """
        # Simple implementation - can be enhanced with graph traversal
        chain = []
        
        # Check if end_function directly references start_principle
        for func_name, func_data in self.function_index.items():
            if func_data['name'] == end_function:
                if start_principle in func_data.get('cross_references', []):
                    chain = [
                        {'node': start_principle, 'type': 'principle', 'level': 1},
                        {'node': end_function, 'type': 'rule', 'level': 2, **func_data}
                    ]
                break
        
        return chain if chain else None
    
    def export_index(self, output_file: str):
        """Export the complete index to JSON"""
        export_data = {
            'frameworks': self.frameworks,
            'function_index': self.function_index,
            'principle_index': self.principle_index,
            'domain_index': dict(self.domain_index),
            'cross_references': dict(self.cross_references),
            'stats': self.get_framework_stats()
        }
        
        # Convert Path objects to strings
        for fw_code, fw_data in export_data['frameworks'].items():
            fw_data['files'] = [str(f) for f in fw_data['files']]
        
        with open(output_file, 'w', encoding='utf-8') as f:
            json.dump(export_data, f, indent=2)
        
        print(f"✅ Exported index to {output_file}")
    
    def print_summary(self):
        """Print a summary of the index"""
        stats = self.get_framework_stats()
        
        print("\n" + "="*70)
        print("ChainLex Framework Index Summary")
        print("="*70)
        print(f"\n📚 Total Frameworks: {stats['total_frameworks']}")
        print(f"⚖️  Total Functions: {stats['total_functions']}")
        print(f"📜 Total Principles: {stats['total_principles']}")
        
        print("\n🏛️  Frameworks:")
        for code, fw_stats in stats['frameworks'].items():
            print(f"  {code:4s} - {fw_stats['name']:35s} [{fw_stats['function_count']:4d} functions]")
        
        print("\n🎯 Domains:")
        for domain, domain_stats in stats['domains'].items():
            print(f"  {domain:20s} - {domain_stats['function_count']:4d} functions, {domain_stats['principles']:2d} principles")
        
        print("\n" + "="*70)


def main():
    """Main entry point for framework indexing"""
    import sys
    
    # Create index
    print("Building ChainLex Framework Index...")
    index = FrameworkIndex()
    
    # Print summary
    index.print_summary()
    
    # Export to JSON
    output_file = "framework_index.json"
    index.export_index(output_file)
    
    # Examples
    print("\n" + "="*70)
    print("Example Queries")
    print("="*70)
    
    print("\n1️⃣  Search for 'contract' functions:")
    results = index.search_functions("contract")[:5]
    for r in results:
        print(f"  - {r['framework']}:{r['name']}")
    
    print("\n2️⃣  Find principles for 'contract' domain:")
    principles = index.find_principles_by_domain("contract")[:5]
    for p in principles:
        print(f"  - {p['name']}")
    
    print("\n3️⃣  Find rules derived from 'pacta-sunt-servanda':")
    derived = index.find_derived_rules("pacta-sunt-servanda")[:5]
    for d in derived:
        print(f"  - {d['framework']}:{d['name']}")
    
    print("\n" + "="*70)
    
    return 0


if __name__ == "__main__":
    exit(main())
