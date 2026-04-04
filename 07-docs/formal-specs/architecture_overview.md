# Technical Architecture Documentation - AD-RES-J7 System
## Comprehensive System Architecture with Formal Analysis

**Document Version:** 1.0  
**Date:** 2025-11-07  
**Repository:** cogpy/ad-res-j7  
**Case:** 2025-137857 (Jacqueline & Daniel Faucitt vs Peter Faucitt)

---

## Executive Summary

The AD-RES-J7 system is a hybrid **legal reasoning and case management platform** that combines:
1. **AI-powered legal inference** using transformer-based attention mechanisms (PyTorch)
2. **Multi-schema relational database** for case data, evidence, and legal reasoning (PostgreSQL)
3. **Formal legal framework** with 60+ foundational principles and 8 branches of law (Scheme)
4. **Case-specific implementation** for Case 2025-137857 with R10.227M+ in documented damages

The system architecture integrates **symbolic legal reasoning** (Scheme-based lex framework) with **neural attention mechanisms** (PyTorch transformers) to model legal causation, burden of proof, and guilt determination.

---

## 1. System Architecture Overview

```mermaid
graph TB
    subgraph "Client Layer"
        CLI[CLI Tools]
        SCRIPTS[Automation Scripts]
    end
    
    subgraph "Application Layer"
        subgraph "Legal Reasoning Engine (Python)"
            LAE[Legal Attention Engine<br/>PyTorch Transformer]
            BOP[Burden of Proof Analyzer<br/>Civil/Criminal/Mathematical]
            LEX_PY[Lex Framework Loader]
        end
        
        subgraph "Case Management Backend (Node.js)"
            HIM[Hierarchical Issue Manager]
            HGM[Hypergraph Manager]
            LEX_MGR[Lex Inference Engine]
            CASE_MGR[Case Manager]
            XREF[Cross-Reference Manager]
        end
    end
    
    subgraph "Data Layer (PostgreSQL)"
        subgraph "Base Schema"
            DOCS[case_documents]
            EVIDENCE[evidence_records]
            ISSUES[issues]
        end
        
        subgraph "Hierarchical Schema"
            ARGS[legal_arguments]
            PARAS[issue_paragraphs]
            LINKS[issue_argument_links]
        end
        
        subgraph "Hypergraph Schema"
            NODES[hypergraph_nodes]
            EDGES[hypergraph_edges]
            RELATIONS[hypergraph_relations]
        end
        
        subgraph "Lex Inference Schema"
            AGENTS[agents]
            ARENAS[arenas]
            EVENTS[events]
            CONFIGS[configurations]
            GUILT[guilt_assignments]
        end
    end
    
    subgraph "Legal Framework (Scheme)"
        LV1[Level 1: 60+ Principles<br/>known_laws.scm]
        CIV[Civil Law Framework]
        CRI[Criminal Law Framework]
        CON[Constitutional Law]
        LAB[Labour Law]
        ENV[Environmental Law]
        ADM[Administrative Law]
        CONST[Construction Law]
        INTL[International Law]
    end
    
    CLI --> HIM
    CLI --> HGM
    CLI --> LEX_MGR
    SCRIPTS --> LAE
    SCRIPTS --> BOP
    
    LAE --> LEX_PY
    BOP --> LAE
    LEX_PY --> LV1
    
    HIM --> DOCS
    HIM --> EVIDENCE
    HIM --> ISSUES
    HIM --> ARGS
    HIM --> PARAS
    HIM --> LINKS
    
    HGM --> NODES
    HGM --> EDGES
    HGM --> RELATIONS
    
    LEX_MGR --> AGENTS
    LEX_MGR --> ARENAS
    LEX_MGR --> EVENTS
    LEX_MGR --> CONFIGS
    LEX_MGR --> GUILT
    
    CASE_MGR --> DOCS
    CASE_MGR --> EVIDENCE
    
    LV1 --> CIV
    LV1 --> CRI
    LV1 --> CON
    LV1 --> LAB
    LV1 --> ENV
    LV1 --> ADM
    LV1 --> CONST
    LV1 --> INTL
    
    style LAE fill:#ff9999
    style BOP fill:#ff9999
    style HIM fill:#99ccff
    style HGM fill:#99ccff
    style LV1 fill:#99ff99
```

---

## 2. Component Architecture

### 2.1 Legal Attention Engine (Python/PyTorch)

The core AI component that performs legal reasoning using transformer attention mechanisms.

```mermaid
graph LR
    subgraph "Legal Attention Engine Architecture"
        INPUT[Legal Events<br/>Agents<br/>Norms]
        
        subgraph "Encoding Layer"
            EMBED[Legal Embedder<br/>Events → Vectors]
            POS[Legal Positional Encoding<br/>Temporal/Causal/Epistemic/Deontic]
        end
        
        subgraph "Transformer Layers"
            MHA[Multi-Head Legal Attention<br/>4 Specialized Heads]
            HEAD1[Causal Head<br/>Cause-Effect Chains]
            HEAD2[Intentional Head<br/>Mental States]
            HEAD3[Temporal Head<br/>Sequence & Timing]
            HEAD4[Normative Head<br/>Rule Violations]
            FFN[Feed Forward Network]
        end
        
        subgraph "Counterfactual Reasoning"
            CROSS[Cross-Attention<br/>Actual vs Possible Worlds]
        end
        
        subgraph "Output Layer"
            GUILT[Guilt Scores<br/>Per Agent]
            ATTN[Attention Weights<br/>Juridical Heat Map]
        end
        
        INPUT --> EMBED
        EMBED --> POS
        POS --> MHA
        MHA --> HEAD1
        MHA --> HEAD2
        MHA --> HEAD3
        MHA --> HEAD4
        HEAD1 --> FFN
        HEAD2 --> FFN
        HEAD3 --> FFN
        HEAD4 --> FFN
        FFN --> CROSS
        CROSS --> GUILT
        CROSS --> ATTN
    end
    
    style GUILT fill:#ff6666
    style ATTN fill:#ffcc66
```

**Key Features:**
- **Multi-head attention** with 4 specialized legal reasoning heads
- **Legal positional encoding** captures temporal, causal, epistemic, and deontic positions
- **Cross-attention** for counterfactual reasoning (what-if scenarios)
- **Attention weights** form interpretable "juridical heat maps"
- **Emergent guilt determination** from learned relational patterns

### 2.2 Burden of Proof Analyzer

Implements three legal standards of proof and provides strategic guidance.

```mermaid
graph TD
    subgraph "Burden of Proof Analyzer"
        INPUT[Legal Events<br/>Evidence<br/>Agents]
        
        subgraph "Proof Standards"
            CIVIL[Civil Standard<br/>Balance of Probabilities<br/>>50% likelihood]
            CRIMINAL[Criminal Standard<br/>Beyond Reasonable Doubt<br/>~95-99% certainty]
            MATH[Mathematical Standard<br/>Invariant All Conditions<br/>Logical certainty]
        end
        
        subgraph "Elements to Prove"
            CAUSATION[Causation<br/>But-for Test]
            INTENT[Intent<br/>Mens Rea]
            KNOWLEDGE[Knowledge<br/>Epistemic State]
            DUTY[Duty<br/>Legal Obligation]
            BREACH[Breach<br/>Violation]
            HARM[Harm<br/>Actual Damage]
        end
        
        subgraph "Analysis Output"
            PROB[Element Probabilities<br/>Per Standard]
            GAP[Proof Gaps<br/>Missing Evidence]
            STRAT[Recommended Strategy<br/>For Dan & Jax]
        end
        
        INPUT --> CIVIL
        INPUT --> CRIMINAL
        INPUT --> MATH
        
        CIVIL --> CAUSATION
        CIVIL --> INTENT
        CIVIL --> KNOWLEDGE
        CRIMINAL --> CAUSATION
        CRIMINAL --> INTENT
        CRIMINAL --> KNOWLEDGE
        MATH --> CAUSATION
        MATH --> INTENT
        
        CAUSATION --> DUTY
        INTENT --> BREACH
        KNOWLEDGE --> HARM
        
        DUTY --> PROB
        BREACH --> GAP
        HARM --> STRAT
    end
    
    style CIVIL fill:#99ccff
    style CRIMINAL fill:#ff9999
    style MATH fill:#99ff99
```

---

## 3. Database Architecture

### 3.1 Multi-Schema Design

The system uses **four interconnected schemas** in PostgreSQL:

```mermaid
erDiagram
    %% Base Schema
    case_documents ||--o{ evidence_records : "references"
    case_documents {
        serial id PK
        varchar case_number
        varchar document_type
        varchar title
        text content
        varchar file_path
        jsonb metadata
        timestamp created_at
    }
    
    evidence_records {
        serial id PK
        varchar case_number
        varchar evidence_type
        text description
        varchar file_path
        varchar source
        timestamp date_collected
        jsonb metadata
    }
    
    issues ||--o{ issue_paragraphs : "has"
    issues ||--o{ issue_argument_links : "linked to"
    issues ||--o{ issue_cross_references : "references"
    issues {
        serial id PK
        integer issue_number UK
        varchar title
        text description
        varchar priority
        varchar status
        jsonb labels
        varchar issue_type
        integer parent_issue_id FK
        integer rank_order
        integer weight
        timestamp created_at
    }
    
    %% Hierarchical Schema
    legal_arguments ||--o{ issue_argument_links : "proves/disproves"
    legal_arguments {
        serial id PK
        varchar argument_name
        text description
        varchar argument_type
        text strategy
        varchar status
        jsonb metadata
    }
    
    issue_paragraphs ||--o{ paragraph_issue_links : "contains"
    issue_paragraphs {
        serial id PK
        integer feature_issue_id FK
        integer paragraph_number
        varchar title
        text content
        integer rank_order
        integer weight
        jsonb metadata
    }
    
    %% Hypergraph Schema
    hypergraph_nodes ||--o{ hypergraph_relations : "participates in"
    hypergraph_edges ||--o{ hypergraph_relations : "connects"
    hypergraph_nodes {
        serial id PK
        varchar node_type
        varchar entity_id
        varchar label
        text description
        jsonb metadata
    }
    
    hypergraph_edges {
        serial id PK
        varchar edge_type
        varchar label
        text description
        integer strength
        varchar direction
        jsonb metadata
    }
    
    hypergraph_relations {
        serial id PK
        integer node_id FK
        integer edge_id FK
        varchar role
        integer position
        integer weight
    }
    
    %% Lex Inference Schema
    agents ||--o{ guilt_assignments : "assigned guilt"
    arenas ||--o{ events : "contains"
    events ||--o{ configurations : "in config"
    configurations ||--o{ guilt_assignments : "determines"
    
    agents {
        serial id PK
        varchar agent_type
        varchar entity_id UK
        varchar name
        jsonb attributes
        varchar legal_status
    }
    
    arenas {
        serial id PK
        varchar arena_type
        varchar name
        varchar jurisdiction
        jsonb constraints
        jsonb boundary_conditions
    }
    
    events {
        serial id PK
        varchar event_type
        text description
        timestamp temporal_position
        integer arena_id FK
        jsonb preconditions
        jsonb postconditions
        jsonb counterfactuals
    }
    
    configurations {
        serial id PK
        varchar configuration_name
        jsonb agent_ids
        jsonb arena_ids
        jsonb event_ids
        jsonb horizon_ids
        boolean is_possible
        boolean is_actual
        integer probability
        jsonb world_state
    }
    
    guilt_assignments {
        serial id PK
        integer configuration_id FK
        integer agent_id FK
        varchar guilt_type
        varchar charge
        jsonb evidence_chain
        jsonb rule_applications
        integer confidence
    }
```

### 3.2 Hierarchical Issue Structure

The hierarchical issue system organizes legal work into a 4-level structure:

```mermaid
graph TD
    subgraph "Legal Argument Structure"
        ARG1[Legal Argument<br/>Strategy: Defense/Offense]
        
        subgraph "Feature Level"
            FEAT1[Feature Issue #1<br/>Proves/Disproves Argument]
            FEAT2[Feature Issue #2<br/>Proves/Disproves Argument]
            FEAT3[Feature Issue #3<br/>Proves/Disproves Argument]
        end
        
        subgraph "Paragraph Level (Feature 1)"
            PARA1[Paragraph 1.1<br/>Rank 1, Weight 100<br/>Highest Influence]
            PARA2[Paragraph 1.2<br/>Rank 2, Weight 90<br/>High Influence]
            PARA3[Paragraph 1.3<br/>Rank 3, Weight 75<br/>Medium Influence]
        end
        
        subgraph "Task Level (Paragraph 1.1)"
            TASK1[Task #101<br/>Rank 1, Weight 100]
            TASK2[Task #102<br/>Rank 2, Weight 95]
            TASK3[Task #103<br/>Rank 3, Weight 85]
        end
        
        ARG1 --> FEAT1
        ARG1 --> FEAT2
        ARG1 --> FEAT3
        
        FEAT1 --> PARA1
        FEAT1 --> PARA2
        FEAT1 --> PARA3
        
        PARA1 --> TASK1
        PARA1 --> TASK2
        PARA1 --> TASK3
    end
    
    style ARG1 fill:#ff9999
    style FEAT1 fill:#ffcc99
    style PARA1 fill:#ffff99
    style TASK1 fill:#ccffcc
```

**Structure Rules:**
- **Legal Argument** → **Feature Issue** → **Paragraph** → **Task Issue**
- Each level has **rank ordering** (1 = highest importance)
- Each level has **weighting** (0-100 = degree of influence)
- Aggregate strength calculated from weighted sum of children
- Aim for **3×3 rule**: 1 feature ≈ 3 paragraphs ≈ 9 tasks

---

## 4. Data Flow Architecture

### 4.1 Legal Reasoning Pipeline

```mermaid
sequenceDiagram
    participant User
    participant CLI
    participant LexEngine
    participant LegalAttention
    participant BurdenAnalyzer
    participant Database
    
    User->>CLI: Analyze legal case
    CLI->>Database: Fetch events, agents, norms
    Database-->>CLI: Return case data
    
    CLI->>LexEngine: Initialize reasoning
    LexEngine->>Database: Load legal principles (lv1)
    Database-->>LexEngine: 60+ principles
    
    CLI->>LegalAttention: Forward(events, agents, norms)
    LegalAttention->>LegalAttention: Embed inputs
    LegalAttention->>LegalAttention: Add positional encoding
    LegalAttention->>LegalAttention: Multi-head attention (4 heads)
    LegalAttention->>LegalAttention: Cross-attention (counterfactuals)
    LegalAttention-->>CLI: Guilt scores + attention weights
    
    CLI->>BurdenAnalyzer: Analyze(guilt_scores, standard)
    BurdenAnalyzer->>BurdenAnalyzer: Check elements (causation, intent, etc)
    BurdenAnalyzer->>BurdenAnalyzer: Calculate probabilities
    BurdenAnalyzer->>BurdenAnalyzer: Identify proof gaps
    BurdenAnalyzer-->>CLI: Analysis + strategy
    
    CLI->>Database: Store guilt assignments
    CLI->>Database: Store attention weights
    CLI-->>User: Return analysis results
```

### 4.2 Hierarchical Issue Management Pipeline

```mermaid
sequenceDiagram
    participant User
    participant CLI
    participant HierarchyMgr
    participant Database
    participant CrossRef
    
    User->>CLI: Create feature issue
    CLI->>HierarchyMgr: createFeatureIssue(data)
    HierarchyMgr->>Database: INSERT into issues
    Database-->>HierarchyMgr: issue_id
    HierarchyMgr->>Database: Link to legal_argument
    HierarchyMgr-->>CLI: feature_issue
    
    User->>CLI: Create paragraph
    CLI->>HierarchyMgr: createParagraph(feature_id, rank, weight)
    HierarchyMgr->>Database: INSERT into issue_paragraphs
    Database-->>HierarchyMgr: paragraph_id
    HierarchyMgr-->>CLI: paragraph
    
    User->>CLI: Create task issue
    CLI->>HierarchyMgr: createTaskIssue(paragraph_id, rank, weight)
    HierarchyMgr->>Database: INSERT into issues (parent_id)
    HierarchyMgr->>Database: INSERT into paragraph_issue_links
    HierarchyMgr-->>CLI: task_issue
    
    User->>CLI: Add evidence reference
    CLI->>CrossRef: addCrossReference(issue_id, evidence)
    CrossRef->>Database: INSERT into issue_cross_references
    CrossRef->>Database: Check consolidation opportunities
    Database-->>CrossRef: similar issues found
    CrossRef->>Database: INSERT into cross_reference_consolidations
    CrossRef-->>CLI: consolidation_recommendation
    
    User->>CLI: Calculate feature strength
    CLI->>HierarchyMgr: getFeatureStrength(feature_id)
    HierarchyMgr->>Database: Fetch paragraphs + tasks
    HierarchyMgr->>HierarchyMgr: Weighted sum aggregation
    HierarchyMgr-->>CLI: strength_score
```

### 4.3 Hypergraph Relationship Pipeline

```mermaid
sequenceDiagram
    participant User
    participant CLI
    participant HypergraphMgr
    participant Database
    
    User->>CLI: Create relationship
    CLI->>HypergraphMgr: createEdge(nodes, type)
    
    loop For each entity
        HypergraphMgr->>Database: Find or create node
        Database-->>HypergraphMgr: node_id
    end
    
    HypergraphMgr->>Database: INSERT into hypergraph_edges
    Database-->>HypergraphMgr: edge_id
    
    loop For each node
        HypergraphMgr->>Database: INSERT into hypergraph_relations
        HypergraphMgr->>Database: (node_id, edge_id, role, weight)
    end
    
    HypergraphMgr-->>CLI: edge created
    
    User->>CLI: Query relationships
    CLI->>HypergraphMgr: findRelated(node_id, edge_type)
    HypergraphMgr->>Database: JOIN nodes, edges, relations
    Database-->>HypergraphMgr: related_nodes
    HypergraphMgr-->>CLI: relationship_graph
```

---

## 5. Integration Architecture

### 5.1 External System Integrations

```mermaid
graph TB
    subgraph "External Systems"
        GITHUB[GitHub API<br/>Issue Management]
        DOCS[Document Storage<br/>Evidence Files]
        LEGAL_DB[Legal Databases<br/>Case Law & Statutes]
    end
    
    subgraph "Integration Layer"
        CASE_MGR[Case Manager<br/>Document Import]
        ISSUE_GEN[Issue Generator<br/>GitHub Sync]
        LEX_LOADER[Lex Framework Loader<br/>Legal Principles]
    end
    
    subgraph "Core System"
        DATABASE[(PostgreSQL<br/>All Schemas)]
        LEX_ENGINE[Lex Inference Engine]
        HIERARCHY[Hierarchical Manager]
    end
    
    GITHUB <--> ISSUE_GEN
    DOCS --> CASE_MGR
    LEGAL_DB --> LEX_LOADER
    
    ISSUE_GEN --> HIERARCHY
    CASE_MGR --> DATABASE
    LEX_LOADER --> LEX_ENGINE
    
    HIERARCHY --> DATABASE
    LEX_ENGINE --> DATABASE
    
    style GITHUB fill:#99ccff
    style DOCS fill:#ffcc99
    style LEGAL_DB fill:#99ff99
```

### 5.2 API Contracts

The system exposes several internal APIs for integration:

**HierarchicalIssueManager API:**
- `createLegalArgument(name, description, type, strategy)`
- `createFeatureIssue(number, title, description, argumentId)`
- `createTaskIssue(number, title, parentFeatureId, paragraphId, rank, weight)`
- `createParagraph(featureId, number, title, content, rank, weight)`
- `linkIssueToArgument(issueId, argumentId, linkType, strength)`
- `addCrossReference(issueId, refType, refId, path, title, relationshipType)`
- `getFeatureStrength(featureId)` - Calculates aggregate strength
- `detectConsolidationOpportunities()` - Finds duplicate work

**HypergraphManager API:**
- `createNode(nodeType, label, entityId, description, metadata)`
- `createEdge(edgeType, label, nodes, strength, direction, metadata)`
- `getEdgeWithNodes(edgeId)` - Retrieves complete relationship
- `findNodesByType(nodeType)` - Filters by entity type
- `findRelatedNodes(nodeId, edgeType, maxDepth)` - Graph traversal
- `findPath(sourceId, targetId, maxHops)` - Shortest path

**LexInferenceEngine API:**
- `createAgent(agentType, name, attributes, legalStatus)`
- `createArena(arenaType, name, jurisdiction, constraints)`
- `createEvent(eventType, description, temporalPosition, arenaId)`
- `createConfiguration(name, agentIds, arenaIds, eventIds, isPossible, isActual)`
- `assignGuilt(configId, agentId, guiltType, charge, evidenceChain, confidence)`
- `enumeratePossibleWorlds(constrains)` - Generate configurations

---

## 6. Deployment Architecture

### 6.1 Runtime Environment

```mermaid
graph TB
    subgraph "Runtime Environment"
        subgraph "Python Runtime"
            PYTORCH[PyTorch 2.0+<br/>Legal Attention Engine]
            NUMPY[NumPy<br/>Numerical Computing]
            MATPLOTLIB[Matplotlib/Seaborn<br/>Visualization]
        end
        
        subgraph "Node.js Runtime"
            NODE[Node.js v20+]
            DRIZZLE[Drizzle ORM]
            NEON[Neon Serverless Driver]
        end
        
        subgraph "Database"
            POSTGRES[(PostgreSQL 15+<br/>4 Schemas)]
        end
        
        subgraph "File Storage"
            EVIDENCE[Evidence Files<br/>PDFs, Images, Documents]
            LEX_FILES[Lex Framework<br/>49 Scheme Files]
        end
    end
    
    PYTORCH --> NODE
    NODE --> DRIZZLE
    DRIZZLE --> NEON
    NEON --> POSTGRES
    
    NODE --> EVIDENCE
    PYTORCH --> LEX_FILES
    NODE --> LEX_FILES
    
    style PYTORCH fill:#ff9999
    style NODE fill:#99ccff
    style POSTGRES fill:#99ff99
```

### 6.2 Configuration Management

**Environment Variables:**
- `DATABASE_URL` - PostgreSQL connection string
- `NODE_ENV` - Development/production mode
- `LOG_LEVEL` - Logging verbosity

**Database Migrations:**
- `npm run db:migrate` - Base schema
- `npm run db:hierarchy:setup` - Hierarchical issues schema
- `npm run db:hypergraph:setup` - Hypergraph schema
- `npm run db:lex:setup` - Lex inference schema

---

## 7. Performance Characteristics

### 7.1 Scalability

**Database:**
- Base schema: Handles 2,866+ files, R10.227M+ in damages
- Hierarchical schema: 2 arguments, 3 features, 7 paragraphs, 13+ tasks
- Hypergraph schema: Multi-way relationships with arbitrary arity
- Lex inference: Enumerates possibility spaces (combinatorial)

**Legal Attention Engine:**
- Input: Variable-length sequences (events, agents, norms)
- Time complexity: O(n²) for self-attention
- Space complexity: O(n × d_model) for embeddings
- Parallelizable: Batch processing across GPUs

### 7.2 Performance Optimization

**Database Indexing:**
- B-tree indexes on foreign keys
- GIN indexes on JSONB fields
- Partial indexes on status fields
- Covering indexes for common queries

**Caching Strategies:**
- Lex principles loaded once at startup
- Attention weights cached per configuration
- Feature strength calculations memoized
- Cross-reference consolidations computed incrementally

---

## 8. Security Architecture

### 8.1 Data Protection

```mermaid
graph LR
    subgraph "Security Layers"
        AUTH[Authentication<br/>GitHub OAuth]
        AUTHZ[Authorization<br/>Role-Based Access]
        AUDIT[Audit Trail<br/>All DB Operations]
        ENCRYPT[Encryption<br/>Data at Rest & Transit]
    end
    
    subgraph "Protected Assets"
        EVIDENCE[Evidence Files<br/>Confidential]
        CASE_DATA[Case Data<br/>Privileged]
        LEGAL_ANALYSIS[Legal Analysis<br/>Work Product]
    end
    
    AUTH --> AUTHZ
    AUTHZ --> AUDIT
    AUDIT --> ENCRYPT
    
    ENCRYPT --> EVIDENCE
    ENCRYPT --> CASE_DATA
    ENCRYPT --> LEGAL_ANALYSIS
    
    style AUTH fill:#ff9999
    style EVIDENCE fill:#ffcc99
```

### 8.2 Access Control

**Database Permissions:**
- Read-only for analysis queries
- Write access for case managers
- Admin access for schema migrations
- No direct public access

**API Security:**
- GitHub token authentication
- PostgreSQL SSL connections
- Environment variable secrets
- No hardcoded credentials

---

## 9. Case-Specific Implementation (2025-137857)

### 9.1 Case Overview

**Parties:**
- **Applicants:** Jacqueline Faucitt (Jax), Daniel James Faucitt (Dan)
- **Respondent:** Peter Faucitt
- **Related Parties:** Rynette, Bantjies (trustees)

**Claims:**
- **Revenue theft:** R3.141M+ (Shopify platform hijacking)
- **Financial flows:** R4.276M+ (unauthorized transfers)
- **Family trust:** R2.851M+ (trust fund misappropriation)
- **Total:** R10.227M+ in documented damages

**Legal Arguments (Hierarchical Structure):**
1. **Revenue Stream Hijacking** - Proves Peter's unauthorized control
2. **Financial Fraud** - Proves systematic theft from company accounts
3. **Fiduciary Breach** - Proves trustee violations

### 9.2 Case Data Model

```mermaid
erDiagram
    CASE_2025_137857 ||--o{ EVIDENCE_RECORDS : "contains"
    CASE_2025_137857 ||--o{ LEGAL_ARGUMENTS : "presents"
    CASE_2025_137857 ||--o{ ANNEXURES : "attaches"
    
    CASE_2025_137857 {
        string case_number "2025-137857"
        string jurisdiction "South Africa"
        date filing_date "2025-03"
        string status "Active"
        decimal total_damages "10227000+"
    }
    
    EVIDENCE_RECORDS {
        string evidence_code "JF01-JF10"
        string type "Bank/Shopify/Email"
        decimal amount
        date event_date
        string responsible_party
    }
    
    LEGAL_ARGUMENTS {
        string argument_name
        string proves "Revenue hijacking"
        integer confidence "95-99%"
        string burden_standard "Civil/Criminal"
    }
    
    ANNEXURES {
        string annexure_code "JF01-JF10"
        string document_type
        integer page_count
        date submission_date
    }
    
    FEATURE_ISSUES ||--o{ TASK_ISSUES : "decomposes into"
    FEATURE_ISSUES ||--o{ PARAGRAPHS : "organizes by"
    PARAGRAPHS ||--o{ TASK_ISSUES : "contains"
    
    FEATURE_ISSUES {
        integer issue_number
        string title
        integer argument_id FK
        string link_type "proves/disproves"
        integer strength "0-100"
    }
    
    PARAGRAPHS {
        integer id PK
        integer feature_issue_id FK
        integer rank_order "1=highest"
        integer weight "0-100"
        string content
    }
    
    TASK_ISSUES {
        integer issue_number
        integer parent_feature_id FK
        integer paragraph_id FK
        integer rank_order "1=highest"
        integer weight "0-100"
    }
```

### 9.3 Case-Specific Workflows

**Evidence Processing Workflow:**
1. Scan evidence packages (JF01-JF10 annexures)
2. Extract metadata (dates, amounts, parties)
3. Create hypergraph nodes for entities
4. Link to relevant legal arguments
5. Calculate burden of proof requirements
6. Generate cross-references for consolidation

**Legal Analysis Workflow:**
1. Load events from evidence (bank transfers, email communications)
2. Define agents (Peter, Jax, Dan, Rynette, Bantjies)
3. Apply legal principles (lv1: 60+ principles)
4. Run legal attention engine (guilt determination)
5. Run burden of proof analyzer (civil/criminal standards)
6. Generate juridical heat maps (attention visualization)
7. Output strategic recommendations

---

## 10. Technology Stack Summary

| Layer | Technology | Purpose |
|-------|-----------|---------|
| **AI/ML** | PyTorch 2.0+ | Legal attention transformer |
| **Backend** | Node.js v20+ | Case management, APIs |
| **Database** | PostgreSQL 15+ | Multi-schema persistence |
| **ORM** | Drizzle | Type-safe queries |
| **Legal Framework** | Scheme | Formal legal principles |
| **Visualization** | Matplotlib, Seaborn | Attention heat maps |
| **Testing** | Node.js Test Runner | Integration tests |
| **CI/CD** | GitHub Actions | Automated testing |

---

## 11. Future Extensions

### 11.1 Planned Enhancements

**Legal Reasoning:**
- Abductive reasoning engine (hypothesis generation)
- Analogical reasoning (transfer across cases)
- Case law citation network integration
- Natural language legal document parsing

**Scalability:**
- Distributed inference across multiple GPUs
- Sharded database for large case volumes
- Event sourcing for audit trail
- CQRS pattern for read-optimized queries

**Integration:**
- Court filing system APIs
- Legal database integrations (LexisNexis, Westlaw)
- Expert witness management
- Client communication portal

### 11.2 Research Directions

- **Interpretable AI:** Explaining attention-based guilt determination
- **Multi-jurisdictional reasoning:** Transfer learning across legal systems
- **Temporal reasoning:** Dynamic norms and evolving legal landscapes
- **Uncertainty quantification:** Bayesian confidence intervals for guilt scores

---

## 12. References

**Code Repository:**
- GitHub: https://github.com/cogpy/ad-res-j7
- Documentation: `/docs/` directory
- Tests: `/tests/` directory

**Key Documentation:**
- `README.md` - System overview
- `HIERARCHICAL_ISSUES_SUMMARY.md` - Issue structure
- `BURDEN_OF_PROOF_IMPLEMENTATION_COMPLETE.md` - Proof standards
- `COMPREHENSIVE_EVIDENCE_INDEX.md` - Evidence catalog
- `db/README.md` - Database setup guide

**Academic Foundations:**
- Transformer attention mechanisms (Vaswani et al., 2017)
- Legal reasoning as graph inference
- Burden of proof standards (civil/criminal)
- South African law (8 branches, 60+ principles)

---

## Document History

| Version | Date | Author | Changes |
|---------|------|--------|---------|
| 1.0 | 2025-11-07 | System | Initial comprehensive architecture documentation |

---

**End of Architecture Overview**
