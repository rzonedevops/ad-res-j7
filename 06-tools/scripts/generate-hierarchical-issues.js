#!/usr/bin/env node

/**
 * Hierarchical Issue Generator
 * 
 * Consumes structured-todo.json (output from parse-todo-hierarchically.js)
 * and generates GitHub issues with full hierarchical metadata:
 * - Legal arguments
 * - Feature issues (with parent argument links)
 * - Paragraph metadata (rank, weight)
 * - Task issues (with parent feature and paragraph links)
 */

const fs = require('fs');

class HierarchicalIssueGenerator {
  constructor(structuredInputPath = 'structured-todo.json') {
    this.structuredData = null;
    this.issues = [];
    this.existingIssues = new Set();
    
    // Load structured input
    try {
      const content = fs.readFileSync(structuredInputPath, 'utf8');
      this.structuredData = JSON.parse(content);
    } catch (error) {
      throw new Error(`Failed to load structured input from ${structuredInputPath}: ${error.message}`);
    }
  }

  /**
   * Generate all issues from structured hierarchy
   */
  generateIssues() {
    console.log('🔄 Generating hierarchical issues from structured TODO data...\n');
    
    if (!this.structuredData || !this.structuredData.hierarchy) {
      throw new Error('Invalid structured data format');
    }
    
    const { tasks, paragraphs, features, legal_arguments } = this.structuredData.hierarchy;
    
    console.log(`Processing:`);
    console.log(`  - ${legal_arguments.length} legal arguments`);
    console.log(`  - ${features.length} features`);
    console.log(`  - ${paragraphs.length} paragraphs`);
    console.log(`  - ${tasks.length} tasks\n`);
    
    // Generate issues for each task
    let generatedCount = 0;
    let skippedCount = 0;
    
    for (const task of tasks) {
      const issue = this.generateTaskIssue(task, paragraphs, features, legal_arguments);
      
      if (issue) {
        this.issues.push(issue);
        generatedCount++;
      } else {
        skippedCount++;
      }
    }
    
    console.log(`✅ Generated ${generatedCount} issues`);
    console.log(`⚠️  Skipped ${skippedCount} issues (duplicates or invalid)\n`);
    
    return this.issues;
  }

  /**
   * Generate a single task issue with full hierarchical context
   */
  generateTaskIssue(task, paragraphs, features, legalArguments) {
    // Find parent paragraph
    const paragraph = paragraphs.find(p => p.id === task.paragraphId);
    if (!paragraph) {
      console.warn(`⚠️  Task ${task.id} has no parent paragraph, skipping`);
      return null;
    }
    
    // Find parent feature
    const feature = features.find(f => f.id === task.featureId);
    if (!feature) {
      console.warn(`⚠️  Task ${task.id} has no parent feature, skipping`);
      return null;
    }
    
    // Find legal argument
    const legalArgument = legalArguments.find(a => a.id === feature.argumentId);
    
    // Generate title with hierarchical prefix
    let title = this.cleanTitle(task.title);
    
    // Check for duplicates
    if (this.titleExists(title)) {
      const contextSuffix = ` (${feature.title.replace(/[^a-zA-Z0-9]/g, '').substring(0, 10)})`;
      if (title.length + contextSuffix.length <= 80) {
        title += contextSuffix;
      } else {
        title = title.substring(0, 80 - contextSuffix.length) + contextSuffix;
      }
    }
    
    // Track title
    this.existingIssues.add(this.normalizeTitle(title));
    
    // Generate labels with hierarchical metadata
    const labels = this.generateLabels(task, paragraph, feature, legalArgument);
    
    // Generate body with full hierarchical context
    const body = this.generateBody(task, paragraph, feature, legalArgument);
    
    return {
      title: title,
      body: body,
      labels: labels,
      metadata: {
        task_id: task.id,
        paragraph_id: paragraph.id,
        paragraph_rank: paragraph.rankOrder,
        paragraph_weight: paragraph.weight,
        feature_id: feature.id,
        feature_title: feature.title,
        argument_id: legalArgument ? legalArgument.id : null,
        argument_name: legalArgument ? legalArgument.name : null,
        task_rank: task.rankOrder,
        task_weight: task.weight,
        priority: task.priority
      },
      source: task
    };
  }

  /**
   * Generate labels with hierarchical information
   */
  generateLabels(task, paragraph, feature, legalArgument) {
    const labels = ['todo', 'task'];
    
    // Add hierarchical type labels
    labels.push('hierarchical-task');
    
    // Add priority label
    if (task.priority === 'critical') {
      labels.push('priority: critical', 'bug');
    } else if (task.priority === 'high') {
      labels.push('priority: high');
    } else if (task.priority === 'medium') {
      labels.push('priority: medium');
    } else if (task.priority === 'low') {
      labels.push('priority: low');
    }
    
    // Add rank label
    labels.push(`rank-${task.rankOrder}`);
    
    // Add weight category
    if (task.weight >= 90) {
      labels.push('weight-high');
    } else if (task.weight >= 60) {
      labels.push('weight-medium');
    } else {
      labels.push('weight-low');
    }
    
    // Add legal argument type if available
    if (legalArgument) {
      if (legalArgument.type === 'defense') {
        labels.push('legal-defense');
      } else if (legalArgument.type === 'evidence') {
        labels.push('legal-evidence');
      } else if (legalArgument.type === 'counterclaim') {
        labels.push('legal-counterclaim');
      }
    }
    
    return labels;
  }

  /**
   * Generate issue body with hierarchical context
   */
  generateBody(task, paragraph, feature, legalArgument) {
    let body = '## 📋 Task Description\n\n';
    body += task.description + '\n\n';
    
    body += '## 🏗️ Hierarchical Context\n\n';
    
    if (legalArgument) {
      body += `**Legal Argument:** ${legalArgument.name}\n`;
      body += `- Type: ${legalArgument.type}\n`;
      body += `- Strategy: ${legalArgument.strategy}\n\n`;
    }
    
    body += `**Feature Issue:** ${feature.title}\n`;
    body += `- Priority: ${feature.priority}\n`;
    body += `- Feature ID: \`${feature.id}\`\n\n`;
    
    body += `**Paragraph:** ${paragraph.title}\n`;
    body += `- Paragraph Number: ${paragraph.number}\n`;
    body += `- Rank Order: ${paragraph.rankOrder} (1 = highest influence)\n`;
    body += `- Weight: ${paragraph.weight}/100\n`;
    body += `- Paragraph ID: \`${paragraph.id}\`\n\n`;
    
    body += '## 📊 Task Metadata\n\n';
    body += `- **Task Rank:** ${task.rankOrder} (1 = highest priority within paragraph)\n`;
    body += `- **Task Weight:** ${task.weight}/100 (influence on paragraph)\n`;
    body += `- **Priority:** ${task.priority}\n`;
    body += `- **Task ID:** \`${task.id}\`\n\n`;
    
    body += '## 📁 Source Information\n\n';
    body += `**Source File:** \`${task.source}\`\n`;
    body += `**Line Number:** ${task.lineNumber}\n\n`;
    
    body += '## ✅ Acceptance Criteria\n\n';
    body += '- [ ] Review the task requirements in the hierarchical context\n';
    body += '- [ ] Ensure alignment with parent feature and legal argument\n';
    body += '- [ ] Implement the necessary changes\n';
    body += '- [ ] Test the implementation\n';
    body += '- [ ] Update documentation if needed\n';
    body += '- [ ] Verify contribution to paragraph and feature strength\n';
    body += '- [ ] Close this issue when complete\n\n';
    
    body += '---\n\n';
    body += '*Generated automatically from hierarchically-structured TODO files*\n';
    body += '*This issue is part of a 4-level hierarchy: Legal Argument → Feature → Paragraph → Task*';
    
    return body;
  }

  /**
   * Clean title for GitHub issue
   */
  cleanTitle(text) {
    // Remove markdown formatting
    let title = text.replace(/\*\*(.+?)\*\*/g, '$1');
    title = title.replace(/\*(.+?)\*/g, '$1');
    title = title.replace(/`(.+?)`/g, '$1');
    
    // Trim
    title = title.trim();
    
    // Limit length
    if (title.length > 80) {
      title = title.substring(0, 77) + '...';
    }
    
    return title;
  }

  /**
   * Normalize title for duplicate detection
   */
  normalizeTitle(title) {
    return title.toLowerCase()
      .replace(/[^\w\s]/g, '')
      .replace(/\s+/g, ' ')
      .trim();
  }

  /**
   * Check if title exists
   */
  titleExists(title) {
    const normalized = this.normalizeTitle(title);
    return this.existingIssues.has(normalized);
  }

  /**
   * Generate output JSON
   */
  generateOutput(outputPath = 'todo-issues.json') {
    const output = {
      summary: {
        total_issues: this.issues.length,
        priorities: {
          critical: this.issues.filter(i => i.source.priority === 'critical').length,
          high: this.issues.filter(i => i.source.priority === 'high').length,
          medium: this.issues.filter(i => i.source.priority === 'medium').length,
          low: this.issues.filter(i => i.source.priority === 'low').length
        },
        hierarchical_metadata: {
          legal_arguments: [...new Set(this.issues.map(i => i.metadata.argument_name).filter(Boolean))].length,
          features: [...new Set(this.issues.map(i => i.metadata.feature_id))].length,
          paragraphs: [...new Set(this.issues.map(i => i.metadata.paragraph_id))].length
        },
        source_metadata: this.structuredData.metadata
      },
      issues: this.issues,
      generated_at: new Date().toISOString(),
      generator_version: '2.0-hierarchical',
      schema_version: '2.0'
    };
    
    // Write output
    fs.writeFileSync(outputPath, JSON.stringify(output, null, 2));
    console.log(`✅ Generated output written to ${outputPath}\n`);
    
    return output;
  }

  /**
   * Print summary
   */
  printSummary() {
    console.log('📊 Issue Generation Summary:\n');
    console.log(`  Total Issues: ${this.issues.length}`);
    
    const priorities = {
      critical: this.issues.filter(i => i.source.priority === 'critical').length,
      high: this.issues.filter(i => i.source.priority === 'high').length,
      medium: this.issues.filter(i => i.source.priority === 'medium').length,
      low: this.issues.filter(i => i.source.priority === 'low').length
    };
    
    console.log(`\n  Priority Distribution:`);
    console.log(`    Critical: ${priorities.critical}`);
    console.log(`    High:     ${priorities.high}`);
    console.log(`    Medium:   ${priorities.medium}`);
    console.log(`    Low:      ${priorities.low}`);
    
    const hierarchicalStats = {
      legal_arguments: [...new Set(this.issues.map(i => i.metadata.argument_name).filter(Boolean))].length,
      features: [...new Set(this.issues.map(i => i.metadata.feature_id))].length,
      paragraphs: [...new Set(this.issues.map(i => i.metadata.paragraph_id))].length
    };
    
    console.log(`\n  Hierarchical Coverage:`);
    console.log(`    Legal Arguments: ${hierarchicalStats.legal_arguments}`);
    console.log(`    Features:        ${hierarchicalStats.features}`);
    console.log(`    Paragraphs:      ${hierarchicalStats.paragraphs}`);
    console.log();
  }
}

// CLI Interface
if (require.main === module) {
  const args = process.argv.slice(2);
  const inputPath = args[0] || 'structured-todo.json';
  const outputPath = args[1] || 'todo-issues.json';
  
  console.log('🏗️  Hierarchical Issue Generator\n');
  console.log('='.repeat(70) + '\n');
  
  try {
    const generator = new HierarchicalIssueGenerator(inputPath);
    generator.generateIssues();
    generator.printSummary();
    generator.generateOutput(outputPath);
    
    console.log('='.repeat(70));
    console.log('🎉 Issue generation complete!\n');
    console.log(`Next step: Use ${outputPath} with GitHub Actions to create issues`);
    
    process.exit(0);
  } catch (error) {
    console.error('💥 Error:', error.message);
    console.error(error.stack);
    process.exit(1);
  }
}

module.exports = HierarchicalIssueGenerator;
