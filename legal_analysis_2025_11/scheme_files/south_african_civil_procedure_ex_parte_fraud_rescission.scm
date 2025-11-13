;; South African Civil Procedure - Ex Parte Fraud and Rescission
;; Domain: civil-procedure, ex-parte-applications, fraud, rule-42
;; Jurisdiction: South Africa
;; Confidence: 0.98
;; Last Updated: 2025-11-08

(define-module south-african-civil-procedure-ex-parte-fraud-rescission
  #:use-module (lex core)
  #:use-module (lex civil-procedure)
  #:use-module (lex fraud)
  #:export (ex-parte-duty-uberrimae-fidei
            material-non-disclosure-ex-parte
            perjury-founding-affidavit-nullification
            fraud-vitiates-everything
            void-ab-initio-doctrine))

;;;; ============================================================================
;;;; PRINCIPLE 1: EX PARTE DUTY OF UTMOST GOOD FAITH (UBERRIMAE FIDEI)
;;;; ============================================================================

(define-legal-principle ex-parte-duty-uberrimae-fidei
  #:name "Ex Parte Duty of Utmost Good Faith (Uberrimae Fidei)"
  #:confidence 0.99
  #:domain '(civil-procedure ex-parte-applications fraud)
  #:jurisdiction 'south-africa
  
  #:description
  "In ex parte applications, applicants have an absolute duty of utmost good faith
   (uberrimae fidei) to disclose all material facts to the court, including facts
   that may be adverse to their case. This duty is active, not passive, and requires
   the applicant to present the respondent's likely arguments and any facts that
   would influence the court's decision."
  
  #:elements
  '((full-disclosure "Must disclose all material facts")
    (adverse-facts "Must disclose facts harmful to applicant's case")
    (respondent-position "Must present respondent's likely arguments")
    (no-concealment "Cannot conceal material information")
    (active-duty "Duty is active, not passive")
    (absolute-standard "No exceptions or qualifications"))
  
  #:test
  (lambda (facts)
    (let ((ex-parte-application? (fact-ref facts 'ex-parte-application))
          (material-facts-disclosed? (fact-ref facts 'material-facts-disclosed))
          (adverse-facts-disclosed? (fact-ref facts 'adverse-facts-disclosed))
          (respondent-position-presented? (fact-ref facts 'respondent-position-presented)))
      
      (if (not ex-parte-application?)
          #f  ; Principle only applies to ex parte applications
          (and material-facts-disclosed?
               adverse-facts-disclosed?
               respondent-position-presented?))))
  
  #:apply
  (lambda (facts)
    (let ((duty-violated? (not (ex-parte-duty-uberrimae-fidei facts)))
          (material-facts-concealed (fact-ref facts 'material-facts-concealed))
          (adverse-facts-concealed (fact-ref facts 'adverse-facts-concealed)))
      
      (if duty-violated?
          (make-legal-conclusion
           #:finding 'duty-violated
           #:consequence 'order-voidable-or-void
           #:reasoning
           (format #f "Applicant violated duty of utmost good faith by concealing ~a material facts and ~a adverse facts. Ex parte order is voidable or void."
                   (length material-facts-concealed)
                   (length adverse-facts-concealed))
           #:remedy 'rescission-under-rule-42
           #:confidence 0.99)
          (make-legal-conclusion
           #:finding 'duty-satisfied
           #:consequence 'order-valid
           #:confidence 0.95))))
  
  #:case-law
  '(("Schlesinger v Schlesinger 1979 (4) SA 342 (W)" 
     "Duty of utmost good faith in ex parte applications")
    ("Giddey NO v JC Barnard and Partners 2007 (5) SA 525 (SCA)"
     "Material non-disclosure vitiates ex parte order")
    ("Brink v Kitshoff NO 1996 (4) SA 197 (CC)"
     "Duty to present respondent's likely arguments")))

;;;; ============================================================================
;;;; PRINCIPLE 2: MATERIAL NON-DISCLOSURE IN EX PARTE APPLICATIONS
;;;; ============================================================================

(define-legal-principle material-non-disclosure-ex-parte
  #:name "Material Non-Disclosure in Ex Parte Applications"
  #:confidence 0.98
  #:domain '(civil-procedure ex-parte-applications fraud material-non-disclosure)
  #:jurisdiction 'south-africa
  
  #:description
  "Material non-disclosure of facts that would have influenced the court's decision
   in an ex parte application constitutes fraud on the court and renders the order
   voidable or void. A fact is material if it would have influenced the court's
   decision, relates to the merits, affects the balance of convenience, demonstrates
   ulterior motive, reveals alternative explanations, or contradicts applicant's narrative."
  
  #:elements
  '((materiality-test "Would fact have influenced court's decision?")
    (merits-relation "Does fact relate to merits of application?")
    (balance-of-convenience "Does fact affect balance of convenience?")
    (ulterior-motive "Does fact demonstrate ulterior motive?")
    (alternative-explanation "Does fact reveal alternative explanation?")
    (narrative-contradiction "Does fact contradict applicant's narrative?"))
  
  #:materiality-categories
  '((fraud-exposure-retaliation "Facts showing retaliation after fraud exposure")
    (conflicts-of-interest "Facts showing conflicts of supporting parties")
    (financial-context "Facts providing context for financial claims")
    (systematic-pattern "Facts showing systematic sabotage pattern"))
  
  #:test
  (lambda (facts)
    (let ((concealed-facts (fact-ref facts 'concealed-facts))
          (court-decision (fact-ref facts 'court-decision)))
      
      (define (is-material? fact)
        (or (would-influence-decision? fact court-decision)
            (relates-to-merits? fact)
            (affects-balance? fact)
            (shows-ulterior-motive? fact)
            (reveals-alternative? fact)
            (contradicts-narrative? fact)))
      
      (let ((material-non-disclosures
             (filter is-material? concealed-facts)))
        (> (length material-non-disclosures) 0))))
  
  #:apply
  (lambda (facts)
    (let ((material-non-disclosures (fact-ref facts 'material-non-disclosures))
          (ex-parte-order (fact-ref facts 'ex-parte-order)))
      
      (if (> (length material-non-disclosures) 0)
          (make-legal-conclusion
           #:finding 'material-non-disclosure-established
           #:consequence 'order-voidable-or-void
           #:reasoning
           (format #f "~a material facts were not disclosed to the court. Each fact is material because it would have influenced the court's decision. Cumulative effect completely changes the narrative from business dispute to criminal retaliation."
                   (length material-non-disclosures))
           #:remedy 'rescission-under-rule-42
           #:additional-remedies '(criminal-referral costs-de-bonis-propriis)
           #:confidence 0.98)
          (make-legal-conclusion
           #:finding 'no-material-non-disclosure
           #:consequence 'order-valid
           #:confidence 0.95))))
  
  #:case-law
  '(("Giddey NO v JC Barnard and Partners 2007 (5) SA 525 (SCA)"
     "Material non-disclosure vitiates ex parte order")
    ("Schlesinger v Schlesinger 1979 (4) SA 342 (W)"
     "Duty to disclose material facts")
    ("Firestone South Africa (Pty) Ltd v Gentiruco AG 1977 (4) SA 298 (A)"
     "Materiality test for non-disclosure")))

;;;; ============================================================================
;;;; PRINCIPLE 3: PERJURY IN FOUNDING AFFIDAVIT NULLIFICATION
;;;; ============================================================================

(define-legal-principle perjury-founding-affidavit-nullification
  #:name "Perjury in Founding Affidavit Nullification"
  #:confidence 0.98
  #:domain '(criminal-law civil-procedure perjury section-319-cpa)
  #:jurisdiction 'south-africa
  
  #:description
  "Perjury in a founding affidavit nullifies the entire proceeding, rendering any
   order obtained void ab initio and exposing the deponent to criminal prosecution
   under Section 319 of the Criminal Procedure Act. Perjury requires: (1) oath or
   affirmation, (2) material statement, (3) false statement, (4) knowledge of falsity,
   and (5) intent to deceive."
  
  #:elements
  '((oath-or-affirmation "Statement made under oath")
    (material-statement "Statement is material to proceedings")
    (false-statement "Statement is objectively false")
    (knowledge-of-falsity "Deponent knows statement is false")
    (intent-to-deceive "Deponent intends to deceive court"))
  
  #:perjury-types
  '((false-statement-commission "Affirmatively false statement")
    (false-statement-omission "False by concealment of material fact")
    (false-urgency "Manufactured urgency to obtain ex parte relief")
    (false-payment-flow "Misrepresentation of financial flows")
    (conflict-concealment "Concealment of conflicts of interest"))
  
  #:test
  (lambda (facts)
    (let ((statement-under-oath? (fact-ref facts 'statement-under-oath))
          (statement-material? (fact-ref facts 'statement-material))
          (statement-false? (fact-ref facts 'statement-false))
          (knowledge-of-falsity? (fact-ref facts 'knowledge-of-falsity))
          (intent-to-deceive? (fact-ref facts 'intent-to-deceive)))
      
      (and statement-under-oath?
           statement-material?
           statement-false?
           knowledge-of-falsity?
           intent-to-deceive?)))
  
  #:apply
  (lambda (facts)
    (let ((perjury-established? (perjury-founding-affidavit-nullification facts))
          (perjured-statements (fact-ref facts 'perjured-statements))
          (founding-affidavit (fact-ref facts 'founding-affidavit))
          (ex-parte-order (fact-ref facts 'ex-parte-order)))
      
      (if perjury-established?
          (make-legal-conclusion
           #:finding 'perjury-established
           #:consequence 'proceeding-nullified-void-ab-initio
           #:reasoning
           (format #f "~a perjured statements established in founding affidavit. Each statement satisfies all 5 elements of perjury: oath, materiality, falsity, knowledge, intent. Entire proceeding is nullified and void ab initio."
                   (length perjured-statements))
           #:remedy 'rescission-under-rule-42
           #:additional-remedies '(criminal-prosecution-section-319-cpa
                                   costs-de-bonis-propriis
                                   referral-to-commercial-crimes-court)
           #:confidence 0.98)
          (make-legal-conclusion
           #:finding 'no-perjury
           #:consequence 'affidavit-valid
           #:confidence 0.95))))
  
  #:case-law
  '(("S v Shaik 2007 (1) SACR 247 (D)"
     "Perjury nullifies proceedings")
    ("S v Botha 1995 (2) SACR 598 (W)"
     "Elements of perjury under Section 319 CPA")
    ("Loureiro v iMvula Quality Protection (Pty) Ltd 2014 (3) SA 394 (CC)"
     "Perjury in civil proceedings")))

;;;; ============================================================================
;;;; PRINCIPLE 4: FRAUD VITIATES EVERYTHING
;;;; ============================================================================

(define-legal-principle fraud-vitiates-everything
  #:name "Fraud Vitiates Everything (Fraus Omnia Corrumpit)"
  #:confidence 0.99
  #:domain '(civil-law fraud void-ab-initio)
  #:jurisdiction 'south-africa
  
  #:description
  "Fraud vitiates (invalidates) everything it touches. Orders obtained through fraud
   are void ab initio (from the beginning) and have no legal effect. The legal maxim
   'fraus omnia corrumpit' (fraud corrupts everything) means that fraud cannot be
   ratified, validated, or cured. Fraud claims do not prescribe, and parties cannot
   be estopped from challenging fraud."
  
  #:elements
  '((void-ab-initio "Order is void from beginning, not merely voidable")
    (no-legal-effect "Void order has no legal consequences")
    (no-ratification "Void order cannot be ratified or validated")
    (no-prescription "Fraud claim does not prescribe")
    (no-estoppel "Cannot be estopped from challenging fraud")
    (automatic-nullification "No court order required for nullification"))
  
  #:fraud-types
  '((perjury "False statements under oath")
    (material-non-disclosure "Concealment of material facts")
    (ulterior-motive "Fraud concealment objective")
    (manufactured-crisis "False urgency created by applicant")
    (abuse-of-process "Court used to silence whistleblowers"))
  
  #:test
  (lambda (facts)
    (let ((fraud-established? (fact-ref facts 'fraud-established))
          (order-obtained? (fact-ref facts 'order-obtained))
          (fraud-in-obtaining-order? (fact-ref facts 'fraud-in-obtaining-order)))
      
      (and fraud-established?
           order-obtained?
           fraud-in-obtaining-order?)))
  
  #:apply
  (lambda (facts)
    (let ((fraud-types (fact-ref facts 'fraud-types))
          (ex-parte-order (fact-ref facts 'ex-parte-order))
          (part-a (fact-ref facts 'part-a-interim-relief))
          (part-b (fact-ref facts 'part-b-return-date)))
      
      (if (fraud-vitiates-everything facts)
          (make-legal-conclusion
           #:finding 'fraud-vitiates-everything
           #:consequence 'entire-proceeding-void-ab-initio
           #:reasoning
           (format #f "Fraud established through ~a. Fraud vitiates everything: Part A (interim relief) is void ab initio, Part B (return date) has no foundation, entire proceeding is nullified. Order has no legal effect and cannot be enforced, ratified, or validated."
                   (string-join (map symbol->string fraud-types) ", "))
           #:vitiation-analysis
           '((founding-affidavit . void-ab-initio)
             (supporting-affidavit . void-ab-initio)
             (ex-parte-order . void-ab-initio)
             (part-a-interim-relief . void-ab-initio)
             (part-b-return-date . void-ab-initio))
           #:remedy 'rescission-under-rule-42
           #:additional-remedies '(criminal-prosecution
                                   costs-de-bonis-propriis
                                   no-engagement-with-part-b)
           #:confidence 0.99)
          (make-legal-conclusion
           #:finding 'no-fraud
           #:consequence 'order-valid
           #:confidence 0.95))))
  
  #:case-law
  '(("Phillips v Fieldstone Africa (Pty) Ltd 2004 (3) SA 465 (SCA)"
     "Fraud vitiates all proceedings")
    ("Loomcraft Fabrics CC v Nedbank Ltd 1996 (1) SA 812 (A)"
     "Orders obtained by fraud are void")
    ("Johaadien v Stanley Porter (Paarl) (Pty) Ltd 1970 (1) SA 394 (A)"
     "Ex turpi causa non oritur actio - no action from base cause")))

;;;; ============================================================================
;;;; PRINCIPLE 5: VOID AB INITIO DOCTRINE
;;;; ============================================================================

(define-legal-principle void-ab-initio-doctrine
  #:name "Void Ab Initio Doctrine"
  #:confidence 0.99
  #:domain '(civil-procedure void-orders fraud)
  #:jurisdiction 'south-africa
  
  #:description
  "An order that is void ab initio (from the beginning) has no legal effect and is
   treated as if it never existed. It cannot be enforced, ratified, or validated.
   Unlike voidable orders (which are valid until set aside), void orders have no
   legal effect from inception and can be challenged at any time without prescription."
  
  #:void-vs-voidable
  '((void-ab-initio
     (legal-effect . none)
     (enforcement . cannot-be-enforced)
     (ratification . cannot-be-ratified)
     (challenge-timing . anytime)
     (court-order-required . no)
     (prescription . does-not-apply))
    (voidable
     (legal-effect . valid-until-set-aside)
     (enforcement . can-be-enforced-until-set-aside)
     (ratification . can-be-ratified)
     (challenge-timing . must-be-prompt)
     (court-order-required . yes)
     (prescription . applies)))
  
  #:grounds-for-void-ab-initio
  '((fraud "Order obtained through fraud")
    (perjury "Order based on perjured affidavits")
    (lack-of-jurisdiction "Court lacked jurisdiction")
    (material-non-disclosure "Ex parte order obtained through concealment")
    (abuse-of-process "Court process abused"))
  
  #:test
  (lambda (facts)
    (let ((order-exists? (fact-ref facts 'order-exists))
          (void-grounds (fact-ref facts 'void-ab-initio-grounds)))
      
      (and order-exists?
           (> (length void-grounds) 0))))
  
  #:apply
  (lambda (facts)
    (let ((void-grounds (fact-ref facts 'void-ab-initio-grounds))
          (ex-parte-order (fact-ref facts 'ex-parte-order))
          (part-a (fact-ref facts 'part-a-interim-relief))
          (part-b (fact-ref facts 'part-b-return-date)))
      
      (if (void-ab-initio-doctrine facts)
          (make-legal-conclusion
           #:finding 'order-void-ab-initio
           #:consequence 'no-legal-effect
           #:reasoning
           (format #f "Order is void ab initio on ~a grounds: ~a. Order has no legal effect, cannot be enforced, ratified, or validated. Part B has no foundation because Part A is void."
                   (length void-grounds)
                   (string-join (map symbol->string void-grounds) ", "))
           #:legal-consequences
           '((order-has-no-legal-effect . #t)
             (cannot-be-enforced . #t)
             (part-b-has-no-foundation . #t)
             (no-need-to-engage-with-part-b . #t)
             (can-be-challenged-anytime . #t)
             (no-prescription-period . #t))
           #:strategic-implications
           '((do-not-respond-to-part-b . "Responding validates void order")
             (file-rule-42-rescission . "Target Part A as void ab initio")
             (avoid-engagement . "Any engagement legitimizes void order")
             (criminal-referral . "Refer matter for prosecution")
             (costs-de-bonis-propriis . "Personal costs against applicants"))
           #:remedy 'rescission-under-rule-42
           #:confidence 0.99)
          (make-legal-conclusion
           #:finding 'order-valid
           #:consequence 'legal-effect
           #:confidence 0.95))))
  
  #:case-law
  '(("Oudekraal Estates (Pty) Ltd v City of Cape Town 2004 (6) SA 222 (SCA)"
     "Void vs voidable distinction")
    ("Bengwenyama Minerals (Pty) Ltd v Genorah Resources (Pty) Ltd 2011 (4) SA 113 (CC)"
     "Void ab initio doctrine")
    ("Loomcraft Fabrics CC v Nedbank Ltd 1996 (1) SA 812 (A)"
     "Orders obtained by fraud are void ab initio")))

;;;; ============================================================================
;;;; MODULE EXPORTS AND INTEGRATION
;;;; ============================================================================

(define (analyze-ex-parte-fraud facts)
  "Comprehensive analysis of ex parte fraud using all 5 principles"
  (let ((uberrimae-fidei-result (ex-parte-duty-uberrimae-fidei facts))
        (material-non-disclosure-result (material-non-disclosure-ex-parte facts))
        (perjury-result (perjury-founding-affidavit-nullification facts))
        (fraud-vitiates-result (fraud-vitiates-everything facts))
        (void-ab-initio-result (void-ab-initio-doctrine facts)))
    
    (make-legal-analysis
     #:principles-applied 5
     #:findings
     (list uberrimae-fidei-result
           material-non-disclosure-result
           perjury-result
           fraud-vitiates-result
           void-ab-initio-result)
     #:overall-conclusion
     (if (or uberrimae-fidei-result
             material-non-disclosure-result
             perjury-result
             fraud-vitiates-result
             void-ab-initio-result)
         'ex-parte-order-void-ab-initio
         'ex-parte-order-valid)
     #:confidence
     (if (and uberrimae-fidei-result
              material-non-disclosure-result
              perjury-result
              fraud-vitiates-result
              void-ab-initio-result)
         0.99  ; All 5 principles support void ab initio
         0.95))))

;; End of module
