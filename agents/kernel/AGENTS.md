# agents/kernel/

Core behavioral rules inherited by all agents.

## Purpose

Kernel files define immutable or near-immutable rules that constrain agent behavior. Changes here affect ALL agents.

## Agent Architecture

Only the **Orchestrator** is user-facing (`user-invokable: true`). All other agents are hidden sub-agents (`user-invokable: false`) spawned by the orchestrator. Sub-agents never interact with the user directly — they read from files and write to files.

## File Reference

|File|Purpose|Mutability|
|-|-|-|
|`three-laws.md`|Fundamental laws|IMMUTABLE|
|`quality-gates.md`|Phase transition + error recovery + checkpoints|STABLE|
|`mode-protocol.md`|EXPLORE/EXPLOIT definitions|STABLE|
|`tool-stakes.md`|Risk classification|STABLE|
|`todo-conventions.md`|TODO priority system|STABLE|
|`communication.md`|Human-AI communication & override protocol (merged human-loop.md)|STABLE|
|`context-budget.md`|Read strategy & quality constraints (simplified, checkpoints → quality-gates)|ADJUSTABLE|
|`self-analysis.md`|Logging categories|STABLE|
|`feedback-collection.md`|Automatic feedback capture|STABLE|
|`library-system.md`|Knowledge persistence (merged pattern-system.md)|STABLE|
|`prompt-preservation.md`|Prompt audit trail|STABLE|
|`output-budget.md`|Output token limits|ADJUSTABLE|
|`thoroughness.md`|Context reading rules|STABLE|
|`glossary.md`|Shared terminology|STABLE|
|`model-behavior.md`|Cross-model consistency|STABLE|
|`human-loop.md`|→ Merged into communication.md|REDIRECT|
|`escalation.md`|→ Merged into quality-gates.md § Error Recovery|REDIRECT|
|`pattern-system.md`|→ Merged into library-system.md|REDIRECT|
|`sub-agent-mandate.md`|→ Core triggers inlined in orchestrator source|REDIRECT|
|`consistency-stack.md`|→ Moved to agents/reference/consistency-stack.md|REDIRECT|

## Library Patterns

Learned patterns that inform agent behavior. Stored in `.ai/library/` and referenced by orchestrator during dispatch.

|Pattern|Path|Purpose|
|-|-|-|
|File-Mediated State|`.ai/library/patterns/file-mediated-state.md`|SA communication via files, not conversation summaries|
|Scope Fencing|`.ai/library/patterns/scope-fencing.md`|Explicit DO/DO NOT lists to prevent scope creep|
|Graduated Complexity|`.ai/library/patterns/graduated-complexity.md`|Sort tasks into waves by complexity before delegating|
|Feedback Consumption|`.ai/library/patterns/feedback-consumption.md`|Mandatory feedback read/write loop around SA dispatch|
|Dispatch SA (Skill)|`.github/skills/dispatch-sa/SKILL.md`|v2 dispatch template and pre-dispatch checklist|
|Post-SA Review (Skill)|`.github/skills/post-sa-review/SKILL.md`|Mandatory post-SA output processing and feedback capture|
|Include Deduplication|`.ai/library/patterns/include-deduplication.md`|Composable @include fragments for source file deduplication|
|Two-Phase Compilation|`.ai/library/patterns/two-phase-compilation.md`|Separate resolution from compression for incremental builds|
|Reference Extraction|`.ai/library/patterns/reference-extraction.md`|Move detail tables to reference/, keep summaries in source|
|Reference Integrity|`.github/skills/reference-integrity/SKILL.md`|Post-compilation and pre-session reference integrity verification|

### Recent Rule Additions

New rules added to existing kernel files during the 2026-02-23 overhaul:

|File|Rule Added|Purpose|
|-|-|-|
|`thoroughness.md`|Read-Before-Write Guard|Require full file read before modification|
|`tool-stakes.md`|Tool Discipline (Purpose Clarity, 3-Call Rule, Failure Budget)|Prevent aimless tool usage|
|`quality-gates.md`|Deliverable Gate|Verify deliverable count and scope before handoff|
|`output-budget.md`|Concept Compression|Reduce redundant concept explanations|
|`context-budget.md`|80% Ceiling (Hard Limit)|Hard cap on context window usage|
|`feedback-collection.md`|End-of-Session Processing|Mandatory feedback write before termination|

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

Note: Kernel files are copied to `.github/agents/kernel/` during `bin/install.sh`. Source of truth is `agents/kernel/` in the prompt-engineering repo.

## Never

- Remove existing rules (only add)
- Change thresholds without documented rationale
- Skip `three-laws.md` reference in any agent
