#!/usr/bin/env node

/**
 * Generate Feature-Level Issues from need-classification.md
 * 
 * This script:
 * 1. Parses need-classification.md to extract features
 * 2. Creates feature-level issues on GitHub
 * 3. Links existing task-level issues as sub-issues using tasklists
 */

const fs = require('fs');
const { execSync } = require('child_process');

class FeatureIssueGenerator {
  constructor(parsedFeaturesPath, dryRun = true) {
    this.dryRun = dryRun;
    this.features = [];
    this.createdIssues = [];
    
    // Load parsed features
    try {
      const content = fs.readFileSync(parsedFeaturesPath, 'utf8');
      const data = JSON.parse(content);
      this.features = data.features;
    } catch (error) {
      throw new Error(`Failed to load parsed features from ${parsedFeaturesPath}: ${error.message}`);
    }
  }

  /**
   * Generate issue title for a feature
   */
  generateTitle(feature) {
    // Prepend [FEATURE] tag and ensure title is under 80 chars
    const prefix = '[FEATURE] ';
    let title = feature.name;
    
    if (prefix.length + title.length > 80) {
      title = title.substring(0, 80 - prefix.length - 3) + '...';
    }
    
    return `${prefix}${title}`;
  }

  /**
   * Generate issue body for a feature
   */
  generateBody(feature) {
    let body = '';

    // Priority and description
    body += `**Priority:** ${feature.priority}\n\n`;
    body += `${feature.description}\n\n`;

    // Legal argument context
    if (feature.legalArgument) {
      body += `**Legal Argument:** ${feature.legalArgument}\n\n`;
    }

    body += '---\n\n';

    // Paragraph structure overview
    body += '## Paragraph Structure\n\n';
    feature.paragraphs.forEach((para, idx) => {
      body += `### Paragraph ${idx + 1}: ${para.name}\n`;
      body += `- **Rank:** ${para.rank} (1 = highest influence)\n`;
      body += `- **Weight:** ${para.weight}/100\n`;
      body += `- **Tasks:** ${para.taskCount}\n\n`;
    });

    body += '---\n\n';

    // Task issues as sub-issues using GitHub tasklists
    body += '## Task Issues\n\n';
    
    // Group tasks by paragraph
    const tasksByParagraph = new Map();
    feature.taskIssues.forEach(task => {
      const paragraphName = task.paragraph || 'Uncategorized';
      if (!tasksByParagraph.has(paragraphName)) {
        tasksByParagraph.set(paragraphName, []);
      }
      tasksByParagraph.get(paragraphName).push(task);
    });

    // Output tasks grouped by paragraph
    feature.paragraphs.forEach(para => {
      const tasks = tasksByParagraph.get(para.name) || [];
      if (tasks.length > 0) {
        body += `### ${para.name}\n\n`;
        tasks.forEach(task => {
          // GitHub tasklist format that creates sub-issues
          body += `- [ ] #${task.issueNumber} - ${task.description.substring(0, 100)}${task.description.length > 100 ? '...' : ''}\n`;
        });
        body += '\n';
      }
    });

    body += '---\n\n';

    // Metadata
    body += `**Total Task Issues:** ${feature.taskIssues.length}\n`;
    body += `**Paragraphs:** ${feature.paragraphs.length}\n\n`;
    
    body += '*This feature issue was automatically generated from todo/need-classification.md*\n';

    return body;
  }

  /**
   * Create a single feature issue
   */
  async createFeatureIssue(feature) {
    const title = this.generateTitle(feature);
    const body = this.generateBody(feature);
    
    // Write to temp files for safe shell execution
    const titleFile = '/tmp/feature_title.txt';
    const bodyFile = '/tmp/feature_body.txt';
    
    fs.writeFileSync(titleFile, title);
    fs.writeFileSync(bodyFile, body);

    if (this.dryRun) {
      console.log('\n' + '='.repeat(80));
      console.log('DRY RUN - Would create issue:');
      console.log('='.repeat(80));
      console.log(`Title: ${title}`);
      console.log(`\nBody:\n${body}`);
      console.log('='.repeat(80));
      
      return {
        feature: feature.name,
        title,
        taskCount: feature.taskIssues.length,
        created: false,
        dryRun: true
      };
    }

    try {
      // Create issue using GitHub CLI
      const result = execSync(
        `gh issue create --title "$(cat ${titleFile})" --body "$(cat ${bodyFile})" --label "feature" --label "needs-triage"`,
        { encoding: 'utf8', stdio: 'pipe' }
      );
      
      // Parse issue URL from output
      const issueUrl = result.trim();
      const issueNumberMatch = issueUrl.match(/\/issues\/(\d+)$/);
      const issueNumber = issueNumberMatch ? parseInt(issueNumberMatch[1]) : null;

      console.log(`✅ Created feature issue #${issueNumber}: ${title}`);
      
      return {
        feature: feature.name,
        title,
        issueNumber,
        issueUrl,
        taskCount: feature.taskIssues.length,
        created: true
      };
    } catch (error) {
      console.error(`❌ Failed to create feature issue: ${error.message}`);
      return {
        feature: feature.name,
        title,
        error: error.message,
        created: false
      };
    }
  }

  /**
   * Generate all feature issues
   */
  async generateAll() {
    console.log(`🚀 Generating feature-level issues...`);
    console.log(`   Mode: ${this.dryRun ? 'DRY RUN' : 'LIVE'}`);
    console.log(`   Features to process: ${this.features.length}\n`);

    for (let i = 0; i < this.features.length; i++) {
      const feature = this.features[i];
      console.log(`\n[${i + 1}/${this.features.length}] Processing: ${feature.name}`);
      console.log(`   Priority: ${feature.priority}`);
      console.log(`   Task Issues: ${feature.taskIssues.length}`);
      console.log(`   Paragraphs: ${feature.paragraphs.length}`);
      
      const result = await this.createFeatureIssue(feature);
      this.createdIssues.push(result);
      
      if (!this.dryRun && result.created) {
        // Small delay to avoid rate limiting
        await new Promise(resolve => setTimeout(resolve, 1000));
      }
    }

    return this.generateSummary();
  }

  /**
   * Generate summary report
   */
  generateSummary() {
    const successful = this.createdIssues.filter(i => i.created).length;
    const failed = this.createdIssues.filter(i => !i.created && !i.dryRun).length;
    const totalTasks = this.createdIssues.reduce((sum, i) => sum + i.taskCount, 0);

    const summary = {
      total: this.createdIssues.length,
      successful,
      failed,
      dryRun: this.dryRun,
      totalTasksLinked: totalTasks,
      issues: this.createdIssues
    };

    console.log('\n' + '='.repeat(80));
    console.log('SUMMARY');
    console.log('='.repeat(80));
    console.log(`Total Features: ${summary.total}`);
    console.log(`Successful: ${summary.successful}`);
    console.log(`Failed: ${summary.failed}`);
    console.log(`Total Task Issues Linked: ${summary.totalTasksLinked}`);
    console.log(`Mode: ${this.dryRun ? 'DRY RUN' : 'LIVE'}`);
    console.log('='.repeat(80));

    return summary;
  }
}

// Main execution
async function main() {
  const args = process.argv.slice(2);
  const parsedFeaturesFile = args[0] || 'parsed-features.json';
  const dryRun = args.includes('--dry-run') || args.includes('-n');
  const outputFile = args.find(arg => arg.startsWith('--output='))?.split('=')[1] || 'feature-issues-report.json';

  try {
    const generator = new FeatureIssueGenerator(parsedFeaturesFile, dryRun);
    const summary = await generator.generateAll();
    
    // Write summary to file
    fs.writeFileSync(outputFile, JSON.stringify(summary, null, 2));
    console.log(`\n📝 Summary written to ${outputFile}`);

    // Exit with error if any failed (and not dry run)
    if (!dryRun && summary.failed > 0) {
      process.exit(1);
    }

  } catch (error) {
    console.error('❌ Error:', error.message);
    process.exit(1);
  }
}

if (require.main === module) {
  main();
}

module.exports = FeatureIssueGenerator;
