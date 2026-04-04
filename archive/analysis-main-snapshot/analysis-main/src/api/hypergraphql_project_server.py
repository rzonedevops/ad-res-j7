#!/usr/bin/env python3
"""
HyperGraphQL Project Server
============================

Flask-based GraphQL server for the project hypergraph.
Provides:
- GraphQL endpoint at /graphql
- GraphQL Playground at /graphql (GET)
- CORS support for frontend integration
- Error handling and logging
"""

import logging
from pathlib import Path
from typing import Dict, Any

from flask import Flask, request, jsonify
from flask_cors import CORS
from ariadne import graphql_sync, make_executable_schema, load_schema_from_path

# Simple GraphQL Playground HTML
PLAYGROUND_HTML = """
<!DOCTYPE html>
<html>
<head>
    <meta charset=utf-8/>
    <meta name="viewport" content="user-scalable=no, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, minimal-ui">
    <title>GraphQL Playground</title>
    <link rel="stylesheet" href="//cdn.jsdelivr.net/npm/graphql-playground-react/build/static/css/index.css" />
    <link rel="shortcut icon" href="//cdn.jsdelivr.net/npm/graphql-playground-react/build/favicon.png" />
    <script src="//cdn.jsdelivr.net/npm/graphql-playground-react/build/static/js/middleware.js"></script>
</head>
<body>
    <div id="root">
        <style>
            body { margin: 0; font-family: "Open Sans", sans-serif; overflow: hidden; }
            #root { height: 100vh; }
        </style>
        <div style="display: flex; flex-direction: column; height: 100%; justify-content: center; align-items: center;">
            <div>Loading GraphQL Playground...</div>
        </div>
    </div>
    <script>
        window.addEventListener('load', function (event) {
            GraphQLPlayground.init(document.getElementById('root'), {
                endpoint: '/graphql'
            })
        })
    </script>
</body>
</html>
"""

# Import resolvers and loader
import sys
from pathlib import Path
sys.path.append(str(Path(__file__).parent))

from hypergraphql_project_resolvers import resolvers
from hypergraphql_project import get_project_loader

# Configure logging
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

# Initialize Flask app
app = Flask(__name__)
CORS(app)

# Load GraphQL schema
schema_path = Path(__file__).parent / "project_hypergraph_schema.graphql"
if not schema_path.exists():
    raise FileNotFoundError(f"GraphQL schema not found: {schema_path}")

type_defs = load_schema_from_path(str(schema_path))
schema = make_executable_schema(type_defs, *resolvers)

# Pre-load the project hypergraph data
try:
    loader = get_project_loader()
    loader.load()
    logger.info("Project hypergraph loaded successfully")
except Exception as e:
    logger.error(f"Failed to load project hypergraph: {e}")
    raise


@app.route("/graphql", methods=["GET"])
def graphql_playground():
    """Serve GraphQL Playground for interactive queries"""
    return PLAYGROUND_HTML, 200


@app.route("/graphql", methods=["POST"])
def graphql_server():
    """Handle GraphQL queries"""
    try:
        data = request.get_json()
        
        if not data:
            return jsonify({"error": "No JSON data provided"}), 400
            
        query = data.get("query")
        variables = data.get("variables")
        operation_name = data.get("operationName")
        
        if not query:
            return jsonify({"error": "No query provided"}), 400
        
        # Execute GraphQL query
        success, result = graphql_sync(
            schema,
            data={"query": query, "variables": variables, "operationName": operation_name},
            context_value={"request": request}
        )
        
        status_code = 200 if success else 400
        return jsonify(result), status_code
        
    except Exception as e:
        logger.error(f"GraphQL server error: {e}")
        return jsonify({
            "errors": [{
                "message": "Internal server error",
                "extensions": {"code": "INTERNAL_ERROR"}
            }]
        }), 500


@app.route("/hypergraph/info", methods=["GET"])
def hypergraph_info():
    """Get basic information about the project hypergraph"""
    try:
        loader = get_project_loader()
        metrics = loader.get_hypergraph_metrics()
        
        return jsonify({
            "project": "rzonedevops/analysis",
            "version": "0.6.0",
            "hypergraph": {
                "nodes": metrics.get("total_nodes", 0),
                "hyperedges": metrics.get("total_hyperedges", 0),
                "layers": metrics.get("total_layers", 0),
                "density": metrics.get("density", 0.0),
                "avgDegree": metrics.get("average_degree", 0.0)
            },
            "nodeTypes": metrics.get("node_types", {}),
            "edgeTypes": metrics.get("edge_types", {}),
            "layerSizes": metrics.get("layer_sizes", {})
        })
        
    except Exception as e:
        logger.error(f"Error getting hypergraph info: {e}")
        return jsonify({"error": "Failed to get hypergraph info"}), 500


@app.route("/hypergraph/schema", methods=["GET"])
def get_schema_sdl():
    """Get the GraphQL schema in SDL format"""
    try:
        with open(schema_path, 'r') as f:
            schema_sdl = f.read()
        
        return jsonify({
            "sdl": schema_sdl,
            "endpoints": {
                "graphql": "/graphql",
                "playground": "/graphql (GET)",
                "info": "/hypergraph/info",
                "schema": "/hypergraph/schema"
            }
        })
        
    except Exception as e:
        logger.error(f"Error getting schema: {e}")
        return jsonify({"error": "Failed to get schema"}), 500


@app.route("/health", methods=["GET"])
def health_check():
    """Health check endpoint"""
    try:
        loader = get_project_loader()
        node_count = len(loader.nodes) if loader._loaded else "not loaded"
        
        return jsonify({
            "status": "healthy",
            "service": "HyperGraphQL Project Server",
            "hypergraph_loaded": loader._loaded,
            "node_count": node_count
        })
        
    except Exception as e:
        return jsonify({
            "status": "unhealthy", 
            "error": str(e)
        }), 500


@app.errorhandler(404)
def not_found(error):
    """Handle 404 errors"""
    return jsonify({
        "error": "Not found",
        "available_endpoints": [
            "POST /graphql - GraphQL API",
            "GET /graphql - GraphQL Playground", 
            "GET /hypergraph/info - Hypergraph information",
            "GET /hypergraph/schema - GraphQL schema SDL",
            "GET /health - Health check"
        ]
    }), 404


@app.errorhandler(500)
def internal_error(error):
    """Handle 500 errors"""
    return jsonify({
        "error": "Internal server error",
        "message": "An unexpected error occurred"
    }), 500


def create_app(config: Dict[str, Any] = None) -> Flask:
    """Create and configure Flask app"""
    if config:
        app.config.update(config)
    return app


def run_server(host: str = "0.0.0.0", port: int = 8000, debug: bool = False):
    """Run the GraphQL server"""
    logger.info(f"Starting HyperGraphQL Project Server on {host}:{port}")
    logger.info("Available endpoints:")
    logger.info("  POST /graphql - GraphQL API")
    logger.info("  GET /graphql - GraphQL Playground")
    logger.info("  GET /hypergraph/info - Hypergraph info")
    logger.info("  GET /health - Health check")
    
    app.run(host=host, port=port, debug=debug)


if __name__ == "__main__":
    # Run server if executed directly
    import argparse
    
    parser = argparse.ArgumentParser(description="HyperGraphQL Project Server")
    parser.add_argument("--host", default="0.0.0.0", help="Host to bind to")
    parser.add_argument("--port", type=int, default=8000, help="Port to bind to")
    parser.add_argument("--debug", action="store_true", help="Enable debug mode")
    
    args = parser.parse_args()
    run_server(host=args.host, port=args.port, debug=args.debug)