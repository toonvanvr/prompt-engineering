# Prompt Engineering - AI Agent Conventions

Self-evolving AI agent system for prompt optimization and compilation.

## Architecture

This repo defines **5 agents** that operate in VS Code via GitHub Copilot:

| Agent | Purpose | Mode |
|-------|---------|------|
| Orchestrator | Multi-phase coordination, never implements directly | EXPLORE→EXPLOIT |
| Researcher | Codebase analysis, dependency mapping | EXPLORE |
| Designer | Architecture specs, trade-off analysis | EXPLORE |
| Implementer | Code execution per design contract | EXPLOIT |
| Compiler | Prompt compression (50-70% token reduction) | EXPLOIT |

## Directory Conventions

| Path | Edit? | Purpose |
|------|-------|---------|
| `agents/source/*.src.md` | YES | Human-readable agent definitions |
| `agents/compiled/*.agent.md` | NO | Auto-generated, token-optimized (invoke @compiler) |
| `agents/kernel/` | CAREFULLY | Core behavioral rules inherited by all agents |
| `.ai/library/` | YES | Persistent knowledge (skills, patterns, research, domain, quirks) |
| `.ai/scratch/` | TEMP | Ephemeral session workspaces |

## Key Workflows

**Edit an agent:** Edit `agents/source/{name}.src.md` → invoke @compiler → outputs to `agents/compiled/`

**Install to project:** Run `./QUICKSTART.sh /path/to/project` (creates symlinks in `.github/agents/`)

## Conventions

- **TODO annotations:** Use `TODO(0-4)` priority system (0=critical/blocks merge, 4=question/research)
- **Modes:** EXPLORE (discovery, options OK) vs EXPLOIT (execution, zero deviation)
- **Quality gates:** Every phase transition requires explicit gate verification
- **Three Laws:** (1) Spawn sub-agents for complexity, (2) Document before terminate, (3) Quality gates immutable
- **Skills format:** Files in `.ai/library/skills/` follow [Agent Skills](https://agentskills.io/) standard

## File Communication

Agents communicate via files in `.ai/scratch/{session}/communication/`:
- `human_input.md` — Human writes here (actions: pause, resume, abort, redirect, feedback, context)
- `ai_status.md` — AI writes status updates
- `findings.md` — Accumulated discoveries

## Never

- Edit `agents/compiled/` directly—always edit source and recompile
- Skip quality gates between phases
- Implement without design approval (for complex changes)
- Create sub-agents without passing kernel inheritance rules
