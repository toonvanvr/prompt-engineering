# Post-SA Review

## Description
How to process sub-agent output and capture feedback.

## Mandatory Steps (gates next SA spawn)

1. **Read** the SA's output file (NOT the conversation)
2a. **Write 1 success entry** to `.ai/feedback/pattern_successes.md` (WHAT worked)
2b. **Write 1 failure entry** to `.ai/feedback/pattern_failures.md` (WHAT didn't work — or "No failures")
3. **Update** progress tracking (task name, status, key outcomes)
4. **Summarize** for orchestrator context: max 5 bullet points retained from SA output

## Feedback Format (3 lines per entry)
```
## {date} — {title}
What: {one sentence describing what happened}
Next: {one sentence actionable recommendation}
```

## Rules
- Steps 2a AND 2b are BOTH mandatory — no skipping failures
- "No failures" is acceptable but must be explicit (e.g., `## 2026-03-04 — Nominal / What: No failures / Next: Continue`)
- Entries append to END of file

## ONLY after steps 1-4 may the orchestrator spawn the next SA.
Skipping feedback capture is the #1 cause of repeated mistakes.
