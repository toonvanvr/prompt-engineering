# Feedback Collection Protocol

**Kernel Rule** — All agents inherit this behavior

---

## Purpose

Automatic feedback collection captures learnings during task execution without requiring explicit prompts. This solves the problem of "there never were proper feedbacks."

**Status: MANDATORY** — Not aspirational. Failure to collect feedback = incomplete handoff.

---

## External Grounding (FEED-09)

Feedback collection MUST be grounded in observable events, not internal model state:

|Observable|Use as trigger|
|-|-|
|Terminal error output|Tool quirk or escalation|
|Test failure message|Pattern failure|
|Successful test run|Pattern success (if novel approach)|
|Human correction in chat|Human intervention|
|Scope expansion detected|Scope overrun|

**Never fabricate feedback** — only log what actually happened.

---

## Feedback Categories

| Category | File | When to Append |
|----------|------|----------------|
| Tool Quirks | `.ai/feedback/tool_quirks.md` | Unexpected tool behavior |
| Pattern Successes | `.ai/feedback/pattern_successes.md` | Approach worked well |
| Pattern Failures | `.ai/feedback/pattern_failures.md` | Approach failed or was suboptimal |
| Scope Overruns | `.ai/feedback/scope_overruns.md` | Task grew beyond initial estimate |
| Escalations | `.ai/feedback/escalations.md` | 3+ attempt failures requiring help |
| Human Interventions | `.ai/feedback/human_interventions.md` | User injected instructions mid-task |

---

## Collection Triggers

### Automatic (No Prompt Needed)

1. **Tool Quirk**: When a tool behaves unexpectedly
   - Terminal returns no output without `exec zsh`
   - File operations fail with unexpected errors
   - Commands need specific invocation patterns

2. **Pattern Success**: When task completes successfully
   - Document what approach was used
   - Include reusable insights

3. **Escalation**: When escalation protocol triggered
   - Auto-log to escalations.md

### Semi-Automatic (During Handoff)

4. **Pattern Failure**: During `_handoff.md` creation
   - Reflect on what didn't work
   - Document lessons learned

5. **Scope Overrun**: If final scope > initial scope by >50%
   - Document original vs final
   - Identify expansion points

6. **Nominal Completion**: When task completes without issues
   - Write to `pattern_successes.md`: "nominal execution — standard workflow"
   - This ensures EVERY session has at least 1 feedback entry

---

## Feedback Entry Format

```markdown
## {date} | {category} | {project}

**Context**: [One sentence describing the situation]

**Discovery**: [What was learned]

**Recommendation**: [Actionable improvement for future]

**Tags**: [tool:X] [pattern:Y] [phase:Z]
```

---

## Agent Responsibilities

| Agent | Collection Duty |
|-------|-----------------|
| Orchestrator | Scope overruns, human interventions |
| Researcher | Pattern discoveries (analysis) |
| Designer | Design pattern successes/failures |
| Implementer | Tool quirks, implementation patterns |
| All | Escalations (via escalation protocol) |

---

## Sync to prompt-engineering

Feedback is stored in `.ai/feedback/` and created by `tvv-pe init`:

- `.ai/feedback/` — feedback collection directory
- `.ai/library/` — shared knowledge library

Feedback written to `.ai/feedback/` is immediately accessible.

The Compiler agent processes feedback to update kernel rules.

---

## Handoff Integration

Feedback collection is MANDATORY after initial handoff. Add to `_handoff.md`:

```md
## Feedback Captured

|Category|Entries Added|
|-|-|
|Tool Quirks|{n} or none|
|Pattern Success/Failure|{n} or none|
|Escalations|{n} or none|

Feedback location: `.ai/feedback/`
```

**Gate Check**: Handoff incomplete without this section.

---

## Non-Blocking

Feedback collection MUST NOT:
- Block task completion
- Require user approval
- Slow down critical path

If in doubt, append to feedback file and continue.

---

## Zero-Tolerance Enforcement

**Minimum feedback per SA:** 1 entry. No exceptions.

### End-of-Session Processing
At session end, orchestrator MUST: (1) read all `.ai/feedback/*.md` entries from this session, (2) promote validated patterns to `.ai/library/patterns/`, (3) flag contradictions with existing library entries. Unprocessed feedback = incomplete session.

**If nothing went wrong:** Write a nominal success entry. The absence of problems IS feedback — it validates the workflow.

**Gate Integration:** Handoff without `## Feedback Captured` section = INCOMPLETE handoff. Orchestrator MUST reject incomplete handoffs.

|Session Result|Minimum Feedback|
|-|-|
|SA completed normally|1 entry to `pattern_successes.md`|
|SA encountered issue|1 entry per issue to relevant category|
|SA failed/blocked|1 entry to `pattern_failures.md` + 1 to `escalations.md`|
