# Scripts Directory

This directory contains automation scripts for maintaining the ad-res-j7 repository.

## Automated Cross-Reference Checking

### `automated_cross_reference_checker.py` ⭐ **NEW**

Automated system that validates all evidence and analysis documents properly link to the core revelations:
1. Dan & Kay Shopify platform was paid by Dan & Jax UK company RegimA Zone Ltd
2. RWD ZA has no independent revenue stream of its own

**Usage:**
```bash
# Basic validation
python3 scripts/automated_cross_reference_checker.py

# Verbose mode with detailed output
python3 scripts/automated_cross_reference_checker.py --verbose

# Generate JSON report
python3 scripts/automated_cross_reference_checker.py --output cross_reference_validation_report.json

# NPM scripts
npm run test:automated-cross-reference
npm run validate-cross-references
```

**Features:**
- Tracks 4 core revelations across all documents
- Validates 8 critical files for proper cross-referencing
- Scans 7 major directories for revelation references
- Generates comprehensive JSON and console reports
- Provides coverage metrics and gap analysis
- Integration with CI/CD pipelines

**Core Revelations Tracked:**
1. **Shopify Platform Payment** - RegimA Zone Ltd (UK) owned and paid for platform
2. **RWD No Revenue** - RWD ZA has no independent revenue stream
3. **Platform Cost Non-payment** - RWD never compensated platform owner
4. **Unjust Enrichment** - R2.94M-R6.88M from platform use without compensation

**Output:**
- ✅ Complete cross-references found
- ⚠️  Missing references in non-critical files
- ❌ Critical validation errors
- Coverage percentages by directory
- Detailed JSON report with document lists

**Documentation:** See `../docs/AUTOMATED_CROSS_REFERENCE_SYSTEM.md`

## Cross-Reference Validation

### `validate_cross_references.py`
Validates existing cross-reference structure in the systematic cross-referencing implementation.

**Usage:**
```bash
python3 scripts/validate_cross_references.py
```

**Features:**
- Validates response matrix integrity
- Checks cross-reference index structure
- Validates AD paragraph files
- Verifies evidence cross-references
- Comprehensive error and warning reporting

## JSON Validation

### `validate_json.py`
Validates all JSON files in the repository for proper formatting and parseability.

**Usage:**
```bash
# Validate all JSON files in the repository
python3 scripts/validate_json.py

# Validate JSON files in a specific directory
python3 scripts/validate_json.py /path/to/directory
```

**Features:**
- Validates JSON syntax and parseability
- Provides detailed error messages for invalid files
- Returns appropriate exit codes for CI/CD integration
- Processes all JSON files recursively

**Output:**
- ✓ Valid JSON files
- ✗ Invalid JSON files with error details
- Summary statistics

## Requirements

- Python 3.x
- Standard library only (no external dependencies)

## Exit Codes

- `0`: All JSON files are valid
- `1`: One or more JSON files are invalid

## Integration

This script can be integrated into:
- Pre-commit hooks
- GitHub Actions workflows
- Automated testing pipelines
- Manual quality assurance processes

## Related Documentation

See `../JSON_VALIDATION_DOCUMENTATION.md` for comprehensive documentation on JSON validation processes and best practices.