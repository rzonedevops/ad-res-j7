-- =============================================================================
-- WEIGHTED HYPERGRAPH SCHEMA FOR LEX-HYPERGRAPH-NEURAL-NET-QL
-- =============================================================================
-- Database: Neon PostgreSQL
-- Purpose: Store weighted hypergraph with GNN features for legal reasoning
-- Version: 1.0
-- Date: 2025-10-23
-- =============================================================================

-- Drop existing tables if they exist
DROP TABLE IF EXISTS weighted_edges CASCADE;
DROP TABLE IF EXISTS node_embeddings CASCADE;
DROP TABLE IF EXISTS inference_chains CASCADE;
DROP TABLE IF EXISTS gnn_predictions CASCADE;

-- =============================================================================
-- WEIGHTED EDGES TABLE
-- =============================================================================
CREATE TABLE weighted_edges (
    id SERIAL PRIMARY KEY,
    source_id VARCHAR(255) NOT NULL,
    target_id VARCHAR(255) NOT NULL,
    edge_type VARCHAR(100) NOT NULL,
    weight FLOAT NOT NULL DEFAULT 1.0,
    repetition_count INTEGER NOT NULL DEFAULT 1,
    avg_confidence FLOAT NOT NULL DEFAULT 1.0,
    avg_strength FLOAT NOT NULL DEFAULT 1.0,
    normalized_weight FLOAT,
    inference_types TEXT,
    relationship_names TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    -- Constraints
    CONSTRAINT unique_weighted_edge UNIQUE(source_id, target_id, edge_type),
    CONSTRAINT positive_weight CHECK (weight >= 0),
    CONSTRAINT positive_repetition CHECK (repetition_count > 0)
);

-- Indexes for weighted_edges
CREATE INDEX idx_weighted_edges_source ON weighted_edges(source_id);
CREATE INDEX idx_weighted_edges_target ON weighted_edges(target_id);
CREATE INDEX idx_weighted_edges_type ON weighted_edges(edge_type);
CREATE INDEX idx_weighted_edges_weight ON weighted_edges(weight DESC);

-- =============================================================================
-- NODE EMBEDDINGS TABLE (GNN Features)
-- =============================================================================
CREATE TABLE node_embeddings (
    id SERIAL PRIMARY KEY,
    node_id VARCHAR(255) NOT NULL UNIQUE,
    embedding FLOAT[] NOT NULL,  -- GNN-computed embedding vector
    embedding_dim INTEGER NOT NULL,
    model_version VARCHAR(50) DEFAULT 'v1.0',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    -- Constraints
    CONSTRAINT positive_dim CHECK (embedding_dim > 0)
);

-- Indexes for node_embeddings
CREATE INDEX idx_node_embeddings_node ON node_embeddings(node_id);
CREATE INDEX idx_node_embeddings_model ON node_embeddings(model_version);

-- =============================================================================
-- INFERENCE CHAINS TABLE
-- =============================================================================
CREATE TABLE inference_chains (
    id SERIAL PRIMARY KEY,
    source_id VARCHAR(255) NOT NULL,
    target_id VARCHAR(255) NOT NULL,
    path TEXT[] NOT NULL,  -- Array of node IDs in path
    path_length INTEGER NOT NULL,
    confidence FLOAT NOT NULL,
    gnn_score FLOAT,
    reasoning_steps TEXT[] NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    -- Constraints
    CONSTRAINT unique_inference_chain UNIQUE(source_id, target_id),
    CONSTRAINT positive_path_length CHECK (path_length > 0),
    CONSTRAINT valid_confidence CHECK (confidence >= 0 AND confidence <= 1)
);

-- Indexes for inference_chains
CREATE INDEX idx_inference_chains_source ON inference_chains(source_id);
CREATE INDEX idx_inference_chains_target ON inference_chains(target_id);
CREATE INDEX idx_inference_chains_confidence ON inference_chains(confidence DESC);
CREATE INDEX idx_inference_chains_gnn_score ON inference_chains(gnn_score DESC);

-- =============================================================================
-- GNN PREDICTIONS TABLE
-- =============================================================================
CREATE TABLE gnn_predictions (
    id SERIAL PRIMARY KEY,
    node_id VARCHAR(255) NOT NULL,
    prediction_type VARCHAR(50) NOT NULL,  -- 'confidence', 'classification', etc.
    predicted_value FLOAT NOT NULL,
    actual_value FLOAT,
    error FLOAT,
    model_version VARCHAR(50) DEFAULT 'v1.0',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    -- Constraints
    CONSTRAINT unique_gnn_prediction UNIQUE(node_id, prediction_type, model_version)
);

-- Indexes for gnn_predictions
CREATE INDEX idx_gnn_predictions_node ON gnn_predictions(node_id);
CREATE INDEX idx_gnn_predictions_type ON gnn_predictions(prediction_type);
CREATE INDEX idx_gnn_predictions_model ON gnn_predictions(model_version);
CREATE INDEX idx_gnn_predictions_error ON gnn_predictions(error);

-- =============================================================================
-- VIEWS
-- =============================================================================

-- View: High-weight edges (top 10%)
CREATE OR REPLACE VIEW high_weight_edges AS
SELECT 
    source_id,
    target_id,
    edge_type,
    weight,
    repetition_count,
    avg_confidence
FROM weighted_edges
WHERE weight >= (SELECT PERCENTILE_CONT(0.9) WITHIN GROUP (ORDER BY weight) FROM weighted_edges)
ORDER BY weight DESC;

-- View: Node similarity (based on embeddings)
CREATE OR REPLACE VIEW node_similarity_matrix AS
SELECT 
    e1.node_id AS node1_id,
    e2.node_id AS node2_id,
    -- Cosine similarity approximation (requires pgvector extension for exact)
    (SELECT SUM(e1.embedding[i] * e2.embedding[i]) 
     FROM generate_series(1, e1.embedding_dim) AS i) AS similarity_score
FROM node_embeddings e1
CROSS JOIN node_embeddings e2
WHERE e1.node_id < e2.node_id;

-- View: Inference chain statistics
CREATE OR REPLACE VIEW inference_chain_stats AS
SELECT 
    source_id,
    COUNT(*) AS num_chains,
    AVG(path_length) AS avg_path_length,
    AVG(confidence) AS avg_confidence,
    AVG(gnn_score) AS avg_gnn_score,
    MAX(confidence) AS max_confidence
FROM inference_chains
GROUP BY source_id
ORDER BY num_chains DESC;

-- =============================================================================
-- FUNCTIONS
-- =============================================================================

-- Function: Update timestamp on row update
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Triggers for updated_at
CREATE TRIGGER update_weighted_edges_updated_at
    BEFORE UPDATE ON weighted_edges
    FOR EACH ROW
    EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_node_embeddings_updated_at
    BEFORE UPDATE ON node_embeddings
    FOR EACH ROW
    EXECUTE FUNCTION update_updated_at_column();

-- Function: Calculate edge weight
CREATE OR REPLACE FUNCTION calculate_edge_weight(
    p_repetition_count INTEGER,
    p_avg_confidence FLOAT,
    p_avg_strength FLOAT
) RETURNS FLOAT AS $$
BEGIN
    RETURN p_repetition_count * p_avg_confidence * p_avg_strength;
END;
$$ LANGUAGE plpgsql IMMUTABLE;

-- Function: Find similar nodes by embedding
CREATE OR REPLACE FUNCTION find_similar_nodes(
    p_node_id VARCHAR(255),
    p_limit INTEGER DEFAULT 10
) RETURNS TABLE (
    similar_node_id VARCHAR(255),
    similarity_score FLOAT
) AS $$
BEGIN
    RETURN QUERY
    SELECT 
        e2.node_id,
        -- Placeholder for cosine similarity (requires pgvector for exact calculation)
        0.0::FLOAT AS similarity
    FROM node_embeddings e1
    CROSS JOIN node_embeddings e2
    WHERE e1.node_id = p_node_id
      AND e2.node_id != p_node_id
    LIMIT p_limit;
END;
$$ LANGUAGE plpgsql;

-- =============================================================================
-- SAMPLE DATA INSERTION (for testing)
-- =============================================================================

-- Insert sample weighted edges
INSERT INTO weighted_edges (source_id, target_id, edge_type, weight, repetition_count, avg_confidence, avg_strength)
VALUES 
    ('pacta-sunt-servanda', 'contract-valid?', 'derivation', 0.95, 1, 0.95, 1.0),
    ('consensus-ad-idem', 'contract-valid?', 'derivation', 0.90, 1, 0.90, 1.0),
    ('neminem-laedere', 'duty-of-care?', 'derivation', 0.95, 1, 0.95, 1.0)
ON CONFLICT (source_id, target_id, edge_type) DO NOTHING;

-- Insert sample node embeddings
INSERT INTO node_embeddings (node_id, embedding, embedding_dim)
VALUES 
    ('pacta-sunt-servanda', ARRAY[1.0, 0.0, 0.0, 0.0, 1.0, 1.0], 6),
    ('consensus-ad-idem', ARRAY[1.0, 0.0, 0.0, 0.0, 1.0, 0.95], 6),
    ('neminem-laedere', ARRAY[1.0, 0.0, 0.0, 0.0, 1.0, 1.0], 6)
ON CONFLICT (node_id) DO NOTHING;

-- Insert sample inference chains
INSERT INTO inference_chains (source_id, target_id, path, path_length, confidence, gnn_score, reasoning_steps)
VALUES 
    ('pacta-sunt-servanda', 'contract-valid?', 
     ARRAY['pacta-sunt-servanda', 'contract-valid?'], 
     2, 0.95, 0.95,
     ARRAY['pacta-sunt-servanda → contract-valid?'])
ON CONFLICT (source_id, target_id) DO NOTHING;

-- =============================================================================
-- GRANTS (adjust as needed)
-- =============================================================================

-- Grant permissions to application user (replace 'app_user' with actual username)
-- GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA public TO app_user;
-- GRANT USAGE, SELECT ON ALL SEQUENCES IN SCHEMA public TO app_user;
-- GRANT EXECUTE ON ALL FUNCTIONS IN SCHEMA public TO app_user;

-- =============================================================================
-- COMMENTS
-- =============================================================================

COMMENT ON TABLE weighted_edges IS 'Weighted edges with aggregated repetitions for GNN training';
COMMENT ON TABLE node_embeddings IS 'GNN-computed node embeddings for similarity search';
COMMENT ON TABLE inference_chains IS 'Pre-computed inference chains between legal concepts';
COMMENT ON TABLE gnn_predictions IS 'GNN model predictions for evaluation';

COMMENT ON COLUMN weighted_edges.weight IS 'Computed weight = repetition_count × avg_confidence × avg_strength';
COMMENT ON COLUMN node_embeddings.embedding IS 'GNN feature vector for node';
COMMENT ON COLUMN inference_chains.gnn_score IS 'GNN-computed reasoning score for path';

-- =============================================================================
-- END OF SCHEMA
-- =============================================================================
