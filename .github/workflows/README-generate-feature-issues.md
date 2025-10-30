# Generate Feature-Level Issues from need-classification.md

This workflow generates feature-level issues from the hierarchical structure defined in `todo/need-classification.md` and automatically links existing task-level issues as sub-issues.

## Overview

The `need-classification.md` file contains a hierarchical structure:

```
Legal Argument (Strategy)
└── Feature (Proves/disproves argument)
    └── Paragraphs (Fact groupings)
        └── Tasks (Actionable items with existing issue numbers)
```

This workflow:
1. **Parses** `todo/need-classification.md` to extract features and their metadata
2. **Creates** feature-level issues on GitHub (one per Feature section)
3. **Links** existing task-level issues as sub-issues using GitHub tasklists

## Usage

### Running the Workflow

Navigate to **Actions** → **Generate Feature-Level Issues from need-classification.md** → **Run workflow**

#### Parameters

- **dry_run**: 
  - `true` (default) - Shows what would be created without actually creating issues
  - `false` - Creates the feature issues on GitHub

### Manual Usage

You can also run the scripts manually:

```bash
# Parse need-classification.md
node scripts/parse-need-classification.js todo/need-classification.md parsed-features.json

# Generate feature issues (dry-run)
node scripts/generate-feature-issues.js parsed-features.json --dry-run

# Generate feature issues (live)
node scripts/generate-feature-issues.js parsed-features.json
```

## What Gets Created

Each feature-level issue includes:

### Title
```
[FEATURE] <Feature Name>
```

### Body Structure

1. **Priority and Description**
   - Feature priority level
   - Feature description from need-classification.md

2. **Legal Argument Context**
   - Parent legal argument this feature supports

3. **Paragraph Structure**
   - Overview of paragraphs within the feature
   - Rank and weight for each paragraph

4. **Task Issues (as Sub-Issues)**
   - All existing task-level issues linked using GitHub tasklists
   - Grouped by paragraph
   - Format: `- [ ] #<issue-number> - <description>`

5. **Metadata**
   - Total task issues
   - Paragraph count
   - Source file reference

### Example Feature Issue

```markdown
**Priority:** high

Validate workflow automation handles edge cases and special characters correctly

**Legal Argument:** Workflow Testing & Quality Assurance

---

## Paragraph Structure

### Paragraph 1: Unit & Integration Tests
- **Rank:** 1 (1 = highest influence)
- **Weight:** 100/100
- **Tasks:** 4

---

## Task Issues

### Unit & Integration Tests

- [ ] #2766 - Create unit tests for markdown parsing logic
- [ ] #2767 - Implement integration tests for GitHub API interaction
- [ ] #2768 - Add regression tests to prevent workflow breaking changes
- [ ] #2777 - Create validation tests for workflow changes

---

**Total Task Issues:** 17
**Paragraphs:** 3

*This feature issue was automatically generated from todo/need-classification.md*
```

## Output

The workflow produces:

- **Feature Issues**: Created on GitHub with appropriate labels
- **Artifacts**:
  - `parsed-features.json` - Structured data from need-classification.md
  - `feature-issues-report.json` - Summary of created issues

## Benefits

1. **Hierarchical Organization**: Maintains the legal argument → feature → paragraph → task structure
2. **Sub-Issue Tracking**: Automatically links task-level issues to their parent features
3. **Progress Visibility**: GitHub tasklists show completion status at the feature level
4. **Consolidation**: Reduces issue clutter by grouping related tasks under features
5. **Metadata Preservation**: Captures rank, weight, and paragraph information

## Labels Applied

- `feature` - Marks issue as feature-level
- `needs-triage` - Indicates new issue requiring review

## Integration with Hierarchical Issue Framework

This workflow complements the existing hierarchical issue system:

- **Legal Arguments** (Strategy level) - Not created as issues
- **Features** (Proves/disproves) - Created by this workflow
- **Paragraphs** (Components) - Documented within feature issues
- **Tasks** (Actionable) - Existing issues, linked as sub-issues

## Troubleshooting

### No issues created in dry-run mode
This is expected. Set `dry_run: false` to create issues.

### Parse errors
Check that `todo/need-classification.md` follows the expected format:
- Legal Arguments start with `## Legal Argument:`
- Features start with `### Feature:`
- Paragraphs start with `#### Paragraph N:`
- Tasks include `- Issue: [#NNNN]` on the line following the task

### Rate limiting
The script includes a 1-second delay between issue creation to avoid GitHub API rate limits.

## Related Documentation

- [Hierarchical Issues Summary](../HIERARCHICAL_ISSUES_SUMMARY.md)
- [Hierarchical Issues Quick Start](../HIERARCHICAL_ISSUES_QUICKSTART.md)
- [Issue Consolidation Guide](../ISSUE_CONSOLIDATION_GUIDE.md)

## Scripts

- `scripts/parse-need-classification.js` - Parses need-classification.md
- `scripts/generate-feature-issues.js` - Creates feature issues on GitHub
