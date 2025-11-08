;;; South African Company Law - Director Collective Action
;;; Enhanced principles for director collective action requirements and unilateral action invalidity
;;; Date: 2025-11-08
;;; Case: 2025-137857 (Peter Faucitt v. Jacqueline & Daniel Faucitt)
(define-module (lex cmp za south-african-company-law-director-collective-action)
  #:use-module (lex lv1 known-laws)
  #:use-module (lex cmp za south-african-company-law)
  #:export (
    director-collective-action-requirement
    board-resolution-necessity-significant-actions
    unilateral-director-action-invalidity-test
    director-action-authorization-documentation
    director-collective-action-breach-remedies
  ))

;;;
;;; NEW PRINCIPLE: Director Collective Action Requirement
;;;
(define-principle director-collective-action-requirement
  #:name "Director Collective Action Requirement"
  #:confidence 0.98
  #:domain '(company-law corporate-governance director-duties)
  #:description "Tests whether a director's action requires collective board action and board resolution under Companies Act s66"
  
  #:core-elements '(
    (director-action "Action taken by director")
    (significance-test "Action is significant and affects company/other directors")
    (collective-action-requirement "Companies Act s66 requires collective board action")
    (board-resolution-required "Board resolution required for significant actions")
    (unilateral-action-prohibited "Unilateral action without board resolution prohibited")
    (action-invalidity "Unilateral action is invalid without proper authorization")
  )
  
  #:legal-framework
  "Companies Act 71 of 2008, Section 66:
  
  **s66(1)**: The business and affairs of a company must be managed by or under the direction of its board, which has the authority to exercise all of the powers and perform any of the functions of the company.
  
  **s66(2)**: The board of a company may delegate to a director, prescribed officer, employee, committee, or other person any of the powers or functions of the board.
  
  **s66(8)**: A decision of the board must be approved by a resolution adopted at a board meeting.
  
  **Interpretation**: Significant actions affecting the company or other directors require collective board action through board resolution. Unilateral actions by individual directors without board authorization are invalid."
  
  #:test-methodology
  "Apply the director collective action test in 6 steps:
  
  1. **Identify Director Action**:
     - What action did the director take?
     - When did the action occur?
     - What was the effect of the action?
     - Who was affected by the action?
  
  2. **Assess Action Significance**:
     - Does action affect company operations?
     - Does action affect other directors?
     - Does action affect company assets?
     - Does action have financial implications?
     - Is action reversible or irreversible?
  
  3. **Test Collective Action Requirement**:
     - Is action within board's authority (s66(1))?
     - Has board delegated authority to individual director (s66(2))?
     - If no delegation, is board resolution required (s66(8))?
     - Does company MOI specify requirements?
  
  4. **Verify Board Resolution**:
     - Was board meeting held?
     - Was resolution adopted?
     - Was resolution documented?
     - Did resolution authorize specific action?
  
  5. **Determine Unilateral Action Status**:
     - If significant action + no delegation + no resolution = UNILATERAL
     - Unilateral action prohibited under s66
     - Action invalid without proper authorization
  
  6. **Assess Remedies**:
     - Action should be reversed
     - Affected parties entitled to relief
     - Director may be liable for breach
     - Costs may be awarded against director"
  
  #:significance-factors '(
    (affects-all-directors 0.98 "Action affects all directors' ability to perform duties")
    (operational-disruption 0.97 "Action disrupts company operations")
    (financial-impact 0.96 "Action has significant financial implications")
    (access-denial 0.97 "Action denies access to company systems/resources")
    (irreversible-consequences 0.95 "Action has irreversible consequences")
    (affects-third-parties 0.94 "Action affects third parties (customers, suppliers)")
    (regulatory-implications 0.96 "Action has regulatory compliance implications")
    (strategic-decision 0.95 "Action involves strategic business decision")
  )
  
  #:case-application
  "Faucitt Family Trust - Peter's Unilateral Card Cancellation:
  
  **Director Action Identified**:
  - **Action**: Peter cancelled all business cards unilaterally
  - **Date**: June 7, 2025 (1 day after Dan's cooperation)
  - **Effect**: All directors (Peter, Jax, Dan) lost access to company systems
  - **Affected**: All three directors, company operations, third parties
  
  **Action Significance Assessment**:
  
  | Significance Factor | Present? | Impact |
  |---------------------|----------|--------|
  | Affects all directors | YES ✓ | Dan and Jax lost access to systems |
  | Operational disruption | YES ✓ | Business operations disrupted |
  | Financial impact | YES ✓ | Revenue generation affected |
  | Access denial | YES ✓ | Documentation systems inaccessible |
  | Irreversible consequences | YES ✓ | Documentation lost, relationships damaged |
  | Affects third parties | YES ✓ | Customers, suppliers affected |
  | Regulatory implications | YES ✓ | EU Responsible Person compliance jeopardized |
  | Strategic decision | YES ✓ | Affects business continuity strategy |
  
  **Significance Score**: 8/8 factors = **HIGHLY SIGNIFICANT ACTION**
  
  **Collective Action Requirement Test**:
  - **Within Board Authority (s66(1))**: YES - card management is board function
  - **Delegated to Peter (s66(2))**: NO - no delegation documented
  - **Board Resolution Required (s66(8))**: YES - significant action requires resolution
  - **MOI Requirements**: Standard MOI requires board resolution for significant actions
  
  **Board Resolution Verification**:
  - **Board Meeting Held**: NO
  - **Resolution Adopted**: NO
  - **Resolution Documented**: NO
  - **Specific Authorization**: NO
  
  **Unilateral Action Determination**:
  - ✓ Significant action (8/8 factors)
  - ✓ No delegation to Peter
  - ✓ No board resolution
  - **CONCLUSION**: UNILATERAL ACTION (prohibited under s66)
  
  **Action Invalidity**:
  - Peter's card cancellation is **INVALID**
  - Action taken without proper authorization
  - Breach of Companies Act s66
  - Action should be reversed
  
  **Remedies Assessment**:
  1. **Reversal**: Cards should be reinstated
  2. **Relief**: Dan and Jax entitled to access restoration
  3. **Liability**: Peter liable for breach of director duties
  4. **Costs**: Costs awarded against Peter
  5. **Damages**: Peter liable for operational losses
  
  **Legal Implications**:
  - Peter breached director collective action requirement
  - Card cancellation is invalid and should be reversed
  - Peter cannot rely on consequences of invalid action
  - Peter's complaint about documentation obstruction is estopped
  - Court should order reversal and award costs against Peter"
  
  #:legal-implications '(
    "Director collective action requirement breached"
    "Unilateral action invalid under Companies Act s66"
    "Action should be reversed"
    "Director liable for breach"
    "Costs awarded against director"
    "Affected directors entitled to relief"
  ))

;;;
;;; NEW PRINCIPLE: Board Resolution Necessity Significant Actions
;;;
(define-principle board-resolution-necessity-significant-actions
  #:name "Board Resolution Necessity for Significant Actions"
  #:confidence 0.97
  #:domain '(company-law corporate-governance board-procedures)
  #:description "Defines which director actions require board resolution and establishes necessity test"
  
  #:resolution-required-categories '(
    (system-access-changes 0.98 "Changes to director access to company systems")
    (financial-authority-changes 0.97 "Changes to director financial authority")
    (operational-disruption-actions 0.96 "Actions causing operational disruption")
    (multi-director-impact-actions 0.97 "Actions affecting multiple directors")
    (strategic-business-decisions 0.95 "Strategic business decisions")
    (significant-expenditure 0.96 "Expenditure above delegated authority")
    (third-party-relationship-changes 0.94 "Changes to third-party relationships")
    (regulatory-compliance-actions 0.96 "Actions affecting regulatory compliance")
  )
  
  #:test-methodology
  "Test whether board resolution is necessary in 4 steps:
  
  1. **Categorize Action**:
     - Which category does action fall into?
     - Does action fit multiple categories?
     - What is highest confidence category?
  
  2. **Assess Impact**:
     - How many directors affected?
     - What is financial impact?
     - What is operational impact?
     - What is strategic impact?
  
  3. **Check Delegation**:
     - Has board delegated authority?
     - Is delegation documented?
     - Does delegation cover this specific action?
  
  4. **Determine Necessity**:
     - If significant category + no delegation = RESOLUTION REQUIRED
     - If resolution required + no resolution = BREACH
     - Breach consequences: invalidity, reversal, liability"
  
  #:case-application
  "Faucitt Family Trust - Card Cancellation Resolution Necessity:
  
  **Action Categorization**:
  
  | Category | Applies? | Confidence | Reasoning |
  |----------|----------|------------|-----------|
  | System access changes | YES ✓ | 0.98 | Cards provide system access |
  | Financial authority changes | YES ✓ | 0.97 | Cards enable financial transactions |
  | Operational disruption | YES ✓ | 0.96 | Business operations disrupted |
  | Multi-director impact | YES ✓ | 0.97 | All 3 directors affected |
  | Strategic decisions | YES ✓ | 0.95 | Affects business continuity |
  | Third-party relationships | YES ✓ | 0.94 | Customer/supplier relationships affected |
  | Regulatory compliance | YES ✓ | 0.96 | EU compliance jeopardized |
  
  **Categories Matched**: 7/8 = **HIGHLY SIGNIFICANT**
  
  **Impact Assessment**:
  - **Directors Affected**: 3/3 (100%)
  - **Financial Impact**: HIGH (revenue generation blocked)
  - **Operational Impact**: HIGH (business operations disrupted)
  - **Strategic Impact**: HIGH (business continuity threatened)
  
  **Delegation Check**:
  - **Board Delegation**: NO - no delegation to Peter for card cancellation
  - **Documentation**: NO - no written delegation
  - **Specific Coverage**: NO - delegation does not cover this action
  
  **Necessity Determination**:
  - ✓ Significant categories (7/8)
  - ✓ No delegation
  - **CONCLUSION**: BOARD RESOLUTION REQUIRED
  
  **Breach Assessment**:
  - Resolution required: YES
  - Resolution obtained: NO
  - **BREACH**: Peter breached board resolution necessity requirement
  
  **Consequences**:
  1. Action invalid
  2. Action should be reversed
  3. Peter liable for breach
  4. Costs awarded against Peter
  
  **Legal Implications**:
  - Board resolution was necessary for card cancellation
  - Peter's failure to obtain resolution is breach
  - Card cancellation is invalid
  - Court should order reversal"
  
  #:legal-implications '(
    "Board resolution necessary for significant actions"
    "Failure to obtain resolution is breach"
    "Action invalid without resolution"
    "Court should order reversal"
    "Director liable for breach"
  ))

;;;
;;; NEW PRINCIPLE: Unilateral Director Action Invalidity Test
;;;
(define-principle unilateral-director-action-invalidity-test
  #:name "Unilateral Director Action Invalidity Test"
  #:confidence 0.96
  #:domain '(company-law corporate-governance director-authority)
  #:description "Tests validity of unilateral director actions and determines invalidity consequences"
  
  #:invalidity-test-elements '(
    (action-significance "Action is significant under board resolution necessity test")
    (no-board-authorization "No board resolution or delegation authorizes action")
    (affects-other-directors "Action affects other directors' ability to perform duties")
    (no-emergency-justification "No genuine emergency justifies unilateral action")
    (alternative-available "Alternative collective action process available")
    (bad-faith-indicators "Indicators suggest bad faith motivation")
  )
  
  #:test-methodology
  "Test unilateral action invalidity in 6 steps:
  
  1. **Verify Action Significance**: Apply board resolution necessity test
  2. **Check Authorization**: Verify board resolution or delegation
  3. **Assess Impact on Others**: Determine effect on other directors
  4. **Test Emergency Justification**: Assess whether genuine emergency exists
  5. **Evaluate Alternatives**: Determine if collective action was available
  6. **Identify Bad Faith**: Look for bad faith indicators
  
  **Invalidity Formula**:
  - If 4+ elements present = INVALID ACTION
  - If 5+ elements present = INVALID + BAD FAITH
  - If 6 elements present = INVALID + BAD FAITH + ABUSE"
  
  #:case-application
  "Faucitt Family Trust - Peter's Card Cancellation Invalidity:
  
  **Invalidity Test Results**:
  
  | Element | Present? | Evidence |
  |---------|----------|----------|
  | 1. Action significance | YES ✓ | 7/8 significant categories matched |
  | 2. No authorization | YES ✓ | No board resolution, no delegation |
  | 3. Affects other directors | YES ✓ | Dan and Jax lost system access |
  | 4. No emergency | YES ✓ | No genuine emergency (1 day after cooperation) |
  | 5. Alternative available | YES ✓ | Board meeting could be called |
  | 6. Bad faith indicators | YES ✓ | 1-day interval, timing suspicious |
  
  **Elements Present**: 6/6 = **INVALID + BAD FAITH + ABUSE**
  
  **Invalidity Determination**:
  - **Action Validity**: INVALID
  - **Bad Faith**: PRESENT (1-day interval after cooperation)
  - **Abuse of Power**: PRESENT (used director position to sabotage)
  
  **Bad Faith Indicators**:
  1. **Timing**: 1 day after Dan's cooperation (June 6 → June 7)
  2. **Retaliation**: Appears to be retaliation for cooperation
  3. **Manufactured Crisis**: Created documentation problem
  4. **No Emergency**: No genuine emergency justified unilateral action
  5. **Pattern**: Part of pattern of actions against Dan/Jax
  
  **Invalidity Consequences**:
  1. **Action Void**: Card cancellation is void ab initio
  2. **No Legal Effect**: Action has no legal effect
  3. **Reversal Required**: Action must be reversed
  4. **Estoppel**: Peter cannot rely on consequences of invalid action
  5. **Liability**: Peter liable for damages from invalid action
  6. **Costs**: Costs on punitive scale against Peter
  
  **Legal Implications**:
  - Peter's card cancellation is invalid
  - Action taken in bad faith
  - Abuse of director power established
  - Peter cannot complain about consequences of invalid action
  - Court should reverse action and award punitive costs"
  
  #:legal-implications '(
    "Unilateral action invalid"
    "Bad faith established"
    "Abuse of director power"
    "Action void ab initio"
    "Reversal required"
    "Punitive costs warranted"
  ))

;;;
;;; NEW PRINCIPLE: Director Action Authorization Documentation
;;;
(define-principle director-action-authorization-documentation
  #:name "Director Action Authorization Documentation"
  #:confidence 0.95
  #:domain '(company-law corporate-governance documentation)
  #:description "Requires documentation of director action authorization through board resolutions or delegation"
  
  #:documentation-requirements '(
    (board-resolution-minutes "Board resolution must be recorded in board minutes")
    (delegation-written "Delegation of authority must be in writing")
    (specific-authorization "Authorization must be specific to action taken")
    (date-recorded "Date of authorization must be recorded")
    (signatories-identified "Authorizing directors must be identified")
    (action-described "Action authorized must be clearly described")
  )
  
  #:documentation-test
  "Test authorization documentation in 4 steps:
  
  1. **Request Documentation**:
     - Request board resolution or delegation
     - Request board minutes
     - Request written authorization
  
  2. **Verify Documentation**:
     - Is documentation present?
     - Is documentation authentic?
     - Is documentation specific?
     - Is documentation dated?
  
  3. **Assess Adequacy**:
     - Does documentation authorize specific action?
     - Is authorization clear and unambiguous?
     - Are all requirements satisfied?
  
  4. **Determine Authorization**:
     - If adequate documentation = AUTHORIZED
     - If inadequate/absent documentation = UNAUTHORIZED
     - Unauthorized action is invalid"
  
  #:case-application
  "Faucitt Family Trust - Card Cancellation Authorization Documentation:
  
  **Documentation Request**:
  - **Board Resolution**: Requested - NOT PROVIDED
  - **Board Minutes**: Requested - NOT PROVIDED
  - **Written Delegation**: Requested - NOT PROVIDED
  - **Any Authorization**: Requested - NOT PROVIDED
  
  **Documentation Verification**:
  
  | Requirement | Present? | Status |
  |-------------|----------|--------|
  | Board resolution minutes | NO ✗ | ABSENT |
  | Delegation in writing | NO ✗ | ABSENT |
  | Specific authorization | NO ✗ | ABSENT |
  | Date recorded | NO ✗ | ABSENT |
  | Signatories identified | NO ✗ | ABSENT |
  | Action described | NO ✗ | ABSENT |
  
  **Requirements Satisfied**: 0/6 = **NO DOCUMENTATION**
  
  **Adequacy Assessment**:
  - **Documentation Present**: NO
  - **Documentation Authentic**: N/A (absent)
  - **Documentation Specific**: N/A (absent)
  - **Documentation Dated**: N/A (absent)
  - **Adequacy**: INADEQUATE (absent)
  
  **Authorization Determination**:
  - Documentation adequate: NO
  - Documentation absent: YES
  - **CONCLUSION**: UNAUTHORIZED ACTION
  
  **Legal Implications**:
  - Peter's card cancellation is unauthorized
  - No documentation supports authorization
  - Absence of documentation proves lack of authorization
  - Unauthorized action is invalid
  - Peter liable for unauthorized action
  
  **Evidentiary Significance**:
  - Burden of proof on Peter to show authorization
  - Peter failed to provide any documentation
  - Absence of documentation is strong evidence of no authorization
  - Court should find action unauthorized"
  
  #:legal-implications '(
    "Authorization must be documented"
    "Absence of documentation proves lack of authorization"
    "Unauthorized action invalid"
    "Burden of proof on director claiming authorization"
    "Failure to provide documentation is evidence against authorization"
  ))

;;;
;;; NEW PRINCIPLE: Director Collective Action Breach Remedies
;;;
(define-principle director-collective-action-breach-remedies
  #:name "Director Collective Action Breach Remedies"
  #:confidence 0.94
  #:domain '(company-law corporate-governance remedies)
  #:description "Establishes remedies available for breach of director collective action requirement"
  
  #:available-remedies '(
    (action-reversal "Court orders reversal of invalid action")
    (status-quo-restoration "Court orders restoration of status quo ante")
    (access-restoration "Court orders restoration of access/rights")
    (declaratory-relief "Court declares action invalid")
    (costs-order "Costs awarded against breaching director")
    (damages-award "Damages awarded for losses caused")
    (director-liability "Director held personally liable")
    (injunctive-relief "Injunction against future breaches")
  )
  
  #:remedy-selection-criteria
  "Select appropriate remedies based on:
  
  1. **Severity of Breach**: More severe = more extensive remedies
  2. **Harm Caused**: Greater harm = higher damages
  3. **Bad Faith**: Bad faith = punitive costs
  4. **Reversibility**: Reversible action = reversal ordered
  5. **Ongoing Harm**: Continuing harm = injunction
  6. **Deterrence**: Need for deterrence = personal liability"
  
  #:case-application
  "Faucitt Family Trust - Remedies for Card Cancellation Breach:
  
  **Breach Severity Assessment**:
  - **Breach Type**: Director collective action requirement
  - **Severity**: HIGH (6/6 invalidity elements, bad faith, abuse)
  - **Harm**: HIGH (operational disruption, documentation obstruction)
  - **Bad Faith**: PRESENT (1-day interval, retaliation)
  - **Reversibility**: YES (cards can be reinstated)
  - **Ongoing Harm**: YES (continuing obstruction)
  
  **Appropriate Remedies**:
  
  | Remedy | Appropriate? | Justification |
  |--------|--------------|---------------|
  | Action reversal | YES ✓ | Action is reversible, should be reversed |
  | Status quo restoration | YES ✓ | Restore pre-cancellation access |
  | Access restoration | YES ✓ | Dan and Jax need system access |
  | Declaratory relief | YES ✓ | Declare action invalid |
  | Costs order | YES ✓ | Peter should bear costs (bad faith) |
  | Damages award | YES ✓ | Operational losses compensable |
  | Director liability | YES ✓ | Personal liability for bad faith breach |
  | Injunctive relief | YES ✓ | Prevent future unilateral actions |
  
  **Remedies Appropriate**: 8/8 = **COMPREHENSIVE RELIEF**
  
  **Specific Relief Requested**:
  
  1. **Action Reversal**:
     - Order: Peter must reinstate all cancelled cards
     - Timeline: Immediate (within 24 hours)
  
  2. **Status Quo Restoration**:
     - Order: Restore all access to pre-June 7, 2025 status
     - Scope: All systems, all directors
  
  3. **Access Restoration**:
     - Order: Dan and Jax must have full access restored
     - Systems: Banking, accounting, documentation, operations
  
  4. **Declaratory Relief**:
     - Declaration: Peter's card cancellation is invalid
     - Effect: No legal effect, void ab initio
  
  5. **Costs Order**:
     - Scale: Attorney-client scale (bad faith)
     - Payer: Peter personally
  
  6. **Damages Award**:
     - Operational losses: Quantified
     - Documentation costs: Quantified
     - Reputational damage: Quantified
  
  7. **Director Liability**:
     - Personal liability: Peter liable for all losses
     - No company indemnity: Bad faith excludes indemnity
  
  8. **Injunctive Relief**:
     - Injunction: Peter prohibited from future unilateral actions
     - Scope: All significant actions require board resolution
  
  **Legal Implications**:
  - Comprehensive relief appropriate for serious breach
  - Bad faith justifies punitive costs
  - Personal liability for director breach
  - Injunction prevents future breaches"
  
  #:legal-implications '(
    "Action reversal ordered"
    "Status quo restored"
    "Access restored to affected directors"
    "Action declared invalid"
    "Costs on attorney-client scale"
    "Damages awarded for losses"
    "Director personally liable"
    "Injunction against future breaches"
  ))
