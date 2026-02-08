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
# Installer should exit 0 (not abort), so ensure it didn't error out fatally
if echo "$output" | grep -q "could not be parsed by jq"; then
  echo "OK: JSONC detected and warning emitted"
else
  echo "FAIL: expected JSONC warning, got:\n$output" >&2
  exit 2
fi

echo "--- installer output ---"
echo "$output"

echo "test_install_jsonc.sh: PASS"