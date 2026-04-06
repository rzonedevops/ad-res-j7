;; =============================================================================
;; LABOUR LAW HELPER FUNCTIONS
;; =============================================================================
;; Version: 1.0
;; Description: Helper functions for labour law reasoning
;; Derived from Level 1 principles: audi-alteram-partem, bona-fides,
;;                                   procedural-fairness, proportionality
;; =============================================================================

(define-module (chainlex labour-law-helpers)
  #:use-module (chainlex core-utilities)
  #:export (
    ;; Employment relationship helpers
    employment-relationship?
    employee?
    independent-contractor?
    personal-service?
    
    ;; Dismissal helpers
    dismissal-occurred?
    fair-dismissal?
    unfair-dismissal?
    automatically-unfair-dismissal?
    constructive-dismissal?
    
    ;; Fair reason helpers
    misconduct-dismissal?
    incapacity-dismissal?
    operational-requirements-dismissal?
    
    ;; Fair procedure helpers
    fair-procedure?
    investigation-conducted?
    opportunity-to-respond?
    right-to-representation?
    
    ;; Strike and lockout helpers
    protected-strike?
    protected-lockout?
    essential-service?
    strike-procedurally-compliant?
    
    ;; Working time helpers
    working-time-compliant?
    overtime-lawful?
    rest-periods-adequate?
    
    ;; Leave entitlements helpers
    annual-leave-entitled?
    sick-leave-entitled?
    maternity-leave-entitled?
    family-responsibility-leave-entitled?
    
    ;; Discrimination helpers
    unfair-discrimination?
    listed-ground?
    inherent-job-requirement?
    
    ;; Collective bargaining helpers
    collective-agreement-binding?
    bargaining-unit-appropriate?
    organizational-rights?
  ))

;; =============================================================================
;; EMPLOYMENT RELATIONSHIP HELPERS
;; =============================================================================

(define (employment-relationship? relationship)
  "Check if employment relationship exists
   Cross-reference: pacta-sunt-servanda, personal service (Level 1)"
  (and (personal-service? relationship)
       (remuneration? relationship)
       (supervision-and-control? relationship)))

(define (employee? person relationship)
  "Check if person is an employee (not independent contractor)
   Cross-reference: employment relationship principles (Level 1)"
  (let ((works-for-another (get-attribute person 'works-for-another #f))
        (subject-to-control (get-attribute relationship 'subject-to-control #f))
        (economically-dependent (get-attribute person 'economically-dependent #f))
        (integrated-into-business (get-attribute relationship 'integrated #f)))
    (and works-for-another
         subject-to-control
         economically-dependent
         integrated-into-business)))

(define (independent-contractor? person relationship)
  "Check if person is an independent contractor
   Cross-reference: employment relationship principles (Level 1)"
  (let ((own-business (get-attribute person 'own-business #f))
        (no-control (not (get-attribute relationship 'subject-to-control #f)))
        (multiple-clients (get-attribute person 'multiple-clients #f))
        (bears-own-risk (get-attribute person 'bears-own-risk #f)))
    (and own-business
         no-control
         (or multiple-clients bears-own-risk))))

(define (personal-service? relationship)
  "Check if relationship involves personal service
   Cross-reference: personal service principles (Level 1)"
  (let ((service-type (get-attribute relationship 'service-type 'none))
        (substitution-allowed (get-attribute relationship 'substitution-allowed #f)))
    (and (equal? service-type 'personal)
         (not substitution-allowed))))

(define (remuneration? relationship)
  "Check if remuneration is provided
   Cross-reference: consideration, quid pro quo (Level 1)"
  (let ((remuneration (get-attribute relationship 'remuneration #f))
        (payment-amount (get-attribute relationship 'payment-amount 0)))
    (and remuneration
         (> payment-amount 0))))

(define (supervision-and-control? relationship)
  "Check if supervision and control exists
   Cross-reference: employment relationship principles (Level 1)"
  (let ((supervision (get-attribute relationship 'supervision #f))
        (control-over-work (get-attribute relationship 'control-over-work #f))
        (discretion-limited (get-attribute relationship 'discretion-limited #f)))
    (and supervision
         control-over-work
         discretion-limited)))

;; =============================================================================
;; DISMISSAL HELPERS
;; =============================================================================

(define (dismissal-occurred? dismissal)
  "Check if dismissal occurred
   Cross-reference: termination of contract (Level 1)"
  (let ((termination (get-attribute dismissal 'termination #f))
        (by-employer (get-attribute dismissal 'by-employer #f))
        (employment-ended (get-attribute dismissal 'employment-ended #f)))
    (and termination
         by-employer
         employment-ended)))

(define (fair-dismissal? dismissal)
  "Check if dismissal is fair (substantive + procedural fairness)
   Cross-reference: audi-alteram-partem, procedural-fairness (Level 1)"
  (and (fair-reason? dismissal)
       (fair-procedure? dismissal)))

(define (unfair-dismissal? dismissal)
  "Check if dismissal is unfair
   Cross-reference: audi-alteram-partem, procedural-fairness (Level 1)"
  (and (dismissal-occurred? dismissal)
       (not (fair-dismissal? dismissal))))

(define (automatically-unfair-dismissal? dismissal)
  "Check if dismissal is automatically unfair
   Cross-reference: discrimination, rights protection (Level 1)"
  (let ((reason (get-attribute dismissal 'reason 'unknown)))
    (member-of? reason '(discrimination
                         pregnancy
                         trade-union-participation
                         refusing-unsafe-work
                         exercising-statutory-right
                         whistle-blowing
                         asserting-constitutional-right))))

(define (constructive-dismissal? dismissal)
  "Check if constructive dismissal occurred
   Cross-reference: breach of contract, intolerable conditions (Level 1)"
  (let ((employee-resigned (get-attribute dismissal 'employee-resigned #f))
        (intolerable-conditions (get-attribute dismissal 'intolerable-conditions #f))
        (no-choice (get-attribute dismissal 'no-choice-but-resign #f))
        (employer-breach (get-attribute dismissal 'employer-breach #f)))
    (and employee-resigned
         intolerable-conditions
         no-choice
         employer-breach)))

;; =============================================================================
;; FAIR REASON HELPERS
;; =============================================================================

(define (fair-reason? dismissal)
  "Check if fair reason for dismissal exists
   Cross-reference: substantive fairness (Level 1)"
  (or (misconduct-dismissal? dismissal)
      (incapacity-dismissal? dismissal)
      (operational-requirements-dismissal? dismissal)))

(define (misconduct-dismissal? dismissal)
  "Check if dismissal based on misconduct
   Cross-reference: fault, breach of duty (Level 1)"
  (let ((reason (get-attribute dismissal 'reason 'unknown))
        (serious-misconduct (get-attribute dismissal 'serious-misconduct #f))
        (repeated-misconduct (get-attribute dismissal 'repeated-misconduct #f))
        (warnings-given (get-attribute dismissal 'warnings-given #f)))
    (and (equal? reason 'misconduct)
         (or serious-misconduct
             (and repeated-misconduct warnings-given)))))

(define (incapacity-dismissal? dismissal)
  "Check if dismissal based on incapacity
   Cross-reference: performance standards (Level 1)"
  (let ((reason (get-attribute dismissal 'reason 'unknown))
        (poor-performance (get-attribute dismissal 'poor-performance #f))
        (ill-health (get-attribute dismissal 'ill-health #f))
        (assistance-provided (get-attribute dismissal 'assistance-provided #f)))
    (and (equal? reason 'incapacity)
         (or poor-performance ill-health)
         assistance-provided)))

(define (operational-requirements-dismissal? dismissal)
  "Check if dismissal based on operational requirements
   Cross-reference: business necessity (Level 1)"
  (let ((reason (get-attribute dismissal 'reason 'unknown))
        (economic-reasons (get-attribute dismissal 'economic-reasons #f))
        (restructuring (get-attribute dismissal 'restructuring #f))
        (consultation-held (get-attribute dismissal 'consultation-held #f))
        (alternatives-considered (get-attribute dismissal 'alternatives-considered #f)))
    (and (equal? reason 'operational-requirements)
         (or economic-reasons restructuring)
         consultation-held
         alternatives-considered)))

;; =============================================================================
;; FAIR PROCEDURE HELPERS
;; =============================================================================

(define (fair-procedure? dismissal)
  "Check if fair procedure was followed
   Cross-reference: audi-alteram-partem, nemo-iudex-in-causa-sua (Level 1)"
  (and (investigation-conducted? dismissal)
       (employee-notified? dismissal)
       (opportunity-to-respond? dismissal)
       (hearing-held? dismissal)
       (right-to-representation? dismissal)))

(define (investigation-conducted? dismissal)
  "Check if investigation was conducted
   Cross-reference: procedural fairness (Level 1)"
  (let ((investigation (get-attribute dismissal 'investigation-conducted #f))
        (facts-gathered (get-attribute dismissal 'facts-gathered #f)))
    (and investigation facts-gathered)))

(define (employee-notified? dismissal)
  "Check if employee was notified
   Cross-reference: audi-alteram-partem (Level 1)"
  (let ((notification (get-attribute dismissal 'employee-notified #f))
        (charges-specified (get-attribute dismissal 'charges-specified #f))
        (adequate-notice (get-attribute dismissal 'adequate-notice #f)))
    (and notification
         charges-specified
         adequate-notice)))

(define (opportunity-to-respond? dismissal)
  "Check if employee had opportunity to respond
   Cross-reference: audi-alteram-partem (Level 1)"
  (let ((opportunity (get-attribute dismissal 'opportunity-to-respond #f))
        (could-state-case (get-attribute dismissal 'could-state-case #f))
        (could-present-evidence (get-attribute dismissal 'could-present-evidence #f)))
    (and opportunity
         could-state-case
         could-present-evidence)))

(define (hearing-held? dismissal)
  "Check if hearing was held
   Cross-reference: procedural fairness (Level 1)"
  (let ((hearing (get-attribute dismissal 'hearing-held #f))
        (impartial-chairperson (get-attribute dismissal 'impartial-chairperson #f)))
    (and hearing impartial-chairperson)))

(define (right-to-representation? dismissal)
  "Check if employee could be represented
   Cross-reference: audi-alteram-partem (Level 1)"
  (let ((representation-allowed (get-attribute dismissal 'representation-allowed #f))
        (trade-union-rep (get-attribute dismissal 'trade-union-rep #f))
        (fellow-employee (get-attribute dismissal 'fellow-employee #f)))
    (or representation-allowed
        trade-union-rep
        fellow-employee)))

;; =============================================================================
;; STRIKE AND LOCKOUT HELPERS
;; =============================================================================

(define (protected-strike? strike)
  "Check if strike is protected
   Cross-reference: right to strike, procedural compliance (Level 1)"
  (and (dispute-of-interest? strike)
       (conciliation-attempted? strike)
       (notice-given? strike)
       (strike-procedurally-compliant? strike)
       (not (essential-service? strike))
       (peaceful-strike? strike)))

(define (protected-lockout? lockout)
  "Check if lockout is protected
   Cross-reference: employer rights, procedural compliance (Level 1)"
  (and (response-to-strike? lockout)
       (notice-given? lockout)
       (procedurally-compliant? lockout)
       (not (essential-service? lockout))))

(define (essential-service? action)
  "Check if action involves essential service
   Cross-reference: public interest (Level 1)"
  (let ((service (get-attribute action 'service-type 'unknown)))
    (member-of? service '(healthcare
                          fire-services
                          police
                          sanitation
                          parliament
                          courts))))

(define (strike-procedurally-compliant? strike)
  "Check if strike follows correct procedure
   Cross-reference: procedural-fairness (Level 1)"
  (and (conciliation-attempted? strike)
       (certificate-issued? strike)
       (notice-given? strike)
       (within-time-limits? strike)))

(define (dispute-of-interest? strike)
  "Check if dispute is one of interest (not rights)
   Cross-reference: dispute resolution (Level 1)"
  (let ((dispute-type (get-attribute strike 'dispute-type 'unknown)))
    (equal? dispute-type 'interest)))

(define (conciliation-attempted? action)
  "Check if conciliation was attempted
   Cross-reference: dispute resolution (Level 1)"
  (get-attribute action 'conciliation-attempted #f))

(define (notice-given? action)
  "Check if required notice was given
   Cross-reference: procedural requirements (Level 1)"
  (let ((notice (get-attribute action 'notice-given #f))
        (notice-period (get-attribute action 'notice-period 0)))
    (and notice (>= notice-period 48))))  ; 48 hours minimum

(define (certificate-issued? strike)
  "Check if certificate of non-resolution issued
   Cross-reference: procedural requirements (Level 1)"
  (get-attribute strike 'certificate-issued #f))

(define (within-time-limits? action)
  "Check if action within required time limits
   Cross-reference: procedural requirements (Level 1)"
  (let ((within-limits (get-attribute action 'within-time-limits #t)))
    within-limits))

(define (peaceful-strike? strike)
  "Check if strike is peaceful (no violence)
   Cross-reference: right to strike limits (Level 1)"
  (not (get-attribute strike 'violence #f)))

(define (response-to-strike? lockout)
  "Check if lockout is response to strike
   Cross-reference: proportionality (Level 1)"
  (get-attribute lockout 'response-to-strike #f))

(define (procedurally-compliant? action)
  "Check general procedural compliance
   Cross-reference: procedural-fairness (Level 1)"
  (get-attribute action 'procedurally-compliant #t))

;; =============================================================================
;; WORKING TIME HELPERS
;; =============================================================================

(define (working-time-compliant? arrangement)
  "Check if working time arrangements comply with BCEA
   Cross-reference: employee protection (Level 1)"
  (and (max-hours-per-week? arrangement)
       (max-hours-per-day? arrangement)
       (rest-periods-adequate? arrangement)))

(define (max-hours-per-week? arrangement)
  "Check if maximum hours per week not exceeded
   Cross-reference: BCEA limits (Level 1)"
  (let ((hours-per-week (get-attribute arrangement 'hours-per-week 40)))
    (<= hours-per-week 45)))

(define (max-hours-per-day? arrangement)
  "Check if maximum hours per day not exceeded
   Cross-reference: BCEA limits (Level 1)"
  (let ((hours-per-day (get-attribute arrangement 'hours-per-day 8)))
    (<= hours-per-day 9)))

(define (overtime-lawful? arrangement)
  "Check if overtime is lawful and properly compensated
   Cross-reference: overtime regulations (Level 1)"
  (let ((overtime-hours (get-attribute arrangement 'overtime-hours 0))
        (overtime-rate (get-attribute arrangement 'overtime-rate 1.0))
        (employee-agreed (get-attribute arrangement 'employee-agreed #t)))
    (and (<= overtime-hours 10)  ; Max 10 hours overtime per week
         (>= overtime-rate 1.5)   ; Minimum 1.5x pay
         employee-agreed)))

(define (rest-periods-adequate? arrangement)
  "Check if rest periods are adequate
   Cross-reference: employee protection (Level 1)"
  (let ((daily-rest (get-attribute arrangement 'daily-rest-hours 0))
        (weekly-rest (get-attribute arrangement 'weekly-rest-hours 0)))
    (and (>= daily-rest 12)  ; 12 hours between shifts
         (>= weekly-rest 36))))  ; 36 hours weekly rest

;; =============================================================================
;; LEAVE ENTITLEMENTS HELPERS
;; =============================================================================

(define (annual-leave-entitled? employee)
  "Check if employee entitled to annual leave
   Cross-reference: leave entitlements (Level 1)"
  (let ((service-period (get-attribute employee 'service-period 0)))
    (>= service-period 4)))  ; After 4 months employment

(define (sick-leave-entitled? employee)
  "Check if employee entitled to sick leave
   Cross-reference: leave entitlements (Level 1)"
  (let ((service-period (get-attribute employee 'service-period 0)))
    (>= service-period 1)))  ; After 1 month employment

(define (maternity-leave-entitled? employee)
  "Check if employee entitled to maternity leave
   Cross-reference: leave entitlements (Level 1)"
  (let ((pregnant (get-attribute employee 'pregnant #f))
        (service-period (get-attribute employee 'service-period 0)))
    (and pregnant
         (>= service-period 4))))  ; After 4 months employment

(define (family-responsibility-leave-entitled? employee)
  "Check if employee entitled to family responsibility leave
   Cross-reference: leave entitlements (Level 1)"
  (let ((service-period (get-attribute employee 'service-period 0))
        (full-time (get-attribute employee 'full-time #t)))
    (and (>= service-period 4)
         full-time)))  ; After 4 months, full-time only

;; =============================================================================
;; DISCRIMINATION HELPERS
;; =============================================================================

(define (unfair-discrimination? treatment)
  "Check if treatment constitutes unfair discrimination
   Cross-reference: equality, dignity (Level 1)"
  (and (differential-treatment? treatment)
       (listed-ground? treatment)
       (not (inherent-job-requirement? treatment))))

(define (differential-treatment? treatment)
  "Check if differential treatment occurred
   Cross-reference: equality (Level 1)"
  (get-attribute treatment 'differential-treatment #f))

(define (listed-ground? treatment)
  "Check if based on listed ground
   Cross-reference: EEA listed grounds (Level 1)"
  (let ((ground (get-attribute treatment 'ground 'unknown)))
    (member-of? ground '(race gender sex pregnancy marital-status
                         ethnic-origin colour sexual-orientation age
                         disability religion hiv-status conscience belief
                         political-opinion culture language birth))))

(define (inherent-job-requirement? treatment)
  "Check if differential treatment is inherent job requirement
   Cross-reference: legitimate business need (Level 1)"
  (let ((inherent (get-attribute treatment 'inherent-requirement #f))
        (legitimate-purpose (get-attribute treatment 'legitimate-purpose #f))
        (proportionate (get-attribute treatment 'proportionate #f)))
    (and inherent
         legitimate-purpose
         proportionate)))

;; =============================================================================
;; COLLECTIVE BARGAINING HELPERS
;; =============================================================================

(define (collective-agreement-binding? agreement)
  "Check if collective agreement is binding
   Cross-reference: pacta-sunt-servanda (Level 1)"
  (let ((signed (get-attribute agreement 'signed #f))
        (parties-bound (get-attribute agreement 'parties-bound #f))
        (registered (get-attribute agreement 'registered #f)))
    (and signed parties-bound)))

(define (bargaining-unit-appropriate? unit)
  "Check if bargaining unit is appropriate
   Cross-reference: collective bargaining principles (Level 1)"
  (let ((sufficient-community-of-interest 
         (get-attribute unit 'community-of-interest #f))
        (viable-size (get-attribute unit 'viable-size #f)))
    (and sufficient-community-of-interest
         viable-size)))

(define (organizational-rights? union)
  "Check if union has organizational rights
   Cross-reference: freedom of association (Level 1)"
  (let ((sufficiently-representative 
         (get-attribute union 'sufficiently-representative #f))
        (registered (get-attribute union 'registered #f)))
    (and sufficiently-representative
         registered)))

;; End of labour law helpers
