# Bug Fix: DatePicker Month Wrapping

## Prompt

> The DatePicker wraps from December to February instead of January. Fix it.

## What Happens

The orchestrator classifies this as a **low-complexity fix** — the bug is clearly described, the component is named, and the expected behavior is obvious. It spawns a researcher to locate the code, then hands off directly to an implementer. No design phase needed.

### Pipeline: Research → Implement

**Research phase** finds:
- `src/components/DatePicker/DatePicker.tsx` — the main component
- `src/components/DatePicker/utils.ts` — month calculation logic
- `getNextMonth()` uses `(month + 2) % 12` instead of `(month % 12) + 1`

**Implementation phase** fixes the off-by-one in `getNextMonth()` and updates the corresponding test case.

## Why Design Was Skipped

The orchestrator skips design when:
- The root cause maps to a single function or file
- The fix doesn't change interfaces or data flow
- No architectural decisions are involved

A bug fix with clear reproduction steps and an obvious solution doesn't need a design document.
