;; South African Civil Law - Temporal Bad Faith Indicators
;; Specialized module for temporal pattern analysis revealing bad faith in AD-RES-J7 case
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
   'name "South African Civil Law - Temporal Bad Faith Indicators"
   'jurisdiction "za"
   'legal-domain '(civil bad-faith temporal-analysis)
   'version "1.0"
   'last-updated "2025-10-31"
   'derived-from-level 1
   'confidence-base 0.94
   'language "en"
   'case-application "AD-RES-J7 (Case 2025-137857)"))

;; =============================================================================
;; CRITICAL: TEMPORAL BAD FAITH INDICATORS
;; =============================================================================

(define temporal-bad-faith-indicators
  (make-principle
   'name 'temporal-bad-faith-indicators
   'description "Temporal patterns that reveal bad faith intent"
   'domain '(bad-faith temporal-analysis abuse-of-process)
   'confidence 0.94
   'jurisdiction "za"
   'statutory-basis "Common law bad faith, abuse of process"
   'temporal-patterns '(cooperation-followed-by-punishment
                       settlement-followed-by-litigation
                       discovery-followed-by-destruction
                       compliance-followed-by-new-demands
                       good-faith-met-with-bad-faith
                       exposure-followed-by-retaliation
                       signing-followed-by-adverse-action
                       negotiation-followed-by-attack)
   'timing-thresholds '(same-day-very-high-correlation
                       next-day-very-high-correlation
                       within-2-days-high-correlation
                       within-week-medium-correlation
                       within-month-low-correlation)
   'correlation-strength-calculation '(delta-days correlation-strength
                                       0-1 "very-high"
                                       2-3 "high"
                                       4-7 "medium-high"
                                       8-14 "medium"
                                       15-30 "low-medium"
                                       31+ "low")
   'inference "Timing patterns reveal intent incompatible with stated purpose"
   'case-applications '((pattern "cooperation-followed-by-punishment"
                        event1 "Dan provides reports"
                        date1 "2025-06-06"
                        event2 "Peter cancels cards"
                        date2 "2025-06-07"
                        delta "1 day"
                        correlation "very-high"
                        inference "Cooperation used as pretext for punishment")
                       (pattern "settlement-followed-by-litigation"
                        event1 "Settlement discussion"
                        date1 "2025-08-11"
                        event2 "Interdict filed"
                        date2 "2025-08-13"
                        delta "2 days"
                        correlation "high"
                        inference "Settlement not genuine, used as setup")
                       (pattern "signing-followed-by-adverse-action"
                        event1 "Jax signs backdating"
                        date1 "2025-08-11"
                        event2 "Jax included in interdict"
                        date2 "2025-08-13"
                        delta "2 days"
                        correlation "high"
                        inference "Signing coerced, adverse action reveals duress")
                       (pattern "exposure-followed-by-retaliation"
                        event1 "Jax confronts Rynette"
                        date1 "2025-05-15"
                        event2 "Shopify orders removed"
                        date2 "2025-05-22"
                        delta "7 days"
                        correlation "medium-high"
                        inference "Retaliation for whistleblowing"))
   'multi-pattern-analysis "Multiple temporal patterns strengthen bad faith inference"
   'pattern-count-confidence '(1-pattern 0.85
                              2-patterns 0.90
                              3-patterns 0.94
                              4-plus-patterns 0.97)
   'legal-consequences '(bad-faith-finding
                        set-aside-action
                        personal-costs-order
                        punitive-damages
                        declaratory-relief)
   'related-principles '(bad-faith
                        manufactured-crisis-indicators
                        abuse-of-process
                        retaliatory-action-indicators
                        settlement-bad-faith-indicators)
   'inference-type 'abductive
   'base-principles (list bad-faith)))

;; =============================================================================
;; HIGH: URGENCY CLAIM VS ACTUAL DELAY ANALYSIS
;; =============================================================================

(define urgency-claim-vs-actual-delay
  (make-principle
   'name 'urgency-claim-vs-actual-delay
   'description "Analysis of stated urgency versus actual delay before action"
   'domain '(abuse-of-process bad-faith temporal-analysis)
   'confidence 0.93
   'jurisdiction "za"
   'statutory-basis "Common law abuse of process, urgent application requirements"
   'elements '(stated-urgency-claim
              actual-delay-before-action
              no-emergency-measures-taken
              timing-reveals-non-urgent
              delay-inconsistent-with-urgency
              strategic-timing-revealed)
   'delay-thresholds '(0-7-days "potentially-urgent"
                      8-30-days "questionable-urgency"
                      31-60-days "urgency-negated"
                      61-plus-days "clearly-non-urgent")
   'case-application "Peter claims urgency in interdict but delayed 2 months from alleged issues (Jun to Aug 2025); timing correlates with settlement negotiation and investment payout (May 2026)"
   'specific-analysis '(alleged-issue-date "2025-06-07"
                       action-date "2025-08-13"
                       delay "67 days"
                       urgency-claim "urgent-interdict"
                       actual-urgency "clearly-non-urgent"
                       strategic-timing "settlement-negotiation"
                       financial-correlation "investment-payout-9-months")
   'inference "Significant delay negates urgency claim and reveals strategic timing"
   'related-principles '(temporal-bad-faith-indicators
                        manufactured-urgency-indicators
                        abuse-of-process)
   'inference-type 'deductive
   'base-principles (list abuse-of-process)))

;; =============================================================================
;; HIGH: MANUFACTURED URGENCY INDICATORS
;; =============================================================================

(define manufactured-urgency-indicators
  (make-principle
   'name 'manufactured-urgency-indicators
   'description "Indicators that urgency was manufactured rather than genuine"
   'domain '(abuse-of-process temporal-analysis)
   'confidence 0.92
   'jurisdiction "za"
   'statutory-basis "Common law abuse of process, urgent application requirements"
   'indicators '(delay-before-claiming-urgency
                timing-correlates-with-other-objectives
                no-emergency-measures-before-court
                urgency-claim-inconsistent-with-conduct
                party-created-urgency-through-own-actions
                strategic-timing-revealed
                concurrent-non-urgent-actions)
   'pattern "Delay → Strategic timing point → Sudden urgency claim"
   'case-application "Peter delays 2 months, then claims urgency 2 days after settlement discussion, 9 months before investment payout"
   'inference "Manufactured urgency serves strategic purpose, not genuine emergency"
   'related-principles '(urgency-claim-vs-actual-delay
                        temporal-bad-faith-indicators
                        abuse-of-process)
   'inference-type 'abductive
   'base-principles (list abuse-of-process)))

;; =============================================================================
;; MEDIUM: FINANCIAL EVENT TIMING CORRELATION
;; =============================================================================

(define financial-event-timing-correlation
  (make-principle
   'name 'financial-event-timing-correlation
   'description "Correlation between litigation timing and financial events"
   'domain '(temporal-analysis ulterior-motive)
   'confidence 0.91
   'jurisdiction "za"
   'statutory-basis "Common law proper purpose, abuse of process"
   'correlation-types '(litigation-before-payment-due
                       litigation-before-investment-payout
                       litigation-before-financial-deadline
                       litigation-timing-maximizes-financial-advantage
                       litigation-prevents-financial-transaction)
   'timing-analysis "Litigation date → Financial event date → Calculate correlation"
   'case-application "Interdict 13 Aug 2025 → Investment payout May 2026 (9 months) → Correlation suggests financial motive"
   'inference "Litigation timing correlating with financial events suggests ulterior financial motive"
   'related-principles '(temporal-bad-faith-indicators
                        ulterior-motive-analysis
                        proper-purpose-test)
   'inference-type 'abductive
   'base-principles (list proper-purpose)))

;; =============================================================================
;; PLACEHOLDER FUNCTIONS FOR FUTURE IMPLEMENTATION
;; =============================================================================

(define (detect-temporal-bad-faith-pattern event1 event2 pattern-type)
  ;; Detect specific temporal bad faith pattern
  ;; Returns: (pattern-detected? delta correlation-strength confidence)
  'placeholder)

(define (analyze-urgency-vs-delay urgency-claim issue-date action-date)
  ;; Analyze stated urgency versus actual delay
  ;; Returns: (urgency-negated? delay-days delay-category confidence)
  'placeholder)

(define (detect-manufactured-urgency delay strategic-timing concurrent-actions)
  ;; Detect manufactured urgency
  ;; Returns: (manufactured? indicators confidence)
  'placeholder)

(define (correlate-financial-event-timing litigation-date financial-event-date)
  ;; Correlate litigation timing with financial events
  ;; Returns: (correlation-detected? correlation-type confidence)
  'placeholder)

(define (calculate-pattern-confidence pattern-count patterns)
  ;; Calculate confidence based on number of temporal patterns
  ;; Returns: (overall-confidence pattern-analysis)
  'placeholder)

;; =============================================================================
;; INTEGRATION WITH HYPERGRAPHQL
;; =============================================================================

;; Register all principles with the principle registry
(register-principle! temporal-bad-faith-indicators)
(register-principle! urgency-claim-vs-actual-delay)
(register-principle! manufactured-urgency-indicators)
(register-principle! financial-event-timing-correlation)

;; Export principles for use in other modules
(provide temporal-bad-faith-indicators
         urgency-claim-vs-actual-delay
         manufactured-urgency-indicators
         financial-event-timing-correlation)

;; =============================================================================
;; END OF MODULE
;; =============================================================================
