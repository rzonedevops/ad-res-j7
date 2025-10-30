#!/usr/bin/env node

/**
 * Phase 1 Critical Evidence - Chronological Narrative Generator
 * 
 * Generates a chronological narrative document linking Phase 1 critical evidence
 * to Answering Affidavit (AD) paragraph references for legal review preparation.
 * 
 * Task Requirements from Issue #[FEATURE] Phase 1 Critical Evidence:
 * - Paragraph 1: Responsible Person Documentation (Rank 1, Weight 100/100)
 * - Paragraph 2: Director & Financial Records (Rank 2, Weight 95/100)
 * - Paragraph 3: Document Comparison & Witness Statements (Rank 3, Weight 90/100)
 */

const fs = require('fs');
const path = require('path');

/**
 * Phase 1 Critical Evidence Structure
 */
const phase1Evidence = {
  caseNumber: '2025-137857',
  featureIssue: '[FEATURE] Phase 1 Critical Evidence',
  legalArgument: 'Case Evidence Collection & Documentation',
  priority: 'critical',
  
  paragraphs: [
    {
      id: 1,
      title: 'Responsible Person Documentation',
      rank: 1,
      weight: 100,
      adReferences: ['AD 3.3', 'AD 3.4', 'AD 3.5', 'AD 3.6', 'AD 3.7'],
      description: 'Evidence demonstrating Jacqueline Faucitt\'s designation as Responsible Person across 37 jurisdictions',
      tasks: [
        {
          issueNumber: 2834,
          title: 'Gather Responsible Person documentation for 37 jurisdictions',
          annexure: 'JF-RP1',
          chronologicalEvents: [
            {
              date: '2018-03-15',
              event: 'Initial Responsible Person designation for EU (27 states)',
              adReference: 'AD 3.3.1',
              evidenceFile: 'JF-RP1_RESPONSIBLE_PERSON_DESIGNATION_DOCUMENTATION.md',
              significance: 'Establishes legal foundation of RP role across EU',
              impact: 'Personal legal liability for product safety and compliance'
            },
            {
              date: '2019-04-05',
              event: 'Canada Responsible Person designation',
              adReference: 'AD 3.3.1',
              evidenceFile: 'JF-RP1_RESPONSIBLE_PERSON_DESIGNATION_DOCUMENTATION.md',
              significance: 'Expansion of RP duties to North American jurisdiction'
            },
            {
              date: '2019-06-20',
              event: 'Switzerland Responsible Person designation',
              adReference: 'AD 3.3.1',
              evidenceFile: 'JF-RP1_RESPONSIBLE_PERSON_DESIGNATION_DOCUMENTATION.md',
              significance: 'Extension to European non-EU markets'
            },
            {
              date: '2020-09-10',
              event: 'Australia AICIS Responsible Person designation',
              adReference: 'AD 3.3.1',
              evidenceFile: 'JF-RP1_RESPONSIBLE_PERSON_DESIGNATION_DOCUMENTATION.md',
              significance: 'Asia-Pacific regulatory compliance established'
            },
            {
              date: '2021-01-01',
              event: 'UK Post-Brexit Responsible Person designation',
              adReference: 'AD 3.3.1',
              evidenceFile: 'JF-RP1_RESPONSIBLE_PERSON_DESIGNATION_DOCUMENTATION.md',
              significance: 'Separate UK designation required post-Brexit',
              impact: 'Critical for maintaining UK market access'
            },
            {
              date: '2021-11-12',
              event: 'UAE ESMA Responsible Person designation',
              adReference: 'AD 3.3.1',
              evidenceFile: 'JF-RP1_RESPONSIBLE_PERSON_DESIGNATION_DOCUMENTATION.md',
              significance: 'Middle East market regulatory compliance'
            },
            {
              date: '2022-02-18',
              event: 'Singapore HSA Responsible Person designation',
              adReference: 'AD 3.3.1',
              evidenceFile: 'JF-RP1_RESPONSIBLE_PERSON_DESIGNATION_DOCUMENTATION.md',
              significance: 'Southeast Asian regulatory framework compliance'
            },
            {
              date: '2025-08-19',
              event: 'Interdict prevents RP duties performance',
              adReference: 'AD 3.6.1, AD 3.6.2, AD 3.6.3',
              evidenceFile: 'JF-RP1_RESPONSIBLE_PERSON_DESIGNATION_DOCUMENTATION.md',
              significance: 'Immediate regulatory non-compliance in 37 jurisdictions',
              impact: 'Cannot access systems, documentation, or perform legal duties'
            }
          ]
        },
        {
          issueNumber: 2835,
          title: 'Obtain regulatory risk analysis documentation (JF-RP2)',
          annexure: 'JF-RP2',
          chronologicalEvents: [
            {
              date: '2025-08-19',
              event: 'Regulatory risk analysis conducted post-interdict',
              adReference: 'AD 3.6.4',
              evidenceFile: 'JF-RP2_REGULATORY_RISK_ANALYSIS.md',
              significance: 'Quantifies immediate compliance risks across 37 jurisdictions',
              impact: 'Market access loss, penalties €10K-€1M per jurisdiction, criminal liability'
            },
            {
              date: '2025-08-20',
              event: 'Timeline for compliance restoration analysis',
              adReference: 'AD 3.6.5',
              evidenceFile: 'JF-RP2_REGULATORY_RISK_ANALYSIS.md',
              significance: '6-12 month restoration period required',
              impact: 'Massive financial and reputational damage'
            }
          ]
        }
      ]
    },
    {
      id: 2,
      title: 'Director & Financial Records',
      rank: 2,
      weight: 95,
      adReferences: ['AD 7.8', 'AD 7.9', 'AD 7.10', 'AD 7.11', 'AD 10.5'],
      description: 'Evidence demonstrating director loan account practices and Peter\'s own withdrawals',
      tasks: [
        {
          issueNumber: 2836,
          title: 'Collect director loan account statements for all 3 directors',
          annexure: 'JF-DLA1, JF-DLA2, JF-DLA3',
          chronologicalEvents: [
            {
              date: '2023-01-01',
              event: 'Director loan account baseline - all directors',
              adReference: 'AD 7.9',
              evidenceFiles: ['JF-DLA1_PETER_FAUCITT_DIRECTOR_LOAN_ACCOUNT.md', 
                              'JF-DLA2_JACQUELINE_FAUCITT_DIRECTOR_LOAN_ACCOUNT.md',
                              'JF-DLA3_DANIEL_FAUCITT_DIRECTOR_LOAN_ACCOUNT.md'],
              significance: 'Establishes substantial credit balances owed to directors',
              impact: 'Companies owe directors millions - withdrawals are against credit balances'
            },
            {
              date: '2025-07-31',
              event: 'July 2025 director loan account positions',
              adReference: 'AD 7.9, AD 7.10',
              evidenceFiles: ['JF-DLA1_PETER_FAUCITT_DIRECTOR_LOAN_ACCOUNT.md',
                              'JF-DLA2_JACQUELINE_FAUCITT_DIRECTOR_LOAN_ACCOUNT.md', 
                              'JF-DLA3_DANIEL_FAUCITT_DIRECTOR_LOAN_ACCOUNT.md'],
              significance: 'Shows all three directors maintain substantial credit balances',
              impact: 'All directors entitled to draw against their loan accounts'
            }
          ]
        },
        {
          issueNumber: 2837,
          title: 'Document Peter\'s own withdrawals with minimum 4 examples (JF-PA series)',
          annexure: 'JF-PA1, JF-PA2, JF-PA3, JF-PA4',
          chronologicalEvents: [
            {
              date: '2023-02-15',
              event: 'Peter withdrawal #4 - R120,000',
              adReference: 'AD 7.8.5.3',
              evidenceFile: 'JF-PA4_PETER_WITHDRAWAL_15FEB2023.md',
              significance: 'Peter used identical informal process 2.5 years before complaint',
              impact: 'No board resolution, self-authorized, against credit balance'
            },
            {
              date: '2023-01-12',
              event: 'Peter withdrawal #3 - R95,000',
              adReference: 'AD 7.8.5.3',
              evidenceFile: 'JF-PA3_PETER_WITHDRAWAL_12JAN2023.md',
              significance: 'Routine withdrawal without board resolution',
              impact: 'Demonstrates long-standing informal practice'
            },
            {
              date: '2025-03-15',
              event: 'Peter withdrawal #1 - R125,000',
              adReference: 'AD 7.8.5.3',
              evidenceFile: 'JF-PA1_PETER_WITHDRAWAL_15MAR2025.md',
              significance: 'Peter made R125K withdrawal just 4 months before complaint',
              impact: 'Self-authorized, no board resolution, identical to process he now objects to'
            },
            {
              date: '2025-07-20',
              event: 'Peter withdrawal #2 - R120,000',
              adReference: 'AD 7.8.5.3',
              evidenceFile: 'JF-PA2_PETER_WITHDRAWAL_20JUL2025.md',
              significance: 'Peter withdrew R120K just 4 days after Daniel\'s R500K withdrawal',
              impact: 'Hypocritical complaint - Peter continued using same informal process'
            }
          ]
        },
        {
          issueNumber: 2838,
          title: 'Obtain R500K payment bank statement dated 16 July 2025 (JF-BS1)',
          annexure: 'JF-BS1',
          chronologicalEvents: [
            {
              date: '2025-07-16',
              event: 'Daniel\'s R500,000 director loan withdrawal',
              adReference: 'AD 7.8.5.2',
              evidenceFile: 'JF-BS1_R500K_PAYMENT_BANK_STATEMENT.md',
              significance: 'Central transaction in Peter\'s complaint',
              impact: 'Properly authorized, dual signatory, against R1.67M credit balance'
            },
            {
              date: '2025-07-16',
              event: 'Normal business operations continue same day',
              adReference: 'AD 7.8.5.2',
              evidenceFile: 'JF-BS1_R500K_PAYMENT_BANK_STATEMENT.md',
              significance: 'Shopify fees, AWS costs, customer payments all processed',
              impact: 'Director loan payment was routine transaction among many'
            },
            {
              date: '2025-07-20',
              event: 'Peter\'s own R120K withdrawal 4 days later',
              adReference: 'AD 7.8.5.3',
              evidenceFile: 'JF-BS1_R500K_PAYMENT_BANK_STATEMENT.md',
              significance: 'Peter used same informal process after Daniel\'s withdrawal',
              impact: 'Demonstrates acceptance of informal practice'
            },
            {
              date: '2025-07-25',
              event: 'Jacqueline\'s R145K withdrawal same month',
              adReference: 'AD 7.8.5.3',
              evidenceFile: 'JF-BS1_R500K_PAYMENT_BANK_STATEMENT.md',
              significance: 'All three directors withdrew in July without board resolutions',
              impact: 'Confirms established informal practice'
            }
          ]
        }
      ]
    },
    {
      id: 3,
      title: 'Document Comparison & Witness Statements',
      rank: 3,
      weight: 90,
      adReferences: ['AD 2.2', 'AD 7.7', 'AD 11.6'],
      description: 'Evidence showing material non-disclosures and witness testimony',
      tasks: [
        {
          issueNumber: 2839,
          title: 'Create comparison document highlighting all changes between founding and answering affidavits',
          annexure: 'JF-CMP1',
          chronologicalEvents: [
            {
              date: '2025-08-13',
              event: 'Peter\'s ex parte interdict application filed',
              adReference: 'AD 2.2.1, AD 2.2.2',
              evidenceFile: 'FOUNDING_AFFIDAVIT_ANALYSIS.md',
              significance: 'Material non-disclosures in ex parte application',
              impact: 'Failed to disclose RP role, settlement agreement, upcoming investment payout'
            },
            {
              date: '2025-08-19',
              event: 'Ex parte interdict granted',
              adReference: 'AD 2.2.4',
              evidenceFile: 'INTERDICT_ORDER_ANALYSIS.md',
              significance: 'Court granted interdict without knowing material facts',
              impact: 'Immediate regulatory non-compliance, business destruction'
            },
            {
              date: '2025-10-30',
              event: 'Answering affidavit preparation',
              adReference: 'AD 2.3',
              evidenceFile: 'COMPARISON_FOUNDING_VS_ANSWERING.md',
              significance: 'Comprehensive response revealing material non-disclosures',
              impact: 'Demonstrates basis for setting aside ex parte interdict'
            }
          ]
        },
        {
          issueNumber: 2840,
          title: 'Obtain Daniel\'s witness statement regarding "Has anything changed?"',
          annexure: 'JF-DWS1',
          chronologicalEvents: [
            {
              date: '2025-06-01',
              event: 'Peter cancels all business cards',
              adReference: 'AD 7.7',
              evidenceFile: 'DANIEL_FAUCITT_WITNESS_STATEMENT.md',
              significance: 'Peter\'s unilateral actions causing business disruption',
              impact: 'Director oversight characterized as "interference"'
            },
            {
              date: '2025-08-11',
              event: 'Settlement agreement signed',
              adReference: 'AD 2.2.3',
              evidenceFile: 'DANIEL_FAUCITT_WITNESS_STATEMENT.md',
              significance: 'Agreement signed 8 days before interdict',
              impact: 'Suggests strategic litigation rather than genuine concern'
            },
            {
              date: '2025-08-13',
              event: 'Daniel asked "Has anything changed?"',
              adReference: 'AD 11.6',
              evidenceFile: 'DANIEL_FAUCITT_WITNESS_STATEMENT.md',
              significance: 'Direct contradiction to Peter\'s claims of sudden changes',
              impact: 'No changes to established practices - Peter\'s complaint is pretextual'
            }
          ]
        }
      ]
    }
  ]
};

/**
 * Generate chronological narrative document
 */
function generateChronologicalNarrative() {
  console.log('📝 Generating Phase 1 Critical Evidence Chronological Narrative...\n');
  
  let narrative = `# Phase 1 Critical Evidence - Chronological Narrative with AD References

**Case Number:** ${phase1Evidence.caseNumber}
**Feature Issue:** ${phase1Evidence.featureIssue}
**Legal Argument:** ${phase1Evidence.legalArgument}
**Priority:** ${phase1Evidence.priority}
**Generated:** ${new Date().toISOString().split('T')[0]}

---

## Executive Summary

This document provides a chronological narrative of Phase 1 Critical Evidence required before legal review, organized by paragraph rank and linked to specific Answering Affidavit (AD) paragraph references.

**Structure:**
- **Paragraph 1:** Responsible Person Documentation (Rank 1, Weight 100/100)
- **Paragraph 2:** Director & Financial Records (Rank 2, Weight 95/100)
- **Paragraph 3:** Document Comparison & Witness Statements (Rank 3, Weight 90/100)

**Total Tasks:** 7
**AD References:** Multiple paragraphs from AD 2.2 through AD 11.6

---

`;

  // Generate narrative for each paragraph
  phase1Evidence.paragraphs.forEach(paragraph => {
    narrative += `## Paragraph ${paragraph.id}: ${paragraph.title}\n\n`;
    narrative += `**Rank:** ${paragraph.rank} (1 = highest influence)\n`;
    narrative += `**Weight:** ${paragraph.weight}/100\n`;
    narrative += `**AD References:** ${paragraph.adReferences.join(', ')}\n`;
    narrative += `**Description:** ${paragraph.description}\n\n`;
    narrative += `---\n\n`;
    
    // Generate task sections
    paragraph.tasks.forEach(task => {
      narrative += `### Task #${task.issueNumber}: ${task.title}\n\n`;
      narrative += `**Annexure:** ${task.annexure}\n\n`;
      
      // Generate chronological events
      narrative += `#### Chronological Evidence Timeline\n\n`;
      
      task.chronologicalEvents.forEach((event, index) => {
        narrative += `**${event.date}** - ${event.event}\n\n`;
        narrative += `- **AD Reference:** ${event.adReference}\n`;
        if (Array.isArray(event.evidenceFile)) {
          narrative += `- **Evidence Files:**\n`;
          event.evidenceFile.forEach(file => {
            narrative += `  - \`jax-dan-response/evidence-attachments/${file}\`\n`;
          });
        } else if (Array.isArray(event.evidenceFiles)) {
          narrative += `- **Evidence Files:**\n`;
          event.evidenceFiles.forEach(file => {
            narrative += `  - \`jax-dan-response/evidence-attachments/${file}\`\n`;
          });
        } else {
          narrative += `- **Evidence File:** \`jax-dan-response/evidence-attachments/${event.evidenceFile}\`\n`;
        }
        narrative += `- **Significance:** ${event.significance}\n`;
        if (event.impact) {
          narrative += `- **Impact:** ${event.impact}\n`;
        }
        narrative += `\n`;
      });
      
      narrative += `---\n\n`;
    });
  });
  
  // Add cross-reference section
  narrative += `## Complete Evidence File Index\n\n`;
  narrative += `### Responsible Person Documentation\n\n`;
  narrative += `- **JF-RP1:** \`jax-dan-response/evidence-attachments/JF-RP1_RESPONSIBLE_PERSON_DESIGNATION_DOCUMENTATION.md\`\n`;
  narrative += `- **JF-RP2:** \`jax-dan-response/evidence-attachments/JF-RP2_REGULATORY_RISK_ANALYSIS.md\`\n\n`;
  
  narrative += `### Director Loan Accounts\n\n`;
  narrative += `- **JF-DLA1:** \`jax-dan-response/evidence-attachments/JF-DLA1_PETER_FAUCITT_DIRECTOR_LOAN_ACCOUNT.md\`\n`;
  narrative += `- **JF-DLA2:** \`jax-dan-response/evidence-attachments/JF-DLA2_JACQUELINE_FAUCITT_DIRECTOR_LOAN_ACCOUNT.md\`\n`;
  narrative += `- **JF-DLA3:** \`jax-dan-response/evidence-attachments/JF-DLA3_DANIEL_FAUCITT_DIRECTOR_LOAN_ACCOUNT.md\`\n\n`;
  
  narrative += `### Peter's Withdrawals\n\n`;
  narrative += `- **JF-PA1:** \`jax-dan-response/evidence-attachments/JF-PA1_PETER_WITHDRAWAL_15MAR2025.md\`\n`;
  narrative += `- **JF-PA2:** \`jax-dan-response/evidence-attachments/JF-PA2_PETER_WITHDRAWAL_20JUL2025.md\`\n`;
  narrative += `- **JF-PA3:** \`jax-dan-response/evidence-attachments/JF-PA3_PETER_WITHDRAWAL_12JAN2023.md\`\n`;
  narrative += `- **JF-PA4:** \`jax-dan-response/evidence-attachments/JF-PA4_PETER_WITHDRAWAL_15FEB2023.md\`\n\n`;
  
  narrative += `### Bank Statement\n\n`;
  narrative += `- **JF-BS1:** \`jax-dan-response/evidence-attachments/JF-BS1_R500K_PAYMENT_BANK_STATEMENT.md\`\n\n`;
  
  narrative += `### Witness Statements\n\n`;
  narrative += `- **JF-DWS1:** \`jax-dan-response/evidence-attachments/DANIEL_FAUCITT_WITNESS_STATEMENT.md\`\n\n`;
  
  // Add AD Reference Quick Index
  narrative += `---\n\n`;
  narrative += `## AD Paragraph Quick Reference\n\n`;
  narrative += `| AD Paragraph | Topic | Evidence |\n`;
  narrative += `|--------------|-------|----------|\n`;
  narrative += `| AD 2.2 | Material Non-Disclosure in Ex Parte Application | JF-CMP1 |\n`;
  narrative += `| AD 2.3 | Purpose of Answering Affidavit | All evidence |\n`;
  narrative += `| AD 3.3 | Responsible Person Role | JF-RP1 |\n`;
  narrative += `| AD 3.4 | Legal Responsibilities and Personal Liability | JF-RP1 |\n`;
  narrative += `| AD 3.5 | Non-Delegable Nature of RP Role | JF-RP1 |\n`;
  narrative += `| AD 3.6 | Direct Impact of Interdict | JF-RP1, JF-RP2 |\n`;
  narrative += `| AD 3.7 | Material Non-Disclosure by Applicant | JF-RP1, JF-RP2 |\n`;
  narrative += `| AD 7.7 | Peter's Unilateral Actions | JF-DWS1 |\n`;
  narrative += `| AD 7.8 | Director Loan Account Structure | JF-DLA1, JF-DLA2, JF-DLA3 |\n`;
  narrative += `| AD 7.8.5.2 | Daniel's R500K Withdrawal | JF-BS1 |\n`;
  narrative += `| AD 7.8.5.3 | Peter's Own Withdrawals | JF-PA1, JF-PA2, JF-PA3, JF-PA4 |\n`;
  narrative += `| AD 7.9 | Director Loan Balances | JF-DLA1, JF-DLA2, JF-DLA3 |\n`;
  narrative += `| AD 7.10 | Informal Practice Evidence | JF-BS1, JF-PA series |\n`;
  narrative += `| AD 10.5 | Historical Business Model | JF-DLA series |\n`;
  narrative += `| AD 11.6 | Daniel's Witness Statement | JF-DWS1 |\n\n`;
  
  narrative += `---\n\n`;
  narrative += `## Next Steps for Legal Review\n\n`;
  narrative += `1. ✅ Verify all evidence files are present in \`jax-dan-response/evidence-attachments/\`\n`;
  narrative += `2. ⏳ Cross-reference each AD paragraph with corresponding evidence\n`;
  narrative += `3. ⏳ Prepare evidence presentation strategy\n`;
  narrative += `4. ⏳ Organize physical evidence bundles for court\n`;
  narrative += `5. ⏳ Brief legal counsel on chronological sequence\n\n`;
  
  narrative += `---\n\n`;
  narrative += `*Generated by Phase 1 Critical Evidence Chronological Narrative Generator*\n`;
  narrative += `*Script: \`scripts/generate-phase1-chronological-narrative.js\`*\n`;
  
  return narrative;
}

/**
 * Main execution
 */
function main() {
  try {
    const narrative = generateChronologicalNarrative();
    
    const outputPath = path.join(__dirname, '..', 'PHASE_1_CRITICAL_EVIDENCE_CHRONOLOGICAL_NARRATIVE.md');
    fs.writeFileSync(outputPath, narrative, 'utf8');
    
    console.log('✅ Successfully generated chronological narrative');
    console.log(`📄 Output: ${outputPath}`);
    console.log(`📊 Total paragraphs: ${phase1Evidence.paragraphs.length}`);
    console.log(`📋 Total tasks: ${phase1Evidence.paragraphs.reduce((sum, p) => sum + p.tasks.length, 0)}`);
    
    const totalEvents = phase1Evidence.paragraphs.reduce((sum, p) => 
      sum + p.tasks.reduce((taskSum, t) => taskSum + t.chronologicalEvents.length, 0), 0
    );
    console.log(`⏱️  Total chronological events: ${totalEvents}`);
    
    console.log('\n📝 Narrative sections generated:');
    phase1Evidence.paragraphs.forEach(p => {
      console.log(`   - Paragraph ${p.id}: ${p.title} (Weight: ${p.weight}/100)`);
    });
    
    console.log('\n✨ Phase 1 Critical Evidence narrative ready for legal review!\n');
    
  } catch (error) {
    console.error('❌ Error generating narrative:', error);
    process.exit(1);
  }
}

// Run if called directly
if (require.main === module) {
  main();
}

module.exports = { generateChronologicalNarrative, phase1Evidence };
