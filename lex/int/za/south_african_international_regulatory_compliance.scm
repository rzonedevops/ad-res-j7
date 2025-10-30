;; South African International Regulatory Compliance
;; Cross-border regulatory compliance framework for AD-RES-J7 case
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
   'name "South African International Regulatory Compliance"
   'jurisdiction '("za" "uk" "eu")
   'legal-domain '(regulatory-compliance international-law product-safety)
   'version "1.0"
   'last-updated "2025-10-30"
   'derived-from-level 1
   'confidence-base 0.95
   'language "en"
   'case-application "AD-RES-J7 (Case 2025-137857)"))

;; =============================================================================
;; CRITICAL: EU RESPONSIBLE PERSON DUTY
;; =============================================================================

(define eu-responsible-person-duty
  (make-principle
   'name 'eu-responsible-person-duty
   'description "Duties of EU Responsible Person under Cosmetics Regulation 1223/2009"
   'domain '(regulatory-compliance international-law product-safety)
   'confidence 0.96
   'jurisdiction '("eu" "za")
   'statutory-basis "EU Regulation 1223/2009, Articles 4-5"
   'duties '(ensure-product-safety
            maintain-product-information-file
            report-adverse-events
            notify-cpnp
            ensure-compliance-all-markets
            maintain-documentation-10-years
            respond-to-market-surveillance
            implement-corrective-actions)
   'consequences-non-compliance '(market-withdrawal
                                 criminal-penalties
                                 civil-liability
                                 reputational-damage
                                 loss-of-market-access)
   'infrastructure-requirements '(compliance-documentation-systems
                                 adverse-event-reporting-systems
                                 market-surveillance-tools
                                 pif-maintenance-systems
                                 cpnp-notification-infrastructure
                                 multi-jurisdiction-tracking)
   'case-application "Dan's role as EU RP for 37 jurisdictions requires comprehensive IT infrastructure"
   'related-principles '(regulatory-compliance-necessity regulatory-compliance-cost-reasonableness)
   'inference-type 'deductive
   'base-principles (list pacta-sunt-servanda)))

;; =============================================================================
;; CRITICAL: REGULATORY COMPLIANCE NECESSITY
;; =============================================================================

(define regulatory-compliance-necessity
  (make-principle
   'name 'regulatory-compliance-necessity
   'description "Test for whether regulatory compliance is necessary and unavoidable"
   'domain '(regulatory-compliance necessity)
   'confidence 0.97
   'jurisdiction "za"
   'statutory-basis "Common law business necessity"
   'elements '(legal-obligation-exists
              severe-consequences-for-non-compliance
              no-reasonable-alternative
              compliance-proportionate-to-business)
   'inference "If all elements satisfied, compliance costs are necessary business expenses"
   'case-application "EU RP duties mandatory for market access; severe consequences for non-compliance"
   'related-principles '(business-judgment-rule regulatory-compliance-cost-reasonableness)
   'inference-type 'deductive
   'base-principles (list pacta-sunt-servanda)))

;; =============================================================================
;; HIGH: REGULATORY COMPLIANCE COST REASONABLENESS
;; =============================================================================

(define regulatory-compliance-cost-reasonableness
  (make-principle
   'name 'regulatory-compliance-cost-reasonableness
   'description "Test for whether regulatory compliance costs are reasonable"
   'domain '(regulatory-compliance cost-analysis)
   'confidence 0.94
   'jurisdiction "za"
   'statutory-basis "Companies Act 71/2008 s76 (director duty of care)"
   'factors '(industry-benchmarks
             revenue-percentage
             complexity-of-operations
             number-of-jurisdictions
             consequences-of-non-compliance
             alternative-cost-comparison)
   'benchmarks '((e-commerce-it-spend-percentage 5 10)
                (international-operations-it-spend-percentage 8 12)
                (regulatory-heavy-industries-compliance-percentage 10 15))
   'inference "Costs within industry benchmarks presumed reasonable"
   'case-application "Dan's R8.85M/18mo = R5.9M annually = 4.6% of R128M revenue (within 5-10% benchmark)"
   'related-principles '(business-judgment-rule regulatory-compliance-necessity)
   'inference-type 'inductive
   'base-principles (list business-judgment-rule)))

;; =============================================================================
;; HIGH: CROSS-BORDER DIRECTOR DUTIES
;; =============================================================================

(define cross-border-director-duties
  (make-principle
   'name 'cross-border-director-duties
   'description "Duties of directors managing multi-jurisdiction operations"
   'domain '(company director-duties international-operations)
   'confidence 0.93
   'jurisdiction '("za" "uk" "eu")
   'statutory-basis "Companies Act 71/2008 s76, UK Companies Act 2006, EU regulations"
   'duties '(compliance-with-all-applicable-laws
            understanding-foreign-regulations
            implementing-compliance-systems
            monitoring-regulatory-changes
            coordinating-cross-border-operations
            managing-foreign-subsidiaries
            transfer-pricing-compliance
            tax-compliance-all-jurisdictions)
   'standard-of-care "Higher standard for international operations due to complexity"
   'case-application "Dan managing ZA entities with UK subsidiaries and EU compliance obligations"
   'related-principles '(director-duty-of-care business-judgment-rule regulatory-compliance-necessity)
   'inference-type 'deductive
   'base-principles (list director-duty-of-care)))

;; =============================================================================
;; PLACEHOLDER FUNCTIONS FOR FUTURE IMPLEMENTATION
;; =============================================================================

(define (evaluate-eu-rp-compliance operations infrastructure documentation)
  ;; Evaluate whether EU RP duties are being met
  ;; Returns: (compliant? gaps infrastructure-adequacy)
  'placeholder)

(define (assess-compliance-necessity regulation business-operations consequences)
  ;; Assess whether regulatory compliance is necessary
  ;; Returns: (necessary? elements justification)
  'placeholder)

(define (evaluate-compliance-cost-reasonableness costs revenue industry benchmarks)
  ;; Evaluate whether compliance costs are reasonable
  ;; Returns: (reasonable? comparison-to-benchmarks)
  'placeholder)

(define (analyze-cross-border-director-duties operations jurisdictions compliance-systems)
  ;; Analyze whether director meeting cross-border duties
  ;; Returns: (compliant? duties-met gaps)
  'placeholder)

;; =============================================================================
;; INTEGRATION WITH HYPERGRAPHQL
;; =============================================================================

;; Register all principles with the principle registry
(register-principle! eu-responsible-person-duty)
(register-principle! regulatory-compliance-necessity)
(register-principle! regulatory-compliance-cost-reasonableness)
(register-principle! cross-border-director-duties)

;; Export principles for use in other modules
(provide eu-responsible-person-duty
         regulatory-compliance-necessity
         regulatory-compliance-cost-reasonableness
         cross-border-director-duties)

;; =============================================================================
;; END OF MODULE
;; =============================================================================
