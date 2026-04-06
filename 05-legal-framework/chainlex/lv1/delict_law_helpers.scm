;; =============================================================================
;; DELICT (TORT) LAW HELPER FUNCTIONS
;; =============================================================================
;; Version: 1.0
;; Description: Helper functions for delict/tort law reasoning
;; Derived from Level 1 principles: neminem-laedere, culpa, damnum-iniuria-datum
;; =============================================================================

(define-module (chainlex delict-law-helpers)
  #:use-module (chainlex core-utilities)
  #:export (
    ;; Elements of delict
    act-or-omission?
    contra-boni-mores?
    infringement-of-right?
    breach-of-legal-duty?
    
    ;; Fault
    duty-of-care?
    breach-of-duty?
    reasonable-person-standard?
    
    ;; Causation
    but-for-test?
    reasonable-foreseeability?
    novus-actus-interveniens?
    
    ;; Defenses
    consent-defense?
    necessity-defense?
    self-defense?
    
    ;; Damages
    patrimonial-loss?
    non-patrimonial-loss?
    
    ;; Specific torts
    defamation?
    privacy-invasion?
    negligent-misstatement?
  ))

;; =============================================================================
;; ELEMENTS OF DELICT
;; =============================================================================

(define (act-or-omission? claim)
  "Check if there was an act or omission (conduct)"
  (or (has-attribute claim 'act)
      (and (has-attribute claim 'omission)
           (has-attribute claim 'legal-duty-to-act))))

(define (contra-boni-mores? act)
  "Check if act is contra boni mores (against good morals)"
  (let ((act-type (get-attribute act 'type 'unknown))
        (societal-values (get-attribute act 'violates-societal-values #f)))
    (or societal-values
        (member-of? act-type '(fraud deceit malice intentional-harm)))))

(define (infringement-of-right? act)
  "Check if act infringes a legally protected right"
  (let ((rights-infringed (get-attribute act 'rights-infringed '())))
    (and (not (null? rights-infringed))
         (any-true?
           (map (lambda (right)
                  (member-of? right '(life bodily-integrity dignity property privacy reputation)))
                rights-infringed)))))

(define (breach-of-legal-duty? act)
  "Check if act breaches a legal duty"
  (let ((duty-breached (get-attribute act 'duty-breached #f))
        (statutory-duty (get-attribute act 'statutory-duty #f))
        (common-law-duty (get-attribute act 'common-law-duty #f)))
    (or duty-breached statutory-duty common-law-duty)))

;; =============================================================================
;; FAULT (NEGLIGENCE)
;; =============================================================================

(define (duty-of-care? defendant)
  "Check if defendant owed duty of care (derived from neminem-laedere)"
  (let ((relationship (get-attribute defendant 'relationship-to-plaintiff 'unknown))
        (foreseeability (get-attribute defendant 'harm-foreseeable #f))
        (proximity (get-attribute defendant 'proximity-to-plaintiff #f)))
    (or 
      ;; Special relationship creates duty
      (member-of? relationship '(doctor-patient employer-employee manufacturer-consumer))
      ;; General duty based on foreseeability and proximity
      (and foreseeability proximity))))

(define (breach-of-duty? defendant)
  "Check if defendant breached duty of care"
  (let ((standard-of-care (get-attribute defendant 'standard-of-care 'reasonable-person))
        (conduct (get-attribute defendant 'conduct 'unknown))
        (failed-to-meet-standard (get-attribute defendant 'failed-standard #f)))
    (or failed-to-meet-standard
        (not (reasonable-person-standard? defendant)))))

(define (reasonable-person-standard? defendant)
  "Check if defendant met reasonable person standard"
  (let ((conduct (get-attribute defendant 'conduct 'unknown))
        (precautions-taken (get-attribute defendant 'precautions '()))
        (risk-level (get-attribute defendant 'risk-level 'low))
        (cost-of-precautions (get-attribute defendant 'cost-of-precautions 0)))
    (cond
      ;; High risk requires high precautions
      ((equal? risk-level 'high)
       (>= (length precautions-taken) 3))
      ;; Medium risk requires moderate precautions
      ((equal? risk-level 'medium)
       (>= (length precautions-taken) 2))
      ;; Low risk requires basic precautions
      ((equal? risk-level 'low)
       (>= (length precautions-taken) 1))
      (else #f))))

;; =============================================================================
;; CAUSATION
;; =============================================================================

(define (but-for-test? act damage)
  "Apply but-for test for factual causation"
  ;; But for the act, would the damage have occurred?
  (let ((damage-without-act (get-attribute damage 'would-occur-without-act #f)))
    (not damage-without-act)))

(define (reasonable-foreseeability? act damage)
  "Check if damage was reasonably foreseeable (legal causation)"
  (let ((damage-type (get-attribute damage 'type 'unknown))
        (act-type (get-attribute act 'type 'unknown))
        (foreseeable (get-attribute damage 'foreseeable #f)))
    (or foreseeable
        ;; Certain act-damage combinations are inherently foreseeable
        (and (equal? act-type 'speeding)
             (member-of? damage-type '(collision injury death)))
        (and (equal? act-type 'medical-negligence)
             (member-of? damage-type '(injury death complications))))))

(define (novus-actus-interveniens? intervening-act original-act damage)
  "Check if intervening act breaks chain of causation"
  (let ((intervening-foreseeable (get-attribute intervening-act 'foreseeable #f))
        (intervening-independent (get-attribute intervening-act 'independent #f)))
    ;; Breaks chain if unforeseeable and independent
    (and (not intervening-foreseeable)
         intervening-independent)))

;; =============================================================================
;; DEFENSES
;; =============================================================================

(define (consent-defense? plaintiff act)
  "Check if plaintiff consented (volenti non fit iniuria)"
  (let ((express-consent (get-attribute plaintiff 'express-consent #f))
        (implied-consent (get-attribute plaintiff 'implied-consent #f))
        (knew-risks (get-attribute plaintiff 'knew-risks #f))
        (voluntarily-assumed (get-attribute plaintiff 'voluntarily-assumed-risk #f)))
    (or express-consent
        (and implied-consent knew-risks voluntarily-assumed))))

(define (necessity-defense? defendant act)
  "Check if act was necessary to prevent greater harm"
  (let ((harm-prevented (get-attribute act 'harm-prevented 0))
        (harm-caused (get-attribute act 'harm-caused 0))
        (no-alternative (get-attribute act 'no-reasonable-alternative #f)))
    (and (> harm-prevented harm-caused)
         no-alternative)))

(define (self-defense? defendant act)
  "Check if act was in self-defense"
  (let ((attack-imminent (get-attribute act 'attack-imminent #f))
        (force-proportionate (get-attribute act 'force-proportionate #f))
        (no-retreat-required (get-attribute act 'retreat-not-required #t)))
    (and attack-imminent force-proportionate)))

;; =============================================================================
;; DAMAGES
;; =============================================================================

(define (patrimonial-loss? damage)
  "Check if damage is patrimonial (economic)"
  (let ((damage-type (get-attribute damage 'type 'unknown)))
    (member-of? damage-type '(property-damage lost-income medical-expenses lost-profits))))

(define (non-patrimonial-loss? damage)
  "Check if damage is non-patrimonial (pain, suffering, dignity)"
  (let ((damage-type (get-attribute damage 'type 'unknown)))
    (member-of? damage-type '(pain-suffering emotional-distress loss-of-amenities dignity-harm))))

;; =============================================================================
;; SPECIFIC TORTS/DELICTS
;; =============================================================================

(define (defamation? statement)
  "Check if statement constitutes defamation"
  (and 
    ;; Statement was made
    (has-attribute statement 'content)
    ;; Statement was published to third party
    (get-attribute statement 'published #f)
    ;; Statement refers to plaintiff
    (has-attribute statement 'refers-to)
    ;; Statement is defamatory (lowers reputation)
    (get-attribute statement 'defamatory #f)
    ;; Statement is false (truth is defense)
    (not (get-attribute statement 'true #f))))

(define (privacy-invasion? act)
  "Check if act invades privacy"
  (let ((privacy-type (get-attribute act 'privacy-type 'unknown))
        (reasonable-expectation (get-attribute act 'reasonable-expectation-of-privacy #f)))
    (and reasonable-expectation
         (member-of? privacy-type '(intrusion disclosure private-facts false-light appropriation)))))

(define (negligent-misstatement? statement reliance)
  "Check if negligent misstatement occurred"
  (and 
    ;; Statement was made
    (has-attribute statement 'content)
    ;; Statement was false
    (get-attribute statement 'false #f)
    ;; Maker owed duty of care
    (get-attribute statement 'duty-of-care #f)
    ;; Statement was negligent
    (get-attribute statement 'negligent #f)
    ;; Plaintiff relied on statement
    (get-attribute reliance 'reasonable #f)
    ;; Plaintiff suffered loss
    (has-attribute reliance 'loss)))

;; =============================================================================
;; ADDITIONAL DELICT HELPERS
;; =============================================================================

(define (vicarious-liability? employer employee act)
  "Check if employer is vicariously liable for employee's act"
  (and 
    ;; Employment relationship exists
    (get-attribute employee 'employed-by employer)
    ;; Act was in course and scope of employment
    (get-attribute act 'course-of-employment #f)
    ;; Act was for employer's benefit or closely connected
    (or (get-attribute act 'for-employers-benefit #f)
        (get-attribute act 'closely-connected-to-employment #f))))

(define (strict-liability? activity)
  "Check if activity attracts strict liability (no fault required)"
  (let ((activity-type (get-attribute activity 'type 'unknown)))
    (member-of? activity-type '(ultra-hazardous dangerous-animals defective-products nuclear-activity))))

(define (contributory-negligence? plaintiff damage)
  "Check if plaintiff was contributorily negligent"
  (let ((plaintiff-fault (get-attribute plaintiff 'fault-percentage 0)))
    (> plaintiff-fault 0)))

(define (apportionment-of-damages plaintiff-fault defendant-fault total-damages)
  "Calculate apportionment of damages based on fault"
  (let ((total-fault (+ plaintiff-fault defendant-fault)))
    (if (> total-fault 0)
        (* total-damages (/ defendant-fault total-fault))
        total-damages)))

;; =============================================================================
;; END OF DELICT LAW HELPERS
;; =============================================================================

