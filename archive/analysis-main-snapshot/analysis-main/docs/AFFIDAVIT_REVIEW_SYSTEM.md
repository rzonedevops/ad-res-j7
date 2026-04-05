# Affidavit Review System Documentation

## Overview

The Affidavit Review System is a critical safety mechanism that ensures legal documents containing critical or high-priority evidence updates receive proper review before filing. This system was implemented to address the issue of automatic affidavit enhancement without adequate legal oversight.

## Problem Statement

Previously, the affidavit enhancement system would automatically process and enhance legal documents with evidence updates without requiring manual review. This posed significant legal risks when:

- Critical evidence updates (containing keywords like "fraud", "murder", "criminal") were incorporated
- Multiple high-priority evidence updates were applied
- Documents needed legal compliance validation before filing

## Solution: Automated Review Requirement System

### Key Features

1. **Automatic Detection**: Identifies documents requiring review based on evidence update severity
2. **Review Status Tracking**: Maintains detailed status for each document requiring review  
3. **Legal Compliance Validation**: Ensures documents are approved before filing
4. **Approval Workflow**: Provides tools for reviewers to approve/reject documents
5. **Comprehensive Reporting**: Generates alerts and status reports

### Review Trigger Criteria

Documents require legal review when they contain:

- **Critical Evidence Updates**: Any updates with "critical" priority (keywords: fraud, murder, criminal, etc.)
- **Multiple High-Priority Updates**: 3 or more "high" priority updates (configurable threshold)

### Review Workflow

```
1. Evidence Update Detected
   ↓
2. Affidavit Enhanced Automatically  
   ↓
3. Review Requirements Assessed
   ↓
4. [IF REVIEW REQUIRED]
   ↓
5. Review Status Created
   ↓  
6. Legal Review Alert Generated
   ↓
7. Manual Legal Review
   ↓
8. Approval/Rejection Decision
   ↓
9. Document Ready for Filing (if approved)
```

## Configuration

The review system is configured through the `review_settings` section in `config/affidavit_enhancement.json`:

```json
{
  "review_settings": {
    "require_review_for_critical": true,
    "require_review_for_multiple_high": true,  
    "high_priority_threshold": 3,
    "auto_create_github_issue": true,
    "prevent_filing_without_review": true
  }
}
```

### Configuration Options

| Setting | Description | Default |
|---------|-------------|---------|
| `require_review_for_critical` | Require review for any critical updates | `true` |
| `require_review_for_multiple_high` | Require review for multiple high priority updates | `true` |
| `high_priority_threshold` | Number of high priority updates that trigger review | `3` |
| `auto_create_github_issue` | Automatically create GitHub issues for reviews | `true` |
| `prevent_filing_without_review` | Prevent filing documents without completed review | `true` |

## File Organization

The review system creates the following directory structure:

```
project/
├── enhanced_affidavits/          # Enhanced documents
├── backups/                      # Original document backups  
├── review_required/              # Review status tracking files
│   ├── document1_review_status.json
│   ├── document2_review_status.json
│   └── ...
└── CRITICAL_EVIDENCE_REVIEW_ALERT.md  # Generated review alerts
```

## Review Status Data Structure

Each document requiring review has a status file containing:

```json
{
  "affidavit_path": "path/to/original/document.md",
  "enhanced_path": "path/to/enhanced/document.md", 
  "critical_updates": 2,
  "high_priority_updates": 3,
  "total_updates": 8,
  "requires_review": true,
  "review_completed": false,
  "reviewer": null,
  "review_date": null,
  "approval_status": "pending",
  "review_comments": "",
  "legal_compliance_checked": false,
  "ready_for_filing": false
}
```

### Status Values

- **approval_status**: `"pending"`, `"approved"`, `"rejected"`, `"needs_revision"`
- **ready_for_filing**: `true` only when approved and compliance checked

## Usage

### Running Enhancement with Review System

```bash
# Standard enhancement (includes review system)
python scripts/enhance_affidavits.py --verbose

# Critical updates only  
python scripts/enhance_affidavits.py --priority-filter critical

# Dry run to see what would be reviewed
python scripts/enhance_affidavits.py --dry-run --verbose
```

### Managing Reviews

#### List Pending Reviews
```bash
python scripts/manage_affidavit_reviews.py --list
```

#### Interactive Review Process
```bash
python scripts/manage_affidavit_reviews.py --review "document.md" --reviewer "Legal Counsel Name"
```

#### Direct Approval
```bash  
python scripts/manage_affidavit_reviews.py --approve "document.md" --reviewer "Legal Counsel" --comments "Reviewed and approved for filing"
```

#### Rejection
```bash
python scripts/manage_affidavit_reviews.py --reject "document.md" --reviewer "Legal Counsel" --comments "Requires revision before filing"
```

#### Generate Status Report
```bash
python scripts/manage_affidavit_reviews.py --status-report
```

## API Usage

### Programmatic Review Management

```python
from affidavit_enhancement.affidavit_processor import AffidavitProcessor

# Initialize processor
processor = AffidavitProcessor()

# Get pending reviews
pending_reviews = processor.get_pending_reviews()

# Complete a review
success = processor.mark_review_complete(
    affidavit_path="document.md",
    reviewer="Legal Counsel", 
    approval_status="approved",
    comments="Legal review completed"
)

# Generate review alert
alert_report = processor.generate_review_summary_report()
```

### Review Status Class

```python
from affidavit_enhancement.affidavit_processor import ReviewStatus

review_status = ReviewStatus(
    affidavit_path="document.md",
    enhanced_path="document_enhanced.md", 
    critical_updates=1,
    high_priority_updates=2,
    total_updates=5,
    requires_review=True
)
```

## Integration with GitHub Actions

The system integrates with existing GitHub Actions workflows:

1. **Automatic Enhancement**: Triggered on evidence file changes
2. **Review Alert Generation**: Creates GitHub issues for critical reviews
3. **Status Reporting**: Updates PR descriptions with review requirements

### GitHub Issue Creation

When critical evidence updates are detected, the system can automatically create GitHub issues with:

- List of documents requiring review
- Summary of critical and high priority updates
- Links to enhanced documents
- Review completion checklist

## Security Considerations

### Preventing Unauthorized Filing

- Documents marked as requiring review cannot be filed without approval
- Review status is tracked in persistent files
- Only approved documents have `ready_for_filing: true`
- Legal compliance must be explicitly checked

### Access Control

- Review completion requires reviewer identification
- Audit trail maintained in review status files
- Timestamp tracking for all review actions

## Compliance Requirements

### Legal Standards

The system helps ensure compliance with:

- Professional conduct standards
- Court rules and procedures  
- Ethical requirements
- Confidentiality obligations
- Quality standards

### Documentation Requirements

- All review decisions are logged
- Reviewer identification is mandatory
- Review comments provide audit trail
- Document version control maintained

## Troubleshooting

### Common Issues

#### No Reviews Detected
- Check `review_settings` configuration
- Verify evidence update priority classification
- Ensure critical keywords are properly configured

#### Review Status Files Missing  
- Confirm `review_dir` exists and is writable
- Check file permissions
- Verify enhancement process completed successfully

#### Documents Not Ready for Filing
- Ensure review has been completed
- Check approval status is "approved"
- Verify `ready_for_filing` is true

### Debugging

Enable verbose logging:
```bash
python scripts/enhance_affidavits.py --verbose
```

Check review system status:
```bash
python scripts/manage_affidavit_reviews.py --list --verbose
```

## Best Practices

### For Legal Reviewers

1. **Always Review Enhanced Documents**: Check the enhanced version against originals
2. **Validate Legal Accuracy**: Ensure evidence integration is legally sound
3. **Check Compliance**: Verify court rules and procedure compliance
4. **Document Decisions**: Provide clear review comments
5. **Approve Only When Ready**: Only approve documents ready for immediate filing

### For System Administrators

1. **Regular Monitoring**: Check for pending reviews regularly
2. **Backup Management**: Ensure review status files are backed up
3. **Configuration Updates**: Keep review thresholds current
4. **Access Management**: Control who can complete reviews
5. **Audit Trail**: Preserve review history for compliance

### For Developers

1. **Test Review Triggers**: Verify review requirements work correctly
2. **Status File Integrity**: Ensure review status files are not corrupted
3. **Error Handling**: Implement robust error handling for review operations
4. **Performance**: Monitor system performance with large numbers of reviews
5. **Documentation**: Keep this documentation current with system changes

## Related Documentation

- [Affidavit Enhancement System](AFFIDAVIT_ENHANCEMENT_SYSTEM.md)
- [Legal Procedures](legal/procedures/README.md)
- [Configuration Guide](../config/README.md)
- [API Documentation](../API_DOCUMENTATION.md)

## Change Log

- **v1.0.0** (2025-10-13): Initial implementation of review system
  - Automatic review requirement detection
  - Review status tracking
  - CLI management tools
  - GitHub Actions integration
  - Comprehensive documentation

---

*For support or questions about the review system, please create an issue in the repository.*