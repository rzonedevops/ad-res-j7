# GitHub Copilot Instructions for ad-res-j7

## Core Architecture to Keep in Mind
- Repository blends two layers: extensive legal documentation plus executable tooling that turns attention weights into legal inferences.
- Python stack (`legal_attention_engine.py`, `burden_of_proof_analyzer.py`, `lex-inference-engine/`) models legal causation with PyTorch; Node stack (`db/*.js`, `scripts/*.js`) orchestrates evidence, issues, and Postgres persistence through Drizzle.
- Hypergraph + hierarchy pipeline: `db/hypergraph-manager.js` builds evidence graphs → `db/hierarchical-issue-manager.js` organizes issues → `db/issue-consolidator.js` spots mergers → `burden-of-proof-framework.js` consumes ranked data for argument strength.
- Documentation mirrors the code paths; cross-check `HIERARCHICAL_ISSUES_SUMMARY.md`, `BURDEN_OF_PROOF_IMPLEMENTATION_COMPLETE.md`, and `COMPREHENSIVE_EVIDENCE_INDEX.md` before refactoring anything structural.

## Environment & Workflows
- Always load `.env` with `DATABASE_URL`; `db/config.js` aborts immediately if the variable is missing. Neon URLs switch drivers (`@neondatabase/serverless`) automatically—retain that detection logic.
- Database lifecycle: `npm run db:migrate` (core schema) → `npm run db:hierarchy:setup` / `db:hypergraph:setup` for optional modules → populate via matching `npm run db:*:populate` scripts.
- Validation loop lives in `package.json`: `npm test` runs the multi-suite harness in `tests/run-all-tests.js`; call targeted suites like `npm run test:hierarchical-issues`, `test:evidence-cross-reference`, or `test:burden-of-proof` when touching those subsystems.
- Evidence audits are expected after data updates: `npm run validate-evidence-completeness` (JS) or `npm run validate-evidence-completeness-py`; Python scripts assume Python ≥3.8 with torch installed.

## 🔴 Highest Priority: Hierarchical Issue Consolidation
- Mandatory structure: Legal Argument → Feature Issue → Paragraph (ranked fact grouping) → Task Issue; enforce rank (1 = strongest) and weight (0-100) at each level.
- Aim for the 3×3 rule (`1 feature ≈ 3 paragraphs ≈ 9 tasks`); if a feature needs >15 tasks split it or re-evaluate the argument scope.
- Use `db/hierarchical-issue-manager.js` APIs or CLI modes (`npm run db:hierarchy:demo`, `db:hierarchy:stats`) to create/update nodes; never add orphan tasks.
- Consolidation workflow: detect overlaps with `npm run db:xref:consolidations`, review context in `db/issue-consolidator.js report`, then link tasks via `addCrossReference` so analytics stay accurate.
- Issue titles must encode level: `[FEATURE] …`, `[PARA 1.1] … (Rank 1, Weight 100)`, `[TASK] …`; retain original GitHub issue numbers in parentheses when migrating.

## Coding Patterns & Conventions
- Node modules rely on async/await with explicit error logging—mirror the try/catch pattern used throughout `db/hierarchical-issue-manager.js` when expanding APIs.
- Python components expect dataclass-based inputs (`LegalEvent`, `Agent`, `Norm`) and return tensors + metadata dicts; keep signatures stable so downstream analyzers (e.g., `burden_of_proof_analyzer.py`) remain compatible.
- When extending attention logic, update both encoder modules and stored-weight reporting; visualization scripts read `stored_attention_weights` fields.
- Any new evidence ingestion must thread through cross-reference helpers so `case_hypergraph_summary.json` and `feature-issues-report.json` stay synchronized.

## Before You Ship Changes
- Re-run targeted npm/python commands noted above plus `npm run validate-file-paths` after touching large document sets; file path drift breaks downstream automation.
- Update supporting docs if interfaces move—`HIERARCHICAL_ISSUES_QUICKSTART.md` and `CROSS_REFERENCE_QUICKSTART.md` serve as the “source of truth” for human operators.
- If a change affects legal strategy weighting, regenerate stats (`npm run db:hierarchy:stats`, `npm run db:xref:stats`) and capture deltas for reviewers.

Have feedback or spot gaps in these instructions? Let me know which sections need clarification so we can iterate quickly.
