#!/usr/bin/env sh
# Minimal agent installation for prompt-engineering
#
# Usage: ./QUICKSTART.sh /path/to/workspace
#
# Creates only .github/agents/ with symlinked agents and README.

set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
AGENTS_DIR="$SCRIPT_DIR/agents/compiled"

# Validate target
TARGET="$(cd "$1" 2>/dev/null && pwd)" || { echo "Usage: $0 /path/to/workspace"; exit 1; }
TARGET_AGENTS="$TARGET/.github/agents"

echo "Installing prompt-engineering agents..."
echo "  Source: $SCRIPT_DIR"
echo "  Target: $TARGET"
echo ""

# Create .github/agents/
mkdir -p "$TARGET_AGENTS"

# Clean deprecated structures from older installations
rm -rf "$TARGET_AGENTS/lib" 2>/dev/null || true

# Symlink agent files
for agent in "$AGENTS_DIR"/*.agent.md; do
    name="$(basename "$agent")"
    ln -sf "$agent" "$TARGET_AGENTS/$name"
    echo "✓ .github/agents/$name"
done

# Store source path for on-demand features
echo "$SCRIPT_DIR" > "$TARGET_AGENTS/.source"

# Create README
cat > "$TARGET_AGENTS/README.md" << 'EOF'
# GitHub Copilot Agents

Symlinked from prompt-engineering repo.

## Usage
Use @Orchestrator, @Implementer, or @Compiler in VS Code.

## Feedback
Create files in feedback/ to report issues or suggest improvements.
Files are auto-gitignored.
EOF
echo "✓ .github/agents/README.md"

# Create feedback folder with gitignore
mkdir -p "$TARGET_AGENTS/feedback"
echo "*" > "$TARGET_AGENTS/feedback/.gitignore"

echo ""
echo "Feedback? Drop files in .github/agents/feedback/"
echo ""
echo "Done. Use @Orchestrator in VS Code."
