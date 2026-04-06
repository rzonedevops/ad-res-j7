"""
Text-based visualization for Kronecker product results.

Generates:
    - Corroboration heatmaps (ASCII)
    - Entity profile cards
    - Cluster summaries
    - Gap analysis tables
"""

from __future__ import annotations
from typing import Dict, List, Optional
from io import StringIO

from kronecker.engine import KroneckerEngine, ProductEntry
from kronecker.coincidence import CoincidenceDetector, Coincidence, EntityScore


# =============================================================================
# Heatmap
# =============================================================================

def corroboration_heatmap(engine: KroneckerEngine, top_n: int = 15) -> str:
    """
    ASCII heatmap of entity × lens activation.

    Rows = top entities (by total weight), columns = lenses.
    Cell = sum of outgoing weights in that lens for that entity.
    """
    detector = CoincidenceDetector(engine)
    scores = detector.score_entities(min_depth=1)[:top_n]
    lenses = engine.registry.lenses
    lens_names = [l.name.split("_", 1)[-1][:8] for l in lenses]

    if not scores:
        return "(no data)\n"

    buf = StringIO()

    # Header
    name_width = max(len(s.entity) for s in scores)
    name_width = max(name_width, 8)
    col_width = max(len(n) for n in lens_names)
    col_width = max(col_width, 5)

    buf.write(" " * (name_width + 2))
    for n in lens_names:
        buf.write(f"{n:>{col_width}} ")
    buf.write(" TOTAL\n")
    buf.write("-" * (name_width + 2 + (col_width + 1) * len(lenses) + 6) + "\n")

    # Rows
    blocks = " ░▒▓█"
    for s in scores:
        buf.write(f"{s.entity:<{name_width}}  ")
        row_total = 0.0
        for lens in lenses:
            profile = engine.entity_profile(s.entity)
            lens_data = profile.get(lens.name, {})
            val = sum(lens_data.values())
            row_total += val

            # Quantize to block character
            if val == 0:
                block = blocks[0]
            elif val < 0.5:
                block = blocks[1]
            elif val < 1.5:
                block = blocks[2]
            elif val < 3.0:
                block = blocks[3]
            else:
                block = blocks[4]

            buf.write(f"{block:>{col_width}} ")
        buf.write(f" {row_total:5.1f}\n")

    buf.write("\nLegend: ' '=0  ░<0.5  ▒<1.5  ▓<3.0  █>=3.0\n")
    return buf.getvalue()


# =============================================================================
# Entity profile card
# =============================================================================

def entity_card(engine: KroneckerEngine, entity: str) -> str:
    """Detailed profile card for a single entity."""
    buf = StringIO()
    profile = engine.entity_profile(entity)
    idx = engine.registry.entity_index

    buf.write(f"{'=' * 60}\n")
    buf.write(f"  ENTITY: {entity}\n")
    buf.write(f"{'=' * 60}\n\n")

    if not profile:
        buf.write("  (no connections found across any lens)\n")
        return buf.getvalue()

    total_connections = 0
    for lens_name, connections in sorted(profile.items()):
        short = lens_name.split("_", 1)[-1] if "_" in lens_name else lens_name
        buf.write(f"  [{short}]\n")
        for target, weight in sorted(connections.items(), key=lambda x: -x[1]):
            bar_len = int(weight * 20)
            bar = "█" * bar_len + "░" * (20 - bar_len)
            buf.write(f"    → {target:<25} {bar} {weight:.3f}\n")
            total_connections += 1
        buf.write("\n")

    buf.write(f"  Total connections: {total_connections}\n")
    buf.write(f"  Active lenses: {len(profile)}/{engine.registry.n_lenses}\n")
    return buf.getvalue()


# =============================================================================
# Coincidence table
# =============================================================================

def coincidence_table(
    detector: CoincidenceDetector,
    min_depth: int = 2,
    top_n: int = 20,
) -> str:
    """Tabular summary of top coincidences."""
    coincidences = detector.detect(min_depth)[:top_n]
    if not coincidences:
        return "(no coincidences at depth >= {min_depth})\n"

    buf = StringIO()
    n_lenses = detector.engine.registry.n_lenses
    lens_short = [
        n.split("_", 1)[-1][:3].upper()
        for n in detector.engine.registry.names
    ]

    # Header
    buf.write(f"{'SOURCE':<20} {'TARGET':<20} {'D':>2} {'STR':>6}  ")
    for s in lens_short:
        buf.write(f"{s:>3} ")
    buf.write("\n")
    buf.write("-" * (20 + 20 + 4 + 7 + 2 + 4 * len(lens_short)) + "\n")

    for c in coincidences:
        buf.write(f"{c.source:<20} {c.target:<20} {c.depth:>2} {c.strength:>6.3f}  ")
        for name in detector.engine.registry.names:
            if name in c.lens_weights:
                buf.write(f"  ● ")
            else:
                buf.write(f"  · ")
        buf.write("\n")

    buf.write(f"\nShowing top {len(coincidences)} of "
              f"{len(detector.detect(min_depth))} coincidences "
              f"(depth >= {min_depth}, max = {n_lenses})\n")
    return buf.getvalue()


# =============================================================================
# Gap analysis
# =============================================================================

def gap_table(detector: CoincidenceDetector, source: str, target: str) -> str:
    """Show which lenses have evidence for a specific entity pair."""
    gaps = detector.gap_analysis(source, target)
    buf = StringIO()

    buf.write(f"Gap Analysis: {source} → {target}\n")
    buf.write("-" * 50 + "\n")

    for lens_name, weight in gaps.items():
        short = lens_name.split("_", 1)[-1] if "_" in lens_name else lens_name
        if weight is not None:
            buf.write(f"  ● {short:<20} weight={weight:.3f}\n")
        else:
            buf.write(f"  ○ {short:<20} (GAP — no evidence)\n")

    active = sum(1 for v in gaps.values() if v is not None)
    buf.write(f"\nCorroboration: {active}/{len(gaps)} lenses\n")
    return buf.getvalue()


# =============================================================================
# Full report
# =============================================================================

def full_report(engine: KroneckerEngine, top_n: int = 15) -> str:
    """Generate a complete text report."""
    detector = CoincidenceDetector(engine)
    summary = engine.summary()
    buf = StringIO()

    buf.write("╔══════════════════════════════════════════════════════════╗\n")
    buf.write("║          KRONECKER PRODUCT ANALYSIS  ⊗⁶                ║\n")
    buf.write("╚══════════════════════════════════════════════════════════╝\n\n")

    buf.write(f"  Lenses:              {summary['n_lenses']}\n")
    buf.write(f"  Entities:            {summary['entity_count']}\n")
    buf.write(f"  Total pairs:         {summary['total_entity_pairs']}\n")
    buf.write(f"  Fully corroborated:  {summary['fully_corroborated']}\n")
    buf.write(f"\n  Corroboration depth distribution:\n")
    for depth, count in sorted(summary["by_corroboration_depth"].items()):
        bar = "█" * min(count, 40)
        buf.write(f"    depth {depth}: {count:>4}  {bar}\n")

    buf.write(f"\n{'─' * 60}\n")
    buf.write("CORROBORATION HEATMAP\n")
    buf.write(f"{'─' * 60}\n\n")
    buf.write(corroboration_heatmap(engine, top_n))

    buf.write(f"\n{'─' * 60}\n")
    buf.write("TOP COINCIDENCES\n")
    buf.write(f"{'─' * 60}\n\n")
    buf.write(coincidence_table(detector, min_depth=2, top_n=top_n))

    # Clusters
    clusters = detector.find_clusters(min_depth=2)
    if clusters:
        buf.write(f"\n{'─' * 60}\n")
        buf.write(f"CLUSTERS ({len(clusters)} found)\n")
        buf.write(f"{'─' * 60}\n\n")
        for i, cluster in enumerate(clusters[:10]):
            buf.write(f"  Cluster {i + 1} ({len(cluster)} entities): "
                       f"{', '.join(sorted(cluster)[:8])}")
            if len(cluster) > 8:
                buf.write(f" ... +{len(cluster) - 8} more")
            buf.write("\n")

    return buf.getvalue()
