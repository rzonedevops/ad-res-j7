;; =============================================================================
;; CHAINLEX CORE UTILITIES
;; =============================================================================
;; Version: 1.0
;; Description: Foundational helper functions for all legal frameworks
;; Level: 0 (Infrastructure)
;;
;; This module provides the core data structure operations and utility functions
;; used by all Level 1 principles and Level 2+ jurisdiction-specific rules.
;; =============================================================================

(define-module (chainlex core-utilities)
  #:export (
    ;; Data structure operations
    has-attribute
    get-attribute
    set-attribute
    has-right
    get-right
    
    ;; Entity operations
    entity-type
    entity-id
    create-entity
    
    ;; List and set operations
    member-of?
    subset-of?
    intersection
    union
    
    ;; Temporal operations
    current-date
    date-diff
    within-time-period?
    date-before?
    date-after?
    
    ;; Logical operations
    all-true?
    any-true?
    none-true?
    
    ;; Comparison operations
    value-equals?
    value-greater?
    value-less?
    
    ;; String operations
    string-contains?
    string-matches?
    
    ;; Numeric operations
    within-range?
    percentage-of
    
    ;; Legal-specific operations
    applies-to-jurisdiction?
    applies-to-domain?
    get-confidence
    compute-inference
  ))

;; =============================================================================
;; DATA STRUCTURE OPERATIONS
;; =============================================================================

(define (has-attribute entity attribute-name)
  "Check if an entity has a specific attribute"
  (cond
    ;; Handle association list (alist)
    ((list? entity)
     (assoc attribute-name entity))
    ;; Handle hash table
    ((hash-table? entity)
     (hash-table-exists? entity attribute-name))
    ;; Handle record/struct (if available)
    (else #f)))

(define (get-attribute entity attribute-name . default)
  "Get the value of an attribute from an entity"
  (let ((default-value (if (null? default) #f (car default))))
    (cond
      ;; Handle association list
      ((list? entity)
       (let ((pair (assoc attribute-name entity)))
         (if pair (cdr pair) default-value)))
      ;; Handle hash table
      ((hash-table? entity)
       (hash-table-ref entity attribute-name default-value))
      (else default-value))))

(define (set-attribute entity attribute-name value)
  "Set an attribute value on an entity (returns new entity)"
  (cond
    ;; Handle association list
    ((list? entity)
     (cons (cons attribute-name value)
           (filter (lambda (pair) (not (equal? (car pair) attribute-name))) entity)))
    ;; Handle hash table
    ((hash-table? entity)
     (hash-table-set! entity attribute-name value)
     entity)
    (else entity)))

(define (has-right entity right-name)
  "Check if an entity has a specific right"
  (let ((rights (get-attribute entity 'rights '())))
    (member right-name rights)))

(define (get-right entity right-name)
  "Get details of a specific right"
  (let ((rights (get-attribute entity 'rights '())))
    (assoc right-name rights)))

;; =============================================================================
;; ENTITY OPERATIONS
;; =============================================================================

(define (entity-type entity)
  "Get the type of an entity"
  (get-attribute entity 'type 'unknown))

(define (entity-id entity)
  "Get the unique identifier of an entity"
  (get-attribute entity 'id #f))

(define (create-entity type attributes)
  "Create a new entity with given type and attributes"
  (cons (cons 'type type)
        (cons (cons 'id (symbol->string (gensym)))
              attributes)))

;; =============================================================================
;; LIST AND SET OPERATIONS
;; =============================================================================

(define (member-of? item collection)
  "Check if item is a member of collection"
  (cond
    ((null? collection) #f)
    ((list? collection) (member item collection))
    (else #f)))

(define (subset-of? set1 set2)
  "Check if set1 is a subset of set2"
  (cond
    ((null? set1) #t)
    ((not (member-of? (car set1) set2)) #f)
    (else (subset-of? (cdr set1) set2))))

(define (intersection set1 set2)
  "Return intersection of two sets"
  (cond
    ((null? set1) '())
    ((member-of? (car set1) set2)
     (cons (car set1) (intersection (cdr set1) set2)))
    (else (intersection (cdr set1) set2))))

(define (union set1 set2)
  "Return union of two sets"
  (cond
    ((null? set1) set2)
    ((member-of? (car set1) set2)
     (union (cdr set1) set2))
    (else (cons (car set1) (union (cdr set1) set2)))))

;; =============================================================================
;; TEMPORAL OPERATIONS
;; =============================================================================

(define (current-date)
  "Get current date as seconds since epoch"
  (current-time))

(define (date-diff date1 date2)
  "Calculate difference between two dates in days"
  (/ (abs (- date1 date2)) 86400))  ; 86400 seconds per day

(define (within-time-period? event-date start-date end-date)
  "Check if a date falls within a time period"
  (and (>= event-date start-date)
       (<= event-date end-date)))

(define (date-before? date1 date2)
  "Check if date1 is before date2"
  (< date1 date2))

(define (date-after? date1 date2)
  "Check if date1 is after date2"
  (> date1 date2))

;; =============================================================================
;; LOGICAL OPERATIONS
;; =============================================================================

(define (all-true? predicates)
  "Check if all predicates in list are true"
  (cond
    ((null? predicates) #t)
    ((not (car predicates)) #f)
    (else (all-true? (cdr predicates)))))

(define (any-true? predicates)
  "Check if any predicate in list is true"
  (cond
    ((null? predicates) #f)
    ((car predicates) #t)
    (else (any-true? (cdr predicates)))))

(define (none-true? predicates)
  "Check if no predicates in list are true"
  (not (any-true? predicates)))

;; =============================================================================
;; COMPARISON OPERATIONS
;; =============================================================================

(define (value-equals? value1 value2)
  "Check if two values are equal (handles different types)"
  (cond
    ((and (number? value1) (number? value2)) (= value1 value2))
    ((and (string? value1) (string? value2)) (string=? value1 value2))
    ((and (symbol? value1) (symbol? value2)) (eq? value1 value2))
    (else (equal? value1 value2))))

(define (value-greater? value1 value2)
  "Check if value1 > value2"
  (cond
    ((and (number? value1) (number? value2)) (> value1 value2))
    ((and (string? value1) (string? value2)) (string>? value1 value2))
    (else #f)))

(define (value-less? value1 value2)
  "Check if value1 < value2"
  (cond
    ((and (number? value1) (number? value2)) (< value1 value2))
    ((and (string? value1) (string? value2)) (string<? value1 value2))
    (else #f)))

;; =============================================================================
;; STRING OPERATIONS
;; =============================================================================

(define (string-contains? haystack needle)
  "Check if haystack contains needle"
  (if (and (string? haystack) (string? needle))
      (string-contains haystack needle)
      #f))

(define (string-matches? str pattern)
  "Check if string matches a regex pattern"
  (if (and (string? str) (string? pattern))
      (regexp-match? (regexp pattern) str)
      #f))

;; =============================================================================
;; NUMERIC OPERATIONS
;; =============================================================================

(define (within-range? value min-val max-val)
  "Check if value is within range [min, max]"
  (and (>= value min-val)
       (<= value max-val)))

(define (percentage-of value total)
  "Calculate percentage"
  (if (and (number? value) (number? total) (> total 0))
      (* (/ value total) 100)
      0))

;; =============================================================================
;; LEGAL-SPECIFIC OPERATIONS
;; =============================================================================

(define (applies-to-jurisdiction? rule jurisdiction)
  "Check if a rule applies to a specific jurisdiction"
  (let ((rule-jurisdiction (get-attribute rule 'jurisdiction 'unknown)))
    (or (equal? rule-jurisdiction jurisdiction)
        (equal? rule-jurisdiction 'universal))))

(define (applies-to-domain? rule domain)
  "Check if a rule applies to a specific legal domain"
  (let ((rule-domains (get-attribute rule 'domains '())))
    (member-of? domain rule-domains)))

(define (get-confidence entity)
  "Get confidence level of an entity or rule"
  (get-attribute entity 'confidence 1.0))

(define (compute-inference premise conclusion inference-type)
  "Compute confidence of inference from premise to conclusion"
  (let ((premise-confidence (get-confidence premise))
        (inference-factor (case inference-type
                           ((deductive) 0.95)
                           ((inductive) 0.80)
                           ((abductive) 0.70)
                           ((analogical) 0.65)
                           (else 0.50))))
    (* premise-confidence inference-factor)))

;; =============================================================================
;; HELPER CONSTRUCTORS
;; =============================================================================

(define (make-legal-entity type id attributes)
  "Create a legal entity (person, organization, etc.)"
  (create-entity type (cons (cons 'id id) attributes)))

(define (make-contract parties terms)
  "Create a contract entity"
  (create-entity 'contract
                 (list (cons 'parties parties)
                       (cons 'terms terms)
                       (cons 'status 'pending))))

(define (make-claim claimant defendant basis)
  "Create a legal claim"
  (create-entity 'claim
                 (list (cons 'claimant claimant)
                       (cons 'defendant defendant)
                       (cons 'basis basis)
                       (cons 'status 'filed))))

(define (make-right holder type scope)
  "Create a legal right"
  (create-entity 'right
                 (list (cons 'holder holder)
                       (cons 'right-type type)
                       (cons 'scope scope))))

;; =============================================================================
;; VALIDATION HELPERS
;; =============================================================================

(define (valid-date? date)
  "Check if date is valid"
  (and (number? date) (> date 0)))

(define (valid-entity? entity)
  "Check if entity is valid"
  (and entity
       (or (list? entity) (hash-table? entity))
       (has-attribute entity 'type)))

(define (valid-amount? amount)
  "Check if amount is valid"
  (and (number? amount) (>= amount 0)))

(define (valid-percentage? value)
  "Check if value is a valid percentage"
  (and (number? value) (>= value 0) (<= value 100)))

;; =============================================================================
;; END OF CORE UTILITIES
;; =============================================================================

