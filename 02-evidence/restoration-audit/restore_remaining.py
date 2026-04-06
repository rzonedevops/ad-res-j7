#!/usr/bin/env python3
"""
Restore All Remaining Deleted Files from Commit c21d804
"""

import subprocess
import os
import json
from pathlib import Path

REPO_DIR = Path("/home/ubuntu/revstream1")
AUDIT_DIR = Path("/home/ubuntu/restoration_audit")
PARENT_COMMIT = "a68a5de"

BINARY_EXTENSIONS = {'.png', '.jpg', '.jpeg', '.gif', '.pdf', '.bin', '.ico', 
                     '.woff', '.woff2', '.ttf', '.eot', '.svg', '.webp'}

def run_git(cmd, cwd=REPO_DIR, binary=False):
    """Run a git command and return output."""
    result = subprocess.run(
        cmd, shell=True, cwd=cwd, capture_output=True, text=not binary
    )
    return result.stdout, result.stderr

def get_all_deleted_files():
    """Get all files deleted in c21d804."""
    stdout, _ = run_git("git show c21d804 --name-status | grep '^D'")
    files = []
    for line in stdout.split('\n'):
        if line.startswith('D\t'):
            files.append(line[2:])
        elif line.startswith('D '):
            parts = line.split()
            if len(parts) >= 2:
                files.append(parts[1])
    return files

def is_binary_file(filepath):
    """Check if file is binary based on extension."""
    return Path(filepath).suffix.lower() in BINARY_EXTENSIONS

def restore_file(filepath, commit=PARENT_COMMIT):
    """Restore a file from a specific commit."""
    target_path = REPO_DIR / filepath
    
    # Skip if already exists
    if target_path.exists():
        return "exists", target_path.stat().st_size
    
    target_path.parent.mkdir(parents=True, exist_ok=True)
    
    # Handle binary files
    if is_binary_file(filepath):
        stdout, stderr = run_git(f"git show {commit}:{filepath}", binary=True)
        if stderr:
            stderr_str = stderr.decode('utf-8', errors='ignore') if isinstance(stderr, bytes) else stderr
            if "does not exist" in stderr_str or "fatal:" in stderr_str:
                return "not_found", 0
        if stdout:
            with open(target_path, 'wb') as f:
                f.write(stdout)
            return "restored", len(stdout)
        return "empty", 0
    
    # Handle text files
    try:
        stdout, stderr = run_git(f"git show {commit}:{filepath}")
        if stderr and ("does not exist" in stderr or "fatal:" in stderr):
            return "not_found", 0
        if stdout:
            with open(target_path, 'w') as f:
                f.write(stdout)
            return "restored", len(stdout)
    except UnicodeDecodeError:
        # Fallback to binary mode
        stdout, stderr = run_git(f"git show {commit}:{filepath}", binary=True)
        if stderr:
            stderr_str = stderr.decode('utf-8', errors='ignore') if isinstance(stderr, bytes) else stderr
            if "does not exist" in stderr_str or "fatal:" in stderr_str:
                return "not_found", 0
        if stdout:
            with open(target_path, 'wb') as f:
                f.write(stdout)
            return "restored", len(stdout)
    
    return "empty", 0

def main():
    print("="*70)
    print("RESTORING ALL REMAINING DELETED FILES")
    print("="*70)
    
    deleted_files = get_all_deleted_files()
    print(f"Total deleted files to process: {len(deleted_files)}")
    
    results = {
        "restored": [],
        "exists": [],
        "not_found": [],
        "empty": [],
        "errors": []
    }
    
    for i, filepath in enumerate(deleted_files):
        try:
            status, size = restore_file(filepath)
            results[status].append({"file": filepath, "size": size})
        except Exception as e:
            results["errors"].append({"file": filepath, "error": str(e)})
        
        if (i + 1) % 50 == 0:
            print(f"  Processed {i + 1}/{len(deleted_files)} files...")
    
    # Save results
    results_path = AUDIT_DIR / "full_restoration_results.json"
    with open(results_path, 'w') as f:
        json.dump(results, f, indent=2)
    
    print("\n" + "="*70)
    print("FULL RESTORATION SUMMARY")
    print("="*70)
    print(f"Restored: {len(results['restored'])} files")
    print(f"Already existed: {len(results['exists'])} files")
    print(f"Not found in parent: {len(results['not_found'])} files")
    print(f"Empty content: {len(results['empty'])} files")
    print(f"Errors: {len(results['errors'])} files")
    
    # Calculate total restored bytes
    total_bytes = sum(f['size'] for f in results['restored'])
    print(f"\nTotal data restored: {total_bytes:,} bytes ({total_bytes/1024/1024:.2f} MB)")
    
    return results

if __name__ == "__main__":
    main()
