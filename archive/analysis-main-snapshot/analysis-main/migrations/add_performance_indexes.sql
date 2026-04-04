-- Performance Indexes Migration
-- Created: 2025-10-14
-- Purpose: Add performance indexes for optimized query execution

-- Cases table indexes
CREATE INDEX IF NOT EXISTS idx_cases_timeline ON cases(timeline_date);
CREATE INDEX IF NOT EXISTS idx_cases_status ON cases(status);
CREATE INDEX IF NOT EXISTS idx_cases_created_at ON cases(created_at);

-- Evidence table indexes
CREATE INDEX IF NOT EXISTS idx_evidence_case_id ON evidence(case_id);
CREATE INDEX IF NOT EXISTS idx_evidence_type ON evidence(evidence_type);
CREATE INDEX IF NOT EXISTS idx_evidence_date ON evidence(evidence_date);

-- Documents table indexes
CREATE INDEX IF NOT EXISTS idx_documents_processed_date ON documents(processed_date);
CREATE INDEX IF NOT EXISTS idx_documents_case_id ON documents(case_id);
CREATE INDEX IF NOT EXISTS idx_documents_status ON documents(status);

-- Entities table indexes
CREATE INDEX IF NOT EXISTS idx_entities_type ON entities(entity_type);
CREATE INDEX IF NOT EXISTS idx_entities_name ON entities(name);
CREATE INDEX IF NOT EXISTS idx_entities_case_id ON entities(case_id);

-- Relationships table indexes
CREATE INDEX IF NOT EXISTS idx_relationships_source ON relationships(source_entity_id);
CREATE INDEX IF NOT EXISTS idx_relationships_target ON relationships(target_entity_id);
CREATE INDEX IF NOT EXISTS idx_relationships_type ON relationships(relationship_type);

-- Timeline table indexes (if exists)
CREATE INDEX IF NOT EXISTS idx_timeline_date ON timeline(event_date);
CREATE INDEX IF NOT EXISTS idx_timeline_entity ON timeline(entity_id);

-- Composite indexes for common query patterns
CREATE INDEX IF NOT EXISTS idx_evidence_case_date ON evidence(case_id, evidence_date);
CREATE INDEX IF NOT EXISTS idx_relationships_source_type ON relationships(source_entity_id, relationship_type);
CREATE INDEX IF NOT EXISTS idx_entities_type_case ON entities(entity_type, case_id);

-- Performance metrics table for monitoring
CREATE TABLE IF NOT EXISTS performance_metrics (
    id SERIAL PRIMARY KEY,
    operation_type VARCHAR(50) NOT NULL,
    execution_time_ms INTEGER NOT NULL,
    query_text TEXT,
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    metadata JSONB
);

CREATE INDEX IF NOT EXISTS idx_perf_metrics_timestamp ON performance_metrics(timestamp);
CREATE INDEX IF NOT EXISTS idx_perf_metrics_operation ON performance_metrics(operation_type);

-- Sync status tracking table
CREATE TABLE IF NOT EXISTS sync_status (
    id SERIAL PRIMARY KEY,
    sync_type VARCHAR(50) NOT NULL,
    target_database VARCHAR(50) NOT NULL,
    status VARCHAR(20) NOT NULL,
    records_synced INTEGER DEFAULT 0,
    errors_count INTEGER DEFAULT 0,
    started_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    completed_at TIMESTAMP,
    metadata JSONB
);

CREATE INDEX IF NOT EXISTS idx_sync_status_type ON sync_status(sync_type);
CREATE INDEX IF NOT EXISTS idx_sync_status_target ON sync_status(target_database);
CREATE INDEX IF NOT EXISTS idx_sync_status_timestamp ON sync_status(started_at);

-- Add comments for documentation
COMMENT ON INDEX idx_cases_timeline IS 'Optimizes timeline-based case queries';
COMMENT ON INDEX idx_evidence_case_id IS 'Optimizes evidence lookup by case';
COMMENT ON INDEX idx_relationships_source IS 'Optimizes relationship traversal from source';
COMMENT ON INDEX idx_relationships_target IS 'Optimizes relationship traversal to target';
COMMENT ON TABLE performance_metrics IS 'Tracks database operation performance metrics';
COMMENT ON TABLE sync_status IS 'Tracks database synchronization status and history';

