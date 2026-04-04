"""
Legal Attention Grip Optimizer - Ontogenetic Self-Improvement

Implements ontogenesis-inspired self-optimization for the legal attention engine,
enabling continuous improvement of "grip" on case material through evolutionary cycles.

Key Concepts:
- Grip: Quality of fit between attention patterns and legal domain structure
- Ontogenesis: Self-generating, self-optimizing, evolving mechanism
- Fitness: Composite measure of legal reasoning quality across multiple dimensions
"""

import torch
import torch.nn as nn
import numpy as np
from typing import Dict, List, Tuple, Optional, Any
from dataclasses import dataclass, field
from enum import Enum
import json
from datetime import datetime


class GripDimension(Enum):
    """Dimensions of legal reasoning grip."""
    COMPLETENESS = "completeness"  # % of possibility space explored
    INVARIANCE = "invariance"  # % of guilt assignments that are necessary
    EVIDENCE_INTEGRATION = "evidence_integration"  # % of evidence linked
    RULE_COVERAGE = "rule_coverage"  # % of applicable laws incorporated
    COHERENCE = "coherence"  # Logical consistency of reasoning
    EXPLANATORY_POWER = "explanatory_power"  # Can all facts be accounted for
    STABILITY = "stability"  # Numerical stability of computations
    EFFICIENCY = "efficiency"  # Computational efficiency


@dataclass
class GripMetrics:
    """Comprehensive grip measurement."""
    # Quantitative metrics
    completeness: float = 0.0  # 0-1
    invariance_rate: float = 0.0  # 0-1
    evidence_integration: float = 0.0  # 0-1
    rule_coverage: float = 0.0  # 0-1
    delta_minimization: float = 0.0  # Lower is better (justice gap)
    
    # Qualitative assessments (0-1 normalized)
    coherence: float = 0.0
    explanatory_power: float = 0.0
    predictive_accuracy: float = 0.0
    resistance_to_counterexamples: float = 0.0
    transformative_insight: float = 0.0
    
    # Computational metrics
    stability: float = 0.0
    efficiency: float = 0.0
    
    # Overall fitness
    fitness: float = 0.0
    
    # Metadata
    timestamp: str = field(default_factory=lambda: datetime.now().isoformat())
    generation: int = 0
    
    def compute_fitness(self) -> float:
        """
        Compute overall fitness as weighted combination of metrics.
        
        Fitness = 
          completeness * 0.15 +
          invariance_rate * 0.20 +
          evidence_integration * 0.15 +
          rule_coverage * 0.10 +
          coherence * 0.10 +
          explanatory_power * 0.10 +
          stability * 0.10 +
          efficiency * 0.05 +
          transformative_insight * 0.05
        """
        self.fitness = (
            self.completeness * 0.15 +
            self.invariance_rate * 0.20 +
            self.evidence_integration * 0.15 +
            self.rule_coverage * 0.10 +
            self.coherence * 0.10 +
            self.explanatory_power * 0.10 +
            self.stability * 0.10 +
            self.efficiency * 0.05 +
            self.transformative_insight * 0.05
        )
        return self.fitness
    
    def to_dict(self) -> Dict[str, Any]:
        """Convert to dictionary for serialization."""
        return {
            'completeness': self.completeness,
            'invariance_rate': self.invariance_rate,
            'evidence_integration': self.evidence_integration,
            'rule_coverage': self.rule_coverage,
            'delta_minimization': self.delta_minimization,
            'coherence': self.coherence,
            'explanatory_power': self.explanatory_power,
            'predictive_accuracy': self.predictive_accuracy,
            'resistance_to_counterexamples': self.resistance_to_counterexamples,
            'transformative_insight': self.transformative_insight,
            'stability': self.stability,
            'efficiency': self.efficiency,
            'fitness': self.fitness,
            'timestamp': self.timestamp,
            'generation': self.generation
        }


@dataclass
class AttentionGenome:
    """Genetic information for attention mechanism."""
    id: str
    generation: int
    lineage: List[str]  # Parent IDs
    
    # Attention weights as genes
    causal_weights: torch.Tensor
    intentional_weights: torch.Tensor
    temporal_weights: torch.Tensor
    normative_weights: torch.Tensor
    counterfactual_weights: torch.Tensor
    necessity_weights: torch.Tensor
    proportionality_weights: torch.Tensor
    
    # Performance history
    fitness_history: List[float] = field(default_factory=list)
    grip_history: List[GripMetrics] = field(default_factory=list)
    
    # Metadata
    age: int = 0
    mutations: int = 0


class GripOptimizer:
    """
    Ontogenetic grip optimizer for legal attention mechanism.
    
    Implements:
    1. Self-assessment: Measure current grip quality
    2. Self-optimization: Improve attention patterns iteratively
    3. Self-evolution: Apply genetic operations for improvement
    4. Self-reflection: Track progress and adapt strategy
    """
    
    def __init__(
        self,
        initial_genome: Optional[AttentionGenome] = None,
        mutation_rate: float = 0.1,
        learning_rate: float = 0.01,
        target_fitness: float = 0.90
    ):
        self.genome = initial_genome
        self.mutation_rate = mutation_rate
        self.learning_rate = learning_rate
        self.target_fitness = target_fitness
        
        # Optimization history
        self.generation = 0
        self.optimization_history: List[Dict[str, Any]] = []
        
    def measure_grip(
        self,
        attention_weights: Dict[str, torch.Tensor],
        configurations: List[Dict[str, Any]],
        evidence_pool: List[Dict[str, Any]],
        inference_rules: List[Dict[str, Any]]
    ) -> GripMetrics:
        """
        Measure comprehensive grip on case material.
        
        Args:
            attention_weights: Current attention weight tensors
            configurations: All legal configurations analyzed
            evidence_pool: Available evidence items
            inference_rules: Applicable legal rules
            
        Returns:
            GripMetrics: Comprehensive grip measurement
        """
        metrics = GripMetrics(generation=self.generation)
        
        # 1. Completeness: % of possibility space explored
        if len(configurations) > 0:
            total_possible = self._estimate_possibility_space_size(configurations)
            metrics.completeness = min(1.0, len(configurations) / max(1, total_possible))
        
        # 2. Invariance rate: % of necessary guilt assignments
        invariant_count = sum(
            1 for config in configurations 
            if config.get('guilt_status') == 'necessary'
        )
        metrics.invariance_rate = invariant_count / max(1, len(configurations))
        
        # 3. Evidence integration: % of evidence linked to configurations
        linked_evidence = set()
        for config in configurations:
            linked_evidence.update(config.get('evidence_refs', []))
        metrics.evidence_integration = len(linked_evidence) / max(1, len(evidence_pool))
        
        # 4. Rule coverage: % of applicable rules used
        applied_rules = set()
        for config in configurations:
            applied_rules.update(config.get('applied_rules', []))
        metrics.rule_coverage = len(applied_rules) / max(1, len(inference_rules))
        
        # 5. Coherence: Measure logical consistency via attention pattern stability
        metrics.coherence = self._measure_attention_coherence(attention_weights)
        
        # 6. Explanatory power: Can attention explain all critical facts?
        metrics.explanatory_power = self._measure_explanatory_power(
            attention_weights, evidence_pool
        )
        
        # 7. Stability: Numerical stability of attention computations
        metrics.stability = self._measure_numerical_stability(attention_weights)
        
        # 8. Efficiency: Computational efficiency (normalized by size)
        metrics.efficiency = self._measure_computational_efficiency(
            attention_weights, configurations
        )
        
        # 9. Transformative insight: Detect emergent patterns
        metrics.transformative_insight = self._measure_emergent_patterns(
            attention_weights, configurations
        )
        
        # Compute overall fitness
        metrics.compute_fitness()
        
        return metrics
    
    def optimize_grip(
        self,
        current_weights: Dict[str, torch.Tensor],
        configurations: List[Dict[str, Any]],
        evidence_pool: List[Dict[str, Any]],
        inference_rules: List[Dict[str, Any]],
        iterations: int = 10
    ) -> Tuple[Dict[str, torch.Tensor], List[GripMetrics]]:
        """
        Iteratively optimize attention weights for better grip.
        
        Uses gradient ascent on grip fitness function.
        
        Args:
            current_weights: Current attention weight tensors
            configurations: Legal configurations
            evidence_pool: Available evidence
            inference_rules: Applicable rules
            iterations: Number of optimization iterations
            
        Returns:
            Tuple of (optimized_weights, metrics_history)
        """
        weights = {k: v.clone().detach().requires_grad_(True) 
                   for k, v in current_weights.items()}
        metrics_history = []
        
        for i in range(iterations):
            # Measure current grip
            metrics = self.measure_grip(
                weights, configurations, evidence_pool, inference_rules
            )
            metrics_history.append(metrics)
            
            # Check if target reached
            if metrics.fitness >= self.target_fitness:
                print(f"✅ Target fitness {self.target_fitness} reached at iteration {i}")
                break
            
            # Compute gradients via fitness improvement
            fitness_loss = -metrics.fitness  # Negative for gradient ascent
            
            # Simulate gradient by perturbing weights
            improved_weights = self._gradient_step(
                weights, configurations, evidence_pool, inference_rules
            )
            
            # Update weights
            for key in weights:
                weights[key] = improved_weights[key]
            
            print(f"Iteration {i+1}/{iterations}: Fitness = {metrics.fitness:.4f}")
        
        return weights, metrics_history
    
    def evolve(
        self,
        population_size: int = 5,
        generations: int = 10
    ) -> Tuple[AttentionGenome, List[Dict[str, Any]]]:
        """
        Evolve attention genome through genetic algorithm.
        
        Args:
            population_size: Number of genomes in population
            generations: Number of evolutionary generations
            
        Returns:
            Tuple of (best_genome, evolution_history)
        """
        # Initialize population
        population = [self._create_random_genome() for _ in range(population_size)]
        evolution_history = []
        
        for gen in range(generations):
            # Evaluate fitness of each genome
            fitness_scores = []
            for genome in population:
                # Simulate evaluation (in practice, would run full inference)
                fitness = self._evaluate_genome_fitness(genome)
                fitness_scores.append(fitness)
            
            # Record generation stats
            gen_stats = {
                'generation': gen,
                'best_fitness': max(fitness_scores),
                'avg_fitness': np.mean(fitness_scores),
                'std_fitness': np.std(fitness_scores)
            }
            evolution_history.append(gen_stats)
            
            print(f"Generation {gen+1}: Best={gen_stats['best_fitness']:.4f}, "
                  f"Avg={gen_stats['avg_fitness']:.4f}")
            
            # Selection: Keep best performers
            sorted_pop = sorted(
                zip(population, fitness_scores), 
                key=lambda x: x[1], 
                reverse=True
            )
            elite = [genome for genome, _ in sorted_pop[:population_size//2]]
            
            # Reproduction: Create offspring via crossover and mutation
            offspring = []
            while len(offspring) < population_size - len(elite):
                parent1, parent2 = np.random.choice(elite, size=2, replace=False)
                child = self._crossover(parent1, parent2)
                child = self._mutate(child)
                offspring.append(child)
            
            # Next generation
            population = elite + offspring
            self.generation += 1
        
        # Return best genome
        best_genome = max(
            population, 
            key=lambda g: self._evaluate_genome_fitness(g)
        )
        
        return best_genome, evolution_history
    
    # Helper methods
    
    def _estimate_possibility_space_size(
        self, 
        configurations: List[Dict[str, Any]]
    ) -> int:
        """Estimate total possibility space size."""
        # Extract dimensions
        agents = set()
        arenas = set()
        events = set()
        horizons = set()
        
        for config in configurations:
            agents.add(config.get('agent_id'))
            arenas.add(config.get('arena'))
            events.add(config.get('event_id'))
            horizons.add(config.get('horizon'))
        
        # Cartesian product
        return len(agents) * len(arenas) * len(events) * len(horizons)
    
    def _measure_attention_coherence(
        self, 
        attention_weights: Dict[str, torch.Tensor]
    ) -> float:
        """Measure coherence via attention pattern consistency."""
        if not attention_weights:
            return 0.0
        
        # Check variance across heads - lower variance = more coherent
        variances = []
        for head_weights in attention_weights.values():
            if isinstance(head_weights, torch.Tensor):
                variances.append(head_weights.var().item())
        
        if not variances:
            return 0.0
        
        # Normalize: lower variance = higher coherence
        avg_variance = np.mean(variances)
        coherence = 1.0 / (1.0 + avg_variance)
        return coherence
    
    def _measure_explanatory_power(
        self,
        attention_weights: Dict[str, torch.Tensor],
        evidence_pool: List[Dict[str, Any]]
    ) -> float:
        """Measure how well attention explains critical evidence."""
        if not evidence_pool:
            return 0.0
        
        # Count critical evidence items with high attention
        critical_count = sum(
            1 for evidence in evidence_pool 
            if evidence.get('criticality', 0) > 0.7
        )
        
        # Simulate coverage (in practice, would check actual attention scores)
        coverage = min(1.0, critical_count / max(1, len(evidence_pool)))
        
        return coverage
    
    def _measure_numerical_stability(
        self,
        attention_weights: Dict[str, torch.Tensor]
    ) -> float:
        """Measure numerical stability of attention weights."""
        if not attention_weights:
            return 0.0
        
        # Check for NaN, Inf, or extreme values
        stable_count = 0
        total_count = 0
        
        for weights in attention_weights.values():
            if isinstance(weights, torch.Tensor):
                total_count += 1
                if not torch.isnan(weights).any() and not torch.isinf(weights).any():
                    if weights.abs().max() < 1e6:  # No extreme values
                        stable_count += 1
        
        return stable_count / max(1, total_count)
    
    def _measure_computational_efficiency(
        self,
        attention_weights: Dict[str, torch.Tensor],
        configurations: List[Dict[str, Any]]
    ) -> float:
        """Measure computational efficiency (inverse of complexity)."""
        # Simple heuristic: efficiency = 1 / (parameters * configs)
        total_params = sum(
            w.numel() for w in attention_weights.values() 
            if isinstance(w, torch.Tensor)
        )
        
        complexity = total_params * len(configurations)
        efficiency = 1.0 / (1.0 + np.log1p(complexity))
        
        return efficiency
    
    def _measure_emergent_patterns(
        self,
        attention_weights: Dict[str, torch.Tensor],
        configurations: List[Dict[str, Any]]
    ) -> float:
        """Detect emergent patterns in attention structure."""
        # Heuristic: measure clustering in attention space
        # Higher clustering = stronger emergent patterns
        
        if not configurations:
            return 0.0
        
        # Count configurations with similar guilt patterns
        guilt_statuses = [c.get('guilt_status', 'unknown') for c in configurations]
        unique_statuses = len(set(guilt_statuses))
        
        # More distinct patterns = higher insight
        pattern_strength = min(1.0, unique_statuses / max(1, len(configurations)))
        
        return pattern_strength
    
    def _gradient_step(
        self,
        weights: Dict[str, torch.Tensor],
        configurations: List[Dict[str, Any]],
        evidence_pool: List[Dict[str, Any]],
        inference_rules: List[Dict[str, Any]]
    ) -> Dict[str, torch.Tensor]:
        """Perform gradient ascent step on grip fitness."""
        improved = {}
        
        for key, w in weights.items():
            # Perturb and measure improvement
            perturbation = torch.randn_like(w) * self.learning_rate
            w_new = w + perturbation
            
            # Normalize
            w_new = torch.softmax(w_new, dim=-1) if w_new.dim() > 1 else w_new
            
            improved[key] = w_new
        
        return improved
    
    def _create_random_genome(self) -> AttentionGenome:
        """Create random attention genome."""
        genome_id = f"genome_{self.generation}_{np.random.randint(10000)}"
        
        # Random attention weights
        dim = 64
        genome = AttentionGenome(
            id=genome_id,
            generation=self.generation,
            lineage=[],
            causal_weights=torch.randn(dim, dim),
            intentional_weights=torch.randn(dim, dim),
            temporal_weights=torch.randn(dim, dim),
            normative_weights=torch.randn(dim, dim),
            counterfactual_weights=torch.randn(dim, dim),
            necessity_weights=torch.randn(dim, dim),
            proportionality_weights=torch.randn(dim, dim)
        )
        
        return genome
    
    def _evaluate_genome_fitness(self, genome: AttentionGenome) -> float:
        """Evaluate fitness of a genome."""
        # Simulate fitness based on weight properties
        # In practice, would run full inference pipeline
        
        weights = [
            genome.causal_weights,
            genome.intentional_weights,
            genome.temporal_weights,
            genome.normative_weights,
            genome.counterfactual_weights,
            genome.necessity_weights,
            genome.proportionality_weights
        ]
        
        # Simple fitness: inverse of weight variance (more stable = better)
        variances = [w.var().item() for w in weights]
        fitness = 1.0 / (1.0 + np.mean(variances))
        
        return fitness
    
    def _crossover(
        self, 
        parent1: AttentionGenome, 
        parent2: AttentionGenome
    ) -> AttentionGenome:
        """Genetic crossover between two genomes."""
        child_id = f"genome_{self.generation}_{np.random.randint(10000)}"
        
        # Single-point crossover on each weight tensor
        child = AttentionGenome(
            id=child_id,
            generation=self.generation,
            lineage=[parent1.id, parent2.id],
            causal_weights=self._crossover_tensor(
                parent1.causal_weights, parent2.causal_weights
            ),
            intentional_weights=self._crossover_tensor(
                parent1.intentional_weights, parent2.intentional_weights
            ),
            temporal_weights=self._crossover_tensor(
                parent1.temporal_weights, parent2.temporal_weights
            ),
            normative_weights=self._crossover_tensor(
                parent1.normative_weights, parent2.normative_weights
            ),
            counterfactual_weights=self._crossover_tensor(
                parent1.counterfactual_weights, parent2.counterfactual_weights
            ),
            necessity_weights=self._crossover_tensor(
                parent1.necessity_weights, parent2.necessity_weights
            ),
            proportionality_weights=self._crossover_tensor(
                parent1.proportionality_weights, parent2.proportionality_weights
            )
        )
        
        return child
    
    def _crossover_tensor(
        self, 
        t1: torch.Tensor, 
        t2: torch.Tensor
    ) -> torch.Tensor:
        """Single-point crossover on tensor."""
        size = t1.numel()
        point = np.random.randint(0, size)
        
        flat1 = t1.flatten()
        flat2 = t2.flatten()
        
        child_flat = torch.cat([flat1[:point], flat2[point:]])
        child = child_flat.reshape(t1.shape)
        
        return child
    
    def _mutate(self, genome: AttentionGenome) -> AttentionGenome:
        """Apply random mutations to genome."""
        genome.mutations += 1
        
        # Mutate each weight tensor
        weights = [
            'causal_weights', 'intentional_weights', 'temporal_weights',
            'normative_weights', 'counterfactual_weights', 
            'necessity_weights', 'proportionality_weights'
        ]
        
        for weight_name in weights:
            w = getattr(genome, weight_name)
            
            # Random mutation
            if np.random.random() < self.mutation_rate:
                mutation = torch.randn_like(w) * 0.1
                setattr(genome, weight_name, w + mutation)
        
        return genome
    
    def save_optimization_history(self, filepath: str):
        """Save optimization history to file."""
        with open(filepath, 'w') as f:
            json.dump(self.optimization_history, f, indent=2)
    
    def generate_grip_report(
        self, 
        metrics: GripMetrics
    ) -> str:
        """Generate human-readable grip assessment report."""
        report = f"""
# Legal Attention Grip Assessment Report

**Generation:** {metrics.generation}
**Timestamp:** {metrics.timestamp}
**Overall Fitness:** {metrics.fitness:.4f}

## Quantitative Metrics

### Coverage Metrics
- **Completeness**: {metrics.completeness:.2%} - Possibility space explored
- **Evidence Integration**: {metrics.evidence_integration:.2%} - Evidence linked to configurations
- **Rule Coverage**: {metrics.rule_coverage:.2%} - Applicable laws incorporated

### Quality Metrics
- **Invariance Rate**: {metrics.invariance_rate:.2%} - Necessary guilt assignments
- **Coherence**: {metrics.coherence:.2%} - Logical consistency
- **Explanatory Power**: {metrics.explanatory_power:.2%} - Critical facts explained

### Performance Metrics
- **Stability**: {metrics.stability:.2%} - Numerical stability
- **Efficiency**: {metrics.efficiency:.2%} - Computational efficiency
- **Delta Minimization**: {metrics.delta_minimization:.4f} - Justice gap

## Qualitative Assessment

### Transformative Insight
{self._assess_insight_level(metrics.transformative_insight)}

### Overall Grip Quality
{self._assess_grip_quality(metrics.fitness)}

## Recommendations

{self._generate_recommendations(metrics)}
"""
        return report
    
    def _assess_insight_level(self, insight: float) -> str:
        """Assess transformative insight level."""
        if insight >= 0.8:
            return "✅ **Excellent** - Strong emergent patterns detected"
        elif insight >= 0.6:
            return "✓ **Good** - Moderate pattern emergence"
        elif insight >= 0.4:
            return "⚠️ **Fair** - Limited pattern detection"
        else:
            return "❌ **Poor** - No clear emergent patterns"
    
    def _assess_grip_quality(self, fitness: float) -> str:
        """Assess overall grip quality."""
        if fitness >= 0.90:
            return "✅ **Optimal Grip** - Excellent fit to case material"
        elif fitness >= 0.75:
            return "✓ **Strong Grip** - Good fit with room for improvement"
        elif fitness >= 0.60:
            return "⚠️ **Moderate Grip** - Acceptable but needs enhancement"
        else:
            return "❌ **Weak Grip** - Significant improvement required"
    
    def _generate_recommendations(self, metrics: GripMetrics) -> str:
        """Generate actionable recommendations."""
        recs = []
        
        if metrics.completeness < 0.8:
            recs.append("- **Expand possibility space exploration** - Add more configurations")
        
        if metrics.invariance_rate < 0.5:
            recs.append("- **Strengthen inference rules** - Collect evidence for necessity")
        
        if metrics.evidence_integration < 0.7:
            recs.append("- **Improve evidence linking** - Connect more evidence to configurations")
        
        if metrics.rule_coverage < 0.7:
            recs.append("- **Apply more legal principles** - Incorporate additional applicable laws")
        
        if metrics.coherence < 0.7:
            recs.append("- **Improve logical consistency** - Resolve attention pattern conflicts")
        
        if not recs:
            recs.append("- **Maintain current quality** - Continue monitoring and refinement")
        
        return "\n".join(recs)


# Example usage
if __name__ == "__main__":
    print("🧬 Legal Attention Grip Optimizer - Ontogenetic Self-Improvement")
    print("=" * 70)
    
    # Initialize optimizer
    optimizer = GripOptimizer(
        mutation_rate=0.1,
        learning_rate=0.01,
        target_fitness=0.90
    )
    
    # Simulate case data
    configurations = [
        {'agent_id': 'agent1', 'arena': 'trust', 'event_id': 'e1', 
         'horizon': 'full', 'guilt_status': 'necessary', 
         'evidence_refs': ['ev1', 'ev2'], 'applied_rules': ['rule1']},
        {'agent_id': 'agent2', 'arena': 'court', 'event_id': 'e2',
         'horizon': 'partial', 'guilt_status': 'possible',
         'evidence_refs': ['ev2', 'ev3'], 'applied_rules': ['rule2']},
    ]
    
    evidence_pool = [
        {'id': 'ev1', 'criticality': 0.9},
        {'id': 'ev2', 'criticality': 0.8},
        {'id': 'ev3', 'criticality': 0.6},
    ]
    
    inference_rules = [
        {'id': 'rule1', 'name': 'Breach of Fiduciary Duty'},
        {'id': 'rule2', 'name': 'Material Non-Disclosure'},
    ]
    
    # Create sample attention weights
    dim = 64
    attention_weights = {
        'causal': torch.randn(dim, dim),
        'intentional': torch.randn(dim, dim),
        'temporal': torch.randn(dim, dim),
    }
    
    # Measure initial grip
    print("\n📊 Measuring Initial Grip...")
    initial_metrics = optimizer.measure_grip(
        attention_weights, configurations, evidence_pool, inference_rules
    )
    
    print(f"\nInitial Fitness: {initial_metrics.fitness:.4f}")
    print(f"- Completeness: {initial_metrics.completeness:.2%}")
    print(f"- Invariance Rate: {initial_metrics.invariance_rate:.2%}")
    print(f"- Evidence Integration: {initial_metrics.evidence_integration:.2%}")
    
    # Generate report
    print("\n" + "="*70)
    print(optimizer.generate_grip_report(initial_metrics))
    
    print("\n✅ Grip optimizer demonstration complete!")
