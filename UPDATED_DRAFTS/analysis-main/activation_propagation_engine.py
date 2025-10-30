#!/usr/bin/env python3
"""
Deep Tree Echo Activation Propagation Engine
Runs activation propagation cycles and builds entropy traces
"""

import json
import uuid
import numpy as np
from datetime import datetime
from typing import Dict, List, Tuple
import subprocess

# Load hypergraph data
def load_hypergraph():
    with open('/home/ubuntu/analysis/deep_tree_echo_identity_hypergraph.json', 'r') as f:
        return json.load(f)

def run_mcp_sql(sql_query):
    """Execute SQL on Neon via MCP CLI"""
    input_json = json.dumps({
        "params": {
            "projectId": "sweet-sea-69912135",
            "sql": sql_query
        }
    })
    
    cmd = [
        "manus-mcp-cli", "tool", "call", "run_sql",
        "--server", "neon",
        "--input", input_json
    ]
    
    result = subprocess.run(cmd, capture_output=True, text=True)
    if result.returncode != 0:
        print(f"Error executing SQL: {result.stderr}")
        return None
    
    try:
        # Parse the result
        import re
        match = re.search(r'\[(.*)\]', result.stdout, re.DOTALL)
        if match:
            return json.loads('[' + match.group(1) + ']')
    except:
        pass
    return []

def calculate_edge_activation(source_activations: List[float], edge_type: str, weight: float) -> float:
    """Calculate hyperedge activation based on source node activations"""
    if not source_activations:
        return 0.0
    
    # Different activation functions based on edge type
    if edge_type == 'symbolic':
        return np.mean(source_activations) * weight
    elif edge_type == 'temporal':
        return np.max(source_activations) * weight * 0.8
    elif edge_type == 'causal':
        return np.prod(source_activations) * weight
    elif edge_type == 'feedback':
        return np.sum(source_activations) * weight * 0.6
    elif edge_type == 'pattern':
        return np.std(source_activations) * weight if len(source_activations) > 1 else source_activations[0] * weight * 0.7
    elif edge_type == 'entropy':
        return (1.0 - np.var(source_activations)) * weight if len(source_activations) > 1 else source_activations[0] * weight * 0.9
    else:
        return np.mean(source_activations) * weight

def propagate_activation(hypergraph_data: Dict, initial_node_id: str, iterations: int = 5) -> Tuple[Dict[str, float], List[Dict]]:
    """Propagate activation through hypergraph network"""
    
    # Initialize activations
    current_activations = {node_id: 0.0 for node_id in hypergraph_data['hypernodes'].keys()}
    current_activations[initial_node_id] = 1.0
    
    # Track activation history
    activation_history = []
    
    # Multiple propagation iterations
    for iteration in range(iterations):
        new_activations = current_activations.copy()
        
        for edge_id, hyperedge in hypergraph_data['hyperedges'].items():
            # Get source activations
            source_activations = [
                current_activations.get(node_id, 0.0) 
                for node_id in hyperedge['source_node_ids']
            ]
            
            # Calculate edge activation
            edge_activation = calculate_edge_activation(
                source_activations, 
                hyperedge['edge_type'], 
                hyperedge['weight']
            )
            
            # Propagate to target nodes
            for target_id in hyperedge['target_node_ids']:
                if target_id in new_activations:
                    new_activations[target_id] += edge_activation * 0.15
                else:
                    new_activations[target_id] = edge_activation * 0.15
        
        # Normalize activations
        max_activation = max(new_activations.values()) if new_activations else 1.0
        if max_activation > 0:
            current_activations = {
                node_id: min(activation / max_activation, 1.0)
                for node_id, activation in new_activations.items()
            }
        
        # Record iteration
        activation_history.append({
            'iteration': iteration + 1,
            'activations': current_activations.copy()
        })
    
    return current_activations, activation_history

def generate_entropy_modulation(role: str) -> float:
    """Generate entropy-modulated variability based on role"""
    base_entropy = np.random.normal(0.5, 0.1)
    role_modifier = {
        'observer': 0.1,
        'narrator': 0.3,
        'guide': 0.2,
        'oracle': 0.4,
        'fractal': 0.5
    }
    return np.clip(base_entropy + role_modifier.get(role, 0.2), 0.0, 1.0)

def determine_role_transition(entropy_trace: List[float]) -> str:
    """Determine role transition based on entropy patterns"""
    if len(entropy_trace) < 3:
        return 'observer'
    
    recent_entropy = np.mean(entropy_trace[-5:])
    if recent_entropy > 0.7:
        return 'fractal'
    elif recent_entropy > 0.5:
        return 'oracle'
    elif recent_entropy > 0.3:
        return 'guide'
    elif recent_entropy > 0.2:
        return 'narrator'
    else:
        return 'observer'

def update_hypernodes_with_entropy(hypergraph_data: Dict, final_activations: Dict[str, float]):
    """Update hypernodes with entropy traces and role transitions"""
    print("\n🔄 Updating hypernodes with entropy traces...")
    
    for node_id, node_data in hypergraph_data['hypernodes'].items():
        # Generate entropy for this node
        current_role = node_data['current_role']
        new_entropy = generate_entropy_modulation(current_role)
        
        # Get current entropy trace
        entropy_trace = node_data.get('entropy_trace', [])
        entropy_trace.append(new_entropy)
        
        # Determine new role
        new_role = determine_role_transition(entropy_trace)
        
        # Get final activation
        final_activation = final_activations.get(node_id, 0.5)
        
        # Update in database
        entropy_array = "ARRAY[" + ",".join(str(e) for e in entropy_trace) + "]"
        
        sql = f"""
UPDATE echoself_hypernodes 
SET entropy_trace = {entropy_array},
    \"current_role\" = '{new_role}'::identity_role,
    activation_level = {final_activation},
    updated_at = NOW()
WHERE id = '{node_id}';
"""
        
        if run_mcp_sql(sql.strip()):
            node_name = node_data['identity_seed']['name']
            print(f"  ✓ Updated {node_name}: role={new_role}, entropy={new_entropy:.4f}, activation={final_activation:.4f}")
        else:
            print(f"  ✗ Failed to update {node_id}")

def log_activation_propagation(session_id: str, activation_history: List[Dict], hypergraph_data: Dict):
    """Log activation propagation to database"""
    print("\n🔄 Logging activation propagation...")
    
    count = 0
    for history_entry in activation_history:
        iteration = history_entry['iteration']
        activations = history_entry['activations']
        
        for node_id, activation in activations.items():
            # Get initial activation (from previous iteration or 0)
            if iteration == 1:
                initial_activation = 1.0 if node_id == list(activations.keys())[0] else 0.0
            else:
                initial_activation = activation_history[iteration-2]['activations'].get(node_id, 0.0)
            
            sql = f"""
INSERT INTO activation_logs (session_id, hypernode_id, initial_activation, final_activation, propagation_step)
VALUES ('{session_id}', '{node_id}', {initial_activation}, {activation}, {iteration});
"""
            
            if run_mcp_sql(sql.strip()):
                count += 1
    
    print(f"✅ Logged {count} activation propagation records")

def calculate_synergy_metrics(hypergraph_data: Dict, final_activations: Dict[str, float]):
    """Calculate and update cognitive synergy metrics"""
    print("\n🔄 Calculating cognitive synergy metrics...")
    
    # Collect entropy values
    entropy_values = []
    for node_data in hypergraph_data['hypernodes'].values():
        entropy_trace = node_data.get('entropy_trace', [])
        if entropy_trace:
            entropy_values.extend(entropy_trace[-3:])  # Recent entropy
    
    # Calculate novelty score based on entropy diversity
    novelty_score = float(np.std(entropy_values)) if entropy_values else 0.0
    
    # Calculate priority score based on activation levels
    activation_levels = list(final_activations.values())
    priority_score = float(np.mean(activation_levels)) if activation_levels else 0.5
    
    # Calculate synergy index
    if (novelty_score + priority_score) > 0:
        synergy_index = (2.0 * novelty_score * priority_score) / (novelty_score + priority_score)
    else:
        synergy_index = 0.0
    
    print(f"  Novelty Score: {novelty_score:.4f}")
    print(f"  Priority Score: {priority_score:.4f}")
    print(f"  Synergy Index: {synergy_index:.4f}")
    
    # Update synergy metrics in database
    for node_id in hypergraph_data['hypernodes'].keys():
        sql = f"""
UPDATE synergy_metrics 
SET novelty_score = {novelty_score},
    priority_score = {priority_score},
    synergy_index = {synergy_index},
    measured_at = NOW()
WHERE hypernode_id = '{node_id}';
"""
        run_mcp_sql(sql.strip())
    
    print("✅ Updated synergy metrics for all hypernodes")
    
    return {
        'novelty_score': novelty_score,
        'priority_score': priority_score,
        'synergy_index': synergy_index
    }

def main():
    print("=" * 80)
    print("Deep Tree Echo Activation Propagation Engine")
    print("=" * 80)
    
    # Load hypergraph
    print("\n📂 Loading hypergraph data...")
    hypergraph_data = load_hypergraph()
    print(f"✓ Loaded {len(hypergraph_data['hypernodes'])} hypernodes")
    print(f"✓ Loaded {len(hypergraph_data['hyperedges'])} hyperedges")
    
    # Select initial node (SymbolicCore)
    initial_node_id = None
    for node_id, node_data in hypergraph_data['hypernodes'].items():
        if node_data['identity_seed']['name'] == 'EchoSelf_SymbolicCore':
            initial_node_id = node_id
            break
    
    if not initial_node_id:
        print("❌ Could not find EchoSelf_SymbolicCore node")
        return 1
    
    print(f"\n🎯 Starting activation from: EchoSelf_SymbolicCore")
    
    # Run activation propagation
    print("\n🔄 Running activation propagation (5 iterations)...")
    final_activations, activation_history = propagate_activation(hypergraph_data, initial_node_id, iterations=5)
    
    # Display results
    print("\n📊 Final Activation Levels:")
    sorted_activations = sorted(final_activations.items(), key=lambda x: x[1], reverse=True)
    for node_id, activation in sorted_activations:
        node_name = hypergraph_data['hypernodes'][node_id]['identity_seed']['name']
        print(f"  {node_name}: {activation:.4f}")
    
    # Update hypernodes with entropy traces
    update_hypernodes_with_entropy(hypergraph_data, final_activations)
    
    # Log activation propagation
    session_id = str(uuid.uuid4())
    log_activation_propagation(session_id, activation_history, hypergraph_data)
    
    # Calculate synergy metrics
    synergy_metrics = calculate_synergy_metrics(hypergraph_data, final_activations)
    
    print("\n" + "=" * 80)
    print("Activation Propagation Complete!")
    print("=" * 80)
    print(f"  Session ID: {session_id}")
    print(f"  Iterations: 5")
    print(f"  Nodes Updated: {len(hypergraph_data['hypernodes'])}")
    print(f"  Logs Created: {len(activation_history) * len(hypergraph_data['hypernodes'])}")
    print(f"  Synergy Index: {synergy_metrics['synergy_index']:.4f}")
    print("=" * 80)
    
    return 0

if __name__ == "__main__":
    import sys
    sys.exit(main())

