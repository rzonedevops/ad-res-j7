#!/usr/bin/env node

const { db } = require('./config');
const { sql } = require('drizzle-orm');
const fs = require('fs');
const path = require('path');

/**
 * Advanced Analytics Dashboard for Legal Case Management
 * 
 * Provides comprehensive analytics across:
 * - Legal arguments and strategy effectiveness
 * - Issue completion and progress tracking
 * - Evidence collection status
 * - Cross-reference network analysis
 * - Timeline and milestone projections
 */
class AnalyticsDashboard {
  
  constructor() {
    this.dashboardData = null;
  }

  /**
   * Generate comprehensive analytics dashboard data
   */
  async generateDashboard() {
    console.log('🔄 Generating Advanced Analytics Dashboard...\n');
    
    const dashboardData = {
      metadata: {
        generated_at: new Date().toISOString(),
        dashboard_version: '1.0.0',
        case_id: '2025-137857'
      },
      executive_summary: await this.getExecutiveSummary(),
      issue_analytics: await this.getIssueAnalytics(),
      legal_argument_strength: await this.getLegalArgumentStrength(),
      evidence_analytics: await this.getEvidenceAnalytics(),
      cross_reference_network: await this.getCrossReferenceNetworkAnalytics(),
      timeline_projections: await this.getTimelineProjections(),
      performance_metrics: await this.getPerformanceMetrics(),
      risk_assessment: await this.getRiskAssessment()
    };
    
    this.dashboardData = dashboardData;
    return dashboardData;
  }

  /**
   * Get executive summary with key metrics
   */
  async getExecutiveSummary() {
    try {
      // Total issues by type and status
      const issueStats = await db.execute(sql`
        SELECT 
          issue_type,
          status,
          COUNT(*) as count
        FROM issues
        GROUP BY issue_type, status
      `);
      
      // Total evidence records
      const evidenceCount = await db.execute(sql`
        SELECT COUNT(*) as count FROM evidence_records
      `);
      
      // Total legal arguments
      const argumentCount = await db.execute(sql`
        SELECT COUNT(*) as count FROM legal_arguments
      `);
      
      // Calculate completion rate
      const completionStats = await db.execute(sql`
        SELECT 
          COUNT(CASE WHEN status = 'closed' THEN 1 END)::float / NULLIF(COUNT(*), 0) * 100 as completion_rate,
          COUNT(CASE WHEN status = 'open' THEN 1 END) as open_count,
          COUNT(CASE WHEN status = 'closed' THEN 1 END) as closed_count,
          COUNT(*) as total_count
        FROM issues
      `);
      
      const stats = completionStats.rows[0];
      
      return {
        total_issues: parseInt(stats.total_count) || 0,
        open_issues: parseInt(stats.open_count) || 0,
        closed_issues: parseInt(stats.closed_count) || 0,
        completion_rate: parseFloat(stats.completion_rate || 0).toFixed(1) + '%',
        total_evidence: parseInt(evidenceCount.rows[0]?.count || 0),
        total_arguments: parseInt(argumentCount.rows[0]?.count || 0),
        issue_breakdown: this.formatIssueBreakdown(issueStats.rows)
      };
    } catch (error) {
      console.error('Error getting executive summary:', error);
      return this.getDefaultExecutiveSummary();
    }
  }

  /**
   * Get detailed issue analytics
   */
  async getIssueAnalytics() {
    try {
      // Feature issues with their task counts
      const featureAnalytics = await db.execute(sql`
        SELECT 
          f.id,
          f.title,
          f.priority,
          f.status,
          f.rank_order,
          f.weight,
          COUNT(t.id) as task_count,
          COUNT(CASE WHEN t.status = 'closed' THEN 1 END) as completed_tasks,
          AVG(t.weight) as avg_task_weight
        FROM issues f
        LEFT JOIN issues t ON t.parent_issue_id = f.id
        WHERE f.issue_type = 'feature'
        GROUP BY f.id, f.title, f.priority, f.status, f.rank_order, f.weight
        ORDER BY f.rank_order ASC NULLS LAST, f.weight DESC NULLS LAST
      `);
      
      // Priority distribution
      const priorityDist = await db.execute(sql`
        SELECT 
          priority,
          COUNT(*) as count,
          COUNT(CASE WHEN status = 'closed' THEN 1 END) as completed
        FROM issues
        GROUP BY priority
        ORDER BY 
          CASE priority
            WHEN 'critical' THEN 1
            WHEN 'high' THEN 2
            WHEN 'medium' THEN 3
            WHEN 'low' THEN 4
          END
      `);
      
      return {
        feature_issues: featureAnalytics.rows.map(f => ({
          id: f.id,
          title: f.title,
          priority: f.priority,
          status: f.status,
          rank_order: f.rank_order,
          weight: f.weight,
          task_count: parseInt(f.task_count) || 0,
          completed_tasks: parseInt(f.completed_tasks) || 0,
          completion_rate: this.calculatePercentage(f.completed_tasks, f.task_count),
          avg_task_weight: parseFloat(f.avg_task_weight || 0).toFixed(1)
        })),
        priority_distribution: priorityDist.rows.map(p => ({
          priority: p.priority,
          total: parseInt(p.count),
          completed: parseInt(p.completed),
          completion_rate: this.calculatePercentage(p.completed, p.count)
        }))
      };
    } catch (error) {
      console.error('Error getting issue analytics:', error);
      return { feature_issues: [], priority_distribution: [] };
    }
  }

  /**
   * Analyze legal argument strength based on linked issues
   */
  async getLegalArgumentStrength() {
    try {
      const argumentAnalysis = await db.execute(sql`
        SELECT 
          la.id,
          la.argument_name,
          la.argument_type,
          la.status,
          COUNT(DISTINCT ial.issue_id) as linked_issues,
          AVG(ial.strength) as avg_strength,
          COUNT(DISTINCT CASE WHEN i.status = 'closed' THEN ial.issue_id END) as completed_issues
        FROM legal_arguments la
        LEFT JOIN issue_argument_links ial ON la.id = ial.argument_id
        LEFT JOIN issues i ON ial.issue_id = i.id
        WHERE la.status = 'active'
        GROUP BY la.id, la.argument_name, la.argument_type, la.status
        ORDER BY avg_strength DESC NULLS LAST
      `);
      
      return argumentAnalysis.rows.map(arg => ({
        id: arg.id,
        name: arg.argument_name,
        type: arg.argument_type,
        linked_issues: parseInt(arg.linked_issues) || 0,
        completed_issues: parseInt(arg.completed_issues) || 0,
        avg_strength: parseFloat(arg.avg_strength || 0).toFixed(1),
        completion_rate: this.calculatePercentage(arg.completed_issues, arg.linked_issues),
        strength_rating: this.getRatingFromScore(parseFloat(arg.avg_strength || 0))
      }));
    } catch (error) {
      console.error('Error analyzing legal arguments:', error);
      return [];
    }
  }

  /**
   * Get evidence collection analytics
   */
  async getEvidenceAnalytics() {
    try {
      // Evidence by type
      const evidenceByType = await db.execute(sql`
        SELECT 
          evidence_type,
          COUNT(*) as count,
          COUNT(CASE WHEN file_path IS NOT NULL AND file_path != '' THEN 1 END) as with_files
        FROM evidence_records
        GROUP BY evidence_type
        ORDER BY count DESC
      `);
      
      // Recent evidence collection
      const recentEvidence = await db.execute(sql`
        SELECT 
          evidence_type,
          description,
          source,
          date_collected,
          created_at
        FROM evidence_records
        ORDER BY created_at DESC
        LIMIT 10
      `);
      
      // Total count
      const totalCount = await db.execute(sql`
        SELECT COUNT(*) as count FROM evidence_records
      `);
      
      return {
        total_evidence: parseInt(totalCount.rows[0]?.count || 0),
        by_type: evidenceByType.rows.map(e => ({
          type: e.evidence_type,
          count: parseInt(e.count),
          with_files: parseInt(e.with_files),
          file_rate: this.calculatePercentage(e.with_files, e.count)
        })),
        recent_additions: recentEvidence.rows.map(e => ({
          type: e.evidence_type,
          description: e.description?.substring(0, 100) + (e.description?.length > 100 ? '...' : ''),
          source: e.source,
          collected: e.date_collected || e.created_at
        }))
      };
    } catch (error) {
      console.error('Error getting evidence analytics:', error);
      return { total_evidence: 0, by_type: [], recent_additions: [] };
    }
  }

  /**
   * Analyze cross-reference network
   */
  async getCrossReferenceNetworkAnalytics() {
    try {
      // Cross-references by type
      const xrefByType = await db.execute(sql`
        SELECT 
          reference_type,
          COUNT(*) as count,
          COUNT(DISTINCT issue_id) as unique_issues
        FROM issue_cross_references
        GROUP BY reference_type
        ORDER BY count DESC
      `);
      
      // Consolidation opportunities
      const consolidations = await db.execute(sql`
        SELECT 
          consolidation_status,
          COUNT(*) as count,
          SUM(issue_count) as total_issues
        FROM cross_reference_consolidations
        GROUP BY consolidation_status
      `);
      
      // Top cross-referenced items
      const topXrefs = await db.execute(sql`
        SELECT 
          reference_type,
          reference_id,
          reference_title,
          COUNT(DISTINCT issue_id) as issue_count
        FROM issue_cross_references
        GROUP BY reference_type, reference_id, reference_title
        ORDER BY issue_count DESC
        LIMIT 10
      `);
      
      return {
        by_type: xrefByType.rows.map(x => ({
          type: x.reference_type,
          count: parseInt(x.count),
          unique_issues: parseInt(x.unique_issues)
        })),
        consolidation_opportunities: consolidations.rows.map(c => ({
          status: c.consolidation_status,
          count: parseInt(c.count),
          total_issues: parseInt(c.total_issues || 0)
        })),
        most_referenced: topXrefs.rows.map(x => ({
          type: x.reference_type,
          id: x.reference_id,
          title: x.reference_title?.substring(0, 80) + (x.reference_title?.length > 80 ? '...' : ''),
          issue_count: parseInt(x.issue_count)
        }))
      };
    } catch (error) {
      console.error('Error getting cross-reference analytics:', error);
      return { by_type: [], consolidation_opportunities: [], most_referenced: [] };
    }
  }

  /**
   * Get timeline projections based on current progress
   */
  async getTimelineProjections() {
    try {
      const stats = await db.execute(sql`
        SELECT 
          COUNT(*) as total_issues,
          COUNT(CASE WHEN status = 'closed' THEN 1 END) as closed_issues,
          COUNT(CASE WHEN status = 'open' AND priority = 'critical' THEN 1 END) as critical_open,
          COUNT(CASE WHEN status = 'open' AND priority = 'high' THEN 1 END) as high_open,
          AVG(EXTRACT(EPOCH FROM (completed_at - created_at))/3600) FILTER (WHERE completed_at IS NOT NULL) as avg_completion_hours
        FROM issues
      `);
      
      const data = stats.rows[0];
      const totalIssues = parseInt(data.total_issues) || 0;
      const closedIssues = parseInt(data.closed_issues) || 0;
      const openIssues = totalIssues - closedIssues;
      const avgHours = parseFloat(data.avg_completion_hours) || 24;
      
      const estimatedHoursRemaining = openIssues * avgHours;
      const estimatedDays = Math.ceil(estimatedHoursRemaining / 8); // 8 hour workday
      
      return {
        current_progress: {
          total_issues: totalIssues,
          completed: closedIssues,
          remaining: openIssues,
          completion_rate: this.calculatePercentage(closedIssues, totalIssues)
        },
        critical_items: {
          critical_open: parseInt(data.critical_open) || 0,
          high_open: parseInt(data.high_open) || 0
        },
        projections: {
          avg_completion_hours: avgHours.toFixed(1),
          estimated_hours_remaining: estimatedHoursRemaining.toFixed(0),
          estimated_days: estimatedDays,
          estimated_completion_date: this.addDays(new Date(), estimatedDays)
        },
        milestones: this.generateMilestones(openIssues, estimatedDays)
      };
    } catch (error) {
      console.error('Error getting timeline projections:', error);
      return { current_progress: {}, critical_items: {}, projections: {}, milestones: [] };
    }
  }

  /**
   * Get performance metrics
   */
  async getPerformanceMetrics() {
    try {
      // Test results
      const testResults = await db.execute(sql`
        SELECT 
          test_type,
          total_tests,
          passed,
          failed,
          success_rate,
          run_at
        FROM test_results
        ORDER BY run_at DESC
        LIMIT 5
      `);
      
      return {
        recent_test_runs: testResults.rows.map(t => ({
          test_type: t.test_type,
          total: parseInt(t.total_tests),
          passed: parseInt(t.passed),
          failed: parseInt(t.failed),
          success_rate: parseInt(t.success_rate) + '%',
          run_at: t.run_at
        })),
        overall_quality: this.calculateOverallQuality(testResults.rows)
      };
    } catch (error) {
      console.error('Error getting performance metrics:', error);
      return { recent_test_runs: [], overall_quality: 'N/A' };
    }
  }

  /**
   * Get risk assessment
   */
  async getRiskAssessment() {
    try {
      const stats = await db.execute(sql`
        SELECT 
          COUNT(CASE WHEN status = 'open' AND priority = 'critical' THEN 1 END) as critical_open,
          COUNT(CASE WHEN status = 'open' AND priority = 'high' THEN 1 END) as high_open,
          COUNT(CASE WHEN status = 'open' THEN 1 END) as total_open
        FROM issues
      `);
      
      const data = stats.rows[0];
      const criticalOpen = parseInt(data.critical_open) || 0;
      const highOpen = parseInt(data.high_open) || 0;
      const totalOpen = parseInt(data.total_open) || 0;
      
      const risks = [];
      
      if (criticalOpen > 0) {
        risks.push({
          severity: 'CRITICAL',
          description: `${criticalOpen} critical issue(s) open`,
          impact: 'May block case progression',
          mitigation: 'Immediate attention required'
        });
      }
      
      if (highOpen > 5) {
        risks.push({
          severity: 'HIGH',
          description: `${highOpen} high-priority issues pending`,
          impact: 'Could delay timeline',
          mitigation: 'Prioritize high-impact tasks'
        });
      }
      
      if (totalOpen > 50) {
        risks.push({
          severity: 'MEDIUM',
          description: `High issue count (${totalOpen} open)`,
          impact: 'Management overhead',
          mitigation: 'Consider consolidation opportunities'
        });
      }
      
      return {
        risk_level: this.determineRiskLevel(criticalOpen, highOpen, totalOpen),
        identified_risks: risks,
        recommendations: this.generateRecommendations(criticalOpen, highOpen, totalOpen)
      };
    } catch (error) {
      console.error('Error getting risk assessment:', error);
      return { risk_level: 'UNKNOWN', identified_risks: [], recommendations: [] };
    }
  }

  // ===== HELPER METHODS =====

  formatIssueBreakdown(rows) {
    const breakdown = {};
    rows.forEach(row => {
      if (!breakdown[row.issue_type]) {
        breakdown[row.issue_type] = {};
      }
      breakdown[row.issue_type][row.status] = parseInt(row.count);
    });
    return breakdown;
  }

  calculatePercentage(numerator, denominator) {
    if (!denominator || denominator === 0) return '0%';
    return ((numerator / denominator) * 100).toFixed(1) + '%';
  }

  getRatingFromScore(score) {
    if (score >= 80) return 'STRONG';
    if (score >= 60) return 'MODERATE';
    if (score >= 40) return 'WEAK';
    return 'VERY_WEAK';
  }

  addDays(date, days) {
    const result = new Date(date);
    result.setDate(result.getDate() + days);
    return result.toISOString().split('T')[0];
  }

  generateMilestones(openIssues, totalDays) {
    if (totalDays <= 0) return [];
    
    return [
      {
        name: '25% Complete',
        estimated_date: this.addDays(new Date(), Math.ceil(totalDays * 0.25)),
        issues_remaining: Math.ceil(openIssues * 0.75)
      },
      {
        name: '50% Complete',
        estimated_date: this.addDays(new Date(), Math.ceil(totalDays * 0.5)),
        issues_remaining: Math.ceil(openIssues * 0.5)
      },
      {
        name: '75% Complete',
        estimated_date: this.addDays(new Date(), Math.ceil(totalDays * 0.75)),
        issues_remaining: Math.ceil(openIssues * 0.25)
      },
      {
        name: 'Completion',
        estimated_date: this.addDays(new Date(), totalDays),
        issues_remaining: 0
      }
    ];
  }

  calculateOverallQuality(testResults) {
    if (!testResults || testResults.length === 0) return 'N/A';
    const avgSuccess = testResults.reduce((sum, t) => sum + parseInt(t.success_rate), 0) / testResults.length;
    if (avgSuccess >= 90) return 'EXCELLENT';
    if (avgSuccess >= 75) return 'GOOD';
    if (avgSuccess >= 60) return 'FAIR';
    return 'NEEDS_IMPROVEMENT';
  }

  determineRiskLevel(critical, high, total) {
    if (critical > 0) return 'CRITICAL';
    if (high > 5 || total > 100) return 'HIGH';
    if (high > 0 || total > 50) return 'MEDIUM';
    return 'LOW';
  }

  generateRecommendations(critical, high, total) {
    const recommendations = [];
    
    if (critical > 0) {
      recommendations.push('Address critical issues immediately');
    }
    if (high > 3) {
      recommendations.push('Focus on high-priority tasks in parallel');
    }
    if (total > 50) {
      recommendations.push('Review consolidation opportunities');
      recommendations.push('Consider breaking down large features');
    }
    
    return recommendations;
  }

  getDefaultExecutiveSummary() {
    return {
      total_issues: 0,
      open_issues: 0,
      closed_issues: 0,
      completion_rate: '0%',
      total_evidence: 0,
      total_arguments: 0,
      issue_breakdown: {}
    };
  }

  /**
   * Save dashboard to file
   */
  async saveDashboard(outputPath = null) {
    if (!this.dashboardData) {
      await this.generateDashboard();
    }
    
    const defaultPath = path.join(__dirname, '..', 'reports', 'analytics-dashboard.json');
    const filePath = outputPath || defaultPath;
    
    // Ensure reports directory exists
    const dir = path.dirname(filePath);
    if (!fs.existsSync(dir)) {
      fs.mkdirSync(dir, { recursive: true });
    }
    
    fs.writeFileSync(filePath, JSON.stringify(this.dashboardData, null, 2));
    console.log(`\n✅ Dashboard saved to: ${filePath}`);
    
    return filePath;
  }

  /**
   * Display dashboard summary in console
   */
  displaySummary() {
    if (!this.dashboardData) {
      console.log('⚠️  No dashboard data available. Run generateDashboard() first.');
      return;
    }
    
    const { executive_summary, risk_assessment, timeline_projections } = this.dashboardData;
    
    console.log('\n📊 ADVANCED ANALYTICS DASHBOARD');
    console.log('================================\n');
    
    console.log('📈 Executive Summary:');
    console.log(`   Total Issues: ${executive_summary.total_issues}`);
    console.log(`   Open: ${executive_summary.open_issues} | Closed: ${executive_summary.closed_issues}`);
    console.log(`   Completion Rate: ${executive_summary.completion_rate}`);
    console.log(`   Evidence Records: ${executive_summary.total_evidence}`);
    console.log(`   Legal Arguments: ${executive_summary.total_arguments}\n`);
    
    console.log('⚠️  Risk Assessment:');
    console.log(`   Risk Level: ${risk_assessment.risk_level}`);
    console.log(`   Identified Risks: ${risk_assessment.identified_risks.length}`);
    if (risk_assessment.recommendations.length > 0) {
      console.log('   Recommendations:');
      risk_assessment.recommendations.forEach(rec => {
        console.log(`   - ${rec}`);
      });
    }
    console.log('');
    
    if (timeline_projections.projections) {
      console.log('📅 Timeline Projections:');
      console.log(`   Estimated Days to Completion: ${timeline_projections.projections.estimated_days}`);
      console.log(`   Target Date: ${timeline_projections.projections.estimated_completion_date}`);
    }
    
    console.log('\n');
  }
}

// CLI support
if (require.main === module) {
  const dashboard = new AnalyticsDashboard();
  
  dashboard.generateDashboard()
    .then(() => dashboard.displaySummary())
    .then(() => dashboard.saveDashboard())
    .then(() => {
      console.log('✅ Dashboard generation complete!\n');
      process.exit(0);
    })
    .catch(error => {
      console.error('❌ Error generating dashboard:', error);
      process.exit(1);
    });
}

module.exports = AnalyticsDashboard;
