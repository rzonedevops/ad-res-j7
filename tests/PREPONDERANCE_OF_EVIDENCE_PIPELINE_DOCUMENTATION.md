# Preponderance of Evidence Testing Pipeline Documentation

## Overview

This document describes the automated testing pipeline for the **preponderance of evidence** assessment framework, implementing task_25 from feature_33 (para_22).

**Source:** `todo/optimal-strategies-burden-of-proof.md` (line 10)  
**Standard:** Civil - Balance of Probabilities (>50% threshold)  
**Requirement:** Preponderance of evidence assessment framework

## Purpose

The preponderance of evidence testing pipeline provides comprehensive automated validation of the civil standard "Balance of Probabilities" used in legal cases where Dan & Jax must prove guilt of other agents (Peter, Rynette, Bantjies, etc.) to a standard of "more likely than not" (>50% likelihood).

## Architecture

### Test File
- **Location:** `tests/preponderance-of-evidence-pipeline.test.js`
- **Type:** Automated test pipeline with 7 phases
- **Framework:** Node.js with custom assertion framework
- **Integration:** Works with existing burden of proof framework

### Key Components

1. **PreponderanceOfEvidencePipeline Class**
   - Main testing orchestrator
   - Manages test execution and reporting
   - Tracks results across all phases

2. **Test Phases** (13 test suites across 7 phases)
   - Phase 1: Framework Validation (2 suites)
   - Phase 2: Evidence Weighting Pipeline (2 suites)
   - Phase 3: Probability Calculation Pipeline (2 suites)
   - Phase 4: Evidence Quality Assessment (2 suites)
   - Phase 5: Preponderance Determination (2 suites)
   - Phase 6: Integration Testing (2 suites)
   - Phase 7: End-to-End Scenarios (1 suite)

## Running the Tests

### Command Line

```bash
# Run via npm script (recommended)
npm run test:preponderance-pipeline

# Run directly with Node
node tests/preponderance-of-evidence-pipeline.test.js
```

### Expected Output

The pipeline runs 63 automated tests across 7 phases:

```
════════════════════════════════════════════════════════════════════════════════
🚀 PREPONDERANCE OF EVIDENCE AUTOMATED TESTING PIPELINE
════════════════════════════════════════════════════════════════════════════════
📋 Task: task_25 (Create automated testing pipeline for preponderance of evidence)
📍 Source: todo/optimal-strategies-burden-of-proof.md (line 10)
🎯 Standard: Civil - Balance of Probabilities (>50% threshold)
⚖️  Requirement: Preponderance of evidence assessment framework
════════════════════════════════════════════════════════════════════════════════
```

## Test Coverage

### Phase 1: Framework Validation

**Purpose:** Ensure preponderance framework is properly configured

**Tests:**
- ✅ Preponderance framework exists and is accessible
- ✅ Civil standard threshold is correctly set to 50.1% (>50%)
- ✅ Threshold edge cases (50.0%, 50.1%, 51.0%, 75.0%)

**Key Validations:**
- Framework file `burden-of-proof-requirements.json` exists
- Civil standard requirement is "Preponderance of evidence"
- Threshold validation for edge cases (exactly 50% should FAIL)

### Phase 2: Evidence Weighting Pipeline

**Purpose:** Validate evidence weighting and aggregation algorithms

**Tests:**
- ✅ Evidence weighting algorithm calculates correctly
- ✅ Multi-evidence aggregation produces accurate results

**Key Algorithms:**
```javascript
// Evidence Weight = (reliability × 0.4) + (relevance × 0.3) + 
//                   (corroboration × 0.2) + (source_credibility × 0.1)

// Aggregation = Σ(evidence_strength × weight) / Σ(weight)
```

**Test Scenarios:**
- Strong direct evidence (>75% strength)
- Moderate circumstantial evidence (55-75% strength)
- Weak evidence (<50% strength)

### Phase 3: Probability Calculation Pipeline

**Purpose:** Validate probability calculations and comparative analysis

**Tests:**
- ✅ Bayesian-style probability updates
- ✅ Comparative analysis (plaintiff vs defendant)

**Key Concepts:**
- Posterior probability calculation using evidence strength
- Comparative probability analysis (must exceed 50% for preponderance)
- Edge case handling (exactly 50% should favor defendant)

**Test Scenarios:**
- Strong evidence supporting guilt (70-85% posterior)
- Moderate evidence with neutral prior (55-70% posterior)
- Weak evidence with low prior (25-40% posterior)

### Phase 4: Evidence Quality Assessment

**Purpose:** Validate evidence quality metrics and corroboration effects

**Tests:**
- ✅ Evidence quality assessment (authenticity, relevance, reliability)
- ✅ Corroboration effects on evidence strength

**Quality Formula:**
```javascript
Quality = (authenticity + relevance + reliability) / 3
// Note: Inadmissible evidence = 0 quality (excluded)
```

**Corroboration:**
- Each corroboration adds credibility with diminishing returns
- Boost = 0.15 × (reliability/100) × (1/count)

**Test Scenarios:**
- High-quality documentary evidence (>90% quality)
- Moderate quality witness testimony (65-80% quality)
- Low quality circumstantial (<50% quality)
- Inadmissible evidence (0% quality - excluded)

### Phase 5: Preponderance Determination

**Purpose:** Validate the core preponderance determination algorithm

**Tests:**
- ✅ Preponderance determination with multiple evidence sets
- ✅ Alternative explanation analysis

**Determination Logic:**
```javascript
overallProbability = Σ(evidence_probability × weight) / Σ(weight)
meetsPreponderance = overallProbability > 0.5
```

**Alternative Explanations:**
- Primary explanation must be more likely than all alternatives combined
- Normalized comparison: primary / (primary + alternatives)

**Test Scenarios:**
- Clear preponderance (>70% probability)
- Borderline preponderance (51-55% probability)
- Fails preponderance (<50% probability)
- Exactly at threshold (50% = FAIL)

### Phase 6: Integration Testing

**Purpose:** Ensure integration with existing burden of proof framework

**Tests:**
- ✅ Integration with `burden-of-proof-framework.js`
- ✅ Compatibility with `burden_of_proof_analyzer.py`

**Integration Points:**
- Framework files: `burden-of-proof-framework.js`, `burden-of-proof-requirements.json`, `burden-of-proof-strategies.json`
- Python analyzer: `burden_of_proof_analyzer.py`
- Civil standard configuration alignment

### Phase 7: End-to-End Scenarios

**Purpose:** Validate complete preponderance assessment workflows

**Tests:**
- ✅ Real-world case scenarios with actual evidence profiles

**Test Cases:**
1. **Fiduciary Breach - Peter (Strong Case)**
   - Evidence quality: 80-90%
   - Alternative explanations: 15-25%
   - Expected: MEETS preponderance

2. **Revenue Diversion - Rynette (Moderate Case)**
   - Evidence quality: 60-75%
   - Alternative explanations: 25-45%
   - Expected: MEETS preponderance

3. **Professional Misconduct - Bantjies (Weak Case)**
   - Evidence quality: 35-45%
   - Alternative explanations: 50-95%
   - Expected: FAILS preponderance

## Preponderance Threshold

The pipeline enforces the civil standard threshold:

```
PREPONDERANCE_THRESHOLD = 0.501 (50.1%)
```

### Key Rules:
- ✅ **>50%** = Preponderance established
- ❌ **=50%** = Preponderance NOT established (tie goes to defendant)
- ❌ **<50%** = Preponderance NOT established

### Interpretation:
- **More likely than not** that the allegation is true
- Plaintiff's evidence must **outweigh** defendant's evidence
- Primary explanation must be **more probable** than alternatives

## Usage in Development

### Adding New Tests

To add new preponderance tests:

```javascript
testNewPreponderanceScenario() {
  console.log('\n🧪 Test: New preponderance scenario...');
  
  const scenario = {
    evidence: [/* evidence array */],
    alternatives: [/* alternatives */],
    expectedOutcome: true/false
  };
  
  const result = evaluateCase(scenario);
  this.assert(result.meetsPreponderance === scenario.expectedOutcome,
              'Test description');
  
  return true;
}
```

Add the test to the `runAllTests()` method in the `testPhases` array.

### Customizing Thresholds

Adjust threshold constants at the class level:

```javascript
constructor() {
  this.PREPONDERANCE_THRESHOLD = 0.501; // >50%
  this.HIGH_CONFIDENCE = 0.75; // 75%+
  this.LOW_CONFIDENCE = 0.40; // <50%
}
```

## Integration with CI/CD

The test can be integrated into CI/CD pipelines:

```yaml
# Example GitHub Actions workflow
- name: Run Preponderance Pipeline Tests
  run: npm run test:preponderance-pipeline
```

## Related Documentation

- **Main Framework:** `burden-of-proof-requirements.json`
- **Civil Standards:** `tests/civil-evidence-standards-validation.test.js` (task_24)
- **Overall Workflow:** `tests/burden-of-proof-workflow-test.js`
- **Python Analyzer:** `burden_of_proof_analyzer.py`

## Success Criteria

The pipeline passes when:
- ✅ All 63 tests pass (100% success rate)
- ✅ Framework validation complete
- ✅ Evidence weighting algorithms validated
- ✅ Probability calculations verified
- ✅ Evidence quality metrics tested
- ✅ Preponderance determination validated
- ✅ Integration confirmed
- ✅ End-to-end scenarios pass

## Error Handling

If tests fail:
1. Check framework files exist and are valid JSON
2. Verify threshold configurations match specifications
3. Review evidence weighting calculations
4. Validate probability calculation logic
5. Check integration with burden of proof framework

## Performance

- **Execution Time:** ~0.01-0.02 seconds
- **Test Count:** 63 automated tests
- **Phase Count:** 7 phases (13 test suites)
- **Memory:** Minimal (in-memory calculations only)

## Maintenance

### Regular Updates
- Update test scenarios when adding new evidence types
- Adjust thresholds if legal standards change
- Add new integration tests when framework expands

### Regression Testing
- Run after any changes to burden of proof framework
- Validate before deploying evidence assessment features
- Include in continuous integration pipeline

## Task Completion

**Task ID:** task_25  
**Feature ID:** feature_33  
**Paragraph ID:** para_22  
**Status:** ✅ COMPLETE

This automated testing pipeline fulfills the requirement to create comprehensive automated testing for the preponderance of evidence assessment framework, ensuring that the civil standard "Balance of Probabilities" (>50% threshold) is correctly implemented and validated across all evidence assessment workflows.
