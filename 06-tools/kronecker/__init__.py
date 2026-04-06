"""
Kronecker Product Hypergraph Engine (⊗⁶)
=========================================

Six-lens analytical framework that computes the Kronecker (tensor) product
across independent analytical dimensions over a shared entity set.

Lenses:
    L1 - Identity/Entity    : Who is involved
    L2 - Financial           : Money flows and account relationships
    L3 - Temporal            : When events occurred and their sequencing
    L4 - Legal/Normative     : Which rules/duties were violated
    L5 - Evidentiary         : What documents support the claims
    L6 - Behavioral          : How actors behaved (agent states, comms)

A nonzero entry in the product L1 ⊗ L2 ⊗ L3 ⊗ L4 ⊗ L5 ⊗ L6
represents a fully corroborated finding across all six dimensions.
"""

from kronecker.sparse import SparseMatrix
from kronecker.lens import Lens, LensRegistry
from kronecker.engine import KroneckerEngine
from kronecker.coincidence import CoincidenceDetector

__all__ = [
    "SparseMatrix",
    "Lens",
    "LensRegistry",
    "KroneckerEngine",
    "CoincidenceDetector",
]
