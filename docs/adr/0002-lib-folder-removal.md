# ADR-0002: lib/ Folder Removal

**Status**: Accepted
**Date**: 2026-02-11
**Deciders**: Orchestrator + Human

## Context

`lib/templates/` contained 2 gitignore template files (4 lines each, 8 lines total). These were included in the release archive via `release.yml` but had zero consumers — `install.sh` uses inline `ensure_gitignore_line` calls instead.

## Decision

Delete `lib/` entirely. Remove from release archive. Root goes from 9 items to 8.

## Consequences

### Positive
- Cleaner root directory
- No dead code or unused templates

### Negative
- None — templates were unused

### Neutral
- Release archive becomes slightly smaller

## Alternatives Considered

| Alternative | Pros | Cons | Reason rejected |
|-|-|-|-|
| Merge into bin/ | Consolidates utilities | Nothing uses them; adds clutter to bin/ | No consumer exists |
| Keep but document as reference | Preserves intent | Dead code with no path to activation | Adds maintenance burden for zero value |
