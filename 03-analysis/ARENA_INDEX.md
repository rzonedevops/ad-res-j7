# ARENA INDEX
## Legal Framework - Rules & Principles Mapped to Cases

**Purpose**: This index maps the legal framework (lex/) to each of the three cases, showing which legal principles and rules apply where.

**Navigation**: 
- 📖 [Agent Index](AGENT_INDEX.md) - Evidence and documents
- 🔗 [Relations Index](RELATIONS_INDEX.md) - Arena-Agent connections
- ⚙️ [Grip Workflow](GRIP_WORKFLOW.md) - How to use the system

---

## Legal Framework Structure

### lex/lv1/ - First-Order Principles (60+ Universal Maxims)

**File**: `lex/lv1/known_laws.scm` (40KB)

Foundation principles that underpin all legal reasoning:

#### Contract & Agreement
- `pacta-sunt-servanda` - Agreements must be kept
- `consensus-ad-idem` - Meeting of the minds required
- `exceptio-non-adimpleti-contractus` - Exception for non-performance
- `consideration-exists` - Valid contracts require consideration

#### Property & Ownership
- `nemo-plus-iuris` - Cannot transfer more rights than possessed
- `nemo-dat-quod-non-habet` - Cannot give what you don't have
- `res-nullius` - Unowned things can be acquired

#### Justice & Fairness
- `audi-alteram-partem` - Hear the other side
- `nemo-iudex-in-causa-sua` - No one judge in own cause
- `ei-qui-affirmat-incumbit-probatio` - Burden of proof on claimant
- `de-minimis-non-curat-lex` - Law does not concern itself with trifles

#### Criminal Law
- `nullum-crimen-sine-lege` - No crime without law
- `actus-non-facit-reum-nisi-mens-sit-rea` - Act not guilty without guilty mind
- `ei-incumbit-probatio-qui-dicit` - Burden on the accuser

#### Good Faith
- `bona-fides` - Good faith required
- `uberrima-fides` - Utmost good faith (fiduciary contexts)
- `fraus-omnia-corrumpit` - Fraud corrupts everything

### lex/civ/ - Civil Law

**Application**: Contract breaches, unjust enrichment, delict (torts)

**Relevance to Cases**:
- Material non-disclosure (civil case)
- Breach of contract
- Unjust enrichment claims

### lex/cri/ - Criminal Law

**Application**: Fraud, theft, perjury, forgery

**Relevance to Cases**:
- Perjury charges (criminal case)
- Fraud allegations
- Theft of revenue streams
- Email impersonation

### lex/trs/ - Trust Law

**Application**: Fiduciary duties, trustee obligations

**Relevance to Cases**:
- Breach of fiduciary duty (civil case)
- Trustee failures to investigate
- Trust asset protection

### lex/civ-proc/ - Civil Procedure

**Application**: Court procedures, ex parte applications, rescission

**Relevance to Cases**:
- Rescission application procedures
- Ex parte duty of disclosure
- Interdict standards

### lex/evid/ - Evidence Law

**Application**: Admissibility, burden of proof, standards

**Relevance to Cases**:
- Evidence requirements for all cases
- Burden of proof standards
- Documentary evidence authentication

### lex/adm/ - Administrative Law

**Application**: Regulatory compliance, administrative justice

**Relevance to Cases**:
- SARS compliance (external validation)
- Regulatory obligations
- Administrative fairness

### lex/lab/ - Labour Law

**Application**: Employment relationships, unfair dismissal

**Relevance to Cases**:
- Employment status disputes
- Contractor vs employee classifications

### lex/cmp/ - Company Law

**Application**: Corporate structures, director duties

**Relevance to Cases**:
- Director obligations
- Company record-keeping
- Corporate governance

---

## Mapping to Cases

### 1. Civil Response (Rescission Application)

**Primary Arena Principles**:

#### Ground 1: Bad Faith / Clean Hands
- `bona-fides` (good faith) - violated
- `fraus-omnia-corrumpit` (fraud corrupts all) - applies
- `nemo-iudex-in-causa-sua` (no judge in own cause) - Peter created the problems
- `lex/civ-proc/` - ex parte duties, rescission standards

**Mapping**: [1-CIVIL-RESPONSE/arena-mapping.md](1-CIVIL-RESPONSE/arena-mapping.md)

#### Ground 2: Material Non-Disclosure
- `uberrima-fides` (utmost good faith) - ex parte duty violated
- `audi-alteram-partem` (hear other side) - failed to disclose
- `ei-qui-affirmat-incumbit-probatio` (burden on claimant) - incomplete
- `lex/civ-proc/` - ex parte disclosure requirements

**Mapping**: [1-CIVIL-RESPONSE/arena-mapping.md](1-CIVIL-RESPONSE/arena-mapping.md)

#### Ground 3: Gross Disproportionality
- `de-minimis-non-curat-lex` (law doesn't concern trifles) - inverted (relief causes more harm)
- Constitutional proportionality (Section 36)
- `lex/civ/` - proportionality in remedies

**Mapping**: [1-CIVIL-RESPONSE/arena-mapping.md](1-CIVIL-RESPONSE/arena-mapping.md)

#### Trust Law Claims
- `uberrima-fides` (trustee duty) - breach of fiduciary duty
- `lex/trs/` - trustee obligations to investigate fraud
- Duty to beneficiaries

**Mapping**: [1-CIVIL-RESPONSE/arena-mapping.md](1-CIVIL-RESPONSE/arena-mapping.md)

---

### 2. Criminal Case (Post-Interdict Prosecution)

**Primary Arena Principles**:

#### Perjury Charges
- `actus-non-facit-reum-nisi-mens-sit-rea` (guilty mind required)
- `nullum-crimen-sine-lege` (crime defined by statute)
- Criminal Procedure Act 51 of 1977, Section 319
- `lex/cri/` - perjury elements
- `lex/evid/` - proof requirements

**Mapping**: [2-CRIMINAL-CASE/arena-mapping.md](2-CRIMINAL-CASE/arena-mapping.md)

#### Fraud Charges
- `fraus-omnia-corrumpit` (fraud corrupts all)
- `actus-non-facit-reum-nisi-mens-sit-rea` (intention required)
- Common law fraud elements:
  - Misrepresentation
  - Knowledge of falsity (scienter)
  - Intent to defraud
  - Actual prejudice
- `lex/cri/` - fraud provisions

**Mapping**: [2-CRIMINAL-CASE/arena-mapping.md](2-CRIMINAL-CASE/arena-mapping.md)

#### Theft Charges
- `nemo-dat-quod-non-habet` (cannot give what you don't have)
- Criminal Law Amendment Act 1 of 1988
- `lex/cri/` - theft elements
- Revenue hijacking analysis

**Mapping**: [2-CRIMINAL-CASE/arena-mapping.md](2-CRIMINAL-CASE/arena-mapping.md)

#### Email Impersonation
- Electronic Communications and Transactions Act 25 of 2002
- `fraus-omnia-corrumpit` (fraud through impersonation)
- `lex/cri/` - electronic crimes

**Mapping**: [2-CRIMINAL-CASE/arena-mapping.md](2-CRIMINAL-CASE/arena-mapping.md)

#### Obstruction of Justice
- Criminal Procedure Act 51 of 1977
- `fraus-omnia-corrumpit` (deliberate obstruction)
- Card cancellations creating documentation gap
- `lex/cri/` - obstruction provisions

**Mapping**: [2-CRIMINAL-CASE/arena-mapping.md](2-CRIMINAL-CASE/arena-mapping.md)

---

### 3. External Validation (Third-Party Verification)

**Primary Arena Principles**:

#### SARS Compliance
- Tax Administration Act 28 of 2011
- `bona-fides` (good faith reporting)
- `lex/adm/` - administrative compliance
- Revenue reporting obligations

**Mapping**: [3-EXTERNAL-VALIDATION/arena-mapping.md](3-EXTERNAL-VALIDATION/arena-mapping.md)

#### Banking Good Standing
- `bona-fides` (good banking relationships)
- Financial conduct standards
- `lex/cmp/` - corporate banking requirements

**Mapping**: [3-EXTERNAL-VALIDATION/arena-mapping.md](3-EXTERNAL-VALIDATION/arena-mapping.md)

#### Professional Standards
- Accounting Profession Act 26 of 2005
- `lex/prof-eth/` - professional ethics
- `uberrima-fides` (professional duty)
- Expert opinion standards

**Mapping**: [3-EXTERNAL-VALIDATION/arena-mapping.md](3-EXTERNAL-VALIDATION/arena-mapping.md)

#### Regulatory Compliance
- CPNP (Cosmetic Products Notification Portal)
- MHRA (Medicines and Healthcare products Regulatory Agency)
- `lex/adm/` - regulatory frameworks
- International compliance obligations

**Mapping**: [3-EXTERNAL-VALIDATION/arena-mapping.md](3-EXTERNAL-VALIDATION/arena-mapping.md)

---

## Cross-Cutting Principles

### Principles Applicable to All Cases

1. **Evidence Standards**
   - `ei-qui-affirmat-incumbit-probatio` (burden on claimant)
   - `ei-incumbit-probatio-qui-dicit` (burden on accuser)
   - `lex/evid/` - admissibility, authentication
   - Balance of probabilities (civil) vs beyond reasonable doubt (criminal)

2. **Good Faith Requirements**
   - `bona-fides` (general good faith)
   - `uberrima-fides` (utmost good faith in fiduciary contexts)
   - `fraus-omnia-corrumpit` (fraud vitiates all)

3. **Procedural Fairness**
   - `audi-alteram-partem` (hear both sides)
   - `nemo-iudex-in-causa-sua` (no judge in own cause)
   - Natural justice principles

4. **Property Rights**
   - `nemo-plus-iuris` (cannot transfer more than possessed)
   - `nemo-dat-quod-non-habet` (cannot give what not owned)
   - Revenue stream ownership

---

## Using This Index

### For Legal Analysis
1. Identify which case you're working on
2. Review the "Primary Arena Principles" for that case
3. Navigate to the detailed arena-mapping.md for that case
4. Cross-reference with AGENT_INDEX.md to see supporting evidence

### For Evidence Collection
1. Start with AGENT_INDEX.md to see available evidence
2. Use this index to understand which legal principles the evidence supports
3. Navigate to RELATIONS_INDEX.md to see complete arena-agent connections

### For Grip Optimization
1. Use GRIP_WORKFLOW.md to understand analytical workflows
2. Run `npm run db:lex:demo` to see principles in action
3. Run `npm run db:grip:demo` to measure grip quality
4. Use `npm run db:lex:analyze` for modal logic analysis

---

## File Locations

### Lex Framework Files
- First-order principles: `lex/lv1/known_laws.scm`
- Civil law: `lex/civ/`
- Criminal law: `lex/cri/`
- Trust law: `lex/trs/`
- Civil procedure: `lex/civ-proc/`
- Evidence law: `lex/evid/`
- Administrative law: `lex/adm/`
- Labour law: `lex/lab/`
- Company law: `lex/cmp/`
- Professional ethics: `lex/prof-eth/`

### Case-Specific Mappings
- Civil response: `1-CIVIL-RESPONSE/arena-mapping.md`
- Criminal case: `2-CRIMINAL-CASE/arena-mapping.md`
- External validation: `3-EXTERNAL-VALIDATION/arena-mapping.md`

### Related Documentation
- Lex system guide: `db/LEX_SYSTEM_COMPLETE.md`
- Lex inference guide: `db/LEX_INFERENCE_GUIDE.md`
- Legal aspects analysis: `lex/LEGAL_ASPECTS_ANALYSIS.md`

---

**Last Updated**: 2025-11-17  
**Version**: 1.0  
**Purpose**: Enable optimal grip on legal framework (arena) across all three cases
