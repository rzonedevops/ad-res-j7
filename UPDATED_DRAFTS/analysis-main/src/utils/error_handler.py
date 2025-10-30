"""
Enhanced Error Handler for Database Synchronization

Provides comprehensive error handling with detailed recovery instructions.
"""

import logging
from enum import Enum
from typing import Optional, Dict, Any, Callable
from functools import wraps


logger = logging.getLogger(__name__)


class ErrorCategory(Enum):
    """Categories of errors that can occur during database operations."""
    CONNECTION = "connection"
    AUTHENTICATION = "authentication"
    SCHEMA = "schema"
    QUERY = "query"
    NETWORK = "network"
    CONFIGURATION = "configuration"
    UNKNOWN = "unknown"


class DatabaseError(Exception):
    """Base exception for database-related errors."""
    
    def __init__(
        self, 
        message: str, 
        category: ErrorCategory = ErrorCategory.UNKNOWN,
        recovery_steps: Optional[list] = None,
        original_error: Optional[Exception] = None
    ):
        self.message = message
        self.category = category
        self.recovery_steps = recovery_steps or []
        self.original_error = original_error
        super().__init__(self.message)


class ErrorHandler:
    """Handles errors with detailed logging and recovery guidance."""
    
    # Error pattern matching for categorization
    ERROR_PATTERNS = {
        ErrorCategory.CONNECTION: [
            "connection refused",
            "could not connect",
            "connection timeout",
            "unable to connect",
            "connection failed"
        ],
        ErrorCategory.AUTHENTICATION: [
            "authentication failed",
            "invalid credentials",
            "access denied",
            "unauthorized",
            "permission denied",
            "invalid api key"
        ],
        ErrorCategory.SCHEMA: [
            "relation does not exist",
            "table does not exist",
            "column does not exist",
            "schema does not exist",
            "syntax error",
            "invalid schema"
        ],
        ErrorCategory.QUERY: [
            "query failed",
            "invalid query",
            "sql error",
            "execution failed"
        ],
        ErrorCategory.NETWORK: [
            "network error",
            "timeout",
            "dns resolution failed",
            "host unreachable"
        ],
        ErrorCategory.CONFIGURATION: [
            "missing configuration",
            "invalid configuration",
            "environment variable not set",
            "config error"
        ]
    }
    
    # Recovery instructions for each error category
    RECOVERY_INSTRUCTIONS = {
        ErrorCategory.CONNECTION: [
            "1. Verify the database server is running and accessible",
            "2. Check firewall settings and network connectivity",
            "3. Confirm the database host and port are correct",
            "4. Try connecting using a database client (e.g., psql, pgAdmin)",
            "5. Check if the database is accepting connections from your IP"
        ],
        ErrorCategory.AUTHENTICATION: [
            "1. Verify your database credentials are correct",
            "2. Check environment variables: SUPABASE_URL, SUPABASE_KEY, NEON_CONNECTION_STRING",
            "3. Ensure API keys have not expired",
            "4. Verify you have the necessary permissions for the operation",
            "5. For Supabase, check if you're using the correct API key (anon vs service_role)"
        ],
        ErrorCategory.SCHEMA: [
            "1. Verify the table/column exists in the database",
            "2. Check if you're connected to the correct database",
            "3. Review the schema migration status",
            "4. Run database migrations if needed",
            "5. Check for typos in table or column names"
        ],
        ErrorCategory.QUERY: [
            "1. Review the SQL query syntax",
            "2. Check for missing or extra commas, quotes, or parentheses",
            "3. Verify column names and data types match the schema",
            "4. Test the query in a database client first",
            "5. Check query logs for more detailed error information"
        ],
        ErrorCategory.NETWORK: [
            "1. Check your internet connection",
            "2. Verify DNS resolution is working",
            "3. Try pinging the database host",
            "4. Check if a VPN or proxy is interfering",
            "5. Retry the operation after a brief delay"
        ],
        ErrorCategory.CONFIGURATION: [
            "1. Review the configuration file (src/config.py)",
            "2. Set required environment variables",
            "3. Run 'python -c \"from src.config import get_config; get_config().validate()\"'",
            "4. Check .env file if using one",
            "5. Verify all required dependencies are installed"
        ],
        ErrorCategory.UNKNOWN: [
            "1. Review the full error message and stack trace",
            "2. Check application logs for more context",
            "3. Search for similar errors in documentation or issues",
            "4. Try the operation again with verbose logging enabled",
            "5. Contact support with the error details if the issue persists"
        ]
    }
    
    @classmethod
    def categorize_error(cls, error: Exception) -> ErrorCategory:
        """
        Categorize an error based on its message.
        
        Args:
            error: The exception to categorize
            
        Returns:
            ErrorCategory: The category of the error
        """
        error_message = str(error).lower()
        
        for category, patterns in cls.ERROR_PATTERNS.items():
            if any(pattern in error_message for pattern in patterns):
                return category
        
        return ErrorCategory.UNKNOWN
    
    @classmethod
    def handle_error(
        cls,
        error: Exception,
        operation: str,
        context: Optional[Dict[str, Any]] = None
    ) -> DatabaseError:
        """
        Handle an error with detailed logging and recovery guidance.
        
        Args:
            error: The exception that occurred
            operation: Description of the operation that failed
            context: Additional context about the error
            
        Returns:
            DatabaseError: Enhanced error with recovery instructions
        """
        category = cls.categorize_error(error)
        recovery_steps = cls.RECOVERY_INSTRUCTIONS.get(category, [])
        
        # Log the error
        logger.error(f"Error during {operation}: {error}")
        logger.error(f"Error category: {category.value}")
        
        if context:
            logger.error(f"Context: {context}")
        
        # Log recovery steps
        logger.info("=" * 80)
        logger.info("RECOVERY INSTRUCTIONS")
        logger.info("=" * 80)
        for step in recovery_steps:
            logger.info(step)
        logger.info("=" * 80)
        
        # Create enhanced error
        enhanced_error = DatabaseError(
            message=f"{operation} failed: {error}",
            category=category,
            recovery_steps=recovery_steps,
            original_error=error
        )
        
        return enhanced_error
    
    @classmethod
    def with_error_handling(cls, operation_name: str):
        """
        Decorator for automatic error handling.
        
        Args:
            operation_name: Name of the operation for logging
            
        Returns:
            Decorated function with error handling
        """
        def decorator(func: Callable):
            @wraps(func)
            def wrapper(*args, **kwargs):
                try:
                    return func(*args, **kwargs)
                except Exception as e:
                    enhanced_error = cls.handle_error(
                        error=e,
                        operation=operation_name,
                        context={
                            "function": func.__name__,
                            "args": str(args)[:100],  # Limit length
                            "kwargs": str(kwargs)[:100]
                        }
                    )
                    raise enhanced_error from e
            return wrapper
        return decorator


def retry_with_backoff(
    max_retries: int = 3,
    initial_delay: float = 1.0,
    backoff_factor: float = 2.0,
    exceptions: tuple = (Exception,)
):
    """
    Decorator for retrying operations with exponential backoff.
    
    Args:
        max_retries: Maximum number of retry attempts
        initial_delay: Initial delay in seconds
        backoff_factor: Multiplier for delay after each retry
        exceptions: Tuple of exceptions to catch and retry
        
    Returns:
        Decorated function with retry logic
    """
    def decorator(func: Callable):
        @wraps(func)
        def wrapper(*args, **kwargs):
            delay = initial_delay
            last_exception = None
            
            for attempt in range(max_retries + 1):
                try:
                    return func(*args, **kwargs)
                except exceptions as e:
                    last_exception = e
                    
                    if attempt < max_retries:
                        logger.warning(
                            f"Attempt {attempt + 1}/{max_retries} failed for {func.__name__}: {e}"
                        )
                        logger.info(f"Retrying in {delay} seconds...")
                        import time
                        time.sleep(delay)
                        delay *= backoff_factor
                    else:
                        logger.error(
                            f"All {max_retries} retry attempts failed for {func.__name__}"
                        )
            
            # All retries exhausted
            if last_exception:
                raise last_exception
                
        return wrapper
    return decorator

