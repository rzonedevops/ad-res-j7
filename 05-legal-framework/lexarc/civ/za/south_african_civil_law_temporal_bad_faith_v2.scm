;; South African Civil Law - Temporal Bad Faith Analysis v2
;; Enhanced framework for detecting bad faith through temporal pattern analysis
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
   'name "South African Civil Law - Temporal Bad Faith Analysis v2"
   'jurisdiction "za"
   'legal-domain '(civil bad-faith temporal-analysis)
   'version "2.0"
   'last-updated "2025-10-31"
   'derived-from-level 1
   'confidence-base 0.95
   'language "en"
   'case-application "2025-137857 (Peter Faucitt v. Jacqueline & Daniel Faucitt)"))

;; =============================================================================
;; PRINCIPLE 1: MANUFACTURED CRISIS INDICATORS
;; =============================================================================

(define manufactured-crisis-indicators
  (make-principle
   'name 'manufactured-crisis-indicators
   'description "Indicators of manufactured crisis through timing of adverse actions relative to triggering events"
   'domain '(civil bad-faith temporal-analysis)
   'confidence 0.95
   'jurisdiction "za"
   'statutory-basis "Common law bad faith doctrine"
   'base-principles (list bona-fides venire-contra-factum-proprium)
   'inference-type 'abductive
   'indicators '(adverse-action-follows-exposure
                timing-correlation-strong
                no-legitimate-business-reason
                part-of-coordinated-pattern
                immediate-response
                disproportionate-action
                targets-whistleblower)
   'temporal-threshold '(days 1)
   'red-flags '((days-between-exposure-and-action <= 1)
               (legitimate-business-reason false)
               (part-of-pattern true)
               (targets-person-who-exposed true))
   'inference "Adverse action within 1 day of exposure with no legitimate reason suggests manufactured crisis and bad faith"
   'case-application "Cards cancelled 7 Jun 2025, 1 day after Dan submitted fraud reports to accountant 6 Jun 2025"
   'evidence-required '(exposure-event-with-date
                       adverse-action-with-date
                       timeline-correlation-analysis
                       absence-of-legitimate-reason
                       pattern-of-similar-actions)
   'legal-consequences '(bad-faith-inference
                        abuse-of-process
                        damages-for-malicious-action
                        punitive-costs)
   'related-principles '(fraud-exposure-retaliation-indicators 
                        bad-faith 
                        venire-contra-factum-proprium
                        abuse-of-process)))

(register-principle! manufactured-crisis-indicators)

;; =============================================================================
;; PRINCIPLE 2: FRAUD EXPOSURE RETALIATION INDICATORS
;; =============================================================================

(define fraud-exposure-retaliation-indicators
  (make-principle
   'name 'fraud-exposure-retaliation-indicators
   'description "Indicators of retaliation following fraud exposure or whistleblowing"
   'domain '(civil bad-faith fraud temporal-analysis whistleblower-protection)
   'confidence 0.96
   'jurisdiction "za"
   'statutory-basis "Common law bad faith doctrine, Protected Disclosures Act 26 of 2000"
   'base-principles (list bona-fides)
   'inference-type 'abductive
   'indicators '(fraud-reported-or-exposed
                adverse-action-follows-immediately
                action-targets-whistleblower
                no-prior-similar-action
                timing-correlation-strong
                escalating-severity
                coordinated-multi-party-action)
   'temporal-threshold '(days 1 7)
   'red-flags '((days-between-exposure-and-action <= 7)
               (targets-whistleblower true)
               (no-prior-similar-action true)
               (coordinated-action true))
   'inference "Adverse action within 1-7 days of fraud exposure targeting whistleblower suggests retaliation and bad faith"
   'case-application "Cards cancelled 7 Jun (1 day after reports 6 Jun); Orders removed 22 May (7 days after Jax confrontation 15 May)"
   'evidence-required '(fraud-exposure-documentation
                       adverse-action-documentation
                       timeline-correlation
                       targeting-of-whistleblower
                       absence-of-prior-actions)
   'legal-consequences '(retaliation-inference
                        bad-faith-finding
                        whistleblower-protection-violation
                        damages-enhanced
                        punitive-relief)
   'protected-disclosures '(fraud
                           financial-irregularities
                           breach-of-fiduciary-duty
                           criminal-conduct
                           regulatory-violations)
   'related-principles '(manufactured-crisis-indicators 
                        confrontation-retaliation-indicators
                        bad-faith
                        whistleblower-protection)))

(register-principle! fraud-exposure-retaliation-indicators)

;; =============================================================================
;; PRINCIPLE 3: CONFRONTATION RETALIATION INDICATORS
;; =============================================================================

(define confrontation-retaliation-indicators
  (make-principle
   'name 'confrontation-retaliation-indicators
   'description "Indicators of retaliation following confrontation about wrongdoing"
   'domain '(civil bad-faith temporal-analysis)
   'confidence 0.94
   'jurisdiction "za"
   'statutory-basis "Common law bad faith doctrine"
   'base-principles (list bona-fides venire-contra-factum-proprium)
   'inference-type 'abductive
   'indicators '(confrontation-about-wrongdoing
                adverse-action-follows
                action-targets-confronter
                timing-correlation
                escalating-pattern
                multiple-retaliatory-actions
                coordinated-response)
   'temporal-threshold '(days 7 14)
   'red-flags '((days-between-confrontation-and-first-action <= 7)
               (days-between-confrontation-and-second-action <= 14)
               (targets-confronter true)
               (escalating-pattern true))
   'inference "Multiple adverse actions within 7-14 days of confrontation targeting confronter suggests retaliation pattern"
   'case-application "Jax confronts Rynette 15 May 2025 → Orders removed 22 May (7 days) → New domain registered 29 May (14 days)"
   'evidence-required '(confrontation-documentation
                       adverse-actions-documentation
                       timeline-showing-pattern
                       targeting-analysis
                       escalation-analysis)
   'legal-consequences '(retaliation-inference
                        bad-faith-finding
                        pattern-of-misconduct
                        damages-for-retaliation)
   'pattern-analysis '(single-action-suspicious
                      multiple-actions-strong-evidence
                      escalating-actions-compelling-evidence)
   'related-principles '(fraud-exposure-retaliation-indicators 
                        manufactured-crisis-indicators
                        bad-faith)))

(register-principle! confrontation-retaliation-indicators)

;; =============================================================================
;; HELPER FUNCTIONS
;; =============================================================================

(define (calculate-temporal-correlation event1 event2)
  "Calculate temporal correlation strength between two events"
  (let ((days-between (calculate-days-between 
                       (get-attribute event1 'date)
                       (get-attribute event2 'date))))
    (cond
      ((<= days-between 1) 0.95)  ;; Very strong correlation
      ((<= days-between 3) 0.90)  ;; Strong correlation
      ((<= days-between 7) 0.85)  ;; Moderate correlation
      ((<= days-between 14) 0.75) ;; Weak correlation
      (else 0.50))))              ;; Minimal correlation

(define (analyze-manufactured-crisis case-facts)
  "Analyze case for manufactured crisis indicators"
  (let ((exposure-event (get-attribute case-facts 'exposure-event))
        (adverse-action (get-attribute case-facts 'adverse-action))
        (legitimate-reason (get-attribute case-facts 'legitimate-business-reason))
        (part-of-pattern (get-attribute case-facts 'part-of-coordinated-pattern)))
    (and exposure-event
         adverse-action
         (not legitimate-reason)
         part-of-pattern
         (temporal-correlation-exists? exposure-event adverse-action 1))))

(define (analyze-fraud-exposure-retaliation case-facts)
  "Analyze case for fraud exposure retaliation indicators"
  (let ((fraud-exposed (get-attribute case-facts 'fraud-reported-or-exposed))
        (adverse-action (get-attribute case-facts 'adverse-action))
        (targets-whistleblower (get-attribute case-facts 'targets-whistleblower))
        (no-prior-action (get-attribute case-facts 'no-prior-similar-action)))
    (and fraud-exposed
         adverse-action
         targets-whistleblower
         no-prior-action
         (temporal-correlation-exists? 
          (get-attribute case-facts 'exposure-date)
          (get-attribute case-facts 'action-date)
          7))))

(define (analyze-confrontation-retaliation case-facts)
  "Analyze case for confrontation retaliation indicators"
  (let ((confrontation (get-attribute case-facts 'confrontation-about-wrongdoing))
        (adverse-actions (get-attribute case-facts 'adverse-actions-list))
        (targets-confronter (get-attribute case-facts 'targets-confronter))
        (escalating (get-attribute case-facts 'escalating-pattern)))
    (and confrontation
         (>= (length adverse-actions) 2)  ;; Multiple actions strengthen inference
         targets-confronter
         escalating
         (all-within-threshold? adverse-actions 
                               (get-attribute case-facts 'confrontation-date)
                               14))))

(define (all-within-threshold? actions reference-date threshold-days)
  "Check if all actions are within threshold days of reference date"
  (all (map (lambda (action)
              (temporal-correlation-exists? 
               reference-date 
               (get-attribute action 'date)
               threshold-days))
            actions)))

;; =============================================================================
;; PATTERN DETECTION FUNCTIONS
;; =============================================================================

(define (detect-retaliation-pattern case-facts)
  "Detect overall retaliation pattern across multiple events"
  (let ((manufactured-crisis (analyze-manufactured-crisis case-facts))
        (fraud-retaliation (analyze-fraud-exposure-retaliation case-facts))
        (confrontation-retaliation (analyze-confrontation-retaliation case-facts)))
    (list
     (list 'manufactured-crisis manufactured-crisis)
     (list 'fraud-retaliation fraud-retaliation)
     (list 'confrontation-retaliation confrontation-retaliation)
     (list 'overall-pattern-strength 
           (if (>= (count-true (list manufactured-crisis 
                                    fraud-retaliation 
                                    confrontation-retaliation)) 2)
               'strong
               'moderate)))))

(define (count-true boolean-list)
  "Count number of true values in list"
  (length (filter identity boolean-list)))

;; =============================================================================
;; TIMELINE ANALYSIS FUNCTIONS
;; =============================================================================

(define (build-temporal-timeline events)
  "Build temporal timeline from events with correlation analysis"
  (let ((sorted-events (sort-by-date events)))
    (map (lambda (event)
           (list event
                 (find-correlated-events event sorted-events)
                 (calculate-correlation-strength event sorted-events)))
         sorted-events)))

(define (find-correlated-events target-event all-events)
  "Find events temporally correlated with target event"
  (filter (lambda (event)
            (and (not (equal? event target-event))
                 (temporal-correlation-exists? target-event event 14)))
          all-events))

(define (calculate-correlation-strength event correlated-events)
  "Calculate overall correlation strength for event"
  (if (null? correlated-events)
      0.0
      (/ (apply + (map (lambda (e) (calculate-temporal-correlation event e))
                      correlated-events))
         (length correlated-events))))

;; =============================================================================
;; CONFIDENCE CALCULATION
;; =============================================================================

(define (compute-bad-faith-confidence base-confidence temporal-factors)
  "Compute confidence for bad faith inference based on temporal factors"
  (let ((correlation-strength (get-attribute temporal-factors 'correlation-strength))
        (pattern-consistency (get-attribute temporal-factors 'pattern-consistency))
        (evidence-quality (get-attribute temporal-factors 'evidence-quality))
        (multiple-incidents (get-attribute temporal-factors 'multiple-incidents)))
    (* base-confidence 
       correlation-strength 
       pattern-consistency 
       evidence-quality
       (if multiple-incidents 1.05 1.0))))  ;; Boost for multiple incidents

;; =============================================================================
;; CASE APPLICATION FUNCTIONS
;; =============================================================================

(define (apply-temporal-bad-faith-principles case-facts)
  "Apply all temporal bad faith principles to case facts"
  (list
   (list 'manufactured-crisis-indicators
         (analyze-manufactured-crisis case-facts)
         (compute-bad-faith-confidence 0.95 case-facts))
   (list 'fraud-exposure-retaliation-indicators
         (analyze-fraud-exposure-retaliation case-facts)
         (compute-bad-faith-confidence 0.96 case-facts))
   (list 'confrontation-retaliation-indicators
         (analyze-confrontation-retaliation case-facts)
         (compute-bad-faith-confidence 0.94 case-facts))
   (list 'overall-retaliation-pattern
         (detect-retaliation-pattern case-facts)
         (compute-bad-faith-confidence 0.95 case-facts))))

;; =============================================================================
;; EXPORT PRINCIPLES
;; =============================================================================

(provide manufactured-crisis-indicators
         fraud-exposure-retaliation-indicators
         confrontation-retaliation-indicators
         analyze-manufactured-crisis
         analyze-fraud-exposure-retaliation
         analyze-confrontation-retaliation
         detect-retaliation-pattern
         build-temporal-timeline
         apply-temporal-bad-faith-principles)
