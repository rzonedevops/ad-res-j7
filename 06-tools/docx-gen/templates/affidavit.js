#!/usr/bin/env node
/**
 * Affidavit DOCX Template
 *
 * South African High Court answering/responding affidavit format.
 * Follows Rules of Court conventions:
 *   - Court heading with case number and parties
 *   - Oath declaration
 *   - Numbered paragraphs with sub-numbering (1.1, 1.2 …)
 *   - Signature and Commissioner of Oaths block
 */

const {
  Document,
  Packer,
  HeadingLevel,
  AlignmentType,
} = require('docx');

const {
  DOCUMENT_STYLES,
  LEGAL_NUMBERING,
  pageProperties,
} = require('../styles');

const {
  p,
  pBold,
  pCenter,
  pCenterBold,
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
  courtHeading,
  oathBlock,
  signatureBlock,
  annexureList,
} = require('../builder');

/**
 * Build an affidavit document
 *
 * @param {Object} data
 * @param {string} data.title - e.g. "ANSWERING AFFIDAVIT OF THE FIRST RESPONDENT"
 * @param {string} data.caseNo - e.g. "2025-137857"
 * @param {string} data.date
 * @param {string} data.division - e.g. "GAUTENG DIVISION, PRETORIA"
 * @param {Object} data.applicant - { name, designation }
 * @param {Array}  data.respondents - [{ name, designation }]
 * @param {string} data.deponentName
 * @param {string} data.deponentDescription - e.g. "an adult female, South African citizen …"
 * @param {Array}  data.parts - [{ title, paragraphs: [{ number, text, subs: [{ number, text }] }] }]
 * @param {Array}  data.annexures - [{ id, description }]
 * @param {string} data.signaturePlace
 * @returns {Document}
 */
function buildAffidavit(data) {
  const children = [];

  // Court heading
  children.push(...courtHeading({
    caseNo: data.caseNo,
    division: data.division,
    applicant: data.applicant,
    respondents: data.respondents,
  }));

  // Document title
  children.push(emptyLine());
  children.push(pCenterBold(data.title, { size: 32 }));
  children.push(emptyLine());

  // Oath
  children.push(...oathBlock(data.deponentName));
  children.push(emptyLine());

  // Table of contents (if parts provided)
  if (data.parts && data.parts.length > 0) {
    children.push(h1('TABLE OF CONTENTS'));
    data.parts.forEach((part, i) => {
      children.push(bulletItem([
        { text: `PART ${String.fromCharCode(65 + i)}: `, font: 'Times New Roman', size: 24, bold: true },
        { text: part.title, font: 'Times New Roman', size: 24 },
      ]));
    });
    children.push(pageBreak());
  }

  // Parts
  if (data.parts) {
    data.parts.forEach((part, i) => {
      children.push(h1(`PART ${String.fromCharCode(65 + i)}: ${part.title}`));

      if (part.paragraphs) {
        part.paragraphs.forEach(para => {
          children.push(numberedPara(para.number, para.text, { bold: para.bold }));

          if (para.subs) {
            para.subs.forEach(sub => {
              children.push(subPara(sub.number, sub.text));
            });
          }

          if (para.table) {
            children.push(legalTable(para.table.headers, para.table.rows));
            children.push(emptyLine());
          }
        });
      }

      if (part.sections) {
        part.sections.forEach(section => {
          children.push(h2(section.title));
          if (section.paragraphs) {
            section.paragraphs.forEach(para => {
              children.push(numberedPara(para.number, para.text, { bold: para.bold }));
              if (para.subs) {
                para.subs.forEach(sub => {
                  children.push(subPara(sub.number, sub.text));
                });
              }
            });
          }
        });
      }
    });
  }

  // Annexures
  if (data.annexures) {
    children.push(pageBreak());
    children.push(...annexureList(data.annexures));
  }

  // Signature
  children.push(...signatureBlock(data.deponentName, data.signaturePlace));

  const doc = new Document({
    styles: DOCUMENT_STYLES,
    numbering: { config: [LEGAL_NUMBERING] },
    sections: [{
      properties: {
        ...pageProperties(),
      },
      headers: { default: docHeader(data.caseNo, data.title) },
      footers: { default: docFooter() },
      children,
    }],
  });

  return doc;
}

module.exports = { buildAffidavit };
