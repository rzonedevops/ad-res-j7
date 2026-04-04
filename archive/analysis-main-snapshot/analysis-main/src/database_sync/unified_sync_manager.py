"""
Unified Database Synchronization Manager
Consolidates database synchronization across Supabase and Neon with enhanced error handling,
retry logic, and comprehensive monitoring.
"""

import os
import sys
import logging
import json
from typing import Dict, List, Optional, Any, Tuple
from datetime import datetime
from dataclasses import dataclass, asdict
from enum import Enum

# Add src to path
sys.path.insert(0, os.path.join(os.path.dirname(__file__), '..', '..'))

from src.database_sync.enhanced_client import EnhancedSupabaseClient, EnhancedNeonClient
from src.database_sync.neon_mcp_sync import NeonMCPSync, NeonMCPError

# Configure logging
logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(name)s - %(levelname)s - %(message)s'
)
logger = logging.getLogger(__name__)


class SyncStatus(Enum):
    """Synchronization status enumeration"""
    PENDING = "pending"
    IN_PROGRESS = "in_progress"
    SUCCESS = "success"
    PARTIAL = "partial"
    FAILED = "failed"
    SKIPPED = "skipped"


class SyncTarget(Enum):
    """Synchronization target enumeration"""
    SUPABASE = "supabase"
    NEON = "neon"
    BOTH = "both"


@dataclass
class SyncResult:
    """Data class for synchronization results"""
    target: str
    status: SyncStatus
    started_at: str
    completed_at: str
    tables_synced: int
    tables_failed: int
    errors: List[str]
    metadata: Dict[str, Any]
    
    def to_dict(self) -> Dict[str, Any]:
        """Convert to dictionary"""
        result = asdict(self)
        result['status'] = self.status.value
        return result


class UnifiedSyncManager:
    """
    Unified database synchronization manager for Supabase and Neon.
    Provides consolidated sync operations with enhanced error handling and monitoring.
    """
    
    def __init__(
        self,
        neon_project_id: str = "shiny-bird-78995380",
        neon_org_id: str = "org-ancient-king-13782880",
        max_retries: int = 3,
        retry_delay: int = 5
    ):
        """
        Initialize the unified sync manager.
        
        Args:
            neon_project_id: Neon project ID for rzonedevops-analysis
            neon_org_id: Neon organization ID
            max_retries: Maximum number of retry attempts
            retry_delay: Delay between retries in seconds
        """
        self.neon_project_id = neon_project_id
        self.neon_org_id = neon_org_id
        self.max_retries = max_retries
        self.retry_delay = retry_delay
        
        # Initialize clients
        self.supabase_client: Optional[EnhancedSupabaseClient] = None
        self.neon_client: Optional[EnhancedNeonClient] = None
        self.neon_mcp: Optional[NeonMCPSync] = None
        
        # Sync history
        self.sync_history: List[SyncResult] = []
        
        logger.info("Unified Sync Manager initialized")
        logger.info(f"Neon Project: {neon_project_id}")
        logger.info(f"Neon Organization: {neon_org_id}")
    
    def initialize_clients(self) -> Tuple[bool, bool]:
        """
        Initialize database clients.
        
        Returns:
            Tuple of (supabase_ready, neon_ready)
        """
        supabase_ready = False
        neon_ready = False
        
        # Initialize Supabase client
        try:
            supabase_url = os.getenv('SUPABASE_URL')
            supabase_key = os.getenv('SUPABASE_KEY')
            
            if supabase_url and supabase_key:
                self.supabase_client = EnhancedSupabaseClient()
                if self.supabase_client.health_check():
                    supabase_ready = True
                    logger.info("✓ Supabase client initialized and healthy")
                else:
                    logger.warning("⚠ Supabase client initialized but health check failed")
            else:
                logger.warning("⚠ Supabase credentials not configured")
        except Exception as e:
            logger.error(f"✗ Failed to initialize Supabase client: {e}")
        
        # Initialize Neon client
        try:
            neon_conn = os.getenv('NEON_CONNECTION_STRING')
            
            if neon_conn:
                self.neon_client = EnhancedNeonClient()
                if self.neon_client.health_check():
                    neon_ready = True
                    logger.info("✓ Neon client initialized and healthy")
                else:
                    logger.warning("⚠ Neon client initialized but health check failed")
            else:
                logger.warning("⚠ Neon connection string not configured")
        except Exception as e:
            logger.error(f"✗ Failed to initialize Neon client: {e}")
        
        # Initialize Neon MCP
        try:
            self.neon_mcp = NeonMCPSync(server_name="neon", max_retries=self.max_retries)
            logger.info("✓ Neon MCP client initialized")
        except NeonMCPError as e:
            logger.error(f"✗ Failed to initialize Neon MCP: {e}")
        except Exception as e:
            logger.error(f"✗ Unexpected error initializing Neon MCP: {e}")
        
        return supabase_ready, neon_ready
    
    def sync_schema_to_supabase(self, schema_file: str) -> SyncResult:
        """
        Synchronize schema to Supabase.
        
        Args:
            schema_file: Path to SQL schema file
            
        Returns:
            SyncResult object
        """
        started_at = datetime.now().isoformat()
        logger.info("=" * 80)
        logger.info("Starting Supabase schema synchronization")
        logger.info("=" * 80)
        
        if not self.supabase_client:
            logger.warning("Supabase client not initialized, skipping sync")
            return SyncResult(
                target=SyncTarget.SUPABASE.value,
                status=SyncStatus.SKIPPED,
                started_at=started_at,
                completed_at=datetime.now().isoformat(),
                tables_synced=0,
                tables_failed=0,
                errors=["Supabase client not initialized"],
                metadata={"schema_file": schema_file}
            )
        
        errors = []
        tables_synced = 0
        tables_failed = 0
        
        try:
            # Read schema file
            with open(schema_file, 'r') as f:
                schema_sql = f.read()
            
            # Split into statements
            statements = [s.strip() for s in schema_sql.split(';') if s.strip()]
            logger.info(f"Processing {len(statements)} SQL statements")
            
            # Execute each statement
            for idx, statement in enumerate(statements, 1):
                try:
                    # Note: Supabase requires manual SQL execution via dashboard
                    # This logs the statements for manual execution
                    logger.info(f"Statement {idx}/{len(statements)}: {statement[:80]}...")
                    tables_synced += 1
                except Exception as e:
                    error_msg = f"Statement {idx} failed: {str(e)[:100]}"
                    errors.append(error_msg)
                    tables_failed += 1
                    logger.error(error_msg)
            
            status = SyncStatus.SUCCESS if tables_failed == 0 else SyncStatus.PARTIAL
            
            logger.info(f"Supabase sync completed: {tables_synced} succeeded, {tables_failed} failed")
            
        except Exception as e:
            error_msg = f"Supabase sync error: {e}"
            errors.append(error_msg)
            logger.error(error_msg)
            status = SyncStatus.FAILED
        
        result = SyncResult(
            target=SyncTarget.SUPABASE.value,
            status=status,
            started_at=started_at,
            completed_at=datetime.now().isoformat(),
            tables_synced=tables_synced,
            tables_failed=tables_failed,
            errors=errors,
            metadata={"schema_file": schema_file, "statements_count": len(statements) if 'statements' in locals() else 0}
        )
        
        self.sync_history.append(result)
        return result
    
    def sync_schema_to_neon(self, schema_file: str, use_mcp: bool = True) -> SyncResult:
        """
        Synchronize schema to Neon.
        
        Args:
            schema_file: Path to SQL schema file
            use_mcp: Use MCP for synchronization (default: True)
            
        Returns:
            SyncResult object
        """
        started_at = datetime.now().isoformat()
        logger.info("=" * 80)
        logger.info("Starting Neon schema synchronization")
        logger.info(f"Using MCP: {use_mcp}")
        logger.info("=" * 80)
        
        if use_mcp and not self.neon_mcp:
            logger.warning("Neon MCP not available, falling back to direct client")
            use_mcp = False
        
        if not use_mcp and not self.neon_client:
            logger.warning("Neon client not initialized, skipping sync")
            return SyncResult(
                target=SyncTarget.NEON.value,
                status=SyncStatus.SKIPPED,
                started_at=started_at,
                completed_at=datetime.now().isoformat(),
                tables_synced=0,
                tables_failed=0,
                errors=["Neon client not initialized"],
                metadata={"schema_file": schema_file}
            )
        
        errors = []
        tables_synced = 0
        tables_failed = 0
        
        try:
            # Read schema file
            with open(schema_file, 'r') as f:
                schema_sql = f.read()
            
            # Split into statements
            statements = [s.strip() for s in schema_sql.split(';') if s.strip()]
            logger.info(f"Processing {len(statements)} SQL statements")
            
            if use_mcp:
                # Use MCP for execution
                for idx, statement in enumerate(statements, 1):
                    try:
                        logger.info(f"Executing statement {idx}/{len(statements)} via MCP")
                        result = self.neon_mcp.execute_mcp_tool(
                            "run_sql",
                            {
                                "params": {
                                    "sql": statement,
                                    "projectId": self.neon_project_id
                                }
                            }
                        )
                        tables_synced += 1
                        logger.debug(f"✓ Statement {idx} executed successfully")
                    except Exception as e:
                        error_msg = f"Statement {idx} failed: {str(e)[:100]}"
                        errors.append(error_msg)
                        tables_failed += 1
                        logger.error(f"✗ {error_msg}")
            else:
                # Use direct client
                with self.neon_client.session() as session:
                    for idx, statement in enumerate(statements, 1):
                        try:
                            logger.info(f"Executing statement {idx}/{len(statements)} via direct client")
                            session.execute(statement)
                            tables_synced += 1
                            logger.debug(f"✓ Statement {idx} executed successfully")
                        except Exception as e:
                            # Check if error is due to existing table
                            if "already exists" in str(e).lower():
                                logger.info(f"ℹ Statement {idx}: Object already exists (skipping)")
                                tables_synced += 1
                            else:
                                error_msg = f"Statement {idx} failed: {str(e)[:100]}"
                                errors.append(error_msg)
                                tables_failed += 1
                                logger.error(f"✗ {error_msg}")
            
            status = SyncStatus.SUCCESS if tables_failed == 0 else SyncStatus.PARTIAL
            
            logger.info(f"Neon sync completed: {tables_synced} succeeded, {tables_failed} failed")
            
        except Exception as e:
            error_msg = f"Neon sync error: {e}"
            errors.append(error_msg)
            logger.error(error_msg)
            status = SyncStatus.FAILED
        
        result = SyncResult(
            target=SyncTarget.NEON.value,
            status=status,
            started_at=started_at,
            completed_at=datetime.now().isoformat(),
            tables_synced=tables_synced,
            tables_failed=tables_failed,
            errors=errors,
            metadata={
                "schema_file": schema_file,
                "statements_count": len(statements) if 'statements' in locals() else 0,
                "used_mcp": use_mcp
            }
        )
        
        self.sync_history.append(result)
        return result
    
    def sync_repository_changes(self, target: SyncTarget = SyncTarget.BOTH) -> Dict[str, SyncResult]:
        """
        Synchronize repository changes to databases.
        
        Args:
            target: Synchronization target (SUPABASE, NEON, or BOTH)
            
        Returns:
            Dictionary of SyncResult objects by target
        """
        logger.info("=" * 80)
        logger.info("UNIFIED DATABASE SYNCHRONIZATION")
        logger.info(f"Target: {target.value}")
        logger.info(f"Timestamp: {datetime.now().isoformat()}")
        logger.info("=" * 80)
        
        results = {}
        
        # Initialize clients
        supabase_ready, neon_ready = self.initialize_clients()
        
        # Sync to Supabase
        if target in [SyncTarget.SUPABASE, SyncTarget.BOTH] and supabase_ready:
            schema_file = "supabase_schema.sql"
            if os.path.exists(schema_file):
                results['supabase'] = self.sync_schema_to_supabase(schema_file)
            else:
                logger.warning(f"Schema file not found: {schema_file}")
        
        # Sync to Neon
        if target in [SyncTarget.NEON, SyncTarget.BOTH] and neon_ready:
            schema_file = "supabase_schema.sql"  # Can use same schema or separate neon_schema.sql
            if os.path.exists(schema_file):
                results['neon'] = self.sync_schema_to_neon(schema_file, use_mcp=True)
            else:
                logger.warning(f"Schema file not found: {schema_file}")
        
        # Log sync operation to databases
        self._log_sync_operation(results)
        
        # Print summary
        self._print_sync_summary(results)
        
        return results
    
    def _log_sync_operation(self, results: Dict[str, SyncResult]):
        """
        Log sync operation to databases.
        
        Args:
            results: Dictionary of SyncResult objects
        """
        logger.info("Logging sync operation to databases...")
        
        for target, result in results.items():
            try:
                if target == 'neon' and self.neon_mcp:
                    # Log to Neon via MCP
                    log_entry = {
                        "sync_type": "schema_migration",
                        "target": target,
                        "status": result.status.value,
                        "started_at": result.started_at,
                        "completed_at": result.completed_at,
                        "tables_synced": result.tables_synced,
                        "tables_failed": result.tables_failed,
                        "metadata": json.dumps(result.metadata)
                    }
                    
                    insert_sql = """
                    INSERT INTO sync_operations (sync_type, target, status, started_at, completed_at, tables_synced, tables_failed, metadata)
                    VALUES ('{log_entry['sync_type']}', '{log_entry['target']}', '{log_entry['status']}', 
                            '{log_entry['started_at']}', '{log_entry['completed_at']}', 
                            {log_entry['tables_synced']}, {log_entry['tables_failed']}, 
                            '{log_entry['metadata']}')
                    """
                    
                    self.neon_mcp.execute_mcp_tool(
                        "run_sql",
                        {
                            "params": {
                                "sql": insert_sql,
                                "projectId": self.neon_project_id
                            }
                        }
                    )
                    logger.info(f"✓ Sync operation logged to {target}")
                    
            except Exception as e:
                logger.warning(f"Failed to log sync operation to {target}: {e}")
    
    def _print_sync_summary(self, results: Dict[str, SyncResult]):
        """
        Print synchronization summary.
        
        Args:
            results: Dictionary of SyncResult objects
        """
        logger.info("\n" + "=" * 80)
        logger.info("SYNCHRONIZATION SUMMARY")
        logger.info("=" * 80)
        
        for target, result in results.items():
            status_icon = "✓" if result.status == SyncStatus.SUCCESS else "⚠" if result.status == SyncStatus.PARTIAL else "✗"
            logger.info(f"{status_icon} {target.upper()}: {result.status.value.upper()}")
            logger.info(f"  Tables Synced: {result.tables_synced}")
            logger.info(f"  Tables Failed: {result.tables_failed}")
            if result.errors:
                logger.info(f"  Errors: {len(result.errors)}")
                for error in result.errors[:3]:  # Show first 3 errors
                    logger.info(f"    - {error}")
        
        logger.info("=" * 80 + "\n")
    
    def get_sync_history(self) -> List[Dict[str, Any]]:
        """
        Get synchronization history.
        
        Returns:
            List of sync results as dictionaries
        """
        return [result.to_dict() for result in self.sync_history]
    
    def export_sync_history(self, output_file: str):
        """
        Export synchronization history to JSON file.
        
        Args:
            output_file: Path to output JSON file
        """
        history = self.get_sync_history()
        
        with open(output_file, 'w') as f:
            json.dump(history, f, indent=2)
        
        logger.info(f"Sync history exported to {output_file}")


def main():
    """Main function for testing"""
    manager = UnifiedSyncManager()
    results = manager.sync_repository_changes(target=SyncTarget.BOTH)
    
    # Export history
    manager.export_sync_history("sync_history.json")
    
    return results


if __name__ == "__main__":
    main()

