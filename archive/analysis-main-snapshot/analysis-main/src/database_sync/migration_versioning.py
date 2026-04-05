#!/usr/bin/env python3
"""
Database Migration Versioning System
Manages versioned migrations for Supabase and Neon databases
"""

import os
import json
import hashlib
from datetime import datetime
from pathlib import Path
from typing import Dict, List, Optional, Any

class MigrationVersioning:
    """Manages database migration versions"""
    
    def __init__(self, migrations_dir: Optional[Path] = None):
        self.repo_path = Path(__file__).parent.parent.parent
        self.migrations_dir = migrations_dir or (self.repo_path / "migrations")
        self.migrations_dir.mkdir(exist_ok=True)
        self.version_file = self.migrations_dir / "versions.json"
        self.versions = self._load_versions()
    
    def _load_versions(self) -> Dict:
        """Load migration versions from file"""
        if self.version_file.exists():
            with open(self.version_file, 'r') as f:
                return json.load(f)
        return {
            "migrations": [],
            "last_updated": None,
            "current_version": "0.0.0"
        }
    
    def _save_versions(self):
        """Save migration versions to file"""
        with open(self.version_file, 'w') as f:
            json.dump(self.versions, f, indent=2)
    
    def create_migration(self, name: str, sql_content: str, 
                        target: str = "both") -> Dict[str, Any]:
        """
        Create a new migration
        
        Args:
            name: Migration name
            sql_content: SQL content for the migration
            target: Target database ('supabase', 'neon', or 'both')
            
        Returns:
            Migration metadata
        """
        # Generate version number
        version = self._generate_version()
        timestamp = datetime.now().isoformat()
        
        # Create migration file
        migration_file = self.migrations_dir / f"v{version}_{name}.sql"
        with open(migration_file, 'w') as f:
            f.write(f"-- Migration: {name}\n")
            f.write(f"-- Version: {version}\n")
            f.write(f"-- Target: {target}\n")
            f.write(f"-- Created: {timestamp}\n\n")
            f.write(sql_content)
        
        # Calculate checksum
        checksum = hashlib.sha256(sql_content.encode()).hexdigest()
        
        # Create migration metadata
        migration = {
            "version": version,
            "name": name,
            "file": str(migration_file.name),
            "target": target,
            "checksum": checksum,
            "created_at": timestamp,
            "applied_supabase": False,
            "applied_neon": False,
            "applied_at_supabase": None,
            "applied_at_neon": None
        }
        
        # Add to versions
        self.versions["migrations"].append(migration)
        self.versions["current_version"] = version
        self.versions["last_updated"] = timestamp
        self._save_versions()
        
        return migration
    
    def _generate_version(self) -> str:
        """Generate next version number"""
        current = self.versions["current_version"]
        parts = current.split(".")
        parts[-1] = str(int(parts[-1]) + 1)
        return ".".join(parts)
    
    def get_pending_migrations(self, target: str = "both") -> List[Dict]:
        """Get migrations pending application"""
        pending = []
        for migration in self.versions["migrations"]:
            if target == "both":
                if not migration["applied_supabase"] or not migration["applied_neon"]:
                    pending.append(migration)
            elif target == "supabase" and not migration["applied_supabase"]:
                pending.append(migration)
            elif target == "neon" and not migration["applied_neon"]:
                pending.append(migration)
        return pending
    
    def mark_applied(self, version: str, target: str):
        """Mark a migration as applied"""
        for migration in self.versions["migrations"]:
            if migration["version"] == version:
                if target == "supabase":
                    migration["applied_supabase"] = True
                    migration["applied_at_supabase"] = datetime.now().isoformat()
                elif target == "neon":
                    migration["applied_neon"] = True
                    migration["applied_at_neon"] = datetime.now().isoformat()
                self._save_versions()
                break
    
    def consolidate_schemas(self):
        """Consolidate existing schema files into migrations"""
        print("Consolidating schema files...")
        
        # Find all schema files
        schema_files = [
            "supabase_schema_enhanced.sql",
            "neon_schema_enhanced.sql"
        ]
        
        for schema_file in schema_files:
            schema_path = self.repo_path / schema_file
            if schema_path.exists():
                target = "supabase" if "supabase" in schema_file else "neon"
                name = f"consolidated_{target}_schema"
                
                with open(schema_path, 'r') as f:
                    content = f.read()
                
                self.create_migration(name, content, target)
                print(f"Created migration from {schema_file}")
        
        print("Schema consolidation complete!")


def main():
    """Main execution"""
    versioning = MigrationVersioning()
    
    # Consolidate existing schemas
    versioning.consolidate_schemas()
    
    # Show status
    print(f"\nCurrent version: {versioning.versions['current_version']}")
    print(f"Total migrations: {len(versioning.versions['migrations'])}")
    
    pending = versioning.get_pending_migrations()
    print(f"Pending migrations: {len(pending)}")


if __name__ == "__main__":
    main()
