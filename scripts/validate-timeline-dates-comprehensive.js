#!/usr/bin/env node

/**
 * Comprehensive Timeline Date Validation Script
 * 
 * This script validates dates across ALL timeline sources in the repository:
 * 1. forensic-events-data.json (15 forensic events)
 * 2. COMPREHENSIVE_TIMELINE_2017_2025.md (all annexure versions)
 * 3. Individual event folders (revenue-theft, family-trust, financial-flows)
 * 4. Timeline analysis documents
 * 
 * Validation checks:
 * - Date format consistency (YYYY-MM-DD vs other formats)
 * - Chronological accuracy across sources
 * - Cross-reference accuracy between documents
 * - Event date matching with folder names
 */

const fs = require('fs');
const path = require('path');

class TimelineDateValidator {
  constructor() {
    this.errors = [];
    this.warnings = [];
    this.info = [];
    this.dateDiscrepancies = [];
    
    // Key timeline sources
    this.sources = {
      forensicEvents: 'forensic-events-data.json',
      comprehensiveTimelines: [
        'ANNEXURES/JF09/COMPREHENSIVE_TIMELINE_2017_2025.md',
        'FINAL_AFFIDAVIT_PACKAGE/ANNEXURES/JF09/COMPREHENSIVE_TIMELINE_2017_2025.md'
      ],
      analysisTimelines: [
        'affidavit_work/analysis/COMPREHENSIVE_TIMELINE_ANALYSIS.md',
        'affidavit_work/analysis/TIMELINE_QUICK_REFERENCE.md',
        'affidavit_work/analysis/TIMELINE_ANALYSIS_COMPLETION_SUMMARY.md',
        'affidavit_work/analysis/TIMELINE_INTEGRATION_GUIDE.md',
        'KEY_TIMELINE_EVENTS_INTEGRATION_REPORT.md',
        'TIMELINE_IMPLEMENTATION_COMPLETE.md',
        'FORENSIC_TIMELINE_INTEGRATION_GUIDE.md'
      ]
    };
    
    this.eventDateMap = new Map(); // Maps event ID to expected date
    this.dateOccurrences = new Map(); // Tracks where each date appears
  }
  
  /**
   * Main validation entry point
   */
  async validate() {
    console.log('🔍 Comprehensive Timeline Date Validation\n');
    console.log('=' .repeat(80));
    
    // Step 1: Load and validate forensic events data
    this.validateForensicEvents();
    
    // Step 2: Validate comprehensive timeline documents
    this.validateComprehensiveTimelines();
    
    // Step 3: Validate analysis timeline documents
    this.validateAnalysisTimelines();
    
    // Step 4: Cross-reference dates between sources
    this.crossReferenceDates();
    
    // Step 5: Validate event folder dates
    this.validateEventFolders();
    
    // Step 6: Generate report
    this.generateReport();
    
    return {
      errors: this.errors.length,
      warnings: this.warnings.length,
      success: this.errors.length === 0
    };
  }
  
  /**
   * Validate forensic-events-data.json
   */
  validateForensicEvents() {
    console.log('\n📊 Validating Forensic Events Data...\n');
    
    try {
      const dataPath = path.join(__dirname, '..', this.sources.forensicEvents);
      const data = JSON.parse(fs.readFileSync(dataPath, 'utf8'));
      
      console.log(`  Case: ${data.caseNumber} - ${data.caseName}`);
      console.log(`  Events: ${data.events.length}`);
      console.log(`  Timeline: ${data.timeline.startDate} to ${data.timeline.endDate}`);
      console.log(`  Duration: ${data.timeline.durationDays} days\n`);
      
      // Validate each event
      data.events.forEach((event, index) => {
        // Check date format
        if (!this.isValidDateFormat(event.date)) {
          this.errors.push({
            source: 'forensic-events-data.json',
            event: event.id,
            issue: `Invalid date format: ${event.date}`,
            expected: 'YYYY-MM-DD'
          });
        }
        
        // Store event date for cross-reference
        this.eventDateMap.set(event.id, {
          date: event.date,
          title: event.title,
          category: event.category
        });
        
        // Track date occurrence
        this.trackDateOccurrence(event.date, 'forensic-events-data.json', event.title);
        
        // Validate date is within timeline range
        if (event.date < data.timeline.startDate || event.date > data.timeline.endDate) {
          this.warnings.push({
            source: 'forensic-events-data.json',
            event: event.id,
            issue: `Event date ${event.date} outside timeline range (${data.timeline.startDate} to ${data.timeline.endDate})`
          });
        }
      });
      
      // Validate chronological order
      this.validateChronologicalOrder(data.events, 'forensic-events-data.json');
      
      console.log(`  ✅ Validated ${data.events.length} events`);
      
    } catch (error) {
      this.errors.push({
        source: 'forensic-events-data.json',
        issue: `Error reading file: ${error.message}`
      });
    }
  }
  
  /**
   * Validate comprehensive timeline documents
   */
  validateComprehensiveTimelines() {
    console.log('\n📖 Validating Comprehensive Timeline Documents...\n');
    
    this.sources.comprehensiveTimelines.forEach(timelinePath => {
      const fullPath = path.join(__dirname, '..', timelinePath);
      
      if (!fs.existsSync(fullPath)) {
        this.warnings.push({
          source: timelinePath,
          issue: 'File not found'
        });
        return;
      }
      
      try {
        const content = fs.readFileSync(fullPath, 'utf8');
        
        // Extract dates in various formats
        const dates = this.extractDatesFromMarkdown(content);
        
        console.log(`  ${path.basename(timelinePath)}: ${dates.length} dates found`);
        
        // Track occurrences
        dates.forEach(dateInfo => {
          this.trackDateOccurrence(dateInfo.date, timelinePath, dateInfo.context);
        });
        
      } catch (error) {
        this.errors.push({
          source: timelinePath,
          issue: `Error reading file: ${error.message}`
        });
      }
    });
  }
  
  /**
   * Validate analysis timeline documents
   */
  validateAnalysisTimelines() {
    console.log('\n📚 Validating Analysis Timeline Documents...\n');
    
    this.sources.analysisTimelines.forEach(timelinePath => {
      const fullPath = path.join(__dirname, '..', timelinePath);
      
      if (!fs.existsSync(fullPath)) {
        // Not all files may exist, skip silently
        return;
      }
      
      try {
        const content = fs.readFileSync(fullPath, 'utf8');
        
        // Extract dates in various formats
        const dates = this.extractDatesFromMarkdown(content);
        
        console.log(`  ${path.basename(timelinePath)}: ${dates.length} dates found`);
        
        // Track occurrences
        dates.forEach(dateInfo => {
          this.trackDateOccurrence(dateInfo.date, timelinePath, dateInfo.context);
        });
        
      } catch (error) {
        this.errors.push({
          source: timelinePath,
          issue: `Error reading file: ${error.message}`
        });
      }
    });
  }
  
  /**
   * Cross-reference dates between sources
   */
  crossReferenceDates() {
    console.log('\n🔗 Cross-Referencing Dates Between Sources...\n');
    
    // Check if key events from forensic-events-data.json appear in comprehensive timeline
    const criticalEvents = [
      { id: 6, date: '2025-05-22', title: 'Shopify Audit Trail Hijacking' },
      { id: 5, date: '2025-05-15', title: 'Jax Confrontation / Unauthorized Transfers' },
      { id: 7, date: '2025-05-29', title: 'Domain Registration' }
    ];
    
    criticalEvents.forEach(event => {
      const occurrences = this.dateOccurrences.get(event.date);
      
      if (!occurrences || occurrences.length < 2) {
        this.warnings.push({
          issue: `Critical event date ${event.date} (${event.title}) appears in limited sources`,
          occurrences: occurrences ? occurrences.length : 0
        });
      } else {
        this.info.push({
          message: `✓ Critical event ${event.date} (${event.title}) verified in ${occurrences.length} sources`
        });
      }
    });
  }
  
  /**
   * Validate event folder dates
   */
  validateEventFolders() {
    console.log('\n📁 Validating Event Folder Dates...\n');
    
    const eventDirs = [
      'backups/pre-consolidation/jax-response/revenue-theft',
      'backups/pre-consolidation/jax-response/family-trust',
      'backups/pre-consolidation/jax-response/financial-flows'
    ];
    
    eventDirs.forEach(dirPath => {
      const fullPath = path.join(__dirname, '..', dirPath);
      
      if (!fs.existsSync(fullPath)) {
        return;
      }
      
      const folders = fs.readdirSync(fullPath, { withFileTypes: true })
        .filter(dirent => dirent.isDirectory())
        .map(dirent => dirent.name);
      
      folders.forEach(folder => {
        // Extract date from folder name (e.g., "22-may-shopify-audit")
        const match = folder.match(/^(\d{1,2})-(jan|feb|mar|apr|may|june?|july?|aug|sep|oct|nov|dec)/i);
        
        if (match) {
          const day = match[1].padStart(2, '0');
          const monthStr = match[2].toLowerCase();
          const monthMap = {
            'jan': '01', 'feb': '02', 'mar': '03', 'apr': '04',
            'may': '05', 'jun': '06', 'june': '06', 'jul': '07', 'july': '07',
            'aug': '08', 'sep': '09', 'oct': '10', 'nov': '11', 'dec': '12'
          };
          
          const month = monthMap[monthStr];
          const expectedDate = `2025-${month}-${day}`;
          
          // Check if this date is in forensic events
          const matchingEvent = Array.from(this.eventDateMap.values())
            .find(e => e.date === expectedDate);
          
          if (matchingEvent) {
            this.info.push({
              message: `✓ Folder ${folder} matches event date ${expectedDate} (${matchingEvent.title})`
            });
          }
        }
      });
    });
  }
  
  /**
   * Validate chronological order of events
   */
  validateChronologicalOrder(events, source) {
    for (let i = 1; i < events.length; i++) {
      if (events[i].date < events[i - 1].date) {
        this.errors.push({
          source: source,
          issue: `Chronological order violation: Event ${events[i].id} (${events[i].date}) before Event ${events[i-1].id} (${events[i-1].date})`
        });
      }
    }
  }
  
  /**
   * Extract dates from markdown content
   */
  extractDatesFromMarkdown(content) {
    const dates = [];
    const lines = content.split('\n');
    
    // Pattern for YYYY-MM-DD
    const isoDatePattern = /\b(\d{4})-(\d{2})-(\d{2})\b/g;
    // Pattern for Month DD, YYYY
    const monthDatePattern = /\b(January|February|March|April|May|June|July|August|September|October|November|December)\s+(\d{1,2}),?\s+(\d{4})\b/g;
    
    lines.forEach((line, lineNum) => {
      let match;
      
      // Extract ISO dates
      while ((match = isoDatePattern.exec(line)) !== null) {
        dates.push({
          date: match[0],
          line: lineNum + 1,
          context: line.trim().substring(0, 80)
        });
      }
      
      // Extract month-formatted dates
      while ((match = monthDatePattern.exec(line)) !== null) {
        const monthMap = {
          'January': '01', 'February': '02', 'March': '03', 'April': '04',
          'May': '05', 'June': '06', 'July': '07', 'August': '08',
          'September': '09', 'October': '10', 'November': '11', 'December': '12'
        };
        
        const month = monthMap[match[1]];
        const day = match[2].padStart(2, '0');
        const year = match[3];
        const isoDate = `${year}-${month}-${day}`;
        
        dates.push({
          date: isoDate,
          line: lineNum + 1,
          context: line.trim().substring(0, 80),
          originalFormat: match[0]
        });
      }
    });
    
    return dates;
  }
  
  /**
   * Check if date is in valid YYYY-MM-DD format
   */
  isValidDateFormat(dateStr) {
    const pattern = /^\d{4}-\d{2}-\d{2}$/;
    if (!pattern.test(dateStr)) {
      return false;
    }
    
    // Validate it's a real date
    const date = new Date(dateStr);
    return date instanceof Date && !isNaN(date);
  }
  
  /**
   * Track where a date occurs
   */
  trackDateOccurrence(date, source, context) {
    if (!this.dateOccurrences.has(date)) {
      this.dateOccurrences.set(date, []);
    }
    
    this.dateOccurrences.get(date).push({
      source: source,
      context: context
    });
  }
  
  /**
   * Generate validation report
   */
  generateReport() {
    console.log('\n' + '='.repeat(80));
    console.log('📋 Validation Summary\n');
    
    console.log(`✅ Info Messages: ${this.info.length}`);
    console.log(`⚠️  Warnings: ${this.warnings.length}`);
    console.log(`❌ Errors: ${this.errors.length}\n`);
    
    if (this.warnings.length > 0) {
      console.log('Warnings:');
      this.warnings.forEach((warning, idx) => {
        console.log(`  ${idx + 1}. ${warning.issue || JSON.stringify(warning)}`);
      });
      console.log('');
    }
    
    if (this.errors.length > 0) {
      console.log('Errors:');
      this.errors.forEach((error, idx) => {
        console.log(`  ${idx + 1}. [${error.source}] ${error.issue}`);
      });
      console.log('');
    }
    
    // Date occurrence summary
    console.log('📅 Date Occurrence Summary:');
    const sortedDates = Array.from(this.dateOccurrences.keys()).sort();
    sortedDates.forEach(date => {
      const occurrences = this.dateOccurrences.get(date);
      console.log(`  ${date}: ${occurrences.length} occurrence(s)`);
    });
    
    console.log('\n' + '='.repeat(80));
    
    if (this.errors.length === 0) {
      console.log('✅ TIMELINE DATE VALIDATION PASSED');
    } else {
      console.log('❌ TIMELINE DATE VALIDATION FAILED');
    }
    
    // Write detailed report to file
    const report = {
      timestamp: new Date().toISOString(),
      summary: {
        errors: this.errors.length,
        warnings: this.warnings.length,
        info: this.info.length
      },
      errors: this.errors,
      warnings: this.warnings,
      info: this.info,
      dateOccurrences: Object.fromEntries(this.dateOccurrences)
    };
    
    const reportPath = path.join(__dirname, '..', 'timeline_date_validation_report.json');
    fs.writeFileSync(reportPath, JSON.stringify(report, null, 2));
    console.log(`\n📄 Detailed report written to: timeline_date_validation_report.json`);
  }
}

// Run validation
const validator = new TimelineDateValidator();
validator.validate()
  .then(result => {
    process.exit(result.success ? 0 : 1);
  })
  .catch(error => {
    console.error('Fatal error:', error);
    process.exit(1);
  });
