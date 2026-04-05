# LEX-SIM-NN: Differentiable Legal Simulation Results

**Synced from:** [cogpy/revstream1](https://github.com/cogpy/revstream1)
**Case:** 2025-137857 — Revenue Stream Hijacking
**Date:** 2026-03-10

## Overview

This directory contains the LEX-SIM-NN differentiable legal simulation results for Case 2025-137857. The pipeline encodes evidence as 24-dimensional vectors across 6 categories and trains a neural network with Virtual Endocrine System (VES) modulation to assess burden of proof thresholds.

## Key Results

| Metric | Value |
|--------|-------|
| Civil Probability | **98.86%** (Threshold: 50%) — **MET** |
| Criminal Probability | **98.88%** (Threshold: 95%) — **MET** |
| Training Loss (final) | 0.0023 |
| Cognitive Mode | THREAT |

## Per-Filing Evidence Strength

| Filing | Score | Burden | Status |
|--------|-------|--------|--------|
| POPIA Criminal | 94.02% | 95% | Near Threshold |
| Professional Misconduct | 92.91% | 50% | **MET** |
| CIPC Complaint | 92.49% | 50% | **MET** |
| Commercial Crime | 92.00% | 95% | Near Threshold |
| NPA Tax Fraud | 91.75% | 95% | Near Threshold |
| Civil Action | 91.32% | 50% | **MET** |
| FIC Report | 89.58% | 50% | **MET** |

## Contents

| Directory | Contents |
|-----------|----------|
| [simulation/](./simulation/) | LEX-SIM-NN report, JSON results, Python pipeline script |
| [events/](./events/) | EVENT_SIM_001 (simulation), EVENT_EML_001 (forensic EML extraction) |
| [relations/](./relations/) | LEX-SIM-NN evidence attribution relation mapping |
| [timeline/](./timeline/) | Phase 7 timeline (LEX-SIM-NN Analysis) |

## Forensic EML Evidence

355 forensic EML files were extracted from the Exchange database (stored in revstream1):
- Bantjies communications (99 files)
- Rynette Farrar communications (100 files)
- Elliott Attorneys (6 files)
- ABSA/Bank details (100 files)
- Manufacturing context (50 files)

All files include SHA-256 integrity hashes and forensic JSON sidecars.

## Cross-References

- [revstream1 Main Index](https://github.com/cogpy/revstream1/blob/main/docs/index.md)
- [revstream1 Filings Index](https://github.com/cogpy/revstream1/blob/main/docs/filings/index.md)
- [revstream1 Simulation Models](https://github.com/cogpy/revstream1/blob/main/docs/simulation/index.md)
