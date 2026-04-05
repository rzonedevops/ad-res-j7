# Quick Start: Repository Optimization Guide

## 🚀 Fast Track for Developers

This guide shows you how to use the new optimization utilities immediately.

## Using JavaScript Utilities

### File Operations

```javascript
const { readJsonFile, writeJsonFile } = require('./lib/utils');

// Read JSON safely (returns default if error)
const data = readJsonFile('data.json', {});

// Write JSON safely
writeJsonFile('output.json', data);
```

### Performance Timing

```javascript
const { Timer } = require('./lib/utils');

const timer = new Timer('MyOperation');
// ... do work ...
timer.end(); // Logs: "⏱️  MyOperation (completed): 123ms"
```

### Caching

```javascript
const { SimpleCache } = require('./lib/utils');

const cache = new SimpleCache(100, 300000); // 100 items, 5 min TTL

// Set value
cache.set('key', expensiveData);

// Get value (returns null if expired/missing)
const cached = cache.get('key');
```

### Batch Processing

```javascript
const { BatchProcessor } = require('./lib/utils');

const processor = new BatchProcessor(100, async (batch) => {
  return batch.map(item => processItem(item));
});

const results = await processor.process(allItems);
```

## Using Python Utilities

### File Operations

```python
from lib.python_utils import read_json_file, write_json_file

# Read JSON safely
data = read_json_file('data.json', {})

# Write JSON safely
write_json_file('output.json', data)
```

### Performance Timing

```python
from lib.python_utils import Timer, timing_decorator

# Manual timing
timer = Timer('MyOperation')
# ... do work ...
timer.end()

# Or use decorator
@timing_decorator
def my_function():
    # ... do work ...
    pass
```

### Caching

```python
from lib.python_utils import SimpleCache

cache = SimpleCache(max_size=100, ttl=300)  # 100 items, 5 min

# Set value
cache.set('key', expensive_data)

# Get value (returns None if expired/missing)
cached = cache.get('key')
```

## Using Database Utilities

### Query Execution with Caching

```javascript
const { executeQuery, getTableStats } = require('./db/db-utils');

// Execute query with timing
const users = await executeQuery('GetUsers', async () => {
  return await db.select().from(usersTable);
}, true); // enable caching

// Get table statistics
const stats = await getTableStats('case_documents');
console.log(`${stats.table}: ${stats.count} rows, ${stats.size}`);
```

### Schema Validation

```javascript
const { validateSchema } = require('./db/db-utils');

const requiredTables = ['case_documents', 'evidence_records', 'issues'];
const validation = await validateSchema(requiredTables);

if (validation.valid) {
  console.log('✅ All required tables exist');
} else {
  console.log('❌ Missing tables:', validation.missingTables);
}
```

## Running Optimized Scripts

### Evidence Validation

```bash
# JavaScript version (slower, ~104s)
node scripts/validate-evidence-completeness-optimized.js

# Python version (faster, ~0.4s) ⚡
python3 scripts/validate_evidence_completeness_optimized.py
```

### Database Connection Test

```bash
# Original
npm run db:test

# Optimized (with feature detection)
node db/test-connection-optimized.js
```

### Cleanup Analysis

```bash
# Analyze repository for optimization opportunities
node scripts/analyze-cleanup-opportunities.js
```

## Performance Best Practices

### 1. Always Use Caching for Repeated Operations

```javascript
// ❌ Bad: No caching
for (let i = 0; i < 100; i++) {
  const data = await fetchExpensiveData(id);
}

// ✅ Good: Cache expensive operations
const cache = new SimpleCache();
for (let i = 0; i < 100; i++) {
  let data = cache.get(id);
  if (!data) {
    data = await fetchExpensiveData(id);
    cache.set(id, data);
  }
}
```

### 2. Use Timers for Performance Tracking

```javascript
// ✅ Always time expensive operations
const timer = new Timer('DatabaseQuery');
const results = await runExpensiveQuery();
timer.end(); // Logs execution time
```

### 3. Batch Process Large Datasets

```javascript
// ❌ Bad: Process one at a time
for (const item of items) {
  await processItem(item);
}

// ✅ Good: Batch process
const processor = new BatchProcessor(100, async (batch) => {
  return await Promise.all(batch.map(processItem));
});
await processor.process(items);
```

### 4. Handle Errors Gracefully

```javascript
// ✅ Use safe file operations
const data = readJsonFile('config.json', {
  fallback: 'default value'
});
```

## Migration Guide

### Migrating Existing Scripts

1. **Replace manual JSON operations:**

```javascript
// Before
try {
  const content = fs.readFileSync('data.json', 'utf8');
  const data = JSON.parse(content);
} catch (error) {
  console.error('Error:', error);
  const data = {};
}

// After
const { readJsonFile } = require('./lib/utils');
const data = readJsonFile('data.json', {});
```

2. **Add performance tracking:**

```javascript
// Before
const start = Date.now();
// ... do work ...
console.log(`Time: ${Date.now() - start}ms`);

// After
const { Timer } = require('./lib/utils');
const timer = new Timer('Operation');
// ... do work ...
timer.end();
```

3. **Add caching:**

```javascript
// Before
const results = await expensiveOperation();

// After
const { SimpleCache } = require('./lib/utils');
const cache = new SimpleCache();

let results = cache.get('key');
if (!results) {
  results = await expensiveOperation();
  cache.set('key', results);
}
```

## Testing Your Changes

### Run Tests

```bash
# Run all tests
npm test

# Run specific validation
npm run validate-evidence-completeness
```

### Check Performance

```bash
# Compare before/after with timing
node scripts/your-script.js  # Shows timing now!
```

## Common Patterns

### Pattern: File Processing with Error Handling

```javascript
const { readFile, writeFile, Timer } = require('./lib/utils');

async function processFiles(filePaths) {
  const timer = new Timer('File Processing');
  
  for (const path of filePaths) {
    const content = readFile(path);
    if (!content) continue; // Skip errors
    
    const processed = processContent(content);
    writeFile(path + '.processed', processed);
  }
  
  timer.end();
}
```

### Pattern: Database Query with Caching

```javascript
const { executeQuery } = require('./db/db-utils');

async function getUsers() {
  return await executeQuery('GetAllUsers', async () => {
    return await db.select().from(users);
  }, true); // Enable 5-minute cache
}
```

### Pattern: Batch Processing with Progress

```javascript
const { BatchProcessor } = require('./lib/utils');

const processor = new BatchProcessor(100, async (batch) => {
  // Process batch
  return batch.map(item => processItem(item));
}, { logProgress: true }); // Logs batch progress

const results = await processor.process(allItems);
```

## Need Help?

- **Documentation**: See `lib/README.md` for detailed API docs
- **Examples**: Check `OPTIMIZATION_SUMMARY.md` for more examples
- **Issues**: File an issue if you encounter problems

## Quick Reference Table

| Task | Old Way | New Way | Performance |
|------|---------|---------|-------------|
| Read JSON | `JSON.parse(fs.readFileSync(...))` | `readJsonFile(...)` | Same, safer |
| Time operation | `Date.now()` tracking | `Timer` class | Better logging |
| Cache data | Manual Map | `SimpleCache` | TTL + size limit |
| Batch process | Manual loop | `BatchProcessor` | Progress + logging |
| Database query | Direct query | `executeQuery` | Timing + caching |

---

**Ready to optimize? Start using these utilities in your scripts today!** 🚀
