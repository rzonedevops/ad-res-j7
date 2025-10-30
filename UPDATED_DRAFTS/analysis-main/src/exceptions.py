"""
Custom Exceptions

This module defines custom exception classes for the analysis system,
providing structured error handling and better error messages.
"""


class AnalysisException(Exception):
    """Base exception for all analysis system errors."""

    def __init__(self, message: str, details: dict = None):
        super().__init__(message)
        self.message = message
        self.details = details or {}

    def __str__(self):
        if self.details:
            details_str = ", ".join(f"{k}={v}" for k, v in self.details.items())
            return f"{self.message} ({details_str})"
        return self.message


class DatabaseError(AnalysisException):
    """Base exception for database-related errors."""



class DatabaseConnectionError(DatabaseError):
    """Exception raised when database connection fails."""



class DatabaseSyncError(DatabaseError):
    """Exception raised when database synchronization fails."""



class DatabaseSchemaError(DatabaseError):
    """Exception raised when database schema validation fails."""



class DatabaseQueryError(DatabaseError):
    """Exception raised when database query execution fails."""



class ConfigurationError(AnalysisException):
    """Exception raised for configuration-related errors."""



class ValidationError(AnalysisException):
    """Exception raised when data validation fails."""



class EvidenceError(AnalysisException):
    """Base exception for evidence-related errors."""



class EvidenceValidationError(EvidenceError):
    """Exception raised when evidence validation fails."""



class ChainOfCustodyError(EvidenceError):
    """Exception raised when chain of custody is broken."""



class TimelineError(AnalysisException):
    """Base exception for timeline-related errors."""



class TimelineValidationError(TimelineError):
    """Exception raised when timeline validation fails."""



class TimelineConflictError(TimelineError):
    """Exception raised when timeline conflicts are detected."""



class APIError(AnalysisException):
    """Base exception for API-related errors."""



class APIRateLimitError(APIError):
    """Exception raised when API rate limit is exceeded."""



class APIAuthenticationError(APIError):
    """Exception raised when API authentication fails."""



class ModelError(AnalysisException):
    """Base exception for model-related errors."""



class ModelLoadError(ModelError):
    """Exception raised when model loading fails."""



class ModelInferenceError(ModelError):
    """Exception raised when model inference fails."""



class RetryableError(AnalysisException):
    """
    Exception that indicates the operation can be retried.
    Used for transient errors that may succeed on retry.
    """

    def __init__(self, message: str, details: dict = None, max_retries: int = 3):
        super().__init__(message, details)
        self.max_retries = max_retries
