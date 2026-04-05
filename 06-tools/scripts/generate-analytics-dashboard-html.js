#!/usr/bin/env node

/**
 * Analytics Dashboard HTML Generator
 * Creates an interactive HTML visualization of the analytics dashboard
 */

const fs = require('fs');
const path = require('path');

class DashboardHTMLGenerator {
  
  /**
   * Generate HTML dashboard from JSON data
   */
  static generateHTML(dashboardData, outputPath = null) {
    const html = `<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Advanced Analytics Dashboard - Case ${dashboardData.metadata.case_id}</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, 'Helvetica Neue', Arial, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: #333;
            padding: 20px;
            min-height: 100vh;
        }
        
        .container {
            max-width: 1400px;
            margin: 0 auto;
        }
        
        .header {
            background: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            margin-bottom: 20px;
        }
        
        .header h1 {
            color: #667eea;
            margin-bottom: 10px;
        }
        
        .header .meta {
            color: #666;
            font-size: 14px;
        }
        
        .dashboard-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 20px;
            margin-bottom: 20px;
        }
        
        .card {
            background: white;
            border-radius: 10px;
            padding: 20px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }
        
        .card h2 {
            color: #667eea;
            font-size: 18px;
            margin-bottom: 15px;
            padding-bottom: 10px;
            border-bottom: 2px solid #f0f0f0;
        }
        
        .metric {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 10px 0;
            border-bottom: 1px solid #f5f5f5;
        }
        
        .metric:last-child {
            border-bottom: none;
        }
        
        .metric-label {
            font-size: 14px;
            color: #666;
        }
        
        .metric-value {
            font-size: 18px;
            font-weight: bold;
            color: #333;
        }
        
        .metric-value.large {
            font-size: 36px;
            color: #667eea;
        }
        
        .progress-bar {
            width: 100%;
            height: 20px;
            background: #f0f0f0;
            border-radius: 10px;
            overflow: hidden;
            margin: 10px 0;
        }
        
        .progress-fill {
            height: 100%;
            background: linear-gradient(90deg, #667eea 0%, #764ba2 100%);
            transition: width 0.3s ease;
        }
        
        .risk-badge {
            display: inline-block;
            padding: 5px 15px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: bold;
            text-transform: uppercase;
        }
        
        .risk-critical { background: #f44336; color: white; }
        .risk-high { background: #ff9800; color: white; }
        .risk-medium { background: #ffc107; color: #333; }
        .risk-low { background: #4caf50; color: white; }
        
        .list {
            list-style: none;
        }
        
        .list-item {
            padding: 10px;
            margin: 5px 0;
            background: #f9f9f9;
            border-radius: 5px;
            font-size: 14px;
        }
        
        .list-item.priority-critical {
            border-left: 4px solid #f44336;
        }
        
        .list-item.priority-high {
            border-left: 4px solid #ff9800;
        }
        
        .list-item.priority-medium {
            border-left: 4px solid #ffc107;
        }
        
        .table {
            width: 100%;
            border-collapse: collapse;
            margin: 10px 0;
        }
        
        .table th {
            background: #f5f5f5;
            padding: 10px;
            text-align: left;
            font-size: 12px;
            color: #666;
            text-transform: uppercase;
        }
        
        .table td {
            padding: 10px;
            border-bottom: 1px solid #f0f0f0;
            font-size: 14px;
        }
        
        .table tr:hover {
            background: #f9f9f9;
        }
        
        .chart-placeholder {
            background: #f5f5f5;
            height: 200px;
            border-radius: 5px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: #999;
            font-size: 14px;
        }
        
        .milestone {
            padding: 15px;
            margin: 10px 0;
            background: linear-gradient(90deg, #f5f5f5 0%, white 100%);
            border-left: 4px solid #667eea;
            border-radius: 5px;
        }
        
        .milestone-date {
            font-size: 12px;
            color: #666;
        }
        
        .milestone-name {
            font-size: 16px;
            font-weight: bold;
            color: #333;
            margin: 5px 0;
        }
        
        .footer {
            background: white;
            padding: 20px;
            border-radius: 10px;
            text-align: center;
            color: #666;
            font-size: 14px;
            margin-top: 20px;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>📊 Advanced Analytics Dashboard</h1>
            <div class="meta">
                Case ${dashboardData.metadata.case_id} | 
                Generated: ${new Date(dashboardData.metadata.generated_at).toLocaleString()} | 
                Version: ${dashboardData.metadata.dashboard_version}
            </div>
        </div>
        
        ${this.renderExecutiveSummary(dashboardData.executive_summary)}
        
        ${this.renderRiskAssessment(dashboardData.risk_assessment)}
        
        ${this.renderIssueAnalytics(dashboardData.issue_analytics)}
        
        ${this.renderLegalArgumentStrength(dashboardData.legal_argument_strength)}
        
        ${this.renderEvidenceAnalytics(dashboardData.evidence_analytics)}
        
        ${this.renderCrossReferenceNetwork(dashboardData.cross_reference_network)}
        
        ${this.renderTimelineProjections(dashboardData.timeline_projections)}
        
        ${this.renderPerformanceMetrics(dashboardData.performance_metrics)}
        
        <div class="footer">
            Advanced Analytics Dashboard &copy; 2025 | Legal Case Management System
        </div>
    </div>
</body>
</html>`;
    
    const defaultPath = path.join(__dirname, '..', 'reports', 'analytics-dashboard.html');
    const filePath = outputPath || defaultPath;
    
    // Ensure directory exists
    const dir = path.dirname(filePath);
    if (!fs.existsSync(dir)) {
      fs.mkdirSync(dir, { recursive: true });
    }
    
    fs.writeFileSync(filePath, html);
    console.log(`\n✅ HTML Dashboard generated: ${filePath}`);
    
    return filePath;
  }
  
  static renderExecutiveSummary(summary) {
    const completionPercentage = parseFloat(summary.completion_rate);
    
    return `
        <div class="dashboard-grid">
            <div class="card">
                <h2>📈 Executive Summary</h2>
                <div class="metric">
                    <span class="metric-label">Total Issues</span>
                    <span class="metric-value large">${summary.total_issues}</span>
                </div>
                <div class="metric">
                    <span class="metric-label">Open</span>
                    <span class="metric-value">${summary.open_issues}</span>
                </div>
                <div class="metric">
                    <span class="metric-label">Closed</span>
                    <span class="metric-value">${summary.closed_issues}</span>
                </div>
                <div class="metric">
                    <span class="metric-label">Completion Rate</span>
                    <span class="metric-value">${summary.completion_rate}</span>
                </div>
                <div class="progress-bar">
                    <div class="progress-fill" style="width: ${completionPercentage}%"></div>
                </div>
            </div>
            
            <div class="card">
                <h2>📚 Evidence & Arguments</h2>
                <div class="metric">
                    <span class="metric-label">Evidence Records</span>
                    <span class="metric-value">${summary.total_evidence}</span>
                </div>
                <div class="metric">
                    <span class="metric-label">Legal Arguments</span>
                    <span class="metric-value">${summary.total_arguments}</span>
                </div>
            </div>
        </div>`;
  }
  
  static renderRiskAssessment(risk) {
    const riskClass = risk.risk_level.toLowerCase().replace('_', '-');
    
    return `
        <div class="card">
            <h2>⚠️ Risk Assessment</h2>
            <div class="metric">
                <span class="metric-label">Overall Risk Level</span>
                <span class="risk-badge risk-${riskClass}">${risk.risk_level}</span>
            </div>
            
            ${risk.identified_risks.length > 0 ? `
                <h3 style="margin: 20px 0 10px 0; font-size: 14px; color: #666;">Identified Risks</h3>
                <ul class="list">
                    ${risk.identified_risks.map(r => `
                        <li class="list-item priority-${r.severity.toLowerCase()}">
                            <strong>${r.description}</strong><br>
                            <small>Impact: ${r.impact} | Mitigation: ${r.mitigation}</small>
                        </li>
                    `).join('')}
                </ul>
            ` : ''}
            
            ${risk.recommendations.length > 0 ? `
                <h3 style="margin: 20px 0 10px 0; font-size: 14px; color: #666;">Recommendations</h3>
                <ul class="list">
                    ${risk.recommendations.map(rec => `
                        <li class="list-item">${rec}</li>
                    `).join('')}
                </ul>
            ` : ''}
        </div>`;
  }
  
  static renderIssueAnalytics(analytics) {
    return `
        <div class="dashboard-grid">
            <div class="card">
                <h2>📋 Feature Issues</h2>
                ${analytics.feature_issues.length > 0 ? `
                    <table class="table">
                        <thead>
                            <tr>
                                <th>Title</th>
                                <th>Priority</th>
                                <th>Tasks</th>
                                <th>Progress</th>
                            </tr>
                        </thead>
                        <tbody>
                            ${analytics.feature_issues.slice(0, 10).map(f => `
                                <tr>
                                    <td>${f.title.substring(0, 40)}...</td>
                                    <td><span class="risk-badge risk-${f.priority === 'critical' ? 'critical' : f.priority === 'high' ? 'high' : 'medium'}">${f.priority}</span></td>
                                    <td>${f.completed_tasks}/${f.task_count}</td>
                                    <td>${f.completion_rate}</td>
                                </tr>
                            `).join('')}
                        </tbody>
                    </table>
                ` : '<p style="color: #999;">No feature issues found</p>'}
            </div>
            
            <div class="card">
                <h2>🎯 Priority Distribution</h2>
                ${analytics.priority_distribution.map(p => `
                    <div class="metric">
                        <span class="metric-label">${p.priority || 'Unspecified'}</span>
                        <span class="metric-value">${p.total} (${p.completion_rate})</span>
                    </div>
                `).join('')}
            </div>
        </div>`;
  }
  
  static renderLegalArgumentStrength(legalArguments) {
    return `
        <div class="card">
            <h2>⚖️ Legal Argument Strength</h2>
            ${legalArguments.length > 0 ? `
                <table class="table">
                    <thead>
                        <tr>
                            <th>Argument</th>
                            <th>Type</th>
                            <th>Linked Issues</th>
                            <th>Avg Strength</th>
                            <th>Rating</th>
                        </tr>
                    </thead>
                    <tbody>
                        ${legalArguments.map(arg => `
                            <tr>
                                <td>${arg.name}</td>
                                <td>${arg.type}</td>
                                <td>${arg.linked_issues}</td>
                                <td>${arg.avg_strength}</td>
                                <td><span class="risk-badge risk-${arg.strength_rating === 'STRONG' ? 'low' : arg.strength_rating === 'MODERATE' ? 'medium' : 'high'}">${arg.strength_rating}</span></td>
                            </tr>
                        `).join('')}
                    </tbody>
                </table>
            ` : '<p style="color: #999;">No legal arguments found</p>'}
        </div>`;
  }
  
  static renderEvidenceAnalytics(evidence) {
    return `
        <div class="dashboard-grid">
            <div class="card">
                <h2>📂 Evidence Collection</h2>
                <div class="metric">
                    <span class="metric-label">Total Evidence</span>
                    <span class="metric-value large">${evidence.total_evidence}</span>
                </div>
                
                ${evidence.by_type.length > 0 ? `
                    <h3 style="margin: 20px 0 10px 0; font-size: 14px; color: #666;">By Type</h3>
                    ${evidence.by_type.map(e => `
                        <div class="metric">
                            <span class="metric-label">${e.type}</span>
                            <span class="metric-value">${e.count} (${e.file_rate} with files)</span>
                        </div>
                    `).join('')}
                ` : ''}
            </div>
            
            <div class="card">
                <h2>🆕 Recent Evidence</h2>
                ${evidence.recent_additions.length > 0 ? `
                    <ul class="list">
                        ${evidence.recent_additions.map(e => `
                            <li class="list-item">
                                <strong>${e.type}</strong><br>
                                <small>${e.description}</small>
                            </li>
                        `).join('')}
                    </ul>
                ` : '<p style="color: #999;">No recent evidence</p>'}
            </div>
        </div>`;
  }
  
  static renderCrossReferenceNetwork(xref) {
    return `
        <div class="card">
            <h2>🔗 Cross-Reference Network</h2>
            
            ${xref.by_type.length > 0 ? `
                <h3 style="margin: 20px 0 10px 0; font-size: 14px; color: #666;">By Type</h3>
                ${xref.by_type.map(x => `
                    <div class="metric">
                        <span class="metric-label">${x.type}</span>
                        <span class="metric-value">${x.count} refs (${x.unique_issues} issues)</span>
                    </div>
                `).join('')}
            ` : ''}
            
            ${xref.most_referenced.length > 0 ? `
                <h3 style="margin: 20px 0 10px 0; font-size: 14px; color: #666;">Most Referenced Items</h3>
                <table class="table">
                    <thead>
                        <tr>
                            <th>Type</th>
                            <th>Title</th>
                            <th>Issues</th>
                        </tr>
                    </thead>
                    <tbody>
                        ${xref.most_referenced.map(x => `
                            <tr>
                                <td>${x.type}</td>
                                <td>${x.title || x.id}</td>
                                <td>${x.issue_count}</td>
                            </tr>
                        `).join('')}
                    </tbody>
                </table>
            ` : ''}
        </div>`;
  }
  
  static renderTimelineProjections(timeline) {
    return `
        <div class="dashboard-grid">
            <div class="card">
                <h2>📅 Timeline Projections</h2>
                ${timeline.projections && timeline.projections.estimated_days ? `
                    <div class="metric">
                        <span class="metric-label">Estimated Days to Completion</span>
                        <span class="metric-value large">${timeline.projections.estimated_days}</span>
                    </div>
                    <div class="metric">
                        <span class="metric-label">Target Date</span>
                        <span class="metric-value">${timeline.projections.estimated_completion_date}</span>
                    </div>
                    <div class="metric">
                        <span class="metric-label">Avg Hours per Issue</span>
                        <span class="metric-value">${timeline.projections.avg_completion_hours}</span>
                    </div>
                ` : '<p style="color: #999;">No projection data available</p>'}
            </div>
            
            <div class="card">
                <h2>🎯 Milestones</h2>
                ${timeline.milestones && timeline.milestones.length > 0 ? timeline.milestones.map(m => `
                    <div class="milestone">
                        <div class="milestone-name">${m.name}</div>
                        <div class="milestone-date">${m.estimated_date}</div>
                        ${m.issues_remaining !== undefined ? `<small>${m.issues_remaining} issues remaining</small>` : ''}
                    </div>
                `).join('') : '<p style="color: #999;">No milestones</p>'}
            </div>
        </div>`;
  }
  
  static renderPerformanceMetrics(perf) {
    return `
        <div class="card">
            <h2>🔍 Performance Metrics</h2>
            <div class="metric">
                <span class="metric-label">Overall Quality</span>
                <span class="metric-value">${perf.overall_quality}</span>
            </div>
            
            ${perf.recent_test_runs.length > 0 ? `
                <h3 style="margin: 20px 0 10px 0; font-size: 14px; color: #666;">Recent Test Runs</h3>
                <table class="table">
                    <thead>
                        <tr>
                            <th>Test Type</th>
                            <th>Total</th>
                            <th>Passed</th>
                            <th>Failed</th>
                            <th>Success Rate</th>
                        </tr>
                    </thead>
                    <tbody>
                        ${perf.recent_test_runs.map(t => `
                            <tr>
                                <td>${t.test_type}</td>
                                <td>${t.total}</td>
                                <td>${t.passed}</td>
                                <td>${t.failed}</td>
                                <td>${t.success_rate}</td>
                            </tr>
                        `).join('')}
                    </tbody>
                </table>
            ` : '<p style="color: #999;">No test results available</p>'}
        </div>`;
  }
}

// CLI support
if (require.main === module) {
  const dashboardJsonPath = process.argv[2] || path.join(__dirname, '..', 'reports', 'analytics-dashboard.json');
  
  if (!fs.existsSync(dashboardJsonPath)) {
    console.error(`❌ Dashboard JSON not found: ${dashboardJsonPath}`);
    console.log('💡 Run `npm run analytics:generate` first to create the dashboard data.');
    process.exit(1);
  }
  
  const dashboardData = JSON.parse(fs.readFileSync(dashboardJsonPath, 'utf8'));
  DashboardHTMLGenerator.generateHTML(dashboardData);
  
  console.log('✅ HTML dashboard generation complete!\n');
}

module.exports = DashboardHTMLGenerator;
