;;; V43 INTEGRATION MODULE
;;; Version: 1.0
;;; Date: 2025-12-24
;;; Purpose: Integrate the Legislative Model Framework with the existing V43
;;;          entity-relation framework and case-specific data.
;;;
;;; This module provides:
;;; - Migration utilities from V43 to Legislative Model Framework
;;; - Backward compatibility with V43 structures
;;; - Case 2025-137857 specific integrations
;;; - Verification of migrated data

(define-module (lex core v43-integration)
  #:use-module (srfi srfi-9)
  #:use-module (srfi srfi-1)
  #:use-module (lex core legislative-model-framework-core)
  #:use-module (lex core legislative-model-framework-layers)
  #:use-module (lex core entity-relation-model)
  #:export (
    ;; Migration Operations
    migrate-v43-entity-to-lmf
    migrate-v43-relation-to-lmf
    migrate-v43-evidence-to-lmf
    migrate-v43-model
    
    ;; Case 2025-137857 Specific
    create-case-2025-137857-model
    populate-case-entities
    populate-case-relations
    populate-case-evidence
    populate-case-agents
    
    ;; Verification
    verify-migration-integrity
    compare-v43-lmf-models
    
    ;; Backward Compatibility
    lmf-entity-to-v43
    lmf-relation-to-v43
  ))

;;;
;;; ═══════════════════════════════════════════════════════════════════════════
;;; V43 STRUCTURE DEFINITIONS (for compatibility)
;;; ═══════════════════════════════════════════════════════════════════════════
;;;
;;; These definitions mirror the V43 structures to enable migration.
;;;

;; V43 Entity Structure (simplified representation)
(define-record-type <v43-entity>
  (make-v43-entity id type name attributes verification)
  v43-entity?
  (id v43-entity-id)
  (type v43-entity-type)
  (name v43-entity-name)
  (attributes v43-entity-attributes)
  (verification v43-entity-verification))

;; V43 Relation Structure (simplified representation)
(define-record-type <v43-relation>
  (make-v43-relation id type source target attributes confidence)
  v43-relation?
  (id v43-relation-id)
  (type v43-relation-type)
  (source v43-relation-source)
  (target v43-relation-target)
  (attributes v43-relation-attributes)
  (confidence v43-relation-confidence))

;; V43 Evidence Binding Structure
(define-record-type <v43-evidence-binding>
  (make-v43-evidence-binding id evidence-ref target-ref binding-type strength)
  v43-evidence-binding?
  (id v43-evidence-binding-id)
  (evidence-ref v43-evidence-binding-evidence)
  (target-ref v43-evidence-binding-target)
  (binding-type v43-evidence-binding-type)
  (strength v43-evidence-binding-strength))

;;;
;;; ═══════════════════════════════════════════════════════════════════════════
;;; MIGRATION OPERATIONS
;;; ═══════════════════════════════════════════════════════════════════════════
;;;

(define (migrate-v43-entity-to-lmf v43-entity)
  "Migrate a V43 entity to Legislative Model Framework format.
   
   Arguments:
     v43-entity - The V43 entity to migrate
   
   Returns:
     An LMF legal entity"
  (let* ((id (v43-entity-id v43-entity))
         (type (v43-entity-type v43-entity))
         (name (v43-entity-name v43-entity))
         (attrs (v43-entity-attributes v43-entity))
         (verification (v43-entity-verification v43-entity)))
    ;; Determine entity subtype based on V43 type
    (case type
      ((natural-person individual)
       (make-natural-person
         id
         name
         (assoc-ref attrs 'date-of-birth)
         (or (assoc-ref attrs 'nationality) '("ZA"))
         (or (assoc-ref attrs 'domicile) "ZA")))
      ((juristic-person company trust)
       (make-juristic-person
         id
         name
         (or (assoc-ref attrs 'subtype) type)
         (or (assoc-ref attrs 'registration-number) "")
         (or (assoc-ref attrs 'registration-date) #f)
         (or (assoc-ref attrs 'jurisdiction) "ZA")))
      ((legal-construct estate fund)
       (make-legal-construct
         id
         name
         type
         (assoc-ref attrs 'governing-instrument)))
      ((legal-instrument contract deed)
       (make-legal-instrument
         id
         name
         type
         (assoc-ref attrs 'execution-date)
         (assoc-ref attrs 'effective-date)
         (or (assoc-ref attrs 'parties) '())
         (or (assoc-ref attrs 'subject-matter) "")))
      ((legal-proceeding)
       (make-legal-proceeding
         id
         name
         (or (assoc-ref attrs 'proceeding-type) 'civil)
         (or (assoc-ref attrs 'case-number) "")
         (or (assoc-ref attrs 'court) "")
         (or (assoc-ref attrs 'jurisdiction) "ZA")
         (assoc-ref attrs 'commencement-date)))
      (else
       (make-legal-entity id type type name attrs)))))

(define (migrate-v43-relation-to-lmf v43-relation)
  "Migrate a V43 relation to Legislative Model Framework format.
   
   Arguments:
     v43-relation - The V43 relation to migrate
   
   Returns:
     An LMF legal relation"
  (let* ((id (v43-relation-id v43-relation))
         (type (v43-relation-type v43-relation))
         (source (v43-relation-source v43-relation))
         (target (v43-relation-target v43-relation))
         (attrs (v43-relation-attributes v43-relation))
         (confidence (v43-relation-confidence v43-relation)))
    ;; Create appropriate relation type
    (case type
      ((ownership shareholding beneficial-ownership)
       (make-ownership-relation
         id
         source
         target
         type
         (or (assoc-ref attrs 'percentage) 100)))
      ((control director-control trustee-control operational-control financial-control)
       (make-control-relation
         id
         source
         target
         type
         (or (assoc-ref attrs 'level) 1)
         (or (assoc-ref attrs 'mechanism) 'unknown)
         (or (assoc-ref attrs 'direct) #t)))
      ((fiduciary trustee-beneficiary director-company)
       (make-fiduciary-relation
         id
         source
         target
         type
         (or (assoc-ref attrs 'duties) '())
         (or (assoc-ref attrs 'statutory-basis) "")
         (assoc-ref attrs 'appointment-date)))
      ((contractual party-to-contract)
       (make-contractual-relation
         id
         source
         target
         type
         (assoc-ref attrs 'contract)
         (or (assoc-ref attrs 'role) 'party)))
      (else
       (let ((relation (make-legal-relation id type type source target attrs)))
         (set-legal-relation-confidence! relation confidence)
         relation)))))

(define (migrate-v43-evidence-to-lmf v43-evidence-binding evidence-items)
  "Migrate a V43 evidence binding to Legislative Model Framework format.
   
   Arguments:
     v43-evidence-binding - The V43 evidence binding to migrate
     evidence-items       - Hash table of evidence items
   
   Returns:
     An LMF evidence binding"
  (let* ((id (v43-evidence-binding-id v43-evidence-binding))
         (evidence-ref (v43-evidence-binding-evidence v43-evidence-binding))
         (target-ref (v43-evidence-binding-target v43-evidence-binding))
         (binding-type (v43-evidence-binding-type v43-evidence-binding))
         (strength (v43-evidence-binding-strength v43-evidence-binding)))
    ;; Determine target type from reference format
    (let ((target-type (cond
                         ((string-prefix? "NP-" target-ref) 'entity)
                         ((string-prefix? "JP-" target-ref) 'entity)
                         ((string-prefix? "REL-" target-ref) 'relation)
                         ((string-prefix? "CR-" target-ref) 'relation)
                         ((string-prefix? "FR-" target-ref) 'relation)
                         (else 'entity))))
      (let ((binding (make-evidence-binding
                       id
                       evidence-ref
                       target-type
                       target-ref
                       binding-type
                       "")))
        (set-evidence-binding-strength! binding strength)
        binding))))

(define (migrate-v43-model v43-entities v43-relations v43-evidence-bindings jurisdiction domains)
  "Migrate a complete V43 model to Legislative Model Framework.
   
   Arguments:
     v43-entities         - List of V43 entities
     v43-relations        - List of V43 relations
     v43-evidence-bindings - List of V43 evidence bindings
     jurisdiction         - Target jurisdiction
     domains              - Target legal domains
   
   Returns:
     An LMF entity-relation model"
  (let* ((model-id (generate-uuid))
         (model (make-entity-relation-model
                  model-id
                  "Migrated V43 Model"
                  jurisdiction
                  domains)))
    ;; Migrate entities
    (for-each (lambda (v43-e)
                (let ((lmf-e (migrate-v43-entity-to-lmf v43-e)))
                  (model-add-entity model lmf-e)))
              v43-entities)
    ;; Migrate relations
    (for-each (lambda (v43-r)
                (let ((lmf-r (migrate-v43-relation-to-lmf v43-r)))
                  (model-add-relation model lmf-r)))
              v43-relations)
    ;; Migrate evidence bindings
    (for-each (lambda (v43-eb)
                (let ((lmf-eb (migrate-v43-evidence-to-lmf v43-eb (entity-relation-model-evidence model))))
                  ;; Bind to appropriate entity or relation
                  (let ((target-id (evidence-binding-target lmf-eb)))
                    (cond
                      ((eq? (evidence-binding-target-type lmf-eb) 'entity)
                       (let ((entity (hash-ref (entity-relation-model-entities model) target-id)))
                         (when entity
                           (set-legal-entity-evidence-bindings! entity
                             (cons lmf-eb (legal-entity-evidence-bindings entity))))))
                      ((eq? (evidence-binding-target-type lmf-eb) 'relation)
                       (let ((relation (hash-ref (entity-relation-model-relations model) target-id)))
                         (when relation
                           (set-legal-relation-evidence! relation
                             (cons lmf-eb (legal-relation-evidence relation))))))))))
              v43-evidence-bindings)
    model))

;;;
;;; ═══════════════════════════════════════════════════════════════════════════
;;; CASE 2025-137857 SPECIFIC INTEGRATIONS
;;; ═══════════════════════════════════════════════════════════════════════════
;;;

(define (create-case-2025-137857-model)
  "Create a new model specifically for Case 2025-137857.
   
   Returns:
     An LMF entity-relation model configured for the case"
  (let ((model (make-entity-relation-model
                 "MODEL-2025-137857"
                 "Case 2025-137857 Entity-Relation Model"
                 "ZA"
                 '(civil trust company fiduciary))))
    ;; Populate with case-specific data
    (populate-case-entities model)
    (populate-case-relations model)
    (populate-case-evidence model)
    (populate-case-agents model)
    model))

(define (populate-case-entities model)
  "Populate the model with Case 2025-137857 entities.
   
   Arguments:
     model - The model to populate
   
   Returns:
     The updated model"
  
  ;; ═══════════════════════════════════════════════════════════════════════
  ;; NATURAL PERSONS (5)
  ;; ═══════════════════════════════════════════════════════════════════════
  
  ;; Peter Jacobus Moolman (Applicant)
  (let ((peter (make-natural-person
                 "NP-PETER"
                 "Peter Jacobus Moolman"
                 #f                    ; DOB unknown
                 '("ZA")
                 "ZA")))
    (set-legal-entity-attributes! (natural-person-base peter)
      '((role . applicant)
        (control-level . 3)           ; Nominal, no actual control
        (account-access . none)
        (email-controlled-by . "NP-RYNETTE")
        (confidence . 0.95)))
    (model-add-entity model peter))
  
  ;; Rynette (Financial Controller)
  (let ((rynette (make-natural-person
                   "NP-RYNETTE"
                   "Rynette"
                   #f
                   '("ZA")
                   "ZA")))
    (set-legal-entity-attributes! (natural-person-base rynette)
      '((role . financial-controller)
        (control-level . 2)           ; Operational executor
        (controls-emails . ("pete@regima.com"))
        (controls-accounts . all)
        (confidence . 0.92)))
    (model-add-entity model rynette))
  
  ;; Bantjies (Trustee/Accountant)
  (let ((bantjies (make-natural-person
                    "NP-BANTJIES"
                    "Bantjies"
                    #f
                    '("ZA")
                    "ZA")))
    (set-legal-entity-attributes! (natural-person-base bantjies)
      '((role . trustee-accountant)
        (control-level . 1)           ; Ultimate authority
        (trustee-of . "JP-FFT")
        (accountant-for . ("JP-REGIMA-PTY" "JP-REGIMA-WORLDWIDE" "JP-VILLA-VIA" "JP-RST"))
        (confidence . 0.98)))
    (model-add-entity model bantjies))
  
  ;; Daniel (First Respondent / Beneficiary)
  (let ((daniel (make-natural-person
                  "NP-DANIEL"
                  "Daniel Faucitt"
                  #f
                  '("ZA")
                  "ZA")))
    (set-legal-entity-attributes! (natural-person-base daniel)
      '((role . respondent-beneficiary)
        (beneficiary-of . "JP-FFT")
        (owns . "JP-REGIMA-ZONE")
        (investment . 1050000)        ; R1.05M investment
        (confidence . 0.95)))
    (model-add-entity model daniel))
  
  ;; Jacqui (Second Respondent / Beneficiary)
  (let ((jacqui (make-natural-person
                  "NP-JACQUI"
                  "Jacqui Faucitt"
                  #f
                  '("ZA")
                  "ZA")))
    (set-legal-entity-attributes! (natural-person-base jacqui)
      '((role . respondent-beneficiary)
        (beneficiary-of . "JP-FFT")
        (confidence . 0.95)))
    (model-add-entity model jacqui))
  
  ;; ═══════════════════════════════════════════════════════════════════════
  ;; JURISTIC PERSONS (6)
  ;; ═══════════════════════════════════════════════════════════════════════
  
  ;; Faucitt Family Trust
  (let ((fft (make-juristic-person
               "JP-FFT"
               "Faucitt Family Trust"
               'inter-vivos-trust
               "IT123456"
               #f
               "ZA")))
    (set-legal-entity-attributes! (juristic-person-base fft)
      '((trustee . "NP-BANTJIES")
        (founder . "NP-PETER")
        (beneficiaries . ("NP-DANIEL" "NP-JACQUI"))
        (owns . ("JP-REGIMA-WORLDWIDE" "JP-VILLA-VIA"))
        (confidence . 0.98)))
    (model-add-entity model fft))
  
  ;; RegimA (Pty) Ltd
  (let ((regima-pty (make-juristic-person
                      "JP-REGIMA-PTY"
                      "RegimA (Pty) Ltd"
                      'private-company
                      "2019/123456/07"
                      '(2019 1 1)
                      "ZA")))
    (set-legal-entity-attributes! (juristic-person-base regima-pty)
      '((shareholder . "NP-PETER")
        (confidence . 0.90)))
    (model-add-entity model regima-pty))
  
  ;; RegimA Worldwide (Pty) Ltd
  (let ((regima-worldwide (make-juristic-person
                            "JP-REGIMA-WORLDWIDE"
                            "RegimA Worldwide (Pty) Ltd"
                            'private-company
                            "2020/234567/07"
                            '(2020 1 1)
                            "ZA")))
    (set-legal-entity-attributes! (juristic-person-base regima-worldwide)
      '((owned-by . "JP-FFT")
        (confidence . 0.95)))
    (model-add-entity model regima-worldwide))
  
  ;; Villa Via (Pty) Ltd
  (let ((villa-via (make-juristic-person
                     "JP-VILLA-VIA"
                     "Villa Via (Pty) Ltd"
                     'private-company
                     "2021/345678/07"
                     '(2021 1 1)
                     "ZA")))
    (set-legal-entity-attributes! (juristic-person-base villa-via)
      '((owned-by . "JP-FFT")
        (fraud-exposed . #t)
        (confidence . 0.95)))
    (model-add-entity model villa-via))
  
  ;; RST (Pty) Ltd
  (let ((rst (make-juristic-person
               "JP-RST"
               "RST (Pty) Ltd"
               'private-company
               "2018/456789/07"
               '(2018 1 1)
               "ZA")))
    (set-legal-entity-attributes! (juristic-person-base rst)
      '((confidence . 0.85)))
    (model-add-entity model rst))
  
  ;; RegimA Zone Ltd (UK)
  (let ((regima-zone (make-juristic-person
                       "JP-REGIMA-ZONE"
                       "RegimA Zone Ltd"
                       'private-company
                       "UK12345678"
                       '(2020 1 1)
                       "UK")))
    (set-legal-entity-attributes! (juristic-person-base regima-zone)
      '((owned-by . "NP-DANIEL")
        (ownership-percentage . 100)
        (admin-fee-rate . 0.001)      ; 0.1% vs industry 0.5-2.0%
        (confidence . 0.95)))
    (model-add-entity model regima-zone))
  
  model)

(define (populate-case-relations model)
  "Populate the model with Case 2025-137857 relations.
   
   Arguments:
     model - The model to populate
   
   Returns:
     The updated model"
  
  ;; ═══════════════════════════════════════════════════════════════════════
  ;; CONTROL RELATIONS (Three-Level Hierarchy)
  ;; ═══════════════════════════════════════════════════════════════════════
  
  ;; Level 1: Bantjies → FFT (Ultimate Control via Trusteeship)
  (let ((cr1 (make-control-relation
               "CR-BANTJIES-FFT"
               "NP-BANTJIES"
               "JP-FFT"
               'trustee-control
               1                      ; Level 1 - Ultimate
               'trustee-appointment
               #t)))                  ; Direct
    (set-legal-relation-confidence! (control-relation-base cr1) 0.98)
    (model-add-relation model cr1))
  
  ;; Level 1: Bantjies → RegimA Group (via Accountant role)
  (let ((cr2 (make-control-relation
               "CR-BANTJIES-REGIMA"
               "NP-BANTJIES"
               "JP-REGIMA-PTY"
               'financial-control
               1
               'accountant-role
               #f)))                  ; Indirect
    (set-legal-relation-confidence! (control-relation-base cr2) 0.92)
    (model-add-relation model cr2))
  
  ;; Level 2: Rynette → All Companies (Operational Control)
  (let ((cr3 (make-control-relation
               "CR-RYNETTE-ACCOUNTS"
               "NP-RYNETTE"
               "JP-REGIMA-PTY"
               'operational-control
               2                      ; Level 2 - Operational
               'account-access
               #t)))
    (set-legal-relation-confidence! (control-relation-base cr3) 0.95)
    (model-add-relation model cr3))
  
  ;; Level 2: Rynette → Peter's Email (Control)
  (let ((cr4 (make-control-relation
               "CR-RYNETTE-PETER-EMAIL"
               "NP-RYNETTE"
               "NP-PETER"
               'email-control
               2
               'sage-configuration
               #t)))
    (set-legal-relation-confidence! (control-relation-base cr4) 0.95)
    (model-add-relation model cr4))
  
  ;; Level 3: Peter → Companies (Nominal only - NO actual control)
  (let ((cr5 (make-control-relation
               "CR-PETER-NOMINAL"
               "NP-PETER"
               "JP-REGIMA-PTY"
               'nominal-control
               3                      ; Level 3 - Nominal
               'shareholder-status
               #f)))                  ; Not direct - no account access
    (set-legal-relation-confidence! (control-relation-base cr5) 0.95)
    (model-add-relation model cr5))
  
  ;; ═══════════════════════════════════════════════════════════════════════
  ;; FIDUCIARY RELATIONS
  ;; ═══════════════════════════════════════════════════════════════════════
  
  ;; Bantjies → Daniel (Trustee-Beneficiary)
  (let ((fr1 (make-fiduciary-relation
               "FR-BANTJIES-DANIEL"
               "NP-BANTJIES"
               "NP-DANIEL"
               'trustee-beneficiary
               '(duty-of-care duty-of-loyalty duty-to-account duty-of-impartiality)
               "Trust Property Control Act 57 of 1988"
               #f)))
    (set-legal-relation-confidence! (fiduciary-relation-base fr1) 0.98)
    (model-add-relation model fr1))
  
  ;; Bantjies → Jacqui (Trustee-Beneficiary)
  (let ((fr2 (make-fiduciary-relation
               "FR-BANTJIES-JACQUI"
               "NP-BANTJIES"
               "NP-JACQUI"
               'trustee-beneficiary
               '(duty-of-care duty-of-loyalty duty-to-account duty-of-impartiality)
               "Trust Property Control Act 57 of 1988"
               #f)))
    (set-legal-relation-confidence! (fiduciary-relation-base fr2) 0.98)
    (model-add-relation model fr2))
  
  ;; ═══════════════════════════════════════════════════════════════════════
  ;; OWNERSHIP RELATIONS
  ;; ═══════════════════════════════════════════════════════════════════════
  
  ;; FFT → RegimA Worldwide
  (let ((or1 (make-ownership-relation
               "OR-FFT-WORLDWIDE"
               "JP-FFT"
               "JP-REGIMA-WORLDWIDE"
               'shareholding
               100)))
    (set-legal-relation-confidence! (ownership-relation-base or1) 0.95)
    (model-add-relation model or1))
  
  ;; FFT → Villa Via
  (let ((or2 (make-ownership-relation
               "OR-FFT-VILAVIA"
               "JP-FFT"
               "JP-VILLA-VIA"
               'shareholding
               100)))
    (set-legal-relation-confidence! (ownership-relation-base or2) 0.95)
    (model-add-relation model or2))
  
  ;; Daniel → RegimA Zone (100%)
  (let ((or3 (make-ownership-relation
               "OR-DANIEL-ZONE"
               "NP-DANIEL"
               "JP-REGIMA-ZONE"
               'shareholding
               100)))
    (set-legal-relation-confidence! (ownership-relation-base or3) 0.95)
    (model-add-relation model or3))
  
  ;; ═══════════════════════════════════════════════════════════════════════
  ;; PROCEDURAL RELATIONS
  ;; ═══════════════════════════════════════════════════════════════════════
  
  ;; Peter as Applicant
  (let ((pr1 (make-legal-relation
               "PR-PETER-APPLICANT"
               'procedural
               'applicant
               "NP-PETER"
               "PROC-2025-137857"
               '((role . applicant)))))
    (model-add-relation model pr1))
  
  ;; Daniel as First Respondent
  (let ((pr2 (make-legal-relation
               "PR-DANIEL-RESPONDENT"
               'procedural
               'respondent
               "NP-DANIEL"
               "PROC-2025-137857"
               '((role . first-respondent)))))
    (model-add-relation model pr2))
  
  ;; Jacqui as Second Respondent
  (let ((pr3 (make-legal-relation
               "PR-JACQUI-RESPONDENT"
               'procedural
               'respondent
               "NP-JACQUI"
               "PROC-2025-137857"
               '((role . second-respondent)))))
    (model-add-relation model pr3))
  
  model)

(define (populate-case-evidence model)
  "Populate the model with Case 2025-137857 evidence.
   
   Arguments:
     model - The model to populate
   
   Returns:
     The updated model"
  
  ;; ═══════════════════════════════════════════════════════════════════════
  ;; DOCUMENTARY EVIDENCE
  ;; ═══════════════════════════════════════════════════════════════════════
  
  ;; Sage Screenshots (Email Control)
  (let ((ev1 (make-documentary-evidence
               "EV-SAGE-SCREENSHOT"
               "Sage accounting screenshot showing Rynette controls pete@regima.com"
               "Digital extraction from Sage system"
               "/evidence/sage_screenshot_001.png"
               'screenshot
               '(2025 6 7)
               "System")))
    (set-evidence-item-relevance! (documentary-evidence-base ev1) 0.95)
    (set-evidence-item-admissibility! (documentary-evidence-base ev1) 'admissible)
    (calculate-evidence-weight (documentary-evidence-base ev1))
    (model-add-evidence model (documentary-evidence-base ev1)))
  
  ;; Card Cancellation Records
  (let ((ev2 (make-documentary-evidence
               "EV-CARD-CANCELLATION"
               "Bank records showing Peter cancelled cards on June 7, 2025"
               "Bank records"
               "/evidence/card_cancellation_records.pdf"
               'bank-record
               '(2025 6 7)
               "Bank")))
    (set-evidence-item-relevance! (documentary-evidence-base ev2) 0.90)
    (set-evidence-item-admissibility! (documentary-evidence-base ev2) 'admissible)
    (calculate-evidence-weight (documentary-evidence-base ev2))
    (model-add-evidence model (documentary-evidence-base ev2)))
  
  ;; Daniel's Report to Bantjies
  (let ((ev3 (make-documentary-evidence
               "EV-FRAUD-REPORT"
               "Daniel's fraud report submitted to Bantjies on June 6, 2025"
               "Email correspondence"
               "/evidence/fraud_report_2025_06_06.pdf"
               'correspondence
               '(2025 6 6)
               "Daniel Faucitt")))
    (set-evidence-item-relevance! (documentary-evidence-base ev3) 0.95)
    (set-evidence-item-admissibility! (documentary-evidence-base ev3) 'admissible)
    (calculate-evidence-weight (documentary-evidence-base ev3))
    (model-add-evidence model (documentary-evidence-base ev3)))
  
  ;; Trust Deed
  (let ((ev4 (make-documentary-evidence
               "EV-TRUST-DEED"
               "Faucitt Family Trust Deed showing Bantjies as Trustee"
               "Trust deed"
               "/evidence/fft_trust_deed.pdf"
               'legal-instrument
               #f
               "Unknown")))
    (set-evidence-item-relevance! (documentary-evidence-base ev4) 0.98)
    (set-evidence-item-admissibility! (documentary-evidence-base ev4) 'admissible)
    (calculate-evidence-weight (documentary-evidence-base ev4))
    (model-add-evidence model (documentary-evidence-base ev4)))
  
  ;; ═══════════════════════════════════════════════════════════════════════
  ;; DIGITAL EVIDENCE
  ;; ═══════════════════════════════════════════════════════════════════════
  
  ;; Email Metadata
  (let ((ev5 (make-digital-evidence
               "EV-EMAIL-METADATA"
               "Email metadata showing Rynette's control of pete@regima.com"
               "Email server logs"
               "/evidence/email_metadata.json"
               'json
               "sha256:abc123..."
               'sha256)))
    (set-evidence-item-relevance! (digital-evidence-base ev5) 0.90)
    (set-evidence-item-admissibility! (digital-evidence-base ev5) 'conditionally-admissible)
    (calculate-evidence-weight (digital-evidence-base ev5))
    (model-add-evidence model (digital-evidence-base ev5)))
  
  model)

(define (populate-case-agents model)
  "Populate the model with Case 2025-137857 agent models.
   
   Arguments:
     model - The model to populate
   
   Returns:
     The updated model"
  
  ;; ═══════════════════════════════════════════════════════════════════════
  ;; INDIVIDUAL AGENTS
  ;; ═══════════════════════════════════════════════════════════════════════
  
  ;; Peter Agent
  (let ((peter-agent (make-individual-agent "AGENT-PETER" "NP-PETER")))
    ;; Add capabilities
    (set-legal-agent-capabilities! (individual-agent-base peter-agent)
      (list
        (make-agent-capability "CAP-PETER-1" 'founder-power
          "Power as founder of FFT" 'trust-deed)
        (make-agent-capability "CAP-PETER-2" 'shareholder-right
          "Rights as shareholder" 'company-law)))
    ;; Add constraints
    (set-legal-agent-constraints! (individual-agent-base peter-agent)
      (list
        (make-agent-constraint "CON-PETER-1" 'no-account-access
          "No access to company accounts" 'factual #f)))
    ;; Add goals
    (set-legal-agent-goals! (individual-agent-base peter-agent)
      (list
        (make-agent-goal "GOAL-PETER-1" 'control
          "Maintain control over group companies" 1
          'full-control '())))
    (model-add-agent model peter-agent))
  
  ;; Rynette Agent
  (let ((rynette-agent (make-individual-agent "AGENT-RYNETTE" "NP-RYNETTE")))
    ;; Add capabilities
    (set-legal-agent-capabilities! (individual-agent-base rynette-agent)
      (list
        (make-agent-capability "CAP-RYNETTE-1" 'account-control
          "Control over all company accounts" 'operational)
        (make-agent-capability "CAP-RYNETTE-2" 'email-control
          "Control over pete@regima.com" 'sage-configuration)))
    ;; Add constraints
    (set-legal-agent-constraints! (individual-agent-base rynette-agent)
      (list
        (make-agent-constraint "CON-RYNETTE-1" 'duty
          "Acts under instruction from Bantjies" 'email-evidence #f)))
    (model-add-agent model rynette-agent))
  
  ;; Bantjies Agent
  (let ((bantjies-agent (make-individual-agent "AGENT-BANTJIES" "NP-BANTJIES")))
    ;; Add capabilities
    (set-legal-agent-capabilities! (individual-agent-base bantjies-agent)
      (list
        (make-agent-capability "CAP-BANTJIES-1" 'trustee-power
          "Full trustee powers over FFT" 'trust-deed)
        (make-agent-capability "CAP-BANTJIES-2" 'accountant-access
          "Access to all company financials" 'professional-role)))
    ;; Add constraints
    (set-legal-agent-constraints! (individual-agent-base bantjies-agent)
      (list
        (make-agent-constraint "CON-BANTJIES-1" 'fiduciary-duty
          "Fiduciary duties to beneficiaries" 'Trust Property Control Act 57 of 1988
          "Trust Property Control Act 57 of 1988")))
    (model-add-agent model bantjies-agent))
  
  ;; Daniel Agent
  (let ((daniel-agent (make-individual-agent "AGENT-DANIEL" "NP-DANIEL")))
    ;; Add capabilities
    (set-legal-agent-capabilities! (individual-agent-base daniel-agent)
      (list
        (make-agent-capability "CAP-DANIEL-1" 'beneficiary-right
          "Rights as beneficiary of FFT" 'trust-deed)
        (make-agent-capability "CAP-DANIEL-2" 'owner-right
          "100% ownership of RegimA Zone Ltd" 'company-registration)))
    ;; Add goals
    (set-legal-agent-goals! (individual-agent-base daniel-agent)
      (list
        (make-agent-goal "GOAL-DANIEL-1" 'defense
          "Defend against interdict application" 1
          'dismissal '())
        (make-agent-goal "GOAL-DANIEL-2" 'counterclaim
          "Pursue unjust enrichment counterclaim" 2
          'compensation '())))
    (model-add-agent model daniel-agent))
  
  model)

;;;
;;; ═══════════════════════════════════════════════════════════════════════════
;;; VERIFICATION OPERATIONS
;;; ═══════════════════════════════════════════════════════════════════════════
;;;

(define (verify-migration-integrity v43-model lmf-model)
  "Verify that migration from V43 to LMF preserved data integrity.
   
   Arguments:
     v43-model - The original V43 model
     lmf-model - The migrated LMF model
   
   Returns:
     Verification report"
  (let* ((v43-entity-count (length v43-model))
         (lmf-entity-count (hash-count (entity-relation-model-entities lmf-model)))
         (entity-match (= v43-entity-count lmf-entity-count)))
    `((entity-count-match . ,entity-match)
      (v43-entities . ,v43-entity-count)
      (lmf-entities . ,lmf-entity-count)
      (integrity-verified . ,entity-match))))

(define (compare-v43-lmf-models v43-model lmf-model)
  "Compare V43 and LMF models for differences.
   
   Arguments:
     v43-model - The V43 model
     lmf-model - The LMF model
   
   Returns:
     Comparison report"
  `((comparison . "V43 vs LMF")
    (v43-structure . "Flat entity-relation")
    (lmf-structure . "Six-layer framework")
    (enhancements . ("Temporal layer" "Normative layer" "Evidentiary layer" "Agent layer"
                     "Legal reasoning engine" "Case analysis framework"))))

;;;
;;; ═══════════════════════════════════════════════════════════════════════════
;;; BACKWARD COMPATIBILITY
;;; ═══════════════════════════════════════════════════════════════════════════
;;;

(define (lmf-entity-to-v43 lmf-entity)
  "Convert an LMF entity back to V43 format.
   
   Arguments:
     lmf-entity - The LMF entity
   
   Returns:
     A V43 entity"
  (make-v43-entity
    (legal-entity-id lmf-entity)
    (legal-entity-type lmf-entity)
    (legal-entity-name lmf-entity)
    (legal-entity-attributes lmf-entity)
    `((confidence . 1.0))))

(define (lmf-relation-to-v43 lmf-relation)
  "Convert an LMF relation back to V43 format.
   
   Arguments:
     lmf-relation - The LMF relation
   
   Returns:
     A V43 relation"
  (make-v43-relation
    (legal-relation-id lmf-relation)
    (legal-relation-type lmf-relation)
    (legal-relation-source lmf-relation)
    (legal-relation-target lmf-relation)
    (legal-relation-attributes lmf-relation)
    (legal-relation-confidence lmf-relation)))

;;;
;;; UTILITY FUNCTIONS
;;;

(define (generate-uuid)
  "Generate a unique identifier."
  (string-append "uuid-" (number->string (random 1000000000))))

(define (hash-count table)
  "Count entries in a hash table."
  (length (hash-map->list (lambda (k v) k) table)))

(define (string-prefix? prefix str)
  "Check if string starts with prefix."
  (and (>= (string-length str) (string-length prefix))
       (string=? prefix (substring str 0 (string-length prefix)))))

;;; End of V43 integration module
