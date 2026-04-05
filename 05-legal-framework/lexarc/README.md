# LEX Archive (lexarc)

**Purpose:** Historical versioned files from the LEX Legal Reasoning Framework

This directory contains archived versioned files that have been superseded by canonical versions in the main `lex/` directory. These files are preserved for:

- Historical reference and audit trail
- Rollback capability if needed
- Understanding the evolution of the framework
- Research and analysis of development patterns

---

## Directory Structure

```
lexarc/
├── entity_relation_framework_v*.scm    # Entity-relation frameworks (v1-v72)
├── high_resolution_agent_models_v*.scm # Agent models (v65-v73)
├── legal_aspects_comprehensive_v*.scm  # Legal aspects (v58-v73)
├── jax_dan_response_improvements_v*.md # Response improvements (v61-v73)
├── verification_report_v*.md           # Verification reports
├── lex_refinement_analysis_v*.json     # Refinement analysis
├── lex-framework-parsed.json           # Parsed framework data
│
├── summaries/                          # Implementation summaries
│   └── V*_IMPLEMENTATION_SUMMARY.md
│
├── analysis/                           # Analysis reports
│   └── *_ANALYSIS*.md/json
│
├── docs/                               # Historical documentation
│   ├── PHASE_*.md
│   └── LEX_*.md
│
├── v69-refinement/                     # V69 refinement batch
│
└── [domain subdirectories]/            # Domain-specific archives
    ├── civ/za/
    ├── cri/za/
    ├── cmp/za/
    ├── trs/za/
    ├── dat/za/
    ├── evid/za/
    ├── frn/za/
    ├── lab/za/
    ├── lv1/
    └── prof-eth/za/
```

---

## Version History

### Entity-Relation Framework

| Version Range | Key Features |
|---------------|--------------|
| v1-v20 | Initial framework development |
| v21-v40 | Enhanced entity attributes, temporal chains |
| v41-v50 | AtomSpace integration, truth values |
| v51-v60 | High-resolution agents, legal aspects |
| v61-v70 | Comprehensive enhancements, AD integration |
| v71-v72 | Optimal resolution, atomspace enhanced |

**Canonical Version:** v72 → `lex/core/entity_relation_framework_canonical.scm`

### High-Resolution Agent Models

| Version Range | Key Features |
|---------------|--------------|
| v65-v67 | Initial comprehensive models |
| v70-v72 | Enhanced verification |
| v73 | Optimal resolution |

**Canonical Version:** v73 → `lex/core/high_resolution_agent_models_canonical.scm`

### Legal Aspects Comprehensive

| Version Range | Key Features |
|---------------|--------------|
| v58-v60 | Initial comprehensive aspects |
| v70-v71 | Financial fraud enhanced |
| v73 | Optimal resolution |

**Canonical Version:** v73 → `lex/core/legal_aspects_comprehensive_canonical.scm`

---

## File Statistics

| Category | Count |
|----------|-------|
| Entity-Relation Frameworks | ~72 |
| Agent Models | ~9 |
| Legal Aspects | ~6 |
| Response Improvements | ~13 |
| Verification Reports | ~8 |
| Implementation Summaries | ~15 |
| Analysis Reports | ~10 |
| **Total Archived Files** | **~234** |

---

## Usage

These files are archived for reference only. For active development, use the canonical files in `lex/core/`:

```scheme
;; Use canonical version
(use-modules (lex core entity-relation-framework-canonical))

;; NOT archived version
;; (use-modules (lexarc entity-relation-framework-v72))
```

---

## Recovery

If a rollback is needed, canonical files can be restored from specific versions:

```bash
# Example: Restore v71 as canonical
cp lexarc/entity_relation_framework_v71_atomspace_enhanced.scm \
   lex/core/entity_relation_framework_canonical.scm
```

---

## Archive Date

**Archived:** 2026-01-25  
**Reason:** Framework consolidation and cleanup
