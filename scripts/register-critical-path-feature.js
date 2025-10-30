#!/usr/bin/env node

/**
 * Register Issue #2946 (Critical Path Dependencies) in Hierarchical System
 * 
 * This script creates the feature issue in the database and links it to
 * the appropriate legal arguments.
 */

const path = require('path');
const fs = require('fs');

// Import hierarchical issue manager
const HierarchicalIssueManager = require('../db/hierarchical-issue-manager');

async function registerCriticalPathFeature() {
  console.log('\n╔════════════════════════════════════════════════════════════════╗');
  console.log('║     Registering Issue #2946 in Hierarchical System            ║');
  console.log('╚════════════════════════════════════════════════════════════════╝\n');
  
  const manager = new HierarchicalIssueManager();
  
  try {
    // 1. Create or get the Strategic Coordination legal argument
    console.log('📋 Step 1: Creating Strategic Coordination Legal Argument...');
    
    const strategicArg = await manager.createLegalArgument(
      'Strategic Coordination & Execution Management',
      'Master execution strategy coordinating all evidence collection, forensic analysis, and system implementation tasks to ensure legal review readiness within 12-week timeline.',
      'coordination',
      'Critical path dependency management with bottleneck identification and validation gates'
    );
    
    console.log(`   ✅ Created legal argument #${strategicArg.id}: ${strategicArg.argument_name}\n`);
    
    // 2. Create the Feature Issue for #2946
    console.log('📋 Step 2: Creating Feature Issue #2946...');
    
    const feature = await manager.createFeatureIssue(
      2946,
      '[FEATURE] Critical Path Dependencies',
      `Master execution plan for Case 2025-137857 tracking 150+ tasks across 12-week timeline.
      
Key Components:
- Foundation Layer: 8 critical tasks (security + Phase 1 evidence)
- Integration Layer: 20 tasks with 4 major dependency chains
- Validation Layer: 4 quality gates before legal review
- Optional Features: 3 enhancement evaluations

Critical Success Factors:
1. Responsible Person documentation (37 jurisdictions) - 4-6 week bottleneck
2. Civil Evidence Test Suite - enables 8 downstream tasks
3. Evidence Index (275+ files) - enables 3 downstream tasks
4. Timeline validation - critical for legal review

Execution Strategy:
- Week 1-2: Critical Foundation
- Week 3-4: Evidence Building Momentum
- Week 5-6: Forensic Analysis & Validation
- Week 7-8: Integration & Quality
- Week 9-10: Pre-Legal Review
- Week 11-12: Final Validation & Optional Tasks`,
      'critical',
      strategicArg.id
    );
    
    console.log(`   ✅ Created feature issue #${feature.id}: ${feature.title}\n`);
    
    // 3. Create paragraphs for major dependency chains
    console.log('📋 Step 3: Creating dependency chain paragraphs...');
    
    const paragraphs = [
      {
        title: 'Foundation Layer - Phase 1 Critical Evidence',
        description: 'Security fixes and essential evidence collection that blocks all downstream work. Includes R500K bank statement, director loan accounts, Responsible Person documentation (37 jurisdictions - 4-6 week bottleneck), Peter\'s withdrawals, and regulatory risk analysis.',
        rank: 1,
        weight: 100
      },
      {
        title: 'Integration Layer - Evidence Index Chain',
        description: 'Comprehensive evidence index mapping 275+ files. Enables annexure verification, cross-reference testing, and Referenced By updates. 1-week delay causes 3-week cascade.',
        rank: 2,
        weight: 90
      },
      {
        title: 'Integration Layer - Civil Evidence Test Suite',
        description: 'Comprehensive test suite for civil evidence standards. CRITICAL: Longest dependency chain enabling 8 downstream tasks. 2-week delay causes 6-week cascade. Requires modular design with daily standup.',
        rank: 3,
        weight: 95
      },
      {
        title: 'Integration Layer - Timeline & Date Validation',
        description: 'Update case timeline with 15 forensic events and validate all dates across revenue-theft, family-trust, and financial-flows analyses. Enables visual timeline, cross-border analysis, and damage calculations.',
        rank: 4,
        weight: 85
      },
      {
        title: 'Validation Layer - Quality Gates',
        description: 'Four critical validation checkpoints before legal review: date accuracy verification, annexure numbering check, contradiction check between affidavits, and legal review preparation. No task bypasses these gates.',
        rank: 5,
        weight: 100
      },
      {
        title: 'System Integration - Repository & Timeline',
        description: 'Repository structure consolidation, timeline visualization, and system testing. Ensures all systems integrated and cross-reference system operational before Week 8.',
        rank: 6,
        weight: 75
      },
      {
        title: 'Pre-Legal Review - Response Coordination',
        description: 'Coordination between Jacqueline\'s and Daniel\'s responses, attorney briefing package, technical affidavit preparation, and comprehensive documentation of evidence chains.',
        rank: 7,
        weight: 80
      },
      {
        title: 'Final Validation - QA & Optional Features',
        description: 'Automated testing infrastructure, workflow validation, and evaluation of optional features (Criminal Evidence Standards, Mathematical Proof Standards, Evidence Collection Infrastructure).',
        rank: 8,
        weight: 60
      }
    ];
    
    for (const para of paragraphs) {
      const paragraph = await manager.createParagraph(
        feature.id,
        para.title,
        para.description,
        para.rank,
        para.weight
      );
      console.log(`   ✅ Created paragraph: ${para.title} (Rank ${para.rank}, Weight ${para.weight})`);
    }
    
    console.log('\n📊 Summary:');
    console.log('─────────────────────────────────────────────────────────────────');
    console.log(`   Legal Argument: #${strategicArg.id}`);
    console.log(`   Feature Issue: #${feature.id}`);
    console.log(`   Paragraphs: ${paragraphs.length}`);
    console.log(`   Total Tasks Tracked: 150+`);
    console.log(`   Execution Timeline: 12 weeks`);
    console.log('');
    
    console.log('✅ Registration Complete!\n');
    console.log('Next Steps:');
    console.log('  1. Run: npm run db:hierarchy:stats');
    console.log('  2. Run: npm run critical-path:status');
    console.log('  3. Review: CRITICAL_PATH_DEPENDENCIES.md');
    console.log('  4. Review: WEEKLY_EXECUTION_CHECKLISTS.md\n');
    
    return {
      argument: strategicArg,
      feature: feature,
      paragraphs: paragraphs
    };
    
  } catch (error) {
    console.error('❌ Error registering critical path feature:', error);
    throw error;
  }
}

// Run if called directly
if (require.main === module) {
  registerCriticalPathFeature()
    .then(() => process.exit(0))
    .catch(error => {
      console.error(error);
      process.exit(1);
    });
}

module.exports = { registerCriticalPathFeature };
