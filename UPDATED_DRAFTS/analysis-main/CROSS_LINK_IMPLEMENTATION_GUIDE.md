# Cross-Repository Implementation Guide

**Step-by-Step Instructions for Adopting Features**

## Overview

This guide provides detailed, actionable instructions for implementing features from other repositories. Each section includes:
- Prerequisites and dependencies
- Step-by-step installation
- Configuration instructions
- Testing procedures
- Troubleshooting tips

## Quick Start Matrix

| Feature | Source Repo | Effort | Prerequisites | Priority |
|---------|-------------|--------|---------------|----------|
| Evidence Automation | analysis | 1 week | Python 3.8+, Database | 🔴 HIGH |
| Database Sync | analysis | 2 weeks | PostgreSQL/Supabase/Neon | 🔴 HIGH |
| Automated Testing | ad-res-j7 | 2-3 weeks | pytest, GitHub Actions | 🔴 HIGH |
| Docker Deployment | analyticase | 1-2 weeks | Docker, docker-compose | 🔴 HIGH |
| Simulation Models | analyticase | 4-6 weeks | NumPy, Database | 🟡 MEDIUM |
| ZA Judiciary API | analyticase | 2-3 weeks | API credentials, Database | 🟡 MEDIUM |
| Timeline Viz | ad-res-j7 | 1 week | Mermaid support | 🟡 MEDIUM |
| HyperGNN Framework | analysss | 3-4 weeks | PyTorch/TensorFlow | 🟡 MEDIUM |
| Citizenship Analysis | analysss | 1 week | None | 🟢 LOW |

## 1. Evidence Automation (from analysis)

**Source:** rzonedevops/analysis  
**Target:** analysss, avtomaatoctory, analyticase  
**Effort:** 1 week  
**Priority:** 🔴 HIGH

### Prerequisites
```bash
# Python packages
pip install python-docx beautifulsoup4 pypdf2 email-parser

# Database (PostgreSQL/Supabase/Neon)
# Ensure database connection is configured
```

### Step 1: Copy Evidence Automation Module
```bash
# From source repository (analysis)
cd /path/to/analysis
tar -czf evidence_automation.tar.gz src/evidence_automation/

# To target repository
cd /path/to/target-repo
tar -xzf /path/to/evidence_automation.tar.gz
mv src/evidence_automation/ ./src/
```

### Step 2: Update Dependencies
Add to `requirements.txt` or `pyproject.toml`:
```txt
# Evidence processing
python-docx>=0.8.11
beautifulsoup4>=4.10.0
PyPDF2>=2.0.0
email-parser>=0.1.0
```

Install:
```bash
pip install -r requirements.txt
```

### Step 3: Configure Evidence Automation
Create `config/evidence_automation.json`:
```json
{
  "repository_root": ".",
  "evidence_base_dir": "evidence",
  "output_base_dir": "analysis_outputs",
  "supported_formats": [".docx", ".html", ".pdf", ".eml"],
  "entity_extraction": {
    "enabled": true,
    "confidence_threshold": 0.7
  },
  "timeline_integration": {
    "enabled": true,
    "auto_update": true
  }
}
```

### Step 4: Test Evidence Processing
```python
# test_evidence_automation.py
from src.evidence_automation import EvidenceProcessor

def test_basic_processing():
    processor = EvidenceProcessor()
    package = processor.process_evidence_package(
        files=["test_evidence/sample.docx"],
        package_name="test_package"
    )
    
    assert package.name == "test_package"
    assert len(package.files) > 0
    print(f"✅ Processed {len(package.files)} files")
    print(f"✅ Extracted {len(package.entities)} entities")

if __name__ == "__main__":
    test_basic_processing()
```

Run test:
```bash
python test_evidence_automation.py
```

### Step 5: Integrate with Existing Code
```python
# In your main analysis file
from src.evidence_automation import process_evidence_files

# Process evidence
package = process_evidence_files(
    file_paths=["evidence/doc1.docx", "evidence/email1.eml"],
    package_name="case_2025_001"
)

# Use extracted data
for entity in package.entities:
    print(f"Entity: {entity['text']} ({entity['type']})")

for event in package.timeline_events:
    print(f"Event: {event['date']} - {event['description']}")
```

### Troubleshooting
- **Import Error**: Ensure `src/` is in Python path: `export PYTHONPATH="${PYTHONPATH}:${PWD}"`
- **File Not Found**: Check `evidence_base_dir` in config
- **Extraction Fails**: Verify file format is supported

## 2. Database Synchronization (from analysis)

**Source:** rzonedevops/analysis  
**Target:** analysss, avtomaatoctory, analyticase  
**Effort:** 2 weeks  
**Priority:** 🔴 HIGH

### Prerequisites
```bash
# Python packages
pip install psycopg2-binary supabase neon-api

# Database credentials
export SUPABASE_URL="https://your-project.supabase.co"
export SUPABASE_KEY="your-anon-key"
export NEON_CONNECTION_STRING="postgresql://user:pass@host:5432/db"
```

### Step 1: Copy Database Sync Module
```bash
# From source repository
cd /path/to/analysis
tar -czf database_sync.tar.gz src/database_sync/

# To target repository
cd /path/to/target-repo
tar -xzf /path/to/database_sync.tar.gz
mv src/database_sync/ ./src/
```

### Step 2: Create Database Schema Extensions
Add to your database schema:
```sql
-- Synchronization tracking
CREATE TABLE IF NOT EXISTS sync_log (
    id SERIAL PRIMARY KEY,
    sync_type VARCHAR(50) NOT NULL,
    source_db VARCHAR(50) NOT NULL,
    target_db VARCHAR(50) NOT NULL,
    status VARCHAR(20) NOT NULL,
    started_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    completed_at TIMESTAMP,
    error_message TEXT,
    changes_applied JSONB
);

-- Migration versioning
CREATE TABLE IF NOT EXISTS migration_versions (
    version VARCHAR(50) PRIMARY KEY,
    applied_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    description TEXT
);
```

### Step 3: Configure Synchronization
Create `config/database_sync.json`:
```json
{
  "supabase": {
    "url": "${SUPABASE_URL}",
    "key": "${SUPABASE_KEY}",
    "schema": "public"
  },
  "neon": {
    "connection_string": "${NEON_CONNECTION_STRING}",
    "schema": "public"
  },
  "sync_options": {
    "auto_backup": true,
    "rollback_on_error": true,
    "log_level": "INFO"
  }
}
```

### Step 4: Test Synchronization
```python
# test_database_sync.py
from src.database_sync import DatabaseSynchronizer, Change

def test_sync():
    synchronizer = DatabaseSynchronizer()
    
    # Create test change
    changes = [
        Change(
            change_type="schema_update",
            description="Add test column",
            sql="ALTER TABLE test ADD COLUMN test_col VARCHAR(100)"
        )
    ]
    
    # Sync changes
    result = synchronizer.sync_schema_changes(changes)
    
    assert len(result.errors) == 0
    print(f"✅ Supabase changes: {len(result.supabase_changes)}")
    print(f"✅ Neon changes: {len(result.neon_changes)}")

if __name__ == "__main__":
    test_sync()
```

### Step 5: Automate Synchronization
Create GitHub Action `.github/workflows/database-sync.yml`:
```yaml
name: Database Synchronization

on:
  push:
    paths:
      - 'database_schema/**'
      - 'src/models/**'
  workflow_dispatch:

jobs:
  sync:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      
      - name: Set up Python
        uses: actions/setup-python@v4
        with:
          python-version: '3.11'
      
      - name: Install dependencies
        run: |
          pip install -r requirements.txt
      
      - name: Run database sync
        env:
          SUPABASE_URL: ${{ secrets.SUPABASE_URL }}
          SUPABASE_KEY: ${{ secrets.SUPABASE_KEY }}
          NEON_CONNECTION_STRING: ${{ secrets.NEON_CONNECTION_STRING }}
        run: |
          python scripts/sync_databases.py
```

### Troubleshooting
- **Connection Error**: Check database credentials and network access
- **Permission Error**: Verify database user has schema modification permissions
- **Sync Conflicts**: Check `sync_log` table for details

## 3. Automated Testing Pipeline (from ad-res-j7)

**Source:** cogpy/ad-res-j7  
**Target:** All Python repositories  
**Effort:** 2-3 weeks  
**Priority:** 🔴 HIGH

### Prerequisites
```bash
# Python testing tools
pip install pytest pytest-cov pytest-asyncio pytest-mock

# GitHub Actions (built-in)
```

### Step 1: Adapt JavaScript Tests to Python
The ad-res-j7 repo uses Jest (JavaScript). We'll adapt to pytest (Python).

Create `tests/test_workflows.py`:
```python
"""
Workflow validation tests adapted from ad-res-j7.
"""
import pytest
import yaml
from pathlib import Path

class TestWorkflowValidation:
    """Test workflow structure and configuration."""
    
    @pytest.fixture
    def workflow_files(self):
        """Get all workflow YAML files."""
        workflow_dir = Path(".github/workflows")
        return list(workflow_dir.glob("*.yml"))
    
    def test_workflows_exist(self, workflow_files):
        """Test that workflow files exist."""
        assert len(workflow_files) > 0, "No workflow files found"
    
    def test_workflow_syntax(self, workflow_files):
        """Test that all workflows have valid YAML syntax."""
        for workflow_file in workflow_files:
            with open(workflow_file) as f:
                data = yaml.safe_load(f)
                assert data is not None
                assert 'name' in data
                assert 'on' in data
    
    def test_workflow_permissions(self, workflow_files):
        """Test that workflows have proper permissions."""
        for workflow_file in workflow_files:
            with open(workflow_file) as f:
                data = yaml.safe_load(f)
                if 'permissions' in data:
                    perms = data['permissions']
                    # Verify no overly broad permissions
                    assert perms != 'write-all'
    
    def test_required_workflows_present(self, workflow_files):
        """Test that required workflows are present."""
        workflow_names = [f.stem for f in workflow_files]
        required = ['test', 'lint']
        
        for req in required:
            assert any(req in name for name in workflow_names), \
                f"Required workflow '{req}' not found"
```

Create `tests/test_integration.py`:
```python
"""
Integration tests for core functionality.
"""
import pytest
from src.evidence_automation import EvidenceProcessor
from src.database_sync import DatabaseSynchronizer

class TestIntegration:
    """Integration tests for main components."""
    
    def test_evidence_to_database_flow(self, tmp_path):
        """Test complete evidence to database flow."""
        # Create test evidence
        test_file = tmp_path / "test.txt"
        test_file.write_text("Test evidence content")
        
        # Process evidence
        processor = EvidenceProcessor()
        package = processor.process_evidence_package(
            files=[str(test_file)],
            package_name="test_package"
        )
        
        # Verify package created
        assert package.name == "test_package"
        assert len(package.files) > 0
        
        # Note: Database sync would be tested with mock database
        # to avoid hitting real database in tests
```

### Step 2: Create pytest Configuration
Create `pytest.ini`:
```ini
[pytest]
testpaths = tests
python_files = test_*.py
python_classes = Test*
python_functions = test_*
addopts = 
    --verbose
    --strict-markers
    --cov=src
    --cov-report=html
    --cov-report=term-missing
markers =
    slow: marks tests as slow (deselect with '-m "not slow"')
    integration: marks tests as integration tests
    unit: marks tests as unit tests
```

### Step 3: Create GitHub Actions Workflow
Create `.github/workflows/automated-tests.yml`:
```yaml
name: Automated Testing Pipeline

on:
  push:
    branches: [ "main", "develop" ]
  pull_request:
    branches: [ "main", "develop" ]
  schedule:
    - cron: '0 2 * * *'  # Daily at 2 AM UTC
  workflow_dispatch:
    inputs:
      verbose:
        description: 'Enable verbose test output'
        type: boolean
        default: false

jobs:
  test:
    runs-on: ubuntu-latest
    
    steps:
      - uses: actions/checkout@v3
      
      - name: Set up Python
        uses: actions/setup-python@v4
        with:
          python-version: '3.11'
          cache: 'pip'
      
      - name: Install dependencies
        run: |
          python -m pip install --upgrade pip
          pip install -r requirements.txt
          pip install pytest pytest-cov pytest-asyncio
      
      - name: Run tests
        run: |
          pytest tests/ \
            --cov=src \
            --cov-report=json \
            --cov-report=term-missing \
            -v ${{ github.event.inputs.verbose && '--verbose' || '' }}
      
      - name: Check test coverage
        run: |
          coverage report --fail-under=80
      
      - name: Upload test results
        if: always()
        uses: actions/upload-artifact@v3
        with:
          name: test-results
          path: |
            htmlcov/
            .coverage
            coverage.json
          retention-days: 30
      
      - name: Create issue on scheduled failure
        if: failure() && github.event_name == 'schedule'
        uses: actions/github-script@v6
        with:
          script: |
            const issue = {
              owner: context.repo.owner,
              repo: context.repo.repo,
              title: 'Automated Test Failure - ' + new Date().toISOString().split('T')[0],
              body: 'Scheduled automated tests failed. Please investigate.\n\nRun: ${{ github.server_url }}/${{ github.repository }}/actions/runs/${{ github.run_id }}',
              labels: ['automated-test-failure', 'bug', 'priority: high']
            };
            github.rest.issues.create(issue);
```

### Step 4: Add Quality Checks
Create `.github/workflows/quality-checks.yml`:
```yaml
name: Code Quality Checks

on: [push, pull_request]

jobs:
  lint:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - uses: actions/setup-python@v4
        with:
          python-version: '3.11'
      
      - name: Install linting tools
        run: |
          pip install black flake8 isort mypy
      
      - name: Run black
        run: black --check src/ tests/
      
      - name: Run flake8
        run: flake8 src/ tests/ --max-line-length=100
      
      - name: Run isort
        run: isort --check-only src/ tests/
      
      - name: Run mypy
        run: mypy src/ --ignore-missing-imports
```

### Step 5: Monitor and Maintain
Set up monitoring:
```bash
# View test results
pytest tests/ -v

# Generate coverage report
pytest tests/ --cov=src --cov-report=html
open htmlcov/index.html

# Run specific test suites
pytest tests/ -m unit         # Only unit tests
pytest tests/ -m integration  # Only integration tests
pytest tests/ -m "not slow"   # Skip slow tests
```

### Success Metrics
- ✅ Test success rate ≥ 90%
- ✅ Code coverage ≥ 80%
- ✅ No critical issues in scheduled runs
- ✅ Automated issue creation working
- ✅ All required workflows passing

### Troubleshooting
- **Tests Failing**: Check individual test output, fix issues incrementally
- **Coverage Low**: Add tests for uncovered code paths
- **Workflow Not Triggering**: Check trigger configuration in YAML
- **Issues Not Created**: Verify GitHub Actions permissions

## 4. Docker Deployment (from analyticase)

**Source:** rzonedevops/analyticase  
**Target:** All repositories  
**Effort:** 1-2 weeks  
**Priority:** 🔴 HIGH

### Prerequisites
```bash
# Install Docker and Docker Compose
# Ubuntu/Debian
sudo apt-get update
sudo apt-get install docker.io docker-compose

# Verify installation
docker --version
docker-compose --version
```

### Step 1: Copy Docker Configuration Files
From analyticase repository, copy:
- `Dockerfile`
- `docker-compose.yml`
- `nginx.conf`
- `.dockerignore`

### Step 2: Create Dockerfile
Customize for your repository:
```dockerfile
# Dockerfile
FROM python:3.11-slim

WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y \
    gcc \
    postgresql-client \
    && rm -rf /var/lib/apt/lists/*

# Copy requirements first for better caching
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy application code
COPY . .

# Create necessary directories
RUN mkdir -p /app/evidence /app/analysis_outputs /app/logs

# Set environment variables
ENV PYTHONUNBUFFERED=1
ENV FLASK_APP=main.py

# Expose port
EXPOSE 5000

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
  CMD python -c "import requests; requests.get('http://localhost:5000/api/health')"

# Run application
CMD ["python", "main.py"]
```

### Step 3: Create docker-compose.yml
```yaml
version: '3.8'

services:
  app:
    build: .
    container_name: analysis-app
    ports:
      - "5000:5000"
    environment:
      - SUPABASE_URL=${SUPABASE_URL}
      - SUPABASE_KEY=${SUPABASE_KEY}
      - NEON_CONNECTION_STRING=${NEON_CONNECTION_STRING}
      - FLASK_ENV=production
    volumes:
      - ./evidence:/app/evidence
      - ./analysis_outputs:/app/analysis_outputs
      - ./logs:/app/logs
    restart: unless-stopped
    networks:
      - analysis-network
  
  nginx:
    image: nginx:alpine
    container_name: analysis-nginx
    ports:
      - "80:80"
      - "443:443"
    volumes:
      - ./nginx.conf:/etc/nginx/nginx.conf:ro
      - ./ssl:/etc/nginx/ssl:ro
    depends_on:
      - app
    restart: unless-stopped
    networks:
      - analysis-network

networks:
  analysis-network:
    driver: bridge
```

### Step 4: Create nginx.conf
```nginx
events {
    worker_connections 1024;
}

http {
    upstream app {
        server app:5000;
    }

    server {
        listen 80;
        server_name _;

        # Security headers
        add_header X-Frame-Options DENY;
        add_header X-Content-Type-Options nosniff;
        add_header X-XSS-Protection "1; mode=block";

        # Rate limiting
        limit_req_zone $binary_remote_addr zone=api:10m rate=10r/s;

        location /api/ {
            limit_req zone=api burst=20 nodelay;
            
            proxy_pass http://app;
            proxy_set_header Host $host;
            proxy_set_header X-Real-IP $remote_addr;
            proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
            proxy_set_header X-Forwarded-Proto $scheme;
        }

        location /health {
            proxy_pass http://app/api/health;
            access_log off;
        }
    }
}
```

### Step 5: Deploy
```bash
# Create .env file
cat > .env << EOF
SUPABASE_URL=https://your-project.supabase.co
SUPABASE_KEY=your-key
NEON_CONNECTION_STRING=postgresql://user:pass@host:5432/db
EOF

# Build and start
docker-compose up -d

# Check status
docker-compose ps

# View logs
docker-compose logs -f app

# Test health endpoint
curl http://localhost/health
```

### Success Criteria
- ✅ Docker build successful
- ✅ Containers running
- ✅ Health check passing
- ✅ API endpoints accessible
- ✅ Persistent data in volumes

### Troubleshooting
- **Build Fails**: Check Dockerfile syntax and dependencies
- **Container Exits**: Check logs with `docker-compose logs app`
- **Cannot Connect**: Verify ports not in use, check firewall
- **Health Check Fails**: Verify health endpoint in application

## Summary

This implementation guide provides step-by-step instructions for adopting the four highest-priority features:

1. ✅ **Evidence Automation** - Automated document processing and entity extraction
2. ✅ **Database Synchronization** - Multi-database sync with versioning
3. ✅ **Automated Testing** - Comprehensive test pipeline with CI/CD
4. ✅ **Docker Deployment** - Production-ready containerization

For additional features, see:
- [REPOSITORY_CROSS_LINK_ANALYSIS.md](./REPOSITORY_CROSS_LINK_ANALYSIS.md) - Complete analysis
- [CROSS_LINK_SUMMARY.md](./CROSS_LINK_SUMMARY.md) - Quick reference
- [CROSS_LINK_VISUALIZATION.md](./CROSS_LINK_VISUALIZATION.md) - Visual guide

---

**Document Version:** 1.0  
**Last Updated:** October 15, 2025  
**Next Review:** November 15, 2025
