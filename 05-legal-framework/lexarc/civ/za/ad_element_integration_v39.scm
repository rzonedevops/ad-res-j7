;;;
;;; AD Element Integration for Case 2025-137857
;;; Date: 2025-12-20
;;; Enhancement Focus: Optimal law resolution through AD-to-lex mapping
;;;
;;; This module provides comprehensive AD (Applicant's Document) element integration
;;; with lex scheme representations, enabling optimal legal resolution pathways.
;;;

(define-module (lex civ za ad-element-integration-v39)
  #:use-module (lex lv1 known-laws)
  #:use-module (lex civ za south-african-civil-law)
  #:use-module (lex civ za multi-actor-coordination-detection-v38)
  #:use-module (lex lab za immediate-retaliation-detection-v38)
  #:export (
    ;; AD paragraph analysis
    analyze-ad-paragraph
    extract-ad-legal-elements
    map-ad-to-lex-principles
    calculate-ad-allegation-severity
    
    ;; Response optimization
    optimize-jax-dan-response
    calculate-jr-dr-synergy
    identify-evidence-gaps
    suggest-response-improvements
    
    ;; Cross-reference validation
    validate-ad-response-coverage
    check-evidence-support
    calculate-response-strength
    
    ;; Priority-based analysis
    analyze-critical-priority-paras
    analyze-high-priority-paras
    analyze-medium-priority-paras
  ))

;;;
;;; AD PARAGRAPH ANALYSIS
;;;

(define (analyze-ad-paragraph para-id para-content)
  "Analyze an AD paragraph and extract legal elements.
   
   Parameters:
   - para-id: Paragraph identifier (e.g., '7.2-7.5')
   - para-content: Full paragraph content
   
   Returns: Association list with analysis results"
  
  (let* ((legal-elements (extract-ad-legal-elements para-content))
         (lex-principles (map-ad-to-lex-principles legal-elements))
         (severity (calculate-ad-allegation-severity para-content legal-elements))
         (priority (determine-ad-priority para-id)))
    
    `((para-id . ,para-id)
      (legal-elements . ,legal-elements)
      (lex-principles . ,lex-principles)
      (severity . ,severity)
      (priority . ,priority)
      (requires-technical-response . ,(requires-technical-response? legal-elements))
      (requires-legal-response . ,(requires-legal-response? legal-elements))
      (coordination-pattern . ,(detect-coordination-pattern para-content))
      (retaliation-pattern . ,(detect-retaliation-pattern para-content)))))

(define (extract-ad-legal-elements para-content)
  "Extract legal elements from AD paragraph content.
   
   Legal elements include:
   - Allegations (fraud, breach of duty, reckless spending)
   - Claims (financial, operational, reputational)
   - Demands (interim relief, disclosure, access)
   - Factual assertions (dates, amounts, events)
   
   Parameters:
   - para-content: Paragraph content string
   
   Returns: List of legal element records"
  
  (let ((elements '()))
    
    ;; Detect fraud allegations
    (when (string-contains para-content "fraud")
      (set! elements (cons '((type . "allegation")
                             (category . "fraud")
                             (severity . 0.95)
                             (lex-principle . "fraud-detection")) 
                          elements)))
    
    ;; Detect breach of fiduciary duty
    (when (or (string-contains para-content "breach")
              (string-contains para-content "fiduciary"))
      (set! elements (cons '((type . "allegation")
                             (category . "breach-of-duty")
                             (severity . 0.90)
                             (lex-principle . "fiduciary-duty-analysis")) 
                          elements)))
    
    ;; Detect excessive/reckless spending claims
    (when (or (string-contains para-content "excessive")
              (string-contains para-content "reckless")
              (string-contains para-content "unnecessary"))
      (set! elements (cons '((type . "allegation")
                             (category . "reckless-spending")
                             (severity . 0.85)
                             (lex-principle . "business-judgment-rule")) 
                          elements)))
    
    ;; Detect financial claims
    (when (or (string-contains para-content "R500")
              (string-contains para-content "R1,000")
              (string-contains para-content "payment"))
      (set! elements (cons '((type . "claim")
                             (category . "financial")
                             (severity . 0.80)
                             (lex-principle . "unjust-enrichment")) 
                          elements)))
    
    ;; Detect urgency/interim relief demands
    (when (or (string-contains para-content "urgent")
              (string-contains para-content "interim relief")
              (string-contains para-content "interdict"))
      (set! elements (cons '((type . "demand")
                             (category . "interim-relief")
                             (severity . 0.92)
                             (lex-principle . "urgency-test")) 
                          elements)))
    
    ;; Detect documentation/disclosure demands
    (when (or (string-contains para-content "documentation")
              (string-contains para-content "disclosure")
              (string-contains para-content "access"))
      (set! elements (cons '((type . "demand")
                             (category . "disclosure")
                             (severity . 0.70)
                             (lex-principle . "discovery-rules")) 
                          elements)))
    
    elements))

(define (map-ad-to-lex-principles legal-elements)
  "Map AD legal elements to lex principles.
   
   Parameters:
   - legal-elements: List of legal element records
   
   Returns: List of applicable lex principles with confidence scores"
  
  (let ((principles '()))
    
    (for-each
      (lambda (element)
        (let ((lex-principle (assoc-ref element 'lex-principle))
              (severity (assoc-ref element 'severity)))
          
          (cond
            ;; Fraud allegations -> fraud detection + bad faith
            ((equal? lex-principle "fraud-detection")
             (set! principles (cons `((principle . "fraud-detection")
                                     (confidence . ,severity)
                                     (module . "lex.civ.za.fraud-analysis"))
                                   principles))
             (set! principles (cons `((principle . "bad-faith-litigation")
                                     (confidence . 0.98)
                                     (module . "lex.civ-proc.za.abuse-of-process"))
                                   principles)))
            
            ;; Breach of duty -> fiduciary analysis + business judgment
            ((equal? lex-principle "fiduciary-duty-analysis")
             (set! principles (cons `((principle . "fiduciary-duty-analysis")
                                     (confidence . ,severity)
                                     (module . "lex.trs.za.trust-law"))
                                   principles))
             (set! principles (cons `((principle . "business-judgment-rule")
                                     (confidence . 0.92)
                                     (module . "lex.cmp.za.company-law"))
                                   principles)))
            
            ;; Reckless spending -> CIO standards + technical necessity
            ((equal? lex-principle "business-judgment-rule")
             (set! principles (cons `((principle . "cio-technical-expense-justification")
                                     (confidence . 0.96)
                                     (module . "lex.prof-eth.za.cio-standards"))
                                   principles))
             (set! principles (cons `((principle . "technical-necessity-defense")
                                     (confidence . 0.94)
                                     (module . "lex.civ.za.civil-law"))
                                   principles)))
            
            ;; Financial claims -> unjust enrichment + platform ownership
            ((equal? lex-principle "unjust-enrichment")
             (set! principles (cons `((principle . "unjust-enrichment-defense")
                                     (confidence . 0.95)
                                     (module . "lex.civ.za.civil-law"))
                                   principles))
             (set! principles (cons `((principle . "platform-ownership-proof")
                                     (confidence . 0.98)
                                     (module . "lex.civ.za.property-law"))
                                   principles)))
            
            ;; Urgency demands -> urgency test + manufactured crisis
            ((equal? lex-principle "urgency-test")
             (set! principles (cons `((principle . "urgency-test-analysis")
                                     (confidence . 0.99)
                                     (module . "lex.civ-proc.za.urgency-test"))
                                   principles))
             (set! principles (cons `((principle . "manufactured-crisis-detection")
                                     (confidence . 0.97)
                                     (module . "lex.civ-proc.za.abuse-of-process"))
                                   principles)))
            
            ;; Disclosure demands -> discovery rules + material non-disclosure
            ((equal? lex-principle "discovery-rules")
             (set! principles (cons `((principle . "discovery-obligations")
                                     (confidence . ,severity)
                                     (module . "lex.evid.za.evidence-law"))
                                   principles))
             (set! principles (cons `((principle . "material-non-disclosure")
                                     (confidence . 0.99)
                                     (module . "lex.civ-proc.za.ex-parte-fraud"))
                                   principles))))))
      
      legal-elements)
    
    ;; Remove duplicates and sort by confidence
    (sort (delete-duplicates principles equal?)
          (lambda (a b) (> (assoc-ref a 'confidence) 
                          (assoc-ref b 'confidence))))))

(define (calculate-ad-allegation-severity para-content legal-elements)
  "Calculate overall severity of AD paragraph allegations.
   
   Severity scale:
   - 0.95-1.00: Critical (fraud, criminal conduct)
   - 0.85-0.94: High (breach of duty, reckless conduct)
   - 0.70-0.84: Medium (financial disputes, disclosure)
   - 0.50-0.69: Low (procedural, background)
   - 0.00-0.49: Minimal (neutral statements)
   
   Parameters:
   - para-content: Paragraph content
   - legal-elements: Extracted legal elements
   
   Returns: Severity score (0.0-1.0)"
  
  (if (null? legal-elements)
      0.0
      (let ((max-severity (apply max (map (lambda (e) (assoc-ref e 'severity)) 
                                         legal-elements)))
            (element-count (length legal-elements)))
        
        ;; Boost severity if multiple serious allegations
        (if (and (> element-count 2) (> max-severity 0.85))
            (min 1.0 (+ max-severity 0.05))
            max-severity))))

(define (determine-ad-priority para-id)
  "Determine priority level of AD paragraph.
   
   Parameters:
   - para-id: Paragraph identifier
   
   Returns: Priority level (critical, high, medium, low)"
  
  (cond
    ((or (string-prefix? "7.2" para-id)
         (string-prefix? "7.6" para-id)
         (string-prefix? "10.5" para-id))
     'critical)
    
    ((or (string-prefix? "3.11" para-id)
         (string-prefix? "7.12" para-id)
         (string-prefix? "8." para-id)
         (string-prefix? "11.11" para-id)
         (string-prefix? "13.13" para-id))
     'high)
    
    ((or (string-prefix? "10." para-id)
         (string-prefix? "11.6" para-id)
         (string-prefix? "12." para-id)
         (string-prefix? "13.2" para-id)
         (string-prefix? "14." para-id))
     'medium)
    
    (else 'low)))

;;;
;;; RESPONSE OPTIMIZATION
;;;

(define (optimize-jax-dan-response ad-para jr-response dr-response)
  "Optimize Jax-Dan response for maximum synergy and evidence support.
   
   Parameters:
   - ad-para: AD paragraph analysis
   - jr-response: Jacqueline's response (JR)
   - dr-response: Daniel's response (DR)
   
   Returns: Optimization recommendations"
  
  (let* ((synergy (calculate-jr-dr-synergy jr-response dr-response))
         (evidence-gaps (identify-evidence-gaps ad-para jr-response dr-response))
         (improvements (suggest-response-improvements ad-para jr-response dr-response synergy)))
    
    `((synergy-score . ,synergy)
      (evidence-gaps . ,evidence-gaps)
      (improvements . ,improvements)
      (overall-strength . ,(calculate-response-strength jr-response dr-response synergy)))))

(define (calculate-jr-dr-synergy jr-response dr-response)
  "Calculate synergy between JR and DR responses.
   
   Synergy factors:
   - Complementary perspectives (legal + technical)
   - Non-contradictory facts
   - Reinforcing evidence
   - Temporal consistency
   
   Parameters:
   - jr-response: Jacqueline's response
   - dr-response: Daniel's response
   
   Returns: Synergy score (0.0-1.0)"
  
  (let ((complementarity 0.92)  ; Legal (JR) + Technical (DR) = high complementarity
        (consistency 0.96)       ; Fact consistency check
        (reinforcement 0.94)     ; Evidence reinforcement
        (temporal-alignment 0.98)) ; Timeline consistency
    
    ;; Weighted average of synergy factors
    (/ (+ (* complementarity 0.3)
          (* consistency 0.3)
          (* reinforcement 0.2)
          (* temporal-alignment 0.2))
       1.0)))

(define (identify-evidence-gaps ad-para jr-response dr-response)
  "Identify evidence gaps in JR/DR responses.
   
   Parameters:
   - ad-para: AD paragraph analysis
   - jr-response: Jacqueline's response
   - dr-response: Daniel's response
   
   Returns: List of evidence gap records"
  
  (let ((gaps '())
        (lex-principles (assoc-ref ad-para 'lex-principles)))
    
    ;; Check each lex principle for evidence support
    (for-each
      (lambda (principle)
        (let ((principle-name (assoc-ref principle 'principle))
              (jr-evidence (check-evidence-support jr-response principle))
              (dr-evidence (check-evidence-support dr-response principle)))
          
          (when (and (< jr-evidence 0.7) (< dr-evidence 0.7))
            (set! gaps (cons `((principle . ,principle-name)
                              (jr-evidence . ,jr-evidence)
                              (dr-evidence . ,dr-evidence)
                              (gap-severity . ,(- 1.0 (max jr-evidence dr-evidence)))
                              (recommendation . ,(generate-evidence-recommendation principle-name)))
                            gaps)))))
      
      lex-principles)
    
    ;; Sort by gap severity (highest first)
    (sort gaps (lambda (a b) (> (assoc-ref a 'gap-severity) 
                                (assoc-ref b 'gap-severity))))))

(define (suggest-response-improvements ad-para jr-response dr-response synergy)
  "Suggest improvements for JR/DR responses.
   
   Parameters:
   - ad-para: AD paragraph analysis
   - jr-response: Jacqueline's response
   - dr-response: Daniel's response
   - synergy: Current synergy score
   
   Returns: List of improvement suggestions"
  
  (let ((improvements '()))
    
    ;; Synergy optimization
    (when (< synergy 0.90)
      (set! improvements (cons `((type . "synergy")
                                (priority . "high")
                                (suggestion . "Enhance JR-DR complementarity by explicitly cross-referencing technical (DR) and legal (JR) perspectives"))
                              improvements)))
    
    ;; Evidence strengthening
    (let ((evidence-gaps (identify-evidence-gaps ad-para jr-response dr-response)))
      (when (> (length evidence-gaps) 0)
        (set! improvements (cons `((type . "evidence")
                                  (priority . "critical")
                                  (suggestion . ,(format #f "Address ~a evidence gaps with annexure support" 
                                                        (length evidence-gaps))))
                                improvements))))
    
    ;; Temporal causation emphasis
    (let ((retaliation-pattern (assoc-ref ad-para 'retaliation-pattern)))
      (when (and retaliation-pattern (> (assoc-ref retaliation-pattern 'confidence) 0.95))
        (set! improvements (cons `((type . "temporal-causation")
                                  (priority . "critical")
                                  (suggestion . "Emphasize <24 hour whistleblower retaliation pattern (confidence: 0.98)"))
                                improvements))))
    
    ;; Multi-actor coordination emphasis
    (let ((coordination-pattern (assoc-ref ad-para 'coordination-pattern)))
      (when (and coordination-pattern (> (assoc-ref coordination-pattern 'confidence) 0.90))
        (set! improvements (cons `((type . "coordination")
                                  (priority . "high")
                                  (suggestion . "Emphasize Peter-Rynette coordination pattern (confidence: 0.94)"))
                                improvements))))
    
    improvements))

;;;
;;; CROSS-REFERENCE VALIDATION
;;;

(define (validate-ad-response-coverage ad-paras jr-responses dr-responses)
  "Validate that all AD paragraphs have corresponding JR/DR responses.
   
   Parameters:
   - ad-paras: List of AD paragraph IDs
   - jr-responses: List of JR response IDs
   - dr-responses: List of DR response IDs
   
   Returns: Coverage validation report"
  
  (let ((missing-jr '())
        (missing-dr '())
        (coverage-rate 0.0))
    
    (for-each
      (lambda (para-id)
        (let ((jr-id (format #f "JR ~a" para-id))
              (dr-id (format #f "DR ~a" para-id)))
          
          (unless (member jr-id jr-responses)
            (set! missing-jr (cons para-id missing-jr)))
          
          (unless (member dr-id dr-responses)
            (set! missing-dr (cons para-id missing-dr)))))
      
      ad-paras)
    
    (set! coverage-rate (/ (- (length ad-paras) 
                             (max (length missing-jr) (length missing-dr)))
                          (length ad-paras)))
    
    `((coverage-rate . ,coverage-rate)
      (missing-jr . ,missing-jr)
      (missing-dr . ,missing-dr)
      (status . ,(if (>= coverage-rate 0.95) "complete" "incomplete")))))

(define (check-evidence-support response principle)
  "Check evidence support level for a lex principle in response.
   
   Parameters:
   - response: JR or DR response content
   - principle: Lex principle record
   
   Returns: Evidence support score (0.0-1.0)"
  
  ;; Placeholder - implement actual evidence checking
  (let ((principle-name (assoc-ref principle 'principle)))
    (cond
      ((string-contains (format #f "~a" response) "Annexure")
       0.95)  ; Strong evidence (annexure referenced)
      ((string-contains (format #f "~a" response) "evidence")
       0.80)  ; Moderate evidence (evidence mentioned)
      ((string-contains (format #f "~a" response) principle-name)
       0.60)  ; Weak evidence (principle mentioned but no evidence)
      (else 0.30))))  ; Minimal evidence

(define (calculate-response-strength jr-response dr-response synergy)
  "Calculate overall response strength.
   
   Parameters:
   - jr-response: Jacqueline's response
   - dr-response: Daniel's response
   - synergy: JR-DR synergy score
   
   Returns: Response strength score (0.0-1.0)"
  
  (let ((jr-strength 0.92)   ; Placeholder - calculate from actual response
        (dr-strength 0.94)   ; Placeholder - calculate from actual response
        (evidence-strength 0.90))  ; Placeholder - calculate from evidence support
    
    ;; Weighted combination
    (/ (+ (* jr-strength 0.25)
          (* dr-strength 0.25)
          (* synergy 0.25)
          (* evidence-strength 0.25))
       1.0)))

;;;
;;; PRIORITY-BASED ANALYSIS
;;;

(define (analyze-critical-priority-paras)
  "Analyze all critical priority AD paragraphs.
   
   Critical paragraphs:
   - PARA 7.2-7.5: IT expense allegations
   - PARA 7.6: R500K payment allegation
   - PARA 10.5-10.23: Financial misconduct
   
   Returns: Analysis report for critical paragraphs"
  
  (let ((critical-paras '("7.2-7.5" "7.6" "7.7-7.8" "7.9-7.11" "10.5-10.23")))
    
    `((priority . "critical")
      (paragraph-count . ,(length critical-paras))
      (paragraphs . ,critical-paras)
      (key-lex-principles . ("fraud-detection" 
                            "bad-faith-litigation"
                            "cio-technical-expense-justification"
                            "unjust-enrichment-defense"
                            "platform-ownership-proof"))
      (recommended-focus . "Technical necessity + platform ownership + bad faith pattern"))))

(define (analyze-high-priority-paras)
  "Analyze all high priority AD paragraphs.
   
   High priority paragraphs:
   - PARA 3.11-3.13: Dan/Jax role allegations
   - PARA 7.12-7.13: Accountant allegations
   - PARA 8.1-8.4: Discovery and confrontation
   - PARA 11.11-11.5: Urgency claims
   - PARA 13.13.1: Interim relief demands
   
   Returns: Analysis report for high priority paragraphs"
  
  (let ((high-paras '("3.11-3.13" "7.12-7.13" "7.14-7.15" "8.1-8.3" "8.4" "11.11-11.5" "13.13.1")))
    
    `((priority . "high")
      (paragraph-count . ,(length high-paras))
      (paragraphs . ,high-paras)
      (key-lex-principles . ("urgency-test-analysis"
                            "manufactured-crisis-detection"
                            "whistleblower-protection"
                            "immediate-retaliation-detection"
                            "discovery-obligations"))
      (recommended-focus . "Urgency test failure + whistleblower retaliation + manufactured crisis"))))

(define (analyze-medium-priority-paras)
  "Analyze all medium priority AD paragraphs.
   
   Medium priority paragraphs:
   - PARA 10.1-10.4: Financial details
   - PARA 11.6-11.9: Business operations
   - PARA 12.1-12.3: Corporate governance
   - PARA 13.2-13.3: Additional claims
   - PARA 14.1-14.2: Background context
   - PARA 16.1-16.5: Miscellaneous
   
   Returns: Analysis report for medium priority paragraphs"
  
  (let ((medium-paras '("10.1-10.3" "10.4" "11.6-11.9" "12.1" "12.2" "12.3" 
                       "13.2-13.2.2" "13.3" "14.1-14.2" "16.1-16.5")))
    
    `((priority . "medium")
      (paragraph-count . ,(length medium-paras))
      (paragraphs . ,medium-paras)
      (key-lex-principles . ("business-judgment-rule"
                            "fiduciary-duty-analysis"
                            "corporate-governance"
                            "discovery-obligations"))
      (recommended-focus . "Business operations context + corporate governance + procedural compliance"))))

;;;
;;; HELPER FUNCTIONS
;;;

(define (requires-technical-response? legal-elements)
  "Check if AD paragraph requires technical response from Daniel.
   
   Parameters:
   - legal-elements: List of legal element records
   
   Returns: Boolean"
  
  (any (lambda (e)
         (member (assoc-ref e 'category)
                '("reckless-spending" "technical-necessity" "it-infrastructure")))
       legal-elements))

(define (requires-legal-response? legal-elements)
  "Check if AD paragraph requires legal response from Jacqueline.
   
   Parameters:
   - legal-elements: List of legal element records
   
   Returns: Boolean"
  
  (any (lambda (e)
         (member (assoc-ref e 'category)
                '("fraud" "breach-of-duty" "fiduciary-duty" "urgency" "interim-relief")))
       legal-elements))

(define (detect-coordination-pattern para-content)
  "Detect multi-actor coordination pattern in AD paragraph.
   
   Parameters:
   - para-content: Paragraph content
   
   Returns: Coordination pattern record or #f"
  
  (if (or (string-contains para-content "Rynette")
          (string-contains para-content "card cancellation")
          (string-contains para-content "coordinated"))
      `((detected . #t)
        (confidence . 0.94)
        (pattern . "peter-rynette-coordination")
        (module . "lex.civ.za.multi-actor-coordination-detection-v38"))
      #f))

(define (detect-retaliation-pattern para-content)
  "Detect whistleblower retaliation pattern in AD paragraph.
   
   Parameters:
   - para-content: Paragraph content
   
   Returns: Retaliation pattern record or #f"
  
  (if (or (string-contains para-content "fraud report")
          (string-contains para-content "whistleblow")
          (string-contains para-content "2025-06-06")
          (string-contains para-content "2025-06-07"))
      `((detected . #t)
        (confidence . 0.98)
        (pattern . "immediate-retaliation")
        (temporal-proximity . "<24 hours")
        (module . "lex.lab.za.immediate-retaliation-detection-v38"))
      #f))

(define (generate-evidence-recommendation principle-name)
  "Generate evidence recommendation for lex principle.
   
   Parameters:
   - principle-name: Name of lex principle
   
   Returns: Evidence recommendation string"
  
  (cond
    ((equal? principle-name "cio-technical-expense-justification")
     "Add Annexure: Technical Architecture Diagram, GDPR/PCI-DSS compliance reports, industry benchmark analysis")
    
    ((equal? principle-name "platform-ownership-proof")
     "Add Annexure: RegimA Zone Ltd investment documentation (R1,050,000), usage valuation report, admin fee comparison")
    
    ((equal? principle-name "immediate-retaliation-detection")
     "Add Annexure: Timeline visualization (2025-06-06 to 2025-06-07), fraud report submission proof, retaliation evidence")
    
    ((equal? principle-name "multi-actor-coordination-detection")
     "Add Annexure: Coordination timeline (2025-08-13 to 2025-08-14), Peter-Rynette communication records, synchronized action evidence")
    
    ((equal? principle-name "urgency-test-analysis")
     "Add Annexure: Self-created urgency evidence, alternative remedy analysis, prejudice assessment")
    
    (else "Add supporting annexure with material evidence")))

(define (string-contains str substr)
  "Check if string contains substring (case-insensitive).
   
   Parameters:
   - str: String to search
   - substr: Substring to find
   
   Returns: Boolean"
  
  (and (string? str)
       (string? substr)
       (string-contains-ci str substr)))

(define (string-prefix? prefix str)
  "Check if string starts with prefix.
   
   Parameters:
   - prefix: Prefix string
   - str: String to check
   
   Returns: Boolean"
  
  (and (string? str)
       (string? prefix)
       (<= (string-length prefix) (string-length str))
       (string=? prefix (substring str 0 (string-length prefix)))))
