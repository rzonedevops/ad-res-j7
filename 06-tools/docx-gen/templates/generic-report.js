#!/usr/bin/env node
/**
 * Generic Legal Report DOCX Template
 *
 * Flexible template for any legal report, analysis, or memo.
 * Supports arbitrary titled sections with paragraphs, tables, and bullet lists.
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
  h3,
  numberedPara,
  bulletItem,
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
 * @param {string} data.title
 * @param {string} data.caseRef
 * @param {string} data.date
 * @param {string} data.version
 * @param {string} data.burdenOfProof
 * @param {Array}  data.additionalFields - [[label, value]]
 * @param {string|Array} data.executiveSummary
 * @param {Array} data.sections - [{ title, level, paragraphs, bullets, table, subsections }]
 * @param {Array} data.annexures - [{ id, description }]
 */
function buildGenericReport(data) {
  const children = [];

  children.push(...reportTitleBlock({
    title: data.title,
    caseRef: data.caseRef,
    date: data.date,
    version: data.version,
    burdenOfProof: data.burdenOfProof,
    additionalFields: data.additionalFields,
  }));

  // Executive Summary
  if (data.executiveSummary) {
    children.push(h1('EXECUTIVE SUMMARY'));
    const paras = Array.isArray(data.executiveSummary) ? data.executiveSummary : [data.executiveSummary];
    paras.forEach(para => children.push(p(para)));
    children.push(horizontalRule());
  }

  // Sections
  if (data.sections) {
    data.sections.forEach((section, i) => {
      const headingFn = section.level === 2 ? h2 : section.level === 3 ? h3 : h1;
      const prefix = section.numbered !== false ? `${i + 1}. ` : '';
      children.push(headingFn(`${prefix}${section.title}`));

      if (section.paragraphs) {
        section.paragraphs.forEach(para => {
          if (typeof para === 'string') {
            children.push(p(para));
          } else if (para.number) {
            children.push(numberedPara(para.number, para.text));
          } else {
            children.push(p(para.text || para));
          }
        });
      }

      if (section.bullets) {
        section.bullets.forEach(b => children.push(bulletItem(b)));
      }

      if (section.table) {
        children.push(legalTable(section.table.headers, section.table.rows));
      }

      if (section.subsections) {
        section.subsections.forEach(sub => {
          children.push(h2(sub.title));
          if (sub.paragraphs) {
            sub.paragraphs.forEach(para => children.push(p(para)));
          }
          if (sub.table) {
            children.push(legalTable(sub.table.headers, sub.table.rows));
          }
        });
      }

      children.push(horizontalRule());
    });
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
      headers: { default: docHeader(data.caseRef, data.title) },
      footers: { default: docFooter() },
      children,
    }],
  });
}

module.exports = { buildGenericReport };
