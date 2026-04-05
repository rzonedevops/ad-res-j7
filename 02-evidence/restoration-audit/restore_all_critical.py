#!/usr/bin/env python3
"""
Restore All Critical Files from Commit c21d804

This script restores all critical legal filings and evidence documents
that were deleted in commit c21d804 from the parent commit a68a5de.
"""

import subprocess
import os
import json
from pathlib import Path
from datetime import datetime

REPO_DIR = Path("/home/ubuntu/revstream1")
AUDIT_DIR = Path("/home/ubuntu/restoration_audit")
PARENT_COMMIT = "a68a5de"

# Critical files to restore - legal filings and key evidence
CRITICAL_FILES = [
    # CIPC Filings (most comprehensive versions)
    "docs/filings/CIPC_COMPLAINT_REFINED_2025_12_24.md",
    "docs/filings/CIPC_COMPLAINT_REFINED_2025_12_24_UPDATED_20251226.md",
    "docs/filings/regulatory/CIPC_COMPLAINT_COMPREHENSIVE_2025_12_28.md",
    "docs/filings/regulatory/CIPC_COMPLAINT_REFINED_2025_12_27.md",
    "docs/filings/CIPC_COMPLAINT_EVIDENCE_ENHANCED_20251214.md",
    "docs/filings/CIPC_COMPLAINT_EVIDENCE_ENHANCED_20251215_REFINED.md",
    "docs/filings/CIPC_COMPLAINT_EVIDENCE_ENHANCED_20251216.md",
    "docs/filings/CIPC_COMPLAINT_SF9_INTEGRATED_2025_12_09.md",
    
    # POPIA Filings
    "docs/filings/POPIA_COMPLAINT_REFINED_2025_12_24.md",
    "docs/filings/criminal/POPIA_COMPLAINT_COMPREHENSIVE_2025_12_28.md",
    "docs/filings/criminal/POPIA_COMPLAINT_REFINED_2025_12_27.md",
    "docs/filings/POPIA_COMPLAINT_EVIDENCE_ENHANCED_20251214.md",
    "docs/filings/POPIA_COMPLAINT_EVIDENCE_ENHANCED_20251215_REFINED.md",
    "docs/filings/POPIA_COMPLAINT_EVIDENCE_ENHANCED_20251216.md",
    
    # NPA Tax Fraud Reports
    "docs/filings/NPA_TAX_FRAUD_REPORT_REFINED_2025_12_24.md",
    "docs/filings/NPA_TAX_FRAUD_REPORT_REFINED_2025_12_24_UPDATED_20251226.md",
    "docs/filings/regulatory/NPA_TAX_FRAUD_REPORT_COMPREHENSIVE_2025_12_28.md",
    "docs/filings/regulatory/NPA_TAX_FRAUD_REPORT_REFINED_2025_12_27.md",
    "docs/filings/NPA_TAX_FRAUD_REPORT_EVIDENCE_ENHANCED_20251214.md",
    "docs/filings/NPA_TAX_FRAUD_REPORT_EVIDENCE_ENHANCED_20251215_REFINED.md",
    "docs/filings/NPA_TAX_FRAUD_REPORT_EVIDENCE_ENHANCED_20251216.md",
    
    # Commercial Crime
    "docs/filings/COMMERCIAL_CRIME_EVIDENCE_ENHANCED_20251214.md",
    "docs/filings/COMMERCIAL_CRIME_EVIDENCE_ENHANCED_20251215_REFINED.md",
    "docs/filings/COMMERCIAL_CRIME_EVIDENCE_ENHANCED_20251216.md",
    "docs/filings/COMMERCIAL_CRIME_SF9_INTEGRATED_2025_12_09.md",
    
    # Criminal Complaints
    "docs/filings/CRIMINAL_COMPLAINT_EVIDENCE_ENHANCED.md",
    "docs/filings/CRIMINAL_COMPLAINT_EVIDENCE_ENHANCED_UPDATED_2025_12_12.md",
    "docs/filings/criminal/criminal_complaint.md",
    
    # Civil/Answering Affidavits
    "docs/filings/ANSWERING_AFFIDAVIT_EVIDENCE_ENHANCED_20251214.md",
    "docs/filings/ANSWERING_AFFIDAVIT_EVIDENCE_ENHANCED_20251216.md",
    "docs/filings/ANSWERING_AFFIDAVIT_FINAL_EVIDENCE_ENHANCED_2025_12_09.md",
    "docs/filings/civil/answering_affidavit.md",
    
    # Key Evidence Documents
    "docs/CONSPIRACY_EVIDENCE_CROSS_REFERENCE_R18_75M_TIMELINE.md",
    "docs/EVIDENCE_INDEX_COMPREHENSIVE_2025_12_15.md",
    "docs/R18_75M_KETONI_PAYOUT_CENTRAL_MOTIVE_ANALYSIS.md",
    "docs/FFT_KETONI_INVESTMENT_TIMELINE_V48.md",
    "docs/FORENSIC_CAUSAL_MAP.md",
    "docs/FRAUD_EVIDENCE_REPORT_2019_ACCOUNTS.md",
    "docs/EMAIL_ARCHIVE_EVIDENCE_REPORT_2025-11-19.md",
    
    # Index and Navigation Files
    "docs/index.md",
    "docs/README.md",
    "docs/filings/index.md",
    "docs/filings/README.md",
    
    # Civil and Criminal Evidence Pages
    "docs/civil-evidence.md",
    "docs/civil-evidence.html",
    "docs/criminal-evidence.md",
    "docs/criminal-evidence.html",
    "docs/regulatory-evidence.md",
    "docs/regulatory-evidence.html",
    "docs/timeline.md",
    "docs/timeline.html",
]

def run_git(cmd, cwd=REPO_DIR):
    """Run a git command and return output."""
    result = subprocess.run(
        cmd, shell=True, cwd=cwd, capture_output=True, text=True
    )
    return result.stdout, result.stderr

def restore_file(filepath, commit=PARENT_COMMIT):
    """Restore a file from a specific commit."""
    target_path = REPO_DIR / filepath
    target_path.parent.mkdir(parents=True, exist_ok=True)
    
    stdout, stderr = run_git(f"git show {commit}:{filepath}")
    if stderr and ("does not exist" in stderr or "fatal:" in stderr):
        return False, f"File not found in commit {commit}"
    
    if stdout:
        with open(target_path, 'w') as f:
            f.write(stdout)
        return True, f"Restored ({len(stdout)} bytes)"
    return False, "Empty content"

def main():
    print("="*70)
    print("CRITICAL FILE RESTORATION")
    print(f"Restoring from parent commit: {PARENT_COMMIT}")
    print("="*70)
    
    results = {
        "restored": [],
        "failed": [],
        "skipped": []
    }
    
    for filepath in CRITICAL_FILES:
        target_path = REPO_DIR / filepath
        
        # Check if file already exists
        if target_path.exists():
            size = target_path.stat().st_size
            print(f"[EXISTS] {filepath} ({size} bytes)")
            results["skipped"].append({"file": filepath, "reason": "already exists", "size": size})
            continue
        
        # Restore from parent commit
        success, msg = restore_file(filepath)
        if success:
            size = (REPO_DIR / filepath).stat().st_size
            print(f"[RESTORED] {filepath} - {msg}")
            results["restored"].append({"file": filepath, "size": size})
        else:
            print(f"[FAILED] {filepath} - {msg}")
            results["failed"].append({"file": filepath, "reason": msg})
    
    # Save results
    results_path = AUDIT_DIR / "restoration_results.json"
    with open(results_path, 'w') as f:
        json.dump(results, f, indent=2)
    
    print("\n" + "="*70)
    print("RESTORATION SUMMARY")
    print("="*70)
    print(f"Restored: {len(results['restored'])} files")
    print(f"Already existed: {len(results['skipped'])} files")
    print(f"Failed: {len(results['failed'])} files")
    print(f"\nResults saved to: {results_path}")
    
    return results

if __name__ == "__main__":
    main()
