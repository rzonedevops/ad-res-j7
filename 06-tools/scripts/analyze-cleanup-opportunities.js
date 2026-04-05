#!/usr/bin/env node
/**
 * Repository Cleanup Analyzer
 * Identifies potentially unused files and optimization opportunities
 */

const fs = require('fs');
const path = require('path');
const { formatFileSize, Timer } = require('../lib/utils');

class CleanupAnalyzer {
  constructor(repoRoot = process.cwd()) {
    this.repoRoot = repoRoot;
    this.unusedFiles = [];
    this.duplicatePatterns = [];
    this.largeFiles = [];
    this.tempFiles = [];
    
    // Patterns for temporary/generated files
    this.tempPatterns = [
      /\.tmp$/,
      /\.temp$/,
      /-results\.json$/,
      /-report\.json$/,
      /^test-.*\.json$/,
      /node_modules/,
      /\.pyc$/,
      /__pycache__/,
      /\.swp$/,
      /\.swo$/,
      /~$/
    ];
    
    // Large file threshold (10MB)
    this.largeFileThreshold = 10 * 1024 * 1024;
  }
  
  /**
   * Scan repository for optimization opportunities
   */
  async analyze() {
    const timer = new Timer('Repository Analysis');
    
    console.log('='.repeat(80));
    console.log('REPOSITORY CLEANUP ANALYZER');
    console.log('='.repeat(80));
    console.log();
    
    // Analyze Python files
    console.log('🐍 Analyzing Python files...');
    await this.analyzePythonFiles();
    
    // Analyze JavaScript files
    console.log('📜 Analyzing JavaScript files...');
    await this.analyzeJavaScriptFiles();
    
    // Find large files
    console.log('📦 Finding large files...');
    await this.findLargeFiles();
    
    // Find temporary files
    console.log('🗑️  Finding temporary files...');
    await this.findTempFiles();
    
    // Generate report
    this.generateReport();
    
    timer.end();
  }
  
  /**
   * Analyze Python files for optimization
   */
  async analyzePythonFiles() {
    const pythonFiles = this.findFiles('.py');
    const analysis = {
      total: pythonFiles.length,
      potentialDuplicates: [],
      unused: []
    };
    
    // Check for similar names (potential duplicates)
    const baseNames = new Map();
    
    for (const file of pythonFiles) {
      const basename = path.basename(file, '.py');
      
      // Track similar names
      if (basename.includes('_optimized') || basename.includes('_old') || 
          basename.includes('_backup') || basename.includes('_test')) {
        const originalName = basename
          .replace('_optimized', '')
          .replace('_old', '')
          .replace('_backup', '')
          .replace('_test', '');
        
        if (!baseNames.has(originalName)) {
          baseNames.set(originalName, []);
        }
        baseNames.get(originalName).push(file);
      }
    }
    
    // Find potential duplicates
    for (const [name, files] of baseNames.entries()) {
      if (files.length > 1) {
        analysis.potentialDuplicates.push({
          name,
          files,
          count: files.length
        });
      }
    }
    
    console.log(`  Found ${analysis.total} Python files`);
    console.log(`  Potential duplicates: ${analysis.potentialDuplicates.length}`);
    
    this.duplicatePatterns.push(...analysis.potentialDuplicates);
  }
  
  /**
   * Analyze JavaScript files for optimization
   */
  async analyzeJavaScriptFiles() {
    const jsFiles = this.findFiles('.js');
    const analysis = {
      total: jsFiles.length,
      potentialDuplicates: [],
      unused: []
    };
    
    // Check for similar names
    const baseNames = new Map();
    
    for (const file of jsFiles) {
      const basename = path.basename(file, '.js');
      
      if (basename.includes('-optimized') || basename.includes('-old') || 
          basename.includes('-backup') || basename.includes('-test')) {
        const originalName = basename
          .replace('-optimized', '')
          .replace('-old', '')
          .replace('-backup', '')
          .replace('-test', '');
        
        if (!baseNames.has(originalName)) {
          baseNames.set(originalName, []);
        }
        baseNames.get(originalName).push(file);
      }
    }
    
    for (const [name, files] of baseNames.entries()) {
      if (files.length > 1) {
        analysis.potentialDuplicates.push({
          name,
          files,
          count: files.length
        });
      }
    }
    
    console.log(`  Found ${analysis.total} JavaScript files`);
    console.log(`  Potential duplicates: ${analysis.potentialDuplicates.length}`);
    
    this.duplicatePatterns.push(...analysis.potentialDuplicates);
  }
  
  /**
   * Find large files that might need optimization
   */
  async findLargeFiles() {
    const allFiles = this.findFiles();
    
    for (const file of allFiles) {
      try {
        const stats = fs.statSync(file);
        
        if (stats.isFile() && stats.size > this.largeFileThreshold) {
          this.largeFiles.push({
            path: file,
            size: stats.size,
            sizeFormatted: formatFileSize(stats.size),
            ext: path.extname(file)
          });
        }
      } catch (error) {
        // Skip files we can't read
      }
    }
    
    // Sort by size descending
    this.largeFiles.sort((a, b) => b.size - a.size);
    
    console.log(`  Found ${this.largeFiles.length} large files (>10MB)`);
  }
  
  /**
   * Find temporary files that can be cleaned up
   */
  async findTempFiles() {
    const allFiles = this.findFiles();
    
    for (const file of allFiles) {
      const relativePath = path.relative(this.repoRoot, file);
      
      // Check against temp patterns
      for (const pattern of this.tempPatterns) {
        if (pattern.test(relativePath)) {
          try {
            const stats = fs.statSync(file);
            this.tempFiles.push({
              path: file,
              relativePath,
              size: stats.size,
              sizeFormatted: formatFileSize(stats.size)
            });
          } catch (error) {
            // Skip
          }
          break;
        }
      }
    }
    
    console.log(`  Found ${this.tempFiles.length} temporary files`);
  }
  
  /**
   * Find all files with optional extension filter
   */
  findFiles(extension = null) {
    const files = [];
    
    const scanDir = (dir) => {
      try {
        const entries = fs.readdirSync(dir, { withFileTypes: true });
        
        for (const entry of entries) {
          const fullPath = path.join(dir, entry.name);
          
          // Skip common ignore patterns
          if (entry.name === 'node_modules' || 
              entry.name === '.git' ||
              entry.name === '__pycache__') {
            continue;
          }
          
          if (entry.isDirectory()) {
            scanDir(fullPath);
          } else if (entry.isFile()) {
            if (!extension || fullPath.endsWith(extension)) {
              files.push(fullPath);
            }
          }
        }
      } catch (error) {
        // Skip directories we can't read
      }
    };
    
    scanDir(this.repoRoot);
    return files;
  }
  
  /**
   * Generate cleanup report
   */
  generateReport() {
    console.log();
    console.log('='.repeat(80));
    console.log('CLEANUP REPORT');
    console.log('='.repeat(80));
    console.log();
    
    // Duplicate patterns
    if (this.duplicatePatterns.length > 0) {
      console.log('🔄 Potential Duplicate Files:');
      console.log('-'.repeat(80));
      for (const dup of this.duplicatePatterns.slice(0, 10)) {
        console.log(`\n  ${dup.name} (${dup.count} versions):`);
        for (const file of dup.files) {
          const relativePath = path.relative(this.repoRoot, file);
          console.log(`    - ${relativePath}`);
        }
      }
      if (this.duplicatePatterns.length > 10) {
        console.log(`\n  ... and ${this.duplicatePatterns.length - 10} more duplicate patterns`);
      }
      console.log();
    }
    
    // Large files
    if (this.largeFiles.length > 0) {
      console.log('📦 Large Files (>10MB):');
      console.log('-'.repeat(80));
      for (const file of this.largeFiles.slice(0, 10)) {
        const relativePath = path.relative(this.repoRoot, file.path);
        console.log(`  ${file.sizeFormatted.padEnd(10)} ${relativePath}`);
      }
      if (this.largeFiles.length > 10) {
        console.log(`  ... and ${this.largeFiles.length - 10} more large files`);
      }
      console.log();
    }
    
    // Temporary files
    if (this.tempFiles.length > 0) {
      const totalTempSize = this.tempFiles.reduce((sum, f) => sum + f.size, 0);
      console.log('🗑️  Temporary Files:');
      console.log('-'.repeat(80));
      console.log(`  Total: ${this.tempFiles.length} files (${formatFileSize(totalTempSize)})`);
      console.log();
      console.log('  Examples:');
      for (const file of this.tempFiles.slice(0, 10)) {
        console.log(`  ${file.sizeFormatted.padEnd(10)} ${file.relativePath}`);
      }
      if (this.tempFiles.length > 10) {
        console.log(`  ... and ${this.tempFiles.length - 10} more`);
      }
      console.log();
    }
    
    // Recommendations
    console.log('💡 Recommendations:');
    console.log('-'.repeat(80));
    
    if (this.duplicatePatterns.length > 0) {
      console.log('  1. Review duplicate files and consolidate where possible');
      console.log('     - Keep the optimized version, remove old versions');
      console.log('     - Archive backups if still needed');
    }
    
    if (this.largeFiles.length > 0) {
      console.log('  2. Optimize or compress large files');
      console.log('     - Consider Git LFS for large binary files');
      console.log('     - Compress or split large JSON files');
    }
    
    if (this.tempFiles.length > 0) {
      console.log('  3. Clean up temporary files');
      console.log('     - Add patterns to .gitignore');
      console.log(`     - Can free up ${formatFileSize(this.tempFiles.reduce((s, f) => s + f.size, 0))}`);
    }
    
    console.log();
    console.log('='.repeat(80));
  }
}

// Run analyzer
if (require.main === module) {
  const analyzer = new CleanupAnalyzer();
  analyzer.analyze().catch(error => {
    console.error('❌ Analysis failed:', error);
    process.exit(1);
  });
}

module.exports = CleanupAnalyzer;
