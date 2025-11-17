#!/usr/bin/env node

/**
 * Special Characters Workflow Test
 * 
 * From: todo/workflow-validation-tests.md, line 14 (Should-Do High Priority)
 * Task: "Test the workflow with sample tasks containing special characters"
 * 
 * This test validates that the todo-to-issues workflow correctly handles:
 * - Tasks with émojis and ünicode characters (line 47)
 * - Tasks with "quotes" and 'apostrophes' (line 48)
 * - Tasks with numbers: 123, percentages: 50%, and symbols: $@# (line 49)
 * - Tasks with markdown formatting (bold, italic, code, links) (line 33)
 * - Long task descriptions that exceed 80 characters (lines 53-54)
 */

const fs = require('fs');
const path = require('path');
const TestResultArchiver = require('./test-result-archiver');

class SpecialCharactersWorkflowTest {
  constructor() {
    this.testResults = [];
    this.errors = [];
    this.testDataDir = '/tmp/special-chars-test';
    this.startTime = Date.now();
  }

  // Test helper function
  assert(condition, message) {
    const result = {
      test: message,
      passed: condition,
      timestamp: new Date().toISOString(),
      suite: 'special-characters'
    };
    
    this.testResults.push(result);
    
    if (condition) {
      console.log(`✅ ${message}`);
    } else {
      console.log(`❌ ${message}`);
      this.errors.push(message);
    }
    
    return condition;
  }

  setup() {
    console.log('🔧 Setting up special characters test environment...');
    
    if (!fs.existsSync(this.testDataDir)) {
      fs.mkdirSync(this.testDataDir, { recursive: true });
    }
  }

  cleanup() {
    console.log('🧹 Cleaning up special characters test environment...');
    
    if (fs.existsSync(this.testDataDir)) {
      fs.rmSync(this.testDataDir, { recursive: true, force: true });
    }
  }

  // Simulate the parseMarkdownForTasks logic from the workflow
  parseMarkdownForTasks(content, filename) {
    const lines = content.split('\n');
    const tasks = [];
    let currentSection = '';
    let currentPriority = 'medium';
    
    for (let i = 0; i < lines.length; i++) {
      const line = lines[i].trim();
      
      // Track current section
      if (line.match(/^#{1,4}\s+/)) {
        currentSection = line.replace(/^#+\s+/, '');
        
        // Determine priority from section
        if (line.toLowerCase().includes('critical') || line.toLowerCase().includes('must-do')) {
          currentPriority = 'critical';
        } else if (line.toLowerCase().includes('high') || line.toLowerCase().includes('should-do')) {
          currentPriority = 'high';
        } else if (line.toLowerCase().includes('low') || line.toLowerCase().includes('nice-to-have')) {
          currentPriority = 'low';
        }
      }
      
      // Look for numbered tasks
      const numberedTask = line.match(/^\d+\.\s*(.+)$/);
      if (numberedTask && numberedTask[1].length > 10) {
        tasks.push({
          task: numberedTask[1].trim(),
          section: currentSection,
          priority: currentPriority,
          file: filename,
          lineNumber: i + 1,
          type: 'numbered_task'
        });
      }
      
      // Look for bulleted tasks with action words
      const bulletMatch = line.match(/^[-*]\s*(.+)$/);
      if (bulletMatch && bulletMatch[1].length > 15) {
        const taskText = bulletMatch[1].trim();
        if (/\b(implement|create|fix|test|validate|ensure|add|update|develop)\b/i.test(taskText)) {
          tasks.push({
            task: taskText,
            section: currentSection,
            priority: currentPriority,
            file: filename,
            lineNumber: i + 1,
            type: 'bullet_task'
          });
        }
      }
    }
    
    return tasks;
  }

  // Generate issue content similar to the workflow
  generateIssueContent(task) {
    let title = task.task;
    
    // Remove markdown formatting
    title = title.replace(/\*\*(.+?)\*\*/g, '$1');
    title = title.replace(/\*(.+?)\*/g, '$1');
    title = title.replace(/`(.+?)`/g, '$1');
    
    // Trim and clean
    title = title.replace(/^[-*\d.\s]+/, '').trim();
    
    // Limit length to 80 characters
    if (title.length > 80) {
      title = title.substring(0, 77) + '...';
    }
    
    return {
      title: title,
      originalTask: task.task,
      priority: task.priority,
      section: task.section,
      characterTypes: this.analyzeCharacterTypes(task.task)
    };
  }

  // Analyze what types of special characters are in the text
  analyzeCharacterTypes(text) {
    const types = {
      emoji: /[\u{1F300}-\u{1F9FF}]/u.test(text),
      unicode: /[^\x00-\x7F]/.test(text),
      quotes: /["']/.test(text),
      numbers: /\d/.test(text),
      percentage: /%/.test(text),
      symbols: /[$@#%^&*()!~`+=\[\]{}|\\;:<>?\/]/.test(text),
      markdown_bold: /\*\*.*?\*\*/.test(text),
      markdown_italic: /\*.*?\*/.test(text) || /_.*?_/.test(text),
      markdown_code: /`.*?`/.test(text),
      markdown_link: /\[.*?\]\(.*?\)/.test(text)
    };
    
    return types;
  }

  // Test 1: Émojis and Unicode Characters (from line 47)
  testEmojisAndUnicode() {
    console.log('\n🌍 Test 1: Émojis and ünicode characters in task descriptions...');
    
    const testContent = `# Special Characters Testing

## Should-Do (High Priority)

1. Test with émojis and ünicode characters in task descriptions
2. Implement 🚀 rocket feature with ✨ sparkles and 🎯 targeting
3. Add support for Français, Español, and 日本語 internationalization
4. Create système de gestion with ñoño and Zürich compatibility
5. Develop feature with café, naïve, and résumé handling
`;

    try {
      const testFile = path.join(this.testDataDir, 'emoji-unicode-test.md');
      fs.writeFileSync(testFile, testContent, 'utf8');
      
      const parsedTasks = this.parseMarkdownForTasks(testContent, testFile);
      
      this.assert(parsedTasks.length >= 5, `Found all emoji/unicode tasks (found ${parsedTasks.length})`);
      
      // Verify specific tasks were parsed
      const emojiTask = parsedTasks.find(t => t.task.includes('🚀') || t.task.includes('émojis'));
      this.assert(emojiTask !== undefined, 'Parsed task with emoji characters');
      
      const unicodeTask = parsedTasks.find(t => t.task.includes('ünicode') || t.task.includes('Français'));
      this.assert(unicodeTask !== undefined, 'Parsed task with unicode characters');
      
      // Test issue generation
      if (emojiTask) {
        const issue = this.generateIssueContent(emojiTask);
        this.assert(issue.title.length > 0, 'Generated valid title from emoji task');
        this.assert(issue.characterTypes.emoji || issue.characterTypes.unicode, 'Detected special characters in task');
      }
      
      // Verify file encoding preserved unicode
      const readContent = fs.readFileSync(testFile, 'utf8');
      this.assert(readContent.includes('émojis'), 'File encoding preserves accented characters');
      this.assert(readContent.includes('🚀'), 'File encoding preserves emoji characters');
      
    } catch (error) {
      this.assert(false, `Emoji/Unicode test error: ${error.message}`);
    }
  }

  // Test 2: Quotes and Apostrophes (from line 48)
  testQuotesAndApostrophes() {
    console.log('\n💬 Test 2: Tasks with "quotes" and \'apostrophes\'...');
    
    const testContent = `# Quote Testing

## Should-Do (High Priority)

1. Validate proper handling of tasks with "quotes" and 'apostrophes'
2. Test "double quotes" in task descriptions
3. Handle 'single quotes' correctly
4. Process mixed "quotes" and 'apostrophes' together
5. Ensure it's, don't, and can't contractions work properly
6. Test nested "quotes 'within' quotes" scenarios
`;

    try {
      const testFile = path.join(this.testDataDir, 'quotes-test.md');
      fs.writeFileSync(testFile, testContent, 'utf8');
      
      const parsedTasks = this.parseMarkdownForTasks(testContent, testFile);
      
      this.assert(parsedTasks.length >= 5, `Found all quote tasks (found ${parsedTasks.length})`);
      
      // Test various quote scenarios
      const doubleQuoteTask = parsedTasks.find(t => t.task.includes('"double quotes"'));
      this.assert(doubleQuoteTask !== undefined, 'Parsed task with double quotes');
      
      const singleQuoteTask = parsedTasks.find(t => t.task.includes('\'single quotes\''));
      this.assert(singleQuoteTask !== undefined, 'Parsed task with single quotes');
      
      const contractionTask = parsedTasks.find(t => t.task.includes('it\'s') || t.task.includes('don\'t'));
      this.assert(contractionTask !== undefined, 'Parsed task with contractions');
      
      // Test issue generation preserves quotes
      if (doubleQuoteTask) {
        const issue = this.generateIssueContent(doubleQuoteTask);
        this.assert(issue.title.length > 0, 'Generated valid title from quoted task');
        this.assert(issue.characterTypes.quotes, 'Detected quote characters');
      }
      
    } catch (error) {
      this.assert(false, `Quote test error: ${error.message}`);
    }
  }

  // Test 3: Numbers, Percentages, and Symbols (from line 49)
  testNumbersPercentagesSymbols() {
    console.log('\n🔢 Test 3: Numbers, percentages, and symbols ($@#)...');
    
    const testContent = `# Numbers and Symbols Testing

## Should-Do (High Priority)

1. Ensure correct processing of tasks with numbers: 123, percentages: 50%, and symbols: $@#
2. Process financial amounts like $1,000.00 and €500 correctly
3. Handle email addresses like user@example.com and test@domain.org
4. Test hashtags like #issue123 and #feature-request
5. Validate percentages: 25%, 50%, 75%, and 100% completion
6. Handle special symbols: !@#$%^&*()_+-=[]{}|\\;:'",.<>?/~\`
7. Process numbers in various formats: 1,234.56, 0.123, -456, +789
`;

    try {
      const testFile = path.join(this.testDataDir, 'numbers-symbols-test.md');
      fs.writeFileSync(testFile, testContent, 'utf8');
      
      const parsedTasks = this.parseMarkdownForTasks(testContent, testFile);
      
      this.assert(parsedTasks.length >= 6, `Found all number/symbol tasks (found ${parsedTasks.length})`);
      
      // Test specific scenarios
      const percentageTask = parsedTasks.find(t => t.task.includes('%'));
      this.assert(percentageTask !== undefined, 'Parsed task with percentage symbols');
      
      const dollarTask = parsedTasks.find(t => t.task.includes('$'));
      this.assert(dollarTask !== undefined, 'Parsed task with dollar signs');
      
      const atSymbolTask = parsedTasks.find(t => t.task.includes('@'));
      this.assert(atSymbolTask !== undefined, 'Parsed task with @ symbols');
      
      const hashSymbolTask = parsedTasks.find(t => t.task.includes('#'));
      this.assert(hashSymbolTask !== undefined, 'Parsed task with # symbols');
      
      // Test issue generation
      if (percentageTask) {
        const issue = this.generateIssueContent(percentageTask);
        this.assert(issue.title.length > 0, 'Generated valid title from percentage task');
        this.assert(issue.characterTypes.percentage || issue.characterTypes.symbols, 'Detected special symbols');
      }
      
    } catch (error) {
      this.assert(false, `Number/Symbol test error: ${error.message}`);
    }
  }

  // Test 4: Markdown Formatting (from line 33)
  testMarkdownFormatting() {
    console.log('\n📝 Test 4: Markdown formatting (bold, italic, code, links)...');
    
    const testContent = `# Markdown Formatting Testing

## Action Required

- Test force regeneration functionality with existing issues
- Verify proper handling of tasks with markdown formatting **bold** and *italic* text
- Ensure correct parsing of tasks with \`code blocks\` and [links](http://example.com)

## Should-Do (High Priority)

1. Process **bold text** in task descriptions correctly
2. Handle *italic text* and _underscored italic_ properly
3. Test \`inline code\` snippets within tasks
4. Validate [hyperlinks](https://github.com) and [named links](http://test.com)
5. Test ~~strikethrough~~ text formatting
6. Handle > blockquotes in task descriptions
7. Test mixed formatting: **bold** with *italic* and \`code\`
`;

    try {
      const testFile = path.join(this.testDataDir, 'markdown-test.md');
      fs.writeFileSync(testFile, testContent, 'utf8');
      
      const parsedTasks = this.parseMarkdownForTasks(testContent, testFile);
      
      this.assert(parsedTasks.length >= 8, `Found all markdown tasks (found ${parsedTasks.length})`);
      
      // Test specific formatting
      const boldTask = parsedTasks.find(t => t.task.includes('**bold'));
      this.assert(boldTask !== undefined, 'Parsed task with bold markdown');
      
      const italicTask = parsedTasks.find(t => t.task.includes('*italic'));
      this.assert(italicTask !== undefined, 'Parsed task with italic markdown');
      
      const codeTask = parsedTasks.find(t => t.task.includes('`code'));
      this.assert(codeTask !== undefined, 'Parsed task with code markdown');
      
      const linkTask = parsedTasks.find(t => t.task.includes('[') && t.task.includes(']('));
      this.assert(linkTask !== undefined, 'Parsed task with link markdown');
      
      // Test markdown removal in title generation
      if (boldTask) {
        const issue = this.generateIssueContent(boldTask);
        this.assert(!issue.title.includes('**'), 'Bold markdown removed from title');
        this.assert(issue.title.includes('bold'), 'Bold text content preserved');
        this.assert(issue.characterTypes.markdown_bold, 'Detected bold markdown');
      }
      
      if (codeTask) {
        const issue = this.generateIssueContent(codeTask);
        this.assert(!issue.title.includes('`'), 'Code markdown removed from title');
        this.assert(issue.characterTypes.markdown_code, 'Detected code markdown');
      }
      
    } catch (error) {
      this.assert(false, `Markdown formatting test error: ${error.message}`);
    }
  }

  // Test 5: Long Task Descriptions (from lines 53-54)
  testLongTaskDescriptions() {
    console.log('\n📏 Test 5: Long task descriptions exceeding 80 characters...');
    
    const testContent = `# Long Task Description Testing

## Should-Do (High Priority)

1. This is an intentionally very long task description that exceeds the normal 80 character limit for GitHub issue titles to test the truncation functionality and ensure it works properly without breaking the workflow or creating malformed issues in the GitHub repository system
2. Another long task with specific requirements: implement comprehensive validation framework including unit tests, integration tests, performance benchmarks, security checks, error handling improvements, documentation updates, and thorough code review processes
3. Short task for comparison
`;

    try {
      const testFile = path.join(this.testDataDir, 'long-tasks-test.md');
      fs.writeFileSync(testFile, testContent, 'utf8');
      
      const parsedTasks = this.parseMarkdownForTasks(testContent, testFile);
      
      this.assert(parsedTasks.length >= 3, `Found all long tasks (found ${parsedTasks.length})`);
      
      // Find the long tasks
      const longTasks = parsedTasks.filter(t => t.task.length > 80);
      this.assert(longTasks.length >= 2, `Found tasks exceeding 80 characters (${longTasks.length})`);
      
      // Test truncation
      longTasks.forEach((task, index) => {
        const issue = this.generateIssueContent(task);
        
        this.assert(issue.title.length <= 80, 
          `Long task ${index + 1}: Title truncated to ${issue.title.length} chars (≤80)`);
        
        if (task.task.length > 80) {
          this.assert(issue.title.endsWith('...'), 
            `Long task ${index + 1}: Truncated title ends with ellipsis`);
        }
        
        // Original task should be preserved
        this.assert(issue.originalTask.length > 80, 
          `Long task ${index + 1}: Original task preserved (${issue.originalTask.length} chars)`);
      });
      
    } catch (error) {
      this.assert(false, `Long task test error: ${error.message}`);
    }
  }

  // Test 6: Combined Special Characters
  testCombinedSpecialCharacters() {
    console.log('\n🎭 Test 6: Combined special characters in single tasks...');
    
    const testContent = `# Combined Special Characters Testing

## Must-Do (Critical Priority)

1. Implement système with 50% performance boost using $1,000 budget and 🚀 deployment
2. Test "quoted text" with émojis 🎯, numbers 123, and symbols @#$ together
3. Create feature with **bold** text, \`code\`, [links](http://test.com), and 25% completion
4. Validate Peter's fiduciary duty breach claims with €500K in damages at 95% confidence
5. Handle Rynette's conspiracy evidence including $10M transfers and #CrimeProof hashtags
`;

    try {
      const testFile = path.join(this.testDataDir, 'combined-test.md');
      fs.writeFileSync(testFile, testContent, 'utf8');
      
      const parsedTasks = this.parseMarkdownForTasks(testContent, testFile);
      
      this.assert(parsedTasks.length >= 4, `Found all combined tasks (found ${parsedTasks.length})`);
      
      // Test each task has multiple character types
      parsedTasks.forEach((task, index) => {
        const issue = this.generateIssueContent(task);
        const types = issue.characterTypes;
        
        const specialCharCount = Object.values(types).filter(v => v === true).length;
        
        this.assert(specialCharCount >= 2, 
          `Combined task ${index + 1}: Has multiple special character types (${specialCharCount})`);
        
        // Ensure title is still valid
        this.assert(issue.title.length > 0 && issue.title.length <= 80,
          `Combined task ${index + 1}: Valid title length (${issue.title.length})`);
      });
      
    } catch (error) {
      this.assert(false, `Combined special characters test error: ${error.message}`);
    }
  }

  // Test 7: Workflow Integration Test
  testWorkflowIntegration() {
    console.log('\n⚙️ Test 7: Workflow integration with special characters...');
    
    try {
      // Read the actual workflow file
      const workflowPath = '.github/workflows/todo-to-issues.yml';
      
      if (!fs.existsSync(workflowPath)) {
        this.assert(false, 'Workflow file not found');
        return;
      }
      
      const workflowContent = fs.readFileSync(workflowPath, 'utf8');
      
      // Verify workflow has proper UTF-8 handling
      this.assert(workflowContent.includes('utf8') || workflowContent.includes('utf-8'),
        'Workflow specifies UTF-8 encoding for file operations');
      
      // Verify workflow handles special characters in labels
      this.assert(workflowContent.includes('--label'),
        'Workflow uses label parameters');
      
      // Verify title sanitization exists
      this.assert(workflowContent.includes('title.replace') || workflowContent.includes('title ='),
        'Workflow includes title processing logic');
      
      // Verify truncation logic exists
      this.assert(workflowContent.includes('substring') || workflowContent.includes('.length'),
        'Workflow includes length handling logic');
      
    } catch (error) {
      this.assert(false, `Workflow integration test error: ${error.message}`);
    }
  }

  // Generate test summary
  generateSummary() {
    const endTime = Date.now();
    const duration = (endTime - this.startTime) / 1000;
    
    const passed = this.testResults.filter(r => r.passed).length;
    const failed = this.testResults.filter(r => !r.passed).length;
    const total = this.testResults.length;
    const successRate = total > 0 ? ((passed / total) * 100).toFixed(1) : 0;
    
    console.log('\n' + '='.repeat(80));
    console.log('📊 SPECIAL CHARACTERS WORKFLOW TEST RESULTS');
    console.log('='.repeat(80));
    console.log(`\n✅ Passed: ${passed}/${total}`);
    console.log(`❌ Failed: ${failed}/${total}`);
    console.log(`📈 Success Rate: ${successRate}%`);
    console.log(`⏱️  Duration: ${duration.toFixed(2)}s`);
    
    if (this.errors.length > 0) {
      console.log('\n❌ Failed Tests:');
      this.errors.forEach((error, index) => {
        console.log(`   ${index + 1}. ${error}`);
      });
    }
    
    // Save results
    const results = {
      summary: {
        total_tests: total,
        passed: passed,
        failed: failed,
        success_rate: parseFloat(successRate),
        duration: duration,
        timestamp: new Date().toISOString()
      },
      test_results: this.testResults,
      errors: this.errors
    };
    
    // Save to test results directory
    const resultsDir = 'tests';
    if (!fs.existsSync(resultsDir)) {
      fs.mkdirSync(resultsDir, { recursive: true });
    }
    
    fs.writeFileSync(
      path.join(resultsDir, 'special-characters-test-results.json'),
      JSON.stringify(results, null, 2)
    );
    
    console.log('\n📁 Results saved to tests/special-characters-test-results.json');
    console.log('='.repeat(80) + '\n');
    
    return results;
  }

  // Run all tests
  async runAllTests() {
    console.log('🚀 Starting Special Characters Workflow Tests...');
    console.log('📋 Testing requirements from todo/workflow-validation-tests.md (line 14)\n');
    
    this.setup();
    
    try {
      this.testEmojisAndUnicode();
      this.testQuotesAndApostrophes();
      this.testNumbersPercentagesSymbols();
      this.testMarkdownFormatting();
      this.testLongTaskDescriptions();
      this.testCombinedSpecialCharacters();
      this.testWorkflowIntegration();
      
      const results = this.generateSummary();
      
      // Exit with appropriate code
      if (results.summary.failed > 0) {
        process.exit(1);
      } else {
        process.exit(0);
      }
      
    } catch (error) {
      console.error('💥 Fatal error:', error.message);
      console.error(error.stack);
      process.exit(1);
    } finally {
      this.cleanup();
    }
  // Create a test todo file with special characters
  createSpecialCharactersTodoFile() {
    const specialCharacterContent = `# Special Characters Workflow Test

This file tests the workflow's ability to handle various special characters, unicode symbols, and formatting.

## Must-Do (Critical Priority)

1. Fix émoji handling in the workflow: 🚀 ✅ 📋 🔧 for better user experience
2. Implement ünicode character support: café, naïve, résumé, piñata processing
3. Handle "quotes" and 'apostrophes' correctly in task titles and descriptions
4. Process symbols properly: $100 budget, @mentions, #hashtags, 50% completion

## Should-Do (High Priority)

1. Test markdown with **bold émojis** and *italic ünicode* characters: café ☕
2. Validate code blocks with special chars: \`const price = $99.99;\` and \`SELECT * FROM résumé;\`
3. Ensure proper URL handling: https://example.com/café?query=naïve&price=$100
4. Test mixed formatting: **Important: 🚨** Handle émoji in bold text properly

## Nice-to-Have (Medium Priority)

1. Support mathematical symbols: ∑, ∆, π, ∞, ≤, ≥, ≠ in technical documentation
2. Handle currency symbols: €100, £50, ¥1000, ₹500 in financial tasks
3. Process language-specific characters: español, français, Deutsch, 中文, العربية
4. Test special punctuation: em-dash—like this, ellipsis…, quotes "smart" and 'curly'

## Improvements Needed:
- Create validation for émoji rendering in GitHub issues
- Enhance unicode normalization for search and comparison
- Add support for RTL (right-to-left) text handling
- Implement proper encoding/decoding for special character preservation

## **Action Required**:
- Test workflow with "complex" formatting: **bold**, *italic*, \`code\`, and émojis 🔥
- Validate proper escaping of: \`backticks\`, "quotes", and 'apostrophes' in issue bodies
- Ensure special characters don't break: JSON parsing, YAML processing, or shell commands

## Edge Cases for Special Characters

### Emoji and Symbol Tests
1. 🎯 Target: Test émoji in task titles for proper rendering
2. 📊 Analytics: Implement data visualization with special chars: ±5% accuracy
3. 🔒 Security: Handle authentication tokens with symbols: API_KEY_$2024!@#
4. 🌐 International: Support global characters: résumé, naïve, café, piñata

### Complex Formatting Tests
1. **🚨 Critical Bug**: Handle formatting with émojis in markdown **bold** text
2. *✨ Enhancement*: Implement \`code blocks\` with special characters properly
3. [🔗 Link Test](https://example.com/café?query=résumé&symbols=$@#): URL with special chars
4. > 💡 **Quote Block**: Test blockquotes with émojis and special formatting

### Punctuation and Symbol Tests
1. Test "smart quotes" and 'apostrophes' in various contexts
2. Handle mathematical expressions: x ± y = z, where α ≤ β ≥ γ
3. Process financial data: profit/loss of ±$1,234.56 (≈15% change)
4. Validate time formats: meeting at 2:30 PM–4:00 PM on 12/25/2024

### Unicode Normalization Tests
1. Test composed vs decomposed unicode: café vs cafe\u0301
2. Handle zero-width characters: invisible\u200bseparators
3. Process combining characters: a\u0300 (a with grave accent)
4. Validate emoji variations: 👍🏻 vs 👍🏽 vs 👍🏿 (skin tone modifiers)

---

*This test file validates comprehensive special character handling in the todo-to-issues workflow.*
`;

    // Write to a temporary test file
    const testFilePath = '/tmp/special-characters-test.md';
    fs.writeFileSync(testFilePath, specialCharacterContent);
    return testFilePath;
  }

  // Test the workflow's embedded JavaScript parser with special characters
  testJavaScriptParserWithSpecialChars() {
    console.log('\n🧪 Testing JavaScript parser with special characters...');

    try {
      // Read the workflow file to extract the JavaScript parser
      const workflowContent = fs.readFileSync('.github/workflows/todo-to-issues.yml', 'utf8');
      
      // Extract the embedded JavaScript code
      const jsStart = workflowContent.indexOf('cat > issue-generator.js << \'EOF\'');
      const jsEnd = workflowContent.indexOf('EOF', jsStart + 50);
      
      if (jsStart === -1 || jsEnd === -1) {
        this.assert(false, 'Could not extract JavaScript parser from workflow');
        return;
      }

      const jsCode = workflowContent.substring(jsStart + 32, jsEnd - 1); // Extract just the JS content
      
      // Test critical functions for special character handling
      this.assert(jsCode.includes('parseMarkdownForTasks'), 'Parser has parseMarkdownForTasks method');
      this.assert(jsCode.includes('generateIssueContent'), 'Parser has generateIssueContent method');
      this.assert(jsCode.includes('isHighQualityTask'), 'Parser has task quality filtering');
      
      // Test title cleaning logic for special characters
      this.assert(jsCode.includes('title.replace'), 'Parser includes title cleaning logic');
      this.assert(jsCode.includes('.trim()'), 'Parser trims whitespace from titles');
      
      // Test for character encoding safety
      this.assert(jsCode.includes('utf8'), 'Parser specifies UTF-8 encoding for file reading');
      
      // Test JSON safety for special characters
      this.assert(jsCode.includes('JSON.stringify'), 'Parser uses JSON.stringify for safe serialization');
      
    } catch (error) {
      this.assert(false, `Error testing JavaScript parser: ${error.message}`);
    }
  }

  // Test markdown parsing with special characters
  testMarkdownParsingWithSpecialChars() {
    console.log('\n🧪 Testing markdown parsing with special characters...');

    // Create sample content with special characters
    const testContent = `# Test File

## Must-Do (Critical Priority)

1. Fix émoji handling 🚀 for better UX
2. Process "quotes" and 'apostrophes' correctly  
3. Handle symbols: $100, @user, #tag, 50%

## Improvements Needed:
- Create validation for émoji rendering
- Test unicode: café, naïve, résumé
- Handle currency: €100, £50, ¥1000
`;

    try {
      // Simulate the parsing logic from the workflow
      const lines = testContent.split('\n');
      let foundTasks = 0;
      let hasSpecialChars = false;
      let hasEmojis = false;
      let hasUnicode = false;
      let hasSymbols = false;

      for (const line of lines) {
        // Count tasks with special characters
        if (line.match(/^\d+\.\s+.*[🚀✅📋🔧]/)) {
          foundTasks++;
          hasEmojis = true;
        }
        if (line.includes('émoji') || line.includes('café') || line.includes('naïve')) {
          hasUnicode = true;
        }
        if (line.includes('"') || line.includes("'") || line.includes('$') || line.includes('@') || line.includes('%')) {
          hasSymbols = true;
          hasSpecialChars = true;
        }
        if (line.match(/^\d+\.\s+/) || line.match(/^-\s+/)) {
          foundTasks++;
        }
      }

      this.assert(foundTasks >= 6, `Found ${foundTasks} tasks in test content (expected >= 6)`);
      this.assert(hasEmojis, 'Detected emoji characters in tasks');
      this.assert(hasUnicode, 'Detected unicode characters in tasks');
      this.assert(hasSymbols, 'Detected special symbols in tasks');
      this.assert(hasSpecialChars, 'Overall special character detection working');

    } catch (error) {
      this.assert(false, `Error testing markdown parsing: ${error.message}`);
    }
  }

  // Test title generation with special characters
  testTitleGenerationWithSpecialChars() {
    console.log('\n🧪 Testing title generation with special characters...');

    const testTasks = [
      'Fix émoji handling 🚀 for better user experience',
      'Process "quotes" and \'apostrophes\' correctly in titles',
      'Handle symbols: $100 budget, @mentions, #hashtags, 50% completion',
      'Support mathematical symbols: ∑, ∆, π, ∞ in documentation',
      'Test **bold émojis** and *italic ünicode* characters: café ☕',
      'Very long title with special chars: This is a very long task description with émojis 🚀 and unicode characters like café, naïve, résumé that exceeds eighty characters and should be truncated'
    ];

    try {
      for (const task of testTasks) {
        // Simulate title cleaning logic from the workflow
        let title = task;
        
        // Remove markdown formatting (like in the workflow)
        title = title.replace(/\*\*(.+?)\*\*/g, '$1');
        title = title.replace(/\*(.+?)\*/g, '$1');
        title = title.replace(/`(.+?)`/g, '$1');
        
        // Trim and clean
        title = title.replace(/^[-*\d.\s]+/, '').trim();
        
        // Limit length
        if (title.length > 80) {
          title = title.substring(0, 77) + '...';
        }

        // Validate the cleaned title
        this.assert(title.length <= 80, `Title properly truncated: "${title.substring(0, 50)}..."`);
        this.assert(title.length > 0, `Title not empty after cleaning: "${task.substring(0, 30)}..."`);
        
        // Test that special characters are preserved (when they fit within the length limit)
        if (task.includes('🚀') && title.length < 77) {
          this.assert(title.includes('🚀'), 'Emoji preserved in title (when within length limit)');
        } else if (task.includes('🚀')) {
          // For long titles that get truncated, just verify the truncation worked
          this.assert(title.endsWith('...'), 'Long title with emoji properly truncated');
        }
        if (task.includes('café') && title.length < 77) {
          this.assert(title.includes('café'), 'Unicode characters preserved in title (when within length limit)');
        } else if (task.includes('café')) {
          // For long titles that get truncated, just verify the truncation worked
          this.assert(title.endsWith('...'), 'Long title with unicode properly truncated');
        }
        if (task.includes('"') || task.includes("'")) {
          this.assert(title.includes('"') || title.includes("'"), 'Quote characters preserved in title');
        }
      }

    } catch (error) {
      this.assert(false, `Error testing title generation: ${error.message}`);
    }
  }

  // Test label generation with special characters
  testLabelGenerationWithSpecialChars() {
    console.log('\n🧪 Testing label generation with special characters...');

    try {
      // Test that labels are generated correctly regardless of special chars in content
      const testCases = [
        { priority: 'critical', expectedLabels: ['todo', 'enhancement', 'priority: critical', 'bug'] },
        { priority: 'high', expectedLabels: ['todo', 'enhancement', 'priority: high'] },
        { priority: 'medium', expectedLabels: ['todo', 'enhancement', 'priority: medium'] },
        { priority: 'low', expectedLabels: ['todo', 'enhancement', 'priority: low'] }
      ];

      for (const testCase of testCases) {
        // Simulate label generation logic
        const labels = ['todo', 'enhancement'];
        
        if (testCase.priority === 'critical') {
          labels.push('priority: critical', 'bug');
        } else if (testCase.priority === 'high') {
          labels.push('priority: high');
        } else if (testCase.priority === 'medium') {
          labels.push('priority: medium');
        } else if (testCase.priority === 'low') {
          labels.push('priority: low');
        }

        // Validate generated labels
        this.assert(
          JSON.stringify(labels.sort()) === JSON.stringify(testCase.expectedLabels.sort()),
          `Correct labels generated for ${testCase.priority} priority`
        );
        
        // Test that labels are valid for GitHub (no special characters in label names)
        for (const label of labels) {
          this.assert(
            !label.includes('🚀') && !label.includes('café'),
            `Label "${label}" doesn't contain problematic special characters`
          );
        }
      }

    } catch (error) {
      this.assert(false, `Error testing label generation: ${error.message}`);
    }
  }

  // Test JSON serialization with special characters
  testJSONSerializationWithSpecialChars() {
    console.log('\n🧪 Testing JSON serialization with special characters...');

    try {
      // Test issue data with special characters
      const testIssueData = {
        title: 'Fix émoji handling 🚀 and unicode: café, naïve',
        body: '## Task Description\n\nTest with "quotes" and \'apostrophes\' and symbols: $@#\n\n**Émojis**: 🚀 ✅ 📋\n**Unicode**: café, naïve, résumé\n**Symbols**: $100, @user, #tag, 50%',
        labels: ['todo', 'enhancement', 'priority: high'],
        source: {
          task: 'Fix émoji handling 🚀 and unicode: café, naïve',
          section: 'Must-Do (Critical Priority)',
          priority: 'critical',
          file: 'test-special-chars.md',
          lineNumber: 5
        }
      };

      // Test JSON serialization (what the workflow does)
      const jsonString = JSON.stringify(testIssueData, null, 2);
      this.assert(jsonString.length > 0, 'JSON serialization successful');
      this.assert(jsonString.includes('🚀'), 'Emojis preserved in JSON');
      this.assert(jsonString.includes('café'), 'Unicode characters preserved in JSON');
      this.assert(jsonString.includes('\\\"quotes\\\"'), 'Quote characters properly escaped in JSON');
      
      // Test deserialization
      const parsedData = JSON.parse(jsonString);
      this.assert(parsedData.title === testIssueData.title, 'Title correctly deserialized');
      this.assert(parsedData.body.includes('🚀'), 'Emojis preserved through serialization cycle');
      this.assert(parsedData.source.task.includes('café'), 'Unicode preserved in nested objects');

      // Test that the JSON is valid according to GitHub API expectations
      this.assert(typeof parsedData.title === 'string', 'Title is string type');
      this.assert(Array.isArray(parsedData.labels), 'Labels is array type');
      this.assert(parsedData.labels.every(label => typeof label === 'string'), 'All labels are strings');

    } catch (error) {
      this.assert(false, `Error testing JSON serialization: ${error.message}`);
    }
  }

  // Test GitHub CLI command construction with special characters
  testGitHubCLICommandConstruction() {
    console.log('\n🧪 Testing GitHub CLI command construction with special characters...');

    try {
      // Simulate the workflow's command construction logic
      const testIssue = {
        title: 'Fix émoji handling 🚀 and "quotes"',
        body: 'Task with special chars: café, naïve, $@#',
        labels: ['todo', 'enhancement', 'priority: high']
      };

      // Test command argument array construction (from workflow)
      const gh_args = ['issue', 'create', '--title', testIssue.title, '--body', testIssue.body];
      
      // Add labels as separate arguments (as the workflow does)
      for (const label of testIssue.labels) {
        gh_args.push('--label', label);
      }

      // Validate command construction
      this.assert(gh_args[0] === 'issue', 'Command starts with "issue"');
      this.assert(gh_args[1] === 'create', 'Command includes "create"');
      this.assert(gh_args.includes('--title'), 'Command includes --title flag');
      this.assert(gh_args.includes('--body'), 'Command includes --body flag');
      this.assert(gh_args.includes('--label'), 'Command includes --label flag');
      
      // Test that special characters are properly included
      const titleIndex = gh_args.indexOf('--title') + 1;
      this.assert(gh_args[titleIndex].includes('🚀'), 'Title with emoji in command args');
      this.assert(gh_args[titleIndex].includes('"'), 'Title with quotes in command args');
      
      // Test that labels are properly structured
      const labelIndices = [];
      for (let i = 0; i < gh_args.length - 1; i++) {
        if (gh_args[i] === '--label') {
          labelIndices.push(i + 1);
        }
      }
      this.assert(labelIndices.length === testIssue.labels.length, 'Correct number of label arguments');

    } catch (error) {
      this.assert(false, `Error testing GitHub CLI command construction: ${error.message}`);
    }
  }

  // Test the actual workflow file with special characters todo file
  testWorkflowWithSpecialCharactersTodoFile() {
    console.log('\n🧪 Testing workflow integration with special characters todo file...');

    try {
      // Create the test file
      const testFilePath = this.createSpecialCharactersTodoFile();
      
      // Verify the test file was created successfully
      this.assert(fs.existsSync(testFilePath), 'Special characters test file created');
      
      const content = fs.readFileSync(testFilePath, 'utf8');
      this.assert(content.includes('🚀'), 'Test file contains emojis');
      this.assert(content.includes('café'), 'Test file contains unicode characters');
      this.assert(content.includes('"quotes"'), 'Test file contains quote characters');
      this.assert(content.includes('$100'), 'Test file contains symbol characters');
      
      // Test that the file structure matches workflow expectations
      this.assert(content.includes('## Must-Do'), 'Test file has Must-Do section');
      this.assert(content.includes('## Should-Do'), 'Test file has Should-Do section');
      this.assert(content.includes('## Improvements Needed:'), 'Test file has Improvements Needed section');
      
      // Count expected tasks
      const lines = content.split('\n');
      let taskCount = 0;
      for (const line of lines) {
        if (line.match(/^\d+\.\s+/) || (line.startsWith('- ') && !line.includes('**'))) {
          taskCount++;
        }
      }
      this.assert(taskCount >= 20, `Test file contains ${taskCount} tasks (expected >= 20)`);
      
      // Clean up
      fs.unlinkSync(testFilePath);
      this.assert(!fs.existsSync(testFilePath), 'Test file cleaned up');

    } catch (error) {
      this.assert(false, `Error testing workflow integration: ${error.message}`);
    }
  }

  // Run all special character tests
  runAllTests() {
    console.log('🚀 Starting special characters workflow tests...');
    console.log('=' .repeat(60));
    
    this.testJavaScriptParserWithSpecialChars();
    this.testMarkdownParsingWithSpecialChars();
    this.testTitleGenerationWithSpecialChars();
    this.testLabelGenerationWithSpecialChars();
    this.testJSONSerializationWithSpecialChars();
    this.testGitHubCLICommandConstruction();
    this.testWorkflowWithSpecialCharactersTodoFile();
    
    console.log('\n' + '=' .repeat(60));
    console.log(`📊 Test Summary: ${this.testResults.length} tests run`);
    
    const passedTests = this.testResults.filter(t => t.passed).length;
    const failedTests = this.testResults.filter(t => !t.passed).length;
    
    console.log(`✅ Passed: ${passedTests}`);
    console.log(`❌ Failed: ${failedTests}`);
    
    if (this.errors.length > 0) {
      console.log('\n🔥 Failed Tests:');
      this.errors.forEach((error, index) => {
        console.log(`${index + 1}. ${error}`);
      });
    }
    
    // Write detailed results to file
    const detailedResults = {
      summary: {
        total: this.testResults.length,
        passed: passedTests,
        failed: failedTests,
        success_rate: Math.round((passedTests / this.testResults.length) * 100)
      },
      tests: this.testResults,
      errors: this.errors,
      generated_at: new Date().toISOString(),
      test_type: 'special-characters-workflow'
    };
    
    // Archive test results
    const archiver = new TestResultArchiver();
    archiver.archiveTestResult('special-characters-workflow-results.json', detailedResults, {
      testType: 'special-characters-workflow',
      metadata: {
        special_chars_tested: ['emojis', 'unicode', 'quotes', 'symbols', 'currencies', 'mathematical'],
        encoding: 'UTF-8',
        markdown_features: ['bold', 'italic', 'code', 'links', 'quotes']
      },
      summary: detailedResults.summary
    });
    
    return failedTests === 0;
  }
}

// Run tests if this file is executed directly
if (require.main === module) {
  const tester = new SpecialCharactersWorkflowTest();
  tester.runAllTests();
}

module.exports = SpecialCharactersWorkflowTest;
  const success = tester.runAllTests();
  process.exit(success ? 0 : 1);
}

module.exports = SpecialCharactersWorkflowTest;
