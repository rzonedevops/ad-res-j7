#!/usr/bin/env node

/**
 * Parse need-classification.md to extract feature-level issues
 * and their associated task-level issues
 * 
 * This script parses the hierarchical structure:
 * - Legal Arguments
 * - Features (will become feature-level issues)
 * - Paragraphs (components within features)
 * - Tasks (existing issues to be linked as sub-issues)
 */

const fs = require('fs');
const path = require('path');

class NeedClassificationParser {
  constructor() {
    this.legalArguments = [];
    this.features = [];
    this.currentArgument = null;
    this.currentFeature = null;
    this.currentParagraph = null;
  }

  /**
   * Parse the need-classification.md file
   */
  parse(filePath) {
    console.log(`📄 Parsing ${filePath}...`);
    
    if (!fs.existsSync(filePath)) {
      throw new Error(`File not found: ${filePath}`);
    }

    const content = fs.readFileSync(filePath, 'utf8');
    const lines = content.split('\n');

    for (let i = 0; i < lines.length; i++) {
      const line = lines[i];
      const lineNumber = i + 1;

      // Parse Legal Argument (## Legal Argument: ...)
      if (line.match(/^## Legal Argument:/)) {
        const argumentName = line.replace(/^## Legal Argument:\s*/, '').trim();
        this.currentArgument = {
          name: argumentName,
          type: null,
          strategy: null,
          description: null,
          features: []
        };
        this.legalArguments.push(this.currentArgument);
        this.currentFeature = null;
        this.currentParagraph = null;
        continue;
      }

      // Parse argument metadata
      if (this.currentArgument && !this.currentFeature) {
        if (line.startsWith('**Type:**')) {
          this.currentArgument.type = line.replace('**Type:**', '').trim();
        } else if (line.startsWith('**Strategy:**')) {
          this.currentArgument.strategy = line.replace('**Strategy:**', '').trim();
        } else if (line.startsWith('**Description:**')) {
          this.currentArgument.description = line.replace('**Description:**', '').trim();
        }
      }

      // Parse Feature (### Feature: ...)
      if (line.match(/^### Feature:/)) {
        const featureName = line.replace(/^### Feature:\s*/, '').trim();
        this.currentFeature = {
          name: featureName,
          legalArgument: this.currentArgument ? this.currentArgument.name : null,
          priority: null,
          description: null,
          paragraphs: [],
          taskIssues: []
        };
        if (this.currentArgument) {
          this.currentArgument.features.push(this.currentFeature);
        }
        this.features.push(this.currentFeature);
        this.currentParagraph = null;
        continue;
      }

      // Parse feature metadata
      if (this.currentFeature && !this.currentParagraph) {
        if (line.startsWith('**Priority:**')) {
          this.currentFeature.priority = line.replace('**Priority:**', '').trim();
        } else if (line.startsWith('**Description:**')) {
          this.currentFeature.description = line.replace('**Description:**', '').trim();
        }
      }

      // Parse Paragraph (#### Paragraph N: ...)
      if (line.match(/^#### Paragraph \d+:/)) {
        const paragraphMatch = line.match(/^#### Paragraph \d+:\s*(.+)$/);
        const paragraphName = paragraphMatch ? paragraphMatch[1].trim() : '';
        this.currentParagraph = {
          name: paragraphName,
          rank: null,
          weight: null,
          tasks: []
        };
        if (this.currentFeature) {
          this.currentFeature.paragraphs.push(this.currentParagraph);
        }
        continue;
      }

      // Parse paragraph metadata
      if (this.currentParagraph && line.startsWith('**Rank:**')) {
        const rankMatch = line.match(/\*\*Rank:\*\*\s*(\d+)/);
        if (rankMatch) {
          this.currentParagraph.rank = parseInt(rankMatch[1]);
        }
      }
      if (this.currentParagraph && line.startsWith('**Weight:**')) {
        const weightMatch = line.match(/\*\*Weight:\*\*\s*(\d+)/);
        if (weightMatch) {
          this.currentParagraph.weight = parseInt(weightMatch[1]);
        }
      }

      // Parse Task with Issue reference
      // Format: - [ ] **Task N** (Rank N, Weight N): Description
      //   - Issue: [#NNNN](...)
      if (line.match(/^- \[ \] \*\*Task \d+\*\*/)) {
        const taskMatch = line.match(/^- \[ \] \*\*Task (\d+)\*\* \(Rank (\d+), Weight (\d+)\):\s*(.+)$/);
        if (taskMatch) {
          const taskNum = parseInt(taskMatch[1]);
          const rank = parseInt(taskMatch[2]);
          const weight = parseInt(taskMatch[3]);
          const description = taskMatch[4].trim();
          
          // Look ahead to next line for issue reference
          if (i + 1 < lines.length) {
            const nextLine = lines[i + 1];
            const issueMatch = nextLine.match(/- Issue: \[#(\d+)\]/);
            if (issueMatch) {
              const issueNumber = parseInt(issueMatch[1]);
              const task = {
                taskNumber: taskNum,
                rank,
                weight,
                description,
                issueNumber,
                paragraph: this.currentParagraph ? this.currentParagraph.name : null
              };
              
              if (this.currentParagraph) {
                this.currentParagraph.tasks.push(task);
              }
              if (this.currentFeature) {
                this.currentFeature.taskIssues.push(task);
              }
            }
          }
        }
      }
    }

    console.log(`✅ Parsed ${this.legalArguments.length} legal arguments`);
    console.log(`✅ Parsed ${this.features.length} features`);
    
    let totalTasks = 0;
    this.features.forEach(f => {
      totalTasks += f.taskIssues.length;
    });
    console.log(`✅ Parsed ${totalTasks} task issues\n`);

    return {
      legalArguments: this.legalArguments,
      features: this.features
    };
  }

  /**
   * Generate output suitable for GitHub Action
   */
  generateOutput() {
    return {
      metadata: {
        generated_at: new Date().toISOString(),
        parser_version: '1.0.0',
        total_arguments: this.legalArguments.length,
        total_features: this.features.length
      },
      features: this.features.map(feature => ({
        name: feature.name,
        legalArgument: feature.legalArgument,
        priority: feature.priority,
        description: feature.description,
        paragraphs: feature.paragraphs.map(p => ({
          name: p.name,
          rank: p.rank,
          weight: p.weight,
          taskCount: p.tasks.length
        })),
        taskIssues: feature.taskIssues.map(t => ({
          issueNumber: t.issueNumber,
          description: t.description,
          rank: t.rank,
          weight: t.weight,
          paragraph: t.paragraph
        }))
      }))
    };
  }
}

// Main execution
if (require.main === module) {
  const inputFile = process.argv[2] || 'todo/need-classification.md';
  const outputFile = process.argv[3] || 'parsed-features.json';

  try {
    const parser = new NeedClassificationParser();
    parser.parse(inputFile);
    const output = parser.generateOutput();

    // Write output
    fs.writeFileSync(outputFile, JSON.stringify(output, null, 2));
    console.log(`📝 Output written to ${outputFile}`);
    
    // Display summary
    console.log('\n📊 Summary:');
    console.log(`   Legal Arguments: ${output.metadata.total_arguments}`);
    console.log(`   Features: ${output.metadata.total_features}`);
    
    const totalTasks = output.features.reduce((sum, f) => sum + f.taskIssues.length, 0);
    console.log(`   Total Task Issues: ${totalTasks}`);

  } catch (error) {
    console.error('❌ Error:', error.message);
    process.exit(1);
  }
}

module.exports = NeedClassificationParser;
