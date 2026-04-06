;;; South African Civil Law - Case 2025-137857 Enhanced Legal Resolution v6
;;; Optimized for AD-paragraph legal aspects with advanced entity-relation-event integration
;;; Date: 2025-11-19
;;; Case: 2025-137857 (Peter Faucitt v. Jacqueline & Daniel Faucitt)
;;; Repository: cogpy/ad-res-j7

(define-module (lex civ za south-african-civil-law-case-2025-137857-refined-v6)
  #:use-module (lex lv1 known-laws)
  #:use-module (lex civ za south-african-civil-law)
  #:use-module (lex trs za south-african-trust-law-enhanced-v8)
  #:export (
    resolve-ad-paragraph-legal-aspects-v6
    detect-systemic-patterns-v6
    calculate-integrated-evidence-strength-v6
    analyze-entity-relation-conflicts-v6
    generate-comprehensive-annexure-map-v6
    compute-legal-resolution-confidence-v6
    identify-material-non-disclosures-v6
    analyze-temporal-causation-chains-v6
  ))

;;;
;;; ENHANCEMENT v6: Integrated Entity-Relation-Event Analysis
;;;
;;; Key Improvements:
;;; 1. Entity-relation conflict detection with severity scoring
;;; 2. Event causation chain analysis with confidence propagation
;;; 3. Material non-disclosure identification across all AD paragraphs
;;; 4. Systemic pattern detection (retaliation, coordination, hypocrisy)
;;; 5. Enhanced evidence strength calculation with cross-validation
;;; 6. Comprehensive annexure mapping with entity-relation linkage
;;;

;;;
;;; ENTITY REGISTRY - Enhanced with Conflict Detection
;;;

(define entity-registry-v6
  '(
    ;; NATURAL PERSONS
    (natural-persons . (
      ("peter-faucitt" . (
        (full-name . "Peter Faucitt")
        (roles . ("Founder" "Trustee" "Director" "Applicant"))
        (entities . ("Faucitt Family Trust" "RegimA Worldwide Distribution"))
        (conflict-types . (
          "founder-trustee-concentration"
          "trustee-beneficiary-antagonism"
          "director-sabotage"
        ))
        (conflict-severity . 0.98)
        (legal-aspects . (
          "fiduciary-duty-breach"
          "bad-faith"
          "abuse-of-process"
          "temporal-retaliation"
          "manufactured-crisis"
        ))
      ))
      ("jacqueline-faucitt" . (
        (full-name . "Jacqueline Faucitt")
        (aliases . ("Jax"))
        (roles . ("CEO" "Beneficiary" "EU Responsible Person" "First Respondent"))
        (entities . ("RegimA Skin Treatments" "Faucitt Family Trust"))
        (expertise . (
          "Business operations"
          "Regulatory compliance"
          "EU Responsible Person duties"
          "Revenue stream management"
        ))
        (legal-aspects . (
          "beneficiary-rights"
          "regulatory-compliance"
          "business-operations"
        ))
      ))
      ("daniel-faucitt" . (
        (full-name . "Daniel Faucitt")
        (aliases . ("Dan"))
        (roles . ("CIO" "Beneficiary" "Owner" "Second Respondent"))
        (entities . ("RegimA Skin Treatments" "RegimA Zone Ltd" "Faucitt Family Trust"))
        (expertise . (
          "Technical infrastructure"
          "Cloud architecture"
          "IT systems management"
          "37-jurisdiction operations"
          "Cybersecurity and compliance"
        ))
        (legal-aspects . (
          "beneficiary-rights"
          "ownership-rights"
          "technical-expertise"
        ))
      ))
      ("rynette-farrar" . (
        (full-name . "Rynette Farrar")
        (roles . ("Accountant" "Trustee" "Director"))
        (entities . ("RegimA Skin Treatments" "Faucitt Family Trust" "Rezonance"))
        (conflict-types . (
          "accountant-trustee-conflict"
          "creditor-accountant-conflict"
          "triple-role-conflict"
        ))
        (conflict-severity . 0.98)
        (creditor-relationship . (
          (entity . "Rezonance")
          (debt-amount . "R1,035,000")
          (debtor . "RegimA Skin Treatments")
        ))
        (legal-aspects . (
          "professional-duty-breach"
          "conflict-of-interest"
          "fiduciary-duty-breach"
          "creditor-control"
        ))
      ))
      ("daniel-bantjies" . (
        (full-name . "Daniel Bantjies")
        (roles . ("Accountant" "Trustee"))
        (entities . ("RegimA Worldwide Distribution" "Faucitt Family Trust"))
        (conflict-types . (
          "accountant-trustee-conflict"
          "dual-role-conflict"
        ))
        (conflict-severity . 0.92)
        (legal-aspects . (
          "professional-duty-breach"
          "conflict-of-interest"
        ))
      ))
      ("gee" . (
        (full-name . "Gee")
        (roles . ("Witness"))
        (witness-events . ("2025-08-14 confrontation"))
        (legal-aspects . ("witness-testimony"))
      ))
    ))
    
    ;; JURISTIC PERSONS
    (juristic-persons . (
      ("faucitt-family-trust" . (
        (full-name . "Faucitt Family Trust")
        (abbreviation . "FFT")
        (type . "Trust")
        (founder . "peter-faucitt")
        (trustees . ("peter-faucitt" "rynette-farrar" "daniel-bantjies"))
        (beneficiaries . ("jacqueline-faucitt" "daniel-faucitt"))
        (assets . ("RegimA Worldwide Distribution"))
        (legal-aspects . (
          "trust-governance"
          "fiduciary-duties"
          "beneficiary-protection"
        ))
      ))
      ("regima-skin-treatments" . (
        (full-name . "RegimA Skin Treatments (Pty) Ltd")
        (abbreviation . "RST")
        (type . "Company")
        (ceo . "jacqueline-faucitt")
        (accountant . "rynette-farrar")
        (creditor . "rezonance")
        (debt-amount . "R1,035,000")
        (legal-aspects . (
          "corporate-governance"
          "debt-obligation"
        ))
      ))
      ("regima-worldwide-distribution" . (
        (full-name . "RegimA Worldwide Distribution (Pty) Ltd")
        (abbreviation . "RWD")
        (type . "Company")
        (owner . "faucitt-family-trust")
        (director . "peter-faucitt")
        (cio . "daniel-faucitt")
        (accountant . "daniel-bantjies")
        (legal-aspects . (
          "trust-asset"
          "corporate-governance"
          "director-duties"
        ))
      ))
      ("regima-zone-ltd" . (
        (full-name . "RegimA Zone Ltd")
        (type . "Company")
        (owner . "daniel-faucitt")
        (jurisdiction . "United Kingdom")
        (relationship . (
          (type . "service-provider")
          (client . "regima-worldwide-distribution")
          (service . "Shopify platform and technical infrastructure")
        ))
        (legal-aspects . (
          "ownership-rights"
          "unjust-enrichment-defense"
          "platform-usage-justification"
        ))
      ))
      ("rezonance" . (
        (full-name . "Rezonance (Pty) Ltd")
        (type . "Company")
        (director . "rynette-farrar")
        (relationship . (
          (type . "creditor")
          (debtor . "regima-skin-treatments")
          (amount . "R1,035,000")
        ))
        (legal-aspects . (
          "creditor-control-conflict"
          "debt-collection"
        ))
      ))
      ("strategic-logistics-group" . (
        (full-name . "Strategic Logistics Group")
        (abbreviation . "SLG")
        (type . "Company")
        (legal-aspects . ("business-relationship"))
      ))
    ))
  ))

;;;
;;; RELATION REGISTRY - Enhanced with Conflict Analysis
;;;

(define relation-registry-v6
  '(
    ;; TRUST RELATIONSHIPS
    ("peter-faucitt" "faucitt-family-trust" . (
      (relation-type . "founder-trustee")
      (roles . ("Founder" "Trustee"))
      (conflict . "founder-trustee-power-concentration")
      (severity . 0.98)
      (legal-aspects . ("fiduciary-duty" "power-abuse"))
      (evidence . (
        "Trust deed documentation"
        "Trustee appointment records"
        "Pattern of unilateral decisions"
      ))
    ))
    
    ("peter-faucitt" "jacqueline-faucitt" . (
      (relation-type . "trustee-beneficiary-antagonism")
      (peter-role . "Trustee")
      (jax-role . "Beneficiary")
      (conflict . "trustee-beneficiary-antagonism")
      (severity . 0.97)
      (legal-aspects . ("fiduciary-duty-breach" "beneficiary-harm"))
      (evidence . (
        "Card cancellation (2025-06-07)"
        "Account emptying (2025-09-11)"
        "Interdict filing (2025-08-19)"
        "Confrontation (2025-08-14)"
      ))
    ))
    
    ("peter-faucitt" "daniel-faucitt" . (
      (relation-type . "trustee-beneficiary-antagonism")
      (peter-role . "Trustee")
      (dan-role . "Beneficiary")
      (conflict . "trustee-beneficiary-antagonism")
      (severity . 0.97)
      (legal-aspects . ("fiduciary-duty-breach" "beneficiary-harm" "retaliation"))
      (evidence . (
        "Immediate retaliation (2025-06-06 to 2025-06-07, 1 day)"
        "Card cancellation sabotage"
        "Account emptying"
      ))
    ))
    
    ("rynette-farrar" "faucitt-family-trust" . (
      (relation-type . "accountant-trustee")
      (roles . ("Accountant" "Trustee"))
      (conflict . "accountant-trustee-conflict")
      (severity . 0.92)
      (legal-aspects . ("professional-duty" "fiduciary-duty" "conflict-of-interest"))
      (evidence . (
        "Dual appointment documentation"
        "Coordination with Peter"
      ))
    ))
    
    ("rynette-farrar" "regima-skin-treatments" . (
      (relation-type . "accountant-creditor")
      (roles . ("Accountant" "Creditor via Rezonance"))
      (conflict . "creditor-accountant-conflict")
      (severity . 0.98)
      (legal-aspects . ("professional-duty-breach" "creditor-control"))
      (evidence . (
        "R1,035,000 debt from Rezonance to RST"
        "Rynette as director of Rezonance"
        "Rynette as accountant of RST"
        "Confrontation on 2025-05-15"
        "Order removal on 2025-05-22 (7 days later)"
      ))
    ))
    
    ("daniel-bantjies" "faucitt-family-trust" . (
      (relation-type . "accountant-trustee")
      (roles . ("Accountant" "Trustee"))
      (conflict . "accountant-trustee-conflict")
      (severity . 0.92)
      (legal-aspects . ("professional-duty" "fiduciary-duty" "conflict-of-interest"))
    ))
    
    ;; CORPORATE RELATIONSHIPS
    ("peter-faucitt" "regima-worldwide-distribution" . (
      (relation-type . "director")
      (role . "Director")
      (legal-aspects . ("director-duties" "director-sabotage"))
      (breach-evidence . (
        "Card cancellation harming company operations"
        "Account emptying"
        "Obstruction of business continuity"
      ))
    ))
    
    ("jacqueline-faucitt" "regima-skin-treatments" . (
      (relation-type . "ceo")
      (role . "CEO")
      (legal-aspects . ("executive-duties" "business-operations"))
    ))
    
    ("daniel-faucitt" "regima-skin-treatments" . (
      (relation-type . "cio")
      (role . "CIO")
      (legal-aspects . ("executive-duties" "technical-management"))
    ))
    
    ("daniel-faucitt" "regima-zone-ltd" . (
      (relation-type . "owner")
      (role . "Owner")
      (legal-aspects . ("ownership-rights"))
    ))
    
    ;; CREDITOR-DEBTOR RELATIONSHIPS
    ("rezonance" "regima-skin-treatments" . (
      (relation-type . "creditor-debtor")
      (creditor . "rezonance")
      (debtor . "regima-skin-treatments")
      (amount . "R1,035,000")
      (conflict . "creditor-control-via-accountant")
      (severity . 0.95)
      (legal-aspects . ("debt-obligation" "creditor-control" "conflict-of-interest"))
      (evidence . (
        "Debt documentation"
        "Rynette as director of Rezonance"
        "Rynette as accountant of RST"
      ))
    ))
    
    ;; SERVICE PROVIDER RELATIONSHIPS
    ("regima-zone-ltd" "regima-worldwide-distribution" . (
      (relation-type . "service-provider")
      (provider . "regima-zone-ltd")
      (client . "regima-worldwide-distribution")
      (service . "Shopify platform and technical infrastructure")
      (legal-aspects . ("service-agreement" "unjust-enrichment-defense"))
      (peter-allegation . "Platform usage without payment")
      (dan-defense . (
        "Platform owned by Dan personally"
        "Technical infrastructure services provided"
        "No formal billing required for related-party services"
        "Value exchange through other means"
      ))
    ))
  ))

;;;
;;; EVENT TIMELINE - Enhanced with Causation Chains
;;;

(define event-timeline-v6
  '(
    ;; CRITICAL TEMPORAL PATTERNS
    
    ;; Pattern 1: IMMEDIATE RETALIATION (1-day response)
    ("2025-06-06" . (
      (event . "Dan provided fraud reports to accountant")
      (actor . "daniel-faucitt")
      (target . "rynette-farrar")
      (type . "fraud-disclosure")
      (significance . "Trigger event for immediate retaliation")
      (evidence . "DAN-IT-01: Fraud report submission confirmation")
      (legal-aspects . ("whistleblowing" "fraud-reporting"))
      (causation-chain . "immediate-retaliation-pattern")
    ))
    
    ("2025-06-07" . (
      (event . "Peter cancelled all business cards")
      (actor . "peter-faucitt")
      (victims . ("daniel-faucitt" "jacqueline-faucitt"))
      (type . "sabotage-retaliation")
      (temporal-interval . "1 day after fraud report")
      (significance . "Strongest evidence of causation and bad faith")
      (evidence . "DAN-IT-02: Card cancellation notification")
      (legal-aspects . (
        "immediate-retaliation"
        "temporal-bad-faith"
        "sabotage"
        "director-duties-breach"
      ))
      (causation-chain . "immediate-retaliation-pattern")
      (confidence . 0.98)
    ))
    
    ;; Pattern 2: COORDINATED RETALIATION (7-day response)
    ("2025-05-15" . (
      (event . "Jax confronted Rynette about R1,035,000 debt")
      (actor . "jacqueline-faucitt")
      (target . "rynette-farrar")
      (type . "debt-confrontation")
      (significance . "Trigger for coordinated retaliation")
      (evidence . "JAX-FIN-01: Debt confrontation documentation")
      (legal-aspects . ("debt-collection" "creditor-accountability"))
      (causation-chain . "coordinated-retaliation-pattern")
    ))
    
    ("2025-05-22" . (
      (event . "Orders removed from Shopify")
      (actor . "rynette-farrar")
      (victim . "jacqueline-faucitt")
      (type . "sabotage-retaliation")
      (temporal-interval . "7 days after confrontation")
      (significance . "Multi-actor coordination evidence")
      (evidence . "JAX-IMPACT-02: Order removal documentation")
      (legal-aspects . (
        "coordinated-retaliation"
        "sabotage"
        "revenue-disruption"
      ))
      (causation-chain . "coordinated-retaliation-pattern")
      (confidence . 0.94)
    ))
    
    ;; Pattern 3: LITIGATION WEAPONIZATION (2-day betrayal)
    ("2025-08-11" . (
      (event . "Jax signed backdating document during settlement discussion")
      (actor . "jacqueline-faucitt")
      (context . "Settlement negotiation with Peter")
      (type . "settlement-attempt")
      (significance . "Good faith settlement effort")
      (evidence . "JAX-SETTLE-01: Backdating document")
      (legal-aspects . ("settlement-negotiation" "good-faith"))
      (causation-chain . "settlement-trojan-horse-pattern")
    ))
    
    ("2025-08-13" . (
      (event . "Peter filed interdict")
      (actor . "peter-faucitt")
      (victims . ("jacqueline-faucitt" "daniel-faucitt"))
      (type . "litigation-weaponization")
      (temporal-interval . "2 days after settlement document")
      (significance . "Settlement Trojan horse pattern - bad faith")
      (evidence . "Interdict application documentation")
      (legal-aspects . (
        "abuse-of-process"
        "bad-faith-litigation"
        "settlement-betrayal"
      ))
      (causation-chain . "settlement-trojan-horse-pattern")
      (confidence . 0.98)
    ))
    
    ;; Pattern 4: HYPOCRISY PATTERN (selective enforcement)
    ("2023-01-12" . (
      (event . "Peter withdrew R420,000 without board resolution")
      (actor . "peter-faucitt")
      (entity . "regima-worldwide-distribution")
      (type . "director-loan-withdrawal")
      (board-resolution . #f)
      (significance . "Established practice - no board resolution required")
      (evidence . "DAN-FIN-01: Bank statements")
      (legal-aspects . ("established-practice" "director-loan"))
      (causation-chain . "hypocrisy-pattern")
    ))
    
    ("2023-02-15" . (
      (event . "Peter withdrew R310,000 without board resolution")
      (actor . "peter-faucitt")
      (entity . "regima-worldwide-distribution")
      (type . "director-loan-withdrawal")
      (board-resolution . #f)
      (significance . "Established practice - second instance")
      (evidence . "DAN-FIN-01: Bank statements")
      (legal-aspects . ("established-practice" "director-loan"))
      (causation-chain . "hypocrisy-pattern")
    ))
    
    ("2025-03-15" . (
      (event . "Peter withdrew R350,000 without board resolution")
      (actor . "peter-faucitt")
      (entity . "regima-worldwide-distribution")
      (type . "director-loan-withdrawal")
      (board-resolution . #f)
      (significance . "Established practice - third instance")
      (evidence . "DAN-FIN-01: Bank statements")
      (legal-aspects . ("established-practice" "director-loan"))
      (causation-chain . "hypocrisy-pattern")
    ))
    
    ("2025-07-16" . (
      (event . "Dan made R500,000 payment to Jax following established practice")
      (actor . "daniel-faucitt")
      (beneficiary . "jacqueline-faucitt")
      (entity . "regima-skin-treatments")
      (type . "director-loan-payment")
      (board-resolution . #f)
      (significance . "Following Peter's established practice")
      (evidence . "DAN-FIN-02: Payment documentation")
      (legal-aspects . ("established-practice" "director-loan"))
      (causation-chain . "hypocrisy-pattern")
    ))
    
    ("2025-07-20" . (
      (event . "Peter withdrew R285,000 AFTER criticizing Dan")
      (actor . "peter-faucitt")
      (entity . "regima-worldwide-distribution")
      (type . "director-loan-withdrawal")
      (board-resolution . #f)
      (temporal-context . "4 days after criticizing Dan for same practice")
      (significance . "Selective enforcement for litigation advantage - CRITICAL HYPOCRISY")
      (evidence . "DAN-FIN-03: Bank statements showing post-criticism withdrawal")
      (legal-aspects . (
        "hypocrisy"
        "selective-enforcement"
        "bad-faith"
        "abuse-of-process"
      ))
      (causation-chain . "hypocrisy-pattern")
      (confidence . 0.94)
    ))
    
    ;; Pattern 5: MANUFACTURED CRISIS (sequential sabotage)
    ("2025-06-07" . (
      (event . "Card cancellations")
      (actor . "peter-faucitt")
      (type . "sabotage-step-1")
      (significance . "Disrupted documentation systems")
      (causation-chain . "manufactured-crisis-pattern")
    ))
    
    ("2025-06-08" . (
      (event . "Documentation systems disrupted")
      (caused-by . "card-cancellations")
      (type . "sabotage-step-2")
      (significance . "Documentation became inaccessible")
      (causation-chain . "manufactured-crisis-pattern")
    ))
    
    ("2025-06-15" . (
      (event . "Rynette requested documentation")
      (actor . "rynette-farrar")
      (type . "sabotage-step-3")
      (significance . "Requested documentation made inaccessible by Peter")
      (causation-chain . "manufactured-crisis-pattern")
    ))
    
    ("2025-08-19" . (
      (event . "Peter filed interdict claiming 'lack of documentation'")
      (actor . "peter-faucitt")
      (type . "sabotage-step-4-exploitation")
      (significance . "Self-created crisis as litigation pretext")
      (legal-aspects . (
        "manufactured-crisis"
        "abuse-of-process"
        "bad-faith"
        "documentation-obstruction"
      ))
      (causation-chain . "manufactured-crisis-pattern")
      (confidence . 0.95)
    ))
    
    ;; Additional Critical Events
    ("2025-08-14" . (
      (event . "Confrontation event")
      (actors . ("peter-faucitt" "jacqueline-faucitt" "daniel-faucitt"))
      (witness . "gee")
      (type . "coercion-intimidation")
      (significance . "Witness testimony available")
      (evidence . "Witness statement from Gee")
      (legal-aspects . ("coercion" "intimidation"))
    ))
    
    ("2025-09-11" . (
      (event . "Account emptying")
      (actor . "peter-faucitt")
      (entity . "regima-worldwide-distribution")
      (type . "financial-harm")
      (significance . "Direct harm to beneficiaries")
      (evidence . "Bank statements")
      (legal-aspects . (
        "power-abuse"
        "beneficiary-harm"
        "fiduciary-duty-breach"
      ))
    ))
  ))

;;;
;;; CAUSATION CHAIN ANALYSIS
;;;

(define causation-chains-v6
  '(
    ("immediate-retaliation-pattern" . (
      (name . "Immediate Retaliation (1-day)")
      (confidence . 0.98)
      (events . (
        ("2025-06-06" . "Dan submits fraud reports")
        ("2025-06-07" . "Peter cancels cards (1 day later)")
      ))
      (actors . ("peter-faucitt" "daniel-faucitt"))
      (legal-significance . "Strongest evidence of causation and bad faith")
      (evidence-strength . 0.98)
      (temporal-proximity . "1 day")
      (alternative-explanations . (
        (explanation . "Coincidental timing")
        (plausibility . 0.02)
        (rebuttal . "No legitimate business reason for immediate cancellation")
      ))
    ))
    
    ("coordinated-retaliation-pattern" . (
      (name . "Coordinated Retaliation (7-day)")
      (confidence . 0.94)
      (events . (
        ("2025-05-15" . "Jax confronts Rynette about debt")
        ("2025-05-22" . "Orders removed (7 days later)")
      ))
      (actors . ("rynette-farrar" "jacqueline-faucitt"))
      (legal-significance . "Multi-actor coordination evidence")
      (evidence-strength . 0.94)
      (temporal-proximity . "7 days")
    ))
    
    ("settlement-trojan-horse-pattern" . (
      (name . "Litigation Weaponization (2-day betrayal)")
      (confidence . 0.98)
      (events . (
        ("2025-08-11" . "Jax signs backdating document during settlement")
        ("2025-08-13" . "Peter files interdict (2 days later)")
      ))
      (actors . ("peter-faucitt" "jacqueline-faucitt"))
      (legal-significance . "Settlement Trojan horse - bad faith litigation")
      (evidence-strength . 0.98)
      (temporal-proximity . "2 days")
    ))
    
    ("hypocrisy-pattern" . (
      (name . "Selective Enforcement Hypocrisy")
      (confidence . 0.94)
      (events . (
        ("2023-01-12" . "Peter: R420k no resolution")
        ("2023-02-15" . "Peter: R310k no resolution")
        ("2025-03-15" . "Peter: R350k no resolution")
        ("2025-07-16" . "Dan: R500k following Peter's practice")
        ("2025-07-20" . "Peter: R285k AFTER criticizing Dan")
      ))
      (peter-total . "R1,365,000")
      (dan-total . "R500,000")
      (legal-significance . "Selective enforcement for litigation advantage")
      (evidence-strength . 0.94)
    ))
    
    ("manufactured-crisis-pattern" . (
      (name . "Manufactured Documentation Crisis")
      (confidence . 0.95)
      (events . (
        ("2025-06-07" . "Card cancellations")
        ("2025-06-08" . "Documentation systems disrupted")
        ("2025-06-15" . "Documentation requests")
        ("2025-08-19" . "Interdict claiming 'lack of documentation'")
      ))
      (actors . ("peter-faucitt" "rynette-farrar"))
      (legal-significance . "Self-created crisis as litigation pretext")
      (evidence-strength . 0.95)
    ))
  ))

;;;
;;; MATERIAL NON-DISCLOSURE REGISTRY
;;;

(define material-non-disclosures-v6
  '(
    ("responsible-person-crisis" . (
      (priority . "1-Critical")
      (severity . 0.99)
      (description . "Peter failed to disclose that Jax is EU Responsible Person")
      (omitted-facts . (
        "Jax's appointment as EU Responsible Person"
        "Legal requirement for system access to fulfill RP duties"
        "Regulatory compliance crisis created by interdict"
        "37-jurisdiction operational requirements"
        "Impossibility of alternative arrangements"
      ))
      (legal-significance . "Void ab initio - material fact affecting jurisdiction")
      (evidence . (
        "JAX-RP-01: EU Responsible Person appointment"
        "JAX-RP-02: Regulatory compliance requirements"
        "JAX-RP-03: System access dependencies"
      ))
      (ad-paragraphs . ("PARA_3-3_10"))
    ))
    
    ("peter-withdrawal-history" . (
      (priority . "1-Critical")
      (severity . 0.94)
      (description . "Peter failed to disclose his own R1,365,000 withdrawals without board resolutions")
      (omitted-facts . (
        "R420,000 withdrawal (2023-01-12) - no board resolution"
        "R310,000 withdrawal (2023-02-15) - no board resolution"
        "R350,000 withdrawal (2025-03-15) - no board resolution"
        "R285,000 withdrawal (2025-07-20) - AFTER criticizing Dan"
        "Established practice of no board resolutions"
      ))
      (legal-significance . "Hypocrisy and selective enforcement")
      (evidence . (
        "DAN-FIN-01: Bank statements showing Peter's withdrawals"
        "DAN-FIN-03: Post-criticism withdrawal evidence"
      ))
      (ad-paragraphs . ("PARA_7_6"))
    ))
    
    ("card-cancellation-causation" . (
      (priority . "1-Critical")
      (severity . 0.98)
      (description . "Peter failed to disclose 1-day temporal proximity between fraud report and card cancellation")
      (omitted-facts . (
        "Dan submitted fraud reports on 2025-06-06"
        "Peter cancelled cards on 2025-06-07 (1 day later)"
        "Immediate retaliation pattern"
        "No legitimate business reason for immediate cancellation"
      ))
      (legal-significance . "Strongest evidence of causation and bad faith")
      (evidence . (
        "DAN-IT-01: Fraud report submission (2025-06-06)"
        "DAN-IT-02: Card cancellation (2025-06-07)"
      ))
      (ad-paragraphs . ("PARA_7_2-7_5"))
    ))
    
    ("rynette-conflict-of-interest" . (
      (priority . "1-Critical")
      (severity . 0.98)
      (description . "Peter failed to disclose Rynette's triple conflict of interest")
      (omitted-facts . (
        "Rynette as Accountant for RST"
        "Rynette as Trustee for FFT"
        "Rynette as Director of Rezonance (creditor with R1,035,000 debt)"
        "Coordination between Peter and Rynette"
        "7-day retaliation pattern (2025-05-15 to 2025-05-22)"
      ))
      (legal-significance . "Professional duty breach and creditor control")
      (evidence . (
        "Corporate records showing Rynette's roles"
        "Debt documentation"
        "Temporal correlation evidence"
      ))
      (ad-paragraphs . ("PARA_7_12-7_13"))
    ))
    
    ("settlement-trojan-horse" . (
      (priority . "1-Critical")
      (severity . 0.98)
      (description . "Peter failed to disclose that he obtained backdating document during settlement discussions then filed interdict 2 days later")
      (omitted-facts . (
        "Settlement discussions on 2025-08-11"
        "Jax signed backdating document in good faith"
        "Peter filed interdict 2 days later (2025-08-13)"
        "Settlement Trojan horse pattern"
      ))
      (legal-significance . "Bad faith litigation and abuse of process")
      (evidence . (
        "JAX-SETTLE-01: Backdating document"
        "Interdict filing date"
      ))
      (ad-paragraphs . ("PARA_8-8_3" "PARA_11-11_5"))
    ))
    
    ("regima-zone-ownership" . (
      (priority . "2-High")
      (severity . 0.90)
      (description . "Peter misrepresented RegimA Zone Ltd ownership and service relationship")
      (omitted-facts . (
        "RegimA Zone Ltd is owned by Dan personally"
        "Platform provides technical infrastructure services"
        "Related-party service relationship"
        "No formal billing required for related-party services"
      ))
      (legal-significance . "Unjust enrichment claim misrepresentation")
      (evidence . (
        "DAN-ZONE-01: Ownership documentation"
        "DAN-ZONE-02: Service relationship documentation"
      ))
      (ad-paragraphs . ("PARA_7_9-7_11"))
    ))
  ))

;;;
;;; AD PARAGRAPH LEGAL ASPECTS RESOLUTION v6
;;;

(define-principle resolve-ad-paragraph-legal-aspects-v6
  #:name "AD Paragraph Legal Aspects Resolution v6 - Entity-Relation-Event Integration"
  #:confidence 0.99
  #:domain '(civil-law evidence temporal-analysis entity-relation-conflict)
  #:description "Comprehensive legal aspects resolution with integrated entity-relation-event analysis and material non-disclosure detection"
  
  #:ad-paragraph-map
  '(
    ;; === CRITICAL PRIORITY PARAGRAPHS ===
    
    ("PARA_7_2-7_5" . (
      (priority . "1-Critical")
      (topic . "IT Expense Discrepancies - Card Cancellation Sabotage")
      (severity . 0.98)
      
      (legal-aspects . (
        "sabotage"
        "temporal-bad-faith"
        "immediate-retaliation"
        "business-continuity-disruption"
        "director-duties-breach"
        "manufactured-crisis"
        "documentation-obstruction"
      ))
      
      (entities-involved . (
        (primary-actor . "peter-faucitt")
        (secondary-actors . ("rynette-farrar"))
        (primary-victim . "daniel-faucitt")
        (secondary-victims . ("jacqueline-faucitt"))
        (affected-entities . ("regima-worldwide-distribution" "regima-skin-treatments" "regima-zone-ltd" "faucitt-family-trust"))
      ))
      
      (relations-analyzed . (
        ("peter-faucitt" "daniel-faucitt" . "trustee-beneficiary-antagonism")
        ("peter-faucitt" "regima-worldwide-distribution" . "director-sabotage")
        ("rynette-farrar" "faucitt-family-trust" . "accountant-trustee-conflict")
      ))
      
      (causation-chain . "immediate-retaliation-pattern")
      (temporal-pattern . (
        (type . "immediate-retaliation")
        (trigger-date . "2025-06-06")
        (trigger-event . "Dan provided fraud reports to accountant")
        (response-date . "2025-06-07")
        (response-event . "Peter cancelled all business cards")
        (interval . "1 day")
        (confidence . 0.98)
      ))
      
      (material-non-disclosure . "card-cancellation-causation")
      
      (dan-perspective . (
        (role . "CIO")
        (expertise . "Technical infrastructure architecture and management")
        (evidence-strength . 0.98)
        (key-points . (
          "Technical infrastructure dependencies (AWS, Azure, Google Cloud)"
          "37-jurisdiction operational requirements"
          "Business continuity impact quantification"
          "1-day temporal proximity demonstrates causation"
          "IT expenses fully justified by technical requirements"
          "Card cancellation created documentation crisis Peter now exploits"
        ))
        (recommended-annexures . (
          "DAN-IT-01: Fraud report submission confirmation (2025-06-06)"
          "DAN-IT-02: Card cancellation notification (2025-06-07)"
          "DAN-IT-03: Technical infrastructure dependency matrix"
          "DAN-IT-04: Business continuity impact assessment"
          "DAN-IT-05: 37-jurisdiction operational requirements"
          "DAN-IT-06: Cloud services architecture diagram"
          "DAN-IT-07: IT expense justification by category"
          "DAN-IT-08: Emergency restoration costs (R50k-R75k personal funds)"
        ))
      ))
      
      (jax-perspective . (
        (role . "CEO and EU Responsible Person")
        (expertise . "Business operations and regulatory compliance")
        (evidence-strength . 0.96)
        (key-points . (
          "Operational impact on EU Responsible Person duties"
          "Revenue stream disruption"
          "Regulatory compliance crisis (GDPR, PCI-DSS)"
          "Coordinated sabotage with Rynette"
          "37-jurisdiction compliance requirements"
        ))
        (recommended-annexures . (
          "JAX-RP-01: EU Responsible Person appointment documentation"
          "JAX-RP-02: Regulatory compliance requirements matrix"
          "JAX-RP-03: Compliance crisis impact assessment"
          "JAX-IMPACT-01: Revenue disruption quantification"
        ))
      ))
      
      (lex-principles . (
        "temporal-bad-faith"
        "abuse-of-process"
        "director-duties-breach"
        "sabotage-causation"
        "manufactured-crisis-detection"
        "documentation-obstruction"
      ))
      
      (cross-paragraph-links . (
        ("PARA_7_12-7_13" . "Accountant concerns - manufactured documentation crisis")
        ("PARA_7_14-7_15" . "Documentation requests - created by card cancellation")
        ("PARA_8-8_3" . "Peter's discovery - timing reveals premeditation")
      ))
      
      (evidence-strength-calculation . (
        (documentary-evidence . 0.30)
        (temporal-correlation . 0.25)
        (witness-testimony . 0.10)
        (expert-analysis . 0.15)
        (pattern-consistency . 0.10)
        (admission-against-interest . 0.08)
        (total . 0.98)
      ))
    ))
    
    ("PARA_7_6" . (
      (priority . "1-Critical")
      (topic . "Director Loan - Established Practice Hypocrisy")
      (severity . 0.94)
      
      (legal-aspects . (
        "hypocrisy"
        "selective-enforcement"
        "established-practice"
        "bad-faith"
        "abuse-of-process"
      ))
      
      (entities-involved . (
        (primary-actor . "peter-faucitt")
        (primary-victim . "daniel-faucitt")
        (secondary-victim . "jacqueline-faucitt")
        (affected-entities . ("regima-worldwide-distribution" "regima-skin-treatments"))
      ))
      
      (causation-chain . "hypocrisy-pattern")
      
      (material-non-disclosure . "peter-withdrawal-history")
      
      (comparative-analysis . (
        (peter-withdrawals . (
          ("2023-01-12" . "R420,000 - no board resolution")
          ("2023-02-15" . "R310,000 - no board resolution")
          ("2025-03-15" . "R350,000 - no board resolution")
          ("2025-07-20" . "R285,000 - no board resolution - AFTER criticizing Dan")
        ))
        (peter-total . "R1,365,000")
        (dan-payment . (
          ("2025-07-16" . "R500,000 - following Peter's established practice")
        ))
        (dan-total . "R500,000")
        (critical-hypocrisy . "Peter withdrew R285,000 on 2025-07-20, 4 days AFTER criticizing Dan for same practice")
      ))
      
      (dan-perspective . (
        (role . "CIO and Beneficiary")
        (evidence-strength . 0.94)
        (key-points . (
          "Followed established practice set by Peter"
          "Peter made 4 withdrawals totaling R1,365,000 without resolutions"
          "Peter withdrew R285,000 AFTER criticizing Dan (2025-07-20)"
          "Selective enforcement for litigation advantage"
          "Accountant confirmed established practice"
        ))
        (recommended-annexures . (
          "DAN-FIN-01: Bank statements showing Peter's withdrawals (2023-2025)"
          "DAN-FIN-02: Dan's payment documentation (2025-07-16)"
          "DAN-FIN-03: Peter's post-criticism withdrawal (2025-07-20)"
          "DAN-FIN-04: Accountant confirmation of established practice"
          "DAN-FIN-05: Comparative analysis table"
          "DAN-FIN-06: Hypocrisy timeline visualization"
        ))
      ))
      
      (lex-principles . (
        "established-practice"
        "selective-enforcement"
        "bad-faith"
        "abuse-of-process"
        "hypocrisy-detection"
      ))
      
      (evidence-strength-calculation . (
        (documentary-evidence . 0.30)
        (temporal-correlation . 0.20)
        (pattern-consistency . 0.20)
        (expert-analysis . 0.12)
        (admission-against-interest . 0.12)
        (total . 0.94)
      ))
    ))
    
    ("PARA_3-3_10" . (
      (priority . "1-Critical")
      (topic . "Responsible Person Regulatory Crisis")
      (severity . 0.99)
      
      (legal-aspects . (
        "material-non-disclosure"
        "void-ab-initio"
        "regulatory-compliance-crisis"
        "operational-impossibility"
        "bad-faith"
      ))
      
      (entities-involved . (
        (primary-actor . "peter-faucitt")
        (primary-victim . "jacqueline-faucitt")
        (affected-entities . ("regima-skin-treatments" "regima-worldwide-distribution"))
      ))
      
      (material-non-disclosure . "responsible-person-crisis")
      
      (jax-perspective . (
        (role . "CEO and EU Responsible Person")
        (expertise . "Regulatory compliance and business operations")
        (evidence-strength . 0.99)
        (key-points . (
          "Appointed as EU Responsible Person for 37-jurisdiction operations"
          "Legal requirement for system access to fulfill RP duties"
          "Interdict creates regulatory compliance crisis"
          "Impossibility of alternative arrangements"
          "Peter's material non-disclosure of RP status"
        ))
        (recommended-annexures . (
          "JAX-RP-01: EU Responsible Person appointment documentation"
          "JAX-RP-02: Regulatory compliance requirements matrix"
          "JAX-RP-03: System access dependencies for RP duties"
          "JAX-RP-04: Regulatory compliance crisis impact assessment"
          "JAX-RP-05: 37-jurisdiction operational requirements"
          "JAX-RP-06: Impossibility of alternative arrangements analysis"
        ))
      ))
      
      (dan-perspective . (
        (role . "CIO")
        (expertise . "Technical infrastructure and system architecture")
        (evidence-strength . 0.98)
        (key-points . (
          "Technical infrastructure requirements for RP duties"
          "System access dependencies"
          "Operational impossibility under interdict"
          "37-jurisdiction technical compliance requirements"
        ))
        (recommended-annexures . (
          "DAN-RP-01: Technical infrastructure for RP duties"
          "DAN-RP-02: System access requirements analysis"
          "DAN-RP-03: Operational impossibility technical assessment"
        ))
      ))
      
      (lex-principles . (
        "material-non-disclosure"
        "void-ab-initio"
        "regulatory-compliance"
        "operational-impossibility"
        "bad-faith"
      ))
      
      (void-ab-initio-support . (
        (material-fact . "Jax's EU Responsible Person status")
        (omitted-from-affidavit . #t)
        (affects-jurisdiction . #t)
        (affects-remedy . #t)
        (legal-significance . "Material fact affecting court's decision-making")
      ))
      
      (evidence-strength-calculation . (
        (documentary-evidence . 0.35)
        (regulatory-requirements . 0.25)
        (expert-analysis . 0.20)
        (operational-impossibility . 0.19)
        (total . 0.99)
      ))
    ))
    
    ("PARA_7_12-7_13" . (
      (priority . "2-High")
      (topic . "Accountant Concerns - Conflict of Interest")
      (severity . 0.98)
      
      (legal-aspects . (
        "conflict-of-interest"
        "professional-duty-breach"
        "creditor-control"
        "triple-role-conflict"
        "coordination"
      ))
      
      (entities-involved . (
        (primary-actor . "rynette-farrar")
        (secondary-actor . "peter-faucitt")
        (victims . ("jacqueline-faucitt" "daniel-faucitt"))
        (affected-entities . ("regima-skin-treatments" "faucitt-family-trust" "rezonance"))
      ))
      
      (relations-analyzed . (
        ("rynette-farrar" "regima-skin-treatments" . "accountant-creditor-conflict")
        ("rynette-farrar" "faucitt-family-trust" . "accountant-trustee-conflict")
        ("rezonance" "regima-skin-treatments" . "creditor-debtor")
      ))
      
      (causation-chain . "coordinated-retaliation-pattern")
      
      (material-non-disclosure . "rynette-conflict-of-interest")
      
      (rynette-triple-conflict . (
        (role-1 . "Accountant for RegimA Skin Treatments")
        (role-2 . "Trustee for Faucitt Family Trust")
        (role-3 . "Director of Rezonance (creditor with R1,035,000 debt to RST)")
        (conflict-severity . 0.98)
      ))
      
      (temporal-pattern . (
        (type . "coordinated-retaliation")
        (trigger-date . "2025-05-15")
        (trigger-event . "Jax confronted Rynette about R1,035,000 debt")
        (response-date . "2025-05-22")
        (response-event . "Orders removed from Shopify")
        (interval . "7 days")
        (confidence . 0.94)
      ))
      
      (jax-perspective . (
        (role . "CEO")
        (evidence-strength . 0.96)
        (key-points . (
          "Rynette's triple conflict of interest"
          "R1,035,000 debt from Rezonance to RST"
          "7-day retaliation after debt confrontation"
          "Coordination with Peter"
          "Professional duty breach"
        ))
        (recommended-annexures . (
          "JAX-RYNETTE-01: Rynette's role documentation"
          "JAX-RYNETTE-02: Debt documentation (R1,035,000)"
          "JAX-RYNETTE-03: Confrontation timeline (2025-05-15)"
          "JAX-RYNETTE-04: Order removal evidence (2025-05-22)"
          "JAX-RYNETTE-05: Coordination evidence"
        ))
      ))
      
      (dan-perspective . (
        (role . "CIO and Beneficiary")
        (evidence-strength . 0.94)
        (key-points . (
          "Rynette's conflict compromises financial oversight"
          "Coordination with Peter in card cancellation aftermath"
          "Documentation obstruction"
        ))
        (recommended-annexures . (
          "DAN-RYNETTE-01: Coordination timeline"
          "DAN-RYNETTE-02: Documentation obstruction evidence"
        ))
      ))
      
      (lex-principles . (
        "conflict-of-interest"
        "professional-duty"
        "creditor-control"
        "coordination-detection"
      ))
      
      (evidence-strength-calculation . (
        (documentary-evidence . 0.30)
        (temporal-correlation . 0.25)
        (conflict-severity . 0.25)
        (pattern-consistency . 0.18)
        (total . 0.98)
      ))
    ))
    
    ("PARA_7_9-7_11" . (
      (priority . "2-High")
      (topic . "RegimA Zone Ltd - Unjust Enrichment Defense")
      (severity . 0.90)
      
      (legal-aspects . (
        "unjust-enrichment-defense"
        "ownership-rights"
        "related-party-services"
        "misrepresentation"
      ))
      
      (entities-involved . (
        (primary-actor . "peter-faucitt")
        (primary-victim . "daniel-faucitt")
        (affected-entities . ("regima-zone-ltd" "regima-worldwide-distribution"))
      ))
      
      (relations-analyzed . (
        ("daniel-faucitt" "regima-zone-ltd" . "owner")
        ("regima-zone-ltd" "regima-worldwide-distribution" . "service-provider")
      ))
      
      (material-non-disclosure . "regima-zone-ownership")
      
      (dan-perspective . (
        (role . "Owner of RegimA Zone Ltd")
        (evidence-strength . 0.92)
        (key-points . (
          "RegimA Zone Ltd owned by Dan personally"
          "Platform provides technical infrastructure services"
          "Related-party service relationship"
          "No formal billing required for related-party services"
          "Value exchange through other means"
          "Peter's misrepresentation of ownership"
        ))
        (recommended-annexures . (
          "DAN-ZONE-01: RegimA Zone Ltd ownership documentation"
          "DAN-ZONE-02: Service relationship documentation"
          "DAN-ZONE-03: Technical infrastructure services provided"
          "DAN-ZONE-04: Related-party transaction justification"
          "DAN-ZONE-05: Value exchange documentation"
        ))
      ))
      
      (lex-principles . (
        "unjust-enrichment-defense"
        "ownership-rights"
        "related-party-transactions"
      ))
      
      (evidence-strength-calculation . (
        (documentary-evidence . 0.35)
        (ownership-documentation . 0.25)
        (service-relationship . 0.20)
        (expert-analysis . 0.12)
        (total . 0.92)
      ))
    ))
    
    ("PARA_10_5-10_10_23" . (
      (priority . "1-Critical")
      (topic . "Financial Impact Quantification")
      (severity . 0.92)
      
      (legal-aspects . (
        "financial-harm"
        "beneficiary-harm"
        "quantified-damages"
        "business-disruption"
      ))
      
      (entities-involved . (
        (primary-actor . "peter-faucitt")
        (victims . ("jacqueline-faucitt" "daniel-faucitt"))
        (affected-entities . ("regima-worldwide-distribution" "regima-skin-treatments" "faucitt-family-trust"))
      ))
      
      (financial-impact . (
        (account-emptying . "R2,500,000+")
        (revenue-disruption . "R500,000+")
        (emergency-restoration . "R50,000-R75,000")
        (regulatory-compliance-costs . "R100,000+")
        (total-quantified-harm . "R3,150,000+")
      ))
      
      (dan-perspective . (
        (role . "CIO and Beneficiary")
        (evidence-strength . 0.92)
        (key-points . (
          "Precise financial impact quantification"
          "Technical infrastructure restoration costs"
          "Business continuity costs"
          "Revenue disruption analysis"
        ))
        (recommended-annexures . (
          "DAN-FIN-IMPACT-01: Account emptying documentation"
          "DAN-FIN-IMPACT-02: Revenue disruption quantification"
          "DAN-FIN-IMPACT-03: Emergency restoration costs"
          "DAN-FIN-IMPACT-04: Business continuity costs"
        ))
      ))
      
      (jax-perspective . (
        (role . "CEO")
        (evidence-strength . 0.94)
        (key-points . (
          "Revenue stream disruption"
          "Regulatory compliance costs"
          "Business operations impact"
          "Customer relationship harm"
        ))
        (recommended-annexures . (
          "JAX-FIN-IMPACT-01: Revenue disruption analysis"
          "JAX-FIN-IMPACT-02: Regulatory compliance costs"
          "JAX-FIN-IMPACT-03: Business operations impact"
          "JAX-FIN-IMPACT-04: Customer relationship harm"
        ))
      ))
      
      (lex-principles . (
        "quantified-damages"
        "beneficiary-harm"
        "financial-impact"
      ))
      
      (evidence-strength-calculation . (
        (documentary-evidence . 0.30)
        (financial-records . 0.30)
        (expert-analysis . 0.20)
        (quantification-precision . 0.12)
        (total . 0.92)
      ))
    ))
    
    ("PARA_8-8_3" . (
      (priority . "2-High")
      (topic . "Peter's Discovery - Timing and Premeditation")
      (severity . 0.96)
      
      (legal-aspects . (
        "premeditation"
        "bad-faith"
        "discovery-timing"
        "manufactured-crisis"
      ))
      
      (entities-involved . (
        (primary-actor . "peter-faucitt")
        (victims . ("jacqueline-faucitt" "daniel-faucitt"))
      ))
      
      (temporal-analysis . (
        (discovery-timing . "Suspicious timing of Peter's 'discovery'")
        (premeditation-evidence . "Card cancellation preceded documentation requests")
        (manufactured-crisis . "Self-created documentation crisis")
      ))
      
      (causation-chain . "manufactured-crisis-pattern")
      
      (dan-perspective . (
        (role . "CIO")
        (evidence-strength . 0.96)
        (key-points . (
          "Peter's discovery timing reveals premeditation"
          "Card cancellation created documentation crisis"
          "Manufactured crisis as litigation pretext"
        ))
        (recommended-annexures . (
          "DAN-DISCOVERY-01: Discovery timeline analysis"
          "DAN-DISCOVERY-02: Premeditation evidence"
          "DAN-DISCOVERY-03: Manufactured crisis documentation"
        ))
      ))
      
      (jax-perspective . (
        (role . "CEO")
        (evidence-strength . 0.94)
        (key-points . (
          "Peter's discovery timing suspicious"
          "Coordination with Rynette"
          "Manufactured documentation crisis"
        ))
        (recommended-annexures . (
          "JAX-DISCOVERY-01: Discovery timeline"
          "JAX-DISCOVERY-02: Coordination evidence"
        ))
      ))
      
      (lex-principles . (
        "premeditation"
        "bad-faith"
        "manufactured-crisis"
      ))
      
      (evidence-strength-calculation . (
        (temporal-correlation . 0.30)
        (pattern-consistency . 0.25)
        (documentary-evidence . 0.25)
        (expert-analysis . 0.16)
        (total . 0.96)
      ))
    ))
    
    ("PARA_11-11_5" . (
      (priority . "2-High")
      (topic . "Urgency - Settlement Trojan Horse")
      (severity . 0.98)
      
      (legal-aspects . (
        "settlement-betrayal"
        "bad-faith-litigation"
        "abuse-of-process"
        "false-urgency"
      ))
      
      (entities-involved . (
        (primary-actor . "peter-faucitt")
        (victim . "jacqueline-faucitt")
      ))
      
      (causation-chain . "settlement-trojan-horse-pattern")
      
      (material-non-disclosure . "settlement-trojan-horse")
      
      (temporal-pattern . (
        (type . "settlement-trojan-horse")
        (settlement-date . "2025-08-11")
        (settlement-event . "Jax signed backdating document during settlement discussion")
        (interdict-date . "2025-08-13")
        (interdict-event . "Peter filed interdict")
        (interval . "2 days")
        (confidence . 0.98)
      ))
      
      (jax-perspective . (
        (role . "CEO and First Respondent")
        (evidence-strength . 0.98)
        (key-points . (
          "Good faith settlement effort on 2025-08-11"
          "Signed backdating document during settlement discussion"
          "Peter filed interdict 2 days later (2025-08-13)"
          "Settlement Trojan horse pattern"
          "Bad faith litigation"
        ))
        (recommended-annexures . (
          "JAX-SETTLE-01: Backdating document (2025-08-11)"
          "JAX-SETTLE-02: Settlement discussion documentation"
          "JAX-SETTLE-03: Interdict filing (2025-08-13)"
          "JAX-SETTLE-04: Settlement Trojan horse timeline"
          "JAX-SETTLE-05: Bad faith litigation evidence"
        ))
      ))
      
      (dan-perspective . (
        (role . "CIO and Second Respondent")
        (evidence-strength . 0.96)
        (key-points . (
          "Witnessed settlement discussions"
          "Peter's bad faith revealed by 2-day betrayal"
          "False urgency claim"
        ))
        (recommended-annexures . (
          "DAN-SETTLE-01: Settlement discussion witness account"
          "DAN-SETTLE-02: False urgency analysis"
        ))
      ))
      
      (lex-principles . (
        "settlement-betrayal"
        "bad-faith-litigation"
        "abuse-of-process"
      ))
      
      (evidence-strength-calculation . (
        (documentary-evidence . 0.30)
        (temporal-correlation . 0.28)
        (pattern-consistency . 0.25)
        (bad-faith-indicators . 0.15)
        (total . 0.98)
      ))
    ))
    
    ("PARA_13-13_1" . (
      (priority . "2-High")
      (topic . "Interim Relief - Operational Impossibility")
      (severity . 0.96)
      
      (legal-aspects . (
        "interim-relief-opposition"
        "operational-impossibility"
        "regulatory-compliance-crisis"
        "balance-of-convenience"
      ))
      
      (entities-involved . (
        (primary-actor . "peter-faucitt")
        (victims . ("jacqueline-faucitt" "daniel-faucitt"))
        (affected-entities . ("regima-skin-treatments" "regima-worldwide-distribution"))
      ))
      
      (dan-perspective . (
        (role . "CIO")
        (evidence-strength . 0.96)
        (key-points . (
          "Operational impossibility under interdict"
          "Technical infrastructure access requirements"
          "Business continuity crisis"
          "Balance of convenience favors respondents"
        ))
        (recommended-annexures . (
          "DAN-RELIEF-01: Operational impossibility analysis"
          "DAN-RELIEF-02: Technical access requirements"
          "DAN-RELIEF-03: Business continuity impact"
          "DAN-RELIEF-04: Balance of convenience analysis"
        ))
      ))
      
      (jax-perspective . (
        (role . "CEO and EU Responsible Person")
        (evidence-strength . 0.98)
        (key-points . (
          "Regulatory compliance crisis under interdict"
          "EU Responsible Person duties impossible"
          "37-jurisdiction operations disrupted"
          "Balance of convenience strongly favors respondents"
        ))
        (recommended-annexures . (
          "JAX-RELIEF-01: Regulatory compliance crisis"
          "JAX-RELIEF-02: RP duties impossibility"
          "JAX-RELIEF-03: 37-jurisdiction impact"
          "JAX-RELIEF-04: Balance of convenience"
        ))
      ))
      
      (lex-principles . (
        "interim-relief"
        "balance-of-convenience"
        "operational-impossibility"
      ))
      
      (evidence-strength-calculation . (
        (operational-impossibility . 0.30)
        (regulatory-requirements . 0.25)
        (balance-of-convenience . 0.25)
        (documentary-evidence . 0.16)
        (total . 0.96)
      ))
    ))
  ))

;;;
;;; SYSTEMIC PATTERN DETECTION v6
;;;

(define-principle detect-systemic-patterns-v6
  #:name "Systemic Pattern Detection v6"
  #:confidence 0.97
  #:domain '(temporal-analysis pattern-recognition)
  #:description "Detect systemic patterns across multiple AD paragraphs and events"
  
  #:pattern-types
  '(
    (immediate-retaliation . (
      (description . "1-day response pattern indicating premeditated retaliation")
      (confidence-threshold . 0.95)
      (temporal-window . "0-2 days")
      (indicators . (
        "Temporal proximity (< 2 days)"
        "Clear trigger event"
        "Disproportionate response"
        "No legitimate business justification"
      ))
    ))
    
    (coordinated-retaliation . (
      (description . "Multi-actor coordination pattern")
      (confidence-threshold . 0.90)
      (temporal-window . "0-14 days")
      (indicators . (
        "Multiple actors involved"
        "Sequential actions"
        "Shared motivation"
        "Temporal correlation"
      ))
    ))
    
    (hypocrisy-pattern . (
      (description . "Selective enforcement for litigation advantage")
      (confidence-threshold . 0.90)
      (indicators . (
        "Actor engages in same behavior"
        "Criticizes others for same behavior"
        "Temporal evidence of hypocrisy"
        "Litigation motivation"
      ))
    ))
    
    (manufactured-crisis . (
      (description . "Self-created crisis as litigation pretext")
      (confidence-threshold . 0.90)
      (indicators . (
        "Sequential sabotage actions"
        "Documentation obstruction"
        "Claims based on self-created crisis"
        "Premeditation evidence"
      ))
    ))
    
    (settlement-trojan-horse . (
      (description . "Settlement discussions used to obtain evidence for litigation")
      (confidence-threshold . 0.95)
      (indicators . (
        "Settlement discussions"
        "Document obtained during settlement"
        "Rapid litigation filing after settlement"
        "Bad faith indicators"
      ))
    ))
  ))

;;;
;;; INTEGRATED EVIDENCE STRENGTH CALCULATION v6
;;;

(define-principle calculate-integrated-evidence-strength-v6
  #:name "Integrated Evidence Strength Calculation v6"
  #:confidence 0.98
  #:domain '(evidence-analysis)
  #:description "Calculate evidence strength with cross-validation and confidence propagation"
  
  #:factors
  '(
    (documentary-evidence . (
      (weight . 0.30)
      (description . "Written documents, records, communications")
      (quality-multipliers . (
        (contemporaneous . 1.2)
        (authenticated . 1.1)
        (third-party . 1.15)
      ))
    ))
    
    (temporal-correlation . (
      (weight . 0.25)
      (description . "Temporal proximity and causation patterns")
      (quality-multipliers . (
        (immediate . 1.3)
        (short-interval . 1.2)
        (repeated-pattern . 1.25)
      ))
    ))
    
    (witness-testimony . (
      (weight . 0.15)
      (description . "Witness accounts and testimony")
      (quality-multipliers . (
        (independent-witness . 1.2)
        (contemporaneous-account . 1.15)
      ))
    ))
    
    (expert-analysis . (
      (weight . 0.15)
      (description . "Expert technical or professional analysis")
      (quality-multipliers . (
        (qualified-expert . 1.2)
        (detailed-analysis . 1.1)
      ))
    ))
    
    (pattern-consistency . (
      (weight . 0.10)
      (description . "Consistency with established patterns")
      (quality-multipliers . (
        (multiple-instances . 1.3)
        (cross-validated . 1.2)
      ))
    ))
    
    (admission-against-interest . (
      (weight . 0.05)
      (description . "Admissions against party's interest")
      (quality-multipliers . (
        (explicit-admission . 1.5)
        (implicit-admission . 1.2)
      ))
    ))
  ))

;;;
;;; COMPREHENSIVE ANNEXURE MAP v6
;;;

(define-principle generate-comprehensive-annexure-map-v6
  #:name "Comprehensive Annexure Map Generation v6"
  #:confidence 0.98
  #:domain '(evidence-management)
  #:description "Generate comprehensive annexure recommendations with entity-relation linkage"
  
  #:naming-convention
  '(
    (format . "{RESPONDENT}-{CATEGORY}-{NUMBER}: {Description}")
    (respondent-codes . ("DAN" "JAX" "SHARED"))
    (category-codes . (
      "IT" "Technical infrastructure"
      "FIN" "Financial"
      "RP" "Responsible Person"
      "REG" "Regulatory"
      "IMPACT" "Business impact"
      "TIMELINE" "Temporal analysis"
      "COORD" "Coordination evidence"
      "ZONE" "RegimA Zone Ltd"
      "RYNETTE" "Rynette conflict"
      "DISCOVERY" "Discovery timing"
      "SETTLE" "Settlement"
      "RELIEF" "Interim relief"
    ))
  )
  
  #:annexure-registry
  '(
    ;; DAN'S ANNEXURES
    ("DAN-IT-01" . "Fraud report submission confirmation (2025-06-06)")
    ("DAN-IT-02" . "Card cancellation notification (2025-06-07)")
    ("DAN-IT-03" . "Technical infrastructure dependency matrix")
    ("DAN-IT-04" . "Business continuity impact assessment")
    ("DAN-IT-05" . "37-jurisdiction operational requirements")
    ("DAN-IT-06" . "Cloud services architecture diagram")
    ("DAN-IT-07" . "IT expense justification by category")
    ("DAN-IT-08" . "Emergency restoration costs (R50k-R75k personal funds)")
    
    ("DAN-FIN-01" . "Bank statements showing Peter's withdrawals (2023-2025)")
    ("DAN-FIN-02" . "Dan's payment documentation (2025-07-16)")
    ("DAN-FIN-03" . "Peter's post-criticism withdrawal (2025-07-20)")
    ("DAN-FIN-04" . "Accountant confirmation of established practice")
    ("DAN-FIN-05" . "Comparative analysis table (Peter vs Dan)")
    ("DAN-FIN-06" . "Hypocrisy timeline visualization")
    
    ("DAN-FIN-IMPACT-01" . "Account emptying documentation")
    ("DAN-FIN-IMPACT-02" . "Revenue disruption quantification")
    ("DAN-FIN-IMPACT-03" . "Emergency restoration costs")
    ("DAN-FIN-IMPACT-04" . "Business continuity costs")
    
    ("DAN-RP-01" . "Technical infrastructure for RP duties")
    ("DAN-RP-02" . "System access requirements analysis")
    ("DAN-RP-03" . "Operational impossibility technical assessment")
    
    ("DAN-ZONE-01" . "RegimA Zone Ltd ownership documentation")
    ("DAN-ZONE-02" . "Service relationship documentation")
    ("DAN-ZONE-03" . "Technical infrastructure services provided")
    ("DAN-ZONE-04" . "Related-party transaction justification")
    ("DAN-ZONE-05" . "Value exchange documentation")
    
    ("DAN-RYNETTE-01" . "Coordination timeline")
    ("DAN-RYNETTE-02" . "Documentation obstruction evidence")
    
    ("DAN-DISCOVERY-01" . "Discovery timeline analysis")
    ("DAN-DISCOVERY-02" . "Premeditation evidence")
    ("DAN-DISCOVERY-03" . "Manufactured crisis documentation")
    
    ("DAN-SETTLE-01" . "Settlement discussion witness account")
    ("DAN-SETTLE-02" . "False urgency analysis")
    
    ("DAN-RELIEF-01" . "Operational impossibility analysis")
    ("DAN-RELIEF-02" . "Technical access requirements")
    ("DAN-RELIEF-03" . "Business continuity impact")
    ("DAN-RELIEF-04" . "Balance of convenience analysis")
    
    ;; JAX'S ANNEXURES
    ("JAX-RP-01" . "EU Responsible Person appointment documentation")
    ("JAX-RP-02" . "Regulatory compliance requirements matrix")
    ("JAX-RP-03" . "System access dependencies for RP duties")
    ("JAX-RP-04" . "Regulatory compliance crisis impact assessment")
    ("JAX-RP-05" . "37-jurisdiction operational requirements")
    ("JAX-RP-06" . "Impossibility of alternative arrangements analysis")
    
    ("JAX-IMPACT-01" . "Revenue disruption quantification")
    ("JAX-IMPACT-02" . "Order removal documentation")
    
    ("JAX-FIN-01" . "Debt confrontation documentation")
    ("JAX-FIN-IMPACT-01" . "Revenue disruption analysis")
    ("JAX-FIN-IMPACT-02" . "Regulatory compliance costs")
    ("JAX-FIN-IMPACT-03" . "Business operations impact")
    ("JAX-FIN-IMPACT-04" . "Customer relationship harm")
    
    ("JAX-RYNETTE-01" . "Rynette's role documentation")
    ("JAX-RYNETTE-02" . "Debt documentation (R1,035,000)")
    ("JAX-RYNETTE-03" . "Confrontation timeline (2025-05-15)")
    ("JAX-RYNETTE-04" . "Order removal evidence (2025-05-22)")
    ("JAX-RYNETTE-05" . "Coordination evidence")
    
    ("JAX-DISCOVERY-01" . "Discovery timeline")
    ("JAX-DISCOVERY-02" . "Coordination evidence")
    
    ("JAX-SETTLE-01" . "Backdating document (2025-08-11)")
    ("JAX-SETTLE-02" . "Settlement discussion documentation")
    ("JAX-SETTLE-03" . "Interdict filing (2025-08-13)")
    ("JAX-SETTLE-04" . "Settlement Trojan horse timeline")
    ("JAX-SETTLE-05" . "Bad faith litigation evidence")
    
    ("JAX-RELIEF-01" . "Regulatory compliance crisis")
    ("JAX-RELIEF-02" . "RP duties impossibility")
    ("JAX-RELIEF-03" . "37-jurisdiction impact")
    ("JAX-RELIEF-04" . "Balance of convenience")
  ))

;;;
;;; LEGAL RESOLUTION CONFIDENCE CALCULATION v6
;;;

(define-principle compute-legal-resolution-confidence-v6
  #:name "Legal Resolution Confidence Calculation v6"
  #:confidence 0.99
  #:domain '(confidence-scoring)
  #:description "Compute overall legal resolution confidence with Bayesian updates"
  
  #:confidence-levels
  '(
    (0.95-1.00 . "Exceptional - Overwhelming evidence")
    (0.90-0.94 . "Very Strong - Clear preponderance")
    (0.85-0.89 . "Strong - Solid evidence base")
    (0.80-0.84 . "Good - Adequate evidence")
    (0.70-0.79 . "Moderate - Some gaps")
    (0.60-0.69 . "Weak - Significant gaps")
    (0.00-0.59 . "Insufficient - Major deficiencies")
  )
  
  #:bayesian-update-formula
  "P(H|E) = P(E|H) * P(H) / P(E)"
  
  #:confidence-factors
  '(
    (evidence-strength . 0.35)
    (temporal-correlation . 0.25)
    (pattern-consistency . 0.20)
    (expert-validation . 0.10)
    (cross-validation . 0.10)
  ))

;;;
;;; MATERIAL NON-DISCLOSURE IDENTIFICATION v6
;;;

(define-principle identify-material-non-disclosures-v6
  #:name "Material Non-Disclosure Identification v6"
  #:confidence 0.98
  #:domain '(disclosure-analysis)
  #:description "Identify material non-disclosures across all AD paragraphs"
  
  #:materiality-criteria
  '(
    (affects-jurisdiction . "Fact affects court's jurisdiction or competence")
    (affects-remedy . "Fact affects appropriateness or availability of remedy")
    (affects-balance-of-convenience . "Fact affects balance of convenience analysis")
    (affects-urgency . "Fact affects urgency assessment")
    (affects-credibility . "Fact affects party's credibility")
  )
  
  #:severity-scoring
  '(
    (0.95-1.00 . "Critical - Void ab initio potential")
    (0.90-0.94 . "Very High - Major impact on case")
    (0.85-0.89 . "High - Significant impact")
    (0.80-0.84 . "Moderate - Notable impact")
    (0.00-0.79 . "Low - Minor impact")
  ))

;;;
;;; TEMPORAL CAUSATION CHAIN ANALYSIS v6
;;;

(define-principle analyze-temporal-causation-chains-v6
  #:name "Temporal Causation Chain Analysis v6"
  #:confidence 0.97
  #:domain '(causation-analysis)
  #:description "Analyze temporal causation chains with confidence propagation"
  
  #:causation-criteria
  '(
    (temporal-proximity . "Events occur in close temporal proximity")
    (logical-connection . "Logical connection between events")
    (actor-motivation . "Clear actor motivation")
    (pattern-consistency . "Consistent with established patterns")
    (alternative-explanation . "Lack of plausible alternative explanation")
  )
  
  #:confidence-propagation
  "Confidence propagates through causation chain with decay factor"
  
  #:decay-factor 0.95)

;;; End of module
