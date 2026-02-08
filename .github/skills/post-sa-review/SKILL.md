# Post-SA Review

## Description
How to process sub-agent output and capture feedback.

## Mandatory Steps (gates next SA spawn)

1. **Read** the SA's output file (NOT the conversation)
2. **Categorize** and write 1-3 lines to relevant `.ai/feedback/*.md`:
   - Success → pattern_successes.md
   - Failure/deviation → pattern_failures.md
   - Scope exceeded → scope_overruns.md
   - Tool issue → tool_quirks.md
   - Needed human help → human_interventions.md
3. **Update** progress tracking (task name, status, key outcomes)
4. **Summarize** for orchestrator context: max 5 bullet points retained from SA output

## Feedback Format
```
- {date}: {what happened} → {lesson for future SAs}
```

## ONLY after steps 1-4 may the orchestrator spawn the next SA.
Skipping feedback capture is the #1 cause of repeated mistakes.
