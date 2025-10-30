# Label Management Guide

## Overview

This repository uses a comprehensive labeling system to organize issues according to the hierarchical legal framework. To prevent issues with missing labels during automated issue creation, we provide tools to ensure all required labels exist.

## Ensure Labels Script

### Location
`scripts/ensure-labels.sh`

### Purpose
Creates GitHub labels if they don't already exist in the repository, preventing "label not found" errors during issue creation.

### Usage

#### Basic Usage (Default Labels)
```bash
./scripts/ensure-labels.sh
```
This creates a default set of labels commonly used across the repository.

#### Custom Labels
```bash
./scripts/ensure-labels.sh "label-name:color:description" "another-label:color:description"
```

#### Example
```bash
./scripts/ensure-labels.sh \
  "feature:0052CC:Feature request" \
  "needs-triage:FFCC00:Requires triage"
```

### Label Format
Each label specification follows the format: `name:color:description`

- **name**: The label name (can include spaces, colons, etc.)
- **color**: Hex color code without the # (e.g., "0052CC")
- **description**: Label description

### Default Labels

The script includes these default labels when called without arguments:

#### Issue Type Labels
- `feature` - Feature request (blue)
- `bug` - Something isn't working (red)
- `enhancement` - New feature or request (light blue)
- `documentation` - Documentation improvements (blue)
- `todo` - To do items (blue)
- `task` - Task item (light blue)

#### Hierarchical Labels
- `hierarchical-task` - Hierarchical task (light green)
- `needs-triage` - Requires triage (yellow)

#### Priority Labels
- `priority: critical` - Critical priority (red)
- `priority: high` - High priority (orange)
- `priority: medium` - Medium priority (yellow)
- `priority: low` - Low priority (green)

#### Weight Labels
- `weight-high` - High weight 90-100 (pink)
- `weight-medium` - Medium weight 60-89 (orange)
- `weight-low` - Low weight 0-59 (yellow)

#### Rank Labels
- `rank-1` - Rank 1 highest (dark blue)
- `rank-2` - Rank 2 (blue)
- `rank-3` - Rank 3 (lighter blue)

#### Legal Labels
- `legal-defense` - Legal defense argument (indigo)
- `legal-counterclaim` - Legal counterclaim (blue)
- `legal-evidence` - Legal evidence (light purple)

### GitHub Actions Integration

The script is integrated into workflows to automatically create required labels before issue creation.

#### Example Workflow Usage
```yaml
- name: Ensure required labels exist
  env:
    GH_TOKEN: ${{ secrets.GITHUB_TOKEN }}
  run: |
    # Create only the labels needed for this workflow
    ./scripts/ensure-labels.sh \
      "feature:0052CC:Feature request" \
      "needs-triage:FFCC00:Requires triage"
```

### Error Handling

The script includes robust error handling:
- ✅ Creates labels if they don't exist
- ⚠️ Skips labels that already exist (no error)
- ❌ Reports failed label creation
- 📊 Provides summary of actions taken

### Exit Codes
- `0` - Success (all labels created or already exist)
- `1` - Failure (one or more labels failed to create)

### Requirements
- GitHub CLI (`gh`) must be installed
- `GH_TOKEN` environment variable should be set (for CI/CD)
- Authenticated with GitHub (run `gh auth login` locally)

### Troubleshooting

#### Error: "GitHub CLI (gh) is not installed"
Install GitHub CLI from https://cli.github.com/

#### Error: Authentication issues
```bash
# For local development
gh auth login

# For GitHub Actions (automatic)
env:
  GH_TOKEN: ${{ secrets.GITHUB_TOKEN }}
```

#### Label creation fails
Check that:
1. You have write access to the repository
2. `GH_TOKEN` has `issues: write` permission
3. Label name doesn't contain invalid characters

### Best Practices

1. **Create labels before issue creation**: Always run this script before workflows that create issues
2. **Use consistent colors**: Follow the default color scheme for consistency
3. **Document custom labels**: Add new labels to the default set if they're commonly used
4. **Test locally**: Run the script locally with `--dry-run` to test (future feature)

### Adding New Labels

To add new labels to the default set, edit `scripts/ensure-labels.sh` and add to the `DEFAULT_LABELS` array:

```bash
DEFAULT_LABELS=(
    # ... existing labels ...
    "new-label:color:description"
)
```

### Related Files
- `.github/workflows/generate-feature-issues.yml` - Uses this script
- `scripts/generate-feature-issues.js` - Creates issues with labels
- `docs/LABEL_HANDLING_GUIDE.md` - Label handling in scripts

### See Also
- [Hierarchical Issues Guide](../HIERARCHICAL_ISSUES_QUICKSTART.md)
- [Issue Consolidation Guide](../ISSUE_CONSOLIDATION_GUIDE.md)
- [Copilot Instructions](../.github/copilot-instructions.md)
