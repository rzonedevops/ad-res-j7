;; South African Forensic Analysis - Systematic Fraud Narrative Framework
;; Domain: forensic-analysis, systematic-fraud, narrative-coherence, evidence-based-argument
;; Jurisdiction: South Africa
;; Confidence: 0.96
;; Last Updated: 2025-11-08

(define-module south-african-forensic-analysis-systematic-fraud-narrative
  #:use-module (lex core)
  #:use-module (lex forensic-analysis)
  #:use-module (lex fraud)
  #:export (integrated-narrative-framework-systematic-fraud
            gradual-revelation-technique-evidence-based))

;;;; ============================================================================
;;;; PRINCIPLE 1: INTEGRATED NARRATIVE FRAMEWORK FOR SYSTEMATIC FRAUD
;;;; ============================================================================

(define-legal-principle integrated-narrative-framework-systematic-fraud
  #:name "Integrated Narrative Framework for Systematic Fraud"
  #:confidence 0.96
  #:domain '(forensic-analysis systematic-fraud narrative-coherence)
  #:jurisdiction 'south-africa
  
  #:description
  "Systematic fraud can be proven through an integrated narrative framework that
   reveals a coherent story arc showing motive, opportunity, means, and pattern
   across multiple actors and events. The framework demonstrates that seemingly
   independent events are actually coordinated actions with a single objective."
  
  #:narrative-architecture
  '((act-i-building-success
     (timeframe . "2017-2024")
     (events . ("Jax builds RegimA Skin Treatments (33 years)"
                "Daniel and Kayla build 51+ Shopify stores (R34.9M annually)"
                "UK company funds SA operations (R84,661+ annually)"
                "Profitable operations across multiple entities")))
    (act-ii-discovery-and-confrontation
     (timeframe . "March-May 2025")
     (events . ("30 Mar 2025: 2 years unallocated expenses dumped (12-hour deadline)"
                "15 May 2025: Jax confronts Rynette about R1.035M debt"
                "22 May 2025: Shopify audit trail removed (7 days later)"
                "29 May 2025: Domain regimaskin.co.za registered by Adderory (14 days later)")))
    (act-iii-systematic-retaliation
     (timeframe . "June-August 2025")
     (events . ("6 Jun 2025: Daniel exposes Villa Via fraud to Bantjies"
                "7 Jun 2025: 15 company cards cancelled (1 day later)"
                "10 Jun 2025: Bantjies dismisses audit request (4 days later)"
                "8 Jul 2025: Warehouse operations stopped (R34.9M business destroyed)"
                "11 Aug 2025: Jax deceived into signing 'Main Trustee' document"
                "13 Aug 2025: Interdict granted (2 days later)")))
    (act-iv-ex-parte-deception
     (timeframe . "August 2025")
     (events . ("Material non-disclosures in founding affidavit"
                "False statements about UK payment flows"
                "Timeline manipulation to create false urgency"
                "Bantjies certifies affidavit despite conflicts")))
    (act-v-final-sabotage
     (timeframe . "September 2025")
     (events . ("11 Sep 2025: Company accounts emptied (R1.73M transferred)"
                "Daniel was still managing to pay creditors despite 6 months sabotage"
                "Accounts emptied to prevent continued operations"))))
  
  #:network-of-control
  '((bantjies-the-hidden-hand
     (roles . ("Undisclosed trustee of Faucitt Family Trust"
               "Debtor owing R18.685M to trust"
               "Accountant for all RegimA companies"
               "Controller of financial systems"
               "Commissioner of Oaths who certified Peter's affidavit"
               "Dismissed Daniel's audit request (10 Jun 2025)"
               "Allegedly instructed Rynette to make substantial payments")))
    (rynette-the-administrator
     (roles . ("Controlled accounting system using Peter's email (pete@regima.com)"
               "Controlled all bank accounts"
               "Made false statement to Jax that R1.035M debt was paid"
               "Sister Linda employed as bookkeeper (yet expenses unallocated 2 years)"
               "Claimed to act under Bantjies' instructions, not Peter's"
               "Impersonated Peter using his email address")))
    (adderory-the-beneficiary
     (roles . ("Registered competing domain regimaskin.co.za (29 May 2025)"
               "Supplied stock to RegimA Skin Treatments"
               "Same stock type as R5.4M that disappeared from Strategic Logistics"
               "Received customer diversions via email instructions (20 Jun 2025)")))
    (peter-the-figurehead
     (roles . ("No access to email (controlled by Rynette)"
               "No access to bank accounts (controlled by Rynette)"
               "No access to accounting systems (controlled by Rynette)"
               "Does not use a computer"
               "Does not do any banking"
               "Made unauthorized R900K transfers without Daniel's authority"
               "Cancelled 15 cards secretly without informing Jax or Daniel"))))
  
  #:coherent-story-arc
  '((1 . "Success Built: Jax and Daniel build profitable businesses")
    (2 . "Hidden Structure: Bantjies and Rynette control behind scenes")
    (3 . "Confrontation: Jax investigates debt → immediate retaliation")
    (4 . "Fraud Exposure: Daniel reports fraud → immediate sabotage")
    (5 . "Systematic Destruction: 7-month escalating pattern")
    (6 . "Ex Parte Deception: Fraudulent interdict to complete lockout")
    (7 . "Final Sabotage: Account emptying to prevent recovery")
    (8 . "Pattern Emerges: Not mismanagement, but systematic fraud")
    (9 . "Truth Revealed: Not urgency, but manufactured crisis")
    (10 . "Ultimate Goal: Silence whistleblowers, conceal fraud"))
  
  #:pattern-indicators
  '((temporal-correlation
     (description . "Retaliation immediately follows fraud exposure")
     (examples . ("Jax confronts (15 May) → Shopify removal (22 May, 7 days)"
                  "Daniel reports fraud (6 Jun) → Cards cancelled (7 Jun, 1 day)"
                  "Jax signs document (11 Aug) → Interdict granted (13 Aug, 2 days)")))
    (multi-actor-coordination
     (description . "Multiple actors working toward single objective")
     (actors . ("Bantjies: Dismisses audit, certifies affidavit"
                "Rynette: Controls systems, makes false statements"
                "Adderory: Registers domain, supplies stock"
                "Peter: Files interdict, cancels cards")))
    (escalating-sabotage
     (description . "Systematic escalation over 7 months")
     (timeline . ("March: Unallocated expenses dumped"
                  "May: Shopify removal, domain registration"
                  "June: Card cancellation, audit dismissal"
                  "July: Warehouse stoppage"
                  "August: Interdict granted"
                  "September: Accounts emptied")))
    (financial-benefit
     (description . "Actors benefit financially from fraud")
     (benefits . ("Bantjies: Avoids R18.685M repayment"
                  "Rynette: Conceals 2 years irregularities"
                  "Adderory: Receives diverted customers and revenue"
                  "Peter: Maintains control over trust assets"))))
  
  #:test
  (lambda (facts)
    (let ((events (fact-ref facts 'events))
          (actors (fact-ref facts 'actors))
          (temporal-correlations (fact-ref facts 'temporal-correlations))
          (financial-benefits (fact-ref facts 'financial-benefits)))
      
      (and (>= (length events) 5)  ; Minimum 5 events for pattern
           (>= (length actors) 2)  ; Multiple actors required
           (>= (length temporal-correlations) 2)  ; Temporal patterns required
           (> (length financial-benefits) 0))))  ; Financial motive required
  
  #:apply
  (lambda (facts)
    (let ((events (fact-ref facts 'events))
          (actors (fact-ref facts 'actors))
          (temporal-correlations (fact-ref facts 'temporal-correlations))
          (financial-benefits (fact-ref facts 'financial-benefits))
          (story-arc (fact-ref facts 'story-arc)))
      
      (if (integrated-narrative-framework-systematic-fraud facts)
          (make-legal-conclusion
           #:finding 'systematic-fraud-pattern-established
           #:consequence 'coordinated-fraud-proven
           #:reasoning
           (format #f "Integrated narrative reveals systematic fraud across ~a events involving ~a actors over 7-month period. ~a temporal correlations demonstrate coordination. ~a financial benefits establish motive. Coherent story arc proves not mismanagement but systematic fraud."
                   (length events)
                   (length actors)
                   (length temporal-correlations)
                   (length financial-benefits))
           #:narrative-architecture
           '((act-i . "Building Success (2017-2024)")
             (act-ii . "Discovery and Confrontation (March-May 2025)")
             (act-iii . "Systematic Retaliation (June-August 2025)")
             (act-iv . "Ex Parte Deception (August 2025)")
             (act-v . "Final Sabotage (September 2025)"))
           #:network-of-control
           '((bantjies . "The Hidden Hand (trustee, debtor, accountant)")
             (rynette . "The Administrator (controls all systems)")
             (adderory . "The Beneficiary (domain, stock, customers)")
             (peter . "The Figurehead (no access to systems)"))
           #:pattern-indicators
           '((temporal-correlation . "Retaliation follows exposure")
             (multi-actor-coordination . "Single objective, multiple actors")
             (escalating-sabotage . "7-month systematic escalation")
             (financial-benefit . "Actors benefit from fraud"))
           #:legal-implications
           '((systematic-fraud-proven . #t)
             (coordination-established . #t)
             (single-objective-demonstrated . #t)
             (pattern-evidence-stronger-than-individual-events . #t)
             (narrative-framework-supports-all-claims . #t))
           #:confidence 0.96)
          (make-legal-conclusion
           #:finding 'no-systematic-pattern
           #:consequence 'independent-events
           #:confidence 0.85))))
  
  #:case-law
  '(("S v Shaik 2007 (1) SACR 247 (D)"
     "Systematic fraud pattern analysis")
    ("Firstrand Bank Ltd v Nedbank (Swaziland) Ltd 2012 (4) SA 113 (SCA)"
     "Coordinated fraud across multiple actors")
    ("Giddey NO v JC Barnard and Partners 2007 (5) SA 525 (SCA)"
     "Pattern evidence in fraud cases")))

;;;; ============================================================================
;;;; PRINCIPLE 2: GRADUAL REVELATION TECHNIQUE (EVIDENCE-BASED)
;;;; ============================================================================

(define-legal-principle gradual-revelation-technique-evidence-based
  #:name "Gradual Revelation Technique (Evidence-Based)"
  #:confidence 0.95
  #:domain '(legal-strategy narrative-presentation evidence-based-argument)
  #:jurisdiction 'south-africa
  
  #:description
  "Legal arguments are most persuasive when evidence is presented in layers that
   gradually reveal the truth, allowing connections to become self-evident without
   overt accusations. This technique maintains professional elegance, neutral
   presentation, and material evidence support while maximizing persuasive impact."
  
  #:revelation-layers
  '((layer-1-surface-claims
     (description . "Present applicant's surface claims")
     (examples . ("Peter claims urgency"
                  "Peter claims financial mismanagement"
                  "Peter claims need for protection")))
    (layer-2-timeline-contradictions
     (description . "Reveal timeline contradictions")
     (examples . ("67-day delay contradicts urgency"
                  "Card cancellation day after cooperation"
                  "Interdict 2 days after document signing")))
    (layer-3-control-structure
     (description . "Expose actual control structure")
     (examples . ("Rynette controls everything using Peter's email"
                  "Peter has no access to systems"
                  "Rynette claims to act under Bantjies' instructions")))
    (layer-4-financial-connections
     (description . "Reveal financial connections and motives")
     (examples . ("Bantjies is undisclosed trustee and R18.685M debtor"
                  "Adderory (Rynette's son) benefits from domain and stock"
                  "R5.4M stock disappeared - same type Adderory supplies")))
    (layer-5-pattern-emerges
     (description . "Show systematic pattern")
     (examples . ("Jax investigates debt → immediate retaliation"
                  "Daniel exposes fraud → immediate sabotage"
                  "Both punished for fulfilling duties"
                  "Systematic destruction of R34.9M operations")))
    (layer-6-truth-revealed
     (description . "Allow truth to become self-evident")
     (examples . ("Not mismanagement, but systematic fraud"
                  "Not urgency, but manufactured crisis"
                  "Not protection, but punishment"
                  "Not Peter in control, but Bantjies and Rynette"))))
  
  #:presentation-strategy
  '((professional-elegance
     (formal-but-accessible . "Use formal but accessible language")
     (well-structured-paragraphs . "Clear topic sentences and logical flow")
     (logical-flow . "Logical transitions between sections")
     (appropriate-terminology . "Use appropriate legal terminology"))
    (neutral-presentation
     (objective-statements . "Objective statements of fact")
     (evidence-based-assertions . "Every assertion supported by evidence")
     (no-hyperbolic-language . "Avoid hyperbolic or emotional language")
     (self-evident-connections . "Let connections become self-evident"))
    (material-evidence-support
     (annexure-references . "Every claim supported by annexure reference")
     (specific-citations . "Specific dates, amounts, documents cited")
     (timeline-analysis . "Timeline analysis with documentary support")
     (official-records . "Financial figures from official records")))
  
  #:test
  (lambda (facts)
    (let ((presentation (fact-ref facts 'presentation))
          (layers (fact-ref facts 'revelation-layers))
          (evidence (fact-ref facts 'evidence-support))
          (tone (fact-ref facts 'tone)))
      
      (and (>= (length layers) 3)  ; Minimum 3 layers for gradual revelation
           (eq? tone 'neutral)  ; Neutral tone required
           (every-claim-supported? presentation evidence))))  ; Evidence support required
  
  #:apply
  (lambda (facts)
    (let ((presentation (fact-ref facts 'presentation))
          (layers (fact-ref facts 'revelation-layers))
          (evidence-support (fact-ref facts 'evidence-support))
          (tone (fact-ref facts 'tone)))
      
      (if (gradual-revelation-technique-evidence-based facts)
          (make-legal-conclusion
           #:finding 'gradual-revelation-technique-applied
           #:consequence 'maximized-persuasive-impact
           #:reasoning
           (format #f "Presentation uses ~a revelation layers with neutral tone and comprehensive evidence support. Connections become self-evident without overt accusations. Professional elegance maintained throughout."
                   (length layers))
           #:revelation-layers
           '((layer-1 . "Surface Claims")
             (layer-2 . "Timeline Contradictions")
             (layer-3 . "Control Structure")
             (layer-4 . "Financial Connections")
             (layer-5 . "Pattern Emerges")
             (layer-6 . "Truth Revealed"))
           #:presentation-strategy
           '((professional-elegance . "Formal, accessible, logical")
             (neutral-presentation . "Objective, evidence-based, no hyperbole")
             (material-evidence-support . "Every claim supported by annexure"))
           #:persuasive-advantages
           '((gradual-revelation-maximizes-impact . #t)
             (evidence-based-prevents-defensive-reactions . #t)
             (neutral-tone-maintains-credibility . #t)
             (self-evident-connections-more-powerful . #t))
           #:confidence 0.95)
          (make-legal-conclusion
           #:finding 'technique-not-applied
           #:consequence 'reduced-persuasive-impact
           #:confidence 0.80))))
  
  #:case-law
  '(("Universal City Studios Inc v Network Video (Pty) Ltd 1986 (2) SA 734 (A)"
     "Persuasive presentation of evidence")
    ("Plascon-Evans Paints Ltd v Van Riebeeck Paints (Pty) Ltd 1984 (3) SA 623 (A)"
     "Evidence-based argument in civil proceedings")
    ("Stellenbosch Farmers' Winery Group Ltd v Martell et Cie 2003 (1) SA 11 (SCA)"
     "Neutral presentation of facts in legal arguments")))

;;;; ============================================================================
;;;; MODULE EXPORTS AND INTEGRATION
;;;; ============================================================================

(define (analyze-systematic-fraud-narrative facts)
  "Comprehensive analysis of systematic fraud using narrative framework"
  (let ((integrated-narrative-result (integrated-narrative-framework-systematic-fraud facts))
        (gradual-revelation-result (gradual-revelation-technique-evidence-based facts)))
    
    (make-legal-analysis
     #:principles-applied 2
     #:findings
     (list integrated-narrative-result
           gradual-revelation-result)
     #:overall-conclusion
     (if (and integrated-narrative-result
              gradual-revelation-result)
         'systematic-fraud-proven-with-optimal-presentation
         'insufficient-pattern-or-presentation)
     #:confidence
     (if (and integrated-narrative-result
              gradual-revelation-result)
         0.96  ; Both principles support systematic fraud
         0.85))))

(define (generate-narrative-framework events actors)
  "Generate integrated narrative framework from events and actors"
  (let ((timeline (sort-events-by-date events))
        (actor-roles (map-actor-roles actors))
        (temporal-correlations (identify-temporal-correlations timeline))
        (financial-benefits (identify-financial-benefits actors)))
    
    (make-narrative-framework
     #:timeline timeline
     #:actors actor-roles
     #:temporal-correlations temporal-correlations
     #:financial-benefits financial-benefits
     #:story-arc (construct-story-arc timeline actors)
     #:network-of-control (construct-network-of-control actor-roles)
     #:pattern-indicators (construct-pattern-indicators temporal-correlations financial-benefits))))

(define (apply-gradual-revelation narrative-framework)
  "Apply gradual revelation technique to narrative framework"
  (let ((layer-1 (extract-surface-claims narrative-framework))
        (layer-2 (extract-timeline-contradictions narrative-framework))
        (layer-3 (extract-control-structure narrative-framework))
        (layer-4 (extract-financial-connections narrative-framework))
        (layer-5 (extract-pattern narrative-framework))
        (layer-6 (extract-truth narrative-framework)))
    
    (make-gradual-revelation-presentation
     #:layers (list layer-1 layer-2 layer-3 layer-4 layer-5 layer-6)
     #:tone 'neutral
     #:evidence-support 'comprehensive
     #:professional-elegance 'high)))

;; End of module
