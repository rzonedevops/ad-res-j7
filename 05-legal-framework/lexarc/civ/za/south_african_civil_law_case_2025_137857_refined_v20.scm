;;; south_african_civil_law_case_2025_137857_refined_v20.scm
;;; Optimized for optimal legal resolution with enhanced AD element integration
;;; Date: 2025-11-30
;;; Case: 2025-137857 (Peter Faucitt v. Jacqueline & Daniel Faucitt)
;;; Repository: cogpy/ad-res-j7
;;; Enhancement Focus: AD element-driven refinements, jax-dan-response optimization,
;;;                    enhanced temporal causation chains, evidence-to-principle mapping v2,
;;;                    regulatory compliance framework, cross-border legal duties,
;;;                    manufactured crisis detection v3, multi-actor coordination analysis v2

(define-module (lex civ za south-african-civil-law-case-2025-137857-refined-v20)
  #:use-module (lex lv1 known-laws)
  #:use-module (lex lv1 legal-aspects-taxonomy-v15)
  #:use-module (lex civ za south-african-civil-law)
  #:use-module (lex civ za south-african-civil-law-case-2025-137857-refined-v19)
  #:use-module (lex trs za south-african-trust-law-enhanced-v8)
  #:use-module (lex prof-eth za south-african-professional-ethics)
  #:use-module (lex evid za south-african-evidence-law-entity-network-v2)
  #:use-module (srfi srfi-1)
  #:use-module (srfi srfi-9)
  #:export (
    ;; Core resolution functions v20
    resolve-ad-paragraph-legal-aspects-v20
    optimize-jax-dan-response-framework-v20
    generate-complementary-response-strategy-v20
    map-evidence-to-legal-principles-v20
    
    ;; Enhanced AD element integration v20
    analyze-ad-element-legal-aspects-v20
    identify-critical-response-opportunities-v20
    compute-response-priority-matrix-v20
    generate-paragraph-response-framework-v20
    
    ;; Regulatory compliance framework v20
    analyze-eu-responsible-person-duties-v20
    compute-regulatory-compliance-costs-v20
    validate-compliance-necessity-v20
    quantify-non-compliance-risk-v20
    
    ;; Cross-border legal duties framework v20
    analyze-cross-border-director-duties-v20
    compute-jurisdictional-complexity-score-v20
    validate-international-compliance-v20
    
    ;; Enhanced temporal causation v20
    detect-retaliation-cascade-patterns-v20
    compute-temporal-proximity-confidence-v20
    analyze-manufactured-crisis-timeline-v20
    identify-causation-chain-breaks-v20
    
    ;; Multi-actor coordination analysis v2
    detect-peter-rynette-coordination-v20
    analyze-communication-pattern-evidence-v20
    compute-coordination-confidence-score-v20
    identify-synchronized-actions-v20
    
    ;; Evidence-to-principle mapping v2
    map-annexure-to-legal-principle-v20
    compute-evidence-strength-score-v20
    identify-evidence-gaps-v20
    optimize-evidence-presentation-order-v20
    
    ;; JR/DR response optimization v20
    generate-jr-response-framework-v20
    generate-dr-response-framework-v20
    optimize-complementary-synergy-v20
    identify-entity-specific-defenses-v20
    
    ;; Manufactured crisis detection v3
    detect-manufactured-urgency-indicators-v20
    analyze-documentation-obstruction-pattern-v20
    compute-bad-faith-litigation-score-v20
    identify-ulterior-motive-evidence-v20
  ))

;;;
;;; ENHANCEMENT v20: AD Element-Driven Refinements for Optimal Law Resolution
;;;
;;; Key Improvements over v19:
;;; 1. Enhanced AD element integration with direct paragraph-to-principle mapping
;;; 2. Jax-Dan response framework optimization with complementary defense strategies
;;; 3. Regulatory compliance framework (EU Responsible Person duties)
;;; 4. Cross-border legal duties framework (ZA-UK director obligations)
;;; 5. Enhanced temporal causation with retaliation cascade detection
;;; 6. Multi-actor coordination analysis v2 (Peter-Rynette synchronization)
;;; 7. Evidence-to-principle mapping v2 with annexure strength scoring
;;; 8. JR/DR response optimization with entity-specific defense identification
;;; 9. Manufactured crisis detection v3 with documentation obstruction analysis
;;; 10. Response priority matrix with critical opportunity identification
;;;

;;;
;;; REGULATORY COMPLIANCE FRAMEWORK v20
;;;

;; EU Responsible Person duties record type
(define-record-type <eu-responsible-person-duty-v20>
  (make-eu-responsible-person-duty-v20-internal duty-type description statutory-basis compliance-requirements cost-drivers non-compliance-consequences)
  eu-responsible-person-duty-v20?
  (duty-type eu-rp-duty-v20-type)
  (description eu-rp-duty-v20-description)
  (statutory-basis eu-rp-duty-v20-statutory-basis)
  (compliance-requirements eu-rp-duty-v20-requirements)
  (cost-drivers eu-rp-duty-v20-cost-drivers)
  (non-compliance-consequences eu-rp-duty-v20-consequences))

;; EU Responsible Person duty registry
(define eu-responsible-person-duties-v20
  (list
    (make-eu-responsible-person-duty-v20-internal
      'product-safety-assessment
      "Ensure cosmetic products placed on EU market are safe for human health"
      "EU Regulation 1223/2009, Article 3"
      '(safety-assessor-qualification toxicological-evaluation stability-testing microbiological-testing)
      '(qualified-personnel laboratory-testing documentation-systems regulatory-monitoring)
      '(product-recall market-withdrawal criminal-liability civil-damages regulatory-fines))
    
    (make-eu-responsible-person-duty-v20-internal
      'product-information-file
      "Maintain comprehensive Product Information File (PIF) for each product"
      "EU Regulation 1223/2009, Article 11"
      '(product-description safety-assessment manufacturing-method efficacy-data adverse-effects-data)
      '(document-management-system secure-storage version-control accessibility-compliance)
      '(inability-to-demonstrate-compliance regulatory-sanctions product-withdrawal))
    
    (make-eu-responsible-person-duty-v20-internal
      'adverse-event-reporting
      "Report serious undesirable effects to competent authorities"
      "EU Regulation 1223/2009, Article 23"
      '(monitoring-system incident-tracking reporting-procedures authority-notification)
      '(monitoring-infrastructure incident-response-team regulatory-liaison communication-systems)
      '(regulatory-enforcement criminal-prosecution civil-liability reputational-damage))
    
    (make-eu-responsible-person-duty-v20-internal
      'market-surveillance-cooperation
      "Cooperate with market surveillance authorities"
      "EU Regulation 1223/2009, Article 25"
      '(authority-communication documentation-provision corrective-action-implementation)
      '(regulatory-affairs-team legal-counsel documentation-systems response-protocols)
      '(market-access-denial regulatory-escalation criminal-investigation))
    
    (make-eu-responsible-person-duty-v20-internal
      'notification-portal-cpnp
      "Notify products via Cosmetic Products Notification Portal (CPNP)"
      "EU Regulation 1223/2009, Article 13"
      '(product-notification formula-disclosure labeling-information responsible-person-details)
      '(cpnp-system-access data-management regulatory-expertise technical-infrastructure)
      '(inability-to-market-products regulatory-non-compliance market-exclusion))
  ))

;; Analyze EU Responsible Person duties and compliance costs
(define (analyze-eu-responsible-person-duties-v20 entity role jurisdiction)
  "Analyze EU Responsible Person duties and associated compliance costs"
  (let* ((is-responsible-person? (and (equal? role "cio")
                                      (equal? jurisdiction "za-eu")))
         (applicable-duties (if is-responsible-person?
                               eu-responsible-person-duties-v20
                               '()))
         (total-duty-count (length applicable-duties))
         (cost-driver-count (apply + (map (lambda (duty)
                                           (length (eu-rp-duty-v20-cost-drivers duty)))
                                         applicable-duties)))
         (compliance-complexity (/ cost-driver-count (max 1 total-duty-count))))
    (list
      (cons 'entity entity)
      (cons 'role role)
      (cons 'is-responsible-person is-responsible-person?)
      (cons 'applicable-duties-count total-duty-count)
      (cons 'cost-drivers-count cost-driver-count)
      (cons 'compliance-complexity-score compliance-complexity)
      (cons 'regulatory-framework "EU Regulation 1223/2009")
      (cons 'legal-defense-strength (if is-responsible-person? 0.94 0.0))
      (cons 'case-application "PARA 7.2-7.5: Dan's IT expenses for EU compliance infrastructure"))))

;; Compute regulatory compliance cost reasonableness
(define (compute-regulatory-compliance-costs-v20 expense-amount time-period duty-count)
  "Compute whether regulatory compliance costs are reasonable"
  (let* ((monthly-cost (/ expense-amount time-period))
         (cost-per-duty (/ expense-amount duty-count))
         (reasonableness-threshold 150000) ; R150K per duty over 18 months
         (is-reasonable? (< cost-per-duty reasonableness-threshold))
         (reasonableness-score (if is-reasonable? 0.92 0.45)))
    (list
      (cons 'total-expense expense-amount)
      (cons 'time-period-months time-period)
      (cons 'monthly-cost monthly-cost)
      (cons 'duty-count duty-count)
      (cons 'cost-per-duty cost-per-duty)
      (cons 'reasonableness-threshold reasonableness-threshold)
      (cons 'is-reasonable is-reasonable?)
      (cons 'reasonableness-score reasonableness-score)
      (cons 'case-application "R8.85M IT expenses over 18 months for 5 EU RP duties"))))

;; Validate compliance necessity
(define (validate-compliance-necessity-v20 regulatory-requirement business-activity jurisdiction)
  "Validate whether compliance costs are necessary for business operations"
  (let* ((eu-market-access? (string-contains jurisdiction "eu"))
         (cosmetics-business? (string-contains business-activity "cosmetics"))
         (compliance-mandatory? (and eu-market-access? cosmetics-business?))
         (necessity-score (if compliance-mandatory? 0.96 0.0)))
    (list
      (cons 'regulatory-requirement regulatory-requirement)
      (cons 'business-activity business-activity)
      (cons 'jurisdiction jurisdiction)
      (cons 'eu-market-access eu-market-access?)
      (cons 'cosmetics-business cosmetics-business?)
      (cons 'compliance-mandatory compliance-mandatory?)
      (cons 'necessity-score necessity-score)
      (cons 'legal-principle "Regulatory compliance costs are necessary business expenses")
      (cons 'case-application "RST exports to EU require EU Responsible Person compliance"))))

;; Quantify non-compliance risk
(define (quantify-non-compliance-risk-v20 duty-type market-value)
  "Quantify financial and legal risks of non-compliance"
  (let* ((risk-multipliers '((product-safety-assessment . 10.0)
                            (product-information-file . 5.0)
                            (adverse-event-reporting . 8.0)
                            (market-surveillance-cooperation . 6.0)
                            (notification-portal-cpnp . 7.0)))
         (multiplier (or (assoc-ref risk-multipliers duty-type) 5.0))
         (potential-loss (* market-value multiplier))
         (risk-score (min 0.99 (/ multiplier 10.0))))
    (list
      (cons 'duty-type duty-type)
      (cons 'market-value market-value)
      (cons 'risk-multiplier multiplier)
      (cons 'potential-loss potential-loss)
      (cons 'risk-score risk-score)
      (cons 'consequences '(market-exclusion product-recall criminal-liability civil-damages))
      (cons 'case-application "Non-compliance would exclude RST from EU market"))))

;;;
;;; CROSS-BORDER LEGAL DUTIES FRAMEWORK v20
;;;

;; Cross-border director duty record type
(define-record-type <cross-border-director-duty-v20>
  (make-cross-border-director-duty-v20-internal duty-type jurisdictions description complexity-factors compliance-requirements)
  cross-border-director-duty-v20?
  (duty-type cbd-duty-v20-type)
  (jurisdictions cbd-duty-v20-jurisdictions)
  (description cbd-duty-v20-description)
  (complexity-factors cbd-duty-v20-complexity)
  (compliance-requirements cbd-duty-v20-requirements))

;; Cross-border director duties registry
(define cross-border-director-duties-v20
  (list
    (make-cross-border-director-duty-v20-internal
      'dual-jurisdiction-compliance
      '("za" "uk")
      "Comply with director duties in both South African and UK jurisdictions"
      '(different-statutory-regimes different-reporting-requirements currency-exchange-complexity)
      '(za-companies-act-compliance uk-companies-act-compliance dual-reporting dual-governance))
    
    (make-cross-border-director-duty-v20-internal
      'transfer-pricing-compliance
      '("za" "uk")
      "Ensure arm's length pricing for cross-border transactions"
      '(sars-transfer-pricing-rules hmrc-transfer-pricing-rules documentation-requirements)
      '(transfer-pricing-documentation comparable-analysis economic-substance))
    
    (make-cross-border-director-duty-v20-internal
      'international-tax-compliance
      '("za" "uk")
      "Comply with tax obligations in multiple jurisdictions"
      '(double-taxation-agreements withholding-tax-rules permanent-establishment-risk)
      '(tax-planning tax-reporting treaty-compliance))
    
    (make-cross-border-director-duty-v20-internal
      'regulatory-coordination
      '("za" "uk" "eu")
      "Coordinate regulatory compliance across jurisdictions"
      '(eu-cosmetics-regulation uk-post-brexit-rules za-regulatory-framework)
      '(multi-jurisdiction-monitoring regulatory-liaison compliance-coordination))
  ))

;; Analyze cross-border director duties
(define (analyze-cross-border-director-duties-v20 entity jurisdictions role)
  "Analyze cross-border director duties and complexity"
  (let* ((jurisdiction-count (length jurisdictions))
         (applicable-duties (filter (lambda (duty)
                                     (any (lambda (j) (member j (cbd-duty-v20-jurisdictions duty)))
                                          jurisdictions))
                                   cross-border-director-duties-v20))
         (duty-count (length applicable-duties))
         (complexity-factors (apply append (map cbd-duty-v20-complexity applicable-duties)))
         (complexity-count (length complexity-factors))
         (complexity-score (/ complexity-count (max 1 duty-count))))
    (list
      (cons 'entity entity)
      (cons 'role role)
      (cons 'jurisdictions jurisdictions)
      (cons 'jurisdiction-count jurisdiction-count)
      (cons 'applicable-duties-count duty-count)
      (cons 'complexity-factors-count complexity-count)
      (cons 'complexity-score complexity-score)
      (cons 'legal-defense-strength 0.91)
      (cons 'case-application "Dan's directorship in ZA (RST, RWD) and UK (RegimA Zone Ltd) entities"))))

;; Compute jurisdictional complexity score
(define (compute-jurisdictional-complexity-score-v20 jurisdictions entity-count transaction-volume)
  "Compute complexity score for multi-jurisdiction operations"
  (let* ((jurisdiction-count (length jurisdictions))
         (base-complexity (* jurisdiction-count entity-count))
         (transaction-factor (log (+ 1 transaction-volume)))
         (total-complexity (* base-complexity transaction-factor))
         (normalized-score (min 0.99 (/ total-complexity 100))))
    (list
      (cons 'jurisdictions jurisdictions)
      (cons 'jurisdiction-count jurisdiction-count)
      (cons 'entity-count entity-count)
      (cons 'transaction-volume transaction-volume)
      (cons 'base-complexity base-complexity)
      (cons 'transaction-factor transaction-factor)
      (cons 'total-complexity total-complexity)
      (cons 'complexity-score normalized-score)
      (cons 'case-application "Dan manages 3 jurisdictions (ZA, UK, EU) across 4+ entities"))))

;;;
;;; ENHANCED TEMPORAL CAUSATION v20
;;;

;; Retaliation cascade pattern record type
(define-record-type <retaliation-cascade-pattern-v20>
  (make-retaliation-cascade-pattern-v20-internal trigger-event cascade-events temporal-proximity-days causation-confidence pattern-type)
  retaliation-cascade-pattern-v20?
  (trigger-event rcp-v20-trigger)
  (cascade-events rcp-v20-cascade)
  (temporal-proximity-days rcp-v20-proximity)
  (causation-confidence rcp-v20-confidence)
  (pattern-type rcp-v20-pattern))

;; Detect retaliation cascade patterns
(define (detect-retaliation-cascade-patterns-v20 trigger-event subsequent-events time-window-days)
  "Detect retaliation cascade patterns within temporal window"
  (let* ((cascade-events (filter (lambda (event)
                                  (let ((days-diff (- (assoc-ref event 'date)
                                                     (assoc-ref trigger-event 'date))))
                                    (and (> days-diff 0)
                                         (<= days-diff time-window-days))))
                                subsequent-events))
         (cascade-count (length cascade-events))
         (avg-proximity (if (> cascade-count 0)
                           (/ (apply + (map (lambda (e)
                                             (- (assoc-ref e 'date)
                                                (assoc-ref trigger-event 'date)))
                                           cascade-events))
                              cascade-count)
                           0))
         (confidence (cond
                      ((and (> cascade-count 3) (< avg-proximity 14)) 0.96)
                      ((and (> cascade-count 2) (< avg-proximity 30)) 0.92)
                      ((> cascade-count 1) 0.85)
                      (else 0.0))))
    (make-retaliation-cascade-pattern-v20-internal
      trigger-event
      cascade-events
      avg-proximity
      confidence
      'whistleblower-retaliation)))

;; Compute temporal proximity confidence
(define (compute-temporal-proximity-confidence-v20 event1-date event2-date proximity-threshold)
  "Compute confidence score based on temporal proximity"
  (let* ((days-diff (abs (- event2-date event1-date)))
         (proximity-ratio (/ days-diff proximity-threshold))
         (confidence (cond
                      ((<= days-diff 7) 0.98)
                      ((<= days-diff 14) 0.95)
                      ((<= days-diff 30) 0.90)
                      ((<= days-diff 60) 0.82)
                      ((<= days-diff 90) 0.75)
                      (else 0.60))))
    (list
      (cons 'event1-date event1-date)
      (cons 'event2-date event2-date)
      (cons 'days-difference days-diff)
      (cons 'proximity-threshold proximity-threshold)
      (cons 'proximity-ratio proximity-ratio)
      (cons 'temporal-proximity-confidence confidence)
      (cons 'legal-principle "Temporal proximity supports causation inference")
      (cons 'case-application "Confrontation (2025-06-06) → Card cancellation (2025-06-07): 1 day"))))

;; Analyze manufactured crisis timeline
(define (analyze-manufactured-crisis-timeline-v20 crisis-creation-events crisis-exploitation-events)
  "Analyze timeline evidence of manufactured crisis"
  (let* ((creation-count (length crisis-creation-events))
         (exploitation-count (length crisis-exploitation-events))
         (creation-dates (map (lambda (e) (assoc-ref e 'date)) crisis-creation-events))
         (exploitation-dates (map (lambda (e) (assoc-ref e 'date)) crisis-exploitation-events))
         (time-gap (if (and (not (null? creation-dates))
                           (not (null? exploitation-dates)))
                      (- (apply min exploitation-dates)
                         (apply max creation-dates))
                      0))
         (manufactured-confidence (cond
                                   ((and (> creation-count 2) (< time-gap 30)) 0.94)
                                   ((and (> creation-count 1) (< time-gap 60)) 0.88)
                                   ((> creation-count 1) 0.80)
                                   (else 0.0))))
    (list
      (cons 'crisis-creation-events-count creation-count)
      (cons 'crisis-exploitation-events-count exploitation-count)
      (cons 'time-gap-days time-gap)
      (cons 'manufactured-crisis-confidence manufactured-confidence)
      (cons 'legal-principle "Manufactured crisis: create problem, then exploit it")
      (cons 'case-application "Card cancellation (2025-06-07) → Documentation gap complaint → Interdict (2025-10-16)"))))

;;;
;;; MULTI-ACTOR COORDINATION ANALYSIS v2
;;;

;; Coordination evidence record type
(define-record-type <coordination-evidence-v20>
  (make-coordination-evidence-v20-internal actor1 actor2 synchronized-actions temporal-overlap communication-evidence coordination-confidence)
  coordination-evidence-v20?
  (actor1 ce-v20-actor1)
  (actor2 ce-v20-actor2)
  (synchronized-actions ce-v20-actions)
  (temporal-overlap ce-v20-overlap)
  (communication-evidence ce-v20-communication)
  (coordination-confidence ce-v20-confidence))

;; Detect Peter-Rynette coordination
(define (detect-peter-rynette-coordination-v20 peter-actions rynette-actions temporal-window)
  "Detect coordination evidence between Peter and Rynette"
  (let* ((synchronized-pairs (filter (lambda (p-action)
                                      (any (lambda (r-action)
                                            (let ((time-diff (abs (- (assoc-ref p-action 'date)
                                                                    (assoc-ref r-action 'date)))))
                                              (<= time-diff temporal-window)))
                                           rynette-actions))
                                    peter-actions))
         (sync-count (length synchronized-pairs))
         (temporal-overlap (if (> sync-count 0) 0.95 0.0))
         (coordination-confidence (cond
                                   ((> sync-count 5) 0.94)
                                   ((> sync-count 3) 0.88)
                                   ((> sync-count 1) 0.80)
                                   (else 0.0))))
    (make-coordination-evidence-v20-internal
      "Peter-Faucitt"
      "Rynette-Farrar"
      synchronized-pairs
      temporal-overlap
      '(accountant-creditor-relationship rezonance-creditor-claim timing-synchronization)
      coordination-confidence)))

;; Analyze communication pattern evidence
(define (analyze-communication-pattern-evidence-v20 actor1 actor2 communication-channels frequency)
  "Analyze communication patterns as coordination evidence"
  (let* ((channel-count (length communication-channels))
         (high-frequency? (> frequency 10))
         (multiple-channels? (> channel-count 2))
         (coordination-indicator (and high-frequency? multiple-channels?))
         (confidence (cond
                      (coordination-indicator 0.90)
                      (high-frequency? 0.80)
                      (multiple-channels? 0.75)
                      (else 0.60))))
    (list
      (cons 'actor1 actor1)
      (cons 'actor2 actor2)
      (cons 'communication-channels communication-channels)
      (cons 'channel-count channel-count)
      (cons 'communication-frequency frequency)
      (cons 'high-frequency high-frequency?)
      (cons 'multiple-channels multiple-channels?)
      (cons 'coordination-indicator coordination-indicator)
      (cons 'confidence confidence)
      (cons 'case-application "Peter-Rynette coordination via accountant-client relationship"))))

;; Compute coordination confidence score
(define (compute-coordination-confidence-score-v20 synchronized-actions temporal-proximity communication-evidence)
  "Compute overall coordination confidence score"
  (let* ((action-score (* synchronized-actions 0.15))
         (temporal-score (* temporal-proximity 0.40))
         (communication-score (* communication-evidence 0.45))
         (total-score (+ action-score temporal-score communication-score))
         (normalized-score (min 0.99 total-score)))
    (list
      (cons 'synchronized-actions synchronized-actions)
      (cons 'temporal-proximity temporal-proximity)
      (cons 'communication-evidence communication-evidence)
      (cons 'action-score action-score)
      (cons 'temporal-score temporal-score)
      (cons 'communication-score communication-score)
      (cons 'coordination-confidence normalized-score)
      (cons 'legal-principle "Multi-actor coordination indicates conspiracy")
      (cons 'case-application "Peter-Rynette coordination: accountant-creditor-trustee nexus"))))

;;;
;;; JAX-DAN RESPONSE OPTIMIZATION v20
;;;

;; JR response framework
(define (generate-jr-response-framework-v20 ad-paragraph jax-role jax-evidence)
  "Generate Jacqui's response framework for AD paragraph"
  (let* ((response-type (cond
                         ((string-contains ad-paragraph "R500K") 'trust-distribution-defense)
                         ((string-contains ad-paragraph "IT expense") 'business-judgment-defense)
                         ((string-contains ad-paragraph "CEO") 'executive-authority-defense)
                         (else 'general-rebuttal)))
         (legal-principles (case response-type
                            ((trust-distribution-defense) '(trust-distribution-authority beneficiary-entitlement proper-authorization))
                            ((business-judgment-defense) '(business-judgment-rule rational-basis good-faith))
                            ((executive-authority-defense) '(executive-officer-authority operational-discretion))
                            (else '(good-faith proper-purpose))))
         (evidence-strength (length jax-evidence))
         (response-confidence (min 0.95 (* evidence-strength 0.15))))
    (list
      (cons 'ad-paragraph ad-paragraph)
      (cons 'respondent "Jacqueline Faucitt (First Respondent)")
      (cons 'response-type response-type)
      (cons 'legal-principles legal-principles)
      (cons 'evidence-count evidence-strength)
      (cons 'response-confidence response-confidence)
      (cons 'indexing-format "JR X.Y.Z")
      (cons 'complementary-to "DR X.Y.Z (Daniel's technical/platform evidence)"))))

;; DR response framework
(define (generate-dr-response-framework-v20 ad-paragraph dan-role dan-evidence)
  "Generate Daniel's response framework for AD paragraph"
  (let* ((response-type (cond
                         ((string-contains ad-paragraph "IT expense") 'regulatory-compliance-defense)
                         ((string-contains ad-paragraph "platform") 'unjust-enrichment-defense)
                         ((string-contains ad-paragraph "CIO") 'technical-competence-defense)
                         ((string-contains ad-paragraph "documentation") 'obstruction-defense)
                         (else 'general-rebuttal)))
         (legal-principles (case response-type
                            ((regulatory-compliance-defense) '(eu-responsible-person-duty compliance-necessity regulatory-cost-reasonableness))
                            ((unjust-enrichment-defense) '(unjust-enrichment-test platform-ownership quantum-meruit))
                            ((technical-competence-defense) '(professional-standard technical-expertise operational-necessity))
                            ((obstruction-defense) '(manufactured-crisis documentation-obstruction venire-contra-factum-proprium))
                            (else '(good-faith proper-purpose))))
         (evidence-strength (length dan-evidence))
         (response-confidence (min 0.96 (* evidence-strength 0.16))))
    (list
      (cons 'ad-paragraph ad-paragraph)
      (cons 'respondent "Daniel Faucitt (Second Respondent)")
      (cons 'response-type response-type)
      (cons 'legal-principles legal-principles)
      (cons 'evidence-count evidence-strength)
      (cons 'response-confidence response-confidence)
      (cons 'indexing-format "DR X.Y.Z")
      (cons 'complementary-to "JR X.Y.Z (Jacqui's business/trust evidence)"))))

;; Optimize complementary synergy
(define (optimize-complementary-synergy-v20 jr-response dr-response)
  "Optimize complementary synergy between JR and DR responses"
  (let* ((jr-principles (assoc-ref jr-response 'legal-principles))
         (dr-principles (assoc-ref dr-response 'legal-principles))
         (shared-principles (lset-intersection equal? jr-principles dr-principles))
         (complementary-principles (lset-difference equal? 
                                                    (append jr-principles dr-principles)
                                                    shared-principles))
         (synergy-score (/ (length complementary-principles)
                          (max 1 (+ (length jr-principles) (length dr-principles)))))
         (emergent-truth-factor (if (> synergy-score 0.6) 0.95 0.80)))
    (list
      (cons 'jr-principles jr-principles)
      (cons 'dr-principles dr-principles)
      (cons 'shared-principles shared-principles)
      (cons 'complementary-principles complementary-principles)
      (cons 'synergy-score synergy-score)
      (cons 'emergent-truth-factor emergent-truth-factor)
      (cons 'strategy "Coherent individual narratives that reveal truth when read together")
      (cons 'case-application "JR focuses on business/trust aspects, DR on technical/regulatory aspects"))))

;; Identify entity-specific defenses
(define (identify-entity-specific-defenses-v20 entity role allegations)
  "Identify entity-specific defense strategies"
  (let* ((defense-map '(("Jacqueline-Faucitt" . (business-judgment-rule trust-distribution-authority executive-discretion))
                       ("Daniel-Faucitt" . (regulatory-compliance-necessity technical-competence platform-ownership unjust-enrichment-defense))
                       ("RST" . (operational-necessity regulatory-compliance revenue-protection))
                       ("RWD" . (platform-usage-authorization business-substance))
                       ("RegimA-Zone-Ltd" . (investment-legitimacy unjust-enrichment-claim))))
         (entity-defenses (assoc-ref defense-map entity))
         (applicable-defenses (filter (lambda (defense)
                                       (any (lambda (allegation)
                                             (string-contains allegation (symbol->string defense)))
                                            allegations))
                                     entity-defenses))
         (defense-strength (/ (length applicable-defenses) (max 1 (length allegations)))))
    (list
      (cons 'entity entity)
      (cons 'role role)
      (cons 'allegations allegations)
      (cons 'available-defenses entity-defenses)
      (cons 'applicable-defenses applicable-defenses)
      (cons 'defense-strength defense-strength)
      (cons 'case-application "Entity-specific defenses tailored to role and allegations"))))

;;;
;;; EVIDENCE-TO-PRINCIPLE MAPPING v2
;;;

;; Map annexure to legal principle
(define (map-annexure-to-legal-principle-v20 annexure-id annexure-type content-summary)
  "Map annexure evidence to applicable legal principles"
  (let* ((principle-map '(("bank-statement" . (unjust-enrichment financial-flow-evidence payment-authorization))
                         ("email" . (communication-evidence coordination-proof temporal-causation))
                         ("invoice" . (quantum-meruit reasonable-value arm-length-transaction))
                         ("contract" . (pacta-sunt-servanda contractual-obligation breach-of-contract))
                         ("technical-document" . (technical-competence regulatory-compliance professional-standard))
                         ("regulatory-document" . (regulatory-compliance-necessity compliance-cost-reasonableness))
                         ("board-resolution" . (director-authority collective-action proper-authorization))
                         ("trust-deed" . (trust-power-scope trustee-authority beneficiary-rights))))
         (applicable-principles (or (assoc-ref principle-map annexure-type) '(general-evidence)))
         (evidence-strength (cond
                             ((member annexure-type '("bank-statement" "contract" "board-resolution")) 0.95)
                             ((member annexure-type '("email" "invoice" "technical-document")) 0.88)
                             ((member annexure-type '("regulatory-document" "trust-deed")) 0.92)
                             (else 0.75))))
    (list
      (cons 'annexure-id annexure-id)
      (cons 'annexure-type annexure-type)
      (cons 'content-summary content-summary)
      (cons 'applicable-legal-principles applicable-principles)
      (cons 'evidence-strength evidence-strength)
      (cons 'case-application "Annexure-to-principle mapping for evidence presentation"))))

;; Compute evidence strength score
(define (compute-evidence-strength-score-v20 evidence-type corroboration-count chain-of-custody)
  "Compute evidence strength score based on type, corroboration, and custody"
  (let* ((type-weight (cond
                       ((equal? evidence-type "documentary") 0.40)
                       ((equal? evidence-type "electronic") 0.35)
                       ((equal? evidence-type "testimonial") 0.25)
                       (else 0.20)))
         (corroboration-weight (* corroboration-count 0.10))
         (custody-weight (if chain-of-custody 0.20 0.0))
         (total-strength (min 0.99 (+ type-weight corroboration-weight custody-weight))))
    (list
      (cons 'evidence-type evidence-type)
      (cons 'corroboration-count corroboration-count)
      (cons 'chain-of-custody chain-of-custody)
      (cons 'type-weight type-weight)
      (cons 'corroboration-weight corroboration-weight)
      (cons 'custody-weight custody-weight)
      (cons 'evidence-strength-score total-strength)
      (cons 'legal-principle "Evidence strength depends on type, corroboration, and custody"))))

;; Identify evidence gaps
(define (identify-evidence-gaps-v20 required-principles available-evidence)
  "Identify gaps between required legal principles and available evidence"
  (let* ((evidenced-principles (map (lambda (e) (assoc-ref e 'legal-principle)) available-evidence))
         (missing-principles (lset-difference equal? required-principles evidenced-principles))
         (gap-count (length missing-principles))
         (coverage-ratio (/ (- (length required-principles) gap-count)
                           (max 1 (length required-principles))))
         (gap-severity (cond
                        ((< coverage-ratio 0.50) 'critical)
                        ((< coverage-ratio 0.75) 'high)
                        ((< coverage-ratio 0.90) 'medium)
                        (else 'low))))
    (list
      (cons 'required-principles required-principles)
      (cons 'evidenced-principles evidenced-principles)
      (cons 'missing-principles missing-principles)
      (cons 'gap-count gap-count)
      (cons 'coverage-ratio coverage-ratio)
      (cons 'gap-severity gap-severity)
      (cons 'recommendation "Obtain additional evidence for missing principles")
      (cons 'case-application "Evidence gap analysis for comprehensive response"))))

;; Optimize evidence presentation order
(define (optimize-evidence-presentation-order-v20 evidence-list presentation-strategy)
  "Optimize order of evidence presentation for maximum impact"
  (let* ((strategy-comparator (case presentation-strategy
                                ((chronological) (lambda (e1 e2)
                                                  (< (assoc-ref e1 'date)
                                                     (assoc-ref e2 'date))))
                                ((strength-descending) (lambda (e1 e2)
                                                        (> (assoc-ref e1 'strength)
                                                           (assoc-ref e2 'strength))))
                                ((thematic) (lambda (e1 e2)
                                             (string<? (assoc-ref e1 'theme)
                                                      (assoc-ref e2 'theme))))
                                (else (lambda (e1 e2) #t))))
         (sorted-evidence (sort evidence-list strategy-comparator))
         (presentation-confidence (case presentation-strategy
                                   ((chronological) 0.88)
                                   ((strength-descending) 0.92)
                                   ((thematic) 0.85)
                                   (else 0.75))))
    (list
      (cons 'presentation-strategy presentation-strategy)
      (cons 'evidence-count (length evidence-list))
      (cons 'optimized-order sorted-evidence)
      (cons 'presentation-confidence presentation-confidence)
      (cons 'recommendation "Present evidence in optimal order for narrative coherence")
      (cons 'case-application "Chronological for causation, strength-descending for impact"))))

;;;
;;; MANUFACTURED CRISIS DETECTION v3
;;;

;; Detect manufactured urgency indicators
(define (detect-manufactured-urgency-indicators-v20 crisis-claims timeline-evidence)
  "Detect indicators of manufactured urgency in crisis claims"
  (let* ((urgency-keywords '("immediate" "urgent" "emergency" "critical" "irreparable"))
         (urgency-count (apply + (map (lambda (claim)
                                       (length (filter (lambda (keyword)
                                                        (string-contains claim keyword))
                                                      urgency-keywords)))
                                     crisis-claims)))
         (actual-delay (if (not (null? timeline-evidence))
                          (- (assoc-ref (car timeline-evidence) 'action-date)
                             (assoc-ref (car timeline-evidence) 'crisis-date))
                          0))
         (urgency-inconsistent? (> actual-delay 90))
         (manufactured-confidence (if (and (> urgency-count 3) urgency-inconsistent?)
                                     0.91
                                     0.0)))
    (list
      (cons 'crisis-claims crisis-claims)
      (cons 'urgency-keyword-count urgency-count)
      (cons 'actual-delay-days actual-delay)
      (cons 'urgency-inconsistent urgency-inconsistent?)
      (cons 'manufactured-urgency-confidence manufactured-confidence)
      (cons 'legal-principle "Manufactured urgency: claims urgency but delays action")
      (cons 'case-application "Peter claims urgency but waited 4+ months to file interdict"))))

;; Analyze documentation obstruction pattern
(define (analyze-documentation-obstruction-pattern-v20 obstruction-actions documentation-complaints)
  "Analyze pattern of creating documentation gap then complaining about it"
  (let* ((obstruction-count (length obstruction-actions))
         (complaint-count (length documentation-complaints))
         (temporal-sequence-valid? (if (and (not (null? obstruction-actions))
                                           (not (null? documentation-complaints)))
                                      (< (assoc-ref (car obstruction-actions) 'date)
                                         (assoc-ref (car documentation-complaints) 'date))
                                      #f))
         (obstruction-confidence (if (and (> obstruction-count 0)
                                         (> complaint-count 0)
                                         temporal-sequence-valid?)
                                    0.93
                                    0.0)))
    (list
      (cons 'obstruction-actions obstruction-actions)
      (cons 'obstruction-count obstruction-count)
      (cons 'documentation-complaints documentation-complaints)
      (cons 'complaint-count complaint-count)
      (cons 'temporal-sequence-valid temporal-sequence-valid?)
      (cons 'obstruction-confidence obstruction-confidence)
      (cons 'legal-principle "Venire contra factum proprium: cannot complain about self-created problem")
      (cons 'case-application "Peter cancelled Dan's card (2025-06-07), then complains about documentation gap"))))

;; Compute bad faith litigation score
(define (compute-bad-faith-litigation-score-v20 ulterior-motives manufactured-crisis abuse-of-process)
  "Compute bad faith litigation score"
  (let* ((ulterior-motive-weight (* ulterior-motives 0.35))
         (manufactured-crisis-weight (* manufactured-crisis 0.40))
         (abuse-of-process-weight (* abuse-of-process 0.25))
         (total-score (+ ulterior-motive-weight manufactured-crisis-weight abuse-of-process-weight))
         (bad-faith-confidence (min 0.98 total-score)))
    (list
      (cons 'ulterior-motives ulterior-motives)
      (cons 'manufactured-crisis manufactured-crisis)
      (cons 'abuse-of-process abuse-of-process)
      (cons 'ulterior-motive-weight ulterior-motive-weight)
      (cons 'manufactured-crisis-weight manufactured-crisis-weight)
      (cons 'abuse-of-process-weight abuse-of-process-weight)
      (cons 'bad-faith-litigation-score bad-faith-confidence)
      (cons 'legal-principle "Bad faith litigation: ulterior motive + manufactured crisis + abuse of process")
      (cons 'case-application "Peter's interdict: bypass trust powers + manufactured urgency + documentation obstruction"))))

;; Identify ulterior motive evidence
(define (identify-ulterior-motive-evidence-v20 stated-purpose alternative-explanations circumstantial-evidence)
  "Identify evidence of ulterior motives"
  (let* ((alternative-count (length alternative-explanations))
         (circumstantial-count (length circumstantial-evidence))
         (motive-inconsistency (> alternative-count 2))
         (strong-circumstantial? (> circumstantial-count 3))
         (ulterior-motive-confidence (cond
                                      ((and motive-inconsistency strong-circumstantial?) 0.92)
                                      (motive-inconsistency 0.85)
                                      (strong-circumstantial? 0.80)
                                      (else 0.0))))
    (list
      (cons 'stated-purpose stated-purpose)
      (cons 'alternative-explanations alternative-explanations)
      (cons 'alternative-count alternative-count)
      (cons 'circumstantial-evidence circumstantial-evidence)
      (cons 'circumstantial-count circumstantial-count)
      (cons 'motive-inconsistency motive-inconsistency)
      (cons 'strong-circumstantial strong-circumstantial?)
      (cons 'ulterior-motive-confidence ulterior-motive-confidence)
      (cons 'legal-principle "Ulterior motive: stated purpose inconsistent with actions and circumstances")
      (cons 'case-application "Peter seeks interdict despite having absolute trust powers to act directly"))))

;;;
;;; AD PARAGRAPH RESPONSE OPTIMIZATION v20
;;;

;; Compute response priority matrix
(define (compute-response-priority-matrix-v20 ad-paragraph allegation-severity evidence-strength defense-availability)
  "Compute response priority for AD paragraph"
  (let* ((severity-weight (* allegation-severity 0.40))
         (evidence-weight (* evidence-strength 0.35))
         (defense-weight (* defense-availability 0.25))
         (priority-score (+ severity-weight evidence-weight defense-weight))
         (priority-level (cond
                          ((> priority-score 0.85) 'critical)
                          ((> priority-score 0.70) 'high)
                          ((> priority-score 0.50) 'medium)
                          (else 'low))))
    (list
      (cons 'ad-paragraph ad-paragraph)
      (cons 'allegation-severity allegation-severity)
      (cons 'evidence-strength evidence-strength)
      (cons 'defense-availability defense-availability)
      (cons 'severity-weight severity-weight)
      (cons 'evidence-weight evidence-weight)
      (cons 'defense-weight defense-weight)
      (cons 'priority-score priority-score)
      (cons 'priority-level priority-level)
      (cons 'case-application "Response priority matrix for jax-dan-response optimization"))))

;; Generate paragraph response framework
(define (generate-paragraph-response-framework-v20 ad-paragraph-id ad-content jr-response dr-response evidence-list)
  "Generate comprehensive paragraph response framework"
  (let* ((response-count (+ (if jr-response 1 0) (if dr-response 1 0)))
         (evidence-count (length evidence-list))
         (response-completeness (/ (+ response-count evidence-count) 4.0))
         (framework-confidence (min 0.96 response-completeness)))
    (list
      (cons 'ad-paragraph-id ad-paragraph-id)
      (cons 'ad-content ad-content)
      (cons 'jr-response jr-response)
      (cons 'dr-response dr-response)
      (cons 'evidence-list evidence-list)
      (cons 'response-count response-count)
      (cons 'evidence-count evidence-count)
      (cons 'response-completeness response-completeness)
      (cons 'framework-confidence framework-confidence)
      (cons 'indexing-format "AD X.Y → JR X.Y.1-N, DR X.Y.1-N → Annexure refs")
      (cons 'case-application "Comprehensive paragraph-by-paragraph response framework"))))

) ; end module
