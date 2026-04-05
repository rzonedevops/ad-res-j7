#!/usr/bin/env python3
"""
Super-Sleuth Intro-spect Mode & Hyper-Holmes Turbo-Solve Analyzer
Analyzes the repository to identify areas for incremental improvement
"""

import os
import json
import re
from pathlib import Path
from collections import defaultdict
from datetime import datetime

class SuperSleuthAnalyzer:
    def __init__(self, repo_path):
        self.repo_path = Path(repo_path)
        self.findings = {
            "code_quality": [],
            "database_sync": [],
            "documentation": [],
            "testing": [],
            "dependencies": [],
            "security": [],
            "performance": []
        }
        
    def analyze(self):
        """Run comprehensive analysis"""
        print("🔍 Super-Sleuth Intro-spect Mode Activated...")
        print("⚡ Hyper-Holmes Turbo-Solve Mode Engaged...\n")
        
        self.analyze_code_quality()
        self.analyze_database_sync()
        self.analyze_documentation()
        self.analyze_testing()
        self.analyze_dependencies()
        self.analyze_security()
        self.analyze_performance()
        
        return self.findings
    
    def analyze_code_quality(self):
        """Analyze code quality issues"""
        print("📊 Analyzing code quality...")
        
        # Check for duplicate sync scripts
        sync_scripts = list(self.repo_path.glob("sync_*.py"))
        if len(sync_scripts) > 5:
            self.findings["code_quality"].append({
                "issue": "Multiple sync scripts detected",
                "count": len(sync_scripts),
                "recommendation": "Consolidate into unified sync manager",
                "priority": "high",
                "files": [str(f.name) for f in sync_scripts]
            })
        
        # Check for outdated scripts
        test_files = list(self.repo_path.glob("test_*.py"))
        for test_file in test_files:
            if test_file.stat().st_size < 1000:  # Small test files
                self.findings["code_quality"].append({
                    "issue": f"Minimal test coverage in {test_file.name}",
                    "recommendation": "Expand test coverage",
                    "priority": "medium"
                })
    
    def analyze_database_sync(self):
        """Analyze database synchronization"""
        print("🗄️  Analyzing database synchronization...")
        
        # Check for schema files
        schema_files = list(self.repo_path.glob("*schema*.sql"))
        if len(schema_files) > 1:
            self.findings["database_sync"].append({
                "issue": "Multiple schema files found",
                "count": len(schema_files),
                "recommendation": "Create versioned migration system",
                "priority": "high",
                "files": [str(f.name) for f in schema_files]
            })
        
        # Check for sync utilities
        sync_dir = self.repo_path / "src" / "database_sync"
        if sync_dir.exists():
            sync_files = list(sync_dir.glob("*.py"))
            self.findings["database_sync"].append({
                "issue": "Database sync utilities present",
                "count": len(sync_files),
                "recommendation": "Ensure unified sync manager is used",
                "priority": "medium"
            })
    
    def analyze_documentation(self):
        """Analyze documentation completeness"""
        print("📚 Analyzing documentation...")
        
        md_files = list(self.repo_path.glob("*.md"))
        docs_dir = self.repo_path / "docs"
        
        if docs_dir.exists():
            docs_files = list(docs_dir.rglob("*.md"))
            self.findings["documentation"].append({
                "issue": "Documentation structure exists",
                "count": len(docs_files),
                "recommendation": "Ensure all features are documented",
                "priority": "low"
            })
        
        # Check for missing API documentation
        api_dir = self.repo_path / "src" / "api"
        if api_dir.exists():
            api_files = list(api_dir.glob("*.py"))
            api_docs = self.repo_path / "docs" / "technical" / "api"
            if not api_docs.exists():
                self.findings["documentation"].append({
                    "issue": "API documentation directory missing",
                    "recommendation": "Create API documentation",
                    "priority": "medium"
                })
    
    def analyze_testing(self):
        """Analyze testing infrastructure"""
        print("🧪 Analyzing testing infrastructure...")
        
        tests_dir = self.repo_path / "tests"
        if tests_dir.exists():
            test_files = list(tests_dir.rglob("test_*.py"))
            self.findings["testing"].append({
                "issue": "Test suite exists",
                "count": len(test_files),
                "recommendation": "Ensure comprehensive test coverage",
                "priority": "medium"
            })
    
    def analyze_dependencies(self):
        """Analyze dependencies"""
        print("📦 Analyzing dependencies...")
        
        req_file = self.repo_path / "requirements.txt"
        if req_file.exists():
            with open(req_file, 'r') as f:
                deps = [line.strip() for line in f if line.strip() and not line.startswith('#')]
            
            self.findings["dependencies"].append({
                "issue": "Dependencies defined",
                "count": len(deps),
                "recommendation": "Review and update dependency versions",
                "priority": "low"
            })
    
    def analyze_security(self):
        """Analyze security considerations"""
        print("🔒 Analyzing security...")
        
        # Check for hardcoded credentials (basic check)
        py_files = list(self.repo_path.rglob("*.py"))
        security_issues = []
        
        for py_file in py_files[:50]:  # Limit to avoid excessive processing
            try:
                content = py_file.read_text()
                if re.search(r'(password|secret|api_key)\s*=\s*["\'][^"\']+["\']', content, re.IGNORECASE):
                    security_issues.append(str(py_file.name))
            except:
                pass
        
        if security_issues:
            self.findings["security"].append({
                "issue": "Potential hardcoded credentials",
                "files": security_issues[:5],
                "recommendation": "Use environment variables for sensitive data",
                "priority": "high"
            })
    
    def analyze_performance(self):
        """Analyze performance optimization opportunities"""
        print("⚡ Analyzing performance...")
        
        # Check for large files
        large_files = []
        for f in self.repo_path.rglob("*"):
            if f.is_file() and f.stat().st_size > 10_000_000:  # > 10MB
                large_files.append({
                    "file": str(f.name),
                    "size_mb": round(f.stat().st_size / 1_000_000, 2)
                })
        
        if large_files:
            self.findings["performance"].append({
                "issue": "Large files detected",
                "files": large_files[:5],
                "recommendation": "Consider using Git LFS or optimization",
                "priority": "medium"
            })
    
    def generate_report(self):
        """Generate analysis report"""
        report = {
            "timestamp": datetime.now().isoformat(),
            "repository": str(self.repo_path),
            "findings": self.findings,
            "summary": self.generate_summary()
        }
        
        return report
    
    def generate_summary(self):
        """Generate summary of findings"""
        total_issues = sum(len(v) for v in self.findings.values())
        high_priority = sum(1 for category in self.findings.values() 
                          for finding in category 
                          if finding.get("priority") == "high")
        
        return {
            "total_findings": total_issues,
            "high_priority": high_priority,
            "categories_analyzed": len(self.findings)
        }

def main():
    analyzer = SuperSleuthAnalyzer("/home/ubuntu/analysis")
    findings = analyzer.analyze()
    report = analyzer.generate_report()
    
    # Save report
    output_file = "/home/ubuntu/analysis/super_sleuth_analysis_report.json"
    with open(output_file, 'w') as f:
        json.dump(report, f, indent=2)
    
    print(f"\n✅ Analysis complete! Report saved to: {output_file}")
    print(f"\n📊 Summary:")
    print(f"   Total findings: {report['summary']['total_findings']}")
    print(f"   High priority: {report['summary']['high_priority']}")
    print(f"   Categories: {report['summary']['categories_analyzed']}")
    
    return report

if __name__ == "__main__":
    main()
