/**
 * Grip Metrics Database Migration
 * 
 * Adds tables for tracking grip optimization metrics across legal analysis iterations.
 * Enables continuous measurement and improvement of legal reasoning quality.
 */

const { drizzle } = require('drizzle-orm/node-postgres');
const { Pool } = require('pg');
const config = require('./config');

const pool = new Pool({ connectionString: config.databaseUrl });
const db = drizzle(pool);

async function migrateGripMetrics() {
  console.log('🧬 Starting Grip Metrics Migration...\n');

  try {
    // 1. Grip Assessments Table
    console.log('Creating grip_assessments table...');
    await pool.query(`
      CREATE TABLE IF NOT EXISTS grip_assessments (
        id SERIAL PRIMARY KEY,
        assessment_id VARCHAR(255) UNIQUE NOT NULL,
        generation INTEGER NOT NULL DEFAULT 0,
        timestamp TIMESTAMPTZ NOT NULL DEFAULT NOW(),
        
        -- Quantitative metrics (0-1 normalized)
        completeness DECIMAL(5,4) NOT NULL DEFAULT 0,
        invariance_rate DECIMAL(5,4) NOT NULL DEFAULT 0,
        evidence_integration DECIMAL(5,4) NOT NULL DEFAULT 0,
        rule_coverage DECIMAL(5,4) NOT NULL DEFAULT 0,
        delta_minimization DECIMAL(10,4) NOT NULL DEFAULT 0,
        
        -- Qualitative metrics (0-1 normalized)
        coherence DECIMAL(5,4) NOT NULL DEFAULT 0,
        explanatory_power DECIMAL(5,4) NOT NULL DEFAULT 0,
        predictive_accuracy DECIMAL(5,4) NOT NULL DEFAULT 0,
        resistance_to_counterexamples DECIMAL(5,4) NOT NULL DEFAULT 0,
        transformative_insight DECIMAL(5,4) NOT NULL DEFAULT 0,
        
        -- Computational metrics
        stability DECIMAL(5,4) NOT NULL DEFAULT 0,
        efficiency DECIMAL(5,4) NOT NULL DEFAULT 0,
        
        -- Overall fitness
        fitness DECIMAL(5,4) NOT NULL DEFAULT 0,
        
        -- Context
        case_id VARCHAR(255),
        configuration_count INTEGER DEFAULT 0,
        evidence_count INTEGER DEFAULT 0,
        rule_count INTEGER DEFAULT 0,
        
        -- Metadata
        notes TEXT,
        created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
      );
    `);
    console.log('✅ Created grip_assessments table\n');

    // 2. Attention Genomes Table
    console.log('Creating attention_genomes table...');
    await pool.query(`
      CREATE TABLE IF NOT EXISTS attention_genomes (
        id SERIAL PRIMARY KEY,
        genome_id VARCHAR(255) UNIQUE NOT NULL,
        generation INTEGER NOT NULL DEFAULT 0,
        
        -- Lineage
        parent_ids TEXT[], -- Array of parent genome IDs
        
        -- Genetic weights (stored as JSON)
        causal_weights JSONB,
        intentional_weights JSONB,
        temporal_weights JSONB,
        normative_weights JSONB,
        counterfactual_weights JSONB,
        necessity_weights JSONB,
        proportionality_weights JSONB,
        
        -- Performance history
        fitness_history JSONB, -- Array of fitness scores
        
        -- Metadata
        age INTEGER DEFAULT 0,
        mutations INTEGER DEFAULT 0,
        created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
        last_evaluated_at TIMESTAMPTZ
      );
    `);
    console.log('✅ Created attention_genomes table\n');

    // 3. Optimization History Table
    console.log('Creating optimization_history table...');
    await pool.query(`
      CREATE TABLE IF NOT EXISTS optimization_history (
        id SERIAL PRIMARY KEY,
        optimization_id VARCHAR(255) UNIQUE NOT NULL,
        genome_id VARCHAR(255) REFERENCES attention_genomes(genome_id),
        
        -- Optimization parameters
        iteration INTEGER NOT NULL,
        learning_rate DECIMAL(10,8) NOT NULL,
        mutation_rate DECIMAL(5,4),
        
        -- Results
        initial_fitness DECIMAL(5,4),
        final_fitness DECIMAL(5,4),
        improvement DECIMAL(5,4),
        
        -- Convergence info
        converged BOOLEAN DEFAULT FALSE,
        iterations_taken INTEGER,
        time_elapsed_ms INTEGER,
        
        -- Context
        case_id VARCHAR(255),
        
        -- Metadata
        notes TEXT,
        created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
      );
    `);
    console.log('✅ Created optimization_history table\n');

    // 4. Evidence Gap Analysis Table
    console.log('Creating evidence_gap_analysis table...');
    await pool.query(`
      CREATE TABLE IF NOT EXISTS evidence_gap_analysis (
        id SERIAL PRIMARY KEY,
        gap_id VARCHAR(255) UNIQUE NOT NULL,
        assessment_id VARCHAR(255) REFERENCES grip_assessments(assessment_id),
        
        -- Gap identification
        gap_type VARCHAR(100) NOT NULL, -- 'missing_link', 'weak_support', 'contradiction'
        configuration_id VARCHAR(255),
        evidence_id VARCHAR(255),
        
        -- Impact assessment
        impact_on_invariance DECIMAL(5,4) DEFAULT 0,
        impact_on_fitness DECIMAL(5,4) DEFAULT 0,
        priority_score DECIMAL(5,4) DEFAULT 0,
        
        -- Recommendation
        recommended_action TEXT,
        required_evidence_type VARCHAR(255),
        
        -- Status tracking
        status VARCHAR(50) DEFAULT 'identified', -- identified, in_progress, resolved, deferred
        resolved_at TIMESTAMPTZ,
        resolution_notes TEXT,
        
        -- Metadata
        created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
        updated_at TIMESTAMPTZ
      );
    `);
    console.log('✅ Created evidence_gap_analysis table\n');

    // 5. Invariance Tracking Table
    console.log('Creating invariance_tracking table...');
    await pool.query(`
      CREATE TABLE IF NOT EXISTS invariance_tracking (
        id SERIAL PRIMARY KEY,
        tracking_id VARCHAR(255) UNIQUE NOT NULL,
        assessment_id VARCHAR(255) REFERENCES grip_assessments(assessment_id),
        
        -- Configuration info
        agent_id VARCHAR(255) NOT NULL,
        guilt_charge VARCHAR(255) NOT NULL,
        
        -- Invariance status
        status VARCHAR(50) NOT NULL, -- 'necessary', 'possible', 'impossible'
        configuration_count INTEGER DEFAULT 0,
        invariance_count INTEGER DEFAULT 0,
        invariance_percentage DECIMAL(5,4) DEFAULT 0,
        
        -- Strengthening path
        current_strength DECIMAL(5,4) DEFAULT 0,
        target_strength DECIMAL(5,4) DEFAULT 1.0,
        required_evidence TEXT[],
        
        -- Timeline
        first_detected_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
        last_updated_at TIMESTAMPTZ,
        achieved_invariance_at TIMESTAMPTZ
      );
    `);
    console.log('✅ Created invariance_tracking table\n');

    // 6. Grip Evolution Timeline Table
    console.log('Creating grip_evolution_timeline table...');
    await pool.query(`
      CREATE TABLE IF NOT EXISTS grip_evolution_timeline (
        id SERIAL PRIMARY KEY,
        timeline_id VARCHAR(255) UNIQUE NOT NULL,
        case_id VARCHAR(255) NOT NULL,
        
        -- Timeline point
        timestamp TIMESTAMPTZ NOT NULL DEFAULT NOW(),
        generation INTEGER NOT NULL,
        
        -- Metrics snapshot
        fitness DECIMAL(5,4) NOT NULL,
        completeness DECIMAL(5,4),
        invariance_rate DECIMAL(5,4),
        evidence_integration DECIMAL(5,4),
        
        -- Changes from previous
        fitness_delta DECIMAL(5,4),
        improvement_rate DECIMAL(5,4),
        
        -- Events
        event_type VARCHAR(100), -- 'optimization', 'mutation', 'evidence_added', 'rule_applied'
        event_description TEXT,
        
        -- Context
        genome_id VARCHAR(255),
        assessment_id VARCHAR(255),
        
        created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
      );
    `);
    console.log('✅ Created grip_evolution_timeline table\n');

    // Create indexes for performance
    console.log('Creating indexes...');
    
    await pool.query(`
      CREATE INDEX IF NOT EXISTS idx_grip_assessments_case 
      ON grip_assessments(case_id);
      
      CREATE INDEX IF NOT EXISTS idx_grip_assessments_fitness 
      ON grip_assessments(fitness DESC);
      
      CREATE INDEX IF NOT EXISTS idx_grip_assessments_generation 
      ON grip_assessments(generation);
      
      CREATE INDEX IF NOT EXISTS idx_attention_genomes_generation 
      ON attention_genomes(generation);
      
      CREATE INDEX IF NOT EXISTS idx_optimization_history_genome 
      ON optimization_history(genome_id);
      
      CREATE INDEX IF NOT EXISTS idx_evidence_gaps_status 
      ON evidence_gap_analysis(status);
      
      CREATE INDEX IF NOT EXISTS idx_evidence_gaps_priority 
      ON evidence_gap_analysis(priority_score DESC);
      
      CREATE INDEX IF NOT EXISTS idx_invariance_status 
      ON invariance_tracking(status);
      
      CREATE INDEX IF NOT EXISTS idx_evolution_timeline_case 
      ON grip_evolution_timeline(case_id);
      
      CREATE INDEX IF NOT EXISTS idx_evolution_timeline_timestamp 
      ON grip_evolution_timeline(timestamp);
    `);
    console.log('✅ Created indexes\n');

    // Insert sample data for demonstration
    console.log('Inserting sample grip assessment...');
    await pool.query(`
      INSERT INTO grip_assessments (
        assessment_id, generation, completeness, invariance_rate, 
        evidence_integration, rule_coverage, coherence, 
        explanatory_power, stability, efficiency, fitness,
        case_id, configuration_count, evidence_count, rule_count, notes
      ) VALUES (
        'assessment_demo_001',
        0,
        0.85,
        0.45,
        0.72,
        0.68,
        0.75,
        0.80,
        0.95,
        0.70,
        0.73,
        'case_2025_137857',
        48,
        150,
        60,
        'Initial grip assessment for demonstration'
      ) ON CONFLICT (assessment_id) DO NOTHING;
    `);
    console.log('✅ Inserted sample data\n');

    console.log('✅ Grip Metrics Migration Complete!\n');
    console.log('📊 Created 6 new tables:');
    console.log('   1. grip_assessments - Comprehensive grip measurements');
    console.log('   2. attention_genomes - Genetic attention patterns');
    console.log('   3. optimization_history - Optimization tracking');
    console.log('   4. evidence_gap_analysis - Gap identification and resolution');
    console.log('   5. invariance_tracking - Invariance strengthening progress');
    console.log('   6. grip_evolution_timeline - Temporal fitness tracking\n');

  } catch (error) {
    console.error('❌ Migration failed:', error);
    throw error;
  } finally {
    await pool.end();
  }
}

// Run migration if called directly
if (require.main === module) {
  migrateGripMetrics()
    .then(() => {
      console.log('Migration completed successfully');
      process.exit(0);
    })
    .catch((error) => {
      console.error('Migration failed:', error);
      process.exit(1);
    });
}

module.exports = { migrateGripMetrics };
