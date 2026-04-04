#!/bin/bash

################################################################################
# Comprehensive Cross-Reference Verification Script
# 
# This script runs all cross-reference validation systems to verify accuracy.
# Implements verification task from todo/JAX_DAN_RESPONSE_EXPANSION_PLAN.md:319
#
# Usage:
#   ./scripts/verify-all-cross-references.sh
#   ./scripts/verify-all-cross-references.sh --verbose
#
# Exit codes:
#   0 - All validations passed
#   1 - Critical errors found (requires attention)
################################################################################

set -e

VERBOSE=false
if [[ "$1" == "--verbose" ]]; then
    VERBOSE=true
fi

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$REPO_ROOT"

# Color codes for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Counters
TOTAL_TESTS=0
PASSED_TESTS=0
FAILED_TESTS=0
TOTAL_WARNINGS=0
TOTAL_ERRORS=0

echo "╔════════════════════════════════════════════════════════════════╗"
echo "║  COMPREHENSIVE CROSS-REFERENCE VERIFICATION                   ║"
echo "║  Repository: cogpy/ad-res-j7                                  ║"
echo "║  Task: Verify all cross-references are accurate               ║"
echo "╚════════════════════════════════════════════════════════════════╝"
echo ""

################################################################################
# Test 1: Automated Cross-Reference Checker (Core Revelations)
################################################################################
echo -e "${BLUE}[1/4] Running Automated Cross-Reference Checker...${NC}"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

TEMP_REPORT="/tmp/xref_validation_$(date +%s).json"

if python3 scripts/automated_cross_reference_checker.py --output "$TEMP_REPORT" > /tmp/test1_output.txt 2>&1; then
    PASSED_TESTS=$((PASSED_TESTS + 1))
    
    # Count warnings from output
    WARNINGS=$(grep -c "WARNING:" /tmp/test1_output.txt || true)
    TOTAL_WARNINGS=$((TOTAL_WARNINGS + WARNINGS))
    
    if [ $WARNINGS -eq 0 ]; then
        echo -e "${GREEN}✅ PASSED${NC} - Automated cross-reference checker (0 warnings)"
    else
        echo -e "${YELLOW}✅ PASSED WITH WARNINGS${NC} - Automated cross-reference checker ($WARNINGS warnings)"
        if [ "$VERBOSE" = true ]; then
            grep "WARNING:" /tmp/test1_output.txt || true
        fi
    fi
else
    FAILED_TESTS=$((FAILED_TESTS + 1))
    echo -e "${RED}❌ FAILED${NC} - Automated cross-reference checker"
    cat /tmp/test1_output.txt
fi
TOTAL_TESTS=$((TOTAL_TESTS + 1))
echo ""

################################################################################
# Test 2: Evidence Cross-Reference Accuracy Test Suite
################################################################################
echo -e "${BLUE}[2/4] Running Evidence Cross-Reference Accuracy Tests...${NC}"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

if node tests/evidence-cross-reference-accuracy.test.js > /tmp/test2_output.txt 2>&1; then
    if grep -q "ALL TESTS PASSED" /tmp/test2_output.txt; then
        PASSED_TESTS=$((PASSED_TESTS + 1))
        
        # Extract test count
        TEST_COUNT=$(grep "Total Tests:" /tmp/test2_output.txt | awk '{print $3}')
        echo -e "${GREEN}✅ PASSED${NC} - Evidence cross-reference accuracy ($TEST_COUNT/10 tests passed)"
    else
        FAILED_TESTS=$((FAILED_TESTS + 1))
        echo -e "${RED}❌ FAILED${NC} - Evidence cross-reference accuracy"
        cat /tmp/test2_output.txt
    fi
else
    FAILED_TESTS=$((FAILED_TESTS + 1))
    echo -e "${RED}❌ FAILED${NC} - Evidence cross-reference accuracy (execution error)"
    cat /tmp/test2_output.txt
fi
TOTAL_TESTS=$((TOTAL_TESTS + 1))
echo ""

################################################################################
# Test 3: Systematic Cross-Reference Validation
################################################################################
echo -e "${BLUE}[3/4] Running Systematic Cross-Reference Validation...${NC}"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

if python3 scripts/validate_cross_references.py > /tmp/test3_output.txt 2>&1; then
    if grep -q "All cross-references validated successfully" /tmp/test3_output.txt; then
        PASSED_TESTS=$((PASSED_TESTS + 1))
        echo -e "${GREEN}✅ PASSED${NC} - Systematic cross-reference validation"
    else
        FAILED_TESTS=$((FAILED_TESTS + 1))
        echo -e "${RED}❌ FAILED${NC} - Systematic cross-reference validation"
        cat /tmp/test3_output.txt
    fi
else
    FAILED_TESTS=$((FAILED_TESTS + 1))
    echo -e "${RED}❌ FAILED${NC} - Systematic cross-reference validation (execution error)"
    cat /tmp/test3_output.txt
fi
TOTAL_TESTS=$((TOTAL_TESTS + 1))
echo ""

################################################################################
# Test 4: Unit Tests for Automated Cross-Reference Checker
################################################################################
echo -e "${BLUE}[4/4] Running Cross-Reference Unit Tests...${NC}"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

if python3 tests/test_automated_cross_reference_checker.py > /tmp/test4_output.txt 2>&1; then
    if grep -q "OK" /tmp/test4_output.txt && ! grep -q "FAILED" /tmp/test4_output.txt; then
        PASSED_TESTS=$((PASSED_TESTS + 1))
        
        # Extract test count
        UNIT_TEST_COUNT=$(grep "Ran" /tmp/test4_output.txt | awk '{print $2}')
        echo -e "${GREEN}✅ PASSED${NC} - Cross-reference unit tests ($UNIT_TEST_COUNT tests)"
    else
        FAILED_TESTS=$((FAILED_TESTS + 1))
        echo -e "${RED}❌ FAILED${NC} - Cross-reference unit tests"
        cat /tmp/test4_output.txt
    fi
else
    FAILED_TESTS=$((FAILED_TESTS + 1))
    echo -e "${RED}❌ FAILED${NC} - Cross-reference unit tests (execution error)"
    cat /tmp/test4_output.txt
fi
TOTAL_TESTS=$((TOTAL_TESTS + 1))
echo ""

################################################################################
# Summary
################################################################################
echo "╔════════════════════════════════════════════════════════════════╗"
echo "║  VALIDATION SUMMARY                                            ║"
echo "╚════════════════════════════════════════════════════════════════╝"
echo ""
echo "Total Validation Suites: $TOTAL_TESTS"
echo -e "Passed:                  ${GREEN}$PASSED_TESTS${NC}"
echo -e "Failed:                  ${RED}$FAILED_TESTS${NC}"
echo -e "Warnings (non-critical): ${YELLOW}$TOTAL_WARNINGS${NC}"
echo -e "Errors (critical):       ${RED}$TOTAL_ERRORS${NC}"
echo ""

if [ $FAILED_TESTS -eq 0 ]; then
    if [ $TOTAL_WARNINGS -eq 0 ]; then
        echo -e "${GREEN}╔════════════════════════════════════════════════════════════════╗${NC}"
        echo -e "${GREEN}║  🎉 ALL CROSS-REFERENCES VERIFIED - 100% ACCURATE            ║${NC}"
        echo -e "${GREEN}╚════════════════════════════════════════════════════════════════╝${NC}"
    else
        echo -e "${YELLOW}╔════════════════════════════════════════════════════════════════╗${NC}"
        echo -e "${YELLOW}║  ✅ ALL VALIDATIONS PASSED ($TOTAL_WARNINGS non-critical warnings)        ║${NC}"
        echo -e "${YELLOW}╚════════════════════════════════════════════════════════════════╝${NC}"
        echo ""
        echo -e "${YELLOW}Note:${NC} Warnings are informational only and do not indicate errors."
        echo "      See CROSS_REFERENCE_VALIDATION_REPORT.md for details."
    fi
    echo ""
    echo "✅ Task completed: All cross-references are accurate"
    echo "📄 Full report: CROSS_REFERENCE_VALIDATION_REPORT.md"
    exit 0
else
    echo -e "${RED}╔════════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${RED}║  ❌ VALIDATION FAILED - CRITICAL ERRORS FOUND                 ║${NC}"
    echo -e "${RED}╚════════════════════════════════════════════════════════════════╝${NC}"
    echo ""
    echo "⚠️  Action required: Review errors above and fix critical issues"
    echo "📄 Full report: CROSS_REFERENCE_VALIDATION_REPORT.md"
    exit 1
fi
