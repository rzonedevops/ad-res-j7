#!/usr/bin/env node

/**
 * Test suite for ensure-labels.sh script
 * Tests the label creation and validation logic
 */

const { execSync, spawnSync } = require('child_process');
const fs = require('fs');
const path = require('path');

class EnsureLabelsTests {
  constructor() {
    this.testsPassed = 0;
    this.testsFailed = 0;
    this.errors = [];
    this.scriptPath = path.join(__dirname, '../scripts/ensure-labels.sh');
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
   * Test: Script exists and is executable
   */
  testScriptExists() {
    this.test('Script exists and is executable', () => {
      this.assert(
        fs.existsSync(this.scriptPath),
        `Script not found at ${this.scriptPath}`
      );
      
      const stats = fs.statSync(this.scriptPath);
      this.assert(
        (stats.mode & 0o111) !== 0,
        'Script is not executable'
      );
    });
  }

  /**
   * Test: Script has valid bash syntax
   */
  testScriptSyntax() {
    this.test('Script has valid bash syntax', () => {
      try {
        execSync(`bash -n ${this.scriptPath}`, { stdio: 'pipe' });
      } catch (error) {
        throw new Error(`Script has syntax errors: ${error.message}`);
      }
    });
  }

  /**
   * Test: Script contains required functions
   */
  testScriptStructure() {
    this.test('Script contains required functions', () => {
      const content = fs.readFileSync(this.scriptPath, 'utf8');
      
      // Check for main function
      this.assert(
        content.includes('main()'),
        'Script does not define main() function'
      );
      
      // Check for create_label function
      this.assert(
        content.includes('create_label()'),
        'Script does not define create_label() function'
      );
      
      // Check for default labels
      this.assert(
        content.includes('DEFAULT_LABELS=('),
        'Script does not define DEFAULT_LABELS array'
      );
    });
  }

  /**
   * Test: Script has proper error handling
   */
  testErrorHandling() {
    this.test('Script has proper error handling', () => {
      const content = fs.readFileSync(this.scriptPath, 'utf8');
      
      // Check for set -e (exit on error)
      this.assert(
        content.includes('set -e'),
        'Script does not use "set -e" for error handling'
      );
      
      // Check for gh CLI verification
      this.assert(
        content.includes('command -v gh'),
        'Script does not verify gh CLI is available'
      );
    });
  }

  /**
   * Test: Default labels are properly formatted
   */
  testDefaultLabels() {
    this.test('Default labels are properly formatted', () => {
      const content = fs.readFileSync(this.scriptPath, 'utf8');
      
      // Extract default labels section
      const labelsMatch = content.match(/DEFAULT_LABELS=\(([\s\S]*?)\n\)/);
      this.assert(labelsMatch, 'Could not find DEFAULT_LABELS array');
      
      const labelsSection = labelsMatch[1];
      
      // Check for feature label
      this.assert(
        labelsSection.includes('feature:'),
        'Default labels should include "feature" label'
      );
      
      // Check for needs-triage label
      this.assert(
        labelsSection.includes('needs-triage:'),
        'Default labels should include "needs-triage" label'
      );
      
      // Check for priority labels
      this.assert(
        labelsSection.includes('priority: critical:'),
        'Default labels should include "priority: critical" label'
      );
      
      // Verify label format (name:color:description)
      // Updated regex to handle label names with colons and spaces
      const labelLines = labelsSection.split('\n').filter(line => line.trim().startsWith('"'));
      labelLines.forEach(line => {
        // Match: "anything:6-hex-digits:anything" 
        // The label name and description can contain colons, spaces, and special chars
        // The color is always a 6-digit hex code
        const match = line.match(/"(.+?):([0-9a-fA-F]{6}):(.+)"/);
        this.assert(
          match,
          `Label line does not match expected format (name:hexcolor:description): ${line.trim()}`
        );
        
        // Validate color is 6-digit hex
        if (match) {
          const color = match[2];
          this.assert(
            /^[0-9a-fA-F]{6}$/.test(color),
            `Invalid color format in label: ${line.trim()}`
          );
        }
      });
    });
  }

  /**
   * Test: Script handles label specifications correctly
   */
  testLabelSpecificationParsing() {
    this.test('Script handles label specifications correctly', () => {
      const content = fs.readFileSync(this.scriptPath, 'utf8');
      
      // Check that label parsing is present (either IFS or bash parameter expansion)
      this.assert(
        content.includes('%%:*') || content.includes('#*:') || content.includes("IFS=':' read -r"),
        'Script should parse label specification format (name:color:description)'
      );
      
      // Check for trimming whitespace
      this.assert(
        content.includes('xargs') || content.includes('trim'),
        'Script should trim whitespace from parsed values'
      );
      
      // Check for validation
      this.assert(
        content.includes('[ -z "$name" ]'),
        'Script should validate label name is not empty'
      );
    });
  }

  /**
   * Test: Script provides helpful output
   */
  testOutputMessages() {
    this.test('Script provides helpful output messages', () => {
      const content = fs.readFileSync(this.scriptPath, 'utf8');
      
      // Check for emoji or visual indicators
      this.assert(
        content.includes('✓') || content.includes('✅') || content.includes('✗') || content.includes('❌'),
        'Script should use visual indicators in output'
      );
      
      // Check for summary section
      this.assert(
        content.includes('Summary') || content.includes('verified'),
        'Script should provide summary of actions taken'
      );
    });
  }

  /**
   * Test: Script handles gh CLI errors gracefully
   */
  testGhCliErrorHandling() {
    this.test('Script handles gh CLI errors gracefully', () => {
      const content = fs.readFileSync(this.scriptPath, 'utf8');
      
      // Check for gh CLI availability check
      this.assert(
        content.includes('if ! command -v gh'),
        'Script should check if gh CLI is available'
      );
      
      // Check for label already exists handling
      this.assert(
        content.includes('Already exists') || content.includes('already exist'),
        'Script should handle "label already exists" gracefully'
      );
      
      // Check for counting created/skipped/failed
      this.assert(
        content.includes('created') && content.includes('skipped') && content.includes('failed'),
        'Script should track created, skipped, and failed labels'
      );
    });
  }

  /**
   * Test: Script uses proper exit codes
   */
  testExitCodes() {
    this.test('Script uses proper exit codes', () => {
      const content = fs.readFileSync(this.scriptPath, 'utf8');
      
      // Check for exit 1 on errors
      this.assert(
        content.includes('exit 1'),
        'Script should exit with code 1 on errors'
      );
      
      // Check for successful exit (implicit or explicit)
      // Bash scripts exit with 0 by default if they complete without errors
    });
  }

  /**
   * Test: Script documentation is present
   */
  testDocumentation() {
    this.test('Script has proper documentation', () => {
      const content = fs.readFileSync(this.scriptPath, 'utf8');
      
      // Check for shebang
      this.assert(
        content.startsWith('#!/bin/bash'),
        'Script should start with proper shebang'
      );
      
      // Check for usage comment
      this.assert(
        content.includes('Usage:') || content.includes('usage'),
        'Script should include usage documentation'
      );
      
      // Check for example
      this.assert(
        content.includes('Example:') || content.includes('example'),
        'Script should include usage examples'
      );
    });
  }

  /**
   * Test: Label names support special characters
   */
  testSpecialCharacterSupport() {
    this.test('Script supports labels with special characters', () => {
      const content = fs.readFileSync(this.scriptPath, 'utf8');
      
      // Check that labels with colons are included
      this.assert(
        content.includes('priority: critical'),
        'Script should support labels with colons and spaces'
      );
      
      // Check that labels with dashes are included
      this.assert(
        content.includes('needs-triage') || content.includes('hierarchical-task'),
        'Script should support labels with dashes'
      );
    });
  }

  /**
   * Test: Color validation
   */
  testColorHandling() {
    this.test('Script handles colors properly', () => {
      const content = fs.readFileSync(this.scriptPath, 'utf8');
      
      // Check for default color when not provided
      this.assert(
        content.includes('cccccc') || content.includes('default color'),
        'Script should provide default color if none specified'
      );
      
      // Colors should be hex without # prefix
      const labelLines = content.match(/DEFAULT_LABELS=\(([\s\S]*?)\)/)?.[1] || '';
      const colorMatches = labelLines.match(/:([0-9a-fA-F]{6}):/g);
      if (colorMatches) {
        colorMatches.forEach(match => {
          const color = match.slice(1, -1); // Remove colons
          this.assert(
            /^[0-9a-fA-F]{6}$/.test(color),
            `Invalid color format: ${color}`
          );
        });
      }
    });
  }

  /**
   * Run all tests
   */
  runAll() {
    console.log('='.repeat(70));
    console.log('🧪 Ensure Labels Script Test Suite');
    console.log('='.repeat(70));

    this.testScriptExists();
    this.testScriptSyntax();
    this.testScriptStructure();
    this.testErrorHandling();
    this.testDefaultLabels();
    this.testLabelSpecificationParsing();
    this.testOutputMessages();
    this.testGhCliErrorHandling();
    this.testExitCodes();
    this.testDocumentation();
    this.testSpecialCharacterSupport();
    this.testColorHandling();

    this.printSummary();
  }

  /**
   * Print test summary
   */
  printSummary() {
    console.log('\n' + '='.repeat(70));
    console.log('📊 Test Results');
    console.log('='.repeat(70));
    console.log(`✅ Passed: ${this.testsPassed}`);
    console.log(`❌ Failed: ${this.testsFailed}`);
    
    if (this.errors.length > 0) {
      console.log('\n❌ Failed tests:');
      this.errors.forEach(({ test, error }) => {
        console.log(`  - ${test}`);
        console.log(`    ${error}`);
      });
    }
    
    console.log('='.repeat(70));
    
    if (this.testsFailed === 0) {
      console.log('✅ All tests passed! Label script is working correctly.\n');
      process.exit(0);
    } else {
      console.log('❌ Some tests failed. Please review the errors above.\n');
      process.exit(1);
    }
  }
}

// Run tests
const tests = new EnsureLabelsTests();
tests.runAll();
