#!/usr/bin/env node
/**
 * NPA Tax Fraud Report DOCX Template
 *
 * National Prosecuting Authority / SARS report format.
 * Covers tax fraud, fraudulent SARS submissions, and related offenses.
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
 * @param {Array} data.suspects - [{ name, idNumber, role, proofOfForeknowledge }]
 * @param {Array} data.taxViolations - [{ act, section, violation, evidence, status }]
 * @param {Array} data.financialImpact - [{ category, amount, percentage }]
 * @param {Array} data.requestForAction - [string]
 * @param {Array} data.annexures - [{ id, description }]
 */
function buildNpaTaxFraudReport(data) {
  const children = [];

  children.push(...reportTitleBlock({
    title: 'NPA TAX FRAUD REPORT',
    caseRef: data.caseRef,
    date: data.date,
    version: data.version,
    burdenOfProof: data.burdenOfProof,
    additionalFields: [
      ['Submitted To', 'National Prosecuting Authority / SARS'],
    ],
  }));

  // Executive Summary
  if (data.executiveSummary) {
    children.push(h1('EXECUTIVE SUMMARY'));
    const paras = Array.isArray(data.executiveSummary) ? data.executiveSummary : [data.executiveSummary];
    paras.forEach(para => children.push(p(para)));
    children.push(horizontalRule());
  }

  // 1. Suspects
  if (data.suspects && data.suspects.length > 0) {
    children.push(h1('1. SUSPECTS'));
    children.push(legalTable(
      ['Name', 'ID Number', 'Role', 'Proof of Foreknowledge'],
      data.suspects.map(s => [s.name, s.idNumber || '', s.role, s.proofOfForeknowledge || '']),
    ));
    children.push(horizontalRule());
  }

  // 2. Tax Violations
  if (data.taxViolations && data.taxViolations.length > 0) {
    children.push(h1('2. TAX VIOLATIONS & STATUTORY OFFENSES'));
    children.push(legalTable(
      ['Act', 'Section', 'Violation', 'Evidence', 'Status'],
      data.taxViolations.map(v => [v.act, v.section, v.violation, v.evidence, v.status]),
    ));
    children.push(horizontalRule());
  }

  // 3. Financial Impact
  if (data.financialImpact && data.financialImpact.length > 0) {
    children.push(h1('3. FINANCIAL IMPACT'));
    children.push(legalTable(
      ['Category', 'Amount (ZAR)', 'Percentage'],
      data.financialImpact.map(f => [f.category, f.amount, f.percentage || '']),
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

  // Request for Action
  if (data.requestForAction) {
    children.push(h1('REQUEST FOR ACTION'));
    data.requestForAction.forEach((item, i) => {
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
      headers: { default: docHeader(data.caseRef, 'NPA Tax Fraud Report') },
      footers: { default: docFooter() },
      children,
    }],
  });
}

module.exports = { buildNpaTaxFraudReport };
