#!/bin/bash

# Ensure Required GitHub Labels Exist
# This script creates labels if they don't already exist in the repository.
# Usage: ./ensure-labels.sh [label1:color1:description1] [label2:color2:description2] ...
#
# Example:
#   ./ensure-labels.sh "feature:0052CC:Feature request" "needs-triage:FFCC00:Requires triage"
#
# If no arguments are provided, it creates a default set of common labels.

set -e

# Color codes for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Default labels if none specified
DEFAULT_LABELS=(
    "feature:0052CC:Feature request"
    "needs-triage:FFCC00:Requires triage"
    "bug:d73a4a:Something isn't working"
    "enhancement:a2eeef:New feature or request"
    "documentation:0075ca:Improvements or additions to documentation"
    "todo:1d76db:To do items"
    "task:c5def5:Task item"
    "hierarchical-task:bfdadc:Hierarchical task"
    "priority: critical:d73a4a:Critical priority"
    "priority: high:ff9800:High priority"
    "priority: medium:ffc107:Medium priority"
    "priority: low:8bc34a:Low priority"
    "weight-high:e91e63:High weight (90-100)"
    "weight-medium:ff9800:Medium weight (60-89)"
    "weight-low:ffeb3b:Low weight (0-59)"
    "rank-1:1a237e:Rank 1 (highest)"
    "rank-2:303f9f:Rank 2"
    "rank-3:3f51b5:Rank 3"
    "legal-defense:5c6bc0:Legal defense argument"
    "legal-counterclaim:7986cb:Legal counterclaim"
    "legal-evidence:9fa8da:Legal evidence"
)

# Function to create a label
create_label() {
    local label_spec="$1"
    
    # Parse label specification (format: name:color:description)
    IFS=':' read -r name color description <<< "$label_spec"
    
    # Trim whitespace
    name=$(echo "$name" | xargs)
    color=$(echo "$color" | xargs)
    description=$(echo "$description" | xargs)
    
    # Validate inputs
    if [ -z "$name" ]; then
        echo -e "${RED}❌ Error: Label name cannot be empty${NC}"
        return 1
    fi
    
    # Set default color if not provided
    if [ -z "$color" ]; then
        color="cccccc"
    fi
    
    # Set default description if not provided
    if [ -z "$description" ]; then
        description="$name"
    fi
    
    # Try to create the label
    echo -ne "  Creating label '${BLUE}${name}${NC}'... "
    
    if gh label create "$name" --color "$color" --description "$description" 2>/dev/null; then
        echo -e "${GREEN}✓ Created${NC}"
        return 0
    else
        # Label might already exist, check
        if gh label list --json name --jq '.[].name' | grep -Fxq "$name"; then
            echo -e "${YELLOW}⚠ Already exists${NC}"
            return 0
        else
            echo -e "${RED}✗ Failed${NC}"
            return 1
        fi
    fi
}

# Main execution
main() {
    echo -e "${BLUE}🏷️  Ensuring required GitHub labels exist...${NC}\n"
    
    # Check if gh CLI is available
    if ! command -v gh &> /dev/null; then
        echo -e "${RED}❌ Error: GitHub CLI (gh) is not installed${NC}"
        echo "Please install it from https://cli.github.com/"
        exit 1
    fi
    
    # Check if GH_TOKEN is set
    if [ -z "$GH_TOKEN" ]; then
        echo -e "${YELLOW}⚠ Warning: GH_TOKEN environment variable is not set${NC}"
        echo "This might cause authentication issues in CI/CD environments"
    fi
    
    # Determine which labels to create
    local labels_to_create=()
    
    if [ $# -eq 0 ]; then
        # No arguments, use default labels
        echo -e "${YELLOW}ℹ No labels specified, using default set${NC}\n"
        labels_to_create=("${DEFAULT_LABELS[@]}")
    else
        # Use provided labels
        labels_to_create=("$@")
    fi
    
    # Create labels
    local created=0
    local skipped=0
    local failed=0
    
    for label_spec in "${labels_to_create[@]}"; do
        if create_label "$label_spec"; then
            if [[ $(create_label "$label_spec" 2>&1) == *"Already exists"* ]]; then
                ((skipped++))
            else
                ((created++))
            fi
        else
            ((failed++))
        fi
    done
    
    # Summary
    echo -e "\n${BLUE}═══════════════════════════════════════${NC}"
    echo -e "${GREEN}✅ Labels verified: ${created} created, ${skipped} existed, ${failed} failed${NC}"
    echo -e "${BLUE}═══════════════════════════════════════${NC}"
    
    # Exit with error if any failed
    if [ $failed -gt 0 ]; then
        exit 1
    fi
}

# Run main function
main "$@"
