;;; South African Company Law - Forensic Accounting Enhanced v5
;;; Enhanced with email control, stock adjustment fraud, and creditor sabotage timeline principles
;;; Date: 2025-11-03
;;; Case: 2025-137857 (Peter Faucitt v. Jacqueline & Daniel Faucitt)

(define-module (lex cmp za south-african-company-law-forensic-accounting-enhanced-v5)
  #:use-module (lex lv1 known-laws)
  #:use-module (lex cmp za south-african-company-law-forensic-accounting-enhanced-v4)
  #:export (
    email-control-financial-authority-abuse
    stock-adjustment-fraud-pattern-indicators
    creditor-obligation-sabotage-timeline-correlation
  ))

;;;
;;; NEW PRINCIPLE: Email Control Financial Authority Abuse
;;;

(define-principle email-control-financial-authority-abuse
  #:name "Email Control Financial Authority Abuse"
  #:confidence 0.96
  #:domain '(company-law forensic-accounting fraud-detection)
  #:description "Indicators of unauthorized email control combined with financial authority abuse"
  
  #:core-indicators '(
    (accountant-controls-director-email "Accountant controls director's email address")
    (email-used-for-financial-authorization "Email used to authorize financial transactions")
    (email-used-for-accounting-systems "Email used to access accounting systems (e.g., Sage)")
    (director-denies-authorization "Director explicitly denies authorization")
    (multiple-bank-accounts-opened "Multiple bank accounts opened using controlled email")
    (financial-decisions-without-knowledge "Financial decisions made without director knowledge")
    (systematic-pattern-extended-period "Systematic pattern over extended period (6+ months)")
    (email-control-coincides-unallocated-expenses "Email control coincides with unallocated expenses")
  )
  
  #:red-flags '(
    (email-control-duration-exceeds-6-months 0.95 "Email control duration exceeds 6 months")
    (financial-transactions-exceed-1m 0.96 "Financial transactions exceed R1M")
    (multiple-bank-accounts-opened-8-absa 0.94 "Multiple bank accounts opened (8 ABSA accounts)")
    (director-explicitly-denied-authorization 0.98 "Director explicitly denied authorization")
    (accountant-conflicting-interests-trustee 0.97 "Accountant has conflicting interests (also trustee)")
    (email-used-for-sage-accounting 0.95 "Email used for Sage accounting system")
    (unallocated-expenses-2-years 0.93 "Unallocated expenses for 2+ years")
    (court-order-seize-related-email-kayla 0.92 "Court order obtained to seize related email (Kayla)")
  )
  
  #:case-application
  "Rynette Farrar controlled Peter's email (pete@regima.com) as evidenced by Sage screenshots from June and August 2025. Rynette may have opened 8 ABSA accounts using Daniel's stolen card. Peter had no access to company accounts or banks. Rynette claimed to act under Bantjies' instructions (unknown trustee at the time). Two years of unallocated expenses in the system controlled by Rynette using Peter's email."
  
  #:legal-implications '(
    "Breach of fiduciary duty (accountant)"
    "Fraud indicators (unauthorized financial authority)"
    "Unauthorized agent liability"
    "Voidable transactions"
    "Director protection from liability"
    "Potential criminal charges (fraud, theft, identity theft)"
  )
  
  #:related-principles '(
    fiduciary-duty
    accountant-professional-duty
    fraud-indicators
    unauthorized-email-control-indicators
    conflict-of-interest-prohibition
  )
  
  #:integration-points '(
    "jax-dan-response/AD/2-High-Priority/PARA_7_12-7_13_DAN_ACCOUNTANT.md"
    "jax-dan-response/accountant_concerns.md"
  )
  
  #:test-function
  (lambda (facts)
    (let ((email-control (assoc-ref facts 'accountant-controls-director-email))
          (duration-months (assoc-ref facts 'email-control-duration-months))
          (transactions-amount (assoc-ref facts 'financial-transactions-amount))
          (director-denies (assoc-ref facts 'director-denies-authorization))
          (accountant-is-trustee (assoc-ref facts 'accountant-is-trustee))
          (unallocated-years (assoc-ref facts 'unallocated-expenses-years)))
      
      (and email-control
           (>= duration-months 6)
           (>= transactions-amount 1000000)
           director-denies
           accountant-is-trustee
           (>= unallocated-years 2)))))

;;;
;;; NEW PRINCIPLE: Stock Adjustment Fraud Pattern Indicators
;;;

(define-principle stock-adjustment-fraud-pattern-indicators
  #:name "Stock Adjustment Fraud Pattern Indicators"
  #:confidence 0.95
  #:domain '(company-law forensic-accounting fraud-detection)
  #:description "Indicators of fraudulent stock adjustments where large inventory losses are attributed to stock adjustments or disappeared stock"
  
  #:core-indicators '(
    (large-stock-adjustment-5m-plus "Large stock adjustment (R5M+)")
    (stock-described-disappeared "Stock described as 'just disappeared'")
    (no-theft-report-filed "No theft report filed")
    (no-insurance-claim-made "No insurance claim made")
    (stock-type-matches-related-party "Stock type matches related party supplier")
    (supplier-is-related-party "Supplier is related party (e.g., director's relative's company)")
    (coincides-with-unallocated-expenses "Coincides with unallocated expenses")
    (accountant-controls-financial-systems "Accountant controls financial systems")
    (no-physical-stock-count-documentation "No physical stock count documentation")
  )
  
  #:red-flags '(
    (stock-adjustment-exceeds-5m 0.96 "Stock adjustment exceeds R5M")
    (stock-disappeared-without-explanation 0.95 "Stock 'disappeared' without explanation")
    (no-police-report-filed 0.94 "No police report filed")
    (supplier-is-directors-relative 0.97 "Supplier is director's relative")
    (accountant-conflicting-interests 0.96 "Accountant has conflicting interests")
    (unallocated-expenses-2-years 0.93 "Unallocated expenses for 2+ years")
    (court-order-seize-related-email 0.92 "Court order to seize related email")
    (sars-audit-triggered-by-amounts 0.94 "SARS audit triggered by amounts")
  )
  
  #:case-application
  "Strategic Logistics Group (SLG) reported R5.4M loss attributed to 'stock adjustment' - stock 'just disappeared.' This is the same type of stock supplied by Adderory (Rynette's son's company). Rynette controlled the accounting system using Peter's email. Two years of unallocated expenses. SARS audit triggered, and Rynette claimed Bantjies instructed the huge payments. Court order obtained to seize Kayla's email account, interfering with law enforcement investigation freeze."
  
  #:legal-implications '(
    "Fraud indicators (stock theft, false accounting)"
    "Breach of fiduciary duty"
    "Related party transaction concealment"
    "Tax evasion indicators"
    "Potential criminal charges (fraud, theft)"
    "Director liability for losses"
    "Voidable transactions"
  )
  
  #:related-principles '(
    fraud-indicators
    related-party-transaction-disclosure
    excessive-profit-extraction-test
    strategic-entity-exclusion-indicators
    director-self-dealing-prohibition
  )
  
  #:test-function
  (lambda (facts)
    (let ((stock-adjustment (assoc-ref facts 'stock-adjustment-amount))
          (stock-disappeared (assoc-ref facts 'stock-disappeared))
          (no-theft-report (assoc-ref facts 'no-theft-report))
          (supplier-related-party (assoc-ref facts 'supplier-related-party))
          (sars-audit (assoc-ref facts 'sars-audit-triggered)))
      
      (and (>= stock-adjustment 5000000)
           stock-disappeared
           no-theft-report
           supplier-related-party
           sars-audit))))

;;;
;;; ENHANCED PRINCIPLE: Creditor Obligation Sabotage Timeline Correlation
;;;

(define-principle creditor-obligation-sabotage-timeline-correlation
  #:name "Creditor Obligation Sabotage Timeline Correlation"
  #:confidence 0.96
  #:domain '(company-law forensic-accounting fraud-detection)
  #:description "Enhanced timeline analysis for detecting systematic sabotage of director's ability to meet creditor obligations"
  
  #:timeline-pattern '(
    (2025-03-01 "RegimA SA revenue diversion" "Revenue stream hijacked" "First action in pattern")
    (2025-04-14 "RWD bank letter" "Financial access restricted" "Escalating sabotage")
    (2025-05-15 "Jax confronts Rynette (R1.035M debt)" "Fraud exposure" "Trigger for acceleration")
    (2025-05-22 "Orders removed from Shopify" "Revenue stream cut" "Retaliation (7 days after)")
    (2025-05-29 "New domain registered (Adderory)" "Revenue hijacking complete" "Alternative channel created")
    (2025-06-06 "Dan submits reports to accountant" "Villa Via fraud exposed" "Second trigger")
    (2025-06-07 "Cards cancelled (Peter)" "Financial access removed" "Retaliation (1 day after)")
    (2025-06-20 "Email instruction to avoid regima.zone" "Brand sabotage" "Systematic destruction")
    (2025-09-11 "Accounts emptied" "Complete financial cutoff" "Final sabotage action")
  )
  
  #:sabotage-indicators '(
    (duration-exceeds-6-months 0.96 "Duration exceeds 6 months")
    (multiple-revenue-streams-diverted-3-plus 0.97 "Multiple revenue streams diverted (3+)")
    (bank-access-progressively-removed 0.95 "Bank access progressively removed")
    (card-cancellations-without-notice 0.96 "Card cancellations without notice")
    (timing-correlates-fraud-exposure 0.98 "Timing correlates with fraud exposure")
    (accounts-emptied-after-6-months 0.95 "Accounts emptied after 6 months")
    (creditor-obligations-remain-with-target 0.94 "Creditor obligations remain with target")
    (alternative-revenue-channels-created 0.93 "Alternative revenue channels created")
  )
  
  #:correlation-analysis '(
    (fraud-exposure-to-retaliation "1-7 days")
    (revenue-diversion-to-account-emptying "6 months")
    (card-cancellation-to-report-submission "1 day")
    (confrontation-to-orders-removal "7 days")
  )
  
  #:case-application
  "Daniel's revenue streams were systematically hijacked over 6 months (1 Mar - 11 Sep 2025). Pattern shows clear correlation between fraud exposure events (15 May Jax confrontation, 6 Jun Dan reports) and retaliatory actions (22 May orders removed, 7 Jun cards cancelled). Dan left responsible for creditor payments while ability to pay systematically sabotaged. Final account emptying on 11 Sep completed the financial cutoff."
  
  #:legal-implications '(
    "Breach of fiduciary duty (systematic sabotage)"
    "Fraud indicators (coordinated pattern)"
    "Reckless trading (removing ability to pay creditors)"
    "Intentional harm (deliberate destruction)"
    "Bad faith conduct (retaliation for fraud exposure)"
    "Director liability for creditor losses"
    "Voidable transactions (revenue diversions)"
  )
  
  #:related-principles '(
    creditor-obligation-sabotage-indicators
    revenue-stream-hijacking-indicators
    fraud-exposure-retaliation-indicators
    manufactured-crisis-indicators
    temporal-bad-faith-indicators
  )
  
  #:integration-points '(
    "jax-dan-response/AD/1-Critical/DAN_BUSINESS_CONTINUITY_IMPACT.md"
    "jax-dan-response/AD/1-Critical/DAN_TECHNICAL_TIMELINE_ANALYSIS.md"
    "jax-dan-response/timeline_analysis.md"
  )
  
  #:test-function
  (lambda (facts)
    (let ((timeline-events (assoc-ref facts 'timeline-events))
          (duration-months (assoc-ref facts 'sabotage-duration-months))
          (revenue-streams-diverted (assoc-ref facts 'revenue-streams-diverted))
          (fraud-exposure-correlation (assoc-ref facts 'fraud-exposure-correlation)))
      
      (and (>= duration-months 6)
           (>= revenue-streams-diverted 3)
           fraud-exposure-correlation
           (>= (length timeline-events) 5)))))

;;; End of module
