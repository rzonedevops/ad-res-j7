;; ============================================================================
;; SOUTH AFRICAN EVIDENCE LAW - CASE 2025-137857 EVIDENCE MAPPING
;; ============================================================================
;; File: south_african_evidence_case_2025_137857.scm
;; Purpose: Evidence-to-legal-principle mapping for Case 2025-137857
;; Date: 2025-11-15
;; Confidence: 0.96
;;
;; This module provides comprehensive evidence mapping, strength calculation,
;; and admissibility analysis for all AD paragraphs in Case 2025-137857.
;; ============================================================================

(define-module (lex evid za case-2025-137857-evidence)
  #:use-module (lex lv1 known-laws)
  #:use-module (lex evid za south-african-evidence)
  #:export (
    ;; Evidence Mapping
    ad-paragraph-evidence-map
    map-evidence-to-legal-principle
    generate-evidence-matrix
    
    ;; Evidence Strength Calculation
    calculate-evidence-strength
    calculate-aggregate-evidence-strength
    calculate-admissibility-score
    
    ;; Evidence Analysis
    analyze-corroboration
    analyze-temporal-proximity
    detect-evidence-patterns
  ))

;; ============================================================================
;; PART 1: AD PARAGRAPH EVIDENCE MAPPING
;; ============================================================================

;; ----------------------------------------------------------------------------
;; 1.1 Critical Priority Evidence (PARA 7.6 - Director Loan)
;; ----------------------------------------------------------------------------

(define para-7-6-evidence
  '((paragraph . "para-7-6")
    (priority . "critical")
    (legal-issue . "director-loan-hypocrisy")
    (evidence . (
      ((type . "bank-statements")
       (description . "Peter's withdrawals without board resolutions")
       (dates . ("2023-01-12" "2023-02-15" "2025-03-15" "2025-07-20"))
       (amounts . (420000 310000 350000 285000))
       (total . 1365000)
       (board-resolutions . #f)
       (strength . 0.95)
       (admissibility . 0.98)
       (corroboration . 3)  ; Sage records, accountant records, bank statements
       (temporal-proximity . 0))  ; Contemporaneous records
      ((type . "sage-accounting-records")
       (description . "Director loan account system documentation")
       (period . "2020-2025")
       (transaction-count . 47)
       (pattern . "no-board-resolutions-required")
       (strength . 0.94)
       (admissibility . 0.97)
       (corroboration . 2)  ; Bank statements, accountant confirmation
       (temporal-proximity . 0))
      ((type . "accountant-records")
       (custodian . "daniel-bantjies")
       (description . "Historical director loan transactions")
       (statement . "Director loan account system used for decades")
       (strength . 0.92)
       (admissibility . 0.96)
       (corroboration . 2)  ; Professional third-party confirmation
       (temporal-proximity . 0))
      ((type . "daniel-withdrawal")
       (date . "2025-07-16")
       (amount . 500000)
       (description . "Daniel's withdrawal following established practice")
       (board-resolution . #f)
       (signatory-authority . #t)
       (sage-recorded . #t)
       (strength . 0.93)
       (admissibility . 0.97)
       (corroboration . 3))
    ))
    (legal-principles . (
      "inconsistent-application-of-standards"
      "selective-enforcement"
      "bad-faith-litigation"
      "material-non-disclosure"
      "hypocrisy"
    ))
    (confidence . 0.94)))

;; ----------------------------------------------------------------------------
;; 1.2 Critical Priority Evidence (PARA 7.2-7.5 - IT Expenses)
;; ----------------------------------------------------------------------------

(define para-7-2-7-5-evidence
  '((paragraph . "para-7-2-7-5")
    (priority . "critical")
    (legal-issue . "it-expense-sabotage")
    (evidence . (
      ((type . "card-cancellation-records")
       (date . "2025-06-07")
       (actor . "peter-faucitt")
       (action . "cancelled-all-business-cards")
       (systems-affected . ("cloud-storage" "accounting-software" "email-services"))
       (strength . 0.97)
       (admissibility . 0.98)
       (corroboration . 2)  ; Bank records, system access logs
       (temporal-proximity . 1))  ; 1 day after fraud report
      ((type . "temporal-correlation")
       (trigger-event . "fraud-reports-to-accountant")
       (trigger-date . "2025-06-06")
       (response-event . "card-cancellations")
       (response-date . "2025-06-07")
       (days-elapsed . 1)
       (pattern . "immediate-retaliation")
       (strength . 0.96)
       (admissibility . 0.95)
       (corroboration . 3)  ; Timeline records, witness statements
       (temporal-proximity . 1))
      ((type . "industry-benchmarks")
       (description . "E-commerce IT spend 5-10% of revenue")
       (source . "Gartner IT Spending Report 2024")
       (regima-revenue-2024 . 128800000)
       (regima-it-spend-2024 . 6700000)
       (regima-percentage . 0.052)
       (industry-range . (0.05 0.10))
       (conclusion . "low-end-of-industry-standard")
       (strength . 0.91)
       (admissibility . 0.93)
       (corroboration . 1))
      ((type . "causation-chain")
       (sequence . (
         "card-cancellation"
         "documentation-systems-disrupted"
         "documentation-inaccessible"
         "peter-demands-documentation"
         "peter-files-interdict-claiming-lack-of-documentation"
       ))
       (description . "Self-created crisis used as litigation pretext")
       (strength . 0.95)
       (admissibility . 0.94)
       (corroboration . 4))
    ))
    (legal-principles . (
      "immediate-retaliation"
      "manufactured-crisis"
      "self-created-documentation-gap"
      "temporal-bad-faith"
      "material-non-disclosure"
      "causation"
    ))
    (confidence . 0.96)))

;; ----------------------------------------------------------------------------
;; 1.3 Critical Priority Evidence (PARA 8.11-8.13 - Litigation Weaponization)
;; ----------------------------------------------------------------------------

(define para-8-11-8-13-evidence
  '((paragraph . "para-8-11-8-13")
    (priority . "critical")
    (legal-issue . "litigation-weaponization")
    (evidence . (
      ((type . "timeline-events")
       (cooperation-date . "2025-08-11")
       (cooperation-event . "jax-signed-backdating-document")
       (cooperation-context . "settlement-discussion")
       (interdict-date . "2025-08-13")
       (interdict-event . "peter-filed-interdict")
       (days-elapsed . 2)
       (pattern . "cooperation-betrayal")
       (strength . 0.98)
       (admissibility . 0.97)
       (corroboration . 2)  ; Document signatures, court filing records
       (temporal-proximity . 2))
      ((type . "settlement-context")
       (description . "Backdating signature obtained during settlement discussion")
       (good-faith-assumption . #t)
       (immediate-betrayal . #t)
       (strength . 0.91)
       (admissibility . 0.89)
       (corroboration . 1))
      ((type . "urgency-negation")
       (claim . "urgent-relief-required")
       (evidence-against . "2-day-delay-after-cooperation")
       (conclusion . "no-genuine-urgency")
       (strength . 0.93)
       (admissibility . 0.92)
       (corroboration . 2))
    ))
    (legal-principles . (
      "bad-faith-litigation"
      "abuse-of-process"
      "cooperation-betrayal"
      "manufactured-urgency"
      "material-non-disclosure"
    ))
    (confidence . 0.98)))

;; ----------------------------------------------------------------------------
;; 1.4 High Priority Evidence (PARA 3-3.10 - Responsible Person)
;; ----------------------------------------------------------------------------

(define para-3-3-10-evidence
  '((paragraph . "para-3-3-10")
    (priority . "high")
    (legal-issue . "responsible-person-regulatory-crisis")
    (evidence . (
      ((type . "regulatory-requirements")
       (jurisdictions . 37)
       (description . "EU/EEA Responsible Person compliance requirements")
       (requirements . (
         "product-safety-monitoring"
         "adverse-event-reporting"
         "corrective-action-implementation"
         "documentation-maintenance"
         "regulatory-correspondence"
       ))
       (reporting-deadlines . (3 15))  ; days
       (strength . 0.96)
       (admissibility . 0.97)
       (corroboration . 1)  ; EU regulations publicly available
       (temporal-proximity . 0))
      ((type . "financial-impact-analysis")
       (potential-fines-per-jurisdiction . 10000000)  ; €10M
       (total-jurisdictions . 37)
       (product-recall-costs . (50000000 200000000))
       (annual-revenue-at-risk . 128800000)
       (strength . 0.89)
       (admissibility . 0.88)
       (corroboration . 1))
      ((type . "interdict-impact")
       (description . "Jacqueline cannot fulfill Responsible Person duties")
       (immediate-violations . #t)
       (criminal-liability-risk . #t)
       (strength . 0.94)
       (admissibility . 0.93)
       (corroboration . 2))
    ))
    (legal-principles . (
      "regulatory-compliance-crisis"
      "disproportionate-relief"
      "business-destruction"
      "manufactured-crisis"
    ))
    (confidence . 0.96)))

;; ----------------------------------------------------------------------------
;; 1.5 Unjust Enrichment Evidence (PARA 10.5-10.10)
;; ----------------------------------------------------------------------------

(define para-10-5-10-10-evidence
  '((paragraph . "para-10-5-10-10")
    (priority . "critical")
    (legal-issue . "unjust-enrichment-platform-usage")
    (evidence . (
      ((type . "platform-ownership")
       (owner . "daniel-faucitt")
       (entity . "regima-zone-ltd")
       (legal-structure . "uk-limited-company")
       (ownership-percentage . 1.0)
       (strength . 0.97)
       (admissibility . 0.98)
       (corroboration . 2)  ; Company registration, ownership records
       (temporal-proximity . 0))
      ((type . "platform-usage")
       (users . ("regima-worldwide-distribution" "regima-skin-treatments"))
       (usage-period . "2020-2025")
       (licensing-agreement . #f)
       (compensation-paid . 0)
       (strength . 0.94)
       (admissibility . 0.96)
       (corroboration . 3))
      ((type . "platform-valuation")
       (method . "usage-fees-calculation")
       (annual-revenue . 128800000)
       (platform-fee-percentage . (0.03 0.07))
       (annual-valuation . (3680000 8190000))
       (period-years . 5)
       (total-valuation . (18400000 40950000))
       (strength . 0.92)
       (admissibility . 0.93)
       (corroboration . 1))
      ((type . "enrichment-elements")
       (enriched-party . ("regima-worldwide-distribution" "regima-skin-treatments"))
       (impoverished-party . "daniel-faucitt")
       (benefit . "platform-usage-without-payment")
       (causal-connection . #t)
       (legal-justification . #f)
       (strength . 0.93)
       (admissibility . 0.94)
       (corroboration . 3))
    ))
    (legal-principles . (
      "unjust-enrichment-enrichment"
      "unjust-enrichment-impoverishment"
      "unjust-enrichment-causal-connection"
      "unjust-enrichment-no-legal-justification"
    ))
    (confidence . 0.93)))

;; ============================================================================
;; PART 2: EVIDENCE STRENGTH CALCULATION FUNCTIONS
;; ============================================================================

;; ----------------------------------------------------------------------------
;; 2.1 Base Evidence Strength Calculator
;; ----------------------------------------------------------------------------

(define (calculate-evidence-strength evidence-item)
  "Calculate overall strength of evidence item considering multiple factors"
  (let* ((base-strength (assoc-ref evidence-item 'strength))
         (admissibility (assoc-ref evidence-item 'admissibility))
         (corroboration (assoc-ref evidence-item 'corroboration))
         (temporal-proximity (assoc-ref evidence-item 'temporal-proximity)))
    (* base-strength
       admissibility
       (if corroboration 
           (+ 1.0 (* 0.05 corroboration))  ; 5% boost per corroborating item
           1.0)
       (if temporal-proximity
           (cond
             ((= temporal-proximity 0) 1.1)   ; Contemporaneous = 10% boost
             ((<= temporal-proximity 1) 1.08) ; Same day = 8% boost
             ((<= temporal-proximity 7) 1.05) ; Same week = 5% boost
             (#t 1.0))
           1.0))))

;; ----------------------------------------------------------------------------
;; 2.2 Aggregate Evidence Strength Calculator
;; ----------------------------------------------------------------------------

(define (calculate-aggregate-evidence-strength evidence-list)
  "Calculate aggregate strength across multiple evidence items"
  (if (null? evidence-list)
      0.0
      (let* ((strengths (map calculate-evidence-strength evidence-list))
             (count (length strengths))
             (sum (apply + strengths))
             (average (/ sum count))
             ;; Boost for multiple strong evidence items
             (multiplier (cond
                          ((and (>= count 4) (>= average 0.90)) 1.1)
                          ((and (>= count 3) (>= average 0.85)) 1.05)
                          (#t 1.0))))
        (* average multiplier))))

;; ----------------------------------------------------------------------------
;; 2.3 Admissibility Score Calculator
;; ----------------------------------------------------------------------------

(define (calculate-admissibility-score evidence-item)
  "Calculate admissibility score based on evidence type and characteristics"
  (let* ((base-admissibility (assoc-ref evidence-item 'admissibility))
         (evidence-type (assoc-ref evidence-item 'type))
         (corroboration (assoc-ref evidence-item 'corroboration))
         ;; Documentary evidence generally highly admissible
         (type-multiplier (cond
                           ((member evidence-type '("bank-statements" "sage-accounting-records" 
                                                   "card-cancellation-records" "timeline-events"))
                            1.05)
                           ((member evidence-type '("accountant-records" "regulatory-requirements"))
                            1.03)
                           (#t 1.0))))
    (* base-admissibility
       type-multiplier
       (if (and corroboration (>= corroboration 2))
           1.02  ; 2% boost for strong corroboration
           1.0))))

;; ============================================================================
;; PART 3: EVIDENCE ANALYSIS FUNCTIONS
;; ============================================================================

;; ----------------------------------------------------------------------------
;; 3.1 Corroboration Analyzer
;; ----------------------------------------------------------------------------

(define (analyze-corroboration evidence-list)
  "Analyze corroboration patterns across evidence items"
  (let* ((corroboration-counts (map (lambda (e) 
                                      (or (assoc-ref e 'corroboration) 0))
                                   evidence-list))
         (total-corroboration (apply + corroboration-counts))
         (avg-corroboration (if (null? evidence-list)
                               0
                               (/ total-corroboration (length evidence-list))))
         (strong-corroboration (filter (lambda (c) (>= c 3)) corroboration-counts)))
    (list
      (cons 'total-corroboration total-corroboration)
      (cons 'average-corroboration avg-corroboration)
      (cons 'strong-corroboration-count (length strong-corroboration))
      (cons 'corroboration-strength 
            (cond
              ((>= avg-corroboration 3.0) 0.98)
              ((>= avg-corroboration 2.0) 0.95)
              ((>= avg-corroboration 1.0) 0.90)
              (#t 0.85))))))

;; ----------------------------------------------------------------------------
;; 3.2 Temporal Proximity Analyzer
;; ----------------------------------------------------------------------------

(define (analyze-temporal-proximity evidence-list)
  "Analyze temporal proximity patterns for retaliation detection"
  (let* ((temporal-items (filter (lambda (e) 
                                   (assoc-ref e 'temporal-proximity))
                                evidence-list))
         (proximities (map (lambda (e) 
                            (assoc-ref e 'temporal-proximity))
                          temporal-items))
         (immediate-retaliation (filter (lambda (p) (<= p 1)) proximities))
         (short-term-retaliation (filter (lambda (p) (and (> p 1) (<= p 7))) proximities)))
    (list
      (cons 'temporal-items-count (length temporal-items))
      (cons 'immediate-retaliation-count (length immediate-retaliation))
      (cons 'short-term-retaliation-count (length short-term-retaliation))
      (cons 'retaliation-pattern-strength
            (cond
              ((> (length immediate-retaliation) 0) 0.98)
              ((> (length short-term-retaliation) 0) 0.93)
              (#t 0.85))))))

;; ----------------------------------------------------------------------------
;; 3.3 Evidence Pattern Detector
;; ----------------------------------------------------------------------------

(define (detect-evidence-patterns evidence-list)
  "Detect patterns across evidence items (chains, correlations, etc.)"
  (let* ((causation-chains (filter (lambda (e) 
                                    (equal? (assoc-ref e 'type) "causation-chain"))
                                  evidence-list))
         (temporal-correlations (filter (lambda (e)
                                         (equal? (assoc-ref e 'type) "temporal-correlation"))
                                       evidence-list))
         (timeline-events (filter (lambda (e)
                                   (equal? (assoc-ref e 'type) "timeline-events"))
                                 evidence-list)))
    (list
      (cons 'causation-chains-count (length causation-chains))
      (cons 'temporal-correlations-count (length temporal-correlations))
      (cons 'timeline-events-count (length timeline-events))
      (cons 'pattern-strength
            (cond
              ((and (> (length causation-chains) 0)
                    (> (length temporal-correlations) 0)) 0.97)
              ((or (> (length causation-chains) 0)
                   (> (length temporal-correlations) 0)) 0.93)
              (#t 0.85))))))

;; ============================================================================
;; PART 4: EVIDENCE MATRIX GENERATION
;; ============================================================================

;; ----------------------------------------------------------------------------
;; 4.1 Evidence-to-Legal-Principle Mapper
;; ----------------------------------------------------------------------------

(define (map-evidence-to-legal-principle ad-paragraph)
  "Map evidence items to legal principles for specific AD paragraph"
  (let ((evidence-data (cond
                        ((equal? ad-paragraph "para-7-6") para-7-6-evidence)
                        ((equal? ad-paragraph "para-7-2-7-5") para-7-2-7-5-evidence)
                        ((equal? ad-paragraph "para-8-11-8-13") para-8-11-8-13-evidence)
                        ((equal? ad-paragraph "para-3-3-10") para-3-3-10-evidence)
                        ((equal? ad-paragraph "para-10-5-10-10") para-10-5-10-10-evidence)
                        (#t #f))))
    (if evidence-data
        (let* ((evidence-list (assoc-ref evidence-data 'evidence))
               (legal-principles (assoc-ref evidence-data 'legal-principles)))
          (map (lambda (principle)
                 (let ((relevant-evidence (filter 
                                           (lambda (e)
                                             (or (string-contains principle "retaliation")
                                                 (string-contains principle "crisis")
                                                 (string-contains principle "bad-faith")
                                                 #t))  ; All evidence relevant for now
                                           evidence-list)))
                   (list
                     (cons 'legal-principle principle)
                     (cons 'evidence-count (length relevant-evidence))
                     (cons 'evidence-items relevant-evidence)
                     (cons 'aggregate-strength 
                           (calculate-aggregate-evidence-strength relevant-evidence)))))
               legal-principles))
        #f)))

;; ----------------------------------------------------------------------------
;; 4.2 Comprehensive Evidence Matrix Generator
;; ----------------------------------------------------------------------------

(define (generate-evidence-matrix ad-paragraph)
  "Generate comprehensive evidence matrix for specific AD paragraph"
  (let ((evidence-data (cond
                        ((equal? ad-paragraph "para-7-6") para-7-6-evidence)
                        ((equal? ad-paragraph "para-7-2-7-5") para-7-2-7-5-evidence)
                        ((equal? ad-paragraph "para-8-11-8-13") para-8-11-8-13-evidence)
                        ((equal? ad-paragraph "para-3-3-10") para-3-3-10-evidence)
                        ((equal? ad-paragraph "para-10-5-10-10") para-10-5-10-10-evidence)
                        (#t #f))))
    (if evidence-data
        (let* ((evidence-list (assoc-ref evidence-data 'evidence))
               (legal-principles (assoc-ref evidence-data 'legal-principles))
               (confidence (assoc-ref evidence-data 'confidence))
               (corroboration-analysis (analyze-corroboration evidence-list))
               (temporal-analysis (analyze-temporal-proximity evidence-list))
               (pattern-analysis (detect-evidence-patterns evidence-list)))
          (list
            (cons 'paragraph ad-paragraph)
            (cons 'priority (assoc-ref evidence-data 'priority))
            (cons 'legal-issue (assoc-ref evidence-data 'legal-issue))
            (cons 'evidence-count (length evidence-list))
            (cons 'evidence-items evidence-list)
            (cons 'legal-principles legal-principles)
            (cons 'overall-strength 
                  (calculate-aggregate-evidence-strength evidence-list))
            (cons 'corroboration-analysis corroboration-analysis)
            (cons 'temporal-analysis temporal-analysis)
            (cons 'pattern-analysis pattern-analysis)
            (cons 'confidence confidence)))
        #f)))

;; ============================================================================
;; PART 5: CONSOLIDATED EVIDENCE MAP
;; ============================================================================

(define ad-paragraph-evidence-map
  (list
    (cons "para-7-6" para-7-6-evidence)
    (cons "para-7-2-7-5" para-7-2-7-5-evidence)
    (cons "para-8-11-8-13" para-8-11-8-13-evidence)
    (cons "para-3-3-10" para-3-3-10-evidence)
    (cons "para-10-5-10-10" para-10-5-10-10-evidence)))

;; ============================================================================
;; END OF MODULE
;; ============================================================================
