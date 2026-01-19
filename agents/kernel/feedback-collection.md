# Feedback Collection Protocol

**Kernel Rule** — All agents inherit this behavior

---

## Purpose

Automatic feedback collection captures learnings during task execution without requiring explicit prompts. This solves the problem of "there never were proper feedbacks."

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

Feedback is automatically available via symlinks created by QUICKSTART.sh:

- `.github/feedback` → `.ai/feedback`
- `.github/lib` → `.ai/library`

No sync script needed. Feedback written to `.ai/feedback/` is immediately accessible.

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
