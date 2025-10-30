# Civil Evidence Standards Validation Test Suite

## Overview

This comprehensive test suite validates civil evidence standards under the **Balance of Probabilities** standard (>50% likelihood threshold). The test suite implements task_24 from feature_33 as defined in `todo/optimal-strategies-burden-of-proof.md`.

## Purpose

The civil evidence standards validation test ensures that the burden of proof framework correctly implements and validates the civil standard for legal proceedings, where Dan & Jax must prove allegations against accused parties (Peter, Rynette, Bantjies, etc.) to a standard of "more likely than not" (>50% probability).

## Test Coverage

### 1. Civil Standard Framework (Test 1-3)
- **Framework Validation**: Verifies that the civil standard is properly defined with:
  - Name: "Balance of Probabilities"
  - Threshold: 50.1% (more likely than not)
  - Requirement: "Preponderance of evidence"
- **Evidence Threshold Requirements**: Validates evidence quality, corroboration, and burden-shifting rules
- **Necessary Elements**: Confirms all required elements for civil proof are defined

### 2. Preponderance of Evidence Assessment (Test 4)
- Validates that the framework allows both direct and circumstantial evidence
- Confirms primary, supporting, and expert evidence requirements are defined
- Tests that preponderance can be established through multiple evidence types

### 3. Documentary Evidence Validation (Test 5)
- **Protocol Testing**: Validates documentary evidence evaluation mechanisms
- **Authenticity Checks**: Tests document authentication and relevance validation
- **Threshold Validation**: Ensures documentary evidence meets >50% validation rate

### 4. Witness Credibility Assessment (Test 6)
- **Credibility Scoring**: Tests witness credibility evaluation (60%+ threshold)
- **Bias Detection**: Validates filtering of biased witnesses
- **Consistency Checks**: Confirms testimony consistency requirements
- **Threshold Validation**: Ensures witness credibility rate exceeds 50%

### 5. Circumstantial Evidence Evaluation (Test 7)
- **Strength Assessment**: Evaluates circumstantial evidence strength (60%+ threshold)
- **Reliability Testing**: Validates evidence reliability (65%+ threshold)
- **Pattern Recognition**: Tests identification of strong circumstantial indicators
- **Threshold Validation**: Confirms overall strength meets >50% standard

### 6. Likelihood Threshold Calculations (Test 8)
- **Scenario Testing**: Tests three evidence scenarios:
  - Strong Direct Evidence (expected >50%)
  - Moderate Circumstantial Evidence (expected >50%)
  - Weak Evidence (expected <50%)
- **Weighted Calculations**: Validates evidence weight × reliability calculations
- **Threshold Enforcement**: Confirms proper >50% threshold application

### 7. Balance of Probabilities Comparison (Test 9)
- **Competing Narratives**: Tests evaluation of plaintiff vs defendant evidence
- **Probability Comparison**: Validates that higher probability prevails
- **Outcome Prediction**: Confirms correct outcome based on evidence strength
- **Use Cases**: Tests fiduciary breach, contract dispute, and negligence scenarios

### 8. Proof Requirements for Dan & Jax (Test 10)
- **Misconduct Proof**: Validates requirement to prove specific acts of misconduct
- **Intent/Negligence**: Confirms intent or negligence must be established
- **Harm/Damages**: Validates that resulting harm must be proven
- **Quantification**: Tests requirement for quantifiable damages

### 9. Framework Integration (Test 11)
- **File Existence**: Verifies all framework files are present
- **Threshold Consistency**: Validates civil threshold (50.1%) across framework
- **Standards Alignment**: Ensures proper integration with burden of proof system

### 10. Evidence Sufficiency Assessment (Test 12)
- **Piece Count**: Tests minimum evidence pieces requirement (3+)
- **Quality Threshold**: Validates quality average threshold (60%+)
- **Corroboration**: Confirms corroboration requirements
- **Sufficiency Determination**: Tests correct sufficiency assessment for various claims

### 11. Alternative Explanations Evaluation (Test 13)
- **Framework Requirement**: Validates that alternative explanations must be evaluated
- **Likelihood Comparison**: Tests primary vs alternative explanation weighting
- **Threshold Application**: Confirms primary explanation must exceed 50%
- **Scenario Testing**: Tests multiple explanation comparison scenarios

### 12. Damages/Harm Calculation Framework (Test 14)
- **Requirement Validation**: Confirms damages must be proven
- **Calculation Testing**: Validates damage proof percentage calculations
- **Threshold Application**: Tests that proven damages must meet >50% of claimed
- **Scenario Coverage**: Tests various damage claim scenarios
- **Duplicate Detection**: Identifies duplicate damage claims by category and time period
- **Duplicate Prevention**: Ensures damage claims are not double-counted in totals
- **Test Cases**:
  - Detects duplicate claims with same category and period
  - Calculates correct totals excluding duplicates (e.g., R115,000 from 5 claims with 1 duplicate)
  - Validates all unique claims are properly counted
  - Confirms no false positives when claims differ by period or category

### 13. Causal Connection Requirements (Test 15)
- **Framework Requirement**: Validates causal connection proof is required
- **Strength Assessment**: Tests causation strength calculation using:
  - Temporal proximity (30% weight)
  - Intervening factors (30% weight, inverted)
  - Overall strength (40% weight)
- **Threshold Validation**: Confirms causal strength must exceed 50%
- **Scenario Testing**: Tests direct, indirect, and weak causation scenarios

## Running the Tests

### Via npm Script (Recommended)
```bash
npm run test:civil-evidence-standards
```

### Direct Execution
```bash
node tests/civil-evidence-standards-validation.test.js
```

### As Part of Full Test Suite
```bash
npm test
```

## Test Results Format

### Success Output
```
🎉 ALL CIVIL EVIDENCE STANDARDS VALIDATION TESTS PASSED!
✅ Civil standard (>50% likelihood) fully validated
✅ Preponderance of evidence assessment framework verified
✅ Documentary evidence validation protocols confirmed
✅ Witness credibility mechanisms tested
✅ Circumstantial evidence evaluation validated
✅ Likelihood threshold calculations verified
✅ Balance of probabilities comparison working correctly
✅ Framework integration complete
```

### Metrics Reported
- **Total Tests**: 56 assertions across 15 test categories
- **Success Rate**: Percentage of passed tests
- **Execution Time**: Test suite duration in seconds
- **Standard**: Balance of Probabilities
- **Threshold**: >50% likelihood

## Dependencies

### Framework Files Required
- `burden-of-proof-requirements.json` - Defines civil standard requirements
- `burden-of-proof-framework.js` - Core framework implementation
- `burden-of-proof-strategies.json` - Target-specific strategies

### Integration Points
The test suite integrates with:
- Burden of Proof Framework (main implementation)
- Evidence validation workflows
- Legal verification systems
- Hierarchical issue management

## Legal Standards Validated

### Civil Standard: Balance of Probabilities
- **Threshold**: More likely than not (>50.1%)
- **Evidence Required**: Preponderance of evidence
- **Burden**: On plaintiff (Dan & Jax in this case)
- **Quality**: Credible and reliable evidence
- **Corroboration**: Preferred but not required
- **Burden Shifting**: Prima facie case shifts burden to defendant

### Key Principles Tested
1. **Factual Allegations**: Must be supported by evidence
2. **Causal Connection**: Actions must be linked to harm
3. **Damages**: Harm must be clearly established
4. **Alternative Explanations**: Must be less probable than primary explanation

## Use Cases

### 1. Fiduciary Duty Breach
- Documentary evidence of fiduciary relationship
- Evidence of breach of duty
- Proof of damages resulting from breach
- Causal connection between breach and harm

### 2. Financial Misconduct
- Financial records showing irregular transactions
- Pattern evidence of systematic behavior
- Expert testimony on financial irregularities
- Quantifiable financial harm

### 3. Breach of Contract
- Contract documentation
- Evidence of breach
- Proof of damages from breach
- Causal link between breach and losses

## Test Scenarios Covered

### Evidence Strength Scenarios
1. **Strong Direct Evidence**: Documentary + witness + expert (89.5% likelihood)
2. **Moderate Circumstantial**: Pattern + opportunity + motive + docs (72.8% likelihood)
3. **Weak Evidence**: Low reliability witness + weak circumstantial (42.5% likelihood)

### Causation Scenarios
1. **Direct Causation**: Clear timeline, minimal intervening factors (93% strength)
2. **Indirect Causation**: Supporting evidence, some intervening factors (66% strength)
3. **Weak Causation**: Multiple intervening factors (38% strength)

### Damage Proof Scenarios
1. **High Proof Rate**: 85% of claimed damages proven (MEETS threshold)
2. **Moderate Proof Rate**: 60% of claimed damages proven (MEETS threshold)
3. **Low Proof Rate**: 47.5% of claimed damages proven (FAILS threshold)

### Duplicate Prevention Scenarios (Task 33 Implementation)
1. **Duplicate Detection**: Multiple claims with same category and period
   - Example: Two "revenue_loss" claims for "2025-Q1" (each R50,000)
   - Detection: Identifies 1 duplicate from 5 total claims
2. **Duplicate-Free Calculation**: Properly excludes duplicates from totals
   - Input claims: R50,000 + R20,000 + R50,000 (duplicate) + R30,000 + R15,000
   - Without duplicate prevention: R165,000 (incorrect - double-counted)
   - With duplicate prevention: R115,000 (correct total)
3. **Unique Claims Validation**: All unique claims counted when no duplicates exist
   - Different categories: "revenue_loss" vs "operational_costs"
   - Different periods: "2025-Q1" vs "2025-Q2"
   - Result: All 4 claims properly counted as unique

## Maintenance

### Adding New Tests
To add new civil evidence standard tests:

1. Add test method to `CivilEvidenceStandardsValidation` class
2. Follow naming convention: `test[Category][Aspect]()`
3. Use `this.assert()` for all validations
4. Add test to `runAllTests()` array
5. Update this documentation

### Updating Standards
If civil standard requirements change:

1. Update `burden-of-proof-requirements.json`
2. Review and update test assertions
3. Run full test suite to verify
4. Update documentation to reflect changes

## Related Documentation

- `todo/optimal-strategies-burden-of-proof.md` - Source task definition
- `burden-of-proof-requirements.json` - Civil standard specification
- `BURDEN_OF_PROOF_IMPLEMENTATION_COMPLETE.md` - Implementation overview
- `tests/burden-of-proof-workflow-test.js` - Workflow integration tests

## Task Reference

- **Task ID**: task_24
- **Feature ID**: feature_33
- **Paragraph ID**: para_22
- **Source**: todo/optimal-strategies-burden-of-proof.md (line 9)
- **Description**: Implement comprehensive test suite for civil evidence standards validation (>50% likelihood)

## Contact

For questions about this test suite or civil evidence standards validation, refer to:
- Repository copilot instructions (`.github/copilot-instructions.md`)
- Burden of proof framework documentation
- Hierarchical issues documentation
