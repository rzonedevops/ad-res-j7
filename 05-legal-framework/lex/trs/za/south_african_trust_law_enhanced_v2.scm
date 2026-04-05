;; South African Trust Law - Enhanced v2
;; Specialized module for trust power abuse and beneficiary protection in AD-RES-J7 case
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
   'name "South African Trust Law - Enhanced v2"
   'jurisdiction "za"
   'legal-domain '(trust fiduciary)
   'version "2.0"
   'last-updated "2025-10-30"
   'derived-from-level 1
   'confidence-base 0.95
   'language "en"
   'case-application "AD-RES-J7 (Case 2025-137857)"))

;; =============================================================================
;; CRITICAL: TRUST POWER BYPASS INDICATORS
;; =============================================================================

(define trust-power-bypass-indicators
  (make-principle
   'name 'trust-power-bypass-indicators
   'description "Indicators that trustee bypasses direct trust powers for ulterior motives"
   'domain '(trust fiduciary abuse-of-process)
   'confidence 0.94
   'jurisdiction "za"
   'statutory-basis "Trust Property Control Act 57/1988, common law fiduciary duties"
   'indicators '(trustee-has-absolute-powers
                trustee-seeks-court-relief-instead
                beneficiary-is-target-of-relief
                timing-coincides-with-settlement-negotiation
                manufactured-urgency
                no-internal-resolution-attempt)
   'inference "Seeking court relief when direct power exists suggests ulterior motive beyond trust administration"
   'case-application "Peter has absolute trust powers but seeks interdict against beneficiary Jax during settlement negotiation"
   'related-principles '(proper-purpose-test abuse-of-process trustee-conflict-prohibition)
   'inference-type 'abductive
   'base-principles (list fiduciary-duty)))

;; =============================================================================
;; CRITICAL: BENEFICIARY ADVERSE ACTION PROHIBITION (ENHANCED)
;; =============================================================================

(define beneficiary-adverse-action-prohibition-enhanced
  (make-principle
   'name 'beneficiary-adverse-action-prohibition-enhanced
   'description "Prohibition on trustee taking adverse legal action against beneficiary"
   'domain '(trust fiduciary conflict-of-interest)
   'confidence 0.97
   'jurisdiction "za"
   'statutory-basis "Trust Property Control Act 57/1988 s9, common law fiduciary duties"
   'prohibition "Trustee cannot use trust powers or position to attack beneficiary through legal proceedings"
   'elements '(trustee-initiates-legal-action
              beneficiary-is-target
              action-uses-trust-position-or-powers
              conflict-with-fiduciary-duty
              no-beneficiary-consent)
   'remedies '(set-aside-action
              remove-trustee
              damages-for-breach-of-fiduciary-duty)
   'case-application "Peter (Trustee) and Danie (Co-Trustee) include Jax (Beneficiary) in interdict for 'helping Daniel'"
   'aggravating-factors '(beneficiary-punished-for-supporting-another-beneficiary
                         timing-after-beneficiary-cooperation
                         weaponization-of-trust-position)
   'related-principles '(trustee-conflict-prohibition fiduciary-duty-of-loyalty)
   'inference-type 'deductive
   'base-principles (list fiduciary-duty)))

;; =============================================================================
;; HIGH: TRUST ASSET ABANDONMENT INDICATORS
;; =============================================================================

(define trust-asset-abandonment-indicators
  (make-principle
   'name 'trust-asset-abandonment-indicators
   'description "Indicators that trustees are abandoning or neglecting trust assets"
   'domain '(trust trustee-duties)
   'confidence 0.93
   'jurisdiction "za"
   'statutory-basis "Trust Property Control Act 57/1988 s9"
   'indicators '(trust-asset-generating-no-revenue
                trust-asset-accumulating-liabilities
                trustees-not-managing-asset
                expenses-dumped-on-trust-asset
                revenue-diverted-from-trust-asset
                no-trustee-oversight-of-asset
                asset-value-declining
                creditors-pursuing-trust-asset)
   'fiduciary-breach "Trustees must actively manage and protect trust assets"
   'case-application "RWD (trust asset): no stock/inventory/assets, expense dumping recipient, revenue diverted, accumulating losses"
   'related-principles '(trustee-duty-of-care trust-asset-protection)
   'inference-type 'inductive
   'base-principles (list fiduciary-duty)))

;; =============================================================================
;; HIGH: BACKDATING INDICATORS
;; =============================================================================

(define backdating-indicators
  (make-principle
   'name 'backdating-indicators
   'description "Indicators of improper backdating of legal documents"
   'domain '(trust corporate-governance fraud)
   'confidence 0.95
   'jurisdiction "za"
   'statutory-basis "Common law fraud, misrepresentation"
   'red-flags '(document-signed-after-stated-effective-date
               effective-date-strategically-chosen
               no-contemporaneous-evidence
               timing-benefits-specific-party
               pattern-of-backdating
               lack-of-disclosure)
   'case-application "Jax signs 11 Aug 2025 backdating Peter's Main Trustee designation to 1 Jul 2025; Peter and Danie include Jax in interdict 13 Aug"
   'inference "Backdating to establish authority for prior actions or upcoming legal maneuvers"
   'related-principles '(fraud-indicators material-misrepresentation)
   'inference-type 'abductive
   'base-principles (list fraud-indicators)))

;; =============================================================================
;; HIGH: ULTERIOR MOTIVE ANALYSIS
;; =============================================================================

(define ulterior-motive-analysis
  (make-principle
   'name 'ulterior-motive-analysis
   'description "Framework for analyzing whether action has ulterior motive"
   'domain '(civil-procedure abuse-of-process bad-faith)
   'confidence 0.92
   'jurisdiction "za"
   'statutory-basis "Common law abuse of process"
   'factors '(stated-purpose-achievable-by-simpler-means
             timing-coincides-with-other-objectives
             action-disproportionate-to-stated-purpose
             pattern-of-similar-actions
             beneficiary-of-action-different-from-stated
             no-reasonable-explanation-for-chosen-method)
   'inference "When simpler means available but not used, suggests ulterior motive"
   'case-application "Peter has absolute trust powers but seeks court interdict during settlement negotiation"
   'related-principles '(abuse-of-process trust-power-bypass-indicators proper-purpose-test)
   'inference-type 'abductive
   'base-principles (list proper-purpose)))

;; =============================================================================
;; MEDIUM: TRUSTEE DISCLOSURE REQUIREMENT
;; =============================================================================

(define trustee-disclosure-requirement
  (make-principle
   'name 'trustee-disclosure-requirement
   'description "Requirement for trustees to be disclosed to beneficiaries"
   'domain '(trust disclosure transparency)
   'confidence 0.96
   'jurisdiction "za"
   'statutory-basis "Trust Property Control Act 57/1988, common law fiduciary duties"
   'requirement "All trustees must be disclosed to beneficiaries"
   'rationale "Beneficiaries cannot protect their interests if they don't know who trustees are"
   'case-application "Bantjies unknown trustee status - lack of disclosure to beneficiaries"
   'remedies '(compel-disclosure
              set-aside-trustee-actions
              remove-undisclosed-trustee)
   'related-principles '(transparency-principle beneficiary-rights)
   'inference-type 'deductive
   'base-principles (list fiduciary-duty)))

;; =============================================================================
;; MEDIUM: TRUST DISTRIBUTION AUTHORIZATION TEST
;; =============================================================================

(define trust-distribution-authorization-test
  (make-principle
   'name 'trust-distribution-authorization-test
   'description "Test for whether trust distribution was properly authorized"
   'domain '(trust trust-administration)
   'confidence 0.95
   'jurisdiction "za"
   'statutory-basis "Trust Property Control Act 57/1988, Trust Deed"
   'elements '(trustee-has-discretion
              distribution-within-trust-deed-terms
              beneficiary-entitled
              proper-trustee-resolution
              no-conflict-of-interest)
   'burden-of-proof "Trustee must prove proper authorization"
   'case-application "R500K payment to Jax - analysis of authorization"
   'related-principles '(trustee-discretion beneficiary-entitlement)
   'inference-type 'deductive
   'base-principles (list fiduciary-duty)))

;; =============================================================================
;; PLACEHOLDER FUNCTIONS FOR FUTURE IMPLEMENTATION
;; =============================================================================

(define (detect-trust-power-bypass trustee-powers court-action timing context)
  ;; Analyze whether trustee is bypassing direct powers
  ;; Returns: (bypass-detected? indicators confidence)
  'placeholder)

(define (evaluate-beneficiary-adverse-action trustee-action beneficiary trust-relationship)
  ;; Evaluate whether trustee action violates beneficiary protection
  ;; Returns: (violation? elements aggravating-factors)
  'placeholder)

(define (analyze-trust-asset-abandonment trust-asset financial-data trustee-actions)
  ;; Analyze whether trustees are abandoning trust asset
  ;; Returns: (abandonment? indicators confidence)
  'placeholder)

(define (detect-backdating document stated-date actual-date context)
  ;; Detect improper backdating of documents
  ;; Returns: (backdating-detected? red-flags confidence)
  'placeholder)

(define (analyze-ulterior-motive action stated-purpose available-alternatives context)
  ;; Analyze whether action has ulterior motive
  ;; Returns: (ulterior-motive? factors confidence)
  'placeholder)

(define (verify-trustee-disclosure trustees beneficiaries disclosure-records)
  ;; Verify whether all trustees properly disclosed
  ;; Returns: (compliant? undisclosed-trustees)
  'placeholder)

(define (evaluate-distribution-authorization distribution trust-deed trustee-resolution)
  ;; Evaluate whether distribution properly authorized
  ;; Returns: (authorized? elements confidence)
  'placeholder)

;; =============================================================================
;; INTEGRATION WITH HYPERGRAPHQL
;; =============================================================================

;; Register all principles with the principle registry
(register-principle! trust-power-bypass-indicators)
(register-principle! beneficiary-adverse-action-prohibition-enhanced)
(register-principle! trust-asset-abandonment-indicators)
(register-principle! backdating-indicators)
(register-principle! ulterior-motive-analysis)
(register-principle! trustee-disclosure-requirement)
(register-principle! trust-distribution-authorization-test)

;; Export principles for use in other modules
(provide trust-power-bypass-indicators
         beneficiary-adverse-action-prohibition-enhanced
         trust-asset-abandonment-indicators
         backdating-indicators
         ulterior-motive-analysis
         trustee-disclosure-requirement
         trust-distribution-authorization-test)

;; =============================================================================
;; END OF MODULE
;; =============================================================================
