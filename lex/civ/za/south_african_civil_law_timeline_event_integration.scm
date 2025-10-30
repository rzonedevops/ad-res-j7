;; =============================================================================
;; South African Civil Law - Timeline and Event Integration Framework
;; =============================================================================
;; Version: 1.0
;; Last Updated: 2025-10-30
;; Case-Specific Enhancements: Faucitt v. Faucitt (2025-137857)
;; Focus: Temporal analysis, event causation, timing-based legal inferences
;; =============================================================================

;; Import Level 1 first-order principles
(require "../../lv1/known_laws.scm")

;; Initialize principle registry
(initialize-principle-registry!)

;; =============================================================================
;; PART 1: TEMPORAL CAUSATION ANALYSIS
;; =============================================================================

;; -----------------------------------------------------------------------------
;; 1.1 But-For Causation with Temporal Analysis
;; -----------------------------------------------------------------------------

(define temporal-but-for-causation
  (make-principle
   'name 'temporal-but-for-causation
   'description "But-for causation analysis incorporating temporal sequence"
   'domain '(civil delict causation evidence)
   'confidence 0.96
   'jurisdiction "za"
   'statutory-basis "Common law delict - causation element"
   'test "But for action A at time T1, would consequence B at time T2 have occurred?"
   'temporal-requirements '(action-precedes-consequence
                           temporal-proximity
                           no-intervening-causes
                           sequence-supports-causation)
   'case-application "But for Peter's card cancellation (June 7), would documentation gap exist?"
   'inference "Temporal sequence establishes causation"
   'related-principles '(factual-causation legal-causation)
   'inference-type 'deductive))

(define timing-analysis-bad-faith
  (make-principle
   'name 'timing-analysis-bad-faith
   'description "Suspicious timing of actions indicates bad faith or ulterior motive"
   'domain '(civil evidence bad-faith)
   'confidence 0.93
   'jurisdiction "za"
   'principle "Timing of actions can reveal true motive"
   'suspicious-timing-indicators '(action-immediately-after-cooperation
                                  action-during-settlement-negotiation
                                  action-coincides-with-other-events
                                  action-creates-urgency
                                  disproportionate-response-timing)
   'case-application "Peter cancels cards June 7 (day after Dan's cooperation June 6)"
   'inference "Suspicious timing suggests manufactured crisis"
   'related-principles '(bad-faith-indicators ulterior-motive-analysis)
   'inference-type 'abductive))

;; -----------------------------------------------------------------------------
;; 1.2 Event Sequence Analysis
;; -----------------------------------------------------------------------------

(define event-sequence-causation-analysis
  (make-principle
   'name 'event-sequence-causation-analysis
   'description "Analysis of event sequences to establish causation and motive"
   'domain '(civil evidence causation)
   'confidence 0.94
   'jurisdiction "za"
   'analysis-method '(identify-events
                     establish-temporal-order
                     identify-causal-relationships
                     assess-intervening-causes
                     infer-motive-from-sequence)
   'case-application "Card cancellation timeline: cooperation → cancellation → documentation gap → complaint"
   'inference "Event sequence reveals manufactured crisis"
   'related-principles '(temporal-but-for-causation timing-analysis-bad-faith)
   'inference-type 'abductive))

(define manufactured-crisis-timeline-indicators
  (make-principle
   'name 'manufactured-crisis-timeline-indicators
   'description "Timeline indicators that crisis was manufactured rather than genuine"
   'domain '(civil evidence bad-faith)
   'confidence 0.92
   'jurisdiction "za"
   'indicators '(crisis-created-by-party-complaining
                timing-suspicious
                party-had-control-over-triggering-event
                crisis-benefits-complaining-party
                escalation-disproportionate
                no-attempt-at-internal-resolution)
   'case-application "Peter creates documentation gap (card cancellation), then complains about missing documentation"
   'timeline-pattern '(party-creates-problem
                      party-complains-about-problem
                      party-seeks-urgent-relief
                      party-benefits-from-urgency)
   'inference "Timeline pattern proves manufactured crisis"
   'related-principles '(timing-analysis-bad-faith abuse-of-process)
   'inference-type 'abductive))

;; =============================================================================
;; PART 2: BAD FAITH AND ULTERIOR MOTIVE DETECTION
;; =============================================================================

;; -----------------------------------------------------------------------------
;; 2.1 Bad Faith Indicators
;; -----------------------------------------------------------------------------

(define bad-faith-indicators
  (make-principle
   'name 'bad-faith-indicators
   'description "Indicators that party is acting in bad faith"
   'domain '(civil procedural-fairness)
   'confidence 0.93
   'jurisdiction "za"
   'indicators '(suspicious-timing
                manufactured-urgency
                obstruction-of-documentation
                bypassing-available-remedies
                disproportionate-response
                inconsistent-positions
                ulterior-motive-evident)
   'case-application "Peter's actions: card cancellation, bypassing trust powers, ex parte application"
   'inference "Multiple indicators establish bad faith"
   'related-principles '(bona-fides abuse-of-process)
   'inference-type 'abductive))

(define ulterior-motive-analysis
  (make-principle
   'name 'ulterior-motive-analysis
   'description "Analysis framework for detecting ulterior motives"
   'domain '(civil evidence)
   'confidence 0.91
   'jurisdiction "za"
   'analysis-factors '(stated-purpose-vs-actual-effect
                      timing-of-actions
                      availability-of-alternative-remedies
                      party-bypasses-available-powers
                      actions-benefit-party-in-other-ways
                      pattern-of-behavior)
   'case-application "Peter seeks interdict despite having absolute trust powers"
   'question "Why seek court relief when direct power exists?"
   'inference "Bypassing available powers suggests ulterior motive"
   'related-principles '(proper-purpose-test trust-power-abuse-test)
   'inference-type 'abductive))

(define manufactured-urgency-indicators
  (make-principle
   'name 'manufactured-urgency-indicators
   'description "Indicators that urgency is manufactured rather than genuine"
   'domain '(civil procedural-fairness interim-relief)
   'confidence 0.92
   'jurisdiction "za"
   'indicators '(party-created-urgency
                no-genuine-irreparable-harm
                delay-before-claiming-urgency
                ex-parte-application-without-justification
                timing-coincides-with-other-goals)
   'case-application "Peter seeks urgent ex parte interdict during settlement negotiation"
   'inference "Urgency manufactured to gain litigation advantage"
   'related-principles '(interim-relief-requirements abuse-of-process)
   'inference-type 'abductive))

;; -----------------------------------------------------------------------------
;; 2.2 Abuse of Process Through Timing
;; -----------------------------------------------------------------------------

(define abuse-of-process-timing-indicators
  (make-principle
   'name 'abuse-of-process-timing-indicators
   'description "Timing-based indicators of abuse of process"
   'domain '(civil procedural-fairness)
   'confidence 0.93
   'jurisdiction "za"
   'statutory-basis "Common law abuse of process doctrine"
   'timing-indicators '(litigation-during-settlement-negotiation
                       ex-parte-application-without-urgency
                       escalation-without-internal-resolution
                       timing-creates-litigation-advantage
                       timing-disrupts-business-operations)
   'case-application "Peter seeks ex parte interdict during settlement negotiation"
   'inference "Timing reveals abuse of process"
   'related-principles '(abuse-of-process bad-faith-indicators)
   'inference-type 'abductive))

;; =============================================================================
;; PART 3: OBSTRUCTION AND ESTOPPEL THROUGH TEMPORAL ANALYSIS
;; =============================================================================

;; -----------------------------------------------------------------------------
;; 3.1 Obstruction of Documentation
;; -----------------------------------------------------------------------------

(define obstruction-timeline-analysis
  (make-principle
   'name 'obstruction-timeline-analysis
   'description "Timeline analysis to prove obstruction of documentation"
   'domain '(civil evidence obstruction)
   'confidence 0.95
   'jurisdiction "za"
   'timeline-pattern '(documentation-accessible-before-action
                      party-takes-action-restricting-access
                      documentation-becomes-inaccessible
                      party-complains-about-missing-documentation)
   'case-application "Peter's card cancellation timeline"
   'timeline '((2025-06-06 "Documentation accessible, Dan cooperates")
              (2025-06-07 "Peter cancels cards unilaterally")
              (2025-06-07-onwards "Documentation inaccessible")
              (present "Peter complains about missing documentation"))
   'inference "Timeline proves Peter created the documentation gap"
   'legal-consequence "Venire contra factum proprium - estoppel"
   'related-principles '(venire-contra-factum-proprium obstruction-of-documentation-principle)
   'inference-type 'deductive))

(define self-created-problem-estoppel
  (make-principle
   'name 'self-created-problem-estoppel
   'description "Party estopped from complaining about problem they created"
   'domain '(civil estoppel)
   'confidence 0.96
   'jurisdiction "za"
   'statutory-basis "Common law estoppel, venire contra factum proprium"
   'principle "Party cannot benefit from problem they created"
   'test-elements '(party-created-problem
                   party-had-control
                   party-now-complains-about-problem
                   party-seeks-benefit-from-problem)
   'case-application "Peter created documentation gap, now complains about missing documentation"
   'legal-effect "Peter estopped from relying on documentation gap"
   'related-principles '(venire-contra-factum-proprium clean-hands-doctrine)
   'inference-type 'deductive))

;; -----------------------------------------------------------------------------
;; 3.2 Temporal Adverse Inference
;; -----------------------------------------------------------------------------

(define temporal-adverse-inference
  (make-principle
   'name 'temporal-adverse-inference
   'description "Court draws adverse inference from suspicious timing of actions"
   'domain '(civil evidence)
   'confidence 0.93
   'jurisdiction "za"
   'principle "Suspicious timing supports adverse inference against party"
   'inference-triggers '(action-immediately-after-cooperation
                        action-creates-problem-party-complains-about
                        timing-benefits-party
                        no-innocent-explanation-for-timing)
   'case-application "Peter's card cancellation day after Dan's cooperation"
   'adverse-inference "Court should infer Peter acted to create crisis"
   'related-principles '(timing-analysis-bad-faith bad-faith-indicators)
   'inference-type 'abductive))

;; =============================================================================
;; PART 4: TRUST POWER BYPASS TEMPORAL ANALYSIS
;; =============================================================================

;; -----------------------------------------------------------------------------
;; 4.1 Trust Power Bypass Timeline
;; -----------------------------------------------------------------------------

(define trust-power-bypass-timeline-analysis
  (make-principle
   'name 'trust-power-bypass-timeline-analysis
   'description "Timeline analysis of trustee bypassing direct trust powers"
   'domain '(trust fiduciary abuse-of-process)
   'confidence 0.92
   'jurisdiction "za"
   'statutory-basis "Trust Property Control Act 57/1988"
   'timeline-pattern '(trustee-has-absolute-powers
                      trustee-chooses-not-to-use-powers
                      trustee-seeks-court-relief-instead
                      timing-coincides-with-other-actions)
   'case-application "Peter has absolute trust powers but seeks court interdict"
   'timing-coincidence "Interdict application during settlement negotiation"
   'question "Why bypass direct powers for court relief?"
   'inference "Timing suggests ulterior motive beyond trust administration"
   'related-principles '(trust-power-abuse-test ulterior-motive-analysis)
   'inference-type 'abductive))

(define trust-power-bypass-indicators
  (make-principle
   'name 'trust-power-bypass-indicators
   'description "Indicators that trustee is bypassing direct trust powers for ulterior motives"
   'domain '(trust fiduciary abuse-of-process)
   'confidence 0.94
   'jurisdiction "za"
   'statutory-basis "Trust Property Control Act 57/1988"
   'indicators '(trustee-has-absolute-powers
                trustee-seeks-court-relief-instead
                beneficiary-is-target-of-relief
                timing-coincides-with-other-actions
                manufactured-urgency
                ex-parte-application
                no-attempt-to-use-direct-powers)
   'case-application "Peter seeks interdict despite having absolute trust powers (PARA 11-11.5)"
   'inference "Seeking court relief when direct power exists suggests ulterior motive"
   'ulterior-motive-possibilities '(litigation-pressure
                                   settlement-leverage
                                   business-disruption
                                   reputational-damage)
   'related-principles '(proper-purpose-test abuse-of-process)
   'inference-type 'abductive))

;; =============================================================================
;; PART 5: PLATFORM USAGE TIMELINE ANALYSIS
;; =============================================================================

;; -----------------------------------------------------------------------------
;; 5.1 Unjust Enrichment Timeline
;; -----------------------------------------------------------------------------

(define platform-usage-timeline-analysis
  (make-principle
   'name 'platform-usage-timeline-analysis
   'description "Timeline analysis for platform usage unjust enrichment claim"
   'domain '(civil unjust-enrichment)
   'confidence 0.94
   'jurisdiction "za"
   'timeline-elements '(platform-investment-date
                       usage-commencement-date
                       usage-duration
                       payment-absence-duration
                       enrichment-calculation-period)
   'case-application "RegimA Zone Ltd platform usage by RWD"
   'timeline '((investment "Dan's UK company invests R1M in platform")
              (usage-start "RWD begins using platform")
              (usage-duration "28 months of usage")
              (payment "No payment made to RegimA Zone Ltd")
              (enrichment "R2.94M-R6.88M unjust enrichment"))
   'inference "Timeline establishes unjust enrichment elements"
   'related-principles '(unjust-enrichment-test quantum-meruit)
   'inference-type 'deductive))

(define ongoing-enrichment-calculation
  (make-principle
   'name 'ongoing-enrichment-calculation
   'description "Method for calculating ongoing unjust enrichment over time"
   'domain '(civil unjust-enrichment remedies)
   'confidence 0.93
   'jurisdiction "za"
   'calculation-method '(identify-usage-period
                        calculate-monthly-value
                        multiply-by-duration
                        adjust-for-market-rates
                        consider-alternative-cost)
   'case-application "RWD platform usage for 28 months"
   'calculation "R105K-R245K per month × 28 months = R2.94M-R6.88M"
   'related-principles '(quantum-meruit restitution)
   'inference-type 'deductive))

;; =============================================================================
;; PART 6: CASE-SPECIFIC TIMELINE INTEGRATION
;; =============================================================================

;; -----------------------------------------------------------------------------
;; 6.1 Card Cancellation Timeline
;; -----------------------------------------------------------------------------

(define card-cancellation-timeline
  (make-principle
   'name 'card-cancellation-timeline
   'description "Complete timeline analysis of card cancellation events"
   'domain '(case-specific evidence)
   'confidence 0.95
   'jurisdiction "za"
   'case-reference "Faucitt v. Faucitt (2025-137857)"
   'timeline '((2025-06-06 "Dan provides reports to accountant - cooperation")
              (2025-06-07 "Peter cancels business cards unilaterally - next day")
              (2025-06-07-onwards "Documentation becomes inaccessible")
              (present "Peter complains about missing documentation"))
   'legal-significance "Demonstrates manufactured crisis and bad faith"
   'causal-chain "Peter's action → documentation gap → Peter's complaint"
   'legal-principles-triggered '(temporal-but-for-causation
                                timing-analysis-bad-faith
                                manufactured-crisis-timeline-indicators
                                obstruction-timeline-analysis
                                self-created-problem-estoppel
                                venire-contra-factum-proprium)
   'conclusion "Timeline proves Peter manufactured the documentation crisis"
   'inference-type 'deductive))

;; -----------------------------------------------------------------------------
;; 6.2 Settlement Negotiation Timeline
;; -----------------------------------------------------------------------------

(define settlement-negotiation-timeline
  (make-principle
   'name 'settlement-negotiation-timeline
   'description "Timeline of litigation actions during settlement negotiation"
   'domain '(case-specific procedural-fairness)
   'confidence 0.93
   'jurisdiction "za"
   'case-reference "Faucitt v. Faucitt (2025-137857)"
   'timeline-pattern '(settlement-negotiation-ongoing
                      peter-seeks-ex-parte-interdict
                      manufactured-urgency
                      litigation-pressure-tactic)
   'legal-significance "Seeking ex parte relief during settlement suggests bad faith"
   'legal-principles-triggered '(abuse-of-process-timing-indicators
                                bad-faith-indicators
                                manufactured-urgency-indicators)
   'inference "Peter using litigation as pressure tactic during settlement"
   'related-principles '(abuse-of-process bad-faith-indicators)
   'inference-type 'abductive))

;; =============================================================================
;; FRAMEWORK METADATA
;; =============================================================================

(define timeline-event-integration-metadata
  (make-hash-table
   'name "Timeline and Event Integration Framework"
   'jurisdiction "za"
   'legal-domain '(civil evidence causation)
   'version "1.0"
   'last-updated "2025-10-30"
   'derived-from-level 1
   'confidence-base 0.93
   'statutory-basis "Common law causation, estoppel, abuse of process"
   'language "en"
   'case-specific-enhancements "Faucitt v. Faucitt (2025-137857) - Temporal analysis"))

;; Register all principles
(register-principles!
 temporal-but-for-causation
 timing-analysis-bad-faith
 event-sequence-causation-analysis
 manufactured-crisis-timeline-indicators
 bad-faith-indicators
 ulterior-motive-analysis
 manufactured-urgency-indicators
 abuse-of-process-timing-indicators
 obstruction-timeline-analysis
 self-created-problem-estoppel
 temporal-adverse-inference
 trust-power-bypass-timeline-analysis
 trust-power-bypass-indicators
 platform-usage-timeline-analysis
 ongoing-enrichment-calculation
 card-cancellation-timeline
 settlement-negotiation-timeline)

;; Export framework
(provide timeline-event-integration-metadata
         temporal-but-for-causation
         timing-analysis-bad-faith
         manufactured-crisis-timeline-indicators
         obstruction-timeline-analysis
         trust-power-bypass-indicators
         card-cancellation-timeline)
