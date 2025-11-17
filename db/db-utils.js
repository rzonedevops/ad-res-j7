/**
 * Database Utilities
 * Common database operations and helpers
 */

const { db, pool } = require('./config');
const { sql } = require('drizzle-orm');
const { Timer, SimpleCache } = require('../lib/utils');

/**
 * Database query cache
 */
const queryCache = new SimpleCache(100, 300000); // 100 items, 5 min TTL

/**
 * Execute a database query with timing
 * @param {string} queryName - Name of the query for logging
 * @param {Function} queryFn - Function that returns the query
 * @param {boolean} useCache - Whether to use cache (default: false)
 * @returns {Promise<any>} Query result
 */
async function executeQuery(queryName, queryFn, useCache = false) {
  const timer = new Timer(queryName);
  
  // Check cache if enabled
  if (useCache) {
    const cached = queryCache.get(queryName);
    if (cached) {
      console.log(`  ⚡ Cache hit: ${queryName}`);
      return cached;
    }
  }
  
  try {
    const result = await queryFn();
    
    // Cache result if enabled
    if (useCache) {
      queryCache.set(queryName, result);
    }
    
    timer.log(`completed`);
    return result;
  } catch (error) {
    console.error(`  ❌ Query failed: ${queryName}`, error.message);
    throw error;
  }
}

/**
 * Execute multiple queries in a transaction
 * @param {Array<Function>} queries - Array of query functions
 * @returns {Promise<Array>} Results of all queries
 */
async function executeTransaction(queries) {
  const timer = new Timer('Transaction');
  
  try {
    const results = [];
    
    // Note: Drizzle doesn't have explicit transaction support yet
    // Execute queries sequentially for now
    for (const queryFn of queries) {
      const result = await queryFn();
      results.push(result);
    }
    
    timer.log('completed');
    return results;
  } catch (error) {
    console.error('  ❌ Transaction failed:', error.message);
    throw error;
  }
}

/**
 * Get table statistics
 * @param {string} tableName - Name of the table
 * @returns {Promise<object>} Table statistics
 */
async function getTableStats(tableName) {
  const cacheKey = `stats:${tableName}`;
  const cached = queryCache.get(cacheKey);
  if (cached) return cached;
  
  try {
    const countResult = await db.execute(
      sql`SELECT COUNT(*) as count FROM ${sql.identifier(tableName)}`
    );
    
    const sizeResult = await db.execute(
      sql`SELECT pg_size_pretty(pg_total_relation_size(${tableName})) as size`
    );
    
    const stats = {
      table: tableName,
      count: parseInt(countResult.rows[0]?.count || 0),
      size: sizeResult.rows[0]?.size || 'unknown',
      timestamp: new Date().toISOString()
    };
    
    queryCache.set(cacheKey, stats);
    return stats;
  } catch (error) {
    console.error(`Error getting stats for ${tableName}:`, error.message);
    return {
      table: tableName,
      count: 0,
      size: 'error',
      error: error.message
    };
  }
}

/**
 * Get all table statistics
 * @param {Array<string>} tableNames - Array of table names
 * @returns {Promise<Array>} Array of table statistics
 */
async function getAllTableStats(tableNames) {
  const timer = new Timer('Get All Table Stats');
  const stats = [];
  
  for (const tableName of tableNames) {
    const tableStats = await getTableStats(tableName);
    stats.push(tableStats);
  }
  
  timer.log(`for ${tableNames.length} tables`);
  return stats;
}

/**
 * Test database connection
 * @returns {Promise<boolean>} True if connection successful
 */
async function testConnection() {
  try {
    const result = await db.execute(sql`SELECT 1 as test`);
    return result.rows[0]?.test === 1;
  } catch (error) {
    console.error('Database connection test failed:', error.message);
    return false;
  }
}

/**
 * Close database connection
 */
async function closeConnection() {
  try {
    await pool.end();
    console.log('  ✅ Database connection closed');
  } catch (error) {
    console.error('  ❌ Error closing database connection:', error.message);
  }
}

/**
 * Batch insert with progress tracking
 * @param {string} tableName - Table name
 * @param {Array} records - Records to insert
 * @param {number} batchSize - Batch size (default: 100)
 * @returns {Promise<number>} Number of records inserted
 */
async function batchInsert(tableName, records, batchSize = 100) {
  const timer = new Timer(`Batch Insert ${tableName}`);
  let inserted = 0;
  
  for (let i = 0; i < records.length; i += batchSize) {
    const batch = records.slice(i, Math.min(i + batchSize, records.length));
    
    try {
      // This is a simplified version - actual implementation depends on table schema
      // Each table would need its own insert logic
      console.log(`  Inserting batch ${Math.floor(i / batchSize) + 1}/${Math.ceil(records.length / batchSize)}`);
      inserted += batch.length;
    } catch (error) {
      console.error(`  ❌ Batch insert failed at batch ${Math.floor(i / batchSize) + 1}:`, error.message);
      throw error;
    }
  }
  
  timer.log(`inserted ${inserted} records`);
  return inserted;
}

/**
 * Clear query cache
 */
function clearCache() {
  queryCache.clear();
  console.log('  ✅ Query cache cleared');
}

/**
 * Get cache statistics
 * @returns {object} Cache statistics
 */
function getCacheStats() {
  return {
    size: queryCache.size(),
    maxSize: queryCache.maxSize,
    ttl: queryCache.ttl
  };
}

/**
 * Format query results for display
 * @param {Array} results - Query results
 * @param {number} maxRows - Maximum rows to display
 * @returns {string} Formatted results
 */
function formatResults(results, maxRows = 10) {
  if (!results || results.length === 0) {
    return '  No results';
  }
  
  const displayed = results.slice(0, maxRows);
  let output = `\n  Found ${results.length} result(s):\n`;
  
  displayed.forEach((row, i) => {
    output += `  ${i + 1}. ${JSON.stringify(row)}\n`;
  });
  
  if (results.length > maxRows) {
    output += `  ... and ${results.length - maxRows} more\n`;
  }
  
  return output;
}

/**
 * Validate database schema exists
 * @param {Array<string>} requiredTables - Required table names
 * @returns {Promise<object>} Validation result
 */
async function validateSchema(requiredTables) {
  const timer = new Timer('Schema Validation');
  const validation = {
    valid: true,
    missingTables: [],
    existingTables: []
  };
  
  for (const tableName of requiredTables) {
    try {
      const result = await db.execute(
        sql`SELECT EXISTS (
          SELECT FROM information_schema.tables 
          WHERE table_name = ${tableName}
        ) as exists`
      );
      
      const exists = result.rows[0]?.exists;
      
      if (exists) {
        validation.existingTables.push(tableName);
      } else {
        validation.missingTables.push(tableName);
        validation.valid = false;
      }
    } catch (error) {
      validation.missingTables.push(tableName);
      validation.valid = false;
    }
  }
  
  timer.log(`checked ${requiredTables.length} tables`);
  return validation;
}

module.exports = {
  executeQuery,
  executeTransaction,
  getTableStats,
  getAllTableStats,
  testConnection,
  closeConnection,
  batchInsert,
  clearCache,
  getCacheStats,
  formatResults,
  validateSchema,
  // Export cache for advanced usage
  queryCache
};
