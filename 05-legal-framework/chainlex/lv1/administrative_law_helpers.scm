;; =============================================================================
;; ADMINISTRATIVE LAW HELPER FUNCTIONS
;; =============================================================================
;; Version: 1.0
;; Description: Helper functions for administrative law reasoning (PAJA)
;; Derived from Level 1 principles: legality, rationality, procedural-fairness,
;;                                   audi-alteram-partem, nemo-iudex-in-causa-sua
;; =============================================================================

(define-module (chainlex administrative-law-helpers)
  #:use-module (chainlex core-utilities)
  #:export (
    ;; Administrative action helpers
    administrative-action?
    public-nature?
    adversely-affects-rights?
    external-legal-effect?
    
    ;; Lawfulness helpers
    lawful-action?
    empowered-by-law?
    proper-purpose?
    ultra-vires?
    
    ;; Procedural fairness helpers
    procedurally-fair?
    adequate-notice?
    opportunity-to-respond?
    reasons-provided?
    
    ;; Reasonableness helpers
    reasonable-action?
    rational-action?
    proportionate-action?
    
    ;; Grounds for review helpers
    reviewable-action?
    bad-faith?
    irrelevant-considerations?
    arbitrary-or-capricious?
    
    ;; Judicial review helpers
    judicial-review-available?
    locus-standi?
    exhausted-internal-remedies?
    within-time-limits?
    
    ;; Legitimate expectation helpers
    legitimate-expectation?
    procedural-expectation?
    substantive-expectation?
  ))

;; =============================================================================
;; ADMINISTRATIVE ACTION HELPERS
;; =============================================================================

(define (administrative-action? action)
  "Check if action constitutes administrative action under PAJA
   Cross-reference: legality, rule-of-law (Level 1)"
  (and (decision-or-failure? action)
       (public-nature? action)
       (adversely-affects-rights? action)
       (external-legal-effect? action)
       (not-excluded? action)))

(define (decision-or-failure? action)
  "Check if action is decision or failure to act
   Cross-reference: administrative action definition (Level 1)"
  (let ((type (get-attribute action 'type 'unknown)))
    (member-of? type '(decision failure-to-act))))

(define (public-nature? action)
  "Check if action is of public nature
   Cross-reference: public law (Level 1)"
  (let ((nature (get-attribute action 'nature 'unknown))
        (public-body (get-attribute action 'public-body #f))
        (public-power (get-attribute action 'public-power #f)))
    (and (equal? nature 'public)
         (or public-body public-power))))

(define (adversely-affects-rights? action)
  "Check if action adversely affects rights
   Cross-reference: rights protection (Level 1)"
  (let ((affects-rights (get-attribute action 'affects-rights #f))
        (adverse-effect (get-attribute action 'adverse-effect #f)))
    (and affects-rights adverse-effect)))

(define (external-legal-effect? action)
  "Check if action has direct external legal effect
   Cross-reference: legal effect principles (Level 1)"
  (let ((legal-effect (get-attribute action 'legal-effect #f))
        (external (get-attribute action 'external-effect #f))
        (direct (get-attribute action 'direct-effect #f)))
    (and legal-effect external direct)))

(define (not-excluded? action)
  "Check if action is not excluded from PAJA
   Cross-reference: PAJA exclusions (Level 1)"
  (let ((type (get-attribute action 'type 'unknown)))
    (not (member-of? type '(legislative-act judicial-act 
                            executive-policy cabinet-decision)))))

;; =============================================================================
;; LAWFULNESS HELPERS
;; =============================================================================

(define (lawful-action? action)
  "Check if administrative action is lawful
   Cross-reference: legality, rule-of-law (Level 1)"
  (and (empowered-by-law? action)
       (proper-purpose? action)
       (within-scope-of-power? action)
       (not (ultra-vires? action))))

(define (empowered-by-law? action)
  "Check if administrator empowered by law
   Cross-reference: legality (Level 1)"
  (let ((empowering-provision (get-attribute action 'empowering-provision #f))
        (statutory-authority (get-attribute action 'statutory-authority #f)))
    (or empowering-provision statutory-authority)))

(define (proper-purpose? action)
  "Check if action taken for proper purpose
   Cross-reference: legality (Level 1)"
  (let ((purpose (get-attribute action 'purpose 'unknown))
        (authorized-purpose (get-attribute action 'authorized-purpose #f))
        (improper-motive (get-attribute action 'improper-motive #f)))
    (and authorized-purpose
         (not improper-motive))))

(define (within-scope-of-power? action)
  "Check if action within scope of delegated power
   Cross-reference: legality (Level 1)"
  (let ((within-scope (get-attribute action 'within-scope #t))
        (exceeds-authority (get-attribute action 'exceeds-authority #f)))
    (and within-scope
         (not exceeds-authority))))

(define (ultra-vires? action)
  "Check if action is ultra vires (beyond powers)
   Cross-reference: legality (Level 1)"
  (let ((beyond-powers (get-attribute action 'beyond-powers #f))
        (no-authority (get-attribute action 'no-authority #f))
        (exceeds-jurisdiction (get-attribute action 'exceeds-jurisdiction #f)))
    (or beyond-powers no-authority exceeds-jurisdiction)))

;; =============================================================================
;; PROCEDURAL FAIRNESS HELPERS
;; =============================================================================

(define (procedurally-fair? action)
  "Check if action is procedurally fair
   Cross-reference: audi-alteram-partem, procedural-fairness (Level 1)"
  (and (adequate-notice? action)
       (opportunity-to-respond? action)
       (reasons-provided? action)
       (impartial-decision-maker? action)))

(define (adequate-notice? action)
  "Check if adequate notice was given
   Cross-reference: audi-alteram-partem (Level 1)"
  (let ((notice-given (get-attribute action 'notice-given #f))
        (notice-period (get-attribute action 'notice-period 0))
        (clear-statement (get-attribute action 'clear-statement #f)))
    (and notice-given
         (>= notice-period 1)  ; Minimum reasonable notice
         clear-statement)))

(define (opportunity-to-respond? action)
  "Check if opportunity to respond was given
   Cross-reference: audi-alteram-partem (Level 1)"
  (let ((opportunity (get-attribute action 'opportunity-to-respond #f))
        (could-present-case (get-attribute action 'could-present-case #f))
        (submissions-considered (get-attribute action 'submissions-considered #f)))
    (and opportunity
         could-present-case
         submissions-considered)))

(define (reasons-provided? action)
  "Check if reasons for decision were provided
   Cross-reference: rationality, transparency (Level 1)"
  (let ((reasons (get-attribute action 'reasons-provided #f))
        (adequate-reasons (get-attribute action 'adequate-reasons #f)))
    (and reasons adequate-reasons)))

(define (impartial-decision-maker? action)
  "Check if decision-maker was impartial
   Cross-reference: nemo-iudex-in-causa-sua (Level 1)"
  (let ((impartial (get-attribute action 'impartial-decision-maker #t))
        (bias (get-attribute action 'bias #f))
        (conflict-of-interest (get-attribute action 'conflict-of-interest #f)))
    (and impartial
         (not bias)
         (not conflict-of-interest))))

;; =============================================================================
;; REASONABLENESS HELPERS
;; =============================================================================

(define (reasonable-action? action)
  "Check if action is reasonable
   Cross-reference: rationality, proportionality (Level 1)"
  (and (rational-action? action)
       (proportionate-action? action)
       (justifiable-in-circumstances? action)))

(define (rational-action? action)
  "Check if action is rational
   Cross-reference: rationality (Level 1)"
  (let ((rational (get-attribute action 'rational #t))
        (logical-connection (get-attribute action 'logical-connection #f))
        (evidence-based (get-attribute action 'evidence-based #f)))
    (and rational
         logical-connection
         evidence-based)))

(define (proportionate-action? action)
  "Check if action is proportionate
   Cross-reference: proportionality (Level 1)"
  (let ((proportionate (get-attribute action 'proportionate #t))
        (least-restrictive (get-attribute action 'least-restrictive #f))
        (balance-struck (get-attribute action 'balance-struck #f)))
    (and proportionate
         (or least-restrictive balance-struck))))

(define (justifiable-in-circumstances? action)
  "Check if action is justifiable in the circumstances
   Cross-reference: reasonableness (Level 1)"
  (let ((justifiable (get-attribute action 'justifiable #t))
        (circumstances-considered (get-attribute action 'circumstances-considered #f)))
    (and justifiable circumstances-considered)))

;; =============================================================================
;; GROUNDS FOR REVIEW HELPERS
;; =============================================================================

(define (reviewable-action? action)
  "Check if action is reviewable under PAJA section 6
   Cross-reference: legality, procedural-fairness (Level 1)"
  (or (ultra-vires? action)
      (not (lawful-action? action))
      (not (procedurally-fair? action))
      (not (reasonable-action? action))
      (bad-faith? action)
      (irrelevant-considerations? action)
      (arbitrary-or-capricious? action)
      (materially-influenced-by-error? action)))

(define (bad-faith? action)
  "Check if action taken in bad faith
   Cross-reference: bona-fides (Level 1)"
  (let ((bad-faith (get-attribute action 'bad-faith #f))
        (dishonest (get-attribute action 'dishonest #f))
        (corrupt (get-attribute action 'corrupt #f)))
    (or bad-faith dishonest corrupt)))

(define (irrelevant-considerations? action)
  "Check if irrelevant considerations influenced decision
   Cross-reference: rationality (Level 1)"
  (let ((irrelevant-factors (get-attribute action 'irrelevant-factors #f))
        (relevant-factors-ignored (get-attribute action 'relevant-factors-ignored #f)))
    (or irrelevant-factors relevant-factors-ignored)))

(define (arbitrary-or-capricious? action)
  "Check if action is arbitrary or capricious
   Cross-reference: rationality, rule-of-law (Level 1)"
  (let ((arbitrary (get-attribute action 'arbitrary #f))
        (capricious (get-attribute action 'capricious #f))
        (no-rational-basis (get-attribute action 'no-rational-basis #f)))
    (or arbitrary capricious no-rational-basis)))

(define (materially-influenced-by-error? action)
  "Check if action materially influenced by error of law or fact
   Cross-reference: legal correctness (Level 1)"
  (let ((error-of-law (get-attribute action 'error-of-law #f))
        (error-of-fact (get-attribute action 'error-of-fact #f))
        (material (get-attribute action 'material-error #f)))
    (and (or error-of-law error-of-fact)
         material)))

;; =============================================================================
;; JUDICIAL REVIEW HELPERS
;; =============================================================================

(define (judicial-review-available? action applicant)
  "Check if judicial review is available
   Cross-reference: access to justice (Level 1)"
  (and (administrative-action? action)
       (reviewable-action? action)
       (locus-standi? applicant)
       (exhausted-internal-remedies? action)
       (within-time-limits? action)))

(define (locus-standi? applicant)
  "Check if applicant has standing (locus standi)
   Cross-reference: access to justice (Level 1)"
  (let ((sufficient-interest (get-attribute applicant 'sufficient-interest #f))
        (directly-affected (get-attribute applicant 'directly-affected #f))
        (acting-on-behalf-of-others (get-attribute applicant 'acting-on-behalf #f))
        (public-interest (get-attribute applicant 'public-interest #f)))
    (or directly-affected
        sufficient-interest
        acting-on-behalf-of-others
        public-interest)))

(define (exhausted-internal-remedies? action)
  "Check if internal remedies have been exhausted
   Cross-reference: procedural requirements (Level 1)"
  (let ((no-internal-remedy (get-attribute action 'no-internal-remedy #f))
        (internal-remedy-exhausted (get-attribute action 'internal-remedy-exhausted #f))
        (exceptional-circumstances (get-attribute action 'exceptional-circumstances #f)))
    (or no-internal-remedy
        internal-remedy-exhausted
        exceptional-circumstances)))

(define (within-time-limits? action)
  "Check if review application within time limits
   Cross-reference: procedural requirements (Level 1)"
  (let ((days-since-action (get-attribute action 'days-since-action 0))
        (reasonable-time (get-attribute action 'reasonable-time #t)))
    (and (<= days-since-action 180)  ; 180 days under PAJA
         reasonable-time)))

;; =============================================================================
;; LEGITIMATE EXPECTATION HELPERS
;; =============================================================================

(define (legitimate-expectation? expectation)
  "Check if legitimate expectation exists
   Cross-reference: procedural-fairness, reliance (Level 1)"
  (or (procedural-expectation? expectation)
      (substantive-expectation? expectation)))

(define (procedural-expectation? expectation)
  "Check if procedural legitimate expectation exists
   Cross-reference: audi-alteram-partem (Level 1)"
  (let ((clear-representation (get-attribute expectation 'clear-representation #f))
        (relied-upon (get-attribute expectation 'relied-upon #f))
        (expectation-of-procedure (get-attribute expectation 'expectation-of-procedure #f)))
    (and clear-representation
         relied-upon
         expectation-of-procedure)))

(define (substantive-expectation? expectation)
  "Check if substantive legitimate expectation exists
   Cross-reference: procedural-fairness, reliance (Level 1)"
  (let ((clear-representation (get-attribute expectation 'clear-representation #f))
        (relied-upon (get-attribute expectation 'relied-upon #f))
        (expectation-of-outcome (get-attribute expectation 'expectation-of-outcome #f))
        (detrimental-reliance (get-attribute expectation 'detrimental-reliance #f)))
    (and clear-representation
         relied-upon
         expectation-of-outcome
         detrimental-reliance)))

;; End of administrative law helpers
