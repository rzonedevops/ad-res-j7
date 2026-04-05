"""
Kronecker product engine.

Computes the tensor product ⊗ across N lenses without materializing
the full dense tensor.  Instead it enumerates entity tuples that have
nonzero support in EVERY lens (the "coincidence set").

Two modes:
    1. Full product  — SparseTensor with one axis per lens.
    2. Projected product — collapse to entity×entity by multiplying
       all per-lens adjacency weights (fast coincidence scan).
"""

from __future__ import annotations
from typing import Dict, List, Optional, Set, Tuple
from dataclasses import dataclass, field

from kronecker.sparse import EntityIndex, SparseMatrix, SparseTensor, Scalar
from kronecker.lens import Lens, LensRegistry


@dataclass
class ProductEntry:
    """One nonzero entry in the ⊗ product."""
    entities: Tuple[str, str]           # (source, target)
    per_lens: Dict[str, Scalar]         # {lens_name: weight}
    combined: Scalar = 0.0              # product of all lens weights
    n_lenses: int = 0                   # how many lenses contribute


class KroneckerEngine:
    """
    Computes the Kronecker (tensor) product across a LensRegistry.

    The key insight: for the entity-pair (i, j), its product weight is

        w(i,j) = L1[i,j] * L2[i,j] * ... * LN[i,j]

    This is nonzero only when (i,j) is an edge in ALL lenses — the
    "full corroboration" condition.  Partial products (k-of-N) are
    also supported for softer coincidence detection.
    """

    def __init__(self, registry: LensRegistry):
        self.registry = registry
        self._product_cache: Optional[Dict[Tuple[int, int], ProductEntry]] = None

    def invalidate(self) -> None:
        self._product_cache = None

    # --------------------------------------------------------------------- #
    # Core product computation
    # --------------------------------------------------------------------- #

    def compute_product(self, min_lenses: int = None) -> Dict[Tuple[int, int], ProductEntry]:
        """
        Compute the element-wise product across all lenses.

        Args:
            min_lenses: minimum number of lenses that must have a nonzero
                        entry for the pair to be included.  Defaults to
                        all lenses (full corroboration).

        Returns:
            {(row, col): ProductEntry} for qualifying entity pairs.
        """
        lenses = self.registry.lenses
        if not lenses:
            return {}

        n_total = len(lenses)
        if min_lenses is None:
            min_lenses = n_total

        # Collect all (row, col) pairs that appear in at least one lens
        pair_weights: Dict[Tuple[int, int], Dict[str, Scalar]] = {}
        for lens in lenses:
            mat = lens.matrix
            for r, c, v in mat.nonzero():
                key = (r, c)
                if key not in pair_weights:
                    pair_weights[key] = {}
                pair_weights[key][lens.name] = v

        # Filter and build ProductEntry objects
        idx = self.registry.entity_index
        result: Dict[Tuple[int, int], ProductEntry] = {}

        for (r, c), lens_map in pair_weights.items():
            n_active = len(lens_map)
            if n_active < min_lenses:
                continue

            combined = 1.0
            for v in lens_map.values():
                combined *= v

            entry = ProductEntry(
                entities=(idx.name_of(r), idx.name_of(c)),
                per_lens=dict(lens_map),
                combined=combined,
                n_lenses=n_active,
            )
            result[(r, c)] = entry

        self._product_cache = result
        return result

    # --------------------------------------------------------------------- #
    # Convenience accessors
    # --------------------------------------------------------------------- #

    def full_corroboration(self) -> List[ProductEntry]:
        """Pairs with nonzero weight in ALL lenses — strongest findings."""
        product = self.compute_product()
        entries = sorted(product.values(), key=lambda e: e.combined, reverse=True)
        return entries

    def partial_corroboration(self, k: int) -> List[ProductEntry]:
        """Pairs with nonzero weight in at least k lenses."""
        product = self.compute_product(min_lenses=k)
        return sorted(product.values(), key=lambda e: e.n_lenses, reverse=True)

    def entity_profile(self, entity_name: str) -> Dict[str, Dict[str, Scalar]]:
        """
        For a single entity, return its outgoing connections per lens.

        Returns {lens_name: {target_name: weight}}.
        """
        idx = self.registry.entity_index
        eidx = idx.index_of(entity_name)
        if eidx is None:
            return {}

        profile: Dict[str, Dict[str, Scalar]] = {}
        for lens in self.registry.lenses:
            row = lens.matrix.row_entries(eidx)
            if row:
                profile[lens.name] = {
                    idx.name_of(c): v for c, v in row.items()
                }
        return profile

    def corroboration_matrix(self) -> SparseMatrix:
        """
        Collapse the product into a single SparseMatrix where each
        entry is the product of weights across all contributing lenses.
        """
        result = SparseMatrix(self.registry.entity_index)
        product = self.compute_product(min_lenses=1)
        for (r, c), entry in product.items():
            result.set(r, c, entry.combined)
        return result

    def lens_overlap_matrix(self) -> SparseMatrix:
        """
        Matrix where entry (i,j) = number of lenses where edge (i,j) is nonzero.
        """
        result = SparseMatrix(self.registry.entity_index)
        product = self.compute_product(min_lenses=1)
        for (r, c), entry in product.items():
            result.set(r, c, float(entry.n_lenses))
        return result

    # --------------------------------------------------------------------- #
    # Full tensor construction (for small entity sets)
    # --------------------------------------------------------------------- #

    def to_sparse_tensor(self, min_lenses: int = None) -> SparseTensor:
        """
        Build the full N-dimensional SparseTensor.

        Axis k corresponds to lens k; the value at (i, j, i, j, i, j)
        isn't quite right — instead each axis pair (2k, 2k+1) is
        (source_in_lens_k, target_in_lens_k).  For the common case
        where source=target across lenses, we flatten to N axes of
        *pairs* identified by their combined (r,c) key.

        For simplicity, this builds a 2-axis tensor (entity × entity)
        with the combined weight, plus a metadata dict keyed by lens
        for each nonzero.  Use the `compute_product` dict directly for
        richer per-lens data.
        """
        n = self.registry.n_lenses
        tensor = SparseTensor(ndim=2, entity_index=self.registry.entity_index)
        product = self.compute_product(min_lenses=min_lenses)
        for (r, c), entry in product.items():
            tensor.set((r, c), entry.combined)
        return tensor

    # --------------------------------------------------------------------- #
    # Reporting
    # --------------------------------------------------------------------- #

    def summary(self) -> Dict:
        product = self.compute_product(min_lenses=1)
        n_total = self.registry.n_lenses

        by_depth = {}
        for entry in product.values():
            k = entry.n_lenses
            by_depth[k] = by_depth.get(k, 0) + 1

        return {
            "n_lenses": n_total,
            "lens_names": self.registry.names,
            "total_entity_pairs": len(product),
            "fully_corroborated": by_depth.get(n_total, 0),
            "by_corroboration_depth": dict(sorted(by_depth.items())),
            "entity_count": len(self.registry.entity_index),
        }
