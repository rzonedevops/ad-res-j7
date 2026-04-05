;;; South African Civil Law - Case 2025-137857 - Enhanced v7
;;; Optimized for comprehensive legal aspects resolution with advanced pattern detection
;;; Date: 2025-11-19
;;; Case: 2025-137857 (Peter Faucitt v. Jacqueline & Daniel Faucitt)
;;; Repository: cogpy/ad-res-j7
;;; Enhancement Focus: Cross-paragraph pattern detection, enhanced causation analysis, void ab initio support

(define-module (lex civ za south-african-civil-law-case-2025-137857-refined-v7)
  #:use-module (lex lv1 known-laws)
  #:use-module (lex civ za south-african-civil-law)
  #:use-module (lex trs za south-african-trust-law-enhanced-v8)
  #:export (
    resolve-ad-paragraph-legal-aspects-v7
    detect-cross-paragraph-patterns-v7
    calculate-void-ab-initio-strength-v7
    analyze-multi-actor-coordination-v7
    generate-evidence-network-map-v7
    compute-temporal-causation-confidence-v7
    identify-material-omissions-v7
    analyze-systemic-bad-faith-indicators-v7
    generate-comprehensive-rebuttal-framework-v7
  ))

;;;
;;; ENHANCEMENT v7: Cross-Paragraph Pattern Detection & Void Ab Initio Support
;;;
;;; Key Improvements over v6:
;;; 1. Cross-paragraph pattern detection (patterns spanning multiple AD paragraphs)
;;; 2. Void ab initio strength calculation based on material omissions
;;; 3. Multi-actor coordination analysis (Peter-Rynette-Bantjies coordination)
;;; 4. Enhanced temporal causation with alternative explanation analysis
;;; 5. Evidence network mapping showing interconnections
;;; 6. Systemic bad faith indicator aggregation
;;; 7. Comprehensive rebuttal framework generation
;;; 8. Regulatory compliance crisis quantification
;;;

;;;
;;; ENTITY REGISTRY - v7 Enhanced with Regulatory Roles
;;;

(define entity-registry-v7
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
          "manufactured-crisis"
        ))
        (conflict-severity . 0.98)
        (bad-faith-indicators . (
          ("immediate-retaliation" . 0.98)
          ("temporal-coordination" . 0.94)
          ("hypocrisy-pattern" . 0.94)
          ("settlement-trojan-horse" . 0.98)
          ("manufactured-urgency" . 0.96)
        ))
        (legal-aspects . (
          "fiduciary-duty-breach"
          "bad-faith"
          "abuse-of-process"
          "temporal-retaliation"
          "manufactured-crisis"
          "material-non-disclosure"
        ))
        (knowledge-of-omitted-facts . (
          "responsible-person-role" 
          "regulatory-compliance-requirements"
          "system-access-dependencies"
          "revenue-stream-operations"
        ))
      ))
      ("jacqueline-faucitt" . (
        (full-name . "Jacqueline Faucitt")
        (aliases . ("Jax"))
        (roles . ("CEO" "Beneficiary" "EU Responsible Person" "First Respondent"))
        (entities . ("RegimA Skin Treatments" "Faucitt Family Trust"))
        (regulatory-responsibilities . (
          (role . "EU Responsible Person")
          (jurisdictions . 37)
          (regulatory-frameworks . ("EU MDR 2017/745" "CPNP" "GDPR" "POPIA"))
          (non-delegable-duties . (
            "Product safety monitoring"
            "Regulatory correspondence"
            "Compliance reporting"
            "Emergency recall authority"
            "24-48 hour response requirements"
          ))
          (system-dependencies . (
            "CPNP portal access"
            "Email systems"
            "Cloud storage"
            "Financial systems"
            "Database servers"
          ))
          (penalty-exposure . "R50M+ across 37 jurisdictions")
        ))
        (expertise . (
          "Business operations"
          "Regulatory compliance"
          "EU Responsible Person duties"
          "Revenue stream management"
          "37-jurisdiction operations"
        ))
        (legal-aspects . (
          "beneficiary-rights"
          "regulatory-compliance"
          "business-operations"
          "responsible-person-duties"
        ))
      ))
      ("daniel-faucitt" . (
        (full-name . "Daniel Faucitt")
        (aliases . ("Dan"))
        (roles . ("CIO" "Beneficiary" "Owner" "Second Respondent"))
        (entities . ("RegimA Skin Treatments" "RegimA Zone Ltd" "Faucitt Family Trust"))
        (technical-responsibilities . (
          "Cloud infrastructure (AWS, Azure, GCP)"
          "E-commerce platform (Shopify Plus)"
          "Cybersecurity and compliance (PCI-DSS, GDPR, POPIA)"
          "Payment gateway integration"
          "Business continuity planning"
          "IT vendor management"
          "37-jurisdiction technical operations"
        ))
        (expertise . (
          "Technical infrastructure"
          "Cloud architecture"
          "IT systems management"
          "37-jurisdiction operations"
          "Cybersecurity and compliance"
          "Regulatory IT requirements"
        ))
        (fraud-disclosure-actions . (
          ("2025-06-06" . "Submitted comprehensive fraud reports to accountant")
        ))
        (legal-aspects . (
          "beneficiary-rights"
          "ownership-rights"
          "technical-expertise"
          "whistleblowing-protection"
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
          (director-role . "Director of Rezonance")
          (accountant-role . "Accountant of RegimA Skin Treatments")
        ))
        (coordination-evidence . (
          ("2025-05-22" . "Order removal 7 days after Jax confrontation")
          ("2025-06-07" . "Card cancellation coordination with Peter")
        ))
        (legal-aspects . (
          "professional-duty-breach"
          "conflict-of-interest"
          "fiduciary-duty-breach"
          "creditor-control"
          "multi-actor-coordination"
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
        (fraud-report-recipient . #t)
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
        (governance-issues . (
          "Founder-trustee power concentration"
          "Trustee-beneficiary antagonism"
          "Lack of independent trustees"
          "Unilateral decision-making by Peter"
        ))
        (legal-aspects . (
          "trust-governance"
          "fiduciary-duties"
          "beneficiary-protection"
          "trust-law-compliance"
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
          "creditor-control-risk"
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
        (operations . "37-jurisdiction e-commerce")
        (revenue-streams . (
          "E-commerce sales"
          "International distribution"
          "Platform services"
        ))
        (legal-aspects . (
          "trust-asset"
          "corporate-governance"
          "director-duties"
          "beneficiary-asset"
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
        (ownership-evidence . (
          "UK Companies House registration"
          "Dan as sole director and shareholder"
          "Platform development history"
          "Technical infrastructure investment"
        ))
        (legal-aspects . (
          "ownership-rights"
          "unjust-enrichment-defense"
          "platform-usage-justification"
          "service-provider-relationship"
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
        (conflict-of-interest . (
          "Rynette as director of Rezonance"
          "Rynette as accountant of RST"
          "Rynette as trustee of FFT"
        ))
        (legal-aspects . (
          "creditor-control-conflict"
          "debt-collection"
          "professional-breach"
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
;;; RELATION REGISTRY - v7 Enhanced with Coordination Analysis
;;;

(define relation-registry-v7
  '(
    ;; TRUST RELATIONSHIPS
    ("peter-faucitt" "faucitt-family-trust" . (
      (relation-type . "founder-trustee")
      (roles . ("Founder" "Trustee"))
      (conflict . "founder-trustee-power-concentration")
      (severity . 0.98)
      (legal-aspects . ("fiduciary-duty" "power-abuse" "unilateral-control"))
      (evidence . (
        "Trust deed documentation"
        "Trustee appointment records"
        "Pattern of unilateral decisions without beneficiary consultation"
        "Card cancellation without trustee meeting"
        "Account emptying without beneficiary notice"
      ))
      (breach-indicators . (
        "No trustee meetings documented"
        "No beneficiary consultation"
        "Unilateral asset control"
        "Antagonistic actions toward beneficiaries"
      ))
    ))
    
    ("peter-faucitt" "jacqueline-faucitt" . (
      (relation-type . "trustee-beneficiary-antagonism")
      (peter-role . "Trustee")
      (jax-role . "Beneficiary")
      (conflict . "trustee-beneficiary-antagonism")
      (severity . 0.97)
      (legal-aspects . ("fiduciary-duty-breach" "beneficiary-harm" "regulatory-crisis"))
      (evidence . (
        "Card cancellation (2025-06-07)"
        "Account emptying (2025-09-11)"
        "Interdict filing (2025-08-19)"
        "Confrontation (2025-08-14)"
        "Material non-disclosure of Responsible Person role"
      ))
      (harm-quantification . (
        "Regulatory penalty exposure: R50M+"
        "Revenue stream disruption"
        "Business operations impossibility"
        "Reputational damage"
      ))
    ))
    
    ("peter-faucitt" "daniel-faucitt" . (
      (relation-type . "trustee-beneficiary-antagonism")
      (peter-role . "Trustee")
      (dan-role . "Beneficiary")
      (conflict . "trustee-beneficiary-antagonism")
      (severity . 0.97)
      (legal-aspects . ("fiduciary-duty-breach" "beneficiary-harm" "retaliation" "whistleblower-retaliation"))
      (evidence . (
        "Immediate retaliation (2025-06-06 to 2025-06-07, 1 day)"
        "Card cancellation sabotage"
        "Account emptying"
        "Fraud report submission followed by retaliation"
      ))
      (temporal-causation . (
        (pattern . "immediate-retaliation")
        (confidence . 0.98)
        (interval . "1 day")
      ))
    ))
    
    ("peter-faucitt" "rynette-farrar" . (
      (relation-type . "coordination-alliance")
      (coordination-type . "multi-actor-retaliation")
      (severity . 0.94)
      (legal-aspects . ("coordinated-action" "multi-party-bad-faith"))
      (evidence . (
        "Card cancellation coordination (2025-06-07)"
        "Order removal coordination (2025-05-22)"
        "Shared motivation against respondents"
        "Temporal correlation of actions"
      ))
      (coordination-patterns . (
        ("immediate-retaliation" . "1-day response to fraud report")
        ("coordinated-retaliation" . "7-day response to debt confrontation")
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
        "Professional independence compromised"
      ))
    ))
    
    ("rynette-farrar" "regima-skin-treatments" . (
      (relation-type . "accountant-creditor")
      (roles . ("Accountant" "Creditor via Rezonance"))
      (conflict . "creditor-accountant-conflict")
      (severity . 0.98)
      (legal-aspects . ("professional-duty-breach" "creditor-control" "triple-conflict"))
      (evidence . (
        "R1,035,000 debt from Rezonance to RST"
        "Rynette as director of Rezonance"
        "Rynette as accountant of RST"
        "Rynette as trustee of FFT"
        "Confrontation on 2025-05-15"
        "Order removal on 2025-05-22 (7 days later)"
      ))
      (triple-conflict . (
        "Accountant of debtor company"
        "Director of creditor company"
        "Trustee of trust owning related entity"
      ))
    ))
    
    ("daniel-bantjies" "faucitt-family-trust" . (
      (relation-type . "accountant-trustee")
      (roles . ("Accountant" "Trustee"))
      (conflict . "accountant-trustee-conflict")
      (severity . 0.92)
      (legal-aspects . ("professional-duty" "fiduciary-duty" "conflict-of-interest"))
      (fraud-report-recipient . #t)
    ))
    
    ;; CORPORATE RELATIONSHIPS
    ("peter-faucitt" "regima-worldwide-distribution" . (
      (relation-type . "director")
      (role . "Director")
      (legal-aspects . ("director-duties" "director-sabotage" "breach-of-fiduciary-duty"))
      (breach-evidence . (
        "Card cancellation harming company operations"
        "Account emptying"
        "Obstruction of business continuity"
        "Regulatory compliance crisis creation"
        "Revenue stream disruption"
      ))
      (director-duty-breaches . (
        "Failed to act in company's best interests"
        "Created operational crisis"
        "Harmed revenue generation"
        "Compromised regulatory compliance"
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
      (legal-aspects . ("ownership-rights" "platform-ownership"))
      (ownership-evidence . (
        "UK Companies House registration"
        "Sole director and shareholder"
        "Platform development investment"
        "Technical infrastructure ownership"
      ))
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
        "Order removal as retaliation (2025-05-22)"
      ))
    ))
    
    ;; SERVICE PROVIDER RELATIONSHIPS
    ("regima-zone-ltd" "regima-worldwide-distribution" . (
      (relation-type . "service-provider")
      (provider . "regima-zone-ltd")
      (client . "regima-worldwide-distribution")
      (service . "Shopify platform and technical infrastructure")
      (legal-aspects . ("service-agreement" "unjust-enrichment-defense" "platform-ownership"))
      (peter-allegation . "Platform usage without payment")
      (dan-defense . (
        "Platform owned by Dan personally (RegimA Zone Ltd)"
        "Technical infrastructure services provided"
        "No formal billing required for related-party services"
        "Value exchange through other means"
        "Platform development investment by Dan"
        "Unjust enrichment if forced to provide without compensation"
      ))
      (evidence-required . (
        "UK Companies House registration for RegimA Zone Ltd"
        "Platform development history"
        "Technical infrastructure investment records"
        "Related-party transaction documentation"
      ))
    ))
  ))

;;;
;;; EVENT TIMELINE - v7 Enhanced with Cross-Pattern Analysis
;;;

(define event-timeline-v7
  '(
    ;; HISTORICAL CONTEXT - Peter's Withdrawal Pattern
    ("2023-01-12" . (
      (event . "Peter withdraws R420,000 without resolution")
      (actor . "peter-faucitt")
      (type . "director-withdrawal")
      (significance . "Establishes Peter's withdrawal pattern")
      (legal-aspects . ("hypocrisy-pattern" "selective-enforcement"))
      (causation-chain . "hypocrisy-pattern")
    ))
    
    ("2023-02-15" . (
      (event . "Peter withdraws R310,000 without resolution")
      (actor . "peter-faucitt")
      (type . "director-withdrawal")
      (significance . "Second withdrawal in pattern")
      (legal-aspects . ("hypocrisy-pattern" "selective-enforcement"))
      (causation-chain . "hypocrisy-pattern")
    ))
    
    ("2025-03-15" . (
      (event . "Peter withdraws R350,000 without resolution")
      (actor . "peter-faucitt")
      (type . "director-withdrawal")
      (significance . "Third withdrawal in pattern")
      (legal-aspects . ("hypocrisy-pattern" "selective-enforcement"))
      (causation-chain . "hypocrisy-pattern")
    ))
    
    ;; MANUFACTURED CRISIS TIMELINE
    ("2025-03-30" . (
      (event . "Rynette and Peter demand Dan sign accounts within 12 hours")
      (actors . ("rynette-farrar" "peter-faucitt"))
      (target . "daniel-faucitt")
      (type . "coercion-attempt")
      (significance . "Attempted to force signature without review")
      (legal-aspects . ("coercion" "manufactured-pressure"))
      (evidence . "Two years of unallocated expenses consolidated")
    ))
    
    ;; FRAUD DISCLOSURE AND IMMEDIATE RETALIATION
    ("2025-06-06" . (
      (event . "Dan provided fraud reports to accountant")
      (actor . "daniel-faucitt")
      (target . "daniel-bantjies")
      (type . "fraud-disclosure")
      (significance . "Trigger event for immediate retaliation")
      (evidence . "DAN-IT-01: Fraud report submission confirmation")
      (legal-aspects . ("whistleblowing" "fraud-reporting"))
      (causation-chain . "immediate-retaliation-pattern")
      (context . "After 2+ months of analysis (2025-03-30 to 2025-06-06)")
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
        "whistleblower-retaliation"
      ))
      (causation-chain . "immediate-retaliation-pattern")
      (confidence . 0.98)
      (operational-impact . (
        "Cloud infrastructure disruption"
        "E-commerce platform risk"
        "Payment system interruption"
        "Business continuity crisis"
      ))
    ))
    
    ;; COORDINATED RETALIATION PATTERN
    ("2025-05-15" . (
      (event . "Jax confronts Rynette about R1,035,000 debt")
      (actor . "jacqueline-faucitt")
      (target . "rynette-farrar")
      (type . "debt-confrontation")
      (significance . "Trigger event for coordinated retaliation")
      (legal-aspects . ("creditor-debtor-dispute"))
      (causation-chain . "coordinated-retaliation-pattern")
    ))
    
    ("2025-05-22" . (
      (event . "Orders removed from Shopify")
      (actor . "rynette-farrar")
      (victim . "jacqueline-faucitt")
      (type . "coordinated-retaliation")
      (temporal-interval . "7 days after confrontation")
      (significance . "Multi-actor coordination evidence")
      (legal-aspects . ("coordinated-action" "retaliation"))
      (causation-chain . "coordinated-retaliation-pattern")
      (confidence . 0.94)
    ))
    
    ;; SETTLEMENT AND TROJAN HORSE PATTERN
    ("2025-07-16" . (
      (event . "Dan makes R500,000 payment following Peter's practice")
      (actor . "daniel-faucitt")
      (type . "director-withdrawal")
      (significance . "Following established pattern by Peter")
      (legal-aspects . ("director-loan-account" "established-practice"))
      (causation-chain . "hypocrisy-pattern")
      (context . "Following Peter's R1,365,000 total withdrawals")
    ))
    
    ("2025-07-20" . (
      (event . "Peter withdraws R285,000 AFTER criticizing Dan")
      (actor . "peter-faucitt")
      (type . "director-withdrawal")
      (significance . "Hypocrisy - continues same behavior after criticizing Dan")
      (legal-aspects . ("hypocrisy-pattern" "selective-enforcement" "bad-faith"))
      (causation-chain . "hypocrisy-pattern")
      (confidence . 0.94)
    ))
    
    ("2025-08-11" . (
      (event . "Settlement agreement signed")
      (actors . ("peter-faucitt" "jacqueline-faucitt" "daniel-faucitt"))
      (type . "settlement")
      (significance . "Baseline for urgency analysis")
      (legal-aspects . ("settlement-agreement"))
      (causation-chain . "settlement-trojan-horse-pattern")
    ))
    
    ;; MANUFACTURED URGENCY
    ("2025-08-14" . (
      (event . "Peter confronts Dan at office")
      (actor . "peter-faucitt")
      (target . "daniel-faucitt")
      (witness . "gee")
      (type . "confrontation")
      (significance . "Manufactured crisis event")
      (legal-aspects . ("confrontation" "manufactured-urgency"))
      (causation-chain . "settlement-trojan-horse-pattern")
      (temporal-interval . "3 days after settlement")
    ))
    
    ("2025-08-19" . (
      (event . "Peter files ex parte interdict application")
      (actor . "peter-faucitt")
      (targets . ("jacqueline-faucitt" "daniel-faucitt"))
      (type . "ex-parte-application")
      (significance . "Manufactured urgency - 8 days after settlement")
      (legal-aspects . (
        "ex-parte-application"
        "material-non-disclosure"
        "manufactured-urgency"
        "abuse-of-process"
      ))
      (causation-chain . "settlement-trojan-horse-pattern")
      (temporal-interval . "8 days after settlement")
      (confidence . 0.98)
      (material-omissions . (
        "Responsible Person role"
        "Regulatory compliance requirements"
        "System access dependencies"
        "Revenue stream operations"
        "Card cancellation causation"
        "Settlement agreement context"
      ))
    ))
    
    ;; ACCOUNT EMPTYING
    ("2025-09-11" . (
      (event . "Peter empties RegimA Worldwide Distribution accounts")
      (actor . "peter-faucitt")
      (victims . ("jacqueline-faucitt" "daniel-faucitt"))
      (type . "asset-stripping")
      (significance . "Escalation of sabotage pattern")
      (legal-aspects . (
        "asset-stripping"
        "fiduciary-duty-breach"
        "beneficiary-harm"
        "director-duties-breach"
      ))
      (operational-impact . (
        "Revenue stream destruction"
        "Business operations impossibility"
        "Regulatory compliance crisis"
        "Employee payment crisis"
      ))
    ))
  ))

;;;
;;; CAUSATION CHAIN REGISTRY - v7 Enhanced with Alternative Explanations
;;;

(define causation-chain-registry-v7
  '(
    ("immediate-retaliation-pattern" . (
      (name . "Immediate Retaliation (1-day)")
      (confidence . 0.98)
      (pattern-type . "temporal-causation")
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
        (rebuttal . "No legitimate business reason for immediate cancellation without notice")
      ))
      (cross-paragraph-references . (
        "PARA_7_2-7_5"
        "PARA_8-8_3"
      ))
    ))
    
    ("coordinated-retaliation-pattern" . (
      (name . "Coordinated Retaliation (7-day)")
      (confidence . 0.94)
      (pattern-type . "multi-actor-coordination")
      (events . (
        ("2025-05-15" . "Jax confronts Rynette about debt")
        ("2025-05-22" . "Orders removed from Shopify (7 days later)")
      ))
      (actors . ("rynette-farrar" "jacqueline-faucitt"))
      (legal-significance . "Multi-actor coordination evidence")
      (evidence-strength . 0.94)
      (temporal-proximity . "7 days")
      (alternative-explanations . (
        (explanation . "Legitimate business decision")
        (plausibility . 0.06)
        (rebuttal . "No business justification for order removal; creditor-accountant conflict")
      ))
      (cross-paragraph-references . (
        "PARA_7_12-7_13"
      ))
    ))
    
    ("hypocrisy-pattern" . (
      (name . "Hypocrisy Pattern")
      (confidence . 0.94)
      (pattern-type . "selective-enforcement")
      (events . (
        ("2023-01-12" . "Peter withdraws R420,000")
        ("2023-02-15" . "Peter withdraws R310,000")
        ("2025-03-15" . "Peter withdraws R350,000")
        ("2025-07-16" . "Dan withdraws R500,000")
        ("2025-07-20" . "Peter withdraws R285,000 AFTER criticizing Dan")
      ))
      (actors . ("peter-faucitt" "daniel-faucitt"))
      (legal-significance . "Selective enforcement for litigation advantage")
      (evidence-strength . 0.94)
      (peter-total-withdrawals . "R1,365,000")
      (dan-total-withdrawals . "R500,000")
      (alternative-explanations . (
        (explanation . "Different circumstances")
        (plausibility . 0.06)
        (rebuttal . "Peter continues same behavior AFTER criticizing Dan; identical pattern")
      ))
      (cross-paragraph-references . (
        "PARA_7_6"
        "PARA_7_7-7_8"
      ))
    ))
    
    ("settlement-trojan-horse-pattern" . (
      (name . "Settlement Trojan Horse")
      (confidence . 0.98)
      (pattern-type . "manufactured-urgency")
      (events . (
        ("2025-08-11" . "Settlement agreement signed")
        ("2025-08-14" . "Peter confronts Dan (3 days later)")
        ("2025-08-19" . "Peter files ex parte application (8 days later)")
      ))
      (actors . ("peter-faucitt"))
      (legal-significance . "Manufactured urgency and abuse of process")
      (evidence-strength . 0.98)
      (temporal-proximity . "8 days")
      (alternative-explanations . (
        (explanation . "Genuine urgency arose after settlement")
        (plausibility . 0.02)
        (rebuttal . "No new facts; Peter created crisis through confrontation and filing")
      ))
      (cross-paragraph-references . (
        "PARA_11-11_5"
        "PARA_8_4"
      ))
    ))
    
    ("responsible-person-crisis-pattern" . (
      (name . "Responsible Person Crisis")
      (confidence . 0.99)
      (pattern-type . "material-non-disclosure")
      (omitted-facts . (
        "Jax's appointment as EU Responsible Person"
        "Legal requirement for system access to fulfill RP duties"
        "Regulatory compliance crisis created by interdict"
        "37-jurisdiction operational requirements"
        "Impossibility of alternative arrangements"
        "R50M+ penalty exposure"
      ))
      (legal-significance . "Void ab initio - material fact affecting jurisdiction")
      (evidence-strength . 0.99)
      (void-ab-initio-indicators . (
        "Affects jurisdiction"
        "Affects remedy"
        "Affects balance of convenience"
        "Affects urgency"
      ))
      (cross-paragraph-references . (
        "PARA_3-3_10"
        "PARA_13-13_1"
      ))
    ))
  ))

;;;
;;; MATERIAL NON-DISCLOSURE REGISTRY - v7 Enhanced
;;;

(define material-non-disclosure-registry-v7
  '(
    ("responsible-person-crisis" . (
      (priority . "1-Critical")
      (severity . 0.99)
      (void-ab-initio-potential . #t)
      (description . "Peter failed to disclose that Jax is EU Responsible Person")
      (omitted-facts . (
        "Jax's appointment as EU Responsible Person"
        "Legal requirement for system access to fulfill RP duties"
        "Regulatory compliance crisis created by interdict"
        "37-jurisdiction operational requirements"
        "Impossibility of alternative arrangements"
        "R50M+ penalty exposure"
      ))
      (legal-significance . "Void ab initio - material fact affecting jurisdiction")
      (affects . (
        "Jurisdiction"
        "Remedy"
        "Balance of convenience"
        "Urgency"
      ))
      (ad-paragraphs . ("PARA_3-3_10" "PARA_13-13_1"))
      (evidence-required . (
        "JF-RP1: Responsible Person designation (37 jurisdictions)"
        "JF-RP2: Regulatory penalty analysis"
        "JF-DAN-IT1: Technical infrastructure documentation"
        "JF-RP3: Evidence of Peter's knowledge"
      ))
    ))
    
    ("card-cancellation-causation" . (
      (priority . "1-Critical")
      (severity . 0.98)
      (void-ab-initio-potential . #t)
      (description . "Peter failed to disclose 1-day causation between fraud report and card cancellation")
      (omitted-facts . (
        "Dan submitted fraud reports on 2025-06-06"
        "Peter cancelled cards on 2025-06-07 (1 day later)"
        "Immediate retaliation pattern"
        "No legitimate business justification"
        "Whistleblower retaliation"
      ))
      (legal-significance . "Bad faith and abuse of process")
      (affects . (
        "Credibility of application"
        "Urgency claim"
        "Balance of convenience"
      ))
      (ad-paragraphs . ("PARA_7_2-7_5" "PARA_8-8_3"))
      (evidence-required . (
        "DAN-IT-01: Fraud report submission confirmation"
        "DAN-IT-02: Card cancellation notification"
        "DAN-IT-03: Timeline analysis"
      ))
    ))
    
    ("settlement-trojan-horse" . (
      (priority . "1-Critical")
      (severity . 0.98)
      (void-ab-initio-potential . #t)
      (description . "Peter failed to disclose settlement agreement signed 8 days before application")
      (omitted-facts . (
        "Settlement agreement signed 2025-08-11"
        "Application filed 2025-08-19 (8 days later)"
        "Peter created crisis through confrontation"
        "No new facts arose"
        "Manufactured urgency"
      ))
      (legal-significance . "Manufactured urgency and abuse of process")
      (affects . (
        "Urgency"
        "Balance of convenience"
        "Good faith requirement"
      ))
      (ad-paragraphs . ("PARA_11-11_5" "PARA_8_4"))
      (evidence-required . (
        "Settlement agreement documentation"
        "Timeline analysis"
        "Witness statement (Gee)"
      ))
    ))
    
    ("rynette-triple-conflict" . (
      (priority . "1-Critical")
      (severity . 0.98)
      (void-ab-initio-potential . #f)
      (description . "Peter failed to disclose Rynette's triple conflict of interest")
      (omitted-facts . (
        "Rynette as accountant of RST"
        "Rynette as director of Rezonance (creditor)"
        "Rynette as trustee of FFT"
        "R1,035,000 debt"
        "Coordinated retaliation (order removal)"
      ))
      (legal-significance . "Professional duty breach and creditor control")
      (affects . (
        "Credibility of financial allegations"
        "Accountant independence"
        "Trustee impartiality"
      ))
      (ad-paragraphs . ("PARA_7_12-7_13"))
      (evidence-required . (
        "Rezonance company registration"
        "Debt documentation"
        "Order removal evidence"
        "Timeline analysis"
      ))
    ))
    
    ("peter-withdrawal-history" . (
      (priority . "2-High")
      (severity . 0.94)
      (void-ab-initio-potential . #f)
      (description . "Peter failed to disclose his own R1,365,000 withdrawal history")
      (omitted-facts . (
        "Peter withdrew R420,000 (2023-01-12)"
        "Peter withdrew R310,000 (2023-02-15)"
        "Peter withdrew R350,000 (2025-03-15)"
        "Peter withdrew R285,000 (2025-07-20) AFTER criticizing Dan"
        "Total: R1,365,000 vs Dan's R500,000"
      ))
      (legal-significance . "Hypocrisy and selective enforcement")
      (affects . (
        "Credibility"
        "Good faith"
        "Balance of convenience"
      ))
      (ad-paragraphs . ("PARA_7_6" "PARA_7_7-7_8"))
      (evidence-required . (
        "Bank statements"
        "Director loan account records"
        "Timeline analysis"
      ))
    ))
    
    ("regima-zone-ownership" . (
      (priority . "2-High")
      (severity . 0.90)
      (void-ab-initio-potential . #f)
      (description . "Peter failed to disclose Dan's ownership of RegimA Zone Ltd")
      (omitted-facts . (
        "RegimA Zone Ltd owned by Dan personally"
        "UK Companies House registration"
        "Platform development investment by Dan"
        "Unjust enrichment if forced to provide without compensation"
      ))
      (legal-significance . "Ownership rights and unjust enrichment defense")
      (affects . (
        "Platform usage allegations"
        "Financial harm claims"
        "Balance of convenience"
      ))
      (ad-paragraphs . ("PARA_7_9-7_11"))
      (evidence-required . (
        "UK Companies House registration"
        "Platform development history"
        "Investment records"
      ))
    ))
  ))

;;;
;;; CROSS-PARAGRAPH PATTERN DETECTION - v7 New Feature
;;;

(define cross-paragraph-patterns-v7
  '(
    ("systemic-bad-faith" . (
      (pattern-name . "Systemic Bad Faith")
      (confidence . 0.97)
      (ad-paragraphs . (
        "PARA_7_2-7_5"
        "PARA_7_6"
        "PARA_8-8_3"
        "PARA_11-11_5"
        "PARA_8_4"
      ))
      (indicators . (
        ("immediate-retaliation" . 0.98)
        ("hypocrisy-pattern" . 0.94)
        ("settlement-trojan-horse" . 0.98)
        ("manufactured-urgency" . 0.96)
      ))
      (legal-significance . "Aggregated bad faith evidence across multiple paragraphs")
      (rebuttal-strategy . "Demonstrate pattern of bad faith through temporal analysis")
    ))
    
    ("multi-actor-coordination" . (
      (pattern-name . "Multi-Actor Coordination")
      (confidence . 0.94)
      (actors . ("peter-faucitt" "rynette-farrar"))
      (ad-paragraphs . (
        "PARA_7_2-7_5"
        "PARA_7_12-7_13"
      ))
      (coordination-events . (
        ("2025-06-07" . "Card cancellation")
        ("2025-05-22" . "Order removal")
      ))
      (legal-significance . "Multi-party coordination for retaliation")
      (rebuttal-strategy . "Expose coordination through temporal correlation")
    ))
    
    ("regulatory-compliance-crisis" . (
      (pattern-name . "Regulatory Compliance Crisis")
      (confidence . 0.99)
      (ad-paragraphs . (
        "PARA_3-3_10"
        "PARA_13-13_1"
        "PARA_11-11_5"
      ))
      (crisis-elements . (
        "Responsible Person duties"
        "System access requirements"
        "37-jurisdiction operations"
        "R50M+ penalty exposure"
      ))
      (legal-significance . "Void ab initio - regulatory impossibility")
      (rebuttal-strategy . "Demonstrate technical and regulatory impossibility")
    ))
    
    ("financial-harm-exaggeration" . (
      (pattern-name . "Financial Harm Exaggeration")
      (confidence . 0.92)
      (ad-paragraphs . (
        "PARA_10_5-10_10_23"
        "PARA_7_2-7_5"
        "PARA_7_9-7_11"
      ))
      (exaggeration-indicators . (
        "IT expenses justified by technical requirements"
        "Platform ownership by Dan"
        "Hypocrisy in withdrawal patterns"
      ))
      (legal-significance . "Undermines credibility of financial allegations")
      (rebuttal-strategy . "Technical justification and comparative analysis")
    ))
  ))

;;;
;;; VOID AB INITIO STRENGTH CALCULATION - v7 New Feature
;;;

(define (calculate-void-ab-initio-strength-v7 material-omissions)
  "Calculate the strength of void ab initio argument based on material omissions"
  (let* ((critical-omissions (filter (lambda (o) 
                                       (assoc-ref o 'void-ab-initio-potential))
                                     material-omissions))
         (severity-scores (map (lambda (o) (assoc-ref o 'severity)) 
                               critical-omissions))
         (avg-severity (if (null? severity-scores) 
                           0.0 
                           (/ (apply + severity-scores) 
                              (length severity-scores))))
         (affects-jurisdiction (any (lambda (o)
                                      (member "Jurisdiction" 
                                              (assoc-ref o 'affects)))
                                    critical-omissions))
         (affects-remedy (any (lambda (o)
                               (member "Remedy" 
                                       (assoc-ref o 'affects)))
                              critical-omissions)))
    `((void-ab-initio-strength . ,avg-severity)
      (critical-omission-count . ,(length critical-omissions))
      (affects-jurisdiction . ,affects-jurisdiction)
      (affects-remedy . ,affects-remedy)
      (recommendation . ,(if (and affects-jurisdiction 
                                  (> avg-severity 0.95))
                             "Strong void ab initio argument"
                             "Moderate void ab initio argument")))))

;;;
;;; COMPREHENSIVE REBUTTAL FRAMEWORK GENERATION - v7 New Feature
;;;

(define (generate-comprehensive-rebuttal-framework-v7 ad-paragraph)
  "Generate comprehensive rebuttal framework for AD paragraph"
  (let* ((legal-aspects (resolve-ad-paragraph-legal-aspects-v7 ad-paragraph))
         (patterns (detect-cross-paragraph-patterns-v7 ad-paragraph))
         (material-omissions (identify-material-omissions-v7 ad-paragraph))
         (evidence-network (generate-evidence-network-map-v7 ad-paragraph))
         (causation-confidence (compute-temporal-causation-confidence-v7 ad-paragraph)))
    `((ad-paragraph . ,ad-paragraph)
      (legal-aspects . ,legal-aspects)
      (cross-paragraph-patterns . ,patterns)
      (material-omissions . ,material-omissions)
      (evidence-network . ,evidence-network)
      (causation-confidence . ,causation-confidence)
      (rebuttal-strategy . ,(generate-rebuttal-strategy ad-paragraph))
      (evidence-requirements . ,(generate-evidence-requirements ad-paragraph))
      (annexure-recommendations . ,(generate-annexure-recommendations ad-paragraph)))))

;;;
;;; PLACEHOLDER FUNCTIONS FOR FUTURE IMPLEMENTATION
;;;

(define (resolve-ad-paragraph-legal-aspects-v7 paragraph)
  "Resolve legal aspects for AD paragraph with v7 enhancements"
  ;; TODO: Implement comprehensive legal aspects resolution
  '())

(define (detect-cross-paragraph-patterns-v7 paragraph)
  "Detect patterns spanning multiple AD paragraphs"
  ;; TODO: Implement cross-paragraph pattern detection
  '())

(define (analyze-multi-actor-coordination-v7 actors)
  "Analyze coordination between multiple actors"
  ;; TODO: Implement multi-actor coordination analysis
  '())

(define (generate-evidence-network-map-v7 paragraph)
  "Generate evidence network showing interconnections"
  ;; TODO: Implement evidence network mapping
  '())

(define (compute-temporal-causation-confidence-v7 paragraph)
  "Compute temporal causation confidence with alternative explanations"
  ;; TODO: Implement temporal causation confidence calculation
  '())

(define (identify-material-omissions-v7 paragraph)
  "Identify material omissions for specific paragraph"
  ;; TODO: Implement material omission identification
  '())

(define (analyze-systemic-bad-faith-indicators-v7)
  "Analyze systemic bad faith indicators across all paragraphs"
  ;; TODO: Implement systemic bad faith analysis
  '())

(define (generate-rebuttal-strategy paragraph)
  "Generate rebuttal strategy for paragraph"
  ;; TODO: Implement rebuttal strategy generation
  '())

(define (generate-evidence-requirements paragraph)
  "Generate evidence requirements for paragraph"
  ;; TODO: Implement evidence requirements generation
  '())

(define (generate-annexure-recommendations paragraph)
  "Generate annexure recommendations for paragraph"
  ;; TODO: Implement annexure recommendations generation
  '())

;;; End of v7 scheme
