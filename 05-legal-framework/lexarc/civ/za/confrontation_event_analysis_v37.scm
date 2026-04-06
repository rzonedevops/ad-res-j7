;; confrontation_event_analysis_v37.scm
;; South African Civil Law - Confrontation Event Analysis Framework V37
;; Case: 2025-137857 (Peter Faucitt v. Jacqueline & Daniel Faucitt)
;; Purpose: Analyze confrontation events with provocation defense and witness evidence framework

(define-module (lex civ za confrontation-event-analysis-v37)
  #:use-module (lex lv1 known-laws)
  #:export (
    confrontation-event
    make-confrontation-event
    analyze-confrontation-event
    assess-provocation-defense
    evaluate-witness-credibility
    determine-confrontation-liability
    calculate-confrontation-confidence
    ))

;; ============================================================================
;; RECORD TYPE DEFINITIONS
;; ============================================================================

;; Confrontation Event Record
(define-record-type <confrontation-event>
  (make-confrontation-event-internal
    event-id
    date
    location
    parties
    initiator
    respondent
    alleged-actions
    witness-accounts
    physical-contact
    verbal-exchange
    provocation-factors
    self-defense-claim
    evidence-strength)
  confrontation-event?
  (event-id confrontation-event-id)
  (date confrontation-event-date)
  (location confrontation-event-location)
  (parties confrontation-event-parties)
  (initiator confrontation-event-initiator)
  (respondent confrontation-event-respondent)
  (alleged-actions confrontation-event-alleged-actions)
  (witness-accounts confrontation-event-witness-accounts)
  (physical-contact confrontation-event-physical-contact)
  (verbal-exchange confrontation-event-verbal-exchange)
  (provocation-factors confrontation-event-provocation-factors)
  (self-defense-claim confrontation-event-self-defense-claim)
  (evidence-strength confrontation-event-evidence-strength))

;; Witness Account Record
(define-record-type <witness-account>
  (make-witness-account
    witness-name
    witness-relationship
    account-description
    credibility-score
    consistency-score
    corroboration-evidence)
  witness-account?
  (witness-name witness-account-name)
  (witness-relationship witness-account-relationship)
  (account-description witness-account-description)
  (credibility-score witness-account-credibility)
  (consistency-score witness-account-consistency)
  (corroboration-evidence witness-account-corroboration))

;; Provocation Factor Record
(define-record-type <provocation-factor>
  (make-provocation-factor
    factor-type
    description
    severity-score
    temporal-proximity
    causal-nexus)
  provocation-factor?
  (factor-type provocation-factor-type)
  (description provocation-factor-description)
  (severity-score provocation-factor-severity)
  (temporal-proximity provocation-factor-temporal-proximity)
  (causal-nexus provocation-factor-causal-nexus))

;; ============================================================================
;; CONFRONTATION EVENT ANALYSIS
;; ============================================================================

(define (analyze-confrontation-event event)
  "Comprehensive analysis of confrontation event with legal assessment"
  (let* ((initiator-analysis (analyze-initiator-role event))
         (respondent-analysis (analyze-respondent-role event))
         (provocation-assessment (assess-provocation-defense event))
         (witness-credibility (evaluate-witness-credibility event))
         (liability-determination (determine-confrontation-liability event))
         (confidence-score (calculate-confrontation-confidence event)))
    (list
      (cons 'event-id (confrontation-event-id event))
      (cons 'initiator-analysis initiator-analysis)
      (cons 'respondent-analysis respondent-analysis)
      (cons 'provocation-assessment provocation-assessment)
      (cons 'witness-credibility witness-credibility)
      (cons 'liability-determination liability-determination)
      (cons 'confidence-score confidence-score))))

;; ============================================================================
;; INITIATOR ROLE ANALYSIS
;; ============================================================================

(define (analyze-initiator-role event)
  "Analyze the role of the initiator in the confrontation"
  (let* ((initiator (confrontation-event-initiator event))
         (alleged-actions (confrontation-event-alleged-actions event))
         (physical-contact (confrontation-event-physical-contact event))
         (verbal-exchange (confrontation-event-verbal-exchange event))
         (aggression-score (calculate-aggression-score alleged-actions physical-contact verbal-exchange)))
    (list
      (cons 'initiator initiator)
      (cons 'alleged-actions alleged-actions)
      (cons 'physical-contact physical-contact)
      (cons 'verbal-exchange verbal-exchange)
      (cons 'aggression-score aggression-score)
      (cons 'primary-responsibility (if (> aggression-score 0.7) 'high 'moderate)))))

(define (calculate-aggression-score actions physical verbal)
  "Calculate aggression score based on actions, physical contact, and verbal exchange"
  (let* ((action-score (if (member 'physical-aggression actions) 0.8 0.3))
         (physical-score (if physical 0.9 0.0))
         (verbal-score (if (member 'threatening-language verbal) 0.6 0.2))
         (weighted-score (/ (+ (* action-score 0.4) (* physical-score 0.4) (* verbal-score 0.2)) 1.0)))
    weighted-score))

;; ============================================================================
;; RESPONDENT ROLE ANALYSIS
;; ============================================================================

(define (analyze-respondent-role event)
  "Analyze the role of the respondent in the confrontation"
  (let* ((respondent (confrontation-event-respondent event))
         (self-defense-claim (confrontation-event-self-defense-claim event))
         (provocation-factors (confrontation-event-provocation-factors event))
         (response-proportionality (assess-response-proportionality event)))
    (list
      (cons 'respondent respondent)
      (cons 'self-defense-claim self-defense-claim)
      (cons 'provocation-factors (length provocation-factors))
      (cons 'response-proportionality response-proportionality)
      (cons 'defensive-posture (if self-defense-claim 'defensive 'neutral)))))

(define (assess-response-proportionality event)
  "Assess whether respondent's response was proportionate to provocation"
  (let* ((alleged-actions (confrontation-event-alleged-actions event))
         (provocation-factors (confrontation-event-provocation-factors event))
         (provocation-severity (calculate-provocation-severity provocation-factors))
         (response-severity (calculate-response-severity alleged-actions)))
    (cond
      ((< response-severity (* provocation-severity 1.2)) 'proportionate)
      ((< response-severity (* provocation-severity 2.0)) 'moderately-disproportionate)
      (else 'highly-disproportionate))))

(define (calculate-provocation-severity factors)
  "Calculate overall provocation severity from provocation factors"
  (if (null? factors)
      0.0
      (let* ((severity-scores (map provocation-factor-severity factors))
             (average-severity (/ (apply + severity-scores) (length severity-scores))))
        average-severity)))

(define (calculate-response-severity actions)
  "Calculate response severity from alleged actions"
  (cond
    ((member 'physical-violence actions) 0.9)
    ((member 'physical-contact actions) 0.6)
    ((member 'verbal-response actions) 0.3)
    (else 0.1)))

;; ============================================================================
;; PROVOCATION DEFENSE ASSESSMENT
;; ============================================================================

(define (assess-provocation-defense event)
  "Assess the strength of provocation defense based on provocation factors"
  (let* ((provocation-factors (confrontation-event-provocation-factors event))
         (provocation-severity (calculate-provocation-severity provocation-factors))
         (temporal-proximity (assess-temporal-proximity-provocation provocation-factors))
         (causal-nexus (assess-causal-nexus-provocation provocation-factors))
         (defense-strength (* provocation-severity temporal-proximity causal-nexus)))
    (list
      (cons 'provocation-factors-count (length provocation-factors))
      (cons 'provocation-severity provocation-severity)
      (cons 'temporal-proximity temporal-proximity)
      (cons 'causal-nexus causal-nexus)
      (cons 'defense-strength defense-strength)
      (cons 'defense-viability (cond
                                  ((> defense-strength 0.8) 'strong)
                                  ((> defense-strength 0.6) 'moderate)
                                  ((> defense-strength 0.4) 'weak)
                                  (else 'minimal))))))

(define (assess-temporal-proximity-provocation factors)
  "Assess temporal proximity of provocation to confrontation"
  (if (null? factors)
      0.0
      (let* ((temporal-scores (map provocation-factor-temporal-proximity factors))
             (max-temporal (apply max temporal-scores)))
        max-temporal)))

(define (assess-causal-nexus-provocation factors)
  "Assess causal nexus between provocation and response"
  (if (null? factors)
      0.0
      (let* ((causal-scores (map provocation-factor-causal-nexus factors))
             (average-causal (/ (apply + causal-scores) (length causal-scores))))
        average-causal)))

;; ============================================================================
;; WITNESS CREDIBILITY EVALUATION
;; ============================================================================

(define (evaluate-witness-credibility event)
  "Evaluate credibility of witness accounts"
  (let* ((witness-accounts (confrontation-event-witness-accounts event))
         (credibility-scores (map witness-account-credibility witness-accounts))
         (consistency-scores (map witness-account-consistency witness-accounts))
         (average-credibility (if (null? credibility-scores) 0.0
                                  (/ (apply + credibility-scores) (length credibility-scores))))
         (average-consistency (if (null? consistency-scores) 0.0
                                  (/ (apply + consistency-scores) (length consistency-scores))))
         (overall-witness-strength (* average-credibility average-consistency)))
    (list
      (cons 'witness-count (length witness-accounts))
      (cons 'average-credibility average-credibility)
      (cons 'average-consistency average-consistency)
      (cons 'overall-witness-strength overall-witness-strength)
      (cons 'witness-reliability (cond
                                   ((> overall-witness-strength 0.8) 'highly-reliable)
                                   ((> overall-witness-strength 0.6) 'reliable)
                                   ((> overall-witness-strength 0.4) 'moderately-reliable)
                                   (else 'unreliable))))))

;; ============================================================================
;; LIABILITY DETERMINATION
;; ============================================================================

(define (determine-confrontation-liability event)
  "Determine liability for confrontation based on comprehensive analysis"
  (let* ((initiator-analysis (analyze-initiator-role event))
         (respondent-analysis (analyze-respondent-role event))
         (provocation-assessment (assess-provocation-defense event))
         (aggression-score (cdr (assoc 'aggression-score initiator-analysis)))
         (response-proportionality (cdr (assoc 'response-proportionality respondent-analysis)))
         (defense-strength (cdr (assoc 'defense-strength provocation-assessment)))
         (liability-score (calculate-liability-score aggression-score response-proportionality defense-strength)))
    (list
      (cons 'initiator-liability (if (> aggression-score 0.7) 'high 'moderate))
      (cons 'respondent-liability (cond
                                    ((eq? response-proportionality 'proportionate) 'minimal)
                                    ((eq? response-proportionality 'moderately-disproportionate) 'moderate)
                                    (else 'high)))
      (cons 'primary-liability (if (> liability-score 0.5) 'initiator 'respondent))
      (cons 'liability-score liability-score))))

(define (calculate-liability-score aggression proportionality defense-strength)
  "Calculate overall liability score (>0.5 = initiator liable, <0.5 = respondent liable)"
  (let* ((aggression-weight 0.4)
         (proportionality-weight 0.3)
         (defense-weight 0.3)
         (proportionality-score (cond
                                  ((eq? proportionality 'proportionate) 0.9)
                                  ((eq? proportionality 'moderately-disproportionate) 0.5)
                                  (else 0.1)))
         (weighted-score (+ (* aggression aggression-weight)
                            (* proportionality-score proportionality-weight)
                            (* defense-strength defense-weight))))
    weighted-score))

;; ============================================================================
;; CONFIDENCE SCORE CALCULATION
;; ============================================================================

(define (calculate-confrontation-confidence event)
  "Calculate overall confidence in confrontation analysis based on evidence strength"
  (let* ((evidence-strength (confrontation-event-evidence-strength event))
         (witness-credibility (evaluate-witness-credibility event))
         (witness-strength (cdr (assoc 'overall-witness-strength witness-credibility)))
         (overall-confidence (* evidence-strength witness-strength)))
    (list
      (cons 'evidence-strength evidence-strength)
      (cons 'witness-strength witness-strength)
      (cons 'overall-confidence overall-confidence)
      (cons 'confidence-level (cond
                                ((> overall-confidence 0.9) 'very-high)
                                ((> overall-confidence 0.7) 'high)
                                ((> overall-confidence 0.5) 'moderate)
                                (else 'low))))))

;; ============================================================================
;; CASE-SPECIFIC: PARA 8.4 CONFRONTATION EVENT
;; ============================================================================

;; Define provocation factors for PARA 8.4 confrontation
(define peter-provocation-factors-para-8-4
  (list
    (make-provocation-factor
      'legal-intimidation
      "Peter filed interdict to intimidate Daniel and Jacqueline"
      0.8  ; High severity
      0.95 ; Very high temporal proximity (confrontation shortly after interdict)
      0.9) ; Strong causal nexus
    (make-provocation-factor
      'operational-sabotage
      "Peter coordinated with Rynette to cancel business cards"
      0.85 ; Very high severity
      0.9  ; High temporal proximity
      0.92) ; Very strong causal nexus
    (make-provocation-factor
      'whistleblower-retaliation
      "Peter retaliated against Daniel for fraud report"
      0.9  ; Very high severity
      0.85 ; High temporal proximity
      0.95))) ; Very strong causal nexus

;; Define witness accounts for PARA 8.4 confrontation
(define daniel-witness-accounts-para-8-4
  (list
    ;; Placeholder for actual witness accounts
    ;; To be populated with real witness statements
    ))

;; Define PARA 8.4 confrontation event
(define para-8-4-confrontation-event
  (make-confrontation-event-internal
    'para-8-4-confrontation
    "2025-08-XX"  ; Date to be specified from evidence
    "Location TBD" ; Location to be specified from evidence
    '("Peter Faucitt" "Daniel Faucitt")
    "Peter Faucitt"  ; Alleged initiator based on provocation pattern
    "Daniel Faucitt"
    '(verbal-response) ; Daniel's alleged actions (to be specified from evidence)
    daniel-witness-accounts-para-8-4
    #f  ; No physical contact (to be confirmed from evidence)
    '(heated-exchange) ; Verbal exchange type
    peter-provocation-factors-para-8-4
    #t  ; Daniel claims self-defense/provocation defense
    0.85)) ; Evidence strength (to be refined based on actual evidence)

;; ============================================================================
;; LEGAL PRINCIPLES INTEGRATION
;; ============================================================================

;; Principle: Provocation Defense (South African Common Law)
;; A person who is provoked may have a defense if:
;; 1. The provocation was sufficient to cause a reasonable person to lose self-control
;; 2. The response was proportionate to the provocation
;; 3. There is a causal nexus between the provocation and the response

;; Principle: Self-Defense (South African Common Law)
;; A person may use reasonable force to defend themselves if:
;; 1. There is an unlawful attack
;; 2. The attack is imminent or in progress
;; 3. The defensive action is necessary
;; 4. The means used are proportionate to the attack

;; Principle: Witness Credibility Assessment
;; Factors affecting witness credibility:
;; 1. Relationship to parties (independent witnesses more credible)
;; 2. Consistency of account (internal and external consistency)
;; 3. Corroboration from other evidence
;; 4. Demeanor and plausibility

;; ============================================================================
;; EXPORT FUNCTIONS
;; ============================================================================

;; Export case-specific confrontation event for PARA 8.4
(define (get-para-8-4-confrontation-event)
  "Get the PARA 8.4 confrontation event for analysis"
  para-8-4-confrontation-event)

;; Export analysis function for PARA 8.4
(define (analyze-para-8-4-confrontation)
  "Analyze PARA 8.4 confrontation event with comprehensive legal assessment"
  (analyze-confrontation-event para-8-4-confrontation-event))

;; ============================================================================
;; END OF MODULE
;; ============================================================================
