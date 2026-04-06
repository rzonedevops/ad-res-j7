"""
Sparse matrix and tensor primitives for the Kronecker engine.

All structures use dictionary-of-keys (DOK) format for efficient
construction and lookup without numpy/scipy dependencies.
"""

from __future__ import annotations
from typing import Dict, Iterator, List, Optional, Set, Tuple
from dataclasses import dataclass, field
import math


# Type aliases
Index = Tuple[int, ...]
Scalar = float


class SparseMatrix:
    """
    Sparse matrix over an indexed entity set.

    Stores only nonzero entries as {(row, col): weight}.
    Rows and columns share the same entity namespace via an EntityIndex.
    """

    def __init__(self, entity_index: "EntityIndex" = None):
        self._data: Dict[Tuple[int, int], Scalar] = {}
        self.entity_index = entity_index or EntityIndex()

    # -- construction ---------------------------------------------------------

    def set(self, row: int, col: int, value: Scalar) -> None:
        if value == 0.0:
            self._data.pop((row, col), None)
        else:
            self._data[(row, col)] = value

    def set_by_name(self, row_name: str, col_name: str, value: Scalar) -> None:
        r = self.entity_index.get_or_add(row_name)
        c = self.entity_index.get_or_add(col_name)
        self.set(r, c, value)

    def get(self, row: int, col: int) -> Scalar:
        return self._data.get((row, col), 0.0)

    def get_by_name(self, row_name: str, col_name: str) -> Scalar:
        r = self.entity_index.index_of(row_name)
        c = self.entity_index.index_of(col_name)
        if r is None or c is None:
            return 0.0
        return self.get(r, c)

    # -- properties -----------------------------------------------------------

    @property
    def nnz(self) -> int:
        return len(self._data)

    @property
    def shape(self) -> Tuple[int, int]:
        n = len(self.entity_index)
        return (n, n)

    @property
    def density(self) -> float:
        n = len(self.entity_index)
        if n == 0:
            return 0.0
        return self.nnz / (n * n)

    # -- iteration ------------------------------------------------------------

    def nonzero(self) -> Iterator[Tuple[int, int, Scalar]]:
        for (r, c), v in self._data.items():
            yield r, c, v

    def nonzero_named(self) -> Iterator[Tuple[str, str, Scalar]]:
        for r, c, v in self.nonzero():
            yield self.entity_index.name_of(r), self.entity_index.name_of(c), v

    # -- row/column access ----------------------------------------------------

    def row_entries(self, row: int) -> Dict[int, Scalar]:
        return {c: v for (r, c), v in self._data.items() if r == row}

    def col_entries(self, col: int) -> Dict[int, Scalar]:
        return {r: v for (r, c), v in self._data.items() if c == col}

    def row_names(self, row_name: str) -> Dict[str, Scalar]:
        r = self.entity_index.index_of(row_name)
        if r is None:
            return {}
        return {
            self.entity_index.name_of(c): v
            for c, v in self.row_entries(r).items()
        }

    # -- algebra --------------------------------------------------------------

    def transpose(self) -> "SparseMatrix":
        t = SparseMatrix(self.entity_index)
        for r, c, v in self.nonzero():
            t.set(c, r, v)
        return t

    def hadamard(self, other: "SparseMatrix") -> "SparseMatrix":
        """Element-wise (Hadamard) product — intersection of support."""
        result = SparseMatrix(self.entity_index)
        for (r, c), v in self._data.items():
            w = other.get(r, c)
            if w != 0.0:
                result.set(r, c, v * w)
        return result

    def add(self, other: "SparseMatrix", alpha: Scalar = 1.0) -> "SparseMatrix":
        """Weighted sum: self + alpha * other."""
        result = SparseMatrix(self.entity_index)
        result._data = dict(self._data)
        for (r, c), v in other._data.items():
            current = result._data.get((r, c), 0.0)
            new_val = current + alpha * v
            if new_val == 0.0:
                result._data.pop((r, c), None)
            else:
                result._data[(r, c)] = new_val
        return result

    # -- serialization --------------------------------------------------------

    def to_dict(self) -> Dict:
        return {
            "entities": self.entity_index.to_list(),
            "entries": [
                {"row": r, "col": c, "value": v}
                for r, c, v in self.nonzero()
            ],
        }

    @classmethod
    def from_dict(cls, data: Dict) -> "SparseMatrix":
        idx = EntityIndex()
        for name in data.get("entities", []):
            idx.get_or_add(name)
        mat = cls(idx)
        for entry in data.get("entries", []):
            mat.set(entry["row"], entry["col"], entry["value"])
        return mat

    def __repr__(self) -> str:
        return f"SparseMatrix(n={len(self.entity_index)}, nnz={self.nnz}, density={self.density:.4f})"


class EntityIndex:
    """
    Bidirectional mapping between entity names and integer indices.
    Shared across all lenses to ensure alignment.
    """

    def __init__(self):
        self._name_to_idx: Dict[str, int] = {}
        self._idx_to_name: Dict[int, str] = {}
        self._next_idx = 0

    def get_or_add(self, name: str) -> int:
        if name not in self._name_to_idx:
            self._name_to_idx[name] = self._next_idx
            self._idx_to_name[self._next_idx] = name
            self._next_idx += 1
        return self._name_to_idx[name]

    def index_of(self, name: str) -> Optional[int]:
        return self._name_to_idx.get(name)

    def name_of(self, idx: int) -> str:
        return self._idx_to_name.get(idx, f"<unknown:{idx}>")

    def names(self) -> List[str]:
        return [self._idx_to_name[i] for i in range(self._next_idx)]

    def to_list(self) -> List[str]:
        return self.names()

    def __len__(self) -> int:
        return self._next_idx

    def __contains__(self, name: str) -> bool:
        return name in self._name_to_idx

    def __repr__(self) -> str:
        return f"EntityIndex(n={self._next_idx})"


class SparseTensor:
    """
    Sparse N-dimensional tensor stored as {(i1, i2, ..., iN): value}.

    Used for the full ⊗⁶ product where each axis corresponds to a lens.
    """

    def __init__(self, ndim: int, entity_index: EntityIndex = None):
        self.ndim = ndim
        self.entity_index = entity_index or EntityIndex()
        self._data: Dict[Index, Scalar] = {}

    def set(self, index: Index, value: Scalar) -> None:
        if len(index) != self.ndim:
            raise ValueError(f"Expected {self.ndim}-dim index, got {len(index)}")
        if value == 0.0:
            self._data.pop(index, None)
        else:
            self._data[index] = value

    def get(self, index: Index) -> Scalar:
        return self._data.get(index, 0.0)

    @property
    def nnz(self) -> int:
        return len(self._data)

    def nonzero(self) -> Iterator[Tuple[Index, Scalar]]:
        for idx, v in self._data.items():
            yield idx, v

    def slice_axis(self, axis: int, value: int) -> "SparseTensor":
        """Fix one axis and return the (N-1)-dim sub-tensor."""
        result = SparseTensor(self.ndim - 1, self.entity_index)
        for idx, v in self._data.items():
            if idx[axis] == value:
                new_idx = idx[:axis] + idx[axis + 1:]
                result.set(new_idx, v)
        return result

    def project(self, axes: List[int]) -> "SparseTensor":
        """Project (marginalize) onto a subset of axes by summing out the rest."""
        result = SparseTensor(len(axes), self.entity_index)
        for idx, v in self._data.items():
            projected = tuple(idx[a] for a in axes)
            current = result.get(projected)
            result.set(projected, current + v)
        return result

    def to_dict(self) -> Dict:
        return {
            "ndim": self.ndim,
            "nnz": self.nnz,
            "entities": self.entity_index.to_list(),
            "entries": [
                {"index": list(idx), "value": v}
                for idx, v in self.nonzero()
            ],
        }

    @classmethod
    def from_dict(cls, data: Dict) -> "SparseTensor":
        idx = EntityIndex()
        for name in data.get("entities", []):
            idx.get_or_add(name)
        tensor = cls(data["ndim"], idx)
        for entry in data.get("entries", []):
            tensor.set(tuple(entry["index"]), entry["value"])
        return tensor

    def __repr__(self) -> str:
        n = len(self.entity_index)
        return f"SparseTensor(ndim={self.ndim}, n={n}, nnz={self.nnz})"
