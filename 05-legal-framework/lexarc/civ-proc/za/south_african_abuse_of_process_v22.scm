;;; South African Abuse of Process and Manufactured Crisis Detection Framework
;;; Version 22 - Case 2025-137857 Enhancement
;;; Date: December 3, 2025
;;; Purpose: Detect abuse of process and manufactured crisis in legal proceedings

(define-module (lex civ-proc za south-african-abuse-of-process-v22)
  #:use-module (lex lv1 known-laws)
  #:use-module (lex civ-proc za south-african-civil-procedure-ex-parte)
  #:export (
    abuse-of-process-detection-framework
    ex-parte-fraud-detection-framework
    manufactured-crisis-detection-framework
    material-non-disclosure-analysis
    temporal-causation-analysis
  ))

;;;
;;; PRINCIPLE 1: Abuse of Process Detection Framework
;;;
(define-principle abuse-of-process-detection-framework
  #:name "Abuse of Process Detection Framework"
  #:confidence 0.96
  #:domain '(civil-procedure abuse-of-process litigation-ethics)
  #:description "Framework for detecting abuse of process in legal proceedings"
  
  #:core-elements '(
    (legitimate-purpose-assessment "Legitimate purpose of legal action assessed")
    (improper-purpose-detection "Improper purpose detected")
    (procedural-irregularity-identification "Procedural irregularities identified")
    (material-non-disclosure-detection "Material non-disclosures detected")
    (temporal-causation-analysis "Temporal causation analyzed")
    (abuse-of-process-conclusion "Abuse of process concluded")
  )
  
  #:test-methodology
  "Apply the abuse of process detection framework in 6 steps:
  
  1. **Assess Legitimate Purpose**:
     - What is the stated purpose of the legal action?
     - Is the purpose legitimate?
     - Is the purpose consistent with legal principles?
     - Is the purpose consistent with justice?
  
  2. **Detect Improper Purpose**:
     - Is there evidence of improper purpose?
     - What improper purpose is evident?
     - Is improper purpose primary or secondary?
     - What does the improper purpose accomplish?
  
  3. **Identify Procedural Irregularities**:
     - Are there procedural irregularities?
     - What procedures were not followed?
     - Why were procedures not followed?
     - What is the impact of irregularities?
  
  4. **Detect Material Non-Disclosures**:
     - Are material facts non-disclosed?
     - What facts are non-disclosed?
     - Why are facts non-disclosed?
     - What is the impact of non-disclosure?
  
  5. **Analyze Temporal Causation**:
     - What events preceded the legal action?
     - Is timing suspicious?
     - Is timing coordinated with other events?
     - What does timing reveal about motive?
  
  6. **Conclude Abuse of Process**:
     - Is abuse of process evident?
     - What evidence supports abuse?
     - Is abuse intentional?
     - What remedy is appropriate?"
  
  #:red-flags '(
    (improper-purpose-evident 0.96 "Improper purpose evident")
    (procedural-irregularity-material 0.94 "Material procedural irregularity")
    (material-non-disclosure-evident 0.95 "Material non-disclosure evident")
    (temporal-causation-suspicious 0.93 "Suspicious temporal causation")
    (abuse-of-process-evident 0.96 "Abuse of process evident")
  )
  
  #:case-application
  "Case 2025-137857 - Peter's Abuse of Process in Interdict:
  
  **Legitimate Purpose Assessment**:
  - Stated purpose: Protect trust assets from misuse
  - Purpose appears legitimate on surface
  - But Peter has absolute trustee power
  - Court involvement not necessary for stated purpose
  
  **Improper Purpose Detection**:
  - Improper purpose: Retaliation for fraud reporting
  - Improper purpose: Obstruct fraud investigation
  - Improper purpose: Punish whistleblowers
  - Improper purpose: Prevent counter-action by beneficiaries
  
  **Procedural Irregularity Identification**:
  - Ex parte interdict filed without notice
  - Material facts non-disclosed to court
  - Urgency manufactured without justification
  - Procedure designed to prevent response
  
  **Material Non-Disclosure Detection**:
  - Non-disclosed: Fraud reporting by Daniel (June 6-10)
  - Non-disclosed: Whistleblower status of Daniel
  - Non-disclosed: Retaliation pattern
  - Non-disclosed: Peter's absolute trustee power
  - Non-disclosed: Available alternative remedies
  
  **Temporal Causation Analysis**:
  - Fraud reporting: May 15 (Jax), June 6-10 (Daniel)
  - Interdict filing: August 13-19 (2-3 months later)
  - Timing suggests retaliation, not emergency
  - Urgency manufactured to justify ex parte procedure
  
  **Abuse of Process Conclusion**:
  - Abuse of process evident from all factors
  - Improper purpose: Retaliation and obstruction
  - Procedural irregularity: Ex parte without disclosure
  - Material non-disclosure: Fraud reporting and whistleblower status
  - Temporal causation: Retaliation pattern evident
  - Conclusion: Abuse of process"
  
  #:inference-type 'deductive
  #:related-principles '(
    ex-parte-fraud-detection-framework
    manufactured-crisis-detection-framework
    material-non-disclosure-analysis
    temporal-causation-analysis
  ))

;;;
;;; PRINCIPLE 2: Ex Parte Fraud Detection Framework
;;;
(define-principle ex-parte-fraud-detection-framework
  #:name "Ex Parte Fraud Detection Framework"
  #:confidence 0.97
  #:domain '(civil-procedure fraud litigation-ethics)
  #:description "Framework for detecting fraud on court in ex parte proceedings"
  
  #:core-elements '(
    (ex-parte-requirement-assessment "Ex parte requirement assessed")
    (urgency-justification-analysis "Urgency justification analyzed")
    (material-fact-identification "Material facts identified")
    (fact-disclosure-assessment "Disclosure of material facts assessed")
    (fraud-inference-analysis "Fraud inferred from non-disclosure")
    (fraud-on-court-conclusion "Fraud on court concluded")
  )
  
  #:test-methodology
  "Apply the ex parte fraud detection framework in 6 steps:
  
  1. **Assess Ex Parte Requirement**:
     - Is ex parte procedure required?
     - What justifies ex parte procedure?
     - Could notice have been given?
     - Why was notice not given?
  
  2. **Analyze Urgency Justification**:
     - Is urgency claimed?
     - Is urgency justified?
     - What emergency exists?
     - Could emergency have been prevented?
  
  3. **Identify Material Facts**:
     - What facts are material to the decision?
     - What facts affect the court's discretion?
     - What facts would change the outcome?
     - What facts are known to the applicant?
  
  4. **Assess Fact Disclosure**:
     - Are material facts disclosed?
     - Are all material facts disclosed?
     - Are facts disclosed completely?
     - Are facts disclosed accurately?
  
  5. **Infer Fraud from Non-Disclosure**:
     - Are material facts non-disclosed?
     - Is non-disclosure intentional?
     - Is non-disclosure reckless?
     - What is the impact on the court's decision?
  
  6. **Conclude Fraud on Court**:
     - Is fraud on court evident?
     - What evidence supports fraud?
     - Is fraud intentional or reckless?
     - What remedy is appropriate?"
  
  #:red-flags '(
    (urgency-not-justified 0.94 "Urgency not justified")
    (material-fact-non-disclosed 0.97 "Material fact non-disclosed")
    (non-disclosure-intentional 0.96 "Non-disclosure intentional")
    (court-decision-affected 0.95 "Court decision affected by non-disclosure")
    (fraud-on-court-evident 0.97 "Fraud on court evident")
  )
  
  #:case-application
  "Case 2025-137857 - Peter's Fraud on Court in Ex Parte Interdict:
  
  **Ex Parte Requirement Assessment**:
  - Ex parte procedure used for interdict
  - Claimed justification: Urgency and risk of asset dissipation
  - But Peter has absolute trustee power
  - Peter could have used trustee power without court
  - Ex parte procedure not necessary
  
  **Urgency Justification Analysis**:
  - Claimed urgency: Immediate asset dissipation risk
  - But fraud reporting was May 15 (3 months prior)
  - But Daniel's actions were not secret
  - But Peter had trustee power to act
  - Urgency manufactured, not genuine
  
  **Material Fact Identification**:
  - Material fact 1: Daniel reported fraud (June 6-10)
  - Material fact 2: Daniel is whistleblower
  - Material fact 3: Interdict is retaliation
  - Material fact 4: Peter has absolute trustee power
  - Material fact 5: Alternative remedies available
  
  **Fact Disclosure Assessment**:
  - Fact 1 (fraud reporting): NOT DISCLOSED
  - Fact 2 (whistleblower status): NOT DISCLOSED
  - Fact 3 (retaliation motive): NOT DISCLOSED
  - Fact 4 (trustee power): NOT DISCLOSED
  - Fact 5 (alternative remedies): NOT DISCLOSED
  - All material facts non-disclosed
  
  **Fraud Inference from Non-Disclosure**:
  - Non-disclosure of fraud reporting affects court's discretion
  - Non-disclosure of whistleblower status affects court's discretion
  - Non-disclosure of retaliation motive affects court's discretion
  - Non-disclosure of trustee power affects court's discretion
  - Non-disclosure of alternatives affects court's discretion
  - Court would not grant interdict if facts disclosed
  
  **Fraud on Court Conclusion**:
  - Fraud on court evident from material non-disclosures
  - Non-disclosure intentional (facts known to Peter)
  - Non-disclosure affects court's decision
  - Court misled about urgency and necessity
  - Conclusion: Fraud on court"
  
  #:inference-type 'deductive
  #:related-principles '(
    material-non-disclosure-analysis
    temporal-causation-analysis
    abuse-of-process-detection-framework
    whistleblower-protection-doctrine
  ))

;;;
;;; PRINCIPLE 3: Manufactured Crisis Detection Framework
;;;
(define-principle manufactured-crisis-detection-framework
  #:name "Manufactured Crisis Detection Framework"
  #:confidence 0.95
  #:domain '(evidence-law pattern-analysis litigation-ethics)
  #:description "Framework for detecting manufactured crisis in legal proceedings"
  
  #:core-elements '(
    (crisis-claim-identification "Crisis claim identified")
    (crisis-justification-analysis "Crisis justification analyzed")
    (crisis-timing-analysis "Crisis timing analyzed")
    (crisis-prevention-possibility "Possibility of crisis prevention assessed")
    (manufactured-crisis-inference "Manufactured crisis inferred")
    (manufactured-crisis-conclusion "Manufactured crisis concluded")
  )
  
  #:test-methodology
  "Apply the manufactured crisis detection framework in 6 steps:
  
  1. **Identify Crisis Claim**:
     - What crisis is claimed?
     - What is the nature of the crisis?
     - What is the claimed urgency?
     - What is the claimed risk?
  
  2. **Analyze Crisis Justification**:
     - Is the crisis justified?
     - What evidence supports the crisis?
     - Is the evidence credible?
     - Is the evidence complete?
  
  3. **Analyze Crisis Timing**:
     - When did the crisis arise?
     - What events preceded the crisis?
     - Is timing suspicious?
     - Is timing coordinated with other events?
  
  4. **Assess Crisis Prevention Possibility**:
     - Could the crisis have been prevented?
     - What actions would have prevented crisis?
     - Why were preventive actions not taken?
     - Does non-prevention suggest intent?
  
  5. **Infer Manufactured Crisis**:
     - Is the crisis manufactured?
     - What evidence suggests manufacture?
     - What motive explains manufacture?
     - What benefit flows from manufacture?
  
  6. **Conclude Manufactured Crisis**:
     - Is manufactured crisis evident?
     - What evidence supports conclusion?
     - Is manufacture intentional?
     - What remedy is appropriate?"
  
  #:red-flags '(
    (crisis-justification-weak 0.92 "Crisis justification weak or absent")
    (crisis-timing-suspicious 0.94 "Crisis timing suspicious or coordinated")
    (crisis-preventable 0.93 "Crisis preventable but not prevented")
    (crisis-benefits-applicant 0.95 "Crisis benefits applicant in litigation")
    (manufactured-crisis-evident 0.95 "Manufactured crisis evident")
  )
  
  #:case-application
  "Case 2025-137857 - Peter's Manufactured Crisis:
  
  **Crisis Claim Identification**:
  - Claimed crisis: Imminent asset dissipation by Daniel
  - Claimed urgency: Immediate action required
  - Claimed risk: Loss of trust assets
  - Claimed necessity: Ex parte interdict required
  
  **Crisis Justification Analysis**:
  - Justification: Daniel's alleged misuse of company resources
  - Evidence: Alleged IT expenses (R8.85M)
  - But expenses documented and justified
  - But expenses within CEO authority
  - Justification weak and incomplete
  
  **Crisis Timing Analysis**:
  - Fraud reporting: May 15 (Jax), June 6-10 (Daniel)
  - Interdict filing: August 13-19 (2-3 months later)
  - Timing suggests retaliation, not emergency
  - Crisis claim made only after fraud reporting
  - Timing suspicious and coordinated
  
  **Crisis Prevention Possibility Assessment**:
  - Peter has absolute trustee power
  - Peter could have restricted Daniel's access
  - Peter could have removed Daniel from trust
  - Peter could have managed assets directly
  - Crisis preventable through trustee action
  - Non-prevention suggests intent to manufacture
  
  **Manufactured Crisis Inference**:
  - Crisis claim follows fraud reporting
  - Crisis claim enables ex parte procedure
  - Crisis claim prevents Daniel's response
  - Crisis claim creates legal record against Daniel
  - Manufactured crisis benefits Peter's retaliation
  
  **Manufactured Crisis Conclusion**:
  - Manufactured crisis evident from all factors
  - Timing: Follows fraud reporting by 2-3 months
  - Prevention: Peter could have prevented crisis
  - Benefit: Crisis enables ex parte procedure
  - Motive: Retaliation for fraud reporting
  - Conclusion: Manufactured crisis"
  
  #:inference-type 'inductive
  #:related-principles '(
    temporal-causation-analysis
    abuse-of-process-detection-framework
    ex-parte-fraud-detection-framework
    retaliation-detection-framework
  ))

;;;
;;; PRINCIPLE 4: Material Non-Disclosure Analysis
;;;
(define-principle material-non-disclosure-analysis
  #:name "Material Non-Disclosure Analysis"
  #:confidence 0.96
  #:domain '(civil-procedure fraud evidence-law)
  #:description "Analyzes material non-disclosures in legal proceedings"
  
  #:core-elements '(
    (material-fact-identification "Material facts identified")
    (disclosure-requirement-assessment "Disclosure requirement assessed")
    (actual-disclosure-assessment "Actual disclosure assessed")
    (non-disclosure-impact-analysis "Impact of non-disclosure analyzed")
    (non-disclosure-intent-assessment "Intent of non-disclosure assessed")
    (material-non-disclosure-conclusion "Material non-disclosure concluded")
  )
  
  #:test-methodology
  "Apply the material non-disclosure analysis in 6 steps:
  
  1. **Identify Material Facts**:
     - What facts are material?
     - What facts affect court's discretion?
     - What facts would change outcome?
     - What facts are known to applicant?
  
  2. **Assess Disclosure Requirement**:
     - Is disclosure required?
     - What is the scope of disclosure?
     - Are all material facts required?
     - What is the standard for materiality?
  
  3. **Assess Actual Disclosure**:
     - What facts are disclosed?
     - Are all material facts disclosed?
     - Are facts disclosed completely?
     - Are facts disclosed accurately?
  
  4. **Analyze Non-Disclosure Impact**:
     - What facts are non-disclosed?
     - What is the impact on court's decision?
     - Would court decide differently if facts disclosed?
     - Is impact material?
  
  5. **Assess Non-Disclosure Intent**:
     - Is non-disclosure intentional?
     - Is non-disclosure reckless?
     - Is non-disclosure negligent?
     - What is the motive for non-disclosure?
  
  6. **Conclude Material Non-Disclosure**:
     - Is material non-disclosure evident?
     - What facts are non-disclosed?
     - What is the impact?
     - What remedy is appropriate?"
  
  #:red-flags '(
    (material-fact-non-disclosed 0.97 "Material fact non-disclosed")
    (non-disclosure-affects-decision 0.96 "Non-disclosure affects court decision")
    (non-disclosure-intentional 0.95 "Non-disclosure intentional")
    (multiple-non-disclosures 0.94 "Multiple material non-disclosures")
    (pattern-of-non-disclosure 0.95 "Pattern of material non-disclosures")
  )
  
  #:case-application
  "Case 2025-137857 - Peter's Material Non-Disclosures:
  
  **Material Fact Identification**:
  - Fact 1: Daniel reported fraud to Bantjies (June 6-10)
  - Fact 2: Daniel is whistleblower for protected disclosure
  - Fact 3: Interdict is retaliation for fraud reporting
  - Fact 4: Peter has absolute trustee power
  - Fact 5: Alternative remedies available without court
  - Fact 6: Urgency manufactured, not genuine
  - Fact 7: IT expenses documented and justified
  
  **Disclosure Requirement Assessment**:
  - Ex parte applicant must disclose all material facts
  - Court must have complete information
  - Court must know of whistleblower status
  - Court must know of retaliation motive
  - Court must know of alternative remedies
  
  **Actual Disclosure Assessment**:
  - Fact 1 (fraud reporting): NOT DISCLOSED
  - Fact 2 (whistleblower status): NOT DISCLOSED
  - Fact 3 (retaliation motive): NOT DISCLOSED
  - Fact 4 (trustee power): NOT DISCLOSED
  - Fact 5 (alternative remedies): NOT DISCLOSED
  - Fact 6 (manufactured urgency): NOT DISCLOSED
  - Fact 7 (justified expenses): NOT DISCLOSED
  
  **Non-Disclosure Impact Analysis**:
  - Court not aware of whistleblower protection
  - Court not aware of retaliation motive
  - Court not aware of alternative remedies
  - Court not aware of trustee power
  - Court misled about urgency and necessity
  - Court would not grant interdict if facts disclosed
  
  **Non-Disclosure Intent Assessment**:
  - Non-disclosure intentional (facts known to Peter)
  - Non-disclosure strategic (enables ex parte procedure)
  - Non-disclosure deliberate (prevents response)
  - Motive: Enable retaliation through fraud on court
  
  **Material Non-Disclosure Conclusion**:
  - Material non-disclosure evident and systematic
  - Multiple facts non-disclosed (7 material facts)
  - Non-disclosure affects court's decision
  - Non-disclosure intentional and strategic
  - Conclusion: Fraud on court through material non-disclosure"
  
  #:inference-type 'deductive
  #:related-principles '(
    ex-parte-fraud-detection-framework
    abuse-of-process-detection-framework
    fraud-on-court-doctrine
    whistleblower-protection-doctrine
  ))

;;;
;;; PRINCIPLE 5: Temporal Causation Analysis
;;;
(define-principle temporal-causation-analysis
  #:name "Temporal Causation Analysis"
  #:confidence 0.94
  #:domain '(evidence-law causation-analysis inference)
  #:description "Analyzes temporal causation to establish retaliation and coordination"
  
  #:core-elements '(
    (event-sequence-identification "Event sequence identified")
    (temporal-proximity-analysis "Temporal proximity analyzed")
    (causation-inference-analysis "Causation inferred from timing")
    (alternative-explanation-evaluation "Alternative explanations evaluated")
    (retaliation-pattern-detection "Retaliation pattern detected")
    (temporal-causation-conclusion "Temporal causation concluded")
  )
  
  #:test-methodology
  "Apply the temporal causation analysis in 6 steps:
  
  1. **Identify Event Sequence**:
     - What events occurred?
     - In what order did events occur?
     - What is the relationship between events?
     - Do events form a sequence?
  
  2. **Analyze Temporal Proximity**:
     - How close in time are events?
     - Is proximity suspicious?
     - Is proximity consistent with causation?
     - Is proximity consistent with coincidence?
  
  3. **Infer Causation from Timing**:
     - Does timing suggest causation?
     - Is causation the best explanation?
     - What other explanations exist?
     - Is causation more likely than alternatives?
  
  4. **Evaluate Alternative Explanations**:
     - What alternative explanations exist?
     - Are alternatives plausible?
     - Are alternatives more likely?
     - Why is causation more likely?
  
  5. **Detect Retaliation Pattern**:
     - Is retaliation pattern evident?
     - What triggers the retaliation?
     - How does retaliation escalate?
     - Is pattern systematic?
  
  6. **Conclude Temporal Causation**:
     - Is temporal causation evident?
     - What evidence supports causation?
     - Is causation the best explanation?
     - What remedy is appropriate?"
  
  #:red-flags '(
    (temporal-proximity-suspicious 0.93 "Temporal proximity suspicious")
    (causation-inference-strong 0.94 "Strong inference of causation")
    (alternative-explanation-implausible 0.92 "Alternative explanation implausible")
    (retaliation-pattern-evident 0.95 "Retaliation pattern evident")
    (temporal-causation-established 0.94 "Temporal causation established")
  )
  
  #:case-application
  "Case 2025-137857 - Temporal Causation of Retaliation:
  
  **Event Sequence Identification**:
  - Event 1: May 15, 2025 - Jax confronts Rynette about fraud
  - Event 2: June 6-10, 2025 - Daniel reports fraud to Bantjies
  - Event 3: August 11, 2025 - Peter deceives Jax into signing document
  - Event 4: August 13-19, 2025 - Peter files ex parte interdict
  - Event 5: August 2025 - Peter and Danie remove Jax from trustee position
  
  **Temporal Proximity Analysis**:
  - Event 1 to Event 2: 3 weeks (fraud reporting escalation)
  - Event 2 to Event 3: 2 months (planning retaliation)
  - Event 3 to Event 4: 2 days (executing retaliation)
  - Event 4 to Event 5: Weeks (consolidating retaliation)
  - Proximity: Suspicious and coordinated
  
  **Causation Inference from Timing**:
  - Fraud reporting (Events 1-2) triggers retaliation (Events 3-5)
  - Timing suggests causation, not coincidence
  - Retaliation follows fraud reporting by 2-3 months
  - Timing allows planning and coordination
  - Causation is best explanation
  
  **Alternative Explanation Evaluation**:
  - Alternative: Coincidence of events
  - Alternative: Unrelated concerns about assets
  - But timing is too close and coordinated
  - But pattern is too systematic
  - But motive is too clear (retaliation)
  - Causation more likely than alternatives
  
  **Retaliation Pattern Detection**:
  - Trigger: Fraud reporting by Daniel (June 6-10)
  - Response: Deception of Jax (August 11)
  - Escalation: Ex parte interdict (August 13-19)
  - Further escalation: Removal from trustee position (August)
  - Pattern: Systematic retaliation against whistleblowers
  
  **Temporal Causation Conclusion**:
  - Temporal causation evident from event sequence
  - Fraud reporting causes retaliation
  - Timing is suspicious and coordinated
  - Pattern is systematic and escalating
  - Conclusion: Temporal causation of retaliation established"
  
  #:inference-type 'inductive
  #:related-principles '(
    abuse-of-process-detection-framework
    manufactured-crisis-detection-framework
    retaliation-detection-framework
    whistleblower-protection-doctrine
  ))

;;;
;;; Module exports and integration
;;;
(define-public abuse-of-process-detection-framework abuse-of-process-detection-framework)
(define-public ex-parte-fraud-detection-framework ex-parte-fraud-detection-framework)
(define-public manufactured-crisis-detection-framework manufactured-crisis-detection-framework)
(define-public material-non-disclosure-analysis material-non-disclosure-analysis)
(define-public temporal-causation-analysis temporal-causation-analysis)

;;; End of module
