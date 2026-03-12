# Feedback Loop

## Description
How to capture and consume execution feedback. Both success AND failure entries are mandatory per SA. Feedback collection MUST be grounded in observable events, not internal model state.

## Files
- `.ai/feedback/pattern_successes.md` — approaches that worked
- `.ai/feedback/pattern_failures.md` — approaches that failed or underperformed
- `.ai/feedback/tool_quirks.md` — unexpected tool behavior
- `.ai/feedback/scope_overruns.md` — task grew beyond initial estimate
- `.ai/feedback/escalations.md` — 3+ attempt failures requiring help
- `.ai/feedback/human_interventions.md` — user injected instructions mid-task

## Entry Format (3 lines)
```
## {date} — {title}
What: {one sentence describing what happened}
Next: {one sentence actionable recommendation}
```

## Capture Rules
- BOTH success and failure files get an entry every SA — symmetric capture is mandatory
- If no failures occurred: `## {date} — Nominal` / `What: No failures` / `Next: Continue`
- Observable events only: terminal errors, test results, human corrections. Never fabricate.
- Tolerant read: file may not exist. Create with `# Pattern {Successes|Failures}` header on first write.
- Entries append to END of file.

## Collection Triggers

### Automatic (No Prompt Needed)
- **Tool Quirk**: Tool behaves unexpectedly (terminal no output, file ops fail)
- **Pattern Success**: Task completes successfully — document approach and reusable insights
- **Escalation**: Escalation protocol triggered — auto-log to escalations.md

### Semi-Automatic (During Handoff)
- **Pattern Failure**: Reflect on what didn't work during `_handoff.md` creation
- **Scope Overrun**: If final scope > initial scope by >50% — document original vs final
- **Nominal Completion**: Write to `pattern_successes.md`: "nominal execution — standard workflow"

## Agent Responsibilities

|Agent|Collection Duty|
|-|-|
|Orchestrator|Scope overruns, human interventions|
|Researcher|Pattern discoveries (analysis)|
|Designer|Design pattern successes/failures|
|Implementer|Tool quirks, implementation patterns|
|All|Escalations (via escalation protocol)|

## Feedback Lifecycle

### Collection (Current)
Raw entries appended to `.ai/feedback/{category}.md` per SA.

### Compilation (Orchestrator Duty)
At session end or when `hot/` exceeds 20 lines:
1. Review raw entries + hot/ entries
2. Distill still-relevant patterns → `hot/active-warnings.md` or `hot/active-wins.md`
3. Archive resolved entries → `archive/{date}-compilation.md`
4. Hot/ total MUST stay ≤20 lines

### Application (Pre-Dispatch)
Orchestrator reads `hot/` before every SA dispatch. Hot entries become anti-instructions or reinforcements in dispatch.

## Pre-Dispatch
- Scan `pattern_failures.md` for anti-patterns relevant to next SA's scope
- Include as anti-instructions in dispatch CONSTRAINTS section
