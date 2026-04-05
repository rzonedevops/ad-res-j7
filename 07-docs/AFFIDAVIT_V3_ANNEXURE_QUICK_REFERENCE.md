# Affidavit v3 Annexure Verification - Quick Reference

## Quick Commands

### Run Verification
```bash
# Using npm (recommended for CI/CD)
npm run test:affidavit-v3-annexures

# Using Python directly
npm run validate-affidavit-v3-annexures

# Or manually
python3 scripts/verify_affidavit_v3_annexures.py
node tests/affidavit-v3-annexure-verification.test.js
```

## Expected Results

### Success Output
```
✅ VERIFICATION COMPLETE
All annexure references have corresponding files

Total Annexures: 33
Missing Files: 0
```

### Failure Output
```
❌ VERIFICATION FAILED
Missing X annexure files:
  ❌ JF-XXX (Y references)
```

## Files to Check

### Affidavit
- **Location:** `jax-response/analysis-output/REVISED_Answering_Affidavit_Jax_TRACKED_CHANGES_v3.md`
- **Line count:** 1171 lines
- **Last verified:** October 30, 2025

### Annexures Directory
- **Location:** `evidence/annexures/`
- **Expected files:** 33 annexure files (+ collection guides)
- **Naming pattern:** `JF-XXX*.md`

## All 33 Annexures

1. JF-AR1 - Accounting allocation records
2. JF-BS1 - Bank statement 16 July 2025
3. JF-CHESNO1 - Forensic accounting reports
4. JF-CHESNO2 - Unauthorized transfer statements
5. JF-CHESNO3 - Police/fraud investigation records
6. JF-CHESNO4 - Insolvency assessments
7. JF-CORR1 - Daniel's cooperation correspondence
8. JF-DLA1 - Peter's director loan account
9. JF-DLA2 - Jax's director loan account
10. JF-DLA3 - Daniel's director loan account
11. JF-EAL1 - Email access logs
12. JF-EX1 - Jacqueline access restriction evidence
13. JF-EX2 - Daniel access restriction evidence
14. JF-EX3 - Concern dismissal documentation
15. JF-EX4 - "Trust Rynette" statements
16. JF-FSL1 - Financial system logs
17. JF-HIST1 - Collaborative decision emails
18. JF-HIST2 - Director consultation examples
19. JF-HIST3 - Transparent transaction records
20. JF-PA1 - Peter withdrawal example 1
21. JF-PA2 - Peter withdrawal example 2
22. JF-PA3 - Peter withdrawal example 3
23. JF-PA4 - Peter withdrawal example 4
24. JF-RESTORE1 - Companies House dormancy filings
25. JF-RESTORE2 - Tax loss documentation
26. JF-RESTORE3 - Creditor repayment correspondence
27. JF-RESTORE4 - New venture evidence
28. JF-RF1 - Financial software access grants
29. JF-RF2 - Password/credential sharing
30. JF-RF3 - Bank signatory authority grants
31. JF-RP1 - Responsible Person designation documentation
32. JF-RP2 - Regulatory risk analysis
33. JF-SAL1 - System access logs

## When to Run Verification

### Required
- Before court submission
- After modifying the affidavit
- After adding/removing annexures
- Before creating final affidavit package

### Recommended
- As part of CI/CD pipeline
- During code review
- Weekly as part of quality checks
- After evidence collection updates

## Troubleshooting

### If verification fails:

1. **Check file existence:**
   ```bash
   ls -la evidence/annexures/JF-XXX*.md
   ```

2. **Check affidavit for reference:**
   ```bash
   grep "JF-XXX" jax-response/analysis-output/REVISED_Answering_Affidavit_Jax_TRACKED_CHANGES_v3.md
   ```

3. **Create missing annexure:**
   - Use existing annexure as template
   - Follow naming convention: `JF-XXX_DESCRIPTION.md`
   - Include placeholder if evidence not yet collected

4. **Update and re-verify:**
   ```bash
   npm run test:affidavit-v3-annexures
   ```

## Documentation

- **Latest Verification:** `docs/ANNEXURE_VERIFICATION_REPORT_2025_10_30.md`
- **Original Verification:** `docs/ANNEXURE_VERIFICATION_REPORT.md`
- **Task Summary:** `docs/AFFIDAVIT_V3_ANNEXURE_VERIFICATION_COMPLETE.md`
- **This Guide:** `docs/AFFIDAVIT_V3_ANNEXURE_QUICK_REFERENCE.md`

## Integration

### Add to CI/CD
```yaml
- name: Verify Affidavit Annexures
  run: npm run test:affidavit-v3-annexures
```

### Add to Pre-commit Hook
```bash
#!/bin/bash
if git diff --cached --name-only | grep -q "REVISED_Answering_Affidavit_Jax_TRACKED_CHANGES_v3.md"; then
  echo "Affidavit modified, verifying annexures..."
  npm run test:affidavit-v3-annexures || exit 1
fi
```

## Reference Stats

- **Total unique annexures:** 33
- **Total reference occurrences:** 79
- **Average references per annexure:** 2.4
- **Most referenced:** JF-RP1, JF-RP2, JF-DLA1-3, JF-SAL1, JF-EAL1, JF-FSL1 (3 refs each)
- **Least referenced:** 9 annexures with 1 reference each

## Status

✅ Last verified: October 30, 2025 07:06 UTC  
✅ Status: All annexure references correct and complete  
✅ Next verification: As needed when affidavit is updated
