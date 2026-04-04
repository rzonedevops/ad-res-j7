;; South African Company Law - Forensic Accounting (Enhanced)
;; Companies Act 71 of 2008 - Forensic Accounting, Transfer Pricing, Expense Dumping
;; =============================================================================
;; Version: 2.0 (Enhanced)
;; Last Updated: 2025-10-30
;; Case-Specific Enhancements: Faucitt v. Faucitt (2025-137857)
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
   'name "South African Company Law - Forensic Accounting (Enhanced)"
   'jurisdiction "za"
   'legal-domain '(company forensic-accounting fraud-detection)
   'version "2.0"
   'last-updated "2025-10-30"
   'derived-from-level 1
   'confidence-base 0.92
   'statutory-basis "Companies Act 71 of 2008, Income Tax Act 58 of 1962"
   'language "en"
   'case-specific-enhancements "Faucitt v. Faucitt (2025-137857)"))

;; =============================================================================
;; PART 1: EXPENSE DUMPING FRAMEWORK
;; =============================================================================

;; -----------------------------------------------------------------------------
;; 1.1 Expense Dumping Indicators
;; -----------------------------------------------------------------------------

(define expense-dumping-indicators
  (derive-from-principles
   'name 'expense-dumping-indicators
   'base-principles (list bona-fides venire-contra-factum-proprium)
   'inference-type 'inductive
   'description "Indicators of systematic expense dumping to specific entity"
   'domain '(company accounting-fraud inter-company-transactions)
   'confidence 0.92
   'jurisdiction "za"
   'statutory-basis "Companies Act 71 of 2008, s22 (fair dealing), s76 (director duties)"
   'indicators '(disproportionate-expense-allocation
                entity-bears-group-expenses
                no-corresponding-revenue-allocation
                other-entities-profit-while-target-loses
                systematic-pattern-over-time
                no-legitimate-business-justification
                expense-allocation-inconsistent-with-operations
                target-entity-lacks-resources-to-generate-expenses)
   'test-elements '(identify-expense-allocation-pattern
                   compare-expense-ratios-across-entities
                   analyze-profit-distribution
                   assess-business-justification
                   examine-historical-patterns
                   evaluate-operational-capacity)
   'case-application "RWD forced to pay group expenses while SLG/RST profit"
   'case-specific-facts '("RWD bears disproportionate IT expenses"
                         "RWD shows losses while RST/SLG profit"
                         "No corresponding revenue allocation to RWD"
                         "Systematic pattern over multiple years"
                         "RWD lacks operational capacity to generate such expenses")
   'evidence-location "AD/1-Critical/PARA_10_5-10_10_23_DAN_FINANCIAL.md"
   'legal-consequences '(director-liability
                        accounting-restatement
                        inter-company-claims
                        shareholder-oppression-claim)
   'related-principles '(transfer-pricing-abuse accounting-fraud-indicators director-duty-of-care)
   'provenance "Derived from bona-fides and fair dealing principles"))

(define expense-dumping-test
  (make-principle
   'name 'expense-dumping-test
   'description "Test for whether expense allocation constitutes improper expense dumping"
   'domain '(company accounting-fraud inter-company-transactions)
   'confidence 0.91
   'jurisdiction "za"
   'test-elements '(disproportionate-allocation
                   no-business-justification
                   systematic-pattern
                   profit-extraction-from-other-entities
                   target-entity-harmed)
   'burden-of-proof "Party alleging expense dumping must prove disproportionate allocation and lack of justification"
   'defense "Legitimate business justification for expense allocation"
   'remedies '(reallocation-of-expenses
              inter-company-claims
              director-liability
              accounting-restatement)
   'case-application "RWD expense dumping analysis"
   'inference-type 'deductive))

;; -----------------------------------------------------------------------------
;; 1.2 Expense Allocation Reasonableness
;; -----------------------------------------------------------------------------

(define expense-allocation-reasonableness-test
  (make-principle
   'name 'expense-allocation-reasonableness-test
   'description "Test for whether inter-company expense allocation is reasonable"
   'domain '(company inter-company-transactions)
   'confidence 0.93
   'jurisdiction "za"
   'statutory-basis "Companies Act 71 of 2008, s22 (fair dealing)"
   'test-factors '(proportional-to-benefit-received
                  consistent-with-operations
                  arms-length-basis
                  documented-allocation-methodology
                  business-justification-exists)
   'allocation-methods '(revenue-based
                        headcount-based
                        usage-based
                        cost-driver-based
                        direct-attribution)
   'red-flags '(no-documented-methodology
               allocation-inconsistent-with-operations
               disproportionate-to-benefit
               systematic-disadvantage-to-one-entity
               allocation-changed-without-justification)
   'case-application "RWD expense allocation analysis"
   'related-principles '(expense-dumping-indicators transfer-pricing-abuse)
   'inference-type 'deductive))

;; =============================================================================
;; PART 2: TRANSFER PRICING ABUSE FRAMEWORK
;; =============================================================================

;; -----------------------------------------------------------------------------
;; 2.1 Transfer Pricing Abuse Indicators
;; -----------------------------------------------------------------------------

(define transfer-pricing-abuse-indicators
  (derive-from-principles
   'name 'transfer-pricing-abuse-indicators
   'base-principles (list bona-fides venire-contra-factum-proprium)
   'inference-type 'abductive
   'description "Indicators of transfer pricing manipulation between related entities"
   'domain '(company accounting-fraud inter-company-transactions)
   'confidence 0.93
   'jurisdiction "za"
   'statutory-basis "Companies Act 71 of 2008, Income Tax Act 58 of 1962 s31"
   'indicators '(below-cost-sales-to-related-parties
                disproportionate-profit-distribution
                artificial-loss-creation
                inventory-adjustments-without-justification
                negative-inventory-balances
                no-arms-length-pricing
                profit-shifting-pattern
                tax-loss-creation-in-one-entity
                profit-concentration-in-another-entity)
   'test-elements '(identify-related-parties
                   compare-transfer-prices-to-market-prices
                   analyze-profit-distribution-pattern
                   examine-inventory-adjustments
                   assess-business-justification
                   evaluate-arms-length-standard)
   'case-application "SLG R5.4M loss via R5.2M inventory adjustment, selling to RST below cost"
   'case-specific-facts '("SLG R5.4M manufactured loss"
                         "R5.2M inventory adjustment (10x prior year)"
                         "46% of annual sales"
                         "Negative R4.2M finished goods inventory"
                         "SLG sells to RST (related party)"
                         "RST profits while SLG loses")
   'evidence-location "AD/1-Critical/PARA_10_5-10_10_23_DAN_FINANCIAL.md"
   'legal-consequences '(tax-adjustment
                        director-liability
                        accounting-restatement
                        shareholder-oppression-claim
                        fraud-investigation)
   'related-principles '(accounting-fraud-indicators expense-dumping-indicators)
   'provenance "Derived from bona-fides and fair dealing principles"))

(define transfer-pricing-arms-length-test
  (make-principle
   'name 'transfer-pricing-arms-length-test
   'description "Test for whether inter-company pricing meets arms-length standard"
   'domain '(company inter-company-transactions tax)
   'confidence 0.94
   'jurisdiction "za"
   'statutory-basis "Income Tax Act 58 of 1962, s31"
   'test "Would unrelated parties transact at this price in similar circumstances?"
   'methods '(comparable-uncontrolled-price
             resale-price-method
             cost-plus-method
             profit-split-method
             transactional-net-margin-method)
   'factors '(market-prices
             industry-benchmarks
             profit-margins
             business-functions
             risks-assumed
             assets-employed)
   'red-flags '(below-cost-pricing
               excessive-profit-margins
               inconsistent-with-market
               profit-shifting-pattern)
   'burden-of-proof "Taxpayer must prove arms-length pricing"
   'remedies '(price-adjustment
              tax-assessment
              penalties
              interest)
   'case-application "SLG to RST transfer pricing analysis"
   'inference-type 'deductive))

;; -----------------------------------------------------------------------------
;; 2.2 Inventory Adjustment Reasonableness
;; -----------------------------------------------------------------------------

(define inventory-adjustment-reasonableness-test
  (make-principle
   'name 'inventory-adjustment-reasonableness-test
   'description "Test for whether inventory adjustments are reasonable or indicative of manipulation"
   'domain '(company accounting forensic-accounting)
   'confidence 0.92
   'jurisdiction "za"
   'statutory-basis "Companies Act 71 of 2008, IFRS inventory standards"
   'test-factors '(magnitude-compared-to-prior-years
                  percentage-of-sales
                  business-justification
                  supporting-documentation
                  write-off-recovery
                  inventory-count-verification)
   'red-flags '(adjustment-10x-prior-year
               adjustment-exceeds-40-percent-of-sales
               no-supporting-documentation
               no-write-off-recovery
               negative-inventory-balances
               timing-coincides-with-tax-planning)
   'suspicious-indicators '(finished-goods-inventory-negative
                           raw-materials-inventory-excessive
                           adjustment-creates-tax-loss
                           adjustment-benefits-related-party)
   'case-application "SLG R5.2M inventory adjustment (10x prior year, 46% of sales)"
   'case-specific-red-flags '("10x prior year adjustment"
                             "46% of annual sales"
                             "No write-off recovery"
                             "Negative R4.2M finished goods inventory"
                             "Creates R5.4M tax loss")
   'evidence-location "AD/1-Critical/PARA_10_5-10_10_23_DAN_FINANCIAL.md"
   'legal-consequences '(accounting-restatement
                        auditor-investigation
                        tax-adjustment
                        fraud-investigation)
   'related-principles '(transfer-pricing-abuse-indicators accounting-fraud-indicators)
   'inference-type 'inductive))

;; -----------------------------------------------------------------------------
;; 2.3 Negative Inventory Balance Indicators
;; -----------------------------------------------------------------------------

(define negative-inventory-balance-indicators
  (make-principle
   'name 'negative-inventory-balance-indicators
   'description "Indicators that negative inventory balances represent accounting fiction"
   'domain '(company accounting-fraud forensic-accounting)
   'confidence 0.95
   'jurisdiction "za"
   'statutory-basis "IFRS inventory standards, Companies Act 71 of 2008"
   'principle "Inventory cannot be physically negative - negative balance indicates accounting error or manipulation"
   'indicators '(finished-goods-inventory-negative
                cannot-sell-what-does-not-exist
                indicates-sales-without-corresponding-production
                suggests-inventory-given-away-without-recording
                may-indicate-transfer-pricing-manipulation)
   'case-application "SLG negative R4.2M finished goods inventory"
   'interpretation '("Either sold inventory not yet produced (impossible)"
                    "Or gave inventory to related parties without proper invoicing"
                    "Or manipulated inventory to create artificial loss")
   'legal-significance "Strong evidence of accounting manipulation"
   'related-principles '(transfer-pricing-abuse-indicators inventory-adjustment-reasonableness-test)
   'inference-type 'deductive))

;; =============================================================================
;; PART 3: SETTLEMENT MANIPULATION FRAMEWORK
;; =============================================================================

;; -----------------------------------------------------------------------------
;; 3.1 Settlement Manipulation Indicators
;; -----------------------------------------------------------------------------

(define settlement-manipulation-indicators
  (derive-from-principles
   'name 'settlement-manipulation-indicators
   'base-principles (list bona-fides abuse-of-process)
   'inference-type 'inductive
   'description "Indicators of bad faith settlement manipulation"
   'domain '(procedure bad-faith settlement)
   'confidence 0.91
   'jurisdiction "za"
   'statutory-basis "Common law abuse of process"
   'indicators '(settlement-reached-then-immediate-litigation
                timing-coincides-with-financial-events
                settlement-used-as-pretext-for-urgency
                inconsistent-positions-before-and-after-settlement
                strategic-timing-for-leverage
                settlement-terms-ignored-immediately
                litigation-timed-with-investment-payout)
   'suspicious-patterns '(settlement-to-litigation-gap-less-than-week
                         litigation-timed-with-investment-payout
                         settlement-terms-ignored-immediately
                         urgency-claimed-but-delay-before-settlement
                         settlement-negotiation-used-as-cover)
   'case-application "Settlement Aug 11 → Interdict Aug 14 (3 days) → Investment payout May 2026 (9 months)"
   'case-specific-facts '("Settlement reached August 11, 2025"
                         "Interdict filed August 14, 2025 (3 days later)"
                         "Investment payout due May 2026 (9 months away)"
                         "Urgency claimed but 9-month wait for payout"
                         "Settlement used as pretext for manufactured urgency")
   'evidence-location "AD/3-Medium-Priority/PARA_12_3_DAN_SETTLEMENT_TIMING.md"
   'legal-consequences '(interdict-set-aside
                        material-non-disclosure
                        abuse-of-process
                        personal-costs-order)
   'related-principles '(timing-analysis-bad-faith manufactured-urgency-indicators abuse-of-process)
   'provenance "Derived from bona-fides and abuse of process principles"))

(define settlement-timing-analysis
  (make-principle
   'name 'settlement-timing-analysis
   'description "Analysis of settlement timing for bad faith indicators"
   'domain '(procedure bad-faith settlement)
   'confidence 0.90
   'jurisdiction "za"
   'analysis-factors '(time-between-settlement-and-litigation
                      time-between-litigation-and-claimed-urgency-event
                      consistency-of-urgency-claim-with-timing
                      strategic-advantage-from-timing
                      pattern-of-delay-then-urgency)
   'red-flags '(settlement-to-litigation-less-than-week
               litigation-to-event-more-than-six-months
               urgency-claimed-for-distant-event
               timing-creates-leverage
               settlement-negotiation-abandoned-immediately)
   'case-application "Settlement-to-interdict 3 days, interdict-to-payout 9 months"
   'inference "Timing inconsistent with genuine urgency, suggests strategic manipulation"
   'related-principles '(settlement-manipulation-indicators manufactured-urgency-indicators)
   'inference-type 'abductive))

;; =============================================================================
;; PART 4: FORENSIC ACCOUNTING ANALYSIS FUNCTIONS
;; =============================================================================

;; -----------------------------------------------------------------------------
;; 4.1 Expense Dumping Analysis
;; -----------------------------------------------------------------------------

(define (analyze-expense-dumping entities expense-data)
  "Analyze expense allocation patterns for expense dumping indicators"
  (let ((expense-ratios (calculate-expense-ratios entities expense-data))
        (profit-patterns (analyze-profit-distribution entities))
        (allocation-justification (assess-allocation-justification entities)))
    (make-analysis-result
     'test 'expense-dumping-indicators
     'entities entities
     'expense-ratios expense-ratios
     'profit-patterns profit-patterns
     'justification allocation-justification
     'indicators-present (count-indicators-present expense-dumping-indicators entities)
     'confidence (calculate-confidence expense-dumping-indicators entities)
     'conclusion (determine-expense-dumping-conclusion entities expense-data))))

(define (calculate-expense-ratios entities expense-data)
  "Calculate expense-to-revenue ratios for each entity"
  (map (lambda (entity)
         (let ((expenses (get-total-expenses entity expense-data))
               (revenue (get-total-revenue entity expense-data)))
           (list entity (/ expenses revenue))))
       entities))

(define (analyze-profit-distribution entities)
  "Analyze profit distribution patterns across entities"
  (map (lambda (entity)
         (list entity 
               (get-profit entity)
               (get-profit-margin entity)))
       entities))

;; -----------------------------------------------------------------------------
;; 4.2 Transfer Pricing Analysis
;; -----------------------------------------------------------------------------

(define (analyze-transfer-pricing related-parties transactions)
  "Analyze transfer pricing for arms-length compliance"
  (let ((pricing-analysis (compare-to-market-prices transactions))
        (profit-distribution (analyze-profit-distribution related-parties))
        (inventory-analysis (analyze-inventory-adjustments related-parties)))
    (make-analysis-result
     'test 'transfer-pricing-abuse-indicators
     'parties related-parties
     'pricing-analysis pricing-analysis
     'profit-distribution profit-distribution
     'inventory-analysis inventory-analysis
     'indicators-present (count-indicators-present transfer-pricing-abuse-indicators related-parties)
     'confidence (calculate-confidence transfer-pricing-abuse-indicators related-parties)
     'conclusion (determine-transfer-pricing-conclusion related-parties transactions))))

(define (compare-to-market-prices transactions)
  "Compare transfer prices to market prices"
  (map (lambda (transaction)
         (let ((transfer-price (get-price transaction))
               (market-price (get-market-price transaction))
               (cost (get-cost transaction)))
           (list transaction
                 transfer-price
                 market-price
                 (- transfer-price market-price)
                 (< transfer-price cost))))
       transactions))

(define (analyze-inventory-adjustments entities)
  "Analyze inventory adjustments for reasonableness"
  (map (lambda (entity)
         (let ((adjustment (get-inventory-adjustment entity))
               (prior-year (get-prior-year-adjustment entity))
               (sales (get-annual-sales entity)))
           (list entity
                 adjustment
                 (/ adjustment prior-year)  ;; Multiple of prior year
                 (/ adjustment sales)       ;; Percentage of sales
                 (get-inventory-balance entity 'finished-goods)
                 (negative? (get-inventory-balance entity 'finished-goods)))))
       entities))

;; -----------------------------------------------------------------------------
;; 4.3 Settlement Timing Analysis
;; -----------------------------------------------------------------------------

(define (analyze-settlement-timing settlement-date litigation-date event-date)
  "Analyze settlement timing for bad faith indicators"
  (let ((settlement-to-litigation (days-between settlement-date litigation-date))
        (litigation-to-event (days-between litigation-date event-date))
        (settlement-to-event (days-between settlement-date event-date)))
    (make-analysis-result
     'test 'settlement-manipulation-indicators
     'settlement-date settlement-date
     'litigation-date litigation-date
     'event-date event-date
     'settlement-to-litigation-days settlement-to-litigation
     'litigation-to-event-days litigation-to-event
     'red-flags (list
                 (< settlement-to-litigation 7)  ;; Less than week
                 (> litigation-to-event 180)     ;; More than 6 months
                 (> litigation-to-event (* 30 settlement-to-litigation)))  ;; Disproportionate
     'indicators-present (count-indicators-present settlement-manipulation-indicators 
                                                  (list settlement-date litigation-date event-date))
     'confidence (calculate-confidence settlement-manipulation-indicators 
                                      (list settlement-date litigation-date event-date))
     'conclusion (determine-settlement-timing-conclusion settlement-to-litigation litigation-to-event))))

;; =============================================================================
;; PART 5: CONFIDENCE CALCULATION
;; =============================================================================

(define (calculate-confidence principle entities)
  "Calculate confidence score for principle application"
  (let ((base-confidence (get-attribute principle 'confidence))
        (indicators-present (count-indicators-present principle entities))
        (total-indicators (length (get-attribute principle 'indicators))))
    (* base-confidence (/ indicators-present total-indicators))))

(define (count-indicators-present principle entities)
  "Count how many indicators are present in the evidence"
  ;; Placeholder - would analyze actual evidence
  (length (get-attribute principle 'indicators)))

;; =============================================================================
;; PRINCIPLE REGISTRY
;; =============================================================================

(register-principle! expense-dumping-indicators)
(register-principle! expense-dumping-test)
(register-principle! expense-allocation-reasonableness-test)
(register-principle! transfer-pricing-abuse-indicators)
(register-principle! transfer-pricing-arms-length-test)
(register-principle! inventory-adjustment-reasonableness-test)
(register-principle! negative-inventory-balance-indicators)
(register-principle! settlement-manipulation-indicators)
(register-principle! settlement-timing-analysis)

;; =============================================================================
;; EXPORTS
;; =============================================================================

(provide expense-dumping-indicators
         expense-dumping-test
         expense-allocation-reasonableness-test
         transfer-pricing-abuse-indicators
         transfer-pricing-arms-length-test
         inventory-adjustment-reasonableness-test
         negative-inventory-balance-indicators
         settlement-manipulation-indicators
         settlement-timing-analysis
         analyze-expense-dumping
         analyze-transfer-pricing
         analyze-settlement-timing)
