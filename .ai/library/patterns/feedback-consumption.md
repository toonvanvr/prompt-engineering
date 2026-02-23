# Pattern: Feedback Consumption Loop

Orchestrator must read `.ai/feedback/` before each SA dispatch and write 1-3 line entries after each SA completes, creating a mandatory learning loop that prevents repeated failures across invocations.

## When to Use
- Before every SA dispatch — read feedback files, extract relevant entries, include as anti-instructions
- After every SA completion — read SA output, write feedback entry, update progress, only then spawn next SA
- When past SAs have failed in ways that could recur

## When NOT to Use
- Mid-SA execution — feedback is an orchestrator-level concern, not an SA concern (SAs write feedback per `kernel/feedback-collection.md`)
- For one-off tasks with no follow-up SAs

## Example
Pre-dispatch: Orchestrator reads `pattern_failures.md`, finds "memory/scratch confusion" entry → adds `DO NOT: write persistent state to .ai/scratch/` to next SA's scope fence. Post-SA: reads handoff, writes `- 2026-02-07: renderer SA mixed config formats → standardize on YAML`.
