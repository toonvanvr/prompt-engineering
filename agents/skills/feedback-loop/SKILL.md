# Feedback Loop

## Description
How to capture and consume execution feedback. Both success AND failure entries are mandatory per SA.

## Files
- `.ai/feedback/pattern_successes.md` — approaches that worked
- `.ai/feedback/pattern_failures.md` — approaches that failed or underperformed

## Entry Format (3 lines)
```
## {date} — {title}
What: {one sentence describing what happened}
Next: {one sentence actionable recommendation}
```

## Capture Rules
- BOTH files get an entry every SA — symmetric capture is mandatory
- If no failures occurred: `## {date} — Nominal` / `What: No failures` / `Next: Continue`
- Observable events only: terminal errors, test results, human corrections. Never fabricate.
- Tolerant read: file may not exist. Create with `# Pattern {Successes|Failures}` header on first write.
- Entries append to END of file.

## Pre-Dispatch
- Scan `pattern_failures.md` for anti-patterns relevant to next SA's scope
- Include as anti-instructions in dispatch CONSTRAINTS section
