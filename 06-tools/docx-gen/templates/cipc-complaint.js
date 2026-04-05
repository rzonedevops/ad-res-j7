#!/usr/bin/env node
/**
 * CIPC Companies Act Complaint DOCX Template
 *
 * Companies and Intellectual Property Commission complaint format.
 * Sections: Parties, Central Motive, Statutory Violations, Relief Sought, Annexures.
 */

const {
  Document,
  HeadingLevel,
} = require('docx');

const {
  DOCUMENT_STYLES,
  LEGAL_NUMBERING,
  pageProperties,
} = require('../styles');

const {
  p,
  pBold,
  h1,
  h2,
  h3,
  numberedPara,
  subPara,
  bulletItem,
  emptyLine,
  pageBreak,
  horizontalRule,
  legalTable,
  docHeader,
  docFooter,
  reportTitleBlock,
  annexureList,
} = require('../builder');

/**
 * @param {Object} data
 * @param {string} data.caseRef - e.g. "2025-137857-CIPC"
 * @param {string} data.date
 * @param {string} data.version
 * @param {string} data.burdenOfProof
 * @param {Object} data.complainants - { names, capacity }
 * @param {Array}  data.tierA - [{ name, idNumber, role, proofOfForeknowledge }]
 * @param {Array}  data.tierC - [{ name, role, involvement, assessment }]
 * @param {string} data.centralMotive - paragraph text
 * @param {Array}  data.violations - [{ section, violation, evidence, status }]
 * @param {Array}  data.reliefSought - [string]
 * @param {Array}  data.annexures - [{ id, description }]
 */
function buildCipcComplaint(data) {
  const children = [];

  // Title block
  children.push(...reportTitleBlock({
    title: 'CIPC COMPANIES ACT COMPLAINT',
    caseRef: data.caseRef,
    date: data.date,
    version: data.version,
    burdenOfProof: data.burdenOfProof,
  }));

  // Executive Summary
  if (data.executiveSummary) {
    children.push(h1('EXECUTIVE SUMMARY'));
    if (Array.isArray(data.executiveSummary)) {
      data.executiveSummary.forEach(para => children.push(p(para)));
    } else {
      children.push(p(data.executiveSummary));
    }
    children.push(horizontalRule());
  }

  // 1. Parties
  children.push(h1('1. PARTIES'));

  children.push(h2('Complainants'));
  children.push(legalTable(
    ['Field', 'Value'],
    [
      ['Names', data.complainants.names],
      ['Capacity', data.complainants.capacity],
    ],
  ));
  children.push(emptyLine());

  if (data.tierA && data.tierA.length > 0) {
    children.push(h2('TIER A: PREMEDITATED CONSPIRATORS (KNOWLEDGE PROVEN)'));
    children.push(legalTable(
      ['Name', 'ID Number', 'Role', 'Proof of Foreknowledge'],
      data.tierA.map(r => [r.name, r.idNumber || '', r.role, r.proofOfForeknowledge]),
    ));
    children.push(emptyLine());
  }

  if (data.tierC && data.tierC.length > 0) {
    children.push(h2('TIER C: PARTICIPANTS (KNOWLEDGE UNPROVEN)'));
    children.push(legalTable(
      ['Name', 'Role', 'Involvement', 'Assessment'],
      data.tierC.map(r => [r.name, r.role, r.involvement, r.assessment]),
    ));
    children.push(emptyLine());
  }

  children.push(horizontalRule());

  // 2. Central Financial Motive
  if (data.centralMotive) {
    children.push(h1('2. CENTRAL FINANCIAL MOTIVE'));
    if (Array.isArray(data.centralMotive)) {
      data.centralMotive.forEach(para => children.push(p(para)));
    } else {
      children.push(p(data.centralMotive));
    }
    children.push(horizontalRule());
  }

  // 3. Statutory Violations
  if (data.violations && data.violations.length > 0) {
    children.push(h1('3. STATUTORY VIOLATIONS'));
    children.push(legalTable(
      ['Section', 'Violation', 'Evidence', 'Status'],
      data.violations.map(v => [v.section, v.violation, v.evidence, v.status]),
    ));
    children.push(horizontalRule());
  }

  // Custom sections
  if (data.sections) {
    data.sections.forEach((section, i) => {
      children.push(h1(`${i + 4}. ${section.title}`));
      if (section.paragraphs) {
        section.paragraphs.forEach(para => children.push(p(para)));
      }
      if (section.table) {
        children.push(legalTable(section.table.headers, section.table.rows));
      }
      children.push(horizontalRule());
    });
  }

  // Relief Sought
  if (data.reliefSought) {
    children.push(h1('RELIEF SOUGHT'));
    data.reliefSought.forEach((item, i) => {
      children.push(numberedPara(`${i + 1}.`, item));
    });
    children.push(horizontalRule());
  }

  // Annexures
  if (data.annexures) {
    children.push(...annexureList(data.annexures));
  }

  return new Document({
    styles: DOCUMENT_STYLES,
    numbering: { config: [LEGAL_NUMBERING] },
    sections: [{
      properties: { ...pageProperties() },
      headers: { default: docHeader(data.caseRef, 'CIPC Complaint') },
      footers: { default: docFooter() },
      children,
    }],
  });
}

module.exports = { buildCipcComplaint };
