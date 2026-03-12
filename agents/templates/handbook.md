````markdown
# Handbook Template

Post-compaction recovery file. Created per-session at `{scratchSessionDir}/handbook.md`.

## Usage

Orchestrator creates this at session startup, updates after each SA, reads after context compaction.

## Template

```md
# Handbook: {task-name}
Updated: {ISO8601}

## PHASE
Current: {phase} | Wave: {current_wave} / {total_waves}

## COMPLETED
- [x] {SA-1}: {one-line result}
- [x] {SA-2}: {one-line result}

## ACTIVE
SA: {name} | Status: {RUNNING/BLOCKED} | Output: {path}

## NEXT ACTION
{Exactly what to do next — 1-3 lines, imperative}

## HARD CONSTRAINTS
- {constraint 1}
- {constraint 2}

## KEY PATHS
|Path|Purpose|
|-|-|
|{path}|{why it matters}|

## DELIVERABLES
- [ ] {deliverable 1}
- [ ] {deliverable 2}

## ABORT CONDITIONS
- {when to stop and escalate}
```

## Rules

|Rule|Rationale|
|-|-|
|NEXT ACTION is imperative ("Do X")|Recovery must be actionable|
|COMPLETED uses one-line summaries|Space budget|
|KEY PATHS lists only current needs|Not a full inventory|
|DELIVERABLES mirrors dispatch checkboxes|Track across compaction|
|No definitions or concept explanations|System prompt has those|
|HARD CONSTRAINTS = task-specific only|Kernel constraints in system prompt|
|Max 60 lines|Must be fast to read|
````
