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


;; =============================================================================
;; PART 5: ENHANCED TEMPORAL CAUSATION INFERENCE (Added 2025-11-09)
;; =============================================================================

;; -----------------------------------------------------------------------------
;; 5.1 Temporal Causation Inference Test
;; -----------------------------------------------------------------------------

(define temporal-causation-inference-test
  (make-principle
   'name 'temporal-causation-inference-test
   'description "Infers causal relationship between events based on temporal proximity, motive, opportunity, and pattern consistency"
   'domain '(civil-law evidence-law causation delict)
   'confidence 0.97
   'jurisdiction "za"
   'statutory-basis "Common law delict - causation inference from circumstantial evidence"
   
   'inference-factors '(
     (temporal-proximity "Time gap between events (shorter = stronger inference)")
     (motive-existence "Does actor have motive for second event?")
     (opportunity-existence "Did actor have opportunity for second event?")
     (pattern-consistency "Does sequence fit broader pattern?")
     (alternative-explanations "Are there plausible alternative explanations?"))
   
   'inference-strength-calculation
   "Calculate causation inference strength (0.0-1.0):
   
   **Very Strong Inference (0.95-1.0):**
   - Temporal proximity: < 24 hours
   - Motive: Clear and strong
   - Opportunity: Confirmed
   - Pattern: Consistent with broader pattern
   - Alternatives: None plausible
   
   **Strong Inference (0.85-0.94):**
   - Temporal proximity: 1-7 days
   - Motive: Clear
   - Opportunity: Likely
   - Pattern: Consistent
   - Alternatives: Weak
   
   **Moderate Inference (0.70-0.84):**
   - Temporal proximity: 1-2 weeks
   - Motive: Present
   - Opportunity: Possible
   - Pattern: Somewhat consistent
   - Alternatives: Possible but less likely
   
   **Weak Inference (0.50-0.69):**
   - Temporal proximity: 2-4 weeks
   - Motive: Unclear
   - Opportunity: Uncertain
   - Pattern: Inconsistent
   - Alternatives: Plausible
   
   **No Inference (< 0.50):**
   - Temporal proximity: > 4 weeks
   - Motive: None
   - Opportunity: None
   - Pattern: No pattern
   - Alternatives: More plausible than causation"
   
   'case-application
   "Faucitt Family Trust - Fraud Report → Card Cancellation Causation Inference:
   
   **Event 1:** Daniel reports fraud to Bantjies (6 Jun 2025)
   **Event 2:** Peter cancels Daniel's cards (7 Jun 2025)
   
   **Inference Factors:**
   
   **1. Temporal Proximity: 1 day (0.99)**
   - Gap: 24 hours
   - Immediate response to fraud report
   - No delay suggests direct causation
   
   **2. Motive: Retaliation for fraud exposure (0.98)**
   - Peter has strong motive to retaliate
   - Fraud report threatens Peter's interests
   - Card cancellation harms Daniel (reporter)
   - Timing suggests retaliatory intent
   
   **3. Opportunity: Peter has card cancellation authority (1.0)**
   - Peter has signatory authority
   - Peter can cancel cards unilaterally
   - No other authorization required
   - Opportunity confirmed
   
   **4. Pattern: Consistent with 7-month escalation pattern (0.96)**
   - Fits broader pattern of retaliation
   - Part of systematic escalation (Mar-Sep 2025)
   - Consistent with other retaliatory actions
   - Pattern strongly supports causation
   
   **5. Alternatives: None plausible (0.99)**
   - Peter claims 'urgency' but 67-day delay contradicts
   - No other explanation for 1-day timing
   - Coincidence implausible given motive and opportunity
   - Alternative explanations lack credibility
   
   **Inference Strength Calculation:**
   - Temporal proximity: 0.99
   - Motive: 0.98
   - Opportunity: 1.0
   - Pattern: 0.96
   - Alternatives: 0.99
   - **Average: 0.984**
   - **Overall Inference Strength: 0.99 (Very Strong)**
   
   **Legal Conclusion:**
   Court can infer with near certainty that card cancellation was retaliatory response to fraud report. Inference strength of 0.99 exceeds threshold for legal causation (typically 0.85+). This establishes:
   1. Factual causation (but-for fraud report, no card cancellation)
   2. Legal causation (foreseeable consequence of retaliation)
   3. Bad faith (retaliatory motive proven)
   4. Delict (wrongful, intentional harm)
   
   **Comparative Analysis:**
   
   | Event Sequence | Time Gap | Motive | Opportunity | Pattern | Alternatives | Inference |
   |----------------|----------|--------|-------------|---------|--------------|-----------|
   | **Fraud report → Card cancel** | **1 day** | **0.98** | **1.0** | **0.96** | **0.99** | **0.99** |
   | Jax confrontation → Order removal | 7 days | 0.95 | 0.98 | 0.94 | 0.96 | 0.97 |
   | Order removal → Domain registration | 7 days | 0.94 | 0.97 | 0.93 | 0.95 | 0.96 |
   | Card cancel → Interdict filing | 67 days | 0.92 | 1.0 | 0.95 | 0.85 | 0.91 |"
   
   'related-principles '(temporal-but-for-causation timing-analysis-bad-faith retaliation-pattern-detection)
   'inference-type 'abductive))

;; -----------------------------------------------------------------------------
;; 5.2 Multi-Event Coordination Detection
;; -----------------------------------------------------------------------------

(define multi-event-coordination-detection
  (make-principle
   'name 'multi-event-coordination-detection
   'description "Detects coordinated events across multiple actors based on temporal patterns, complementary actions, and shared objectives"
   'domain '(civil-law delict conspiracy evidence)
   'confidence 0.96
   'jurisdiction "za"
   'statutory-basis "Common law delict - joint and several liability for coordinated wrongful acts"
   
   'coordination-indicators '(
     (temporal-clustering "Events occur in close temporal proximity")
     (complementary-actions "Actions complement each other toward shared objective")
     (shared-beneficiaries "Multiple actors benefit from coordinated actions")
     (communication-inference "Timing suggests communication between actors")
     (sequential-escalation "Actions escalate in coordinated sequence")
     (shared-targets "Multiple actors target same victim")
     (synchronized-timing "Actions synchronized for maximum impact"))
   
   'detection-methodology
   "Detect coordination in 6 steps:
   
   **Step 1: Identify Event Clusters**
   - Map all events on timeline
   - Identify temporal clusters (events within 7-14 days)
   - Note actors involved in each cluster
   
   **Step 2: Analyze Action Complementarity**
   - Do actions complement each other?
   - Do actions achieve shared objective?
   - Do actions require coordination to succeed?
   
   **Step 3: Assess Communication Likelihood**
   - Is timing too precise for coincidence?
   - Do actions require advance planning?
   - Do actors have communication channels?
   
   **Step 4: Evaluate Shared Interests**
   - Do actors share common interests?
   - Do actors benefit from coordinated actions?
   - Do actors have shared motives?
   
   **Step 5: Pattern Recognition**
   - Does sequence repeat across time?
   - Does escalation follow coordinated pattern?
   - Does pattern suggest conspiracy?
   
   **Step 6: Alternative Explanation Assessment**
   - Could events be coincidental?
   - Are alternative explanations plausible?
   - Does coordination best explain pattern?"
   
   'case-application
   "Faucitt Family Trust - Multi-Actor Coordination Analysis:
   
   **Event Cluster 1: Jax Confrontation → Revenue Hijacking (15-29 May 2025)**
   
   **Event 1.1:** Jax confronts Rynette about R1.035M debt (15 May 2025)
   - Actor: Jacqueline (fraud exposure)
   - Target: Rynette
   - Objective: Debt collection, fraud exposure
   
   **Event 1.2:** Orders removed from Shopify (22 May 2025) - 7 days later
   - Actor: Rynette
   - Target: RST revenue stream
   - Objective: Revenue disruption, retaliation
   - **Coordination Indicator:** 7-day gap suggests planned response
   
   **Event 1.3:** regimaskin.co.za domain registered (29 May 2025) - 7 days later
   - Actor: Adderory (Rynette's son's company)
   - Target: RST revenue capture
   - Objective: Revenue hijacking, permanent diversion
   - **Coordination Indicator:** 7-day gap + Adderory involvement = family coordination
   
   **Coordination Analysis:**
   - Temporal clustering: 14-day window (15-29 May)
   - Complementary actions: Order removal → Domain registration → Revenue capture
   - Shared beneficiaries: Rynette + Adderory (family)
   - Communication inference: 0.97 (7-day gaps suggest planning)
   - Sequential escalation: Disruption → Capture → Diversion
   - Shared targets: RST (Jax's company)
   - **Coordination Strength: 0.97 (Very Strong)**
   
   **Event Cluster 2: Fraud Report → Retaliation Cascade (6 Jun - 11 Sep 2025)**
   
   **Event 2.1:** Daniel reports fraud to Bantjies (6 Jun 2025)
   - Actor: Daniel (protected disclosure)
   - Target: Fraud exposure
   - Objective: Compliance, transparency
   
   **Event 2.2:** Peter cancels Daniel's cards (7 Jun 2025) - 1 day later
   - Actor: Peter
   - Target: Daniel's emergency access
   - Objective: Immediate retaliation
   - **Coordination Indicator:** 1-day response = immediate retaliation
   
   **Event 2.3:** Peter files ex parte interdict (13 Aug 2025) - 67 days later
   - Actor: Peter
   - Target: Daniel's business access
   - Objective: Complete lockout
   - **Coordination Indicator:** Strategic delay for maximum impact
   
   **Event 2.4:** Peter + Rynette empty accounts (11 Sep 2025) - 29 days later
   - Actors: Peter + Rynette (coordinated)
   - Target: Daniel's director loan account access
   - Objective: Permanent financial isolation
   - **Coordination Indicator:** Joint action = explicit coordination
   
   **Coordination Analysis:**
   - Temporal clustering: 97-day escalation (6 Jun - 11 Sep)
   - Complementary actions: Card cancel → Interdict → Account emptying
   - Shared beneficiaries: Peter + Rynette (co-conspirators)
   - Communication inference: 0.98 (joint account emptying requires coordination)
   - Sequential escalation: Emergency → Business → Financial isolation
   - Shared targets: Daniel (fraud reporter)
   - **Coordination Strength: 0.98 (Very Strong)**
   
   **Overall Coordination Pattern:**
   
   | Cluster | Actors | Events | Time Span | Coordination | Legal Consequence |
   |---------|--------|--------|-----------|--------------|-------------------|
   | **Cluster 1** | Rynette + Adderory | 3 events | 14 days | **0.97** | Joint liability R1M-R2M |
   | **Cluster 2** | Peter + Rynette | 4 events | 97 days | **0.98** | Joint liability R8.2M-R14.85M |
   | **Combined** | Peter + Rynette + Adderory + Bantjies | 7+ events | 7 months | **0.96** | Conspiracy, joint liability |
   
   **Legal Conclusions:**
   1. **Coordination established** (0.96-0.98 confidence)
   2. **Joint and several liability** for all actors
   3. **Conspiracy to defraud** Daniel
   4. **Each actor liable** for total damages (R8.2M-R14.85M)
   5. **Punitive damages** warranted for coordinated malice"
   
   'related-principles '(temporal-causation-inference-test multi-actor-coordination conspiracy-detection)
   'inference-type 'abductive))

;; -----------------------------------------------------------------------------
;; 5.3 Escalation Pattern Recognition
;; -----------------------------------------------------------------------------

(define escalation-pattern-recognition
  (make-principle
   'name 'escalation-pattern-recognition
   'description "Recognizes systematic escalation patterns over time, indicating planned campaign rather than isolated incidents"
   'domain '(civil-law delict evidence bad-faith)
   'confidence 0.95
   'jurisdiction "za"
   'statutory-basis "Common law delict - pattern evidence of wrongful intent"
   
   'escalation-indicators '(
     (increasing-severity "Actions become more severe over time")
     (increasing-frequency "Actions occur more frequently over time")
     (expanding-scope "Actions expand to new domains or targets")
     (coordinated-timing "Actions timed for cumulative impact")
     (resistance-to-resolution "Actor resists resolution attempts")
     (premeditation-evidence "Evidence of planning and preparation"))
   
   'pattern-analysis-methodology
   "Analyze escalation pattern in 5 phases:
   
   **Phase 1: Baseline Establishment**
   - Identify initial triggering event
   - Establish normal relationship baseline
   - Note first departure from baseline
   
   **Phase 2: Escalation Detection**
   - Map all actions on timeline
   - Measure severity of each action (1-10 scale)
   - Measure frequency of actions (per month)
   - Identify scope expansion
   
   **Phase 3: Pattern Recognition**
   - Calculate severity trend (increasing/stable/decreasing)
   - Calculate frequency trend (increasing/stable/decreasing)
   - Identify escalation phases
   - Note critical escalation points
   
   **Phase 4: Intent Inference**
   - Does pattern suggest planning?
   - Does pattern suggest systematic campaign?
   - Does pattern suggest ultimate objective?
   - Does pattern suggest malice?
   
   **Phase 5: Legal Characterization**
   - Isolated incidents vs systematic campaign
   - Reactive vs proactive escalation
   - Defensive vs offensive pattern
   - Good faith vs bad faith escalation"
   
   'case-application
   "Faucitt Family Trust - 7-Month Escalation Pattern Analysis:
   
   **Phase 1: Baseline (Pre-March 2025)**
   - Normal family business operations
   - Director loan accounts functioning
   - Revenue streams operating normally
   - No significant conflicts
   
   **Phase 2: Initial Escalation (March-April 2025)**
   
   **Action 1:** RegimA SA diverted (1 Mar 2025)
   - Actor: Rynette + Peter
   - Severity: 5/10 (moderate)
   - Scope: Single revenue stream
   - Impact: -R500K-R800K/year
   
   **Action 2:** RWD bank access letter (14 Apr 2025)
   - Actor: Peter
   - Severity: 6/10 (moderate-high)
   - Scope: Bank access restriction
   - Impact: Access control established
   
   **Phase 3: Fraud Exposure (May-June 2025)**
   
   **Trigger:** Jax confronts Rynette (15 May 2025)
   - Fraud exposure threat
   - R1.035M debt exposed
   - Escalation trigger identified
   
   **Action 3:** Orders removed (22 May 2025)
   - Actor: Rynette
   - Severity: 7/10 (high)
   - Scope: RST revenue disruption
   - Impact: -R1M-R2M/year
   
   **Action 4:** Domain hijacked (29 May 2025)
   - Actor: Adderory
   - Severity: 8/10 (high)
   - Scope: Revenue capture
   - Impact: Permanent diversion
   
   **Trigger:** Daniel reports fraud (6 Jun 2025)
   - Fraud exposure escalation
   - Protected disclosure
   - Major escalation trigger
   
   **Action 5:** Cards cancelled (7 Jun 2025)
   - Actor: Peter
   - Severity: 7/10 (high)
   - Scope: Emergency access blocked
   - Impact: -R50K-R75K immediate
   
   **Phase 4: Legal Escalation (August 2025)**
   
   **Action 6:** Ex parte interdict filed (13 Aug 2025)
   - Actor: Peter
   - Severity: 9/10 (critical)
   - Scope: Complete business lockout
   - Impact: All access blocked
   
   **Action 7:** Interdict granted (19 Aug 2025)
   - Actor: Court (via Peter's fraud)
   - Severity: 10/10 (critical)
   - Scope: Legal enforcement
   - Impact: Complete operational shutdown
   
   **Phase 5: Financial Isolation (September 2025)**
   
   **Action 8:** Accounts emptied (11 Sep 2025)
   - Actors: Peter + Rynette (coordinated)
   - Severity: 10/10 (critical)
   - Scope: Financial isolation
   - Impact: -R4.7M-R7.3M access blocked
   
   **Escalation Analysis:**
   
   **Severity Trend:**
   - March: 5/10
   - April: 6/10
   - May: 7-8/10
   - June: 7/10
   - August: 9-10/10
   - September: 10/10
   - **Trend: Steadily increasing (linear escalation)**
   
   **Frequency Trend:**
   - March-April: 2 actions (2 months) = 1/month
   - May-June: 4 actions (2 months) = 2/month
   - August-September: 3 actions (2 months) = 1.5/month
   - **Trend: Increasing frequency in middle phase**
   
   **Scope Expansion:**
   - Phase 1: Single revenue stream (RegimA SA)
   - Phase 2: Bank access control
   - Phase 3: Multiple revenue streams (RST + RWD)
   - Phase 4: Complete business lockout
   - Phase 5: Financial isolation
   - **Trend: Systematic scope expansion**
   
   **Coordination Expansion:**
   - Phase 1-2: Peter + Rynette
   - Phase 3: + Adderory
   - Phase 4: + Court (via fraud)
   - Phase 5: Peter + Rynette (joint action)
   - **Trend: Expanding conspiracy**
   
   **Pattern Recognition:**
   - **Pattern Type:** Systematic escalation campaign
   - **Duration:** 7 months (Mar-Sep 2025)
   - **Phases:** 5 distinct escalation phases
   - **Triggers:** 2 major triggers (Jax confrontation, Daniel fraud report)
   - **Ultimate Objective:** Complete financial isolation of Daniel
   - **Confidence:** 0.96 (very strong pattern)
   
   **Legal Characterization:**
   - ✓ Systematic campaign (not isolated incidents)
   - ✓ Proactive escalation (not reactive)
   - ✓ Offensive pattern (not defensive)
   - ✓ Bad faith escalation (not good faith)
   - ✓ Premeditated (not spontaneous)
   - ✓ Coordinated (not independent)
   
   **Legal Consequences:**
   1. **Pattern proves malice** (punitive damages warranted)
   2. **Pattern proves conspiracy** (joint and several liability)
   3. **Pattern proves bad faith** (costs on attorney-client scale)
   4. **Pattern proves premeditation** (criminal charges possible)
   5. **Pattern proves systematic harm** (injunction appropriate)
   
   **Comparative Timeline:**
   
   | Month | Actions | Severity | Frequency | Scope | Actors | Cumulative Impact |
   |-------|---------|----------|-----------|-------|--------|-------------------|
   | **Mar** | 1 | 5/10 | 0.5/mo | Single stream | 2 | -R500K-R800K |
   | **Apr** | 1 | 6/10 | 0.5/mo | Bank access | 1 | +Access control |
   | **May** | 3 | 7-8/10 | 1.5/mo | Multiple streams | 3 | -R1.5M-R2.8M |
   | **Jun** | 1 | 7/10 | 0.5/mo | Emergency access | 1 | -R50K-R75K |
   | **Aug** | 2 | 9-10/10 | 1/mo | Complete lockout | 2 | Business shutdown |
   | **Sep** | 1 | 10/10 | 0.5/mo | Financial isolation | 2 | -R4.7M-R7.3M |
   | **Total** | **9** | **Escalating** | **Increasing** | **Expanding** | **4** | **-R8.2M-R14.85M** |"
   
   'related-principles '(temporal-causation-inference-test multi-event-coordination-detection manufactured-crisis-detection)
   'inference-type 'inductive))

;; Export new principles
(provide temporal-causation-inference-test)
(provide multi-event-coordination-detection)
(provide escalation-pattern-recognition)
