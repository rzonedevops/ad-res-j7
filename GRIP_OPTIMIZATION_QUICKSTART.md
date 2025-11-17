# Grip Optimization Quick Reference

**Quick access to grip optimization features for optimal lex context and case content analysis.**

## 🚀 Quick Start (3 Steps)

```bash
# 1. Setup grip tables
npm run db:grip:setup

# 2. View current grip
npm run db:grip:stats

# 3. Run demo
npm run db:grip:demo
```

## 📊 Core Commands

### Database Operations
```bash
npm run db:grip:setup       # Create grip metrics tables (6 tables)
npm run db:grip:stats        # View grip statistics
npm run db:grip:demo         # Run comprehensive demo
```

### Testing
```bash
npm run test:grip-optimization   # Run grip optimization tests
```

### Python API
```bash
# Measure and optimize grip
python legal_attention_grip_optimizer.py
```

## 📈 Grip Metrics Overview

### Quantitative (0-1 scale)
- **Completeness**: Possibility space coverage
- **Invariance Rate**: Necessary guilt assignments
- **Evidence Integration**: Evidence-config linkage
- **Rule Coverage**: Applied legal principles

### Qualitative (0-1 scale)
- **Coherence**: Logical consistency
- **Explanatory Power**: Fact coverage
- **Transformative Insight**: Pattern emergence

### Target: **Fitness ≥ 0.90** (Optimal Grip)

## 🧬 Key Features

### 1. Self-Assessment
Continuously measure grip quality across 12 dimensions.

### 2. Self-Optimization
Iteratively improve attention patterns via gradient ascent.

### 3. Self-Evolution
Apply genetic algorithms for population-level optimization.

### 4. Gap Detection
Automatically identify evidence gaps limiting grip.

### 5. Invariance Tracking
Monitor progress toward necessary guilt properties.

## 📝 Common Workflows

### Initial Assessment
```bash
npm run db:lex:demo          # Analyze case
npm run db:grip:stats        # Check grip quality
```

### Optimization Loop
```python
from legal_attention_grip_optimizer import GripOptimizer

optimizer = GripOptimizer(target_fitness=0.90)
optimized_weights, history = optimizer.optimize_grip(
    current_weights, configurations, 
    evidence_pool, inference_rules
)
```

### Track Progress
```javascript
const GripManager = require('./db/grip-manager');
const manager = new GripManager();

// Record assessment
await manager.recordAssessment(metrics);

// Identify gaps
const gaps = await manager.identifyEvidenceGaps(assessmentId);

// Track invariance
await manager.trackInvariance({
    agent_id: 'bantjies',
    guilt_charge: 'breach_fiduciary_duty',
    status: 'possible',
    invariance_percentage: 0.46
});
```

## 🎯 Fitness Interpretation

| Score | Quality | Action |
|-------|---------|--------|
| ≥0.90 | ✅ Optimal | Maintain |
| 0.75-0.89 | ✓ Strong | Minor improvements |
| 0.60-0.74 | ⚠️ Moderate | Optimize |
| <0.60 | ❌ Weak | Major work needed |

## 🔧 Troubleshooting

### Low fitness (<0.60)
```bash
# 1. Check data quality
npm run db:hierarchy:stats
npm run db:hypergraph:stats

# 2. Increase optimization iterations
# Edit learning_rate in Python code

# 3. Run evolution
# Use genetic algorithm approach
```

### Slow convergence
```bash
# Adjust parameters:
# - Increase learning_rate (0.05-0.10)
# - Use evolutionary approach
# - Add diverse initial population
```

## 📚 Documentation

- **Complete Guide**: `GRIP_OPTIMIZATION_GUIDE.md`
- **Python API**: `legal_attention_grip_optimizer.py`
- **Node.js API**: `db/grip-manager.js`
- **Database Schema**: `db/grip-metrics-migrate.js`
- **Tests**: `tests/grip-optimization.test.js`

## 🔗 Integration

### LexiCog Agent
```javascript
// Integrate with LexiCog workflow
const lexicog = new LexiCogAgent();
const gripManager = new GripManager();

// Analyze → Measure → Optimize → Re-analyze
```

### Lex Inference Engine
```bash
npm run db:lex:demo          # Run lex analysis
npm run db:grip:stats        # Measure grip
# Optimize based on recommendations
npm run db:lex:analyze       # Re-analyze
```

## 📊 Database Tables (6)

1. **grip_assessments** - Comprehensive metrics per generation
2. **attention_genomes** - Genetic attention patterns
3. **optimization_history** - Optimization tracking
4. **evidence_gap_analysis** - Gap identification
5. **invariance_tracking** - Progress toward necessity
6. **grip_evolution_timeline** - Temporal fitness tracking

## 💡 Pro Tips

1. **Start with demo**: `npm run db:grip:demo`
2. **Monitor evolution**: Check grip_evolution_timeline
3. **Address gaps first**: Highest priority = biggest impact
4. **Track invariance**: Focus on necessary guilt properties
5. **Iterate frequently**: Continuous improvement cycle

## 🎓 Key Concepts

- **Grip**: Quality of fit to case material
- **Fitness**: Weighted combination of 12 metrics
- **Invariance**: Guilt that holds in ALL configurations
- **Ontogenesis**: Self-generating, evolving mechanism
- **Genome**: Genetic encoding of attention patterns

## ⚡ One-Liners

```bash
# Quick health check
npm run db:grip:stats | grep "Fitness"

# Full demo with output
npm run db:grip:demo > grip_demo_output.txt

# Run tests
npm run test:grip-optimization

# Setup everything
npm run db:migrate && npm run db:grip:setup && npm run db:grip:demo
```

## 🆘 Support

1. Check `GRIP_OPTIMIZATION_GUIDE.md`
2. Run `npm run db:grip:demo`
3. Review test output: `npm run test:grip-optimization`
4. Verify DB connection: `npm run db:test`

---

**Status**: ✅ OPERATIONAL  
**Version**: 1.0.0  
**Integration**: Full lex database + inference engine
