#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
FAILED=0

pass() { echo "PASS: $*"; }
fail() { echo "FAIL: $*"; FAILED=1; }

normalize_tools() {
  local raw="$1"
  raw="$(printf '%s' "$raw" | sed -E 's/^[[:space:]]*tools:[[:space:]]*//; s/^\[//; s/\]$//')"
  printf '%s' "$raw" \
    | tr ',' '\n' \
    | sed -E "s/^[[:space:]]+|[[:space:]]+$//g; s/^['\"]//; s/['\"]$//" \
    | sed '/^$/d' \
    | LC_ALL=C sort -u \
    | paste -sd ',' -
}

extract_tools_from_yaml_frontmatter() {
  local file="$1"
  awk '
    BEGIN { in_yaml=0; yaml_seen=0 }
    /^---[[:space:]]*$/ {
      if (yaml_seen == 0) { in_yaml=1; yaml_seen=1; next }
      if (in_yaml == 1) { in_yaml=0; exit }
    }
    in_yaml == 1 && /^[[:space:]]*tools:[[:space:]]*/ { print; exit }
  ' "$file"
}

extract_tools_from_source_frontmatter() {
  local file="$1"
  awk '
    BEGIN { in_yaml=0 }
    /^```yaml[[:space:]]*$/ { in_yaml=1; next }
    in_yaml == 1 && /^```[[:space:]]*$/ { in_yaml=0; exit }
    in_yaml == 1 && /^[[:space:]]*tools:[[:space:]]*/ { print; exit }
  ' "$file"
}

echo "Running agent regression checks..."

# a) source tools presence
for src in "$ROOT"/agents/source/*.src.md; do
  base="$(basename "$src" .src.md)"
  tools_line="$(extract_tools_from_source_frontmatter "$src" || true)"
  if [[ -z "$tools_line" ]]; then
    fail "source tools missing: agents/source/${base}.src.md"
  else
    pass "source tools present: agents/source/${base}.src.md"
  fi
done

# b/c) compiled tools presence + parity with snapshot (or source fallback)
for src in "$ROOT"/agents/source/*.src.md; do
  base="$(basename "$src" .src.md)"
  compiled="$ROOT/agents/compiled/${base}.agent.md"
  snapshot="$ROOT/.github/agents/${base}.agent.md"

  if [[ ! -f "$compiled" ]]; then
    fail "compiled agent missing: agents/compiled/${base}.agent.md"
    continue
  fi

  compiled_tools_line="$(extract_tools_from_yaml_frontmatter "$compiled" || true)"
  if [[ -z "$compiled_tools_line" ]]; then
    fail "compiled tools missing: agents/compiled/${base}.agent.md"
  else
    pass "compiled tools present: agents/compiled/${base}.agent.md"
  fi

  if [[ -n "$compiled_tools_line" ]]; then
    compiled_norm="$(normalize_tools "$compiled_tools_line")"

    if [[ -f "$snapshot" ]]; then
      snapshot_tools_line="$(extract_tools_from_yaml_frontmatter "$snapshot" || true)"
      if [[ -z "$snapshot_tools_line" ]]; then
        fail "snapshot tools missing (parity target=snapshot): .github/agents/${base}.agent.md"
        continue
      fi

      snapshot_norm="$(normalize_tools "$snapshot_tools_line")"
      if [[ "$compiled_norm" == "$snapshot_norm" ]]; then
        pass "compiled tools parity OK (target=snapshot): ${base}"
      else
        fail "compiled tools parity FAIL (target=snapshot): ${base}"
        echo "  compiled: [$compiled_norm]"
        echo "  snapshot: [$snapshot_norm]"
      fi
      continue
    fi

    source_tools_line="$(extract_tools_from_source_frontmatter "$src" || true)"
    if [[ -z "$source_tools_line" ]]; then
      fail "source tools missing (parity target=source-fallback): agents/source/${base}.src.md"
      continue
    fi

    source_norm="$(normalize_tools "$source_tools_line")"
    if [[ "$compiled_norm" == "$source_norm" ]]; then
      pass "compiled tools parity OK (target=source-fallback; snapshot missing): ${base}"
    else
      fail "compiled tools parity FAIL (target=source-fallback; snapshot missing): ${base}"
      echo "  compiled: [$compiled_norm]"
      echo "  source:   [$source_norm]"
    fi
  fi
done

# d) orchestrator delegation + ai_status checkpoint anchors
ORCH_SRC="$ROOT/agents/source/orchestrator.src.md"
if grep -q "Sub-Agents Are Mandatory" "$ORCH_SRC" && grep -q "implementation is ALWAYS delegated" "$ORCH_SRC"; then
  pass "orchestrator delegation anchors present"
else
  fail "orchestrator delegation anchors missing"
fi

if grep -q "communication/ai_status.md" "$ORCH_SRC" && grep -q "Checkpoint Protocol" "$ORCH_SRC"; then
  pass "orchestrator ai_status checkpoint anchors present"
else
  fail "orchestrator ai_status checkpoint anchors missing"
fi

# e) user-invocable spelling (no 'k')
INVOKABLE_COUNT=$({ grep -rn "user-invokable" "$ROOT/agents/" --include="*.md" 2>/dev/null || true; } | wc -l)
if [[ "$INVOKABLE_COUNT" -eq 0 ]]; then
  pass "no user-invokable (old spelling) found"
else
  fail "found $INVOKABLE_COUNT occurrences of user-invokable (should be user-invocable)"
fi

# f) plugin.json validity
PLUGIN_JSON="$ROOT/.github/plugin/plugin.json"
if [[ -f "$PLUGIN_JSON" ]]; then
  if python3 -c "import json; json.load(open('$PLUGIN_JSON'))" 2>/dev/null; then
    pass "plugin.json is valid JSON"
  else
    fail "plugin.json is invalid JSON"
  fi
  
  # Check version sync with VERSION file
  if [[ -f "$ROOT/VERSION" ]]; then
    PLUGIN_VER=$(python3 -c "import json; print(json.load(open('$PLUGIN_JSON'))['version'])" 2>/dev/null || echo "unknown")
    FILE_VER=$(cat "$ROOT/VERSION" | tr -d '[:space:]')
    if [[ "$PLUGIN_VER" == "$FILE_VER" ]]; then
      pass "plugin.json version matches VERSION file ($FILE_VER)"
    else
      fail "plugin.json version ($PLUGIN_VER) != VERSION ($FILE_VER)"
    fi
  fi
else
  pass "no plugin.json (optional)"
fi

if [[ "$FAILED" -ne 0 ]]; then
  echo "Regression checks: FAILED"
  exit 1
fi

echo "Regression checks: PASSED"
