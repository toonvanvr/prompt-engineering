#!/usr/bin/env sh
# Minimal agent installation for prompt-engineering
#
# Usage: ./QUICKSTART.sh /path/to/workspace
#
# Creates:
# - .github/agents/ with symlinked agents
# - .human/ folder structure with templates
# - .gitignore entries for agent symlinks

set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
AGENTS_DIR="$SCRIPT_DIR/agents/compiled"
HUMAN_DIR="$SCRIPT_DIR/.human"

# Validate target
TARGET="$(cd "$1" 2>/dev/null && pwd)" || { echo "Usage: $0 /path/to/workspace"; exit 1; }
TARGET_AGENTS="$TARGET/.github/agents"
TARGET_HUMAN="$TARGET/.human"

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

## Human Override
Place instruction files in `.human/instructions/` to provide async feedback.
Templates available in `.human/templates/`.

## Feedback
Create files in feedback/ to report issues or suggest improvements.
Files are auto-gitignored.
EOF
echo "✓ .github/agents/README.md"

# Create feedback folder with gitignore
mkdir -p "$TARGET_AGENTS/feedback"
echo "*" > "$TARGET_AGENTS/feedback/.gitignore"

# --- .human/ folder structure ---
echo ""
mkdir -p "$TARGET_HUMAN/instructions"
mkdir -p "$TARGET_HUMAN/templates"

# Copy templates (don't overwrite if exist)
if [ -d "$HUMAN_DIR/templates" ]; then
    for tmpl in "$HUMAN_DIR/templates"/*.md; do
        name="$(basename "$tmpl")"
        if [ ! -f "$TARGET_HUMAN/templates/$name" ]; then
            cp "$tmpl" "$TARGET_HUMAN/templates/$name"
            echo "✓ .human/templates/$name"
        else
            echo "⊘ .human/templates/$name (exists)"
        fi
    done
fi

# Copy instructions README if not exists
if [ -f "$HUMAN_DIR/instructions/README.md" ] && [ ! -f "$TARGET_HUMAN/instructions/README.md" ]; then
    cp "$HUMAN_DIR/instructions/README.md" "$TARGET_HUMAN/instructions/README.md"
    echo "✓ .human/instructions/README.md"
fi

# --- .gitignore handling ---
echo ""
GITIGNORE="$TARGET/.gitignore"
AGENT_IGNORES=".github/agents/orchestrator.agent.md
.github/agents/implementer.agent.md
.github/agents/compiler.agent.md"

# Create or append to .gitignore
if [ ! -f "$GITIGNORE" ]; then
    # Create new .gitignore
    cat > "$GITIGNORE" << EOF
# AI agent symlinks (from prompt-engineering)
.github/agents/orchestrator.agent.md
.github/agents/implementer.agent.md
.github/agents/compiler.agent.md
EOF
    echo "✓ .gitignore (created)"
else
    # Append missing entries
    added=0
    for entry in $AGENT_IGNORES; do
        if ! grep -qxF "$entry" "$GITIGNORE" 2>/dev/null; then
            # Add header comment if first addition
            if [ $added -eq 0 ]; then
                echo "" >> "$GITIGNORE"
                echo "# AI agent symlinks (from prompt-engineering)" >> "$GITIGNORE"
            fi
            echo "$entry" >> "$GITIGNORE"
            added=$((added + 1))
        fi
    done
    if [ $added -gt 0 ]; then
        echo "✓ .gitignore (added $added entries)"
    else
        echo "⊘ .gitignore (entries exist)"
    fi
fi

echo ""
echo "Human override: .human/instructions/ (copy from templates/)"
echo "Feedback: .github/agents/feedback/"
echo ""
echo "Done. Use @Orchestrator in VS Code."
