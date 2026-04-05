-- Migration: 001 - create_migration_tracking
-- Description: Create table to track applied migrations
-- Created: 2025-10-17T16:51:54.863735

-- UP

        CREATE TABLE IF NOT EXISTS schema_migrations (
            version VARCHAR(10) PRIMARY KEY,
            name VARCHAR(255) NOT NULL,
            description TEXT,
            checksum VARCHAR(64) NOT NULL,
            applied_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
            applied_by VARCHAR(100),
            execution_time_ms INTEGER
        );
        
        CREATE INDEX IF NOT EXISTS idx_migrations_applied_at 
        ON schema_migrations(applied_at);
        

-- DOWN

        DROP TABLE IF EXISTS schema_migrations;
        