# Technical Architecture & Formal Specifications

**Date:** 2025-11-07  
**Version:** 1.0  
**Location:** `/docs/formal-specs/`

---

## What's New

**Comprehensive technical architecture documentation and Z++ formal specifications** have been generated for the AD-RES-J7 Legal Reasoning Platform and Case 2025-137857.

### Quick Access

📋 **[Master Index](/docs/formal-specs/INDEX.md)** - Start here for complete navigation

📊 **[Architecture Overview](/docs/formal-specs/architecture_overview.md)** - Best first read (28KB, 11 diagrams)

📖 **[Specifications Guide](/docs/formal-specs/README.md)** - How to read the Z++ specs

---

## What's Included

### 1. Architecture Documentation (28KB)
**File:** `/docs/formal-specs/architecture_overview.md`

- **11 Mermaid diagrams** visualizing the entire system
- System architecture (3 layers: Client, Application, Data)
- Component deep-dives:
  - Legal Attention Engine (PyTorch transformer)
  - Burden of Proof Analyzer (civil/criminal/mathematical standards)
  - Hierarchical Issue Manager (4-level structure)
  - Hypergraph Manager (multi-way relationships)
  - Lex Inference Engine (formal legal reasoning)
- Multi-schema database (4 interconnected schemas)
- Data flow pipelines
- Integration architecture
- Case 2025-137857 specifics (R10.227M+ damages)

### 2. Z++ Formal Specifications (115KB)
**Files:** `/docs/formal-specs/*.zpp`

#### 2.1 Data Model (21KB, 850 lines, 35 schemas)
- All database schemas with formal invariants
- Base, hierarchical, hypergraph, and lex inference schemas
- Referential integrity, uniqueness, temporal consistency
- Case-specific constraints

#### 2.2 System State (16KB, 650 lines, 12 schemas)
- Runtime state of all components
- Legal attention engine state (embeddings, attention weights)
- Burden analyzer state (proof requirements, gaps)
- Hierarchical manager state (strengths, consolidations)
- Complete system integration with invariants

#### 2.3 Operations (30KB, 1200 lines, 25 operations)
- All state-changing operations with pre/post-conditions
- Legal reasoning: ForwardPass, TrainAttentionEngine, AnalyzeBurdenOfProof
- Hierarchical: CreateArgument, CreateFeature, CreateParagraph, CreateTask
- Hypergraph: CreateNode, CreateEdge, FindRelatedNodes
- Case management: AddDocument, AddEvidence
- Query operations (read-only)

#### 2.4 Integrations (20KB, 800 lines, 18 schemas, 10 ops)
- GitHub API integration (issue sync)
- Document storage (upload/retrieve with checksums)
- Legal database integration (case law, statutes)
- Email and notification services
- Integration monitoring (health checks, retries, rate limits)

---

## Why Formal Specifications?

### Benefits

1. **Precise Documentation**
   - Unambiguous description of system behavior
   - Mathematical rigor eliminates interpretation errors
   - Serves as definitive reference

2. **Verification**
   - Prove correctness properties
   - Ensure invariants hold in all states
   - Validate operations preserve system integrity

3. **Design Validation**
   - Catch architectural flaws early
   - Verify cross-component consistency
   - Ensure integration contracts are sound

4. **Implementation Guide**
   - Direct mapping from spec to code
   - Clear operation contracts (pre/post-conditions)
   - Explicit error handling

5. **Communication**
   - Bridge between legal team and engineers
   - Common language for stakeholders
   - Both technical (Z++) and accessible (diagrams)

### What's Verified

✅ **Data Integrity** - 35 schemas with 100+ invariants  
✅ **Legal Reasoning** - Burden thresholds, guilt invariance, attention normalization  
✅ **Hierarchical Structure** - Acyclic, rank-ordered, weighted (3×3 rule)  
✅ **Hypergraph Structure** - Connected, multi-way relationships (arity ≥2)  
✅ **Case 2025-137857** - Damages ≥R10.227M, Peter guilt assignments, evidence codes

---

## For Different Audiences

### Legal Team / Stakeholders
1. [Architecture Overview → Case 2025-137857](/docs/formal-specs/architecture_overview.md#9-case-specific-implementation-2025-137857)
2. Focus on Mermaid diagrams (visual understanding)
3. [Specifications Guide](/docs/formal-specs/README.md) for notation primer

### System Architects
1. [Architecture Overview](/docs/formal-specs/architecture_overview.md) - Complete design
2. [System State Spec](/docs/formal-specs/system_state.zpp) - Component interactions
3. [Integrations Spec](/docs/formal-specs/integrations.zpp) - System boundaries

### Backend Developers
1. [Data Model Spec](/docs/formal-specs/data_model.zpp) - Database schemas
2. [Operations Spec](/docs/formal-specs/operations.zpp) - API contracts
3. [Architecture → Integration Architecture](/docs/formal-specs/architecture_overview.md#5-integration-architecture)

### Integration Engineers / DevOps
1. [Integrations Spec](/docs/formal-specs/integrations.zpp) - All external APIs
2. [Architecture → Deployment](/docs/formal-specs/architecture_overview.md#6-deployment-architecture)
3. [Operations → Query Operations](/docs/formal-specs/operations.zpp#query-operations-read-only)

---

## Quick Stats

| Metric | Value |
|--------|-------|
| **Total Documentation** | 6 files, 130KB |
| **Formal Specs** | 3,500+ lines Z++ |
| **Schemas** | 65 data structures |
| **Operations** | 32 (25 mutations + 7 queries) |
| **Diagrams** | 11 Mermaid |
| **Invariants** | 100+ verified properties |
| **Coverage** | Core lex framework + Case 2025-137857 |

---

## How to Use

### 1. Understanding the System
Start with [Architecture Overview](/docs/formal-specs/architecture_overview.md) for high-level understanding with diagrams.

### 2. Implementing Features
1. Check [Operations Spec](/docs/formal-specs/operations.zpp) for similar operation
2. Review [Data Model](/docs/formal-specs/data_model.zpp) for relevant schemas
3. Ensure [System State](/docs/formal-specs/system_state.zpp) invariants maintained
4. Map to implementation using [Master Index](/docs/formal-specs/INDEX.md)

### 3. Adding Integrations
1. Review [Integrations Spec](/docs/formal-specs/integrations.zpp)
2. Follow API contract template
3. Add to `IntegrationState` monitoring
4. Implement health checks and retry logic

### 4. Verifying Correctness
1. Check [Data Model](/docs/formal-specs/data_model.zpp) for invariants
2. Review [System State](/docs/formal-specs/system_state.zpp) for constraints
3. Use [Operations](/docs/formal-specs/operations.zpp) preconditions as validation

### 5. Debugging Issues
1. Trace operation through [Operations Spec](/docs/formal-specs/operations.zpp)
2. Check state invariants in [System State](/docs/formal-specs/system_state.zpp)
3. Verify data integrity in [Data Model](/docs/formal-specs/data_model.zpp)
4. Review integration contracts in [Integrations](/docs/formal-specs/integrations.zpp)

---

## Complete File List

1. **[INDEX.md](/docs/formal-specs/INDEX.md)** (17KB)
   - Master navigation index
   - Quick links by audience
   - Cross-references to existing docs

2. **[architecture_overview.md](/docs/formal-specs/architecture_overview.md)** (28KB)
   - 11 Mermaid diagrams
   - Complete system architecture
   - Case 2025-137857 details

3. **[data_model.zpp](/docs/formal-specs/data_model.zpp)** (21KB)
   - 35 schemas
   - Database formalization
   - All invariants

4. **[system_state.zpp](/docs/formal-specs/system_state.zpp)** (16KB)
   - 12 state schemas
   - Component states
   - Global invariants

5. **[operations.zpp](/docs/formal-specs/operations.zpp)** (30KB)
   - 25 operations
   - Pre/post-conditions
   - Frame conditions

6. **[integrations.zpp](/docs/formal-specs/integrations.zpp)** (20KB)
   - 18 integration schemas
   - 10 workflows
   - API contracts

7. **[README.md](/docs/formal-specs/README.md)** (15KB)
   - Z++ notation primer
   - Reading guide
   - Usage examples

---

## Cross-References

### Existing Documentation
- [Main README](/README.md) - System overview
- [Database Guide](/db/README.md) - Setup instructions
- [Legal Framework](/lex/README.md) - Lex principles
- [Attorney Briefing](/ATTORNEY_EXECUTIVE_BRIEFING.md) - Case guide
- [Evidence Index](/COMPREHENSIVE_EVIDENCE_INDEX.md) - Evidence catalog
- [Hierarchical Issues](/HIERARCHICAL_ISSUES_SUMMARY.md) - Issue structure

### Implementation
- Database schemas: `/db/schema.js`, `/db/hypergraph-schema.js`, `/db/lex-inference-schema.js`
- Managers: `/db/hierarchical-issue-manager.js`, `/db/hypergraph-manager.js`
- Legal reasoning: `legal_attention_engine.py`, `burden_of_proof_analyzer.py`
- Lex framework: `/lex/lv1/known_laws.scm` (60+ principles)

---

## Maintenance

### When to Update
- Database schema changes → Update `data_model.zpp`
- New operations → Update `operations.zpp`
- API changes → Update `integrations.zpp`
- State changes → Update `system_state.zpp`
- Architecture changes → Update `architecture_overview.md`

### Version Control
- Major (X.0): Breaking changes
- Minor (1.X): Additions
- Patch (1.0.X): Clarifications

### Process
1. Propose spec change
2. Architect review
3. Update implementation
4. Commit together
5. Update index if needed

---

## Next Steps

### For First-Time Users
1. Read [Master Index](/docs/formal-specs/INDEX.md)
2. Review [Architecture Overview](/docs/formal-specs/architecture_overview.md)
3. Focus on your role's recommended path
4. Refer to [Specifications Guide](/docs/formal-specs/README.md) for Z++ help

### For Developers
1. Bookmark [Operations Spec](/docs/formal-specs/operations.zpp) for API reference
2. Keep [Data Model](/docs/formal-specs/data_model.zpp) open for schema reference
3. Check invariants when making changes
4. Map spec to code using implementation table

### For Architects
1. Review [System State](/docs/formal-specs/system_state.zpp) for component design
2. Validate [Integrations](/docs/formal-specs/integrations.zpp) for boundaries
3. Use [Architecture](/docs/formal-specs/architecture_overview.md) for presentations

---

## Support

**Questions?**
- Technical: See relevant specification file
- Z++ Notation: [README.md](/docs/formal-specs/README.md) → Primer
- Case 2025-137857: Attorney briefing documents
- General: Repository issue tracker

**Contributing:**
- Propose specification updates via pull request
- Follow version control process
- Update both spec and implementation together
- Maintain documentation consistency

---

## Version

**Specification Version:** 1.0  
**Release Date:** 2025-11-07  
**Authors:** System Architects  
**Status:** Complete  

---

**[📋 Go to Master Index](/docs/formal-specs/INDEX.md)**
