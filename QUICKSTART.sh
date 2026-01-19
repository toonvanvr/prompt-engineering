#!/usr/bin/env sh
# Agent installation for prompt-engineering
#
# Usage: ./QUICKSTART.sh /path/to/workspace
#
# Creates:
# - .github/agents/ with symlinked agents
# - .ai/ folder structure (library, scratch, feedback)
# - .gitignore entries for agent symlinks

set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
AGENTS_DIR="$SCRIPT_DIR/agents/compiled"
KERNEL_DIR="$SCRIPT_DIR/agents/kernel"
LIBRARY_DIR="$SCRIPT_DIR/.ai/library"

# Validate target
TARGET="$(cd "$1" 2>/dev/null && pwd)" || { echo "Usage: $0 /path/to/workspace"; exit 1; }
TARGET_AGENTS="$TARGET/.github/agents"
TARGET_AI="$TARGET/.ai"

# Detect self-install (installing into prompt-engineering repo itself)
SELF_INSTALL=false
if [ "$TARGET" = "$SCRIPT_DIR" ]; then
    SELF_INSTALL=true
    echo "Self-install detected (prompt-engineering repo)"
fi

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

# Symlink kernel directory (needed by agents for references)
# Skip in self-install to avoid creating symlink inside kernel directory itself
if [ "$SELF_INSTALL" = false ]; then
    ln -sf "$KERNEL_DIR" "$TARGET_AGENTS/kernel"
    echo "✓ .github/agents/kernel/ (symlinked)"
else
    echo "⊘ .github/agents/kernel/ (skipped - self-install)"
fi

# Skip README.md - it shows up as an agent in VS Code UI
# Documentation is in the main README.md and docs/ folder

# Create .gitignore for .github folder (ignore symlinked content)
cat > "$TARGET/.github/.gitignore" << 'AGENTIGNORE'
# Symlinked from prompt-engineering repo - ignored locally
/agents/compiler.agent.md
/agents/designer.agent.md
/agents/implementer.agent.md
/agents/orchestrator.agent.md
/agents/researcher.agent.md
/agents/kernel
/feedback
/lib
/.source
AGENTIGNORE
echo "✓ .github/.gitignore"

# Clean up legacy feedback folder in agents (now using .github/feedback symlink)
rm -rf "$TARGET_AGENTS/feedback" 2>/dev/null || true

# --- Symlinks for cross-tool compatibility ---
# VS Code Copilot reads .github/ for context; our knowledge lives in .ai/
echo ""
echo "Creating .github symlinks..."
ln -sfn ../.ai/library "$TARGET/.github/lib"
ln -sfn ../.ai/feedback "$TARGET/.github/feedback"
echo "✓ .github/lib -> .ai/library"
echo "✓ .github/feedback -> .ai/feedback"

# --- .ai/ folder structure ---
echo ""
mkdir -p "$TARGET_AI/scratch"
mkdir -p "$TARGET_AI/feedback"
mkdir -p "$TARGET_AI/memory"
mkdir -p "$TARGET_AI/library/skills"
mkdir -p "$TARGET_AI/library/patterns"
mkdir -p "$TARGET_AI/library/research"
mkdir -p "$TARGET_AI/library/domain"
mkdir -p "$TARGET_AI/library/quirks"

# Create library index (skip for self-install - already exists)
if [ "$SELF_INSTALL" = false ]; then
cat > "$TARGET_AI/library/index.md" << 'EOF'
# Library Index

Knowledge persistence layer. See `agents/kernel/library-system.md`.

## Structure

|Folder|Purpose|Format|
|-|-|-|
|`skills/`|HOW to do things|SKILL.md (Agent Skills standard)|
|`patterns/`|WHAT works|Markdown|
|`research/`|WHY things are|Markdown|
|`domain/`|WHAT things mean|Markdown|
|`quirks/`|WHAT to watch out for|Markdown|

## Usage

- Agents scan skills at startup
- New knowledge added during execution
- Maintain with `maintain-library` skill
EOF
echo "✓ .ai/library/index.md"
fi

# Symlink maintain-library skill if exists (skip for self-install - already there)
if [ "$SELF_INSTALL" = false ] && [ -d "$LIBRARY_DIR/skills/maintain-library" ]; then
    mkdir -p "$TARGET_AI/library/skills"
    ln -sf "$LIBRARY_DIR/skills/maintain-library" "$TARGET_AI/library/skills/maintain-library"
    echo "✓ .ai/library/skills/maintain-library (symlinked)"
fi

# Create instructions README (skip for self-install - already exists)
if [ "$SELF_INSTALL" = false ]; then
cat > "$TARGET_AI/library/README.md" << 'EOF'
# AI Library

Per-repo knowledge persistence. Grows organically during agent execution.

## Folders

- `skills/` — Teachable procedures (SKILL.md format)
- `patterns/` — Reusable solutions
- `research/` — Investigation findings
- `domain/` — Business/technical concepts
- `quirks/` — Tool oddities and workarounds

## Adding Knowledge

Agents add knowledge automatically during execution.
Manual additions welcome — use appropriate folder.

## Maintenance

Run library maintenance skill periodically:
"Review the library and update outdated skills"
EOF
echo "✓ .ai/library/README.md"
fi

# Create feedback files with headers
for category in tool_quirks pattern_successes pattern_failures scope_overruns escalations human_interventions; do
    file="$TARGET_AI/feedback/${category}.md"
    if [ ! -f "$file" ]; then
        printf "# %s\n\nAutomatically collected feedback. See docs/feedback.md for format.\n\n---\n\n" "$category" > "$file"
        echo "✓ .ai/feedback/${category}.md"
    fi
done

# Note: No sync-feedback.sh needed - .github/feedback is symlinked to .ai/feedback

# --- .ai/.gitignore handling ---
# Create .ai/.gitignore for ignoring dynamic content
echo ""
cat > "$TARGET_AI/.gitignore" << 'AIIGNORE'
# .ai/ plugin gitignore
# These subdirectories contain dynamic/local content and should be ignored
/feedback/
/scratch/
/memory/
/library/
/.gitignore
AIIGNORE
echo "✓ .ai/.gitignore"

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "Installation complete!"
echo ""
echo "Agents:        @orchestrator, @researcher, @designer, @implementer"
echo "Communication: .ai/scratch/{session}/communication/human_input.md"
echo "Library:       .ai/library/ (symlinked via .github/lib)"
echo "Feedback:      .ai/feedback/ (symlinked via .github/feedback)"
echo ""
echo "Open VS Code → Copilot Chat → Agent mode → @orchestrator"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
