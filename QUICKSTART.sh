#!/usr/bin/env sh
# Install prompt-engineering agents into a target workspace
#
# Usage: ./QUICKSTART.sh /path/to/workspace
#
# This script:
# 1. Symlinks individual *.agent.md files → .github/agents/
# 2. Symlinks lib/templates/ → .github/agents/lib/
# 3. Scaffolds .human/ folder (copies templates, overwrites with newer versions)

set -e

# Get the directory where this script lives (the prompt-engineering repo)
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
AGENTS_DIR="$SCRIPT_DIR/agents/compiled"
TEMPLATES_DIR="$SCRIPT_DIR/agents/templates"
HUMAN_DIR="$SCRIPT_DIR/.human"

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
TARGET_LIB="$TARGET_AGENTS/lib"
TARGET_HUMAN="$TARGET_WORKSPACE/.human"

echo "Installing prompt-engineering agents..."
echo "  Source: $SCRIPT_DIR"
echo "  Target: $TARGET_WORKSPACE"
echo ""

# Create .github/agents directory if needed
if [ ! -d "$TARGET_AGENTS" ]; then
    echo "Creating $TARGET_AGENTS/"
    mkdir -p "$TARGET_AGENTS"
elif [ -L "$TARGET_AGENTS" ]; then
    # Old-style symlink to entire folder - remove it
    echo "Removing old-style folder symlink..."
    rm "$TARGET_AGENTS"
    mkdir -p "$TARGET_AGENTS"
fi

# Symlink individual agent files
echo "Linking agents..."
for agent_file in "$AGENTS_DIR"/*.agent.md; do
    if [ -f "$agent_file" ]; then
        agent_name="$(basename "$agent_file")"
        target_link="$TARGET_AGENTS/$agent_name"
        
        if [ -L "$target_link" ]; then
            rm "$target_link"
        elif [ -f "$target_link" ]; then
            echo "  Backing up existing $agent_name"
            mv "$target_link" "$target_link.backup"
        fi
        
        ln -s "$agent_file" "$target_link"
        echo "  ✓ $agent_name"
    fi
done

# Create lib directory and symlink templates
echo ""
echo "Linking lib/templates..."
mkdir -p "$TARGET_LIB"

if [ -L "$TARGET_LIB/templates" ]; then
    rm "$TARGET_LIB/templates"
elif [ -d "$TARGET_LIB/templates" ]; then
    echo "  Backing up existing lib/templates"
    mv "$TARGET_LIB/templates" "$TARGET_LIB/templates.backup"
fi

ln -s "$TEMPLATES_DIR" "$TARGET_LIB/templates"
echo "  ✓ lib/templates → agents/templates"

# Scaffold .human folder (copy, not symlink - workspace-local)
echo ""
echo "Scaffolding .human/ folder..."

# Create structure
mkdir -p "$TARGET_HUMAN/instructions"
mkdir -p "$TARGET_HUMAN/processed"
mkdir -p "$TARGET_HUMAN/templates"

# Copy templates (overwrite with newer versions)
# This is the single documented command for auto-allow:
# cp -r overwrites existing files with source versions
cp -r "$HUMAN_DIR/templates/"* "$TARGET_HUMAN/templates/" 2>/dev/null || true
echo "  ✓ .human/instructions/"
echo "  ✓ .human/processed/"
echo "  ✓ .human/templates/ ($(ls -1 "$TARGET_HUMAN/templates/" 2>/dev/null | wc -l | tr -d ' ') templates)"

echo ""
echo "═══════════════════════════════════════════════════════"
echo "✓ Installation complete"
echo "═══════════════════════════════════════════════════════"
echo ""
echo "Installed agents:"
ls -1 "$TARGET_AGENTS"/*.agent.md 2>/dev/null | xargs -I {} basename {} .agent.md | sed 's/^/  • /'
echo ""
echo "Human instruction templates:"
ls -1 "$TARGET_HUMAN/templates/"*.md 2>/dev/null | xargs -I {} basename {} .md | sed 's/^/  • /'
echo ""
echo "Usage in VS Code with GitHub Copilot:"
echo "  @workspace Use the Orchestrator agent"
echo ""
echo "To inject instructions during task execution:"
echo "  Copy a template from .human/templates/ to .human/instructions/"
echo "  Edit checkboxes/values, save → agent processes at next checkpoint"
