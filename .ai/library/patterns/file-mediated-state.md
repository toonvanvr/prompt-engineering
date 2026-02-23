# Pattern: File-Mediated State Transfer

SAs communicate exclusively through files — the orchestrator routes between SAs by pointing them at output files from previous SAs, never by summarizing conversation state. This preserves full context across SA boundaries without costing orchestrator tokens.

## When to Use
- All multi-SA workflows — every SA reads input from files and writes output to files
- When SA₁'s output feeds SA₂'s input (e.g., researcher findings → designer spec → implementer code)
- Orchestrator decision-making — read SA handoff files to determine next action

## When NOT to Use
- Single-SA tasks with no follow-up — file output is still required (for audit trail) but routing is unnecessary
- Human-to-orchestrator communication — use conversation, not files

## Example
Researcher writes `findings.md` (512 lines) → Orchestrator reads it, extracts key facts, creates Designer dispatch pointing at `findings.md` → Designer reads `findings.md`, writes `design-spec.md` → Orchestrator points Implementer at `design-spec.md`. Anti-pattern: Orchestrator summarizing findings in Designer's prompt (loses detail, wastes context).
