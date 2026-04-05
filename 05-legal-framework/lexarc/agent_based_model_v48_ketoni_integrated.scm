;;; ============================================================================
;;; AGENT-BASED MODEL V48 - KETONI ZAR 18.75M PAYOUT INTEGRATED
;;; ============================================================================
;;; High-Resolution Agent-Based Model with Entity-Relation Framework
;;; Date: 2025-12-26
;;; Verification Level: PRIMARY SOURCE VERIFIED + KETONI PAYOUT MOTIVE INTEGRATED
;;; 
;;; CRITICAL REVELATION:
;;; ZAR 18.75 million payout owed by Ketoni to Faucitt Family Trust (May 2026)
;;; This financial motive provides the central organizing principle for all agent
;;; behaviors, motivations, and inter-agent relationships since Apr 2023.
;;; ============================================================================

(define-module (lex agent-based-model-v48-ketoni)
  #:use-module (lex entity-relation-framework-v48-ketoni)
  #:export (
    agent-peter-faucitt
    agent-jacqueline-faucitt
    agent-daniel-faucitt
    agent-daniel-bantjies
    agent-kevin-derrick
    agent-rynette
    agent-ketoni-investment-holdings
    agent-faucitt-family-trust
    agent-rezonance
    ketoni-payout-agent-network
  ))

;;; ============================================================================
;;; AGENT 1: PETER ANDREW FAUCITT - THE CONTROL CONSOLIDATOR
;;; ============================================================================

(define-agent agent-peter-faucitt
  (type individual-agent)
  (agent-id "peter-faucitt")
  (full-name "PETER ANDREW FAUCITT")
  (id-number "5204305708185")
  
  ;; ROLES & POWERS
  (roles
    ((role "Founder")
     (entity "Faucitt Family Trust")
     (powers "Sole power to appoint trustees during lifetime")
     (since "2013-11-27"))
    
    ((role "Trustee")
     (entity "Faucitt Family Trust")
     (powers "Fiduciary duty to all beneficiaries")
     (since "2013-11-27"))
    
    ((role "Main Trustee")
     (entity "Faucitt Family Trust")
     (powers "Sole control over trust decisions")
     (designation-date "2025-07-01")  ;; Backdated
     (document-signed "2025-08-11")
     (signed-by "Jacqueline Faucitt"))
    
    ((role "Beneficiary")
     (entity "Faucitt Family Trust")
     (entitlement "Share of ZAR 18.75M Ketoni payout")
     (since "2013-11-27")))
  
  ;; CENTRAL FINANCIAL MOTIVE
  (financial-interests
    ((interest-type "Beneficiary Share")
     (asset "Ketoni ZAR 18.75M payout")
     (payout-date "2026-05")
     (personal-benefit "Maximize personal share by controlling other beneficiaries")
     (conflict "Fiduciary duty vs personal financial interest")
     (confidence 0.95)))
  
  ;; AGENT OBJECTIVES (Re-contextualized with Ketoni motive)
  (objectives
    ((objective "Control distribution of ZAR 18.75M Ketoni payout")
     (priority "PRIMARY")
     (mechanism "Consolidate control as Main Trustee before May 2026")
     (confidence 0.95))
    
    ((objective "Neutralize Jax as trustee")
     (priority "HIGH")
     (mechanism "Interdict for 'crime of helping Daniel'")
     (timing "T-9 months before payout")
     (result "Jax cannot oppose Peter's payout decisions")
     (confidence 0.97))
    
    ((objective "Control Dan's beneficiary share")
     (priority "HIGH")
     (mechanism "Interdict + Medical Testing + Curatorship")
     (timing "T-9 months before payout")
     (result "If curatorship granted, Peter controls Dan's entire share")
     (confidence 0.94))
    
    ((objective "Eliminate ReZonance debt obstacle")
     (priority "MEDIUM")
     (mechanism "Pressure to dissolve ReZonance")
     (timing "T-27 months before payout")
     (result "R1M debt eliminated, clean slate for ZAR 18.75M payout")
     (confidence 0.90))
    
    ((objective "Silence fraud exposure")
     (priority "HIGH")
     (mechanism "Retaliation against Dan for exposing Villa Via fraud")
     (timing "Immediate (<24 hours after fraud disclosure)")
     (result "Dan silenced, fraud protected")
     (confidence 0.93)))
  
  ;; AGENT BEHAVIORS (Ketoni motive-driven)
  (behaviors
    ((behavior "Forum Shopping")
     (action "Choose family court instead of commercial court")
     (stated-reason "Financial fraud claims")
     (actual-reason "Family court allows control over beneficiaries")
     (ketoni-motive "Control beneficiaries' shares of ZAR 18.75M")
     (timing "Aug 13, 2025 (T-9 months before payout)")
     (confidence 0.95))
    
    ((behavior "Trustee Power Backdating")
     (action "Obtain Jax's signature on Main Trustee backdating document")
     (date "2025-08-11")
     (backdated-to "2025-07-01")
     (ketoni-motive "Sole control over trust decisions before May 2026")
     (timing "T-9 months before payout")
     (confidence 0.90))
    
    ((behavior "Immediate Betrayal")
     (action "Interdict Jax 2 days after she signs backdating document")
     (date "2025-08-13")
     (reason "Crime of helping Daniel")
     (ketoni-motive "Neutralize Jax as trustee before May 2026")
     (timing "T-9 months before payout")
     (confidence 0.97))
    
    ((behavior "Joint Beneficiary Targeting")
     (action "Interdict both Jax AND Dan together")
     (date "2025-08-13")
     (ketoni-motive "Both are beneficiaries entitled to shares of ZAR 18.75M")
     (timing "T-9 months before payout")
     (confidence 0.96))
    
    ((behavior "Medical Testing Rush")
     (action "Rush toward medical testing of Dan")
     (timing "Aug 2025 (T-9 months before payout)")
     (suspected-purpose "Curatorship fraud")
     (ketoni-motive "Curatorship = full control over Dan's share of ZAR 18.75M")
     (confidence 0.92))
    
    ((behavior "Fraud Exposure Retaliation")
     (action "Cancel all business cards <24 hours after Dan exposes fraud")
     (date "2025-06-07")
     (trigger "Dan's fraud disclosure to Bantjies (2025-06-06)")
     (ketoni-context "Fraud exposure threatens control structure before payout")
     (confidence 0.93)))
  
  ;; AGENT RELATIONSHIPS (Ketoni-contextualized)
  (relationships
    ((related-agent "agent-jacqueline-faucitt")
     (relationship-type "Adversarial")
     (context "Neutralized as trustee via interdict")
     (ketoni-impact "Cannot oppose Peter's payout decisions")
     (confidence 0.97))
    
    ((related-agent "agent-daniel-faucitt")
     (relationship-type "Adversarial")
     (context "Targeted via interdict + medical testing + curatorship")
     (ketoni-impact "If curatorship granted, Peter controls Dan's share")
     (confidence 0.94))
    
    ((related-agent "agent-daniel-bantjies")
     (relationship-type "Aligned")
     (context "Co-trustee, colleague of Ketoni Director")
     (ketoni-impact "Peter + Bantjies control trust before May 2026")
     (confidence 0.91))
    
    ((related-agent "agent-ketoni-investment-holdings")
     (relationship-type "Financial Creditor")
     (context "Ketoni owes ZAR 18.75M to FFT")
     (ketoni-impact "Peter controls distribution as Main Trustee")
     (confidence 0.90)))
  
  ;; AGENT DECISION-MAKING MODEL
  (decision-model
    (primary-driver "Maximize personal share of ZAR 18.75M Ketoni payout")
    (constraint "Fiduciary duty to all beneficiaries")
    (conflict-resolution "Personal interest overrides fiduciary duty")
    (timing-pressure "May 2026 payout deadline")
    (risk-tolerance "High - willing to use interdicts, medical testing, curatorship")
    (confidence 0.94)))

;;; ============================================================================
;;; AGENT 2: JACQUELINE FAUCITT - THE NEUTRALIZED TRUSTEE
;;; ============================================================================

(define-agent agent-jacqueline-faucitt
  (type individual-agent)
  (agent-id "jacqueline-faucitt")
  (full-name "JACQUELINE FAUCITT")
  (id-number "5706070898181")
  
  ;; ROLES & POWERS
  (roles
    ((role "Trustee")
     (entity "Faucitt Family Trust")
     (powers "Fiduciary duty to all beneficiaries")
     (since "2013-11-27")
     (status "NEUTRALIZED via interdict (2025-08-13)"))
    
    ((role "Beneficiary")
     (entity "Faucitt Family Trust")
     (entitlement "Share of ZAR 18.75M Ketoni payout")
     (since "2013-11-27")
     (threat "Share controlled by Peter via interdict")))
  
  ;; FINANCIAL INTERESTS
  (financial-interests
    ((interest-type "Beneficiary Share")
     (asset "Ketoni ZAR 18.75M payout")
     (payout-date "2026-05")
     (threat "Peter controls distribution, Jax neutralized as trustee")
     (confidence 0.95)))
  
  ;; AGENT OBJECTIVES
  (objectives
    ((objective "Protect Dan (son) from Peter's attacks")
     (priority "HIGH")
     (mechanism "Confrontation with Rynette, support for Dan")
     (result "Interdicted for 'crime of helping Daniel'")
     (confidence 0.97))
    
    ((objective "Address ReZonance debt")
     (priority "MEDIUM")
     (mechanism "Confrontation with Rynette (2025-05-15)")
     (statement "Keeping funds is profiting from proceeds of murder")
     (result "Retaliation: Orders removed from Shopify")
     (confidence 0.95))
    
    ((objective "Protect beneficiary share of Ketoni payout")
     (priority "HIGH")
     (threat "Neutralized as trustee, cannot oppose Peter's decisions")
     (confidence 0.96)))
  
  ;; AGENT BEHAVIORS
  (behaviors
    ((behavior "Cooperation with Peter")
     (action "Signed Main Trustee backdating document")
     (date "2025-08-11")
     (backdated-to "2025-07-01")
     (result "Gave Peter sole control over trust")
     (ketoni-impact "Peter controls ZAR 18.75M distribution")
     (confidence 0.90))
    
    ((behavior "Immediate Betrayal Victim")
     (action "Interdicted 2 days after signing backdating document")
     (date "2025-08-13")
     (reason "Crime of helping Daniel")
     (ketoni-impact "Neutralized as trustee before May 2026 payout")
     (confidence 0.97))
    
    ((behavior "Confrontation with Rynette")
     (action "Confronted Rynette about R1,035,000 debt to ReZonance")
     (date "2025-05-15")
     (statement "Keeping funds is profiting from proceeds of murder")
     (ketoni-context "R1M debt is obstacle to clean control of ZAR 18.75M")
     (result "Retaliation: Orders removed from Shopify (2025-05-22)")
     (confidence 0.95)))
  
  ;; AGENT RELATIONSHIPS
  (relationships
    ((related-agent "agent-peter-faucitt")
     (relationship-type "Adversarial")
     (context "Betrayed 2 days after cooperation")
     (ketoni-impact "Neutralized as trustee, cannot protect her share")
     (confidence 0.97))
    
    ((related-agent "agent-daniel-faucitt")
     (relationship-type "Protective")
     (context "Mother protecting son")
     (result "Interdicted for 'crime of helping Daniel'")
     (confidence 0.97))
    
    ((related-agent "agent-rynette")
     (relationship-type "Adversarial")
     (context "Confronted about ReZonance debt")
     (result "Retaliation via Shopify order removal")
     (confidence 0.95)))
  
  ;; AGENT DECISION-MAKING MODEL
  (decision-model
    (primary-driver "Protect Dan and beneficiary interests")
    (constraint "Neutralized as trustee via interdict")
    (conflict-resolution "Maternal protection overrides personal safety")
    (timing-pressure "May 2026 payout deadline")
    (risk-tolerance "High - willing to confront Peter and Rynette")
    (confidence 0.95)))

;;; ============================================================================
;;; AGENT 3: DANIEL JAMES FAUCITT - THE TARGETED BENEFICIARY
;;; ============================================================================

(define-agent agent-daniel-faucitt
  (type individual-agent)
  (agent-id "daniel-faucitt")
  (full-name "DANIEL JAMES FAUCITT")
  (id-number "8207155300182")
  (professional-role "CIO")
  
  ;; ROLES & POWERS
  (roles
    ((role "Beneficiary")
     (entity "Faucitt Family Trust")
     (entitlement "Share of ZAR 18.75M Ketoni payout")
     (since "2013-11-27")
     (threat "Curatorship = Peter controls entire share")))
  
  ;; FINANCIAL INTERESTS
  (financial-interests
    ((interest-type "Beneficiary Share")
     (asset "Ketoni ZAR 18.75M payout")
     (payout-date "2026-05")
     (threat "Peter seeks curatorship to control Dan's share")
     (confidence 0.94)))
  
  ;; AGENT OBJECTIVES
  (objectives
    ((objective "Expose fraud in RegimA Group")
     (priority "HIGH")
     (mechanism "Disclosure to Bantjies (accountant)")
     (date "2025-06-06")
     (result "Immediate retaliation: Cards cancelled <24 hours")
     (confidence 0.97))
    
    ((objective "Protect beneficiary share of Ketoni payout")
     (priority "HIGH")
     (threat "Interdict + Medical Testing + Curatorship")
     (ketoni-impact "If curatorship granted, Peter controls Dan's entire share")
     (confidence 0.94))
    
    ((objective "Resist curatorship fraud")
     (priority "HIGH")
     (mechanism "Oppose medical testing and curatorship application")
     (ketoni-context "Curatorship = loss of control over ZAR 18.75M share")
     (confidence 0.92)))
  
  ;; AGENT BEHAVIORS
  (behaviors
    ((behavior "Fraud Exposure")
     (action "Disclosed Villa Via fraud to Bantjies")
     (date "2025-06-06")
     (content "Villa Via extracting funds from 'Group'")
     (context "Unaware Bantjies was Trustee appointed Jul 2024")
     (ketoni-context "Fraud exposure threatens control structure before payout")
     (result "Cards cancelled <24 hours, interdict filed 2 months later")
     (confidence 0.97))
    
    ((behavior "Resistance to Control")
     (action "Resisted pressure to dissolve ReZonance")
     (date "2024-02-14")
     (pressured-by "Bantjies, Peter, Rynette")
     (ketoni-context "ReZonance debt is obstacle to clean control of ZAR 18.75M")
     (result "ReZonance still exists but under deregistration pressure")
     (confidence 0.95))
    
    ((behavior "Competence Demonstration")
     (action "Financial analysis, fraud exposure, system building")
     (context "Actions demonstrate competence, not incapacity")
     (ketoni-relevance "Contradicts medical testing / curatorship basis")
     (confidence 0.96)))
  
  ;; AGENT RELATIONSHIPS
  (relationships
    ((related-agent "agent-peter-faucitt")
     (relationship-type "Adversarial")
     (context "Targeted via interdict + medical testing + curatorship")
     (ketoni-impact "Peter seeks full control over Dan's share of ZAR 18.75M")
     (confidence 0.94))
    
    ((related-agent "agent-jacqueline-faucitt")
     (relationship-type "Protective")
     (context "Mother protecting son")
     (result "Jax interdicted for 'crime of helping Daniel'")
     (confidence 0.97))
    
    ((related-agent "agent-daniel-bantjies")
     (relationship-type "Adversarial")
     (context "Disclosed fraud to Bantjies as accountant, unaware he was Trustee")
     (result "Immediate retaliation")
     (confidence 0.93))
    
    ((related-agent "agent-rezonance")
     (relationship-type "Co-Director")
     (context "50% owner with Kayla (deceased)")
     (ketoni-relevance "ReZonance debt is obstacle to Peter's control")
     (confidence 0.95)))
  
  ;; AGENT DECISION-MAKING MODEL
  (decision-model
    (primary-driver "Expose fraud and protect beneficiary interests")
    (constraint "Targeted via interdict + medical testing + curatorship")
    (conflict-resolution "Integrity overrides personal safety")
    (timing-pressure "May 2026 payout deadline")
    (risk-tolerance "High - willing to expose fraud despite retaliation")
    (confidence 0.95)))

;;; ============================================================================
;;; AGENT 4: DANIEL JACOBUS BANTJIES - THE STRATEGIC APPOINTEE
;;; ============================================================================

(define-agent agent-daniel-bantjies
  (type individual-agent)
  (agent-id "daniel-bantjies")
  (full-name "DANIEL JACOBUS BANTJES")
  (id-number "5810045103089")
  (professional-designation "CA (SA)")
  
  ;; ROLES & POWERS
  (roles
    ((role "Trust Accountant")
     (entity "Faucitt Family Trust")
     (since "2013-11-27")
     (source "Trust Deed"))
    
    ((role "Accountant for RegimA Group")
     (entities "All companies associated with Peter, Jacqui, Daniel")
     (context "Professional relationship since 2013"))
    
    ((role "Trustee")
     (entity "Faucitt Family Trust")
     (appointment-date "2024-07")
     (appointment-mechanism "Email by Rynette")
     (j246-registration "2024-10-18")
     (timing "T-10 months before ZAR 18.75M payout")
     (ketoni-significance "Appointed to consolidate control before payout")))
  
  ;; KETONI CONNECTION - CRITICAL
  (professional-connections
    ((connected-to "Kevin Michael Derrick")
     (connection-type "Colleague at George Group")
     (derrick-role "Director of Ketoni Investment Holdings")
     (ketoni-obligation "Ketoni owes ZAR 18.75M to FFT")
     (significance "Bantjies may have facilitated FFT investment in Ketoni (Apr 2023)")
     (confidence 0.90)))
  
  ;; AGENT OBJECTIVES
  (objectives
    ((objective "Consolidate trust control before Ketoni payout")
     (priority "HIGH")
     (mechanism "Accept trustee appointment (Jul 2024)")
     (timing "T-10 months before payout")
     (result "Peter + Bantjies control trust, Jax outvoted")
     (confidence 0.91))
    
    ((objective "Eliminate ReZonance debt obstacle")
     (priority "MEDIUM")
     (mechanism "Pressure Dan to dissolve ReZonance (2024-02-14)")
     (ketoni-context "R1M debt is obstacle to clean control of ZAR 18.75M")
     (result "Dan refused, ReZonance still exists")
     (confidence 0.90))
    
    ((objective "Protect fraud schemes")
     (priority "HIGH")
     (mechanism "Retaliation against Dan for fraud exposure")
     (timing "Immediate (<24 hours after Dan's disclosure)")
     (confidence 0.93)))
  
  ;; AGENT BEHAVIORS
  (behaviors
    ((behavior "Strategic Trustee Acceptance")
     (action "Accepted trustee appointment from Rynette")
     (date "2024-07")
     (timing "T-10 months before ZAR 18.75M payout")
     (ketoni-connection "Colleague of Ketoni Director (Kevin Derrick)")
     (ketoni-motive "Consolidate control before payout")
     (confidence 0.91))
    
    ((behavior "Beneficiary Non-Notification")
     (action "Did not inform Dan (beneficiary) of trustee appointment")
     (context "Dan discovers Bantjies is Trustee only after fraud disclosure")
     (ketoni-significance "Secret appointment to consolidate control")
     (confidence 0.92))
    
    ((behavior "ReZonance Dissolution Pressure")
     (action "Pressured Dan to dissolve ReZonance")
     (date "2024-02-14")
     (co-participants "Peter, Rynette")
     (ketoni-context "R1M debt is obstacle to ZAR 18.75M control")
     (result "Dan refused")
     (confidence 0.90))
    
    ((behavior "Fraud Exposure Retaliation")
     (action "Participated in retaliation after Dan's fraud disclosure")
     (date "2025-06-06 (disclosure), 2025-06-07 (retaliation)")
     (mechanism "Cards cancelled <24 hours")
     (ketoni-context "Fraud exposure threatens control before payout")
     (confidence 0.93)))
  
  ;; AGENT RELATIONSHIPS
  (relationships
    ((related-agent "agent-peter-faucitt")
     (relationship-type "Aligned")
     (context "Co-trustee, aligned on control consolidation")
     (ketoni-impact "Peter + Bantjies control trust before May 2026")
     (confidence 0.91))
    
    ((related-agent "agent-kevin-derrick")
     (relationship-type "Professional Colleague")
     (context "Colleagues at George Group")
     (ketoni-connection "Derrick is Director of Ketoni owing ZAR 18.75M to FFT")
     (significance "Bantjies may have facilitated FFT investment")
     (confidence 0.90))
    
    ((related-agent "agent-daniel-faucitt")
     (relationship-type "Adversarial")
     (context "Dan exposed fraud to Bantjies as accountant")
     (result "Immediate retaliation")
     (confidence 0.93))
    
    ((related-agent "agent-rynette")
     (relationship-type "Collaborative")
     (context "Rynette appointed Bantjies as Trustee")
     (ketoni-significance "Coordinated control consolidation")
     (confidence 0.92)))
  
  ;; AGENT DECISION-MAKING MODEL
  (decision-model
    (primary-driver "Consolidate trust control before Ketoni payout")
    (constraint "Professional obligations as accountant")
    (conflict-resolution "Trust control overrides professional ethics")
    (timing-pressure "May 2026 payout deadline")
    (risk-tolerance "Medium - willing to pressure beneficiaries, retaliate")
    (confidence 0.91)))

;;; ============================================================================
;;; AGENT 5: KEVIN MICHAEL DERRICK - THE KETONI DIRECTOR
;;; ============================================================================

(define-agent agent-kevin-derrick
  (type individual-agent)
  (agent-id "kevin-derrick")
  (full-name "KEVIN MICHAEL DERRICK")
  
  ;; ROLES & POWERS
  (roles
    ((role "Director")
     (entity "Ketoni Investment Holdings")
     (registration "2023/562189/07")
     (since "2023-02-20")
     (ketoni-obligation "Ketoni owes ZAR 18.75M to FFT (May 2026)")
     (confidence 0.95)))
  
  ;; PROFESSIONAL CONNECTIONS
  (professional-connections
    ((connected-to "Daniel Jacobus Bantjies")
     (connection-type "Colleague at George Group")
     (bantjies-role "FFT Trustee (appointed Jul 2024)")
     (significance "Bantjies appointed Trustee 10 months before ZAR 18.75M payout")
     (implication "Bantjies may have facilitated FFT investment in Ketoni")
     (confidence 0.90)))
  
  ;; AGENT OBJECTIVES
  (objectives
    ((objective "Manage Ketoni obligations to FFT")
     (priority "HIGH")
     (obligation "ZAR 18.75M payout (May 2026)")
     (confidence 0.90)))
  
  ;; AGENT RELATIONSHIPS
  (relationships
    ((related-agent "agent-daniel-bantjies")
     (relationship-type "Professional Colleague")
     (context "Colleagues at George Group")
     (ketoni-significance "Bantjies appointed FFT Trustee 10 months before payout")
     (confidence 0.90))
    
    ((related-agent "agent-ketoni-investment-holdings")
     (relationship-type "Director")
     (context "Director of company owing ZAR 18.75M to FFT")
     (confidence 0.95))
    
    ((related-agent "agent-faucitt-family-trust")
     (relationship-type "Debtor")
     (context "Ketoni owes ZAR 18.75M to FFT")
     (payout-date "2026-05")
     (confidence 0.90)))
  
  ;; AGENT DECISION-MAKING MODEL
  (decision-model
    (primary-driver "Manage Ketoni obligations")
    (constraint "Fiduciary duty to Ketoni shareholders")
    (timing-pressure "May 2026 payout deadline")
    (confidence 0.90)))

;;; ============================================================================
;;; AGENT 6: RYNETTE - THE OPERATIONAL CONTROLLER
;;; ============================================================================

(define-agent agent-rynette
  (type individual-agent)
  (agent-id "rynette")
  (full-name "RYNETTE")
  (role-clarification "NOT a Trustee of Faucitt Family Trust")
  
  ;; ROLES & POWERS
  (roles
    ((role "Operational Controller")
     (entities "RegimA Group companies")
     (control-mechanisms
       "- Controlled Peter's email (pete@regima.com)
        - Controlled Sage accounting system
        - Controlled all company accounts and banks
        - Appointed Bantjies as Trustee (Jul 2024)")
     (confidence 0.95)))
  
  ;; AGENT OBJECTIVES
  (objectives
    ((objective "Consolidate operational control")
     (priority "HIGH")
     (mechanism "Control accounting, emails, banks")
     (confidence 0.95))
    
    ((objective "Appoint aligned trustee")
     (priority "HIGH")
     (mechanism "Appointed Bantjies as Trustee (Jul 2024)")
     (timing "T-10 months before ZAR 18.75M payout")
     (ketoni-significance "Consolidate trust control before payout")
     (confidence 0.92))
    
    ((objective "Eliminate ReZonance debt obstacle")
     (priority "MEDIUM")
     (mechanism "Misallocate GoDaddy payments, pressure dissolution")
     (ketoni-context "R1M debt is obstacle to ZAR 18.75M control")
     (confidence 0.90)))
  
  ;; AGENT BEHAVIORS
  (behaviors
    ((behavior "Trustee Appointment")
     (action "Appointed Bantjies as Trustee via email")
     (date "2024-07")
     (timing "T-10 months before ZAR 18.75M payout")
     (ketoni-motive "Consolidate trust control before payout")
     (confidence 0.92))
    
    ((behavior "Accounting Control")
     (action "Controlled Sage system, Peter's email")
     (context "Two years of unallocated expenses")
     (ketoni-relevance "Control financial records before payout")
     (confidence 0.95))
    
    ((behavior "Retaliation Against Jacqui")
     (action "Removed Shopify orders after Jax's confrontation")
     (date "2025-05-22 (7 days after confrontation)")
     (trigger "Jax confronted about R1M ReZonance debt (2025-05-15)")
     (ketoni-context "R1M debt is obstacle to ZAR 18.75M control")
     (confidence 0.95)))
  
  ;; AGENT RELATIONSHIPS
  (relationships
    ((related-agent "agent-peter-faucitt")
     (relationship-type "Collaborative")
     (context "Operational control aligned with Peter's objectives")
     (ketoni-impact "Supports Peter's control consolidation")
     (confidence 0.93))
    
    ((related-agent "agent-daniel-bantjies")
     (relationship-type "Collaborative")
     (context "Appointed Bantjies as Trustee")
     (ketoni-significance "Consolidate trust control before payout")
     (confidence 0.92))
    
    ((related-agent "agent-jacqueline-faucitt")
     (relationship-type "Adversarial")
     (context "Retaliation after Jax's confrontation")
     (confidence 0.95))
    
    ((related-agent "agent-daniel-faucitt")
     (relationship-type "Adversarial")
     (context "Pressure to dissolve ReZonance, fraud concealment")
     (confidence 0.93)))
  
  ;; AGENT DECISION-MAKING MODEL
  (decision-model
    (primary-driver "Maintain operational control")
    (constraint "Not a trustee, acts through others")
    (timing-pressure "May 2026 payout deadline")
    (risk-tolerance "High - willing to misallocate, retaliate")
    (confidence 0.93)))

;;; ============================================================================
;;; AGENT 7: KETONI INVESTMENT HOLDINGS - THE FINANCIAL NEXUS
;;; ============================================================================

(define-agent agent-ketoni-investment-holdings
  (type corporate-agent)
  (agent-id "ketoni-investment-holdings")
  (official-name "KETONI INVESTMENT HOLDINGS")
  (registration-number "2023/562189/07")
  (incorporation-date "2023-02-20")
  
  ;; FINANCIAL OBLIGATIONS - THE CENTRAL NEXUS
  (financial-obligations
    ((creditor "Faucitt Family Trust")
     (amount "ZAR 18,750,000.00")
     (payout-type "Option")
     (payout-date "2026-05")
     (significance "CENTRAL FINANCIAL NEXUS - explains all FFT actions since Apr 2023")
     (confidence 0.90)))
  
  ;; DIRECTORS
  (directors
    ((name "Kevin Michael Derrick")
     (connection-to-fft "Colleague of Bantjies (FFT Trustee)")
     (confidence 0.95)))
  
  ;; SHAREHOLDERS
  (shareholders
    ((shareholder "Faucitt Family Trust")
     (shares 5000)
     (share-class "A-Ordinary")
     (certificate-date "2023-04-24")
     (expected-return "ZAR 18.75M (May 2026)")
     (confidence 1.00)))
  
  ;; AGENT RELATIONSHIPS
  (relationships
    ((related-agent "agent-faucitt-family-trust")
     (relationship-type "Debtor")
     (obligation "ZAR 18.75M payout (May 2026)")
     (confidence 0.90))
    
    ((related-agent "agent-kevin-derrick")
     (relationship-type "Director")
     (confidence 0.95))
    
    ((related-agent "agent-daniel-bantjies")
     (relationship-type "Indirect Connection")
     (context "Derrick (Director) is colleague of Bantjies (FFT Trustee)")
     (significance "Bantjies may have facilitated FFT investment")
     (confidence 0.90))))

;;; ============================================================================
;;; AGENT 8: FAUCITT FAMILY TRUST - THE TRUST ENTITY
;;; ============================================================================

(define-agent agent-faucitt-family-trust
  (type trust-agent)
  (agent-id "faucitt-family-trust")
  (official-name "FAUCITT FAMILY TRUST")
  (trust-number "IT 003651/2013")
  
  ;; FINANCIAL ASSETS - THE CENTRAL ASSET
  (financial-assets
    ((asset-type "Investment Shareholding")
     (company "Ketoni Investment Holdings")
     (shares 5000)
     (expected-payout "ZAR 18,750,000.00")
     (payout-date "2026-05")
     (significance "CENTRAL FINANCIAL ASSET - explains all trust actions")
     (confidence 0.90)))
  
  ;; TRUSTEES
  (trustees
    ((name "Peter Andrew Faucitt")
     (role "Founder + Main Trustee + Beneficiary")
     (ketoni-interest "Control distribution of ZAR 18.75M")
     (confidence 1.00))
    
    ((name "Jacqueline Faucitt")
     (role "Trustee + Beneficiary")
     (status "NEUTRALIZED via interdict (2025-08-13)")
     (ketoni-impact "Cannot oppose Peter's payout decisions")
     (confidence 1.00))
    
    ((name "Daniel Jacobus Bantjies")
     (role "Trustee")
     (appointment "2024-07 (T-10 months before payout)")
     (ketoni-connection "Colleague of Ketoni Director")
     (confidence 1.00)))
  
  ;; BENEFICIARIES
  (beneficiaries
    ((name "Peter Andrew Faucitt")
     (entitlement "Share of ZAR 18.75M")
     (control "Full control as Main Trustee")
     (confidence 1.00))
    
    ((name "Jacqueline Faucitt")
     (entitlement "Share of ZAR 18.75M")
     (threat "Neutralized as trustee, share controlled by Peter")
     (confidence 1.00))
    
    ((name "Daniel James Faucitt")
     (entitlement "Share of ZAR 18.75M")
     (threat "Curatorship = Peter controls entire share")
     (confidence 1.00)))
  
  ;; AGENT RELATIONSHIPS
  (relationships
    ((related-agent "agent-ketoni-investment-holdings")
     (relationship-type "Creditor")
     (obligation "Ketoni owes ZAR 18.75M to FFT")
     (payout-date "2026-05")
     (confidence 0.90))
    
    ((related-agent "agent-peter-faucitt")
     (relationship-type "Trustee-Beneficiary")
     (conflict "Fiduciary duty vs personal financial interest")
     (confidence 1.00))
    
    ((related-agent "agent-jacqueline-faucitt")
     (relationship-type "Trustee-Beneficiary")
     (status "Neutralized via interdict")
     (confidence 1.00))
    
    ((related-agent "agent-daniel-faucitt")
     (relationship-type "Beneficiary")
     (threat "Curatorship attempt")
     (confidence 1.00))
    
    ((related-agent "agent-daniel-bantjies")
     (relationship-type "Trustee")
     (timing "Appointed T-10 months before payout")
     (confidence 1.00))))

;;; ============================================================================
;;; AGENT 9: REZONANCE - THE FINANCIAL OBSTACLE
;;; ============================================================================

(define-agent agent-rezonance
  (type corporate-agent)
  (agent-id "rezonance")
  (official-name "REZONANCE")
  
  ;; DIRECTORS
  (directors
    ((name "Daniel James Faucitt")
     (ownership "50%")
     (confidence 0.95))
    
    ((name "Kayla Pretorius")
     (ownership "50%")
     (status "DECEASED (murdered 2023-07-13)")
     (ketoni-timing "Murdered 80 days after FFT Ketoni investment")
     (confidence 1.00)))
  
  ;; FINANCIAL CLAIMS
  (financial-claims
    ((debtor "RegimA Skin Treatments")
     (amount "R1,035,000+")
     (statement-date "2023-02-28")
     (status "UNPAID as of Dec 2025")
     (ketoni-context "ZAR 18.75M dwarfs R1M debt - debt is obstacle to control")
     (confidence 1.00)))
  
  ;; AGENT RELATIONSHIPS
  (relationships
    ((related-agent "agent-daniel-faucitt")
     (relationship-type "Co-Director")
     (ownership "50%")
     (confidence 0.95))
    
    ((related-agent "agent-faucitt-family-trust")
     (relationship-type "Creditor")
     (context "FFT companies owe R1M+ to ReZonance")
     (ketoni-relevance "Debt is obstacle to clean control of ZAR 18.75M")
     (confidence 0.95))))

;;; ============================================================================
;;; KETONI PAYOUT AGENT NETWORK
;;; ============================================================================

(define-network ketoni-payout-agent-network
  (network-name "Ketoni ZAR 18.75M Payout Control Network")
  (central-asset "ZAR 18.75M Ketoni payout (May 2026)")
  
  ;; NETWORK NODES
  (nodes
    agent-peter-faucitt
    agent-jacqueline-faucitt
    agent-daniel-faucitt
    agent-daniel-bantjies
    agent-kevin-derrick
    agent-rynette
    agent-ketoni-investment-holdings
    agent-faucitt-family-trust
    agent-rezonance)
  
  ;; NETWORK DYNAMICS
  (network-dynamics
    ((phase "Investment Phase")
     (period "Feb-Apr 2023")
     (key-events
       "- Ketoni incorporated (2023-02-20)
        - ReZonance debt statement (2023-02-28)
        - FFT invests in Ketoni (2023-04-24)")
     (significance "ZAR 18.75M entitlement established"))
    
    ((phase "Creditor Elimination Phase")
     (period "Jul 2023 - Feb 2024")
     (key-events
       "- Kayla murdered (2023-07-13, 80 days after investment)
        - Card expiry forces expenses to RWD (2023-07-31)
        - Pressure to dissolve ReZonance (2024-02-14)")
     (significance "R1M debt obstacle elimination attempt"))
    
    ((phase "Control Consolidation Phase")
     (period "Jul 2024 - Aug 2025")
     (key-events
       "- Bantjies appointed Trustee (2024-07, T-10 months)
        - Main Trustee backdated (2025-08-11, T-9 months)
        - Interdict filed (2025-08-13, T-9 months)
        - Medical testing rushed (2025-08, T-9 months)")
     (significance "Peter consolidates control before May 2026 payout"))
    
    ((phase "Payout Phase")
     (period "May 2026")
     (key-event "ZAR 18.75M Ketoni payout due")
     (control-structure
       "- Peter: Full control as Main Trustee
        - Bantjies: Aligned co-trustee
        - Jax: Neutralized via interdict
        - Dan: Targeted via curatorship")
     (significance "ALL EVENTS CONVERGE HERE")))
  
  ;; NETWORK INSIGHTS
  (network-insights
    "1. ZAR 18.75M Ketoni payout is CENTRAL ORGANIZING PRINCIPLE
     2. All agent behaviors driven by May 2026 payout deadline
     3. Peter's objective: Maximize personal share by controlling others
     4. Jax neutralized: Cannot oppose Peter's payout decisions
     5. Dan targeted: Curatorship = Peter controls Dan's entire share
     6. Bantjies appointed: Consolidate control before payout
     7. ReZonance debt: R1M obstacle to clean control of ZAR 18.75M
     8. Timing convergence: All control actions T-9 to T-10 months before payout
     9. Forum shopping: Family court allows control over beneficiaries
     10. ALL EVENTS CONVERGE ON MAY 2026 PAYOUT DATE"))

;;; ============================================================================
;;; END OF AGENT-BASED MODEL V48 - KETONI PAYOUT INTEGRATED
;;; ============================================================================
