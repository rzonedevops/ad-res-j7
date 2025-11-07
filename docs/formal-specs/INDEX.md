# Formal Specifications & Architecture Documentation - Master Index

**System:** AD-RES-J7 Legal Reasoning Platform  
**Case:** 2025-137857 (Jacqueline & Daniel Faucitt vs Peter Faucitt)  
**Version:** 1.0  
**Date:** 2025-11-07

---

## Quick Navigation

### 📋 Start Here
- [Architecture Overview (Mermaid Diagrams)](architecture_overview.md) - Best first read for all audiences
- [Formal Specs README](README.md) - Guide to reading the Z++ specifications

### 📊 For Different Audiences

**Legal Team / Non-Technical Stakeholders:**
1. [Architecture Overview → Section 9: Case-Specific Implementation](architecture_overview.md#9-case-specific-implementation-2025-137857)
2. [Architecture Overview → Section 3: Database Architecture](architecture_overview.md#3-database-architecture)
3. Focus on Mermaid diagrams (visual understanding)

**System Architects:**
1. [Architecture Overview](architecture_overview.md) - Complete system design
2. [System State Specification](system_state.zpp) - Component interactions
3. [Integrations Specification](integrations.zpp) - System boundaries

**Backend Developers:**
1. [Data Model Specification](data_model.zpp) - Database schemas and invariants
2. [Operations Specification](operations.zpp) - API contracts and state transitions
3. [Architecture Overview → Section 5: Integration Architecture](architecture_overview.md#5-integration-architecture)

**Integration Engineers / DevOps:**
1. [Integrations Specification](integrations.zpp) - All external API contracts
2. [Architecture Overview → Section 6: Deployment Architecture](architecture_overview.md#6-deployment-architecture)
3. [Operations Specification → Query Operations](operations.zpp#query-operations-read-only)

**Database Administrators:**
1. [Data Model Specification](data_model.zpp) - All schemas with constraints
2. [Architecture Overview → Section 3.1: Multi-Schema Design](architecture_overview.md#31-multi-schema-design)
3. Implementation: [`/db/schema.js`](/db/schema.js), [`/db/hypergraph-schema.js`](/db/hypergraph-schema.js)

---

## Documentation Structure

### 1. Architecture Documentation (28KB)
**File:** [`architecture_overview.md`](architecture_overview.md)

**Content Highlights:**
- 11 Mermaid diagrams visualizing the entire system
- System architecture with 3 layers (Client, Application, Data)
- Component breakdowns:
  - Legal Attention Engine (PyTorch transformer)
  - Burden of Proof Analyzer (3 standards: civil, criminal, mathematical)
  - Hierarchical Issue Manager (4-level structure)
  - Hypergraph Manager (multi-way relationships)
  - Lex Inference Engine (formal legal reasoning)
- Multi-schema database (4 interconnected schemas)
- Data flow pipelines with sequence diagrams
- Integration architecture (GitHub, document storage, legal databases)
- Case 2025-137857 specifics (R10.227M+ damages, 2,866 files)

**Key Diagrams:**
- System Architecture Overview
- Legal Attention Engine Architecture
- Burden of Proof Analyzer Flow
- Database ER Diagram (4 schemas)
- Hierarchical Issue Structure (4 levels)
- Data Flow Sequences
- Integration Boundaries

**Best For:** Executive overview, presentations, system understanding

---

### 2. Data Model Specification (21KB, 850 lines)
**File:** [`data_model.zpp`](data_model.zpp)

**Schemas Defined:** 35

**Major Components:**
- **Base Schema (5 schemas):**
  - `CaseDocument` - Legal documents with metadata
  - `EvidenceRecord` - Evidence items with amounts
  - `Issue` - Work items (features/tasks)
  - `LegalArgument` - Top-level legal strategies
  - `IssueParagraph` - Fact groupings within features

- **Hierarchical Schema (3 schemas):**
  - `IssueArgumentLink` - Features → Arguments
  - `ParagraphIssueLink` - Tasks → Paragraphs
  - `CrossReference` - Issues → Evidence/Documents

- **Hypergraph Schema (4 schemas):**
  - `HypergraphNode` - Entities (documents, people, events)
  - `HypergraphEdge` - Multi-way relationships
  - `HypergraphRelation` - Node-edge connections
  - `Hypergraph` - Complete graph structure

- **Lex Inference Schema (6 schemas):**
  - `Agent` - Actors in the legal scenario
  - `Arena` - Contextual spaces (legal, business, temporal)
  - `Event` - Occurrences in possibility space
  - `Configuration` - Agent-arena-event instantiations
  - `GuiltAssignment` - Responsibility attribution
  - `CompleteDataModel` - Full integration

**Key Invariants:**
- Referential integrity across all schemas
- Uniqueness constraints on IDs and codes
- Temporal consistency (created ≤ updated)
- Domain constraints (e.g., weight: 0-100, rank ≥ 1)
- Case-specific: total_damages ≥ 10,227,000

**Best For:** Database design, schema understanding, data integrity verification

---

### 3. System State Specification (16KB, 650 lines)
**File:** [`system_state.zpp`](system_state.zpp)

**Schemas Defined:** 12

**Major Components:**
- **Legal Attention Engine State:**
  - `LegalEmbedding` - Event/agent/norm embeddings
  - `PositionalEncoding` - Temporal/causal/epistemic/deontic positions
  - `AttentionWeights` - 4-head attention (causal, intentional, temporal, normative)
  - `LegalAttentionEngineState` - Complete engine state

- **Burden of Proof Analyzer State:**
  - `ProofRequirement` - Element requirements per standard
  - `ProofGap` - Missing evidence identification
  - `GuiltAnalysis` - Complete guilt analysis per agent
  - `BurdenOfProofAnalyzerState` - Analyzer state

- **Hierarchical Issue Manager State:**
  - `FeatureStrength` - Aggregate strength calculation
  - `ConsolidationOpportunity` - Duplicate detection
  - `HierarchicalIssueManagerState` - Manager state

- **Other Components:**
  - `HypergraphManagerState` - Graph metrics (degrees, arities)
  - `LexInferenceEngineState` - Legal principles and rules
  - `CaseManagerState` - Case timeline and damages
  - `SystemState` - Complete system integration
  - `InitialSystemState` - Startup state
  - `SystemInvariants` - Global invariants

**Key Invariants:**
- Cross-component consistency (guilt scores ↔ agents)
- Attention weight normalization (sum to 1.0)
- Burden thresholds (civil >50%, criminal >95%, mathematical 100%)
- Feature strength aggregation
- Case-specific: Peter has guilt assignments with confidence >50%

**Best For:** Runtime state understanding, component interactions, invariant verification

---

### 4. Operations Specification (30KB, 1200 lines)
**File:** [`operations.zpp`](operations.zpp)

**Operations Defined:** 25 (22 state-changing + 3 read-only)

**Major Categories:**

**Legal Attention Engine Operations (2):**
- `ForwardPass` - Compute guilt scores and attention weights from events/agents/norms
- `TrainAttentionEngine` - Train transformer model on labeled data

**Burden of Proof Operations (2):**
- `AnalyzeBurdenOfProof` - Analyze guilt under specific standard (civil/criminal/mathematical)
- `UpdateProofRequirements` - Modify proof requirements for elements

**Hierarchical Issue Operations (5):**
- `CreateLegalArgument` - Create top-level legal strategy
- `CreateFeatureIssue` - Create feature linked to argument
- `CreateParagraph` - Create fact grouping within feature
- `CreateTaskIssue` - Create task within paragraph
- `CalculateFeatureStrength` - Compute aggregate strength from paragraphs/tasks

**Hypergraph Operations (3):**
- `CreateHypergraphNode` - Add entity to graph
- `CreateHypergraphEdge` - Create multi-way relationship
- `FindRelatedNodes` - Graph traversal with transitive closure

**Lex Inference Operations (3):**
- `CreateAgent` - Add agent (person, corporation, trust)
- `CreateEvent` - Add event to timeline
- `AssignGuilt` - Attribute responsibility with evidence chain

**Case Management Operations (2):**
- `AddCaseDocument` - Store legal document
- `AddEvidence` - Add evidence record (updates total damages)

**Query Operations (3 - read-only):**
- `GetAllEvidence` - Retrieve all evidence
- `GetFeaturesForArgument` - Get features linked to argument
- `GetGuiltAssignmentsForAgent` - Get guilt for specific agent

**Operation Structure:**
Each operation specifies:
- **Preconditions:** What must be true before operation
- **Postconditions:** What will be true after operation
- **Frame Conditions:** What remains unchanged
- **Error Handling:** Result status and error codes

**Best For:** API design, backend implementation, operation contracts

---

### 5. Integrations Specification (20KB, 800 lines)
**File:** [`integrations.zpp`](integrations.zpp)

**Schemas Defined:** 18  
**Operations Defined:** 10

**Major Integrations:**

**GitHub API (3 operations):**
- `GitHubIssueCreate` - Create issue with labels/assignees
- `GitHubIssueUpdate` - Update issue state/content
- `GitHubIssueSync` - Bidirectional sync with local database
- **Rate Limit:** 5000 req/hour (authenticated)
- **Endpoints:** `/repos/{owner}/{repo}/issues`

**Document Storage (2 operations):**
- `DocumentUpload` - Upload file with checksum verification
- `DocumentRetrieve` - Download file with integrity check
- `DocumentStorageSync` - Sync metadata with local database
- **Supported Formats:** PDF, DOCX, images, emails

**Legal Database (2 operations):**
- `CaseLawSearch` - Search case law by query/jurisdiction
- `StatutoryLookup` - Retrieve statutory provisions
- `LegalResearchIntegration` - Combined research workflow
- **Jurisdictions:** South Africa, UK, International

**Email & Notifications (2 operations):**
- `SendEmail` - Deliver email with attachments
- `SendNotification` - Multi-channel (email, SMS, push)
- `NotifyOnGuiltAssignment` - Automatic stakeholder alerts
- **Priority Levels:** Low, Normal, High, Urgent

**Integration Monitoring (3 operations):**
- `CheckSystemHealth` - Health check for external systems
- `RetryFailedIntegration` - Exponential backoff retry logic
- `SyncIssuesFromGitHub` - End-to-end GitHub sync workflow
- **Metrics:** Connection status, error count, rate limits, sync timestamps

**API Contracts Include:**
- Endpoint specifications (base URL, path, method)
- Request/response schemas
- Authentication requirements
- Rate limits and retries
- Error handling

**Best For:** Integration design, API consumption, monitoring, DevOps

---

### 6. Specifications Guide (15KB)
**File:** [`README.md`](README.md)

**Content:**
- Overview and purpose of formal specifications
- Z++ notation primer (for non-experts)
- Reading order by audience (legal, architect, developer, DevOps)
- Key properties verified (100+ invariants)
- Specification statistics (65 schemas, 32 operations, 18 integrations)
- Implementation mapping (spec → code correspondence)
- Usage examples with Z++ code snippets
- Maintenance procedures and version control
- Future enhancements (refinement, temporal logic, concurrency)

**Best For:** Understanding how to use the specifications, learning Z++ notation

---

## Specification Statistics

| Metric | Value |
|--------|-------|
| **Total Files** | 6 |
| **Total Size** | 130KB |
| **Total Lines** | 3,500+ |
| **Schemas** | 65 |
| **Operations** | 32 |
| **Diagrams** | 11 Mermaid |
| **Invariants** | 100+ |
| **Comments** | Comprehensive |

---

## Key Properties Verified

### Data Integrity ✅
- Referential integrity (all FKs reference valid entities)
- Uniqueness (PKs, unique constraints)
- Domain constraints (bounded values)
- Temporal consistency (timestamps ordered)

### Legal Reasoning ✅
- Guilt invariance (guilty party always guilty)
- Burden standards (civil >50%, criminal >95%, mathematical 100%)
- Evidence chains (all guilt justified)
- Attention normalization (weights sum to 1.0)

### Hierarchical Structure ✅
- Acyclic hierarchy (no circular dependencies)
- Parent-child consistency (tasks reference valid features)
- Rank ordering (unique ranks within parent)
- Weight bounds (0-100)
- 3×3 rule (1 feature ≈ 3 paragraphs ≈ 9 tasks)

### Hypergraph Structure ✅
- Arity constraint (edges connect ≥2 nodes)
- No isolated nodes (all nodes have degree >0)
- Position uniqueness (within each edge)
- Referential integrity (relations reference valid nodes/edges)

### Case 2025-137857 ✅
- Total damages ≥ R10,227,000
- Parties present (Jax, Dan, Peter)
- Peter has guilt assignments (confidence >50%)
- Evidence codes follow "JF##" format
- Case number "2025-137857" throughout

---

## Implementation Mapping

| Specification | Implementation File | Function/Table |
|---------------|---------------------|----------------|
| `CaseDocument` | `db/schema.js` | `caseDocuments` table |
| `EvidenceRecord` | `db/schema.js` | `evidenceRecords` table |
| `Issue` | `db/schema.js` | `issues` table |
| `HypergraphNode` | `db/hypergraph-schema.js` | `hypergraph_nodes` table |
| `Agent` | `db/lex-inference-schema.js` | `agents` table |
| `CreateFeatureIssue` | `db/hierarchical-issue-manager.js` | `createFeatureIssue()` |
| `CreateHypergraphNode` | `db/hypergraph-manager.js` | `createNode()` |
| `ForwardPass` | `legal_attention_engine.py` | `forward()` method |
| `AnalyzeBurdenOfProof` | `burden_of_proof_analyzer.py` | `analyze_burden_of_proof()` |
| `GitHubIssueSync` | Future implementation | GitHub API wrapper |

---

## Usage Scenarios

### Scenario 1: Understand System Architecture
1. Read [Architecture Overview](architecture_overview.md)
2. Focus on Mermaid diagrams
3. Review Section 9 for Case 2025-137857

### Scenario 2: Implement New Operation
1. Review [Operations Specification](operations.zpp) for similar operation
2. Check [Data Model](data_model.zpp) for relevant schemas
3. Ensure [System State](system_state.zpp) invariants are maintained
4. Map to implementation using table above

### Scenario 3: Add External Integration
1. Review [Integrations Specification](integrations.zpp)
2. Follow API contract template
3. Add to `IntegrationState` monitoring
4. Implement health checks and retry logic

### Scenario 4: Verify Data Integrity
1. Check [Data Model](data_model.zpp) for invariants
2. Review [System State](system_state.zpp) for cross-schema constraints
3. Run database queries to validate
4. Use [Operations](operations.zpp) preconditions as checks

### Scenario 5: Debug Legal Reasoning
1. Review [Architecture → Legal Attention Engine](architecture_overview.md#21-legal-attention-engine-pythonpytorch)
2. Check [System State → Attention Weights](system_state.zpp) for state
3. Trace [Operations → ForwardPass](operations.zpp) for data flow
4. Verify burden thresholds in [Operations → AnalyzeBurdenOfProof](operations.zpp)

---

## Cross-References to Existing Documentation

### Core Documentation
- [`README.md`](/README.md) - System overview
- [`db/README.md`](/db/README.md) - Database setup guide
- [`lex/README.md`](/lex/README.md) - Legal framework overview

### Case Documentation
- [`ATTORNEY_EXECUTIVE_BRIEFING.md`](/ATTORNEY_EXECUTIVE_BRIEFING.md) - Attorney guide
- [`COMPREHENSIVE_EVIDENCE_INDEX.md`](/COMPREHENSIVE_EVIDENCE_INDEX.md) - Evidence catalog
- [`HIERARCHICAL_ISSUES_SUMMARY.md`](/HIERARCHICAL_ISSUES_SUMMARY.md) - Issue structure

### Implementation Guides
- [`BURDEN_OF_PROOF_IMPLEMENTATION_COMPLETE.md`](/BURDEN_OF_PROOF_IMPLEMENTATION_COMPLETE.md) - Proof standards
- [`HIERARCHICAL_ISSUES_QUICKSTART.md`](/HIERARCHICAL_ISSUES_QUICKSTART.md) - Quick start
- [`CROSS_REFERENCE_QUICKSTART.md`](/CROSS_REFERENCE_QUICKSTART.md) - Cross-references

---

## Maintenance and Updates

### When to Update Specifications

**Must Update When:**
- Database schema changes (update `data_model.zpp`)
- New operations added (update `operations.zpp`)
- API contracts change (update `integrations.zpp`)
- System state modified (update `system_state.zpp`)
- Architecture changes (update `architecture_overview.md`)

**Version Control:**
- Major version (X.0): Breaking changes
- Minor version (1.X): Additions, non-breaking changes
- Patch version (1.0.X): Clarifications, fixes

**Review Process:**
1. Developer proposes spec change
2. Architect reviews for consistency
3. Update implementation to match
4. Commit spec + code together
5. Update this index if structure changes

---

## Support and Contact

### Questions by Topic
- **Architecture:** See [architecture_overview.md](architecture_overview.md)
- **Data Models:** See [data_model.zpp](data_model.zpp)
- **Operations:** See [operations.zpp](operations.zpp)
- **Integrations:** See [integrations.zpp](integrations.zpp)
- **Z++ Notation:** See [README.md](README.md) → Z++ Primer

### Technical Support
- **Database Issues:** `/db/README.md`
- **Legal Framework:** `/lex/README.md`
- **Case 2025-137857:** Attorney briefing documents
- **GitHub Issues:** Repository issue tracker

---

## Version History

| Version | Date | Files Changed | Description |
|---------|------|---------------|-------------|
| 1.0 | 2025-11-07 | All 6 files | Initial comprehensive specification set |

---

## Quick Links

- [📋 Architecture Overview](architecture_overview.md)
- [🗂️ Data Model Spec](data_model.zpp)
- [⚙️ System State Spec](system_state.zpp)
- [🔧 Operations Spec](operations.zpp)
- [🔌 Integrations Spec](integrations.zpp)
- [📖 Specifications Guide](README.md)
- [🏠 Repository Root](/)
- [💼 Attorney Briefing](/ATTORNEY_EXECUTIVE_BRIEFING.md)
- [📊 Evidence Index](/COMPREHENSIVE_EVIDENCE_INDEX.md)

---

**Generated:** 2025-11-07  
**System:** AD-RES-J7 Legal Reasoning Platform  
**Case:** 2025-137857  
**Specification Version:** 1.0

**End of Master Index**
