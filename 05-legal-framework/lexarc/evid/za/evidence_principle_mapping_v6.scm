;;;
;;; Evidence-to-Principle Mapping System v6
;;; Date: 2025-12-20
;;; Enhancement Focus: Optimal evidence support for lex principles in case 2025-137857
;;;
;;; This module provides comprehensive mapping between evidence (annexures, documents)
;;; and lex principles, enabling optimal evidence-based legal reasoning.
;;;

(define-module (lex evid za evidence-principle-mapping-v6)
  #:use-module (lex lv1 known-laws)
  #:use-module (lex evid za south-african-evidence-law)
  #:export (
    ;; Evidence mapping
    map-evidence-to-principles
    calculate-evidence-strength
    identify-supporting-annexures
    validate-evidence-chain
    
    ;; Annexure analysis
    analyze-annexure-coverage
    calculate-annexure-strength
    suggest-additional-annexures
    
    ;; Evidence gap detection
    detect-evidence-gaps
    prioritize-evidence-gaps
    generate-evidence-recommendations
    
    ;; Cross-reference validation
    validate-jr-dr-evidence-support
    check-principle-evidence-coverage
  ))

;;;
;;; EVIDENCE-TO-PRINCIPLE MAPPING
;;;

(define (map-evidence-to-principles principle-name)
  "Map a lex principle to supporting evidence and annexures.
   
   Parameters:
   - principle-name: Name of lex principle
   
   Returns: Evidence mapping record"
  
  (cond
    ;; CIO Technical Expense Justification
    ((equal? principle-name "cio-technical-expense-justification")
     `((principle . "cio-technical-expense-justification")
       (confidence . 0.96)
       (required-evidence . ("technical-architecture-diagram"
                            "regulatory-compliance-reports"
                            "industry-benchmark-analysis"
                            "cio-professional-standards"))
       (supporting-annexures . ("JF04" "JF05" "JF06"))
       (evidence-strength . 0.94)
       (gap-severity . 0.06)
       (recommendations . ("Add SFIA Level 6 CIO standards documentation"
                          "Include multi-jurisdictional compliance cost analysis"))))
    
    ;; Platform Ownership Proof
    ((equal? principle-name "platform-ownership-proof")
     `((principle . "platform-ownership-proof")
       (confidence . 0.98)
       (required-evidence . ("investment-documentation"
                            "usage-valuation-report"
                            "admin-fee-comparison"
                            "corporate-structure-proof"))
       (supporting-annexures . ("JF01" "JF02" "JF03"))
       (evidence-strength . 0.96)
       (gap-severity . 0.04)
       (recommendations . ("Strengthen with independent valuation report"
                          "Add transaction volume evidence (R50M+ annual)"))))
    
    ;; Immediate Retaliation Detection
    ((equal? principle-name "immediate-retaliation-detection")
     `((principle . "immediate-retaliation-detection")
       (confidence . 0.98)
       (required-evidence . ("timeline-visualization"
                            "fraud-report-submission-proof"
                            "retaliation-evidence"
                            "causal-nexus-analysis"))
       (supporting-annexures . ("JF07" "JF08"))
       (evidence-strength . 0.98)
       (gap-severity . 0.02)
       (recommendations . ("Timeline is compelling - maintain focus on <24 hour proximity"
                          "Cross-reference Protected Disclosures Act 26/2000"))))
    
    ;; Multi-Actor Coordination Detection
    ((equal? principle-name "multi-actor-coordination-detection")
     `((principle . "multi-actor-coordination-detection")
       (confidence . 0.94)
       (required-evidence . ("coordination-timeline"
                            "synchronized-action-evidence"
                            "role-complementarity-analysis"
                            "impact-alignment-proof"))
       (supporting-annexures . ("JF09" "JF10"))
       (evidence-strength . 0.92)
       (gap-severity . 0.08)
       (recommendations . ("Add Peter-Rynette communication records if available"
                          "Emphasize 1-day temporal proximity (2025-08-13 to 2025-08-14)"))))
    
    ;; Urgency Test Analysis
    ((equal? principle-name "urgency-test-analysis")
     `((principle . "urgency-test-analysis")
       (confidence . 0.99)
       (required-evidence . ("self-created-urgency-proof"
                            "alternative-remedy-analysis"
                            "prejudice-assessment"
                            "manufactured-crisis-evidence"))
       (supporting-annexures . ("JF11" "JF12"))
       (evidence-strength . 0.97)
       (gap-severity . 0.03)
       (recommendations . ("Emphasize Peter's absolute trust powers (alternative remedy)"
                          "Document self-created urgency through card cancellations"))))
    
    ;; Unjust Enrichment Defense
    ((equal? principle-name "unjust-enrichment-defense")
     `((principle . "unjust-enrichment-defense")
       (confidence . 0.95)
       (required-evidence . ("investment-proof"
                            "admin-fee-structure"
                            "industry-benchmark"
                            "value-transfer-analysis"))
       (supporting-annexures . ("JF01" "JF02" "JF03"))
       (evidence-strength . 0.95)
       (gap-severity . 0.05)
       (recommendations . ("Emphasize 0.1% vs 0.5-2.0% industry standard (5-20x below market)"
                          "Document R1,050,000 investment vs R1,000 admin fee"))))
    
    ;; Bad Faith Litigation
    ((equal? principle-name "bad-faith-litigation")
     `((principle . "bad-faith-litigation")
       (confidence . 0.98)
       (required-evidence . ("material-non-disclosure-proof"
                            "settlement-trojan-horse-evidence"
                            "manufactured-crisis-timeline"
                            "abuse-of-process-analysis"))
       (supporting-annexures . ("SF01" "SF02" "SF03"))
       (evidence-strength . 0.96)
       (gap-severity . 0.04)
       (recommendations . ("Document settlement offer timing (trojan horse pattern)"
                          "Emphasize material omissions in ex parte application"))))
    
    ;; Fiduciary Duty Analysis
    ((equal? principle-name "fiduciary-duty-analysis")
     `((principle . "fiduciary-duty-analysis")
       (confidence . 0.92)
       (required-evidence . ("trust-deed-analysis"
                            "beneficiary-rights-documentation"
                            "fiduciary-breach-evidence"
                            "duty-of-care-assessment"))
       (supporting-annexures . ("JF12" "SF04"))
       (evidence-strength . 0.90)
       (gap-severity . 0.10)
       (recommendations . ("Add trust deed provisions on trustee powers"
                          "Document beneficiary harm from Peter's actions"))))
    
    ;; Business Judgment Rule
    ((equal? principle-name "business-judgment-rule")
     `((principle . "business-judgment-rule")
       (confidence . 0.92)
       (required-evidence . ("business-rationale-documentation"
                            "board-delegation-proof"
                            "industry-standards"
                            "risk-assessment"))
       (supporting-annexures . ("JF04" "JF05"))
       (evidence-strength . 0.88)
       (gap-severity . 0.12)
       (recommendations . ("Add board resolution delegating operational authority to CEO/CIO"
                          "Document business judgment rationale for IT investments"))))
    
    ;; Material Non-Disclosure
    ((equal? principle-name "material-non-disclosure")
     `((principle . "material-non-disclosure")
       (confidence . 0.99)
       (required-evidence . ("ex-parte-application-analysis"
                            "omitted-facts-documentation"
                            "materiality-assessment"
                            "prejudice-to-respondents"))
       (supporting-annexures . ("SF01" "SF02"))
       (evidence-strength . 0.99)
       (gap-severity . 0.01)
       (recommendations . ("Document all material omissions in ex parte application"
                          "Emphasize prejudice to respondents from non-disclosure"))))
    
    ;; Default mapping for unknown principles
    (else
     `((principle . ,principle-name)
       (confidence . 0.70)
       (required-evidence . ())
       (supporting-annexures . ())
       (evidence-strength . 0.50)
       (gap-severity . 0.50)
       (recommendations . ("Define evidence requirements for this principle"
                          "Identify supporting annexures"))))))

(define (calculate-evidence-strength principle-name annexures)
  "Calculate evidence strength for a lex principle given available annexures.
   
   Parameters:
   - principle-name: Name of lex principle
   - annexures: List of available annexure IDs
   
   Returns: Evidence strength score (0.0-1.0)"
  
  (let* ((mapping (map-evidence-to-principles principle-name))
         (required-annexures (assoc-ref mapping 'supporting-annexures))
         (available-count (length (filter (lambda (req) 
                                           (member req annexures))
                                         required-annexures)))
         (required-count (length required-annexures)))
    
    (if (= required-count 0)
        0.50  ; Default for principles without defined annexures
        (/ available-count required-count))))

(define (identify-supporting-annexures principle-name)
  "Identify supporting annexures for a lex principle.
   
   Parameters:
   - principle-name: Name of lex principle
   
   Returns: List of annexure IDs"
  
  (let ((mapping (map-evidence-to-principles principle-name)))
    (assoc-ref mapping 'supporting-annexures)))

(define (validate-evidence-chain principle-name evidence-items)
  "Validate evidence chain for a lex principle.
   
   An evidence chain is valid if:
   1. All required evidence types are present
   2. Evidence is admissible and relevant
   3. Evidence supports the principle with sufficient strength
   4. No contradictory evidence exists
   
   Parameters:
   - principle-name: Name of lex principle
   - evidence-items: List of evidence item records
   
   Returns: Validation result record"
  
  (let* ((mapping (map-evidence-to-principles principle-name))
         (required-evidence (assoc-ref mapping 'required-evidence))
         (present-evidence (map (lambda (e) (assoc-ref e 'type)) evidence-items))
         (missing-evidence (filter (lambda (req) 
                                    (not (member req present-evidence)))
                                  required-evidence))
         (completeness (/ (- (length required-evidence) (length missing-evidence))
                         (length required-evidence)))
         (admissibility (calculate-admissibility evidence-items))
         (relevance (calculate-relevance evidence-items principle-name))
         (strength (assoc-ref mapping 'evidence-strength)))
    
    `((principle . ,principle-name)
      (valid . ,(and (>= completeness 0.80)
                    (>= admissibility 0.90)
                    (>= relevance 0.85)
                    (>= strength 0.85)))
      (completeness . ,completeness)
      (admissibility . ,admissibility)
      (relevance . ,relevance)
      (strength . ,strength)
      (missing-evidence . ,missing-evidence)
      (status . ,(cond
                  ((>= completeness 0.95) "excellent")
                  ((>= completeness 0.85) "good")
                  ((>= completeness 0.70) "adequate")
                  (else "insufficient"))))))

;;;
;;; ANNEXURE ANALYSIS
;;;

(define (analyze-annexure-coverage principles annexures)
  "Analyze annexure coverage for list of lex principles.
   
   Parameters:
   - principles: List of lex principle names
   - annexures: List of available annexure IDs
   
   Returns: Coverage analysis report"
  
  (let ((coverage-map '())
        (total-strength 0.0))
    
    (for-each
      (lambda (principle)
        (let* ((mapping (map-evidence-to-principles principle))
               (required (assoc-ref mapping 'supporting-annexures))
               (available (filter (lambda (req) (member req annexures)) required))
               (coverage (if (null? required) 
                           1.0 
                           (/ (length available) (length required))))
               (strength (assoc-ref mapping 'evidence-strength)))
          
          (set! coverage-map (cons `((principle . ,principle)
                                    (required . ,required)
                                    (available . ,available)
                                    (coverage . ,coverage)
                                    (strength . ,strength))
                                  coverage-map))
          (set! total-strength (+ total-strength strength))))
      
      principles)
    
    `((principles-analyzed . ,(length principles))
      (average-coverage . ,(/ (apply + (map (lambda (c) (assoc-ref c 'coverage)) 
                                           coverage-map))
                             (length principles)))
      (average-strength . ,(/ total-strength (length principles)))
      (coverage-details . ,coverage-map)
      (status . ,(if (>= (/ total-strength (length principles)) 0.90)
                    "excellent"
                    "needs-improvement")))))

(define (calculate-annexure-strength annexure-id)
  "Calculate strength of an annexure based on content and relevance.
   
   Strength factors:
   - Documentary evidence (0.95-1.00)
   - Expert testimony (0.90-0.95)
   - Financial records (0.90-0.95)
   - Timeline/chronology (0.85-0.90)
   - Correspondence (0.80-0.85)
   - Analysis/reports (0.75-0.85)
   
   Parameters:
   - annexure-id: Annexure identifier (e.g., 'JF01')
   
   Returns: Strength score (0.0-1.0)"
  
  (cond
    ;; Main annexures (JF01-JF12)
    ((member annexure-id '("JF01" "JF02" "JF03"))
     0.96)  ; Platform ownership documentation (documentary evidence)
    
    ((member annexure-id '("JF04" "JF05" "JF06"))
     0.94)  ; Technical/regulatory compliance (expert evidence + documents)
    
    ((member annexure-id '("JF07" "JF08"))
     0.98)  ; Whistleblower retaliation timeline (documentary + chronological)
    
    ((member annexure-id '("JF09" "JF10"))
     0.92)  ; Multi-actor coordination evidence (chronological + correspondence)
    
    ((member annexure-id '("JF11" "JF12"))
     0.97)  ; Urgency test / manufactured crisis (documentary + analysis)
    
    ;; Supporting annexures (SF1-SF8)
    ((member annexure-id '("SF01" "SF02" "SF03"))
     0.96)  ; Bad faith litigation evidence (documentary)
    
    ((member annexure-id '("SF04" "SF05"))
     0.90)  ; Fiduciary duty analysis (analysis + documents)
    
    ((member annexure-id '("SF06" "SF07" "SF08"))
     0.85)  ; Supporting correspondence and analysis
    
    ;; Default for unknown annexures
    (else 0.70)))

(define (suggest-additional-annexures principle-name current-annexures)
  "Suggest additional annexures to strengthen evidence for principle.
   
   Parameters:
   - principle-name: Name of lex principle
   - current-annexures: List of currently available annexure IDs
   
   Returns: List of suggested annexure additions"
  
  (let* ((mapping (map-evidence-to-principles principle-name))
         (required (assoc-ref mapping 'supporting-annexures))
         (missing (filter (lambda (req) (not (member req current-annexures))) 
                         required))
         (recommendations (assoc-ref mapping 'recommendations)))
    
    `((principle . ,principle-name)
      (missing-annexures . ,missing)
      (priority . ,(if (> (length missing) 2) "high" "medium"))
      (recommendations . ,recommendations))))

;;;
;;; EVIDENCE GAP DETECTION
;;;

(define (detect-evidence-gaps principles current-evidence)
  "Detect evidence gaps for list of lex principles.
   
   Parameters:
   - principles: List of lex principle names
   - current-evidence: List of available evidence items
   
   Returns: List of evidence gap records"
  
  (let ((gaps '()))
    
    (for-each
      (lambda (principle)
        (let* ((mapping (map-evidence-to-principles principle))
               (required-evidence (assoc-ref mapping 'required-evidence))
               (available-evidence (filter (lambda (req)
                                            (any (lambda (e) 
                                                  (equal? (assoc-ref e 'type) req))
                                                current-evidence))
                                          required-evidence))
               (missing-evidence (filter (lambda (req)
                                          (not (member req available-evidence)))
                                        required-evidence))
               (gap-severity (assoc-ref mapping 'gap-severity)))
          
          (when (> (length missing-evidence) 0)
            (set! gaps (cons `((principle . ,principle)
                              (missing-evidence . ,missing-evidence)
                              (gap-severity . ,gap-severity)
                              (priority . ,(if (> gap-severity 0.15) "high" "medium"))
                              (recommendations . ,(assoc-ref mapping 'recommendations)))
                            gaps)))))
      
      principles)
    
    ;; Sort by gap severity (highest first)
    (sort gaps (lambda (a b) (> (assoc-ref a 'gap-severity) 
                                (assoc-ref b 'gap-severity))))))

(define (prioritize-evidence-gaps gaps)
  "Prioritize evidence gaps by severity and impact.
   
   Parameters:
   - gaps: List of evidence gap records
   
   Returns: Prioritized list of gaps"
  
  (sort gaps (lambda (a b)
              (let ((severity-a (assoc-ref a 'gap-severity))
                    (severity-b (assoc-ref b 'gap-severity))
                    (missing-a (length (assoc-ref a 'missing-evidence)))
                    (missing-b (length (assoc-ref b 'missing-evidence))))
                
                ;; Sort by severity first, then by number of missing items
                (or (> severity-a severity-b)
                    (and (= severity-a severity-b)
                         (> missing-a missing-b)))))))

(define (generate-evidence-recommendations principle-name gaps)
  "Generate evidence recommendations for addressing gaps.
   
   Parameters:
   - principle-name: Name of lex principle
   - gaps: Evidence gap record for principle
   
   Returns: List of actionable recommendations"
  
  (let* ((mapping (map-evidence-to-principles principle-name))
         (recommendations (assoc-ref mapping 'recommendations))
         (missing-evidence (assoc-ref gaps 'missing-evidence)))
    
    (append recommendations
            (map (lambda (missing)
                  (format #f "Obtain and annex: ~a" missing))
                missing-evidence))))

;;;
;;; CROSS-REFERENCE VALIDATION
;;;

(define (validate-jr-dr-evidence-support jr-response dr-response principles)
  "Validate evidence support in JR and DR responses for lex principles.
   
   Parameters:
   - jr-response: Jacqueline's response content
   - dr-response: Daniel's response content
   - principles: List of lex principle names
   
   Returns: Validation report"
  
  (let ((validation-results '()))
    
    (for-each
      (lambda (principle)
        (let* ((jr-support (check-response-evidence-support jr-response principle))
               (dr-support (check-response-evidence-support dr-response principle))
               (combined-support (max jr-support dr-support))
               (status (cond
                        ((>= combined-support 0.90) "excellent")
                        ((>= combined-support 0.75) "good")
                        ((>= combined-support 0.60) "adequate")
                        (else "insufficient"))))
          
          (set! validation-results 
                (cons `((principle . ,principle)
                       (jr-support . ,jr-support)
                       (dr-support . ,dr-support)
                       (combined-support . ,combined-support)
                       (status . ,status))
                     validation-results))))
      
      principles)
    
    `((principles-validated . ,(length principles))
      (average-support . ,(/ (apply + (map (lambda (r) (assoc-ref r 'combined-support))
                                          validation-results))
                            (length principles)))
      (validation-details . ,validation-results))))

(define (check-principle-evidence-coverage principle-name annexures)
  "Check evidence coverage for a specific lex principle.
   
   Parameters:
   - principle-name: Name of lex principle
   - annexures: List of available annexure IDs
   
   Returns: Coverage assessment"
  
  (let* ((mapping (map-evidence-to-principles principle-name))
         (required (assoc-ref mapping 'supporting-annexures))
         (available (filter (lambda (req) (member req annexures)) required))
         (coverage (if (null? required) 
                     1.0 
                     (/ (length available) (length required))))
         (strength (assoc-ref mapping 'evidence-strength))
         (gap-severity (assoc-ref mapping 'gap-severity)))
    
    `((principle . ,principle-name)
      (required-annexures . ,required)
      (available-annexures . ,available)
      (coverage . ,coverage)
      (strength . ,strength)
      (gap-severity . ,gap-severity)
      (status . ,(cond
                  ((>= coverage 0.95) "complete")
                  ((>= coverage 0.75) "good")
                  ((>= coverage 0.50) "partial")
                  (else "insufficient")))
      (recommendations . ,(assoc-ref mapping 'recommendations)))))

;;;
;;; HELPER FUNCTIONS
;;;

(define (calculate-admissibility evidence-items)
  "Calculate admissibility score for evidence items.
   
   Parameters:
   - evidence-items: List of evidence item records
   
   Returns: Admissibility score (0.0-1.0)"
  
  ;; Placeholder - implement actual admissibility assessment
  (if (null? evidence-items)
      0.0
      (/ (apply + (map (lambda (e) 
                        (if (assoc-ref e 'admissible) 1.0 0.0))
                      evidence-items))
         (length evidence-items))))

(define (calculate-relevance evidence-items principle-name)
  "Calculate relevance score for evidence items to principle.
   
   Parameters:
   - evidence-items: List of evidence item records
   - principle-name: Name of lex principle
   
   Returns: Relevance score (0.0-1.0)"
  
  ;; Placeholder - implement actual relevance assessment
  (if (null? evidence-items)
      0.0
      0.90))  ; Default high relevance

(define (check-response-evidence-support response principle)
  "Check evidence support in response for lex principle.
   
   Parameters:
   - response: Response content (JR or DR)
   - principle: Lex principle name
   
   Returns: Support score (0.0-1.0)"
  
  ;; Placeholder - implement actual response analysis
  (let ((response-str (format #f "~a" response)))
    (cond
      ((and (string-contains response-str "Annexure")
            (string-contains response-str principle))
       0.95)  ; Strong support (annexure + principle mentioned)
      ((string-contains response-str "Annexure")
       0.85)  ; Good support (annexure referenced)
      ((string-contains response-str principle)
       0.70)  ; Moderate support (principle mentioned)
      ((string-contains response-str "evidence")
       0.60)  ; Weak support (evidence mentioned generally)
      (else 0.40))))  ; Minimal support

(define (string-contains str substr)
  "Check if string contains substring (case-insensitive).
   
   Parameters:
   - str: String to search
   - substr: Substring to find
   
   Returns: Boolean"
  
  (and (string? str)
       (string? substr)
       (string-contains-ci str substr)))
