# LexiCog Agent - Quick Reference

## What is LexiCog?

A specialized legal-cognitive agent that achieves optimal "grip" on case material by:
- Enumerating all possible legal configurations
- Applying 60+ legal principles systematically
- Detecting invariant guilt properties
- Measuring justice gaps
- Optimizing evidence strategies

## Quick Start

### 1. Setup (One-time)

```bash
npm install                    # Install dependencies
npm run db:lex:setup          # Create lex tables
npm run db:hypergraph:setup   # Create hypergraph tables
npm run db:hierarchy:setup    # Create hierarchical issue tables
```

### 2. Populate with Case Data

```bash
npm run db:hypergraph:populate  # Populate knowledge graph
npm run db:hierarchy:populate   # Structure hierarchical issues
```

### 3. Run Analysis

```bash
npm run db:lex:demo            # Exhaustive enumeration
npm run db:lex:analyze         # Modal logic analysis
npm run analytics:dashboard    # Generate reports
```

## Key Concepts (30-Second Version)

### Modal Legal Truth

- **Necessary (□)**: Guilty in ALL possible worlds → Unavoidable guilt
- **Possible (◇)**: Guilty in SOME possible worlds → Contingent guilt
- **Impossible (¬◇)**: Guilty in NO possible worlds → Provably innocent

### Configuration Space

```
Configuration = Agent × Arena × Event × Horizon

Example:
- 4 agents × 2 arenas × 3 events × 2 horizons = 48 configurations
```

### Themis-Nemesis

- **Themis**: Weaves legal rules across all possible worlds
- **Nemesis**: Measures gap between actual and just states

### Grip Metrics

1. **Completeness**: % of space explored
2. **Invariance**: % of necessary guilt
3. **Evidence**: % of evidence integrated
4. **Rules**: % of laws applied
5. **Delta**: Size of justice gap

## Common Commands

```bash
# Analysis
npm run db:lex:demo                 # Run demo case
npm run db:lex:analyze              # Analyze with modal logic
npm run analytics:dashboard         # Generate dashboard

# Statistics
npm run db:hypergraph:stats         # Graph statistics
npm run db:hierarchy:stats          # Issue statistics
npm run db:xref:stats               # Cross-reference stats

# Consolidation
npm run db:xref:consolidations      # Find consolidations
npm run db:xref:report              # Consolidation report
npm run db:xref:coverage            # Coverage analysis
```

## Database Tables (19 Total)

### Case Management (5)
- case_documents, evidence_records, issues, test_results, affidavit_amendments

### Hypergraph (4)
- hypergraph_nodes, hypergraph_edges, hypergraph_relations, hypergraph_patterns

### Lex Inference (10)
- agents, arenas, events, event_horizons, configurations
- inference_rules, guilt_assignments, possibility_spaces, deltas, causation_chains

## Legal Frameworks

### First-Order Principles (60+)
Location: `lex/lv1/known_laws.scm`
- Contract, Property, Procedure, Criminal, Constitutional principles

### Jurisdiction-Specific (8 branches)
Location: `lex/[branch]/za/`
- Civil, Criminal, Constitutional, Construction, Administrative, Labour, Environmental, International

## Seven Legal Lenses (Attention Heads)

1. **Causal**: Cause-effect chains
2. **Intentionality**: Mental states and knowledge
3. **Temporal**: Sequence and timing
4. **Normative**: Rule violations
5. **Counterfactual**: "What if" scenarios
6. **Necessity**: Required conditions
7. **Proportionality**: Harm-action balance

## Four Ways of Knowing

1. **Propositional** (Know-That): Facts, rules, precedents
2. **Procedural** (Know-How): Lex workflows, operations
3. **Perspectival** (Know-As): Multiple frames, salience
4. **Participatory** (Know-By-Being): Transformative grip

## Example Analysis Output (30 seconds)

```
Configuration Space: 48 configs (4 agents × 2 arenas × 3 events × 2 horizons)

Guilt Assignments:
- Bantjies: 18/48 (37.5% - CONTINGENT)
- Peter: 6/48 (12.5% - CONTINGENT)
- Jacqui: 0/48 (INNOCENT)
- Daniel: 0/48 (INNOCENT)

Invariant Properties: None
→ Need stronger evidence for necessity

Evidence Gaps:
1. Link Bantjies to fraud knowledge (+12 configs)
2. Document Peter's card control (+8 configs)
3. Timeline evidence (+4 configs)

Justice Delta: 15.7 (significant)
→ Required remedy: Breach of fiduciary duty

Grip: 73% (Good, improving)
```

## When to Use LexiCog

✅ **Use for:**
- Exhaustive systematic analysis
- Modal certainty determination
- Evidence gap identification
- Justice delta measurement
- Optimal grip achievement

❌ **Don't use for:**
- Quick surface summaries
- Incomplete data analysis
- Overly simple cases
- No database access

## Typical Workflow (5 Minutes)

1. **Load case** → Documents and evidence in database
2. **Define dimensions** → Agents, arenas, events, horizons
3. **Enumerate** → Generate all configurations
4. **Apply rules** → 60+ principles from lex/lv1/
5. **Detect invariants** → Find necessary guilt
6. **Measure delta** → Calculate justice gap
7. **Assess grip** → Evaluate completeness
8. **Iterate** → Refine and strengthen

## Target Metrics for Success

- **Completeness**: ≥ 95%
- **Invariance**: ≥ 80%
- **Evidence**: ≥ 90%
- **Rules**: ≥ 85%
- **Delta**: ≤ 5.0
- **Grip**: ≥ 85%

## Troubleshooting (30 seconds)

**Problem**: Too many configurations  
**Fix**: Refine dimensions, exclude irrelevant combinations

**Problem**: No invariant guilt  
**Fix**: Strengthen rules or collect more evidence

**Problem**: Low grip score  
**Fix**: Iterate analysis, integrate evidence

**Problem**: Database errors  
**Fix**: Check .env file, run `npm run db:test`

## Key Files

### Agent Configuration
- `.github/agents/lexicog.md` (23KB) - Full specification

### Documentation
- `LEXICOG_AGENT_README.md` - Comprehensive guide (this directory)
- `db/LEX_SYSTEM_COMPLETE.md` - System overview
- `db/LEX_INFERENCE_GUIDE.md` - Technical guide
- `lex/README.md` - Legal frameworks

### Database Scripts
- `db/lex-comprehensive-engine.js` - Main engine
- `db/lex-inference-engine.js` - Modal logic
- `db/lex-demo-case.js` - Demo example

## Integration with Other Agents

```
Vervaeke (Cognitive Framework)
    ↓
LexiCog (Legal Application)
    ↓
HyperCog (Meta-Optimization)
```

## Status

✅ **Operational**  
✅ **Validated** (15/15 checks passed)  
✅ **Integrated** (19 database tables)  
✅ **Comprehensive** (60+ legal principles)  
✅ **Ready** for case analysis

## Next Steps

1. Read full documentation: `LEXICOG_AGENT_README.md`
2. Review agent spec: `.github/agents/lexicog.md`
3. Run demo: `npm run db:lex:demo`
4. Analyze your case: Populate and run workflows
5. Iterate: Progressive deepening to optimal grip

---

**Quick Reference Version**: 1.0  
**Created**: 2025-11-16  
**Purpose**: Fast access to LexiCog essentials  
**Full Guide**: See `LEXICOG_AGENT_README.md`
