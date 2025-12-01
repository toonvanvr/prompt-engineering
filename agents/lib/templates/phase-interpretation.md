# Phase: Interpretation Template

Use this template for documenting request interpretation.

---

```markdown
# Request Interpretation: {TOPIC}

## Original Request
<Paste or summarize the original request>

## Understanding

### What is Being Asked
<Clear statement of what the user wants>

### Why (Business Context)
<The underlying need or problem being solved>

### Success Looks Like
<Concrete, observable outcomes>

## Scope Analysis

### Definitely In Scope
- {Item with clear rationale}
- {Item with clear rationale}

### Probably In Scope
- {Item that seems implied}
- {Item that's reasonable}

### Definitely Out of Scope  
- {Item explicitly excluded}
- {Item that would be scope creep}

### Unclear (Needs Clarification)
- {Ambiguous item}: {possible interpretations}

## Ambiguity Analysis

### Ambiguity #1: {Topic}
**The Ambiguity:** {What's unclear}
**Possible Interpretations:**
  1. {Interpretation A}
  2. {Interpretation B}
**Impact if Wrong:** {HIGH/MEDIUM/LOW}
**Recommendation:** {Proceed with X / Ask user}

### Ambiguity #2: {Topic}
...

## Assumptions Made

| Assumption | Rationale | Risk if Wrong |
|------------|-----------|---------------|
| {Assumption} | {Why reasonable} | {Impact} |

## Success Criteria

Measurable criteria for completion:
- [ ] {Criterion 1}
- [ ] {Criterion 2}
- [ ] {Criterion 3}

## Domain Boundaries

### Backend Impact
- Services: {which services}
- Models: {which models}
- Jobs: {which jobs}

### Frontend Impact
- Views: {which views}
- Components: {which components}
- State: {what state changes}

### Integration Points
- External APIs: {list}
- Internal services: {list}

## Preliminary Approach
<High-level strategy for tackling this>

## Questions for User
<Only if truly blocking - prefer assumptions>

## Next Phase Recommendation
- [ ] Proceed to analysis
- [ ] Clarify with user first
- [ ] Reduce scope
```
