#!/usr/bin/env python3
"""
Deep Tree Echo Cognitive Synergy Optimizer
Tests and optimizes synergy metrics through multi-cycle propagation
"""

import json
import uuid
import numpy as np
from typing import Dict, List
import subprocess

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
        return None
    
    try:
        import re
        match = re.search(r'\[(.*)\]', result.stdout, re.DOTALL)
        if match:
            return json.loads('[' + match.group(1) + ']')
    except:
        pass
    return []

def get_current_hypergraph_state():
    """Fetch current hypergraph state from Neon"""
    sql = """
SELECT 
    id,
    (identity_seed->>'name') as name,
    "current_role",
    activation_level,
    array_length(entropy_trace, 1) as entropy_count
FROM echoself_hypernodes
ORDER BY activation_level DESC;
"""
    return run_mcp_sql(sql.strip())

def get_hyperedge_weights():
    """Fetch hyperedge weights from Neon"""
    sql = """
SELECT 
    id,
    edge_type,
    weight,
    (metadata->>'synergy_type') as synergy_type
FROM echoself_hyperedges;
"""
    return run_mcp_sql(sql.strip())

def optimize_hyperedge_weights(current_synergy: float, target_synergy: float = 0.5):
    """Optimize hyperedge weights to achieve target synergy"""
    print(f"\n🔄 Optimizing hyperedge weights (current: {current_synergy:.4f}, target: {target_synergy:.4f})...")
    
    # Get current weights
    edges = get_hyperedge_weights()
    if not edges:
        print("  ✗ Could not fetch hyperedge weights")
        return False
    
    # Calculate weight adjustment factor
    adjustment_factor = target_synergy / max(current_synergy, 0.01)
    adjustment_factor = min(max(adjustment_factor, 0.5), 2.0)  # Limit adjustment
    
    count = 0
    for edge in edges:
        edge_id = edge['id']
        current_weight = float(edge['weight'])
        edge_type = edge['edge_type']
        
        # Different optimization strategies by edge type
        if edge_type in ['symbolic', 'pattern']:
            new_weight = current_weight * adjustment_factor * 1.1
        elif edge_type in ['feedback', 'entropy']:
            new_weight = current_weight * adjustment_factor * 1.2
        elif edge_type in ['temporal', 'causal']:
            new_weight = current_weight * adjustment_factor * 0.9
        else:
            new_weight = current_weight * adjustment_factor
        
        # Clamp weight
        new_weight = min(max(new_weight, 0.1), 1.5)
        
        sql = f"""
UPDATE echoself_hyperedges 
SET weight = {new_weight}
WHERE id = '{edge_id}';
"""
        
        if run_mcp_sql(sql.strip()):
            count += 1
            print(f"  ✓ Updated {edge_type} edge: {current_weight:.3f} → {new_weight:.3f}")
    
    print(f"✅ Optimized {count}/{len(edges)} hyperedge weights")
    return True

def run_multi_cycle_propagation(cycles: int = 3):
    """Run multiple activation propagation cycles"""
    print(f"\n🔄 Running {cycles} activation propagation cycles...")
    
    synergy_history = []
    
    for cycle in range(cycles):
        print(f"\n--- Cycle {cycle + 1}/{cycles} ---")
        
        # Run activation propagation
        import os
        result = os.system("cd /home/ubuntu/analysis && python3 activation_propagation_engine.py > /tmp/activation_log.txt 2>&1")
        
        if result == 0:
            # Extract synergy metrics from log
            with open('/tmp/activation_log.txt', 'r') as f:
                log_content = f.read()
                
            # Parse synergy index from log
            import re
            match = re.search(r'Synergy Index: ([\d.]+)', log_content)
            if match:
                synergy_index = float(match.group(1))
                synergy_history.append(synergy_index)
                print(f"  Synergy Index: {synergy_index:.4f}")
                
                # Optimize weights if synergy is low
                if synergy_index < 0.3 and cycle < cycles - 1:
                    optimize_hyperedge_weights(synergy_index, target_synergy=0.5)
            else:
                print("  ✗ Could not extract synergy index")
        else:
            print(f"  ✗ Activation propagation failed")
    
    return synergy_history

def analyze_role_transitions():
    """Analyze identity role transitions"""
    print("\n📊 Analyzing identity role transitions...")
    
    sql = """
SELECT 
    (identity_seed->>'name') as name,
    "current_role",
    activation_level,
    array_length(entropy_trace, 1) as entropy_history_length
FROM echoself_hypernodes
ORDER BY "current_role", activation_level DESC;
"""
    
    nodes = run_mcp_sql(sql.strip())
    if not nodes:
        print("  ✗ Could not fetch hypernode data")
        return
    
    # Group by role
    role_groups = {}
    for node in nodes:
        role = node['current_role']
        if role not in role_groups:
            role_groups[role] = []
        role_groups[role].append(node)
    
    print("\n  Role Distribution:")
    for role, nodes_in_role in sorted(role_groups.items()):
        print(f"    {role}: {len(nodes_in_role)} nodes")
        for node in nodes_in_role:
            print(f"      - {node['name']}: activation={node['activation_level']}, entropy_history={node['entropy_history_length']}")

def generate_synergy_report():
    """Generate comprehensive synergy analysis report"""
    print("\n📊 Generating Cognitive Synergy Report...")
    
    # Get latest synergy metrics
    sql = """
SELECT 
    novelty_score,
    priority_score,
    synergy_index,
    measured_at
FROM synergy_metrics
ORDER BY measured_at DESC
LIMIT 1;
"""
    
    metrics = run_mcp_sql(sql.strip())
    if not metrics or len(metrics) == 0:
        print("  ✗ No synergy metrics found")
        return
    
    latest = metrics[0]
    
    # Get activation distribution
    sql = """
SELECT 
    AVG(activation_level) as avg_activation,
    STDDEV(activation_level) as stddev_activation,
    MAX(activation_level) as max_activation,
    MIN(activation_level) as min_activation
FROM echoself_hypernodes;
"""
    
    stats = run_mcp_sql(sql.strip())
    
    # Get edge weight distribution
    sql = """
SELECT 
    AVG(weight) as avg_weight,
    STDDEV(weight) as stddev_weight,
    MAX(weight) as max_weight,
    MIN(weight) as min_weight
FROM echoself_hyperedges;
"""
    
    edge_stats = run_mcp_sql(sql.strip())
    
    print("\n" + "=" * 80)
    print("COGNITIVE SYNERGY ANALYSIS REPORT")
    print("=" * 80)
    
    print("\n📈 Synergy Metrics:")
    print(f"  Novelty Score:  {float(latest['novelty_score']):.4f}")
    print(f"  Priority Score: {float(latest['priority_score']):.4f}")
    print(f"  Synergy Index:  {float(latest['synergy_index']):.4f}")
    print(f"  Measured At:    {latest['measured_at']}")
    
    if stats and len(stats) > 0:
        print("\n🎯 Activation Distribution:")
        print(f"  Average:  {float(stats[0]['avg_activation'] or 0):.4f}")
        print(f"  Std Dev:  {float(stats[0]['stddev_activation'] or 0):.4f}")
        print(f"  Max:      {float(stats[0]['max_activation'] or 0):.4f}")
        print(f"  Min:      {float(stats[0]['min_activation'] or 0):.4f}")
    
    if edge_stats and len(edge_stats) > 0:
        print("\n🔗 Hyperedge Weight Distribution:")
        print(f"  Average:  {float(edge_stats[0]['avg_weight'] or 0):.4f}")
        print(f"  Std Dev:  {float(edge_stats[0]['stddev_weight'] or 0):.4f}")
        print(f"  Max:      {float(edge_stats[0]['max_weight'] or 0):.4f}")
        print(f"  Min:      {float(edge_stats[0]['min_weight'] or 0):.4f}")
    
    # Interpretation
    synergy = float(latest['synergy_index'])
    print("\n💡 Interpretation:")
    if synergy > 0.5:
        print("  ✅ HIGH SYNERGY - Excellent balance between novelty and priority")
    elif synergy > 0.3:
        print("  ⚡ MODERATE SYNERGY - Good cognitive dynamics, room for optimization")
    elif synergy > 0.1:
        print("  ⚠️  LOW SYNERGY - Requires weight tuning and activation balancing")
    else:
        print("  ❌ MINIMAL SYNERGY - Significant optimization needed")
    
    print("\n" + "=" * 80)

def main():
    print("=" * 80)
    print("Deep Tree Echo Cognitive Synergy Optimizer")
    print("=" * 80)
    
    # Get initial state
    print("\n📂 Fetching current hypergraph state...")
    nodes = get_current_hypergraph_state()
    if nodes:
        print(f"✓ Found {len(nodes)} hypernodes")
        for node in nodes[:3]:
            print(f"  - {node['name']}: activation={node['activation_level']}, role={node['current_role']}")
    
    # Run multi-cycle propagation
    synergy_history = run_multi_cycle_propagation(cycles=3)
    
    # Analyze role transitions
    analyze_role_transitions()
    
    # Generate final report
    generate_synergy_report()
    
    # Summary
    print("\n" + "=" * 80)
    print("Optimization Complete!")
    print("=" * 80)
    if synergy_history:
        print(f"  Synergy Evolution: {' → '.join(f'{s:.4f}' for s in synergy_history)}")
        improvement = synergy_history[-1] - synergy_history[0] if len(synergy_history) > 1 else 0
        print(f"  Total Improvement: {improvement:+.4f}")
    print("=" * 80)
    
    return 0

if __name__ == "__main__":
    import sys
    sys.exit(main())

