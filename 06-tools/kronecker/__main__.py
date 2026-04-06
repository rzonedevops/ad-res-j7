#!/usr/bin/env python3
"""
Run the Kronecker ⊗⁶ analysis against the ad-res-j7 data models.

Usage:
    python -m kronecker
    python -m kronecker --entity PERSON_002
    python -m kronecker --gap PERSON_001 PERSON_002
    python -m kronecker --min-depth 3
    python -m kronecker --json
"""

import argparse
import json
import os
import sys

# Ensure project root is on path
sys.path.insert(0, os.path.dirname(os.path.dirname(os.path.abspath(__file__))))

from kronecker.loaders import load_all_lenses
from kronecker.engine import KroneckerEngine
from kronecker.coincidence import CoincidenceDetector
from kronecker.visualize import full_report, entity_card, gap_table


def main():
    parser = argparse.ArgumentParser(
        description="Kronecker Product Hypergraph Analysis (⊗⁶)"
    )
    parser.add_argument(
        "--data-dir",
        default=os.path.join(os.path.dirname(os.path.dirname(os.path.abspath(__file__))),
                             "data_models"),
        help="Path to data_models directory",
    )
    parser.add_argument("--entity", help="Show profile card for a specific entity")
    parser.add_argument("--gap", nargs=2, metavar=("SOURCE", "TARGET"),
                        help="Gap analysis for an entity pair")
    parser.add_argument("--min-depth", type=int, default=2,
                        help="Minimum corroboration depth (default: 2)")
    parser.add_argument("--top", type=int, default=15,
                        help="Number of top results to show")
    parser.add_argument("--json", action="store_true", dest="as_json",
                        help="Output structured JSON instead of text")
    parser.add_argument("--summary", action="store_true",
                        help="Show only the summary statistics")

    args = parser.parse_args()

    # Load
    print("Loading lenses...", file=sys.stderr)
    registry = load_all_lenses(args.data_dir)
    engine = KroneckerEngine(registry)
    detector = CoincidenceDetector(engine)

    print(f"  {registry.n_lenses} lenses, "
          f"{len(registry.entity_index)} entities loaded\n",
          file=sys.stderr)

    # Dispatch
    if args.entity:
        if args.as_json:
            print(json.dumps(engine.entity_profile(args.entity), indent=2))
        else:
            print(entity_card(engine, args.entity))

    elif args.gap:
        if args.as_json:
            print(json.dumps(detector.gap_analysis(*args.gap), indent=2))
        else:
            print(gap_table(detector, *args.gap))

    elif args.as_json:
        print(json.dumps(detector.report(args.min_depth, args.top), indent=2))

    elif args.summary:
        summary = engine.summary()
        for k, v in summary.items():
            print(f"  {k}: {v}")

    else:
        print(full_report(engine, args.top))


if __name__ == "__main__":
    main()
