;;; South African Trust Law - Enhanced v5
;;; Enhanced with undisclosed trustee triple conflict indicators
;;; Date: 2025-11-03
;;; Case: 2025-137857 (Peter Faucitt v. Jacqueline & Daniel Faucitt)

(define-module (lex trs za south-african-trust-law-enhanced-v5)
  #:use-module (lex lv1 known-laws)
  #:use-module (lex trs za south-african-trust-law-enhanced-v4)
  #:export (
    undisclosed-trustee-triple-conflict-indicators
  ))

;;;
;;; ENHANCED PRINCIPLE: Undisclosed Trustee Status with Triple Conflict
;;;

(define-principle undisclosed-trustee-triple-conflict-indicators
  #:name "Undisclosed Trustee Triple Conflict Indicators"
  #:confidence 0.97
  #:domain '(trust-law fiduciary-duty conflict-of-interest)
  #:description "Enhanced indicators for undisclosed trustee status combined with multiple conflicting roles creating triple conflict of interest"
  
  #:core-indicators '(
    (trustee-status-not-disclosed "Trustee status not disclosed to beneficiaries")
    (trustee-also-accountant "Trustee also serves as accountant for trust entities")
    (trustee-provides-instructions "Trustee provides instructions for financial decisions")
    (trustee-controls-financial-systems "Trustee controls financial systems and access")
    (beneficiaries-discover-during-investigation "Beneficiaries discover trustee status during investigation")
    (trustee-financial-interest-related-entities "Trustee has financial interest in related entities")
    (pattern-non-disclosure-extended-period "Pattern of non-disclosure over extended period")
    (trustees-conflicting-roles-systemic-control "Trustee's conflicting roles create systemic control")
  )
  
  #:triple-conflict-pattern '(
    (role-1-trustee "Trustee - Fiduciary duty to beneficiaries")
    (role-2-accountant "Accountant - Professional duty to companies")
    (role-3-instruction-authority "Instruction Authority - Directs financial decisions")
  )
  
  #:red-flags '(
    (trustee-status-undisclosed-1-year 0.96 "Trustee status undisclosed for over 1 year")
    (trustee-has-3-plus-conflicting-roles 0.98 "Trustee has 3+ conflicting roles")
    (trustee-controls-all-financial-systems 0.95 "Trustee controls all financial systems")
    (beneficiaries-explicitly-unaware 0.97 "Beneficiaries explicitly unaware")
    (trustee-instructs-payments-related-parties 0.94 "Trustee instructs payments to related parties")
    (discovery-during-fraud-investigation 0.95 "Discovery during fraud investigation")
    (trustees-relative-employed-bookkeeping 0.93 "Trustee's relative employed for bookkeeping")
  )
  
  #:case-application
  "Danie Bantjies was an unknown trustee of the Faucitt Family Trust. Beneficiaries (Jax and Dan) were unaware of his trustee status. Bantjies also served as accountant for the companies. Rynette claimed Bantjies instructed her to make huge payments (per SARS audit email). Rynette's sister Linda was employed specifically to do the books, yet expenses remained unallocated for 2 years. Beneficiaries discovered Bantjies' trustee status during their investigation in June 2025."
  
  #:legal-implications '(
    "Severe breach of fiduciary duty"
    "Conflict of interest violation"
    "Beneficiary rights violation (right to know trustees)"
    "Voidable trust decisions"
    "Potential trustee removal"
    "Personal liability for losses"
    "Fraud indicators"
  )
  
  #:related-principles '(
    fiduciary-duty
    undisclosed-trustee-status-indicators
    conflict-of-interest-prohibition
    beneficiary-information-rights
    trustee-removal-grounds
  )
  
  #:integration-points '(
    "jax-dan-response/AD/2-High-Priority/PARA_8-8_3_DAN_DISCOVERY.md"
    "jax-dan-response/peters_discovery.md"
  )
  
  #:test-function
  (lambda (facts)
    (let ((trustee-undisclosed (assoc-ref facts 'trustee-status-undisclosed))
          (trustee-is-accountant (assoc-ref facts 'trustee-is-accountant))
          (trustee-gives-instructions (assoc-ref facts 'trustee-gives-instructions))
          (beneficiaries-unaware (assoc-ref facts 'beneficiaries-unaware))
          (discovery-during-investigation (assoc-ref facts 'discovery-during-investigation)))
      
      (and trustee-undisclosed
           trustee-is-accountant
           trustee-gives-instructions
           beneficiaries-unaware
           discovery-during-investigation))))

;;; End of module
