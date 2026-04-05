-- Migration: 002 - enhance_sync_log
-- Description: Add enhanced sync logging capabilities
-- Created: 2025-10-17T16:51:54.863926

-- UP

        CREATE TABLE IF NOT EXISTS sync_log_enhanced (
            id SERIAL PRIMARY KEY,
            sync_type VARCHAR(50) NOT NULL,
            source_db VARCHAR(50) NOT NULL,
            target_db VARCHAR(50) NOT NULL,
            status VARCHAR(20) NOT NULL,
            started_at TIMESTAMP NOT NULL,
            completed_at TIMESTAMP,
            duration_ms INTEGER,
            records_processed INTEGER DEFAULT 0,
            records_failed INTEGER DEFAULT 0,
            error_message TEXT,
            metadata JSONB,
            created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
        );
        
        CREATE INDEX IF NOT EXISTS idx_sync_log_enhanced_type 
        ON sync_log_enhanced(sync_type);
        
        CREATE INDEX IF NOT EXISTS idx_sync_log_enhanced_status 
        ON sync_log_enhanced(status);
        
        CREATE INDEX IF NOT EXISTS idx_sync_log_enhanced_started 
        ON sync_log_enhanced(started_at);
        

-- DOWN

        DROP TABLE IF EXISTS sync_log_enhanced;
        