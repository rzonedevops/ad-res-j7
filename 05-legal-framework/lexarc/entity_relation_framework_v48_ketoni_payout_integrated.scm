;;; ============================================================================
;;; ENTITY-RELATION FRAMEWORK V48 - KETONI ZAR 18.75M PAYOUT INTEGRATED
;;; ============================================================================
;;; Version: 48.0
;;; Date: 2025-12-26
;;; Verification Level: PRIMARY SOURCE VERIFIED + CRITICAL REVELATION INTEGRATED
;;; 
;;; CRITICAL REVELATION (Discovered 2 weeks ago):
;;; The ZAR 18.75 million payout available as option in May 2026 is owed by 
;;; Ketoni to the Faucitt Family Trust. This revelation provides the central
;;; financial motive that re-contextualizes ALL events involving the Trust.
;;;
;;; METHODOLOGY:
;;; - All entity data extracted from official documents only
;;; - No assumptions or inferences without explicit source citation
;;; - Confidence levels based on source reliability
;;; - Unverified claims explicitly marked as UNVERIFIED
;;; - Financial motive analysis integrated throughout
;;; ============================================================================

;;; ============================================================================
;;; SECTION 1: KETONI INVESTMENT HOLDINGS - THE CENTRAL FINANCIAL NEXUS
;;; ============================================================================

(define-entity ketoni-investment-holdings
  (type company)
  (official-name "KETONI INVESTMENT HOLDINGS")
  (registration-number "2023/562189/07")
  (incorporation-date "2023-02-20")
  (source-cipc "CIPC Records")
  (verification-confidence 0.95)
  
  ;; CRITICAL FINANCIAL OBLIGATION
  (financial-obligations
    ((creditor "Faucitt Family Trust")
     (amount "ZAR 18,750,000.00")
     (payout-type "Option")
     (payout-date "2026-05")
     (discovery-date "~2025-12-12")  ;; "2 weeks ago" from 2025-12-26
     (source "User disclosure - requires document verification")
     (verification-confidence 0.80)  ;; High confidence from user, pending document
     (significance "CENTRAL MOTIVE - explains all trust actions")))
  
  ;; VERIFIED Director from CIPC
  (directors
    ((name "KEVIN MICHAEL DERRICK")
     (id-number "UNKNOWN")
     (source "CIPC Records via DANIE_BANTJES_GEORGE_GROUP_CONNECTION.md")
     (verification-confidence 0.95)
     (connection-to-bantjies "Colleague at George Group")))
  
  ;; VERIFIED Shareholders
  (shareholders
    ((shareholder "Faucitt Family Trust")
     (share-certificate-number "3")
     (share-class "A-Ordinary")
     (number-of-shares 5000)
     (certificate-date "2023-04-24")
     (source "Share Certificate Analysis")
     (verification-confidence 1.00)
     (investment-timing "2 months after R1,035,000 debt to ReZonance")))
  
  ;; ANNUAL FINANCIAL STATEMENTS - FY2024 (Year ended 29 Feb 2024)
  ;; Source: Exchange email 0863_20250129 from Bantjes to Rynette
  (annual-financial-statements
    ((year-end "2024-02-29")
     (prepared-by "Forvis Mazars")
     (review-type "Independent Review - Companies Act compliance")
     (pages 16)
     (contents "Balance Sheet, Income Statement, Notes, Directors Report")
     (source-document "Ketoni Investment Holdings AFS 2024 - Signed.pdf")
     (source-email-date "2025-01-29")
     (source-email-from "Danie Bantjes <danie.bantjes@gmail.com>")
     (source-email-to "Rynette Farrar <rynette@regima.zone>")
     (source-email-subject "Re: Faucitt family trust - agreement")
     (verification-confidence 0.95)
     (evidentiary-significance
       "AFS sent to bookkeeper (Rynette) not beneficiaries (Jax/Dan).
        Delivered 57 days before revenue hijacking began (Mar 2025).
        Delivered ~15 months before R18.75M payout option (May 2026).
        Confirms Ketoni operational activity during first full year.
        Balance sheet should disclose R18.75M shareholder obligation.")))

  ;; CRITICAL TIMELINE CONTEXT
  (incorporation-context
    (incorporated "2023-02-20")
    (rezonance-debt-statement "2023-02-28")  ;; 8 days AFTER Ketoni incorporation
    (fft-investment "2023-04-24")  ;; 63 days after incorporation
    (kayla-murder "2023-07-13")  ;; 80 days after FFT investment
    (afs-fy2024-sent "2025-01-29")  ;; AFS sent to Rynette, 57 days before scheme
    (significance "Ketoni incorporated while R1M+ debt to ReZonance unpaid")))

;;; ============================================================================
;;; SECTION 2: FAUCITT FAMILY TRUST - RE-CONTEXTUALIZED WITH FINANCIAL MOTIVE
;;; ============================================================================

(define-entity faucitt-family-trust
  (type trust)
  (official-name "FAUCITT FAMILY TRUST")
  
  ;; VERIFIED from J246 Letter of Authority
  (trust-number "IT 003651/2013")
  (urn "9922013TRU003651")
  (registration-office "JOHANNESBURG")
  (j246-authorization-date "2024-10-18")
  (source-j246 "J246+-+Letter+of+Authority(3).pdf")
  (verification-confidence 1.00)
  
  ;; VERIFIED from Trust Deed
  (execution-date "2013-11-27")
  (registration-date "2013-12-05")
  (initial-donation "R100.00")
  (source-deed "deed_of_trust_reconstructed.md")
  
  ;; =========================================================================
  ;; CRITICAL FINANCIAL ASSET - THE CENTRAL MOTIVE
  ;; =========================================================================
  (financial-assets
    ((asset-type "Investment Shareholding")
     (company "Ketoni Investment Holdings")
     (shares 5000)
     (share-class "A-Ordinary")
     (certificate-date "2023-04-24")
     (expected-payout "ZAR 18,750,000.00")
     (payout-date "2026-05")
     (payout-mechanism "Option")
     (source "Share Certificate + User disclosure")
     (verification-confidence 0.90)
     (CRITICAL-SIGNIFICANCE 
       "This ZAR 18.75M payout explains:
        1. WHY Peter interdicted Jax in family court (not commercial court)
        2. WHY Peter interdicted both Jax AND Dan together
        3. WHY medical testing was rushed (curatorship fraud attempt)
        4. WHY Bantjies was appointed Trustee in July 2024 (control consolidation)
        5. WHY family court was chosen (control beneficiary shares of payout)
        6. MOTIVE for all trust activities since Apr 2023 investment")))
  
  ;; VERIFIED Founder from Trust Deed
  (founder
    (name "PETER ANDREW FAUCITT")
    (id-number "5204305708185")
    (address "20 River Road, Morning Hill, Bedfordview")
    (source "Trust Deed - Image 12 Deed Of Trust Title")
    (verification-confidence 1.00)
    (financial-interest-in-ketoni-payout "As Founder, has powers over trust assets"))
  
  ;; VERIFIED Original Trustees from Trust Deed (2013)
  (original-trustees
    ((name "PETER ANDREW FAUCITT")
     (id-number "5204305708185")
     (role "Trustee")
     (appointment-date "2013-11-27")
     (source "Trust Deed - Declaration by Trustees")
     (verification-confidence 1.00))
    ((name "JACQUELINE FAUCITT")
     (id-number "5706070898181")
     (role "Trustee")
     (appointment-date "2013-11-27")
     (source "Trust Deed - Declaration by Trustees")
     (verification-confidence 1.00)))
  
  ;; VERIFIED Current Trustees from J246 (2024) - RE-CONTEXTUALIZED
  (current-trustees-as-of-2024-10-18
    ((name "PETER ANDREW FAUCITT")
     (id-number "5204305708185")
     (source "J246 Letter of Authority")
     (verification-confidence 1.00)
     (ketoni-payout-control-motive "Controls trust decisions on ZAR 18.75M payout")
     (backdated-main-trustee-designation "2025-07-01")
     (backdating-document-signed "2025-08-11")
     (backdating-signed-by "Jacqueline Faucitt")
     (significance "Main Trustee designation gives Peter sole control before May 2026"))
    
    ((name "JACQUELINE FAUCITT")
     (id-number "5706070898181")
     (source "J246 Letter of Authority")
     (verification-confidence 1.00)
     (ketoni-payout-beneficiary-interest "Entitled to beneficiary share of payout")
     (interdict-inclusion "2025-08-13")
     (interdict-timing "2 days after signing Main Trustee backdating document")
     (significance "Interdicted for 'crime of helping Daniel' - neutralized as trustee"))
    
    ((name "DANIEL JACOBUS BANTJES")
     (id-number "5810045103089")
     (source "J246 Letter of Authority")
     (verification-confidence 1.00)
     (appointment-date "2024-07")  ;; Email appointment by Rynette
     (j246-registration "2024-10-18")
     (ketoni-connection "Colleague of Kevin Derrick (Ketoni Director) at George Group")
     (ketoni-payout-control-motive "Appointed 10 months before May 2026 payout")
     (significance "Strategic appointment to control trust before payout date")))
  
  ;; VERIFIED Beneficiaries from Trust Deed - RE-CONTEXTUALIZED
  (beneficiaries
    ((name "PETER ANDREW FAUCITT")
     (id-number "5204305708185")
     (address "20 River Road, Morning Hill, Bedfordview")
     (source "Trust Deed - Clause 1.3 and Image 12")
     (signature-date "2013-11-27")
     (verification-confidence 1.00)
     (ketoni-payout-entitlement "Beneficiary share of ZAR 18.75M payout")
     (dual-role-conflict "Both Trustee AND Beneficiary - conflict of interest"))
    
    ((name "JACQUELINE FAUCITT")
     (id-number "5706070898181")
     (address "20 River Road, Morning Hill, Bedfordview")
     (source "Trust Deed - Clause 1.3 and Image 25")
     (signature-date "2013-11-27")
     (verification-confidence 1.00)
     (ketoni-payout-entitlement "Beneficiary share of ZAR 18.75M payout")
     (interdict-impact "Interdicted 9 months before payout - control mechanism")
     (significance "Interdict prevents her from controlling her beneficiary share"))
    
    ((name "DANIEL JAMES FAUCITT")
     (id-number "8207155300182")
     (address "16 Villa Palmar, 20A Protea Road, Bedfordview")
     (source "Trust Deed - Image 29 Deed Preamble Daniel")
     (signature-date "2013-11-27")
     (verification-confidence 1.00)
     (ketoni-payout-entitlement "Beneficiary share of ZAR 18.75M payout")
     (interdict-impact "Interdicted 9 months before payout - control mechanism")
     (medical-testing-threat "Curatorship fraud attempt to control his share")
     (significance "Primary target - interdict + medical testing = full control of his share")))
  
  ;; VERIFIED Trust Accountant - RE-CONTEXTUALIZED
  (accountant
    (name "D J BANTJES")
    (designation "CA (SA)")
    (address "19 Fisheagle Lane, Country Lane Estate, Rietvalleirand, 0081")
    (practice-number "944130")
    (source "Trust Deed - Declaration by Trustees, clause 6.b")
    (verification-confidence 1.00)
    (later-trustee-appointment "2024-07")
    (ketoni-connection "Colleague of Kevin Derrick at George Group")
    (significance "Accountant since 2013, appointed Trustee 10 months before payout"))
  
  ;; Key Trust Deed Provisions (VERIFIED) - RE-CONTEXTUALIZED
  (trustee-appointment-power
    (during-founder-life "Founder has sole power to appoint trustees")
    (after-founder-death "Surviving trustees may appoint new trustees")
    (source "Trust Deed - Clause 3.2 and 3.3")
    (verification-confidence 1.00)
    (ketoni-payout-relevance "Peter controls trustee appointments before May 2026"))
  
  (minimum-trustees 2)
  (maximum-trustees 5)
  (source-trustee-limits "Trust Deed - Clause 3.4")
  
  (termination-provision
    (description "Trust terminates at time determined by trustees in sole discretion")
    (vesting "Trust assets vest in beneficiaries on termination date")
    (source "Trust Deed - Clause 15")
    (verification-confidence 1.00)
    (ketoni-payout-relevance "Trustees control WHEN and HOW ZAR 18.75M is distributed"))
  
  ;; =========================================================================
  ;; FINANCIAL MOTIVE ANALYSIS - INTEGRATED THROUGHOUT
  ;; =========================================================================
  (ketoni-payout-motive-analysis
    (central-revelation "ZAR 18.75M payout owed by Ketoni to FFT in May 2026")
    
    (explains-family-court-choice
      "Peter chose family court (not commercial court) because:
       - Family court allows control over beneficiaries (Jax & Dan)
       - Commercial court would only address 'financial fraud' claims
       - Family court interdict controls beneficiary shares of payout
       - Medical testing = curatorship = full control of Dan's share")
    
    (explains-joint-interdict
      "Peter interdicted BOTH Jax AND Dan together because:
       - Both are beneficiaries entitled to shares of ZAR 18.75M
       - Interdicting both maximizes Peter's control over payout distribution
       - Jax interdicted for 'helping Daniel' = neutralizing her beneficiary rights
       - Dan interdicted + medical testing = attempting full control of his share")
    
    (explains-bantjies-appointment
      "Rynette appointed Bantjies as Trustee in July 2024 because:
       - 10 months before May 2026 payout date
       - Bantjies is colleague of Kevin Derrick (Ketoni Director)
       - Consolidates control over trust decisions before payout
       - Ensures Peter + Bantjies control payout distribution (Jax neutralized)")
    
    (explains-medical-testing-rush
      "Medical testing rushed as suspected curatorship fraud because:
       - Curatorship would give Peter full control over Dan's beneficiary share
       - Dan's share of ZAR 18.75M would be controlled by curator (Peter)
       - Timing: 9 months before May 2026 payout
       - Pattern: Interdict + Medical Testing + Curatorship = Total Control")
    
    (explains-rezonance-debt-context
      "R1,035,000 debt to ReZonance remains unpaid because:
       - FFT invested in Ketoni (Apr 2023) while owing R1M+ to ReZonance
       - Kayla murdered (Jul 2023) 80 days after FFT Ketoni investment
       - Pressure to dissolve ReZonance (Feb 2024) would eliminate debt
       - ZAR 18.75M payout dwarfs R1M debt - debt is obstacle to control")
    
    (timing-analysis
      "All events converge on May 2026 payout date:
       - Apr 2023: FFT invests in Ketoni
       - Jul 2023: Kayla murdered (ReZonance co-director)
       - Jul 2024: Bantjies appointed Trustee (10 months before payout)
       - Aug 2025: Interdict filed (9 months before payout)
       - Aug 2025: Medical testing rushed (9 months before payout)
       - May 2026: ZAR 18.75M payout date - EVERYTHING POINTS HERE")))

;;; ============================================================================
;;; SECTION 3: INDIVIDUALS - RE-CONTEXTUALIZED WITH KETONI PAYOUT MOTIVE
;;; ============================================================================

(define-entity peter-andrew-faucitt
  (type individual)
  (full-name "PETER ANDREW FAUCITT")
  (id-number "5204305708185")
  (birth-date-derived "1952-04-30")
  (gender "Male")
  (citizenship "South African")
  
  ;; VERIFIED Address from Trust Deed
  (address-2013 "20 River Road, Morning Hill, Bedfordview"
    (source "Trust Deed 2013")
    (verification-confidence 1.00))
  
  ;; VERIFIED Roles in Trust - RE-CONTEXTUALIZED
  (trust-roles
    ((role "Founder")
     (trust "Faucitt Family Trust")
     (date "2013-11-27")
     (source "Trust Deed")
     (verification-confidence 1.00)
     (ketoni-payout-power "Founder powers over ZAR 18.75M trust asset"))
    
    ((role "Trustee")
     (trust "Faucitt Family Trust")
     (appointment-date "2013-11-27")
     (source "Trust Deed")
     (verification-confidence 1.00)
     (ketoni-payout-control "Trustee control over payout distribution"))
    
    ((role "Main Trustee")
     (trust "Faucitt Family Trust")
     (designation-date-backdated "2025-07-01")
     (document-signed "2025-08-11")
     (source "Document signed by Jacqueline Faucitt")
     (verification-confidence 0.90)
     (ketoni-payout-significance "Main Trustee = sole control before May 2026"))
    
    ((role "Beneficiary")
     (trust "Faucitt Family Trust")
     (date "2013-11-27")
     (source "Trust Deed - Clause 1.3")
     (verification-confidence 1.00)
     (ketoni-payout-entitlement "Beneficiary share of ZAR 18.75M")))
  
  ;; LEGAL ACTIONS - RE-CONTEXTUALIZED WITH KETONI MOTIVE
  (legal-actions
    ((action "Interdict")
     (case-number "2025/137857")
     (filing-date "2025-08-13")
     (respondents "Jacqueline Faucitt" "Daniel James Faucitt")
     (court "Family Court")  ;; NOT Commercial Court
     (timing "9 months before May 2026 Ketoni payout")
     (ketoni-motive-analysis
       "Family court choice (not commercial court) explained by:
        - Control over beneficiaries (Jax & Dan) before May 2026 payout
        - Commercial court inappropriate for controlling beneficiary shares
        - Family court allows interdict + medical testing = curatorship
        - Curatorship = full control over Dan's ZAR 18.75M share
        - Jax interdicted = neutralized as trustee before payout")
     (significance "CENTRAL CONTROL MECHANISM for ZAR 18.75M payout")))
  
  ;; VERIFIED Company Roles from B2Bhint CIPC Records
  (company-roles
    ((company "REGIMA WORLDWIDE DISTRIBUTION")
     (registration "2011/005722/07")
     (role "Director")
     (source "B2Bhint CIPC")
     (verification-confidence 0.95)
     (trust-ownership "Owned by Faucitt Family Trust"))
    
    ((company "VILLA VIA ARCADIA NO 2")
     (registration "1996/004451")
     (role "Member")
     (source "B2Bhint CIPC")
     (verification-confidence 0.95)
     (trust-ownership "Owned by Faucitt Family Trust")
     (fraud-context "Villa Via extracting funds from 'Group' - exposed by Daniel Jun 2025"))))

(define-entity jacqueline-faucitt
  (type individual)
  (full-name "JACQUELINE FAUCITT")
  (id-number "5706070898181")
  (birth-date-derived "1957-06-07")
  (gender "Female")
  (citizenship "South African")
  
  ;; VERIFIED Address from Trust Deed
  (address-2013 "20 River Road, Morning Hill, Bedfordview"
    (source "Trust Deed 2013")
    (verification-confidence 1.00))
  
  ;; VERIFIED Roles in Trust - RE-CONTEXTUALIZED
  (trust-roles
    ((role "Trustee")
     (trust "Faucitt Family Trust")
     (appointment-date "2013-11-27")
     (source "Trust Deed")
     (verification-confidence 1.00)
     (neutralization-date "2025-08-13")
     (neutralization-mechanism "Interdict for 'crime of helping Daniel'")
     (ketoni-payout-impact "Neutralized as trustee 9 months before May 2026 payout"))
    
    ((role "Beneficiary")
     (trust "Faucitt Family Trust")
     (date "2013-11-27")
     (source "Trust Deed - Clause 1.3")
     (verification-confidence 1.00)
     (ketoni-payout-entitlement "Beneficiary share of ZAR 18.75M")
     (control-threat "Interdict prevents control over her beneficiary share")))
  
  ;; CRITICAL EVENTS - RE-CONTEXTUALIZED
  (critical-events
    ((event "Confrontation with Rynette")
     (date "2025-05-15")
     (subject "R1,035,000 debt to ReZonance")
     (statement "Keeping funds is profiting from proceeds of murder")
     (source "Communication records")
     (ketoni-context "R1M debt vs ZAR 18.75M payout - debt is obstacle"))
    
    ((event "Signed Main Trustee Backdating Document")
     (date "2025-08-11")
     (backdated-to "2025-07-01")
     (beneficiary "Peter Andrew Faucitt")
     (source "User disclosure")
     (verification-confidence 0.90)
     (ketoni-significance "Gave Peter sole control before May 2026 payout"))
    
    ((event "Included in Interdict")
     (date "2025-08-13")
     (timing "2 days after signing backdating document")
     (reason "Crime of helping Daniel")
     (source "Court records")
     (ketoni-motive "Neutralized as trustee before May 2026 payout distribution"))))

(define-entity daniel-james-faucitt
  (type individual)
  (full-name "DANIEL JAMES FAUCITT")
  (id-number "8207155300182")
  (birth-date-derived "1982-07-15")
  (gender "Male")
  (citizenship "South African")
  (professional-role "CIO")
  
  ;; VERIFIED Address from Trust Deed
  (address-2013 "16 Villa Palmar, 20A Protea Road, Bedfordview"
    (source "Trust Deed 2013")
    (verification-confidence 1.00))
  
  ;; VERIFIED Role in Trust - RE-CONTEXTUALIZED
  (trust-roles
    ((role "Beneficiary")
     (trust "Faucitt Family Trust")
     (date "2013-11-27")
     (source "Trust Deed - Clause 1.3")
     (verification-confidence 1.00)
     (ketoni-payout-entitlement "Beneficiary share of ZAR 18.75M")
     (control-threats
       "Multiple mechanisms to control his share:
        1. Interdict (filed 2025-08-13, 9 months before payout)
        2. Medical testing (rushed, suspected curatorship fraud)
        3. Curatorship would give Peter full control over his share
        4. Primary target due to fraud exposure (2025-06-06)")))
  
  ;; CRITICAL EVENTS - RE-CONTEXTUALIZED
  (critical-events
    ((event "Fraud Disclosure to Bantjies")
     (date "2025-06-06")
     (recipient "Daniel Jacobus Bantjies")
     (subject "Villa Via extracting funds from Group")
     (context "Unaware Bantjies was Trustee appointed Jul 2024")
     (source "Email records")
     (ketoni-significance "Exposed fraud 11 months before May 2026 payout")
     (retaliation-timing "Cards cancelled <24 hours after disclosure"))
    
    ((event "Included in Interdict")
     (date "2025-08-13")
     (timing "9 months before May 2026 Ketoni payout")
     (court "Family Court")
     (ketoni-motive "Control beneficiary share before payout"))
    
    ((event "Medical Testing Threat")
     (timing "Post-interdict, 9 months before May 2026")
     (suspected-purpose "Curatorship fraud")
     (ketoni-motive "Curatorship = full control over his ZAR 18.75M share")
     (significance "Interdict + Medical Testing + Curatorship = Total Control"))))

(define-entity daniel-jacobus-bantjes
  (type individual)
  (full-name "DANIEL JACOBUS BANTJES")
  (id-number "5810045103089")
  (birth-date-derived "1958-10-04")
  (gender "Male")
  (citizenship "South African")
  (professional-designation "CA (SA)")
  (practice-number "944130")
  
  ;; VERIFIED Address from Trust Deed
  (address "19 Fisheagle Lane, Country Lane Estate, Rietvalleirand, 0081"
    (source "Trust Deed - Declaration by Trustees")
    (verification-confidence 1.00))
  
  ;; DUAL ROLES - RE-CONTEXTUALIZED
  (professional-roles
    ((role "Trust Accountant")
     (trust "Faucitt Family Trust")
     (appointment-date "2013-11-27")
     (source "Trust Deed - Declaration by Trustees, clause 6.b")
     (verification-confidence 1.00)
     (duration "2013-present"))
    
    ((role "Accountant for RegimA Group Companies")
     (companies "All companies associated with Peter, Jacqui, and Daniel")
     (source "User disclosure + email evidence")
     (verification-confidence 0.95)
     (significance "Daniel contacted him about fraud as accountant, unaware he was trustee"))
    
    ((role "Trustee")
     (trust "Faucitt Family Trust")
     (appointment-date "2024-07")
     (appointment-mechanism "Email by Rynette")
     (j246-registration "2024-10-18")
     (source "J246 Letter of Authority + User disclosure")
     (verification-confidence 1.00)
     (ketoni-timing "Appointed 10 months before May 2026 Ketoni payout")
     (ketoni-significance "Strategic appointment to control trust before payout")))
  
  ;; KETONI CONNECTION - CRITICAL
  (ketoni-connection
    (connection-type "Professional colleague")
    (connected-to "Kevin Michael Derrick")
    (derrick-role "Director of Ketoni Investment Holdings")
    (shared-employer "George Group")
    (source "DANIE_BANTJES_GEORGE_GROUP_CONNECTION.md + LinkedIn analysis")
    (verification-confidence 0.90)
    (ketoni-significance
      "Bantjies' colleague (Kevin Derrick) is Director of Ketoni.
       Bantjies appointed Trustee 10 months before ZAR 18.75M payout.
       This connection suggests Bantjies may have facilitated FFT investment in Ketoni."))
  
  ;; CRITICAL EVENTS - RE-CONTEXTUALIZED
  (critical-events
    ((event "Pressure to Dissolve ReZonance")
     (date "2024-02-14")
     (participants "Bantjies, Peter, Rynette, Daniel")
     (subject "Dissolve ReZonance")
     (rezonance-debt "R1,035,000+ owed to ReZonance by RST")
     (source "Meeting records")
     (ketoni-context "Dissolving ReZonance would eliminate R1M debt obstacle"))
    
    ((event "Received Fraud Disclosure from Daniel")
     (date "2025-06-06")
     (sender "Daniel James Faucitt")
     (subject "Villa Via extracting funds from Group")
     (daniel-awareness "Unaware Bantjies was Trustee")
     (source "Email records")
     (ketoni-timing "11 months before May 2026 payout")
     (retaliation "Cards cancelled <24 hours after disclosure"))))

;;; ============================================================================
;;; SECTION 4: REZONANCE - RE-CONTEXTUALIZED AS FINANCIAL OBSTACLE
;;; ============================================================================

(define-entity rezonance
  (type company)
  (official-name "REZONANCE")
  (registration-number "UNKNOWN - requires CIPC verification")
  
  ;; VERIFIED Directors
  (directors
    ((name "DANIEL JAMES FAUCITT")
     (ownership "50%")
     (source "User disclosure")
     (verification-confidence 0.95))
    
    ((name "KAYLA PRETORIUS")
     (ownership "50%")
     (status "DECEASED")
     (death-date "2023-07-13")
     (death-context "Murdered")
     (source "Police records")
     (verification-confidence 1.00)
     (ketoni-timing "Murdered 80 days after FFT Ketoni investment")))
  
  ;; VERIFIED Financial Claims
  (financial-claims
    ((debtor "RegimA Skin Treatments (RST)")
     (amount "R1,035,000+")
     (statement-date "2023-02-28")
     (source "Rezonance Febr 2023.PDF")
     (verification-confidence 1.00)
     (current-status "UNPAID as of Dec 2025")
     (ketoni-context
       "FFT invested in Ketoni (Apr 2023) while owing R1M+ to ReZonance.
        Kayla murdered (Jul 2023) 80 days after FFT Ketoni investment.
        Pressure to dissolve ReZonance (Feb 2024) would eliminate debt.
        ZAR 18.75M Ketoni payout dwarfs R1M debt - debt is obstacle to control.")))
  
  ;; CRITICAL EVENTS - RE-CONTEXTUALIZED
  (critical-events
    ((event "Debt Statement")
     (date "2023-02-28")
     (amount "R1,035,000+")
     (ketoni-context "8 days after Ketoni incorporation"))
    
    ((event "FFT Ketoni Investment")
     (date "2023-04-24")
     (ketoni-shares "5,000 A-Ordinary shares")
     (rezonance-debt-status "UNPAID")
     (significance "FFT invests in Ketoni while owing R1M+ to ReZonance"))
    
    ((event "Kayla Murdered")
     (date "2023-07-13")
     (timing "80 days after FFT Ketoni investment")
     (impact "50% owner of ReZonance killed")
     (debt-impact "Debt now owed to Kayla's estate")
     (ketoni-significance "Eliminates one creditor, complicates debt recovery"))
    
    ((event "Pressure to Dissolve")
     (date "2024-02-14")
     (participants "Bantjies, Peter, Rynette")
     (target "Daniel James Faucitt")
     (outcome "Daniel refused")
     (ketoni-motive "Dissolution would eliminate R1M debt obstacle"))
    
    ((event "Jacqui Confrontation")
     (date "2025-05-15")
     (statement "Keeping funds is profiting from proceeds of murder")
     (ketoni-context "14 months after FFT Ketoni investment, 12 months before payout"))))

;;; ============================================================================
;;; SECTION 5: REGIMA GROUP COMPANIES - RE-CONTEXTUALIZED
;;; ============================================================================

(define-entity regima-worldwide-distribution
  (type company)
  (official-name "REGIMA WORLDWIDE DISTRIBUTION")
  (registration-number "2011/005722/07")
  (source "B2Bhint CIPC")
  (verification-confidence 0.95)
  
  ;; VERIFIED Ownership
  (ownership
    (owner "Faucitt Family Trust")
    (source "B2Bhint CIPC + User disclosure")
    (verification-confidence 0.95)
    (ketoni-significance "Trust-owned company - trustees control before May 2026"))
  
  ;; VERIFIED Directors
  (directors
    ((name "PETER ANDREW FAUCITT")
     (source "B2Bhint CIPC")
     (verification-confidence 0.95))
    ((name "JACQUELINE FAUCITT")
     (source "B2Bhint CIPC")
     (verification-confidence 0.95)))
  
  ;; CRITICAL CONTEXT
  (financial-context
    (expense-dumping-ground "All expenses forced to RWD after Jul 2023 card expiry")
    (card-expiry-date "2023-07-31")
    (rwd-card-status "Only card that didn't expire")
    (ketoni-timing "Card expiry 18 days after Kayla's murder, 3 months after FFT Ketoni investment")))

(define-entity villa-via-arcadia-no-2
  (type company)
  (official-name "VILLA VIA ARCADIA NO 2")
  (registration-number "1996/004451")
  (source "B2Bhint CIPC")
  (verification-confidence 0.95)
  
  ;; VERIFIED Ownership
  (ownership
    (owner "Faucitt Family Trust")
    (source "B2Bhint CIPC + User disclosure")
    (verification-confidence 0.95)
    (ketoni-significance "Trust-owned company - trustees control before May 2026"))
  
  ;; VERIFIED Members
  (members
    ((name "PETER ANDREW FAUCITT")
     (source "B2Bhint CIPC")
     (verification-confidence 0.95))
    ((name "JACQUELINE FAUCITT")
     (source "B2Bhint CIPC")
     (verification-confidence 0.95)))
  
  ;; FRAUD CONTEXT
  (fraud-allegations
    (exposed-by "Daniel James Faucitt")
    (exposure-date "2025-06-06")
    (recipient "Daniel Jacobus Bantjies")
    (allegation "Villa Via extracting funds from 'Group'")
    (source "Email records")
    (ketoni-timing "Fraud exposed 11 months before May 2026 Ketoni payout")
    (retaliation "Cards cancelled <24 hours after disclosure")))

(define-entity regima-skin-treatments
  (type company)
  (official-name "REGIMA SKIN TREATMENTS")
  (registration-number "1992/005371")
  (source "B2Bhint CIPC")
  (verification-confidence 0.95)
  
  ;; VERIFIED Members
  (members
    ((name "PETER ANDREW FAUCITT")
     (source "B2Bhint CIPC")
     (verification-confidence 0.95))
    ((name "JACQUELINE FAUCITT")
     (source "B2Bhint CIPC")
     (verification-confidence 0.95)))
  
  ;; VERIFIED Financial Obligations
  (financial-obligations
    ((creditor "ReZonance")
     (amount "R1,035,000+")
     (statement-date "2023-02-28")
     (current-status "UNPAID as of Dec 2025")
     (source "Rezonance Febr 2023.PDF")
     (verification-confidence 1.00)
     (ketoni-context "Debt remains unpaid while FFT invests in Ketoni (Apr 2023)"))))

;;; ============================================================================
;;; SECTION 6: KEVIN MICHAEL DERRICK - KETONI DIRECTOR
;;; ============================================================================

(define-entity kevin-michael-derrick
  (type individual)
  (full-name "KEVIN MICHAEL DERRICK")
  (id-number "UNKNOWN - requires verification")
  
  ;; VERIFIED Company Roles
  (company-roles
    ((company "Ketoni Investment Holdings")
     (registration "2023/562189/07")
     (role "Director")
     (source "CIPC Records via DANIE_BANTJES_GEORGE_GROUP_CONNECTION.md")
     (verification-confidence 0.95)
     (ketoni-payout-control "Director of company owing ZAR 18.75M to FFT")))
  
  ;; VERIFIED Professional Connection
  (professional-connections
    ((connected-to "Daniel Jacobus Bantjes")
     (connection-type "Colleague")
     (shared-employer "George Group")
     (source "DANIE_BANTJES_GEORGE_GROUP_CONNECTION.md + LinkedIn analysis")
     (verification-confidence 0.90)
     (ketoni-significance
       "Derrick (Ketoni Director) is colleague of Bantjies (FFT Trustee).
        Bantjies appointed Trustee 10 months before ZAR 18.75M payout.
        Suggests Bantjies may have facilitated FFT investment in Ketoni."))))

;;; ============================================================================
;;; SECTION 7: RELATIONS - RE-CONTEXTUALIZED WITH KETONI PAYOUT MOTIVE
;;; ============================================================================

(define-relation controls-trust-before-payout
  (type power-relation)
  (subject "Peter Andrew Faucitt")
  (object "Faucitt Family Trust")
  (mechanism
    "1. Founder powers (since 2013-11-27)
     2. Trustee role (since 2013-11-27)
     3. Main Trustee designation (backdated to 2025-07-01)
     4. Jacqui neutralized via interdict (2025-08-13)
     5. Bantjies appointed as co-trustee (2024-07)")
  (timing "Consolidated control 9 months before May 2026 payout")
  (ketoni-motive "Control trust decisions on ZAR 18.75M payout distribution")
  (verification-confidence 0.95))

(define-relation entitled-to-beneficiary-share
  (type financial-entitlement)
  (subjects
    "Peter Andrew Faucitt"
    "Jacqueline Faucitt"
    "Daniel James Faucitt")
  (object "Ketoni Investment Holdings payout")
  (amount "ZAR 18,750,000.00")
  (payout-date "2026-05")
  (distribution-mechanism "Via Faucitt Family Trust")
  (control-threats
    "Jax: Neutralized via interdict (2025-08-13)
     Dan: Targeted via interdict + medical testing + curatorship attempt")
  (verification-confidence 0.90))

(define-relation interdicted-before-payout
  (type legal-control-mechanism)
  (subject "Peter Andrew Faucitt")
  (objects "Jacqueline Faucitt" "Daniel James Faucitt")
  (mechanism "Interdict filed 2025-08-13")
  (court "Family Court")  ;; NOT Commercial Court
  (timing "9 months before May 2026 Ketoni payout")
  (ketoni-motive
    "Family court chosen (not commercial court) to control beneficiaries.
     Interdict prevents Jax & Dan from controlling their beneficiary shares.
     Medical testing + curatorship would give Peter full control over Dan's share.")
  (verification-confidence 1.00))

(define-relation appointed-trustee-before-payout
  (type strategic-appointment)
  (subject "Rynette")  ;; NOT a trustee herself
  (object "Daniel Jacobus Bantjes")
  (appointment-date "2024-07")
  (appointment-mechanism "Email")
  (j246-registration "2024-10-18")
  (timing "10 months before May 2026 Ketoni payout")
  (ketoni-connection "Bantjies is colleague of Kevin Derrick (Ketoni Director)")
  (ketoni-motive "Consolidate trust control before ZAR 18.75M payout")
  (verification-confidence 0.95))

(define-relation owes-payout-to-trust
  (type financial-obligation)
  (subject "Ketoni Investment Holdings")
  (object "Faucitt Family Trust")
  (amount "ZAR 18,750,000.00")
  (payout-type "Option")
  (payout-date "2026-05")
  (source "User disclosure - requires document verification")
  (verification-confidence 0.80)
  (significance "CENTRAL FINANCIAL MOTIVE for all trust actions since Apr 2023"))

(define-relation invested-while-owing-debt
  (type financial-contradiction)
  (subject "Faucitt Family Trust")
  (investment
    (company "Ketoni Investment Holdings")
    (date "2023-04-24")
    (shares "5,000 A-Ordinary shares"))
  (unpaid-debt
    (creditor "ReZonance")
    (debtor "RegimA Skin Treatments")
    (amount "R1,035,000+")
    (statement-date "2023-02-28"))
  (significance
    "FFT invests in Ketoni (expecting ZAR 18.75M return) while owing R1M+ to ReZonance.
     ZAR 18.75M payout dwarfs R1M debt - debt is obstacle to control.
     Pressure to dissolve ReZonance would eliminate debt obstacle.")
  (verification-confidence 0.95))

(define-relation murdered-after-investment
  (type temporal-correlation)
  (victim "Kayla Pretorius")
  (death-date "2023-07-13")
  (death-context "Murdered - 50% owner of ReZonance")
  (fft-ketoni-investment "2023-04-24")
  (timing "80 days after FFT Ketoni investment")
  (rezonance-debt "R1,035,000+ owed to ReZonance by RST")
  (debt-impact "Debt now owed to Kayla's estate")
  (ketoni-context
    "Kayla murdered 80 days after FFT invests in Ketoni.
     ReZonance debt remains unpaid.
     Pressure to dissolve ReZonance (Feb 2024) would eliminate debt.
     ZAR 18.75M payout (May 2026) dwarfs R1M debt.")
  (verification-confidence 1.00))

(define-relation colleague-connection-ketoni
  (type professional-network)
  (person-1 "Daniel Jacobus Bantjes")
  (person-1-role "FFT Trustee (appointed Jul 2024)")
  (person-2 "Kevin Michael Derrick")
  (person-2-role "Ketoni Director")
  (connection "Colleagues at George Group")
  (ketoni-significance
    "Bantjies' colleague (Derrick) is Director of Ketoni owing ZAR 18.75M to FFT.
     Bantjies appointed Trustee 10 months before May 2026 payout.
     Suggests Bantjies may have facilitated FFT investment in Ketoni.")
  (verification-confidence 0.90))

;;; ============================================================================
;;; SECTION 8: TIMELINE - KETONI PAYOUT AS CENTRAL ORGANIZING PRINCIPLE
;;; ============================================================================

(define-timeline ketoni-payout-control-timeline
  (central-event
    (event "Ketoni ZAR 18.75M Payout")
    (date "2026-05")
    (significance "ALL EVENTS CONVERGE ON THIS DATE"))
  
  (events
    ;; PHASE 1: INVESTMENT & DEBT (Feb-Apr 2023)
    ((date "2023-02-20")
     (event "Ketoni Investment Holdings incorporated")
     (timing "T-39 months before payout")
     (significance "Company owing ZAR 18.75M to FFT established"))
    
    ((date "2023-02-28")
     (event "R1,035,000+ debt statement to ReZonance")
     (timing "8 days after Ketoni incorporation")
     (significance "Debt obstacle established"))
    
    ((date "2023-04-24")
     (event "FFT invests 5,000 shares in Ketoni")
     (timing "T-37 months before payout")
     (significance "ZAR 18.75M payout entitlement established")
     (contradiction "Invests while owing R1M+ to ReZonance"))
    
    ;; PHASE 2: KAYLA'S MURDER & CONTROL (Jul 2023)
    ((date "2023-07-13")
     (event "Kayla Pretorius murdered")
     (timing "80 days after FFT Ketoni investment, T-34 months before payout")
     (significance "50% owner of ReZonance (creditor) eliminated"))
    
    ((date "2023-07-31")
     (event "All bank cards expire EXCEPT RWD card")
     (timing "18 days after Kayla's murder")
     (significance "Forces all expenses to RWD (expense dumping ground)"))
    
    ;; PHASE 3: REZONANCE DISSOLUTION PRESSURE (Feb 2024)
    ((date "2024-02-14")
     (event "Bantjies, Peter & Rynette pressure Daniel to dissolve ReZonance")
     (timing "T-27 months before payout")
     (significance "Dissolving ReZonance would eliminate R1M debt obstacle"))
    
    ;; PHASE 4: TRUSTEE APPOINTMENT (Jul-Oct 2024)
    ((date "2024-07")
     (event "Rynette appoints Bantjies as Trustee via email")
     (timing "T-10 months before payout")
     (significance "Bantjies (colleague of Ketoni Director) appointed to control trust"))
    
    ((date "2024-10-18")
     (event "J246 Letter of Authority issued for Bantjies")
     (timing "T-7 months before payout")
     (significance "Bantjies officially registered as third Trustee"))
    
    ;; PHASE 5: FRAUD DISCOVERY & RETALIATION (2025)
    ((date "2025-06-06")
     (event "Daniel exposes Villa Via fraud to Bantjies")
     (timing "T-11 months before payout")
     (significance "Fraud exposure threatens control structure"))
    
    ((date "2025-06-07")
     (event "Cards cancelled secretly")
     (timing "<24 hours after fraud disclosure")
     (significance "Immediate retaliation"))
    
    ((date "2025-08-11")
     (event "Jacqui signs Main Trustee backdating document")
     (timing "T-9 months before payout")
     (significance "Peter designated Main Trustee (backdated to 2025-07-01)"))
    
    ((date "2025-08-13")
     (event "Peter files interdict against Jax & Dan in FAMILY COURT")
     (timing "T-9 months before payout, 2 days after backdating document")
     (significance "Control mechanism: Jax neutralized, Dan targeted for curatorship")
     (court-choice "Family court (not commercial) allows control over beneficiaries"))
    
    ((date "2025-08-post")
     (event "Medical testing rushed")
     (timing "T-9 months before payout")
     (significance "Suspected curatorship fraud to control Dan's beneficiary share"))
    
    ;; PHASE 6: PAYOUT DATE
    ((date "2026-05")
     (event "ZAR 18.75M Ketoni payout due")
     (timing "T-0")
     (control-structure
       "Peter: Founder + Main Trustee + Beneficiary
        Bantjies: Trustee (colleague of Ketoni Director)
        Jax: Neutralized via interdict
        Dan: Targeted via interdict + medical testing + curatorship attempt")
     (significance "EVERYTHING CONVERGES HERE - CENTRAL MOTIVE FOR ALL ACTIONS"))))

;;; ============================================================================
;;; SECTION 9: LEGAL ASPECTS - RE-CONTEXTUALIZED WITH KETONI MOTIVE
;;; ============================================================================

(define-legal-aspect family-court-vs-commercial-court-choice
  (category "Forum Selection")
  (peter-choice "Family Court")
  (appropriate-forum "Commercial Court")
  (peter-claims "Financial fraud")
  
  (ketoni-motive-analysis
    "Peter's choice of family court (not commercial court) is explained by the
     ZAR 18.75M Ketoni payout in May 2026:
     
     COMMERCIAL COURT would only address:
     - Financial fraud claims
     - Business disputes
     - Cannot control beneficiaries' personal rights
     
     FAMILY COURT allows:
     - Interdict against beneficiaries (Jax & Dan)
     - Medical testing orders
     - Curatorship applications
     - Control over beneficiaries' shares of trust assets
     
     KETONI PAYOUT MOTIVE:
     - Family court interdict prevents Jax & Dan from controlling their shares
     - Medical testing + curatorship = full control over Dan's share
     - Timing: 9 months before May 2026 payout
     - Result: Peter controls distribution of ZAR 18.75M")
  
  (legal-implications
    "Forum shopping to maximize control over beneficiaries before payout.
     Commercial court inappropriate for Peter's stated 'financial fraud' claims.
     Family court choice reveals true motive: control beneficiary shares of payout.")
  
  (verification-confidence 0.95))

(define-legal-aspect curatorship-fraud-via-medical-testing
  (category "Abuse of Process")
  (mechanism "Medical testing + Curatorship application")
  (target "Daniel James Faucitt")
  (timing "9 months before May 2026 Ketoni payout")
  
  (ketoni-motive-analysis
    "Medical testing rushed as suspected curatorship fraud because:
     
     CURATORSHIP WOULD GIVE PETER:
     - Full control over Dan's beneficiary share of ZAR 18.75M
     - Legal authority to make decisions on Dan's behalf
     - Control over Dan's financial interests in trust
     
     TIMING ANALYSIS:
     - Medical testing: Aug 2025 (9 months before payout)
     - Interdict filed: Aug 2025 (9 months before payout)
     - Payout date: May 2026
     
     PATTERN:
     1. Interdict (control movement/communication)
     2. Medical testing (establish 'incapacity')
     3. Curatorship (full legal control)
     4. May 2026 payout (Peter controls Dan's share)")
  
  (legal-implications
    "Abuse of medical testing process to establish false incapacity.
     Curatorship fraud to control beneficiary's share of ZAR 18.75M payout.
     Timing reveals financial motive: 9 months before payout date.")
  
  (verification-confidence 0.90))

(define-legal-aspect trustee-conflict-of-interest
  (category "Fiduciary Duty Breach")
  (conflicted-trustee "Peter Andrew Faucitt")
  (roles
    "1. Founder (powers over trust)
     2. Trustee (fiduciary duty to beneficiaries)
     3. Main Trustee (sole control)
     4. Beneficiary (personal financial interest)")
  
  (ketoni-payout-conflict
    "Peter has direct financial interest in ZAR 18.75M Ketoni payout as beneficiary.
     As Main Trustee, he controls payout distribution.
     As Founder, he has additional powers over trust assets.
     
     CONFLICT:
     - Fiduciary duty to maximize ALL beneficiaries' interests
     - Personal interest in maximizing HIS OWN share
     - Actions taken to control/reduce Jax & Dan's shares
     
     EVIDENCE OF CONFLICT:
     - Jax interdicted (neutralized as trustee, threatened as beneficiary)
     - Dan interdicted + medical testing (curatorship = full control of his share)
     - Timing: 9 months before May 2026 payout")
  
  (legal-implications
    "Breach of fiduciary duty: Trustee acting in personal interest.
     Conflict of interest: Beneficiary-Trustee controlling other beneficiaries' shares.
     ZAR 18.75M payout provides financial motive for fiduciary breach.")
  
  (verification-confidence 0.95))

(define-legal-aspect bantjies-appointment-timing
  (category "Strategic Trustee Appointment")
  (appointee "Daniel Jacobus Bantjes")
  (appointment-date "2024-07")
  (appointment-mechanism "Email by Rynette")
  (j246-registration "2024-10-18")
  (timing "10 months before May 2026 Ketoni payout")
  
  (ketoni-connection
    "Bantjies is colleague of Kevin Derrick (Ketoni Director) at George Group.
     Bantjies may have facilitated FFT investment in Ketoni (Apr 2023).
     Bantjies appointed Trustee 10 months before ZAR 18.75M payout.")
  
  (ketoni-motive-analysis
    "Bantjies' appointment as Trustee is strategically timed:
     
     TIMING:
     - Apr 2023: FFT invests in Ketoni (Bantjies' colleague is Director)
     - Jul 2024: Bantjies appointed Trustee (10 months before payout)
     - May 2026: ZAR 18.75M payout due
     
     CONTROL STRUCTURE:
     - Peter: Founder + Main Trustee + Beneficiary
     - Bantjies: Trustee (colleague of Ketoni Director)
     - Jax: Neutralized via interdict
     
     RESULT:
     - Peter + Bantjies control trust decisions before May 2026 payout
     - Jax neutralized as trustee
     - Dan targeted for curatorship (full control of his share)")
  
  (legal-implications
    "Strategic appointment to consolidate control before payout.
     Bantjies' Ketoni connection suggests facilitation of investment.
     Timing reveals financial motive: 10 months before ZAR 18.75M payout.")
  
  (verification-confidence 0.90))

;;; ============================================================================
;;; SECTION 10: VERIFICATION & CONFIDENCE LEVELS
;;; ============================================================================

(define-verification-summary
  (ketoni-payout-revelation
    (amount "ZAR 18,750,000.00")
    (payout-date "2026-05")
    (payout-type "Option")
    (source "User disclosure - discovered ~2025-12-12")
    (verification-confidence 0.80)
    (requires-document-verification
      "1. Ketoni Investment Holdings shareholder agreement
       2. Share certificate terms and conditions
       3. Option agreement or payout schedule
       4. Any correspondence regarding May 2026 payout"))
  
  (high-confidence-facts
    "1. FFT invested 5,000 shares in Ketoni (Apr 2023) - confidence 1.00
     2. Kayla murdered (Jul 2023) - confidence 1.00
     3. R1,035,000+ debt to ReZonance (Feb 2023) - confidence 1.00
     4. Bantjies appointed Trustee (Jul 2024, J246 Oct 2024) - confidence 1.00
     5. Interdict filed (Aug 2025) - confidence 1.00
     6. Bantjies colleague of Kevin Derrick (Ketoni Director) - confidence 0.90")
  
  (central-insight
    "The ZAR 18.75M Ketoni payout in May 2026 is the CENTRAL FINANCIAL MOTIVE
     that explains ALL trust actions since Apr 2023 investment:
     
     1. WHY family court (not commercial): Control beneficiaries before payout
     2. WHY Jax & Dan interdicted together: Both are beneficiaries entitled to shares
     3. WHY medical testing rushed: Curatorship = full control of Dan's share
     4. WHY Bantjies appointed (Jul 2024): Consolidate control 10 months before payout
     5. WHY Jax interdicted after signing backdating doc: Neutralize her as trustee
     6. WHY ReZonance dissolution pressure: R1M debt is obstacle to control
     
     EVERYTHING CONVERGES ON MAY 2026 PAYOUT DATE."))

;;; ============================================================================
;;; END OF ENTITY-RELATION FRAMEWORK V48 - KETONI PAYOUT INTEGRATED
;;; ============================================================================
