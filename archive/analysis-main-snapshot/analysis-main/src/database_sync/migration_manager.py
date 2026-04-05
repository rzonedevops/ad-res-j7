#!/usr/bin/env python3
"""
Enhanced Database Migration Manager

Provides versioned migrations with rollback support for Supabase and Neon databases.

Author: Manus AI - Hyper-Holmes Turbo-Solve Mode
Date: October 17, 2025
"""

import os
import json
import hashlib
from datetime import datetime
from typing import List, Dict, Optional, Tuple
from pathlib import Path
import logging

logger = logging.getLogger(__name__)


class Migration:
    """Represents a single database migration."""
    
    def __init__(
        self,
        version: str,
        name: str,
        up_sql: str,
        down_sql: Optional[str] = None,
        description: Optional[str] = None
    ):
        """
        Initialize a migration.
        
        Args:
            version: Migration version (e.g., "001", "002")
            name: Migration name (e.g., "add_evidence_table")
            up_sql: SQL to apply the migration
            down_sql: SQL to rollback the migration
            description: Human-readable description
        """
        self.version = version
        self.name = name
        self.up_sql = up_sql
        self.down_sql = down_sql
        self.description = description or f"Migration {version}: {name}"
        self.checksum = self._calculate_checksum()
        self.applied_at: Optional[datetime] = None
    
    def _calculate_checksum(self) -> str:
        """Calculate checksum of the migration SQL."""
        content = f"{self.version}{self.name}{self.up_sql}"
        return hashlib.sha256(content.encode()).hexdigest()
    
    def to_dict(self) -> Dict:
        """Convert migration to dictionary."""
        return {
            'version': self.version,
            'name': self.name,
            'description': self.description,
            'checksum': self.checksum,
            'applied_at': self.applied_at.isoformat() if self.applied_at else None
        }
    
    @classmethod
    def from_dict(cls, data: Dict) -> 'Migration':
        """Create migration from dictionary."""
        migration = cls(
            version=data['version'],
            name=data['name'],
            up_sql=data.get('up_sql', ''),
            down_sql=data.get('down_sql'),
            description=data.get('description')
        )
        if data.get('applied_at'):
            migration.applied_at = datetime.fromisoformat(data['applied_at'])
        return migration


class MigrationManager:
    """Manages database migrations with versioning and rollback support."""
    
    def __init__(self, migrations_dir: str = "migrations"):
        """
        Initialize the migration manager.
        
        Args:
            migrations_dir: Directory containing migration files
        """
        self.migrations_dir = Path(migrations_dir)
        self.migrations_dir.mkdir(exist_ok=True)
        self.state_file = self.migrations_dir / "migration_state.json"
        self.migrations: List[Migration] = []
        self.applied_migrations: Dict[str, Migration] = {}
        self._load_state()
    
    def _load_state(self):
        """Load migration state from file."""
        if self.state_file.exists():
            try:
                with open(self.state_file, 'r') as f:
                    state = json.load(f)
                    for migration_data in state.get('applied', []):
                        migration = Migration.from_dict(migration_data)
                        self.applied_migrations[migration.version] = migration
            except Exception as e:
                logger.error(f"Failed to load migration state: {e}")
    
    def _save_state(self):
        """Save migration state to file."""
        try:
            state = {
                'applied': [m.to_dict() for m in self.applied_migrations.values()],
                'last_updated': datetime.now().isoformat()
            }
            with open(self.state_file, 'w') as f:
                json.dump(state, f, indent=2)
        except Exception as e:
            logger.error(f"Failed to save migration state: {e}")
    
    def add_migration(
        self,
        name: str,
        up_sql: str,
        down_sql: Optional[str] = None,
        description: Optional[str] = None
    ) -> Migration:
        """
        Add a new migration.
        
        Args:
            name: Migration name
            up_sql: SQL to apply the migration
            down_sql: SQL to rollback the migration
            description: Human-readable description
            
        Returns:
            The created Migration object
        """
        # Generate version number
        version = f"{len(self.migrations) + 1:03d}"
        
        migration = Migration(
            version=version,
            name=name,
            up_sql=up_sql,
            down_sql=down_sql,
            description=description
        )
        
        self.migrations.append(migration)
        
        # Save migration to file
        migration_file = self.migrations_dir / f"{version}_{name}.sql"
        with open(migration_file, 'w') as f:
            f.write(f"-- Migration: {version} - {name}\n")
            f.write(f"-- Description: {description or 'No description'}\n")
            f.write(f"-- Created: {datetime.now().isoformat()}\n\n")
            f.write("-- UP\n")
            f.write(up_sql)
            f.write("\n\n-- DOWN\n")
            if down_sql:
                f.write(down_sql)
            else:
                f.write("-- No rollback SQL provided\n")
        
        logger.info(f"Created migration {version}: {name}")
        return migration
    
    def get_pending_migrations(self) -> List[Migration]:
        """
        Get list of migrations that haven't been applied yet.
        
        Returns:
            List of pending migrations
        """
        return [
            m for m in self.migrations
            if m.version not in self.applied_migrations
        ]
    
    def apply_migration(self, migration: Migration, execute_func) -> bool:
        """
        Apply a single migration.
        
        Args:
            migration: Migration to apply
            execute_func: Function to execute SQL (should accept sql string)
            
        Returns:
            True if successful, False otherwise
        """
        try:
            logger.info(f"Applying migration {migration.version}: {migration.name}")
            
            # Execute the migration SQL
            execute_func(migration.up_sql)
            
            # Mark as applied
            migration.applied_at = datetime.now()
            self.applied_migrations[migration.version] = migration
            self._save_state()
            
            logger.info(f"Successfully applied migration {migration.version}")
            return True
            
        except Exception as e:
            logger.error(f"Failed to apply migration {migration.version}: {e}")
            return False
    
    def rollback_migration(self, migration: Migration, execute_func) -> bool:
        """
        Rollback a single migration.
        
        Args:
            migration: Migration to rollback
            execute_func: Function to execute SQL
            
        Returns:
            True if successful, False otherwise
        """
        try:
            if not migration.down_sql:
                logger.error(f"No rollback SQL for migration {migration.version}")
                return False
            
            logger.info(f"Rolling back migration {migration.version}: {migration.name}")
            
            # Execute the rollback SQL
            execute_func(migration.down_sql)
            
            # Remove from applied migrations
            if migration.version in self.applied_migrations:
                del self.applied_migrations[migration.version]
                self._save_state()
            
            logger.info(f"Successfully rolled back migration {migration.version}")
            return True
            
        except Exception as e:
            logger.error(f"Failed to rollback migration {migration.version}: {e}")
            return False
    
    def apply_all_pending(self, execute_func) -> Tuple[int, int]:
        """
        Apply all pending migrations.
        
        Args:
            execute_func: Function to execute SQL
            
        Returns:
            Tuple of (successful_count, failed_count)
        """
        pending = self.get_pending_migrations()
        successful = 0
        failed = 0
        
        for migration in pending:
            if self.apply_migration(migration, execute_func):
                successful += 1
            else:
                failed += 1
                # Stop on first failure
                break
        
        return successful, failed
    
    def get_migration_status(self) -> Dict:
        """
        Get current migration status.
        
        Returns:
            Dictionary with migration status information
        """
        pending = self.get_pending_migrations()
        
        return {
            'total_migrations': len(self.migrations),
            'applied_migrations': len(self.applied_migrations),
            'pending_migrations': len(pending),
            'last_applied': max(
                (m.applied_at for m in self.applied_migrations.values()),
                default=None
            ),
            'pending_versions': [m.version for m in pending]
        }
    
    def validate_checksums(self) -> List[str]:
        """
        Validate checksums of applied migrations.
        
        Returns:
            List of migration versions with checksum mismatches
        """
        mismatches = []
        
        for version, applied_migration in self.applied_migrations.items():
            # Find the migration in our current list
            current_migration = next(
                (m for m in self.migrations if m.version == version),
                None
            )
            
            if current_migration:
                if current_migration.checksum != applied_migration.checksum:
                    mismatches.append(version)
                    logger.warning(
                        f"Checksum mismatch for migration {version}: "
                        f"expected {applied_migration.checksum}, "
                        f"got {current_migration.checksum}"
                    )
        
        return mismatches


def create_initial_migrations() -> MigrationManager:
    """
    Create initial migrations for the analysis repository.
    
    Returns:
        MigrationManager with initial migrations
    """
    manager = MigrationManager()
    
    # Migration 001: Create migration tracking table
    manager.add_migration(
        name="create_migration_tracking",
        description="Create table to track applied migrations",
        up_sql="""
        CREATE TABLE IF NOT EXISTS schema_migrations (
            version VARCHAR(10) PRIMARY KEY,
            name VARCHAR(255) NOT NULL,
            description TEXT,
            checksum VARCHAR(64) NOT NULL,
            applied_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
            applied_by VARCHAR(100),
            execution_time_ms INTEGER
        );
        
        CREATE INDEX IF NOT EXISTS idx_migrations_applied_at 
        ON schema_migrations(applied_at);
        """,
        down_sql="""
        DROP TABLE IF EXISTS schema_migrations;
        """
    )
    
    # Migration 002: Create sync log enhancements
    manager.add_migration(
        name="enhance_sync_log",
        description="Add enhanced sync logging capabilities",
        up_sql="""
        CREATE TABLE IF NOT EXISTS sync_log_enhanced (
            id SERIAL PRIMARY KEY,
            sync_type VARCHAR(50) NOT NULL,
            source_db VARCHAR(50) NOT NULL,
            target_db VARCHAR(50) NOT NULL,
            status VARCHAR(20) NOT NULL,
            started_at TIMESTAMP NOT NULL,
            completed_at TIMESTAMP,
            duration_ms INTEGER,
            records_processed INTEGER DEFAULT 0,
            records_failed INTEGER DEFAULT 0,
            error_message TEXT,
            metadata JSONB,
            created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
        );
        
        CREATE INDEX IF NOT EXISTS idx_sync_log_enhanced_type 
        ON sync_log_enhanced(sync_type);
        
        CREATE INDEX IF NOT EXISTS idx_sync_log_enhanced_status 
        ON sync_log_enhanced(status);
        
        CREATE INDEX IF NOT EXISTS idx_sync_log_enhanced_started 
        ON sync_log_enhanced(started_at);
        """,
        down_sql="""
        DROP TABLE IF EXISTS sync_log_enhanced;
        """
    )
    
    # Migration 003: Add schema version tracking
    manager.add_migration(
        name="add_schema_version",
        description="Track schema version for drift detection",
        up_sql="""
        CREATE TABLE IF NOT EXISTS schema_version (
            id SERIAL PRIMARY KEY,
            version VARCHAR(20) NOT NULL,
            description TEXT,
            applied_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
            checksum VARCHAR(64) NOT NULL,
            UNIQUE(version)
        );
        
        INSERT INTO schema_version (version, description, checksum)
        VALUES ('1.0.0', 'Initial schema version', 'initial')
        ON CONFLICT (version) DO NOTHING;
        """,
        down_sql="""
        DROP TABLE IF EXISTS schema_version;
        """
    )
    
    return manager


if __name__ == "__main__":
    # Example usage
    logging.basicConfig(level=logging.INFO)
    
    manager = create_initial_migrations()
    status = manager.get_migration_status()
    
    print("Migration Status:")
    print(f"  Total migrations: {status['total_migrations']}")
    print(f"  Applied: {status['applied_migrations']}")
    print(f"  Pending: {status['pending_migrations']}")
    print(f"  Pending versions: {status['pending_versions']}")

