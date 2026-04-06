"""
Coincidence detection across lenses.

A "coincidence" is an entity pair (or cluster) that lights up across
multiple independent analytical dimensions.  The more lenses that
agree, the stronger the corroboration.

This module provides:
    - Threshold-based detection (k-of-N coincidences)
    - Entity-centric profiling (which lenses activate for a given actor)
    - Cluster detection (groups of entities that co-occur across lenses)
    - Scoring and ranking
"""

from __future__ import annotations
from typing import Dict, List, Optional, Set, Tuple
from dataclasses import dataclass, field
from collections import defaultdict

from kronecker.sparse import EntityIndex, SparseMatrix, Scalar
from kronecker.engine import KroneckerEngine, ProductEntry


@dataclass
class Coincidence:
    """A detected cross-lens coincidence."""
    source: str
    target: str
    depth: int                          # number of lenses
    combined_weight: float
    lens_weights: Dict[str, float]      # {lens_name: weight}
    missing_lenses: List[str] = field(default_factory=list)

    @property
    def strength(self) -> float:
        """Normalized strength: depth / total possible * combined weight."""
        total = self.depth + len(self.missing_lenses)
        if total == 0:
            return 0.0
        return (self.depth / total) * self.combined_weight


@dataclass
class EntityScore:
    """Aggregate coincidence score for a single entity."""
    entity: str
    total_coincidences: int = 0
    max_depth: int = 0
    total_weight: float = 0.0
    per_lens_count: Dict[str, int] = field(default_factory=dict)
    connected_entities: Set[str] = field(default_factory=set)


class CoincidenceDetector:
    """
    Detects and ranks cross-lens coincidences.
    """

    def __init__(self, engine: KroneckerEngine):
        self.engine = engine

    # --------------------------------------------------------------------- #
    # Detection
    # --------------------------------------------------------------------- #

    def detect(self, min_depth: int = 2) -> List[Coincidence]:
        """
        Find all entity pairs corroborated across >= min_depth lenses.

        Returns coincidences sorted by depth (desc), then combined weight (desc).
        """
        all_lens_names = set(self.engine.registry.names)
        product = self.engine.compute_product(min_lenses=min_depth)

        coincidences = []
        for (r, c), entry in product.items():
            active = set(entry.per_lens.keys())
            missing = sorted(all_lens_names - active)

            coincidences.append(Coincidence(
                source=entry.entities[0],
                target=entry.entities[1],
                depth=entry.n_lenses,
                combined_weight=entry.combined,
                lens_weights=dict(entry.per_lens),
                missing_lenses=missing,
            ))

        coincidences.sort(key=lambda c: (c.depth, c.combined_weight), reverse=True)
        return coincidences

    def detect_full(self) -> List[Coincidence]:
        """Only fully corroborated coincidences (all lenses)."""
        return self.detect(min_depth=self.engine.registry.n_lenses)

    # --------------------------------------------------------------------- #
    # Entity scoring
    # --------------------------------------------------------------------- #

    def score_entities(self, min_depth: int = 2) -> List[EntityScore]:
        """
        Aggregate coincidence data per entity.

        Returns entities sorted by total_weight descending.
        """
        coincidences = self.detect(min_depth)
        scores: Dict[str, EntityScore] = {}

        for c in coincidences:
            for entity in (c.source, c.target):
                if entity not in scores:
                    scores[entity] = EntityScore(entity=entity)
                s = scores[entity]
                s.total_coincidences += 1
                s.max_depth = max(s.max_depth, c.depth)
                s.total_weight += c.combined_weight
                for lens_name in c.lens_weights:
                    s.per_lens_count[lens_name] = s.per_lens_count.get(lens_name, 0) + 1

                other = c.target if entity == c.source else c.source
                s.connected_entities.add(other)

        result = sorted(scores.values(), key=lambda s: s.total_weight, reverse=True)
        return result

    # --------------------------------------------------------------------- #
    # Cluster detection
    # --------------------------------------------------------------------- #

    def find_clusters(self, min_depth: int = 2) -> List[Set[str]]:
        """
        Find connected components in the coincidence graph.

        Two entities are in the same cluster if they share a coincidence
        at >= min_depth.  Returns clusters sorted largest-first.
        """
        coincidences = self.detect(min_depth)

        # Union-find
        parent: Dict[str, str] = {}

        def find(x: str) -> str:
            while parent.get(x, x) != x:
                parent[x] = parent.get(parent[x], parent[x])
                x = parent[x]
            return x

        def union(a: str, b: str) -> None:
            ra, rb = find(a), find(b)
            if ra != rb:
                parent[ra] = rb

        for c in coincidences:
            union(c.source, c.target)

        # Group by root
        clusters: Dict[str, Set[str]] = defaultdict(set)
        all_entities = set()
        for c in coincidences:
            all_entities.add(c.source)
            all_entities.add(c.target)
        for e in all_entities:
            clusters[find(e)].add(e)

        return sorted(clusters.values(), key=len, reverse=True)

    # --------------------------------------------------------------------- #
    # Gap analysis
    # --------------------------------------------------------------------- #

    def gap_analysis(self, source: str, target: str) -> Dict[str, Optional[float]]:
        """
        For a specific entity pair, show which lenses have evidence
        and which are gaps (None = no edge in that lens).
        """
        result: Dict[str, Optional[float]] = {}
        idx = self.engine.registry.entity_index
        ri = idx.index_of(source)
        ci = idx.index_of(target)

        for lens in self.engine.registry.lenses:
            if ri is not None and ci is not None:
                w = lens.matrix.get(ri, ci)
                result[lens.name] = w if w != 0.0 else None
            else:
                result[lens.name] = None

        return result

    # --------------------------------------------------------------------- #
    # Reporting
    # --------------------------------------------------------------------- #

    def report(self, min_depth: int = 2, top_n: int = 20) -> Dict:
        """Generate a structured coincidence report."""
        coincidences = self.detect(min_depth)
        scores = self.score_entities(min_depth)
        clusters = self.find_clusters(min_depth)

        return {
            "parameters": {
                "min_depth": min_depth,
                "total_lenses": self.engine.registry.n_lenses,
                "lens_names": self.engine.registry.names,
            },
            "summary": {
                "total_coincidences": len(coincidences),
                "fully_corroborated": sum(
                    1 for c in coincidences
                    if c.depth == self.engine.registry.n_lenses
                ),
                "unique_entities": len(scores),
                "clusters": len(clusters),
            },
            "top_coincidences": [
                {
                    "source": c.source,
                    "target": c.target,
                    "depth": c.depth,
                    "strength": round(c.strength, 4),
                    "combined_weight": round(c.combined_weight, 4),
                    "active_lenses": list(c.lens_weights.keys()),
                    "missing_lenses": c.missing_lenses,
                }
                for c in coincidences[:top_n]
            ],
            "top_entities": [
                {
                    "entity": s.entity,
                    "total_coincidences": s.total_coincidences,
                    "max_depth": s.max_depth,
                    "total_weight": round(s.total_weight, 4),
                    "connected_to": len(s.connected_entities),
                    "per_lens_count": s.per_lens_count,
                }
                for s in scores[:top_n]
            ],
            "clusters": [sorted(c) for c in clusters],
        }
