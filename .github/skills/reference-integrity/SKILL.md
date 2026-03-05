```skill
# Reference Integrity Check

## Description
Verify that all file references in agent system files resolve to existing targets, and that the compilation pipeline preserves critical paths.

## When to Invoke
- Post-compilation (MANDATORY)
- Session-start (optional)
- Pre-release (recommended)

## Checks

### 1. File Existence
Scan backtick-wrapped paths in `agents/`, `.ai/`, `.github/` → verify each target exists on disk.
- Report broken references as `file:line → missing_path`
- Skip runtime paths containing `{scratchSessionDir}`, `{session}`, or template variables

### 2. Pipeline Path Survival
For each path containing `/` in `agents/source/*.src.md`, verify it appears in corresponding `agents/compiled/*.agent.md`.
- Report dropped paths: `source_file:line → path → MISSING in compiled`

### 3. Kernel Ref Completeness
For each entry in source Kernel References sections, verify it exists in compiled Kernel References.
- Compare: `agents/source/{agent}.src.md` §Kernel References → `agents/compiled/{agent}.agent.md` §Kernel References

### 4. Glossary Conformance
For each path defined in `agents/kernel/glossary.md`, verify canonical form is used in kernel and shared files.
- Flag bare forms where glossary defines qualified path (e.g., `ai_status.md` where glossary says `communication/ai_status.md`)

### 5. Feedback File Readiness
Verify `.ai/feedback/` directory exists and contains at minimum:
- `pattern_successes.md`
- `pattern_failures.md`

## Output Format
```markdown
## Reference Integrity Report

### File Existence
- [PASS/FAIL] {count} references checked, {count} broken
- Broken: {file:line → missing_path}

### Pipeline Path Survival
- [PASS/FAIL] {count} paths checked, {count} dropped
- Dropped: {source:line → path}

### Kernel Ref Completeness
- [PASS/FAIL] {count} refs checked, {count} missing
- Missing: {agent → ref}

### Glossary Conformance
- [PASS/FAIL] {count} terms checked, {count} bare
- Bare: {file:line → bare_form → canonical_form}

### Feedback Readiness
- [PASS/FAIL] {files present/missing}
```

## Integration
- Post-compilation: Run all 5 checks. FAIL blocks deployment.
- Session-start: Run checks 1, 5 only. Advisory.
- Pre-release: Run all 5 checks. Must pass for release.
```
