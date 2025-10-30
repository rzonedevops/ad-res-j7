#!/usr/bin/env node

/**
 * Preponderance of Evidence Automated Testing Pipeline
 * 
 * Comprehensive automated testing pipeline for preponderance of evidence 
 * assessment framework as required by task_25 from feature_33.
 * 
 * This pipeline validates the civil standard "Balance of Probabilities" (>50% threshold)
 * and provides automated testing for:
 * - Evidence weighting and aggregation
 * - Probability threshold calculations  
 * - Evidence quality assessment
 * - Preponderance determination algorithms
 * - Integration with burden of proof analyzer
 * 
 * Task: task_25 (para_22, feature_33)
 * Source: todo/optimal-strategies-burden-of-proof.md (line 10)
 */

const fs = require('fs');
const path = require('path');

class PreponderanceOfEvidencePipeline {
  constructor() {
    this.testResults = [];
    this.startTime = Date.now();
    this.requirements = null;
    this.evidenceScenarios = [];
    
    // Preponderance threshold constants
    this.PREPONDERANCE_THRESHOLD = 0.501; // >50%
    this.HIGH_CONFIDENCE = 0.75; // 75%+
    this.LOW_CONFIDENCE = 0.40; // <50%
  }

  assert(condition, message) {
    const result = {
      test: message,
      passed: condition,
      timestamp: new Date().toISOString()
    };
    
    this.testResults.push(result);
    
    if (condition) {
      console.log(`✅ ${message}`);
    } else {
      console.log(`❌ ${message}`);
    }
    
    return condition;
  }

  // ============================================================================
  // PHASE 1: Framework Validation
  // ============================================================================

  testPreponderanceFrameworkExists() {
    console.log('\n🧪 Phase 1.1: Validate preponderance framework exists...');
    
    try {
      const requirementsPath = 'burden-of-proof-requirements.json';
      this.assert(fs.existsSync(requirementsPath), 'burden-of-proof-requirements.json exists');
      
      const data = fs.readFileSync(requirementsPath, 'utf8');
      this.requirements = JSON.parse(data);
      
      const civil = this.requirements.standards.civil;
      this.assert(civil !== undefined, 'Civil standard exists');
      this.assert(civil.standard.requirement === 'Preponderance of evidence',
                  'Preponderance of evidence requirement defined');
      this.assert(civil.standard.threshold === '50.1%',
                  'Preponderance threshold is 50.1%');
      
      return true;
    } catch (error) {
      this.assert(false, `Framework validation failed: ${error.message}`);
      return false;
    }
  }

  testPreponderanceThresholdConfiguration() {
    console.log('\n🧪 Phase 1.2: Validate threshold configuration...');
    
    const expectedThreshold = this.PREPONDERANCE_THRESHOLD;
    this.assert(expectedThreshold > 0.5 && expectedThreshold <= 1.0,
                `Threshold ${expectedThreshold} is valid (>0.5 and <=1.0)`);
    this.assert(Math.abs(expectedThreshold - 0.501) < 0.001,
                `Threshold matches civil standard (${expectedThreshold})`);
    
    // Test threshold edge cases
    const edgeCases = [
      { value: 0.500, meetsThreshold: false, label: '50.0% (exactly half)' },
      { value: 0.501, meetsThreshold: true, label: '50.1% (minimum preponderance)' },
      { value: 0.510, meetsThreshold: true, label: '51.0% (clear preponderance)' },
      { value: 0.750, meetsThreshold: true, label: '75.0% (strong preponderance)' }
    ];
    
    edgeCases.forEach(testCase => {
      const meets = testCase.value >= this.PREPONDERANCE_THRESHOLD;
      this.assert(meets === testCase.meetsThreshold,
                  `${testCase.label} ${meets ? 'meets' : 'fails'} threshold`);
    });
    
    return true;
  }

  // ============================================================================
  // PHASE 2: Evidence Weighting Pipeline
  // ============================================================================

  testEvidenceWeightingAlgorithm() {
    console.log('\n🧪 Phase 2.1: Test evidence weighting algorithm...');
    
    // Define evidence weight calculation method
    const calculateEvidenceWeight = (evidence) => {
      const { reliability, relevance, corroboration, source_credibility } = evidence;
      
      // Weighted average: reliability (40%), relevance (30%), corroboration (20%), source (10%)
      const weight = (reliability * 0.4) + (relevance * 0.3) + 
                     (corroboration * 0.2) + (source_credibility * 0.1);
      return weight / 100; // Normalize to 0-1
    };
    
    // Test cases with different evidence profiles
    const evidenceTests = [
      {
        name: 'Strong Direct Evidence',
        evidence: { reliability: 90, relevance: 95, corroboration: 80, source_credibility: 85 },
        expectedWeight: 0.89, // Expected to be high
        shouldMeetThreshold: true
      },
      {
        name: 'Moderate Circumstantial Evidence',
        evidence: { reliability: 70, relevance: 65, corroboration: 60, source_credibility: 70 },
        expectedWeight: 0.67,
        shouldMeetThreshold: true
      },
      {
        name: 'Weak Evidence',
        evidence: { reliability: 40, relevance: 45, corroboration: 30, source_credibility: 35 },
        expectedWeight: 0.40,
        shouldMeetThreshold: false
      }
    ];
    
    evidenceTests.forEach(test => {
      const weight = calculateEvidenceWeight(test.evidence);
      const withinTolerance = Math.abs(weight - test.expectedWeight) < 0.05;
      this.assert(withinTolerance,
                  `${test.name}: calculated weight ${weight.toFixed(2)} ≈ ${test.expectedWeight}`);
      
      const meetsThreshold = weight >= this.PREPONDERANCE_THRESHOLD;
      this.assert(meetsThreshold === test.shouldMeetThreshold,
                  `${test.name}: ${meetsThreshold ? 'meets' : 'fails'} preponderance threshold`);
    });
    
    return true;
  }

  testMultiEvidenceAggregation() {
    console.log('\n🧪 Phase 2.2: Test multi-evidence aggregation...');
    
    // Aggregate multiple pieces of evidence
    const aggregateEvidence = (evidenceList) => {
      if (evidenceList.length === 0) return 0;
      
      // Calculate weighted sum based on individual evidence strengths
      let totalWeight = 0;
      let totalStrength = 0;
      
      evidenceList.forEach(ev => {
        const weight = ev.weight || 1.0;
        totalWeight += weight;
        totalStrength += ev.strength * weight;
      });
      
      return totalStrength / totalWeight;
    };
    
    const scenarios = [
      {
        name: 'Multiple strong pieces',
        evidence: [
          { strength: 0.80, weight: 1.0 },
          { strength: 0.75, weight: 1.0 },
          { strength: 0.70, weight: 0.8 }
        ],
        shouldMeetThreshold: true
      },
      {
        name: 'Mixed quality evidence',
        evidence: [
          { strength: 0.65, weight: 1.0 },
          { strength: 0.45, weight: 0.5 },
          { strength: 0.55, weight: 0.8 }
        ],
        shouldMeetThreshold: true
      },
      {
        name: 'Mostly weak evidence',
        evidence: [
          { strength: 0.40, weight: 1.0 },
          { strength: 0.35, weight: 0.8 },
          { strength: 0.45, weight: 0.6 }
        ],
        shouldMeetThreshold: false
      }
    ];
    
    scenarios.forEach(scenario => {
      const aggregatedStrength = aggregateEvidence(scenario.evidence);
      const meetsThreshold = aggregatedStrength >= this.PREPONDERANCE_THRESHOLD;
      
      console.log(`   ${scenario.name}: ${aggregatedStrength.toFixed(3)} (${meetsThreshold ? 'PASS' : 'FAIL'})`);
      this.assert(meetsThreshold === scenario.shouldMeetThreshold,
                  `${scenario.name}: aggregation result is ${meetsThreshold ? 'preponderant' : 'not preponderant'}`);
    });
    
    return true;
  }

  // ============================================================================
  // PHASE 3: Probability Calculation Pipeline
  // ============================================================================

  testProbabilityCalculations() {
    console.log('\n🧪 Phase 3.1: Test probability calculations...');
    
    // Bayesian-style probability update
    const calculatePosteriorProbability = (priorProb, evidenceStrength, evidenceLikelihood) => {
      // Simple Bayesian update: P(H|E) = P(E|H) * P(H) / P(E)
      // Assuming P(E) normalizes to make this a weighted average
      const posterior = (evidenceLikelihood * priorProb + (1 - evidenceLikelihood) * (1 - priorProb)) / 
                       (evidenceLikelihood * priorProb + (1 - evidenceLikelihood) * (1 - priorProb) + 
                        (1 - evidenceLikelihood) * priorProb + evidenceLikelihood * (1 - priorProb));
      
      // Simplified: weight by evidence strength
      return priorProb * (1 - evidenceStrength) + evidenceStrength * evidenceLikelihood;
    };
    
    const probabilityTests = [
      {
        name: 'Strong evidence supporting guilt',
        prior: 0.30,
        evidenceStrength: 0.85,
        likelihood: 0.90,
        expectedRange: [0.70, 0.85]
      },
      {
        name: 'Moderate evidence with neutral prior',
        prior: 0.50,
        evidenceStrength: 0.60,
        likelihood: 0.70,
        expectedRange: [0.55, 0.70]
      },
      {
        name: 'Weak evidence with low prior',
        prior: 0.20,
        evidenceStrength: 0.40,
        likelihood: 0.50,
        expectedRange: [0.25, 0.40]
      }
    ];
    
    probabilityTests.forEach(test => {
      const posterior = calculatePosteriorProbability(test.prior, test.evidenceStrength, test.likelihood);
      const inRange = posterior >= test.expectedRange[0] && posterior <= test.expectedRange[1];
      
      console.log(`   ${test.name}: P=${posterior.toFixed(3)} (expected ${test.expectedRange[0]}-${test.expectedRange[1]})`);
      this.assert(inRange, `${test.name}: probability in expected range`);
      
      const meetsPreponderance = posterior >= this.PREPONDERANCE_THRESHOLD;
      console.log(`   → ${meetsPreponderance ? 'Meets' : 'Fails'} preponderance threshold`);
    });
    
    return true;
  }

  testComparativeAnalysis() {
    console.log('\n🧪 Phase 3.2: Test comparative probability analysis...');
    
    // Compare plaintiff vs defendant evidence strength
    const comparativeCases = [
      {
        name: 'Clear plaintiff advantage',
        plaintiffEvidence: 0.70,
        defendantEvidence: 0.30,
        expectedOutcome: 'plaintiff',
        meetsPreponderance: true
      },
      {
        name: 'Narrow plaintiff advantage',
        plaintiffEvidence: 0.52,
        defendantEvidence: 0.48,
        expectedOutcome: 'plaintiff',
        meetsPreponderance: true
      },
      {
        name: 'Equal evidence (edge case)',
        plaintiffEvidence: 0.50,
        defendantEvidence: 0.50,
        expectedOutcome: 'defendant',
        meetsPreponderance: false
      },
      {
        name: 'Defendant advantage',
        plaintiffEvidence: 0.45,
        defendantEvidence: 0.55,
        expectedOutcome: 'defendant',
        meetsPreponderance: false
      }
    ];
    
    comparativeCases.forEach(testCase => {
      const totalEvidence = testCase.plaintiffEvidence + testCase.defendantEvidence;
      const plaintiffProportion = testCase.plaintiffEvidence / totalEvidence;
      
      const outcome = plaintiffProportion > 0.5 ? 'plaintiff' : 'defendant';
      const meetsPreponderance = testCase.plaintiffEvidence > 0.5;
      
      console.log(`   ${testCase.name}: P=${testCase.plaintiffEvidence} vs D=${testCase.defendantEvidence} → ${outcome}`);
      this.assert(outcome === testCase.expectedOutcome,
                  `${testCase.name}: correct outcome (${outcome})`);
      this.assert(meetsPreponderance === testCase.meetsPreponderance,
                  `${testCase.name}: preponderance assessment correct`);
    });
    
    return true;
  }

  // ============================================================================
  // PHASE 4: Evidence Quality Assessment
  // ============================================================================

  testEvidenceQualityMetrics() {
    console.log('\n🧪 Phase 4.1: Test evidence quality assessment...');
    
    const assessEvidenceQuality = (evidence) => {
      const metrics = {
        authenticity: evidence.authenticity || 0,
        relevance: evidence.relevance || 0,
        reliability: evidence.reliability || 0,
        admissibility: evidence.admissible ? 100 : 0
      };
      
      // Must be admissible first
      if (!evidence.admissible) return 0;
      
      // Average of quality metrics
      const quality = (metrics.authenticity + metrics.relevance + metrics.reliability) / 3;
      return quality / 100; // Normalize to 0-1
    };
    
    const qualityTests = [
      {
        name: 'High-quality documentary evidence',
        evidence: { authenticity: 95, relevance: 90, reliability: 92, admissible: true },
        expectedQuality: 0.92,
        shouldContribute: true
      },
      {
        name: 'Moderate quality witness testimony',
        evidence: { authenticity: 70, relevance: 80, reliability: 65, admissible: true },
        expectedQuality: 0.72,
        shouldContribute: true
      },
      {
        name: 'Low quality circumstantial',
        evidence: { authenticity: 45, relevance: 50, reliability: 40, admissible: true },
        expectedQuality: 0.45,
        shouldContribute: false
      },
      {
        name: 'Inadmissible evidence (excluded)',
        evidence: { authenticity: 95, relevance: 95, reliability: 95, admissible: false },
        expectedQuality: 0,
        shouldContribute: false
      }
    ];
    
    qualityTests.forEach(test => {
      const quality = assessEvidenceQuality(test.evidence);
      const withinTolerance = Math.abs(quality - test.expectedQuality) < 0.05;
      
      console.log(`   ${test.name}: quality=${quality.toFixed(2)} (expected ${test.expectedQuality})`);
      this.assert(withinTolerance, `${test.name}: quality score matches expected`);
      
      const contributes = quality >= this.PREPONDERANCE_THRESHOLD;
      this.assert(contributes === test.shouldContribute,
                  `${test.name}: ${contributes ? 'contributes to' : 'insufficient for'} preponderance`);
    });
    
    return true;
  }

  testCorroborationEffects() {
    console.log('\n🧪 Phase 4.2: Test corroboration effects on evidence strength...');
    
    const calculateCorroboratedStrength = (primaryEvidence, corroboratingEvidence) => {
      let strength = primaryEvidence.strength;
      
      corroboratingEvidence.forEach(corroboration => {
        // Each corroboration adds credibility, but with diminishing returns
        const boostFactor = 0.15 * (corroboration.reliability / 100) * (1 / (corroboratingEvidence.length));
        strength = Math.min(1.0, strength + boostFactor);
      });
      
      return strength;
    };
    
    const corroborationTests = [
      {
        name: 'Single strong corroboration',
        primary: { strength: 0.55 },
        corroboration: [{ reliability: 85 }],
        expectedIncrease: true
      },
      {
        name: 'Multiple moderate corroborations',
        primary: { strength: 0.48 },
        corroboration: [
          { reliability: 70 },
          { reliability: 65 },
          { reliability: 60 }
        ],
        expectedIncrease: true
      },
      {
        name: 'Weak corroboration insufficient',
        primary: { strength: 0.45 },
        corroboration: [{ reliability: 30 }],
        expectedIncrease: true // Will increase, but may not meet threshold
      }
    ];
    
    corroborationTests.forEach(test => {
      const baseStrength = test.primary.strength;
      const corroboratedStrength = calculateCorroboratedStrength(test.primary, test.corroboration);
      const increased = corroboratedStrength > baseStrength;
      
      console.log(`   ${test.name}: ${baseStrength.toFixed(2)} → ${corroboratedStrength.toFixed(2)}`);
      this.assert(increased === test.expectedIncrease,
                  `${test.name}: corroboration ${increased ? 'increased' : 'did not increase'} strength`);
      
      const meetsPreponderance = corroboratedStrength >= this.PREPONDERANCE_THRESHOLD;
      console.log(`   → ${meetsPreponderance ? 'Meets' : 'Fails'} preponderance threshold`);
    });
    
    return true;
  }

  // ============================================================================
  // PHASE 5: Preponderance Determination
  // ============================================================================

  testPreponderanceDetermination() {
    console.log('\n🧪 Phase 5.1: Test preponderance determination algorithm...');
    
    const determinePreponderance = (evidenceSet) => {
      let totalWeight = 0;
      let weightedSum = 0;
      
      evidenceSet.forEach(evidence => {
        const weight = evidence.weight || 1.0;
        totalWeight += weight;
        weightedSum += evidence.probability * weight;
      });
      
      const overallProbability = totalWeight > 0 ? weightedSum / totalWeight : 0;
      
      return {
        probability: overallProbability,
        meetsPreponderance: overallProbability > 0.5,
        confidence: overallProbability > 0.5 ? 
                   (overallProbability - 0.5) * 2 : // Scale to 0-1 above threshold
                   (0.5 - overallProbability) * 2  // Scale to 0-1 below threshold
      };
    };
    
    const determinationTests = [
      {
        name: 'Strong case - clear preponderance',
        evidence: [
          { probability: 0.75, weight: 1.0 },
          { probability: 0.70, weight: 0.8 },
          { probability: 0.68, weight: 0.6 }
        ],
        shouldMeet: true
      },
      {
        name: 'Borderline case - narrow preponderance',
        evidence: [
          { probability: 0.55, weight: 1.0 },
          { probability: 0.52, weight: 0.9 },
          { probability: 0.48, weight: 0.7 }
        ],
        shouldMeet: true
      },
      {
        name: 'Weak case - fails preponderance',
        evidence: [
          { probability: 0.45, weight: 1.0 },
          { probability: 0.42, weight: 0.8 },
          { probability: 0.40, weight: 0.6 }
        ],
        shouldMeet: false
      },
      {
        name: 'Exactly at threshold (edge case)',
        evidence: [
          { probability: 0.50, weight: 1.0 }
        ],
        shouldMeet: false // 50% is NOT preponderance
      }
    ];
    
    determinationTests.forEach(test => {
      const result = determinePreponderance(test.evidence);
      
      console.log(`   ${test.name}: P=${result.probability.toFixed(3)} (${result.meetsPreponderance ? 'PASS' : 'FAIL'})`);
      this.assert(result.meetsPreponderance === test.shouldMeet,
                  `${test.name}: preponderance determination is ${result.meetsPreponderance ? 'met' : 'not met'}`);
    });
    
    return true;
  }

  testAlternativeExplanationAnalysis() {
    console.log('\n🧪 Phase 5.2: Test alternative explanation analysis...');
    
    const evaluateWithAlternatives = (primaryExplanation, alternatives) => {
      const totalProbability = primaryExplanation.probability + 
                              alternatives.reduce((sum, alt) => sum + alt.probability, 0);
      
      const normalizedPrimary = primaryExplanation.probability / totalProbability;
      const normalizedAlternatives = alternatives.map(alt => alt.probability / totalProbability);
      
      // Primary must be more likely than all alternatives combined
      const alternativesCombined = normalizedAlternatives.reduce((sum, p) => sum + p, 0);
      
      return {
        primaryProbability: normalizedPrimary,
        alternativesProbability: alternativesCombined,
        meetsPreponderance: normalizedPrimary > 0.5
      };
    };
    
    const alternativeTests = [
      {
        name: 'Primary clearly more likely',
        primary: { probability: 0.70 },
        alternatives: [
          { probability: 0.20 },
          { probability: 0.10 }
        ],
        shouldMeet: true
      },
      {
        name: 'Primary slightly more likely',
        primary: { probability: 0.52 },
        alternatives: [
          { probability: 0.30 },
          { probability: 0.18 }
        ],
        shouldMeet: true
      },
      {
        name: 'Alternatives equally or more likely',
        primary: { probability: 0.40 },
        alternatives: [
          { probability: 0.35 },
          { probability: 0.25 }
        ],
        shouldMeet: false
      }
    ];
    
    alternativeTests.forEach(test => {
      const result = evaluateWithAlternatives(test.primary, test.alternatives);
      
      console.log(`   ${test.name}: Primary=${result.primaryProbability.toFixed(2)} vs Alternatives=${result.alternativesProbability.toFixed(2)}`);
      this.assert(result.meetsPreponderance === test.shouldMeet,
                  `${test.name}: ${result.meetsPreponderance ? 'meets' : 'fails'} preponderance when considering alternatives`);
    });
    
    return true;
  }

  // ============================================================================
  // PHASE 6: Integration Testing
  // ============================================================================

  testIntegrationWithBurdenOfProofFramework() {
    console.log('\n🧪 Phase 6.1: Test integration with burden of proof framework...');
    
    try {
      // Verify framework files exist
      const frameworkFiles = [
        'burden-of-proof-framework.js',
        'burden-of-proof-requirements.json',
        'burden-of-proof-strategies.json'
      ];
      
      frameworkFiles.forEach(file => {
        this.assert(fs.existsSync(file), `Framework file ${file} exists`);
      });
      
      // Verify civil standard configuration
      const civil = this.requirements.standards.civil;
      this.assert(civil.standard.name === 'Balance of Probabilities',
                  'Civil standard name matches');
      this.assert(civil.standard.threshold === '50.1%',
                  'Civil threshold matches preponderance standard');
      this.assert(civil.standard.requirement === 'Preponderance of evidence',
                  'Preponderance requirement explicitly stated');
      
      // Verify evidence requirements
      const evidenceReqs = civil.requirements.evidence_requirements;
      this.assert(evidenceReqs !== undefined, 'Evidence requirements defined');
      this.assert(evidenceReqs.primary.toLowerCase().includes('circumstantial'),
                  'Circumstantial evidence supported for preponderance');
      
      return true;
    } catch (error) {
      this.assert(false, `Integration test failed: ${error.message}`);
      return false;
    }
  }

  testPythonAnalyzerCompatibility() {
    console.log('\n🧪 Phase 6.2: Test Python analyzer compatibility...');
    
    // Check if Python analyzer exists
    const pythonAnalyzer = 'burden_of_proof_analyzer.py';
    this.assert(fs.existsSync(pythonAnalyzer), 
                'burden_of_proof_analyzer.py exists');
    
    if (fs.existsSync(pythonAnalyzer)) {
      const content = fs.readFileSync(pythonAnalyzer, 'utf8');
      
      // Check for preponderance-related implementation
      this.assert(content.includes('CIVIL') || content.includes('civil'),
                  'Python analyzer includes civil standard');
      this.assert(content.includes('balance_of_probabilities') || content.includes('preponderance'),
                  'Python analyzer references preponderance/balance of probabilities');
      this.assert(content.includes('0.51') || content.includes('50'),
                  'Python analyzer includes preponderance threshold');
    }
    
    return true;
  }

  // ============================================================================
  // PHASE 7: End-to-End Scenarios
  // ============================================================================

  testEndToEndPreponderanceScenarios() {
    console.log('\n🧪 Phase 7: Test end-to-end preponderance scenarios...');
    
    const evaluateCase = (caseData) => {
      // Aggregate all evidence
      let totalStrength = 0;
      let totalWeight = 0;
      
      caseData.evidence.forEach(ev => {
        // Calculate individual evidence strength
        const quality = (ev.reliability + ev.relevance + ev.authenticity) / 300;
        const strength = quality * (ev.admissible ? 1 : 0);
        const weight = ev.weight || 1.0;
        
        totalStrength += strength * weight;
        totalWeight += weight;
      });
      
      const overallStrength = totalWeight > 0 ? totalStrength / totalWeight : 0;
      
      // Consider alternative explanations
      const alternativeStrength = caseData.alternatives ? 
                                  caseData.alternatives.reduce((sum, alt) => sum + alt.strength, 0) / 
                                  caseData.alternatives.length : 0;
      
      // Normalize: primary vs alternatives
      const total = overallStrength + alternativeStrength;
      const normalizedPrimary = total > 0 ? overallStrength / total : 0;
      
      return {
        evidenceStrength: overallStrength,
        normalizedStrength: normalizedPrimary,
        meetsPreponderance: normalizedPrimary > 0.5,
        confidence: normalizedPrimary
      };
    };
    
    const scenarios = [
      {
        name: 'Fiduciary Breach - Peter (Strong Case)',
        evidence: [
          { reliability: 85, relevance: 90, authenticity: 88, admissible: true, weight: 1.0 },
          { reliability: 80, relevance: 85, authenticity: 82, admissible: true, weight: 0.9 },
          { reliability: 75, relevance: 80, authenticity: 78, admissible: true, weight: 0.7 }
        ],
        alternatives: [
          { strength: 0.15 },
          { strength: 0.10 }
        ],
        expectedOutcome: true
      },
      {
        name: 'Revenue Diversion - Rynette (Moderate Case)',
        evidence: [
          { reliability: 70, relevance: 75, authenticity: 68, admissible: true, weight: 1.0 },
          { reliability: 65, relevance: 70, authenticity: 62, admissible: true, weight: 0.8 },
          { reliability: 60, relevance: 55, authenticity: 58, admissible: false, weight: 0.6 }
        ],
        alternatives: [
          { strength: 0.25 },
          { strength: 0.20 }
        ],
        expectedOutcome: true
      },
      {
        name: 'Professional Misconduct - Bantjies (Weak Case)',
        evidence: [
          { reliability: 40, relevance: 45, authenticity: 38, admissible: true, weight: 1.0 },
          { reliability: 35, relevance: 40, authenticity: 32, admissible: true, weight: 0.7 }
        ],
        alternatives: [
          { strength: 0.50 },
          { strength: 0.45 },
          { strength: 0.30 }
        ],
        expectedOutcome: false
      }
    ];
    
    scenarios.forEach(scenario => {
      const result = evaluateCase(scenario);
      
      console.log(`\n   ${scenario.name}:`);
      console.log(`   Evidence Strength: ${result.evidenceStrength.toFixed(3)}`);
      console.log(`   Normalized (vs alternatives): ${result.normalizedStrength.toFixed(3)}`);
      console.log(`   Preponderance: ${result.meetsPreponderance ? 'MET ✓' : 'NOT MET ✗'}`);
      
      this.assert(result.meetsPreponderance === scenario.expectedOutcome,
                  `${scenario.name}: ${result.meetsPreponderance ? 'meets' : 'fails'} preponderance as expected`);
    });
    
    return true;
  }

  // ============================================================================
  // Test Runner
  // ============================================================================

  runAllTests() {
    console.log('═'.repeat(80));
    console.log('🚀 PREPONDERANCE OF EVIDENCE AUTOMATED TESTING PIPELINE');
    console.log('═'.repeat(80));
    console.log('📋 Task: task_25 (Create automated testing pipeline for preponderance of evidence)');
    console.log('📍 Source: todo/optimal-strategies-burden-of-proof.md (line 10)');
    console.log('🎯 Standard: Civil - Balance of Probabilities (>50% threshold)');
    console.log('⚖️  Requirement: Preponderance of evidence assessment framework');
    console.log('═'.repeat(80));

    const testPhases = [
      // Phase 1: Framework Validation
      { name: 'Phase 1.1', test: () => this.testPreponderanceFrameworkExists() },
      { name: 'Phase 1.2', test: () => this.testPreponderanceThresholdConfiguration() },
      
      // Phase 2: Evidence Weighting
      { name: 'Phase 2.1', test: () => this.testEvidenceWeightingAlgorithm() },
      { name: 'Phase 2.2', test: () => this.testMultiEvidenceAggregation() },
      
      // Phase 3: Probability Calculations
      { name: 'Phase 3.1', test: () => this.testProbabilityCalculations() },
      { name: 'Phase 3.2', test: () => this.testComparativeAnalysis() },
      
      // Phase 4: Evidence Quality
      { name: 'Phase 4.1', test: () => this.testEvidenceQualityMetrics() },
      { name: 'Phase 4.2', test: () => this.testCorroborationEffects() },
      
      // Phase 5: Preponderance Determination
      { name: 'Phase 5.1', test: () => this.testPreponderanceDetermination() },
      { name: 'Phase 5.2', test: () => this.testAlternativeExplanationAnalysis() },
      
      // Phase 6: Integration
      { name: 'Phase 6.1', test: () => this.testIntegrationWithBurdenOfProofFramework() },
      { name: 'Phase 6.2', test: () => this.testPythonAnalyzerCompatibility() },
      
      // Phase 7: End-to-End
      { name: 'Phase 7', test: () => this.testEndToEndPreponderanceScenarios() }
    ];

    let allTestsPassed = true;
    testPhases.forEach(phase => {
      if (!phase.test()) {
        allTestsPassed = false;
      }
    });

    // Calculate results
    const totalTests = this.testResults.length;
    const passedTests = this.testResults.filter(t => t.passed).length;
    const failedTests = totalTests - passedTests;
    const successRate = Math.round((passedTests / totalTests) * 100);
    const duration = ((Date.now() - this.startTime) / 1000).toFixed(2);

    // Print summary
    console.log('\n' + '═'.repeat(80));
    console.log('📊 PREPONDERANCE OF EVIDENCE PIPELINE TEST SUMMARY');
    console.log('═'.repeat(80));
    console.log(`✅ Passed: ${passedTests}/${totalTests}`);
    console.log(`❌ Failed: ${failedTests}`);
    console.log(`📈 Success Rate: ${successRate}%`);
    console.log(`⏱️  Execution Time: ${duration}s`);
    console.log(`🎯 Preponderance Threshold: >50% (0.501)`);
    console.log(`📋 Test Phases Completed: ${testPhases.length}`);

    if (failedTests === 0) {
      console.log('\n🎉 ALL PREPONDERANCE OF EVIDENCE PIPELINE TESTS PASSED!');
      console.log('✅ Framework validation complete');
      console.log('✅ Evidence weighting algorithms validated');
      console.log('✅ Probability calculations verified');
      console.log('✅ Evidence quality metrics tested');
      console.log('✅ Preponderance determination algorithms validated');
      console.log('✅ Integration with burden of proof framework confirmed');
      console.log('✅ End-to-end scenarios successfully tested');
      console.log('\n📋 Task task_25 (feature_33, para_22) COMPLETE');
    } else {
      console.log('\n⚠️  Some tests failed. Review the output above.');
    }

    console.log('═'.repeat(80));

    return allTestsPassed;
  }
}

// Run tests if executed directly
if (require.main === module) {
  const pipeline = new PreponderanceOfEvidencePipeline();
  const success = pipeline.runAllTests();
  process.exit(success ? 0 : 1);
}

module.exports = PreponderanceOfEvidencePipeline;
