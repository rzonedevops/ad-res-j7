"""
Integrated Lex-Grip Workflow Demo

Demonstrates end-to-end integration of grip optimization with lex inference engine
for optimal case analysis with continuous quality measurement and improvement.
"""

import json
import sys
from datetime import datetime
from typing import Dict, List, Any

# Note: This demo shows the integration pattern. 
# Actual execution requires torch to be installed: pip install torch numpy

try:
    from legal_attention_grip_optimizer import GripOptimizer, GripMetrics
    TORCH_AVAILABLE = True
except ImportError:
    TORCH_AVAILABLE = False
    print("⚠️  Note: PyTorch not installed. Showing workflow structure only.")
    print("   To run: pip install torch numpy\n")


class IntegratedLexGripWorkflow:
    """
    Integrated workflow combining lex inference with grip optimization.
    
    Workflow:
    1. Initial Analysis: Run lex inference on case configurations
    2. Grip Measurement: Assess quality of legal reasoning
    3. Gap Identification: Detect evidence/reasoning weaknesses
    4. Optimization: Improve attention patterns for better grip
    5. Re-analysis: Verify improvements
    6. Iteration: Repeat until target grip achieved
    """
    
    def __init__(self, case_id: str = "case_2025_137857"):
        self.case_id = case_id
        self.optimizer = None
        self.current_generation = 0
        self.grip_history = []
        
        if TORCH_AVAILABLE:
            self.optimizer = GripOptimizer(
                mutation_rate=0.1,
                learning_rate=0.01,
                target_fitness=0.90
            )
    
    def run_complete_workflow(self):
        """Execute complete lex-grip integrated workflow."""
        print("🧬 Integrated Lex-Grip Workflow Demo")
        print("=" * 70)
        print(f"Case ID: {self.case_id}")
        print(f"Target Fitness: 0.90 (90% grip quality)\n")
        
        # Phase 1: Initial Lex Analysis
        print("📊 Phase 1: Initial Lex Analysis")
        print("-" * 70)
        configurations = self._run_lex_inference()
        evidence_pool = self._load_evidence_pool()
        inference_rules = self._load_inference_rules()
        print(f"✅ Analyzed {len(configurations)} configurations")
        print(f"✅ Loaded {len(evidence_pool)} evidence items")
        print(f"✅ Applied {len(inference_rules)} inference rules\n")
        
        # Phase 2: Initial Grip Measurement
        print("📏 Phase 2: Initial Grip Measurement")
        print("-" * 70)
        initial_metrics = self._measure_grip(
            configurations, evidence_pool, inference_rules
        )
        self.grip_history.append(initial_metrics)
        self._display_metrics(initial_metrics)
        print()
        
        # Phase 3: Evidence Gap Analysis
        print("🔍 Phase 3: Evidence Gap Analysis")
        print("-" * 70)
        gaps = self._identify_gaps(initial_metrics, configurations)
        self._display_gaps(gaps)
        print()
        
        # Phase 4: Invariance Analysis
        print("⚖️  Phase 4: Invariance Status")
        print("-" * 70)
        invariance_status = self._analyze_invariance(configurations)
        self._display_invariance(invariance_status)
        print()
        
        # Phase 5: Optimization Loop
        print("🔄 Phase 5: Optimization Loop")
        print("-" * 70)
        
        max_iterations = 5
        for i in range(max_iterations):
            print(f"\nIteration {i+1}/{max_iterations}")
            
            # Simulate optimization step
            improved_metrics = self._optimization_step(
                initial_metrics, configurations, evidence_pool, inference_rules
            )
            
            self.grip_history.append(improved_metrics)
            print(f"  Fitness: {improved_metrics['fitness']:.4f} "
                  f"(Δ {improved_metrics['fitness'] - initial_metrics['fitness']:.4f})")
            
            # Check convergence
            if improved_metrics['fitness'] >= 0.90:
                print(f"\n✅ Target fitness reached in {i+1} iterations!")
                break
            
            initial_metrics = improved_metrics
        
        print()
        
        # Phase 6: Final Assessment
        print("📊 Phase 6: Final Assessment")
        print("-" * 70)
        final_metrics = self.grip_history[-1]
        self._display_final_report(final_metrics, gaps, invariance_status)
        
        # Phase 7: Recommendations
        print("\n💡 Phase 7: Recommendations")
        print("-" * 70)
        self._generate_recommendations(final_metrics, gaps)
        
        print("\n" + "=" * 70)
        print("✅ Workflow Complete!\n")
        
        return {
            'case_id': self.case_id,
            'generations': len(self.grip_history),
            'initial_fitness': self.grip_history[0]['fitness'],
            'final_fitness': self.grip_history[-1]['fitness'],
            'improvement': self.grip_history[-1]['fitness'] - self.grip_history[0]['fitness'],
            'gaps_identified': len(gaps),
            'target_reached': self.grip_history[-1]['fitness'] >= 0.90
        }
    
    def _run_lex_inference(self) -> List[Dict[str, Any]]:
        """Simulate lex inference engine analysis."""
        # In production: npm run db:lex:demo and parse results
        # Here: Create sample configurations
        return [
            {
                'id': f'config_{i}',
                'agent_id': agent,
                'arena': arena,
                'event_id': f'event_{i}',
                'horizon': horizon,
                'guilt_status': status,
                'evidence_refs': [f'ev_{i}', f'ev_{i+1}'],
                'applied_rules': [f'rule_{i % 3}']
            }
            for i, (agent, arena, horizon, status) in enumerate([
                ('bantjies', 'trust', 'full', 'possible'),
                ('bantjies', 'trust', 'partial', 'possible'),
                ('peter', 'trust', 'full', 'possible'),
                ('peter', 'court', 'full', 'possible'),
                ('jacqui', 'trust', 'full', 'impossible'),
                ('daniel', 'trust', 'full', 'impossible'),
                ('bantjies', 'court', 'full', 'necessary'),
                ('bantjies', 'court', 'partial', 'necessary'),
            ])
        ]
    
    def _load_evidence_pool(self) -> List[Dict[str, Any]]:
        """Load available evidence items."""
        return [
            {'id': f'ev_{i}', 'criticality': 0.5 + (i % 5) * 0.1}
            for i in range(20)
        ]
    
    def _load_inference_rules(self) -> List[Dict[str, Any]]:
        """Load applicable inference rules."""
        return [
            {'id': 'rule_0', 'name': 'Breach of Fiduciary Duty', 'strength': 100},
            {'id': 'rule_1', 'name': 'Material Non-Disclosure', 'strength': 95},
            {'id': 'rule_2', 'name': 'Professional Misconduct', 'strength': 90},
        ]
    
    def _measure_grip(
        self, 
        configurations: List[Dict], 
        evidence_pool: List[Dict],
        inference_rules: List[Dict]
    ) -> Dict[str, float]:
        """Measure grip on case material."""
        # Calculate metrics
        total_configs = len(configurations)
        necessary_count = sum(1 for c in configurations if c['guilt_status'] == 'necessary')
        
        linked_evidence = set()
        for config in configurations:
            linked_evidence.update(config.get('evidence_refs', []))
        
        applied_rules = set()
        for config in configurations:
            applied_rules.update(config.get('applied_rules', []))
        
        metrics = {
            'completeness': min(1.0, total_configs / 48),  # Assuming 48 total possible
            'invariance_rate': necessary_count / max(1, total_configs),
            'evidence_integration': len(linked_evidence) / max(1, len(evidence_pool)),
            'rule_coverage': len(applied_rules) / max(1, len(inference_rules)),
            'coherence': 0.75,  # Simulated
            'explanatory_power': 0.80,  # Simulated
            'stability': 0.95,  # Simulated
            'efficiency': 0.70,  # Simulated
            'transformative_insight': 0.60,  # Simulated
        }
        
        # Compute fitness
        metrics['fitness'] = (
            metrics['completeness'] * 0.15 +
            metrics['invariance_rate'] * 0.20 +
            metrics['evidence_integration'] * 0.15 +
            metrics['rule_coverage'] * 0.10 +
            metrics['coherence'] * 0.10 +
            metrics['explanatory_power'] * 0.10 +
            metrics['stability'] * 0.10 +
            metrics['efficiency'] * 0.05 +
            metrics['transformative_insight'] * 0.05
        )
        
        return metrics
    
    def _identify_gaps(
        self, 
        metrics: Dict[str, float],
        configurations: List[Dict]
    ) -> List[Dict[str, Any]]:
        """Identify evidence and reasoning gaps."""
        gaps = []
        
        if metrics['invariance_rate'] < 0.5:
            gaps.append({
                'type': 'weak_invariance',
                'priority': 1.0 - metrics['invariance_rate'],
                'description': 'Low invariance rate - guilt not necessary',
                'action': 'Collect additional evidence to strengthen necessity claims',
                'impact': 'High - affects core guilt determination'
            })
        
        if metrics['evidence_integration'] < 0.7:
            gaps.append({
                'type': 'missing_evidence_links',
                'priority': 1.0 - metrics['evidence_integration'],
                'description': 'Insufficient evidence linked to configurations',
                'action': 'Link more evidence items to legal configurations',
                'impact': 'Medium - affects completeness'
            })
        
        if metrics['rule_coverage'] < 0.7:
            gaps.append({
                'type': 'incomplete_rule_application',
                'priority': 1.0 - metrics['rule_coverage'],
                'description': 'Not all applicable rules applied',
                'action': 'Apply additional legal principles from lex/lv1/',
                'impact': 'Medium - affects legal rigor'
            })
        
        return gaps
    
    def _analyze_invariance(
        self, 
        configurations: List[Dict]
    ) -> Dict[str, Any]:
        """Analyze invariance status by agent."""
        status = {}
        
        for config in configurations:
            agent = config['agent_id']
            guilt_status = config['guilt_status']
            
            if agent not in status:
                status[agent] = {
                    'necessary': 0,
                    'possible': 0,
                    'impossible': 0,
                    'total': 0
                }
            
            status[agent][guilt_status] += 1
            status[agent]['total'] += 1
        
        # Calculate invariance percentage
        for agent, counts in status.items():
            counts['invariance_pct'] = counts['necessary'] / max(1, counts['total'])
        
        return status
    
    def _optimization_step(
        self,
        current_metrics: Dict[str, float],
        configurations: List[Dict],
        evidence_pool: List[Dict],
        inference_rules: List[Dict]
    ) -> Dict[str, float]:
        """Simulate one optimization step."""
        # In production: Actually optimize attention weights
        # Here: Simulate improvement
        
        improved = current_metrics.copy()
        
        # Simulate small improvements
        improved['invariance_rate'] = min(1.0, improved['invariance_rate'] + 0.05)
        improved['evidence_integration'] = min(1.0, improved['evidence_integration'] + 0.03)
        improved['coherence'] = min(1.0, improved['coherence'] + 0.02)
        
        # Recalculate fitness
        improved['fitness'] = (
            improved['completeness'] * 0.15 +
            improved['invariance_rate'] * 0.20 +
            improved['evidence_integration'] * 0.15 +
            improved['rule_coverage'] * 0.10 +
            improved['coherence'] * 0.10 +
            improved['explanatory_power'] * 0.10 +
            improved['stability'] * 0.10 +
            improved['efficiency'] * 0.05 +
            improved['transformative_insight'] * 0.05
        )
        
        return improved
    
    def _display_metrics(self, metrics: Dict[str, float]):
        """Display grip metrics."""
        print(f"Overall Fitness: {metrics['fitness']:.4f} ({metrics['fitness']*100:.1f}%)")
        print()
        print("Quantitative Metrics:")
        print(f"  Completeness:         {metrics['completeness']:.2%}")
        print(f"  Invariance Rate:      {metrics['invariance_rate']:.2%}")
        print(f"  Evidence Integration: {metrics['evidence_integration']:.2%}")
        print(f"  Rule Coverage:        {metrics['rule_coverage']:.2%}")
        print()
        print("Qualitative Metrics:")
        print(f"  Coherence:            {metrics['coherence']:.2%}")
        print(f"  Explanatory Power:    {metrics['explanatory_power']:.2%}")
        print(f"  Stability:            {metrics['stability']:.2%}")
        print(f"  Efficiency:           {metrics['efficiency']:.2%}")
        print(f"  Transformative:       {metrics['transformative_insight']:.2%}")
    
    def _display_gaps(self, gaps: List[Dict]):
        """Display identified gaps."""
        print(f"Identified {len(gaps)} evidence/reasoning gaps:\n")
        for i, gap in enumerate(gaps, 1):
            print(f"{i}. {gap['type'].upper()}")
            print(f"   Priority: {gap['priority']:.2%}")
            print(f"   Issue: {gap['description']}")
            print(f"   Action: {gap['action']}")
            print(f"   Impact: {gap['impact']}")
            print()
    
    def _display_invariance(self, status: Dict[str, Any]):
        """Display invariance status."""
        for agent, counts in status.items():
            print(f"{agent.capitalize()}:")
            print(f"  Necessary:  {counts['necessary']}/{counts['total']} "
                  f"({counts['invariance_pct']:.1%})")
            print(f"  Possible:   {counts['possible']}/{counts['total']}")
            print(f"  Impossible: {counts['impossible']}/{counts['total']}")
            print()
    
    def _display_final_report(
        self, 
        metrics: Dict[str, float],
        gaps: List[Dict],
        invariance: Dict[str, Any]
    ):
        """Display final assessment report."""
        fitness = metrics['fitness']
        
        if fitness >= 0.90:
            quality = "✅ OPTIMAL"
        elif fitness >= 0.75:
            quality = "✓ STRONG"
        elif fitness >= 0.60:
            quality = "⚠️ MODERATE"
        else:
            quality = "❌ WEAK"
        
        print(f"Final Fitness: {fitness:.4f} ({fitness*100:.1f}%)")
        print(f"Quality Assessment: {quality}")
        print()
        print(f"Improvement: {metrics['fitness'] - self.grip_history[0]['fitness']:.4f}")
        print(f"Generations: {len(self.grip_history)}")
        print(f"Evidence Gaps: {len(gaps)}")
    
    def _generate_recommendations(
        self, 
        metrics: Dict[str, float],
        gaps: List[Dict]
    ):
        """Generate actionable recommendations."""
        recs = []
        
        if metrics['invariance_rate'] < 0.8:
            recs.append("🎯 Strengthen invariance: Collect evidence to convert 'possible' to 'necessary'")
        
        if metrics['evidence_integration'] < 0.9:
            recs.append("🔗 Improve evidence linking: Connect more evidence to configurations")
        
        if metrics['rule_coverage'] < 0.85:
            recs.append("📚 Apply more rules: Incorporate additional legal principles from lex/lv1/")
        
        if len(gaps) > 0:
            recs.append(f"🔍 Address {len(gaps)} identified gaps in priority order")
        
        if metrics['fitness'] >= 0.90:
            recs.append("✅ Maintain quality: Continue monitoring and periodic re-assessment")
        
        if not recs:
            recs.append("✅ Excellent grip achieved - maintain current approach")
        
        for i, rec in enumerate(recs, 1):
            print(f"{i}. {rec}")


def main():
    """Run integrated workflow demo."""
    workflow = IntegratedLexGripWorkflow()
    
    try:
        results = workflow.run_complete_workflow()
        
        # Save results
        results_file = f"grip_workflow_results_{datetime.now().strftime('%Y%m%d_%H%M%S')}.json"
        with open(results_file, 'w') as f:
            json.dump(results, f, indent=2)
        
        print(f"\n📄 Results saved to: {results_file}")
        
        # Exit code based on target achievement
        exit_code = 0 if results['target_reached'] else 1
        return exit_code
        
    except Exception as e:
        print(f"\n❌ Workflow error: {e}")
        return 1


if __name__ == "__main__":
    exit_code = main()
    sys.exit(exit_code)
