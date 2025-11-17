/**
 * Grip Manager - Database Operations for Grip Optimization
 * 
 * Provides API for recording, querying, and analyzing grip metrics
 * across legal analysis iterations.
 */

const { drizzle } = require('drizzle-orm/node-postgres');
const { Pool } = require('pg');
const config = require('./config');

class GripManager {
  constructor() {
    this.pool = new Pool({ connectionString: config.databaseUrl });
    this.db = drizzle(this.pool);
  }

  /**
   * Record a grip assessment
   */
  async recordAssessment(metrics) {
    const query = `
      INSERT INTO grip_assessments (
        assessment_id, generation, completeness, invariance_rate,
        evidence_integration, rule_coverage, delta_minimization,
        coherence, explanatory_power, predictive_accuracy,
        resistance_to_counterexamples, transformative_insight,
        stability, efficiency, fitness,
        case_id, configuration_count, evidence_count, rule_count, notes
      ) VALUES (
        $1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14, $15,
        $16, $17, $18, $19, $20
      )
      RETURNING *;
    `;

    const values = [
      metrics.assessment_id || `assessment_${Date.now()}`,
      metrics.generation || 0,
      metrics.completeness || 0,
      metrics.invariance_rate || 0,
      metrics.evidence_integration || 0,
      metrics.rule_coverage || 0,
      metrics.delta_minimization || 0,
      metrics.coherence || 0,
      metrics.explanatory_power || 0,
      metrics.predictive_accuracy || 0,
      metrics.resistance_to_counterexamples || 0,
      metrics.transformative_insight || 0,
      metrics.stability || 0,
      metrics.efficiency || 0,
      metrics.fitness || 0,
      metrics.case_id || 'case_2025_137857',
      metrics.configuration_count || 0,
      metrics.evidence_count || 0,
      metrics.rule_count || 0,
      metrics.notes || null
    ];

    const result = await this.pool.query(query, values);
    return result.rows[0];
  }

  /**
   * Get latest grip assessment for a case
   */
  async getLatestAssessment(caseId = 'case_2025_137857') {
    const query = `
      SELECT * FROM grip_assessments
      WHERE case_id = $1
      ORDER BY generation DESC, created_at DESC
      LIMIT 1;
    `;

    const result = await this.pool.query(query, [caseId]);
    return result.rows[0] || null;
  }

  /**
   * Get grip evolution over time
   */
  async getGripEvolution(caseId = 'case_2025_137857', limit = 50) {
    const query = `
      SELECT 
        generation,
        timestamp,
        fitness,
        completeness,
        invariance_rate,
        evidence_integration,
        coherence,
        transformative_insight
      FROM grip_assessments
      WHERE case_id = $1
      ORDER BY generation ASC, created_at ASC
      LIMIT $2;
    `;

    const result = await this.pool.query(query, [caseId, limit]);
    return result.rows;
  }

  /**
   * Identify evidence gaps
   */
  async identifyEvidenceGaps(assessmentId) {
    const query = `
      INSERT INTO evidence_gap_analysis (
        gap_id, assessment_id, gap_type, priority_score,
        recommended_action, status
      ) VALUES ($1, $2, $3, $4, $5, $6)
      RETURNING *;
    `;

    // Analyze assessment to find gaps (simplified for demo)
    const assessment = await this.pool.query(
      'SELECT * FROM grip_assessments WHERE assessment_id = $1',
      [assessmentId]
    );

    if (!assessment.rows[0]) {
      throw new Error('Assessment not found');
    }

    const gaps = [];
    const metrics = assessment.rows[0];

    // Check for low invariance rate
    if (metrics.invariance_rate < 0.5) {
      gaps.push({
        gap_id: `gap_${Date.now()}_invariance`,
        assessment_id: assessmentId,
        gap_type: 'weak_invariance',
        priority_score: 1.0 - metrics.invariance_rate,
        recommended_action: 'Collect additional evidence to strengthen necessity claims',
        status: 'identified'
      });
    }

    // Check for low evidence integration
    if (metrics.evidence_integration < 0.7) {
      gaps.push({
        gap_id: `gap_${Date.now()}_evidence`,
        assessment_id: assessmentId,
        gap_type: 'missing_links',
        priority_score: 1.0 - metrics.evidence_integration,
        recommended_action: 'Link more evidence items to configurations',
        status: 'identified'
      });
    }

    // Check for low rule coverage
    if (metrics.rule_coverage < 0.7) {
      gaps.push({
        gap_id: `gap_${Date.now()}_rules`,
        assessment_id: assessmentId,
        gap_type: 'incomplete_rules',
        priority_score: 1.0 - metrics.rule_coverage,
        recommended_action: 'Apply additional applicable legal principles',
        status: 'identified'
      });
    }

    // Insert all gaps
    for (const gap of gaps) {
      await this.pool.query(query, [
        gap.gap_id,
        gap.assessment_id,
        gap.gap_type,
        gap.priority_score,
        gap.recommended_action,
        gap.status
      ]);
    }

    return gaps;
  }

  /**
   * Track invariance progress
   */
  async trackInvariance(data) {
    const query = `
      INSERT INTO invariance_tracking (
        tracking_id, assessment_id, agent_id, guilt_charge,
        status, configuration_count, invariance_count,
        invariance_percentage, current_strength, required_evidence
      ) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10)
      ON CONFLICT (tracking_id) 
      DO UPDATE SET
        invariance_count = EXCLUDED.invariance_count,
        invariance_percentage = EXCLUDED.invariance_percentage,
        current_strength = EXCLUDED.current_strength,
        last_updated_at = NOW()
      RETURNING *;
    `;

    const values = [
      data.tracking_id || `inv_${data.agent_id}_${data.guilt_charge}`,
      data.assessment_id,
      data.agent_id,
      data.guilt_charge,
      data.status,
      data.configuration_count || 0,
      data.invariance_count || 0,
      data.invariance_percentage || 0,
      data.current_strength || 0,
      data.required_evidence || []
    ];

    const result = await this.pool.query(query, values);
    return result.rows[0];
  }

  /**
   * Record optimization event
   */
  async recordOptimization(data) {
    const query = `
      INSERT INTO optimization_history (
        optimization_id, genome_id, iteration, learning_rate,
        mutation_rate, initial_fitness, final_fitness,
        improvement, converged, iterations_taken, time_elapsed_ms,
        case_id, notes
      ) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13)
      RETURNING *;
    `;

    const values = [
      data.optimization_id || `opt_${Date.now()}`,
      data.genome_id,
      data.iteration || 0,
      data.learning_rate || 0.01,
      data.mutation_rate || 0.1,
      data.initial_fitness || 0,
      data.final_fitness || 0,
      data.improvement || 0,
      data.converged || false,
      data.iterations_taken || 0,
      data.time_elapsed_ms || 0,
      data.case_id || 'case_2025_137857',
      data.notes || null
    ];

    const result = await this.pool.query(query, values);
    return result.rows[0];
  }

  /**
   * Add timeline event
   */
  async addTimelineEvent(event) {
    const query = `
      INSERT INTO grip_evolution_timeline (
        timeline_id, case_id, generation, fitness,
        completeness, invariance_rate, evidence_integration,
        fitness_delta, improvement_rate, event_type,
        event_description, genome_id, assessment_id
      ) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13)
      RETURNING *;
    `;

    const values = [
      event.timeline_id || `timeline_${Date.now()}`,
      event.case_id || 'case_2025_137857',
      event.generation || 0,
      event.fitness || 0,
      event.completeness || null,
      event.invariance_rate || null,
      event.evidence_integration || null,
      event.fitness_delta || null,
      event.improvement_rate || null,
      event.event_type,
      event.event_description,
      event.genome_id || null,
      event.assessment_id || null
    ];

    const result = await this.pool.query(query, values);
    return result.rows[0];
  }

  /**
   * Generate grip statistics report
   */
  async generateStatsReport(caseId = 'case_2025_137857') {
    // Get latest assessment
    const latest = await this.getLatestAssessment(caseId);
    
    // Get evolution trend
    const evolution = await this.getGripEvolution(caseId, 10);
    
    // Get evidence gaps
    const gapsQuery = `
      SELECT gap_type, COUNT(*) as count, AVG(priority_score) as avg_priority
      FROM evidence_gap_analysis ega
      JOIN grip_assessments ga ON ega.assessment_id = ga.assessment_id
      WHERE ga.case_id = $1 AND ega.status = 'identified'
      GROUP BY gap_type;
    `;
    const gaps = await this.pool.query(gapsQuery, [caseId]);
    
    // Get invariance status
    const invarianceQuery = `
      SELECT status, COUNT(*) as count, AVG(invariance_percentage) as avg_percentage
      FROM invariance_tracking it
      JOIN grip_assessments ga ON it.assessment_id = ga.assessment_id
      WHERE ga.case_id = $1
      GROUP BY status;
    `;
    const invariance = await this.pool.query(invarianceQuery, [caseId]);
    
    // Compile report
    const report = {
      case_id: caseId,
      timestamp: new Date().toISOString(),
      latest_assessment: latest,
      evolution_trend: evolution,
      evidence_gaps: gaps.rows,
      invariance_status: invariance.rows,
      summary: this._generateSummary(latest, evolution, gaps.rows, invariance.rows)
    };
    
    return report;
  }

  /**
   * Generate human-readable summary
   */
  _generateSummary(latest, evolution, gaps, invariance) {
    if (!latest) {
      return 'No assessments recorded yet.';
    }

    const fitness = latest.fitness;
    const trend = evolution.length > 1 
      ? evolution[evolution.length - 1].fitness - evolution[0].fitness
      : 0;

    let summary = `\n📊 Grip Statistics Summary\n`;
    summary += `${'='.repeat(50)}\n\n`;
    summary += `Current Fitness: ${(fitness * 100).toFixed(1)}%\n`;
    summary += `Generation: ${latest.generation}\n`;
    
    if (trend > 0) {
      summary += `Trend: ↑ Improving (${(trend * 100).toFixed(1)}% gain)\n`;
    } else if (trend < 0) {
      summary += `Trend: ↓ Declining (${Math.abs(trend * 100).toFixed(1)}% loss)\n`;
    } else {
      summary += `Trend: → Stable\n`;
    }
    
    summary += `\nKey Metrics:\n`;
    summary += `- Completeness: ${(latest.completeness * 100).toFixed(1)}%\n`;
    summary += `- Invariance Rate: ${(latest.invariance_rate * 100).toFixed(1)}%\n`;
    summary += `- Evidence Integration: ${(latest.evidence_integration * 100).toFixed(1)}%\n`;
    summary += `- Rule Coverage: ${(latest.rule_coverage * 100).toFixed(1)}%\n`;
    
    if (gaps.length > 0) {
      summary += `\nEvidence Gaps Identified: ${gaps.length} types\n`;
      gaps.forEach(gap => {
        summary += `- ${gap.gap_type}: ${gap.count} gaps (priority: ${(gap.avg_priority * 100).toFixed(1)}%)\n`;
      });
    }
    
    if (invariance.length > 0) {
      summary += `\nInvariance Status:\n`;
      invariance.forEach(inv => {
        summary += `- ${inv.status}: ${inv.count} (${(inv.avg_percentage * 100).toFixed(1)}% avg)\n`;
      });
    }
    
    return summary;
  }

  /**
   * Demo: Run comprehensive grip analysis
   */
  async demo() {
    console.log('🧬 Grip Manager Demo\n');
    console.log('='*70);

    try {
      // 1. Record initial assessment
      console.log('\n1️⃣ Recording initial grip assessment...');
      const assessment = await this.recordAssessment({
        assessment_id: `demo_${Date.now()}`,
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
        configuration_count: 48,
        evidence_count: 150,
        rule_count: 60,
        notes: 'Demo assessment'
      });
      console.log(`✅ Recorded: ${assessment.assessment_id}`);
      console.log(`   Fitness: ${(assessment.fitness * 100).toFixed(1)}%`);

      // 2. Identify evidence gaps
      console.log('\n2️⃣ Identifying evidence gaps...');
      const gaps = await this.identifyEvidenceGaps(assessment.assessment_id);
      console.log(`✅ Found ${gaps.length} evidence gaps`);
      gaps.forEach(gap => {
        console.log(`   - ${gap.gap_type}: ${gap.recommended_action}`);
      });

      // 3. Track invariance
      console.log('\n3️⃣ Tracking invariance progress...');
      const tracking = await this.trackInvariance({
        assessment_id: assessment.assessment_id,
        agent_id: 'bantjies',
        guilt_charge: 'breach_fiduciary_duty',
        status: 'possible',
        configuration_count: 48,
        invariance_count: 22,
        invariance_percentage: 0.46,
        current_strength: 0.46,
        required_evidence: ['email_evidence', 'timeline_proof']
      });
      console.log(`✅ Tracked: ${tracking.agent_id} - ${tracking.guilt_charge}`);
      console.log(`   Status: ${tracking.status} (${(tracking.invariance_percentage * 100).toFixed(1)}%)`);

      // 4. Record timeline event
      console.log('\n4️⃣ Recording timeline event...');
      const event = await this.addTimelineEvent({
        generation: 1,
        fitness: 0.73,
        event_type: 'initial_assessment',
        event_description: 'Initial grip assessment completed',
        assessment_id: assessment.assessment_id
      });
      console.log(`✅ Event recorded: ${event.event_type}`);

      // 5. Generate statistics report
      console.log('\n5️⃣ Generating statistics report...');
      const report = await this.generateStatsReport();
      console.log(report.summary);

      console.log('\n✅ Demo complete!\n');

    } catch (error) {
      console.error('❌ Demo failed:', error);
      throw error;
    }
  }

  /**
   * Display statistics
   */
  async stats() {
    const report = await this.generateStatsReport();
    console.log(report.summary);
  }

  /**
   * Close database connection
   */
  async close() {
    await this.pool.end();
  }
}

// CLI interface
async function main() {
  const manager = new GripManager();
  const command = process.argv[2] || 'stats';

  try {
    switch (command) {
      case 'demo':
        await manager.demo();
        break;
      case 'stats':
        await manager.stats();
        break;
      default:
        console.log('Usage: node grip-manager.js [demo|stats]');
    }
  } catch (error) {
    console.error('Error:', error);
    process.exit(1);
  } finally {
    await manager.close();
  }
}

// Run if called directly
if (require.main === module) {
  main();
}

module.exports = GripManager;
