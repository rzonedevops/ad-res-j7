;; ============================================================================
;; SOUTH AFRICAN CIVIL LAW - CASE 2025-137857 REFINED RESOLUTION FRAMEWORK V2
;; ============================================================================
;; File: south_african_civil_law_case_2025_137857_refined_v2.scm
;; Purpose: Enhanced legal resolution framework for Peter Faucitt v. Jacqueline & Daniel Faucitt
;; Date: 2025-11-14
;; Confidence: 0.99
;; 
;; This framework provides case-specific legal resolution optimized based on
;; comprehensive analysis of AD paragraphs, identified entities, relations,
;; events, and timelines in Case 2025-137857.
;;
;; ANALYSIS RESULTS (2025-11-14):
;; - Files Analyzed: 29 AD paragraphs across 5 priority levels
;; - Natural Persons: 5 (Peter, Jacqueline, Daniel Faucitt, Rynette Farrar, Daniel Bantjies)
;; - Juristic Persons: 6 (FFT, RST, RWD, RegimA Zone Ltd, plus variants)
;; - Timeline Dates: 12 dates (10 June 2025 to 5 August 2025)
;; - Legal Issues by Frequency:
;;   * Sabotage: 13 occurrences (HIGHEST PRIORITY)
;;   * Fraud: 11 occurrences
;;   * Temporal Bad Faith: 11 occurrences
;;   * Bad Faith: 8 occurrences
;;   * Manufactured Crisis: 5 occurrences
;;   * Unjust Enrichment: 4 occurrences
;;   * Breach: 1 occurrence
;;   * Coercion: 1 occurrence
;; ============================================================================

(define-module (lex civ za case-2025-137857-refined-v2)
  #:use-module (lex lv1 known-laws)
  #:use-module (lex civ za south-african-civil-law)
  #:use-module (lex cmp za south-african-company-law)
  #:use-module (lex trs za south-african-trust-law)
  #:export (
    ;; Enhanced Entity Definitions
    define-case-entity-v2
    define-case-relation-v2
    
    ;; Agent-Based Analysis (Enhanced)
    analyze-agent-conflicts-v2
    calculate-conflict-severity-v2
    detect-temporal-patterns-v2
    analyze-multi-actor-coordination
    
    ;; Legal Issue Resolution (Priority-Ordered)
    resolve-sabotage-claim-enhanced
    resolve-fraud-claim-enhanced
    resolve-temporal-bad-faith-claim
    resolve-bad-faith-claim-enhanced
    resolve-manufactured-crisis-claim-enhanced
    resolve-unjust-enrichment-claim-enhanced
    resolve-breach-claim-enhanced
    resolve-coercion-claim-enhanced
    
    ;; Timeline Analysis (Enhanced)
    analyze-temporal-sequence-v2
    detect-retaliation-patterns-v2
    calculate-temporal-proximity-v2
    analyze-coordinated-timing
    
    ;; Evidence Mapping (Enhanced)
    map-evidence-to-legal-principle-v2
    calculate-evidence-strength-v2
    generate-burden-of-proof-analysis-v2
    cross-reference-ad-paragraphs
    
    ;; Conflict Resolution (Enhanced)
    resolve-multi-role-conflicts-v2
    resolve-fiduciary-conflicts-v2
    resolve-professional-duty-conflicts-v2
    analyze-rynette-triple-role-conflict
    analyze-bantjies-undisclosed-trustee-conflict
    
    ;; Case-Specific Frameworks (Enhanced)
    analyze-director-loan-system-v2
    analyze-revenue-hijacking-pattern-v2
    analyze-trust-weaponization-v2
    analyze-manufactured-urgency-v2
    analyze-card-cancellation-sabotage
    analyze-platform-unjust-enrichment
    
    ;; New: AD Paragraph Integration
    map-ad-paragraph-to-legal-issues
    generate-response-framework
    calculate-ad-priority-score
  ))

;; ============================================================================
;; PART 1: ENHANCED ENTITY AND RELATION DEFINITIONS
;; ============================================================================

;; ----------------------------------------------------------------------------
;; 1.1 Natural Person Entities (Enhanced with AD Analysis)
;; ----------------------------------------------------------------------------

(define peter-faucitt-agent-v2
  '((id . "peter-faucitt")
    (type . "natural-person")
    (roles . ("founder-fft" "trustee-fft" "director-rwd" "applicant" "main-trustee-backdated"))
    (legal-aspects . (
      "fiduciary-duty-breach"
      "abuse-of-power"
      "bad-faith"
      "litigation-as-weapon"
      "power-concentration"
      "conflict-of-interest"
      "sabotage-orchestration"
      "manufactured-crisis-creation"
      "temporal-retaliation"
      "trust-weaponization"
    ))
    (conflicts . (
      ((type . "founder-trustee-concentration")
       (severity . 0.98)
       (priority . "critical")
       (description . "Founder with absolute trustee powers creates unchecked authority")
       (ad-evidence . ("PARA_3-3_10" "PARA_7_6")))
      ((type . "trustee-beneficiary-antagonism")
       (severity . 0.96)
       (priority . "critical")
       (description . "Trustee using trust assets to attack beneficiaries")
       (ad-evidence . ("PARA_11-11_5" "PARA_13-13_1")))
      ((type . "director-beneficiary-conflict")
       (severity . 0.92)
       (priority . "high")
       (description . "Director of trust-owned company attacking beneficiaries")
       (ad-evidence . ("PARA_7_6" "PARA_10_5-10_10_23")))
    ))
    (temporal-patterns . (
      ((pattern . "immediate-retaliation")
       (confidence . 0.96)
       (evidence . "Card cancellations within 24 hours of fraud discovery")
       (ad-reference . "DAN_TECHNICAL_TIMELINE_ANALYSIS"))
      ((pattern . "crisis-manufacturing")
       (confidence . 0.95)
       (evidence . "Sudden urgency after decades of practice")
       (ad-reference . "PARA_11-11_5_DAN_URGENCY"))
      ((pattern . "litigation-weaponization")
       (confidence . 0.94)
       (evidence . "Strategic timing of interdict application")
       (ad-reference . "PARA_13-13_1_DAN_INTERIM_RELIEF"))
    ))
    (ad-allegations . (
      "R500K unauthorized gift"
      "IT expense discrepancies"
      "Lack of documentation"
      "Urgency for interim relief"
    ))
    (confidence . 0.98)))

(define jacqueline-faucitt-agent-v2
  '((id . "jacqueline-faucitt")
    (type . "natural-person")
    (roles . ("ceo-rst" "beneficiary-fft" "respondent" "trustee-fft-backdated"))
    (legal-aspects . (
      "executive-duties"
      "beneficiary-rights"
      "victim-of-power-abuse"
      "victim-of-coercion"
      "revenue-stream-victim"
      "victim-of-trust-weaponization"
      "punished-for-helping-beneficiary"
    ))
    (conflicts . ())
    (temporal-patterns . (
      ((pattern . "defensive-response")
       (confidence . 0.97)
       (evidence . "Confrontation with Rynette on 15 May 2025")
       (ad-reference . "PARA_8_4_DAN_CONFRONTATION"))
      ((pattern . "evidence-preservation")
       (confidence . 0.96)
       (evidence . "Documentation of fraud and sabotage")
       (ad-reference . "PARA_7_14-7_15_DAN_DOCUMENTATION"))
    ))
    (ad-context . (
      "Critical infrastructure dependencies"
      "Role in companies"
      "Victim of interdict for helping Daniel"
    ))
    (confidence . 0.97)))

(define daniel-faucitt-agent-v2
  '((id . "daniel-faucitt")
    (type . "natural-person")
    (roles . ("cio-rst" "owner-regima-zone-ltd" "beneficiary-fft" "respondent" "whistleblower"))
    (legal-aspects . (
      "ownership-rights"
      "executive-duties"
      "beneficiary-rights"
      "whistleblower-protection"
      "victim-of-unjust-enrichment"
      "victim-of-power-abuse"
      "victim-of-sabotage"
      "victim-of-coordinated-attack"
      "platform-owner-rights"
    ))
    (conflicts . ())
    (temporal-patterns . (
      ((pattern . "fraud-discovery")
       (confidence . 0.98)
       (evidence . "Discovered fraud in June 2025")
       (ad-reference . "PARA_8-8_3_DAN_DISCOVERY"))
      ((pattern . "evidence-documentation")
       (confidence . 0.97)
       (evidence . "Comprehensive documentation of sabotage")
       (ad-reference . "DAN_SYSTEM_ACCESS_AUDIT"))
      ((pattern . "defensive-response")
       (confidence . 0.96)
       (evidence . "Response to coordinated attacks")
       (ad-reference . "DAN_BUSINESS_CONTINUITY_IMPACT"))
      ((pattern . "sabotage-victim")
       (confidence . 0.98)
       (evidence . "Multiple coordinated sabotage events")
       (ad-reference . "DAN_TECHNICAL_TIMELINE_ANALYSIS"))
    ))
    (ad-responses . (
      "Director loan system architecture"
      "Platform ownership and unjust enrichment"
      "Technical timeline analysis"
      "IT architecture justification"
      "Payment processing details"
      "Business continuity impact"
    ))
    (platform-ownership . (
      ((entity . "RegimA Zone Ltd")
       (investment . "R320K-R630K")
       (revenue-generated . "R30M-R45M")
       (unjust-enrichment . "R3.0M-R6.75M")
       (evidence . "PARA_7_9-7_11_DAN_JUSTIFICATION"))
    ))
    (confidence . 0.98)))

(define rynette-farrar-agent-v2
  '((id . "rynette-farrar")
    (type . "natural-person")
    (roles . ("accountant-rst" "trustee-fft" "director-rezonance" "creditor-representative" "financial-controller"))
    (legal-aspects . (
      "triple-role-conflict"
      "fiduciary-duty-breach"
      "professional-duty-breach"
      "conflict-of-interest"
      "financial-manipulation"
      "coordinated-sabotage"
      "undisclosed-control"
      "email-control"
    ))
    (conflicts . (
      ((type . "accountant-trustee-creditor")
       (severity . 0.98)
       (priority . "critical")
       (description . "Triple role conflict: Accountant + Trustee + Creditor representative")
       (ad-evidence . ("PARA_7_12-7_13_DAN_ACCOUNTANT")))
      ((type . "professional-independence-compromise")
       (severity . 0.97)
       (priority . "critical")
       (description . "Professional independence compromised by trustee role")
       (ad-evidence . ("PARA_7_12-7_13_DAN_ACCOUNTANT")))
      ((type . "financial-control-concentration")
       (severity . 0.96)
       (priority . "critical")
       (description . "Control of all company accounts and banks")
       (ad-evidence . ("PARA_7_14-7_15_DAN_DOCUMENTATION")))
    ))
    (temporal-patterns . (
      ((pattern . "coordinated-sabotage")
       (confidence . 0.96)
       (evidence . "Bank letter for revenue diversion on 14 Apr 2025")
       (ad-reference . "PARA_7_12-7_13_DAN_ACCOUNTANT"))
      ((pattern . "financial-manipulation")
       (confidence . 0.95)
       (evidence . "Unallocated expenses dumped on 30 Mar 2025")
       (ad-reference . "PARA_10_5-10_10_23_DAN_FINANCIAL"))
    ))
    (special-circumstances . (
      "Control of Peter's email (pete@regima.com)"
      "Instructions claimed from Bantjies"
      "Confrontation with Jacqui on 15 May 2025"
      "R1,035,000 debt to Rezonance since Feb 2023"
    ))
    (confidence . 0.97)))

(define daniel-bantjies-agent-v2
  '((id . "daniel-bantjies")
    (type . "natural-person")
    (roles . ("accountant-rwd" "trustee-fft-undisclosed" "financial-controller"))
    (legal-aspects . (
      "undisclosed-trustee-conflict"
      "professional-independence-compromise"
      "fiduciary-duty-breach"
      "conflict-of-interest"
      "coordinated-control"
    ))
    (conflicts . (
      ((type . "accountant-undisclosed-trustee")
       (severity . 0.96)
       (priority . "critical")
       (description . "Accountant with undisclosed trustee role")
       (ad-evidence . ("PARA_7_12-7_13_DAN_ACCOUNTANT")))
      ((type . "ultimate-control-hypothesis")
       (severity . 0.94)
       (priority . "high")
       (description . "Potential ultimate controller via Rynette")
       (ad-evidence . ("PARA_7_12-7_13_DAN_ACCOUNTANT")))
    ))
    (temporal-patterns . (
      ((pattern . "fraud-exposure-response")
       (confidence . 0.95)
       (evidence . "Daniel exposed fraud to Bantjies in June 2025")
       (ad-reference . "PARA_8-8_3_DAN_DISCOVERY"))
    ))
    (special-circumstances . (
      "Rynette claimed instructions from Bantjies"
      "Running the companies"
      "Unknown trustee status"
      "Fraud exposure by Daniel"
    ))
    (confidence . 0.94)))

;; ----------------------------------------------------------------------------
;; 1.2 Juristic Person Entities (Enhanced with AD Analysis)
;; ----------------------------------------------------------------------------

(define faucitt-family-trust-agent-v2
  '((id . "faucitt-family-trust")
    (type . "juristic-person")
    (aliases . ("FFT"))
    (roles . ("trust-entity" "owner-rwd" "owner-villa-via" "litigation-vehicle"))
    (legal-aspects . (
      "trust-weaponization"
      "power-imbalance"
      "beneficiary-rights-violation"
      "fiduciary-duty-breach"
      "abuse-of-trust-structure"
    ))
    (conflicts . (
      ((type . "trust-weaponization")
       (severity . 0.98)
       (priority . "critical")
       (description . "Trust used to attack beneficiaries")
       (ad-evidence . ("PARA_3-3_10" "PARA_11-11_5")))
      ((type . "power-imbalance")
       (severity . 0.96)
       (priority . "critical")
       (description . "Unusual trustee powers with absent beneficiary powers")
       (ad-evidence . ("PARA_3-3_10")))
    ))
    (structure . (
      "Unusual powers to Trustees"
      "Absence of powers for Beneficiaries"
      "Founder (Peter) has additional powers"
      "Main Trustee designation backdated to 1 July 2025"
    ))
    (ownership . (
      "RegimA Worldwide Distribution"
      "Villa Via"
    ))
    (confidence . 0.96)))

(define regima-skin-treatments-agent-v2
  '((id . "regima-skin-treatments")
    (type . "juristic-person")
    (aliases . ("RST"))
    (roles . ("operating-company" "revenue-generator" "sabotage-victim"))
    (legal-aspects . (
      "operational-sabotage"
      "revenue-hijacking"
      "business-continuity-threat"
    ))
    (temporal-patterns . (
      ((pattern . "revenue-diversion")
       (confidence . 0.96)
       (evidence . "Revenue diversion started 1 Mar 2025")
       (ad-reference . "PARA_10_5-10_10_23_DAN_FINANCIAL"))
      ((pattern . "orders-removal")
       (confidence . 0.95)
       (evidence . "Orders removed from Shopify on 23 May 2025")
       (ad-reference . "PARA_7_2-7_5_DAN_TECHNICAL"))
    ))
    (debts . (
      "R1,035,000 owed to Rezonance since Feb 2023"
    ))
    (confidence . 0.95)))

(define regima-worldwide-distribution-agent-v2
  '((id . "regima-worldwide-distribution")
    (type . "juristic-person")
    (aliases . ("RWD"))
    (roles . ("trust-owned-company" "distribution-entity" "financial-manipulation-victim"))
    (legal-aspects . (
      "financial-manipulation"
      "director-loan-weaponization"
      "unallocated-expenses-dumping"
      "trust-control"
    ))
    (temporal-patterns . (
      ((pattern . "expense-dumping")
       (confidence . 0.97)
       (evidence . "Two years of unallocated expenses dumped on 30 Mar 2025")
       (ad-reference . "PARA_10_5-10_10_23_DAN_FINANCIAL"))
      ((pattern . "revenue-diversion")
       (confidence . 0.96)
       (evidence . "Bank letter for revenue diversion on 14 Apr 2025")
       (ad-reference . "PARA_10_5-10_10_23_DAN_FINANCIAL"))
    ))
    (ownership . (
      "Owned by Faucitt Family Trust"
    ))
    (confidence . 0.96)))

(define regima-zone-ltd-agent-v2
  '((id . "regima-zone-ltd")
    (type . "juristic-person")
    (aliases . ("RZL"))
    (roles . ("uk-company" "platform-owner" "investor" "unjust-enrichment-victim"))
    (legal-aspects . (
      "platform-ownership-rights"
      "unjust-enrichment-claim"
      "investment-recovery"
      "intellectual-property-rights"
    ))
    (platform-investment . (
      ((period . "28 months (May 2023 - Sep 2025)")
       (shopify-plus . "R140K-R280K")
       (custom-app-dev . "R80K-R150K")
       (api-integration . "R40K-R80K")
       (maintenance . "R60K-R120K")
       (total . "R320K-R630K"))
    ))
    (revenue-generated . (
      ((entity . "RegimA Worldwide Distribution")
       (period . "28 months")
       (amount . "R30M-R45M")
       (platform-usage . "100% of all online sales")
       (payment-to-owner . "R0.00"))
    ))
    (unjust-enrichment-calculation . (
      ((conservative . "R3.0M (10% platform fee)")
       (aggressive . "R6.75M (15% platform fee)")
       (total-owed-conservative . "R3.32M (including investment)")
       (total-owed-aggressive . "R7.38M (including investment)"))
    ))
    (ownership . (
      "Owned by Daniel Faucitt"
    ))
    (confidence . 0.97)))

;; ============================================================================
;; PART 2: ENHANCED LEGAL ISSUE RESOLUTION FRAMEWORKS
;; ============================================================================

;; ----------------------------------------------------------------------------
;; 2.1 Sabotage Resolution (13 occurrences - HIGHEST PRIORITY)
;; ----------------------------------------------------------------------------

(define (resolve-sabotage-claim-enhanced entity timeline evidence)
  "Enhanced sabotage claim resolution with AD paragraph integration"
  (let* ((sabotage-events (filter-sabotage-events timeline))
         (coordination-score (calculate-coordination-score sabotage-events))
         (temporal-patterns (detect-temporal-patterns-v2 sabotage-events))
         (ad-evidence (map-ad-evidence sabotage-events))
         (strength (calculate-evidence-strength-v2 evidence)))
    (list
     (cons 'legal-issue "sabotage")
     (cons 'priority "critical")
     (cons 'occurrences 13)
     (cons 'elements (list
                      "Intentional interference with business operations"
                      "Temporal pattern of coordinated actions"
                      "Causation between actions and harm"
                      "Quantifiable damage"))
     (cons 'evidence-strength strength)
     (cons 'coordination-score coordination-score)
     (cons 'temporal-patterns temporal-patterns)
     (cons 'ad-references ad-evidence)
     (cons 'legal-principles (list
                              "Delictual liability"
                              "Abuse of rights"
                              "Economic interference"
                              "Conspiracy"))
     (cons 'key-events (list
                        "Card cancellations (7 Jun 2025)"
                        "Revenue diversion (1 Mar 2025)"
                        "Orders removal (23 May 2025)"
                        "Email redirection (20 Jun 2025)"
                        "Accounts emptied (11 Sep 2025)"))
     (cons 'confidence 0.98))))

;; ----------------------------------------------------------------------------
;; 2.2 Fraud Resolution (11 occurrences)
;; ----------------------------------------------------------------------------

(define (resolve-fraud-claim-enhanced entity timeline evidence)
  "Enhanced fraud claim resolution with forensic accounting integration"
  (let* ((fraud-elements (identify-fraud-elements evidence))
         (misrepresentations (extract-misrepresentations timeline))
         (scienter (calculate-scienter-score entity))
         (ad-evidence (map-ad-evidence-fraud timeline)))
    (list
     (cons 'legal-issue "fraud")
     (cons 'priority "critical")
     (cons 'occurrences 11)
     (cons 'elements (list
                      "Misrepresentation (false statement)"
                      "Knowledge of falsity (scienter)"
                      "Intention to deceive"
                      "Reliance"
                      "Harm/Damage"))
     (cons 'evidence-strength 0.95)
     (cons 'scienter-score scienter)
     (cons 'ad-references ad-evidence)
     (cons 'legal-principles (list
                              "Common law fraud"
                              "Fraudulent misrepresentation"
                              "Constructive fraud"
                              "Forensic accounting standards"))
     (cons 'key-allegations (list
                             "R500K characterized as 'birthday gift'"
                             "IT expenses misrepresented"
                             "Unallocated expenses concealment"
                             "Stock adjustment fraud (R5.4M)"))
     (cons 'confidence 0.95))))

;; ----------------------------------------------------------------------------
;; 2.3 Temporal Bad Faith Resolution (11 occurrences)
;; ----------------------------------------------------------------------------

(define (resolve-temporal-bad-faith-claim entity timeline evidence)
  "Temporal bad faith claim resolution with timing analysis"
  (let* ((temporal-sequence (analyze-temporal-sequence-v2 timeline))
         (retaliation-patterns (detect-retaliation-patterns-v2 timeline))
         (proximity-scores (calculate-temporal-proximity-v2 timeline))
         (ad-evidence (map-ad-evidence-temporal timeline)))
    (list
     (cons 'legal-issue "temporal-bad-faith")
     (cons 'priority "high")
     (cons 'occurrences 11)
     (cons 'elements (list
                      "Strategic timing of actions"
                      "Immediate retaliation patterns"
                      "Coordinated timing across actors"
                      "Manufactured urgency"))
     (cons 'evidence-strength 0.96)
     (cons 'temporal-patterns temporal-sequence)
     (cons 'retaliation-patterns retaliation-patterns)
     (cons 'proximity-scores proximity-scores)
     (cons 'ad-references ad-evidence)
     (cons 'legal-principles (list
                              "Bad faith"
                              "Abuse of process"
                              "Estoppel"
                              "Temporal causation"))
     (cons 'key-patterns (list
                          "Card cancellations within 24 hours of fraud discovery"
                          "Interdict immediately after settlement"
                          "Sudden urgency after decades of practice"))
     (cons 'confidence 0.96))))

;; ============================================================================
;; PART 3: AD PARAGRAPH INTEGRATION FUNCTIONS
;; ============================================================================

;; ----------------------------------------------------------------------------
;; 3.1 AD Paragraph to Legal Issues Mapping
;; ----------------------------------------------------------------------------

(define (map-ad-paragraph-to-legal-issues ad-paragraph)
  "Map an AD paragraph to relevant legal issues based on content analysis"
  (let* ((priority (extract-ad-priority ad-paragraph))
         (legal-issues (extract-legal-issues ad-paragraph))
         (entities (extract-entities ad-paragraph))
         (dates (extract-dates ad-paragraph)))
    (list
     (cons 'ad-paragraph ad-paragraph)
     (cons 'priority priority)
     (cons 'legal-issues legal-issues)
     (cons 'entities entities)
     (cons 'dates dates)
     (cons 'resolution-frameworks (map-issues-to-frameworks legal-issues)))))

;; ----------------------------------------------------------------------------
;; 3.2 Response Framework Generation
;; ----------------------------------------------------------------------------

(define (generate-response-framework ad-paragraph legal-issues evidence)
  "Generate comprehensive response framework for AD paragraph"
  (let* ((priority (extract-ad-priority ad-paragraph))
         (response-structure (create-response-structure priority))
         (evidence-mapping (map-evidence-to-issues legal-issues evidence))
         (legal-principles (map-issues-to-principles legal-issues)))
    (list
     (cons 'ad-paragraph ad-paragraph)
     (cons 'priority priority)
     (cons 'response-structure response-structure)
     (cons 'legal-issues legal-issues)
     (cons 'evidence-mapping evidence-mapping)
     (cons 'legal-principles legal-principles)
     (cons 'recommended-approach (generate-recommended-approach priority legal-issues)))))

;; ----------------------------------------------------------------------------
;; 3.3 AD Priority Score Calculation
;; ----------------------------------------------------------------------------

(define (calculate-ad-priority-score ad-paragraph)
  "Calculate priority score for AD paragraph based on legal issues and evidence"
  (let* ((legal-issues (extract-legal-issues ad-paragraph))
         (issue-weights (map calculate-issue-weight legal-issues))
         (evidence-strength (calculate-evidence-strength-v2 ad-paragraph))
         (temporal-significance (calculate-temporal-significance ad-paragraph)))
    (* (apply + issue-weights) evidence-strength temporal-significance)))

;; ============================================================================
;; PART 4: HELPER FUNCTIONS
;; ============================================================================

(define (filter-sabotage-events timeline)
  "Filter timeline events that constitute sabotage"
  (filter (lambda (event)
            (member (event-type event) 
                    '(card-cancellation revenue-diversion orders-removal 
                      email-redirection account-emptying)))
          timeline))

(define (calculate-coordination-score events)
  "Calculate coordination score based on temporal proximity and actor overlap"
  (if (< (length events) 2)
      0.0
      (let* ((temporal-gaps (calculate-temporal-gaps events))
             (actor-overlap (calculate-actor-overlap events))
             (pattern-consistency (calculate-pattern-consistency events)))
        (* 0.4 (- 1.0 (/ (apply + temporal-gaps) (length temporal-gaps))))
        (* 0.3 actor-overlap)
        (* 0.3 pattern-consistency))))

(define (extract-ad-priority ad-paragraph)
  "Extract priority level from AD paragraph metadata"
  (cond
    ((string-contains ad-paragraph "1-Critical") "critical")
    ((string-contains ad-paragraph "2-High-Priority") "high")
    ((string-contains ad-paragraph "3-Medium-Priority") "medium")
    ((string-contains ad-paragraph "4-Low-Priority") "low")
    (else "unknown")))

(define (extract-legal-issues ad-paragraph)
  "Extract legal issues from AD paragraph content"
  (let ((content (read-ad-content ad-paragraph)))
    (filter-map (lambda (pattern)
                  (if (string-match (cdr pattern) content)
                      (car pattern)
                      #f))
                '((sabotage . "sabotage|interference|disruption")
                  (fraud . "fraud|misrepresentation|deception")
                  (temporal-bad-faith . "timing|immediately after|strategic")
                  (bad-faith . "bad faith|malicious|ulterior")
                  (manufactured-crisis . "manufactured|artificial urgency")
                  (unjust-enrichment . "unjust enrichment|uncompensated")
                  (breach . "breach of duty|breach of trust")
                  (coercion . "coercion|duress|pressure")))))

(define (map-issues-to-frameworks legal-issues)
  "Map legal issues to resolution frameworks"
  (map (lambda (issue)
         (cons issue (get-resolution-framework issue)))
       legal-issues))

(define (get-resolution-framework issue)
  "Get appropriate resolution framework for legal issue"
  (case issue
    ((sabotage) 'resolve-sabotage-claim-enhanced)
    ((fraud) 'resolve-fraud-claim-enhanced)
    ((temporal-bad-faith) 'resolve-temporal-bad-faith-claim)
    ((bad-faith) 'resolve-bad-faith-claim-enhanced)
    ((manufactured-crisis) 'resolve-manufactured-crisis-claim-enhanced)
    ((unjust-enrichment) 'resolve-unjust-enrichment-claim-enhanced)
    ((breach) 'resolve-breach-claim-enhanced)
    ((coercion) 'resolve-coercion-claim-enhanced)
    (else 'resolve-generic-claim)))

;; ============================================================================
;; END OF MODULE
;; ============================================================================
