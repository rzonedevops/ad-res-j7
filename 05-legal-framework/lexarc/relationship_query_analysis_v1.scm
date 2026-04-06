;;; relationship_query_analysis_v1.scm
;;; Relationship Query and Analysis Tools for Multi-Agent Entity-Relation Framework
;;; Date: 2025-12-19
;;; Purpose: Sophisticated tools for querying and analyzing entity relationships

(define-module (lex relationship-query-analysis-v1)
  #:use-module (srfi srfi-9)
  #:use-module (srfi srfi-1)
  #:use-module (lex relation-tracking-temporal-v1)
  #:use-module (lex entity-agent-modeling-v1)
  #:export (
    ;; Direct relationship queries
    query-direct-relationships
    query-direct-relationships-by-category
    count-direct-relationships
    
    ;; Indirect relationship queries
    query-indirect-relationships
    find-relationship-path
    find-all-relationship-paths
    calculate-relationship-distance
    
    ;; Temporal queries
    query-relationships-at-time
    query-relationship-changes-during-period
    analyze-relationship-timeline
    
    ;; Network analysis
    analyze-relationship-network
    calculate-network-centrality
    calculate-network-density
    calculate-clustering-coefficient
    identify-network-communities
    
    ;; Pattern detection
    detect-coordination-patterns
    detect-conflict-patterns
    detect-control-patterns
    detect-influence-patterns
    
    ;; Relationship strength analysis
    calculate-relationship-strength
    calculate-relationship-impact
    rank-relationships-by-strength
    
    ;; Conflict detection
    detect-relationship-conflicts
    detect-role-conflicts
    detect-interest-conflicts
    
    ;; Visualization data generation
    generate-relationship-graph-data
    generate-relationship-timeline-data
    generate-network-analysis-data
  ))

;;;
;;; DIRECT RELATIONSHIP QUERIES
;;;

(define (query-direct-relationships entity-id)
  "Query all direct relationships for an entity.
   
   Parameters:
   - entity-id: Entity identifier
   
   Returns: List of direct relationships with both perspectives"
  
  (let ((relationships (get-entity-relationships entity-id)))
    (map (lambda (rel)
           (if (equal? (relationship-entity-a-id rel) entity-id)
               rel
               (get-inverse-relationship rel)))
         relationships)))

(define (query-direct-relationships-by-category entity-id category)
  "Query direct relationships by category.
   
   Parameters:
   - entity-id: Entity identifier
   - category: Relationship category
   
   Returns: List of relationships in specified category"
  
  (let ((relationships (query-direct-relationships entity-id)))
    (filter (lambda (rel)
              (equal? (relationship-category rel) category))
            relationships)))

(define (count-direct-relationships entity-id)
  "Count direct relationships for an entity.
   
   Parameters:
   - entity-id: Entity identifier
   
   Returns: Count of direct relationships"
  
  (length (query-direct-relationships entity-id)))

;;;
;;; INDIRECT RELATIONSHIP QUERIES
;;;

(define (query-indirect-relationships entity-id depth)
  "Query indirect relationships up to specified depth.
   
   Parameters:
   - entity-id: Entity identifier
   - depth: Maximum depth to traverse
   
   Returns: List of indirect relationships with path information"
  
  (let ((visited (make-hash-table))
        (results '()))
    (define (traverse current-id current-depth path)
      (when (<= current-depth depth)
        (hash-set! visited current-id #t)
        (let ((direct-rels (query-direct-relationships current-id)))
          (for-each
            (lambda (rel)
              (let ((next-id (if (equal? (relationship-entity-a-id rel) current-id)
                                (relationship-entity-b-id rel)
                                (relationship-entity-a-id rel))))
                (when (not (hash-ref visited next-id #f))
                  (set! results 
                    (cons `((relationship . ,rel)
                            (depth . ,current-depth)
                            (path . ,(append path (list rel))))
                          results))
                  (traverse next-id (+ current-depth 1) (append path (list rel))))))
            direct-rels))))
    (traverse entity-id 1 '())
    results))

(define (find-relationship-path entity-a-id entity-b-id max-depth)
  "Find shortest relationship path between two entities.
   
   Parameters:
   - entity-a-id: First entity identifier
   - entity-b-id: Second entity identifier
   - max-depth: Maximum path depth
   
   Returns: Shortest path or #f if no path found"
  
  (let ((paths (find-all-relationship-paths entity-a-id entity-b-id max-depth)))
    (if (null? paths)
        #f
        (car (sort paths
                   (lambda (a b)
                     (< (length (assoc-ref a 'path))
                        (length (assoc-ref b 'path)))))))))

(define (find-all-relationship-paths entity-a-id entity-b-id max-depth)
  "Find all relationship paths between two entities.
   
   Parameters:
   - entity-a-id: First entity identifier
   - entity-b-id: Second entity identifier
   - max-depth: Maximum path depth
   
   Returns: List of all paths"
  
  (let ((paths '()))
    (define (search current-id current-path current-depth visited)
      (cond
        ((equal? current-id entity-b-id)
         (set! paths (cons `((path . ,current-path)
                            (depth . ,current-depth))
                          paths)))
        ((< current-depth max-depth)
         (let ((direct-rels (query-direct-relationships current-id)))
           (for-each
             (lambda (rel)
               (let ((next-id (if (equal? (relationship-entity-a-id rel) current-id)
                                 (relationship-entity-b-id rel)
                                 (relationship-entity-a-id rel))))
                 (when (not (member next-id visited))
                   (search next-id 
                          (append current-path (list rel))
                          (+ current-depth 1)
                          (cons next-id visited)))))
             direct-rels)))))
    (search entity-a-id '() 0 (list entity-a-id))
    paths))

(define (calculate-relationship-distance entity-a-id entity-b-id)
  "Calculate shortest distance between two entities.
   
   Parameters:
   - entity-a-id: First entity identifier
   - entity-b-id: Second entity identifier
   
   Returns: Distance (number of relationships) or #f if not connected"
  
  (let ((path (find-relationship-path entity-a-id entity-b-id 10)))
    (if path
        (length (assoc-ref path 'path))
        #f)))

;;;
;;; TEMPORAL QUERIES
;;;

(define (query-relationships-at-time entity-id timestamp)
  "Query relationships active at specific time.
   
   Parameters:
   - entity-id: Entity identifier
   - timestamp: Point in time
   
   Returns: List of relationships active at specified time"
  
  (let ((all-relationships (query-direct-relationships entity-id)))
    (filter (lambda (rel)
              (and (<= (relationship-start-date rel) timestamp)
                   (or (not (relationship-end-date rel))
                       (>= (relationship-end-date rel) timestamp))))
            all-relationships)))

(define (query-relationship-changes-during-period entity-id start-time end-time)
  "Query relationship changes during time period.
   
   Parameters:
   - entity-id: Entity identifier
   - start-time: Period start time
   - end-time: Period end time
   
   Returns: List of relationship changes (created, modified, terminated)"
  
  (let ((all-relationships (query-direct-relationships entity-id))
        (changes '()))
    (for-each
      (lambda (rel)
        (let ((rel-id (relationship-id rel)))
          ;; Check for creation
          (when (and (>= (relationship-created-at rel) start-time)
                     (<= (relationship-created-at rel) end-time))
            (set! changes (cons `((type . created)
                                  (relationship . ,rel)
                                  (timestamp . ,(relationship-created-at rel)))
                               changes)))
          
          ;; Check for termination
          (when (and (relationship-end-date rel)
                     (>= (relationship-end-date rel) start-time)
                     (<= (relationship-end-date rel) end-time))
            (set! changes (cons `((type . terminated)
                                  (relationship . ,rel)
                                  (timestamp . ,(relationship-end-date rel)))
                               changes)))
          
          ;; Check for modifications
          (let ((transitions (get-relationship-state-transitions rel-id)))
            (for-each
              (lambda (transition)
                (when (and (>= (relationship-state-transition-timestamp transition) start-time)
                           (<= (relationship-state-transition-timestamp transition) end-time))
                  (set! changes (cons `((type . modified)
                                        (relationship . ,rel)
                                        (transition . ,transition)
                                        (timestamp . ,(relationship-state-transition-timestamp transition)))
                                     changes))))
              transitions))))
      all-relationships)
    (sort changes
          (lambda (a b)
            (< (assoc-ref a 'timestamp)
               (assoc-ref b 'timestamp))))))

(define (analyze-relationship-timeline entity-id)
  "Analyze complete relationship timeline for entity.
   
   Parameters:
   - entity-id: Entity identifier
   
   Returns: Timeline analysis with key events"
  
  (let* ((all-relationships (query-direct-relationships entity-id))
         (events '()))
    
    ;; Collect all timeline events
    (for-each
      (lambda (rel)
        ;; Creation event
        (set! events (cons `((type . relationship-created)
                            (relationship . ,rel)
                            (timestamp . ,(relationship-created-at rel)))
                          events))
        
        ;; Termination event
        (when (relationship-end-date rel)
          (set! events (cons `((type . relationship-terminated)
                              (relationship . ,rel)
                              (timestamp . ,(relationship-end-date rel)))
                            events)))
        
        ;; State transitions
        (let ((transitions (get-relationship-state-transitions (relationship-id rel))))
          (for-each
            (lambda (transition)
              (set! events (cons `((type . state-transition)
                                  (relationship . ,rel)
                                  (transition . ,transition)
                                  (timestamp . ,(relationship-state-transition-timestamp transition)))
                                events)))
            transitions)))
      all-relationships)
    
    ;; Sort by timestamp
    (sort events
          (lambda (a b)
            (< (assoc-ref a 'timestamp)
               (assoc-ref b 'timestamp))))))

;;;
;;; NETWORK ANALYSIS
;;;

(define (analyze-relationship-network entity-id)
  "Analyze relationship network around entity.
   
   Parameters:
   - entity-id: Entity identifier
   
   Returns: Network analysis metrics"
  
  (let* ((network-size (count-direct-relationships entity-id))
         (network-density (calculate-network-density entity-id))
         (centrality (calculate-network-centrality entity-id))
         (clustering (calculate-clustering-coefficient entity-id))
         (communities (identify-network-communities entity-id)))
    
    `((entity-id . ,entity-id)
      (network-size . ,network-size)
      (network-density . ,network-density)
      (centrality . ,centrality)
      (clustering-coefficient . ,clustering)
      (communities . ,communities))))

(define (calculate-network-centrality entity-id)
  "Calculate centrality of entity in network.
   
   Centrality measures importance based on number and strength of connections.
   
   Parameters:
   - entity-id: Entity identifier
   
   Returns: Centrality score (0.0-1.0)"
  
  (let* ((direct-count (count-direct-relationships entity-id))
         (indirect-rels (query-indirect-relationships entity-id 2))
         (indirect-count (length indirect-rels))
         (total-connections (+ direct-count (* 0.5 indirect-count))))
    
    ;; Normalize to 0.0-1.0 range (assuming max 50 total connections)
    (min 1.0 (/ total-connections 50))))

(define (calculate-network-density entity-id)
  "Calculate density of entity's network.
   
   Density measures how interconnected the entity's connections are.
   
   Parameters:
   - entity-id: Entity identifier
   
   Returns: Density score (0.0-1.0)"
  
  (let* ((direct-rels (query-direct-relationships entity-id))
         (connected-entities (map (lambda (rel)
                                    (if (equal? (relationship-entity-a-id rel) entity-id)
                                        (relationship-entity-b-id rel)
                                        (relationship-entity-a-id rel)))
                                 direct-rels))
         (n (length connected-entities)))
    
    (if (< n 2)
        0.0
        (let ((actual-connections 0)
              (possible-connections (/ (* n (- n 1)) 2)))
          ;; Count connections between connected entities
          (for-each
            (lambda (entity-a)
              (for-each
                (lambda (entity-b)
                  (when (and (not (equal? entity-a entity-b))
                             (find-relationship-path entity-a entity-b 1))
                    (set! actual-connections (+ actual-connections 1))))
                connected-entities))
            connected-entities)
          
          ;; Calculate density
          (/ actual-connections possible-connections)))))

(define (calculate-clustering-coefficient entity-id)
  "Calculate clustering coefficient for entity.
   
   Clustering coefficient measures tendency to form clusters.
   
   Parameters:
   - entity-id: Entity identifier
   
   Returns: Clustering coefficient (0.0-1.0)"
  
  (let* ((direct-rels (query-direct-relationships entity-id))
         (neighbors (map (lambda (rel)
                          (if (equal? (relationship-entity-a-id rel) entity-id)
                              (relationship-entity-b-id rel)
                              (relationship-entity-a-id rel)))
                        direct-rels))
         (k (length neighbors)))
    
    (if (< k 2)
        0.0
        (let ((triangle-count 0))
          ;; Count triangles
          (for-each
            (lambda (neighbor-a)
              (for-each
                (lambda (neighbor-b)
                  (when (and (not (equal? neighbor-a neighbor-b))
                             (find-relationship-path neighbor-a neighbor-b 1))
                    (set! triangle-count (+ triangle-count 1))))
                neighbors))
            neighbors)
          
          ;; Calculate clustering coefficient
          (/ triangle-count (* k (- k 1)))))))

(define (identify-network-communities entity-id)
  "Identify communities in entity's network.
   
   Parameters:
   - entity-id: Entity identifier
   
   Returns: List of identified communities"
  
  (let* ((direct-rels (query-direct-relationships entity-id))
         (communities '()))
    
    ;; Group by relationship category
    (for-each
      (lambda (category)
        (let ((category-rels (filter (lambda (rel)
                                       (equal? (relationship-category rel) category))
                                    direct-rels)))
          (when (not (null? category-rels))
            (set! communities 
              (cons `((category . ,category)
                      (size . ,(length category-rels))
                      (members . ,(map (lambda (rel)
                                        (if (equal? (relationship-entity-a-id rel) entity-id)
                                            (relationship-entity-b-id rel)
                                            (relationship-entity-a-id rel)))
                                      category-rels)))
                    communities)))))
      relationship-categories)
    
    communities))

;;;
;;; PATTERN DETECTION
;;;

(define (detect-coordination-patterns entity-id)
  "Detect coordination patterns in entity's relationships.
   
   Parameters:
   - entity-id: Entity identifier
   
   Returns: List of detected coordination patterns"
  
  (let* ((coordination-rels (query-direct-relationships-by-category entity-id 'coordination))
         (patterns '()))
    
    (for-each
      (lambda (rel)
        (let* ((other-entity (if (equal? (relationship-entity-a-id rel) entity-id)
                                (relationship-entity-b-id rel)
                                (relationship-entity-a-id rel)))
               (coordination-strength (assoc-ref (relationship-attributes rel) 'coordination-strength 0.0)))
          (when (> coordination-strength 0.80)
            (set! patterns 
              (cons `((type . coordination)
                      (entities . (,entity-id ,other-entity))
                      (strength . ,coordination-strength)
                      (relationship . ,rel))
                    patterns)))))
      coordination-rels)
    
    patterns))

(define (detect-conflict-patterns entity-id)
  "Detect conflict patterns in entity's relationships.
   
   Parameters:
   - entity-id: Entity identifier
   
   Returns: List of detected conflict patterns"
  
  (let* ((adversarial-rels (query-direct-relationships-by-category entity-id 'adversarial))
         (patterns '()))
    
    (for-each
      (lambda (rel)
        (let* ((other-entity (if (equal? (relationship-entity-a-id rel) entity-id)
                                (relationship-entity-b-id rel)
                                (relationship-entity-a-id rel)))
               (conflict-intensity (assoc-ref (relationship-attributes rel) 'conflict-intensity 0.0)))
          (when (> conflict-intensity 0.70)
            (set! patterns 
              (cons `((type . conflict)
                      (entities . (,entity-id ,other-entity))
                      (intensity . ,conflict-intensity)
                      (relationship . ,rel))
                    patterns)))))
      adversarial-rels)
    
    patterns))

(define (detect-control-patterns entity-id)
  "Detect control patterns in entity's relationships.
   
   Parameters:
   - entity-id: Entity identifier
   
   Returns: List of detected control patterns"
  
  (let* ((fiduciary-rels (query-direct-relationships-by-category entity-id 'fiduciary))
         (ownership-rels (query-direct-relationships-by-category entity-id 'ownership))
         (patterns '()))
    
    ;; Analyze fiduciary relationships for control
    (for-each
      (lambda (rel)
        (when (member (relationship-type rel) '(trustee-trust director-company))
          (set! patterns 
            (cons `((type . fiduciary-control)
                    (controller . ,entity-id)
                    (controlled . ,(if (equal? (relationship-entity-a-id rel) entity-id)
                                      (relationship-entity-b-id rel)
                                      (relationship-entity-a-id rel)))
                    (relationship . ,rel))
                  patterns))))
      fiduciary-rels)
    
    ;; Analyze ownership relationships for control
    (for-each
      (lambda (rel)
        (let ((ownership-pct (assoc-ref (relationship-attributes rel) 'ownership-percentage 0)))
          (when (>= ownership-pct 50)
            (set! patterns 
              (cons `((type . ownership-control)
                      (controller . ,entity-id)
                      (controlled . ,(if (equal? (relationship-entity-a-id rel) entity-id)
                                        (relationship-entity-b-id rel)
                                        (relationship-entity-a-id rel)))
                      (ownership-percentage . ,ownership-pct)
                      (relationship . ,rel))
                    patterns)))))
      ownership-rels)
    
    patterns))

(define (detect-influence-patterns entity-id)
  "Detect influence patterns in entity's relationships.
   
   Parameters:
   - entity-id: Entity identifier
   
   Returns: List of detected influence patterns"
  
  (let* ((indirect-rels (query-indirect-relationships entity-id 2))
         (patterns '()))
    
    ;; Analyze indirect control through intermediaries
    (for-each
      (lambda (indirect-rel)
        (let* ((path (assoc-ref indirect-rel 'path))
               (depth (assoc-ref indirect-rel 'depth)))
          (when (and (= depth 2)
                     (every (lambda (rel)
                              (or (equal? (relationship-category rel) 'fiduciary)
                                  (equal? (relationship-category rel) 'ownership)))
                            path))
            (set! patterns 
              (cons `((type . indirect-influence)
                      (influencer . ,entity-id)
                      (influenced . ,(relationship-entity-b-id (car (reverse path))))
                      (path . ,path))
                    patterns)))))
      indirect-rels)
    
    patterns))

;;;
;;; RELATIONSHIP STRENGTH ANALYSIS
;;;

(define (calculate-relationship-strength relationship)
  "Calculate overall strength of relationship.
   
   Factors:
   - Duration
   - Evidence strength
   - Confidence score
   - Operational impact
   
   Parameters:
   - relationship: Relationship record
   
   Returns: Strength score (0.0-1.0)"
  
  (let* ((duration (calculate-duration-score relationship))
         (evidence (relationship-confidence relationship))
         (impact (calculate-impact-score relationship))
         (weights '((duration . 0.3) (evidence . 0.4) (impact . 0.3))))
    
    (+ (* (assoc-ref weights 'duration) duration)
       (* (assoc-ref weights 'evidence) evidence)
       (* (assoc-ref weights 'impact) impact))))

(define (calculate-duration-score relationship)
  "Calculate duration score for relationship.
   
   Parameters:
   - relationship: Relationship record
   
   Returns: Duration score (0.0-1.0)"
  
  (let* ((start (relationship-start-date relationship))
         (end (or (relationship-end-date relationship) (current-timestamp)))
         (duration (- end start))
         (years (/ duration (* 365 24 60 60))))
    
    ;; Score based on years (max at 10 years)
    (min 1.0 (/ years 10))))

(define (calculate-impact-score relationship)
  "Calculate impact score for relationship.
   
   Parameters:
   - relationship: Relationship record
   
   Returns: Impact score (0.0-1.0)"
  
  (let ((operational-impact (assoc-ref (relationship-attributes relationship) 'operational-impact 0.5))
        (financial-impact (assoc-ref (relationship-attributes relationship) 'financial-impact 0.5)))
    
    ;; Average of operational and financial impact
    (/ (+ operational-impact financial-impact) 2)))

(define (rank-relationships-by-strength relationships)
  "Rank relationships by strength.
   
   Parameters:
   - relationships: List of relationships
   
   Returns: Sorted list of relationships with strength scores"
  
  (let ((scored-relationships 
          (map (lambda (rel)
                 `((relationship . ,rel)
                   (strength . ,(calculate-relationship-strength rel))))
               relationships)))
    (sort scored-relationships
          (lambda (a b)
            (> (assoc-ref a 'strength)
               (assoc-ref b 'strength))))))

;;;
;;; CONFLICT DETECTION
;;;

(define (detect-relationship-conflicts entity-id)
  "Detect conflicts in entity's relationships.
   
   Parameters:
   - entity-id: Entity identifier
   
   Returns: List of detected conflicts"
  
  (append (detect-role-conflicts entity-id)
          (detect-interest-conflicts entity-id)))

(define (detect-role-conflicts entity-id)
  "Detect role conflicts for entity.
   
   Parameters:
   - entity-id: Entity identifier
   
   Returns: List of role conflicts"
  
  (let* ((relationships (query-direct-relationships entity-id))
         (conflicts '()))
    
    ;; Check for conflicting fiduciary duties
    (let ((fiduciary-rels (filter (lambda (rel)
                                    (equal? (relationship-category rel) 'fiduciary))
                                 relationships)))
      (when (> (length fiduciary-rels) 1)
        ;; Potential conflict of fiduciary duties
        (set! conflicts 
          (cons `((type . fiduciary-duty-conflict)
                  (entity . ,entity-id)
                  (relationships . ,fiduciary-rels))
                conflicts))))
    
    conflicts))

(define (detect-interest-conflicts entity-id)
  "Detect conflicts of interest for entity.
   
   Parameters:
   - entity-id: Entity identifier
   
   Returns: List of interest conflicts"
  
  (let* ((relationships (query-direct-relationships entity-id))
         (conflicts '()))
    
    ;; Check for ownership + fiduciary conflicts
    (let ((ownership-rels (filter (lambda (rel)
                                    (equal? (relationship-category rel) 'ownership))
                                 relationships))
          (fiduciary-rels (filter (lambda (rel)
                                    (equal? (relationship-category rel) 'fiduciary))
                                 relationships)))
      
      (for-each
        (lambda (ownership-rel)
          (for-each
            (lambda (fiduciary-rel)
              (let ((ownership-entity (if (equal? (relationship-entity-a-id ownership-rel) entity-id)
                                         (relationship-entity-b-id ownership-rel)
                                         (relationship-entity-a-id ownership-rel)))
                    (fiduciary-entity (if (equal? (relationship-entity-a-id fiduciary-rel) entity-id)
                                        (relationship-entity-b-id fiduciary-rel)
                                        (relationship-entity-a-id fiduciary-rel))))
                
                ;; Check if there's a path between ownership and fiduciary entities
                (when (find-relationship-path ownership-entity fiduciary-entity 2)
                  (set! conflicts 
                    (cons `((type . ownership-fiduciary-conflict)
                            (entity . ,entity-id)
                            (ownership-relationship . ,ownership-rel)
                            (fiduciary-relationship . ,fiduciary-rel))
                          conflicts)))))
            fiduciary-rels))
        ownership-rels))
    
    conflicts))

;;;
;;; VISUALIZATION DATA GENERATION
;;;

(define (generate-relationship-graph-data entity-id depth)
  "Generate data for relationship graph visualization.
   
   Parameters:
   - entity-id: Entity identifier
   - depth: Depth of relationships to include
   
   Returns: Graph data (nodes and edges)"
  
  (let ((nodes (make-hash-table))
        (edges '())
        (visited (make-hash-table)))
    
    (define (collect-nodes-edges current-id current-depth)
      (when (and (<= current-depth depth)
                 (not (hash-ref visited current-id #f)))
        (hash-set! visited current-id #t)
        (hash-set! nodes current-id 
          `((id . ,current-id)
            (depth . ,current-depth)))
        
        (let ((rels (query-direct-relationships current-id)))
          (for-each
            (lambda (rel)
              (let ((other-id (if (equal? (relationship-entity-a-id rel) current-id)
                                 (relationship-entity-b-id rel)
                                 (relationship-entity-a-id rel))))
                (set! edges 
                  (cons `((source . ,current-id)
                          (target . ,other-id)
                          (type . ,(relationship-type rel))
                          (category . ,(relationship-category rel))
                          (confidence . ,(relationship-confidence rel)))
                        edges))
                (collect-nodes-edges other-id (+ current-depth 1))))
            rels))))
    
    (collect-nodes-edges entity-id 0)
    
    `((nodes . ,(hash-map->list (lambda (k v) v) nodes))
      (edges . ,edges))))

(define (generate-relationship-timeline-data entity-id)
  "Generate data for relationship timeline visualization.
   
   Parameters:
   - entity-id: Entity identifier
   
   Returns: Timeline data"
  
  (let ((timeline (analyze-relationship-timeline entity-id)))
    (map (lambda (event)
           `((timestamp . ,(assoc-ref event 'timestamp))
             (type . ,(assoc-ref event 'type))
             (relationship-type . ,(relationship-type (assoc-ref event 'relationship)))
             (relationship-category . ,(relationship-category (assoc-ref event 'relationship)))
             (other-entity . ,(if (equal? (relationship-entity-a-id (assoc-ref event 'relationship)) entity-id)
                                 (relationship-entity-b-id (assoc-ref event 'relationship))
                                 (relationship-entity-a-id (assoc-ref event 'relationship))))))
         timeline)))

(define (generate-network-analysis-data entity-id)
  "Generate data for network analysis visualization.
   
   Parameters:
   - entity-id: Entity identifier
   
   Returns: Network analysis data"
  
  (let* ((network-metrics (analyze-relationship-network entity-id))
         (patterns (append (detect-coordination-patterns entity-id)
                          (detect-conflict-patterns entity-id)
                          (detect-control-patterns entity-id)
                          (detect-influence-patterns entity-id)))
         (conflicts (detect-relationship-conflicts entity-id)))
    
    `((metrics . ,network-metrics)
      (patterns . ,patterns)
      (conflicts . ,conflicts))))

;;;
;;; HELPER FUNCTIONS
;;;

(define (assoc-ref alist key . default)
  "Get value from association list with optional default."
  (let ((pair (assoc key alist)))
    (if pair
        (cdr pair)
        (if (null? default) #f (car default)))))

(define (current-timestamp)
  "Get current timestamp."
  (get-internal-real-time))

;;;
;;; EXAMPLE USAGE
;;;

;; Example: Query direct relationships
;; (query-direct-relationships "daniel-faucitt")

;; Example: Find relationship path
;; (find-relationship-path "daniel-faucitt" "peter-faucitt" 5)

;; Example: Analyze relationship network
;; (analyze-relationship-network "daniel-faucitt")

;; Example: Detect patterns
;; (detect-coordination-patterns "daniel-faucitt")
;; (detect-control-patterns "daniel-faucitt")

;; Example: Generate visualization data
;; (generate-relationship-graph-data "daniel-faucitt" 2)
;; (generate-relationship-timeline-data "daniel-faucitt")
