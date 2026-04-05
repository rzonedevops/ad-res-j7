# Analytics Dashboard Reports

This directory contains generated analytics dashboard files for Case 2025-137857.

## Generated Files

- `analytics-dashboard.json` - Dashboard data in JSON format
- `analytics-dashboard.html` - Interactive HTML visualization
- `sample-analytics-dashboard.json` - Sample data for testing (not committed)

## Generation

Generate fresh dashboard data:

```bash
npm run analytics:generate
```

Create HTML visualization:

```bash
npm run analytics:html
```

## Viewing

Open the HTML dashboard in your browser:

```bash
# macOS
open reports/analytics-dashboard.html

# Linux
xdg-open reports/analytics-dashboard.html

# Windows
start reports/analytics-dashboard.html
```

## Note

Dashboard files are regenerated dynamically and are excluded from version control (see `.gitignore`). This ensures:
- Fresh data on each generation
- No merge conflicts
- Smaller repository size
- Current metrics always available

## Documentation

For detailed information, see [Analytics Dashboard Guide](../docs/ANALYTICS_DASHBOARD_GUIDE.md).
