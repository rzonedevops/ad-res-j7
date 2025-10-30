#!/usr/bin/env node

/**
 * Test suite for Hierarchical TODO Parser and Issue Generator
 * Tests the complete pipeline: TODO → Structured JSON → GitHub Issues JSON
 */

const fs = require('fs');
const path = require('path');
const HierarchicalTodoParser = require('../scripts/parse-todo-hierarchically');
const HierarchicalIssueGenerator = require('../scripts/generate-hierarchical-issues');

class HierarchicalWorkflowTests {
  constructor() {
    this.testResults = {
      passed: 0,
      failed: 0,
      total: 0,
      errors: []
    };
  }

  async runTest(name, testFn) {
    this.testResults.total++;
    try {
      await testFn();
      this.testResults.passed++;
      console.log(`  ✅ ${name}`);
      return true;
    } catch (error) {
      this.testResults.failed++;
      this.testResults.errors.push({ name, error: error.message });
      console.log(`  ❌ ${name}`);
      console.log(`     Error: ${error.message}`);
      return false;
    }
  }

  async runAllTests() {
    console.log('🧪 Running Hierarchical TODO Workflow Tests\n');
    
    // Test 1: TODO Parser can parse markdown
    await this.runTest('Parse TODO markdown hierarchically', () => {
      const parser = new HierarchicalTodoParser();
      const testMarkdown = `# Legal Argument

## Feature Issue

### Paragraph 1

- Implement feature X
- Create component Y

### Paragraph 2

- Test implementation
`;
      
      parser.parseMarkdownHierarchically(testMarkdown, 'test.md');
      
      if (parser.legalArguments.length !== 1) {
        throw new Error(`Expected 1 legal argument, got ${parser.legalArguments.length}`);
      }
      
      if (parser.features.length !== 1) {
        throw new Error(`Expected 1 feature, got ${parser.features.length}`);
      }
      
      if (parser.paragraphs.length !== 2) {
        throw new Error(`Expected 2 paragraphs, got ${parser.paragraphs.length}`);
      }
      
      if (parser.tasks.length !== 3) {
        throw new Error(`Expected 3 tasks, got ${parser.tasks.length}`);
      }
    });

    // Test 2: Parser assigns correct ranks
    await this.runTest('Assign rank orders to paragraphs', () => {
      const parser = new HierarchicalTodoParser();
      const testMarkdown = `# Test Argument

## Feature One

### Paragraph A
- Implement task 1
- Create task 2

### Paragraph B
- Implement task 3
`;
      
      parser.parseMarkdownHierarchically(testMarkdown, 'test.md');
      
      if (parser.paragraphs.length < 2) {
        throw new Error(`Expected at least 2 paragraphs, got ${parser.paragraphs.length}`);
      }
      
      // Check paragraph ranks
      const para1 = parser.paragraphs.find(p => p.title === 'Paragraph A');
      const para2 = parser.paragraphs.find(p => p.title === 'Paragraph B');
      
      if (!para1) {
        throw new Error('Could not find Paragraph A');
      }
      
      if (!para2) {
        throw new Error('Could not find Paragraph B');
      }
      
      if (para1.rankOrder !== 1) {
        throw new Error(`First paragraph rank should be 1, got ${para1.rankOrder}`);
      }
      
      if (para2.rankOrder !== 2) {
        throw new Error(`Second paragraph rank should be 2, got ${para2.rankOrder}`);
      }
    });

    // Test 3: Parser assigns weights
    await this.runTest('Assign weights based on rank and keywords', () => {
      const parser = new HierarchicalTodoParser();
      const testMarkdown = `# Argument

## Feature

### Evidence Paragraph
- Document evidence item

### Second Paragraph
- Add supporting item
`;
      
      parser.parseMarkdownHierarchically(testMarkdown, 'test.md');
      
      const evidencePara = parser.paragraphs.find(p => p.title.includes('Evidence'));
      const secondPara = parser.paragraphs.find(p => p.title.includes('Second'));
      
      if (evidencePara.weight !== 100) {
        throw new Error(`Evidence paragraph should have weight 100, got ${evidencePara.weight}`);
      }
      
      if (secondPara.weight !== 90) {
        throw new Error(`Second paragraph should have weight 90, got ${secondPara.weight}`);
      }
      
      // Check task weights
      const evidenceTask = parser.tasks.find(t => t.title.includes('Document'));
      if (evidenceTask.weight !== 100) {
        throw new Error(`Evidence task should have weight 100, got ${evidenceTask.weight}`);
      }
    });

    // Test 4: Parser generates valid structured JSON
    await this.runTest('Generate valid structured JSON output', () => {
      const parser = new HierarchicalTodoParser();
      const testMarkdown = `# Test Argument

## Test Feature

### Test Paragraph
- Implement test task
`;
      
      parser.parseMarkdownHierarchically(testMarkdown, 'test.md');
      
      // Generate output in memory
      const testOutputPath = '/tmp/test-structured-todo.json';
      const output = parser.generateStructuredOutput(testOutputPath);
      
      if (!output.metadata) {
        throw new Error('Output missing metadata');
      }
      
      if (!output.hierarchy) {
        throw new Error('Output missing hierarchy');
      }
      
      if (!output.statistics) {
        throw new Error('Output missing statistics');
      }
      
      if (!Array.isArray(output.hierarchy.legal_arguments)) {
        throw new Error('Legal arguments should be an array');
      }
      
      if (!Array.isArray(output.hierarchy.features)) {
        throw new Error('Features should be an array');
      }
      
      if (!Array.isArray(output.hierarchy.paragraphs)) {
        throw new Error('Paragraphs should be an array');
      }
      
      if (!Array.isArray(output.hierarchy.tasks)) {
        throw new Error('Tasks should be an array');
      }
      
      // Clean up
      if (fs.existsSync(testOutputPath)) {
        fs.unlinkSync(testOutputPath);
      }
    });

    // Test 5: Issue Generator consumes structured JSON
    await this.runTest('Generate issues from structured JSON', () => {
      // Create test structured data
      const structuredData = {
        metadata: {
          total_arguments: 1,
          total_features: 1,
          total_paragraphs: 1,
          total_tasks: 1
        },
        hierarchy: {
          legal_arguments: [
            {
              id: 'arg_1',
              name: 'Test Argument',
              description: 'Test description',
              type: 'defense',
              strategy: 'Test strategy',
              source: 'test.md'
            }
          ],
          features: [
            {
              id: 'feature_1',
              title: 'Test Feature',
              description: 'Test feature description',
              priority: 'high',
              argumentId: 'arg_1',
              source: 'test.md',
              lineNumber: 1,
              paragraphs: []
            }
          ],
          paragraphs: [
            {
              id: 'para_1',
              featureId: 'feature_1',
              number: 1,
              title: 'Test Paragraph',
              content: 'Test content',
              rankOrder: 1,
              weight: 95,
              source: 'test.md',
              lineNumber: 2,
              tasks: []
            }
          ],
          tasks: [
            {
              id: 'task_1',
              paragraphId: 'para_1',
              featureId: 'feature_1',
              title: 'Implement test feature',
              description: 'Implement test feature implementation',
              rankOrder: 1,
              weight: 100,
              priority: 'high',
              source: 'test.md',
              lineNumber: 3
            }
          ]
        }
      };
      
      // Write test structured data
      const testInputPath = '/tmp/test-structured-input.json';
      fs.writeFileSync(testInputPath, JSON.stringify(structuredData, null, 2));
      
      try {
        const generator = new HierarchicalIssueGenerator(testInputPath);
        const issues = generator.generateIssues();
        
        if (issues.length !== 1) {
          throw new Error(`Expected 1 issue, got ${issues.length}`);
        }
        
        const issue = issues[0];
        
        if (!issue.title) {
          throw new Error('Issue missing title');
        }
        
        if (!issue.body) {
          throw new Error('Issue missing body');
        }
        
        if (!Array.isArray(issue.labels)) {
          throw new Error('Issue labels should be an array');
        }
        
        if (!issue.metadata) {
          throw new Error('Issue missing metadata');
        }
        
        if (!issue.metadata.task_id) {
          throw new Error('Issue metadata missing task_id');
        }
        
        if (!issue.metadata.paragraph_id) {
          throw new Error('Issue metadata missing paragraph_id');
        }
        
        if (!issue.metadata.feature_id) {
          throw new Error('Issue metadata missing feature_id');
        }
        
        if (!issue.metadata.argument_id) {
          throw new Error('Issue metadata missing argument_id');
        }
      } finally {
        // Clean up
        if (fs.existsSync(testInputPath)) {
          fs.unlinkSync(testInputPath);
        }
      }
    });

    // Test 6: Issue Generator includes hierarchical metadata
    await this.runTest('Include hierarchical metadata in issues', () => {
      const structuredData = {
        metadata: {},
        hierarchy: {
          legal_arguments: [{
            id: 'arg_1',
            name: 'Defense Argument',
            description: 'Test',
            type: 'defense',
            strategy: 'Test strategy',
            source: 'test.md'
          }],
          features: [{
            id: 'feature_1',
            title: 'Feature Title',
            argumentId: 'arg_1',
            priority: 'critical',
            source: 'test.md',
            lineNumber: 1,
            paragraphs: []
          }],
          paragraphs: [{
            id: 'para_1',
            featureId: 'feature_1',
            number: 1,
            title: 'Paragraph Title',
            rankOrder: 1,
            weight: 95,
            source: 'test.md',
            lineNumber: 2,
            tasks: []
          }],
          tasks: [{
            id: 'task_1',
            paragraphId: 'para_1',
            featureId: 'feature_1',
            title: 'Task Title',
            description: 'Implement feature X',
            rankOrder: 1,
            weight: 100,
            priority: 'critical',
            source: 'test.md',
            lineNumber: 3
          }]
        }
      };
      
      const testPath = '/tmp/test-metadata.json';
      fs.writeFileSync(testPath, JSON.stringify(structuredData, null, 2));
      
      try {
        const generator = new HierarchicalIssueGenerator(testPath);
        const issues = generator.generateIssues();
        const issue = issues[0];
        
        // Check labels
        if (!issue.labels.includes('hierarchical-task')) {
          throw new Error('Issue should include hierarchical-task label');
        }
        
        if (!issue.labels.includes('priority: critical')) {
          throw new Error('Issue should include priority label');
        }
        
        if (!issue.labels.includes('rank-1')) {
          throw new Error('Issue should include rank label');
        }
        
        if (!issue.labels.includes('weight-high')) {
          throw new Error('Issue should include weight label');
        }
        
        // Check metadata
        if (issue.metadata.paragraph_rank !== 1) {
          throw new Error('Metadata should include paragraph rank');
        }
        
        if (issue.metadata.paragraph_weight !== 95) {
          throw new Error('Metadata should include paragraph weight');
        }
        
        if (issue.metadata.task_rank !== 1) {
          throw new Error('Metadata should include task rank');
        }
        
        if (issue.metadata.task_weight !== 100) {
          throw new Error('Metadata should include task weight');
        }
      } finally {
        if (fs.existsSync(testPath)) {
          fs.unlinkSync(testPath);
        }
      }
    });

    // Test 7: End-to-end workflow
    await this.runTest('Complete workflow: Parse → Generate', () => {
      const testMarkdown = `# Payment Structure Defense

## Revenue Stream Analysis

### Investment Evidence
- Document R1M bank transfer
- Gather investment documentation

### Admin Fee Structure
- Verify R1K admin fee invoices
`;
      
      // Parse
      const parser = new HierarchicalTodoParser();
      parser.parseMarkdownHierarchically(testMarkdown, 'test.md');
      
      const structuredPath = '/tmp/test-e2e-structured.json';
      const issuesPath = '/tmp/test-e2e-issues.json';
      
      try {
        const structuredOutput = parser.generateStructuredOutput(structuredPath);
        
        if (structuredOutput.hierarchy.tasks.length !== 3) {
          throw new Error(`Expected 3 tasks, got ${structuredOutput.hierarchy.tasks.length}`);
        }
        
        // Generate issues
        const generator = new HierarchicalIssueGenerator(structuredPath);
        const issues = generator.generateIssues();
        
        if (issues.length !== 3) {
          throw new Error(`Expected 3 issues, got ${issues.length}`);
        }
        
        // Check first issue has all hierarchical context
        const firstIssue = issues[0];
        if (!firstIssue.body.includes('Payment Structure Defense')) {
          throw new Error('Issue should reference legal argument');
        }
        
        if (!firstIssue.body.includes('Revenue Stream Analysis')) {
          throw new Error('Issue should reference feature');
        }
        
        if (!firstIssue.body.includes('Investment Evidence')) {
          throw new Error('Issue should reference paragraph');
        }
        
        const output = generator.generateOutput(issuesPath);
        
        if (output.summary.total_issues !== 3) {
          throw new Error('Output summary should show 3 issues');
        }
        
        if (!output.summary.hierarchical_metadata) {
          throw new Error('Output should include hierarchical metadata');
        }
      } finally {
        if (fs.existsSync(structuredPath)) fs.unlinkSync(structuredPath);
        if (fs.existsSync(issuesPath)) fs.unlinkSync(issuesPath);
      }
    });

    // Print summary
    console.log('\n' + '='.repeat(60));
    console.log('📊 Test Summary\n');
    console.log(`Total Tests:  ${this.testResults.total}`);
    console.log(`Passed:       ${this.testResults.passed} ✅`);
    console.log(`Failed:       ${this.testResults.failed} ❌`);
    console.log(`Success Rate: ${((this.testResults.passed / this.testResults.total) * 100).toFixed(1)}%`);
    
    if (this.testResults.errors.length > 0) {
      console.log('\n❌ Failed Tests:');
      this.testResults.errors.forEach(err => {
        console.log(`  - ${err.name}: ${err.error}`);
      });
    }
    
    console.log('='.repeat(60) + '\n');

    return this.testResults;
  }
}

// Run tests if called directly
if (require.main === module) {
  const tests = new HierarchicalWorkflowTests();
  tests.runAllTests()
    .then(results => {
      process.exit(results.failed > 0 ? 1 : 0);
    })
    .catch(error => {
      console.error('💥 Test suite failed:', error);
      process.exit(1);
    });
}

module.exports = HierarchicalWorkflowTests;
