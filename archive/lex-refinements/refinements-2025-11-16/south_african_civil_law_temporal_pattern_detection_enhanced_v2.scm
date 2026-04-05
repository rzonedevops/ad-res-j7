;; ============================================================================
;; SOUTH AFRICAN CIVIL LAW - ENHANCED TEMPORAL PATTERN DETECTION V2
;; ============================================================================
;; File: south_african_civil_law_temporal_pattern_detection_enhanced_v2.scm
;; Purpose: Advanced temporal pattern analysis for legal case timelines
;; Date: 2025-11-16
;; Confidence: 0.94
;; 
;; This module provides advanced detection of temporal patterns, including:
;; - Causation chain detection (Action → Gap → Complaint sequences)
;; - Retaliation pattern recognition (immediate and delayed)
;; - Crisis manufacturing detection
;; - Strategic timing analysis
;; - Temporal proximity scoring
;; ============================================================================

(define-module (lex civ za temporal-pattern-detection-enhanced-v2)
  #:use-module (lex lv1 known-laws)
  #:use-module (lex civ za south-african-civil-law)
  #:use-module (lex civ za south-african-civil-law-temporal-bad-faith-v3)
  #:export (
    ;; Causation Chain Detection
    detect-causation-chain
    analyze-action-gap-complaint-sequence
    calculate-causal-connection-strength
    detect-self-created-problem
    
    ;; Retaliation Pattern Recognition
    detect-retaliation-pattern
    detect-immediate-retaliation
    detect-delayed-retaliation
    detect-coordinated-retaliation
    calculate-retaliation-confidence
    
    ;; Crisis Manufacturing Detection
    detect-crisis-manufacturing
    analyze-manufactured-urgency
    detect-strategic-timing
    calculate-crisis-authenticity-score
    
    ;; Temporal Proximity Analysis
    calculate-temporal-proximity-score
    analyze-event-sequence-timing
    detect-suspicious-timing-patterns
    
    ;; Pattern Validation
    validate-temporal-pattern
    calculate-pattern-confidence
    generate-temporal-evidence-requirements
  ))

;; ============================================================================
;; PART 1: CAUSATION CHAIN DETECTION
;; ============================================================================

;; ----------------------------------------------------------------------------
;; 1.1 Causation Chain Detection
;; ----------------------------------------------------------------------------

(define (detect-causation-chain timeline actor)
  "Detects causation chains where an actor's action creates a problem,
   then uses that self-created problem as basis for complaint/litigation."
  (let* ((actor-actions (filter-actor-actions timeline actor))
         (actor-complaints (filter-actor-complaints timeline actor))
         (potential-chains (find-action-complaint-pairs actor-actions actor-complaints))
         (validated-chains (filter validate-causation-chain potential-chains))
         (chain-count (length validated-chains))
         (severity (if (> chain-count 0) 0.95 0.0)))
    
    (make-causation-result
     'actor actor
     'detected-chains validated-chains
     'chain-count chain-count
     'severity severity
     'priority (if (> chain-count 0) 'critical 'none)
     'description "Actor creates problem through own actions, then complains about it"
     'legal-principles (list
                        'self-created-problem-doctrine
                        'clean-hands-doctrine
                        'causation
                        'bad-faith)
     'confidence 0.95)))

;; ----------------------------------------------------------------------------
;; 1.2 Action-Gap-Complaint Sequence Analysis
;; ----------------------------------------------------------------------------

(define (analyze-action-gap-complaint-sequence action gap complaint)
  "Analyzes a specific Action → Gap → Complaint sequence to determine
   causal connection strength and self-creation indicators."
  (let* ((action-date (get-event-date action))
         (gap-emergence-date (get-event-date gap))
         (complaint-date (get-event-date complaint))
         (action-to-gap-days (date-difference gap-emergence-date action-date))
         (gap-to-complaint-days (date-difference complaint-date gap-emergence-date))
         (action-causes-gap (analyze-causal-link action gap))
         (gap-basis-for-complaint (analyze-complaint-basis gap complaint))
         (causal-strength (calculate-causal-connection-strength 
                          action gap complaint
                          action-to-gap-days))
         (self-created (and action-causes-gap 
                           gap-basis-for-complaint
                           (> causal-strength 0.80))))
    
    (make-sequence-analysis
     'action action
     'gap gap
     'complaint complaint
     'action-to-gap-days action-to-gap-days
     'gap-to-complaint-days gap-to-complaint-days
     'action-causes-gap action-causes-gap
     'gap-basis-for-complaint gap-basis-for-complaint
     'causal-strength causal-strength
     'self-created self-created
     'severity (if self-created 0.95 0.0)
     'evidence-required (list
                         "Timeline showing action date"
                         "Documentation of gap emergence"
                         "Complaint/litigation documents citing gap"
                         "Causal link evidence (logs, records, statements)")
     'confidence 0.95)))

;; ----------------------------------------------------------------------------
;; 1.3 Causal Connection Strength Calculation
;; ----------------------------------------------------------------------------

(define (calculate-causal-connection-strength action gap complaint temporal-proximity)
  "Calculates the strength of causal connection between action and gap."
  (let* ((temporal-factor (cond
                           ((< temporal-proximity 2) 1.0)    ; 0-1 days: immediate
                           ((< temporal-proximity 7) 0.95)   ; 2-6 days: very close
                           ((< temporal-proximity 30) 0.85)  ; 1-4 weeks: close
                           ((< temporal-proximity 90) 0.70)  ; 1-3 months: moderate
                           (else 0.50)))                     ; 3+ months: weak
         (logical-necessity (analyze-logical-necessity action gap))
         (alternative-causes (count-alternative-causes gap))
         (alternative-factor (/ 1.0 (+ 1.0 alternative-causes)))
         (causal-strength (* temporal-factor logical-necessity alternative-factor)))
    
    (make-causal-strength-result
     'temporal-factor temporal-factor
     'logical-necessity logical-necessity
     'alternative-causes alternative-causes
     'alternative-factor alternative-factor
     'causal-strength causal-strength
     'confidence 0.93)))

;; ----------------------------------------------------------------------------
;; 1.4 Self-Created Problem Detection
;; ----------------------------------------------------------------------------

(define (detect-self-created-problem timeline actor problem)
  "Detects when an actor creates a problem through their own actions,
   then uses that problem as basis for relief or complaint."
  (let* ((problem-date (get-event-date problem))
         (prior-actions (filter-prior-actions timeline actor problem-date))
         (causal-actions (filter (lambda (action)
                                   (action-causes-problem? action problem))
                                prior-actions))
         (has-self-created (> (length causal-actions) 0))
         (complaint-citing-problem (find-complaint-citing-problem timeline actor problem))
         (severity (if (and has-self-created complaint-citing-problem) 0.94 0.0)))
    
    (make-self-created-result
     'actor actor
     'problem problem
     'causal-actions causal-actions
     'has-self-created has-self-created
     'complaint-citing-problem complaint-citing-problem
     'severity severity
     'legal-principles (list
                        'self-created-problem-doctrine
                        'clean-hands-doctrine
                        'equitable-estoppel)
     'evidence-required (list
                         "Actor's actions creating problem"
                         "Timeline showing causation"
                         "Complaint/application citing problem"
                         "Absence of alternative causes")
     'confidence 0.94)))

;; ============================================================================
;; PART 2: RETALIATION PATTERN RECOGNITION
;; ============================================================================

;; ----------------------------------------------------------------------------
;; 2.1 Retaliation Pattern Detection
;; ----------------------------------------------------------------------------

(define (detect-retaliation-pattern timeline actor1 actor2)
  "Detects retaliation patterns where actor1 responds negatively to
   actor2's actions with suspicious temporal proximity."
  (let* ((actor2-trigger-events (filter-potential-trigger-events timeline actor2))
         (actor1-response-events (filter-potential-response-events timeline actor1))
         (retaliation-pairs (find-trigger-response-pairs 
                            actor2-trigger-events 
                            actor1-response-events))
         (validated-retaliations (filter validate-retaliation-pattern retaliation-pairs))
         (retaliation-count (length validated-retaliations))
         (severity (if (> retaliation-count 0)
                      (min 1.0 (* 0.90 (+ 1.0 (* 0.05 retaliation-count))))
                      0.0)))
    
    (make-retaliation-result
     'retaliator actor1
     'target actor2
     'detected-retaliations validated-retaliations
     'retaliation-count retaliation-count
     'severity severity
     'priority (if (> retaliation-count 0) 'critical 'none)
     'description "Pattern of retaliatory actions following trigger events"
     'legal-principles (list
                        'retaliation
                        'bad-faith
                        'abuse-of-power
                        'whistleblower-protection)
     'confidence 0.95)))

;; ----------------------------------------------------------------------------
;; 2.2 Immediate Retaliation Detection
;; ----------------------------------------------------------------------------

(define (detect-immediate-retaliation trigger-event response-event)
  "Detects immediate retaliation (0-2 days between trigger and response)."
  (let* ((trigger-date (get-event-date trigger-event))
         (response-date (get-event-date response-event))
         (days-between (date-difference response-date trigger-date))
         (is-immediate (<= days-between 2))
         (response-is-negative (event-is-negative? response-event))
         (response-targets-trigger-actor (event-targets-actor? 
                                          response-event 
                                          (get-event-actor trigger-event)))
         (is-retaliation (and is-immediate 
                             response-is-negative 
                             response-targets-trigger-actor))
         (confidence (if is-retaliation
                        (cond
                         ((= days-between 0) 0.99)  ; Same day
                         ((= days-between 1) 0.97)  ; Next day
                         ((= days-between 2) 0.93)  ; 2 days
                         (else 0.0))
                        0.0)))
    
    (make-immediate-retaliation-result
     'trigger-event trigger-event
     'response-event response-event
     'days-between days-between
     'is-immediate is-immediate
     'is-retaliation is-retaliation
     'severity confidence
     'confidence confidence
     'evidence-required (list
                         "Timeline showing trigger event date"
                         "Timeline showing response event date"
                         "Evidence of negative impact on trigger actor"
                         "Absence of alternative explanations")
     'description (format "Immediate retaliation: ~a day(s) between events" days-between))))

;; ----------------------------------------------------------------------------
;; 2.3 Delayed Retaliation Detection
;; ----------------------------------------------------------------------------

(define (detect-delayed-retaliation trigger-event response-event)
  "Detects delayed retaliation (3-30 days between trigger and response)."
  (let* ((trigger-date (get-event-date trigger-event))
         (response-date (get-event-date response-event))
         (days-between (date-difference response-date trigger-date))
         (is-delayed (and (> days-between 2) (<= days-between 30)))
         (response-is-negative (event-is-negative? response-event))
         (response-targets-trigger-actor (event-targets-actor? 
                                          response-event 
                                          (get-event-actor trigger-event)))
         (strategic-timing-indicators (detect-strategic-timing-indicators 
                                       trigger-event 
                                       response-event))
         (is-retaliation (and is-delayed 
                             response-is-negative 
                             response-targets-trigger-actor
                             (> (length strategic-timing-indicators) 0)))
         (confidence (if is-retaliation
                        (cond
                         ((< days-between 7) 0.89)   ; 3-6 days
                         ((< days-between 14) 0.85)  ; 1-2 weeks
                         ((< days-between 30) 0.80)  ; 2-4 weeks
                         (else 0.0))
                        0.0)))
    
    (make-delayed-retaliation-result
     'trigger-event trigger-event
     'response-event response-event
     'days-between days-between
     'is-delayed is-delayed
     'is-retaliation is-retaliation
     'strategic-timing-indicators strategic-timing-indicators
     'severity confidence
     'confidence confidence
     'description (format "Delayed retaliation: ~a day(s) between events" days-between))))

;; ----------------------------------------------------------------------------
;; 2.4 Coordinated Retaliation Detection
;; ----------------------------------------------------------------------------

(define (detect-coordinated-retaliation trigger-event response-events)
  "Detects coordinated retaliation involving multiple actors or actions."
  (let* ((trigger-date (get-event-date trigger-event))
         (response-dates (map get-event-date response-events))
         (days-from-trigger (map (lambda (date) 
                                   (date-difference date trigger-date))
                                response-dates))
         (temporal-clustering (analyze-temporal-clustering days-from-trigger))
         (actor-coordination (analyze-actor-coordination response-events))
         (is-coordinated (and (> (length response-events) 1)
                             (> temporal-clustering 0.80)
                             (> actor-coordination 0.70)))
         (severity (if is-coordinated 0.96 0.0)))
    
    (make-coordinated-retaliation-result
     'trigger-event trigger-event
     'response-events response-events
     'response-count (length response-events)
     'temporal-clustering temporal-clustering
     'actor-coordination actor-coordination
     'is-coordinated is-coordinated
     'severity severity
     'confidence 0.94
     'description "Multiple coordinated retaliatory actions")))

;; ----------------------------------------------------------------------------
;; 2.5 Retaliation Confidence Calculation
;; ----------------------------------------------------------------------------

(define (calculate-retaliation-confidence trigger-event response-event)
  "Calculates confidence score for retaliation pattern."
  (let* ((temporal-proximity (calculate-temporal-proximity trigger-event response-event))
         (negative-impact-score (calculate-negative-impact-score response-event))
         (targeting-score (calculate-targeting-score response-event trigger-event))
         (alternative-explanations (count-alternative-explanations response-event))
         (alternative-factor (/ 1.0 (+ 1.0 alternative-explanations)))
         (confidence (* temporal-proximity 
                       negative-impact-score 
                       targeting-score 
                       alternative-factor)))
    
    (make-confidence-calculation
     'temporal-proximity temporal-proximity
     'negative-impact-score negative-impact-score
     'targeting-score targeting-score
     'alternative-explanations alternative-explanations
     'alternative-factor alternative-factor
     'confidence confidence)))

;; ============================================================================
;; PART 3: CRISIS MANUFACTURING DETECTION
;; ============================================================================

;; ----------------------------------------------------------------------------
;; 3.1 Crisis Manufacturing Detection
;; ----------------------------------------------------------------------------

(define (detect-crisis-manufacturing timeline actor)
  "Detects when an actor manufactures a crisis through deliberate actions,
   then uses the manufactured crisis as basis for urgent relief."
  (let* ((actor-actions (filter-actor-actions timeline actor))
         (crisis-events (filter-crisis-events timeline))
         (urgent-applications (filter-urgent-applications timeline actor))
         (manufacturing-sequences (find-manufacturing-sequences 
                                   actor-actions 
                                   crisis-events 
                                   urgent-applications))
         (validated-sequences (filter validate-manufacturing-sequence 
                                     manufacturing-sequences))
         (has-manufacturing (> (length validated-sequences) 0))
         (severity (if has-manufacturing 0.93 0.0)))
    
    (make-manufacturing-result
     'actor actor
     'detected-sequences validated-sequences
     'sequence-count (length validated-sequences)
     'has-manufacturing has-manufacturing
     'severity severity
     'priority (if has-manufacturing 'critical 'none)
     'description "Actor manufactures crisis, then seeks urgent relief based on it"
     'legal-principles (list
                        'manufactured-crisis
                        'self-created-urgency
                        'clean-hands-doctrine
                        'bad-faith)
     'confidence 0.93)))

;; ----------------------------------------------------------------------------
;; 3.2 Manufactured Urgency Analysis
;; ----------------------------------------------------------------------------

(define (analyze-manufactured-urgency crisis-event urgent-application)
  "Analyzes whether urgency in an application is manufactured rather than genuine."
  (let* ((crisis-date (get-event-date crisis-event))
         (application-date (get-event-date urgent-application))
         (days-between (date-difference application-date crisis-date))
         (actor-caused-crisis (actor-caused-event? 
                              (get-application-actor urgent-application)
                              crisis-event))
         (alternative-remedies (identify-alternative-remedies urgent-application))
         (alternative-count (length alternative-remedies))
         (urgency-claims (extract-urgency-claims urgent-application))
         (genuine-urgency-score (calculate-genuine-urgency-score 
                                crisis-event 
                                urgency-claims))
         (is-manufactured (and actor-caused-crisis 
                              (< genuine-urgency-score 0.50)
                              (> alternative-count 0)))
         (severity (if is-manufactured 0.93 0.0)))
    
    (make-urgency-analysis
     'crisis-event crisis-event
     'urgent-application urgent-application
     'days-between days-between
     'actor-caused-crisis actor-caused-crisis
     'alternative-remedies alternative-remedies
     'genuine-urgency-score genuine-urgency-score
     'is-manufactured is-manufactured
     'severity severity
     'confidence 0.92)))

;; ----------------------------------------------------------------------------
;; 3.3 Strategic Timing Detection
;; ----------------------------------------------------------------------------

(define (detect-strategic-timing event timeline)
  "Detects strategic timing indicators suggesting deliberate timing choices
   rather than organic event occurrence."
  (let* ((event-date (get-event-date event))
         (event-actor (get-event-actor event))
         (prior-events (filter-prior-events timeline event-date))
         (subsequent-events (filter-subsequent-events timeline event-date 30))
         (timing-indicators (list
                            (detect-settlement-betrayal event prior-events)
                            (detect-litigation-timing event prior-events)
                            (detect-deadline-manipulation event prior-events)
                            (detect-power-timing event prior-events)))
         (detected-indicators (filter identity timing-indicators))
         (has-strategic-timing (> (length detected-indicators) 0))
         (severity (if has-strategic-timing 0.91 0.0)))
    
    (make-strategic-timing-result
     'event event
     'detected-indicators detected-indicators
     'indicator-count (length detected-indicators)
     'has-strategic-timing has-strategic-timing
     'severity severity
     'confidence 0.91)))

;; ----------------------------------------------------------------------------
;; 3.4 Crisis Authenticity Score Calculation
;; ----------------------------------------------------------------------------

(define (calculate-crisis-authenticity-score crisis-event actor)
  "Calculates authenticity score for a crisis (0.0 = manufactured, 1.0 = genuine)."
  (let* ((actor-caused (actor-caused-event? actor crisis-event))
         (external-factors (count-external-factors crisis-event))
         (urgency-level (calculate-urgency-level crisis-event))
         (alternative-remedies (identify-alternative-remedies-for-crisis crisis-event))
         (alternative-count (length alternative-remedies))
         (actor-factor (if actor-caused 0.20 1.0))
         (external-factor (min 1.0 (* 0.30 external-factors)))
         (urgency-factor (* 0.40 urgency-level))
         (alternative-factor (if (> alternative-count 0) 0.50 1.0))
         (authenticity-score (* actor-factor 
                               (+ external-factor urgency-factor)
                               alternative-factor)))
    
    (make-authenticity-score
     'actor-caused actor-caused
     'external-factors external-factors
     'urgency-level urgency-level
     'alternative-count alternative-count
     'authenticity-score authenticity-score
     'is-manufactured (< authenticity-score 0.50)
     'confidence 0.90)))

;; ============================================================================
;; PART 4: TEMPORAL PROXIMITY ANALYSIS
;; ============================================================================

;; ----------------------------------------------------------------------------
;; 4.1 Temporal Proximity Score Calculation
;; ----------------------------------------------------------------------------

(define (calculate-temporal-proximity-score event1 event2)
  "Calculates temporal proximity score between two events (0.0 = distant, 1.0 = immediate)."
  (let* ((date1 (get-event-date event1))
         (date2 (get-event-date event2))
         (days-between (abs (date-difference date2 date1)))
         (proximity-score (cond
                           ((= days-between 0) 1.00)    ; Same day
                           ((= days-between 1) 0.97)    ; Next day
                           ((= days-between 2) 0.93)    ; 2 days
                           ((< days-between 7) 0.85)    ; Within a week
                           ((< days-between 14) 0.75)   ; Within 2 weeks
                           ((< days-between 30) 0.60)   ; Within a month
                           ((< days-between 90) 0.40)   ; Within 3 months
                           ((< days-between 180) 0.20)  ; Within 6 months
                           (else 0.10))))               ; More than 6 months
    
    (make-proximity-score
     'event1 event1
     'event2 event2
     'days-between days-between
     'proximity-score proximity-score
     'confidence 0.98)))

;; ----------------------------------------------------------------------------
;; 4.2 Event Sequence Timing Analysis
;; ----------------------------------------------------------------------------

(define (analyze-event-sequence-timing event-sequence)
  "Analyzes timing patterns across a sequence of events."
  (let* ((dates (map get-event-date event-sequence))
         (intervals (calculate-intervals dates))
         (mean-interval (mean intervals))
         (std-dev-interval (standard-deviation intervals))
         (clustering-score (calculate-clustering-score intervals))
         (regularity-score (calculate-regularity-score intervals))
         (suspicious-patterns (detect-suspicious-interval-patterns intervals)))
    
    (make-sequence-timing-analysis
     'event-sequence event-sequence
     'intervals intervals
     'mean-interval mean-interval
     'std-dev-interval std-dev-interval
     'clustering-score clustering-score
     'regularity-score regularity-score
     'suspicious-patterns suspicious-patterns
     'confidence 0.92)))

;; ----------------------------------------------------------------------------
;; 4.3 Suspicious Timing Pattern Detection
;; ----------------------------------------------------------------------------

(define (detect-suspicious-timing-patterns timeline)
  "Detects suspicious timing patterns across entire timeline."
  (let* ((events (get-timeline-events timeline))
         (patterns (list
                   (detect-immediate-response-patterns events)
                   (detect-strategic-delay-patterns events)
                   (detect-clustering-patterns events)
                   (detect-deadline-patterns events)))
         (detected-patterns (filter (lambda (p) (> (length p) 0)) patterns))
         (has-suspicious-patterns (> (length detected-patterns) 0)))
    
    (make-suspicious-patterns-result
     'detected-patterns detected-patterns
     'pattern-count (length detected-patterns)
     'has-suspicious-patterns has-suspicious-patterns
     'confidence 0.91)))

;; ============================================================================
;; PART 5: PATTERN VALIDATION
;; ============================================================================

;; ----------------------------------------------------------------------------
;; 5.1 Temporal Pattern Validation
;; ----------------------------------------------------------------------------

(define (validate-temporal-pattern pattern)
  "Validates a detected temporal pattern against multiple criteria."
  (let* ((pattern-type (get-pattern-attribute pattern 'type))
         (temporal-criteria (validate-temporal-criteria pattern))
         (causal-criteria (validate-causal-criteria pattern))
         (alternative-explanations (count-alternative-explanations-for-pattern pattern))
         (evidence-strength (calculate-evidence-strength pattern))
         (is-valid (and temporal-criteria
                       causal-criteria
                       (< alternative-explanations 2)
                       (> evidence-strength 0.70))))
    
    (make-validation-result
     'pattern pattern
     'pattern-type pattern-type
     'temporal-criteria temporal-criteria
     'causal-criteria causal-criteria
     'alternative-explanations alternative-explanations
     'evidence-strength evidence-strength
     'is-valid is-valid
     'confidence (if is-valid 0.93 0.0))))

;; ----------------------------------------------------------------------------
;; 5.2 Pattern Confidence Calculation
;; ----------------------------------------------------------------------------

(define (calculate-pattern-confidence pattern)
  "Calculates overall confidence score for a detected pattern."
  (let* ((temporal-strength (get-pattern-attribute pattern 'temporal-strength))
         (causal-strength (get-pattern-attribute pattern 'causal-strength))
         (evidence-quality (get-pattern-attribute pattern 'evidence-quality))
         (alternative-count (get-pattern-attribute pattern 'alternative-count))
         (alternative-factor (/ 1.0 (+ 1.0 alternative-count)))
         (confidence (* 0.93 
                       temporal-strength 
                       causal-strength 
                       evidence-quality 
                       alternative-factor)))
    
    (make-confidence-result
     'temporal-strength temporal-strength
     'causal-strength causal-strength
     'evidence-quality evidence-quality
     'alternative-factor alternative-factor
     'confidence confidence)))

;; ----------------------------------------------------------------------------
;; 5.3 Temporal Evidence Requirements Generation
;; ----------------------------------------------------------------------------

(define (generate-temporal-evidence-requirements pattern)
  "Generates list of evidence requirements for proving a temporal pattern."
  (let* ((pattern-type (get-pattern-attribute pattern 'type))
         (base-requirements (list
                            "Timeline documentation with precise dates"
                            "Event sequence documentation"
                            "Actor identification for each event"))
         (type-specific-requirements
          (case pattern-type
            ((retaliation)
             (list "Trigger event documentation"
                   "Response event documentation"
                   "Evidence of negative impact"
                   "Absence of alternative explanations"))
            ((causation-chain)
             (list "Action documentation"
                   "Gap emergence documentation"
                   "Complaint/litigation documents"
                   "Causal link evidence"))
            ((crisis-manufacturing)
             (list "Crisis event documentation"
                   "Actor's prior actions documentation"
                   "Urgent application documents"
                   "Alternative remedy analysis"))
            (else (list "Pattern-specific evidence")))))
    
    (append base-requirements type-specific-requirements)))

;; ============================================================================
;; HELPER FUNCTIONS
;; ============================================================================

(define (calculate-intervals dates)
  "Calculates intervals in days between consecutive dates."
  (if (< (length dates) 2)
      '()
      (map (lambda (i)
             (date-difference (list-ref dates i)
                            (list-ref dates (- i 1))))
           (range 1 (length dates)))))

(define (calculate-clustering-score intervals)
  "Calculates clustering score for intervals (0.0 = dispersed, 1.0 = clustered)."
  (if (null? intervals)
      0.0
      (let* ((mean-interval (mean intervals))
             (deviations (map (lambda (i) (abs (- i mean-interval))) intervals))
             (mean-deviation (mean deviations))
             (clustering (- 1.0 (min 1.0 (/ mean-deviation (+ mean-interval 1))))))
        clustering)))

(define (calculate-regularity-score intervals)
  "Calculates regularity score for intervals (0.0 = irregular, 1.0 = regular)."
  (if (null? intervals)
      0.0
      (let* ((std-dev (standard-deviation intervals))
             (mean-interval (mean intervals))
             (coefficient-of-variation (if (> mean-interval 0)
                                          (/ std-dev mean-interval)
                                          1.0))
             (regularity (- 1.0 (min 1.0 coefficient-of-variation))))
        regularity)))

(define (analyze-logical-necessity action gap)
  "Analyzes logical necessity of action causing gap (0.0 = no necessity, 1.0 = necessary)."
  (let* ((action-type (get-event-attribute action 'type))
         (gap-type (get-event-attribute gap 'type))
         (necessity-mapping (get-necessity-mapping action-type gap-type))
         (logical-necessity (or necessity-mapping 0.50)))
    logical-necessity))

(define (count-alternative-causes gap)
  "Counts alternative causes for a gap besides the identified action."
  (let* ((gap-type (get-event-attribute gap 'type))
         (potential-causes (get-potential-causes gap-type))
         (alternative-count (length potential-causes)))
    alternative-count))

(define (event-is-negative? event)
  "Determines if an event has negative impact."
  (let* ((event-type (get-event-attribute event 'type))
         (negative-types '(card-cancellation system-lockout litigation 
                          revenue-hijacking asset-seizure)))
    (member event-type negative-types)))

(define (event-targets-actor? event actor)
  "Determines if an event targets a specific actor."
  (let* ((event-targets (get-event-attribute event 'targets))
         (targets-actor (member actor event-targets)))
    targets-actor))

;; ============================================================================
;; MODULE INITIALIZATION
;; ============================================================================

(define framework-metadata
  (make-hash-table
   'name "South African Civil Law - Enhanced Temporal Pattern Detection V2"
   'jurisdiction "za"
   'legal-domain '(civil)
   'version "2.0"
   'date "2025-11-16"
   'confidence-base 0.94
   'derived-from-modules '(
     "south_african_civil_law.scm"
     "south_african_civil_law_temporal_bad_faith_v3.scm"
   )))

;; Export module
(provide 'lex-civ-za-temporal-pattern-detection-enhanced-v2)
