````markdown
# Implementation Dispatch Template

Sub-agent dispatch for code implementation.

---

## ⚠️ MANDATORY: EXPLOIT MODE

Implementation sub-agents operate in **EXPLOIT mode only**.

```
┌─────────────────────────────────────────────────────────────────┐
│ IMPLEMENTATION = EXPLOIT MODE                                   │
│                                                                 │
│ Creativity: DISABLED                                            │
│ Deviation: ZERO without approval                                │
│ Verification: MANDATORY per change                              │
│                                                                 │
│ FOLLOW THE DESIGN. NO FREELANCING.                              │
└─────────────────────────────────────────────────────────────────┘
```

---

## The 1-1-1 Rule

```
┌─────────────────────────────────────────────────────────────────┐
│ 1 FILE    — Maximum 2 files changed per task                    │
│ 1 VERIFY  — Specific verification step per task                 │
│ 1 OUTCOME — Clear, checkable completion criterion               │
│                                                                 │
│ If task needs more → DECOMPOSE FURTHER                          │
└─────────────────────────────────────────────────────────────────┘
```

---

````markdown
# Sub-Agent Dispatch: Implementation — {COMPONENT}

# MANDATORY: Sub-Agent Prime Directives

You are a SUB-AGENT. DOCUMENT → SCOPE → PERSIST → INHERIT.

---

## Task

Implement {component} per approved design.

## Mode: EXPLOIT (mandatory)

Creativity: disabled
Deviation: zero without approval
Verification: mandatory per change

FULL CONSTRAINT STACK:

- Three Laws: enforced
- ALWAYS/NEVER: strict
- Gates: sequential
- Format: exact

⚠️ MODE SWITCH → EXPLORE: Only on blocker (requires escalation)

---

## Input Context

| Source   | Path                                |
| -------- | ----------------------------------- |
| Design   | `.ai/scratch/{topic}/design.md`     |
| Analysis | `.ai/scratch/{topic}/analysis_*.md` |
| Review   | `.ai/scratch/{topic}/review_*.md`   |

---

## Implementation Scope

### Files to Create

| File   | Purpose | Verification    |
| ------ | ------- | --------------- |
| {path} | {what}  | {how to verify} |

### Files to Modify

| File   | Changes | Verification    |
| ------ | ------- | --------------- |
| {path} | {what}  | {how to verify} |

---

## Implementation Guidelines

| Guideline | Requirement                            |
| --------- | -------------------------------------- |
| Style     | Match existing patterns                |
| Changes   | Atomic, reversible                     |
| Docs      | Comments for non-obvious code          |
| Errors    | Handle per design, meaningful messages |

---

## Constraints

| Limit            | Value | Action if Exceeded  |
| ---------------- | ----- | ------------------- |
| Lines/file       | 250   | Split task          |
| Files modified   | 8     | Spawn sub-agent     |
| Design deviation | 0     | Document + escalate |

---

## FORBIDDEN Actions

- ❌ Adding features not in design
- ❌ Refactoring unrelated code
- ❌ Changing public interfaces without approval
- ❌ Skipping error handling
- ❌ Skipping verification

---

## Output Requirements

### Changes Applied

Use edit tools to apply changes to files.

### Change Log: `.ai/scratch/{topic}/implementation_{component}.md`

```markdown
# Implementation: {Component}

## Summary

{what was implemented}

## Files Created

| File   | Purpose | Lines |
| ------ | ------- | ----- |
| {path} | {why}   | {n}   |

## Files Modified

| File   | Change | Lines   | Reason |
| ------ | ------ | ------- | ------ |
| {path} | {what} | {range} | {why}  |

## Design Deviations

| Deviation | Original  | Actual | Reason |
| --------- | --------- | ------ | ------ |
| {what}    | {planned} | {done} | {why}  |

## Verification Log

| Step | Command/Check | Result      |
| ---- | ------------- | ----------- |
| 1    | {what}        | {PASS/FAIL} |

## Test Considerations

- {what to test}

## Known Limitations

- {limitation}: {explanation}
```
````

### Handoff: `.ai/scratch/{topic}/_handoff.md`

```markdown
# Implementation Handoff: {Component}

## Summary

{what was implemented}

## Changes Made

| File   | Type    | Status | Verified |
| ------ | ------- | ------ | -------- |
| {path} | NEW/MOD | DONE   | ✓        |

## Verification Needed

- [ ] {check}

## Ready for Review

{focus areas for reviewer}

## Gate: Implementation Complete

- [ ] Matches design
- [ ] Tests pass
- [ ] No regressions
- [ ] Style consistent
- Status: {PASS|FAIL}
```

---

## Success Criteria

- [ ] All design components implemented
- [ ] Code compiles/parses
- [ ] Project conventions followed
- [ ] Changes documented
- [ ] Each change verified
- [ ] Handoff complete
- [ ] Gate passed

```

```
````
