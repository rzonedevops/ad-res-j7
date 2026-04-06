#!/usr/bin/env node
/**
 * Template Registry
 *
 * Central export for all DOCX legal templates.
 */

const { buildAffidavit } = require('./affidavit');
const { buildCipcComplaint } = require('./cipc-complaint');
const { buildSapsSubmission } = require('./saps-commercial-crime');
const { buildNpaTaxFraudReport } = require('./npa-tax-fraud');
const { buildFicReport } = require('./fic-report');
const { buildPopiaComplaint } = require('./popia-complaint');
const { buildProfessionalMisconductComplaint } = require('./professional-misconduct');
const { buildGenericReport } = require('./generic-report');

const TEMPLATES = {
  affidavit: {
    build: buildAffidavit,
    label: 'High Court Affidavit',
    description: 'SA High Court answering/responding affidavit with numbered paragraphs, oath block, and commissioner signature.',
  },
  cipc: {
    build: buildCipcComplaint,
    label: 'CIPC Companies Act Complaint',
    description: 'Companies and Intellectual Property Commission complaint for statutory violations.',
  },
  saps: {
    build: buildSapsSubmission,
    label: 'SAPS Commercial Crime Submission',
    description: 'South African Police Service commercial crime unit submission with offense tables.',
  },
  npa: {
    build: buildNpaTaxFraudReport,
    label: 'NPA / SARS Tax Fraud Report',
    description: 'National Prosecuting Authority tax fraud report with financial impact analysis.',
  },
  sars: {
    build: buildNpaTaxFraudReport,
    label: 'SARS Tax Fraud Report',
    description: 'Alias for NPA template — same format used for direct SARS submissions.',
  },
  fic: {
    build: buildFicReport,
    label: 'FIC Suspicious Transaction Report',
    description: 'Financial Intelligence Centre suspicious transaction report with money laundering indicators.',
  },
  popia: {
    build: buildPopiaComplaint,
    label: 'POPIA Complaint',
    description: 'Information Regulator complaint for Protection of Personal Information Act violations.',
  },
  misconduct: {
    build: buildProfessionalMisconductComplaint,
    label: 'Professional Misconduct Complaint',
    description: 'SAICA/SAIPA professional misconduct complaint against chartered accountants.',
  },
  report: {
    build: buildGenericReport,
    label: 'Generic Legal Report',
    description: 'Flexible template for memos, analyses, and ad-hoc legal reports.',
  },
};

module.exports = { TEMPLATES };
