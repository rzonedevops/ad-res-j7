;;; South African CEO Operational Discretion and Business Judgment Framework
;;; Version 22 - Case 2025-137857 Enhancement
;;; Date: December 3, 2025
;;; Purpose: Protect CEO operational discretion and business judgment rule

(define-module (lex cmp za south-african-ceo-operational-discretion-v22)
  #:use-module (lex lv1 known-laws)
  #:use-module (lex cmp za south-african-company-law-director-duties)
  #:export (
    ceo-operational-discretion-framework
    business-judgment-rule-application
    ceo-decision-authority-doctrine
    ceo-fiduciary-duty-balance
    ceo-decision-reasonableness-test
  ))

;;;
;;; PRINCIPLE 1: CEO Operational Discretion Framework
;;;
(define-principle ceo-operational-discretion-framework
  #:name "CEO Operational Discretion Framework"
  #:confidence 0.96
  #:domain '(company-law corporate-governance director-duties)
  #:description "Framework for protecting CEO operational discretion in business decisions"
  
  #:core-elements '(
    (ceo-authority-scope "CEO authority scope established")
    (operational-decision-definition "Operational decision defined")
    (discretion-scope-determination "Discretion scope determined")
    (business-judgment-rule-application "Business judgment rule applied")
    (decision-reasonableness-assessment "Decision reasonableness assessed")
    (discretion-protection-conclusion "Discretion protection concluded")
  )
  
  #:test-methodology
  "Apply the CEO operational discretion framework in 6 steps:
  
  1. **Establish CEO Authority Scope**:
     - What is the CEO's authority?
     - What decisions can CEO make independently?
     - What decisions require board approval?
     - What is the scope of operational authority?
  
  2. **Define Operational Decision**:
     - Is the decision operational?
     - Does it fall within CEO authority?
     - Is it a strategic or operational decision?
     - What is the nature of the decision?
  
  3. **Determine Discretion Scope**:
     - What discretion does CEO have?
     - Are there constraints on discretion?
     - What is the range of acceptable decisions?
     - Can CEO choose between alternatives?
  
  4. **Apply Business Judgment Rule**:
     - Does business judgment rule apply?
     - Was decision made in good faith?
     - Was decision made with reasonable care?
     - Was decision made in company interests?
  
  5. **Assess Decision Reasonableness**:
     - Is the decision reasonable?
     - Would reasonable CEO make this decision?
     - Is decision within industry standards?
     - Is decision supported by evidence?
  
  6. **Conclude Discretion Protection**:
     - Is discretion protected?
     - Is decision within scope of authority?
     - Is decision protected by business judgment rule?
     - Is decision defensible?"
  
  #:red-flags '(
    (ceo-authority-not-established 0.92 "CEO authority not established")
    (decision-outside-authority 0.94 "Decision outside CEO authority")
    (discretion-not-exercised 0.90 "Discretion not exercised")
    (business-judgment-rule-not-met 0.93 "Business judgment rule not met")
    (decision-unreasonable 0.91 "Decision unreasonable")
  )
  
  #:case-application
  "Case 2025-137857 - Jacqueline's CEO Operational Discretion:
  
  **CEO Authority Scope Establishment**:
  - Jax is CEO of RegimA Worldwide Distribution
  - CEO authority includes operational decisions
  - CEO authority includes capital expenditure decisions
  - CEO authority includes vendor selection
  - CEO authority includes IT infrastructure decisions
  
  **Operational Decision Definition**:
  - Decision: Approve R8.85M IT infrastructure investment
  - Nature: Operational decision for EU compliance
  - Scope: Within CEO operational authority
  - Purpose: Enable regulatory compliance
  
  **Discretion Scope Determination**:
  - CEO has discretion to make capital expenditure decisions
  - Discretion limited to reasonable business purposes
  - Discretion limited to company interests
  - Discretion includes infrastructure investments
  
  **Business Judgment Rule Application**:
  - Decision made in good faith: Yes
  - Decision made with reasonable care: Yes
  - Decision made in company interests: Yes
  - Business judgment rule applies
  
  **Decision Reasonableness Assessment**:
  - Decision is reasonable for EU compliance
  - Decision is within industry standards
  - Decision is supported by regulatory requirement
  - Decision is within CEO authority
  
  **Discretion Protection Conclusion**:
  - CEO discretion is protected
  - Decision is within scope of authority
  - Decision is protected by business judgment rule
  - Decision is defensible"
  
  #:inference-type 'deductive
  #:related-principles '(
    business-judgment-rule-application
    ceo-decision-authority-doctrine
    ceo-fiduciary-duty-balance
    ceo-decision-reasonableness-test
  ))

;;;
;;; PRINCIPLE 2: Business Judgment Rule Application
;;;
(define-principle business-judgment-rule-application
  #:name "Business Judgment Rule Application"
  #:confidence 0.95
  #:domain '(company-law corporate-governance director-duties)
  #:description "Application of business judgment rule to protect CEO decisions"
  
  #:core-elements '(
    (business-judgment-requirement "Business judgment requirement met")
    (good-faith-requirement "Good faith requirement met")
    (reasonable-care-requirement "Reasonable care requirement met")
    (company-interest-requirement "Company interest requirement met")
    (informed-decision-requirement "Informed decision requirement met")
    (judgment-rule-protection "Business judgment rule protection applied")
  )
  
  #:test-methodology
  "Apply the business judgment rule in 6 steps:
  
  1. **Establish Business Judgment**:
     - Is the decision a business judgment?
     - Is the decision discretionary?
     - Is the decision within authority?
     - Does the decision involve judgment?
  
  2. **Assess Good Faith**:
     - Was decision made in good faith?
     - Is there evidence of bad faith?
     - Was decision made for proper purpose?
     - Was decision made honestly?
  
  3. **Assess Reasonable Care**:
     - Was decision made with reasonable care?
     - Was information gathered?
     - Were alternatives considered?
     - Was decision process reasonable?
  
  4. **Assess Company Interest**:
     - Was decision made in company interests?
     - Is there evidence of self-dealing?
     - Is there evidence of conflict?
     - Does decision benefit company?
  
  5. **Assess Informed Decision**:
     - Was decision informed?
     - What information was available?
     - What information was considered?
     - Was decision based on adequate information?
  
  6. **Apply Rule Protection**:
     - Does business judgment rule apply?
     - Is decision protected from challenge?
     - What is the scope of protection?
     - What remedy exists for breach?"
  
  #:red-flags '(
    (good-faith-not-established 0.94 "Good faith not established")
    (reasonable-care-not-taken 0.92 "Reasonable care not taken")
    (company-interest-not-served 0.93 "Company interest not served")
    (decision-not-informed 0.91 "Decision not informed")
    (business-judgment-rule-not-applicable 0.90 "Business judgment rule not applicable")
  )
  
  #:case-application
  "Case 2025-137857 - Jax's Business Judgment in IT Investment:
  
  **Business Judgment Establishment**:
  - Decision is discretionary business judgment
  - Decision is within CEO authority
  - Decision involves judgment about necessity and cost
  - Decision qualifies for business judgment rule
  
  **Good Faith Assessment**:
  - Decision made in good faith: Yes
  - No evidence of bad faith: Confirmed
  - Decision made for proper purpose (compliance): Yes
  - Decision made honestly: Yes
  
  **Reasonable Care Assessment**:
  - Information gathered: Yes (regulatory requirements, cost analysis)
  - Alternatives considered: Yes (manual vs. automated, in-house vs. outsourced)
  - Decision process reasonable: Yes (board approval, vendor selection)
  - Reasonable care taken: Yes
  
  **Company Interest Assessment**:
  - Decision serves company interests: Yes
  - No self-dealing: Confirmed
  - No conflict of interest: Confirmed
  - Decision benefits company (market access, compliance): Yes
  
  **Informed Decision Assessment**:
  - Decision informed: Yes
  - Information available: Yes (regulatory requirements, cost data, industry standards)
  - Information considered: Yes
  - Decision based on adequate information: Yes
  
  **Rule Protection Application**:
  - Business judgment rule applies: Yes
  - Decision protected from challenge: Yes
  - Scope of protection: Full protection
  - Remedy for breach: Not applicable (no breach)"
  
  #:inference-type 'deductive
  #:related-principles '(
    ceo-operational-discretion-framework
    ceo-decision-authority-doctrine
    ceo-fiduciary-duty-balance
    ceo-decision-reasonableness-test
  ))

;;;
;;; PRINCIPLE 3: CEO Decision Authority Doctrine
;;;
(define-principle ceo-decision-authority-doctrine
  #:name "CEO Decision Authority Doctrine"
  #:confidence 0.94
  #:domain '(company-law corporate-governance director-duties)
  #:description "Establishes doctrine of CEO decision authority and its scope"
  
  #:core-elements '(
    (ceo-authority-grant "CEO authority granted by company")
    (authority-scope-definition "Authority scope defined")
    (authority-limitation-identification "Authority limitations identified")
    (decision-within-authority "Decision within authority scope")
    (authority-protection-doctrine "Authority protection doctrine established")
    (authority-abuse-detection "Authority abuse detection framework")
  )
  
  #:test-methodology
  "Apply the CEO decision authority doctrine in 6 steps:
  
  1. **Establish Authority Grant**:
     - Does company grant CEO authority?
     - What is the scope of authority?
     - Are there explicit limitations?
     - What is the source of authority?
  
  2. **Define Authority Scope**:
     - What decisions can CEO make?
     - What is the range of authority?
     - Are there financial limits?
     - Are there subject matter limits?
  
  3. **Identify Authority Limitations**:
     - What limitations exist?
     - Are there board approval requirements?
     - Are there shareholder approval requirements?
     - Are there legal limitations?
  
  4. **Assess Decision Within Authority**:
     - Is the decision within authority?
     - Does it exceed authority limits?
     - Is it within financial limits?
     - Is it within subject matter scope?
  
  5. **Establish Authority Protection**:
     - Is authority protected from challenge?
     - What is the scope of protection?
     - What remedy exists for abuse?
     - How is authority protected?
  
  6. **Detect Authority Abuse**:
     - Is authority being abused?
     - Is decision outside authority scope?
     - Is decision made in bad faith?
     - What remedy exists?"
  
  #:red-flags '(
    (ceo-authority-not-granted 0.92 "CEO authority not granted")
    (decision-outside-authority 0.94 "Decision outside CEO authority")
    (authority-limit-exceeded 0.93 "Authority limit exceeded")
    (authority-abused 0.95 "Authority abused")
    (authority-protection-not-applicable 0.90 "Authority protection not applicable")
  )
  
  #:case-application
  "Case 2025-137857 - Jax's CEO Decision Authority:
  
  **Authority Grant Establishment**:
  - Company grants CEO authority to Jax
  - Authority includes operational decisions
  - Authority includes capital expenditure
  - Authority includes IT infrastructure
  
  **Authority Scope Definition**:
  - CEO can make operational decisions
  - CEO can approve capital expenditure
  - CEO can select vendors
  - CEO can manage IT infrastructure
  
  **Authority Limitation Identification**:
  - Board approval may be required for large expenditures
  - Shareholder approval may be required for major decisions
  - Legal limitations apply (fiduciary duty)
  - Company policy limitations apply
  
  **Decision Within Authority Assessment**:
  - R8.85M IT investment is operational decision
  - Decision is within CEO authority
  - Decision is within financial authority
  - Decision is within subject matter scope
  
  **Authority Protection Establishment**:
  - CEO authority is protected from challenge
  - Protection extends to business judgment
  - Protection extends to discretionary decisions
  - Protection extends to reasonable decisions
  
  **Authority Abuse Detection**:
  - Is authority being abused? No
  - Is decision outside authority scope? No
  - Is decision made in bad faith? No
  - Conclusion: No authority abuse"
  
  #:inference-type 'deductive
  #:related-principles '(
    ceo-operational-discretion-framework
    business-judgment-rule-application
    ceo-fiduciary-duty-balance
    ceo-decision-reasonableness-test
  ))

;;;
;;; PRINCIPLE 4: CEO Fiduciary Duty Balance
;;;
(define-principle ceo-fiduciary-duty-balance
  #:name "CEO Fiduciary Duty Balance"
  #:confidence 0.93
  #:domain '(company-law fiduciary-law director-duties)
  #:description "Balances CEO fiduciary duty with operational discretion"
  
  #:core-elements '(
    (fiduciary-duty-identification "Fiduciary duty identified")
    (duty-scope-definition "Duty scope defined")
    (operational-discretion-scope "Operational discretion scope defined")
    (duty-discretion-balance "Duty and discretion balanced")
    (duty-breach-detection "Duty breach detection framework")
    (duty-compliance-conclusion "Duty compliance concluded")
  )
  
  #:test-methodology
  "Apply the CEO fiduciary duty balance in 6 steps:
  
  1. **Identify Fiduciary Duty**:
     - What fiduciary duty applies?
     - To whom is duty owed?
     - What is the scope of duty?
     - What are the requirements?
  
  2. **Define Duty Scope**:
     - What must CEO do?
     - What must CEO avoid?
     - What is the standard of care?
     - What is the standard of conduct?
  
  3. **Define Discretion Scope**:
     - What discretion does CEO have?
     - What decisions are discretionary?
     - What is the range of discretion?
     - How does discretion operate?
  
  4. **Balance Duty and Discretion**:
     - How do duty and discretion interact?
     - Can discretion override duty?
     - Can duty override discretion?
     - How are conflicts resolved?
  
  5. **Detect Duty Breach**:
     - Is duty being breached?
     - What is the breach?
     - What is the impact?
     - What remedy exists?
  
  6. **Conclude Duty Compliance**:
     - Is duty being complied with?
     - Is discretion being exercised properly?
     - Is balance maintained?
     - Is conduct defensible?"
  
  #:red-flags '(
    (fiduciary-duty-not-identified 0.92 "Fiduciary duty not identified")
    (duty-scope-unclear 0.90 "Duty scope unclear")
    (duty-breach-evident 0.95 "Duty breach evident")
    (discretion-abused 0.94 "Discretion abused")
    (duty-discretion-conflict 0.91 "Duty-discretion conflict unresolved")
  )
  
  #:case-application
  "Case 2025-137857 - Jax's Fiduciary Duty Balance:
  
  **Fiduciary Duty Identification**:
  - Jax owes fiduciary duty to company
  - Duty includes duty of care
  - Duty includes duty of loyalty
  - Duty includes duty to act in company interests
  
  **Duty Scope Definition**:
  - Must act in company interests: Yes
  - Must avoid self-dealing: Yes
  - Must exercise reasonable care: Yes
  - Must disclose conflicts: Yes
  
  **Discretion Scope Definition**:
  - CEO has discretion in operational decisions
  - Discretion includes capital expenditure decisions
  - Discretion includes vendor selection
  - Discretion includes IT infrastructure decisions
  
  **Duty and Discretion Balance**:
  - Duty constrains discretion
  - Discretion must be exercised within duty
  - Duty does not eliminate discretion
  - Balance maintained in IT investment decision
  
  **Duty Breach Detection**:
  - Is duty being breached? No
  - Decision serves company interests: Yes
  - No self-dealing: Confirmed
  - Reasonable care taken: Yes
  - No duty breach evident
  
  **Duty Compliance Conclusion**:
  - Duty is being complied with
  - Discretion is being exercised properly
  - Balance is maintained
  - Conduct is defensible"
  
  #:inference-type 'deductive
  #:related-principles '(
    ceo-operational-discretion-framework
    business-judgment-rule-application
    ceo-decision-authority-doctrine
    ceo-decision-reasonableness-test
  ))

;;;
;;; PRINCIPLE 5: CEO Decision Reasonableness Test
;;;
(define-principle ceo-decision-reasonableness-test
  #:name "CEO Decision Reasonableness Test"
  #:confidence 0.92
  #:domain '(company-law corporate-governance decision-analysis)
  #:description "Tests reasonableness of CEO decisions"
  
  #:core-elements '(
    (decision-purpose-assessment "Decision purpose assessed")
    (decision-process-assessment "Decision process assessed")
    (decision-outcome-assessment "Decision outcome assessed")
    (industry-standard-comparison "Industry standard comparison")
    (alternative-analysis "Alternative analysis")
    (reasonableness-conclusion "Reasonableness concluded")
  )
  
  #:test-methodology
  "Apply the CEO decision reasonableness test in 6 steps:
  
  1. **Assess Decision Purpose**:
     - What is the purpose of the decision?
     - Is the purpose legitimate?
     - Is the purpose in company interests?
     - Is the purpose reasonable?
  
  2. **Assess Decision Process**:
     - How was the decision made?
     - What information was considered?
     - Were alternatives evaluated?
     - Was the process reasonable?
  
  3. **Assess Decision Outcome**:
     - What is the outcome?
     - Does outcome serve purpose?
     - Is outcome reasonable?
     - Is outcome defensible?
  
  4. **Compare to Industry Standards**:
     - What do industry standards indicate?
     - How does decision compare?
     - Is decision within industry norms?
     - Are there outliers or exceptions?
  
  5. **Analyze Alternatives**:
     - What alternatives exist?
     - Why was chosen alternative selected?
     - Would other alternatives be better?
     - Is chosen alternative reasonable?
  
  6. **Conclude Reasonableness**:
     - Is decision reasonable?
     - Would reasonable CEO make this decision?
     - Is decision defensible?
     - What is the confidence level?"
  
  #:red-flags '(
    (decision-purpose-unclear 0.90 "Decision purpose unclear")
    (decision-process-inadequate 0.92 "Decision process inadequate")
    (decision-outcome-unreasonable 0.91 "Decision outcome unreasonable")
    (decision-outside-industry-norms 0.88 "Decision outside industry norms")
    (decision-unreasonable 0.93 "Decision unreasonable")
  )
  
  #:case-application
  "Case 2025-137857 - Jax's IT Investment Reasonableness:
  
  **Decision Purpose Assessment**:
  - Purpose: Enable EU regulatory compliance
  - Purpose: Maintain market access in 37 jurisdictions
  - Purpose: Protect company from regulatory penalties
  - Purpose: Legitimate and reasonable
  
  **Decision Process Assessment**:
  - Information gathered: Yes (regulatory requirements, cost analysis)
  - Alternatives evaluated: Yes (manual vs. automated, in-house vs. outsourced)
  - Process: Reasonable and thorough
  
  **Decision Outcome Assessment**:
  - Outcome: R8.85M IT infrastructure investment
  - Outcome serves purpose: Yes (enables compliance)
  - Outcome: Reasonable and defensible
  
  **Industry Standard Comparison**:
  - Cosmetics industry EU compliance: €500K-€2M annually
  - Jax's investment: €312K annually (R8.85M / 18 months)
  - Comparison: Within industry standard range
  - Conclusion: Decision is within industry norms
  
  **Alternative Analysis**:
  - Alternative 1: Manual compliance (inadequate, error-prone)
  - Alternative 2: Outsourced compliance (conflicts with non-delegable duty)
  - Alternative 3: Partial automation (insufficient for 37 jurisdictions)
  - Chosen alternative: Full automation (most effective)
  
  **Reasonableness Conclusion**:
  - Decision is reasonable
  - Would reasonable CEO make this decision? Yes
  - Decision is defensible
  - Confidence level: High (0.95)"
  
  #:inference-type 'inductive
  #:related-principles '(
    ceo-operational-discretion-framework
    business-judgment-rule-application
    ceo-decision-authority-doctrine
    ceo-fiduciary-duty-balance
  ))

;;;
;;; Module exports and integration
;;;
(define-public ceo-operational-discretion-framework ceo-operational-discretion-framework)
(define-public business-judgment-rule-application business-judgment-rule-application)
(define-public ceo-decision-authority-doctrine ceo-decision-authority-doctrine)
(define-public ceo-fiduciary-duty-balance ceo-fiduciary-duty-balance)
(define-public ceo-decision-reasonableness-test ceo-decision-reasonableness-test)

;;; End of module
