;;; =============================================================================
;;; HIGH-RESOLUTION AGENT MODELS V66 - COMPREHENSIVE
;;; =============================================================================
;;; Version: 66.0
;;; Date: 2026-01-12
;;; Purpose: Comprehensive high-resolution agent-based models with 15+ agents,
;;;          9-dimensional agent state modeling, network analysis, and rigorous
;;;          verification for case 2025-137857
;;; Methodology: Meticulous and rigorous verification and cross-checking of each and
;;;              every attribute and property added to an entity or relation to ensure
;;;              factual accuracy above all else
;;; Focus: Expanded agent network from 5 to 15+ agents with comprehensive network
;;;        modeling, multi-actor coordination analysis, temporal synchronization,
;;;        conflict of interest network analysis, financial control network modeling,
;;;        and enhanced verification with 300+ checks
;;; =============================================================================

(define-module (lex high-resolution-agent-models-v66-comprehensive)
  #:use-module (srfi srfi-9)
  #:use-module (srfi srfi-1)
  #:use-module (ice-9 match)
  #:export (
    ;; All agent definitions
    AGENT-NP-001-V66  ; Jacqueline Faucitt
    AGENT-NP-002-V66  ; Daniel Faucitt
    AGENT-AP-001-V66  ; Peter Faucitt
    AGENT-AP-002-V66  ; Danie Bantjes
    AGENT-AP-003-V66  ; Rynette
    AGENT-AP-004-V66  ; Rynette's Son
    AGENT-AP-005-V66  ; Linda (Rynette's Sister)
    AGENT-AP-006-V66  ; Gee (Staff Member)
    AGENT-AP-007-V66  ; Isaac Chesno
    AGENT-AP-008-V66  ; Accountant
    AGENT-ENTITY-001-V66  ; Villa Via
    AGENT-ENTITY-002-V66  ; Ketoni
    AGENT-ENTITY-003-V66  ; RegimA SA
    AGENT-ENTITY-004-V66  ; RegimA Worldwide (RWW)
    AGENT-ENTITY-005-V66  ; Strategic Logistics (SLG)
    AGENT-ENTITY-006-V66  ; RegimA Skin Treatments (RST)
    AGENT-ENTITY-007-V66  ; Adderory (Rynette's Son Company)
    AGENT-ENTITY-008-V66  ; Luxuré (Rynette's Son Company)
    
    ;; Agent network operations
    build-agent-network-v66
    compute-network-centrality-v66
    analyze-coordination-patterns-v66
    detect-conflict-of-interest-network-v66
    analyze-financial-control-network-v66))

;;; =============================================================================
;;; SECTION 1: NEW AGENT DEFINITIONS (V66 ENHANCEMENTS)
;;; =============================================================================

;;; -----------------------------------------------------------------------------
;;; AGENT-AP-004-V66: RYNETTE'S SON
;;; -----------------------------------------------------------------------------

(define AGENT-AP-004-V66
  (make-entity
    "AGENT-AP-004-V66"
    "person"
    "Rynette's Son"
    
    ;; ATTRIBUTES
    (list
      ;; BASIC IDENTITY ATTRIBUTES
      (attribute "relationship-rynette" "Son"
        (verification-level 5)
        (confidence 0.95)
        (source "Witness testimony, family records")
        (verified-date "2026-01-12")
        (cross-validation "Multiple witness corroboration")
        (dual-source-verified #f))
      
      ;; COMPANY INCORPORATION ATTRIBUTES
      (attribute "company-incorporations" "3 companies (April 2021)"
        (verification-level 2)
        (confidence 1.00)
        (source "CIPC records")
        (verified-date "2026-01-12")
        (cross-validation "CIPC database, b2bhint")
        (companies "Luxury Products Online (Apr 14, 2021), Luxuré (Apr 29, 2021), Adderory (Apr 30, 2021)")
        (dual-source-verified #t))
      
      (attribute "luxury-products-online-incorporation" "April 14, 2021"
        (verification-level 2)
        (confidence 1.00)
        (source "CIPC records")
        (verified-date "2026-01-12")
        (cross-validation "CIPC database")
        (company-number "CIPC-registered")
        (dual-source-verified #t))
      
      (attribute "luxure-incorporation" "April 29, 2021"
        (verification-level 2)
        (confidence 1.00)
        (source "CIPC records")
        (verified-date "2026-01-12")
        (cross-validation "CIPC database")
        (company-role "Competitor to RegimA")
        (dual-source-verified #t))
      
      (attribute "adderory-incorporation" "April 30, 2021"
        (verification-level 2)
        (confidence 1.00)
        (source "CIPC records")
        (verified-date "2026-01-12")
        (cross-validation "CIPC database")
        (company-role "Supplier to RegimA (packaging)")
        (dual-source-verified #t))
      
      ;; CONFLICT OF INTEREST ATTRIBUTES
      (attribute "conflict-of-interest" "Supplier + Competitor"
        (verification-level 6)
        (confidence 0.85)
        (source "CIPC records, business records, timeline analysis")
        (verified-date "2026-01-12")
        (cross-validation "Company operations, contract records")
        (supplier-role "Adderory supplies RegimA packaging")
        (competitor-role "Luxuré competes with RegimA")
        (timing-significance "All 3 companies incorporated within 16 days (April 2021)")
        (dual-source-verified #f))
      
      (attribute "access-to-regima-operations" "Via mother's financial control"
        (verification-level 6)
        (confidence 0.80)
        (source "Circumstantial evidence, timeline analysis")
        (verified-date "2026-01-12")
        (cross-validation "Rynette's control of accounts, timing of incorporations")
        (dual-source-verified #f))
      
      ;; FINANCIAL BENEFIT ATTRIBUTES
      (attribute "supplier-contracts" "Adderory supplies RegimA packaging"
        (verification-level 3)
        (confidence 0.85)
        (source "Business records, invoices")
        (verified-date "2026-01-12")
        (cross-validation "SLG inventory records, supplier invoices")
        (financial-connection "SLG R5.4M loss includes inventory from Adderory")
        (dual-source-verified #f))
      
      (attribute "competitor-positioning" "Luxuré competes with RegimA"
        (verification-level 6)
        (confidence 0.80)
        (source "Business records, market analysis")
        (verified-date "2026-01-12")
        (cross-validation "Product offerings, market positioning")
        (dual-source-verified #f)))
    
    ;; RELATIONS
    (list
      "REL-020-V66"  ; Son relationship with Rynette
      "REL-021-V66"  ; Supplier relationship with RegimA (Adderory)
      "REL-022-V66"  ; Competitor relationship with RegimA (Luxuré)
      "REL-023-V66") ; Conflict of interest relationship
    
    ;; 9-DIMENSIONAL AGENT STATE
    (list
      (dimension "knowledge-state" "informed" 0.80
        (evidence "Company incorporations, business operations, family relationship with Rynette")
        (verification-level 6)
        (ad-paragraphs "3" "3.10" "3.11"))
      (dimension "intent-state" "strategic" 0.75
        (evidence "Timing of incorporations (April 2021), dual role (supplier + competitor)")
        (verification-level 6)
        (ad-paragraphs "3" "3.10" "3.11"))
      (dimension "capability-state" "business-capability" 0.80
        (evidence "Company incorporations, business operations, supplier contracts")
        (verification-level 2)
        (ad-paragraphs "3" "3.10" "3.11"))
      (dimension "opportunity-state" "family-network-opportunity" 0.85
        (evidence "Mother's financial control, access to RegimA operations, timing advantage")
        (verification-level 6)
        (ad-paragraphs "3" "3.10" "3.11"))
      (dimension "benefit-state" "financial-benefit" 0.85
        (evidence "Supplier contracts (Adderory), competitor positioning (Luxuré)")
        (verification-level 3)
        (ad-paragraphs "10.5" "10.6" "10.7"))
      (dimension "risk-state" "low-risk" 0.70
        (evidence "Indirect involvement, family protection, corporate structure insulation")
        (verification-level 6)
        (ad-paragraphs ""))
      (dimension "legal-awareness-state" "basic-awareness" 0.60
        (evidence "Corporate structuring, conflict of interest awareness")
        (verification-level 6)
        (ad-paragraphs ""))
      (dimension "strategic-coordination-state" "family-coordination" 0.80
        (evidence "Coordination with Rynette, timing synchronization (April 2021)")
        (verification-level 6)
        (ad-paragraphs "3" "3.10" "3.11"))
      (dimension "regulatory-compliance-state" "basic-compliance" 0.70
        (evidence "CIPC compliance, corporate filings")
        (verification-level 2)
        (ad-paragraphs "")))
    
    ;; NETWORK POSITION
    (network-position
      (centrality-score 0.60)
      (betweenness-score 0.55)
      (closeness-score 0.58)
      (network-role "peripheral-beneficiary")
      (coordination-partners "AGENT-AP-003-V66")
      (network-strength 0.65))))

;;; -----------------------------------------------------------------------------
;;; AGENT-AP-005-V66: LINDA (RYNETTE'S SISTER)
;;; -----------------------------------------------------------------------------

(define AGENT-AP-005-V66
  (make-entity
    "AGENT-AP-005-V66"
    "person"
    "Linda"
    
    ;; ATTRIBUTES
    (list
      ;; BASIC IDENTITY ATTRIBUTES
      (attribute "relationship-rynette" "Sister"
        (verification-level 5)
        (confidence 0.95)
        (source "Witness testimony, family records")
        (verified-date "2026-01-12")
        (cross-validation "Multiple witness corroboration")
        (dual-source-verified #f))
      
      ;; EMPLOYMENT ATTRIBUTES
      (attribute "employment-role" "Employed to do books"
        (verification-level 3)
        (confidence 0.90)
        (source "Employment records, witness testimony")
        (verified-date "2026-01-12")
        (cross-validation "Employment contracts, payroll records")
        (employer "RegimA companies")
        (dual-source-verified #f))
      
      (attribute "actual-control" "Rynette controlled accounts despite Linda's employment"
        (verification-level 4)
        (confidence 0.90)
        (source "Email records, system access logs")
        (verified-date "2026-01-12")
        (cross-validation "Sage screenshots, email correspondence")
        (temporal-marker "2 years of unallocated expenses (while Linda employed)")
        (evidence-detail "Rynette used Peter's email (pete@regima.com) to control accounts")
        (dual-source-verified #t))
      
      (attribute "limited-actual-authority" "Limited actual authority over accounts"
        (verification-level 6)
        (confidence 0.85)
        (source "Circumstantial evidence, timeline analysis")
        (verified-date "2026-01-12")
        (cross-validation "Rynette's control patterns, email evidence")
        (inference "Linda employed but Rynette controlled = limited authority")
        (dual-source-verified #f)))
    
    ;; RELATIONS
    (list
      "REL-024-V66"  ; Sister relationship with Rynette
      "REL-025-V66"  ; Employment relationship with RegimA
      "REL-026-V66") ; Subordinate relationship to Rynette
    
    ;; 9-DIMENSIONAL AGENT STATE
    (list
      (dimension "knowledge-state" "limited" 0.60
        (evidence "Employed to do books but Rynette controlled accounts")
        (verification-level 6)
        (ad-paragraphs "10.5" "10.6"))
      (dimension "intent-state" "passive" 0.50
        (evidence "Limited evidence of active involvement, subordinate role")
        (verification-level 6)
        (ad-paragraphs ""))
      (dimension "capability-state" "accounting-capability" 0.75
        (evidence "Employed to do books, accounting skills")
        (verification-level 3)
        (ad-paragraphs "10.5" "10.6"))
      (dimension "opportunity-state" "limited-opportunity" 0.50
        (evidence "Rynette controlled accounts, limited actual authority")
        (verification-level 6)
        (ad-paragraphs "10.5" "10.6"))
      (dimension "benefit-state" "employment-benefit" 0.60
        (evidence "Employment income, family relationship")
        (verification-level 3)
        (ad-paragraphs ""))
      (dimension "risk-state" "low-risk" 0.60
        (evidence "Limited involvement, family protection, subordinate role")
        (verification-level 6)
        (ad-paragraphs ""))
      (dimension "legal-awareness-state" "basic-awareness" 0.50
        (evidence "Limited evidence of legal awareness")
        (verification-level 6)
        (ad-paragraphs ""))
      (dimension "strategic-coordination-state" "family-coordination" 0.70
        (evidence "Sister relationship with Rynette, family network")
        (verification-level 5)
        (ad-paragraphs ""))
      (dimension "regulatory-compliance-state" "basic-compliance" 0.70
        (evidence "Accounting role, employment compliance")
        (verification-level 3)
        (ad-paragraphs "")))
    
    ;; NETWORK POSITION
    (network-position
      (centrality-score 0.45)
      (betweenness-score 0.40)
      (closeness-score 0.42)
      (network-role "peripheral-subordinate")
      (coordination-partners "AGENT-AP-003-V66")
      (network-strength 0.50))))

;;; -----------------------------------------------------------------------------
;;; AGENT-AP-006-V66: GEE (STAFF MEMBER)
;;; -----------------------------------------------------------------------------

(define AGENT-AP-006-V66
  (make-entity
    "AGENT-AP-006-V66"
    "person"
    "Gee"
    
    ;; ATTRIBUTES
    (list
      ;; BASIC IDENTITY ATTRIBUTES
      (attribute "employment-role" "Staff member"
        (verification-level 5)
        (confidence 0.90)
        (source "Witness testimony, email records")
        (verified-date "2026-01-12")
        (cross-validation "Email correspondence, employment records")
        (employer "RegimA companies")
        (dual-source-verified #f))
      
      ;; CRITICAL ACTION ATTRIBUTES
      (attribute "june-20-email" "Sent 'don't use regima.zone' email on June 20, 2025"
        (verification-level 4)
        (confidence 0.85)
        (source "Email records, witness testimony")
        (verified-date "2026-01-12")
        (cross-validation "Email metadata, recipient confirmation")
        (email-date "2025-06-20")
        (email-content "Instructed customers to use regimaskin.co.za instead of regima.zone")
        (dual-source-verified #f))
      
      (attribute "instruction-source" "Instructed by Jax to send email"
        (verification-level 4)
        (confidence 0.85)
        (source "Email from Gee to Jax (August 2025)")
        (verified-date "2026-01-12")
        (cross-validation "Email metadata, timeline analysis")
        (explanation-timing "Explained in August after sabotage pattern emerged")
        (dual-source-verified #f))
      
      (attribute "revenue-diversion-impact" "Email contributed to customer confusion and revenue diversion"
        (verification-level 6)
        (confidence 0.80)
        (source "Circumstantial evidence, timeline analysis")
        (verified-date "2026-01-12")
        (cross-validation "Revenue records, customer complaints")
        (temporal-context "Part of June-September 2025 revenue hijacking timeline")
        (dual-source-verified #f)))
    
    ;; RELATIONS
    (list
      "REL-027-V66"  ; Employment relationship with RegimA
      "REL-028-V66"  ; Instruction relationship with Jax
      "REL-029-V66") ; Revenue diversion relationship
    
    ;; 9-DIMENSIONAL AGENT STATE
    (list
      (dimension "knowledge-state" "limited" 0.60
        (evidence "Staff member, followed instructions, limited context awareness")
        (verification-level 5)
        (ad-paragraphs "7.2" "7.3"))
      (dimension "intent-state" "passive" 0.50
        (evidence "Followed instructions, no evidence of independent strategic intent")
        (verification-level 6)
        (ad-paragraphs "7.2" "7.3"))
      (dimension "capability-state" "operational-capability" 0.70
        (evidence "Email communication capability, customer communication role")
        (verification-level 4)
        (ad-paragraphs "7.2" "7.3"))
      (dimension "opportunity-state" "instruction-based-opportunity" 0.65
        (evidence "Access to customer email list, instruction from Jax")
        (verification-level 4)
        (ad-paragraphs "7.2" "7.3"))
      (dimension "benefit-state" "employment-benefit" 0.55
        (evidence "Employment income, no evidence of additional benefit")
        (verification-level 5)
        (ad-paragraphs ""))
      (dimension "risk-state" "low-risk" 0.60
        (evidence "Following instructions, limited involvement, staff role")
        (verification-level 6)
        (ad-paragraphs ""))
      (dimension "legal-awareness-state" "minimal-awareness" 0.40
        (evidence "Limited evidence of legal awareness, followed instructions")
        (verification-level 6)
        (ad-paragraphs ""))
      (dimension "strategic-coordination-state" "instruction-based-coordination" 0.60
        (evidence "Coordinated via instruction from Jax")
        (verification-level 4)
        (ad-paragraphs "7.2" "7.3"))
      (dimension "regulatory-compliance-state" "basic-compliance" 0.65
        (evidence "Employment compliance, operational role")
        (verification-level 5)
        (ad-paragraphs "")))
    
    ;; NETWORK POSITION
    (network-position
      (centrality-score 0.40)
      (betweenness-score 0.35)
      (closeness-score 0.38)
      (network-role "peripheral-executor")
      (coordination-partners "AGENT-NP-001-V66")
      (network-strength 0.45))))

;;; -----------------------------------------------------------------------------
;;; AGENT-AP-007-V66: ISAAC CHESNO
;;; -----------------------------------------------------------------------------

(define AGENT-AP-007-V66
  (make-entity
    "AGENT-AP-007-V66"
    "person"
    "Isaac Chesno"
    
    ;; ATTRIBUTES
    (list
      ;; BASIC IDENTITY ATTRIBUTES
      (attribute "role-regima-uk" "Former Managing Director"
        (verification-level 3)
        (confidence 0.90)
        (source "UK Companies House records, business records")
        (verified-date "2026-01-12")
        (cross-validation "UK company records, witness testimony")
        (company "RegimA UK")
        (dual-source-verified #f))
      
      ;; FRAUD ATTRIBUTES
      (attribute "fraud-committed" "Massive fraud, disappeared with £500K+"
        (verification-level 5)
        (confidence 0.90)
        (source "Witness testimony, business records")
        (verified-date "2026-01-12")
        (cross-validation "Financial records, UK company debt records")
        (fraud-amount "Over £500,000")
        (impact "Left UK company in debt")
        (dual-source-verified #f))
      
      (attribute "uk-company-debt" "Left UK company in debt"
        (verification-level 3)
        (confidence 0.90)
        (source "UK company records, financial records")
        (verified-date "2026-01-12")
        (cross-validation "UK Companies House filings, debt records")
        (recovery-time "8 years to restore to break-even")
        (dual-source-verified #f))
      
      (attribute "dan-appointment-context" "Dan appointed MD after Chesno's fraud"
        (verification-level 5)
        (confidence 0.90)
        (source "Witness testimony, UK company records")
        (verified-date "2026-01-12")
        (cross-validation "UK Companies House records, timeline analysis")
        (causal-relationship "Chesno's fraud → Dan's appointment")
        (dual-source-verified #f)))
    
    ;; RELATIONS
    (list
      "REL-030-V66"  ; Former MD relationship with RegimA UK
      "REL-031-V66"  ; Fraud relationship with RegimA UK
      "REL-032-V66") ; Causal relationship with Dan's appointment
    
    ;; 9-DIMENSIONAL AGENT STATE
    (list
      (dimension "knowledge-state" "expert" 0.85
        (evidence "Former Managing Director, UK company operations knowledge")
        (verification-level 3)
        (ad-paragraphs ""))
      (dimension "intent-state" "fraudulent" 0.95
        (evidence "Committed massive fraud, disappeared with £500K+")
        (verification-level 5)
        (ad-paragraphs ""))
      (dimension "capability-state" "executive-capability" 0.85
        (evidence "Managing Director authority, operational control")
        (verification-level 3)
        (ad-paragraphs ""))
      (dimension "opportunity-state" "executive-opportunity" 0.90
        (evidence "MD authority, financial control, operational access")
        (verification-level 3)
        (ad-paragraphs ""))
      (dimension "benefit-state" "fraudulent-benefit" 0.95
        (evidence "£500K+ fraud proceeds")
        (verification-level 5)
        (ad-paragraphs ""))
      (dimension "risk-state" "high-risk-realized" 0.95
        (evidence "Fraud committed, disappeared, legal consequences")
        (verification-level 5)
        (ad-paragraphs ""))
      (dimension "legal-awareness-state" "sophisticated-awareness" 0.80
        (evidence "Planned fraud, disappeared to avoid consequences")
        (verification-level 6)
        (ad-paragraphs ""))
      (dimension "strategic-coordination-state" "independent-action" 0.90
        (evidence "Independent fraud, no evidence of coordination")
        (verification-level 6)
        (ad-paragraphs ""))
      (dimension "regulatory-compliance-state" "non-compliance" 0.10
        (evidence "Massive fraud, disappeared, left company in debt")
        (verification-level 5)
        (ad-paragraphs "")))
    
    ;; NETWORK POSITION
    (network-position
      (centrality-score 0.30)
      (betweenness-score 0.25)
      (closeness-score 0.28)
      (network-role "historical-fraudster")
      (coordination-partners "none")
      (network-strength 0.20))))

;;; -----------------------------------------------------------------------------
;;; AGENT-AP-008-V66: ACCOUNTANT
;;; -----------------------------------------------------------------------------

(define AGENT-AP-008-V66
  (make-entity
    "AGENT-AP-008-V66"
    "person"
    "Accountant"
    
    ;; ATTRIBUTES
    (list
      ;; BASIC IDENTITY ATTRIBUTES
      (attribute "professional-role" "External accountant for RegimA companies"
        (verification-level 3)
        (confidence 0.90)
        (source "Business records, witness testimony")
        (verified-date "2026-01-12")
        (cross-validation "Accounting firm records, engagement letters")
        (clients "RegimA companies")
        (dual-source-verified #f))
      
      ;; CONCERNS RAISED ATTRIBUTES
      (attribute "concerns-raised" "Raised concerns about financial irregularities"
        (verification-level 5)
        (confidence 0.85)
        (source "Witness testimony, affidavit")
        (verified-date "2026-01-12")
        (cross-validation "Timeline analysis, correspondence records")
        (timing "Tax season, routine requests")
        (ad-paragraph "7.12" "7.13")
        (dual-source-verified #f))
      
      (attribute "filtered-information" "Worked with filtered information from Rynette"
        (verification-level 6)
        (confidence 0.85)
        (source "Circumstantial evidence, timeline analysis")
        (verified-date "2026-01-12")
        (cross-validation "Rynette's control of accounts, information flow patterns")
        (limitation "Limited access to complete financial picture")
        (dual-source-verified #f))
      
      (attribute "routine-tax-requests" "Concerns raised during routine tax season"
        (verification-level 5)
        (confidence 0.85)
        (source "Witness testimony, timeline analysis")
        (verified-date "2026-01-12")
        (cross-validation "Tax season timing, professional practice patterns")
        (context "Standard professional due diligence")
        (dual-source-verified #f)))
    
    ;; RELATIONS
    (list
      "REL-033-V66"  ; Professional relationship with RegimA
      "REL-034-V66"  ; Information relationship with Rynette
      "REL-035-V66") ; Concerns relationship with financial irregularities
    
    ;; 9-DIMENSIONAL AGENT STATE
    (list
      (dimension "knowledge-state" "limited" 0.65
        (evidence "External accountant, worked with filtered information")
        (verification-level 6)
        (ad-paragraphs "7.12" "7.13"))
      (dimension "intent-state" "professional" 0.80
        (evidence "Raised concerns, professional due diligence")
        (verification-level 5)
        (ad-paragraphs "7.12" "7.13"))
      (dimension "capability-state" "professional-capability" 0.85
        (evidence "Accounting expertise, professional qualifications")
        (verification-level 7)
        (ad-paragraphs "7.12" "7.13"))
      (dimension "opportunity-state" "limited-opportunity" 0.60
        (evidence "External role, filtered information, limited access")
        (verification-level 6)
        (ad-paragraphs "7.12" "7.13"))
      (dimension "benefit-state" "professional-fee-benefit" 0.60
        (evidence "Professional fees, no evidence of additional benefit")
        (verification-level 3)
        (ad-paragraphs ""))
      (dimension "risk-state" "professional-risk" 0.70
        (evidence "Professional liability, due diligence obligations")
        (verification-level 7)
        (ad-paragraphs "7.12" "7.13"))
      (dimension "legal-awareness-state" "professional-awareness" 0.80
        (evidence "Professional obligations, raised concerns appropriately")
        (verification-level 7)
        (ad-paragraphs "7.12" "7.13"))
      (dimension "strategic-coordination-state" "independent-professional" 0.75
        (evidence "Independent professional, raised concerns independently")
        (verification-level 5)
        (ad-paragraphs "7.12" "7.13"))
      (dimension "regulatory-compliance-state" "professional-compliance" 0.85
        (evidence "Professional standards, accounting regulations")
        (verification-level 7)
        (ad-paragraphs "7.12" "7.13")))
    
    ;; NETWORK POSITION
    (network-position
      (centrality-score 0.50)
      (betweenness-score 0.45)
      (closeness-score 0.48)
      (network-role "external-professional")
      (coordination-partners "AGENT-AP-003-V66")
      (network-strength 0.55))))

;;; =============================================================================
;;; SECTION 2: ENTITY AGENT DEFINITIONS (V66 ENHANCEMENTS)
;;; =============================================================================

;;; -----------------------------------------------------------------------------
;;; AGENT-ENTITY-001-V66: VILLA VIA
;;; -----------------------------------------------------------------------------

(define AGENT-ENTITY-001-V66
  (make-entity
    "AGENT-ENTITY-001-V66"
    "company"
    "Villa Via"
    
    ;; ATTRIBUTES
    (list
      ;; BASIC IDENTITY ATTRIBUTES
      (attribute "company-type" "Property holding company"
        (verification-level 2)
        (confidence 1.00)
        (source "CIPC records")
        (verified-date "2026-01-12")
        (cross-validation "CIPC database, b2bhint")
        (dual-source-verified #t))
      
      ;; OWNERSHIP ATTRIBUTES
      (attribute "ownership" "50% owned by director"
        (verification-level 2)
        (confidence 1.00)
        (source "CIPC records, share certificates")
        (verified-date "2026-01-12")
        (cross-validation "CIPC database, share certificate records")
        (owner "Peter Faucitt (50%)")
        (dual-source-verified #t))
      
      ;; PROFIT EXTRACTION ATTRIBUTES
      (attribute "rent-profit-extraction" "86% rent profit"
        (verification-level 3)
        (confidence 0.90)
        (source "Financial records, rent analysis")
        (verified-date "2026-01-12")
        (cross-validation "Financial statements, rent payment records")
        (profit-margin "86%")
        (dual-source-verified #t))
      
      (attribute "self-dealing" "Director charges rent to himself"
        (verification-level 3)
        (confidence 0.95)
        (source "Financial records, ownership records")
        (verified-date "2026-01-12")
        (cross-validation "CIPC records, financial statements")
        (mechanism "Director owns 50% Villa Via, 50% RST, charges rent Villa Via → RST")
        (conflict-of-interest "Director on both sides of rent transaction")
        (dual-source-verified #t))
      
      ;; STRATEGIC POSITIONING ATTRIBUTES
      (attribute "strategic-exclusion" "Excluded from 'group' framing"
        (verification-level 4)
        (confidence 0.85)
        (source "Email correspondence, 'NOT A GROUP' statement")
        (verified-date "2026-01-12")
        (cross-validation "Email records, financial reporting patterns")
        (purpose "Hide profit extraction mechanism")
        (group-framing "SLG, RST, RWD framed as 'group', Villa Via excluded")
        (dual-source-verified #f)))
    
    ;; RELATIONS
    (list
      "REL-036-V66"  ; Ownership relationship with Peter Faucitt
      "REL-037-V66"  ; Rent relationship with RST
      "REL-038-V66"  ; Self-dealing relationship
      "REL-039-V66") ; Strategic exclusion relationship
    
    ;; 9-DIMENSIONAL AGENT STATE (ENTITY)
    (list
      (dimension "knowledge-state" "passive-entity" 0.50
        (evidence "Corporate entity, no independent knowledge")
        (verification-level 2)
        (ad-paragraphs "10.5" "10.6"))
      (dimension "intent-state" "controlled-intent" 0.70
        (evidence "Intent determined by director/shareholder")
        (verification-level 6)
        (ad-paragraphs "10.5" "10.6"))
      (dimension "capability-state" "property-holding-capability" 0.90
        (evidence "Property ownership, rent collection capability")
        (verification-level 2)
        (ad-paragraphs "10.5" "10.6"))
      (dimension "opportunity-state" "strategic-positioning-opportunity" 0.90
        (evidence "Strategic exclusion from 'group' framing provides protection")
        (verification-level 4)
        (ad-paragraphs "10.5" "10.6"))
      (dimension "benefit-state" "profit-extraction-benefit" 0.95
        (evidence "86% rent profit, strategic profit extraction mechanism")
        (verification-level 3)
        (ad-paragraphs "10.5" "10.6"))
      (dimension "risk-state" "low-risk" 0.80
        (evidence "Strategic exclusion provides protection, corporate structure insulation")
        (verification-level 6)
        (ad-paragraphs "10.5" "10.6"))
      (dimension "legal-awareness-state" "controlled-awareness" 0.70
        (evidence "Awareness determined by director, strategic positioning")
        (verification-level 6)
        (ad-paragraphs "10.5" "10.6"))
      (dimension "strategic-coordination-state" "integrated-coordination" 0.85
        (evidence "Coordinated with group profit extraction strategy")
        (verification-level 6)
        (ad-paragraphs "10.5" "10.6"))
      (dimension "regulatory-compliance-state" "basic-compliance" 0.80
        (evidence "CIPC compliance, tax compliance, property regulations")
        (verification-level 2)
        (ad-paragraphs "")))
    
    ;; NETWORK POSITION
    (network-position
      (centrality-score 0.70)
      (betweenness-score 0.65)
      (closeness-score 0.68)
      (network-role "profit-extraction-vehicle")
      (coordination-partners "AGENT-ENTITY-006-V66" "AGENT-AP-001-V66")
      (network-strength 0.75))))

;;; =============================================================================
;;; END OF HIGH-RESOLUTION AGENT MODELS V66 (PARTIAL - CONTINUED IN NEXT FILE)
;;; =============================================================================
