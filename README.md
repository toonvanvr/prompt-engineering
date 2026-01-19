# Prompt Engineering

Self-evolving AI agent system for GitHub Copilot. Agents coordinate complex, multi-phase tasks with automatic context isolation and feedback collection.

## Quick Start

```bash
./QUICKSTART.sh /path/to/your/project
```

Then in VS Code:
1. Open Copilot Chat (Agent mode)
2. Select **@orchestrator**
3. Describe your task

## Agents

| Agent | Mode | Purpose | Spawns Others? |
|-------|------|---------|----------------|
| **Orchestrator** | EXPLORE | Coordination only, never implements | YES |
| **Researcher** | EXPLORE | Codebase analysis, pattern finding | NO |
| **Designer** | EXPLORE | Architecture specs, trade-off analysis | NO |
| **Implementer** | EXPLOIT | Code execution per design contract | NO |
| **Compiler** | EXPLOIT | Prompt optimization (50-70% reduction) | NO |

### When to Use Each

- **@orchestrator** — Multi-step tasks, vague requests, anything complex
- **@researcher** — Deep code investigation, dependency mapping
- **@designer** — Architecture decisions, spec writing
- **@implementer** — Direct code changes with clear spec
- **@compiler** — Compress verbose prompts

## Key Features

### Context Isolation
Sub-agents receive only what they need via dispatch—not parent's accumulated context. This prevents token overflow in long-running tasks.

### File-Based Communication
Agents communicate through files, not return values:
- `STATE.md` — Single source of truth
- `communication/human_input.md` — Human writes here
- `communication/ai_status.md` — AI writes status here
- `communication/findings.md` — Accumulated discoveries
- `_handoff.md` — Completion documentation

### Knowledge Persistence (Library)
Learnings persist in `.ai/library/` with 5 categories:
- `skills/` — HOW to do things (Agent Skills format)
- `patterns/` — WHAT works (reusable solutions)
- `research/` — WHY things are (investigation findings)
- `domain/` — WHAT things mean (business concepts)
- `quirks/` — WHAT to watch out for (tool oddities)

Skills follow the [Agent Skills](https://agentskills.io/) open standard.

### Automatic Feedback Collection
Learnings captured automatically to `.ai/feedback/`:
- Tool quirks discovered
- Pattern successes/failures
- Scope overruns
- Escalations

### Human Input
Write to `communication/human_input.md` to intervene:
```markdown
## [2026-01-19T14:30:00] Human Input

ACTION: pause
REASON: Need to review design
```

Supported actions: `pause`, `resume`, `abort`, `redirect`, `feedback`, `context`

## Project Structure

```
agents/
├── compiled/     # Deployed agents (auto-generated)
├── source/       # Human-editable source
├── kernel/       # Inherited behavioral rules
├── modes/        # EXPLORE/EXPLOIT specs
└── templates/    # Sub-agent dispatch templates

.ai/
├── scratch/      # Timestamped working folders
├── feedback/     # Collected learnings
├── library/      # Permanent knowledge (skills, patterns, research, domain, quirks)
└── self-analysis/# Execution logs for improvement
```

## For Users

1. Run `QUICKSTART.sh` on your project
2. Use `@orchestrator` for complex tasks
3. Write to `communication/human_input.md` to intervene
4. Feedback auto-collected to `.ai/feedback/`
5. Library grows organically in `.ai/library/`

## For Maintainers

1. Edit `agents/source/*.src.md`
2. Invoke `@compiler` to generate `agents/compiled/*.agent.md`
3. Process `.ai/feedback/` to improve kernel rules

## Docs

- [Agents Guide](docs/agents.md) — Agent details and dispatch patterns
- [Workflow Guide](docs/workflow.md) — Phase structure and gates
- [Feedback System](docs/feedback.md) — Feedback collection and sync
- [Examples](examples/) — Sample prompts and scenarios

## References

- [Agent Skills](https://agentskills.io/) — Open standard for skill definitions
- [humanlayer/humanlayer](https://github.com/humanlayer/humanlayer) — Human-in-the-loop inspiration
- [VS Code Custom Agents](https://code.visualstudio.com/docs/copilot/copilot-customization) — Configuration docs

