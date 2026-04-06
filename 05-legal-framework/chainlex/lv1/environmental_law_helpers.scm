;; =============================================================================
;; ENVIRONMENTAL LAW HELPER FUNCTIONS
;; =============================================================================
;; Version: 1.0
;; Description: Helper functions for environmental law reasoning (NEMA, EIA)
;; Derived from Level 1 principles: sustainable development, precautionary principle,
;;                                   polluter-pays, environmental stewardship
;; =============================================================================

(define-module (chainlex environmental-law-helpers)
  #:use-module (chainlex core-utilities)
  #:export (
    ;; NEMA principles helpers
    sustainable-development?
    precautionary-principle-applies?
    polluter-pays-applies?
    environmental-justice?
    
    ;; EIA helpers
    eia-required?
    listed-activity?
    significant-impact?
    eia-process-compliant?
    
    ;; Authorization helpers
    environmental-authorization-valid?
    competent-authority?
    conditions-complied-with?
    
    ;; Pollution helpers
    air-quality-compliant?
    water-use-authorized?
    waste-management-compliant?
    
    ;; Biodiversity helpers
    protected-area-compliant?
    threatened-species-protected?
    habitat-protected?
  ))

;; =============================================================================
;; NEMA PRINCIPLES HELPERS
;; =============================================================================

(define (sustainable-development? action)
  "Check if action aligns with sustainable development principle
   Cross-reference: sustainable development, intergenerational equity (Level 1)"
  (let ((meets-present-needs (get-attribute action 'meets-present-needs #f))
        (future-generations-protected 
         (get-attribute action 'future-generations-protected #f))
        (balances-pillars (get-attribute action 'balances-pillars #f)))
    (and meets-present-needs
         future-generations-protected
         balances-pillars)))

(define (precautionary-principle-applies? action)
  "Check if precautionary principle applies
   Cross-reference: precautionary principle (Level 1)"
  (let ((serious-harm-risk (get-attribute action 'serious-harm-risk #f))
        (scientific-uncertainty (get-attribute action 'scientific-uncertainty #f))
        (preventive-measures (get-attribute action 'preventive-measures #f)))
    (and serious-harm-risk
         scientific-uncertainty
         preventive-measures)))

(define (polluter-pays-applies? action)
  "Check if polluter-pays principle applies
   Cross-reference: polluter-pays (Level 1)"
  (let ((pollution-caused (get-attribute action 'pollution-caused #f))
        (costs-internalized (get-attribute action 'costs-internalized #f))
        (polluter-identified (get-attribute action 'polluter-identified #f)))
    (and pollution-caused
         polluter-identified
         costs-internalized)))

(define (environmental-justice? action)
  "Check if environmental justice principles are met
   Cross-reference: equality, dignity, environmental rights (Level 1)"
  (let ((equitable-access (get-attribute action 'equitable-access #f))
        (no-disproportionate-impact 
         (get-attribute action 'no-disproportionate-impact #f))
        (meaningful-participation (get-attribute action 'meaningful-participation #f)))
    (and equitable-access
         no-disproportionate-impact
         meaningful-participation)))

;; =============================================================================
;; EIA HELPERS
;; =============================================================================

(define (eia-required? activity)
  "Check if Environmental Impact Assessment is required
   Cross-reference: environmental protection, NEMA (Level 1)"
  (or (listed-activity? activity)
      (significant-impact? activity)
      (cumulative-impact? activity)))

(define (listed-activity? activity)
  "Check if activity is listed in EIA regulations
   Cross-reference: NEMA regulations (Level 1)"
  (let ((activity-type (get-attribute activity 'type 'unknown))
        (listing (get-attribute activity 'listing 'none)))
    (member-of? listing '(listing1 listing2 listing3))))

(define (significant-impact? activity)
  "Check if activity has potential significant environmental impact
   Cross-reference: environmental protection (Level 1)"
  (let ((impact-magnitude (get-attribute activity 'impact-magnitude 'low))
        (sensitive-area (get-attribute activity 'sensitive-area #f))
        (irreversible (get-attribute activity 'irreversible #f))
        (cumulative-effects (get-attribute activity 'cumulative-effects #f)))
    (or (member-of? impact-magnitude '(high very-high))
        sensitive-area
        irreversible
        cumulative-effects)))

(define (cumulative-impact? activity)
  "Check if cumulative environmental impact exists
   Cross-reference: cumulative impact principles (Level 1)"
  (let ((multiple-activities (get-attribute activity 'multiple-activities #f))
        (combined-impact (get-attribute activity 'combined-impact #f))
        (exceeds-threshold (get-attribute activity 'exceeds-threshold #f)))
    (and multiple-activities
         combined-impact
         exceeds-threshold)))

(define (eia-process-compliant? process)
  "Check if EIA process was compliant with requirements
   Cross-reference: procedural-fairness, NEMA process (Level 1)"
  (and (screening-done? process)
       (scoping-conducted? process)
       (impact-assessment-done? process)
       (public-participation? process)
       (environmental-management-plan? process)
       (competent-authority-decision? process)))

(define (screening-done? process)
  "Check if screening was conducted
   Cross-reference: EIA process (Level 1)"
  (get-attribute process 'screening-done #f))

(define (scoping-conducted? process)
  "Check if scoping was conducted
   Cross-reference: EIA process (Level 1)"
  (let ((scoping (get-attribute process 'scoping-conducted #f))
        (key-issues-identified (get-attribute process 'key-issues-identified #f)))
    (and scoping key-issues-identified)))

(define (impact-assessment-done? process)
  "Check if impact assessment was done
   Cross-reference: EIA process (Level 1)"
  (let ((assessment (get-attribute process 'impact-assessment-done #f))
        (alternatives-considered (get-attribute process 'alternatives-considered #f))
        (mitigation-measures (get-attribute process 'mitigation-measures #f)))
    (and assessment
         alternatives-considered
         mitigation-measures)))

(define (public-participation? process)
  "Check if public participation was conducted
   Cross-reference: audi-alteram-partem, participatory democracy (Level 1)"
  (let ((participation (get-attribute process 'public-participation #f))
        (notice-given (get-attribute process 'notice-given #f))
        (comments-considered (get-attribute process 'comments-considered #f)))
    (and participation
         notice-given
         comments-considered)))

(define (environmental-management-plan? process)
  "Check if environmental management plan was prepared
   Cross-reference: EIA requirements (Level 1)"
  (let ((emp (get-attribute process 'environmental-management-plan #f))
        (monitoring-program (get-attribute process 'monitoring-program #f))
        (compliance-program (get-attribute process 'compliance-program #f)))
    (and emp
         monitoring-program
         compliance-program)))

(define (competent-authority-decision? process)
  "Check if competent authority made decision
   Cross-reference: administrative action (Level 1)"
  (let ((decision-made (get-attribute process 'decision-made #f))
        (competent-authority (get-attribute process 'competent-authority #f))
        (reasons-provided (get-attribute process 'reasons-provided #f)))
    (and decision-made
         competent-authority
         reasons-provided)))

;; =============================================================================
;; AUTHORIZATION HELPERS
;; =============================================================================

(define (environmental-authorization-valid? authorization)
  "Check if environmental authorization is valid
   Cross-reference: legality, NEMA authorization (Level 1)"
  (and (competent-authority? authorization)
       (eia-process-followed? authorization)
       (conditions-complied-with? authorization)
       (not-expired? authorization)
       (not-suspended? authorization)))

(define (competent-authority? authorization)
  "Check if issued by competent authority
   Cross-reference: administrative action (Level 1)"
  (let ((authority (get-attribute authorization 'issuing-authority 'none)))
    (member-of? authority '(deff provincial-authority local-authority))))

(define (eia-process-followed? authorization)
  "Check if EIA process was followed
   Cross-reference: procedural requirements (Level 1)"
  (let ((process (get-attribute authorization 'eia-process #f)))
    (and process
         (eia-process-compliant? process))))

(define (conditions-complied-with? authorization)
  "Check if authorization conditions are complied with
   Cross-reference: compliance obligations (Level 1)"
  (let ((conditions (get-attribute authorization 'conditions '()))
        (compliance-status (get-attribute authorization 'compliance-status 'compliant)))
    (equal? compliance-status 'compliant)))

(define (not-expired? authorization)
  "Check if authorization has not expired
   Cross-reference: temporal validity (Level 1)"
  (let ((expiry-date (get-attribute authorization 'expiry-date 0))
        (current-date (current-date)))
    (or (= expiry-date 0)  ; No expiry
        (< current-date expiry-date))))

(define (not-suspended? authorization)
  "Check if authorization is not suspended or revoked
   Cross-reference: validity requirements (Level 1)"
  (let ((suspended (get-attribute authorization 'suspended #f))
        (revoked (get-attribute authorization 'revoked #f)))
    (and (not suspended)
         (not revoked))))

;; =============================================================================
;; POLLUTION HELPERS
;; =============================================================================

(define (air-quality-compliant? activity)
  "Check if air quality requirements are met
   Cross-reference: pollution prevention (Level 1)"
  (let ((license (get-attribute activity 'atmospheric-emission-license #f))
        (standards-met (get-attribute activity 'emission-standards-met #f))
        (monitoring (get-attribute activity 'monitoring-and-reporting #f)))
    (and license
         standards-met
         monitoring)))

(define (water-use-authorized? use)
  "Check if water use is authorized
   Cross-reference: water resource protection (Level 1)"
  (let ((license (get-attribute use 'water-use-license #f))
        (efficient-use (get-attribute use 'efficient-water-use #f))
        (no-pollution (get-attribute use 'no-pollution #f))
        (allocation-compliant (get-attribute use 'allocation-compliant #f)))
    (and license
         efficient-use
         no-pollution
         allocation-compliant)))

(define (waste-management-compliant? waste)
  "Check if waste management is compliant
   Cross-reference: waste hierarchy, polluter-pays (Level 1)"
  (and (waste-license-if-required? waste)
       (waste-hierarchy-followed? waste)
       (cradle-to-grave-responsibility? waste)
       (proper-disposal? waste)))

(define (waste-license-if-required? waste)
  "Check if waste management license obtained if required
   Cross-reference: waste management requirements (Level 1)"
  (let ((license-required (get-attribute waste 'license-required #f))
        (license-obtained (get-attribute waste 'license-obtained #f)))
    (or (not license-required)
        license-obtained)))

(define (waste-hierarchy-followed? waste)
  "Check if waste hierarchy is followed
   Cross-reference: waste hierarchy principle (Level 1)"
  (let ((hierarchy-priority (get-attribute waste 'hierarchy-priority 'disposal)))
    (member-of? hierarchy-priority 
                '(avoidance reduction reuse recycling recovery treatment disposal))))

(define (cradle-to-grave-responsibility? waste)
  "Check if cradle-to-grave responsibility maintained
   Cross-reference: producer responsibility (Level 1)"
  (let ((tracking (get-attribute waste 'waste-tracking #f))
        (manifest (get-attribute waste 'waste-manifest #f))
        (responsibility-maintained 
         (get-attribute waste 'responsibility-maintained #f)))
    (and tracking
         manifest
         responsibility-maintained)))

(define (proper-disposal? waste)
  "Check if waste properly disposed
   Cross-reference: waste management standards (Level 1)"
  (let ((licensed-facility (get-attribute waste 'licensed-facility #f))
        (appropriate-method (get-attribute waste 'appropriate-method #f))
        (no-illegal-dumping (not (get-attribute waste 'illegal-dumping #f))))
    (and licensed-facility
         appropriate-method
         no-illegal-dumping)))

;; =============================================================================
;; BIODIVERSITY HELPERS
;; =============================================================================

(define (protected-area-compliant? activity)
  "Check if activity in protected area is compliant
   Cross-reference: conservation obligations (Level 1)"
  (let ((in-protected-area (get-attribute activity 'in-protected-area #f))
        (permit-obtained (get-attribute activity 'permit-obtained #f))
        (conservation-objectives (get-attribute activity 'conservation-objectives #f)))
    (or (not in-protected-area)
        (and permit-obtained conservation-objectives))))

(define (threatened-species-protected? activity)
  "Check if threatened species are protected
   Cross-reference: biodiversity protection (Level 1)"
  (let ((threatened-species-present 
         (get-attribute activity 'threatened-species-present #f))
        (no-harm (get-attribute activity 'no-harm-to-species #f))
        (permit-if-required (get-attribute activity 'species-permit #f)))
    (or (not threatened-species-present)
        (and no-harm permit-if-required))))

(define (habitat-protected? activity)
  "Check if critical habitat is protected
   Cross-reference: habitat protection (Level 1)"
  (let ((critical-habitat (get-attribute activity 'critical-habitat #f))
        (habitat-assessment (get-attribute activity 'habitat-assessment #f))
        (no-destruction (get-attribute activity 'no-habitat-destruction #f))
        (offset-measures (get-attribute activity 'offset-measures #f)))
    (or (not critical-habitat)
        (and habitat-assessment
             (or no-destruction offset-measures)))))

;; End of environmental law helpers
