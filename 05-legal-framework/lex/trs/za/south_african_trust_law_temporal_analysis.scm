;; South African Trust Law - Temporal Analysis Framework
;; Enhanced framework for temporal pattern analysis in trust law
;; =============================================================================

;; Import Level 1 first-order principles
(require "../../lv1/known_laws.scm")

;; Initialize principle registry
(initialize-principle-registry!)

;; =============================================================================
;; FRAMEWORK METADATA
;; =============================================================================

(define framework-metadata
  (make-hash-table
   'name "South African Trust Law - Temporal Analysis"
   'jurisdiction "za"
   'legal-domain '(trust fiduciary temporal-analysis)
   'version "1.0"
   'last-updated "2025-10-31"
   'derived-from-level 1
   'confidence-base 0.95
   'language "en"
   'case-application "2025-137857 (Peter Faucitt v. Jacqueline & Daniel Faucitt)"))

;; =============================================================================
;; PRINCIPLE 1: TRUST POWER BYPASS TEMPORAL ANALYSIS
;; =============================================================================

(define trust-power-bypass-temporal-analysis
  (make-principle
   'name 'trust-power-bypass-temporal-analysis
   'description "Temporal analysis of trustee seeking court relief when direct powers exist"
   'domain '(trust fiduciary abuse-of-process temporal-analysis)
   'confidence 0.95
   'jurisdiction "za"
   'statutory-basis "Trust Property Control Act 57/1988, abuse of process doctrine"
   'base-principles (list fiduciary-duty proper-purpose-test)
   'inference-type 'abductive
   'indicators '(trustee-has-absolute-powers
                trustee-seeks-court-relief-instead
                beneficiary-is-target-of-relief
                timing-coincides-with-settlement
                timing-coincides-with-backdating
                manufactured-urgency)
   'temporal-correlations '((backdating-signed settlement-discussion interdict-filed) 
                           (days-between 0 2))
   'red-flags '((days-between-backdating-and-interdict <= 2)
               (days-between-settlement-and-interdict <= 2)
               (beneficiary-signed-backdating-then-targeted true))
   'inference "Seeking court relief within 2 days of backdating and settlement suggests ulterior motive and abuse of process"
   'case-application "Peter seeks interdict 13 Aug 2025, 2 days after Jax signs backdating 11 Aug 2025, same day as settlement discussion"
   'evidence-required '(trust-deed-showing-powers
                       court-application
                       backdating-document-with-date
                       settlement-correspondence-with-date
                       timeline-correlation-analysis)
   'legal-consequences '(abuse-of-process
                        bad-faith-indicator
                        ulterior-motive-evidence
                        proper-purpose-violation)
   'related-principles '(trust-power-bypass-indicators 
                        proper-purpose-test 
                        abuse-of-process
                        beneficiary-adverse-action-prohibition)))

(register-principle! trust-power-bypass-temporal-analysis)

;; =============================================================================
;; PRINCIPLE 2: BACKDATING COERCION INDICATORS
;; =============================================================================

(define backdating-coercion-indicators
  (make-principle
   'name 'backdating-coercion-indicators
   'description "Indicators of coercion when backdating is followed by adverse action against signer"
   'domain '(trust civil coercion temporal-analysis)
   'confidence 0.96
   'jurisdiction "za"
   'statutory-basis "Common law coercion doctrine, Trust Property Control Act 57/1988"
   'base-principles (list fiduciary-duty)
   'inference-type 'abductive
   'indicators '(document-backdated
                signer-is-beneficiary
                adverse-action-against-signer-follows
                timing-correlation-strong
                signer-had-no-benefit-from-backdating
                beneficiary-in-vulnerable-position
                trustee-gains-power-from-backdating)
   'temporal-threshold '(days 2)
   'red-flags '((days-between-signing-and-adverse-action <= 2)
               (signer-is-beneficiary true)
               (signer-benefits-from-backdating false)
               (trustee-gains-power true))
   'inference "Adverse action against backdating signer within 2 days suggests document was signed under coercion or duress"
   'case-application "Jax (beneficiary) signs backdating Peter's Main Trustee status 11 Aug 2025; Peter includes Jax in interdict 13 Aug 2025 (2 days later)"
   'evidence-required '(backdated-document-with-signatures
                       adverse-action-document-with-date
                       timeline-showing-correlation
                       analysis-of-who-benefits
                       beneficiary-vulnerability-evidence)
   'legal-consequences '(coercion-inference
                        document-validity-challenge
                        bad-faith-indicator
                        fiduciary-duty-breach)
   'related-principles '(backdating-indicators 
                        coercion-indicators 
                        beneficiary-adverse-action-prohibition
                        fiduciary-duty)))

(register-principle! backdating-coercion-indicators)

;; =============================================================================
;; PRINCIPLE 3: BENEFICIARY PROTECTION WHEN ATTACKED
;; =============================================================================

(define beneficiary-protection-when-attacked
  (make-principle
   'name 'beneficiary-protection-when-attacked
   'description "Protection for beneficiaries when trustees attack them instead of managing trust assets"
   'domain '(trust fiduciary beneficiary-rights)
   'confidence 0.96
   'jurisdiction "za"
   'statutory-basis "Trust Property Control Act 57/1988, fiduciary duty doctrine"
   'base-principles (list fiduciary-duty)
   'inference-type 'deductive
   'rule "Trustees have duty to protect and benefit beneficiaries, not attack them"
   'indicators '(trustee-initiates-legal-action-against-beneficiary
                beneficiary-punished-for-supporting-another-beneficiary
                trust-assets-neglected-while-attacking-beneficiaries
                no-legitimate-trust-purpose
                beneficiary-acting-in-trust-interest)
   'red-flags '((trustee-sues-beneficiary true)
               (trust-assets-deteriorating true)
               (beneficiary-supporting-another-beneficiary true)
               (legitimate-trust-purpose false))
   'inference "Trustee attacking beneficiary while neglecting trust assets is fundamental breach of fiduciary duty"
   'case-application "Peter (Trustee) includes Jax (Beneficiary) in interdict for 'helping Daniel' (another Beneficiary) while RWD (trust asset) deteriorates"
   'evidence-required '(court-application-against-beneficiary
                       trust-asset-status-showing-neglect
                       beneficiary-actions-supporting-trust
                       lack-of-legitimate-trust-purpose)
   'legal-consequences '(fiduciary-duty-breach
                        beneficiary-protection-order
                        trustee-removal-grounds
                        damages-claim)
   'remedies '(interdict-dismissal
              trustee-removal
              beneficiary-protection-order
              damages-for-breach)
   'related-principles '(fiduciary-duty 
                        beneficiary-adverse-action-prohibition 
                        trust-asset-abandonment-indicators
                        proper-purpose-test)))

(register-principle! beneficiary-protection-when-attacked)

;; =============================================================================
;; HELPER FUNCTIONS
;; =============================================================================

(define (calculate-days-between date1 date2)
  "Calculate days between two dates"
  ;; Placeholder for date calculation
  (abs (- (date->days date2) (date->days date1))))

(define (temporal-correlation-exists? event1 event2 threshold-days)
  "Check if temporal correlation exists between two events"
  (let ((days-between (calculate-days-between 
                       (get-attribute event1 'date)
                       (get-attribute event2 'date))))
    (<= days-between threshold-days)))

(define (analyze-trust-power-bypass case-facts)
  "Analyze case for trust power bypass indicators with temporal analysis"
  (let ((has-powers (get-attribute case-facts 'trustee-has-absolute-powers))
        (seeks-court (get-attribute case-facts 'trustee-seeks-court-relief))
        (backdating-date (get-attribute case-facts 'backdating-date))
        (interdict-date (get-attribute case-facts 'interdict-date))
        (settlement-date (get-attribute case-facts 'settlement-date)))
    (and has-powers
         seeks-court
         (temporal-correlation-exists? 
          backdating-date interdict-date 2)
         (temporal-correlation-exists? 
          settlement-date interdict-date 2))))

(define (analyze-backdating-coercion case-facts)
  "Analyze case for backdating coercion indicators"
  (let ((document-backdated (get-attribute case-facts 'document-backdated))
        (signer-is-beneficiary (get-attribute case-facts 'signer-is-beneficiary))
        (signing-date (get-attribute case-facts 'signing-date))
        (adverse-action-date (get-attribute case-facts 'adverse-action-date))
        (signer-benefits (get-attribute case-facts 'signer-benefits)))
    (and document-backdated
         signer-is-beneficiary
         (not signer-benefits)
         (temporal-correlation-exists? 
          signing-date adverse-action-date 2))))

(define (analyze-beneficiary-attack case-facts)
  "Analyze case for beneficiary attack indicators"
  (let ((trustee-sues (get-attribute case-facts 'trustee-initiates-legal-action))
        (target-is-beneficiary (get-attribute case-facts 'target-is-beneficiary))
        (assets-neglected (get-attribute case-facts 'trust-assets-neglected))
        (legitimate-purpose (get-attribute case-facts 'legitimate-trust-purpose)))
    (and trustee-sues
         target-is-beneficiary
         assets-neglected
         (not legitimate-purpose))))

;; =============================================================================
;; CONFIDENCE CALCULATION
;; =============================================================================

(define (compute-temporal-analysis-confidence base-confidence temporal-factors)
  "Compute confidence for temporal analysis based on correlation strength"
  (let ((correlation-strength (get-attribute temporal-factors 'correlation-strength))
        (evidence-quality (get-attribute temporal-factors 'evidence-quality))
        (pattern-consistency (get-attribute temporal-factors 'pattern-consistency)))
    (* base-confidence 
       correlation-strength 
       evidence-quality 
       pattern-consistency)))

;; =============================================================================
;; CASE APPLICATION FUNCTIONS
;; =============================================================================

(define (apply-temporal-trust-principles case-facts)
  "Apply all temporal trust principles to case facts"
  (list
   (list 'trust-power-bypass-temporal-analysis
         (analyze-trust-power-bypass case-facts)
         (compute-temporal-analysis-confidence 0.95 case-facts))
   (list 'backdating-coercion-indicators
         (analyze-backdating-coercion case-facts)
         (compute-temporal-analysis-confidence 0.96 case-facts))
   (list 'beneficiary-protection-when-attacked
         (analyze-beneficiary-attack case-facts)
         (compute-temporal-analysis-confidence 0.96 case-facts))))

;; =============================================================================
;; EXPORT PRINCIPLES
;; =============================================================================

(provide trust-power-bypass-temporal-analysis
         backdating-coercion-indicators
         beneficiary-protection-when-attacked
         analyze-trust-power-bypass
         analyze-backdating-coercion
         analyze-beneficiary-attack
         apply-temporal-trust-principles)
