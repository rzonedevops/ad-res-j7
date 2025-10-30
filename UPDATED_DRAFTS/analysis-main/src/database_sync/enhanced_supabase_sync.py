"""
Enhanced Supabase Synchronization Module
Provides robust database synchronization with error handling, transaction management,
and retry logic for the rzonedevops/analysis framework.
"""

import os
import logging
import time
from typing import Dict, List, Any
from datetime import datetime
from supabase import create_client, Client
from sqlalchemy import create_engine, text
from sqlalchemy.pool import QueuePool
import json

# Configure logging
logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(name)s - %(levelname)s - %(message)s'
)
logger = logging.getLogger(__name__)


class SupabaseSyncError(Exception):
    """Custom exception for Supabase sync errors"""


class EnhancedSupabaseSync:
    """
    Enhanced Supabase synchronization with connection pooling,
    error handling, and transaction management.
    """
    
    def __init__(self, max_retries: int = 3, retry_delay: int = 2):
        """
        Initialize the enhanced Supabase sync client.
        
        Args:
            max_retries: Maximum number of retry attempts for failed operations
            retry_delay: Delay in seconds between retry attempts
        """
        self.url = os.environ.get("SUPABASE_URL")
        self.key = os.environ.get("SUPABASE_KEY")
        
        if not self.url or not self.key:
            raise SupabaseSyncError(
                "SUPABASE_URL and SUPABASE_KEY environment variables must be set"
            )
        
        self.client: Client = create_client(self.url, self.key)
        self.max_retries = max_retries
        self.retry_delay = retry_delay
        
        # Initialize connection pool for PostgreSQL operations
        self._init_connection_pool()
        
        logger.info("Enhanced Supabase sync initialized successfully")
    
    def _init_connection_pool(self):
        """Initialize SQLAlchemy connection pool for direct PostgreSQL access"""
        try:
            # Extract database connection string from Supabase URL
            # Format: postgresql://[user]:[password]@[host]:[port]/[database]
            db_url = self.url.replace('https://', 'postgresql://postgres:')
            db_url = f"{db_url.split('.')[0]}.supabase.co:5432/postgres"
            
            self.engine = create_engine(
                db_url,
                poolclass=QueuePool,
                pool_size=10,
                max_overflow=5,
                pool_timeout=30,
                pool_pre_ping=True
            )
            logger.info("Connection pool initialized")
        except Exception as e:
            logger.warning(f"Connection pool initialization failed: {e}")
            self.engine = None
    
    def _retry_operation(self, operation, *args, **kwargs):
        """
        Retry an operation with exponential backoff.
        
        Args:
            operation: Function to retry
            *args: Positional arguments for the operation
            **kwargs: Keyword arguments for the operation
            
        Returns:
            Result of the operation
            
        Raises:
            SupabaseSyncError: If all retry attempts fail
        """
        last_error = None
        
        for attempt in range(self.max_retries):
            try:
                return operation(*args, **kwargs)
            except Exception as e:
                last_error = e
                if attempt < self.max_retries - 1:
                    delay = self.retry_delay * (2 ** attempt)
                    logger.warning(
                        f"Operation failed (attempt {attempt + 1}/{self.max_retries}): {e}. "
                        f"Retrying in {delay} seconds..."
                    )
                    time.sleep(delay)
                else:
                    logger.error(f"Operation failed after {self.max_retries} attempts: {e}")
        
        raise SupabaseSyncError(f"Operation failed after {self.max_retries} attempts: {last_error}")
    
    def execute_schema(self, schema_file: str) -> Dict[str, Any]:
        """
        Execute SQL schema file with proper error handling and transaction management.
        
        Args:
            schema_file: Path to SQL schema file
            
        Returns:
            Dictionary with execution results
        """
        logger.info(f"Executing schema from {schema_file}")
        
        try:
            with open(schema_file, 'r') as f:
                schema_sql = f.read()
            
            # Split into individual statements
            statements = [s.strip() for s in schema_sql.split(';') if s.strip()]
            
            results = {
                'total_statements': len(statements),
                'executed': 0,
                'failed': 0,
                'errors': []
            }
            
            if self.engine:
                # Use SQLAlchemy for better transaction control
                with self.engine.begin() as conn:
                    for idx, statement in enumerate(statements, 1):
                        try:
                            conn.execute(text(statement))
                            results['executed'] += 1
                            logger.debug(f"Executed statement {idx}/{len(statements)}")
                        except Exception as e:
                            results['failed'] += 1
                            error_msg = f"Statement {idx} failed: {str(e)[:100]}"
                            results['errors'].append(error_msg)
                            logger.error(error_msg)
                            # Continue with other statements
            else:
                # Fallback to Supabase RPC if direct connection not available
                for idx, statement in enumerate(statements, 1):
                    try:
                        self.client.rpc('execute_sql', {'sql': statement}).execute()
                        results['executed'] += 1
                        logger.debug(f"Executed statement {idx}/{len(statements)}")
                    except Exception as e:
                        results['failed'] += 1
                        error_msg = f"Statement {idx} failed: {str(e)[:100]}"
                        results['errors'].append(error_msg)
                        logger.error(error_msg)
            
            logger.info(
                f"Schema execution complete: {results['executed']} succeeded, "
                f"{results['failed']} failed"
            )
            
            return results
            
        except Exception as e:
            logger.error(f"Schema execution failed: {e}")
            raise SupabaseSyncError(f"Schema execution failed: {e}")
    
    def sync_table_data(self, table_name: str, data: List[Dict[str, Any]], 
                       upsert: bool = True) -> Dict[str, Any]:
        """
        Synchronize data to a Supabase table with transaction support.
        
        Args:
            table_name: Name of the table to sync
            data: List of dictionaries containing row data
            upsert: If True, use upsert (insert or update), else insert only
            
        Returns:
            Dictionary with sync results
        """
        logger.info(f"Syncing {len(data)} records to table '{table_name}'")
        
        def _sync_operation():
            if upsert:
                result = self.client.table(table_name).upsert(data).execute()
            else:
                result = self.client.table(table_name).insert(data).execute()
            return result
        
        try:
            result = self._retry_operation(_sync_operation)
            
            sync_result = {
                'table': table_name,
                'records_synced': len(data),
                'timestamp': datetime.utcnow().isoformat(),
                'status': 'success'
            }
            
            logger.info(f"Successfully synced {len(data)} records to '{table_name}'")
            return sync_result
            
        except Exception as e:
            logger.error(f"Failed to sync data to '{table_name}': {e}")
            raise SupabaseSyncError(f"Table sync failed: {e}")
    
    def validate_schema(self, expected_tables: List[str]) -> Dict[str, bool]:
        """
        Validate that expected tables exist in the database.
        
        Args:
            expected_tables: List of table names to validate
            
        Returns:
            Dictionary mapping table names to existence status
        """
        logger.info(f"Validating schema for {len(expected_tables)} tables")
        
        validation_results = {}
        
        for table in expected_tables:
            try:
                # Try to query the table (limit 0 to avoid data transfer)
                self.client.table(table).select("*").limit(0).execute()
                validation_results[table] = True
                logger.debug(f"Table '{table}' exists")
            except Exception as e:
                validation_results[table] = False
                logger.warning(f"Table '{table}' not found: {e}")
        
        valid_count = sum(validation_results.values())
        logger.info(
            f"Schema validation complete: {valid_count}/{len(expected_tables)} tables exist"
        )
        
        return validation_results
    
    def get_sync_status(self) -> Dict[str, Any]:
        """
        Get current synchronization status and health metrics.
        
        Returns:
            Dictionary with sync status information
        """
        status = {
            'connected': False,
            'url': self.url,
            'timestamp': datetime.utcnow().isoformat(),
            'pool_status': None
        }
        
        try:
            # Test connection
            self.client.table('_health_check').select("*").limit(1).execute()
            status['connected'] = True
        except:
            # Health check table might not exist, try another approach
            try:
                self.client.auth.get_session()
                status['connected'] = True
            except:
                status['connected'] = False
        
        if self.engine:
            try:
                status['pool_status'] = {
                    'pool_size': self.engine.pool.size(),
                    'checked_in': self.engine.pool.checkedin(),
                    'checked_out': self.engine.pool.checkedout(),
                    'overflow': self.engine.pool.overflow()
                }
            except:
                pass
        
        return status
    
    def create_performance_indexes(self) -> Dict[str, Any]:
        """
        Create performance indexes for optimized queries.
        
        Returns:
            Dictionary with index creation results
        """
        logger.info("Creating performance indexes")
        
        indexes = [
            "CREATE INDEX IF NOT EXISTS idx_cases_timeline ON cases(timeline_date);",
            "CREATE INDEX IF NOT EXISTS idx_evidence_case_id ON evidence(case_id);",
            "CREATE INDEX IF NOT EXISTS idx_documents_processed_date ON documents(processed_date);",
            "CREATE INDEX IF NOT EXISTS idx_entities_type ON entities(entity_type);",
            "CREATE INDEX IF NOT EXISTS idx_relationships_source ON relationships(source_entity_id);",
            "CREATE INDEX IF NOT EXISTS idx_relationships_target ON relationships(target_entity_id);"
        ]
        
        results = {
            'total_indexes': len(indexes),
            'created': 0,
            'failed': 0,
            'errors': []
        }
        
        if self.engine:
            with self.engine.begin() as conn:
                for idx_sql in indexes:
                    try:
                        conn.execute(text(idx_sql))
                        results['created'] += 1
                    except Exception as e:
                        results['failed'] += 1
                        results['errors'].append(str(e))
                        logger.warning(f"Index creation failed: {e}")
        
        logger.info(
            f"Index creation complete: {results['created']} created, {results['failed']} failed"
        )
        
        return results


def main():
    """Main function for testing the enhanced sync module"""
    try:
        sync = EnhancedSupabaseSync()
        
        # Get sync status
        status = sync.get_sync_status()
        print(f"Sync Status: {json.dumps(status, indent=2)}")
        
        # Validate expected tables
        expected_tables = ['cases', 'evidence', 'documents', 'entities', 'relationships']
        validation = sync.validate_schema(expected_tables)
        print(f"\nSchema Validation: {json.dumps(validation, indent=2)}")
        
        # Create performance indexes
        index_results = sync.create_performance_indexes()
        print(f"\nIndex Creation: {json.dumps(index_results, indent=2)}")
        
        logger.info("Enhanced Supabase sync test completed successfully")
        
    except Exception as e:
        logger.error(f"Test failed: {e}")
        raise


if __name__ == "__main__":
    main()

