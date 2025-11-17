"""
Common Python Utility Functions
Consolidated utility functions used across Python scripts
"""

import json
import os
import time
from pathlib import Path
from typing import Any, Optional, Dict, List, Callable
from functools import wraps
from datetime import datetime
import logging

# Configure logging
logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(name)s - %(levelname)s - %(message)s'
)
logger = logging.getLogger(__name__)


def read_json_file(filepath: str, default: Any = None) -> Any:
    """
    Safely read JSON file with error handling
    
    Args:
        filepath: Path to JSON file
        default: Default value if file doesn't exist or is invalid
        
    Returns:
        Parsed JSON or default value
    """
    try:
        if not os.path.exists(filepath):
            return default
        
        with open(filepath, 'r', encoding='utf-8') as f:
            return json.load(f)
    except (json.JSONDecodeError, IOError) as e:
        logger.error(f"Error reading JSON file {filepath}: {e}")
        return default


def write_json_file(filepath: str, data: Any, indent: int = 2) -> bool:
    """
    Safely write JSON file with error handling
    
    Args:
        filepath: Path to JSON file
        data: Data to write
        indent: JSON indentation (default: 2)
        
    Returns:
        Success status
    """
    try:
        # Ensure directory exists
        Path(filepath).parent.mkdir(parents=True, exist_ok=True)
        
        with open(filepath, 'w', encoding='utf-8') as f:
            json.dump(data, f, indent=indent, ensure_ascii=False)
        return True
    except (IOError, TypeError) as e:
        logger.error(f"Error writing JSON file {filepath}: {e}")
        return False


def ensure_dir(dir_path: str) -> None:
    """
    Ensure directory exists
    
    Args:
        dir_path: Directory path
    """
    Path(dir_path).mkdir(parents=True, exist_ok=True)


def format_file_size(bytes_size: int) -> str:
    """
    Format file size in human-readable format
    
    Args:
        bytes_size: Size in bytes
        
    Returns:
        Formatted size string
    """
    if bytes_size == 0:
        return '0 B'
    
    sizes = ['B', 'KB', 'MB', 'GB', 'TB']
    i = 0
    size = float(bytes_size)
    
    while size >= 1024 and i < len(sizes) - 1:
        size /= 1024
        i += 1
    
    return f"{size:.2f} {sizes[i]}"


def get_file_stats(filepath: str) -> Optional[Dict[str, Any]]:
    """
    Get file stats safely
    
    Args:
        filepath: Path to file
        
    Returns:
        Dictionary with file stats or None if error
    """
    try:
        stats = os.stat(filepath)
        return {
            'size': stats.st_size,
            'size_formatted': format_file_size(stats.st_size),
            'modified': datetime.fromtimestamp(stats.st_mtime).isoformat(),
            'created': datetime.fromtimestamp(stats.st_ctime).isoformat(),
            'is_file': os.path.isfile(filepath),
            'is_dir': os.path.isdir(filepath)
        }
    except (OSError, IOError) as e:
        logger.error(f"Error getting stats for {filepath}: {e}")
        return None


def is_non_empty_file(filepath: str) -> bool:
    """
    Check if file exists and is not empty
    
    Args:
        filepath: Path to file
        
    Returns:
        True if file exists and is not empty
    """
    try:
        return os.path.isfile(filepath) and os.path.getsize(filepath) > 0
    except (OSError, IOError):
        return False


class Timer:
    """Simple timer for performance measurement"""
    
    def __init__(self, label: str = 'Operation'):
        self.label = label
        self.start = time.time()
    
    def elapsed(self) -> float:
        """Get elapsed time in seconds"""
        return time.time() - self.start
    
    def elapsed_ms(self) -> float:
        """Get elapsed time in milliseconds"""
        return self.elapsed() * 1000
    
    def log(self, message: str = ''):
        """Log elapsed time"""
        elapsed = self.elapsed_ms()
        msg = f"⏱️  {self.label}"
        if message:
            msg += f" ({message})"
        msg += f": {elapsed:.2f}ms"
        logger.info(msg)
    
    def end(self) -> float:
        """End timer and log"""
        self.log('completed')
        return self.elapsed()


class SimpleCache:
    """Simple cache implementation with TTL"""
    
    def __init__(self, max_size: int = 100, ttl: int = 3600):
        self.cache: Dict[str, Dict[str, Any]] = {}
        self.max_size = max_size
        self.ttl = ttl  # Time to live in seconds
    
    def set(self, key: str, value: Any) -> None:
        """Set cache value"""
        # Remove oldest if at capacity
        if len(self.cache) >= self.max_size:
            oldest_key = next(iter(self.cache))
            del self.cache[oldest_key]
        
        self.cache[key] = {
            'value': value,
            'timestamp': time.time()
        }
    
    def get(self, key: str) -> Optional[Any]:
        """Get cache value"""
        if key not in self.cache:
            return None
        
        entry = self.cache[key]
        
        # Check if expired
        if time.time() - entry['timestamp'] > self.ttl:
            del self.cache[key]
            return None
        
        return entry['value']
    
    def clear(self) -> None:
        """Clear cache"""
        self.cache.clear()
    
    def size(self) -> int:
        """Get cache size"""
        return len(self.cache)


class BatchProcessor:
    """Batch processor for efficient bulk operations"""
    
    def __init__(self, batch_size: int = 100, process_fn: Callable = None, 
                 log_progress: bool = True):
        self.batch_size = batch_size
        self.process_fn = process_fn
        self.log_progress = log_progress
    
    def process(self, items: List[Any]) -> List[Any]:
        """Process items in batches"""
        results = []
        total = len(items)
        
        for i in range(0, total, self.batch_size):
            batch = items[i:min(i + self.batch_size, total)]
            
            if self.log_progress:
                batch_num = (i // self.batch_size) + 1
                total_batches = (total + self.batch_size - 1) // self.batch_size
                logger.info(f"Processing batch {batch_num}/{total_batches}...")
            
            batch_results = self.process_fn(batch)
            results.extend(batch_results)
        
        return results


def retry_operation(operation: Callable, max_retries: int = 3, 
                   base_delay: float = 1.0) -> Any:
    """
    Retry failed operations with exponential backoff
    
    Args:
        operation: Function to execute
        max_retries: Maximum number of retries
        base_delay: Base delay in seconds
        
    Returns:
        Result of operation
        
    Raises:
        Last exception if all retries fail
    """
    for attempt in range(1, max_retries + 1):
        try:
            return operation()
        except Exception as e:
            if attempt == max_retries:
                raise
            
            delay = base_delay * (2 ** (attempt - 1))
            logger.warning(f"Attempt {attempt} failed, retrying in {delay}s...")
            time.sleep(delay)


def timing_decorator(func: Callable) -> Callable:
    """Decorator to measure function execution time"""
    @wraps(func)
    def wrapper(*args, **kwargs):
        timer = Timer(func.__name__)
        result = func(*args, **kwargs)
        timer.end()
        return result
    return wrapper


def safe_read_file(filepath: str, encoding: str = 'utf-8') -> Optional[str]:
    """
    Read file with encoding fallback
    
    Args:
        filepath: Path to file
        encoding: Encoding to use
        
    Returns:
        File content or None
    """
    try:
        with open(filepath, 'r', encoding=encoding) as f:
            return f.read()
    except (IOError, UnicodeDecodeError) as e:
        logger.error(f"Error reading file {filepath}: {e}")
        return None


def safe_write_file(filepath: str, content: str, encoding: str = 'utf-8') -> bool:
    """
    Write file with error handling
    
    Args:
        filepath: Path to file
        content: Content to write
        encoding: Encoding to use
        
    Returns:
        Success status
    """
    try:
        # Ensure directory exists
        Path(filepath).parent.mkdir(parents=True, exist_ok=True)
        
        with open(filepath, 'w', encoding=encoding) as f:
            f.write(content)
        return True
    except IOError as e:
        logger.error(f"Error writing file {filepath}: {e}")
        return False
