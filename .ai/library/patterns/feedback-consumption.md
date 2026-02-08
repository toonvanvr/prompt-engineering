# Pattern: Feedback Consumption Loop

## Problem
Feedback files exist but are never read, making past failures repeat.

## Solution
Before each SA dispatch, the orchestrator MUST:
1. Read relevant `.ai/feedback/*.md` files
2. Extract entries relevant to the current task type
3. Include as anti-instructions in the SA dispatch

After each SA completes, the orchestrator MUST:
1. Read the SA's output file
2. Write 1-3 lines to the relevant `.ai/feedback/*.md` file
3. Update progress tracking
4. Only THEN spawn the next SA

## Rules
- Feedback capture is a MANDATORY gate — not a suggestion
- Entries should be 1-3 lines, not structured documents
- Format: `- {date}: {what happened} → {lesson for future SAs}`
- Anti-instructions reference specific past failures by name

## Evidence
- Logger project: 5 of 6 feedback files had zero entries after 20+ SA invocations
- The ONE pattern_failures entry (memory/scratch confusion) was effectively used when humans intervened to inject it
