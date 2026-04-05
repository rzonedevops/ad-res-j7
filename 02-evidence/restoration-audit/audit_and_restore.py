#!/usr/bin/env python3
"""
Audit and Restore Script for Commit c21d804

This script:
1. Identifies all files deleted in commit c21d804
2. Categorizes them by type (legal filings, evidence docs, etc.)
3. Restores critical files from the parent commit (a68a5de)
4. Generates a verification report
"""

import subprocess
import os
import json
from pathlib import Path
from datetime import datetime

REPO_DIR = Path("/home/ubuntu/revstream1")
AUDIT_DIR = Path("/home/ubuntu/restoration_audit")
COMMIT_HASH = "c21d804"
PARENT_COMMIT = "a68a5de"

TIMESTAMP = datetime.now().strftime("%Y-%m-%d %H:%M:%S")

def run_git(cmd, cwd=REPO_DIR):
    """Run a git command and return output."""
    result = subprocess.run(
        cmd, shell=True, cwd=cwd, capture_output=True, text=True
    )
    return result.stdout.strip(), result.stderr.strip()

def get_deleted_files():
    """Get all files deleted in the commit."""
    stdout, _ = run_git(f"git show {COMMIT_HASH} --name-status | grep '^D'")
    files = []
    for line in stdout.split('\n'):
        if line.startswith('D\t'):
            files.append(line[2:])
        elif line.startswith('D '):
            files.append(line[2:])
    return files

def categorize_files(files):
    """Categorize deleted files by type."""
    categories = {
        "legal_filings_cipc": [],
        "legal_filings_popia": [],
        "legal_filings_npa": [],
        "legal_filings_commercial": [],
        "legal_filings_criminal": [],
        "legal_filings_civil": [],
        "evidence_docs": [],
        "analysis_reports": [],
        "index_files": [],
        "other_docs": [],
        "entities": [],
        "events": [],
        "timelines": [],
        "skills": [],
        "other": []
    }
    
    for f in files:
        f_lower = f.lower()
        if 'cipc' in f_lower:
            categories["legal_filings_cipc"].append(f)
        elif 'popia' in f_lower:
            categories["legal_filings_popia"].append(f)
        elif 'npa' in f_lower or 'tax_fraud' in f_lower:
            categories["legal_filings_npa"].append(f)
        elif 'commercial' in f_lower:
            categories["legal_filings_commercial"].append(f)
        elif 'criminal' in f_lower:
            categories["legal_filings_criminal"].append(f)
        elif 'civil' in f_lower or 'affidavit' in f_lower:
            categories["legal_filings_civil"].append(f)
        elif 'evidence' in f_lower:
            categories["evidence_docs"].append(f)
        elif 'analysis' in f_lower or 'report' in f_lower or 'summary' in f_lower:
            categories["analysis_reports"].append(f)
        elif 'index' in f_lower or 'readme' in f_lower:
            categories["index_files"].append(f)
        elif f.startswith('docs/entities/'):
            categories["entities"].append(f)
        elif f.startswith('docs/events/'):
            categories["events"].append(f)
        elif f.startswith('docs/timelines/'):
            categories["timelines"].append(f)
        elif f.startswith('docs/skills/'):
            categories["skills"].append(f)
        elif f.startswith('docs/'):
            categories["other_docs"].append(f)
        else:
            categories["other"].append(f)
    
    return categories

def get_file_size_from_commit(filepath, commit):
    """Get file size from a specific commit."""
    stdout, stderr = run_git(f"git show {commit}:{filepath} 2>/dev/null | wc -c")
    try:
        return int(stdout)
    except:
        return 0

def restore_file(filepath, commit=PARENT_COMMIT):
    """Restore a file from a specific commit."""
    target_path = REPO_DIR / filepath
    target_path.parent.mkdir(parents=True, exist_ok=True)
    
    stdout, stderr = run_git(f"git show {commit}:{filepath}")
    if stderr and "does not exist" in stderr:
        return False, f"File not found in commit {commit}"
    
    with open(target_path, 'w') as f:
        f.write(stdout)
    
    return True, f"Restored to {target_path}"

def generate_audit_report(categories, deleted_files):
    """Generate a comprehensive audit report."""
    report = {
        "timestamp": TIMESTAMP,
        "commit_analyzed": COMMIT_HASH,
        "parent_commit": PARENT_COMMIT,
        "total_deleted_files": len(deleted_files),
        "categories": {},
        "critical_files": [],
        "restoration_candidates": []
    }
    
    # Count by category
    for cat, files in categories.items():
        report["categories"][cat] = {
            "count": len(files),
            "files": files
        }
    
    # Identify critical legal filings
    critical_patterns = [
        "CIPC_COMPLAINT_REFINED_2025_12",
        "POPIA_COMPLAINT_REFINED_2025_12",
        "NPA_TAX_FRAUD_REPORT_REFINED_2025_12",
        "COMMERCIAL_CRIME",
        "CRIMINAL_COMPLAINT",
        "EVIDENCE_ENHANCED",
        "COMPREHENSIVE"
    ]
    
    for f in deleted_files:
        for pattern in critical_patterns:
            if pattern in f:
                size = get_file_size_from_commit(f, PARENT_COMMIT)
                report["critical_files"].append({
                    "file": f,
                    "size_bytes": size,
                    "pattern_matched": pattern
                })
                if size > 5000:  # Files > 5KB are likely comprehensive
                    report["restoration_candidates"].append(f)
                break
    
    return report

def main():
    print("="*70)
    print("AUDIT AND RESTORATION SCRIPT")
    print(f"Analyzing commit: {COMMIT_HASH}")
    print(f"Parent commit: {PARENT_COMMIT}")
    print("="*70)
    
    # Get deleted files
    print("\n[1/4] Getting deleted files...")
    deleted_files = get_deleted_files()
    print(f"  Found {len(deleted_files)} deleted files")
    
    # Categorize
    print("\n[2/4] Categorizing files...")
    categories = categorize_files(deleted_files)
    for cat, files in categories.items():
        if files:
            print(f"  {cat}: {len(files)} files")
    
    # Generate audit report
    print("\n[3/4] Generating audit report...")
    report = generate_audit_report(categories, deleted_files)
    
    # Save report
    report_path = AUDIT_DIR / "audit_report.json"
    with open(report_path, 'w') as f:
        json.dump(report, f, indent=2)
    print(f"  Saved: {report_path}")
    
    # Print critical findings
    print("\n[4/4] Critical Findings:")
    print(f"  Total deleted: {report['total_deleted_files']}")
    print(f"  Critical files identified: {len(report['critical_files'])}")
    print(f"  Restoration candidates (>5KB): {len(report['restoration_candidates'])}")
    
    print("\n" + "="*70)
    print("CATEGORY SUMMARY")
    print("="*70)
    for cat, data in report["categories"].items():
        if data["count"] > 0:
            print(f"\n{cat.upper()}: {data['count']} files")
            for f in data["files"][:5]:
                print(f"  - {f}")
            if data["count"] > 5:
                print(f"  ... and {data['count'] - 5} more")
    
    print("\n" + "="*70)
    print("RESTORATION CANDIDATES (>5KB)")
    print("="*70)
    for f in report["restoration_candidates"][:20]:
        print(f"  - {f}")
    if len(report["restoration_candidates"]) > 20:
        print(f"  ... and {len(report['restoration_candidates']) - 20} more")
    
    return report

if __name__ == "__main__":
    report = main()
