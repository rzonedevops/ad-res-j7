#!/usr/bin/env python3
"""
Apply Migrations to Neon Database via MCP

This script applies the pending migrations to the rzonedevops-analysis Neon database.

Author: Manus AI - Hyper-Holmes Turbo-Solve Mode
Date: October 17, 2025
"""

import os
import sys
import json
import subprocess
import logging
from datetime import datetime

# Add src to path
sys.path.insert(0, os.path.join(os.path.dirname(__file__), 'src'))

from src.database_sync.migration_manager import create_initial_migrations

# Configure logging
logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(levelname)s - %(message)s'
)
logger = logging.getLogger(__name__)

# Neon project details
NEON_PROJECT_ID = "shiny-bird-78995380"  # rzonedevops-analysis
ORG_ID = "org-ancient-king-13782880"


def execute_sql_via_mcp(sql: str, project_id: str) -> bool:
    """
    Execute SQL on Neon database via MCP.
    
    Args:
        sql: SQL statement to execute
        project_id: Neon project ID
        
    Returns:
        True if successful, False otherwise
    """
    try:
        # Prepare MCP input
        mcp_input = {
            "params": {
                "projectId": project_id,
                "sql": sql
            }
        }
        
        # Execute via MCP
        result = subprocess.run(
            [
                'manus-mcp-cli', 'tool', 'call', 'run_sql',
                '--server', 'neon',
                '--input', json.dumps(mcp_input)
            ],
            capture_output=True,
            text=True,
            timeout=30
        )
        
        if result.returncode == 0:
            logger.info("SQL executed successfully")
            return True
        else:
            logger.error(f"SQL execution failed: {result.stderr}")
            return False
            
    except Exception as e:
        logger.error(f"Error executing SQL: {e}")
        return False


def apply_migrations():
    """Apply all pending migrations to Neon database."""
    logger.info("=" * 80)
    logger.info("APPLYING MIGRATIONS TO NEON DATABASE")
    logger.info("=" * 80)
    logger.info(f"Project: rzonedevops-analysis ({NEON_PROJECT_ID})")
    logger.info(f"Timestamp: {datetime.now().isoformat()}")
    logger.info("")
    
    # Create migration manager
    manager = create_initial_migrations()
    
    # Get pending migrations
    pending = manager.get_pending_migrations()
    
    if not pending:
        logger.info("No pending migrations to apply")
        return True
    
    logger.info(f"Found {len(pending)} pending migrations:")
    for migration in pending:
        logger.info(f"  - {migration.version}: {migration.name}")
    logger.info("")
    
    # Apply each migration
    successful = 0
    failed = 0
    
    for migration in pending:
        logger.info("-" * 80)
        logger.info(f"Applying migration {migration.version}: {migration.name}")
        logger.info(f"Description: {migration.description}")
        logger.info("")
        
        # Split SQL into individual statements
        statements = [s.strip() for s in migration.up_sql.split(';') if s.strip()]
        
        migration_success = True
        for i, statement in enumerate(statements, 1):
            logger.info(f"  Executing statement {i}/{len(statements)}...")
            
            if execute_sql_via_mcp(statement, NEON_PROJECT_ID):
                logger.info(f"  ✓ Statement {i} executed successfully")
            else:
                logger.error(f"  ✗ Statement {i} failed")
                migration_success = False
                break
        
        if migration_success:
            logger.info(f"✓ Migration {migration.version} applied successfully")
            successful += 1
        else:
            logger.error(f"✗ Migration {migration.version} failed")
            failed += 1
            # Stop on first failure
            break
        
        logger.info("")
    
    # Summary
    logger.info("=" * 80)
    logger.info("MIGRATION SUMMARY")
    logger.info("=" * 80)
    logger.info(f"Total migrations: {len(pending)}")
    logger.info(f"Successful: {successful}")
    logger.info(f"Failed: {failed}")
    logger.info("=" * 80)
    
    if failed == 0:
        logger.info("✅ All migrations applied successfully!")
        return True
    else:
        logger.error("❌ Some migrations failed")
        return False


def main():
    """Main entry point."""
    try:
        success = apply_migrations()
        sys.exit(0 if success else 1)
    except KeyboardInterrupt:
        logger.info("\nMigration cancelled by user")
        sys.exit(1)
    except Exception as e:
        logger.error(f"Unexpected error: {e}", exc_info=True)
        sys.exit(1)


if __name__ == "__main__":
    main()

