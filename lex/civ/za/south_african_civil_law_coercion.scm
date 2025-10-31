;; South African Civil Law - Coercion Indicators
;; Specialized module for detecting duress and undue influence in AD-RES-J7 case
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
   'name "South African Civil Law - Coercion Indicators"
   'jurisdiction "za"
   'legal-domain '(civil contract duress undue-influence)
   'version "1.0"
   'last-updated "2025-10-31"
   'derived-from-level 1
   'confidence-base 0.93
   'language "en"
   'case-application "AD-RES-J7 (Case 2025-137857)"))

;; =============================================================================
;; HIGH: COERCION INDICATORS
;; =============================================================================

(define coercion-indicators
  (make-principle
   'name 'coercion-indicators
   'description "Indicators that document signing or action was coerced"
   'domain '(contract duress undue-influence)
   'confidence 0.93
   'jurisdiction "za"
   'statutory-basis "Common law duress and undue influence"
   'indicators '(adverse-action-shortly-after-signing
                signer-disadvantaged-by-document
                timing-with-other-pressure-events
                no-independent-legal-advice
                beneficiary-of-document-has-power-over-signer
                document-benefits-party-with-power
                signing-during-settlement-negotiation
                follow-through-adverse-action
                power-imbalance
                fiduciary-relationship-abused)
   'temporal-pattern "Pressure event → Signing → Adverse action (days)"
   'timing-threshold "Adverse action within 1-7 days of signing indicates coercion"
   'timing-correlation-strength '(same-day "very-high"
                                 1-day "very-high"
                                 2-days "high"
                                 3-7-days "medium-high"
                                 8-14-days "medium"
                                 15-plus-days "low")
   'case-application "Settlement discussion 11 Aug → Jax signs backdating 11 Aug → Jax included in interdict 13 Aug (2 days)"
   'specific-analysis '(pressure-event "settlement-discussion"
                       pressure-date "2025-08-11"
                       signing-event "Jax signs backdating Peter's Main Trustee to 1 Jul"
                       signing-date "2025-08-11"
                       same-day-pressure-signing "yes"
                       document-benefits "Peter (gains Main Trustee authority)"
                       signer-disadvantaged "Jax (beneficiary, Peter is trustee)"
                       adverse-action "Jax included in interdict"
                       adverse-action-date "2025-08-13"
                       delta "2 days"
                       correlation "high"
                       power-relationship "trustee-beneficiary"
                       fiduciary-duty "yes"
                       independent-advice "no")
   'power-relationships '(trustee-beneficiary
                         director-shareholder
                         employer-employee
                         creditor-debtor
                         parent-child)
   'inference "Adverse action shortly after signing suggests coercion or duress"
   'legal-consequences '(set-aside-document
                        void-ab-initio
                        damages-for-duress
                        costs-order)
   'related-principles '(duress
                        undue-influence
                        unconscionable-conduct
                        temporal-bad-faith-indicators
                        settlement-bad-faith-indicators)
   'inference-type 'abductive
   'base-principles (list duress undue-influence)))

;; =============================================================================
;; HIGH: BACKDATING COERCION CORRELATION
;; =============================================================================

(define backdating-coercion-correlation
  (make-principle
   'name 'backdating-coercion-correlation
   'description "Correlation between backdating and coercion indicators"
   'domain '(contract fraud duress)
   'confidence 0.92
   'jurisdiction "za"
   'statutory-basis "Common law fraud, duress, misrepresentation"
   'correlation-elements '(document-backdated
                          signer-disadvantaged
                          adverse-action-after-signing
                          beneficiary-has-power
                          timing-reveals-coercion
                          authority-established-for-upcoming-action)
   'pattern "Backdating signed → Adverse action (days) → Backdating establishes authority for adverse action"
   'case-application "Jax signs backdating 11 Aug (Peter Main Trustee from 1 Jul) → Interdict filed 13 Aug → Backdating may establish Peter's authority for interdict"
   'inference "Backdating followed by adverse action suggests coercion and strategic authority establishment"
   'related-principles '(coercion-indicators
                        backdating-indicators
                        fraud-indicators)
   'inference-type 'abductive
   'base-principles (list duress fraud-indicators)))

;; =============================================================================
;; MEDIUM: SETTLEMENT COERCION PATTERN
;; =============================================================================

(define settlement-coercion-pattern
  (make-principle
   'name 'settlement-coercion-pattern
   'description "Pattern of coercion during settlement negotiations"
   'domain '(contract settlement duress)
   'confidence 0.91
   'jurisdiction "za"
   'statutory-basis "Common law duress, good faith in settlement"
   'pattern-elements '(settlement-negotiation
                      document-signing-during-settlement
                      document-benefits-stronger-party
                      weaker-party-disadvantaged
                      litigation-follows-shortly
                      settlement-not-genuine)
   'temporal-pattern "Settlement negotiation → Document signing (same day) → Litigation (days)"
   'case-application "Settlement discussion 11 Aug → Backdating signed 11 Aug → Interdict 13 Aug"
   'inference "Document signing during settlement followed by litigation suggests settlement used for coercion"
   'related-principles '(coercion-indicators
                        settlement-bad-faith-indicators
                        duress)
   'inference-type 'abductive
   'base-principles (list duress bad-faith)))

;; =============================================================================
;; MEDIUM: FIDUCIARY RELATIONSHIP COERCION
;; =============================================================================

(define fiduciary-relationship-coercion
  (make-principle
   'name 'fiduciary-relationship-coercion
   'description "Coercion within fiduciary relationship context"
   'domain '(fiduciary duress undue-influence)
   'confidence 0.94
   'jurisdiction "za"
   'statutory-basis "Common law fiduciary duties, undue influence"
   'aggravating-factors '(fiduciary-has-power-over-other
                         fiduciary-benefits-from-document
                         other-party-disadvantaged
                         fiduciary-duty-breached
                         trust-relationship-abused
                         no-independent-advice)
   'fiduciary-relationships '(trustee-beneficiary
                             director-shareholder
                             attorney-client
                             guardian-ward
                             executor-beneficiary)
   'presumption "Undue influence presumed in fiduciary relationships where fiduciary benefits"
   'rebuttal "Fiduciary must prove no undue influence (independent advice, full disclosure, fair dealing)"
   'case-application "Peter (Trustee) benefits from Jax (Beneficiary) signing backdating; adverse action 2 days later; no independent advice"
   'inference "Fiduciary relationship + Benefit to fiduciary + Adverse action = Strong coercion inference"
   'related-principles '(coercion-indicators
                        fiduciary-duty
                        undue-influence
                        beneficiary-adverse-action-prohibition)
   'inference-type 'deductive
   'base-principles (list fiduciary-duty undue-influence)))

;; =============================================================================
;; PLACEHOLDER FUNCTIONS FOR FUTURE IMPLEMENTATION
;; =============================================================================

(define (detect-coercion signing-event adverse-action timing power-relationship)
  ;; Detect coercion based on temporal and power analysis
  ;; Returns: (coercion-detected? indicators correlation-strength confidence)
  'placeholder)

(define (analyze-backdating-coercion backdating signing adverse-action)
  ;; Analyze correlation between backdating and coercion
  ;; Returns: (correlation-detected? elements confidence)
  'placeholder)

(define (detect-settlement-coercion settlement signing litigation timing)
  ;; Detect coercion pattern in settlement context
  ;; Returns: (pattern-detected? elements confidence)
  'placeholder)

(define (analyze-fiduciary-coercion fiduciary-relationship document adverse-action)
  ;; Analyze coercion in fiduciary relationship context
  ;; Returns: (coercion-detected? aggravating-factors presumption confidence)
  'placeholder)

;; =============================================================================
;; INTEGRATION WITH HYPERGRAPHQL
;; =============================================================================

;; Register all principles with the principle registry
(register-principle! coercion-indicators)
(register-principle! backdating-coercion-correlation)
(register-principle! settlement-coercion-pattern)
(register-principle! fiduciary-relationship-coercion)

;; Export principles for use in other modules
(provide coercion-indicators
         backdating-coercion-correlation
         settlement-coercion-pattern
         fiduciary-relationship-coercion)

;; =============================================================================
;; END OF MODULE
;; =============================================================================
