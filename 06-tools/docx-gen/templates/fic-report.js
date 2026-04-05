#!/usr/bin/env node
/**
 * FIC Suspicious Transaction Report DOCX Template
 *
 * Financial Intelligence Centre suspicious activity / transaction report format.
 * Covers money laundering, suspicious transfers, and FICA violations.
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
 * @param {Array} data.suspects - [{ name, role, involvement }]
 * @param {Array} data.suspiciousTransactions - [{ date, description, amount, accounts, indicator }]
 * @param {Array} data.moneyLaunderingIndicators - [{ indicator, evidence, status }]
 * @param {Array} data.requestForAction - [string]
 * @param {Array} data.annexures - [{ id, description }]
 */
function buildFicReport(data) {
  const children = [];

  children.push(...reportTitleBlock({
    title: 'FIC SUSPICIOUS TRANSACTION REPORT',
    caseRef: data.caseRef,
    date: data.date,
    version: data.version,
    burdenOfProof: data.burdenOfProof,
    additionalFields: [
      ['Submitted To', 'Financial Intelligence Centre'],
      ['Report Type', 'Suspicious Transaction Report (STR)'],
    ],
  }));

  // Executive Summary
  if (data.executiveSummary) {
    children.push(h1('EXECUTIVE SUMMARY'));
    const paras = Array.isArray(data.executiveSummary) ? data.executiveSummary : [data.executiveSummary];
    paras.forEach(para => children.push(p(para)));
    children.push(horizontalRule());
  }

  // 1. Persons Involved
  if (data.suspects && data.suspects.length > 0) {
    children.push(h1('1. PERSONS INVOLVED'));
    children.push(legalTable(
      ['Name', 'Role', 'Involvement'],
      data.suspects.map(s => [s.name, s.role, s.involvement]),
    ));
    children.push(horizontalRule());
  }

  // 2. Suspicious Transactions
  if (data.suspiciousTransactions && data.suspiciousTransactions.length > 0) {
    children.push(h1('2. SUSPICIOUS TRANSACTIONS'));
    children.push(legalTable(
      ['Date', 'Description', 'Amount (ZAR)', 'Accounts', 'Indicator'],
      data.suspiciousTransactions.map(t => [
        t.date, t.description, t.amount, t.accounts || '', t.indicator || '',
      ]),
    ));
    children.push(horizontalRule());
  }

  // 3. Money Laundering Indicators
  if (data.moneyLaunderingIndicators && data.moneyLaunderingIndicators.length > 0) {
    children.push(h1('3. MONEY LAUNDERING INDICATORS'));
    children.push(legalTable(
      ['Indicator', 'Evidence', 'Status'],
      data.moneyLaunderingIndicators.map(m => [m.indicator, m.evidence, m.status]),
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
      headers: { default: docHeader(data.caseRef, 'FIC Suspicious Transaction Report') },
      footers: { default: docFooter() },
      children,
    }],
  });
}

module.exports = { buildFicReport };
