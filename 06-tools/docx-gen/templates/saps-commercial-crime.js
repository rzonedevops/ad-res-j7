#!/usr/bin/env node
/**
 * SAPS Commercial Crime Submission DOCX Template
 *
 * South African Police Service (Commercial Crime Unit) submission format.
 * Sections: Suspects, Criminal Offenses, Request for Action, Annexures.
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
 * @param {Array} data.tierA - [{ name, idNumber, role, proofOfForeknowledge }]
 * @param {Array} data.tierC - [{ name, role, involvement, assessment }]
 * @param {Array} data.offenseGroups - [{ act, offenses: [{ offense, evidence, status }] }]
 * @param {Array} data.requestForAction - [string]
 * @param {Array} data.annexures - [{ id, description }]
 */
function buildSapsSubmission(data) {
  const children = [];

  children.push(...reportTitleBlock({
    title: 'COMMERCIAL CRIME SUBMISSION (SAPS)',
    caseRef: data.caseRef,
    date: data.date,
    version: data.version,
    burdenOfProof: data.burdenOfProof,
  }));

  // Executive Summary
  if (data.executiveSummary) {
    children.push(h1('EXECUTIVE SUMMARY'));
    const paras = Array.isArray(data.executiveSummary) ? data.executiveSummary : [data.executiveSummary];
    paras.forEach(para => children.push(p(para)));
    children.push(horizontalRule());
  }

  // 1. Suspects
  children.push(h1('1. SUSPECTS & PERSONS OF INTEREST'));

  if (data.tierA && data.tierA.length > 0) {
    children.push(h2('TIER A: PREMEDITATED CONSPIRATORS (KNOWLEDGE PROVEN)'));
    children.push(legalTable(
      ['Name', 'ID Number', 'Role', 'Proof of Foreknowledge'],
      data.tierA.map(s => [s.name, s.idNumber || '', s.role, s.proofOfForeknowledge]),
    ));
    children.push(emptyLine());
  }

  if (data.tierC && data.tierC.length > 0) {
    children.push(h2('TIER C: PARTICIPANTS (KNOWLEDGE UNPROVEN)'));
    children.push(legalTable(
      ['Name', 'Role', 'Involvement', 'Assessment'],
      data.tierC.map(s => [s.name, s.role, s.involvement, s.assessment]),
    ));
    children.push(emptyLine());
  }

  children.push(horizontalRule());

  // 2. Criminal Offenses
  children.push(h1('2. CONSOLIDATED CRIMINAL OFFENSES'));

  if (data.offenseGroups) {
    data.offenseGroups.forEach(group => {
      children.push(h2(group.act));
      children.push(legalTable(
        ['Offense', 'Evidence', 'Status'],
        group.offenses.map(o => [o.offense, o.evidence, o.status]),
      ));
      children.push(emptyLine());
    });
  }

  children.push(horizontalRule());

  // 3. Request for Action
  if (data.requestForAction) {
    children.push(h1('3. REQUEST FOR ACTION'));
    children.push(p('We request the South African Police Service (SAPS) Commercial Crime Unit to:'));
    children.push(emptyLine());
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
      headers: { default: docHeader(data.caseRef, 'SAPS Commercial Crime Submission') },
      footers: { default: docFooter() },
      children,
    }],
  });
}

module.exports = { buildSapsSubmission };
