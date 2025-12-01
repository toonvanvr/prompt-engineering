````markdown
# Handoff Template

Standard template for phase transitions.

---

```markdown
# Phase Handoff: {PHASE_NAME}

**Phase:** {Interpretation|Analysis|Design|Implementation|Review}
**Topic:** {topic_identifier}
**Next:** {next_phase}

---

## Confidence Assessment

| Level             | Concerns      | Mitigation |
| ----------------- | ------------- | ---------- |
| {HIGH/MEDIUM/LOW} | {if not HIGH} | {if LOW}   |

**If LOW:**

- [ ] Spawn verification sub-agent
- [ ] Flag for human review

---

## Summary

{2-3 sentences: what was done & key discoveries}

---

## Key Findings

| Finding | Reference       | Impact   |
| ------- | --------------- | -------- |
| {title} | `{path}:{line}` | {effect} |

---

## Decisions Made

| Decision | Rationale | Impact    |
| -------- | --------- | --------- |
| {what}   | {why}     | {affects} |

---

## Artifacts Produced

| Artifact | Path                         | Description |
| -------- | ---------------------------- | ----------- |
| {name}   | `.ai/scratch/{topic}/{file}` | {contents}  |

---

## Open Questions

### For Next Phase

- [ ] {question to answer next}

### For User (if blocking)

- {only if truly blocking}

---

## Recommendations

| Priority   | Recommendation |
| ---------- | -------------- |
| Start with | {what}         |
| Focus on   | {area}         |
| Watch for  | {risk}         |

---

## Critical Context

### Must Remember

- {critical fact}

### Gotchas

- {gotcha}: {explanation}

---

## Quality Gate

| Gate        | Status              |
| ----------- | ------------------- |
| {gate_name} | {PASS/FAIL/PENDING} |

### Checks

| Check   | Status | Evidence |
| ------- | ------ | -------- |
| {check} | ✓/✗    | {ref}    |

---

## Acceptance Checklist

Before proceeding, verify:

- [ ] All artifacts accessible
- [ ] Summary clear
- [ ] No blocking questions
- [ ] Context sufficient
```

---

## Phase-Specific Sections

### Analysis Handoff Additions

```markdown
## Patterns Discovered

- {pattern}: {usage}

## Questions for Design

- {question}
```

### Design Handoff Additions

```markdown
## Implementation Order

1. {step}
2. {step}

## Files to Modify

| File   | Type    | Change |
| ------ | ------- | ------ |
| {path} | NEW/MOD | {what} |
```

### Implementation Handoff Additions

```markdown
## Verification Log

| Step    | Result      |
| ------- | ----------- |
| {check} | {PASS/FAIL} |

## Ready for Review

{focus areas}
```

### Review Handoff Additions

```markdown
## Verdict: {PASS/CONDITIONAL/FAIL}

## Blocking Issues

- {issue}

## Conditional Items

- {issue to track}
```
````
