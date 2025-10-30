#!/usr/bin/env node

/**
 * Forensic Timeline Population Test Suite
 * Tests that all 15 forensic analysis events are properly integrated
 * Case: 2025-137857 - Peter Faucitt v. Jacqueline Faucitt et al.
 */

const fs = require('fs');
const path = require('path');

class ForensicTimelinePopulationTest {
  constructor() {
    this.testResults = [];
    this.errors = [];
    
    // Load forensic events data
    this.forensicDataPath = path.join(process.cwd(), 'forensic-events-data.json');
    this.forensicData = null;
    
    // Required components
    this.requiredFiles = [
      'forensic-events-data.json',
      'db/populate-forensic-timeline.js',
      'db/hypergraph-manager.js',
      'db/hypergraph-schema.js'
    ];
  }

  runAllTests() {
    console.log('📅 Forensic Timeline Population Tests');
    console.log('═'.repeat(60));

    try {
      this.testRequiredFilesExist();
      this.testForensicDataStructure();
      this.testPopulateScriptStructure();
      this.testEventCategorization();
      this.testShopifyConnections();
      
      this.printSummary();
      return this.testResults.every(result => result.passed);
      
    } catch (error) {
      this.errors.push(`Test execution error: ${error.message}`);
      console.error('❌ Test execution failed:', error);
      return false;
    }
  }

  testRequiredFilesExist() {
    console.log('\n📁 Testing Required Files Exist...');
    
    for (const file of this.requiredFiles) {
      const fullPath = path.join(process.cwd(), file);
      const exists = fs.existsSync(fullPath);
      
      this.testResults.push({
        test: `Required file exists: ${file}`,
        passed: exists,
        message: exists ? '✅ File exists' : `❌ Missing file: ${file}`
      });
      
      if (exists) {
        console.log(`  ✅ ${file}`);
      } else {
        console.log(`  ❌ ${file}`);
        this.errors.push(`Missing required file: ${file}`);
      }
    }
  }

  testForensicDataStructure() {
    console.log('\n📊 Testing Forensic Data Structure...');
    
    if (!fs.existsSync(this.forensicDataPath)) {
      this.testResults.push({
        test: 'Forensic data file exists',
        passed: false,
        message: '❌ forensic-events-data.json not found'
      });
      return;
    }
    
    try {
      this.forensicData = JSON.parse(fs.readFileSync(this.forensicDataPath, 'utf8'));
    } catch (error) {
      this.testResults.push({
        test: 'Forensic data is valid JSON',
        passed: false,
        message: `❌ Invalid JSON: ${error.message}`
      });
      this.errors.push(`Invalid JSON in forensic-events-data.json: ${error.message}`);
      return;
    }
    
    // Test data structure
    const requiredFields = [
      'caseNumber',
      'caseName',
      'criticalRevelation',
      'totalLosses',
      'timeline',
      'categories',
      'events',
      'shopifyPlatformFacts',
      'legalFramework'
    ];
    
    for (const field of requiredFields) {
      const exists = this.forensicData.hasOwnProperty(field);
      this.testResults.push({
        test: `Forensic data has field: ${field}`,
        passed: exists,
        message: exists ? '✅ Field present' : `❌ Missing field: ${field}`
      });
      
      if (exists) {
        console.log(`  ✅ ${field}`);
      } else {
        console.log(`  ❌ Missing field: ${field}`);
      }
    }
    
    // Test event count
    const eventCount = this.forensicData.events ? this.forensicData.events.length : 0;
    const hasAllEvents = eventCount === 15;
    
    this.testResults.push({
      test: 'Has all 15 forensic events',
      passed: hasAllEvents,
      message: hasAllEvents ? 
        '✅ All 15 events present' : 
        `❌ Expected 15 events, found ${eventCount}`
    });
    
    console.log(`  ${hasAllEvents ? '✅' : '❌'} Event count: ${eventCount}/15`);
    
    // Test categories
    if (this.forensicData.categories) {
      const categoryCount = this.forensicData.categories.length;
      const hasAllCategories = categoryCount === 3;
      
      this.testResults.push({
        test: 'Has all 3 categories',
        passed: hasAllCategories,
        message: hasAllCategories ? 
          '✅ All 3 categories present' : 
          `❌ Expected 3 categories, found ${categoryCount}`
      });
      
      console.log(`  ${hasAllCategories ? '✅' : '❌'} Category count: ${categoryCount}/3`);
      
      // Validate category structure
      const expectedCategories = ['revenue', 'trust', 'financial'];
      for (const catId of expectedCategories) {
        const found = this.forensicData.categories.some(c => c.id === catId);
        this.testResults.push({
          test: `Category exists: ${catId}`,
          passed: found,
          message: found ? `✅ Category ${catId} found` : `❌ Missing category: ${catId}`
        });
        
        console.log(`  ${found ? '✅' : '❌'} Category: ${catId}`);
      }
    }
  }

  testPopulateScriptStructure() {
    console.log('\n🔧 Testing Populate Script Structure...');
    
    const scriptPath = path.join(process.cwd(), 'db/populate-forensic-timeline.js');
    if (!fs.existsSync(scriptPath)) {
      this.testResults.push({
        test: 'Populate script exists',
        passed: false,
        message: '❌ populate-forensic-timeline.js not found'
      });
      return;
    }
    
    const scriptContent = fs.readFileSync(scriptPath, 'utf8');
    
    // Check for required functions and patterns
    const requiredPatterns = [
      { pattern: /populateForensicTimeline/i, description: "Main populate function" },
      { pattern: /createNode/i, description: "Create node calls" },
      { pattern: /createEdge/i, description: "Create edge calls" },
      { pattern: /forensic-events-data\.json/i, description: "Load forensic data" },
      { pattern: /perpetrator/i, description: "Perpetrator handling" },
      { pattern: /category/i, description: "Category handling" },
      { pattern: /shopify/i, description: "Shopify connection handling" },
      { pattern: /timeline/i, description: "Timeline sequence" }
    ];
    
    for (const check of requiredPatterns) {
      const found = check.pattern.test(scriptContent);
      
      this.testResults.push({
        test: `Script includes: ${check.description}`,
        passed: found,
        message: found ? '✅ Pattern found' : `❌ Missing: ${check.description}`
      });
      
      if (found) {
        console.log(`  ✅ ${check.description}`);
      } else {
        console.log(`  ❌ ${check.description}`);
      }
    }
  }

  testEventCategorization() {
    console.log('\n📂 Testing Event Categorization...');
    
    if (!this.forensicData || !this.forensicData.events) {
      console.log('  ⚠️  Skipping - forensic data not loaded');
      return;
    }
    
    // Count events per category
    const categoryCounts = {
      revenue: 0,
      trust: 0,
      financial: 0
    };
    
    for (const event of this.forensicData.events) {
      if (categoryCounts.hasOwnProperty(event.category)) {
        categoryCounts[event.category]++;
      }
    }
    
    // Validate expected counts (5 events per category)
    for (const [category, count] of Object.entries(categoryCounts)) {
      const isCorrect = count === 5;
      
      this.testResults.push({
        test: `Category ${category} has 5 events`,
        passed: isCorrect,
        message: isCorrect ? 
          `✅ ${category}: ${count} events` : 
          `❌ ${category}: expected 5, found ${count}`
      });
      
      console.log(`  ${isCorrect ? '✅' : '❌'} ${category}: ${count}/5 events`);
    }
    
    // Validate event structure
    console.log('\n  Validating event structures...');
    const requiredEventFields = [
      'id', 'date', 'title', 'category', 'perpetrators', 
      'crimeType', 'description', 'impact', 'legalSignificance',
      'shopifyConnection', 'evidenceReferences'
    ];
    
    let validEvents = 0;
    for (const event of this.forensicData.events) {
      const hasAllFields = requiredEventFields.every(field => 
        event.hasOwnProperty(field)
      );
      if (hasAllFields) {
        validEvents++;
      }
    }
    
    const allEventsValid = validEvents === this.forensicData.events.length;
    this.testResults.push({
      test: 'All events have required fields',
      passed: allEventsValid,
      message: allEventsValid ? 
        `✅ All ${validEvents} events valid` : 
        `❌ Only ${validEvents}/${this.forensicData.events.length} events valid`
    });
    
    console.log(`  ${allEventsValid ? '✅' : '❌'} Valid events: ${validEvents}/${this.forensicData.events.length}`);
  }

  testShopifyConnections() {
    console.log('\n🛍️  Testing Shopify Platform Connections...');
    
    if (!this.forensicData || !this.forensicData.events) {
      console.log('  ⚠️  Skipping - forensic data not loaded');
      return;
    }
    
    // Count Shopify-connected events
    const shopifyEvents = this.forensicData.events.filter(e => e.shopifyConnection);
    const expectedShopifyEvents = 10; // Based on forensic-events-data.json
    
    const hasExpectedShopifyEvents = shopifyEvents.length === expectedShopifyEvents;
    
    this.testResults.push({
      test: `Has ${expectedShopifyEvents} Shopify-connected events`,
      passed: hasExpectedShopifyEvents,
      message: hasExpectedShopifyEvents ? 
        `✅ ${shopifyEvents.length} Shopify-connected events` : 
        `❌ Expected ${expectedShopifyEvents}, found ${shopifyEvents.length}`
    });
    
    console.log(`  ${hasExpectedShopifyEvents ? '✅' : '❌'} Shopify events: ${shopifyEvents.length}/${expectedShopifyEvents}`);
    
    // Validate Shopify platform facts
    if (this.forensicData.shopifyPlatformFacts) {
      const facts = this.forensicData.shopifyPlatformFacts;
      const requiredFacts = [
        'owner', 'paidBy', 'since', 'duration', 
        'totalInvestment', 'keyImplication'
      ];
      
      let validFacts = 0;
      for (const fact of requiredFacts) {
        if (facts.hasOwnProperty(fact)) {
          validFacts++;
          console.log(`  ✅ ${fact}: ${facts[fact]}`);
        } else {
          console.log(`  ❌ Missing fact: ${fact}`);
        }
      }
      
      const allFactsPresent = validFacts === requiredFacts.length;
      this.testResults.push({
        test: 'All Shopify platform facts present',
        passed: allFactsPresent,
        message: allFactsPresent ? 
          '✅ All platform facts present' : 
          `❌ Missing ${requiredFacts.length - validFacts} facts`
      });
    }
    
    // Check for critical event #6 (Shopify Audit Trail Hijacking)
    const criticalEvent = this.forensicData.events.find(e => e.id === 6);
    if (criticalEvent) {
      const isCritical = criticalEvent.title.includes('Shopify Audit Trail');
      this.testResults.push({
        test: 'Critical Event #6 (Shopify Audit Trail) present',
        passed: isCritical,
        message: isCritical ? 
          '✅ Critical event found' : 
          '❌ Critical event not found or incorrect'
      });
      
      console.log(`  ${isCritical ? '✅' : '❌'} Critical Event #6: ${criticalEvent.title}`);
    }
  }

  printSummary() {
    const totalTests = this.testResults.length;
    const passedTests = this.testResults.filter(r => r.passed).length;
    const failedTests = totalTests - passedTests;
    
    console.log('\n' + '═'.repeat(60));
    console.log('📊 Forensic Timeline Population Test Summary');
    console.log('═'.repeat(60));
    console.log(`Total Tests: ${totalTests}`);
    console.log(`✅ Passed: ${passedTests}`);
    console.log(`❌ Failed: ${failedTests}`);
    console.log(`Success Rate: ${((passedTests / totalTests) * 100).toFixed(1)}%`);
    
    if (this.errors.length > 0) {
      console.log('\n🚨 Errors:');
      this.errors.forEach(error => console.log(`  ❌ ${error}`));
    }
    
    if (failedTests > 0) {
      console.log('\n❌ Failed Tests:');
      this.testResults
        .filter(r => !r.passed)
        .forEach(r => console.log(`  ❌ ${r.test}: ${r.message}`));
    }
    
    console.log('\n💡 Next Steps:');
    if (failedTests === 0) {
      console.log('  ✅ All tests passed! Ready to populate database.');
      console.log('  Run: npm run db:forensic-timeline:populate');
    } else {
      console.log('  ❌ Fix failed tests before populating database.');
    }
  }
}

// Run if called directly
if (require.main === module) {
  const test = new ForensicTimelinePopulationTest();
  const success = test.runAllTests();
  process.exit(success ? 0 : 1);
}

module.exports = ForensicTimelinePopulationTest;
