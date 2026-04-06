#!/usr/bin/env node
/**
 * Legal Document Style Definitions
 *
 * Centralised style constants for all DOCX templates.
 * South African High Court conventions:
 *   - Times New Roman 12pt body, 14pt headings
 *   - 1.5 line spacing for affidavits
 *   - Numbered paragraphs
 *   - A4 page size with 2.54 cm margins
 */

const {
  AlignmentType,
  HeadingLevel,
  TabStopPosition,
  TabStopType,
  UnderlineType,
  convertInchesToTwip,
  convertMillimetersToTwip,
  LevelFormat,
  BorderStyle,
} = require('docx');

// ── Colour palette ──────────────────────────────────────────────────────────
const COLOURS = {
  BLACK: '000000',
  DARK_GREY: '333333',
  MID_GREY: '666666',
  LIGHT_GREY: 'CCCCCC',
  WHITE: 'FFFFFF',
  ACCENT_BLUE: '1F4E79',
  ACCENT_RED: 'C00000',
  STATUS_GREEN: '2E7D32',
  STATUS_RED: 'C62828',
  TABLE_HEADER_BG: '1F4E79',
  TABLE_ALT_ROW: 'F2F2F2',
};

// ── Font families ───────────────────────────────────────────────────────────
const FONTS = {
  BODY: 'Times New Roman',
  HEADING: 'Times New Roman',
  MONO: 'Courier New',
};

// ── Font sizes (half-points) ────────────────────────────────────────────────
const SIZES = {
  BODY: 24,         // 12pt
  SMALL: 20,        // 10pt
  FOOTNOTE: 18,     // 9pt
  H1: 32,           // 16pt
  H2: 28,           // 14pt
  H3: 26,           // 13pt
  H4: 24,           // 12pt
  TITLE: 36,        // 18pt
  SUBTITLE: 28,     // 14pt
};

// ── Spacing (twips – 1/20 pt) ───────────────────────────────────────────────
const SPACING = {
  BODY_AFTER: 120,
  BODY_LINE: 360,       // 1.5 line spacing (240 = single)
  HEADING_BEFORE: 240,
  HEADING_AFTER: 120,
  PARAGRAPH_AFTER: 200,
  DOUBLE_LINE: 480,
};

// ── Page geometry (A4) ──────────────────────────────────────────────────────
const PAGE = {
  WIDTH: convertMillimetersToTwip(210),
  HEIGHT: convertMillimetersToTwip(297),
  MARGIN_TOP: convertMillimetersToTwip(25.4),
  MARGIN_BOTTOM: convertMillimetersToTwip(25.4),
  MARGIN_LEFT: convertMillimetersToTwip(25.4),
  MARGIN_RIGHT: convertMillimetersToTwip(25.4),
};

// ── Reusable text run options ───────────────────────────────────────────────
function bodyRun(text, opts = {}) {
  return {
    text,
    font: opts.font || FONTS.BODY,
    size: opts.size || SIZES.BODY,
    bold: opts.bold || false,
    italics: opts.italics || false,
    underline: opts.underline ? { type: UnderlineType.SINGLE } : undefined,
    color: opts.color || COLOURS.BLACK,
  };
}

function boldRun(text, opts = {}) {
  return bodyRun(text, { ...opts, bold: true });
}

function italicRun(text, opts = {}) {
  return bodyRun(text, { ...opts, italics: true });
}

// ── Paragraph presets ───────────────────────────────────────────────────────
const PARAGRAPH_STYLES = {
  body: {
    spacing: { after: SPACING.BODY_AFTER, line: SPACING.BODY_LINE },
    alignment: AlignmentType.JUSTIFIED,
  },
  centered: {
    spacing: { after: SPACING.BODY_AFTER, line: SPACING.BODY_LINE },
    alignment: AlignmentType.CENTER,
  },
  heading1: {
    spacing: { before: SPACING.HEADING_BEFORE, after: SPACING.HEADING_AFTER },
    alignment: AlignmentType.LEFT,
  },
  heading2: {
    spacing: { before: SPACING.HEADING_BEFORE, after: SPACING.HEADING_AFTER },
    alignment: AlignmentType.LEFT,
  },
  numberedParagraph: {
    spacing: { after: SPACING.PARAGRAPH_AFTER, line: SPACING.BODY_LINE },
    alignment: AlignmentType.JUSTIFIED,
    indent: { left: convertInchesToTwip(0.5), hanging: convertInchesToTwip(0.5) },
  },
  tableCell: {
    spacing: { after: 60 },
    alignment: AlignmentType.LEFT,
  },
};

// ── Table border preset ─────────────────────────────────────────────────────
const TABLE_BORDERS = {
  top: { style: BorderStyle.SINGLE, size: 1, color: COLOURS.LIGHT_GREY },
  bottom: { style: BorderStyle.SINGLE, size: 1, color: COLOURS.LIGHT_GREY },
  left: { style: BorderStyle.SINGLE, size: 1, color: COLOURS.LIGHT_GREY },
  right: { style: BorderStyle.SINGLE, size: 1, color: COLOURS.LIGHT_GREY },
  insideHorizontal: { style: BorderStyle.SINGLE, size: 1, color: COLOURS.LIGHT_GREY },
  insideVertical: { style: BorderStyle.SINGLE, size: 1, color: COLOURS.LIGHT_GREY },
};

// ── Document-level numbering definition ─────────────────────────────────────
const LEGAL_NUMBERING = {
  reference: 'legal-numbering',
  levels: [
    {
      level: 0,
      format: LevelFormat.DECIMAL,
      text: '%1.',
      alignment: AlignmentType.LEFT,
      style: { paragraph: { indent: { left: convertInchesToTwip(0.5), hanging: convertInchesToTwip(0.5) } } },
    },
    {
      level: 1,
      format: LevelFormat.DECIMAL,
      text: '%1.%2',
      alignment: AlignmentType.LEFT,
      style: { paragraph: { indent: { left: convertInchesToTwip(1.0), hanging: convertInchesToTwip(0.5) } } },
    },
    {
      level: 2,
      format: LevelFormat.DECIMAL,
      text: '%1.%2.%3',
      alignment: AlignmentType.LEFT,
      style: { paragraph: { indent: { left: convertInchesToTwip(1.5), hanging: convertInchesToTwip(0.5) } } },
    },
  ],
};

// ── Document-level custom styles ────────────────────────────────────────────
const DOCUMENT_STYLES = {
  default: {
    document: {
      run: {
        font: FONTS.BODY,
        size: SIZES.BODY,
        color: COLOURS.BLACK,
      },
      paragraph: {
        spacing: { after: SPACING.BODY_AFTER, line: SPACING.BODY_LINE },
        alignment: AlignmentType.JUSTIFIED,
      },
    },
  },
  paragraphStyles: [
    {
      id: 'CourtTitle',
      name: 'Court Title',
      basedOn: 'Normal',
      next: 'Normal',
      run: { font: FONTS.HEADING, size: SIZES.TITLE, bold: true, color: COLOURS.BLACK },
      paragraph: { spacing: { after: 60 }, alignment: AlignmentType.CENTER },
    },
    {
      id: 'CourtSubtitle',
      name: 'Court Subtitle',
      basedOn: 'Normal',
      next: 'Normal',
      run: { font: FONTS.HEADING, size: SIZES.SUBTITLE, bold: true, color: COLOURS.BLACK },
      paragraph: { spacing: { after: 60 }, alignment: AlignmentType.CENTER },
    },
    {
      id: 'LegalBody',
      name: 'Legal Body',
      basedOn: 'Normal',
      next: 'Normal',
      run: { font: FONTS.BODY, size: SIZES.BODY },
      paragraph: {
        spacing: { after: SPACING.BODY_AFTER, line: SPACING.BODY_LINE },
        alignment: AlignmentType.JUSTIFIED,
      },
    },
    {
      id: 'CaseReference',
      name: 'Case Reference',
      basedOn: 'Normal',
      next: 'Normal',
      run: { font: FONTS.BODY, size: SIZES.BODY, bold: true, color: COLOURS.ACCENT_BLUE },
      paragraph: { spacing: { after: 60 }, alignment: AlignmentType.LEFT },
    },
    {
      id: 'StatusProven',
      name: 'Status Proven',
      basedOn: 'Normal',
      next: 'Normal',
      run: { font: FONTS.BODY, size: SIZES.BODY, bold: true, color: COLOURS.STATUS_GREEN },
      paragraph: { spacing: { after: 60 } },
    },
    {
      id: 'StatusFailed',
      name: 'Status Failed',
      basedOn: 'Normal',
      next: 'Normal',
      run: { font: FONTS.BODY, size: SIZES.BODY, bold: true, color: COLOURS.STATUS_RED },
      paragraph: { spacing: { after: 60 } },
    },
  ],
};

// ── Page properties shared across all templates ─────────────────────────────
function pageProperties(opts = {}) {
  return {
    page: {
      size: { width: PAGE.WIDTH, height: PAGE.HEIGHT, orientation: opts.landscape ? 'landscape' : undefined },
      margin: {
        top: PAGE.MARGIN_TOP,
        bottom: PAGE.MARGIN_BOTTOM,
        left: PAGE.MARGIN_LEFT,
        right: PAGE.MARGIN_RIGHT,
      },
    },
  };
}

module.exports = {
  COLOURS,
  FONTS,
  SIZES,
  SPACING,
  PAGE,
  PARAGRAPH_STYLES,
  TABLE_BORDERS,
  LEGAL_NUMBERING,
  DOCUMENT_STYLES,
  bodyRun,
  boldRun,
  italicRun,
  pageProperties,
};
