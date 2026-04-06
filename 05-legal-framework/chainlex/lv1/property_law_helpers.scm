;; =============================================================================
;; PROPERTY LAW HELPER FUNCTIONS
;; =============================================================================
;; Version: 1.0
;; Description: Helper functions for property law reasoning
;; Derived from Level 1 principles: nemo-plus-iuris, nemo-dat-quod-non-habet,
;;                                   res-nullius
;; =============================================================================

(define-module (chainlex property-law-helpers)
  #:use-module (chainlex core-utilities)
  #:export (
    ;; Ownership helpers
    ownership-rights?
    full-ownership?
    limited-ownership?
    
    ;; Possession helpers
    possession?
    physical-control?
    animus-possidendi?
    lawful-possession?
    
    ;; Transfer helpers
    valid-transfer?
    capacity-to-transfer?
    capacity-to-receive?
    delivery-completed?
    
    ;; Real rights helpers
    real-right?
    personal-right?
    limited-real-right?
    
    ;; Specific real rights
    servitude?
    usufruct?
    use?
    habitation?
    mortgage?
    pledge?
    lease-real-right?
    
    ;; Acquisition helpers
    occupation?
    accession?
    specification?
    prescription?
  ))

;; =============================================================================
;; OWNERSHIP HELPERS
;; =============================================================================

(define (ownership-rights? person property)
  "Check if person has ownership rights over property
   Cross-reference: nemo-plus-iuris (Level 1)"
  (let ((rights (get-attribute person 'rights-over-property '())))
    (all-true?
      (list
        (member-of? 'use rights)
        (member-of? 'enjoy rights)
        (member-of? 'dispose rights)))))

(define (full-ownership? person property)
  "Check if person has full (unrestricted) ownership
   Cross-reference: nemo-plus-iuris (Level 1)"
  (let ((ownership-type (get-attribute person 'ownership-type 'none))
        (restrictions (get-attribute property 'restrictions '())))
    (and (equal? ownership-type 'full)
         (null? restrictions)
         (ownership-rights? person property))))

(define (limited-ownership? person property)
  "Check if person has limited ownership (with restrictions)
   Cross-reference: nemo-plus-iuris (Level 1)"
  (let ((ownership-type (get-attribute person 'ownership-type 'none))
        (restrictions (get-attribute property 'restrictions '())))
    (and (ownership-rights? person property)
         (or (equal? ownership-type 'limited)
             (not (null? restrictions))))))

;; =============================================================================
;; POSSESSION HELPERS
;; =============================================================================

(define (possession? person property)
  "Check if person has possession (corpus + animus)
   Cross-reference: possession principles (Level 1)"
  (and (physical-control? person property)
       (animus-possidendi? person property)))

(define (physical-control? person property)
  "Check if person has physical control (corpus possessionis)
   Cross-reference: possession principles (Level 1)"
  (let ((has-control (get-attribute person 'physical-control #f))
        (property-location (get-attribute property 'location 'unknown))
        (person-access (get-attribute person 'access-to-property #f)))
    (or has-control
        person-access
        (get-attribute person 'holds-property #f))))

(define (animus-possidendi? person property)
  "Check if person has intention to possess (animus possidendi)
   Cross-reference: possession principles (Level 1)"
  (let ((intention (get-attribute person 'intention-to-possess #f))
        (holds-as-owner (get-attribute person 'holds-as-owner #f)))
    (or intention holds-as-owner)))

(define (lawful-possession? person property)
  "Check if possession is lawful (not stolen, obtained legally)
   Cross-reference: nemo-dat-quod-non-habet (Level 1)"
  (let ((lawful (get-attribute person 'lawful-possession #t))
        (stolen (get-attribute property 'stolen #f))
        (obtained-illegally (get-attribute person 'obtained-illegally #f)))
    (and lawful
         (not stolen)
         (not obtained-illegally))))

;; =============================================================================
;; TRANSFER HELPERS
;; =============================================================================

(define (valid-transfer? transfer)
  "Check if property transfer is valid
   Cross-reference: nemo-dat-quod-non-habet, pacta-sunt-servanda (Level 1)"
  (and (capacity-to-transfer? transfer)
       (capacity-to-receive? transfer)
       (delivery-completed? transfer)
       (lawful-object? transfer)))

(define (capacity-to-transfer? transfer)
  "Check if transferor has capacity to transfer
   Cross-reference: nemo-dat-quod-non-habet (Level 1)"
  (let ((transferor (get-attribute transfer 'transferor #f))
        (property (get-attribute transfer 'property #f)))
    (and transferor
         property
         (ownership-rights? transferor property)
         (get-attribute transferor 'capacity #t)
         (not (get-attribute transferor 'insolvent #f)))))

(define (capacity-to-receive? transfer)
  "Check if transferee has capacity to receive
   Cross-reference: legal capacity principles (Level 1)"
  (let ((transferee (get-attribute transfer 'transferee #f)))
    (and transferee
         (get-attribute transferee 'capacity #t)
         (>= (get-attribute transferee 'age 0) 18))))

(define (delivery-completed? transfer)
  "Check if delivery (traditio) was completed
   Cross-reference: transfer of ownership principles (Level 1)"
  (let ((delivery-method (get-attribute transfer 'delivery-method 'none))
        (delivered (get-attribute transfer 'delivered #f))
        (registered (get-attribute transfer 'registered #f)))
    (or delivered
        registered
        (member-of? delivery-method '(actual-delivery 
                                       constructive-delivery 
                                       symbolic-delivery)))))

(define (lawful-object? transfer)
  "Check if object of transfer is lawful
   Cross-reference: legality principles (Level 1)"
  (let ((property (get-attribute transfer 'property #f)))
    (and property
         (not (get-attribute property 'illegal #f))
         (not (get-attribute property 'res-extra-commercium #f)))))

;; =============================================================================
;; REAL VS PERSONAL RIGHTS HELPERS
;; =============================================================================

(define (real-right? right)
  "Check if right is a real right (enforceable against world)
   Cross-reference: real rights principles (Level 1)"
  (let ((type (get-attribute right 'type 'unknown))
        (enforceable-against (get-attribute right 'enforceable-against 'none)))
    (or (equal? enforceable-against 'world)
        (equal? enforceable-against 'erga-omnes)
        (member-of? type '(ownership servitude usufruct mortgage pledge)))))

(define (personal-right? right)
  "Check if right is a personal right (enforceable against specific person)
   Cross-reference: personal rights principles (Level 1)"
  (let ((type (get-attribute right 'type 'unknown))
        (enforceable-against (get-attribute right 'enforceable-against 'none)))
    (or (equal? enforceable-against 'specific-person)
        (equal? enforceable-against 'in-personam)
        (member-of? type '(contract-right lease-personal debt)))))

(define (limited-real-right? right)
  "Check if right is a limited real right (burden on another's property)
   Cross-reference: real rights principles (Level 1)"
  (let ((type (get-attribute right 'type 'unknown)))
    (and (real-right? right)
         (member-of? type '(servitude usufruct use habitation mortgage pledge)))))

;; =============================================================================
;; SPECIFIC LIMITED REAL RIGHTS HELPERS
;; =============================================================================

(define (servitude? right property)
  "Check if servitude exists over property
   Cross-reference: real rights principles (Level 1)"
  (let ((type (get-attribute right 'type 'unknown))
        (burden (get-attribute property 'burden #f))
        (dominant-tenement (get-attribute right 'dominant-tenement #f))
        (servient-tenement (get-attribute property 'servient-tenement #f)))
    (and (equal? type 'servitude)
         (or burden servient-tenement)
         (or dominant-tenement
             (get-attribute right 'personal-servitude #f)))))

(define (usufruct? right property)
  "Check if usufruct exists over property
   Cross-reference: real rights principles (Level 1)"
  (let ((type (get-attribute right 'type 'unknown))
        (use-rights (get-attribute right 'use-rights #f))
        (enjoyment-rights (get-attribute right 'enjoyment-rights #f))
        (preserve-substance (get-attribute right 'preserve-substance #t)))
    (and (equal? type 'usufruct)
         use-rights
         enjoyment-rights
         preserve-substance)))

(define (use? right property)
  "Check if right of use exists
   Cross-reference: real rights principles (Level 1)"
  (let ((type (get-attribute right 'type 'unknown))
        (limited-use (get-attribute right 'limited-use #f)))
    (and (equal? type 'use)
         limited-use)))

(define (habitation? right property)
  "Check if right of habitation exists
   Cross-reference: real rights principles (Level 1)"
  (let ((type (get-attribute right 'type 'unknown))
        (dwelling (get-attribute property 'dwelling #f))
        (residence-right (get-attribute right 'residence-right #f)))
    (and (equal? type 'habitation)
         dwelling
         residence-right)))

(define (mortgage? right property)
  "Check if mortgage exists over property
   Cross-reference: real rights, security principles (Level 1)"
  (let ((type (get-attribute right 'type 'unknown))
        (secured-debt (get-attribute right 'secured-debt #f))
        (immovable-property (get-attribute property 'immovable #f))
        (registered (get-attribute right 'registered #f)))
    (and (equal? type 'mortgage)
         secured-debt
         immovable-property
         registered)))

(define (pledge? right property)
  "Check if pledge exists over property
   Cross-reference: real rights, security principles (Level 1)"
  (let ((type (get-attribute right 'type 'unknown))
        (secured-debt (get-attribute right 'secured-debt #f))
        (movable-property (get-attribute property 'movable #f))
        (delivery (get-attribute right 'delivery #f)))
    (and (equal? type 'pledge)
         secured-debt
         movable-property
         delivery)))

(define (lease-real-right? right)
  "Check if lease has real right characteristics (long-term, registered)
   Cross-reference: real rights principles (Level 1)"
  (let ((type (get-attribute right 'type 'unknown))
        (duration (get-attribute right 'duration 0))
        (registered (get-attribute right 'registered #f)))
    (and (equal? type 'lease)
         (> duration 10)  ; Long-term lease (>10 years)
         registered)))

;; =============================================================================
;; ACQUISITION HELPERS
;; =============================================================================

(define (occupation? acquisition)
  "Check if property acquired by occupation (res nullius)
   Cross-reference: res-nullius (Level 1)"
  (let ((method (get-attribute acquisition 'method 'unknown))
        (property (get-attribute acquisition 'property #f))
        (ownerless (get-attribute property 'ownerless #f))
        (taken-possession (get-attribute acquisition 'taken-possession #f)))
    (and (equal? method 'occupation)
         ownerless
         taken-possession
         (animus-possidendi? 
           (get-attribute acquisition 'acquirer #f) 
           property))))

(define (accession? acquisition)
  "Check if property acquired by accession
   Cross-reference: property acquisition principles (Level 1)"
  (let ((method (get-attribute acquisition 'method 'unknown))
        (principal-thing (get-attribute acquisition 'principal-thing #f))
        (accessory-thing (get-attribute acquisition 'accessory-thing #f))
        (attached (get-attribute acquisition 'attached #f)))
    (and (equal? method 'accession)
         principal-thing
         accessory-thing
         attached)))

(define (specification? acquisition)
  "Check if property acquired by specification
   Cross-reference: property acquisition principles (Level 1)"
  (let ((method (get-attribute acquisition 'method 'unknown))
        (materials (get-attribute acquisition 'materials #f))
        (new-species (get-attribute acquisition 'new-species #f))
        (cannot-revert (get-attribute acquisition 'cannot-revert #f)))
    (and (equal? method 'specification)
         materials
         new-species
         cannot-revert)))

(define (prescription? acquisition)
  "Check if property acquired by prescription (acquisitive/extinctive)
   Cross-reference: prescription principles (Level 1)"
  (let ((method (get-attribute acquisition 'method 'unknown))
        (period (get-attribute acquisition 'period 0))
        (continuous-possession (get-attribute acquisition 'continuous-possession #f))
        (peaceful (get-attribute acquisition 'peaceful #f))
        (public (get-attribute acquisition 'public #f)))
    (and (equal? method 'prescription)
         (>= period 30)  ; 30 years for acquisitive prescription
         continuous-possession
         peaceful
         public)))

;; End of property law helpers
