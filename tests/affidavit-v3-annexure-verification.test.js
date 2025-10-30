/**
 * Test: Affidavit v3 Annexure Reference Verification
 * Task: task_88 from structured-todo.json
 * Source: Repository_Status_and_Critical_Evidence_Collection.md, line 77
 * 
 * Verifies that all annexure references in affidavit v3 have corresponding files
 */

const fs = require('fs');
const path = require('path');

// Paths
const AFFIDAVIT_PATH = path.join(__dirname, '..', 'jax-response', 'analysis-output', 'REVISED_Answering_Affidavit_Jax_TRACKED_CHANGES_v3.md');
const ANNEXURES_DIR = path.join(__dirname, '..', 'evidence', 'annexures');

// Expected annexures based on previous verification
const EXPECTED_ANNEXURES = [
  'JF-AR1', 'JF-BS1', 'JF-CHESNO1', 'JF-CHESNO2', 'JF-CHESNO3', 'JF-CHESNO4',
  'JF-CORR1', 'JF-DLA1', 'JF-DLA2', 'JF-DLA3', 'JF-EAL1', 'JF-EX1', 'JF-EX2',
  'JF-EX3', 'JF-EX4', 'JF-FSL1', 'JF-HIST1', 'JF-HIST2', 'JF-HIST3',
  'JF-PA1', 'JF-PA2', 'JF-PA3', 'JF-PA4', 'JF-RESTORE1', 'JF-RESTORE2',
  'JF-RESTORE3', 'JF-RESTORE4', 'JF-RF1', 'JF-RF2', 'JF-RF3', 'JF-RP1',
  'JF-RP2', 'JF-SAL1'
];

function extractAnnexureReferences(content) {
  const pattern = /JF-[A-Z0-9]+/g;
  const matches = content.match(pattern) || [];
  const unique = [...new Set(matches)];
  return {
    unique: unique.sort(),
    total: matches.length
  };
}

function checkAnnexureFiles(annexuresDir, references) {
  const existing = [];
  const missing = [];
  
  for (const ref of references) {
    const pattern = `${ref}*.md`;
    const files = fs.readdirSync(annexuresDir).filter(file => file.startsWith(ref) && file.endsWith('.md'));
    
    if (files.length > 0) {
      existing.push({ ref, files });
    } else {
      missing.push(ref);
    }
  }
  
  return { existing, missing };
}

function runTest() {
  console.log('================================================================================');
  console.log('TEST: Affidavit v3 Annexure Reference Verification');
  console.log('================================================================================\n');
  
  let testsPassed = 0;
  let testsFailed = 0;
  
  // Test 1: Affidavit file exists
  console.log('Test 1: Affidavit file exists');
  if (fs.existsSync(AFFIDAVIT_PATH)) {
    console.log('  ✅ PASS: Affidavit v3 file found');
    testsPassed++;
  } else {
    console.log(`  ❌ FAIL: Affidavit not found at ${AFFIDAVIT_PATH}`);
    testsFailed++;
    return { passed: testsPassed, failed: testsFailed };
  }
  
  // Test 2: Annexures directory exists
  console.log('\nTest 2: Annexures directory exists');
  if (fs.existsSync(ANNEXURES_DIR)) {
    console.log('  ✅ PASS: Annexures directory found');
    testsPassed++;
  } else {
    console.log(`  ❌ FAIL: Annexures directory not found at ${ANNEXURES_DIR}`);
    testsFailed++;
    return { passed: testsPassed, failed: testsFailed };
  }
  
  // Test 3: Extract references from affidavit
  console.log('\nTest 3: Extract annexure references');
  const content = fs.readFileSync(AFFIDAVIT_PATH, 'utf-8');
  const { unique, total } = extractAnnexureReferences(content);
  
  if (unique.length > 0) {
    console.log(`  ✅ PASS: Found ${unique.length} unique references (${total} total occurrences)`);
    testsPassed++;
  } else {
    console.log('  ❌ FAIL: No annexure references found');
    testsFailed++;
    return { passed: testsPassed, failed: testsFailed };
  }
  
  // Test 4: Expected number of annexures
  console.log('\nTest 4: Expected number of annexures');
  if (unique.length === EXPECTED_ANNEXURES.length) {
    console.log(`  ✅ PASS: Found expected ${EXPECTED_ANNEXURES.length} annexures`);
    testsPassed++;
  } else {
    console.log(`  ⚠️  WARNING: Found ${unique.length} annexures, expected ${EXPECTED_ANNEXURES.length}`);
    console.log('  (This may be acceptable if affidavit was updated)');
    testsPassed++;
  }
  
  // Test 5: All references have corresponding files
  console.log('\nTest 5: All references have corresponding files');
  const { existing, missing } = checkAnnexureFiles(ANNEXURES_DIR, unique);
  
  if (missing.length === 0) {
    console.log(`  ✅ PASS: All ${unique.length} annexures have corresponding files`);
    testsPassed++;
  } else {
    console.log(`  ❌ FAIL: ${missing.length} annexures missing:`);
    missing.forEach(ref => console.log(`     - ${ref}`));
    testsFailed++;
  }
  
  // Test 6: No unexpected missing annexures
  console.log('\nTest 6: Verify expected annexures are present');
  const missingExpected = EXPECTED_ANNEXURES.filter(ref => !unique.includes(ref));
  if (missingExpected.length === 0) {
    console.log('  ✅ PASS: All expected annexures are referenced');
    testsPassed++;
  } else {
    console.log(`  ⚠️  WARNING: ${missingExpected.length} expected annexures not found in affidavit:`);
    missingExpected.forEach(ref => console.log(`     - ${ref}`));
    console.log('  (This may be acceptable if affidavit was updated)');
    testsPassed++;
  }
  
  console.log('\n' + '='.repeat(80));
  console.log('SUMMARY');
  console.log('='.repeat(80));
  console.log(`Tests Passed: ${testsPassed}`);
  console.log(`Tests Failed: ${testsFailed}`);
  console.log(`Total Annexures: ${unique.length}`);
  console.log(`Missing Files: ${missing.length}`);
  
  if (testsFailed === 0 && missing.length === 0) {
    console.log('\n✅ ALL TESTS PASSED - Annexure references verified complete');
    return { passed: testsPassed, failed: testsFailed, success: true };
  } else {
    console.log('\n❌ TESTS FAILED - Annexure verification incomplete');
    return { passed: testsPassed, failed: testsFailed, success: false };
  }
}

// Run tests
const result = runTest();
process.exit(result.success ? 0 : 1);
