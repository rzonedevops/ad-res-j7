"""
Neon MCP Synchronization Module
Provides database synchronization with Neon PostgreSQL using Model Context Protocol (MCP).
Leverages manus-mcp-cli for optimized database operations and query performance.
"""

import logging
import subprocess
import json
from typing import Dict, List, Any
from datetime import datetime

# Configure logging
logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(name)s - %(levelname)s - %(message)s'
)
logger = logging.getLogger(__name__)


class NeonMCPError(Exception):
    """Custom exception for Neon MCP errors"""


class NeonMCPSync:
    """
    Neon database synchronization using Model Context Protocol.
    Provides optimized database operations through MCP server integration.
    """
    
    def __init__(self, server_name: str = "neon", max_retries: int = 3):
        """
        Initialize the Neon MCP sync client.
        
        Args:
            server_name: Name of the MCP server (default: "neon")
            max_retries: Maximum number of retry attempts for failed operations
        """
        self.server_name = server_name
        self.max_retries = max_retries
        self.mcp_cli = "manus-mcp-cli"
        
        # Verify MCP CLI is available
        self._verify_mcp_cli()
        
        # List available tools
        self.available_tools = self._list_available_tools()
        
        logger.info(f"Neon MCP sync initialized with {len(self.available_tools)} available tools")
    
    def _verify_mcp_cli(self):
        """Verify that manus-mcp-cli is available"""
        try:
            result = subprocess.run(
                [self.mcp_cli, "--help"],
                capture_output=True,
                text=True,
                timeout=10
            )
            if result.returncode != 0:
                raise NeonMCPError("manus-mcp-cli is not functioning properly")
            logger.debug("MCP CLI verified successfully")
        except FileNotFoundError:
            raise NeonMCPError("manus-mcp-cli not found in PATH")
        except subprocess.TimeoutExpired:
            raise NeonMCPError("manus-mcp-cli verification timed out")
    
    def _list_available_tools(self) -> List[str]:
        """
        List available MCP tools for the Neon server.
        
        Returns:
            List of available tool names
        """
        try:
            result = subprocess.run(
                [self.mcp_cli, "tool", "list", "--server", self.server_name],
                capture_output=True,
                text=True,
                timeout=30
            )
            
            if result.returncode == 0:
                # Parse tool names from output
                tools = []
                for line in result.stdout.split('\n'):
                    if line.strip() and not line.startswith('#'):
                        # Extract tool name (first word)
                        tool_name = line.strip().split()[0]
                        if tool_name:
                            tools.append(tool_name)
                return tools
            else:
                logger.warning(f"Failed to list tools: {result.stderr}")
                return []
                
        except Exception as e:
            logger.warning(f"Could not list MCP tools: {e}")
            return []
    
    def execute_mcp_tool(self, tool_name: str, args: Dict[str, Any]) -> Dict[str, Any]:
        """
        Execute an MCP tool with the given arguments.
        
        Args:
            tool_name: Name of the MCP tool to execute
            args: Dictionary of arguments for the tool
            
        Returns:
            Dictionary with tool execution results
        """
        logger.info(f"Executing MCP tool: {tool_name}")
        
        try:
            # Prepare the command
            cmd = [
                self.mcp_cli, "tool", "call", tool_name,
                "--server", self.server_name,
                "--input", json.dumps(args)
            ]
            
            # Execute the command
            result = subprocess.run(
                cmd,
                capture_output=True,
                text=True,
                timeout=60
            )
            
            if result.returncode == 0:
                # Parse JSON output
                try:
                    output = json.loads(result.stdout)
                    logger.debug(f"Tool {tool_name} executed successfully")
                    return output
                except json.JSONDecodeError:
                    # Return raw output if not JSON
                    return {'output': result.stdout, 'raw': True}
            else:
                error_msg = f"Tool execution failed: {result.stderr}"
                logger.error(error_msg)
                raise NeonMCPError(error_msg)
                
        except subprocess.TimeoutExpired:
            error_msg = f"Tool {tool_name} execution timed out"
            logger.error(error_msg)
            raise NeonMCPError(error_msg)
        except Exception as e:
            error_msg = f"Tool execution error: {e}"
            logger.error(error_msg)
            raise NeonMCPError(error_msg)
    
    def execute_query(self, query: str, database: str = "analysis_framework") -> Dict[str, Any]:
        """
        Execute a SQL query using MCP.
        
        Args:
            query: SQL query to execute
            database: Database name (default: "analysis_framework")
            
        Returns:
            Dictionary with query results
        """
        logger.info(f"Executing query on database '{database}'")
        
        args = {
            "query": query,
            "database": database
        }
        
        try:
            result = self.execute_mcp_tool("execute_query", args)
            return result
        except Exception as e:
            logger.error(f"Query execution failed: {e}")
            raise NeonMCPError(f"Query execution failed: {e}")
    
    def execute_schema(self, schema_file: str, database: str = "analysis_framework") -> Dict[str, Any]:
        """
        Execute SQL schema file using MCP.
        
        Args:
            schema_file: Path to SQL schema file
            database: Database name
            
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
            
            for idx, statement in enumerate(statements, 1):
                try:
                    self.execute_query(statement, database)
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
            raise NeonMCPError(f"Schema execution failed: {e}")
    
    def create_database(self, database_name: str) -> Dict[str, Any]:
        """
        Create a new database using MCP.
        
        Args:
            database_name: Name of the database to create
            
        Returns:
            Dictionary with creation results
        """
        logger.info(f"Creating database '{database_name}'")
        
        args = {
            "database_name": database_name
        }
        
        try:
            result = self.execute_mcp_tool("create_database", args)
            logger.info(f"Database '{database_name}' created successfully")
            return result
        except Exception as e:
            logger.error(f"Database creation failed: {e}")
            raise NeonMCPError(f"Database creation failed: {e}")
    
    def list_databases(self) -> List[str]:
        """
        List all available databases.
        
        Returns:
            List of database names
        """
        logger.info("Listing databases")
        
        try:
            result = self.execute_mcp_tool("list_databases", {})
            
            if isinstance(result, dict) and 'databases' in result:
                databases = result['databases']
                logger.info(f"Found {len(databases)} databases")
                return databases
            else:
                logger.warning("Unexpected result format from list_databases")
                return []
                
        except Exception as e:
            logger.error(f"Failed to list databases: {e}")
            return []
    
    def optimize_query(self, query: str) -> Dict[str, Any]:
        """
        Optimize a SQL query using MCP query optimization tools.
        
        Args:
            query: SQL query to optimize
            
        Returns:
            Dictionary with optimization suggestions
        """
        logger.info("Optimizing query")
        
        args = {
            "query": query
        }
        
        try:
            result = self.execute_mcp_tool("optimize_query", args)
            logger.info("Query optimization complete")
            return result
        except Exception as e:
            logger.warning(f"Query optimization not available: {e}")
            return {'optimized': False, 'error': str(e)}
    
    def create_performance_indexes(self, database: str = "analysis_framework") -> Dict[str, Any]:
        """
        Create performance indexes for optimized queries.
        
        Args:
            database: Database name
            
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
        
        for idx_sql in indexes:
            try:
                self.execute_query(idx_sql, database)
                results['created'] += 1
            except Exception as e:
                results['failed'] += 1
                results['errors'].append(str(e))
                logger.warning(f"Index creation failed: {e}")
        
        logger.info(
            f"Index creation complete: {results['created']} created, {results['failed']} failed"
        )
        
        return results
    
    def get_sync_status(self) -> Dict[str, Any]:
        """
        Get current synchronization status.
        
        Returns:
            Dictionary with sync status information
        """
        status = {
            'server': self.server_name,
            'timestamp': datetime.utcnow().isoformat(),
            'available_tools': self.available_tools,
            'tool_count': len(self.available_tools),
            'databases': []
        }
        
        try:
            status['databases'] = self.list_databases()
        except:
            pass
        
        return status
    
    def sync_table_data(self, table_name: str, data: List[Dict[str, Any]], 
                       database: str = "analysis_framework") -> Dict[str, Any]:
        """
        Synchronize data to a Neon table.
        
        Args:
            table_name: Name of the table to sync
            data: List of dictionaries containing row data
            database: Database name
            
        Returns:
            Dictionary with sync results
        """
        logger.info(f"Syncing {len(data)} records to table '{table_name}'")
        
        results = {
            'table': table_name,
            'total_records': len(data),
            'inserted': 0,
            'failed': 0,
            'errors': []
        }
        
        for idx, record in enumerate(data, 1):
            try:
                # Build INSERT query
                columns = ', '.join(record.keys())
                placeholders = ', '.join([f"'{v}'" if isinstance(v, str) else str(v) 
                                        for v in record.values()])
                query = f"INSERT INTO {table_name} ({columns}) VALUES ({placeholders}) " \
                       "ON CONFLICT DO UPDATE SET " \
                       f"{', '.join([f'{k}=EXCLUDED.{k}' for k in record.keys()])};"
                
                self.execute_query(query, database)
                results['inserted'] += 1
                
                if idx % 100 == 0:
                    logger.debug(f"Synced {idx}/{len(data)} records")
                    
            except Exception as e:
                results['failed'] += 1
                error_msg = f"Record {idx} failed: {str(e)[:100]}"
                results['errors'].append(error_msg)
                logger.error(error_msg)
        
        logger.info(
            f"Table sync complete: {results['inserted']} inserted, {results['failed']} failed"
        )
        
        return results


def main():
    """Main function for testing the Neon MCP sync module"""
    try:
        sync = NeonMCPSync()
        
        # Get sync status
        status = sync.get_sync_status()
        print(f"Sync Status: {json.dumps(status, indent=2)}")
        
        # List databases
        databases = sync.list_databases()
        print(f"\nAvailable Databases: {databases}")
        
        # Create performance indexes
        index_results = sync.create_performance_indexes()
        print(f"\nIndex Creation: {json.dumps(index_results, indent=2)}")
        
        logger.info("Neon MCP sync test completed successfully")
        
    except Exception as e:
        logger.error(f"Test failed: {e}")
        raise


if __name__ == "__main__":
    main()

