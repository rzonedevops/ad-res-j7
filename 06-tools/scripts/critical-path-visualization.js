#!/usr/bin/env node

/**
 * Critical Path Dependency Graph Visualization
 * 
 * Generates ASCII and Mermaid visualizations of task dependencies,
 * critical paths, and completion status for Issue #2946.
 */

const fs = require('fs');
const path = require('path');

// Import dependency data from tracker
const {
  TASK_DEPENDENCIES,
  EXECUTION_TIMELINE,
  BOTTLENECKS
} = require('./critical-path-tracker');

// ============================================================================
// ASCII VISUALIZATION
// ============================================================================

function generateASCIIGraph() {
  console.log('\n╔════════════════════════════════════════════════════════════════╗');
  console.log('║        CRITICAL PATH DEPENDENCY GRAPH - ASCII VIEW            ║');
  console.log('╚════════════════════════════════════════════════════════════════╝\n');
  
  console.log('Legend: ⬛ Foundation | 🔷 Integration | ✅ Validation | ⚠️ Bottleneck\n');
  console.log('');
  
  console.log('FOUNDATION LAYER (Week 1-2)');
  console.log('═══════════════════════════════════════════════════════════════');
  console.log('');
  console.log('  Security Infrastructure');
  console.log('  ⬛ #2771 Fix security vulnerability');
  console.log('  ⬛ #2774 Verify issue creation');
  console.log('  ⬛ #2776 Implement batching');
  console.log('  │');
  console.log('  Phase 1 Critical Evidence');
  console.log('  ⬛ #2838 R500K payment statement');
  console.log('  ⬛ #2836 Director loan accounts');
  console.log('  ⚠️ #2834 Responsible Person (37 jurisdictions) [4-6 weeks]');
  console.log('  ⬛ #2837 Peter\'s withdrawals');
  console.log('  ⬛ #2835 Regulatory risk analysis');
  console.log('  │');
  console.log('  ⬛ #2841 Chesno fraud documentation');
  console.log('  │');
  console.log('  └─────────────────────────────────────┐');
  console.log('                                         │');
  console.log('                                         ▼');
  console.log('');
  
  console.log('INTEGRATION LAYER (Week 3-8)');
  console.log('═══════════════════════════════════════════════════════════════');
  console.log('');
  console.log('  Evidence Index Chain');
  console.log('  🔷 #2855 Comprehensive Evidence Index [275+ files]');
  console.log('     │');
  console.log('     ├─→ #2853 Verify annexure references');
  console.log('     ├─→ #2879 Test cross-reference system');
  console.log('     └─→ #2900 Update "Referenced By" sections');
  console.log('');
  console.log('  Timeline Analysis Chain');
  console.log('  🔷 #2857 Update case timeline [15 events]');
  console.log('     │');
  console.log('     ├─→ #2858 Visual timeline diagram');
  console.log('     ├─→ #2863 Date accuracy verification [GATE]');
  console.log('     └─→ #2893 Comprehensive timeline analysis');
  console.log('');
  console.log('  Date Validation Chain');
  console.log('  🔷 #2869 Validate dates [revenue/trust/flows]');
  console.log('     │');
  console.log('     ├─→ #2870 Cross-border flow analysis');
  console.log('     ├─→ #2875 Timeline visualization');
  console.log('     └─→ #2876 Damage calculation methodology');
  console.log('');
  console.log('  Civil Evidence Test Suite Chain [CRITICAL]');
  console.log('  ⚠️ #2789 Civil Evidence Test Suite');
  console.log('     │   [Enables 8 tasks, 6-week cascade risk]');
  console.log('     │');
  console.log('     ├─→ #2790 Preponderance assessment pipeline');
  console.log('     ├─→ #2791 Monitoring & alerting');
  console.log('     ├─→ #2792 Balance of probabilities framework');
  console.log('     ├─→ #2794 Balance of probabilities test suite');
  console.log('     ├─→ #2795 Hearsay evidence validation');
  console.log('     ├─→ #2796 Expert testimony validation');
  console.log('     ├─→ #2797 Witness credibility assessment');
  console.log('     └─→ #2798 Duplicate prevention');
  console.log('');
  console.log('                                         │');
  console.log('                                         ▼');
  console.log('');
  
  console.log('VALIDATION LAYER (Week 9-10)');
  console.log('═══════════════════════════════════════════════════════════════');
  console.log('');
  console.log('  Quality Gates');
  console.log('  ✅ #2863 Date accuracy verification [GATE]');
  console.log('  ✅ #2864 Annexure numbering check [GATE]');
  console.log('  ✅ #2903 Contradiction check [GATE]');
  console.log('  ✅ #2891/2897 Legal review preparation [FINAL GATE]');
  console.log('');
  console.log('═══════════════════════════════════════════════════════════════');
  console.log('');
}

// ============================================================================
// MERMAID DIAGRAM GENERATION
// ============================================================================

function generateMermaidDiagram() {
  const mermaid = `
# Critical Path Dependencies - Mermaid Diagram

\`\`\`mermaid
graph TD
    %% Foundation Layer
    subgraph foundation[Foundation Layer - Week 1-2]
        SEC[#2771 Security Fix]
        ISS[#2774 Issue Creation]
        BAT[#2776 Batching]
        
        BANK[#2838 R500K Statement]
        LOAN[#2836 Director Loans]
        RP[#2834 Responsible Person<br/>37 jurisdictions<br/>⚠️ 4-6 weeks]
        WIT[#2837 Peter Withdrawals]
        REG[#2835 Regulatory Risk]
        
        CHES[#2841 Chesno Fraud]
    end
    
    %% Integration Layer - Evidence Index
    subgraph evidence[Evidence Index Chain - Week 3-4]
        IDX[#2855 Evidence Index<br/>275+ files]
        IDX --> ANN[#2853 Verify Annexures]
        IDX --> XR[#2879 Test Cross-Ref]
        IDX --> REF[#2900 Referenced By]
    end
    
    %% Integration Layer - Timeline
    subgraph timeline[Timeline Chain - Week 3-6]
        TL[#2857 Update Timeline<br/>15 events]
        TL --> VIS[#2858 Visual Timeline]
        TL --> DATE[#2863 Date Verification<br/>✅ GATE]
        TL --> ANA[#2893 Timeline Analysis]
    end
    
    %% Integration Layer - Date Validation
    subgraph dates[Date Validation Chain - Week 5-6]
        VAL[#2869 Validate Dates]
        VAL --> CB[#2870 Cross-Border Analysis]
        VAL --> TV[#2875 Timeline Viz]
        VAL --> DMG[#2876 Damage Calc]
    end
    
    %% Integration Layer - Civil Evidence
    subgraph civil[Civil Evidence Chain - Week 5-6]
        CIV[#2789 Civil Evidence Suite<br/>⚠️ Enables 8 tasks]
        CIV --> PREP[#2790 Preponderance Pipeline]
        CIV --> MON[#2791 Monitoring]
        CIV --> BAL1[#2792 Balance Framework]
        CIV --> BAL2[#2794 Balance Tests]
        CIV --> HEAR[#2795 Hearsay]
        CIV --> EXP[#2796 Expert Testimony]
        CIV --> WIT2[#2797 Witness Credibility]
        CIV --> DUP[#2798 Duplicate Prevention]
    end
    
    %% Validation Layer
    subgraph validation[Validation Layer - Week 9-10]
        GATE1[#2863 Date Gate ✅]
        GATE2[#2864 Annexure Gate ✅]
        GATE3[#2903 Contradiction Gate ✅]
        GATE4[#2891/2897 Legal Review Gate ✅]
    end
    
    %% Dependencies
    foundation --> evidence
    foundation --> timeline
    foundation --> dates
    foundation --> civil
    
    evidence --> validation
    timeline --> validation
    dates --> validation
    civil --> validation
    
    %% Styling
    classDef bottleneck fill:#ff6b6b,stroke:#c92a2a,stroke-width:3px
    classDef gate fill:#51cf66,stroke:#2b8a3e,stroke-width:3px
    classDef critical fill:#ffd43b,stroke:#fab005,stroke-width:2px
    
    class RP,CIV bottleneck
    class DATE,GATE1,GATE2,GATE3,GATE4 gate
    class IDX,TL,VAL critical
\`\`\`

## Dependency Statistics

- **Foundation Tasks:** 9
- **Integration Chains:** 4 (total 28 tasks)
- **Validation Gates:** 4
- **Critical Bottlenecks:** 2 (RP, CIV)
- **Total Tracked Tasks:** 150+

## Critical Path Analysis

### Longest Chain: Civil Evidence Suite
\`\`\`
#2789 → [8 dependent tasks] → 6-week cascade risk
Timeline: Week 5-6
Mitigation: Modular design, daily standup
\`\`\`

### Biggest Bottleneck: Responsible Person Documentation
\`\`\`
#2834 → 37 jurisdictions → 4-6 weeks
Timeline: Week 1-2 START
Mitigation: Parallelize by jurisdiction
\`\`\`

### Quality Gates (No Bypass)
\`\`\`
Week 9-10:
  ✅ #2863 - Date Accuracy
  ✅ #2864 - Annexure Numbering
  ✅ #2903 - Contradiction Check
  ✅ #2891/2897 - Legal Review Prep
\`\`\`
`;
  
  return mermaid;
}

// ============================================================================
// TIMELINE GANTT CHART
// ============================================================================

function generateGanttChart() {
  const gantt = `
# Critical Path Timeline - Gantt Chart

\`\`\`mermaid
gantt
    title Critical Path Dependencies - 12 Week Timeline
    dateFormat YYYY-MM-DD
    section Foundation
    Security (#2771)           :done, f1, 2025-11-01, 1w
    Phase 1 Evidence           :crit, f2, 2025-11-01, 2w
    Responsible Person (#2834) :crit, active, f3, 2025-11-01, 6w
    
    section Integration
    Evidence Index (#2855)     :crit, i1, 2025-11-15, 1w
    Timeline Update (#2857)    :i2, 2025-11-15, 2w
    Date Validation (#2869)    :i3, 2025-11-29, 1w
    Civil Evidence (#2789)     :crit, i4, 2025-11-29, 2w
    
    section Validation
    Date Gate (#2863)          :milestone, v1, 2025-12-20, 0d
    Annexure Gate (#2864)      :milestone, v2, 2025-12-20, 0d
    Contradiction Gate (#2903) :milestone, v3, 2025-12-27, 0d
    Legal Review Gate (#2891)  :milestone, v4, 2026-01-10, 0d
\`\`\`

## Week-by-Week Breakdown

| Week    | Focus                        | Tasks    | Critical |
|---------|------------------------------|----------|----------|
| 1-2     | Critical Foundation          | 9        | 8        |
| 3-4     | Evidence Building            | 12       | 2        |
| 5-6     | Forensic Analysis            | 18       | 3        |
| 7-8     | Integration & Quality        | 18       | 1        |
| 9-10    | Pre-Legal Review             | 28       | 4        |
| 11-12   | Final Validation             | 27       | 0        |
| **Total** | **All Phases**             | **112**  | **18**   |
`;
  
  return gantt;
}

// ============================================================================
// EXPORT FUNCTIONS
// ============================================================================

function exportVisualization() {
  const outputDir = path.join(__dirname, '..', 'docs', 'visualizations');
  
  // Ensure directory exists
  if (!fs.existsSync(outputDir)) {
    fs.mkdirSync(outputDir, { recursive: true });
  }
  
  // Generate Mermaid diagram
  const mermaidContent = generateMermaidDiagram();
  const mermaidPath = path.join(outputDir, 'CRITICAL_PATH_GRAPH.md');
  fs.writeFileSync(mermaidPath, mermaidContent);
  console.log(`✅ Mermaid diagram exported to: ${mermaidPath}`);
  
  // Generate Gantt chart
  const ganttContent = generateGanttChart();
  const ganttPath = path.join(outputDir, 'CRITICAL_PATH_TIMELINE.md');
  fs.writeFileSync(ganttPath, ganttContent);
  console.log(`✅ Gantt chart exported to: ${ganttPath}`);
  
  return {
    mermaid: mermaidPath,
    gantt: ganttPath
  };
}

// ============================================================================
// CLI INTERFACE
// ============================================================================

function main() {
  const args = process.argv.slice(2);
  
  if (args.includes('--help') || args.includes('-h')) {
    console.log(`
Critical Path Visualization Generator

USAGE:
  node scripts/critical-path-visualization.js [OPTIONS]

OPTIONS:
  --ascii       Display ASCII dependency graph
  --mermaid     Display Mermaid diagram code
  --gantt       Display Gantt chart code
  --export      Export all visualizations to docs/visualizations/
  --help, -h    Show this help message

EXAMPLES:
  node scripts/critical-path-visualization.js --ascii
  node scripts/critical-path-visualization.js --export
    `);
    return;
  }
  
  if (args.includes('--ascii') || args.length === 0) {
    generateASCIIGraph();
  }
  
  if (args.includes('--mermaid')) {
    console.log(generateMermaidDiagram());
  }
  
  if (args.includes('--gantt')) {
    console.log(generateGanttChart());
  }
  
  if (args.includes('--export')) {
    console.log('\n📊 Exporting visualizations...\n');
    const exported = exportVisualization();
    console.log('\n✅ Export complete!');
    console.log(`\nView visualizations:`);
    console.log(`  - Mermaid: ${exported.mermaid}`);
    console.log(`  - Gantt:   ${exported.gantt}\n`);
  }
}

// Run if called directly
if (require.main === module) {
  main();
}

module.exports = {
  generateASCIIGraph,
  generateMermaidDiagram,
  generateGanttChart,
  exportVisualization
};
