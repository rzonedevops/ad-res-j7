;; ENTITY-RELATION FRAMEWORK V46 - KETONI CORRECTED
;; Date: 2025-12-26
;; Case: 2025-137857
;; Purpose: Corrected attribution of May 2026 payment from "Bantjies debt" to "Ketoni Investment Holdings payout"
;; Critical Correction: Everything comes back to the Trust

;; ============================================================================
;; CRITICAL CORRECTION SUMMARY
;; ============================================================================

;; PREVIOUS (INCORRECT): May 2026 R28.7M payment was "debt from Bantjies to Pete & Jax"
;; CORRECTED: May 2026 R28.7M payment is "investment payout from Ketoni Investment Holdings to Faucitt Family Trust"
;;
;; Evidence: Share Certificate #3 (April 24, 2023) - FFT holds 5,000 A-Ordinary shares in KIH
;; Control: Bantjies (Trustee) controls distribution to beneficiaries Peter (50%) and Jax (50%)
;; Network: Bantjies (George Group CFO) + Kevin Derrick (KIH Director + George Group)
;; Motive: Peter needs control over Jax's R14.35M (50%) share before May 2026 payout

;; ============================================================================
;; PART 1: CORRECTED ENTITY DEFINITIONS
;; ============================================================================

;; ----------------------------------------------------------------------------
;; 1.1 Ketoni Investment Holdings (NEW ENTITY)
;; ----------------------------------------------------------------------------

(define-record-type <ketoni-investment-holdings-v46>
  (make-ketoni-investment-holdings-v46
    entity-id
    entity-type
    name
    abbreviation
    company-number
    jurisdiction
    incorporation-date
    legal-status
    vat-number
    registered-address
    known-directors
    shareholders
    expected-payout
    verification-status
    evidence-chain
    notes)
  ketoni-investment-holdings-v46?
  (entity-id kih-v46-entity-id)
  (entity-type kih-v46-entity-type)
  (name kih-v46-name)
  (abbreviation kih-v46-abbreviation)
  (company-number kih-v46-company-number)
  (jurisdiction kih-v46-jurisdiction)
  (incorporation-date kih-v46-incorporation-date)
  (legal-status kih-v46-legal-status)
  (vat-number kih-v46-vat-number)
  (registered-address kih-v46-registered-address)
  (known-directors kih-v46-known-directors)
  (shareholders kih-v46-shareholders)
  (expected-payout kih-v46-expected-payout)
  (verification-status kih-v46-verification-status)
  (evidence-chain kih-v46-evidence-chain)
  (notes kih-v46-notes))

;; Sample: Ketoni Investment Holdings
(define ketoni-investment-holdings
  (make-ketoni-investment-holdings-v46
    "KIH-2023-562189-07"
    "juristic_person"
    "Ketoni Investment Holdings (Pty) Ltd"
    "KIH"
    "2023/562189/07"
    "South Africa"
    "2023-02-20"
    "active"
    "9132219271"
    "20 Tennyson Ave, Senderwood, Germiston, Gauteng, 2145"
    '(("Kevin Michael Derrick" . "Director"))
    '(("Faucitt Family Trust" . ("5000 A-Ordinary shares" "Certificate #3" "2023-04-24")))
    '(("total_amount" . "R28.7M")
      ("payout_date" . "2026-05")
      ("beneficiary_split" . (("Peter_Faucitt" . "R14.35M (50%)") ("Jacqueline_Faucitt" . "R14.35M (50%)")))
      ("distribution_controlled_by" . "Daniel Jacobus Bantjes (Trustee)"))
    "verified"
    '("2023-04-24_Trust_Share_Cert.jpg" "CIPC_SEARCH_2025-12-17" "B2BHINT_2025-12-17")
    "Investment vehicle for FFT - May 2026 payout is THE ULTIMATE GOAL"))

;; ----------------------------------------------------------------------------
;; 1.2 Faucitt Family Trust (UPDATED WITH KETONI)
;; ----------------------------------------------------------------------------

(define-record-type <faucitt-family-trust-v46>
  (make-faucitt-family-trust-v46
    entity-id
    entity-type
    name
    abbreviation
    trust-number
    urn
    founder
    beneficiaries
    trustees
    owned-entities
    investments
    may-2026-payout
    verification-status
    evidence-chain
    notes)
  faucitt-family-trust-v46?
  (entity-id fft-v46-entity-id)
  (entity-type fft-v46-entity-type)
  (name fft-v46-name)
  (abbreviation fft-v46-abbreviation)
  (trust-number fft-v46-trust-number)
  (urn fft-v46-urn)
  (founder fft-v46-founder)
  (beneficiaries fft-v46-beneficiaries)
  (trustees fft-v46-trustees)
  (owned-entities fft-v46-owned-entities)
  (investments fft-v46-investments)
  (may-2026-payout fft-v46-may-2026-payout)
  (verification-status fft-v46-verification-status)
  (evidence-chain fft-v46-evidence-chain)
  (notes fft-v46-notes))

;; Sample: Faucitt Family Trust (Updated with Ketoni)
(define faucitt-family-trust-v46
  (make-faucitt-family-trust-v46
    "FFT-003651-2013"
    "trust"
    "Faucitt Family Trust"
    "FFT"
    "003651/2013"
    "9922013TRU003651"
    "Peter Andrew Faucitt"
    '(("Peter Andrew Faucitt" . "50%") ("Jacqueline Faucitt" . "50%"))
    '("Peter Andrew Faucitt" "Jacqueline Faucitt" "Daniel Jacobus Bantjes (appointed July 2024)")
    '("RegimA Worldwide (RWD)" "Villa Via")
    '(("Ketoni Investment Holdings (KIH)" . ("5000 A-Ordinary shares" "Certificate #3" "2023-04-24")))
    '(("source" . "Ketoni Investment Holdings (KIH)")
      ("total_amount" . "R28.7M")
      ("payout_date" . "2026-05")
      ("peter_share" . "R14.35M (50%)")
      ("jax_share" . "R14.35M (50%)")
      ("distribution_controlled_by" . "Daniel Jacobus Bantjes (Trustee)")
      ("peter_motive" . "Control Jax's R14.35M share before May 2026 payout"))
    "verified"
    '("Trust_Deed_2013" "J246_Letter_of_Authority_2024-10-18" "2023-04-24_Trust_Share_Cert.jpg")
    "EVERYTHING COMES BACK TO THE TRUST - May 2026 payout is ultimate goal"))

;; ----------------------------------------------------------------------------
;; 1.3 Daniel Jacobus Bantjes (UPDATED WITH KETONI CONFLICT)
;; ----------------------------------------------------------------------------

(define-record-type <daniel-jacobus-bantjes-v46>
  (make-daniel-jacobus-bantjes-v46
    entity-id
    entity-type
    name
    known-as
    id-number
    positions
    professional-network
    conflict-of-interest
    may-2026-control
    fiduciary-breaches
    verification-status
    evidence-chain
    notes)
  daniel-jacobus-bantjes-v46?
  (entity-id djb-v46-entity-id)
  (entity-type djb-v46-entity-type)
  (name djb-v46-name)
  (known-as djb-v46-known-as)
  (id-number djb-v46-id-number)
  (positions djb-v46-positions)
  (professional-network djb-v46-professional-network)
  (conflict-of-interest djb-v46-conflict-of-interest)
  (may-2026-control djb-v46-may-2026-control)
  (fiduciary-breaches djb-v46-fiduciary-breaches)
  (verification-status djb-v46-verification-status)
  (evidence-chain djb-v46-evidence-chain)
  (notes djb-v46-notes))

;; Sample: Daniel Jacobus Bantjes (Updated with Ketoni conflict)
(define daniel-jacobus-bantjes-v46
  (make-daniel-jacobus-bantjes-v46
    "DJB-5810045103089"
    "natural_person"
    "Daniel Jacobus Bantjes"
    '("Danie Bantjes" "Bantjies")
    "5810045103089"
    '(("Accountant" . "Faucitt Family Companies")
      ("Trustee" . "Faucitt Family Trust (appointed July 2024 by Rynette, hidden from Daniel)")
      ("Group CFO" . "The George Group (joined May 2023)"))
    '(("colleague" . "Kevin Michael Derrick (KIH Director)")
      ("employer" . "The George Group")
      ("timeline" . "Joined George Group ONE MONTH after KIH share cert issued to FFT (Apr 24 → May 2023)"))
    '(("role_1" . "Trustee of FFT (controls May 2026 KIH payout distribution)")
      ("role_2" . "Colleague of Kevin Derrick (KIH Director) at The George Group")
      ("conflict" . "Professional loyalty to network vs. fiduciary duty to beneficiaries")
      ("non_disclosure" . "Failed to disclose professional relationship with KIH Director to beneficiaries")
      ("severity" . "CRITICAL - Controls R28.7M payout distribution with undisclosed network ties"))
    '(("payout_amount" . "R28.7M from KIH to FFT")
      ("payout_date" . "May 2026")
      ("control_mechanism" . "As Trustee, Bantjies controls distribution to beneficiaries")
      ("peter_share" . "R14.35M (50%)")
      ("jax_share" . "R14.35M (50%)")
      ("peter_motive" . "Needs control over Jax's R14.35M share")
      ("bantjies_role" . "Controls distribution - can facilitate Peter's control over Jax's share"))
    '(("false_affidavit" . "Gave false affidavit against beneficiary Jax (August 2025, 9 months before May 2026)")
      ("non_disclosure_kih" . "Failed to disclose KIH investment and May 2026 payout to beneficiaries")
      ("non_disclosure_network" . "Failed to disclose professional relationship with KIH Director")
      ("betrayal" . "Acted against beneficiary Jax's interests to support Peter's control")
      ("timing" . "Appointed Trustee July 2024, gave false affidavit August 2025, payout May 2026"))
    "verified"
    '("J246_Letter_of_Authority_2024-10-18" "LinkedIn_Profile" "2023-04-24_Trust_Share_Cert.jpg")
    "CRITICAL CONFLICT: Controls May 2026 payout distribution with undisclosed ties to KIH Director"))

;; ----------------------------------------------------------------------------
;; 1.4 Kevin Michael Derrick (NEW ENTITY)
;; ----------------------------------------------------------------------------

(define-record-type <kevin-michael-derrick-v46>
  (make-kevin-michael-derrick-v46
    entity-id
    entity-type
    name
    positions
    professional-network
    related-companies
    kih-role
    verification-status
    evidence-chain
    notes)
  kevin-michael-derrick-v46?
  (entity-id kmd-v46-entity-id)
  (entity-type kmd-v46-entity-type)
  (name kmd-v46-name)
  (positions kmd-v46-positions)
  (professional-network kmd-v46-professional-network)
  (related-companies kmd-v46-related-companies)
  (kih-role kmd-v46-kih-role)
  (verification-status kmd-v46-verification-status)
  (evidence-chain kmd-v46-evidence-chain)
  (notes kmd-v46-notes))

;; Sample: Kevin Michael Derrick
(define kevin-michael-derrick-v46
  (make-kevin-michael-derrick-v46
    "KMD-UNKNOWN"
    "natural_person"
    "Kevin Michael Derrick"
    '(("Director" . "Ketoni Investment Holdings (Pty) Ltd")
      ("Director" . "The George Group")
      ("Director" . "Multiple George Group entities"))
    '(("colleague" . "Daniel Jacobus Bantjes (George Group CFO)")
      ("employer" . "The George Group")
      ("timeline" . "Bantjies joined George Group ONE MONTH after KIH share cert issued (Apr 24 → May 2023)"))
    '("THE GEORGE GROUP" "GEORGE ASSET MANAGEMENT SOLUTIONS" "GEORGE CLEANING ENTERPRISES" 
      "GEORGE LANDSCAPING SERVICES" "GEORGE GROUP MANAGEMENT SERVICES" "GEORGE OFFSITE MONITORING ENTERPRISES"
      "QUATRO PROPERTY CARE" "QUATRO INTEGRATED SERVICES" "QUATRO CLEANING SERVICES" "QUATRO PARKING MANAGEMENT"
      "QUATRO SECURITY SERVICES" "QUATRO HORTICULTURAL SERVICES" "C T R INVESTMENT PROTECTION"
      "SCARLET IBIS INVESTMENTS 265" "CLIPPER MARINE SERVICES" "CREATIVE RIDES MARKETING"
      "CREATIVE RIDES COLLECTIBLE CAR AUCTIONS" "CREATIVE RIDES ANTIQUES" "CLASSIC CAR VALUATIONS")
    '(("company" . "Ketoni Investment Holdings (Pty) Ltd")
      ("role" . "Director")
      ("shareholder" . "Faucitt Family Trust (5000 A-Ordinary shares, Certificate #3)")
      ("payout" . "R28.7M expected May 2026")
      ("network_connection" . "Colleague of Bantjies (FFT Trustee) at The George Group"))
    "verified"
    '("2023-04-24_Trust_Share_Cert.jpg" "B2BHINT_2025-12-17")
    "KIH Director - Network connection to Bantjies (FFT Trustee) via The George Group"))

;; ============================================================================
;; PART 2: CORRECTED RELATIONS
;; ============================================================================

;; ----------------------------------------------------------------------------
;; 2.1 Trust-KIH Investment Relation (NEW)
;; ----------------------------------------------------------------------------

(define-record-type <trust-kih-investment-relation-v46>
  (make-trust-kih-investment-relation-v46
    relation-id
    relation-type
    from-entity
    to-entity
    shares
    share-class
    certificate-number
    certificate-date
    expected-payout
    distribution-control
    strategic-significance
    strength
    evidence-chain
    notes)
  trust-kih-investment-relation-v46?
  (relation-id tkir-v46-relation-id)
  (relation-type tkir-v46-relation-type)
  (from-entity tkir-v46-from-entity)
  (to-entity tkir-v46-to-entity)
  (shares tkir-v46-shares)
  (share-class tkir-v46-share-class)
  (certificate-number tkir-v46-certificate-number)
  (certificate-date tkir-v46-certificate-date)
  (expected-payout tkir-v46-expected-payout)
  (distribution-control tkir-v46-distribution-control)
  (strategic-significance tkir-v46-strategic-significance)
  (strength tkir-v46-strength)
  (evidence-chain tkir-v46-evidence-chain)
  (notes tkir-v46-notes))

;; Sample: FFT-KIH Investment Relation
(define fft-kih-investment-relation
  (make-trust-kih-investment-relation-v46
    "REL-FFT-KIH-INVESTMENT"
    "shareholder"
    "Faucitt Family Trust"
    "Ketoni Investment Holdings (Pty) Ltd"
    5000
    "A Ordinary"
    3
    "2023-04-24"
    '(("total_amount" . "R28.7M")
      ("payout_date" . "May 2026")
      ("peter_share" . "R14.35M (50%)")
      ("jax_share" . "R14.35M (50%)"))
    '(("controlled_by" . "Daniel Jacobus Bantjes (Trustee)")
      ("conflict" . "Bantjies is colleague of KIH Director (Kevin Derrick) at The George Group")
      ("peter_motive" . "Control Jax's R14.35M share before May 2026 payout"))
    "THIS IS THE ULTIMATE GOAL - May 2026 payout is why interdict was filed August 2025 (9 months before)"
    0.99
    '("2023-04-24_Trust_Share_Cert.jpg" "CIPC_SEARCH_2025-12-17" "B2BHINT_2025-12-17")
    "CORRECTED ATTRIBUTION: May 2026 R28.7M is KIH payout to FFT, NOT debt from Bantjies"))

;; ----------------------------------------------------------------------------
;; 2.2 Bantjies-Derrick Professional Network Relation (NEW)
;; ----------------------------------------------------------------------------

(define-record-type <bantjies-derrick-network-relation-v46>
  (make-bantjies-derrick-network-relation-v46
    relation-id
    relation-type
    entity-1
    entity-1-role
    entity-2
    entity-2-role
    common-entity
    start-date
    timeline-significance
    conflict-of-interest
    strength
    evidence-chain
    notes)
  bantjies-derrick-network-relation-v46?
  (relation-id bdnr-v46-relation-id)
  (relation-type bdnr-v46-relation-type)
  (entity-1 bdnr-v46-entity-1)
  (entity-1-role bdnr-v46-entity-1-role)
  (entity-2 bdnr-v46-entity-2)
  (entity-2-role bdnr-v46-entity-2-role)
  (common-entity bdnr-v46-common-entity)
  (start-date bdnr-v46-start-date)
  (timeline-significance bdnr-v46-timeline-significance)
  (conflict-of-interest bdnr-v46-conflict-of-interest)
  (strength bdnr-v46-strength)
  (evidence-chain bdnr-v46-evidence-chain)
  (notes bdnr-v46-notes))

;; Sample: Bantjies-Derrick Professional Network
(define bantjies-derrick-network
  (make-bantjies-derrick-network-relation-v46
    "REL-BANTJIES-DERRICK-NETWORK"
    "professional_colleagues"
    "Daniel Jacobus Bantjes"
    "Group CFO"
    "Kevin Michael Derrick"
    "Director"
    "The George Group"
    "2023-05"
    "Bantjies joined George Group ONE MONTH after KIH share cert issued to FFT (Apr 24, 2023 → May 2023)"
    '(("bantjies_role_1" . "Trustee of FFT (controls May 2026 KIH payout distribution)")
      ("derrick_role" . "Director of KIH (company making R28.7M payout to FFT)")
      ("professional_relationship" . "Colleagues at The George Group")
      ("conflict" . "Professional loyalty to network vs. fiduciary duty to beneficiaries Peter and Jax")
      ("non_disclosure" . "Bantjies failed to disclose this relationship to beneficiaries")
      ("severity" . "CRITICAL - Undisclosed network connection while controlling R28.7M distribution"))
    0.97
    '("LinkedIn_Profile_Bantjies" "B2BHINT_Kevin_Derrick" "2023-04-24_Trust_Share_Cert.jpg")
    "CRITICAL NETWORK: Bantjies controls May 2026 payout distribution, Derrick is KIH Director, both at George Group"))

;; ============================================================================
;; PART 3: CORRECTED EVENTS
;; ============================================================================

;; ----------------------------------------------------------------------------
;; 3.1 May 2026 Payout Event (CORRECTED)
;; ----------------------------------------------------------------------------

(define-record-type <may-2026-payout-event-v46>
  (make-may-2026-payout-event-v46
    event-id
    event-type
    event-date
    actors
    event-description
    payout-details
    control-mechanism
    strategic-significance
    timeline
    evidence-chain
    notes)
  may-2026-payout-event-v46?
  (event-id m26pe-v46-event-id)
  (event-type m26pe-v46-event-type)
  (event-date m26pe-v46-event-date)
  (actors m26pe-v46-actors)
  (event-description m26pe-v46-event-description)
  (payout-details m26pe-v46-payout-details)
  (control-mechanism m26pe-v46-control-mechanism)
  (strategic-significance m26pe-v46-strategic-significance)
  (timeline m26pe-v46-timeline)
  (evidence-chain m26pe-v46-evidence-chain)
  (notes m26pe-v46-notes))

;; Sample: May 2026 Payout Event (Corrected)
(define may-2026-payout-event-corrected
  (make-may-2026-payout-event-v46
    "EVENT-MAY-2026-KIH-PAYOUT"
    "trust_investment_payout"
    "2026-05"
    '("Ketoni Investment Holdings (KIH)" "Faucitt Family Trust (FFT)" "Daniel Jacobus Bantjes (Trustee)"
      "Peter Andrew Faucitt (Beneficiary 50%)" "Jacqueline Faucitt (Beneficiary 50%)")
    "Ketoni Investment Holdings (KIH) makes R28.7M payout to Faucitt Family Trust (FFT) based on 5,000 A-Ordinary shares (Certificate #3, April 24, 2023). Distribution to beneficiaries controlled by Trustee Bantjies."
    '(("source" . "Ketoni Investment Holdings (KIH)")
      ("recipient" . "Faucitt Family Trust (FFT)")
      ("total_amount" . "R28.7M")
      ("peter_share" . "R14.35M (50%)")
      ("jax_share" . "R14.35M (50%)")
      ("basis" . "5,000 A-Ordinary shares (Certificate #3, April 24, 2023)"))
    '(("distribution_controlled_by" . "Daniel Jacobus Bantjes (Trustee)")
      ("bantjies_conflict" . "Colleague of KIH Director (Kevin Derrick) at The George Group")
      ("peter_motive" . "Control Jax's R14.35M share before payout")
      ("control_mechanisms" . ("Interdict (August 2025)" "Medical testing" "Curatorship fraud")))
    "THE ULTIMATE GOAL - Everything (interdict, medical testing, curatorship) is designed to control Jax's R14.35M share before May 2026 payout"
    '(("2023-02-20" . "KIH incorporated")
      ("2023-04-24" . "FFT receives 5,000 KIH shares (Certificate #3) - Investment basis established")
      ("2023-05" . "Bantjies joins The George Group (ONE MONTH after share cert) - Network connection")
      ("2024-07" . "Bantjies appointed FFT Trustee by Rynette (hidden from Daniel) - Control mechanism activated")
      ("2025-06-06" . "Daniel reports fraud to Bantjies - Threat to control structure")
      ("2025-06-07" . "Immediate retaliation (card cancellation) - Control structure defense")
      ("2025-08" . "Interdict filed - 9 months before May 2026 payout - Control consolidation begins")
      ("2026-05" . "Expected KIH payout to FFT (R28.7M) - THE ULTIMATE GOAL"))
    '("2023-04-24_Trust_Share_Cert.jpg" "CIPC_SEARCH_2025-12-17" "B2BHINT_2025-12-17" "J246_Letter_of_Authority_2024-10-18")
    "CORRECTED: May 2026 R28.7M is KIH investment payout to FFT, NOT debt from Bantjies to Pete/Jax"))

;; ============================================================================
;; PART 4: CORRECTED LEGAL ASPECTS
;; ============================================================================

;; ----------------------------------------------------------------------------
;; 4.1 Bantjies Conflict of Interest (CORRECTED)
;; ----------------------------------------------------------------------------

(define-record-type <bantjies-conflict-corrected-v46>
  (make-bantjies-conflict-corrected-v46
    legal-aspect-id
    legal-principle
    statutory-basis
    case-law
    application-to-case
    conflict-details
    fiduciary-breaches
    relevance
    evidence-chain
    notes)
  bantjies-conflict-corrected-v46?
  (legal-aspect-id bcc-v46-legal-aspect-id)
  (legal-principle bcc-v46-legal-principle)
  (statutory-basis bcc-v46-statutory-basis)
  (case-law bcc-v46-case-law)
  (application-to-case bcc-v46-application-to-case)
  (conflict-details bcc-v46-conflict-details)
  (fiduciary-breaches bcc-v46-fiduciary-breaches)
  (relevance bcc-v46-relevance)
  (evidence-chain bcc-v46-evidence-chain)
  (notes bcc-v46-notes))

;; Sample: Bantjies Conflict of Interest (Corrected)
(define bantjies-conflict-corrected
  (make-bantjies-conflict-corrected-v46
    "LEGAL-BANTJIES-CONFLICT-CORRECTED"
    "Trustee Conflict of Interest - Professional Network with Investment Company Director"
    "Trust Property Control Act, 1988 (Act 57 of 1988) - Section 9 (Fiduciary duties of trustees)"
    '("Doyle v Board of Executors 1999 (2) SA 805 (C): Trustees must avoid conflicts of interest"
      "Potgieter v Potgieter 2012 (1) SA 637 (SCA): Fiduciary duty requires full disclosure")
    "Bantjies as FFT Trustee controls distribution of R28.7M May 2026 payout from KIH to beneficiaries. Bantjies has undisclosed professional relationship with KIH Director (Kevin Derrick) at The George Group. This creates conflict between professional network loyalty and fiduciary duty to beneficiaries."
    '(("role_1" . "Trustee of FFT - Controls May 2026 R28.7M payout distribution to beneficiaries")
      ("role_2" . "Colleague of Kevin Derrick (KIH Director) at The George Group")
      ("conflict" . "Professional loyalty to network vs. fiduciary duty to beneficiaries Peter and Jax")
      ("non_disclosure" . "Failed to disclose professional relationship with KIH Director to beneficiaries")
      ("timeline" . "Joined George Group ONE MONTH after KIH share cert issued (Apr 24 → May 2023)")
      ("appointment" . "Appointed FFT Trustee July 2024 (13 months after joining George Group)")
      ("false_affidavit" . "Gave false affidavit against beneficiary Jax August 2025 (9 months before May 2026 payout)")
      ("severity" . "CRITICAL - Controls R28.7M distribution with undisclosed network ties"))
    '(("false_affidavit" . "Gave false affidavit against beneficiary Jax (August 2025)")
      ("non_disclosure_investment" . "Failed to disclose KIH investment and May 2026 payout to beneficiaries")
      ("non_disclosure_network" . "Failed to disclose professional relationship with KIH Director")
      ("betrayal" . "Acted against beneficiary Jax's interests to support Peter's control")
      ("duty_of_loyalty" . "Violated duty of loyalty to beneficiary Jax")
      ("duty_of_impartiality" . "Violated duty of impartiality between beneficiaries Peter and Jax")
      ("duty_of_disclosure" . "Violated duty to disclose material conflicts of interest"))
    0.98
    '("J246_Letter_of_Authority_2024-10-18" "2023-04-24_Trust_Share_Cert.jpg" "LinkedIn_Profile_Bantjies" "B2BHINT_Kevin_Derrick")
    "CORRECTED CONFLICT: Bantjies controls May 2026 KIH payout distribution with undisclosed ties to KIH Director"))

;; ============================================================================
;; PART 5: OPERATIONS
;; ============================================================================

;; ----------------------------------------------------------------------------
;; 5.1 Get May 2026 Payout Details
;; ----------------------------------------------------------------------------

(define (get-may-2026-payout-details-v46)
  "Returns corrected May 2026 payout details from KIH to FFT"
  '(("source" . "Ketoni Investment Holdings (KIH)")
    ("recipient" . "Faucitt Family Trust (FFT)")
    ("basis" . "5,000 A-Ordinary shares (Certificate #3, April 24, 2023)")
    ("total_amount" . "R28.7M")
    ("peter_share" . "R14.35M (50%)")
    ("jax_share" . "R14.35M (50%)")
    ("payout_date" . "May 2026")
    ("distribution_controlled_by" . "Daniel Jacobus Bantjes (Trustee)")
    ("bantjies_conflict" . "Colleague of KIH Director (Kevin Derrick) at The George Group")
    ("peter_motive" . "Control Jax's R14.35M share before May 2026 payout")
    ("control_mechanisms" . ("Interdict (August 2025, 9 months before payout)" "Medical testing" "Curatorship fraud"))
    ("strategic_significance" . "THE ULTIMATE GOAL - Everything comes back to the Trust")
    ("correction_note" . "PREVIOUS INCORRECT: 'Debt from Bantjies to Pete/Jax' - CORRECTED: 'KIH investment payout to FFT'")))

;; ----------------------------------------------------------------------------
;; 5.2 Get Bantjies Conflict Details (Corrected)
;; ----------------------------------------------------------------------------

(define (get-bantjies-conflict-details-corrected-v46)
  "Returns corrected Bantjies conflict of interest details"
  '(("role_1" . "Trustee of FFT (controls May 2026 R28.7M KIH payout distribution)")
    ("role_2" . "Colleague of Kevin Derrick (KIH Director) at The George Group")
    ("conflict_type" . "Professional network loyalty vs. fiduciary duty to beneficiaries")
    ("non_disclosure" . "Failed to disclose professional relationship with KIH Director to beneficiaries")
    ("timeline" . "Joined George Group May 2023 (ONE MONTH after KIH share cert issued Apr 24, 2023)")
    ("trustee_appointment" . "July 2024 (13 months after joining George Group, 10 months before May 2026 payout)")
    ("false_affidavit" . "August 2025 (9 months before May 2026 payout)")
    ("fiduciary_breaches" . ("Duty of loyalty" "Duty of impartiality" "Duty of disclosure" "Duty to act in beneficiaries' best interests"))
    ("severity" . "CRITICAL - Controls R28.7M distribution with undisclosed network ties to payout company director")
    ("correction_note" . "PREVIOUS INCORRECT: 'Bantjies owes R28.7M debt' - CORRECTED: 'Bantjies controls R28.7M KIH payout distribution'")))

;; ----------------------------------------------------------------------------
;; 5.3 Get Trust Central Control Analysis
;; ----------------------------------------------------------------------------

(define (get-trust-central-control-analysis-v46)
  "Returns analysis showing how everything comes back to the Trust"
  '(("central_mechanism" . "Faucitt Family Trust (FFT)")
    ("trust_assets" . ("RegimA Worldwide (RWD) - 100% ownership" "Villa Via - 100% ownership"))
    ("trust_investments" . ("Ketoni Investment Holdings (KIH) - 5,000 A-Ordinary shares (Certificate #3, Apr 24, 2023)"))
    ("may_2026_payout" . ("Source: KIH" "Recipient: FFT" "Amount: R28.7M" "Peter share: R14.35M (50%)" "Jax share: R14.35M (50%)"))
    ("control_structure" . (("Level 1: Investment" . "FFT invested in KIH (5,000 shares, Apr 2023)")
                            ("Level 2: Corporate Network" . "Kevin Derrick (KIH Director) + Bantjies (George Group CFO)")
                            ("Level 3: Trust Control" . "Bantjies (Trustee) controls May 2026 payout distribution")
                            ("Level 4: Beneficiary Control" . "Peter needs control over Jax's R14.35M share")))
    ("timeline" . (("Apr 24, 2023" . "FFT receives 5,000 KIH shares - Investment basis")
                   ("May 2023" . "Bantjies joins George Group - Network connection (ONE MONTH after share cert)")
                   ("July 2024" . "Bantjies appointed FFT Trustee - Control mechanism activated")
                   ("August 2025" . "Interdict filed - Control consolidation (9 months before May 2026)")
                   ("May 2026" . "Expected KIH payout - THE ULTIMATE GOAL")))
    ("strategic_significance" . "EVERYTHING COMES BACK TO THE TRUST - All control mechanisms (interdict, medical testing, curatorship) designed to control Jax's R14.35M share before May 2026 payout")
    ("correction_note" . "This analysis corrects previous misattribution of May 2026 payment as 'Bantjies debt' to correct 'KIH investment payout to FFT'")))

;; ============================================================================
;; END OF ENTITY-RELATION FRAMEWORK V46 - KETONI CORRECTED
;; ============================================================================
