#!/usr/bin/env bash
set -euo pipefail

tmpdir=$(mktemp -d)
trap 'rm -rf "$tmpdir"' EXIT

mkdir -p "$tmpdir/.vscode"
cat > "$tmpdir/.vscode/settings.json" <<'JSONC'
// This is a JSONC file with comments
{
  // existing setting
  "existing": true
}
// trailing comment
JSONC

output=$(bash bin/install.sh "$tmpdir" 2>&1 || true)

# New behavior: grep-based JSONC handling adds settings without jq
# Verify that recommended keys were added to the JSONC file
if grep -q '"chat.useAgentSkills"' "$tmpdir/.vscode/settings.json"; then
  echo "OK: settings added to JSONC file"
else
  echo "FAIL: expected settings to be added to JSONC file" >&2
  echo "--- settings file ---" >&2
  cat "$tmpdir/.vscode/settings.json" >&2
  exit 2
fi

# Verify the existing setting is still present
if grep -q '"existing"' "$tmpdir/.vscode/settings.json"; then
  echo "OK: existing settings preserved"
else
  echo "FAIL: existing settings were lost" >&2
  exit 2
fi

echo "--- installer output ---"
echo "$output"

echo "test_install_jsonc.sh: PASS"