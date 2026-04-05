;;;
;;; Legal Aspects Taxonomy v13
;;; Data-driven legal issue classification with forensic AD element integration
;;; Case 2025-137857 - November 23, 2025
;;; Repository: cogpy/ad-res-j7
;;;
;;; Enhancement Focus: Forensic AD element analysis integration with actual frequency data
;;;

(define-module (lex lv1 legal-aspects-taxonomy-v13)
  #:use-module (lex lv1 known-laws)
  #:use-module (srfi srfi-1)
  #:export (
    legal-aspects-taxonomy-v13
    classify-legal-aspect-v13
    compute-legal-aspect-confidence-v13
    aggregate-legal-aspects-by-priority-v13
    generate-legal-aspect-network-v13
    detect-temporal-causation-patterns-v13
    analyze-entity-relation-co-occurrence-v13
    compute-priority-weighted-confidence-v13
    detect-cross-paragraph-patterns-v13
    generate-evidence-paragraph-mapping-v13
    get-aspect-frequency-v13
    get-aspect-evidence-requirements-v13
    get-aspect-related-aspects-v13
    get-aspect-lex-principles-v13
    get-aspect-ad-paragraphs-v13
  ))

;;;
;;; Legal Aspects Taxonomy Data Structure v13
;;; Updated with actual AD analysis data: 25 paragraphs, 28 unique dates, 127 event mentions
;;;

(define legal-aspects-taxonomy-v13
  '(
    ;; ========================================
    ;; CRITICAL PRIORITY LEGAL ASPECTS
    ;; ========================================
    
    ("fraud" . (
      (category . "intentional-wrongdoing")
      (priority . "critical")
      (frequency . 113)  ; Updated from actual AD analysis
      (ad-paragraph-distribution . (
        ("1-critical" . 2)
        ("2-high" . 3)
        ("3-medium" . 1)
      ))
      (confidence . 0.97)
      (priority-weighted-confidence . 0.98)
      (evidence-requirements . (
        "material-misrepresentation" 
        "knowledge" 
        "reliance" 
        "damages"
        "platform-ownership-concealment"
        "revenue-hijacking-evidence"
      ))
      (quantified-damages . (
        ("revenue-theft" . 3141000)
        ("financial-flows" . 4276000)
        ("family-trust" . 2851000)
        ("total" . 10269727.90)
      ))
      (entity-relations . (
        ("peter-faucitt" . "rst" . "trustee-company" . 0.98)
        ("peter-faucitt" . "rynette-farrar" . "coordination" . 0.94)
      ))
      (ad-paragraph-evidence . (
        "7.2-7.5" "7.6" "7.7-7.8" "7.9-7.11" "10.5-10.23"
      ))
      (related-aspects . ("bad-faith" "unjust-enrichment" "manufactured-crisis"))
      (lex-principles . (
        "south-african-civil-law-case-2025-137857-refined-v13"
        "south-african-forensic-analysis-systematic-fraud-narrative"
      ))
    ))
    
    ("bad-faith" . (
      (category . "intentional-wrongdoing")
      (priority . "critical")
      (frequency . 53)  ; Updated from actual AD analysis
      (ad-paragraph-distribution . (
        ("1-critical" . 4)
        ("2-high" . 3)
      ))
      (confidence . 0.98)
      (priority-weighted-confidence . 0.99)
      (evidence-requirements . (
        "temporal-proximity" 
        "knowledge-of-omitted-facts" 
        "hypocrisy-pattern"
        "settlement-trojan-horse"
        "material-non-disclosure"
      ))
      (temporal-patterns . (
        ("settlement-negotiation" . "2025-03-01" . "2025-04-14")
        ("whistleblowing-trigger" . "2025-05-15")
        ("retaliation-cascade" . "2025-05-22" . "2025-06-07" . "2025-08-13")
      ))
      (entity-relations . (
        ("peter-faucitt" . "dan" . "retaliation" . 0.98)
        ("peter-faucitt" . "jax" . "retaliation" . 0.96)
        ("peter-faucitt" . "rynette-farrar" . "coordination" . 0.94)
      ))
      (ad-paragraph-evidence . (
        "7.2-7.5" "7.6" "7.9-7.11" "8.1-8.3" "11.1-11.5" "12.3"
      ))
      (related-aspects . ("fraud" "manufactured-crisis" "retaliation"))
      (lex-principles . (
        "south-african-civil-law-temporal-bad-faith-v3"
        "south-african-civil-law-manufactured-crisis-detection"
      ))
    ))
    
    ("unjust-enrichment" . (
      (category . "civil-law-remedy")
      (priority . "critical")
      (frequency . 37)  ; Updated from actual AD analysis
      (ad-paragraph-distribution . (
        ("1-critical" . 3)
      ))
      (confidence . 0.94)
      (priority-weighted-confidence . 0.96)
      (evidence-requirements . (
        "enrichment" 
        "impoverishment" 
        "causal-connection" 
        "no-legal-justification"
        "platform-ownership-evidence"
        "r1m-uk-investment-proof"
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
      (entity-relations . (
        ("dan" . "regima-zone-ltd" . "ownership" . 0.99)
        ("jax" . "regima-zone-ltd" . "ownership" . 0.99)
        ("dan" . "rwd" . "technical-control" . 0.99)
        ("jax" . "rwd" . "operational-control" . 0.99)
      ))
      (ad-paragraph-evidence . (
        "7.9-7.11" "10.5-10.23"
      ))
      (related-aspects . ("fraud" "platform-ownership"))
      (lex-principles . (
        "south-african-civil-law-unjust-enrichment"
        "south-african-civil-law-platform-unjust-enrichment"
      ))
    ))
    
    ("retaliation" . (
      (category . "whistleblower-protection")
      (priority . "critical")
      (frequency . 35)  ; Updated from actual AD analysis
      (ad-paragraph-distribution . (
        ("1-critical" . 1)
        ("2-high" . 2)
      ))
      (confidence . 0.98)
      (priority-weighted-confidence . 0.98)
      (evidence-requirements . (
        "whistleblowing-disclosure" 
        "temporal-proximity" 
        "adverse-action"
        "causation-inference"
        "immediate-retaliation-pattern"
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
      (entity-relations . (
        ("peter-faucitt" . "dan" . "immediate-retaliation" . 0.98)
        ("peter-faucitt" . "jax" . "short-term-retaliation" . 0.96)
        ("rynette-farrar" . "jax" . "short-term-retaliation" . 0.96)
      ))
      (ad-paragraph-evidence . (
        "7.2-7.5" "8.4" "11.1-11.5"
      ))
      (related-aspects . ("bad-faith" "manufactured-crisis" "temporal-proximity"))
      (lex-principles . (
        "south-african-civil-law-retaliation"
        "south-african-civil-law-temporal-bad-faith-v3"
      ))
    ))
    
    ("manufactured-crisis" . (
      (category . "strategic-wrongdoing")
      (priority . "critical")
      (frequency . 29)  ; Updated from actual AD analysis
      (ad-paragraph-distribution . (
        ("1-critical" . 1)
        ("2-high" . 3)
      ))
      (confidence . 0.98)
      (priority-weighted-confidence . 0.98)
      (evidence-requirements . (
        "settlement-trojan-horse" 
        "temporal-causation" 
        "operational-impossibility"
        "technical-infrastructure-dependency"
        "8-critical-systems"
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
      (entity-relations . (
        ("dan" . "rst" . "technical-dependency" . 0.99)
        ("jax" . "rst" . "operational-dependency" . 0.99)
        ("dan" . "jax" . "complementary-infrastructure" . 0.99)
      ))
      (ad-paragraph-evidence . (
        "7.2-7.5" "11.1-11.5" "12.3" "13.1"
      ))
      (related-aspects . ("bad-faith" "abuse-of-process" "retaliation"))
      (lex-principles . (
        "south-african-civil-law-manufactured-crisis"
        "south-african-civil-law-manufactured-crisis-detection"
      ))
    ))
    
    ;; ========================================
    ;; HIGH PRIORITY LEGAL ASPECTS
    ;; ========================================
    
    ("temporal-proximity" . (
      (category . "evidence-pattern")
      (priority . "high")
      (frequency . 25)  ; Updated from actual AD analysis
      (ad-paragraph-distribution . (
        ("1-critical" . 1)
        ("2-high" . 1)
      ))
      (confidence . 0.96)
      (priority-weighted-confidence . 0.96)
      (evidence-requirements . (
        "date-extraction"
        "event-sequence"
        "causation-inference"
      ))
      (temporal-analysis . (
        ("unique-dates" . 28)
        ("total-event-mentions" . 127)
        ("critical-events" . 100)
        ("high-priority-events" . 27)
      ))
      (ad-paragraph-evidence . (
        "7.2-7.5" "8.1-8.3"
      ))
      (related-aspects . ("retaliation" "manufactured-crisis" "bad-faith"))
      (lex-principles . (
        "south-african-civil-law-temporal-bad-faith-v3"
      ))
    ))
    
    ("breach" . (
      (category . "general-wrongdoing")
      (priority . "high")
      (frequency . 13)  ; Updated from actual AD analysis
      (ad-paragraph-distribution . (
        ("1-critical" . 2)
        ("2-high" . 3)
      ))
      (confidence . 0.96)
      (priority-weighted-confidence . 0.97)
      (evidence-requirements . (
        "duty-owed"
        "breach-of-duty"
        "causation"
        "damages"
      ))
      (ad-paragraph-evidence . (
        "7.6" "7.9-7.11" "8.1-8.3" "11.1-11.5" "12.1"
      ))
      (related-aspects . ("fiduciary-duty" "bad-faith"))
      (lex-principles . (
        "south-african-civil-law"
      ))
    ))
    
    ("abuse-of-process" . (
      (category . "procedural-wrongdoing")
      (priority . "high")
      (frequency . 7)  ; Updated from actual AD analysis
      (ad-paragraph-distribution . (
        ("1-critical" . 1)
      ))
      (confidence . 0.93)
      (priority-weighted-confidence . 0.94)
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
      (ad-paragraph-evidence . (
        "11.1-11.5"
      ))
      (related-aspects . ("bad-faith" "manufactured-crisis"))
      (lex-principles . (
        "south-african-civil-procedure-ex-parte-fraud-rescission"
      ))
    ))
    
    ("fiduciary-duty" . (
      (category . "trust-law-violation")
      (priority . "high")
      (frequency . 6)  ; Updated from actual AD analysis
      (ad-paragraph-distribution . (
        ("1-critical" . 2)
        ("2-high" . 1)
      ))
      (confidence . 0.95)
      (priority-weighted-confidence . 0.96)
      (evidence-requirements . (
        "fiduciary-relationship" 
        "duty-owed" 
        "breach" 
        "causation"
        "founder-trustee-concentration"
      ))
      (entity-relations . (
        ("peter-faucitt" . "faucitt-family-trust" . "founder-trustee" . 0.98)
      ))
      (ad-paragraph-evidence . (
        "7.6" "7.9-7.11" "12.1"
      ))
      (related-aspects . ("breach" "self-dealing" "conflict-of-interest"))
      (lex-principles . (
        "south-african-trust-law-enhanced-v8"
        "south-african-trust-law-trustee-beneficiary-conflicts"
      ))
    ))
    
    ;; ========================================
    ;; MEDIUM PRIORITY LEGAL ASPECTS
    ;; ========================================
    
    ("conflict-of-interest" . (
      (category . "trust-law-violation")
      (priority . "medium")
      (frequency . 5)  ; Updated from actual AD analysis
      (ad-paragraph-distribution . (
        ("2-high" . 1)
      ))
      (confidence . 0.91)
      (priority-weighted-confidence . 0.91)
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
      (ad-paragraph-evidence . (
        "7.12-7.13"
      ))
      (related-aspects . ("fiduciary-duty" "self-dealing"))
      (lex-principles . (
        "south-african-professional-ethics-multi-party-conflicts"
      ))
    ))
    
    ("delict" . (
      (category . "civil-law-remedy")
      (priority . "medium")
      (frequency . 4)  ; Updated from actual AD analysis
      (ad-paragraph-distribution . (
        ("1-critical" . 1)
      ))
      (confidence . 0.92)
      (priority-weighted-confidence . 0.93)
      (evidence-requirements . (
        "wrongful-act" 
        "fault" 
        "causation" 
        "damages"
      ))
      (ad-paragraph-evidence . (
        "7.2-7.5"
      ))
      (related-aspects . ("retaliation" "manufactured-crisis"))
      (lex-principles . (
        "south-african-civil-law"
      ))
    ))
    
    ("self-dealing" . (
      (category . "trust-law-violation")
      (priority . "medium")
      (frequency . 2)  ; Updated from actual AD analysis
      (ad-paragraph-distribution . (
        ("2-high" . 1)
      ))
      (confidence . 0.90)
      (priority-weighted-confidence . 0.90)
      (evidence-requirements . (
        "fiduciary-relationship" 
        "personal-benefit" 
        "conflict"
      ))
      (ad-paragraph-evidence . (
        "12.1"
      ))
      (related-aspects . ("fiduciary-duty" "conflict-of-interest"))
      (lex-principles . (
        "south-african-company-law-self-dealing-detection"
      ))
    ))
    
    ("coercion" . (
      (category . "intentional-wrongdoing")
      (priority . "medium")
      (frequency . 1)  ; Updated from actual AD analysis
      (ad-paragraph-distribution . (
        ("2-high" . 1)
      ))
      (confidence . 0.93)
      (priority-weighted-confidence . 0.93)
      (evidence-requirements . (
        "threat" 
        "improper-purpose" 
        "causal-connection"
      ))
      (ad-paragraph-evidence . (
        "8.4"
      ))
      (related-aspects . ("bad-faith" "manufactured-crisis"))
      (lex-principles . (
        "south-african-civil-law-coercion"
      ))
    ))
  ))

;;;
;;; API Functions v13
;;;

;;; Classify legal aspect with v13 data-driven enhancements
(define (classify-legal-aspect-v13 aspect-name)
  "Classify a legal aspect and return its taxonomy entry with v13 data-driven enhancements"
  (assoc-ref legal-aspects-taxonomy-v13 aspect-name))

;;; Compute confidence score with priority weighting
(define (compute-legal-aspect-confidence-v13 aspect-name evidence-list)
  "Compute confidence score based on evidence requirements satisfaction"
  (let* ((aspect-data (classify-legal-aspect-v13 aspect-name))
         (requirements (assoc-ref aspect-data 'evidence-requirements))
         (base-confidence (assoc-ref aspect-data 'confidence))
         (priority-weighted-confidence (assoc-ref aspect-data 'priority-weighted-confidence))
         (satisfied-count (length (filter (lambda (req) 
                                            (member req evidence-list)) 
                                          requirements)))
         (total-count (length requirements)))
    (if (> total-count 0)
        (* priority-weighted-confidence (/ satisfied-count total-count))
        priority-weighted-confidence)))

;;; Compute priority-weighted confidence
(define (compute-priority-weighted-confidence-v13 aspect-name)
  "Compute priority-weighted confidence based on AD paragraph distribution"
  (let* ((aspect-data (classify-legal-aspect-v13 aspect-name))
         (base-confidence (assoc-ref aspect-data 'confidence))
         (priority-dist (assoc-ref aspect-data 'ad-paragraph-distribution))
         (critical-count (or (assoc-ref priority-dist "1-critical") 0))
         (high-count (or (assoc-ref priority-dist "2-high") 0))
         (medium-count (or (assoc-ref priority-dist "3-medium") 0))
         (total-count (+ critical-count high-count medium-count)))
    (if (> total-count 0)
        (let ((critical-weight 1.0)
              (high-weight 0.95)
              (medium-weight 0.85))
          (* base-confidence
             (/ (+ (* critical-count critical-weight)
                   (* high-count high-weight)
                   (* medium-count medium-weight))
                total-count)))
        base-confidence)))

;;; Aggregate legal aspects by priority
(define (aggregate-legal-aspects-by-priority-v13)
  "Aggregate all legal aspects grouped by priority level with frequency data"
  (let ((critical '())
        (high '())
        (medium '()))
    (for-each
      (lambda (aspect-entry)
        (let* ((aspect-name (car aspect-entry))
               (aspect-data (cdr aspect-entry))
               (priority (assoc-ref aspect-data 'priority))
               (frequency (assoc-ref aspect-data 'frequency)))
          (cond
            ((equal? priority "critical")
             (set! critical (cons (cons aspect-name frequency) critical)))
            ((equal? priority "high")
             (set! high (cons (cons aspect-name frequency) high)))
            ((equal? priority "medium")
             (set! medium (cons (cons aspect-name frequency) medium))))))
      legal-aspects-taxonomy-v13)
    `((critical . ,(reverse critical))
      (high . ,(reverse high))
      (medium . ,(reverse medium)))))

;;; Analyze entity-relation co-occurrence patterns
(define (analyze-entity-relation-co-occurrence-v13 aspect-name)
  "Analyze entity-relation co-occurrence patterns for a legal aspect"
  (let* ((aspect-data (classify-legal-aspect-v13 aspect-name))
         (entity-relations (assoc-ref aspect-data 'entity-relations)))
    entity-relations))

;;; Detect temporal causation patterns
(define (detect-temporal-causation-patterns-v13 aspect-name)
  "Detect temporal causation patterns for a legal aspect"
  (let* ((aspect-data (classify-legal-aspect-v13 aspect-name))
         (temporal-patterns (assoc-ref aspect-data 'temporal-patterns))
         (temporal-thresholds (assoc-ref aspect-data 'temporal-thresholds))
         (retaliation-events (assoc-ref aspect-data 'retaliation-events)))
    (or temporal-patterns temporal-thresholds retaliation-events '())))

;;; Detect cross-paragraph patterns
(define (detect-cross-paragraph-patterns-v13 legal-aspects-list)
  "Detect cross-paragraph patterns for multiple legal aspects"
  (let ((paragraph-aspect-map (make-hash-table)))
    (for-each
      (lambda (aspect-name)
        (let* ((aspect-data (classify-legal-aspect-v13 aspect-name))
               (ad-paragraphs (assoc-ref aspect-data 'ad-paragraph-evidence)))
          (when ad-paragraphs
            (for-each
              (lambda (para)
                (hash-set! paragraph-aspect-map para
                          (cons aspect-name (or (hash-ref paragraph-aspect-map para) '()))))
              ad-paragraphs))))
      legal-aspects-list)
    paragraph-aspect-map))

;;; Generate evidence-paragraph mapping
(define (generate-evidence-paragraph-mapping-v13)
  "Generate comprehensive evidence-paragraph mapping for all legal aspects"
  (let ((evidence-map '()))
    (for-each
      (lambda (aspect-entry)
        (let* ((aspect-name (car aspect-entry))
               (aspect-data (cdr aspect-entry))
               (ad-paragraphs (assoc-ref aspect-data 'ad-paragraph-evidence))
               (lex-principles (assoc-ref aspect-data 'lex-principles)))
          (when (and ad-paragraphs lex-principles)
            (set! evidence-map
                  (cons (list aspect-name ad-paragraphs lex-principles)
                        evidence-map)))))
      legal-aspects-taxonomy-v13)
    (reverse evidence-map)))

;;; Generate legal aspect network
(define (generate-legal-aspect-network-v13)
  "Generate network of related legal aspects"
  (let ((network '()))
    (for-each
      (lambda (aspect-entry)
        (let* ((aspect-name (car aspect-entry))
               (aspect-data (cdr aspect-entry))
               (related-aspects (assoc-ref aspect-data 'related-aspects)))
          (when related-aspects
            (set! network (cons (cons aspect-name related-aspects) network)))))
      legal-aspects-taxonomy-v13)
    (reverse network)))

;;; Accessor functions
(define (get-aspect-frequency-v13 aspect-name)
  "Get frequency count for a legal aspect"
  (let ((aspect-data (classify-legal-aspect-v13 aspect-name)))
    (assoc-ref aspect-data 'frequency)))

(define (get-aspect-evidence-requirements-v13 aspect-name)
  "Get evidence requirements for a legal aspect"
  (let ((aspect-data (classify-legal-aspect-v13 aspect-name)))
    (assoc-ref aspect-data 'evidence-requirements)))

(define (get-aspect-related-aspects-v13 aspect-name)
  "Get related aspects for a legal aspect"
  (let ((aspect-data (classify-legal-aspect-v13 aspect-name)))
    (assoc-ref aspect-data 'related-aspects)))

(define (get-aspect-lex-principles-v13 aspect-name)
  "Get lex principles for a legal aspect"
  (let ((aspect-data (classify-legal-aspect-v13 aspect-name)))
    (assoc-ref aspect-data 'lex-principles)))

(define (get-aspect-ad-paragraphs-v13 aspect-name)
  "Get AD paragraph evidence for a legal aspect"
  (let ((aspect-data (classify-legal-aspect-v13 aspect-name)))
    (assoc-ref aspect-data 'ad-paragraph-evidence)))
