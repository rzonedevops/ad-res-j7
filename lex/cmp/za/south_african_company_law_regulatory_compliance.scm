;; =============================================================================
;; South African Company Law - Regulatory Compliance Framework
;; =============================================================================
;; Version: 1.0
;; Last Updated: 2025-10-28
;; Case-Specific Enhancements: Faucitt v. Faucitt (2025-137857)
;; Purpose: EU Responsible Person duties and regulatory compliance cost analysis
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
   'name "South African Company Law - Regulatory Compliance"
   'jurisdiction "za-eu"
   'legal-domain '(company regulatory-compliance international-law)
   'version "1.0"
   'last-updated "2025-10-28"
   'derived-from-level 1
   'confidence-base 0.93
   'statutory-basis "EU Regulation 1223/2009, Companies Act 71 of 2008"
   'language "en"
   'case-specific-enhancements "Faucitt v. Faucitt - Dan's EU Responsible Person duties"))

;; =============================================================================
;; PART 1: EU RESPONSIBLE PERSON DUTIES
;; =============================================================================

;; -----------------------------------------------------------------------------
;; 1.1 Core Regulatory Duties
;; -----------------------------------------------------------------------------

(define eu-responsible-person-duty
  (make-principle
   'name 'eu-responsible-person-duty
   'description "Duties of EU Responsible Person under Cosmetics Regulation 1223/2009"
   'domain '(regulatory-compliance international-law)
   'confidence 0.93
   'jurisdiction "eu"
   'statutory-basis "EU Regulation 1223/2009 on Cosmetic Products, Article 4"
   'provenance "EU law, mandatory for cosmetics market access"
   'duties '(product-safety-assessment
            compliance-documentation
            adverse-event-reporting
            market-surveillance-cooperation
            product-information-file-maintenance
            labeling-compliance
            notification-to-cpnp
            post-market-surveillance)
   'compliance-requirements '(technical-documentation-systems
                              safety-assessment-infrastructure
                              regulatory-monitoring-systems
                              communication-platforms
                              database-management-systems
                              reporting-infrastructure)
   'case-application "Dan appointed as EU Responsible Person for RegimA products"
   'legal-consequence "Personal liability for non-compliance, product recalls, market access loss"
   'related-principles '(director-duty-of-care professional-standard regulatory-compliance-necessity)
   'inference-type 'deductive))

(define product-safety-assessment-duty
  (make-principle
   'name 'product-safety-assessment-duty
   'description "Responsible Person must ensure product safety assessment completed"
   'domain '(regulatory-compliance product-safety)
   'confidence 0.94
   'jurisdiction "eu"
   'statutory-basis "EU Regulation 1223/2009, Article 10"
   'requirements '(safety-assessor-qualification
                  scientific-evaluation
                  toxicological-assessment
                  documentation-of-assessment
                  regular-updates)
   'technical-infrastructure-needed '(document-management-system
                                     safety-data-storage
                                     version-control-system
                                     assessment-tracking-database)
   'case-application "Dan requires IT systems to manage safety assessments"
   'inference-type 'deductive))

(define product-information-file-duty
  (make-principle
   'name 'product-information-file-duty
   'description "Responsible Person must maintain Product Information File (PIF)"
   'domain '(regulatory-compliance documentation)
   'confidence 0.94
   'jurisdiction "eu"
   'statutory-basis "EU Regulation 1223/2009, Article 11"
   'pif-contents '(product-description
                  safety-assessment-report
                  manufacturing-method
                  proof-of-claimed-effects
                  animal-testing-data
                  adverse-event-records)
   'accessibility-requirement "PIF must be readily accessible to authorities"
   'technical-infrastructure-needed '(secure-document-storage
                                     rapid-retrieval-system
                                     multi-location-access
                                     audit-trail-system)
   'case-application "Dan requires document management systems for PIF compliance"
   'inference-type 'deductive))

(define adverse-event-reporting-duty
  (make-principle
   'name 'adverse-event-reporting-duty
   'description "Responsible Person must report serious undesirable effects"
   'domain '(regulatory-compliance product-safety)
   'confidence 0.95
   'jurisdiction "eu"
   'statutory-basis "EU Regulation 1223/2009, Article 23"
   'reporting-requirements '(immediate-notification
                            investigation-of-incident
                            corrective-action-implementation
                            documentation-of-response)
   'technical-infrastructure-needed '(monitoring-system
                                     alert-notification-system
                                     reporting-platform
                                     incident-tracking-database)
   'case-application "Dan requires monitoring and reporting systems for adverse events"
   'inference-type 'deductive))

;; -----------------------------------------------------------------------------
;; 1.2 Regulatory Compliance Cost Framework
;; -----------------------------------------------------------------------------

(define regulatory-compliance-cost-reasonableness
  (make-principle
   'name 'regulatory-compliance-cost-reasonableness
   'description "Test for whether regulatory compliance costs are reasonable"
   'domain '(regulatory-compliance company director-duties)
   'confidence 0.94
   'jurisdiction "za"
   'statutory-basis "Companies Act 71 of 2008, s76 (director duty of care)"
   'test-elements '(regulatory-requirement-exists
                   cost-necessary-for-compliance
                   cost-proportionate-to-requirement
                   no-less-expensive-alternative
                   compliance-failure-consequences-severe)
   'burden-of-proof "Director must prove regulatory necessity if challenged"
   'case-application "Dan's R8.85M IT expenses over 18 months (PARA 7.2-7.5)"
   'defense-elements '(mandatory-regulatory-duty
                      technical-infrastructure-required
                      no-viable-alternative
                      market-access-dependent-on-compliance
                      personal-liability-for-non-compliance)
   'related-principles '(business-judgment-rule director-duty-of-care professional-standard)
   'inference-type 'deductive))

(define regulatory-compliance-necessity
  (make-principle
   'name 'regulatory-compliance-necessity
   'description "Principle that regulatory compliance costs are necessary business expenses"
   'domain '(regulatory-compliance company)
   'confidence 0.95
   'jurisdiction "za"
   'principle "Costs necessary for regulatory compliance are legitimate business expenses"
   'rationale "Companies operating in regulated industries must comply or lose market access"
   'application-context "Director incurring costs for mandatory regulatory compliance"
   'defense "Compliance costs cannot be questioned without proving alternative compliance method"
   'case-application "Dan's IT expenses for EU Responsible Person duties"
   'related-principles '(business-judgment-rule operational-necessity)
   'inference-type 'deductive))

(define compliance-cost-proportionality-test
  (make-principle
   'name 'compliance-cost-proportionality-test
   'description "Test for whether compliance costs are proportionate to regulatory requirements"
   'domain '(regulatory-compliance company)
   'confidence 0.92
   'jurisdiction "za"
   'test-factors '(magnitude-of-regulatory-requirement
                  complexity-of-compliance-obligations
                  market-value-of-compliance
                  consequences-of-non-compliance
                  industry-standard-costs)
   'proportionality-indicators '(cost-vs-market-access-value
                                cost-vs-non-compliance-penalties
                                cost-vs-industry-benchmarks
                                cost-vs-regulatory-complexity)
   'case-application "R8.85M IT expenses vs. EU market access value and non-compliance penalties"
   'inference-type 'deductive))

;; -----------------------------------------------------------------------------
;; 1.3 Cross-Border Regulatory Compliance
;; -----------------------------------------------------------------------------

(define cross-border-regulatory-duty
  (make-principle
   'name 'cross-border-regulatory-duty
   'description "Director duty to comply with regulations in all operating jurisdictions"
   'domain '(company international-law regulatory-compliance)
   'confidence 0.92
   'jurisdiction "za-eu"
   'duty "Director must ensure compliance with regulations in all jurisdictions where company operates"
   'complexity-factors '(multiple-regulatory-regimes
                        conflicting-requirements
                        language-barriers
                        different-enforcement-standards
                        cross-border-coordination-needs)
   'cost-implications '(multiple-compliance-systems
                       translation-services
                       legal-advice-multiple-jurisdictions
                       technical-infrastructure-for-each-jurisdiction)
   'case-application "Dan's dual ZA-EU regulatory compliance obligations"
   'related-principles '(director-duty-of-care professional-standard)
   'inference-type 'deductive))

(define regulatory-infrastructure-investment-necessity
  (make-principle
   'name 'regulatory-infrastructure-investment-necessity
   'description "Principle that investment in regulatory compliance infrastructure is necessary"
   'domain '(regulatory-compliance company)
   'confidence 0.93
   'jurisdiction "za"
   'principle "Companies must invest in infrastructure to meet regulatory obligations"
   'infrastructure-types '(document-management-systems
                          compliance-tracking-systems
                          reporting-platforms
                          monitoring-systems
                          communication-infrastructure
                          database-systems)
   'justification "Cannot comply with modern regulatory requirements without technical infrastructure"
   'case-application "Dan's IT systems for EU Responsible Person compliance"
   'related-principles '(regulatory-compliance-necessity operational-necessity)
   'inference-type 'deductive))

;; =============================================================================
;; PART 2: CROSS-BORDER DIRECTOR DUTIES
;; =============================================================================

;; -----------------------------------------------------------------------------
;; 2.1 Multi-Jurisdiction Director Duties
;; -----------------------------------------------------------------------------

(define cross-border-director-duties
  (make-principle
   'name 'cross-border-director-duties
   'description "Director duties when operating in multiple jurisdictions"
   'domain '(company international-law)
   'confidence 0.92
   'jurisdiction "za-uk"
   'duties '(comply-with-all-jurisdictions
            maintain-separate-entity-compliance
            avoid-jurisdiction-conflicts
            proper-transfer-pricing
            tax-compliance-all-jurisdictions
            regulatory-compliance-all-jurisdictions)
   'complexity-factors '(multiple-regulatory-regimes
                        currency-exchange-requirements
                        cross-border-transaction-documentation
                        international-tax-compliance
                        different-corporate-governance-standards)
   'case-application "Dan's UK and ZA company directorship (PARA 3-3.10)"
   'standard "Reasonable director operating in multiple jurisdictions"
   'related-principles '(director-duty-of-care professional-standard)
   'inference-type 'deductive))

(define international-director-standard
  (make-principle
   'name 'international-director-standard
   'description "Standard of care for directors operating internationally"
   'domain '(company international-law)
   'confidence 0.91
   'jurisdiction "za-uk"
   'standard "Higher standard of care due to increased complexity"
   'factors '(multiple-legal-systems
            cross-border-transaction-complexity
            currency-risk-management
            international-tax-compliance
            multi-jurisdiction-regulatory-compliance)
   'cost-implications "Higher professional fees, more complex systems, greater compliance burden"
   'case-application "Dan's international operations justify higher IT and compliance costs"
   'related-principles '(director-duty-of-care professional-standard)
   'inference-type 'deductive))

;; =============================================================================
;; PART 3: DEFENSE FRAMEWORK FOR COMPLIANCE COSTS
;; =============================================================================

;; -----------------------------------------------------------------------------
;; 3.1 Compliance Cost Defense Elements
;; -----------------------------------------------------------------------------

(define compliance-cost-defense-framework
  (make-principle
   'name 'compliance-cost-defense-framework
   'description "Framework for defending regulatory compliance costs against challenge"
   'domain '(regulatory-compliance company director-duties)
   'confidence 0.93
   'jurisdiction "za"
   'defense-elements '(mandatory-regulatory-duty-exists
                      technical-infrastructure-required-for-compliance
                      no-viable-less-expensive-alternative
                      market-access-dependent-on-compliance
                      personal-liability-for-non-compliance
                      costs-proportionate-to-regulatory-complexity
                      costs-within-industry-standards)
   'burden-of-proof "Challenger must prove costs unreasonable or unnecessary"
   'challenger-must-prove '(alternative-compliance-method-exists
                           alternative-is-less-expensive
                           alternative-achieves-same-compliance
                           costs-disproportionate-to-requirement)
   'case-application "Peter challenges Dan's IT expenses - Peter must prove alternative"
   'related-principles '(business-judgment-rule burden-of-proof)
   'inference-type 'deductive))

(define regulatory-cost-challenge-burden
  (make-principle
   'name 'regulatory-cost-challenge-burden
   'description "Burden of proof for challenging regulatory compliance costs"
   'domain '(regulatory-compliance evidence)
   'confidence 0.94
   'jurisdiction "za"
   'burden-allocation "Challenger bears burden of proving costs unreasonable"
   'challenger-must-prove '(regulatory-requirement-does-not-exist
                           or-costs-not-necessary-for-compliance
                           or-less-expensive-alternative-exists
                           or-costs-disproportionate-to-requirement)
   'director-presumption "Presumption that director acted reasonably in compliance matters"
   'case-application "Peter must prove Dan's IT expenses unreasonable - not just assert"
   'related-principles '(business-judgment-rule burden-of-proof)
   'inference-type 'deductive))

;; -----------------------------------------------------------------------------
;; 3.2 Application to Case
;; -----------------------------------------------------------------------------

(define dan-regulatory-compliance-defense
  (make-principle
   'name 'dan-regulatory-compliance-defense
   'description "Dan's defense of IT expenses based on EU Responsible Person duties"
   'domain '(regulatory-compliance company director-duties)
   'confidence 0.93
   'jurisdiction "za-eu"
   'case-application "Faucitt v. Faucitt (2025-137857) - PARA 7.2-7.5"
   'defense-elements '(eu-responsible-person-duty-mandatory
                      technical-systems-required-for-compliance
                      r8-85m-it-expenses-necessary-for-compliance
                      no-less-expensive-alternative-available
                      eu-market-access-dependent-on-compliance
                      personal-liability-for-non-compliance)
   'it-systems-breakdown '(document-management-system
                          compliance-tracking-system
                          product-safety-database
                          reporting-infrastructure
                          communication-platforms
                          monitoring-systems)
   'peter-burden "Peter must prove alternative compliance method or unreasonableness"
   'peter-failure "Peter provides no evidence of alternative or unreasonableness"
   'legal-conclusion "Dan's IT expenses reasonable and necessary for regulatory compliance"
   'related-principles '(eu-responsible-person-duty regulatory-compliance-cost-reasonableness)
   'inference-type 'deductive))

;; =============================================================================
;; HELPER FUNCTIONS
;; =============================================================================

(define (apply-regulatory-compliance-test entity expenses regulatory-duty)
  "Apply regulatory compliance cost reasonableness test"
  (let ((test-result (make-hash-table)))
    (hash-set! test-result 'entity entity)
    (hash-set! test-result 'expenses expenses)
    (hash-set! test-result 'regulatory-duty regulatory-duty)
    (hash-set! test-result 'test-elements
               '(regulatory-requirement-exists
                 cost-necessary-for-compliance
                 cost-proportionate-to-requirement
                 no-less-expensive-alternative
                 compliance-failure-consequences-severe))
    (hash-set! test-result 'conclusion "Apply each element to determine reasonableness")
    test-result))

(define (apply-compliance-cost-defense entity challenger expenses)
  "Apply compliance cost defense framework"
  (let ((defense (make-hash-table)))
    (hash-set! defense 'entity entity)
    (hash-set! defense 'challenger challenger)
    (hash-set! defense 'expenses expenses)
    (hash-set! defense 'burden-of-proof "Challenger must prove costs unreasonable")
    (hash-set! defense 'challenger-must-prove
               '(alternative-compliance-method-exists
                 alternative-is-less-expensive
                 alternative-achieves-same-compliance
                 costs-disproportionate-to-requirement))
    (hash-set! defense 'conclusion "Challenger fails if cannot prove all elements")
    defense))

;; =============================================================================
;; EXPORT PRINCIPLES
;; =============================================================================

(provide eu-responsible-person-duty
         product-safety-assessment-duty
         product-information-file-duty
         adverse-event-reporting-duty
         regulatory-compliance-cost-reasonableness
         regulatory-compliance-necessity
         compliance-cost-proportionality-test
         cross-border-regulatory-duty
         regulatory-infrastructure-investment-necessity
         cross-border-director-duties
         international-director-standard
         compliance-cost-defense-framework
         regulatory-cost-challenge-burden
         dan-regulatory-compliance-defense
         apply-regulatory-compliance-test
         apply-compliance-cost-defense)
