;; ============================================================================
;; MODULE 1.1: SINGLE-DIMENSIONAL AGENT MODELING
;; ============================================================================
;; Level: Foundation (1 nest, 1 term)
;; Duration: 2 hours
;; Prerequisites: Basic Scheme syntax
;; Learning Objectives:
;;   1. Understand what an agent is
;;   2. Define agent record types
;;   3. Create and manipulate agent instances
;;   4. Implement simple scoring functions
;;   5. Pass automated assessments
;; ============================================================================

;; ============================================================================
;; PART 1: CONCEPTS (10 minutes)
;; ============================================================================

;; CONCEPT: What is an Agent?
;;
;; An agent is an entity with:
;; • Identity (unique ID, name, type)
;; • State (measurable attributes/dimensions)
;; • Behavior (actions and responses)
;;
;; In our framework, agents are modeled as records with:
;; • Identification fields (id, name)
;; • State dimensions (quantitative scores 0.0-1.0)
;; • Metadata (timestamps, verification info)
;;
;; REAL-WORLD ANALOGY:
;; Think of an agent like a customer in a business:
;; • ID: Customer account number
;; • State: Satisfaction score (how happy they are)
;; • Behavior: Purchases, feedback, interactions

;; CONCEPT: What is a Dimension?
;;
;; A dimension is a measurable attribute of an agent's state.
;; In Module 1.1, we focus on a SINGLE dimension.
;;
;; Examples:
;; • Customer: satisfaction score (0.0 = very unsatisfied, 1.0 = very satisfied)
;; • Employee: performance score (0.0 = poor, 1.0 = excellent)
;; • Product: quality score (0.0 = defective, 1.0 = perfect)
;;
;; All dimensions use a normalized 0.0-1.0 scale for comparability.

;; ============================================================================
;; PART 2: DEMONSTRATION (15 minutes)
;; ============================================================================

;; STEP 1: Define the agent record type
;;
;; We use define-record-type to create a structured data type for agents.
;; This ensures type safety and clear data organization.

(define-record-type <agent-1d>
  ;; Constructor: How to create an agent
  (make-agent-1d id name satisfaction)
  
  ;; Predicate: How to check if something is an agent
  agent-1d?
  
  ;; Accessors: How to get agent attributes
  (id agent-1d-id)
  (name agent-1d-name)
  (satisfaction agent-1d-satisfaction))

;; STEP 2: Create agent instances
;;
;; Let's create three customer agents with different satisfaction scores.

(define alice (make-agent-1d "C001" "Alice" 0.85))
(define bob (make-agent-1d "C002" "Bob" 0.72))
(define carol (make-agent-1d "C003" "Carol" 0.93))

;; STEP 3: Access agent attributes
;;
;; Use the accessor functions to get specific attributes.

(display "Alice's ID: ") (display (agent-1d-id alice)) (newline)
;; Output: Alice's ID: C001

(display "Bob's name: ") (display (agent-1d-name bob)) (newline)
;; Output: Bob's name: Bob

(display "Carol's satisfaction: ") (display (agent-1d-satisfaction carol)) (newline)
;; Output: Carol's satisfaction: 0.93

;; STEP 4: Implement scoring function
;;
;; For a 1D agent, the score is simply the dimension value.

(define (score-agent-1d agent)
  "Compute the score for a 1D agent (simply returns the satisfaction score)"
  (agent-1d-satisfaction agent))

;; Test the scoring function
(display "Alice's score: ") (display (score-agent-1d alice)) (newline)
;; Output: Alice's score: 0.85

;; STEP 5: Implement comparison function
;;
;; Compare two agents and return the one with higher satisfaction.

(define (better-agent agent1 agent2)
  "Return the agent with higher satisfaction score"
  (if (> (score-agent-1d agent1) (score-agent-1d agent2))
      agent1
      agent2))

;; Test the comparison function
(define best (better-agent alice bob))
(display "Better agent: ") (display (agent-1d-name best)) (newline)
;; Output: Better agent: Alice

;; STEP 6: Implement agent list operations
;;
;; Find the best agent in a list of agents.

(define (find-best-agent agents)
  "Find the agent with the highest satisfaction score in a list"
  (if (null? agents)
      #f
      (fold better-agent (car agents) (cdr agents))))

;; Test with multiple agents
(define customers (list alice bob carol))
(define top-customer (find-best-agent customers))
(display "Top customer: ") (display (agent-1d-name top-customer)) (newline)
;; Output: Top customer: Carol

;; ============================================================================
;; PART 3: GUIDED PRACTICE (30 minutes)
;; ============================================================================

;; EXERCISE 1: Create Your First Agent
;;
;; Task: Create an agent representing an employee named "David"
;;       with ID "E001" and performance score 0.78
;;
;; Your code here:
;; (define david (make-agent-1d "E001" "David" 0.78))

;; EXERCISE 2: Implement Agent Update
;;
;; Task: Write a function that creates a new agent with an updated satisfaction score.
;;       (In functional programming, we don't mutate; we create new instances)
;;
;; Function signature:
;; (define (update-agent-satisfaction agent new-satisfaction) ...)
;;
;; Hint: Use make-agent-1d with the old id and name, but new satisfaction
;;
;; Your code here:
;; (define (update-agent-satisfaction agent new-satisfaction)
;;   (make-agent-1d (agent-1d-id agent)
;;                  (agent-1d-name agent)
;;                  new-satisfaction))

;; EXERCISE 3: Implement Agent Filtering
;;
;; Task: Write a function that filters agents by a minimum satisfaction threshold.
;;       Return only agents with satisfaction >= threshold.
;;
;; Function signature:
;; (define (filter-agents-by-satisfaction agents threshold) ...)
;;
;; Hint: Use filter with a lambda that checks satisfaction >= threshold
;;
;; Your code here:
;; (define (filter-agents-by-satisfaction agents threshold)
;;   (filter (lambda (agent)
;;             (>= (agent-1d-satisfaction agent) threshold))
;;           agents))

;; ============================================================================
;; PART 4: INDEPENDENT PRACTICE (45 minutes)
;; ============================================================================

;; CHALLENGE 1: Implement Agent Statistics
;;
;; Task: Write functions to compute statistics over a list of agents:
;;       - average-satisfaction: Compute mean satisfaction
;;       - min-satisfaction: Find minimum satisfaction
;;       - max-satisfaction: Find maximum satisfaction
;;
;; Your code here:

;; CHALLENGE 2: Implement Agent Ranking
;;
;; Task: Write a function that ranks agents by satisfaction (highest to lowest).
;;       Return a list of agents sorted by satisfaction score.
;;
;; Function signature:
;; (define (rank-agents agents) ...)
;;
;; Hint: Use sort with a comparison function
;;
;; Your code here:

;; CHALLENGE 3: Implement Agent Report
;;
;; Task: Write a function that generates a text report for an agent.
;;       The report should include ID, name, satisfaction, and a rating category:
;;       - 0.0-0.4: "Poor"
;;       - 0.4-0.7: "Fair"
;;       - 0.7-0.9: "Good"
;;       - 0.9-1.0: "Excellent"
;;
;; Function signature:
;; (define (generate-agent-report agent) ...)
;;
;; Your code here:

;; ============================================================================
;; PART 5: ASSESSMENT (20 minutes)
;; ============================================================================

;; AUTOMATED TEST SUITE
;;
;; Run these tests to verify your implementations.
;; All tests must pass to complete the module.

(define (run-module-1.1-tests)
  "Run all tests for Module 1.1"
  (let ((tests-passed 0)
        (tests-total 0))
    
    ;; Test 1: Agent creation
    (set! tests-total (+ tests-total 1))
    (let ((test-agent (make-agent-1d "T001" "TestAgent" 0.5)))
      (if (and (equal? (agent-1d-id test-agent) "T001")
               (equal? (agent-1d-name test-agent) "TestAgent")
               (equal? (agent-1d-satisfaction test-agent) 0.5))
          (begin
            (display "✓ Test 1: Agent creation - PASSED\n")
            (set! tests-passed (+ tests-passed 1)))
          (display "✗ Test 1: Agent creation - FAILED\n")))
    
    ;; Test 2: Scoring function
    (set! tests-total (+ tests-total 1))
    (let ((test-agent (make-agent-1d "T002" "TestAgent2" 0.75)))
      (if (equal? (score-agent-1d test-agent) 0.75)
          (begin
            (display "✓ Test 2: Scoring function - PASSED\n")
            (set! tests-passed (+ tests-passed 1)))
          (display "✗ Test 2: Scoring function - FAILED\n")))
    
    ;; Test 3: Comparison function
    (set! tests-total (+ tests-total 1))
    (let ((agent-a (make-agent-1d "T003" "AgentA" 0.8))
          (agent-b (make-agent-1d "T004" "AgentB" 0.6)))
      (if (equal? (agent-1d-id (better-agent agent-a agent-b)) "T003")
          (begin
            (display "✓ Test 3: Comparison function - PASSED\n")
            (set! tests-passed (+ tests-passed 1)))
          (display "✗ Test 3: Comparison function - FAILED\n")))
    
    ;; Test 4: Find best agent
    (set! tests-total (+ tests-total 1))
    (let ((agents (list (make-agent-1d "T005" "Agent1" 0.5)
                        (make-agent-1d "T006" "Agent2" 0.9)
                        (make-agent-1d "T007" "Agent3" 0.7))))
      (if (equal? (agent-1d-id (find-best-agent agents)) "T006")
          (begin
            (display "✓ Test 4: Find best agent - PASSED\n")
            (set! tests-passed (+ tests-passed 1)))
          (display "✗ Test 4: Find best agent - FAILED\n")))
    
    ;; Test 5: Boundary values
    (set! tests-total (+ tests-total 1))
    (let ((agent-min (make-agent-1d "T008" "MinAgent" 0.0))
          (agent-max (make-agent-1d "T009" "MaxAgent" 1.0)))
      (if (and (equal? (score-agent-1d agent-min) 0.0)
               (equal? (score-agent-1d agent-max) 1.0))
          (begin
            (display "✓ Test 5: Boundary values - PASSED\n")
            (set! tests-passed (+ tests-passed 1)))
          (display "✗ Test 5: Boundary values - FAILED\n")))
    
    ;; Report results
    (newline)
    (display "========================================\n")
    (display "TEST RESULTS: ")
    (display tests-passed)
    (display "/")
    (display tests-total)
    (display " tests passed\n")
    (display "========================================\n")
    
    (if (= tests-passed tests-total)
        (begin
          (display "✓ ALL TESTS PASSED!\n")
          (display "Module 1.1 Complete - You may proceed to Module 1.2\n")
          #t)
        (begin
          (display "✗ Some tests failed. Review your implementations.\n")
          #f))))

;; Run the test suite
;; (run-module-1.1-tests)

;; ============================================================================
;; PART 6: REFLECTION (10 minutes)
;; ============================================================================

;; REFLECTION QUESTIONS:
;;
;; 1. What is the difference between an agent's ID and its name?
;;    Answer: ID is a unique identifier (like a primary key), while name is
;;    a human-readable label that may not be unique.
;;
;; 2. Why do we use a 0.0-1.0 scale for dimensions?
;;    Answer: Normalization enables comparability across different dimensions
;;    and agents, and simplifies aggregation and statistical analysis.
;;
;; 3. Why do we create new agents instead of mutating existing ones?
;;    Answer: Functional programming principles - immutability ensures
;;    predictability, thread-safety, and easier reasoning about code.
;;
;; 4. How would you extend this to track satisfaction over time?
;;    Answer: Add a temporal-history field with timestamped satisfaction scores,
;;    or maintain a separate time-series data structure.
;;
;; 5. What are the limitations of a 1D agent model?
;;    Answer: Cannot capture multi-faceted behavior (e.g., high satisfaction
;;    but low loyalty), cannot model trade-offs between dimensions.

;; ============================================================================
;; SOLUTIONS TO EXERCISES
;; ============================================================================

;; EXERCISE 1 SOLUTION:
(define david (make-agent-1d "E001" "David" 0.78))

;; EXERCISE 2 SOLUTION:
(define (update-agent-satisfaction agent new-satisfaction)
  "Create a new agent with updated satisfaction score"
  (make-agent-1d (agent-1d-id agent)
                 (agent-1d-name agent)
                 new-satisfaction))

;; EXERCISE 3 SOLUTION:
(define (filter-agents-by-satisfaction agents threshold)
  "Filter agents by minimum satisfaction threshold"
  (filter (lambda (agent)
            (>= (agent-1d-satisfaction agent) threshold))
          agents))

;; CHALLENGE 1 SOLUTION:
(define (average-satisfaction agents)
  "Compute average satisfaction across agents"
  (if (null? agents)
      0.0
      (/ (apply + (map agent-1d-satisfaction agents))
         (length agents))))

(define (min-satisfaction agents)
  "Find minimum satisfaction score"
  (if (null? agents)
      0.0
      (apply min (map agent-1d-satisfaction agents))))

(define (max-satisfaction agents)
  "Find maximum satisfaction score"
  (if (null? agents)
      0.0
      (apply max (map agent-1d-satisfaction agents))))

;; CHALLENGE 2 SOLUTION:
(define (rank-agents agents)
  "Rank agents by satisfaction (highest to lowest)"
  (sort agents
        (lambda (a b)
          (> (agent-1d-satisfaction a)
             (agent-1d-satisfaction b)))))

;; CHALLENGE 3 SOLUTION:
(define (generate-agent-report agent)
  "Generate text report for an agent"
  (let* ((satisfaction (agent-1d-satisfaction agent))
         (rating (cond
                   ((< satisfaction 0.4) "Poor")
                   ((< satisfaction 0.7) "Fair")
                   ((< satisfaction 0.9) "Good")
                   (else "Excellent"))))
    (string-append
      "AGENT REPORT\n"
      "============\n"
      "ID: " (agent-1d-id agent) "\n"
      "Name: " (agent-1d-name agent) "\n"
      "Satisfaction: " (number->string satisfaction) "\n"
      "Rating: " rating "\n")))

;; ============================================================================
;; NEXT STEPS
;; ============================================================================

;; Congratulations on completing Module 1.1!
;;
;; You've learned:
;; ✓ What agents are and why we model them
;; ✓ How to define agent record types
;; ✓ How to create and manipulate agent instances
;; ✓ How to implement scoring and comparison functions
;; ✓ How to work with lists of agents
;;
;; Next Module: Module 1.2 - Three-Dimensional Agent Modeling
;; Duration: 4 hours
;; Prerequisites: ✓ Module 1.1 complete
;;
;; In Module 1.2, you'll learn:
;; • Multi-dimensional agent states
;; • Aggregate scoring across dimensions
;; • Correlation analysis between dimensions
;; • Trade-offs and optimization

;; ============================================================================
;; END OF MODULE 1.1
;; ============================================================================
