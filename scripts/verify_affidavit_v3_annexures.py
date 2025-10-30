#!/usr/bin/env python3
"""
Verify all annexure references in affidavit v3 are correct and complete
Task: task_88 from structured-todo.json
Source: Repository_Status_and_Critical_Evidence_Collection.md, line 77
"""

import re
import os
import sys
from pathlib import Path
from collections import defaultdict

# Paths
SCRIPT_DIR = Path(__file__).parent.parent
AFFIDAVIT_PATH = SCRIPT_DIR / "jax-response/analysis-output/REVISED_Answering_Affidavit_Jax_TRACKED_CHANGES_v3.md"
ANNEXURES_DIR = SCRIPT_DIR / "evidence/annexures"

def extract_annexure_references(affidavit_path):
    """Extract all JF- annexure references from the affidavit"""
    if not affidavit_path.exists():
        print(f"ERROR: Affidavit not found at {affidavit_path}")
        return None
    
    with open(affidavit_path, 'r', encoding='utf-8') as f:
        content = f.read()
    
    # Find all JF- references
    pattern = r'JF-[A-Z0-9]+'
    
    # Count occurrences and track line numbers
    references = defaultdict(list)
    for line_num, line in enumerate(content.split('\n'), 1):
        found = re.findall(pattern, line)
        for ref in found:
            references[ref].append(line_num)
    
    return references

def check_annexure_files(annexures_dir, references):
    """Check which annexure files exist"""
    if not annexures_dir.exists():
        print(f"ERROR: Annexures directory not found at {annexures_dir}")
        return None, None
    
    existing = {}
    missing = []
    
    for ref in sorted(references.keys()):
        # Check for any file matching the reference
        pattern = f"{ref}*.md"
        matches = list(Path(annexures_dir).glob(pattern))
        
        if matches:
            existing[ref] = [str(m.name) for m in matches]
        else:
            missing.append(ref)
    
    return existing, missing

def main():
    print("=" * 80)
    print("AFFIDAVIT V3 ANNEXURE VERIFICATION")
    print("=" * 80)
    print(f"Affidavit: {AFFIDAVIT_PATH.name}")
    print(f"Annexures Dir: {ANNEXURES_DIR}")
    print()
    
    # Extract references
    references = extract_annexure_references(AFFIDAVIT_PATH)
    if references is None:
        return 1
    
    total_unique = len(references)
    total_occurrences = sum(len(lines) for lines in references.values())
    
    print(f"✅ Found {total_unique} unique annexure references")
    print(f"✅ Found {total_occurrences} total reference occurrences")
    print()
    
    # Check files
    existing, missing = check_annexure_files(ANNEXURES_DIR, references)
    if existing is None:
        return 1
    
    print(f"Existing files: {len(existing)}/{total_unique}")
    print(f"Missing files: {len(missing)}")
    print()
    
    # Report results
    if len(missing) == 0:
        print("=" * 80)
        print("✅ VERIFICATION COMPLETE")
        print("=" * 80)
        print("All annexure references have corresponding files")
        print()
        print("Top 5 Most Referenced Annexures:")
        sorted_refs = sorted(references.items(), key=lambda x: len(x[1]), reverse=True)
        for ref, lines in sorted_refs[:5]:
            print(f"  • {ref}: {len(lines)} occurrences")
        print()
        return 0
    else:
        print("=" * 80)
        print("❌ VERIFICATION FAILED")
        print("=" * 80)
        print(f"Missing {len(missing)} annexure files:")
        for ref in sorted(missing):
            occurrences = len(references[ref])
            print(f"  ❌ {ref} ({occurrences} references)")
        print()
        return 1

if __name__ == "__main__":
    sys.exit(main())
