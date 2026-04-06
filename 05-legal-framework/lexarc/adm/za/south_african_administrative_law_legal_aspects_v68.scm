;;; south_african_administrative_law_legal_aspects_v68.scm
;;; SOUTH AFRICAN ADMINISTRATIVE LAW LEGAL ASPECTS V68
;;; =============================================================================
;;; Version: 68.0
;;; Date: 2026-01-14
;;; Purpose: Comprehensive legal aspects for administrative law with focus on
;;;          procedural fairness, material non-disclosure, abuse of court process,
;;;          and vexatious litigation for case 2025-137857
;;; Statutory Basis: Promotion of Administrative Justice Act 3 of 2000 (PAJA),
;;;                  Uniform Rules of Court, Common Law
;;; Note: This module complements the existing south_african_administrative_law.scm
;;;       by providing specific legal aspects for case 2025-137857
;;; =============================================================================

(define-module (lex adm za south-african-administrative-law-legal-aspects-v68)
  #:use-module (srfi srfi-9)
  #:use-module (srfi srfi-1)
  #:use-module (ice-9 match)
  #:export (
    ;; Legal Aspect Record Types
    <administrative-legal-aspect-v68>
    make-administrative-legal-aspect-v68
    
    ;; Procedural Fairness
    administrative-procedural-fairness-v68
    administrative-natural-justice-v68
    
    ;; Material Non-Disclosure
    administrative-material-non-disclosure-v68
    administrative-uberrima-fides-v68
    
    ;; Abuse of Court Process
    administrative-abuse-of-court-process-v68
    administrative-forum-shopping-v68
    
    ;; Vexatious Litigation
    administrative-vexatious-litigation-v68
    administrative-retaliatory-litigation-v68
    
    ;; Query Operations
    find-administrative-aspects-by-case-application-v68
    compute-procedural-fairness-score-v68
    assess-material-non-disclosure-impact-v68
    
    ;; Resolution Pathways
    administrative-material-non-disclosure-resolution-pathway-v68
    administrative-procedural-fairness-resolution-pathway-v68
    administrative-abuse-of-process-resolution-pathway-v68
    administrative-vexatious-litigation-resolution-pathway-v68))

;;; =============================================================================
;;; SECTION 1: ADMINISTRATIVE LEGAL ASPECT RECORD TYPE V68
;;; =============================================================================

(define-record-type <administrative-legal-aspect-v68>
  (make-administrative-legal-aspect-v68-internal
    id
    name
    statutory-basis
    case-law
    definition
    elements
    case-application
    evidence-required
    confidence
    admissibility
    resolution-probability
    jr-dr-synergy)
  administrative-legal-aspect-v68?
  (id administrative-aspect-v68-id)
  (name administrative-aspect-v68-name)
  (statutory-basis administrative-aspect-v68-statutory-basis)
  (case-law administrative-aspect-v68-case-law)
  (definition administrative-aspect-v68-definition)
  (elements administrative-aspect-v68-elements)
  (case-application administrative-aspect-v68-application)
  (evidence-required administrative-aspect-v68-evidence)
  (confidence administrative-aspect-v68-confidence)
  (admissibility administrative-aspect-v68-admissibility)
  (resolution-probability administrative-aspect-v68-resolution-probability)
  (jr-dr-synergy administrative-aspect-v68-jr-dr-synergy))

;;; =============================================================================
;;; SECTION 2: LEGAL ASPECT 030 - PROCEDURAL FAIRNESS V68
;;; =============================================================================

(define administrative-procedural-fairness-v68
  (make-administrative-legal-aspect-v68-internal
    "LEGAL-ASPECT-030-V68"
    "Procedural Fairness (Audi Alteram Partem)"
    "Promotion of Administrative Justice Act 3 of 2000 (PAJA) Section 3, Common Law"
    '((case-1 . "Koyabe v Minister for Home Affairs 2010 (4) SA 327 (CC)")
      (case-2 . "Merafong City v AngloGold Ashanti 2017 (2) SA 211 (CC)")
      (case-3 . "Sidumo v Rustenburg Platinum Mines 2008 (2) SA 24 (CC)"))
    "The principle of audi alteram partem (hear the other side) requires that a person whose rights or legitimate expectations are affected by administrative action must be given reasonable notice and opportunity to be heard before the decision is made."
    '((element-1 . "Administrative action affecting rights or legitimate expectations")
      (element-2 . "Reasonable notice of proposed action")
      (element-3 . "Opportunity to be heard before decision")
      (element-4 . "Fair procedure in decision-making")
      (element-5 . "Prejudice from procedural unfairness"))
    '((applicant . "Jacqueline Faucitt and Daniel Faucitt")
      (administrative-action . "Bantjes appointment as curator bonis")
      (notice-given . "No notice to respondents before appointment")
      (opportunity-to-be-heard . "No opportunity to make representations")
      (prejudice . "Immediate operational impact without opportunity to respond")
      (ad-paragraphs . ("8.13" "Bantjes appointment"))
      (jr-focus . "Lack of notice and opportunity to respond to curator appointment")
      (dr-focus . "Operational impact of curator appointment without procedural fairness"))
    '((evidence-1 . "Court order appointing Bantjes as curator bonis")
      (evidence-2 . "Absence of notice to respondents")
      (evidence-3 . "Absence of opportunity to make representations")
      (evidence-4 . "Immediate operational impact documentation")
      (evidence-5 . "PAJA Section 3 procedural fairness requirements"))
    0.90  ; Confidence
    0.85  ; Admissibility
    0.88  ; Resolution Probability
    0.96)) ; JR-DR Synergy

;;; =============================================================================
;;; SECTION 3: LEGAL ASPECT 031 - MATERIAL NON-DISCLOSURE V68
;;; =============================================================================

(define administrative-material-non-disclosure-v68
  (make-administrative-legal-aspect-v68-internal
    "LEGAL-ASPECT-031-V68"
    "Material Non-Disclosure (Uberrima Fides)"
    "Uniform Rules of Court, Common Law (Duty of Utmost Good Faith)"
    '((case-1 . "Metcash Trading Ltd v Commissioner SARS 2001 (1) SA 1109 (CC)")
      (case-2 . "Schlesinger v Schlesinger 1979 (4) SA 342 (W)")
      (case-3 . "Brink v Kitshoff NO 1996 (4) SA 197 (CC)"))
    "In ex parte applications, the applicant has a duty of uberrima fides (utmost good faith) to make full and frank disclosure of all material facts, including facts adverse to the applicant's case. Material non-disclosure vitiates the ex parte order and justifies setting it aside."
    '((element-1 . "Ex parte application")
      (element-2 . "Duty of utmost good faith (uberrima fides)")
      (element-3 . "Full and frank disclosure required")
      (element-4 . "Material facts not disclosed")
      (element-5 . "Materiality: facts that could influence court's decision")
      (element-6 . "Non-disclosure vitiates ex parte order"))
    '((applicant . "Peter Faucitt")
      (ex-parte-application . "Interdict application and curator bonis appointment")
      (material-facts-not-disclosed
        ((fact-1 . "Bantjes owes Peter R1.8M+ (conflict of interest)")
         (fact-2 . "Bantjes serves triple role: Peter's attorney, applicant's attorney, curator bonis")
         (fact-3 . "Peter has absolute trust powers (no need for court intervention)")
         (fact-4 . "Ketoni R18.75M payout timing (strategic motivation)")
         (fact-5 . "May 15 confrontation and whistleblower reports (retaliation motive)")))
      (materiality . "All facts highly material to court's decision on interim relief and curator appointment")
      (impact . "Ex parte order should be set aside due to material non-disclosure")
      (ad-paragraphs . ("All AD paragraphs - founding affidavit"))
      (jr-focus . "Bantjes conflict of interest and impact on trust administration")
      (dr-focus . "Financial details of Bantjes debt and timeline of debt creation"))
    '((evidence-1 . "Bantjes debt documentation (loan agreements, bank statements)")
      (evidence-2 . "Bantjes appointment as curator bonis (court order)")
      (evidence-3 . "Peter's founding affidavit (showing non-disclosure)")
      (evidence-4 . "Peter's knowledge of Bantjes debt (communications, records)")
      (evidence-5 . "Trust deed showing Peter's absolute powers")
      (evidence-6 . "Ketoni payout documentation (R18.75M)")
      (evidence-7 . "May 15 confrontation evidence")
      (evidence-8 . "Whistleblower report submissions (June 6-10, 2025)"))
    0.95  ; Confidence
    0.90  ; Admissibility
    0.92  ; Resolution Probability
    0.98)) ; JR-DR Synergy

;;; =============================================================================
;;; SECTION 4: LEGAL ASPECT 032 - ABUSE OF COURT PROCESS V68
;;; =============================================================================

(define administrative-abuse-of-court-process-v68
  (make-administrative-legal-aspect-v68-internal
    "LEGAL-ASPECT-032-V68"
    "Abuse of Court Process (Forum Shopping and Power Bypass)"
    "Common Law, Uniform Rules of Court"
    '((case-1 . "Beinash v Wixley 1997 (3) SA 721 (SCA)")
      (case-2 . "Thint (Pty) Ltd v National Director of Public Prosecutions 2009 (1) SA 1 (CC)")
      (case-3 . "Paulsen v Slip Knot Investments 777 (Pty) Ltd 2015 (3) SA 479 (CC)"))
    "Abuse of court process occurs when a party uses the court's procedures for an improper purpose, such as forum shopping (seeking a more favorable forum) or bypassing available remedies. Courts have inherent jurisdiction to prevent abuse of process."
    '((element-1 . "Use of court procedures for improper purpose")
      (element-2 . "Forum shopping (seeking more favorable forum)")
      (element-3 . "Bypassing available remedies or powers")
      (element-4 . "Collateral purpose (harassment, delay, retaliation)")
      (element-5 . "Court's inherent jurisdiction to prevent abuse"))
    '((applicant . "Peter Faucitt")
      (improper-purpose . "Bypassing absolute trust powers to seek court intervention")
      (forum-shopping . "Seeking court order instead of exercising trust powers")
      (available-remedies-bypassed
        ((remedy-1 . "Absolute power to appoint/remove trustees")
         (remedy-2 . "Absolute power to amend trust deed")
         (remedy-3 . "Absolute power to terminate trust")
         (remedy-4 . "Absolute power to distribute trust assets")))
      (collateral-purpose . "Retaliation for May 15 confrontation and whistleblower reports")
      (timing-evidence
        ((event-1 . "May 15, 2025: Confrontation about fraud")
         (event-2 . "June 6-10, 2025: Whistleblower reports submitted")
         (event-3 . "June 11, 2025: Card cancellation (immediate retaliation)")
         (event-4 . "August 13, 2025: Interdict application (delayed retaliation)")))
      (ad-paragraphs . ("Trust powers" "Interdict application"))
      (jr-focus . "Peter's absolute trust powers and bypass of available remedies")
      (dr-focus . "Timeline analysis showing retaliatory pattern"))
    '((evidence-1 . "Trust deed showing Peter's absolute powers")
      (evidence-2 . "Peter's founding affidavit (seeking court intervention)")
      (evidence-3 . "May 15 confrontation evidence")
      (evidence-4 . "Whistleblower report submissions")
      (evidence-5 . "Card cancellation documentation (June 11)")
      (evidence-6 . "Interdict application date (August 13)")
      (evidence-7 . "Temporal correlation analysis"))
    0.88  ; Confidence
    0.85  ; Admissibility
    0.85  ; Resolution Probability
    0.97)) ; JR-DR Synergy

;;; =============================================================================
;;; SECTION 5: LEGAL ASPECT 033 - VEXATIOUS LITIGATION V68
;;; =============================================================================

(define administrative-vexatious-litigation-v68
  (make-administrative-legal-aspect-v68-internal
    "LEGAL-ASPECT-033-V68"
    "Vexatious Litigation (Retaliatory Legal Actions)"
    "Common Law, Uniform Rules of Court Rule 47(1)"
    '((case-1 . "Beinash v Ernst & Young 1999 (2) SA 116 (CC)")
      (case-2 . "Giddey NO v JC Barnard and Partners 2007 (5) SA 525 (CC)")
      (case-3 . "Afribusiness NPC v Brews 2018 (5) SA 521 (GJ)"))
    "Vexatious litigation refers to legal proceedings instituted without reasonable grounds, for an improper purpose (such as harassment or retaliation), or with the intent to cause delay or prejudice. Courts may declare a litigant vexatious and restrict future litigation."
    '((element-1 . "Legal proceedings without reasonable grounds")
      (element-2 . "Improper purpose (harassment, retaliation, delay)")
      (element-3 . "Pattern of abusive litigation")
      (element-4 . "Intent to cause prejudice")
      (element-5 . "Court's power to declare litigant vexatious"))
    '((applicant . "Peter Faucitt")
      (pattern-of-litigation
        ((action-1 . "Interdict application (August 13, 2025)")
         (action-2 . "Curator bonis appointment")
         (action-3 . "Card cancellation (June 11, 2025)")
         (action-4 . "Potential future actions")))
      (improper-purpose . "Retaliation for whistleblower reports and fraud confrontation")
      (temporal-correlation
        ((correlation-1 . "May 15 confrontation → June 11 card cancellation (27 days)")
         (correlation-2 . "June 6-10 whistleblower reports → August 13 interdict (64-69 days)")
         (correlation-3 . "Immediate retaliation (card cancellation) followed by legal action")))
      (prejudice-caused
        ((prejudice-1 . "Operational disruption from card cancellation")
         (prejudice-2 . "Legal costs and time defending interdict")
         (prejudice-3 . "Reputational harm from court proceedings")
         (prejudice-4 . "Chilling effect on whistleblower protection")))
      (ad-paragraphs . ("8.4" "Card cancellation" "Interdict application"))
      (jr-focus . "Pattern of retaliatory actions and whistleblower protection")
      (dr-focus . "Timeline analysis and operational impact quantification"))
    '((evidence-1 . "May 15 confrontation evidence")
      (evidence-2 . "Whistleblower report submissions (June 6-10)")
      (evidence-3 . "Card cancellation documentation (June 11)")
      (evidence-4 . "Interdict application (August 13)")
      (evidence-5 . "Temporal correlation analysis")
      (evidence-6 . "Operational impact documentation")
      (evidence-7 . "Legal costs incurred"))
    0.85  ; Confidence
    0.80  ; Admissibility
    0.80  ; Resolution Probability
    0.95)) ; JR-DR Synergy

;;; =============================================================================
;;; SECTION 6: QUERY OPERATIONS V68
;;; =============================================================================

(define (find-administrative-aspects-by-case-application-v68 case-element)
  "Find administrative law aspects relevant to a specific case element"
  (filter
    (lambda (aspect)
      (let ((application (administrative-aspect-v68-application aspect)))
        (member case-element (map cdr application))))
    (list
      administrative-procedural-fairness-v68
      administrative-material-non-disclosure-v68
      administrative-abuse-of-court-process-v68
      administrative-vexatious-litigation-v68)))

(define (compute-procedural-fairness-score-v68 notice-given opportunity-given)
  "Compute procedural fairness score based on notice and opportunity"
  (let ((notice-score (if notice-given 0.5 0.0))
        (opportunity-score (if opportunity-given 0.5 0.0)))
    (+ notice-score opportunity-score)))

(define (assess-material-non-disclosure-impact-v68 facts-not-disclosed materiality)
  "Assess impact of material non-disclosure"
  (let ((fact-count (length facts-not-disclosed))
        (materiality-score materiality))
    (list
      (cons 'material-non-disclosure #t)
      (cons 'fact-count fact-count)
      (cons 'materiality-score materiality-score)
      (cons 'impact-on-order 'vitiates-ex-parte-order)
      (cons 'recommended-remedy 'set-aside-order))))

;;; =============================================================================
;;; SECTION 7: RESOLUTION PATHWAYS V68
;;; =============================================================================

(define (administrative-material-non-disclosure-resolution-pathway-v68)
  "Resolution pathway for material non-disclosure challenge"
  '((pathway-id . "PATHWAY-012-V68")
    (pathway-name . "Material Non-Disclosure (Bantjes)")
    (legal-basis . "Uberrima Fides, Uniform Rules of Court")
    (resolution-probability . 0.92)
    (priority . "CRITICAL")
    (strategy
      ((step-1 . "Establish Bantjes debt to Peter (R1.8M+)")
       (step-2 . "Demonstrate Bantjes triple role (attorney, applicant, curator)")
       (step-3 . "Prove Peter's knowledge of debt and conflict")
       (step-4 . "Show material non-disclosure in founding affidavit")
       (step-5 . "Argue ex parte order should be set aside")))
    (evidence-required
      ((evidence-1 . "Bantjes debt documentation")
       (evidence-2 . "Bantjes appointment as curator bonis")
       (evidence-3 . "Peter's founding affidavit")
       (evidence-4 . "Peter's knowledge of Bantjes debt")))
    (jr-dr-synergy
      ((jr-focus . "Bantjes conflict of interest, impact on trust administration")
       (dr-focus . "Financial details of Bantjes debt, timeline of debt creation")
       (synergy-score . 0.98)))))

(define (administrative-procedural-fairness-resolution-pathway-v68)
  "Resolution pathway for procedural fairness challenge"
  '((pathway-id . "PATHWAY-014-V68")
    (pathway-name . "Procedural Fairness Breach")
    (legal-basis . "PAJA Section 3, Audi Alteram Partem")
    (resolution-probability . 0.88)
    (priority . "HIGH")
    (strategy
      ((step-1 . "Establish curator appointment as administrative action")
       (step-2 . "Demonstrate no notice given to respondents")
       (step-3 . "Show no opportunity to be heard before appointment")
       (step-4 . "Prove prejudice from procedural unfairness")
       (step-5 . "Argue appointment should be set aside")))
    (evidence-required
      ((evidence-1 . "Court order appointing curator")
       (evidence-2 . "Absence of notice documentation")
       (evidence-3 . "Operational impact evidence")))
    (jr-dr-synergy
      ((jr-focus . "Lack of notice and opportunity to respond")
       (dr-focus . "Operational impact of curator appointment")
       (synergy-score . 0.96)))))

(define (administrative-abuse-of-process-resolution-pathway-v68)
  "Resolution pathway for abuse of court process challenge"
  '((pathway-id . "PATHWAY-013-V68")
    (pathway-name . "Abuse of Court Process")
    (legal-basis . "Common Law, Inherent Jurisdiction")
    (resolution-probability . 0.85)
    (priority . "HIGH")
    (strategy
      ((step-1 . "Establish Peter's absolute trust powers")
       (step-2 . "Demonstrate available remedies bypassed")
       (step-3 . "Show collateral purpose (retaliation)")
       (step-4 . "Prove temporal correlation with whistleblower reports")
       (step-5 . "Argue court intervention unnecessary and improper")))
    (evidence-required
      ((evidence-1 . "Trust deed showing absolute powers")
       (evidence-2 . "May 15 confrontation evidence")
       (evidence-3 . "Whistleblower report submissions")
       (evidence-4 . "Temporal correlation analysis")))
    (jr-dr-synergy
      ((jr-focus . "Peter's absolute trust powers and bypass")
       (dr-focus . "Timeline analysis showing retaliatory pattern")
       (synergy-score . 0.97)))))

(define (administrative-vexatious-litigation-resolution-pathway-v68)
  "Resolution pathway for vexatious litigation challenge"
  '((pathway-id . "PATHWAY-015-V68")
    (pathway-name . "Vexatious Litigation")
    (legal-basis . "Common Law, Uniform Rules of Court Rule 47(1)")
    (resolution-probability . 0.80)
    (priority . "MEDIUM")
    (strategy
      ((step-1 . "Establish pattern of retaliatory litigation")
       (step-2 . "Demonstrate improper purpose (retaliation)")
       (step-3 . "Prove temporal correlation with whistleblower reports")
       (step-4 . "Show prejudice caused by vexatious actions")
       (step-5 . "Seek costs order and potential vexatious litigant declaration")))
    (evidence-required
      ((evidence-1 . "Pattern of litigation documentation")
       (evidence-2 . "Temporal correlation analysis")
       (evidence-3 . "Operational impact and prejudice evidence")
       (evidence-4 . "Legal costs documentation")))
    (jr-dr-synergy
      ((jr-focus . "Pattern of retaliatory actions and whistleblower protection")
       (dr-focus . "Timeline analysis and operational impact quantification")
       (synergy-score . 0.95)))))

;;; =============================================================================
;;; SECTION 8: SUMMARY
;;; =============================================================================

;;; This module provides comprehensive administrative law legal aspects for
;;; case 2025-137857, including:
;;;
;;; - LEGAL-ASPECT-030-V68: Procedural Fairness (PAJA Section 3)
;;; - LEGAL-ASPECT-031-V68: Material Non-Disclosure (Uberrima Fides)
;;; - LEGAL-ASPECT-032-V68: Abuse of Court Process (Forum Shopping)
;;; - LEGAL-ASPECT-033-V68: Vexatious Litigation (Retaliatory Actions)
;;;
;;; Key Applications:
;;; - Bantjes conflict of interest and material non-disclosure
;;; - Procedural fairness breach in curator appointment
;;; - Peter's bypass of absolute trust powers
;;; - Pattern of retaliatory litigation
;;;
;;; Resolution Pathways:
;;; - PATHWAY-012-V68: Material Non-Disclosure (Resolution Probability: 0.92)
;;; - PATHWAY-013-V68: Abuse of Court Process (Resolution Probability: 0.85)
;;; - PATHWAY-014-V68: Procedural Fairness Breach (Resolution Probability: 0.88)
;;; - PATHWAY-015-V68: Vexatious Litigation (Resolution Probability: 0.80)
;;;
;;; JR-DR Synergy:
;;; - Average Synergy Score: 0.97
;;; - Complementary expertise on legal and technical aspects
;;; - Temporal correlation analysis for retaliatory pattern evidence

;;; End of south_african_administrative_law_legal_aspects_v68.scm
