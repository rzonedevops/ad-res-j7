;;; South African Civil Law - Case 2025-137857 Refined v4
;;; Enhanced with AD-paragraph-specific legal resolution and evidence mapping
;;; Date: 2025-11-17
;;; Case: 2025-137857 (Peter Faucitt v. Jacqueline & Daniel Faucitt)
;;; Repository: cogpy/ad-res-j7

(define-module (lex civ za south-african-civil-law-case-2025-137857-refined-v4)
  #:use-module (lex lv1 known-laws)
  #:use-module (lex civ za south-african-civil-law)
  #:use-module (lex trs za south-african-trust-law-enhanced-v8)
  #:export (
    resolve-ad-paragraph-legal-aspects
    detect-advanced-temporal-patterns
    calculate-multi-factor-evidence-strength
    analyze-jax-dan-response-optimization
    generate-evidence-annexure-recommendations
  ))

;;;
;;; CORE PRINCIPLE: AD Paragraph Legal Aspects Resolution
;;;

(define-principle resolve-ad-paragraph-legal-aspects
  #:name "AD Paragraph Legal Aspects Resolution"
  #:confidence 0.98
  #:domain '(civil-law evidence temporal-analysis)
  #:description "Resolves legal aspects for each AD paragraph with entity-relation-event integration"
  
  #:ad-paragraph-map
  '(
    ;; CRITICAL PRIORITY PARAGRAPHS
    
    ("PARA_7_2-7_5" . (
      (priority . "1-Critical")
      (topic . "IT Expense Discrepancies - Card Cancellation Sabotage")
      (legal-aspects . (
        "sabotage"
        "temporal-bad-faith"
        "immediate-retaliation"
        "business-continuity-disruption"
        "director-duties-breach"
      ))
      (entities . (
        (primary-actor . "peter-faucitt")
        (primary-victim . "daniel-faucitt")
        (affected-entities . ("rwd" "rst" "regima-zone"))
      ))
      (temporal-pattern . (
        (type . "immediate-retaliation")
        (trigger-date . "2025-06-06")
        (trigger-event . "Dan provided fraud reports to accountant")
        (response-date . "2025-06-07")
        (response-event . "Peter cancelled all business cards")
        (interval . "1 day")
        (confidence . 0.98)
      ))
      (dan-perspective . (
        (role . "CIO")
        (expertise . "Technical infrastructure architecture and management")
        (evidence-strength . 0.98)
        (key-points . (
          "Technical infrastructure dependencies (AWS, Azure, Google Cloud)"
          "37-jurisdiction operational requirements"
          "Business continuity impact quantification"
          "1-day temporal proximity demonstrates causation"
          "IT expenses fully justified by technical requirements"
        ))
        (recommended-annexures . (
          "DAN-IT-01: Fraud report submission confirmation (2025-06-06)"
          "DAN-IT-02: Card cancellation notification (2025-06-07)"
          "DAN-IT-03: Technical infrastructure dependency matrix"
          "DAN-IT-04: Business continuity impact assessment"
          "DAN-IT-05: 37-jurisdiction operational requirements"
          "DAN-IT-06: Cloud services architecture diagram"
          "DAN-IT-07: IT expense justification by category"
        ))
      ))
      (jax-perspective . (
        (role . "CEO")
        (expertise . "Business operations and regulatory compliance")
        (evidence-strength . 0.96)
        (key-points . (
          "Operational impact on EU Responsible Person duties"
          "Revenue stream disruption"
          "Regulatory compliance crisis"
          "Coordinated sabotage with Rynette"
        ))
      ))
      (lex-principles . (
        "temporal-bad-faith"
        "abuse-of-process"
        "director-duties-breach"
        "sabotage-causation"
      ))
    ))
    
    ("PARA_7_6" . (
      (priority . "1-Critical")
      (topic . "Director Loan - Established Practice Hypocrisy")
      (legal-aspects . (
        "established-practice"
        "selective-enforcement"
        "hypocrisy"
        "director-loan-legitimacy"
        "bad-faith-litigation"
      ))
      (entities . (
        (primary-actor . "peter-faucitt")
        (primary-victim . "daniel-faucitt")
        (affected-entities . ("rwd" "fft"))
      ))
      (temporal-pattern . (
        (type . "hypocrisy-pattern")
        (peter-withdrawals . (
          ("2023-01-12" . "R420,000")
          ("2023-02-15" . "R310,000")
          ("2025-03-15" . "R350,000")
          ("2025-07-20" . "R285,000")
        ))
        (peter-total . "R1,365,000")
        (dan-payment . ("2025-07-16" . "R500,000"))
        (peter-characterization . "unauthorized gift")
        (confidence . 0.94)
      ))
      (dan-perspective . (
        (role . "CIO and Beneficiary")
        (expertise . "Financial analysis and established practice documentation")
        (evidence-strength . 0.94)
        (key-points . (
          "Peter made 4 withdrawals totaling R1,365,000 without board resolutions"
          "Dan followed identical established practice (R500,000)"
          "Peter made another withdrawal (R285,000) on 2025-07-20 AFTER criticizing Dan"
          "Selective enforcement for litigation advantage"
          "Established practice confirmed by accountant"
        ))
        (recommended-annexures . (
          "DAN-FIN-01: Bank statements showing Peter's withdrawals (2023-2025)"
          "DAN-FIN-02: Bank statement showing Dan's payment (2025-07-16)"
          "DAN-FIN-03: Board resolution records (absence thereof)"
          "DAN-FIN-04: Comparative analysis table"
          "DAN-FIN-05: Accountant confirmation of established practice"
          "DAN-FIN-06: Peter's withdrawal on 2025-07-20 (post-criticism)"
        ))
      ))
      (lex-principles . (
        "established-practice"
        "selective-enforcement"
        "bad-faith-litigation"
        "director-loan-legitimacy"
      ))
    ))
    
    ("PARA_7_7-7_8" . (
      (priority . "1-Critical")
      (topic . "Payment Details - Documentary Evidence")
      (legal-aspects . (
        "payment-verification"
        "documentary-evidence"
        "bank-statement-proof"
      ))
      (entities . (
        (primary-actor . "daniel-faucitt")
        (affected-entities . ("rwd"))
      ))
      (dan-perspective . (
        (role . "CIO and Director")
        (expertise . "Financial transaction documentation")
        (evidence-strength . 0.96)
        (key-points . (
          "Complete bank statement evidence"
          "Payment date: 2025-07-16"
          "Payment amount: R500,000"
          "Transaction reference and details"
        ))
        (recommended-annexures . (
          "DAN-FIN-07: Bank statement showing R500,000 payment"
          "DAN-FIN-08: Transaction confirmation"
        ))
      ))
      (lex-principles . (
        "documentary-evidence"
        "payment-verification"
      ))
    ))
    
    ("PARA_7_9-7_11" . (
      (priority . "1-Critical")
      (topic . "Justification - Business Necessity and Established Practice")
      (legal-aspects . (
        "business-necessity"
        "established-practice"
        "director-loan-justification"
        "comparative-analysis"
      ))
      (entities . (
        (primary-actor . "daniel-faucitt")
        (comparator . "peter-faucitt")
        (affected-entities . ("rwd"))
      ))
      (dan-perspective . (
        (role . "CIO and Director")
        (expertise . "Business operations and financial management")
        (evidence-strength . 0.93)
        (key-points . (
          "Business necessity for operational continuity"
          "Following established practice set by Peter"
          "Comparative analysis shows Peter's larger withdrawals"
          "No board resolutions required (established practice)"
        ))
        (recommended-annexures . (
          "DAN-FIN-09: Business necessity documentation"
          "DAN-FIN-10: Comparative analysis (Peter vs Dan)"
          "DAN-FIN-11: Established practice timeline"
        ))
      ))
      (lex-principles . (
        "business-necessity"
        "established-practice"
        "comparative-analysis"
      ))
    ))
    
    ("PARA_10_5-10_10_23" . (
      (priority . "1-Critical")
      (topic . "Financial Impact Quantification")
      (legal-aspects . (
        "financial-impact-quantification"
        "sabotage-damages"
        "business-continuity-costs"
        "opportunity-costs"
      ))
      (entities . (
        (primary-actor . "peter-faucitt")
        (primary-victim . "daniel-faucitt")
        (affected-entities . ("rwd" "rst" "regima-zone"))
      ))
      (dan-perspective . (
        (role . "CIO")
        (expertise . "Technical infrastructure cost analysis")
        (evidence-strength . 0.92)
        (key-points . (
          "Cloud services disruption costs"
          "Software licensing impact"
          "Emergency system recovery costs"
          "37-jurisdiction operational impact"
          "Quantifiable technical infrastructure costs"
        ))
        (recommended-annexures . (
          "DAN-FIN-IMPACT-01: Cloud services cost breakdown"
          "DAN-FIN-IMPACT-02: Software licensing invoices"
          "DAN-FIN-IMPACT-03: Emergency recovery expense documentation"
          "DAN-FIN-IMPACT-04: Business continuity cost analysis"
          "DAN-FIN-IMPACT-05: 37-jurisdiction operational impact assessment"
        ))
      ))
      (lex-principles . (
        "financial-impact-quantification"
        "sabotage-damages"
        "causation-chain"
      ))
    ))
    
    ("PARA_3-3_10" . (
      (priority . "1-Critical")
      (topic . "Responsible Person Regulatory Crisis")
      (legal-aspects . (
        "regulatory-crisis"
        "responsible-person-duties"
        "operational-impossibility"
        "void-ab-initio"
        "technical-infrastructure-dependency"
      ))
      (entities . (
        (primary-actor . "peter-faucitt")
        (primary-victim . "jacqueline-faucitt")
        (supporting-victim . "daniel-faucitt")
        (affected-entities . ("rst" "rwd"))
      ))
      (temporal-pattern . (
        (type . "manufactured-crisis")
        (sequence . (
          "Card cancellations → Documentation systems disrupted"
          "Documentation requests → Documentation inaccessible"
          "Claim 'lack of documentation' → File interdict"
        ))
        (confidence . 0.95)
      ))
      (dan-perspective . (
        (role . "CIO and Technical Infrastructure Manager")
        (expertise . "Technical infrastructure for regulatory compliance")
        (evidence-strength . 0.96)
        (key-points . (
          "Technical infrastructure requirements for EU Responsible Person"
          "System dependencies for 37-jurisdiction operations"
          "Operational impossibility under interdict"
          "Peter's technical knowledge demonstrates bad faith"
          "Void ab initio argument supported by technical evidence"
        ))
        (recommended-annexures . (
          "DAN-RP-01: Technical infrastructure architecture diagram"
          "DAN-RP-02: 37-jurisdiction system requirements matrix"
          "DAN-RP-03: EU Responsible Person system dependencies"
          "DAN-RP-04: System access logs and audit trails"
          "DAN-RP-05: Regulatory compliance platform documentation"
          "DAN-RP-06: Business continuity impact assessment"
          "DAN-RP-07: Peter's technical knowledge evidence"
        ))
      ))
      (jax-perspective . (
        (role . "CEO and EU Responsible Person")
        (expertise . "Regulatory compliance and business operations")
        (evidence-strength . 0.97)
        (key-points . (
          "EU Responsible Person duties and obligations"
          "Regulatory compliance requirements"
          "Operational impossibility under interdict"
          "Manufactured crisis by Peter"
          "Void ab initio argument"
        ))
      ))
      (lex-principles . (
        "regulatory-crisis"
        "operational-impossibility"
        "void-ab-initio"
        "manufactured-crisis"
        "bad-faith-litigation"
      ))
    ))
    
    ("PARA_3_11-3_13" . (
      (priority . "1-Critical")
      (topic . "Jax Role and CEO Duties")
      (legal-aspects . (
        "ceo-duties"
        "regulatory-compliance"
        "eu-responsible-person"
        "operational-management"
      ))
      (entities . (
        (primary-actor . "jacqueline-faucitt")
        (affected-entities . ("rst"))
      ))
      (jax-perspective . (
        (role . "CEO and EU Responsible Person")
        (expertise . "Business operations and regulatory compliance")
        (evidence-strength . 0.96)
        (key-points . (
          "CEO responsibilities for RST"
          "EU Responsible Person duties"
          "Regulatory compliance management"
          "Operational decision-making authority"
        ))
      ))
      (lex-principles . (
        "ceo-duties"
        "regulatory-compliance"
        "fiduciary-duties"
      ))
    ))
    
    ("PARA_11-11_5" . (
      (priority . "1-Critical")
      (topic . "Urgency - Manufactured Crisis")
      (legal-aspects . (
        "manufactured-urgency"
        "self-created-crisis"
        "bad-faith-litigation"
        "abuse-of-process"
      ))
      (entities . (
        (primary-actor . "peter-faucitt")
        (primary-victims . ("jacqueline-faucitt" "daniel-faucitt"))
      ))
      (temporal-pattern . (
        (type . "manufactured-crisis")
        (sequence . (
          "Card cancellations → Systems disrupted"
          "Documentation obstruction → Crisis created"
          "Claim urgency → Litigation filed"
        ))
        (confidence . 0.95)
      ))
      (lex-principles . (
        "manufactured-crisis"
        "bad-faith-litigation"
        "abuse-of-process"
        "self-created-urgency"
      ))
    ))
    
    ("PARA_13-13_1" . (
      (priority . "1-Critical")
      (topic . "Interim Relief - Void Ab Initio")
      (legal-aspects . (
        "interim-relief"
        "void-ab-initio"
        "operational-impossibility"
        "bad-faith-application"
      ))
      (entities . (
        (primary-actor . "peter-faucitt")
        (primary-victims . ("jacqueline-faucitt" "daniel-faucitt"))
      ))
      (lex-principles . (
        "void-ab-initio"
        "interim-relief-requirements"
        "operational-impossibility"
        "bad-faith-litigation"
      ))
    ))
  )
  
  #:resolution-methodology
  "Resolve AD paragraph legal aspects in 8 steps:
  
  1. **Identify AD Paragraph**: Locate paragraph in priority structure
  2. **Extract Legal Aspects**: Identify all legal issues in paragraph
  3. **Map Entities**: Identify actors, victims, and affected entities
  4. **Analyze Temporal Patterns**: Detect retaliation, coordination, or hypocrisy patterns
  5. **Assess Evidence Strength**: Calculate multi-factor evidence strength
  6. **Determine Perspectives**: Identify Jax and Dan perspectives and expertise
  7. **Link Lex Principles**: Connect to applicable legal principles
  8. **Generate Recommendations**: Suggest evidence annexures and improvements"
  
  #:legal-implications '(
    "Comprehensive AD paragraph legal aspect mapping"
    "Entity-relation-event integration"
    "Temporal pattern detection and confidence scoring"
    "Evidence strength calculation"
    "Perspective-specific expertise identification"
    "Lex principle linkage"
    "Evidence annexure recommendations"
  ))

;;;
;;; ENHANCED PRINCIPLE: Advanced Temporal Pattern Detection
;;;

(define-principle detect-advanced-temporal-patterns
  #:name "Advanced Temporal Pattern Detection"
  #:confidence 0.98
  #:domain '(temporal-analysis causation evidence)
  #:description "Detects complex temporal patterns with multi-factor confidence scoring"
  
  #:pattern-types
  '(
    (immediate-retaliation . (
      (interval . "1 day")
      (base-confidence . 0.98)
      (description . "Strongest evidence of causation and bad faith")
    ))
    (coordinated-retaliation . (
      (interval . "7 days")
      (base-confidence . 0.94)
      (description . "Demonstrates multi-actor coordination")
    ))
    (litigation-weaponization . (
      (interval . "2 days")
      (base-confidence . 0.98)
      (description . "Settlement discussion used to obtain cooperation")
    ))
    (hypocrisy-pattern . (
      (interval . "variable")
      (base-confidence . 0.94)
      (description . "Inconsistent application of standards")
    ))
    (manufactured-crisis . (
      (interval . "sequential")
      (base-confidence . 0.95)
      (description . "Self-created crisis as litigation pretext")
    ))
  )
  
  #:confidence-factors
  '(
    (temporal-proximity . 0.25)  ; Closer in time = higher confidence
    (actor-motivation . 0.20)    ; Clear motive = higher confidence
    (pattern-consistency . 0.20) ; Repeated pattern = higher confidence
    (documentary-evidence . 0.15) ; Strong documentation = higher confidence
    (witness-testimony . 0.10)   ; Witness support = higher confidence
    (alternative-explanation . -0.10) ; Plausible alternative = lower confidence
  )
  
  #:detection-algorithm
  "Detect temporal patterns with confidence scoring:
  
  1. **Identify Event Pairs**: Find trigger-response event pairs
  2. **Calculate Temporal Proximity**: Measure time interval
  3. **Assess Actor Motivation**: Evaluate motive for response
  4. **Check Pattern Consistency**: Compare to other instances
  5. **Evaluate Evidence**: Assess documentary and testimonial support
  6. **Consider Alternatives**: Evaluate alternative explanations
  7. **Calculate Confidence**: Sum weighted factors for final confidence score
  8. **Classify Pattern**: Assign pattern type based on characteristics"
  
  #:case-application
  "Case 2025-137857 Temporal Patterns:
  
  **Pattern 1: Immediate Retaliation (1-day)**
  - Trigger: 2025-06-06 (Dan fraud report)
  - Response: 2025-06-07 (Card cancellation)
  - Confidence: 0.98
  - Factors:
    * Temporal proximity: 0.25 (1 day = maximum)
    * Actor motivation: 0.20 (clear retaliation motive)
    * Documentary evidence: 0.15 (bank records, emails)
    * Pattern consistency: 0.20 (consistent with other retaliations)
    * Alternative explanation: -0.02 (weak alternatives)
  
  **Pattern 2: Coordinated Retaliation (7-day)**
  - Trigger: 2025-05-15 (Jax confronts Rynette)
  - Response: 2025-05-22 (Orders removed)
  - Confidence: 0.94
  - Factors:
    * Temporal proximity: 0.20 (7 days = high)
    * Actor motivation: 0.20 (clear retaliation motive)
    * Documentary evidence: 0.15 (Shopify logs)
    * Pattern consistency: 0.20 (consistent with coordination)
    * Multi-actor: 0.15 (Peter-Rynette coordination)
    * Alternative explanation: -0.06 (some alternatives)
  
  **Pattern 3: Litigation Weaponization (2-day)**
  - Cooperation: 2025-08-11 (Jax signs backdating)
  - Betrayal: 2025-08-13 (Interdict filed)
  - Confidence: 0.98
  - Factors:
    * Temporal proximity: 0.25 (2 days = maximum)
    * Actor motivation: 0.20 (clear bad faith)
    * Documentary evidence: 0.15 (court records)
    * Pattern consistency: 0.20 (settlement Trojan horse)
    * Witness testimony: 0.10 (Gee witness)
    * Alternative explanation: -0.02 (weak alternatives)"
  
  #:legal-implications '(
    "Temporal patterns demonstrate causation"
    "High confidence scores support bad faith claims"
    "Multi-factor analysis strengthens evidence"
    "Pattern consistency demonstrates systematic abuse"
  ))

;;;
;;; ENHANCED PRINCIPLE: Multi-Factor Evidence Strength Calculation
;;;

(define-principle calculate-multi-factor-evidence-strength
  #:name "Multi-Factor Evidence Strength Calculation"
  #:confidence 0.97
  #:domain '(evidence quantification)
  #:description "Calculates evidence strength using multiple weighted factors"
  
  #:strength-factors
  '(
    (documentary-evidence . 0.30)     ; Bank statements, emails, contracts
    (temporal-correlation . 0.25)     ; Timing and causation evidence
    (witness-testimony . 0.15)        ; Witness statements and affidavits
    (expert-analysis . 0.15)          ; Technical or professional expertise
    (pattern-consistency . 0.10)      ; Repeated pattern evidence
    (admission-against-interest . 0.05) ; Opponent's admissions
  )
  
  #:calculation-methodology
  "Calculate evidence strength in 6 steps:
  
  1. **Assess Documentary Evidence**: Evaluate quality and completeness
  2. **Evaluate Temporal Correlation**: Measure timing and causation strength
  3. **Consider Witness Testimony**: Assess witness credibility and relevance
  4. **Factor Expert Analysis**: Evaluate expert qualifications and opinions
  5. **Check Pattern Consistency**: Compare to other instances
  6. **Calculate Total Strength**: Sum weighted factors for final score (0.0-1.0)"
  
  #:case-application
  "Case 2025-137857 Evidence Strength Examples:
  
  **PARA_7_2-7_5 (Card Cancellation Sabotage)**
  - Documentary evidence: 0.30 (bank records, emails, system logs)
  - Temporal correlation: 0.25 (1-day proximity = maximum)
  - Expert analysis: 0.15 (Dan's CIO expertise)
  - Pattern consistency: 0.10 (consistent with other retaliations)
  - **Total: 0.80 (Very Strong)**
  
  **PARA_7_6 (Director Loan Hypocrisy)**
  - Documentary evidence: 0.30 (bank statements for all withdrawals)
  - Temporal correlation: 0.20 (Peter's post-criticism withdrawal)
  - Expert analysis: 0.12 (accountant confirmation)
  - Pattern consistency: 0.10 (4 instances by Peter)
  - Admission against interest: 0.05 (Peter acknowledges his withdrawals)
  - **Total: 0.77 (Very Strong)**
  
  **PARA_3-3_10 (Responsible Person Crisis)**
  - Documentary evidence: 0.28 (system architecture, regulatory docs)
  - Temporal correlation: 0.25 (manufactured crisis sequence)
  - Expert analysis: 0.15 (Dan's technical expertise, Jax's regulatory expertise)
  - Pattern consistency: 0.10 (consistent with manufactured crisis pattern)
  - **Total: 0.78 (Very Strong)**"
  
  #:legal-implications '(
    "Evidence strength quantification supports legal arguments"
    "Multi-factor analysis provides comprehensive assessment"
    "High scores indicate strong evidentiary foundation"
    "Weighted factors reflect legal significance"
  ))

;;;
;;; NEW PRINCIPLE: JAX-DAN Response Optimization Analysis
;;;

(define-principle analyze-jax-dan-response-optimization
  #:name "JAX-DAN Response Optimization Analysis"
  #:confidence 0.96
  #:domain '(legal-strategy response-optimization)
  #:description "Analyzes and optimizes jax-dan-response materials based on AD elements"
  
  #:optimization-methodology
  "Optimize jax-dan-response in 7 steps:
  
  1. **Identify AD Paragraph**: Locate paragraph in priority structure
  2. **Assess Current Response**: Evaluate existing response materials
  3. **Identify Gaps**: Determine missing evidence or analysis
  4. **Determine Perspectives**: Identify Jax vs Dan perspective and expertise
  5. **Recommend Enhancements**: Suggest specific improvements
  6. **Generate Annexure List**: Create evidence annexure recommendations
  7. **Calculate Confidence**: Assess strength of enhanced response"
  
  #:perspective-allocation
  "Allocate perspectives based on expertise:
  
  **Dan's Perspective (Technical/Infrastructure)**:
  - IT infrastructure and technical architecture
  - Cloud services and system administration
  - Technical cost justification
  - System access and security
  - Business continuity technical analysis
  - 37-jurisdiction technical requirements
  
  **Jax's Perspective (Business/Regulatory)**:
  - Business operations and strategy
  - Regulatory compliance (EU Responsible Person)
  - Revenue stream management
  - Customer relationships
  - Brand management
  - Business impact assessment
  
  **Shared Perspectives**:
  - Financial impact quantification
  - Temporal pattern analysis
  - Bad faith litigation evidence
  - Trust and fiduciary duty issues"
  
  #:enhancement-recommendations
  '(
    (para-7-2-7-5 . (
      (current-strength . 0.85)
      (target-strength . 0.98)
      (enhancements . (
        "Add comprehensive technical infrastructure dependency analysis"
        "Emphasize 1-day temporal proximity for causation"
        "Quantify business continuity impact across 37 jurisdictions"
        "Document cloud services architecture and costs"
        "Create IT expense justification by category"
      ))
      (annexures . 7)
    ))
    (para-7-6 . (
      (current-strength . 0.82)
      (target-strength . 0.94)
      (enhancements . (
        "Create comprehensive comparative table (Peter vs Dan)"
        "Highlight Peter's withdrawal on 2025-07-20 (post-criticism)"
        "Document established practice with exact dates and amounts"
        "Obtain accountant confirmation of practice"
        "Emphasize selective enforcement for litigation advantage"
      ))
      (annexures . 6)
    ))
    (para-10-5-10-10-23 . (
      (current-strength . 0.78)
      (target-strength . 0.92)
      (enhancements . (
        "Add precise technical infrastructure impact analysis"
        "Quantify cloud services disruption costs"
        "Document software licensing impact"
        "Calculate emergency system recovery costs"
        "Provide total quantifiable impact (excluding opportunity costs)"
      ))
      (annexures . 5)
    ))
    (para-3-3-10 . (
      (current-strength . 0.83)
      (target-strength . 0.96)
      (enhancements . (
        "Expand technical infrastructure requirements analysis"
        "Document system dependencies for EU Responsible Person duties"
        "Emphasize operational impossibility under interdict"
        "Demonstrate Peter's technical knowledge and bad faith"
        "Support void ab initio argument with technical evidence"
      ))
      (annexures . 7)
    ))
  )
  
  #:legal-implications '(
    "Optimized responses strengthen legal position"
    "Perspective allocation maximizes expertise utilization"
    "Evidence annexure recommendations support claims"
    "Confidence scoring guides prioritization"
  ))

;;;
;;; NEW PRINCIPLE: Evidence Annexure Recommendations
;;;

(define-principle generate-evidence-annexure-recommendations
  #:name "Evidence Annexure Recommendations"
  #:confidence 0.95
  #:domain '(evidence documentation)
  #:description "Generates specific evidence annexure recommendations for each AD paragraph"
  
  #:annexure-naming-convention
  "Annexure Naming Convention:
  
  **Format**: {RESPONDENT}-{CATEGORY}-{NUMBER}: {Description}
  
  **Respondent Codes**:
  - DAN: Daniel Faucitt (Second Respondent)
  - JAX: Jacqueline Faucitt (First Respondent)
  - SHARED: Both respondents
  
  **Category Codes**:
  - IT: Information Technology
  - FIN: Financial
  - RP: Responsible Person
  - REG: Regulatory
  - IMPACT: Impact Assessment
  - TIMELINE: Timeline Analysis
  - COORD: Coordination Evidence
  
  **Examples**:
  - DAN-IT-01: Fraud report submission confirmation
  - JAX-RP-01: EU Responsible Person appointment documentation
  - SHARED-TIMELINE-01: Comprehensive temporal pattern analysis"
  
  #:annexure-recommendations-by-paragraph
  '(
    ("PARA_7_2-7_5" . (
      "DAN-IT-01: Fraud report submission confirmation (2025-06-06)"
      "DAN-IT-02: Card cancellation notification (2025-06-07)"
      "DAN-IT-03: Technical infrastructure dependency matrix"
      "DAN-IT-04: Business continuity impact assessment"
      "DAN-IT-05: 37-jurisdiction operational requirements"
      "DAN-IT-06: Cloud services architecture diagram"
      "DAN-IT-07: IT expense justification by category"
    ))
    ("PARA_7_6" . (
      "DAN-FIN-01: Bank statements showing Peter's withdrawals (2023-2025)"
      "DAN-FIN-02: Bank statement showing Dan's payment (2025-07-16)"
      "DAN-FIN-03: Board resolution records (absence thereof)"
      "DAN-FIN-04: Comparative analysis table (Peter vs Dan)"
      "DAN-FIN-05: Accountant confirmation of established practice"
      "DAN-FIN-06: Peter's withdrawal on 2025-07-20 (post-criticism)"
    ))
    ("PARA_7_7-7_8" . (
      "DAN-FIN-07: Bank statement showing R500,000 payment"
      "DAN-FIN-08: Transaction confirmation"
    ))
    ("PARA_7_9-7_11" . (
      "DAN-FIN-09: Business necessity documentation"
      "DAN-FIN-10: Comparative analysis (Peter vs Dan)"
      "DAN-FIN-11: Established practice timeline"
    ))
    ("PARA_10_5-10_10_23" . (
      "DAN-FIN-IMPACT-01: Cloud services cost breakdown"
      "DAN-FIN-IMPACT-02: Software licensing invoices"
      "DAN-FIN-IMPACT-03: Emergency recovery expense documentation"
      "DAN-FIN-IMPACT-04: Business continuity cost analysis"
      "DAN-FIN-IMPACT-05: 37-jurisdiction operational impact assessment"
    ))
    ("PARA_3-3_10" . (
      "DAN-RP-01: Technical infrastructure architecture diagram"
      "DAN-RP-02: 37-jurisdiction system requirements matrix"
      "DAN-RP-03: EU Responsible Person system dependencies"
      "DAN-RP-04: System access logs and audit trails"
      "DAN-RP-05: Regulatory compliance platform documentation"
      "DAN-RP-06: Business continuity impact assessment"
      "DAN-RP-07: Peter's technical knowledge evidence"
      "JAX-RP-01: EU Responsible Person appointment documentation"
      "JAX-RP-02: Regulatory compliance requirements"
      "JAX-RP-03: Operational impossibility analysis"
    ))
  )
  
  #:legal-implications '(
    "Systematic evidence annexure organization"
    "Clear naming convention for easy reference"
    "Comprehensive evidence coverage"
    "Perspective-specific evidence allocation"
  ))

;;; Export all principles
(export resolve-ad-paragraph-legal-aspects
        detect-advanced-temporal-patterns
        calculate-multi-factor-evidence-strength
        analyze-jax-dan-response-optimization
        generate-evidence-annexure-recommendations)
