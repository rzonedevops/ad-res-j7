# HyperGraphQL Project Examples

This document provides examples of GraphQL queries for the project hypergraph. The API exposes the complete project structure with 985 nodes, 532 hyperedges, and 8 layers.

## Server Information

- **Endpoint**: `http://localhost:8080/graphql`
- **Playground**: `http://localhost:8080/graphql` (GET request)
- **Info**: `http://localhost:8080/hypergraph/info`
- **Health**: `http://localhost:8080/health`

## Basic Queries

### 1. Get Hypergraph Metrics

```graphql
query GetMetrics {
  projectMetrics {
    totalNodes
    totalHyperedges
    totalLayers
    density
    averageDegree
    nodeTypes
    edgeTypes
    layerSizes
  }
}
```

### 2. List All Layers

```graphql
query GetLayers {
  projectLayers {
    name
    nodeCount
    nodeTypes
  }
}
```

### 3. Get Python Files

```graphql
query GetPythonFiles {
  projectNodes(type: PYTHON_FILE, limit: 10) {
    id
    name
    type
    properties
    layer
    degree
  }
}
```

## Node Queries

### 4. Get Functions

```graphql
query GetFunctions {
  projectNodes(type: FUNCTION, limit: 5) {
    id
    name
    properties
    neighbors(depth: 1) {
      id
      name
      type
    }
  }
}
```

### 5. Get Database Tables

```graphql
query GetDatabaseTables {
  projectNodes(type: DATABASE_TABLE) {
    id
    name
    properties
    layer
  }
}
```

### 6. Search Nodes by Name

```graphql
query SearchNodes {
  projectNodesByName(name: "hypergraph") {
    id
    name
    type
    layer
  }
}
```

### 7. Search with Filters

```graphql
query SearchPythonFiles {
  searchProjectNodes(
    query: "analysis"
    type: PYTHON_FILE
    limit: 5
  ) {
    id
    name
    type
    properties
  }
}
```

## Layer-Based Queries

### 8. Get API Layer Nodes

```graphql
query GetAPILayer {
  projectLayer(name: API) {
    name
    description
    nodeCount
    nodeTypes
    nodes {
      id
      name
      type
      properties
    }
  }
}
```

### 9. Get Python Code Layer

```graphql
query GetPythonCodeLayer {
  projectNodes(layer: PYTHON_CODE, limit: 10) {
    id
    name
    type
    properties
  }
}
```

## Graph Traversal Queries

### 10. Get Node Neighbors

```graphql
query GetNodeNeighbors {
  projectNode(id: "2") {
    id
    name
    type
    neighbors(depth: 2) {
      id
      name
      type
    }
    connectedEdges {
      id
      type
      nodeIds
    }
  }
}
```

### 11. Find Shortest Path

```graphql
query FindPath {
  projectShortestPath(fromId: "0", toId: "2") {
    id
    name
    type
  }
}
```

### 12. Extract Subgraph

```graphql
query GetSubgraph {
  projectSubgraph(nodeIds: ["0", "1", "2"]) {
    nodeCount
    edgeCount
    nodes {
      id
      name
      type
    }
    edges {
      id
      type
      nodeIds
    }
  }
}
```

## Analysis Queries

### 13. Get Node Metrics

```graphql
query GetNodeMetrics {
  projectNodeMetrics(nodeId: "2") {
    nodeId
    degree
    type
    layer
  }
}
```

### 14. Community Detection

```graphql
query DetectCommunities {
  projectCommunityDetection(algorithm: "louvain") {
    id
    size
    density
    nodes {
      id
      name
      type
    }
  }
}
```

## Edge Queries

### 15. Get Hyperedges

```graphql
query GetHyperedges {
  projectHyperedges(limit: 5) {
    id
    type
    size
    properties
    nodes {
      id
      name
      type
    }
  }
}
```

### 16. Get Specific Edge Types

```graphql
query GetContainsEdges {
  projectHyperedges(type: CONTAINS) {
    id
    type
    properties
    nodeIds
    size
  }
}
```

## Complex Queries

### 17. Multi-Layer Analysis

```graphql
query MultiLayerAnalysis {
  filesystem: projectNodes(layer: FILESYSTEM) {
    id
    name
    type
  }
  pythonCode: projectNodes(layer: PYTHON_CODE, limit: 10) {
    id
    name
    type
  }
  database: projectNodes(layer: DATABASE, limit: 5) {
    id
    name  
    type
  }
}
```

### 18. Comprehensive Node Analysis

```graphql
query AnalyzeNode {
  node: projectNode(id: "20") {
    id
    name
    type
    layer
    degree
    properties
    neighbors(depth: 1) {
      id
      name
      type
    }
    connectedEdges {
      id
      type
      size
    }
  }
  metrics: projectNodeMetrics(nodeId: "20") {
    degree
    type
    layer
  }
}
```

## cURL Examples

### Basic Health Check
```bash
curl http://localhost:8080/health
```

### Get Hypergraph Info
```bash
curl http://localhost:8080/hypergraph/info
```

### GraphQL Query via cURL
```bash
curl -X POST http://localhost:8080/graphql \
  -H "Content-Type: application/json" \
  -d '{
    "query": "{ projectMetrics { totalNodes totalHyperedges density } }"
  }'
```

### Search Python Files
```bash
curl -X POST http://localhost:8080/graphql \
  -H "Content-Type: application/json" \
  -d '{
    "query": "{ projectNodes(type: PYTHON_FILE, limit: 3) { id name type } }"
  }'
```

## Available Types

### Node Types
- `DIRECTORY` - Directory nodes (10)
- `MODULE` - Python modules (10) 
- `PYTHON_FILE` - Python source files (100)
- `FUNCTION` - Python functions (378)
- `CLASS` - Python classes (140)
- `DATABASE_TABLE` - Database tables (70)
- `DATABASE_INDEX` - Database indexes (112)
- `GRAPHQL_TYPE` - GraphQL type definitions (42)
- `DEPENDENCY` - External dependencies (34)
- `DOCUMENTATION` - Documentation files (50)
- `CONFIGURATION` - Configuration files (3)
- `TEST_FILE` - Test files (36)

### Edge Types
- `CONTAINS` - Containment relationships (10)
- `DEFINES` - Definition relationships (518)
- `DOCUMENTATION_CATEGORY` - Documentation categories (4)

### Layer Types
- `FILESYSTEM` - File system structure (20 nodes)
- `PYTHON_CODE` - Python code elements (618 nodes)
- `DATABASE` - Database schema (182 nodes)
- `API` - API definitions (42 nodes)
- `DEPENDENCIES` - External dependencies (34 nodes)
- `DOCUMENTATION` - Documentation (50 nodes)
- `CONFIGURATION` - Configuration (3 nodes)
- `TESTS` - Test files (36 nodes)

## Performance Notes

- Simple queries (single node, metrics) typically complete in <10ms
- Complex traversal queries may take 50-100ms
- Community detection can take several seconds for the full graph
- Use `limit` parameters to control result set size
- Layer-based filtering is more efficient than type-based filtering

## Error Handling

The API returns standard GraphQL error responses:

```json
{
  "errors": [{
    "message": "Node not found",
    "path": ["projectNode"],
    "extensions": {
      "code": "NOT_FOUND"
    }
  }]
}
```

## Next Steps

1. Start the server: `python src/api/hypergraphql_project_server.py`
2. Open GraphQL Playground: http://localhost:8080/graphql
3. Try the example queries above
4. Explore the schema in the playground documentation
5. Build custom queries for your use case