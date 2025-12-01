````markdown
# Common Error Patterns

Quick reference for diagnosing and fixing common errors in orchestration and sub-agent work.

> **Core Reference**: See [orchestration.md](orchestration.md) for 3-attempt escalation, [skepticism.md](skepticism.md) for verification mindset.

## Orchestration Errors

| Error | Likely Cause | Quick Fix |
|-------|--------------|-----------|
| Sub-agent returns no handoff | Dispatch didn't require it | Re-dispatch with explicit handoff requirement |
| Sub-agent scope creep | Boundaries unclear | Add explicit OUT OF SCOPE to dispatch |
| Context overflow mid-task | Too many files loaded | Split into smaller sub-agents |
| Phase gate fails | Prerequisites not met | Go back, complete missing items |
| Parallel sub-agents conflict | No sync points | Add handoff points between parallel work |
| Handoff document too large | Scope too broad | Split sub-agent into smaller pieces |
| Sub-agent stuck | Task too complex | Decompose further |
| Lost context after resume | STATE.md not updated | Always update STATE.md after each step |

## Sub-Agent Dispatch Errors

| Error | Likely Cause | Quick Fix |
|-------|--------------|-----------|
| Sub-agent doesn't understand task | Objective unclear | One-sentence objective, numbered steps |
| Wrong files analyzed | File list wrong | Use exact paths, verify existence |
| Return format wrong | Format not specified | Add explicit RETURN FORMAT section |
| Sub-agent makes changes it shouldn't | No constraints section | Add CONSTRAINTS with ❌ items |
| Sub-agent asks clarifying questions | Context incomplete | Provide more context, don't require questions |

## Quality Gate Errors

| Error | Likely Cause | Quick Fix |
|-------|--------------|-----------|
| Gate check missed | Rushing | Slow down, check each item explicitly |
| Conditional pass not tracked | No follow-up mechanism | Create issue/note for follow-up |
| Gate blocked incorrectly | Criteria too strict | Consider appeal with evidence |
| Gate passed prematurely | Criteria misunderstood | Re-read gate definition |

## Documentation Errors

| Error | Likely Cause | Quick Fix |
|-------|--------------|-----------|
| Document too long (>500 lines) | Scope too broad | Split by concern immediately |
| Handoff missing context | Written too quickly | Include all 5 sections |
| Assumptions not documented | Forgot | Add to assumptions.md before proceeding |
| Decisions not logged | Moving too fast | Add to decision_log.md |

---

## Error Recovery Protocol

When any error occurs, follow STOP-READ-DIAGNOSE-FIX-VERIFY:

```
1. STOP  — Don't make random changes
2. READ  — Understand the exact error
3. DIAGNOSE — Find root cause
4. FIX — Minimal targeted fix
5. VERIFY — Confirm fix works
```

### 3-Attempt Escalation

| Attempt | Strategy |
|---------|----------|
| 1 | Targeted fix based on error |
| 2 | New approach with more context |
| 3 | Diagnostic sub-agent |
| 4+ | **ESCALATE** |

---

## Anti-Patterns Table

| Anti-Pattern | Problem | Solution |
|--------------|---------|----------|
| Random changes | Compounds errors | STOP, diagnose first |
| Skipping sub-agent | Context overflow | Sub-agents exist for a reason |
| Gate rushing | Cascade failures | Gates are checkpoints, not delays |
| Trusting without verifying | Hidden bugs | Verify, then trust |
| Ignoring low confidence | Uncertainty compounds | Address or escalate |
| Monolithic documents | Processing failures | Split at 500 lines |
| Assumption without doc | Hidden dependencies | Write to assumptions.md |
| Parallel without sync | Coordination failures | Add handoff points |

---

## Domain-Specific Errors

### TypeScript/Code Errors (for implementation phases)

| Error | Cause | Fix |
|-------|-------|-----|
| Type mismatch | Wrong type used | Check expected type |
| Import not found | Path wrong | Verify file exists |
| Undefined property | Null/undefined access | Add null checks |

### Documentation Errors

| Error | Cause | Fix |
|-------|-------|-----|
| Missing section | Template not followed | Check template requirements |
| Wrong format | Didn't read spec | Read format specification |
| Incomplete handoff | Rushing | Include all required sections |

---

## Quick Diagnosis Guide

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                     QUICK DIAGNOSIS FLOW                                    │
│                                                                             │
│  Error appears                                                              │
│       │                                                                     │
│       ▼                                                                     │
│  Is error message clear?                                                    │
│       │                                                                     │
│   YES─┴───NO                                                                │
│    │       │                                                                │
│    ▼       ▼                                                                │
│  Fix it  Check error pattern table above                                    │
│    │       │                                                                │
│    │   Found match?                                                         │
│    │    │       │                                                           │
│    │  YES      NO                                                           │
│    │   │        │                                                           │
│    │   ▼        ▼                                                           │
│    │ Apply fix  Spawn diagnostic sub-agent                                  │
│    │   │        │                                                           │
│    └───┴────────┘                                                           │
│          │                                                                  │
│          ▼                                                                  │
│       VERIFY                                                                │
│          │                                                                  │
│      Pass? ─── NO ──► Attempt 2/3 or ESCALATE                               │
│          │                                                                  │
│         YES                                                                 │
│          │                                                                  │
│          ▼                                                                  │
│      CONTINUE                                                               │
└─────────────────────────────────────────────────────────────────────────────┘
```

````
