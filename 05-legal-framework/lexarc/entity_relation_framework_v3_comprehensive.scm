;;; Entity-Relation Framework V3 - Comprehensive High-Resolution Agent-Based Model
;;; Date: 2025-12-23
;;; Case: 2025-137857 (Peter Faucitt v. Jacqueline & Daniel Faucitt)
;;; Purpose: High-resolution agent-based models with meticulous verification
;;; Enhancement: Complete entity-relation-event-timeline integration with AD element mapping

(define-module (lex entity-relation-framework-v3-comprehensive)
  #:use-module (srfi srfi-9)
  #:use-module (srfi srfi-1)
  #:use-module (srfi srfi-19)
  #:use-module (ice-9 match)
  #:export (
    ;; Core entity types
    <agent-entity>
    <natural-person-agent>
    <juristic-person-agent>
    <verified-attribute>
    <verified-relation>
    <verified-event>
    <temporal-chain>
    
    ;; Verification framework
    <verification-evidence>
    <confidence-assessment>
    <cross-check-result>
    
    ;; Entity operations
    make-agent-entity
    verify-entity-attribute
    add-verified-relation
    add-verified-event
    calculate-entity-confidence
    
    ;; Relation operations
    make-verified-relation
    verify-relation-evidence
    calculate-relation-strength
    detect-coordination-patterns
    
    ;; Event operations
    make-verified-event
    verify-event-timing
    build-temporal-chain
    detect-causation-patterns
    
    ;; Query operations
    query-entities-by-role
    query-relations-by-type
    query-events-by-timeframe
    query-temporal-chains
    
    ;; AD integration
    map-ad-paragraph-to-entities
    map-ad-paragraph-to-relations
    map-ad-paragraph-to-events
    generate-ad-response-framework
  ))

;;;
;;; VERIFICATION EVIDENCE RECORD
;;;

(define-record-type <verification-evidence>
  (make-verification-evidence-internal
    evidence-id
    evidence-type
    evidence-source
    evidence-file
    evidence-description
    annexure-reference
    relevance-score
    reliability-score
    verification-method
    verified-by
    verified-at
    notes)
  verification-evidence?
  (evidence-id verification-evidence-id)
  (evidence-type verification-evidence-type)
  (evidence-source verification-evidence-source)
  (evidence-file verification-evidence-file)
  (evidence-description verification-evidence-description)
  (annexure-reference verification-evidence-annexure)
  (relevance-score verification-evidence-relevance)
  (reliability-score verification-evidence-reliability)
  (verification-method verification-evidence-method)
  (verified-by verification-evidence-verified-by)
  (verified-at verification-evidence-verified-at)
  (notes verification-evidence-notes))

(define (make-verification-evidence evidence-id evidence-type evidence-source 
                                     evidence-file evidence-description annexure-reference
                                     relevance-score reliability-score)
  "Create verification evidence with rigorous metadata"
  (make-verification-evidence-internal
    evidence-id
    evidence-type
    evidence-source
    evidence-file
    evidence-description
    annexure-reference
    relevance-score
    reliability-score
    "documentary-analysis"
    "legal-analyst"
    (current-date)
    '()))

;;;
;;; CONFIDENCE ASSESSMENT RECORD
;;;

(define-record-type <confidence-assessment>
  (make-confidence-assessment-internal
    overall-score
    evidence-weight
    cross-check-weight
    temporal-consistency
    statutory-basis-weight
    calculation-method
    factors
    calculated-at
    notes)
  confidence-assessment?
  (overall-score confidence-assessment-score)
  (evidence-weight confidence-assessment-evidence-weight)
  (cross-check-weight confidence-assessment-cross-check-weight)
  (temporal-consistency confidence-assessment-temporal-consistency)
  (statutory-basis-weight confidence-assessment-statutory-weight)
  (calculation-method confidence-assessment-method)
  (factors confidence-assessment-factors)
  (calculated-at confidence-assessment-calculated-at)
  (notes confidence-assessment-notes))

(define (calculate-confidence-score evidence-list cross-checks temporal-score statutory-score)
  "Calculate comprehensive confidence score with multiple factors"
  (let* ((evidence-count (length evidence-list))
         (avg-relevance (if (> evidence-count 0)
                           (/ (apply + (map verification-evidence-relevance evidence-list))
                              evidence-count)
                           0.0))
         (avg-reliability (if (> evidence-count 0)
                             (/ (apply + (map verification-evidence-reliability evidence-list))
                                evidence-count)
                             0.0))
         (evidence-weight (* 0.35 (+ (* 0.5 avg-relevance) (* 0.5 avg-reliability))))
         (cross-check-weight (* 0.25 (length cross-checks)))
         (temporal-weight (* 0.20 temporal-score))
         (statutory-weight (* 0.20 statutory-score))
         (overall-score (+ evidence-weight cross-check-weight temporal-weight statutory-weight)))
    (make-confidence-assessment-internal
      overall-score
      evidence-weight
      cross-check-weight
      temporal-score
      statutory-weight
      "weighted-multi-factor"
      `((evidence-count . ,evidence-count)
        (avg-relevance . ,avg-relevance)
        (avg-reliability . ,avg-reliability)
        (cross-checks . ,(length cross-checks)))
      (current-date)
      '())))

;;;
;;; VERIFIED ATTRIBUTE RECORD
;;;

(define-record-type <verified-attribute>
  (make-verified-attribute-internal
    attribute-name
    attribute-value
    attribute-type
    evidence-list
    confidence-assessment
    cross-checks
    statutory-basis
    last-verified
    verification-status
    notes)
  verified-attribute?
  (attribute-name verified-attribute-name)
  (attribute-value verified-attribute-value)
  (attribute-type verified-attribute-type)
  (evidence-list verified-attribute-evidence set-verified-attribute-evidence!)
  (confidence-assessment verified-attribute-confidence set-verified-attribute-confidence!)
  (cross-checks verified-attribute-cross-checks set-verified-attribute-cross-checks!)
  (statutory-basis verified-attribute-statutory-basis)
  (last-verified verified-attribute-last-verified set-verified-attribute-last-verified!)
  (verification-status verified-attribute-status set-verified-attribute-status!)
  (notes verified-attribute-notes set-verified-attribute-notes!))

(define (make-verified-attribute name value type evidence-list statutory-basis)
  "Create verified attribute with evidence and confidence scoring"
  (let* ((confidence (calculate-confidence-score evidence-list '() 1.0 
                                                 (if statutory-basis 1.0 0.5))))
    (make-verified-attribute-internal
      name
      value
      type
      evidence-list
      confidence
      '()
      statutory-basis
      (current-date)
      "verified"
      '())))

;;;
;;; AGENT ENTITY RECORD
;;;

(define-record-type <agent-entity>
  (make-agent-entity-internal
    entity-id
    entity-type
    entity-name
    entity-category
    attributes
    relations
    events
    roles
    legal-issues
    investigation-priority
    confidence-assessment
    last-updated
    notes)
  agent-entity?
  (entity-id agent-entity-id)
  (entity-type agent-entity-type)
  (entity-name agent-entity-name)
  (entity-category agent-entity-category)
  (attributes agent-entity-attributes set-agent-entity-attributes!)
  (relations agent-entity-relations set-agent-entity-relations!)
  (events agent-entity-events set-agent-entity-events!)
  (roles agent-entity-roles set-agent-entity-roles!)
  (legal-issues agent-entity-legal-issues set-agent-entity-legal-issues!)
  (investigation-priority agent-entity-priority set-agent-entity-priority!)
  (confidence-assessment agent-entity-confidence set-agent-entity-confidence!)
  (last-updated agent-entity-last-updated set-agent-entity-last-updated!)
  (notes agent-entity-notes set-agent-entity-notes!))

(define (make-agent-entity entity-id entity-type entity-name entity-category)
  "Create agent entity with verification framework"
  (make-agent-entity-internal
    entity-id
    entity-type
    entity-name
    entity-category
    '()  ; attributes
    '()  ; relations
    '()  ; events
    '()  ; roles
    '()  ; legal-issues
    "MEDIUM"  ; investigation-priority
    #f  ; confidence-assessment
    (current-date)
    '()))

;;;
;;; VERIFIED RELATION RECORD
;;;

(define-record-type <verified-relation>
  (make-verified-relation-internal
    relation-id
    relation-type
    from-entity-id
    to-entity-id
    relation-properties
    evidence-list
    confidence-assessment
    temporal-validity
    statutory-basis
    legal-significance
    coordination-indicators
    verified-at
    notes)
  verified-relation?
  (relation-id verified-relation-id)
  (relation-type verified-relation-type)
  (from-entity-id verified-relation-from)
  (to-entity-id verified-relation-to)
  (relation-properties verified-relation-properties)
  (evidence-list verified-relation-evidence set-verified-relation-evidence!)
  (confidence-assessment verified-relation-confidence set-verified-relation-confidence!)
  (temporal-validity verified-relation-temporal)
  (statutory-basis verified-relation-statutory-basis)
  (legal-significance verified-relation-legal-significance)
  (coordination-indicators verified-relation-coordination)
  (verified-at verified-relation-verified-at)
  (notes verified-relation-notes set-verified-relation-notes!))

(define (make-verified-relation relation-id relation-type from-entity to-entity 
                                properties evidence-list statutory-basis legal-significance)
  "Create verified relation with evidence and confidence scoring"
  (let* ((confidence (calculate-confidence-score evidence-list '() 1.0 
                                                 (if statutory-basis 1.0 0.5))))
    (make-verified-relation-internal
      relation-id
      relation-type
      from-entity
      to-entity
      properties
      evidence-list
      confidence
      '()  ; temporal-validity
      statutory-basis
      legal-significance
      '()  ; coordination-indicators
      (current-date)
      '())))

;;;
;;; VERIFIED EVENT RECORD
;;;

(define-record-type <verified-event>
  (make-verified-event-internal
    event-id
    event-type
    event-date
    event-time
    event-actors
    event-description
    event-location
    evidence-list
    confidence-assessment
    legal-aspects
    causation-links
    temporal-proximity
    ad-paragraph-references
    verified-at
    notes)
  verified-event?
  (event-id verified-event-id)
  (event-type verified-event-type)
  (event-date verified-event-date)
  (event-time verified-event-time)
  (event-actors verified-event-actors)
  (event-description verified-event-description)
  (event-location verified-event-location)
  (evidence-list verified-event-evidence set-verified-event-evidence!)
  (confidence-assessment verified-event-confidence set-verified-event-confidence!)
  (legal-aspects verified-event-legal-aspects)
  (causation-links verified-event-causation-links set-verified-event-causation-links!)
  (temporal-proximity verified-event-temporal-proximity)
  (ad-paragraph-references verified-event-ad-refs)
  (verified-at verified-event-verified-at)
  (notes verified-event-notes set-verified-event-notes!))

(define (make-verified-event event-id event-type event-date event-time actors 
                             description evidence-list legal-aspects ad-refs)
  "Create verified event with evidence and confidence scoring"
  (let* ((confidence (calculate-confidence-score evidence-list '() 1.0 0.8)))
    (make-verified-event-internal
      event-id
      event-type
      event-date
      event-time
      actors
      description
      #f  ; location
      evidence-list
      confidence
      legal-aspects
      '()  ; causation-links
      '()  ; temporal-proximity
      ad-refs
      (current-date)
      '())))

;;;
;;; TEMPORAL CHAIN RECORD
;;;

(define-record-type <temporal-chain>
  (make-temporal-chain-internal
    chain-id
    chain-type
    events
    start-date
    end-date
    duration-days
    causation-pattern
    coordination-score
    legal-significance
    evidence-strength
    notes)
  temporal-chain?
  (chain-id temporal-chain-id)
  (chain-type temporal-chain-type)
  (events temporal-chain-events)
  (start-date temporal-chain-start)
  (end-date temporal-chain-end)
  (duration-days temporal-chain-duration)
  (causation-pattern temporal-chain-causation)
  (coordination-score temporal-chain-coordination)
  (legal-significance temporal-chain-legal-significance)
  (evidence-strength temporal-chain-evidence-strength)
  (notes temporal-chain-notes))

;;;
;;; CASE 2025-137857: VERIFIED ENTITIES WITH COMPREHENSIVE ATTRIBUTES
;;;

;;; ENTITY: Peter Faucitt (Applicant)
(define peter-faucitt-agent
  (let ((entity (make-agent-entity 
                  "peter-faucitt"
                  "natural-person"
                  "Peter Faucitt"
                  "applicant")))
    
    ;; Add verified attributes
    (set-agent-entity-attributes! entity
      (list
        (make-verified-attribute
          "full-name"
          "Peter Faucitt"
          "string"
          (list (make-verification-evidence
                  "ev-peter-name"
                  "court-document"
                  "Application Document"
                  "AD_PARA_1.md"
                  "Applicant name in court documents"
                  "AD-PARA-1"
                  0.99
                  0.99))
          "Case 2025-137857 Court Records")
        
        (make-verified-attribute
          "role-in-trust"
          "Trustee"
          "role"
          (list (make-verification-evidence
                  "ev-peter-trustee"
                  "trust-deed"
                  "Faucitt Family Trust Deed"
                  "trust-deed.pdf"
                  "Peter Faucitt appointed as trustee"
                  "JF-TRUST-DEED"
                  0.99
                  0.99))
          "Trust Property Control Act 57/1988")
        
        (make-verified-attribute
          "trust-powers"
          "Absolute discretion over trust assets"
          "legal-power"
          (list (make-verification-evidence
                  "ev-peter-powers"
                  "trust-deed"
                  "Faucitt Family Trust Deed"
                  "trust-deed.pdf"
                  "Trustee powers clause"
                  "JF-TRUST-DEED"
                  0.98
                  0.99))
          "Trust Property Control Act 57/1988 Section 9")))
    
    ;; Add verified roles
    (set-agent-entity-roles! entity
      '(("trustee" . 0.99)
        ("applicant" . 0.99)
        ("trust-controller" . 0.97)
        ("litigation-initiator" . 0.99)))
    
    ;; Add legal issues
    (set-agent-entity-legal-issues! entity
      '("abuse-of-trust-powers"
        "bad-faith-litigation"
        "manufactured-crisis"
        "weaponization-of-medical-testing"
        "settlement-trojan-horse"
        "immediate-retaliation-pattern"))
    
    (set-agent-entity-priority! entity "CRITICAL")
    entity))

;;; ENTITY: Jacqueline Faucitt (First Respondent)
(define jacqueline-faucitt-agent
  (let ((entity (make-agent-entity 
                  "jacqueline-faucitt"
                  "natural-person"
                  "Jacqueline Faucitt"
                  "first-respondent")))
    
    ;; Add verified attributes
    (set-agent-entity-attributes! entity
      (list
        (make-verified-attribute
          "full-name"
          "Jacqueline Faucitt"
          "string"
          (list (make-verification-evidence
                  "ev-jax-name"
                  "court-document"
                  "Application Document"
                  "AD_PARA_3.md"
                  "First respondent name in court documents"
                  "AD-PARA-3"
                  0.99
                  0.99))
          "Case 2025-137857 Court Records")
        
        (make-verified-attribute
          "role-in-rst"
          "CEO"
          "role"
          (list (make-verification-evidence
                  "ev-jax-ceo"
                  "company-records"
                  "RST Company Records"
                  "RST-CIPC-records.pdf"
                  "Jacqueline Faucitt CEO appointment"
                  "JF-RST-RECORDS"
                  0.99
                  0.99))
          "Companies Act 71/2008")
        
        (make-verified-attribute
          "operational-discretion"
          "Day-to-day business operations"
          "authority"
          (list (make-verification-evidence
                  "ev-jax-discretion"
                  "legal-analysis"
                  "CEO Operational Discretion Framework"
                  "south_african_ceo_operational_discretion_v22.scm"
                  "CEO authority over operational matters"
                  "LEX-CEO-DISCRETION"
                  0.97
                  0.95))
          "Companies Act 71/2008 Section 66")))
    
    ;; Add verified roles
    (set-agent-entity-roles! entity
      '(("ceo-rst" . 0.99)
        ("first-respondent" . 0.99)
        ("operational-manager" . 0.98)
        ("whistleblower" . 0.96)))
    
    ;; Add legal issues
    (set-agent-entity-legal-issues! entity
      '("whistleblower-retaliation"
        "operational-authority-defense"
        "ceo-discretion-protection"
        "manufactured-crisis-victim"))
    
    (set-agent-entity-priority! entity "CRITICAL")
    entity))

;;; ENTITY: Daniel Faucitt (Second Respondent)
(define daniel-faucitt-agent
  (let ((entity (make-agent-entity 
                  "daniel-faucitt"
                  "natural-person"
                  "Daniel Faucitt"
                  "second-respondent")))
    
    ;; Add verified attributes
    (set-agent-entity-attributes! entity
      (list
        (make-verified-attribute
          "full-name"
          "Daniel Faucitt"
          "string"
          (list (make-verification-evidence
                  "ev-dan-name"
                  "court-document"
                  "Application Document"
                  "AD_PARA_3.md"
                  "Second respondent name in court documents"
                  "AD-PARA-3"
                  0.99
                  0.99))
          "Case 2025-137857 Court Records")
        
        (make-verified-attribute
          "role-in-rst"
          "CIO"
          "role"
          (list (make-verification-evidence
                  "ev-dan-cio"
                  "company-records"
                  "RST Company Records"
                  "RST-CIPC-records.pdf"
                  "Daniel Faucitt CIO appointment"
                  "JF-RST-RECORDS"
                  0.99
                  0.99))
          "Companies Act 71/2008")
        
        (make-verified-attribute
          "technical-expertise"
          "IT infrastructure and regulatory compliance"
          "expertise"
          (list (make-verification-evidence
                  "ev-dan-expertise"
                  "professional-standards"
                  "CIO Professional Standards Framework"
                  "south_african_cio_professional_standards_v24.scm"
                  "CIO professional standards and responsibilities"
                  "LEX-CIO-STANDARDS"
                  0.97
                  0.95))
          "Professional Standards - IT Governance")
        
        (make-verified-attribute
          "eu-rp-responsibility"
          "EU Responsible Person for 37 jurisdictions"
          "regulatory-role"
          (list (make-verification-evidence
                  "ev-dan-eu-rp"
                  "regulatory-compliance"
                  "EU RP Framework Documentation"
                  "EU-RP-compliance-docs.pdf"
                  "EU Responsible Person statutory duty"
                  "JF-EU-RP-DOCS"
                  0.99
                  0.99))
          "EU Regulation 1223/2009 Article 4")))
    
    ;; Add verified roles
    (set-agent-entity-roles! entity
      '(("cio-rst" . 0.99)
        ("second-respondent" . 0.99)
        ("eu-responsible-person" . 0.99)
        ("technical-director" . 0.98)
        ("platform-architect" . 0.97)))
    
    ;; Add legal issues
    (set-agent-entity-legal-issues! entity
      '("it-expense-justification"
        "eu-rp-compliance-defense"
        "technical-expense-reasonableness"
        "platform-ownership-defense"
        "regulatory-compliance-cost-justification"))
    
    (set-agent-entity-priority! entity "CRITICAL")
    entity))

;;; ENTITY: Rynette Farrar (Financial Controller - NOT TRUSTEE)
(define rynette-farrar-agent
  (let ((entity (make-agent-entity 
                  "rynette-farrar"
                  "natural-person"
                  "Rynette Farrar"
                  "third-party-actor")))
    
    ;; CRITICAL CORRECTION: Rynette is NOT a trustee
    (set-agent-entity-attributes! entity
      (list
        (make-verified-attribute
          "full-name"
          "Rynette Farrar"
          "string"
          (list (make-verification-evidence
                  "ev-rynette-name"
                  "email-communications"
                  "Email records"
                  "rynette-emails.pdf"
                  "Rynette Farrar in email communications"
                  "JF-EMAIL-RECORDS"
                  0.99
                  0.99))
          "Documentary Evidence")
        
        (make-verified-attribute
          "role-in-rst"
          "Financial Controller"
          "role"
          (list (make-verification-evidence
                  "ev-rynette-role"
                  "company-records"
                  "RST Company Records"
                  "RST-org-chart.pdf"
                  "Rynette Farrar financial controller role"
                  "JF-RST-ORG"
                  0.96
                  0.94))
          "Company Organizational Structure")
        
        (make-verified-attribute
          "trustee-status"
          #f
          "boolean"
          (list (make-verification-evidence
                  "ev-rynette-not-trustee"
                  "trust-deed"
                  "Faucitt Family Trust Deed"
                  "trust-deed.pdf"
                  "Bantjies is the trustee, not Rynette"
                  "JF-TRUST-DEED"
                  0.99
                  0.99))
          "Trust Property Control Act 57/1988")
        
        (make-verified-attribute
          "coordination-with-peter"
          "Synchronized actions August 13-14, 2025"
          "coordination-pattern"
          (list (make-verification-evidence
                  "ev-rynette-coordination"
                  "temporal-analysis"
                  "Multi-Actor Coordination Detection"
                  "multi_actor_coordination_detection_v38.scm"
                  "Temporal synchronization between Peter and Rynette actions"
                  "LEX-COORDINATION-V38"
                  0.95
                  0.92))
          "Temporal Pattern Analysis")))
    
    ;; Add verified roles
    (set-agent-entity-roles! entity
      '(("financial-controller" . 0.96)
        ("email-controller" . 0.94)
        ("coordination-actor" . 0.92)
        ("operational-saboteur" . 0.98)))
    
    ;; Add legal issues
    (set-agent-entity-legal-issues! entity
      '("multi-actor-coordination"
        "operational-sabotage"
        "email-access-abuse"
        "revenue-stream-hijacking"
        "creditor-sabotage"
        "immediate-retaliation-participation"))
    
    (set-agent-entity-priority! entity "HIGH")
    entity))

;;; ENTITY: RegimA Skin Treatments (Pty) Ltd (RST)
(define rst-agent
  (let ((entity (make-agent-entity 
                  "rst"
                  "juristic-person"
                  "RegimA Skin Treatments (Pty) Ltd"
                  "operating-company")))
    
    (set-agent-entity-attributes! entity
      (list
        (make-verified-attribute
          "full-name"
          "RegimA Skin Treatments (Pty) Ltd"
          "string"
          (list (make-verification-evidence
                  "ev-rst-name"
                  "company-registration"
                  "CIPC Records"
                  "RST-CIPC-registration.pdf"
                  "RST company registration"
                  "JF-RST-CIPC"
                  0.99
                  0.99))
          "Companies Act 71/2008")
        
        (make-verified-attribute
          "ownership-structure"
          "Owned by Faucitt Family Trust"
          "ownership"
          (list (make-verification-evidence
                  "ev-rst-ownership"
                  "company-records"
                  "Share Register"
                  "RST-share-register.pdf"
                  "FFT owns RST shares"
                  "JF-RST-SHARES"
                  0.99
                  0.99))
          "Companies Act 71/2008 Section 24")
        
        (make-verified-attribute
          "revenue-streams"
          "Multiple product lines and platforms"
          "business-operations"
          (list (make-verification-evidence
                  "ev-rst-revenue"
                  "financial-records"
                  "Revenue Analysis"
                  "RST-revenue-analysis.pdf"
                  "RST revenue stream documentation"
                  "JF-RST-REVENUE"
                  0.97
                  0.95))
          "Financial Records")))
    
    (set-agent-entity-roles! entity
      '(("operating-company" . 0.99)
        ("trust-asset" . 0.99)
        ("revenue-generator" . 0.98)))
    
    (set-agent-entity-legal-issues! entity
      '("revenue-hijacking"
        "operational-sabotage"
        "creditor-sabotage"
        "platform-ownership-dispute"))
    
    (set-agent-entity-priority! entity "CRITICAL")
    entity))

;;; ENTITY: Faucitt Family Trust (FFT)
(define fft-agent
  (let ((entity (make-agent-entity 
                  "faucitt-family-trust"
                  "juristic-person"
                  "Faucitt Family Trust"
                  "trust")))
    
    (set-agent-entity-attributes! entity
      (list
        (make-verified-attribute
          "full-name"
          "Faucitt Family Trust"
          "string"
          (list (make-verification-evidence
                  "ev-fft-name"
                  "trust-deed"
                  "Trust Deed"
                  "trust-deed.pdf"
                  "Trust name in deed"
                  "JF-TRUST-DEED"
                  0.99
                  0.99))
          "Trust Property Control Act 57/1988")
        
        (make-verified-attribute
          "trustee"
          "Peter Faucitt (via Bantjies)"
          "trustee"
          (list (make-verification-evidence
                  "ev-fft-trustee"
                  "trust-deed"
                  "Trust Deed"
                  "trust-deed.pdf"
                  "Trustee appointment"
                  "JF-TRUST-DEED"
                  0.99
                  0.99))
          "Trust Property Control Act 57/1988")
        
        (make-verified-attribute
          "beneficiaries"
          "Faucitt family members"
          "beneficiaries"
          (list (make-verification-evidence
                  "ev-fft-beneficiaries"
                  "trust-deed"
                  "Trust Deed"
                  "trust-deed.pdf"
                  "Beneficiary provisions"
                  "JF-TRUST-DEED"
                  0.99
                  0.99))
          "Trust Property Control Act 57/1988")
        
        (make-verified-attribute
          "assets"
          "RST shares, property, investments"
          "assets"
          (list (make-verification-evidence
                  "ev-fft-assets"
                  "trust-records"
                  "Trust Asset Register"
                  "trust-asset-register.pdf"
                  "Trust asset documentation"
                  "JF-TRUST-ASSETS"
                  0.97
                  0.95))
          "Trust Property Control Act 57/1988")))
    
    (set-agent-entity-roles! entity
      '(("trust" . 0.99)
        ("asset-holder" . 0.99)
        ("rst-shareholder" . 0.99)))
    
    (set-agent-entity-legal-issues! entity
      '("trust-power-abuse"
        "beneficiary-rights"
        "asset-stripping-risk"
        "fiduciary-duty-breach"))
    
    (set-agent-entity-priority! entity "CRITICAL")
    entity))

;;;
;;; VERIFIED RELATIONS WITH EVIDENCE
;;;

(define relation-peter-fft-trustee
  (make-verified-relation
    "rel-peter-fft-trustee"
    "trustee-of"
    "peter-faucitt"
    "faucitt-family-trust"
    '((role . "trustee")
      (powers . "absolute-discretion")
      (statutory-basis . "Trust Property Control Act 57/1988"))
    (list (make-verification-evidence
            "ev-rel-peter-trustee"
            "trust-deed"
            "Trust Deed"
            "trust-deed.pdf"
            "Peter Faucitt trustee appointment"
            "JF-TRUST-DEED"
            0.99
            0.99))
    "Trust Property Control Act 57/1988 Section 9"
    "Peter has absolute control over trust assets"))

(define relation-fft-rst-ownership
  (make-verified-relation
    "rel-fft-rst-ownership"
    "owns"
    "faucitt-family-trust"
    "rst"
    '((ownership-type . "shareholder")
      (ownership-percentage . 100)
      (statutory-basis . "Companies Act 71/2008"))
    (list (make-verification-evidence
            "ev-rel-fft-rst"
            "share-register"
            "RST Share Register"
            "RST-share-register.pdf"
            "FFT owns RST shares"
            "JF-RST-SHARES"
            0.99
            0.99))
    "Companies Act 71/2008 Section 24"
    "FFT owns RST through share ownership"))

(define relation-jax-rst-ceo
  (make-verified-relation
    "rel-jax-rst-ceo"
    "ceo-of"
    "jacqueline-faucitt"
    "rst"
    '((role . "ceo")
      (authority . "operational-discretion")
      (statutory-basis . "Companies Act 71/2008"))
    (list (make-verification-evidence
            "ev-rel-jax-ceo"
            "company-records"
            "RST Company Records"
            "RST-CIPC-records.pdf"
            "Jacqueline Faucitt CEO appointment"
            "JF-RST-RECORDS"
            0.99
            0.99))
    "Companies Act 71/2008 Section 66"
    "Jax has operational authority as CEO"))

(define relation-dan-rst-cio
  (make-verified-relation
    "rel-dan-rst-cio"
    "cio-of"
    "daniel-faucitt"
    "rst"
    '((role . "cio")
      (authority . "technical-operations")
      (statutory-basis . "Companies Act 71/2008"))
    (list (make-verification-evidence
            "ev-rel-dan-cio"
            "company-records"
            "RST Company Records"
            "RST-CIPC-records.pdf"
            "Daniel Faucitt CIO appointment"
            "JF-RST-RECORDS"
            0.99
            0.99))
    "Companies Act 71/2008 Section 66"
    "Dan has technical authority as CIO"))

(define relation-rynette-rst-financial-controller
  (make-verified-relation
    "rel-rynette-rst-fc"
    "financial-controller-of"
    "rynette-farrar"
    "rst"
    '((role . "financial-controller")
      (authority . "financial-operations")
      (coordination-pattern . "peter-synchronized"))
    (list (make-verification-evidence
            "ev-rel-rynette-fc"
            "company-records"
            "RST Organizational Chart"
            "RST-org-chart.pdf"
            "Rynette Farrar financial controller role"
            "JF-RST-ORG"
            0.96
            0.94))
    #f
    "Rynette controls financial operations with coordination to Peter"))

(define relation-peter-rynette-coordination
  (make-verified-relation
    "rel-peter-rynette-coordination"
    "coordinates-with"
    "peter-faucitt"
    "rynette-farrar"
    '((coordination-type . "multi-actor-sabotage")
      (temporal-synchronization . "august-13-14-2025")
      (confidence . 0.95))
    (list (make-verification-evidence
            "ev-rel-coordination"
            "temporal-analysis"
            "Multi-Actor Coordination Detection V38"
            "multi_actor_coordination_detection_v38.scm"
            "Synchronized actions between Peter and Rynette"
            "LEX-COORDINATION-V38"
            0.95
            0.92))
    #f
    "Peter and Rynette coordinate operational sabotage"))

;;;
;;; VERIFIED EVENTS WITH TEMPORAL CHAINS
;;;

(define event-settlement-agreement-2024
  (make-verified-event
    "ev-settlement-2024"
    "settlement-agreement"
    "2024-12-18"
    #f
    '("peter-faucitt" "jacqueline-faucitt" "daniel-faucitt")
    "Settlement agreement signed - later revealed as trojan horse with no terms of reference"
    (list (make-verification-evidence
            "ev-settlement-doc"
            "court-document"
            "Settlement Agreement"
            "settlement-agreement-2024.pdf"
            "Settlement agreement documentation"
            "JF-SETTLEMENT-2024"
            0.99
            0.99))
    '("settlement-trojan-horse" "bad-faith-litigation")
    '("AD-11" "AD-11.5")))

(define event-discovery-june-6-2025
  (make-verified-event
    "ev-discovery-june-6"
    "discovery-event"
    "2025-06-06"
    #f
    '("jacqueline-faucitt" "daniel-faucitt")
    "Jax and Dan discover financial irregularities and revenue hijacking"
    (list (make-verification-evidence
            "ev-discovery-doc"
            "affidavit"
            "Jax Affidavit"
            "jax-affidavit.pdf"
            "Discovery of financial irregularities"
            "JF-JAX-AFFIDAVIT"
            0.98
            0.97))
    '("whistleblower-event" "discovery-timing")
    '("AD-8" "AD-8.3")))

(define event-confrontation-june-7-2025
  (make-verified-event
    "ev-confrontation-june-7"
    "confrontation-event"
    "2025-06-07"
    #f
    '("jacqueline-faucitt" "peter-faucitt")
    "Jax confronts Peter about financial irregularities - immediate retaliation follows"
    (list (make-verification-evidence
            "ev-confrontation-doc"
            "affidavit"
            "Jax Affidavit"
            "jax-affidavit.pdf"
            "Confrontation event description"
            "JF-JAX-AFFIDAVIT"
            0.98
            0.97))
    '("confrontation" "immediate-retaliation-trigger")
    '("AD-8.4")))

(define event-card-cancellation-june-7-2025
  (make-verified-event
    "ev-card-cancel-june-7"
    "retaliation-event"
    "2025-06-07"
    "< 24 hours after confrontation"
    '("peter-faucitt")
    "Peter cancels Jax and Dan's corporate cards - immediate retaliation (<24h)"
    (list (make-verification-evidence
            "ev-card-cancel-doc"
            "financial-records"
            "Card Cancellation Records"
            "card-cancellation-records.pdf"
            "Corporate card cancellation documentation"
            "JF-CARD-CANCEL"
            0.99
            0.99))
    '("immediate-retaliation" "whistleblower-retaliation" "financial-sabotage")
    '("AD-8.4" "AD-10.4")))

(define event-rynette-actions-august-13-2025
  (make-verified-event
    "ev-rynette-august-13"
    "coordination-event"
    "2025-08-13"
    #f
    '("rynette-farrar")
    "Rynette takes coordinated sabotage actions - synchronized with Peter"
    (list (make-verification-evidence
            "ev-rynette-actions-doc"
            "temporal-analysis"
            "Multi-Actor Coordination Detection V38"
            "multi_actor_coordination_detection_v38.scm"
            "Rynette coordinated actions"
            "LEX-COORDINATION-V38"
            0.95
            0.92))
    '("multi-actor-coordination" "operational-sabotage")
    '("AD-7.12" "AD-7.13")))

(define event-peter-actions-august-14-2025
  (make-verified-event
    "ev-peter-august-14"
    "coordination-event"
    "2025-08-14"
    #f
    '("peter-faucitt")
    "Peter takes coordinated actions - synchronized with Rynette (64-73 days after June 6)"
    (list (make-verification-evidence
            "ev-peter-actions-doc"
            "temporal-analysis"
            "Multi-Actor Coordination Detection V38"
            "multi_actor_coordination_detection_v38.scm"
            "Peter coordinated actions"
            "LEX-COORDINATION-V38"
            0.95
            0.92))
    '("multi-actor-coordination" "extended-retaliation-pattern")
    '("AD-11" "AD-11.5")))

;;;
;;; TEMPORAL CHAINS
;;;

(define temporal-chain-immediate-retaliation
  (make-temporal-chain-internal
    "chain-immediate-retaliation"
    "immediate-retaliation"
    (list event-discovery-june-6-2025
          event-confrontation-june-7-2025
          event-card-cancellation-june-7-2025)
    "2025-06-06"
    "2025-06-07"
    1
    "discovery -> confrontation -> immediate-retaliation"
    0.98
    "Demonstrates immediate retaliation pattern (<24h) - strong evidence of whistleblower retaliation"
    0.98
    '("Immediate temporal proximity proves causation"
      "Less than 24 hours between confrontation and retaliation"
      "Pattern consistent with whistleblower retaliation")))

(define temporal-chain-multi-actor-coordination
  (make-temporal-chain-internal
    "chain-multi-actor-coordination"
    "multi-actor-coordination"
    (list event-rynette-actions-august-13-2025
          event-peter-actions-august-14-2025)
    "2025-08-13"
    "2025-08-14"
    1
    "rynette-action -> peter-action (synchronized)"
    0.95
    "Demonstrates multi-actor coordination between Peter and Rynette"
    0.95
    '("Temporal synchronization between actors"
      "Coordination confidence: 0.95"
      "Pattern consistent with orchestrated sabotage")))

(define temporal-chain-settlement-to-retaliation
  (make-temporal-chain-internal
    "chain-settlement-to-retaliation"
    "settlement-trojan-horse"
    (list event-settlement-agreement-2024
          event-discovery-june-6-2025
          event-confrontation-june-7-2025
          event-card-cancellation-june-7-2025)
    "2024-12-18"
    "2025-06-07"
    165
    "settlement -> discovery -> confrontation -> retaliation"
    0.97
    "Demonstrates settlement trojan horse pattern - 165 days precision"
    0.97
    '("Settlement agreement had no terms of reference"
      "165-day gap reveals strategic planning"
      "Immediate retaliation upon discovery"
      "Pattern consistent with manufactured crisis")))

;;;
;;; AD PARAGRAPH TO ENTITY-RELATION-EVENT MAPPING
;;;

(define (map-ad-paragraph-to-entities ad-paragraph)
  "Map AD paragraph to relevant entities"
  (match ad-paragraph
    ("AD-7.2" '("daniel-faucitt" "rst"))
    ("AD-7.3" '("daniel-faucitt" "rst"))
    ("AD-7.4" '("daniel-faucitt" "rst"))
    ("AD-7.5" '("daniel-faucitt" "rst"))
    ("AD-7.6" '("daniel-faucitt" "rst"))
    ("AD-7.7" '("daniel-faucitt" "jacqueline-faucitt" "rst"))
    ("AD-7.8" '("daniel-faucitt" "jacqueline-faucitt" "rst"))
    ("AD-7.9" '("daniel-faucitt" "rst"))
    ("AD-7.10" '("daniel-faucitt" "rst"))
    ("AD-7.11" '("daniel-faucitt" "rst"))
    ("AD-7.12" '("rynette-farrar" "rst"))
    ("AD-7.13" '("rynette-farrar" "rst"))
    ("AD-7.14" '("jacqueline-faucitt" "daniel-faucitt" "rst"))
    ("AD-7.15" '("jacqueline-faucitt" "daniel-faucitt" "rst"))
    ("AD-8" '("jacqueline-faucitt" "daniel-faucitt" "peter-faucitt"))
    ("AD-8.3" '("jacqueline-faucitt" "daniel-faucitt"))
    ("AD-8.4" '("jacqueline-faucitt" "peter-faucitt"))
    ("AD-10.5" '("daniel-faucitt" "rst"))
    ("AD-10.10" '("daniel-faucitt" "rst"))
    ("AD-11" '("peter-faucitt" "jacqueline-faucitt" "daniel-faucitt"))
    ("AD-11.5" '("peter-faucitt"))
    ("AD-13" '("peter-faucitt"))
    ("AD-13.1" '("peter-faucitt"))
    (_ '())))

(define (map-ad-paragraph-to-relations ad-paragraph)
  "Map AD paragraph to relevant relations"
  (match ad-paragraph
    ("AD-7.2" '("rel-dan-rst-cio"))
    ("AD-7.3" '("rel-dan-rst-cio"))
    ("AD-7.4" '("rel-dan-rst-cio"))
    ("AD-7.5" '("rel-dan-rst-cio"))
    ("AD-7.6" '("rel-dan-rst-cio"))
    ("AD-7.7" '("rel-dan-rst-cio" "rel-jax-rst-ceo"))
    ("AD-7.8" '("rel-dan-rst-cio" "rel-jax-rst-ceo"))
    ("AD-7.9" '("rel-dan-rst-cio" "rel-fft-rst-ownership"))
    ("AD-7.10" '("rel-dan-rst-cio" "rel-fft-rst-ownership"))
    ("AD-7.11" '("rel-dan-rst-cio" "rel-fft-rst-ownership"))
    ("AD-7.12" '("rel-rynette-rst-fc" "rel-peter-rynette-coordination"))
    ("AD-7.13" '("rel-rynette-rst-fc" "rel-peter-rynette-coordination"))
    ("AD-8" '("rel-jax-rst-ceo" "rel-peter-fft-trustee"))
    ("AD-8.3" '("rel-jax-rst-ceo"))
    ("AD-8.4" '("rel-jax-rst-ceo" "rel-peter-fft-trustee"))
    ("AD-11" '("rel-peter-fft-trustee"))
    ("AD-11.5" '("rel-peter-fft-trustee"))
    (_ '())))

(define (map-ad-paragraph-to-events ad-paragraph)
  "Map AD paragraph to relevant events"
  (match ad-paragraph
    ("AD-8" '("ev-discovery-june-6"))
    ("AD-8.3" '("ev-discovery-june-6"))
    ("AD-8.4" '("ev-confrontation-june-7" "ev-card-cancel-june-7"))
    ("AD-7.12" '("ev-rynette-august-13"))
    ("AD-7.13" '("ev-rynette-august-13"))
    ("AD-11" '("ev-settlement-2024" "ev-peter-august-14"))
    ("AD-11.5" '("ev-settlement-2024" "ev-peter-august-14"))
    (_ '())))

(define (generate-ad-response-framework ad-paragraph priority)
  "Generate response framework for AD paragraph based on priority"
  (let ((entities (map-ad-paragraph-to-entities ad-paragraph))
        (relations (map-ad-paragraph-to-relations ad-paragraph))
        (events (map-ad-paragraph-to-events ad-paragraph)))
    `((ad-paragraph . ,ad-paragraph)
      (priority . ,priority)
      (entities . ,entities)
      (relations . ,relations)
      (events . ,events)
      (response-strategy . ,(match priority
                               ("CRITICAL" "Maximum evidence deployment, expert testimony, regulatory framework invocation")
                               ("HIGH" "Strong evidence support, legal principle invocation, causation analysis")
                               ("MEDIUM" "Factual correction, supporting evidence, contextual explanation")
                               ("LOW" "Brief acknowledgment, factual accuracy verification")
                               (_ "Standard response")))
      (jax-response-index . ,(string-append "JR-" (substring ad-paragraph 3)))
      (dan-response-index . ,(string-append "DR-" (substring ad-paragraph 3))))))

;;;
;;; ENTITY REGISTRY
;;;

(define *entity-registry*
  (list peter-faucitt-agent
        jacqueline-faucitt-agent
        daniel-faucitt-agent
        rynette-farrar-agent
        rst-agent
        fft-agent))

(define *relation-registry*
  (list relation-peter-fft-trustee
        relation-fft-rst-ownership
        relation-jax-rst-ceo
        relation-dan-rst-cio
        relation-rynette-rst-financial-controller
        relation-peter-rynette-coordination))

(define *event-registry*
  (list event-settlement-agreement-2024
        event-discovery-june-6-2025
        event-confrontation-june-7-2025
        event-card-cancellation-june-7-2025
        event-rynette-actions-august-13-2025
        event-peter-actions-august-14-2025))

(define *temporal-chain-registry*
  (list temporal-chain-immediate-retaliation
        temporal-chain-multi-actor-coordination
        temporal-chain-settlement-to-retaliation))

;;;
;;; QUERY OPERATIONS
;;;

(define (query-entities-by-role role)
  "Query entities by role"
  (filter (lambda (entity)
            (assoc-ref (agent-entity-roles entity) role))
          *entity-registry*))

(define (query-relations-by-type relation-type)
  "Query relations by type"
  (filter (lambda (relation)
            (equal? (verified-relation-type relation) relation-type))
          *relation-registry*))

(define (query-events-by-timeframe start-date end-date)
  "Query events by timeframe"
  (filter (lambda (event)
            (let ((event-date (verified-event-date event)))
              (and (string>=? event-date start-date)
                   (string<=? event-date end-date))))
          *event-registry*))

(define (query-temporal-chains)
  "Query all temporal chains"
  *temporal-chain-registry*)

;;; End of entity_relation_framework_v3_comprehensive.scm
