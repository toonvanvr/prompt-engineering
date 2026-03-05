# Self-Diagnosis

## Description
How agents document their own execution flaws for continuous improvement.

## Categories

|Category|Trigger|
|-|-|
|`DRIFT`|Output doesn't match assigned role/task|
|`OVERFLOW`|Truncated output, forgotten context|
|`GATE_SKIP`|Phase transition without verification|
|`SCOPE_CREEP`|Modified files outside scope|
|`LAW_VIOLATION`|Three Laws breached|

## Log Location
`{scratchSessionDir}/_self_analysis.md`

## When to Log
- Any Three Law violation (always)
- Gate skip — even if outcome was fine
- Scope exceeded
- Context overflow symptoms
- Awareness of own rule violation

## Entry Format
```
## {CATEGORY} — {date}
Trigger: {what prompted this}
Impact: {what was affected}
Correction: {how it was fixed}
```
