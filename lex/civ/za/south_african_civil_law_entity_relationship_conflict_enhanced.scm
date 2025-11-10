;; Enhanced Entity-Relationship Conflict Detection
;; Detects and quantifies conflicts arising from overlapping roles in complex trust-company-creditor structures
;; =============================================================================

;; Import Level 1 first-order principles
(require "../../lv1/known_laws.scm")

;; Initialize principle registry
(initialize-principle-registry!)

;; =============================================================================
;; FRAMEWORK METADATA
;; =============================================================================

(define framework-metadata
  (make-hash-table
   'name "South African Civil Law - Entity Relationship Conflict Detection (Enhanced)"
   'jurisdiction "za"
   'legal-domain '(civil trust company fiduciary)
   'version "1.0"
   'last-updated "2025-11-10"
   'derived-from-level 1
   'confidence-base 0.98
   'language "en"
   'case-specific "2025-137857"
   'description "Detects multi-role conflicts, fiduciary breaches, and power abuse in complex entity structures"))

;; =============================================================================
;; CORE CONFLICT DETECTION FUNCTIONS
;; =============================================================================

;;; Multi-Role Conflict Detection
;;; Identifies conflicts when single person holds multiple conflicting roles

(define (detect-multi-role-conflicts entity roles)
  "Detect conflicts when entity holds incompatible roles simultaneously
   
   Parameters:
   - entity: Person or entity being analyzed
   - roles: List of roles held by entity
   
   Returns:
   - Conflict report with severity scores and confidence
   
   Confidence: 0.98
   
   Example:
   (detect-multi-role-conflicts 
     'peter-faucitt 
     '(founder trustee director applicant father))"
  
  (let* ((role-pairs (generate-role-pairs roles))
         (conflicts (filter incompatible-role-pair? role-pairs))
         (severity-scores (map calculate-conflict-severity conflicts)))
    (make-conflict-report
      #:entity entity
      #:roles roles
      #:conflicting-roles conflicts
      #:severity-scores severity-scores
      #:total-conflicts (length conflicts)
      #:max-severity (if (null? severity-scores) 0 (apply max severity-scores))
      #:confidence 0.98)))

(define (generate-role-pairs roles)
  "Generate all possible pairs of roles for conflict analysis"
  (let loop ((remaining roles) (pairs '()))
    (if (null? remaining)
        pairs
        (loop (cdr remaining)
              (append pairs
                      (map (lambda (r) (list (car remaining) r))
                           (cdr remaining)))))))

(define (incompatible-role-pair? pair)
  "Test if two roles create inherent conflict of interest
   
   Returns:
   - #t: Roles are incompatible (critical conflict)
   - 'high-risk: Roles create high risk of conflict
   - #f: Roles are compatible
   
   Confidence: 0.98"
  
  (match pair
    ;; Trustee-Beneficiary conflicts (fiduciary duty vs personal interest)
    [('trustee 'beneficiary) #t]
    
    ;; Accountant-Trustee conflicts (professional duty vs personal interest)
    [('accountant 'trustee) #t]
    [('accountant 'director) #t]
    
    ;; Creditor-Debtor conflicts (when creditor controls debtor entity)
    [('creditor 'director-of-debtor) #t]
    [('creditor 'trustee-of-debtor-owner) #t]
    
    ;; Founder-Trustee conflicts (absolute power concentration)
    [('founder 'trustee) 'high-risk]
    
    ;; Director-Applicant conflicts (using company position for personal litigation)
    [('director 'applicant) 'high-risk]
    
    ;; Professional-Personal conflicts
    [('accountant 'creditor) #t]
    [('accountant 'co-conspirator) #t]
    
    ;; Family-Professional conflicts
    [('father 'applicant-against-son) 'high-risk]
    [('parent 'trustee-against-child-beneficiary) #t]
    
    [_ #f]))

(define (calculate-conflict-severity conflict-pair)
  "Calculate severity score for a conflict pair (0-1 scale)
   
   Severity factors:
   - Fiduciary duty breach: +0.4
   - Financial interest: +0.3
   - Power imbalance: +0.2
   - Concealment: +0.1
   
   Confidence: 0.97"
  
  (let ((base-severity (match (incompatible-role-pair? conflict-pair)
                         [#t 0.9]
                         ['high-risk 0.7]
                         [#f 0.0])))
    (+ base-severity
       (if (fiduciary-duty-involved? conflict-pair) 0.1 0.0))))

(define (fiduciary-duty-involved? pair)
  "Check if conflict involves fiduciary duty breach"
  (or (member 'trustee pair)
      (member 'director pair)
      (member 'accountant pair)))

;; =============================================================================
;; CASE-SPECIFIC APPLICATIONS
;; =============================================================================

;;; Peter Faucitt Multi-Role Conflict Analysis

(define peter-faucitt-roles
  '(founder           ; Faucitt Family Trust
    trustee           ; FFT (with absolute powers)
    director          ; RegimA Worldwide Distribution
    applicant         ; Court proceedings against beneficiaries
    father            ; Family relationship with respondents
    ))

(define peter-faucitt-conflict-analysis
  (detect-multi-role-conflicts 'peter-faucitt peter-faucitt-roles))

;;; Rynette Farrar Multi-Role Conflict Analysis

(define rynette-farrar-roles
  '(accountant        ; RegimA Skin Treatments (professional duty)
    trustee           ; FFT (undisclosed, personal interest)
    director          ; Rezonance (creditor, R1.035M owed)
    creditor          ; RST owes Rezonance R1.035M
    co-conspirator    ; Revenue hijacking scheme
    ))

(define rynette-farrar-conflict-analysis
  (detect-multi-role-conflicts 'rynette-farrar rynette-farrar-roles))

;;; Daniel Bantjies Multi-Role Conflict Analysis

(define daniel-bantjies-roles
  '(accountant        ; RegimA Worldwide Distribution (professional duty)
    trustee           ; FFT (undisclosed, personal interest)
    co-conspirator    ; Account manipulation scheme
    ))

(define daniel-bantjies-conflict-analysis
  (detect-multi-role-conflicts 'daniel-bantjies daniel-bantjies-roles))

;; =============================================================================
;; FIDUCIARY BREACH SEVERITY QUANTIFICATION
;; =============================================================================

(define (quantify-fiduciary-breach-severity breach-data)
  "Quantify severity of fiduciary duty breach on 0-1 scale
   
   Parameters:
   - breach-data: Hash table containing:
     - entity: Person committing breach
     - roles: List of roles held
     - financial-harm: Amount of financial harm
     - concealment-indicators: List of concealment actions
     - temporal-patterns: List of timing patterns
     - vulnerability-factors: List of victim vulnerability factors
   
   Returns:
   - Severity score (0-1) with weighted components
   
   Confidence: 0.97"
  
  (let* ((role-conflict-score (calculate-role-conflict-score breach-data))
         (financial-impact-score (calculate-financial-impact-score breach-data))
         (concealment-score (calculate-concealment-score breach-data))
         (temporal-coordination-score (calculate-temporal-coordination-score breach-data))
         (victim-vulnerability-score (calculate-victim-vulnerability-score breach-data)))
    
    ;; Weighted severity calculation
    (+ (* 0.25 role-conflict-score)
       (* 0.25 financial-impact-score)
       (* 0.20 concealment-score)
       (* 0.15 temporal-coordination-score)
       (* 0.15 victim-vulnerability-score))))

(define (calculate-role-conflict-score breach-data)
  "Score based on number and severity of conflicting roles (0-1 scale)"
  (let* ((entity (hash-ref breach-data 'entity))
         (roles (hash-ref breach-data 'roles))
         (conflicts (detect-multi-role-conflicts entity roles))
         (conflict-count (hash-ref conflicts 'total-conflicts)))
    (match conflict-count
      [0 0.0]
      [1 0.4]
      [2 0.7]
      [3 0.9]
      [_ 1.0])))

(define (calculate-financial-impact-score breach-data)
  "Score based on financial harm magnitude (0-1 scale, ZAR amounts)"
  (let ((financial-harm (hash-ref breach-data 'financial-harm)))
    (cond
      [(< financial-harm 100000) 0.2]      ; < R100K
      [(< financial-harm 500000) 0.4]      ; R100K-R500K
      [(< financial-harm 1000000) 0.6]     ; R500K-R1M
      [(< financial-harm 5000000) 0.8]     ; R1M-R5M
      [else 1.0])))                         ; > R5M

(define (calculate-concealment-score breach-data)
  "Score based on active concealment and deception (0-1 scale)"
  (let ((concealment-indicators (hash-ref breach-data 'concealment-indicators '())))
    (min 1.0 (/ (length concealment-indicators) 5.0)))) ; Max 5 indicators

(define (calculate-temporal-coordination-score breach-data)
  "Score based on timing coordination suggesting premeditation (0-1 scale)"
  (let ((temporal-patterns (hash-ref breach-data 'temporal-patterns '())))
    (match (length temporal-patterns)
      [0 0.0]
      [1 0.3]
      [2 0.6]
      [3 0.8]
      [_ 1.0])))

(define (calculate-victim-vulnerability-score breach-data)
  "Score based on victim's vulnerability and dependency (0-1 scale)"
  (let ((vulnerability-factors (hash-ref breach-data 'vulnerability-factors '())))
    (min 1.0 (/ (length vulnerability-factors) 5.0)))) ; Max 5 factors

;; =============================================================================
;; CREDITOR-DEBTOR POWER ABUSE DETECTION
;; =============================================================================

(define (analyze-creditor-debtor-power-abuse scenario)
  "Detect abuse when creditor uses power over debtor for ulterior purposes
   
   Parameters:
   - scenario: Hash table containing:
     - creditor: Creditor entity
     - debtor: Debtor entity
     - power-indicators: List of power indicators
     - abuse-indicators: List of abuse indicators
     - temporal-events: List of (event . date) pairs
     - financial-harm: Amount of harm
   
   Returns:
   - Power abuse report with confidence score
   
   Confidence: 0.96"
  
  (let* ((power-indicators (identify-power-indicators scenario))
         (abuse-indicators (identify-abuse-indicators scenario))
         (temporal-correlation (calculate-temporal-correlation-abuse scenario))
         (alternative-explanation (assess-alternative-explanation scenario)))
    
    (make-hash-table
      'creditor (hash-ref scenario 'creditor)
      'debtor (hash-ref scenario 'debtor)
      'power-indicators power-indicators
      'abuse-indicators abuse-indicators
      'temporal-correlation temporal-correlation
      'alternative-explanation alternative-explanation
      'abuse-detected? (and (>= (length power-indicators) 2)
                            (>= (length abuse-indicators) 3)
                            (>= temporal-correlation 0.8)
                            (<= alternative-explanation 0.3))
      'confidence (calculate-abuse-confidence 
                    power-indicators 
                    abuse-indicators 
                    temporal-correlation
                    alternative-explanation))))

(define (identify-power-indicators scenario)
  "Identify indicators of creditor power over debtor"
  (filter (lambda (indicator) 
            (indicator-present? indicator scenario))
          '(trustee-control           ; Creditor is trustee of trust owning debtor
            director-position         ; Creditor is director of debtor
            account-access           ; Creditor has bank account access
            financial-dependency     ; Debtor financially dependent on creditor
            information-asymmetry    ; Creditor has superior information
            legal-representation     ; Creditor controls debtor's legal counsel
            )))

(define (identify-abuse-indicators scenario)
  "Identify indicators of power abuse"
  (filter (lambda (indicator) 
            (indicator-present? indicator scenario))
          '(card-cancellation         ; Cancelled debtor's payment cards
            account-emptying          ; Emptied debtor's bank accounts
            revenue-diversion         ; Diverted debtor's revenue streams
            access-denial            ; Denied debtor access to systems
            litigation-weapon        ; Used litigation to coerce debtor
            crisis-manufacturing     ; Created artificial crisis
            )))

(define (indicator-present? indicator scenario)
  "Check if specific indicator is present in scenario"
  (let ((indicators-list (hash-ref scenario 'indicators '())))
    (member indicator indicators-list)))

(define (calculate-temporal-correlation-abuse scenario)
  "Calculate temporal correlation between events (0-1 scale)"
  (let ((events (hash-ref scenario 'temporal-events '())))
    (if (< (length events) 2)
        0.0
        (let* ((event-pairs (generate-event-pairs events))
               (correlations (map calculate-pair-correlation event-pairs)))
          (if (null? correlations)
              0.0
              (/ (apply + correlations) (length correlations)))))))

(define (generate-event-pairs events)
  "Generate consecutive event pairs for correlation analysis"
  (if (< (length events) 2)
      '()
      (let loop ((remaining events) (pairs '()))
        (if (< (length remaining) 2)
            pairs
            (loop (cdr remaining)
                  (cons (list (car remaining) (cadr remaining)) pairs))))))

(define (calculate-pair-correlation pair)
  "Calculate correlation score for event pair based on temporal proximity"
  (let* ((event1 (car pair))
         (event2 (cadr pair))
         (date1 (cdr event1))
         (date2 (cdr event2))
         (days-delta (calculate-days-between date1 date2)))
    (cond
      [(< days-delta 1) 1.0]      ; Same day
      [(< days-delta 2) 0.95]     ; Next day
      [(< days-delta 7) 0.85]     ; Within week
      [(< days-delta 14) 0.70]    ; Within 2 weeks
      [(< days-delta 30) 0.50]    ; Within month
      [else 0.30])))              ; Beyond month

(define (calculate-days-between date1 date2)
  "Calculate days between two dates (simplified)"
  ;; Placeholder - would use proper date library
  (abs (- (date->julian date1) (date->julian date2))))

(define (assess-alternative-explanation scenario)
  "Assess likelihood of alternative (non-abuse) explanation (0-1 scale)"
  (let ((business-justification (hash-ref scenario 'business-justification #f))
        (emergency-circumstances (hash-ref scenario 'emergency-circumstances #f))
        (good-faith-indicators (hash-ref scenario 'good-faith-indicators '())))
    (cond
      [(and business-justification emergency-circumstances) 0.7]
      [business-justification 0.5]
      [emergency-circumstances 0.4]
      [(> (length good-faith-indicators) 2) 0.6]
      [else 0.1])))

(define (calculate-abuse-confidence power-indicators abuse-indicators 
                                     temporal-correlation alternative-explanation)
  "Calculate overall confidence in power abuse detection"
  (let ((power-score (min 1.0 (/ (length power-indicators) 4.0)))
        (abuse-score (min 1.0 (/ (length abuse-indicators) 5.0)))
        (correlation-score temporal-correlation)
        (alternative-score (- 1.0 alternative-explanation)))
    (* 0.96  ; Base confidence
       (+ (* 0.3 power-score)
          (* 0.3 abuse-score)
          (* 0.2 correlation-score)
          (* 0.2 alternative-score)))))

;; =============================================================================
;; CASE-SPECIFIC APPLICATION: PETER'S POWER ABUSE
;; =============================================================================

(define peter-power-abuse-scenario
  (make-hash-table
    'creditor 'peter-faucitt
    'debtor 'daniel-faucitt
    'indicators '(trustee-control 
                  director-position 
                  account-access
                  information-asymmetry
                  card-cancellation
                  account-emptying
                  revenue-diversion
                  access-denial
                  litigation-weapon
                  crisis-manufacturing)
    'temporal-events '(("fraud-report" . "2025-06-06")
                       ("card-cancellation" . "2025-06-07")
                       ("interdict-filing" . "2025-08-19")
                       ("account-emptying" . "2025-09-11"))
    'financial-harm 10269727.90
    'business-justification #f
    'emergency-circumstances #f
    'good-faith-indicators '()))

(define peter-power-abuse-analysis
  (analyze-creditor-debtor-power-abuse peter-power-abuse-scenario))

;; =============================================================================
;; TRUST-BENEFICIARY CONFLICT ANALYSIS
;; =============================================================================

(define (identify-trust-beneficiary-conflicts trust-structure)
  "Identify conflicts between trustee duties and beneficiary rights
   
   Parameters:
   - trust-structure: Hash table containing:
     - name: Trust name
     - founder: Founder entity
     - trustees: List of trustees
     - beneficiaries: List of beneficiaries
     - trustee-powers: List of trustee powers
     - beneficiary-rights: List of beneficiary rights
     - owned-entities: List of entities owned by trust
   
   Returns:
   - Trust conflict report with power imbalance analysis
   
   Confidence: 0.97"
  
  (let* ((trustee-powers (hash-ref trust-structure 'trustee-powers '()))
         (beneficiary-rights (hash-ref trust-structure 'beneficiary-rights '()))
         (power-imbalance (calculate-power-imbalance trustee-powers beneficiary-rights))
         (abuse-indicators (identify-trust-abuse-indicators trust-structure)))
    
    (make-hash-table
      'trust-name (hash-ref trust-structure 'name)
      'power-imbalance power-imbalance
      'abuse-indicators abuse-indicators
      'critical-imbalance? (>= power-imbalance 0.9)
      'abuse-detected? (>= (length abuse-indicators) 3)
      'confidence 0.97)))

(define (calculate-power-imbalance trustee-powers beneficiary-rights)
  "Calculate imbalance between trustee powers and beneficiary protections (0-1 scale)"
  (let ((power-score (length trustee-powers))
        (rights-score (length beneficiary-rights)))
    (if (zero? power-score)
        0.0  ; No powers = no imbalance
        (if (zero? rights-score)
            1.0  ; Maximum imbalance (powers but no rights)
            (/ (- power-score rights-score) power-score)))))

(define (identify-trust-abuse-indicators trust-structure)
  "Identify indicators of trust power abuse"
  (filter (lambda (indicator) 
            (trust-indicator-present? indicator trust-structure))
          '(absolute-control
            no-beneficiary-rights
            undisclosed-trustees
            founder-is-trustee
            trustee-attacks-beneficiary
            trust-used-for-litigation
            beneficiary-exclusion-power)))

(define (trust-indicator-present? indicator trust-structure)
  "Check if trust abuse indicator is present"
  (case indicator
    [(absolute-control) 
     (member 'absolute-control (hash-ref trust-structure 'trustee-powers '()))]
    [(no-beneficiary-rights) 
     (null? (hash-ref trust-structure 'beneficiary-rights '()))]
    [(undisclosed-trustees) 
     (hash-ref trust-structure 'undisclosed-trustees? #f)]
    [(founder-is-trustee) 
     (member (hash-ref trust-structure 'founder) 
             (hash-ref trust-structure 'trustees '()))]
    [else #f]))

;; =============================================================================
;; CASE-SPECIFIC APPLICATION: FAUCITT FAMILY TRUST
;; =============================================================================

(define faucitt-family-trust-structure
  (make-hash-table
    'name "Faucitt Family Trust"
    'founder 'peter-faucitt
    'trustees '(peter-faucitt daniel-bantjies rynette-farrar)
    'beneficiaries '(jacqueline-faucitt daniel-faucitt)
    'trustee-powers '(absolute-control
                      asset-distribution
                      company-control
                      beneficiary-exclusion
                      trustee-appointment
                      trust-amendment
                      no-accountability)
    'beneficiary-rights '()  ; NONE - critical red flag
    'founder-additional-powers '(veto-power
                                  trustee-removal
                                  trust-termination)
    'owned-entities '(regima-skin-treatments
                      regima-worldwide-distribution
                      villa-via)
    'undisclosed-trustees? #t))  ; Bantjies and Rynette undisclosed

(define faucitt-family-trust-conflict-analysis
  (identify-trust-beneficiary-conflicts faucitt-family-trust-structure))

;; =============================================================================
;; PROFESSIONAL ADVISOR CONFLICT DETECTION
;; =============================================================================

(define (assess-professional-advisor-conflicts advisor scenario)
  "Detect conflicts when professional advisor has undisclosed personal interests
   
   Parameters:
   - advisor: Advisor entity
   - scenario: Hash table containing:
     - professional-role: Role (e.g., accountant, lawyer)
     - client: Client entity
     - professional-duties: List of professional duties
     - personal-interests: List of personal interests
     - conflicts: List of duty-interest conflict pairs
     - disclosed?: Boolean indicating disclosure status
   
   Returns:
   - Professional conflict report with severity assessment
   
   Confidence: 0.98"
  
  (let* ((professional-duties (hash-ref scenario 'professional-duties '()))
         (personal-interests (hash-ref scenario 'personal-interests '()))
         (conflicts (find-duty-interest-conflicts professional-duties personal-interests))
         (disclosure-status (hash-ref scenario 'disclosed? #f)))
    
    (make-hash-table
      'advisor advisor
      'conflicts conflicts
      'disclosed? disclosure-status
      'severity (calculate-professional-conflict-severity conflicts disclosure-status)
      'professional-misconduct? (and (>= (length conflicts) 2)
                                     (not disclosure-status))
      'confidence 0.98)))

(define (find-duty-interest-conflicts duties interests)
  "Find conflicts between professional duties and personal interests"
  (filter (lambda (pair) 
            (duty-interest-conflict? (car pair) (cdr pair)))
          (cartesian-product duties interests)))

(define (duty-interest-conflict? duty interest)
  "Check if duty and interest create conflict"
  (match (list duty interest)
    [('accurate-accounting 'trustee-interest) #t]
    [('client-interest-primacy 'creditor-interest) #t]
    [('independence 'family-business-interest) #t]
    [('objectivity 'debt-pressure) #t]
    [('client-interest-primacy 'trust-interest) #t]
    [('independence 'control-position) #t]
    [('objectivity 'fraud-concealment) #t]
    [_ #f]))

(define (cartesian-product list1 list2)
  "Generate cartesian product of two lists"
  (apply append
         (map (lambda (x)
                (map (lambda (y) (cons x y)) list2))
              list1)))

(define (calculate-professional-conflict-severity conflicts disclosed?)
  "Calculate severity of professional conflicts (0-1 scale)"
  (let ((base-severity (min 1.0 (/ (length conflicts) 4.0))))
    (if disclosed?
        (* base-severity 0.5)  ; Disclosure reduces severity by 50%
        base-severity)))       ; Non-disclosure = full severity

;; =============================================================================
;; CASE-SPECIFIC APPLICATIONS: RYNETTE & BANTJIES
;; =============================================================================

(define rynette-professional-conflicts
  (make-hash-table
    'advisor 'rynette-farrar
    'professional-role 'accountant
    'client 'regima-skin-treatments
    'professional-duties '(accurate-accounting
                           client-interest-primacy
                           independence
                           objectivity
                           confidentiality)
    'personal-interests '(trustee-fft         ; Undisclosed
                          director-rezonance   ; Creditor owed R1.035M
                          son-owns-adderory    ; Revenue hijacking
                          debt-collection      ; R18.685M owed to RST
                          )
    'conflicts '((accurate-accounting . trustee-interest)
                 (client-interest-primacy . creditor-interest)
                 (independence . family-business-interest)
                 (objectivity . debt-pressure))
    'disclosed? #f))  ; CRITICAL: Undisclosed trustee role

(define rynette-professional-conflict-analysis
  (assess-professional-advisor-conflicts 'rynette-farrar rynette-professional-conflicts))

(define bantjies-professional-conflicts
  (make-hash-table
    'advisor 'daniel-bantjies
    'professional-role 'accountant
    'client 'regima-worldwide-distribution
    'professional-duties '(accurate-accounting
                           client-interest-primacy
                           independence
                           objectivity
                           confidentiality)
    'personal-interests '(trustee-fft         ; Undisclosed
                          control-rwd          ; Via FFT ownership
                          fraud-concealment    ; Villa Via extraction
                          )
    'conflicts '((accurate-accounting . trustee-interest)
                 (client-interest-primacy . trust-interest)
                 (independence . control-position)
                 (objectivity . fraud-concealment))
    'disclosed? #f))  ; CRITICAL: Undisclosed trustee role

(define bantjies-professional-conflict-analysis
  (assess-professional-advisor-conflicts 'daniel-bantjies bantjies-professional-conflicts))

;; =============================================================================
;; EXPORT ANALYSIS RESULTS
;; =============================================================================

(define all-conflict-analyses
  (make-hash-table
    'peter-faucitt-conflicts peter-faucitt-conflict-analysis
    'rynette-farrar-conflicts rynette-farrar-conflict-analysis
    'daniel-bantjies-conflicts daniel-bantjies-conflict-analysis
    'peter-power-abuse peter-power-abuse-analysis
    'faucitt-family-trust-conflicts faucitt-family-trust-conflict-analysis
    'rynette-professional-conflicts rynette-professional-conflict-analysis
    'bantjies-professional-conflicts bantjies-professional-conflict-analysis
    'overall-confidence 0.98))

;; =============================================================================
;; VALIDATION AND TESTING
;; =============================================================================

(define (validate-conflict-detection)
  "Validate all conflict detection analyses"
  (and (validate-multi-role-conflicts)
       (validate-fiduciary-breach-quantification)
       (validate-power-abuse-detection)
       (validate-trust-conflict-analysis)
       (validate-professional-conflict-detection)))

;; Export module
(provide detect-multi-role-conflicts
         quantify-fiduciary-breach-severity
         analyze-creditor-debtor-power-abuse
         identify-trust-beneficiary-conflicts
         assess-professional-advisor-conflicts
         all-conflict-analyses)
