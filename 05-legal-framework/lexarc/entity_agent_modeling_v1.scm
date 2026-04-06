;;; entity_agent_modeling_v1.scm
;;; Entity Agent Modeling System for Multi-Agent Entity-Relation Framework
;;; Date: 2025-12-19
;;; Purpose: Model entities (natural and juristic persons) as autonomous agents

(define-module (lex entity-agent-modeling-v1)
  #:use-module (srfi srfi-9)
  #:use-module (srfi srfi-1)
  #:export (
    ;; Entity record types
    <entity>
    <natural-person-entity>
    <juristic-person-entity>
    <agent-state>
    <agent-capability>
    <agent-constraint>
    <behavioral-pattern>
    
    ;; Entity constructors
    make-entity
    make-natural-person-entity
    make-juristic-person-entity
    make-agent-state
    make-agent-capability
    make-agent-constraint
    make-behavioral-pattern
    
    ;; Entity accessors
    entity-id
    entity-type
    entity-attributes
    entity-agent-model
    entity-relationships
    entity-version
    entity-created-at
    entity-updated-at
    
    ;; Entity operations
    create-entity
    get-entity
    update-entity
    delete-entity
    query-entities
    
    ;; Agent model operations
    get-agent-state
    update-agent-state
    get-agent-capabilities
    add-agent-capability
    remove-agent-capability
    get-agent-constraints
    add-agent-constraint
    remove-agent-constraint
    get-behavioral-patterns
    add-behavioral-pattern
    
    ;; Natural person specific
    natural-person-roles
    natural-person-professional-qualifications
    natural-person-expertise-areas
    
    ;; Juristic person specific
    juristic-person-directors
    juristic-person-shareholders
    juristic-person-business-activities
    juristic-person-operational-status
  ))

;;;
;;; ENTITY RECORD TYPES
;;;

(define-record-type <entity>
  (make-entity-internal 
    entity-id 
    entity-type 
    attributes 
    agent-model 
    relationships 
    version 
    created-at 
    updated-at)
  entity?
  (entity-id entity-id)
  (entity-type entity-type)
  (attributes entity-attributes set-entity-attributes!)
  (agent-model entity-agent-model set-entity-agent-model!)
  (relationships entity-relationships set-entity-relationships!)
  (version entity-version set-entity-version!)
  (created-at entity-created-at)
  (updated-at entity-updated-at set-entity-updated-at!))

(define-record-type <natural-person-entity>
  (make-natural-person-entity-internal
    base-entity
    full-name
    known-aliases
    date-of-birth
    nationality
    id-number
    roles
    role-history
    professional-qualifications
    expertise-areas)
  natural-person-entity?
  (base-entity natural-person-base-entity)
  (full-name natural-person-full-name set-natural-person-full-name!)
  (known-aliases natural-person-known-aliases set-natural-person-known-aliases!)
  (date-of-birth natural-person-date-of-birth set-natural-person-date-of-birth!)
  (nationality natural-person-nationality set-natural-person-nationality!)
  (id-number natural-person-id-number set-natural-person-id-number!)
  (roles natural-person-roles set-natural-person-roles!)
  (role-history natural-person-role-history set-natural-person-role-history!)
  (professional-qualifications natural-person-professional-qualifications set-natural-person-professional-qualifications!)
  (expertise-areas natural-person-expertise-areas set-natural-person-expertise-areas!))

(define-record-type <juristic-person-entity>
  (make-juristic-person-entity-internal
    base-entity
    legal-name
    registration-number
    registration-date
    jurisdiction
    entity-subtype
    ownership-structure
    governance-structure
    directors
    shareholders
    trustees
    beneficiaries
    business-activities
    operational-status
    revenue-streams
    asset-base
    employee-count)
  juristic-person-entity?
  (base-entity juristic-person-base-entity)
  (legal-name juristic-person-legal-name set-juristic-person-legal-name!)
  (registration-number juristic-person-registration-number set-juristic-person-registration-number!)
  (registration-date juristic-person-registration-date set-juristic-person-registration-date!)
  (jurisdiction juristic-person-jurisdiction set-juristic-person-jurisdiction!)
  (entity-subtype juristic-person-entity-subtype set-juristic-person-entity-subtype!)
  (ownership-structure juristic-person-ownership-structure set-juristic-person-ownership-structure!)
  (governance-structure juristic-person-governance-structure set-juristic-person-governance-structure!)
  (directors juristic-person-directors set-juristic-person-directors!)
  (shareholders juristic-person-shareholders set-juristic-person-shareholders!)
  (trustees juristic-person-trustees set-juristic-person-trustees!)
  (beneficiaries juristic-person-beneficiaries set-juristic-person-beneficiaries!)
  (business-activities juristic-person-business-activities set-juristic-person-business-activities!)
  (operational-status juristic-person-operational-status set-juristic-person-operational-status!)
  (revenue-streams juristic-person-revenue-streams set-juristic-person-revenue-streams!)
  (asset-base juristic-person-asset-base set-juristic-person-asset-base!)
  (employee-count juristic-person-employee-count set-juristic-person-employee-count!))

;;;
;;; AGENT MODEL RECORD TYPES
;;;

(define-record-type <agent-state>
  (make-agent-state-internal
    entity-id
    timestamp
    attributes
    capabilities
    constraints
    behavioral-patterns)
  agent-state?
  (entity-id agent-state-entity-id)
  (timestamp agent-state-timestamp)
  (attributes agent-state-attributes set-agent-state-attributes!)
  (capabilities agent-state-capabilities set-agent-state-capabilities!)
  (constraints agent-state-constraints set-agent-state-constraints!)
  (behavioral-patterns agent-state-behavioral-patterns set-agent-state-behavioral-patterns!))

(define-record-type <agent-capability>
  (make-agent-capability-internal
    capability-id
    capability-type
    capability-name
    description
    confidence
    evidence-basis)
  agent-capability?
  (capability-id agent-capability-id)
  (capability-type agent-capability-type)
  (capability-name agent-capability-name)
  (description agent-capability-description)
  (confidence agent-capability-confidence set-agent-capability-confidence!)
  (evidence-basis agent-capability-evidence-basis set-agent-capability-evidence-basis!))

(define-record-type <agent-constraint>
  (make-agent-constraint-internal
    constraint-id
    constraint-type
    constraint-name
    description
    severity
    impact)
  agent-constraint?
  (constraint-id agent-constraint-id)
  (constraint-type agent-constraint-type)
  (constraint-name agent-constraint-name)
  (description agent-constraint-description)
  (severity agent-constraint-severity set-agent-constraint-severity!)
  (impact agent-constraint-impact set-agent-constraint-impact!))

(define-record-type <behavioral-pattern>
  (make-behavioral-pattern-internal
    pattern-id
    pattern-type
    pattern-name
    description
    frequency
    confidence
    evidence)
  behavioral-pattern?
  (pattern-id behavioral-pattern-id)
  (pattern-type behavioral-pattern-type)
  (pattern-name behavioral-pattern-name)
  (description behavioral-pattern-description)
  (frequency behavioral-pattern-frequency set-behavioral-pattern-frequency!)
  (confidence behavioral-pattern-confidence set-behavioral-pattern-confidence!)
  (evidence behavioral-pattern-evidence set-behavioral-pattern-evidence!))

;;;
;;; ENTITY STORAGE (in-memory for now, can be replaced with database)
;;;

(define *entity-store* (make-hash-table))

;;;
;;; ENTITY CONSTRUCTORS
;;;

(define (make-entity entity-id entity-type attributes)
  "Create a new entity.
   
   Parameters:
   - entity-id: Unique identifier
   - entity-type: 'natural-person' or 'juristic-person'
   - attributes: Association list of attributes
   
   Returns: Entity record"
  
  (let ((timestamp (current-time)))
    (make-entity-internal
      entity-id
      entity-type
      attributes
      (make-default-agent-model entity-type)
      '()  ; relationships
      1    ; version
      timestamp
      timestamp)))

(define (make-natural-person-entity entity-id full-name attributes)
  "Create a new natural person entity.
   
   Parameters:
   - entity-id: Unique identifier
   - full-name: Full legal name
   - attributes: Association list of additional attributes
   
   Returns: Natural person entity record"
  
  (let ((base-entity (make-entity entity-id "natural-person" attributes)))
    (make-natural-person-entity-internal
      base-entity
      full-name
      (assoc-ref attributes 'known-aliases '())
      (assoc-ref attributes 'date-of-birth #f)
      (assoc-ref attributes 'nationality #f)
      (assoc-ref attributes 'id-number #f)
      (assoc-ref attributes 'roles '())
      (assoc-ref attributes 'role-history '())
      (assoc-ref attributes 'professional-qualifications '())
      (assoc-ref attributes 'expertise-areas '()))))

(define (make-juristic-person-entity entity-id legal-name entity-subtype attributes)
  "Create a new juristic person entity.
   
   Parameters:
   - entity-id: Unique identifier
   - legal-name: Full legal name
   - entity-subtype: 'company', 'trust', 'partnership', etc.
   - attributes: Association list of additional attributes
   
   Returns: Juristic person entity record"
  
  (let ((base-entity (make-entity entity-id "juristic-person" attributes)))
    (make-juristic-person-entity-internal
      base-entity
      legal-name
      (assoc-ref attributes 'registration-number #f)
      (assoc-ref attributes 'registration-date #f)
      (assoc-ref attributes 'jurisdiction #f)
      entity-subtype
      (assoc-ref attributes 'ownership-structure '())
      (assoc-ref attributes 'governance-structure '())
      (assoc-ref attributes 'directors '())
      (assoc-ref attributes 'shareholders '())
      (assoc-ref attributes 'trustees '())
      (assoc-ref attributes 'beneficiaries '())
      (assoc-ref attributes 'business-activities '())
      (assoc-ref attributes 'operational-status "active")
      (assoc-ref attributes 'revenue-streams '())
      (assoc-ref attributes 'asset-base '())
      (assoc-ref attributes 'employee-count 0))))

(define (make-agent-state entity-id)
  "Create a new agent state.
   
   Parameters:
   - entity-id: Entity identifier
   
   Returns: Agent state record"
  
  (make-agent-state-internal
    entity-id
    (current-time)
    '()  ; attributes
    '()  ; capabilities
    '()  ; constraints
    '())) ; behavioral-patterns

(define (make-agent-capability capability-type capability-name description confidence)
  "Create a new agent capability.
   
   Parameters:
   - capability-type: Type of capability
   - capability-name: Name of capability
   - description: Description of capability
   - confidence: Confidence score (0.0-1.0)
   
   Returns: Agent capability record"
  
  (make-agent-capability-internal
    (generate-id "capability")
    capability-type
    capability-name
    description
    confidence
    '())) ; evidence-basis

(define (make-agent-constraint constraint-type constraint-name description severity)
  "Create a new agent constraint.
   
   Parameters:
   - constraint-type: Type of constraint
   - constraint-name: Name of constraint
   - description: Description of constraint
   - severity: Severity level ('low', 'medium', 'high', 'critical')
   
   Returns: Agent constraint record"
  
  (make-agent-constraint-internal
    (generate-id "constraint")
    constraint-type
    constraint-name
    description
    severity
    '())) ; impact

(define (make-behavioral-pattern pattern-type pattern-name description frequency confidence)
  "Create a new behavioral pattern.
   
   Parameters:
   - pattern-type: Type of pattern
   - pattern-name: Name of pattern
   - description: Description of pattern
   - frequency: Frequency of pattern ('rare', 'occasional', 'frequent', 'constant')
   - confidence: Confidence score (0.0-1.0)
   
   Returns: Behavioral pattern record"
  
  (make-behavioral-pattern-internal
    (generate-id "pattern")
    pattern-type
    pattern-name
    description
    frequency
    confidence
    '())) ; evidence

;;;
;;; ENTITY OPERATIONS
;;;

(define (create-entity entity-id entity-type attributes)
  "Create and store a new entity.
   
   Parameters:
   - entity-id: Unique identifier
   - entity-type: 'natural-person' or 'juristic-person'
   - attributes: Association list of attributes
   
   Returns: Created entity"
  
  (let ((entity (make-entity entity-id entity-type attributes)))
    (hash-set! *entity-store* entity-id entity)
    entity))

(define (get-entity entity-id)
  "Retrieve entity by ID.
   
   Parameters:
   - entity-id: Entity identifier
   
   Returns: Entity or #f if not found"
  
  (hash-ref *entity-store* entity-id #f))

(define (update-entity entity-id attributes)
  "Update entity attributes (creates new version).
   
   Parameters:
   - entity-id: Entity identifier
   - attributes: New or updated attributes
   
   Returns: Updated entity"
  
  (let ((entity (get-entity entity-id)))
    (if entity
        (begin
          (set-entity-attributes! entity 
            (merge-attributes (entity-attributes entity) attributes))
          (set-entity-version! entity (+ (entity-version entity) 1))
          (set-entity-updated-at! entity (current-time))
          entity)
        #f)))

(define (delete-entity entity-id)
  "Delete entity from store.
   
   Parameters:
   - entity-id: Entity identifier
   
   Returns: #t if deleted, #f if not found"
  
  (if (hash-ref *entity-store* entity-id #f)
      (begin
        (hash-remove! *entity-store* entity-id)
        #t)
      #f))

(define (query-entities filters)
  "Query entities with filters.
   
   Parameters:
   - filters: Association list of filter criteria
   
   Returns: List of matching entities"
  
  (let ((all-entities (hash-map->list (lambda (k v) v) *entity-store*)))
    (filter (lambda (entity)
              (apply-filters entity filters))
            all-entities)))

;;;
;;; AGENT MODEL OPERATIONS
;;;

(define (get-agent-state entity-id)
  "Get current agent state for entity.
   
   Parameters:
   - entity-id: Entity identifier
   
   Returns: Agent state"
  
  (let ((entity (get-entity entity-id)))
    (if entity
        (assoc-ref (entity-agent-model entity) 'state)
        #f)))

(define (update-agent-state entity-id new-state)
  "Update agent state for entity.
   
   Parameters:
   - entity-id: Entity identifier
   - new-state: New agent state
   
   Returns: Updated entity"
  
  (let ((entity (get-entity entity-id)))
    (if entity
        (begin
          (set-entity-agent-model! entity
            (assoc-set! (entity-agent-model entity) 'state new-state))
          (set-entity-updated-at! entity (current-time))
          entity)
        #f)))

(define (get-agent-capabilities entity-id)
  "Get agent capabilities for entity.
   
   Parameters:
   - entity-id: Entity identifier
   
   Returns: List of agent capabilities"
  
  (let ((entity (get-entity entity-id)))
    (if entity
        (assoc-ref (entity-agent-model entity) 'capabilities '())
        '())))

(define (add-agent-capability entity-id capability)
  "Add capability to entity's agent model.
   
   Parameters:
   - entity-id: Entity identifier
   - capability: Agent capability record
   
   Returns: Updated entity"
  
  (let* ((entity (get-entity entity-id))
         (capabilities (get-agent-capabilities entity-id)))
    (if entity
        (begin
          (set-entity-agent-model! entity
            (assoc-set! (entity-agent-model entity) 
                       'capabilities 
                       (cons capability capabilities)))
          (set-entity-updated-at! entity (current-time))
          entity)
        #f)))

(define (remove-agent-capability entity-id capability-id)
  "Remove capability from entity's agent model.
   
   Parameters:
   - entity-id: Entity identifier
   - capability-id: Capability identifier to remove
   
   Returns: Updated entity"
  
  (let* ((entity (get-entity entity-id))
         (capabilities (get-agent-capabilities entity-id))
         (filtered-capabilities 
           (filter (lambda (c) 
                     (not (equal? (agent-capability-id c) capability-id)))
                   capabilities)))
    (if entity
        (begin
          (set-entity-agent-model! entity
            (assoc-set! (entity-agent-model entity) 
                       'capabilities 
                       filtered-capabilities))
          (set-entity-updated-at! entity (current-time))
          entity)
        #f)))

(define (get-agent-constraints entity-id)
  "Get agent constraints for entity.
   
   Parameters:
   - entity-id: Entity identifier
   
   Returns: List of agent constraints"
  
  (let ((entity (get-entity entity-id)))
    (if entity
        (assoc-ref (entity-agent-model entity) 'constraints '())
        '())))

(define (add-agent-constraint entity-id constraint)
  "Add constraint to entity's agent model.
   
   Parameters:
   - entity-id: Entity identifier
   - constraint: Agent constraint record
   
   Returns: Updated entity"
  
  (let* ((entity (get-entity entity-id))
         (constraints (get-agent-constraints entity-id)))
    (if entity
        (begin
          (set-entity-agent-model! entity
            (assoc-set! (entity-agent-model entity) 
                       'constraints 
                       (cons constraint constraints)))
          (set-entity-updated-at! entity (current-time))
          entity)
        #f)))

(define (remove-agent-constraint entity-id constraint-id)
  "Remove constraint from entity's agent model.
   
   Parameters:
   - entity-id: Entity identifier
   - constraint-id: Constraint identifier to remove
   
   Returns: Updated entity"
  
  (let* ((entity (get-entity entity-id))
         (constraints (get-agent-constraints entity-id))
         (filtered-constraints 
           (filter (lambda (c) 
                     (not (equal? (agent-constraint-id c) constraint-id)))
                   constraints)))
    (if entity
        (begin
          (set-entity-agent-model! entity
            (assoc-set! (entity-agent-model entity) 
                       'constraints 
                       filtered-constraints))
          (set-entity-updated-at! entity (current-time))
          entity)
        #f)))

(define (get-behavioral-patterns entity-id)
  "Get behavioral patterns for entity.
   
   Parameters:
   - entity-id: Entity identifier
   
   Returns: List of behavioral patterns"
  
  (let ((entity (get-entity entity-id)))
    (if entity
        (assoc-ref (entity-agent-model entity) 'behavioral-patterns '())
        '())))

(define (add-behavioral-pattern entity-id pattern)
  "Add behavioral pattern to entity's agent model.
   
   Parameters:
   - entity-id: Entity identifier
   - pattern: Behavioral pattern record
   
   Returns: Updated entity"
  
  (let* ((entity (get-entity entity-id))
         (patterns (get-behavioral-patterns entity-id)))
    (if entity
        (begin
          (set-entity-agent-model! entity
            (assoc-set! (entity-agent-model entity) 
                       'behavioral-patterns 
                       (cons pattern patterns)))
          (set-entity-updated-at! entity (current-time))
          entity)
        #f)))

;;;
;;; HELPER FUNCTIONS
;;;

(define (make-default-agent-model entity-type)
  "Create default agent model for entity type.
   
   Parameters:
   - entity-type: 'natural-person' or 'juristic-person'
   
   Returns: Default agent model"
  
  `((state . ,(make-agent-state "default"))
    (capabilities . ())
    (constraints . ())
    (behavioral-patterns . ())))

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

(define (apply-filters entity filters)
  "Apply filters to entity.
   
   Parameters:
   - entity: Entity to filter
   - filters: Association list of filter criteria
   
   Returns: #t if entity matches all filters, #f otherwise"
  
  (every (lambda (filter)
           (let ((key (car filter))
                 (value (cdr filter)))
             (equal? (assoc-ref (entity-attributes entity) key) value)))
         filters))

(define (generate-id prefix)
  "Generate unique ID with prefix.
   
   Parameters:
   - prefix: ID prefix
   
   Returns: Unique ID string"
  
  (string-append prefix "-" (number->string (current-time))))

(define (current-time)
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

;; Example: Create natural person entity
;; (define daniel (create-entity 
;;   "daniel-faucitt" 
;;   "natural-person"
;;   '((full-name . "Daniel Faucitt")
;;     (roles . ("director" "cio" "eu-responsible-person"))
;;     (professional-qualifications . ("CIO"))
;;     (expertise-areas . ("technical" "regulatory-compliance")))))

;; Example: Add capability to entity
;; (add-agent-capability 
;;   "daniel-faucitt"
;;   (make-agent-capability 
;;     "technical-expertise" 
;;     "Technical Decision Making"
;;     "Can make technical infrastructure decisions"
;;     0.98))

;; Example: Query entities by type
;; (query-entities '((entity-type . "natural-person")))
