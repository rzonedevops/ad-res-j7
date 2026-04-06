#!/usr/bin/env python3
"""
Verify Restored Legal Filings - Item by Item Comparison

This script verifies that all critical legal filings have been properly restored
by comparing file sizes and checking for key content markers.
"""

import os
import json
from pathlib import Path
from datetime import datetime

REPO_DIR = Path("/home/ubuntu/revstream1")
AUDIT_DIR = Path("/home/ubuntu/restoration_audit")

# Key content markers that should be present in comprehensive filings
CIPC_MARKERS = [
    "Companies Act",
    "Section 76",
    "Section 77",
    "Section 162",
    "R10",  # Financial amounts
    "Burden of Proof",
    "Evidence",
    "Peter Andrew Faucitt",
    "Rynette Farrar",
    "Bantjies"
]

POPIA_MARKERS = [
    "POPIA",
    "Personal Information",
    "Information Officer",
    "Section 14",
    "Section 19",
    "Identity Fraud",
    "Unauthorized Access",
    "Evidence"
]

NPA_MARKERS = [
    "Tax Fraud",
    "SARS",
    "Income Tax",
    "VAT",
    "R",  # Financial amounts
    "Evidence",
    "Criminal"
]

COMMERCIAL_MARKERS = [
    "Commercial Crime",
    "Fraud",
    "Theft",
    "Money Laundering",
    "R5.4",  # Stock theft
    "R10",  # Total amounts
    "Evidence"
]

def check_file_content(filepath, markers):
    """Check if file contains expected content markers."""
    try:
        with open(filepath, 'r') as f:
            content = f.read()
        
        found = []
        missing = []
        for marker in markers:
            if marker in content:
                found.append(marker)
            else:
                missing.append(marker)
        
        return {
            "size": len(content),
            "lines": content.count('\n'),
            "found_markers": found,
            "missing_markers": missing,
            "completeness": len(found) / len(markers) * 100 if markers else 100
        }
    except Exception as e:
        return {"error": str(e)}

def find_best_version(pattern, directory):
    """Find the most comprehensive version of a filing."""
    files = list(directory.glob(pattern))
    if not files:
        return None, None
    
    best_file = None
    best_size = 0
    
    for f in files:
        size = f.stat().st_size
        if size > best_size:
            best_size = size
            best_file = f
    
    return best_file, best_size

def verify_filing_category(category, patterns, markers, directories):
    """Verify all filings in a category."""
    results = {
        "category": category,
        "files": [],
        "best_version": None,
        "issues": []
    }
    
    all_files = []
    for directory in directories:
        for pattern in patterns:
            all_files.extend(directory.glob(pattern))
    
    # Sort by size (largest first)
    all_files.sort(key=lambda x: x.stat().st_size, reverse=True)
    
    for f in all_files[:10]:  # Check top 10 by size
        check = check_file_content(f, markers)
        check["path"] = str(f.relative_to(REPO_DIR))
        results["files"].append(check)
    
    if results["files"]:
        results["best_version"] = results["files"][0]
        
        # Check for issues
        best = results["files"][0]
        if best.get("completeness", 0) < 70:
            results["issues"].append(f"Best version only {best['completeness']:.0f}% complete")
        if best.get("size", 0) < 5000:
            results["issues"].append(f"Best version is small ({best['size']} bytes)")
    else:
        results["issues"].append("No files found for this category")
    
    return results

def main():
    print("="*70)
    print("LEGAL FILINGS VERIFICATION REPORT")
    print(f"Generated: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}")
    print("="*70)
    
    # Directories to search
    docs_dir = REPO_DIR / "docs"
    filings_dir = REPO_DIR / "docs" / "filings"
    regulatory_dir = REPO_DIR / "docs" / "filings" / "regulatory"
    criminal_dir = REPO_DIR / "docs" / "filings" / "criminal"
    civil_dir = REPO_DIR / "docs" / "filings" / "civil"
    
    directories = [docs_dir, filings_dir, regulatory_dir, criminal_dir, civil_dir]
    
    verification_results = {}
    
    # Verify CIPC filings
    print("\n[1/4] Verifying CIPC Filings...")
    cipc_results = verify_filing_category(
        "CIPC",
        ["*CIPC*.md", "*cipc*.md"],
        CIPC_MARKERS,
        directories
    )
    verification_results["CIPC"] = cipc_results
    print(f"  Found {len(cipc_results['files'])} files")
    if cipc_results["best_version"]:
        print(f"  Best: {cipc_results['best_version']['path']} ({cipc_results['best_version']['size']} bytes, {cipc_results['best_version']['completeness']:.0f}% complete)")
    
    # Verify POPIA filings
    print("\n[2/4] Verifying POPIA Filings...")
    popia_results = verify_filing_category(
        "POPIA",
        ["*POPIA*.md", "*popia*.md"],
        POPIA_MARKERS,
        directories
    )
    verification_results["POPIA"] = popia_results
    print(f"  Found {len(popia_results['files'])} files")
    if popia_results["best_version"]:
        print(f"  Best: {popia_results['best_version']['path']} ({popia_results['best_version']['size']} bytes, {popia_results['best_version']['completeness']:.0f}% complete)")
    
    # Verify NPA filings
    print("\n[3/4] Verifying NPA Tax Fraud Reports...")
    npa_results = verify_filing_category(
        "NPA",
        ["*NPA*.md", "*npa*.md", "*TAX_FRAUD*.md", "*tax_fraud*.md"],
        NPA_MARKERS,
        directories
    )
    verification_results["NPA"] = npa_results
    print(f"  Found {len(npa_results['files'])} files")
    if npa_results["best_version"]:
        print(f"  Best: {npa_results['best_version']['path']} ({npa_results['best_version']['size']} bytes, {npa_results['best_version']['completeness']:.0f}% complete)")
    
    # Verify Commercial Crime filings
    print("\n[4/4] Verifying Commercial Crime Submissions...")
    commercial_results = verify_filing_category(
        "Commercial Crime",
        ["*COMMERCIAL*.md", "*commercial*.md"],
        COMMERCIAL_MARKERS,
        directories
    )
    verification_results["Commercial Crime"] = commercial_results
    print(f"  Found {len(commercial_results['files'])} files")
    if commercial_results["best_version"]:
        print(f"  Best: {commercial_results['best_version']['path']} ({commercial_results['best_version']['size']} bytes, {commercial_results['best_version']['completeness']:.0f}% complete)")
    
    # Save verification results
    results_path = AUDIT_DIR / "verification_results.json"
    with open(results_path, 'w') as f:
        json.dump(verification_results, f, indent=2)
    
    # Print summary
    print("\n" + "="*70)
    print("VERIFICATION SUMMARY")
    print("="*70)
    
    all_issues = []
    for category, results in verification_results.items():
        if results["issues"]:
            all_issues.extend([f"{category}: {issue}" for issue in results["issues"]])
    
    if all_issues:
        print("\nISSUES FOUND:")
        for issue in all_issues:
            print(f"  - {issue}")
    else:
        print("\nNo issues found. All filings appear complete.")
    
    print(f"\nDetailed results saved to: {results_path}")
    
    return verification_results

if __name__ == "__main__":
    main()
