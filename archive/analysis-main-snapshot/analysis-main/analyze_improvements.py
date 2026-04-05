#!/usr/bin/env python3
"""
Super-Sleuth Intro-Spect & Hyper-Holmes Turbo-Solve Analysis
Comprehensive repository analysis for incremental improvements

Author: Manus AI - Gold Bar Challenge Mode
Date: October 18, 2025
"""

import os
import json
import subprocess
from pathlib import Path
from datetime import datetime
from typing import Dict, List, Any

class RepositoryAnalyzer:
    """Analyze repository for improvement opportunities."""
    
    def __init__(self, repo_path: str = "."):
        self.repo_path = Path(repo_path)
        self.findings = {
            "timestamp": datetime.now().isoformat(),
            "code_quality": [],
            "database_sync": [],
            "documentation": [],
            "testing": [],
            "dependencies": [],
            "security": [],
            "performance": []
        }
    
    def analyze_code_quality(self):
        """Analyze code quality issues."""
        print("🔍 Analyzing code quality...")
        
        # Check for Python files with potential issues
        py_files = list(self.repo_path.glob("*.py"))
        
        for py_file in py_files:
            try:
                # Check file size
                size = py_file.stat().st_size
                if size > 50000:  # Files larger than 50KB
                    self.findings["code_quality"].append({
                        "file": str(py_file.name),
                        "issue": "Large file size",
                        "size": size,
                        "suggestion": "Consider refactoring into smaller modules"
                    })
                
                # Check for common issues
                with open(py_file, 'r', encoding='utf-8', errors='ignore') as f:
                    content = f.read()
                    lines = content.split('\n')
                    
                    # Check for missing docstrings
                    if 'def ' in content or 'class ' in content:
                        if '"""' not in content[:500]:
                            self.findings["code_quality"].append({
                                "file": str(py_file.name),
                                "issue": "Missing module docstring",
                                "suggestion": "Add comprehensive module documentation"
                            })
                    
                    # Check for hardcoded credentials (basic check)
                    if any(x in content.lower() for x in ['password =', 'api_key =', 'secret =']):
                        if 'os.environ' not in content and 'getenv' not in content:
                            self.findings["security"].append({
                                "file": str(py_file.name),
                                "issue": "Potential hardcoded credentials",
                                "suggestion": "Use environment variables for sensitive data"
                            })
            
            except Exception as e:
                print(f"  Warning: Could not analyze {py_file.name}: {e}")
    
    def analyze_database_sync(self):
        """Analyze database synchronization setup."""
        print("🔍 Analyzing database synchronization...")
        
        # Check for sync scripts
        sync_scripts = list(self.repo_path.glob("sync_*.py"))
        
        if len(sync_scripts) > 5:
            self.findings["database_sync"].append({
                "issue": "Multiple sync scripts",
                "count": len(sync_scripts),
                "suggestion": "Consolidate sync scripts into unified sync manager"
            })
        
        # Check for migration system
        migration_dirs = [
            self.repo_path / "migrations",
            self.repo_path / "alembic",
            self.repo_path / "src" / "database_sync" / "migrations"
        ]
        
        has_migrations = any(d.exists() for d in migration_dirs)
        if not has_migrations:
            self.findings["database_sync"].append({
                "issue": "No migration directory found",
                "suggestion": "Implement proper database migration system"
            })
    
    def analyze_documentation(self):
        """Analyze documentation completeness."""
        print("🔍 Analyzing documentation...")
        
        # Check for key documentation files
        required_docs = {
            "README.md": "Main documentation",
            "CONTRIBUTING.md": "Contribution guidelines",
            "LICENSE": "License information",
            "CHANGELOG.md": "Version history"
        }
        
        for doc_file, description in required_docs.items():
            if not (self.repo_path / doc_file).exists():
                self.findings["documentation"].append({
                    "missing_file": doc_file,
                    "description": description,
                    "suggestion": f"Create {doc_file} for better project documentation"
                })
    
    def analyze_dependencies(self):
        """Analyze dependency management."""
        print("🔍 Analyzing dependencies...")
        
        req_file = self.repo_path / "requirements.txt"
        if req_file.exists():
            with open(req_file, 'r') as f:
                lines = f.readlines()
                
                unpinned = []
                for line in lines:
                    line = line.strip()
                    if line and not line.startswith('#'):
                        if '>=' in line and '<' not in line:
                            pkg = line.split('>=')[0].strip()
                            unpinned.append(pkg)
                
                if unpinned:
                    self.findings["dependencies"].append({
                        "issue": "Unpinned upper bounds",
                        "packages": unpinned[:5],  # Show first 5
                        "suggestion": "Add upper version bounds for stability"
                    })
    
    def analyze_testing(self):
        """Analyze testing infrastructure."""
        print("🔍 Analyzing testing setup...")
        
        test_dirs = [
            self.repo_path / "tests",
            self.repo_path / "test"
        ]
        
        has_tests = any(d.exists() and any(d.glob("test_*.py")) for d in test_dirs)
        
        if not has_tests:
            self.findings["testing"].append({
                "issue": "Limited test coverage",
                "suggestion": "Implement comprehensive test suite"
            })
        
        # Check for CI/CD
        ci_files = [
            self.repo_path / ".github" / "workflows",
            self.repo_path / ".gitlab-ci.yml",
            self.repo_path / ".circleci"
        ]
        
        has_ci = any(f.exists() for f in ci_files)
        if not has_ci:
            self.findings["testing"].append({
                "issue": "No CI/CD configuration",
                "suggestion": "Set up automated testing pipeline"
            })
    
    def analyze_performance(self):
        """Analyze potential performance improvements."""
        print("🔍 Analyzing performance opportunities...")
        
        # Check for large data files that could be optimized
        large_files = []
        for ext in ['.json', '.csv', '.txt']:
            for file in self.repo_path.glob(f"*{ext}"):
                size = file.stat().st_size
                if size > 1_000_000:  # > 1MB
                    large_files.append({
                        "file": file.name,
                        "size_mb": round(size / 1_000_000, 2)
                    })
        
        if large_files:
            self.findings["performance"].append({
                "issue": "Large data files in repository",
                "files": large_files[:5],
                "suggestion": "Consider using Git LFS or external storage"
            })
    
    def generate_report(self) -> Dict[str, Any]:
        """Generate comprehensive analysis report."""
        print("\n" + "="*80)
        print("SUPER-SLEUTH INTRO-SPECT ANALYSIS COMPLETE")
        print("="*80)
        
        total_issues = sum(len(v) for v in self.findings.values() if isinstance(v, list))
        print(f"\n📊 Total findings: {total_issues}")
        
        for category, issues in self.findings.items():
            if isinstance(issues, list) and issues:
                print(f"\n{category.upper().replace('_', ' ')}:")
                for issue in issues:
                    print(f"  • {issue.get('issue', issue.get('missing_file', 'Issue'))}")
        
        return self.findings
    
    def save_report(self, filename: str = "improvement_analysis.json"):
        """Save analysis report to file."""
        report_path = self.repo_path / filename
        with open(report_path, 'w') as f:
            json.dump(self.findings, f, indent=2)
        print(f"\n💾 Report saved to: {filename}")
        return report_path
    
    def run_analysis(self):
        """Run complete analysis."""
        print("🚀 Starting Super-Sleuth Intro-Spect Analysis...")
        print(f"📁 Repository: {self.repo_path.absolute()}")
        print()
        
        self.analyze_code_quality()
        self.analyze_database_sync()
        self.analyze_documentation()
        self.analyze_dependencies()
        self.analyze_testing()
        self.analyze_performance()
        
        report = self.generate_report()
        report_path = self.save_report()
        
        return report, report_path


if __name__ == "__main__":
    analyzer = RepositoryAnalyzer()
    report, report_path = analyzer.run_analysis()
    
    print("\n✅ Analysis complete! Ready for Hyper-Holmes Turbo-Solve mode!")
