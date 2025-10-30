-- Enhanced Supabase Schema for Analysis Repository
-- Criminal Case Timeline & Evidence Analysis System
-- Last Updated: October 2025

-- Enable required extensions
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
CREATE EXTENSION IF NOT EXISTS "pgcrypto";

-- ============================================================================
-- CORE ENTITIES
-- ============================================================================

-- Main entities table
CREATE TABLE IF NOT EXISTS entities (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name TEXT NOT NULL,
    entity_type TEXT NOT NULL,
    description TEXT,
    metadata JSONB DEFAULT '{}',
    confidence_score DECIMAL(3,2) CHECK (confidence_score >= 0 AND confidence_score <= 1),
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW(),
    created_by TEXT,
    is_active BOOLEAN DEFAULT TRUE
);

-- Entity relationships (hypergraph edges)
CREATE TABLE IF NOT EXISTS entity_relationships (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    source_entity_id UUID REFERENCES entities(id) ON DELETE CASCADE,
    target_entity_id UUID REFERENCES entities(id) ON DELETE CASCADE,
    relationship_type TEXT NOT NULL,
    strength DECIMAL(3,2) CHECK (strength >= 0 AND strength <= 1),
    evidence_ids UUID[],
    temporal_data JSONB,
    metadata JSONB DEFAULT '{}',
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()
);

-- Entity versions for temporal tracking
CREATE TABLE IF NOT EXISTS entity_versions (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    entity_id UUID REFERENCES entities(id) ON DELETE CASCADE,
    version_number INTEGER NOT NULL,
    version_date TIMESTAMP NOT NULL,
    entity_data JSONB NOT NULL,
    compliance_status JSONB,
    change_description TEXT,
    changed_by TEXT,
    created_at TIMESTAMP DEFAULT NOW()
);

-- ============================================================================
-- EVIDENCE MANAGEMENT
-- ============================================================================

-- Evidence documents
CREATE TABLE IF NOT EXISTS evidence (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    title TEXT NOT NULL,
    description TEXT,
    file_path TEXT,
    file_hash TEXT UNIQUE,
    file_type TEXT,
    file_size BIGINT,
    source TEXT,
    date_obtained DATE,
    date_created DATE,
    classification TEXT,
    sensitivity_level TEXT,
    metadata JSONB DEFAULT '{}',
    extracted_entities UUID[],
    ocr_processed BOOLEAN DEFAULT FALSE,
    ocr_text TEXT,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW(),
    created_by TEXT
);

-- Evidence relationships
CREATE TABLE IF NOT EXISTS evidence_relationships (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    evidence_id UUID REFERENCES evidence(id) ON DELETE CASCADE,
    related_evidence_id UUID REFERENCES evidence(id) ON DELETE CASCADE,
    relationship_type TEXT NOT NULL,
    description TEXT,
    created_at TIMESTAMP DEFAULT NOW()
);

-- Evidence access log
CREATE TABLE IF NOT EXISTS evidence_access_log (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    evidence_id UUID REFERENCES evidence(id) ON DELETE CASCADE,
    accessed_by TEXT NOT NULL,
    access_type TEXT NOT NULL,
    access_reason TEXT,
    ip_address INET,
    accessed_at TIMESTAMP DEFAULT NOW()
);

-- ============================================================================
-- TIMELINE MANAGEMENT
-- ============================================================================

-- Timeline events
CREATE TABLE IF NOT EXISTS timeline_events (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    event_date DATE NOT NULL,
    event_time TIME,
    title TEXT NOT NULL,
    description TEXT,
    event_type TEXT,
    significance TEXT,
    entities_involved UUID[],
    evidence_ids UUID[],
    location TEXT,
    metadata JSONB DEFAULT '{}',
    confidence_score DECIMAL(3,2) CHECK (confidence_score >= 0 AND confidence_score <= 1),
    verified BOOLEAN DEFAULT FALSE,
    verified_by TEXT,
    verified_at TIMESTAMP,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()
);

-- Timeline event relationships
CREATE TABLE IF NOT EXISTS timeline_event_relationships (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    source_event_id UUID REFERENCES timeline_events(id) ON DELETE CASCADE,
    target_event_id UUID REFERENCES timeline_events(id) ON DELETE CASCADE,
    relationship_type TEXT NOT NULL,
    description TEXT,
    created_at TIMESTAMP DEFAULT NOW()
);

-- ============================================================================
-- HYPERGRAPH ANALYSIS
-- ============================================================================

-- Hypergraph nodes
CREATE TABLE IF NOT EXISTS hypergraph_nodes (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    node_type TEXT NOT NULL,
    node_data JSONB NOT NULL,
    entity_id UUID REFERENCES entities(id) ON DELETE SET NULL,
    centrality_score DECIMAL(5,4),
    betweenness_score DECIMAL(5,4),
    clustering_coefficient DECIMAL(5,4),
    metadata JSONB DEFAULT '{}',
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()
);

-- Hypergraph edges (hyperedges connecting multiple nodes)
CREATE TABLE IF NOT EXISTS hypergraph_edges (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    edge_type TEXT NOT NULL,
    node_ids UUID[] NOT NULL,
    weight DECIMAL(5,4),
    direction TEXT,
    temporal_data JSONB,
    metadata JSONB DEFAULT '{}',
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()
);

-- Hypergraph metrics
CREATE TABLE IF NOT EXISTS hypergraph_metrics (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    metric_name TEXT NOT NULL,
    metric_value DECIMAL(10,4),
    metric_type TEXT,
    calculation_date TIMESTAMP DEFAULT NOW(),
    metadata JSONB DEFAULT '{}',
    created_at TIMESTAMP DEFAULT NOW()
);

-- ============================================================================
-- LEGAL COMPLIANCE
-- ============================================================================

-- SA AI Legislation
CREATE TABLE IF NOT EXISTS sa_legislation (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name TEXT NOT NULL,
    full_name TEXT,
    year INTEGER,
    type TEXT,
    significance TEXT,
    key_requirements JSONB,
    effective_date DATE,
    status TEXT,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()
);

-- Compliance deadlines
CREATE TABLE IF NOT EXISTS compliance_deadlines (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    requirement TEXT NOT NULL,
    timeframe TEXT NOT NULL,
    legislation_id UUID REFERENCES sa_legislation(id),
    legislation TEXT NOT NULL,
    severity TEXT NOT NULL,
    last_checked TIMESTAMP,
    next_due TIMESTAMP,
    status TEXT DEFAULT 'pending',
    responsible_party TEXT,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()
);

-- AI fraud threats
CREATE TABLE IF NOT EXISTS ai_fraud_threats (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    threat_name TEXT NOT NULL,
    threat_type TEXT NOT NULL,
    description TEXT,
    severity TEXT,
    legal_implications JSONB,
    detection_methods JSONB,
    mitigation_strategies JSONB,
    related_legislation UUID[],
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()
);

-- Compliance monitoring
CREATE TABLE IF NOT EXISTS compliance_monitoring (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    entity_id UUID REFERENCES entities(id) ON DELETE CASCADE,
    legislation_id UUID REFERENCES sa_legislation(id),
    compliance_status TEXT NOT NULL,
    last_assessment DATE,
    next_review DATE,
    risk_level TEXT,
    findings JSONB,
    recommendations JSONB,
    assessed_by TEXT,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()
);

-- ============================================================================
-- CASE MANAGEMENT
-- ============================================================================

-- Cases
CREATE TABLE IF NOT EXISTS cases (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    case_number TEXT UNIQUE NOT NULL,
    case_name TEXT NOT NULL,
    case_type TEXT,
    status TEXT DEFAULT 'active',
    description TEXT,
    start_date DATE,
    end_date DATE,
    jurisdiction TEXT,
    court TEXT,
    metadata JSONB DEFAULT '{}',
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()
);

-- Case entities (linking cases to entities)
CREATE TABLE IF NOT EXISTS case_entities (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    case_id UUID REFERENCES cases(id) ON DELETE CASCADE,
    entity_id UUID REFERENCES entities(id) ON DELETE CASCADE,
    role TEXT,
    added_at TIMESTAMP DEFAULT NOW()
);

-- Case evidence (linking cases to evidence)
CREATE TABLE IF NOT EXISTS case_evidence (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    case_id UUID REFERENCES cases(id) ON DELETE CASCADE,
    evidence_id UUID REFERENCES evidence(id) ON DELETE CASCADE,
    relevance_score DECIMAL(3,2),
    added_at TIMESTAMP DEFAULT NOW(),
    added_by TEXT
);

-- ============================================================================
-- ANALYSIS & REPORTING
-- ============================================================================

-- Analysis reports
CREATE TABLE IF NOT EXISTS analysis_reports (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    report_type TEXT NOT NULL,
    title TEXT NOT NULL,
    description TEXT,
    case_id UUID REFERENCES cases(id) ON DELETE CASCADE,
    report_data JSONB NOT NULL,
    generated_by TEXT,
    generated_at TIMESTAMP DEFAULT NOW(),
    file_path TEXT,
    status TEXT DEFAULT 'draft',
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()
);

-- Model predictions (AI/ML results)
CREATE TABLE IF NOT EXISTS model_predictions (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    model_name TEXT NOT NULL,
    model_version TEXT,
    input_data JSONB NOT NULL,
    prediction_data JSONB NOT NULL,
    confidence_score DECIMAL(3,2),
    case_id UUID REFERENCES cases(id) ON DELETE CASCADE,
    created_at TIMESTAMP DEFAULT NOW()
);

-- ============================================================================
-- INDEXES FOR PERFORMANCE
-- ============================================================================

-- Entity indexes
CREATE INDEX IF NOT EXISTS idx_entities_type ON entities(entity_type);
CREATE INDEX IF NOT EXISTS idx_entities_active ON entities(is_active);
CREATE INDEX IF NOT EXISTS idx_entities_created_at ON entities(created_at);
CREATE INDEX IF NOT EXISTS idx_entities_name_gin ON entities USING gin(to_tsvector('english', name));

-- Relationship indexes
CREATE INDEX IF NOT EXISTS idx_entity_relationships_source ON entity_relationships(source_entity_id);
CREATE INDEX IF NOT EXISTS idx_entity_relationships_target ON entity_relationships(target_entity_id);
CREATE INDEX IF NOT EXISTS idx_entity_relationships_type ON entity_relationships(relationship_type);

-- Evidence indexes
CREATE INDEX IF NOT EXISTS idx_evidence_classification ON evidence(classification);
CREATE INDEX IF NOT EXISTS idx_evidence_date_obtained ON evidence(date_obtained);
CREATE INDEX IF NOT EXISTS idx_evidence_file_hash ON evidence(file_hash);
CREATE INDEX IF NOT EXISTS idx_evidence_title_gin ON evidence USING gin(to_tsvector('english', title));

-- Timeline indexes
CREATE INDEX IF NOT EXISTS idx_timeline_events_date ON timeline_events(event_date);
CREATE INDEX IF NOT EXISTS idx_timeline_events_type ON timeline_events(event_type);
CREATE INDEX IF NOT EXISTS idx_timeline_events_verified ON timeline_events(verified);

-- Hypergraph indexes
CREATE INDEX IF NOT EXISTS idx_hypergraph_nodes_type ON hypergraph_nodes(node_type);
CREATE INDEX IF NOT EXISTS idx_hypergraph_nodes_entity ON hypergraph_nodes(entity_id);
CREATE INDEX IF NOT EXISTS idx_hypergraph_edges_type ON hypergraph_edges(edge_type);

-- Case indexes
CREATE INDEX IF NOT EXISTS idx_cases_number ON cases(case_number);
CREATE INDEX IF NOT EXISTS idx_cases_status ON cases(status);
CREATE INDEX IF NOT EXISTS idx_cases_start_date ON cases(start_date);

-- ============================================================================
-- ROW LEVEL SECURITY (RLS)
-- ============================================================================

-- Enable RLS on sensitive tables
ALTER TABLE entities ENABLE ROW LEVEL SECURITY;
ALTER TABLE evidence ENABLE ROW LEVEL SECURITY;
ALTER TABLE timeline_events ENABLE ROW LEVEL SECURITY;
ALTER TABLE cases ENABLE ROW LEVEL SECURITY;

-- Example RLS policies (customize based on your auth setup)
-- CREATE POLICY "Users can view their own cases" ON cases
--     FOR SELECT USING (auth.uid() = created_by::uuid);

-- ============================================================================
-- TRIGGERS FOR UPDATED_AT
-- ============================================================================

-- Function to update updated_at timestamp
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ language 'plpgsql';

-- Apply trigger to tables with updated_at
CREATE TRIGGER update_entities_updated_at BEFORE UPDATE ON entities
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_entity_relationships_updated_at BEFORE UPDATE ON entity_relationships
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_evidence_updated_at BEFORE UPDATE ON evidence
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_timeline_events_updated_at BEFORE UPDATE ON timeline_events
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_hypergraph_nodes_updated_at BEFORE UPDATE ON hypergraph_nodes
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_hypergraph_edges_updated_at BEFORE UPDATE ON hypergraph_edges
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_cases_updated_at BEFORE UPDATE ON cases
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_analysis_reports_updated_at BEFORE UPDATE ON analysis_reports
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

-- ============================================================================
-- COMMENTS
-- ============================================================================

COMMENT ON TABLE entities IS 'Core entities in the case analysis system';
COMMENT ON TABLE entity_relationships IS 'Relationships between entities forming a hypergraph';
COMMENT ON TABLE evidence IS 'Evidence documents and materials';
COMMENT ON TABLE timeline_events IS 'Chronological events in case timelines';
COMMENT ON TABLE hypergraph_nodes IS 'Nodes in the hypergraph analysis structure';
COMMENT ON TABLE hypergraph_edges IS 'Hyperedges connecting multiple nodes';
COMMENT ON TABLE cases IS 'Legal cases being analyzed';
COMMENT ON TABLE sa_legislation IS 'South African legislation relevant to AI and legal compliance';
COMMENT ON TABLE compliance_monitoring IS 'Tracking compliance with legal requirements';

