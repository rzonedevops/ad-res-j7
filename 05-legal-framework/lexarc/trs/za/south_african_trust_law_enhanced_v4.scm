;; South African Trust Law - Enhanced v4
;; New principles for ad-res-j7 case profile optimization
;; Date: 2025-11-02
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
   'name "South African Trust Law - Enhanced v4"
   'jurisdiction "za"
   'legal-domain '(trust fiduciary)
   'version "4.0"
   'last-updated "2025-11-02"
   'derived-from-level 1
   'confidence-base 0.95
   'language "en"
   'case-profile "ad-res-j7"))

;; =============================================================================
;; NEW PRINCIPLE 1: UNDISCLOSED TRUSTEE STATUS INDICATORS
;; =============================================================================

(define undisclosed-trustee-status-indicators
  (make-principle
   'name 'undisclosed-trustee-status-indicators
   'description "Indicators of undisclosed trustee status and implications for beneficiary protection"
   'domain '(trust fiduciary disclosure beneficiary-rights)
   'confidence 0.95
   'jurisdiction "za"
   'statutory-basis "Trust Property Control Act 57 of 1988, s16 (trustee duties)"
   'common-law-basis "Fiduciary duty, beneficiary right to information"
   'base-principles '(fiduciary-duty beneficiary-protection)
   'inference-type 'deductive
   
   ;; Core indicators
   'indicators '(trustee-status-not-disclosed-to-beneficiaries
                trustee-has-conflicting-roles
                trustee-makes-decisions-without-disclosure
                beneficiaries-discover-trustee-status-during-investigation
                trustee-also-accountant-or-advisor
                trustee-also-shareholder-in-related-entities
                undisclosed-trustee-controls-financial-decisions
                pattern-of-non-disclosure-over-extended-period)
   
   ;; Red flags for detection
   'red-flags '((trustee-status-undisclosed-for-over-1-year 0.96)
               (trustee-has-multiple-conflicting-roles 0.95)
               (trustee-controls-related-party-entities 0.94)
               (beneficiaries-explicitly-unaware 0.97)
               (trustee-makes-material-decisions-without-disclosure 0.96)
               (discovery-during-fraud-investigation 0.95))
   
   ;; Beneficiary rights violated
   'beneficiary-rights-violated '(right-to-information-about-trustees
                                  right-to-know-who-controls-trust-assets
                                  right-to-challenge-conflicted-trustees
                                  right-to-informed-consent
                                  right-to-transparency-in-trust-administration)
   
   ;; Evidence requirements
   'evidence-required '(trust-deed-showing-trustee-appointment
                       beneficiary-testimony-of-non-disclosure
                       timeline-of-discovery
                       conflicting-role-documentation
                       financial-decisions-made-by-undisclosed-trustee
                       correspondence-showing-non-disclosure)
   
   ;; Legal implications
   'legal-implications '(breach-of-fiduciary-duty
                        violation-of-beneficiary-rights
                        voidable-trustee-decisions
                        trustee-removal-grounds
                        damages-for-breach-of-duty
                        conflict-of-interest-violations)
   
   ;; Inference logic
   'inference "Undisclosed trustee status, especially when combined with conflicting roles, violates beneficiary rights to information and transparency in trust administration"
   
   ;; Case application
   "Danie Bantjies was unknown trustee until Dan exposed Villa Via fraud to him in June 2025. Bantjies has multiple conflicting roles: (1) Co-Trustee of Faucitt Family Trust, (2) Accountant for RegimA Group companies, (3) Shareholder in Villa Via (50%). Beneficiaries (Jax and Dan) were unaware of his trustee status. Rynette claimed Bantjies instructed her to make huge payments related to R5.4M stock adjustment."
   
   ;; Related principles
   'related-principles '(fiduciary-duty
                        beneficiary-protection-when-attacked
                        conflict-of-interest-prohibition
                        trust-power-abuse-test
                        accountant-professional-duty)
   
   ;; Remedies
   'remedies '(compel-full-disclosure-of-trustee-status
              remove-conflicted-trustee
              void-decisions-made-without-disclosure
              damages-for-breach-of-fiduciary-duty
              appoint-independent-trustee
              beneficiary-access-to-trust-information)))

;; =============================================================================
;; NEW PRINCIPLE 2: MULTI-JURISDICTION COMPLIANCE CRISIS TEST
;; =============================================================================

(define multi-jurisdiction-compliance-crisis-test
  (make-principle
   'name 'multi-jurisdiction-compliance-crisis-test
   'description "Test for evaluating multi-jurisdiction compliance crisis caused by legal actions"
   'domain '(international regulatory-compliance trust)
   'confidence 0.95
   'jurisdiction "za"
   'statutory-basis "EU Regulation 1223/2009 (Cosmetics), Trust Property Control Act 57 of 1988"
   'common-law-basis "Proportionality, irreparable harm, balance of convenience"
   'base-principles '(fiduciary-duty proportionality-test)
   'inference-type 'deductive
   
   ;; Test elements
   'elements '(regulatory-role-in-multiple-jurisdictions
              legal-action-prevents-role-performance
              immediate-compliance-violations
              regulatory-penalties-across-jurisdictions
              irreparable-harm-to-business-operations
              no-alternative-means-to-achieve-objective
              disproportionate-harm-vs-benefit)
   
   ;; Compliance crisis factors
   'crisis-factors '(number-of-jurisdictions-affected
                    severity-of-regulatory-violations
                    potential-penalties-per-jurisdiction
                    business-continuity-impact
                    consumer-safety-implications
                    regulatory-enforcement-timeline
                    ability-to-remedy-violations)
   
   ;; Red flags for disproportionate harm
   'red-flags '((jurisdictions-affected-exceeds-10 0.94)
               (regulatory-role-is-mandatory 0.97)
               (violations-immediate-upon-action 0.96)
               (no-substitute-person-available 0.95)
               (penalties-exceed-r1m-per-jurisdiction 0.93)
               (business-operations-must-cease 0.96))
   
   ;; Evidence requirements
   'evidence-required '(regulatory-role-documentation
                       jurisdiction-list-with-requirements
                       legal-action-preventing-performance
                       immediate-violation-analysis
                       penalty-calculation-per-jurisdiction
                       business-impact-assessment
                       alternative-means-analysis)
   
   ;; Legal implications
   'legal-implications '(disproportionate-harm-to-respondent
                        irreparable-business-damage
                        regulatory-violations-across-jurisdictions
                        consumer-safety-implications
                        balance-of-convenience-favors-respondent
                        interim-relief-should-be-denied)
   
   ;; Proportionality analysis
   'proportionality-analysis "Compare: (1) Harm to applicant if relief denied, vs (2) Harm to respondent if relief granted. If respondent harm includes multi-jurisdiction compliance crisis with irreparable business damage, relief should be denied unless applicant can show compelling necessity."
   
   ;; Inference logic
   'inference "Legal action causing multi-jurisdiction compliance crisis with immediate violations across numerous jurisdictions demonstrates disproportionate harm and should fail balance of convenience test"
   
   ;; Case application
   "Jax is EU Responsible Person for RegimA Skin Treatments across 37 jurisdictions (EU Regulation 1223/2009). Peter's interdict prevents Jax from performing this mandatory regulatory role, creating immediate compliance violations in all 37 jurisdictions. Regulatory penalties per jurisdiction can exceed €1M. No substitute person available. Business operations must cease if Jax cannot perform role. Disproportionate harm to Jax and business vs. Peter's claimed urgency."
   
   ;; Related principles
   'related-principles '(beneficiary-protection-when-attacked
                        eu-responsible-person-duty
                        regulatory-compliance-necessity
                        proportionality-test
                        balance-of-convenience)
   
   ;; Remedies
   'remedies '(deny-interim-relief-due-to-disproportionate-harm
              require-alternative-means-to-achieve-objective
              protect-regulatory-compliance-role
              damages-for-business-disruption
              costs-for-frivolous-application)))

;; =============================================================================
;; ENHANCED PRINCIPLE: TRUST POWER BYPASS TEMPORAL ANALYSIS (from v3)
;; =============================================================================

(define trust-power-bypass-temporal-analysis
  (make-principle
   'name 'trust-power-bypass-temporal-analysis
   'description "Temporal analysis of trustee bypassing direct trust powers to seek court relief"
   'domain '(trust fiduciary abuse-of-process)
   'confidence 0.96
   'jurisdiction "za"
   'statutory-basis "Trust Property Control Act 57 of 1988, trust deed provisions"
   'common-law-basis "Proper purpose test, abuse of process"
   'base-principles '(fiduciary-duty proper-purpose-test)
   'inference-type 'abductive
   
   ;; Core indicators
   'indicators '(trustee-has-absolute-powers-per-trust-deed
                trustee-seeks-court-relief-instead
                beneficiary-is-target-of-relief
                timing-coincides-with-other-actions
                manufactured-urgency
                settlement-discussion-immediately-before
                coercion-indicators-present)
   
   ;; Temporal pattern analysis
   'temporal-patterns '((settlement-discussion-to-court-action "Suggests bad faith negotiation")
                       (backdating-signature-to-court-action "Suggests coercion")
                       (fraud-exposure-to-court-action "Suggests retaliation")
                       (power-granted-to-court-bypass "Suggests ulterior motive"))
   
   ;; Red flags for ulterior motives
   'red-flags '((court-action-within-48-hours-of-settlement 0.97)
               (trustee-has-absolute-powers-per-deed 0.96)
               (beneficiary-signed-backdating-before-action 0.95)
               (no-attempt-to-use-direct-powers 0.94)
               (manufactured-urgency-claims 0.93))
   
   ;; Evidence requirements
   'evidence-required '(trust-deed-showing-absolute-powers
                       timeline-of-settlement-discussion
                       timeline-of-court-action
                       backdating-signature-timeline
                       correspondence-showing-no-attempt-to-use-powers
                       manufactured-urgency-analysis)
   
   ;; Legal implications
   'legal-implications '(abuse-of-process
                        ulterior-motive-for-court-action
                        bad-faith-conduct
                        coercion-of-beneficiary
                        improper-purpose
                        court-action-should-be-dismissed)
   
   ;; Inference logic
   'inference "Seeking court relief when direct trust powers exist, especially with suspicious timing, suggests ulterior motive such as coercion, retaliation, or manufactured crisis"
   
   ;; Case application
   "Peter has absolute trust powers per Faucitt Family Trust deed. Settlement discussion 11 Aug 2025. Jax signs backdating Peter's Main Trustee status same day (11 Aug). Peter files interdict 13 Aug (2 days later) including Jax. Pattern suggests: (1) Coercion during settlement, (2) Backdating to strengthen position, (3) Court action to attack beneficiary who signed backdating, (4) Ulterior motive rather than genuine urgency."
   
   ;; Related principles
   'related-principles '(beneficiary-adverse-action-prohibition
                        backdating-coercion-indicators
                        manufactured-crisis-indicators
                        proper-purpose-test
                        abuse-of-process)
   
   ;; Remedies
   'remedies '(dismiss-court-action-for-abuse-of-process
              costs-against-applicant
              void-backdated-documents-obtained-by-coercion
              protect-beneficiary-from-further-attacks
              trustee-removal-for-breach-of-duty)))

;; =============================================================================
;; ENHANCED PRINCIPLE: BENEFICIARY PROTECTION WHEN ATTACKED (from v3)
;; =============================================================================

(define beneficiary-protection-when-attacked
  (make-principle
   'name 'beneficiary-protection-when-attacked
   'description "Protection for beneficiaries when attacked by trustees using trust assets or powers"
   'domain '(trust fiduciary beneficiary-rights)
   'confidence 0.97
   'jurisdiction "za"
   'statutory-basis "Trust Property Control Act 57 of 1988, s16 (trustee duties)"
   'common-law-basis "Fiduciary duty, beneficiary protection"
   'base-principles '(fiduciary-duty beneficiary-protection)
   'inference-type 'deductive
   
   ;; Core indicators
   'indicators '(trustee-uses-trust-assets-to-attack-beneficiary
                trustee-uses-trust-powers-to-attack-beneficiary
                trustee-uses-court-process-to-attack-beneficiary
                beneficiary-punished-for-supporting-another-beneficiary
                beneficiary-punished-for-exposing-fraud
                trustee-has-conflicting-interests
                attack-serves-trustee-personal-interests)
   
   ;; Aggravating factors
   'aggravating-factors '(beneficiary-punished-for-fraud-exposure
                         beneficiary-punished-for-supporting-co-beneficiary
                         trustee-has-undisclosed-conflicts
                         trustee-bypasses-direct-powers-to-use-court
                         attack-coincides-with-settlement-negotiation
                         multiple-beneficiaries-attacked-simultaneously)
   
   ;; Red flags for trustee abuse
   'red-flags '((trustee-includes-beneficiary-in-court-action 0.97)
               (beneficiary-exposed-fraud-before-attack 0.96)
               (beneficiary-supported-co-beneficiary 0.95)
               (trustee-has-conflicting-financial-interests 0.94)
               (attack-serves-no-trust-purpose 0.96))
   
   ;; Evidence requirements
   'evidence-required '(court-action-including-beneficiary
                       timeline-of-fraud-exposure-to-attack
                       trustee-conflicting-interests-documentation
                       trust-purpose-analysis
                       beneficiary-support-for-co-beneficiary-evidence
                       trust-asset-use-for-attack)
   
   ;; Legal implications
   'legal-implications '(breach-of-fiduciary-duty
                        violation-of-beneficiary-rights
                        trustee-removal-grounds
                        damages-for-breach-of-duty
                        costs-against-trustee-personally
                        void-court-action-as-abuse-of-process)
   
   ;; Inference logic
   'inference "Trustee attacking beneficiaries using trust assets, powers, or court process violates fundamental fiduciary duty and beneficiary protection principles"
   
   ;; Case application
   "Peter (Trustee) and Danie (Co-Trustee) include Jax (Beneficiary) in interdict for 'helping Daniel' (co-beneficiary). Aggravating factors: (1) Jax exposed fraud before attack, (2) Jax supported Dan (co-beneficiary), (3) Peter and Danie have conflicting interests (Villa Via shareholders), (4) Attack serves no trust purpose, (5) Interdict filed 2 days after Jax signed backdating during settlement discussion."
   
   ;; Related principles
   'related-principles '(fiduciary-duty
                        trust-power-bypass-temporal-analysis
                        undisclosed-trustee-status-indicators
                        fraud-exposure-retaliation-indicators
                        beneficiary-adverse-action-prohibition)
   
   ;; Remedies
   'remedies '(dismiss-court-action-against-beneficiary
              costs-against-trustee-personally
              damages-for-breach-of-fiduciary-duty
              trustee-removal
              appoint-independent-trustee
              protect-beneficiary-from-further-attacks)))

;; =============================================================================
;; HELPER FUNCTIONS
;; =============================================================================

;; Function to evaluate undisclosed trustee status
(define (evaluate-undisclosed-trustee-status trustee evidence)
  (let ((indicator-count (count-matching-indicators 
                          evidence 
                          (get-attribute undisclosed-trustee-status-indicators 'indicators)))
        (red-flag-score (calculate-red-flag-score 
                        evidence 
                        (get-attribute undisclosed-trustee-status-indicators 'red-flags)))
        (conflicting-roles (get-attribute evidence 'conflicting-roles)))
    (make-evaluation
     'principle 'undisclosed-trustee-status-indicators
     'trustee trustee
     'indicator-count indicator-count
     'red-flag-score red-flag-score
     'conflicting-roles conflicting-roles
     'confidence (if (>= indicator-count 4) 0.95 (* 0.95 (/ indicator-count 4)))
     'conclusion (if (and (>= indicator-count 4) (>= red-flag-score 0.90) (>= (length conflicting-roles) 2))
                    "Strong evidence of undisclosed trustee status with conflicting roles"
                    "Insufficient evidence for undisclosed trustee status violation"))))

;; Function to evaluate multi-jurisdiction compliance crisis
(define (evaluate-multi-jurisdiction-compliance-crisis role evidence)
  (let ((jurisdictions-affected (get-attribute evidence 'jurisdictions-affected))
        (regulatory-role-mandatory (get-attribute evidence 'regulatory-role-mandatory))
        (violations-immediate (get-attribute evidence 'violations-immediate))
        (element-count (count-matching-elements 
                        evidence 
                        (get-attribute multi-jurisdiction-compliance-crisis-test 'elements)))
        (red-flag-score (calculate-red-flag-score 
                        evidence 
                        (get-attribute multi-jurisdiction-compliance-crisis-test 'red-flags))))
    (make-evaluation
     'principle 'multi-jurisdiction-compliance-crisis-test
     'role role
     'jurisdictions-affected jurisdictions-affected
     'element-count element-count
     'red-flag-score red-flag-score
     'confidence (if (and (>= jurisdictions-affected 10) regulatory-role-mandatory violations-immediate) 0.95 0.85)
     'conclusion (if (and (>= jurisdictions-affected 10) 
                         regulatory-role-mandatory 
                         violations-immediate
                         (>= red-flag-score 0.90))
                    "Strong evidence of multi-jurisdiction compliance crisis with disproportionate harm"
                    "Insufficient evidence for multi-jurisdiction compliance crisis"))))

;; Function to evaluate trust power bypass with temporal analysis
(define (evaluate-trust-power-bypass timeline evidence)
  (let ((has-absolute-powers (get-attribute evidence 'trustee-has-absolute-powers))
        (seeks-court-relief (get-attribute evidence 'seeks-court-relief))
        (settlement-to-action-days (calculate-days-between 
                                    (get-attribute timeline 'settlement-discussion)
                                    (get-attribute timeline 'court-action)))
        (backdating-to-action-days (calculate-days-between 
                                    (get-attribute timeline 'backdating-signature)
                                    (get-attribute timeline 'court-action)))
        (indicator-count (count-matching-indicators 
                          evidence 
                          (get-attribute trust-power-bypass-temporal-analysis 'indicators)))
        (red-flag-score (calculate-red-flag-score 
                        evidence 
                        (get-attribute trust-power-bypass-temporal-analysis 'red-flags))))
    (make-evaluation
     'principle 'trust-power-bypass-temporal-analysis
     'has-absolute-powers has-absolute-powers
     'seeks-court-relief seeks-court-relief
     'settlement-to-action-days settlement-to-action-days
     'backdating-to-action-days backdating-to-action-days
     'indicator-count indicator-count
     'red-flag-score red-flag-score
     'confidence (if (and has-absolute-powers 
                         seeks-court-relief 
                         (<= settlement-to-action-days 2)) 0.96 0.85)
     'conclusion (if (and has-absolute-powers 
                         seeks-court-relief 
                         (<= settlement-to-action-days 2)
                         (>= red-flag-score 0.90))
                    "Strong evidence of trust power bypass with ulterior motive"
                    "Insufficient evidence for trust power bypass with ulterior motive"))))

;; Function to evaluate beneficiary protection when attacked
(define (evaluate-beneficiary-protection-when-attacked beneficiary evidence)
  (let ((trustee-includes-beneficiary-in-action (get-attribute evidence 'trustee-includes-beneficiary))
        (beneficiary-exposed-fraud (get-attribute evidence 'beneficiary-exposed-fraud))
        (beneficiary-supported-co-beneficiary (get-attribute evidence 'beneficiary-supported-co-beneficiary))
        (trustee-conflicting-interests (get-attribute evidence 'trustee-conflicting-interests))
        (indicator-count (count-matching-indicators 
                          evidence 
                          (get-attribute beneficiary-protection-when-attacked 'indicators)))
        (aggravating-factor-count (count-matching-indicators 
                                   evidence 
                                   (get-attribute beneficiary-protection-when-attacked 'aggravating-factors)))
        (red-flag-score (calculate-red-flag-score 
                        evidence 
                        (get-attribute beneficiary-protection-when-attacked 'red-flags))))
    (make-evaluation
     'principle 'beneficiary-protection-when-attacked
     'beneficiary beneficiary
     'indicator-count indicator-count
     'aggravating-factor-count aggravating-factor-count
     'red-flag-score red-flag-score
     'confidence (if (and trustee-includes-beneficiary-in-action 
                         (>= aggravating-factor-count 2)) 0.97 0.85)
     'conclusion (if (and trustee-includes-beneficiary-in-action 
                         (>= aggravating-factor-count 2)
                         (>= red-flag-score 0.90))
                    "Strong evidence of trustee attacking beneficiary in breach of fiduciary duty"
                    "Insufficient evidence for beneficiary protection violation"))))

;; =============================================================================
;; VALIDATION AND TESTING
;; =============================================================================

;; Validate all new and enhanced principles
(define (validate-new-principles)
  (and (validate-derivation undisclosed-trustee-status-indicators)
       (validate-derivation multi-jurisdiction-compliance-crisis-test)
       (validate-derivation trust-power-bypass-temporal-analysis)
       (validate-derivation beneficiary-protection-when-attacked)))

;; Export principles to registry
(register-principle! undisclosed-trustee-status-indicators)
(register-principle! multi-jurisdiction-compliance-crisis-test)
(register-principle! trust-power-bypass-temporal-analysis)
(register-principle! beneficiary-protection-when-attacked)

;; =============================================================================
;; END OF FILE
;; =============================================================================
