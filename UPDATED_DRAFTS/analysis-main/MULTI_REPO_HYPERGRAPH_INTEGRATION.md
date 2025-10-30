# Multi-Repository Hypergraph Integration

**Version:** 1.0.0  
**Date:** October 16, 2025  
**Status:** ✅ Implemented

## Overview

The Multi-Repository Hypergraph Integration extends the existing hypergraph construction capabilities to work across multiple related repositories, enabling ecosystem-wide analysis, cross-repository relationship detection, and unified insights.

## Supported Repositories

This integration supports the following related repositories:

| Repository | Language | Focus | Status |
|------------|----------|-------|--------|
| **cogpy/ad-res-j7** | JavaScript | Civil litigation case management | ✅ Supported |
| **EchoCog/analysss** | Python | Criminal case analysis | ✅ Supported |
| **rzonedevops/analysis** | Python | Evidence automation | ✅ Supported |
| **rzonedevops/avtomaatoctory** | Python | Evidence automation | ✅ Supported |
| **rzonedevops/analyticase** | Python | ML & judiciary integration | ✅ Supported |

## Key Features

### 1. Multi-Repository Analysis
- **Repository Cloning**: Automatically clones configured repositories for analysis
- **Language-Agnostic**: Supports both Python and JavaScript/TypeScript repositories
- **Unified Structure**: Creates a consistent hypergraph structure across all repositories

### 2. Cross-Repository Relationship Detection
- **Shared Concepts**: Identifies frameworks, dependencies, and patterns shared across repositories
- **Cross-Repository Nodes**: Creates special nodes representing concepts found in multiple repositories
- **Cross-Repository Edges**: Links repositories through shared concepts and patterns

### 3. Aggregated Metrics
- **Unified Statistics**: Aggregates metrics across all analyzed repositories
- **Comparative Analysis**: Enables side-by-side comparison of repository characteristics
- **Ecosystem Insights**: Provides insights into the overall project ecosystem

### 4. Visualization
- **Repository Comparison Charts**: Visual comparison of repository sizes and complexity
- **Cross-Repository Network**: Visualization of shared concepts and relationships
- **Metrics Dashboard**: Comprehensive dashboard showing unified statistics
- **Shared Concepts Analysis**: Highlights the most commonly shared frameworks and patterns

## Installation

### Prerequisites

```bash
# Ensure Python 3.8+ is installed
python3 --version

# Install required dependencies
pip install -r requirements.txt
```

### Additional Dependencies

The multi-repo integration requires:
- `matplotlib` - For visualization
- `numpy` - For numerical operations
- `git` - For repository cloning

## Usage

### Basic Usage

Analyze all configured repositories and create a unified hypergraph:

```bash
# Analyze all repositories (will clone if needed)
python3 construct_multi_repo_hypergraph.py --output multi_repo_hypergraph.json

# Use existing local repositories (skip cloning)
python3 construct_multi_repo_hypergraph.py --skip-clone --output multi_repo_hypergraph.json

# Analyze specific repositories only
python3 construct_multi_repo_hypergraph.py --repos rzonedevops/analysis EchoCog/analysss
```

### Visualization

Create visualizations from the generated hypergraph:

```bash
# Generate all visualizations
python3 visualize_multi_repo_hypergraph.py multi_repo_hypergraph.json
```

This creates:
- `multi_repo_comparison.png` - Side-by-side repository comparison
- `multi_repo_relationships.png` - Cross-repository relationship summary
- `multi_repo_metrics_dashboard.png` - Comprehensive metrics dashboard
- `multi_repo_shared_concepts.png` - Top shared concepts visualization

### Advanced Usage

#### Custom Workspace Directory

```bash
# Use a specific directory for cloning repositories
python3 construct_multi_repo_hypergraph.py --workspace /tmp/repos --output results.json
```

#### Programmatic Usage

```python
from construct_multi_repo_hypergraph import (
    MultiRepoHypergraphConstructor,
    RepositoryConfig
)

# Define custom repositories
repositories = [
    RepositoryConfig("owner1", "repo1", "Python", "Description"),
    RepositoryConfig("owner2", "repo2", "JavaScript", "Description"),
]

# Create constructor
constructor = MultiRepoHypergraphConstructor(repositories)

# Build hypergraph
hypergraph = constructor.construct(skip_clone=True)

# Save results
constructor.save("output.json")

# Print summary
constructor.print_summary()
```

## Output Format

### Hypergraph Structure

The multi-repository hypergraph JSON has the following structure:

```json
{
  "metadata": {
    "type": "multi_repository_hypergraph",
    "version": "1.0.0",
    "timestamp": "2025-10-16T...",
    "repositories": ["owner1/repo1", "owner2/repo2"],
    "constructor": "MultiRepoHypergraphConstructor"
  },
  "repositories": {
    "owner/repo": {
      "metadata": { ... },
      "nodes": { ... },
      "edges": [ ... ],
      "statistics": { ... }
    }
  },
  "cross_repo_nodes": {
    "node_id": {
      "id": 123,
      "type": "cross_repo_framework",
      "name": "HyperGNN",
      "repositories": ["repo1", "repo2"],
      "instance_count": 2,
      "instances": [["repo1", 45], ["repo2", 78]]
    }
  },
  "cross_repo_edges": [
    {
      "id": 456,
      "type": "shared_concept",
      "concept": "HyperGNN",
      "repositories": ["repo1", "repo2"],
      "via_node": 123
    }
  ],
  "unified_metrics": {
    "total_repositories": 5,
    "total_nodes": 1234,
    "total_edges": 567,
    "cross_repo_nodes": 15,
    "cross_repo_edges": 30,
    "node_types": { ... },
    "edge_types": { ... }
  }
}
```

## Architecture

### Components

1. **RepositoryConfig**: Configuration for each repository to analyze
2. **MultiRepoHypergraphConstructor**: Main constructor class
   - Phase 1: Repository discovery and preparation
   - Phase 2: Individual repository analysis
   - Phase 3: Cross-repository relationship detection
   - Phase 4: Unified metrics computation

3. **MultiRepoHypergraphVisualizer**: Visualization generator
   - Repository comparison charts
   - Cross-repository network visualization
   - Unified metrics dashboard
   - Shared concepts analysis

### Analysis Phases

#### Phase 1: Repository Discovery
- Clones repositories or discovers local checkouts
- Verifies repository accessibility
- Sets up workspace structure

#### Phase 2: Individual Analysis
- Python repositories: Analyzes `.py` files, detects frameworks
- JavaScript repositories: Analyzes `.js`/`.ts` files, parses `package.json`
- Creates repository-specific hypergraphs with nodes and edges

#### Phase 3: Cross-Repository Detection
- Identifies shared frameworks (e.g., HyperGNN, Flask, GraphQL)
- Creates cross-repository nodes for shared concepts
- Establishes edges linking repositories through shared concepts

#### Phase 4: Metrics Aggregation
- Aggregates node and edge counts
- Computes unified statistics
- Generates comparative metrics

## Integration with Existing Systems

### HyperGraphQL Integration

The multi-repository hypergraph can be integrated with the existing HyperGraphQL API:

```python
# Load multi-repo hypergraph into GraphQL system
from src.api.hypergraphql_project import ProjectHypergraphLoader

loader = ProjectHypergraphLoader()
loader.load_multi_repo_hypergraph('multi_repo_hypergraph.json')

# Query across repositories
query = """
  query {
    crossRepoNodes(type: FRAMEWORK) {
      name
      repositories
      instanceCount
    }
  }
"""
```

### Database Synchronization

The multi-repository data can be synchronized to databases:

```python
# Sync to Supabase/Neon
from src.database_sync.unified_sync import sync_multi_repo_hypergraph

sync_multi_repo_hypergraph('multi_repo_hypergraph.json')
```

## Use Cases

### 1. Ecosystem Analysis
Understand the overall structure and relationships across all related repositories.

```bash
python3 construct_multi_repo_hypergraph.py --output ecosystem.json
python3 visualize_multi_repo_hypergraph.py ecosystem.json
```

### 2. Dependency Tracking
Identify shared dependencies and frameworks across repositories.

```python
# Load hypergraph
with open('multi_repo_hypergraph.json') as f:
    data = json.load(f)

# Find shared frameworks
for node in data['cross_repo_nodes'].values():
    if node['type'] == 'cross_repo_framework':
        print(f"{node['name']}: {node['repositories']}")
```

### 3. Impact Analysis
Determine which repositories would be affected by changes to shared components.

```python
# Identify repositories using a specific framework
framework = "HyperGNN"
affected_repos = [
    node['repositories'] 
    for node in data['cross_repo_nodes'].values()
    if node['name'].lower() == framework.lower()
]
```

### 4. Code Reuse Opportunities
Find code patterns and implementations that could be shared across repositories.

## Best Practices

### Performance Optimization

1. **Use `--skip-clone`** when analyzing local repositories repeatedly
2. **Limit analysis scope** with `--repos` flag for faster iterations
3. **Cache results** by saving JSON output for later visualization

### Repository Selection

1. **Focus on active repositories** for meaningful analysis
2. **Include related repositories** that share common goals or frameworks
3. **Exclude archived repositories** unless historical analysis is needed

### Maintenance

1. **Regular updates**: Re-run analysis periodically to track evolution
2. **Version tracking**: Include version numbers in output filenames
3. **Documentation**: Keep repository configurations up to date

## Troubleshooting

### Clone Failures

If repositories fail to clone:
- Check network connectivity
- Verify repository URLs and accessibility
- Use `--skip-clone` with local checkouts
- Check git credentials for private repositories

### Analysis Errors

If analysis fails:
- Check file permissions
- Verify Python/JavaScript syntax
- Review error logs for specific issues
- Use smaller repository subsets for testing

### Visualization Issues

If visualizations fail:
- Ensure matplotlib is installed: `pip install matplotlib`
- Check output directory permissions
- Verify hypergraph JSON is valid

## Future Enhancements

### Planned Features

1. **GraphQL API Extensions**
   - Full multi-repo query support
   - Cross-repository search
   - Real-time updates

2. **Enhanced Analysis**
   - Code similarity detection
   - Dependency conflict identification
   - Architecture pattern recognition

3. **Interactive Visualizations**
   - Web-based interactive dashboards
   - Drill-down capabilities
   - Real-time repository updates

4. **CI/CD Integration**
   - GitHub Actions workflow
   - Automated analysis on push
   - Pull request impact analysis

## Contributing

To extend the multi-repository integration:

1. **Add new repository configurations** in `DEFAULT_REPOSITORIES`
2. **Implement language-specific analyzers** for new languages
3. **Create custom visualizations** in `MultiRepoHypergraphVisualizer`
4. **Add new relationship detection logic** in cross-repo analysis phase

## References

- [Project Hypergraph Report](PROJECT_HYPERGRAPH_REPORT.md)
- [Cross-Repository Analysis](REPOSITORY_CROSS_LINK_ANALYSIS.md)
- [HyperGraphQL API Documentation](HYPERGRAPHQL_API_DOCUMENTATION.md)
- [Technical Architecture](TECHNICAL_ARCHITECTURE.md)

## License

Same as parent repository license.

---

**Last Updated:** October 16, 2025  
**Version:** 1.0.0  
**Status:** ✅ Production Ready
