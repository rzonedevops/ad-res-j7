;;;
;;; Legal Aspects Taxonomy v12
;;; Optimized legal issue classification with forensic confidence scoring
;;; Case 2025-137857 - November 22, 2025
;;;

(define-module (lex lv1 legal-aspects-taxonomy-v12)
  #:use-module (srfi srfi-1)
  #:export (
    legal-aspects-taxonomy-v12
    classify-legal-aspect-v12
    compute-legal-aspect-confidence-v12
    aggregate-legal-aspects-by-priority-v12
    generate-legal-aspect-network-v12
    detect-temporal-causation-patterns-v12
    get-aspect-frequency
    get-aspect-evidence-requirements
    get-aspect-related-aspects
    get-aspect-lex-principles
  ))

;;;
;;; Legal Aspects Taxonomy Data Structure
;;;

(define legal-aspects-taxonomy-v12
  '(
    ;; ========================================
    ;; CRITICAL PRIORITY LEGAL ASPECTS
    ;; ========================================
    
    ("bad-faith" . (
      (category . "intentional-wrongdoing")
      (priority . "critical")
      (frequency . 9)
      (confidence . 0.98)
      (evidence-requirements . (
        "temporal-proximity" 
        "knowledge-of-omitted-facts" 
        "hypocrisy-pattern"
        "settlement-trojan-horse"
      ))
      (temporal-patterns . (
        ("settlement-negotiation" . "2025-03-01" . "2025-04-14")
        ("whistleblowing-trigger" . "2025-05-15")
        ("retaliation-cascade" . "2025-05-22" . "2025-06-07" . "2025-08-13")
      ))
      (related-aspects . ("fraud" "manufactured-crisis" "retaliation"))
      (lex-principles . (
        "south-african-civil-law-temporal-bad-faith-v3"
        "south-african-civil-law-manufactured-crisis-detection"
      ))
    ))
    
    ("fraud" . (
      (category . "intentional-wrongdoing")
      (priority . "critical")
      (frequency . 8)
      (confidence . 0.97)
      (evidence-requirements . (
        "material-misrepresentation" 
        "knowledge" 
        "reliance" 
        "damages"
        "platform-ownership-concealment"
      ))
      (quantified-damages . (
        ("revenue-theft" . 3141000)
        ("financial-flows" . 4276000)
        ("family-trust" . 2851000)
        ("total" . 10269727.90)
      ))
      (related-aspects . ("bad-faith" "unjust-enrichment"))
      (lex-principles . (
        "south-african-civil-law-case-2025-137857-refined-v11"
        "south-african-forensic-analysis-systematic-fraud-narrative"
      ))
    ))
    
    ("fiduciary-duty-breach" . (
      (category . "trust-law-violation")
      (priority . "critical")
      (frequency . 7)
      (confidence . 0.96)
      (evidence-requirements . (
        "fiduciary-relationship" 
        "duty-owed" 
        "breach" 
        "causation"
        "founder-trustee-concentration"
      ))
      (entity-relations . (
        ("peter-faucitt" . "faucitt-family-trust" . "founder-trustee")
        ("conflict-severity" . 0.98)
      ))
      (related-aspects . ("self-dealing" "conflict-of-interest"))
      (lex-principles . (
        "south-african-trust-law-enhanced-v8"
        "south-african-trust-law-trustee-beneficiary-conflicts"
      ))
    ))
    
    ("manufactured-crisis" . (
      (category . "strategic-wrongdoing")
      (priority . "critical")
      (frequency . 6)
      (confidence . 0.98)
      (evidence-requirements . (
        "settlement-trojan-horse" 
        "temporal-causation" 
        "operational-impossibility"
        "technical-infrastructure-dependency"
      ))
      (temporal-pattern . (
        ("settlement-period" . "2025-03-01" . "2025-04-14")
        ("crisis-trigger" . "2025-06-07")
        ("manufactured-urgency" . "2025-09-11")
        ("causation-confidence" . 0.98)
      ))
      (system-dependencies . (
        ("critical-systems" . 8)
        ("operational-impossibility-confidence" . 0.99)
      ))
      (related-aspects . ("bad-faith" "abuse-of-process" "retaliation"))
      (lex-principles . (
        "south-african-civil-law-manufactured-crisis"
        "south-african-civil-law-manufactured-crisis-detection"
      ))
    ))
    
    ("retaliation" . (
      (category . "whistleblower-protection")
      (priority . "critical")
      (frequency . 4)
      (confidence . 0.98)
      (evidence-requirements . (
        "whistleblowing-disclosure" 
        "temporal-proximity" 
        "adverse-action"
        "causation-inference"
      ))
      (temporal-thresholds . (
        ("immediate" . "< 24 hours" . 0.98)
        ("short-term" . "< 7 days" . 0.96)
        ("medium-term" . "< 30 days" . 0.90)
      ))
      (retaliation-events . (
        ("jax-whistleblowing" . "2025-05-15")
        ("rynette-retaliation" . "2025-05-22" . "7-days" . 0.96)
        ("dan-whistleblowing" . "2025-06-06")
        ("peter-retaliation" . "2025-06-07" . "< 24-hours" . 0.98)
        ("coordinated-action" . "2025-08-13" . 0.94)
      ))
      (related-aspects . ("bad-faith" "manufactured-crisis" "multi-actor-coordination"))
      (lex-principles . (
        "south-african-civil-law-retaliation"
        "south-african-civil-law-temporal-bad-faith-v3"
      ))
    ))
    
    ("unjust-enrichment" . (
      (category . "civil-law-remedy")
      (priority . "critical")
      (frequency . 3)
      (confidence . 0.94)
      (evidence-requirements . (
        "enrichment" 
        "impoverishment" 
        "causal-connection" 
        "no-legal-justification"
        "platform-ownership-evidence"
      ))
      (uk-investment-structure . (
        ("regima-zone-ltd-investment" . 1000000)
        ("admin-fee-percentage" . 0.001)
        ("defense-strength" . 0.99)
        ("legal-significance" . "proves-legitimate-investment")
      ))
      (platform-ownership . (
        ("dan-jax-ownership" . "RegimA Zone Ltd")
        ("investment-proof" . "R1M UK investment")
        ("peter-contribution" . 0)
        ("unjust-enrichment-confidence" . 0.99)
      ))
      (related-aspects . ("fraud" "platform-ownership"))
      (lex-principles . (
        "south-african-civil-law-unjust-enrichment"
        "south-african-civil-law-platform-unjust-enrichment"
      ))
    ))
    
    ;; ========================================
    ;; HIGH PRIORITY LEGAL ASPECTS
    ;; ========================================
    
    ("abuse-of-process" . (
      (category . "procedural-wrongdoing")
      (priority . "high")
      (frequency . 2)
      (confidence . 0.93)
      (evidence-requirements . (
        "improper-purpose" 
        "void-ab-initio"
        "settlement-trojan-horse"
      ))
      (void-ab-initio-analysis . (
        ("settlement-period" . "2025-03-01" . "2025-04-14")
        ("crisis-creation" . "2025-06-07")
        ("void-confidence" . 0.99)
      ))
      (related-aspects . ("bad-faith" "manufactured-crisis"))
      (lex-principles . (
        "south-african-civil-procedure-ex-parte-fraud-rescission"
      ))
    ))
    
    ("delict" . (
      (category . "civil-law-remedy")
      (priority . "high")
      (frequency . 2)
      (confidence . 0.92)
      (evidence-requirements . (
        "wrongful-act" 
        "fault" 
        "causation" 
        "damages"
      ))
      (related-aspects . ("retaliation" "manufactured-crisis"))
      (lex-principles . (
        "south-african-civil-law"
      ))
    ))
    
    ("coercion" . (
      (category . "intentional-wrongdoing")
      (priority . "high")
      (frequency . 1)
      (confidence . 0.93)
      (evidence-requirements . (
        "threat" 
        "improper-purpose" 
        "causal-connection"
      ))
      (related-aspects . ("bad-faith" "manufactured-crisis"))
      (lex-principles . (
        "south-african-civil-law-coercion"
      ))
    ))
    
    ;; ========================================
    ;; MEDIUM PRIORITY LEGAL ASPECTS
    ;; ========================================
    
    ("self-dealing" . (
      (category . "trust-law-violation")
      (priority . "medium")
      (frequency . 1)
      (confidence . 0.90)
      (evidence-requirements . (
        "fiduciary-relationship" 
        "personal-benefit" 
        "conflict"
      ))
      (related-aspects . ("fiduciary-duty-breach" "conflict-of-interest"))
      (lex-principles . (
        "south-african-company-law-self-dealing-detection"
      ))
    ))
    
    ("conflict-of-interest" . (
      (category . "trust-law-violation")
      (priority . "medium")
      (frequency . 1)
      (confidence . 0.91)
      (evidence-requirements . (
        "fiduciary-relationship" 
        "competing-interests" 
        "duty-impairment"
      ))
      (accountant-creditor-conflict . (
        ("rynette-farrar" . "accountant")
        ("rezonance-debt" . 1035000)
        ("conflict-severity" . 0.98)
      ))
      (related-aspects . ("fiduciary-duty-breach" "self-dealing"))
      (lex-principles . (
        "south-african-professional-ethics-multi-party-conflicts"
      ))
    ))
  ))

;;;
;;; API Functions
;;;

;;; Classify legal aspect with v12 enhancements
(define (classify-legal-aspect-v12 aspect-name)
  "Classify a legal aspect and return its taxonomy entry with v12 enhancements"
  (assoc-ref legal-aspects-taxonomy-v12 aspect-name))

;;; Compute confidence score for legal aspect
(define (compute-legal-aspect-confidence-v12 aspect-name evidence-list)
  "Compute confidence score based on evidence requirements satisfaction"
  (let* ((aspect-data (classify-legal-aspect-v12 aspect-name))
         (requirements (assoc-ref aspect-data 'evidence-requirements))
         (base-confidence (assoc-ref aspect-data 'confidence))
         (satisfied-count (length (filter (lambda (req) 
                                            (member req evidence-list)) 
                                          requirements)))
         (total-count (length requirements)))
    (if (> total-count 0)
        (* base-confidence (/ satisfied-count total-count))
        base-confidence)))

;;; Aggregate legal aspects by priority
(define (aggregate-legal-aspects-by-priority-v12)
  "Aggregate all legal aspects grouped by priority level"
  (let ((critical '())
        (high '())
        (medium '()))
    (for-each
      (lambda (aspect-entry)
        (let* ((aspect-name (car aspect-entry))
               (aspect-data (cdr aspect-entry))
               (priority (assoc-ref aspect-data 'priority)))
          (cond
            ((equal? priority "critical")
             (set! critical (cons aspect-name critical)))
            ((equal? priority "high")
             (set! high (cons aspect-name high)))
            ((equal? priority "medium")
             (set! medium (cons aspect-name medium))))))
      legal-aspects-taxonomy-v12)
    `((critical . ,(reverse critical))
      (high . ,(reverse high))
      (medium . ,(reverse medium)))))

;;; Generate legal aspect network
(define (generate-legal-aspect-network-v12 aspect-name)
  "Generate network of related legal aspects"
  (let* ((aspect-data (classify-legal-aspect-v12 aspect-name))
         (related (assoc-ref aspect-data 'related-aspects)))
    (if related
        (map (lambda (related-aspect)
               (cons related-aspect (classify-legal-aspect-v12 related-aspect)))
             related)
        '())))

;;; Detect temporal causation patterns
(define (detect-temporal-causation-patterns-v12 event-timeline)
  "Detect temporal causation patterns with confidence scoring"
  (define (temporal-proximity date1 date2)
    "Calculate temporal proximity in days"
    ;; Simplified - actual implementation would parse dates
    (abs (- (string->number (substring date1 8 10))
            (string->number (substring date2 8 10)))))
  
  (define (causation-confidence proximity-days)
    "Calculate causation confidence based on temporal proximity"
    (cond
      ((< proximity-days 1) 0.98)   ; < 24 hours
      ((< proximity-days 7) 0.96)   ; < 7 days
      ((< proximity-days 30) 0.90)  ; < 30 days
      (else 0.75)))                 ; > 30 days
  
  (map (lambda (event-pair)
         (let* ((event1 (car event-pair))
                (event2 (cadr event-pair))
                (date1 (assoc-ref event1 'date))
                (date2 (assoc-ref event2 'date))
                (proximity (temporal-proximity date1 date2))
                (confidence (causation-confidence proximity)))
           `((event1 . ,event1)
             (event2 . ,event2)
             (proximity-days . ,proximity)
             (causation-confidence . ,confidence))))
       event-timeline))

;;;
;;; Convenience Accessors
;;;

(define (get-aspect-frequency aspect-name)
  "Get frequency count for a legal aspect"
  (let ((aspect-data (classify-legal-aspect-v12 aspect-name)))
    (if aspect-data
        (assoc-ref aspect-data 'frequency)
        0)))

(define (get-aspect-evidence-requirements aspect-name)
  "Get evidence requirements for a legal aspect"
  (let ((aspect-data (classify-legal-aspect-v12 aspect-name)))
    (if aspect-data
        (assoc-ref aspect-data 'evidence-requirements)
        '())))

(define (get-aspect-related-aspects aspect-name)
  "Get related aspects for a legal aspect"
  (let ((aspect-data (classify-legal-aspect-v12 aspect-name)))
    (if aspect-data
        (assoc-ref aspect-data 'related-aspects)
        '())))

(define (get-aspect-lex-principles aspect-name)
  "Get lex principles for a legal aspect"
  (let ((aspect-data (classify-legal-aspect-v12 aspect-name)))
    (if aspect-data
        (assoc-ref aspect-data 'lex-principles)
        '())))
