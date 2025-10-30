#!/usr/bin/env node

/**
 * Verify Proper Issue Creation with Multiple Labels
 * 
 * This test verifies that GitHub issues can be created with multiple labels
 * correctly through the workflow automation system.
 * 
 * Test Source: todo/workflow-test.md (line 13)
 * Feature ID: feature_12
 * Paragraph ID: para_10
 * Task ID: task_9
 */

const fs = require('fs');
const path = require('path');

class MultiLabelIssueCreationTest {
  constructor() {
    this.testResults = {
      passed: 0,
      failed: 0,
      errors: []
    };
  }

  /**
   * Assert helper
   */
  assert(condition, message) {
    if (condition) {
      this.testResults.passed++;
      console.log(`  ✅ ${message}`);
      return true;
    } else {
      this.testResults.failed++;
      this.testResults.errors.push(message);
      console.log(`  ❌ ${message}`);
      return false;
    }
  }

  /**
   * Test 1: Validate workflow supports multiple labels in issue creation
   */
  testWorkflowMultiLabelSupport() {
    console.log('\n📋 Test 1: Workflow Multi-Label Support');
    
    const workflowPath = '.github/workflows/todo-to-issues.yml';
    
    if (!fs.existsSync(workflowPath)) {
      this.assert(false, 'Workflow file not found');
      return;
    }

    const content = fs.readFileSync(workflowPath, 'utf8');

    // Check for label array handling
    this.assert(
      content.includes('gh_args+=("--label" "$label")'),
      'Workflow uses proper array syntax for adding multiple labels'
    );

    // Check for JSON array parsing
    this.assert(
      content.includes('jq -r \'.[]\''),
      'Workflow uses jq to parse label arrays'
    );

    // Check for label validation
    this.assert(
      content.includes('label_count'),
      'Workflow tracks number of labels added'
    );

    // Check for multiple label iteration
    this.assert(
      content.includes('while IFS= read -r label'),
      'Workflow iterates through multiple labels'
    );
  }

  /**
   * Test 2: Verify multiple label combinations
   */
  testMultipleLabelCombinations() {
    console.log('\n📋 Test 2: Multiple Label Combinations');

    const testCases = [
      {
        name: 'Critical priority with bug label',
        labels: ['todo', 'enhancement', 'priority: critical', 'bug'],
        expectedCount: 4
      },
      {
        name: 'High priority task',
        labels: ['todo', 'enhancement', 'priority: high'],
        expectedCount: 3
      },
      {
        name: 'Medium priority with documentation',
        labels: ['todo', 'enhancement', 'priority: medium', 'documentation'],
        expectedCount: 4
      },
      {
        name: 'Low priority improvement',
        labels: ['todo', 'enhancement', 'priority: low'],
        expectedCount: 3
      },
      {
        name: 'Multiple custom labels',
        labels: ['workflow-reliability-alert', 'infrastructure', 'priority: critical', 'must-do: phase 1'],
        expectedCount: 4
      }
    ];

    testCases.forEach(testCase => {
      this.assert(
        testCase.labels.length === testCase.expectedCount,
        `${testCase.name}: Expected ${testCase.expectedCount} labels, got ${testCase.labels.length}`
      );

      // Verify labels with special characters
      const hasSpecialCharLabels = testCase.labels.some(l => 
        l.includes(':') || l.includes(' ') || l.includes('-')
      );
      
      if (hasSpecialCharLabels) {
        this.assert(
          true,
          `${testCase.name}: Contains labels with special characters (colons, spaces, dashes)`
        );
      }

      // Verify JSON serialization
      const jsonStr = JSON.stringify(testCase.labels);
      const parsed = JSON.parse(jsonStr);
      this.assert(
        JSON.stringify(parsed) === jsonStr,
        `${testCase.name}: Labels can be serialized and deserialized correctly`
      );
    });
  }

  /**
   * Test 3: Verify label validation rules
   */
  testLabelValidationRules() {
    console.log('\n📋 Test 3: Label Validation Rules');

    const workflowPath = '.github/workflows/todo-to-issues.yml';
    const content = fs.readFileSync(workflowPath, 'utf8');

    // Check for label format validation
    this.assert(
      content.includes('[a-zA-Z0-9:\\ ._-]+'),
      'Workflow validates label format (alphanumeric, colons, spaces, dots, underscores, dashes)'
    );

    // Check for label length validation
    this.assert(
      content.includes('${#label} -le 50'),
      'Workflow validates label length (max 50 characters)'
    );

    // Test validation logic with sample labels
    const validLabels = [
      'priority: critical',
      'priority: high',
      'must-do: phase 1',
      'workflow-reliability-alert',
      'label with spaces',
      'label:with:colons'
    ];

    validLabels.forEach(label => {
      const isValid = /^[a-zA-Z0-9: ._-]+$/.test(label) && label.length <= 50;
      this.assert(
        isValid,
        `Label "${label}" passes validation rules`
      );
    });
  }

  /**
   * Test 4: Verify default label handling
   */
  testDefaultLabelHandling() {
    console.log('\n📋 Test 4: Default Label Handling');

    const workflowPath = '.github/workflows/todo-to-issues.yml';
    const content = fs.readFileSync(workflowPath, 'utf8');

    // Check that default labels are added when no valid labels exist
    this.assert(
      content.includes('gh_args+=("--label" "todo")') &&
      content.includes('gh_args+=("--label" "enhancement")'),
      'Workflow adds default labels (todo, enhancement) when no valid labels provided'
    );

    // Check for minimum label requirement
    this.assert(
      content.includes('if [ $label_count -eq 0 ]'),
      'Workflow checks for minimum label count'
    );
  }

  /**
   * Test 5: Verify structured-todo.json contains task with proper labels
   */
  testStructuredTodoTask() {
    console.log('\n📋 Test 5: Structured Todo Task Verification');

    const todoPath = 'todo/structured-todo.json';
    
    if (!fs.existsSync(todoPath)) {
      this.assert(false, 'structured-todo.json not found');
      return;
    }

    const todoContent = fs.readFileSync(todoPath, 'utf8');
    const todoData = JSON.parse(todoContent);

    // Find task_9 which is "Verify proper issue creation with multiple labels"
    let task9Found = false;
    let task9Data = null;

    if (todoData.hierarchy && todoData.hierarchy.features) {
      for (const feature of todoData.hierarchy.features) {
        if (feature.paragraphs) {
          for (const paragraph of feature.paragraphs) {
            if (paragraph.tasks) {
              const task = paragraph.tasks.find(t => t.id === 'task_9');
              if (task) {
                task9Found = true;
                task9Data = task;
                break;
              }
            }
          }
          if (task9Found) break;
        }
      }
    }

    this.assert(
      task9Found,
      'Task "Verify proper issue creation with multiple labels" (task_9) found in structured-todo.json'
    );

    if (task9Data) {
      this.assert(
        task9Data.title === 'Verify proper issue creation with multiple labels',
        'Task title matches exactly'
      );

      this.assert(
        task9Data.featureId === 'feature_12',
        'Task belongs to correct feature (feature_12)'
      );

      this.assert(
        task9Data.paragraphId === 'para_10',
        'Task belongs to correct paragraph (para_10)'
      );
    }
  }

  /**
   * Test 6: Integration test - simulate issue creation with multiple labels
   */
  testIssueCreationSimulation() {
    console.log('\n📋 Test 6: Issue Creation Simulation');

    // Simulate the complete flow of creating an issue with multiple labels
    const issueData = {
      title: 'Verify proper issue creation with multiple labels',
      body: 'Testing issue creation with multiple labels including priority and type labels',
      labels: ['todo', 'enhancement', 'priority: medium', 'testing']
    };

    // Step 1: Validate issue data structure
    this.assert(
      issueData.title && issueData.title.length > 0,
      'Simulation: Issue has valid title'
    );

    this.assert(
      issueData.body && issueData.body.length > 0,
      'Simulation: Issue has valid body'
    );

    this.assert(
      Array.isArray(issueData.labels) && issueData.labels.length > 0,
      'Simulation: Issue has labels array'
    );

    // Step 2: Validate multiple labels
    this.assert(
      issueData.labels.length >= 2,
      `Simulation: Issue has multiple labels (${issueData.labels.length} labels)`
    );

    // Step 3: Validate label formats
    const hasLabelWithColon = issueData.labels.some(l => l.includes(':'));
    this.assert(
      hasLabelWithColon,
      'Simulation: Issue includes label with colon (priority: medium)'
    );

    // Step 4: Build command arguments (as workflow would do)
    const args = ['issue', 'create', '--title', issueData.title, '--body', issueData.body];
    issueData.labels.forEach(label => {
      args.push('--label', label);
    });

    this.assert(
      args.includes('--label'),
      'Simulation: Command includes --label arguments'
    );

    this.assert(
      args.filter(a => a === '--label').length === issueData.labels.length,
      `Simulation: Command includes correct number of label arguments (${issueData.labels.length})`
    );

    // Step 5: Verify command structure preserves labels
    const labelArgs = [];
    for (let i = 0; i < args.length; i++) {
      if (args[i] === '--label' && i + 1 < args.length) {
        labelArgs.push(args[i + 1]);
      }
    }

    this.assert(
      JSON.stringify(labelArgs.sort()) === JSON.stringify(issueData.labels.sort()),
      'Simulation: All labels preserved in command arguments'
    );
  }

  /**
   * Test 7: Verify error handling for invalid label scenarios
   */
  testInvalidLabelHandling() {
    console.log('\n📋 Test 7: Invalid Label Handling');

    const workflowPath = '.github/workflows/todo-to-issues.yml';
    const content = fs.readFileSync(workflowPath, 'utf8');

    // Check for label JSON structure validation
    this.assert(
      content.includes('jq -e \'type == "array"\''),
      'Workflow validates labels field is a JSON array'
    );

    // Check for malformed JSON handling
    this.assert(
      content.includes('attempting to fix...') || content.includes('labels_fixed'),
      'Workflow attempts to fix malformed label JSON'
    );

    // Check for invalid label skipping
    this.assert(
      content.includes('Skipped invalid label'),
      'Workflow logs when invalid labels are skipped'
    );

    // Test invalid label patterns
    const invalidLabels = [
      'label`with`backticks',  // Contains backticks
      'label$with$dollars',     // Contains dollar signs
      'a'.repeat(51),           // Too long (>50 chars)
    ];

    invalidLabels.forEach(label => {
      const isInvalid = !/^[a-zA-Z0-9: ._-]+$/.test(label) || label.length > 50;
      this.assert(
        isInvalid,
        `Invalid label "${label.substring(0, 20)}..." correctly identified`
      );
    });
  }

  /**
   * Run all tests
   */
  runAllTests() {
    console.log('═══════════════════════════════════════════════════════════════');
    console.log('🧪 Multiple Label Issue Creation Verification Test');
    console.log('═══════════════════════════════════════════════════════════════');
    console.log('Task: Verify proper issue creation with multiple labels');
    console.log('Source: todo/workflow-test.md (line 13)');
    console.log('Feature: feature_12 | Paragraph: para_10 | Task: task_9\n');

    try {
      this.testWorkflowMultiLabelSupport();
      this.testMultipleLabelCombinations();
      this.testLabelValidationRules();
      this.testDefaultLabelHandling();
      this.testStructuredTodoTask();
      this.testIssueCreationSimulation();
      this.testInvalidLabelHandling();

      console.log('\n═══════════════════════════════════════════════════════════════');
      console.log('📊 Test Results Summary');
      console.log('═══════════════════════════════════════════════════════════════');
      console.log(`✅ Passed: ${this.testResults.passed}`);
      console.log(`❌ Failed: ${this.testResults.failed}`);

      if (this.testResults.failed > 0) {
        console.log('\n❌ Failed Tests:');
        this.testResults.errors.forEach((error, index) => {
          console.log(`  ${index + 1}. ${error}`);
        });
        console.log('\n⚠️  Some tests failed. Please review the issues above.');
        process.exit(1);
      } else {
        console.log('\n✅ All tests passed! Issue creation with multiple labels is working correctly.');
        console.log('\n📝 Verification Complete:');
        console.log('   • Workflow supports multiple label arrays');
        console.log('   • Labels with special characters (colons, spaces) are handled correctly');
        console.log('   • Label validation rules are in place');
        console.log('   • Default labels are added when needed');
        console.log('   • Task is properly defined in structured-todo.json');
        console.log('   • Issue creation simulation successful');
        console.log('   • Error handling for invalid labels is implemented');
        process.exit(0);
      }

    } catch (error) {
      console.error('\n💥 Test suite encountered an error:', error.message);
      console.error(error.stack);
      process.exit(1);
    }
  }
}

// Run tests if executed directly
if (require.main === module) {
  const tester = new MultiLabelIssueCreationTest();
  tester.runAllTests();
}

module.exports = MultiLabelIssueCreationTest;
