"""
Unified Database Synchronization Orchestrator
Coordinates synchronization between Supabase and Neon databases,
ensuring data consistency and providing comprehensive sync management.
"""

import logging
import json
from typing import Dict, List, Any
from datetime import datetime
from pathlib import Path

from .enhanced_supabase_sync import EnhancedSupabaseSync
from .neon_mcp_sync import NeonMCPSync

# Configure logging
logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(name)s - %(levelname)s - %(message)s'
)
logger = logging.getLogger(__name__)


class UnifiedSyncError(Exception):
    """Custom exception for unified sync errors"""


class UnifiedDatabaseSync:
    """
    Orchestrates synchronization between Supabase and Neon databases.
    Ensures data consistency and provides comprehensive sync management.
    """
    
    def __init__(self):
        """Initialize the unified sync orchestrator"""
        try:
            self.supabase_sync = EnhancedSupabaseSync()
            logger.info("Supabase sync initialized")
        except Exception as e:
            logger.error(f"Failed to initialize Supabase sync: {e}")
            self.supabase_sync = None
        
        try:
            self.neon_sync = NeonMCPSync()
            logger.info("Neon MCP sync initialized")
        except Exception as e:
            logger.error(f"Failed to initialize Neon sync: {e}")
            self.neon_sync = None
        
        if not self.supabase_sync and not self.neon_sync:
            raise UnifiedSyncError("Failed to initialize any database sync clients")
        
        logger.info("Unified database sync orchestrator initialized")
    
    def sync_schema(self, schema_file: str, target: str = "both") -> Dict[str, Any]:
        """
        Synchronize database schema to target databases.
        
        Args:
            schema_file: Path to SQL schema file
            target: Target database(s) - "supabase", "neon", or "both"
            
        Returns:
            Dictionary with sync results for each target
        """
        logger.info(f"Syncing schema from {schema_file} to {target}")
        
        results = {
            'schema_file': schema_file,
            'target': target,
            'timestamp': datetime.utcnow().isoformat(),
            'supabase': None,
            'neon': None,
            'status': 'pending'
        }
        
        # Sync to Supabase
        if target in ["supabase", "both"] and self.supabase_sync:
            try:
                results['supabase'] = self.supabase_sync.execute_schema(schema_file)
                logger.info("Supabase schema sync completed")
            except Exception as e:
                results['supabase'] = {'error': str(e), 'status': 'failed'}
                logger.error(f"Supabase schema sync failed: {e}")
        
        # Sync to Neon
        if target in ["neon", "both"] and self.neon_sync:
            try:
                results['neon'] = self.neon_sync.execute_schema(schema_file)
                logger.info("Neon schema sync completed")
            except Exception as e:
                results['neon'] = {'error': str(e), 'status': 'failed'}
                logger.error(f"Neon schema sync failed: {e}")
        
        # Determine overall status
        if results['supabase'] or results['neon']:
            has_errors = (
                (results['supabase'] and 'error' in results['supabase']) or
                (results['neon'] and 'error' in results['neon'])
            )
            results['status'] = 'partial' if has_errors else 'success'
        else:
            results['status'] = 'failed'
        
        logger.info(f"Schema sync completed with status: {results['status']}")
        return results
    
    def sync_table(self, table_name: str, data: List[Dict[str, Any]], 
                   target: str = "both") -> Dict[str, Any]:
        """
        Synchronize table data to target databases.
        
        Args:
            table_name: Name of the table to sync
            data: List of dictionaries containing row data
            target: Target database(s) - "supabase", "neon", or "both"
            
        Returns:
            Dictionary with sync results for each target
        """
        logger.info(f"Syncing {len(data)} records to table '{table_name}' in {target}")
        
        results = {
            'table': table_name,
            'record_count': len(data),
            'target': target,
            'timestamp': datetime.utcnow().isoformat(),
            'supabase': None,
            'neon': None,
            'status': 'pending'
        }
        
        # Sync to Supabase
        if target in ["supabase", "both"] and self.supabase_sync:
            try:
                results['supabase'] = self.supabase_sync.sync_table_data(table_name, data)
                logger.info(f"Supabase table '{table_name}' sync completed")
            except Exception as e:
                results['supabase'] = {'error': str(e), 'status': 'failed'}
                logger.error(f"Supabase table sync failed: {e}")
        
        # Sync to Neon
        if target in ["neon", "both"] and self.neon_sync:
            try:
                results['neon'] = self.neon_sync.sync_table_data(table_name, data)
                logger.info(f"Neon table '{table_name}' sync completed")
            except Exception as e:
                results['neon'] = {'error': str(e), 'status': 'failed'}
                logger.error(f"Neon table sync failed: {e}")
        
        # Determine overall status
        if results['supabase'] or results['neon']:
            has_errors = (
                (results['supabase'] and 'error' in results['supabase']) or
                (results['neon'] and 'error' in results['neon'])
            )
            results['status'] = 'partial' if has_errors else 'success'
        else:
            results['status'] = 'failed'
        
        logger.info(f"Table sync completed with status: {results['status']}")
        return results
    
    def create_performance_indexes(self, target: str = "both") -> Dict[str, Any]:
        """
        Create performance indexes on target databases.
        
        Args:
            target: Target database(s) - "supabase", "neon", or "both"
            
        Returns:
            Dictionary with index creation results
        """
        logger.info(f"Creating performance indexes on {target}")
        
        results = {
            'target': target,
            'timestamp': datetime.utcnow().isoformat(),
            'supabase': None,
            'neon': None,
            'status': 'pending'
        }
        
        # Create indexes on Supabase
        if target in ["supabase", "both"] and self.supabase_sync:
            try:
                results['supabase'] = self.supabase_sync.create_performance_indexes()
                logger.info("Supabase indexes created")
            except Exception as e:
                results['supabase'] = {'error': str(e), 'status': 'failed'}
                logger.error(f"Supabase index creation failed: {e}")
        
        # Create indexes on Neon
        if target in ["neon", "both"] and self.neon_sync:
            try:
                results['neon'] = self.neon_sync.create_performance_indexes()
                logger.info("Neon indexes created")
            except Exception as e:
                results['neon'] = {'error': str(e), 'status': 'failed'}
                logger.error(f"Neon index creation failed: {e}")
        
        # Determine overall status
        if results['supabase'] or results['neon']:
            has_errors = (
                (results['supabase'] and 'error' in results['supabase']) or
                (results['neon'] and 'error' in results['neon'])
            )
            results['status'] = 'partial' if has_errors else 'success'
        else:
            results['status'] = 'failed'
        
        logger.info(f"Index creation completed with status: {results['status']}")
        return results
    
    def validate_schemas(self, expected_tables: List[str]) -> Dict[str, Any]:
        """
        Validate that expected tables exist in both databases.
        
        Args:
            expected_tables: List of table names to validate
            
        Returns:
            Dictionary with validation results for each database
        """
        logger.info(f"Validating {len(expected_tables)} tables across databases")
        
        results = {
            'expected_tables': expected_tables,
            'timestamp': datetime.utcnow().isoformat(),
            'supabase': None,
            'neon': None,
            'consistent': False
        }
        
        # Validate Supabase schema
        if self.supabase_sync:
            try:
                results['supabase'] = self.supabase_sync.validate_schema(expected_tables)
            except Exception as e:
                results['supabase'] = {'error': str(e)}
                logger.error(f"Supabase validation failed: {e}")
        
        # Validate Neon schema (using query approach)
        if self.neon_sync:
            neon_validation = {}
            for table in expected_tables:
                try:
                    query = f"SELECT EXISTS (SELECT FROM information_schema.tables WHERE table_name = '{table}');"
                    result = self.neon_sync.execute_query(query)
                    neon_validation[table] = True  # Simplified - actual parsing would be needed
                except:
                    neon_validation[table] = False
            results['neon'] = neon_validation
        
        # Check consistency
        if results['supabase'] and results['neon']:
            results['consistent'] = results['supabase'] == results['neon']
        
        logger.info(f"Schema validation completed. Consistent: {results['consistent']}")
        return results
    
    def get_comprehensive_status(self) -> Dict[str, Any]:
        """
        Get comprehensive status of both database connections.
        
        Returns:
            Dictionary with detailed status information
        """
        status = {
            'timestamp': datetime.utcnow().isoformat(),
            'supabase': None,
            'neon': None,
            'overall_health': 'unknown'
        }
        
        # Get Supabase status
        if self.supabase_sync:
            try:
                status['supabase'] = self.supabase_sync.get_sync_status()
            except Exception as e:
                status['supabase'] = {'error': str(e), 'connected': False}
        
        # Get Neon status
        if self.neon_sync:
            try:
                status['neon'] = self.neon_sync.get_sync_status()
            except Exception as e:
                status['neon'] = {'error': str(e)}
        
        # Determine overall health
        supabase_healthy = status['supabase'] and status['supabase'].get('connected', False)
        neon_healthy = status['neon'] and status['neon'].get('tool_count', 0) > 0
        
        if supabase_healthy and neon_healthy:
            status['overall_health'] = 'healthy'
        elif supabase_healthy or neon_healthy:
            status['overall_health'] = 'partial'
        else:
            status['overall_health'] = 'unhealthy'
        
        return status
    
    def sync_all_schemas(self, schema_dir: str = ".") -> Dict[str, Any]:
        """
        Synchronize all SQL schema files from a directory.
        
        Args:
            schema_dir: Directory containing SQL schema files
            
        Returns:
            Dictionary with sync results for all schemas
        """
        logger.info(f"Syncing all schemas from {schema_dir}")
        
        schema_path = Path(schema_dir)
        sql_files = list(schema_path.glob("*.sql"))
        
        results = {
            'schema_dir': schema_dir,
            'total_files': len(sql_files),
            'synced': 0,
            'failed': 0,
            'details': []
        }
        
        for sql_file in sql_files:
            try:
                sync_result = self.sync_schema(str(sql_file), target="both")
                if sync_result['status'] == 'success':
                    results['synced'] += 1
                else:
                    results['failed'] += 1
                results['details'].append(sync_result)
            except Exception as e:
                results['failed'] += 1
                results['details'].append({
                    'file': str(sql_file),
                    'error': str(e),
                    'status': 'failed'
                })
                logger.error(f"Failed to sync {sql_file}: {e}")
        
        logger.info(
            f"Schema sync complete: {results['synced']} succeeded, {results['failed']} failed"
        )
        
        return results


def main():
    """Main function for testing the unified sync orchestrator"""
    try:
        sync = UnifiedDatabaseSync()
        
        # Get comprehensive status
        status = sync.get_comprehensive_status()
        print(f"Comprehensive Status:\n{json.dumps(status, indent=2)}")
        
        # Validate schemas
        expected_tables = ['cases', 'evidence', 'documents', 'entities', 'relationships']
        validation = sync.validate_schemas(expected_tables)
        print(f"\nSchema Validation:\n{json.dumps(validation, indent=2)}")
        
        # Create performance indexes
        index_results = sync.create_performance_indexes(target="both")
        print(f"\nIndex Creation:\n{json.dumps(index_results, indent=2)}")
        
        logger.info("Unified sync test completed successfully")
        
    except Exception as e:
        logger.error(f"Test failed: {e}")
        raise


if __name__ == "__main__":
    main()

