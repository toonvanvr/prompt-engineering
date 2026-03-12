# Self-Analysis

## Description
How agents document execution flaws for continuous improvement. Flaw detected → Document → Learn → Prevent recurrence.

## Log Location
`{scratchSessionDir}/_self_analysis.md`

## Categories

|Category|Definition|Trigger|
|-|-|-|
|`DRIFT`|Deviated from assigned role/task|Output doesn't match intent|
|`OVERFLOW`|Context limit exceeded|Truncated output, forgotten context|
|`GATE_SKIP`|Proceeded without verification|Gate not checked before phase change|
|`SCOPE_CREEP`|Work exceeded assigned scope|Modified files outside IN list|
|`LAW_VIOLATION`|Three Laws breached|Sub-agent not spawned, no handoff, gate bypassed|
|`MODEL_DRIFT`|Model-specific behavior tendencies|Behavior drifts from expected norms|

## When to Log

### ALWAYS Log
- Any Three Law violation
- Gate skip (even if outcome was fine)
- Scope exceeded
- Context overflow symptoms
- User correction of agent behavior

### CONSIDER Logging
- Unexpected difficulty
- Approach change mid-task
- Repeated attempts needed
- Unclear specification impact

## Entry Format
```
## {CATEGORY} — {date}
Trigger: {what prompted this — observable event}
Impact: {what was affected, severity}
Correction: {how it was fixed}
Prevention: {how to prevent recurrence}
```
