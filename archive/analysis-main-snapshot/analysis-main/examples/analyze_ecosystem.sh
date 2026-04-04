#!/bin/bash
##
# Analyze Ecosystem - Multi-Repository Hypergraph Analysis
# =========================================================
# 
# This script demonstrates the complete workflow for analyzing
# multiple related repositories and generating insights.
#
# Usage:
#   ./analyze_ecosystem.sh [--skip-clone] [--workspace DIR]
#

set -e  # Exit on error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Configuration
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"
WORKSPACE_DIR="${WORKSPACE_DIR:-/tmp/repo-analysis}"
OUTPUT_DIR="${PROJECT_ROOT}/analysis_outputs"
TIMESTAMP=$(date +%Y%m%d_%H%M%S)

# Parse arguments
SKIP_CLONE=false
CUSTOM_WORKSPACE=""

while [[ $# -gt 0 ]]; do
    case $1 in
        --skip-clone)
            SKIP_CLONE=true
            shift
            ;;
        --workspace)
            CUSTOM_WORKSPACE="$2"
            shift 2
            ;;
        --help)
            echo "Usage: $0 [--skip-clone] [--workspace DIR]"
            echo ""
            echo "Options:"
            echo "  --skip-clone      Use existing local repositories"
            echo "  --workspace DIR   Use custom workspace directory"
            echo "  --help           Show this help message"
            exit 0
            ;;
        *)
            echo "Unknown option: $1"
            echo "Run '$0 --help' for usage information"
            exit 1
            ;;
    esac
done

# Use custom workspace if provided
if [ -n "$CUSTOM_WORKSPACE" ]; then
    WORKSPACE_DIR="$CUSTOM_WORKSPACE"
fi

echo -e "${BLUE}════════════════════════════════════════════════════════════════${NC}"
echo -e "${BLUE}   Multi-Repository Ecosystem Analysis${NC}"
echo -e "${BLUE}════════════════════════════════════════════════════════════════${NC}"
echo ""
echo -e "${GREEN}Configuration:${NC}"
echo "  Project Root: $PROJECT_ROOT"
echo "  Workspace:    $WORKSPACE_DIR"
echo "  Output Dir:   $OUTPUT_DIR"
echo "  Skip Clone:   $SKIP_CLONE"
echo ""

# Create output directory
mkdir -p "$OUTPUT_DIR"

# Step 1: Construct Multi-Repo Hypergraph
echo -e "${YELLOW}Step 1: Constructing Multi-Repository Hypergraph${NC}"
echo "─────────────────────────────────────────────────────────────"

HYPERGRAPH_FILE="$OUTPUT_DIR/multi_repo_hypergraph_${TIMESTAMP}.json"

if [ "$SKIP_CLONE" = true ]; then
    echo "Using existing local repositories..."
    python3 "$PROJECT_ROOT/construct_multi_repo_hypergraph.py" \
        --skip-clone \
        --workspace "$WORKSPACE_DIR" \
        --output "$HYPERGRAPH_FILE"
else
    echo "Cloning and analyzing repositories..."
    python3 "$PROJECT_ROOT/construct_multi_repo_hypergraph.py" \
        --workspace "$WORKSPACE_DIR" \
        --output "$HYPERGRAPH_FILE"
fi

if [ $? -eq 0 ]; then
    echo -e "${GREEN}✓ Hypergraph construction complete${NC}"
else
    echo -e "${RED}✗ Hypergraph construction failed${NC}"
    exit 1
fi

# Step 2: Generate Visualizations
echo ""
echo -e "${YELLOW}Step 2: Generating Visualizations${NC}"
echo "─────────────────────────────────────────────────────────────"

# Copy to a standard name for visualization
cp "$HYPERGRAPH_FILE" "$OUTPUT_DIR/multi_repo_hypergraph.json"

python3 "$PROJECT_ROOT/visualize_multi_repo_hypergraph.py" \
    "$OUTPUT_DIR/multi_repo_hypergraph.json"

if [ $? -eq 0 ]; then
    echo -e "${GREEN}✓ Visualizations generated${NC}"
else
    echo -e "${RED}✗ Visualization generation failed${NC}"
    exit 1
fi

# Step 3: Generate Summary Report
echo ""
echo -e "${YELLOW}Step 3: Generating Summary Report${NC}"
echo "─────────────────────────────────────────────────────────────"

REPORT_FILE="$OUTPUT_DIR/ecosystem_report_${TIMESTAMP}.txt"

cat > "$REPORT_FILE" << EOF
Multi-Repository Ecosystem Analysis Report
==========================================

Generated: $(date)
Hypergraph File: $(basename "$HYPERGRAPH_FILE")

Summary Statistics:
$(python3 -c "
import json
with open('$HYPERGRAPH_FILE') as f:
    data = json.load(f)
    metrics = data.get('unified_metrics', {})
    print(f\"  Total Repositories: {metrics.get('total_repositories', 0)}\")
    print(f\"  Total Nodes: {metrics.get('total_nodes', 0)}\")
    print(f\"  Total Edges: {metrics.get('total_edges', 0)}\")
    print(f\"  Cross-Repo Nodes: {metrics.get('cross_repo_nodes', 0)}\")
    print(f\"  Cross-Repo Edges: {metrics.get('cross_repo_edges', 0)}\")
")

Repositories Analyzed:
$(python3 -c "
import json
with open('$HYPERGRAPH_FILE') as f:
    data = json.load(f)
    for repo in data.get('unified_metrics', {}).get('repositories_analyzed', []):
        print(f\"  • {repo}\")
")

Generated Files:
  • Hypergraph JSON: $(basename "$HYPERGRAPH_FILE")
  • Comparison Chart: multi_repo_comparison.png
  • Relationships: multi_repo_relationships.png
  • Metrics Dashboard: multi_repo_metrics_dashboard.png
  • Shared Concepts: multi_repo_shared_concepts.png
  • This Report: $(basename "$REPORT_FILE")

EOF

echo -e "${GREEN}✓ Summary report generated${NC}"

# Step 4: Display Results
echo ""
echo -e "${YELLOW}Step 4: Analysis Complete${NC}"
echo "─────────────────────────────────────────────────────────────"
echo ""
echo -e "${GREEN}✓ All steps completed successfully!${NC}"
echo ""
echo "Generated files in: $OUTPUT_DIR"
echo ""
ls -lh "$OUTPUT_DIR" | grep -E "(multi_repo|ecosystem)" || true
echo ""
echo -e "${BLUE}Next Steps:${NC}"
echo "  1. Review the summary report: $REPORT_FILE"
echo "  2. View visualizations in: $OUTPUT_DIR"
echo "  3. Explore hypergraph JSON: $HYPERGRAPH_FILE"
echo ""
echo -e "${YELLOW}Tips:${NC}"
echo "  • Run with --skip-clone for faster repeated analysis"
echo "  • Customize output with: export OUTPUT_DIR=/your/path"
echo "  • See documentation: MULTI_REPO_HYPERGRAPH_INTEGRATION.md"
echo ""
echo -e "${BLUE}════════════════════════════════════════════════════════════════${NC}"
