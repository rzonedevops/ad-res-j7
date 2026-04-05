#!/usr/bin/env node

/**
 * Emergency Court Readiness Check
 * 
 * Validates that all critical materials are ready for immediate court submission.
 * Run this before attorney handoff to ensure nothing is missing.
 * 
 * Usage: node scripts/emergency-readiness-check.js
 */

const fs = require('fs');
const path = require('path');

console.log(`
╔════════════════════════════════════════════════════════════════╗
║           EMERGENCY COURT READINESS CHECK                      ║
║              Courts Need Response Within Days                  ║
╚════════════════════════════════════════════════════════════════╝
`);

// Critical files that MUST exist for court submission
const CRITICAL_FILES = {
  'Final Affidavits': [
    'FINAL_ANSWERING_AFFIDAVIT_COMPLETE.md',
    'FINAL_ANSWERING_AFFIDAVIT_COMPLETE.docx',
    'FINAL_ANSWERING_AFFIDAVIT_ABRIDGED.md',
    'FINAL_ANSWERING_AFFIDAVIT_ABRIDGED.docx'
  ],
  'Attorney Briefing': [
    'ATTORNEY_EXECUTIVE_BRIEFING.md',
    'ATTORNEY_QUICK_REFERENCE_GUIDE.md',
    'ATTORNEY_BRIEFING_PACKAGE_README.md',
    'ANNEXURES_QUICK_REFERENCE_GUIDE.md'
  ],
  'Critical Evidence Index': [
    'COMPREHENSIVE_EVIDENCE_INDEX.md',
    'COMPREHENSIVE_EVIDENCE_INDEX.json'
  ],
  'Supporting Documentation': [
    'FINAL_AFFIDAVITS_SUMMARY.md',
    'SUPPORTING_AFFIDAVIT_DANIEL_JAMES_FAUCITT.md',
    'ANSWERING_AFFIDAVIT_JACQUELINE_FAUCITT.md'
  ]
};

// Check for evidence directories
const EVIDENCE_DIRS = [
  'ANNEXURES',
  'evidence',
  'FINAL_AFFIDAVIT_PACKAGE'
];

let allGood = true;
let readyCount = 0;
let totalChecks = 0;

console.log('📋 CHECKING CRITICAL COURT DOCUMENTS\n');
console.log('═'.repeat(70));

// Check critical files
for (const [category, files] of Object.entries(CRITICAL_FILES)) {
  console.log(`\n📁 ${category}:`);
  
  for (const file of files) {
    totalChecks++;
    const filePath = path.join(process.cwd(), file);
    const exists = fs.existsSync(filePath);
    
    if (exists) {
      const stats = fs.statSync(filePath);
      const sizeKB = (stats.size / 1024).toFixed(1);
      console.log(`   ✅ ${file} (${sizeKB} KB)`);
      readyCount++;
    } else {
      console.log(`   ❌ ${file} - MISSING!`);
      allGood = false;
    }
  }
}

console.log('\n' + '═'.repeat(70));
console.log('\n📂 CHECKING EVIDENCE DIRECTORIES\n');
console.log('═'.repeat(70));

// Check evidence directories
for (const dir of EVIDENCE_DIRS) {
  totalChecks++;
  const dirPath = path.join(process.cwd(), dir);
  
  if (fs.existsSync(dirPath) && fs.statSync(dirPath).isDirectory()) {
    const files = fs.readdirSync(dirPath);
    console.log(`   ✅ ${dir}/ (${files.length} files)`);
    readyCount++;
  } else {
    console.log(`   ❌ ${dir}/ - MISSING!`);
    allGood = false;
  }
}

console.log('\n' + '═'.repeat(70));
console.log('\n🔍 CHECKING SPECIFIC ANNEXURES\n');
console.log('═'.repeat(70));

// Check for specific critical annexures mentioned in emergency plan
const CRITICAL_ANNEXURES = [
  'JF-RP1',  // Responsible Person
  'JF-BS1',  // R500K bank statement
  'JF-DLA',  // Director loan accounts
  'JF5',     // Settlement agreement
  'JF10'     // Peter's withdrawals
];

const annexuresDir = path.join(process.cwd(), 'ANNEXURES');
if (fs.existsSync(annexuresDir)) {
  const annexureFiles = fs.readdirSync(annexuresDir, { recursive: true });
  
  for (const annexure of CRITICAL_ANNEXURES) {
    totalChecks++;
    const found = annexureFiles.some(f => 
      f.includes(annexure) || f.toUpperCase().includes(annexure)
    );
    
    if (found) {
      console.log(`   ✅ ${annexure} - Referenced in documentation`);
      readyCount++;
    } else {
      console.log(`   ⚠️  ${annexure} - Not found (may need manual verification)`);
    }
  }
}

console.log('\n' + '═'.repeat(70));
console.log('\n📊 READINESS SUMMARY\n');
console.log('═'.repeat(70));

const readyPercent = ((readyCount / totalChecks) * 100).toFixed(1);
console.log(`\n   Ready: ${readyCount}/${totalChecks} checks passed (${readyPercent}%)`);

if (allGood) {
  console.log(`\n   ✅ READY FOR ATTORNEY HANDOFF`);
  console.log(`   ✅ All critical documents present`);
  console.log(`   ✅ Evidence directories accessible`);
  console.log(`\n   🎯 Next Steps:`);
  console.log(`      1. Package affidavits for attorney review`);
  console.log(`      2. Verify cross-references: npm run validate-cross-references`);
  console.log(`      3. Validate dates: npm run validate-dates`);
  console.log(`      4. Hand off to attorney within 2-4 hours`);
} else {
  console.log(`\n   ⚠️  ISSUES DETECTED - Address before attorney handoff`);
  console.log(`   ❌ Missing critical files (see above)`);
  console.log(`\n   🔧 Actions Required:`);
  console.log(`      1. Locate or generate missing files`);
  console.log(`      2. Re-run this check after fixes`);
  console.log(`      3. Do not hand off to attorney until 100% ready`);
}

console.log('\n' + '═'.repeat(70));
console.log('\n⏱️  EMERGENCY TIMELINE\n');
console.log('═'.repeat(70));
console.log(`
   Day 1 (Today):    Attorney handoff, verify evidence
   Day 2 (Tomorrow): Attorney review, execute affidavits  
   Day 3:            File with court
   
   ⚠️  Court deadline: Confirm exact date/time with attorney
`);

console.log('═'.repeat(70));

// Exit with error code if not ready
process.exit(allGood ? 0 : 1);
