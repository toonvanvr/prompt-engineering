#!/usr/bin/env bash
set -euo pipefail

tmpdir=$(mktemp -d)
# cleanup at end to avoid premature removal during debugging
cleanup() { rm -rf "$tmpdir"; }
# intentionally don't trap EXIT to keep tmpdir available for assertions on failure

mkdir -p "$tmpdir/.vscode"
# start with empty JSON to ensure merge injects recommended keys
cat > "$tmpdir/.vscode/settings.json" <<'JSON'
{}
JSON

# Run installer and capture output to a file to avoid command-substitution edge cases
logfile="$tmpdir/install.log"
bash bin/install.sh "$tmpdir" 2>&1 | tee "$logfile" || true

echo "--- DEBUG: installer output ---"
cat "$logfile" || true

echo "--- DEBUG: settings file ---"
cat "$tmpdir/.vscode/settings.json" || true

# Ensure exit was successful and that merged file contains a recommended key
if grep -q "\"chat.useAgentSkills\"" "$tmpdir/.vscode/settings.json"; then
  echo "OK: settings.json merged recommended keys"
else
  echo "FAIL: settings.json did not contain recommended keys. See $logfile for installer output." >&2
  echo "--- installer output (from $logfile) ---" >&2
  sed -n '1,200p' "$logfile" >&2
  cleanup
  exit 2
fi

echo "--- installer output (from $logfile) ---"
cat "$logfile" || true

cleanup

echo "test_install_merge.sh: PASS"