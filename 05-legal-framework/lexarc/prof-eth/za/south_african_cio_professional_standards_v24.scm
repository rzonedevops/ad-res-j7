;;; South African CIO Professional Standards v24
;;; Industry benchmark comparison and technical necessity framework
;;; Date: 2025-12-05
;;; Case: 2025-137857 (Peter Faucitt v. Jacqueline & Daniel Faucitt)
;;; Repository: cogpy/ad-res-j7

(define-module (lex prof-eth za south-african-cio-professional-standards-v24)
  #:use-module (lex lv1 known-laws)
  #:use-module (lex lv1 legal-aspects-taxonomy-v17)
  #:use-module (srfi srfi-1)
  #:use-module (srfi srfi-9)
  #:export (
    ;; Core CIO professional standards functions v24
    assess-cio-professional-standards-v24
    compare-industry-benchmarks-v24
    evaluate-technical-necessity-v24
    calculate-investment-reasonableness-v24
    
    ;; Industry standard frameworks
    assess-sfia-compliance-v24
    assess-itil-compliance-v24
    assess-iso27001-compliance-v24
    assess-pci-dss-compliance-v24
    
    ;; Investment justification
    justify-it-infrastructure-investment-v24
    calculate-it-spending-ratio-v24
    compare-industry-it-spending-v24
    assess-investment-proportionality-v24
    
    ;; Technical necessity assessment
    assess-infrastructure-criticality-v24
    evaluate-security-requirements-v24
    assess-regulatory-compliance-necessity-v24
    evaluate-business-continuity-requirements-v24
  ))

;;;
;;; CIO PROFESSIONAL STANDARDS FRAMEWORK v24
;;;
;;; Key Components:
;;; 1. Industry standard compliance (SFIA, ITIL, ISO 27001, PCI-DSS)
;;; 2. Technical necessity assessment
;;; 3. Investment reasonableness evaluation
;;; 4. Industry benchmark comparison
;;; 5. Professional standards defensibility
;;;

;;; CIO professional standards record type
(define-record-type <cio-professional-standards-v24>
  (make-cio-professional-standards-v24-internal role-scope industry-benchmarks technical-necessity investment-comparison reasonableness-test defensibility-score)
  cio-professional-standards-v24?
  (role-scope cio-standards-v24-role-scope)
  (industry-benchmarks cio-standards-v24-industry-benchmarks)
  (technical-necessity cio-standards-v24-technical-necessity)
  (investment-comparison cio-standards-v24-investment-comparison)
  (reasonableness-test cio-standards-v24-reasonableness-test)
  (defensibility-score cio-standards-v24-defensibility-score))

;;; Industry benchmark frameworks
(define industry-benchmark-frameworks-v24
  '((sfia . "Skills Framework for the Information Age")
    (itil . "Information Technology Infrastructure Library")
    (iso27001 . "Information Security Management System")
    (pci-dss . "Payment Card Industry Data Security Standard")
    (cobit . "Control Objectives for Information and Related Technologies")
    (togaf . "The Open Group Architecture Framework")
    (nist . "National Institute of Standards and Technology Cybersecurity Framework")))

;;; CIO role scope components
(define cio-role-scope-components-v24
  '((it-infrastructure . "IT infrastructure planning, implementation, and management")
    (security . "Cybersecurity, data protection, and risk management")
    (compliance . "Regulatory compliance and audit management")
    (operations . "IT operations, service delivery, and support")
    (strategy . "IT strategy alignment with business objectives")
    (innovation . "Technology innovation and digital transformation")
    (governance . "IT governance, policies, and procedures")))

;;;
;;; CORE CIO PROFESSIONAL STANDARDS FUNCTIONS
;;;

(define (assess-cio-professional-standards-v24 cio-role investments industry-context)
  "Assess CIO professional standards compliance and investment defensibility"
  (let* ((role-scope (extract-role-scope-v24 cio-role))
         (industry-benchmarks (identify-applicable-benchmarks-v24 industry-context))
         (technical-necessity (evaluate-technical-necessity-v24 investments industry-context))
         (investment-comparison (compare-industry-benchmarks-v24 investments industry-context))
         (reasonableness (calculate-investment-reasonableness-v24 investments industry-context))
         (defensibility (calculate-defensibility-score-v24 technical-necessity investment-comparison reasonableness)))
    (make-cio-professional-standards-v24-internal
      role-scope
      industry-benchmarks
      technical-necessity
      investment-comparison
      reasonableness
      defensibility)))

(define (extract-role-scope-v24 cio-role)
  "Extract CIO role scope components"
  (filter (lambda (component)
            (member (car component) (cdr (assoc 'scope cio-role))))
          cio-role-scope-components-v24))

(define (identify-applicable-benchmarks-v24 industry-context)
  "Identify applicable industry benchmark frameworks"
  (let ((industry (cdr (assoc 'industry industry-context)))
        (compliance-requirements (cdr (assoc 'compliance-requirements industry-context))))
    (cond
      ((member 'eu-cosmetics compliance-requirements)
       '(sfia itil iso27001 pci-dss gdpr))
      ((member 'financial-services compliance-requirements)
       '(sfia itil iso27001 pci-dss cobit))
      ((member 'e-commerce compliance-requirements)
       '(sfia itil iso27001 pci-dss))
      (else
       '(sfia itil iso27001)))))

;;;
;;; INDUSTRY BENCHMARK COMPARISON
;;;

(define (compare-industry-benchmarks-v24 investments industry-context)
  "Compare investments against industry benchmarks"
  (let* ((total-investment (cdr (assoc 'total-investment investments)))
         (period-months (cdr (assoc 'period-months investments)))
         (monthly-average (/ total-investment period-months))
         (annual-revenue (cdr (assoc 'annual-revenue industry-context)))
         (it-spending-ratio (/ (* total-investment 12) (* annual-revenue period-months)))
         (industry-standard-ratio (get-industry-standard-it-spending-ratio-v24 industry-context))
         (comparison-result (compare-ratios-v24 it-spending-ratio industry-standard-ratio)))
    (make-industry-benchmark-comparison-v24
      total-investment
      period-months
      monthly-average
      it-spending-ratio
      industry-standard-ratio
      comparison-result)))

(define-record-type <industry-benchmark-comparison-v24>
  (make-industry-benchmark-comparison-v24 total-investment period-months monthly-average it-spending-ratio industry-standard-ratio comparison-result)
  industry-benchmark-comparison-v24?
  (total-investment benchmark-comparison-v24-total-investment)
  (period-months benchmark-comparison-v24-period-months)
  (monthly-average benchmark-comparison-v24-monthly-average)
  (it-spending-ratio benchmark-comparison-v24-it-spending-ratio)
  (industry-standard-ratio benchmark-comparison-v24-industry-standard-ratio)
  (comparison-result benchmark-comparison-v24-comparison-result))

(define (get-industry-standard-it-spending-ratio-v24 industry-context)
  "Get industry standard IT spending ratio as % of revenue"
  (let ((industry (cdr (assoc 'industry industry-context))))
    (cond
      ((eq? industry 'cosmetics-eu-compliance) 0.045) ; 4.5% for EU-compliant cosmetics
      ((eq? industry 'e-commerce) 0.050) ; 5.0% for e-commerce
      ((eq? industry 'financial-services) 0.070) ; 7.0% for financial services
      ((eq? industry 'manufacturing) 0.035) ; 3.5% for manufacturing
      (else 0.040)))) ; 4.0% default

(define (compare-ratios-v24 actual-ratio standard-ratio)
  "Compare actual IT spending ratio to industry standard"
  (let ((difference (- actual-ratio standard-ratio))
        (percentage-difference (/ (- actual-ratio standard-ratio) standard-ratio)))
    (cond
      ((< percentage-difference -0.20)
       (list 'below-standard "Significantly below industry standard" 0.70))
      ((< percentage-difference 0.00)
       (list 'below-standard "Below industry standard" 0.85))
      ((< percentage-difference 0.15)
       (list 'within-standard "Within industry standard range" 0.95))
      ((< percentage-difference 0.30)
       (list 'above-standard "Above industry standard (justifiable)" 0.85))
      (else
       (list 'significantly-above "Significantly above industry standard (requires justification)" 0.70)))))

;;;
;;; TECHNICAL NECESSITY ASSESSMENT
;;;

(define (evaluate-technical-necessity-v24 investments industry-context)
  "Evaluate technical necessity of IT investments"
  (let* ((infrastructure-criticality (assess-infrastructure-criticality-v24 investments))
         (security-requirements (evaluate-security-requirements-v24 investments industry-context))
         (regulatory-compliance (assess-regulatory-compliance-necessity-v24 investments industry-context))
         (business-continuity (evaluate-business-continuity-requirements-v24 investments))
         (necessity-score (calculate-necessity-score-v24
                           infrastructure-criticality
                           security-requirements
                           regulatory-compliance
                           business-continuity)))
    (make-technical-necessity-assessment-v24
      infrastructure-criticality
      security-requirements
      regulatory-compliance
      business-continuity
      necessity-score)))

(define-record-type <technical-necessity-assessment-v24>
  (make-technical-necessity-assessment-v24 infrastructure-criticality security-requirements regulatory-compliance business-continuity necessity-score)
  technical-necessity-assessment-v24?
  (infrastructure-criticality necessity-v24-infrastructure-criticality)
  (security-requirements necessity-v24-security-requirements)
  (regulatory-compliance necessity-v24-regulatory-compliance)
  (business-continuity necessity-v24-business-continuity)
  (necessity-score necessity-v24-necessity-score))

(define (assess-infrastructure-criticality-v24 investments)
  "Assess infrastructure criticality for business operations"
  (let ((infrastructure-components (cdr (assoc 'infrastructure-components investments))))
    (let ((critical-count (count (lambda (c) (eq? (cdr (assoc 'criticality c)) 'critical))
                                  infrastructure-components))
          (high-count (count (lambda (c) (eq? (cdr (assoc 'criticality c)) 'high))
                             infrastructure-components))
          (total-count (length infrastructure-components)))
      (make-criticality-assessment-v24
        critical-count
        high-count
        total-count
        (/ (+ (* critical-count 1.0) (* high-count 0.7)) total-count)))))

(define-record-type <criticality-assessment-v24>
  (make-criticality-assessment-v24 critical-count high-count total-count criticality-score)
  criticality-assessment-v24?
  (critical-count criticality-v24-critical-count)
  (high-count criticality-v24-high-count)
  (total-count criticality-v24-total-count)
  (criticality-score criticality-v24-criticality-score))

(define (evaluate-security-requirements-v24 investments industry-context)
  "Evaluate security requirements and compliance"
  (let ((security-frameworks (cdr (assoc 'security-frameworks investments)))
        (compliance-requirements (cdr (assoc 'compliance-requirements industry-context))))
    (let ((required-frameworks (filter (lambda (f)
                                         (member f compliance-requirements))
                                       security-frameworks))
          (implemented-frameworks (filter (lambda (f)
                                            (cdr (assoc 'implemented (assoc f investments))))
                                          security-frameworks)))
      (make-security-requirements-assessment-v24
        required-frameworks
        implemented-frameworks
        (/ (length implemented-frameworks) (max 1 (length required-frameworks)))))))

(define-record-type <security-requirements-assessment-v24>
  (make-security-requirements-assessment-v24 required-frameworks implemented-frameworks compliance-score)
  security-requirements-assessment-v24?
  (required-frameworks security-v24-required-frameworks)
  (implemented-frameworks security-v24-implemented-frameworks)
  (compliance-score security-v24-compliance-score))

(define (assess-regulatory-compliance-necessity-v24 investments industry-context)
  "Assess regulatory compliance necessity for IT investments"
  (let ((compliance-requirements (cdr (assoc 'compliance-requirements industry-context)))
        (compliance-investments (cdr (assoc 'compliance-investments investments))))
    (let ((total-compliance-cost (apply + (map cdr compliance-investments)))
          (total-investment (cdr (assoc 'total-investment investments)))
          (compliance-ratio (/ total-compliance-cost total-investment)))
      (make-regulatory-compliance-assessment-v24
        compliance-requirements
        compliance-investments
        total-compliance-cost
        compliance-ratio
        (assess-compliance-necessity-score-v24 compliance-requirements compliance-ratio)))))

(define-record-type <regulatory-compliance-assessment-v24>
  (make-regulatory-compliance-assessment-v24 requirements investments total-cost compliance-ratio necessity-score)
  regulatory-compliance-assessment-v24?
  (requirements compliance-v24-requirements)
  (investments compliance-v24-investments)
  (total-cost compliance-v24-total-cost)
  (compliance-ratio compliance-v24-compliance-ratio)
  (necessity-score compliance-v24-necessity-score))

(define (assess-compliance-necessity-score-v24 requirements compliance-ratio)
  "Assess necessity score for regulatory compliance investments"
  (let ((requirement-count (length requirements))
        (high-risk-count (count (lambda (r) (member r '(eu-cosmetics gdpr pci-dss))) requirements)))
    (cond
      ((and (> requirement-count 3) (> high-risk-count 2) (> compliance-ratio 0.30))
       0.95) ; High necessity: multiple high-risk requirements, substantial compliance investment
      ((and (> requirement-count 2) (> high-risk-count 1) (> compliance-ratio 0.20))
       0.85) ; Moderate-high necessity
      ((and (> requirement-count 1) (> compliance-ratio 0.10))
       0.75) ; Moderate necessity
      (else
       0.60)))) ; Low-moderate necessity

(define (evaluate-business-continuity-requirements-v24 investments)
  "Evaluate business continuity and disaster recovery requirements"
  (let ((bc-dr-investments (cdr (assoc 'business-continuity-investments investments)))
        (total-investment (cdr (assoc 'total-investment investments))))
    (let ((bc-dr-ratio (/ (apply + (map cdr bc-dr-investments)) total-investment)))
      (make-business-continuity-assessment-v24
        bc-dr-investments
        bc-dr-ratio
        (assess-bc-dr-necessity-score-v24 bc-dr-ratio)))))

(define-record-type <business-continuity-assessment-v24>
  (make-business-continuity-assessment-v24 investments bc-dr-ratio necessity-score)
  business-continuity-assessment-v24?
  (investments bc-dr-v24-investments)
  (bc-dr-ratio bc-dr-v24-bc-dr-ratio)
  (necessity-score bc-dr-v24-necessity-score))

(define (assess-bc-dr-necessity-score-v24 bc-dr-ratio)
  "Assess necessity score for business continuity investments"
  (cond
    ((> bc-dr-ratio 0.20) 0.95) ; High necessity: substantial BC/DR investment
    ((> bc-dr-ratio 0.10) 0.85) ; Moderate-high necessity
    ((> bc-dr-ratio 0.05) 0.75) ; Moderate necessity
    (else 0.60))) ; Low-moderate necessity

(define (calculate-necessity-score-v24 infrastructure security compliance bc-dr)
  "Calculate overall technical necessity score"
  (let ((infra-score (criticality-v24-criticality-score infrastructure))
        (security-score (security-v24-compliance-score security))
        (compliance-score (compliance-v24-necessity-score compliance))
        (bc-dr-score (bc-dr-v24-necessity-score bc-dr)))
    (/ (+ (* infra-score 0.30)
          (* security-score 0.25)
          (* compliance-score 0.30)
          (* bc-dr-score 0.15))
       1.0)))

;;;
;;; INVESTMENT REASONABLENESS CALCULATION
;;;

(define (calculate-investment-reasonableness-v24 investments industry-context)
  "Calculate investment reasonableness score"
  (let* ((benchmark-comparison (compare-industry-benchmarks-v24 investments industry-context))
         (technical-necessity (evaluate-technical-necessity-v24 investments industry-context))
         (proportionality (assess-investment-proportionality-v24 investments industry-context))
         (reasonableness-score (calculate-reasonableness-score-v24
                                benchmark-comparison
                                technical-necessity
                                proportionality)))
    (make-investment-reasonableness-v24
      benchmark-comparison
      technical-necessity
      proportionality
      reasonableness-score)))

(define-record-type <investment-reasonableness-v24>
  (make-investment-reasonableness-v24 benchmark-comparison technical-necessity proportionality reasonableness-score)
  investment-reasonableness-v24?
  (benchmark-comparison reasonableness-v24-benchmark-comparison)
  (technical-necessity reasonableness-v24-technical-necessity)
  (proportionality reasonableness-v24-proportionality)
  (reasonableness-score reasonableness-v24-reasonableness-score))

(define (assess-investment-proportionality-v24 investments industry-context)
  "Assess investment proportionality to company size and complexity"
  (let ((total-investment (cdr (assoc 'total-investment investments)))
        (annual-revenue (cdr (assoc 'annual-revenue industry-context)))
        (employee-count (cdr (assoc 'employee-count industry-context)))
        (jurisdiction-count (cdr (assoc 'jurisdiction-count industry-context))))
    (let ((revenue-ratio (/ total-investment annual-revenue))
          (per-employee-investment (/ total-investment employee-count))
          (per-jurisdiction-investment (/ total-investment jurisdiction-count)))
      (make-proportionality-assessment-v24
        revenue-ratio
        per-employee-investment
        per-jurisdiction-investment
        (calculate-proportionality-score-v24 revenue-ratio per-employee-investment per-jurisdiction-investment)))))

(define-record-type <proportionality-assessment-v24>
  (make-proportionality-assessment-v24 revenue-ratio per-employee-investment per-jurisdiction-investment proportionality-score)
  proportionality-assessment-v24?
  (revenue-ratio proportionality-v24-revenue-ratio)
  (per-employee-investment proportionality-v24-per-employee-investment)
  (per-jurisdiction-investment proportionality-v24-per-jurisdiction-investment)
  (proportionality-score proportionality-v24-proportionality-score))

(define (calculate-proportionality-score-v24 revenue-ratio per-employee per-jurisdiction)
  "Calculate proportionality score based on company metrics"
  (let ((revenue-score (cond
                        ((< revenue-ratio 0.03) 0.95) ; < 3% of revenue: highly proportional
                        ((< revenue-ratio 0.05) 0.90) ; 3-5% of revenue: proportional
                        ((< revenue-ratio 0.08) 0.80) ; 5-8% of revenue: moderately proportional
                        (else 0.70))) ; > 8% of revenue: requires justification
        (employee-score (cond
                         ((< per-employee 50000) 0.90) ; < R50K per employee: reasonable
                         ((< per-employee 100000) 0.85) ; R50-100K per employee: moderate
                         (else 0.75))) ; > R100K per employee: high
        (jurisdiction-score (cond
                             ((< per-jurisdiction 200000) 0.85) ; < R200K per jurisdiction: reasonable
                             ((< per-jurisdiction 400000) 0.80) ; R200-400K per jurisdiction: moderate
                             (else 0.75)))) ; > R400K per jurisdiction: high
    (/ (+ (* revenue-score 0.50)
          (* employee-score 0.25)
          (* jurisdiction-score 0.25))
       1.0)))

(define (calculate-reasonableness-score-v24 benchmark-comparison technical-necessity proportionality)
  "Calculate overall investment reasonableness score"
  (let ((benchmark-score (caddr (benchmark-comparison-v24-comparison-result benchmark-comparison)))
        (necessity-score (necessity-v24-necessity-score technical-necessity))
        (proportionality-score (proportionality-v24-proportionality-score proportionality)))
    (/ (+ (* benchmark-score 0.35)
          (* necessity-score 0.40)
          (* proportionality-score 0.25))
       1.0)))

;;;
;;; DEFENSIBILITY SCORE CALCULATION
;;;

(define (calculate-defensibility-score-v24 technical-necessity investment-comparison reasonableness)
  "Calculate overall CIO professional standards defensibility score"
  (let ((necessity-score (necessity-v24-necessity-score technical-necessity))
        (benchmark-score (caddr (benchmark-comparison-v24-comparison-result investment-comparison)))
        (reasonableness-score (reasonableness-v24-reasonableness-score reasonableness)))
    (let ((aggregate-score (/ (+ (* necessity-score 0.40)
                                 (* benchmark-score 0.30)
                                 (* reasonableness-score 0.30))
                              1.0)))
      (make-defensibility-assessment-v24
        necessity-score
        benchmark-score
        reasonableness-score
        aggregate-score
        (determine-defensibility-level-v24 aggregate-score)))))

(define-record-type <defensibility-assessment-v24>
  (make-defensibility-assessment-v24 necessity-score benchmark-score reasonableness-score aggregate-score defensibility-level)
  defensibility-assessment-v24?
  (necessity-score defensibility-v24-necessity-score)
  (benchmark-score defensibility-v24-benchmark-score)
  (reasonableness-score defensibility-v24-reasonableness-score)
  (aggregate-score defensibility-v24-aggregate-score)
  (defensibility-level defensibility-v24-defensibility-level))

(define (determine-defensibility-level-v24 aggregate-score)
  "Determine defensibility level based on aggregate score"
  (cond
    ((>= aggregate-score 0.90)
     (list 'highly-defensible "Investments highly defensible under CIO professional standards" 0.95))
    ((>= aggregate-score 0.80)
     (list 'defensible "Investments defensible under CIO professional standards" 0.90))
    ((>= aggregate-score 0.70)
     (list 'moderately-defensible "Investments moderately defensible, may require additional justification" 0.80))
    (else
     (list 'requires-justification "Investments require substantial justification" 0.70))))

;;;
;;; CASE-SPECIFIC ANALYSIS (2025-137857: Dan's IT Investments)
;;;

;;; Dan's IT investment profile
(define dan-it-investment-profile-v24
  '((total-investment . 8850000) ; R8.85M
    (period-months . 18)
    (infrastructure-components .
      (((component . "EU compliance systems") (criticality . critical) (cost . 3200000))
       ((component . "Cybersecurity infrastructure") (criticality . critical) (cost . 2400000))
       ((component . "E-commerce platform") (criticality . critical) (cost . 1800000))
       ((component . "Business continuity/DR") (criticality . high) (cost . 1450000))))
    (security-frameworks . (iso27001 pci-dss gdpr popia))
    (compliance-investments .
      ((eu-cosmetics . 3200000)
       (gdpr . 1200000)
       (pci-dss . 800000)
       (popia . 400000)))
    (business-continuity-investments .
      ((disaster-recovery . 900000)
       (backup-systems . 350000)
       (redundancy . 200000)))))

;;; RegimA industry context
(define regima-industry-context-v24
  '((industry . cosmetics-eu-compliance)
    (annual-revenue . 180000000) ; R180M estimated annual revenue
    (employee-count . 150)
    (jurisdiction-count . 37) ; 37 EU jurisdictions
    (compliance-requirements . (eu-cosmetics gdpr pci-dss popia iso27001))))

;;; Dan's CIO professional standards assessment
(define dan-cio-professional-standards-assessment-v24
  (assess-cio-professional-standards-v24
    '((role . cio)
      (scope . (it-infrastructure security compliance operations)))
    dan-it-investment-profile-v24
    regima-industry-context-v24))

;;; Export case-specific analyses
(export
  dan-it-investment-profile-v24
  regima-industry-context-v24
  dan-cio-professional-standards-assessment-v24)
