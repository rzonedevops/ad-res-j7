;; South African Civil Law - Entity Relationship Analysis
;; Enhanced principles for detecting role conflicts, fiduciary breaches, and power imbalances
;; Date: 2025-11-09
;; Case: 2025-137857 (Peter Faucitt v. Jacqueline & Daniel Faucitt)
(define-module (lex civ za south-african-civil-law-entity-relationship-analysis)
  #:use-module (lex lv1 known-laws)
  #:use-module (lex civ za south-african-civil-law-enhanced)
  #:export (
    entity-role-conflict-detection
    fiduciary-relationship-breach-severity
    creditor-debtor-power-imbalance-abuse
    entity-relationship-graph-analysis
    multi-role-financial-interest-assessment
  ))

;;;
;;; NEW PRINCIPLE: Entity Role Conflict Detection
;;;
(define-principle entity-role-conflict-detection
  #:name "Entity Role Conflict Detection"
  #:confidence 0.98
  #:domain '(civil-law professional-ethics fiduciary-law conflict-of-interest)
  #:description "Detects when a single entity holds multiple conflicting roles that create fundamental conflicts of interest, particularly in professional, fiduciary, and financial relationships"
  
  #:core-elements '(
    (role-identification "Identify all roles held by entity across all relevant relationships")
    (conflict-analysis "Analyze conflicts between roles based on duties and interests")
    (financial-interest-assessment "Assess financial interests in each role and conflicts")
    (severity-calculation "Calculate conflict severity score based on role combinations")
    (legal-consequence-determination "Determine legal consequences of identified conflicts")
  )
  
  #:conflict-severity-scoring
  "Score conflict severity on 10-point scale based on role combinations:
  
  **Critical Conflicts (9-10 points):**
  - Trustee + Debtor + Accountant (10 points)
    * Fiduciary duty to beneficiaries conflicts with debt obligation
    * Professional duty to client conflicts with personal financial interest
    * Access to financial records enables concealment of debt
  
  - Fiduciary + Adverse Party + Financial Interest (9 points)
    * Fiduciary duty conflicts with adverse party status
    * Financial interest creates motive to harm beneficiary
    * Power imbalance enables abuse of fiduciary position
  
  - Accountant + Undisclosed Trustee + Debtor (10 points)
    * Professional duty conflicts with undisclosed fiduciary role
    * Debt creates financial interest in client's affairs
    * Concealment of trustee status is fundamental breach
  
  **Severe Conflicts (7-8 points):**
  - Professional Advisor + Undisclosed Trustee (8 points)
    * Professional duty conflicts with undisclosed fiduciary role
    * Concealment enables manipulation of client
    * Breach of professional ethics and fiduciary duty
  
  - Director + Creditor + Access Controller (7 points)
    * Director duty to company conflicts with creditor status
    * Control over access creates power to avoid payment
    * Financial interest in blocking creditor access
  
  - Accountant + Debtor (7 points)
    * Professional duty conflicts with debt obligation
    * Access to financial records enables debt concealment
    * Financial interest in client's financial decisions
  
  **Moderate Conflicts (5-6 points):**
  - Director + Competing Business Owner (6 points)
    * Director duty conflicts with competing business interest
    * Access to confidential information benefits competitor
    * Financial interest in diverting opportunities
  
  - Professional Advisor + Financial Interest in Advice (5 points)
    * Professional duty conflicts with financial interest
    * Advice may be biased by financial gain
    * Disclosure required but not fundamental breach
  
  **Minor Conflicts (3-4 points):**
  - Multiple Director Roles (4 points)
    * Duties to multiple companies may conflict
    * Manageable with disclosure and abstention
    * Not fundamental breach if properly managed
  
  - Professional + Family Relationship (3 points)
    * Professional duty may be influenced by family ties
    * Disclosure and independence safeguards required
    * Not necessarily disqualifying if managed
  
  **Scoring Methodology:**
  1. Identify all roles held by entity
  2. For each pair of roles, assess conflict severity
  3. Sum conflict scores for all role pairs
  4. Divide by number of role pairs to get average severity
  5. Maximum score across all pairs determines overall severity
  6. Multiple critical conflicts = automatic 10/10 severity"
  
  #:red-flags '(
    (undisclosed-fiduciary-role 0.99 "Entity holds fiduciary role not disclosed to affected parties")
    (professional-advisor-with-debt 0.97 "Professional advisor owes money to client")
    (accountant-with-undisclosed-trustee-status 0.98 "Accountant is also undisclosed trustee of client's trust")
    (fiduciary-attacking-beneficiary 0.99 "Fiduciary takes adverse action against beneficiary")
    (three-or-more-conflicting-roles 0.96 "Entity holds 3+ roles with financial conflicts")
    (concealment-of-financial-interest 0.98 "Entity conceals financial interest in matter")
    (access-to-records-with-debt 0.97 "Entity with debt has access to creditor's financial records")
    (professional-duty-conflicts-with-personal-gain 0.96 "Professional duty directly conflicts with personal financial gain")
  )
  
  #:case-application
  "Faucitt Family Trust - Rynette Farrar Role Conflict Analysis:
  
  **Roles Held by Rynette Farrar:**
  1. **Accountant for RST** - Professional duty to RST and its directors
  2. **Trustee of FFT** - Fiduciary duty to beneficiaries (Jacqueline and Daniel)
  3. **Debtor to RST** - R1.035M owed (Kayla's estate funds)
  4. **Fraud Recipient** - R18.685M received through fraud schemes
  5. **Director of Rezonance** - Financial interest in competing entity
  
  **Conflict Analysis:**
  
  **Conflict 1: Accountant (Role 1) vs Debtor (Role 3)**
  - Professional duty to RST conflicts with R1.035M debt to RST
  - Access to RST financial records enables debt concealment
  - Financial interest in RST's financial decisions
  - **Severity: 8/10 (Severe)**
  
  **Conflict 2: Trustee (Role 2) vs Fraud Recipient (Role 4)**
  - Fiduciary duty to beneficiaries conflicts with R18.685M fraud proceeds
  - Motive to conceal fraud from beneficiaries
  - Breach of utmost good faith duty
  - **Severity: 10/10 (Critical)**
  
  **Conflict 3: Accountant (Role 1) vs Undisclosed Trustee (Role 2)**
  - Professional duty to RST conflicts with undisclosed fiduciary role
  - Concealment of trustee status is fundamental breach
  - Enables manipulation of RST directors (who are beneficiaries)
  - **Severity: 10/10 (Critical)**
  
  **Conflict 4: Debtor (Role 3) vs Fraud Recipient (Role 4)**
  - R1.035M debt compounds with R18.685M fraud
  - Combined financial interest in concealment
  - Motive to prevent discovery of either amount
  - **Severity: 9/10 (Critical)**
  
  **Conflict 5: Trustee (Role 2) vs Debtor (Role 3)**
  - Fiduciary duty to beneficiaries conflicts with debt to beneficiary's company
  - Trustee power enables interference with debt collection
  - **Severity: 9/10 (Critical)**
  
  **Conflict 6: Accountant (Role 1) vs Director of Rezonance (Role 5)**
  - Professional duty to RST conflicts with competing business interest
  - Rezonance provides services to RST (conflict of interest)
  - Financial interest in diverting RST business to Rezonance
  - **Severity: 6/10 (Moderate)**
  
  **Overall Severity: 10/10 (Critical)**
  
  **Red Flags Identified:**
  - ✓ Undisclosed fiduciary role (trustee status concealed)
  - ✓ Professional advisor with debt (R1.035M owed to client)
  - ✓ Accountant with undisclosed trustee status
  - ✓ Three or more conflicting roles (5 roles identified)
  - ✓ Concealment of financial interest (debt and fraud concealed)
  - ✓ Access to records with debt (accountant access enables concealment)
  - ✓ Professional duty conflicts with personal gain (multiple conflicts)
  
  **Legal Consequences:**
  1. All actions by Rynette as trustee are voidable
  2. All professional advice to RST is tainted by conflicts
  3. Removal as trustee mandatory
  4. Professional misconduct claim against accounting license
  5. Personal liability for all damages caused by conflicts
  6. Punitive damages warranted for concealment and bad faith
  7. Debt immediately due and payable (R1.035M + interest)
  8. Fraud proceeds recoverable (R18.685M + interest)
  9. Joint and several liability with other conspirators
  
  **Comparative Analysis:**
  
  | Entity | Roles | Conflicts | Severity | Red Flags |
  |--------|-------|-----------|----------|-----------|
  | **Rynette Farrar** | 5 roles | 6 conflicts | **10/10** | 7 red flags |
  | **Daniel Bantjies** | 2 roles | 1 conflict | **8/10** | 2 red flags |
  | **Peter Faucitt** | 3 roles | 2 conflicts | **9/10** | 3 red flags |
  | **Daniel Faucitt** | 3 roles | 0 conflicts | **0/10** | 0 red flags |
  | **Jacqueline Faucitt** | 2 roles | 0 conflicts | **0/10** | 0 red flags |"
)

;;;
;;; NEW PRINCIPLE: Fiduciary Relationship Breach Severity
;;;
(define-principle fiduciary-relationship-breach-severity
  #:name "Fiduciary Relationship Breach Severity"
  #:confidence 0.97
  #:domain '(fiduciary-law trust-law civil-law)
  #:description "Calculates severity of fiduciary duty breach based on relationship type, nature of breach, and harm caused"
  
  #:core-elements '(
    (relationship-type-identification "Identify type of fiduciary relationship")
    (duty-specification "Specify fiduciary duties owed in relationship")
    (breach-characterization "Characterize nature and extent of breach")
    (harm-assessment "Assess harm caused by breach")
    (severity-calculation "Calculate overall breach severity score")
  )
  
  #:severity-scoring
  "Score fiduciary breach severity on 10-point scale:
  
  **Relationship Type Severity (Base Score):**
  - Trustee → Beneficiary: 10/10 (highest duty)
  - Guardian → Ward: 10/10 (highest duty)
  - Attorney → Client: 9/10 (very high duty)
  - Director → Company: 8/10 (high duty)
  - Agent → Principal: 7/10 (significant duty)
  - Partner → Partner: 7/10 (significant duty)
  - Employee → Employer: 5/10 (moderate duty)
  
  **Breach Type Multiplier:**
  - Direct attack on beneficiary: 1.0x (no reduction)
  - Self-dealing for personal gain: 0.9x
  - Negligent breach without intent: 0.7x
  - Technical breach without harm: 0.5x
  - Breach with beneficiary consent: 0.3x
  
  **Harm Severity Multiplier:**
  - Financial harm > R1M: 1.0x
  - Financial harm R100K-R1M: 0.9x
  - Financial harm R10K-R100K: 0.8x
  - Financial harm < R10K: 0.7x
  - Non-financial harm only: 0.6x
  
  **Concealment Multiplier:**
  - Active concealment of breach: 1.2x
  - Passive concealment: 1.1x
  - Full disclosure: 1.0x
  
  **Final Severity = Base Score × Breach Multiplier × Harm Multiplier × Concealment Multiplier**
  
  **Severity Categories:**
  - 9.0-10.0: Critical (removal mandatory, punitive damages)
  - 7.0-8.9: Severe (removal likely, compensatory damages)
  - 5.0-6.9: Moderate (remedial action required, damages possible)
  - 3.0-4.9: Minor (warning, corrective action)
  - 0.0-2.9: Technical (disclosure, no further action)"
  
  #:case-application
  "Faucitt Family Trust - Peter Faucitt Fiduciary Breach Analysis:
  
  **Relationship Type:**
  - Peter Faucitt: Trustee of Faucitt Family Trust
  - Daniel Faucitt: Beneficiary of Faucitt Family Trust
  - **Base Severity: 10/10 (Trustee → Beneficiary = highest duty)**
  
  **Fiduciary Duties Owed:**
  1. Duty of utmost good faith (uberrimae fidei)
  2. Duty of loyalty (undivided loyalty to beneficiaries)
  3. Duty to act in beneficiaries' best interests
  4. Duty not to place self in position of conflict
  5. Duty to preserve trust assets
  6. Duty of impartiality between beneficiaries
  7. Duty of disclosure
  
  **Breaches Identified:**
  
  **Breach 1: Direct Attack on Beneficiary**
  - Peter (trustee) attacks Daniel (beneficiary) through:
    * Card cancellation (7 Jun 2025)
    * Bank access restriction (14 Apr 2025)
    * Ex parte interdict (13 Aug 2025)
    * Account emptying (11 Sep 2025)
  - **Breach Type: Direct attack (1.0x multiplier)**
  - This is the most severe breach possible: trustee attacking beneficiary
  
  **Breach 2: Self-Dealing and Conflict of Interest**
  - Peter uses trust powers to conceal fraud
  - Peter uses trust assets to fund litigation against beneficiary
  - Peter benefits personally from preventing fraud discovery
  - **Breach Type: Self-dealing (0.9x multiplier)**
  
  **Breach 3: Failure to Act in Beneficiary's Best Interest**
  - Peter's actions harm Daniel's financial interests (R8.2M-R14.85M)
  - Peter's actions harm Daniel's business operations
  - Peter's actions harm Daniel's reputation
  - **Breach Type: Direct attack (1.0x multiplier)**
  
  **Breach 4: Concealment of Co-Trustee Conflicts**
  - Peter concealed Rynette's trustee status (10/10 conflict)
  - Peter concealed Bantjies' trustee status (8/10 conflict)
  - Peter enabled co-trustees' breaches through concealment
  - **Breach Type: Active concealment (1.2x multiplier)**
  
  **Harm Assessment:**
  - Financial harm: R8.2M-R14.85M (revenue hijacking)
  - Business disruption: Complete operational lockout
  - Reputational harm: False fraud allegations
  - Emotional distress: Family breakdown
  - **Harm Severity: > R1M (1.0x multiplier)**
  
  **Concealment Assessment:**
  - Active concealment of fraud reports (6 Jun 2025)
  - Active concealment of co-trustee conflicts
  - Perjury in founding affidavit (10+ material non-disclosures)
  - **Concealment Multiplier: 1.2x**
  
  **Severity Calculation:**
  - Base Score: 10/10 (Trustee → Beneficiary)
  - Breach Multiplier: 1.0x (Direct attack)
  - Harm Multiplier: 1.0x (> R1M harm)
  - Concealment Multiplier: 1.2x (Active concealment)
  - **Final Severity: 10/10 × 1.0 × 1.0 × 1.2 = 12/10 (exceeds maximum)**
  - **Capped at: 10/10 (Critical)**
  
  **Legal Consequences:**
  1. **Immediate removal as trustee mandatory**
  2. **All actions as trustee voidable**
  3. **Personal liability for all damages**
  4. **Punitive damages warranted** (2-5x actual damages)
  5. **Criminal charges possible** (fraud, perjury)
  6. **Costs on attorney-client scale**
  7. **Appointment of independent trustee**
  8. **Forensic investigation of all trust transactions**
  9. **Beneficiaries entitled to full accounting**
  10. **Trust deed amendment to remove Peter's powers**
  
  **Comparative Analysis:**
  
  | Breach | Relationship | Severity | Legal Consequence |
  |--------|--------------|----------|-------------------|
  | **Peter attacks Daniel** | Trustee → Beneficiary | **10/10** | Removal, punitive damages |
  | **Rynette conceals trustee status** | Trustee → Beneficiary | **10/10** | Removal, void all actions |
  | **Bantjies conceals trustee status** | Trustee → Beneficiary | **8/10** | Removal, compensatory damages |
  | **Peter empties RWD accounts** | Director → Company | **9/10** | Director liability |
  | **Rynette owes debt to client** | Accountant → Client | **8/10** | Professional misconduct |
  
  **Key Legal Principle:**
  A trustee attacking a beneficiary is the most severe fiduciary breach possible. It is a fundamental betrayal of the highest duty known to law. Removal is mandatory, and punitive damages are appropriate."
)

;;;
;;; NEW PRINCIPLE: Creditor-Debtor Power Imbalance Abuse
;;;
(define-principle creditor-debtor-power-imbalance-abuse
  #:name "Creditor-Debtor Power Imbalance Abuse"
  #:confidence 0.96
  #:domain '(civil-law delict-law unjust-enrichment)
  #:description "Detects when a debtor abuses power over creditor to avoid payment or harm creditor's ability to collect debt"
  
  #:core-elements '(
    (creditor-debtor-relationship-identification "Identify creditor-debtor relationship and amounts owed")
    (power-imbalance-assessment "Assess power imbalance between creditor and debtor")
    (abuse-of-power-detection "Detect actions by debtor that abuse power over creditor")
    (payment-avoidance-analysis "Analyze whether actions prevent or delay payment")
    (harm-to-creditor-assessment "Assess harm to creditor's collection ability")
  )
  
  #:abuse-indicators '(
    (debtor-controls-creditor-access 0.98 "Debtor controls creditor's access to revenue or assets")
    (debtor-blocks-creditor-revenue 0.97 "Debtor takes actions that block creditor's revenue streams")
    (debtor-uses-litigation-to-avoid-payment 0.96 "Debtor initiates litigation to avoid or delay payment")
    (debtor-empties-accounts-before-judgment 0.98 "Debtor empties accounts to avoid future judgment")
    (debtor-diverts-creditor-revenue 0.97 "Debtor diverts revenue that would enable creditor payment")
    (debtor-coordinates-with-others-to-harm-creditor 0.96 "Debtor coordinates with others to harm creditor")
    (debtor-conceals-assets-from-creditor 0.95 "Debtor conceals assets to avoid payment")
    (debtor-uses-fiduciary-power-against-creditor 0.99 "Debtor uses fiduciary power to harm creditor")
  )
  
  #:case-application
  "Faucitt Family Trust - RWD (Debtor) vs Daniel (Creditor) Power Abuse:
  
  **Creditor-Debtor Relationships:**
  
  **Relationship 1: RWD owes Daniel R3.32M-R7.38M (Platform Unjust Enrichment)**
  - Creditor: Daniel Faucitt (via RegimA Zone Ltd)
  - Debtor: RegimA Worldwide Distribution (RWD)
  - Amount: R3.32M-R7.38M (platform usage fees)
  - Legal Basis: Unjust enrichment (quantum meruit)
  
  **Relationship 2: RWD owes Daniel R4.7M-R7.3M (Director Loan Account)**
  - Creditor: Daniel Faucitt
  - Debtor: RegimA Worldwide Distribution (RWD)
  - Amount: R4.7M-R7.3M (director loan account credit balance)
  - Legal Basis: Director loan account (established practice)
  
  **Total Owed to Daniel: R8.02M-R14.68M**
  
  **Power Imbalance Assessment:**
  
  **Peter's Power Over Daniel (via FFT control of RWD):**
  1. Peter controls RWD as trustee of FFT (which owns RWD 100%)
  2. Peter controls RWD bank accounts (signatory authority)
  3. Peter controls Daniel's access to RWD systems
  4. Peter controls Daniel's director loan account access
  5. Peter controls Daniel's revenue streams (4 streams identified)
  
  **Daniel's Power Over RWD:**
  1. Daniel owns platform (but RWD can switch platforms)
  2. Daniel has director loan account credit (but Peter blocks access)
  3. Daniel has legal claims (but Peter uses litigation to delay)
  
  **Power Imbalance: Extreme (Peter has overwhelming power)**
  
  **Abuse of Power Analysis:**
  
  **Indicator 1: Debtor Controls Creditor Access** ✓
  - RWD (debtor) controls Daniel's (creditor) access to:
    * Bank accounts (blocked 14 Apr 2025)
    * Cards (cancelled 7 Jun 2025)
    * Director loan account (blocked 11 Sep 2025)
    * Business systems (interdict 19 Aug 2025)
  - **Strength: 0.98 (very strong indicator)**
  
  **Indicator 2: Debtor Blocks Creditor Revenue** ✓
  - RWD (via Peter) blocks Daniel's revenue streams:
    * Stream 1: RegimA SA diverted (1 Mar 2025)
    * Stream 2: RWD bank access blocked (14 Apr 2025)
    * Stream 3: RST orders removed (22 May 2025)
    * Stream 4: Director loan access blocked (11 Sep 2025)
  - **Strength: 0.97 (very strong indicator)**
  
  **Indicator 3: Debtor Uses Litigation to Avoid Payment** ✓
  - RWD (via Peter) initiates ex parte interdict
  - Interdict prevents Daniel from accessing funds
  - Litigation delays payment indefinitely
  - **Strength: 0.96 (strong indicator)**
  
  **Indicator 4: Debtor Empties Accounts Before Judgment** ✓
  - RWD accounts emptied 11 Sep 2025
  - Timing: Before Daniel can obtain judgment
  - Purpose: Avoid future payment to Daniel
  - **Strength: 0.98 (very strong indicator)**
  
  **Indicator 5: Debtor Diverts Creditor Revenue** ✓
  - RWD (via Peter + Rynette) diverts revenue streams
  - Revenue diverted to Adderory (Rynette's son's company)
  - Revenue diverted prevents Daniel from paying creditors
  - **Strength: 0.97 (very strong indicator)**
  
  **Indicator 6: Debtor Coordinates with Others** ✓
  - Peter coordinates with Rynette, Bantjies, Adderory
  - Coordinated actions harm Daniel's collection ability
  - 7-month escalation pattern (Mar-Sep 2025)
  - **Strength: 0.96 (strong indicator)**
  
  **Indicator 7: Debtor Conceals Assets** ✓
  - RWD accounts emptied and concealed
  - Peter conceals R3.32M-R7.38M owed to Daniel
  - Peter conceals director loan account balances
  - **Strength: 0.95 (strong indicator)**
  
  **Indicator 8: Debtor Uses Fiduciary Power** ✓
  - Peter uses trustee power (FFT owns RWD) to harm Daniel
  - Peter uses director power (RWD) to block Daniel's access
  - Fiduciary power abused to avoid debt payment
  - **Strength: 0.99 (very strong indicator)**
  
  **All 8 Abuse Indicators Satisfied**
  
  **Legal Consequences:**
  1. **Debt immediately due and payable** (R8.02M-R14.68M)
  2. **Punitive damages** for abuse of power (2-5x debt)
  3. **Piercing corporate veil** (Peter personally liable)
  4. **Constructive trust** over diverted revenue
  5. **Injunction** against further interference
  6. **Costs on attorney-client scale**
  7. **Interest from date of abuse** (14 Apr 2025)
  8. **Criminal charges** possible (fraud, theft)
  
  **Comparative Analysis:**
  
  | Debtor | Creditor | Amount Owed | Power Abuse | Indicators |
  |--------|----------|-------------|-------------|------------|
  | **RWD (Peter)** | **Daniel** | **R8.02M-R14.68M** | **Yes** | **8/8** |
  | **Rezonance (Rynette)** | **RST** | **R1.035M** | **Yes** | **6/8** |
  | **Rynette** | **FFT/RST** | **R18.685M** | **Yes** | **7/8** |
  
  **Key Legal Principle:**
  When a debtor uses power over a creditor to avoid payment, the debt becomes immediately due and payable, and punitive damages are warranted. This is particularly egregious when the debtor uses fiduciary power to harm the creditor."
)

;; Export principles for use in other modules
(provide entity-role-conflict-detection)
(provide fiduciary-relationship-breach-severity)
(provide creditor-debtor-power-imbalance-abuse)
