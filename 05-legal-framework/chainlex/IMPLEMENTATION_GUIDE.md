# ChainLex Implementation Guide

**Version:** 2.0  
**Date:** October 23, 2025  
**Status:** Core Utilities and Helpers Implemented

## Overview

This guide documents the implementation strategy for the ChainLex legal reasoning system. The system consists of **2,349 functions** across **7 legal frameworks** plus **60+ Level 1 principles**.

## Architecture

### Three-Layer Design

```
┌─────────────────────────────────────────────────────────┐
│ Level 2+: Jurisdiction-Specific Rules (2,349 functions) │
│ ├── South African Civil Law (339 functions)             │
│ ├── South African Criminal Law (326 functions)          │
│ ├── South African Labour Law (366 functions)            │
│ ├── South African Construction Law (349 functions)      │
│ ├── South African Environmental Law (306 functions)     │
│ ├── South African International Law (356 functions)     │
│ └── South African Administrative Law (213 functions)    │
└─────────────────────────────────────────────────────────┘
                          ↓ derives from
┌─────────────────────────────────────────────────────────┐
│ Level 1: First-Order Principles (60+ principles)        │
│ ├── pacta-sunt-servanda (contracts must be kept)        │
│ ├── consensus-ad-idem (meeting of minds)                │
│ ├── neminem-laedere (harm no one)                       │
│ ├── nulla-poena-sine-lege (no punishment without law)   │
│ └── ... (56 more principles)                            │
└─────────────────────────────────────────────────────────┘
                          ↓ uses
┌─────────────────────────────────────────────────────────┐
│ Level 0: Core Utilities (Infrastructure)                │
│ ├── core_utilities.scm (data structures, operations)    │
│ ├── contract_law_helpers.scm (contract-specific logic)  │
│ ├── delict_law_helpers.scm (tort-specific logic)        │
│ └── ... (domain-specific helpers)                       │
└─────────────────────────────────────────────────────────┘
```

## Implementation Status

### ✅ Completed

1. **Core Utilities Module** (`lv1/core_utilities.scm`)
   - Data structure operations (has-attribute, get-attribute, set-attribute)
   - Entity operations (create-entity, entity-type, entity-id)
   - List/set operations (member-of?, subset-of?, intersection, union)
   - Temporal operations (current-date, date-diff, within-time-period?)
   - Logical operations (all-true?, any-true?, none-true?)
   - Comparison operations (value-equals?, value-greater?, value-less?)
   - String operations (string-contains?, string-matches?)
   - Numeric operations (within-range?, percentage-of)
   - Legal-specific operations (applies-to-jurisdiction?, get-confidence, compute-inference)
   - Validation helpers (valid-date?, valid-entity?, valid-amount?)

2. **Contract Law Helpers** (`lv1/contract_law_helpers.scm`)
   - Contract formation (intention-to-create-legal-relations?, capacity-of-parties?, legality-of-object?)
   - Offer and acceptance (within-reasonable-time?, mirror-image-rule?)
   - Contract terms (express-term?, implied-term?, condition-precedent?, condition-subsequent?)
   - Contract performance (substantial-performance?, material-breach?, anticipatory-breach?)
   - Contract remedies (specific-performance-available?, damages-adequate-remedy?)
   - Contract interpretation (plain-meaning-rule?, contra-proferentem?, business-efficacy-test?)
   - Additional helpers (consideration-adequate?, past-consideration?, promissory-estoppel-applies?)

3. **Delict Law Helpers** (`lv1/delict_law_helpers.scm`)
   - Elements of delict (act-or-omission?, contra-boni-mores?, infringement-of-right?, breach-of-legal-duty?)
   - Fault (duty-of-care?, breach-of-duty?, reasonable-person-standard?)
   - Causation (but-for-test?, reasonable-foreseeability?, novus-actus-interveniens?)
   - Defenses (consent-defense?, necessity-defense?, self-defense?)
   - Damages (patrimonial-loss?, non-patrimonial-loss?)
   - Specific torts (defamation?, privacy-invasion?, negligent-misstatement?)
   - Additional helpers (vicarious-liability?, strict-liability?, contributory-negligence?, apportionment-of-damages)

### 🚧 In Progress

4. **Criminal Law Helpers** (planned)
   - Elements of crime (actus-reus?, mens-rea?, causation?)
   - Defenses (insanity?, intoxication?, necessity?, duress?)
   - Specific crimes (murder?, theft?, fraud?, assault?)

5. **Property Law Helpers** (planned)
   - Ownership (ownership-rights?, possession?, transfer-of-ownership?)
   - Real rights (servitude?, mortgage?, pledge?)
   - Personal rights (lease?, loan?, deposit?)

6. **Labour Law Helpers** (planned)
   - Employment relationship (employee?, independent-contractor?)
   - Dismissal (fair-dismissal?, unfair-dismissal?, constructive-dismissal?)
   - Collective bargaining (strike-lawful?, lockout-lawful?)

7. **Administrative Law Helpers** (planned)
   - Administrative action (administrative-action?, lawful?, reasonable?, procedurally-fair?)
   - Judicial review (reviewable?, grounds-for-review?)

8. **Environmental Law Helpers** (planned)
   - Environmental impact (eia-required?, significant-impact?)
   - Liability (polluter-pays?, strict-liability?)

9. **Construction Law Helpers** (planned)
   - Construction contracts (fidic-compliant?, jbcc-compliant?)
   - Defects (latent-defect?, patent-defect?)
   - Claims (extension-of-time?, variation-order?)

## Implementation Strategy

### Phase 1: Core Infrastructure ✅

**Status:** Complete

**Deliverables:**
- `core_utilities.scm` - 50+ utility functions
- `contract_law_helpers.scm` - 25+ contract-specific functions
- `delict_law_helpers.scm` - 20+ tort-specific functions

**Key Decisions:**
- Use association lists (alists) as primary data structure for entities
- Support both alists and hash tables for flexibility
- Implement temporal operations using Unix timestamps
- Use confidence levels (0.0-1.0) for inference chains

### Phase 2: Domain-Specific Helpers 🚧

**Status:** In Progress (3/9 complete)

**Approach:**
1. Identify common patterns in each legal domain
2. Extract helper functions from Level 2+ rules
3. Implement based on Level 1 principles
4. Add comprehensive documentation

**Remaining Work:**
- Criminal law helpers (estimated 20 functions)
- Property law helpers (estimated 15 functions)
- Labour law helpers (estimated 25 functions)
- Administrative law helpers (estimated 15 functions)
- Environmental law helpers (estimated 10 functions)
- Construction law helpers (estimated 15 functions)

### Phase 3: Integration with Existing Rules 📋

**Status:** Planned

**Approach:**
1. Update existing .scm files to import helper modules
2. Replace placeholder calls with actual helper functions
3. Add missing logic where helpers don't exist
4. Test integration with hypergraph

**Files to Update:**
- `civ/za/south_african_civil_law.scm` (339 functions)
- `cri/za/south_african_criminal_law.scm` (326 functions)
- `lab/za/south_african_labour_law.scm` (366 functions)
- `cst/za/south_african_construction_law.scm` (349 functions)
- `env/za/south_african_environmental_law.scm` (306 functions)
- `int/za/south_african_international_law.scm` (356 functions)
- `adm/za/south_african_administrative_law.scm` (213 functions)

### Phase 4: Testing and Validation 📋

**Status:** Planned

**Test Cases:**
1. Unit tests for each helper function
2. Integration tests for complete legal scenarios
3. Inference chain validation
4. Confidence computation verification
5. Cross-domain relationship testing

### Phase 5: Documentation and Examples 📋

**Status:** Planned

**Deliverables:**
- Usage examples for each helper module
- Legal reasoning walkthroughs
- Inference chain examples
- API documentation

## Data Structure Design

### Entity Representation

Entities are represented as association lists (alists):

```scheme
;; Example: Natural person
(define person
  '((type . natural-person)
    (id . "ZA-ID-8501015800089")
    (name . "John Doe")
    (age . 40)
    (birth-date . 473385600)  ; Unix timestamp
    (identity-number . "8501015800089")
    (mental-capacity . #t)
    (insolvent . #f)))

;; Example: Contract
(define contract
  '((type . contract)
    (id . "CONTRACT-2025-001")
    (parties . (party-a party-b))
    (offer . offer-entity)
    (acceptance . acceptance-entity)
    (consideration . consideration-entity)
    (context . commercial)
    (express-intention . #t)
    (terms . (term-1 term-2 term-3))
    (performance-date . 1735689600)  ; Future date
    (enforceable . #t)))
```

### Confidence Levels

Confidence levels indicate certainty of legal conclusions:

```scheme
;; Level 1 principles: 1.0 (explicitly stated)
(define pacta-sunt-servanda
  '((confidence . 1.0)
    (provenance . "Roman law maxim")))

;; Level 2 rules: 0.95 (derived deductively)
(define contract-valid?
  '((confidence . 0.95)
    (derived-from . (pacta-sunt-servanda consensus-ad-idem))
    (inference-type . deductive)))

;; Inference chains: cumulative
;; confidence = principle-confidence × inference-factor
;; deductive: 0.95, inductive: 0.80, abductive: 0.70, analogical: 0.65
```

### Inference Types

Four types of legal inference:

1. **Deductive** (0.95 factor)
   - Conclusion necessarily follows from premises
   - Example: "All contracts require offer + acceptance. This has both. Therefore, valid contract."

2. **Inductive** (0.80 factor)
   - Conclusion probably follows from premises
   - Example: "Most employment contracts include notice periods. This is an employment contract. Therefore, probably includes notice period."

3. **Abductive** (0.70 factor)
   - Best explanation for observed facts
   - Example: "Contract was breached. Defendant had motive and opportunity. Therefore, defendant likely breached."

4. **Analogical** (0.65 factor)
   - Reasoning by similarity to precedent
   - Example: "Case A is similar to Case B. Case B was decided X. Therefore, Case A should be decided X."

## Usage Examples

### Example 1: Contract Validity Check

```scheme
(use-modules (chainlex core-utilities)
             (chainlex contract-law-helpers))

(define my-contract
  '((type . contract)
    (parties . ((party-a . ((age . 25) (mental-capacity . #t) (insolvent . #f)))
                (party-b . ((age . 30) (mental-capacity . #t) (insolvent . #f)))))
    (offer . ((date . 1729699200)))
    (acceptance . ((date . 1729785600) (terms . (term-1 term-2))))
    (consideration . ((value . 10000)))
    (context . commercial)
    (purpose . sale-of-goods)
    (illegal . #f)
    (contra-bonos-mores . #f)))

;; Check validity
(define valid? (contract-valid? my-contract))
;; Returns: #t

;; Check specific elements
(define has-capacity? (capacity-of-parties? my-contract))
;; Returns: #t

(define legal-object? (legality-of-object? my-contract))
;; Returns: #t

(define has-intention? (intention-to-create-legal-relations? my-contract))
;; Returns: #t
```

### Example 2: Delict Liability Check

```scheme
(use-modules (chainlex core-utilities)
             (chainlex delict-law-helpers))

(define delict-claim
  '((type . delict-claim)
    (act . ((type . speeding)
            (rights-infringed . (bodily-integrity))
            (duty-breached . #t)))
    (defendant . ((relationship-to-plaintiff . driver-pedestrian)
                  (harm-foreseeable . #t)
                  (proximity-to-plaintiff . #t)
                  (failed-standard . #t)
                  (precautions . ())
                  (risk-level . high)))
    (damage . ((type . injury)
               (foreseeable . #t)
               (would-occur-without-act . #f)))))

;; Check if delict established
(define delict? (delict-established? delict-claim))
;; Returns: #t

;; Check specific elements
(define wrongful? (wrongfulness? (get-attribute delict-claim 'act)))
;; Returns: #t

(define negligent? (negligence? (get-attribute delict-claim 'defendant)))
;; Returns: #t

(define causal? (factual-causation? 
                  (get-attribute delict-claim 'act)
                  (get-attribute delict-claim 'damage)))
;; Returns: #t
```

### Example 3: Inference Chain

```scheme
(use-modules (chainlex core-utilities))

;; Level 1 principle
(define pacta-sunt-servanda
  '((type . principle)
    (name . "pacta-sunt-servanda")
    (confidence . 1.0)
    (provenance . "Roman law")))

;; Intermediate rule
(define contract-binding
  '((type . rule)
    (name . "contract-binding")
    (confidence . 0.95)
    (derived-from . (pacta-sunt-servanda))
    (inference-type . deductive)))

;; Specific application
(define this-contract-binding
  '((type . application)
    (name . "this-contract-binding")
    (derived-from . (contract-binding))
    (inference-type . deductive)))

;; Compute chain confidence
(define chain-confidence
  (compute-inference
    (compute-inference pacta-sunt-servanda contract-binding 'deductive)
    this-contract-binding
    'deductive))
;; Returns: 0.9025 (1.0 × 0.95 × 0.95)
```

## Integration with Hypergraph

The helper functions integrate seamlessly with the hypergraph system:

1. **Nodes** represent legal entities (principles, rules, concepts)
2. **Edges** represent relationships (derivation, analogy, contradiction)
3. **Hyperedges** represent multi-premise inferences
4. **Confidence** flows through inference chains

### Example: Query with Helpers

```python
from query_hypergraph import HypergraphQuery

# Load hypergraph
query = HypergraphQuery("scmlex_hypergraph.pkl")

# Find contract law principles
principles = query.find_principles_by_domain('contract')

# For each principle, find derived rules
for principle in principles:
    rules = query.find_rules_derived_from_principle(principle['name'])
    
    # Use helper functions to validate
    for rule in rules:
        # Check if rule applies to current jurisdiction
        if applies_to_jurisdiction?(rule, 'ZA'):
            # Compute confidence
            confidence = get_confidence(rule)
            print(f"{rule['name']}: {confidence}")
```

## Best Practices

### 1. Always Use Helper Functions

❌ **Bad:**
```scheme
(define (contract-valid? contract)
  (and (has-attribute contract 'offer)
       (has-attribute contract 'acceptance)
       ;; ... many more checks
       ))
```

✅ **Good:**
```scheme
(use-modules (chainlex contract-law-helpers))

(define (contract-valid? contract)
  (and (offer-exists? contract)
       (acceptance-exists? contract)
       (consideration-exists? contract)
       (intention-to-create-legal-relations? contract)
       (capacity-of-parties? contract)
       (legality-of-object? contract)))
```

### 2. Document Derivations

Always document which Level 1 principles a rule derives from:

```scheme
(define (specific-performance-available? contract)
  "Check if specific performance available (derived from specific-performance principle)"
  ;; Implementation
  )
```

### 3. Use Confidence Levels

Include confidence levels for all derived rules:

```scheme
(define rule
  '((confidence . 0.95)
    (derived-from . (pacta-sunt-servanda))
    (inference-type . deductive)))
```

### 4. Handle Edge Cases

Always handle edge cases and invalid inputs:

```scheme
(define (has-attribute entity attribute-name)
  (cond
    ((list? entity) (assoc attribute-name entity))
    ((hash-table? entity) (hash-table-exists? entity attribute-name))
    (else #f)))  ; Handle invalid entity type
```

## Next Steps

1. **Complete domain-specific helpers** (6 remaining modules)
2. **Update existing .scm files** to use helpers
3. **Create test suite** for all functions
4. **Generate documentation** with examples
5. **Update hypergraph** with new relationships
6. **Create interactive demo** showcasing legal reasoning

## Contributing

To add new helper functions:

1. Identify the legal domain
2. Create or update the appropriate helper module
3. Implement based on Level 1 principles
4. Add comprehensive documentation
5. Include usage examples
6. Update this guide
7. Commit to repository

## References

- [ChainLex Repository](https://github.com/cogpy/chainlex)
- [Hypergraph Documentation](hypergraph/README.md)
- [Schema Documentation](hypergraph/SCHEMA.md)
- [Enhancement Guide](ENHANCEMENTS.md)

---

**Last Updated:** October 23, 2025  
**Version:** 2.0  
**Status:** Core utilities complete, domain helpers in progress

