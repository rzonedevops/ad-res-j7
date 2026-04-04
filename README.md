# AD-RES-J7: Forensic Case Analysis Corpus

**Case 2025-137857** | Gauteng High Court | Revenue Stream Hijacking, Perjury & Weaponized Litigation

---

## Repository Structure

This corpus is organized into seven numbered sections for clear forensic navigation:

```
ad-res-j7/
├── 01-case/              Court filings, affidavits, legal proceedings
├── 02-evidence/          Primary source materials & annexures
├── 03-analysis/          Analytical work product & findings
├── 04-response/          Jax & Daniel response materials
├── 05-legal-framework/   LEX Scheme files (legal principles)
├── 06-tools/             Scripts, database layer, engines
├── 07-docs/              Documentation, reports, guides
├── tests/                Test suite (40+ files)
├── archive/              Superseded & historical materials
└── CASE_SUMMARY_2025_137857.md   Executive summary
```

---

## Quick Start

**Read first:** [`CASE_SUMMARY_2025_137857.md`](CASE_SUMMARY_2025_137857.md) — comprehensive summary of what happened, who did it, and when.

### By Role

| You are... | Start here |
|------------|-----------|
| **Attorney / Legal** | [`01-case/`](01-case/) → court documents & affidavits |
| **Forensic Analyst** | [`02-evidence/`](02-evidence/) → primary evidence & annexures |
| **Investigator** | [`03-analysis/`](03-analysis/) → foreknowledge scoring, timelines, entity analysis |
| **Respondent Team** | [`04-response/`](04-response/) → defense materials for Jax & Daniel |
| **Technical / Developer** | [`06-tools/`](06-tools/) → database, scripts, inference engine |

---

## 01-case/ — Court Filings & Legal Proceedings

The case record: court documents, affidavits, and legal proceedings organized by track.

```
01-case/
├── court-documents/       PDFs of court filings, orders, interdict applications
├── affidavits/            Final answering affidavits (MD + DOCX), supporting affidavits
├── civil-response/        Civil track: annexure index, supporting affidavits, rebuttal
├── criminal-case/         Criminal track: arena/agent mapping
├── external-validation/   Third-party verification package
└── mediation/             Settlement & mediation materials
```

**Key files:**
- `court-documents/KF0019-UrgentApplication.pdf` — The urgent application
- `affidavits/ANSWERING_AFFIDAVIT_JACQUELINE_FAUCITT.md` — Jax's answering affidavit
- `affidavits/SUPPORTING_AFFIDAVIT_DANIEL_JAMES_FAUCITT.md` — Daniel's supporting affidavit

---

## 02-evidence/ — Primary Source Materials

All evidence organized by type, with 12 main annexure packages (JF01–JF12).

```
02-evidence/
├── annexures/             JF01-JF12: main evidence packages (each with README)
├── annexures-supporting/  Additional annexure materials
├── bank-records/          Bank statements & transfer records
├── bank-statements/       Additional bank documentation
├── correspondence/        Email & letter evidence
├── shopify_reports/       Shopify platform data & invoices
├── witness-statements/    Witness statements & declarations
├── legal-documents/       Legal correspondence & documents
├── invoices/              Financial invoices
├── identity-documents/    ID documents
├── director_loan_accounts/ DLA records
├── rezonance-misallocation/ ReZonance financial misallocation evidence
├── business-operations/   Business operational evidence
├── character-references/  Character reference letters
├── computer-expenses/     IT & computing expense records
├── property_unit9_southview_park/ Property evidence
├── UK_tax_residency/      UK tax residency documentation
├── 2025-11-14-batch*/     Evidence batches (4 batches)
├── INDEX.md               Comprehensive evidence index
└── INDEX.json             Machine-readable evidence index
```

**Key annexures:**
- `annexures/JF01/` — Shopify Plus email evidence (forensic time capsule)
- `annexures/JF03/` — Financial records & revenue analysis
- `annexures/JF06/` — Court documents & interdicts
- `annexures/JF08/` — Comprehensive fraud package

---

## 03-analysis/ — Analytical Work Product

Forensic analysis, foreknowledge scoring, financial forensics, and entity relationship mapping.

```
03-analysis/
├── foreknowledge/         Provable foreknowledge analysis (placeholder for cross-repo)
├── financial-forensics/   Fund flow analysis, anomaly detection
├── revenue-hijacking/     Revenue stream hijacking evidence
│   ├── court-package/     POPIA-compliant vs opaque system comparison
│   └── evidence-collection/ Audit trails, domain evidence, Shopify platform
├── burden-of-proof/       Legal burden analysis & strategy
├── timeline/              Event timelines & visualizations
├── entity-analysis/       Hypergraph entity mapping & relationships
│   ├── hypergraph-mapping/
│   ├── legal-hypergraphql/
│   └── shared-hypergraphql-schema/
├── ARENA_INDEX.md         60+ legal principles mapped to all 3 cases
├── AGENT_INDEX.md         100+ evidence files mapped to all 3 cases
└── RELATIONS_INDEX.md     Complete arena-agent mapping
```

**Key navigation indexes:**
- `ARENA_INDEX.md` — Legal framework (rules & principles)
- `AGENT_INDEX.md` — Evidence base (facts & documents)
- `RELATIONS_INDEX.md` — How legal principles connect to evidence

---

## 04-response/ — Defense Materials

Response materials for both respondents, organized by individual.

```
04-response/
├── jax/                   Jacqueline Faucitt's response
│   ├── AD/                Affidavit defense (priority-ranked 1-5)
│   ├── evidence-attachments/
│   ├── family-trust/      Trust breach evidence (chronological)
│   ├── financial-flows/   Unauthorized transfers & diversions
│   ├── revenue-theft/     Revenue hijacking evidence chain
│   └── source-documents/
└── dan/                   Daniel Faucitt's response
    ├── AD/                Affidavit defense (priority-ranked 1-5)
    ├── annexures/         DAN-DL, DAN-IT, DAN-LW, DAN-UE, JAX-RP
    ├── criminal-complaint/
    ├── rule-42-rescission/
    └── source-documents/
```

---

## 05-legal-framework/ — LEX Scheme Files

Legal principles encoded in Scheme, organized by domain of law.

```
05-legal-framework/
├── lv1/          First-order principles (known_laws.scm)
├── civ/          Civil law (South African)
├── cri/          Criminal law
├── civ-proc/     Civil procedure
├── trs/          Trust & estate law
├── adm/          Administrative law
├── cmp/          Company law
├── cst/          Constitutional law
├── evid/         Evidence law
├── env/          Environmental law
├── eth/          Ethics
├── prof-eth/     Professional ethics
├── frn/          Franchise law
├── int/          International law
├── lab/          Labour law
└── hypergraph/   Hypergraph integration layer
```

---

## 06-tools/ — Scripts, Database & Engines

All technical tooling: database layer, automation scripts, analysis scripts, and the LEX inference engine.

```
06-tools/
├── db/                    Database layer (managers, migrations, config)
│   ├── config.js          Connection config (Neon/PostgreSQL)
│   ├── *-migrate.js       Schema migrations (6 schemas)
│   └── *-manager.js       Manager classes (7 managers)
├── database/              Additional database resources (schema, docs, data)
├── scripts/               Automation & validation scripts
├── analysis-scripts/      Python & JS analysis scripts (moved from root)
├── lex-engine/            LEX inference engine (transformer-based legal reasoning)
├── lib/                   Shared utilities (JS + Python)
├── grammars/              ANTLR/Flex/Bison grammar files
├── implementation/        Implementation phase plans
├── schema.graphql         GraphQL schema
└── example_queries.graphql
```

### Database Setup

```bash
npm run db:migrate              # Base schema
npm run db:hierarchy:setup      # Hierarchical issues
npm run db:hypergraph:setup     # Hypergraph
npm run db:xref:setup           # Cross-references
npm run db:lex:setup            # LEX inference
npm run db:grip:setup           # Grip metrics
```

### Key npm Scripts

```bash
# Testing
npm test                        # Run all tests
npm run test:hierarchical-issues
npm run test:cross-reference
npm run test:evidence-completeness

# Validation
npm run validate-evidence-completeness
npm run verify-all-cross-references
npm run validate-dates

# Analysis
npm run db:lex:demo             # Legal inference demo
npm run db:grip:stats           # Quality metrics
npm run db:xref:consolidations  # Find duplicate issues
```

---

## 07-docs/ — Documentation & Guides

Comprehensive documentation organized by purpose.

```
07-docs/
├── legal/                 Legal documents, frameworks, analysis
│   ├── frameworks/        8 legal branch frameworks
│   ├── analysis/          Case analysis documents
│   ├── evidence/          Evidence guides
│   ├── annexures/         Annexure indexes
│   └── affidavits/        Final affidavit documentation
├── strategic/             Legal strategy & burden of proof
│   ├── arguments/
│   ├── assessments/
│   └── burden-of-proof/
├── technical/             Technical implementation guides
├── reports/               Status, verification, completion reports
├── quickstart/            Quick-start guides
├── formal-specs/          Formal specifications
├── visualizations/        Critical path & timeline visualizations
├── GRIP_WORKFLOW.md       Optimal understanding workflows
└── OPTIMIZATION_QUICKSTART.md
```

---

## archive/ — Superseded Materials

Historical and superseded materials preserved for reference. Not part of the active corpus.

```
archive/
├── analysis-main-snapshot/  18,600-file snapshot of analysis repo (UPDATED_DRAFTS)
├── backups/                 Pre-consolidation backups
├── lex-refinements/         Dated LEX analysis & refinement MDs
├── legal-analysis-2025-11/  November 2025 legal analysis batch
├── affidavit-work/          Working affidavit drafts
├── historical/              Historical analysis
├── superseded/              Superseded implementations
└── [other archived materials]
```

---

## Core Legal Insight

**"Attention IS the lex inference engine"** — The system uses transformer attention mechanisms for legal reasoning. Guilt determination emerges from learned relational patterns in attention weights, not from explicit rules. Multi-head attention provides different legal lenses: causal, intentional, temporal, and normative.

---

## Prerequisites

- **Node.js** v20+
- **PostgreSQL** v12+ (or Neon serverless)
- **Python** v3.8+

```bash
npm ci                    # Install JS dependencies
pip install -r requirements.txt  # Install Python dependencies
cp .env.example .env      # Configure database connection
```

---

## Related Repositories

| Repository | Purpose |
|------------|---------|
| `rzonedevops/analysis` | Provable foreknowledge analysis, forensic audit, routing analysis |
| `rzonedevops/fincosys` | Financial ecosystem: 122K transactions, fund flow tracing |
| `9cog/fincosys` | Hypergraph-based financial entity management prototype |

---

*Case 2025-137857 | Restructured for optimal cognitive grip | Generated 2026-04-04*
