# Self-Analysis Protocol

How agents document execution flaws. Continuous improvement loop.

---

## Core Principle

> Flaw detected → Document → Learn → Prevent recurrence.

---

## Log Location

```
.ai/self-analysis/
├── {date}-{task}-{category}.md
└── index.md (summary of all entries)
```

### Filename Pattern

`YYYY-MM-DD-{task-slug}-{category}.md`

Example: `2024-01-15-auth-impl-DRIFT.md`

---

## Categories

|Category|Definition|Trigger|
|-|-|-|
|`DRIFT`|Deviated from assigned role/task|Output doesn't match intent|
|`OVERFLOW`|Context limit exceeded|Truncated output, forgotten context|
|`GATE_SKIP`|Proceeded without verification|Gate not checked before phase change|
|`SCOPE_CREEP`|Work exceeded assigned scope|Modified files outside IN list|
|`LAW_VIOLATION`|Three Laws breached|Sub-agent not spawned, no handoff, gate bypassed|

---

## Log Format

```md
# Self-Analysis: {CATEGORY}

## Metadata
- Date: {YYYY-MM-DD}
- Task: {task description}
- Agent: {agent type}
- Phase: {phase when occurred}

## Trigger
{What prompted this log? Observable symptom.}

## Analysis
{Root cause. Why did this happen?}

## Impact
{What was affected? Severity.}

## Correction
{How was it fixed in this instance?}

## Prevention
{How to prevent recurrence?}

## Related
{Links to related entries if any}
```

---

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

---

## Example Entry

```md
# Self-Analysis: SCOPE_CREEP

## Metadata
- Date: 2024-01-15
- Task: Implement auth service
- Agent: Implementer
- Phase: Implementation

## Trigger
Modified `config/database.ts` which was outside assigned scope (auth service only).

## Analysis
Database config was imported by auth service. Assumed "dependencies" included transitive.
Spec said "auth service + direct dependencies" — database config is indirect.

## Impact
- Severity: Medium
- Files affected: 1 outside scope
- Risk: Unintended side effects in database layer

## Correction
Reverted database config change. Documented need for separate sub-agent if database changes required.

## Prevention
- Clarify "direct dependency" definition in sub-agent dispatch
- Add explicit OUT list to scope definition
- Verify file is IN scope before editing

## Related
None
```

---

## Index Maintenance

Update `.ai/self-analysis/index.md` after each entry:

```md
# Self-Analysis Index

|Date|Task|Category|Summary|
|-|-|-|-|
|2024-01-15|auth-impl|SCOPE_CREEP|Modified out-of-scope database config|
|...|...|...|...|

## Statistics
- Total entries: {N}
- By category: DRIFT: {n}, OVERFLOW: {n}, ...
- Most common: {category}
```

---

## Usage by Orchestrator

Orchestrator reviews self-analysis before:

- Dispatching similar tasks
- Updating agent prompts
- Identifying systematic issues

### Pattern Detection

```
Same category >3 times → Update kernel rules
Same task type fails → Update dispatch template
Same agent type → Update agent definition
```

---

## Summary

```
Location: .ai/self-analysis/{date}-{task}-{category}.md

Categories:
- DRIFT: Role deviation
- OVERFLOW: Context exceeded
- GATE_SKIP: Verification skipped
- SCOPE_CREEP: Scope exceeded
- LAW_VIOLATION: Three Laws breach

Format: Trigger → Analysis → Impact → Correction → Prevention
```
