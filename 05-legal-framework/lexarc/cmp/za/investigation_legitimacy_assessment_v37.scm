;; investigation_legitimacy_assessment_v37.scm
;; South African Company Law - Investigation Legitimacy Assessment Framework V37
;; Case: 2025-137857 (Peter Faucitt v. Jacqueline & Daniel Faucitt)
;; Purpose: Evaluate investigation methodology and forensic accounting standards compliance

(define-module (lex cmp za investigation-legitimacy-assessment-v37)
  #:use-module (lex lv1 known-laws)
  #:export (
    investigation-claim
    make-investigation-claim
    assess-investigation-legitimacy
    evaluate-forensic-accounting-standards
    analyze-investigation-methodology
    assess-evidence-admissibility
    calculate-investigation-credibility
    ))

;; ============================================================================
;; RECORD TYPE DEFINITIONS
;; ============================================================================

;; Investigation Claim Record
(define-record-type <investigation-claim>
  (make-investigation-claim-internal
    claim-id
    investigator
    investigation-subject
    investigation-scope
    methodology
    forensic-standards-compliance
    evidence-collection-methods
    independence-assessment
    qualifications
    findings
    evidence-strength)
  investigation-claim?
  (claim-id investigation-claim-id)
  (investigator investigation-claim-investigator)
  (investigation-subject investigation-claim-subject)
  (investigation-scope investigation-claim-scope)
  (methodology investigation-claim-methodology)
  (forensic-standards-compliance investigation-claim-standards)
  (evidence-collection-methods investigation-claim-evidence-methods)
  (independence-assessment investigation-claim-independence)
  (qualifications investigation-claim-qualifications)
  (findings investigation-claim-findings)
  (evidence-strength investigation-claim-evidence-strength))

;; Forensic Standard Record
(define-record-type <forensic-standard>
  (make-forensic-standard
    standard-name
    standard-body
    compliance-requirements
    compliance-score)
  forensic-standard?
  (standard-name forensic-standard-name)
  (standard-body forensic-standard-body)
  (compliance-requirements forensic-standard-requirements)
  (compliance-score forensic-standard-compliance))

;; Investigation Methodology Record
(define-record-type <investigation-methodology>
  (make-investigation-methodology
    methodology-type
    data-sources
    analytical-techniques
    documentation-quality
    peer-review
    methodology-soundness)
  investigation-methodology?
  (methodology-type investigation-methodology-type)
  (data-sources investigation-methodology-sources)
  (analytical-techniques investigation-methodology-techniques)
  (documentation-quality investigation-methodology-documentation)
  (peer-review investigation-methodology-peer-review)
  (methodology-soundness investigation-methodology-soundness))

;; ============================================================================
;; INVESTIGATION LEGITIMACY ASSESSMENT
;; ============================================================================

(define (assess-investigation-legitimacy claim)
  "Comprehensive assessment of investigation legitimacy"
  (let* ((independence-analysis (analyze-investigator-independence claim))
         (qualifications-analysis (analyze-investigator-qualifications claim))
         (methodology-analysis (analyze-investigation-methodology claim))
         (standards-analysis (evaluate-forensic-accounting-standards claim))
         (evidence-analysis (assess-evidence-admissibility claim))
         (legitimacy-score (calculate-legitimacy-score independence-analysis qualifications-analysis methodology-analysis standards-analysis))
         (credibility (calculate-investigation-credibility claim)))
    (list
      (cons 'claim-id (investigation-claim-id claim))
      (cons 'independence-analysis independence-analysis)
      (cons 'qualifications-analysis qualifications-analysis)
      (cons 'methodology-analysis methodology-analysis)
      (cons 'standards-analysis standards-analysis)
      (cons 'evidence-analysis evidence-analysis)
      (cons 'legitimacy-score legitimacy-score)
      (cons 'legitimacy-determination (determine-legitimacy-outcome legitimacy-score))
      (cons 'credibility credibility))))

;; ============================================================================
;; INVESTIGATOR INDEPENDENCE ANALYSIS
;; ============================================================================

(define (analyze-investigator-independence claim)
  "Analyze investigator independence and potential conflicts of interest"
  (let* ((independence (investigation-claim-independence claim))
         (independence-score (assess-independence-score independence))
         (conflict-factors (identify-conflict-factors independence)))
    (list
      (cons 'independence-assessment independence)
      (cons 'independence-score independence-score)
      (cons 'conflict-factors conflict-factors)
      (cons 'independence-determination (cond
                                          ((> independence-score 0.9) 'fully-independent)
                                          ((> independence-score 0.7) 'substantially-independent)
                                          ((> independence-score 0.5) 'questionable-independence)
                                          (else 'not-independent))))))

(define (assess-independence-score independence)
  "Assess independence score based on relationship to parties"
  (cond
    ((eq? independence 'fully-independent) 0.95)
    ((eq? independence 'third-party-appointed) 0.85)
    ((eq? independence 'party-appointed) 0.5)
    ((eq? independence 'related-party) 0.2)
    (else 0.6)))

(define (identify-conflict-factors independence)
  "Identify potential conflict of interest factors"
  (cond
    ((eq? independence 'related-party) '(financial-interest personal-relationship))
    ((eq? independence 'party-appointed) '(appointment-bias))
    (else '())))

;; ============================================================================
;; INVESTIGATOR QUALIFICATIONS ANALYSIS
;; ============================================================================

(define (analyze-investigator-qualifications claim)
  "Analyze investigator qualifications and expertise"
  (let* ((qualifications (investigation-claim-qualifications claim))
         (qualifications-score (assess-qualifications-score qualifications)))
    (list
      (cons 'qualifications qualifications)
      (cons 'qualifications-score qualifications-score)
      (cons 'qualifications-determination (cond
                                            ((> qualifications-score 0.9) 'highly-qualified)
                                            ((> qualifications-score 0.7) 'qualified)
                                            ((> qualifications-score 0.5) 'minimally-qualified)
                                            (else 'unqualified))))))

(define (assess-qualifications-score qualifications)
  "Assess qualifications score based on credentials and experience"
  (let* ((has-ca (member 'chartered-accountant qualifications))
         (has-cfe (member 'certified-fraud-examiner qualifications))
         (has-forensic-experience (member 'forensic-accounting-experience qualifications))
         (has-relevant-expertise (member 'relevant-industry-expertise qualifications))
         (qualification-count (+ (if has-ca 1 0)
                                 (if has-cfe 1 0)
                                 (if has-forensic-experience 1 0)
                                 (if has-relevant-expertise 1 0)))
         (score (/ qualification-count 4.0)))
    score))

;; ============================================================================
;; INVESTIGATION METHODOLOGY ANALYSIS
;; ============================================================================

(define (analyze-investigation-methodology claim)
  "Analyze investigation methodology and soundness"
  (let* ((methodology (investigation-claim-methodology claim))
         (methodology-soundness (assess-methodology-soundness methodology))
         (data-sources-adequacy (assess-data-sources-adequacy methodology))
         (analytical-techniques-validity (assess-analytical-techniques-validity methodology))
         (documentation-quality (assess-documentation-quality methodology))
         (methodology-score (* methodology-soundness data-sources-adequacy analytical-techniques-validity documentation-quality)))
    (list
      (cons 'methodology methodology)
      (cons 'methodology-soundness methodology-soundness)
      (cons 'data-sources-adequacy data-sources-adequacy)
      (cons 'analytical-techniques-validity analytical-techniques-validity)
      (cons 'documentation-quality documentation-quality)
      (cons 'methodology-score methodology-score)
      (cons 'methodology-determination (cond
                                         ((> methodology-score 0.8) 'sound-methodology)
                                         ((> methodology-score 0.6) 'adequate-methodology)
                                         ((> methodology-score 0.4) 'questionable-methodology)
                                         (else 'flawed-methodology))))))

(define (assess-methodology-soundness methodology)
  "Assess overall methodology soundness"
  (let* ((methodology-type (investigation-methodology-type methodology))
         (peer-review (investigation-methodology-peer-review methodology))
         (soundness-base (cond
                           ((eq? methodology-type 'systematic-forensic-analysis) 0.9)
                           ((eq? methodology-type 'standard-audit-procedures) 0.8)
                           ((eq? methodology-type 'ad-hoc-review) 0.5)
                           (else 0.3)))
         (peer-review-bonus (if peer-review 0.1 0.0))
         (soundness (min 1.0 (+ soundness-base peer-review-bonus))))
    soundness))

(define (assess-data-sources-adequacy methodology)
  "Assess adequacy of data sources used in investigation"
  (let* ((data-sources (investigation-methodology-sources methodology))
         (source-count (length data-sources))
         (has-primary-sources (member 'primary-documents data-sources))
         (has-financial-records (member 'financial-records data-sources))
         (has-witness-interviews (member 'witness-interviews data-sources))
         (adequacy-score (min 1.0 (* (/ source-count 5.0) 
                                     (if has-primary-sources 1.2 0.8)
                                     (if has-financial-records 1.1 0.9)))))
    adequacy-score))

(define (assess-analytical-techniques-validity methodology)
  "Assess validity of analytical techniques used"
  (let* ((techniques (investigation-methodology-techniques methodology))
         (technique-count (length techniques))
         (has-ratio-analysis (member 'financial-ratio-analysis techniques))
         (has-trend-analysis (member 'trend-analysis techniques))
         (has-comparative-analysis (member 'comparative-analysis techniques))
         (validity-score (min 1.0 (* (/ technique-count 4.0)
                                     (if has-ratio-analysis 1.1 0.9)))))
    validity-score))

(define (assess-documentation-quality methodology)
  "Assess quality of investigation documentation"
  (let* ((documentation (investigation-methodology-documentation methodology))
         (quality-score (cond
                          ((eq? documentation 'comprehensive-detailed) 0.95)
                          ((eq? documentation 'adequate) 0.75)
                          ((eq? documentation 'minimal) 0.5)
                          (else 0.3))))
    quality-score))

;; ============================================================================
;; FORENSIC ACCOUNTING STANDARDS EVALUATION
;; ============================================================================

(define (evaluate-forensic-accounting-standards claim)
  "Evaluate compliance with forensic accounting standards"
  (let* ((standards-compliance (investigation-claim-standards claim))
         (standards-score (assess-standards-compliance-score standards-compliance)))
    (list
      (cons 'standards-compliance standards-compliance)
      (cons 'standards-score standards-score)
      (cons 'standards-determination (cond
                                       ((> standards-score 0.9) 'fully-compliant)
                                       ((> standards-score 0.7) 'substantially-compliant)
                                       ((> standards-score 0.5) 'partially-compliant)
                                       (else 'non-compliant))))))

(define (assess-standards-compliance-score standards)
  "Assess compliance with forensic accounting standards"
  (let* ((has-ifac (member 'ifac-standards standards))
         (has-acfe (member 'acfe-standards standards))
         (has-isa (member 'isa-standards standards))
         (has-local (member 'saica-standards standards))
         (compliance-count (+ (if has-ifac 1 0)
                              (if has-acfe 1 0)
                              (if has-isa 1 0)
                              (if has-local 1 0)))
         (score (/ compliance-count 4.0)))
    score))

;; ============================================================================
;; EVIDENCE ADMISSIBILITY ASSESSMENT
;; ============================================================================

(define (assess-evidence-admissibility claim)
  "Assess admissibility of evidence collected in investigation"
  (let* ((evidence-methods (investigation-claim-evidence-methods claim))
         (admissibility-score (assess-admissibility-score evidence-methods)))
    (list
      (cons 'evidence-methods evidence-methods)
      (cons 'admissibility-score admissibility-score)
      (cons 'admissibility-determination (cond
                                           ((> admissibility-score 0.9) 'highly-admissible)
                                           ((> admissibility-score 0.7) 'admissible)
                                           ((> admissibility-score 0.5) 'questionable-admissibility)
                                           (else 'inadmissible))))))

(define (assess-admissibility-score methods)
  "Assess admissibility score based on evidence collection methods"
  (let* ((has-lawful-collection (member 'lawful-collection methods))
         (has-chain-of-custody (member 'chain-of-custody methods))
         (has-authentication (member 'authentication methods))
         (has-relevance (member 'relevance methods))
         (admissibility-count (+ (if has-lawful-collection 1 0)
                                 (if has-chain-of-custody 1 0)
                                 (if has-authentication 1 0)
                                 (if has-relevance 1 0)))
         (score (/ admissibility-count 4.0)))
    score))

;; ============================================================================
;; LEGITIMACY SCORE CALCULATION
;; ============================================================================

(define (calculate-legitimacy-score independence qualifications methodology standards)
  "Calculate overall investigation legitimacy score"
  (let* ((independence-score (cdr (assoc 'independence-score independence)))
         (qualifications-score (cdr (assoc 'qualifications-score qualifications)))
         (methodology-score (cdr (assoc 'methodology-score methodology)))
         (standards-score (cdr (assoc 'standards-score standards)))
         ;; Weighted average: independence 30%, qualifications 20%, methodology 30%, standards 20%
         (legitimacy-score (+ (* independence-score 0.3)
                              (* qualifications-score 0.2)
                              (* methodology-score 0.3)
                              (* standards-score 0.2))))
    legitimacy-score))

(define (determine-legitimacy-outcome legitimacy-score)
  "Determine legitimacy outcome based on legitimacy score"
  (cond
    ((> legitimacy-score 0.8) 'legitimate-investigation)
    ((> legitimacy-score 0.6) 'questionable-legitimacy)
    ((> legitimacy-score 0.4) 'weak-legitimacy)
    (else 'illegitimate-investigation)))

;; ============================================================================
;; INVESTIGATION CREDIBILITY CALCULATION
;; ============================================================================

(define (calculate-investigation-credibility claim)
  "Calculate overall investigation credibility based on evidence strength"
  (let* ((evidence-strength (investigation-claim-evidence-strength claim))
         (credibility-level (cond
                              ((> evidence-strength 0.9) 'very-high)
                              ((> evidence-strength 0.7) 'high)
                              ((> evidence-strength 0.5) 'moderate)
                              (else 'low))))
    (list
      (cons 'evidence-strength evidence-strength)
      (cons 'credibility-level credibility-level))))

;; ============================================================================
;; CASE-SPECIFIC: PARA 12.2 INVESTIGATION CLAIM
;; ============================================================================

;; Define Peter's investigation methodology for PARA 12.2
(define peter-investigation-methodology-para-12-2
  (make-investigation-methodology
    'ad-hoc-review ; Methodology type (not systematic forensic analysis)
    '(selective-financial-records) ; Limited data sources
    '(basic-calculation) ; Limited analytical techniques
    'minimal ; Poor documentation quality
    #f ; No peer review
    0.4)) ; Low methodology soundness

;; Define PARA 12.2 investigation claim
(define para-12-2-investigation-claim
  (make-investigation-claim-internal
    'para-12-2-investigation
    "Peter Faucitt" ; Investigator (not independent)
    "Daniel Faucitt and Jacqueline Faucitt"
    '(financial-misconduct-allegations)
    peter-investigation-methodology-para-12-2
    '() ; No forensic standards compliance claimed
    '(selective-collection) ; Questionable evidence collection methods
    'related-party ; Not independent (Peter is party to dispute)
    '() ; No professional forensic qualifications claimed
    '(alleged-financial-misconduct) ; Findings
    0.85)) ; Evidence strength for legitimacy critique

;; ============================================================================
;; LEGAL PRINCIPLES INTEGRATION
;; ============================================================================

;; Principle: Expert Evidence Admissibility (South African Law of Evidence)
;; Expert evidence is admissible if:
;; 1. The expert has relevant qualifications and experience
;; 2. The expert is independent and impartial
;; 3. The methodology used is scientifically sound
;; 4. The evidence is relevant to the issues in dispute

;; Principle: Forensic Accounting Standards (IFAC, ACFE, SAICA)
;; Forensic accounting investigations must comply with:
;; 1. International Federation of Accountants (IFAC) standards
;; 2. Association of Certified Fraud Examiners (ACFE) standards
;; 3. International Standards on Auditing (ISA)
;; 4. South African Institute of Chartered Accountants (SAICA) standards

;; Principle: Investigation Independence (Companies Act 71/2008)
;; Investigations must be conducted by independent parties to ensure:
;; 1. Objectivity and impartiality
;; 2. Freedom from conflicts of interest
;; 3. Credibility of findings
;; 4. Admissibility of evidence

;; ============================================================================
;; EXPORT FUNCTIONS
;; ============================================================================

;; Export case-specific investigation claim for PARA 12.2
(define (get-para-12-2-investigation-claim)
  "Get the PARA 12.2 investigation claim for analysis"
  para-12-2-investigation-claim)

;; Export analysis function for PARA 12.2
(define (analyze-para-12-2-investigation)
  "Analyze PARA 12.2 investigation claim with comprehensive legitimacy assessment"
  (assess-investigation-legitimacy para-12-2-investigation-claim))

;; ============================================================================
;; END OF MODULE
;; ============================================================================
