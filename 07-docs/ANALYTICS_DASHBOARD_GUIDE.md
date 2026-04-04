# Advanced Analytics Dashboard

## Overview

The Advanced Analytics Dashboard provides comprehensive insights into the legal case management system for Case 2025-137857. It aggregates data from multiple sources including:

- Legal arguments and strategies
- Issue tracking and completion
- Evidence collection status
- Cross-reference networks
- Timeline projections
- Performance metrics
- Risk assessment

## Quick Start

### 1. Generate Dashboard Data

```bash
npm run analytics:generate
```

This command:
- Queries the database for current status
- Aggregates metrics across all modules
- Generates `reports/analytics-dashboard.json`
- Displays a summary in the console

### 2. Generate HTML Visualization

```bash
npm run analytics:html
```

This creates an interactive HTML dashboard at `reports/analytics-dashboard.html`.

### 3. View the Dashboard

Open `reports/analytics-dashboard.html` in your web browser to see:
- Executive summary with key metrics
- Visual progress indicators
- Risk assessment and recommendations
- Detailed analytics by category
- Timeline projections and milestones

## Dashboard Sections

### 📈 Executive Summary

Key metrics at a glance:
- Total issues (open/closed)
- Completion rate
- Evidence count
- Legal arguments count

### ⚠️ Risk Assessment

- Overall risk level (CRITICAL/HIGH/MEDIUM/LOW)
- Identified risks with severity levels
- Impact analysis
- Mitigation recommendations

### 📋 Issue Analytics

- Feature issues breakdown
- Task completion rates
- Priority distribution
- Rank and weight analysis

### ⚖️ Legal Argument Strength

- Argument effectiveness ratings
- Linked issues per argument
- Average strength scores
- Completion rates

### 📂 Evidence Collection

- Total evidence records
- Evidence by type
- Recent additions
- File attachment rates

### 🔗 Cross-Reference Network

- Cross-references by type
- Most referenced items
- Consolidation opportunities
- Network density metrics

### 📅 Timeline Projections

- Estimated completion date
- Days to completion
- Milestone tracking
- Critical path analysis

### 🔍 Performance Metrics

- Test results history
- Success rates
- Quality assessment
- System performance

## Running Tests

```bash
npm run test:analytics-dashboard
```

The test suite validates:
- Dashboard data generation
- Metric calculations
- Helper functions
- File I/O operations
- Data structure integrity

## Database Requirements

The analytics dashboard requires a PostgreSQL database connection. Configure your `.env` file:

```env
DATABASE_URL=postgres://user:password@host:port/database
```

See `.env.example` for more details.

### Without Database

The dashboard can run in limited mode (helper functions only) without a database connection. This is useful for:
- Unit testing calculation logic
- Development without database access
- CI/CD environments

## API Usage

### Programmatic Access

```javascript
const AnalyticsDashboard = require('./db/analytics-dashboard');

const dashboard = new AnalyticsDashboard();

// Generate dashboard data
const data = await dashboard.generateDashboard();

// Display summary
dashboard.displaySummary();

// Save to file
await dashboard.saveDashboard('path/to/output.json');
```

### HTML Generation

```javascript
const DashboardHTMLGenerator = require('./scripts/generate-analytics-dashboard-html');

// Load JSON data
const data = require('./reports/analytics-dashboard.json');

// Generate HTML
DashboardHTMLGenerator.generateHTML(data, 'path/to/output.html');
```

## Data Structure

The dashboard JSON contains:

```json
{
  "metadata": {
    "generated_at": "ISO 8601 timestamp",
    "dashboard_version": "1.0.0",
    "case_id": "2025-137857"
  },
  "executive_summary": { ... },
  "issue_analytics": { ... },
  "legal_argument_strength": [ ... ],
  "evidence_analytics": { ... },
  "cross_reference_network": { ... },
  "timeline_projections": { ... },
  "performance_metrics": { ... },
  "risk_assessment": { ... }
}
```

## Integration with Existing Systems

The analytics dashboard integrates with:

1. **Hierarchical Issue Manager** (`db/hierarchical-issue-manager.js`)
   - Feature issues, paragraphs, and tasks
   - Rank ordering and weighting

2. **Cross-Reference System** (`db/issue-consolidator.js`)
   - Evidence linking
   - Consolidation detection

3. **Hypergraph Manager** (`db/hypergraph-manager.js`)
   - Evidence networks
   - Relationship mapping

4. **Legal Attention Engine** (Python modules)
   - Burden of proof analysis
   - Argument strength calculation

## Customization

### Adding New Metrics

To add custom metrics:

1. Add a new method to `AnalyticsDashboard` class
2. Call it from `generateDashboard()`
3. Update the HTML generator to display it
4. Add tests for the new metric

Example:

```javascript
async getCustomMetric() {
  try {
    const result = await db.execute(sql`SELECT ...`);
    return result.rows;
  } catch (error) {
    console.error('Error getting custom metric:', error);
    return [];
  }
}
```

### Styling the HTML Dashboard

Modify the `<style>` section in `generate-analytics-dashboard-html.js` to customize:
- Colors and themes
- Layout and spacing
- Card styles
- Typography

## Troubleshooting

### Database Connection Issues

If you see "DATABASE_URL must be set":
1. Create a `.env` file in the project root
2. Copy from `.env.example`
3. Update with your database credentials

### No Data in Dashboard

If the dashboard shows zeros:
1. Ensure database migrations have run: `npm run db:migrate`
2. Populate test data if needed
3. Check database connection
4. Review console errors

### HTML Not Generating

If `npm run analytics:html` fails:
1. Run `npm run analytics:generate` first
2. Check that `reports/analytics-dashboard.json` exists
3. Verify file permissions

## Best Practices

1. **Regular Generation**: Generate dashboards regularly (daily/weekly) to track progress
2. **Version Control**: Exclude `reports/*.json` and `reports/*.html` from git (already in `.gitignore`)
3. **Archival**: Keep historical dashboards for trend analysis
4. **Monitoring**: Set up automated dashboard generation in CI/CD
5. **Review**: Use dashboards in team meetings for status updates

## Future Enhancements

Planned features:
- Interactive charts and graphs
- Trend analysis over time
- Export to PDF
- Email reports
- Real-time updates
- Drill-down capabilities
- Custom date ranges
- Comparative analytics

## Support

For issues or questions:
1. Check this documentation
2. Review test cases for examples
3. Examine the source code comments
4. Refer to existing dashboard implementations in `reports/`

## Related Documentation

- [Hierarchical Issues Guide](../db/HIERARCHICAL_ISSUES_GUIDE.md)
- [Cross-Reference Guide](../db/CROSS_REFERENCE_GUIDE.md)
- [Hypergraph Guide](../db/HYPERGRAPH_GUIDE.md)
- [Database Setup](../db/README.md)
