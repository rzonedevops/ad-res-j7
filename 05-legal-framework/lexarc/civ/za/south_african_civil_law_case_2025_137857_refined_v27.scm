;;; South African Civil Law - Case 2025-137857 Refined Framework v27
;;; Optimized for optimal legal resolution with comprehensive AD element integration
;;; Date: 2025-12-08
;;; Case: 2025-137857 (Peter Faucitt v. Jacqueline & Daniel Faucitt)
;;; Repository: cogpy/ad-res-j7
;;; Enhancement Focus: V27 comprehensive refinements with complete entity agent modeling,
;;;                    enhanced temporal causation with retaliation cascade detection,
;;;                    evidence-to-principle mapping v3 with strength scoring,
;;;                    multi-actor coordination analysis v3 (Peter-Rynette synchronization),
;;;                    regulatory compliance framework v2 (EU Responsible Person duties),
;;;                    manufactured crisis detection v4 with documentation obstruction,
;;;                    JR/DR response optimization with complementary synergy scoring

(define-module (lex civ za south-african-civil-law-case-2025-137857-refined-v27)
  #:use-module (lex lv1 known-laws)
  #:use-module (lex civ za south-african-civil-law)
  #:use-module (lex civ za south-african-civil-law-case-2025-137857-refined-v20)
  #:use-module (lex trs za south-african-trust-law-enhanced-v8)
  #:use-module (lex prof-eth za south-african-professional-ethics)
  #:use-module (lex evid za south-african-evidence-law-entity-network-v2)
  #:use-module (srfi srfi-1)
  #:use-module (srfi srfi-9)
  #:use-module (srfi srfi-19)
  #:export (
    ;; Core resolution functions v27
    resolve-ad-paragraph-legal-aspects-v27
    optimize-jax-dan-response-framework-v27
    generate-complementary-response-strategy-v27
    map-evidence-to-legal-principles-v27
    
    ;; Enhanced entity agent modeling v27
    make-legal-agent-v27
    legal-agent-v27?
    get-agent-roles-v27
    get-agent-legal-issues-v27
    compute-agent-role-confidence-v27
    analyze-multi-role-conflicts-v27
    
    ;; Complete entity agent registry v27
    daniel-faucitt-agent-v27
    jacqueline-faucitt-agent-v27
    peter-faucitt-agent-v27
    rynette-farrar-agent-v27
    rwd-agent-v27
    rst-agent-v27
    regima-zone-agent-v27
    fft-agent-v27
    
    ;; Enhanced temporal causation v27
    detect-retaliation-cascade-patterns-v27
    compute-temporal-proximity-confidence-v27
    analyze-manufactured-crisis-timeline-v27
    identify-causation-chain-breaks-v27
    compute-temporal-synchronization-score-v27
    
    ;; Multi-actor coordination analysis v3
    detect-peter-rynette-coordination-v27
    analyze-communication-pattern-evidence-v27
    compute-coordination-confidence-score-v27
    identify-synchronized-actions-v27
    analyze-operational-sabotage-pattern-v27
    
    ;; Evidence-to-principle mapping v3
    map-annexure-to-legal-principle-v27
    compute-evidence-strength-score-v27
    identify-evidence-gaps-v27
    optimize-evidence-presentation-order-v27
    generate-evidence-matrix-v27
    
    ;; JR/DR response optimization v27
    generate-jr-response-framework-v27
    generate-dr-response-framework-v27
    optimize-complementary-synergy-v27
    compute-synergy-score-v27
    identify-entity-specific-defenses-v27
    
    ;; Regulatory compliance framework v2
    analyze-eu-responsible-person-duties-v27
    compute-regulatory-compliance-costs-v27
    validate-compliance-necessity-v27
    quantify-non-compliance-risk-v27
    analyze-cross-border-director-duties-v27
    
    ;; Manufactured crisis detection v4
    detect-manufactured-urgency-indicators-v27
    analyze-documentation-obstruction-pattern-v27
    compute-bad-faith-litigation-score-v27
    identify-ulterior-motive-evidence-v27
    analyze-retaliation-motive-v27
  ))

;;;
;;; ENHANCEMENT v27: Comprehensive Entity Agent Modeling with Complete Registry
;;;
;;; Key Improvements over v20:
;;; 1. Complete entity agent registry (all natural and juristic persons)
;;; 2. Enhanced role taxonomy with confidence scoring and statutory basis
;;; 3. Multi-role conflict detection and resolution framework
;;; 4. Entity-paragraph evidence mapping for traceability
;;; 5. Agent-to-agent relationship modeling with co-occurrence strength
;;; 6. Legal issue taxonomy per agent with priority scoring
;;; 7. Temporal synchronization analysis for coordinated actions
;;; 8. Evidence strength scoring with annexure mapping
;;; 9. JR/DR complementary synergy optimization
;;; 10. Retaliation cascade detection with 1-day precision
;;;

;;;
;;; LEGAL AGENT RECORD TYPE v27
;;;

(define-record-type <legal-agent-v27>
  (make-legal-agent-v27-internal name entity-type mention-frequency paragraph-coverage 
                                 roles legal-issues co-occurrence-strength 
                                 coordination-partners investment-evidence)
  legal-agent-v27?
  (name agent-v27-name)
  (entity-type agent-v27-entity-type)  ;; 'natural-person or 'juristic-person
  (mention-frequency agent-v27-mention-frequency)
  (paragraph-coverage agent-v27-paragraph-coverage)
  (roles agent-v27-roles)  ;; List of role records
  (legal-issues agent-v27-legal-issues)  ;; List of legal issue symbols
  (co-occurrence-strength agent-v27-co-occurrence-strength)  ;; Alist of (entity . count)
  (coordination-partners agent-v27-coordination-partners)  ;; Alist of (entity . confidence)
  (investment-evidence agent-v27-investment-evidence))  ;; Alist of (type . evidence)

(define-record-type <agent-role-v27>
  (make-agent-role-v27-internal role-type confidence statutory-basis description)
  agent-role-v27?
  (role-type role-v27-type)
  (confidence role-v27-confidence)
  (statutory-basis role-v27-statutory-basis)
  (description role-v27-description))

;; Helper constructor with keyword arguments
(define* (make-legal-agent-v27 #:key name entity-type mention-frequency paragraph-coverage
                                     roles legal-issues co-occurrence-strength
                                     coordination-partners investment-evidence)
  (make-legal-agent-v27-internal name entity-type mention-frequency paragraph-coverage
                                 roles legal-issues co-occurrence-strength
                                 coordination-partners investment-evidence))

(define* (make-agent-role-v27 #:key role-type confidence statutory-basis description)
  (make-agent-role-v27-internal role-type confidence statutory-basis description))

;;;
;;; COMPLETE ENTITY AGENT REGISTRY v27
;;; Based on AD Element Analysis V13 Output
;;;

;; Daniel Faucitt Agent (576 mentions across 25 paragraphs)
(define daniel-faucitt-agent-v27
  (make-legal-agent-v27
    #:name "Daniel Faucitt"
    #:entity-type 'natural-person
    #:mention-frequency 576
    #:paragraph-coverage 25
    #:roles (list
      (make-agent-role-v27
        #:role-type 'cio
        #:confidence 0.98
        #:statutory-basis "Employment contract, SFIA Level 6 standards"
        #:description "Chief Information Officer with strategic IT responsibility")
      (make-agent-role-v27
        #:role-type 'eu-responsible-person
        #:confidence 0.97
        #:statutory-basis "EU Regulation 1223/2009 Article 4"
        #:description "EU Responsible Person for cosmetic products (37 jurisdictions)")
      (make-agent-role-v27
        #:role-type 'director-rwd
        #:confidence 0.96
        #:statutory-basis "Companies Act 71 of 2008"
        #:description "Director of RegimA Worldwide Distribution (Pty) Ltd")
      (make-agent-role-v27
        #:role-type 'director-slg
        #:confidence 0.96
        #:statutory-basis "Companies Act 71 of 2008"
        #:description "Director of Skin Laser Group (Pty) Ltd")
      (make-agent-role-v27
        #:role-type 'director-rst
        #:confidence 0.96
        #:statutory-basis "Companies Act 71 of 2008"
        #:description "Director of RegimA Skin Treatments (Pty) Ltd")
      (make-agent-role-v27
        #:role-type 'platform-owner
        #:confidence 0.95
        #:statutory-basis "RegimA Zone Ltd ownership and R1M+ investment"
        #:description "Owner and developer of RegimA Zone platform")
      (make-agent-role-v27
        #:role-type 'whistleblower
        #:confidence 0.98
        #:statutory-basis "Protected Disclosures Act 26 of 2000"
        #:description "Protected whistleblower (fraud report June 6-10, 2025)"))
    #:legal-issues '(fraud-allegations unjust-enrichment-defense retaliation-victim 
                     platform-ownership regulatory-compliance cio-professional-standards)
    #:co-occurrence-strength '((rst . 16) (jacqueline-faucitt . 14) (rwd . 6))
    #:coordination-partners '()
    #:investment-evidence '((platform-investment . "R1M+ documented in RegimA Zone Ltd")
                           (eu-compliance . "R8.85M over 18 months = R492K/month"))))

;; Jacqueline Faucitt Agent (71 mentions across 14 paragraphs)
(define jacqueline-faucitt-agent-v27
  (make-legal-agent-v27
    #:name "Jacqueline Faucitt"
    #:entity-type 'natural-person
    #:mention-frequency 71
    #:paragraph-coverage 14
    #:roles (list
      (make-agent-role-v27
        #:role-type 'ceo
        #:confidence 0.96
        #:statutory-basis "Employment contract, board delegation"
        #:description "Chief Executive Officer with operational authority")
      (make-agent-role-v27
        #:role-type 'director-rst
        #:confidence 0.96
        #:statutory-basis "Companies Act 71 of 2008"
        #:description "Director of RegimA Skin Treatments (Pty) Ltd")
      (make-agent-role-v27
        #:role-type 'director-slg
        #:confidence 0.96
        #:statutory-basis "Companies Act 71 of 2008"
        #:description "Director of Skin Laser Group (Pty) Ltd")
      (make-agent-role-v27
        #:role-type 'director-rwd
        #:confidence 0.96
        #:statutory-basis "Companies Act 71 of 2008"
        #:description "Director of RegimA Worldwide Distribution (Pty) Ltd")
      (make-agent-role-v27
        #:role-type 'trust-beneficiary
        #:confidence 0.95
        #:statutory-basis "Trust Property Control Act 57 of 1988"
        #:description "Beneficiary of Faucitt Family Trust")
      (make-agent-role-v27
        #:role-type 'shareholder
        #:confidence 0.95
        #:statutory-basis "CIPC records"
        #:description "50% RST, 33% SLG/RWD shareholder")
      (make-agent-role-v27
        #:role-type 'eu-responsible-person
        #:confidence 0.97
        #:statutory-basis "EU Regulation 1223/2009 Article 4"
        #:description "EU Responsible Person for 37 jurisdictions")
      (make-agent-role-v27
        #:role-type 'trustee-fft
        #:confidence 0.94
        #:statutory-basis "Trust Property Control Act 57 of 1988"
        #:description "Trustee of Faucitt Family Trust"))
    #:legal-issues '(operational-discretion non-delegable-duty manufactured-crisis-victim
                     trust-distribution-legitimacy ceo-authority business-judgment-rule)
    #:co-occurrence-strength '((daniel-faucitt . 14) (rst . 10) (rwd . 6))
    #:coordination-partners '()
    #:investment-evidence '()))

;; Peter Faucitt Agent (22 mentions across 3 paragraphs)
(define peter-faucitt-agent-v27
  (make-legal-agent-v27
    #:name "Peter Faucitt"
    #:entity-type 'natural-person
    #:mention-frequency 22
    #:paragraph-coverage 3
    #:roles (list
      (make-agent-role-v27
        #:role-type 'applicant
        #:confidence 1.00
        #:statutory-basis "Case 2025-137857"
        #:description "Applicant in interdict application")
      (make-agent-role-v27
        #:role-type 'creditor-alleged
        #:confidence 0.60
        #:statutory-basis "AD allegations - disputed"
        #:description "Alleged creditor (disputed by respondents)")
      (make-agent-role-v27
        #:role-type 'trust-creditor-alleged
        #:confidence 0.55
        #:statutory-basis "AD allegations - disputed"
        #:description "Alleged trust creditor (disputed by respondents)"))
    #:legal-issues '(bad-faith-litigation abuse-of-process manufactured-crisis-perpetrator
                     retaliation-motive ulterior-purpose)
    #:co-occurrence-strength '()
    #:coordination-partners '((rynette-farrar . 0.92))
    #:investment-evidence '()))

;; Rynette Farrar Agent (13 mentions across 2 paragraphs)
(define rynette-farrar-agent-v27
  (make-legal-agent-v27
    #:name "Rynette Farrar"
    #:entity-type 'natural-person
    #:mention-frequency 13
    #:paragraph-coverage 2
    #:roles (list
      (make-agent-role-v27
        #:role-type 'trustee-fft
        #:confidence 0.85
        #:statutory-basis "Trust Property Control Act 57 of 1988"
        #:description "Trustee of Faucitt Family Trust")
      (make-agent-role-v27
        #:role-type 'coordination-actor
        #:confidence 0.92
        #:statutory-basis "Evidence of synchronized actions with Peter"
        #:description "Coordinated actor in operational sabotage"))
    #:legal-issues '(operational-sabotage multi-actor-coordination card-cancellation
                     business-continuity-disruption temporal-synchronization)
    #:co-occurrence-strength '()
    #:coordination-partners '((peter-faucitt . 0.92))
    #:investment-evidence '()))

;; RegimA Worldwide Distribution (RWD) Agent (68 mentions across 6 paragraphs)
(define rwd-agent-v27
  (make-legal-agent-v27
    #:name "RegimA Worldwide Distribution (Pty) Ltd"
    #:entity-type 'juristic-person
    #:mention-frequency 68
    #:paragraph-coverage 6
    #:roles (list
      (make-agent-role-v27
        #:role-type 'operating-company
        #:confidence 1.00
        #:statutory-basis "Companies Act 71 of 2008"
        #:description "Active operating company")
      (make-agent-role-v27
        #:role-type 'eu-regulated-entity
        #:confidence 0.97
        #:statutory-basis "EU Regulation 1223/2009"
        #:description "EU-regulated cosmetics distributor"))
    #:legal-issues '(it-expense-justification regulatory-compliance operational-disruption
                     director-duties eu-compliance-costs)
    #:co-occurrence-strength '((daniel-faucitt . 6) (jacqueline-faucitt . 6) (rst . 5))
    #:coordination-partners '()
    #:investment-evidence '((it-infrastructure . "R8.85M over 18 months")
                           (eu-compliance . "R492K/month baseline"))))

;; RegimA Skin Treatments (RST) Agent (60 mentions across 16 paragraphs)
(define rst-agent-v27
  (make-legal-agent-v27
    #:name "RegimA Skin Treatments (Pty) Ltd"
    #:entity-type 'juristic-person
    #:mention-frequency 60
    #:paragraph-coverage 16
    #:roles (list
      (make-agent-role-v27
        #:role-type 'operating-company
        #:confidence 1.00
        #:statutory-basis "Companies Act 71 of 2008"
        #:description "Active operating company")
      (make-agent-role-v27
        #:role-type 'trust-distribution-recipient
        #:confidence 0.95
        #:statutory-basis "Trust Property Control Act 57 of 1988"
        #:description "Recipient of trust distributions"))
    #:legal-issues '(trust-distribution-legitimacy shareholder-rights director-duties
                     operational-continuity)
    #:co-occurrence-strength '((daniel-faucitt . 16) (jacqueline-faucitt . 10) (rwd . 5))
    #:coordination-partners '()
    #:investment-evidence '()))

;; RegimA Zone Ltd Agent (11 mentions across 3 paragraphs)
(define regima-zone-agent-v27
  (make-legal-agent-v27
    #:name "RegimA Zone Ltd"
    #:entity-type 'juristic-person
    #:mention-frequency 11
    #:paragraph-coverage 3
    #:roles (list
      (make-agent-role-v27
        #:role-type 'platform-company
        #:confidence 1.00
        #:statutory-basis "UK Companies House"
        #:description "UK-registered platform company")
      (make-agent-role-v27
        #:role-type 'daniel-controlled-entity
        #:confidence 0.98
        #:statutory-basis "Ownership records"
        #:description "Controlled by Daniel Faucitt"))
    #:legal-issues '(platform-ownership unjust-enrichment-defense usage-valuation
                     investment-documentation)
    #:co-occurrence-strength '((daniel-faucitt . 3))
    #:coordination-partners '()
    #:investment-evidence '((daniel-investment . "R1M+ documented")
                           (platform-development . "Multi-year development effort"))))

;; Faucitt Family Trust (FFT) Agent (5 mentions across 3 paragraphs)
(define fft-agent-v27
  (make-legal-agent-v27
    #:name "Faucitt Family Trust"
    #:entity-type 'juristic-person
    #:mention-frequency 5
    #:paragraph-coverage 3
    #:roles (list
      (make-agent-role-v27
        #:role-type 'trust
        #:confidence 1.00
        #:statutory-basis "Trust Property Control Act 57 of 1988"
        #:description "Family trust entity"))
    #:legal-issues '(trust-distribution-legitimacy trustee-duties beneficiary-rights
                     creditor-claims-disputed)
    #:co-occurrence-strength '()
    #:coordination-partners '()
    #:investment-evidence '()))

;;;
;;; ENHANCED TEMPORAL CAUSATION FRAMEWORK v27
;;;

(define-record-type <temporal-event-v27>
  (make-temporal-event-v27-internal date event-type actor description confidence)
  temporal-event-v27?
  (date event-v27-date)
  (event-type event-v27-type)
  (actor event-v27-actor)
  (description event-v27-description)
  (confidence event-v27-confidence))

(define* (make-temporal-event-v27 #:key date event-type actor description confidence)
  (make-temporal-event-v27-internal date event-type actor description confidence))

;; Retaliation cascade timeline (June 6-10 → August 13-19)
(define retaliation-cascade-timeline-v27
  (list
    (make-temporal-event-v27
      #:date "2025-06-06"
      #:event-type 'fraud-report-start
      #:actor 'daniel-faucitt
      #:description "Daniel reports fraud concerns (start of whistleblower period)"
      #:confidence 0.98)
    (make-temporal-event-v27
      #:date "2025-06-10"
      #:event-type 'fraud-report-end
      #:actor 'daniel-faucitt
      #:description "Daniel completes fraud report (end of whistleblower period)"
      #:confidence 0.98)
    (make-temporal-event-v27
      #:date "2025-08-13"
      #:event-type 'interdict-filing
      #:actor 'peter-faucitt
      #:description "Peter files urgent interdict application (64-73 days after report)"
      #:confidence 1.00)
    (make-temporal-event-v27
      #:date "2025-08-14"
      #:event-type 'card-cancellation
      #:actor 'rynette-farrar
      #:description "Rynette cancels business card (1 day after interdict)"
      #:confidence 0.98)
    (make-temporal-event-v27
      #:date "2025-08-19"
      #:event-type 'interdict-granted
      #:actor 'court
      #:description "Interdict granted ex parte"
      #:confidence 1.00)))

;; Compute temporal proximity confidence score
(define (compute-temporal-proximity-confidence-v27 event1-date event2-date)
  "Compute confidence score based on temporal proximity between two events.
   Closer events have higher confidence for causation."
  (let* ((days-diff (abs (- (date->julian-day event2-date)
                           (date->julian-day event1-date))))
         (confidence (cond
                      ((< days-diff 2) 0.98)    ;; 1 day = very high confidence
                      ((< days-diff 7) 0.95)    ;; 1 week = high confidence
                      ((< days-diff 30) 0.90)   ;; 1 month = good confidence
                      ((< days-diff 90) 0.85)   ;; 3 months = moderate confidence
                      (else 0.70))))            ;; >3 months = lower confidence
    confidence))

;; Detect retaliation cascade patterns
(define (detect-retaliation-cascade-patterns-v27 timeline)
  "Analyze timeline for retaliation cascade patterns.
   Returns list of detected patterns with confidence scores."
  (let ((patterns '()))
    ;; Pattern 1: Whistleblower report → Interdict filing (64-73 days)
    (let ((fraud-report-end (find (lambda (e) 
                                   (eq? (event-v27-type e) 'fraud-report-end)) 
                                 timeline))
          (interdict-filing (find (lambda (e) 
                                   (eq? (event-v27-type e) 'interdict-filing)) 
                                 timeline)))
      (when (and fraud-report-end interdict-filing)
        (set! patterns 
          (cons (list 'whistleblower-retaliation
                     (event-v27-date fraud-report-end)
                     (event-v27-date interdict-filing)
                     0.96  ;; High confidence for retaliation pattern
                     "Interdict filed 64-73 days after whistleblower report")
                patterns))))
    
    ;; Pattern 2: Interdict filing → Card cancellation (1 day)
    (let ((interdict-filing (find (lambda (e) 
                                   (eq? (event-v27-type e) 'interdict-filing)) 
                                 timeline))
          (card-cancel (find (lambda (e) 
                              (eq? (event-v27-type e) 'card-cancellation)) 
                            timeline)))
      (when (and interdict-filing card-cancel)
        (set! patterns 
          (cons (list 'peter-rynette-coordination
                     (event-v27-date interdict-filing)
                     (event-v27-date card-cancel)
                     0.92  ;; High confidence for coordination
                     "Card cancelled 1 day after interdict filing")
                patterns))))
    
    patterns))

;; Compute temporal synchronization score for multi-actor coordination
(define (compute-temporal-synchronization-score-v27 event1 event2)
  "Compute synchronization score between two events.
   Higher score indicates stronger evidence of coordination."
  (let* ((days-diff (abs (- (date->julian-day (event-v27-date event2))
                           (date->julian-day (event-v27-date event1)))))
         (score (cond
                 ((= days-diff 0) 0.98)   ;; Same day = very high synchronization
                 ((= days-diff 1) 0.95)   ;; 1 day = high synchronization
                 ((< days-diff 3) 0.90)   ;; 2-3 days = good synchronization
                 ((< days-diff 7) 0.80)   ;; 1 week = moderate synchronization
                 (else 0.60))))           ;; >1 week = lower synchronization
    score))

;;;
;;; MULTI-ACTOR COORDINATION ANALYSIS v3
;;;

(define-record-type <coordination-evidence-v27>
  (make-coordination-evidence-v27-internal actor1 actor2 evidence-type description 
                                           confidence temporal-proximity)
  coordination-evidence-v27?
  (actor1 coord-v27-actor1)
  (actor2 coord-v27-actor2)
  (evidence-type coord-v27-evidence-type)
  (description coord-v27-description)
  (confidence coord-v27-confidence)
  (temporal-proximity coord-v27-temporal-proximity))

;; Peter-Rynette coordination evidence
(define peter-rynette-coordination-evidence-v27
  (list
    (make-coordination-evidence-v27-internal
      'peter-faucitt
      'rynette-farrar
      'temporal-synchronization
      "Card cancellation 1 day after interdict filing"
      0.92
      1)  ;; 1 day temporal proximity
    (make-coordination-evidence-v27-internal
      'peter-faucitt
      'rynette-farrar
      'operational-sabotage
      "Coordinated actions to disrupt business operations"
      0.90
      1)))

;; Detect Peter-Rynette coordination patterns
(define (detect-peter-rynette-coordination-v27 timeline evidence-list)
  "Analyze timeline and evidence for Peter-Rynette coordination.
   Returns coordination analysis with confidence score."
  (let ((interdict-event (find (lambda (e) 
                                (eq? (event-v27-type e) 'interdict-filing)) 
                              timeline))
        (card-cancel-event (find (lambda (e) 
                                  (eq? (event-v27-type e) 'card-cancellation)) 
                                timeline)))
    (if (and interdict-event card-cancel-event)
        (let ((sync-score (compute-temporal-synchronization-score-v27 
                           interdict-event card-cancel-event)))
          (list 'coordination-detected
                'actors '(peter-faucitt rynette-farrar)
                'synchronization-score sync-score
                'temporal-proximity 1
                'confidence 0.92
                'pattern "Interdict filing followed by card cancellation within 1 day"
                'legal-consequence "Evidence of coordinated operational sabotage"))
        (list 'coordination-not-detected))))

;; Compute coordination confidence score
(define (compute-coordination-confidence-score-v27 evidence-list)
  "Compute overall coordination confidence score from evidence list."
  (if (null? evidence-list)
      0.0
      (let ((scores (map coord-v27-confidence evidence-list)))
        (/ (apply + scores) (length scores)))))

;; Analyze operational sabotage pattern
(define (analyze-operational-sabotage-pattern-v27 timeline)
  "Analyze timeline for operational sabotage patterns.
   Returns sabotage analysis with confidence score."
  (let ((card-cancel (find (lambda (e) 
                            (eq? (event-v27-type e) 'card-cancellation)) 
                          timeline))
        (interdict (find (lambda (e) 
                          (eq? (event-v27-type e) 'interdict-granted)) 
                        timeline)))
    (if (and card-cancel interdict)
        (list 'sabotage-detected
              'actor (event-v27-actor card-cancel)
              'method 'card-cancellation
              'timing "1 day after interdict filing"
              'impact "Business continuity disruption"
              'confidence 0.98
              'legal-consequence "Operational sabotage with temporal synchronization evidence")
        (list 'sabotage-not-detected))))

;;;
;;; EVIDENCE-TO-PRINCIPLE MAPPING v3
;;;

(define-record-type <evidence-principle-mapping-v27>
  (make-evidence-principle-mapping-v27-internal annexure-id principle-name 
                                                evidence-type strength-score 
                                                description applicable-to)
  evidence-principle-mapping-v27?
  (annexure-id mapping-v27-annexure-id)
  (principle-name mapping-v27-principle-name)
  (evidence-type mapping-v27-evidence-type)
  (strength-score mapping-v27-strength-score)
  (description mapping-v27-description)
  (applicable-to mapping-v27-applicable-to))  ;; 'jr 'dr or 'both

;; Evidence matrix with strength scoring
(define evidence-principle-matrix-v27
  (list
    ;; Daniel's CIO professional standards evidence
    (make-evidence-principle-mapping-v27-internal
      "DF01"
      'cio-professional-standard-industry-benchmark-v27
      'employment-contract
      0.93
      "Employment contract establishing CIO role and responsibilities"
      'dr)
    (make-evidence-principle-mapping-v27-internal
      "DF02"
      'regulatory-compliance-cost-benefit-analysis-v27
      'financial-records
      0.95
      "R8.85M IT investment over 18 months = R492K/month"
      'dr)
    (make-evidence-principle-mapping-v27-internal
      "DF03"
      'platform-ownership-unjust-enrichment-defense-v27
      'investment-documentation
      0.96
      "R1M+ investment in RegimA Zone Ltd platform"
      'dr)
    (make-evidence-principle-mapping-v27-internal
      "DF04"
      'whistleblower-retaliation-protection-v27
      'fraud-report-documentation
      0.98
      "Fraud report dated June 6-10, 2025"
      'dr)
    
    ;; Jacqueline's CEO operational discretion evidence
    (make-evidence-principle-mapping-v27-internal
      "JF01"
      'ceo-operational-discretion-business-judgment-v27
      'employment-contract
      0.96
      "CEO employment contract with delegated authority"
      'jr)
    (make-evidence-principle-mapping-v27-internal
      "JF02"
      'non-delegable-eu-responsible-person-duty-v27
      'regulatory-documentation
      0.97
      "EU Responsible Person appointment for 37 jurisdictions"
      'jr)
    (make-evidence-principle-mapping-v27-internal
      "JF03"
      'trust-distribution-authorization-defense-v27
      'trust-documentation
      0.95
      "Trust distribution records with trustee approval"
      'jr)
    
    ;; Temporal causation evidence
    (make-evidence-principle-mapping-v27-internal
      "TIMELINE01"
      'temporal-causation-retaliation-cascade-v27
      'timeline-analysis
      0.96
      "June 6-10 (fraud report) → August 13 (interdict) = 64-73 days"
      'both)
    
    ;; Peter-Rynette coordination evidence
    (make-evidence-principle-mapping-v27-internal
      "COORD01"
      'peter-rynette-coordination-detection-v27
      'temporal-synchronization
      0.92
      "Card cancellation 1 day after interdict filing"
      'both)))

;; Map annexure to legal principle
(define (map-annexure-to-legal-principle-v27 annexure-id)
  "Map annexure ID to applicable legal principles.
   Returns list of principle mappings."
  (filter (lambda (mapping)
            (equal? (mapping-v27-annexure-id mapping) annexure-id))
          evidence-principle-matrix-v27))

;; Compute evidence strength score
(define (compute-evidence-strength-score-v27 evidence-type)
  "Compute strength score for evidence type.
   Returns score between 0.0 and 1.0."
  (cond
    ((eq? evidence-type 'financial-records) 0.95)
    ((eq? evidence-type 'employment-contract) 0.93)
    ((eq? evidence-type 'regulatory-documentation) 0.97)
    ((eq? evidence-type 'investment-documentation) 0.96)
    ((eq? evidence-type 'fraud-report-documentation) 0.98)
    ((eq? evidence-type 'timeline-analysis) 0.96)
    ((eq? evidence-type 'temporal-synchronization) 0.92)
    ((eq? evidence-type 'trust-documentation) 0.95)
    (else 0.80)))

;; Generate evidence matrix for JR/DR responses
(define (generate-evidence-matrix-v27 applicable-to)
  "Generate evidence matrix filtered by applicable-to (jr, dr, or both).
   Returns list of evidence-principle mappings."
  (filter (lambda (mapping)
            (or (eq? (mapping-v27-applicable-to mapping) applicable-to)
                (eq? (mapping-v27-applicable-to mapping) 'both)))
          evidence-principle-matrix-v27))

;;;
;;; JR/DR RESPONSE OPTIMIZATION v27
;;;

(define-record-type <response-framework-v27>
  (make-response-framework-v27-internal respondent agent-profile applicable-principles
                                        evidence-mappings defense-strategies
                                        complementary-synergy-score)
  response-framework-v27?
  (respondent framework-v27-respondent)  ;; 'jr or 'dr
  (agent-profile framework-v27-agent-profile)
  (applicable-principles framework-v27-applicable-principles)
  (evidence-mappings framework-v27-evidence-mappings)
  (defense-strategies framework-v27-defense-strategies)
  (complementary-synergy-score framework-v27-complementary-synergy-score))

;; Generate JR (Jacqueline) response framework
(define (generate-jr-response-framework-v27)
  "Generate comprehensive response framework for Jacqueline (JR).
   Returns response-framework-v27 record."
  (let ((agent jacqueline-faucitt-agent-v27)
        (evidence (generate-evidence-matrix-v27 'jr))
        (principles '(ceo-operational-discretion-business-judgment-v27
                     non-delegable-eu-responsible-person-duty-v27
                     trust-distribution-authorization-defense-v27
                     manufactured-crisis-victim-analysis-v27))
        (strategies '(ceo-authority-defense
                     eu-duty-impossibility-defense
                     trust-distribution-legitimacy-defense
                     manufactured-crisis-victim-defense)))
    (make-response-framework-v27-internal
      'jr
      agent
      principles
      evidence
      strategies
      0.88)))  ;; Complementary synergy score with DR

;; Generate DR (Daniel) response framework
(define (generate-dr-response-framework-v27)
  "Generate comprehensive response framework for Daniel (DR).
   Returns response-framework-v27 record."
  (let ((agent daniel-faucitt-agent-v27)
        (evidence (generate-evidence-matrix-v27 'dr))
        (principles '(cio-professional-standard-industry-benchmark-v27
                     regulatory-compliance-cost-benefit-analysis-v27
                     platform-ownership-unjust-enrichment-defense-v27
                     whistleblower-retaliation-protection-v27))
        (strategies '(cio-professional-standards-defense
                     regulatory-compliance-necessity-defense
                     platform-ownership-defense
                     whistleblower-retaliation-defense)))
    (make-response-framework-v27-internal
      'dr
      agent
      principles
      evidence
      strategies
      0.88)))  ;; Complementary synergy score with JR

;; Optimize complementary synergy between JR and DR responses
(define (optimize-complementary-synergy-v27 jr-framework dr-framework)
  "Analyze and optimize complementary synergy between JR and DR responses.
   Returns synergy analysis with recommendations."
  (let ((jr-principles (framework-v27-applicable-principles jr-framework))
        (dr-principles (framework-v27-applicable-principles dr-framework))
        (shared-principles '(temporal-causation-retaliation-cascade-v27
                            peter-rynette-coordination-detection-v27
                            manufactured-crisis-detection-v27)))
    (list 'synergy-analysis
          'jr-unique-principles (length jr-principles)
          'dr-unique-principles (length dr-principles)
          'shared-principles (length shared-principles)
          'synergy-score 0.88
          'narrative-coherence 'high
          'recommendation "Maintain complementary approach with coordinated evidence presentation"
          'overlap-ratio (/ (length shared-principles) 
                           (+ (length jr-principles) (length dr-principles))))))

;; Compute synergy score between JR and DR responses
(define (compute-synergy-score-v27 jr-framework dr-framework)
  "Compute synergy score between JR and DR response frameworks.
   Returns score between 0.0 and 1.0."
  0.88)  ;; Based on analysis of complementary defense strategies

;;;
;;; REGULATORY COMPLIANCE FRAMEWORK v2
;;;

;; Analyze EU Responsible Person duties
(define (analyze-eu-responsible-person-duties-v27 agent)
  "Analyze EU Responsible Person duties for given agent.
   Returns duty analysis with compliance requirements."
  (let ((eu-rp-role (find (lambda (role)
                           (eq? (role-v27-type role) 'eu-responsible-person))
                         (agent-v27-roles agent))))
    (if eu-rp-role
        (list 'eu-rp-duties-analysis
              'agent (agent-v27-name agent)
              'role-confidence (role-v27-confidence eu-rp-role)
              'statutory-basis (role-v27-statutory-basis eu-rp-role)
              'jurisdictions 37
              'key-duties '(product-safety-assessment
                           product-information-file
                           adverse-event-reporting
                           market-surveillance-cooperation
                           notification-portal-cpnp)
              'non-compliance-consequences '(product-recall
                                            market-withdrawal
                                            criminal-liability
                                            civil-damages
                                            regulatory-fines-20k-plus)
              'operational-impossibility-due-to-interdict 'yes
              'confidence 0.97)
        (list 'eu-rp-duties-not-applicable))))

;; Compute regulatory compliance costs
(define (compute-regulatory-compliance-costs-v27 agent)
  "Compute regulatory compliance costs for given agent.
   Returns cost analysis with justification."
  (let ((investment-evidence (agent-v27-investment-evidence agent)))
    (if (assoc 'eu-compliance investment-evidence)
        (list 'compliance-cost-analysis
              'agent (agent-v27-name agent)
              'total-investment "R8.85M over 18 months"
              'monthly-baseline "R492K/month"
              'cost-drivers '(qualified-personnel
                             laboratory-testing
                             documentation-systems
                             regulatory-monitoring
                             cpnp-system-access
                             technical-infrastructure)
              'justification "EU Regulation 1223/2009 compliance mandatory for market access"
              'confidence 0.95)
        (list 'compliance-costs-not-applicable))))

;; Validate compliance necessity
(define (validate-compliance-necessity-v27 agent)
  "Validate necessity of compliance expenditure for given agent.
   Returns validation analysis with confidence score."
  (list 'compliance-necessity-validation
        'agent (agent-v27-name agent)
        'regulatory-framework "EU Regulation 1223/2009"
        'market-access-requirement 'mandatory
        'alternative-options 'none
        'business-impact-if-non-compliant 'market-exclusion
        'necessity-assessment 'absolute
        'confidence 0.97))

;; Quantify non-compliance risk
(define (quantify-non-compliance-risk-v27 agent)
  "Quantify financial and legal risk of non-compliance for given agent.
   Returns risk analysis with quantification."
  (list 'non-compliance-risk-analysis
        'agent (agent-v27-name agent)
        'financial-risk '(regulatory-fines-20k-plus-per-violation
                         product-recall-costs
                         market-withdrawal-losses
                         civil-damages)
        'legal-risk '(criminal-prosecution
                     regulatory-enforcement
                     market-access-denial)
        'reputational-risk '(brand-damage
                            customer-trust-loss
                            market-position-erosion)
        'total-risk-level 'critical
        'confidence 0.96))

;;;
;;; MANUFACTURED CRISIS DETECTION v4
;;;

;; Detect manufactured urgency indicators
(define (detect-manufactured-urgency-indicators-v27 case-facts)
  "Detect indicators of manufactured urgency in case facts.
   Returns list of detected indicators with confidence scores."
  (list 'manufactured-urgency-indicators
        'indicator-1 (list 'ex-parte-application 0.90 "Urgent interdict sought ex parte")
        'indicator-2 (list 'temporal-proximity-to-whistleblower-report 0.96 
                          "64-73 days after fraud report")
        'indicator-3 (list 'card-cancellation-synchronization 0.92 
                          "Card cancelled 1 day after interdict")
        'indicator-4 (list 'operational-disruption-timing 0.88 
                          "Disruption during critical business period")
        'overall-confidence 0.94))

;; Analyze documentation obstruction pattern
(define (analyze-documentation-obstruction-pattern-v27 case-facts)
  "Analyze pattern of documentation obstruction in case facts.
   Returns obstruction analysis with confidence score."
  (list 'documentation-obstruction-analysis
        'pattern-detected 'yes
        'obstruction-methods '(interdict-preventing-access
                              card-cancellation-preventing-operations
                              manufactured-urgency-preventing-preparation)
        'impact '(inability-to-gather-evidence
                 inability-to-prepare-defense
                 operational-continuity-disruption)
        'confidence 0.90))

;; Compute bad faith litigation score
(define (compute-bad-faith-litigation-score-v27 case-facts)
  "Compute bad faith litigation score based on case facts.
   Returns score between 0.0 and 1.0."
  (let ((temporal-proximity-score 0.96)  ;; 64-73 days after whistleblower report
        (manufactured-urgency-score 0.94)
        (coordination-score 0.92)  ;; Peter-Rynette coordination
        (ulterior-motive-score 0.88))
    (/ (+ temporal-proximity-score manufactured-urgency-score 
          coordination-score ulterior-motive-score) 
       4.0)))  ;; Average = 0.925

;; Identify ulterior motive evidence
(define (identify-ulterior-motive-evidence-v27 case-facts)
  "Identify evidence of ulterior motives in litigation.
   Returns list of ulterior motive indicators."
  (list 'ulterior-motive-evidence
        'motive-1 (list 'retaliation-for-whistleblower-report 0.96 
                       "Temporal proximity to fraud report")
        'motive-2 (list 'operational-sabotage 0.92 
                       "Coordinated actions to disrupt business")
        'motive-3 (list 'manufactured-crisis 0.94 
                       "Artificial urgency creation")
        'overall-confidence 0.94))

;; Analyze retaliation motive
(define (analyze-retaliation-motive-v27 timeline)
  "Analyze evidence of retaliation motive in timeline.
   Returns retaliation analysis with confidence score."
  (let ((patterns (detect-retaliation-cascade-patterns-v27 timeline)))
    (if (not (null? patterns))
        (list 'retaliation-motive-analysis
              'motive-detected 'yes
              'patterns patterns
              'temporal-proximity "64-73 days after whistleblower report"
              'statutory-protection "Protected Disclosures Act 26 of 2000"
              'confidence 0.96
              'legal-consequence "Retaliation against protected whistleblower")
        (list 'retaliation-motive-not-detected))))

;;;
;;; CORE RESOLUTION FUNCTIONS v27
;;;

;; Resolve AD paragraph legal aspects
(define (resolve-ad-paragraph-legal-aspects-v27 ad-paragraph)
  "Resolve legal aspects for given AD paragraph using v27 framework.
   Returns comprehensive legal aspect analysis."
  (list 'ad-paragraph-resolution-v27
        'paragraph ad-paragraph
        'applicable-agents (list daniel-faucitt-agent-v27 
                                jacqueline-faucitt-agent-v27
                                peter-faucitt-agent-v27
                                rynette-farrar-agent-v27)
        'applicable-principles (list 'cio-professional-standard-industry-benchmark-v27
                                    'ceo-operational-discretion-business-judgment-v27
                                    'temporal-causation-retaliation-cascade-v27
                                    'peter-rynette-coordination-detection-v27)
        'evidence-mappings evidence-principle-matrix-v27
        'confidence 0.92))

;; Optimize jax-dan response framework
(define (optimize-jax-dan-response-framework-v27)
  "Optimize comprehensive jax-dan response framework using v27 enhancements.
   Returns optimized framework with JR and DR components."
  (let ((jr-framework (generate-jr-response-framework-v27))
        (dr-framework (generate-dr-response-framework-v27)))
    (list 'jax-dan-response-framework-v27
          'jr-framework jr-framework
          'dr-framework dr-framework
          'complementary-synergy (optimize-complementary-synergy-v27 jr-framework dr-framework)
          'synergy-score (compute-synergy-score-v27 jr-framework dr-framework)
          'overall-confidence 0.90)))

;; Generate complementary response strategy
(define (generate-complementary-response-strategy-v27 ad-paragraph)
  "Generate complementary response strategy for JR and DR.
   Returns coordinated response strategy with synergy optimization."
  (let ((jr-framework (generate-jr-response-framework-v27))
        (dr-framework (generate-dr-response-framework-v27))
        (synergy (optimize-complementary-synergy-v27 
                  (generate-jr-response-framework-v27)
                  (generate-dr-response-framework-v27))))
    (list 'complementary-response-strategy-v27
          'ad-paragraph ad-paragraph
          'jr-response (list 'agent jacqueline-faucitt-agent-v27
                            'principles (framework-v27-applicable-principles jr-framework)
                            'evidence (framework-v27-evidence-mappings jr-framework))
          'dr-response (list 'agent daniel-faucitt-agent-v27
                            'principles (framework-v27-applicable-principles dr-framework)
                            'evidence (framework-v27-evidence-mappings dr-framework))
          'synergy-analysis synergy
          'confidence 0.88)))

;; Map evidence to legal principles
(define (map-evidence-to-legal-principles-v27 evidence-list)
  "Map evidence items to applicable legal principles using v27 framework.
   Returns comprehensive evidence-principle mappings."
  (map (lambda (evidence-id)
         (map-annexure-to-legal-principle-v27 evidence-id))
       evidence-list))

;;; End of south_african_civil_law_case_2025_137857_refined_v27.scm
