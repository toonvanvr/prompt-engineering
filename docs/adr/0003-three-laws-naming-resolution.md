# ADR-0003: Three Laws Naming Resolution

**Status**: Accepted
**Date**: 2026-02-11
**Deciders**: Orchestrator + Human

## Context

Both `agents/kernel/three-laws.md` and per-agent source sections used "Three Laws" for DIFFERENT content. Kernel Three Laws: (1) sub-agents mandatory, (2) document before terminate, (3) quality gates immutable. Agent "Three Laws": role-specific behavioral constraints unique to each agent.

## Decision

Rename agent-level sections to "Agent Laws". Kernel retains "Three Laws" as canonical.

## Consequences

### Positive
- Clear disambiguation between kernel-level and agent-level behavioral constraints
- "Three Laws" now unambiguously refers to kernel rules

### Negative
- Minor diff noise across agent source files

### Neutral
- Compiled agent files regenerated with updated section names

## Alternatives Considered

| Alternative | Pros | Cons | Reason rejected |
|-|-|-|-|
| Rename kernel file | Fixes collision at source | Kernel is IMMUTABLE; violates change policy | Kernel stability takes precedence |
| Number agent laws differently | Avoids "Three Laws" entirely | Inconsistent with existing documentation | Unnecessary complexity |
| Add namespace prefix (e.g., "Kernel Three Laws") | Explicit disambiguation | Verbose; still ambiguous when shortened | "Agent Laws" is simpler and sufficient |
