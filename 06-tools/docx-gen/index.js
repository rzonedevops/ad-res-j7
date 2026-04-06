#!/usr/bin/env node
/**
 * docx-gen — Legal DOCX Generator CLI
 *
 * Usage:
 *   node docx-gen/index.js <template> <data.json> [output.docx]
 *   node docx-gen/index.js --list
 *   node docx-gen/index.js --demo <template>
 *
 * Templates:
 *   affidavit   — High Court answering affidavit
 *   cipc        — CIPC Companies Act complaint
 *   saps        — SAPS commercial crime submission
 *   npa / sars  — NPA / SARS tax fraud report
 *   fic         — FIC suspicious transaction report
 *   popia       — POPIA complaint
 *   misconduct  — Professional misconduct (SAICA/SAIPA)
 *   report      — Generic legal report
 */

const fs = require('fs');
const path = require('path');
const { Packer } = require('docx');
const { TEMPLATES } = require('./templates');

// ── CLI parsing ─────────────────────────────────────────────────────────────

async function main() {
  const args = process.argv.slice(2);

  if (args.length === 0 || args.includes('--help') || args.includes('-h')) {
    printUsage();
    return 0;
  }

  if (args.includes('--list')) {
    printTemplateList();
    return 0;
  }

  if (args[0] === '--demo') {
    const templateName = args[1];
    if (!templateName) {
      console.error('❌ --demo requires a template name');
      return 1;
    }
    return await generateDemo(templateName, args[2]);
  }

  // Standard: <template> <data.json> [output.docx]
  const templateName = args[0];
  const dataPath = args[1];
  const outputPath = args[2];

  if (!templateName || !dataPath) {
    console.error('❌ Usage: docx-gen <template> <data.json> [output.docx]');
    return 1;
  }

  return await generateFromJson(templateName, dataPath, outputPath);
}

// ── Commands ────────────────────────────────────────────────────────────────

function printUsage() {
  console.log(`
docx-gen — Legal DOCX Generator

Usage:
  node docx-gen/index.js <template> <data.json> [output.docx]
  node docx-gen/index.js --list
  node docx-gen/index.js --demo <template> [output.docx]

Options:
  --list          List available templates
  --demo <name>   Generate a demo document for the named template
  --help, -h      Show this help message

Templates:
  affidavit       High Court answering affidavit
  cipc            CIPC Companies Act complaint
  saps            SAPS commercial crime submission
  npa             NPA tax fraud report
  sars            SARS tax fraud report (alias for npa)
  fic             FIC suspicious transaction report
  popia           POPIA complaint
  misconduct      Professional misconduct (SAICA/SAIPA)
  report          Generic legal report

Examples:
  node docx-gen/index.js cipc data/cipc-data.json output/cipc-complaint.docx
  node docx-gen/index.js --demo affidavit
  node docx-gen/index.js --list
  `);
}

function printTemplateList() {
  console.log('\n📄 Available DOCX Templates:\n');
  const maxLen = Math.max(...Object.keys(TEMPLATES).map(k => k.length));
  for (const [key, tmpl] of Object.entries(TEMPLATES)) {
    console.log(`  ${key.padEnd(maxLen + 2)} ${tmpl.label}`);
    console.log(`  ${''.padEnd(maxLen + 2)} ${tmpl.description}\n`);
  }
}

async function generateFromJson(templateName, dataPath, outputPath) {
  const tmpl = TEMPLATES[templateName];
  if (!tmpl) {
    console.error(`❌ Unknown template: "${templateName}"`);
    console.error(`   Use --list to see available templates.`);
    return 1;
  }

  const absDataPath = path.resolve(dataPath);
  if (!fs.existsSync(absDataPath)) {
    console.error(`❌ Data file not found: ${absDataPath}`);
    return 1;
  }

  let data;
  try {
    data = JSON.parse(fs.readFileSync(absDataPath, 'utf8'));
  } catch (err) {
    console.error(`❌ Failed to parse JSON: ${err.message}`);
    return 1;
  }

  const doc = tmpl.build(data);
  const outFile = outputPath || `${templateName}-${Date.now()}.docx`;
  const absOut = path.resolve(outFile);

  const dir = path.dirname(absOut);
  if (!fs.existsSync(dir)) {
    fs.mkdirSync(dir, { recursive: true });
  }

  const buffer = await Packer.toBuffer(doc);
  fs.writeFileSync(absOut, buffer);

  console.log(`✅ Generated: ${absOut}`);
  console.log(`   Template:  ${tmpl.label}`);
  console.log(`   Size:      ${(buffer.length / 1024).toFixed(1)} KB`);
  return 0;
}

async function generateDemo(templateName, outputPath) {
  const tmpl = TEMPLATES[templateName];
  if (!tmpl) {
    console.error(`❌ Unknown template: "${templateName}"`);
    return 1;
  }

  const demoDataPath = path.join(__dirname, 'demo-data', `${templateName}.json`);
  if (!fs.existsSync(demoDataPath)) {
    console.error(`❌ No demo data found for "${templateName}" at ${demoDataPath}`);
    console.error(`   Create ${demoDataPath} with sample data.`);
    return 1;
  }

  const data = JSON.parse(fs.readFileSync(demoDataPath, 'utf8'));
  const doc = tmpl.build(data);
  const outFile = outputPath || `demo-${templateName}.docx`;
  const absOut = path.resolve(outFile);

  const dir = path.dirname(absOut);
  if (!fs.existsSync(dir)) {
    fs.mkdirSync(dir, { recursive: true });
  }

  const buffer = await Packer.toBuffer(doc);
  fs.writeFileSync(absOut, buffer);

  console.log(`✅ Demo generated: ${absOut}`);
  console.log(`   Template:       ${tmpl.label}`);
  console.log(`   Size:           ${(buffer.length / 1024).toFixed(1)} KB`);
  return 0;
}

// ── Entrypoint ──────────────────────────────────────────────────────────────

main()
  .then(code => process.exit(code))
  .catch(err => {
    console.error('❌ Fatal error:', err.message);
    process.exit(1);
  });
