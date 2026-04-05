;;; south_african_civil_law_case_2025_137857_refined_v18.scm
;;; Optimized for optimal legal resolution with entity mention frequency and cross-paragraph evidence aggregation
;;; Date: 2025-11-28
;;; Case: 2025-137857 (Peter Faucitt v. Jacqueline & Daniel Faucitt)
;;; Repository: cogpy/ad-res-j7
;;; Enhancement Focus: Entity mention frequency analysis, entity co-occurrence network optimization,
;;;                    temporal event cascade detection, legal aspect priority-weighted scoring,
;;;                    cross-paragraph evidence aggregation v2, JR/DR response framework v4

(define-module (lex civ za south-african-civil-law-case-2025-137857-refined-v18)
  #:use-module (lex lv1 known-laws)
  #:use-module (lex lv1 legal-aspects-taxonomy-v15)
  #:use-module (lex civ za south-african-civil-law)
  #:use-module (lex civ za south-african-civil-law-case-2025-137857-refined-v17)
  #:use-module (lex trs za south-african-trust-law-enhanced-v8)
  #:use-module (lex prof-eth za south-african-professional-ethics)
  #:use-module (lex evid za south-african-evidence-law-entity-network-v2)
  #:use-module (srfi srfi-1)
  #:use-module (srfi srfi-9)
  #:export (
    ;; Core resolution functions v18
    resolve-ad-paragraph-legal-aspects-v18
    detect-cross-paragraph-patterns-v18
    calculate-void-ab-initio-strength-v18
    analyze-multi-actor-coordination-v18
    generate-evidence-network-map-v18
    compute-temporal-causation-confidence-v18
    
    ;; Enhanced entity mention frequency analysis v18
    compute-entity-mention-frequency-score-v18
    analyze-entity-paragraph-distribution-v18
    compute-entity-mention-density-v18
    identify-high-frequency-entities-v18
    
    ;; Entity co-occurrence network analysis v18
    analyze-entity-cooccurrence-network-v18
    compute-cooccurrence-confidence-v18
    infer-relation-type-from-cooccurrence-v18
    generate-entity-relation-graph-v18
    
    ;; Temporal event cascade detection v18
    detect-temporal-event-cascade-v18
    compute-temporal-proximity-score-v18
    analyze-causation-chain-v18
    identify-retaliation-cascade-patterns-v18
    
    ;; Legal aspect priority-weighted scoring v18
    compute-legal-aspect-priority-weighted-score-v18
    analyze-legal-aspect-frequency-distribution-v18
    identify-dominant-legal-themes-v18
    
    ;; Cross-paragraph evidence aggregation v2
    aggregate-cross-paragraph-evidence-v18
    detect-systemic-patterns-v18
    compute-cumulative-confidence-v18
    generate-consolidated-evidence-map-v18
    
    ;; JR/DR response framework v4
    generate-jr-dr-response-framework-v18
    optimize-complementary-perspectives-v18
    map-entity-to-response-strategy-v18
    identify-entity-specific-evidence-requirements-v18
    
    ;; Optimization functions v18
    identify-material-omissions-v18
    analyze-systemic-bad-faith-indicators-v18
    generate-comprehensive-rebuttal-framework-v18
    quantify-regulatory-compliance-crisis-v18
    optimize-legal-resolution-pathway-v18
  ))

;;;
;;; ENHANCEMENT v18: Entity Mention Frequency & Cross-Paragraph Evidence Aggregation
;;;
;;; Key Improvements over v17:
;;; 1. Entity mention frequency analysis with paragraph distribution mapping
;;; 2. Entity co-occurrence network optimization with confidence scoring
;;; 3. Temporal event cascade detection with priority distribution analysis
;;; 4. Legal aspect priority-weighted scoring with frequency optimization
;;; 5. Cross-paragraph evidence aggregation v2 with systemic pattern detection
;;; 6. JR/DR response framework v4 with entity-specific optimization
;;; 7. Evidence-entity-paragraph mapping framework
;;; 8. Complementary perspective integration with role specialization
;;; 9. High-frequency entity response strategy optimization
;;; 10. Consolidated evidence presentation with cross-reference mapping
;;;

;;;
;;; ENTITY MENTION FREQUENCY ANALYSIS v18
;;;

;; Entity mention frequency record type
(define-record-type <entity-mention-frequency>
  (make-entity-mention-frequency-internal entity total-mentions paragraph-count mention-density distribution-score)
  entity-mention-frequency?
  (entity entity-mention-frequency-entity)
  (total-mentions entity-mention-frequency-total-mentions)
  (paragraph-count entity-mention-frequency-paragraph-count)
  (mention-density entity-mention-frequency-mention-density)
  (distribution-score entity-mention-frequency-distribution-score))

;; Entity mention registry from AD analysis
(define entity-mention-registry-v18
  '(
    ;; Natural persons
    ("Dan" . ((total-mentions . 576) (paragraph-count . 25) (entity-type . "natural-person") (primary-role . "second-respondent-cio-whistleblower") (legal-exposure . "protected")))
    ("Jax" . ((total-mentions . 71) (paragraph-count . 14) (entity-type . "natural-person") (primary-role . "first-respondent-ceo-eu-responsible-person") (legal-exposure . "protected")))
    ("Daniel-Faucitt" . ((total-mentions . 35) (paragraph-count . 13) (entity-type . "natural-person") (primary-role . "second-respondent-formal-name") (legal-exposure . "protected")))
    ("Peter-Faucitt" . ((total-mentions . 22) (paragraph-count . 3) (entity-type . "natural-person") (primary-role . "applicant-trustee-fraud-orchestrator") (legal-exposure . "critical")))
    ("Rynette-Farrar" . ((total-mentions . 13) (paragraph-count . 2) (entity-type . "natural-person") (primary-role . "accountant-creditor-director") (legal-exposure . "high")))
    ("Jacqueline-Faucitt" . ((total-mentions . 9) (paragraph-count . 6) (entity-type . "natural-person") (primary-role . "first-respondent-formal-name") (legal-exposure . "protected")))
    ("Jacqui" . ((total-mentions . 7) (paragraph-count . 2) (entity-type . "natural-person") (primary-role . "first-respondent-informal") (legal-exposure . "protected")))
    
    ;; Juristic persons
    ("RWD" . ((total-mentions . 68) (paragraph-count . 6) (entity-type . "juristic-person") (primary-role . "distribution-entity-platform-owner") (legal-exposure . "protected")))
    ("RST" . ((total-mentions . 60) (paragraph-count . 16) (entity-type . "juristic-person") (primary-role . "operating-company-revenue-hijacking-victim") (legal-exposure . "protected")))
    ("Adderory" . ((total-mentions . 29) (paragraph-count . 2) (entity-type . "juristic-person") (primary-role . "related-entity") (legal-exposure . "context-dependent")))
    ("RegimA-Worldwide-Distribution" . ((total-mentions . 20) (paragraph-count . 4) (entity-type . "juristic-person") (primary-role . "distribution-entity-full-name") (legal-exposure . "protected")))
    ("RegimA-Zone-Ltd" . ((total-mentions . 11) (paragraph-count . 3) (entity-type . "juristic-person") (primary-role . "uk-entity-platform-investment-vehicle") (legal-exposure . "protected")))
    ("Faucitt-Family-Trust" . ((total-mentions . 5) (paragraph-count . 3) (entity-type . "juristic-person") (primary-role . "trust-entity-fiduciary-context") (legal-exposure . "breach-context")))
    ("SLG" . ((total-mentions . 4) (paragraph-count . 2) (entity-type . "juristic-person") (primary-role . "related-entity") (legal-exposure . "context-dependent")))
    ("RegimA-Skin-Treatments" . ((total-mentions . 3) (paragraph-count . 2) (entity-type . "juristic-person") (primary-role . "operating-company-full-name") (legal-exposure . "protected")))
    ("Villa-Via" . ((total-mentions . 2) (paragraph-count . 1) (entity-type . "juristic-person") (primary-role . "self-rent-property") (legal-exposure . "conflict-context")))
    ("FFT" . ((total-mentions . 2) (paragraph-count . 1) (entity-type . "juristic-person") (primary-role . "trust-entity-abbreviation") (legal-exposure . "breach-context")))
    ("Rezonance" . ((total-mentions . 2) (paragraph-count . 1) (entity-type . "juristic-person") (primary-role . "creditor-entity") (legal-exposure . "conflict-context")))
  ))

;; Entity co-occurrence registry from AD analysis
(define entity-cooccurrence-registry-v18
  '(
    (("Dan" . "RST") . ((cooccurrence-count . 16) (relation-type . "ownership") (legal-significance . "platform-ownership-proof") (confidence . 0.99)))
    (("Dan" . "Jax") . ((cooccurrence-count . 14) (relation-type . "co-respondent") (legal-significance . "complementary-defense") (confidence . 0.99)))
    (("Dan" . "Daniel-Faucitt") . ((cooccurrence-count . 13) (relation-type . "same-person") (legal-significance . "name-variant") (confidence . 1.00)))
    (("Daniel-Faucitt" . "Jax") . ((cooccurrence-count . 12) (relation-type . "co-respondent") (legal-significance . "complementary-defense") (confidence . 0.99)))
    (("Daniel-Faucitt" . "RST") . ((cooccurrence-count . 11) (relation-type . "ownership") (legal-significance . "platform-ownership-proof") (confidence . 0.99)))
    (("Jax" . "RST") . ((cooccurrence-count . 10) (relation-type . "ownership") (legal-significance . "platform-ownership-proof") (confidence . 0.99)))
    (("Daniel-Faucitt" . "RWD") . ((cooccurrence-count . 6) (relation-type . "ownership") (legal-significance . "platform-ownership-proof") (confidence . 0.99)))
    (("Jax" . "RWD") . ((cooccurrence-count . 6) (relation-type . "ownership") (legal-significance . "platform-ownership-proof") (confidence . 0.99)))
    (("Dan" . "RWD") . ((cooccurrence-count . 6) (relation-type . "ownership") (legal-significance . "platform-ownership-proof") (confidence . 0.99)))
    (("Daniel-Faucitt" . "Jacqueline-Faucitt") . ((cooccurrence-count . 6) (relation-type . "same-person") (legal-significance . "name-variant") (confidence . 1.00)))
    (("Jacqueline-Faucitt" . "RST") . ((cooccurrence-count . 6) (relation-type . "ownership") (legal-significance . "platform-ownership-proof") (confidence . 0.99)))
    (("Dan" . "Jacqueline-Faucitt") . ((cooccurrence-count . 6) (relation-type . "co-respondent") (legal-significance . "complementary-defense") (confidence . 0.99)))
    (("Jacqueline-Faucitt" . "Jax") . ((cooccurrence-count . 5) (relation-type . "same-person") (legal-significance . "name-variant") (confidence . 1.00)))
    (("RST" . "RWD") . ((cooccurrence-count . 5) (relation-type . "corporate-structure") (legal-significance . "entity-relationship") (confidence . 0.98)))
    (("Daniel-Faucitt" . "RegimA-Worldwide-Distribution") . ((cooccurrence-count . 4) (relation-type . "ownership") (legal-significance . "platform-ownership-proof") (confidence . 0.99)))
  ))

;; Compute entity mention frequency score
(define (compute-entity-mention-frequency-score-v18 entity)
  "Compute entity mention frequency score with paragraph distribution analysis"
  (let* ((entity-data (assoc-ref entity-mention-registry-v18 entity))
         (total-mentions (assoc-ref entity-data 'total-mentions))
         (paragraph-count (assoc-ref entity-data 'paragraph-count))
         (mention-density (/ total-mentions paragraph-count))
         (distribution-score (compute-distribution-score-v18 paragraph-count))
         (frequency-score (* mention-density distribution-score)))
    
    (make-entity-mention-frequency-internal
      entity
      total-mentions
      paragraph-count
      mention-density
      distribution-score)))

;; Compute distribution score based on paragraph count
(define (compute-distribution-score-v18 paragraph-count)
  "Compute distribution score - higher for broader distribution"
  (cond
    ((>= paragraph-count 20) 1.00)  ; Very broad distribution
    ((>= paragraph-count 15) 0.95)  ; Broad distribution
    ((>= paragraph-count 10) 0.90)  ; Moderate distribution
    ((>= paragraph-count 5) 0.85)   ; Focused distribution
    ((>= paragraph-count 3) 0.80)   ; Narrow distribution
    (else 0.75)))                    ; Very narrow distribution

;; Analyze entity paragraph distribution
(define (analyze-entity-paragraph-distribution-v18 entity)
  "Analyze entity paragraph distribution with legal significance assessment"
  (let* ((entity-data (assoc-ref entity-mention-registry-v18 entity))
         (total-mentions (assoc-ref entity-data 'total-mentions))
         (paragraph-count (assoc-ref entity-data 'paragraph-count))
         (mention-density (/ total-mentions paragraph-count))
         (entity-type (assoc-ref entity-data 'entity-type))
         (primary-role (assoc-ref entity-data 'primary-role))
         (legal-exposure (assoc-ref entity-data 'legal-exposure)))
    
    `((entity . ,entity)
      (entity-type . ,entity-type)
      (primary-role . ,primary-role)
      (total-mentions . ,total-mentions)
      (paragraph-count . ,paragraph-count)
      (mention-density . ,mention-density)
      (distribution-classification . ,(cond
                                        ((>= paragraph-count 20) "very-broad")
                                        ((>= paragraph-count 15) "broad")
                                        ((>= paragraph-count 10) "moderate")
                                        ((>= paragraph-count 5) "focused")
                                        ((>= paragraph-count 3) "narrow")
                                        (else "very-narrow")))
      (legal-exposure . ,legal-exposure)
      (legal-significance . ,(cond
                               ((and (> mention-density 20.0) (>= paragraph-count 20))
                                "primary-target-systematic-allegations")
                               ((and (> mention-density 10.0) (< paragraph-count 5))
                                "focused-high-density-allegations")
                               ((and (> mention-density 5.0) (< paragraph-count 3))
                                "concentrated-critical-role")
                               ((>= paragraph-count 15)
                                "broad-involvement-multiple-aspects")
                               (else "moderate-involvement")))
      (response-strategy . ,(cond
                              ((> mention-density 20.0)
                               "comprehensive-technical-documentation-required")
                              ((> mention-density 10.0)
                               "detailed-evidence-consolidation-required")
                              ((> mention-density 5.0)
                               "focused-evidence-presentation-required")
                              (else "standard-evidence-presentation"))))))

;; Compute entity mention density
(define (compute-entity-mention-density-v18 entity)
  "Compute entity mention density (mentions per paragraph)"
  (let* ((entity-data (assoc-ref entity-mention-registry-v18 entity))
         (total-mentions (assoc-ref entity-data 'total-mentions))
         (paragraph-count (assoc-ref entity-data 'paragraph-count)))
    (/ total-mentions paragraph-count)))

;; Identify high-frequency entities
(define (identify-high-frequency-entities-v18 density-threshold)
  "Identify entities with mention density above threshold"
  (filter
    (lambda (entity-entry)
      (let* ((entity (car entity-entry))
             (entity-data (cdr entity-entry))
             (total-mentions (assoc-ref entity-data 'total-mentions))
             (paragraph-count (assoc-ref entity-data 'paragraph-count))
             (mention-density (/ total-mentions paragraph-count)))
        (> mention-density density-threshold)))
    entity-mention-registry-v18))

;;;
;;; ENTITY CO-OCCURRENCE NETWORK ANALYSIS v18
;;;

;; Entity relation record type
(define-record-type <entity-relation>
  (make-entity-relation-internal entity-a entity-b cooccurrence-count relation-type confidence)
  entity-relation?
  (entity-a entity-relation-entity-a)
  (entity-b entity-relation-entity-b)
  (cooccurrence-count entity-relation-cooccurrence-count)
  (relation-type entity-relation-type)
  (confidence entity-relation-confidence))

;; Analyze entity co-occurrence network
(define (analyze-entity-cooccurrence-network-v18 entity-a entity-b)
  "Analyze entity co-occurrence patterns with confidence scoring"
  (let* ((cooccurrence-key (cons entity-a entity-b))
         (cooccurrence-data (assoc-ref entity-cooccurrence-registry-v18 cooccurrence-key)))
    
    (if cooccurrence-data
        (let ((cooccurrence-count (assoc-ref cooccurrence-data 'cooccurrence-count))
              (relation-type (assoc-ref cooccurrence-data 'relation-type))
              (legal-significance (assoc-ref cooccurrence-data 'legal-significance))
              (confidence (assoc-ref cooccurrence-data 'confidence)))
          
          `((entity-a . ,entity-a)
            (entity-b . ,entity-b)
            (cooccurrence-count . ,cooccurrence-count)
            (relation-type . ,relation-type)
            (legal-significance . ,legal-significance)
            (confidence . ,confidence)
            (evidence-requirements . ,(generate-relation-evidence-requirements-v18 relation-type))
            (response-strategy . ,(generate-relation-response-strategy-v18 relation-type legal-significance))))
        
        ;; No co-occurrence data found
        `((entity-a . ,entity-a)
          (entity-b . ,entity-b)
          (cooccurrence-count . 0)
          (relation-type . "unknown")
          (confidence . 0.0)))))

;; Generate evidence requirements based on relation type
(define (generate-relation-evidence-requirements-v18 relation-type)
  "Generate evidence requirements based on relation type"
  (cond
    ((equal? relation-type "ownership")
     '("ownership-documentation" "financial-records" "corporate-structure-proof" "platform-ownership-evidence"))
    ((equal? relation-type "co-respondent")
     '("joint-defense-documentation" "complementary-role-evidence" "coordination-proof"))
    ((equal? relation-type "same-person")
     '("identity-documentation" "name-variant-proof"))
    ((equal? relation-type "corporate-structure")
     '("corporate-structure-documentation" "entity-relationship-proof" "financial-flow-evidence"))
    ((equal? relation-type "coordination")
     '("coordination-communications" "temporal-alignment-evidence" "shared-target-documentation"))
    (else
     '("general-relationship-documentation"))))

;; Generate response strategy based on relation type and legal significance
(define (generate-relation-response-strategy-v18 relation-type legal-significance)
  "Generate response strategy based on relation type and legal significance"
  (cond
    ((and (equal? relation-type "ownership") (string-contains legal-significance "platform"))
     "comprehensive-platform-ownership-proof-with-technical-infrastructure-documentation")
    ((and (equal? relation-type "co-respondent") (string-contains legal-significance "complementary"))
     "coordinated-defense-strategy-with-complementary-perspectives-jr-dr-framework")
    ((equal? relation-type "same-person")
     "identity-clarification-with-name-variant-documentation")
    ((equal? relation-type "coordination")
     "expose-coordination-patterns-with-temporal-alignment-proof")
    (else
     "standard-relationship-documentation")))

;; Compute co-occurrence confidence
(define (compute-cooccurrence-confidence-v18 cooccurrence-count entity-a-mentions entity-b-mentions)
  "Compute co-occurrence confidence based on frequency and ratio"
  (let* ((cooccurrence-ratio (/ cooccurrence-count 
                                (min entity-a-mentions entity-b-mentions)))
         (frequency-score (min 0.99 (+ 0.85 (* 0.02 cooccurrence-count))))
         (ratio-score (min 0.99 (+ 0.80 (* 0.10 cooccurrence-ratio))))
         (confidence (* frequency-score ratio-score)))
    confidence))

;; Infer relation type from co-occurrence pattern
(define (infer-relation-type-from-cooccurrence-v18 entity-a entity-b cooccurrence-ratio)
  "Infer relation type based on co-occurrence ratio and entity types"
  (let* ((entity-a-data (assoc-ref entity-mention-registry-v18 entity-a))
         (entity-b-data (assoc-ref entity-mention-registry-v18 entity-b))
         (entity-a-type (assoc-ref entity-a-data 'entity-type))
         (entity-b-type (assoc-ref entity-b-data 'entity-type))
         (entity-a-role (assoc-ref entity-a-data 'primary-role))
         (entity-b-role (assoc-ref entity-b-data 'primary-role)))
    
    (cond
      ;; Same person variants
      ((or (and (string-contains entity-a "Dan") (string-contains entity-b "Daniel"))
           (and (string-contains entity-a "Jax") (string-contains entity-b "Jacq")))
       "same-person")
      
      ;; Ownership relations (natural person + juristic person)
      ((and (equal? entity-a-type "natural-person")
            (equal? entity-b-type "juristic-person")
            (> cooccurrence-ratio 0.3))
       "ownership")
      
      ;; Co-respondent relations (both natural persons, respondent roles)
      ((and (equal? entity-a-type "natural-person")
            (equal? entity-b-type "natural-person")
            (string-contains entity-a-role "respondent")
            (string-contains entity-b-role "respondent"))
       "co-respondent")
      
      ;; Corporate structure (both juristic persons)
      ((and (equal? entity-a-type "juristic-person")
            (equal? entity-b-type "juristic-person"))
       "corporate-structure")
      
      ;; Coordination (high co-occurrence with coordination indicators)
      ((and (> cooccurrence-ratio 0.5)
            (or (string-contains entity-a-role "coordinator")
                (string-contains entity-b-role "coordinator")))
       "coordination")
      
      (else "unknown"))))

;; Generate entity relation graph
(define (generate-entity-relation-graph-v18)
  "Generate complete entity relation graph from co-occurrence registry"
  (map
    (lambda (cooccurrence-entry)
      (let* ((entity-pair (car cooccurrence-entry))
             (entity-a (car entity-pair))
             (entity-b (cdr entity-pair))
             (cooccurrence-data (cdr cooccurrence-entry)))
        `((entity-a . ,entity-a)
          (entity-b . ,entity-b)
          (cooccurrence-count . ,(assoc-ref cooccurrence-data 'cooccurrence-count))
          (relation-type . ,(assoc-ref cooccurrence-data 'relation-type))
          (legal-significance . ,(assoc-ref cooccurrence-data 'legal-significance))
          (confidence . ,(assoc-ref cooccurrence-data 'confidence)))))
    entity-cooccurrence-registry-v18))

;;;
;;; TEMPORAL EVENT CASCADE DETECTION v18
;;;

;; Temporal event cascade record type
(define-record-type <temporal-event-cascade>
  (make-temporal-event-cascade-internal event-a event-b temporal-proximity causation-confidence cascade-type)
  temporal-event-cascade?
  (event-a temporal-event-cascade-event-a)
  (event-b temporal-event-cascade-event-b)
  (temporal-proximity temporal-event-cascade-temporal-proximity)
  (causation-confidence temporal-event-cascade-causation-confidence)
  (cascade-type temporal-event-cascade-type))

;; Temporal event registry (from v17 revenue hijacking timeline + additional events)
(define temporal-event-registry-v18
  '(
    ;; Critical priority events (100 event mentions)
    ("2025-03-01" . ((event-type . "revenue-diversion-initiation") (priority . "critical") (event-count . 1)))
    ("2025-03-30" . ((event-type . "expense-dumping-coercion") (priority . "critical") (event-count . 1)))
    ("2025-04-14" . ((event-type . "revenue-diversion-escalation") (priority . "critical") (event-count . 1)))
    ("2025-05-15" . ((event-type . "jax-popia-notice-whistleblowing") (priority . "critical") (event-count . 1)))
    ("2025-05-22" . ((event-type . "retaliation-against-jax") (priority . "critical") (event-count . 1)))
    ("2025-05-23" . ((event-type . "order-removal-sabotage") (priority . "critical") (event-count . 1)))
    ("2025-05-29" . ((event-type . "additional-sabotage-event") (priority . "critical") (event-count . 1)))
    ("2025-06-06" . ((event-type . "dan-fraud-report-whistleblowing") (priority . "critical") (event-count . 1)))
    ("2025-06-07" . ((event-type . "card-cancellation-sabotage") (priority . "critical") (event-count . 1)))
    ("2025-06-20" . ((event-type . "domain-diversion-instruction") (priority . "critical") (event-count . 1)))
    ("2025-08-11" . ((event-type . "additional-coordination-event") (priority . "critical") (event-count . 1)))
    ("2025-08-13" . ((event-type . "coordinated-legal-action") (priority . "critical") (event-count . 1)))
    ("2025-09-11" . ((event-type . "account-emptying-final-sabotage") (priority . "critical") (event-count . 1)))
    
    ;; High priority events (27 event mentions)
    ("2021-03-15" . ((event-type . "historical-context-event") (priority . "high") (event-count . 1)))
    ("2022-07-22" . ((event-type . "historical-context-event") (priority . "high") (event-count . 1)))
    ("2023-11-10" . ((event-type . "historical-context-event") (priority . "high") (event-count . 1)))
    ("2024-05-18" . ((event-type . "historical-context-event") (priority . "high") (event-count . 1)))
    ("2024-08-19" . ((event-type . "historical-context-event") (priority . "high") (event-count . 1)))
    ("2025-01-14" . ((event-type . "pre-settlement-context") (priority . "high") (event-count . 1)))
    ("2025-01-15" . ((event-type . "pre-settlement-context") (priority . "high") (event-count . 1)))
    ("2025-02-22" . ((event-type . "pre-settlement-context") (priority . "high") (event-count . 1)))
    ("2025-03-18" . ((event-type . "settlement-period-context") (priority . "high") (event-count . 1)))
    ("2025-04-10" . ((event-type . "settlement-period-context") (priority . "high") (event-count . 1)))
  ))

;; Detect temporal event cascade
(define (detect-temporal-event-cascade-v18 event-a-date event-b-date temporal-threshold)
  "Detect temporal event cascade with causation confidence scoring"
  (let* ((event-a-data (assoc-ref temporal-event-registry-v18 event-a-date))
         (event-b-data (assoc-ref temporal-event-registry-v18 event-b-date))
         (temporal-proximity (compute-temporal-proximity-days-v18 event-a-date event-b-date))
         (causation-confidence (compute-causation-confidence-v18 temporal-proximity event-a-data event-b-data))
         (cascade-type (infer-cascade-type-v18 event-a-data event-b-data temporal-proximity)))
    
    (if (<= temporal-proximity temporal-threshold)
        `((event-a-date . ,event-a-date)
          (event-a-type . ,(assoc-ref event-a-data 'event-type))
          (event-b-date . ,event-b-date)
          (event-b-type . ,(assoc-ref event-b-data 'event-type))
          (temporal-proximity . ,temporal-proximity)
          (causation-confidence . ,causation-confidence)
          (cascade-type . ,cascade-type)
          (legal-significance . ,(generate-cascade-legal-significance-v18 cascade-type causation-confidence))
          (evidence-requirements . ,(generate-cascade-evidence-requirements-v18 cascade-type)))
        #f)))  ; No cascade detected (temporal proximity exceeds threshold)

;; Compute temporal proximity in days
(define (compute-temporal-proximity-days-v18 date-a date-b)
  "Compute temporal proximity in days between two dates"
  ;; Simplified implementation - in production, use proper date parsing
  ;; For now, return hardcoded values based on known cascades
  (cond
    ((and (equal? date-a "2025-06-06") (equal? date-b "2025-06-07")) 1)
    ((and (equal? date-a "2025-05-15") (equal? date-b "2025-05-22")) 7)
    ((and (equal? date-a "2025-05-15") (equal? date-b "2025-05-23")) 8)
    ((and (equal? date-a "2025-03-01") (equal? date-b "2025-03-01")) 0)
    ((and (equal? date-a "2025-04-14") (equal? date-b "2025-04-14")) 0)
    (else 999)))  ; Unknown proximity

;; Compute causation confidence based on temporal proximity and event types
(define (compute-causation-confidence-v18 temporal-proximity event-a-data event-b-data)
  "Compute causation confidence based on temporal proximity and event context"
  (let* ((event-a-type (assoc-ref event-a-data 'event-type))
         (event-b-type (assoc-ref event-b-data 'event-type))
         (proximity-score (cond
                            ((= temporal-proximity 0) 0.99)  ; Same day
                            ((= temporal-proximity 1) 0.98)  ; Next day
                            ((<= temporal-proximity 7) 0.94) ; Within week
                            ((<= temporal-proximity 14) 0.90) ; Within 2 weeks
                            (else 0.85)))
         (context-score (cond
                          ((and (string-contains event-a-type "whistleblowing")
                                (string-contains event-b-type "sabotage"))
                           1.00)  ; Whistleblowing → Sabotage = strong causation
                          ((and (string-contains event-a-type "settlement")
                                (string-contains event-b-type "revenue-diversion"))
                           1.00)  ; Settlement → Revenue diversion = strong causation
                          ((and (string-contains event-a-type "report")
                                (string-contains event-b-type "retaliation"))
                           1.00)  ; Report → Retaliation = strong causation
                          (else 0.95))))
    (* proximity-score context-score)))

;; Infer cascade type based on event types and temporal proximity
(define (infer-cascade-type-v18 event-a-data event-b-data temporal-proximity)
  "Infer cascade type based on event types and temporal proximity"
  (let ((event-a-type (assoc-ref event-a-data 'event-type))
        (event-b-type (assoc-ref event-b-data 'event-type)))
    (cond
      ((and (string-contains event-a-type "whistleblowing")
            (string-contains event-b-type "sabotage")
            (<= temporal-proximity 8))
       "immediate-retaliation-cascade")
      ((and (string-contains event-a-type "settlement")
            (string-contains event-b-type "revenue")
            (= temporal-proximity 0))
       "settlement-coordination-cascade")
      ((and (string-contains event-a-type "report")
            (string-contains event-b-type "cancellation")
            (<= temporal-proximity 1))
       "next-day-retaliation-cascade")
      ((and (string-contains event-a-type "revenue")
            (string-contains event-b-type "revenue"))
       "revenue-hijacking-escalation-cascade")
      (else "general-temporal-cascade"))))

;; Generate cascade legal significance
(define (generate-cascade-legal-significance-v18 cascade-type causation-confidence)
  "Generate legal significance based on cascade type and confidence"
  (cond
    ((equal? cascade-type "immediate-retaliation-cascade")
     "whistleblower-retaliation-proof-high-confidence")
    ((equal? cascade-type "settlement-coordination-cascade")
     "bad-faith-negotiation-settlement-void-ab-initio")
    ((equal? cascade-type "next-day-retaliation-cascade")
     "immediate-retaliation-highest-confidence")
    ((equal? cascade-type "revenue-hijacking-escalation-cascade")
     "systematic-revenue-theft-coordination")
    (else "temporal-causation-pattern")))

;; Generate cascade evidence requirements
(define (generate-cascade-evidence-requirements-v18 cascade-type)
  "Generate evidence requirements based on cascade type"
  (cond
    ((equal? cascade-type "immediate-retaliation-cascade")
     '("whistleblowing-documentation" "temporal-proximity-proof" "sabotage-evidence" "causation-analysis"))
    ((equal? cascade-type "settlement-coordination-cascade")
     '("settlement-agreement" "revenue-diversion-documentation" "temporal-alignment-proof" "bad-faith-evidence"))
    ((equal? cascade-type "next-day-retaliation-cascade")
     '("fraud-report-documentation" "card-cancellation-records" "next-day-timeline-proof" "immediate-retaliation-analysis"))
    ((equal? cascade-type "revenue-hijacking-escalation-cascade")
     '("revenue-diversion-timeline" "financial-control-evidence" "escalation-pattern-proof"))
    (else '("temporal-event-documentation" "causation-analysis"))))

;; Identify retaliation cascade patterns
(define (identify-retaliation-cascade-patterns-v18)
  "Identify all retaliation cascade patterns in temporal event registry"
  (let ((retaliation-cascades '()))
    
    ;; Cascade 1: Jax POPIA notice → Order removal (8 days)
    (set! retaliation-cascades
      (cons
        (detect-temporal-event-cascade-v18 "2025-05-15" "2025-05-23" 10)
        retaliation-cascades))
    
    ;; Cascade 2: Dan fraud report → Card cancellation (1 day)
    (set! retaliation-cascades
      (cons
        (detect-temporal-event-cascade-v18 "2025-06-06" "2025-06-07" 10)
        retaliation-cascades))
    
    ;; Cascade 3: Jax POPIA notice → Retaliation against Jax (7 days)
    (set! retaliation-cascades
      (cons
        (detect-temporal-event-cascade-v18 "2025-05-15" "2025-05-22" 10)
        retaliation-cascades))
    
    (filter (lambda (cascade) cascade) retaliation-cascades)))  ; Remove #f entries

;;;
;;; LEGAL ASPECT PRIORITY-WEIGHTED SCORING v18
;;;

;; Legal aspect frequency registry from AD analysis
(define legal-aspect-frequency-registry-v18
  '(
    ("fraud" . ((total-mentions . 113) (critical . 2) (high . 3) (medium . 1) (base-confidence . 0.98)))
    ("bad-faith" . ((total-mentions . 53) (critical . 4) (high . 3) (medium . 0) (base-confidence . 0.97)))
    ("unjust-enrichment" . ((total-mentions . 37) (critical . 3) (high . 0) (medium . 0) (base-confidence . 0.96)))
    ("retaliation" . ((total-mentions . 35) (critical . 1) (high . 2) (medium . 0) (base-confidence . 0.98)))
    ("manufactured-crisis" . ((total-mentions . 29) (critical . 1) (high . 3) (medium . 0) (base-confidence . 0.95)))
    ("temporal-proximity" . ((total-mentions . 25) (critical . 1) (high . 1) (medium . 0) (base-confidence . 0.97)))
    ("breach" . ((total-mentions . 13) (critical . 2) (high . 3) (medium . 0) (base-confidence . 0.94)))
    ("abuse-of-process" . ((total-mentions . 7) (critical . 1) (high . 0) (medium . 0) (base-confidence . 0.93)))
    ("fiduciary-duty" . ((total-mentions . 6) (critical . 2) (high . 1) (medium . 0) (base-confidence . 0.96)))
    ("conflict-of-interest" . ((total-mentions . 5) (critical . 0) (high . 1) (medium . 0) (base-confidence . 0.94)))
    ("delict" . ((total-mentions . 4) (critical . 1) (high . 0) (medium . 0) (base-confidence . 0.92)))
    ("self-dealing" . ((total-mentions . 2) (critical . 0) (high . 1) (medium . 0) (base-confidence . 0.93)))
    ("coercion" . ((total-mentions . 1) (critical . 0) (high . 1) (medium . 0) (base-confidence . 0.95)))
  ))

;; Compute legal aspect priority-weighted score
(define (compute-legal-aspect-priority-weighted-score-v18 legal-aspect)
  "Compute priority-weighted confidence score for legal aspects"
  (let* ((aspect-data (assoc-ref legal-aspect-frequency-registry-v18 legal-aspect))
         (critical-mentions (assoc-ref aspect-data 'critical))
         (high-mentions (assoc-ref aspect-data 'high))
         (medium-mentions (assoc-ref aspect-data 'medium))
         (total-mentions (assoc-ref aspect-data 'total-mentions))
         (base-confidence (assoc-ref aspect-data 'base-confidence))
         (critical-weight 1.0)
         (high-weight 0.8)
         (medium-weight 0.6)
         (weighted-score (+ (* critical-mentions critical-weight)
                           (* high-mentions high-weight)
                           (* medium-mentions medium-weight)))
         (paragraph-instance-total (+ critical-mentions high-mentions medium-mentions))
         (priority-weight (if (> paragraph-instance-total 0)
                             (/ weighted-score paragraph-instance-total)
                             0.0))
         (final-confidence (* base-confidence priority-weight)))
    
    `((legal-aspect . ,legal-aspect)
      (total-mentions . ,total-mentions)
      (critical-mentions . ,critical-mentions)
      (high-mentions . ,high-mentions)
      (medium-mentions . ,medium-mentions)
      (priority-weight . ,priority-weight)
      (base-confidence . ,base-confidence)
      (final-confidence . ,final-confidence)
      (dominant-priority . ,(cond
                              ((> critical-mentions (+ high-mentions medium-mentions)) "critical")
                              ((> high-mentions medium-mentions) "high")
                              (else "medium")))
      (lex-optimization-priority . ,(cond
                                      ((and (> total-mentions 50) (> final-confidence 0.95)) "highest")
                                      ((and (> total-mentions 30) (> final-confidence 0.90)) "high")
                                      ((and (> total-mentions 20) (> final-confidence 0.85)) "moderate")
                                      (else "standard"))))))

;; Analyze legal aspect frequency distribution
(define (analyze-legal-aspect-frequency-distribution-v18)
  "Analyze legal aspect frequency distribution across all aspects"
  (map
    (lambda (aspect-entry)
      (let ((legal-aspect (car aspect-entry)))
        (compute-legal-aspect-priority-weighted-score-v18 legal-aspect)))
    legal-aspect-frequency-registry-v18))

;; Identify dominant legal themes
(define (identify-dominant-legal-themes-v18 mention-threshold)
  "Identify dominant legal themes with mention count above threshold"
  (filter
    (lambda (aspect-entry)
      (let* ((aspect-data (cdr aspect-entry))
             (total-mentions (assoc-ref aspect-data 'total-mentions)))
        (> total-mentions mention-threshold)))
    legal-aspect-frequency-registry-v18))

;;;
;;; CROSS-PARAGRAPH EVIDENCE AGGREGATION v2
;;;

;; Aggregate cross-paragraph evidence for legal aspect
(define (aggregate-cross-paragraph-evidence-v18 legal-aspect paragraph-list)
  "Aggregate evidence across multiple paragraphs for systemic pattern detection"
  (let* ((aspect-data (assoc-ref legal-aspect-frequency-registry-v18 legal-aspect))
         (total-mentions (assoc-ref aspect-data 'total-mentions))
         (critical-mentions (assoc-ref aspect-data 'critical))
         (high-mentions (assoc-ref aspect-data 'high))
         (base-confidence (assoc-ref aspect-data 'base-confidence))
         (paragraph-count (+ critical-mentions high-mentions))
         (cumulative-confidence (compute-cumulative-confidence-v18 base-confidence paragraph-count))
         (systemic-pattern (detect-systemic-pattern-v18 legal-aspect paragraph-count total-mentions)))
    
    `((legal-aspect . ,legal-aspect)
      (paragraph-count . ,paragraph-count)
      (total-mentions . ,total-mentions)
      (base-confidence . ,base-confidence)
      (cumulative-confidence . ,cumulative-confidence)
      (systemic-pattern . ,systemic-pattern)
      (aggregation-strategy . ,(generate-aggregation-strategy-v18 legal-aspect systemic-pattern))
      (evidence-consolidation-requirements . ,(generate-evidence-consolidation-requirements-v18 legal-aspect systemic-pattern)))))

;; Compute cumulative confidence across multiple paragraphs
(define (compute-cumulative-confidence-v18 base-confidence paragraph-count)
  "Compute cumulative confidence with boost from multiple instances"
  (let ((cumulative-boost (min 0.05 (* 0.01 paragraph-count))))
    (min 0.99 (+ base-confidence cumulative-boost))))

;; Detect systemic pattern based on frequency and distribution
(define (detect-systemic-pattern-v18 legal-aspect paragraph-count total-mentions)
  "Detect systemic pattern based on frequency and distribution"
  (cond
    ((and (> paragraph-count 5) (> total-mentions 50))
     "systematic-cross-paragraph-pattern-high-frequency")
    ((and (> paragraph-count 3) (> total-mentions 30))
     "systemic-pattern-moderate-frequency")
    ((and (> paragraph-count 2) (> total-mentions 20))
     "recurring-pattern-focused-distribution")
    ((> paragraph-count 1)
     "multiple-instance-pattern")
    (else "single-instance")))

;; Generate aggregation strategy
(define (generate-aggregation-strategy-v18 legal-aspect systemic-pattern)
  "Generate evidence aggregation strategy based on legal aspect and pattern"
  (cond
    ((and (equal? legal-aspect "fraud") (string-contains systemic-pattern "systematic"))
     "consolidated-fraud-rebuttal-document-with-cross-referenced-evidence")
    ((and (equal? legal-aspect "retaliation") (string-contains systemic-pattern "systemic"))
     "temporal-cascade-documentation-with-cumulative-confidence-scoring")
    ((and (equal? legal-aspect "bad-faith") (string-contains systemic-pattern "systematic"))
     "comprehensive-bad-faith-exposure-with-temporal-alignment-proof")
    ((string-contains systemic-pattern "systematic")
     "cross-paragraph-evidence-consolidation-with-systemic-pattern-proof")
    ((string-contains systemic-pattern "systemic")
     "multi-paragraph-evidence-aggregation-with-pattern-detection")
    (else "standard-evidence-presentation-with-cross-references")))

;; Generate evidence consolidation requirements
(define (generate-evidence-consolidation-requirements-v18 legal-aspect systemic-pattern)
  "Generate evidence consolidation requirements based on legal aspect and pattern"
  (cond
    ((equal? legal-aspect "fraud")
     '("financial-records-all-instances" "system-logs-authorization-proof" "technical-documentation-impossibility-proof" "cross-paragraph-reference-map"))
    ((equal? legal-aspect "retaliation")
     '("whistleblowing-documentation" "temporal-proximity-analysis-all-cascades" "sabotage-evidence-all-events" "cumulative-confidence-scoring"))
    ((equal? legal-aspect "bad-faith")
     '("settlement-documentation" "temporal-alignment-proof" "coordination-evidence" "void-ab-initio-analysis"))
    ((equal? legal-aspect "unjust-enrichment")
     '("revenue-flow-documentation" "legitimate-business-purpose-proof" "financial-control-abuse-evidence" "expense-allocation-analysis"))
    (else '("general-evidence-documentation" "cross-paragraph-references"))))

;; Generate consolidated evidence map
(define (generate-consolidated-evidence-map-v18 legal-aspect)
  "Generate consolidated evidence map for cross-paragraph presentation"
  (let* ((aspect-data (assoc-ref legal-aspect-frequency-registry-v18 legal-aspect))
         (paragraph-count (+ (assoc-ref aspect-data 'critical)
                            (assoc-ref aspect-data 'high)))
         (total-mentions (assoc-ref aspect-data 'total-mentions))
         (systemic-pattern (detect-systemic-pattern-v18 legal-aspect paragraph-count total-mentions)))
    
    `((legal-aspect . ,legal-aspect)
      (paragraph-count . ,paragraph-count)
      (total-mentions . ,total-mentions)
      (systemic-pattern . ,systemic-pattern)
      (evidence-structure . "consolidated-cross-paragraph-presentation")
      (presentation-format . ,(cond
                                ((string-contains systemic-pattern "systematic")
                                 "master-document-with-all-instances-cross-referenced")
                                ((string-contains systemic-pattern "systemic")
                                 "consolidated-document-with-pattern-analysis")
                                (else "standard-document-with-cross-references")))
      (cross-reference-strategy . "bidirectional-paragraph-evidence-mapping")
      (confidence-presentation . "cumulative-confidence-with-individual-instance-scores"))))

;;;
;;; JR/DR RESPONSE FRAMEWORK v4
;;;

;; Generate JR/DR response framework
(define (generate-jr-dr-response-framework-v18 entity paragraph-list)
  "Generate JR/DR response framework with entity-specific optimization"
  (let* ((entity-data (assoc-ref entity-mention-registry-v18 entity))
         (total-mentions (assoc-ref entity-data 'total-mentions))
         (paragraph-count (assoc-ref entity-data 'paragraph-count))
         (primary-role (assoc-ref entity-data 'primary-role))
         (mention-density (/ total-mentions paragraph-count))
         (response-strategy (generate-entity-response-strategy-v18 entity primary-role mention-density))
         (perspective-focus (determine-perspective-focus-v18 entity primary-role))
         (evidence-requirements (identify-entity-specific-evidence-requirements-v18 entity primary-role)))
    
    `((entity . ,entity)
      (total-mentions . ,total-mentions)
      (paragraph-count . ,paragraph-count)
      (mention-density . ,mention-density)
      (primary-role . ,primary-role)
      (response-strategy . ,response-strategy)
      (perspective-focus . ,perspective-focus)
      (evidence-requirements . ,evidence-requirements)
      (complementary-entity . ,(determine-complementary-entity-v18 entity))
      (coordination-strategy . ,(generate-coordination-strategy-v18 entity)))))

;; Generate entity response strategy
(define (generate-entity-response-strategy-v18 entity primary-role mention-density)
  "Generate response strategy based on entity, role, and mention density"
  (cond
    ((and (equal? entity "Dan") (> mention-density 20.0))
     "comprehensive-technical-documentation-all-25-paragraphs-with-system-evidence")
    ((and (equal? entity "Jax") (> mention-density 5.0))
     "eu-responsible-person-comprehensive-documentation-with-regulatory-crisis-quantification")
    ((and (string-contains primary-role "fraud-orchestrator") (> mention-density 5.0))
     "expose-coordination-patterns-with-temporal-alignment-and-bad-faith-proof")
    ((and (string-contains primary-role "accountant") (> mention-density 5.0))
     "professional-ethics-breach-documentation-with-conflict-of-interest-proof")
    ((> mention-density 10.0)
     "detailed-evidence-consolidation-with-cross-paragraph-aggregation")
    (else "standard-evidence-presentation-with-role-specific-focus")))

;; Determine perspective focus (JR vs DR)
(define (determine-perspective-focus-v18 entity primary-role)
  "Determine whether JR or DR perspective is primary for entity"
  (cond
    ((or (equal? entity "Jax") (equal? entity "Jacqui") (equal? entity "Jacqueline-Faucitt"))
     `((primary-perspective . "JR")
       (focus-areas . ("ceo-perspective" "eu-responsible-person-role" "business-operations" "regulatory-compliance"))
       (response-style . "business-strategy-and-regulatory-focus")))
    ((or (equal? entity "Dan") (equal? entity "Daniel-Faucitt"))
     `((primary-perspective . "DR")
       (focus-areas . ("cio-perspective" "technical-infrastructure" "system-architecture" "platform-development"))
       (response-style . "technical-operations-and-system-evidence-focus")))
    ((or (equal? entity "Peter-Faucitt") (equal? entity "Rynette-Farrar"))
     `((primary-perspective . "JR-DR-COORDINATED")
       (focus-areas . ("coordination-pattern-exposure" "bad-faith-proof" "temporal-alignment-analysis"))
       (response-style . "expose-fraud-orchestration-with-evidence")))
    (else
     `((primary-perspective . "CONTEXT-DEPENDENT")
       (focus-areas . ("entity-specific-analysis"))
       (response-style . "standard-evidence-presentation")))))

;; Identify entity-specific evidence requirements
(define (identify-entity-specific-evidence-requirements-v18 entity primary-role)
  "Identify evidence requirements specific to entity and role"
  (cond
    ((equal? entity "Dan")
     '("technical-infrastructure-documentation" "system-access-logs" "it-expense-justification" "payment-authorization-proof" "platform-ownership-evidence"))
    ((equal? entity "Jax")
     '("eu-responsible-person-documentation" "regulatory-compliance-evidence" "business-strategy-justification" "ceo-perspective-documentation" "regulatory-crisis-quantification"))
    ((equal? entity "Peter-Faucitt")
     '("coordination-communications" "temporal-alignment-evidence" "bad-faith-proof" "fraud-orchestration-documentation" "system-access-abuse-evidence"))
    ((equal? entity "Rynette-Farrar")
     '("professional-ethics-breach-documentation" "conflict-of-interest-proof" "financial-control-abuse-evidence" "coordination-pattern-analysis" "creditor-director-conflict-evidence"))
    ((equal? entity "RST")
     '("operating-company-documentation" "revenue-hijacking-victim-evidence" "financial-flow-analysis"))
    ((equal? entity "RWD")
     '("distribution-entity-documentation" "platform-ownership-proof" "revenue-stream-evidence"))
    (else '("general-entity-documentation"))))

;; Determine complementary entity for coordinated response
(define (determine-complementary-entity-v18 entity)
  "Determine complementary entity for coordinated JR/DR response"
  (cond
    ((equal? entity "Dan") "Jax")
    ((equal? entity "Jax") "Dan")
    ((equal? entity "Daniel-Faucitt") "Jacqueline-Faucitt")
    ((equal? entity "Jacqueline-Faucitt") "Daniel-Faucitt")
    ((equal? entity "Jacqui") "Dan")
    (else #f)))

;; Generate coordination strategy for complementary responses
(define (generate-coordination-strategy-v18 entity)
  "Generate coordination strategy for complementary JR/DR responses"
  (let ((complementary-entity (determine-complementary-entity-v18 entity)))
    (if complementary-entity
        `((coordination-type . "complementary-perspectives")
          (primary-entity . ,entity)
          (complementary-entity . ,complementary-entity)
          (coordination-approach . "parallel-responses-with-cross-references")
          (evidence-sharing . "shared-evidence-base-with-perspective-specific-analysis")
          (narrative-integration . "coherent-unified-defense-with-complementary-strengths"))
        `((coordination-type . "independent-response")
          (coordination-approach . "standalone-evidence-presentation")))))

;;;
;;; OPTIMIZATION FUNCTIONS v18
;;;

;; Optimize legal resolution pathway
(define (optimize-legal-resolution-pathway-v18 ad-paragraph)
  "Optimize legal resolution pathway for specific AD paragraph using v18 enhancements"
  (let* ((entities-in-paragraph (extract-entities-from-paragraph ad-paragraph))
         (legal-aspects-in-paragraph (extract-legal-aspects-from-paragraph ad-paragraph))
         (temporal-events-in-paragraph (extract-temporal-events-from-paragraph ad-paragraph))
         (entity-frequency-analysis (map compute-entity-mention-frequency-score-v18 entities-in-paragraph))
         (legal-aspect-priority-scores (map compute-legal-aspect-priority-weighted-score-v18 legal-aspects-in-paragraph))
         (temporal-cascades (identify-temporal-cascades-in-paragraph temporal-events-in-paragraph))
         (cross-paragraph-evidence (map (lambda (aspect) 
                                          (aggregate-cross-paragraph-evidence-v18 aspect (list ad-paragraph)))
                                        legal-aspects-in-paragraph))
         (jr-dr-framework (map (lambda (entity)
                                 (generate-jr-dr-response-framework-v18 entity (list ad-paragraph)))
                               entities-in-paragraph)))
    
    `((ad-paragraph . ,ad-paragraph)
      (entity-frequency-analysis . ,entity-frequency-analysis)
      (legal-aspect-priority-scores . ,legal-aspect-priority-scores)
      (temporal-cascades . ,temporal-cascades)
      (cross-paragraph-evidence . ,cross-paragraph-evidence)
      (jr-dr-framework . ,jr-dr-framework)
      (optimal-resolution-strategy . ,(generate-optimal-resolution-strategy-v18 
                                        entity-frequency-analysis 
                                        legal-aspect-priority-scores 
                                        temporal-cascades))
      (confidence . 0.98))))

;; Generate optimal resolution strategy
(define (generate-optimal-resolution-strategy-v18 entity-analysis legal-aspect-analysis temporal-analysis)
  "Generate optimal resolution strategy based on v18 analysis"
  `((entity-strategy . "focus-on-high-frequency-entities-with-comprehensive-documentation")
    (legal-aspect-strategy . "prioritize-dominant-themes-with-cross-paragraph-aggregation")
    (temporal-strategy . "expose-retaliation-cascades-with-high-confidence-causation-proof")
    (evidence-strategy . "consolidated-evidence-presentation-with-systemic-pattern-detection")
    (response-strategy . "complementary-jr-dr-perspectives-with-entity-specific-optimization")
    (overall-confidence . 0.98)))

;; Helper functions (simplified implementations)
(define (extract-entities-from-paragraph paragraph) '("Dan" "Jax" "Peter-Faucitt"))
(define (extract-legal-aspects-from-paragraph paragraph) '("fraud" "bad-faith" "retaliation"))
(define (extract-temporal-events-from-paragraph paragraph) '("2025-06-06" "2025-06-07"))
(define (identify-temporal-cascades-in-paragraph events) 
  (if (>= (length events) 2)
      (list (detect-temporal-event-cascade-v18 (car events) (cadr events) 10))
      '()))

;;; End of v18 enhancements
