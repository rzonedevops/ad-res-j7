# ChainLex Quick Start Guide

**Get optimal grip on the legal frameworks in minutes!**

## 🚀 Installation & Setup

No installation required - ChainLex uses standard Python libraries.

```bash
# Clone the repository
git clone https://github.com/cogpy/chainlex.git
cd chainlex

# Ready to use!
python3 chainlex_api.py
```

## 📚 Basic Usage

### 1. Initialize ChainLex

```python
from chainlex_api import ChainLex

# Create API instance
chainlex = ChainLex()

# Get quick reference
print(chainlex.quick_reference())
```

### 2. Search for Legal Concepts

```python
# Universal search
results = chainlex.search("contract validity")
print(f"Found {len(results['rules'])} rules")

# Search in specific domain
results = chainlex.search("dismissal", domain="labour")
```

### 3. Work with Principles

```python
# Get all principles
all_principles = chainlex.principles.all()

# Get principles by domain
contract_principles = chainlex.principles.by_domain("contract")

# Get specific principle
principle = chainlex.principles.get("pacta-sunt-servanda")

# Search principles
results = chainlex.principles.search("good faith")
```

### 4. Work with Rules

```python
# Get rules by framework
civil_rules = chainlex.rules.by_framework("civ")

# Get rules by domain
labour_rules = chainlex.rules.by_domain("labour")

# Find derived rules
derived = chainlex.rules.derived_from("pacta-sunt-servanda")

# Search rules
results = chainlex.rules.search("unfair dismissal")
```

### 5. Build Inference Chains

```python
# Build inference chain
chain = chainlex.inference.chain(
    "pacta-sunt-servanda",  # Level 1 principle
    "contract-valid?"        # Level 2+ rule
)

# Explain the chain
if chain:
    explanation = chainlex.inference.explain(chain)
    print(explanation)
    
    # Compute confidence
    confidence = chainlex.inference.confidence(chain)
    print(f"Confidence: {confidence}")
```

### 6. Framework Statistics

```python
# Get comprehensive stats
stats = chainlex.stats()

# List all frameworks
frameworks = chainlex.frameworks.list()
for fw in frameworks:
    print(f"{fw['code']}: {fw['name']} - {fw['function_count']} functions")

# Get specific framework details
civil_law = chainlex.frameworks.get("civ")
```

## 🎯 Common Use Cases

### Use Case 1: Contract Law Analysis

```python
chainlex = ChainLex()

# Find contract law principles
principles = chainlex.principles.by_domain("contract")
print("Contract Law Principles:")
for p in principles[:5]:
    print(f"  • {p['name']}")

# Find contract-related rules
rules = chainlex.rules.by_domain("contract")
print(f"\nFound {len(rules)} contract law rules")

# Search for specific concept
results = chainlex.search("offer and acceptance")
```

### Use Case 2: Criminal Law Research

```python
chainlex = ChainLex()

# Get criminal law framework
criminal_law = chainlex.frameworks.get("cri")
print(f"Criminal Law: {criminal_law['function_count']} functions")

# Search for mens rea
results = chainlex.search("mens rea", domain="criminal")

# Find principles
principles = chainlex.principles.by_domain("criminal")
```

### Use Case 3: Labour Law Compliance

```python
chainlex = ChainLex()

# Search for dismissal rules
dismissal_rules = chainlex.search("dismissal", domain="labour")
print(f"Found {len(dismissal_rules['rules'])} dismissal rules")

# Get all labour law rules
labour_rules = chainlex.rules.by_domain("labour")

# Find specific rule
results = chainlex.rules.search("unfair dismissal")
```

### Use Case 4: Cross-Framework Analysis

```python
chainlex = ChainLex()

# Find a principle
principle = "audi-alteram-partem"  # Hear the other side

# Find all rules derived from it
derived = chainlex.rules.derived_from(principle)
print(f"Rules derived from {principle}:")
for rule in derived:
    print(f"  • {rule['framework']}:{rule['name']}")
```

## 🔍 Advanced Features

### Working with the Hypergraph

```python
# Load with hypergraph support (requires NetworkX)
chainlex = ChainLex(load_hypergraph=True)

# Access hypergraph directly
if chainlex.hypergraph:
    # Use hypergraph query methods
    principles = chainlex.hypergraph.find_principles_by_domain("contract")
    
    # Build complex inference chains
    chain = chainlex.hypergraph.build_inference_chain(
        "pacta-sunt-servanda",
        "contract-valid?"
    )
```

### Framework Indexing

```python
from framework_index import FrameworkIndex

# Create comprehensive index
index = FrameworkIndex()

# Export index to JSON
index.export_index("my_index.json")

# Print summary
index.print_summary()

# Search functions
results = index.search_functions("contract", domain="contract")

# Find principles
principles = index.find_principles_by_domain("contract")

# Find derived rules
derived = index.find_derived_rules("pacta-sunt-servanda")
```

## 📖 Framework Reference

### Available Frameworks

| Code | Framework | Functions | Level |
|------|-----------|-----------|-------|
| `lv1` | Level 1 Principles | 197 | 1 |
| `civ` | Civil Law (ZA) | 395 | 2 |
| `cri` | Criminal Law (ZA) | 326 | 2 |
| `con` | Constitutional Law (ZA) | 4 | 2 |
| `adm` | Administrative Law (ZA) | 213 | 2 |
| `lab` | Labour Law (ZA) | 366 | 2 |
| `env` | Environmental Law (ZA) | 306 | 2 |
| `cst` | Construction Law (ZA) | 349 | 2 |
| `int` | International Law (ZA) | 356 | 2 |

### Available Domains

- **contract** - Contract law (offer, acceptance, breach, remedies)
- **delict** - Tort law (negligence, damages, causation)
- **property** - Property law (ownership, possession, transfer)
- **family** - Family law (marriage, divorce, custody)
- **criminal** - Criminal law (actus reus, mens rea, defenses)
- **constitutional** - Constitutional law (rights, limitations)
- **administrative** - Administrative law (PAJA, judicial review)
- **labour** - Labour law (dismissal, strikes, collective bargaining)
- **employment** - Employment law (contracts, conditions)
- **environmental** - Environmental law (NEMA, EIA, pollution)
- **construction** - Construction law (JBCC, FIDIC, claims)
- **international** - International law (treaties, customary law)

## 🎓 Understanding the System

### Inference Levels

ChainLex uses a multi-level inference architecture:

1. **Level 1**: First-order principles (e.g., pacta-sunt-servanda)
   - Confidence: 1.0 (explicitly stated)
   - 60+ universal legal maxims

2. **Level 2+**: Jurisdiction-specific rules
   - Confidence: 0.95 (derived)
   - 2,349 functions across 8 frameworks

### Inference Types

- **Deductive** (0.95 factor): Conclusion necessarily follows
- **Inductive** (0.80 factor): Conclusion probably follows
- **Abductive** (0.70 factor): Best explanation
- **Analogical** (0.65 factor): Reasoning by similarity

### Confidence Computation

```python
# Level 1 principle: 1.0
# → Deductive inference (×0.95)
# Level 2 rule: 0.95
# → Deductive inference (×0.95)
# Level 3 application: 0.9025

chain = chainlex.inference.chain(principle, rule)
confidence = chainlex.inference.confidence(
    chain,
    inference_types=['deductive', 'deductive']
)
print(f"Confidence: {confidence}")  # 0.9025
```

## 💡 Tips & Best Practices

### 1. Start with Domains

Always start by exploring domains to understand scope:

```python
stats = chainlex.stats()
for domain, info in stats['domains'].items():
    print(f"{domain}: {info['function_count']} functions")
```

### 2. Use Search for Discovery

Use the search function to discover relevant concepts:

```python
# Broad search
results = chainlex.search("contract")

# Specific search
results = chainlex.search("breach of contract", domain="contract")
```

### 3. Trace Principles to Rules

Always trace rules back to principles for understanding:

```python
# Find a rule
rule = chainlex.rules.search("contract-valid?")[0]

# Find its principle references
cross_refs = rule.get('cross_references', [])
for ref in cross_refs:
    principle = chainlex.principles.get(ref)
    if principle:
        print(f"Based on: {ref}")
```

### 4. Export for Offline Use

Export the index for offline analysis:

```python
from framework_index import FrameworkIndex

index = FrameworkIndex()
index.export_index("framework_index.json")

# Load later
import json
with open("framework_index.json") as f:
    data = json.load(f)
```

## 🔧 Troubleshooting

### Issue: "Module not found"

```python
# Make sure you're in the chainlex directory
import os
os.chdir('/path/to/chainlex')

from chainlex_api import ChainLex
```

### Issue: "Hypergraph not loading"

```python
# Hypergraph requires NetworkX
# Install with: pip install networkx

chainlex = ChainLex(load_hypergraph=True)
```

### Issue: "No results found"

```python
# Check available domains
stats = chainlex.stats()
print(stats['domains'].keys())

# Try broader search
results = chainlex.search("contract")
```

## 📚 Further Reading

- [README.md](README.md) - Repository overview
- [IMPLEMENTATION_GUIDE.md](IMPLEMENTATION_GUIDE.md) - Implementation details
- [ENHANCEMENTS.md](ENHANCEMENTS.md) - Framework enhancements
- [hypergraph/README.md](hypergraph/README.md) - Hypergraph documentation

## 🤝 Contributing

To extend the frameworks:

1. Add functions to appropriate `.scm` files
2. Include cross-references to Level 1 principles
3. Add comprehensive docstrings
4. Rebuild the index: `python3 framework_index.py`
5. Test with the API: `python3 chainlex_api.py`

## 📝 License

MIT License - See LICENSE file

---

**ChainLex**: Where legal reasoning meets optimal grip through comprehensive indexing and intuitive APIs.
