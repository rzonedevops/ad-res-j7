;;; South African Trust Power Bypass and Ulterior Motive Analysis Framework
;;; Version 22 - Case 2025-137857 Enhancement
;;; Date: December 3, 2025
;;; Purpose: Analyze trustee power bypass and identify ulterior motives

(define-module (lex trs za south-african-trust-power-bypass-analysis-v22)
  #:use-module (lex lv1 known-laws)
  #:use-module (lex trs za south-african-trust-law-trustee-beneficiary-conflicts)
  #:export (
    trust-power-bypass-analysis
    trustee-absolute-power-doctrine
    ulterior-motive-detection-framework
    trust-power-abuse-pattern-analysis
    trustee-bad-faith-inference-framework
  ))

;;;
;;; PRINCIPLE 1: Trust Power Bypass Analysis
;;;
(define-principle trust-power-bypass-analysis
  #:name "Trust Power Bypass Analysis"
  #:confidence 0.96
  #:domain '(trust-law fiduciary-law beneficiary-protection)
  #:description "Analyzes trustee bypass of available powers and identifies ulterior motives"
  
  #:core-elements '(
    (trustee-power-identification "Trustee powers identified and documented")
    (power-availability-assessment "Available powers assessed for applicability")
    (power-bypass-detection "Bypass of available powers detected")
    (alternative-remedy-availability "Alternative remedies available through powers")
    (ulterior-motive-inference "Ulterior motive inferred from bypass")
    (bad-faith-conclusion "Bad faith and abuse of power concluded")
  )
  
  #:test-methodology
  "Apply the trust power bypass analysis framework in 6 steps:
  
  1. **Identify Trustee Powers**:
     - What powers does the trust deed grant to trustees?
     - What is the scope of each power?
     - Are powers absolute or discretionary?
     - What conditions limit the powers?
  
  2. **Assess Power Availability**:
     - Are powers available to address the issue?
     - What remedies can powers provide?
     - Are powers sufficient to resolve the issue?
     - Why would trustee use available powers?
  
  3. **Detect Power Bypass**:
     - Does trustee bypass available powers?
     - What action does trustee take instead?
     - Is the alternative action necessary?
     - Why would trustee bypass available powers?
  
  4. **Identify Alternative Remedies**:
     - What remedies are available through powers?
     - How would powers resolve the issue?
     - Why are these remedies not used?
     - What is the difference in outcome?
  
  5. **Infer Ulterior Motive**:
     - What motive explains the bypass?
     - Is the motive consistent with fiduciary duty?
     - Is the motive consistent with beneficiary interests?
     - What does the bypass reveal about intent?
  
  6. **Conclude Bad Faith**:
     - Is bypass evidence of bad faith?
     - Does bypass violate fiduciary duty?
     - Is abuse of power established?
     - What remedy is appropriate?"
  
  #:red-flags '(
    (trustee-power-not-identified 0.95 "Trustee power not identified or documented")
    (power-bypass-not-explained 0.94 "Power bypass not explained or justified")
    (alternative-remedy-not-considered 0.92 "Alternative remedy not considered")
    (ulterior-motive-evident 0.96 "Ulterior motive evident from bypass")
    (bad-faith-inference-strong 0.95 "Strong inference of bad faith")
  )
  
  #:case-application
  "Case 2025-137857 - Peter Faucitt's Trust Power Bypass:
  
  **Trustee Powers Identification**:
  - Trust deed grants trustees absolute power over trust assets
  - Trustees can manage, invest, and distribute trust assets
  - Trustees can remove beneficiaries from trust
  - Trustees can modify trust terms (with limitations)
  - Trustees can take action to protect trust assets
  
  **Power Availability Assessment**:
  - Peter has absolute trustee power over trust assets
  - Peter can address beneficiary concerns through trustee powers
  - Peter can remove beneficiary from trust if necessary
  - Peter can modify trust terms through proper procedures
  - Peter can protect trust assets through trustee action
  
  **Power Bypass Detection**:
  - Peter seeks court interdict instead of using trustee powers
  - Peter could remove Daniel from trust without court involvement
  - Peter could modify trust terms through trustee action
  - Peter could protect assets through trustee management
  - Peter bypasses all available trustee remedies
  
  **Alternative Remedy Availability**:
  - Trustee removal of beneficiary: Available through trustee power
  - Asset protection: Available through trustee management
  - Trust modification: Available through trustee action
  - Beneficiary restriction: Available through trustee power
  - All remedies available without court involvement
  
  **Ulterior Motive Inference**:
  - Bypass suggests motive beyond trust protection
  - Court interdict provides public validation
  - Court interdict creates legal record against Daniel
  - Court interdict prevents Daniel's counter-action
  - Motive appears to be punishment and control, not protection
  
  **Bad Faith Conclusion**:
  - Bypass of available powers indicates bad faith
  - Seeking court involvement suggests ulterior motive
  - Trustee action would be sufficient for legitimate purpose
  - Court involvement suggests illegitimate purpose
  - Conclusion: Bad faith and abuse of trustee power"
  
  #:inference-type 'deductive
  #:related-principles '(
    trustee-absolute-power-doctrine
    ulterior-motive-detection-framework
    fiduciary-duty-breach-analysis
    abuse-of-power-doctrine
  ))

;;;
;;; PRINCIPLE 2: Trustee Absolute Power Doctrine
;;;
(define-principle trustee-absolute-power-doctrine
  #:name "Trustee Absolute Power Doctrine"
  #:confidence 0.95
  #:domain '(trust-law fiduciary-law)
  #:description "Establishes doctrine of absolute trustee power and its limitations"
  
  #:core-elements '(
    (absolute-power-grant "Trust deed grants absolute power to trustees")
    (power-scope-definition "Scope of absolute power defined")
    (power-limitation-identification "Limitations on absolute power identified")
    (fiduciary-duty-constraint "Fiduciary duty constrains absolute power")
    (beneficiary-protection-requirement "Beneficiary protection required despite absolute power")
    (power-abuse-doctrine "Abuse of absolute power doctrine established")
  )
  
  #:test-methodology
  "Apply the trustee absolute power doctrine in 6 steps:
  
  1. **Establish Absolute Power Grant**:
     - Does trust deed grant absolute power to trustees?
     - What is the language of the grant?
     - Are there explicit limitations?
     - What is the scope of the power?
  
  2. **Define Power Scope**:
     - What actions can trustees take?
     - What decisions can trustees make?
     - What assets can trustees control?
     - What beneficiary interests can trustees affect?
  
  3. **Identify Power Limitations**:
     - What limitations exist on absolute power?
     - Are there fiduciary duty limitations?
     - Are there beneficiary protection limitations?
     - Are there legal limitations?
  
  4. **Apply Fiduciary Duty Constraint**:
     - Does fiduciary duty constrain absolute power?
     - Must trustees act in beneficiary interests?
     - Can trustees act against beneficiary interests?
     - What is the scope of fiduciary duty?
  
  5. **Require Beneficiary Protection**:
     - Must trustees protect beneficiary interests?
     - Can trustees harm beneficiaries?
     - What protection must be provided?
     - What remedy exists for breach?
  
  6. **Establish Abuse Doctrine**:
     - Can absolute power be abused?
     - What constitutes abuse?
     - What remedy exists for abuse?
     - How is abuse detected?"
  
  #:red-flags '(
    (absolute-power-not-limited 0.92 "Absolute power not limited by fiduciary duty")
    (fiduciary-duty-ignored 0.96 "Fiduciary duty ignored in power exercise")
    (beneficiary-interests-harmed 0.95 "Beneficiary interests harmed by power exercise")
    (power-used-for-punishment 0.94 "Absolute power used for punishment")
    (power-abuse-evident 0.96 "Abuse of absolute power evident")
  )
  
  #:case-application
  "Case 2025-137857 - Peter's Absolute Trustee Power:
  
  **Absolute Power Grant**:
  - Trust deed grants Peter absolute power as trustee
  - Power extends to all trust assets and decisions
  - No explicit limitations on power exercise
  - Power is discretionary and unreviewable
  
  **Power Scope Definition**:
  - Peter can manage all trust assets
  - Peter can make all trust decisions
  - Peter can affect beneficiary interests
  - Peter can restrict beneficiary access
  
  **Power Limitation Identification**:
  - Fiduciary duty limits absolute power
  - Beneficiary protection required despite absolute power
  - Power cannot be used for personal benefit
  - Power cannot be used for punishment
  
  **Fiduciary Duty Constraint Application**:
  - Peter must act in beneficiary interests
  - Peter cannot act against beneficiary interests
  - Peter must protect beneficiary rights
  - Peter must exercise power in good faith
  
  **Beneficiary Protection Requirement**:
  - Peter must protect Daniel's interests
  - Peter cannot harm Daniel without cause
  - Peter cannot use power for punishment
  - Peter must act in trust's best interests
  
  **Abuse Doctrine Establishment**:
  - Absolute power can be abused
  - Abuse occurs when power used for improper purpose
  - Abuse occurs when power harms beneficiary
  - Remedy: Court can intervene to prevent abuse"
  
  #:inference-type 'deductive
  #:related-principles '(
    fiduciary-duty-doctrine
    beneficiary-protection-framework
    abuse-of-power-doctrine
    trust-law-principles
  ))

;;;
;;; PRINCIPLE 3: Ulterior Motive Detection Framework
;;;
(define-principle ulterior-motive-detection-framework
  #:name "Ulterior Motive Detection Framework"
  #:confidence 0.96
  #:domain '(trust-law evidence-law inference)
  #:description "Framework for detecting ulterior motives in trustee actions"
  
  #:core-elements '(
    (stated-purpose-identification "Stated purpose of action identified")
    (legitimate-purpose-assessment "Legitimacy of stated purpose assessed")
    (available-alternative-analysis "Available alternatives analyzed")
    (action-necessity-evaluation "Necessity of chosen action evaluated")
    (motive-inference-analysis "Ulterior motive inferred from circumstances")
    (bad-faith-conclusion "Bad faith motive concluded")
  )
  
  #:test-methodology
  "Apply the ulterior motive detection framework in 6 steps:
  
  1. **Identify Stated Purpose**:
     - What is the stated purpose of the action?
     - What does the trustee claim to accomplish?
     - What benefit is claimed?
     - What harm is claimed to prevent?
  
  2. **Assess Purpose Legitimacy**:
     - Is the stated purpose legitimate?
     - Is the purpose consistent with fiduciary duty?
     - Is the purpose consistent with beneficiary interests?
     - Is the purpose consistent with trust terms?
  
  3. **Analyze Available Alternatives**:
     - What alternative actions are available?
     - Would alternatives accomplish the stated purpose?
     - Why were alternatives not chosen?
     - What is different about the chosen action?
  
  4. **Evaluate Action Necessity**:
     - Is the chosen action necessary?
     - Could the purpose be accomplished differently?
     - Why is the chosen action necessary?
     - What makes it necessary instead of alternatives?
  
  5. **Infer Ulterior Motive**:
     - What motive explains the choice?
     - Is the motive consistent with stated purpose?
     - What does the choice reveal about true intent?
     - What benefit flows from the chosen action?
  
  6. **Conclude Bad Faith**:
     - Is bad faith evident?
     - Does evidence support ulterior motive?
     - Is the motive improper?
     - What remedy is appropriate?"
  
  #:red-flags '(
    (stated-purpose-questionable 0.90 "Stated purpose questionable or inconsistent")
    (alternatives-not-considered 0.92 "Available alternatives not considered")
    (action-not-necessary 0.94 "Chosen action not necessary for stated purpose")
    (ulterior-motive-evident 0.96 "Ulterior motive evident from circumstances")
    (bad-faith-inference-strong 0.95 "Strong inference of bad faith")
  )
  
  #:case-application
  "Case 2025-137857 - Peter's Ulterior Motive in Interdict:
  
  **Stated Purpose Identification**:
  - Peter claims purpose is to protect trust assets
  - Peter claims Daniel is misusing company resources
  - Peter claims interdict is necessary to prevent harm
  - Peter claims urgent action is required
  
  **Purpose Legitimacy Assessment**:
     - Stated purpose of asset protection is legitimate
     - But Peter has absolute power to protect assets
     - Peter does not need court involvement
     - Purpose could be accomplished through trustee action
  
  **Available Alternative Analysis**:
     - Peter could remove Daniel from trust
     - Peter could restrict Daniel's access to assets
     - Peter could modify trust terms
     - Peter could manage assets directly
     - All alternatives available without court
  
  **Action Necessity Evaluation**:
     - Court interdict not necessary for stated purpose
     - Trustee action would be sufficient
     - Court involvement not required for asset protection
     - Chosen action exceeds what is necessary
  
  **Ulterior Motive Inference**:
     - Court interdict provides public record against Daniel
     - Court involvement creates legal liability for Daniel
     - Court involvement prevents Daniel's counter-action
     - Motive appears to be punishment and control
     - Motive appears to be retaliation for fraud reporting
  
  **Bad Faith Conclusion**:
     - Bypass of available powers indicates bad faith
     - Unnecessary court involvement indicates ulterior motive
     - Timing (after fraud reporting) indicates retaliation
     - Conclusion: Bad faith and abuse of trustee power"
  
  #:inference-type 'inductive
  #:related-principles '(
    trust-power-bypass-analysis
    bad-faith-inference-framework
    fiduciary-duty-breach-analysis
    retaliation-detection-framework
  ))

;;;
;;; PRINCIPLE 4: Trust Power Abuse Pattern Analysis
;;;
(define-principle trust-power-abuse-pattern-analysis
  #:name "Trust Power Abuse Pattern Analysis"
  #:confidence 0.94
  #:domain '(trust-law evidence-law pattern-analysis)
  #:description "Analyzes patterns of trust power abuse across multiple actions"
  
  #:core-elements '(
    (action-sequence-identification "Sequence of trustee actions identified")
    (action-timing-analysis "Timing of actions analyzed for coordination")
    (action-consequence-assessment "Consequences of actions assessed")
    (beneficiary-harm-pattern "Pattern of beneficiary harm identified")
    (coordinated-action-detection "Coordination with other parties detected")
    (systematic-abuse-conclusion "Systematic abuse pattern concluded")
  )
  
  #:test-methodology
  "Apply the trust power abuse pattern analysis in 6 steps:
  
  1. **Identify Action Sequence**:
     - What actions has trustee taken?
     - In what order were actions taken?
     - What is the relationship between actions?
     - Do actions form a sequence?
  
  2. **Analyze Action Timing**:
     - When were actions taken?
     - What triggered each action?
     - Is timing coordinated with other events?
     - Is timing suspicious or unusual?
  
  3. **Assess Action Consequences**:
     - What are the consequences of each action?
     - Who benefits from each action?
     - Who is harmed by each action?
     - Are consequences consistent?
  
  4. **Identify Beneficiary Harm Pattern**:
     - Is beneficiary harmed by actions?
     - Is harm pattern consistent?
     - Is harm intentional or incidental?
     - Does harm escalate over time?
  
  5. **Detect Coordinated Action**:
     - Are actions coordinated with others?
     - Do other parties benefit from actions?
     - Is coordination evident from timing?
     - Is coordination evident from consequences?
  
  6. **Conclude Systematic Abuse**:
     - Is abuse pattern systematic?
     - Is abuse intentional?
     - Is abuse coordinated?
     - What remedy is appropriate?"
  
  #:red-flags '(
    (action-sequence-suspicious 0.92 "Action sequence suspicious or coordinated")
    (timing-coordinated-with-events 0.94 "Timing coordinated with other events")
    (beneficiary-harm-pattern-evident 0.95 "Pattern of beneficiary harm evident")
    (coordinated-action-detected 0.93 "Coordinated action with other parties detected")
    (systematic-abuse-evident 0.96 "Systematic abuse pattern evident")
  )
  
  #:case-application
  "Case 2025-137857 - Peter's Systematic Trust Power Abuse:
  
  **Action Sequence Identification**:
  - May 15: Jax confronts Rynette about fraud (protected disclosure)
  - June 6-10: Daniel reports fraud to Bantjies (protected disclosure)
  - August 11: Peter deceives Jax into signing 'Main Trustee' document
  - August 13-19: Peter files ex parte interdict
  - August: Peter and Danie remove Jax from trustee position
  
  **Action Timing Analysis**:
  - Actions follow fraud reporting (May 15, June 6-10)
  - Actions escalate over 3-month period
  - Deception (Aug 11) immediately precedes interdict (Aug 13-19)
  - Timing suggests coordinated retaliation
  
  **Action Consequence Assessment**:
  - Fraud reporting triggers retaliation sequence
  - Deception removes Jax's trustee protections
  - Interdict restricts Jax and Daniel's actions
  - Removal from trustee position eliminates Jax's authority
  - Consequences escalate systematically
  
  **Beneficiary Harm Pattern**:
  - Daniel harmed by fraud reporting (retaliation)
  - Jax harmed by deception and removal
  - Both harmed by interdict restrictions
  - Harm escalates over time
  - Pattern clearly targets fraud reporters
  
  **Coordinated Action Detection**:
  - Peter coordinates with Danie (co-trustee)
  - Peter coordinates with Bantjies (trustee)
  - Rynette involved in fraud (controlled by Bantjies)
  - Multi-party coordination evident
  - Coordination targets fraud investigation
  
  **Systematic Abuse Conclusion**:
  - Abuse pattern is systematic and intentional
  - Abuse coordinated across multiple parties
  - Abuse targets fraud reporters (whistleblowers)
  - Abuse escalates over time
  - Conclusion: Systematic, coordinated abuse of trust power"
  
  #:inference-type 'inductive
  #:related-principles '(
    retaliation-detection-framework
    coordinated-action-analysis
    whistleblower-protection-doctrine
    abuse-of-power-doctrine
  ))

;;;
;;; PRINCIPLE 5: Trustee Bad Faith Inference Framework
;;;
(define-principle trustee-bad-faith-inference-framework
  #:name "Trustee Bad Faith Inference Framework"
  #:confidence 0.95
  #:domain '(trust-law fiduciary-law evidence-law)
  #:description "Framework for inferring bad faith from trustee actions"
  
  #:core-elements '(
    (fiduciary-duty-breach-evidence "Evidence of fiduciary duty breach")
    (self-interest-evidence "Evidence of self-interest in action")
    (beneficiary-interest-conflict "Conflict with beneficiary interests")
    (deception-evidence "Evidence of deception or concealment")
    (retaliation-evidence "Evidence of retaliation or punishment")
    (bad-faith-inference "Bad faith inferred from evidence")
  )
  
  #:test-methodology
  "Apply the trustee bad faith inference framework in 6 steps:
  
  1. **Identify Fiduciary Duty Breach**:
     - What fiduciary duty applies?
     - Has the duty been breached?
     - What is the evidence of breach?
     - Is breach intentional or negligent?
  
  2. **Identify Self-Interest Evidence**:
     - Does trustee benefit from action?
     - Is benefit personal or trust-related?
     - Is benefit disclosed?
     - Is benefit material?
  
  3. **Assess Beneficiary Interest Conflict**:
     - Does action conflict with beneficiary interests?
     - Is conflict material?
     - Is conflict disclosed?
     - Is conflict avoidable?
  
  4. **Identify Deception Evidence**:
     - Is there evidence of deception?
     - What is being concealed?
     - Who is being deceived?
     - What is the purpose of deception?
  
  5. **Identify Retaliation Evidence**:
     - Is there evidence of retaliation?
     - What triggered the retaliation?
     - Is retaliation proportionate?
     - Is retaliation improper?
  
  6. **Infer Bad Faith**:
     - Is bad faith evident?
     - What evidence supports bad faith?
     - Is bad faith the only explanation?
     - What remedy is appropriate?"
  
  #:red-flags '(
    (fiduciary-duty-breach-evident 0.95 "Fiduciary duty breach evident")
    (self-interest-evident 0.92 "Self-interest evident in action")
    (beneficiary-interest-conflict-material 0.94 "Material conflict with beneficiary interests")
    (deception-evident 0.96 "Deception evident in action")
    (retaliation-evident 0.95 "Retaliation evident in action")
  )
  
  #:case-application
  "Case 2025-137857 - Peter's Bad Faith Trustee Actions:
  
  **Fiduciary Duty Breach Evidence**:
  - Peter must act in beneficiary interests
  - Peter's actions harm Daniel (beneficiary)
  - Peter's actions harm Jax (trustee and beneficiary)
  - Breach is evident and material
  
  **Self-Interest Evidence**:
  - Peter benefits from Daniel's restriction
  - Peter benefits from Jax's removal
  - Peter benefits from fraud investigation obstruction
  - Benefits are personal, not trust-related
  
  **Beneficiary Interest Conflict**:
  - Interdict conflicts with Daniel's interests
  - Removal conflicts with Jax's interests
  - Fraud obstruction conflicts with trust interests
  - Conflicts are material and undisclosed
  
  **Deception Evidence**:
  - Peter deceives Jax into signing 'Main Trustee' document
  - Document backdated to July 1, 2025
  - Deception removes Jax's trustee protections
  - Deception enables subsequent retaliation
  
  **Retaliation Evidence**:
  - Interdict filed after fraud reporting (May 15, June 6-10)
  - Timing suggests retaliation for protected disclosure
  - Escalation over 3-month period
  - Retaliation pattern evident and systematic
  
  **Bad Faith Inference**:
  - All evidence points to bad faith
  - Breach, self-interest, conflict, deception, retaliation
  - Bad faith is only reasonable explanation
  - Conclusion: Bad faith trustee actions"
  
  #:inference-type 'inductive
  #:related-principles '(
    fiduciary-duty-doctrine
    retaliation-detection-framework
    deception-detection-framework
    abuse-of-power-doctrine
  ))

;;;
;;; Module exports and integration
;;;
(define-public trust-power-bypass-analysis trust-power-bypass-analysis)
(define-public trustee-absolute-power-doctrine trustee-absolute-power-doctrine)
(define-public ulterior-motive-detection-framework ulterior-motive-detection-framework)
(define-public trust-power-abuse-pattern-analysis trust-power-abuse-pattern-analysis)
(define-public trustee-bad-faith-inference-framework trustee-bad-faith-inference-framework)

;;; End of module
