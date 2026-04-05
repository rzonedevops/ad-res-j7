;; South African Trust Law - Enhanced v3
;; Specialized module for trust power abuse and beneficiary protection in AD-RES-J7 case
;; =============================================================================

;; Import Level 1 first-order principles
(require "../../lv1/known_laws.scm")

;; Initialize principle registry
(initialize-principle-registry!)

;; =============================================================================
;; FRAMEWORK METADATA
;; =============================================================================

(define framework-metadata
  (make-hash-table
   'name "South African Trust Law - Enhanced v3"
   'jurisdiction "za"
   'legal-domain '(trust fiduciary)
   'version "3.0"
   'last-updated "2025-11-01"
   'derived-from-level 1
   'confidence-base 0.95
   'language "en"
   'case-application "AD-RES-J7 (Case 2025-137857)"))

;; =============================================================================
;; CRITICAL: TRUST POWER BYPASS INDICATORS (ENHANCED)
;; =============================================================================

(define trust-power-bypass-temporal-analysis
  (make-principle
   'name 'trust-power-bypass-temporal-analysis
   'description "Temporal analysis of trustee bypassing direct trust powers, especially when coinciding with settlement or adverse action."
   'domain '(trust fiduciary abuse-of-process temporal-analysis)
   'confidence 0.96
   'jurisdiction "za"
   'statutory-basis "Trust Property Control Act 57/1988, common law fiduciary duties"
   'indicators '(trustee-has-absolute-powers
                trustee-seeks-court-relief-instead
                beneficiary-is-target-of-relief
                timing-coincides-with-settlement-negotiation
                timing-immediately-follows-beneficiary-cooperation
                manufactured-urgency
                no-internal-resolution-attempt)
   'inference "Seeking court relief when direct power exists, especially with adverse timing, suggests ulterior motive (leverage, harassment, delay) beyond trust administration."
   'case-application "Peter has absolute trust powers but seeks interdict against beneficiary Jax (2 days after she signs backdating document) during settlement negotiation."
   'related-principles '(proper-purpose-test abuse-of-process trustee-conflict-prohibition)
   'inference-type 'abductive
   'base-principles (list fiduciary-duty)))

;; =============================================================================
;; CRITICAL: BENEFICIARY PROTECTION WHEN ATTACKED (NEW)
;; =============================================================================

(define beneficiary-protection-when-attacked
  (make-principle
   'name 'beneficiary-protection-when-attacked
   'description "Principle for beneficiary protection when trustee initiates adverse legal action against them."
   'domain '(trust fiduciary conflict-of-interest)
   'confidence 0.97
   'jurisdiction "za"
   'statutory-basis "Trust Property Control Act 57/1988 s9, common law fiduciary duties"
   'prohibition "Trustee cannot use trust powers or position to attack beneficiary through legal proceedings, especially when the beneficiary is supporting another beneficiary."
   'elements '(trustee-initiates-legal-action
              beneficiary-is-target
              action-uses-trust-position-or-powers
              conflict-with-fiduciary-duty
              beneficiary-punished-for-supporting-another-beneficiary)
   'remedies '(set-aside-action
              remove-trustee
              damages-for-breach-of-fiduciary-duty)
   'case-application "Peter (Trustee) and Danie (Co-Trustee) include Jax (Beneficiary) in interdict for 'helping Daniel'."
   'related-principles '(trustee-conflict-prohibition fiduciary-duty-of-loyalty)
   'inference-type 'deductive
   'base-principles (list fiduciary-duty)))

;; =============================================================================
;; CRITICAL: BACKDATING COERCION INDICATORS (NEW)
;; =============================================================================

(define backdating-coercion-indicators
  (make-principle
   'name 'backdating-coercion-indicators
   'description "Indicators of coercion when a party signs a backdated document followed immediately by adverse action against them."
   'domain '(trust corporate-governance fraud coercion)
   'confidence 0.95
   'jurisdiction "za"
   'statutory-basis "Common law fraud, misrepresentation, duress"
   'red-flags '(document-signed-after-stated-effective-date
               signer-immediately-becomes-target-of-adverse-action
               timing-suggests-coercion-or-ulterior-motive
               signer-has-no-benefit-from-signing)
   'case-application "Jax signs 11 Aug 2025 backdating Peter's Main Trustee status; Peter files interdict against Jax 2 days later (13 Aug)."
   'inference "Immediate adverse action against the signer suggests the signing was coerced or used as a pretext for the subsequent action."
   'related-principles '(backdating-indicators ulterior-motive-analysis)
   'inference-type 'abductive
   'base-principles (list fraud-indicators)))

;; =============================================================================
;; CRITICAL: MANUFACTURED CRISIS INDICATORS (NEW)
;; =============================================================================

(define manufactured-crisis-indicators
  (make-principle
   'name 'manufactured-crisis-indicators
   'description "Indicators that a crisis event was intentionally manufactured or timed to coincide with other events."
   'domain '(delict tort abuse-of-process temporal-analysis)
   'confidence 0.94
   'jurisdiction "za"
   'statutory-basis "Common law delict (wrongfulness, causation)"
   'indicators '(adverse-action-immediately-follows-disclosure-of-fraud
                action-disproportionate-to-stated-cause
                timing-coincides-with-reporting-or-investigation
                pattern-of-escalating-adverse-actions)
   'case-application "Card cancellations on 7 Jun 2025 (day after Dan provides reports to accountant on 6 Jun)."
   'inference "The timing of the crisis event suggests a retaliatory or preemptive action to create a false sense of urgency or to sabotage a counter-investigation."
   'related-principles '(fraud-exposure-retaliation-indicators ulterior-motive-analysis)
   'inference-type 'abductive
   'base-principles (list damnum-injuria-datum)))

;; =============================================================================
;; CRITICAL: FRAUD EXPOSURE RETALIATION INDICATORS (NEW)
;; =============================================================================

(define fraud-exposure-retaliation-indicators
  (make-principle
   'name 'fraud-exposure-retaliation-indicators
   'description "Indicators of adverse action taken in retaliation for exposing fraud."
   'domain '(delict tort whistleblowing temporal-analysis)
   'confidence 0.95
   'jurisdiction "za"
   'statutory-basis "Protected Disclosures Act, common law delict"
   'indicators '(adverse-action-immediately-follows-disclosure
                action-targets-disclosing-party
                action-is-disproportionate-or-unjustified
                timing-suggests-causal-link)
   'case-application "Dan exposed Villa Via fraud to Bantjies in June 2025; immediate financial sabotage and interdict followed."
   'inference "The sequence of events strongly suggests a retaliatory motive for the adverse actions."
   'related-principles '(manufactured-crisis-indicators financial-sabotage-indicators)
   'inference-type 'abductive
   'base-principles (list damnum-injuria-datum)))

;; =============================================================================
;; INTEGRATION WITH HYPERGRAPHQL
;; =============================================================================

;; Register all principles with the principle registry
(register-principle! trust-power-bypass-temporal-analysis)
(register-principle! beneficiary-protection-when-attacked)
(register-principle! backdating-coercion-indicators)
(register-principle! manufactured-crisis-indicators)
(register-principle! fraud-exposure-retaliation-indicators)

;; Export principles for use in other modules
(provide trust-power-bypass-temporal-analysis
         beneficiary-protection-when-attacked
         backdating-coercion-indicators
         manufactured-crisis-indicators
         fraud-exposure-retaliation-indicators)

;; =============================================================================
;; END OF MODULE
;; =============================================================================
