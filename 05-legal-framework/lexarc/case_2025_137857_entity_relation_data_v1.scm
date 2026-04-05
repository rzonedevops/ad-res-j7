;;; case_2025_137857_entity_relation_data_v1.scm
;;; Entity and Relationship Population Data for Case 2025-137857
;;; Date: 2025-12-19
;;; Purpose: Populate multi-agent entity-relation framework with case data

(define-module (lex case-2025-137857-entity-relation-data-v1)
  #:use-module (lex entity-agent-modeling-v1)
  #:use-module (lex relation-tracking-temporal-v1)
  #:export (
    populate-case-entities
    populate-case-relationships
    get-case-entity-registry
    get-case-relationship-registry
  ))

;;;
;;; ENTITY POPULATION DATA
;;;

(define case-entities
  '(;; NATURAL PERSONS
    
    ((entity-id . "daniel-faucitt")
     (entity-type . "natural-person")
     (full-name . "Daniel Faucitt")
     (roles . ("director" "cio" "eu-responsible-person" "whistleblower" "platform-owner"))
     (professional-qualifications . ("CIO"))
     (expertise-areas . ("technical" "regulatory-compliance" "platform-development"))
     (agent-capabilities . (
       ("legal-decision-making" . 0.95)
       ("operational-control" . 0.98)
       ("technical-expertise" . 0.99)
       ("regulatory-compliance" . 0.97)
       ("whistleblower-protection" . 0.98)))
     (agent-constraints . (
       ("fiduciary-duties" . "high")
       ("regulatory-restrictions" . "high")
       ("operational-dependencies" . "critical")))
     (behavioral-patterns . (
       ("whistleblowing" . ("frequent" . 0.98))
       ("fraud-detection" . ("frequent" . 0.97))
       ("technical-decision-making" . ("constant" . 0.99)))))
    
    ((entity-id . "jacqueline-faucitt")
     (entity-type . "natural-person")
     (full-name . "Jacqueline Faucitt")
     (known-aliases . ("Jax" "Jacqui"))
     (roles . ("director" "ceo" "eu-responsible-person" "trustee" "information-officer"))
     (professional-qualifications . ("CEO" "POPIA Information Officer"))
     (expertise-areas . ("operational-management" "regulatory-compliance" "brand-management"))
     (agent-capabilities . (
       ("legal-decision-making" . 0.96)
       ("operational-control" . 0.98)
       ("strategic-planning" . 0.95)
       ("regulatory-compliance" . 0.97)
       ("relationship-building" . 0.94)))
     (agent-constraints . (
       ("fiduciary-duties" . "high")
       ("regulatory-restrictions" . "high")
       ("manufactured-crisis-victim" . "high")))
     (behavioral-patterns . (
       ("operational-decision-making" . ("constant" . 0.98))
       ("regulatory-compliance" . ("constant" . 0.97))
       ("crisis-management" . ("frequent" . 0.95)))))
    
    ((entity-id . "peter-faucitt")
     (entity-type . "natural-person")
     (full-name . "Peter Faucitt")
     (roles . ("applicant" "trust-founder" "creditor-alleged"))
     (agent-capabilities . (
       ("legal-intimidation" . 0.98)
       ("trust-power-abuse" . 0.94)
       ("bad-faith-litigation" . 0.98)))
     (agent-constraints . (
       ("fiduciary-duties" . "high")
       ("material-non-disclosure" . "critical")))
     (behavioral-patterns . (
       ("retaliation" . ("frequent" . 0.98))
       ("legal-intimidation" . ("frequent" . 0.95))
       ("settlement-trojan-horse" . ("occasional" . 0.98)))))
    
    ((entity-id . "rynette-farrar")
     (entity-type . "natural-person")
     (full-name . "Rynette Farrar")
     (roles . ("financial-controller" "coordination-actor"))
     (agent-capabilities . (
       ("operational-sabotage" . 0.98)
       ("financial-control" . 0.95)
       ("coordination" . 0.92)))
     (agent-constraints . (
       ("accountability" . "low")))
     (behavioral-patterns . (
       ("card-cancellation" . ("occasional" . 0.98))
       ("coordination-with-peter" . ("frequent" . 0.94))
       ("financial-manipulation" . ("frequent" . 0.90)))))
    
    ((entity-id . "bantjies")
     (entity-type . "natural-person")
     (full-name . "Bantjies")
     (roles . ("trustee" "accountant"))
     (professional-qualifications . ("Accountant"))
     (agent-capabilities . (
       ("financial-oversight" . 0.95)
       ("trust-administration" . 0.90)
       ("accounting" . 0.98)))
     (agent-constraints . (
       ("fiduciary-duties" . "high")
       ("professional-duties" . "high")))
     (behavioral-patterns . (
       ("trust-administration" . ("constant" . 0.90))
       ("accounting-services" . ("constant" . 0.98)))))
    
    ;; JURISTIC PERSONS
    
    ((entity-id . "rwd-pty-ltd")
     (entity-type . "juristic-person")
     (legal-name . "RegimA Worldwide Distribution (Pty) Ltd")
     (entity-subtype . "company")
     (jurisdiction . "South Africa")
     (directors . ("daniel-faucitt" "jacqueline-faucitt"))
     (shareholders . (("faucitt-family-trust" . 100)))
     (business-activities . ("e-commerce" "distribution" "platform-operations"))
     (operational-status . "active")
     (agent-capabilities . (
       ("contract-execution" . 0.95)
       ("revenue-generation" . 0.90)
       ("regulatory-compliance" . 0.97)))
     (agent-constraints . (
       ("regulatory-compliance" . "high")
       ("system-dependencies" . "critical")
       ("expense-dumping-victim" . "high")))
     (system-dependencies . ("shopify-platform" "payment-processing" "cloud-infrastructure")))
    
    ((entity-id . "rst-pty-ltd")
     (entity-type . "juristic-person")
     (legal-name . "RegimA Skin Treatments (Pty) Ltd")
     (entity-subtype . "company")
     (jurisdiction . "South Africa")
     (directors . ("daniel-faucitt" "jacqueline-faucitt"))
     (shareholders . (("daniel-faucitt" . 50) ("jacqueline-faucitt" . 50)))
     (business-activities . ("product-development" "regulatory-compliance" "brand-management"))
     (operational-status . "active")
     (agent-capabilities . (
       ("contract-execution" . 0.95)
       ("regulatory-compliance" . 0.98)
       ("product-development" . 0.96)))
     (agent-constraints . (
       ("regulatory-compliance" . "critical")
       ("eu-rp-requirements" . "critical")))
     (system-dependencies . ("cpnp-portal" "regulatory-correspondence" "compliance-documentation")))
    
    ((entity-id . "rzl-ltd")
     (entity-type . "juristic-person")
     (legal-name . "RegimA Zone Ltd")
     (entity-subtype . "company")
     (jurisdiction . "United Kingdom")
     (directors . ("daniel-faucitt"))
     (shareholders . (("daniel-faucitt" . 100)))
     (business-activities . ("platform-development" "infrastructure-investment" "technical-services"))
     (operational-status . "active")
     (agent-capabilities . (
       ("platform-ownership" . 0.98)
       ("technical-infrastructure" . 0.99)
       ("investment-capacity" . 0.95)))
     (investment-profile . (
       ("total-investment" . 1050000)
       ("development-costs" . 750000)
       ("infrastructure-costs" . 300000)))
     (operational-model . (
       ("admin-fee" . 0.001)
       ("industry-benchmark" . 0.005-0.020)
       ("below-market-factor" . 5-20))))
    
    ((entity-id . "slg-pty-ltd")
     (entity-type . "juristic-person")
     (legal-name . "Strategic Logistics Group (Pty) Ltd")
     (entity-subtype . "company")
     (jurisdiction . "South Africa")
     (directors . ("daniel-faucitt" "jacqueline-faucitt" "peter-faucitt"))
     (shareholders . (("daniel-faucitt" . 33) ("jacqueline-faucitt" . 33) ("peter-faucitt" . 33)))
     (business-activities . ("logistics" "procurement" "supply-chain-management"))
     (operational-status . "active")
     (agent-capabilities . (
       ("procurement" . 0.90)
       ("logistics-management" . 0.88)))
     (financial-issues . (
       ("stock-adjustment-loss" . 5400000)
       ("stock-disappearance" . "unexplained"))))
    
    ((entity-id . "faucitt-family-trust")
     (entity-type . "juristic-person")
     (legal-name . "Faucitt Family Trust")
     (entity-subtype . "trust")
     (jurisdiction . "South Africa")
     (trustees . ("peter-faucitt" "jacqueline-faucitt" "bantjies"))
     (beneficiaries . ("daniel-faucitt" "jacqueline-faucitt"))
     (founder . "peter-faucitt")
     (trust-assets . ("rwd-pty-ltd" "villa-via"))
     (governance-structure . (
       ("trustee-powers" . "extensive")
       ("beneficiary-powers" . "minimal")
       ("founder-powers" . "additional")))
     (agent-capabilities . (
       ("asset-ownership" . 0.95)
       ("trust-administration" . 0.85)))
     (agent-constraints . (
       ("fiduciary-duties" . "critical")
       ("beneficiary-protection" . "critical")))
     (alleged-misuse . (
       ("power-abuse" . 0.94)
       ("beneficiary-harm" . 0.96)
       ("material-non-disclosure" . 0.99))))
    
    ((entity-id . "villa-via")
     (entity-type . "juristic-person")
     (legal-name . "Villa Via")
     (entity-subtype . "company")
     (jurisdiction . "South Africa")
     (shareholders . (("peter-faucitt" . 50) ("jacqueline-faucitt" . 50)))
     (business-activities . ("property-ownership" "rent-extraction"))
     (operational-status . "active")
     (agent-capabilities . (
       ("rent-collection" . 0.95)
       ("profit-extraction" . 0.98)))
     (profit-extraction . (
       ("rent-profit-margin" . 0.86)
       ("annual-rent-extraction" . "significant")
       ("excluded-from-group-framing" . #t))))))

;;;
;;; RELATIONSHIP POPULATION DATA
;;;

(define case-relationships
  '(;; OWNERSHIP RELATIONS
    
    ((entity-a-id . "daniel-faucitt")
     (entity-b-id . "rst-pty-ltd")
     (relationship-type . shareholder)
     (entity-a-role . "shareholder")
     (entity-b-role . "company")
     (start-date . "2010-01-01")
     (ownership-percentage . 50)
     (confidence . 0.98)
     (evidence . ("CIPC registration" "Share certificates")))
    
    ((entity-a-id . "jacqueline-faucitt")
     (entity-b-id . "rst-pty-ltd")
     (relationship-type . shareholder)
     (entity-a-role . "shareholder")
     (entity-b-role . "company")
     (start-date . "2010-01-01")
     (ownership-percentage . 50)
     (confidence . 0.98)
     (evidence . ("CIPC registration" "Share certificates")))
    
    ((entity-a-id . "daniel-faucitt")
     (entity-b-id . "rzl-ltd")
     (relationship-type . shareholder)
     (entity-a-role . "shareholder")
     (entity-b-role . "company")
     (start-date . "2015-01-01")
     (ownership-percentage . 100)
     (confidence . 0.99)
     (evidence . ("Companies House registration" "Platform ownership documentation")))
    
    ((entity-a-id . "daniel-faucitt")
     (entity-b-id . "slg-pty-ltd")
     (relationship-type . shareholder)
     (entity-a-role . "shareholder")
     (entity-b-role . "company")
     (start-date . "2015-01-01")
     (ownership-percentage . 33)
     (confidence . 0.96)
     (evidence . ("CIPC registration")))
    
    ((entity-a-id . "jacqueline-faucitt")
     (entity-b-id . "slg-pty-ltd")
     (relationship-type . shareholder)
     (entity-a-role . "shareholder")
     (entity-b-role . "company")
     (start-date . "2015-01-01")
     (ownership-percentage . 33)
     (confidence . 0.96)
     (evidence . ("CIPC registration")))
    
    ((entity-a-id . "peter-faucitt")
     (entity-b-id . "slg-pty-ltd")
     (relationship-type . shareholder)
     (entity-a-role . "shareholder")
     (entity-b-role . "company")
     (start-date . "2015-01-01")
     (ownership-percentage . 33)
     (confidence . 0.96)
     (evidence . ("CIPC registration")))
    
    ((entity-a-id . "faucitt-family-trust")
     (entity-b-id . "rwd-pty-ltd")
     (relationship-type . shareholder)
     (entity-a-role . "shareholder")
     (entity-b-role . "company")
     (start-date . "2010-01-01")
     (ownership-percentage . 100)
     (confidence . 0.98)
     (evidence . ("Trust deed" "CIPC registration")))
    
    ((entity-a-id . "faucitt-family-trust")
     (entity-b-id . "villa-via")
     (relationship-type . shareholder)
     (entity-a-role . "shareholder")
     (entity-b-role . "company")
     (start-date . "2015-01-01")
     (ownership-percentage . 100)
     (confidence . 0.95)
     (evidence . ("Trust deed")))
    
    ;; FIDUCIARY RELATIONS
    
    ((entity-a-id . "peter-faucitt")
     (entity-b-id . "faucitt-family-trust")
     (relationship-type . trustee-trust)
     (entity-a-role . "trustee-founder")
     (entity-b-role . "trust")
     (start-date . "2010-01-01")
     (confidence . 0.98)
     (evidence . ("Trust deed"))
     (fiduciary-duties . ("duty-of-care" "duty-of-loyalty" "duty-of-disclosure"))
     (breach-indicators . (
       ("material-non-disclosure" . 0.99)
       ("bad-faith-litigation" . 0.98)
       ("beneficiary-harm" . 0.96))))
    
    ((entity-a-id . "jacqueline-faucitt")
     (entity-b-id . "faucitt-family-trust")
     (relationship-type . trustee-trust)
     (entity-a-role . "trustee")
     (entity-b-role . "trust")
     (start-date . "2010-01-01")
     (end-date . "2025-08-13")
     (confidence . 0.98)
     (evidence . ("Trust deed" "Interdict filing"))
     (termination-reason . "Included in interdict for helping beneficiary Daniel"))
    
    ((entity-a-id . "bantjies")
     (entity-b-id . "faucitt-family-trust")
     (relationship-type . trustee-trust)
     (entity-a-role . "trustee")
     (entity-b-role . "trust")
     (start-date . "2024-07-01")
     (confidence . 0.95)
     (evidence . ("Trust appointment documentation"))
     (note . "Appointed by Rynette, unknown to Daniel until fraud report"))
    
    ((entity-a-id . "daniel-faucitt")
     (entity-b-id . "rst-pty-ltd")
     (relationship-type . director-company)
     (entity-a-role . "director")
     (entity-b-role . "company")
     (start-date . "2010-01-01")
     (confidence . 0.98)
     (evidence . ("CIPC registration" "Director appointment")))
    
    ((entity-a-id . "jacqueline-faucitt")
     (entity-b-id . "rst-pty-ltd")
     (relationship-type . director-company)
     (entity-a-role . "director")
     (entity-b-role . "company")
     (start-date . "2010-01-01")
     (confidence . 0.98)
     (evidence . ("CIPC registration" "Director appointment")))
    
    ((entity-a-id . "daniel-faucitt")
     (entity-b-id . "rwd-pty-ltd")
     (relationship-type . director-company)
     (entity-a-role . "director")
     (entity-b-role . "company")
     (start-date . "2010-01-01")
     (confidence . 0.98)
     (evidence . ("CIPC registration" "Director appointment")))
    
    ((entity-a-id . "jacqueline-faucitt")
     (entity-b-id . "rwd-pty-ltd")
     (relationship-type . director-company)
     (entity-a-role . "director")
     (entity-b-role . "company")
     (start-date . "2010-01-01")
     (confidence . 0.98)
     (evidence . ("CIPC registration" "Director appointment")))
    
    ((entity-a-id . "daniel-faucitt")
     (entity-b-id . "slg-pty-ltd")
     (relationship-type . director-company)
     (entity-a-role . "director")
     (entity-b-role . "company")
     (start-date . "2015-01-01")
     (confidence . 0.96)
     (evidence . ("CIPC registration")))
    
    ((entity-a-id . "jacqueline-faucitt")
     (entity-b-id . "slg-pty-ltd")
     (relationship-type . director-company)
     (entity-a-role . "director")
     (entity-b-role . "company")
     (start-date . "2015-01-01")
     (confidence . 0.96)
     (evidence . ("CIPC registration")))
    
    ((entity-a-id . "peter-faucitt")
     (entity-b-id . "slg-pty-ltd")
     (relationship-type . director-company)
     (entity-a-role . "director")
     (entity-b-role . "company")
     (start-date . "2015-01-01")
     (confidence . 0.96)
     (evidence . ("CIPC registration")))
    
    ((entity-a-id . "daniel-faucitt")
     (entity-b-id . "rzl-ltd")
     (relationship-type . director-company)
     (entity-a-role . "director-managing")
     (entity-b-role . "company")
     (start-date . "2015-01-01")
     (confidence . 0.99)
     (evidence . ("Companies House registration")))
    
    ;; EMPLOYMENT RELATIONS
    
    ((entity-a-id . "daniel-faucitt")
     (entity-b-id . "rwd-pty-ltd")
     (relationship-type . employer-employee)
     (entity-a-role . "cio")
     (entity-b-role . "employer")
     (start-date . "2010-01-01")
     (job-title . "Chief Information Officer")
     (confidence . 0.98)
     (evidence . ("Employment contract" "CIO role documentation")))
    
    ((entity-a-id . "jacqueline-faucitt")
     (entity-b-id . "rst-pty-ltd")
     (relationship-type . employer-employee)
     (entity-a-role . "ceo")
     (entity-b-role . "employer")
     (start-date . "2010-01-01")
     (job-title . "Chief Executive Officer")
     (confidence . 0.98)
     (evidence . ("Employment contract" "CEO role documentation")))
    
    ((entity-a-id . "daniel-faucitt")
     (entity-b-id . "rst-pty-ltd")
     (relationship-type . service-provider-client)
     (entity-a-role . "eu-responsible-person")
     (entity-b-role . "client")
     (start-date . "2020-01-01")
     (job-title . "EU Responsible Person")
     (confidence . 0.97)
     (evidence . ("EU RP appointment" "CPNP registration")))
    
    ((entity-a-id . "jacqueline-faucitt")
     (entity-b-id . "rst-pty-ltd")
     (relationship-type . service-provider-client)
     (entity-a-role . "eu-responsible-person")
     (entity-b-role . "client")
     (start-date . "2020-01-01")
     (job-title . "EU Responsible Person")
     (confidence . 0.97)
     (evidence . ("EU RP appointment" "CPNP registration")))
    
    ((entity-a-id . "bantjies")
     (entity-b-id . "rwd-pty-ltd")
     (relationship-type . service-provider-client)
     (entity-a-role . "accountant")
     (entity-b-role . "client")
     (start-date . "2010-01-01")
     (confidence . 0.98)
     (evidence . ("Accounting services agreement")))
    
    ((entity-a-id . "bantjies")
     (entity-b-id . "rst-pty-ltd")
     (relationship-type . service-provider-client)
     (entity-a-role . "accountant")
     (entity-b-role . "client")
     (start-date . "2010-01-01")
     (confidence . 0.98)
     (evidence . ("Accounting services agreement")))
    
    ;; FAMILY RELATIONS
    
    ((entity-a-id . "daniel-faucitt")
     (entity-b-id . "jacqueline-faucitt")
     (relationship-type . spouse)
     (entity-a-role . "spouse")
     (entity-b-role . "spouse")
     (start-date . "2005-01-01")
     (confidence . 1.0)
     (evidence . ("Marriage certificate")))
    
    ((entity-a-id . "peter-faucitt")
     (entity-b-id . "daniel-faucitt")
     (relationship-type . parent-child)
     (entity-a-role . "parent")
     (entity-b-role . "child")
     (confidence . 1.0)
     (evidence . ("Birth certificate")))
    
    ((entity-a-id . "peter-faucitt")
     (entity-b-id . "jacqueline-faucitt")
     (relationship-type . extended-family)
     (entity-a-role . "parent-in-law")
     (entity-b-role . "child-in-law")
     (confidence . 1.0)
     (evidence . ("Family relationship")))
    
    ;; COORDINATION RELATIONS
    
    ((entity-a-id . "daniel-faucitt")
     (entity-b-id . "jacqueline-faucitt")
     (relationship-type . co-respondent)
     (entity-a-role . "second-respondent")
     (entity-b-role . "first-respondent")
     (start-date . "2025-08-13")
     (confidence . 0.98)
     (evidence . ("Interdict filing" "Complementary defense strategy"))
     (coordination-strength . 0.98)
     (coordination-type . "complementary-defense"))
    
    ((entity-a-id . "peter-faucitt")
     (entity-b-id . "rynette-farrar")
     (relationship-type . co-conspirator)
     (entity-a-role . "legal-intimidation")
     (entity-b-role . "operational-sabotage")
     (start-date . "2025-08-13")
     (confidence . 0.94)
     (evidence . ("Temporal synchronization" "Role complementarity" "Impact alignment"))
     (coordination-strength . 0.94)
     (temporal-synchronization . 0.95)
     (role-complementarity . 0.92)
     (impact-alignment . 0.95))
    
    ;; LEGAL RELATIONS
    
    ((entity-a-id . "peter-faucitt")
     (entity-b-id . "daniel-faucitt")
     (relationship-type . applicant-respondent)
     (entity-a-role . "applicant")
     (entity-b-role . "second-respondent")
     (start-date . "2025-08-13")
     (confidence . 1.0)
     (evidence . ("Interdict application" "Case 2025-137857")))
    
    ((entity-a-id . "peter-faucitt")
     (entity-b-id . "jacqueline-faucitt")
     (relationship-type . applicant-respondent)
     (entity-a-role . "applicant")
     (entity-b-role . "first-respondent")
     (start-date . "2025-08-13")
     (confidence . 1.0)
     (evidence . ("Interdict application" "Case 2025-137857")))
    
    ((entity-a-id . "peter-faucitt")
     (entity-b-id . "daniel-faucitt")
     (relationship-type . creditor-debtor)
     (entity-a-role . "creditor-alleged")
     (entity-b-role . "debtor-disputed")
     (start-date . "2025-08-13")
     (confidence . 0.60)
     (evidence . ("Applicant allegations"))
     (disputed . #t)
     (dispute-basis . "Lack of evidence, material non-disclosure"))
    
    ;; ADVERSARIAL RELATIONS
    
    ((entity-a-id . "daniel-faucitt")
     (entity-b-id . "peter-faucitt")
     (relationship-type . whistleblower-target)
     (entity-a-role . "whistleblower")
     (entity-b-role . "target")
     (start-date . "2025-06-06")
     (confidence . 0.98)
     (evidence . ("Fraud report submission" "Protected disclosure"))
     (retaliation-confidence . 0.98)
     (temporal-proximity . "<24 hours"))
    
    ((entity-a-id . "peter-faucitt")
     (entity-b-id . "daniel-faucitt")
     (relationship-type . victim-perpetrator)
     (entity-a-role . "retaliation-perpetrator")
     (entity-b-role . "retaliation-victim")
     (start-date . "2025-06-07")
     (confidence . 0.98)
     (evidence . ("Immediate retaliation" "Whistleblower retaliation"))
     (retaliation-type . "immediate")
     (temporal-proximity . "<24 hours"))
    
    ;; REGULATORY RELATIONS
    
    ((entity-a-id . "bantjies")
     (entity-b-id . "rst-pty-ltd")
     (relationship-type . auditor-auditee)
     (entity-a-role . "accountant")
     (entity-b-role . "auditee")
     (start-date . "2010-01-01")
     (confidence . 0.95)
     (evidence . ("Accounting services" "Financial statements")))))

;;;
;;; POPULATION FUNCTIONS
;;;

(define (populate-case-entities)
  "Populate all case entities into framework.
   
   Returns: List of created entities"
  
  (map (lambda (entity-data)
         (let ((entity-id (assoc-ref entity-data 'entity-id))
               (entity-type (assoc-ref entity-data 'entity-type)))
           (create-entity entity-id entity-type entity-data)))
       case-entities))

(define (populate-case-relationships)
  "Populate all case relationships into framework.
   
   Returns: List of created relationships"
  
  (map (lambda (rel-data)
         (let ((entity-a-id (assoc-ref rel-data 'entity-a-id))
               (entity-b-id (assoc-ref rel-data 'entity-b-id))
               (relationship-type (assoc-ref rel-data 'relationship-type)))
           (create-relationship entity-a-id entity-b-id relationship-type rel-data)))
       case-relationships))

(define (get-case-entity-registry)
  "Get registry of all case entities.
   
   Returns: Association list of entity IDs and names"
  
  (map (lambda (entity-data)
         (cons (assoc-ref entity-data 'entity-id)
               (or (assoc-ref entity-data 'full-name)
                   (assoc-ref entity-data 'legal-name))))
       case-entities))

(define (get-case-relationship-registry)
  "Get registry of all case relationships.
   
   Returns: Association list of relationship types and counts"
  
  (let ((type-counts (make-hash-table)))
    (for-each
      (lambda (rel-data)
        (let ((rel-type (assoc-ref rel-data 'relationship-type)))
          (hash-set! type-counts rel-type 
            (+ 1 (hash-ref type-counts rel-type 0)))))
      case-relationships)
    (hash-map->list cons type-counts)))

;;;
;;; HELPER FUNCTIONS
;;;

(define (assoc-ref alist key . default)
  "Get value from association list with optional default."
  (let ((pair (assoc key alist)))
    (if pair
        (cdr pair)
        (if (null? default) #f (car default)))))

;;;
;;; EXAMPLE USAGE
;;;

;; Example: Populate all entities
;; (populate-case-entities)

;; Example: Populate all relationships
;; (populate-case-relationships)

;; Example: Get entity registry
;; (get-case-entity-registry)

;; Example: Get relationship registry
;; (get-case-relationship-registry)
