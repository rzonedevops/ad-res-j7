#!/usr/bin/env node
/**
 * Professional Misconduct Complaint DOCX Template
 *
 * Complaint to SAICA/SAIPA for professional misconduct by
 * chartered accountants, auditors, or registered practitioners.
 */

const { Document } = require('docx');

const {
  DOCUMENT_STYLES,
  LEGAL_NUMBERING,
  pageProperties,
} = require('../styles');

const {
  p,
  h1,
  h2,
  numberedPara,
  emptyLine,
  horizontalRule,
  legalTable,
  docHeader,
  docFooter,
  reportTitleBlock,
  annexureList,
} = require('../builder');

/**
 * @param {Object} data
 * @param {string} data.caseRef
 * @param {string} data.date
 * @param {string} data.version
 * @param {string} data.burdenOfProof
 * @param {string} data.professionalBody - e.g. "SAICA" or "SAIPA"
 * @param {string|Array} data.executiveSummary
 * @param {Object} data.complainants - { names, capacity }
 * @param {Object} data.respondent - { name, membershipNumber, designation, firm }
 * @param {Array} data.conflictsOfInterest - [{ conflict, evidence, status }]
 * @param {Array} data.breaches - [{ code, rule, breach, evidence, status }]
 * @param {Array} data.reliefSought - [string]
 * @param {Array} data.annexures - [{ id, description }]
 */
function buildProfessionalMisconductComplaint(data) {
  const children = [];

  const body = data.professionalBody || 'SAICA';

  children.push(...reportTitleBlock({
    title: `PROFESSIONAL MISCONDUCT COMPLAINT (${body})`,
    caseRef: data.caseRef,
    date: data.date,
    version: data.version,
    burdenOfProof: data.burdenOfProof,
    additionalFields: [
      ['Submitted To', `${body} Disciplinary Committee`],
    ],
  }));

  // Executive Summary
  if (data.executiveSummary) {
    children.push(h1('EXECUTIVE SUMMARY'));
    const paras = Array.isArray(data.executiveSummary) ? data.executiveSummary : [data.executiveSummary];
    paras.forEach(para => children.push(p(para)));
    children.push(horizontalRule());
  }

  // 1. Parties
  children.push(h1('1. PARTIES'));

  if (data.complainants) {
    children.push(h2('Complainants'));
    children.push(legalTable(
      ['Field', 'Value'],
      [
        ['Names', data.complainants.names],
        ['Capacity', data.complainants.capacity],
      ],
    ));
    children.push(emptyLine());
  }

  if (data.respondent) {
    children.push(h2('Respondent'));
    const rows = [
      ['Name', data.respondent.name],
      ['Membership Number', data.respondent.membershipNumber || 'To be confirmed'],
      ['Designation', data.respondent.designation || ''],
      ['Firm', data.respondent.firm || ''],
    ];
    children.push(legalTable(['Field', 'Value'], rows));
    children.push(emptyLine());
  }

  children.push(horizontalRule());

  // 2. Conflicts of Interest
  if (data.conflictsOfInterest && data.conflictsOfInterest.length > 0) {
    children.push(h1('2. IRRECONCILABLE CONFLICTS OF INTEREST'));
    children.push(legalTable(
      ['Conflict', 'Evidence', 'Status'],
      data.conflictsOfInterest.map(c => [c.conflict, c.evidence, c.status]),
    ));
    children.push(horizontalRule());
  }

  // 3. Professional Code Breaches
  if (data.breaches && data.breaches.length > 0) {
    children.push(h1('3. PROFESSIONAL CODE BREACHES'));
    children.push(legalTable(
      ['Code', 'Rule', 'Breach', 'Evidence', 'Status'],
      data.breaches.map(b => [b.code, b.rule, b.breach, b.evidence, b.status]),
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
      headers: { default: docHeader(data.caseRef, `${body} Misconduct Complaint`) },
      footers: { default: docFooter() },
      children,
    }],
  });
}

module.exports = { buildProfessionalMisconductComplaint };
