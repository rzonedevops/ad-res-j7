;; urgency_test_interdict_v37.scm
;; South African Civil Procedure - Urgency Test Framework for Interdict Applications V37
;; Case: 2025-137857 (Peter Faucitt v. Jacqueline & Daniel Faucitt)
;; Purpose: Assess urgency claims with balance of convenience and self-created urgency detection

(define-module (lex civ-proc za urgency-test-interdict-v37)
  #:use-module (lex lv1 known-laws)
  #:export (
    urgency-claim
    make-urgency-claim
    assess-urgency-test
    evaluate-balance-of-convenience
    detect-self-created-urgency
    analyze-manufactured-urgency
    calculate-urgency-confidence
    ))

;; ============================================================================
;; RECORD TYPE DEFINITIONS
;; ============================================================================

;; Urgency Claim Record
(define-record-type <urgency-claim>
  (make-urgency-claim-internal
    claim-id
    applicant
    respondent
    alleged-harm
    timeframe-claim
    urgency-justification
    delay-explanation
    self-created-factors
    balance-of-convenience
    evidence-strength)
  urgency-claim?
  (claim-id urgency-claim-id)
  (applicant urgency-claim-applicant)
  (respondent urgency-claim-respondent)
  (alleged-harm urgency-claim-alleged-harm)
  (timeframe-claim urgency-claim-timeframe)
  (urgency-justification urgency-claim-justification)
  (delay-explanation urgency-claim-delay-explanation)
  (self-created-factors urgency-claim-self-created-factors)
  (balance-of-convenience urgency-claim-balance)
  (evidence-strength urgency-claim-evidence-strength))

;; Self-Created Urgency Factor Record
(define-record-type <self-created-urgency-factor>
  (make-self-created-urgency-factor
    factor-type
    description
    applicant-action
    temporal-relationship
    causation-strength)
  self-created-urgency-factor?
  (factor-type self-created-urgency-factor-type)
  (description self-created-urgency-factor-description)
  (applicant-action self-created-urgency-factor-action)
  (temporal-relationship self-created-urgency-factor-temporal)
  (causation-strength self-created-urgency-factor-causation))

;; Balance of Convenience Record
(define-record-type <balance-of-convenience>
  (make-balance-of-convenience
    applicant-harm
    respondent-harm
    applicant-harm-severity
    respondent-harm-severity
    applicant-harm-reversibility
    respondent-harm-reversibility
    public-interest)
  balance-of-convenience?
  (applicant-harm balance-applicant-harm)
  (respondent-harm balance-respondent-harm)
  (applicant-harm-severity balance-applicant-harm-severity)
  (respondent-harm-severity balance-respondent-harm-severity)
  (applicant-harm-reversibility balance-applicant-harm-reversibility)
  (respondent-harm-reversibility balance-respondent-harm-reversibility)
  (public-interest balance-public-interest))

;; ============================================================================
;; URGENCY TEST ASSESSMENT
;; ============================================================================

(define (assess-urgency-test claim)
  "Comprehensive urgency test assessment for interdict application"
  (let* ((urgency-justification-analysis (analyze-urgency-justification claim))
         (delay-analysis (analyze-delay-explanation claim))
         (self-created-analysis (detect-self-created-urgency claim))
         (manufactured-analysis (analyze-manufactured-urgency claim))
         (balance-analysis (evaluate-balance-of-convenience claim))
         (urgency-score (calculate-urgency-score claim urgency-justification-analysis delay-analysis self-created-analysis))
         (confidence (calculate-urgency-confidence claim)))
    (list
      (cons 'claim-id (urgency-claim-id claim))
      (cons 'urgency-justification-analysis urgency-justification-analysis)
      (cons 'delay-analysis delay-analysis)
      (cons 'self-created-analysis self-created-analysis)
      (cons 'manufactured-analysis manufactured-analysis)
      (cons 'balance-analysis balance-analysis)
      (cons 'urgency-score urgency-score)
      (cons 'urgency-determination (determine-urgency-outcome urgency-score))
      (cons 'confidence confidence))))

;; ============================================================================
;; URGENCY JUSTIFICATION ANALYSIS
;; ============================================================================

(define (analyze-urgency-justification claim)
  "Analyze the justification provided for urgency"
  (let* ((justification (urgency-claim-justification claim))
         (alleged-harm (urgency-claim-alleged-harm claim))
         (timeframe (urgency-claim-timeframe claim))
         (harm-severity (assess-harm-severity alleged-harm))
         (timeframe-reasonableness (assess-timeframe-reasonableness timeframe))
         (justification-strength (* harm-severity timeframe-reasonableness)))
    (list
      (cons 'justification justification)
      (cons 'alleged-harm alleged-harm)
      (cons 'timeframe timeframe)
      (cons 'harm-severity harm-severity)
      (cons 'timeframe-reasonableness timeframe-reasonableness)
      (cons 'justification-strength justification-strength)
      (cons 'justification-adequacy (cond
                                      ((> justification-strength 0.8) 'strong)
                                      ((> justification-strength 0.6) 'moderate)
                                      ((> justification-strength 0.4) 'weak)
                                      (else 'insufficient))))))

(define (assess-harm-severity harm)
  "Assess the severity of alleged harm"
  (cond
    ((member 'irreparable-harm harm) 0.95)
    ((member 'substantial-financial-loss harm) 0.8)
    ((member 'operational-disruption harm) 0.7)
    ((member 'reputational-damage harm) 0.6)
    ((member 'minor-inconvenience harm) 0.3)
    (else 0.1)))

(define (assess-timeframe-reasonableness timeframe)
  "Assess whether the claimed timeframe is reasonable"
  (cond
    ((string-contains timeframe "immediate") 0.9)
    ((string-contains timeframe "days") 0.7)
    ((string-contains timeframe "weeks") 0.5)
    ((string-contains timeframe "months") 0.2)
    (else 0.1)))

;; ============================================================================
;; DELAY EXPLANATION ANALYSIS
;; ============================================================================

(define (analyze-delay-explanation claim)
  "Analyze whether delay in bringing application undermines urgency"
  (let* ((delay-explanation (urgency-claim-delay-explanation claim))
         (delay-reasonableness (assess-delay-reasonableness delay-explanation))
         (delay-impact (calculate-delay-impact delay-reasonableness)))
    (list
      (cons 'delay-explanation delay-explanation)
      (cons 'delay-reasonableness delay-reasonableness)
      (cons 'delay-impact delay-impact)
      (cons 'delay-undermines-urgency (if (< delay-reasonableness 0.5) #t #f)))))

(define (assess-delay-reasonableness explanation)
  "Assess whether delay explanation is reasonable"
  (cond
    ((string-contains explanation "no-delay") 0.95)
    ((string-contains explanation "reasonable-delay") 0.7)
    ((string-contains explanation "justified-delay") 0.6)
    ((string-contains explanation "unexplained-delay") 0.2)
    ((string-contains explanation "substantial-delay") 0.1)
    (else 0.5)))

(define (calculate-delay-impact reasonableness)
  "Calculate impact of delay on urgency claim (lower = more negative impact)"
  (- 1.0 reasonableness))

;; ============================================================================
;; SELF-CREATED URGENCY DETECTION
;; ============================================================================

(define (detect-self-created-urgency claim)
  "Detect whether urgency was self-created by applicant's actions"
  (let* ((self-created-factors (urgency-claim-self-created-factors claim))
         (factor-count (length self-created-factors))
         (causation-scores (map self-created-urgency-factor-causation self-created-factors))
         (average-causation (if (null? causation-scores) 0.0
                                (/ (apply + causation-scores) (length causation-scores))))
         (self-created-score (* average-causation (min 1.0 (/ factor-count 3)))))
    (list
      (cons 'self-created-factors-count factor-count)
      (cons 'average-causation average-causation)
      (cons 'self-created-score self-created-score)
      (cons 'self-created-determination (cond
                                          ((> self-created-score 0.8) 'clearly-self-created)
                                          ((> self-created-score 0.6) 'likely-self-created)
                                          ((> self-created-score 0.4) 'possibly-self-created)
                                          (else 'not-self-created))))))

;; ============================================================================
;; MANUFACTURED URGENCY ANALYSIS
;; ============================================================================

(define (analyze-manufactured-urgency claim)
  "Analyze whether urgency was manufactured through coordinated actions"
  (let* ((self-created-analysis (detect-self-created-urgency claim))
         (self-created-score (cdr (assoc 'self-created-score self-created-analysis)))
         (delay-analysis (analyze-delay-explanation claim))
         (delay-impact (cdr (assoc 'delay-impact delay-analysis)))
         (manufactured-score (* self-created-score delay-impact)))
    (list
      (cons 'self-created-score self-created-score)
      (cons 'delay-impact delay-impact)
      (cons 'manufactured-score manufactured-score)
      (cons 'manufactured-determination (cond
                                          ((> manufactured-score 0.8) 'clearly-manufactured)
                                          ((> manufactured-score 0.6) 'likely-manufactured)
                                          ((> manufactured-score 0.4) 'possibly-manufactured)
                                          (else 'not-manufactured))))))

;; ============================================================================
;; BALANCE OF CONVENIENCE EVALUATION
;; ============================================================================

(define (evaluate-balance-of-convenience claim)
  "Evaluate balance of convenience between applicant and respondent"
  (let* ((balance (urgency-claim-balance claim))
         (applicant-harm-score (calculate-harm-score
                                 (balance-applicant-harm-severity balance)
                                 (balance-applicant-harm-reversibility balance)))
         (respondent-harm-score (calculate-harm-score
                                  (balance-respondent-harm-severity balance)
                                  (balance-respondent-harm-reversibility balance)))
         (public-interest-factor (balance-public-interest balance))
         (balance-score (calculate-balance-score applicant-harm-score respondent-harm-score public-interest-factor)))
    (list
      (cons 'applicant-harm (balance-applicant-harm balance))
      (cons 'respondent-harm (balance-respondent-harm balance))
      (cons 'applicant-harm-score applicant-harm-score)
      (cons 'respondent-harm-score respondent-harm-score)
      (cons 'public-interest-factor public-interest-factor)
      (cons 'balance-score balance-score)
      (cons 'balance-determination (cond
                                     ((> balance-score 0.7) 'strongly-favors-applicant)
                                     ((> balance-score 0.55) 'favors-applicant)
                                     ((> balance-score 0.45) 'neutral)
                                     ((> balance-score 0.3) 'favors-respondent)
                                     (else 'strongly-favors-respondent))))))

(define (calculate-harm-score severity reversibility)
  "Calculate harm score based on severity and reversibility"
  (* severity (- 1.0 reversibility)))

(define (calculate-balance-score applicant-harm respondent-harm public-interest)
  "Calculate overall balance of convenience score (>0.5 favors applicant)"
  (let* ((harm-ratio (if (= (+ applicant-harm respondent-harm) 0) 0.5
                         (/ applicant-harm (+ applicant-harm respondent-harm))))
         (public-interest-adjustment (* public-interest 0.2))
         (balance-score (+ (* harm-ratio 0.8) public-interest-adjustment)))
    balance-score))

;; ============================================================================
;; URGENCY SCORE CALCULATION
;; ============================================================================

(define (calculate-urgency-score claim justification-analysis delay-analysis self-created-analysis)
  "Calculate overall urgency score"
  (let* ((justification-strength (cdr (assoc 'justification-strength justification-analysis)))
         (delay-impact (cdr (assoc 'delay-impact delay-analysis)))
         (self-created-score (cdr (assoc 'self-created-score self-created-analysis)))
         ;; Urgency score: high justification + low delay impact + low self-created = high urgency
         (urgency-score (* justification-strength
                           (- 1.0 delay-impact)
                           (- 1.0 self-created-score))))
    urgency-score))

(define (determine-urgency-outcome urgency-score)
  "Determine urgency outcome based on urgency score"
  (cond
    ((> urgency-score 0.8) 'urgent-matter)
    ((> urgency-score 0.6) 'moderately-urgent)
    ((> urgency-score 0.4) 'questionable-urgency)
    (else 'not-urgent)))

;; ============================================================================
;; CONFIDENCE SCORE CALCULATION
;; ============================================================================

(define (calculate-urgency-confidence claim)
  "Calculate confidence in urgency assessment based on evidence strength"
  (let* ((evidence-strength (urgency-claim-evidence-strength claim))
         (confidence-level (cond
                             ((> evidence-strength 0.9) 'very-high)
                             ((> evidence-strength 0.7) 'high)
                             ((> evidence-strength 0.5) 'moderate)
                             (else 'low))))
    (list
      (cons 'evidence-strength evidence-strength)
      (cons 'confidence-level confidence-level))))

;; ============================================================================
;; CASE-SPECIFIC: PARA 11.11.5 URGENCY CLAIM
;; ============================================================================

;; Define self-created urgency factors for Peter's interdict application
(define peter-self-created-urgency-factors-para-11-11-5
  (list
    (make-self-created-urgency-factor
      'whistleblower-retaliation
      "Peter retaliated against Daniel's fraud report, creating urgency through own actions"
      "Filed interdict 2 months after Daniel's fraud report"
      'causal-relationship
      0.95) ; Very strong causation
    (make-self-created-urgency-factor
      'coordinated-sabotage
      "Peter coordinated with Rynette to cancel cards, manufacturing crisis"
      "Interdict filing synchronized with card cancellation (1 day apart)"
      'temporal-synchronization
      0.92) ; Very strong causation
    (make-self-created-urgency-factor
      'trust-power-bypass
      "Peter bypassed absolute trust powers to create urgency"
      "Filed interdict instead of using trustee powers"
      'alternative-remedy-available
      0.88))) ; Strong causation

;; Define balance of convenience for PARA 11.11.5
(define para-11-11-5-balance-of-convenience
  (make-balance-of-convenience
    '(alleged-financial-loss) ; Peter's claimed harm
    '(operational-disruption regulatory-non-compliance business-destruction) ; Daniel/Jax harm
    0.6  ; Peter's harm severity (moderate - financial claims disputed)
    0.95 ; Daniel/Jax harm severity (very high - business operations threatened)
    0.8  ; Peter's harm reversibility (high - financial claims can be compensated)
    0.2  ; Daniel/Jax harm reversibility (low - business destruction irreversible)
    0.3)) ; Public interest factor (low - private dispute)

;; Define PARA 11.11.5 urgency claim
(define para-11-11-5-urgency-claim
  (make-urgency-claim-internal
    'para-11-11-5-urgency
    "Peter Faucitt"
    "Daniel Faucitt and Jacqueline Faucitt"
    '(alleged-financial-loss operational-disruption)
    "immediate" ; Peter claims immediate urgency
    "Alleged ongoing financial misconduct requiring immediate interdict"
    "substantial-delay" ; 2 months delay from fraud report to interdict filing
    peter-self-created-urgency-factors-para-11-11-5
    para-11-11-5-balance-of-convenience
    0.92)) ; Evidence strength for self-created urgency defense

;; ============================================================================
;; LEGAL PRINCIPLES INTEGRATION
;; ============================================================================

;; Principle: Urgency Test (South African Civil Procedure)
;; An applicant must establish urgency by showing:
;; 1. The matter cannot wait for normal court processes
;; 2. The applicant will suffer irreparable harm if relief is not granted immediately
;; 3. The applicant has not delayed unreasonably in bringing the application
;; 4. The urgency was not self-created by the applicant's own actions

;; Principle: Balance of Convenience (Setlogelo v Setlogelo 1914 AD 221)
;; The court must weigh:
;; 1. The harm to the applicant if the interdict is not granted
;; 2. The harm to the respondent if the interdict is granted
;; 3. The reversibility of harm to each party
;; 4. The public interest considerations

;; Principle: Self-Created Urgency (Luna Meubel Vervaardigers (Edms) Bpk v Makin 1977 (4) SA 135 (W))
;; Urgency that is self-created by the applicant's own actions or inaction will not be recognized
;; The applicant cannot create urgency through:
;; 1. Deliberate delay in bringing the application
;; 2. Actions that precipitate the crisis
;; 3. Failure to use alternative remedies

;; ============================================================================
;; EXPORT FUNCTIONS
;; ============================================================================

;; Export case-specific urgency claim for PARA 11.11.5
(define (get-para-11-11-5-urgency-claim)
  "Get the PARA 11.11.5 urgency claim for analysis"
  para-11-11-5-urgency-claim)

;; Export analysis function for PARA 11.11.5
(define (analyze-para-11-11-5-urgency)
  "Analyze PARA 11.11.5 urgency claim with comprehensive legal assessment"
  (assess-urgency-test para-11-11-5-urgency-claim))

;; ============================================================================
;; END OF MODULE
;; ============================================================================
