"""
Data loaders that hydrate lenses from the existing ad-res-j7 data models.

Each loader reads JSON data models (entities, relations, events) and
constructs edges in the appropriate lens.  Loaders are designed to be
composable — call whichever ones apply, or write custom loaders for
new data sources.
"""

from __future__ import annotations
import json
import os
from pathlib import Path
from typing import Any, Dict, List, Optional, Tuple

from kronecker.sparse import EntityIndex, SparseMatrix
from kronecker.lens import (
    DictLens, LensRegistry,
    IDENTITY, FINANCIAL, TEMPORAL, LEGAL, EVIDENTIARY, BEHAVIORAL,
)


# =============================================================================
# Helpers
# =============================================================================

def _load_json(path: str) -> Any:
    with open(path) as f:
        return json.load(f)


def _safe_pairs(entities: List[str]) -> List[Tuple[str, str]]:
    """Generate directed pairs from an ordered entity list."""
    pairs = []
    for i in range(0, len(entities) - 1, 2):
        if i + 1 < len(entities):
            pairs.append((entities[i], entities[i + 1]))
    return pairs


def _all_pairs(entities: List[str]) -> List[Tuple[str, str]]:
    """Generate all unique directed pairs from a list."""
    pairs = []
    for i, a in enumerate(entities):
        for b in entities[i + 1:]:
            pairs.append((a, b))
    return pairs


# =============================================================================
# L1 — Identity lens
# =============================================================================

def load_identity_lens(
    registry: LensRegistry,
    entities_path: str,
    relations_path: str,
) -> DictLens:
    """
    Build the Identity lens from entities.json and relations.json.

    Edges represent structural links: director_of, trustee_of,
    member_of, co-occurrence in the same relation.
    """
    entities = _load_json(entities_path)
    relations = _load_json(relations_path)
    idx = registry.entity_index

    # Register all entities
    for e in entities:
        idx.get_or_add(e["id"])

    lens = registry.create_dict_lens(IDENTITY, symmetric=True)

    # Structural relations with named entities
    structural_ids = {"director_of", "trustee_of", "member_of",
                      "financial_controller_of", "sabotage_framing_link"}
    for rel in relations:
        involved = rel.get("entities_involved", [])
        if not involved:
            continue
        rid = rel["id"]

        if rid in structural_ids:
            for src, tgt in _safe_pairs(involved):
                lens.add_edge(src, tgt, weight=1.0)
        else:
            # Co-occurrence: entities appearing in the same relation
            for src, tgt in _all_pairs(involved):
                lens.add_edge(src, tgt, weight=0.5)

    return lens


# =============================================================================
# L2 — Financial lens
# =============================================================================

def load_financial_lens(
    registry: LensRegistry,
    relations_path: str,
    stock_flow_path: str = None,
) -> DictLens:
    """
    Build the Financial lens from relation models and stock-flow data.

    Edges represent money flows, account relationships, and financial fraud links.
    """
    relations = _load_json(relations_path)
    lens = registry.create_dict_lens(FINANCIAL)

    financial_keywords = {
        "revenue", "financial", "fund", "payment", "bank",
        "extraction", "profit", "stock", "invoice", "debt",
        "intercompany", "ketoni",
    }

    for rel in relations:
        title_lower = rel.get("title", "").lower()
        rid = rel["id"].lower()

        is_financial = any(kw in title_lower or kw in rid for kw in financial_keywords)
        if not is_financial:
            continue

        involved = rel.get("entities_involved", [])
        if len(involved) >= 2:
            for src, tgt in _all_pairs(involved):
                lens.add_edge(src, tgt, weight=0.8)

    # Load stock-flow model if available
    if stock_flow_path and os.path.exists(stock_flow_path):
        sf = _load_json(stock_flow_path)
        flows_data = sf.get("flows", {})
        # Handle both dict-of-flows and list-of-flows
        if isinstance(flows_data, dict):
            flows_data = flows_data.values()
        for flow in flows_data:
            if not isinstance(flow, dict):
                continue
            src = flow.get("from_stock") or flow.get("from") or flow.get("source", "")
            tgt = flow.get("to_stock") or flow.get("to") or flow.get("target", "")
            if src and tgt:
                # Connect the entities that control these stocks
                lens.add_edge(src, tgt, weight=flow.get("weight", 0.7))

    return lens


# =============================================================================
# L3 — Temporal lens
# =============================================================================

def load_temporal_lens(
    registry: LensRegistry,
    events_path: str,
    window_days: int = 14,
) -> DictLens:
    """
    Build the Temporal lens from events.json.

    Edges connect entities that co-occur in events within a time window.
    Closer events produce stronger edges.
    """
    from datetime import datetime

    events = _load_json(events_path)
    lens = registry.create_dict_lens(TEMPORAL, symmetric=True)

    # Parse dates
    dated_events = []
    for ev in events:
        date_str = ev.get("date", "")
        try:
            dt = datetime.strptime(date_str, "%Y-%m-%d")
            dated_events.append((dt, ev))
        except (ValueError, TypeError):
            continue

    dated_events.sort(key=lambda x: x[0])

    # Co-occurrence within window
    for i, (dt_i, ev_i) in enumerate(dated_events):
        ents_i = set(ev_i.get("entities_involved", []))
        if not ents_i:
            # Use event ID itself as a temporal node
            ents_i = {ev_i["id"]}

        for j in range(i + 1, len(dated_events)):
            dt_j, ev_j = dated_events[j]
            delta = (dt_j - dt_i).days
            if delta > window_days:
                break

            ents_j = set(ev_j.get("entities_involved", []))
            if not ents_j:
                ents_j = {ev_j["id"]}

            # Weight decays with temporal distance
            weight = 1.0 - (delta / (window_days + 1))
            for a in ents_i:
                for b in ents_j:
                    if a != b:
                        lens.add_edge(a, b, weight=weight)

    return lens


# =============================================================================
# L4 — Legal lens
# =============================================================================

def load_legal_lens(
    registry: LensRegistry,
    relations_path: str,
    lex_model_path: str = None,
) -> DictLens:
    """
    Build the Legal lens from relations that map to statute violations,
    fiduciary breaches, and court proceedings.
    """
    relations = _load_json(relations_path)
    lens = registry.create_dict_lens(LEGAL, symmetric=True)

    legal_keywords = {
        "fraud", "void", "contempt", "abuse", "forgery",
        "false", "interdict", "conspiracy", "capture",
        "credential", "sabotage", "identity_fraud",
        "manufacture", "backdated", "rule_30",
    }

    for rel in relations:
        title_lower = rel.get("title", "").lower()
        rid = rel["id"].lower()

        is_legal = any(kw in title_lower or kw in rid for kw in legal_keywords)
        if not is_legal:
            continue

        involved = rel.get("entities_involved", [])
        if len(involved) >= 2:
            for src, tgt in _all_pairs(involved):
                lens.add_edge(src, tgt, weight=0.9)

    # Enrich from lex transformer model if available
    if lex_model_path and os.path.exists(lex_model_path):
        lex = _load_json(lex_model_path)
        for head in lex.get("attention_heads", []):
            for link in head.get("links", []):
                src = link.get("source", "")
                tgt = link.get("target", "")
                if src and tgt:
                    lens.add_edge(src, tgt, weight=link.get("weight", 0.6))

    return lens


# =============================================================================
# L5 — Evidentiary lens
# =============================================================================

def load_evidentiary_lens(
    registry: LensRegistry,
    entities_path: str,
    relations_path: str,
    hypergraph_path: str = None,
) -> DictLens:
    """
    Build the Evidentiary lens.

    Edges connect entities that are co-referenced by the same evidence
    document or annexure.
    """
    entities = _load_json(entities_path)
    relations = _load_json(relations_path)
    lens = registry.create_dict_lens(EVIDENTIARY, symmetric=True)

    # Entities that are evidence or annexures
    evidence_ids = {
        e["id"] for e in entities
        if e.get("type") in ("Evidence", "Annexure", "Document")
    }

    # Relations represent shared evidentiary context
    evidentiary_keywords = {
        "evidence", "annexure", "attribution", "mailbox",
        "sars_flagged", "forgery",
    }

    for rel in relations:
        title_lower = rel.get("title", "").lower()
        rid = rel["id"].lower()

        is_evidentiary = any(kw in title_lower or kw in rid for kw in evidentiary_keywords)
        involved = rel.get("entities_involved", [])

        if is_evidentiary and len(involved) >= 2:
            for src, tgt in _all_pairs(involved):
                lens.add_edge(src, tgt, weight=0.85)
        elif involved:
            # Any relation with entities = shared evidence context (weaker)
            for src, tgt in _all_pairs(involved):
                if src in evidence_ids or tgt in evidence_ids:
                    lens.add_edge(src, tgt, weight=0.5)

    # Load hypergraph supports if available
    if hypergraph_path and os.path.exists(hypergraph_path):
        hg = _load_json(hypergraph_path)
        for edge in hg.get("hyperedges", []):
            if edge.get("type") in ("SUPPORTS", "EVIDENTIAL"):
                nodes = edge.get("nodes", [])
                for src, tgt in _all_pairs(nodes):
                    lens.add_edge(src, tgt, weight=0.7)

    return lens


# =============================================================================
# L6 — Behavioral lens
# =============================================================================

def load_behavioral_lens(
    registry: LensRegistry,
    relations_path: str,
    events_path: str,
) -> DictLens:
    """
    Build the Behavioral lens.

    Edges connect entities exhibiting coordinated behavior:
    conspiracy, retaliation, cover-up, coordinated actions.
    """
    relations = _load_json(relations_path)
    events = _load_json(events_path)
    lens = registry.create_dict_lens(BEHAVIORAL, symmetric=True)

    behavioral_keywords = {
        "conspiracy", "retaliation", "coordinated", "capture",
        "destruction", "sabotage", "framing", "disruption",
        "cover", "hijacking", "settlement",
    }

    for rel in relations:
        title_lower = rel.get("title", "").lower()
        rid = rel["id"].lower()

        is_behavioral = any(kw in title_lower or kw in rid for kw in behavioral_keywords)
        if not is_behavioral:
            continue

        involved = rel.get("entities_involved", [])
        if len(involved) >= 2:
            for src, tgt in _all_pairs(involved):
                lens.add_edge(src, tgt, weight=0.9)

    # Events also imply behavioral co-action
    for ev in events:
        involved = ev.get("entities_involved", [])
        if len(involved) >= 2:
            for src, tgt in _all_pairs(involved):
                lens.add_edge(src, tgt, weight=0.6)

    return lens


# =============================================================================
# Convenience: load all 6 canonical lenses
# =============================================================================

def load_all_lenses(
    data_dir: str,
    registry: LensRegistry = None,
) -> LensRegistry:
    """
    Load all 6 canonical lenses from the standard data model directory.

    Expected files:
        data_dir/entities.json
        data_dir/relations.json
        data_dir/events.json
        data_dir/stock_flow_model_*.json  (optional)
        data_dir/lex_transformer_model_*.json  (optional)
        data_dir/hypergraph_gnn_model_*.json  (optional)

    Returns a populated LensRegistry.
    """
    if registry is None:
        registry = LensRegistry()

    data = Path(data_dir)
    entities_path = str(data / "entities.json")
    relations_path = str(data / "relations.json")
    events_path = str(data / "events.json")

    # Find optional model files
    stock_flow = _find_latest(data, "stock_flow_model_*.json")
    lex_model = _find_latest(data, "lex_transformer_model_*.json")
    hypergraph = _find_latest(data, "hypergraph_gnn_model_*.json")

    load_identity_lens(registry, entities_path, relations_path)
    load_financial_lens(registry, relations_path, stock_flow)
    load_temporal_lens(registry, events_path)
    load_legal_lens(registry, relations_path, lex_model)
    load_evidentiary_lens(registry, entities_path, relations_path, hypergraph)
    load_behavioral_lens(registry, relations_path, events_path)

    return registry


def _find_latest(directory: Path, pattern: str) -> Optional[str]:
    """Find the most recently modified file matching a glob pattern."""
    matches = sorted(directory.glob(pattern), key=lambda p: p.stat().st_mtime)
    return str(matches[-1]) if matches else None
