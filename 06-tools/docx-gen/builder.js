#!/usr/bin/env node
/**
 * Shared DOCX builder helpers
 *
 * Provides reusable paragraph, table, and section builders
 * used by all legal document templates.
 */

const {
  Paragraph,
  TextRun,
  Table,
  TableRow,
  TableCell,
  WidthType,
  HeadingLevel,
  AlignmentType,
  ShadingType,
  PageBreak,
  BorderStyle,
  Header,
  Footer,
  PageNumber,
  NumberProperties,
  convertInchesToTwip,
  TabStopType,
  Tab,
} = require('docx');

const {
  COLOURS,
  FONTS,
  SIZES,
  SPACING,
  PARAGRAPH_STYLES,
  TABLE_BORDERS,
  bodyRun,
  boldRun,
  italicRun,
} = require('./styles');

// ── Text paragraphs ────────────────────────────────────────────────────────

function p(text, opts = {}) {
  const runs = typeof text === 'string'
    ? [new TextRun(bodyRun(text, opts))]
    : text.map(r => new TextRun(r));

  return new Paragraph({
    children: runs,
    ...PARAGRAPH_STYLES.body,
    ...(opts.alignment && { alignment: opts.alignment }),
    ...(opts.spacing && { spacing: opts.spacing }),
    ...(opts.indent && { indent: opts.indent }),
    ...(opts.style && { style: opts.style }),
  });
}

function pBold(text, opts = {}) {
  return p(text, { ...opts, bold: true });
}

function pCenter(text, opts = {}) {
  return p(text, { ...opts, alignment: AlignmentType.CENTER });
}

function pCenterBold(text, opts = {}) {
  return p(text, { ...opts, alignment: AlignmentType.CENTER, bold: true });
}

function heading(text, level = HeadingLevel.HEADING_1, opts = {}) {
  return new Paragraph({
    children: [new TextRun({
      text,
      font: FONTS.HEADING,
      size: level === HeadingLevel.HEADING_1 ? SIZES.H1
        : level === HeadingLevel.HEADING_2 ? SIZES.H2
        : level === HeadingLevel.HEADING_3 ? SIZES.H3
        : SIZES.H4,
      bold: true,
      color: opts.color || COLOURS.ACCENT_BLUE,
    })],
    heading: level,
    spacing: { before: SPACING.HEADING_BEFORE, after: SPACING.HEADING_AFTER },
    alignment: opts.alignment || AlignmentType.LEFT,
  });
}

function h1(text, opts = {}) { return heading(text, HeadingLevel.HEADING_1, opts); }
function h2(text, opts = {}) { return heading(text, HeadingLevel.HEADING_2, opts); }
function h3(text, opts = {}) { return heading(text, HeadingLevel.HEADING_3, opts); }

function numberedPara(number, text, opts = {}) {
  const runs = [];
  runs.push(new TextRun(boldRun(`${number}  `)));
  if (typeof text === 'string') {
    runs.push(new TextRun(bodyRun(text, opts)));
  } else {
    text.forEach(r => runs.push(new TextRun(r)));
  }
  return new Paragraph({
    children: runs,
    ...PARAGRAPH_STYLES.numberedParagraph,
  });
}

function subPara(number, text, opts = {}) {
  const runs = [];
  runs.push(new TextRun(bodyRun(`${number}  `, { bold: false })));
  if (typeof text === 'string') {
    runs.push(new TextRun(bodyRun(text, opts)));
  } else {
    text.forEach(r => runs.push(new TextRun(r)));
  }
  return new Paragraph({
    children: runs,
    spacing: { after: SPACING.BODY_AFTER, line: SPACING.BODY_LINE },
    alignment: AlignmentType.JUSTIFIED,
    indent: { left: convertInchesToTwip(1.0), hanging: convertInchesToTwip(0.5) },
  });
}

function bulletItem(text, opts = {}) {
  const runs = typeof text === 'string'
    ? [new TextRun(bodyRun(text, opts))]
    : text.map(r => new TextRun(r));

  return new Paragraph({
    children: runs,
    bullet: { level: opts.level || 0 },
    spacing: { after: 80, line: SPACING.BODY_LINE },
    alignment: AlignmentType.JUSTIFIED,
  });
}

function emptyLine() {
  return new Paragraph({ children: [], spacing: { after: SPACING.BODY_AFTER } });
}

function pageBreak() {
  return new Paragraph({ children: [new PageBreak()] });
}

function horizontalRule() {
  return new Paragraph({
    children: [],
    border: {
      bottom: { style: BorderStyle.SINGLE, size: 6, color: COLOURS.LIGHT_GREY, space: 1 },
    },
    spacing: { before: 120, after: 120 },
  });
}

// ── Tables ──────────────────────────────────────────────────────────────────

function tableCell(text, opts = {}) {
  const runs = typeof text === 'string'
    ? [new TextRun({
        text,
        font: FONTS.BODY,
        size: opts.headerRow ? SIZES.SMALL : SIZES.BODY,
        bold: opts.bold || opts.headerRow || false,
        color: opts.headerRow ? COLOURS.WHITE : (opts.color || COLOURS.BLACK),
      })]
    : (Array.isArray(text) ? text.map(r => new TextRun(r)) : [new TextRun(text)]);

  return new TableCell({
    children: [new Paragraph({
      children: runs,
      ...PARAGRAPH_STYLES.tableCell,
      alignment: opts.alignment || AlignmentType.LEFT,
    })],
    width: opts.width ? { size: opts.width, type: WidthType.PERCENTAGE } : undefined,
    shading: opts.headerRow
      ? { type: ShadingType.SOLID, color: COLOURS.TABLE_HEADER_BG }
      : (opts.shading ? { type: ShadingType.SOLID, color: opts.shading } : undefined),
    verticalAlign: opts.verticalAlign || 'center',
    margins: {
      top: 40,
      bottom: 40,
      left: 80,
      right: 80,
    },
  });
}

function headerRow(cells, opts = {}) {
  return new TableRow({
    children: cells.map(cell =>
      typeof cell === 'string'
        ? tableCell(cell, { headerRow: true, ...opts })
        : tableCell(cell.text, { headerRow: true, ...cell, ...opts })
    ),
    tableHeader: true,
  });
}

function dataRow(cells, opts = {}) {
  return new TableRow({
    children: cells.map(cell =>
      typeof cell === 'string'
        ? tableCell(cell, opts)
        : tableCell(cell.text || cell, { ...opts, ...(typeof cell === 'object' ? cell : {}) })
    ),
  });
}

function alternatingRow(cells, rowIndex) {
  const shading = rowIndex % 2 === 1 ? COLOURS.TABLE_ALT_ROW : undefined;
  return dataRow(cells, { shading });
}

function legalTable(headers, rows, opts = {}) {
  const tableRows = [headerRow(headers)];
  rows.forEach((row, i) => {
    tableRows.push(alternatingRow(row, i));
  });

  return new Table({
    rows: tableRows,
    width: { size: 100, type: WidthType.PERCENTAGE },
    borders: TABLE_BORDERS,
    ...(opts.columnWidths && {
      columnWidths: opts.columnWidths.map(w => convertInchesToTwip(w)),
    }),
  });
}

// ── Header / Footer ────────────────────────────────────────────────────────

function docHeader(caseRef, docTitle) {
  return new Header({
    children: [
      new Paragraph({
        children: [
          new TextRun({ text: `${caseRef}`, font: FONTS.BODY, size: SIZES.FOOTNOTE, color: COLOURS.MID_GREY }),
          new TextRun({ text: `  |  ${docTitle}`, font: FONTS.BODY, size: SIZES.FOOTNOTE, color: COLOURS.MID_GREY }),
        ],
        alignment: AlignmentType.RIGHT,
        border: {
          bottom: { style: BorderStyle.SINGLE, size: 1, color: COLOURS.LIGHT_GREY, space: 4 },
        },
      }),
    ],
  });
}

function docFooter() {
  return new Footer({
    children: [
      new Paragraph({
        children: [
          new TextRun({ text: 'Page ', font: FONTS.BODY, size: SIZES.FOOTNOTE, color: COLOURS.MID_GREY }),
          new TextRun({ children: [PageNumber.CURRENT], font: FONTS.BODY, size: SIZES.FOOTNOTE, color: COLOURS.MID_GREY }),
          new TextRun({ text: ' of ', font: FONTS.BODY, size: SIZES.FOOTNOTE, color: COLOURS.MID_GREY }),
          new TextRun({ children: [PageNumber.TOTAL_PAGES], font: FONTS.BODY, size: SIZES.FOOTNOTE, color: COLOURS.MID_GREY }),
        ],
        alignment: AlignmentType.CENTER,
        border: {
          top: { style: BorderStyle.SINGLE, size: 1, color: COLOURS.LIGHT_GREY, space: 4 },
        },
      }),
    ],
  });
}

// ── Court heading block (affidavits) ────────────────────────────────────────

function courtHeading({ court, division, caseNo, applicant, respondents }) {
  const children = [];

  children.push(pCenterBold('IN THE HIGH COURT OF SOUTH AFRICA', { size: SIZES.H2 }));
  children.push(pCenterBold(`${division || 'GAUTENG DIVISION, PRETORIA'}`, { size: SIZES.H3 }));
  children.push(emptyLine());
  children.push(pCenterBold(`CASE NO: ${caseNo}`, { size: SIZES.H3 }));
  children.push(emptyLine());

  children.push(p('In the matter between:', { alignment: AlignmentType.LEFT }));
  children.push(emptyLine());

  // Applicant
  children.push(new Paragraph({
    children: [
      new TextRun(boldRun(applicant.name.toUpperCase())),
      new TextRun(bodyRun(`  —  ${applicant.designation || 'Applicant'}`)),
    ],
    alignment: AlignmentType.LEFT,
    spacing: { after: 120 },
  }));

  children.push(p('and', { alignment: AlignmentType.LEFT }));
  children.push(emptyLine());

  // Respondents
  respondents.forEach((r, i) => {
    children.push(new Paragraph({
      children: [
        new TextRun(boldRun(r.name.toUpperCase())),
        new TextRun(bodyRun(`  —  ${r.designation || `${ordinal(i + 1)} Respondent`}`)),
      ],
      alignment: AlignmentType.LEFT,
      spacing: { after: 80 },
    }));
  });

  children.push(horizontalRule());
  return children;
}

function ordinal(n) {
  const s = ['th', 'st', 'nd', 'rd'];
  const v = n % 100;
  return n + (s[(v - 20) % 10] || s[v] || s[0]);
}

// ── Complaint / Report title block ──────────────────────────────────────────

function reportTitleBlock({ title, caseRef, date, version, burdenOfProof, additionalFields }) {
  const children = [];
  children.push(pCenterBold(title, { size: SIZES.TITLE, color: COLOURS.ACCENT_BLUE }));
  children.push(emptyLine());

  const fields = [
    ['Case Reference', caseRef],
    ['Date', date],
    ['Version', version],
    ...(burdenOfProof ? [['Burden of Proof Standard', burdenOfProof]] : []),
    ...(additionalFields || []),
  ];

  fields.forEach(([label, value]) => {
    children.push(new Paragraph({
      children: [
        new TextRun(boldRun(`${label}: `)),
        new TextRun(bodyRun(value)),
      ],
      alignment: AlignmentType.LEFT,
      spacing: { after: 60 },
    }));
  });

  children.push(horizontalRule());
  return children;
}

// ── Status indicator helpers ────────────────────────────────────────────────

function statusRun(status) {
  const proven = /proven|conclusive|exceeded|confirmed/i.test(status);
  return {
    text: status,
    font: FONTS.BODY,
    size: SIZES.BODY,
    bold: true,
    color: proven ? COLOURS.STATUS_GREEN : COLOURS.STATUS_RED,
  };
}

// ── Oath / Deponent block ───────────────────────────────────────────────────

function oathBlock(deponentName) {
  return [
    horizontalRule(),
    emptyLine(),
    p('I, the undersigned,', { alignment: AlignmentType.LEFT }),
    emptyLine(),
    pCenterBold(deponentName.toUpperCase(), { size: SIZES.H2 }),
    emptyLine(),
    p('do hereby make oath and state that:', { alignment: AlignmentType.LEFT }),
    horizontalRule(),
  ];
}

function signatureBlock(deponentName, place) {
  return [
    emptyLine(),
    emptyLine(),
    horizontalRule(),
    new Paragraph({
      children: [
        new TextRun(bodyRun('________________________________')),
      ],
      alignment: AlignmentType.LEFT,
      spacing: { after: 60 },
    }),
    new Paragraph({
      children: [
        new TextRun(boldRun(deponentName.toUpperCase())),
      ],
      alignment: AlignmentType.LEFT,
      spacing: { after: 60 },
    }),
    p(`Signed and sworn to before me at ${place || '____________'} on this ______ day of ____________ 2026.`),
    emptyLine(),
    new Paragraph({
      children: [new TextRun(bodyRun('________________________________'))],
      alignment: AlignmentType.LEFT,
      spacing: { after: 60 },
    }),
    p('COMMISSIONER OF OATHS'),
    p('Full names: ________________________________'),
    p('Address: ________________________________'),
    p('Designation: ________________________________'),
  ];
}

// ── Annexure list ───────────────────────────────────────────────────────────

function annexureList(annexures) {
  const children = [h2('ANNEXURES')];
  annexures.forEach(a => {
    children.push(new Paragraph({
      children: [
        new TextRun(boldRun(`${a.id}: `)),
        new TextRun(bodyRun(a.description)),
      ],
      spacing: { after: 80, line: SPACING.BODY_LINE },
      indent: { left: convertInchesToTwip(0.5) },
    }));
  });
  return children;
}

module.exports = {
  p,
  pBold,
  pCenter,
  pCenterBold,
  heading,
  h1,
  h2,
  h3,
  numberedPara,
  subPara,
  bulletItem,
  emptyLine,
  pageBreak,
  horizontalRule,
  tableCell,
  headerRow,
  dataRow,
  alternatingRow,
  legalTable,
  docHeader,
  docFooter,
  courtHeading,
  reportTitleBlock,
  statusRun,
  oathBlock,
  signatureBlock,
  annexureList,
};
