;; South African Civil Law - Retaliatory Action Indicators
;; Specialized module for whistleblower retaliation detection in AD-RES-J7 case
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
   'name "South African Civil Law - Retaliatory Action Indicators"
   'jurisdiction "za"
   'legal-domain '(civil delict whistleblower-protection)
   'version "1.0"
   'last-updated "2025-10-31"
   'derived-from-level 1
   'confidence-base 0.93
   'language "en"
   'case-application "AD-RES-J7 (Case 2025-137857)"))

;; =============================================================================
;; HIGH: RETALIATORY ACTION INDICATORS
;; =============================================================================

(define retaliatory-action-indicators
  (make-principle
   'name 'retaliatory-action-indicators
   'description "Indicators that action is retaliatory against whistleblower or complainant"
   'domain '(delict whistleblower-protection retaliation)
   'confidence 0.93
   'jurisdiction "za"
   'statutory-basis "Protected Disclosures Act 26/2000, common law delict"
   'indicators '(adverse-action-follows-complaint
                timing-correlation-with-disclosure
                no-adverse-action-before-disclosure
                escalation-after-exposure
                related-party-coordination
                pattern-of-punishment
                stated-reason-pretextual
                multiple-retaliatory-actions
                increasing-severity)
   'temporal-correlation "Disclosure/complaint → Adverse action (days to weeks)"
   'timing-thresholds '(within-7-days "high-correlation"
                       within-14-days "medium-high-correlation"
                       within-30-days "medium-correlation"
                       within-60-days "low-correlation")
   'case-application "Jax confronts Rynette 15 May → Orders removed 22-23 May (7 days) → Domain registered 29 May (14 days)"
   'specific-pattern '(disclosure-event "Jax confronts Rynette about R1.035M debt"
                      disclosure-date "2025-05-15"
                      disclosure-content "Kayla estate funds, murder proceeds"
                      adverse-action-1 "Shopify orders removed"
                      action-1-date "2025-05-22"
                      delta-1 "7 days"
                      correlation-1 "high"
                      adverse-action-2 "regimaskin.co.za registered by Adderory"
                      action-2-date "2025-05-29"
                      delta-2 "14 days"
                      correlation-2 "medium-high"
                      related-party "Adderory (Rynette's son's company)"
                      pattern "escalating-retaliation")
   'protected-disclosure-elements '(disclosure-of-wrongdoing
                                   good-faith-disclosure
                                   reasonable-belief-wrongdoing
                                   disclosure-to-appropriate-person
                                   protected-under-pda)
   'inference "Temporal correlation between disclosure and adverse action suggests retaliation"
   'legal-consequences '(damages-for-retaliation
                        reinstatement-of-position
                        injunctive-relief
                        punitive-damages
                        costs-order)
   'related-principles '(whistleblower-protection
                        temporal-bad-faith-indicators
                        delict
                        wrongful-interference)
   'inference-type 'abductive
   'base-principles (list delict)))

;; =============================================================================
;; HIGH: ESCALATING RETALIATION PATTERN
;; =============================================================================

(define escalating-retaliation-pattern
  (make-principle
   'name 'escalating-retaliation-pattern
   'description "Pattern of escalating retaliatory actions following disclosure"
   'domain '(delict whistleblower-protection)
   'confidence 0.92
   'jurisdiction "za"
   'statutory-basis "Protected Disclosures Act 26/2000, common law delict"
   'pattern-elements '(initial-disclosure
                      first-retaliatory-action
                      second-retaliatory-action
                      third-retaliatory-action
                      increasing-severity
                      temporal-clustering
                      related-party-coordination)
   'escalation-indicators '(increasing-financial-harm
                           increasing-operational-disruption
                           multiple-methods-employed
                           coordination-across-parties
                           systematic-destruction)
   'case-application "Jax confrontation (15 May) → Orders removed (22 May) → Domain registered (29 May) → Escalating pattern of revenue disruption"
   'inference "Escalating pattern strengthens retaliation inference"
   'related-principles '(retaliatory-action-indicators
                        financial-sabotage-indicators
                        conspiracy-indicators)
   'inference-type 'inductive
   'base-principles (list delict)))

;; =============================================================================
;; MEDIUM: RELATED PARTY COORDINATION IN RETALIATION
;; =============================================================================

(define related-party-coordination-in-retaliation
  (make-principle
   'name 'related-party-coordination-in-retaliation
   'description "Coordination between related parties in retaliatory actions"
   'domain '(delict conspiracy retaliation)
   'confidence 0.91
   'jurisdiction "za"
   'statutory-basis "Common law delict, conspiracy"
   'coordination-indicators '(related-party-takes-action
                             timing-coordination
                             complementary-actions
                             common-objective
                             no-independent-reason)
   'relationship-types '(family-relationship
                        business-relationship
                        financial-relationship
                        control-relationship)
   'case-application "Rynette confronted → Adderory (son's company) registers domain → Related party coordination in retaliation"
   'inference "Related party coordination strengthens retaliation and conspiracy inference"
   'related-principles '(retaliatory-action-indicators
                        conspiracy-indicators
                        related-party-concealment)
   'inference-type 'abductive
   'base-principles (list delict conspiracy)))

;; =============================================================================
;; MEDIUM: PRETEXTUAL REASON ANALYSIS
;; =============================================================================

(define pretextual-reason-analysis
  (make-principle
   'name 'pretextual-reason-analysis
   'description "Analysis of whether stated reason for action is pretextual"
   'domain '(delict retaliation bad-faith)
   'confidence 0.90
   'jurisdiction "za"
   'statutory-basis "Common law delict, bad faith"
   'pretext-indicators '(stated-reason-inconsistent-with-timing
                        stated-reason-inconsistent-with-conduct
                        stated-reason-not-supported-by-evidence
                        real-reason-revealed-by-temporal-pattern
                        no-action-before-disclosure
                        immediate-action-after-disclosure)
   'analysis-framework "Stated reason vs Temporal pattern vs Actual conduct"
   'inference "Inconsistency between stated reason and temporal pattern reveals pretext"
   'related-principles '(retaliatory-action-indicators
                        temporal-bad-faith-indicators
                        bad-faith)
   'inference-type 'abductive
   'base-principles (list bad-faith)))

;; =============================================================================
;; PLACEHOLDER FUNCTIONS FOR FUTURE IMPLEMENTATION
;; =============================================================================

(define (detect-retaliatory-action disclosure adverse-action timing)
  ;; Detect retaliatory action pattern
  ;; Returns: (retaliation-detected? correlation-strength indicators confidence)
  'placeholder)

(define (analyze-escalating-retaliation disclosure actions timing-pattern)
  ;; Analyze escalating retaliation pattern
  ;; Returns: (escalation-detected? severity-progression confidence)
  'placeholder)

(define (detect-related-party-coordination parties actions relationships)
  ;; Detect coordination between related parties in retaliation
  ;; Returns: (coordination-detected? relationship-types confidence)
  'placeholder)

(define (analyze-pretextual-reason stated-reason temporal-pattern conduct)
  ;; Analyze whether stated reason is pretextual
  ;; Returns: (pretextual? inconsistencies confidence)
  'placeholder)

;; =============================================================================
;; INTEGRATION WITH HYPERGRAPHQL
;; =============================================================================

;; Register all principles with the principle registry
(register-principle! retaliatory-action-indicators)
(register-principle! escalating-retaliation-pattern)
(register-principle! related-party-coordination-in-retaliation)
(register-principle! pretextual-reason-analysis)

;; Export principles for use in other modules
(provide retaliatory-action-indicators
         escalating-retaliation-pattern
         related-party-coordination-in-retaliation
         pretextual-reason-analysis)

;; =============================================================================
;; END OF MODULE
;; =============================================================================
