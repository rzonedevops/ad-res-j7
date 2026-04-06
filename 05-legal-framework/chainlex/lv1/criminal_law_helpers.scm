;; =============================================================================
;; CRIMINAL LAW HELPER FUNCTIONS
;; =============================================================================
;; Version: 1.0
;; Description: Helper functions for criminal law reasoning
;; Derived from Level 1 principles: nullum-crimen-sine-lege, 
;;                                   actus-non-facit-reum-nisi-mens-sit-rea
;; =============================================================================

(define-module (chainlex criminal-law-helpers)
  #:use-module (chainlex core-utilities)
  #:export (
    ;; Elements of crime
    actus-reus?
    mens-rea?
    causation?
    unlawful?
    
    ;; Actus reus helpers
    voluntary-conduct?
    unlawful-act?
    omission?
    
    ;; Mens rea helpers
    intention?
    dolus-directus?
    dolus-indirectus?
    dolus-eventualis?
    criminal-negligence?
    
    ;; Causation helpers
    factual-causation?
    legal-causation?
    novus-actus-interveniens?
    
    ;; Defenses
    private-defence?
    necessity-defence?
    insanity-defence?
    intoxication-defence?
    mistake-defence?
    duress-defence?
    impossibility-defence?
    consent-defence-criminal?
    
    ;; Specific crimes helpers
    murder-elements?
    theft-elements?
    fraud-elements?
    assault-elements?
  ))

;; =============================================================================
;; ACTUS REUS HELPERS
;; =============================================================================

(define (actus-reus? act)
  "Check if actus reus (guilty act) is present
   Cross-reference: actus-non-facit-reum-nisi-mens-sit-rea (Level 1)"
  (and (voluntary-conduct? act)
       (unlawful-act? act)))

(define (voluntary-conduct? act)
  "Check if conduct was voluntary (not reflexive or under duress)
   Cross-reference: actus-non-facit-reum-nisi-mens-sit-rea (Level 1)"
  (let ((voluntary (get-attribute act 'voluntary #t))
        (reflexive (get-attribute act 'reflexive #f))
        (under-duress (get-attribute act 'under-duress #f))
        (automatism (get-attribute act 'automatism #f)))
    (and voluntary
         (not reflexive)
         (not under-duress)
         (not automatism))))

(define (unlawful-act? act)
  "Check if act is unlawful (no legal justification)
   Cross-reference: nullum-crimen-sine-lege (Level 1)"
  (let ((lawful-justification (get-attribute act 'lawful-justification #f))
        (statutory-offense (get-attribute act 'statutory-offense #f))
        (common-law-crime (get-attribute act 'common-law-crime #f)))
    (and (or statutory-offense common-law-crime)
         (not lawful-justification))))

(define (omission? act)
  "Check if act is an omission with legal duty to act
   Cross-reference: actus-non-facit-reum-nisi-mens-sit-rea (Level 1)"
  (let ((type (get-attribute act 'type 'action))
        (legal-duty (get-attribute act 'legal-duty #f)))
    (and (equal? type 'omission)
         legal-duty)))

;; =============================================================================
;; MENS REA HELPERS
;; =============================================================================

(define (mens-rea? act)
  "Check if mens rea (guilty mind) is present
   Cross-reference: actus-non-facit-reum-nisi-mens-sit-rea (Level 1)"
  (or (intention? act)
      (criminal-negligence? act)))

(define (intention? act)
  "Check if accused had criminal intention (any form of dolus)
   Cross-reference: actus-non-facit-reum-nisi-mens-sit-rea (Level 1)"
  (or (dolus-directus? act)
      (dolus-indirectus? act)
      (dolus-eventualis? act)))

(define (dolus-directus? act)
  "Check for direct intention (aim/purpose to cause result)
   Cross-reference: actus-non-facit-reum-nisi-mens-sit-rea (Level 1)"
  (let ((intention-type (get-attribute act 'intention-type 'none))
        (desired-result (get-attribute act 'desired-result #f))
        (knew-would-occur (get-attribute act 'knew-would-occur #f)))
    (and (or (equal? intention-type 'direct)
             (equal? intention-type 'dolus-directus))
         desired-result
         knew-would-occur)))

(define (dolus-indirectus? act)
  "Check for indirect intention (knew result was certain/substantially certain)
   Cross-reference: actus-non-facit-reum-nisi-mens-sit-rea (Level 1)"
  (let ((intention-type (get-attribute act 'intention-type 'none))
        (knew-certain-consequence (get-attribute act 'knew-certain-consequence #f))
        (means-to-end (get-attribute act 'means-to-end #f)))
    (and (or (equal? intention-type 'indirect)
             (equal? intention-type 'dolus-indirectus))
         knew-certain-consequence
         means-to-end)))

(define (dolus-eventualis? act)
  "Check for dolus eventualis (foresight + reconciliation with result)
   Cross-reference: actus-non-facit-reum-nisi-mens-sit-rea (Level 1)"
  (let ((intention-type (get-attribute act 'intention-type 'none))
        (foresaw-possibility (get-attribute act 'foresaw-possibility #f))
        (reconciled-with-result (get-attribute act 'reconciled-with-result #f))
        (proceeded-regardless (get-attribute act 'proceeded-regardless #f)))
    (and (or (equal? intention-type 'eventualis)
             (equal? intention-type 'dolus-eventualis))
         foresaw-possibility
         reconciled-with-result
         proceeded-regardless)))

(define (criminal-negligence? act)
  "Check for criminal negligence (reasonable person test)
   Cross-reference: culpa, actus-non-facit-reum-nisi-mens-sit-rea (Level 1)"
  (let ((negligent (get-attribute act 'negligent #f))
        (foreseeable (get-attribute act 'foreseeable #f))
        (preventable (get-attribute act 'preventable #f))
        (failed-standard (get-attribute act 'failed-standard #f)))
    (and negligent
         foreseeable
         preventable
         failed-standard)))

;; =============================================================================
;; CAUSATION HELPERS
;; =============================================================================

(define (causation? act)
  "Check if causal link exists between conduct and result
   Cross-reference: actus-non-facit-reum-nisi-mens-sit-rea (Level 1)"
  (and (factual-causation? act)
       (legal-causation? act)))

(define (factual-causation? act)
  "Check factual causation using 'but for' test
   Cross-reference: causation principles (Level 1)"
  (let ((result (get-attribute act 'result #f))
        (conduct (get-attribute act 'conduct #f))
        (would-occur-without (get-attribute act 'would-occur-without #t)))
    (and result
         conduct
         (not would-occur-without))))

(define (legal-causation? act)
  "Check legal causation (not too remote, no novus actus interveniens)
   Cross-reference: causation principles (Level 1)"
  (let ((reasonably-foreseeable (get-attribute act 'reasonably-foreseeable #f))
        (not-too-remote (get-attribute act 'not-too-remote #t))
        (no-novus-actus (not (novus-actus-interveniens? act))))
    (and reasonably-foreseeable
         not-too-remote
         no-novus-actus)))

(define (novus-actus-interveniens? act)
  "Check if intervening act breaks causal chain
   Cross-reference: causation principles (Level 1)"
  (let ((intervening-act (get-attribute act 'intervening-act #f))
        (independent-cause (get-attribute act 'independent-cause #f))
        (breaks-chain (get-attribute act 'breaks-chain #f)))
    (and intervening-act
         independent-cause
         breaks-chain)))

;; =============================================================================
;; DEFENSE HELPERS
;; =============================================================================

(define (private-defence? act)
  "Check if private defence (self-defence) applies
   Cross-reference: volenti-non-fit-injuria (Level 1)"
  (let ((unlawful-attack (get-attribute act 'unlawful-attack #f))
        (defence-necessary (get-attribute act 'defence-necessary #f))
        (proportionate (get-attribute act 'proportionate-force #f))
        (imminent (get-attribute act 'imminent-threat #f)))
    (and unlawful-attack
         defence-necessary
         proportionate
         imminent)))

(define (necessity-defence? act)
  "Check if necessity defence applies
   Cross-reference: necessity principle (Level 1)"
  (let ((imminent-danger (get-attribute act 'imminent-danger #f))
        (lesser-evil (get-attribute act 'lesser-evil #f))
        (no-alternative (get-attribute act 'no-alternative #f))
        (proportionate (get-attribute act 'proportionate-response #f)))
    (and imminent-danger
         lesser-evil
         no-alternative
         proportionate)))

(define (insanity-defence? act)
  "Check if insanity defence applies
   Cross-reference: compos-mentis (Level 1)"
  (let ((mental-illness (get-attribute act 'mental-illness #f))
        (unable-appreciate-wrongfulness 
         (get-attribute act 'unable-appreciate-wrongfulness #f))
        (unable-act-in-accordance 
         (get-attribute act 'unable-act-in-accordance #f)))
    (and mental-illness
         (or unable-appreciate-wrongfulness
             unable-act-in-accordance))))

(define (intoxication-defence? act)
  "Check if intoxication defence applies (limited scope)
   Cross-reference: actus-non-facit-reum-nisi-mens-sit-rea (Level 1)"
  (let ((involuntary-intoxication (get-attribute act 'involuntary-intoxication #f))
        (specific-intent-crime (get-attribute act 'specific-intent-crime #f))
        (unable-form-intent (get-attribute act 'unable-form-intent #f)))
    (and (or involuntary-intoxication
             (and specific-intent-crime unable-form-intent))
         (not (get-attribute act 'voluntary-intoxication #f)))))

(define (mistake-defence? act)
  "Check if mistake of fact defence applies
   Cross-reference: actus-non-facit-reum-nisi-mens-sit-rea (Level 1)"
  (let ((mistake-of-fact (get-attribute act 'mistake-of-fact #f))
        (reasonable-mistake (get-attribute act 'reasonable-mistake #f))
        (negates-intent (get-attribute act 'negates-intent #f)))
    (and mistake-of-fact
         reasonable-mistake
         negates-intent)))

(define (duress-defence? act)
  "Check if duress defence applies
   Cross-reference: necessity principle (Level 1)"
  (let ((threat-of-harm (get-attribute act 'threat-of-harm #f))
        (imminent-threat (get-attribute act 'imminent-threat #f))
        (no-reasonable-alternative (get-attribute act 'no-reasonable-alternative #f))
        (proportionate (get-attribute act 'proportionate-response #f)))
    (and threat-of-harm
         imminent-threat
         no-reasonable-alternative
         proportionate)))

(define (impossibility-defence? act)
  "Check if impossibility defence applies
   Cross-reference: nullum-crimen-sine-lege (Level 1)"
  (let ((factual-impossibility (get-attribute act 'factual-impossibility #f))
        (legal-impossibility (get-attribute act 'legal-impossibility #f)))
    (or factual-impossibility
        legal-impossibility)))

(define (consent-defence-criminal? act)
  "Check if consent defence applies in criminal context (limited scope)
   Cross-reference: volenti-non-fit-injuria (Level 1)"
  (let ((victim-consented (get-attribute act 'victim-consented #f))
        (capacity-to-consent (get-attribute act 'capacity-to-consent #f))
        (lawful-purpose (get-attribute act 'lawful-purpose #f))
        (type (get-attribute act 'type 'unknown)))
    (and victim-consented
         capacity-to-consent
         lawful-purpose
         ;; Consent limited to certain offenses (e.g., assault, not murder)
         (not (member-of? type '(murder rape serious-assault))))))

;; =============================================================================
;; SPECIFIC CRIMES HELPERS
;; =============================================================================

(define (murder-elements? act)
  "Check if elements of murder are present
   Cross-reference: neminem-laedere, nullum-crimen-sine-lege (Level 1)"
  (let ((unlawful-killing (get-attribute act 'unlawful-killing #f))
        (human-being (get-attribute act 'victim-human-being #f))
        (intention-to-kill (get-attribute act 'intention-to-kill #f)))
    (and unlawful-killing
         human-being
         intention-to-kill
         (causation? act))))

(define (theft-elements? act)
  "Check if elements of theft are present
   Cross-reference: nemo-dat-quod-non-habet, nullum-crimen-sine-lege (Level 1)"
  (let ((appropriation (get-attribute act 'appropriation #f))
        (movable-property (get-attribute act 'movable-property #f))
        (belonging-to-another (get-attribute act 'belonging-to-another #f))
        (intention-to-deprive (get-attribute act 'intention-to-deprive #f))
        (without-consent (get-attribute act 'without-consent #f)))
    (and appropriation
         movable-property
         belonging-to-another
         intention-to-deprive
         without-consent)))

(define (fraud-elements? act)
  "Check if elements of fraud are present
   Cross-reference: bona-fides, nullum-crimen-sine-lege (Level 1)"
  (let ((misrepresentation (get-attribute act 'misrepresentation #f))
        (prejudice-to-another (get-attribute act 'prejudice-to-another #f))
        (benefit-to-accused (get-attribute act 'benefit-to-accused #f))
        (intention-to-deceive (get-attribute act 'intention-to-deceive #f))
        (actual-prejudice (get-attribute act 'actual-prejudice #f)))
    (and misrepresentation
         prejudice-to-another
         benefit-to-accused
         intention-to-deceive
         (or actual-prejudice
             (get-attribute act 'potential-prejudice #f)))))

(define (assault-elements? act)
  "Check if elements of assault are present
   Cross-reference: neminem-laedere, volenti-non-fit-injuria (Level 1)"
  (let ((application-of-force (get-attribute act 'application-of-force #f))
        (unlawful (get-attribute act 'unlawful #f))
        (intention (get-attribute act 'intention #f))
        (victim-did-not-consent (not (get-attribute act 'victim-consented #f))))
    (and application-of-force
         unlawful
         intention
         victim-did-not-consent)))

;; =============================================================================
;; ADDITIONAL HELPERS
;; =============================================================================

(define (unlawful? act)
  "Check if act is unlawful (general helper)
   Cross-reference: nullum-crimen-sine-lege, rule-of-law (Level 1)"
  (unlawful-act? act))

;; End of criminal law helpers
