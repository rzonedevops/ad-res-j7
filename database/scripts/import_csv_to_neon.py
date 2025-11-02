#!/usr/bin/env python3
"""
Import CSV data into Neon database and reconcile with canonical 141 AD paragraphs
"""

import csv
import subprocess
import json
import re

PROJECT_ID = "aged-math-34544232"

def parse_ad_number(ad_str):
    """Parse AD number into sortable tuple"""
    if not ad_str:
        return ()
    parts = str(ad_str).split('.')
    try:
        return tuple(int(p) for p in parts)
    except:
        return ()

def execute_sql(sql):
    """Execute SQL via MCP CLI"""
    mcp_input = {
        "params": {
            "sql": sql,
            "projectId": PROJECT_ID
        }
    }
    
    try:
        result = subprocess.run(
            ['manus-mcp-cli', 'tool', 'call', 'run_sql', '--server', 'neon', '--input', json.dumps(mcp_input)],
            capture_output=True,
            text=True,
            timeout=30
        )
        return result.returncode == 0, result.stdout, result.stderr
    except Exception as e:
        return False, "", str(e)

def escape_sql_string(s):
    """Escape string for SQL"""
    if s is None:
        return 'NULL'
    return "'" + str(s).replace("'", "''").replace('\n', ' ').replace('\r', '') + "'"

# Load canonical 141 AD paragraphs
with open('/home/ubuntu/ad_sorted_correct.txt', 'r') as f:
    canonical_ads = [line.strip().replace('AD ', '') for line in f if line.strip()]

print(f"Canonical AD paragraphs: {len(canonical_ads)}")
print("="*70)

# ============================================================================
# STEP 1: Import affidavit sections
# ============================================================================
print("\nSTEP 1: Importing affidavit sections...")
sections_data = []
with open('/home/ubuntu/upload/affidavit_sections_20251102_185041.csv', 'r') as f:
    reader = csv.DictReader(f)
    for row in reader:
        sections_data.append(row)

for section in sections_data:
    sql = f"""
    INSERT INTO affidavit_sections (id, section_number, title, description)
    VALUES ({section['id']}, {section['section_number']}, {escape_sql_string(section['title'])}, {escape_sql_string(section.get('description', ''))})
    ON CONFLICT (section_number) DO NOTHING;
    """
    success, stdout, stderr = execute_sql(sql)
    if success:
        print(f"  ✓ Section {section['section_number']}: {section['title']}")
    else:
        print(f"  ✗ Error importing section {section['section_number']}: {stderr}")

# ============================================================================
# STEP 2: Import AD paragraphs from CSV
# ============================================================================
print("\nSTEP 2: Importing AD paragraphs from CSV...")
ad_csv_data = {}
with open('/home/ubuntu/upload/ad_paragraphs_20251102_185032.csv', 'r') as f:
    reader = csv.DictReader(f)
    for row in reader:
        para_num = row['paragraph_number']
        ad_csv_data[para_num] = row

imported_count = 0
for para_num, row in ad_csv_data.items():
    # Clean content
    content = row['content'].replace("'", "''").replace('\n', ' ').replace('\r', '')
    summary = row.get('summary', '').replace("'", "''") if row.get('summary') else ''
    
    sql = f"""
    INSERT INTO ad_paragraphs (section_id, paragraph_number, content, summary, severity, annexures)
    VALUES ({row['section_id']}, {escape_sql_string(para_num)}, {escape_sql_string(content)}, 
            {escape_sql_string(summary) if summary else 'NULL'}, 
            {row.get('severity', 'NULL')}, 
            {escape_sql_string(row.get('annexures', '')) if row.get('annexures') else 'NULL'})
    ON CONFLICT (paragraph_number) DO NOTHING;
    """
    success, stdout, stderr = execute_sql(sql)
    if success:
        imported_count += 1
        if imported_count <= 5:
            print(f"  ✓ AD {para_num}")
    else:
        print(f"  ✗ Error importing AD {para_num}: {stderr}")

print(f"  Total imported: {imported_count}/{len(ad_csv_data)}")

# ============================================================================
# STEP 3: Add missing AD paragraphs from canonical list
# ============================================================================
print("\nSTEP 3: Adding missing AD paragraphs from canonical list...")
ad_csv_set = set(ad_csv_data.keys())
missing_ads = set(canonical_ads) - ad_csv_set

# Map AD paragraphs to sections
def get_section_id(ad_num):
    """Determine section ID from AD number"""
    section_map = {
        '1': 1, '2': 1, '3': 1,  # Sections 1-3 map to section_id 1
        '6': 1, '7': 1, '8': 2, '9': 3, '10': 4, '11': 5,
        '12': 1, '13': 1, '14': 1, '16': 1, '17': 1
    }
    first_part = ad_num.split('.')[0]
    return section_map.get(first_part, 1)

added_count = 0
for ad_num in sorted(missing_ads, key=parse_ad_number):
    section_id = get_section_id(ad_num)
    sql = f"""
    INSERT INTO ad_paragraphs (section_id, paragraph_number, content, summary, severity)
    VALUES ({section_id}, {escape_sql_string(ad_num)}, 
            {escape_sql_string(f'[Placeholder for AD {ad_num} - Content to be added]')}, 
            {escape_sql_string(f'AD {ad_num} - Pending content')}, 3)
    ON CONFLICT (paragraph_number) DO NOTHING;
    """
    success, stdout, stderr = execute_sql(sql)
    if success:
        added_count += 1
        if added_count <= 10:
            print(f"  ✓ Added placeholder for AD {ad_num}")
    else:
        print(f"  ✗ Error adding AD {ad_num}: {stderr}")

if added_count > 10:
    print(f"  ... and {added_count - 10} more")
print(f"  Total added: {added_count}/{len(missing_ads)}")

# ============================================================================
# STEP 4: Import JR responses
# ============================================================================
print("\nSTEP 4: Importing JR responses...")
jr_data = {}
with open('/home/ubuntu/upload/jr_responses_20251102_185344.csv', 'r') as f:
    reader = csv.DictReader(f)
    for row in reader:
        para_num = row['paragraph_number']
        jr_data[para_num] = row

jr_imported = 0
for para_num, row in jr_data.items():
    # Extract AD reference (base paragraph without sub-numbering)
    ad_ref = '.'.join(para_num.split('.')[:2]) if '.' in para_num else para_num
    
    content = row['content'].replace("'", "''").replace('\n', ' ').replace('\r', '')
    
    sql = f"""
    INSERT INTO jr_responses (section_id, paragraph_number, ad_paragraph_ref, content, evidence_strength, annexures)
    VALUES ({row['section_id']}, {escape_sql_string(para_num)}, {escape_sql_string(ad_ref)}, 
            {escape_sql_string(content)}, 
            {row.get('evidence_strength', 'NULL')}, 
            {escape_sql_string(row.get('annexures', '')) if row.get('annexures') else 'NULL'})
    ON CONFLICT (paragraph_number) DO NOTHING;
    """
    success, stdout, stderr = execute_sql(sql)
    if success:
        jr_imported += 1
        if jr_imported <= 5:
            print(f"  ✓ JR {para_num} → AD {ad_ref}")
    else:
        print(f"  ✗ Error importing JR {para_num}: {stderr}")

print(f"  Total imported: {jr_imported}/{len(jr_data)}")

# ============================================================================
# STEP 5: Import DR responses
# ============================================================================
print("\nSTEP 5: Importing DR responses...")
dr_data = {}
with open('/home/ubuntu/upload/dr_responses_20251102_185334.csv', 'r') as f:
    reader = csv.DictReader(f)
    for row in reader:
        para_num = row['paragraph_number']
        dr_data[para_num] = row

dr_imported = 0
for para_num, row in dr_data.items():
    # Extract AD reference (base paragraph without sub-numbering)
    ad_ref = '.'.join(para_num.split('.')[:2]) if '.' in para_num else para_num
    
    content = row['content'].replace("'", "''").replace('\n', ' ').replace('\r', '')
    
    sql = f"""
    INSERT INTO dr_responses (section_id, paragraph_number, ad_paragraph_ref, content, evidence_strength, annexures)
    VALUES ({row['section_id']}, {escape_sql_string(para_num)}, {escape_sql_string(ad_ref)}, 
            {escape_sql_string(content)}, 
            {row.get('evidence_strength', 'NULL')}, 
            {escape_sql_string(row.get('annexures', '')) if row.get('annexures') else 'NULL'})
    ON CONFLICT (paragraph_number) DO NOTHING;
    """
    success, stdout, stderr = execute_sql(sql)
    if success:
        dr_imported += 1
        if dr_imported <= 5:
            print(f"  ✓ DR {para_num} → AD {ad_ref}")
    else:
        print(f"  ✗ Error importing DR {para_num}: {stderr}")

print(f"  Total imported: {dr_imported}/{len(dr_data)}")

# ============================================================================
# SUMMARY
# ============================================================================
print("\n" + "="*70)
print("IMPORT SUMMARY")
print("="*70)
print(f"Affidavit sections: {len(sections_data)}")
print(f"AD paragraphs from CSV: {imported_count}")
print(f"AD paragraphs added (placeholders): {added_count}")
print(f"Total AD paragraphs in DB: {imported_count + added_count}")
print(f"JR responses imported: {jr_imported}")
print(f"DR responses imported: {dr_imported}")
print("="*70)
