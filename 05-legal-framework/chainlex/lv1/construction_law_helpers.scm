;; =============================================================================
;; CONSTRUCTION LAW HELPER FUNCTIONS
;; =============================================================================
;; Version: 1.0
;; Description: Helper functions for construction law reasoning
;; Derived from Level 1 principles: pacta-sunt-servanda, bona-fides,
;;                                   professional duty, fitness for purpose
;; =============================================================================

(define-module (chainlex construction-law-helpers)
  #:use-module (chainlex core-utilities)
  #:use-module (chainlex contract-law-helpers)
  #:export (
    ;; Contract type helpers
    standard-form-contract?
    jbcc-compliant?
    fidic-compliant?
    nec-compliant?
    gcc-compliant?
    
    ;; Obligations helpers
    contractor-obligations-met?
    employer-obligations-met?
    workmanship-acceptable?
    
    ;; Variations helpers
    variation-valid?
    variation-instruction-proper?
    variation-valuation-correct?
    
    ;; Claims helpers
    extension-of-time-claim-valid?
    additional-cost-claim-valid?
    delay-event?
    critical-path-affected?
    
    ;; Defects helpers
    defect-liability?
    latent-defect?
    patent-defect?
    within-defects-period?
    
    ;; Completion helpers
    practical-completion?
    final-completion?
    certificate-of-completion?
  ))

;; =============================================================================
;; CONTRACT TYPE HELPERS
;; =============================================================================

(define (standard-form-contract? contract)
  "Check if contract is a standard form
   Cross-reference: construction contract standards (Level 1)"
  (let ((form (get-attribute contract 'contract-form 'unknown)))
    (member-of? form '(jbcc fidic nec gcc))))

(define (jbcc-compliant? contract)
  "Check if contract complies with JBCC standard form
   Cross-reference: JBCC requirements (Level 1)"
  (let ((form (get-attribute contract 'contract-form 'unknown))
        (principal-building-agreement 
         (get-attribute contract 'principal-building-agreement #f))
        (nominated-subcontract (get-attribute contract 'nominated-subcontract #f))
        (minor-works (get-attribute contract 'minor-works #f)))
    (and (equal? form 'jbcc)
         (or principal-building-agreement
             nominated-subcontract
             minor-works))))

(define (fidic-compliant? contract)
  "Check if contract complies with FIDIC standard form
   Cross-reference: FIDIC requirements (Level 1)"
  (let ((form (get-attribute contract 'contract-form 'unknown))
        (book-color (get-attribute contract 'fidic-book 'unknown)))
    (and (equal? form 'fidic)
         (member-of? book-color '(red yellow silver gold green)))))

(define (nec-compliant? contract)
  "Check if contract complies with NEC standard form
   Cross-reference: NEC requirements (Level 1)"
  (let ((form (get-attribute contract 'contract-form 'unknown))
        (nec-version (get-attribute contract 'nec-version 'unknown)))
    (and (equal? form 'nec)
         (member-of? nec-version '(nec3 nec4)))))

(define (gcc-compliant? contract)
  "Check if contract complies with GCC standard form
   Cross-reference: GCC requirements (Level 1)"
  (let ((form (get-attribute contract 'contract-form 'unknown))
        (gcc-2015 (get-attribute contract 'gcc-2015 #f)))
    (and (equal? form 'gcc)
         gcc-2015)))

;; =============================================================================
;; OBLIGATIONS HELPERS
;; =============================================================================

(define (contractor-obligations-met? contractor works)
  "Check if contractor has met all obligations
   Cross-reference: pacta-sunt-servanda, professional duty (Level 1)"
  (and (complete-works-timeously? contractor works)
       (complete-works-properly? contractor works)
       (workmanship-acceptable? works)
       (materials-proper? works)
       (specifications-complied-with? works)))

(define (complete-works-timeously? contractor works)
  "Check if works completed on time
   Cross-reference: time of essence (Level 1)"
  (let ((completion-date (get-attribute works 'completion-date 0))
        (contract-completion (get-attribute works 'contract-completion-date 0))
        (eot-granted (get-attribute works 'extension-of-time-granted 0)))
    (or (<= completion-date contract-completion)
        (<= completion-date (+ contract-completion eot-granted)))))

(define (complete-works-properly? contractor works)
  "Check if works completed properly
   Cross-reference: fitness for purpose (Level 1)"
  (and (workmanship-acceptable? works)
       (materials-proper? works)
       (specifications-complied-with? works)))

(define (workmanship-acceptable? works)
  "Check if workmanship meets required standards
   Cross-reference: professional duty, industry standards (Level 1)"
  (let ((meets-specs (get-attribute works 'meets-specifications #f))
        (industry-standard (get-attribute works 'meets-industry-standards #f))
        (defect-free (get-attribute works 'free-from-defects #f)))
    (and meets-specs
         industry-standard
         defect-free)))

(define (materials-proper? works)
  "Check if proper materials were used
   Cross-reference: fitness for purpose (Level 1)"
  (let ((proper-materials (get-attribute works 'proper-materials-used #f))
        (specification-compliant 
         (get-attribute works 'materials-specification-compliant #f))
        (quality-acceptable (get-attribute works 'materials-quality-acceptable #f)))
    (and proper-materials
         specification-compliant
         quality-acceptable)))

(define (specifications-complied-with? works)
  "Check if specifications were complied with
   Cross-reference: contractual compliance (Level 1)"
  (let ((complies (get-attribute works 'complies-with-specifications #f))
        (drawings-followed (get-attribute works 'drawings-followed #f)))
    (and complies drawings-followed)))

(define (employer-obligations-met? employer)
  "Check if employer has met all obligations
   Cross-reference: pacta-sunt-servanda, cooperation duty (Level 1)"
  (and (site-access-provided? employer)
       (payment-obligations-met? employer)
       (timeous-instructions? employer)
       (cooperation-provided? employer)))

(define (site-access-provided? employer)
  "Check if site access was provided
   Cross-reference: cooperation duty (Level 1)"
  (let ((access (get-attribute employer 'site-access-provided #f))
        (timely (get-attribute employer 'access-timely #f)))
    (and access timely)))

(define (payment-obligations-met? employer)
  "Check if payment obligations were met
   Cross-reference: consideration, payment duties (Level 1)"
  (let ((payments-made (get-attribute employer 'payments-made #f))
        (timely-payment (get-attribute employer 'timely-payment #f))
        (certificates-honored (get-attribute employer 'certificates-honored #f)))
    (and payments-made
         timely-payment
         certificates-honored)))

(define (timeous-instructions? employer)
  "Check if instructions were given timeously
   Cross-reference: cooperation duty (Level 1)"
  (let ((instructions (get-attribute employer 'instructions-given #f))
        (timely (get-attribute employer 'instructions-timely #f)))
    (and instructions timely)))

(define (cooperation-provided? employer)
  "Check if employer cooperated with contractor
   Cross-reference: cooperation duty, bona-fides (Level 1)"
  (let ((cooperation (get-attribute employer 'cooperation #f))
        (no-hindrance (not (get-attribute employer 'hindered-contractor #f))))
    (and cooperation no-hindrance)))

;; =============================================================================
;; VARIATIONS HELPERS
;; =============================================================================

(define (variation-valid? variation)
  "Check if variation is valid
   Cross-reference: variation principles, contractual authority (Level 1)"
  (and (variation-instruction-proper? variation)
       (changes-scope-of-works? variation)
       (variation-valuation-correct? variation)))

(define (variation-instruction-proper? variation)
  "Check if variation instruction was properly given
   Cross-reference: authority to vary (Level 1)"
  (let ((instruction (get-attribute variation 'instruction-given #f))
        (authorized-person (get-attribute variation 'authorized-person #f))
        (in-writing (get-attribute variation 'in-writing #f)))
    (and instruction
         authorized-person
         in-writing)))

(define (changes-scope-of-works? variation)
  "Check if variation changes scope of works
   Cross-reference: variation definition (Level 1)"
  (let ((scope-change (get-attribute variation 'scope-change #f))
        (addition (get-attribute variation 'addition #f))
        (omission (get-attribute variation 'omission #f))
        (substitution (get-attribute variation 'substitution #f)))
    (or scope-change addition omission substitution)))

(define (variation-valuation-correct? variation)
  "Check if variation valuation is correct
   Cross-reference: valuation principles (Level 1)"
  (let ((valuation-method (get-attribute variation 'valuation-method 'unknown))
        (rates-applied (get-attribute variation 'contract-rates-applied #f))
        (fair-valuation (get-attribute variation 'fair-valuation #f)))
    (and (member-of? valuation-method '(contract-rates daywork fair-rates))
         (or rates-applied fair-valuation))))

;; =============================================================================
;; CLAIMS HELPERS
;; =============================================================================

(define (extension-of-time-claim-valid? claim)
  "Check if extension of time claim is valid
   Cross-reference: delay principles, prevention principle (Level 1)"
  (and (delay-event? claim)
       (delay-not-contractor-fault? claim)
       (critical-path-affected? claim)
       (notice-given-timeously? claim)
       (claim-submitted-timeously? claim)))

(define (delay-event? claim)
  "Check if a delay event occurred
   Cross-reference: delay events (Level 1)"
  (let ((event (get-attribute claim 'event-type 'unknown)))
    (member-of? event '(employer-delay variation weather exceptional-event
                        force-majeure authorized-suspension))))

(define (delay-not-contractor-fault? claim)
  "Check if delay was not contractor's fault
   Cross-reference: prevention principle (Level 1)"
  (let ((contractor-fault (get-attribute claim 'contractor-fault #f))
        (employer-caused (get-attribute claim 'employer-caused #f))
        (neutral-event (get-attribute claim 'neutral-event #f)))
    (and (not contractor-fault)
         (or employer-caused neutral-event))))

(define (critical-path-affected? claim)
  "Check if critical path was affected
   Cross-reference: delay impact (Level 1)"
  (let ((critical-path-delay (get-attribute claim 'critical-path-delay #f))
        (completion-delayed (get-attribute claim 'completion-delayed #f))
        (float-consumed (get-attribute claim 'float-consumed #f)))
    (and critical-path-delay
         (or completion-delayed float-consumed))))

(define (notice-given-timeously? claim)
  "Check if notice was given timeously
   Cross-reference: notice requirements (Level 1)"
  (let ((notice (get-attribute claim 'notice-given #f))
        (within-time (get-attribute claim 'notice-within-time #f)))
    (and notice within-time)))

(define (claim-submitted-timeously? claim)
  "Check if claim was submitted timeously
   Cross-reference: procedural requirements (Level 1)"
  (let ((submitted (get-attribute claim 'claim-submitted #f))
        (within-period (get-attribute claim 'within-claim-period #f)))
    (and submitted within-period)))

(define (additional-cost-claim-valid? claim)
  "Check if additional cost claim is valid
   Cross-reference: restitution, unjust enrichment (Level 1)"
  (and (cost-incurred? claim)
       (not-within-contract-price? claim)
       (caused-by-compensable-event? claim)
       (properly-substantiated? claim)))

(define (cost-incurred? claim)
  "Check if additional cost was actually incurred
   Cross-reference: loss and expense (Level 1)"
  (let ((cost (get-attribute claim 'cost-incurred 0))
        (evidence (get-attribute claim 'cost-evidence #f)))
    (and (> cost 0) evidence)))

(define (not-within-contract-price? claim)
  "Check if cost not recoverable within contract price
   Cross-reference: contract price (Level 1)"
  (let ((within-price (get-attribute claim 'within-contract-price #f)))
    (not within-price)))

(define (caused-by-compensable-event? claim)
  "Check if cost caused by compensable event
   Cross-reference: causation, compensation (Level 1)"
  (let ((event (get-attribute claim 'event-type 'unknown)))
    (member-of? event '(variation employer-delay late-instructions
                        suspension employer-breach))))

(define (properly-substantiated? claim)
  "Check if claim is properly substantiated
   Cross-reference: evidence requirements (Level 1)"
  (let ((substantiation (get-attribute claim 'substantiation #f))
        (records (get-attribute claim 'contemporary-records #f))
        (calculations (get-attribute claim 'calculations #f)))
    (and substantiation
         records
         calculations)))

;; =============================================================================
;; DEFECTS HELPERS
;; =============================================================================

(define (defect-liability? defect)
  "Check if contractor liable for defect
   Cross-reference: fitness for purpose, professional duty (Level 1)"
  (and (defect-in-works? defect)
       (within-defects-period? defect)
       (contractor-caused? defect)
       (not-employer-caused? defect)))

(define (defect-in-works? defect)
  "Check if defect exists in the works
   Cross-reference: defect definition (Level 1)"
  (let ((defect-type (get-attribute defect 'type 'unknown)))
    (member-of? defect-type '(workmanship materials design structural))))

(define (within-defects-period? defect)
  "Check if defect manifested within defects liability period
   Cross-reference: warranty period (Level 1)"
  (let ((manifestation-date (get-attribute defect 'manifestation-date 0))
        (completion-date (get-attribute defect 'completion-date 0))
        (defects-period (get-attribute defect 'defects-period 12)))
    (within-time-period? manifestation-date 
                        completion-date 
                        (* defects-period 30))))  ; months to days

(define (latent-defect? defect)
  "Check if defect is latent (hidden, not discoverable)
   Cross-reference: latent defect principles (Level 1)"
  (let ((discoverable-at-completion 
         (get-attribute defect 'discoverable-at-completion #f))
        (manifests-later (get-attribute defect 'manifests-later #f))
        (reasonable-inspection (get-attribute defect 'reasonable-inspection #f)))
    (and (not discoverable-at-completion)
         manifests-later
         reasonable-inspection)))

(define (patent-defect? defect)
  "Check if defect is patent (visible, discoverable)
   Cross-reference: patent defect principles (Level 1)"
  (let ((discoverable-at-completion 
         (get-attribute defect 'discoverable-at-completion #f)))
    discoverable-at-completion))

(define (contractor-caused? defect)
  "Check if defect was caused by contractor
   Cross-reference: causation (Level 1)"
  (let ((contractor-fault (get-attribute defect 'contractor-fault #f)))
    contractor-fault))

(define (not-employer-caused? defect)
  "Check if defect was not caused by employer
   Cross-reference: prevention principle (Level 1)"
  (let ((employer-fault (get-attribute defect 'employer-fault #f)))
    (not employer-fault)))

;; =============================================================================
;; COMPLETION HELPERS
;; =============================================================================

(define (practical-completion? works)
  "Check if practical completion achieved
   Cross-reference: completion principles (Level 1)"
  (let ((substantially-complete (get-attribute works 'substantially-complete #f))
        (can-be-used (get-attribute works 'can-be-used-for-purpose #f))
        (minor-defects-only (get-attribute works 'only-minor-defects #f))
        (certificate-issued (get-attribute works 'completion-certificate-issued #f)))
    (and substantially-complete
         can-be-used
         minor-defects-only
         certificate-issued)))

(define (final-completion? works)
  "Check if final completion achieved
   Cross-reference: completion principles (Level 1)"
  (let ((defects-rectified (get-attribute works 'defects-rectified #f))
        (final-account-agreed (get-attribute works 'final-account-agreed #f))
        (all-obligations-discharged 
         (get-attribute works 'all-obligations-discharged #f)))
    (and defects-rectified
         final-account-agreed
         all-obligations-discharged)))

(define (certificate-of-completion? certificate)
  "Check if certificate of completion is valid
   Cross-reference: certification principles (Level 1)"
  (let ((issued-by-authorized 
         (get-attribute certificate 'issued-by-authorized #f))
        (date-specified (get-attribute certificate 'completion-date-specified #f))
        (properly-executed (get-attribute certificate 'properly-executed #f)))
    (and issued-by-authorized
         date-specified
         properly-executed)))

;; End of construction law helpers
