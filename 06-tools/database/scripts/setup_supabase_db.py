#!/usr/bin/env python3
"""
Set up AD/JR/DR database in Supabase
"""

import os
import csv
from supabase import create_client, Client

# Initialize Supabase client
url = os.environ.get("SUPABASE_URL")
key = os.environ.get("SUPABASE_KEY")
supabase: Client = create_client(url, key)

print("Connected to Supabase")
print("="*70)

def parse_ad_number(ad_str):
    """Parse AD number into sortable tuple"""
    if not ad_str:
        return ()
    parts = str(ad_str).split('.')
    try:
        return tuple(int(p) for p in parts)
    except:
        return ()

# Load canonical 141 AD paragraphs
with open('/home/ubuntu/ad_sorted_correct.txt', 'r') as f:
    canonical_ads = [line.strip().replace('AD ', '') for line in f if line.strip()]

print(f"Canonical AD paragraphs: {len(canonical_ads)}")

# ============================================================================
# STEP 1: Create tables using SQL
# ============================================================================
print("\nSTEP 1: Creating database schema...")

# Read and execute schema
with open('/home/ubuntu/database_schema.sql', 'r') as f:
    schema_sql = f.read()

try:
    # Execute schema creation via RPC or direct SQL
    # Note: Supabase Python client doesn't have direct SQL execution
    # We'll need to create tables via the API
    print("  Schema will be created via Supabase dashboard or SQL editor")
    print("  Proceeding with data import assuming tables exist...")
except Exception as e:
    print(f"  Note: {e}")

# ============================================================================
# STEP 2: Import affidavit sections
# ============================================================================
print("\nSTEP 2: Importing affidavit sections...")
sections_data = []
with open('/home/ubuntu/upload/affidavit_sections_20251102_185041.csv', 'r') as f:
    reader = csv.DictReader(f)
    for row in reader:
        sections_data.append({
            'id': int(row['id']),
            'section_number': int(row['section_number']),
            'title': row['title'],
            'description': row.get('description', '')
        })

try:
    result = supabase.table('affidavit_sections').upsert(sections_data).execute()
    print(f"  ✓ Imported {len(sections_data)} sections")
except Exception as e:
    print(f"  ✗ Error: {e}")

# ============================================================================
# STEP 3: Import AD paragraphs from CSV
# ============================================================================
print("\nSTEP 3: Importing AD paragraphs from CSV...")
ad_csv_data = []
with open('/home/ubuntu/upload/ad_paragraphs_20251102_185032.csv', 'r') as f:
    reader = csv.DictReader(f)
    for row in reader:
        ad_csv_data.append({
            'section_id': int(row['section_id']),
            'paragraph_number': row['paragraph_number'],
            'content': row['content'],
            'summary': row.get('summary') if row.get('summary') else None,
            'severity': int(row['severity']) if row.get('severity') else None,
            'annexures': row.get('annexures') if row.get('annexures') else None
        })

try:
    # Insert in batches of 50
    batch_size = 50
    for i in range(0, len(ad_csv_data), batch_size):
        batch = ad_csv_data[i:i+batch_size]
        result = supabase.table('ad_paragraphs').upsert(batch).execute()
    print(f"  ✓ Imported {len(ad_csv_data)} AD paragraphs from CSV")
except Exception as e:
    print(f"  ✗ Error: {e}")

# ============================================================================
# STEP 4: Add missing AD paragraphs
# ============================================================================
print("\nSTEP 4: Adding missing AD paragraphs...")
ad_csv_set = set([row['paragraph_number'] for row in ad_csv_data])
missing_ads = set(canonical_ads) - ad_csv_set

def get_section_id(ad_num):
    """Determine section ID from AD number"""
    section_map = {
        '1': 1, '2': 1, '3': 1,
        '6': 1, '7': 1, '8': 2, '9': 3, '10': 4, '11': 5,
        '12': 1, '13': 1, '14': 1, '16': 1, '17': 1
    }
    first_part = ad_num.split('.')[0]
    return section_map.get(first_part, 1)

missing_data = []
for ad_num in sorted(missing_ads, key=parse_ad_number):
    missing_data.append({
        'section_id': get_section_id(ad_num),
        'paragraph_number': ad_num,
        'content': f'[Placeholder for AD {ad_num} - Content to be added]',
        'summary': f'AD {ad_num} - Pending content',
        'severity': 3
    })

try:
    if missing_data:
        batch_size = 50
        for i in range(0, len(missing_data), batch_size):
            batch = missing_data[i:i+batch_size]
            result = supabase.table('ad_paragraphs').upsert(batch).execute()
        print(f"  ✓ Added {len(missing_data)} placeholder AD paragraphs")
except Exception as e:
    print(f"  ✗ Error: {e}")

# ============================================================================
# STEP 5: Import JR responses
# ============================================================================
print("\nSTEP 5: Importing JR responses...")
jr_data = []
with open('/home/ubuntu/upload/jr_responses_20251102_185344.csv', 'r') as f:
    reader = csv.DictReader(f)
    for row in reader:
        para_num = row['paragraph_number']
        ad_ref = '.'.join(para_num.split('.')[:2]) if '.' in para_num else para_num
        
        jr_data.append({
            'section_id': int(row['section_id']),
            'paragraph_number': para_num,
            'ad_paragraph_ref': ad_ref,
            'content': row['content'],
            'evidence_strength': int(row['evidence_strength']) if row.get('evidence_strength') else None,
            'annexures': row.get('annexures') if row.get('annexures') else None
        })

try:
    batch_size = 50
    for i in range(0, len(jr_data), batch_size):
        batch = jr_data[i:i+batch_size]
        result = supabase.table('jr_responses').upsert(batch).execute()
    print(f"  ✓ Imported {len(jr_data)} JR responses")
except Exception as e:
    print(f"  ✗ Error: {e}")

# ============================================================================
# STEP 6: Import DR responses
# ============================================================================
print("\nSTEP 6: Importing DR responses...")
dr_data = []
with open('/home/ubuntu/upload/dr_responses_20251102_185334.csv', 'r') as f:
    reader = csv.DictReader(f)
    for row in reader:
        para_num = row['paragraph_number']
        ad_ref = '.'.join(para_num.split('.')[:2]) if '.' in para_num else para_num
        
        dr_data.append({
            'section_id': int(row['section_id']),
            'paragraph_number': para_num,
            'ad_paragraph_ref': ad_ref,
            'content': row['content'],
            'evidence_strength': int(row['evidence_strength']) if row.get('evidence_strength') else None,
            'annexures': row.get('annexures') if row.get('annexures') else None
        })

try:
    batch_size = 50
    for i in range(0, len(dr_data), batch_size):
        batch = dr_data[i:i+batch_size]
        result = supabase.table('dr_responses').upsert(batch).execute()
    print(f"  ✓ Imported {len(dr_data)} DR responses")
except Exception as e:
    print(f"  ✗ Error: {e}")

# ============================================================================
# SUMMARY
# ============================================================================
print("\n" + "="*70)
print("IMPORT SUMMARY")
print("="*70)
print(f"Affidavit sections: {len(sections_data)}")
print(f"AD paragraphs from CSV: {len(ad_csv_data)}")
print(f"AD paragraphs added (placeholders): {len(missing_data)}")
print(f"Total AD paragraphs: {len(ad_csv_data) + len(missing_data)}")
print(f"JR responses: {len(jr_data)}")
print(f"DR responses: {len(dr_data)}")
print("="*70)

# Verify data
print("\nVerifying data in Supabase...")
try:
    ad_count = supabase.table('ad_paragraphs').select('*', count='exact').execute()
    jr_count = supabase.table('jr_responses').select('*', count='exact').execute()
    dr_count = supabase.table('dr_responses').select('*', count='exact').execute()
    
    print(f"  AD paragraphs in database: {ad_count.count}")
    print(f"  JR responses in database: {jr_count.count}")
    print(f"  DR responses in database: {dr_count.count}")
except Exception as e:
    print(f"  Could not verify: {e}")
