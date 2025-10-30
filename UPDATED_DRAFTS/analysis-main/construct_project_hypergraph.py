#!/usr/bin/env python3.11
"""
Comprehensive Project Hypergraph Constructor
Constructs a complete hypergraph representation of the rzonedevops/analysis project,
mapping all entities, relationships, components, and multi-dimensional connections.
"""

import os
import sys
import json
import ast
import re
from pathlib import Path
from typing import Dict, List, Set, Tuple, Any
from collections import defaultdict
from datetime import datetime
import logging

# Configure logging
logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(levelname)s - %(message)s'
)
logger = logging.getLogger(__name__)


class ProjectHypergraphConstructor:
    """Constructs a comprehensive hypergraph of the entire project"""
    
    def __init__(self, project_root: str):
        self.project_root = Path(project_root)
        self.hypergraph = {
            'metadata': {
                'project': 'rzonedevops/analysis',
                'version': '0.6.0',
                'timestamp': datetime.utcnow().isoformat(),
                'constructor': 'ProjectHypergraphConstructor'
            },
            'nodes': {},
            'hyperedges': [],
            'layers': {},
            'metrics': {}
        }
        
        # Entity counters
        self.node_id = 0
        self.edge_id = 0
        
        # Tracking structures
        self.file_nodes = {}
        self.class_nodes = {}
        self.function_nodes = {}
        self.module_nodes = {}
        self.database_nodes = {}
        self.api_nodes = {}
        
    def construct(self) -> Dict[str, Any]:
        """Main construction method"""
        logger.info("=" * 80)
        logger.info("CONSTRUCTING PROJECT HYPERGRAPH")
        logger.info("=" * 80)
        
        # Layer 1: File System Structure
        logger.info("\n📁 Layer 1: Analyzing file system structure...")
        self._analyze_file_structure()
        
        # Layer 2: Python Code Structure
        logger.info("\n🐍 Layer 2: Analyzing Python code structure...")
        self._analyze_python_code()
        
        # Layer 3: Database Schema
        logger.info("\n🗄️ Layer 3: Analyzing database schemas...")
        self._analyze_database_schemas()
        
        # Layer 4: API Endpoints
        logger.info("\n🌐 Layer 4: Analyzing API endpoints...")
        self._analyze_api_endpoints()
        
        # Layer 5: Dependencies
        logger.info("\n🔗 Layer 5: Analyzing dependencies...")
        self._analyze_dependencies()
        
        # Layer 6: Documentation
        logger.info("\n📚 Layer 6: Analyzing documentation...")
        self._analyze_documentation()
        
        # Layer 7: Configuration
        logger.info("\n⚙️ Layer 7: Analyzing configuration...")
        self._analyze_configuration()
        
        # Layer 8: Test Structure
        logger.info("\n🧪 Layer 8: Analyzing test structure...")
        self._analyze_tests()
        
        # Compute metrics
        logger.info("\n📊 Computing hypergraph metrics...")
        self._compute_metrics()
        
        logger.info("\n✅ Hypergraph construction complete!")
        return self.hypergraph
    
    def _add_node(self, node_type: str, name: str, properties: Dict[str, Any]) -> int:
        """Add a node to the hypergraph"""
        node_id = self.node_id
        self.node_id += 1
        
        self.hypergraph['nodes'][node_id] = {
            'id': node_id,
            'type': node_type,
            'name': name,
            'properties': properties
        }
        
        return node_id
    
    def _add_hyperedge(self, edge_type: str, nodes: List[int], 
                       properties: Dict[str, Any] = None):
        """Add a hyperedge connecting multiple nodes"""
        edge_id = self.edge_id
        self.edge_id += 1
        
        self.hypergraph['hyperedges'].append({
            'id': edge_id,
            'type': edge_type,
            'nodes': nodes,
            'properties': properties or {}
        })
        
        return edge_id
    
    def _analyze_file_structure(self):
        """Analyze file system structure"""
        layer = {
            'name': 'File System',
            'description': 'Physical file and directory structure',
            'nodes': []
        }
        
        # Key directories
        directories = [
            'src', 'frameworks', 'tools', 'tests', 'docs',
            'migrations', 'analysis-frontend', 'case_2025_137857',
            'backups', 'analysis_outputs'
        ]
        
        for dir_name in directories:
            dir_path = self.project_root / dir_name
            if dir_path.exists():
                node_id = self._add_node('directory', dir_name, {
                    'path': str(dir_path.relative_to(self.project_root)),
                    'exists': True,
                    'file_count': len(list(dir_path.rglob('*')))
                })
                layer['nodes'].append(node_id)
                
                # Analyze subdirectories
                if dir_name == 'src':
                    self._analyze_src_structure(dir_path, node_id)
        
        self.hypergraph['layers']['filesystem'] = layer
    
    def _analyze_src_structure(self, src_path: Path, parent_id: int):
        """Analyze src directory structure"""
        subdirs = [d for d in src_path.iterdir() if d.is_dir() and not d.name.startswith('_')]
        
        for subdir in subdirs:
            node_id = self._add_node('module', subdir.name, {
                'path': str(subdir.relative_to(self.project_root)),
                'parent': 'src',
                'file_count': len(list(subdir.glob('*.py')))
            })
            self.module_nodes[subdir.name] = node_id
            
            # Create containment hyperedge
            self._add_hyperedge('contains', [parent_id, node_id], {
                'relationship': 'directory_contains_module'
            })
    
    def _analyze_python_code(self):
        """Analyze Python code structure"""
        layer = {
            'name': 'Python Code',
            'description': 'Classes, functions, and code structure',
            'nodes': []
        }
        
        # Find all Python files
        python_files = list(self.project_root.glob('**/*.py'))
        python_files = [f for f in python_files if 'node_modules' not in str(f) and '.git' not in str(f)]
        
        for py_file in python_files[:100]:  # Limit for performance
            try:
                with open(py_file, 'r', encoding='utf-8') as f:
                    content = f.read()
                
                # Parse AST
                try:
                    tree = ast.parse(content)
                    self._analyze_ast(tree, py_file, layer)
                except SyntaxError:
                    logger.warning(f"Syntax error in {py_file}")
                    
            except Exception as e:
                logger.warning(f"Error analyzing {py_file}: {e}")
        
        self.hypergraph['layers']['python_code'] = layer
    
    def _analyze_ast(self, tree: ast.AST, file_path: Path, layer: Dict):
        """Analyze Python AST"""
        # File node
        file_id = self._add_node('python_file', file_path.name, {
            'path': str(file_path.relative_to(self.project_root)),
            'size': file_path.stat().st_size
        })
        layer['nodes'].append(file_id)
        self.file_nodes[str(file_path)] = file_id
        
        # Analyze classes
        for node in ast.walk(tree):
            if isinstance(node, ast.ClassDef):
                class_id = self._add_node('class', node.name, {
                    'file': file_path.name,
                    'methods': [m.name for m in node.body if isinstance(m, ast.FunctionDef)],
                    'bases': [self._get_name(b) for b in node.bases]
                })
                layer['nodes'].append(class_id)
                self.class_nodes[f"{file_path.name}::{node.name}"] = class_id
                
                # Link to file
                self._add_hyperedge('defines', [file_id, class_id], {
                    'relationship': 'file_defines_class'
                })
                
            elif isinstance(node, ast.FunctionDef):
                # Only top-level functions
                if isinstance(node, ast.FunctionDef) and node.col_offset == 0:
                    func_id = self._add_node('function', node.name, {
                        'file': file_path.name,
                        'args': [arg.arg for arg in node.args.args],
                        'decorators': [self._get_name(d) for d in node.decorator_list]
                    })
                    layer['nodes'].append(func_id)
                    
                    # Link to file
                    self._add_hyperedge('defines', [file_id, func_id], {
                        'relationship': 'file_defines_function'
                    })
    
    def _get_name(self, node):
        """Get name from AST node"""
        if isinstance(node, ast.Name):
            return node.id
        elif isinstance(node, ast.Attribute):
            return f"{self._get_name(node.value)}.{node.attr}"
        return str(node)
    
    def _analyze_database_schemas(self):
        """Analyze database schemas"""
        layer = {
            'name': 'Database Schema',
            'description': 'Database tables, columns, and relationships',
            'nodes': []
        }
        
        # Find SQL files
        sql_files = list(self.project_root.glob('**/*.sql'))
        
        for sql_file in sql_files:
            try:
                with open(sql_file, 'r', encoding='utf-8') as f:
                    content = f.read()
                
                # Extract table definitions
                tables = re.findall(r'CREATE\s+TABLE\s+(?:IF\s+NOT\s+EXISTS\s+)?(\w+)', 
                                  content, re.IGNORECASE)
                
                for table in tables:
                    table_id = self._add_node('database_table', table, {
                        'schema_file': sql_file.name,
                        'type': 'table'
                    })
                    layer['nodes'].append(table_id)
                    self.database_nodes[table] = table_id
                
                # Extract indexes
                indexes = re.findall(r'CREATE\s+INDEX\s+(?:IF\s+NOT\s+EXISTS\s+)?(\w+)', 
                                   content, re.IGNORECASE)
                
                for index in indexes:
                    index_id = self._add_node('database_index', index, {
                        'schema_file': sql_file.name,
                        'type': 'index'
                    })
                    layer['nodes'].append(index_id)
                    
            except Exception as e:
                logger.warning(f"Error analyzing {sql_file}: {e}")
        
        self.hypergraph['layers']['database'] = layer
    
    def _analyze_api_endpoints(self):
        """Analyze API endpoints"""
        layer = {
            'name': 'API Endpoints',
            'description': 'REST API and GraphQL endpoints',
            'nodes': []
        }
        
        # Find API files
        api_files = list((self.project_root / 'src' / 'api').glob('*.py'))
        
        for api_file in api_files:
            try:
                with open(api_file, 'r', encoding='utf-8') as f:
                    content = f.read()
                
                # Find Flask routes
                routes = re.findall(r'@app\.route\([\'"]([^\'"]+)[\'"]', content)
                
                for route in routes:
                    route_id = self._add_node('api_endpoint', route, {
                        'file': api_file.name,
                        'type': 'flask_route'
                    })
                    layer['nodes'].append(route_id)
                    self.api_nodes[route] = route_id
                
                # Find GraphQL types
                graphql_types = re.findall(r'type\s+(\w+)', content)
                
                for gql_type in graphql_types:
                    type_id = self._add_node('graphql_type', gql_type, {
                        'file': api_file.name,
                        'type': 'graphql'
                    })
                    layer['nodes'].append(type_id)
                    
            except Exception as e:
                logger.warning(f"Error analyzing {api_file}: {e}")
        
        self.hypergraph['layers']['api'] = layer
    
    def _analyze_dependencies(self):
        """Analyze project dependencies"""
        layer = {
            'name': 'Dependencies',
            'description': 'External and internal dependencies',
            'nodes': []
        }
        
        # Parse requirements.txt
        req_file = self.project_root / 'requirements.txt'
        if req_file.exists():
            with open(req_file, 'r') as f:
                for line in f:
                    line = line.strip()
                    if line and not line.startswith('#'):
                        pkg_name = re.split(r'[>=<]', line)[0]
                        dep_id = self._add_node('dependency', pkg_name, {
                            'source': 'requirements.txt',
                            'specification': line
                        })
                        layer['nodes'].append(dep_id)
        
        # Parse pyproject.toml
        pyproject = self.project_root / 'pyproject.toml'
        if pyproject.exists():
            with open(pyproject, 'r') as f:
                content = f.read()
                deps = re.findall(r'"([^"]+)>=', content)
                for dep in deps:
                    if dep not in [n['name'] for n in self.hypergraph['nodes'].values() 
                                 if n['type'] == 'dependency']:
                        dep_id = self._add_node('dependency', dep, {
                            'source': 'pyproject.toml'
                        })
                        layer['nodes'].append(dep_id)
        
        self.hypergraph['layers']['dependencies'] = layer
    
    def _analyze_documentation(self):
        """Analyze documentation structure"""
        layer = {
            'name': 'Documentation',
            'description': 'Documentation files and structure',
            'nodes': []
        }
        
        # Find markdown files
        md_files = list(self.project_root.glob('**/*.md'))
        md_files = [f for f in md_files if 'node_modules' not in str(f)]
        
        doc_categories = {
            'README': [],
            'GUIDE': [],
            'REPORT': [],
            'ANALYSIS': [],
            'OTHER': []
        }
        
        for md_file in md_files[:50]:  # Limit for performance
            name = md_file.name
            category = 'OTHER'
            
            if 'README' in name.upper():
                category = 'README'
            elif 'GUIDE' in name.upper() or 'TUTORIAL' in name.upper():
                category = 'GUIDE'
            elif 'REPORT' in name.upper() or 'LOG' in name.upper():
                category = 'REPORT'
            elif 'ANALYSIS' in name.upper():
                category = 'ANALYSIS'
            
            doc_id = self._add_node('documentation', name, {
                'path': str(md_file.relative_to(self.project_root)),
                'category': category,
                'size': md_file.stat().st_size
            })
            layer['nodes'].append(doc_id)
            doc_categories[category].append(doc_id)
        
        # Create category hyperedges
        for category, nodes in doc_categories.items():
            if nodes:
                self._add_hyperedge('documentation_category', nodes, {
                    'category': category
                })
        
        self.hypergraph['layers']['documentation'] = layer
    
    def _analyze_configuration(self):
        """Analyze configuration files"""
        layer = {
            'name': 'Configuration',
            'description': 'Configuration and settings files',
            'nodes': []
        }
        
        config_files = [
            'pyproject.toml',
            'requirements.txt',
            '.pre-commit-config.yaml',
            'package.json'
        ]
        
        for config_file in config_files:
            config_path = self.project_root / config_file
            if config_path.exists():
                config_id = self._add_node('configuration', config_file, {
                    'path': config_file,
                    'type': config_path.suffix[1:] if config_path.suffix else 'unknown',
                    'size': config_path.stat().st_size
                })
                layer['nodes'].append(config_id)
        
        self.hypergraph['layers']['configuration'] = layer
    
    def _analyze_tests(self):
        """Analyze test structure"""
        layer = {
            'name': 'Tests',
            'description': 'Test files and test structure',
            'nodes': []
        }
        
        # Find test files
        test_files = list(self.project_root.glob('**/test_*.py'))
        test_files += list(self.project_root.glob('**/*_test.py'))
        
        for test_file in test_files:
            test_id = self._add_node('test_file', test_file.name, {
                'path': str(test_file.relative_to(self.project_root)),
                'size': test_file.stat().st_size
            })
            layer['nodes'].append(test_id)
        
        self.hypergraph['layers']['tests'] = layer
    
    def _compute_metrics(self):
        """Compute hypergraph metrics"""
        self.hypergraph['metrics'] = {
            'total_nodes': len(self.hypergraph['nodes']),
            'total_hyperedges': len(self.hypergraph['hyperedges']),
            'total_layers': len(self.hypergraph['layers']),
            'node_types': self._count_node_types(),
            'edge_types': self._count_edge_types(),
            'layer_sizes': {name: len(layer['nodes']) 
                          for name, layer in self.hypergraph['layers'].items()},
            'density': self._compute_density(),
            'average_degree': self._compute_average_degree()
        }
    
    def _count_node_types(self) -> Dict[str, int]:
        """Count nodes by type"""
        counts = defaultdict(int)
        for node in self.hypergraph['nodes'].values():
            counts[node['type']] += 1
        return dict(counts)
    
    def _count_edge_types(self) -> Dict[str, int]:
        """Count edges by type"""
        counts = defaultdict(int)
        for edge in self.hypergraph['hyperedges']:
            counts[edge['type']] += 1
        return dict(counts)
    
    def _compute_density(self) -> float:
        """Compute hypergraph density"""
        n = len(self.hypergraph['nodes'])
        e = len(self.hypergraph['hyperedges'])
        if n == 0:
            return 0.0
        return e / (n * (n - 1) / 2) if n > 1 else 0.0
    
    def _compute_average_degree(self) -> float:
        """Compute average node degree"""
        if not self.hypergraph['nodes']:
            return 0.0
        
        degrees = defaultdict(int)
        for edge in self.hypergraph['hyperedges']:
            for node_id in edge['nodes']:
                degrees[node_id] += 1
        
        return sum(degrees.values()) / len(self.hypergraph['nodes']) if degrees else 0.0
    
    def save(self, output_file: str):
        """Save hypergraph to JSON file"""
        with open(output_file, 'w') as f:
            json.dump(self.hypergraph, f, indent=2)
        logger.info(f"\n💾 Hypergraph saved to: {output_file}")


def main():
    """Main execution function"""
    project_root = '/home/ubuntu/analysis'
    
    constructor = ProjectHypergraphConstructor(project_root)
    hypergraph = constructor.construct()
    
    # Save to file
    output_file = os.path.join(project_root, 'project_hypergraph.json')
    constructor.save(output_file)
    
    # Print summary
    print("\n" + "=" * 80)
    print("HYPERGRAPH CONSTRUCTION SUMMARY")
    print("=" * 80)
    print(f"Total Nodes: {hypergraph['metrics']['total_nodes']}")
    print(f"Total Hyperedges: {hypergraph['metrics']['total_hyperedges']}")
    print(f"Total Layers: {hypergraph['metrics']['total_layers']}")
    print(f"\nNode Types:")
    for node_type, count in hypergraph['metrics']['node_types'].items():
        print(f"  - {node_type}: {count}")
    print(f"\nLayer Sizes:")
    for layer, size in hypergraph['metrics']['layer_sizes'].items():
        print(f"  - {layer}: {size} nodes")
    print(f"\nDensity: {hypergraph['metrics']['density']:.4f}")
    print(f"Average Degree: {hypergraph['metrics']['average_degree']:.2f}")
    print("=" * 80)


if __name__ == "__main__":
    main()

