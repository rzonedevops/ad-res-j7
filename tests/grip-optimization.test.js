/**
 * Grip Optimization System Tests
 * 
 * Validates grip metrics tracking, optimization workflows, and database integration.
 */

const GripManager = require('../db/grip-manager');
const { Pool } = require('pg');
const config = require('../db/config');

// Test configuration
const TEST_CASE_ID = 'test_case_grip_' + Date.now();

async function testGripOptimizationSystem() {
  console.log('🧬 Testing Grip Optimization System\n');
  console.log('='.repeat(70));
  
  let manager;
  let pool;
  let testsPassed = 0;
  let testsFailed = 0;
  
  try {
    // Setup
    console.log('\n📋 Setup: Initializing database connection...');
    manager = new GripManager();
    pool = new Pool({ connectionString: config.databaseUrl });
    console.log('✅ Connected to database\n');
    
    // Test 1: Record grip assessment
    console.log('🧪 Test 1: Record grip assessment');
    try {
      const assessment = await manager.recordAssessment({
        assessment_id: `test_assessment_${Date.now()}`,
        generation: 1,
        completeness: 0.85,
        invariance_rate: 0.45,
        evidence_integration: 0.72,
        rule_coverage: 0.68,
        coherence: 0.75,
        explanatory_power: 0.80,
        stability: 0.95,
        efficiency: 0.70,
        fitness: 0.73,
        case_id: TEST_CASE_ID,
        configuration_count: 48,
        evidence_count: 150,
        rule_count: 60,
        notes: 'Test assessment'
      });
      
      if (assessment && assessment.assessment_id && assessment.fitness === 0.73) {
        console.log('✅ Test 1 PASSED: Assessment recorded successfully');
        console.log(`   Assessment ID: ${assessment.assessment_id}`);
        console.log(`   Fitness: ${(assessment.fitness * 100).toFixed(1)}%`);
        testsPassed++;
      } else {
        throw new Error('Assessment validation failed');
      }
    } catch (error) {
      console.log('❌ Test 1 FAILED:', error.message);
      testsFailed++;
    }
    
    // Test 2: Retrieve latest assessment
    console.log('\n🧪 Test 2: Retrieve latest assessment');
    try {
      const latest = await manager.getLatestAssessment(TEST_CASE_ID);
      
      if (latest && latest.case_id === TEST_CASE_ID && latest.fitness > 0) {
        console.log('✅ Test 2 PASSED: Latest assessment retrieved');
        console.log(`   Generation: ${latest.generation}`);
        console.log(`   Fitness: ${(latest.fitness * 100).toFixed(1)}%`);
        testsPassed++;
      } else {
        throw new Error('Latest assessment not found or invalid');
      }
    } catch (error) {
      console.log('❌ Test 2 FAILED:', error.message);
      testsFailed++;
    }
    
    // Test 3: Identify evidence gaps
    console.log('\n🧪 Test 3: Identify evidence gaps');
    try {
      const latest = await manager.getLatestAssessment(TEST_CASE_ID);
      const gaps = await manager.identifyEvidenceGaps(latest.assessment_id);
      
      if (Array.isArray(gaps) && gaps.length > 0) {
        console.log(`✅ Test 3 PASSED: Identified ${gaps.length} evidence gaps`);
        gaps.forEach(gap => {
          console.log(`   - ${gap.gap_type}: Priority ${(gap.priority_score * 100).toFixed(1)}%`);
        });
        testsPassed++;
      } else {
        throw new Error('No gaps identified (expected some based on metrics)');
      }
    } catch (error) {
      console.log('❌ Test 3 FAILED:', error.message);
      testsFailed++;
    }
    
    // Test 4: Track invariance
    console.log('\n🧪 Test 4: Track invariance progress');
    try {
      const latest = await manager.getLatestAssessment(TEST_CASE_ID);
      const tracking = await manager.trackInvariance({
        tracking_id: `test_inv_${Date.now()}`,
        assessment_id: latest.assessment_id,
        agent_id: 'test_agent',
        guilt_charge: 'test_charge',
        status: 'possible',
        configuration_count: 48,
        invariance_count: 22,
        invariance_percentage: 0.46,
        current_strength: 0.46,
        required_evidence: ['evidence_1', 'evidence_2']
      });
      
      if (tracking && tracking.agent_id === 'test_agent' && 
          tracking.invariance_percentage === 0.46) {
        console.log('✅ Test 4 PASSED: Invariance tracked successfully');
        console.log(`   Agent: ${tracking.agent_id}`);
        console.log(`   Charge: ${tracking.guilt_charge}`);
        console.log(`   Status: ${tracking.status} (${(tracking.invariance_percentage * 100).toFixed(1)}%)`);
        testsPassed++;
      } else {
        throw new Error('Invariance tracking validation failed');
      }
    } catch (error) {
      console.log('❌ Test 4 FAILED:', error.message);
      testsFailed++;
    }
    
    // Test 5: Record optimization event
    console.log('\n🧪 Test 5: Record optimization event');
    try {
      const optimization = await manager.recordOptimization({
        optimization_id: `test_opt_${Date.now()}`,
        genome_id: 'test_genome_001',
        iteration: 5,
        learning_rate: 0.01,
        mutation_rate: 0.1,
        initial_fitness: 0.70,
        final_fitness: 0.73,
        improvement: 0.03,
        converged: false,
        iterations_taken: 5,
        time_elapsed_ms: 250,
        case_id: TEST_CASE_ID,
        notes: 'Test optimization'
      });
      
      if (optimization && optimization.improvement === 0.03) {
        console.log('✅ Test 5 PASSED: Optimization event recorded');
        console.log(`   Improvement: ${(optimization.improvement * 100).toFixed(1)}%`);
        console.log(`   Iterations: ${optimization.iterations_taken}`);
        testsPassed++;
      } else {
        throw new Error('Optimization event validation failed');
      }
    } catch (error) {
      console.log('❌ Test 5 FAILED:', error.message);
      testsFailed++;
    }
    
    // Test 6: Add timeline event
    console.log('\n🧪 Test 6: Add timeline event');
    try {
      const latest = await manager.getLatestAssessment(TEST_CASE_ID);
      const event = await manager.addTimelineEvent({
        timeline_id: `test_timeline_${Date.now()}`,
        case_id: TEST_CASE_ID,
        generation: 1,
        fitness: 0.73,
        completeness: 0.85,
        invariance_rate: 0.45,
        evidence_integration: 0.72,
        fitness_delta: 0.03,
        improvement_rate: 0.043,
        event_type: 'test_event',
        event_description: 'Test timeline event',
        assessment_id: latest.assessment_id
      });
      
      if (event && event.event_type === 'test_event') {
        console.log('✅ Test 6 PASSED: Timeline event added');
        console.log(`   Event: ${event.event_type}`);
        console.log(`   Fitness: ${(event.fitness * 100).toFixed(1)}%`);
        testsPassed++;
      } else {
        throw new Error('Timeline event validation failed');
      }
    } catch (error) {
      console.log('❌ Test 6 FAILED:', error.message);
      testsFailed++;
    }
    
    // Test 7: Get grip evolution
    console.log('\n🧪 Test 7: Get grip evolution timeline');
    try {
      // Add a second assessment for evolution
      await manager.recordAssessment({
        assessment_id: `test_assessment_${Date.now()}_2`,
        generation: 2,
        completeness: 0.88,
        invariance_rate: 0.52,
        evidence_integration: 0.78,
        rule_coverage: 0.71,
        coherence: 0.80,
        explanatory_power: 0.85,
        stability: 0.96,
        efficiency: 0.72,
        fitness: 0.78,
        case_id: TEST_CASE_ID,
        configuration_count: 48,
        evidence_count: 150,
        rule_count: 60
      });
      
      const evolution = await manager.getGripEvolution(TEST_CASE_ID, 10);
      
      if (Array.isArray(evolution) && evolution.length >= 2) {
        console.log(`✅ Test 7 PASSED: Evolution timeline retrieved`);
        console.log(`   Data points: ${evolution.length}`);
        evolution.forEach(point => {
          console.log(`   Gen ${point.generation}: Fitness ${(point.fitness * 100).toFixed(1)}%`);
        });
        testsPassed++;
      } else {
        throw new Error('Evolution timeline too short or invalid');
      }
    } catch (error) {
      console.log('❌ Test 7 FAILED:', error.message);
      testsFailed++;
    }
    
    // Test 8: Generate statistics report
    console.log('\n🧪 Test 8: Generate statistics report');
    try {
      const report = await manager.generateStatsReport(TEST_CASE_ID);
      
      if (report && report.latest_assessment && report.summary) {
        console.log('✅ Test 8 PASSED: Statistics report generated');
        console.log(report.summary);
        testsPassed++;
      } else {
        throw new Error('Statistics report incomplete');
      }
    } catch (error) {
      console.log('❌ Test 8 FAILED:', error.message);
      testsFailed++;
    }
    
    // Test 9: Verify database tables exist
    console.log('\n🧪 Test 9: Verify database tables');
    try {
      const tables = [
        'grip_assessments',
        'attention_genomes',
        'optimization_history',
        'evidence_gap_analysis',
        'invariance_tracking',
        'grip_evolution_timeline'
      ];
      
      let allExist = true;
      for (const table of tables) {
        const result = await pool.query(`
          SELECT EXISTS (
            SELECT FROM information_schema.tables 
            WHERE table_name = $1
          );
        `, [table]);
        
        if (!result.rows[0].exists) {
          allExist = false;
          console.log(`   ❌ Table ${table} does not exist`);
        }
      }
      
      if (allExist) {
        console.log('✅ Test 9 PASSED: All 6 grip tables exist');
        tables.forEach(t => console.log(`   ✓ ${t}`));
        testsPassed++;
      } else {
        throw new Error('Some tables missing');
      }
    } catch (error) {
      console.log('❌ Test 9 FAILED:', error.message);
      testsFailed++;
    }
    
    // Test 10: Verify indexes exist
    console.log('\n🧪 Test 10: Verify database indexes');
    try {
      const result = await pool.query(`
        SELECT COUNT(*) as index_count
        FROM pg_indexes
        WHERE tablename IN (
          'grip_assessments',
          'attention_genomes',
          'optimization_history',
          'evidence_gap_analysis',
          'invariance_tracking',
          'grip_evolution_timeline'
        );
      `);
      
      const indexCount = parseInt(result.rows[0].index_count);
      if (indexCount >= 10) {
        console.log(`✅ Test 10 PASSED: ${indexCount} indexes found`);
        testsPassed++;
      } else {
        throw new Error(`Only ${indexCount} indexes found, expected >= 10`);
      }
    } catch (error) {
      console.log('❌ Test 10 FAILED:', error.message);
      testsFailed++;
    }
    
  } catch (error) {
    console.error('\n❌ Fatal error:', error);
    testsFailed++;
  } finally {
    // Cleanup
    console.log('\n🧹 Cleanup: Closing connections...');
    if (manager) {
      await manager.close();
    }
    if (pool) {
      await pool.end();
    }
    console.log('✅ Cleanup complete\n');
  }
  
  // Summary
  console.log('='.repeat(70));
  console.log('\n📊 Test Results Summary\n');
  console.log(`Total Tests: ${testsPassed + testsFailed}`);
  console.log(`✅ Passed: ${testsPassed}`);
  console.log(`❌ Failed: ${testsFailed}`);
  console.log(`Success Rate: ${((testsPassed / (testsPassed + testsFailed)) * 100).toFixed(1)}%\n`);
  
  if (testsFailed === 0) {
    console.log('🎉 ALL TESTS PASSED!\n');
    return 0;
  } else {
    console.log('⚠️ SOME TESTS FAILED\n');
    return 1;
  }
}

// Run tests
if (require.main === module) {
  testGripOptimizationSystem()
    .then((exitCode) => {
      process.exit(exitCode);
    })
    .catch((error) => {
      console.error('Test suite failed:', error);
      process.exit(1);
    });
}

module.exports = testGripOptimizationSystem;
