#!/usr/bin/env python3
"""
ChainLex Python API - Unified Interface for Legal Framework Access

Provides a clean, intuitive Python API for working with the ChainLex legal
frameworks, enabling optimal grip through simple function calls.

Features:
- Easy framework querying
- Legal principle lookup
- Rule derivation tracing
- Inference chain building
- Domain-specific helpers
- Integration with hypergraph system

Usage:
    from chainlex_api import ChainLex
    
    # Initialize
    chainlex = ChainLex()
    
    # Search functions
    results = chainlex.search("contract validity")
    
    # Get principles
    principles = chainlex.principles.by_domain("contract")
    
    # Find derived rules
    rules = chainlex.rules.derived_from("pacta-sunt-servanda")
    
    # Build inference chain
    chain = chainlex.inference.chain("pacta-sunt-servanda", "contract-valid?")
"""

import json
from pathlib import Path
from typing import List, Dict, Any, Optional, Union
from framework_index import FrameworkIndex


class PrinciplesAPI:
    """API for Level 1 principles"""
    
    def __init__(self, index: FrameworkIndex):
        self.index = index
    
    def all(self) -> List[Dict]:
        """Get all Level 1 principles"""
        return [
            {'name': name, **data}
            for name, data in self.index.principle_index.items()
        ]
    
    def by_domain(self, domain: str) -> List[Dict]:
        """Get principles applicable to a specific domain"""
        return self.index.find_principles_by_domain(domain)
    
    def get(self, name: str) -> Optional[Dict]:
        """Get a specific principle by name"""
        return self.index.principle_index.get(name)
    
    def search(self, query: str) -> List[Dict]:
        """Search principles by name or description"""
        results = []
        query_lower = query.lower()
        
        for name, data in self.index.principle_index.items():
            if query_lower in name.lower():
                results.append({'name': name, **data})
            elif query_lower in data.get('docstring', '').lower():
                results.append({'name': name, **data})
        
        return results


class RulesAPI:
    """API for Level 2+ jurisdiction-specific rules"""
    
    def __init__(self, index: FrameworkIndex):
        self.index = index
    
    def by_framework(self, framework_code: str) -> List[Dict]:
        """Get all rules in a specific framework"""
        framework = self.index.frameworks.get(framework_code)
        if not framework:
            return []
        
        return [
            func for func in framework.get('functions', [])
            if not func.get('is_principle')
        ]
    
    def by_domain(self, domain: str) -> List[Dict]:
        """Get all rules in a specific domain"""
        func_names = self.index.domain_index.get(domain, [])
        return [
            self.index.function_index[name]
            for name in func_names
        ]
    
    def derived_from(self, principle_name: str) -> List[Dict]:
        """Get all rules derived from a specific principle"""
        return self.index.find_derived_rules(principle_name)
    
    def search(self, query: str, domain: Optional[str] = None) -> List[Dict]:
        """Search rules by name or description"""
        return self.index.search_functions(query, domain)


class InferenceAPI:
    """API for inference chain operations"""
    
    def __init__(self, index: FrameworkIndex):
        self.index = index
    
    def chain(self, start: str, end: str) -> Optional[List[Dict]]:
        """Build inference chain from principle to rule"""
        return self.index.build_inference_chain(start, end)
    
    def confidence(self, chain: List[Dict], inference_types: Optional[List[str]] = None) -> float:
        """
        Compute confidence for an inference chain
        
        Args:
            chain: List of nodes in inference chain
            inference_types: List of inference types for each step
                            (deductive, inductive, abductive, analogical)
        
        Returns:
            Overall confidence (0.0-1.0)
        """
        if not chain:
            return 0.0
        
        # Default inference factors
        factors = {
            'deductive': 0.95,
            'inductive': 0.80,
            'abductive': 0.70,
            'analogical': 0.65
        }
        
        # Start with Level 1 principle confidence
        confidence = 1.0
        
        # Apply factors for each inference step
        if inference_types:
            for inf_type in inference_types:
                confidence *= factors.get(inf_type, 0.95)
        else:
            # Default to deductive
            confidence *= (0.95 ** (len(chain) - 1))
        
        return round(confidence, 4)
    
    def explain(self, chain: List[Dict]) -> str:
        """Generate human-readable explanation of inference chain"""
        if not chain:
            return "No inference chain found"
        
        explanation = []
        for i, node in enumerate(chain):
            level = node.get('level', 'unknown')
            name = node.get('node', node.get('name', 'unknown'))
            node_type = node.get('type', 'unknown')
            
            explanation.append(f"Level {level}: {name} ({node_type})")
            
            if i < len(chain) - 1:
                explanation.append("   ↓ (inference)")
        
        return "\n".join(explanation)


class FrameworksAPI:
    """API for framework-level operations"""
    
    def __init__(self, index: FrameworkIndex):
        self.index = index
    
    def list(self) -> List[Dict]:
        """List all available frameworks"""
        return [
            {
                'code': code,
                'name': fw['name'],
                'level': fw['level'],
                'domains': fw.get('domains', []),
                'function_count': fw['function_count']
            }
            for code, fw in self.index.frameworks.items()
        ]
    
    def get(self, code: str) -> Optional[Dict]:
        """Get detailed information about a framework"""
        return self.index.frameworks.get(code)
    
    def stats(self) -> Dict:
        """Get comprehensive statistics"""
        return self.index.get_framework_stats()


class ChainLex:
    """
    Main ChainLex API - Unified interface for legal framework access
    
    Usage:
        chainlex = ChainLex()
        
        # Access sub-APIs
        chainlex.principles.by_domain("contract")
        chainlex.rules.derived_from("pacta-sunt-servanda")
        chainlex.inference.chain("principle", "rule")
        chainlex.frameworks.list()
    """
    
    def __init__(self, base_path: str = ".", load_hypergraph: bool = False):
        """
        Initialize ChainLex API
        
        Args:
            base_path: Path to ChainLex repository root
            load_hypergraph: Whether to load hypergraph (requires NetworkX)
        """
        self.base_path = Path(base_path)
        self.index = FrameworkIndex(str(self.base_path))
        
        # Initialize sub-APIs
        self.principles = PrinciplesAPI(self.index)
        self.rules = RulesAPI(self.index)
        self.inference = InferenceAPI(self.index)
        self.frameworks = FrameworksAPI(self.index)
        
        # Optionally load hypergraph
        self.hypergraph = None
        if load_hypergraph:
            self._load_hypergraph()
    
    def _load_hypergraph(self):
        """Load the hypergraph for advanced queries"""
        try:
            from hypergraph.query_hypergraph import HypergraphQuery
            hypergraph_file = self.base_path / "hypergraph" / "scmlex_hypergraph.pkl"
            if hypergraph_file.exists():
                self.hypergraph = HypergraphQuery(str(hypergraph_file))
                print("✅ Loaded hypergraph")
        except Exception as e:
            print(f"⚠️  Could not load hypergraph: {e}")
    
    def search(self, query: str, domain: Optional[str] = None) -> Dict[str, List[Dict]]:
        """
        Universal search across all frameworks
        
        Args:
            query: Search query
            domain: Optional domain filter
        
        Returns:
            Dictionary with 'principles' and 'rules' keys
        """
        return {
            'principles': self.principles.search(query),
            'rules': self.rules.search(query, domain)
        }
    
    def stats(self) -> Dict:
        """Get comprehensive statistics"""
        return self.frameworks.stats()
    
    def quick_reference(self) -> str:
        """Get a quick reference guide"""
        stats = self.stats()
        
        ref = [
            "ChainLex Quick Reference",
            "=" * 70,
            "",
            "📚 Frameworks:",
        ]
        
        for code, fw in stats['frameworks'].items():
            ref.append(f"  {code:4s} - {fw['name']:35s} [{fw['function_count']:4d} functions]")
        
        ref.extend([
            "",
            "🎯 Domains:",
        ])
        
        for domain, domain_stats in stats['domains'].items():
            ref.append(f"  {domain:20s} - {domain_stats['function_count']:4d} functions")
        
        ref.extend([
            "",
            "🔍 Example Queries:",
            "  chainlex.search('contract')",
            "  chainlex.principles.by_domain('contract')",
            "  chainlex.rules.derived_from('pacta-sunt-servanda')",
            "  chainlex.inference.chain('principle', 'rule')",
            "",
            "=" * 70
        ])
        
        return "\n".join(ref)


# Convenience function for quick access
def create_api(base_path: str = ".", load_hypergraph: bool = False) -> ChainLex:
    """Create ChainLex API instance"""
    return ChainLex(base_path, load_hypergraph)


def main():
    """Demo of ChainLex API"""
    print("Initializing ChainLex API...")
    chainlex = ChainLex()
    
    print("\n" + chainlex.quick_reference())
    
    print("\n" + "="*70)
    print("Example 1: Search for contract-related items")
    print("="*70)
    results = chainlex.search("contract")
    print(f"\nFound {len(results['principles'])} principles and {len(results['rules'])} rules")
    print("\nFirst 3 rules:")
    for rule in results['rules'][:3]:
        print(f"  - {rule['framework']}:{rule['name']}")
    
    print("\n" + "="*70)
    print("Example 2: Get contract law principles")
    print("="*70)
    principles = chainlex.principles.by_domain("contract")
    print(f"\nFound {len(principles)} principles:")
    for p in principles[:5]:
        print(f"  - {p['name']}")
    
    print("\n" + "="*70)
    print("Example 3: Find rules derived from a principle")
    print("="*70)
    derived = chainlex.rules.derived_from("pacta-sunt-servanda")
    print(f"\nFound {len(derived)} derived rules:")
    for r in derived[:5]:
        print(f"  - {r['framework']}:{r['name']}")
    
    print("\n" + "="*70)
    print("Example 4: Build inference chain")
    print("="*70)
    chain = chainlex.inference.chain("pacta-sunt-servanda", "contract-valid?")
    if chain:
        print("\nInference chain:")
        print(chainlex.inference.explain(chain))
        conf = chainlex.inference.confidence(chain)
        print(f"\nConfidence: {conf}")
    else:
        print("No direct chain found")
    
    print("\n" + "="*70)


if __name__ == "__main__":
    main()
