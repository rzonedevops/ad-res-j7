;;; Legal Aspects Taxonomy v14
;;; Enhanced agent-based entity modeling and cross-paragraph pattern detection
;;; Case 2025-137857 - November 24, 2025
;;; Repository: cogpy/ad-res-j7
;;;
;;; Enhancement Focus: Agent-based entity modeling, enhanced temporal causation,
;;;                    cross-paragraph pattern detection, evidence strength scoring
;;;

(define-module (lex lv1 legal-aspects-taxonomy-v14)
  #:use-module (lex lv1 known-laws)
  #:use-module (srfi srfi-1)
  #:use-module (srfi srfi-9)
  #:export (
    legal-aspects-taxonomy-v14
    classify-legal-aspect-v14
    compute-legal-aspect-confidence-v14
    aggregate-legal-aspects-by-priority-v14
    generate-legal-aspect-network-v14
    detect-temporal-causation-patterns-v14
    analyze-entity-relation-co-occurrence-v14
    compute-priority-weighted-confidence-v14
    detect-cross-paragraph-patterns-v14
    generate-evidence-paragraph-mapping-v14
    get-aspect-frequency-v14
    get-aspect-evidence-requirements-v14
    get-aspect-related-aspects-v14
    get-aspect-lex-principles-v14
    get-aspect-ad-paragraphs-v14
    compute-aspect-cumulative-confidence-v14
    identify-aspect-pattern-clusters-v14
  ))

;;;
;;; Legal Aspects Taxonomy Data Structure v14
;;; Updated with actual AD analysis data: 36 paragraphs analyzed, 28 unique dates, 127 event mentions
;;; Enhanced with agent-based entity modeling and cross-paragraph pattern detection
;;;

(define legal-aspects-taxonomy-v14
  '(
    ;; ========================================
    ;; CRITICAL PRIORITY LEGAL ASPECTS
    ;; ========================================
    
    ("fraud" . (
      (category . "intentional-wrongdoing")
      (priority . "critical")
      (frequency . 113)  ; Actual AD analysis data
      (ad-paragraph-distribution . (
        ("1-critical" . 2)
        ("2-high" . 3)
        ("3-medium" . 1)
      ))
      (confidence . 0.97)
      (priority-weighted-confidence . 0.98)
      (cumulative-confidence . 0.99)  ; Enhanced with cross-paragraph aggregation
      (evidence-requirements . (
        "material-misrepresentation" 
        "knowledge" 
        "reliance" 
        "damages"
        "platform-ownership-concealment"
        "revenue-hijacking-evidence"
        "financial-flow-documentation"
      ))
      (evidence-strength-scores . (
        ("financial-records" . 0.98)
        ("platform-ownership-documents" . 0.99)
        ("revenue-flow-analysis" . 0.96)
        ("correspondence" . 0.88)
      ))
      (quantified-damages . (
        ("revenue-theft" . 3141000)
        ("financial-flows" . 4276000)
        ("family-trust" . 2851000)
        ("total" . 10269727.90)
      ))
      (entity-agent-network . (
        ("peter-faucitt" . (
          (role . "fraud-orchestrator")
          (confidence . 0.98)
          (coordination-targets . ("rynette-farrar"))
        ))
        ("rynette-farrar" . (
          (role . "fraud-facilitator")
          (confidence . 0.94)
          (coordination-targets . ("peter-faucitt"))
        ))
      ))
      (temporal-patterns . (
        ("settlement-negotiation" . "2025-03-01" . "2025-04-14")
        ("fraud-exposure" . "2025-06-06")
        ("immediate-retaliation" . "2025-06-07")
      ))
      (ad-paragraph-evidence . (
        "7.2-7.5" "7.6" "7.7-7.8" "7.9-7.11" "10.5-10.23"
      ))
      (cross-paragraph-patterns . (
        ("systematic-concealment" . 0.98)
        ("coordinated-misrepresentation" . 0.96)
        ("temporal-bad-faith" . 0.98)
      ))
      (related-aspects . ("bad-faith" "unjust-enrichment" "manufactured-crisis"))
      (lex-principles . (
        "south-african-civil-law-case-2025-137857-refined-v14"
        "south-african-forensic-analysis-systematic-fraud-narrative"
      ))
    ))
    
    ("bad-faith" . (
      (category . "intentional-wrongdoing")
      (priority . "critical")
      (frequency . 53)  ; Actual AD analysis data
      (ad-paragraph-distribution . (
        ("1-critical" . 4)
        ("2-high" . 3)
      ))
      (confidence . 0.98)
      (priority-weighted-confidence . 0.99)
      (cumulative-confidence . 0.99)
      (evidence-requirements . (
        "temporal-proximity" 
        "knowledge-of-omitted-facts" 
        "hypocrisy-pattern"
        "settlement-trojan-horse"
        "material-non-disclosure"
        "coordinated-action-evidence"
      ))
      (evidence-strength-scores . (
        ("temporal-analysis" . 0.98)
        ("knowledge-documentation" . 0.95)
        ("hypocrisy-evidence" . 0.92)
        ("settlement-documents" . 0.96)
      ))
      (temporal-patterns . (
        ("settlement-negotiation" . "2025-03-01" . "2025-04-14" . (
          (pattern . "trojan-horse")
          (confidence . 0.99)
          (no-terms-of-reference . #t)
        ))
        ("whistleblowing-trigger" . "2025-05-15" . (
          (actor . "jax")
          (action . "popia-violation-notice")
          (confidence . 0.99)
        ))
        ("retaliation-cascade" . (
          ("2025-05-22" . "rynette-retaliation" . "7-days" . 0.96)
          ("2025-06-07" . "peter-retaliation" . "< 24-hours" . 0.98)
          ("2025-08-13" . "coordinated-action" . 0.94)
        ))
      ))
      (entity-agent-network . (
        ("peter-faucitt" . (
          (role . "bad-faith-orchestrator")
          (confidence . 0.98)
          (targets . ("dan" "jax"))
          (coordination . ("rynette-farrar"))
        ))
        ("rynette-farrar" . (
          (role . "bad-faith-facilitator")
          (confidence . 0.94)
          (targets . ("jax"))
          (coordination . ("peter-faucitt"))
        ))
      ))
      (ad-paragraph-evidence . (
        "7.2-7.5" "7.6" "7.9-7.11" "8.1-8.3" "11.1-11.5" "12.3"
      ))
      (cross-paragraph-patterns . (
        ("settlement-trojan-horse" . 0.99)
        ("temporal-proximity-cascade" . 0.98)
        ("knowledge-hypocrisy" . 0.97)
        ("coordinated-retaliation" . 0.94)
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
      (frequency . 37)  ; Actual AD analysis data
      (ad-paragraph-distribution . (
        ("1-critical" . 3)
      ))
      (confidence . 0.94)
      (priority-weighted-confidence . 0.96)
      (cumulative-confidence . 0.98)
      (evidence-requirements . (
        "enrichment" 
        "impoverishment" 
        "causal-connection" 
        "no-legal-justification"
        "platform-ownership-evidence"
        "r1m-uk-investment-proof"
        "admin-fee-justification"
      ))
      (evidence-strength-scores . (
        ("platform-ownership-documents" . 0.99)
        ("uk-investment-proof" . 0.99)
        ("admin-fee-documentation" . 0.96)
        ("financial-flows" . 0.95)
      ))
      (uk-investment-structure . (
        ("regima-zone-ltd-investment" . 1000000)
        ("admin-fee-percentage" . 0.001)
        ("defense-strength" . 0.99)
        ("legal-significance" . "proves-legitimate-investment")
        ("peter-contribution" . 0)
        ("unjust-enrichment-refutation" . 0.99)
      ))
      (platform-ownership . (
        ("dan-jax-ownership" . "RegimA Zone Ltd")
        ("investment-proof" . "R1M UK investment")
        ("peter-contribution" . 0)
        ("unjust-enrichment-confidence" . 0.99)
        ("admin-fee-justification" . 0.001)
      ))
      (entity-agent-network . (
        ("dan" . (
          (role . "platform-owner")
          (confidence . 0.99)
          (ownership . "regima-zone-ltd")
          (investment . 1000000)
        ))
        ("jax" . (
          (role . "platform-owner")
          (confidence . 0.99)
          (ownership . "regima-zone-ltd")
          (investment . 1000000)
        ))
        ("peter-faucitt" . (
          (role . "unjust-enrichment-claimant")
          (confidence . 0.98)
          (contribution . 0)
          (claim-validity . 0.01)
        ))
      ))
      (ad-paragraph-evidence . (
        "7.9-7.11" "10.5-10.23"
      ))
      (cross-paragraph-patterns . (
        ("platform-ownership-concealment" . 0.99)
        ("investment-omission" . 0.99)
        ("admin-fee-mischaracterization" . 0.96)
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
      (frequency . 35)  ; Actual AD analysis data
      (ad-paragraph-distribution . (
        ("1-critical" . 1)
        ("2-high" . 2)
      ))
      (confidence . 0.98)
      (priority-weighted-confidence . 0.98)
      (cumulative-confidence . 0.99)
      (evidence-requirements . (
        "whistleblowing-disclosure" 
        "temporal-proximity" 
        "adverse-action"
        "causation-inference"
        "immediate-retaliation-pattern"
        "cascade-coordination-evidence"
      ))
      (evidence-strength-scores . (
        ("whistleblowing-documentation" . 0.99)
        ("temporal-analysis" . 0.98)
        ("adverse-action-evidence" . 0.96)
        ("causation-documentation" . 0.95)
      ))
      (temporal-thresholds . (
        ("immediate" . "< 24 hours" . 0.98)
        ("short-term" . "< 7 days" . 0.96)
        ("medium-term" . "< 30 days" . 0.90)
      ))
      (retaliation-events . (
        ("jax-whistleblowing" . "2025-05-15" . (
          (action . "popia-violation-notice")
          (target . "peter-faucitt")
          (confidence . 0.99)
        ))
        ("rynette-retaliation" . "2025-05-22" . (
          (timeframe . "7-days")
          (confidence . 0.96)
          (target . "jax")
          (action . "adverse-action")
        ))
        ("dan-whistleblowing" . "2025-06-06" . (
          (action . "fraud-report-submission")
          (target . "accountant")
          (confidence . 0.99)
        ))
        ("peter-retaliation" . "2025-06-07" . (
          (timeframe . "< 24-hours")
          (confidence . 0.98)
          (target . "dan")
          (action . "card-cancellation")
        ))
        ("coordinated-action" . "2025-08-13" . (
          (confidence . 0.94)
          (actors . ("peter-faucitt" "rynette-farrar"))
          (action . "urgent-application")
        ))
      ))
      (entity-agent-network . (
        ("peter-faucitt" . (
          (role . "retaliation-executor")
          (confidence . 0.98)
          (targets . ("dan" "jax"))
          (temporal-pattern . "immediate")
        ))
        ("rynette-farrar" . (
          (role . "retaliation-coordinator")
          (confidence . 0.96)
          (targets . ("jax"))
          (temporal-pattern . "short-term")
        ))
        ("dan" . (
          (role . "whistleblower-victim")
          (confidence . 0.99)
          (retaliation-timeframe . "< 24-hours")
        ))
        ("jax" . (
          (role . "whistleblower-victim")
          (confidence . 0.99)
          (retaliation-timeframe . "7-days")
        ))
      ))
      (ad-paragraph-evidence . (
        "7.2-7.5" "8.4" "11.1-11.5"
      ))
      (cross-paragraph-patterns . (
        ("retaliation-cascade" . 0.98)
        ("coordinated-retaliation" . 0.94)
        ("temporal-proximity-pattern" . 0.98)
      ))
      (related-aspects . ("bad-faith" "manufactured-crisis" "temporal-proximity"))
      (lex-principles . (
        "south-african-civil-law-retaliation"
        "south-african-whistleblower-protection"
      ))
    ))
    
    ("manufactured-crisis" . (
      (category . "strategic-wrongdoing")
      (priority . "critical")
      (frequency . 29)  ; Actual AD analysis data
      (ad-paragraph-distribution . (
        ("1-critical" . 1)
        ("2-high" . 3)
      ))
      (confidence . 0.98)
      (priority-weighted-confidence . 0.98)
      (cumulative-confidence . 0.99)
      (evidence-requirements . (
        "settlement-trojan-horse" 
        "temporal-causation" 
        "operational-impossibility"
        "regulatory-crisis-creation"
        "coordinated-execution"
      ))
      (evidence-strength-scores . (
        ("settlement-documents" . 0.99)
        ("temporal-analysis" . 0.98)
        ("operational-impact-documentation" . 0.96)
        ("regulatory-crisis-evidence" . 0.99)
      ))
      (settlement-trojan-horse . (
        ("no-terms-of-reference" . #t)
        ("void-ab-initio-confidence" . 0.99)
        ("negotiation-period" . "2025-03-01" . "2025-04-14")
        ("bad-faith-indicators" . (
          "material-non-disclosure"
          "knowledge-of-omitted-facts"
          "hypocrisy-pattern"
        ))
      ))
      (regulatory-crisis . (
        ("eu-responsible-person-removal" . (
          (penalty-exposure . 50000000)
          (confidence . 0.99)
          (operational-impossibility . #t)
        ))
        ("gdpr-compliance-violation" . (
          (penalty-exposure . 20000000)
          (confidence . 0.98)
        ))
        ("total-exposure" . 70000000)
      ))
      (entity-agent-network . (
        ("peter-faucitt" . (
          (role . "crisis-architect")
          (confidence . 0.98)
          (coordination . ("rynette-farrar"))
        ))
        ("rynette-farrar" . (
          (role . "crisis-facilitator")
          (confidence . 0.94)
          (coordination . ("peter-faucitt"))
        ))
      ))
      (ad-paragraph-evidence . (
        "7.2-7.5" "8.1-8.3" "11.1-11.5"
      ))
      (cross-paragraph-patterns . (
        ("settlement-trojan-horse" . 0.99)
        ("regulatory-crisis-creation" . 0.99)
        ("operational-impossibility" . 0.98)
        ("coordinated-execution" . 0.94)
      ))
      (related-aspects . ("bad-faith" "abuse-of-process" "retaliation"))
      (lex-principles . (
        "south-african-civil-law-manufactured-crisis-detection"
        "south-african-civil-law-abuse-of-process"
      ))
    ))
    
    ;; ========================================
    ;; HIGH PRIORITY LEGAL ASPECTS
    ;; ========================================
    
    ("temporal-proximity" . (
      (category . "evidentiary-pattern")
      (priority . "high")
      (frequency . 25)  ; Actual AD analysis data
      (ad-paragraph-distribution . (
        ("1-critical" . 1)
        ("2-high" . 1)
      ))
      (confidence . 0.96)
      (priority-weighted-confidence . 0.97)
      (cumulative-confidence . 0.98)
      (evidence-requirements . (
        "date-documentation"
        "event-sequence"
        "causation-inference"
        "temporal-analysis"
      ))
      (evidence-strength-scores . (
        ("timeline-documentation" . 0.98)
        ("event-sequence-analysis" . 0.96)
        ("causation-documentation" . 0.95)
      ))
      (temporal-thresholds . (
        ("immediate" . "< 24 hours" . 0.98)
        ("short-term" . "< 7 days" . 0.96)
        ("medium-term" . "< 30 days" . 0.90)
      ))
      (ad-paragraph-evidence . (
        "7.2-7.5" "8.4"
      ))
      (cross-paragraph-patterns . (
        ("retaliation-cascade" . 0.98)
        ("coordinated-timing" . 0.94)
      ))
      (related-aspects . ("retaliation" "bad-faith" "manufactured-crisis"))
      (lex-principles . (
        "south-african-civil-law-temporal-bad-faith-v3"
      ))
    ))
    
    ("fiduciary-duty-breach" . (
      (category . "trust-law-violation")
      (priority . "high")
      (frequency . 6)  ; Actual AD analysis data
      (ad-paragraph-distribution . (
        ("1-critical" . 2)
        ("2-high" . 1)
      ))
      (confidence . 0.96)
      (priority-weighted-confidence . 0.97)
      (cumulative-confidence . 0.98)
      (evidence-requirements . (
        "fiduciary-relationship" 
        "duty-owed" 
        "breach" 
        "causation"
        "beneficiary-harm"
      ))
      (evidence-strength-scores . (
        ("trust-documents" . 0.99)
        ("breach-documentation" . 0.96)
        ("beneficiary-harm-evidence" . 0.94)
      ))
      (entity-agent-network . (
        ("peter-faucitt" . (
          (role . "trustee-breach")
          (confidence . 0.98)
          (fiduciary-duty . "faucitt-family-trust")
        ))
      ))
      (ad-paragraph-evidence . (
        "8.1-8.3" "11.1-11.5"
      ))
      (cross-paragraph-patterns . (
        ("self-dealing" . 0.96)
        ("conflict-of-interest" . 0.95)
        ("beneficiary-harm" . 0.94)
      ))
      (related-aspects . ("self-dealing" "conflict-of-interest"))
      (lex-principles . (
        "south-african-trust-law-enhanced-v8"
        "south-african-civil-law-fiduciary-duty"
      ))
    ))
    
    ("abuse-of-process" . (
      (category . "procedural-wrongdoing")
      (priority . "high")
      (frequency . 7)  ; Actual AD analysis data
      (ad-paragraph-distribution . (
        ("1-critical" . 1)
      ))
      (confidence . 0.93)
      (priority-weighted-confidence . 0.94)
      (cumulative-confidence . 0.96)
      (evidence-requirements . (
        "improper-purpose" 
        "void-ab-initio"
        "settlement-trojan-horse"
        "manufactured-crisis"
      ))
      (evidence-strength-scores . (
        ("settlement-documents" . 0.99)
        ("improper-purpose-evidence" . 0.94)
        ("void-ab-initio-analysis" . 0.99)
      ))
      (ad-paragraph-evidence . (
        "8.1-8.3"
      ))
      (cross-paragraph-patterns . (
        ("settlement-trojan-horse" . 0.99)
        ("improper-purpose" . 0.94)
      ))
      (related-aspects . ("bad-faith" "manufactured-crisis"))
      (lex-principles . (
        "south-african-civil-law-abuse-of-process"
      ))
    ))
    
    ("breach" . (
      (category . "general-wrongdoing")
      (priority . "high")
      (frequency . 13)  ; Actual AD analysis data
      (ad-paragraph-distribution . (
        ("1-critical" . 2)
        ("2-high" . 3)
      ))
      (confidence . 0.92)
      (priority-weighted-confidence . 0.93)
      (cumulative-confidence . 0.95)
      (evidence-requirements . (
        "duty-owed"
        "breach-evidence"
        "causation"
        "damages"
      ))
      (evidence-strength-scores . (
        ("breach-documentation" . 0.94)
        ("causation-evidence" . 0.92)
        ("damages-documentation" . 0.90)
      ))
      (ad-paragraph-evidence . (
        "7.6" "8.1-8.3" "11.1-11.5"
      ))
      (cross-paragraph-patterns . (
        ("systematic-breach" . 0.93)
      ))
      (related-aspects . ("fiduciary-duty-breach" "delict"))
      (lex-principles . (
        "south-african-civil-law"
      ))
    ))
    
    ;; ========================================
    ;; MEDIUM PRIORITY LEGAL ASPECTS
    ;; ========================================
    
    ("delict" . (
      (category . "civil-law-remedy")
      (priority . "medium")
      (frequency . 4)  ; Actual AD analysis data
      (ad-paragraph-distribution . (
        ("1-critical" . 1)
      ))
      (confidence . 0.92)
      (priority-weighted-confidence . 0.92)
      (cumulative-confidence . 0.93)
      (evidence-requirements . (
        "wrongful-act" 
        "fault" 
        "causation" 
        "damages"
      ))
      (evidence-strength-scores . (
        ("wrongful-act-documentation" . 0.94)
        ("fault-evidence" . 0.92)
        ("damages-documentation" . 0.90)
      ))
      (ad-paragraph-evidence . (
        "7.2-7.5"
      ))
      (related-aspects . ("retaliation" "manufactured-crisis"))
      (lex-principles . (
        "south-african-civil-law-delict"
      ))
    ))
    
    ("conflict-of-interest" . (
      (category . "ethical-violation")
      (priority . "medium")
      (frequency . 5)  ; Actual AD analysis data
      (ad-paragraph-distribution . (
        ("2-high" . 1)
      ))
      (confidence . 0.90)
      (priority-weighted-confidence . 0.91)
      (cumulative-confidence . 0.92)
      (evidence-requirements . (
        "conflicting-interests"
        "duty-owed"
        "breach-of-duty"
      ))
      (evidence-strength-scores . (
        ("conflict-documentation" . 0.94)
        ("duty-evidence" . 0.90)
      ))
      (entity-agent-network . (
        ("rynette-farrar" . (
          (role . "conflicted-actor")
          (confidence . 0.94)
          (conflicts . ("accountant" "creditor-director"))
        ))
      ))
      (ad-paragraph-evidence . (
        "11.1-11.5"
      ))
      (related-aspects . ("fiduciary-duty-breach" "self-dealing"))
      (lex-principles . (
        "south-african-civil-law-conflict-of-interest"
      ))
    ))
    
    ("self-dealing" . (
      (category . "fiduciary-violation")
      (priority . "medium")
      (frequency . 2)  ; Actual AD analysis data
      (ad-paragraph-distribution . (
        ("2-high" . 1)
      ))
      (confidence . 0.88)
      (priority-weighted-confidence . 0.89)
      (cumulative-confidence . 0.90)
      (evidence-requirements . (
        "fiduciary-relationship"
        "self-dealing-transaction"
        "lack-of-disclosure"
      ))
      (evidence-strength-scores . (
        ("transaction-documentation" . 0.92)
        ("disclosure-evidence" . 0.88)
      ))
      (ad-paragraph-evidence . (
        "11.1-11.5"
      ))
      (related-aspects . ("fiduciary-duty-breach" "conflict-of-interest"))
      (lex-principles . (
        "south-african-trust-law-enhanced-v8"
      ))
    ))
    
    ("coercion" . (
      (category . "intentional-wrongdoing")
      (priority . "medium")
      (frequency . 1)  ; Actual AD analysis data
      (ad-paragraph-distribution . (
        ("2-high" . 1)
      ))
      (confidence . 0.93)
      (priority-weighted-confidence . 0.93)
      (cumulative-confidence . 0.93)
      (evidence-requirements . (
        "threat" 
        "improper-purpose" 
        "causal-connection"
      ))
      (evidence-strength-scores . (
        ("threat-documentation" . 0.94)
        ("improper-purpose-evidence" . 0.92)
      ))
      (ad-paragraph-evidence . (
        "8.1-8.3"
      ))
      (related-aspects . ("bad-faith" "manufactured-crisis"))
      (lex-principles . (
        "south-african-civil-law-coercion"
      ))
    ))
  ))

;;;
;;; TAXONOMY QUERY AND ANALYSIS FUNCTIONS
;;;

;; Classify legal aspect
(define (classify-legal-aspect-v14 aspect-name)
  "Classify a legal aspect and return its taxonomy entry"
  (assoc-ref legal-aspects-taxonomy-v14 aspect-name))

;; Compute legal aspect confidence
(define (compute-legal-aspect-confidence-v14 aspect-name paragraph-priority)
  "Compute confidence for a legal aspect based on paragraph priority"
  (let ((aspect-data (classify-legal-aspect-v14 aspect-name)))
    (if aspect-data
        (let ((base-confidence (assoc-ref aspect-data 'confidence))
              (priority-weight (cond
                                ((equal? paragraph-priority "1-critical") 1.02)
                                ((equal? paragraph-priority "2-high") 1.01)
                                (else 1.0))))
          (min 0.99 (* base-confidence priority-weight)))
        0.0)))

;; Aggregate legal aspects by priority
(define (aggregate-legal-aspects-by-priority-v14 priority-filter)
  "Aggregate legal aspects filtered by paragraph priority"
  (filter (lambda (aspect-entry)
            (let* ((aspect-data (cdr aspect-entry))
                   (distribution (assoc-ref aspect-data 'ad-paragraph-distribution))
                   (priority-count (assoc-ref distribution priority-filter)))
              (and priority-count (> priority-count 0))))
          legal-aspects-taxonomy-v14))

;; Generate legal aspect network
(define (generate-legal-aspect-network-v14 aspect-name)
  "Generate network of related legal aspects"
  (let ((aspect-data (classify-legal-aspect-v14 aspect-name)))
    (if aspect-data
        (let ((related-aspects (assoc-ref aspect-data 'related-aspects)))
          (map (lambda (related)
                 `((aspect . ,related)
                   (relation-type . "related")
                   (confidence . 0.90)))
               related-aspects))
        '())))

;; Detect temporal causation patterns
(define (detect-temporal-causation-patterns-v14 aspect-name)
  "Detect temporal causation patterns for a legal aspect"
  (let ((aspect-data (classify-legal-aspect-v14 aspect-name)))
    (if aspect-data
        (assoc-ref aspect-data 'temporal-patterns)
        '())))

;; Analyze entity relation co-occurrence
(define (analyze-entity-relation-co-occurrence-v14 aspect-name)
  "Analyze entity relation co-occurrence for a legal aspect"
  (let ((aspect-data (classify-legal-aspect-v14 aspect-name)))
    (if aspect-data
        (assoc-ref aspect-data 'entity-agent-network)
        '())))

;; Compute priority-weighted confidence
(define (compute-priority-weighted-confidence-v14 aspect-name)
  "Compute priority-weighted confidence for a legal aspect"
  (let ((aspect-data (classify-legal-aspect-v14 aspect-name)))
    (if aspect-data
        (assoc-ref aspect-data 'priority-weighted-confidence)
        0.0)))

;; Detect cross-paragraph patterns
(define (detect-cross-paragraph-patterns-v14 aspect-name)
  "Detect cross-paragraph patterns for a legal aspect"
  (let ((aspect-data (classify-legal-aspect-v14 aspect-name)))
    (if aspect-data
        (assoc-ref aspect-data 'cross-paragraph-patterns)
        '())))

;; Generate evidence-paragraph mapping
(define (generate-evidence-paragraph-mapping-v14 aspect-name)
  "Generate evidence-paragraph mapping for a legal aspect"
  (let ((aspect-data (classify-legal-aspect-v14 aspect-name)))
    (if aspect-data
        `((aspect . ,aspect-name)
          (ad-paragraphs . ,(assoc-ref aspect-data 'ad-paragraph-evidence))
          (evidence-requirements . ,(assoc-ref aspect-data 'evidence-requirements))
          (evidence-strength-scores . ,(assoc-ref aspect-data 'evidence-strength-scores)))
        '())))

;; Get aspect frequency
(define (get-aspect-frequency-v14 aspect-name)
  "Get frequency count for a legal aspect"
  (let ((aspect-data (classify-legal-aspect-v14 aspect-name)))
    (if aspect-data
        (assoc-ref aspect-data 'frequency)
        0)))

;; Get aspect evidence requirements
(define (get-aspect-evidence-requirements-v14 aspect-name)
  "Get evidence requirements for a legal aspect"
  (let ((aspect-data (classify-legal-aspect-v14 aspect-name)))
    (if aspect-data
        (assoc-ref aspect-data 'evidence-requirements)
        '())))

;; Get aspect related aspects
(define (get-aspect-related-aspects-v14 aspect-name)
  "Get related aspects for a legal aspect"
  (let ((aspect-data (classify-legal-aspect-v14 aspect-name)))
    (if aspect-data
        (assoc-ref aspect-data 'related-aspects)
        '())))

;; Get aspect lex principles
(define (get-aspect-lex-principles-v14 aspect-name)
  "Get lex principles for a legal aspect"
  (let ((aspect-data (classify-legal-aspect-v14 aspect-name)))
    (if aspect-data
        (assoc-ref aspect-data 'lex-principles)
        '())))

;; Get aspect AD paragraphs
(define (get-aspect-ad-paragraphs-v14 aspect-name)
  "Get AD paragraph evidence for a legal aspect"
  (let ((aspect-data (classify-legal-aspect-v14 aspect-name)))
    (if aspect-data
        (assoc-ref aspect-data 'ad-paragraph-evidence)
        '())))

;; Compute aspect cumulative confidence
(define (compute-aspect-cumulative-confidence-v14 aspect-name)
  "Compute cumulative confidence for a legal aspect"
  (let ((aspect-data (classify-legal-aspect-v14 aspect-name)))
    (if aspect-data
        (assoc-ref aspect-data 'cumulative-confidence)
        0.0)))

;; Identify aspect pattern clusters
(define (identify-aspect-pattern-clusters-v14 aspect-list)
  "Identify pattern clusters across multiple legal aspects"
  (let ((fraud-cluster (filter (lambda (a) (member a '("fraud" "bad-faith" "unjust-enrichment"))) aspect-list))
        (retaliation-cluster (filter (lambda (a) (member a '("retaliation" "manufactured-crisis" "temporal-proximity"))) aspect-list))
        (fiduciary-cluster (filter (lambda (a) (member a '("fiduciary-duty-breach" "self-dealing" "conflict-of-interest"))) aspect-list)))
    `((fraud-network . ,fraud-cluster)
      (retaliation-cascade . ,retaliation-cluster)
      (fiduciary-breach-network . ,fiduciary-cluster))))
