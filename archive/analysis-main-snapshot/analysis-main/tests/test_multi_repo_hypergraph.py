#!/usr/bin/env python3
"""
Tests for Multi-Repository Hypergraph Integration
=================================================

Tests the multi-repository hypergraph construction and analysis functionality.
"""

import json
import tempfile
import unittest
from pathlib import Path
from unittest.mock import MagicMock, patch

import sys

sys.path.insert(0, str(Path(__file__).parent.parent))

from construct_multi_repo_hypergraph import (
    MultiRepoHypergraphConstructor,
    RepositoryConfig,
    DEFAULT_REPOSITORIES,
)


class TestRepositoryConfig(unittest.TestCase):
    """Test RepositoryConfig class"""

    def test_repository_config_creation(self):
        """Test creating a repository configuration"""
        config = RepositoryConfig("owner", "repo", "Python", "Test repo")

        self.assertEqual(config.owner, "owner")
        self.assertEqual(config.name, "repo")
        self.assertEqual(config.language, "Python")
        self.assertEqual(config.focus, "Test repo")
        self.assertEqual(config.full_name, "owner/repo")
        self.assertEqual(config.url, "https://github.com/owner/repo.git")

    def test_repository_config_custom_url(self):
        """Test repository config with custom URL"""
        custom_url = "https://custom.git/repo.git"
        config = RepositoryConfig("owner", "repo", "Python", "Test", url=custom_url)

        self.assertEqual(config.url, custom_url)

    def test_repository_config_repr(self):
        """Test string representation"""
        config = RepositoryConfig("owner", "repo", "Python", "Test")
        repr_str = repr(config)

        self.assertIn("owner/repo", repr_str)
        self.assertIn("Python", repr_str)


class TestMultiRepoHypergraphConstructor(unittest.TestCase):
    """Test MultiRepoHypergraphConstructor class"""

    def setUp(self):
        """Set up test fixtures"""
        self.temp_dir = tempfile.mkdtemp()
        self.test_repos = [
            RepositoryConfig("test", "repo1", "Python", "Test repo 1"),
            RepositoryConfig("test", "repo2", "JavaScript", "Test repo 2"),
        ]

    def test_constructor_initialization(self):
        """Test constructor initialization"""
        constructor = MultiRepoHypergraphConstructor(self.test_repos, self.temp_dir)

        self.assertEqual(len(constructor.repositories), 2)
        self.assertEqual(str(constructor.workspace_dir), self.temp_dir)
        self.assertIn("metadata", constructor.multi_hypergraph)
        self.assertIn("repositories", constructor.multi_hypergraph)
        self.assertIn("cross_repo_nodes", constructor.multi_hypergraph)
        self.assertIn("cross_repo_edges", constructor.multi_hypergraph)

    def test_hypergraph_metadata(self):
        """Test hypergraph metadata structure"""
        constructor = MultiRepoHypergraphConstructor(self.test_repos)

        metadata = constructor.multi_hypergraph["metadata"]
        self.assertEqual(metadata["type"], "multi_repository_hypergraph")
        self.assertEqual(metadata["version"], "1.0.0")
        self.assertIn("timestamp", metadata)
        self.assertIn("test/repo1", metadata["repositories"])
        self.assertIn("test/repo2", metadata["repositories"])

    def test_add_node(self):
        """Test adding nodes to hypergraph"""
        constructor = MultiRepoHypergraphConstructor(self.test_repos)

        hypergraph = {"nodes": {}, "edges": []}
        node_id = constructor._add_node(
            hypergraph, "test_type", "test_node", {"prop": "value"}
        )

        self.assertIn(node_id, hypergraph["nodes"])
        self.assertEqual(hypergraph["nodes"][node_id]["type"], "test_type")
        self.assertEqual(hypergraph["nodes"][node_id]["name"], "test_node")
        self.assertEqual(hypergraph["nodes"][node_id]["properties"]["prop"], "value")

    def test_add_edge(self):
        """Test adding edges to hypergraph"""
        constructor = MultiRepoHypergraphConstructor(self.test_repos)

        hypergraph = {"nodes": {}, "edges": []}
        edge_id = constructor._add_edge(
            hypergraph, "test_edge", 1, [2, 3], {"weight": 0.5}
        )

        self.assertEqual(len(hypergraph["edges"]), 1)
        self.assertEqual(hypergraph["edges"][0]["type"], "test_edge")
        self.assertEqual(hypergraph["edges"][0]["source"], 1)
        self.assertEqual(hypergraph["edges"][0]["targets"], [2, 3])
        self.assertEqual(hypergraph["edges"][0]["properties"]["weight"], 0.5)

    def test_count_types(self):
        """Test node type counting"""
        constructor = MultiRepoHypergraphConstructor(self.test_repos)

        nodes = {
            1: {"type": "python_file"},
            2: {"type": "python_file"},
            3: {"type": "directory"},
        }

        counts = constructor._count_types(nodes)
        self.assertEqual(counts["python_file"], 2)
        self.assertEqual(counts["directory"], 1)

    def test_count_edge_types(self):
        """Test edge type counting"""
        constructor = MultiRepoHypergraphConstructor(self.test_repos)

        edges = [
            {"type": "contains"},
            {"type": "contains"},
            {"type": "defines"},
        ]

        counts = constructor._count_edge_types(edges)
        self.assertEqual(counts["contains"], 2)
        self.assertEqual(counts["defines"], 1)

    def test_extract_shared_concepts_no_duplicates(self):
        """Test that shared concepts aren't duplicated within same repo"""
        constructor = MultiRepoHypergraphConstructor(self.test_repos)
        repo = self.test_repos[0]

        hypergraph = {
            "nodes": {
                1: {"id": 1, "type": "framework", "name": "HyperGNN"},
                2: {"id": 2, "type": "framework", "name": "HyperGNN"},  # Duplicate
                3: {"id": 3, "type": "framework", "name": "Flask"},
            }
        }

        constructor._extract_shared_concepts(repo, hypergraph)

        # Should only have one entry per concept per repo
        self.assertEqual(len(constructor.shared_concepts["framework:hypergnn"]), 1)
        self.assertEqual(len(constructor.shared_concepts["framework:flask"]), 1)

    def test_save_hypergraph(self):
        """Test saving hypergraph to JSON file"""
        constructor = MultiRepoHypergraphConstructor(self.test_repos)
        output_file = Path(self.temp_dir) / "test_output.json"

        constructor.save(str(output_file))

        self.assertTrue(output_file.exists())

        # Verify JSON is valid
        with open(output_file, "r") as f:
            data = json.load(f)
            self.assertIn("metadata", data)
            self.assertIn("repositories", data)


class TestDefaultRepositories(unittest.TestCase):
    """Test default repository configurations"""

    def test_default_repositories_exist(self):
        """Test that default repositories are defined"""
        self.assertGreater(len(DEFAULT_REPOSITORIES), 0)

    def test_default_repositories_structure(self):
        """Test that default repositories have correct structure"""
        for repo in DEFAULT_REPOSITORIES:
            self.assertIsInstance(repo, RepositoryConfig)
            self.assertIsNotNone(repo.owner)
            self.assertIsNotNone(repo.name)
            self.assertIsNotNone(repo.language)
            self.assertIsNotNone(repo.focus)
            self.assertTrue(repo.url.startswith("https://"))

    def test_expected_repositories_present(self):
        """Test that expected repositories are in default list"""
        repo_names = [r.full_name for r in DEFAULT_REPOSITORIES]

        expected = [
            "cogpy/ad-res-j7",
            "EchoCog/analysss",
            "rzonedevops/analysis",
            "rzonedevops/avtomaatoctory",
            "rzonedevops/analyticase",
        ]

        for expected_repo in expected:
            self.assertIn(expected_repo, repo_names)


class TestIntegration(unittest.TestCase):
    """Integration tests for multi-repo hypergraph"""

    def test_local_repository_analysis(self):
        """Test analyzing a local repository (current repo)"""
        # This tests with the actual analysis repository
        repos = [RepositoryConfig("rzonedevops", "analysis", "Python", "Test")]

        constructor = MultiRepoHypergraphConstructor(repos)

        # Use skip_clone to analyze local repo
        result = constructor.construct(skip_clone=True)

        # Verify basic structure
        self.assertIn("metadata", result)
        self.assertIn("repositories", result)
        self.assertIn("unified_metrics", result)

        # Should have analyzed at least one repository
        metrics = result["unified_metrics"]
        self.assertGreater(metrics.get("total_nodes", 0), 0)


def run_tests():
    """Run all tests"""
    loader = unittest.TestLoader()
    suite = loader.loadTestsFromModule(sys.modules[__name__])
    runner = unittest.TextTestRunner(verbosity=2)
    result = runner.run(suite)
    return 0 if result.wasSuccessful() else 1


if __name__ == "__main__":
    sys.exit(run_tests())
