# Library Utilities

Common utility functions used across the repository.

## JavaScript Utilities (`utils.js`)

Provides common utility functions for Node.js scripts:

### File Operations
- `readJsonFile(filepath, defaultValue)` - Safely read JSON files
- `writeJsonFile(filepath, data, indent)` - Safely write JSON files
- `readFile(filepath, encoding)` - Read text files with error handling
- `ensureDir(dirPath)` - Ensure directory exists
- `getFileStats(filepath)` - Get file statistics
- `isNonEmptyFile(filepath)` - Check if file exists and is not empty
- `formatFileSize(bytes)` - Format file size in human-readable format

### Performance Utilities
- `Timer` - Simple timer for performance measurement
- `SimpleCache` - In-memory cache with TTL support
- `BatchProcessor` - Batch processor for efficient bulk operations
- `retryOperation(operation, maxRetries, baseDelay)` - Retry failed operations with exponential backoff

### Usage Example

```javascript
const { readJsonFile, Timer, SimpleCache } = require('./lib/utils');

// Read JSON file
const data = readJsonFile('data.json', {});

// Time an operation
const timer = new Timer('Data Processing');
// ... do work ...
timer.end();

// Use cache
const cache = new SimpleCache(100, 60000); // 100 items, 60s TTL
cache.set('key', value);
const cached = cache.get('key');
```

## Python Utilities (`python_utils.py`)

Provides common utility functions for Python scripts:

### File Operations
- `read_json_file(filepath, default)` - Safely read JSON files
- `write_json_file(filepath, data, indent)` - Safely write JSON files
- `safe_read_file(filepath, encoding)` - Read text files with error handling
- `safe_write_file(filepath, content, encoding)` - Write text files with error handling
- `ensure_dir(dir_path)` - Ensure directory exists
- `get_file_stats(filepath)` - Get file statistics
- `is_non_empty_file(filepath)` - Check if file exists and is not empty
- `format_file_size(bytes_size)` - Format file size in human-readable format

### Performance Utilities
- `Timer` - Simple timer for performance measurement
- `SimpleCache` - In-memory cache with TTL support
- `BatchProcessor` - Batch processor for efficient bulk operations
- `retry_operation(operation, max_retries, base_delay)` - Retry failed operations
- `timing_decorator` - Decorator to measure function execution time

### Usage Example

```python
from lib.python_utils import read_json_file, Timer, SimpleCache, timing_decorator

# Read JSON file
data = read_json_file('data.json', {})

# Time an operation
timer = Timer('Data Processing')
# ... do work ...
timer.end()

# Use cache
cache = SimpleCache(max_size=100, ttl=60)  # 100 items, 60s TTL
cache.set('key', value)
cached = cache.get('key')

# Use timing decorator
@timing_decorator
def process_data():
    # ... do work ...
    pass
```

## Benefits

1. **DRY Principle** - Don't repeat yourself; consolidate common patterns
2. **Error Handling** - Consistent error handling across the codebase
3. **Performance** - Built-in caching and batch processing
4. **Maintainability** - Single place to update common functionality
5. **Testability** - Easier to test shared utilities

## Contributing

When adding new utility functions:
1. Add comprehensive docstrings
2. Include error handling
3. Add usage examples to this README
4. Consider both JavaScript and Python implementations
5. Write tests for new utilities
