# Standard Handoff Template

Use this template for all phase handoff documents.

---

```markdown
# Phase Handoff: {PHASE_NAME}

**Phase:** {Interpretation/Analysis/Design/Implementation/Review}
**Topic:** {Topic identifier}
**Completed:** {timestamp}
**Next Phase:** {Next phase name}

---

## Confidence Assessment

**Confidence Level:** HIGH / MEDIUM / LOW

**Concerns** (if not HIGH):
- [Specific uncertainty 1]
- [Specific uncertainty 2]

**Mitigation** (if LOW):
- [ ] Spawn verification sub-agent before proceeding
- [ ] Flag for human review

---

## Executive Summary
<2-3 sentences capturing the essence of what was done and discovered>

---

## Key Findings

### Finding 1: {Title}
{1-2 sentence description}
- Reference: `{path/to/relevant/file}:{line}`
- Impact: {How this affects the work}

### Finding 2: {Title}
...

---

## Decisions Made

| Decision | Rationale | Impact |
|----------|-----------|--------|
| {Decision made} | {Why this choice} | {What it affects} |

---

## Artifacts Produced

| Artifact | Path | Description |
|----------|------|-------------|
| {Name} | `.ai/scratch/{topic}/{file}.md` | {What it contains} |

---

## Open Questions

### For Next Phase
- [ ] {Question that the next phase should answer}

### For User (if blocking)
- {Question only if truly blocking}

---

## Recommendations for Next Phase

1. **Start with:** {Recommendation}
2. **Focus on:** {Key area}
3. **Watch out for:** {Potential issue}

---

## Critical Context to Carry Forward

<Information that MUST NOT be lost in phase transition>

### Must Remember
- {Critical fact 1}
- {Critical fact 2}

### Gotchas Discovered
- {Gotcha}: {explanation}

---

## Quality Gate Status

**Gate:** {Gate name}
**Status:** PASSED / CONDITIONAL / PENDING

### Checks
- [x] {Passed check}
- [ ] {Failed/pending check} → {note}

---

## Handoff Acceptance Checklist

Before proceeding, the next phase should verify:
- [ ] All artifacts are accessible
- [ ] Summary is clear
- [ ] No blocking questions remain
- [ ] Context is sufficient to proceed
```
