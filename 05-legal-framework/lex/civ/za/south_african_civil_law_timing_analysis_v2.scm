;; South African Civil Law - Timing Analysis v2
;; Temporal reasoning framework for bad faith and manufactured crisis detection
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
   'name "South African Civil Law - Timing Analysis v2"
   'jurisdiction "za"
   'legal-domain '(civil-procedure bad-faith timing-analysis)
   'version "2.0"
   'last-updated "2025-10-30"
   'derived-from-level 1
   'confidence-base 0.95
   'language "en"
   'case-application "AD-RES-J7 (Case 2025-137857)"))

;; =============================================================================
;; CRITICAL: MANUFACTURED CRISIS INDICATORS
;; =============================================================================

(define manufactured-crisis-indicators
  (make-principle
   'name 'manufactured-crisis-indicators
   'description "Temporal analysis indicators of manufactured crisis for bad faith"
   'domain '(civil-procedure bad-faith timing-analysis)
   'confidence 0.96
   'jurisdiction "za"
   'statutory-basis "Common law abuse of process, venire contra factum proprium"
   'elements '(cooperation-followed-by-immediate-adverse-action
              timing-creates-problem-complained-about
              venire-contra-factum-proprium
              but-for-causation
              no-reasonable-explanation-for-timing)
   'inference "When party creates the problem they complain about, suggests manufactured crisis"
   'case-application "Dan cooperates 6 Jun, Peter cancels cards 7 Jun (next day), then complains about inaccessible documentation"
   'related-principles '(venire-contra-factum-proprium but-for-causation timing-analysis-bad-faith)
   'inference-type 'abductive
   'base-principles (list venire-contra-factum-proprium)))

;; =============================================================================
;; CRITICAL: TIMING ANALYSIS BAD FAITH
;; =============================================================================

(define timing-analysis-bad-faith
  (make-principle
   'name 'timing-analysis-bad-faith
   'description "Analysis of timing patterns to infer bad faith"
   'domain '(civil-procedure bad-faith temporal-reasoning)
   'confidence 0.96
   'jurisdiction "za"
   'statutory-basis "Common law bad faith, abuse of process"
   'patterns '(cooperation-followed-by-immediate-punishment
              request-followed-by-immediate-adverse-action
              timing-creates-complained-of-problem
              no-reasonable-explanation-for-timing
              pattern-of-strategic-timing)
   'inference-method "Temporal proximity + lack of alternative explanation = bad faith inference"
   'case-application "Dan cooperates 6 Jun → Peter cancels cards 7 Jun (next day) → Documentation inaccessible → Peter complains about documentation"
   'related-principles '(manufactured-crisis-indicators venire-contra-factum-proprium)
   'inference-type 'abductive
   'base-principles (list good-faith)))

;; =============================================================================
;; HIGH: RETALIATORY ACTION INDICATORS
;; =============================================================================

(define retaliatory-action-indicators
  (make-principle
   'name 'retaliatory-action-indicators
   'description "Indicators of retaliatory action following protected conduct"
   'domain '(employment labour-law civil-procedure)
   'confidence 0.94
   'jurisdiction "za"
   'statutory-basis "Labour Relations Act 66/1995, common law"
   'indicators '(adverse-action-follows-protected-conduct
                temporal-proximity
                no-legitimate-business-reason
                pattern-of-escalating-actions
                disproportionate-response)
   'protected-conduct '(whistleblowing
                       fraud-reporting
                       asserting-legal-rights
                       refusing-illegal-conduct)
   'case-application "Orders removed (22 May) and new domain registered (29 May) within 14 days of Jax confronting Rynette (15 May)"
   'inference "Temporal proximity + no alternative explanation = retaliatory inference"
   'related-principles '(timing-analysis-bad-faith manufactured-crisis-indicators)
   'inference-type 'inductive
   'base-principles (list good-faith)))

;; =============================================================================
;; HIGH: PRESSURE TACTICS INDICATORS
;; =============================================================================

(define pressure-tactics-indicators
  (make-principle
   'name 'pressure-tactics-indicators
   'description "Indicators of improper pressure tactics to obtain compliance"
   'domain '(contract civil-procedure undue-influence)
   'confidence 0.93
   'jurisdiction "za"
   'statutory-basis "Common law undue influence, duress"
   'indicators '(unreasonable-time-pressure
                artificial-deadline
                complex-decision-simple-timeframe
                consequences-threatened-for-non-compliance
                no-opportunity-for-review
                information-asymmetry)
   'case-application "12-hour pressure to sign off on two years of unallocated expenses"
   'inference "Pressure tactics suggest improper purpose or content"
   'related-principles '(undue-influence duress)
   'inference-type 'inductive
   'base-principles (list good-faith)))

;; =============================================================================
;; MEDIUM: FIDUCIARY DUTY TO INVESTIGATE FRAUD
;; =============================================================================

(define fiduciary-duty-to-investigate-fraud
  (make-principle
   'name 'fiduciary-duty-to-investigate-fraud
   'description "Director's duty to investigate credible fraud allegations"
   'domain '(company director-duties fiduciary)
   'confidence 0.95
   'jurisdiction "za"
   'statutory-basis "Companies Act 71/2008 s76(3)"
   'duty "Director must investigate credible fraud allegations and take appropriate action"
   'triggers '(credible-fraud-allegation
              financial-irregularities-discovered
              related-party-transaction-concerns
              whistleblower-report)
   'required-actions '(conduct-investigation
                      obtain-expert-advice
                      report-to-board
                      implement-corrective-measures
                      consider-legal-action)
   'case-application "Jax's confrontation of Rynette about ZAR 1,035,000 debt and Kayla's estate proceeds"
   'related-principles '(director-duty-of-care fiduciary-duty-of-loyalty)
   'inference-type 'deductive
   'base-principles (list fiduciary-duty)))

;; =============================================================================
;; MEDIUM: ESTATE PROCEEDS PROHIBITION
;; =============================================================================

(define estate-proceeds-prohibition
  (make-principle
   'name 'estate-proceeds-prohibition
   'description "Prohibition on profiting from estate proceeds, especially in suspicious death"
   'domain '(estate-law criminal-law public-policy)
   'confidence 0.97
   'jurisdiction "za"
   'statutory-basis "Administration of Estates Act 66/1965, common law public policy"
   'principle "No person shall profit from the proceeds of crime or suspicious death"
   'application "Funds forming part of deceased estate cannot be retained by entities without proper estate administration"
   'case-application "ZAR 1,035,000 owed by RST to Rezonance, part of Kayla's estate, retained since Feb 2023"
   'related-principles '(public-policy-prohibition unjust-enrichment-test)
   'inference-type 'deductive
   'base-principles (list public-policy)))

;; =============================================================================
;; PLACEHOLDER FUNCTIONS FOR FUTURE IMPLEMENTATION
;; =============================================================================

(define (detect-manufactured-crisis timeline events party-actions)
  ;; Analyze timeline for manufactured crisis indicators
  ;; Returns: (crisis-manufactured? indicators confidence)
  'placeholder)

(define (analyze-timing-bad-faith event1 event2 temporal-proximity context)
  ;; Analyze timing pattern for bad faith inference
  ;; Returns: (bad-faith-inferred? patterns confidence)
  'placeholder)

(define (detect-retaliatory-action protected-conduct adverse-action timing)
  ;; Detect retaliatory action following protected conduct
  ;; Returns: (retaliation-detected? indicators confidence)
  'placeholder)

(define (evaluate-pressure-tactics timeframe complexity consequences)
  ;; Evaluate whether pressure tactics were used
  ;; Returns: (pressure-detected? indicators confidence)
  'placeholder)

(define (assess-investigation-duty allegation director-actions)
  ;; Assess whether director met duty to investigate
  ;; Returns: (duty-met? required-actions taken-actions)
  'placeholder)

(define (evaluate-estate-proceeds-retention funds estate-status retention-period)
  ;; Evaluate whether retention of estate proceeds is prohibited
  ;; Returns: (prohibited? grounds confidence)
  'placeholder)

;; =============================================================================
;; INTEGRATION WITH HYPERGRAPHQL
;; =============================================================================

;; Register all principles with the principle registry
(register-principle! manufactured-crisis-indicators)
(register-principle! timing-analysis-bad-faith)
(register-principle! retaliatory-action-indicators)
(register-principle! pressure-tactics-indicators)
(register-principle! fiduciary-duty-to-investigate-fraud)
(register-principle! estate-proceeds-prohibition)

;; Export principles for use in other modules
(provide manufactured-crisis-indicators
         timing-analysis-bad-faith
         retaliatory-action-indicators
         pressure-tactics-indicators
         fiduciary-duty-to-investigate-fraud
         estate-proceeds-prohibition)

;; =============================================================================
;; END OF MODULE
;; =============================================================================
