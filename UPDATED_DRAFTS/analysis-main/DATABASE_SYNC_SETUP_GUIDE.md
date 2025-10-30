# Database Synchronization Setup Guide

## Overview

This guide provides step-by-step instructions for setting up and using the database synchronization features in the `rzonedevops/analysis` repository. The system supports synchronization with both **Supabase** and **Neon** databases.

## Table of Contents

1. [Prerequisites](#prerequisites)
2. [Installation](#installation)
3. [Configuration](#configuration)
4. [Health Checks](#health-checks)
5. [Running Synchronization](#running-synchronization)
6. [Troubleshooting](#troubleshooting)
7. [Advanced Usage](#advanced-usage)

## Prerequisites

### Required Software

- **Python 3.8+** (Python 3.11 recommended)
- **Git** for repository management
- **pip** for package installation

### Database Accounts

You need at least one of the following:

- **Supabase Account**: Sign up at [supabase.com](https://supabase.com)
- **Neon Account**: Sign up at [neon.tech](https://neon.tech)

## Installation

### 1. Clone the Repository

```bash
git clone https://github.com/rzonedevops/analysis.git
cd analysis
```

### 2. Install Dependencies

#### Production Dependencies

```bash
pip install -r requirements.txt
```

This includes:
- Core dependencies (torch, transformers, networkx, etc.)
- Database dependencies (supabase, psycopg2-binary, sqlalchemy)
- Fraud analysis dependencies (scikit-learn, xgboost, pandas)

#### Development Dependencies (Optional)

```bash
pip install -r requirements-dev.txt
```

This includes testing, linting, and documentation tools.

### 3. Verify Installation

```bash
python -c "import supabase; import sqlalchemy; print('Dependencies installed successfully')"
```

## Configuration

### Environment Variables

Database synchronization requires specific environment variables to be set. You can set these in your shell, or create a `.env` file.

#### Supabase Configuration

```bash
export SUPABASE_URL="https://your-project.supabase.co"
export SUPABASE_KEY="your-anon-or-service-role-key"
export SUPABASE_SERVICE_ROLE_KEY="your-service-role-key"  # Optional, for admin operations
```

**Finding Your Supabase Credentials:**

1. Go to your Supabase project dashboard
2. Click on **Settings** → **API**
3. Copy the **Project URL** (this is your `SUPABASE_URL`)
4. Copy the **anon public** key or **service_role** key (this is your `SUPABASE_KEY`)

#### Neon Configuration

**Option 1: Connection String (Recommended)**

```bash
export NEON_CONNECTION_STRING="postgresql://user:password@host/database?sslmode=require"
```

**Option 2: Individual Components**

```bash
export NEON_HOST="your-project.neon.tech"
export NEON_DATABASE="your-database-name"
export NEON_USER="your-username"
export NEON_PASSWORD="your-password"
```

**Finding Your Neon Credentials:**

1. Go to your Neon project dashboard
2. Click on **Connection Details**
3. Copy the **Connection String** or individual components

#### Optional Configuration

```bash
# Database connection pooling
export DB_POOL_SIZE=10
export DB_MAX_OVERFLOW=20
export DB_POOL_TIMEOUT=30
export DB_POOL_RECYCLE=3600

# Retry configuration
export DB_MAX_RETRIES=3
export DB_RETRY_DELAY=1.0
export DB_RETRY_BACKOFF=2.0

# Logging
export LOG_LEVEL=INFO
export LOG_FILE=/path/to/logfile.log
```

### Using a .env File

Create a `.env` file in the repository root:

```bash
# .env file
SUPABASE_URL=https://your-project.supabase.co
SUPABASE_KEY=your-key-here
NEON_CONNECTION_STRING=postgresql://user:password@host/database?sslmode=require
```

Then load it in your shell:

```bash
# Using bash
export $(cat .env | xargs)

# Or use python-dotenv
pip install python-dotenv
```

### Validate Configuration

```bash
python -c "from src.config import get_config; config = get_config(); print('Valid!' if config.validate() else 'Invalid configuration')"
```

For strict validation (requires both Supabase and Neon):

```bash
python -c "from src.config import get_config; config = get_config(); print('Valid!' if config.validate(strict=True) else 'Invalid configuration')"
```

## Health Checks

Before running synchronization, verify that your database connections are working.

### Run Health Check

```bash
python -m src.utils.health_check
```

**Expected Output:**

```
================================================================================
DATABASE HEALTH CHECK REPORT
Timestamp: 2025-10-13T12:00:00.000000
================================================================================

Database: Supabase
  Status: HEALTHY
  Response Time: 125.45ms
  Details:
    - url: https://your-project.supabase.co
    - has_service_role_key: True

Database: Neon
  Status: HEALTHY
  Response Time: 89.32ms
  Details:
    - connection_string_configured: True

================================================================================
✅ All database connections are healthy
================================================================================
```

### Interpreting Health Check Results

- **HEALTHY**: Connection is working properly
- **DEGRADED**: Connection is slow or experiencing issues
- **UNHEALTHY**: Connection failed but credentials are configured
- **UNAVAILABLE**: Credentials not configured

## Running Synchronization

### Basic Synchronization

Run the main synchronization script:

```bash
python sync_databases.py
```

This will:
1. Generate migration SQL for all tables
2. Apply migrations to Neon (if configured)
3. Display migration SQL for Supabase (manual execution required)
4. Create sync log entries

### Expected Output

```
================================================================================
DATABASE SYNCHRONIZATION SCRIPT
Repository: rzonedevops/analysis
Timestamp: 2025-10-13T12:00:00.000000
================================================================================

================================================================================
Starting Supabase schema synchronization...
================================================================================
Generating migration SQL for all tables...
Generated migrations for 6 tables:
  - evidence
  - timeline_events
  - entities
  - hypergraph_nodes
  - hypergraph_edges
  - sync_log

================================================================================
SUPABASE MIGRATION SQL
================================================================================
Execute the following SQL in your Supabase SQL Editor:
================================================================================

-- Table: evidence
CREATE TABLE IF NOT EXISTS evidence (...);
...

================================================================================
Starting Neon schema synchronization...
================================================================================
Generating migration SQL for all tables...
Generated migrations for 6 tables:
  - evidence
  - timeline_events
  - entities
  - hypergraph_nodes
  - hypergraph_edges
  - sync_log

Executing migrations on Neon database...
Migrating table: evidence
  ✓ Executed: CREATE TABLE IF NOT EXISTS evidence (...)...
...

================================================================================
SYNCHRONIZATION SUMMARY
================================================================================
Supabase: ✓ SUCCESS
Neon:     ✓ SUCCESS
Overall:  SUCCESS
================================================================================

✅ All database synchronizations completed successfully!
```

### Supabase Manual Migration

For Supabase, you need to manually execute the generated SQL:

1. Copy the SQL output from the synchronization script
2. Go to your Supabase project dashboard
3. Click on **SQL Editor**
4. Paste the SQL and click **Run**

## Troubleshooting

### Common Issues

#### 1. Missing Dependencies

**Error:**
```
ModuleNotFoundError: No module named 'supabase'
```

**Solution:**
```bash
pip install -r requirements.txt
```

#### 2. Invalid Credentials

**Error:**
```
authentication failed
```

**Solution:**
- Verify your environment variables are set correctly
- Check that your API keys haven't expired
- Ensure you're using the correct key type (anon vs service_role)

#### 3. Connection Timeout

**Error:**
```
connection timeout
```

**Solution:**
- Check your internet connection
- Verify firewall settings
- Ensure the database server is accessible from your IP
- Try increasing the connection timeout

#### 4. Schema Errors

**Error:**
```
relation does not exist
```

**Solution:**
- Run the synchronization script to create missing tables
- Verify you're connected to the correct database
- Check the schema migration status

### Error Recovery

The system includes comprehensive error handling with recovery instructions. When an error occurs, you'll see:

```
================================================================================
RECOVERY INSTRUCTIONS
================================================================================
1. Verify the database server is running and accessible
2. Check firewall settings and network connectivity
3. Confirm the database host and port are correct
4. Try connecting using a database client (e.g., psql, pgAdmin)
5. Check if the database is accepting connections from your IP
================================================================================
```

Follow these instructions to resolve the issue.

### Debug Mode

Enable debug logging for more detailed output:

```bash
export LOG_LEVEL=DEBUG
python sync_databases.py
```

## Advanced Usage

### Using MCP (Model Context Protocol) for Neon

The repository supports MCP integration for advanced Neon operations:

```bash
# List available Neon projects
manus-mcp-cli tool call list_projects --server neon --input '{}'

# Run SQL query
manus-mcp-cli tool call run_sql --server neon --input '{
  "sql": "SELECT * FROM evidence LIMIT 10",
  "projectId": "your-project-id"
}'

# Get database tables
manus-mcp-cli tool call get_database_tables --server neon --input '{
  "projectId": "your-project-id"
}'
```

### Custom Synchronization Scripts

You can create custom synchronization scripts using the provided utilities:

```python
from src.config import get_config
from src.database_sync.enhanced_client import EnhancedSupabaseClient, EnhancedNeonClient
from src.utils.error_handler import ErrorHandler, retry_with_backoff

@retry_with_backoff(max_retries=3)
@ErrorHandler.with_error_handling("custom_sync")
def custom_sync():
    config = get_config()
    
    # Your custom sync logic here
    supabase_client = EnhancedSupabaseClient()
    neon_client = EnhancedNeonClient()
    
    # Perform operations...
    
if __name__ == "__main__":
    custom_sync()
```

### Automated Synchronization

Set up automated synchronization using cron or GitHub Actions:

**Cron Example:**

```bash
# Run sync every day at 2 AM
0 2 * * * cd /path/to/analysis && /usr/bin/python sync_databases.py >> /var/log/db_sync.log 2>&1
```

**GitHub Actions Example:**

```yaml
name: Database Sync

on:
  schedule:
    - cron: '0 2 * * *'  # Daily at 2 AM UTC
  workflow_dispatch:  # Manual trigger

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
        run: pip install -r requirements.txt
      - name: Run synchronization
        env:
          SUPABASE_URL: ${{ secrets.SUPABASE_URL }}
          SUPABASE_KEY: ${{ secrets.SUPABASE_KEY }}
          NEON_CONNECTION_STRING: ${{ secrets.NEON_CONNECTION_STRING }}
        run: python sync_databases.py
```

## Support

If you encounter issues not covered in this guide:

1. Check the [GitHub Issues](https://github.com/rzonedevops/analysis/issues)
2. Review the error logs with debug mode enabled
3. Run health checks to identify connection issues
4. Consult the [API Documentation](API_DOCUMENTATION.md)

## Next Steps

- Review [TECHNICAL_ARCHITECTURE.md](TECHNICAL_ARCHITECTURE.md) for system design details
- Explore [DATABASE_SYNC_INSTRUCTIONS.md](DATABASE_SYNC_INSTRUCTIONS.md) for additional sync options
- Check [DEPLOYMENT.md](DEPLOYMENT.md) for production deployment guidance

