# Example Prompts

This folder contains example prompts showing how to interact with the agent system.

## Structure

- [vague-request.md](vague-request.md) — How agents handle ambiguous requests
- [detailed-spec.md](detailed-spec.md) — Implementation from detailed spec
- [minimal-prompt.md](minimal-prompt.md) — Minimal example (just the prompt)

## When to Use Each Agent

| Scenario | Agent | Example |
|----------|-------|---------|
| "Add feature X" | @orchestrator | Multi-phase coordination |
| "Analyze this code" | @researcher | Read-only investigation |
| "Design the approach" | @designer | Spec writing |
| "Implement this spec" | @implementer | Direct execution |

## Prompt Tips

1. **Be specific about outcomes**, not process
2. **Include context files** when relevant
3. **State constraints** explicitly
4. **For multi-day tasks**, include resumption context
