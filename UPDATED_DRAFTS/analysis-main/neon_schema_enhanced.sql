-- Enhanced Neon Schema for Analysis Repository
-- Criminal Case Timeline & Evidence Analysis System
-- Optimized for Neon's serverless PostgreSQL
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
-- LEGAL COMPLIANCE & RELATIONSHIPS
-- ============================================================================

-- Legal relationships (optimized for hypergraph analysis)
CREATE TABLE IF NOT EXISTS legal_relationships (
    id SERIAL PRIMARY KEY,
    source_entity_id UUID REFERENCES entities(id) ON DELETE CASCADE,
    target_entity_id UUID REFERENCES entities(id) ON DELETE CASCADE,
    relationship_type TEXT NOT NULL,
    legal_basis TEXT,
    compliance_impact TEXT,
    temporal_data JSONB,
    strength DECIMAL(3,2),
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()
);

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

-- Compliance monitoring (optimized for Neon)
CREATE TABLE IF NOT EXISTS compliance_monitoring (
    id SERIAL PRIMARY KEY,
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
-- PERFORMANCE OPTIMIZATION FOR NEON
-- ============================================================================

-- Indexes optimized for Neon's serverless architecture
-- Entity indexes
CREATE INDEX IF NOT EXISTS idx_entities_type ON entities(entity_type);
CREATE INDEX IF NOT EXISTS idx_entities_active ON entities(is_active);
CREATE INDEX IF NOT EXISTS idx_entities_created_at ON entities(created_at DESC);
CREATE INDEX IF NOT EXISTS idx_entities_name_gin ON entities USING gin(to_tsvector('english', name));

-- Relationship indexes
CREATE INDEX IF NOT EXISTS idx_entity_relationships_source ON entity_relationships(source_entity_id);
CREATE INDEX IF NOT EXISTS idx_entity_relationships_target ON entity_relationships(target_entity_id);
CREATE INDEX IF NOT EXISTS idx_entity_relationships_type ON entity_relationships(relationship_type);
CREATE INDEX IF NOT EXISTS idx_entity_relationships_composite ON entity_relationships(source_entity_id, target_entity_id);

-- Legal relationship indexes
CREATE INDEX IF NOT EXISTS idx_legal_relationships_source ON legal_relationships(source_entity_id);
CREATE INDEX IF NOT EXISTS idx_legal_relationships_target ON legal_relationships(target_entity_id);
CREATE INDEX IF NOT EXISTS idx_legal_relationships_type ON legal_relationships(relationship_type);

-- Evidence indexes
CREATE INDEX IF NOT EXISTS idx_evidence_classification ON evidence(classification);
CREATE INDEX IF NOT EXISTS idx_evidence_date_obtained ON evidence(date_obtained DESC);
CREATE INDEX IF NOT EXISTS idx_evidence_file_hash ON evidence(file_hash);
CREATE INDEX IF NOT EXISTS idx_evidence_title_gin ON evidence USING gin(to_tsvector('english', title));
CREATE INDEX IF NOT EXISTS idx_evidence_ocr_processed ON evidence(ocr_processed);

-- Timeline indexes
CREATE INDEX IF NOT EXISTS idx_timeline_events_date ON timeline_events(event_date DESC);
CREATE INDEX IF NOT EXISTS idx_timeline_events_type ON timeline_events(event_type);
CREATE INDEX IF NOT EXISTS idx_timeline_events_verified ON timeline_events(verified);
CREATE INDEX IF NOT EXISTS idx_timeline_events_composite ON timeline_events(event_date, event_type);

-- Hypergraph indexes
CREATE INDEX IF NOT EXISTS idx_hypergraph_nodes_type ON hypergraph_nodes(node_type);
CREATE INDEX IF NOT EXISTS idx_hypergraph_nodes_entity ON hypergraph_nodes(entity_id);
CREATE INDEX IF NOT EXISTS idx_hypergraph_edges_type ON hypergraph_edges(edge_type);
CREATE INDEX IF NOT EXISTS idx_hypergraph_edges_nodes ON hypergraph_edges USING gin(node_ids);

-- Case indexes
CREATE INDEX IF NOT EXISTS idx_cases_number ON cases(case_number);
CREATE INDEX IF NOT EXISTS idx_cases_status ON cases(status);
CREATE INDEX IF NOT EXISTS idx_cases_start_date ON cases(start_date DESC);
CREATE INDEX IF NOT EXISTS idx_case_entities_case ON case_entities(case_id);
CREATE INDEX IF NOT EXISTS idx_case_entities_entity ON case_entities(entity_id);
CREATE INDEX IF NOT EXISTS idx_case_evidence_case ON case_evidence(case_id);
CREATE INDEX IF NOT EXISTS idx_case_evidence_evidence ON case_evidence(evidence_id);

-- Compliance indexes
CREATE INDEX IF NOT EXISTS idx_compliance_monitoring_entity ON compliance_monitoring(entity_id);
CREATE INDEX IF NOT EXISTS idx_compliance_monitoring_status ON compliance_monitoring(compliance_status);
CREATE INDEX IF NOT EXISTS idx_compliance_deadlines_next_due ON compliance_deadlines(next_due);

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

CREATE TRIGGER update_legal_relationships_updated_at BEFORE UPDATE ON legal_relationships
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

CREATE TRIGGER update_sa_legislation_updated_at BEFORE UPDATE ON sa_legislation
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_compliance_deadlines_updated_at BEFORE UPDATE ON compliance_deadlines
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_compliance_monitoring_updated_at BEFORE UPDATE ON compliance_monitoring
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

-- ============================================================================
-- MATERIALIZED VIEWS FOR PERFORMANCE
-- ============================================================================

-- Materialized view for entity statistics
CREATE MATERIALIZED VIEW IF NOT EXISTS entity_statistics AS
SELECT 
    entity_type,
    COUNT(*) as total_count,
    AVG(confidence_score) as avg_confidence,
    COUNT(CASE WHEN is_active THEN 1 END) as active_count
FROM entities
GROUP BY entity_type;

-- Index on materialized view
CREATE INDEX IF NOT EXISTS idx_entity_statistics_type ON entity_statistics(entity_type);

-- Materialized view for timeline summary
CREATE MATERIALIZED VIEW IF NOT EXISTS timeline_summary AS
SELECT 
    DATE_TRUNC('month', event_date) as month,
    event_type,
    COUNT(*) as event_count,
    AVG(confidence_score) as avg_confidence
FROM timeline_events
GROUP BY DATE_TRUNC('month', event_date), event_type;

-- Index on materialized view
CREATE INDEX IF NOT EXISTS idx_timeline_summary_month ON timeline_summary(month);

-- ============================================================================
-- COMMENTS
-- ============================================================================

COMMENT ON TABLE entities IS 'Core entities in the case analysis system';
COMMENT ON TABLE entity_relationships IS 'Relationships between entities forming a hypergraph';
COMMENT ON TABLE legal_relationships IS 'Legal relationships optimized for hypergraph analysis';
COMMENT ON TABLE evidence IS 'Evidence documents and materials';
COMMENT ON TABLE timeline_events IS 'Chronological events in case timelines';
COMMENT ON TABLE hypergraph_nodes IS 'Nodes in the hypergraph analysis structure';
COMMENT ON TABLE hypergraph_edges IS 'Hyperedges connecting multiple nodes';
COMMENT ON TABLE cases IS 'Legal cases being analyzed';
COMMENT ON TABLE sa_legislation IS 'South African legislation relevant to AI and legal compliance';
COMMENT ON TABLE compliance_monitoring IS 'Tracking compliance with legal requirements';
COMMENT ON MATERIALIZED VIEW entity_statistics IS 'Aggregated statistics for entities';
COMMENT ON MATERIALIZED VIEW timeline_summary IS 'Monthly summary of timeline events';

-- ============================================================================
-- REFRESH FUNCTION FOR MATERIALIZED VIEWS
-- ============================================================================

-- Function to refresh all materialized views
CREATE OR REPLACE FUNCTION refresh_all_materialized_views()
RETURNS void AS $$
BEGIN
    REFRESH MATERIALIZED VIEW CONCURRENTLY entity_statistics;
    REFRESH MATERIALIZED VIEW CONCURRENTLY timeline_summary;
END;
$$ LANGUAGE plpgsql;

-- Schedule refresh (requires pg_cron extension if available)
-- SELECT cron.schedule('refresh-views', '0 * * * *', 'SELECT refresh_all_materialized_views()');

