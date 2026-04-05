;; South African Civil Law - Agent-Based Conflict Resolution Framework v2
;; Enhanced for optimal law resolution in complex multi-party disputes
;; Derived from Level 1 first-order principles
;; Version: 2.0
;; Last Updated: 2025-11-12
;; Case: 2025-137857 (Peter Faucitt v. Jacqueline & Daniel Faucitt)
;; =============================================================================

;; Import Level 1 first-order principles
(require "../../lv1/known_laws.scm")

;; Initialize principle registry
(initialize-principle-registry!)

;; =============================================================================
;; FRAMEWORK METADATA
;; =============================================================================

(define framework-metadata
  (make-hash-table
   'name "Agent-Based Conflict Resolution Framework v2"
   'jurisdiction "za"
   'legal-domain '(civil trust company professional-ethics)
   'version "2.0"
   'last-updated "2025-11-12"
   'derived-from-level 1
   'confidence-base 0.97
   'language "en"
   'case-reference "2025-137857"))

;; =============================================================================
;; AGENT DEFINITION FRAMEWORK
;; =============================================================================

;; Enhanced agent structure with comprehensive metadata
(define (make-agent name type roles relationships legal-aspects conflicts)
  (make-hash-table
   'name name
   'type type  ;; 'natural-person or 'juristic-person
   'roles roles  ;; List of (role target) pairs
   'relationships relationships  ;; List of relationship descriptors
   'legal-aspects legal-aspects  ;; List of applicable legal principles
   'conflicts conflicts  ;; List of detected conflicts
   'confidence 0.95
   'last-updated (current-timestamp)))

;; =============================================================================
;; ENTITY AGENTS (Based on Legal Aspects Analysis)
;; =============================================================================

;; Natural Person Agents
(define peter-faucitt-agent
  (make-agent
   'name "Peter Faucitt"
   'type 'natural-person
   'roles '((founder faucitt-family-trust)
            (trustee faucitt-family-trust)
            (director regima-worldwide-distribution)
            (applicant case-2025-137857))
   'relationships '((fiduciary-duty faucitt-family-trust)
                    (director-duty regima-worldwide-distribution)
                    (adversarial jacqueline-faucitt daniel-faucitt))
   'legal-aspects '(fiduciary-duty abuse-of-power bad-faith 
                    litigation-as-weapon power-concentration)
   'conflicts '((founder-trustee-power-concentration critical 0.98)
                (trustee-beneficiary-antagonism critical 0.96)
                (director-beneficiary-conflict high 0.92))))

(define jacqueline-faucitt-agent
  (make-agent
   'name "Jacqueline Faucitt"
   'type 'natural-person
   'roles '((ceo regima-skin-treatments)
            (beneficiary faucitt-family-trust)
            (respondent case-2025-137857))
   'relationships '((executive-duty regima-skin-treatments)
                    (beneficiary-right faucitt-family-trust)
                    (victim-of-power-abuse peter-faucitt))
   'legal-aspects '(executive-duties beneficiary-rights 
                    victim-of-power-abuse victim-of-coercion)
   'conflicts '()))

(define daniel-faucitt-agent
  (make-agent
   'name "Daniel Faucitt"
   'type 'natural-person
   'roles '((cio regima-skin-treatments)
            (owner regima-zone-ltd)
            (beneficiary faucitt-family-trust)
            (respondent case-2025-137857))
   'relationships '((executive-duty regima-skin-treatments)
                    (ownership-right regima-zone-ltd)
                    (beneficiary-right faucitt-family-trust)
                    (whistleblower fraud-report-2025-06-06)
                    (victim-of-unjust-enrichment regima-worldwide-distribution))
   'legal-aspects '(ownership-rights executive-duties beneficiary-rights
                    whistleblower-protection victim-of-unjust-enrichment
                    victim-of-power-abuse)
   'conflicts '()))

(define rynette-farrar-agent
  (make-agent
   'name "Rynette Farrar"
   'type 'natural-person
   'roles '((accountant regima-skin-treatments)
            (trustee faucitt-family-trust)
            (director rezonance)
            (creditor-representative regima-skin-treatments))
   'relationships '((professional-duty regima-skin-treatments)
                    (fiduciary-duty faucitt-family-trust)
                    (director-duty rezonance)
                    (creditor-control regima-skin-treatments))
   'legal-aspects '(professional-duty fiduciary-duty conflict-of-interest
                    potential-fraud revenue-hijacking creditor-power-abuse)
   'conflicts '((accountant-trustee-conflict critical 0.97)
                (creditor-accountant-conflict critical 0.96)
                (professional-duty-vs-personal-interest critical 0.95)
                (triple-role-conflict critical 0.98))))

(define daniel-bantjies-agent
  (make-agent
   'name "Daniel Bantjies"
   'type 'natural-person
   'roles '((accountant regima-worldwide-distribution)
            (trustee faucitt-family-trust))
   'relationships '((professional-duty regima-worldwide-distribution)
                    (fiduciary-duty faucitt-family-trust))
   'legal-aspects '(professional-duty fiduciary-duty conflict-of-interest
                    potential-fraud undisclosed-trustee-status)
   'conflicts '((accountant-trustee-conflict critical 0.96)
                (professional-duty-vs-personal-interest high 0.89))))

;; Juristic Person Agents
(define faucitt-family-trust-agent
  (make-agent
   'name "Faucitt Family Trust"
   'type 'juristic-person
   'roles '((trust-entity trust-law)
            (owner regima-worldwide-distribution)
            (owner villa-via))
   'relationships '((trust-beneficiary jacqueline-faucitt)
                    (trust-beneficiary daniel-faucitt)
                    (trust-asset regima-worldwide-distribution)
                    (trust-asset villa-via))
   'legal-aspects '(trust-law fiduciary-duty beneficiary-protection
                    trust-asset-protection unusual-trustee-powers
                    absence-of-beneficiary-powers)
   'conflicts '((trustee-power-imbalance critical 0.94)
                (trust-weaponization high 0.91))))

(define regima-skin-treatments-agent
  (make-agent
   'name "RegimA Skin Treatments"
   'type 'juristic-person
   'roles '((company company-law)
            (primary-brand-manager business-operations)
            (debtor rezonance))
   'relationships '((executive-management jacqueline-faucitt)
                    (executive-management daniel-faucitt)
                    (professional-service rynette-farrar)
                    (creditor-relationship rezonance))
   'legal-aspects '(company-law director-duties corporate-governance
                    debt-obligation creditor-control-risk)
   'conflicts '((creditor-control-conflict high 0.88))))

(define regima-worldwide-distribution-agent
  (make-agent
   'name "RegimA Worldwide Distribution"
   'type 'juristic-person
   'roles '((company company-law)
            (trust-asset faucitt-family-trust)
            (platform-user regima-zone-ltd)
            (e-commerce-operator business-operations))
   'relationships '((owned-by faucitt-family-trust)
                    (director peter-faucitt)
                    (professional-service daniel-bantjies)
                    (platform-usage regima-zone-ltd)
                    (unjust-enrichment-from daniel-faucitt))
   'legal-aspects '(company-law trust-asset unjust-enrichment
                    platform-usage-without-payment director-duties)
   'conflicts '((platform-unjust-enrichment critical 0.96)
                (trust-asset-misuse high 0.90))))

(define regima-zone-ltd-agent
  (make-agent
   'name "RegimA Zone Ltd"
   'type 'juristic-person
   'roles '((uk-company company-law)
            (platform-owner e-commerce-infrastructure)
            (service-provider regima-worldwide-distribution))
   'relationships '((owned-by daniel-faucitt)
                    (platform-provider regima-worldwide-distribution)
                    (unpaid-service-provider regima-worldwide-distribution))
   'legal-aspects '(ownership-rights unjust-enrichment-claim
                    platform-ownership service-provider-rights
                    unpaid-services)
   'conflicts '((platform-usage-without-payment critical 0.97))))

(define rezonance-agent
  (make-agent
   'name "Rezonance"
   'type 'juristic-person
   'roles '((company company-law)
            (creditor regima-skin-treatments))
   'relationships '((director rynette-farrar)
                    (creditor-of regima-skin-treatments)
                    (debt-amount "R1,035,000"))
   'legal-aspects '(company-law creditor-rights debt-obligation
                    creditor-control-risk director-conflict)
   'conflicts '((creditor-director-conflict critical 0.95))))

;; =============================================================================
;; CONFLICT DETECTION FRAMEWORK
;; =============================================================================

;; Enhanced conflict detection with multi-factor severity scoring
(define (detect-role-conflicts agent)
  (let ((roles (get-attribute agent 'roles))
        (conflicts '()))
    ;; Check for incompatible role pairs
    (for-each
     (lambda (role1)
       (for-each
        (lambda (role2)
          (when (roles-incompatible? role1 role2)
            (set! conflicts
                  (cons (make-conflict role1 role2 
                                      (compute-conflict-severity role1 role2 agent))
                        conflicts))))
        roles))
     roles)
    conflicts))

;; Incompatible role pair definitions
(define (roles-incompatible? role1 role2)
  (or (and (eq? (car role1) 'accountant) (eq? (car role2) 'trustee))
      (and (eq? (car role1) 'accountant) (eq? (car role2) 'director))
      (and (eq? (car role1) 'trustee) (eq? (car role2) 'director))
      (and (eq? (car role1) 'founder) (eq? (car role2) 'trustee))
      (and (eq? (car role1) 'creditor) (eq? (car role2) 'accountant))
      (and (eq? (car role1) 'director) (eq? (car role2) 'beneficiary))))

;; Multi-factor conflict severity computation
(define (compute-conflict-severity role1 role2 agent)
  (let ((role-conflict-score (compute-role-conflict-score role1 role2))
        (financial-impact-score (compute-financial-impact-score agent))
        (temporal-coordination-score (compute-temporal-coordination-score agent))
        (victim-vulnerability-score (compute-victim-vulnerability-score agent)))
    ;; Weighted average: 30% role conflict, 30% financial, 20% temporal, 20% vulnerability
    (+ (* 0.30 role-conflict-score)
       (* 0.30 financial-impact-score)
       (* 0.20 temporal-coordination-score)
       (* 0.20 victim-vulnerability-score))))

;; Role conflict severity (0-1 scale)
(define (compute-role-conflict-score role1 role2)
  (cond
   ;; Triple conflicts (accountant + trustee + creditor/director)
   ((or (and (eq? (car role1) 'accountant) (eq? (car role2) 'trustee))
        (and (eq? (car role1) 'creditor) (eq? (car role2) 'accountant)))
    0.98)
   ;; Founder-trustee power concentration
   ((and (eq? (car role1) 'founder) (eq? (car role2) 'trustee))
    0.95)
   ;; Professional duty conflicts
   ((or (and (eq? (car role1) 'accountant) (eq? (car role2) 'director))
        (and (eq? (car role1) 'trustee) (eq? (car role2) 'director)))
    0.92)
   ;; Director-beneficiary conflicts
   ((and (eq? (car role1) 'director) (eq? (car role2) 'beneficiary))
    0.88)
   (else 0.75)))

;; Financial impact severity (0-1 scale)
(define (compute-financial-impact-score agent)
  (let ((legal-aspects (get-attribute agent 'legal-aspects)))
    (cond
     ((member 'unjust-enrichment legal-aspects) 0.96)
     ((member 'revenue-hijacking legal-aspects) 0.94)
     ((member 'creditor-power-abuse legal-aspects) 0.90)
     ((member 'platform-usage-without-payment legal-aspects) 0.92)
     (else 0.70))))

;; Temporal coordination severity (0-1 scale)
(define (compute-temporal-coordination-score agent)
  (let ((legal-aspects (get-attribute agent 'legal-aspects)))
    (cond
     ((member 'immediate-retaliation legal-aspects) 0.95)
     ((member 'crisis-manufacturing legal-aspects) 0.92)
     ((member 'litigation-as-weapon legal-aspects) 0.89)
     ((member 'bad-faith legal-aspects) 0.87)
     (else 0.65))))

;; Victim vulnerability severity (0-1 scale)
(define (compute-victim-vulnerability-score agent)
  (let ((legal-aspects (get-attribute agent 'legal-aspects)))
    (cond
     ((member 'victim-of-power-abuse legal-aspects) 0.93)
     ((member 'victim-of-coercion legal-aspects) 0.91)
     ((member 'whistleblower-protection legal-aspects) 0.88)
     ((member 'beneficiary-rights legal-aspects) 0.85)
     (else 0.60))))

;; =============================================================================
;; TEMPORAL PATTERN ANALYSIS
;; =============================================================================

;; Critical event timeline (from legal aspects analysis)
(define critical-events-timeline
  '((2021-01-15 business-operations-commence 
                (regima-skin-treatments regima-worldwide-distribution)
                contract-formation 0.90)
    (2025-06-06 fraud-report-submission
                (daniel-faucitt)
                fraud-allegation 0.95)
    (2025-06-07 card-cancellation
                (peter-faucitt daniel-faucitt)
                immediate-retaliation 0.96)
    (2025-07-16 r500k-payment-to-jax
                (jacqueline-faucitt regima-skin-treatments)
                trust-distribution 0.85)
    (2025-08-14 confrontation-event
                (peter-faucitt jacqueline-faucitt daniel-faucitt)
                coercion 0.92)
    (2025-08-19 interdict-filing
                (peter-faucitt)
                litigation-as-weapon 0.94)
    (2025-09-11 account-emptying
                (peter-faucitt regima-worldwide-distribution)
                power-abuse 0.93)))

;; Temporal pattern detection
(define (detect-temporal-patterns timeline)
  (let ((patterns '()))
    ;; Immediate retaliation pattern (events within 1-2 days)
    (when (immediate-retaliation-pattern? timeline)
      (set! patterns (cons '(immediate-retaliation 0.95) patterns)))
    ;; Crisis manufacturing pattern (concentrated adverse actions)
    (when (crisis-manufacturing-pattern? timeline)
      (set! patterns (cons '(crisis-manufacturing 0.92) patterns)))
    ;; Litigation weaponization pattern (litigation despite available powers)
    (when (litigation-weaponization-pattern? timeline)
      (set! patterns (cons '(litigation-weaponization 0.91) patterns)))
    patterns))

;; Immediate retaliation pattern detection
(define (immediate-retaliation-pattern? timeline)
  (let ((fraud-report-date (find-event-date timeline 'fraud-report-submission))
        (card-cancel-date (find-event-date timeline 'card-cancellation)))
    (and fraud-report-date card-cancel-date
         (<= (date-difference fraud-report-date card-cancel-date) 1))))

;; Crisis manufacturing pattern detection
(define (crisis-manufacturing-pattern? timeline)
  (let ((may-aug-events (filter-events-by-period timeline 
                                                  '(2025-05-01 2025-08-31))))
    (>= (length may-aug-events) 6)))

;; Litigation weaponization pattern detection
(define (litigation-weaponization-pattern? timeline)
  (let ((interdict-event (find-event timeline 'interdict-filing)))
    (and interdict-event
         ;; Peter has absolute trust powers, litigation unnecessary
         (has-absolute-powers? peter-faucitt-agent))))

;; =============================================================================
;; OPTIMAL LEGAL FRAMEWORK SELECTION
;; =============================================================================

;; Select optimal legal frameworks based on agent analysis
(define (select-optimal-frameworks agents events)
  (let ((frameworks '()))
    ;; Trust law for fiduciary duty breaches
    (when (any-agent-has-aspect? agents 'fiduciary-duty)
      (set! frameworks (cons '(trust-law 0.98) frameworks)))
    ;; Company law for director duties and corporate governance
    (when (any-agent-has-aspect? agents 'director-duties)
      (set! frameworks (cons '(company-law 0.96) frameworks)))
    ;; Delict law for unjust enrichment and bad faith
    (when (or (any-agent-has-aspect? agents 'unjust-enrichment)
              (any-agent-has-aspect? agents 'bad-faith))
      (set! frameworks (cons '(delict-law 0.97) frameworks)))
    ;; Civil procedure for ex parte fraud
    (when (any-event-has-aspect? events 'litigation-as-weapon)
      (set! frameworks (cons '(civil-procedure-ex-parte-fraud 0.95) frameworks)))
    ;; Professional ethics for accountant conflicts
    (when (any-agent-has-conflict? agents 'accountant-trustee-conflict)
      (set! frameworks (cons '(professional-ethics 0.94) frameworks)))
    ;; Forensic accounting for systematic fraud
    (when (or (any-agent-has-aspect? agents 'revenue-hijacking)
              (any-agent-has-aspect? agents 'potential-fraud))
      (set! frameworks (cons '(forensic-accounting 0.93) frameworks)))
    frameworks))

;; =============================================================================
;; EVIDENCE MAPPING FRAMEWORK
;; =============================================================================

;; Map legal aspects to evidence types
(define (map-evidence-for-aspect aspect)
  (cond
   ((eq? aspect 'bad-faith)
    '((temporal-correlation 0.95)
      (bypassing-available-powers 0.92)
      (coordinated-actions 0.89)
      (manufactured-crisis 0.91)))
   ((eq? aspect 'unjust-enrichment)
    '((platform-usage-without-payment 0.97)
      (revenue-diversion 0.94)
      (unpaid-services 0.93)
      (quantified-enrichment 0.96)))
   ((eq? aspect 'fiduciary-duty)
    '((trustee-beneficiary-antagonism 0.96)
      (power-abuse 0.93)
      (self-dealing 0.91)
      (failure-to-act-in-good-faith 0.94)))
   ((eq? aspect 'conflict-of-interest)
    '((multiple-incompatible-roles 0.98)
      (undisclosed-relationships 0.95)
      (professional-duty-breach 0.92)
      (personal-interest-vs-duty 0.90)))
   ((eq? aspect 'coercion)
    '((witness-accounts 0.94)
      (power-imbalance 0.91)
      (threats-and-intimidation 0.89)
      (temporal-proximity-to-litigation 0.87)))
   (else '((general-evidence 0.75)))))

;; =============================================================================
;; INTEGRATION WITH EXISTING LEX FRAMEWORKS
;; =============================================================================

;; This framework integrates with:
;; - lv1/known_laws.scm (Level 1 first-order principles)
;; - civ/za/south_african_civil_law.scm (General civil law)
;; - trs/za/south_african_trust_law_enhanced_v8.scm (Trust law)
;; - cmp/za/south_african_company_law_forensic_accounting_enhanced_v6.scm
;; - civ-proc/za/south_african_civil_procedure_ex_parte_fraud.scm
;; - prof-eth/za/south_african_professional_ethics_multi_party_conflicts.scm

;; Integration function
(define (integrate-with-lex-frameworks agent-analysis)
  (let ((frameworks (select-optimal-frameworks 
                     (get-attribute agent-analysis 'agents)
                     (get-attribute agent-analysis 'events))))
    (for-each
     (lambda (framework)
       (load-framework (car framework))
       (apply-framework-to-agents (car framework) 
                                  (get-attribute agent-analysis 'agents)))
     frameworks)))

;; =============================================================================
;; CASE-SPECIFIC APPLICATION (2025-137857)
;; =============================================================================

;; Apply framework to current case
(define case-2025-137857-analysis
  (make-hash-table
   'case-number "2025-137857"
   'case-name "Peter Faucitt v. Jacqueline & Daniel Faucitt"
   'agents (list peter-faucitt-agent
                 jacqueline-faucitt-agent
                 daniel-faucitt-agent
                 rynette-farrar-agent
                 daniel-bantjies-agent
                 faucitt-family-trust-agent
                 regima-skin-treatments-agent
                 regima-worldwide-distribution-agent
                 regima-zone-ltd-agent
                 rezonance-agent)
   'events critical-events-timeline
   'temporal-patterns (detect-temporal-patterns critical-events-timeline)
   'optimal-frameworks (select-optimal-frameworks 
                        (list peter-faucitt-agent jacqueline-faucitt-agent 
                              daniel-faucitt-agent rynette-farrar-agent 
                              daniel-bantjies-agent)
                        critical-events-timeline)
   'confidence 0.97
   'last-updated "2025-11-12"))

;; =============================================================================
;; EXPORT FUNCTIONS
;; =============================================================================

;; Export agent analysis for use in jax-dan-response
(define (export-agent-analysis-for-response case-analysis)
  (make-hash-table
   'entities (map agent-to-entity-summary 
                  (get-attribute case-analysis 'agents))
   'conflicts (extract-all-conflicts 
               (get-attribute case-analysis 'agents))
   'temporal-patterns (get-attribute case-analysis 'temporal-patterns)
   'optimal-frameworks (get-attribute case-analysis 'optimal-frameworks)
   'evidence-mapping (map-all-evidence 
                      (get-attribute case-analysis 'agents))
   'confidence 0.97))

;; Helper: Convert agent to entity summary
(define (agent-to-entity-summary agent)
  (make-hash-table
   'name (get-attribute agent 'name)
   'type (get-attribute agent 'type)
   'roles (get-attribute agent 'roles)
   'legal-aspects (get-attribute agent 'legal-aspects)
   'conflicts (get-attribute agent 'conflicts)))

;; Helper: Extract all conflicts from agents
(define (extract-all-conflicts agents)
  (apply append (map (lambda (agent) 
                       (get-attribute agent 'conflicts))
                     agents)))

;; Helper: Map evidence for all agents
(define (map-all-evidence agents)
  (apply append 
         (map (lambda (agent)
                (apply append
                       (map map-evidence-for-aspect
                            (get-attribute agent 'legal-aspects))))
              agents)))

;; =============================================================================
;; END OF FRAMEWORK
;; =============================================================================
