#!/usr/bin/env python3
"""
Multi-Repository Hypergraph Constructor
========================================

Constructs a unified hypergraph representation across multiple related repositories,
enabling cross-repository analysis, relationship detection, and ecosystem-wide insights.

Supported Repositories:
- cogpy/ad-res-j7 (JavaScript/Node.js - Civil litigation)
- EchoCog/analysss (Python - Criminal case analysis)
- rzonedevops/analysis (Python - Evidence automation)
- rzonedevops/avtomaatoctory (Python - Evidence automation)
- rzonedevops/analyticase (Python - ML & judiciary integration)
"""

import json
import logging
import os
import subprocess
import tempfile
from collections import defaultdict
from datetime import datetime, timezone
from pathlib import Path
from typing import Any, Dict, List, Optional, Set, Tuple

# Configure logging
logging.basicConfig(
    level=logging.INFO, format="%(asctime)s - %(levelname)s - %(message)s"
)
logger = logging.getLogger(__name__)


class RepositoryConfig:
    """Configuration for a repository to analyze"""

    def __init__(
        self,
        owner: str,
        name: str,
        language: str,
        focus: str,
        url: Optional[str] = None,
    ):
        self.owner = owner
        self.name = name
        self.language = language
        self.focus = focus
        self.url = url or f"https://github.com/{owner}/{name}.git"
        self.full_name = f"{owner}/{name}"

    def __repr__(self):
        return f"RepositoryConfig({self.full_name}, {self.language})"


# Default repository configurations
DEFAULT_REPOSITORIES = [
    RepositoryConfig(
        "cogpy", "ad-res-j7", "JavaScript", "Civil litigation case management"
    ),
    RepositoryConfig("EchoCog", "analysss", "Python", "Criminal case analysis"),
    RepositoryConfig("rzonedevops", "analysis", "Python", "Evidence automation"),
    RepositoryConfig("rzonedevops", "avtomaatoctory", "Python", "Evidence automation"),
    RepositoryConfig(
        "rzonedevops", "analyticase", "Python", "ML & judiciary integration"
    ),
]


class MultiRepoHypergraphConstructor:
    """Constructs a unified hypergraph across multiple repositories"""

    def __init__(
        self, repositories: List[RepositoryConfig], workspace_dir: Optional[str] = None
    ):
        self.repositories = repositories
        self.workspace_dir = (
            Path(workspace_dir)
            if workspace_dir
            else Path(tempfile.mkdtemp(prefix="multi_repo_"))
        )
        self.repo_paths = {}

        # Multi-repo hypergraph structure
        self.multi_hypergraph = {
            "metadata": {
                "type": "multi_repository_hypergraph",
                "version": "1.0.0",
                "timestamp": datetime.now(timezone.utc).isoformat(),
                "repositories": [r.full_name for r in repositories],
                "constructor": "MultiRepoHypergraphConstructor",
            },
            "repositories": {},  # Per-repository hypergraphs
            "cross_repo_nodes": {},  # Nodes that span repositories
            "cross_repo_edges": [],  # Edges connecting repositories
            "unified_metrics": {},
        }

        # Tracking structures
        self.node_id_counter = 0
        self.edge_id_counter = 0
        self.shared_concepts = defaultdict(list)  # Concept -> list of (repo, node_id)

    def construct(self, skip_clone: bool = False) -> Dict[str, Any]:
        """
        Main construction method

        Args:
            skip_clone: If True, uses existing local checkouts instead of cloning
        """
        logger.info("=" * 80)
        logger.info("CONSTRUCTING MULTI-REPOSITORY HYPERGRAPH")
        logger.info("=" * 80)

        # Phase 1: Repository Discovery & Preparation
        logger.info(f"\n📦 Phase 1: Preparing {len(self.repositories)} repositories...")
        if not skip_clone:
            self._clone_repositories()
        else:
            self._discover_local_repositories()

        # Phase 2: Individual Repository Analysis
        logger.info("\n🔍 Phase 2: Analyzing individual repositories...")
        self._analyze_repositories()

        # Phase 3: Cross-Repository Relationship Detection
        logger.info("\n🔗 Phase 3: Detecting cross-repository relationships...")
        self._detect_cross_repo_relationships()

        # Phase 4: Unified Metrics Computation
        logger.info("\n📊 Phase 4: Computing unified metrics...")
        self._compute_unified_metrics()

        logger.info("\n✅ Multi-repository hypergraph construction complete!")
        return self.multi_hypergraph

    def _clone_repositories(self):
        """Clone all configured repositories"""
        for repo in self.repositories:
            repo_dir = self.workspace_dir / repo.name

            if repo_dir.exists():
                logger.info(f"⏭️  {repo.full_name}: Already exists at {repo_dir}")
                self.repo_paths[repo.full_name] = repo_dir
                continue

            try:
                logger.info(f"📥 Cloning {repo.full_name}...")
                result = subprocess.run(
                    ["git", "clone", "--depth", "1", repo.url, str(repo_dir)],
                    capture_output=True,
                    text=True,
                    timeout=300,
                )

                if result.returncode == 0:
                    logger.info(f"✅ {repo.full_name}: Cloned successfully")
                    self.repo_paths[repo.full_name] = repo_dir
                else:
                    logger.error(f"❌ {repo.full_name}: Clone failed - {result.stderr}")

            except subprocess.TimeoutExpired:
                logger.error(f"❌ {repo.full_name}: Clone timeout")
            except Exception as e:
                logger.error(f"❌ {repo.full_name}: Clone error - {e}")

    def _discover_local_repositories(self):
        """Discover locally available repositories"""
        # Check current directory and parent
        search_paths = [
            Path.cwd(),
            Path.cwd().parent,
            Path.cwd().parent.parent,
        ]

        for repo in self.repositories:
            found = False
            for search_path in search_paths:
                potential_path = search_path / repo.name
                if potential_path.exists() and (potential_path / ".git").exists():
                    logger.info(f"✅ {repo.full_name}: Found at {potential_path}")
                    self.repo_paths[repo.full_name] = potential_path
                    found = True
                    break

            if not found:
                logger.warning(f"⚠️  {repo.full_name}: Not found locally")

    def _analyze_repositories(self):
        """Analyze each repository and build individual hypergraphs"""
        for repo in self.repositories:
            if repo.full_name not in self.repo_paths:
                logger.warning(f"⏭️  {repo.full_name}: Skipping (not available)")
                continue

            repo_path = self.repo_paths[repo.full_name]
            logger.info(f"\n🔍 Analyzing {repo.full_name}...")

            # Build repository hypergraph
            repo_hypergraph = self._build_repo_hypergraph(repo, repo_path)
            self.multi_hypergraph["repositories"][repo.full_name] = repo_hypergraph

            # Extract shared concepts
            self._extract_shared_concepts(repo, repo_hypergraph)

    def _build_repo_hypergraph(
        self, repo: RepositoryConfig, repo_path: Path
    ) -> Dict[str, Any]:
        """Build hypergraph for a single repository"""
        hypergraph = {
            "metadata": {
                "repository": repo.full_name,
                "language": repo.language,
                "focus": repo.focus,
                "path": str(repo_path),
                "analyzed_at": datetime.now(timezone.utc).isoformat(),
            },
            "nodes": {},
            "edges": [],
            "statistics": {},
        }

        try:
            # Analyze based on language
            if repo.language == "Python":
                self._analyze_python_repo(repo, repo_path, hypergraph)
            elif repo.language == "JavaScript":
                self._analyze_javascript_repo(repo, repo_path, hypergraph)
            else:
                logger.warning(
                    f"⚠️  {repo.full_name}: Unsupported language {repo.language}"
                )

            # Compute basic statistics
            hypergraph["statistics"] = {
                "node_count": len(hypergraph["nodes"]),
                "edge_count": len(hypergraph["edges"]),
                "node_types": self._count_types(hypergraph["nodes"]),
                "edge_types": self._count_edge_types(hypergraph["edges"]),
            }

        except Exception as e:
            logger.error(f"❌ {repo.full_name}: Analysis error - {e}")

        return hypergraph

    def _analyze_python_repo(
        self, repo: RepositoryConfig, repo_path: Path, hypergraph: Dict
    ):
        """Analyze a Python repository"""
        # Find Python files
        py_files = list(repo_path.rglob("*.py"))
        py_files = [
            f for f in py_files if ".git" not in str(f) and "node_modules" not in str(f)
        ]

        logger.info(f"   📝 Found {len(py_files)} Python files")

        # Analyze key directories
        key_dirs = ["src", "tests", "models", "frameworks", "tools", "api"]
        for dir_name in key_dirs:
            dir_path = repo_path / dir_name
            if dir_path.exists():
                node_id = self._add_node(
                    hypergraph,
                    "directory",
                    dir_name,
                    {
                        "path": str(dir_path.relative_to(repo_path)),
                        "file_count": len(list(dir_path.rglob("*.py"))),
                    },
                )

        # Sample some Python files for patterns
        for py_file in py_files[:20]:  # Limit for performance
            try:
                rel_path = py_file.relative_to(repo_path)
                node_id = self._add_node(
                    hypergraph,
                    "python_file",
                    py_file.name,
                    {"path": str(rel_path), "size": py_file.stat().st_size},
                )

                # Look for key patterns in content
                with open(py_file, "r", encoding="utf-8", errors="ignore") as f:
                    content = f.read()

                    # Detect key frameworks/patterns
                    if "hypergnn" in content.lower():
                        self._add_node(
                            hypergraph, "framework", "HyperGNN", {"file": str(rel_path)}
                        )
                    if "flask" in content.lower() or "@app.route" in content:
                        self._add_node(
                            hypergraph, "framework", "Flask", {"file": str(rel_path)}
                        )
                    if "graphql" in content.lower():
                        self._add_node(
                            hypergraph, "framework", "GraphQL", {"file": str(rel_path)}
                        )

            except Exception as e:
                logger.debug(f"   ⚠️  Error analyzing {py_file.name}: {e}")

    def _analyze_javascript_repo(
        self, repo: RepositoryConfig, repo_path: Path, hypergraph: Dict
    ):
        """Analyze a JavaScript repository"""
        # Find JavaScript files
        js_files = list(repo_path.rglob("*.js")) + list(repo_path.rglob("*.ts"))
        js_files = [
            f for f in js_files if ".git" not in str(f) and "node_modules" not in str(f)
        ]

        logger.info(f"   📝 Found {len(js_files)} JavaScript/TypeScript files")

        # Check for package.json
        package_json = repo_path / "package.json"
        if package_json.exists():
            try:
                with open(package_json, "r") as f:
                    pkg_data = json.load(f)

                    # Add dependencies as nodes
                    deps = pkg_data.get("dependencies", {})
                    for dep_name in list(deps.keys())[:10]:  # Limit
                        self._add_node(
                            hypergraph,
                            "dependency",
                            dep_name,
                            {"version": deps[dep_name], "type": "npm"},
                        )
            except Exception as e:
                logger.debug(f"   ⚠️  Error reading package.json: {e}")

        # Sample some JS files
        for js_file in js_files[:20]:  # Limit for performance
            try:
                rel_path = js_file.relative_to(repo_path)
                self._add_node(
                    hypergraph,
                    "javascript_file",
                    js_file.name,
                    {"path": str(rel_path), "size": js_file.stat().st_size},
                )
            except Exception as e:
                logger.debug(f"   ⚠️  Error analyzing {js_file.name}: {e}")

    def _add_node(
        self, hypergraph: Dict, node_type: str, name: str, properties: Dict
    ) -> int:
        """Add a node to a repository hypergraph"""
        node_id = self.node_id_counter
        self.node_id_counter += 1

        hypergraph["nodes"][node_id] = {
            "id": node_id,
            "type": node_type,
            "name": name,
            "properties": properties,
        }

        return node_id

    def _add_edge(
        self,
        hypergraph: Dict,
        edge_type: str,
        source: int,
        targets: List[int],
        properties: Dict = None,
    ):
        """Add an edge to a repository hypergraph"""
        edge_id = self.edge_id_counter
        self.edge_id_counter += 1

        hypergraph["edges"].append(
            {
                "id": edge_id,
                "type": edge_type,
                "source": source,
                "targets": targets,
                "properties": properties or {},
            }
        )

        return edge_id

    def _count_types(self, nodes: Dict) -> Dict[str, int]:
        """Count node types"""
        counts = defaultdict(int)
        for node in nodes.values():
            counts[node["type"]] += 1
        return dict(counts)

    def _count_edge_types(self, edges: List) -> Dict[str, int]:
        """Count edge types"""
        counts = defaultdict(int)
        for edge in edges:
            counts[edge["type"]] += 1
        return dict(counts)

    def _extract_shared_concepts(self, repo: RepositoryConfig, repo_hypergraph: Dict):
        """Extract concepts that might be shared across repositories"""
        seen_concepts_this_repo = set()
        for node in repo_hypergraph["nodes"].values():
            # Identify shared concepts based on type and name
            if node["type"] in ["framework", "dependency"]:
                concept_key = f"{node['type']}:{node['name'].lower()}"
                # Only add once per repository to avoid duplicates
                if concept_key not in seen_concepts_this_repo:
                    self.shared_concepts[concept_key].append(
                        (repo.full_name, node["id"])
                    )
                    seen_concepts_this_repo.add(concept_key)

    def _detect_cross_repo_relationships(self):
        """Detect relationships between repositories"""
        logger.info(f"   🔍 Found {len(self.shared_concepts)} shared concepts")

        # Create cross-repository nodes for shared concepts
        for concept_key, repo_nodes in self.shared_concepts.items():
            if len(repo_nodes) > 1:  # Shared across multiple repos
                concept_type, concept_name = concept_key.split(":", 1)

                # Create a cross-repo node
                cross_node_id = self.node_id_counter
                self.node_id_counter += 1

                self.multi_hypergraph["cross_repo_nodes"][cross_node_id] = {
                    "id": cross_node_id,
                    "type": f"cross_repo_{concept_type}",
                    "name": concept_name,
                    "repositories": [repo for repo, _ in repo_nodes],
                    "instance_count": len(repo_nodes),
                    "instances": repo_nodes,
                }

                # Create edges connecting the repos through this concept
                for i, (repo1, node1) in enumerate(repo_nodes):
                    for repo2, node2 in repo_nodes[i + 1 :]:
                        edge_id = self.edge_id_counter
                        self.edge_id_counter += 1

                        self.multi_hypergraph["cross_repo_edges"].append(
                            {
                                "id": edge_id,
                                "type": "shared_concept",
                                "concept": concept_name,
                                "repositories": [repo1, repo2],
                                "via_node": cross_node_id,
                            }
                        )

        logger.info(
            f"   ✅ Created {len(self.multi_hypergraph['cross_repo_nodes'])} cross-repo nodes"
        )
        logger.info(
            f"   ✅ Created {len(self.multi_hypergraph['cross_repo_edges'])} cross-repo edges"
        )

    def _compute_unified_metrics(self):
        """Compute metrics across all repositories"""
        total_nodes = 0
        total_edges = 0
        all_node_types = defaultdict(int)
        all_edge_types = defaultdict(int)

        # Aggregate from individual repositories
        for repo_name, repo_hg in self.multi_hypergraph["repositories"].items():
            stats = repo_hg["statistics"]
            total_nodes += stats["node_count"]
            total_edges += stats["edge_count"]

            for node_type, count in stats["node_types"].items():
                all_node_types[node_type] += count

            for edge_type, count in stats["edge_types"].items():
                all_edge_types[edge_type] += count

        # Add cross-repo nodes and edges
        total_nodes += len(self.multi_hypergraph["cross_repo_nodes"])
        total_edges += len(self.multi_hypergraph["cross_repo_edges"])

        self.multi_hypergraph["unified_metrics"] = {
            "total_repositories": len(self.multi_hypergraph["repositories"]),
            "total_nodes": total_nodes,
            "total_edges": total_edges,
            "cross_repo_nodes": len(self.multi_hypergraph["cross_repo_nodes"]),
            "cross_repo_edges": len(self.multi_hypergraph["cross_repo_edges"]),
            "node_types": dict(all_node_types),
            "edge_types": dict(all_edge_types),
            "repositories_analyzed": list(self.multi_hypergraph["repositories"].keys()),
        }

    def save(self, output_file: str):
        """Save multi-repository hypergraph to JSON file"""
        output_path = Path(output_file)
        output_path.parent.mkdir(parents=True, exist_ok=True)

        with open(output_path, "w") as f:
            json.dump(self.multi_hypergraph, f, indent=2)
        logger.info(f"\n💾 Multi-repository hypergraph saved to: {output_file}")

    def print_summary(self):
        """Print a summary of the multi-repository hypergraph"""
        print("\n" + "=" * 80)
        print("MULTI-REPOSITORY HYPERGRAPH SUMMARY")
        print("=" * 80)

        metrics = self.multi_hypergraph["unified_metrics"]
        print(f"\n📊 Overall Statistics:")
        print(f"   Repositories Analyzed: {metrics['total_repositories']}")
        print(f"   Total Nodes: {metrics['total_nodes']}")
        print(f"   Total Edges: {metrics['total_edges']}")
        print(f"   Cross-Repo Nodes: {metrics['cross_repo_nodes']}")
        print(f"   Cross-Repo Edges: {metrics['cross_repo_edges']}")

        print(f"\n📦 Repository Details:")
        for repo_name, repo_hg in self.multi_hypergraph["repositories"].items():
            stats = repo_hg["statistics"]
            print(f"   • {repo_name}:")
            print(f"     - Nodes: {stats['node_count']}")
            print(f"     - Edges: {stats['edge_count']}")
            print(f"     - Language: {repo_hg['metadata']['language']}")

        if self.multi_hypergraph["cross_repo_nodes"]:
            print(f"\n🔗 Shared Concepts (Top 10):")
            cross_nodes = list(self.multi_hypergraph["cross_repo_nodes"].values())
            cross_nodes.sort(key=lambda n: n["instance_count"], reverse=True)
            for node in cross_nodes[:10]:
                print(f"   • {node['name']} ({node['type']})")
                print(
                    f"     - Found in {node['instance_count']} repositories: {', '.join(node['repositories'])}"
                )

        print("\n" + "=" * 80)


def main():
    """Main execution function"""
    import argparse

    parser = argparse.ArgumentParser(
        description="Construct multi-repository hypergraph"
    )
    parser.add_argument(
        "--workspace", type=str, help="Workspace directory for cloning repos"
    )
    parser.add_argument(
        "--output",
        type=str,
        default="multi_repo_hypergraph.json",
        help="Output file for hypergraph JSON",
    )
    parser.add_argument(
        "--skip-clone",
        action="store_true",
        help="Skip cloning, use existing local repos",
    )
    parser.add_argument(
        "--repos",
        nargs="+",
        help="Specific repositories to analyze (owner/name format)",
    )

    args = parser.parse_args()

    # Filter repositories if specified
    repositories = DEFAULT_REPOSITORIES
    if args.repos:
        repositories = [r for r in DEFAULT_REPOSITORIES if r.full_name in args.repos]
        if not repositories:
            logger.error(f"No matching repositories found for: {args.repos}")
            return 1

    # Construct multi-repo hypergraph
    constructor = MultiRepoHypergraphConstructor(repositories, args.workspace)
    multi_hypergraph = constructor.construct(skip_clone=args.skip_clone)

    # Save results
    constructor.save(args.output)

    # Print summary
    constructor.print_summary()

    logger.info(f"\n✅ Multi-repository hypergraph construction complete!")
    logger.info(f"📄 Output saved to: {args.output}")

    return 0


if __name__ == "__main__":
    import sys

    sys.exit(main())
