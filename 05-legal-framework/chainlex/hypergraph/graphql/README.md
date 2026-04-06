# Lex-HyperGraph-Neural-Net-QL GraphQL Interface

## Overview

This directory contains the GraphQL interface for querying the legal reasoning hypergraph
with GNN-powered inference capabilities.

## Features

- **Node Queries**: Query legal principles, rules, and concepts
- **Edge Queries**: Explore relationships and derivations
- **Inference Chains**: Find reasoning paths between nodes
- **GNN-Powered**: Similar node search, confidence prediction, reasoning scores
- **Domain Filtering**: Filter by legal domain (contract, tort, criminal, etc.)
- **Jurisdiction Filtering**: Filter by jurisdiction (ZA, US, UK, etc.)

## Files

- `schema.graphql` - GraphQL schema definition
- `example_queries.graphql` - Example queries
- `README.md` - This file

## Usage

See `example_queries.graphql` for query examples.

## Dependencies

- graphene (for GraphQL schema)
- numpy (for GNN features)
- networkx (for graph operations)
