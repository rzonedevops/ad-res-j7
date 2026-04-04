# Evidence to Lex Principle Mapping Matrix

**Date:** October 30, 2025  
**Case:** 2025-137857 (Peter Faucitt v. Jacqueline & Daniel Faucitt)  
**Purpose:** Map all case evidence to applicable lex framework principles  
**Version:** 1.0

---

## How to Use This Matrix

This matrix maps **evidence** (entities, relations, events, timelines) to **lex principles** for optimal legal resolution. Each mapping includes:

- **Evidence Reference**: Specific evidence item (paragraph, document, timeline)
- **Lex Principle**: Applicable legal principle from lex framework
- **Confidence Score**: Principle confidence (0.0-1.0)
- **Framework Location**: File path in lex/ directory
- **Application**: How to apply principle to evidence
- **Strategic Value**: Why this mapping strengthens the case

---

## Part 1: Entity-Based Mappings

### 1.1 Dan (CIO, Responsible Person)

| Evidence | Lex Principle | Confidence | Framework | Application | Strategic Value |
|----------|--------------|------------|-----------|-------------|-----------------|
| Dan appointed EU Responsible Person | `eu-responsible-person-duty` | 0.93 | `lex/cmp/za/regulatory_compliance_enhanced_v2.scm` | Establish mandatory legal duties under EU Reg 1223/2009 | Proves IT expenses legally necessary |
| R8.85M IT expenses over 18 months | `regulatory-compliance-cost-reasonableness` | 0.94 | `lex/cmp/za/regulatory_compliance_enhanced_v2.scm` | Apply reasonableness test: regulatory necessity, proportionality, industry standards | Defends against "excessive expense" claims |
| CIO role and responsibilities | `professional-it-standard` | 0.93 | `lex/cmp/za/regulatory_compliance_enhanced_v2.scm` | Establish professional standards for IT infrastructure | Shows professional duty requires robust IT |
| Dan's UK company (RegimA Zone Ltd) | `cross-border-director-compliance-duty` | 0.94 | `lex/cmp/za/regulatory_compliance_enhanced_v2.scm` | Establish cross-border compliance obligations | Justifies international IT infrastructure |
| Platform investment R1M | `investment-legitimacy-test` | 0.91 | `lex/COMPREHENSIVE_LEGAL_ASPECTS_ANALYSIS.json` | Verify legitimate business investment | Counters "sham investment" claims |
| Platform usage by RWD (28 months) | `platform-usage-timeline-analysis` | 0.94 | `lex/civ/za/timeline_event_integration.scm` | Calculate unjust enrichment over time | Establishes R2.94M-R6.88M counterclaim |

### 1.2 Jax (CEO, Director, Beneficiary)

| Evidence | Lex Principle | Confidence | Framework | Application | Strategic Value |
|----------|--------------|------------|-----------|-------------|-----------------|
| R500K payment to Jax | `trust-distribution-authorization-test` | 0.95 | `lex/LEX_REFINEMENT_RECOMMENDATIONS.md` | Test whether distribution properly authorized | Defends payment legitimacy |
| Jax as CEO making business decisions | `business-judgment-rule-test` | 0.95 | `lex/LEX_REFINEMENT_RECOMMENDATIONS.md` | Apply business judgment protection | Protects against liability for business decisions |
| Jax as trust beneficiary | `beneficiary-rights` | 0.94 | `lex/trs/za/south_african_trust_law_enhanced.scm` | Establish beneficiary entitlements | Counters Peter's trustee-vs-beneficiary attack |
| Jax as 50% RST shareholder | `shareholder-oppression-test` | 0.96 | `lex/LEX_REFINEMENT_RECOMMENDATIONS.md` | Establish oppression by Peter | Supports counterclaim for oppression |

### 1.3 Peter (Applicant, Director, Trustee)

| Evidence | Lex Principle | Confidence | Framework | Application | Strategic Value |
|----------|--------------|------------|-----------|-------------|-----------------|
| Peter owns 50% RST + 50% Villa Via | `director-self-dealing-prohibition` | 0.97 | `lex/cmp/za/south_african_company_law_enhanced.scm` | Prove self-dealing in rent charges | Exposes conflict of interest |
| Peter as trustee seeking interdict | `trust-power-bypass-indicators` | 0.94 | `lex/civ/za/timeline_event_integration.scm` | Analyze why Peter bypasses direct trust powers | Proves ulterior motive |
| Peter's unilateral card cancellation | `director-collective-action-requirement` | 0.96 | `lex/cmp/za/south_african_company_law_enhanced.scm` | Prove breach of collective action duty | Shows director duty breach |
| Peter's card cancellation (June 7) | `unilateral-action-prohibition` | 0.96 | `lex/cmp/za/south_african_company_law_enhanced.scm` | Prove individual director cannot act alone | Establishes breach of duty |

---

## Part 2: Relation-Based Mappings

### 2.1 Self-Dealing Relations

| Evidence | Lex Principle | Confidence | Framework | Application | Strategic Value |
|----------|--------------|------------|-----------|-------------|-----------------|
| RST pays rent to Villa Via (Peter owns 50% of both) | `director-self-dealing-prohibition` | 0.97 | `lex/cmp/za/south_african_company_law_enhanced.scm` | Prove self-dealing without disclosure | Exposes conflict of interest |
| Villa Via 86% profit margin on rent | `excessive-profit-extraction-test` | 0.94 | `lex/cmp/za/forensic_accounting_enhanced_v2.scm` | Test whether profit extraction excessive | Proves oppressive extraction |
| RST-Villa Via rent not at arms length | `arms-length-principle` | 0.97 | `lex/cmp/za/forensic_accounting_enhanced_v2.scm` | Prove transaction not at market value | Shows related party abuse |

### 2.2 Transfer Pricing Relations

| Evidence | Lex Principle | Confidence | Framework | Application | Strategic Value |
|----------|--------------|------------|-----------|-------------|-----------------|
| SLG sells to RST at below cost | `below-cost-transfer-pricing-prohibition` | 0.96 | `lex/cmp/za/forensic_accounting_enhanced_v2.scm` | Prove related party sales below cost | Exposes transfer pricing abuse |
| SLG R5.4M loss, RST profits | `transfer-pricing-abuse-indicators` | 0.93 | `lex/cmp/za/forensic_accounting_enhanced_v2.scm` | Identify profit shifting mechanism | Shows systematic manipulation |
| SLG-RST transactions not arms length | `arms-length-principle` | 0.97 | `lex/cmp/za/forensic_accounting_enhanced_v2.scm` | Prove transactions not at market value | Establishes abuse |

### 2.3 Unjust Enrichment Relations

| Evidence | Lex Principle | Confidence | Framework | Application | Strategic Value |
|----------|--------------|------------|-----------|-------------|-----------------|
| RWD uses platform without payment (28 months) | `unjust-enrichment-test` | 0.96 | `lex/civ/za/south_african_civil_law_unjust_enrichment.scm` | Apply four-element test: enrichment, expense, causal connection, no legal ground | Establishes R2.94M-R6.88M claim |
| Platform usage value R105K-R245K/month | `quantum-meruit` | 0.95 | `lex/civ/za/south_african_civil_law_unjust_enrichment.scm` | Calculate reasonable value of services | Quantifies enrichment |
| 28 months usage without payment | `ongoing-enrichment-calculation` | 0.93 | `lex/civ/za/timeline_event_integration.scm` | Calculate enrichment over time period | Establishes total claim amount |

### 2.4 Trustee-Beneficiary Relations

| Evidence | Lex Principle | Confidence | Framework | Application | Strategic Value |
|----------|--------------|------------|-----------|-------------|-----------------|
| Peter (trustee) seeks interdict against Jax (beneficiary) | `trustee-conflict-prohibition` | 0.96 | `lex/trs/za/south_african_trust_law_enhanced.scm` | Prove trustee conflict of interest | Shows breach of trustee duty |
| Peter (trustee) attacking Jax (beneficiary) | `beneficiary-adverse-action-prohibition` | 0.94 | `lex/COMPREHENSIVE_LEGAL_ASPECTS_ANALYSIS.json` | Prove trustee cannot take adverse action against beneficiary | Establishes trustee duty breach |

---

## Part 3: Event-Based Mappings

### 3.1 Card Cancellation Event (June 7, 2025)

| Evidence | Lex Principle | Confidence | Framework | Application | Strategic Value |
|----------|--------------|------------|-----------|-------------|-----------------|
| Peter cancels cards June 7 (day after Dan's cooperation June 6) | `timing-analysis-bad-faith` | 0.93 | `lex/civ/za/timeline_event_integration.scm` | Analyze suspicious timing as bad faith indicator | Proves manufactured crisis |
| Card cancellation → documentation inaccessible | `temporal-but-for-causation` | 0.96 | `lex/civ/za/timeline_event_integration.scm` | But-for analysis: but for cancellation, would gap exist? | Proves Peter caused problem |
| Peter created gap, then complains about gap | `self-created-problem-estoppel` | 0.96 | `lex/civ/za/timeline_event_integration.scm` | Estoppel: party cannot benefit from self-created problem | Bars Peter from relying on gap |
| Peter obstructed documentation access | `obstruction-of-documentation-principle` | 0.96 | `lex/cmp/za/regulatory_compliance_enhanced_v2.scm` | Party obstructing cannot benefit from lack of documentation | Adverse inference against Peter |
| Complete card cancellation sequence | `card-cancellation-timeline` | 0.95 | `lex/civ/za/timeline_event_integration.scm` | Apply complete timeline analysis | Comprehensive proof of obstruction |
| Unilateral action without board resolution | `director-collective-action-requirement` | 0.96 | `lex/cmp/za/south_african_company_law_enhanced.scm` | Prove breach of collective action duty | Shows director duty breach |

### 3.2 Ex Parte Interdict Application Event

| Evidence | Lex Principle | Confidence | Framework | Application | Strategic Value |
|----------|--------------|------------|-----------|-------------|-----------------|
| Peter seeks ex parte interdict during settlement | `abuse-of-process-timing-indicators` | 0.93 | `lex/civ/za/timeline_event_integration.scm` | Timing-based abuse of process analysis | Proves abuse of court process |
| Peter has trust powers but seeks court relief | `trust-power-bypass-indicators` | 0.94 | `lex/civ/za/timeline_event_integration.scm` | Analyze bypassing available remedies | Proves ulterior motive |
| Manufactured urgency for ex parte relief | `manufactured-urgency-indicators` | 0.92 | `lex/civ/za/timeline_event_integration.scm` | Identify fake urgency indicators | Shows no genuine urgency |
| Multiple bad faith indicators present | `bad-faith-indicators` | 0.93 | `lex/civ/za/timeline_event_integration.scm` | Comprehensive bad faith analysis | Establishes bad faith pattern |

### 3.3 SLG R5.2M Inventory Adjustment Event

| Evidence | Lex Principle | Confidence | Framework | Application | Strategic Value |
|----------|--------------|------------|-----------|-------------|-----------------|
| R5.2M inventory adjustment (10x prior year) | `accounting-fraud-indicators` | 0.92 | `lex/cmp/za/forensic_accounting_enhanced_v2.scm` | Identify red flags for manipulation | Triggers forensic investigation |
| Adjustment 46% of annual sales | `inventory-adjustment-reasonableness-test` | 0.95 | `lex/cmp/za/forensic_accounting_enhanced_v2.scm` | Test reasonableness of adjustment | Fails reasonableness test |
| Negative R4.2M finished goods inventory | `negative-inventory-impossibility` | 0.98 | `lex/cmp/za/forensic_accounting_enhanced_v2.scm` | Prove accounting impossibility | Proves accounting fiction |
| R5.4M loss driven by single adjustment | `manufactured-loss-indicators` | 0.93 | `lex/cmp/za/forensic_accounting_enhanced_v2.scm` | Identify manufactured loss pattern | Proves loss is artificial |
| Year-end adjustment timing | `year-end-adjustment-fraud-indicators` | 0.91 | `lex/cmp/za/forensic_accounting_enhanced_v2.scm` | Analyze suspicious timing | Shows manipulation timing |

---

## Part 4: Timeline-Based Mappings

### 4.1 Card Cancellation Timeline

| Timeline Element | Lex Principle | Confidence | Framework | Application | Strategic Value |
|-----------------|--------------|------------|-----------|-------------|-----------------|
| June 6: Dan cooperates → June 7: Peter cancels cards | `timing-analysis-bad-faith` | 0.93 | `lex/civ/za/timeline_event_integration.scm` | Suspicious timing analysis | Proves manufactured crisis |
| Cooperation → Cancellation → Gap → Complaint | `event-sequence-causation-analysis` | 0.94 | `lex/civ/za/timeline_event_integration.scm` | Event sequence reveals pattern | Shows deliberate strategy |
| Complete timeline pattern | `manufactured-crisis-timeline-indicators` | 0.92 | `lex/civ/za/timeline_event_integration.scm` | Pattern analysis | Comprehensive proof |
| Timeline proves Peter caused gap | `obstruction-timeline-analysis` | 0.95 | `lex/civ/za/timeline_event_integration.scm` | Timeline-based causation proof | Irrefutable evidence |

### 4.2 Trust Power Bypass Timeline

| Timeline Element | Lex Principle | Confidence | Framework | Application | Strategic Value |
|-----------------|--------------|------------|-----------|-------------|-----------------|
| Peter has powers → Doesn't use → Seeks court relief | `trust-power-bypass-timeline-analysis` | 0.92 | `lex/civ/za/timeline_event_integration.scm` | Timeline of bypassing | Proves ulterior motive |
| Timing coincides with settlement negotiation | `ulterior-motive-analysis` | 0.91 | `lex/civ/za/timeline_event_integration.scm` | Motive analysis from timing | Shows litigation pressure tactic |
| All bypass indicators present | `trust-power-bypass-indicators` | 0.94 | `lex/civ/za/timeline_event_integration.scm` | Comprehensive indicator analysis | Strong evidence of bad faith |

### 4.3 Platform Usage Timeline

| Timeline Element | Lex Principle | Confidence | Framework | Application | Strategic Value |
|-----------------|--------------|------------|-----------|-------------|-----------------|
| Investment → Usage (28 months) → No payment | `platform-usage-timeline-analysis` | 0.94 | `lex/civ/za/timeline_event_integration.scm` | Timeline establishes elements | Proves unjust enrichment |
| 28 months × R105K-R245K/month | `ongoing-enrichment-calculation` | 0.93 | `lex/civ/za/timeline_event_integration.scm` | Calculate enrichment over time | Quantifies R2.94M-R6.88M claim |

### 4.4 Settlement Negotiation Timeline

| Timeline Element | Lex Principle | Confidence | Framework | Application | Strategic Value |
|-----------------|--------------|------------|-----------|-------------|-----------------|
| Settlement ongoing → Ex parte interdict application | `settlement-negotiation-timeline` | 0.93 | `lex/civ/za/timeline_event_integration.scm` | Litigation during settlement | Proves abuse of process |
| Timing creates litigation pressure | `abuse-of-process-timing-indicators` | 0.93 | `lex/civ/za/timeline_event_integration.scm` | Timing-based abuse analysis | Shows bad faith negotiation |

---

## Part 5: Compound Mappings (Multiple Principles)

### 5.1 Peter's Obstruction Pattern

| Evidence Cluster | Applicable Principles | Strategic Application |
|-----------------|----------------------|----------------------|
| **Card Cancellation + Documentation Gap + Complaint** | `temporal-but-for-causation` (0.96)<br>`timing-analysis-bad-faith` (0.93)<br>`obstruction-timeline-analysis` (0.95)<br>`self-created-problem-estoppel` (0.96)<br>`obstruction-of-documentation-principle` (0.96)<br>`temporal-adverse-inference` (0.93) | **Comprehensive obstruction proof**: Timeline proves Peter created problem, timing shows bad faith, estoppel bars reliance on gap, adverse inference against Peter |

### 5.2 SLG Financial Manipulation

| Evidence Cluster | Applicable Principles | Strategic Application |
|-----------------|----------------------|----------------------|
| **R5.2M Adjustment + Negative Inventory + Below-Cost Sales** | `accounting-fraud-indicators` (0.92)<br>`inventory-adjustment-reasonableness-test` (0.95)<br>`negative-inventory-impossibility` (0.98)<br>`transfer-pricing-abuse-indicators` (0.93)<br>`manufactured-loss-indicators` (0.93)<br>`financial-statement-manipulation-test` (0.93) | **Comprehensive manipulation proof**: Multiple red flags, fails reasonableness test, negative inventory proves fiction, transfer pricing abuse evident, forensic investigation required |

### 5.3 Villa Via Profit Extraction

| Evidence Cluster | Applicable Principles | Strategic Application |
|-----------------|----------------------|----------------------|
| **86% Profit Margin + Self-Dealing + Not Arms Length** | `director-self-dealing-prohibition` (0.97)<br>`excessive-profit-extraction-test` (0.94)<br>`arms-length-principle` (0.97)<br>`profit-extraction-mechanism-indicators` (0.92)<br>`financial-oppression-indicators` (0.93) | **Comprehensive oppression proof**: Self-dealing proven, profit extraction excessive, not arms length, systematic oppression of minority shareholders |

### 5.4 Trust Power Bypass + Manufactured Urgency

| Evidence Cluster | Applicable Principles | Strategic Application |
|-----------------|----------------------|----------------------|
| **Trust Powers Available + Court Relief Sought + Ex Parte + Settlement Timing** | `trust-power-bypass-indicators` (0.94)<br>`ulterior-motive-analysis` (0.91)<br>`manufactured-urgency-indicators` (0.92)<br>`abuse-of-process-timing-indicators` (0.93)<br>`bad-faith-indicators` (0.93) | **Comprehensive ulterior motive proof**: Bypassing available remedies, fake urgency, abuse of process, bad faith pattern, litigation pressure tactic |

### 5.5 Regulatory Compliance Defense

| Evidence Cluster | Applicable Principles | Strategic Application |
|-----------------|----------------------|----------------------|
| **EU Responsible Person + IT Infrastructure + R8.85M Expenses + Industry Standards** | `eu-responsible-person-duty` (0.93)<br>`regulatory-compliance-necessity` (0.96)<br>`it-infrastructure-compliance-necessity` (0.92)<br>`regulatory-compliance-cost-reasonableness` (0.94)<br>`professional-it-standard` (0.93)<br>`business-judgment-rule-test` (0.95) | **Comprehensive compliance defense**: Mandatory legal duties, IT necessary for compliance, expenses reasonable and proportionate, industry standards met, business judgment protection applies |

---

## Part 6: Strategic Application Guide

### 6.1 How to Use This Matrix in Affidavit

**Step 1: Identify Evidence**
- Locate specific evidence item (paragraph, document, event, timeline)

**Step 2: Find Applicable Principles**
- Use this matrix to identify relevant lex principles
- Note confidence scores and framework locations

**Step 3: Apply Principles to Evidence**
- State the evidence clearly
- Cite the applicable lex principle
- Reference the framework location
- Apply the principle to the evidence
- State the legal conclusion

**Example:**
```markdown
## Peter's Card Cancellation Created Documentation Gap

**Evidence:** On June 7, 2025, Peter unilaterally cancelled business cards, making documentation inaccessible. This occurred one day after Dan cooperated by providing reports to the accountant on June 6, 2025.

**Applicable Principles:**

1. **Temporal But-For Causation** (confidence: 0.96)
   - Framework: `lex/civ/za/timeline_event_integration.scm`
   - Application: But for Peter's card cancellation on June 7, would the documentation gap exist? No.
   - Conclusion: Peter's action directly caused the documentation gap.

2. **Timing Analysis - Bad Faith** (confidence: 0.93)
   - Framework: `lex/civ/za/timeline_event_integration.scm`
   - Application: Peter's action immediately after Dan's cooperation (June 6 → June 7) indicates bad faith and manufactured crisis.
   - Conclusion: Suspicious timing proves Peter manufactured the crisis.

3. **Self-Created Problem Estoppel** (confidence: 0.96)
   - Framework: `lex/civ/za/timeline_event_integration.scm`
   - Application: Peter created the documentation gap, then complains about missing documentation. Party cannot benefit from self-created problem.
   - Conclusion: Peter is estopped from relying on the documentation gap.

**Legal Consequence:** Peter created the problem he complains about. Court should draw adverse inference against Peter and reject claims based on documentation gap.
```

### 6.2 How to Use This Matrix in Legal Argument

**Structure:**
1. **State the Evidence** (factual foundation)
2. **Cite the Principle** (legal framework)
3. **Apply Principle to Evidence** (legal analysis)
4. **State Confidence Score** (quantitative support)
5. **Reference Framework** (technical detail available)
6. **Draw Conclusion** (legal consequence)

**Example:**
```markdown
The evidence establishes that Peter's unilateral card cancellation on June 7, 2025 directly caused the documentation gap he now complains about. Applying the principle of temporal but-for causation (confidence: 0.96, lex/civ/za/timeline_event_integration.scm), but for Peter's action, the documentation gap would not exist. The suspicious timing—one day after Dan's cooperation—indicates bad faith and manufactured crisis (timing-analysis-bad-faith, confidence: 0.93). Peter is therefore estopped from relying on the self-created documentation gap (self-created-problem-estoppel, confidence: 0.96). The Court should draw an adverse inference against Peter and reject claims based on the documentation gap.
```

### 6.3 How to Use This Matrix for Cross-Examination

**Strategy:** Use lex principles to structure cross-examination questions

**Example: Cross-Examining Peter on Card Cancellation**

Q: You cancelled the business cards on June 7, 2025, correct?
A: Yes.

Q: That was one day after Dan provided reports to the accountant on June 6, 2025?
A: Yes.

Q: And after you cancelled the cards, documentation became inaccessible?
A: Yes.

Q: So but for your card cancellation, the documentation would still be accessible?
**[Applying: temporal-but-for-causation, confidence: 0.96]**
A: [Expected: Yes / Evasion]

Q: You created the documentation gap, and now you complain about missing documentation?
**[Applying: self-created-problem-estoppel, confidence: 0.96]**
A: [Expected: Evasion / Justification attempt]

Q: You had absolute trust powers to act directly, but you chose to seek court relief instead?
**[Applying: trust-power-bypass-indicators, confidence: 0.94]**
A: [Expected: Evasion / Weak justification]

---

## Part 7: Confidence Score Interpretation

### Confidence Score Ranges

| Range | Interpretation | Application |
|-------|---------------|-------------|
| **0.95-1.0** | Very High Confidence | Level 1 principles (explicit law), well-established doctrine, direct statutory basis |
| **0.90-0.94** | High Confidence | Derived principles with strong statutory/case law support, industry standards |
| **0.85-0.89** | Good Confidence | Inferred principles with reasonable support, professional standards |
| **0.80-0.84** | Moderate Confidence | Abductive/analogical reasoning, emerging doctrine |
| **< 0.80** | Lower Confidence | Speculative principles, weak support (use cautiously) |

### Strategic Use of Confidence Scores

**High Confidence Principles (0.95+):**
- Lead with these in affidavit and argument
- Use for foundational legal points
- Cite prominently in headings and conclusions

**Good Confidence Principles (0.90-0.94):**
- Use for supporting arguments
- Combine multiple principles for cumulative effect
- Cite in detailed analysis sections

**Moderate Confidence Principles (0.85-0.89):**
- Use for alternative arguments
- Strengthen with additional evidence
- Combine with higher confidence principles

---

## Part 8: Framework File Reference Guide

### Quick Reference to Framework Files

| Framework | File Path | Primary Focus |
|-----------|-----------|---------------|
| **Regulatory Compliance** | `lex/cmp/za/south_african_company_law_regulatory_compliance_enhanced_v2.scm` | EU Responsible Person duties, IT compliance, expense justification |
| **Forensic Accounting** | `lex/cmp/za/south_african_company_law_forensic_accounting_enhanced_v2.scm` | Accounting fraud, transfer pricing, profit extraction, shareholder oppression |
| **Timeline-Event Integration** | `lex/civ/za/south_african_civil_law_timeline_event_integration.scm` | Temporal causation, bad faith, obstruction, manufactured crisis |
| **Company Law (Enhanced)** | `lex/cmp/za/south_african_company_law_enhanced.scm` | Director duties, self-dealing, conflict of interest, collective action |
| **Trust Law (Enhanced)** | `lex/trs/za/south_african_trust_law_enhanced.scm` | Trustee duties, beneficiary rights, trust power abuse |
| **Civil Law (Unjust Enrichment)** | `lex/civ/za/south_african_civil_law_unjust_enrichment.scm` | Unjust enrichment test, quantum meruit, restitution |
| **Level 1 Principles** | `lex/lv1/known_laws.scm` | Foundational legal maxims (confidence: 1.0) |

---

## Conclusion

This mapping matrix provides **systematic integration** of lex framework principles with case evidence. Use it to:

1. **Strengthen Arguments**: Apply legal principles with confidence scores
2. **Structure Affidavit**: Organize evidence around applicable principles
3. **Prepare Cross-Examination**: Structure questions around principle application
4. **Identify Gaps**: Find evidence needing additional legal support
5. **Prioritize Arguments**: Lead with high-confidence principles

**Key Advantage:** Transforms factual evidence into **legally-grounded, quantitatively-supported** arguments with clear statutory basis and technical framework backing.

---

**Document Version:** 1.0  
**Last Updated:** 2025-10-30  
**Total Mappings:** 80+ evidence-principle pairs  
**Frameworks Integrated:** 7 major frameworks  
**Case Reference:** Faucitt v. Faucitt (2025-137857)
