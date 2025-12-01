````markdown
# Design Dispatch Template

Sub-agent dispatch for solution design.

---

````markdown
# Sub-Agent Dispatch: Design — {FEATURE}

# MANDATORY: Sub-Agent Prime Directives

You are a SUB-AGENT. DOCUMENT → SCOPE → PERSIST → INHERIT.

---

## Task

Design implementation for {feature} based on analysis findings.

## Mode: EXPLORE

Creativity: enabled within guardrails
Output: architecture + specs + alternatives
Questions: encouraged before commitment

⚠️ GUARDRAILS:

- Three Laws: enforced
- Must address all requirements
- Must be implementable

⚠️ MODE SWITCH → EXPLOIT: After design approval

---

## Input Context

| Source       | Path                                |
| ------------ | ----------------------------------- |
| Analysis     | `.ai/scratch/{topic}/analysis_*.md` |
| Handoff      | `.ai/scratch/{topic}/_handoff.md`   |
| Requirements | {requirements_source}               |

## Requirements

1. {requirement_1}
2. {requirement_2}

---

## Scope

| IN                      | OUT                 |
| ----------------------- | ------------------- |
| Architecture decisions  | Code implementation |
| Data model changes      | Test implementation |
| Interface definitions   | Deployment concerns |
| Error handling strategy |                     |

---

## Design Questions

| Question           | Answer In            |
| ------------------ | -------------------- |
| What changes?      | Component list       |
| Where?             | File map             |
| How interact?      | Data flow            |
| Why this approach? | Alternatives section |

---

## Output Requirements

### Primary: `.ai/scratch/{topic}/design.md`

```markdown
# Design: {Feature}

## Overview

{high-level description}

## Requirements Addressed

- [x] {requirement_1}
- [x] {requirement_2}

## Architecture

### Components

| Component | Responsibility | Location |
| --------- | -------------- | -------- |
| {name}    | {what}         | {path}   |

### Data Flow

{ASCII diagram or description}

## Data Model Changes

### New Models

| Model  | Attributes | Purpose |
| ------ | ---------- | ------- |
| {name} | {list}     | {why}   |

### Modified Models

| Model  | Change | Reason |
| ------ | ------ | ------ |
| {name} | {what} | {why}  |

## Interface Definitions

### Public APIs

| Endpoint/Method | Signature | Description |
| --------------- | --------- | ----------- |
| {name}          | {sig}     | {what}      |

## Implementation Plan

### Phase 1: {name}

| File   | Change | Type    |
| ------ | ------ | ------- |
| {path} | {what} | NEW/MOD |

### Phase 2: {name}

...

## Error Handling

| Error  | Handling   |
| ------ | ---------- |
| {case} | {strategy} |

## Edge Cases

| Case   | Handling   |
| ------ | ---------- |
| {case} | {approach} |

## Alternatives Considered

### {Option A}

- Pros: {list}
- Cons: {list}
- Rejected: {reason}

## Risks

| Risk   | Mitigation |
| ------ | ---------- |
| {risk} | {how}      |

## Open Questions

- {question}
```
````

### Handoff: `.ai/scratch/{topic}/_handoff.md`

```markdown
# Design Handoff: {Feature}

## Summary

{2-3 sentences}

## Key Decisions

| Decision | Rationale |
| -------- | --------- |
| {what}   | {why}     |

## Files to Modify

| File   | Type    | Description |
| ------ | ------- | ----------- |
| {path} | NEW/MOD | {what}      |

## Implementation Order

1. {step}
2. {step}

## Artifacts

- `design.md`

## Gate: Design Approved

- [ ] Covers all requirements
- [ ] Addresses all patterns
- [ ] Feasibility confirmed
- [ ] Approach approved
- Status: {PASS|PENDING|FAIL}
```

---

## Constraints

- Design must be implementable incrementally
- Prefer minimal changes
- Consider backward compatibility
- Reference analysis, don't duplicate

---

## Success Criteria

- [ ] All requirements addressed
- [ ] Clear implementation path
- [ ] Edge cases handled
- [ ] Alternatives documented
- [ ] Handoff complete
- [ ] Gate passed

```

```
````
