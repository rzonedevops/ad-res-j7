"""
Repository Change Tracker
Tracks repository changes and prepares them for database synchronization.
"""

import json
import logging
import subprocess
from typing import Dict, List, Optional, Any
from datetime import datetime
from pathlib import Path
from dataclasses import dataclass, asdict

# Configure logging
logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(name)s - %(levelname)s - %(message)s'
)
logger = logging.getLogger(__name__)


@dataclass
class RepositoryChange:
    """Data class for repository changes"""
    change_id: str
    timestamp: str
    change_type: str  # 'added', 'modified', 'deleted'
    file_path: str
    description: str
    author: str
    commit_hash: Optional[str] = None
    lines_added: int = 0
    lines_deleted: int = 0
    metadata: Optional[Dict[str, Any]] = None
    
    def to_dict(self) -> Dict[str, Any]:
        """Convert to dictionary"""
        return asdict(self)


class RepositoryChangeTracker:
    """
    Tracks changes in the repository for database synchronization.
    """
    
    def __init__(self, repo_path: str = "."):
        """
        Initialize the repository change tracker.
        
        Args:
            repo_path: Path to the repository (default: current directory)
        """
        self.repo_path = Path(repo_path).resolve()
        self.changes: List[RepositoryChange] = []
        
        logger.info(f"Repository Change Tracker initialized for: {self.repo_path}")
    
    def get_git_status(self) -> Dict[str, List[str]]:
        """
        Get current git status.
        
        Returns:
            Dictionary with lists of added, modified, and deleted files
        """
        try:
            result = subprocess.run(
                ["git", "status", "--porcelain"],
                cwd=self.repo_path,
                capture_output=True,
                text=True,
                timeout=10
            )
            
            if result.returncode != 0:
                logger.error(f"Git status failed: {result.stderr}")
                return {"added": [], "modified": [], "deleted": []}
            
            status = {
                "added": [],
                "modified": [],
                "deleted": [],
                "untracked": []
            }
            
            for line in result.stdout.strip().split('\n'):
                if not line:
                    continue
                
                status_code = line[:2]
                file_path = line[3:].strip()
                
                if status_code.strip() == 'A' or status_code.strip() == '??':
                    status["added"].append(file_path)
                elif status_code.strip() == 'M':
                    status["modified"].append(file_path)
                elif status_code.strip() == 'D':
                    status["deleted"].append(file_path)
                elif status_code.strip() == '??':
                    status["untracked"].append(file_path)
            
            return status
            
        except Exception as e:
            logger.error(f"Failed to get git status: {e}")
            return {"added": [], "modified": [], "deleted": []}
    
    def get_recent_commits(self, count: int = 10) -> List[Dict[str, Any]]:
        """
        Get recent git commits.
        
        Args:
            count: Number of recent commits to retrieve
            
        Returns:
            List of commit information dictionaries
        """
        try:
            result = subprocess.run(
                ["git", "log", f"-{count}", "--pretty=format:%H|%an|%ae|%at|%s"],
                cwd=self.repo_path,
                capture_output=True,
                text=True,
                timeout=10
            )
            
            if result.returncode != 0:
                logger.error(f"Git log failed: {result.stderr}")
                return []
            
            commits = []
            for line in result.stdout.strip().split('\n'):
                if not line:
                    continue
                
                parts = line.split('|')
                if len(parts) >= 5:
                    commits.append({
                        "hash": parts[0],
                        "author": parts[1],
                        "email": parts[2],
                        "timestamp": datetime.fromtimestamp(int(parts[3])).isoformat(),
                        "message": parts[4]
                    })
            
            return commits
            
        except Exception as e:
            logger.error(f"Failed to get recent commits: {e}")
            return []
    
    def get_file_changes(self, file_path: str) -> Dict[str, int]:
        """
        Get line changes for a specific file.
        
        Args:
            file_path: Path to the file
            
        Returns:
            Dictionary with lines_added and lines_deleted
        """
        try:
            result = subprocess.run(
                ["git", "dif", "--numstat", "HEAD", file_path],
                cwd=self.repo_path,
                capture_output=True,
                text=True,
                timeout=10
            )
            
            if result.returncode != 0 or not result.stdout.strip():
                return {"lines_added": 0, "lines_deleted": 0}
            
            parts = result.stdout.strip().split()
            if len(parts) >= 2:
                return {
                    "lines_added": int(parts[0]) if parts[0] != '-' else 0,
                    "lines_deleted": int(parts[1]) if parts[1] != '-' else 0
                }
            
            return {"lines_added": 0, "lines_deleted": 0}
            
        except Exception as e:
            logger.error(f"Failed to get file changes for {file_path}: {e}")
            return {"lines_added": 0, "lines_deleted": 0}
    
    def track_current_changes(self) -> List[RepositoryChange]:
        """
        Track current repository changes.
        
        Returns:
            List of RepositoryChange objects
        """
        logger.info("Tracking current repository changes...")
        
        status = self.get_git_status()
        changes = []
        
        # Get author information
        try:
            author_result = subprocess.run(
                ["git", "config", "user.name"],
                cwd=self.repo_path,
                capture_output=True,
                text=True,
                timeout=5
            )
            author = author_result.stdout.strip() if author_result.returncode == 0 else "Unknown"
        except Exception:
            author = "Unknown"
        
        timestamp = datetime.now().isoformat()
        
        # Track added files
        for file_path in status["added"]:
            change = RepositoryChange(
                change_id=f"add_{hash(file_path)}_{timestamp}",
                timestamp=timestamp,
                change_type="added",
                file_path=file_path,
                description=f"Added new file: {file_path}",
                author=author,
                metadata={"status": "added"}
            )
            changes.append(change)
        
        # Track modified files
        for file_path in status["modified"]:
            file_changes = self.get_file_changes(file_path)
            change = RepositoryChange(
                change_id=f"mod_{hash(file_path)}_{timestamp}",
                timestamp=timestamp,
                change_type="modified",
                file_path=file_path,
                description=f"Modified file: {file_path}",
                author=author,
                lines_added=file_changes["lines_added"],
                lines_deleted=file_changes["lines_deleted"],
                metadata={"status": "modified", "changes": file_changes}
            )
            changes.append(change)
        
        # Track deleted files
        for file_path in status["deleted"]:
            change = RepositoryChange(
                change_id=f"del_{hash(file_path)}_{timestamp}",
                timestamp=timestamp,
                change_type="deleted",
                file_path=file_path,
                description=f"Deleted file: {file_path}",
                author=author,
                metadata={"status": "deleted"}
            )
            changes.append(change)
        
        self.changes.extend(changes)
        logger.info(f"Tracked {len(changes)} changes")
        
        return changes
    
    def get_changes_summary(self) -> Dict[str, Any]:
        """
        Get summary of tracked changes.
        
        Returns:
            Dictionary with change statistics
        """
        summary = {
            "total_changes": len(self.changes),
            "added": sum(1 for c in self.changes if c.change_type == "added"),
            "modified": sum(1 for c in self.changes if c.change_type == "modified"),
            "deleted": sum(1 for c in self.changes if c.change_type == "deleted"),
            "total_lines_added": sum(c.lines_added for c in self.changes),
            "total_lines_deleted": sum(c.lines_deleted for c in self.changes),
            "authors": list(set(c.author for c in self.changes)),
            "timestamp": datetime.now().isoformat()
        }
        
        return summary
    
    def export_changes(self, output_file: str):
        """
        Export tracked changes to JSON file.
        
        Args:
            output_file: Path to output JSON file
        """
        data = {
            "summary": self.get_changes_summary(),
            "changes": [change.to_dict() for change in self.changes]
        }
        
        with open(output_file, 'w') as f:
            json.dump(data, f, indent=2)
        
        logger.info(f"Changes exported to {output_file}")
    
    def prepare_sync_data(self) -> Dict[str, Any]:
        """
        Prepare data for database synchronization.
        
        Returns:
            Dictionary with sync-ready data
        """
        return {
            "repository": str(self.repo_path),
            "summary": self.get_changes_summary(),
            "changes": [change.to_dict() for change in self.changes],
            "recent_commits": self.get_recent_commits(count=5)
        }


def main():
    """Main function for testing"""
    tracker = RepositoryChangeTracker()
    changes = tracker.track_current_changes()
    
    summary = tracker.get_changes_summary()
    print(json.dumps(summary, indent=2))
    
    # Export changes
    tracker.export_changes("repository_changes.json")
    
    return changes


if __name__ == "__main__":
    main()

