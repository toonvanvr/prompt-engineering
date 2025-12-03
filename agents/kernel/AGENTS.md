# agents/kernel/

Core behavioral rules inherited by all agents.

## Purpose

Kernel files define immutable or near-immutable rules that constrain agent behavior. Changes here affect ALL agents.

## File Reference

|File|Purpose|Mutability|
|-|-|-|
|`three-laws.md`|Fundamental laws|IMMUTABLE|
|`quality-gates.md`|Phase transition rules|STABLE|
|`mode-protocol.md`|EXPLORE/EXPLOIT definitions|STABLE|
|`tool-stakes.md`|Risk classification|STABLE|
|`todo-conventions.md`|TODO priority system|STABLE|
|`human-loop.md`|Human intervention|STABLE|
|`escalation.md`|Error recovery|STABLE|
|`sub-agent-mandate.md`|Spawning thresholds|STABLE|
|`context-budget.md`|Token limits|ADJUSTABLE|
|`consistency-stack.md`|5-layer template|REFERENCE|
|`self-analysis.md`|Logging categories|STABLE|

## Editing Rules

### IMMUTABLE Files
- `three-laws.md` — Do not modify without explicit approval

### STABLE Files
- Changes require review
- Preserve existing behavior
- Additions preferred over modifications

### ADJUSTABLE Files
- May be tuned based on experience
- Document rationale for changes

## Inheritance

Agents reference kernel via dispatch preamble:

```md
## Kernel References
- `agents/kernel/three-laws.md`
- `agents/kernel/quality-gates.md`
- ...
```

## Never

- Remove existing rules (only add)
- Change thresholds without documented rationale
- Skip `three-laws.md` reference in any agent
