#!/usr/bin/env node
/**
 * POPIA Complaint DOCX Template
 *
 * Protection of Personal Information Act complaint to the Information Regulator.
 * Covers data protection violations, unauthorized access, and privacy breaches.
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
 * @param {string|Array} data.executiveSummary
 * @param {Object} data.complainants - { names, capacity }
 * @param {Array} data.respondents - [{ name, role, violations }]
 * @param {Array} data.violations - [{ section, condition, violation, evidence, status }]
 * @param {Array} data.dataSubjects - [{ name, dataCompromised, impact }]
 * @param {Array} data.reliefSought - [string]
 * @param {Array} data.annexures - [{ id, description }]
 */
function buildPopiaComplaint(data) {
  const children = [];

  children.push(...reportTitleBlock({
    title: 'POPIA COMPLAINT',
    caseRef: data.caseRef,
    date: data.date,
    version: data.version,
    burdenOfProof: data.burdenOfProof,
    additionalFields: [
      ['Submitted To', 'Information Regulator (South Africa)'],
      ['Act', 'Protection of Personal Information Act 4 of 2013'],
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

  if (data.respondents && data.respondents.length > 0) {
    children.push(h2('Respondents'));
    children.push(legalTable(
      ['Name', 'Role', 'Violations'],
      data.respondents.map(r => [r.name, r.role, r.violations]),
    ));
    children.push(emptyLine());
  }

  children.push(horizontalRule());

  // 2. POPIA Violations
  if (data.violations && data.violations.length > 0) {
    children.push(h1('2. POPIA VIOLATIONS'));
    children.push(legalTable(
      ['Section', 'Condition', 'Violation', 'Evidence', 'Status'],
      data.violations.map(v => [v.section, v.condition, v.violation, v.evidence, v.status]),
    ));
    children.push(horizontalRule());
  }

  // 3. Data Subjects Affected
  if (data.dataSubjects && data.dataSubjects.length > 0) {
    children.push(h1('3. DATA SUBJECTS AFFECTED'));
    children.push(legalTable(
      ['Data Subject', 'Data Compromised', 'Impact'],
      data.dataSubjects.map(d => [d.name, d.dataCompromised, d.impact]),
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
      headers: { default: docHeader(data.caseRef, 'POPIA Complaint') },
      footers: { default: docFooter() },
      children,
    }],
  });
}

module.exports = { buildPopiaComplaint };
