#!/usr/bin/env sh
# Install prompt-engineering agents into a target workspace
#
# Usage: ./QUICKSTART.sh /path/to/workspace
#
# This creates a symlink from {workspace}/.github/agents to this repository's
# compiled agents, making them available for use in the target workspace.

set -e

# Get the directory where this script lives (the prompt-engineering repo)
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
AGENTS_DIR="$SCRIPT_DIR/agents/compiled"

# Validate arguments
if [ -z "$1" ]; then
    echo "Usage: $0 /path/to/workspace"
    echo ""
    echo "Example: $0 ~/work/cv"
    exit 1
fi

TARGET_WORKSPACE="$(cd "$1" 2>/dev/null && pwd)" || {
    echo "Error: Target workspace '$1' does not exist"
    exit 1
}

TARGET_GITHUB="$TARGET_WORKSPACE/.github"
TARGET_AGENTS="$TARGET_GITHUB/agents"

echo "Installing agents..."
echo "  Source: $AGENTS_DIR"
echo "  Target: $TARGET_AGENTS"
echo ""

# Create .github directory if needed
if [ ! -d "$TARGET_GITHUB" ]; then
    echo "Creating $TARGET_GITHUB/"
    mkdir -p "$TARGET_GITHUB"
fi

# Handle existing agents directory/symlink
if [ -L "$TARGET_AGENTS" ]; then
    CURRENT_LINK="$(readlink "$TARGET_AGENTS")"
    if [ "$CURRENT_LINK" = "$AGENTS_DIR" ]; then
        echo "✓ Already installed correctly"
        exit 0
    fi
    echo "Updating existing symlink (was: $CURRENT_LINK)"
    rm "$TARGET_AGENTS"
elif [ -d "$TARGET_AGENTS" ]; then
    echo "Warning: $TARGET_AGENTS exists as a directory"
    echo "  Backing up to $TARGET_AGENTS.backup"
    mv "$TARGET_AGENTS" "$TARGET_AGENTS.backup"
elif [ -e "$TARGET_AGENTS" ]; then
    echo "Error: $TARGET_AGENTS exists but is not a directory or symlink"
    exit 1
fi

# Create symlink
ln -s "$AGENTS_DIR" "$TARGET_AGENTS"

echo ""
echo "✓ Agents installed successfully"
echo ""
echo "Available agents:"
ls -1 "$TARGET_AGENTS"/*.agent.md 2>/dev/null | xargs -I {} basename {} | sed 's/^/  - /'
echo ""
echo "To use in VS Code with GitHub Copilot:"
echo "  @workspace Use the Orchestrator agent"
