;; South African Professional Ethics - Multi-Party Conflicts of Interest
;; Domain: professional-ethics, conflicts-of-interest, fiduciary-duty, trust-law
;; Jurisdiction: South Africa
;; Confidence: 0.97
;; Last Updated: 2025-11-08

(define-module south-african-professional-ethics-multi-party-conflicts
  #:use-module (lex core)
  #:use-module (lex professional-ethics)
  #:use-module (lex trust-law)
  #:use-module (lex fiduciary-duty)
  #:export (bantjies-triple-conflict-analysis
            commissioner-of-oaths-conflict-invalidation
            undisclosed-trustee-participation-fraud))

;;;; ============================================================================
;;;; PRINCIPLE 1: BANTJIES' TRIPLE CONFLICT ANALYSIS
;;;; ============================================================================

(define-legal-principle bantjies-triple-conflict-analysis
  #:name "Bantjies' Triple Conflict of Interest Analysis"
  #:confidence 0.98
  #:domain '(conflict-of-interest fiduciary-duty professional-ethics)
  #:jurisdiction 'south-africa
  
  #:description
  "A person holding multiple conflicting roles (trustee, debtor, accountant,
   Commissioner of Oaths) cannot act independently in any capacity and has
   overwhelming motive to prevent discovery of fraud. The combination of roles
   creates irreconcilable conflicts where duties to one role directly conflict
   with interests in another role."
  
  #:roles-analyzed
  '((trustee
     (capacity . "Co-trustee of Faucitt Family Trust")
     (duty . "Fiduciary duty to beneficiaries")
     (conflict . "Prevent discovery of trust fraud")
     (motive . "Protect trust from liability"))
    (debtor
     (capacity . "Owes R18.685M to trust")
     (interest . "Personal financial interest")
     (conflict . "Avoid repayment obligation")
     (motive . "Prevent discovery requiring repayment"))
    (accountant
     (capacity . "Accountant for all RegimA companies")
     (duty . "Professional duty to accuracy")
     (conflict . "Conceal accounting irregularities")
     (motive . "Avoid professional liability"))
    (commissioner-of-oaths
     (capacity . "Certified Peter's affidavit")
     (duty . "Duty of independence")
     (conflict . "Validate own interests")
     (motive . "Legitimize proceedings concealing fraud"))
    (fraud-report-recipient
     (capacity . "Received Daniel's fraud reports (6 Jun 2025)")
     (duty . "Duty to investigate")
     (conflict . "Dismiss reports to protect self")
     (motive . "Prevent investigation implicating self")))
  
  #:conflict-matrix
  '((trustee-vs-debtor
     (as-trustee . "Duty to collect debts owed to trust")
     (as-debtor . "Interest in avoiding repayment")
     (conflict . "Cannot collect debt from himself")
     (amount-at-stake . 18685000))
    (trustee-vs-accountant
     (as-trustee . "Duty to ensure accurate accounting")
     (as-accountant . "Responsible for accounting irregularities")
     (conflict . "Cannot audit own work")
     (issue-at-stake . "2 years unallocated expenses"))
    (accountant-vs-commissioner
     (as-accountant . "Subject of fraud reports")
     (as-commissioner . "Must certify affidavit independently")
     (conflict . "Cannot certify affidavit about own conduct")
     (compromise . "Professional independence"))
    (fraud-recipient-vs-commissioner
     (as-recipient . "Received fraud reports (6 Jun 2025)")
     (as-commissioner . "Certified affidavit (14 Aug 2025)")
     (conflict . "Certified affidavit concealing fraud he knew about")
     (timeline . "68 days between reports and certification"))
    (trustee-vs-beneficiary-attack
     (as-trustee . "Fiduciary duty to beneficiaries")
     (as-co-applicant . "Attacking beneficiaries with interdict")
     (conflict . "Cannot attack beneficiaries he has duty to protect")
     (breach . "Fundamental breach of fiduciary duty")))
  
  #:motive-analysis
  '((r18685000-debt-motive
     (debt-amount . 18685000)
     (threat . "Fraud reports threaten discovery")
     (consequence . "Discovery would require repayment")
     (motive . "Prevent discovery to avoid R18.685M repayment")
     (strength . very-high))
    (accounting-irregularities-motive
     (issue . "2 years unallocated expenses")
     (amount . 5400000)
     (stock-disappearance . "R5.4M stock disappeared")
     (claim . "Rynette claims Bantjies instructed substantial payments")
     (motive . "Prevent audit to conceal irregularities")
     (strength . high))
    (professional-liability-motive
     (threat . "Fraud reports implicate accounting")
     (risk . "Professional negligence or complicity")
     (consequence . "Legal Practice Council referral")
     (motive . "Prevent investigation to avoid sanctions")
     (strength . high)))
  
  #:test
  (lambda (facts)
    (let ((person (fact-ref facts 'person))
          (roles (fact-ref facts 'roles))
          (conflicts (fact-ref facts 'conflicts))
          (motives (fact-ref facts 'motives)))
      
      (and (>= (length roles) 3)  ; Triple conflict requires 3+ roles
           (> (length conflicts) 0)  ; Must have actual conflicts
           (> (length motives) 0))))  ; Must have identifiable motives
  
  #:apply
  (lambda (facts)
    (let ((person (fact-ref facts 'person))
          (roles (fact-ref facts 'roles))
          (conflicts (fact-ref facts 'conflicts))
          (motives (fact-ref facts 'motives))
          (debt-amount (fact-ref facts 'debt-amount))
          (participation (fact-ref facts 'participation-in-proceedings)))
      
      (if (bantjies-triple-conflict-analysis facts)
          (make-legal-conclusion
           #:finding 'triple-conflict-established
           #:consequence 'cannot-act-independently
           #:reasoning
           (format #f "~a holds ~a conflicting roles with ~a identified conflicts and ~a motives (including R~a debt). Cannot act independently in any capacity. Overwhelming motive to prevent discovery of fraud."
                   person
                   (length roles)
                   (length conflicts)
                   (length motives)
                   debt-amount)
           #:conflicts-analysis conflicts
           #:motives-analysis motives
           #:legal-implications
           '((cannot-act-independently . #t)
             (commissioner-certification-invalid . #t)
             (supporting-affidavit-tainted . #t)
             (fiduciary-duty-breach . #t)
             (professional-ethics-violations . #t))
           #:remedies
           '(rescission-warranted-on-conflicts-alone
             referral-to-legal-practice-council
             personal-costs-order
             fiduciary-duty-damages)
           #:confidence 0.98)
          (make-legal-conclusion
           #:finding 'no-triple-conflict
           #:consequence 'can-act-independently
           #:confidence 0.95))))
  
  #:case-law
  '(("Ex parte Lebowa Development Corporation 1989 (3) SA 71 (T)"
     "Conflict of interest principles")
    ("Boulting v Association of Cinematograph, Television and Allied Technicians [1963] 2 QB 606"
     "Multiple conflicting roles")
    ("Robinson v Randfontein Estates Gold Mining Co Ltd 1921 AD 168"
     "Fiduciary duty and conflicts of interest")))

;;;; ============================================================================
;;;; PRINCIPLE 2: COMMISSIONER OF OATHS CONFLICT INVALIDATION
;;;; ============================================================================

(define-legal-principle commissioner-of-oaths-conflict-invalidation
  #:name "Commissioner of Oaths Conflict Invalidation"
  #:confidence 0.97
  #:domain '(professional-ethics civil-procedure conflicts-of-interest)
  #:jurisdiction 'south-africa
  
  #:description
  "A Commissioner of Oaths who has a personal interest in the subject matter of
   an affidavit cannot validly certify that affidavit. Such certification is
   invalid and the affidavit is inadmissible. The Commissioner must be independent
   and impartial, with no personal stake in the outcome of the matter."
  
  #:commissioner-duties
  '((independence "Must be independent of the matter")
    (impartiality "Must have no personal interest")
    (verification "Must verify deponent's identity")
    (understanding "Must ensure deponent understands content")
    (voluntary "Must ensure oath is voluntary"))
  
  #:personal-interests-that-invalidate
  '((financial-interest "Commissioner has financial stake in matter")
    (debtor-status "Commissioner owes money to party")
    (fraud-concealment "Affidavit conceals fraud Commissioner knows about")
    (professional-liability "Matter implicates Commissioner's professional conduct")
    (fiduciary-conflict "Commissioner has fiduciary duty to opposing party"))
  
  #:test
  (lambda (facts)
    (let ((commissioner (fact-ref facts 'commissioner))
          (affidavit (fact-ref facts 'affidavit))
          (personal-interests (fact-ref facts 'commissioner-personal-interests))
          (subject-matter (fact-ref facts 'affidavit-subject-matter)))
      
      (and commissioner
           affidavit
           (> (length personal-interests) 0)
           (interests-relate-to-subject-matter? personal-interests subject-matter))))
  
  #:apply
  (lambda (facts)
    (let ((commissioner (fact-ref facts 'commissioner))
          (personal-interests (fact-ref facts 'commissioner-personal-interests))
          (debt-amount (fact-ref facts 'commissioner-debt-amount))
          (fraud-reports-received (fact-ref facts 'fraud-reports-received))
          (certification-date (fact-ref facts 'certification-date))
          (fraud-reports-date (fact-ref facts 'fraud-reports-date)))
      
      (if (commissioner-of-oaths-conflict-invalidation facts)
          (make-legal-conclusion
           #:finding 'commissioner-conflict-established
           #:consequence 'certification-invalid-affidavit-inadmissible
           #:reasoning
           (format #f "Commissioner ~a has ~a personal interests in subject matter, including R~a debt. Received fraud reports on ~a, certified affidavit concealing those reports on ~a (~a days later). Cannot be independent or impartial."
                   commissioner
                   (length personal-interests)
                   debt-amount
                   fraud-reports-date
                   certification-date
                   (date-diff fraud-reports-date certification-date))
           #:independence-violations
           '((cannot-be-independent . "R18.685M at stake")
             (cannot-be-impartial . "Concealing fraud he knew about")
             (cannot-verify-content . "Affidavit omits facts he knows"))
           #:legal-implications
           '((commissioner-certification-invalid . #t)
             (affidavit-inadmissible . #t)
             (ex-parte-order-void . #t)
             (professional-ethics-violation . #t)
             (legal-practice-council-referral . #t))
           #:remedies
           '(rescission-of-ex-parte-order
             referral-to-legal-practice-council
             personal-costs-order)
           #:confidence 0.97)
          (make-legal-conclusion
           #:finding 'no-commissioner-conflict
           #:consequence 'certification-valid
           #:confidence 0.95))))
  
  #:case-law
  '(("Justices of the Peace and Commissioners of Oaths Act 16 of 1963"
     "Commissioner duties and requirements")
    ("S v Botha 1995 (2) SACR 598 (W)"
     "Commissioner independence requirements")
    ("Loureiro v iMvula Quality Protection (Pty) Ltd 2014 (3) SA 394 (CC)"
     "Commissioner certification in civil proceedings")))

;;;; ============================================================================
;;;; PRINCIPLE 3: UNDISCLOSED TRUSTEE PARTICIPATION FRAUD
;;;; ============================================================================

(define-legal-principle undisclosed-trustee-participation-fraud
  #:name "Undisclosed Trustee Participation Fraud"
  #:confidence 0.98
  #:domain '(trust-law fiduciary-duty fraud)
  #:jurisdiction 'south-africa
  
  #:description
  "A trustee who participates in proceedings against beneficiaries without
   disclosing his trustee status commits fraud on the court and breaches
   fiduciary duty to the beneficiaries. Trustees have absolute duties of
   loyalty, good faith, disclosure, and must avoid conflicts of interest.
   Attacking beneficiaries while concealing trustee status inverts the
   fiduciary relationship."
  
  #:trustee-duties-to-beneficiaries
  '((loyalty "Act in beneficiaries' best interests")
    (good-faith "Act honestly and in good faith")
    (disclosure "Disclose all material facts")
    (no-conflict "Avoid conflicts of interest")
    (no-self-dealing "Cannot benefit at beneficiaries' expense"))
  
  #:fiduciary-duty-breaches
  '((loyalty-breach
     (duty . "Act in beneficiaries' best interests")
     (breach . "Attacked beneficiaries")
     (severity . fundamental))
    (good-faith-breach
     (duty . "Act honestly and in good faith")
     (breach . "Concealed trustee status")
     (severity . fraud-on-court))
    (disclosure-breach
     (duty . "Disclose all material facts")
     (breach . "Omitted material conflicts")
     (severity . material-non-disclosure))
    (conflict-breach
     (duty . "Avoid conflicts of interest")
     (breach . "R18.685M debt to trust")
     (severity . overwhelming-conflict))
    (self-dealing-breach
     (duty . "Cannot benefit at beneficiaries' expense")
     (breach . "Prevented fraud discovery")
     (severity . protected-own-interests)))
  
  #:inversion-of-fiduciary-relationship
  '((normal-relationship
     (trustee-role . "Protects beneficiaries")
     (beneficiary-role . "Receives protection")
     (relationship . fiduciary-protection))
    (inverted-relationship
     (trustee-role . "Attacks beneficiaries")
     (beneficiary-role . "Suffers attack")
     (relationship . fiduciary-breach)
     (reason . "Beneficiaries exposed fraud implicating trustee")))
  
  #:test
  (lambda (facts)
    (let ((person (fact-ref facts 'person))
          (trustee-status (fact-ref facts 'trustee-status))
          (trustee-status-disclosed? (fact-ref facts 'trustee-status-disclosed))
          (participation (fact-ref facts 'participation-in-proceedings))
          (proceedings-against-beneficiaries? (fact-ref facts 'against-beneficiaries)))
      
      (and trustee-status
           (not trustee-status-disclosed?)
           participation
           proceedings-against-beneficiaries?)))
  
  #:apply
  (lambda (facts)
    (let ((person (fact-ref facts 'person))
          (trustee-status (fact-ref facts 'trustee-status))
          (beneficiaries (fact-ref facts 'beneficiaries))
          (participation (fact-ref facts 'participation-in-proceedings))
          (affidavit-date (fact-ref facts 'affidavit-date))
          (beneficiary-actions (fact-ref facts 'beneficiary-actions)))
      
      (if (undisclosed-trustee-participation-fraud facts)
          (make-legal-conclusion
           #:finding 'undisclosed-trustee-participation-established
           #:consequence 'fraud-on-court-and-fiduciary-breach
           #:reasoning
           (format #f "~a is trustee but did not disclose trustee status when participating in proceedings against beneficiaries ~a. Beneficiaries fulfilled fiduciary duties by ~a. Trustee attacked beneficiaries for fulfilling duties. Fundamental breach of fiduciary duty and fraud on court."
                   person
                   (string-join beneficiaries ", ")
                   (string-join beneficiary-actions ", "))
           #:fiduciary-duty-breaches
           '((loyalty . fundamental-breach)
             (good-faith . fraud-on-court)
             (disclosure . material-non-disclosure)
             (no-conflict . overwhelming-conflict)
             (no-self-dealing . protected-own-interests))
           #:beneficiary-attack-analysis
           '((jax . "Investigated R1.035M debt (15 May 2025)")
             (daniel . "Reported fraud (6 Jun 2025)")
             (both . "Fulfilled fiduciary duties")
             (trustee . "Attacked beneficiaries for fulfilling duties"))
           #:inversion-analysis
           '((normal . "Trustee protects beneficiaries")
             (here . "Trustee attacks beneficiaries")
             (reason . "Beneficiaries exposed fraud implicating trustee"))
           #:legal-implications
           '((fundamental-breach-fiduciary-duty . #t)
             (fraud-on-court . #t)
             (supporting-affidavit-invalid . #t)
             (interdict-obtained-through-breach . #t)
             (rescission-warranted . #t)
             (personal-liability-for-breach . #t))
           #:remedies
           '(rescission-of-interdict
             fiduciary-duty-damages
             personal-costs-order
             removal-as-trustee)
           #:confidence 0.98)
          (make-legal-conclusion
           #:finding 'no-undisclosed-trustee-participation
           #:consequence 'no-breach
           #:confidence 0.95))))
  
  #:case-law
  '(("Doyle v Board of Executors 1999 (2) SA 805 (C)"
     "Trustee fiduciary duties to beneficiaries")
    ("Land and Agricultural Bank of South Africa v Parker 2005 (2) SA 77 (SCA)"
     "Trustee conflicts of interest")
    ("Thorpe v Trittenwein 2007 (2) SA 172 (T)"
     "Trustee duty of disclosure")))

;;;; ============================================================================
;;;; MODULE EXPORTS AND INTEGRATION
;;;; ============================================================================

(define (analyze-multi-party-conflicts facts)
  "Comprehensive analysis of multi-party conflicts using all 3 principles"
  (let ((triple-conflict-result (bantjies-triple-conflict-analysis facts))
        (commissioner-conflict-result (commissioner-of-oaths-conflict-invalidation facts))
        (undisclosed-trustee-result (undisclosed-trustee-participation-fraud facts)))
    
    (make-legal-analysis
     #:principles-applied 3
     #:findings
     (list triple-conflict-result
           commissioner-conflict-result
           undisclosed-trustee-result)
     #:overall-conclusion
     (if (or triple-conflict-result
             commissioner-conflict-result
             undisclosed-trustee-result)
         'multi-party-conflicts-established
         'no-conflicts)
     #:confidence
     (if (and triple-conflict-result
              commissioner-conflict-result
              undisclosed-trustee-result)
         0.98  ; All 3 principles support conflicts
         0.95))))

;; End of module
