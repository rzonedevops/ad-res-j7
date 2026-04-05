;; =============================================================================
;; South African Company Law - Regulatory Compliance Framework (Enhanced v2)
;; =============================================================================
;; Version: 2.0
;; Last Updated: 2025-10-30
;; Case-Specific Enhancements: Faucitt v. Faucitt (2025-137857)
;; Focus: EU Responsible Person duties, regulatory compliance cost reasonableness
;; =============================================================================

;; Import Level 1 first-order principles
(require "../../lv1/known_laws.scm")

;; Initialize principle registry
(initialize-principle-registry!)

;; =============================================================================
;; PART 1: EU RESPONSIBLE PERSON REGULATORY FRAMEWORK
;; =============================================================================

;; -----------------------------------------------------------------------------
;; 1.1 EU Responsible Person Duties (EU Regulation 1223/2009)
;; -----------------------------------------------------------------------------

(define eu-responsible-person-duty
  (make-principle
   'name 'eu-responsible-person-duty
   'description "Duties of EU Responsible Person under Cosmetics Regulation 1223/2009"
   'domain '(regulatory-compliance international-law company)
   'confidence 0.93
   'jurisdiction "eu"
   'statutory-basis "EU Regulation 1223/2009 on Cosmetic Products, Articles 3-5"
   'provenance "EU Cosmetics Regulation - mandatory compliance for EU market access"
   'duties '(product-safety-assessment
            compliance-documentation
            adverse-event-reporting
            market-surveillance-cooperation
            product-information-file-maintenance
            label-compliance-verification
            good-manufacturing-practice-oversight
            post-market-surveillance)
   'compliance-costs '(documentation-systems
                      safety-assessments
                      regulatory-monitoring
                      technical-infrastructure
                      legal-consultation
                      it-systems-for-tracking
                      training-and-expertise)
   'case-application "Dan's IT expenses for EU compliance (PARA 7.2-7.5)"
   'defense "Compliance costs are necessary and reasonable for regulatory duties"
   'related-principles '(regulatory-compliance-necessity professional-standard)
   'inference-type 'deductive
   'burden-of-proof "Company must demonstrate regulatory necessity of expenses"))

(define regulatory-compliance-cost-reasonableness
  (make-principle
   'name 'regulatory-compliance-cost-reasonableness
   'description "Test for whether regulatory compliance costs are reasonable and necessary"
   'domain '(regulatory-compliance company director-duties)
   'confidence 0.94
   'jurisdiction "za"
   'statutory-basis "Companies Act 71 of 2008, s76(3)(c) - duty of care and skill"
   'test-elements '(regulatory-requirement-exists
                   cost-necessary-for-compliance
                   cost-proportionate-to-obligation
                   alternative-less-costly-methods-considered
                   business-judgment-applied)
   'reasonableness-factors '(regulatory-penalty-risk
                            market-access-necessity
                            industry-standard-costs
                            technical-complexity
                            ongoing-vs-one-time-costs)
   'case-application "R8.85M IT expenses over 18 months for EU compliance"
   'defense-strategy "Demonstrate necessity, proportionality, and industry standards"
   'burden-of-proof "Director must prove reasonableness if challenged"
   'related-principles '(business-judgment-rule director-duty-of-care)
   'inference-type 'deductive))

(define regulatory-compliance-necessity
  (make-principle
   'name 'regulatory-compliance-necessity
   'description "Principle that regulatory compliance costs are necessary business expenses"
   'domain '(regulatory-compliance company)
   'confidence 0.96
   'jurisdiction "za"
   'statutory-basis "Companies Act, common law duty of care"
   'principle "Directors must ensure company complies with applicable regulations"
   'necessity-test '(regulation-applies-to-business
                    non-compliance-consequences-severe
                    compliance-required-for-market-access
                    legal-obligation-exists)
   'consequences-of-non-compliance '(regulatory-penalties
                                     market-exclusion
                                     product-recalls
                                     reputational-damage
                                     criminal-liability)
   'case-application "EU Responsible Person duties for cosmetics export"
   'inference "Compliance costs are justified when regulatory obligation exists"
   'related-principles '(director-duty-of-care business-judgment-rule)
   'inference-type 'deductive))

;; -----------------------------------------------------------------------------
;; 1.2 IT Infrastructure Compliance Framework
;; -----------------------------------------------------------------------------

(define it-infrastructure-compliance-necessity
  (make-principle
   'name 'it-infrastructure-compliance-necessity
   'description "IT infrastructure necessary for regulatory compliance is reasonable expense"
   'domain '(regulatory-compliance company it-governance)
   'confidence 0.92
   'jurisdiction "za"
   'statutory-basis "Companies Act, professional standards"
   'necessary-systems '(product-tracking-databases
                       compliance-documentation-systems
                       adverse-event-reporting-systems
                       audit-trail-maintenance
                       secure-data-storage
                       regulatory-submission-platforms)
   'case-application "Dan's IT expenses for EU compliance infrastructure"
   'justification "Modern regulatory compliance requires robust IT systems"
   'industry-standard "Cosmetics industry requires sophisticated compliance IT"
   'related-principles '(regulatory-compliance-necessity professional-standard)
   'inference-type 'inductive))

(define professional-it-standard
  (make-principle
   'name 'professional-it-standard
   'description "CIO must meet professional standards for IT infrastructure and security"
   'domain '(professional-responsibility it-governance)
   'confidence 0.93
   'jurisdiction "za"
   'statutory-basis "Common law professional duty, Companies Act s76(3)(c)"
   'standards '(data-security
               system-reliability
               regulatory-compliance-support
               business-continuity
               disaster-recovery
               access-controls
               audit-trails)
   'case-application "Dan's role as CIO and Responsible Person"
   'defense "Professional standards require robust IT infrastructure"
   'related-principles '(professional-standard duty-of-care)
   'inference-type 'deductive))

;; =============================================================================
;; PART 2: CROSS-BORDER REGULATORY COMPLIANCE
;; =============================================================================

;; -----------------------------------------------------------------------------
;; 2.1 Cross-Border Director Duties
;; -----------------------------------------------------------------------------

(define cross-border-director-compliance-duty
  (make-principle
   'name 'cross-border-director-compliance-duty
   'description "Directors of companies operating internationally must ensure compliance with foreign regulations"
   'domain '(company director-duties international-law)
   'confidence 0.94
   'jurisdiction "za"
   'statutory-basis "Companies Act 71 of 2008, s76 - duty of care extends to foreign compliance"
   'duties '(identify-applicable-foreign-regulations
            implement-compliance-systems
            allocate-resources-for-compliance
            monitor-regulatory-changes
            ensure-qualified-personnel)
   'case-application "RST/RWD exporting cosmetics to EU market"
   'consequence-of-breach "Market exclusion, penalties, director liability"
   'related-principles '(director-duty-of-care regulatory-compliance-necessity)
   'inference-type 'deductive))

(define international-regulatory-coordination
  (make-principle
   'name 'international-regulatory-coordination
   'description "Companies with international operations must coordinate compliance across jurisdictions"
   'domain '(regulatory-compliance international-law)
   'confidence 0.91
   'jurisdiction "za"
   'coordination-requirements '(unified-compliance-systems
                               cross-border-data-management
                               multi-jurisdictional-reporting
                               harmonized-documentation)
   'case-application "RegimA entities operating in ZA, UK, and EU markets"
   'complexity-factors '(multiple-regulatory-regimes
                        language-requirements
                        different-standards
                        ongoing-monitoring)
   'related-principles '(regulatory-compliance-necessity professional-standard)
   'inference-type 'inductive))

;; =============================================================================
;; PART 3: EXPENSE JUSTIFICATION FRAMEWORK
;; =============================================================================

;; -----------------------------------------------------------------------------
;; 3.1 Business Expense Reasonableness
;; -----------------------------------------------------------------------------

(define business-expense-reasonableness-test
  (make-principle
   'name 'business-expense-reasonableness-test
   'description "Test for whether business expenses are reasonable and justified"
   'domain '(company corporate-governance)
   'confidence 0.95
   'jurisdiction "za"
   'statutory-basis "Companies Act 71 of 2008, s76(3) - director duties"
   'test-elements '(expense-serves-business-purpose
                   amount-proportionate-to-benefit
                   alternative-options-considered
                   proper-authorization-obtained
                   documented-justification)
   'reasonableness-factors '(industry-standards
                            regulatory-requirements
                            business-necessity
                            competitive-positioning
                            risk-mitigation)
   'burden-of-proof "Director challenging expense must prove unreasonableness"
   'presumption "Business judgment presumption favors expense if documented"
   'case-application "R8.85M IT expenses over 18 months"
   'related-principles '(business-judgment-rule director-duty-of-care)
   'inference-type 'deductive))

(define operational-necessity-test
  (make-principle
   'name 'operational-necessity-test
   'description "Test for whether expenses are operationally necessary for business function"
   'domain '(company corporate-governance)
   'confidence 0.93
   'jurisdiction "za"
   'test-elements '(business-cannot-function-without-expense
                   regulatory-compliance-requires-expense
                   competitive-necessity
                   risk-mitigation-necessity)
   'case-application "IT infrastructure for EU compliance and business operations"
   'defense "Expenses necessary for business continuity and regulatory compliance"
   'related-principles '(business-expense-reasonableness-test regulatory-compliance-necessity)
   'inference-type 'deductive))

;; -----------------------------------------------------------------------------
;; 3.2 Documentation Requirements for Expense Justification
;; -----------------------------------------------------------------------------

(define expense-documentation-requirement
  (make-principle
   'name 'expense-documentation-requirement
   'description "Proper documentation required to justify business expenses"
   'domain '(company corporate-governance evidence)
   'confidence 0.94
   'jurisdiction "za"
   'statutory-basis "Companies Act, accounting standards, tax law"
   'required-documentation '(invoices
                            purchase-orders
                            contracts
                            business-justification-memos
                            board-approvals-for-major-expenses
                            regulatory-compliance-documentation)
   'case-application "Dan's documentation for IT expenses (PARA 7.14-7.15)"
   'obstruction-issue "Peter's card cancellation made documentation inaccessible"
   'legal-consequence "Party obstructing documentation cannot benefit from lack of documentation"
   'related-principles '(venire-contra-factum-proprium obstruction-of-documentation)
   'inference-type 'deductive))

(define obstruction-of-documentation-principle
  (make-principle
   'name 'obstruction-of-documentation-principle
   'description "Party who obstructs access to documentation cannot benefit from lack of documentation"
   'domain '(evidence procedural-fairness)
   'confidence 0.96
   'jurisdiction "za"
   'statutory-basis "Common law, procedural fairness principles"
   'principle "No one may benefit from their own wrongdoing"
   'application '(party-creates-documentation-gap
                 party-then-complains-about-missing-documentation
                 court-draws-adverse-inference)
   'case-application "Peter cancels cards (June 7) making documentation inaccessible, then complains about missing documentation"
   'adverse-inference "Court should draw adverse inference against obstructing party"
   'related-principles '(venire-contra-factum-proprium clean-hands-doctrine)
   'inference-type 'deductive))

;; =============================================================================
;; PART 4: REGULATORY COMPLIANCE DEFENSE FRAMEWORK
;; =============================================================================

;; -----------------------------------------------------------------------------
;; 4.1 Compliance Cost Defense Strategy
;; -----------------------------------------------------------------------------

(define compliance-cost-defense-framework
  (make-principle
   'name 'compliance-cost-defense-framework
   'description "Framework for defending regulatory compliance costs against unreasonableness claims"
   'domain '(regulatory-compliance company defense-strategy)
   'confidence 0.93
   'jurisdiction "za"
   'defense-elements '(demonstrate-regulatory-obligation
                      show-necessity-of-expense
                      prove-proportionality
                      cite-industry-standards
                      document-decision-making-process
                      invoke-business-judgment-rule)
   'evidence-required '(regulatory-text
                       compliance-requirements
                       industry-benchmarks
                       expert-opinions
                       cost-benefit-analysis
                       board-minutes-if-available)
   'case-application "Dan's defense of R8.85M IT expenses"
   'strategy "Demonstrate EU Responsible Person duties require robust IT infrastructure"
   'related-principles '(business-judgment-rule regulatory-compliance-necessity)
   'inference-type 'abductive))

(define regulatory-penalty-risk-analysis
  (make-principle
   'name 'regulatory-penalty-risk-analysis
   'description "Analysis of regulatory penalty risk justifies compliance investment"
   'domain '(regulatory-compliance risk-management)
   'confidence 0.92
   'jurisdiction "za"
   'risk-factors '(severity-of-penalties
                  probability-of-detection
                  reputational-damage
                  market-exclusion
                  criminal-liability-potential)
   'justification "Compliance costs justified when penalty risk is high"
   'case-application "EU market exclusion risk justifies IT compliance investment"
   'related-principles '(regulatory-compliance-necessity business-judgment-rule)
   'inference-type 'inductive))

;; =============================================================================
;; PART 5: INTEGRATION WITH CASE EVIDENCE
;; =============================================================================

;; -----------------------------------------------------------------------------
;; 5.1 Case-Specific Application Principles
;; -----------------------------------------------------------------------------

(define dan-regulatory-compliance-defense
  (make-principle
   'name 'dan-regulatory-compliance-defense
   'description "Dan's specific defense based on EU Responsible Person duties"
   'domain '(case-specific regulatory-compliance)
   'confidence 0.91
   'jurisdiction "za"
   'case-reference "Faucitt v. Faucitt (2025-137857)"
   'defense-elements '(eu-responsible-person-appointed
                      regulatory-duties-mandatory
                      it-infrastructure-necessary
                      expenses-reasonable-for-compliance
                      industry-standard-costs
                      business-judgment-protection)
   'evidence-references '(PARA-7.2-7.5 PARA-7.14-7.15)
   'counter-to-peters-claims "Peter's claims of excessive IT expenses ignore regulatory necessity"
   'related-principles '(eu-responsible-person-duty regulatory-compliance-cost-reasonableness)
   'inference-type 'abductive))

(define documentation-obstruction-by-peter
  (make-principle
   'name 'documentation-obstruction-by-peter
   'description "Peter's card cancellation obstructed documentation access"
   'domain '(case-specific evidence procedural-fairness)
   'confidence 0.94
   'jurisdiction "za"
   'case-reference "Faucitt v. Faucitt (2025-137857)"
   'timeline '((2025-06-06 "Dan provides reports to accountant")
              (2025-06-07 "Peter cancels business cards unilaterally")
              (2025-06-07-onwards "Documentation becomes inaccessible")
              (present "Peter complains about missing documentation"))
   'legal-issue "Peter created the documentation gap he now complains about"
   'principle-application "venire-contra-factum-proprium - estoppel"
   'adverse-inference "Court should draw adverse inference against Peter"
   'related-principles '(venire-contra-factum-proprium obstruction-of-documentation-principle)
   'inference-type 'deductive))

;; =============================================================================
;; FRAMEWORK METADATA
;; =============================================================================

(define regulatory-compliance-framework-metadata
  (make-hash-table
   'name "Regulatory Compliance Framework (Enhanced v2)"
   'jurisdiction "za-eu"
   'legal-domain '(regulatory-compliance company international-law)
   'version "2.0"
   'last-updated "2025-10-30"
   'derived-from-level 1
   'confidence-base 0.93
   'statutory-basis "Companies Act 71/2008, EU Regulation 1223/2009"
   'language "en"
   'case-specific-enhancements "Faucitt v. Faucitt (2025-137857) - EU Responsible Person defense"))

;; Register all principles
(register-principles!
 eu-responsible-person-duty
 regulatory-compliance-cost-reasonableness
 regulatory-compliance-necessity
 it-infrastructure-compliance-necessity
 professional-it-standard
 cross-border-director-compliance-duty
 international-regulatory-coordination
 business-expense-reasonableness-test
 operational-necessity-test
 expense-documentation-requirement
 obstruction-of-documentation-principle
 compliance-cost-defense-framework
 regulatory-penalty-risk-analysis
 dan-regulatory-compliance-defense
 documentation-obstruction-by-peter)

;; Export framework
(provide regulatory-compliance-framework-metadata
         eu-responsible-person-duty
         regulatory-compliance-cost-reasonableness
         regulatory-compliance-necessity
         compliance-cost-defense-framework)
