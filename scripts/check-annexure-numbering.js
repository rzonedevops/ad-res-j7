#!/usr/bin/env node
/**
 * Check all annexure numbering is sequential and complete
 * 
 * Task: task_99 from structured-todo.json
 * Source: Repository_Status_and_Critical_Evidence_Collection.md, line 121
 * Feature ID: feature_46
 * Paragraph ID: para_40
 */

const fs = require('fs');
const path = require('path');

const REPO_ROOT = path.join(__dirname, '..');

// Directories to check for annexures
const ANNEXURE_DIRECTORIES = [
  'ANNEXURES',
  'FINAL_AFFIDAVIT_PACKAGE/ANNEXURES',
  'docs/legal/annexures'
];

// Files to check for annexure count discrepancies
const INDEX_FILES = [
  'ANNEXURES/ANNEXURES_INDEX.md',
  'ANNEXURES_QUICK_REFERENCE_GUIDE.md'
];

/**
 * Extract JF directory numbers from a directory
 */
function getAnnexureNumbers(dirPath) {
  const fullPath = path.join(REPO_ROOT, dirPath);
  
  if (!fs.existsSync(fullPath)) {
    return { exists: false, numbers: [], directories: [] };
  }
  
  const entries = fs.readdirSync(fullPath, { withFileTypes: true });
  const jfDirs = entries
    .filter(entry => entry.isDirectory() && /^JF\d+$/.test(entry.name))
    .map(entry => ({
      name: entry.name,
      number: parseInt(entry.name.replace('JF', ''), 10)
    }))
    .sort((a, b) => a.number - b.number);
  
  return {
    exists: true,
    numbers: jfDirs.map(d => d.number),
    directories: jfDirs.map(d => d.name)
  };
}

/**
 * Check if a sequence is complete (no gaps)
 */
function checkSequence(numbers) {
  if (numbers.length === 0) {
    return { isComplete: true, gaps: [], min: null, max: null };
  }
  
  const min = Math.min(...numbers);
  const max = Math.max(...numbers);
  const expected = Array.from({ length: max - min + 1 }, (_, i) => min + i);
  const gaps = expected.filter(n => !numbers.includes(n));
  
  return {
    isComplete: gaps.length === 0,
    gaps,
    min,
    max,
    count: numbers.length,
    expectedCount: expected.length
  };
}

/**
 * Check index files for discrepancies
 */
function checkIndexFiles() {
  const issues = [];
  
  for (const indexFile of INDEX_FILES) {
    const fullPath = path.join(REPO_ROOT, indexFile);
    
    if (!fs.existsSync(fullPath)) {
      issues.push({
        file: indexFile,
        issue: 'File does not exist'
      });
      continue;
    }
    
    const content = fs.readFileSync(fullPath, 'utf-8');
    
    // Check for mentions of total count
    const totalMatch = content.match(/Total Annexures[:\s]*(\d+)/i);
    const rangeMatch = content.match(/JF(\d+)\s*(?:through|to|-)\s*JF(\d+)/i);
    
    if (totalMatch) {
      const reportedTotal = parseInt(totalMatch[0].match(/\d+/)[0], 10);
      issues.push({
        file: indexFile,
        reportedTotal,
        context: totalMatch[0]
      });
    }
    
    if (rangeMatch) {
      const startNum = parseInt(rangeMatch[1], 10);
      const endNum = parseInt(rangeMatch[2], 10);
      issues.push({
        file: indexFile,
        reportedRange: `JF${startNum}-JF${endNum}`,
        startNum,
        endNum
      });
    }
  }
  
  return issues;
}

/**
 * Main validation function
 */
function validateAnnexures() {
  console.log('=' .repeat(80));
  console.log('ANNEXURE NUMBERING VALIDATION');
  console.log('=' .repeat(80));
  console.log();
  
  let hasErrors = false;
  const allResults = {};
  
  // Check each directory
  for (const dir of ANNEXURE_DIRECTORIES) {
    console.log(`Checking: ${dir}`);
    const result = getAnnexureNumbers(dir);
    
    if (!result.exists) {
      console.log(`  ❌ Directory does not exist`);
      hasErrors = true;
      continue;
    }
    
    const sequence = checkSequence(result.numbers);
    allResults[dir] = { result, sequence };
    
    console.log(`  Found: ${result.directories.join(', ')}`);
    console.log(`  Range: JF${sequence.min || 'N/A'} to JF${sequence.max || 'N/A'}`);
    console.log(`  Count: ${sequence.count} directories`);
    
    if (sequence.isComplete) {
      console.log(`  ✅ Sequence is complete (no gaps)`);
    } else {
      console.log(`  ❌ Sequence has gaps: ${sequence.gaps.map(n => `JF${n.toString().padStart(2, '0')}`).join(', ')}`);
      hasErrors = true;
    }
    
    console.log();
  }
  
  // Check consistency across directories
  console.log('Checking consistency across directories...');
  const counts = Object.values(allResults).map(r => r.sequence.count);
  const ranges = Object.values(allResults).map(r => `${r.sequence.min}-${r.sequence.max}`);
  
  if (new Set(counts).size === 1) {
    console.log(`  ✅ All directories have the same count: ${counts[0]}`);
  } else {
    console.log(`  ❌ Directories have different counts: ${JSON.stringify(Object.fromEntries(
      Object.keys(allResults).map((k, i) => [k, counts[i]])
    ), null, 2)}`);
    hasErrors = true;
  }
  
  if (new Set(ranges).size === 1) {
    console.log(`  ✅ All directories have the same range: ${ranges[0]}`);
  } else {
    console.log(`  ❌ Directories have different ranges`);
    hasErrors = true;
  }
  
  console.log();
  
  // Check index files
  console.log('Checking index files for accuracy...');
  const indexIssues = checkIndexFiles();
  
  if (indexIssues.length === 0) {
    console.log('  ℹ️  No index files found or no count information in index files');
  } else {
    const actualCount = Object.values(allResults)[0]?.sequence.count || 0;
    const actualMax = Object.values(allResults)[0]?.sequence.max || 0;
    
    for (const issue of indexIssues) {
      console.log(`  File: ${issue.file}`);
      
      if (issue.reportedTotal !== undefined) {
        if (issue.reportedTotal === actualCount) {
          console.log(`    ✅ Reported total (${issue.reportedTotal}) matches actual count`);
        } else {
          console.log(`    ❌ Reported total (${issue.reportedTotal}) does not match actual count (${actualCount})`);
          console.log(`       Context: "${issue.context}"`);
          hasErrors = true;
        }
      }
      
      if (issue.reportedRange !== undefined) {
        if (issue.endNum === actualMax) {
          console.log(`    ✅ Reported range (${issue.reportedRange}) matches actual range`);
        } else {
          console.log(`    ❌ Reported range (${issue.reportedRange}) does not match actual range (JF${issue.startNum}-JF${actualMax})`);
          hasErrors = true;
        }
      }
    }
  }
  
  console.log();
  console.log('=' .repeat(80));
  
  if (hasErrors) {
    console.log('❌ VALIDATION FAILED - Issues found with annexure numbering');
    console.log('=' .repeat(80));
    return 1;
  } else {
    console.log('✅ VALIDATION PASSED - All annexure numbering is sequential and complete');
    console.log('=' .repeat(80));
    return 0;
  }
}

// Run validation
const exitCode = validateAnnexures();
process.exit(exitCode);
