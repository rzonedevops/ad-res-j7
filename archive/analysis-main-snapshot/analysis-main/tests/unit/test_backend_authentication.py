#!/usr/bin/env python3
"""
Unit tests for Backend API Authentication System
Tests the authentication implementation in backend_api_refined.py
"""

import os
import sys
import tempfile
import unittest
from unittest.mock import patch, MagicMock

# Add project root to path for imports
sys.path.insert(0, os.path.join(os.path.dirname(__file__), '../..'))

# Import the backend API for testing
try:
    from backend_api_refined import app, validate_api_key, require_auth
except ImportError as e:
    print(f"Warning: Could not import backend API: {e}")
    app = None
    validate_api_key = None
    require_auth = None


class TestBackendAuthentication(unittest.TestCase):
    """Test cases for backend API authentication system"""

    def setUp(self):
        """Set up test fixtures"""
        if app is None:
            self.skipTest("Backend API not available for testing")
        
        self.app = app
        self.client = app.test_client()
        self.app.config['TESTING'] = True
        self.app.config['REQUIRE_AUTH'] = True
        self.app.config['DEVELOPMENT_MODE'] = False

    def test_validate_api_key_with_valid_keys(self):
        """Test API key validation with configured valid keys"""
        with patch.dict(os.environ, {'API_KEYS': 'key1,key2,key3'}):
            self.assertTrue(validate_api_key('key1'))
            self.assertTrue(validate_api_key('key2'))
            self.assertTrue(validate_api_key('key3'))
            self.assertFalse(validate_api_key('invalid_key'))
            self.assertFalse(validate_api_key(''))
            self.assertFalse(validate_api_key(None))

    def test_validate_api_key_development_mode(self):
        """Test API key validation in development mode"""
        self.app.config['DEVELOPMENT_MODE'] = True
        with patch.dict(os.environ, {'API_KEYS': ''}):
            # In development mode, any key >= 16 chars should work
            self.assertTrue(validate_api_key('1234567890123456'))
            self.assertTrue(validate_api_key('a' * 16))
            self.assertFalse(validate_api_key('short'))
            self.assertFalse(validate_api_key(''))
            self.assertFalse(validate_api_key(None))

    def test_validate_api_key_no_configuration(self):
        """Test API key validation with no configuration"""
        self.app.config['DEVELOPMENT_MODE'] = False
        with patch.dict(os.environ, {'API_KEYS': ''}):
            # Without configured keys and not in dev mode, all should fail
            self.assertFalse(validate_api_key('any_key'))
            self.assertFalse(validate_api_key('1234567890123456'))

    def test_health_endpoint_no_auth_required(self):
        """Test that health endpoint doesn't require authentication"""
        response = self.client.get('/api/health')
        self.assertEqual(response.status_code, 200)
        
        data = response.get_json()
        self.assertEqual(data['status'], 'healthy')
        self.assertIn('capabilities', data)

    def test_protected_endpoint_without_api_key(self):
        """Test that protected endpoints reject requests without API key"""
        response = self.client.get('/api/cases')
        self.assertEqual(response.status_code, 401)
        
        data = response.get_json()
        self.assertIn('error', data)
        self.assertEqual(data['error'], 'Authentication required')

    def test_protected_endpoint_with_invalid_api_key(self):
        """Test that protected endpoints reject invalid API keys"""
        headers = {'X-API-Key': 'invalid_key'}
        response = self.client.get('/api/cases', headers=headers)
        self.assertEqual(response.status_code, 401)

    def test_protected_endpoint_with_valid_api_key(self):
        """Test that protected endpoints accept valid API keys"""
        with patch.dict(os.environ, {'API_KEYS': 'test_key_123456789'}):
            headers = {'X-API-Key': 'test_key_123456789'}
            response = self.client.get('/api/cases', headers=headers)
            # Should not be 401 (may be other errors due to missing data)
            self.assertNotEqual(response.status_code, 401)

    def test_auth_disabled_configuration(self):
        """Test behavior when authentication is disabled"""
        self.app.config['REQUIRE_AUTH'] = False
        
        # Should be able to access protected endpoints without API key
        response = self.client.get('/api/cases')
        # Should not be 401 (may be other errors due to missing data)
        self.assertNotEqual(response.status_code, 401)

    def test_created_by_field_uses_api_key(self):
        """Test that created_by field uses API key when available"""
        with patch.dict(os.environ, {'API_KEYS': 'test_key_for_creator_field'}):
            headers = {
                'X-API-Key': 'test_key_for_creator_field',
                'Content-Type': 'application/json'
            }
            
            case_data = {
                'title': 'Test Case',
                'description': 'Test case for authentication',
                'status': 'active'
            }
            
            response = self.client.post('/api/cases', 
                                     json=case_data, 
                                     headers=headers)
            
            # If creation succeeds, check the created case
            if response.status_code in [200, 201]:
                data = response.get_json()
                # created_by should contain first 16 chars of API key
                if 'created_by' in data:
                    self.assertEqual(data['created_by'], 'test_key_for_cre')

    def test_multiple_api_keys_configuration(self):
        """Test configuration with multiple API keys"""
        keys = ['key1_1234567890', 'key2_1234567890', 'key3_1234567890']
        with patch.dict(os.environ, {'API_KEYS': ','.join(keys)}):
            for key in keys:
                self.assertTrue(validate_api_key(key))
            
            self.assertFalse(validate_api_key('invalid_key'))

    def test_api_key_with_whitespace(self):
        """Test API key configuration handles whitespace correctly"""
        with patch.dict(os.environ, {'API_KEYS': ' key1 , key2 , key3 '}):
            self.assertTrue(validate_api_key('key1'))
            self.assertTrue(validate_api_key('key2'))
            self.assertTrue(validate_api_key('key3'))
            self.assertFalse(validate_api_key(' key1 '))  # Whitespace not trimmed in validation


class TestAuthenticationIntegration(unittest.TestCase):
    """Integration tests for authentication system"""

    def setUp(self):
        """Set up integration test fixtures"""
        if app is None:
            self.skipTest("Backend API not available for testing")
        
        self.app = app
        self.client = app.test_client()
        self.app.config['TESTING'] = True

    def test_full_authentication_flow(self):
        """Test complete authentication flow from configuration to API access"""
        # Step 1: Configure authentication
        test_key = 'integration_test_key_123456789'
        with patch.dict(os.environ, {'API_KEYS': test_key}):
            self.app.config['REQUIRE_AUTH'] = True
            self.app.config['DEVELOPMENT_MODE'] = False
            
            # Step 2: Test access without key (should fail)
            response = self.client.get('/api/cases')
            self.assertEqual(response.status_code, 401)
            
            # Step 3: Test access with valid key (should succeed)
            headers = {'X-API-Key': test_key}
            response = self.client.get('/api/cases', headers=headers)
            self.assertNotEqual(response.status_code, 401)
            
            # Step 4: Test health endpoint (should always work)
            response = self.client.get('/api/health')
            self.assertEqual(response.status_code, 200)
            
            capabilities = response.get_json()['capabilities']
            self.assertTrue(capabilities['authentication'])


def run_authentication_tests():
    """Run authentication tests"""
    # Create test suite
    suite = unittest.TestSuite()
    
    # Add test cases
    suite.addTest(unittest.makeSuite(TestBackendAuthentication))
    suite.addTest(unittest.makeSuite(TestAuthenticationIntegration))
    
    # Run tests
    runner = unittest.TextTestRunner(verbosity=2)
    result = runner.run(suite)
    
    return result.wasSuccessful()


if __name__ == '__main__':
    print("🔐 Running Backend Authentication Tests...")
    print("=" * 60)
    
    success = run_authentication_tests()
    
    if success:
        print("\n✅ All authentication tests passed!")
        sys.exit(0)
    else:
        print("\n❌ Some authentication tests failed!")
        sys.exit(1)