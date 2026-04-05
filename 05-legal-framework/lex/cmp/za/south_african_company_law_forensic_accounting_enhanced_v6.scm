;;; South African Company Law - Forensic Accounting Enhanced v6
;;; Enhanced with multi-actor coordination, related party network mapping, and email control forensic timeline
;;; Date: 2025-11-04
;;; Case: 2025-137857 (Peter Faucitt v. Jacqueline & Daniel Faucitt)

(define-module (lex cmp za south-african-company-law-forensic-accounting-enhanced-v6)
  #:use-module (lex lv1 known-laws)
  #:use-module (lex cmp za south-african-company-law-forensic-accounting-enhanced-v5)
  #:export (
    multi-actor-coordination-pattern-indicators
    related-party-network-mapping-indicators
    email-control-forensic-timeline-analysis
  ))

;;;
;;; NEW PRINCIPLE: Multi-Actor Coordination Pattern Indicators
;;;

(define-principle multi-actor-coordination-pattern-indicators
  #:name "Multi-Actor Coordination Pattern Indicators"
  #:confidence 0.94
  #:domain '(forensic-accounting fraud-detection pattern-analysis)
  #:description "Indicators of coordinated actions across multiple actors in systematic sabotage patterns"
  
  #:core-indicators '(
    (multiple-actors-related-parties "Multiple actors with related party connections")
    (coordinated-timing-of-actions "Coordinated timing of actions across actors")
    (complementary-roles-in-pattern "Complementary roles in sabotage pattern")
    (shared-financial-interests "Shared financial interests among actors")
    (pattern-spans-extended-period "Pattern spans extended period (3+ months)")
    (actions-escalate-over-time "Actions escalate in severity over time")
    (coordination-despite-claimed-independence "Coordination despite claimed independence")
    (sequential-actions-logical-progression "Sequential actions follow logical progression")
  )
  
  #:coordination-pattern-types '(
    (financial-sabotage "Coordinated financial access removal and revenue diversion")
    (information-control "Coordinated control of information systems and communications")
    (legal-action-coordination "Coordinated legal actions and timing")
    (crisis-manufacturing "Coordinated crisis creation and escalation")
  )
  
  #:red-flags '(
    (coordination-duration-exceeds-3-months 0.94 "Coordination pattern exceeds 3 months")
    (3-plus-actors-coordinating 0.96 "3+ actors coordinating actions")
    (shared-financial-interests-confirmed 0.95 "Shared financial interests confirmed")
    (timing-correlation-exceeds-80-percent 0.97 "Timing correlation exceeds 80%")
    (complementary-roles-all-actors 0.93 "Complementary roles across all actors")
    (escalation-pattern-confirmed 0.95 "Escalation pattern confirmed over time")
    (claimed-independence-contradicted 0.94 "Claimed independence contradicted by evidence")
  )
  
  #:actor-role-analysis '(
    (actor-1-authority "Actor with formal authority (director, trustee)")
    (actor-2-professional "Actor with professional role (accountant, advisor)")
    (actor-3-operational "Actor with operational control (bookkeeper, system operator)")
  )
  
  #:case-application
  "Peter Faucitt (trustee, director) + Danie Bantjies (trustee, accountant, Villa Via director) + Rynette Farrar (bookkeeper, email controller) coordinated actions over 6 months (1 Mar - 11 Sep 2025). Pattern includes: (1) Revenue diversion (Peter/Danie), (2) Email control (Rynette), (3) Financial access removal (Peter), (4) Stock adjustment fraud (Rynette/Danie), (5) Accounts emptying (Peter). Shared financial interests: Villa Via (Peter 50%, Danie 50%), Adderory supplier (Rynette's son). Timing correlation: Cards cancelled day after fraud reports submitted. Escalation: Revenue diversion → Bank letter → Orders removed → Cards cancelled → Accounts emptied."
  
  #:legal-implications '(
    "Joint and several liability for coordinated fraud"
    "Conspiracy to defraud"
    "Breach of fiduciary duty (coordinated)"
    "Racketeering indicators (systematic pattern)"
    "Aggravated damages for coordination"
    "Piercing corporate veil (related party network)"
    "Criminal liability for coordinated actions"
  )
  
  #:coordination-indicators-matrix
  '((actor-1 actor-2 actor-3)
    (authority professional operational)
    (peter danie rynette)
    (trustee accountant bookkeeper)
    (director villa-via email-controller)
    (shareholder shareholder related-party))
  
  #:related-principles '(
    fiduciary-duty
    fraud-indicators
    creditor-obligation-sabotage-indicators
    revenue-stream-hijacking-indicators
    email-control-financial-authority-abuse
    related-party-transaction-disclosure
  )
  
  #:integration-points '(
    "jax-response/AD/1-Critical/PARA_10_5-10_10_23.md"
    "ATTACK_HIJACKING_ANALYSIS.md"
    "ATTACK_RESOLUTION_STRATEGY.md"
    "CRITICAL_REVELATION_PAYMENT_STRUCTURE.md"
  )
  
  #:test-function
  (lambda (facts)
    (let ((num-actors (assoc-ref facts 'number-of-actors))
          (coordination-duration (assoc-ref facts 'coordination-duration-months))
          (shared-interests (assoc-ref facts 'shared-financial-interests))
          (timing-correlation (assoc-ref facts 'timing-correlation-percentage))
          (escalation-pattern (assoc-ref facts 'escalation-pattern-confirmed)))
      
      (and (>= num-actors 3)
           (>= coordination-duration 3)
           shared-interests
           (>= timing-correlation 0.80)
           escalation-pattern))))

;;;
;;; NEW PRINCIPLE: Related Party Network Mapping Indicators
;;;

(define-principle related-party-network-mapping-indicators
  #:name "Related Party Network Mapping Indicators"
  #:confidence 0.93
  #:domain '(forensic-accounting fraud-detection network-analysis)
  #:description "Indicators for mapping and analyzing related party networks to identify hidden relationships and financial flows"
  
  #:core-indicators '(
    (direct-family-relationships "Direct family relationships (parent-child, siblings)")
    (indirect-business-relationships "Indirect relationships through entities")
    (financial-flows-between-parties "Financial flows between related parties")
    (control-relationships "Control relationships (director, shareholder, trustee)")
    (benefit-flows "Benefit flows (profit extraction, rent, fees)")
    (coordination-patterns "Coordination patterns across network")
    (hidden-relationships-discovered "Hidden relationships discovered during investigation")
    (network-complexity "Network complexity (3+ layers of relationships)")
  )
  
  #:network-mapping-layers '(
    (layer-1-direct "Direct relationships (family, employment, shareholding)")
    (layer-2-entity "Entity-mediated relationships (common directors, shareholders)")
    (layer-3-financial "Financial flow relationships (payments, loans, transactions)")
    (layer-4-control "Control relationships (authority, instruction, influence)")
  )
  
  #:red-flags '(
    (network-includes-3-plus-layers 0.95 "Network includes 3+ relationship layers")
    (hidden-relationships-discovered-investigation 0.96 "Hidden relationships discovered during investigation")
    (financial-flows-exceed-1m-annually 0.94 "Financial flows exceed R1M annually")
    (control-relationships-undisclosed 0.97 "Control relationships undisclosed")
    (benefit-flows-one-direction 0.93 "Benefit flows predominantly one direction")
    (network-complexity-high 0.92 "Network complexity high (5+ entities)")
  )
  
  #:network-analysis-methodology
  "Map all relationships in 4 layers: (1) Direct relationships (family, employment), (2) Entity relationships (common directors, shareholders), (3) Financial flows (payments, transactions), (4) Control relationships (authority, instruction). Identify hidden relationships, undisclosed connections, and benefit flows. Analyze network complexity and coordination patterns. Quantify financial flows and profit extraction across network."
  
  #:case-application
  "Related party network: Peter ↔ Danie (Villa Via 50/50, FFT co-trustees) ↔ Rynette (employed by Danie, controls Peter's email) ↔ Adderory (Rynette's son, SLG supplier) ↔ Linda (Rynette's sister, bookkeeper). Hidden relationships: Danie as unknown trustee discovered June 2025. Financial flows: Villa Via rent R1.2M annually (86% margin), Adderory supplies (R5.4M stock disappeared), Rynette debt to Rezonance R1.035M. Control: Peter (trustee, director), Danie (trustee, accountant, Villa Via), Rynette (email controller, Sage operator). Benefit flows: Peter/Danie profit from Villa Via, Adderory supplies to SLG, Rynette controls financial systems."
  
  #:legal-implications '(
    "Related party transaction disclosure violations"
    "Conflict of interest (multiple layers)"
    "Piercing corporate veil (network analysis)"
    "Fraudulent scheme identification"
    "Joint and several liability (network participants)"
    "Conspiracy to defraud (coordinated network)"
    "Aggravated damages (network complexity)"
  )
  
  #:network-visualization-format
  '((entity-nodes (peter danie rynette adderory linda villa-via fft rst slg rwd))
    (relationship-edges (family employment shareholding directorship trusteeship financial-flow control))
    (benefit-flows (villa-via-rent adderory-supplies email-control sage-access))
    (hidden-relationships (danie-trustee-undisclosed)))
  
  #:related-principles '(
    related-party-transaction-disclosure
    conflict-of-interest-prohibition
    fiduciary-duty
    fraud-indicators
    undisclosed-trustee-triple-conflict-indicators
    excessive-profit-extraction-test
  )
  
  #:integration-points '(
    "ADMIN_FEE_FRAUD_ANALYSIS.md"
    "CORRECTED_FRAUD_ANALYSIS.md"
    "CRITICAL_REVELATION_PAYMENT_STRUCTURE.md"
    "jax-response/AD/2-High-Priority/PARA_8-8_3.md"
  )
  
  #:test-function
  (lambda (facts)
    (let ((network-layers (assoc-ref facts 'network-layers))
          (hidden-relationships (assoc-ref facts 'hidden-relationships-discovered))
          (financial-flows (assoc-ref facts 'total-financial-flows))
          (control-undisclosed (assoc-ref facts 'control-relationships-undisclosed))
          (network-entities (assoc-ref facts 'number-of-entities)))
      
      (and (>= network-layers 3)
           hidden-relationships
           (>= financial-flows 1000000)
           control-undisclosed
           (>= network-entities 5)))))

;;;
;;; NEW PRINCIPLE: Email Control Forensic Timeline Analysis
;;;

(define-principle email-control-forensic-timeline-analysis
  #:name "Email Control Forensic Timeline Analysis"
  #:confidence 0.95
  #:domain '(forensic-accounting fraud-detection digital-forensics)
  #:description "Forensic timeline analysis of email control and unauthorized transactions to establish pattern and liability"
  
  #:core-indicators '(
    (email-control-duration-documented "Email control duration documented with evidence")
    (transaction-timing-analysis "Transaction timing analysis (when, by whom)")
    (system-access-logs "System access logs (Sage, banking, email)")
    (authorization-gaps-identified "Authorization gaps identified (no director approval)")
    (unallocated-expense-correlation "Unallocated expenses correlate with email control period")
    (audit-trigger-timing "SARS audit trigger timing correlation")
    (forensic-evidence-screenshots "Forensic evidence (screenshots, system logs)")
    (director-denial-of-authorization "Director explicit denial of authorization")
  )
  
  #:forensic-timeline-methodology
  "Establish email control timeline with evidence: (1) Start date of email control, (2) System access evidence (Sage screenshots, dates), (3) Transaction timing analysis, (4) Authorization gap identification, (5) Unallocated expense correlation, (6) Audit trigger timing, (7) Director denial documentation, (8) End date or ongoing control. Analyze pattern: frequency, transaction types, amounts, authorization gaps, correlation with other events."
  
  #:red-flags '(
    (email-control-exceeds-6-months 0.95 "Email control duration exceeds 6 months")
    (system-access-evidence-multiple-dates 0.96 "System access evidence on multiple dates")
    (transactions-exceed-1m 0.94 "Transactions exceed R1M during control period")
    (authorization-gaps-all-transactions 0.97 "Authorization gaps for all transactions")
    (unallocated-expenses-2-years 0.93 "Unallocated expenses for 2+ years")
    (sars-audit-triggered-during-control 0.94 "SARS audit triggered during control period")
    (director-explicitly-denied-authorization 0.98 "Director explicitly denied authorization")
    (multiple-bank-accounts-opened 0.92 "Multiple bank accounts opened using controlled email")
  )
  
  #:forensic-evidence-types '(
    (sage-screenshots "Sage accounting system screenshots showing email usage")
    (email-logs "Email server logs showing access and usage")
    (banking-records "Banking records showing transactions authorized via email")
    (system-access-logs "System access logs (IP addresses, timestamps)")
    (authorization-documentation "Authorization documentation (or lack thereof)")
    (director-statements "Director statements denying authorization")
    (audit-correspondence "SARS audit correspondence and timing")
  )
  
  #:timeline-correlation-analysis
  '((email-control-start "Date email control began")
    (first-unauthorized-transaction "Date of first unauthorized transaction")
    (unallocated-expenses-start "Date unallocated expenses began accumulating")
    (sars-audit-trigger "Date SARS audit triggered")
    (fraud-report-submission "Date fraud reports submitted")
    (email-control-discovered "Date email control discovered")
    (director-denial "Date director denied authorization"))
  
  #:case-application
  "Rynette Farrar controlled Peter's email (pete@regima.com) for extended period. Forensic evidence: Sage screenshots from June 2025 and August 2025 showing Rynette using Peter's email to access accounting system. Peter had no access to company accounts or banks. Rynette may have opened 8 ABSA accounts using Daniel's stolen card. Two years of unallocated expenses in system controlled by Rynette. SARS audit triggered, Rynette claimed Bantjies instructed huge payments. Peter explicitly denied authorization. Timeline: Email control ongoing → Sage access June/August 2025 → SARS audit triggered → Fraud reports submitted 6 Jun 2025 → Email control discovered during investigation."
  
  #:legal-implications '(
    "Fraud (unauthorized financial authority)"
    "Identity theft (email control, card usage)"
    "Breach of fiduciary duty (accountant/bookkeeper)"
    "Unauthorized agent liability"
    "Voidable transactions (no authorization)"
    "Director protection from liability (no authorization)"
    "Criminal charges (fraud, theft, identity theft)"
    "Aggravated damages (systematic pattern, extended duration)"
  )
  
  #:quantification-methodology
  "Quantify damages: (1) Total transactions during email control period, (2) Unauthorized transactions (no director approval), (3) Unallocated expenses, (4) SARS penalties and interest, (5) Audit costs, (6) Legal costs, (7) Business disruption costs, (8) Reputational damages. Calculate timeline: Start date to discovery date. Establish pattern: Frequency, amounts, transaction types, authorization gaps."
  
  #:related-principles '(
    email-control-financial-authority-abuse
    unauthorized-email-control-indicators
    fraud-indicators
    accountant-professional-duty
    fiduciary-duty
    multi-actor-coordination-pattern-indicators
  )
  
  #:integration-points '(
    "jax-response/AD/2-High-Priority/PARA_7_12-7_13.md"
    "jax-response/accountant_concerns.md"
    "CORRECTED_FRAUD_ANALYSIS.md"
  )
  
  #:test-function
  (lambda (facts)
    (let ((control-duration (assoc-ref facts 'email-control-duration-months))
          (forensic-evidence (assoc-ref facts 'forensic-evidence-exists))
          (transactions-amount (assoc-ref facts 'total-transactions-amount))
          (authorization-gaps (assoc-ref facts 'authorization-gaps-percentage))
          (director-denied (assoc-ref facts 'director-denied-authorization))
          (sars-audit (assoc-ref facts 'sars-audit-triggered)))
      
      (and (>= control-duration 6)
           forensic-evidence
           (>= transactions-amount 1000000)
           (>= authorization-gaps 0.90)
           director-denied
           sars-audit))))

;;; End of module
