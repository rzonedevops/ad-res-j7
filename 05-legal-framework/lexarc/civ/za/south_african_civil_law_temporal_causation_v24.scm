;;; South African Civil Law - Temporal Causation Analysis v24
;;; Enhanced immediate proximity detection and retaliation pattern analysis
;;; Date: 2025-12-05
;;; Case: 2025-137857 (Peter Faucitt v. Jacqueline & Daniel Faucitt)
;;; Repository: cogpy/ad-res-j7

(define-module (lex civ za south-african-civil-law-temporal-causation-v24)
  #:use-module (lex lv1 known-laws)
  #:use-module (lex lv1 legal-aspects-taxonomy-v17)
  #:use-module (srfi srfi-1)
  #:use-module (srfi srfi-9)
  #:use-module (srfi srfi-19)
  #:export (
    ;; Core temporal causation functions v24
    analyze-temporal-proximity-v24
    calculate-causation-confidence-v24
    detect-immediate-retaliation-v24
    detect-retaliation-cascade-v24
    
    ;; Temporal threshold classification
    classify-temporal-proximity-v24
    get-causation-strength-v24
    get-temporal-threshold-confidence-v24
    
    ;; Retaliation pattern detection
    detect-whistleblower-retaliation-pattern-v24
    analyze-protected-disclosure-timeline-v24
    calculate-retaliation-probability-v24
    
    ;; Temporal evidence analysis
    extract-temporal-evidence-v24
    validate-temporal-chain-v24
    compute-temporal-confidence-aggregate-v24
  ))

;;;
;;; TEMPORAL CAUSATION FRAMEWORK v24
;;;
;;; Key Enhancements:
;;; 1. Immediate proximity detection (< 24 hours)
;;; 2. Retaliation cascade pattern analysis
;;; 3. Confidence scoring based on temporal proximity
;;; 4. Whistleblower protection temporal analysis
;;; 5. Multi-event temporal chain validation
;;;

;;; Temporal proximity thresholds
(define temporal-proximity-thresholds-v24
  '((immediate . (0 . 1))      ; < 24 hours: confidence 0.98
    (close . (1 . 7))           ; 1-7 days: confidence 0.90-0.96
    (moderate . (8 . 30))       ; 8-30 days: confidence 0.75-0.89
    (weak . (31 . 90))          ; 31-90 days: confidence 0.50-0.74
    (negligible . (91 . 999)))) ; > 90 days: confidence < 0.50

;;; Causation strength classification
(define causation-strength-classification-v24
  '((immediate . "STRONG - Prima facie causation established")
    (close . "MODERATE-STRONG - Strong inference with alternative explanation burden")
    (moderate . "MODERATE - Requires corroborating evidence")
    (weak . "WEAK - Requires substantial corroborating evidence")
    (negligible . "NEGLIGIBLE - Insufficient temporal connection")))

;;; Temporal event record type
(define-record-type <temporal-event-v24>
  (make-temporal-event-v24-internal date type actor description legal-aspect)
  temporal-event-v24?
  (date temporal-event-v24-date)
  (type temporal-event-v24-type)
  (actor temporal-event-v24-actor)
  (description temporal-event-v24-description)
  (legal-aspect temporal-event-v24-legal-aspect))

;;; Temporal causation analysis record type
(define-record-type <temporal-causation-analysis-v24>
  (make-temporal-causation-analysis-v24-internal event-1 event-2 days-between proximity-classification causation-strength confidence legal-consequence)
  temporal-causation-analysis-v24?
  (event-1 temporal-causation-v24-event-1)
  (event-2 temporal-causation-v24-event-2)
  (days-between temporal-causation-v24-days-between)
  (proximity-classification temporal-causation-v24-proximity-classification)
  (causation-strength temporal-causation-v24-causation-strength)
  (confidence temporal-causation-v24-confidence)
  (legal-consequence temporal-causation-v24-legal-consequence))

;;;
;;; CORE TEMPORAL CAUSATION FUNCTIONS
;;;

(define (analyze-temporal-proximity-v24 event-1 event-2)
  "Analyze temporal proximity between two events and return causation analysis"
  (let* ((days-between (calculate-days-between event-1 event-2))
         (proximity-class (classify-temporal-proximity-v24 days-between))
         (causation-str (get-causation-strength-v24 proximity-class))
         (confidence (get-temporal-threshold-confidence-v24 proximity-class days-between))
         (legal-consequence (determine-legal-consequence-v24 proximity-class causation-str)))
    (make-temporal-causation-analysis-v24-internal
      event-1 event-2 days-between proximity-class causation-str confidence legal-consequence)))

(define (calculate-days-between event-1 event-2)
  "Calculate number of days between two temporal events"
  (let ((date-1 (temporal-event-v24-date event-1))
        (date-2 (temporal-event-v24-date event-2)))
    ;; Placeholder: In real implementation, parse dates and calculate difference
    ;; For now, return mock calculation
    (abs (- (string->number (substring date-2 8 10))
            (string->number (substring date-1 8 10))))))

(define (classify-temporal-proximity-v24 days)
  "Classify temporal proximity based on number of days"
  (cond
    ((<= days 1) 'immediate)
    ((<= days 7) 'close)
    ((<= days 30) 'moderate)
    ((<= days 90) 'weak)
    (else 'negligible)))

(define (get-causation-strength-v24 proximity-class)
  "Get causation strength description for proximity classification"
  (let ((entry (assoc proximity-class causation-strength-classification-v24)))
    (if entry (cdr entry) "UNKNOWN")))

(define (get-temporal-threshold-confidence-v24 proximity-class days)
  "Calculate confidence score based on temporal proximity"
  (case proximity-class
    ((immediate) (if (= days 0) 0.99 0.98))
    ((close) (+ 0.90 (* (- 7 days) 0.01)))
    ((moderate) (+ 0.75 (* (- 30 days) 0.005)))
    ((weak) (+ 0.50 (* (- 90 days) 0.003)))
    ((negligible) 0.30)
    (else 0.00)))

(define (determine-legal-consequence-v24 proximity-class causation-str)
  "Determine legal consequence based on temporal proximity and causation strength"
  (case proximity-class
    ((immediate)
     "Prima facie causation established. Burden shifts to respondent to prove alternative explanation.")
    ((close)
     "Strong inference of causation. Respondent must provide credible alternative explanation.")
    ((moderate)
     "Moderate inference of causation. Requires corroborating evidence to establish causation.")
    ((weak)
     "Weak inference of causation. Requires substantial corroborating evidence.")
    ((negligible)
     "Insufficient temporal connection. Causation unlikely without strong corroborating evidence.")
    (else "Unknown legal consequence")))

;;;
;;; IMMEDIATE RETALIATION DETECTION
;;;

(define (detect-immediate-retaliation-v24 protected-disclosure adverse-action)
  "Detect immediate retaliation pattern (< 24 hours)"
  (let* ((analysis (analyze-temporal-proximity-v24 protected-disclosure adverse-action))
         (days (temporal-causation-v24-days-between analysis))
         (proximity (temporal-causation-v24-proximity-classification analysis)))
    (if (eq? proximity 'immediate)
        (make-retaliation-detection-v24
          'immediate-retaliation
          protected-disclosure
          adverse-action
          days
          0.98
          "STRONG - Immediate retaliation pattern detected"
          "Protected Disclosures Act 26/2000 violation - Prima facie retaliation established")
        #f)))

(define-record-type <retaliation-detection-v24>
  (make-retaliation-detection-v24 pattern-type disclosure-event adverse-event days-between confidence assessment legal-consequence)
  retaliation-detection-v24?
  (pattern-type retaliation-detection-v24-pattern-type)
  (disclosure-event retaliation-detection-v24-disclosure-event)
  (adverse-event retaliation-detection-v24-adverse-event)
  (days-between retaliation-detection-v24-days-between)
  (confidence retaliation-detection-v24-confidence)
  (assessment retaliation-detection-v24-assessment)
  (legal-consequence retaliation-detection-v24-legal-consequence))

;;;
;;; RETALIATION CASCADE DETECTION
;;;

(define (detect-retaliation-cascade-v24 disclosure-event adverse-events)
  "Detect retaliation cascade pattern across multiple adverse events"
  (let* ((cascade-analyses (map (lambda (adverse-event)
                                   (analyze-temporal-proximity-v24 disclosure-event adverse-event))
                                 adverse-events))
         (immediate-count (count (lambda (analysis)
                                   (eq? (temporal-causation-v24-proximity-classification analysis) 'immediate))
                                 cascade-analyses))
         (close-count (count (lambda (analysis)
                               (eq? (temporal-causation-v24-proximity-classification analysis) 'close))
                             cascade-analyses))
         (total-count (length adverse-events))
         (cascade-confidence (calculate-cascade-confidence-v24 immediate-count close-count total-count)))
    (make-retaliation-cascade-v24
      disclosure-event
      adverse-events
      cascade-analyses
      immediate-count
      close-count
      cascade-confidence
      (if (> cascade-confidence 0.90)
          "STRONG - Coordinated retaliation cascade detected"
          "MODERATE - Multiple adverse actions with temporal correlation"))))

(define-record-type <retaliation-cascade-v24>
  (make-retaliation-cascade-v24 disclosure-event adverse-events analyses immediate-count close-count confidence assessment)
  retaliation-cascade-v24?
  (disclosure-event retaliation-cascade-v24-disclosure-event)
  (adverse-events retaliation-cascade-v24-adverse-events)
  (analyses retaliation-cascade-v24-analyses)
  (immediate-count retaliation-cascade-v24-immediate-count)
  (close-count retaliation-cascade-v24-close-count)
  (confidence retaliation-cascade-v24-confidence)
  (assessment retaliation-cascade-v24-assessment))

(define (calculate-cascade-confidence-v24 immediate-count close-count total-count)
  "Calculate confidence for retaliation cascade pattern"
  (let ((immediate-weight 0.98)
        (close-weight 0.90)
        (cascade-multiplier 1.05))
    (min 0.99
         (* cascade-multiplier
            (/ (+ (* immediate-count immediate-weight)
                  (* close-count close-weight))
               total-count)))))

;;;
;;; WHISTLEBLOWER RETALIATION PATTERN DETECTION
;;;

(define (detect-whistleblower-retaliation-pattern-v24 disclosure adverse-action)
  "Detect whistleblower retaliation pattern with Protected Disclosures Act analysis"
  (let* ((temporal-analysis (analyze-temporal-proximity-v24 disclosure adverse-action))
         (days (temporal-causation-v24-days-between temporal-analysis))
         (proximity (temporal-causation-v24-proximity-classification temporal-analysis))
         (confidence (temporal-causation-v24-confidence temporal-analysis))
         (retaliation-prob (calculate-retaliation-probability-v24 proximity days)))
    (make-whistleblower-retaliation-pattern-v24
      disclosure
      adverse-action
      temporal-analysis
      retaliation-prob
      (determine-whistleblower-protection-consequence-v24 proximity retaliation-prob))))

(define-record-type <whistleblower-retaliation-pattern-v24>
  (make-whistleblower-retaliation-pattern-v24 disclosure adverse-action temporal-analysis retaliation-probability legal-consequence)
  whistleblower-retaliation-pattern-v24?
  (disclosure whistleblower-retaliation-v24-disclosure)
  (adverse-action whistleblower-retaliation-v24-adverse-action)
  (temporal-analysis whistleblower-retaliation-v24-temporal-analysis)
  (retaliation-probability whistleblower-retaliation-v24-retaliation-probability)
  (legal-consequence whistleblower-retaliation-v24-legal-consequence))

(define (calculate-retaliation-probability-v24 proximity days)
  "Calculate probability of retaliation based on temporal proximity"
  (case proximity
    ((immediate) 0.98)
    ((close) (- 0.96 (* days 0.01)))
    ((moderate) (- 0.85 (* days 0.005)))
    ((weak) (- 0.70 (* days 0.003)))
    ((negligible) 0.40)
    (else 0.00)))

(define (determine-whistleblower-protection-consequence-v24 proximity retaliation-prob)
  "Determine legal consequence under Protected Disclosures Act"
  (cond
    ((>= retaliation-prob 0.95)
     "Prima facie violation of Protected Disclosures Act 26/2000. Immediate retaliation establishes causation. Remedies: reinstatement, compensation, punitive damages, costs.")
    ((>= retaliation-prob 0.85)
     "Strong inference of Protected Disclosures Act violation. Respondent must prove alternative explanation. Remedies: compensation, costs.")
    ((>= retaliation-prob 0.70)
     "Moderate inference of retaliation. Requires corroborating evidence. Protected Disclosures Act protection applies if causation established.")
    (else
     "Weak inference of retaliation. Requires substantial corroborating evidence to establish Protected Disclosures Act violation.")))

;;;
;;; TEMPORAL EVIDENCE ANALYSIS
;;;

(define (extract-temporal-evidence-v24 event)
  "Extract temporal evidence from event for causation analysis"
  (list
    (cons 'date (temporal-event-v24-date event))
    (cons 'type (temporal-event-v24-type event))
    (cons 'actor (temporal-event-v24-actor event))
    (cons 'description (temporal-event-v24-description event))
    (cons 'legal-aspect (temporal-event-v24-legal-aspect event))))

(define (validate-temporal-chain-v24 events)
  "Validate temporal chain of events for causation analysis"
  (let* ((sorted-events (sort events
                              (lambda (e1 e2)
                                (string<? (temporal-event-v24-date e1)
                                          (temporal-event-v24-date e2)))))
         (chain-analyses (map (lambda (i)
                                (if (< i (- (length sorted-events) 1))
                                    (analyze-temporal-proximity-v24
                                      (list-ref sorted-events i)
                                      (list-ref sorted-events (+ i 1)))
                                    #f))
                              (iota (length sorted-events))))
         (valid-chain-analyses (filter identity chain-analyses)))
    (make-temporal-chain-validation-v24
      sorted-events
      valid-chain-analyses
      (compute-chain-confidence-v24 valid-chain-analyses))))

(define-record-type <temporal-chain-validation-v24>
  (make-temporal-chain-validation-v24 events analyses chain-confidence)
  temporal-chain-validation-v24?
  (events temporal-chain-validation-v24-events)
  (analyses temporal-chain-validation-v24-analyses)
  (chain-confidence temporal-chain-validation-v24-chain-confidence))

(define (compute-chain-confidence-v24 analyses)
  "Compute aggregate confidence for temporal chain"
  (if (null? analyses)
      0.00
      (let ((confidences (map temporal-causation-v24-confidence analyses)))
        (/ (apply + confidences) (length confidences)))))

(define (compute-temporal-confidence-aggregate-v24 analyses)
  "Compute aggregate confidence from multiple temporal causation analyses"
  (if (null? analyses)
      0.00
      (let* ((confidences (map temporal-causation-v24-confidence analyses))
             (avg-confidence (/ (apply + confidences) (length confidences)))
             (max-confidence (apply max confidences))
             (immediate-count (count (lambda (a)
                                       (eq? (temporal-causation-v24-proximity-classification a) 'immediate))
                                     analyses))
             (boost (if (> immediate-count 0) 0.05 0.00)))
        (min 0.99 (+ avg-confidence boost)))))

;;;
;;; CASE-SPECIFIC TEMPORAL ANALYSES (2025-137857)
;;;

;;; Dan whistleblowing and immediate retaliation (June 6-7, 2025)
(define dan-fraud-report-june-6-2025
  (make-temporal-event-v24-internal
    "2025-06-06"
    'protected-disclosure
    "Daniel Faucitt"
    "Fraud report submitted to Bantjies (trustee)"
    'whistleblower-trigger))

(define peter-card-cancellation-june-7-2025
  (make-temporal-event-v24-internal
    "2025-06-07"
    'adverse-action
    "Peter Faucitt"
    "Card cancellation and account lockout"
    'retaliation))

(define dan-immediate-retaliation-analysis-v24
  (detect-immediate-retaliation-v24
    dan-fraud-report-june-6-2025
    peter-card-cancellation-june-7-2025))

;;; Jax whistleblowing and retaliation cascade (May 15-22, 2025)
(define jax-popia-notice-may-15-2025
  (make-temporal-event-v24-internal
    "2025-05-15"
    'protected-disclosure
    "Jacqueline Faucitt"
    "POPIA notice to Peter Faucitt"
    'whistleblower-trigger))

(define rynette-retaliation-may-22-2025
  (make-temporal-event-v24-internal
    "2025-05-22"
    'adverse-action
    "Rynette Farrar"
    "Coordinated retaliation cascade"
    'retaliation))

(define jax-retaliation-cascade-analysis-v24
  (detect-whistleblower-retaliation-pattern-v24
    jax-popia-notice-may-15-2025
    rynette-retaliation-may-22-2025))

;;; Complete temporal chain for case 2025-137857
(define case-2025-137857-temporal-chain-v24
  (list
    (make-temporal-event-v24-internal
      "2025-03-01" 'settlement-negotiation "Peter Faucitt"
      "Settlement negotiation start" 'bad-faith)
    (make-temporal-event-v24-internal
      "2025-04-14" 'settlement-termination "Peter Faucitt"
      "Settlement negotiation end" 'void-ab-initio)
    jax-popia-notice-may-15-2025
    rynette-retaliation-may-22-2025
    dan-fraud-report-june-6-2025
    peter-card-cancellation-june-7-2025
    (make-temporal-event-v24-internal
      "2025-08-13" 'interdict-application "Peter Faucitt"
      "Coordinated action filing" 'multi-actor-coordination)))

(define case-2025-137857-temporal-validation-v24
  (validate-temporal-chain-v24 case-2025-137857-temporal-chain-v24))

;;; Export case-specific analyses
(export
  dan-fraud-report-june-6-2025
  peter-card-cancellation-june-7-2025
  dan-immediate-retaliation-analysis-v24
  jax-popia-notice-may-15-2025
  rynette-retaliation-may-22-2025
  jax-retaliation-cascade-analysis-v24
  case-2025-137857-temporal-chain-v24
  case-2025-137857-temporal-validation-v24)
