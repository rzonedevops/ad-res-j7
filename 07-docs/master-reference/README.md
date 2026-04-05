# Master Reference System

**Case Reference:** 2025-137857
**Purpose:** Centralized evidence-to-filing cross-reference for all compliance submissions

---

## How the Master Reference System Works

The master reference system provides a **single authoritative lookup** between evidence records and the legal filings they support. It sits above the existing three-dimensional organization (Arena, Agent, Relations) and addresses a specific need: when preparing or reviewing a filing, you need to know exactly which evidence records support it and where they live in the repository.

### Problem Solved

The repository contains 1,700+ files across 20 annexures, 15 evidence categories, and multiple analysis directories. Four primary compliance filings each draw on overlapping subsets of this evidence. Without a centralized reference:

- Evidence may be cited in a filing but not located
- Shared evidence across filings may be inconsistently referenced
- New evidence must be manually traced to each applicable filing
- Gaps in evidence coverage are difficult to detect

### Architecture

```
master-reference/
    |
    +-- README.md                          <-- You are here (system overview)
    |
    +-- COMPLIANCE_EVIDENCE_REFERENCE.md   <-- Evidence-to-filing cross-reference
    |
    (future reference files added here)
```

The master reference directory acts as an **index layer** that points into existing directories rather than duplicating content:

```
master-reference/COMPLIANCE_EVIDENCE_REFERENCE.md
       |
       |  references (by path)
       |
       +---> CONSOLIDATED_FILINGS_2026_02_06/   (final filings)
       +---> ANNEXURES/                          (JF01-JF12, SF1-SF8)
       +---> evidence/                           (raw evidence)
       +---> 2-CRIMINAL-CASE/                    (criminal framework)
       +---> legal-analysis/                     (legal analysis)
       +---> UPDATED_DRAFTS/                     (analysis drafts)
       +---> jax-response/                       (respondent materials)
       +---> docs/legal/                         (legal documentation)
```

### Relationship to Existing Indexes

| Index | Scope | Use Case |
|-------|-------|----------|
| `ARENA_INDEX.md` | Legal principles (60+) mapped to cases | "Which law applies?" |
| `AGENT_INDEX.md` | All 1,700+ evidence files by category | "What evidence exists?" |
| `RELATIONS_INDEX.md` | Arena-Agent connections | "How do laws connect to evidence?" |
| **`master-reference/`** | **Evidence mapped to specific filings** | **"Which evidence supports which complaint?"** |

The master reference does not replace existing indexes. It adds a **filing-oriented view** on top of them, answering the question: *"For this specific complaint, what are all the evidence records I need?"*

### Reference Files

| File | Description |
|------|-------------|
| [COMPLIANCE_EVIDENCE_REFERENCE.md](COMPLIANCE_EVIDENCE_REFERENCE.md) | Maps all evidence records to the four primary compliance filings (CIPC, POPIA, NPA Tax Fraud, Commercial Crime) |

### How to Use

**When preparing a filing:**
1. Open `COMPLIANCE_EVIDENCE_REFERENCE.md`
2. Navigate to the relevant filing section (CIPC, POPIA, NPA, or SAPS)
3. Review the evidence table for all supporting records with paths
4. Check the statutory violations mapping against available evidence
5. Use the cross-reference matrix to identify shared evidence

**When adding new evidence:**
1. Place the evidence file in the appropriate `evidence/` or `ANNEXURES/` subdirectory
2. Update `COMPLIANCE_EVIDENCE_REFERENCE.md` with the new record
3. Mark which filings the evidence supports in the cross-reference matrix
4. Update the respondent mapping if the evidence implicates a new party

**When reviewing coverage gaps:**
1. Check the cross-reference matrix at the bottom of the reference file
2. Each row is an evidence record; each column is a filing
3. Empty cells indicate the evidence is not used by that filing
4. Rows with only one X may indicate underutilized evidence

### Key Concepts

- **Evidence ID**: Short identifier (e.g., SF10, JF03, EVENT_014) used consistently across all filings
- **Filing**: One of the four compliance submissions (CIPC, POPIA, NPA, SAPS)
- **Cross-Reference Matrix**: Table showing which evidence supports which filings
- **Respondent Mapping**: Table showing each person's role across all four filings
- **Statutory Mapping**: Table linking specific statutory violations to their supporting evidence

### Maintenance

When changes occur in the repository:

- **New evidence added** -> Update the relevant filing section and cross-reference matrix
- **Filing amended** -> Verify evidence references are still accurate
- **New filing created** -> Add a new section to `COMPLIANCE_EVIDENCE_REFERENCE.md`
- **Evidence relocated** -> Update paths in all references

---

*Master Reference System v1.0 | Case 2025-137857 | 2026-02-06*
