;; ============================================================================
;; SOUTH AFRICAN CIVIL LAW - MULTI-ROLE CONFLICT DETECTION (ENHANCED)
;; ============================================================================
;; File: south_african_civil_law_multi_role_conflict_enhanced.scm
;; Purpose: Enhanced multi-role conflict detection for Case 2025-137857
;; Date: 2025-11-15
;; Confidence: 0.98
;; 
;; This module provides enhanced detection and analysis of multi-role conflicts
;; based on comprehensive entity analysis from the ad-res-j7 repository.
;;
;; KEY ENHANCEMENTS:
;; - Triple-role conflict detection (Rynette: accountant + trustee + creditor)
;; - Undisclosed trustee conflict detection (Bantjies: accountant + undisclosed trustee)
;; - Founder-trustee power concentration (Peter: founder + main trustee)
;; - Professional independence violation detection
;; - Conflict severity scoring with temporal factors
;; ============================================================================

(define-module (lex civ za multi-role-conflict-enhanced)
  #:use-module (lex lv1 known-laws)
  #:use-module (srfi srfi-1)
  #:use-module (srfi srfi-9)
  #:use-module (ice-9 hash-table)
  #:export (
    ;; Multi-Role Conflict Detection
    detect-triple-role-conflict
    detect-undisclosed-trustee-conflict
    detect-founder-trustee-concentration
    detect-professional-independence-violation
    
    ;; Conflict Analysis
    analyze-role-combinations
    calculate-conflict-severity
    identify-conflicting-duties
    assess-independence-compromise
    
    ;; Specific Case Analyzers
    analyze-rynette-triple-role
    analyze-bantjies-undisclosed-trustee
    analyze-peter-power-concentration
    
    ;; Resolution Functions
    resolve-multi-role-conflict
    recommend-conflict-mitigation
    generate-conflict-report
  ))

;; ============================================================================
;; PART 1: ROLE DEFINITIONS AND CONFLICT MATRICES
;; ============================================================================

;; Role definitions with fiduciary and professional duties
(define role-definitions
  '((accountant
     (type . "professional")
     (duties . ("independence" "objectivity" "professional-skepticism" "client-confidentiality"))
     (regulatory-body . "SAICA")
     (conflicts-with . ("trustee" "director" "creditor" "debtor")))
    
    (trustee
     (type . "fiduciary")
     (duties . ("loyalty" "good-faith" "beneficiary-interests" "impartiality" "prudence"))
     (regulatory-framework . "trust-law")
     (conflicts-with . ("beneficiary" "creditor-of-trust" "accountant-of-trust")))
    
    (creditor
     (type . "financial")
     (duties . ("debt-collection" "self-interest-maximization"))
     (conflicts-with . ("debtor" "accountant-of-debtor" "trustee-of-debtor")))
    
    (founder
     (type . "trust-role")
     (powers . ("trust-creation" "beneficiary-designation" "trustee-appointment"))
     (conflicts-with . ("beneficiary" "when-combined-with-trustee")))
    
    (main-trustee
     (type . "fiduciary")
     (powers . ("unilateral-decision-making" "asset-control" "beneficiary-exclusion"))
     (conflicts-with . ("beneficiary" "co-trustees" "when-combined-with-founder")))
    
    (director
     (type . "fiduciary")
     (duties . ("company-interests" "shareholder-interests" "good-faith" "care-and-skill"))
     (conflicts-with . ("competing-company-director" "creditor-of-company" "trustee-of-controlling-shareholder")))
    
    (beneficiary
     (type . "trust-role")
     (rights . ("information" "accounting" "fair-treatment" "trust-assets-protection"))
     (conflicts-with . ("trustee" "creditor-of-trust")))))

;; Conflict severity matrix (base scores)
(define conflict-severity-matrix
  '((("accountant" "trustee") . 0.92)
    (("accountant" "creditor") . 0.88)
    (("accountant" "trustee" "creditor") . 0.98)  ;; Triple-role - highest severity
    (("trustee" "creditor") . 0.90)
    (("founder" "main-trustee") . 0.96)
    (("trustee" "beneficiary") . 0.97)
    (("accountant-undisclosed" "trustee") . 0.96)
    (("director" "trustee-of-controlling-shareholder") . 0.93)))

;; ============================================================================
;; PART 2: TRIPLE-ROLE CONFLICT DETECTION
;; ============================================================================

(define (detect-triple-role-conflict entity)
  "Detect triple-role conflicts (e.g., accountant + trustee + creditor).
   Returns conflict analysis with severity score."
  (let* ((roles (hash-ref entity 'roles '()))
         (role-count (length roles))
         (has-accountant (member "accountant" roles))
         (has-trustee (member "trustee" roles))
         (has-creditor (member "creditor" roles))
         (has-director (member "director" roles)))
    
    (cond
      ;; Triple-role: Accountant + Trustee + Creditor (Rynette case)
      ((and has-accountant has-trustee has-creditor)
       (make-conflict-report
        'type "triple-role-conflict"
        'roles '("accountant" "trustee" "creditor")
        'severity 0.98
        'priority "critical"
        'description "Accountant + Trustee + Creditor creates irreconcilable conflicts"
        'conflicting-duties '(
          ("accountant-independence" . "trustee-loyalty")
          ("accountant-objectivity" . "creditor-self-interest")
          ("trustee-beneficiary-interests" . "creditor-debt-collection")
          ("professional-skepticism" . "fiduciary-advocacy"))
        'regulatory-violations '("SAICA-independence" "trust-law-fiduciary-duty")
        'evidence-required '(
          "role-documentation"
          "debt-records"
          "professional-engagement-letters"
          "trustee-appointment-documents")
        'confidence 0.98))
      
      ;; Double-role: Accountant + Trustee
      ((and has-accountant has-trustee)
       (make-conflict-report
        'type "double-role-conflict"
        'roles '("accountant" "trustee")
        'severity 0.92
        'priority "high"
        'description "Accountant + Trustee compromises professional independence"
        'conflicting-duties '(
          ("accountant-independence" . "trustee-loyalty")
          ("professional-objectivity" . "fiduciary-advocacy"))
        'regulatory-violations '("SAICA-independence")
        'confidence 0.94))
      
      ;; Double-role: Trustee + Creditor
      ((and has-trustee has-creditor)
       (make-conflict-report
        'type "double-role-conflict"
        'roles '("trustee" "creditor")
        'severity 0.90
        'priority "high"
        'description "Trustee + Creditor creates self-interest conflict"
        'conflicting-duties '(
          ("trustee-beneficiary-interests" . "creditor-self-interest")
          ("fiduciary-impartiality" . "debt-collection"))
        'confidence 0.91))
      
      ;; No multi-role conflict detected
      (else
       (make-conflict-report
        'type "no-multi-role-conflict"
        'severity 0.0
        'confidence 1.0)))))

;; ============================================================================
;; PART 3: UNDISCLOSED TRUSTEE CONFLICT DETECTION
;; ============================================================================

(define (detect-undisclosed-trustee-conflict entity)
  "Detect undisclosed trustee conflicts (e.g., accountant with hidden trustee role).
   Returns conflict analysis with material non-disclosure assessment."
  (let* ((roles (hash-ref entity 'roles '()))
         (disclosed-roles (hash-ref entity 'disclosed-roles '()))
         (has-accountant (member "accountant" roles))
         (has-trustee (member "trustee" roles))
         (trustee-disclosed (member "trustee" disclosed-roles)))
    
    (cond
      ;; Undisclosed trustee while serving as accountant (Bantjies case)
      ((and has-accountant has-trustee (not trustee-disclosed))
       (make-conflict-report
        'type "undisclosed-trustee-conflict"
        'roles '("accountant" "trustee-undisclosed")
        'severity 0.96
        'priority "critical"
        'description "Undisclosed trustee role while serving as accountant"
        'material-non-disclosure #t
        'conflicting-duties '(
          ("accountant-independence" . "trustee-loyalty")
          ("professional-objectivity" . "fiduciary-advocacy")
          ("duty-to-disclose-conflicts" . "concealment"))
        'regulatory-violations '(
          "SAICA-independence"
          "SAICA-disclosure-requirements"
          "trust-law-fiduciary-duty")
        'evidence-required '(
          "trustee-appointment-documents"
          "professional-engagement-letters"
          "conflict-disclosure-analysis"
          "timeline-of-appointments")
        'confidence 0.96))
      
      ;; Trustee role disclosed but timing unclear
      ((and has-accountant has-trustee trustee-disclosed)
       (make-conflict-report
        'type "disclosed-trustee-conflict"
        'roles '("accountant" "trustee-disclosed")
        'severity 0.92
        'priority "high"
        'description "Disclosed trustee role still compromises accountant independence"
        'material-non-disclosure #f
        'confidence 0.94))
      
      ;; No undisclosed conflict
      (else
       (make-conflict-report
        'type "no-undisclosed-conflict"
        'severity 0.0
        'confidence 1.0)))))

;; ============================================================================
;; PART 4: FOUNDER-TRUSTEE POWER CONCENTRATION DETECTION
;; ============================================================================

(define (detect-founder-trustee-concentration entity)
  "Detect founder + main trustee power concentration (Peter case).
   Returns analysis of unchecked authority and power abuse risk."
  (let* ((roles (hash-ref entity 'roles '()))
         (has-founder (member "founder" roles))
         (has-main-trustee (member "main-trustee" roles))
         (has-trustee (member "trustee" roles))
         (beneficiaries (hash-ref entity 'beneficiaries '()))
         (attacking-beneficiaries (hash-ref entity 'attacking-beneficiaries #f)))
    
    (cond
      ;; Founder + Main Trustee attacking beneficiaries (Peter case)
      ((and has-founder has-main-trustee attacking-beneficiaries)
       (make-conflict-report
        'type "founder-main-trustee-beneficiary-attack"
        'roles '("founder" "main-trustee")
        'severity 0.98
        'priority "critical"
        'description "Founder + Main Trustee with unchecked authority attacking beneficiaries"
        'power-concentration '(
          "founder-powers" 
          "main-trustee-unilateral-authority"
          "no-effective-oversight"
          "beneficiary-exclusion")
        'abuse-indicators '(
          "trust-weaponization"
          "beneficiary-attack"
          "asset-misuse"
          "fiduciary-duty-breach")
        'conflicting-duties '(
          ("trustee-beneficiary-interests" . "personal-litigation-interests")
          ("fiduciary-loyalty" . "beneficiary-antagonism")
          ("trust-asset-protection" . "trust-asset-weaponization"))
        'evidence-required '(
          "trust-deed"
          "trustee-appointment-documents"
          "litigation-funding-analysis"
          "beneficiary-rights-violations")
        'confidence 0.98))
      
      ;; Founder + Main Trustee without beneficiary attack
      ((and has-founder has-main-trustee)
       (make-conflict-report
        'type "founder-main-trustee-concentration"
        'roles '("founder" "main-trustee")
        'severity 0.96
        'priority "high"
        'description "Founder + Main Trustee creates unchecked authority"
        'power-concentration '(
          "founder-powers" 
          "main-trustee-unilateral-authority"
          "no-effective-oversight")
        'confidence 0.96))
      
      ;; Founder + Trustee (not main trustee)
      ((and has-founder has-trustee)
       (make-conflict-report
        'type "founder-trustee-concentration"
        'roles '("founder" "trustee")
        'severity 0.88
        'priority "medium"
        'description "Founder + Trustee creates potential for power concentration"
        'confidence 0.89))
      
      ;; No power concentration detected
      (else
       (make-conflict-report
        'type "no-power-concentration"
        'severity 0.0
        'confidence 1.0)))))

;; ============================================================================
;; PART 5: PROFESSIONAL INDEPENDENCE VIOLATION DETECTION
;; ============================================================================

(define (detect-professional-independence-violation entity)
  "Detect professional independence violations for accountants.
   Analyzes SAICA standards compliance."
  (let* ((roles (hash-ref entity 'roles '()))
         (has-accountant (member "accountant" roles))
         (has-trustee (member "trustee" roles))
         (has-director (member "director" roles))
         (has-creditor (member "creditor" roles))
         (financial-interest (hash-ref entity 'financial-interest-in-client #f)))
    
    (if (not has-accountant)
        ;; Not an accountant - no professional independence requirements
        (make-conflict-report
         'type "not-applicable"
         'severity 0.0
         'confidence 1.0)
        
        ;; Accountant - check for independence violations
        (let ((violations '())
              (severity 0.0))
          
          ;; Check for trustee role
          (when has-trustee
            (set! violations (cons "trustee-role-compromises-independence" violations))
            (set! severity (max severity 0.92)))
          
          ;; Check for director role
          (when has-director
            (set! violations (cons "director-role-compromises-independence" violations))
            (set! severity (max severity 0.88)))
          
          ;; Check for creditor role
          (when has-creditor
            (set! violations (cons "creditor-role-compromises-independence" violations))
            (set! severity (max severity 0.90)))
          
          ;; Check for financial interest
          (when financial-interest
            (set! violations (cons "financial-interest-compromises-independence" violations))
            (set! severity (max severity 0.85)))
          
          ;; Generate report
          (if (null? violations)
              (make-conflict-report
               'type "no-independence-violation"
               'severity 0.0
               'confidence 1.0)
              (make-conflict-report
               'type "professional-independence-violation"
               'violations violations
               'severity severity
               'priority (if (>= severity 0.90) "critical" "high")
               'description "Professional independence compromised by conflicting roles"
               'regulatory-framework "SAICA-Code-of-Professional-Conduct"
               'evidence-required '(
                 "professional-engagement-letters"
                 "independence-declarations"
                 "conflict-disclosure-analysis")
               'confidence 0.95))))))

;; ============================================================================
;; PART 6: CONFLICT SEVERITY CALCULATION
;; ============================================================================

(define (calculate-conflict-severity entity temporal-factors)
  "Calculate overall conflict severity with temporal factors.
   
   Temporal factors:
   - immediate-retaliation: +0.05
   - coordinated-actions: +0.04
   - evidence-destruction: +0.06
   - manufactured-crisis: +0.05"
  (let* ((base-severity (get-base-conflict-severity entity))
         (temporal-boost 0.0))
    
    ;; Add temporal factor boosts
    (when (hash-ref temporal-factors 'immediate-retaliation #f)
      (set! temporal-boost (+ temporal-boost 0.05)))
    
    (when (hash-ref temporal-factors 'coordinated-actions #f)
      (set! temporal-boost (+ temporal-boost 0.04)))
    
    (when (hash-ref temporal-factors 'evidence-destruction #f)
      (set! temporal-boost (+ temporal-boost 0.06)))
    
    (when (hash-ref temporal-factors 'manufactured-crisis #f)
      (set! temporal-boost (+ temporal-boost 0.05)))
    
    ;; Return total severity (capped at 1.0)
    (min 1.0 (+ base-severity temporal-boost))))

(define (get-base-conflict-severity entity)
  "Get base conflict severity from role combinations."
  (let* ((roles (hash-ref entity 'roles '()))
         (role-count (length roles)))
    
    (cond
      ;; Triple-role conflicts
      ((and (member "accountant" roles)
            (member "trustee" roles)
            (member "creditor" roles))
       0.98)
      
      ;; Founder + Main Trustee
      ((and (member "founder" roles)
            (member "main-trustee" roles))
       0.96)
      
      ;; Undisclosed trustee + accountant
      ((and (member "accountant" roles)
            (member "trustee-undisclosed" roles))
       0.96)
      
      ;; Accountant + Trustee
      ((and (member "accountant" roles)
            (member "trustee" roles))
       0.92)
      
      ;; Trustee + Creditor
      ((and (member "trustee" roles)
            (member "creditor" roles))
       0.90)
      
      ;; Default: no significant conflict
      (else 0.0))))

;; ============================================================================
;; PART 7: SPECIFIC CASE ANALYZERS
;; ============================================================================

(define (analyze-rynette-triple-role)
  "Analyze Rynette Farrar's triple-role conflict.
   Accountant + Trustee + Creditor (R1,035,000+ debt)"
  (let ((entity (make-hash-table)))
    (hash-set! entity 'id "rynette-farrar")
    (hash-set! entity 'roles '("accountant" "trustee" "creditor" "director" "financial-controller"))
    (hash-set! entity 'financial-interest-in-client #t)
    (hash-set! entity 'debt-amount 1035000)
    (hash-set! entity 'email-control "pete@regima.com")
    
    (let* ((triple-role (detect-triple-role-conflict entity))
           (independence (detect-professional-independence-violation entity))
           (temporal-factors (make-hash-table)))
      
      ;; Add temporal factors
      (hash-set! temporal-factors 'coordinated-actions #t)
      (hash-set! temporal-factors 'evidence-destruction #t)  ;; Shopify orders removed
      
      (let ((total-severity (calculate-conflict-severity entity temporal-factors)))
        
        (make-conflict-report
         'entity-id "rynette-farrar"
         'type "triple-role-conflict-comprehensive"
         'roles '("accountant" "trustee" "creditor" "director" "financial-controller")
         'severity total-severity
         'priority "critical"
         'description "Triple-role conflict with coordinated sabotage and evidence destruction"
         'conflicting-duties '(
           ("accountant-independence" . "trustee-loyalty")
           ("accountant-objectivity" . "creditor-self-interest")
           ("trustee-beneficiary-interests" . "creditor-debt-collection")
           ("professional-skepticism" . "fiduciary-advocacy")
           ("financial-controller-objectivity" . "personal-financial-interest"))
         'regulatory-violations '(
           "SAICA-independence"
           "SAICA-disclosure-requirements"
           "trust-law-fiduciary-duty")
         'temporal-patterns '(
           ("confrontation-by-jax" . "2025-05-15")
           ("shopify-orders-removed" . "2025-05-22")
           ("domain-purchased-by-son" . "2025-05-29")
           ("retaliation-timing" . "7-days"))
         'evidence '(
           "R1,035,000+ debt to companies"
           "Shopify order removal (22 May 2025)"
           "Email control (pete@regima.com)"
           "Son purchased domain (29 May 2025)"
           "Bank letter for revenue redirection (14 April 2025)")
         'confidence 0.97)))))

(define (analyze-bantjies-undisclosed-trustee)
  "Analyze Daniel Bantjies' undisclosed trustee conflict.
   Accountant + Undisclosed Trustee"
  (let ((entity (make-hash-table)))
    (hash-set! entity 'id "daniel-bantjies")
    (hash-set! entity 'roles '("accountant" "trustee"))
    (hash-set! entity 'disclosed-roles '("accountant"))  ;; Trustee not disclosed
    
    (let* ((undisclosed (detect-undisclosed-trustee-conflict entity))
           (independence (detect-professional-independence-violation entity))
           (temporal-factors (make-hash-table)))
      
      ;; Add temporal factors
      (hash-set! temporal-factors 'coordinated-actions #t)
      
      (let ((total-severity (calculate-conflict-severity entity temporal-factors)))
        
        (make-conflict-report
         'entity-id "daniel-bantjies"
         'type "undisclosed-trustee-conflict-comprehensive"
         'roles '("accountant" "trustee-undisclosed")
         'severity total-severity
         'priority "critical"
         'description "Undisclosed trustee role while serving as accountant with coordinated control"
         'material-non-disclosure #t
         'conflicting-duties '(
           ("accountant-independence" . "trustee-loyalty")
           ("professional-objectivity" . "fiduciary-advocacy")
           ("duty-to-disclose-conflicts" . "concealment"))
         'regulatory-violations '(
           "SAICA-independence"
           "SAICA-disclosure-requirements"
           "trust-law-fiduciary-duty")
         'temporal-patterns '(
           ("fraud-reports-received" . "2025-06-06")
           ("cards-cancelled-by-peter" . "2025-06-07")
           ("coordination-timing" . "1-day"))
         'evidence '(
           "Trustee appointment not disclosed"
           "Professional engagement letters lacking conflict disclosure"
           "Coordination with Peter and Rynette"
           "Evidence custodian role creates bias")
         'confidence 0.94)))))

(define (analyze-peter-power-concentration)
  "Analyze Peter Faucitt's founder + main trustee power concentration.
   Founder + Main Trustee attacking beneficiaries"
  (let ((entity (make-hash-table)))
    (hash-set! entity 'id "peter-faucitt")
    (hash-set! entity 'roles '("founder" "main-trustee" "director"))
    (hash-set! entity 'beneficiaries '("jacqueline-faucitt" "daniel-faucitt"))
    (hash-set! entity 'attacking-beneficiaries #t)
    
    (let* ((concentration (detect-founder-trustee-concentration entity))
           (temporal-factors (make-hash-table)))
      
      ;; Add temporal factors
      (hash-set! temporal-factors 'immediate-retaliation #t)
      (hash-set! temporal-factors 'coordinated-actions #t)
      (hash-set! temporal-factors 'manufactured-crisis #t)
      
      (let ((total-severity (calculate-conflict-severity entity temporal-factors)))
        
        (make-conflict-report
         'entity-id "peter-faucitt"
         'type "founder-main-trustee-beneficiary-attack-comprehensive"
         'roles '("founder" "main-trustee" "director")
         'severity total-severity
         'priority "critical"
         'description "Founder + Main Trustee with unchecked authority attacking beneficiaries through trust weaponization"
         'power-concentration '(
           "founder-powers" 
           "main-trustee-unilateral-authority"
           "no-effective-oversight"
           "beneficiary-exclusion"
           "backdating-scheme")
         'abuse-indicators '(
           "trust-weaponization"
           "beneficiary-attack"
           "asset-misuse"
           "fiduciary-duty-breach"
           "manufactured-crisis"
           "immediate-retaliation")
         'conflicting-duties '(
           ("trustee-beneficiary-interests" . "personal-litigation-interests")
           ("fiduciary-loyalty" . "beneficiary-antagonism")
           ("trust-asset-protection" . "trust-asset-weaponization"))
         'temporal-patterns '(
           ("fraud-reports-to-accountant" . "2025-06-06")
           ("cards-cancelled" . "2025-06-07")
           ("jax-signature-obtained" . "2025-08-11")
           ("interdict-filed" . "2025-08-13")
           ("retaliation-timing" . "1-day")
           ("betrayal-timing" . "2-days"))
         'backdating-scheme '(
           ("claimed-appointment-date" . "2025-07-01")
           ("actual-appointment-date" . "2025-08-11")
           ("backdating-days" . 41))
         'evidence '(
           "Trust-funded litigation against beneficiaries"
           "Card cancellations (7 June 2025)"
           "Backdating scheme (41 days)"
           "Manufactured urgency"
           "Material non-disclosure in ex parte application"
           "Hypocrisy (R1,365,000 own withdrawals)")
         'confidence 0.98)))))

;; ============================================================================
;; PART 8: HELPER FUNCTIONS
;; ============================================================================

(define (make-conflict-report . args)
  "Create a conflict report hash table from key-value pairs."
  (let ((report (make-hash-table)))
    (let loop ((args args))
      (if (null? args)
          report
          (begin
            (hash-set! report (car args) (cadr args))
            (loop (cddr args)))))))

(define (resolve-multi-role-conflict conflict-report)
  "Provide resolution recommendations for multi-role conflicts."
  (let* ((conflict-type (hash-ref conflict-report 'type))
         (severity (hash-ref conflict-report 'severity 0.0)))
    
    (cond
      ((>= severity 0.95)
       '((recommendation . "immediate-role-separation")
         (urgency . "critical")
         (actions . (
           "Remove from conflicting role immediately"
           "Appoint independent professional"
           "Conduct forensic investigation"
           "Assess damage and liability"))))
      
      ((>= severity 0.85)
       '((recommendation . "role-separation-required")
         (urgency . "high")
         (actions . (
           "Separate conflicting roles within 30 days"
           "Implement oversight mechanisms"
           "Disclose conflicts to all affected parties"))))
      
      (else
       '((recommendation . "conflict-disclosure-and-monitoring")
         (urgency . "medium")
         (actions . (
           "Disclose conflicts to affected parties"
           "Implement monitoring and review"
           "Consider role separation if conflicts escalate")))))))

(define (generate-conflict-report entity)
  "Generate comprehensive conflict report for an entity."
  (let* ((triple-role (detect-triple-role-conflict entity))
         (undisclosed (detect-undisclosed-trustee-conflict entity))
         (concentration (detect-founder-trustee-concentration entity))
         (independence (detect-professional-independence-violation entity)))
    
    (make-hash-table
     'entity-id (hash-ref entity 'id)
     'triple-role-analysis triple-role
     'undisclosed-trustee-analysis undisclosed
     'power-concentration-analysis concentration
     'professional-independence-analysis independence
     'timestamp (current-time)
     'confidence 0.96)))

;; ============================================================================
;; END OF MODULE
;; ============================================================================
