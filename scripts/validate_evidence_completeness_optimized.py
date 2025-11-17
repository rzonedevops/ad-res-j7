#!/usr/bin/env python3
"""
Optimized Evidence Completeness Validation Script
Refactored to use common utilities for better performance
"""

import sys
from pathlib import Path
from typing import Dict, List, Any
from datetime import datetime

# Add lib to path
sys.path.insert(0, str(Path(__file__).parent.parent))

from lib.python_utils import (
    read_json_file,
    write_json_file,
    Timer,
    SimpleCache,
    timing_decorator,
    format_file_size
)


class OptimizedEvidenceValidator:
    """
    Optimized evidence completeness validator with caching and performance tracking
    """
    
    def __init__(self, repo_root: str = None):
        if repo_root is None:
            repo_root = Path(__file__).parent.parent
        self.repo_root = Path(repo_root)
        self.errors = []
        self.warnings = []
        self.passed = []
        
        # Initialize cache (5 minute TTL)
        self.evidence_cache = SimpleCache(max_size=500, ttl=300)
        
        # Core revelation
        self.core_revelation = {
            "key_fact": "Dan & Kay Shopify platform paid by RegimA Zone Ltd (UK company)",
            "critical_implication": "RWD ZA has no independent revenue stream",
            "evidence_requirement": "All financial evidence must demonstrate this payment flow"
        }
        
        # Load evidence categories
        self.evidence_categories = self._load_evidence_categories()
        
        # Completeness thresholds
        self.completeness_thresholds = {
            "phase1_critical": 0.80,
            "phase2_high_priority": 0.60,
            "overall": 0.70,
            "revenue_stream": 1.00
        }
        
        # Performance metrics
        self.metrics = {}
    
    def _load_evidence_categories(self) -> Dict[str, List[str]]:
        """Load evidence categories from JSON or use defaults"""
        categories_file = self.repo_root / 'lib' / 'evidence-categories.json'
        
        # Check cache first
        cached = self.evidence_cache.get('categories')
        if cached:
            return cached
        
        default_categories = {
            "phase1_critical": [
                "JF-RP1", "JF-RP2", "JF-DLA1", "JF-DLA2", "JF-DLA3",
                "JF-PA1", "JF-PA2", "JF-PA3", "JF-PA4", "JF-BS1",
                "JF5-DRAFT", "JF5-FINAL", "JF5-COMPARISON",
                "JF-UKTAX1", "JF-CHESNO1", "JF-CHESNO2", "JF-CHESNO3", "JF-CHESNO4",
                "JF-RESTORE1", "JF-RESTORE2", "JF-RESTORE3", "JF-RESTORE4"
            ],
            "phase2_high_priority": [
                "JF-SAL1", "JF-EAL1", "JF-FSL1", "JF-CORR1", "JF-ITS1",
                "JF-HIST1", "JF-HIST2", "JF-HIST3",
                "JF-RF1", "JF-RF2", "JF-RF3",
                "JF-EX1", "JF-EX2", "JF-EX3", "JF-EX4"
            ],
            "revenue_stream_evidence": [
                "SHOPIFY_PAYMENT_RECORDS",
                "REGIMA_ZONE_LTD_UK_COMPANY_DOCS",
                "RWD_ZA_REVENUE_ANALYSIS",
                "DAN_KAY_PLATFORM_EVIDENCE",
                "UK_TO_SA_PAYMENT_FLOWS"
            ]
        }
        
        categories = read_json_file(str(categories_file), default_categories)
        self.evidence_cache.set('categories', categories)
        return categories
    
    def validate_all_evidence(self) -> Dict[str, Any]:
        """Run complete evidence validation with performance tracking"""
        timer = Timer('Evidence Validation')
        
        print("=" * 80)
        print("OPTIMIZED EVIDENCE COMPLETENESS VALIDATION")
        print("=" * 80)
        print(f"\nCore Revelation: {self.core_revelation['key_fact']}")
        print(f"Critical Implication: {self.core_revelation['critical_implication']}\n")
        print("=" * 80)
        print()
        
        results = {
            "validation_timestamp": datetime.now().isoformat(),
            "core_revelation": self.core_revelation,
            "completeness_by_phase": {},
            "revenue_stream_linkage": {},
            "overall_completeness": 0.0,
            "passed_threshold": False,
            "recommendations": [],
            "performance_metrics": {}
        }
        
        # Validate Phase 1 Critical Evidence
        phase1_timer = Timer('Phase 1 Validation')
        print("📋 Phase 1: Critical Evidence (Must-Do)")
        print("-" * 80)
        results['completeness_by_phase']['phase1_critical'] = self._validate_evidence_phase('phase1_critical')
        results['performance_metrics']['phase1_time'] = phase1_timer.elapsed()
        
        # Validate Phase 2 High Priority Evidence
        phase2_timer = Timer('Phase 2 Validation')
        print("\n📋 Phase 2: High Priority Evidence (Should-Do)")
        print("-" * 80)
        results['completeness_by_phase']['phase2_high_priority'] = self._validate_evidence_phase('phase2_high_priority')
        results['performance_metrics']['phase2_time'] = phase2_timer.elapsed()
        
        # Validate Revenue Stream Evidence
        revenue_timer = Timer('Revenue Stream Validation')
        print("\n💰 Revenue Stream Evidence (Core Revelation)")
        print("-" * 80)
        results['revenue_stream_linkage'] = self._validate_revenue_stream_evidence()
        results['performance_metrics']['revenue_time'] = revenue_timer.elapsed()
        
        # Calculate overall completeness
        total_evidence = (
            len(self.evidence_categories['phase1_critical']) +
            len(self.evidence_categories['phase2_high_priority'])
        )
        total_found = (
            results['completeness_by_phase']['phase1_critical']['found'] +
            results['completeness_by_phase']['phase2_high_priority']['found']
        )
        results['overall_completeness'] = total_found / total_evidence if total_evidence > 0 else 0.0
        results['passed_threshold'] = results['overall_completeness'] >= self.completeness_thresholds['overall']
        
        # Generate recommendations
        results['recommendations'] = self._generate_recommendations(results)
        
        # Print summary
        self._print_validation_summary(results)
        
        # Add total time
        results['performance_metrics']['total_time'] = timer.elapsed()
        
        # Output performance metrics
        print("\n⚡ Performance Metrics:")
        print(f"  Phase 1: {results['performance_metrics']['phase1_time']:.2f}s")
        print(f"  Phase 2: {results['performance_metrics']['phase2_time']:.2f}s")
        print(f"  Revenue Stream: {results['performance_metrics']['revenue_time']:.2f}s")
        print(f"  Total: {results['performance_metrics']['total_time']:.2f}s")
        print(f"  Cache size: {self.evidence_cache.size()}")
        
        timer.end()
        
        # Save results
        output_file = self.repo_root / 'evidence_completeness_validation_report.json'
        if write_json_file(str(output_file), results):
            print(f"\n✅ Report saved to: {output_file}")
        
        return results
    
    @timing_decorator
    def _validate_evidence_phase(self, phase_key: str) -> Dict[str, Any]:
        """Validate evidence completeness for a specific phase"""
        evidence_codes = self.evidence_categories[phase_key]
        found_evidence = []
        missing_evidence = []
        
        for code in evidence_codes:
            # Check cache first
            cache_key = f'evidence:{code}'
            evidence_files = self.evidence_cache.get(cache_key)
            
            if evidence_files is None:
                evidence_files = self._find_evidence_by_code(code)
                self.evidence_cache.set(cache_key, evidence_files)
            
            if len(evidence_files) > 0:
                found_evidence.append(code)
                self.passed.append({'code': code, 'files': evidence_files, 'phase': phase_key})
                
                linkage_score = self._check_revenue_stream_linkage(evidence_files)
                linkage_indicator = "🔗" if linkage_score > 0 else "⚪"
                
                print(f"  ✅ FOUND {linkage_indicator} {code}: {len(evidence_files)} file(s)")
            else:
                missing_evidence.append(code)
                self.errors.append({'code': code, 'phase': phase_key, 'error': 'No evidence files found'})
                print(f"  ❌ MISSING {code}")
        
        completeness_rate = len(found_evidence) / len(evidence_codes) if len(evidence_codes) > 0 else 0.0
        threshold = self.completeness_thresholds.get(phase_key, 0.70)
        meets_threshold = completeness_rate >= threshold
        
        print(f"\n  Completeness: {completeness_rate*100:.1f}% ({len(found_evidence)}/{len(evidence_codes)})")
        print(f"  Threshold: {threshold*100:.1f}% - {'✅ PASS' if meets_threshold else '❌ FAIL'}")
        
        return {
            'total': len(evidence_codes),
            'found': len(found_evidence),
            'missing': len(missing_evidence),
            'completeness_rate': completeness_rate,
            'meets_threshold': meets_threshold,
            'missing_codes': missing_evidence
        }
    
    def _validate_revenue_stream_evidence(self) -> Dict[str, Any]:
        """Validate evidence linking to core revelation"""
        evidence_searches = {
            'shopifyPaymentRecords': ['shopify', 'payment'],
            'regimaZoneLtdUk': ['regima', 'zone', 'ltd'],
            'rwdZaRevenueAnalysis': ['rwd', 'revenue', 'analysis'],
            'danKayPlatform': ['dan', 'kay', 'platform'],
            'ukSaPaymentFlows': ['uk', 'sa', 'payment', 'flow']
        }
        
        revenue_evidence = {}
        
        for category, keywords in evidence_searches.items():
            files = self._search_files(keywords)
            revenue_evidence[category] = {
                'found': len(files) > 0,
                'files': files
            }
            
            status = "✅" if len(files) > 0 else "❌"
            print(f"  {status} {category}: {len(files)} file(s)")
            if len(files) > 0 and len(files) <= 3:
                for file in files:
                    print(f"      - {file}")
        
        total_categories = len(revenue_evidence)
        found_categories = sum(1 for v in revenue_evidence.values() if v['found'])
        completeness = found_categories / total_categories if total_categories > 0 else 0.0
        
        print(f"\n  Revenue Stream Completeness: {completeness*100:.1f}%")
        
        return {
            'evidence': revenue_evidence,
            'completeness': completeness,
            'meets_threshold': completeness >= self.completeness_thresholds['revenue_stream']
        }
    
    def _find_evidence_by_code(self, code: str) -> List[str]:
        """Find evidence files by code"""
        search_dirs = ['evidence', 'ANNEXURES', 'docs/legal']
        files = []
        
        for dir_name in search_dirs:
            dir_path = self.repo_root / dir_name
            if dir_path.exists():
                found = self._search_directory_for_code(dir_path, code)
                files.extend(found)
        
        return files
    
    def _search_directory_for_code(self, dir_path: Path, code: str) -> List[str]:
        """Recursively search directory for code"""
        files = []
        try:
            for item in dir_path.rglob('*'):
                if item.is_file():
                    if code.upper() in item.name.upper():
                        files.append(str(item))
        except PermissionError:
            pass
        
        return files
    
    def _search_files(self, keywords: List[str]) -> List[str]:
        """Search for files matching keywords"""
        cache_key = f"search:{':'.join(keywords)}"
        cached = self.evidence_cache.get(cache_key)
        if cached:
            return cached
        
        search_dirs = ['evidence', 'ANNEXURES', 'docs/legal']
        files = []
        
        for dir_name in search_dirs:
            dir_path = self.repo_root / dir_name
            if dir_path.exists():
                found = self._search_directory_for_keywords(dir_path, keywords)
                files.extend(found)
        
        self.evidence_cache.set(cache_key, files)
        return files
    
    def _search_directory_for_keywords(self, dir_path: Path, keywords: List[str]) -> List[str]:
        """Search directory for keywords"""
        files = []
        try:
            for item in dir_path.rglob('*'):
                if item.is_file():
                    name_lower = item.name.lower()
                    if any(kw.lower() in name_lower for kw in keywords):
                        files.append(str(item))
        except PermissionError:
            pass
        
        return files
    
    def _check_revenue_stream_linkage(self, evidence_files: List[str]) -> int:
        """Check linkage to revenue stream"""
        revenue_keywords = ['shopify', 'regima', 'zone', 'uk', 'payment']
        linkage_score = 0
        
        for file in evidence_files:
            name_lower = file.lower()
            for keyword in revenue_keywords:
                if keyword in name_lower:
                    linkage_score += 1
        
        return linkage_score
    
    def _generate_recommendations(self, results: Dict[str, Any]) -> List[Dict[str, Any]]:
        """Generate recommendations based on results"""
        recommendations = []
        
        for phase, data in results['completeness_by_phase'].items():
            if not data['meets_threshold']:
                recommendations.append({
                    'priority': 'high' if 'critical' in phase else 'medium',
                    'phase': phase,
                    'message': f"{phase} is below threshold ({data['completeness_rate']*100:.1f}%). Missing {data['missing']} items.",
                    'missing_codes': data['missing_codes']
                })
        
        if not results['revenue_stream_linkage']['meets_threshold']:
            recommendations.append({
                'priority': 'critical',
                'phase': 'revenue_stream',
                'message': 'Revenue stream evidence incomplete. Critical for proving core revelation.',
                'completeness': results['revenue_stream_linkage']['completeness']
            })
        
        return recommendations
    
    def _print_validation_summary(self, results: Dict[str, Any]):
        """Print validation summary"""
        print("\n" + "=" * 80)
        print("VALIDATION SUMMARY")
        print("=" * 80)
        print(f"Overall Completeness: {results['overall_completeness']*100:.1f}%")
        print(f"Threshold: {self.completeness_thresholds['overall']*100:.1f}%")
        print(f"Status: {'✅ PASS' if results['passed_threshold'] else '❌ FAIL'}")
        
        if results['recommendations']:
            print("\n📌 Recommendations:")
            for rec in results['recommendations']:
                priority = rec['priority'].upper()
                print(f"  [{priority}] {rec['message']}")
        
        print("\n" + "=" * 80)


def main():
    """Main entry point"""
    validator = OptimizedEvidenceValidator()
    results = validator.validate_all_evidence()
    
    sys.exit(0 if results['passed_threshold'] else 1)


if __name__ == '__main__':
    main()
