#!/usr/bin/env python3.11
"""
Database Synchronization Execution Script
Executes the unified database sync to synchronize schemas and data
between Supabase and Neon databases.
"""

import os
import sys
import json
import logging
from pathlib import Path
from datetime import datetime

# Add src to path
sys.path.insert(0, str(Path(__file__).parent))

from src.database_sync.unified_sync import UnifiedDatabaseSync

# Configure logging
logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(name)s - %(levelname)s - %(message)s',
    handlers=[
        logging.FileHandler('database_sync.log'),
        logging.StreamHandler()
    ]
)
logger = logging.getLogger(__name__)


def main():
    """Main execution function"""
    logger.info("=" * 80)
    logger.info("DATABASE SYNCHRONIZATION EXECUTION")
    logger.info(f"Timestamp: {datetime.utcnow().isoformat()}")
    logger.info("=" * 80)
    
    try:
        # Initialize unified sync
        logger.info("\n📊 Initializing unified database sync...")
        sync = UnifiedDatabaseSync()
        
        # Get comprehensive status
        logger.info("\n📈 Getting comprehensive status...")
        status = sync.get_comprehensive_status()
        logger.info(f"Status: {json.dumps(status, indent=2)}")
        
        # Validate schemas
        logger.info("\n🔍 Validating database schemas...")
        expected_tables = [
            'cases',
            'evidence', 
            'documents',
            'entities',
            'relationships',
            'timeline'
        ]
        validation = sync.validate_schemas(expected_tables)
        logger.info(f"Validation: {json.dumps(validation, indent=2)}")
        
        # Sync performance indexes migration
        logger.info("\n🚀 Creating performance indexes...")
        migration_file = Path(__file__).parent / "migrations" / "add_performance_indexes.sql"
        
        if migration_file.exists():
            index_results = sync.create_performance_indexes(target="both")
            logger.info(f"Index Results: {json.dumps(index_results, indent=2)}")
        else:
            logger.warning(f"Migration file not found: {migration_file}")
        
        # Sync all schema files
        logger.info("\n📁 Syncing all schema files...")
        schema_results = sync.sync_all_schemas(".")
        logger.info(f"Schema Sync Results: {json.dumps(schema_results, indent=2)}")
        
        # Final status check
        logger.info("\n✅ Final status check...")
        final_status = sync.get_comprehensive_status()
        logger.info(f"Final Status: {json.dumps(final_status, indent=2)}")
        
        # Summary
        logger.info("\n" + "=" * 80)
        logger.info("SYNCHRONIZATION SUMMARY")
        logger.info("=" * 80)
        logger.info(f"Overall Health: {final_status.get('overall_health', 'unknown')}")
        logger.info(f"Supabase Connected: {final_status.get('supabase', {}).get('connected', False)}")
        logger.info(f"Neon Tools Available: {final_status.get('neon', {}).get('tool_count', 0)}")
        
        if schema_results:
            logger.info(f"Schemas Synced: {schema_results.get('synced', 0)}/{schema_results.get('total_files', 0)}")
        
        logger.info("\n✨ Database synchronization completed successfully!")
        logger.info("=" * 80)
        
        return 0
        
    except Exception as e:
        logger.error(f"\n❌ Database synchronization failed: {e}", exc_info=True)
        return 1


if __name__ == "__main__":
    sys.exit(main())

