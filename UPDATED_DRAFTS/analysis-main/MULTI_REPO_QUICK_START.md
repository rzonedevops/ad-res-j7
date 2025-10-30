# Multi-Repository Hypergraph - Quick Start Guide

**Quick reference for multi-repository hypergraph integration**

## 🚀 Quick Start (30 seconds)

```bash
# Run the automated analysis workflow
./examples/analyze_ecosystem.sh --skip-clone

# View results in analysis_outputs/
```

## 📋 Common Commands

### Basic Analysis

```bash
# Analyze all default repositories (will clone)
python3 construct_multi_repo_hypergraph.py --output results.json

# Use existing local repositories (faster)
python3 construct_multi_repo_hypergraph.py --skip-clone --output results.json

# Analyze specific repositories only
python3 construct_multi_repo_hypergraph.py \
  --repos rzonedevops/analysis EchoCog/analysss \
  --output custom.json
```

### Visualization

```bash
# Generate all visualizations from hypergraph
python3 visualize_multi_repo_hypergraph.py results.json

# Outputs 4 PNG files:
# - multi_repo_comparison.png
# - multi_repo_relationships.png
# - multi_repo_metrics_dashboard.png
# - multi_repo_shared_concepts.png (if applicable)
```

### Demo

```bash
# Run interactive demo
python3 examples/multi_repo_hypergraph_demo.py
```

## 📊 Supported Repositories

| Repository | Language | Focus |
|------------|----------|-------|
| cogpy/ad-res-j7 | JavaScript | Civil litigation |
| EchoCog/analysss | Python | Criminal case analysis |
| rzonedevops/analysis | Python | Evidence automation |
| rzonedevops/avtomaatoctory | Python | Evidence automation |
| rzonedevops/analyticase | Python | ML & judiciary |

## 📁 Output Files

### Generated Automatically

- `multi_repo_hypergraph.json` - Complete hypergraph data
- `multi_repo_comparison.png` - Repository comparison chart
- `multi_repo_relationships.png` - Cross-repo relationships
- `multi_repo_metrics_dashboard.png` - Unified metrics
- `multi_repo_shared_concepts.png` - Shared frameworks/concepts
- `ecosystem_report_TIMESTAMP.txt` - Summary report

### JSON Structure

```json
{
  "metadata": { "type": "multi_repository_hypergraph", ... },
  "repositories": {
    "owner/repo": {
      "nodes": { ... },
      "edges": [ ... ],
      "statistics": { ... }
    }
  },
  "cross_repo_nodes": { ... },
  "cross_repo_edges": [ ... ],
  "unified_metrics": { ... }
}
```

## 🔧 Advanced Usage

### Custom Repository Configuration

```python
from construct_multi_repo_hypergraph import (
    MultiRepoHypergraphConstructor,
    RepositoryConfig
)

# Define custom repositories
repos = [
    RepositoryConfig("owner", "repo1", "Python", "Description"),
    RepositoryConfig("owner", "repo2", "JavaScript", "Description"),
]

# Analyze
constructor = MultiRepoHypergraphConstructor(repos)
hypergraph = constructor.construct(skip_clone=True)
constructor.save("output.json")
```

### Programmatic Analysis

```python
import json

# Load hypergraph
with open('multi_repo_hypergraph.json') as f:
    data = json.load(f)

# Access metrics
metrics = data['unified_metrics']
print(f"Total Repositories: {metrics['total_repositories']}")
print(f"Total Nodes: {metrics['total_nodes']}")

# Find shared concepts
for node in data['cross_repo_nodes'].values():
    if node['type'] == 'cross_repo_framework':
        print(f"{node['name']}: {node['repositories']}")
```

### Custom Workspace

```bash
# Use specific directory for cloning
export WORKSPACE_DIR=/path/to/workspace
./examples/analyze_ecosystem.sh

# Or with CLI
python3 construct_multi_repo_hypergraph.py \
  --workspace /path/to/workspace \
  --output results.json
```

## 🐛 Troubleshooting

### Clone Failures

```bash
# Use local repos instead
python3 construct_multi_repo_hypergraph.py --skip-clone

# Or check network/credentials
git clone https://github.com/owner/repo.git
```

### Missing Dependencies

```bash
# Install matplotlib for visualization
pip install matplotlib seaborn

# Install all dependencies
pip install -r requirements.txt
```

### Permission Errors

```bash
# Make scripts executable
chmod +x construct_multi_repo_hypergraph.py
chmod +x visualize_multi_repo_hypergraph.py
chmod +x examples/analyze_ecosystem.sh
```

## 📚 Documentation

- **Full Documentation**: [MULTI_REPO_HYPERGRAPH_INTEGRATION.md](MULTI_REPO_HYPERGRAPH_INTEGRATION.md)
- **Cross-Repo Analysis**: [REPOSITORY_CROSS_LINK_ANALYSIS.md](REPOSITORY_CROSS_LINK_ANALYSIS.md)
- **Main README**: [README.md](README.md)

## ⚡ Performance Tips

1. **Use `--skip-clone`** for repeated analysis (10x faster)
2. **Limit repositories** with `--repos` for focused analysis
3. **Custom workspace** to avoid repeated cloning
4. **Generated files** are cached in workspace directory

## 🎯 Common Use Cases

### Ecosystem Overview

```bash
# Analyze all repositories
./examples/analyze_ecosystem.sh --skip-clone

# View dashboard: analysis_outputs/multi_repo_metrics_dashboard.png
```

### Shared Dependencies

```python
# Find common frameworks
for node in data['cross_repo_nodes'].values():
    print(f"{node['name']}: {len(node['repositories'])} repos")
```

### Repository Comparison

```bash
# Generate comparison chart
python3 visualize_multi_repo_hypergraph.py results.json

# View: multi_repo_comparison.png
```

### Impact Analysis

```python
# Find repos using specific framework
framework = "HyperGNN"
for node in data['cross_repo_nodes'].values():
    if node['name'].lower() == framework.lower():
        print(f"Used in: {node['repositories']}")
```

## 🧪 Testing

```bash
# Run test suite
python3 tests/test_multi_repo_hypergraph.py

# Should see: Ran 15 tests - OK
```

## 🔄 Workflow Examples

### Daily Analysis

```bash
# Automated daily ecosystem snapshot
./examples/analyze_ecosystem.sh --skip-clone
mv analysis_outputs/multi_repo_hypergraph.json \
   archive/snapshot_$(date +%Y%m%d).json
```

### CI/CD Integration

```yaml
# .github/workflows/analyze-ecosystem.yml
name: Ecosystem Analysis
on:
  schedule:
    - cron: '0 0 * * *'  # Daily
jobs:
  analyze:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - run: ./examples/analyze_ecosystem.sh --skip-clone
      - uses: actions/upload-artifact@v3
        with:
          name: analysis-results
          path: analysis_outputs/
```

## 💡 Tips

- Generate fresh analysis before important decisions
- Track changes over time by archiving results
- Use visualizations in reports and presentations
- Cross-reference with individual repo analysis
- Share ecosystem insights with team members

## 🆘 Getting Help

- Check documentation: `MULTI_REPO_HYPERGRAPH_INTEGRATION.md`
- Run demo: `python3 examples/multi_repo_hypergraph_demo.py`
- View test examples: `tests/test_multi_repo_hypergraph.py`
- Review code comments in source files

---

**Last Updated**: October 16, 2025  
**Version**: 1.0.0  
**Status**: Production Ready ✅
