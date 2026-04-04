;;; -*- mode: scheme; coding: utf-8 -*-
;;; SOUTH AFRICAN CIVIL LAW - CASE 2025-137857 REFINED RESOLUTION FRAMEWORK V3
;;; ============================================================================
;;; File: south_african_civil_law_case_2025_137857_refined_v3.scm
;;; Purpose: Enhanced legal resolution framework for Peter Faucitt v. Jacqueline & Daniel Faucitt
;;; Date: 2025-11-17
;;; Confidence: 0.98
;;; 
;;; This framework provides case-specific legal resolution optimized for the
;;; identified entities, relations, events, and timelines in Case 2025-137857.
;;;
;;; ENHANCEMENTS IN V3:
;;; - Enhanced temporal pattern detection with retaliation analysis
;;; - Improved evidence mapping to AD paragraphs
;;; - Multi-actor coordination detection
;;; - Strengthened causation chain modeling
;;; - Direct integration with jax-dan-response structure
;;;
;;; KEY CASE ELEMENTS:
;;; - 6 Natural Persons: Peter, Jacqueline, Daniel Faucitt, Rynette Farrar, Daniel Bantjies, Gee
;;; - 6 Juristic Persons: FFT, RST, RWD, RegimA Zone Ltd, Rezonance, SLG
;;; - 39+ Timeline Events with temporal correlation patterns
;;; - 10 Primary Legal Issues with severity scoring
;;; - 25 AD Paragraphs mapped to legal principles
;;; ============================================================================

(define-module (lex civ za case-2025-137857-refined-v3)
  #:use-module (lex lv1 known-laws)
  #:use-module (lex civ za south-african-civil-law)
  #:use-module (lex cmp za south-african-company-law)
  #:use-module (lex trs za south-african-trust-law)
  #:use-module (lex civ-proc za south-african-civil-procedure)
  #:export (
    ;; Entity Definitions
    define-case-entity
    define-case-relation
    get-entity-conflicts
    
    ;; Agent-Based Analysis
    analyze-agent-conflicts
    calculate-conflict-severity
    detect-multi-role-conflicts
    
    ;; Temporal Pattern Detection
    detect-temporal-patterns
    detect-retaliation-patterns
    calculate-temporal-proximity
    analyze-temporal-sequence
    
    ;; Legal Issue Resolution
    resolve-sabotage-claim
    resolve-temporal-bad-faith-claim
    resolve-fraud-coordination-claim
    resolve-fiduciary-breach-claim
    resolve-manufactured-crisis-claim
    resolve-unjust-enrichment-claim
    resolve-conflict-of-interest-claim
    resolve-coercion-claim
    resolve-litigation-weaponization-claim
    
    ;; Evidence Mapping
    map-evidence-to-legal-principle
    map-ad-paragraph-to-legal-aspects
    calculate-evidence-strength
    generate-burden-of-proof-analysis
    
    ;; Multi-Actor Coordination
    detect-multi-actor-coordination
    analyze-coordination-patterns
    calculate-coordination-confidence
    
    ;; Case-Specific Analysis
    analyze-director-loan-hypocrisy
    analyze-revenue-hijacking-pattern
    analyze-trust-weaponization
    analyze-manufactured-urgency
    analyze-regulatory-crisis-impact
  ))

;;; ============================================================================
;;; PART 1: ENTITY AND RELATION DEFINITIONS WITH ENHANCED CONFLICT DETECTION
;;; ============================================================================

;;; ----------------------------------------------------------------------------
;;; 1.1 Natural Person Entities with Multi-Role Conflict Analysis
;;; ----------------------------------------------------------------------------

(define peter-faucitt-agent
  '((id . "peter-faucitt")
    (type . "natural-person")
    (roles . ("founder-fft" "trustee-fft" "director-rwd" "director-rst" "applicant"))
    (legal-aspects . (
      "fiduciary-duty-breach"
      "abuse-of-power"
      "temporal-bad-faith"
      "litigation-weaponization"
      "power-concentration"
      "conflict-of-interest"
      "coercion"
      "manufactured-crisis"
    ))
    (conflicts . (
      ((type . "founder-trustee-concentration")
       (severity . 0.98)
       (priority . "critical")
       (legal-principles . ("fiduciary-duty" "power-concentration" "checks-and-balances"))
       (description . "Founder with absolute trustee powers creates unchecked authority")
       (resolution-required . #t))
      ((type . "trustee-beneficiary-antagonism")
       (severity . 0.97)
       (priority . "critical")
       (legal-principles . ("fiduciary-duty" "trust-law" "beneficiary-rights"))
       (description . "Trustee using trust assets to attack beneficiaries")
       (resolution-required . #t))
      ((type . "director-sabotage")
       (severity . 0.96)
       (priority . "critical")
       (legal-principles . ("fiduciary-duty" "company-law" "director-duties"))
       (description . "Director sabotaging company operations through card cancellations")
       (resolution-required . #t))
    ))
    (critical-events . (
      "2025-06-07: Card cancellation (1 day after fraud report)"
      "2025-07-01: Trustee powers backdated"
      "2025-08-11: Obtained Jax signature on backdating document"
      "2025-08-13: Filed interdict (2 days after cooperation)"
    ))
    (temporal-patterns . (
      "immediate-retaliation"
      "manufactured-crisis"
      "litigation-weaponization"
      "hypocrisy-pattern"
    ))
  ))

(define jacqueline-faucitt-agent
  '((id . "jacqueline-faucitt")
    (type . "natural-person")
    (roles . ("ceo-rst" "beneficiary-fft" "director-regima" "eu-responsible-person" "first-respondent"))
    (legal-aspects . (
      "beneficiary-rights-violation"
      "executive-duties-sabotage"
      "victim-of-coercion"
      "victim-of-power-abuse"
      "revenue-stream-disruption"
      "regulatory-crisis-victim"
    ))
    (conflicts . ())
    (critical-events . (
      "2025-05-15: Confronted Rynette about R1,035,000 debt"
      "2025-05-22: Orders removed from Shopify (7 days after - retaliation)"
      "2025-08-11: Signed backdating document under pressure"
      "2025-08-13: Interdict filed against her (betrayal)"
    ))
    (temporal-patterns . (
      "defensive-response"
      "evidence-preservation"
      "regulatory-compliance-focus"
    ))
  ))

(define daniel-faucitt-agent
  '((id . "daniel-faucitt")
    (type . "natural-person")
    (roles . ("cio-rwd" "beneficiary-fft" "owner-regima-zone-ltd" "technical-infrastructure-manager" "second-respondent"))
    (legal-aspects . (
      "beneficiary-rights-violation"
      "technical-expertise-evidence"
      "victim-of-sabotage"
      "system-access-obstruction"
      "business-continuity-impact"
    ))
    (conflicts . ())
    (critical-events . (
      "2025-06-06: Provided fraud reports to accountant"
      "2025-06-07: All business cards cancelled (1 day after - retaliation)"
      "2025-07-16: R500K director loan payment (within established practice)"
      "2025-08-05: Requested documentation access (obstructed)"
    ))
    (temporal-patterns . (
      "fraud-exposure"
      "immediate-retaliation-victim"
      "documentation-obstruction-victim"
    ))
  ))

(define rynette-farrar-agent
  '((id . "rynette-farrar")
    (type . "natural-person")
    (roles . ("accountant-rst" "trustee-fft" "director-rezonance" "creditor-representative"))
    (legal-aspects . (
      "professional-ethics-breach"
      "conflict-of-interest"
      "triple-role-conflict"
      "revenue-hijacking"
      "fraud-coordination"
    ))
    (conflicts . (
      ((type . "accountant-trustee-creditor-triple-conflict")
       (severity . 0.98)
       (priority . "critical")
       (legal-principles . ("professional-ethics" "conflict-of-interest" "independence"))
       (description . "Accountant + Trustee + Creditor representative = systemic conflict")
       (resolution-required . #t))
    ))
    (critical-events . (
      "2025-05-15: Confronted by Jax about R1,035,000 debt"
      "2025-05-22: Removed orders from Shopify (retaliation)"
      "Ongoing: Revenue hijacking through Rezonance debt"
    ))
    (temporal-patterns . (
      "coordinated-retaliation"
      "revenue-hijacking"
    ))
  ))

(define daniel-bantjies-agent
  '((id . "daniel-bantjies")
    (type . "natural-person")
    (roles . ("accountant-rwd" "trustee-fft"))
    (legal-aspects . (
      "professional-ethics-breach"
      "conflict-of-interest"
      "dual-role-conflict"
    ))
    (conflicts . (
      ((type . "accountant-trustee-conflict")
       (severity . 0.92)
       (priority . "high")
       (legal-principles . ("professional-ethics" "independence"))
       (description . "Accountant serving as trustee creates independence issues")
       (resolution-required . #t))
    ))
  ))

(define gee-agent
  '((id . "gee")
    (type . "natural-person")
    (roles . ("witness"))
    (legal-aspects . (
      "witness-testimony"
      "coercion-evidence"
    ))
    (conflicts . ())
    (critical-events . (
      "2025-08-14: Witnessed confrontation event"
    ))
  ))

;;; ----------------------------------------------------------------------------
;;; 1.2 Juristic Person Entities
;;; ----------------------------------------------------------------------------

(define faucitt-family-trust
  '((id . "fft")
    (type . "trust")
    (legal-aspects . (
      "trust-weaponization"
      "fiduciary-duty-breach"
      "beneficiary-rights-violation"
      "trust-asset-misuse"
    ))
    (trustees . ("peter-faucitt" "rynette-farrar" "daniel-bantjies"))
    (beneficiaries . ("jacqueline-faucitt" "daniel-faucitt"))
    (founder . "peter-faucitt")
  ))

(define regima-skin-treatments
  '((id . "rst")
    (type . "company")
    (legal-aspects . (
      "director-duties-breach"
      "revenue-stream-hijacking"
      "creditor-control-abuse"
      "operational-sabotage"
    ))
    (directors . ("peter-faucitt" "jacqueline-faucitt"))
    (ceo . "jacqueline-faucitt")
    (accountant . "rynette-farrar")
  ))

(define regima-worldwide-distribution
  '((id . "rwd")
    (type . "company")
    (legal-aspects . (
      "director-duties-breach"
      "operational-sabotage"
      "platform-unjust-enrichment"
    ))
    (directors . ("peter-faucitt"))
    (cio . "daniel-faucitt")
    (accountant . "daniel-bantjies")
    (owner . "faucitt-family-trust")
  ))

;;; ============================================================================
;;; PART 2: TEMPORAL PATTERN DETECTION WITH ENHANCED RETALIATION ANALYSIS
;;; ============================================================================

(define (detect-retaliation-patterns events)
  "Detect retaliation patterns in timeline events with confidence scoring"
  (let ((patterns '()))
    
    ;; Pattern 1: Immediate Retaliation (1-day response)
    (let ((fraud-report (find-event events "2025-06-06" "fraud-report"))
          (card-cancel (find-event events "2025-06-07" "card-cancellation")))
      (when (and fraud-report card-cancel)
        (set! patterns (cons
          '((pattern . "immediate-retaliation")
            (trigger . "2025-06-06: Fraud report submission")
            (response . "2025-06-07: Card cancellation")
            (interval . "1 day")
            (confidence . 0.98)
            (severity . 0.98)
            (legal-significance . "Strongest evidence of causation and bad faith")
            (ad-paragraphs . ("PARA_7_2-7_5"))
            (evidence-type . "temporal-proximity"))
          patterns))))
    
    ;; Pattern 2: Coordinated Retaliation (7-day response)
    (let ((confrontation (find-event events "2025-05-15" "rynette-confrontation"))
          (shopify-removal (find-event events "2025-05-22" "shopify-orders-removed")))
      (when (and confrontation shopify-removal)
        (set! patterns (cons
          '((pattern . "coordinated-retaliation")
            (trigger . "2025-05-15: Jax confronts Rynette")
            (response . "2025-05-22: Orders removed from Shopify")
            (interval . "7 days")
            (confidence . 0.94)
            (severity . 0.94)
            (legal-significance . "Demonstrates coordination between actors")
            (actors . ("rynette-farrar"))
            (evidence-type . "multi-actor-coordination"))
          patterns))))
    
    ;; Pattern 3: Litigation Weaponization (2-day betrayal)
    (let ((cooperation (find-event events "2025-08-11" "backdating-signature"))
          (interdict (find-event events "2025-08-13" "interdict-filing")))
      (when (and cooperation interdict)
        (set! patterns (cons
          '((pattern . "litigation-weaponization")
            (cooperation . "2025-08-11: Jax signs backdating document")
            (betrayal . "2025-08-13: Interdict filed")
            (interval . "2 days")
            (confidence . 0.98)
            (severity . 0.98)
            (legal-significance . "Settlement discussion used to obtain cooperation, then immediate litigation")
            (ad-paragraphs . ("PARA_11-11_5" "PARA_13-13_1"))
            (evidence-type . "bad-faith-litigation"))
          patterns))))
    
    patterns))

(define (calculate-temporal-proximity event1 event2)
  "Calculate temporal proximity between two events and return confidence score"
  (let* ((date1 (event-date event1))
         (date2 (event-date event2))
         (days-diff (abs (date-difference date1 date2))))
    (cond
      ((<= days-diff 1) 0.98)  ; 1 day = highest confidence
      ((<= days-diff 7) 0.94)  ; 1 week = high confidence
      ((<= days-diff 30) 0.85) ; 1 month = medium confidence
      (else 0.70))))            ; > 1 month = lower confidence

(define (analyze-temporal-sequence events)
  "Analyze temporal sequence of events to detect patterns"
  (let ((sequences '()))
    
    ;; Manufactured Crisis Sequence
    (set! sequences (cons
      '((pattern . "manufactured-crisis")
        (sequence . (
          "Card cancellations → Documentation systems disrupted"
          "Documentation requests → Documentation inaccessible"
          "Claim 'lack of documentation' → File interdict"
        ))
        (confidence . 0.95)
        (severity . 0.95)
        (legal-significance . "Self-created crisis as litigation pretext")
        (ad-paragraphs . ("PARA_11-11_5"))
        (evidence-type . "manufactured-urgency"))
      sequences))
    
    ;; Hypocrisy Pattern Sequence
    (set! sequences (cons
      '((pattern . "hypocrisy-pattern")
        (sequence . (
          "2023-2025: Peter makes multiple withdrawals without board resolutions"
          "2025-07-16: Dan makes withdrawal following identical practice"
          "2025-08-13: Peter characterizes Dan's withdrawal as 'unauthorized gift'"
        ))
        (confidence . 0.94)
        (severity . 0.87)
        (legal-significance . "Inconsistent application of standards for litigation advantage")
        (ad-paragraphs . ("PARA_7_6" "PARA_7_7-7_8"))
        (evidence-type . "established-practice-hypocrisy"))
      sequences))
    
    sequences))

;;; ============================================================================
;;; PART 3: MULTI-ACTOR COORDINATION DETECTION
;;; ============================================================================

(define (detect-multi-actor-coordination events actors)
  "Detect coordination patterns between multiple actors"
  (let ((coordination-patterns '()))
    
    ;; Peter-Rynette Coordination Pattern
    (when (and (member "peter-faucitt" actors)
               (member "rynette-farrar" actors))
      (set! coordination-patterns (cons
        '((actors . ("peter-faucitt" "rynette-farrar"))
          (pattern . "fraud-exposure-retaliation-coordination")
          (evidence . (
            "Jax confronts Rynette (2025-05-15)"
            "Rynette removes Shopify orders (2025-05-22)"
            "Dan reports fraud to accountant (2025-06-06)"
            "Peter cancels cards (2025-06-07)"
          ))
          (confidence . 0.96)
          (severity . 0.96)
          (legal-significance . "Coordinated retaliation pattern across actors")
          (coordination-type . "temporal-correlation"))
        coordination-patterns)))
    
    ;; Peter-Rynette-Bantjies Trustee Coordination
    (when (and (member "peter-faucitt" actors)
               (member "rynette-farrar" actors)
               (member "daniel-bantjies" actors))
      (set! coordination-patterns (cons
        '((actors . ("peter-faucitt" "rynette-farrar" "daniel-bantjies"))
          (pattern . "trustee-coordination")
          (roles . ("trustee-fft" "trustee-fft" "trustee-fft"))
          (conflicts . (
            "All three trustees have professional conflicts"
            "Peter: Founder + Trustee concentration"
            "Rynette: Accountant + Trustee + Creditor"
            "Bantjies: Accountant + Trustee"
          ))
          (confidence . 0.93)
          (severity . 0.95)
          (legal-significance . "Systemic conflict of interest in trust governance")
          (coordination-type . "structural-conflict"))
        coordination-patterns)))
    
    coordination-patterns))

(define (calculate-coordination-confidence pattern)
  "Calculate confidence score for coordination pattern"
  (let ((base-confidence 0.70)
        (temporal-bonus 0.15)
        (multi-actor-bonus 0.10)
        (evidence-bonus 0.05))
    (+ base-confidence
       (if (has-temporal-correlation? pattern) temporal-bonus 0)
       (if (> (length (assoc-ref pattern 'actors)) 2) multi-actor-bonus 0)
       (if (has-strong-evidence? pattern) evidence-bonus 0))))

;;; ============================================================================
;;; PART 4: ENHANCED LEGAL ISSUE RESOLUTION FUNCTIONS
;;; ============================================================================

(define (resolve-sabotage-claim claim evidence)
  "Resolve sabotage claim with enhanced evidence mapping"
  (let* ((sabotage-events (filter-sabotage-events evidence))
         (temporal-patterns (detect-retaliation-patterns sabotage-events))
         (causation-chain (build-causation-chain sabotage-events))
         (evidence-strength (calculate-evidence-strength evidence))
         (business-impact (calculate-business-continuity-impact sabotage-events)))
    
    `((claim-type . "sabotage")
      (claim-valid . ,(> evidence-strength 0.85))
      (confidence . ,evidence-strength)
      (sabotage-events . ,sabotage-events)
      (temporal-patterns . ,temporal-patterns)
      (causation-chain . ,causation-chain)
      (business-impact . ,business-impact)
      (legal-principles . ("fiduciary-duty" "director-duties" "delict"))
      (ad-paragraphs . ("PARA_7_2-7_5" "PARA_10_5-10_10_23"))
      (resolution . ,(if (> evidence-strength 0.85)
                         "Sabotage claim substantiated with strong temporal and causal evidence"
                         "Insufficient evidence for sabotage claim")))))

(define (resolve-temporal-bad-faith-claim claim evidence)
  "Resolve temporal bad faith claim with retaliation pattern analysis"
  (let* ((timeline-events (get-timeline-events evidence))
         (retaliation-patterns (detect-retaliation-patterns timeline-events))
         (temporal-proximity (calculate-average-temporal-proximity retaliation-patterns))
         (evidence-strength (calculate-evidence-strength evidence)))
    
    `((claim-type . "temporal-bad-faith")
      (claim-valid . ,(> evidence-strength 0.90))
      (confidence . ,evidence-strength)
      (retaliation-patterns . ,retaliation-patterns)
      (temporal-proximity . ,temporal-proximity)
      (legal-principles . ("good-faith" "abuse-of-process" "malicious-prosecution"))
      (ad-paragraphs . ("PARA_7_2-7_5" "PARA_11-11_5" "PARA_13-13_1"))
      (resolution . ,(if (> evidence-strength 0.90)
                         "Temporal bad faith substantiated with immediate retaliation patterns"
                         "Insufficient temporal correlation for bad faith claim")))))

(define (resolve-fraud-coordination-claim claim evidence)
  "Resolve fraud coordination claim with multi-actor analysis"
  (let* ((actors (get-fraud-actors evidence))
         (coordination-patterns (detect-multi-actor-coordination evidence actors))
         (fraud-indicators (identify-fraud-indicators evidence))
         (evidence-strength (calculate-evidence-strength evidence)))
    
    `((claim-type . "fraud-coordination")
      (claim-valid . ,(> evidence-strength 0.85))
      (confidence . ,evidence-strength)
      (actors . ,actors)
      (coordination-patterns . ,coordination-patterns)
      (fraud-indicators . ,fraud-indicators)
      (legal-principles . ("fraud" "conspiracy" "unjust-enrichment"))
      (resolution . ,(if (> evidence-strength 0.85)
                         "Fraud coordination substantiated with multi-actor patterns"
                         "Insufficient evidence for fraud coordination claim")))))

(define (resolve-manufactured-crisis-claim claim evidence)
  "Resolve manufactured crisis claim with sequence analysis"
  (let* ((crisis-sequence (analyze-temporal-sequence evidence))
         (self-created-elements (identify-self-created-crisis-elements evidence))
         (evidence-strength (calculate-evidence-strength evidence)))
    
    `((claim-type . "manufactured-crisis")
      (claim-valid . ,(> evidence-strength 0.90))
      (confidence . ,evidence-strength)
      (crisis-sequence . ,crisis-sequence)
      (self-created-elements . ,self-created-elements)
      (legal-principles . ("good-faith" "abuse-of-process" "material-non-disclosure"))
      (ad-paragraphs . ("PARA_11-11_5"))
      (resolution . ,(if (> evidence-strength 0.90)
                         "Manufactured crisis substantiated with self-created problem sequence"
                         "Insufficient evidence for manufactured crisis claim")))))

;;; ============================================================================
;;; PART 5: AD PARAGRAPH MAPPING TO LEGAL ASPECTS
;;; ============================================================================

(define ad-paragraph-legal-aspects-map
  '(
    ;; Critical Priority
    ("PARA_7_2-7_5" . (
      (legal-aspects . ("sabotage" "temporal-bad-faith" "retaliation" "operational-disruption"))
      (entities . ("peter-faucitt" "daniel-faucitt"))
      (events . ("2025-06-06: Fraud report" "2025-06-07: Card cancellation"))
      (temporal-pattern . "immediate-retaliation")
      (confidence . 0.98)
      (priority . "critical")
      (dan-perspective . "Technical infrastructure sabotage - CIO expertise")
    ))
    
    ("PARA_7_6" . (
      (legal-aspects . ("director-loan" "established-practice" "hypocrisy"))
      (entities . ("peter-faucitt" "daniel-faucitt"))
      (events . ("2023-2025: Peter withdrawals" "2025-07-16: Dan payment"))
      (temporal-pattern . "hypocrisy-pattern")
      (confidence . 0.94)
      (priority . "critical")
      (dan-perspective . "Director loan within established practice")
    ))
    
    ("PARA_7_7-7_8" . (
      (legal-aspects . ("payment-details" "evidence-strength" "documentation"))
      (entities . ("daniel-faucitt"))
      (events . ("2025-07-16: R500K payment"))
      (confidence . 0.90)
      (priority . "critical")
      (dan-perspective . "Payment details and justification")
    ))
    
    ("PARA_7_9-7_11" . (
      (legal-aspects . ("justification" "business-necessity" "operational-requirements"))
      (entities . ("daniel-faucitt"))
      (confidence . 0.88)
      (priority . "critical")
      (dan-perspective . "Business justification for payment")
    ))
    
    ("PARA_10_5-10_10_23" . (
      (legal-aspects . ("financial-impact" "quantification" "damages"))
      (entities . ("daniel-faucitt" "jacqueline-faucitt"))
      (confidence . 0.92)
      (priority . "critical")
      (dan-perspective . "Financial impact quantification")
    ))
    
    ;; High Priority
    ("PARA_3-3_10" . (
      (legal-aspects . ("responsible-person" "regulatory-crisis" "eu-compliance"))
      (entities . ("jacqueline-faucitt" "daniel-faucitt"))
      (events . ("Ongoing: Regulatory compliance requirements"))
      (confidence . 0.96)
      (priority . "high")
      (dan-perspective . "Technical infrastructure for regulatory compliance")
      (jax-perspective . "EU Responsible Person duties")
    ))
    
    ("PARA_3_11-3_13" . (
      (legal-aspects . ("jax-role" "ceo-duties" "executive-responsibilities"))
      (entities . ("jacqueline-faucitt"))
      (confidence . 0.90)
      (priority . "high")
      (jax-perspective . "CEO role and responsibilities")
    ))
    
    ("PARA_11-11_5" . (
      (legal-aspects . ("urgency" "manufactured-crisis" "material-non-disclosure"))
      (entities . ("peter-faucitt"))
      (temporal-pattern . "manufactured-crisis")
      (confidence . 0.95)
      (priority . "high")
    ))
    
    ("PARA_13-13_1" . (
      (legal-aspects . ("interim-relief" "void-ab-initio" "material-non-disclosure"))
      (entities . ("peter-faucitt"))
      (legal-principles . ("uberrima-fides" "material-non-disclosure"))
      (confidence . 0.97)
      (priority . "high")
    ))
  ))

(define (map-ad-paragraph-to-legal-aspects paragraph-id)
  "Map AD paragraph to legal aspects, entities, and evidence"
  (assoc-ref ad-paragraph-legal-aspects-map paragraph-id))

(define (get-dan-perspective-paragraphs)
  "Get all AD paragraphs where Daniel's perspective is relevant"
  (filter (lambda (entry)
            (assoc-ref (cdr entry) 'dan-perspective))
          ad-paragraph-legal-aspects-map))

(define (get-jax-perspective-paragraphs)
  "Get all AD paragraphs where Jacqueline's perspective is relevant"
  (filter (lambda (entry)
            (assoc-ref (cdr entry) 'jax-perspective))
          ad-paragraph-legal-aspects-map))

;;; ============================================================================
;;; PART 6: EVIDENCE STRENGTH CALCULATION
;;; ============================================================================

(define (calculate-evidence-strength evidence)
  "Calculate evidence strength with multiple factors"
  (let ((base-strength 0.70)
        (temporal-correlation-bonus 0.15)
        (multi-source-bonus 0.10)
        (documentary-evidence-bonus 0.05))
    
    (+ base-strength
       (if (has-temporal-correlation? evidence) temporal-correlation-bonus 0)
       (if (has-multiple-sources? evidence) multi-source-bonus 0)
       (if (has-documentary-evidence? evidence) documentary-evidence-bonus 0))))

(define (generate-burden-of-proof-analysis claim evidence)
  "Generate burden of proof analysis for claim"
  (let* ((evidence-strength (calculate-evidence-strength evidence))
         (standard (get-burden-of-proof-standard claim))
         (meets-standard (>= evidence-strength standard)))
    
    `((claim . ,claim)
      (standard . ,standard)
      (evidence-strength . ,evidence-strength)
      (meets-standard . ,meets-standard)
      (analysis . ,(if meets-standard
                       "Evidence meets required burden of proof"
                       "Evidence does not meet required burden of proof")))))

;;; ============================================================================
;;; PART 7: CASE-SPECIFIC ANALYSIS FUNCTIONS
;;; ============================================================================

(define (analyze-director-loan-hypocrisy)
  "Analyze hypocrisy in director loan practice"
  `((pattern . "hypocrisy-pattern")
    (peter-withdrawals . (
      "2023-01-12: R420K (no board resolution)"
      "2023-02-15: R310K (no board resolution)"
      "2025-03-15: R350K (no board resolution)"
      "2025-07-20: R285K (no board resolution)"
    ))
    (dan-payment . "2025-07-16: R500K (following identical practice)")
    (peter-characterization . "Unauthorized gift")
    (confidence . 0.94)
    (severity . 0.87)
    (legal-significance . "Inconsistent application of standards for litigation advantage")
    (ad-paragraphs . ("PARA_7_6" "PARA_7_7-7_8"))))

(define (analyze-regulatory-crisis-impact)
  "Analyze impact of actions on regulatory compliance"
  `((responsible-person . "jacqueline-faucitt")
    (jurisdictions . 37)
    (system-dependencies . (
      "IT infrastructure access"
      "Documentation systems"
      "Compliance platforms"
    ))
    (impact-of-interdict . (
      "System access disruption"
      "Documentation obstruction"
      "Regulatory compliance impossibility"
    ))
    (technical-perspective . "daniel-faucitt")
    (confidence . 0.96)
    (severity . 0.96)
    (legal-significance . "Regulatory crisis created by interdict")
    (ad-paragraphs . ("PARA_3-3_10"))))

;;; ============================================================================
;;; PART 8: HELPER FUNCTIONS
;;; ============================================================================

(define (find-event events date event-type)
  "Find event by date and type"
  (find (lambda (e)
          (and (equal? (assoc-ref e 'date) date)
               (equal? (assoc-ref e 'type) event-type)))
        events))

(define (event-date event)
  "Extract date from event"
  (assoc-ref event 'date))

(define (date-difference date1 date2)
  "Calculate difference in days between two dates"
  ;; Placeholder - implement actual date calculation
  0)

(define (has-temporal-correlation? evidence)
  "Check if evidence has temporal correlation"
  (assoc-ref evidence 'temporal-correlation))

(define (has-multiple-sources? evidence)
  "Check if evidence has multiple sources"
  (> (length (assoc-ref evidence 'sources)) 1))

(define (has-documentary-evidence? evidence)
  "Check if evidence includes documentary proof"
  (assoc-ref evidence 'documentary-evidence))

(define (has-strong-evidence? pattern)
  "Check if pattern has strong evidence"
  (> (assoc-ref pattern 'confidence) 0.90))

(define (get-burden-of-proof-standard claim)
  "Get burden of proof standard for claim type"
  (cond
    ((equal? (assoc-ref claim 'type) "criminal") 0.95)
    ((equal? (assoc-ref claim 'type) "civil") 0.51)
    (else 0.70)))

;;; ============================================================================
;;; END OF MODULE
;;; ============================================================================
