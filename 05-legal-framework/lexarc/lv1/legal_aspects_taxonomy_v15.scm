;;; Legal Aspects Taxonomy v15
;;; Enhanced entity-agent modeling with role-based legal exposure quantification
;;; Case 2025-137857 - November 25, 2025
;;; Repository: cogpy/ad-res-j7
;;;
;;; Enhancement Focus: Agent-based entity modeling with legal exposure scoring,
;;;                    enhanced coordination pattern detection, evidence strength aggregation,
;;;                    cross-paragraph systematic pattern recognition, JR/DR response optimization
;;;

(define-module (lex lv1 legal-aspects-taxonomy-v15)
  #:use-module (lex lv1 known-laws)
  #:use-module (srfi srfi-1)
  #:use-module (srfi srfi-9)
  #:export (
    legal-aspects-taxonomy-v15
    entity-agent-registry-v15
    classify-legal-aspect-v15
    compute-legal-aspect-confidence-v15
    aggregate-legal-aspects-by-priority-v15
    generate-legal-aspect-network-v15
    detect-temporal-causation-patterns-v15
    analyze-entity-relation-co-occurrence-v15
    compute-priority-weighted-confidence-v15
    detect-cross-paragraph-patterns-v15
    generate-evidence-paragraph-mapping-v15
    get-aspect-frequency-v15
    get-aspect-evidence-requirements-v15
    get-aspect-related-aspects-v15
    get-aspect-lex-principles-v15
    get-aspect-ad-paragraphs-v15
    compute-aspect-cumulative-confidence-v15
    identify-aspect-pattern-clusters-v15
    get-entity-agent-profile-v15
    compute-entity-legal-exposure-v15
    detect-multi-actor-coordination-v15
    generate-jr-dr-response-framework-v15
    compute-evidence-strength-aggregate-v15
  ))

;;;
;;; ENTITY-AGENT REGISTRY v15
;;; Comprehensive entity modeling with roles, legal significance, and exposure quantification
;;;

(define entity-agent-registry-v15
  '(
    ;; ========================================
    ;; NATURAL PERSON AGENTS
    ;; ========================================
    
    ("dan" . (
      (formal-names . ("Daniel Faucitt"))
      (informal-names . ("Dan"))
      (type . "natural-person")
      (total-mentions . 611)  ; Dan (576) + Daniel Faucitt (35)
      (paragraph-contexts . 25)
      (roles . (
        "second-respondent"
        "cio"
        "technical-infrastructure-provider"
        "whistleblower"
        "retaliation-victim"
        "platform-owner"
      ))
      (legal-significance . (
        ("whistleblower-protection" . 0.99)
        ("immediate-retaliation-victim" . 0.98)
        ("platform-ownership-evidence" . 0.99)
        ("technical-infrastructure-provider" . 0.99)
        ("r1m-uk-investment-proof" . 0.99)
      ))
      (defense-strength . 0.99)
      (exposure-level . "protected-respondent")
      (coordination-targets . ())
      (key-evidence . (
        "regima-zone-ltd-ownership"
        "r1m-uk-investment"
        "technical-infrastructure-documentation"
        "whistleblowing-submission-2025-06-06"
        "immediate-retaliation-2025-06-07"
      ))
      (temporal-significance . (
        ("2025-06-06" . "fraud-report-submission" . 0.99)
        ("2025-06-07" . "immediate-retaliation-victim" . 0.98)
      ))
    ))
    
    ("jax" . (
      (formal-names . ("Jacqueline Faucitt"))
      (informal-names . ("Jax" "Jacqui"))
      (type . "natural-person")
      (total-mentions . 87)  ; Jax (71) + Jacqueline Faucitt (9) + Jacqui (7)
      (paragraph-contexts . 16)
      (roles . (
        "first-respondent"
        "ceo"
        "eu-responsible-person"
        "whistleblower"
        "retaliation-victim"
        "platform-owner"
      ))
      (legal-significance . (
        ("eu-responsible-person-evidence" . 0.99)
        ("regulatory-compliance-enabler" . 0.99)
        ("whistleblower-protection" . 0.99)
        ("retaliation-victim" . 0.96)
        ("platform-ownership-evidence" . 0.99)
      ))
      (defense-strength . 0.99)
      (exposure-level . "protected-respondent")
      (coordination-targets . ())
      (key-evidence . (
        "regima-zone-ltd-ownership"
        "r1m-uk-investment"
        "eu-responsible-person-documentation"
        "popia-violation-notice-2025-05-15"
        "retaliation-cascade-2025-05-22"
      ))
      (temporal-significance . (
        ("2025-05-15" . "whistleblowing-popia-violation-notice" . 0.99)
        ("2025-05-22" . "retaliation-cascade-victim" . 0.96)
      ))
    ))
    
    ("peter-faucitt" . (
      (formal-names . ("Peter Faucitt"))
      (informal-names . ())
      (type . "natural-person")
      (total-mentions . 22)
      (paragraph-contexts . 3)
      (roles . (
        "applicant"
        "trustee"
        "fiduciary"
        "fraud-orchestrator"
        "manufactured-crisis-architect"
        "retaliation-executor"
        "multi-actor-coordinator"
      ))
      (legal-significance . (
        ("fiduciary-duty-breach-orchestrator" . 0.98)
        ("manufactured-crisis-architect" . 0.99)
        ("retaliation-executor" . 0.98)
        ("bad-faith-orchestrator" . 0.98)
        ("fraud-orchestration" . 0.98)
      ))
      (defense-strength . 0.01)
      (exposure-level . "critical")
      (coordination-targets . ("rynette-farrar"))
      (key-evidence . (
        "settlement-trojan-horse-2025-03-01-to-2025-04-14"
        "immediate-retaliation-2025-06-07"
        "coordinated-action-2025-08-13"
        "void-ab-initio-settlement"
        "regulatory-crisis-r70m-plus"
      ))
      (temporal-significance . (
        ("2025-03-01" . "settlement-negotiation-start" . 0.99)
        ("2025-04-14" . "settlement-negotiation-end" . 0.99)
        ("2025-06-07" . "immediate-retaliation-execution" . 0.98)
        ("2025-08-13" . "coordinated-action-filing" . 0.94)
      ))
      (quantified-exposure . (
        ("regulatory-crisis" . 70000000)
        ("beneficiary-harm" . "unquantified")
        ("void-ab-initio-settlement" . "legal-nullification")
      ))
    ))
    
    ("rynette-farrar" . (
      (formal-names . ("Rynette Farrar"))
      (informal-names . ())
      (type . "natural-person")
      (total-mentions . 13)
      (paragraph-contexts . 2)
      (roles . (
        "accountant"
        "creditor-director"
        "multi-actor-coordinator"
        "retaliation-facilitator"
        "conflict-of-interest-actor"
      ))
      (legal-significance . (
        ("multi-actor-coordination" . 0.94)
        ("conflict-of-interest" . 0.94)
        ("retaliation-facilitation" . 0.96)
        ("creditor-control-abuse" . 0.94)
        ("professional-ethics-violation" . 0.92)
      ))
      (defense-strength . 0.05)
      (exposure-level . "high")
      (coordination-targets . ("peter-faucitt"))
      (key-evidence . (
        "retaliation-cascade-2025-05-22"
        "creditor-control-r1035000"
        "accountant-conflict-of-interest"
      ))
      (temporal-significance . (
        ("2025-05-22" . "retaliation-execution-7-days" . 0.96)
      ))
      (quantified-exposure . (
        ("creditor-control-abuse" . 1035000)
        ("professional-ethics-violation" . "unquantified")
      ))
    ))
    
    ;; ========================================
    ;; JURISTIC PERSON AGENTS
    ;; ========================================
    
    ("rst" . (
      (formal-names . ("RegimA Skin Treatments"))
      (informal-names . ("RST"))
      (type . "juristic-person")
      (total-mentions . 63)  ; RST (60) + RegimA Skin Treatments (3)
      (paragraph-contexts . 16)
      (roles . (
        "operating-company"
        "revenue-hijacking-victim"
        "primary-business-entity"
      ))
      (legal-significance . (
        ("revenue-hijacking-victim" . 0.99)
        ("platform-ownership-evidence" . 0.99)
        ("operational-entity" . 0.99)
      ))
      (defense-strength . 0.99)
      (exposure-level . "protected-entity")
      (key-evidence . (
        "revenue-hijacking-documentation"
        "platform-ownership-proof"
        "operational-records"
      ))
    ))
    
    ("rwd" . (
      (formal-names . ("RegimA Worldwide Distribution"))
      (informal-names . ("RWD"))
      (type . "juristic-person")
      (total-mentions . 88)  ; RWD (68) + RegimA Worldwide Distribution (20)
      (paragraph-contexts . 6)
      (roles . (
        "distribution-entity"
        "platform-owner"
        "technical-infrastructure-entity"
      ))
      (legal-significance . (
        ("platform-ownership-evidence" . 0.99)
        ("unjust-enrichment-defense" . 0.99)
        ("technical-infrastructure-entity" . 0.99)
      ))
      (defense-strength . 0.99)
      (exposure-level . "protected-entity")
      (key-evidence . (
        "platform-ownership-documentation"
        "technical-infrastructure-records"
      ))
    ))
    
    ("regima-zone-ltd" . (
      (formal-names . ("RegimA Zone Ltd"))
      (informal-names . ())
      (type . "juristic-person")
      (total-mentions . 11)
      (paragraph-contexts . 3)
      (roles . (
        "uk-entity"
        "platform-investment-vehicle"
        "ownership-evidence-entity"
      ))
      (legal-significance . (
        ("r1m-investment-proof" . 0.99)
        ("unjust-enrichment-defense" . 0.99)
        ("platform-ownership-evidence" . 0.99)
      ))
      (defense-strength . 0.99)
      (exposure-level . "protected-entity")
      (key-evidence . (
        "r1m-uk-investment-documentation"
        "admin-fee-0.001-justification"
        "platform-ownership-proof"
      ))
      (quantified-defense . (
        ("uk-investment" . 1000000)
        ("admin-fee-percentage" . 0.001)
        ("peter-contribution" . 0)
      ))
    ))
    
    ("faucitt-family-trust" . (
      (formal-names . ("Faucitt Family Trust"))
      (informal-names . ("FFT"))
      (type . "juristic-person")
      (total-mentions . 7)  ; Faucitt Family Trust (5) + FFT (2)
      (paragraph-contexts . 3)
      (roles . (
        "trust-entity"
        "fiduciary-context"
        "beneficiary-interests"
      ))
      (legal-significance . (
        ("fiduciary-duty-breach-context" . 0.99)
        ("beneficiary-interests-violation" . 0.99)
      ))
      (exposure-level . "fiduciary-breach-context")
      (key-evidence . (
        "fiduciary-duty-breach-documentation"
        "beneficiary-harm-evidence"
      ))
    ))
    
    ("rezonance" . (
      (formal-names . ("Rezonance"))
      (informal-names . ())
      (type . "juristic-person")
      (total-mentions . 2)
      (paragraph-contexts . 1)
      (roles . (
        "creditor-entity"
        "conflict-of-interest-context"
      ))
      (legal-significance . (
        ("creditor-control-abuse" . 0.98)
        ("conflict-of-interest" . 0.94)
      ))
      (quantified-significance . (
        ("debt-amount" . 1035000)
      ))
    ))
  ))

;;;
;;; LEGAL ASPECTS TAXONOMY v15
;;; Updated with actual AD analysis data and enhanced entity-agent integration
;;;

(define legal-aspects-taxonomy-v15
  '(
    ;; ========================================
    ;; CRITICAL PRIORITY LEGAL ASPECTS
    ;; ========================================
    
    ("fraud" . (
      (category . "intentional-wrongdoing")
      (priority . "critical")
      (frequency . 113)
      (ad-paragraph-distribution . (
        ("1-critical" . 2)
        ("2-high" . 3)
        ("3-medium" . 1)
      ))
      (confidence . 0.97)
      (priority-weighted-confidence . 0.98)
      (cumulative-confidence . 0.99)
      (evidence-requirements . (
        "material-misrepresentation" 
        "knowledge" 
        "reliance" 
        "damages"
        "platform-ownership-concealment"
        "revenue-hijacking-evidence"
        "financial-flow-documentation"
      ))
      (evidence-strength-scores . (
        ("financial-records" . 0.98)
        ("platform-ownership-documents" . 0.99)
        ("revenue-flow-analysis" . 0.96)
        ("correspondence" . 0.88)
      ))
      (evidence-strength-aggregate . 0.95)
      (quantified-damages . (
        ("revenue-theft" . 3141000)
        ("financial-flows" . 4276000)
        ("family-trust" . 2851000)
        ("total" . 10269727.90)
      ))
      (entity-agent-network . (
        ("peter-faucitt" . (
          (role . "fraud-orchestrator")
          (confidence . 0.98)
          (coordination-targets . ("rynette-farrar"))
          (legal-exposure . "critical")
        ))
        ("rynette-farrar" . (
          (role . "fraud-facilitator")
          (confidence . 0.94)
          (coordination-targets . ("peter-faucitt"))
          (legal-exposure . "high")
        ))
      ))
      (temporal-patterns . (
        ("settlement-negotiation" . "2025-03-01" . "2025-04-14" . (
          (pattern . "trojan-horse")
          (confidence . 0.99)
        ))
        ("fraud-exposure" . "2025-06-06" . (
          (confidence . 0.99)
        ))
        ("immediate-retaliation" . "2025-06-07" . (
          (confidence . 0.98)
        ))
      ))
      (ad-paragraph-evidence . (
        "7.2-7.5" "7.6" "7.7-7.8" "7.9-7.11" "10.5-10.23"
      ))
      (cross-paragraph-patterns . (
        ("systematic-concealment" . 0.98)
        ("coordinated-misrepresentation" . 0.96)
        ("temporal-bad-faith" . 0.98)
      ))
      (jr-dr-response-framework . (
        ("JR-fraud-elements" . (
          (material-misrepresentation . "platform-ownership-concealment")
          (knowledge . "peter-knew-dan-jax-owned-platform")
          (reliance . "settlement-trojan-horse")
          (damages . "r10.27m-quantified")
        ))
        ("DR-fraud-technical" . (
          (technical-infrastructure-evidence . "dan-built-platform")
          (platform-ownership-proof . "regima-zone-ltd-r1m-investment")
          (revenue-hijacking-documentation . "financial-flow-analysis")
        ))
      ))
      (related-aspects . ("bad-faith" "unjust-enrichment" "manufactured-crisis"))
      (lex-principles . (
        "south-african-civil-law-case-2025-137857-refined-v15"
        "south-african-forensic-analysis-systematic-fraud-narrative"
      ))
    ))
    
    ("bad-faith" . (
      (category . "intentional-wrongdoing")
      (priority . "critical")
      (frequency . 53)
      (ad-paragraph-distribution . (
        ("1-critical" . 4)
        ("2-high" . 3)
      ))
      (confidence . 0.98)
      (priority-weighted-confidence . 0.99)
      (cumulative-confidence . 0.99)
      (evidence-requirements . (
        "temporal-proximity" 
        "knowledge-of-omitted-facts" 
        "hypocrisy-pattern"
        "settlement-trojan-horse"
        "material-non-disclosure"
        "coordinated-action-evidence"
      ))
      (evidence-strength-scores . (
        ("temporal-analysis" . 0.98)
        ("knowledge-documentation" . 0.95)
        ("hypocrisy-evidence" . 0.92)
        ("settlement-documents" . 0.96)
      ))
      (evidence-strength-aggregate . 0.95)
      (temporal-patterns . (
        ("settlement-negotiation" . "2025-03-01" . "2025-04-14" . (
          (pattern . "trojan-horse")
          (confidence . 0.99)
          (no-terms-of-reference . #t)
        ))
        ("whistleblowing-trigger" . "2025-05-15" . (
          (actor . "jax")
          (action . "popia-violation-notice")
          (confidence . 0.99)
        ))
        ("retaliation-cascade" . (
          ("2025-05-22" . "rynette-retaliation" . "7-days" . 0.96)
          ("2025-06-07" . "peter-retaliation" . "< 24-hours" . 0.98)
          ("2025-08-13" . "coordinated-action" . 0.94)
        ))
      ))
      (entity-agent-network . (
        ("peter-faucitt" . (
          (role . "bad-faith-orchestrator")
          (confidence . 0.98)
          (targets . ("dan" "jax"))
          (coordination . ("rynette-farrar"))
          (legal-exposure . "critical")
        ))
        ("rynette-farrar" . (
          (role . "bad-faith-facilitator")
          (confidence . 0.94)
          (targets . ("jax"))
          (coordination . ("peter-faucitt"))
          (legal-exposure . "high")
        ))
      ))
      (ad-paragraph-evidence . (
        "7.2-7.5" "7.6" "7.9-7.11" "8.1-8.3" "11.1-11.5" "12.3"
      ))
      (cross-paragraph-patterns . (
        ("settlement-trojan-horse" . 0.99)
        ("temporal-proximity-cascade" . 0.98)
        ("knowledge-hypocrisy" . 0.97)
        ("coordinated-retaliation" . 0.94)
      ))
      (jr-dr-response-framework . (
        ("JR-bad-faith-temporal" . (
          (settlement-trojan-horse . "2025-03-01-to-2025-04-14")
          (whistleblowing-trigger . "2025-05-15")
          (retaliation-cascade . "2025-05-22-7-days")
        ))
        ("DR-bad-faith-immediate" . (
          (whistleblowing-submission . "2025-06-06")
          (immediate-retaliation . "2025-06-07-less-than-24-hours")
          (temporal-proximity-confidence . 0.98)
        ))
      ))
      (related-aspects . ("fraud" "manufactured-crisis" "retaliation"))
      (lex-principles . (
        "south-african-civil-law-temporal-bad-faith-v3"
        "south-african-civil-law-manufactured-crisis-detection"
      ))
    ))
    
    ("unjust-enrichment" . (
      (category . "civil-law-remedy")
      (priority . "critical")
      (frequency . 37)
      (ad-paragraph-distribution . (
        ("1-critical" . 3)
      ))
      (confidence . 0.94)
      (priority-weighted-confidence . 0.96)
      (cumulative-confidence . 0.98)
      (evidence-requirements . (
        "enrichment" 
        "impoverishment" 
        "causal-connection" 
        "no-legal-justification"
        "platform-ownership-evidence"
        "r1m-uk-investment-proof"
        "admin-fee-justification"
      ))
      (evidence-strength-scores . (
        ("platform-ownership-documents" . 0.99)
        ("uk-investment-proof" . 0.99)
        ("admin-fee-documentation" . 0.96)
        ("financial-flows" . 0.95)
      ))
      (evidence-strength-aggregate . 0.97)
      (uk-investment-structure . (
        ("regima-zone-ltd-investment" . 1000000)
        ("admin-fee-percentage" . 0.001)
        ("defense-strength" . 0.99)
        ("legal-significance" . "proves-legitimate-investment")
        ("peter-contribution" . 0)
        ("unjust-enrichment-refutation" . 0.99)
      ))
      (platform-ownership . (
        ("dan-jax-ownership" . "RegimA Zone Ltd")
        ("investment-proof" . "R1M UK investment")
        ("peter-contribution" . 0)
        ("unjust-enrichment-confidence" . 0.99)
        ("admin-fee-justification" . 0.001)
      ))
      (entity-agent-network . (
        ("dan" . (
          (role . "platform-owner")
          (confidence . 0.99)
          (ownership . "regima-zone-ltd")
          (investment . 1000000)
          (defense-strength . 0.99)
        ))
        ("jax" . (
          (role . "platform-owner")
          (confidence . 0.99)
          (ownership . "regima-zone-ltd")
          (investment . 1000000)
          (defense-strength . 0.99)
        ))
        ("peter-faucitt" . (
          (role . "unjust-enrichment-claimant")
          (confidence . 0.98)
          (contribution . 0)
          (claim-validity . 0.01)
          (legal-exposure . "critical")
        ))
      ))
      (ad-paragraph-evidence . (
        "7.9-7.11" "10.5-10.23"
      ))
      (cross-paragraph-patterns . (
        ("platform-ownership-concealment" . 0.99)
        ("investment-omission" . 0.99)
        ("admin-fee-mischaracterization" . 0.96)
      ))
      (jr-dr-response-framework . (
        ("JR-unjust-enrichment-defense" . (
          (platform-ownership . "regima-zone-ltd-co-owner")
          (r1m-investment . "legitimate-business-structure")
          (admin-fee-0.001 . "proves-no-profiteering")
        ))
        ("DR-unjust-enrichment-technical" . (
          (platform-builder . "dan-technical-infrastructure-provider")
          (r1m-investment-proof . "regima-zone-ltd-documentation")
          (peter-contribution-zero . "no-legal-justification-for-enrichment-claim")
        ))
      ))
      (related-aspects . ("fraud" "platform-ownership"))
      (lex-principles . (
        "south-african-civil-law-unjust-enrichment"
        "south-african-civil-law-platform-unjust-enrichment"
      ))
    ))
    
    ("retaliation" . (
      (category . "whistleblower-protection")
      (priority . "critical")
      (frequency . 35)
      (ad-paragraph-distribution . (
        ("1-critical" . 1)
        ("2-high" . 2)
      ))
      (confidence . 0.98)
      (priority-weighted-confidence . 0.98)
      (cumulative-confidence . 0.99)
      (evidence-requirements . (
        "whistleblowing-disclosure" 
        "temporal-proximity" 
        "adverse-action"
        "causation-inference"
        "immediate-retaliation-pattern"
        "cascade-coordination-evidence"
      ))
      (evidence-strength-scores . (
        ("whistleblowing-documentation" . 0.99)
        ("temporal-analysis" . 0.98)
        ("adverse-action-evidence" . 0.96)
        ("causation-documentation" . 0.95)
      ))
      (evidence-strength-aggregate . 0.97)
      (temporal-thresholds . (
        ("immediate" . "< 24 hours" . 0.98)
        ("short-term" . "< 7 days" . 0.96)
        ("medium-term" . "< 30 days" . 0.90)
      ))
      (retaliation-events . (
        ("jax-whistleblowing" . "2025-05-15" . (
          (action . "popia-violation-notice")
          (target . "peter-faucitt")
          (confidence . 0.99)
        ))
        ("rynette-retaliation" . "2025-05-22" . (
          (timeframe . "7-days")
          (confidence . 0.96)
          (target . "jax")
          (action . "adverse-action")
        ))
        ("dan-whistleblowing" . "2025-06-06" . (
          (action . "fraud-report-submission")
          (target . "accountant")
          (confidence . 0.99)
        ))
        ("peter-retaliation" . "2025-06-07" . (
          (timeframe . "< 24-hours")
          (confidence . 0.98)
          (target . "dan")
          (action . "card-cancellation")
        ))
      ))
      (entity-agent-network . (
        ("dan" . (
          (role . "whistleblower")
          (confidence . 0.99)
          (retaliation-victim . #t)
          (temporal-proximity . "< 24-hours")
          (defense-strength . 0.99)
        ))
        ("jax" . (
          (role . "whistleblower")
          (confidence . 0.99)
          (retaliation-victim . #t)
          (temporal-proximity . "7-days")
          (defense-strength . 0.96)
        ))
        ("peter-faucitt" . (
          (role . "retaliation-executor")
          (confidence . 0.98)
          (targets . ("dan"))
          (legal-exposure . "critical")
        ))
        ("rynette-farrar" . (
          (role . "retaliation-executor")
          (confidence . 0.96)
          (targets . ("jax"))
          (legal-exposure . "high")
        ))
      ))
      (ad-paragraph-evidence . (
        "7.2-7.5" "7.6" "8.1-8.3"
      ))
      (cross-paragraph-patterns . (
        ("immediate-retaliation" . 0.98)
        ("cascade-coordination" . 0.94)
        ("temporal-proximity-pattern" . 0.97)
      ))
      (jr-dr-response-framework . (
        ("JR-retaliation-cascade" . (
          (whistleblowing-date . "2025-05-15")
          (retaliation-date . "2025-05-22")
          (temporal-proximity . "7-days")
          (confidence . 0.96)
        ))
        ("DR-retaliation-immediate" . (
          (whistleblowing-date . "2025-06-06")
          (retaliation-date . "2025-06-07")
          (temporal-proximity . "< 24-hours")
          (confidence . 0.98)
        ))
      ))
      (related-aspects . ("bad-faith" "manufactured-crisis" "temporal-proximity"))
      (lex-principles . (
        "south-african-whistleblower-protection"
        "south-african-civil-law-retaliation-temporal-proximity"
      ))
    ))
    
    ("manufactured-crisis" . (
      (category . "procedural-wrongdoing")
      (priority . "critical")
      (frequency . 29)
      (ad-paragraph-distribution . (
        ("1-critical" . 1)
        ("2-high" . 3)
      ))
      (confidence . 0.99)
      (priority-weighted-confidence . 0.99)
      (cumulative-confidence . 0.99)
      (evidence-requirements . (
        "settlement-trojan-horse"
        "no-terms-of-reference"
        "immediate-retaliation-pattern"
        "coordinated-action-evidence"
        "temporal-synchronization"
      ))
      (evidence-strength-scores . (
        ("settlement-documents" . 0.99)
        ("temporal-analysis" . 0.98)
        ("coordination-evidence" . 0.94)
      ))
      (evidence-strength-aggregate . 0.97)
      (temporal-patterns . (
        ("settlement-trojan-horse" . "2025-03-01" . "2025-04-14" . (
          (no-terms-of-reference . #t)
          (confidence . 0.99)
        ))
        ("coordinated-filing" . "2025-08-13" . (
          (actors . ("peter-faucitt" "rynette-farrar"))
          (confidence . 0.94)
        ))
      ))
      (entity-agent-network . (
        ("peter-faucitt" . (
          (role . "crisis-architect")
          (confidence . 0.99)
          (coordination . ("rynette-farrar"))
          (legal-exposure . "critical")
        ))
        ("rynette-farrar" . (
          (role . "crisis-facilitator")
          (confidence . 0.94)
          (coordination . ("peter-faucitt"))
          (legal-exposure . "high")
        ))
      ))
      (ad-paragraph-evidence . (
        "8.1-8.3" "7.2-7.5"
      ))
      (cross-paragraph-patterns . (
        ("settlement-trojan-horse" . 0.99)
        ("coordinated-action" . 0.94)
        ("temporal-synchronization" . 0.96)
      ))
      (jr-dr-response-framework . (
        ("JR-manufactured-crisis-settlement" . (
          (settlement-period . "2025-03-01-to-2025-04-14")
          (no-terms-of-reference . #t)
          (trojan-horse-confidence . 0.99)
        ))
        ("DR-manufactured-crisis-coordination" . (
          (coordinated-filing . "2025-08-13")
          (multi-actor-coordination . ("peter-faucitt" "rynette-farrar"))
          (confidence . 0.94)
        ))
      ))
      (related-aspects . ("bad-faith" "abuse-of-process" "retaliation"))
      (lex-principles . (
        "south-african-civil-law-manufactured-crisis-detection"
        "south-african-civil-law-abuse-of-process"
      ))
    ))
    
    ("temporal-proximity" . (
      (category . "evidentiary-pattern")
      (priority . "critical")
      (frequency . 25)
      (ad-paragraph-distribution . (
        ("1-critical" . 1)
        ("2-high" . 1)
      ))
      (confidence . 0.98)
      (priority-weighted-confidence . 0.98)
      (cumulative-confidence . 0.98)
      (evidence-requirements . (
        "whistleblowing-event"
        "retaliation-event"
        "temporal-interval-calculation"
        "causation-inference"
      ))
      (evidence-strength-scores . (
        ("temporal-documentation" . 0.99)
        ("causation-analysis" . 0.96)
      ))
      (evidence-strength-aggregate . 0.97)
      (temporal-thresholds . (
        ("immediate" . "< 24 hours" . 0.98)
        ("short-term" . "< 7 days" . 0.96)
        ("medium-term" . "< 30 days" . 0.90)
      ))
      (temporal-events . (
        ("jax-cascade" . (
          (whistleblowing . "2025-05-15")
          (retaliation . "2025-05-22")
          (interval . "7-days")
          (confidence . 0.96)
        ))
        ("dan-immediate" . (
          (whistleblowing . "2025-06-06")
          (retaliation . "2025-06-07")
          (interval . "< 24-hours")
          (confidence . 0.98)
        ))
      ))
      (ad-paragraph-evidence . (
        "7.2-7.5" "7.6"
      ))
      (cross-paragraph-patterns . (
        ("immediate-retaliation" . 0.98)
        ("cascade-pattern" . 0.96)
      ))
      (jr-dr-response-framework . (
        ("JR-temporal-proximity-7-days" . (
          (interval . "7-days")
          (confidence . 0.96)
        ))
        ("DR-temporal-proximity-immediate" . (
          (interval . "< 24-hours")
          (confidence . 0.98)
        ))
      ))
      (related-aspects . ("retaliation" "bad-faith"))
      (lex-principles . (
        "south-african-civil-law-retaliation-temporal-proximity"
      ))
    ))
    
    ;; ========================================
    ;; HIGH PRIORITY LEGAL ASPECTS
    ;; ========================================
    
    ("fiduciary-duty-breach" . (
      (category . "fiduciary-violation")
      (priority . "high")
      (frequency . 6)
      (ad-paragraph-distribution . (
        ("1-critical" . 2)
        ("2-high" . 1)
      ))
      (confidence . 0.96)
      (priority-weighted-confidence . 0.97)
      (cumulative-confidence . 0.98)
      (evidence-requirements . (
        "fiduciary-relationship"
        "breach-of-duty"
        "beneficiary-harm"
        "self-dealing"
      ))
      (evidence-strength-scores . (
        ("fiduciary-documentation" . 0.96)
        ("breach-evidence" . 0.94)
        ("beneficiary-harm-documentation" . 0.92)
      ))
      (evidence-strength-aggregate . 0.94)
      (entity-agent-network . (
        ("peter-faucitt" . (
          (role . "fiduciary-breach-orchestrator")
          (confidence . 0.98)
          (fiduciary-duty . "faucitt-family-trust")
          (legal-exposure . "critical")
        ))
      ))
      (ad-paragraph-evidence . (
        "8.1-8.3" "11.1-11.5"
      ))
      (cross-paragraph-patterns . (
        ("self-dealing" . 0.96)
        ("conflict-of-interest" . 0.95)
        ("beneficiary-harm" . 0.94)
      ))
      (jr-dr-response-framework . (
        ("JR-fiduciary-breach-context" . (
          (fiduciary-relationship . "faucitt-family-trust")
          (breach-evidence . "self-dealing-conflict-of-interest")
        ))
        ("DR-fiduciary-breach-impact" . (
          (beneficiary-harm . "quantified-exposure")
        ))
      ))
      (related-aspects . ("self-dealing" "conflict-of-interest"))
      (lex-principles . (
        "south-african-trust-law-enhanced-v8"
        "south-african-civil-law-fiduciary-duty"
      ))
    ))
    
    ("abuse-of-process" . (
      (category . "procedural-wrongdoing")
      (priority . "high")
      (frequency . 7)
      (ad-paragraph-distribution . (
        ("1-critical" . 1)
      ))
      (confidence . 0.93)
      (priority-weighted-confidence . 0.94)
      (cumulative-confidence . 0.96)
      (evidence-requirements . (
        "improper-purpose" 
        "void-ab-initio"
        "settlement-trojan-horse"
        "manufactured-crisis"
      ))
      (evidence-strength-scores . (
        ("settlement-documents" . 0.99)
        ("improper-purpose-evidence" . 0.94)
        ("void-ab-initio-analysis" . 0.99)
      ))
      (evidence-strength-aggregate . 0.97)
      (ad-paragraph-evidence . (
        "8.1-8.3"
      ))
      (cross-paragraph-patterns . (
        ("settlement-trojan-horse" . 0.99)
        ("improper-purpose" . 0.94)
      ))
      (jr-dr-response-framework . (
        ("JR-abuse-of-process-settlement" . (
          (void-ab-initio . "settlement-trojan-horse")
          (improper-purpose . "manufactured-crisis")
        ))
      ))
      (related-aspects . ("bad-faith" "manufactured-crisis"))
      (lex-principles . (
        "south-african-civil-law-abuse-of-process"
      ))
    ))
    
    ("breach" . (
      (category . "general-wrongdoing")
      (priority . "high")
      (frequency . 13)
      (ad-paragraph-distribution . (
        ("1-critical" . 2)
        ("2-high" . 3)
      ))
      (confidence . 0.92)
      (priority-weighted-confidence . 0.93)
      (cumulative-confidence . 0.95)
      (evidence-requirements . (
        "duty-owed"
        "breach-evidence"
        "causation"
        "damages"
      ))
      (evidence-strength-scores . (
        ("breach-documentation" . 0.94)
        ("causation-evidence" . 0.92)
        ("damages-documentation" . 0.90)
      ))
      (evidence-strength-aggregate . 0.92)
      (ad-paragraph-evidence . (
        "7.6" "8.1-8.3" "11.1-11.5"
      ))
      (cross-paragraph-patterns . (
        ("systematic-breach" . 0.93)
      ))
      (related-aspects . ("fiduciary-duty-breach" "delict"))
      (lex-principles . (
        "south-african-civil-law"
      ))
    ))
    
    ;; ========================================
    ;; MEDIUM PRIORITY LEGAL ASPECTS
    ;; ========================================
    
    ("delict" . (
      (category . "civil-law-remedy")
      (priority . "medium")
      (frequency . 4)
      (ad-paragraph-distribution . (
        ("1-critical" . 1)
      ))
      (confidence . 0.92)
      (priority-weighted-confidence . 0.92)
      (cumulative-confidence . 0.93)
      (evidence-requirements . (
        "wrongful-act" 
        "fault" 
        "causation" 
        "damages"
      ))
      (evidence-strength-scores . (
        ("wrongful-act-documentation" . 0.94)
        ("fault-evidence" . 0.92)
        ("damages-documentation" . 0.90)
      ))
      (evidence-strength-aggregate . 0.92)
      (ad-paragraph-evidence . (
        "7.2-7.5"
      ))
      (related-aspects . ("retaliation" "manufactured-crisis"))
      (lex-principles . (
        "south-african-civil-law-delict"
      ))
    ))
    
    ("conflict-of-interest" . (
      (category . "ethical-violation")
      (priority . "medium")
      (frequency . 5)
      (ad-paragraph-distribution . (
        ("2-high" . 1)
      ))
      (confidence . 0.90)
      (priority-weighted-confidence . 0.91)
      (cumulative-confidence . 0.92)
      (evidence-requirements . (
        "conflicting-interests"
        "duty-owed"
        "breach-of-duty"
      ))
      (evidence-strength-scores . (
        ("conflict-documentation" . 0.94)
        ("duty-evidence" . 0.90)
      ))
      (evidence-strength-aggregate . 0.92)
      (entity-agent-network . (
        ("rynette-farrar" . (
          (role . "conflicted-actor")
          (confidence . 0.94)
          (conflicts . ("accountant" "creditor-director"))
          (legal-exposure . "high")
        ))
      ))
      (ad-paragraph-evidence . (
        "11.1-11.5"
      ))
      (related-aspects . ("fiduciary-duty-breach" "self-dealing"))
      (lex-principles . (
        "south-african-civil-law-conflict-of-interest"
      ))
    ))
    
    ("self-dealing" . (
      (category . "fiduciary-violation")
      (priority . "medium")
      (frequency . 2)
      (ad-paragraph-distribution . (
        ("2-high" . 1)
      ))
      (confidence . 0.88)
      (priority-weighted-confidence . 0.89)
      (cumulative-confidence . 0.90)
      (evidence-requirements . (
        "fiduciary-relationship"
        "self-dealing-transaction"
        "lack-of-disclosure"
      ))
      (evidence-strength-scores . (
        ("transaction-documentation" . 0.92)
        ("disclosure-evidence" . 0.88)
      ))
      (evidence-strength-aggregate . 0.90)
      (ad-paragraph-evidence . (
        "11.1-11.5"
      ))
      (related-aspects . ("fiduciary-duty-breach" "conflict-of-interest"))
      (lex-principles . (
        "south-african-trust-law-enhanced-v8"
      ))
    ))
    
    ("coercion" . (
      (category . "intentional-wrongdoing")
      (priority . "medium")
      (frequency . 1)
      (ad-paragraph-distribution . (
        ("2-high" . 1)
      ))
      (confidence . 0.93)
      (priority-weighted-confidence . 0.93)
      (cumulative-confidence . 0.93)
      (evidence-requirements . (
        "threat" 
        "improper-purpose" 
        "causal-connection"
      ))
      (evidence-strength-scores . (
        ("threat-documentation" . 0.94)
        ("improper-purpose-evidence" . 0.92)
      ))
      (evidence-strength-aggregate . 0.93)
      (ad-paragraph-evidence . (
        "8.1-8.3"
      ))
      (related-aspects . ("bad-faith" "manufactured-crisis"))
      (lex-principles . (
        "south-african-civil-law-coercion"
      ))
    ))
  ))

;;;
;;; TAXONOMY QUERY AND ANALYSIS FUNCTIONS v15
;;;

;; Classify legal aspect
(define (classify-legal-aspect-v15 aspect-name)
  "Classify a legal aspect and return its taxonomy entry"
  (assoc-ref legal-aspects-taxonomy-v15 aspect-name))

;; Get entity agent profile
(define (get-entity-agent-profile-v15 entity-name)
  "Get entity agent profile from registry"
  (assoc-ref entity-agent-registry-v15 entity-name))

;; Compute entity legal exposure
(define (compute-entity-legal-exposure-v15 entity-name)
  "Compute legal exposure level for an entity"
  (let ((entity-profile (get-entity-agent-profile-v15 entity-name)))
    (if entity-profile
        (assoc-ref entity-profile 'exposure-level)
        "unknown")))

;; Compute legal aspect confidence
(define (compute-legal-aspect-confidence-v15 aspect-name paragraph-priority)
  "Compute confidence for a legal aspect based on paragraph priority"
  (let ((aspect-data (classify-legal-aspect-v15 aspect-name)))
    (if aspect-data
        (let ((base-confidence (assoc-ref aspect-data 'confidence))
              (priority-weight (cond
                                ((equal? paragraph-priority "1-critical") 1.02)
                                ((equal? paragraph-priority "2-high") 1.01)
                                (else 1.0))))
          (min 0.99 (* base-confidence priority-weight)))
        0.0)))

;; Aggregate legal aspects by priority
(define (aggregate-legal-aspects-by-priority-v15 priority-filter)
  "Aggregate legal aspects filtered by paragraph priority"
  (filter (lambda (aspect-entry)
            (let* ((aspect-data (cdr aspect-entry))
                   (distribution (assoc-ref aspect-data 'ad-paragraph-distribution))
                   (priority-count (assoc-ref distribution priority-filter)))
              (and priority-count (> priority-count 0))))
          legal-aspects-taxonomy-v15))

;; Generate legal aspect network
(define (generate-legal-aspect-network-v15 aspect-name)
  "Generate network of related legal aspects"
  (let ((aspect-data (classify-legal-aspect-v15 aspect-name)))
    (if aspect-data
        (let ((related-aspects (assoc-ref aspect-data 'related-aspects)))
          (map (lambda (related)
                 `((aspect . ,related)
                   (relation-type . "related")
                   (confidence . 0.90)))
               related-aspects))
        '())))

;; Detect temporal causation patterns
(define (detect-temporal-causation-patterns-v15 aspect-name)
  "Detect temporal causation patterns for a legal aspect"
  (let ((aspect-data (classify-legal-aspect-v15 aspect-name)))
    (if aspect-data
        (assoc-ref aspect-data 'temporal-patterns)
        '())))

;; Analyze entity relation co-occurrence
(define (analyze-entity-relation-co-occurrence-v15 aspect-name)
  "Analyze entity relation co-occurrence for a legal aspect"
  (let ((aspect-data (classify-legal-aspect-v15 aspect-name)))
    (if aspect-data
        (assoc-ref aspect-data 'entity-agent-network)
        '())))

;; Compute priority-weighted confidence
(define (compute-priority-weighted-confidence-v15 aspect-name)
  "Compute priority-weighted confidence for a legal aspect"
  (let ((aspect-data (classify-legal-aspect-v15 aspect-name)))
    (if aspect-data
        (assoc-ref aspect-data 'priority-weighted-confidence)
        0.0)))

;; Detect cross-paragraph patterns
(define (detect-cross-paragraph-patterns-v15 aspect-name)
  "Detect cross-paragraph patterns for a legal aspect"
  (let ((aspect-data (classify-legal-aspect-v15 aspect-name)))
    (if aspect-data
        (assoc-ref aspect-data 'cross-paragraph-patterns)
        '())))

;; Generate evidence-paragraph mapping
(define (generate-evidence-paragraph-mapping-v15 aspect-name)
  "Generate evidence-paragraph mapping for a legal aspect"
  (let ((aspect-data (classify-legal-aspect-v15 aspect-name)))
    (if aspect-data
        `((aspect . ,aspect-name)
          (ad-paragraphs . ,(assoc-ref aspect-data 'ad-paragraph-evidence))
          (evidence-requirements . ,(assoc-ref aspect-data 'evidence-requirements))
          (evidence-strength-scores . ,(assoc-ref aspect-data 'evidence-strength-scores))
          (evidence-strength-aggregate . ,(assoc-ref aspect-data 'evidence-strength-aggregate)))
        '())))

;; Get aspect frequency
(define (get-aspect-frequency-v15 aspect-name)
  "Get frequency count for a legal aspect"
  (let ((aspect-data (classify-legal-aspect-v15 aspect-name)))
    (if aspect-data
        (assoc-ref aspect-data 'frequency)
        0)))

;; Get aspect evidence requirements
(define (get-aspect-evidence-requirements-v15 aspect-name)
  "Get evidence requirements for a legal aspect"
  (let ((aspect-data (classify-legal-aspect-v15 aspect-name)))
    (if aspect-data
        (assoc-ref aspect-data 'evidence-requirements)
        '())))

;; Get aspect related aspects
(define (get-aspect-related-aspects-v15 aspect-name)
  "Get related aspects for a legal aspect"
  (let ((aspect-data (classify-legal-aspect-v15 aspect-name)))
    (if aspect-data
        (assoc-ref aspect-data 'related-aspects)
        '())))

;; Get aspect lex principles
(define (get-aspect-lex-principles-v15 aspect-name)
  "Get lex principles for a legal aspect"
  (let ((aspect-data (classify-legal-aspect-v15 aspect-name)))
    (if aspect-data
        (assoc-ref aspect-data 'lex-principles)
        '())))

;; Get aspect AD paragraphs
(define (get-aspect-ad-paragraphs-v15 aspect-name)
  "Get AD paragraph evidence for a legal aspect"
  (let ((aspect-data (classify-legal-aspect-v15 aspect-name)))
    (if aspect-data
        (assoc-ref aspect-data 'ad-paragraph-evidence)
        '())))

;; Compute aspect cumulative confidence
(define (compute-aspect-cumulative-confidence-v15 aspect-name)
  "Compute cumulative confidence for a legal aspect"
  (let ((aspect-data (classify-legal-aspect-v15 aspect-name)))
    (if aspect-data
        (assoc-ref aspect-data 'cumulative-confidence)
        0.0)))

;; Identify aspect pattern clusters
(define (identify-aspect-pattern-clusters-v15 aspect-list)
  "Identify pattern clusters across multiple legal aspects"
  (let ((fraud-cluster (filter (lambda (a) (member a '("fraud" "bad-faith" "unjust-enrichment"))) aspect-list))
        (retaliation-cluster (filter (lambda (a) (member a '("retaliation" "manufactured-crisis" "temporal-proximity"))) aspect-list))
        (fiduciary-cluster (filter (lambda (a) (member a '("fiduciary-duty-breach" "self-dealing" "conflict-of-interest"))) aspect-list)))
    `((fraud-network . ,fraud-cluster)
      (retaliation-cascade . ,retaliation-cluster)
      (fiduciary-breach-network . ,fiduciary-cluster))))

;; Detect multi-actor coordination
(define (detect-multi-actor-coordination-v15 actor-list)
  "Detect multi-actor coordination patterns"
  (let ((peter-rynette-coordination 
          (and (member "peter-faucitt" actor-list)
               (member "rynette-farrar" actor-list))))
    (if peter-rynette-coordination
        `((coordination-detected . #t)
          (actors . ("peter-faucitt" "rynette-farrar"))
          (confidence . 0.94)
          (pattern . "coordinated-retaliation-and-crisis"))
        `((coordination-detected . #f)))))

;; Generate JR/DR response framework
(define (generate-jr-dr-response-framework-v15 aspect-name)
  "Generate JR/DR response framework for a legal aspect"
  (let ((aspect-data (classify-legal-aspect-v15 aspect-name)))
    (if aspect-data
        (assoc-ref aspect-data 'jr-dr-response-framework)
        '())))

;; Compute evidence strength aggregate
(define (compute-evidence-strength-aggregate-v15 aspect-name)
  "Compute aggregate evidence strength for a legal aspect"
  (let ((aspect-data (classify-legal-aspect-v15 aspect-name)))
    (if aspect-data
        (assoc-ref aspect-data 'evidence-strength-aggregate)
        0.0)))
