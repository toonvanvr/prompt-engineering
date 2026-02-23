#!/usr/bin/env bash
# prompt-engineering installer — https://github.com/toonvanvr/prompt-engineering
# Install AI agents into a project. Works via curl pipe or local clone.
# Supports change detection, multiple modes, and per-file reporting.
set -euo pipefail

REPO="toonvanvr/prompt-engineering"
GITHUB_API="https://api.github.com/repos/$REPO/releases"

TMP_DIR=""
MODE="install"
VERBOSE=false
DRY_RUN=false
NEW_COUNT=0
UPDATED_COUNT=0
UNCHANGED_COUNT=0

cleanup() {
  if [[ -n "$TMP_DIR" ]]; then
    rm -rf "$TMP_DIR"
  fi
  return 0
}
trap cleanup EXIT

log() { echo "  $*"; }

# ── Argument parsing ─────────────────────────────────────────────────────────

parse_args() {
  TARGET=""
  VERSION="latest"

  for arg in "$@"; do
    case "$arg" in
      --version=*) VERSION="${arg#--version=}" ;;
      --mode=*)    MODE="${arg#--mode=}" ;;
      --verbose)   VERBOSE=true ;;
      -*) echo "Error: Unknown option '$arg'" >&2; exit 1 ;;
      *) TARGET="$arg" ;;
    esac
  done

  case "$MODE" in
    install|update|check|uninstall) ;;
    *) echo "Error: Unknown mode '$MODE' (use install|update|check|uninstall)" >&2; exit 1 ;;
  esac

  [[ "$MODE" == "check" ]] && DRY_RUN=true

  if [[ -z "$TARGET" ]]; then
    echo "Usage: install.sh <target-directory> [options]" >&2
    echo "" >&2
    echo "Options:" >&2
    echo "  --version=X.Y.Z    Install specific version (default: latest)" >&2
    echo "  --mode=MODE        install (default) | update | check | uninstall" >&2
    echo "  --verbose          Show unchanged files" >&2
    echo "" >&2
    echo "Modes:" >&2
    echo "  install    Full install with change detection (default)" >&2
    echo "  update     Only update agent and kernel files" >&2
    echo "  check      Dry-run — report what would change (exit 1 if outdated)" >&2
    echo "  uninstall  Remove all installed files" >&2
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

# ── Change detection ─────────────────────────────────────────────────────────

copy_if_changed() {
  local src="$1" dest="$2" label="$3"
  if [[ ! -f "$dest" ]]; then
    [[ "$DRY_RUN" != "true" ]] && cp "$src" "$dest"
    log "+ $label (new)"
    ((NEW_COUNT++)) || true
  elif ! cmp -s "$src" "$dest"; then
    [[ "$DRY_RUN" != "true" ]] && cp "$src" "$dest"
    log "↑ $label (updated)"
    ((UPDATED_COUNT++)) || true
  else
    [[ "$VERBOSE" == "true" ]] && log "✓ $label (unchanged)"
    ((UNCHANGED_COUNT++)) || true
  fi
}

# ── Install functions ────────────────────────────────────────────────────────

install_agents() {
  [[ "$DRY_RUN" != "true" ]] && mkdir -p "$TARGET/.github/agents"
  local count=0
  for f in "$SOURCE/agents/compiled/"*.agent.md; do
    [[ -f "$f" ]] || continue
    local name
    name="$(basename "$f")"
    copy_if_changed "$f" "$TARGET/.github/agents/$name" ".github/agents/$name"
    ((count++)) || true
  done
  if [[ $count -eq 0 ]]; then
    log "✗ No compiled agents found"
    exit 1
  fi
}

install_kernel() {
  [[ "$DRY_RUN" != "true" ]] && mkdir -p "$TARGET/.github/agents/kernel"
  for f in "$SOURCE/agents/kernel/"*.md; do
    [[ -f "$f" ]] || continue
    local name
    name="$(basename "$f")"
    copy_if_changed "$f" "$TARGET/.github/agents/kernel/$name" ".github/agents/kernel/$name"
  done
}

install_skills() {
  if [[ -d "$TARGET/.github/skills" ]]; then
    log "⊘ .github/skills/ (exists — skipped)"
    return
  fi
  if [[ -d "$SOURCE/.github/skills" ]]; then
    cp -r "$SOURCE/.github/skills" "$TARGET/.github/skills"
    log "+ .github/skills/ (new)"
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

# ── Pipeline staleness check ─────────────────────────────────────────────────

check_staleness() {
  [[ "$CONTEXT" == "local" || "$CONTEXT" == "self" ]] || return 0
  local warn=0
  for src_file in "$SOURCE/agents/source/"*.src.md; do
    [[ -f "$src_file" ]] || continue
    local base
    base="$(basename "$src_file" .src.md)"
    local pre_file="$SOURCE/agents/precompiled/${base}.pre.md"
    local agent_file="$SOURCE/agents/compiled/${base}.agent.md"
    if [[ -f "$pre_file" ]] && [[ "$src_file" -nt "$pre_file" ]]; then
      log "⚠ ${base}: source newer than precompiled — recompile needed"
      ((warn++)) || true
    fi
    if [[ -f "$pre_file" ]] && [[ -f "$agent_file" ]] && [[ "$pre_file" -nt "$agent_file" ]]; then
      log "⚠ ${base}: precompiled newer than compiled — recompile needed"
      ((warn++)) || true
    fi
  done
  [[ $warn -gt 0 ]] && log "⚠ $warn stale file(s) — run compiler before installing"
  return 0
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
  local install_context="${2:-}"
  local file="$TARGET/.$scope/.gitignore"
  mkdir -p "$(dirname "$file")"
  touch "$file"

  if [[ "$scope" == "github" ]]; then
    ensure_gitignore_line "$file" "# Installed by prompt-engineering — https://github.com/toonvanvr/prompt-engineering"
    ensure_gitignore_line "$file" "# Agent files are compiled outputs — regenerate via bin/install.sh"
    ensure_gitignore_line "$file" "/agents/compiler.agent.md"
    ensure_gitignore_line "$file" "/agents/designer.agent.md"
    ensure_gitignore_line "$file" "/agents/implementer.agent.md"
    ensure_gitignore_line "$file" "/agents/orchestrator.agent.md"
    ensure_gitignore_line "$file" "/agents/researcher.agent.md"
    ensure_gitignore_line "$file" "/agents/kernel/"
    ensure_gitignore_line "$file" "/agents/.tvv-pe"
    ensure_gitignore_line "$file" "/.gitignore"
    # Only gitignore skills in external projects (they're source files in this repo)
    if [[ "$install_context" != "self" ]]; then
      ensure_gitignore_line "$file" "/skills/"
    fi
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

  # Recommended settings: key|value|value_pattern (pattern used for conflict check)
  local settings=(
    'chat.customAgentInSubagent.enabled|true|true'
    'chat.tools.autoExpandFailures|true|true'
    'chat.useAgentSkills|true|true'
    'github.copilot.chat.searchSubagent.enabled|true|true'
    'github.copilot.chat.copilotMemory.enabled|true|true'
    'github.copilot.chat.anthropic.thinking.budgetTokens|32000|32000'
    'github.copilot.chat.anthropic.toolSearchTool.enabled|true|true'
    'github.copilot.chat.anthropic.contextEditing.enabled|true|true'
    'github.copilot.chat.githubMcpServer.enabled|true|true'
    'chat.tools.terminal.sandbox.enabled|false|false'
    'chat.tools.terminal.autoApproveWorkspaceNpmScripts|true|true'
    'chat.tools.terminal.preventShellHistory|true|true'
  )

  # Write fresh file if missing or empty JSON (no actual settings keys)
  local write_fresh=false
  if [[ ! -f "$settings_file" ]]; then
    write_fresh=true
  elif ! grep -q '"[a-zA-Z]' "$settings_file"; then
    # File exists but contains no setting keys (e.g., just "{}" or "{ }")
    write_fresh=true
  fi

  if [[ "$write_fresh" == "true" ]]; then
    echo "{" > "$settings_file"
    for entry in "${settings[@]}"; do
      local key="${entry%%|*}"
      local value="${entry#*|}"; value="${value%%|*}"
      echo "  \"$key\": $value," >> "$settings_file"
    done
    echo "}" >> "$settings_file"
    log "✓ .vscode/settings.json (created)"
    return
  fi

  # File exists with content — grep each key
  local added=0 conflicts=0 existing=0

  for entry in "${settings[@]}"; do
    local key="${entry%%|*}"
    local value="${entry#*|}"; value="${value%%|*}"
    local value_pattern="${entry##*|}"

    if grep -q "\"$key\"" "$settings_file"; then
      # Key exists — check if value matches
      local existing_line
      existing_line=$(grep "\"$key\"" "$settings_file")
      if echo "$existing_line" | grep -q "$value_pattern"; then
        ((existing++)) || true
      else
        ((conflicts++)) || true
        log "⚠ $key — conflict (existing value differs, skipping)"
      fi
    else
      # Key missing — insert before last line containing }
      local line_num
      line_num=$(grep -n "}" "$settings_file" | tail -1 | cut -d: -f1)
      if [[ -n "$line_num" ]]; then
        sed -i "${line_num}i\\  \"$key\": $value," "$settings_file"
        ((added++)) || true
        log "+ $key (added)"
      fi
    fi
  done

  log "✓ .vscode/settings.json ($added added, $existing existing, $conflicts conflicts)"
}

# ── Uninstall ────────────────────────────────────────────────────────────────

run_uninstall() {
  local removed=0 absent=0

  # Agent files
  local agent_files=(
    ".github/agents/compiler.agent.md"
    ".github/agents/designer.agent.md"
    ".github/agents/implementer.agent.md"
    ".github/agents/orchestrator.agent.md"
    ".github/agents/researcher.agent.md"
    ".github/agents/.tvv-pe"
  )

  for f in "${agent_files[@]}"; do
    if [[ -f "$TARGET/$f" ]]; then
      rm "$TARGET/$f"
      log "- $f (removed)"
      ((removed++)) || true
    else
      [[ "$VERBOSE" == "true" ]] && log "⊘ $f (absent)"
      ((absent++)) || true
    fi
  done

  # Kernel files — remove each .md individually
  if [[ -d "$TARGET/.github/agents/kernel" ]]; then
    for f in "$TARGET/.github/agents/kernel/"*.md; do
      [[ -f "$f" ]] || continue
      local name=".github/agents/kernel/$(basename "$f")"
      rm "$f"
      log "- $name (removed)"
      ((removed++)) || true
    done
  fi

  # Gitignore files — only if they contain our marker
  for gitignore_path in ".github/.gitignore" ".ai/.gitignore"; do
    local full_path="$TARGET/$gitignore_path"
    if [[ -f "$full_path" ]] && grep -q "prompt-engineering" "$full_path"; then
      rm "$full_path"
      log "- $gitignore_path (removed)"
      ((removed++)) || true
    elif [[ -f "$full_path" ]]; then
      log "⚠ $gitignore_path (not ours — skipped)"
    fi
  done

  # Remove empty directories (non-recursive, fail-silent)
  rmdir "$TARGET/.github/agents/kernel" 2>/dev/null && log "- .github/agents/kernel/ (removed)" || true
  rmdir "$TARGET/.github/agents" 2>/dev/null && log "- .github/agents/ (removed)" || true

  echo ""
  echo "$((removed + absent)) files checked: $removed removed, $absent already absent"
}

# ── Summary ──────────────────────────────────────────────────────────────────

show_summary() {
  local total=$((NEW_COUNT + UPDATED_COUNT + UNCHANGED_COUNT))
  echo ""

  if [[ "$MODE" == "check" ]]; then
    echo "$total files: $UNCHANGED_COUNT unchanged, $UPDATED_COUNT would update, $NEW_COUNT would add"
    if [[ $((NEW_COUNT + UPDATED_COUNT)) -gt 0 ]]; then
      exit 1
    fi
  else
    echo "$total files: $UNCHANGED_COUNT unchanged, $UPDATED_COUNT updated, $NEW_COUNT new"
    echo ""
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo "Installation complete! (v$VERSION)"
    echo ""
    echo "  Agent: Orchestrator (pick from agent picker in VS Code)"
    echo "  Mode:  Open VS Code → Copilot Chat → Agent mode"
    echo ""
    echo "  All installed files are gitignored — run installer per checkout."
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  fi
}

# ── Main ─────────────────────────────────────────────────────────────────────

main() {
  parse_args "$@"
  resolve_target "$TARGET"
  detect_context

  echo "prompt-engineering installer"
  echo "  Target:  $TARGET"
  echo "  Context: $CONTEXT"
  echo "  Mode:    $MODE"

  if [[ "$CONTEXT" == "remote" ]]; then
    VERSION=$(resolve_version "$VERSION")
    download_release "$VERSION" "$TMP_DIR"
    extract_release "$TMP_DIR/release.tar.gz" "$TMP_DIR"
  fi

  echo "  Version: $VERSION"
  echo ""

  if [[ "$MODE" == "uninstall" ]]; then
    run_uninstall
    exit 0
  fi

  check_staleness

  # Always install agents and kernel
  install_agents
  install_kernel

  # Full install only: setup, skills, gitignore, vscode
  if [[ "$MODE" == "install" ]]; then
    install_skills
    ensure_directories
    ensure_gitignore "github" "$CONTEXT"
    ensure_gitignore "ai"
    configure_vscode
  fi

  # Install and update: version marker
  if [[ "$DRY_RUN" != "true" ]]; then
    write_version_marker
  fi

  show_summary

  exit 0
}

main "$@"
