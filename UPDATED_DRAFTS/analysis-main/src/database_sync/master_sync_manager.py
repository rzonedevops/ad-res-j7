#!/usr/bin/env python3
"""
Master Database Sync Manager
Unified synchronization system for Supabase and Neon databases
Consolidates all sync operations into a single, maintainable interface
"""

import os
import json
import logging
from datetime import datetime
from typing import Dict, List, Optional, Any
from pathlib import Path

# Configure logging
logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(name)s - %(levelname)s - %(message)s'
)
logger = logging.getLogger(__name__)


class MasterSyncManager:
    """
    Unified database synchronization manager
    Handles all sync operations for Supabase and Neon databases
    """
    
    def __init__(self):
        self.supabase_url = os.getenv('SUPABASE_URL')
        self.supabase_key = os.getenv('SUPABASE_KEY')
        self.repo_path = Path(__file__).parent.parent.parent
        self.sync_log = []
        
    def sync_all(self, targets: Optional[List[str]] = None) -> Dict[str, Any]:
        """
        Synchronize all data to specified targets
        
        Args:
            targets: List of sync targets ('supabase', 'neon', or None for all)
            
        Returns:
            Dictionary containing sync results
        """
        logger.info("Starting master sync operation...")
        
        if targets is None:
            targets = ['supabase', 'neon']
        
        results = {
            'timestamp': datetime.now().isoformat(),
            'targets': targets,
            'operations': [],
            'success': True,
            'errors': []
        }
        
        try:
            # Sync entities
            if 'supabase' in targets:
                self._sync_entities_supabase(results)
            if 'neon' in targets:
                self._sync_entities_neon(results)
            
            # Sync evidence
            if 'supabase' in targets:
                self._sync_evidence_supabase(results)
            if 'neon' in targets:
                self._sync_evidence_neon(results)
            
            # Sync timeline
            if 'supabase' in targets:
                self._sync_timeline_supabase(results)
            if 'neon' in targets:
                self._sync_timeline_neon(results)
            
            # Sync hypergraph
            if 'supabase' in targets:
                self._sync_hypergraph_supabase(results)
            if 'neon' in targets:
                self._sync_hypergraph_neon(results)
            
            logger.info("Master sync operation completed successfully")
            
        except Exception as e:
            logger.error(f"Error during sync: {str(e)}")
            results['success'] = False
            results['errors'].append(str(e))
        
        return results
    
    def _sync_entities_supabase(self, results: Dict) -> None:
        """Sync entities to Supabase"""
        logger.info("Syncing entities to Supabase...")
        try:
            # Import here to avoid circular dependencies
            from supabase import create_client
            
            if not self.supabase_url or not self.supabase_key:
                raise ValueError("Supabase credentials not configured")
            
            supabase = create_client(self.supabase_url, self.supabase_key)
            
            # Load entities from repository
            entities_file = self.repo_path / "data" / "entities.json"
            if entities_file.exists():
                with open(entities_file, 'r') as f:
                    entities = json.load(f)
                
                # Upsert entities
                for entity in entities:
                    supabase.table('entities').upsert(entity).execute()
                
                results['operations'].append({
                    'target': 'supabase',
                    'operation': 'sync_entities',
                    'count': len(entities),
                    'status': 'success'
                })
                logger.info(f"Synced {len(entities)} entities to Supabase")
            else:
                logger.warning("Entities file not found")
                
        except Exception as e:
            logger.error(f"Error syncing entities to Supabase: {str(e)}")
            results['errors'].append(f"Supabase entities sync: {str(e)}")
    
    def _sync_entities_neon(self, results: Dict) -> None:
        """Sync entities to Neon using MCP"""
        logger.info("Syncing entities to Neon...")
        try:
            # This will be implemented using Neon MCP tools
            results['operations'].append({
                'target': 'neon',
                'operation': 'sync_entities',
                'status': 'pending_mcp_implementation'
            })
            logger.info("Neon entity sync queued for MCP execution")
            
        except Exception as e:
            logger.error(f"Error syncing entities to Neon: {str(e)}")
            results['errors'].append(f"Neon entities sync: {str(e)}")
    
    def _sync_evidence_supabase(self, results: Dict) -> None:
        """Sync evidence to Supabase"""
        logger.info("Syncing evidence to Supabase...")
        try:
            from supabase import create_client
            
            if not self.supabase_url or not self.supabase_key:
                raise ValueError("Supabase credentials not configured")
            
            supabase = create_client(self.supabase_url, self.supabase_key)
            
            # Load evidence from repository
            evidence_file = self.repo_path / "data" / "evidence.json"
            if evidence_file.exists():
                with open(evidence_file, 'r') as f:
                    evidence = json.load(f)
                
                # Upsert evidence
                for item in evidence:
                    supabase.table('evidence').upsert(item).execute()
                
                results['operations'].append({
                    'target': 'supabase',
                    'operation': 'sync_evidence',
                    'count': len(evidence),
                    'status': 'success'
                })
                logger.info(f"Synced {len(evidence)} evidence items to Supabase")
            else:
                logger.warning("Evidence file not found")
                
        except Exception as e:
            logger.error(f"Error syncing evidence to Supabase: {str(e)}")
            results['errors'].append(f"Supabase evidence sync: {str(e)}")
    
    def _sync_evidence_neon(self, results: Dict) -> None:
        """Sync evidence to Neon using MCP"""
        logger.info("Syncing evidence to Neon...")
        try:
            results['operations'].append({
                'target': 'neon',
                'operation': 'sync_evidence',
                'status': 'pending_mcp_implementation'
            })
            logger.info("Neon evidence sync queued for MCP execution")
            
        except Exception as e:
            logger.error(f"Error syncing evidence to Neon: {str(e)}")
            results['errors'].append(f"Neon evidence sync: {str(e)}")
    
    def _sync_timeline_supabase(self, results: Dict) -> None:
        """Sync timeline to Supabase"""
        logger.info("Syncing timeline to Supabase...")
        try:
            from supabase import create_client
            
            if not self.supabase_url or not self.supabase_key:
                raise ValueError("Supabase credentials not configured")
            
            supabase = create_client(self.supabase_url, self.supabase_key)
            
            # Load timeline from repository
            timeline_file = self.repo_path / "data" / "timeline.json"
            if timeline_file.exists():
                with open(timeline_file, 'r') as f:
                    timeline = json.load(f)
                
                # Upsert timeline events
                for event in timeline:
                    supabase.table('timeline_events').upsert(event).execute()
                
                results['operations'].append({
                    'target': 'supabase',
                    'operation': 'sync_timeline',
                    'count': len(timeline),
                    'status': 'success'
                })
                logger.info(f"Synced {len(timeline)} timeline events to Supabase")
            else:
                logger.warning("Timeline file not found")
                
        except Exception as e:
            logger.error(f"Error syncing timeline to Supabase: {str(e)}")
            results['errors'].append(f"Supabase timeline sync: {str(e)}")
    
    def _sync_timeline_neon(self, results: Dict) -> None:
        """Sync timeline to Neon using MCP"""
        logger.info("Syncing timeline to Neon...")
        try:
            results['operations'].append({
                'target': 'neon',
                'operation': 'sync_timeline',
                'status': 'pending_mcp_implementation'
            })
            logger.info("Neon timeline sync queued for MCP execution")
            
        except Exception as e:
            logger.error(f"Error syncing timeline to Neon: {str(e)}")
            results['errors'].append(f"Neon timeline sync: {str(e)}")
    
    def _sync_hypergraph_supabase(self, results: Dict) -> None:
        """Sync hypergraph to Supabase"""
        logger.info("Syncing hypergraph to Supabase...")
        try:
            from supabase import create_client
            
            if not self.supabase_url or not self.supabase_key:
                raise ValueError("Supabase credentials not configured")
            
            supabase = create_client(self.supabase_url, self.supabase_key)
            
            # Load hypergraph from repository
            hypergraph_file = self.repo_path / "data" / "hypergraph.json"
            if hypergraph_file.exists():
                with open(hypergraph_file, 'r') as f:
                    hypergraph = json.load(f)
                
                # Upsert hypergraph nodes and edges
                if 'nodes' in hypergraph:
                    for node in hypergraph['nodes']:
                        supabase.table('hypergraph_nodes').upsert(node).execute()
                
                if 'edges' in hypergraph:
                    for edge in hypergraph['edges']:
                        supabase.table('hypergraph_edges').upsert(edge).execute()
                
                results['operations'].append({
                    'target': 'supabase',
                    'operation': 'sync_hypergraph',
                    'nodes': len(hypergraph.get('nodes', [])),
                    'edges': len(hypergraph.get('edges', [])),
                    'status': 'success'
                })
                logger.info(f"Synced hypergraph to Supabase")
            else:
                logger.warning("Hypergraph file not found")
                
        except Exception as e:
            logger.error(f"Error syncing hypergraph to Supabase: {str(e)}")
            results['errors'].append(f"Supabase hypergraph sync: {str(e)}")
    
    def _sync_hypergraph_neon(self, results: Dict) -> None:
        """Sync hypergraph to Neon using MCP"""
        logger.info("Syncing hypergraph to Neon...")
        try:
            results['operations'].append({
                'target': 'neon',
                'operation': 'sync_hypergraph',
                'status': 'pending_mcp_implementation'
            })
            logger.info("Neon hypergraph sync queued for MCP execution")
            
        except Exception as e:
            logger.error(f"Error syncing hypergraph to Neon: {str(e)}")
            results['errors'].append(f"Neon hypergraph sync: {str(e)}")
    
    def get_sync_status(self) -> Dict[str, Any]:
        """Get current sync status"""
        return {
            'last_sync': self.sync_log[-1] if self.sync_log else None,
            'total_syncs': len(self.sync_log),
            'supabase_configured': bool(self.supabase_url and self.supabase_key)
        }


def main():
    """Main execution function"""
    manager = MasterSyncManager()
    results = manager.sync_all()
    
    # Save results
    output_file = Path(__file__).parent.parent.parent / "sync_results.json"
    with open(output_file, 'w') as f:
        json.dump(results, f, indent=2)
    
    print(f"\n✅ Sync completed!")
    print(f"Success: {results['success']}")
    print(f"Operations: {len(results['operations'])}")
    if results['errors']:
        print(f"Errors: {len(results['errors'])}")
        for error in results['errors']:
            print(f"  - {error}")
    
    return results


if __name__ == "__main__":
    main()
