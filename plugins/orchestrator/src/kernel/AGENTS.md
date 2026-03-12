# plugins/orchestrator/src/kernel/

Compile-time behavioral rules. These files are **reference sources** — they are inlined into agent source files via `@include` directives or merged into skills/AGENTS.md during the v3 migration. Agents do NOT read from `plugins/orchestrator/src/kernel/` at runtime.

## Status

Kernel files have been migrated to their compile-time destinations:
- **@include targets** → `plugins/orchestrator/src/shared/` (glossary, thoroughness, model-behavior)
- **Skills** → `skills/` (feedback-collection → feedback-loop, self-analysis, verification-methods → verification)
- **AGENTS.md** → root `AGENTS.md` (library-system) and `plugins/orchestrator/AGENTS.md` (todo-conventions)
- **Already inlined** → Content already exists in compiled agents (three-laws, communication, context-budget, output-budget, prompt-preservation, quality-gates)
- **Already covered** → By `plugins/orchestrator/src/modes/` and `plugins/orchestrator/src/shared/` (mode-protocol, tool-stakes)

## Remaining Files (Reference Only)

|File|Purpose|Status|
|-|-|-|
|`three-laws.md`|Fundamental laws|Inlined in compiled agents|
|`quality-gates.md`|Phase transition + error recovery|Inlined in compiled agents|
|`mode-protocol.md`|EXPLORE/EXPLOIT definitions|Covered by `plugins/orchestrator/src/modes/`|
|`tool-stakes.md`|Risk classification|Covered by `plugins/orchestrator/src/shared/constraints.md`|
|`communication.md`|Human-AI communication|Inlined in compiled agents|
|`context-budget.md`|Read strategy|Inlined in compiled agents|
|`output-budget.md`|Output token limits|Inlined in compiled agents|
|`prompt-preservation.md`|Prompt audit trail|Inlined in compiled agents|
|`self-analysis.md`|Logging categories|Migrated to `skills/self-analysis/`|
|`feedback-collection.md`|Feedback capture|Migrated to `skills/feedback-loop/`|
|`library-system.md`|Knowledge persistence|Migrated to root `AGENTS.md`|
|`todo-conventions.md`|TODO priority system|Migrated to `agents/AGENTS.md`|
|`thoroughness.md`|Context reading rules|Migrated to `plugins/orchestrator/src/shared/thoroughness.md`|
|`glossary.md`|Shared terminology|Migrated to `plugins/orchestrator/src/shared/glossary.md`|
|`model-behavior.md`|Cross-model consistency|Migrated to `plugins/orchestrator/src/shared/model-behavior.md`|
|`verification-methods.md`|SA verification|Migrated to `skills/verification/`|

## Modification Rules

These files are kept as authoritative reference. Do not add new kernel files — use `plugins/orchestrator/src/shared/`, `skills/`, or `AGENTS.md` instead.
|Include Deduplication|`.ai/library/patterns/include-deduplication.md`|Composable @include fragments for source file deduplication|
|Two-Phase Compilation|`.ai/library/patterns/two-phase-compilation.md`|Separate resolution from compression for incremental builds|
|Reference Extraction|`.ai/library/patterns/reference-extraction.md`|Move detail tables to reference/, keep summaries in source|
|Reference Integrity|`plugins/orchestrator/skills/reference-integrity/SKILL.md`|Post-compilation and pre-session reference integrity verification|
|Prompt Analysis (Skill)|`plugins/orchestrator/skills/prompt-analysis/SKILL.md`|Mode derivation from prompt classification (repo-only)|
|Path Integrity Pipeline|`.ai/library/patterns/path-integrity-pipeline.md`|Path qualification across source→compiled pipeline|

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
- `plugins/orchestrator/src/kernel/three-laws.md`
- `plugins/orchestrator/src/kernel/quality-gates.md`
- ...
```

Note: Kernel files are the authoritative source in the prompt-engineering repo. No separate deploy step — compiled output is the deployed location.

## Never

- Remove existing rules (only add)
- Change thresholds without documented rationale
- Skip `three-laws.md` reference in any agent
