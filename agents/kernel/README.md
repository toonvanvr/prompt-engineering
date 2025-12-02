# v2 Kernel Rules

Core behavior rules inherited by all v2 agents.

## Index

| File                   | Purpose                      | Scope               |
| ---------------------- | ---------------------------- | ------------------- |
| `three-laws.md`        | Immutable orchestration laws | All agents          |
| `consistency-stack.md` | 5-layer anchoring template   | Agent structure     |
| `mode-protocol.md`     | EXPLORE ↔ EXPLOIT switching  | Task modes          |
| `sub-agent-mandate.md` | Mandatory spawning rules     | Orchestration       |
| `context-budget.md`    | Token/file limits            | Resource management |
| `quality-gates.md`     | Phase transition checks      | Verification        |
| `self-analysis.md`     | Flaw documentation protocol  | Learning            |
| `escalation.md`        | 3-attempt error protocol     | Error handling      |
| `human-loop.md`        | Human-in-the-loop protocol   | Async intervention  |

## Usage

Kernel files are referenced, not copied. Agent compilation injects relevant sections.

```markdown
## Kernel Inheritance

@inherit: three-laws, sub-agent-mandate, escalation
```

## Compression Level

All kernel files: Technical Documentation register, 50-100 lines max.

## Modification Rules

1. Changes require full test suite pass
2. Version bump on any modification
3. Document rationale in commit message
