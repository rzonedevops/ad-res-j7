#!/usr/bin/env node

/**
 * Test suite for Jacqueline & Daniel Response Contradiction Checker
 * 
 * Validates that the contradiction checker correctly identifies:
 * - Consistent facts between responses
 * - Warnings about differences (but not contradictions)
 * - No false positives for contradictions
 */

const ContradictionChecker = require('../scripts/check-jax-dan-contradictions');
const fs = require('fs');
const path = require('path');

class TestRunner {
    constructor() {
        this.passed = 0;
        this.failed = 0;
        this.tests = [];
    }
    
    test(name, fn) {
        this.tests.push({ name, fn });
    }
    
    async run() {
        console.log('=== Jacqueline & Daniel Contradiction Checker Tests ===\n');
        
        for (const test of this.tests) {
            try {
                await test.fn();
                this.passed++;
                console.log(`✅ ${test.name}`);
            } catch (error) {
                this.failed++;
                console.log(`❌ ${test.name}`);
                console.log(`   Error: ${error.message}`);
            }
        }
        
        console.log(`\n=== Test Results ===`);
        console.log(`Passed: ${this.passed}`);
        console.log(`Failed: ${this.failed}`);
        console.log(`Total: ${this.tests.length}`);
        
        return this.failed === 0;
    }
}

function assert(condition, message) {
    if (!condition) {
        throw new Error(message || 'Assertion failed');
    }
}

function assertEqual(actual, expected, message) {
    if (actual !== expected) {
        throw new Error(message || `Expected ${expected}, got ${actual}`);
    }
}

function assertGreaterThan(actual, threshold, message) {
    if (actual <= threshold) {
        throw new Error(message || `Expected ${actual} to be greater than ${threshold}`);
    }
}

// Create test runner
const runner = new TestRunner();

// Test 1: Checker can be instantiated
runner.test('Checker can be instantiated', () => {
    const checker = new ContradictionChecker();
    assert(checker !== null, 'Checker should be created');
    assert(checker.jaxDir !== undefined, 'Checker should have jaxDir');
    assert(checker.danDir !== undefined, 'Checker should have danDir');
});

// Test 2: Checker finds corresponding files
runner.test('Checker finds corresponding files', () => {
    const checker = new ContradictionChecker();
    const pairs = checker.findCorrespondingFiles();
    
    assertGreaterThan(pairs.length, 0, 'Should find at least one corresponding file pair');
    
    // Verify structure of pairs
    if (pairs.length > 0) {
        const pair = pairs[0];
        assert(pair.jaxFile !== undefined, 'Pair should have jaxFile');
        assert(pair.danFile !== undefined, 'Pair should have danFile');
        assert(pair.paraId !== undefined, 'Pair should have paraId');
        assert(pair.priority !== undefined, 'Pair should have priority');
    }
});

// Test 3: Checker can extract amounts
runner.test('Checker can extract amounts', () => {
    const checker = new ContradictionChecker();
    const content = 'The cost is R500,000 and also $1,000.50';
    const amounts = checker.extractFacts(content, 'amounts');
    
    assert(amounts.length >= 2, `Should extract at least 2 amounts, got ${amounts.length}`);
    assert(amounts.some(a => a.includes('500,000')), 'Should extract R500,000');
});

// Test 4: Checker can extract dates
runner.test('Checker can extract dates', () => {
    const checker = new ContradictionChecker();
    const content = 'Event occurred on 15 June 2025 and also 2025-06-15';
    const dates = checker.extractFacts(content, 'dates');
    
    assertGreaterThan(dates.length, 0, `Should extract at least one date, got ${dates.length}`);
});

// Test 5: Checker can extract entities
runner.test('Checker can extract entities', () => {
    const checker = new ContradictionChecker();
    const content = 'RegimA Worldwide Distribution and Shopify Plus and Sage Accounting';
    const entities = checker.extractFacts(content, 'entities');
    
    assertGreaterThan(entities.length, 0, `Should extract at least one entity, got ${entities.length}`);
    assert(entities.some(e => e.includes('RegimA')), 'Should extract RegimA');
});

// Test 6: Checker runs without errors
runner.test('Checker runs without errors', () => {
    const checker = new ContradictionChecker();
    const results = checker.run();
    
    assert(results !== null, 'Results should not be null');
    assert(results.contradictions !== undefined, 'Results should have contradictions array');
    assert(results.warnings !== undefined, 'Results should have warnings array');
    assert(results.info !== undefined, 'Results should have info array');
});

// Test 7: No contradictions found in current responses
runner.test('No contradictions found in current responses', () => {
    const checker = new ContradictionChecker();
    const results = checker.run();
    
    assertEqual(results.contradictions.length, 0, 
        `Expected 0 contradictions, found ${results.contradictions.length}`);
});

// Test 8: Finds expected file pairs
runner.test('Finds critical paragraph pairs', () => {
    const checker = new ContradictionChecker();
    const pairs = checker.findCorrespondingFiles();
    
    // Should find PARA 7.2-7.5 (IT expenses)
    const para725 = pairs.find(p => p.paraId === '7_2-7_5');
    assert(para725 !== undefined, 'Should find PARA 7.2-7.5 pair');
    assert(para725.priority === 1, 'PARA 7.2-7.5 should be critical priority');
});

// Test 9: Can save results to file
runner.test('Can save results to file', () => {
    const checker = new ContradictionChecker();
    checker.run();
    
    const outputPath = '/tmp/test-contradiction-report.json';
    checker.saveResults(outputPath);
    
    assert(fs.existsSync(outputPath), 'Output file should exist');
    
    const content = fs.readFileSync(outputPath, 'utf8');
    const data = JSON.parse(content);
    
    assert(data.timestamp !== undefined, 'Report should have timestamp');
    assert(data.summary !== undefined, 'Report should have summary');
    assert(data.contradictions !== undefined, 'Report should have contradictions');
    
    // Cleanup
    fs.unlinkSync(outputPath);
});

// Test 10: Amount extraction handles various formats
runner.test('Amount extraction handles various formats', () => {
    const checker = new ContradictionChecker();
    
    const testCases = [
        { content: 'R500,000.00', expectedCount: 1 },
        { content: 'R 500,000', expectedCount: 1 },
        { content: '$1,234.56', expectedCount: 1 },
        { content: 'R100 and R200 and R300', expectedCount: 3 }
    ];
    
    for (const testCase of testCases) {
        const amounts = checker.extractFacts(testCase.content, 'amounts');
        assertGreaterThan(amounts.length, 0, 
            `Should extract amounts from "${testCase.content}", got ${amounts.length}`);
    }
});

// Test 11: Priority directory names are correct
runner.test('Priority directory names are correct', () => {
    const checker = new ContradictionChecker();
    
    assertEqual(checker.getPriorityDirName(1), '1-Critical');
    assertEqual(checker.getPriorityDirName(2), '2-High-Priority');
    assertEqual(checker.getPriorityDirName(3), '3-Medium-Priority');
    assertEqual(checker.getPriorityDirName(4), '4-Low-Priority');
    assertEqual(checker.getPriorityDirName(5), '5-Meaningless');
});

// Test 12: Context extraction works
runner.test('Context extraction works', () => {
    const checker = new ContradictionChecker();
    const content = 'This is a long document. The amount is R500,000. This is important.';
    const context = checker.getContext(content, 'R500,000', 50);
    
    assert(context.includes('R500,000'), 'Context should include the matched text');
    assert(context.length <= 150, 'Context should be limited in length');
});

// Test 13: Reports generate expected structure
runner.test('Reports generate expected structure', () => {
    const checker = new ContradictionChecker();
    const results = checker.run();
    
    // Verify result structure
    assert(Array.isArray(results.contradictions), 'Contradictions should be an array');
    assert(Array.isArray(results.warnings), 'Warnings should be an array');
    assert(Array.isArray(results.info), 'Info should be an array');
    assert(typeof results.success === 'boolean', 'Success should be boolean');
});

// Test 14: Warnings are informational not errors
runner.test('Warnings are informational not errors', () => {
    const checker = new ContradictionChecker();
    const results = checker.run();
    
    // Warnings are expected (amount ranges, etc.) but not contradictions
    assert(results.success === true || results.contradictions.length === 0, 
        'Should succeed even with warnings if no contradictions');
});

// Test 15: File paths are absolute
runner.test('File paths are absolute', () => {
    const checker = new ContradictionChecker();
    const pairs = checker.findCorrespondingFiles();
    
    if (pairs.length > 0) {
        const pair = pairs[0];
        assert(path.isAbsolute(pair.jaxFile), 'Jax file path should be absolute');
        assert(path.isAbsolute(pair.danFile), 'Dan file path should be absolute');
    }
});

// Run all tests
runner.run().then(success => {
    process.exit(success ? 0 : 1);
}).catch(error => {
    console.error('Test runner error:', error);
    process.exit(1);
});
