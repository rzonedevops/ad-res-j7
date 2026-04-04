-- Migration: 003 - add_schema_version
-- Description: Track schema version for drift detection
-- Created: 2025-10-17T16:51:54.864084

-- UP

        CREATE TABLE IF NOT EXISTS schema_version (
            id SERIAL PRIMARY KEY,
            version VARCHAR(20) NOT NULL,
            description TEXT,
            applied_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
            checksum VARCHAR(64) NOT NULL,
            UNIQUE(version)
        );
        
        INSERT INTO schema_version (version, description, checksum)
        VALUES ('1.0.0', 'Initial schema version', 'initial')
        ON CONFLICT (version) DO NOTHING;
        

-- DOWN

        DROP TABLE IF EXISTS schema_version;
        