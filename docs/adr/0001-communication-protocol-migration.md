# ADR-0001: Communication Protocol Migration

**Status**: Accepted
**Date**: 2026-02-11
**Deciders**: Orchestrator + Human

## Context

The codebase had two contradictory communication protocols: an older `.human/` folder-based system (referenced in 4 kernel files + 1 template) and a newer single-file `ai_status.md` system (used by all 5 agent sources). The `.human/` system used file-drop mechanics with separate files for each instruction, while `ai_status.md` uses a single file with timestamped ACTION entries in a `## Human Input` section.

## Decision

Standardize on `ai_status.md` as the sole communication protocol. Rewrite `human-loop.md` kernel file preserving the autonomous execution principle. Purge all `.human/` references from kernel files, templates, and config files.

## Consequences

### Positive
- Single source of truth for human-AI communication
- Simpler mental model
- Lower file creation overhead

### Negative
- Loss of granularity (separate files per instruction vs single section)
- Historical `.human/` references in existing scratch sessions become stale

### Neutral
- Existing installed copies in target repos need reinstallation to pick up changes

## Alternatives Considered

| Alternative | Pros | Cons | Reason rejected |
|-|-|-|-|
| Keep both systems with priority rules | Backward compatible | Complexity, ambiguity about which to use | Too complex for marginal benefit |
| Delete human-loop.md entirely | Simplest option | Loses autonomous execution principle | Valuable behavioral constraint worth preserving |
