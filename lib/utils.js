/**
 * Common Utility Functions
 * Consolidated utility functions used across the repository
 */

const fs = require('fs');
const path = require('path');

/**
 * Safely read JSON file with error handling
 * @param {string} filepath - Path to JSON file
 * @param {any} defaultValue - Default value if file doesn't exist or is invalid
 * @returns {any} Parsed JSON or default value
 */
function readJsonFile(filepath, defaultValue = null) {
  try {
    if (!fs.existsSync(filepath)) {
      return defaultValue;
    }
    const content = fs.readFileSync(filepath, 'utf8');
    return JSON.parse(content);
  } catch (error) {
    console.error(`Error reading JSON file ${filepath}:`, error.message);
    return defaultValue;
  }
}

/**
 * Safely write JSON file with error handling
 * @param {string} filepath - Path to JSON file
 * @param {any} data - Data to write
 * @param {number} indent - JSON indentation (default: 2)
 * @returns {boolean} Success status
 */
function writeJsonFile(filepath, data, indent = 2) {
  try {
    const dir = path.dirname(filepath);
    if (!fs.existsSync(dir)) {
      fs.mkdirSync(dir, { recursive: true });
    }
    fs.writeFileSync(filepath, JSON.stringify(data, null, indent), 'utf8');
    return true;
  } catch (error) {
    console.error(`Error writing JSON file ${filepath}:`, error.message);
    return false;
  }
}

/**
 * Ensure directory exists
 * @param {string} dirPath - Directory path
 */
function ensureDir(dirPath) {
  if (!fs.existsSync(dirPath)) {
    fs.mkdirSync(dirPath, { recursive: true });
  }
}

/**
 * Format file size in human-readable format
 * @param {number} bytes - Size in bytes
 * @returns {string} Formatted size
 */
function formatFileSize(bytes) {
  if (bytes === 0) return '0 B';
  const k = 1024;
  const sizes = ['B', 'KB', 'MB', 'GB', 'TB'];
  const i = Math.floor(Math.log(bytes) / Math.log(k));
  return parseFloat((bytes / Math.pow(k, i)).toFixed(2)) + ' ' + sizes[i];
}

/**
 * Get file stats safely
 * @param {string} filepath - Path to file
 * @returns {object|null} File stats or null if error
 */
function getFileStats(filepath) {
  try {
    return fs.statSync(filepath);
  } catch (error) {
    return null;
  }
}

/**
 * Check if file exists and is not empty
 * @param {string} filepath - Path to file
 * @returns {boolean} True if file exists and is not empty
 */
function isNonEmptyFile(filepath) {
  try {
    const stats = fs.statSync(filepath);
    return stats.isFile() && stats.size > 0;
  } catch (error) {
    return false;
  }
}

/**
 * Read file with encoding fallback
 * @param {string} filepath - Path to file
 * @param {string} encoding - Encoding (default: 'utf8')
 * @returns {string|null} File content or null
 */
function readFile(filepath, encoding = 'utf8') {
  try {
    return fs.readFileSync(filepath, encoding);
  } catch (error) {
    console.error(`Error reading file ${filepath}:`, error.message);
    return null;
  }
}

/**
 * Simple timer for performance measurement
 */
class Timer {
  constructor(label = 'Operation') {
    this.label = label;
    this.start = Date.now();
  }

  elapsed() {
    return Date.now() - this.start;
  }

  log(message = '') {
    const elapsed = this.elapsed();
    console.log(`⏱️  ${this.label} ${message ? `(${message})` : ''}: ${elapsed}ms`);
  }

  end() {
    this.log('completed');
    return this.elapsed();
  }
}

/**
 * Simple cache implementation
 */
class SimpleCache {
  constructor(maxSize = 100, ttl = 3600000) {
    this.cache = new Map();
    this.maxSize = maxSize;
    this.ttl = ttl; // Time to live in ms
  }

  set(key, value) {
    // Remove oldest if at capacity
    if (this.cache.size >= this.maxSize) {
      const firstKey = this.cache.keys().next().value;
      this.cache.delete(firstKey);
    }
    
    this.cache.set(key, {
      value,
      timestamp: Date.now()
    });
  }

  get(key) {
    const entry = this.cache.get(key);
    if (!entry) return null;
    
    // Check if expired
    if (Date.now() - entry.timestamp > this.ttl) {
      this.cache.delete(key);
      return null;
    }
    
    return entry.value;
  }

  clear() {
    this.cache.clear();
  }

  size() {
    return this.cache.size;
  }
}

/**
 * Batch processor for efficient bulk operations
 */
class BatchProcessor {
  constructor(batchSize = 100, processFn, options = {}) {
    this.batchSize = batchSize;
    this.processFn = processFn;
    this.options = {
      logProgress: true,
      ...options
    };
  }

  async process(items) {
    const results = [];
    const total = items.length;
    
    for (let i = 0; i < total; i += this.batchSize) {
      const batch = items.slice(i, Math.min(i + this.batchSize, total));
      
      if (this.options.logProgress) {
        console.log(`Processing batch ${Math.floor(i / this.batchSize) + 1}/${Math.ceil(total / this.batchSize)}...`);
      }
      
      const batchResults = await this.processFn(batch);
      results.push(...batchResults);
    }
    
    return results;
  }
}

/**
 * Retry failed operations with exponential backoff
 */
async function retryOperation(operation, maxRetries = 3, baseDelay = 1000) {
  for (let attempt = 1; attempt <= maxRetries; attempt++) {
    try {
      return await operation();
    } catch (error) {
      if (attempt === maxRetries) {
        throw error;
      }
      
      const delay = baseDelay * Math.pow(2, attempt - 1);
      console.log(`Attempt ${attempt} failed, retrying in ${delay}ms...`);
      await new Promise(resolve => setTimeout(resolve, delay));
    }
  }
}

module.exports = {
  readJsonFile,
  writeJsonFile,
  ensureDir,
  formatFileSize,
  getFileStats,
  isNonEmptyFile,
  readFile,
  Timer,
  SimpleCache,
  BatchProcessor,
  retryOperation
};
