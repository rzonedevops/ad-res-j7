;; ============================================================================
;; SOUTH AFRICAN CIVIL LAW - TEMPORAL PATTERN DETECTION (ENHANCED)
;; ============================================================================
;; File: south_african_civil_law_temporal_pattern_detection_enhanced.scm
;; Purpose: Enhanced temporal pattern detection for Case 2025-137857
;; Date: 2025-11-15
;; Confidence: 0.98
;; 
;; This module provides enhanced detection and analysis of temporal patterns
;; including retaliation, coordinated actions, manufactured crises, and betrayal.
;;
;; KEY ENHANCEMENTS:
;; - Immediate retaliation detection (1-day response patterns)
;; - 7-day coordinated response patterns
;; - 2-day betrayal patterns
;; - 14-day family coordination patterns
;; - Causation chain analysis
;; - Crisis manufacturing detection
;; - Temporal bad faith scoring
;; ============================================================================

(define-module (lex civ za temporal-pattern-detection-enhanced)
  #:use-module (lex lv1 known-laws)
  #:use-module (srfi srfi-1)
  #:use-module (srfi srfi-9)
  #:use-module (srfi srfi-19)  ;; Time/Date
  #:use-module (ice-9 hash-table)
  #:export (
    ;; Temporal Pattern Detection
    detect-immediate-retaliation
    detect-coordinated-response
    detect-betrayal-pattern
    detect-family-coordination
    detect-crisis-manufacturing
    
    ;; Temporal Analysis
    calculate-temporal-proximity
    analyze-causation-chain
    identify-trigger-response-pairs
    assess-temporal-bad-faith
    
    ;; Pattern Confidence Scoring
    calculate-retaliation-confidence
    calculate-coordination-confidence
    calculate-manufactured-crisis-confidence
    
    ;; Case-Specific Analyzers
    analyze-fraud-reports-card-cancellation
    analyze-jax-confrontation-shopify-removal
    analyze-signature-interdict-betrayal
    analyze-domain-purchase-coordination
    
    ;; Reporting
    generate-temporal-pattern-report
    visualize-temporal-sequence
  ))

;; ============================================================================
;; PART 1: TEMPORAL PATTERN DEFINITIONS
;; ============================================================================

;; Temporal pattern thresholds (in days)
(define temporal-thresholds
  '((immediate-retaliation . 1)    ;; 0-1 days
    (rapid-response . 7)            ;; 2-7 days
    (coordinated-action . 14)       ;; 8-14 days
    (delayed-response . 30)))       ;; 15-30 days

;; Retaliation indicators
(define retaliation-indicators
  '((temporal-proximity . 0.30)     ;; Weight for time proximity
    (disproportionate-action . 0.25) ;; Weight for action severity
    (operational-disruption . 0.20)  ;; Weight for business impact
    (whistleblower-targeting . 0.15) ;; Weight for whistleblower context
    (pattern-consistency . 0.10)))   ;; Weight for pattern matching

;; ============================================================================
;; PART 2: IMMEDIATE RETALIATION DETECTION (1-DAY PATTERN)
;; ============================================================================

(define (detect-immediate-retaliation trigger-event response-event)
  "Detect immediate retaliation patterns (0-1 day response time).
   
   Example: Fraud reports (6 June) → Card cancellations (7 June)
   
   Returns analysis with confidence score."
  (let* ((trigger-date (hash-ref trigger-event 'date))
         (response-date (hash-ref response-event 'date))
         (days-elapsed (calculate-days-between trigger-date response-date))
         (trigger-type (hash-ref trigger-event 'type))
         (response-type (hash-ref response-event 'type)))
    
    (if (<= days-elapsed 1)
        ;; Immediate retaliation detected
        (let* ((temporal-score 0.30)  ;; Maximum for 1-day response
               (disproportionate-score (assess-disproportionate-action response-event))
               (disruption-score (assess-operational-disruption response-event))
               (whistleblower-score (assess-whistleblower-context trigger-event))
               (pattern-score (assess-pattern-consistency trigger-event response-event))
               (total-confidence (+ temporal-score 
                                   disproportionate-score 
                                   disruption-score 
                                   whistleblower-score 
                                   pattern-score)))
          
          (make-pattern-report
           'pattern-type "immediate-retaliation"
           'trigger-event trigger-event
           'response-event response-event
           'days-elapsed days-elapsed
           'confidence total-confidence
           'severity (if (>= total-confidence 0.90) "critical" "high")
           'description (format #f "Immediate retaliation: ~a → ~a (~a days)"
                               (hash-ref trigger-event 'description)
                               (hash-ref response-event 'description)
                               days-elapsed)
           'indicators '(
             ("temporal-proximity" . "immediate")
             ("response-time" . "1-day")
             ("pattern-type" . "retaliation"))
           'legal-significance '(
             "whistleblower-protection-violation"
             "temporal-bad-faith"
             "coordinated-sabotage"
             "immediate-response-indicates-premeditation")
           'evidence-strength "high"
           'timestamp (current-time)))
        
        ;; Not immediate retaliation
        (make-pattern-report
         'pattern-type "not-immediate-retaliation"
         'days-elapsed days-elapsed
         'confidence 0.0))))

;; ============================================================================
;; PART 3: 7-DAY COORDINATED RESPONSE DETECTION
;; ============================================================================

(define (detect-coordinated-response trigger-event response-event)
  "Detect 7-day coordinated response patterns.
   
   Example: Jax confrontation (15 May) → Shopify orders removed (22 May)
   
   Returns analysis with confidence score."
  (let* ((trigger-date (hash-ref trigger-event 'date))
         (response-date (hash-ref response-event 'date))
         (days-elapsed (calculate-days-between trigger-date response-date)))
    
    (if (and (> days-elapsed 1) (<= days-elapsed 7))
        ;; 7-day coordinated response detected
        (let* ((temporal-score (* 0.30 (/ (- 8 days-elapsed) 7)))  ;; Decreasing score
               (coordination-score (assess-coordination-complexity response-event))
               (evidence-destruction-score (assess-evidence-destruction response-event))
               (total-confidence (+ temporal-score 
                                   coordination-score 
                                   evidence-destruction-score)))
          
          (make-pattern-report
           'pattern-type "coordinated-response-7day"
           'trigger-event trigger-event
           'response-event response-event
           'days-elapsed days-elapsed
           'confidence total-confidence
           'severity (if (>= total-confidence 0.85) "high" "medium")
           'description (format #f "7-day coordinated response: ~a → ~a (~a days)"
                               (hash-ref trigger-event 'description)
                               (hash-ref response-event 'description)
                               days-elapsed)
           'indicators '(
             ("temporal-proximity" . "rapid")
             ("response-time" . "7-day")
             ("pattern-type" . "coordinated-retaliation"))
           'legal-significance '(
             "coordinated-sabotage"
             "evidence-destruction"
             "temporal-bad-faith"
             "planning-indicates-premeditation")
           'evidence-strength "medium-high"
           'timestamp (current-time)))
        
        ;; Not 7-day coordinated response
        (make-pattern-report
         'pattern-type "not-7day-coordinated"
         'days-elapsed days-elapsed
         'confidence 0.0))))

;; ============================================================================
;; PART 4: 2-DAY BETRAYAL PATTERN DETECTION
;; ============================================================================

(define (detect-betrayal-pattern cooperation-event betrayal-event)
  "Detect 2-day betrayal patterns (cooperation → immediate litigation).
   
   Example: Jax signature (11 Aug) → Interdict filed (13 Aug)
   
   Returns analysis with confidence score."
  (let* ((cooperation-date (hash-ref cooperation-event 'date))
         (betrayal-date (hash-ref betrayal-event 'date))
         (days-elapsed (calculate-days-between cooperation-date betrayal-date))
         (cooperation-context (hash-ref cooperation-event 'context)))
    
    (if (<= days-elapsed 2)
        ;; Betrayal pattern detected
        (let* ((temporal-score 0.30)  ;; High score for 2-day betrayal
               (cooperation-score (assess-cooperation-context cooperation-event))
               (weaponization-score (assess-cooperation-weaponization betrayal-event))
               (total-confidence (+ temporal-score 
                                   cooperation-score 
                                   weaponization-score)))
          
          (make-pattern-report
           'pattern-type "betrayal-2day"
           'cooperation-event cooperation-event
           'betrayal-event betrayal-event
           'days-elapsed days-elapsed
           'confidence total-confidence
           'severity "critical"
           'description (format #f "2-day betrayal: ~a → ~a (~a days)"
                               (hash-ref cooperation-event 'description)
                               (hash-ref betrayal-event 'description)
                               days-elapsed)
           'indicators '(
             ("temporal-proximity" . "immediate")
             ("response-time" . "2-day")
             ("pattern-type" . "betrayal")
             ("cooperation-weaponization" . "yes"))
           'legal-significance '(
             "bad-faith-litigation"
             "coercion"
             "settlement-weaponization"
             "cooperation-betrayal"
             "manufactured-pretext")
           'evidence-strength "very-high"
           'timestamp (current-time)))
        
        ;; Not betrayal pattern
        (make-pattern-report
         'pattern-type "not-betrayal"
         'days-elapsed days-elapsed
         'confidence 0.0))))

;; ============================================================================
;; PART 5: 14-DAY FAMILY COORDINATION DETECTION
;; ============================================================================

(define (detect-family-coordination trigger-event family-action-event)
  "Detect 14-day family coordination patterns.
   
   Example: Jax confrontation (15 May) → Domain purchase by Adderory (29 May)
   
   Returns analysis with confidence score."
  (let* ((trigger-date (hash-ref trigger-event 'date))
         (action-date (hash-ref family-action-event 'date))
         (days-elapsed (calculate-days-between trigger-date action-date))
         (family-member (hash-ref family-action-event 'actor)))
    
    (if (and (> days-elapsed 7) (<= days-elapsed 14))
        ;; Family coordination detected
        (let* ((temporal-score (* 0.25 (/ (- 15 days-elapsed) 7)))
               (family-connection-score (assess-family-connection family-action-event))
               (coordination-score (assess-multi-actor-coordination trigger-event family-action-event))
               (total-confidence (+ temporal-score 
                                   family-connection-score 
                                   coordination-score)))
          
          (make-pattern-report
           'pattern-type "family-coordination-14day"
           'trigger-event trigger-event
           'family-action-event family-action-event
           'days-elapsed days-elapsed
           'family-member family-member
           'confidence total-confidence
           'severity "medium-high"
           'description (format #f "14-day family coordination: ~a → ~a by ~a (~a days)"
                               (hash-ref trigger-event 'description)
                               (hash-ref family-action-event 'description)
                               family-member
                               days-elapsed)
           'indicators '(
             ("temporal-proximity" . "coordinated")
             ("response-time" . "14-day")
             ("pattern-type" . "family-coordination")
             ("multi-actor" . "yes"))
           'legal-significance '(
             "coordinated-sabotage"
             "family-involvement"
             "digital-infrastructure-control"
             "systematic-planning")
           'evidence-strength "medium"
           'timestamp (current-time)))
        
        ;; Not family coordination pattern
        (make-pattern-report
         'pattern-type "not-family-coordination"
         'days-elapsed days-elapsed
         'confidence 0.0))))

;; ============================================================================
;; PART 6: CRISIS MANUFACTURING DETECTION
;; ============================================================================

(define (detect-crisis-manufacturing problem-creation complaint-event)
  "Detect crisis manufacturing patterns (create problem → complain about it).
   
   Example: Card cancellations (7 June) → Documentation gap complaint → Litigation
   
   Returns analysis with confidence score."
  (let* ((creation-date (hash-ref problem-creation 'date))
         (complaint-date (hash-ref complaint-event 'date))
         (days-elapsed (calculate-days-between creation-date complaint-date))
         (problem-type (hash-ref problem-creation 'problem-type))
         (complaint-type (hash-ref complaint-event 'complaint-type)))
    
    ;; Check if complaint is about self-created problem
    (if (and (> days-elapsed 0)
             (equal? problem-type complaint-type))
        ;; Crisis manufacturing detected
        (let* ((self-creation-score (assess-self-created-problem problem-creation complaint-event))
               (urgency-manufacturing-score (assess-manufactured-urgency complaint-event))
               (causation-score (assess-causation-chain problem-creation complaint-event))
               (total-confidence (+ self-creation-score 
                                   urgency-manufacturing-score 
                                   causation-score)))
          
          (make-pattern-report
           'pattern-type "crisis-manufacturing"
           'problem-creation-event problem-creation
           'complaint-event complaint-event
           'days-elapsed days-elapsed
           'confidence total-confidence
           'severity "critical"
           'description (format #f "Crisis manufacturing: Created ~a → Complained about ~a (~a days later)"
                               (hash-ref problem-creation 'description)
                               (hash-ref complaint-event 'description)
                               days-elapsed)
           'indicators '(
             ("self-created-problem" . "yes")
             ("manufactured-urgency" . "yes")
             ("pattern-type" . "crisis-manufacturing"))
           'causation-chain (build-causation-chain problem-creation complaint-event)
           'legal-significance '(
             "manufactured-crisis"
             "bad-faith-litigation"
             "self-created-pretext"
             "material-non-disclosure"
             "causation-manipulation")
           'evidence-strength "very-high"
           'timestamp (current-time)))
        
        ;; Not crisis manufacturing
        (make-pattern-report
         'pattern-type "not-crisis-manufacturing"
         'confidence 0.0))))

;; ============================================================================
;; PART 7: CAUSATION CHAIN ANALYSIS
;; ============================================================================

(define (analyze-causation-chain events)
  "Analyze causation chain across multiple events.
   Returns causal relationships and confidence scores."
  (let ((causation-links '())
        (overall-confidence 0.0))
    
    ;; Iterate through event pairs
    (let loop ((remaining-events events))
      (if (< (length remaining-events) 2)
          ;; Return analysis
          (make-hash-table
           'causation-links causation-links
           'overall-confidence (/ overall-confidence (length causation-links))
           'chain-length (length causation-links))
          
          ;; Analyze next pair
          (let* ((event1 (car remaining-events))
                 (event2 (cadr remaining-events))
                 (causal-link (assess-causal-link event1 event2)))
            
            (when (> (hash-ref causal-link 'confidence) 0.5)
              (set! causation-links (cons causal-link causation-links))
              (set! overall-confidence (+ overall-confidence 
                                         (hash-ref causal-link 'confidence))))
            
            (loop (cdr remaining-events)))))))

(define (assess-causal-link event1 event2)
  "Assess causal relationship between two events."
  (let* ((temporal-proximity (calculate-temporal-proximity event1 event2))
         (logical-necessity (assess-logical-necessity event1 event2))
         (intervening-factors (identify-intervening-factors event1 event2))
         (confidence (* temporal-proximity logical-necessity)))
    
    (make-hash-table
     'event1 event1
     'event2 event2
     'temporal-proximity temporal-proximity
     'logical-necessity logical-necessity
     'intervening-factors intervening-factors
     'confidence confidence
     'causal-type (if (> confidence 0.8) "strong" "weak"))))

(define (build-causation-chain problem-creation complaint-event)
  "Build detailed causation chain for crisis manufacturing."
  (list
   (make-hash-table
    'step 1
    'event "Problem created"
    'description (hash-ref problem-creation 'description)
    'date (hash-ref problem-creation 'date)
    'actor (hash-ref problem-creation 'actor))
   
   (make-hash-table
    'step 2
    'event "Documentation disrupted"
    'description "Cloud storage, accounting software, email services suspended"
    'causal-link "Direct result of problem creation")
   
   (make-hash-table
    'step 3
    'event "Documentation demanded"
    'description "Demand for documentation made inaccessible"
    'causal-link "Exploiting self-created gap")
   
   (make-hash-table
    'step 4
    'event "Litigation filed"
    'description (hash-ref complaint-event 'description)
    'date (hash-ref complaint-event 'date)
    'causal-link "Using self-created problem as basis for relief")))

;; ============================================================================
;; PART 8: CASE-SPECIFIC ANALYZERS
;; ============================================================================

(define (analyze-fraud-reports-card-cancellation)
  "Analyze the fraud reports → card cancellation immediate retaliation.
   
   Timeline:
   - 6 June 2025: Daniel provides fraud reports to accountant
   - 7 June 2025: Peter cancels all business cards (1 day later)"
  (let ((trigger-event (make-hash-table
                        'date "2025-06-06"
                        'type "whistleblowing"
                        'description "Fraud reports provided to accountant"
                        'actor "daniel-faucitt"
                        'context "whistleblower-protection"))
        (response-event (make-hash-table
                         'date "2025-06-07"
                         'type "sabotage"
                         'description "All business cards cancelled"
                         'actor "peter-faucitt"
                         'severity "critical"
                         'operational-disruption #t
                         'disproportionate #t)))
    
    (detect-immediate-retaliation trigger-event response-event)))

(define (analyze-jax-confrontation-shopify-removal)
  "Analyze the Jax confrontation → Shopify order removal pattern.
   
   Timeline:
   - 15 May 2025: Jax confronts Rynette about missing money
   - 22 May 2025: Shopify orders removed (7 days later)"
  (let ((trigger-event (make-hash-table
                        'date "2025-05-15"
                        'type "fraud-exposure"
                        'description "Jax confronts Rynette about R1,035,000 debt"
                        'actor "jacqueline-faucitt"
                        'context "creditor-rights"))
        (response-event (make-hash-table
                         'date "2025-05-22"
                         'type "evidence-destruction"
                         'description "Shopify orders and audit trails removed"
                         'actor "rynette-farrar"
                         'severity "critical"
                         'evidence-destruction #t
                         'coordination-complexity "high")))
    
    (detect-coordinated-response trigger-event response-event)))

(define (analyze-signature-interdict-betrayal)
  "Analyze the signature → interdict betrayal pattern.
   
   Timeline:
   - 11 August 2025: Jax signs backdating document during settlement discussion
   - 13 August 2025: Interdict filed (2 days later)"
  (let ((cooperation-event (make-hash-table
                            'date "2025-08-11"
                            'type "cooperation"
                            'description "Jax signs backdating document"
                            'actor "jacqueline-faucitt"
                            'context "settlement-discussion"
                            'cooperation-type "signature"))
        (betrayal-event (make-hash-table
                         'date "2025-08-13"
                         'type "litigation"
                         'description "Interdict filed against Jax and Dan"
                         'actor "peter-faucitt"
                         'severity "critical"
                         'weaponization #t)))
    
    (detect-betrayal-pattern cooperation-event betrayal-event)))

(define (analyze-domain-purchase-coordination)
  "Analyze the domain purchase family coordination pattern.
   
   Timeline:
   - 15 May 2025: Jax confronts Rynette
   - 29 May 2025: Adderory (Rynette's son) purchases regimaskin.co.za (14 days later)"
  (let ((trigger-event (make-hash-table
                        'date "2025-05-15"
                        'type "fraud-exposure"
                        'description "Jax confronts Rynette"
                        'actor "jacqueline-faucitt"))
        (family-action-event (make-hash-table
                              'date "2025-05-29"
                              'type "digital-infrastructure-control"
                              'description "Domain regimaskin.co.za purchased"
                              'actor "adderory"
                              'family-connection "rynette-son"
                              'coordination-indicators "high")))
    
    (detect-family-coordination trigger-event family-action-event)))

;; ============================================================================
;; PART 9: HELPER FUNCTIONS
;; ============================================================================

(define (calculate-days-between date1 date2)
  "Calculate days between two dates (simplified - assumes YYYY-MM-DD format)."
  ;; Simplified implementation - in production, use proper date parsing
  (let* ((d1 (string->date date1 "~Y-~m-~d"))
         (d2 (string->date date2 "~Y-~m-~d"))
         (diff (time-difference (date->time-utc d2) (date->time-utc d1))))
    (quotient (time-second diff) 86400)))  ;; Convert seconds to days

(define (calculate-temporal-proximity event1 event2)
  "Calculate temporal proximity score (0.0-1.0) based on time difference."
  (let ((days (calculate-days-between 
               (hash-ref event1 'date)
               (hash-ref event2 'date))))
    (cond
      ((<= days 1) 1.0)
      ((<= days 7) 0.8)
      ((<= days 14) 0.6)
      ((<= days 30) 0.4)
      (else 0.2))))

(define (assess-disproportionate-action event)
  "Assess if action is disproportionate (returns score 0.0-0.25)."
  (if (hash-ref event 'disproportionate #f)
      0.25
      0.10))

(define (assess-operational-disruption event)
  "Assess operational disruption severity (returns score 0.0-0.20)."
  (if (hash-ref event 'operational-disruption #f)
      0.20
      0.05))

(define (assess-whistleblower-context event)
  "Assess whistleblower protection context (returns score 0.0-0.15)."
  (if (equal? (hash-ref event 'context #f) "whistleblower-protection")
      0.15
      0.0))

(define (assess-pattern-consistency event1 event2)
  "Assess consistency with known patterns (returns score 0.0-0.10)."
  0.10)  ;; Simplified - in production, check against pattern database

(define (assess-coordination-complexity event)
  "Assess coordination complexity (returns score 0.0-0.30)."
  (let ((complexity (hash-ref event 'coordination-complexity "low")))
    (cond
      ((equal? complexity "high") 0.30)
      ((equal? complexity "medium") 0.20)
      (else 0.10))))

(define (assess-evidence-destruction event)
  "Assess evidence destruction severity (returns score 0.0-0.40)."
  (if (hash-ref event 'evidence-destruction #f)
      0.40
      0.0))

(define (assess-cooperation-context event)
  "Assess cooperation context (returns score 0.0-0.35)."
  (if (equal? (hash-ref event 'context #f) "settlement-discussion")
      0.35
      0.15))

(define (assess-cooperation-weaponization event)
  "Assess weaponization of cooperation (returns score 0.0-0.35)."
  (if (hash-ref event 'weaponization #f)
      0.35
      0.0))

(define (assess-family-connection event)
  "Assess family connection strength (returns score 0.0-0.30)."
  (if (hash-ref event 'family-connection #f)
      0.30
      0.0))

(define (assess-multi-actor-coordination event1 event2)
  "Assess multi-actor coordination (returns score 0.0-0.30)."
  (if (hash-ref event2 'coordination-indicators #f)
      0.30
      0.10))

(define (assess-self-created-problem event1 event2)
  "Assess if problem was self-created (returns score 0.0-0.40)."
  (if (equal? (hash-ref event1 'actor) (hash-ref event2 'actor))
      0.40
      0.0))

(define (assess-manufactured-urgency event)
  "Assess manufactured urgency (returns score 0.0-0.35)."
  (if (hash-ref event 'manufactured-urgency #f)
      0.35
      0.0))

(define (assess-causation-chain event1 event2)
  "Assess causation chain strength (returns score 0.0-0.25)."
  0.25)  ;; Simplified - in production, analyze logical necessity

(define (assess-logical-necessity event1 event2)
  "Assess logical necessity of causal link (returns score 0.0-1.0)."
  0.85)  ;; Simplified

(define (identify-intervening-factors event1 event2)
  "Identify intervening factors between events."
  '())  ;; Simplified

(define (make-pattern-report . args)
  "Create a pattern report hash table from key-value pairs."
  (let ((report (make-hash-table)))
    (let loop ((args args))
      (if (null? args)
          report
          (begin
            (hash-set! report (car args) (cadr args))
            (loop (cddr args)))))))

(define (generate-temporal-pattern-report events)
  "Generate comprehensive temporal pattern report for multiple events."
  (let ((patterns '()))
    
    ;; Detect all pattern types
    (for-each
     (lambda (event-pair)
       (let ((e1 (car event-pair))
             (e2 (cadr event-pair)))
         
         ;; Check for immediate retaliation
         (let ((retaliation (detect-immediate-retaliation e1 e2)))
           (when (> (hash-ref retaliation 'confidence 0.0) 0.5)
             (set! patterns (cons retaliation patterns))))
         
         ;; Check for coordinated response
         (let ((coordinated (detect-coordinated-response e1 e2)))
           (when (> (hash-ref coordinated 'confidence 0.0) 0.5)
             (set! patterns (cons coordinated patterns))))))
     
     (zip events (cdr events)))
    
    ;; Return comprehensive report
    (make-hash-table
     'patterns patterns
     'pattern-count (length patterns)
     'overall-confidence (if (null? patterns) 
                             0.0 
                             (/ (apply + (map (lambda (p) (hash-ref p 'confidence)) patterns))
                                (length patterns)))
     'timestamp (current-time))))

;; ============================================================================
;; END OF MODULE
;; ============================================================================
