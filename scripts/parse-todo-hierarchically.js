#!/usr/bin/env node

/**
 * Hierarchical TODO Parser
 * 
 * Parses TODO markdown files and structures them according to the 4-level hierarchy:
 * 1. Legal Arguments (strategic claims)
 * 2. Feature Issues (evidence-based proofs)
 * 3. Paragraphs (fact groupings - 3 per feature)
 * 4. Task Issues (actionable items - ~3 per paragraph = 9 per feature)
 * 
 * Outputs structured-todo.json for consumption by todo-to-issues generator
 */

const fs = require('fs');
const path = require('path');
const glob = require('glob');

class HierarchicalTodoParser {
  constructor() {
    this.legalArguments = [];
    this.features = [];
    this.paragraphs = [];
    this.tasks = [];
    this.nextFeatureId = 1;
    this.nextParagraphId = 1;
    this.nextTaskId = 1;
  }

  /**
   * Parse markdown content to extract hierarchical structure
   */
  parseMarkdownHierarchically(content, filename) {
    const lines = content.split('\n');
    let currentLegalArgument = null;
    let currentFeature = null;
    let currentParagraph = null;
    let currentSection = '';
    let sectionLevel = 0;

    for (let i = 0; i < lines.length; i++) {
      const line = lines[i].trim();
      
      // Detect headers to understand hierarchy
      const headerMatch = line.match(/^(#{1,6})\s+(.+)$/);
      if (headerMatch) {
        const level = headerMatch[1].length;
        const title = headerMatch[2].trim();
        currentSection = title;
        sectionLevel = level;

        // Level 1: Legal Arguments (# Heading)
        if (level === 1) {
          currentLegalArgument = this.extractLegalArgument(title, filename);
          currentFeature = null;
          currentParagraph = null;
        }
        // Level 2: Feature Issues (## Heading)
        else if (level === 2) {
          if (currentLegalArgument) {
            currentFeature = this.extractFeature(title, currentLegalArgument, filename, i + 1);
            currentParagraph = null;
          }
        }
        // Level 3: Paragraphs (### Heading)
        else if (level === 3) {
          if (currentFeature) {
            currentParagraph = this.extractParagraph(title, currentFeature, filename, i + 1);
          }
        }
        continue;
      }

      // Extract tasks from list items
      if (currentParagraph) {
        const task = this.extractTaskFromLine(line, currentParagraph, currentFeature, filename, i + 1);
        if (task) {
          this.tasks.push(task);
        }
      }
    }
  }

  /**
   * Extract legal argument from header
   */
  extractLegalArgument(title, filename) {
    // Check if already exists
    let argument = this.legalArguments.find(a => a.name === title);
    if (!argument) {
      argument = {
        id: `arg_${this.legalArguments.length + 1}`,
        name: title,
        description: `Legal argument extracted from ${filename}`,
        type: this.inferArgumentType(title),
        strategy: this.inferStrategy(title),
        source: filename
      };
      this.legalArguments.push(argument);
    }
    return argument;
  }

  /**
   * Infer argument type from title
   */
  inferArgumentType(title) {
    const lowerTitle = title.toLowerCase();
    if (lowerTitle.includes('defense') || lowerTitle.includes('refut')) {
      return 'defense';
    } else if (lowerTitle.includes('counterclaim') || lowerTitle.includes('fraud')) {
      return 'counterclaim';
    } else if (lowerTitle.includes('evidence') || lowerTitle.includes('proof')) {
      return 'evidence';
    }
    return 'defense';
  }

  /**
   * Infer strategy from title
   */
  inferStrategy(title) {
    if (title.toLowerCase().includes('payment') || title.toLowerCase().includes('revenue')) {
      return 'Prove legitimate business structure';
    } else if (title.toLowerCase().includes('timeline') || title.toLowerCase().includes('chronolog')) {
      return 'Establish factual timeline';
    }
    return 'Support legal position';
  }

  /**
   * Extract feature issue from section
   */
  extractFeature(title, legalArgument, filename, lineNumber) {
    const featureId = `feature_${this.nextFeatureId++}`;
    const priority = this.inferPriority(title);
    
    const feature = {
      id: featureId,
      title: title,
      description: `Feature extracted from ${filename}`,
      priority: priority,
      argumentId: legalArgument.id,
      source: filename,
      lineNumber: lineNumber,
      paragraphs: []
    };
    
    this.features.push(feature);
    return feature;
  }

  /**
   * Extract paragraph from subsection
   */
  extractParagraph(title, feature, filename, lineNumber) {
    const paragraphId = `para_${this.nextParagraphId++}`;
    
    // Calculate rank order within feature (1-based)
    const rankOrder = feature.paragraphs.length + 1;
    
    // Infer weight from position and keywords
    const weight = this.inferParagraphWeight(title, rankOrder);
    
    const paragraph = {
      id: paragraphId,
      featureId: feature.id,
      number: rankOrder,
      title: title,
      content: `Paragraph extracted from ${filename}`,
      rankOrder: rankOrder,
      weight: weight,
      source: filename,
      lineNumber: lineNumber,
      tasks: []
    };
    
    feature.paragraphs.push(paragraph);
    this.paragraphs.push(paragraph);
    return paragraph;
  }

  /**
   * Infer paragraph weight based on position and content
   */
  inferParagraphWeight(title, rankOrder) {
    const lowerTitle = title.toLowerCase();
    
    // Higher weight for evidence-related paragraphs
    if (lowerTitle.includes('evidence') || lowerTitle.includes('proof') || lowerTitle.includes('document')) {
      return 100;
    }
    
    // Weight based on rank (first paragraph usually most important)
    if (rankOrder === 1) return 95;
    if (rankOrder === 2) return 90;
    if (rankOrder === 3) return 85;
    
    return Math.max(50, 100 - (rankOrder * 10));
  }

  /**
   * Extract task from line
   */
  extractTaskFromLine(line, paragraph, feature, filename, lineNumber) {
    // Look for actionable patterns
    const actionablePatterns = [
      /^-\s+(.+)/,                    // Bullet points
      /^\*\s+(.+)/,                   // Asterisk bullets
      /^\d+\.\s+(.+)/,                // Numbered lists
      /^TODO:\s*(.+)/i,               // TODO items
      /^TASK:\s*(.+)/i,               // TASK items
      /^ACTION:\s*(.+)/i              // ACTION items
    ];

    for (const pattern of actionablePatterns) {
      const match = line.match(pattern);
      if (match) {
        const taskText = match[1].trim();
        
        // Skip if too short or looks like metadata
        if (taskText.length < 15 || this.isNonActionable(taskText)) {
          continue;
        }

        // Check if it's truly actionable
        if (this.isActionableTask(taskText)) {
          const taskId = `task_${this.nextTaskId++}`;
          const rankOrder = paragraph.tasks.length + 1;
          const weight = this.inferTaskWeight(taskText, rankOrder);
          
          const task = {
            id: taskId,
            paragraphId: paragraph.id,
            featureId: feature.id,
            title: this.cleanTaskTitle(taskText),
            description: taskText,
            rankOrder: rankOrder,
            weight: weight,
            priority: this.inferPriority(taskText),
            source: filename,
            lineNumber: lineNumber
          };
          
          paragraph.tasks.push(task);
          return task;
        }
      }
    }
    
    return null;
  }

  /**
   * Check if text is non-actionable (metadata, descriptions, etc.)
   */
  isNonActionable(text) {
    const skipPatterns = [
      /^\*\*.*\*\*:?\s*$/,           // Just bold text
      /^Current Coverage/i,
      /^Legal Significance/i,
      /^Framework Phase/i,
      /^Impact:/i,
      /^Estimated effort:/i,
      /hours?$/i,
      /^Show\s+/i,
      /^Demonstrate\s+/i,
      /^Provide\s+/i,
      /^\[x\]/i,                     // Completed checkbox
      /✅/,                          // Checkmark emoji
      /COMPLETED/i
    ];
    
    return skipPatterns.some(pattern => pattern.test(text));
  }

  /**
   * Check if text is actionable
   */
  isActionableTask(text) {
    const actionPatterns = [
      /^(Implement|Create|Build|Fix|Add|Update|Develop|Write|Draft|Prepare|Design|Setup|Configure|Test|Validate|Verify|Check)\s+/i,
      /^(Document|Gather|Obtain|Compile|Collect|Analyze|Review|Examine)\s+/i,
      /monitoring and alerting/i,
      /automated testing/i,
      /duplicate prevention/i
    ];
    
    return actionPatterns.some(pattern => pattern.test(text));
  }

  /**
   * Infer task weight
   */
  inferTaskWeight(text, rankOrder) {
    const lowerText = text.toLowerCase();
    
    // Critical evidence tasks
    if (lowerText.includes('document') || lowerText.includes('evidence') || lowerText.includes('proof')) {
      return 100;
    }
    
    // High priority actions
    if (lowerText.includes('implement') || lowerText.includes('create') || lowerText.includes('build')) {
      return 90;
    }
    
    // Weight based on rank
    if (rankOrder === 1) return 100;
    if (rankOrder === 2) return 90;
    if (rankOrder === 3) return 85;
    
    return Math.max(50, 100 - (rankOrder * 10));
  }

  /**
   * Infer priority from text
   */
  inferPriority(text) {
    const lowerText = text.toLowerCase();
    
    if (lowerText.includes('critical') || lowerText.includes('urgent') || lowerText.includes('must')) {
      return 'critical';
    } else if (lowerText.includes('high') || lowerText.includes('important') || lowerText.includes('should')) {
      return 'high';
    } else if (lowerText.includes('low') || lowerText.includes('nice') || lowerText.includes('could')) {
      return 'low';
    }
    
    return 'medium';
  }

  /**
   * Clean task title for GitHub issue
   */
  cleanTaskTitle(text) {
    // Remove markdown formatting
    let title = text.replace(/\*\*(.+?)\*\*/g, '$1');
    title = title.replace(/\*(.+?)\*/g, '$1');
    title = title.replace(/`(.+?)`/g, '$1');
    
    // Trim and limit length
    title = title.trim();
    if (title.length > 80) {
      title = title.substring(0, 77) + '...';
    }
    
    return title;
  }

  /**
   * Process all TODO files
   */
  processFiles(todoDir = 'todo') {
    console.log(`📂 Scanning ${todoDir} for TODO files...\n`);
    
    const todoFiles = glob.sync(`${todoDir}/**/*.md`);
    
    if (todoFiles.length === 0) {
      console.log('⚠️  No TODO files found');
      return;
    }
    
    console.log(`Found ${todoFiles.length} TODO files\n`);
    
    for (const file of todoFiles) {
      console.log(`📄 Processing: ${file}`);
      
      try {
        const content = fs.readFileSync(file, 'utf8');
        
        if (!content || content.trim() === '') {
          console.log(`  ⚠️  Skipping empty file\n`);
          continue;
        }
        
        this.parseMarkdownHierarchically(content, file);
        console.log(`  ✅ Parsed successfully\n`);
        
      } catch (error) {
        console.error(`  ❌ Error processing ${file}:`, error.message);
        console.log();
      }
    }
  }

  /**
   * Apply the 3x3=9 rule: ensure features have ~3 paragraphs with ~3 tasks each
   */
  applyStructuralRules() {
    console.log('📐 Applying structural rules (3 paragraphs × 3 tasks = 9 tasks per feature)...\n');
    
    for (const feature of this.features) {
      // If feature has no paragraphs, create a default one
      if (feature.paragraphs.length === 0) {
        console.log(`  ⚠️  Feature "${feature.title}" has no paragraphs, creating default`);
        const defaultPara = {
          id: `para_${this.nextParagraphId++}`,
          featureId: feature.id,
          number: 1,
          title: 'Implementation Tasks',
          content: 'Default paragraph for task grouping',
          rankOrder: 1,
          weight: 100,
          source: feature.source,
          lineNumber: feature.lineNumber,
          tasks: []
        };
        feature.paragraphs.push(defaultPara);
        this.paragraphs.push(defaultPara);
      }
      
      // Warn if feature has too many paragraphs (> 5)
      if (feature.paragraphs.length > 5) {
        console.log(`  ⚠️  Feature "${feature.title}" has ${feature.paragraphs.length} paragraphs (recommended: 3-5)`);
      }
      
      // Check tasks per paragraph
      for (const paragraph of feature.paragraphs) {
        if (paragraph.tasks.length === 0) {
          console.log(`  ℹ️  Paragraph "${paragraph.title}" has no tasks`);
        } else if (paragraph.tasks.length > 5) {
          console.log(`  ⚠️  Paragraph "${paragraph.title}" has ${paragraph.tasks.length} tasks (recommended: 2-4)`);
        }
      }
    }
    
    console.log();
  }

  /**
   * Generate structured output for todo-to-issues workflow
   */
  generateStructuredOutput(outputPath = 'structured-todo.json') {
    this.applyStructuralRules();
    
    const output = {
      metadata: {
        generated_at: new Date().toISOString(),
        parser_version: '1.0.0',
        schema_version: '1.0',
        total_arguments: this.legalArguments.length,
        total_features: this.features.length,
        total_paragraphs: this.paragraphs.length,
        total_tasks: this.tasks.length
      },
      hierarchy: {
        legal_arguments: this.legalArguments,
        features: this.features,
        paragraphs: this.paragraphs,
        tasks: this.tasks
      },
      statistics: this.generateStatistics()
    };
    
    // Write output
    fs.writeFileSync(outputPath, JSON.stringify(output, null, 2));
    console.log(`✅ Structured output written to ${outputPath}\n`);
    
    return output;
  }

  /**
   * Generate statistics
   */
  generateStatistics() {
    const stats = {
      by_priority: {
        critical: this.tasks.filter(t => t.priority === 'critical').length,
        high: this.tasks.filter(t => t.priority === 'high').length,
        medium: this.tasks.filter(t => t.priority === 'medium').length,
        low: this.tasks.filter(t => t.priority === 'low').length
      },
      by_argument: this.legalArguments.map(arg => ({
        argument: arg.name,
        features: this.features.filter(f => f.argumentId === arg.id).length,
        tasks: this.tasks.filter(t => {
          const feature = this.features.find(f => f.id === t.featureId);
          return feature && feature.argumentId === arg.id;
        }).length
      })),
      avg_paragraphs_per_feature: this.features.length > 0 
        ? (this.paragraphs.length / this.features.length).toFixed(2)
        : 0,
      avg_tasks_per_paragraph: this.paragraphs.length > 0
        ? (this.tasks.length / this.paragraphs.length).toFixed(2)
        : 0,
      avg_tasks_per_feature: this.features.length > 0
        ? (this.tasks.length / this.features.length).toFixed(2)
        : 0
    };
    
    return stats;
  }

  /**
   * Print summary
   */
  printSummary() {
    console.log('📊 Hierarchical Structure Summary:\n');
    console.log(`  Legal Arguments: ${this.legalArguments.length}`);
    console.log(`  Feature Issues:  ${this.features.length}`);
    console.log(`  Paragraphs:      ${this.paragraphs.length}`);
    console.log(`  Task Issues:     ${this.tasks.length}\n`);
    
    const stats = this.generateStatistics();
    console.log('📈 Statistics:\n');
    console.log(`  Avg Paragraphs per Feature: ${stats.avg_paragraphs_per_feature}`);
    console.log(`  Avg Tasks per Paragraph:    ${stats.avg_tasks_per_paragraph}`);
    console.log(`  Avg Tasks per Feature:      ${stats.avg_tasks_per_feature}\n`);
    
    console.log('🎯 Priority Distribution:\n');
    console.log(`  Critical: ${stats.by_priority.critical}`);
    console.log(`  High:     ${stats.by_priority.high}`);
    console.log(`  Medium:   ${stats.by_priority.medium}`);
    console.log(`  Low:      ${stats.by_priority.low}\n`);
  }
}

// CLI Interface
if (require.main === module) {
  const args = process.argv.slice(2);
  const todoDir = args[0] || 'todo';
  const outputPath = args[1] || 'structured-todo.json';
  
  console.log('🧠 Hierarchical TODO Parser\n');
  console.log('Applying 4-level hierarchy: Legal Argument → Feature → Paragraph → Task\n');
  console.log('='.repeat(70) + '\n');
  
  try {
    const parser = new HierarchicalTodoParser();
    parser.processFiles(todoDir);
    parser.printSummary();
    parser.generateStructuredOutput(outputPath);
    
    console.log('='.repeat(70));
    console.log('🎉 Hierarchical parsing complete!\n');
    console.log(`Next step: Use ${outputPath} with todo-to-issues generator`);
    
    process.exit(0);
  } catch (error) {
    console.error('💥 Error:', error.message);
    console.error(error.stack);
    process.exit(1);
  }
}

module.exports = HierarchicalTodoParser;
