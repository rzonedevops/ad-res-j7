# AD/JR/DR Database Setup Guide

**Repository:** `cogpy/ad-res-j7`  
**Case:** 2025-137857 (Peter Faucitt v. Jacqueline & Daniel Faucitt)  
**Date:** November 02, 2025

---

## Overview

This directory contains all necessary files to set up a PostgreSQL database for managing the 141 AD (Applicant's Document) paragraphs and their corresponding JR (Jacqueline's Response) and DR (Daniel's Response) affidavits.

---

## Files Included

### 1. Schema & Scripts
- **`database_schema.sql`** - Complete PostgreSQL schema with 8 tables, 2 views, and triggers
- **`import_csv_to_neon.py`** - Python script to import CSV data into the database
- **`setup_supabase_db.py`** - Alternative script for Supabase setup

### 2. Data Files
- **`ad_sorted_correct.txt`** - Canonical list of all 141 AD paragraphs
- **`ad_paragraphs_20251102_185032.csv`** - 74 AD paragraphs with content
- **`jr_responses_20251102_185344.csv`** - 76 JR responses
- **`dr_responses_20251102_185334.csv`** - 76 DR responses
- **`affidavit_sections_20251102_185041.csv`** - 5 affidavit sections

### 3. Analysis & Reports
- **`AD_JR_DR_Database_Reconciliation_Report.md`** - Comprehensive reconciliation analysis
- **`AD_Reference_Mapping_141_Paragraphs.md`** - Complete mapping of all AD paragraphs
- **`reconciliation_report_detailed.txt`** - Detailed gap analysis

---

## Database Schema

### Tables

1.  **`affidavit_sections`** - Organizes AD paragraphs into logical sections
2.  **`ad_paragraphs`** - All 141 AD paragraphs from Peter's Founding Affidavit
3.  **`jr_responses`** - Jacqueline's responses (JR paragraphs)
4.  **`dr_responses`** - Daniel's responses (DR paragraphs)
5.  **`comments`** - Strategic notes and commentary on AD paragraphs
6.  **`annexures`** - Evidence attachments referenced in affidavits
7.  **`timeline_events`** - Key events for temporal analysis
8.  **`legal_principles`** - Legal principles from `lex/*` framework

### Views

1.  **`ad_coverage_summary`** - Quick view of JR/DR response coverage
2.  **`missing_responses`** - Identifies AD paragraphs without responses

---

## Setup Instructions

### Option 1: Neon Database

```bash
# 1. Create a new Neon project
# Visit: https://console.neon.tech/

# 2. Get your connection string
# Format: postgresql://user:password@host/database

# 3. Execute the schema
psql "your_connection_string" < database_schema.sql

# 4. Configure the import script
# Edit import_csv_to_neon.py and set PROJECT_ID

# 5. Run the import
python3 import_csv_to_neon.py
```

### Option 2: Supabase Database

```bash
# 1. Create a new Supabase project
# Visit: https://supabase.com/dashboard

# 2. Get your connection details
# Go to Project Settings > Database

# 3. Execute the schema in SQL Editor
# Copy/paste database_schema.sql into Supabase SQL Editor

# 4. Set environment variables
export SUPABASE_URL="your_project_url"
export SUPABASE_KEY="your_anon_key"

# 5. Run the import
python3 setup_supabase_db.py
```

### Option 3: Local PostgreSQL

```bash
# 1. Install PostgreSQL
sudo apt-get install postgresql postgresql-contrib

# 2. Create database
sudo -u postgres createdb ad_jr_dr_affidavit_db

# 3. Execute schema
sudo -u postgres psql ad_jr_dr_affidavit_db < database_schema.sql

# 4. Import data
# Modify import script with local connection string
python3 import_csv_to_neon.py
```

---

## Data Reconciliation Status

### Current Coverage

| Category | Count | Coverage |
| :--- | :--- | :--- |
| Canonical AD Paragraphs | 141 | 100% |
| AD Paragraphs in CSV | 74 | 52% |
| JR Responses | 76 | 54% |
| DR Responses | 76 | 54% |

### Missing Data

**67 AD paragraphs** need content added:
- Section 1: AD 1.1-1.3
- Section 2: AD 2.1-2.4
- Section 3: AD 3.1-3.13
- Section 6: AD 6.1-6.5
- Section 12: AD 12.1-12.4
- Section 13: AD 13.1-13.7
- Section 14: AD 14.1-14.5
- Section 16: AD 16.1-16.12
- Section 17: AD 17.1-17.4

**77 AD paragraphs** need JR/DR responses created.

---

## Usage Examples

### Query Coverage

```sql
-- Get coverage summary
SELECT * FROM ad_coverage_summary;

-- Find missing responses
SELECT * FROM missing_responses;

-- Count responses by section
SELECT 
    s.title,
    COUNT(DISTINCT ad.paragraph_number) as total_ads,
    COUNT(DISTINCT jr.paragraph_number) as jr_responses,
    COUNT(DISTINCT dr.paragraph_number) as dr_responses
FROM ad_paragraphs ad
LEFT JOIN affidavit_sections s ON ad.section_id = s.id
LEFT JOIN jr_responses jr ON ad.paragraph_number = jr.ad_paragraph_ref
LEFT JOIN dr_responses dr ON ad.paragraph_number = dr.ad_paragraph_ref
GROUP BY s.title;
```

### Add New Response

```sql
-- Add a JR response
INSERT INTO jr_responses (section_id, paragraph_number, ad_paragraph_ref, content, evidence_strength)
VALUES (1, '1.1', '1.1', 'Response content here...', 4);

-- Add a DR response
INSERT INTO dr_responses (section_id, paragraph_number, ad_paragraph_ref, content, evidence_strength)
VALUES (1, '1.1', '1.1', 'Response content here...', 4);
```

### Add Commentary

```sql
-- Add strategic comment
INSERT INTO comments (ad_paragraph_ref, comment_type, content, priority)
VALUES ('7.5', 'strategic', 'This paragraph demonstrates Peter''s consciousness of guilt...', 5);
```

---

## Integration with Repository

### Recommended Directory Structure

```
ad-res-j7/
├── database/
│   ├── schema/
│   │   └── database_schema.sql
│   ├── scripts/
│   │   ├── import_csv_to_neon.py
│   │   └── setup_supabase_db.py
│   ├── data/
│   │   ├── ad_sorted_correct.txt
│   │   ├── ad_paragraphs_20251102_185032.csv
│   │   ├── jr_responses_20251102_185344.csv
│   │   ├── dr_responses_20251102_185334.csv
│   │   └── affidavit_sections_20251102_185041.csv
│   └── docs/
│       ├── DATABASE_SETUP_README.md
│       ├── AD_JR_DR_Database_Reconciliation_Report.md
│       └── AD_Reference_Mapping_141_Paragraphs.md
```

---

## Next Steps

1.  **Set up database** using one of the options above
2.  **Import existing data** using the provided scripts
3.  **Populate missing AD paragraphs** (67 placeholders need content)
4.  **Create missing responses** (77 AD paragraphs need JR/DR responses)
5.  **Add commentary** for strategic analysis
6.  **Link annexures** to relevant paragraphs
7.  **Map timeline events** for temporal analysis
8.  **Integrate lex principles** from the legal framework

---

## Support & Maintenance

### Database Connection Details

**Neon Project:**
- Project ID: `aged-math-34544232`
- Branch: `main` (br-old-grass-a4rrzh52)
- Database: `neondb`
- Connection: See `neon_connection_details.txt`

### Troubleshooting

**Issue:** Tables not created
- **Solution:** Ensure PostgreSQL version is 12+, execute schema manually

**Issue:** Import fails
- **Solution:** Check CSV file paths, verify database connection

**Issue:** Missing data
- **Solution:** Review `reconciliation_report_detailed.txt` for gaps

---

## License & Attribution

This database schema and documentation were created by **Manus AI** on November 02, 2025, for the case **2025-137857** in the repository **`cogpy/ad-res-j7`**.
