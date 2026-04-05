;; =============================================================================
;; South African Company Law - Forensic Accounting Framework
;; =============================================================================
;; Version: 1.0
;; Last Updated: 2025-10-28
;; Case-Specific Enhancements: Faucitt v. Faucitt (2025-137857)
;; Purpose: Accounting manipulation detection and transfer pricing abuse analysis
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
   'name "South African Company Law - Forensic Accounting"
   'jurisdiction "za"
   'legal-domain '(company forensic-accounting financial-fraud)
   'version "1.0"
   'last-updated "2025-10-28"
   'derived-from-level 1
   'confidence-base 0.91
   'statutory-basis "Companies Act 71 of 2008, IFRS, GAAP, Income Tax Act"
   'language "en"
   'case-specific-enhancements "Faucitt v. Faucitt - SLG R5.4M manufactured loss"))

;; =============================================================================
;; PART 1: ACCOUNTING MANIPULATION INDICATORS
;; =============================================================================

;; -----------------------------------------------------------------------------
;; 1.1 Core Manipulation Indicators
;; -----------------------------------------------------------------------------

(define accounting-manipulation-indicators
  (make-principle
   'name 'accounting-manipulation-indicators
   'description "Indicators of accounting manipulation or fraud"
   'domain '(company forensic-accounting financial-fraud)
   'confidence 0.91
   'jurisdiction "za"
   'statutory-basis "Companies Act 71 of 2008, IFRS, GAAP"
   'provenance "Forensic accounting standards, fraud detection principles"
   'indicators '(adjustment-size-disproportionate
                timing-suspicious
                no-supporting-documentation
                pattern-of-similar-adjustments
                beneficiary-of-adjustment-unclear
                reversal-not-expected
                magnitude-vs-prior-year-extreme
                adjustment-creates-tax-benefit
                adjustment-shifts-profit-between-entities)
   'red-flags '(negative-inventory-balance
               no-write-off-recovery
               inter-company-pricing-suspicious
               tax-loss-creation-motive
               year-end-timing
               round-number-adjustments
               lack-of-business-justification)
   'case-application "SLG R5.2M inventory adjustment (10x prior year, 46% of sales) (PARA 10.5-10.10.23)"
   'inference "Multiple indicators suggest manufactured loss for tax or profit-shifting purposes"
   'related-principles '(substance-over-form bona-fides)
   'inference-type 'abductive))

(define adjustment-size-disproportionality
  (make-principle
   'name 'adjustment-size-disproportionality
   'description "Indicator when adjustment size is disproportionate to business scale"
   'domain '(forensic-accounting)
   'confidence 0.92
   'jurisdiction "za"
   'test "Is adjustment size disproportionate to normal business operations?"
   'disproportionality-factors '(adjustment-vs-prior-year-ratio
                                adjustment-vs-annual-sales-ratio
                                adjustment-vs-total-assets-ratio
                                adjustment-vs-industry-norms)
   'red-flag-thresholds '(10x-prior-year
                         greater-than-40-percent-sales
                         greater-than-50-percent-assets
                         significantly-above-industry-average)
   'case-application "SLG R5.2M adjustment: 10x prior year, 46% of annual sales"
   'inference "Extreme disproportionality suggests manipulation rather than genuine business event"
   'inference-type 'abductive))

(define timing-suspicion-indicator
  (make-principle
   'name 'timing-suspicion-indicator
   'description "Indicator when timing of adjustment is suspicious"
   'domain '(forensic-accounting)
   'confidence 0.89
   'jurisdiction "za"
   'suspicious-timing-patterns '(year-end-adjustment
                                just-before-audit
                                coincides-with-tax-filing
                                coincides-with-other-events
                                pattern-of-year-end-adjustments)
   'case-application "SLG R5.2M adjustment at year-end (Feb 25, 2025)"
   'inference "Year-end timing suggests tax-motivated adjustment"
   'inference-type 'abductive))

(define negative-inventory-red-flag
  (make-principle
   'name 'negative-inventory-red-flag
   'description "Red flag when inventory balance becomes negative"
   'domain '(forensic-accounting)
   'confidence 0.94
   'jurisdiction "za"
   'principle "Inventory cannot be negative in reality - indicates accounting fiction"
   'red-flag "Negative finished goods inventory indicates either:"
   'explanations '(inventory-sold-before-purchased-or-manufactured
                  accounting-error
                  deliberate-manipulation
                  phantom-inventory-write-off)
   'case-application "SLG negative R4.2M finished goods inventory"
   'inference "Negative inventory is impossible in reality - strong evidence of manipulation"
   'related-principles '(substance-over-form)
   'inference-type 'abductive))

;; -----------------------------------------------------------------------------
;; 1.2 Transfer Pricing Abuse Framework
;; -----------------------------------------------------------------------------

(define transfer-pricing-abuse-test
  (make-principle
   'name 'transfer-pricing-abuse-test
   'description "Test for transfer pricing manipulation in inter-company transactions"
   'domain '(company forensic-accounting tax-law)
   'confidence 0.90
   'jurisdiction "za"
   'statutory-basis "Income Tax Act, OECD Transfer Pricing Guidelines"
   'provenance "International tax law, anti-avoidance principles"
   'test-elements '(related-party-transaction
                   pricing-not-arm's-length
                   profit-shifted-between-entities
                   tax-benefit-obtained
                   no-business-justification)
   'indicators '(selling-below-cost
                pricing-inconsistent-with-market
                loss-in-one-entity-profit-in-related
                timing-year-end-adjustment
                no-independent-third-party-would-accept
                pattern-of-similar-transactions)
   'case-application "SLG selling to RST below cost, creating R5.4M loss in SLG (PARA 10.5-10.10.23)"
   'inference "Transfer pricing manipulation to shift profits from SLG to RST"
   'related-principles '(arm's-length-transaction substance-over-form)
   'inference-type 'abductive))

(define arm's-length-transaction-test
  (make-principle
   'name 'arm's-length-transaction-test
   'description "Test for whether transaction is at arm's length"
   'domain '(company tax-law)
   'confidence 0.92
   'jurisdiction "za"
   'statutory-basis "Income Tax Act, OECD Transfer Pricing Guidelines"
   'test "Would independent third parties transact on these terms?"
   'arm's-length-factors '(market-price-comparison
                          comparable-uncontrolled-price
                          cost-plus-reasonable-margin
                          resale-price-minus-reasonable-margin
                          profit-split-method)
   'not-arm's-length-indicators '(selling-below-cost
                                 pricing-creates-loss-in-one-entity
                                 pricing-creates-disproportionate-profit-in-other
                                 no-commercial-justification)
   'case-application "SLG sells to RST at prices creating R5.4M loss - not arm's length"
   'inference "No independent third party would sell at loss-making prices"
   'inference-type 'deductive))

(define profit-shifting-pattern-indicator
  (make-principle
   'name 'profit-shifting-pattern-indicator
   'description "Indicator of systematic profit shifting between related entities"
   'domain '(forensic-accounting tax-law)
   'confidence 0.88
   'jurisdiction "za"
   'pattern-indicators '(consistent-loss-in-one-entity
                        consistent-profit-in-related-entity
                        inter-company-pricing-creates-pattern
                        tax-benefit-from-pattern
                        no-business-justification-for-pattern)
   'case-application "SLG creates R5.4M loss, RST shows corresponding profit"
   'inference "Systematic profit shifting from SLG to RST"
   'related-principles '(transfer-pricing-abuse-test substance-over-form)
   'inference-type 'abductive))

;; -----------------------------------------------------------------------------
;; 1.3 Inventory Manipulation Framework
;; -----------------------------------------------------------------------------

(define inventory-manipulation-indicators
  (make-principle
   'name 'inventory-manipulation-indicators
   'description "Indicators of inventory manipulation or fraud"
   'domain '(forensic-accounting)
   'confidence 0.90
   'jurisdiction "za"
   'indicators '(disproportionate-write-off
                no-supporting-documentation
                no-write-off-recovery
                negative-inventory-balance
                timing-year-end
                magnitude-vs-prior-year-extreme
                no-physical-inventory-count
                adjustment-creates-tax-benefit)
   'case-application "SLG R5.2M inventory adjustment with no write-off recovery"
   'inference "Inventory manipulation to create tax loss"
   'related-principles '(accounting-manipulation-indicators)
   'inference-type 'abductive))

(define inventory-write-off-reasonableness-test
  (make-principle
   'name 'inventory-write-off-reasonableness-test
   'description "Test for whether inventory write-off is reasonable"
   'domain '(forensic-accounting)
   'confidence 0.91
   'jurisdiction "za"
   'statutory-basis "IFRS, GAAP, IAS 2 (Inventories)"
   'test-elements '(physical-inventory-count-supports
                   obsolescence-justification
                   damage-or-deterioration-evidence
                   market-value-decline-evidence
                   write-off-recovery-expected
                   magnitude-reasonable-vs-business-scale)
   'red-flags '(no-physical-count
               no-obsolescence-evidence
               no-write-off-recovery
               magnitude-extreme
               timing-suspicious)
   'case-application "SLG R5.2M write-off: no recovery, 10x prior year, 46% of sales"
   'inference "Write-off fails reasonableness test - likely manipulation"
   'inference-type 'deductive))

;; =============================================================================
;; PART 2: INTER-COMPANY TRANSACTION SCRUTINY
;; =============================================================================

;; -----------------------------------------------------------------------------
;; 2.1 Related-Party Transaction Framework
;; -----------------------------------------------------------------------------

(define inter-company-transaction-scrutiny
  (make-principle
   'name 'inter-company-transaction-scrutiny
   'description "Enhanced scrutiny for inter-company transactions in related-party groups"
   'domain '(company forensic-accounting)
   'confidence 0.93
   'jurisdiction "za"
   'statutory-basis "Companies Act 71 of 2008, s75, IFRS"
   'provenance "Related-party transaction disclosure requirements"
   'scrutiny-factors '(common-ownership
                      common-directors
                      pricing-not-arm's-length
                      profit-shifting-pattern
                      tax-benefit-obtained
                      minority-shareholder-prejudice
                      lack-of-independent-approval)
   'disclosure-requirements '(full-disclosure-to-board
                             independent-approval
                             fair-value-determination
                             documentation-of-business-purpose
                             arm's-length-pricing-justification)
   'case-application "SLG-RST transactions (common directors: Peter, Jax, Dan) (PARA 10.5-10.10.23)"
   'inference "Inter-company transactions require enhanced scrutiny and justification"
   'related-principles '(director-self-dealing-prohibition conflict-of-interest)
   'inference-type 'deductive))

(define related-party-pricing-scrutiny
  (make-principle
   'name 'related-party-pricing-scrutiny
   'description "Scrutiny of pricing in related-party transactions"
   'domain '(company forensic-accounting)
   'confidence 0.92
   'jurisdiction "za"
   'scrutiny-standard "Higher standard of justification for non-arm's-length pricing"
   'justification-required '(business-purpose-for-pricing
                            market-conditions-explanation
                            long-term-strategy-justification
                            independent-valuation-support)
   'burden-of-proof "Party benefiting from pricing must justify"
   'case-application "RST benefits from below-cost pricing from SLG - RST must justify"
   'inference-type 'deductive))

;; -----------------------------------------------------------------------------
;; 2.2 Tax Loss Creation Motive
;; -----------------------------------------------------------------------------

(define tax-loss-creation-motive-indicator
  (make-principle
   'name 'tax-loss-creation-motive-indicator
   'description "Indicator that adjustment motivated by tax loss creation"
   'domain '(forensic-accounting tax-law)
   'confidence 0.89
   'jurisdiction "za"
   'indicators '(adjustment-creates-tax-loss
                tax-loss-can-be-carried-forward
                tax-benefit-to-group
                timing-year-end
                no-other-business-justification
                pattern-of-similar-adjustments)
   'case-application "SLG R5.4M loss creates tax asset, timing year-end"
   'inference "Tax loss creation motive for adjustment"
   'related-principles '(accounting-manipulation-indicators)
   'inference-type 'abductive))

(define tax-benefit-analysis
  (make-principle
   'name 'tax-benefit-analysis
   'description "Analysis of tax benefits from accounting adjustments"
   'domain '(forensic-accounting tax-law)
   'confidence 0.90
   'jurisdiction "za"
   'analysis-factors '(tax-loss-created
                      tax-loss-value
                      tax-benefit-to-which-entity
                      timing-of-benefit-realization
                      overall-group-tax-position)
   'case-application "SLG R5.4M loss creates tax asset, RST shows profit"
   'inference "Adjustment shifts tax burden within group"
   'inference-type 'abductive))

;; =============================================================================
;; PART 3: FORENSIC ANALYSIS FRAMEWORK
;; =============================================================================

;; -----------------------------------------------------------------------------
;; 3.1 Comprehensive Forensic Test
;; -----------------------------------------------------------------------------

(define comprehensive-forensic-accounting-test
  (make-principle
   'name 'comprehensive-forensic-accounting-test
   'description "Comprehensive test for accounting manipulation"
   'domain '(forensic-accounting)
   'confidence 0.91
   'jurisdiction "za"
   'test-elements '(adjustment-size-analysis
                   timing-analysis
                   supporting-documentation-analysis
                   beneficiary-analysis
                   pattern-analysis
                   business-justification-analysis
                   tax-benefit-analysis
                   related-party-analysis)
   'scoring-system "More indicators present = higher likelihood of manipulation"
   'threshold "3+ indicators = strong evidence of manipulation"
   'case-application "SLG R5.4M loss analysis"
   'inference-type 'abductive))

(define slg-manufactured-loss-analysis
  (make-principle
   'name 'slg-manufactured-loss-analysis
   'description "Forensic analysis of SLG R5.4M manufactured loss"
   'domain '(forensic-accounting)
   'confidence 0.91
   'jurisdiction "za"
   'case-application "Faucitt v. Faucitt (2025-137857) - PARA 10.5-10.10.23"
   'indicators-present '(adjustment-size-disproportionate
                        timing-suspicious
                        no-supporting-documentation
                        beneficiary-unclear
                        magnitude-vs-prior-year-extreme
                        negative-inventory-balance
                        no-write-off-recovery
                        inter-company-pricing-suspicious
                        tax-loss-creation-motive)
   'indicator-count 9
   'red-flags-present '(negative-finished-goods-inventory
                       no-write-off-recovery
                       10x-prior-year-adjustment
                       46-percent-of-annual-sales
                       year-end-timing
                       related-party-transaction)
   'red-flag-count 6
   'forensic-conclusion "Strong evidence of manufactured loss for tax or profit-shifting purposes"
   'most-plausible-explanation "Transfer pricing manipulation: SLG sells to RST below cost, creating tax loss in SLG while profits appear in RST"
   'related-principles '(accounting-manipulation-indicators transfer-pricing-abuse-test)
   'inference-type 'abductive))

;; =============================================================================
;; HELPER FUNCTIONS
;; =============================================================================

(define (count-manipulation-indicators entity adjustment)
  "Count number of manipulation indicators present"
  (let ((count 0))
    ;; Implement indicator counting logic
    count))

(define (apply-forensic-accounting-test entity adjustment)
  "Apply comprehensive forensic accounting test"
  (let ((test-result (make-hash-table)))
    (hash-set! test-result 'entity entity)
    (hash-set! test-result 'adjustment adjustment)
    (hash-set! test-result 'indicators-present
               (count-manipulation-indicators entity adjustment))
    (hash-set! test-result 'conclusion
               "Analyze all indicators to determine likelihood of manipulation")
    test-result))

(define (apply-transfer-pricing-test seller buyer transaction)
  "Apply transfer pricing abuse test"
  (let ((test-result (make-hash-table)))
    (hash-set! test-result 'seller seller)
    (hash-set! test-result 'buyer buyer)
    (hash-set! test-result 'transaction transaction)
    (hash-set! test-result 'test-elements
               '(related-party-transaction
                 pricing-not-arm's-length
                 profit-shifted-between-entities
                 tax-benefit-obtained
                 no-business-justification))
    (hash-set! test-result 'conclusion
               "Apply each element to determine if transfer pricing abuse present")
    test-result))

;; =============================================================================
;; EXPORT PRINCIPLES
;; =============================================================================

(provide accounting-manipulation-indicators
         adjustment-size-disproportionality
         timing-suspicion-indicator
         negative-inventory-red-flag
         transfer-pricing-abuse-test
         arm's-length-transaction-test
         profit-shifting-pattern-indicator
         inventory-manipulation-indicators
         inventory-write-off-reasonableness-test
         inter-company-transaction-scrutiny
         related-party-pricing-scrutiny
         tax-loss-creation-motive-indicator
         tax-benefit-analysis
         comprehensive-forensic-accounting-test
         slg-manufactured-loss-analysis
         count-manipulation-indicators
         apply-forensic-accounting-test
         apply-transfer-pricing-test)
