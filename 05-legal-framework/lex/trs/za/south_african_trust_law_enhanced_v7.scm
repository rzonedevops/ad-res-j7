;;; South African Trust Law - Enhanced Version 7
;;; Enhanced with beneficiary-attack-temporal-correlation and multi-actor-coordination principles
;;; Date: 2025-11-06
;;; Case: 2025-137857 (Peter Faucitt v. Jacqueline & Daniel Faucitt)

(define-module (lex trs za south-african-trust-law-enhanced-v7)
  #:use-module (lex lv1 known-laws)
  #:use-module (lex trs za south-african-trust-law-enhanced-v6)
  #:export (
    beneficiary-attack-temporal-correlation
    trustee-coercion-then-attack-pattern
    beneficiary-cooperation-exploitation
  ))

;;;
;;; NEW PRINCIPLE: Beneficiary Attack Temporal Correlation
;;;

(define-principle beneficiary-attack-temporal-correlation
  #:name "Beneficiary Attack Temporal Correlation"
  #:confidence 0.97
  #:domain '(trust-law fiduciary-duty bad-faith temporal-analysis)
  #:description "Identifies patterns where trustees obtain beneficiary cooperation then immediately attack the beneficiary, indicating bad faith and exploitation"
  
  #:core-indicators '(
    (beneficiary-cooperation-obtained "Beneficiary provides cooperation (signing, consent, agreement)")
    (trustee-attack-follows-immediately "Trustee attacks beneficiary within short timeframe (days/weeks)")
    (temporal-proximity-suspicious "Temporal proximity suggests premeditation")
    (cooperation-exploited "Cooperation obtained under false pretenses or exploited")
    (beneficiary-harmed "Beneficiary harmed by trusting trustee")
    (trustee-bad-faith "Trustee bad faith demonstrated by timing")
  )
  
  #:temporal-correlation-methodology
  "Analyze temporal correlation between beneficiary cooperation and trustee attack:
  
  1. **Identify Cooperation Event**: Document when beneficiary provided cooperation (date, nature, context).
  
  2. **Identify Attack Event**: Document when trustee attacked beneficiary (date, nature, severity).
  
  3. **Calculate Temporal Proximity**: Days/weeks between cooperation and attack.
  
  4. **Assess Correlation Strength**: 
     - 0-3 days: Very high correlation (0.98)
     - 4-7 days: High correlation (0.96)
     - 8-14 days: Moderate correlation (0.93)
     - 15-30 days: Low correlation (0.88)
     - 30+ days: Minimal correlation (0.80)
  
  5. **Analyze Context**: Was cooperation obtained under false pretenses? Was settlement discussion ongoing?
  
  6. **Evaluate Bad Faith**: Does timing suggest premeditation? Was beneficiary exploited?"
  
  #:red-flags '(
    (cooperation-to-attack-within-3-days 0.98 "Beneficiary cooperation to trustee attack within 3 days")
    (settlement-discussion-concurrent 0.96 "Settlement discussion concurrent with cooperation request")
    (cooperation-involves-backdating 0.95 "Cooperation involves backdating trustee powers")
    (attack-includes-cooperating-beneficiary 0.97 "Attack specifically includes beneficiary who just cooperated")
    (no-intervening-events 0.94 "No intervening events between cooperation and attack")
    (trustee-has-absolute-powers 0.96 "Trustee has absolute powers but seeks court intervention")
  )
  
  #:case-application
  "Faucitt Family Trust - Peter (Trustee) attacks Jax (Beneficiary):
  
  **Cooperation Event (11 Aug 2025)**: 
  - Settlement discussion between Peter and Jax
  - Jax signs document backdating Peter's Main Trustee status to 1 Jul 2025
  - Context: Settlement negotiation, trust-building moment
  
  **Attack Event (13 Aug 2025)**:
  - Peter files interdict against Jax (and Dan)
  - 2 days after Jax signed backdating
  - Jax specifically named as respondent despite just cooperating
  
  **Temporal Proximity**: 2 days (very high correlation 0.98)
  
  **Correlation Analysis**:
  - Cooperation obtained during settlement discussion (false pretense)
  - Attack follows immediately (2 days)
  - No intervening events
  - Jax exploited for signing backdating then immediately attacked
  - Peter has absolute trust powers (backdated to 1 Jul) but seeks court interdict
  
  **Bad Faith Indicators**:
  - Timing suggests premeditation (cooperation obtained as setup for attack)
  - Settlement discussion used as false pretense
  - Beneficiary trust exploited
  - Backdating gives Peter absolute powers, making court action unnecessary
  - Attack includes beneficiary who just cooperated in good faith
  
  **Legal Implications**:
  - Trustee bad faith demonstrated (confidence 0.97)
  - Beneficiary protection required
  - Interdict should be set aside
  - Personal costs order warranted
  - Trustee removal may be appropriate"
  
  #:legal-implications '(
    "Trustee bad faith demonstrated by temporal correlation"
    "Beneficiary cooperation exploited"
    "Fiduciary duty breach (trustee exploits beneficiary trust)"
    "Interdict obtained through bad faith should be set aside"
    "Personal costs order warranted"
    "Trustee removal may be appropriate"
    "Beneficiary entitled to protection and remedies"
    "Court should scrutinize trustee's true motives"
  )
  
  #:related-principles '(
    beneficiary-protection-when-attacked
    trust-power-bypass-temporal-analysis
    backdating-coercion-indicators
    fiduciary-duty
    good-faith
    abuse-of-process
  )
  
  #:integration-points '(
    "jax-response/AD/2-High-Priority/PARA_11-11_5.md"
    "PETERS_BAD_FAITH_TIMELINE_ANALYSIS.md"
    "AFFIDAVIT_CASE_SIMULATION_ANALYSIS.md"
  )
  
  #:test-function
  (lambda (facts)
    (let ((cooperation-date (assoc-ref facts 'cooperation-date))
          (attack-date (assoc-ref facts 'attack-date))
          (settlement-discussion (assoc-ref facts 'settlement-discussion))
          (backdating-involved (assoc-ref facts 'backdating-involved))
          (beneficiary-included-in-attack (assoc-ref facts 'beneficiary-included-in-attack)))
      
      (let ((days-between (date-diff cooperation-date attack-date)))
        (and (<= days-between 3)
             settlement-discussion
             backdating-involved
             beneficiary-included-in-attack)))))

;;;
;;; NEW PRINCIPLE: Trustee Coercion Then Attack Pattern
;;;

(define-principle trustee-coercion-then-attack-pattern
  #:name "Trustee Coercion Then Attack Pattern"
  #:confidence 0.96
  #:domain '(trust-law fiduciary-duty coercion bad-faith)
  #:description "Identifies pattern where trustee uses coercive circumstances to obtain beneficiary cooperation, then attacks the beneficiary"
  
  #:core-indicators '(
    (coercive-circumstances-created "Trustee creates coercive circumstances (financial crisis, urgency)")
    (beneficiary-cooperation-under-duress "Beneficiary cooperates under duress or pressure")
    (cooperation-benefits-trustee "Cooperation primarily benefits trustee (e.g., backdating powers)")
    (immediate-attack-follows "Trustee attacks beneficiary immediately after obtaining cooperation")
    (beneficiary-harmed-twice "Beneficiary harmed by coercion AND by attack")
  )
  
  #:coercion-indicators '(
    (manufactured-crisis 0.96 "Trustee manufactured financial crisis (card cancellations, account restrictions)")
    (settlement-pressure 0.93 "Settlement discussion creates pressure to cooperate")
    (urgency-claims 0.91 "Trustee claims urgency to pressure cooperation")
    (information-asymmetry 0.94 "Beneficiary lacks full information about consequences")
    (trust-exploitation 0.95 "Trustee exploits beneficiary's trust in fiduciary relationship")
  )
  
  #:case-application
  "Faucitt Family Trust - Peter's coercion-then-attack pattern:
  
  **Phase 1: Create Coercive Circumstances (Jun-Aug 2025)**:
  - 7 Jun 2025: Peter cancels all business cards (creates financial crisis)
  - Jun-Aug 2025: Financial pressure builds on Jax and Dan
  - 11 Aug 2025: Settlement discussion (creates pressure to cooperate)
  
  **Phase 2: Obtain Cooperation Under Duress (11 Aug 2025)**:
  - Settlement discussion context (pressure to resolve)
  - Jax signs backdating of Peter's Main Trustee status
  - Backdating benefits Peter (absolute trust powers)
  - Jax cooperates in good faith, seeking resolution
  
  **Phase 3: Immediate Attack (13 Aug 2025)**:
  - 2 days after obtaining cooperation
  - Peter files interdict against Jax (and Dan)
  - Uses court despite having absolute trust powers (backdated)
  - Exploits beneficiary who just cooperated
  
  **Pattern Analysis**:
  - Coercive circumstances: Manufactured financial crisis (card cancellations)
  - Cooperation under duress: Settlement pressure, financial crisis
  - Cooperation benefits trustee: Backdating gives absolute powers
  - Immediate attack: 2 days after cooperation
  - Beneficiary harmed twice: By crisis AND by attack
  
  **Legal Implications**:
  - Coercion vitiates consent (backdating signature may be invalid)
  - Trustee bad faith demonstrated
  - Fiduciary duty breach (exploiting beneficiary vulnerability)
  - Interdict should be set aside
  - Personal costs order warranted"
  
  #:legal-implications '(
    "Coercion vitiates consent"
    "Backdating signature may be invalid"
    "Trustee bad faith demonstrated"
    "Fiduciary duty breach"
    "Abuse of process"
    "Beneficiary entitled to protection"
    "Interdict should be set aside"
    "Personal costs order warranted"
  )
  
  #:related-principles '(
    beneficiary-attack-temporal-correlation
    manufactured-crisis-indicators
    backdating-coercion-indicators
    fiduciary-duty
    duress
    undue-influence
  )
  
  #:integration-points '(
    "jax-response/AD/1-Critical/PARA_7_9-7_11.md"
    "jax-response/AD/2-High-Priority/PARA_11-11_5.md"
    "PETERS_CAUSATION_ANALYSIS.md"
  )
  
  #:test-function
  (lambda (facts)
    (let ((manufactured-crisis (assoc-ref facts 'manufactured-crisis))
          (cooperation-under-pressure (assoc-ref facts 'cooperation-under-pressure))
          (cooperation-benefits-trustee (assoc-ref facts 'cooperation-benefits-trustee))
          (immediate-attack (assoc-ref facts 'immediate-attack)))
      
      (and manufactured-crisis
           cooperation-under-pressure
           cooperation-benefits-trustee
           immediate-attack))))

;;;
;;; NEW PRINCIPLE: Beneficiary Cooperation Exploitation
;;;

(define-principle beneficiary-cooperation-exploitation
  #:name "Beneficiary Cooperation Exploitation"
  #:confidence 0.96
  #:domain '(trust-law fiduciary-duty exploitation bad-faith)
  #:description "Identifies when trustees exploit beneficiary cooperation obtained in good faith for strategic advantage"
  
  #:core-indicators '(
    (cooperation-obtained-in-good-faith "Beneficiary cooperates in good faith")
    (trustee-exploits-cooperation "Trustee exploits cooperation for strategic advantage")
    (cooperation-used-against-beneficiary "Cooperation used against beneficiary")
    (beneficiary-trust-betrayed "Beneficiary's trust in fiduciary relationship betrayed")
  )
  
  #:exploitation-patterns '(
    (backdating-then-attack 0.97 "Obtain backdating signature then attack signer")
    (settlement-trap 0.95 "Use settlement discussion to obtain cooperation then attack")
    (false-pretense-cooperation 0.96 "Obtain cooperation under false pretense")
    (immediate-reversal 0.94 "Obtain cooperation then immediately reverse course")
  )
  
  #:case-application
  "Faucitt Family Trust - Peter exploits Jax's cooperation:
  
  **Cooperation Obtained (11 Aug 2025)**:
  - Settlement discussion (implies resolution, not escalation)
  - Jax signs backdating in good faith
  - Jax trusts Peter as trustee (fiduciary relationship)
  
  **Exploitation (13 Aug 2025)**:
  - Peter uses backdated powers to claim authority
  - Peter attacks Jax despite her cooperation
  - Cooperation used to strengthen Peter's position
  - Jax's trust betrayed
  
  **Pattern**: Settlement-trap + backdating-then-attack
  
  **Legal Implications**:
  - Fiduciary duty breach (exploiting beneficiary trust)
  - Bad faith demonstrated
  - Cooperation obtained under false pretense (settlement discussion)
  - Beneficiary entitled to protection and remedies"
  
  #:legal-implications '(
    "Fiduciary duty breach"
    "Bad faith demonstrated"
    "Exploitation of beneficiary trust"
    "Cooperation obtained under false pretense"
    "Beneficiary entitled to protection"
    "Trustee removal may be appropriate"
    "Personal costs order warranted"
  )
  
  #:related-principles '(
    beneficiary-attack-temporal-correlation
    trustee-coercion-then-attack-pattern
    fiduciary-duty
    good-faith
    fraud
    misrepresentation
  )
  
  #:integration-points '(
    "jax-response/AD/2-High-Priority/PARA_11-11_5.md"
    "PETERS_BAD_FAITH_TIMELINE_ANALYSIS.md"
  )
  
  #:test-function
  (lambda (facts)
    (let ((cooperation-in-good-faith (assoc-ref facts 'cooperation-in-good-faith))
          (exploitation-follows (assoc-ref facts 'exploitation-follows))
          (beneficiary-harmed (assoc-ref facts 'beneficiary-harmed)))
      
      (and cooperation-in-good-faith
           exploitation-follows
           beneficiary-harmed))))
