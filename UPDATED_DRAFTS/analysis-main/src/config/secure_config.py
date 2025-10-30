#!/usr/bin/env python3
"""
Secure Configuration Handler
Manages sensitive configuration using environment variables
"""

import os
from typing import Dict, Any


class SecureConfig:
    """Secure configuration management"""
    
    def __init__(self):
        self._config = self._load_config()
    
    def _load_config(self) -> Dict[str, Any]:
        """Load configuration from environment variables"""
        return {
            'supabase': {
                'url': os.getenv('SUPABASE_URL'),
                'key': os.getenv('SUPABASE_KEY')
            },
            'openai': {
                'api_key': os.getenv('OPENAI_API_KEY')
            },
            'app': {
                'debug': os.getenv('DEBUG', 'false').lower() == 'true',
                'log_level': os.getenv('LOG_LEVEL', 'INFO')
            }
        }
    
    def get(self, key_path: str, default: Any = None) -> Any:
        """Get configuration value by dot-notation path"""
        keys = key_path.split('.')
        value = self._config
        
        for key in keys:
            if isinstance(value, dict) and key in value:
                value = value[key]
            else:
                return default
        
        return value
    
    def validate(self) -> Dict[str, bool]:
        """Validate required configuration"""
        return {
            'supabase_configured': bool(
                self.get('supabase.url') and self.get('supabase.key')
            ),
            'openai_configured': bool(self.get('openai.api_key'))
        }


config = SecureConfig()


def get_config() -> SecureConfig:
    """Get global configuration instance"""
    return config


if __name__ == "__main__":
    cfg = get_config()
    print("Configuration Validation:")
    for key, value in cfg.validate().items():
        status = "✅" if value else "❌"
        print(f"{status} {key}: {value}")
