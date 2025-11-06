;;; South African Civil Law - Multi-Actor Coordination
;;; Enhanced with multi-actor-coordination-indicators for revenue hijacking patterns
;;; Date: 2025-11-06
;;; Case: 2025-137857 (Peter Faucitt v. Jacqueline & Daniel Faucitt)

(define-module (lex civ za south-african-civil-law-multi-actor-coordination)
  #:use-module (lex lv1 known-laws)
  #:use-module (lex civ za south-african-civil-law-enhanced)
  #:export (
    multi-actor-coordination-indicators
    coordinated-revenue-diversion-pattern
    actor-network-analysis
  ))

;;;
;;; NEW PRINCIPLE: Multi-Actor Coordination Indicators
;;;

(define-principle multi-actor-coordination-indicators
  #:name "Multi-Actor Coordination Indicators"
  #:confidence 0.96
  #:domain '(civil-law delict fraud conspiracy)
  #:description "Identifies patterns where multiple actors coordinate actions to achieve common objective (e.g., revenue diversion, sabotage)"
  
  #:core-indicators '(
    (multiple-actors-identified "Multiple actors involved in pattern")
    (temporal-coordination "Actions temporally coordinated (close timing)")
    (complementary-actions "Actions complement each other toward common objective")
    (common-objective "Common objective identifiable (e.g., revenue diversion)")
    (information-sharing "Evidence of information sharing between actors")
    (sequential-escalation "Actions escalate sequentially")
  )
  
  #:coordination-analysis-methodology
  "Analyze multi-actor coordination in 6 steps:
  
  1. **Identify Actors**: List all actors involved in pattern (natural persons, companies, entities).
  
  2. **Map Actions**: Document each actor's actions (date, nature, effect).
  
  3. **Analyze Temporal Coordination**: Calculate time intervals between actions. Identify clusters.
  
  4. **Assess Complementarity**: Evaluate how actions complement each other. Do they achieve common objective?
  
  5. **Identify Information Flows**: Look for evidence of information sharing (emails, instructions, meetings).
  
  6. **Evaluate Coordination Strength**: 
     - High (0.95+): Tight temporal coordination, clear complementarity, documented information sharing
     - Medium (0.90-0.94): Temporal coordination, complementarity evident, information sharing inferred
     - Low (0.85-0.89): Loose temporal coordination, complementarity possible, no direct evidence"
  
  #:red-flags '(
    (three-or-more-actors 0.94 "Three or more actors involved")
    (actions-within-7-days 0.96 "Multiple actions within 7-day window")
    (complementary-actions-evident 0.95 "Actions clearly complement each other")
    (documented-instructions 0.97 "Documented instructions between actors (emails, letters)")
    (sequential-escalation-pattern 0.93 "Actions escalate sequentially toward objective")
    (common-beneficiary 0.94 "Common beneficiary of coordinated actions")
  )
  
  #:case-application
  "RegimA Revenue Diversion - Multi-Actor Coordination:
  
  **Actors Identified**:
  1. Peter Faucitt (Trustee, Director)
  2. Rynette Farrar (Financial Controller, non-director)
  3. Adderory (Rynette's son's company)
  4. Danie Bantjies (Co-Trustee, Accountant)
  
  **Coordinated Actions Timeline**:
  
  **Phase 1: Setup (Mar-May 2025)**
  - 1 Mar 2025: RegimA SA revenue diversion begins (Actor: Rynette)
  - 30 Mar 2025: Two years unallocated expenses dumped into RWD (Actors: Rynette, Peter)
  - 14 Apr 2025: Rynette bank letter for RWD revenue diversion (Actor: Rynette)
  
  **Phase 2: Confrontation & Retaliation (May 2025)**
  - 15 May 2025: Jax confronts Rynette about R1.035M debt (Trigger event)
  - 22 May 2025: Orders removed from Shopify (Actor: Unknown, likely Rynette)
  - 29 May 2025: New domain regimaskin.co.za registered (Actor: Adderory)
  
  **Phase 3: Fraud Exposure & Escalation (Jun 2025)**
  - 6 Jun 2025: Dan provides fraud reports to Bantjies (Trigger event)
  - 7 Jun 2025: Peter cancels all business cards (Actor: Peter) [1 day after reports]
  - 20 Jun 2025: Email instruction: use regimaskin.co.za not regima.zone (Actor: Rynette via Gee)
  
  **Phase 4: Legal Action (Aug 2025)**
  - 11 Aug 2025: Settlement discussion + Jax signs backdating (Actors: Peter, Jax)
  - 13 Aug 2025: Peter files interdict (Actor: Peter) [2 days after backdating]
  
  **Phase 5: Final Escalation (Sep 2025)**
  - 11 Sep 2025: Accounts emptied (Actor: Unknown, likely Peter/Rynette)
  
  **Coordination Analysis**:
  
  **Temporal Coordination**: 
  - Tight clusters: 15-29 May (14 days, 3 actions), 6-7 Jun (1 day, 2 actions), 11-13 Aug (2 days, 2 actions)
  - Coordination confidence: 0.96
  
  **Complementary Actions**:
  - Revenue diversion (RegimA SA, bank letter, new domain) → diverts revenue from RWD
  - Orders removed + new domain → redirects customers
  - Card cancellations + account emptying → sabotages Dan's ability to pay creditors
  - All actions serve common objective: revenue diversion + sabotage
  
  **Information Flows**:
  - Rynette controls Peter's email (pete@regima.com) - documented
  - Rynette claims Bantjies instructed payments - documented email
  - Email instruction to use new domain - documented
  - Coordination confidence: 0.97
  
  **Common Objective**: Divert revenue from RWD, sabotage Dan's creditor payments, create crisis for legal action
  
  **Coordination Strength**: High (0.96)
  
  **Legal Implications**:
  - Coordinated delict (joint wrongdoing)
  - Conspiracy to defraud
  - Joint and several liability
  - Aggravated damages (coordination demonstrates intent)"
  
  #:actor-network-structure
  '((peter-faucitt 
      (roles "Trustee" "Director" "Orchestrator")
      (actions "Card cancellations" "Interdict filing" "Settlement trap")
      (connections "Rynette" "Bantjies"))
    (rynette-farrar
      (roles "Financial Controller" "System Administrator" "Executor")
      (actions "Revenue diversion" "Expense dumping" "Email instructions")
      (connections "Peter" "Bantjies" "Adderory"))
    (adderory
      (roles "Stock Supplier" "Domain Registrant" "Revenue Recipient")
      (actions "Domain registration" "Stock supply" "Revenue capture")
      (connections "Rynette"))
    (danie-bantjies
      (roles "Co-Trustee" "Accountant" "Unknown Trustee")
      (actions "Instructions to Rynette" "Fraud exposure recipient")
      (connections "Peter" "Rynette")))
  
  #:legal-implications '(
    "Coordinated delict (joint wrongdoing)"
    "Conspiracy to defraud"
    "Joint and several liability"
    "Aggravated damages (coordination demonstrates intent)"
    "Piercing corporate veil (Adderory as alter ego)"
    "Fraudulent misrepresentation"
    "Unjust enrichment (multiple beneficiaries)"
    "RICO-style pattern analysis applicable"
  )
  
  #:related-principles '(
    revenue-stream-hijacking-indicators
    creditor-obligation-sabotage-indicators
    fraud-exposure-retaliation-indicators
    manufactured-crisis-indicators
    joint-wrongdoing
    conspiracy
    vicarious-liability
  )
  
  #:integration-points '(
    "jax-response/AD/1-Critical/PARA_10_5-10_10_23.md"
    "ATTACK_HIJACKING_ANALYSIS.md"
    "LEGAL_ASPECTS_ANALYSIS_2025-11-06.json"
  )
  
  #:test-function
  (lambda (facts)
    (let ((actor-count (assoc-ref facts 'actor-count))
          (temporal-coordination (assoc-ref facts 'temporal-coordination))
          (complementary-actions (assoc-ref facts 'complementary-actions))
          (documented-information-sharing (assoc-ref facts 'documented-information-sharing)))
      
      (and (>= actor-count 3)
           temporal-coordination
           complementary-actions
           documented-information-sharing))))

;;;
;;; NEW PRINCIPLE: Coordinated Revenue Diversion Pattern
;;;

(define-principle coordinated-revenue-diversion-pattern
  #:name "Coordinated Revenue Diversion Pattern"
  #:confidence 0.96
  #:domain '(civil-law delict fraud unjust-enrichment)
  #:description "Specific pattern of multi-actor coordination to systematically divert revenue from target entity"
  
  #:core-indicators '(
    (revenue-source-identified "Original revenue source identified (e.g., RWD)")
    (diversion-mechanisms-multiple "Multiple diversion mechanisms employed")
    (alternative-recipients-created "Alternative revenue recipients created")
    (customer-redirection "Customers redirected to alternative entities")
    (systematic-execution "Systematic execution over time")
    (target-entity-depleted "Target entity depleted of revenue")
  )
  
  #:diversion-mechanisms '(
    (bank-account-diversion 0.96 "Bank account changes to divert payments")
    (domain-registration 0.95 "New domains registered to capture traffic")
    (order-removal 0.94 "Orders removed from original platform")
    (email-redirection 0.95 "Email instructions to use alternative channels")
    (customer-communication 0.93 "Direct customer communication to redirect orders")
  )
  
  #:case-application
  "RegimA Worldwide Distribution Revenue Diversion:
  
  **Revenue Source**: RWD (historical revenue R12-19M annually)
  
  **Diversion Mechanisms**:
  1. Bank account diversion (14 Apr 2025 - Rynette bank letter)
  2. Domain registration (29 May 2025 - regimaskin.co.za by Adderory)
  3. Order removal (22 May 2025 - orders removed from Shopify)
  4. Email redirection (20 Jun 2025 - use regimaskin.co.za not regima.zone)
  5. RegimA SA diversion (1 Mar 2025 - revenue diverted to RegimA SA)
  
  **Alternative Recipients**: RegimA SA, regimaskin.co.za (Adderory), other entities
  
  **Timeline**: 6 months (Mar-Sep 2025)
  
  **Estimated Diversion**: R6M-R10M (50% of annual revenue over 6 months)
  
  **Target Entity Impact**: RWD depleted, no stock, no operations, accumulating losses
  
  **Legal Implications**:
  - Systematic fraud (multiple mechanisms)
  - Unjust enrichment (alternative recipients)
  - Delict (wrongful deprivation of revenue)
  - Trust asset abandonment (RWD owned by trust)
  - Quantum meruit (platform usage without payment)"
  
  #:quantification-methodology
  "Calculate revenue diversion damages:
  
  1. **Historical Revenue Baseline**: R12-19M annually (average R15.5M)
  2. **Diversion Period**: 6 months (Mar-Sep 2025)
  3. **Expected Revenue**: R7.75M (50% of annual)
  4. **Actual Revenue**: Near zero (diverted)
  5. **Estimated Diversion**: R6M-R10M (conservative to aggressive)
  6. **Lost Profit**: R1.2M-R2M (assuming 20% margin)
  7. **Asset Devaluation**: R2M-R5M (RWD value decline)
  8. **Total Damages**: R9.2M-R17M"
  
  #:legal-implications '(
    "Systematic fraud"
    "Unjust enrichment (multiple recipients)"
    "Delict (wrongful deprivation)"
    "Trust asset abandonment"
    "Quantum meruit"
    "Joint and several liability"
    "Aggravated damages"
    "Restitution required"
  )
  
  #:related-principles '(
    multi-actor-coordination-indicators
    revenue-stream-hijacking-indicators
    trust-asset-abandonment-indicators
    unjust-enrichment-test
    quantum-meruit
  )
  
  #:integration-points '(
    "jax-response/AD/1-Critical/PARA_10_5-10_10_23.md"
    "ATTACK_HIJACKING_ANALYSIS.md"
  )
  
  #:test-function
  (lambda (facts)
    (let ((diversion-mechanisms-count (assoc-ref facts 'diversion-mechanisms-count))
          (alternative-recipients (assoc-ref facts 'alternative-recipients))
          (systematic-execution (assoc-ref facts 'systematic-execution))
          (target-depleted (assoc-ref facts 'target-depleted)))
      
      (and (>= diversion-mechanisms-count 3)
           alternative-recipients
           systematic-execution
           target-depleted))))

;;;
;;; NEW PRINCIPLE: Actor Network Analysis
;;;

(define-principle actor-network-analysis
  #:name "Actor Network Analysis"
  #:confidence 0.94
  #:domain '(civil-law delict fraud network-analysis)
  #:description "Analyzes network structure of actors, their roles, connections, and coordinated actions"
  
  #:core-indicators '(
    (actor-roles-identified "Roles of each actor identified")
    (actor-connections-mapped "Connections between actors mapped")
    (information-flows-documented "Information flows documented")
    (action-sequences-analyzed "Action sequences analyzed")
    (network-structure-revealed "Network structure revealed")
  )
  
  #:network-analysis-methodology
  "Analyze actor network in 5 steps:
  
  1. **Identify Actors**: List all actors (natural persons, companies, entities)
  
  2. **Map Roles**: Document each actor's role (orchestrator, executor, beneficiary, facilitator)
  
  3. **Map Connections**: Identify connections (employment, family, business, control)
  
  4. **Document Information Flows**: Trace information flows (emails, instructions, meetings)
  
  5. **Analyze Network Structure**: 
     - Central actors (high connectivity, control)
     - Peripheral actors (low connectivity, execution)
     - Information hubs (control information flows)
     - Beneficiaries (receive proceeds)"
  
  #:case-application
  "RegimA Actor Network:
  
  **Central Actors**:
  - Peter Faucitt: Orchestrator (Trustee, Director, control authority)
  - Rynette Farrar: Executor (Financial Controller, system access, Peter's email)
  
  **Peripheral Actors**:
  - Adderory: Facilitator (domain registration, stock supply, Rynette's son)
  - Danie Bantjies: Authority Figure (Co-Trustee, Accountant, instructions to Rynette)
  
  **Connections**:
  - Peter ↔ Rynette: Control (Rynette controls Peter's email, acts on Peter's authority)
  - Rynette ↔ Adderory: Family (mother-son), Business (stock supply, domain registration)
  - Rynette ↔ Bantjies: Professional (accountant-controller), Instructions (Bantjies instructs Rynette)
  - Peter ↔ Bantjies: Co-Trustees, Professional (accountant-client)
  
  **Information Flows**:
  - Bantjies → Rynette: Instructions for payments (documented email)
  - Rynette → Gee: Email instructions (use regimaskin.co.za)
  - Rynette controls Peter's email: Information hub
  
  **Network Structure**: Hub-and-spoke with Rynette as information hub
  
  **Legal Implications**:
  - Rynette as central executor (joint liability)
  - Peter as orchestrator (primary liability)
  - Adderory as alter ego (piercing corporate veil)
  - Bantjies as authority figure (professional liability)"
  
  #:legal-implications '(
    "Joint and several liability"
    "Conspiracy to defraud"
    "Piercing corporate veil (Adderory)"
    "Professional liability (Bantjies)"
    "Vicarious liability"
    "Aiding and abetting"
    "Network structure demonstrates coordination"
  )
  
  #:related-principles '(
    multi-actor-coordination-indicators
    coordinated-revenue-diversion-pattern
    joint-wrongdoing
    conspiracy
    vicarious-liability
  )
  
  #:integration-points '(
    "LEGAL_ASPECTS_ANALYSIS_2025-11-06.json"
    "Actor network visualization"
  )
  
  #:test-function
  (lambda (facts)
    (let ((actors-identified (assoc-ref facts 'actors-identified))
          (connections-mapped (assoc-ref facts 'connections-mapped))
          (information-flows-documented (assoc-ref facts 'information-flows-documented)))
      
      (and actors-identified
           connections-mapped
           information-flows-documented))))
