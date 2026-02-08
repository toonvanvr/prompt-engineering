#!/usr/bin/env bash
# prompt-engineering installer — https://github.com/toonvanvr/prompt-engineering
# Install AI agents into a project. Works via curl pipe or local clone.
set -euo pipefail

REPO="toonvanvr/prompt-engineering"
GITHUB_API="https://api.github.com/repos/$REPO/releases"

TMP_DIR=""
cleanup() { [[ -n "$TMP_DIR" ]] && rm -rf "$TMP_DIR"; }
trap cleanup EXIT

log() { echo "  $*"; }

# ── Argument parsing ─────────────────────────────────────────────────────────

parse_args() {
  TARGET=""
  VERSION="latest"

  for arg in "$@"; do
    case "$arg" in
      --version=*) VERSION="${arg#--version=}" ;;
      -*) echo "Error: Unknown option '$arg'" >&2; exit 1 ;;
      *) TARGET="$arg" ;;
    esac
  done

  if [[ -z "$TARGET" ]]; then
    echo "Usage: install.sh <target-directory> [--version=X.Y.Z]" >&2
    echo "" >&2
    echo "Examples:" >&2
    echo "  ./bin/install.sh /path/to/project" >&2
    echo "  curl -fsSL ... | bash -s -- /path/to/project --version=2.0.0" >&2
    exit 1
  fi
}

# ── Target resolution ────────────────────────────────────────────────────────

resolve_target() {
  local raw="$1"
  TARGET="$(cd "$raw" 2>/dev/null && pwd)" || {
    echo "Error: directory '$raw' does not exist" >&2
    exit 1
  }
}

# ── Context detection ────────────────────────────────────────────────────────

detect_context() {
  CONTEXT="remote"
  SOURCE=""

  if [[ -n "${BASH_SOURCE[0]:-}" ]] && [[ -f "${BASH_SOURCE[0]}" ]]; then
    local script_dir
    script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
    if [[ -f "$script_dir/VERSION" ]]; then
      SOURCE="$script_dir"
      CONTEXT="local"
      if [[ "$TARGET" == "$SOURCE" ]]; then
        CONTEXT="self"
      fi
      if [[ "$VERSION" == "latest" ]]; then
        VERSION="$(cat "$SOURCE/VERSION")"
      fi
    fi
  fi

  if [[ "$CONTEXT" == "remote" ]]; then
    TMP_DIR="$(mktemp -d)"
    SOURCE="$TMP_DIR"
  fi
}

# ── Version resolution ───────────────────────────────────────────────────────

resolve_version() {
  local version="$1"
  if [[ "$version" == "latest" ]]; then
    curl -fsSL "$GITHUB_API/latest" | grep '"tag_name"' | sed 's/.*"v\(.*\)".*/\1/'
  else
    echo "$version"
  fi
}

# ── Download & extract ───────────────────────────────────────────────────────

download_release() {
  local version="$1" dest="$2"
  local url="https://github.com/$REPO/releases/download/v${version}/prompt-engineering-v${version}.tar.gz"
  echo "Downloading v${version}..."
  curl -fsSL "$url" -o "$dest/release.tar.gz" || {
    echo "Error: Failed to download v${version}" >&2
    echo "  URL: $url" >&2
    exit 1
  }
}

extract_release() {
  local archive="$1" dest="$2"
  tar xzf "$archive" -C "$dest" --strip-components=1
}

# ── Install functions ────────────────────────────────────────────────────────

install_agents() {
  mkdir -p "$TARGET/.github/agents"
  cp "$SOURCE/agents/compiled/"*.agent.md "$TARGET/.github/agents/"
  log "✓ .github/agents/*.agent.md"
}

install_kernel() {
  rm -rf "$TARGET/.github/agents/kernel"
  cp -r "$SOURCE/agents/kernel" "$TARGET/.github/agents/kernel"
  rm -f "$TARGET/.github/agents/kernel/kernel"
  log "✓ .github/agents/kernel/"
}

install_skills() {
  if [[ -d "$TARGET/.github/skills" ]]; then
    log "⊘ .github/skills/ (exists — skipped)"
    return
  fi
  if [[ -d "$SOURCE/.github/skills" ]]; then
    cp -r "$SOURCE/.github/skills" "$TARGET/.github/skills"
    log "✓ .github/skills/"
  fi
}

write_version_marker() {
  mkdir -p "$TARGET/.github/agents"
  cat > "$TARGET/.github/agents/.tvv-pe" << EOF
version=$VERSION
installed=$(date -u +%Y-%m-%dT%H:%M:%SZ)
EOF
  log "✓ .github/agents/.tvv-pe (v$VERSION)"
}

# ── Directory structure ──────────────────────────────────────────────────────

ensure_directories() {
  local dirs=(".ai/scratch" ".ai/feedback" ".ai/library/patterns" ".ai/library/domain" ".ai/library/quirks")
  for dir in "${dirs[@]}"; do
    mkdir -p "$TARGET/$dir"
  done
  log "✓ .ai/ directories"
}

# ── Gitignore management ────────────────────────────────────────────────────

ensure_gitignore_line() {
  local file="$1" line="$2"
  grep -qxF "$line" "$file" 2>/dev/null || echo "$line" >> "$file"
}

ensure_gitignore() {
  local scope="$1"
  local file="$TARGET/.$scope/.gitignore"
  mkdir -p "$(dirname "$file")"
  touch "$file"

  if [[ "$scope" == "github" ]]; then
    ensure_gitignore_line "$file" "# Installed by prompt-engineering — https://github.com/toonvanvr/prompt-engineering"
    ensure_gitignore_line "$file" "/.gitignore"
    ensure_gitignore_line "$file" "/agents/"
    ensure_gitignore_line "$file" "/skills/"
  elif [[ "$scope" == "ai" ]]; then
    ensure_gitignore_line "$file" "# Installed by prompt-engineering — https://github.com/toonvanvr/prompt-engineering"
    ensure_gitignore_line "$file" "/.gitignore"
    ensure_gitignore_line "$file" "*"
  fi

  log "✓ .$scope/.gitignore"
}

# ── VS Code settings ────────────────────────────────────────────────────────

configure_vscode() {
  local settings_dir="$TARGET/.vscode"
  local settings_file="$settings_dir/settings.json"
  mkdir -p "$settings_dir"

  local recommended='{
  "chat.customAgentInSubagent.enabled": true,
  "chat.agent.thinking.collapsedTools": true,
  "chat.tools.autoExpandFailures": true,
  "chat.useAgentSkills": true,
  "github.copilot.chat.searchSubagent.enabled": true,
  "github.copilot.chat.copilotMemory.enabled": true,
  "github.copilot.chat.anthropic.thinking.budgetTokens": 10000,
  "github.copilot.chat.anthropic.toolSearchTool.enabled": true,
  "github.copilot.chat.anthropic.contextEditing.enabled": true,
  "github.copilot.chat.githubMcpServer.enabled": true,
  "chat.tools.terminal.sandbox.enabled": true,
  "chat.tools.terminal.autoApproveWorkspaceNpmScripts": true,
  "chat.tools.terminal.preventShellHistory": true
}'

  if [[ -f "$settings_file" ]]; then
    if command -v jq >/dev/null 2>&1; then
      local merged
      # Attempt to merge; if jq cannot parse the existing file (e.g., contains comments / JSONC),
      # warn and skip merging instead of failing the installer.
      if merged=$(jq -s '.[0] * .[1]' <(echo "$recommended") "$settings_file" 2>/dev/null); then
        echo "$merged" > "$settings_file"
        log "✓ .vscode/settings.json (merged)"
      else
        log "⚠ .vscode/settings.json could not be parsed by jq (likely contains comments / JSONC). Skipping merge."
        log "  Recommended settings:"
        echo "$recommended" | sed 's/^/    /'
      fi
    else
      log "⚠ .vscode/settings.json exists — install jq to merge settings automatically"
      log "  Recommended settings:"
      echo "$recommended" | sed 's/^/    /'
    fi
  else
    echo "$recommended" > "$settings_file"
    log "✓ .vscode/settings.json (created)"
  fi
}

# ── Summary ──────────────────────────────────────────────────────────────────

show_summary() {
  echo ""
  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  echo "Installation complete! (v$VERSION)"
  echo ""
  echo "  Agent: @orchestrator (only user-facing agent)"
  echo "  Mode:  Open VS Code → Copilot Chat → Agent mode"
  echo ""
  echo "  All installed files are gitignored — run installer per checkout."
  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
}

# ── Main ─────────────────────────────────────────────────────────────────────

main() {
  parse_args "$@"
  resolve_target "$TARGET"
  detect_context

  echo "prompt-engineering installer"
  echo "  Target: $TARGET"
  echo "  Context: $CONTEXT"

  if [[ "$CONTEXT" == "remote" ]]; then
    VERSION=$(resolve_version "$VERSION")
    download_release "$VERSION" "$TMP_DIR"
    extract_release "$TMP_DIR/release.tar.gz" "$TMP_DIR"
  fi

  echo "  Version: $VERSION"
  echo ""

  if [[ "$CONTEXT" != "self" ]]; then
    install_agents
    install_kernel
  else
    log "⊘ Agent/kernel copy skipped (self-install)"
  fi

  install_skills
  write_version_marker
  ensure_directories
  ensure_gitignore "github"
  ensure_gitignore "ai"
  configure_vscode
  show_summary
}

main "$@"
