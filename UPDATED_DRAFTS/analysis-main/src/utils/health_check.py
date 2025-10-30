"""
Health Check Utility for Database Connections

Provides comprehensive health checks for Supabase and Neon databases.
"""

import logging
import time
from datetime import datetime
from typing import Dict, Any, Optional
from dataclasses import dataclass, asdict

from src.config import get_config


logger = logging.getLogger(__name__)


@dataclass
class HealthStatus:
    """Health status for a database connection."""
    
    name: str
    status: str  # "healthy", "degraded", "unhealthy", "unavailable"
    response_time_ms: Optional[float] = None
    error_message: Optional[str] = None
    last_check: Optional[str] = None
    details: Optional[Dict[str, Any]] = None
    
    def to_dict(self) -> Dict[str, Any]:
        """Convert to dictionary."""
        return asdict(self)
    
    @property
    def is_healthy(self) -> bool:
        """Check if the status is healthy."""
        return self.status == "healthy"


class HealthChecker:
    """Performs health checks on database connections."""
    
    def __init__(self):
        self.config = get_config()
    
    def check_supabase(self) -> HealthStatus:
        """
        Check Supabase connection health.
        
        Returns:
            HealthStatus: Health status of Supabase connection
        """
        start_time = time.time()
        
        try:
            # Check if credentials are configured
            if not self.config.database.supabase_url or not self.config.database.supabase_key:
                return HealthStatus(
                    name="Supabase",
                    status="unavailable",
                    error_message="Credentials not configured",
                    last_check=datetime.now().isoformat()
                )
            
            # Try to import and connect
            try:
                from src.database_sync.enhanced_client import EnhancedSupabaseClient
                
                client = EnhancedSupabaseClient()
                is_healthy = client.health_check()
                
                response_time = (time.time() - start_time) * 1000  # Convert to ms
                
                if is_healthy:
                    return HealthStatus(
                        name="Supabase",
                        status="healthy",
                        response_time_ms=round(response_time, 2),
                        last_check=datetime.now().isoformat(),
                        details={
                            "url": self.config.database.supabase_url,
                            "has_service_role_key": bool(self.config.database.supabase_service_role_key)
                        }
                    )
                else:
                    return HealthStatus(
                        name="Supabase",
                        status="unhealthy",
                        response_time_ms=round(response_time, 2),
                        error_message="Health check failed",
                        last_check=datetime.now().isoformat()
                    )
                    
            except ImportError as e:
                return HealthStatus(
                    name="Supabase",
                    status="unavailable",
                    error_message=f"Client not available: {e}",
                    last_check=datetime.now().isoformat()
                )
                
        except Exception as e:
            response_time = (time.time() - start_time) * 1000
            return HealthStatus(
                name="Supabase",
                status="unhealthy",
                response_time_ms=round(response_time, 2),
                error_message=str(e),
                last_check=datetime.now().isoformat()
            )
    
    def check_neon(self) -> HealthStatus:
        """
        Check Neon connection health.
        
        Returns:
            HealthStatus: Health status of Neon connection
        """
        start_time = time.time()
        
        try:
            # Check if credentials are configured
            has_connection_string = bool(self.config.database.neon_connection_string)
            has_individual_creds = bool(
                self.config.database.neon_host and
                self.config.database.neon_database and
                self.config.database.neon_user and
                self.config.database.neon_password
            )
            
            if not (has_connection_string or has_individual_creds):
                return HealthStatus(
                    name="Neon",
                    status="unavailable",
                    error_message="Credentials not configured",
                    last_check=datetime.now().isoformat()
                )
            
            # Try to import and connect
            try:
                from src.database_sync.enhanced_client import EnhancedNeonClient
                
                client = EnhancedNeonClient()
                is_healthy = client.health_check()
                
                response_time = (time.time() - start_time) * 1000  # Convert to ms
                
                if is_healthy:
                    details = {}
                    if self.config.database.neon_host:
                        details["host"] = self.config.database.neon_host
                        details["database"] = self.config.database.neon_database
                    else:
                        details["connection_string_configured"] = True
                    
                    return HealthStatus(
                        name="Neon",
                        status="healthy",
                        response_time_ms=round(response_time, 2),
                        last_check=datetime.now().isoformat(),
                        details=details
                    )
                else:
                    return HealthStatus(
                        name="Neon",
                        status="unhealthy",
                        response_time_ms=round(response_time, 2),
                        error_message="Health check failed",
                        last_check=datetime.now().isoformat()
                    )
                    
            except ImportError as e:
                return HealthStatus(
                    name="Neon",
                    status="unavailable",
                    error_message=f"Client not available: {e}",
                    last_check=datetime.now().isoformat()
                )
                
        except Exception as e:
            response_time = (time.time() - start_time) * 1000
            return HealthStatus(
                name="Neon",
                status="unhealthy",
                response_time_ms=round(response_time, 2),
                error_message=str(e),
                last_check=datetime.now().isoformat()
            )
    
    def check_all(self) -> Dict[str, HealthStatus]:
        """
        Check health of all configured databases.
        
        Returns:
            Dict[str, HealthStatus]: Health status for each database
        """
        results = {}
        
        logger.info("Running health checks...")
        
        # Check Supabase
        supabase_status = self.check_supabase()
        results["supabase"] = supabase_status
        logger.info(f"Supabase: {supabase_status.status}")
        
        # Check Neon
        neon_status = self.check_neon()
        results["neon"] = neon_status
        logger.info(f"Neon: {neon_status.status}")
        
        return results
    
    def print_health_report(self) -> bool:
        """
        Print a comprehensive health report.
        
        Returns:
            bool: True if all systems are healthy, False otherwise
        """
        results = self.check_all()
        
        print("\n" + "=" * 80)
        print("DATABASE HEALTH CHECK REPORT")
        print(f"Timestamp: {datetime.now().isoformat()}")
        print("=" * 80 + "\n")
        
        all_healthy = True
        
        for db_name, status in results.items():
            print(f"Database: {status.name}")
            print(f"  Status: {status.status.upper()}")
            
            if status.response_time_ms is not None:
                print(f"  Response Time: {status.response_time_ms}ms")
            
            if status.error_message:
                print(f"  Error: {status.error_message}")
                all_healthy = False
            
            if status.details:
                print("  Details:")
                for key, value in status.details.items():
                    print(f"    - {key}: {value}")
            
            print()
        
        print("=" * 80)
        
        if all_healthy:
            print("✅ All database connections are healthy")
        else:
            print("⚠️  Some database connections have issues")
        
        print("=" * 80 + "\n")
        
        return all_healthy


def main():
    """Main function for running health checks from command line."""
    import sys
    
    logging.basicConfig(
        level=logging.INFO,
        format='%(asctime)s - %(name)s - %(levelname)s - %(message)s'
    )
    
    checker = HealthChecker()
    all_healthy = checker.print_health_report()
    
    sys.exit(0 if all_healthy else 1)


if __name__ == "__main__":
    main()

