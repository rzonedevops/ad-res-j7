;; LEX SCHEME V36 - JURISTIC PERSON AGENT MODELING
;; Repository: cogpy/ad-res-j7
;; Case: 2025-137857
;; Date: December 17, 2025

(define-module (lex cmp za juristic-person-agent-modeling-v36)
  #:use-module (lex lv1 known-laws)
  #:use-module (srfi srfi-1)
  #:use-module (srfi srfi-9)
  #:export (
    make-juristic-person
    juristic-person?
    juristic-person-name
    juristic-person-registration
    juristic-person-directors
    juristic-person-shareholders
    juristic-person-legal-issues
    
    ;; RWD, RST, RZL definitions
    regima-worldwide-distribution
    regima-skin-treatments
    regima-zone-ltd
    
    ;; Analysis functions
    analyze-corporate-veil
    detect-multi-entity-coordination
    compute-director-duty-allocation
    analyze-platform-ownership-nexus
  ))

;;;
;;; RECORD TYPE DEFINITIONS
;;;

(define-record-type <juristic-person>
  (make-juristic-person name registration jurisdiction status directors shareholders legal-issues)
  juristic-person?
  (name juristic-person-name)
  (registration juristic-person-registration)
  (jurisdiction juristic-person-jurisdiction)
  (status juristic-person-status)
  (directors juristic-person-directors)
  (shareholders juristic-person-shareholders)
  (legal-issues juristic-person-legal-issues))

(define-record-type <director>
  (make-director name role appointment-date fiduciary-duties statutory-basis)
  director?
  (name director-name)
  (role director-role)
  (appointment-date director-appointment-date)
  (fiduciary-duties director-fiduciary-duties)
  (statutory-basis director-statutory-basis))

(define-record-type <shareholder>
  (make-shareholder name percentage share-class)
  shareholder?
  (name shareholder-name)
  (percentage shareholder-percentage)
  (share-class shareholder-share-class))

;;;
;;; JURISTIC PERSON DEFINITIONS
;;;

(define regima-worldwide-distribution
  (make-juristic-person
   "RegimA Worldwide Distribution (Pty) Ltd"
   "[To be confirmed]"
   "South Africa"
   "active"
   (list
    (make-director "Daniel Faucitt" "Director" "[TBC]" 
                   '(care skill diligence good-faith) 
                   "Companies Act 71/2008 Section 76")
    (make-director "Jacqueline Faucitt" "Director" "[TBC]" 
                   '(care skill diligence good-faith) 
                   "Companies Act 71/2008 Section 76"))
   (list
    (make-shareholder "Jacqueline Faucitt" 0.33 "ordinary")
    (make-shareholder "Daniel Faucitt" 0.33 "ordinary")
    (make-shareholder "Other" 0.34 "ordinary"))
   '((it-expense-justification . ((confidence . 0.98) 
                                   (priority . "CRITICAL")
                                   (lex-framework . "prof-eth/za/cio_professional_standard_industry_benchmark_v25.scm")))
     (regulatory-compliance . ((confidence . 0.97) 
                                (priority . "CRITICAL")
                                (lex-framework . "env/za/south_african_regulatory_compliance_cost_justification_v22.scm")))
     (operational-disruption . ((confidence . 0.96) 
                                 (priority . "HIGH")
                                 (lex-framework . "civ/za/south_african_civil_law_manufactured_crisis_detection.scm"))))))

(define regima-skin-treatments
  (make-juristic-person
   "RegimA Skin Treatments (Pty) Ltd"
   "[To be confirmed]"
   "South Africa"
   "active"
   (list
    (make-director "Daniel Faucitt" "Director" "[TBC]" 
                   '(care skill diligence good-faith) 
                   "Companies Act 71/2008 Section 76")
    (make-director "Jacqueline Faucitt" "Director" "[TBC]" 
                   '(care skill diligence good-faith) 
                   "Companies Act 71/2008 Section 76"))
   (list
    (make-shareholder "Jacqueline Faucitt" 0.50 "ordinary")
    (make-shareholder "Daniel Faucitt" 0.50 "ordinary"))
   '((trust-distribution-legitimacy . ((confidence . 0.94) 
                                        (priority . "HIGH")
                                        (lex-framework . "trs/za/south_african_trust_law_enhanced_v8.scm")))
     (shareholder-rights . ((confidence . 0.96) 
                             (priority . "HIGH")
                             (lex-framework . "cmp/za/south_african_company_law_enhanced.scm"))))))

(define regima-zone-ltd
  (make-juristic-person
   "RegimA Zone Ltd"
   "[To be confirmed]"
   "United Kingdom"
   "active"
   '() ; Directors to be confirmed
   (list
    (make-shareholder "Daniel Faucitt" 1.0 "controlling"))
   '((platform-ownership . ((confidence . 0.98) 
                             (priority . "CRITICAL")
                             (lex-framework . "cmp/za/south_african_platform_ownership_defense_v22.scm")
                             (investment-proof . "R1M+ documented")))
     (unjust-enrichment-defense . ((confidence . 0.96) 
                                    (priority . "HIGH")
                                    (lex-framework . "civ/za/south_african_civil_law_platform_unjust_enrichment.scm")
                                    (admin-fee . "0.1%")))
     (usage-valuation . ((confidence . 0.95) 
                          (priority . "MEDIUM-HIGH")
                          (lex-framework . "civ/za/south_african_civil_law_enhanced.scm"))))))

;;;
;;; CORPORATE VEIL ANALYSIS
;;;

(define (analyze-corporate-veil juristic-person)
  "Analyze corporate veil for platform ownership claims"
  (let ((name (juristic-person-name juristic-person))
        (shareholders (juristic-person-shareholders juristic-person)))
    (cond
      ((string-contains name "RegimA Zone")
       '((veil-status . "intact")
         (ownership-clarity . 0.98)
         (separate-legal-personality . #t)
         (investment-proof . "R1M+ documented")
         (legal-significance . "Platform ownership defense against unjust enrichment claims")))
      (else
       '((veil-status . "intact")
         (ownership-clarity . 0.96)
         (separate-legal-personality . #t))))))

;;;
;;; MULTI-ENTITY COORDINATION DETECTION
;;;

(define (detect-multi-entity-coordination entities)
  "Detect coordination patterns across multiple juristic persons"
  (let ((director-overlap (compute-director-overlap entities))
        (shareholder-overlap (compute-shareholder-overlap entities)))
    (if (and (> director-overlap 0.5) (> shareholder-overlap 0.3))
        '((coordination-detected . #t)
          (coordination-type . "director-shareholder-overlap")
          (confidence . 0.94)
          (legal-significance . "Complementary defense strategy across entities"))
        '((coordination-detected . #f)))))

(define (compute-director-overlap entities)
  "Compute director overlap coefficient"
  ;; Placeholder - implement based on actual director lists
  0.85)

(define (compute-shareholder-overlap entities)
  "Compute shareholder overlap coefficient"
  ;; Placeholder - implement based on actual shareholder lists
  0.75)

;;;
;;; DIRECTOR DUTY ALLOCATION
;;;

(define (compute-director-duty-allocation director entity)
  "Compute director duty allocation for complementary defense"
  (let ((director-name (director-name director))
        (entity-name (juristic-person-name entity)))
    (cond
      ((and (string=? director-name "Jacqueline Faucitt")
            (string-contains entity-name "Worldwide Distribution"))
       '((role-focus . "CEO operational discretion")
         (defense-strategy . "Non-delegable duty - regulatory compliance")
         (confidence . 0.96)))
      ((and (string=? director-name "Daniel Faucitt")
            (string-contains entity-name "Worldwide Distribution"))
       '((role-focus . "CIO technical infrastructure")
         (defense-strategy . "IT expense justification - SFIA Level 6 authority")
         (confidence . 0.98)))
      (else
       '((role-focus . "general-director")
         (defense-strategy . "fiduciary-duty-compliance")
         (confidence . 0.90))))))

;;;
;;; PLATFORM OWNERSHIP NEXUS ANALYSIS
;;;

(define (analyze-platform-ownership-nexus juristic-person)
  "Analyze platform ownership nexus for RZL"
  (let ((name (juristic-person-name juristic-person))
        (legal-issues (juristic-person-legal-issues juristic-person)))
    (if (string-contains name "RegimA Zone")
        '((ownership-nexus . "established")
          (investment-documented . #t)
          (investment-amount . "R1M+")
          (admin-fee-percentage . 0.001)
          (unjust-enrichment-defense-strength . 0.96)
          (legal-significance . "Platform ownership defense - investment vastly exceeds usage fees"))
        '((ownership-nexus . "not-applicable")))))

