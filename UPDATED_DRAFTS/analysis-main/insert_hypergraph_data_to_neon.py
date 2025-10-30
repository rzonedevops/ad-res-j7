#!/usr/bin/env python3
"""
Insert Deep Tree Echo Hypergraph Data into Neon Database via MCP
"""

import json
import subprocess
import sys

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
        return False
    return True

def load_hypergraph_data():
    """Load the Deep Tree Echo hypergraph JSON data"""
    with open('/home/ubuntu/analysis/deep_tree_echo_identity_hypergraph.json', 'r') as f:
        return json.load(f)

def insert_hypernodes(hypergraph_data):
    """Insert echoself hypernodes"""
    print("\n🔄 Inserting echoself hypernodes...")
    count = 0
    
    for node_id, node_data in hypergraph_data['hypernodes'].items():
        identity_seed = json.dumps(node_data['identity_seed']).replace("'", "''")
        current_role = node_data['current_role']
        
        # Format entropy trace array
        entropy_trace = node_data['entropy_trace']
        if entropy_trace:
            entropy_str = "ARRAY[" + ",".join(str(e) for e in entropy_trace) + "]"
        else:
            entropy_str = "ARRAY[]::DECIMAL[]"
        
        role_probs = json.dumps(node_data['role_transition_probabilities']).replace("'", "''")
        activation = node_data['activation_level']
        
        sql = f"""
INSERT INTO echoself_hypernodes (id, identity_seed, "current_role", entropy_trace, role_transition_probabilities, activation_level)
VALUES ('{node_id}', '{identity_seed}'::jsonb, '{current_role}'::identity_role, {entropy_str}, '{role_probs}'::jsonb, {activation});
"""
        
        if run_mcp_sql(sql.strip()):
            count += 1
            print(f"  ✓ Inserted hypernode: {node_data['identity_seed']['name']}")
        else:
            print(f"  ✗ Failed to insert hypernode: {node_data['identity_seed']['name']}")
    
    print(f"✅ Inserted {count}/{len(hypergraph_data['hypernodes'])} hypernodes")
    return count

def insert_memory_fragments(hypergraph_data):
    """Insert memory fragments"""
    print("\n🔄 Inserting memory fragments...")
    count = 0
    
    for node_id, node_data in hypergraph_data['hypernodes'].items():
        for fragment in node_data['memory_fragments']:
            frag_id = fragment['id']
            memory_type = fragment['memory_type']
            content = json.dumps(fragment['content']).replace("'", "''")
            
            # Format associations array
            associations = fragment['associations']
            if associations:
                assoc_str = "ARRAY['" + "','".join(associations) + "']::UUID[]"
            else:
                assoc_str = "ARRAY[]::UUID[]"
            
            frag_activation = fragment['activation_level']
            
            sql = f"""
INSERT INTO memory_fragments (id, hypernode_id, memory_type, content, associations, activation_level)
VALUES ('{frag_id}', '{node_id}', '{memory_type}'::memory_type, '{content}'::jsonb, {assoc_str}, {frag_activation});
"""
            
            if run_mcp_sql(sql.strip()):
                count += 1
                print(f"  ✓ Inserted memory fragment: {memory_type} for {node_data['identity_seed']['name']}")
            else:
                print(f"  ✗ Failed to insert memory fragment for {node_data['identity_seed']['name']}")
    
    print(f"✅ Inserted {count} memory fragments")
    return count

def insert_hyperedges(hypergraph_data):
    """Insert echoself hyperedges"""
    print("\n🔄 Inserting echoself hyperedges...")
    count = 0
    
    for edge_id, edge_data in hypergraph_data['hyperedges'].items():
        source_ids = "ARRAY['" + "','".join(edge_data['source_node_ids']) + "']::UUID[]"
        target_ids = "ARRAY['" + "','".join(edge_data['target_node_ids']) + "']::UUID[]"
        edge_type = edge_data['edge_type']
        weight = edge_data['weight']
        metadata = json.dumps(edge_data['metadata']).replace("'", "''")
        
        sql = f"""
INSERT INTO echoself_hyperedges (id, source_node_ids, target_node_ids, edge_type, weight, metadata)
VALUES ('{edge_id}', {source_ids}, {target_ids}, '{edge_type}'::hyperedge_type, {weight}, '{metadata}'::jsonb);
"""
        
        if run_mcp_sql(sql.strip()):
            count += 1
            print(f"  ✓ Inserted hyperedge: {edge_type} ({metadata})")
        else:
            print(f"  ✗ Failed to insert hyperedge: {edge_type}")
    
    print(f"✅ Inserted {count}/{len(hypergraph_data['hyperedges'])} hyperedges")
    return count

def insert_synergy_metrics(hypergraph_data):
    """Insert synergy metrics"""
    print("\n🔄 Inserting synergy metrics...")
    count = 0
    
    metrics = hypergraph_data['synergy_metrics']
    for node_id in hypergraph_data['hypernodes'].keys():
        novelty = metrics['novelty_score']
        priority = metrics['priority_score']
        synergy = metrics['synergy_index']
        
        sql = f"""
INSERT INTO synergy_metrics (hypernode_id, novelty_score, priority_score, synergy_index)
VALUES ('{node_id}', {novelty}, {priority}, {synergy});
"""
        
        if run_mcp_sql(sql.strip()):
            count += 1
        else:
            print(f"  ✗ Failed to insert synergy metrics for node {node_id}")
    
    print(f"✅ Inserted {count} synergy metric records")
    return count

def main():
    print("=" * 80)
    print("Deep Tree Echo Hypergraph Data Insertion to Neon")
    print("=" * 80)
    
    # Load hypergraph data
    print("\n📂 Loading hypergraph data...")
    hypergraph_data = load_hypergraph_data()
    print(f"✓ Loaded {len(hypergraph_data['hypernodes'])} hypernodes")
    print(f"✓ Loaded {len(hypergraph_data['hyperedges'])} hyperedges")
    
    # Insert data
    hypernode_count = insert_hypernodes(hypergraph_data)
    memory_count = insert_memory_fragments(hypergraph_data)
    hyperedge_count = insert_hyperedges(hypergraph_data)
    synergy_count = insert_synergy_metrics(hypergraph_data)
    
    # Summary
    print("\n" + "=" * 80)
    print("Insertion Summary:")
    print("=" * 80)
    print(f"  Hypernodes:       {hypernode_count}/8")
    print(f"  Memory Fragments: {memory_count}/8")
    print(f"  Hyperedges:       {hyperedge_count}/8")
    print(f"  Synergy Metrics:  {synergy_count}/8")
    print("=" * 80)
    
    if hypernode_count == 8 and memory_count == 8 and hyperedge_count == 8 and synergy_count == 8:
        print("\n✅ All hypergraph data successfully inserted into Neon database!")
        return 0
    else:
        print("\n⚠️  Some data failed to insert. Please check errors above.")
        return 1

if __name__ == "__main__":
    sys.exit(main())

