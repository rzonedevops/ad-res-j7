#!/usr/bin/env python3
"""
Evidence Refinery Processor
Automated processing script for GitHub Actions to refine case models and remove speculative claims
Implements OpenCog GGML HyperGraphQL for graph-aware logic and abductive inference
"""

import argparse
import json
import logging
import sys
from datetime import datetime
from pathlib import Path
from typing import Any, Dict, List, Optional

# Configure logging
logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')
logger = logging.getLogger(__name__)

def setup_paths():
    """Setup Python paths for imports"""
    current_dir = Path(__file__).parent.parent
    sys.path.insert(0, str(current_dir))
    sys.path.insert(0, str(current_dir / 'frameworks'))
    sys.path.insert(0, str(current_dir / 'src'))

def run_fact_verification(output_dir: Path) -> Dict[str, Any]:
    """Run strict fact verification and speculation removal"""
    logger.info("🔍 Starting fact verification and speculation removal...")
    
    try:
        from fact_verification_engine import FactVerificationEngine
        from strict_evidence_report_generator import StrictEvidenceReportGenerator
        from evidence_based_analysis import EvidenceBasedAnalyzer
        
        # Initialize engines
        fact_engine = FactVerificationEngine()
        strict_generator = StrictEvidenceReportGenerator()
        evidence_analyzer = EvidenceBasedAnalyzer()
        
        results = {
            'verified_facts': [],
            'speculation_removed': [],
            'exact_figures': [],
            'evidence_sources': [],
            'confidence_scores': {}
        }
        
        # Process all markdown and json files for fact verification
        workspace = Path('.')
        processed_files = 0
        
        for file_path in workspace.glob('**/*.md'):
            if any(skip in str(file_path) for skip in ['node_modules', '.git', 'venv', '__pycache__']):
                continue
                
            try:
                logger.info(f"📄 Analyzing {file_path}")
                
                # Extract documented facts only
                facts = strict_generator.extract_documented_facts(str(file_path))
                results['verified_facts'].extend(facts)
                
                # Analyze content for speculation
                with open(file_path, 'r', encoding='utf-8', errors='ignore') as f:
                    content = f.read()
                
                fact_check = fact_engine.analyze_content_for_speculation(content)
                if fact_check['requires_revision']:
                    results['speculation_removed'].append({
                        'file': str(file_path),
                        'issues': fact_check['speculative_elements'],
                        'confidence': fact_check['confidence_score']
                    })
                
                processed_files += 1
                
            except Exception as e:
                logger.warning(f'⚠️ Error processing {file_path}: {e}')
        
        # Generate strict evidence report
        strict_report = strict_generator.generate_strict_evidence_report()
        (output_dir / 'STRICT_EVIDENCE_REPORT.md').write_text(strict_report)
        
        # Generate figure verification report
        figure_report = strict_generator.generate_figure_verification_report()
        (output_dir / 'FINANCIAL_FIGURE_VERIFICATION.md').write_text(figure_report)
        
        # Save processing results
        (output_dir / 'fact_verification_results.json').write_text(
            json.dumps(results, indent=2, default=str)
        )
        
        logger.info(f'✅ Fact verification complete:')
        logger.info(f'   📊 Files processed: {processed_files}')
        logger.info(f'   📊 Verified facts: {len(results["verified_facts"])}')
        logger.info(f'   🚫 Speculative content flagged: {len(results["speculation_removed"])}')
        
        return results
        
    except ImportError as e:
        logger.error(f"❌ Import error in fact verification: {e}")
        return {'error': str(e)}
    except Exception as e:
        logger.error(f"❌ Error in fact verification: {e}")
        return {'error': str(e)}

def run_abductive_reasoning(evidence_data: Dict[str, Any], output_dir: Path) -> Dict[str, Any]:
    """Run abductive reasoning and hypothesis generation"""
    logger.info("🧠 Starting abductive reasoning and hypothesis generation...")
    
    try:
        from frameworks.opencog_hgnnql import AtomSpace, Atom, AtomType, TruthValue
        from frameworks.hyper_holmes_inference import HyperHolmesInferenceEngine, InferenceRule, RuleType
        
        # Initialize OpenCog AtomSpace and Hyper-Holmes
        atomspace = AtomSpace("evidence_refinery_case")
        inference_engine = HyperHolmesInferenceEngine(atomspace)
        
        # Add evidence as atoms to knowledge base
        evidence_atoms = []
        for category, items in evidence_data.items():
            if isinstance(items, list):
                for item in items:
                    if isinstance(item, dict) and 'fact' in item:
                        atom_id = f'evidence_{len(evidence_atoms)}'
                        evidence_atom = Atom(
                            atom_id=atom_id,
                            atom_type=AtomType.EVIDENCE,
                            name=item.get('fact', 'Unknown fact'),
                            truth_value=TruthValue(
                                strength=min(item.get('weight', 1) / 10.0, 1.0),
                                confidence=0.9 if item.get('classification') == 'documented' else 0.6
                            ),
                            metadata={
                                'category': category,
                                'evidence_type': item.get('classification', 'unknown'),
                                'source': item.get('context', ''),
                                'weight': item.get('weight', 1)
                            }
                        )
                        atomspace.add_atom(evidence_atom)
                        evidence_atoms.append(atom_id)
        
        logger.info(f'🧠 Added {len(evidence_atoms)} evidence atoms to knowledge base')
        
        # Define abductive reasoning rules for legal case analysis
        abductive_rules = [
            InferenceRule(
                rule_id='abductive_financial_fraud',
                rule_type=RuleType.ABDUCTION,
                name='Financial Fraud Pattern Detection',
                description='If unauthorized transactions and account access coexist, hypothesize financial fraud',
                premises=[
                    {'atom_type': AtomType.EVIDENCE, 'pattern': 'unauthorized.*access'},
                    {'atom_type': AtomType.EVIDENCE, 'pattern': 'financial.*transaction'}
                ],
                conclusion={
                    'name': 'financial_fraud_hypothesis',
                    'description': 'Pattern suggests coordinated financial fraud',
                    'confidence_level': 'high'
                }
            ),
            InferenceRule(
                rule_id='abductive_identity_hijacking',
                rule_type=RuleType.ABDUCTION,
                name='Identity Hijacking Pattern',
                description='If email control and business interference coexist, hypothesize identity hijacking',
                premises=[
                    {'atom_type': AtomType.EVIDENCE, 'pattern': 'email.*control'},
                    {'atom_type': AtomType.EVIDENCE, 'pattern': 'business.*interference'}
                ],
                conclusion={
                    'name': 'identity_hijacking_hypothesis',
                    'description': 'Pattern suggests systematic identity hijacking scheme',
                    'confidence_level': 'high'
                }
            ),
            InferenceRule(
                rule_id='abductive_systematic_sabotage',
                rule_type=RuleType.ABDUCTION,
                name='Systematic Business Sabotage',
                description='If multiple business disruptions occur simultaneously, hypothesize coordinated sabotage',
                premises=[
                    {'atom_type': AtomType.EVIDENCE, 'pattern': 'card.*cancel'},
                    {'atom_type': AtomType.EVIDENCE, 'pattern': 'account.*interfer'},
                    {'atom_type': AtomType.EVIDENCE, 'pattern': 'business.*disrupt'}
                ],
                conclusion={
                    'name': 'systematic_sabotage_hypothesis',
                    'description': 'Pattern suggests coordinated business sabotage campaign',
                    'confidence_level': 'very_high'
                }
            )
        ]
        
        # Add abductive rules to inference engine
        for rule in abductive_rules:
            inference_engine.add_rule(rule)
        
        logger.info(f'🧠 Added {len(abductive_rules)} abductive reasoning rules')
        
        # Run abductive inference to generate hypotheses
        logger.info('🔍 Running abductive inference...')
        hypotheses = inference_engine.run_abductive_inference()
        
        # Run pattern detection
        logger.info('🔍 Detecting patterns in evidence...')
        patterns = inference_engine.detect_patterns()
        
        # Generate comprehensive inference report
        inference_results = {
            'generated_hypotheses': hypotheses,
            'detected_patterns': patterns,
            'evidence_atoms_processed': len(evidence_atoms),
            'inference_rules_applied': len(abductive_rules),
            'timestamp': datetime.now().isoformat(),
            'confidence_summary': {
                'high_confidence_hypotheses': len([h for h in hypotheses if h.get('confidence', 0) > 0.8]),
                'medium_confidence_hypotheses': len([h for h in hypotheses if 0.5 <= h.get('confidence', 0) <= 0.8]),
                'low_confidence_hypotheses': len([h for h in hypotheses if h.get('confidence', 0) < 0.5])
            }
        }
        
        # Save results
        (output_dir / 'ABDUCTIVE_REASONING_RESULTS.json').write_text(
            json.dumps(inference_results, indent=2, default=str)
        )
        
        logger.info(f'✅ Abductive reasoning complete:')
        logger.info(f'   🧠 Hypotheses generated: {len(hypotheses)}')
        logger.info(f'   🔍 Patterns detected: {len(patterns)}')
        logger.info(f'   📊 Evidence atoms processed: {len(evidence_atoms)}')
        
        return inference_results
        
    except ImportError as e:
        logger.error(f"❌ Import error in abductive reasoning: {e}")
        return {'error': str(e)}
    except Exception as e:
        logger.error(f"❌ Error in abductive reasoning: {e}")
        return {'error': str(e)}

def run_opencog_ggml_integration(evidence_data: Dict[str, Any], reasoning_data: Dict[str, Any], output_dir: Path) -> Dict[str, Any]:
    """Run OpenCog GGML HyperGraphQL integration"""
    logger.info("🧠 Starting OpenCog GGML HyperGraphQL integration...")
    
    try:
        from frameworks.opencog_case_llm import OpenCogCaseLLM
        from frameworks.ggml_legal_engine import GGMLLegalEngine
        
        # Initialize the complete OpenCog Case-LLM system
        case_id = 'evidence_refinery_' + datetime.now().strftime('%Y%m%d_%H%M%S')
        
        logger.info(f'🔧 Initializing OpenCog Case-LLM system (Case ID: {case_id})')
        system = OpenCogCaseLLM(case_id, str(output_dir))
        
        # Initialize GGML Legal Engine for neural inference
        logger.info('⚡ Initializing GGML Legal Engine...')
        ggml_engine = GGMLLegalEngine()
        
        # Add evidence to OpenCog knowledge base
        evidence_entities = []
        evidence_events = []
        
        # Process verified facts as entities
        for fact in evidence_data.get('verified_facts', []):
            if isinstance(fact, dict) and 'fact' in fact:
                entity_id = f'evidence_entity_{len(evidence_entities)}'
                system.add_entity(entity_id, fact.get('fact', 'Unknown fact'), 'evidence')
                evidence_entities.append(entity_id)
                
                # Add as event with timestamp if available
                if fact.get('date_info'):
                    event_id = f'evidence_event_{len(evidence_events)}'
                    system.add_event(event_id, f'Evidence: {fact.get("fact", "Unknown")}', datetime.now(), [entity_id])
                    evidence_events.append(event_id)
        
        # Add hypotheses from abductive reasoning
        if reasoning_data.get('generated_hypotheses'):
            for hypothesis in reasoning_data['generated_hypotheses']:
                hypothesis_id = f'hypothesis_{hypothesis.get("name", "unknown").replace(" ", "_")}'
                system.add_entity(
                    hypothesis_id, 
                    hypothesis.get('description', 'Generated hypothesis'),
                    'hypothesis'
                )
                evidence_entities.append(hypothesis_id)
                
                # Link hypothesis to supporting evidence
                for evidence_id in hypothesis.get('supporting_evidence', []):
                    system.add_relationship(hypothesis_id, evidence_id, 'supported_by')
        
        logger.info(f'📊 Knowledge base populated:')
        logger.info(f'   📄 Evidence entities: {len(evidence_entities)}')
        logger.info(f'   ⏰ Evidence events: {len(evidence_events)}')
        
        # Run GGML neural inference on the knowledge base
        logger.info('⚡ Running GGML neural inference...')
        try:
            # Run legal document analysis
            legal_analysis_results = ggml_engine.analyze_legal_documents([
                {'content': str(evidence_data), 'type': 'evidence_analysis'},
                {'content': str(reasoning_data), 'type': 'reasoning_results'}
            ])
            
            # Extract entity relationships using GGML
            entity_extraction_results = ggml_engine.extract_entity_relationships(str(evidence_data))
            
            # Run fraud detection analysis
            fraud_detection_results = ggml_engine.detect_fraud_patterns_enhanced(str(evidence_data))
            
            ggml_results = {
                'legal_analysis': legal_analysis_results,
                'entity_extraction': entity_extraction_results,
                'fraud_detection': fraud_detection_results,
                'inference_timestamp': datetime.now().isoformat(),
                'ggml_engine_version': '1.0.0'
            }
            
            logger.info('✅ GGML neural inference completed')
            
        except Exception as e:
            logger.warning(f'⚠️ GGML inference error (continuing without): {e}')
            ggml_results = {'error': str(e), 'status': 'failed'}
        
        # Execute HGNNQL queries for comprehensive analysis
        logger.info('🔍 Executing HGNNQL queries...')
        
        hgnnql_queries = [
            {'query': 'FIND ENTITY WHERE type="evidence"', 'description': 'All evidence entities'},
            {'query': 'FIND ENTITY WHERE type="hypothesis"', 'description': 'All generated hypotheses'},
            {'query': 'LINK evidence hypothesis', 'description': 'Evidence-hypothesis relationships'},
            {'query': 'COUNT ENTITY WHERE confidence > 0.8', 'description': 'High confidence entities'}
        ]
        
        hgnnql_results = []
        for query_info in hgnnql_queries:
            try:
                result = system.query_hgnnql(query_info['query'])
                hgnnql_results.append({
                    'query': query_info['query'],
                    'description': query_info['description'],
                    'result': result,
                    'success': True
                })
            except Exception as e:
                hgnnql_results.append({
                    'query': query_info['query'],
                    'description': query_info['description'],
                    'error': str(e),
                    'success': False
                })
        
        # Run complete analysis pipeline
        logger.info('🧠 Running complete OpenCog analysis pipeline...')
        complete_analysis = system.run_complete_analysis()
        
        # Combine all results
        integration_results = {
            'case_id': case_id,
            'timestamp': datetime.now().isoformat(),
            'evidence_processing': evidence_data,
            'abductive_reasoning': reasoning_data,
            'ggml_neural_inference': ggml_results,
            'hgnnql_queries': hgnnql_results,
            'opencog_analysis': complete_analysis,
            'knowledge_base_stats': {
                'entities': len(evidence_entities),
                'events': len(evidence_events),
                'total_atoms': len(system.atomspace.atoms)
            }
        }
        
        # Save comprehensive results
        (output_dir / 'OPENCOG_GGML_HYPERGRAPHQL_RESULTS.json').write_text(
            json.dumps(integration_results, indent=2, default=str)
        )
        
        logger.info(f'✅ OpenCog GGML HyperGraphQL integration complete!')
        logger.info(f'   🧠 Knowledge atoms: {len(system.atomspace.atoms)}')
        logger.info(f'   🔍 HGNNQL queries: {len(hgnnql_results)}')
        logger.info(f'   ⚡ GGML inference: {"Success" if "error" not in ggml_results else "Failed"}')
        
        return integration_results
        
    except ImportError as e:
        logger.error(f"❌ Import error in OpenCog integration: {e}")
        return {'error': str(e)}
    except Exception as e:
        logger.error(f"❌ Error in OpenCog integration: {e}")
        return {'error': str(e)}

def main():
    """Main entry point for the evidence refinery processor"""
    parser = argparse.ArgumentParser(description='Evidence Refinery Processor for GitHub Actions')
    parser.add_argument('--mode', choices=['fact_verification', 'abductive_reasoning', 'ggml_integration', 'comprehensive'], 
                       default='comprehensive', help='Processing mode')
    parser.add_argument('--output-dir', type=Path, default=Path('evidence_refinery_output'), 
                       help='Output directory for results')
    parser.add_argument('--verbose', action='store_true', help='Enable verbose logging')
    
    args = parser.parse_args()
    
    if args.verbose:
        logging.getLogger().setLevel(logging.DEBUG)
    
    # Setup paths
    setup_paths()
    
    # Ensure output directory exists
    args.output_dir.mkdir(parents=True, exist_ok=True)
    
    logger.info(f"🚀 Starting Evidence Refinery Processor (Mode: {args.mode})")
    
    results = {
        'mode': args.mode,
        'timestamp': datetime.now().isoformat(),
        'output_directory': str(args.output_dir)
    }
    
    try:
        # Step 1: Fact verification (always run first unless specific mode)
        if args.mode in ['fact_verification', 'comprehensive']:
            fact_results = run_fact_verification(args.output_dir)
            results['fact_verification'] = fact_results
        else:
            fact_results = {}
        
        # Step 2: Abductive reasoning
        if args.mode in ['abductive_reasoning', 'comprehensive']:
            reasoning_results = run_abductive_reasoning(fact_results, args.output_dir)
            results['abductive_reasoning'] = reasoning_results
        else:
            reasoning_results = {}
        
        # Step 3: OpenCog GGML integration
        if args.mode in ['ggml_integration', 'comprehensive']:
            integration_results = run_opencog_ggml_integration(fact_results, reasoning_results, args.output_dir)
            results['ggml_integration'] = integration_results
        
        # Save overall results
        (args.output_dir / 'EVIDENCE_REFINERY_COMPLETE_RESULTS.json').write_text(
            json.dumps(results, indent=2, default=str)
        )
        
        logger.info("🎉 Evidence Refinery Processing Complete!")
        logger.info(f"📁 Results saved to: {args.output_dir}")
        
    except Exception as e:
        logger.error(f"❌ Critical error in evidence refinery processing: {e}")
        results['error'] = str(e)
        (args.output_dir / 'EVIDENCE_REFINERY_ERROR.json').write_text(
            json.dumps(results, indent=2, default=str)
        )
        sys.exit(1)

if __name__ == "__main__":
    main()