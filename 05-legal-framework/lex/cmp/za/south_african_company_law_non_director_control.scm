;;; South African Company Law - Non-Director Financial Control
;;; Enhanced with non-director-control-red-flags for governance violations
;;; Date: 2025-11-06
;;; Case: 2025-137857 (Peter Faucitt v. Jacqueline & Daniel Faucitt)

(define-module (lex cmp za south-african-company-law-non-director-control)
  #:use-module (lex lv1 known-laws)
  #:use-module (lex cmp za south-african-company-law-forensic-accounting-enhanced-v6)
  #:export (
    non-director-control-red-flags
    director-exclusion-from-financial-systems
    inverted-control-structure-indicators
  ))

;;;
;;; NEW PRINCIPLE: Non-Director Control Red Flags
;;;

(define-principle non-director-control-red-flags
  #:name "Non-Director Control Red Flags"
  #:confidence 0.95
  #:domain '(company-law corporate-governance fiduciary-duty fraud)
  #:description "Identifies patterns where non-directors exercise financial control while directors are excluded, indicating governance violations"
  
  #:core-indicators '(
    (non-director-has-financial-control "Non-director controls accounts, banks, systems")
    (directors-excluded-from-systems "Directors excluded from financial systems")
    (non-director-makes-financial-decisions "Non-director makes financial decisions")
    (directors-lack-information "Directors lack financial information")
    (inverted-authority-structure "Authority structure inverted (non-director has power)")
    (accountability-gap "Accountability gap (no director oversight)")
  )
  
  #:red-flags '(
    (non-director-controls-all-accounts 0.97 "Non-director controls all company bank accounts")
    (directors-have-no-access 0.96 "Directors have no access to financial systems")
    (non-director-controls-director-email 0.98 "Non-director controls director's email")
    (non-director-makes-payments 0.95 "Non-director makes payments without director approval")
    (non-director-controls-accounting-system 0.96 "Non-director controls accounting system (Sage, etc.)")
    (directors-request-access-denied 0.97 "Directors request access but are denied")
    (unallocated-expenses-accumulate 0.94 "Unallocated expenses accumulate under non-director control")
  )
  
  #:case-application
  "RegimA Companies - Rynette Farrar (Non-Director) Financial Control:
  
  **Non-Director Control**:
  - Rynette Farrar: Not a director of any RegimA company
  - Controls: All bank accounts, Sage accounting system, Peter's email (pete@regima.com)
  - Makes: Financial decisions, payments, expense allocations
  - Access: Unrestricted to all financial systems
  
  **Director Exclusion**:
  - Peter Faucitt: Director, but no access to systems (Rynette controls his email)
  - Jacqueline Faucitt: Director, excluded from financial systems
  - Daniel Faucitt: Director, excluded from financial systems
  - Directors: Cannot access accounts, Sage, or financial information
  
  **Inverted Control Structure**:
  - Normal: Directors control, non-directors execute under supervision
  - Actual: Non-director (Rynette) controls, directors excluded
  - Authority: Inverted (Rynette has power, directors have none)
  
  **Accountability Gap**:
  - No director oversight of Rynette's actions
  - Two years unallocated expenses (Rynette controls Sage using Peter's email)
  - R5.4M stock adjustment (Rynette claims Bantjies instructed payments)
  - Directors discover problems only when investigating fraud
  
  **Red Flags Present**:
  1. Non-director controls all accounts (0.97)
  2. Directors have no access (0.96)
  3. Non-director controls director email (Peter's email) (0.98)
  4. Non-director makes payments (Rynette makes payments per Bantjies) (0.95)
  5. Non-director controls Sage (0.96)
  6. Unallocated expenses accumulate (2 years) (0.94)
  
  **Aggregate Confidence**: 0.96
  
  **Legal Implications**:
  - Governance violation (Companies Act Section 66: director duties)
  - Fiduciary duty breach (directors unable to perform duties)
  - Fraud facilitation (inverted structure enables fraud)
  - Director liability risk (directors responsible but lack control)
  - Ultra vires acts (non-director acts beyond authority)
  - Accountability gap (no oversight)
  - Remedies: Director access restoration, non-director removal, forensic audit"
  
  #:legal-framework
  '((companies-act-section-66 "Director duties require control and oversight")
    (companies-act-section-76 "Director standard of conduct")
    (common-law-fiduciary-duty "Directors must exercise control")
    (corporate-governance-principles "Separation of management and execution")
    (king-iv-governance-code "Accountability and oversight requirements"))
  
  #:legal-implications '(
    "Governance violation (Companies Act Section 66)"
    "Fiduciary duty breach (directors unable to perform duties)"
    "Fraud facilitation (inverted structure enables fraud)"
    "Director liability risk (directors responsible but lack control)"
    "Ultra vires acts (non-director exceeds authority)"
    "Accountability gap (no oversight)"
    "Remedies: Access restoration, non-director removal, forensic audit"
    "Court intervention warranted to restore proper governance"
  )
  
  #:related-principles '(
    fiduciary-duty
    director-collective-action-requirement
    corporate-governance-principles
    fraud-indicators
    ultra-vires
    accountability
  )
  
  #:integration-points '(
    "jax-response/AD/1-Critical/PARA_7_9-7_11.md"
    "PETERS_CAUSATION_ANALYSIS.md"
    "LEGAL_ASPECTS_ANALYSIS_2025-11-06.json"
  )
  
  #:test-function
  (lambda (facts)
    (let ((non-director-controls-accounts (assoc-ref facts 'non-director-controls-accounts))
          (directors-excluded (assoc-ref facts 'directors-excluded))
          (non-director-controls-director-email (assoc-ref facts 'non-director-controls-director-email))
          (accountability-gap (assoc-ref facts 'accountability-gap)))
      
      (and non-director-controls-accounts
           directors-excluded
           non-director-controls-director-email
           accountability-gap))))

;;;
;;; NEW PRINCIPLE: Director Exclusion from Financial Systems
;;;

(define-principle director-exclusion-from-financial-systems
  #:name "Director Exclusion from Financial Systems"
  #:confidence 0.96
  #:domain '(company-law corporate-governance fiduciary-duty)
  #:description "Identifies when directors are systematically excluded from financial systems, preventing them from performing fiduciary duties"
  
  #:core-indicators '(
    (directors-lack-system-access "Directors lack access to financial systems")
    (access-requests-denied "Director access requests denied")
    (information-asymmetry "Directors lack financial information")
    (inability-to-perform-duties "Directors unable to perform fiduciary duties")
    (systematic-exclusion "Exclusion is systematic, not accidental")
  )
  
  #:exclusion-mechanisms '(
    (password-control 0.95 "Non-director controls passwords, directors don't have them")
    (email-control 0.97 "Non-director controls director email accounts")
    (bank-access-restriction 0.96 "Directors excluded from bank account access")
    (accounting-system-lockout 0.95 "Directors locked out of accounting system")
    (card-cancellation 0.94 "Director cards cancelled without notice")
    (system-suspension 0.93 "Systems suspended when directors try to access")
  )
  
  #:case-application
  "RegimA Companies - Director Exclusion Pattern:
  
  **Exclusion Mechanisms**:
  1. Email control: Rynette controls Peter's email (pete@regima.com)
  2. Bank access: Directors excluded from bank accounts (Rynette controls)
  3. Sage lockout: Directors cannot access Sage (Rynette controls using Peter's email)
  4. Card cancellation: Peter cancels cards 7 Jun 2025 (prevents Dan from accessing documentation)
  5. System suspension: Cloud storage, accounting software suspended after card cancellation
  
  **Impact on Directors**:
  - Jax (CEO, Director): Cannot access financial systems, relies on Rynette for information
  - Dan (CIO, Director): Cannot access financial systems, discovers fraud only through investigation
  - Peter (Director): Email controlled by Rynette, may not have full information
  
  **Inability to Perform Duties**:
  - Directors cannot review financial statements
  - Directors cannot approve payments
  - Directors cannot monitor expenses
  - Directors cannot detect fraud
  - Directors cannot fulfill Section 66 duties (Companies Act)
  
  **Systematic Nature**:
  - Exclusion persists for years (2 years unallocated expenses)
  - Multiple mechanisms employed
  - Access restoration requires investigation and confrontation
  
  **Legal Implications**:
  - Directors unable to perform fiduciary duties
  - Governance violation
  - Fraud facilitation
  - Director liability risk (responsible but unable to act)
  - Court intervention warranted"
  
  #:legal-implications '(
    "Directors unable to perform fiduciary duties"
    "Governance violation"
    "Fraud facilitation"
    "Director liability risk"
    "Companies Act Section 66 breach"
    "Fiduciary duty breach"
    "Court intervention warranted to restore access"
    "Forensic audit required"
  )
  
  #:related-principles '(
    non-director-control-red-flags
    fiduciary-duty
    director-collective-action-requirement
    corporate-governance-principles
  )
  
  #:integration-points '(
    "jax-response/AD/1-Critical/PARA_7_9-7_11.md"
    "PETERS_CAUSATION_ANALYSIS.md"
  )
  
  #:test-function
  (lambda (facts)
    (let ((directors-lack-access (assoc-ref facts 'directors-lack-access))
          (exclusion-mechanisms-count (assoc-ref facts 'exclusion-mechanisms-count))
          (systematic-exclusion (assoc-ref facts 'systematic-exclusion)))
      
      (and directors-lack-access
           (>= exclusion-mechanisms-count 3)
           systematic-exclusion))))

;;;
;;; NEW PRINCIPLE: Inverted Control Structure Indicators
;;;

(define-principle inverted-control-structure-indicators
  #:name "Inverted Control Structure Indicators"
  #:confidence 0.95
  #:domain '(company-law corporate-governance fraud)
  #:description "Identifies when company control structure is inverted, with non-directors exercising authority and directors excluded"
  
  #:core-indicators '(
    (authority-inversion "Authority inverted (non-director has power, directors don't)")
    (decision-making-inverted "Decision-making inverted (non-director decides)")
    (information-control-inverted "Information control inverted (non-director controls)")
    (accountability-inverted "Accountability inverted (directors responsible but lack control)")
  )
  
  #:normal-vs-inverted-structure
  '((normal-structure
      (directors "Control, decide, access information, accountable")
      (non-directors "Execute under supervision, no independent authority"))
    (inverted-structure
      (directors "Excluded, no access, no information, still accountable")
      (non-directors "Control, decide, access everything, no accountability")))
  
  #:case-application
  "RegimA Companies - Inverted Control Structure:
  
  **Normal Structure (Expected)**:
  - Directors: Control accounts, make decisions, access information, accountable
  - Rynette: Executes under director supervision, no independent authority
  
  **Inverted Structure (Actual)**:
  - Directors: Excluded from systems, no access, no information, still legally accountable
  - Rynette: Controls accounts, makes decisions, controls information, no legal accountability
  
  **Authority Inversion**:
  - Rynette has authority to make payments (claims Bantjies instructs her)
  - Directors have no authority (excluded from systems)
  
  **Decision-Making Inversion**:
  - Rynette makes financial decisions (expense allocations, payments)
  - Directors cannot make decisions (lack access and information)
  
  **Information Control Inversion**:
  - Rynette controls all information (Sage, banks, Peter's email)
  - Directors lack information (cannot access systems)
  
  **Accountability Inversion**:
  - Directors legally accountable (Section 66, fiduciary duty)
  - Directors lack control (cannot perform duties)
  - Rynette not legally accountable (not a director)
  - Rynette has all control (inverted accountability)
  
  **Legal Implications**:
  - Governance violation (inverted structure violates Companies Act)
  - Fraud facilitation (inversion enables fraud)
  - Director liability risk (accountable but powerless)
  - Ultra vires acts (Rynette exceeds authority)
  - Court intervention required to restore proper structure"
  
  #:legal-implications '(
    "Governance violation (inverted structure violates Companies Act)"
    "Fraud facilitation (inversion enables fraud)"
    "Director liability risk (accountable but powerless)"
    "Ultra vires acts (non-director exceeds authority)"
    "Accountability gap (responsible party lacks control)"
    "Court intervention required to restore proper structure"
    "Forensic audit required"
    "Non-director removal warranted"
  )
  
  #:related-principles '(
    non-director-control-red-flags
    director-exclusion-from-financial-systems
    corporate-governance-principles
    fiduciary-duty
    ultra-vires
    accountability
  )
  
  #:integration-points '(
    "LEGAL_ASPECTS_ANALYSIS_2025-11-06.json"
    "Corporate governance analysis"
  )
  
  #:test-function
  (lambda (facts)
    (let ((authority-inversion (assoc-ref facts 'authority-inversion))
          (decision-making-inverted (assoc-ref facts 'decision-making-inverted))
          (information-control-inverted (assoc-ref facts 'information-control-inverted))
          (accountability-inverted (assoc-ref facts 'accountability-inverted)))
      
      (and authority-inversion
           decision-making-inverted
           information-control-inverted
           accountability-inverted))))
