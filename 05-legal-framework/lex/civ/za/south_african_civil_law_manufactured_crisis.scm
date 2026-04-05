;; South African Civil Law - Manufactured Crisis Indicators
;; Specialized module for detecting manufactured crises in AD-RES-J7 case
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
   'name "South African Civil Law - Manufactured Crisis Indicators"
   'jurisdiction "za"
   'legal-domain '(civil abuse-of-process bad-faith)
   'version "1.0"
   'last-updated "2025-10-31"
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
   'description "Indicators that crisis was manufactured by party now complaining"
   'domain '(abuse-of-process bad-faith temporal-analysis)
   'confidence 0.95
   'jurisdiction "za"
   'statutory-basis "Common law abuse of process, venire contra factum proprium"
   'indicators '(cooperation-followed-by-adverse-action
                self-created-problem-used-as-pretext
                timing-reveals-intent
                no-reasonable-explanation
                pattern-of-manufactured-urgency
                beneficiary-of-crisis-is-creator
                demands-documentation-made-inaccessible
                unilateral-action-without-authority
                next-day-timing-high-correlation
                creates-gap-then-complains-about-gap)
   'temporal-pattern "Cooperation event → Next-day crisis creation → Later complaint about crisis"
   'timing-thresholds '(next-day-action-very-high-correlation
                       within-week-high-correlation
                       within-month-medium-correlation)
   'case-application "Dan provides reports 6 Jun → Peter cancels cards 7 Jun (next day) → Peter demands documentation made inaccessible by card cancellations"
   'specific-examples '((cooperation-date "2025-06-06"
                        crisis-creation-date "2025-06-07"
                        timing-delta "1 day"
                        correlation-strength "very-high"
                        crisis-type "card-cancellations"
                        later-complaint "demands-documentation"
                        documentation-gap-caused-by "card-cancellations")
                       (cooperation-type "expense-allocation-12-hour-deadline"
                        cooperation-date "2025-03-30"
                        target-response "uses-time-to-investigate-fraud"
                        investigation-completion "2025-06-06"
                        crisis-creation "card-cancellations"
                        crisis-date "2025-06-07"
                        timing-pattern "cooperation-investigation-crisis"))
   'inference "When party creates problem then complains about it, suggests ulterior motive and abuse of process"
   'legal-consequences '(set-aside-action
                        personal-costs-order
                        damages-for-abuse-of-process
                        declaratory-relief)
   'related-principles '(venire-contra-factum-proprium 
                        abuse-of-process 
                        temporal-bad-faith-indicators
                        self-created-documentation-gap)
   'inference-type 'abductive
   'base-principles (list venire-contra-factum-proprium)))

;; =============================================================================
;; HIGH: SELF-CREATED DOCUMENTATION GAP
;; =============================================================================

(define self-created-documentation-gap
  (make-principle
   'name 'self-created-documentation-gap
   'description "Party creates documentation gap then complains about lack of documentation"
   'domain '(abuse-of-process bad-faith evidence)
   'confidence 0.96
   'jurisdiction "za"
   'statutory-basis "Common law abuse of process, venire contra factum proprium"
   'elements '(party-controls-access-to-documentation
              party-restricts-access
              party-later-demands-documentation
              documentation-inaccessible-due-to-party-actions
              no-reasonable-explanation
              timing-reveals-intent)
   'pattern "Control access → Restrict access → Demand documentation → Complain about lack"
   'case-application "Peter cancels business cards 7 Jun → Documentation systems disrupted → Peter demands documentation made inaccessible"
   'specific-mechanisms '(card-cancellations-disrupt-cloud-storage
                         card-cancellations-disrupt-accounting-software
                         card-cancellations-disrupt-email-services
                         card-cancellations-disrupt-payment-systems
                         system-lockouts-prevent-access
                         access-restrictions-prevent-retrieval)
   'inference "Party cannot complain of documentation gap they created"
   'remedies '(adverse-inference-against-creator
              set-aside-demands
              costs-order
              abuse-of-process-finding)
   'related-principles '(manufactured-crisis-indicators
                        venire-contra-factum-proprium
                        spoliation-of-evidence)
   'inference-type 'deductive
   'base-principles (list venire-contra-factum-proprium)))

;; =============================================================================
;; MEDIUM: COOPERATION-PUNISHMENT PATTERN
;; =============================================================================

(define cooperation-punishment-pattern
  (make-principle
   'name 'cooperation-punishment-pattern
   'description "Pattern where cooperation is met with punishment/adverse action"
   'domain '(bad-faith temporal-analysis)
   'confidence 0.93
   'jurisdiction "za"
   'statutory-basis "Common law good faith, abuse of process"
   'pattern-elements '(request-for-cooperation
                      target-cooperates
                      adverse-action-follows-cooperation
                      timing-correlation
                      no-reasonable-explanation)
   'temporal-correlation "Cooperation → Adverse action (hours to days)"
   'timing-thresholds '(same-day-very-high
                       next-day-high
                       within-week-medium)
   'case-application "Dan provides reports 6 Jun (cooperation) → Peter cancels cards 7 Jun (punishment, next day)"
   'inference "Punishment following cooperation suggests cooperation was pretext for adverse action"
   'related-principles '(manufactured-crisis-indicators
                        temporal-bad-faith-indicators
                        good-faith-requirement)
   'inference-type 'abductive
   'base-principles (list good-faith)))

;; =============================================================================
;; PLACEHOLDER FUNCTIONS FOR FUTURE IMPLEMENTATION
;; =============================================================================

(define (detect-manufactured-crisis cooperation-event crisis-event timing context)
  ;; Analyze whether crisis was manufactured
  ;; Returns: (manufactured? indicators confidence timing-correlation)
  'placeholder)

(define (analyze-self-created-documentation-gap access-control restriction demand context)
  ;; Analyze whether documentation gap was self-created
  ;; Returns: (self-created? elements mechanisms confidence)
  'placeholder)

(define (detect-cooperation-punishment-pattern cooperation adverse-action timing)
  ;; Detect pattern of cooperation followed by punishment
  ;; Returns: (pattern-detected? correlation confidence)
  'placeholder)

(define (calculate-timing-correlation event1 event2)
  ;; Calculate temporal correlation between events
  ;; Returns: (delta correlation-strength confidence)
  'placeholder)

;; =============================================================================
;; INTEGRATION WITH HYPERGRAPHQL
;; =============================================================================

;; Register all principles with the principle registry
(register-principle! manufactured-crisis-indicators)
(register-principle! self-created-documentation-gap)
(register-principle! cooperation-punishment-pattern)

;; Export principles for use in other modules
(provide manufactured-crisis-indicators
         self-created-documentation-gap
         cooperation-punishment-pattern)

;; =============================================================================
;; END OF MODULE
;; =============================================================================
