#!/usr/bin/env node
/**
 * Optimized Evidence Completeness Validation Script
 * Refactored to use common utilities for better performance
 */

const path = require('path');
const { 
  readJsonFile, 
  writeJsonFile, 
  Timer, 
  SimpleCache,
  formatFileSize,
  isNonEmptyFile 
} = require('../lib/utils');
const fs = require('fs');

class OptimizedEvidenceValidator {
  constructor(repoRoot = process.cwd()) {
    this.repoRoot = repoRoot;
    this.errors = [];
    this.warnings = [];
    this.passed = [];
    
    // Initialize cache for evidence lookups (5 minute TTL)
    this.evidenceCache = new SimpleCache(500, 300000);
    
    // Core revelation
    this.coreRevelation = {
      keyFact: "Dan & Kay Shopify platform paid by RegimA Zone Ltd (UK company)",
      criticalImplication: "RWD ZA has no independent revenue stream",
      evidenceRequirement: "All financial evidence must demonstrate this payment flow"
    };
    
    // Evidence categories with codes
    this.evidenceCategories = this.loadEvidenceCategories();
    
    // Completeness thresholds
    this.completenessThresholds = {
      phase1Critical: 0.80,
      phase2HighPriority: 0.60,
      overall: 0.70,
      revenueStream: 1.00
    };
  }
  
  loadEvidenceCategories() {
    // Try to load from cached JSON, otherwise use defaults
    const categoriesFile = path.join(this.repoRoot, 'lib', 'evidence-categories.json');
    const cached = this.evidenceCache.get('categories');
    
    if (cached) return cached;
    
    const defaultCategories = {
      phase1Critical: [
        "JF-RP1", "JF-RP2", "JF-DLA1", "JF-DLA2", "JF-DLA3",
        "JF-PA1", "JF-PA2", "JF-PA3", "JF-PA4", "JF-BS1",
        "JF5-DRAFT", "JF5-FINAL", "JF5-COMPARISON",
        "JF-UKTAX1", "JF-CHESNO1", "JF-CHESNO2", "JF-CHESNO3", "JF-CHESNO4",
        "JF-RESTORE1", "JF-RESTORE2", "JF-RESTORE3", "JF-RESTORE4"
      ],
      phase2HighPriority: [
        "JF-SAL1", "JF-EAL1", "JF-FSL1", "JF-CORR1", "JF-ITS1",
        "JF-HIST1", "JF-HIST2", "JF-HIST3",
        "JF-RF1", "JF-RF2", "JF-RF3",
        "JF-EX1", "JF-EX2", "JF-EX3", "JF-EX4"
      ],
      revenueStreamEvidence: [
        "SHOPIFY_PAYMENT_RECORDS",
        "REGIMA_ZONE_LTD_UK_COMPANY_DOCS",
        "RWD_ZA_REVENUE_ANALYSIS",
        "DAN_KAY_PLATFORM_EVIDENCE",
        "UK_TO_SA_PAYMENT_FLOWS"
      ]
    };
    
    const categories = readJsonFile(categoriesFile, defaultCategories);
    this.evidenceCache.set('categories', categories);
    return categories;
  }
  
  async validateAllEvidence() {
    const timer = new Timer('Evidence Validation');
    
    console.log("=".repeat(80));
    console.log("OPTIMIZED EVIDENCE COMPLETENESS VALIDATION");
    console.log("=".repeat(80));
    console.log(`\nCore Revelation: ${this.coreRevelation.keyFact}`);
    console.log(`Critical Implication: ${this.coreRevelation.criticalImplication}\n`);
    console.log("=".repeat(80));
    console.log();
    
    const results = {
      validationTimestamp: new Date().toISOString(),
      coreRevelation: this.coreRevelation,
      completenessByPhase: {},
      revenueStreamLinkage: {},
      overallCompleteness: 0.0,
      passedThreshold: false,
      recommendations: [],
      performanceMetrics: {}
    };
    
    // Validate Phase 1 Critical Evidence
    const phase1Timer = new Timer('Phase 1 Validation');
    console.log("📋 Phase 1: Critical Evidence (Must-Do)");
    console.log("-".repeat(80));
    results.completenessByPhase.phase1Critical = this.validateEvidencePhase("phase1Critical");
    results.performanceMetrics.phase1Time = phase1Timer.elapsed();
    
    // Validate Phase 2 High Priority Evidence
    const phase2Timer = new Timer('Phase 2 Validation');
    console.log("\n📋 Phase 2: High Priority Evidence (Should-Do)");
    console.log("-".repeat(80));
    results.completenessByPhase.phase2HighPriority = this.validateEvidencePhase("phase2HighPriority");
    results.performanceMetrics.phase2Time = phase2Timer.elapsed();
    
    // Validate Revenue Stream Evidence
    const revenueTimer = new Timer('Revenue Stream Validation');
    console.log("\n💰 Revenue Stream Evidence (Core Revelation)");
    console.log("-".repeat(80));
    results.revenueStreamLinkage = this.validateRevenueStreamEvidence();
    results.performanceMetrics.revenueTime = revenueTimer.elapsed();
    
    // Calculate overall completeness
    const totalEvidence = this.evidenceCategories.phase1Critical.length + 
                         this.evidenceCategories.phase2HighPriority.length;
    const totalFound = results.completenessByPhase.phase1Critical.found + 
                      results.completenessByPhase.phase2HighPriority.found;
    results.overallCompleteness = totalEvidence > 0 ? totalFound / totalEvidence : 0.0;
    results.passedThreshold = results.overallCompleteness >= this.completenessThresholds.overall;
    
    // Generate recommendations
    results.recommendations = this.generateRecommendations(results);
    
    // Print summary
    this.printValidationSummary(results);
    
    // Add total time
    results.performanceMetrics.totalTime = timer.elapsed();
    
    // Output performance metrics
    console.log("\n⚡ Performance Metrics:");
    console.log(`  Phase 1: ${results.performanceMetrics.phase1Time.toFixed(2)}s`);
    console.log(`  Phase 2: ${results.performanceMetrics.phase2Time.toFixed(2)}s`);
    console.log(`  Revenue Stream: ${results.performanceMetrics.revenueTime.toFixed(2)}s`);
    console.log(`  Total: ${results.performanceMetrics.totalTime.toFixed(2)}s`);
    console.log(`  Cache hits: ${this.evidenceCache.size()}`);
    
    timer.end();
    
    // Save results
    const outputFile = 'evidence_completeness_validation_report.json';
    if (writeJsonFile(outputFile, results)) {
      console.log(`\n✅ Report saved to: ${outputFile}`);
    }
    
    return results;
  }
  
  validateEvidencePhase(phaseKey) {
    const evidenceCodes = this.evidenceCategories[phaseKey];
    const foundEvidence = [];
    const missingEvidence = [];
    
    for (const code of evidenceCodes) {
      // Check cache first
      const cacheKey = `evidence:${code}`;
      let evidenceFiles = this.evidenceCache.get(cacheKey);
      
      if (!evidenceFiles) {
        evidenceFiles = this.findEvidenceByCode(code);
        this.evidenceCache.set(cacheKey, evidenceFiles);
      }
      
      if (evidenceFiles.length > 0) {
        foundEvidence.push(code);
        this.passed.push({ code, files: evidenceFiles, phase: phaseKey });
        
        const linkageScore = this.checkRevenueStreamLinkage(evidenceFiles);
        const linkageIndicator = linkageScore > 0 ? "🔗" : "⚪";
        
        console.log(`  ✅ FOUND ${linkageIndicator} ${code}: ${evidenceFiles.length} file(s)`);
      } else {
        missingEvidence.push(code);
        this.errors.push({ code, phase: phaseKey, error: "No evidence files found" });
        console.log(`  ❌ MISSING ${code}`);
      }
    }
    
    const completenessRate = evidenceCodes.length > 0 ? foundEvidence.length / evidenceCodes.length : 0.0;
    const threshold = this.completenessThresholds[phaseKey] || 0.70;
    const meetsThreshold = completenessRate >= threshold;
    
    console.log(`\n  Completeness: ${(completenessRate * 100).toFixed(1)}% (${foundEvidence.length}/${evidenceCodes.length})`);
    console.log(`  Threshold: ${(threshold * 100).toFixed(1)}% - ${meetsThreshold ? '✅ PASS' : '❌ FAIL'}`);
    
    return {
      total: evidenceCodes.length,
      found: foundEvidence.length,
      missing: missingEvidence.length,
      completenessRate,
      meetsThreshold,
      missingCodes: missingEvidence
    };
  }
  
  validateRevenueStreamEvidence() {
    const evidenceSearches = {
      shopifyPaymentRecords: () => this.searchFiles(['shopify', 'payment']),
      regimaZoneLtdUk: () => this.searchFiles(['regima', 'zone', 'ltd']),
      rwdZaRevenueAnalysis: () => this.searchFiles(['rwd', 'revenue', 'analysis']),
      danKayPlatform: () => this.searchFiles(['dan', 'kay', 'platform']),
      ukSaPaymentFlows: () => this.searchFiles(['uk', 'sa', 'payment', 'flow'])
    };
    
    const revenueEvidence = {};
    
    for (const [category, searchFn] of Object.entries(evidenceSearches)) {
      const files = searchFn();
      revenueEvidence[category] = {
        found: files.length > 0,
        files: files
      };
      
      const status = files.length > 0 ? "✅" : "❌";
      console.log(`  ${status} ${category}: ${files.length} file(s)`);
      if (files.length > 0 && files.length <= 3) {
        for (const file of files) {
          console.log(`      - ${file}`);
        }
      }
    }
    
    const totalCategories = Object.keys(revenueEvidence).length;
    const foundCategories = Object.values(revenueEvidence).filter(v => v.found).length;
    const completeness = totalCategories > 0 ? foundCategories / totalCategories : 0.0;
    
    console.log(`\n  Revenue Stream Completeness: ${(completeness * 100).toFixed(1)}%`);
    
    return {
      evidence: revenueEvidence,
      completeness,
      meetsThreshold: completeness >= this.completenessThresholds.revenueStream
    };
  }
  
  findEvidenceByCode(code) {
    // Simplified evidence search - scan key directories
    const searchDirs = ['evidence', 'ANNEXURES', 'docs/legal'];
    const files = [];
    
    for (const dir of searchDirs) {
      const fullPath = path.join(this.repoRoot, dir);
      if (fs.existsSync(fullPath)) {
        const found = this.searchDirectoryForCode(fullPath, code);
        files.push(...found);
      }
    }
    
    return files;
  }
  
  searchDirectoryForCode(dirPath, code) {
    const files = [];
    try {
      const entries = fs.readdirSync(dirPath, { withFileTypes: true });
      
      for (const entry of entries) {
        const fullPath = path.join(dirPath, entry.name);
        
        if (entry.isDirectory()) {
          // Recursively search subdirectories
          files.push(...this.searchDirectoryForCode(fullPath, code));
        } else if (entry.isFile()) {
          // Check if filename contains code
          if (entry.name.toUpperCase().includes(code.toUpperCase())) {
            files.push(fullPath);
          }
        }
      }
    } catch (error) {
      // Skip directories we can't read
    }
    
    return files;
  }
  
  searchFiles(keywords) {
    const cacheKey = `search:${keywords.join(':')}`;
    const cached = this.evidenceCache.get(cacheKey);
    if (cached) return cached;
    
    const files = [];
    const searchDirs = ['evidence', 'ANNEXURES', 'docs/legal'];
    
    for (const dir of searchDirs) {
      const fullPath = path.join(this.repoRoot, dir);
      if (fs.existsSync(fullPath)) {
        const found = this.searchDirectoryForKeywords(fullPath, keywords);
        files.push(...found);
      }
    }
    
    this.evidenceCache.set(cacheKey, files);
    return files;
  }
  
  searchDirectoryForKeywords(dirPath, keywords) {
    const files = [];
    try {
      const entries = fs.readdirSync(dirPath, { withFileTypes: true });
      
      for (const entry of entries) {
        const fullPath = path.join(dirPath, entry.name);
        
        if (entry.isDirectory()) {
          files.push(...this.searchDirectoryForKeywords(fullPath, keywords));
        } else if (entry.isFile()) {
          const nameLower = entry.name.toLowerCase();
          if (keywords.some(kw => nameLower.includes(kw.toLowerCase()))) {
            files.push(fullPath);
          }
        }
      }
    } catch (error) {
      // Skip directories we can't read
    }
    
    return files;
  }
  
  checkRevenueStreamLinkage(evidenceFiles) {
    const revenueKeywords = ['shopify', 'regima', 'zone', 'uk', 'payment'];
    let linkageScore = 0;
    
    for (const file of evidenceFiles) {
      const nameLower = file.toLowerCase();
      for (const keyword of revenueKeywords) {
        if (nameLower.includes(keyword)) {
          linkageScore++;
        }
      }
    }
    
    return linkageScore;
  }
  
  generateRecommendations(results) {
    const recommendations = [];
    
    // Check each phase
    for (const [phase, data] of Object.entries(results.completenessByPhase)) {
      if (!data.meetsThreshold) {
        recommendations.push({
          priority: phase.includes('Critical') ? 'high' : 'medium',
          phase: phase,
          message: `${phase} is below threshold (${(data.completenessRate * 100).toFixed(1)}%). Missing ${data.missing} items.`,
          missingCodes: data.missingCodes
        });
      }
    }
    
    // Check revenue stream linkage
    if (!results.revenueStreamLinkage.meetsThreshold) {
      recommendations.push({
        priority: 'critical',
        phase: 'revenueStream',
        message: 'Revenue stream evidence incomplete. This is critical for proving the core revelation.',
        completeness: results.revenueStreamLinkage.completeness
      });
    }
    
    return recommendations;
  }
  
  printValidationSummary(results) {
    console.log("\n" + "=".repeat(80));
    console.log("VALIDATION SUMMARY");
    console.log("=".repeat(80));
    console.log(`Overall Completeness: ${(results.overallCompleteness * 100).toFixed(1)}%`);
    console.log(`Threshold: ${(this.completenessThresholds.overall * 100).toFixed(1)}%`);
    console.log(`Status: ${results.passedThreshold ? '✅ PASS' : '❌ FAIL'}`);
    
    if (results.recommendations.length > 0) {
      console.log("\n📌 Recommendations:");
      for (const rec of results.recommendations) {
        const priority = rec.priority.toUpperCase();
        console.log(`  [${priority}] ${rec.message}`);
      }
    }
    
    console.log("\n" + "=".repeat(80));
  }
}

// Run validation
if (require.main === module) {
  const validator = new OptimizedEvidenceValidator();
  validator.validateAllEvidence()
    .then(results => {
      process.exit(results.passedThreshold ? 0 : 1);
    })
    .catch(error => {
      console.error('Validation failed:', error);
      process.exit(1);
    });
}

module.exports = OptimizedEvidenceValidator;
