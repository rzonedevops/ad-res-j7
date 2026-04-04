;; =============================================================================
;; South African Company Law - Forensic Accounting Framework (Enhanced v2)
;; =============================================================================
;; Version: 2.0
;; Last Updated: 2025-10-30
;; Case-Specific Enhancements: Faucitt v. Faucitt (2025-137857)
;; Focus: Accounting manipulation detection, transfer pricing abuse, inventory fraud
;; =============================================================================

;; Import Level 1 first-order principles
(require "../../lv1/known_laws.scm")

;; Initialize principle registry
(initialize-principle-registry!)

;; =============================================================================
;; PART 1: ACCOUNTING FRAUD INDICATORS
;; =============================================================================

;; -----------------------------------------------------------------------------
;; 1.1 General Accounting Fraud Detection Framework
;; -----------------------------------------------------------------------------

(define accounting-fraud-indicators
  (make-principle
   'name 'accounting-fraud-indicators
   'description "Indicators of potential accounting fraud or manipulation"
   'domain '(company forensic-accounting fraud-detection)
   'confidence 0.92
   'jurisdiction "za"
   'statutory-basis "Companies Act 71/2008, Financial Reporting Standards"
   'red-flags '(unusual-adjustments
               timing-of-adjustments
               magnitude-disproportionate-to-prior-periods
               lack-of-documentation
               related-party-transactions
               negative-inventory-balances
               inconsistent-financial-patterns
               year-end-adjustments)
   'investigation-triggers '(adjustment-exceeds-10x-prior-year
                            adjustment-exceeds-30-percent-of-revenue
                            negative-asset-balances
                            unexplained-losses
                            suspicious-timing)
   'case-application "SLG R5.4M manufactured loss, R5.2M inventory adjustment"
   'related-principles '(substance-over-form true-and-fair-view)
   'inference-type 'inductive))

(define manufactured-loss-indicators
  (make-principle
   'name 'manufactured-loss-indicators
   'description "Indicators that losses are manufactured rather than genuine business losses"
   'domain '(company forensic-accounting)
   'confidence 0.93
   'jurisdiction "za"
   'indicators '(sudden-large-loss-after-profitable-periods
                loss-driven-by-single-adjustment
                adjustment-lacks-business-explanation
                timing-coincides-with-dispute
                tax-benefit-from-loss
                related-party-profit-extraction)
   'case-application "SLG R5.4M loss (R5.2M from single inventory adjustment)"
   'analysis-factors '(prior-year-comparison
                      adjustment-to-revenue-ratio
                      business-operations-unchanged
                      related-party-transactions)
   'inference "Loss likely manufactured when driven by unexplained adjustment"
   'related-principles '(accounting-fraud-indicators transfer-pricing-abuse)
   'inference-type 'abductive))

;; -----------------------------------------------------------------------------
;; 1.2 Inventory Fraud Detection
;; -----------------------------------------------------------------------------

(define inventory-valuation-fraud-indicators
  (make-principle
   'name 'inventory-valuation-fraud-indicators
   'description "Indicators of inventory valuation fraud or manipulation"
   'domain '(company forensic-accounting inventory)
   'confidence 0.94
   'jurisdiction "za"
   'statutory-basis "Companies Act, IAS 2 (Inventories)"
   'red-flags '(negative-inventory-balances
               massive-write-offs-without-explanation
               inventory-adjustments-exceeding-sales
               no-corresponding-write-off-recovery
               finished-goods-negative-balance
               timing-of-adjustments-suspicious)
   'case-application "SLG R5.2M inventory adjustment, negative R4.2M finished goods"
   'accounting-impossibility "Negative finished goods inventory indicates accounting fiction"
   'investigation-required "Forensic audit needed when negative inventory appears"
   'related-principles '(accounting-fraud-indicators substance-over-form)
   'inference-type 'deductive))

(define inventory-adjustment-reasonableness-test
  (make-principle
   'name 'inventory-adjustment-reasonableness-test
   'description "Test for whether inventory adjustments are reasonable and justified"
   'domain '(company forensic-accounting inventory)
   'confidence 0.95
   'jurisdiction "za"
   'statutory-basis "IAS 2, Companies Act accounting standards"
   'test-elements '(adjustment-has-business-explanation
                   magnitude-proportionate-to-inventory-value
                   documentation-supports-adjustment
                   physical-count-verification
                   write-off-recovery-if-applicable
                   consistent-with-prior-periods)
   'reasonableness-thresholds '(adjustment-less-than-10-percent-normal
                               adjustment-less-than-2x-prior-year
                               positive-inventory-balances-maintained)
   'case-application "SLG R5.2M adjustment (10x prior year, 46% of sales)"
   'conclusion "Adjustment fails reasonableness test"
   'related-principles '(inventory-valuation-fraud-indicators accounting-fraud-indicators)
   'inference-type 'deductive))

(define negative-inventory-impossibility
  (make-principle
   'name 'negative-inventory-impossibility
   'description "Negative inventory balances are accounting impossibility indicating fraud"
   'domain '(company forensic-accounting inventory)
   'confidence 0.98
   'jurisdiction "za"
   'statutory-basis "IAS 2, basic accounting principles"
   'principle "Physical inventory cannot be negative - indicates accounting manipulation"
   'case-application "SLG finished goods inventory negative R4.2M"
   'implications '(accounting-fiction
                  inventory-given-away-without-invoicing
                  transfer-pricing-manipulation
                  phantom-write-offs)
   'forensic-conclusion "Negative inventory proves accounting manipulation"
   'related-principles '(inventory-valuation-fraud-indicators accounting-fraud-indicators)
   'inference-type 'deductive))

;; =============================================================================
;; PART 2: TRANSFER PRICING ABUSE
;; =============================================================================

;; -----------------------------------------------------------------------------
;; 2.1 Transfer Pricing Manipulation Detection
;; -----------------------------------------------------------------------------

(define transfer-pricing-abuse-indicators
  (make-principle
   'name 'transfer-pricing-abuse-indicators
   'description "Indicators of transfer pricing manipulation between related entities"
   'domain '(company forensic-accounting related-party-transactions)
   'confidence 0.93
   'jurisdiction "za"
   'statutory-basis "Companies Act s75-76, Income Tax Act s31"
   'red-flags '(selling-below-cost-to-related-party
               profit-concentration-in-one-entity
               loss-concentration-in-another-entity
               no-arms-length-pricing
               lack-of-transfer-pricing-documentation
               tax-benefit-from-loss-entity)
   'case-application "SLG sells to RST at below cost, creating R5.4M loss in SLG"
   'mechanism "Profits extracted from SLG to RST via below-cost transfer pricing"
   'tax-implication "SLG creates tax asset, profits appear in other entities"
   'related-principles '(arms-length-principle related-party-transaction-disclosure)
   'inference-type 'abductive))

(define below-cost-transfer-pricing-prohibition
  (make-principle
   'name 'below-cost-transfer-pricing-prohibition
   'description "Related party transactions must be at arms length, not below cost"
   'domain '(company related-party-transactions)
   'confidence 0.96
   'jurisdiction "za"
   'statutory-basis "Companies Act s75-76, Income Tax Act s31"
   'principle "Related party transactions must be at fair market value (arms length)"
   'prohibition "Selling below cost to related party is transfer pricing abuse"
   'case-application "SLG selling to RST at below cost"
   'consequences '(transaction-voidable
                  director-liability
                  tax-adjustment
                  shareholder-oppression)
   'related-principles '(arms-length-principle director-self-dealing-prohibition)
   'inference-type 'deductive))

(define arms-length-principle
  (make-principle
   'name 'arms-length-principle
   'description "Related party transactions must be at arms length (market value)"
   'domain '(company related-party-transactions tax)
   'confidence 0.97
   'jurisdiction "za"
   'statutory-basis "Income Tax Act s31, Companies Act s75"
   'principle "Transaction between related parties must be at price that unrelated parties would agree"
   'test "Would independent third parties transact at this price?"
   'case-application "SLG-RST transactions, Villa Via rent charges"
   'burden-of-proof "Company must prove arms length pricing if challenged"
   'related-principles '(transfer-pricing-abuse-indicators fair-value-requirement)
   'inference-type 'deductive))

;; -----------------------------------------------------------------------------
;; 2.2 Profit Extraction Mechanisms
;; -----------------------------------------------------------------------------

(define profit-extraction-mechanism-indicators
  (make-principle
   'name 'profit-extraction-mechanism-indicators
   'description "Indicators of systematic profit extraction from company"
   'domain '(company forensic-accounting shareholder-oppression)
   'confidence 0.92
   'jurisdiction "za"
   'indicators '(related-party-transactions-at-unfair-prices
                excessive-management-fees
                excessive-rent-charges
                below-cost-sales-to-related-parties
                above-market-purchases-from-related-parties
                profit-concentration-in-related-entity)
   'case-application "Villa Via 86% profit margin on rent, SLG below-cost sales"
   'mechanism "Profits extracted via rent charges and transfer pricing"
   'beneficiaries "Peter (50% RST, 50% Villa Via, 33% SLG)"
   'victims "Minority shareholders (Jax 50% RST, 33% SLG)"
   'related-principles '(shareholder-oppression-test excessive-profit-extraction-test)
   'inference-type 'abductive))

(define excessive-profit-extraction-test
  (make-principle
   'name 'excessive-profit-extraction-test
   'description "Test for whether profit extraction is excessive and oppressive"
   'domain '(company shareholder-oppression)
   'confidence 0.94
   'jurisdiction "za"
   'statutory-basis "Companies Act s163 (shareholder oppression)"
   'test-elements '(profit-margin-excessive
                   transaction-not-arms-length
                   minority-shareholders-prejudiced
                   beneficiary-is-majority-shareholder-or-director
                   lack-of-independent-approval)
   'excessive-thresholds '(profit-margin-exceeds-50-percent
                          profit-margin-exceeds-industry-standard-by-3x
                          no-business-justification)
   'case-application "Villa Via 86% profit margin on rent"
   'conclusion "86% profit margin is excessive and oppressive"
   'related-principles '(shareholder-oppression-test arms-length-principle)
   'inference-type 'deductive))

;; =============================================================================
;; PART 3: FINANCIAL STATEMENT MANIPULATION
;; =============================================================================

;; -----------------------------------------------------------------------------
;; 3.1 Year-End Adjustment Fraud
;; -----------------------------------------------------------------------------

(define year-end-adjustment-fraud-indicators
  (make-principle
   'name 'year-end-adjustment-fraud-indicators
   'description "Indicators that year-end adjustments are fraudulent or manipulative"
   'domain '(company forensic-accounting)
   'confidence 0.91
   'jurisdiction "za"
   'red-flags '(large-adjustments-at-year-end
               adjustments-reverse-profitable-year
               adjustments-create-tax-losses
               lack-of-documentation
               timing-coincides-with-dispute
               adjustments-benefit-related-parties)
   'case-application "SLG R5.2M year-end inventory adjustment"
   'timing-analysis "Adjustment timing coincides with shareholder dispute"
   'tax-benefit "Creates R5.4M tax loss for SLG"
   'related-principles '(accounting-fraud-indicators manufactured-loss-indicators)
   'inference-type 'abductive))

(define financial-statement-manipulation-test
  (make-principle
   'name 'financial-statement-manipulation-test
   'description "Test for whether financial statements have been manipulated"
   'domain '(company forensic-accounting)
   'confidence 0.93
   'jurisdiction "za"
   'statutory-basis "Companies Act, Financial Reporting Standards"
   'test-elements '(unusual-adjustments-present
                   adjustments-lack-business-explanation
                   timing-suspicious
                   magnitude-disproportionate
                   beneficiaries-identifiable
                   pattern-of-manipulation)
   'case-application "SLG financial statements (R5.4M manufactured loss)"
   'indicators-present '(R5.2M-inventory-adjustment
                        negative-inventory-balance
                        10x-prior-year-adjustment
                        46-percent-of-sales
                        no-write-off-recovery
                        timing-during-dispute)
   'conclusion "Financial statements likely manipulated"
   'related-principles '(accounting-fraud-indicators substance-over-form)
   'inference-type 'abductive))

;; -----------------------------------------------------------------------------
;; 3.2 Revenue and Asset Verification
;; -----------------------------------------------------------------------------

(define revenue-source-verification-test
  (make-principle
   'name 'revenue-source-verification-test
   'description "Test for verifying legitimacy of revenue sources"
   'domain '(company forensic-accounting)
   'confidence 0.94
   'jurisdiction "za"
   'statutory-basis "Companies Act, accounting standards"
   'verification-elements '(revenue-source-identifiable
                           underlying-assets-exist
                           inventory-or-stock-exists
                           business-operations-support-revenue
                           related-party-transactions-disclosed)
   'case-application "RWD revenue without stock/inventory/assets"
   'red-flags '(revenue-without-assets
               revenue-without-inventory
               revenue-without-business-substance
               related-party-revenue-concentration)
   'conclusion "Revenue without assets indicates potential fraud or trust operation"
   'related-principles '(business-substance-test trust-operation-indicators)
   'inference-type 'deductive))

(define business-substance-test
  (make-principle
   'name 'business-substance-test
   'description "Test for whether business has genuine substance or is sham"
   'domain '(company forensic-accounting)
   'confidence 0.95
   'jurisdiction "za"
   'statutory-basis "Companies Act, substance-over-form doctrine"
   'substance-indicators '(assets-exist
                          employees-exist
                          business-operations-genuine
                          independent-customers
                          arms-length-transactions)
   'sham-indicators '(no-assets
                     no-inventory
                     only-related-party-transactions
                     revenue-without-business-operations
                     entity-is-conduit)
   'case-application "RWD has revenue but no stock/inventory/assets"
   'inference "RWD may be operating as trust or conduit, not genuine business"
   'related-principles '(substance-over-form trust-operation-indicators)
   'inference-type 'abductive))

;; =============================================================================
;; PART 4: SHAREHOLDER OPPRESSION THROUGH FINANCIAL MANIPULATION
;; =============================================================================

;; -----------------------------------------------------------------------------
;; 4.1 Financial Oppression Indicators
;; -----------------------------------------------------------------------------

(define financial-oppression-indicators
  (make-principle
   'name 'financial-oppression-indicators
   'description "Indicators of shareholder oppression through financial manipulation"
   'domain '(company shareholder-oppression forensic-accounting)
   'confidence 0.93
   'jurisdiction "za"
   'statutory-basis "Companies Act s163"
   'indicators '(profit-extraction-to-related-parties
                losses-manufactured-in-minority-shareholding-entities
                excessive-related-party-charges
                below-cost-transfer-pricing
                dividend-suppression
                asset-stripping)
   'case-application "Peter's 50% RST + 50% Villa Via + 33% SLG structure"
   'oppression-mechanism '(villa-via-extracts-86-percent-profit-rent
                          slg-manufactures-5.4M-loss
                          profits-concentrated-in-peter-controlled-entities
                          losses-in-entities-with-minority-shareholders)
   'victims "Jax (50% RST, 33% SLG), Dan (33% SLG)"
   'related-principles '(shareholder-oppression-test profit-extraction-mechanism-indicators)
   'inference-type 'abductive))

(define dividend-suppression-through-profit-extraction
  (make-principle
   'name 'dividend-suppression-through-profit-extraction
   'description "Suppressing dividends by extracting profits to related parties"
   'domain '(company shareholder-oppression)
   'confidence 0.92
   'jurisdiction "za"
   'statutory-basis "Companies Act s163"
   'mechanism "Extract profits via related party transactions, leaving no profits for dividends"
   'case-application "Villa Via rent extraction, SLG below-cost sales suppress dividends"
   'effect "Minority shareholders receive no dividends while majority extracts profits"
   'oppression "Unfairly prejudicial to minority shareholders"
   'related-principles '(shareholder-oppression-test profit-extraction-mechanism-indicators)
   'inference-type 'abductive))

;; =============================================================================
;; PART 5: FORENSIC ACCOUNTING INVESTIGATION FRAMEWORK
;; =============================================================================

;; -----------------------------------------------------------------------------
;; 5.1 Forensic Investigation Triggers
;; -----------------------------------------------------------------------------

(define forensic-investigation-triggers
  (make-principle
   'name 'forensic-investigation-triggers
   'description "Circumstances triggering need for forensic accounting investigation"
   'domain '(company forensic-accounting)
   'confidence 0.94
   'jurisdiction "za"
   'triggers '(negative-inventory-balances
              adjustments-exceeding-10x-prior-year
              adjustments-exceeding-30-percent-revenue
              manufactured-losses
              excessive-related-party-charges
              shareholder-dispute-with-financial-allegations)
   'case-application "SLG financial statements meet multiple triggers"
   'recommendation "Forensic audit required for SLG, RST, RWD, Villa Via"
   'scope "Examine related party transactions, transfer pricing, inventory valuation"
   'related-principles '(accounting-fraud-indicators financial-statement-manipulation-test)
   'inference-type 'deductive))

(define forensic-evidence-preservation
  (make-principle
   'name 'forensic-evidence-preservation
   'description "Principle that forensic evidence must be preserved and accessible"
   'domain '(forensic-accounting evidence)
   'confidence 0.96
   'jurisdiction "za"
   'principle "Financial records must be preserved and accessible for investigation"
   'obstruction-prohibition "Parties cannot obstruct access to financial records"
   'case-application "Peter's card cancellation obstructed documentation access"
   'consequence "Adverse inference against party obstructing evidence"
   'related-principles '(obstruction-of-documentation-principle venire-contra-factum-proprium)
   'inference-type 'deductive))

;; =============================================================================
;; FRAMEWORK METADATA
;; =============================================================================

(define forensic-accounting-framework-metadata
  (make-hash-table
   'name "Forensic Accounting Framework (Enhanced v2)"
   'jurisdiction "za"
   'legal-domain '(company forensic-accounting fraud-detection)
   'version "2.0"
   'last-updated "2025-10-30"
   'derived-from-level 1
   'confidence-base 0.93
   'statutory-basis "Companies Act 71/2008, IAS 2, Income Tax Act s31"
   'language "en"
   'case-specific-enhancements "Faucitt v. Faucitt (2025-137857) - SLG accounting manipulation"))

;; Register all principles
(register-principles!
 accounting-fraud-indicators
 manufactured-loss-indicators
 inventory-valuation-fraud-indicators
 inventory-adjustment-reasonableness-test
 negative-inventory-impossibility
 transfer-pricing-abuse-indicators
 below-cost-transfer-pricing-prohibition
 arms-length-principle
 profit-extraction-mechanism-indicators
 excessive-profit-extraction-test
 year-end-adjustment-fraud-indicators
 financial-statement-manipulation-test
 revenue-source-verification-test
 business-substance-test
 financial-oppression-indicators
 dividend-suppression-through-profit-extraction
 forensic-investigation-triggers
 forensic-evidence-preservation)

;; Export framework
(provide forensic-accounting-framework-metadata
         accounting-fraud-indicators
         transfer-pricing-abuse-indicators
         financial-oppression-indicators
         forensic-investigation-triggers)
