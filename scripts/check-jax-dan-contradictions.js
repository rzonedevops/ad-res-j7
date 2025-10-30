#!/usr/bin/env node

/**
 * Jacqueline & Daniel Response Contradiction Checker
 * 
 * ⚠️ NOTE (October 30, 2025): The jax-response and jax-dan-response directories have been
 * consolidated. This script now checks for contradictions between:
 * - jax-response/ (Jacqueline's perspective)
 * - jax-response/dan-response-materials/ and jax-response/AD/dan-perspective/ (Daniel's perspective)
 * 
 * The script will redirect references from jax-dan-response to the consolidated locations.
 * 
 * This script checks for contradictions between Jacqueline's and Daniel's responses
 * to ensure consistency in key facts, dates, amounts, system names, and terminology.
 * 
 * Task: Task 138 - Check for contradictions between Jacqueline's and Daniel's responses
 * Feature: Feature 68 - JAX_DAN_RESPONSE_EXPANSION_PLAN.md
 * Paragraph: Para 90 - Comprehensive Consistency Review
 * 
 * Usage:
 *   node scripts/check-jax-dan-contradictions.js
 *   node scripts/check-jax-dan-contradictions.js --verbose
 *   node scripts/check-jax-dan-contradictions.js --output report.json
 */

const fs = require('fs');
const path = require('path');

class ContradictionChecker {
    constructor(options = {}) {
        this.repoRoot = options.repoRoot || '/home/runner/work/ad-res-j7/ad-res-j7';
        this.verbose = options.verbose || false;
        this.jaxDir = path.join(this.repoRoot, 'jax-response');
        // Note: jax-dan-response has been consolidated into jax-response/dan-response-materials
        // and jax-response/AD/dan-perspective - we check both for Daniel's perspective
        this.danDir = path.join(this.repoRoot, 'jax-response', 'dan-response-materials');
        this.danADDir = path.join(this.repoRoot, 'jax-response', 'AD', 'dan-perspective');
        
        this.contradictions = [];
        this.warnings = [];
        this.info = [];
        
        // Key facts to check for consistency
        this.keyFacts = {
            // Financial amounts
            amounts: [
                /R\s*[\d,]+(?:\.\d{2})?/g,  // R amounts like R500,000 or R6,738,007.47
                /\$\s*[\d,]+(?:\.\d{2})?/g,  // Dollar amounts
                /£\s*[\d,]+(?:\.\d{2})?/g,  // Pound amounts
                /€\s*[\d,]+(?:\.\d{2})?/g,  // Euro amounts
            ],
            
            // Dates
            dates: [
                /\d{1,2}\s+(January|February|March|April|May|June|July|August|September|October|November|December)\s+\d{4}/gi,
                /\d{4}-\d{2}-\d{2}/g,  // ISO dates
                /\d{1,2}\/\d{1,2}\/\d{4}/g,  // MM/DD/YYYY or DD/MM/YYYY
            ],
            
            // Company/System names
            entities: [
                /RegimA\s+(?:Worldwide\s+Distribution|Zone|SA|WW)(?:\s+\(Pty\)\s+Ltd)?/gi,
                /Shopify\s+Plus/gi,
                /Sage\s+(?:Accounting|Software)?/gi,
                /AWS|Amazon\s+Web\s+Services/gi,
                /Microsoft\s+365/gi,
                /Adobe\s+Creative\s+Cloud/gi,
            ],
            
            // Legal terms and critical allegations
            allegations: [
                /unauthorized\s+payment/gi,
                /director\s+loan/gi,
                /IT\s+expense/gi,
                /unexplained/gi,
                /GDPR/gi,
                /PCI-DSS/gi,
                /POPIA/gi,
                /Responsible\s+Person/gi,
            ]
        };
    }
    
    /**
     * Find corresponding files between jax-response and jax-dan-response
     */
    findCorrespondingFiles() {
        const correspondingPairs = [];
        const jaxAdDir = path.join(this.jaxDir, 'AD');
        const danAdDir = path.join(this.danDir, 'AD');
        
        // Check priority directories
        for (let priority = 1; priority <= 5; priority++) {
            const priorityName = this.getPriorityDirName(priority);
            const jaxPriorityDir = path.join(jaxAdDir, priorityName);
            const danPriorityDir = path.join(danAdDir, priorityName);
            
            if (!fs.existsSync(jaxPriorityDir) || !fs.existsSync(danPriorityDir)) {
                continue;
            }
            
            const jaxFiles = fs.readdirSync(jaxPriorityDir).filter(f => f.endsWith('.md'));
            const danFiles = fs.readdirSync(danPriorityDir).filter(f => f.endsWith('.md'));
            
            // Try to match PARA files
            for (const jaxFile of jaxFiles) {
                const paraMatch = jaxFile.match(/PARA_(\d+_\d+(?:-\d+_\d+)?)/);
                if (paraMatch) {
                    const paraId = paraMatch[1];
                    
                    // Look for corresponding Daniel file
                    const danFile = danFiles.find(df => 
                        df.includes(paraId) || 
                        df.replace(/_DAN_[A-Z_]+\.md$/, '.md') === jaxFile
                    );
                    
                    if (danFile) {
                        correspondingPairs.push({
                            jaxFile: path.join(jaxPriorityDir, jaxFile),
                            danFile: path.join(danPriorityDir, danFile),
                            paraId: paraId,
                            priority: priority
                        });
                    }
                }
            }
        }
        
        return correspondingPairs;
    }
    
    getPriorityDirName(priority) {
        const names = {
            1: '1-Critical',
            2: '2-High-Priority',
            3: '3-Medium-Priority',
            4: '4-Low-Priority',
            5: '5-Meaningless'
        };
        return names[priority] || `${priority}-Unknown`;
    }
    
    /**
     * Extract specific facts from content
     */
    extractFacts(content, factType) {
        const facts = new Set();
        const patterns = this.keyFacts[factType] || [];
        
        for (const pattern of patterns) {
            const matches = content.match(pattern);
            if (matches) {
                matches.forEach(m => facts.add(m.trim()));
            }
        }
        
        return Array.from(facts);
    }
    
    /**
     * Check for contradictions in specific amounts
     */
    checkAmountConsistency(jaxContent, danContent, paraId) {
        const jaxAmounts = this.extractFacts(jaxContent, 'amounts');
        const danAmounts = this.extractFacts(danContent, 'amounts');
        
        // Check if same amounts appear in both with different contexts
        for (const amount of jaxAmounts) {
            if (danAmounts.includes(amount)) {
                // Same amount appears in both - check if context is consistent
                const jaxContext = this.getContext(jaxContent, amount, 100);
                const danContext = this.getContext(danContent, amount, 100);
                
                this.info.push({
                    type: 'amount_consistency',
                    paraId,
                    amount,
                    status: 'found_in_both',
                    jaxContext: jaxContext.substring(0, 150),
                    danContext: danContext.substring(0, 150)
                });
            }
        }
        
        // Look for conflicting amounts for same items
        this.checkConflictingAmounts(jaxContent, danContent, paraId);
    }
    
    /**
     * Check for conflicting amounts (e.g., different values for same expense)
     */
    checkConflictingAmounts(jaxContent, danContent, paraId) {
        // Common expense categories to check
        const categories = [
            'Shopify',
            'AWS',
            'Sage',
            'Microsoft',
            'Adobe',
            'IT expense',
            'director loan'
        ];
        
        for (const category of categories) {
            const jaxAmountsForCategory = this.extractAmountsForCategory(jaxContent, category);
            const danAmountsForCategory = this.extractAmountsForCategory(danContent, category);
            
            if (jaxAmountsForCategory.length > 0 && danAmountsForCategory.length > 0) {
                // Check if amounts differ
                const jaxSet = new Set(jaxAmountsForCategory);
                const danSet = new Set(danAmountsForCategory);
                
                const onlyInJax = [...jaxSet].filter(a => !danSet.has(a));
                const onlyInDan = [...danSet].filter(a => !jaxSet.has(a));
                
                if (onlyInJax.length > 0 || onlyInDan.length > 0) {
                    this.warnings.push({
                        type: 'amount_difference',
                        paraId,
                        category,
                        jaxAmounts: jaxAmountsForCategory,
                        danAmounts: danAmountsForCategory,
                        message: `Different amounts found for ${category} - verify if ranges vs specific amounts`
                    });
                }
            }
        }
    }
    
    /**
     * Extract amounts mentioned near a category
     */
    extractAmountsForCategory(content, category) {
        const amounts = [];
        const lines = content.split('\n');
        
        for (let i = 0; i < lines.length; i++) {
            const line = lines[i];
            if (line.toLowerCase().includes(category.toLowerCase())) {
                // Check this line and next 3 lines for amounts
                for (let j = i; j < Math.min(i + 4, lines.length); j++) {
                    const amountMatches = lines[j].match(/R\s*[\d,]+(?:\.\d{2})?/g);
                    if (amountMatches) {
                        amounts.push(...amountMatches.map(a => a.trim()));
                    }
                }
            }
        }
        
        return amounts;
    }
    
    /**
     * Check date consistency
     */
    checkDateConsistency(jaxContent, danContent, paraId) {
        const jaxDates = this.extractFacts(jaxContent, 'dates');
        const danDates = this.extractFacts(danContent, 'dates');
        
        // Look for dates that appear in both
        for (const date of jaxDates) {
            if (danDates.includes(date)) {
                this.info.push({
                    type: 'date_consistency',
                    paraId,
                    date,
                    status: 'consistent'
                });
            }
        }
        
        // Check for timeline discrepancies
        this.checkTimelineConsistency(jaxContent, danContent, paraId);
    }
    
    /**
     * Check for timeline discrepancies
     */
    checkTimelineConsistency(jaxContent, danContent, paraId) {
        // Events that should have consistent dates
        const events = [
            'card cancellation',
            'June 2025',
            'July 2023',
            'R500,000',
            'interdict'
        ];
        
        for (const event of events) {
            const jaxMentions = this.findEventMentions(jaxContent, event);
            const danMentions = this.findEventMentions(danContent, event);
            
            if (jaxMentions.length > 0 && danMentions.length > 0) {
                // Extract dates near event mentions
                const jaxEventDates = this.extractDatesNearEvent(jaxContent, event);
                const danEventDates = this.extractDatesNearEvent(danContent, event);
                
                if (jaxEventDates.length > 0 && danEventDates.length > 0) {
                    const inconsistent = jaxEventDates.some(jd => 
                        danEventDates.length > 0 && !danEventDates.includes(jd)
                    );
                    
                    if (inconsistent) {
                        this.warnings.push({
                            type: 'timeline_inconsistency',
                            paraId,
                            event,
                            jaxDates: jaxEventDates,
                            danDates: danEventDates,
                            message: `Timeline dates differ for "${event}"`
                        });
                    }
                }
            }
        }
    }
    
    findEventMentions(content, event) {
        const regex = new RegExp(event, 'gi');
        return content.match(regex) || [];
    }
    
    extractDatesNearEvent(content, event) {
        const dates = [];
        const lines = content.split('\n');
        
        for (let i = 0; i < lines.length; i++) {
            const line = lines[i];
            if (line.toLowerCase().includes(event.toLowerCase())) {
                // Check this line and surrounding 2 lines
                for (let j = Math.max(0, i - 2); j < Math.min(i + 3, lines.length); j++) {
                    for (const pattern of this.keyFacts.dates) {
                        const matches = lines[j].match(pattern);
                        if (matches) {
                            dates.push(...matches);
                        }
                    }
                }
            }
        }
        
        return [...new Set(dates)];
    }
    
    /**
     * Check entity name consistency
     */
    checkEntityConsistency(jaxContent, danContent, paraId) {
        const jaxEntities = this.extractFacts(jaxContent, 'entities');
        const danEntities = this.extractFacts(danContent, 'entities');
        
        // Check for variations in entity names
        const variations = this.findNameVariations(jaxEntities, danEntities);
        
        if (variations.length > 0) {
            this.warnings.push({
                type: 'entity_name_variations',
                paraId,
                variations,
                message: 'Entity names have minor variations - verify consistency'
            });
        }
    }
    
    findNameVariations(jaxEntities, danEntities) {
        const variations = [];
        const baseNames = ['RegimA', 'Shopify', 'Sage', 'AWS', 'Microsoft', 'Adobe'];
        
        for (const base of baseNames) {
            const jaxVariations = jaxEntities.filter(e => e.includes(base));
            const danVariations = danEntities.filter(e => e.includes(base));
            
            if (jaxVariations.length > 0 && danVariations.length > 0) {
                const allVariations = [...new Set([...jaxVariations, ...danVariations])];
                if (allVariations.length > 1) {
                    variations.push({
                        base,
                        jaxForms: jaxVariations,
                        danForms: danVariations,
                        allForms: allVariations
                    });
                }
            }
        }
        
        return variations;
    }
    
    /**
     * Check for direct contradictions in statements
     */
    checkStatementContradictions(jaxContent, danContent, paraId) {
        // Key phrases that might indicate contradictions
        const affirmativePatterns = [
            /Peter\s+(?:did|has|was|created|caused)/gi,
            /(?:yes|confirmed|verified|established)/gi,
            /(?:is|are|was|were)\s+(?:true|correct|accurate)/gi
        ];
        
        const negativePatterns = [
            /Peter\s+(?:did\s+not|has\s+not|was\s+not|never)/gi,
            /(?:no|denied|refuted|false)/gi,
            /(?:is|are|was|were)\s+(?:not|never)/gi
        ];
        
        // Check for statements where one affirms and other denies same fact
        // This is a simple check - more sophisticated NLP would be needed for complete analysis
        const jaxStatements = this.extractStatements(jaxContent);
        const danStatements = this.extractStatements(danContent);
        
        // For now, just flag if one uses very different language about Peter's actions
        const jaxPeterActions = this.extractActionsBy(jaxContent, 'Peter');
        const danPeterActions = this.extractActionsBy(danContent, 'Peter');
        
        if (jaxPeterActions.length > 0 && danPeterActions.length > 0) {
            this.info.push({
                type: 'peter_actions_mentioned',
                paraId,
                jaxActions: jaxPeterActions.slice(0, 5),
                danActions: danPeterActions.slice(0, 5),
                message: 'Both mention Peter\'s actions - verify consistency'
            });
        }
    }
    
    extractStatements(content) {
        // Extract sentences (simplified)
        return content.split(/[.!?]\s+/).filter(s => s.trim().length > 20);
    }
    
    extractActionsBy(content, subject) {
        const actions = [];
        const lines = content.split('\n');
        
        for (const line of lines) {
            if (line.includes(subject)) {
                // Extract verbs near subject
                const matches = line.match(new RegExp(`${subject}\\s+(\\w+(?:ed|ing|s)?(?:\\s+\\w+){0,5})`, 'gi'));
                if (matches) {
                    actions.push(...matches.map(m => m.trim()));
                }
            }
        }
        
        return [...new Set(actions)];
    }
    
    /**
     * Get context around a matched string
     */
    getContext(content, match, chars = 200) {
        const index = content.indexOf(match);
        if (index === -1) return '';
        
        const start = Math.max(0, index - chars / 2);
        const end = Math.min(content.length, index + match.length + chars / 2);
        
        return content.substring(start, end);
    }
    
    /**
     * Check a pair of corresponding files
     */
    checkFilePair(pair) {
        if (this.verbose) {
            console.log(`\nChecking ${pair.paraId}...`);
            console.log(`  Jax: ${path.basename(pair.jaxFile)}`);
            console.log(`  Dan: ${path.basename(pair.danFile)}`);
        }
        
        const jaxContent = fs.readFileSync(pair.jaxFile, 'utf8');
        const danContent = fs.readFileSync(pair.danFile, 'utf8');
        
        // Run all checks
        this.checkAmountConsistency(jaxContent, danContent, pair.paraId);
        this.checkDateConsistency(jaxContent, danContent, pair.paraId);
        this.checkEntityConsistency(jaxContent, danContent, pair.paraId);
        this.checkStatementContradictions(jaxContent, danContent, pair.paraId);
    }
    
    /**
     * Run all checks
     */
    run() {
        console.log('=== Jacqueline & Daniel Response Contradiction Checker ===\n');
        
        // Find all corresponding file pairs
        const pairs = this.findCorrespondingFiles();
        console.log(`Found ${pairs.length} corresponding file pairs to check\n`);
        
        if (pairs.length === 0) {
            console.log('No corresponding files found to compare.');
            return {
                success: true,
                contradictions: [],
                warnings: [],
                info: []
            };
        }
        
        // Check each pair
        for (const pair of pairs) {
            this.checkFilePair(pair);
        }
        
        // Report results
        this.reportResults();
        
        return {
            success: this.contradictions.length === 0,
            contradictions: this.contradictions,
            warnings: this.warnings,
            info: this.info
        };
    }
    
    /**
     * Report results
     */
    reportResults() {
        console.log('\n=== RESULTS ===\n');
        
        console.log(`Contradictions: ${this.contradictions.length}`);
        console.log(`Warnings: ${this.warnings.length}`);
        console.log(`Info: ${this.info.length}`);
        
        if (this.contradictions.length > 0) {
            console.log('\n🔴 CONTRADICTIONS FOUND:');
            this.contradictions.forEach((c, i) => {
                console.log(`\n${i + 1}. ${c.type} in ${c.paraId}`);
                console.log(`   ${c.message}`);
                if (this.verbose && c.details) {
                    console.log(`   Details: ${JSON.stringify(c.details, null, 2)}`);
                }
            });
        } else {
            console.log('\n✅ No direct contradictions found');
        }
        
        if (this.warnings.length > 0) {
            console.log('\n⚠️  WARNINGS (verify these):');
            this.warnings.slice(0, 10).forEach((w, i) => {
                console.log(`\n${i + 1}. ${w.type} in ${w.paraId}`);
                console.log(`   ${w.message}`);
            });
            
            if (this.warnings.length > 10) {
                console.log(`\n   ... and ${this.warnings.length - 10} more warnings`);
            }
        }
        
        if (this.verbose && this.info.length > 0) {
            console.log('\n📋 INFO:');
            this.info.slice(0, 5).forEach((i, idx) => {
                console.log(`\n${idx + 1}. ${i.type} in ${i.paraId}`);
                console.log(`   ${i.message || i.status}`);
            });
            
            if (this.info.length > 5) {
                console.log(`\n   ... and ${this.info.length - 5} more info items`);
            }
        }
    }
    
    /**
     * Save results to file
     */
    saveResults(outputPath) {
        const results = {
            timestamp: new Date().toISOString(),
            summary: {
                contradictions: this.contradictions.length,
                warnings: this.warnings.length,
                info: this.info.length
            },
            contradictions: this.contradictions,
            warnings: this.warnings,
            info: this.info
        };
        
        fs.writeFileSync(outputPath, JSON.stringify(results, null, 2));
        console.log(`\nResults saved to: ${outputPath}`);
    }
}

// CLI execution
if (require.main === module) {
    const args = process.argv.slice(2);
    const verbose = args.includes('--verbose') || args.includes('-v');
    const outputIndex = args.indexOf('--output');
    const outputPath = outputIndex !== -1 ? args[outputIndex + 1] : null;
    
    const checker = new ContradictionChecker({ verbose });
    const results = checker.run();
    
    if (outputPath) {
        checker.saveResults(outputPath);
    }
    
    process.exit(results.success ? 0 : 1);
}

module.exports = ContradictionChecker;
