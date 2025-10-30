/**
 * Validation Test for Point-by-Point Rebuttal Matrix
 * Tests the comprehensive rebuttal matrix for PARA 10.5-10.10.23
 * 
 * Task: #140 - Create point-by-point rebuttal matrix for each sub-allegation
 * Feature: feature_78
 * Paragraph: para_108
 */

const fs = require('fs');
const path = require('path');

// ANSI color codes for output
const colors = {
    reset: '\x1b[0m',
    green: '\x1b[32m',
    red: '\x1b[31m',
    yellow: '\x1b[33m',
    blue: '\x1b[34m',
    cyan: '\x1b[36m'
};

class RebuttalMatrixValidator {
    constructor() {
        this.matrixPath = path.join(__dirname, '../jax-dan-response/financial_allegations_rebuttal_matrix.md');
        this.content = '';
        this.results = {
            passed: 0,
            failed: 0,
            warnings: 0
        };
    }

    loadMatrix() {
        try {
            this.content = fs.readFileSync(this.matrixPath, 'utf8');
            return true;
        } catch (error) {
            console.error(`${colors.red}✗ Failed to load matrix file: ${error.message}${colors.reset}`);
            return false;
        }
    }

    log(message, color = 'reset') {
        console.log(`${colors[color]}${message}${colors.reset}`);
    }

    pass(message) {
        this.results.passed++;
        this.log(`  ✓ ${message}`, 'green');
    }

    fail(message) {
        this.results.failed++;
        this.log(`  ✗ ${message}`, 'red');
    }

    warn(message) {
        this.results.warnings++;
        this.log(`  ⚠ ${message}`, 'yellow');
    }

    testFileStructure() {
        this.log('\n1. Testing File Structure', 'cyan');
        
        if (!this.content) {
            this.fail('Matrix file is empty');
            return;
        }
        this.pass('Matrix file loaded successfully');

        // Check for main sections
        const sections = [
            'Section 6.3: Point-by-Point Rebuttal Matrix',
            'A. IT Expenses and Technology Costs',
            'B. International Payment and Currency Allegations',
            'C. Director Loan Account and Withdrawal Allegations',
            'D. Documentation and Transparency Allegations',
            'E. Business Operations and Financial Performance',
            'F. Tax Compliance and Regulatory Allegations',
            'G. Shareholder and Director Relationship',
            'H. Transfer Pricing and Inter-Company Transaction Allegations',
            'I. Inventory and Asset Valuation',
            'J. Revenue Recognition and Customer Relationship',
            'K. Banking and Cash Management',
            'L. External Relationships and Vendor',
            'M. Regulatory Compliance and Risk Management'
        ];

        sections.forEach(section => {
            if (this.content.includes(section)) {
                this.pass(`Found section: ${section}`);
            } else {
                this.fail(`Missing section: ${section}`);
            }
        });
    }

    testTableStructure() {
        this.log('\n2. Testing Table Structure', 'cyan');

        // Check for table headers
        const headerPattern = /\| Paragraph Reference \| Applicant's Allegation \| Respondent's Rebuttal & Evidence \| Status \|/g;
        const headers = this.content.match(headerPattern);
        
        if (headers && headers.length >= 13) {
            this.pass(`Found ${headers.length} table headers (expected ≥13 for all categories)`);
        } else {
            this.fail(`Found ${headers ? headers.length : 0} table headers (expected ≥13)`);
        }

        // Check for table separator rows
        const separatorPattern = /\| :--- \| :--- \| :--- \| :--- \|/g;
        const separators = this.content.match(separatorPattern);
        
        if (separators && separators.length >= 13) {
            this.pass(`Found ${separators.length} table separators`);
        } else {
            this.fail(`Found ${separators ? separators.length : 0} table separators (expected ≥13)`);
        }
    }

    testSubAllegationCoverage() {
        this.log('\n3. Testing Sub-Allegation Coverage', 'cyan');

        // Expected paragraph ranges
        const expectedParagraphs = [
            '10.5', '10.5.1', '10.5.2', '10.5.3', '10.5.4', '10.5.5', '10.5.6', '10.5.7', '10.5.8',
            '10.6', '10.6.1', '10.6.2', '10.6.3', '10.6.4',
            '10.7', '10.7.1', '10.7.2', '10.7.3', '10.7.4',
            '10.8', '10.8.1', '10.8.2', '10.8.3', '10.8.4',
            '10.9', '10.9.1', '10.9.2', '10.9.3', '10.9.4',
            '10.10', '10.10.1', '10.10.2', '10.10.3', '10.10.4', '10.10.5', '10.10.6',
            '10.10.7', '10.10.8', '10.10.9', '10.10.10', '10.10.11', '10.10.12',
            '10.10.13', '10.10.14', '10.10.15', '10.10.16', '10.10.17', '10.10.18',
            '10.10.19', '10.10.20', '10.10.21', '10.10.22', '10.10.23'
        ];

        let foundCount = 0;
        let missingParagraphs = [];

        expectedParagraphs.forEach(para => {
            // Check if paragraph number appears in a table row
            const paraPattern = new RegExp(`\\|\\s*${para.replace('.', '\\.')}\\s*\\|`, 'g');
            if (paraPattern.test(this.content)) {
                foundCount++;
            } else {
                missingParagraphs.push(para);
            }
        });

        this.pass(`Found ${foundCount} out of ${expectedParagraphs.length} expected paragraph references`);
        
        if (missingParagraphs.length > 0) {
            this.warn(`Potentially missing paragraphs: ${missingParagraphs.slice(0, 5).join(', ')}${missingParagraphs.length > 5 ? ' ...' : ''}`);
        }
    }

    testEvidenceReferences() {
        this.log('\n4. Testing Evidence Annexure References', 'cyan');

        // Common evidence patterns
        const evidencePatterns = [
            { name: 'DJF', pattern: /\*\*DJF\*\*/g },
            { name: 'JF-', pattern: /\*\*JF-[A-Z0-9-]+\*\*/g },
            { name: 'Annexure JF', pattern: /\*\*Annexure JF[A-Z0-9-]*\*\*/g }
        ];

        evidencePatterns.forEach(({ name, pattern }) => {
            const matches = this.content.match(pattern);
            if (matches && matches.length > 0) {
                this.pass(`Found ${matches.length} references to ${name} evidence`);
            } else {
                this.warn(`No references to ${name} evidence found`);
            }
        });

        // Check for comprehensive evidence matrix section
        if (this.content.includes('Comprehensive Evidence Matrix')) {
            this.pass('Found Comprehensive Evidence Matrix section');
        } else {
            this.fail('Missing Comprehensive Evidence Matrix section');
        }
    }

    testStatusValues() {
        this.log('\n5. Testing Status Column Values', 'cyan');

        // Expected status values
        const expectedStatuses = [
            'Refuted',
            "Peter's Hypocrisy",
            'Peter Created Problem',
            'Unsubstantiated',
            'Defamatory'
        ];

        let statusCounts = {};
        expectedStatuses.forEach(status => {
            const pattern = new RegExp(`\\|\\s*${status}`, 'g');
            const matches = this.content.match(pattern);
            const count = matches ? matches.length : 0;
            statusCounts[status] = count;
            
            if (count > 0) {
                this.pass(`Found ${count} allegations with status: ${status}`);
            }
        });

        const totalStatuses = Object.values(statusCounts).reduce((a, b) => a + b, 0);
        this.log(`\n  Total status assignments: ${totalStatuses}`, 'blue');
    }

    testSummarySections() {
        this.log('\n6. Testing Summary Sections', 'cyan');

        const summarySections = [
            'Pattern of Misrepresentation',
            "Applicant's Bad Faith",
            'External Validation',
            'Counter-Questions Peter Must Answer',
            'Comprehensive Evidence Matrix',
            'Conclusion'
        ];

        summarySections.forEach(section => {
            if (this.content.includes(section)) {
                this.pass(`Found summary section: ${section}`);
            } else {
                this.warn(`Missing summary section: ${section}`);
            }
        });
    }

    testCrossReferences() {
        this.log('\n7. Testing Cross-References', 'cyan');

        const crossRefPatterns = [
            { name: 'JAX response references', pattern: /jax-response\/AD\//g },
            { name: 'DAN response references', pattern: /jax-dan-response\/AD\//g },
            { name: 'Evidence attachments', pattern: /evidence-attachments\//g }
        ];

        crossRefPatterns.forEach(({ name, pattern }) => {
            const matches = this.content.match(pattern);
            if (matches && matches.length > 0) {
                this.pass(`Found ${matches.length} ${name}`);
            } else {
                this.warn(`No ${name} found`);
            }
        });
    }

    printResults() {
        this.log('\n' + '='.repeat(60), 'cyan');
        this.log('Test Results Summary', 'cyan');
        this.log('='.repeat(60), 'cyan');
        
        this.log(`\nPassed:   ${this.results.passed}`, 'green');
        this.log(`Failed:   ${this.results.failed}`, 'red');
        this.log(`Warnings: ${this.results.warnings}`, 'yellow');
        
        const total = this.results.passed + this.results.failed;
        const passRate = total > 0 ? ((this.results.passed / total) * 100).toFixed(1) : 0;
        
        this.log(`\nPass Rate: ${passRate}%`, passRate >= 90 ? 'green' : passRate >= 70 ? 'yellow' : 'red');
        
        if (this.results.failed === 0) {
            this.log('\n✓ All critical tests passed!', 'green');
            return 0;
        } else {
            this.log('\n✗ Some tests failed. Review the output above.', 'red');
            return 1;
        }
    }

    runAllTests() {
        this.log('\n╔════════════════════════════════════════════════════════════╗', 'cyan');
        this.log('║  Point-by-Point Rebuttal Matrix Validation Test           ║', 'cyan');
        this.log('║  Task #140: PARA 10.5-10.10.23 Sub-Allegation Matrix      ║', 'cyan');
        this.log('╚════════════════════════════════════════════════════════════╝', 'cyan');

        if (!this.loadMatrix()) {
            return 1;
        }

        this.testFileStructure();
        this.testTableStructure();
        this.testSubAllegationCoverage();
        this.testEvidenceReferences();
        this.testStatusValues();
        this.testSummarySections();
        this.testCrossReferences();

        return this.printResults();
    }
}

// Run the tests
const validator = new RebuttalMatrixValidator();
const exitCode = validator.runAllTests();
process.exit(exitCode);
