# Escalation Protocol

3-attempt error handling. Structured recovery.

---

## Core Principle

> Error → Structured attempts → Escalate if unresolved.

---

## The STOP-READ-DIAGNOSE-FIX-VERIFY Cycle

```
Error occurs
    ↓
1. STOP — Halt current action
2. READ — Examine error message completely
3. DIAGNOSE — Identify root cause
4. FIX — Apply targeted correction
5. VERIFY — Confirm resolution
    ↓
Success? → Continue
Fail? → Next attempt (different approach)
```

---

## Attempt Progression

### Attempt 1: Direct Fix

```markdown
Approach: Fix based on error message
Mindset: Error is as stated
Action: Apply obvious solution
```

Example:

```
Error: "File not found: config.json"
Fix: Create config.json or fix path
```

### Attempt 2: Alternative Approach

```markdown
Approach: Different solution strategy
Mindset: Initial diagnosis was wrong
Action: Step back, try alternative
```

Example:

```
Error: Still "File not found" after creating
Fix: Check working directory, use absolute path
```

### Attempt 3: Diagnostic Mode

```markdown
Approach: Full diagnostic analysis
Mindset: Something fundamental is wrong
Action: Spawn diagnostic sub-agent or deep investigation
```

Example:

```
Error: Path issues persist
Fix: Spawn sub-agent to analyze environment, permissions, symlinks
```

---

## After 3 Attempts

### Escalation Required

```markdown
## Escalation: {error_summary}

### Error

{original error}

### Attempts

1. {attempt_1_action} → {result}
2. {attempt_2_action} → {result}
3. {attempt_3_action} → {result}

### Diagnosis

{what we learned}

### Blockers

{why we can't proceed}

### Request

{what we need from user/system}
```

---

## Escalation Types

|Type|Trigger|Resolution Path|
|-|-|-|
|Technical|3 failed attempts|User intervention or external fix|
|Scope|Requires out-of-scope changes|User approval to expand scope|
|Information|Missing critical info|User provides missing context|
|Permission|Access denied|User grants access|
|Complexity|Beyond single-agent capacity|Spawn specialized sub-agent|

---

## Escalation Template

```md
# ESCALATION: {brief_title}

## Status
- Severity: {HIGH | MEDIUM | LOW}
- Blocking: {YES | NO}
- Attempts exhausted: 3

## Context
Task: {what we were trying to do}
Phase: {current phase}
Mode: {EXPLORE | EXPLOIT}

## Error Details
```

{exact error message}

```

## Attempt History
| # | Approach | Result |
|---|----------|--------|
| 1 | {approach} | {outcome} |
| 2 | {approach} | {outcome} |
| 3 | {approach} | {outcome} |

## Root Cause Hypothesis
{best guess at underlying issue}

## Requested Action
{specific ask: permission, info, intervention}

## Partial Progress
{what was accomplished before block}

## Resume Instructions
{how to continue once resolved}
```

---

## Pre-Escalation Checklist

Before escalating, verify:

- [ ] All 3 attempts documented
- [ ] Each attempt used different approach
- [ ] Error message fully captured
- [ ] Root cause hypothesis formed
- [ ] Partial progress saved
- [ ] Specific ask identified
- [ ] Resume path defined

---

## Post-Escalation

After user resolves:

1. Document resolution in self-analysis
2. Update approach for similar future errors
3. Continue from checkpoint
4. Verify resolution holds

---

## Summary

```
Error → STOP-READ-DIAGNOSE-FIX-VERIFY
Attempt 1: Direct fix
Attempt 2: Alternative approach
Attempt 3: Diagnostic mode
Still failing → Escalate with template

No silent failures.
No infinite loops.
Always document.
```
