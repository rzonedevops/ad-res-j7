# Dependency Management Guide

## Python Standard Library vs Third-Party Packages

### Important Distinction

Python comes with a rich standard library that includes many commonly used modules. These modules should **NEVER** be installed via `pip` because they are already included with Python.

### Common Standard Library Modules

These modules are built-in and should be imported directly (not installed):

```python
# ✅ CORRECT - Import directly
import json
import os
import sys
import datetime
import re
import pathlib
import collections
import itertools
import functools
import typing
import logging
import unittest
import sqlite3
import csv
import xml
import html
import http
import urllib
import email
import socket
import threading
import subprocess
import argparse
import configparser
import tempfile
import shutil
import gzip
import zipfile
import hashlib
import base64
import uuid
```

```bash
# ❌ INCORRECT - Never do this
pip install json
pip install os
pip install sys
# These will fail or install incorrect packages!
```

### The JSON Module Specifically

**The `json` module is part of Python's standard library since Python 2.6.**

#### Correct Usage

```python
# In your Python code:
import json

data = {"key": "value"}
json_string = json.dumps(data)
parsed = json.loads(json_string)
```

#### Common Mistakes

```bash
# ❌ WRONG - Will cause errors
pip install json

# ❌ WRONG - In requirements.txt
json
json>=1.0.0

# ❌ WRONG - In GitHub Actions
- name: Install dependencies
  run: pip install json
```

### How to Identify Standard Library Modules

1. **Check Python Documentation**: Visit https://docs.python.org/3/library/
2. **Test Import Without Installation**:
   ```bash
   python3 -c "import json; print('Built-in')"
   ```
3. **Use `sys.builtin_module_names`**:
   ```python
   import sys
   print('json' in sys.builtin_module_names)
   ```

### Requirements File Best Practices

#### requirements.txt

```txt
# Core dependencies - Only third-party packages
torch>=2.1.0,<3.0.0
transformers>=4.30.0,<5.0.0
numpy>=1.24.0,<2.0.0
flask>=2.3.0,<3.0.0
pydantic>=2.0.0,<3.0.0

# ❌ DO NOT add standard library modules:
# json          <- WRONG
# os            <- WRONG
# datetime      <- WRONG
```

#### pyproject.toml

```toml
[project]
dependencies = [
    "torch>=2.1.0,<3.0.0",
    "numpy>=1.24.0,<2.0.0",
    # Only third-party packages here
    # Never add: "json", "os", "sys", etc.
]
```

### GitHub Actions Workflows

```yaml
- name: Install dependencies
  run: |
    python -m pip install --upgrade pip
    pip install -r requirements.txt  # ✅ Good
    # pip install json                # ❌ NEVER DO THIS
```

### Why This Matters

1. **Build Failures**: Installing standard library modules causes workflow failures
2. **Confusion**: There may be PyPI packages with similar names that are NOT the standard library
3. **Maintainability**: Following Python conventions makes code easier to maintain
4. **Best Practices**: Professional Python development requires understanding this distinction

### Error Messages to Watch For

If you see errors like:
```
ERROR: Could not find a version that satisfies the requirement json
ERROR: No matching distribution found for json
```

This means someone tried to install a standard library module via pip. **Remove it from your requirements file.**

### Validation

Run these commands to validate your dependencies:

```bash
# Check requirements files don't contain standard library modules
grep -E "^(json|os|sys|datetime|re)(\s|$)" requirements.txt

# Verify no broken dependencies
python -m pip check

# Test that standard library imports work
python -c "import json, os, sys, datetime, re; print('All standard imports work')"
```

### Quick Reference

| Module | Type | How to Use |
|--------|------|-----------|
| json | Standard Library | `import json` |
| os | Standard Library | `import os` |
| sys | Standard Library | `import sys` |
| numpy | Third-Party | `pip install numpy` |
| flask | Third-Party | `pip install flask` |
| torch | Third-Party | `pip install torch` |

### Additional Resources

- [Python Standard Library Documentation](https://docs.python.org/3/library/)
- [Python Package Index (PyPI)](https://pypi.org/)
- [pip Documentation](https://pip.pypa.io/)

### Testing Your Dependencies

Use the validation test suite in `tests/test_json_dependency_validation.py` to automatically check for this issue:

```bash
python tests/test_json_dependency_validation.py
```

## Conclusion

Always distinguish between:
- **Standard Library Modules**: Import directly, never install
- **Third-Party Packages**: Install via pip, then import

When in doubt, check the [Python Standard Library documentation](https://docs.python.org/3/library/).
