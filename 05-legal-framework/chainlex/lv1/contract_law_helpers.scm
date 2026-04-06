;; =============================================================================
;; CONTRACT LAW HELPER FUNCTIONS
;; =============================================================================
;; Version: 1.0
;; Description: Helper functions for contract law reasoning
;; Derived from Level 1 principles: pacta-sunt-servanda, consensus-ad-idem
;; =============================================================================

(define-module (chainlex contract-law-helpers)
  #:use-module (chainlex core-utilities)
  #:export (
    ;; Contract formation
    intention-to-create-legal-relations?
    capacity-of-parties?
    legality-of-object?
    
    ;; Offer and acceptance
    within-reasonable-time?
    mirror-image-rule?
    
    ;; Contract terms
    express-term?
    implied-term?
    condition-precedent?
    condition-subsequent?
    
    ;; Contract performance
    substantial-performance?
    material-breach?
    anticipatory-breach?
    
    ;; Contract remedies
    specific-performance-available?
    damages-adequate-remedy?
    
    ;; Contract interpretation
    plain-meaning-rule?
    contra-proferentem?
    business-efficacy-test?
  ))

;; =============================================================================
;; CONTRACT FORMATION HELPERS
;; =============================================================================

(define (intention-to-create-legal-relations? contract)
  "Check if parties intended to create legal relations (derived from consensus-ad-idem)"
  (let ((context (get-attribute contract 'context 'unknown))
        (express-intention (get-attribute contract 'express-intention #f)))
    (cond
      ;; Express intention stated
      (express-intention #t)
      ;; Commercial context presumed
      ((equal? context 'commercial) #t)
      ;; Social/domestic context presumed not
      ((or (equal? context 'social) (equal? context 'domestic)) #f)
      ;; Check for consideration as indicator
      ((has-attribute contract 'consideration) #t)
      (else #f))))

(define (capacity-of-parties? contract)
  "Check if all parties have legal capacity to contract"
  (let ((parties (get-attribute contract 'parties '())))
    (all-true? 
      (map (lambda (party)
             (let ((age (get-attribute party 'age 0))
                   (mental-capacity (get-attribute party 'mental-capacity #t))
                   (not-insolvent (not (get-attribute party 'insolvent #f))))
               (and (>= age 18)
                    mental-capacity
                    not-insolvent)))
           parties))))

(define (legality-of-object? contract)
  "Check if contract object is legal (not contra bonos mores or illegal)"
  (let ((purpose (get-attribute contract 'purpose 'unknown))
        (terms (get-attribute contract 'terms '())))
    (and 
      ;; Not explicitly illegal
      (not (get-attribute contract 'illegal #f))
      ;; Not against public policy
      (not (get-attribute contract 'contra-bonos-mores #f))
      ;; Not impossible to perform
      (not (get-attribute contract 'impossible #f))
      ;; Purpose is lawful
      (not (member-of? purpose '(crime fraud immoral))))))

;; =============================================================================
;; OFFER AND ACCEPTANCE HELPERS
;; =============================================================================

(define (within-reasonable-time? acceptance offer)
  "Check if acceptance was made within reasonable time"
  (let ((offer-date (get-attribute offer 'date 0))
        (acceptance-date (get-attribute acceptance 'date 0))
        (specified-period (get-attribute offer 'validity-period #f))
        (time-diff (date-diff acceptance-date offer-date)))
    (cond
      ;; Specified period exists
      (specified-period (<= time-diff specified-period))
      ;; Perishable goods - short period
      ((equal? (get-attribute offer 'goods-type) 'perishable)
       (<= time-diff 7))  ; 7 days
      ;; Real estate - longer period
      ((equal? (get-attribute offer 'subject-matter) 'real-estate)
       (<= time-diff 30))  ; 30 days
      ;; Default reasonable time
      (else (<= time-diff 14)))))  ; 14 days default

(define (mirror-image-rule? acceptance offer)
  "Check if acceptance mirrors the offer exactly (no counter-offer)"
  (let ((offer-terms (get-attribute offer 'terms '()))
        (acceptance-terms (get-attribute acceptance 'terms '())))
    (and 
      ;; Same number of terms
      (= (length offer-terms) (length acceptance-terms))
      ;; All terms match
      (all-true?
        (map (lambda (term)
               (member-of? term acceptance-terms))
             offer-terms))
      ;; No additional terms in acceptance
      (all-true?
        (map (lambda (term)
               (member-of? term offer-terms))
             acceptance-terms)))))

;; =============================================================================
;; CONTRACT TERMS HELPERS
;; =============================================================================

(define (express-term? contract term-name)
  "Check if a term is expressly stated in contract"
  (let ((express-terms (get-attribute contract 'express-terms '())))
    (member-of? term-name express-terms)))

(define (implied-term? contract term-name)
  "Check if a term is implied by law, custom, or business efficacy"
  (let ((implied-by-law (get-attribute contract 'implied-by-law '()))
        (implied-by-custom (get-attribute contract 'implied-by-custom '()))
        (implied-by-efficacy (get-attribute contract 'implied-by-efficacy '())))
    (or (member-of? term-name implied-by-law)
        (member-of? term-name implied-by-custom)
        (member-of? term-name implied-by-efficacy))))

(define (condition-precedent? contract condition)
  "Check if condition must be satisfied before performance is due"
  (let ((conditions-precedent (get-attribute contract 'conditions-precedent '())))
    (member-of? condition conditions-precedent)))

(define (condition-subsequent? contract condition)
  "Check if condition terminates contract upon occurrence"
  (let ((conditions-subsequent (get-attribute contract 'conditions-subsequent '())))
    (member-of? condition conditions-subsequent)))

;; =============================================================================
;; CONTRACT PERFORMANCE HELPERS
;; =============================================================================

(define (substantial-performance? performance contract)
  "Check if performance is substantial (minor deviations allowed)"
  (let ((completion-percentage (get-attribute performance 'completion-percentage 0))
        (defects (get-attribute performance 'defects '()))
        (minor-defects-only (all-true?
                              (map (lambda (defect)
                                     (equal? (get-attribute defect 'severity) 'minor))
                                   defects))))
    (and (>= completion-percentage 90)
         minor-defects-only)))

(define (material-breach? breach contract)
  "Check if breach is material (goes to root of contract)"
  (let ((breach-severity (get-attribute breach 'severity 'unknown))
        (affects-core-purpose (get-attribute breach 'affects-core-purpose #f))
        (damages-substantial (get-attribute breach 'damages-substantial #f)))
    (or (equal? breach-severity 'fundamental)
        affects-core-purpose
        damages-substantial)))

(define (anticipatory-breach? party contract current-date)
  "Check if party has indicated they will not perform before due date"
  (let ((repudiation (get-attribute party 'repudiation #f))
        (performance-date (get-attribute contract 'performance-date 0))
        (inability-to-perform (get-attribute party 'unable-to-perform #f)))
    (and (date-before? current-date performance-date)
         (or repudiation inability-to-perform))))

;; =============================================================================
;; CONTRACT REMEDIES HELPERS
;; =============================================================================

(define (specific-performance-available? contract)
  "Check if specific performance is available as remedy (derived from specific-performance principle)"
  (let ((subject-matter (get-attribute contract 'subject-matter 'unknown))
        (damages-adequate (damages-adequate-remedy? contract)))
    (and 
      ;; Damages not adequate
      (not damages-adequate)
      ;; Subject matter is unique or real property
      (or (equal? subject-matter 'real-estate)
          (equal? subject-matter 'unique-goods)
          (get-attribute contract 'unique #f))
      ;; Not personal service contract
      (not (equal? subject-matter 'personal-service))
      ;; Contract is valid and enforceable
      (get-attribute contract 'enforceable #t))))

(define (damages-adequate-remedy? contract)
  "Check if monetary damages are adequate remedy"
  (let ((subject-matter (get-attribute contract 'subject-matter 'unknown)))
    (or (equal? subject-matter 'goods)
        (equal? subject-matter 'money)
        (get-attribute contract 'fungible #f))))

;; =============================================================================
;; CONTRACT INTERPRETATION HELPERS
;; =============================================================================

(define (plain-meaning-rule? contract term)
  "Apply plain meaning rule to contract interpretation"
  (let ((term-text (get-attribute term 'text ""))
        (ambiguous (get-attribute term 'ambiguous #f)))
    (and (not ambiguous)
         (> (string-length term-text) 0))))

(define (contra-proferentem? contract term drafter)
  "Apply contra proferentem rule (interpret against drafter)"
  (let ((term-ambiguous (get-attribute term 'ambiguous #f))
        (term-drafter (get-attribute term 'drafter 'unknown)))
    (and term-ambiguous
         (equal? term-drafter drafter))))

(define (business-efficacy-test? contract term)
  "Check if term is necessary for business efficacy"
  (let ((contract-workable (get-attribute contract 'workable-without-term #f)))
    (not contract-workable)))

;; =============================================================================
;; ADDITIONAL CONTRACT HELPERS
;; =============================================================================

(define (consideration-adequate? consideration)
  "Check if consideration is adequate (must be sufficient but need not be adequate)"
  ;; In law, consideration must be sufficient but need not be adequate
  ;; Sufficient = has some value, not necessarily equal value
  (let ((value (get-attribute consideration 'value 0)))
    (> value 0)))

(define (past-consideration? consideration contract-date)
  "Check if consideration is past (and therefore invalid)"
  (let ((consideration-date (get-attribute consideration 'date 0)))
    (date-before? consideration-date contract-date)))

(define (promissory-estoppel-applies? promise reliance detriment)
  "Check if promissory estoppel applies (equitable doctrine)"
  (and 
    ;; Clear and unambiguous promise
    (get-attribute promise 'clear #f)
    ;; Promisee relied on promise
    (get-attribute reliance 'reasonable #f)
    ;; Promisee suffered detriment
    (get-attribute detriment 'substantial #f)
    ;; Unconscionable to not enforce
    (get-attribute promise 'unconscionable-not-to-enforce #f)))

;; =============================================================================
;; END OF CONTRACT LAW HELPERS
;; =============================================================================

