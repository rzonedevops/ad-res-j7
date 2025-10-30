#!/usr/bin/env node

/**
 * Critical Path Tracker for Issue #2946
 * 
 * Monitors execution status of 150+ tasks across the 12-week timeline.
 * Identifies blockers, calculates critical path progress, and generates reports.
 * 
 * Usage:
 *   node scripts/critical-path-tracker.js --status
 *   node scripts/critical-path-tracker.js --blockers
 *   node scripts/critical-path-tracker.js --week 3 --report
 *   node scripts/critical-path-tracker.js --task 2855 --dependencies
 */

const fs = require('fs');
const path = require('path');

// ============================================================================
// TASK DEPENDENCY MAPPING
// ============================================================================

const TASK_DEPENDENCIES = {
  // Foundation Layer (No Dependencies)
  foundation: {
    security: [2771, 2774, 2776],
    phase1_evidence: [2838, 2836, 2834, 2837, 2835],
    chesno: [2841]
  },
  
  // Integration Layer (Enables Multiple Downstream)
  integration: {
    // Evidence Index Chain
    evidence_index: {
      anchor: 2855,
      enables: [2853, 2879, 2900],
      dependencies: [],
      timeline: 'Week 3-4',
      cascadeImpact: '3 weeks'
    },
    
    // Timeline Analysis Chain
    timeline: {
      anchor: 2857,
      enables: [2858, 2863, 2893],
      dependencies: [],
      timeline: 'Week 3-6',
      cascadeImpact: '3 weeks'
    },
    
    // Date Validation Chain
    date_validation: {
      anchor: 2869,
      enables: [2870, 2875, 2876],
      dependencies: [],
      timeline: 'Week 5-6',
      cascadeImpact: '2 weeks'
    },
    
    // Civil Evidence Test Suite Chain (CRITICAL - Longest)
    civil_evidence: {
      anchor: 2789,
      enables: [2790, 2791, 2792, 2794, 2795, 2796, 2797, 2798],
      dependencies: [],
      timeline: 'Week 5-6',
      cascadeImpact: '6 weeks'
    }
  },
  
  // Validation Layer (Quality Gates)
  validation: {
    gates: [2863, 2864, 2903, 2891, 2897]
  }
};

// ============================================================================
// WEEK-BY-WEEK EXECUTION PLAN
// ============================================================================

const EXECUTION_TIMELINE = {
  'Week 1-2': {
    focus: 'Critical Foundation',
    mustComplete: [2771, 2838, 2836, 2834, 2837, 2835],
    start: [2774, 2776, 2841],
    successCriteria: [
      'All Phase 1 critical evidence collected',
      'Security vulnerabilities resolved',
      'Foundation for evidence index established'
    ]
  },
  
  'Week 3-4': {
    focus: 'Evidence Building Momentum',
    complete: [2839, 2840, 2841, 2842, 2843, 2844, 2845, 2846, 2847, 2850],
    start: [2869, 2870],
    successCriteria: [
      '100% Phase 1 completion',
      '60% Phase 2 completion',
      'Forensic analysis pipeline initiated'
    ]
  },
  
  'Week 5-6': {
    focus: 'Forensic Analysis & Validation',
    complete: [2869, 2870, 2871, 2872, 2873, 2874, 2875, 2876, 2877, 2789, 2790, 2794],
    start: [2851, 2852, 2853, 2854, 2855, 2856],
    successCriteria: [
      'All forensic analyses validated',
      'Civil evidence test suite operational',
      'Repository consolidation underway'
    ]
  },
  
  'Week 7-8': {
    focus: 'Integration & Quality',
    complete: [2851, 2852, 2853, 2854, 2855, 2856, 2857, 2858, 2859, 2860, 2861, 2862, 2878, 2879, 2880, 2881, 2882, 2883],
    start: [],
    successCriteria: [
      'Timeline visualization complete',
      'All systems integrated',
      'Cross-reference system operational'
    ]
  },
  
  'Week 9-10': {
    focus: 'Pre-Legal Review',
    complete: [2863, 2864, 2865, 2866, 2867, 2868, 2898, 2899, 2900, 2901, 2902, 2903, 2904, 2905, 2906, 2907, 2908, 2909, 2910, 2911, 2791, 2792, 2793, 2794, 2795, 2796, 2797, 2798],
    start: [],
    successCriteria: [
      'All validation gates passed',
      'Contradiction check complete',
      'Responses coordinated (Jacqueline + Daniel)'
    ]
  },
  
  'Week 11-12': {
    focus: 'Final Validation & Optional Tasks',
    complete: [2884, 2885, 2886, 2887, 2888, 2766, 2767, 2768, 2769, 2770, 2772, 2773, 2775, 2777, 2778, 2779, 2780, 2781, 2782, 2783, 2784, 2785, 2786, 2787, 2788],
    evaluate: [2923, 2924, 2925],
    successCriteria: [
      '100% required tasks complete',
      'All validation checks green',
      'Optional features assessed for ROI',
      'Ready for legal review handoff'
    ]
  }
};

// ============================================================================
// BOTTLENECK DEFINITIONS
// ============================================================================

const BOTTLENECKS = [
  {
    task: 2834,
    title: 'Responsible Person Documentation (37 jurisdictions)',
    scope: '37 jurisdictions',
    timeline: '4-6 weeks',
    impact: 'Blocks Phase 1 completion',
    action: 'Start immediately, parallelize by jurisdiction',
    severity: 'HIGH'
  },
  {
    task: 2789,
    title: 'Civil Evidence Test Suite',
    scope: '8 downstream dependencies',
    timeline: '2 weeks',
    impact: '6-week cascade if delayed',
    action: 'Modular implementation, daily standup',
    severity: 'HIGH'
  },
  {
    task: 2855,
    title: 'Comprehensive Evidence Index (275+ files)',
    scope: '275+ files',
    timeline: '1 week',
    impact: '3-week cascade if delayed',
    action: 'Automate cross-reference detection',
    severity: 'MEDIUM'
  }
];

// ============================================================================
// HELPER FUNCTIONS
// ============================================================================

/**
 * Calculate overall completion percentage
 */
function calculateProgress() {
  const allTasks = [];
  
  // Collect all tasks from timeline
  Object.values(EXECUTION_TIMELINE).forEach(week => {
    if (week.mustComplete) allTasks.push(...week.mustComplete);
    if (week.complete) allTasks.push(...week.complete);
    if (week.start) allTasks.push(...week.start);
  });
  
  // Add foundation tasks
  Object.values(TASK_DEPENDENCIES.foundation).forEach(tasks => {
    if (Array.isArray(tasks)) allTasks.push(...tasks);
  });
  
  // Add integration anchors
  Object.values(TASK_DEPENDENCIES.integration).forEach(chain => {
    if (chain.anchor) allTasks.push(chain.anchor);
    if (chain.enables) allTasks.push(...chain.enables);
  });
  
  // Add validation gates
  allTasks.push(...TASK_DEPENDENCIES.validation.gates);
  
  // Remove duplicates
  const uniqueTasks = [...new Set(allTasks)];
  
  return {
    total: uniqueTasks.length,
    completed: 0, // TODO: Integrate with GitHub API or issue tracker
    percentage: 0
  };
}

/**
 * Find all tasks that depend on a given task
 */
function findDependentTasks(taskNumber) {
  const dependents = [];
  
  // Check integration chains
  Object.entries(TASK_DEPENDENCIES.integration).forEach(([chainName, chain]) => {
    if (chain.anchor === taskNumber) {
      dependents.push({
        chain: chainName,
        tasks: chain.enables,
        impact: chain.cascadeImpact
      });
    }
  });
  
  return dependents;
}

/**
 * Find all tasks that a given task depends on
 */
function findPrerequisites(taskNumber) {
  const prerequisites = [];
  
  // Check if task is in any enables list
  Object.entries(TASK_DEPENDENCIES.integration).forEach(([chainName, chain]) => {
    if (chain.enables && chain.enables.includes(taskNumber)) {
      prerequisites.push({
        chain: chainName,
        anchor: chain.anchor,
        timeline: chain.timeline
      });
    }
  });
  
  return prerequisites;
}

/**
 * Identify current blockers
 */
function identifyBlockers() {
  return BOTTLENECKS.filter(b => b.severity === 'HIGH');
}

/**
 * Get tasks for a specific week
 */
function getWeekTasks(weekRange) {
  return EXECUTION_TIMELINE[weekRange] || null;
}

// ============================================================================
// REPORT GENERATORS
// ============================================================================

/**
 * Generate status dashboard
 */
function generateStatusReport() {
  console.log('\n╔════════════════════════════════════════════════════════════════╗');
  console.log('║         CRITICAL PATH DEPENDENCIES - STATUS DASHBOARD         ║');
  console.log('║                      Issue #2946                               ║');
  console.log('╚════════════════════════════════════════════════════════════════╝\n');
  
  const progress = calculateProgress();
  
  console.log('📊 OVERALL PROGRESS');
  console.log('─────────────────────────────────────────────────────────────────');
  console.log(`   Total Tasks: ${progress.total}`);
  console.log(`   Completed: ${progress.completed} (${progress.percentage}%)`);
  console.log(`   Remaining: ${progress.total - progress.completed}`);
  console.log('');
  
  console.log('🎯 COMPLETION BY LAYER');
  console.log('─────────────────────────────────────────────────────────────────');
  console.log(`   Foundation Layer:    0/8 tasks   ( 0%) ⚠️  Target: Week 2`);
  console.log(`   Integration Layer:   0/20 tasks  ( 0%) ⚠️  Target: Week 8`);
  console.log(`   Validation Layer:    0/4 tasks   ( 0%) ⚠️  Target: Week 10`);
  console.log(`   Optional Features:   0/3 eval    ( 0%)     Target: Week 12`);
  console.log('');
  
  console.log('📅 CURRENT WEEK STATUS');
  console.log('─────────────────────────────────────────────────────────────────');
  console.log(`   Current Week: 0 (Start)`);
  console.log(`   Focus: Not yet started`);
  console.log(`   Status: 🟢 GREEN - No delays`);
  console.log('');
  
  console.log('🚨 ACTIVE BOTTLENECKS');
  console.log('─────────────────────────────────────────────────────────────────');
  const blockers = identifyBlockers();
  blockers.forEach((b, i) => {
    console.log(`   ${i + 1}. #${b.task} - ${b.title}`);
    console.log(`      Timeline: ${b.timeline} | Impact: ${b.impact}`);
    console.log(`      Action: ${b.action}`);
    console.log('');
  });
  
  console.log('✅ NEXT ACTIONS');
  console.log('─────────────────────────────────────────────────────────────────');
  const week1 = EXECUTION_TIMELINE['Week 1-2'];
  console.log(`   Week 1-2 Focus: ${week1.focus}`);
  console.log(`   Must Complete:`);
  week1.mustComplete.forEach(task => {
    console.log(`      • #${task}`);
  });
  console.log('');
  
  console.log('📞 CONTACTS');
  console.log('─────────────────────────────────────────────────────────────────');
  console.log('   @drzo - Strategic oversight, critical path coordination');
  console.log('   @danregima - Evidence collection, forensic analysis');
  console.log('   @dtecho - System implementation, validation automation');
  console.log('');
}

/**
 * Generate blocker report
 */
function generateBlockerReport() {
  console.log('\n╔════════════════════════════════════════════════════════════════╗');
  console.log('║              CRITICAL PATH - BLOCKER ANALYSIS                  ║');
  console.log('╚════════════════════════════════════════════════════════════════╝\n');
  
  console.log('🚨 HIGH SEVERITY BLOCKERS\n');
  
  const highBlockers = BOTTLENECKS.filter(b => b.severity === 'HIGH');
  highBlockers.forEach((b, i) => {
    console.log(`${i + 1}. TASK #${b.task}: ${b.title}`);
    console.log('   ─────────────────────────────────────────────────────────────');
    console.log(`   Scope:        ${b.scope}`);
    console.log(`   Timeline:     ${b.timeline}`);
    console.log(`   Impact:       ${b.impact}`);
    console.log(`   Action:       ${b.action}`);
    console.log(`   Severity:     ${b.severity}`);
    
    // Find dependents
    const dependents = findDependentTasks(b.task);
    if (dependents.length > 0) {
      console.log(`   Blocks:`);
      dependents.forEach(dep => {
        console.log(`      • ${dep.chain}: ${dep.tasks.length} tasks`);
      });
    }
    console.log('');
  });
  
  console.log('⚠️  MEDIUM SEVERITY BLOCKERS\n');
  
  const medBlockers = BOTTLENECKS.filter(b => b.severity === 'MEDIUM');
  medBlockers.forEach((b, i) => {
    console.log(`${i + 1}. TASK #${b.task}: ${b.title}`);
    console.log('   ─────────────────────────────────────────────────────────────');
    console.log(`   Impact:       ${b.impact}`);
    console.log(`   Action:       ${b.action}`);
    console.log('');
  });
}

/**
 * Generate weekly report
 */
function generateWeeklyReport(weekRange) {
  const weekData = getWeekTasks(weekRange);
  
  if (!weekData) {
    console.log(`\n❌ Invalid week range: ${weekRange}`);
    console.log('Valid ranges: Week 1-2, Week 3-4, Week 5-6, Week 7-8, Week 9-10, Week 11-12\n');
    return;
  }
  
  console.log(`\n╔════════════════════════════════════════════════════════════════╗`);
  console.log(`║                    ${weekRange} EXECUTION PLAN                    ║`);
  console.log(`╚════════════════════════════════════════════════════════════════╝\n`);
  
  console.log(`🎯 FOCUS: ${weekData.focus}\n`);
  
  if (weekData.mustComplete) {
    console.log(`✅ MUST COMPLETE (${weekData.mustComplete.length} tasks)`);
    console.log('─────────────────────────────────────────────────────────────────');
    weekData.mustComplete.forEach(task => {
      console.log(`   • #${task}`);
    });
    console.log('');
  }
  
  if (weekData.complete) {
    console.log(`✅ COMPLETE (${weekData.complete.length} tasks)`);
    console.log('─────────────────────────────────────────────────────────────────');
    weekData.complete.forEach(task => {
      console.log(`   • #${task}`);
    });
    console.log('');
  }
  
  if (weekData.start) {
    console.log(`🚀 START (${weekData.start.length} tasks)`);
    console.log('─────────────────────────────────────────────────────────────────');
    weekData.start.forEach(task => {
      console.log(`   • #${task}`);
    });
    console.log('');
  }
  
  if (weekData.evaluate) {
    console.log(`📊 EVALUATE (${weekData.evaluate.length} optional features)`);
    console.log('─────────────────────────────────────────────────────────────────');
    weekData.evaluate.forEach(task => {
      console.log(`   • #${task}`);
    });
    console.log('');
  }
  
  console.log('🎓 SUCCESS CRITERIA');
  console.log('─────────────────────────────────────────────────────────────────');
  weekData.successCriteria.forEach(criteria => {
    console.log(`   ✓ ${criteria}`);
  });
  console.log('');
}

/**
 * Generate task dependency report
 */
function generateTaskDependencyReport(taskNumber) {
  console.log(`\n╔════════════════════════════════════════════════════════════════╗`);
  console.log(`║               TASK #${taskNumber} - DEPENDENCY ANALYSIS                ║`);
  console.log(`╚════════════════════════════════════════════════════════════════╝\n`);
  
  // Find what this task depends on
  const prereqs = findPrerequisites(taskNumber);
  
  if (prereqs.length > 0) {
    console.log('📥 PREREQUISITES (Tasks this depends on)');
    console.log('─────────────────────────────────────────────────────────────────');
    prereqs.forEach(p => {
      console.log(`   • #${p.anchor} (${p.chain})`);
      console.log(`     Timeline: ${p.timeline}`);
    });
    console.log('');
  } else {
    console.log('📥 PREREQUISITES: None (Foundation task)\n');
  }
  
  // Find what depends on this task
  const dependents = findDependentTasks(taskNumber);
  
  if (dependents.length > 0) {
    console.log('📤 DEPENDENTS (Tasks that depend on this)');
    console.log('─────────────────────────────────────────────────────────────────');
    dependents.forEach(d => {
      console.log(`   Chain: ${d.chain}`);
      console.log(`   Tasks: ${d.tasks.join(', ')}`);
      console.log(`   Cascade Impact: ${d.impact}`);
      console.log('');
    });
  } else {
    console.log('📤 DEPENDENTS: None (Leaf task)\n');
  }
}

// ============================================================================
// CLI INTERFACE
// ============================================================================

function main() {
  const args = process.argv.slice(2);
  
  if (args.length === 0 || args.includes('--help') || args.includes('-h')) {
    console.log(`
Critical Path Tracker - Issue #2946

USAGE:
  node scripts/critical-path-tracker.js [OPTIONS]

OPTIONS:
  --status              Show overall status dashboard
  --blockers            Show blocker analysis
  --week <range>        Show weekly execution plan (e.g., "Week 1-2")
  --task <number>       Show dependency analysis for specific task
  --help, -h            Show this help message

EXAMPLES:
  node scripts/critical-path-tracker.js --status
  node scripts/critical-path-tracker.js --blockers
  node scripts/critical-path-tracker.js --week "Week 3-4"
  node scripts/critical-path-tracker.js --task 2855
    `);
    return;
  }
  
  if (args.includes('--status')) {
    generateStatusReport();
  } else if (args.includes('--blockers')) {
    generateBlockerReport();
  } else if (args.includes('--week')) {
    const weekIndex = args.indexOf('--week');
    const weekRange = args[weekIndex + 1];
    generateWeeklyReport(weekRange);
  } else if (args.includes('--task')) {
    const taskIndex = args.indexOf('--task');
    const taskNumber = parseInt(args[taskIndex + 1]);
    generateTaskDependencyReport(taskNumber);
  } else {
    console.log('Unknown option. Use --help for usage information.');
  }
}

// ============================================================================
// EXPORTS
// ============================================================================

module.exports = {
  calculateProgress,
  findDependentTasks,
  findPrerequisites,
  identifyBlockers,
  getWeekTasks,
  TASK_DEPENDENCIES,
  EXECUTION_TIMELINE,
  BOTTLENECKS
};

// Run CLI if called directly
if (require.main === module) {
  main();
}
