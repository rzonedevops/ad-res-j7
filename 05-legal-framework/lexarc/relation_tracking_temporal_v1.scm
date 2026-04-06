;;; relation_tracking_temporal_v1.scm
;;; Relation Tracking with Temporal Versioning for Multi-Agent Entity-Relation Framework
;;; Date: 2025-12-19
;;; Purpose: Track relationships between entities with full temporal versioning

(define-module (lex relation-tracking-temporal-v1)
  #:use-module (srfi srfi-9)
  #:use-module (srfi srfi-1)
  #:use-module (srfi srfi-19)
  #:export (
    ;; Relationship record types
    <relationship>
    <relationship-version>
    <relationship-state-transition>
    
    ;; Relationship constructors
    make-relationship
    make-relationship-version
    make-relationship-state-transition
    
    ;; Relationship accessors
    relationship-id
    relationship-entity-a-id
    relationship-entity-b-id
    relationship-type
    relationship-category
    relationship-state
    relationship-start-date
    relationship-end-date
    relationship-attributes
    relationship-evidence
    relationship-confidence
    relationship-version
    
    ;; Relationship operations
    create-relationship
    get-relationship
    update-relationship
    terminate-relationship
    suspend-relationship
    reactivate-relationship
    dispute-relationship
    query-relationships
    
    ;; Temporal operations
    query-relationship-at-time
    query-relationships-during-period
    get-relationship-version-history
    get-relationship-state-transitions
    
    ;; Relationship type taxonomy
    relationship-types
    relationship-categories
    validate-relationship-type
    
    ;; Bidirectional operations
    get-inverse-relationship
    get-entity-relationships
    get-entity-relationships-by-type
  ))

;;;
;;; RELATIONSHIP RECORD TYPES
;;;

(define-record-type <relationship>
  (make-relationship-internal
    relationship-id
    entity-a-id
    entity-b-id
    entity-a-role
    entity-b-role
    relationship-type
    relationship-category
    state
    start-date
    end-date
    attributes
    evidence
    confidence
    version
    created-at
    updated-at)
  relationship?
  (relationship-id relationship-id)
  (entity-a-id relationship-entity-a-id)
  (entity-b-id relationship-entity-b-id)
  (entity-a-role relationship-entity-a-role set-relationship-entity-a-role!)
  (entity-b-role relationship-entity-b-role set-relationship-entity-b-role!)
  (relationship-type relationship-type set-relationship-type!)
  (relationship-category relationship-category set-relationship-category!)
  (state relationship-state set-relationship-state!)
  (start-date relationship-start-date set-relationship-start-date!)
  (end-date relationship-end-date set-relationship-end-date!)
  (attributes relationship-attributes set-relationship-attributes!)
  (evidence relationship-evidence set-relationship-evidence!)
  (confidence relationship-confidence set-relationship-confidence!)
  (version relationship-version set-relationship-version!)
  (created-at relationship-created-at)
  (updated-at relationship-updated-at set-relationship-updated-at!))

(define-record-type <relationship-version>
  (make-relationship-version-internal
    version-id
    relationship-id
    version-number
    timestamp
    state
    attributes
    evidence
    modified-by
    modification-reason)
  relationship-version?
  (version-id relationship-version-id)
  (relationship-id relationship-version-relationship-id)
  (version-number relationship-version-number)
  (timestamp relationship-version-timestamp)
  (state relationship-version-state)
  (attributes relationship-version-attributes)
  (evidence relationship-version-evidence)
  (modified-by relationship-version-modified-by)
  (modification-reason relationship-version-modification-reason))

(define-record-type <relationship-state-transition>
  (make-relationship-state-transition-internal
    transition-id
    relationship-id
    from-state
    to-state
    timestamp
    reason
    triggered-by)
  relationship-state-transition?
  (transition-id relationship-state-transition-id)
  (relationship-id relationship-state-transition-relationship-id)
  (from-state relationship-state-transition-from-state)
  (to-state relationship-state-transition-to-state)
  (timestamp relationship-state-transition-timestamp)
  (reason relationship-state-transition-reason)
  (triggered-by relationship-state-transition-triggered-by))

;;;
;;; RELATIONSHIP STORAGE (in-memory for now, can be replaced with database)
;;;

(define *relationship-store* (make-hash-table))
(define *relationship-version-store* (make-hash-table))
(define *relationship-state-transition-store* (make-hash-table))

;;;
;;; RELATIONSHIP TYPE TAXONOMY
;;;

(define relationship-types
  '(;; Ownership relations
    (shareholder . ownership)
    (beneficial-owner . ownership)
    (asset-owner . ownership)
    (intellectual-property-owner . ownership)
    (trust-beneficiary . ownership)
    
    ;; Fiduciary relations
    (trustee-trust . fiduciary)
    (trustee-beneficiary . fiduciary)
    (director-company . fiduciary)
    (executor-estate . fiduciary)
    (guardian-ward . fiduciary)
    
    ;; Employment relations
    (employer-employee . employment)
    (contractor-client . employment)
    (consultant-client . employment)
    (service-provider-client . employment)
    
    ;; Family relations
    (parent-child . family)
    (sibling . family)
    (spouse . family)
    (extended-family . family)
    
    ;; Coordination relations
    (co-respondent . coordination)
    (co-conspirator . coordination)
    (business-partner . coordination)
    (collaborator . coordination)
    (alliance . coordination)
    
    ;; Legal relations
    (applicant-respondent . legal)
    (plaintiff-defendant . legal)
    (creditor-debtor . legal)
    (guarantor-principal . legal)
    (co-litigant . legal)
    
    ;; Adversarial relations
    (opponent . adversarial)
    (competitor . adversarial)
    (adversary . adversarial)
    (whistleblower-target . adversarial)
    (victim-perpetrator . adversarial)
    
    ;; Regulatory relations
    (regulator-regulated . regulatory)
    (auditor-auditee . regulatory)
    (inspector-inspected . regulatory)
    (licensor-licensee . regulatory)))

(define relationship-categories
  '(ownership fiduciary employment family coordination legal adversarial regulatory))

;;;
;;; RELATIONSHIP STATE LIFECYCLE
;;;

(define relationship-states
  '(proposed active modified suspended disputed terminated rejected archived))

(define valid-state-transitions
  '((proposed . (active rejected))
    (active . (modified suspended disputed terminated))
    (modified . (active suspended disputed terminated))
    (suspended . (active terminated))
    (disputed . (active terminated))
    (terminated . (archived))
    (rejected . (archived))
    (archived . ())))

;;;
;;; RELATIONSHIP CONSTRUCTORS
;;;

(define (make-relationship entity-a-id entity-b-id relationship-type attributes)
  "Create a new relationship.
   
   Parameters:
   - entity-a-id: First entity identifier
   - entity-b-id: Second entity identifier
   - relationship-type: Type of relationship
   - attributes: Association list of attributes
   
   Returns: Relationship record"
  
  (let* ((relationship-id (generate-id "relationship"))
         (category (get-relationship-category relationship-type))
         (timestamp (current-timestamp)))
    (make-relationship-internal
      relationship-id
      entity-a-id
      entity-b-id
      (assoc-ref attributes 'entity-a-role "entity-a")
      (assoc-ref attributes 'entity-b-role "entity-b")
      relationship-type
      category
      'proposed
      (assoc-ref attributes 'start-date timestamp)
      (assoc-ref attributes 'end-date #f)
      attributes
      (assoc-ref attributes 'evidence '())
      (assoc-ref attributes 'confidence 0.5)
      1
      timestamp
      timestamp)))

(define (make-relationship-version relationship-id version-number state attributes evidence modified-by reason)
  "Create a new relationship version.
   
   Parameters:
   - relationship-id: Relationship identifier
   - version-number: Version number
   - state: Relationship state
   - attributes: Relationship attributes
   - evidence: Evidence for relationship
   - modified-by: Who modified the relationship
   - reason: Reason for modification
   
   Returns: Relationship version record"
  
  (make-relationship-version-internal
    (generate-id "version")
    relationship-id
    version-number
    (current-timestamp)
    state
    attributes
    evidence
    modified-by
    reason))

(define (make-relationship-state-transition relationship-id from-state to-state reason triggered-by)
  "Create a new relationship state transition.
   
   Parameters:
   - relationship-id: Relationship identifier
   - from-state: Previous state
   - to-state: New state
   - reason: Reason for transition
   - triggered-by: Who triggered the transition
   
   Returns: Relationship state transition record"
  
  (make-relationship-state-transition-internal
    (generate-id "transition")
    relationship-id
    from-state
    to-state
    (current-timestamp)
    reason
    triggered-by))

;;;
;;; RELATIONSHIP OPERATIONS
;;;

(define (create-relationship entity-a-id entity-b-id relationship-type attributes)
  "Create and store a new relationship.
   
   Parameters:
   - entity-a-id: First entity identifier
   - entity-b-id: Second entity identifier
   - relationship-type: Type of relationship
   - attributes: Association list of attributes
   
   Returns: Created relationship"
  
  (if (validate-relationship-type relationship-type)
      (let* ((relationship (make-relationship entity-a-id entity-b-id relationship-type attributes))
             (relationship-id (relationship-id relationship)))
        ;; Store relationship
        (hash-set! *relationship-store* relationship-id relationship)
        
        ;; Create initial version
        (let ((version (make-relationship-version
                        relationship-id
                        1
                        'proposed
                        attributes
                        (assoc-ref attributes 'evidence '())
                        "system"
                        "Initial creation")))
          (hash-set! *relationship-version-store* 
                    (relationship-version-id version) 
                    version))
        
        relationship)
      (error "Invalid relationship type" relationship-type)))

(define (get-relationship relationship-id)
  "Retrieve relationship by ID.
   
   Parameters:
   - relationship-id: Relationship identifier
   
   Returns: Relationship or #f if not found"
  
  (hash-ref *relationship-store* relationship-id #f))

(define (update-relationship relationship-id attributes modified-by reason)
  "Update relationship attributes (creates new version).
   
   Parameters:
   - relationship-id: Relationship identifier
   - attributes: New or updated attributes
   - modified-by: Who is modifying the relationship
   - reason: Reason for modification
   
   Returns: Updated relationship"
  
  (let ((relationship (get-relationship relationship-id)))
    (if relationship
        (let* ((new-version (+ (relationship-version relationship) 1))
               (merged-attributes (merge-attributes 
                                   (relationship-attributes relationship) 
                                   attributes))
               (new-evidence (merge-evidence
                             (relationship-evidence relationship)
                             (assoc-ref attributes 'evidence '()))))
          
          ;; Update relationship
          (set-relationship-attributes! relationship merged-attributes)
          (set-relationship-evidence! relationship new-evidence)
          (set-relationship-version! relationship new-version)
          (set-relationship-updated-at! relationship (current-timestamp))
          
          ;; Create version record
          (let ((version (make-relationship-version
                          relationship-id
                          new-version
                          (relationship-state relationship)
                          merged-attributes
                          new-evidence
                          modified-by
                          reason)))
            (hash-set! *relationship-version-store* 
                      (relationship-version-id version) 
                      version))
          
          ;; Create state transition if state changed
          (when (and (assoc-ref attributes 'state)
                     (not (equal? (relationship-state relationship)
                                  (assoc-ref attributes 'state))))
            (let ((transition (make-relationship-state-transition
                               relationship-id
                               (relationship-state relationship)
                               (assoc-ref attributes 'state)
                               reason
                               modified-by)))
              (hash-set! *relationship-state-transition-store*
                        (relationship-state-transition-id transition)
                        transition)
              (set-relationship-state! relationship (assoc-ref attributes 'state))))
          
          relationship)
        #f)))

(define (terminate-relationship relationship-id end-date reason terminated-by)
  "Terminate relationship with end date and reason.
   
   Parameters:
   - relationship-id: Relationship identifier
   - end-date: Relationship end date
   - reason: Reason for termination
   - terminated-by: Who terminated the relationship
   
   Returns: Terminated relationship"
  
  (let ((relationship (get-relationship relationship-id)))
    (if relationship
        (begin
          (set-relationship-end-date! relationship end-date)
          (set-relationship-state! relationship 'terminated)
          (set-relationship-updated-at! relationship (current-timestamp))
          
          ;; Create state transition
          (let ((transition (make-relationship-state-transition
                             relationship-id
                             (relationship-state relationship)
                             'terminated
                             reason
                             terminated-by)))
            (hash-set! *relationship-state-transition-store*
                      (relationship-state-transition-id transition)
                      transition))
          
          relationship)
        #f)))

(define (suspend-relationship relationship-id reason suspended-by)
  "Suspend relationship temporarily.
   
   Parameters:
   - relationship-id: Relationship identifier
   - reason: Reason for suspension
   - suspended-by: Who suspended the relationship
   
   Returns: Suspended relationship"
  
  (update-relationship relationship-id
                      `((state . suspended))
                      suspended-by
                      reason))

(define (reactivate-relationship relationship-id reason reactivated-by)
  "Reactivate suspended relationship.
   
   Parameters:
   - relationship-id: Relationship identifier
   - reason: Reason for reactivation
   - reactivated-by: Who reactivated the relationship
   
   Returns: Reactivated relationship"
  
  (update-relationship relationship-id
                      `((state . active))
                      reactivated-by
                      reason))

(define (dispute-relationship relationship-id reason disputed-by)
  "Mark relationship as disputed.
   
   Parameters:
   - relationship-id: Relationship identifier
   - reason: Reason for dispute
   - disputed-by: Who disputed the relationship
   
   Returns: Disputed relationship"
  
  (update-relationship relationship-id
                      `((state . disputed))
                      disputed-by
                      reason))

(define (query-relationships filters)
  "Query relationships with filters.
   
   Parameters:
   - filters: Association list of filter criteria
   
   Returns: List of matching relationships"
  
  (let ((all-relationships (hash-map->list (lambda (k v) v) *relationship-store*)))
    (filter (lambda (relationship)
              (apply-relationship-filters relationship filters))
            all-relationships)))

;;;
;;; TEMPORAL OPERATIONS
;;;

(define (query-relationship-at-time relationship-id timestamp)
  "Query relationship state at specific point in time.
   
   Parameters:
   - relationship-id: Relationship identifier
   - timestamp: Point in time to query
   
   Returns: Relationship version active at specified time"
  
  (let ((versions (get-relationship-version-history relationship-id)))
    (find (lambda (v)
            (<= (relationship-version-timestamp v) timestamp))
          (sort versions
                (lambda (a b)
                  (> (relationship-version-timestamp a)
                     (relationship-version-timestamp b)))))))

(define (query-relationships-during-period start-time end-time)
  "Query relationships active during time period.
   
   Parameters:
   - start-time: Period start time
   - end-time: Period end time
   
   Returns: List of relationships active during period"
  
  (let ((all-relationships (hash-map->list (lambda (k v) v) *relationship-store*)))
    (filter (lambda (r)
              (relationship-active-during? r start-time end-time))
            all-relationships)))

(define (get-relationship-version-history relationship-id)
  "Get complete version history for relationship.
   
   Parameters:
   - relationship-id: Relationship identifier
   
   Returns: List of relationship versions (sorted by version number)"
  
  (let ((all-versions (hash-map->list (lambda (k v) v) *relationship-version-store*)))
    (sort (filter (lambda (v)
                    (equal? (relationship-version-relationship-id v) relationship-id))
                  all-versions)
          (lambda (a b)
            (< (relationship-version-number a)
               (relationship-version-number b))))))

(define (get-relationship-state-transitions relationship-id)
  "Get all state transitions for relationship.
   
   Parameters:
   - relationship-id: Relationship identifier
   
   Returns: List of state transitions (sorted by timestamp)"
  
  (let ((all-transitions (hash-map->list (lambda (k v) v) *relationship-state-transition-store*)))
    (sort (filter (lambda (t)
                    (equal? (relationship-state-transition-relationship-id t) relationship-id))
                  all-transitions)
          (lambda (a b)
            (< (relationship-state-transition-timestamp a)
               (relationship-state-transition-timestamp b))))))

;;;
;;; BIDIRECTIONAL OPERATIONS
;;;

(define (get-inverse-relationship relationship)
  "Get inverse perspective of relationship (swap entity A and B).
   
   Parameters:
   - relationship: Relationship record
   
   Returns: Inverse relationship perspective"
  
  `((relationship-id . ,(relationship-id relationship))
    (entity-a-id . ,(relationship-entity-b-id relationship))
    (entity-b-id . ,(relationship-entity-a-id relationship))
    (entity-a-role . ,(relationship-entity-b-role relationship))
    (entity-b-role . ,(relationship-entity-a-role relationship))
    (relationship-type . ,(relationship-type relationship))
    (relationship-category . ,(relationship-category relationship))
    (state . ,(relationship-state relationship))
    (perspective . inverse)))

(define (get-entity-relationships entity-id)
  "Get all relationships for an entity.
   
   Parameters:
   - entity-id: Entity identifier
   
   Returns: List of relationships (both as entity-a and entity-b)"
  
  (let ((all-relationships (hash-map->list (lambda (k v) v) *relationship-store*)))
    (filter (lambda (r)
              (or (equal? (relationship-entity-a-id r) entity-id)
                  (equal? (relationship-entity-b-id r) entity-id)))
            all-relationships)))

(define (get-entity-relationships-by-type entity-id relationship-type)
  "Get all relationships of specific type for an entity.
   
   Parameters:
   - entity-id: Entity identifier
   - relationship-type: Type of relationship
   
   Returns: List of relationships of specified type"
  
  (let ((entity-relationships (get-entity-relationships entity-id)))
    (filter (lambda (r)
              (equal? (relationship-type r) relationship-type))
            entity-relationships)))

;;;
;;; HELPER FUNCTIONS
;;;

(define (get-relationship-category relationship-type)
  "Get category for relationship type.
   
   Parameters:
   - relationship-type: Type of relationship
   
   Returns: Relationship category"
  
  (let ((type-entry (assoc relationship-type relationship-types)))
    (if type-entry
        (cdr type-entry)
        'unknown)))

(define (validate-relationship-type relationship-type)
  "Validate relationship type.
   
   Parameters:
   - relationship-type: Type of relationship
   
   Returns: #t if valid, #f otherwise"
  
  (if (assoc relationship-type relationship-types)
      #t
      #f))

(define (relationship-active-during? relationship start-time end-time)
  "Check if relationship was active during time period.
   
   Parameters:
   - relationship: Relationship record
   - start-time: Period start time
   - end-time: Period end time
   
   Returns: #t if active during period, #f otherwise"
  
  (let ((rel-start (relationship-start-date relationship))
        (rel-end (relationship-end-date relationship)))
    (and (<= rel-start end-time)
         (or (not rel-end)
             (>= rel-end start-time)))))

(define (merge-attributes old-attrs new-attrs)
  "Merge old and new attribute lists.
   
   Parameters:
   - old-attrs: Existing attributes
   - new-attrs: New attributes to merge
   
   Returns: Merged attribute list"
  
  (fold (lambda (new-attr result)
          (assoc-set! result (car new-attr) (cdr new-attr)))
        old-attrs
        new-attrs))

(define (merge-evidence old-evidence new-evidence)
  "Merge old and new evidence lists.
   
   Parameters:
   - old-evidence: Existing evidence
   - new-evidence: New evidence to merge
   
   Returns: Merged evidence list"
  
  (append old-evidence new-evidence))

(define (apply-relationship-filters relationship filters)
  "Apply filters to relationship.
   
   Parameters:
   - relationship: Relationship to filter
   - filters: Association list of filter criteria
   
   Returns: #t if relationship matches all filters, #f otherwise"
  
  (every (lambda (filter)
           (let ((key (car filter))
                 (value (cdr filter)))
             (cond
               ((equal? key 'entity-a-id) 
                (equal? (relationship-entity-a-id relationship) value))
               ((equal? key 'entity-b-id) 
                (equal? (relationship-entity-b-id relationship) value))
               ((equal? key 'relationship-type) 
                (equal? (relationship-type relationship) value))
               ((equal? key 'relationship-category) 
                (equal? (relationship-category relationship) value))
               ((equal? key 'state) 
                (equal? (relationship-state relationship) value))
               (else #t))))
         filters))

(define (generate-id prefix)
  "Generate unique ID with prefix.
   
   Parameters:
   - prefix: ID prefix
   
   Returns: Unique ID string"
  
  (string-append prefix "-" (number->string (current-timestamp))))

(define (current-timestamp)
  "Get current timestamp.
   
   Returns: Current timestamp (placeholder implementation)"
  
  ;; Placeholder - replace with actual timestamp implementation
  (get-internal-real-time))

(define (assoc-ref alist key . default)
  "Get value from association list with optional default.
   
   Parameters:
   - alist: Association list
   - key: Key to look up
   - default: Default value if key not found
   
   Returns: Value or default"
  
  (let ((pair (assoc key alist)))
    (if pair
        (cdr pair)
        (if (null? default) #f (car default)))))

(define (assoc-set! alist key value)
  "Set value in association list (functional, returns new list).
   
   Parameters:
   - alist: Association list
   - key: Key to set
   - value: Value to set
   
   Returns: New association list"
  
  (cons (cons key value)
        (filter (lambda (pair) (not (equal? (car pair) key))) alist)))

;;;
;;; EXAMPLE USAGE
;;;

;; Example: Create ownership relationship
;; (define daniel-rst-ownership 
;;   (create-relationship 
;;     "daniel-faucitt" 
;;     "rst-pty-ltd"
;;     'shareholder
;;     '((entity-a-role . "shareholder")
;;       (entity-b-role . "company")
;;       (ownership-percentage . 50)
;;       (start-date . "2010-01-01")
;;       (confidence . 0.98)
;;       (evidence . ("CIPC registration" "Share certificates")))))

;; Example: Update relationship to active
;; (update-relationship 
;;   (relationship-id daniel-rst-ownership)
;;   '((state . active))
;;   "system"
;;   "Verified ownership documentation")

;; Example: Query relationships by type
;; (query-relationships '((relationship-type . shareholder)))

;; Example: Get entity relationships
;; (get-entity-relationships "daniel-faucitt")

;; Example: Query relationship at specific time
;; (query-relationship-at-time 
;;   (relationship-id daniel-rst-ownership)
;;   "2025-06-01")
