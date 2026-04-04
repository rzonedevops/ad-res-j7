;; South African Company Law - Forensic Accounting Enhanced v4
;; New principles for ad-res-j7 case profile optimization
;; Date: 2025-11-02
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
   'name "South African Company Law - Forensic Accounting Enhanced v4"
   'jurisdiction "za"
   'legal-domain '(company forensic-accounting fraud)
   'version "4.0"
   'last-updated "2025-11-02"
   'derived-from-level 1
   'confidence-base 0.94
   'language "en"
   'case-profile "ad-res-j7"))

;; =============================================================================
;; NEW PRINCIPLE 1: UNAUTHORIZED EMAIL CONTROL INDICATORS
;; =============================================================================

(define unauthorized-email-control-indicators
  (make-principle
   'name 'unauthorized-email-control-indicators
   'description "Indicators of unauthorized email control and financial authority abuse"
   'domain '(company fiduciary fraud forensic-accounting)
   'confidence 0.94
   'jurisdiction "za"
   'statutory-basis "Companies Act 71 of 2008, s76 (director duties)"
   'common-law-basis "Fiduciary duty, fraud prevention"
   'base-principles '(fiduciary-duty proper-purpose-test)
   'inference-type 'abductive
   
   ;; Core indicators
   'indicators '(email-control-without-authorization
                financial-authority-without-board-resolution
                accountant-uses-director-email
                multiple-accounts-opened-with-stolen-credentials
                financial-decisions-made-without-director-knowledge
                email-used-to-authorize-transactions
                director-unaware-of-email-usage
                systematic-pattern-over-time)
   
   ;; Red flags for detection
   'red-flags '((email-control-duration-exceeds-6-months 0.95)
               (financial-transactions-exceed-r1m 0.96)
               (multiple-bank-accounts-opened 0.94)
               (director-explicitly-denied-authorization 0.98)
               (accountant-has-conflicting-interests 0.93)
               (email-used-for-sage-accounting-system 0.95))
   
   ;; Evidence requirements
   'evidence-required '(email-login-records
                       sage-screenshots-showing-email
                       bank-account-opening-documents
                       director-testimony-of-no-authorization
                       financial-transaction-records
                       board-resolution-absence)
   
   ;; Legal implications
   'legal-implications '(breach-of-fiduciary-duty
                        fraud-indicators
                        unauthorized-financial-authority
                        potential-criminal-liability
                        voidable-transactions
                        director-protection-from-liability)
   
   ;; Inference logic
   'inference "Unauthorized email control combined with financial authority abuse enables systematic fraud and breach of fiduciary duty"
   
   ;; Case application
   'case-application "Rynette controlled Peter's email (pete@regima.com) and all company accounts/banks. Sage screenshots from June and August 2025 show Rynette using Peter's email. Rynette may have opened 8 ABSA accounts using Daniel's stolen card."
   
   ;; Related principles
   'related-principles '(fiduciary-duty 
                        accountant-professional-duty 
                        fraud-indicators
                        director-collective-action-requirement
                        conflict-of-interest-prohibition)
   
   ;; Remedies
   'remedies '(void-unauthorized-transactions
              restore-proper-financial-controls
              remove-unauthorized-access
              damages-for-breach-of-fiduciary-duty
              criminal-prosecution-for-fraud)))

;; =============================================================================
;; NEW PRINCIPLE 2: STRATEGIC ENTITY EXCLUSION INDICATORS
;; =============================================================================

(define strategic-entity-exclusion-indicators
  (make-principle
   'name 'strategic-entity-exclusion-indicators
   'description "Indicators of strategic entity exclusion from group framing to hide profit extraction"
   'domain '(company forensic-accounting fraud disclosure)
   'confidence 0.93
   'jurisdiction "za"
   'statutory-basis "Companies Act 71 of 2008, s75 (personal financial interests)"
   'common-law-basis "Material non-disclosure, fraud by omission"
   'base-principles '(fiduciary-duty material-non-disclosure)
   'inference-type 'abductive
   
   ;; Core indicators
   'indicators '(entity-excluded-from-group-framing
                entity-central-to-financial-flows
                entity-has-excessive-profit-margins
                entity-has-related-party-relationships
                entity-not-disclosed-in-legal-proceedings
                entity-not-in-consolidated-financials
                strategic-omission-pattern
                disclosure-would-reveal-fraud)
   
   ;; Red flags for detection
   'red-flags '((profit-margin-exceeds-50-percent 0.96)
               (transaction-volume-exceeds-r1m-annually 0.94)
               (related-party-same-directors 0.95)
               (entity-omitted-from-founding-affidavit 0.97)
               (entity-provides-services-to-group 0.93)
               (rates-significantly-above-market 0.94))
   
   ;; Evidence requirements
   'evidence-required '(financial-statements-showing-transactions
                       group-structure-documents
                       founding-affidavit-analysis
                       related-party-disclosure-absence
                       market-rate-comparison
                       profit-margin-analysis)
   
   ;; Legal implications
   'legal-implications '(material-non-disclosure
                        fraud-by-omission
                        breach-of-fiduciary-duty
                        self-dealing-concealment
                        voidable-transactions
                        credibility-destruction)
   
   ;; Inference logic
   'inference "Strategic exclusion of entities from group framing, especially when central to financial flows with excessive profits, suggests intentional concealment of fraud"
   
   ;; Case application
   "Villa Via (Peter 50%, Danie 50%) excluded from 'Group' framing despite: (1) 86% profit margin, (2) 2-4x market rent rates, (3) central to RST financial flows, (4) not disclosed in Peter's founding affidavit. Entities like SLG, RST, RWD framed as 'Group' while Villa Via strategically excluded."
   
   ;; Related principles
   'related-principles '(material-non-disclosure
                        related-party-transaction-disclosure
                        excessive-profit-extraction-test
                        director-self-dealing-prohibition
                        fraud-indicators)
   
   ;; Remedies
   'remedies '(compel-full-disclosure
              void-concealed-transactions
              damages-for-excessive-profits
              adjust-financial-statements
              credibility-impeachment)))

;; =============================================================================
;; NEW PRINCIPLE 3: CREDITOR OBLIGATION SABOTAGE INDICATORS
;; =============================================================================

(define creditor-obligation-sabotage-indicators
  (make-principle
   'name 'creditor-obligation-sabotage-indicators
   'description "Indicators of systematic sabotage of ability to meet creditor obligations"
   'domain '(company fiduciary fraud forensic-accounting)
   'confidence 0.94
   'jurisdiction "za"
   'statutory-basis "Companies Act 71 of 2008, s76 (director duties), Insolvency Act 24 of 1936"
   'common-law-basis "Fiduciary duty, fraud, reckless trading"
   'base-principles '(fiduciary-duty proper-purpose-test)
   'inference-type 'inductive
   
   ;; Core indicators
   'indicators '(revenue-streams-systematically-diverted
                financial-access-removed
                creditor-obligations-remain-with-target
                systematic-pattern-over-extended-period
                timing-correlates-with-fraud-exposure
                multiple-coordinated-actions
                target-left-unable-to-pay-creditors
                sabotage-escalates-over-time)
   
   ;; Red flags for detection
   'red-flags '((sabotage-duration-exceeds-3-months 0.94)
               (multiple-revenue-streams-diverted 0.96)
               (bank-access-removed 0.95)
               (card-cancellations-without-notice 0.96)
               (timing-correlates-with-report-submission 0.97)
               (accounts-emptied-after-6-months 0.95)
               (creditor-obligations-exceed-r1m 0.93))
   
   ;; Timeline pattern analysis
   'timeline-pattern '((revenue-diversion-starts "First action in pattern")
                      (financial-access-progressively-removed "Escalating sabotage")
                      (fraud-exposure-triggers-acceleration "Retaliation correlation")
                      (final-account-emptying "Complete financial cutoff"))
   
   ;; Evidence requirements
   'evidence-required '(timeline-of-sabotage-actions
                       bank-correspondence-showing-diversions
                       card-cancellation-records
                       creditor-obligation-documentation
                       revenue-stream-analysis
                       correlation-with-fraud-exposure-events)
   
   ;; Legal implications
   'legal-implications '(breach-of-fiduciary-duty
                        fraud-indicators
                        reckless-trading
                        intentional-harm
                        bad-faith-conduct
                        director-liability-for-creditor-losses)
   
   ;; Inference logic
   'inference "Systematic sabotage of ability to pay creditors while obligations remain demonstrates bad faith, breach of fiduciary duty, and potential fraud"
   
   ;; Case application
   "Dan's revenue streams hijacked over 6 months (1 Mar - 11 Sep 2025): (1) RegimA SA diversion 1 Mar, (2) RWD bank letter 14 Apr, (3) Orders removed 22 May, (4) Cards cancelled 7 Jun (day after fraud reports submitted), (5) Email instruction to avoid regima.zone 20 Jun, (6) Accounts emptied 11 Sep. Dan left responsible for creditor payments while ability to pay systematically sabotaged."
   
   ;; Related principles
   'related-principles '(revenue-stream-hijacking-indicators
                        manufactured-crisis-indicators
                        fraud-exposure-retaliation-indicators
                        fiduciary-duty
                        director-collective-action-requirement)
   
   ;; Remedies
   'remedies '(restore-revenue-streams
              damages-for-lost-income
              director-liability-for-creditor-losses
              void-unauthorized-diversions
              injunctive-relief-to-prevent-further-sabotage)))

;; =============================================================================
;; NEW PRINCIPLE 4: PLATFORM VALUATION METHODOLOGY
;; =============================================================================

(define platform-valuation-methodology
  (make-principle
   'name 'platform-valuation-methodology
   'description "Methodology for valuing e-commerce platform usage in quantum meruit calculations"
   'domain '(civil unjust-enrichment forensic-accounting)
   'confidence 0.95
   'jurisdiction "za"
   'statutory-basis "Common law - unjust enrichment, quantum meruit"
   'base-principles '(unjust-enrichment-test quantum-meruit)
   'inference-type 'deductive
   
   ;; Valuation factors
   'valuation-factors '(platform-subscription-costs
                       infrastructure-investment
                       maintenance-costs
                       development-costs
                       comparable-market-rates
                       usage-duration-months
                       transaction-volume
                       revenue-generated-through-platform
                       platform-complexity
                       integration-costs)
   
   ;; Calculation methodology
   'calculation-method "Sum of: (1) Platform subscription costs over usage period, (2) Proportional infrastructure investment, (3) Maintenance costs, (4) Development costs, compared with (5) Comparable market rates for similar platforms"
   
   ;; Comparable market rates
   'market-rate-benchmarks '((shopify-plus-monthly 2000-10000)
                            (custom-ecommerce-platform-monthly 5000-20000)
                            (enterprise-platform-monthly 10000-50000)
                            (infrastructure-hosting-monthly 500-5000)
                            (development-costs-once-off 50000-500000))
   
   ;; Valuation tiers
   'valuation-tiers '((basic-usage "Subscription costs + hosting")
                     (standard-usage "Subscription + hosting + maintenance")
                     (full-usage "All costs + development + integration")
                     (enterprise-usage "Full costs + opportunity cost"))
   
   ;; Evidence requirements
   'evidence-required '(platform-subscription-invoices
                       infrastructure-investment-records
                       maintenance-cost-documentation
                       development-cost-records
                       usage-duration-documentation
                       transaction-volume-records
                       comparable-market-rate-analysis)
   
   ;; Calculation example
   'calculation-example "RegimA Zone Ltd platform used by RWD for 28 months:
   - Shopify Plus subscription: R2,000/month × 28 = R56,000
   - Infrastructure investment (proportional): R500,000 × 30% = R150,000
   - Maintenance costs: R10,000/month × 28 = R280,000
   - Development costs (proportional): R1,000,000 × 30% = R300,000
   - Total: R786,000 (conservative)
   - Market rate comparison: R5,000-R15,000/month × 28 = R140,000-R420,000
   - Range: R786,000 - R2,940,000 (depending on valuation tier)"
   
   ;; Legal implications
   'legal-implications '(unjust-enrichment-established
                        quantum-meruit-calculation
                        restitutionary-remedy
                        platform-owner-entitled-to-compensation)
   
   ;; Inference logic
   'inference "Platform usage without payment constitutes unjust enrichment; quantum meruit valuation based on actual costs and comparable market rates"
   
   ;; Case application
   "RWD used Dan's UK company (RegimA Zone Ltd) platform for 28 months without payment. Platform includes Shopify infrastructure, custom development, hosting, and maintenance. Quantum meruit calculation: R2.94M-R6.88M depending on valuation methodology."
   
   ;; Related principles
   'related-principles '(unjust-enrichment-test
                        quantum-meruit
                        cross-border-director-duties
                        fiduciary-duty)
   
   ;; Remedies
   'remedies '(restitutionary-payment-for-platform-usage
              ongoing-platform-fees-if-usage-continues
              damages-for-lost-opportunity
              injunctive-relief-to-prevent-further-usage)))

;; =============================================================================
;; HELPER FUNCTIONS
;; =============================================================================

;; Function to evaluate unauthorized email control indicators
(define (evaluate-unauthorized-email-control evidence)
  (let ((indicator-count (count-matching-indicators 
                          evidence 
                          (get-attribute unauthorized-email-control-indicators 'indicators)))
        (red-flag-score (calculate-red-flag-score 
                        evidence 
                        (get-attribute unauthorized-email-control-indicators 'red-flags))))
    (make-evaluation
     'principle 'unauthorized-email-control-indicators
     'indicator-count indicator-count
     'red-flag-score red-flag-score
     'confidence (if (>= indicator-count 4) 0.94 (* 0.94 (/ indicator-count 4)))
     'conclusion (if (and (>= indicator-count 4) (>= red-flag-score 0.90))
                    "Strong evidence of unauthorized email control and financial authority abuse"
                    "Insufficient evidence for unauthorized email control"))))

;; Function to evaluate strategic entity exclusion
(define (evaluate-strategic-entity-exclusion entity evidence)
  (let ((indicator-count (count-matching-indicators 
                          evidence 
                          (get-attribute strategic-entity-exclusion-indicators 'indicators)))
        (red-flag-score (calculate-red-flag-score 
                        evidence 
                        (get-attribute strategic-entity-exclusion-indicators 'red-flags))))
    (make-evaluation
     'principle 'strategic-entity-exclusion-indicators
     'entity entity
     'indicator-count indicator-count
     'red-flag-score red-flag-score
     'confidence (if (>= indicator-count 5) 0.93 (* 0.93 (/ indicator-count 5)))
     'conclusion (if (and (>= indicator-count 5) (>= red-flag-score 0.90))
                    "Strong evidence of strategic entity exclusion to hide profit extraction"
                    "Insufficient evidence for strategic entity exclusion"))))

;; Function to evaluate creditor obligation sabotage
(define (evaluate-creditor-obligation-sabotage timeline evidence)
  (let ((action-count (length timeline))
        (duration-months (calculate-duration-months timeline))
        (indicator-count (count-matching-indicators 
                          evidence 
                          (get-attribute creditor-obligation-sabotage-indicators 'indicators)))
        (red-flag-score (calculate-red-flag-score 
                        evidence 
                        (get-attribute creditor-obligation-sabotage-indicators 'red-flags))))
    (make-evaluation
     'principle 'creditor-obligation-sabotage-indicators
     'action-count action-count
     'duration-months duration-months
     'indicator-count indicator-count
     'red-flag-score red-flag-score
     'confidence (if (and (>= action-count 5) (>= duration-months 3)) 0.94 0.80)
     'conclusion (if (and (>= action-count 5) (>= duration-months 3) (>= red-flag-score 0.90))
                    "Strong evidence of systematic creditor obligation sabotage"
                    "Insufficient evidence for systematic sabotage pattern"))))

;; Function to calculate platform valuation
(define (calculate-platform-valuation usage-data valuation-tier)
  (let* ((subscription-costs (get-attribute usage-data 'subscription-costs))
         (infrastructure-investment (get-attribute usage-data 'infrastructure-investment))
         (maintenance-costs (get-attribute usage-data 'maintenance-costs))
         (development-costs (get-attribute usage-data 'development-costs))
         (usage-months (get-attribute usage-data 'usage-months))
         (market-rate-low (get-attribute usage-data 'market-rate-low))
         (market-rate-high (get-attribute usage-data 'market-rate-high)))
    (case valuation-tier
      ((basic-usage)
       (+ subscription-costs (* (get-attribute usage-data 'hosting-monthly) usage-months)))
      ((standard-usage)
       (+ subscription-costs 
          (* (get-attribute usage-data 'hosting-monthly) usage-months)
          maintenance-costs))
      ((full-usage)
       (+ subscription-costs
          infrastructure-investment
          maintenance-costs
          development-costs))
      ((enterprise-usage)
       (max (+ subscription-costs
               infrastructure-investment
               maintenance-costs
               development-costs)
            (* market-rate-high usage-months)))
      (else
       (make-valuation-range
        'low (+ subscription-costs (* market-rate-low usage-months))
        'high (+ subscription-costs 
                 infrastructure-investment
                 maintenance-costs
                 development-costs
                 (* market-rate-high usage-months)))))))

;; =============================================================================
;; VALIDATION AND TESTING
;; =============================================================================

;; Validate all new principles
(define (validate-new-principles)
  (and (validate-derivation unauthorized-email-control-indicators)
       (validate-derivation strategic-entity-exclusion-indicators)
       (validate-derivation creditor-obligation-sabotage-indicators)
       (validate-derivation platform-valuation-methodology)))

;; Export principles to registry
(register-principle! unauthorized-email-control-indicators)
(register-principle! strategic-entity-exclusion-indicators)
(register-principle! creditor-obligation-sabotage-indicators)
(register-principle! platform-valuation-methodology)

;; =============================================================================
;; END OF FILE
;; =============================================================================
