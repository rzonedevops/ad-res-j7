# Supplier Catalogue Research - Skincare Ingredients

**Research Date:** October 13, 2025  
**Objective:** Verify availability and pricing accessibility for raw materials in the skincare ingredient supply chain hypergraph

## Overview

This directory contains the results of a comprehensive search of product catalogues from 23 South African skincare ingredient suppliers. The research verified availability information for 91 raw materials used in cosmetic formulations.

## Files

### Data Files

- **hypergraph_nodes_updated.tsv** - Enhanced node data with availability attributes
  - Added fields: `availability_status`, `manufacturer`, `verified_product_name`, `pricing_access`
  
- **hypergraph_edges_updated.tsv** - Enhanced edge data with verification status
  - Added fields: `verified`, `last_checked`
  
- **supplier_ingredient_mapping.json** - Structured JSON mapping of suppliers to ingredients

### Documentation

- **supplier_catalogue_research_report.md** - Comprehensive research report with findings, analysis, and recommendations

- **ingredient_manufacturer_mapping.txt** - Detailed manufacturer information for verified products

## Key Findings

### Availability Status Summary

| Status | Count | Percentage |
|--------|-------|------------|
| Confirmed Available | 9 | 9.9% |
| Requires Verification | 9 | 9.9% |
| Not Found in Catalogues | 2 | 2.2% |
| Requires Direct Inquiry | 71 | 78.0% |

### Verified Manufacturers

- **Seppic** (4 products) - Emulsifiers, thickeners, active ingredients
- **Mibelle Biochemistry** (3 products) - Plant biotechnology, sustainable actives
- **Lubrizol** (2 products) - Rheology modifiers, polymers
- **Croda** (7 products, partial verification) - Active ingredients, peptides, emollients

### Pricing Access

All suppliers follow a **quote-only pricing model**. Pricing information requires:
1. Business account registration
2. Direct contact with sales representatives
3. Formal quotation requests with quantities and delivery requirements

## Usage

### Loading Updated Hypergraph Data

```python
import pandas as pd

# Load updated nodes
nodes = pd.read_csv('hypergraph_nodes_updated.tsv', sep='\t')

# Load updated edges
edges = pd.read_csv('hypergraph_edges_updated.tsv', sep='\t')

# Filter confirmed available ingredients
confirmed = nodes[nodes['availability_status'] == 'confirmed']
print(f"Confirmed available: {len(confirmed)} ingredients")
```

### Querying Supplier-Ingredient Relationships

```python
import json

# Load supplier-ingredient mapping
with open('supplier_ingredient_mapping.json', 'r') as f:
    mapping = json.load(f)

# Find all ingredients from a specific supplier
for supplier in mapping:
    if 'CJP Chemicals' in supplier['supplier_name']:
        print(f"\n{supplier['supplier_name']}:")
        for ing in supplier['ingredients']:
            print(f"  - {ing['name']}")
```

## Next Steps

1. **Direct Contact** - Engage with suppliers for the 71 ingredients requiring direct inquiry
2. **Account Registration** - Register business accounts with major distributors
3. **Verification** - Confirm status of products marked "requires_verification"
4. **Alternative Sourcing** - Research alternatives for "not_found" ingredients
5. **Database Integration** - Sync enhanced data to Supabase and Neon databases

## Contact Information

Key suppliers with verified products:

- **Carst & Walker**: +27 11 489 3600 | https://carst.com/
- **Botanichem**: +27 11 425 2206 | https://botanichem.co.za/
- **IMCD South Africa**: https://www.imcdsa.co.za/
- **Croda South Africa**: https://www.croda.com/

---

**Research conducted by:** Manus AI Research System  
**Next review recommended:** January 2026
