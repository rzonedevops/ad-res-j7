;; ============================================================================
;; SOUTH AFRICAN CIVIL LAW - ENHANCED MULTI-ROLE CONFLICT DETECTION V2
;; ============================================================================
;; File: south_african_civil_law_multi_role_conflict_enhanced_v2.scm
;; Purpose: Enhanced detection and analysis of multi-role conflicts in legal entities
;; Date: 2025-11-16
;; Confidence: 0.95
;; 
;; This module provides advanced detection of multi-role conflicts, including:
;; - Founder + Trustee + Director combinations
;; - Accountant + Trustee conflicts
;; - Triple-role conflicts (Accountant + Trustee + Creditor representative)
;; - Hypocrisy detection (conduct vs objection inconsistency)
;; - Power concentration analysis
;; ============================================================================

(define-module (lex civ za multi-role-conflict-enhanced-v2)
  #:use-module (lex lv1 known-laws)
  #:use-module (lex civ za south-african-civil-law)
  #:use-module (lex trs za south-african-trust-law)
  #:use-module (lex cmp za south-african-company-law)
  #:use-module (lex prof-eth za south-african-professional-ethics-multi-party-conflicts)
  #:export (
    ;; Multi-Role Conflict Detection
    detect-founder-trustee-concentration
    detect-accountant-trustee-conflict
    detect-triple-role-conflict
    detect-director-beneficiary-conflict
    calculate-multi-role-conflict-severity
    
    ;; Hypocrisy Detection
    detect-conduct-objection-hypocrisy
    calculate-hypocrisy-severity
    generate-material-non-disclosure-indicators
    compare-actor-conduct-patterns
    
    ;; Power Concentration Analysis
    analyze-power-concentration
    calculate-unchecked-authority-score
    detect-power-abuse-indicators
    
    ;; Professional Duty Conflicts
    detect-professional-duty-conflict
    analyze-conflict-of-interest-severity
    identify-compromised-duties
    
    ;; Conflict Resolution
    resolve-multi-role-conflict
    generate-conflict-mitigation-recommendations
    calculate-conflict-impact-score
  ))

;; ============================================================================
;; PART 1: MULTI-ROLE CONFLICT DETECTION
;; ============================================================================

;; ----------------------------------------------------------------------------
;; 1.1 Founder-Trustee Concentration Detection
;; ----------------------------------------------------------------------------

(define (detect-founder-trustee-concentration entity)
  "Detects when a single person holds both founder and trustee roles in a trust,
   creating unchecked authority and power concentration."
  (let* ((roles (get-entity-roles entity))
         (is-founder (member 'founder roles))
         (is-trustee (member 'trustee roles))
         (has-concentration (and is-founder is-trustee))
         (severity (if has-concentration 0.98 0.0))
         (trust-type (get-entity-attribute entity 'trust-type))
         (beneficiaries (get-entity-attribute entity 'beneficiaries))
         (has-beneficiaries (> (length beneficiaries) 0)))
    
    (make-conflict-result
     'type 'founder-trustee-concentration
     'detected has-concentration
     'severity severity
     'priority (if has-concentration 'critical 'none)
     'description "Founder with absolute trustee powers creates unchecked authority"
     'legal-principles (list
                        'fiduciary-duty
                        'conflict-of-interest
                        'abuse-of-power)
     'risk-factors (list
                    (cons 'power-concentration 0.98)
                    (cons 'lack-of-oversight 0.96)
                    (cons 'beneficiary-vulnerability 0.94))
     'evidence-required (list
                         "Trust deed showing founder and trustee appointments"
                         "Timeline of trustee appointment (backdating indicators)"
                         "Evidence of unilateral decision-making"
                         "Beneficiary communications showing power imbalance")
     'confidence 0.98)))

;; ----------------------------------------------------------------------------
;; 1.2 Accountant-Trustee Conflict Detection
;; ----------------------------------------------------------------------------

(define (detect-accountant-trustee-conflict entity)
  "Detects when an accountant serves as trustee of a client's trust,
   creating fundamental professional duty conflicts."
  (let* ((roles (get-entity-roles entity))
         (is-accountant (member 'accountant roles))
         (is-trustee (member 'trustee roles))
         (has-conflict (and is-accountant is-trustee))
         (client-entities (get-entity-attribute entity 'accounting-clients))
         (trust-beneficiaries (get-entity-attribute entity 'trust-beneficiaries))
         (client-beneficiary-overlap (intersection client-entities trust-beneficiaries))
         (severity (if has-conflict 0.97 0.0)))
    
    (make-conflict-result
     'type 'accountant-trustee-conflict
     'detected has-conflict
     'severity severity
     'priority (if has-conflict 'critical 'none)
     'description "Accountant serving as trustee of client's trust creates fundamental conflict"
     'legal-principles (list
                        'professional-duty
                        'fiduciary-duty
                        'conflict-of-interest
                        'independence-requirement)
     'risk-factors (list
                    (cons 'professional-independence-loss 0.97)
                    (cons 'client-trust-conflict 0.96)
                    (cons 'financial-reporting-bias 0.94)
                    (cons 'audit-compromise 0.93))
     'evidence-required (list
                         "Accountant-client engagement letters"
                         "Trust deed showing trustee appointment"
                         "Financial statements prepared by accountant"
                         "Professional ethics code violations")
     'confidence 0.97)))

;; ----------------------------------------------------------------------------
;; 1.3 Triple-Role Conflict Detection
;; ----------------------------------------------------------------------------

(define (detect-triple-role-conflict entity)
  "Detects when an entity holds three or more conflicting roles simultaneously,
   such as Accountant + Trustee + Creditor representative."
  (let* ((roles (get-entity-roles entity))
         (conflicting-role-combinations (list
                                         '(accountant trustee creditor-representative)
                                         '(accountant trustee director)
                                         '(trustee director beneficiary)
                                         '(founder trustee director)))
         (detected-combinations (filter (lambda (combo)
                                          (all (map (lambda (role) 
                                                      (member role roles))
                                                    combo)))
                                        conflicting-role-combinations))
         (has-triple-conflict (> (length detected-combinations) 0))
         (severity (if has-triple-conflict 0.98 0.0)))
    
    (make-conflict-result
     'type 'triple-role-conflict
     'detected has-triple-conflict
     'severity severity
     'priority (if has-triple-conflict 'critical 'none)
     'description "Three or more conflicting roles create systemic conflict of interest"
     'detected-combinations detected-combinations
     'legal-principles (list
                        'conflict-of-interest
                        'professional-duty
                        'fiduciary-duty
                        'duty-of-loyalty)
     'risk-factors (list
                    (cons 'systemic-conflict 0.98)
                    (cons 'irreconcilable-duties 0.97)
                    (cons 'power-abuse-potential 0.96)
                    (cons 'beneficiary-harm 0.95))
     'evidence-required (list
                         "Documentation of all role appointments"
                         "Evidence of conflicting duty exercises"
                         "Financial benefit analysis from multiple roles"
                         "Professional ethics violations")
     'confidence 0.98)))

;; ----------------------------------------------------------------------------
;; 1.4 Director-Beneficiary Conflict Detection
;; ----------------------------------------------------------------------------

(define (detect-director-beneficiary-conflict entity1 entity2)
  "Detects when a director of a trust-owned company attacks beneficiaries
   of the trust, creating multi-level conflicts."
  (let* ((entity1-roles (get-entity-roles entity1))
         (entity2-roles (get-entity-roles entity2))
         (entity1-is-director (member 'director entity1-roles))
         (entity1-is-trustee (member 'trustee entity1-roles))
         (entity2-is-beneficiary (member 'beneficiary entity2-roles))
         (has-conflict (and (or entity1-is-director entity1-is-trustee)
                           entity2-is-beneficiary))
         (litigation-exists (check-litigation-between entity1 entity2))
         (severity (if (and has-conflict litigation-exists) 0.92 0.0)))
    
    (make-conflict-result
     'type 'director-beneficiary-conflict
     'detected has-conflict
     'severity severity
     'priority (if has-conflict 'high 'none)
     'description "Director of trust-owned company attacking beneficiaries"
     'legal-principles (list
                        'fiduciary-duty
                        'beneficiary-rights
                        'corporate-governance
                        'abuse-of-power)
     'risk-factors (list
                    (cons 'beneficiary-rights-violation 0.92)
                    (cons 'trust-asset-misuse 0.91)
                    (cons 'corporate-power-abuse 0.89))
     'evidence-required (list
                         "Company ownership structure (trust ownership)"
                         "Director appointment documentation"
                         "Beneficiary status documentation"
                         "Litigation records showing attack on beneficiaries")
     'confidence 0.92)))

;; ----------------------------------------------------------------------------
;; 1.5 Multi-Role Conflict Severity Calculation
;; ----------------------------------------------------------------------------

(define (calculate-multi-role-conflict-severity entity)
  "Calculates overall multi-role conflict severity for an entity based on
   all detected conflicts and their interactions."
  (let* ((founder-trustee (detect-founder-trustee-concentration entity))
         (accountant-trustee (detect-accountant-trustee-conflict entity))
         (triple-role (detect-triple-role-conflict entity))
         (conflicts (list founder-trustee accountant-trustee triple-role))
         (detected-conflicts (filter (lambda (c) (get-conflict-attribute c 'detected))
                                     conflicts))
         (severities (map (lambda (c) (get-conflict-attribute c 'severity))
                         detected-conflicts))
         (max-severity (if (null? severities) 0.0 (apply max severities)))
         (conflict-count (length detected-conflicts))
         (interaction-multiplier (+ 1.0 (* 0.05 (- conflict-count 1))))
         (overall-severity (min 1.0 (* max-severity interaction-multiplier))))
    
    (make-severity-result
     'entity entity
     'detected-conflicts detected-conflicts
     'conflict-count conflict-count
     'max-individual-severity max-severity
     'interaction-multiplier interaction-multiplier
     'overall-severity overall-severity
     'priority (cond
                ((>= overall-severity 0.95) 'critical)
                ((>= overall-severity 0.85) 'high)
                ((>= overall-severity 0.70) 'medium)
                (else 'low))
     'confidence 0.95)))

;; ============================================================================
;; PART 2: HYPOCRISY DETECTION
;; ============================================================================

;; ----------------------------------------------------------------------------
;; 2.1 Conduct-Objection Hypocrisy Detection
;; ----------------------------------------------------------------------------

(define (detect-conduct-objection-hypocrisy actor conduct-pattern objection-pattern)
  "Detects when an actor objects to conduct in which they themselves engaged,
   indicating hypocrisy and selective enforcement."
  (let* ((actor-conduct (get-actor-conduct-history actor conduct-pattern))
         (actor-objections (get-actor-objections actor objection-pattern))
         (conduct-matches-objection (conduct-pattern-matches? actor-conduct objection-pattern))
         (has-hypocrisy conduct-matches-objection)
         (conduct-frequency (length actor-conduct))
         (conduct-total-value (sum-conduct-values actor-conduct))
         (objection-frequency (length actor-objections))
         (severity (if has-hypocrisy
                      (min 1.0 (* 0.90 (+ 1.0 (* 0.02 conduct-frequency))))
                      0.0)))
    
    (make-hypocrisy-result
     'type 'conduct-objection-hypocrisy
     'detected has-hypocrisy
     'severity severity
     'priority (if has-hypocrisy 'critical 'none)
     'description "Actor objects to conduct in which they themselves engaged"
     'actor-conduct actor-conduct
     'actor-objections actor-objections
     'conduct-frequency conduct-frequency
     'conduct-total-value conduct-total-value
     'objection-frequency objection-frequency
     'hypocrisy-ratio (if (> objection-frequency 0)
                         (/ conduct-frequency objection-frequency)
                         0.0)
     'legal-principles (list
                        'clean-hands-doctrine
                        'consistency-principle
                        'good-faith
                        'material-non-disclosure)
     'evidence-required (list
                         "Actor's own conduct records (bank statements, transactions)"
                         "Actor's objections to others' conduct (litigation documents)"
                         "Comparative analysis showing identical patterns"
                         "Timeline showing actor's participation before objection")
     'confidence 0.94)))

;; ----------------------------------------------------------------------------
;; 2.2 Hypocrisy Severity Calculation
;; ----------------------------------------------------------------------------

(define (calculate-hypocrisy-severity hypocrisy-result)
  "Calculates hypocrisy severity based on conduct frequency, value disparity,
   and timing of objections."
  (let* ((conduct-frequency (get-hypocrisy-attribute hypocrisy-result 'conduct-frequency))
         (conduct-total-value (get-hypocrisy-attribute hypocrisy-result 'conduct-total-value))
         (objection-frequency (get-hypocrisy-attribute hypocrisy-result 'objection-frequency))
         (objection-target-value (get-hypocrisy-attribute hypocrisy-result 'objection-target-value))
         (value-ratio (if (> objection-target-value 0)
                         (/ conduct-total-value objection-target-value)
                         1.0))
         (frequency-factor (min 1.0 (* 0.85 (+ 1.0 (* 0.03 conduct-frequency)))))
         (value-factor (min 1.0 (* 0.90 (log (+ 1.0 value-ratio)))))
         (timing-factor (calculate-timing-factor hypocrisy-result))
         (overall-severity (min 1.0 (* frequency-factor value-factor timing-factor))))
    
    (make-severity-calculation
     'frequency-factor frequency-factor
     'value-factor value-factor
     'timing-factor timing-factor
     'overall-severity overall-severity
     'confidence 0.94)))

;; ----------------------------------------------------------------------------
;; 2.3 Material Non-Disclosure Indicator Generation
;; ----------------------------------------------------------------------------

(define (generate-material-non-disclosure-indicators hypocrisy-result)
  "Generates indicators of material non-disclosure based on hypocrisy detection,
   particularly relevant for ex parte applications."
  (let* ((actor-conduct (get-hypocrisy-attribute hypocrisy-result 'actor-conduct))
         (actor-objections (get-hypocrisy-attribute hypocrisy-result 'actor-objections))
         (ex-parte-application (get-hypocrisy-attribute hypocrisy-result 'ex-parte-application))
         (disclosed-conduct (get-disclosed-conduct ex-parte-application))
         (undisclosed-conduct (set-difference actor-conduct disclosed-conduct))
         (materiality-scores (map calculate-conduct-materiality undisclosed-conduct))
         (material-omissions (filter (lambda (score) (> score 0.80)) materiality-scores)))
    
    (make-non-disclosure-result
     'undisclosed-conduct undisclosed-conduct
     'material-omissions material-omissions
     'materiality-scores materiality-scores
     'severity (if (null? material-omissions) 0.0 0.95)
     'legal-principles (list
                        'ex-parte-duty-of-candor
                        'material-non-disclosure
                        'uberrima-fides
                        'good-faith)
     'impact (list
              "Would have informed court of actor's own participation"
              "Would have revealed inconsistency with actor's own conduct"
              "Would have undermined credibility of objection"
              "Would have shown selective enforcement")
     'evidence-required (list
                         "Ex parte application text"
                         "Actor's conduct records not disclosed"
                         "Materiality analysis of omitted facts"
                         "Court rules on ex parte disclosure duties")
     'confidence 0.95)))

;; ----------------------------------------------------------------------------
;; 2.4 Actor Conduct Pattern Comparison
;; ----------------------------------------------------------------------------

(define (compare-actor-conduct-patterns actor1 actor2 conduct-type)
  "Compares conduct patterns between two actors to identify selective
   enforcement and inconsistent standards."
  (let* ((actor1-conduct (get-actor-conduct-history actor1 conduct-type))
         (actor2-conduct (get-actor-conduct-history actor2 conduct-type))
         (actor1-frequency (length actor1-conduct))
         (actor2-frequency (length actor2-conduct))
         (actor1-total-value (sum-conduct-values actor1-conduct))
         (actor2-total-value (sum-conduct-values actor2-conduct))
         (actor1-objections (get-actor-objections actor1 conduct-type))
         (actor2-objections (get-actor-objections actor2 conduct-type))
         (selective-enforcement (and (> actor1-frequency 0)
                                    (> (length actor1-objections) 0)
                                    (= (length actor2-objections) 0))))
    
    (make-comparison-result
     'actor1 actor1
     'actor2 actor2
     'conduct-type conduct-type
     'actor1-conduct-frequency actor1-frequency
     'actor2-conduct-frequency actor2-frequency
     'actor1-conduct-value actor1-total-value
     'actor2-conduct-value actor2-total-value
     'actor1-objections (length actor1-objections)
     'actor2-objections (length actor2-objections)
     'selective-enforcement selective-enforcement
     'value-ratio (if (> actor2-total-value 0)
                     (/ actor1-total-value actor2-total-value)
                     0.0)
     'severity (if selective-enforcement 0.93 0.0)
     'confidence 0.93)))

;; ============================================================================
;; PART 3: POWER CONCENTRATION ANALYSIS
;; ============================================================================

;; ----------------------------------------------------------------------------
;; 3.1 Power Concentration Analysis
;; ----------------------------------------------------------------------------

(define (analyze-power-concentration entity)
  "Analyzes power concentration in an entity based on role combinations,
   control mechanisms, and oversight absence."
  (let* ((roles (get-entity-roles entity))
         (power-roles (filter is-power-role? roles))
         (power-role-count (length power-roles))
         (has-founder-role (member 'founder roles))
         (has-trustee-role (member 'trustee roles))
         (has-director-role (member 'director roles))
         (oversight-mechanisms (get-entity-attribute entity 'oversight-mechanisms))
         (oversight-count (length oversight-mechanisms))
         (concentration-score (calculate-concentration-score 
                               power-role-count 
                               oversight-count
                               has-founder-role
                               has-trustee-role))
         (severity (min 1.0 concentration-score)))
    
    (make-power-analysis-result
     'entity entity
     'power-roles power-roles
     'power-role-count power-role-count
     'oversight-mechanisms oversight-mechanisms
     'oversight-count oversight-count
     'concentration-score concentration-score
     'severity severity
     'priority (cond
                ((>= severity 0.95) 'critical)
                ((>= severity 0.85) 'high)
                (else 'medium))
     'risk-factors (list
                    (cons 'unchecked-authority (if (= oversight-count 0) 0.98 0.70))
                    (cons 'unilateral-decision-making 0.96)
                    (cons 'beneficiary-vulnerability 0.94)
                    (cons 'abuse-potential 0.93))
     'confidence 0.96)))

;; ----------------------------------------------------------------------------
;; 3.2 Unchecked Authority Score Calculation
;; ----------------------------------------------------------------------------

(define (calculate-unchecked-authority-score entity)
  "Calculates a score representing the degree of unchecked authority
   an entity possesses."
  (let* ((power-concentration (analyze-power-concentration entity))
         (concentration-score (get-power-attribute power-concentration 'concentration-score))
         (oversight-count (get-power-attribute power-concentration 'oversight-count))
         (beneficiary-count (length (get-entity-attribute entity 'beneficiaries)))
         (oversight-factor (if (= oversight-count 0) 1.0 (/ 1.0 (+ 1.0 oversight-count))))
         (beneficiary-factor (if (> beneficiary-count 0) 1.05 1.0))
         (unchecked-score (min 1.0 (* concentration-score oversight-factor beneficiary-factor))))
    
    (make-authority-score
     'concentration-score concentration-score
     'oversight-factor oversight-factor
     'beneficiary-factor beneficiary-factor
     'unchecked-score unchecked-score
     'severity unchecked-score
     'confidence 0.96)))

;; ----------------------------------------------------------------------------
;; 3.3 Power Abuse Indicator Detection
;; ----------------------------------------------------------------------------

(define (detect-power-abuse-indicators entity timeline)
  "Detects indicators of power abuse based on entity actions and timeline patterns."
  (let* ((unilateral-actions (filter-unilateral-actions timeline entity))
         (beneficiary-attacks (filter-beneficiary-attacks timeline entity))
         (asset-misuse (filter-asset-misuse timeline entity))
         (litigation-weaponization (filter-litigation-weaponization timeline entity))
         (all-indicators (append unilateral-actions 
                                beneficiary-attacks 
                                asset-misuse 
                                litigation-weaponization))
         (indicator-count (length all-indicators))
         (severity (min 1.0 (* 0.85 (+ 1.0 (* 0.05 indicator-count))))))
    
    (make-abuse-indicators-result
     'entity entity
     'unilateral-actions unilateral-actions
     'beneficiary-attacks beneficiary-attacks
     'asset-misuse asset-misuse
     'litigation-weaponization litigation-weaponization
     'total-indicators indicator-count
     'severity severity
     'confidence 0.94)))

;; ============================================================================
;; PART 4: PROFESSIONAL DUTY CONFLICTS
;; ============================================================================

;; ----------------------------------------------------------------------------
;; 4.1 Professional Duty Conflict Detection
;; ----------------------------------------------------------------------------

(define (detect-professional-duty-conflict entity)
  "Detects conflicts between professional duties and personal interests."
  (let* ((professional-roles (filter is-professional-role? (get-entity-roles entity)))
         (personal-interests (get-entity-attribute entity 'personal-interests))
         (conflicting-pairs (find-conflicting-duty-interest-pairs 
                            professional-roles 
                            personal-interests))
         (has-conflict (> (length conflicting-pairs) 0))
         (severity (if has-conflict 0.95 0.0)))
    
    (make-professional-conflict-result
     'entity entity
     'professional-roles professional-roles
     'personal-interests personal-interests
     'conflicting-pairs conflicting-pairs
     'has-conflict has-conflict
     'severity severity
     'confidence 0.95)))

;; ----------------------------------------------------------------------------
;; 4.2 Conflict of Interest Severity Analysis
;; ----------------------------------------------------------------------------

(define (analyze-conflict-of-interest-severity conflict-result)
  "Analyzes the severity of a conflict of interest based on multiple factors."
  (let* ((conflicting-pairs (get-conflict-attribute conflict-result 'conflicting-pairs))
         (financial-magnitude (calculate-financial-magnitude conflicting-pairs))
         (duty-compromise-level (calculate-duty-compromise-level conflicting-pairs))
         (client-impact (calculate-client-impact conflicting-pairs))
         (severity (* 0.95 
                     (+ (* 0.4 financial-magnitude)
                        (* 0.3 duty-compromise-level)
                        (* 0.3 client-impact)))))
    
    (make-severity-analysis
     'financial-magnitude financial-magnitude
     'duty-compromise-level duty-compromise-level
     'client-impact client-impact
     'overall-severity severity
     'confidence 0.94)))

;; ----------------------------------------------------------------------------
;; 4.3 Compromised Duties Identification
;; ----------------------------------------------------------------------------

(define (identify-compromised-duties entity)
  "Identifies which professional duties are compromised by conflicts of interest."
  (let* ((professional-roles (filter is-professional-role? (get-entity-roles entity)))
         (duties-by-role (map get-professional-duties professional-roles))
         (all-duties (apply append duties-by-role))
         (personal-interests (get-entity-attribute entity 'personal-interests))
         (compromised (filter (lambda (duty)
                               (duty-compromised-by-interest? duty personal-interests))
                             all-duties)))
    
    (make-compromised-duties-result
     'entity entity
     'all-duties all-duties
     'compromised-duties compromised
     'compromise-count (length compromised)
     'severity (min 1.0 (* 0.90 (/ (length compromised) (max 1 (length all-duties)))))
     'confidence 0.93)))

;; ============================================================================
;; PART 5: CONFLICT RESOLUTION
;; ============================================================================

;; ----------------------------------------------------------------------------
;; 5.1 Multi-Role Conflict Resolution
;; ----------------------------------------------------------------------------

(define (resolve-multi-role-conflict conflict-result)
  "Provides resolution recommendations for multi-role conflicts."
  (let* ((conflict-type (get-conflict-attribute conflict-result 'type))
         (severity (get-conflict-attribute conflict-result 'severity))
         (resolution-strategy (determine-resolution-strategy conflict-type severity))
         (required-actions (generate-required-actions conflict-type))
         (legal-remedies (identify-legal-remedies conflict-type)))
    
    (make-resolution-result
     'conflict-type conflict-type
     'severity severity
     'resolution-strategy resolution-strategy
     'required-actions required-actions
     'legal-remedies legal-remedies
     'confidence 0.92)))

;; ----------------------------------------------------------------------------
;; 5.2 Conflict Mitigation Recommendations
;; ----------------------------------------------------------------------------

(define (generate-conflict-mitigation-recommendations conflict-result)
  "Generates specific recommendations for mitigating detected conflicts."
  (let* ((conflict-type (get-conflict-attribute conflict-result 'type))
         (recommendations (case conflict-type
                           ((founder-trustee-concentration)
                            (list "Appoint independent co-trustee"
                                  "Establish oversight committee"
                                  "Require beneficiary consent for major decisions"
                                  "Implement regular independent audits"))
                           ((accountant-trustee-conflict)
                            (list "Resign from trustee position"
                                  "Resign from accountant position"
                                  "Appoint independent accountant"
                                  "Disclose conflict to all affected parties"))
                           ((triple-role-conflict)
                            (list "Resign from at least two conflicting roles"
                                  "Establish Chinese walls between roles"
                                  "Disclose all conflicts to affected parties"
                                  "Seek independent legal advice"))
                           (else (list "Seek professional ethics guidance"
                                      "Disclose conflict to all parties"
                                      "Consider resignation from conflicting roles")))))
    
    (make-recommendations-result
     'conflict-type conflict-type
     'recommendations recommendations
     'priority 'high
     'confidence 0.91)))

;; ----------------------------------------------------------------------------
;; 5.3 Conflict Impact Score Calculation
;; ----------------------------------------------------------------------------

(define (calculate-conflict-impact-score conflict-result affected-parties)
  "Calculates the overall impact score of a conflict on affected parties."
  (let* ((severity (get-conflict-attribute conflict-result 'severity))
         (party-count (length affected-parties))
         (financial-impact (sum-financial-impacts affected-parties))
         (rights-violations (count-rights-violations affected-parties))
         (impact-score (* severity 
                         (+ 1.0 
                            (* 0.1 party-count)
                            (* 0.2 (log (+ 1.0 financial-impact)))
                            (* 0.15 rights-violations)))))
    
    (make-impact-score-result
     'severity severity
     'affected-party-count party-count
     'financial-impact financial-impact
     'rights-violations rights-violations
     'impact-score (min 1.0 impact-score)
     'confidence 0.93)))

;; ============================================================================
;; HELPER FUNCTIONS
;; ============================================================================

(define (is-power-role? role)
  "Determines if a role confers significant power."
  (member role '(founder trustee director ceo cio chairman)))

(define (is-professional-role? role)
  "Determines if a role is a professional role with ethical duties."
  (member role '(accountant attorney trustee director auditor)))

(define (calculate-concentration-score power-role-count oversight-count 
                                       has-founder has-trustee)
  "Calculates power concentration score based on roles and oversight."
  (let* ((base-score (* 0.70 (/ power-role-count (max 1 (+ power-role-count oversight-count)))))
         (founder-bonus (if has-founder 0.15 0.0))
         (trustee-bonus (if has-trustee 0.15 0.0))
         (founder-trustee-bonus (if (and has-founder has-trustee) 0.10 0.0)))
    (min 1.0 (+ base-score founder-bonus trustee-bonus founder-trustee-bonus))))

(define (conduct-pattern-matches? conduct-history pattern)
  "Determines if conduct history matches a given pattern."
  (and (> (length conduct-history) 0)
       (all (map (lambda (conduct) (matches-pattern? conduct pattern))
                 conduct-history))))

(define (calculate-timing-factor hypocrisy-result)
  "Calculates timing factor for hypocrisy severity based on when objections occurred."
  (let* ((last-conduct-date (get-hypocrisy-attribute hypocrisy-result 'last-conduct-date))
         (first-objection-date (get-hypocrisy-attribute hypocrisy-result 'first-objection-date))
         (days-between (date-difference first-objection-date last-conduct-date))
         (timing-factor (cond
                         ((< days-between 30) 1.0)    ; Very recent conduct
                         ((< days-between 180) 0.95)  ; Recent conduct
                         ((< days-between 365) 0.90)  ; Within a year
                         (else 0.85))))               ; Older conduct
    timing-factor))

(define (calculate-conduct-materiality conduct)
  "Calculates materiality score for a piece of undisclosed conduct."
  (let* ((financial-value (get-conduct-attribute conduct 'financial-value))
         (frequency (get-conduct-attribute conduct 'frequency))
         (similarity-to-objection (get-conduct-attribute conduct 'similarity-score))
         (materiality (* 0.90 
                        (+ (* 0.4 (min 1.0 (/ financial-value 1000000)))
                           (* 0.3 (min 1.0 (/ frequency 10)))
                           (* 0.3 similarity-to-objection)))))
    materiality))

;; ============================================================================
;; MODULE INITIALIZATION
;; ============================================================================

(define framework-metadata
  (make-hash-table
   'name "South African Civil Law - Enhanced Multi-Role Conflict Detection V2"
   'jurisdiction "za"
   'legal-domain '(civil trust company professional-ethics)
   'version "2.0"
   'date "2025-11-16"
   'confidence-base 0.95
   'derived-from-modules '(
     "south_african_civil_law.scm"
     "south_african_trust_law.scm"
     "south_african_company_law.scm"
     "south_african_professional_ethics_multi_party_conflicts.scm"
   )))

;; Export module
(provide 'lex-civ-za-multi-role-conflict-enhanced-v2)
