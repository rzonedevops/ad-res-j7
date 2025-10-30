/**
 * Test to verify that all jax-dan-response content files have
 * "Jacqueline's Legal Perspective" sections with valid cross-references
 */

const fs = require('fs');
const path = require('path');

const jaxDanDir = path.join(__dirname, '..', 'jax-dan-response');
const jaxResponseADDir = path.join(__dirname, '..', 'jax-response', 'AD');

// Content files that should have Jacqueline's Legal Perspective sections
const contentFiles = [
  'accountant_concerns.md',
  'annexures_and_evidence.md',
  'comprehensive_material_non_disclosure.md',
  'confrontation.md',
  'critical_paragraph_it_expense_rebuttal.md',
  'critical_paragraph_r500k_rebuttal.md',
  'documentation_requests.md',
  'financial_allegations_rebuttal_matrix.md',
  'interim_relief.md',
  'jax-dan-response-improvements.md',
  'peters_causation.md',
  'peters_discovery.md',
  'quantified_harm_analysis.md',
  'quick-action-summary.md',
  'respondent_roles_and_responsibilities.md',
  'responsible_person_regulatory_crisis.md',
  'settlement_and_timing.md',
  'timeline_analysis.md',
  'urgency.md',
];

// Files with specific cross-references to jax-response/AD files
const specificCrossRefs = {
  'accountant_concerns.md': '2-High-Priority/PARA_7_12-7_13.md',
  'documentation_requests.md': '2-High-Priority/PARA_7_14-7_15.md',
  'urgency.md': '2-High-Priority/PARA_11-11_5.md',
  'interim_relief.md': '2-High-Priority/PARA_13-13_1.md',
  'confrontation.md': '2-High-Priority/PARA_8_4.md',
  'peters_discovery.md': '2-High-Priority/PARA_8-8_3.md',
  'responsible_person_regulatory_crisis.md': '2-High-Priority/PARA_3-3_10.md',
  'respondent_roles_and_responsibilities.md': '2-High-Priority/PARA_3_11-3_13.md',
  'critical_paragraph_it_expense_rebuttal.md': '1-Critical/PARA_7_2-7_5.md',
  'critical_paragraph_r500k_rebuttal.md': '1-Critical/PARA_7_6.md',
};

console.log('\n=== Jacqueline\'s Legal Perspective Section Verification ===\n');

let allPassed = true;
let testsRun = 0;
let testsPassed = 0;

// Test 1: All content files should have the section
console.log('Test 1: Checking all content files have Jacqueline\'s Legal Perspective...');
contentFiles.forEach(filename => {
  testsRun++;
  const filePath = path.join(jaxDanDir, filename);
  
  if (!fs.existsSync(filePath)) {
    console.log(`  ❌ ${filename} - File not found`);
    allPassed = false;
    return;
  }
  
  const content = fs.readFileSync(filePath, 'utf8');
  
  if (content.includes("Jacqueline's Legal Perspective")) {
    console.log(`  ✓ ${filename}`);
    testsPassed++;
  } else {
    console.log(`  ❌ ${filename} - Missing section`);
    allPassed = false;
  }
});

// Test 2: Files with specific cross-references should point to existing files
console.log('\nTest 2: Verifying specific cross-references are valid...');
Object.entries(specificCrossRefs).forEach(([filename, relPath]) => {
  testsRun++;
  const targetPath = path.join(jaxResponseADDir, relPath);
  
  if (fs.existsSync(targetPath)) {
    console.log(`  ✓ ${filename} -> ${relPath} (exists)`);
    testsPassed++;
  } else {
    console.log(`  ❌ ${filename} -> ${relPath} (NOT FOUND)`);
    allPassed = false;
  }
});

// Test 3: Verify cross-reference format in files
console.log('\nTest 3: Verifying cross-reference format...');
Object.entries(specificCrossRefs).forEach(([filename, relPath]) => {
  testsRun++;
  const filePath = path.join(jaxDanDir, filename);
  const content = fs.readFileSync(filePath, 'utf8');
  
  // Check if it contains the expected cross-reference path
  if (content.includes(relPath)) {
    console.log(`  ✓ ${filename} - Contains correct cross-reference`);
    testsPassed++;
  } else {
    console.log(`  ❌ ${filename} - Cross-reference format issue`);
    allPassed = false;
  }
});

// Summary
console.log('\n=== SUMMARY ===');
console.log(`Tests run: ${testsRun}`);
console.log(`Tests passed: ${testsPassed}`);
console.log(`Tests failed: ${testsRun - testsPassed}`);

if (allPassed) {
  console.log('\n✅ All tests passed!\n');
  process.exit(0);
} else {
  console.log('\n❌ Some tests failed!\n');
  process.exit(1);
}
