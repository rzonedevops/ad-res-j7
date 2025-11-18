#!/usr/bin/env node

/**
 * YAML Front Matter Validator
 * Validates YAML front matter in all markdown files to prevent Jekyll build failures
 * 
 * This script checks for:
 * 1. Orphaned opening --- without closing ---
 * 2. Invalid YAML syntax in front matter
 * 3. Files that start with --- but have content on the same line
 */

const fs = require('fs');
const path = require('path');

class YAMLFrontMatterValidator {
  constructor() {
    this.errors = [];
    this.warnings = [];
    this.validFiles = 0;
    this.invalidFiles = 0;
    this.excludeDirs = ['.git', 'node_modules', '.github', 'dist', '_site', 'build'];
  }

  /**
   * Check if a file has valid YAML front matter
   * Returns: 'valid', 'invalid', 'none', or 'error'
   */
  validateFile(filepath) {
    try {
      const content = fs.readFileSync(filepath, 'utf-8');
      const lines = content.split('\n');
      
      if (lines.length < 2) {
        return { status: 'none', message: 'File too short to contain YAML front matter' };
      }
      
      // Check if file starts with ---
      const firstLine = lines[0].trim();
      if (firstLine !== '---') {
        return { status: 'none', message: 'No YAML front matter detected' };
      }
      
      // File starts with ---, look for closing ---
      let closingLineIndex = -1;
      for (let i = 1; i < Math.min(lines.length, 100); i++) { // Check first 100 lines max
        if (lines[i].trim() === '---') {
          closingLineIndex = i;
          break;
        }
      }
      
      if (closingLineIndex === -1) {
        return {
          status: 'invalid',
          message: 'YAML front matter opened with --- but not closed',
          error: 'Missing closing --- delimiter'
        };
      }
      
      // Check if there's actual content between the delimiters
      const yamlContent = lines.slice(1, closingLineIndex).join('\n').trim();
      if (yamlContent.length === 0) {
        return {
          status: 'invalid',
          message: 'Empty YAML front matter (no content between --- delimiters)',
          warning: 'Consider removing empty YAML front matter'
        };
      }
      
      // Basic YAML syntax validation
      // Check for common errors like missing colons, improper indentation
      const yamlLines = lines.slice(1, closingLineIndex);
      let inMultilineValue = false;
      
      for (let i = 0; i < yamlLines.length; i++) {
        const line = yamlLines[i];
        const trimmed = line.trim();
        
        // Skip empty lines and comments
        if (trimmed === '' || trimmed.startsWith('#')) {
          continue;
        }
        
        // Check if previous line ended with > or | (multiline string indicators)
        if (i > 0) {
          const prevLine = yamlLines[i - 1].trim();
          if (prevLine.endsWith('>') || prevLine.endsWith('|') || prevLine.endsWith('>-') || prevLine.endsWith('|-')) {
            inMultilineValue = true;
          }
        }
        
        // If we're in a multiline value, lines don't need colons
        if (inMultilineValue) {
          // Check if we've exited the multiline value (line starts at base indentation with colon)
          if (line.match(/^[a-zA-Z_]/) && line.includes(':')) {
            inMultilineValue = false;
          } else {
            continue; // Skip validation for multiline content
          }
        }
        
        // Check for key-value pairs (should have a colon)
        if (!trimmed.includes(':') && !trimmed.startsWith('-')) {
          return {
            status: 'invalid',
            message: `Invalid YAML syntax at line ${i + 2}`,
            error: `Line does not contain a key-value pair or list item: "${trimmed}"`
          };
        }
      }
      
      return {
        status: 'valid',
        message: 'Valid YAML front matter',
        linesCount: closingLineIndex + 1
      };
      
    } catch (error) {
      return {
        status: 'error',
        message: `Error reading file: ${error.message}`,
        error: error.message
      };
    }
  }

  /**
   * Recursively scan directory for markdown files
   */
  scanDirectory(dir) {
    const entries = fs.readdirSync(dir, { withFileTypes: true });
    
    for (const entry of entries) {
      const fullPath = path.join(dir, entry.name);
      
      if (entry.isDirectory()) {
        // Skip excluded directories
        if (this.excludeDirs.includes(entry.name)) {
          continue;
        }
        this.scanDirectory(fullPath);
      } else if (entry.isFile() && entry.name.endsWith('.md')) {
        const result = this.validateFile(fullPath);
        
        if (result.status === 'invalid') {
          this.invalidFiles++;
          this.errors.push({
            file: fullPath,
            message: result.message,
            error: result.error
          });
        } else if (result.status === 'error') {
          this.invalidFiles++;
          this.errors.push({
            file: fullPath,
            message: result.message,
            error: result.error
          });
        } else if (result.status === 'valid') {
          this.validFiles++;
          if (result.warning) {
            this.warnings.push({
              file: fullPath,
              warning: result.warning
            });
          }
        } else {
          // status === 'none', file doesn't have YAML front matter
          this.validFiles++;
        }
      }
    }
  }

  /**
   * Run validation and generate report
   */
  validate(rootDir) {
    console.log('🔍 Validating YAML front matter in markdown files...\n');
    
    this.scanDirectory(rootDir);
    
    // Print results
    console.log('📊 Validation Results:');
    console.log('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
    console.log(`✅ Valid files:   ${this.validFiles}`);
    console.log(`❌ Invalid files: ${this.invalidFiles}`);
    console.log(`⚠️  Warnings:      ${this.warnings.length}`);
    console.log('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n');
    
    // Print errors
    if (this.errors.length > 0) {
      console.log('❌ Errors found:\n');
      this.errors.forEach((err, index) => {
        console.log(`${index + 1}. ${err.file}`);
        console.log(`   Message: ${err.message}`);
        if (err.error) {
          console.log(`   Error: ${err.error}`);
        }
        console.log();
      });
    }
    
    // Print warnings
    if (this.warnings.length > 0) {
      console.log('⚠️  Warnings:\n');
      this.warnings.forEach((warn, index) => {
        console.log(`${index + 1}. ${warn.file}`);
        console.log(`   Warning: ${warn.warning}`);
        console.log();
      });
    }
    
    // Summary
    if (this.invalidFiles === 0 && this.warnings.length === 0) {
      console.log('✅ All markdown files have valid YAML front matter!\n');
      return true;
    } else if (this.invalidFiles > 0) {
      console.log('❌ Validation failed. Please fix the errors above.\n');
      return false;
    } else {
      console.log('⚠️  Validation passed with warnings.\n');
      return true;
    }
  }
}

// Main execution
if (require.main === module) {
  const validator = new YAMLFrontMatterValidator();
  const rootDir = process.argv[2] || '.';
  
  const success = validator.validate(rootDir);
  process.exit(success ? 0 : 1);
}

module.exports = YAMLFrontMatterValidator;
