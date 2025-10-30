;; South African Company Law - Forensic Accounting Enhanced v3
;; Specialized module for forensic accounting indicators in AD-RES-J7 case
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
   'name "South African Company Law - Forensic Accounting Enhanced v3"
   'jurisdiction "za"
   'legal-domain '(company forensic-accounting fraud)
   'version "3.0"
   'last-updated "2025-10-30"
   'derived-from-level 1
   'confidence-base 0.95
   'language "en"
   'case-application "AD-RES-J7 (Case 2025-137857)"))

;; =============================================================================
;; CRITICAL: REVENUE STREAM HIJACKING INDICATORS
;; =============================================================================

(define revenue-stream-hijacking-indicators
  (make-principle
   'name 'revenue-stream-hijacking-indicators
   'description "Indicators of systematic revenue stream diversion and hijacking"
   'domain '(fraud financial-crime forensic-accounting)
   'confidence 0.95
   'jurisdiction "za"
   'statutory-basis "Companies Act 71/2008 s77 (reckless trading), common law fraud"
   'indicators '(revenue-diverted-to-alternative-channels
                customer-communications-redirected
                payment-instructions-changed
                orders-removed-from-systems
                new-domains-registered
                card-cancellations-preventing-payment
                email-instructions-to-use-alternative-entity
                timing-pattern-of-diversions
                responsible-party-left-with-creditor-obligations
                ability-to-pay-sabotaged)
   'temporal-pattern '(systematic-escalation
                      multiple-diversion-methods
                      coordination-across-entities
                      timing-to-maximize-harm)
   'case-application "Rynette's systematic diversion: RegimA SA (1 Mar), RWD (14 Apr), Shopify removal (23 May), card cancellations (7 Jun), email redirect (20 Jun), account emptying (11 Sep)"
   'harm-analysis "Pattern left Daniel responsible for creditor payments while sabotaging his ability to pay"
   'related-principles '(fraud-indicators reckless-trading-test financial-sabotage-indicators)
   'inference-type 'inductive
   'base-principles (list fraud-indicators)))

;; =============================================================================
;; CRITICAL: EXPENSE DUMPING INDICATORS
;; =============================================================================

(define expense-dumping-indicators
  (make-principle
   'name 'expense-dumping-indicators
   'description "Indicators of systematic expense dumping to disadvantage specific entity"
   'domain '(forensic-accounting transfer-pricing fraud)
   'confidence 0.94
   'jurisdiction "za"
   'statutory-basis "Companies Act 71/2008, Income Tax Act s31"
   'indicators '(disproportionate-expense-allocation
                two-plus-years-unallocated-expenses
                sudden-allocation-to-single-entity
                pressure-to-sign-off-quickly
                timing-before-discovery-of-fraud
                entity-receiving-expenses-becomes-loss-making
                related-entities-remain-profitable
                no-reasonable-allocation-methodology
                controller-has-conflict-of-interest)
   'temporal-analysis "Two years unallocated (during Rynette control) → Sudden dump 30 Mar 2025 → 12-hour pressure to sign"
   'case-application "RWD receives two years of unallocated expenses from all companies, pressured to sign within 12 hours, Dan uses time until 6 Jun to finalize reports and uncover fraud"
   'related-principles '(expense-allocation-reasonableness-test transfer-pricing-abuse-indicators)
   'inference-type 'abductive
   'base-principles (list fraud-indicators)))

;; =============================================================================
;; CRITICAL: INVENTORY ADJUSTMENT REASONABLENESS TEST
;; =============================================================================

(define inventory-adjustment-reasonableness-test
  (make-principle
   'name 'inventory-adjustment-reasonableness-test
   'description "Test for whether inventory adjustments are reasonable or indicate fraud"
   'domain '(forensic-accounting inventory-management fraud)
   'confidence 0.96
   'jurisdiction "za"
   'statutory-basis "Companies Act 71/2008 s29 (financial records), s77 (reckless trading)"
   'red-flags '(adjustment-exceeds-10x-prior-year
               adjustment-percentage-of-sales-exceeds-20-percent
               negative-inventory-balance
               stock-just-disappeared-explanation
               supplier-related-to-controller
               timing-coincides-with-fraud-discovery
               no-physical-inventory-count
               no-reconciliation-documentation)
   'case-application "SLG R5.4M adjustment: 10x prior year, 46% of sales, negative R4.2M finished goods, stock 'just disappeared', same stock type supplied by Adderory (Rynette's son's company)"
   'inference "Multiple red flags indicate manufactured loss rather than legitimate adjustment"
   'related-principles '(transfer-pricing-abuse-indicators related-party-transaction-disclosure)
   'inference-type 'inductive
   'base-principles (list fraud-indicators)))

;; =============================================================================
;; CRITICAL: TRANSFER PRICING ABUSE INDICATORS
;; =============================================================================

(define transfer-pricing-abuse-indicators
  (make-principle
   'name 'transfer-pricing-abuse-indicators
   'description "Indicators of transfer pricing abuse between related entities"
   'domain '(forensic-accounting tax-compliance related-party-transactions)
   'confidence 0.95
   'jurisdiction "za"
   'statutory-basis "Income Tax Act s31, Companies Act s45"
   'indicators '(below-cost-sales-to-related-party
                above-market-purchases-from-related-party
                one-entity-consistently-loss-making
                related-entities-consistently-profitable
                intermediary-entity-related-to-controller
                profit-shifting-pattern
                no-arms-length-pricing
                no-transfer-pricing-documentation)
   'pattern-analysis "SLG → Adderory (Rynette's son) → RST: SLG sells below cost, takes R5.4M loss, RST profitable"
   'case-application "SLG manufactured loss while RST profitable; Adderory intermediary; Rynette controls accounts"
   'related-principles '(related-party-transaction-disclosure arms-length-pricing-test)
   'inference-type 'inductive
   'base-principles (list fraud-indicators)))

;; =============================================================================
;; CRITICAL: FINANCIAL SABOTAGE INDICATORS
;; =============================================================================

(define financial-sabotage-indicators
  (make-principle
   'name 'financial-sabotage-indicators
   'description "Indicators of systematic financial sabotage"
   'domain '(fraud financial-crime tortious-interference)
   'confidence 0.95
   'jurisdiction "za"
   'statutory-basis "Common law delict, Companies Act s77"
   'indicators '(multiple-sabotage-methods
                escalating-pattern
                coordination-across-entities
                timing-to-maximize-harm
                target-left-with-liabilities
                target-ability-to-pay-destroyed
                saboteur-benefits-from-targets-failure)
   'pattern "Systematic escalation over extended period with coordinated actions"
   'case-application "6-month pattern (1 Mar - 11 Sep): revenue diversion → expense dumping → order removal → card cancellation → account emptying"
   'harm "Daniel responsible for creditor payments, ability to pay systematically destroyed"
   'related-principles '(revenue-stream-hijacking-indicators tortious-interference reckless-trading-test)
   'inference-type 'inductive
   'base-principles (list fraud-indicators)))

;; =============================================================================
;; HIGH: RELATED PARTY CONCEALMENT
;; =============================================================================

(define related-party-concealment
  (make-principle
   'name 'related-party-concealment
   'description "Indicators of concealed related party relationships"
   'domain '(company disclosure conflict-of-interest)
   'confidence 0.94
   'jurisdiction "za"
   'statutory-basis "Companies Act 71/2008 s75"
   'indicators '(intermediary-entity-in-transaction-chain
                controller-related-to-intermediary
                no-disclosure-of-relationship
                transaction-pricing-not-arms-length
                pattern-benefits-related-parties
                one-entity-systematically-disadvantaged)
   'case-application "Adderory intermediary between SLG and RST; Rynette (controller) is Adderory owner's mother; SLG loses, RST profits"
   'related-principles '(related-party-transaction-disclosure conflict-of-interest-disclosure)
   'inference-type 'abductive
   'base-principles (list fraud-indicators)))

;; =============================================================================
;; HIGH: EXCESSIVE PROFIT EXTRACTION TEST
;; =============================================================================

(define excessive-profit-extraction-test
  (make-principle
   'name 'excessive-profit-extraction-test
   'description "Test for whether profit extraction from related party is excessive"
   'domain '(company self-dealing related-party-transactions)
   'confidence 0.94
   'jurisdiction "za"
   'statutory-basis "Companies Act 71/2008 s75-76"
   'factors '(profit-margin-percentage
             comparison-to-market-rates
             arms-length-pricing
             disclosure-to-board
             independent-approval
             business-justification)
   'thresholds '((profit-margin-excessive-if-above 50)
                (market-rate-multiple-excessive-if-above 2))
   'case-application "Villa Via 86% profit margin on rent to RST; 2-4x market rates; Peter owns 50% of both"
   'inference "86% margin + 2-4x market rates + no disclosure = excessive profit extraction"
   'related-principles '(director-self-dealing-prohibition related-party-transaction-disclosure)
   'inference-type 'deductive
   'base-principles (list nemo-plus-iuris)))

;; =============================================================================
;; PLACEHOLDER FUNCTIONS FOR FUTURE IMPLEMENTATION
;; =============================================================================

(define (detect-revenue-hijacking transaction-data entity-relationships timeline)
  ;; Analyze transaction patterns for revenue hijacking indicators
  ;; Returns: (confidence indicators evidence)
  'placeholder)

(define (analyze-expense-dumping expense-allocations entity-structure timeline)
  ;; Analyze expense allocation patterns for dumping indicators
  ;; Returns: (confidence red-flags analysis)
  'placeholder)

(define (evaluate-inventory-adjustment adjustment-data historical-data supplier-relationships)
  ;; Evaluate inventory adjustment reasonableness
  ;; Returns: (reasonable? red-flags confidence)
  'placeholder)

(define (detect-transfer-pricing-abuse entity-transactions related-parties pricing-data)
  ;; Detect transfer pricing abuse patterns
  ;; Returns: (abuse-detected? indicators confidence)
  'placeholder)

(define (analyze-financial-sabotage timeline events entities)
  ;; Analyze timeline for financial sabotage patterns
  ;; Returns: (sabotage-pattern confidence harm-analysis)
  'placeholder)

(define (detect-related-party-concealment transaction-chain entity-relationships disclosures)
  ;; Detect concealed related party relationships
  ;; Returns: (concealment-detected? relationships confidence)
  'placeholder)

(define (evaluate-profit-extraction transaction profit-margin market-rates disclosure)
  ;; Evaluate whether profit extraction is excessive
  ;; Returns: (excessive? factors confidence)
  'placeholder)

;; =============================================================================
;; INTEGRATION WITH HYPERGRAPHQL
;; =============================================================================

;; Register all principles with the principle registry
(register-principle! revenue-stream-hijacking-indicators)
(register-principle! expense-dumping-indicators)
(register-principle! inventory-adjustment-reasonableness-test)
(register-principle! transfer-pricing-abuse-indicators)
(register-principle! financial-sabotage-indicators)
(register-principle! related-party-concealment)
(register-principle! excessive-profit-extraction-test)

;; Export principles for use in other modules
(provide revenue-stream-hijacking-indicators
         expense-dumping-indicators
         inventory-adjustment-reasonableness-test
         transfer-pricing-abuse-indicators
         financial-sabotage-indicators
         related-party-concealment
         excessive-profit-extraction-test)

;; =============================================================================
;; END OF MODULE
;; =============================================================================
