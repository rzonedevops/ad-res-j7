#!/usr/bin/env node

/**
 * Test suite for Feature-Level Issue Generation
 * Tests the parser and generator scripts
 */

const fs = require('fs');
const path = require('path');
const NeedClassificationParser = require('../scripts/parse-need-classification.js');
const FeatureIssueGenerator = require('../scripts/generate-feature-issues.js');

class FeatureIssueGenerationTests {
  constructor() {
    this.testsPassed = 0;
    this.testsFailed = 0;
    this.errors = [];
  }

  /**
   * Run a single test
   */
  test(name, testFn) {
    try {
      console.log(`\n▶️  ${name}`);
      testFn();
      this.testsPassed++;
      console.log(`   ✅ PASSED`);
    } catch (error) {
      this.testsFailed++;
      this.errors.push({ test: name, error: error.message });
      console.log(`   ❌ FAILED: ${error.message}`);
    }
  }

  /**
   * Assert helper
   */
  assert(condition, message) {
    if (!condition) {
      throw new Error(message || 'Assertion failed');
    }
  }

  /**
   * Test: Parser can read and parse need-classification.md
   */
  testParserBasicParsing() {
    this.test('Parser: Basic parsing of need-classification.md', () => {
      const parser = new NeedClassificationParser();
      const result = parser.parse('todo/need-classification.md');
      
      this.assert(result.legalArguments.length > 0, 'Should parse legal arguments');
      this.assert(result.features.length > 0, 'Should parse features');
      
      console.log(`   Parsed ${result.legalArguments.length} legal arguments`);
      console.log(`   Parsed ${result.features.length} features`);
    });
  }

  /**
   * Test: Parser correctly extracts feature metadata
   */
  testParserFeatureMetadata() {
    this.test('Parser: Feature metadata extraction', () => {
      const parser = new NeedClassificationParser();
      parser.parse('todo/need-classification.md');
      const output = parser.generateOutput();
      
      const firstFeature = output.features[0];
      
      this.assert(firstFeature.name, 'Feature should have a name');
      this.assert(firstFeature.priority, 'Feature should have a priority');
      this.assert(firstFeature.description, 'Feature should have a description');
      this.assert(Array.isArray(firstFeature.paragraphs), 'Feature should have paragraphs array');
      this.assert(Array.isArray(firstFeature.taskIssues), 'Feature should have taskIssues array');
      
      console.log(`   Feature name: ${firstFeature.name}`);
      console.log(`   Priority: ${firstFeature.priority}`);
      console.log(`   Paragraphs: ${firstFeature.paragraphs.length}`);
      console.log(`   Task issues: ${firstFeature.taskIssues.length}`);
    });
  }

  /**
   * Test: Parser correctly extracts paragraph structure
   */
  testParserParagraphStructure() {
    this.test('Parser: Paragraph structure extraction', () => {
      const parser = new NeedClassificationParser();
      parser.parse('todo/need-classification.md');
      const output = parser.generateOutput();
      
      const featureWithParagraphs = output.features.find(f => f.paragraphs.length > 0);
      this.assert(featureWithParagraphs, 'Should find feature with paragraphs');
      
      const paragraph = featureWithParagraphs.paragraphs[0];
      this.assert(paragraph.name, 'Paragraph should have a name');
      this.assert(typeof paragraph.rank === 'number', 'Paragraph should have a rank');
      this.assert(typeof paragraph.weight === 'number', 'Paragraph should have a weight');
      
      console.log(`   Paragraph: ${paragraph.name}`);
      console.log(`   Rank: ${paragraph.rank}`);
      console.log(`   Weight: ${paragraph.weight}`);
    });
  }

  /**
   * Test: Parser correctly extracts task issues
   */
  testParserTaskIssues() {
    this.test('Parser: Task issue extraction', () => {
      const parser = new NeedClassificationParser();
      parser.parse('todo/need-classification.md');
      const output = parser.generateOutput();
      
      const featureWithTasks = output.features.find(f => f.taskIssues.length > 0);
      this.assert(featureWithTasks, 'Should find feature with task issues');
      
      const task = featureWithTasks.taskIssues[0];
      this.assert(typeof task.issueNumber === 'number', 'Task should have issue number');
      this.assert(task.description, 'Task should have description');
      this.assert(typeof task.rank === 'number', 'Task should have rank');
      this.assert(typeof task.weight === 'number', 'Task should have weight');
      
      console.log(`   Task issue #${task.issueNumber}`);
      console.log(`   Description: ${task.description.substring(0, 50)}...`);
      console.log(`   Rank: ${task.rank}, Weight: ${task.weight}`);
    });
  }

  /**
   * Test: Output JSON has correct structure
   */
  testParserOutputStructure() {
    this.test('Parser: Output JSON structure', () => {
      const parser = new NeedClassificationParser();
      parser.parse('todo/need-classification.md');
      const output = parser.generateOutput();
      
      this.assert(output.metadata, 'Output should have metadata');
      this.assert(output.features, 'Output should have features array');
      this.assert(output.metadata.generated_at, 'Metadata should have generated_at');
      this.assert(output.metadata.parser_version, 'Metadata should have parser_version');
      this.assert(typeof output.metadata.total_arguments === 'number', 'Metadata should have total_arguments');
      this.assert(typeof output.metadata.total_features === 'number', 'Metadata should have total_features');
    });
  }

  /**
   * Test: Generator can load parsed features
   */
  testGeneratorLoadParsedFeatures() {
    this.test('Generator: Load parsed features', () => {
      // First create parsed features
      const parser = new NeedClassificationParser();
      parser.parse('todo/need-classification.md');
      const output = parser.generateOutput();
      
      const testFile = '/tmp/test-parsed-features.json';
      fs.writeFileSync(testFile, JSON.stringify(output));
      
      // Then load in generator
      const generator = new FeatureIssueGenerator(testFile, true);
      this.assert(generator.features.length > 0, 'Generator should load features');
      
      console.log(`   Loaded ${generator.features.length} features`);
      
      // Cleanup
      fs.unlinkSync(testFile);
    });
  }

  /**
   * Test: Generator creates correct title format
   */
  testGeneratorTitleFormat() {
    this.test('Generator: Title format', () => {
      const parser = new NeedClassificationParser();
      parser.parse('todo/need-classification.md');
      const output = parser.generateOutput();
      
      const testFile = '/tmp/test-parsed-features.json';
      fs.writeFileSync(testFile, JSON.stringify(output));
      
      const generator = new FeatureIssueGenerator(testFile, true);
      const feature = generator.features[0];
      const title = generator.generateTitle(feature);
      
      this.assert(title.startsWith('[FEATURE] '), 'Title should start with [FEATURE]');
      this.assert(title.length <= 80, 'Title should be 80 characters or less');
      
      console.log(`   Title: ${title}`);
      console.log(`   Length: ${title.length} chars`);
      
      // Cleanup
      fs.unlinkSync(testFile);
    });
  }

  /**
   * Test: Generator creates correct body structure
   */
  testGeneratorBodyStructure() {
    this.test('Generator: Body structure', () => {
      const parser = new NeedClassificationParser();
      parser.parse('todo/need-classification.md');
      const output = parser.generateOutput();
      
      const testFile = '/tmp/test-parsed-features.json';
      fs.writeFileSync(testFile, JSON.stringify(output));
      
      const generator = new FeatureIssueGenerator(testFile, true);
      const feature = generator.features[0];
      const body = generator.generateBody(feature);
      
      this.assert(body.includes('**Priority:**'), 'Body should include priority');
      this.assert(body.includes('**Legal Argument:**'), 'Body should include legal argument');
      this.assert(body.includes('## Paragraph Structure'), 'Body should include paragraph structure');
      this.assert(body.includes('## Task Issues'), 'Body should include task issues');
      this.assert(body.includes('**Total Task Issues:**'), 'Body should include task count');
      
      // Check for task references
      feature.taskIssues.forEach(task => {
        this.assert(body.includes(`#${task.issueNumber}`), `Body should reference issue #${task.issueNumber}`);
      });
      
      console.log(`   Body length: ${body.length} chars`);
      console.log(`   Task references: ${feature.taskIssues.length}`);
      
      // Cleanup
      fs.unlinkSync(testFile);
    });
  }

  /**
   * Test: Generator dry-run mode doesn't create issues
   */
  testGeneratorDryRun() {
    this.test('Generator: Dry-run mode', async () => {
      const parser = new NeedClassificationParser();
      parser.parse('todo/need-classification.md');
      const output = parser.generateOutput();
      
      const testFile = '/tmp/test-parsed-features.json';
      fs.writeFileSync(testFile, JSON.stringify(output));
      
      const generator = new FeatureIssueGenerator(testFile, true);
      const summary = await generator.generateAll();
      
      this.assert(summary.dryRun === true, 'Summary should indicate dry run');
      this.assert(summary.successful === 0, 'No issues should be created in dry run');
      this.assert(summary.total === generator.features.length, 'Should process all features');
      
      console.log(`   Features processed: ${summary.total}`);
      console.log(`   Dry run mode: ${summary.dryRun}`);
      
      // Cleanup
      fs.unlinkSync(testFile);
    });
  }

  /**
   * Test: All features from need-classification.md are parsed
   */
  testCompleteFeatureParsing() {
    this.test('Integration: Complete feature parsing', () => {
      const parser = new NeedClassificationParser();
      parser.parse('todo/need-classification.md');
      const output = parser.generateOutput();
      
      // According to need-classification.md summary
      this.assert(output.metadata.total_arguments === 7, 'Should parse 7 legal arguments');
      this.assert(output.metadata.total_features === 16, 'Should parse 16 features');
      
      const totalTasks = output.features.reduce((sum, f) => sum + f.taskIssues.length, 0);
      this.assert(totalTasks === 146, 'Should parse 146 task issues');
      
      console.log(`   Legal arguments: ${output.metadata.total_arguments}`);
      console.log(`   Features: ${output.metadata.total_features}`);
      console.log(`   Task issues: ${totalTasks}`);
    });
  }

  /**
   * Run all tests
   */
  async runAll() {
    console.log('🧪 Running Feature-Level Issue Generation Tests\n');
    console.log('='.repeat(80));
    
    // Parser tests
    this.testParserBasicParsing();
    this.testParserFeatureMetadata();
    this.testParserParagraphStructure();
    this.testParserTaskIssues();
    this.testParserOutputStructure();
    
    // Generator tests
    this.testGeneratorLoadParsedFeatures();
    this.testGeneratorTitleFormat();
    this.testGeneratorBodyStructure();
    await this.testGeneratorDryRun();
    
    // Integration tests
    this.testCompleteFeatureParsing();
    
    // Summary
    console.log('\n' + '='.repeat(80));
    console.log('SUMMARY');
    console.log('='.repeat(80));
    console.log(`✅ Passed: ${this.testsPassed}`);
    console.log(`❌ Failed: ${this.testsFailed}`);
    console.log(`📊 Total: ${this.testsPassed + this.testsFailed}`);
    
    if (this.testsFailed > 0) {
      console.log('\n❌ Failed Tests:');
      this.errors.forEach(({ test, error }) => {
        console.log(`   - ${test}: ${error}`);
      });
      process.exit(1);
    } else {
      console.log('\n✅ All tests passed!');
    }
  }
}

// Run tests
if (require.main === module) {
  const tests = new FeatureIssueGenerationTests();
  tests.runAll().catch(error => {
    console.error('❌ Test suite error:', error);
    process.exit(1);
  });
}

module.exports = FeatureIssueGenerationTests;
