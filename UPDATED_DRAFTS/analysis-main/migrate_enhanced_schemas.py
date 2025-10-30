#!/usr/bin/env python3
"""
Database Migration Script for Enhanced Schemas
Migrates both Supabase and Neon databases to the enhanced schema
"""

import os
import sys
from pathlib import Path
from datetime import datetime
import psycopg2
from supabase import create_client, Client
import logging

# Configure logging
logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(name)s - %(levelname)s - %(message)s'
)
logger = logging.getLogger(__name__)


class DatabaseMigration:
    """Handle database migrations for enhanced schemas"""
    
    def __init__(self):
        """Initialize database connections"""
        self.supabase_url = os.getenv('SUPABASE_URL')
        self.supabase_key = os.getenv('SUPABASE_KEY')
        self.neon_connection_string = os.getenv('NEON_CONNECTION_STRING')
        
        self.supabase_client = None
        self.neon_conn = None
        
    def connect_supabase(self) -> bool:
        """Connect to Supabase"""
        try:
            if not self.supabase_url or not self.supabase_key:
                logger.warning("Supabase credentials not found. Skipping Supabase migration.")
                return False
                
            self.supabase_client = create_client(self.supabase_url, self.supabase_key)
            logger.info("✓ Connected to Supabase")
            return True
        except Exception as e:
            logger.error(f"Failed to connect to Supabase: {e}")
            return False
    
    def connect_neon(self) -> bool:
        """Connect to Neon"""
        try:
            if not self.neon_connection_string:
                logger.warning("Neon connection string not found. Skipping Neon migration.")
                return False
                
            self.neon_conn = psycopg2.connect(self.neon_connection_string)
            logger.info("✓ Connected to Neon")
            return True
        except Exception as e:
            logger.error(f"Failed to connect to Neon: {e}")
            return False
    
    def execute_sql_file(self, connection, sql_file_path: str) -> bool:
        """Execute SQL file on given connection"""
        try:
            with open(sql_file_path, 'r') as f:
                sql_content = f.read()
            
            cursor = connection.cursor()
            cursor.execute(sql_content)
            connection.commit()
            cursor.close()
            
            logger.info(f"✓ Executed {sql_file_path}")
            return True
        except Exception as e:
            logger.error(f"Failed to execute {sql_file_path}: {e}")
            connection.rollback()
            return False
    
    def migrate_supabase(self) -> bool:
        """Migrate Supabase to enhanced schema"""
        logger.info("Starting Supabase migration...")
        
        if not self.connect_supabase():
            return False
        
        # For Supabase, we need to use the PostgreSQL connection
        # The Python client doesn't support raw SQL execution
        try:
            # Extract connection details from Supabase URL
            # Format: https://xxxxx.supabase.co
            project_ref = self.supabase_url.split('//')[1].split('.')[0]
            
            # Construct PostgreSQL connection string
            # Note: You'll need the database password from Supabase settings
            db_password = os.getenv('SUPABASE_DB_PASSWORD')
            if not db_password:
                logger.warning("SUPABASE_DB_PASSWORD not set. Cannot execute schema migration.")
                logger.info("Please run the SQL file manually in Supabase SQL Editor:")
                logger.info("  File: supabase_schema_enhanced.sql")
                return False
            
            pg_conn_string = f"postgresql://postgres:{db_password}@db.{project_ref}.supabase.co:5432/postgres"
            pg_conn = psycopg2.connect(pg_conn_string)
            
            result = self.execute_sql_file(pg_conn, 'supabase_schema_enhanced.sql')
            pg_conn.close()
            
            if result:
                logger.info("✓ Supabase migration completed successfully")
            return result
            
        except Exception as e:
            logger.error(f"Supabase migration failed: {e}")
            logger.info("Please run the SQL file manually in Supabase SQL Editor:")
            logger.info("  File: supabase_schema_enhanced.sql")
            return False
    
    def migrate_neon(self) -> bool:
        """Migrate Neon to enhanced schema"""
        logger.info("Starting Neon migration...")
        
        if not self.connect_neon():
            return False
        
        result = self.execute_sql_file(self.neon_conn, 'neon_schema_enhanced.sql')
        
        if result:
            logger.info("✓ Neon migration completed successfully")
            
            # Refresh materialized views
            try:
                cursor = self.neon_conn.cursor()
                cursor.execute("SELECT refresh_all_materialized_views();")
                self.neon_conn.commit()
                cursor.close()
                logger.info("✓ Materialized views refreshed")
            except Exception as e:
                logger.warning(f"Could not refresh materialized views: {e}")
        
        self.neon_conn.close()
        return result
    
    def create_migration_log(self, supabase_success: bool, neon_success: bool):
        """Create migration log file"""
        log_content = f"""# Database Migration Log
        
## Migration Date
{datetime.now().isoformat()}

## Migration Results

### Supabase
Status: {'✓ SUCCESS' if supabase_success else '✗ FAILED'}
Schema File: supabase_schema_enhanced.sql

### Neon
Status: {'✓ SUCCESS' if neon_success else '✗ FAILED'}
Schema File: neon_schema_enhanced.sql

## Schema Enhancements

### New Tables
- entity_versions: Temporal tracking of entity changes
- evidence_relationships: Relationships between evidence items
- evidence_access_log: Audit trail for evidence access
- timeline_event_relationships: Relationships between timeline events
- hypergraph_nodes: Nodes in hypergraph structure
- hypergraph_edges: Hyperedges connecting multiple nodes
- hypergraph_metrics: Metrics for hypergraph analysis
- case_entities: Links cases to entities
- case_evidence: Links cases to evidence
- analysis_reports: Generated analysis reports
- model_predictions: AI/ML model predictions

### Enhanced Tables
- entities: Added confidence_score, is_active, metadata
- entity_relationships: Added strength, evidence_ids, temporal_data
- evidence: Added file_hash, ocr_processed, extracted_entities
- timeline_events: Added confidence_score, verification fields
- sa_legislation: Added effective_date, status
- compliance_deadlines: Added status, responsible_party
- compliance_monitoring: Added findings, recommendations

### Performance Improvements
- Added comprehensive indexes for all major tables
- Created materialized views for entity and timeline statistics (Neon)
- Added GIN indexes for full-text search
- Optimized composite indexes for common queries

### Security Enhancements
- Enabled Row Level Security (RLS) on sensitive tables
- Added audit logging for evidence access
- Implemented updated_at triggers for all tables

## Next Steps

1. Verify all tables were created successfully
2. Test database connections from application
3. Run data validation scripts
4. Update application code to use new schema
5. Monitor performance with new indexes

## Rollback Instructions

If rollback is needed:
1. Restore from database backup taken before migration
2. Or manually drop new tables and restore original schema

## Notes

- All existing data should be preserved
- New columns have default values or allow NULL
- Indexes will improve query performance
- Materialized views need periodic refresh (Neon)
"""
        
        with open('migration_log.md', 'w') as f:
            f.write(log_content)
        
        logger.info("✓ Migration log created: migration_log.md")
    
    def run_migration(self):
        """Run complete migration process"""
        logger.info("=" * 60)
        logger.info("DATABASE MIGRATION: Enhanced Schemas")
        logger.info("=" * 60)
        
        supabase_success = self.migrate_supabase()
        neon_success = self.migrate_neon()
        
        self.create_migration_log(supabase_success, neon_success)
        
        logger.info("=" * 60)
        logger.info("MIGRATION SUMMARY")
        logger.info("=" * 60)
        logger.info(f"Supabase: {'✓ SUCCESS' if supabase_success else '✗ FAILED'}")
        logger.info(f"Neon:     {'✓ SUCCESS' if neon_success else '✗ FAILED'}")
        logger.info("=" * 60)
        
        if supabase_success and neon_success:
            logger.info("✓ All migrations completed successfully!")
            return 0
        elif supabase_success or neon_success:
            logger.warning("⚠ Partial migration completed. Check logs for details.")
            return 1
        else:
            logger.error("✗ Migration failed. Check logs for details.")
            return 2


def main():
    """Main entry point"""
    print("""
╔══════════════════════════════════════════════════════════════╗
║          DATABASE MIGRATION: ENHANCED SCHEMAS                ║
║                                                              ║
║  This script will migrate your databases to the enhanced    ║
║  schema with improved structure and performance.            ║
║                                                              ║
║  Required Environment Variables:                            ║
║    - SUPABASE_URL                                           ║
║    - SUPABASE_KEY                                           ║
║    - SUPABASE_DB_PASSWORD (for direct SQL execution)       ║
║    - NEON_CONNECTION_STRING                                 ║
║                                                              ║
║  ⚠  WARNING: Always backup your databases before migration! ║
╚══════════════════════════════════════════════════════════════╝
    """)
    
    response = input("Do you want to proceed with the migration? (yes/no): ")
    if response.lower() not in ['yes', 'y']:
        print("Migration cancelled.")
        return 0
    
    migration = DatabaseMigration()
    return migration.run_migration()


if __name__ == "__main__":
    sys.exit(main())

