"""
Lens abstraction — each lens is a named analytical filter that produces
a sparse adjacency matrix over the shared entity set.

Built-in lens types map to the six canonical dimensions:
    L1  Identity     (entity ↔ entity structural links)
    L2  Financial    (entity ↔ entity money flows)
    L3  Temporal     (entity ↔ entity co-occurrence in time windows)
    L4  Legal        (entity ↔ entity shared statute violations)
    L5  Evidentiary  (entity ↔ entity co-referenced by evidence)
    L6  Behavioral   (entity ↔ entity shared behavioral patterns)

Custom lenses can be registered for extensibility beyond 6.
"""

from __future__ import annotations
from abc import ABC, abstractmethod
from dataclasses import dataclass, field
from typing import Any, Callable, Dict, List, Optional, Type
import json

from kronecker.sparse import EntityIndex, SparseMatrix


# =============================================================================
# Lens base class
# =============================================================================

class Lens(ABC):
    """
    A single analytical layer.

    Subclass and implement `build()` to populate the adjacency matrix
    from whatever data source backs this lens.
    """

    def __init__(self, name: str, entity_index: EntityIndex):
        self.name = name
        self.entity_index = entity_index
        self._matrix: Optional[SparseMatrix] = None
        self._metadata: Dict[str, Any] = {}

    @property
    def matrix(self) -> SparseMatrix:
        if self._matrix is None:
            self._matrix = SparseMatrix(self.entity_index)
            self.build(self._matrix)
        return self._matrix

    def invalidate(self) -> None:
        """Force rebuild on next access."""
        self._matrix = None

    @abstractmethod
    def build(self, mat: SparseMatrix) -> None:
        """Populate *mat* with edges for this lens."""
        ...

    def edge(self, mat: SparseMatrix, source: str, target: str,
             weight: float = 1.0) -> None:
        """Helper — add a named edge."""
        mat.set_by_name(source, target, weight)

    def biedge(self, mat: SparseMatrix, a: str, b: str,
               weight: float = 1.0) -> None:
        """Helper — add a symmetric (undirected) edge."""
        mat.set_by_name(a, b, weight)
        mat.set_by_name(b, a, weight)

    def summary(self) -> Dict[str, Any]:
        m = self.matrix
        return {
            "name": self.name,
            "entities": len(self.entity_index),
            "edges": m.nnz,
            "density": m.density,
            "metadata": self._metadata,
        }

    def __repr__(self) -> str:
        return f"Lens({self.name!r}, nnz={self.matrix.nnz})"


# =============================================================================
# Concrete lens implementations (data-driven, load from dicts/JSON)
# =============================================================================

class DictLens(Lens):
    """
    Lens built from an explicit edge list.

    edges: list of {"source": str, "target": str, "weight": float}
    """

    def __init__(self, name: str, entity_index: EntityIndex,
                 edges: List[Dict[str, Any]] = None,
                 symmetric: bool = False):
        super().__init__(name, entity_index)
        self._edges = edges or []
        self._symmetric = symmetric

    def build(self, mat: SparseMatrix) -> None:
        for e in self._edges:
            src = e["source"]
            tgt = e["target"]
            w = e.get("weight", 1.0)
            if self._symmetric:
                self.biedge(mat, src, tgt, w)
            else:
                self.edge(mat, src, tgt, w)

    def add_edge(self, source: str, target: str, weight: float = 1.0) -> None:
        self._edges.append({"source": source, "target": target, "weight": weight})
        self.invalidate()

    @classmethod
    def from_json(cls, path: str, entity_index: EntityIndex,
                  name: str = None, symmetric: bool = False) -> "DictLens":
        with open(path) as f:
            data = json.load(f)
        lens_name = name or data.get("name", path)
        edges = data.get("edges", data if isinstance(data, list) else [])
        return cls(lens_name, entity_index, edges, symmetric)


class CallableLens(Lens):
    """
    Lens backed by an arbitrary builder function.

    builder(mat, entity_index) -> None
    """

    def __init__(self, name: str, entity_index: EntityIndex,
                 builder: Callable[[SparseMatrix, EntityIndex], None]):
        super().__init__(name, entity_index)
        self._builder = builder

    def build(self, mat: SparseMatrix) -> None:
        self._builder(mat, self.entity_index)


# =============================================================================
# Lens registry
# =============================================================================

# Canonical lens identifiers
IDENTITY = "L1_identity"
FINANCIAL = "L2_financial"
TEMPORAL = "L3_temporal"
LEGAL = "L4_legal"
EVIDENTIARY = "L5_evidentiary"
BEHAVIORAL = "L6_behavioral"

CANONICAL_ORDER = [IDENTITY, FINANCIAL, TEMPORAL, LEGAL, EVIDENTIARY, BEHAVIORAL]


class LensRegistry:
    """
    Manages the ordered set of lenses that participate in the ⊗ product.

    Enforces a shared EntityIndex so all matrices are aligned.
    """

    def __init__(self, entity_index: EntityIndex = None):
        self.entity_index = entity_index or EntityIndex()
        self._lenses: Dict[str, Lens] = {}
        self._order: List[str] = []

    def register(self, lens: Lens, position: int = None) -> None:
        if lens.entity_index is not self.entity_index:
            raise ValueError(
                f"Lens '{lens.name}' uses a different EntityIndex. "
                "All lenses must share the registry's EntityIndex."
            )
        self._lenses[lens.name] = lens
        if lens.name not in self._order:
            if position is not None:
                self._order.insert(position, lens.name)
            else:
                self._order.append(lens.name)

    def get(self, name: str) -> Optional[Lens]:
        return self._lenses.get(name)

    def remove(self, name: str) -> None:
        self._lenses.pop(name, None)
        if name in self._order:
            self._order.remove(name)

    @property
    def lenses(self) -> List[Lens]:
        return [self._lenses[n] for n in self._order if n in self._lenses]

    @property
    def names(self) -> List[str]:
        return list(self._order)

    @property
    def n_lenses(self) -> int:
        return len(self._order)

    def create_dict_lens(self, name: str, edges: List[Dict] = None,
                         symmetric: bool = False) -> DictLens:
        """Convenience — create, register, and return a DictLens."""
        lens = DictLens(name, self.entity_index, edges or [], symmetric)
        self.register(lens)
        return lens

    def create_callable_lens(self, name: str,
                             builder: Callable) -> CallableLens:
        lens = CallableLens(name, self.entity_index, builder)
        self.register(lens)
        return lens

    def summary(self) -> List[Dict]:
        return [l.summary() for l in self.lenses]

    def __len__(self) -> int:
        return self.n_lenses

    def __repr__(self) -> str:
        return f"LensRegistry(lenses={self._order})"
