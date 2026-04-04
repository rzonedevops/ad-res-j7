# Forensic Timeline Integration Guide

## Overview

This guide documents the integration of all 15 forensic analysis events from Case 2025-137857 into the database hypergraph structure. The forensic timeline captures systematic criminal activities across three categories: Revenue Theft, Family Trust Violations, and Financial Flows.

## Case Summary

**Case Number:** 2025-137857  
**Case Name:** Peter Faucitt v. Jacqueline Faucitt et al.  
**Timeline Duration:** March 15 - August 20, 2025 (158 days)  
**Active Criminal Days:** 156 days of continuous criminal activity  
**Total Documented Losses:** R10,269,727.90

### Financial Impact Breakdown

| Category | Events | Documented Losses |
|----------|--------|-------------------|
| Revenue Theft | 5 | R3,141,647.70 |
| Family Trust Violations | 5 | R2,851,247.35 |
| Financial Flows | 5 | R4,276,832.85 |
| **TOTAL** | **15** | **R10,269,727.90** |

## Critical Revelation

**The Dan & Kay Shopify platform has been paid by Dan & Jax UK company RegimA Zone Ltd the whole time.**

- **Platform Owner:** RegimA Zone Ltd (UK) - Daniel Faucitt's independent UK entity
- **Payment Period:** Since July 2023 (28+ months)
- **Total Investment:** R140,000 - R280,000
- **Monthly Cost:** $1,000 - $2,000 USD

**Key Implication:** RWD ZA has no independent revenue stream. All revenues were generated through infrastructure owned, paid for, and operated by Daniel's UK company.

## Files Created

### 1. Database Population Script
**File:** `db/populate-forensic-timeline.js`

Creates comprehensive hypergraph representation of forensic timeline:

```bash
npm run db:forensic-timeline:populate
```

**What it creates:**
- 15 event nodes with complete metadata
- Perpetrator person nodes (unique from all events)
- 3 category nodes (Revenue Theft, Trust Violations, Financial Flows)
- 1 Shopify platform revelation node
- Multiple relationship edges:
  - Category membership
  - Perpetrator attribution
  - Shopify platform connections
  - Chronological timeline sequences
  - Category-specific timelines

### 2. Test Suite
**File:** `tests/forensic-timeline-population.test.js`

Validates the forensic timeline integration:

```bash
npm run test:forensic-timeline
```

**Test Coverage (33 tests):**
- ✅ Required files existence (4 tests)
- ✅ Forensic data structure validation (13 tests)
- ✅ Populate script structure (8 tests)
- ✅ Event categorization (4 tests)
- ✅ Shopify platform connections (4 tests)

**Success Rate:** 100% (33/33 tests passing)

## Event Categories

### Revenue Theft (5 Events)

1. **2025-04-14:** Bank Account Change Letter
2. **2025-05-22:** Shopify Audit Trail Hijacking ⭐ CRITICAL
3. **2025-05-29:** Domain Registration (Identity Fraud)
4. **2025-06-20:** Email Impersonation Pattern
5. **2025-07-08:** Warehouse POPI Violations

**Total Loss:** R3,141,647.70

### Family Trust Violations (5 Events)

6. **2025-03-15:** Trust Structure Establishment
7. **2025-05-02:** Unauthorized Beneficiary Changes
8. **2025-06-18:** Systematic Trust Violations
9. **2025-07-25:** Trust Asset Misappropriation
10. **2025-08-10:** Trust Breach Evidence

**Total Loss:** R2,851,247.35

### Financial Flows (5 Events)

11. **2025-04-01:** Payment Redirection Scheme
12. **2025-05-15:** Unauthorized Transfers (R850K+)
13. **2025-06-30:** Coordinated Fund Diversions
14. **2025-07-12:** Account Manipulation
15. **2025-08-20:** Financial Evidence Concealment

**Total Loss:** R4,276,832.85

## Data Structure

### Event Node Schema

Each event node contains:

```javascript
{
  nodeType: 'event',
  label: 'Event Title',
  entityId: 'forensic_event_N',
  description: 'Detailed event description',
  metadata: {
    date: 'YYYY-MM-DD',
    category: 'revenue|trust|financial',
    crimeType: 'Specific crime classification',
    impact: 'Financial/operational impact',
    legalSignificance: 'Legal importance',
    shopifyConnection: true|false,
    shopifyNote: 'Connection to Shopify platform',
    shopifyRevelation: 'Revelation about RWD revenue',
    evidenceReferences: ['path/to/evidence'],
    eventNumber: N
  }
}
```

### Relationship Types

1. **belongs_to_category**: Links events to their category
2. **perpetrated_by**: Links events to perpetrators
3. **related_to_shopify**: Links events to Shopify platform node
4. **followed_by**: Chronological timeline sequence
5. **category_timeline**: Category-specific event sequences

## Usage Examples

### Populate Database

```bash
# Ensure DATABASE_URL is set in .env
npm run db:forensic-timeline:populate
```

### Query Examples

```javascript
const HypergraphManager = require('./db/hypergraph-manager');
const hg = new HypergraphManager();

// Get all forensic events
const events = await hg.findNodesByType('event');
const forensicEvents = events.filter(e => 
  e.entity_id && e.entity_id.startsWith('forensic_event_')
);

// Get all Shopify-connected events
const shopifyEdges = await hg.findEdgesByType('related_to_shopify');

// Get all events by a perpetrator
const peterNode = await hg.findNodeByEntity('peter_faucitt');
const peterEvents = await hg.getConnectedNodes(peterNode.id, 'perpetrated_by');

// Get revenue theft category events
const revenueCategoryNode = await hg.findNodeByEntity('revenue');
const revenueEvents = await hg.getConnectedNodes(
  revenueCategoryNode.id, 
  'belongs_to_category'
);

// Get timeline sequence
const timelineEdges = await hg.findEdgesByType('followed_by');

// Get statistics
const stats = await hg.getStatistics();
console.log(`Total nodes: ${stats.total_nodes}`);
console.log(`Total edges: ${stats.total_edges}`);
```

### View Statistics

```bash
npm run db:hypergraph:stats
```

## Database Schema

The forensic timeline uses the existing hypergraph schema defined in `db/hypergraph-schema.js`:

- **hypergraph_nodes**: Stores event, person, category, and financial entity nodes
- **hypergraph_edges**: Stores relationship edges between nodes
- **hypergraph_relations**: Junction table linking nodes to edges

## Integration with Existing Systems

### Cross-References

The forensic timeline integrates with:

1. **Evidence Files:** Each event includes `evidenceReferences` pointing to documentation
2. **Case Hypergraph:** Events can be linked to existing issues, documents, evidence
3. **Hierarchical Issues:** Events support the hierarchical issue tracking system
4. **Legal Arguments:** Events provide factual basis for legal argument nodes

### Timeline Visualization

The forensic timeline data is also available in:

- **HTML Visualization:** `forensic-events-timeline-visualization.html`
- **JSON Data:** `forensic-events-data.json`
- **Database Queries:** Via HypergraphManager API

## Shopify Platform Revelation

10 of the 15 events are directly connected to the Shopify platform revelation, proving that:

1. RegimA Zone Ltd (UK) owns and pays for the Shopify platform
2. RWD ZA has no independent revenue stream
3. All RWD revenue came from infrastructure Dan & Jax funded
4. The revelation undermines claims of independent business operations

## Legal Significance

This timeline serves as:

1. **Pattern Evidence:** Demonstrates systematic coordination across categories
2. **Consciousness of Guilt:** Event #6 (Audit Trail Hijacking) proves awareness
3. **Financial Impact:** Documents R10.27M+ in quantifiable losses
4. **Criminal Coordination:** Links multiple perpetrators across event sequences
5. **Shopify Platform Proof:** Visual representation of RWD's lack of independent revenue

## Maintenance

### Updating Events

To modify forensic events:

1. Edit `forensic-events-data.json`
2. Run tests: `npm run test:forensic-timeline`
3. Re-populate database: `npm run db:forensic-timeline:populate`

### Adding New Events

To add new forensic events:

1. Add event to `forensic-events-data.json` events array
2. Update event count in tests
3. Update documentation
4. Re-run population script

## References

### Source Documentation

- `forensic-events-data.json` - Complete event data
- `FORENSIC_TIMELINE_VISUALIZATION_README.md` - Visualization guide
- `todo/Repository_Status_and_Critical_Evidence_Collection.md` - Original task (line 84)

### Legal Framework References

- **POCA (Prevention of Organised Crime Act) 121 of 1998:** Sections 2-3, 37-38
- **ECTA (Electronic Communications and Transactions Act) 25 of 2002:** Sections 86-88
- **Trust Property Control Act 57 of 1988:** Sections 12, 20, 26
- **Banks Act 94 of 1990:** Sections 78, 91
- **FIC Act (Financial Intelligence Centre Act) 38 of 2001:** Sections 34, 45

## Troubleshooting

### Database Connection Issues

If you see database connection errors:

```bash
# Check .env file exists and has DATABASE_URL
cp .env.example .env
# Edit .env and set DATABASE_URL

# Test connection
npm run db:test
```

### Missing Dependencies

```bash
# Install all dependencies
npm install
```

### Schema Not Set Up

```bash
# Run migrations in order
npm run db:migrate
npm run db:hypergraph:setup
```

## Next Steps

After populating the forensic timeline:

1. **Link to Issues:** Connect events to hierarchical issues
2. **Evidence Integration:** Link to specific evidence files
3. **Visualization:** Generate visual timeline representations
4. **Analysis:** Run queries to identify patterns and connections
5. **Legal Arguments:** Use events to support legal argument nodes

## Support

For questions or issues:

1. Review this documentation
2. Check test results: `npm run test:forensic-timeline`
3. Examine populate script: `db/populate-forensic-timeline.js`
4. Review source data: `forensic-events-data.json`

---

**Last Updated:** 2025-10-30  
**Version:** 1.0  
**Status:** Complete - All 15 forensic events ready for database population
