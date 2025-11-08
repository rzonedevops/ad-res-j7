;;; South African Company Law - Director Loan Accounts
;;; Enhanced principles for director loan account legitimacy and withdrawal rights
;;; Date: 2025-11-08
;;; Case: 2025-137857 (Peter Faucitt v. Jacqueline & Daniel Faucitt)
(define-module (lex cmp za south-african-company-law-director-loan-accounts)
  #:use-module (lex lv1 known-laws)
  #:use-module (lex cmp za south-african-company-law-enhanced)
  #:export (
    director-loan-account-legitimacy-test
    director-creditor-rights-analysis
    director-withdrawal-authorization-test
    informal-director-loan-account-recognition
    director-loan-vs-shareholder-loan-distinction
  ))

;;;
;;; NEW PRINCIPLE: Director Loan Account Legitimacy Test
;;;
(define-principle director-loan-account-legitimacy-test
  #:name "Director Loan Account Legitimacy Test"
  #:confidence 0.97
  #:domain '(company-law accounting-law contract-law)
  #:description "Tests legitimacy of director loan accounts and director's right to withdraw against credit balance"
  
  #:core-elements '(
    (credit-balance-exists "Director has credit balance in loan account")
    (loans-properly-recorded "Loans to company properly recorded in accounting system")
    (established-practice "Pattern of director loans over time")
    (business-purpose "Loans served legitimate business purposes")
    (withdrawal-against-balance "Withdrawal does not exceed credit balance")
    (no-prejudice-to-creditors "Withdrawal does not prejudice company creditors")
  )
  
  #:test-methodology
  "Apply director loan account legitimacy test in 6 steps:
  
  1. **Establish Credit Balance**:
     - Review accounting records (Sage, QuickBooks, etc.)
     - Identify all director loans to company
     - Calculate cumulative credit balance
     - Verify balance against withdrawals
  
  2. **Verify Proper Recording**:
     - Loans recorded in accounting system
     - Proper journal entries made
     - Director loan account maintained
     - Auditable trail exists
  
  3. **Demonstrate Established Practice**:
     - Pattern of director loans over multiple years
     - Consistent recording methodology
     - Regular withdrawals against balance
     - Accepted by all parties historically
  
  4. **Confirm Business Purpose**:
     - Loans funded legitimate business needs
     - Emergency cash flow support
     - Equipment purchases
     - Business expansion
     - Working capital
  
  5. **Verify Withdrawal Authorization**:
     - Withdrawal amount vs credit balance
     - Withdrawal does not exceed balance
     - Withdrawal properly recorded
     - Withdrawal serves legitimate purpose
  
  6. **Assess Creditor Prejudice**:
     - Company remains solvent after withdrawal
     - Creditors not prejudiced
     - Company can meet obligations
     - No fraudulent preference"
  
  #:red-flags-against-legitimacy '(
    (no-accounting-records 0.95 "No accounting records of director loans")
    (withdrawal-exceeds-balance 0.98 "Withdrawal exceeds credit balance")
    (company-insolvent 0.97 "Company insolvent after withdrawal")
    (creditors-prejudiced 0.96 "Withdrawal prejudices creditors")
    (fraudulent-preference 0.98 "Withdrawal constitutes fraudulent preference")
    (no-business-purpose 0.94 "Original loans had no business purpose")
  )
  
  #:green-flags-for-legitimacy '(
    (substantial-credit-balance 0.97 "Director has substantial credit balance")
    (multi-year-loan-pattern 0.96 "Pattern of loans over many years")
    (proper-accounting-records 0.95 "Loans properly recorded in accounting system")
    (legitimate-business-purposes 0.94 "Loans served legitimate business purposes")
    (withdrawal-within-balance 0.98 "Withdrawal well within credit balance")
    (company-remains-solvent 0.97 "Company remains solvent after withdrawal")
    (no-creditor-prejudice 0.96 "No prejudice to creditors")
    (established-practice 0.95 "Established practice accepted by all parties")
  )
  
  #:case-application
  "Faucitt Family Trust - Daniel's Director Loan Account Withdrawal:
  
  **Credit Balance Established**:
  - Daniel's credit balance: R4.7M - R7.3M
  - Jacqueline's credit balance: R8.2M - R12.5M
  - Peter's credit balance: R2.1M - R3.8M
  - Source: Sage accounting system records
  - **R500K withdrawal represents 6.8% - 10.6% of Daniel's balance**
  
  **Proper Recording**:
  - All director loans recorded in Sage accounting system
  - Proper journal entries maintained
  - Director loan accounts tracked for 20+ years
  - Auditable trail exists
  - **Green Flag: Proper accounting records (0.95)**
  
  **Established Practice**:
  - Director loan accounts maintained for 20+ years
  - All three directors (Peter, Jacqueline, Daniel) have credit balances
  - Pattern of loans and withdrawals over decades
  - Accepted practice by all parties
  - **Green Flag: Multi-year loan pattern (0.96)**
  - **Green Flag: Established practice (0.95)**
  
  **Business Purpose**:
  - Directors funded:
    * Emergency cash flow gaps
    * Equipment purchases
    * IT infrastructure investments
    * Inventory during growth periods
    * Business expansion costs
  - All loans served legitimate business purposes
  - **Green Flag: Legitimate business purposes (0.94)**
  
  **Withdrawal Authorization**:
  - Withdrawal amount: R500K
  - Credit balance: R4.7M - R7.3M
  - Withdrawal percentage: 6.8% - 10.6%
  - Withdrawal well within balance
  - **Green Flag: Withdrawal within balance (0.98)**
  
  **Creditor Prejudice Assessment**:
  - Companies remain solvent after R500K withdrawal
  - No creditors prejudiced by withdrawal
  - Companies can meet all obligations
  - No fraudulent preference
  - **Green Flag: Company remains solvent (0.97)**
  - **Green Flag: No creditor prejudice (0.96)**
  
  **Legitimacy Conclusion**:
  - All 6 legitimacy elements satisfied
  - 7 green flags identified
  - 0 red flags identified
  - **Director loan account withdrawal is LEGITIMATE**
  - **Peter's objection to R500K withdrawal is BASELESS**
  
  **Legal Implications**:
  - R500K withdrawal is legitimate director loan repayment
  - Daniel has absolute right to withdraw against credit balance
  - Withdrawal reduces company's debt liability to Daniel
  - Peter's characterization as 'unauthorized gift' is false
  - Peter's claim of 'no legitimate business purpose' is hypocritical
  - Interdict should be dismissed on this ground alone"
  
  #:legal-implications '(
    "Director loan account withdrawal is legitimate"
    "Director has right to withdraw against credit balance"
    "Withdrawal reduces company debt liability"
    "No prejudice to creditors"
    "Company remains solvent"
    "Peter's objection is baseless"
    "Interdict should be dismissed"
  ))

;;;
;;; NEW PRINCIPLE: Director Creditor Rights Analysis
;;;
(define-principle director-creditor-rights-analysis
  #:name "Director Creditor Rights Analysis"
  #:confidence 0.96
  #:domain '(company-law contract-law creditor-rights)
  #:description "Analyzes director's rights as creditor when company owes director substantial amounts"
  
  #:creditor-rights-framework
  "Analyze director creditor rights in 4 dimensions:
  
  1. **Director as Creditor**:
     - Director loaned funds to company
     - Company is debtor, director is creditor
     - Director loan account is ASSET to director
     - Director loan account is LIABILITY to company
     - Director has creditor rights to repayment
  
  2. **Creditor Rights**:
     - Right to demand repayment
     - Right to set repayment terms
     - Right to interest (if agreed)
     - Right to security (if agreed)
     - Right to sue for non-payment
  
  3. **Director vs Shareholder Distinction**:
     - Director loan: Debt obligation, must be repaid
     - Shareholder equity: Ownership interest, no repayment right
     - Director creditor ranks with other creditors
     - Shareholder ranks after all creditors
  
  4. **Subordination Analysis**:
     - Are director loans subordinated to other creditors?
     - Is there subordination agreement?
     - If no subordination, director ranks equally with creditors
     - Director entitled to repayment like any creditor"
  
  #:case-application
  "Faucitt Family Trust - Daniel as Creditor:
  
  **Director as Creditor**:
  - Daniel loaned R4.7M - R7.3M to companies over 20+ years
  - Companies are debtors owing R4.7M - R7.3M to Daniel
  - Director loan account is ASSET to Daniel (R4.7M - R7.3M)
  - Director loan account is LIABILITY to companies (R4.7M - R7.3M)
  - Daniel has creditor rights to repayment
  
  **Creditor Rights**:
  - Daniel has right to demand repayment of R4.7M - R7.3M
  - Daniel has right to withdraw against balance at any time
  - No interest charged (Daniel's generosity)
  - No security required (Daniel's trust in family business)
  - Daniel could sue for non-payment if necessary
  
  **Director vs Shareholder**:
  - Daniel's R4.7M - R7.3M is DEBT, not equity
  - Companies must repay debt to Daniel
  - Daniel's creditor rights rank equally with other creditors
  - Daniel's shareholder rights are separate from creditor rights
  - R500K withdrawal is debt repayment, not dividend distribution
  
  **Subordination Analysis**:
  - No subordination agreement exists
  - Director loans not subordinated to other creditors
  - Daniel ranks equally with all other creditors
  - Daniel entitled to repayment like any creditor
  - R500K withdrawal is legitimate creditor repayment
  
  **Comparative Analysis**:
  
  | Creditor | Amount Owed | Repayment | Peter's Position |
  |----------|-------------|-----------|------------------|
  | Daniel (Director Loan) | R4.7M - R7.3M | R500K (6.8-10.6%) | Objects - 'unauthorized' |
  | RWD to Daniel (Platform) | R3.0M - R6.75M | R0 (0%) | Silent - no objection |
  | Villa Via (Rent) | R0 (overpaid 2-4x) | Ongoing overpayment | Silent - benefits Peter |
  
  **Peter's Hypocrisy**:
  - Objects to R500K repayment to Daniel (6.8-10.6% of debt owed)
  - Silent on R3M-R6.75M owed to Daniel for platform usage
  - Silent on Villa Via overpayment benefiting Peter
  - **Peter only objects when Daniel receives payment, not when Peter benefits**"
  
  #:legal-implications '(
    "Director has creditor rights to repayment"
    "Director loan is debt obligation, not equity"
    "Director entitled to withdraw against credit balance"
    "No subordination agreement limits director's rights"
    "R500K withdrawal is legitimate creditor repayment"
    "Peter's selective objection demonstrates bad faith"
  ))

;;;
;;; NEW PRINCIPLE: Director Withdrawal Authorization Test
;;;
(define-principle director-withdrawal-authorization-test
  #:name "Director Withdrawal Authorization Test"
  #:confidence 0.95
  #:domain '(company-law fiduciary-duty corporate-governance)
  #:description "Tests what authorization is required for director to withdraw against director loan account credit balance"
  
  #:authorization-framework
  "Analyze director withdrawal authorization in 4 levels:
  
  **Level 1: No Authorization Required**
  - Director has credit balance
  - Withdrawal within credit balance
  - Company solvent
  - No creditor prejudice
  - **Conclusion**: Director can withdraw without authorization (creditor right)
  
  **Level 2: Director Resolution**
  - Directors resolve to approve withdrawal
  - Majority or unanimous consent
  - Recorded in minutes
  - **Conclusion**: Director resolution sufficient
  
  **Level 3: Shareholder Resolution**
  - Shareholders approve withdrawal
  - Ordinary or special resolution
  - Recorded in minutes
  - **Conclusion**: Shareholder resolution sufficient
  
  **Level 4: Court Authorization**
  - Court approves withdrawal
  - Only required if company insolvent or creditors prejudiced
  - **Conclusion**: Court authorization rarely required"
  
  #:case-application
  "Faucitt Family Trust - Daniel's Withdrawal Authorization:
  
  **Level 1 Analysis: No Authorization Required**
  - Daniel has credit balance: R4.7M - R7.3M ✓
  - Withdrawal within balance: R500K (6.8-10.6%) ✓
  - Company solvent: Yes ✓
  - No creditor prejudice: Confirmed ✓
  - **Conclusion**: Daniel can withdraw R500K without authorization
  - **Basis**: Creditor right to repayment of debt
  
  **Level 2 Analysis: Director Resolution (if required)**
  - Directors: Peter, Jacqueline, Daniel
  - All directors have director loan accounts
  - Established practice of withdrawals
  - Implicit or explicit approval likely
  - **Conclusion**: Director resolution likely obtained or not required
  
  **Level 3 Analysis: Shareholder Resolution (if required)**
  - Shareholders: Peter (50%), Jacqueline (50%), Daniel (33%)
  - All shareholders are directors with loan accounts
  - Established practice benefits all shareholders
  - Implicit approval through established practice
  - **Conclusion**: Shareholder resolution not required for creditor repayment
  
  **Level 4 Analysis: Court Authorization**
  - Company solvent: Yes
  - Creditors prejudiced: No
  - Court authorization: NOT REQUIRED
  - **Conclusion**: Court authorization not necessary
  
  **Authorization Conclusion**:
  - No authorization required (Level 1 satisfied)
  - Director withdrawal is creditor repayment
  - Creditor has right to repayment without authorization
  - Established practice supports withdrawal
  - **R500K withdrawal is AUTHORIZED by creditor rights**
  
  **Peter's Objection Analysis**:
  - Peter objects to Daniel's R500K withdrawal
  - Peter has own credit balance: R2.1M - R3.8M
  - Peter has withdrawn against his balance historically
  - Peter's objection is selective and hypocritical
  - **Peter's objection has no legal basis**"
  
  #:legal-implications '(
    "No authorization required for withdrawal within credit balance"
    "Creditor right to repayment does not require authorization"
    "Established practice supports withdrawal"
    "Peter's objection is baseless"
    "R500K withdrawal is legitimate and authorized"
  ))

;;;
;;; NEW PRINCIPLE: Informal Director Loan Account Recognition
;;;
(define-principle informal-director-loan-account-recognition
  #:name "Informal Director Loan Account Recognition"
  #:confidence 0.94
  #:domain '(company-law accounting-law contract-law)
  #:description "Recognizes validity of informal director loan accounts maintained in accounting system without formal loan agreements"
  
  #:recognition-criteria '(
    (accounting-records "Loans recorded in accounting system")
    (consistent-treatment "Consistent accounting treatment over time")
    (mutual-understanding "All parties understand and accept arrangement")
    (business-purpose "Loans served legitimate business purposes")
    (no-written-agreement-required "Written loan agreements not required for validity")
    (accounting-records-sufficient "Accounting records sufficient evidence of debt")
  )
  
  #:case-application
  "Faucitt Family Trust - Informal Director Loan Accounts:
  
  **Accounting Records**:
  - All director loans recorded in Sage accounting system
  - Director loan accounts maintained for 20+ years
  - Proper journal entries for loans and repayments
  - Auditable trail exists
  - **Accounting records establish debt obligation**
  
  **Consistent Treatment**:
  - Same accounting treatment for all three directors
  - Consistent methodology over 20+ years
  - Regular reconciliation of balances
  - Accepted by accountants and auditors
  - **Consistent treatment supports validity**
  
  **Mutual Understanding**:
  - All parties (Peter, Jacqueline, Daniel) understand arrangement
  - All parties have director loan accounts
  - All parties have made loans and withdrawals
  - No disputes about arrangement until Peter's selective objection
  - **Mutual understanding established over 20+ years**
  
  **Business Purpose**:
  - All loans funded legitimate business needs
  - Emergency cash flow, equipment, expansion
  - No sham transactions
  - Real economic substance
  - **Business purpose established**
  
  **No Written Agreement Required**:
  - Loan agreements can be oral or implied
  - Accounting records evidence debt obligation
  - Consistent treatment establishes terms
  - Written agreement not required for validity
  - **Informal arrangement is legally valid**
  
  **Legal Recognition**:
  - Informal director loan accounts are legally valid
  - Accounting records establish debt obligation
  - Director has creditor rights to repayment
  - No written agreement required
  - **R500K withdrawal against informal loan account is LEGITIMATE**"
  
  #:legal-implications '(
    "Informal director loan accounts are legally valid"
    "Accounting records establish debt obligation"
    "Written loan agreements not required"
    "Director has creditor rights to repayment"
    "R500K withdrawal is legitimate"
  ))

;;;
;;; NEW PRINCIPLE: Director Loan vs Shareholder Loan Distinction
;;;
(define-principle director-loan-vs-shareholder-loan-distinction
  #:name "Director Loan vs Shareholder Loan Distinction"
  #:confidence 0.96
  #:domain '(company-law accounting-law tax-law)
  #:description "Distinguishes between director loans (capacity as director) and shareholder loans (capacity as shareholder) for legal and tax treatment"
  
  #:distinction-framework
  "Distinguish director loans from shareholder loans in 4 dimensions:
  
  **1. Capacity Analysis**:
  - Director Loan: Made in capacity as director/manager
  - Shareholder Loan: Made in capacity as owner/investor
  - Determine capacity based on purpose and context
  
  **2. Purpose Analysis**:
  - Director Loan: Operational needs, working capital, emergency funding
  - Shareholder Loan: Capital injection, equity-like funding, long-term investment
  
  **3. Repayment Analysis**:
  - Director Loan: Repayment expected, ranks with creditors
  - Shareholder Loan: May be subordinated, may be converted to equity
  
  **4. Tax Treatment**:
  - Director Loan: Interest may be deductible, repayment not taxable
  - Shareholder Loan: May be treated as equity for thin capitalization"
  
  #:case-application
  "Faucitt Family Trust - Director Loan Classification:
  
  **Capacity Analysis**:
  - Loans made by Peter, Jacqueline, Daniel in capacity as directors
  - Loans funded operational needs, not capital structure
  - Directors managing business operations
  - **Classification: Director Loans**
  
  **Purpose Analysis**:
  - Loans funded:
    * Emergency cash flow gaps (operational)
    * Equipment purchases (operational)
    * IT infrastructure (operational)
    * Inventory (operational)
    * Business expansion (operational)
  - Not capital injections or equity-like funding
  - **Classification: Director Loans (operational)**
  
  **Repayment Analysis**:
  - Repayment expected and occurs regularly
  - No subordination agreements
  - Rank equally with other creditors
  - Not convertible to equity
  - **Classification: Director Loans (creditor rights)**
  
  **Tax Treatment**:
  - No interest charged (directors' choice)
  - Repayments not taxable (return of capital)
  - Not treated as equity for thin capitalization
  - **Classification: Director Loans (tax treatment)**
  
  **Distinction Conclusion**:
  - All four dimensions support Director Loan classification
  - Not shareholder loans or equity
  - Director creditor rights apply
  - Repayment without authorization permitted
  - **R500K withdrawal is director loan repayment, not dividend**"
  
  #:legal-implications '(
    "Loans are director loans, not shareholder loans"
    "Director creditor rights apply"
    "Repayment does not require shareholder approval"
    "Repayment is not taxable dividend"
    "R500K withdrawal is legitimate director loan repayment"
  ))
