#!/usr/bin/env node
/**
 * Optimized Database Connection Test
 * Tests database connectivity and displays table statistics
 */

const { 
  testConnection, 
  getAllTableStats, 
  validateSchema,
  closeConnection,
  getCacheStats
} = require('./db-utils');
const { Timer } = require('../lib/utils');

// Core tables that should exist
const CORE_TABLES = [
  'case_documents',
  'evidence_records',
  'issues'
];

// Optional feature tables
const OPTIONAL_TABLES = [
  // Hypergraph tables
  'hypergraph_nodes',
  'hypergraph_edges',
  'hypergraph_relations',
  'hypergraph_patterns',
  
  // Lex inference tables
  'agents',
  'arenas',
  'events',
  'event_horizons',
  'configurations',
  'inference_rules',
  'guilt_assignments',
  'possibility_spaces',
  'deltas',
  'causation_chains',
  
  // Hierarchical issues tables
  'legal_arguments',
  'feature_issues',
  'paragraphs',
  'task_issues',
  'cross_references',
  
  // Grip optimization tables
  'grip_measurements',
  'attention_patterns',
  'evidence_gaps'
];

async function main() {
  const timer = new Timer('Database Connection Test');
  
  console.log('='.repeat(80));
  console.log('DATABASE CONNECTION TEST');
  console.log('='.repeat(80));
  console.log();
  
  // Test basic connection
  console.log('📡 Testing database connection...');
  const connected = await testConnection();
  
  if (!connected) {
    console.error('  ❌ Database connection failed!');
    console.error('  Check your DATABASE_URL in .env file');
    process.exit(1);
  }
  
  console.log('  ✅ Database connection successful!');
  console.log();
  
  // Validate core schema
  console.log('📋 Validating core schema...');
  const coreValidation = await validateSchema(CORE_TABLES);
  
  if (coreValidation.valid) {
    console.log(`  ✅ All ${CORE_TABLES.length} core tables exist`);
  } else {
    console.log(`  ⚠️  Missing core tables: ${coreValidation.missingTables.join(', ')}`);
    console.log('  Run: npm run db:migrate');
  }
  console.log();
  
  // Check optional tables
  console.log('🔍 Checking optional feature tables...');
  const optionalValidation = await validateSchema(OPTIONAL_TABLES);
  const featureStats = {
    hypergraph: optionalValidation.existingTables.filter(t => t.startsWith('hypergraph_')).length,
    lex: optionalValidation.existingTables.filter(t => 
      ['agents', 'arenas', 'events', 'configurations'].includes(t)
    ).length,
    hierarchical: optionalValidation.existingTables.filter(t => 
      ['legal_arguments', 'feature_issues', 'paragraphs', 'task_issues'].includes(t)
    ).length,
    grip: optionalValidation.existingTables.filter(t => t.includes('grip') || t.includes('attention')).length
  };
  
  console.log('  Feature availability:');
  console.log(`    Hypergraph: ${featureStats.hypergraph}/4 tables ${featureStats.hypergraph === 4 ? '✅' : '⚠️'}`);
  console.log(`    Lex Inference: ${featureStats.lex}/4 tables ${featureStats.lex === 4 ? '✅' : '⚠️'}`);
  console.log(`    Hierarchical Issues: ${featureStats.hierarchical}/4 tables ${featureStats.hierarchical === 4 ? '✅' : '⚠️'}`);
  console.log(`    Grip Optimization: ${featureStats.grip}/3 tables ${featureStats.grip === 3 ? '✅' : '⚠️'}`);
  console.log();
  
  if (optionalValidation.missingTables.length > 0) {
    console.log('  💡 To enable missing features, run:');
    if (featureStats.hypergraph < 4) console.log('     npm run db:hypergraph:setup');
    if (featureStats.lex < 4) console.log('     npm run db:lex:setup');
    if (featureStats.hierarchical < 4) console.log('     npm run db:hierarchy:setup');
    if (featureStats.grip < 3) console.log('     npm run db:grip:setup');
    console.log();
  }
  
  // Get statistics for existing tables
  console.log('📊 Table Statistics:');
  console.log('-'.repeat(80));
  
  const existingTables = [
    ...coreValidation.existingTables,
    ...optionalValidation.existingTables
  ];
  
  const stats = await getAllTableStats(existingTables);
  
  // Group by feature
  const coreStats = stats.filter(s => CORE_TABLES.includes(s.table));
  const hypergraphStats = stats.filter(s => s.table.startsWith('hypergraph_'));
  const lexStats = stats.filter(s => 
    ['agents', 'arenas', 'events', 'configurations', 'inference_rules', 
     'guilt_assignments', 'possibility_spaces', 'deltas', 'causation_chains'].includes(s.table)
  );
  const hierarchicalStats = stats.filter(s => 
    ['legal_arguments', 'feature_issues', 'paragraphs', 'task_issues', 'cross_references'].includes(s.table)
  );
  const gripStats = stats.filter(s => 
    ['grip_measurements', 'attention_patterns', 'evidence_gaps'].includes(s.table)
  );
  
  // Display core tables
  if (coreStats.length > 0) {
    console.log('\n  Core Tables:');
    for (const stat of coreStats) {
      console.log(`    ${stat.table.padEnd(30)} ${String(stat.count).padStart(8)} rows  ${stat.size}`);
    }
  }
  
  // Display feature tables
  if (hypergraphStats.length > 0) {
    console.log('\n  Hypergraph Tables:');
    for (const stat of hypergraphStats) {
      console.log(`    ${stat.table.padEnd(30)} ${String(stat.count).padStart(8)} rows  ${stat.size}`);
    }
  }
  
  if (lexStats.length > 0) {
    console.log('\n  Lex Inference Tables:');
    for (const stat of lexStats) {
      console.log(`    ${stat.table.padEnd(30)} ${String(stat.count).padStart(8)} rows  ${stat.size}`);
    }
  }
  
  if (hierarchicalStats.length > 0) {
    console.log('\n  Hierarchical Issues Tables:');
    for (const stat of hierarchicalStats) {
      console.log(`    ${stat.table.padEnd(30)} ${String(stat.count).padStart(8)} rows  ${stat.size}`);
    }
  }
  
  if (gripStats.length > 0) {
    console.log('\n  Grip Optimization Tables:');
    for (const stat of gripStats) {
      console.log(`    ${stat.table.padEnd(30)} ${String(stat.count).padStart(8)} rows  ${stat.size}`);
    }
  }
  
  // Display cache stats
  console.log('\n⚡ Performance:');
  const cacheStats = getCacheStats();
  console.log(`  Cache: ${cacheStats.size}/${cacheStats.maxSize} entries, TTL: ${cacheStats.ttl/1000}s`);
  
  // Summary
  console.log();
  console.log('='.repeat(80));
  console.log('SUMMARY');
  console.log('='.repeat(80));
  console.log(`  Core Tables: ${coreStats.length}/${CORE_TABLES.length}`);
  console.log(`  Optional Tables: ${optionalValidation.existingTables.length}/${OPTIONAL_TABLES.length}`);
  console.log(`  Total Tables: ${existingTables.length}`);
  
  const totalRows = stats.reduce((sum, s) => sum + s.count, 0);
  console.log(`  Total Records: ${totalRows.toLocaleString()}`);
  
  timer.end();
  console.log('='.repeat(80));
  
  // Close connection
  await closeConnection();
  
  // Exit with appropriate code
  process.exit(coreValidation.valid ? 0 : 1);
}

// Run the test
if (require.main === module) {
  main().catch(error => {
    console.error('❌ Test failed:', error);
    process.exit(1);
  });
}

module.exports = { main };
