#!/usr/bin/env node

const HypergraphManager = require('./hypergraph-manager');
const fs = require('fs');
const path = require('path');

/**
 * Populate Hypergraph with 15 Forensic Analysis Events from Case 2025-137857
 * 
 * This script loads forensic-events-data.json and creates:
 * - 15 event nodes (across Revenue Theft, Trust Violations, Financial Flows)
 * - Person nodes for perpetrators
 * - Timeline sequence relationships
 * - Category-based groupings
 * - Shopify platform revelation connections
 */
async function populateForensicTimeline() {
  const hg = new HypergraphManager();
  
  console.log('📅 Populating Forensic Timeline Events for Case 2025-137857\n');

  try {
    // Load forensic events data
    const dataPath = path.join(__dirname, '..', 'forensic-events-data.json');
    const forensicData = JSON.parse(fs.readFileSync(dataPath, 'utf8'));
    
    console.log(`📖 Loaded forensic data: ${forensicData.events.length} events\n`);
    
    // ===== CREATE PERPETRATOR NODES =====
    console.log('👥 Creating perpetrator nodes...');
    const perpetrators = new Map();
    
    // Collect unique perpetrators
    const uniquePerps = new Set();
    forensicData.events.forEach(event => {
      event.perpetrators.forEach(perp => uniquePerps.add(perp));
    });
    
    // Create perpetrator nodes
    for (const perpName of uniquePerps) {
      const perpId = perpName.toLowerCase().replace(/\s+/g, '_');
      const node = await hg.createNode('person', perpName, perpId, 
        `Perpetrator in Case 2025-137857`, 
        { role: 'perpetrator' });
      perpetrators.set(perpName, node);
      console.log(`  ✅ Created: ${perpName}`);
    }
    
    console.log(`\n  Total perpetrators: ${perpetrators.size}\n`);
    
    // ===== CREATE CATEGORY NODES =====
    console.log('📂 Creating category nodes...');
    const categories = new Map();
    
    for (const category of forensicData.categories) {
      const node = await hg.createNode(
        'category', 
        category.name, 
        category.id,
        category.description,
        {
          eventCount: category.eventCount,
          totalLoss: category.totalLoss,
          color: category.color
        }
      );
      categories.set(category.id, node);
      console.log(`  ✅ ${category.name}: ${category.eventCount} events, ${category.totalLoss}`);
    }
    
    console.log();
    
    // ===== CREATE SHOPIFY PLATFORM NODE =====
    console.log('🛍️  Creating Shopify platform revelation node...');
    const shopifyPlatform = await hg.createNode(
      'financial_entity',
      'RegimA Zone Ltd Shopify Platform',
      'regima_zone_shopify',
      forensicData.criticalRevelation.details,
      {
        owner: forensicData.shopifyPlatformFacts.owner,
        paidBy: forensicData.shopifyPlatformFacts.paidBy,
        since: forensicData.shopifyPlatformFacts.since,
        duration: forensicData.shopifyPlatformFacts.duration,
        totalInvestment: forensicData.shopifyPlatformFacts.totalInvestment,
        keyImplication: forensicData.shopifyPlatformFacts.keyImplication
      }
    );
    console.log(`  ✅ Created Shopify platform revelation node\n`);
    
    // ===== CREATE EVENT NODES =====
    console.log('📅 Creating forensic event nodes...\n');
    const eventNodes = [];
    
    for (const event of forensicData.events) {
      const eventId = `forensic_event_${event.id}`;
      
      const node = await hg.createNode(
        'event',
        event.title,
        eventId,
        event.description,
        {
          date: event.date,
          category: event.category,
          crimeType: event.crimeType,
          impact: event.impact,
          legalSignificance: event.legalSignificance,
          shopifyConnection: event.shopifyConnection,
          shopifyNote: event.shopifyNote || null,
          shopifyRevelation: event.shopifyRevelation || null,
          evidenceReferences: event.evidenceReferences,
          eventNumber: event.id
        }
      );
      
      eventNodes.push({ event, node });
      
      const shopifyIndicator = event.shopifyConnection ? '🛍️ ' : '  ';
      console.log(`  ${shopifyIndicator}Event #${event.id} (${event.date}): ${event.title}`);
      console.log(`     Category: ${event.category} | Crime: ${event.crimeType}`);
      if (event.shopifyConnection) {
        console.log(`     ⚠️  Shopify: ${event.shopifyRevelation?.substring(0, 80)}...`);
      }
      console.log();
    }
    
    console.log(`  Total events created: ${eventNodes.length}\n`);
    
    // ===== CREATE RELATIONSHIPS =====
    console.log('🔗 Creating relationships...\n');
    
    // Link events to categories
    console.log('  Linking events to categories...');
    let categoryLinks = 0;
    for (const { event, node } of eventNodes) {
      const category = categories.get(event.category);
      if (category) {
        await hg.createEdge(
          'belongs_to_category',
          `Event belongs to ${event.category}`,
          [
            { nodeId: node.id, role: 'event' },
            { nodeId: category.id, role: 'category' }
          ],
          100,
          'directed',
          { category: event.category }
        );
        categoryLinks++;
      }
    }
    console.log(`    ✅ Created ${categoryLinks} category links\n`);
    
    // Link events to perpetrators
    console.log('  Linking events to perpetrators...');
    let perpetratorLinks = 0;
    for (const { event, node } of eventNodes) {
      for (const perpName of event.perpetrators) {
        const perpNode = perpetrators.get(perpName);
        if (perpNode) {
          await hg.createEdge(
            'perpetrated_by',
            `${event.title} perpetrated by ${perpName}`,
            [
              { nodeId: node.id, role: 'event' },
              { nodeId: perpNode.id, role: 'perpetrator' }
            ],
            90,
            'directed',
            { crimeType: event.crimeType }
          );
          perpetratorLinks++;
        }
      }
    }
    console.log(`    ✅ Created ${perpetratorLinks} perpetrator links\n`);
    
    // Link Shopify-connected events to platform
    console.log('  Linking Shopify-connected events...');
    let shopifyLinks = 0;
    for (const { event, node } of eventNodes) {
      if (event.shopifyConnection) {
        await hg.createEdge(
          'related_to_shopify',
          `Event related to Shopify platform`,
          [
            { nodeId: node.id, role: 'event' },
            { nodeId: shopifyPlatform.id, role: 'platform' }
          ],
          95,
          'directed',
          { 
            shopifyNote: event.shopifyNote,
            shopifyRevelation: event.shopifyRevelation
          }
        );
        shopifyLinks++;
      }
    }
    console.log(`    ✅ Created ${shopifyLinks} Shopify platform links\n`);
    
    // Create chronological timeline sequence
    console.log('  Creating chronological timeline...');
    const sortedEvents = eventNodes.sort((a, b) => 
      new Date(a.event.date) - new Date(b.event.date)
    );
    
    let timelineLinks = 0;
    for (let i = 0; i < sortedEvents.length - 1; i++) {
      const current = sortedEvents[i];
      const next = sortedEvents[i + 1];
      
      await hg.createEdge(
        'followed_by',
        `${current.event.title} followed by ${next.event.title}`,
        [
          { nodeId: current.node.id, role: 'earlier', position: i },
          { nodeId: next.node.id, role: 'later', position: i + 1 }
        ],
        80,
        'directed',
        { 
          timeGap: `${current.event.date} → ${next.event.date}`,
          sequence: i + 1
        }
      );
      timelineLinks++;
    }
    console.log(`    ✅ Created ${timelineLinks} timeline sequence links\n`);
    
    // Create category-specific timelines
    console.log('  Creating category-specific timelines...');
    let categoryTimelineLinks = 0;
    
    for (const [categoryId, categoryNode] of categories) {
      const categoryEvents = eventNodes
        .filter(({ event }) => event.category === categoryId)
        .sort((a, b) => new Date(a.event.date) - new Date(b.event.date));
      
      if (categoryEvents.length > 0) {
        const nodeIds = categoryEvents.map(({ node }) => ({ 
          nodeId: node.id, 
          role: 'event' 
        }));
        nodeIds.push({ nodeId: categoryNode.id, role: 'category' });
        
        await hg.createEdge(
          'category_timeline',
          `${categoryNode.label} timeline sequence`,
          nodeIds,
          85,
          'directed',
          { category: categoryId, eventCount: categoryEvents.length }
        );
        categoryTimelineLinks++;
      }
    }
    console.log(`    ✅ Created ${categoryTimelineLinks} category timeline links\n`);
    
    // ===== SUMMARY STATISTICS =====
    console.log('📊 Forensic Timeline Population Summary\n');
    
    const stats = await hg.getStatistics();
    
    console.log('Case Information:');
    console.log(`  Case Number: ${forensicData.caseNumber}`);
    console.log(`  Case Name: ${forensicData.caseName}`);
    console.log(`  Timeline: ${forensicData.timeline.startDate} to ${forensicData.timeline.endDate}`);
    console.log(`  Duration: ${forensicData.timeline.durationDays} days`);
    console.log(`  Active Criminal Days: ${forensicData.timeline.activeCriminalDays}\n`);
    
    console.log('Financial Impact:');
    console.log(`  Revenue Losses: ${forensicData.totalLosses.revenue}`);
    console.log(`  Trust Violations: ${forensicData.totalLosses.trust}`);
    console.log(`  Financial Losses: ${forensicData.totalLosses.financial}`);
    console.log(`  TOTAL LOSSES: ${forensicData.totalLosses.total}\n`);
    
    console.log('Database Statistics:');
    console.log(`  Total Nodes: ${stats.total_nodes}`);
    console.log(`  Total Edges: ${stats.total_edges}`);
    console.log(`  Total Relations: ${stats.total_relations}\n`);
    
    console.log('Nodes Created:');
    console.log(`  ✅ Events: ${eventNodes.length}`);
    console.log(`  ✅ Perpetrators: ${perpetrators.size}`);
    console.log(`  ✅ Categories: ${categories.size}`);
    console.log(`  ✅ Shopify Platform: 1\n`);
    
    console.log('Relationships Created:');
    console.log(`  ✅ Category Links: ${categoryLinks}`);
    console.log(`  ✅ Perpetrator Links: ${perpetratorLinks}`);
    console.log(`  ✅ Shopify Links: ${shopifyLinks}`);
    console.log(`  ✅ Timeline Sequence: ${timelineLinks}`);
    console.log(`  ✅ Category Timelines: ${categoryTimelineLinks}\n`);
    
    console.log('✨ Forensic timeline population complete!\n');
    
    console.log('💡 Query Examples:');
    console.log('  - npm run db:hypergraph:stats');
    console.log('  - npm run db:hypergraph:demo');
    console.log('  - node db/hypergraph-manager.js query "event" "forensic_event_6"\n');
    
    return {
      success: true,
      eventsCreated: eventNodes.length,
      perpetratorsCreated: perpetrators.size,
      categoriesCreated: categories.size,
      relationshipsCreated: categoryLinks + perpetratorLinks + shopifyLinks + timelineLinks + categoryTimelineLinks
    };
    
  } catch (error) {
    console.error('❌ Error populating forensic timeline:', error);
    if (error.stack) {
      console.error(error.stack);
    }
    process.exit(1);
  }
}

// Run if executed directly
if (require.main === module) {
  populateForensicTimeline()
    .then(result => {
      console.log('✅ Script completed successfully');
      process.exit(0);
    })
    .catch(error => {
      console.error('❌ Script failed:', error);
      process.exit(1);
    });
}

module.exports = { populateForensicTimeline };
