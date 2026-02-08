#!/usr/bin/env bash
set -euo pipefail

tmpdir=$(mktemp -d)
# cleanup at end to avoid premature removal during debugging
cleanup() { rm -rf "$tmpdir"; }
# intentionally don't trap EXIT to keep tmpdir available for assertions on failure

logfile="$tmpdir/install.log"
# Run installer and capture output robustly
bash bin/install.sh "$tmpdir" 2>&1 | tee "$logfile" || true

gitignore="$tmpdir/.github/.gitignore"
if grep -q "/skills/" "$gitignore"; then
  echo "OK: /skills/ present in .github/.gitignore"
else
  echo "FAIL: /skills/ missing from .github/.gitignore. See $logfile for output" >&2
  echo "--- .gitignore content ---" >&2
  cat "$gitignore" || true
  cleanup
  exit 2
fi

echo "--- installer output (from $logfile) ---"
cat "$logfile" || true

cleanup

echo "test_gitignore_skills.sh: PASS"