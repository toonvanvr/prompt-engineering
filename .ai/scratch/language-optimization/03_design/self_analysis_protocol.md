# Self-Analysis Protocol Specification

## Overview

Mechanism for agents to document their own execution flaws. Enables cross-session learning from failures.

---

## Purpose

1. **Capture execution failures** — What went wrong, why
2. **Enable pattern detection** — Recurring issues across sessions
3. **Feed future improvements** — Agents learn from past mistakes
4. **Reduce repeat failures** — Same mistake shouldn't happen twice

---

## Storage Structure

```
.ai/
├── self-analysis/
│   ├── sessions/                  # Per-session summaries
│   │   ├── 2024-01-15-auth-impl.md
│   │   └── 2024-01-16-api-design.md
│   │
│   ├── patterns/                  # Aggregated failure patterns
│   │   ├── context-overflow.md
│   │   ├── scope-creep.md
│   │   └── gate-skipping.md
│   │
│   ├── compilations/              # Compiler-specific logs
│   │   └── ...
│   │
│   └── _summary.md                # High-level overview
```

---

## Issue Categories

| Category           | Code        | Definition                                |
| ------------------ | ----------- | ----------------------------------------- |
| Context Overflow   | OVERFLOW    | Exceeded context budget, lost information |
| Scope Creep        | CREEP       | Worked beyond assigned boundaries         |
| Gate Skipping      | GATE_SKIP   | Proceeded without gate verification       |
| Design Drift       | DRIFT       | Implementation deviated from spec         |
| Persona Break      | PERSONA     | Dropped assigned role/mindset             |
| Verification Skip  | VERIFY_SKIP | Didn't verify after changes               |
| Documentation Gap  | DOC_GAP     | Left work undocumented                    |
| Escalation Failure | ESC_FAIL    | Didn't escalate after 3 attempts          |

---

## Entry Format

### Session Entry

```markdown
# Session Analysis: {YYYY-MM-DD}-{topic}

## Summary

- Task: {brief description}
- Status: COMPLETE | PARTIAL | FAILED
- Duration: {approximate}
- Sub-agents spawned: {count}

## Issues Observed

### Issue 1: {short title}

| Field      | Value                    |
| ---------- | ------------------------ | ------ | ---- |
| Category   | {OVERFLOW                | CREEP  | ...} |
| Severity   | HIGH                     | MEDIUM | LOW  |
| Phase      | {where occurred}         |
| Trigger    | {what caused it}         |
| Symptom    | {how it manifested}      |
| Correction | {what fixed it}          |
| Prevention | {how to avoid next time} |

### Issue 2: ...

## Metrics

| Metric         | Value       |
| -------------- | ----------- |
| Files analyzed | {N}         |
| Files modified | {N}         |
| Gates passed   | {N}/{total} |
| Escalations    | {N}         |
| Retries        | {N}         |

## Recommendations

- {actionable improvement}
```

### Pattern Entry

```markdown
# Pattern: {CATEGORY}

## Definition

{What this pattern means}

## Frequency

{How often observed}

## Common Triggers

1. {trigger}
2. {trigger}

## Example Occurrences

- {date}: {brief description}
- {date}: {brief description}

## Mitigation Strategies

1. {strategy}
2. {strategy}

## Detection Signals

| Signal   | Action       |
| -------- | ------------ |
| {signal} | {what to do} |
```

---

## Logging Protocol

### When to Log

| Event                     | Action                        |
| ------------------------- | ----------------------------- |
| Gate check fails          | Log immediately with category |
| 3-attempt escalation      | Log all attempts + diagnosis  |
| Scope boundary crossed    | Log with justification        |
| Context approaching limit | Log preventive action taken   |
| Sub-agent deviation       | Log discrepancy               |
| Unexpected behavior       | Log with analysis             |

### Severity Criteria

| Severity | Definition                                    | Examples                        |
| -------- | --------------------------------------------- | ------------------------------- |
| HIGH     | Blocked progress, required human intervention | Escalation, data loss           |
| MEDIUM   | Required correction but self-recoverable      | Wrong file edited, retry needed |
| LOW      | Minor inefficiency, no impact on outcome      | Suboptimal tool choice          |

---

## Analysis Triggers

### Automatic (Every Session)

1. Create session entry at task completion
2. Record all gate pass/fail
3. Log any escalations
4. Note scope deviations

### On Issue Detection

When issue occurs, immediately:

```markdown
## Issue Detected

Category: {category}
Severity: {level}
Phase: {current phase}

### What Happened

{brief description}

### Root Cause

{analysis}

### Correction

{what was done}

### Future Prevention

{recommendation}
```

---

## Reading Self-Analysis

### At Session Start

Agents SHOULD read relevant patterns:

```markdown
## Session Initialization

Read `.ai/self-analysis/patterns/` for:

- Common failure modes
- Detection signals
- Mitigation strategies

Apply learnings to current task.
```

### When Pattern Matches

If current situation matches known pattern:

```markdown
## Pattern Match Detected

Known pattern: {pattern name}
Current trigger: {observed trigger}
Preventive action: {mitigation from pattern file}
```

---

## Aggregation Protocol

### Periodic (Weekly or After N Sessions)

1. Review all session entries
2. Identify recurring issues
3. Create/update pattern entries
4. Update `_summary.md`

### Pattern Threshold

Create pattern entry when:

- Same category appears 3+ times
- Same trigger appears 2+ times
- HIGH severity issue occurs once

---

## Summary File Format

```markdown
# Self-Analysis Summary

Last updated: {date}

## Statistics

| Period    | Sessions | Issues | High Severity |
| --------- | -------- | ------ | ------------- |
| This week | {N}      | {N}    | {N}           |
| All time  | {N}      | {N}    | {N}           |

## Top Patterns

| Pattern   | Frequency | Last Seen |
| --------- | --------- | --------- |
| {pattern} | {N}       | {date}    |

## Active Mitigations

- {mitigation in effect}

## Improvement Trend

{brief narrative on whether issues are decreasing}
```

---

## Integration Points

### Orchestrator

- Creates session entry at task completion
- Reads patterns at session start
- Passes pattern awareness to sub-agents

### Sub-Agents

- Log issues as they occur
- Include analysis reference in `_handoff.md`

### Compiler

- Logs compilation metrics
- Tracks semantic drift warnings

---

## ALWAYS / NEVER

### ALWAYS

1. Create session entry at task end
2. Log HIGH severity immediately
3. Include prevention recommendation
4. Update pattern when threshold met
5. Read patterns at session start

### NEVER

1. Skip logging for "minor" issues
2. Log without analysis/root cause
3. Leave session undocumented
4. Ignore recurring patterns
5. Log sensitive data (credentials, PII)

---

## Implementation Notes

### File Naming Convention

```
{YYYY-MM-DD}-{topic-slug}.md

Examples:
2024-01-15-auth-implementation.md
2024-01-16-api-design-review.md
```

### Token Efficiency

Self-analysis files should be:

- Dense (minimal prose)
- Structured (tables over paragraphs)
- Actionable (focus on prevention)

Target: <100 lines per session entry
