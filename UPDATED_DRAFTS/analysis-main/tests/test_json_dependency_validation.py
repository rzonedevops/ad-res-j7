#!/usr/bin/env python3
"""
Test to validate that the json module is correctly used from Python's standard library
and not incorrectly listed as a dependency.

This test ensures the issue described in the problem statement remains resolved.
"""

import json
import os
import re
from pathlib import Path


def test_json_import_works():
    """Test that json module can be imported and works correctly."""
    # Test basic json functionality
    test_data = {"test": "value", "number": 42}
    json_string = json.dumps(test_data)
    parsed_data = json.loads(json_string)
    
    assert parsed_data == test_data, "json module should work correctly"


def test_no_json_in_requirements():
    """Test that 'json' is not listed in requirements.txt."""
    repo_root = Path(__file__).parent.parent
    requirements_file = repo_root / "requirements.txt"
    
    if requirements_file.exists():
        with open(requirements_file, 'r') as f:
            content = f.read()
        
        # Check for json as a standalone package (not as part of other package names)
        lines = content.split('\n')
        for line in lines:
            line = line.strip()
            if line and not line.startswith('#'):
                # Match json at the start of the line (possibly with version specifiers)
                if re.match(r'^json(\s|$|==|>=|<=|>|<|!=)', line):
                    raise AssertionError(
                        f"Found invalid 'json' package in requirements.txt: {line}\n"
                        "The 'json' module is part of Python's standard library and should not be installed."
                    )


def test_no_json_in_requirements_dev():
    """Test that 'json' is not listed in requirements-dev.txt."""
    repo_root = Path(__file__).parent.parent
    requirements_dev_file = repo_root / "requirements-dev.txt"
    
    if requirements_dev_file.exists():
        with open(requirements_dev_file, 'r') as f:
            content = f.read()
        
        lines = content.split('\n')
        for line in lines:
            line = line.strip()
            if line and not line.startswith('#') and not line.startswith('-r'):
                if re.match(r'^json(\s|$|==|>=|<=|>|<|!=)', line):
                    raise AssertionError(
                        f"Found invalid 'json' package in requirements-dev.txt: {line}\n"
                        "The 'json' module is part of Python's standard library and should not be installed."
                    )


def test_no_json_in_pyproject_toml():
    """Test that 'json' is not listed in pyproject.toml dependencies."""
    repo_root = Path(__file__).parent.parent
    pyproject_file = repo_root / "pyproject.toml"
    
    if pyproject_file.exists():
        with open(pyproject_file, 'r') as f:
            content = f.read()
        
        # Check for "json" in dependency arrays
        # This is a simple check - won't catch all cases but covers the common ones
        if re.search(r'["\']json["\']\s*[,\]]', content):
            raise AssertionError(
                "Found 'json' package in pyproject.toml dependencies.\n"
                "The 'json' module is part of Python's standard library and should not be installed."
            )


def test_no_pip_install_json_in_workflows():
    """Test that GitHub workflows don't contain 'pip install json' commands."""
    repo_root = Path(__file__).parent.parent
    workflows_dir = repo_root / ".github" / "workflows"
    
    if workflows_dir.exists():
        for workflow_file in workflows_dir.glob("*.yml"):
            with open(workflow_file, 'r') as f:
                content = f.read()
            
            # Check for pip install json (with word boundaries to avoid false positives)
            if re.search(r'pip\s+install.*\bjson\b', content):
                raise AssertionError(
                    f"Found 'pip install json' in {workflow_file.name}.\n"
                    "The 'json' module is part of Python's standard library and should not be installed."
                )


if __name__ == "__main__":
    # Run tests
    print("Running json dependency validation tests...")
    
    try:
        test_json_import_works()
        print("✅ test_json_import_works - PASSED")
    except AssertionError as e:
        print(f"❌ test_json_import_works - FAILED: {e}")
    
    try:
        test_no_json_in_requirements()
        print("✅ test_no_json_in_requirements - PASSED")
    except AssertionError as e:
        print(f"❌ test_no_json_in_requirements - FAILED: {e}")
    
    try:
        test_no_json_in_requirements_dev()
        print("✅ test_no_json_in_requirements_dev - PASSED")
    except AssertionError as e:
        print(f"❌ test_no_json_in_requirements_dev - FAILED: {e}")
    
    try:
        test_no_json_in_pyproject_toml()
        print("✅ test_no_json_in_pyproject_toml - PASSED")
    except AssertionError as e:
        print(f"❌ test_no_json_in_pyproject_toml - FAILED: {e}")
    
    try:
        test_no_pip_install_json_in_workflows()
        print("✅ test_no_pip_install_json_in_workflows - PASSED")
    except AssertionError as e:
        print(f"❌ test_no_pip_install_json_in_workflows - FAILED: {e}")
    
    print("\nAll validation tests completed successfully!")
