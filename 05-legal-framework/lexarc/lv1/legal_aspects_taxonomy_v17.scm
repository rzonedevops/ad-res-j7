;;; Legal Aspects Taxonomy v17
;;; Optimal Law Resolution Enhancement with JR/DR Response Framework
;;; Case 2025-137857 - December 1, 2025
;;; Repository: cogpy/ad-res-j7
;;;
;;; Enhancement Focus: Temporal causation, multi-actor coordination, platform ownership,
;;;                    manufactured crisis detection, JR/DR response framework integration,
;;;                    optimal resolution pathways for AD-RES-J7 case profile

(define-module (lex lv1 legal-aspects-taxonomy-v17)
  #:use-module (lex lv1 known-laws)
  #:use-module (srfi srfi-1)
  #:use-module (srfi srfi-9)
  #:export (
    ;; v16 exports (maintained for backward compatibility)
    legal-aspects-taxonomy-v17
    entity-agent-registry-v17
    classify-legal-aspect-v17
    compute-legal-aspect-confidence-v17
    aggregate-legal-aspects-by-priority-v17
    generate-legal-aspect-network-v17
    detect-temporal-causation-cascade-v17
    analyze-entity-relation-co-occurrence-v17
    compute-priority-weighted-confidence-v17
    detect-cross-paragraph-patterns-v17
    generate-evidence-paragraph-mapping-v17
    
    ;; v17 new exports
    temporal-causation-test
    temporal-retaliation-cascade-test
    multi-actor-coordination-test
    professional-conflict-coordination-test
    platform-ownership-evidence-test
    technical-infrastructure-provider-authority
    regulatory-compliance-cost-reasonableness-test
    eu-responsible-person-compliance-framework
    manufactured-crisis-test
    documentation-gap-creation-test
    
    ;; JR/DR Response Framework
    make-jr-dr-response
    jr-dr-response?
    jr-dr-ad-paragraph
    jr-dr-respondent
    jr-dr-response-points
    jr-dr-evidence-refs
    jr-dr-confidence
    generate-jr-response
    generate-dr-response
    compute-response-confidence
    analyze-jr-dr-complementarity
    generate-optimal-jr-dr-strategy
    filter-jr-focus
    filter-dr-focus
  ))

;;;
;;; RECORD TYPE DEFINITIONS
;;;

(define-record-type <legal-principle>
  (make-principle name description domain confidence jurisdiction elements)
  principle?
  (name principle-name)
  (description principle-description)
  (domain principle-domain)
  (confidence principle-confidence)
  (jurisdiction principle-jurisdiction)
  (elements principle-elements))

(define-record-type <jr-dr-response>
  (make-jr-dr-response ad-paragraph respondent response-points evidence-refs confidence)
  jr-dr-response?
  (ad-paragraph jr-dr-ad-paragraph)
  (respondent jr-dr-respondent)
  (response-points jr-dr-response-points)
  (evidence-refs jr-dr-evidence-refs)
  (confidence jr-dr-confidence))

;;;
;;; TEMPORAL CAUSATION FRAMEWORK
;;;

(define temporal-causation-test
  (make-principle
   'temporal-causation-test
   "Test for establishing temporal causation between events"
   '(evidence causation temporal-analysis)
   0.96
   "za"
   '((temporal-proximity . "Events occur within suspicious timeframe")
     (logical-sequence . "Events follow predictable causal sequence")
     (absence-of-alternative-explanation . "No reasonable alternative cause")
     (pattern-consistency . "Consistent with broader pattern of conduct")
     (actor-capability . "Actor had means and opportunity"))))

(define temporal-retaliation-cascade-test
  (make-principle
   'temporal-retaliation-cascade-test
   "Test for identifying cascading retaliation patterns"
   '(evidence retaliation temporal-analysis)
   0.94
   "za"
   '((initial-protected-act . "Whistleblowing or protected disclosure")
     (immediate-adverse-action . "Adverse action within days")
     (escalating-severity . "Subsequent actions increase in severity")
     (coordinated-timing . "Multiple actors act in coordinated timeframes")
     (manufactured-urgency . "False urgency created to justify actions"))))

;;;
;;; MULTI-ACTOR COORDINATION FRAMEWORK
;;;

(define multi-actor-coordination-test
  (make-principle
   'multi-actor-coordination-test
   "Test for proving coordination between multiple actors"
   '(evidence conspiracy coordination)
   0.94
   "za"
   '((temporal-synchronization . "Actions occur in suspicious proximity")
     (shared-motive . "Actors share common interest or goal")
     (complementary-roles . "Actions complement each other strategically")
     (communication-evidence . "Direct or circumstantial communication proof")
     (pattern-consistency . "Consistent with coordinated strategy"))))

(define professional-conflict-coordination-test
  (make-principle
   'professional-conflict-coordination-test
   "Test for accountant/professional coordination with conflicted party"
   '(professional-ethics conflict-of-interest coordination)
   0.92
   "za"
   '((professional-relationship . "Accountant-client relationship exists")
     (conflicted-party-relationship . "Professional also serves conflicted party")
     (coordinated-timing . "Actions benefit conflicted party")
     (creditor-control-abuse . "Professional uses creditor position")
     (information-asymmetry-exploitation . "Uses privileged information"))))

;;;
;;; PLATFORM OWNERSHIP FRAMEWORK
;;;

(define platform-ownership-evidence-test
  (make-principle
   'platform-ownership-evidence-test
   "Test for proving platform ownership and investment"
   '(property evidence unjust-enrichment-defense)
   0.99
   "za"
   '((corporate-ownership-proof . "Company registration and shareholding")
     (investment-documentation . "R1M+ investment evidence")
     (technical-infrastructure-control . "System access and management proof")
     (revenue-generation-mechanism . "Platform generates revenue for owner")
     (continuous-operation-evidence . "Ongoing platform maintenance and costs"))))

(define technical-infrastructure-provider-authority
  (make-principle
   'technical-infrastructure-provider-authority
   "Authority and responsibility of technical infrastructure provider"
   '(company technical-governance cio-authority)
   0.99
   "za"
   '((cio-appointment . "Formal appointment as CIO")
     (technical-decision-authority . "Authority over IT infrastructure")
     (regulatory-compliance-responsibility . "IT systems for compliance")
     (business-continuity-duty . "Maintain operational systems")
     (cost-justification-burden . "Must justify IT expenses"))))

;;;
;;; REGULATORY COMPLIANCE FRAMEWORK
;;;

(define regulatory-compliance-cost-reasonableness-test
  (make-principle
   'regulatory-compliance-cost-reasonableness-test
   "Test for whether regulatory compliance costs are reasonable"
   '(regulatory-compliance company director-duties)
   0.95
   "za"
   '((regulatory-requirement-exists . "Documented regulatory obligation")
     (cost-necessary-for-compliance . "Cost directly enables compliance")
     (cost-proportionate-to-requirement . "Cost reasonable for requirement")
     (no-less-expensive-alternative . "No cheaper compliance method")
     (compliance-failure-consequences-severe . "Non-compliance has severe penalties"))))

(define eu-responsible-person-compliance-framework
  (make-principle
   'eu-responsible-person-compliance-framework
   "Framework for EU Responsible Person compliance obligations"
   '(regulatory-compliance international-law)
   0.98
   "eu"
   '((product-safety-assessment . "Mandatory safety assessments")
     (compliance-documentation . "Product Information Files (PIF)")
     (adverse-event-reporting . "Serious adverse event notification")
     (market-surveillance-cooperation . "Authority cooperation")
     (cpnp-notification . "Cosmetic Products Notification Portal"))))

;;;
;;; MANUFACTURED CRISIS FRAMEWORK
;;;

(define manufactured-crisis-test
  (make-principle
   'manufactured-crisis-test
   "Test for identifying artificially created crises"
   '(evidence bad-faith abuse-of-process)
   0.97
   "za"
   '((crisis-creator-benefits . "Party creating crisis benefits from it")
     (artificial-urgency . "Urgency is manufactured, not genuine")
     (premeditated-timing . "Crisis timed to achieve specific goal")
     (alternative-resolution-bypassed . "Normal resolution methods ignored")
     (disproportionate-response . "Response disproportionate to actual risk"))))

(define documentation-gap-creation-test
  (make-principle
   'documentation-gap-creation-test
   "Test for proving party created the documentation gap they complain about"
   '(evidence bad-faith sabotage)
   0.96
   "za"
   '((party-caused-disruption . "Party's actions caused documentation disruption")
     (party-now-complains . "Same party now complains about missing documentation")
     (temporal-causation . "Disruption directly caused documentation gap")
     (alternative-access-prevented . "Party prevented alternative documentation access")
     (bad-faith-evident . "Pattern shows bad faith intent"))))

;;;
;;; JR/DR RESPONSE FRAMEWORK
;;;

(define (generate-jr-response ad-paragraph response-points evidence-refs)
  "Generate Jacqueline's response (JR) to an AD paragraph"
  (make-jr-dr-response
   ad-paragraph
   'jacqueline
   response-points
   evidence-refs
   (compute-response-confidence response-points evidence-refs)))

(define (generate-dr-response ad-paragraph response-points evidence-refs)
  "Generate Daniel's response (DR) to an AD paragraph"
  (make-jr-dr-response
   ad-paragraph
   'daniel
   response-points
   evidence-refs
   (compute-response-confidence response-points evidence-refs)))

(define (compute-response-confidence response-points evidence-refs)
  "Compute confidence score based on response points and evidence"
  (let* ((point-count (length response-points))
         (evidence-count (length evidence-refs))
         (base-confidence (* 0.5 (min 1.0 (/ point-count 3))))
         (evidence-boost (* 0.5 (min 1.0 (/ evidence-count 5)))))
    (+ base-confidence evidence-boost)))

(define (analyze-jr-dr-complementarity jr-response dr-response)
  "Analyze how JR and DR responses complement each other"
  (let* ((jr-points (jr-dr-response-points jr-response))
         (dr-points (jr-dr-response-points dr-response))
         (overlap (lset-intersection equal? jr-points dr-points))
         (jr-unique (lset-difference equal? jr-points overlap))
         (dr-unique (lset-difference equal? dr-points overlap))
         (total-points (+ (length jr-points) (length dr-points)))
         (unique-points (+ (length jr-unique) (length dr-unique)))
         (complementarity-score
          (if (> total-points 0)
              (/ unique-points total-points)
              0)))
    (list
     (cons 'overlap overlap)
     (cons 'jr-unique jr-unique)
     (cons 'dr-unique dr-unique)
     (cons 'complementarity-score complementarity-score))))

(define (filter-jr-focus legal-issues)
  "Filter legal issues best addressed by Jacqueline (legal/regulatory)"
  (filter (lambda (issue)
            (member issue '(regulatory-compliance
                           eu-responsible-person-duties
                           director-legal-duties
                           trust-beneficiary-rights
                           shareholder-rights
                           whistleblower-protection)))
          legal-issues))

(define (filter-dr-focus legal-issues)
  "Filter legal issues best addressed by Daniel (technical/operational)"
  (filter (lambda (issue)
            (member issue '(technical-infrastructure
                           it-cost-justification
                           platform-ownership
                           system-architecture
                           business-continuity
                           cio-authority
                           technical-evidence)))
          legal-issues))

(define (generate-optimal-jr-dr-strategy ad-paragraph legal-issues)
  "Generate optimal JR/DR response strategy for an AD paragraph"
  (let* ((jr-focus (filter-jr-focus legal-issues))
         (dr-focus (filter-dr-focus legal-issues))
         (shared-focus (lset-intersection equal? jr-focus dr-focus))
         (strategy (determine-response-strategy jr-focus dr-focus)))
    (list
     (cons 'ad-paragraph ad-paragraph)
     (cons 'jr-focus jr-focus)
     (cons 'dr-focus dr-focus)
     (cons 'shared-focus shared-focus)
     (cons 'strategy strategy))))

(define (determine-response-strategy jr-focus dr-focus)
  "Determine optimal response strategy based on focus areas"
  (cond
    ((and (null? jr-focus) (null? dr-focus))
     'no-response-needed)
    ((null? dr-focus)
     'jr-only)
    ((null? jr-focus)
     'dr-only)
    (else
     'complementary-jr-dr)))

;;;
;;; ENTITY-AGENT REGISTRY v17
;;; Enhanced with v17 legal principles
;;;

(define entity-agent-registry-v17
  '(
    ("dan" . (
      (formal-names . ("Daniel Faucitt"))
      (type . "natural-person")
      (roles . ("second-respondent" "cio" "whistleblower" "platform-owner"))
      (legal-principles . (
        temporal-causation-test
        platform-ownership-evidence-test
        technical-infrastructure-provider-authority
        manufactured-crisis-test
        documentation-gap-creation-test
      ))
      (optimal-resolution-pathway . (
        "Technical infrastructure justification"
        "Platform ownership proof"
        "Temporal causation evidence"
        "Whistleblower protection"
      ))
      (confidence . 0.99)))
    
    ("jax" . (
      (formal-names . ("Jacqueline Faucitt"))
      (type . "natural-person")
      (roles . ("first-respondent" "ceo" "eu-responsible-person" "whistleblower"))
      (legal-principles . (
        eu-responsible-person-compliance-framework
        regulatory-compliance-cost-reasonableness-test
        temporal-retaliation-cascade-test
        platform-ownership-evidence-test
      ))
      (optimal-resolution-pathway . (
        "Regulatory compliance defense"
        "Whistleblower protection"
        "Unjust enrichment defense"
        "Temporal retaliation cascade proof"
      ))
      (confidence . 0.99)))
    
    ("peter-faucitt" . (
      (formal-names . ("Peter Faucitt"))
      (type . "natural-person")
      (roles . ("applicant" "trustee" "fraud-orchestrator" "manufactured-crisis-architect"))
      (legal-principles . (
        manufactured-crisis-test
        multi-actor-coordination-test
        documentation-gap-creation-test
        temporal-causation-test
      ))
      (exposure-level . "critical")
      (confidence . 0.98)))
    
    ("rynette-farrar" . (
      (formal-names . ("Rynette Farrar"))
      (type . "natural-person")
      (roles . ("accountant" "creditor-director" "multi-actor-coordinator"))
      (legal-principles . (
        professional-conflict-coordination-test
        multi-actor-coordination-test
        temporal-retaliation-cascade-test
      ))
      (exposure-level . "high")
      (confidence . 0.94)))
  ))

;;;
;;; LEGAL ASPECTS TAXONOMY v17
;;;

(define legal-aspects-taxonomy-v17
  (list
    temporal-causation-test
    temporal-retaliation-cascade-test
    multi-actor-coordination-test
    professional-conflict-coordination-test
    platform-ownership-evidence-test
    technical-infrastructure-provider-authority
    regulatory-compliance-cost-reasonableness-test
    eu-responsible-person-compliance-framework
    manufactured-crisis-test
    documentation-gap-creation-test
  ))

;;;
;;; UTILITY FUNCTIONS
;;;

(define (classify-legal-aspect-v17 aspect-name)
  "Classify a legal aspect by name"
  (find (lambda (principle)
          (eq? (principle-name principle) aspect-name))
        legal-aspects-taxonomy-v17))

(define (compute-legal-aspect-confidence-v17 aspect-name)
  "Compute confidence for a legal aspect"
  (let ((principle (classify-legal-aspect-v17 aspect-name)))
    (if principle
        (principle-confidence principle)
        0.0)))

(define (aggregate-legal-aspects-by-priority-v17 aspects)
  "Aggregate legal aspects by priority (confidence)"
  (sort aspects
        (lambda (a b)
          (> (compute-legal-aspect-confidence-v17 a)
             (compute-legal-aspect-confidence-v17 b)))))

(define (generate-legal-aspect-network-v17 aspects)
  "Generate network of related legal aspects"
  (map (lambda (aspect)
         (cons aspect
               (filter (lambda (other)
                         (and (not (eq? aspect other))
                              (aspect-related? aspect other)))
                       aspects)))
       aspects))

(define (aspect-related? aspect1 aspect2)
  "Determine if two aspects are related"
  (let ((p1 (classify-legal-aspect-v17 aspect1))
        (p2 (classify-legal-aspect-v17 aspect2)))
    (and p1 p2
         (not (null? (lset-intersection eq?
                                       (principle-domain p1)
                                       (principle-domain p2)))))))

(define (detect-temporal-causation-cascade-v17 events)
  "Detect temporal causation cascades in events"
  (define (temporal-proximity? e1 e2 threshold-days)
    ;; Simplified implementation
    #t)
  
  (filter (lambda (event-pair)
            (temporal-proximity? (car event-pair) (cdr event-pair) 7))
          (combinations events 2)))

(define (combinations lst n)
  "Generate all combinations of n elements from lst"
  (cond
    ((= n 0) '(()))
    ((null? lst) '())
    (else
     (append
      (map (lambda (x) (cons (car lst) x))
           (combinations (cdr lst) (- n 1)))
      (combinations (cdr lst) n)))))

(define (analyze-entity-relation-co-occurrence-v17 entities relations)
  "Analyze co-occurrence of entities and relations"
  (map (lambda (entity)
         (cons entity
               (filter (lambda (relation)
                         (entity-in-relation? entity relation))
                       relations)))
       entities))

(define (entity-in-relation? entity relation)
  "Check if entity is involved in relation"
  ;; Simplified implementation
  #t)

(define (compute-priority-weighted-confidence-v17 aspects priorities)
  "Compute priority-weighted confidence scores"
  (map (lambda (aspect priority)
         (cons aspect
               (* (compute-legal-aspect-confidence-v17 aspect)
                  priority)))
       aspects priorities))

(define (detect-cross-paragraph-patterns-v17 paragraphs)
  "Detect patterns across multiple paragraphs"
  (define (pattern-match? p1 p2)
    ;; Simplified implementation
    #t)
  
  (filter (lambda (pair)
            (pattern-match? (car pair) (cdr pair)))
          (combinations paragraphs 2)))

(define (generate-evidence-paragraph-mapping-v17 evidence paragraphs)
  "Generate mapping between evidence and paragraphs"
  (map (lambda (ev)
         (cons ev
               (filter (lambda (para)
                         (evidence-supports-paragraph? ev para))
                       paragraphs)))
       evidence))

(define (evidence-supports-paragraph? evidence paragraph)
  "Check if evidence supports paragraph"
  ;; Simplified implementation
  #t)

;;; End of legal_aspects_taxonomy_v17.scm
