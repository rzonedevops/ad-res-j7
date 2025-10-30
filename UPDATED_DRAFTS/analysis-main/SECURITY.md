# Security Policy

## Overview

The **Analysis Repository** handles sensitive legal case information, evidence, and personal data. Security is paramount to protect the integrity of legal proceedings and maintain confidentiality of case materials.

## Supported Versions

We provide security updates for the following versions:

| Version | Supported          |
| ------- | ------------------ |
| 1.x     | :white_check_mark: |
| < 1.0   | :x:                |

## Reporting a Vulnerability

### How to Report

**DO NOT** create public GitHub issues for security vulnerabilities.

Instead, please report security vulnerabilities through one of these channels:

1. **GitHub Security Advisories** (Preferred):
   - Go to the repository's Security tab
   - Click "Report a vulnerability"
   - Provide detailed information about the vulnerability

2. **Email**:
   - Send to: devops@rzone.dev
   - Subject: "[SECURITY] Analysis Repository Vulnerability"
   - Include detailed description and reproduction steps

### What to Include

When reporting a vulnerability, please include:

- **Description**: Clear description of the vulnerability
- **Impact**: Potential impact on security and data
- **Reproduction Steps**: Detailed steps to reproduce the issue
- **Affected Components**: Which parts of the system are affected
- **Suggested Fix**: If you have ideas for remediation
- **Your Contact Info**: For follow-up questions

### Response Timeline

- **Acknowledgment**: Within 48 hours
- **Initial Assessment**: Within 5 business days
- **Status Updates**: Every 7 days until resolution
- **Fix Timeline**: Critical issues within 30 days, others within 90 days

## Security Best Practices

### For Contributors

1. **Never Commit Secrets**:
   - No API keys, passwords, or tokens in code
   - Use environment variables for sensitive data
   - Check `.gitignore` before committing

2. **Code Review**:
   - All code changes require review
   - Security-sensitive changes need additional scrutiny
   - Use static analysis tools

3. **Dependencies**:
   - Keep dependencies up-to-date
   - Review security advisories for dependencies
   - Use `pip-audit` or similar tools

4. **Input Validation**:
   - Validate all user inputs
   - Sanitize data before database operations
   - Use parameterized queries

5. **Authentication & Authorization**:
   - Implement proper access controls
   - Use secure session management
   - Follow principle of least privilege

### For Users

1. **Environment Configuration**:
   - Use strong, unique passwords for databases
   - Rotate API keys regularly
   - Limit API key permissions

2. **Database Security**:
   - Use SSL/TLS for database connections
   - Enable row-level security in Supabase
   - Regularly backup sensitive data

3. **Access Control**:
   - Limit repository access to authorized personnel
   - Use GitHub's branch protection rules
   - Enable two-factor authentication

4. **Evidence Handling**:
   - Encrypt sensitive evidence files
   - Use secure file transfer methods
   - Maintain audit logs

## Security Features

### Current Security Measures

1. **Data Encryption**:
   - Database connections use SSL/TLS
   - Sensitive fields can be encrypted at rest
   - Secure credential storage

2. **Authentication**:
   - API key authentication for backend services
   - JWT tokens for session management
   - Rate limiting on API endpoints

3. **Input Validation**:
   - Pydantic models for data validation
   - SQL injection prevention via parameterized queries
   - XSS protection in web interfaces

4. **Audit Logging**:
   - Database operation logging
   - Evidence access tracking
   - User activity monitoring

5. **Access Control**:
   - Role-based access control (RBAC)
   - Row-level security in databases
   - API endpoint authorization

### Planned Security Enhancements

- [ ] Automated security scanning in CI/CD
- [ ] Enhanced encryption for evidence files
- [ ] Multi-factor authentication support
- [ ] Advanced threat detection
- [ ] Security compliance reporting

## Vulnerability Disclosure Policy

### Responsible Disclosure

We follow responsible disclosure practices:

1. **Private Reporting**: Report vulnerabilities privately first
2. **Coordinated Disclosure**: Work with us on timing of public disclosure
3. **Credit**: We acknowledge security researchers who report issues responsibly
4. **No Legal Action**: We won't pursue legal action against researchers who follow this policy

### Public Disclosure Timeline

- **Critical Vulnerabilities**: 30 days after fix is available
- **High Severity**: 60 days after fix is available
- **Medium/Low Severity**: 90 days after fix is available

We may request extended timelines for complex issues.

## Security Checklist for Developers

Before submitting code:

- [ ] No hardcoded secrets or credentials
- [ ] Input validation implemented
- [ ] SQL queries use parameterization
- [ ] Authentication/authorization checks in place
- [ ] Error messages don't leak sensitive information
- [ ] Dependencies are up-to-date
- [ ] Security tests included
- [ ] Documentation updated with security considerations

## Compliance

This repository handles legal case data and must comply with:

- **South African Protection of Personal Information Act (POPIA)**
- **South African Cybercrimes Act**
- **Legal Professional Privilege requirements**
- **Court confidentiality rules**

### Data Protection

- Personal information is processed lawfully
- Data minimization principles applied
- Secure storage and transmission
- Access controls and audit trails
- Data retention policies followed

## Security Tools

### Recommended Tools

1. **Static Analysis**:
   - `bandit` - Python security linter
   - `safety` - Dependency vulnerability scanner
   - `pip-audit` - Audit Python packages

2. **Secret Scanning**:
   - `git-secrets` - Prevent committing secrets
   - `truffleHog` - Find secrets in git history

3. **Dependency Management**:
   - `dependabot` - Automated dependency updates
   - `snyk` - Vulnerability scanning

### Running Security Checks

```bash
# Install security tools
pip install bandit safety pip-audit

# Run security scan
bandit -r src/ -f json -o security-report.json

# Check dependencies
safety check
pip-audit

# Scan for secrets
git secrets --scan
```

## Incident Response

### In Case of Security Breach

1. **Immediate Actions**:
   - Contain the breach
   - Assess the impact
   - Notify affected parties
   - Document the incident

2. **Investigation**:
   - Determine root cause
   - Identify compromised data
   - Review access logs
   - Collect evidence

3. **Remediation**:
   - Apply security patches
   - Update credentials
   - Enhance security measures
   - Monitor for further issues

4. **Post-Incident**:
   - Conduct post-mortem
   - Update security policies
   - Improve detection mechanisms
   - Train team members

## Contact

For security-related questions or concerns:

- **Security Team**: devops@rzone.dev
- **GitHub Security**: Use Security Advisories feature
- **Emergency**: For critical issues requiring immediate attention

## Acknowledgments

We appreciate the security research community and will acknowledge responsible disclosure of vulnerabilities in our security advisories.

## Updates to This Policy

This security policy is reviewed and updated quarterly. Last updated: October 2025.

---

**Remember**: Security is everyone's responsibility. If you see something, say something.

