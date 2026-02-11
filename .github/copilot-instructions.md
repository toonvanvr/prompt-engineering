# Prompt Engineering - AI Agent Conventions

Self-evolving AI agent system for prompt optimization and compilation.

## Architecture

This repo defines **5 agents** that operate in VS Code via GitHub Copilot. Only the **Orchestrator** is user-facing (`user-invokable: true`). All others are hidden subagents spawned automatically.

| Agent | Visibility | Purpose | Mode |
|-------|-----------|---------|------|
| **Orchestrator** | User-facing | Multi-phase coordination, never implements directly | EXPLORE→EXPLOIT |
| Researcher | Hidden subagent | Codebase analysis, dependency mapping | EXPLORE |
| Designer | Hidden subagent | Architecture specs, trade-off analysis | EXPLORE |
| Implementer | Hidden subagent | Code execution per design contract | EXPLOIT |
| Compiler | Hidden subagent | Prompt compression (50-70% token reduction) | EXPLOIT |

## Directory Conventions

| Path | Edit? | Purpose |
|------|-------|---------|
| `agents/source/*.src.md` | YES | Human-readable agent definitions |
| `agents/compiled/*.agent.md` | NO | Auto-generated, token-optimized (invoke @compiler) |
| `agents/kernel/` | CAREFULLY | Core behavioral rules inherited by all agents |
| `.ai/library/` | YES | Persistent knowledge (patterns, domain, quirks) |
| `.ai/scratch/` | TEMP | Ephemeral session workspaces |
| `.ai/feedback/` | NO | Auto-collected learnings (gitignored, machine-local) |
| `.github/skills/` | YES | Agent Skills (committed, VS Code native) |
| `bin/` | YES | Installer script (`install.sh`) |

All paths in agent files are relative to the workspace root directory.

## Key Workflows

**Edit an agent:** Edit `agents/source/{name}.src.md` → invoke @compiler → outputs to `agents/compiled/`

**Install to project:** `curl -fsSL https://raw.githubusercontent.com/toonvanvr/prompt-engineering/main/bin/install.sh | bash -s -- .`

**Release:** Tag with `vX.Y.Z` → GitHub Actions creates release

**Manage feedback:** Feedback is collected automatically in `.ai/feedback/` (gitignored, machine-local). Library knowledge in `.ai/library/` is committed in the source repo.

## Conventions

- **TODO annotations:** Use `TODO(0-4)` priority system (0=critical/blocks merge, 4=question/research)
- **Modes:** EXPLORE (discovery, options OK) vs EXPLOIT (execution, zero deviation)
- **Quality gates:** Every phase transition requires explicit gate verification
- **Three Laws:** (1) Spawn sub-agents for complexity, (2) Document before terminate, (3) Quality gates immutable
- **Skills format:** Files in `.github/skills/` follow [Agent Skills](https://agentskills.io/) standard

## File Communication

Agents communicate via files in `.ai/scratch/{session}/communication/`:
- `ai_status.md` — AI writes status updates; human appends ACTION entries to `## Human Input` section (actions: pause, resume, abort, redirect, feedback, context, approve)
- `findings.md` — Accumulated discoveries

## Never

- Edit `agents/compiled/` directly—always edit source and recompile
- Skip quality gates between phases
- Implement without design approval (for complex changes)
- Create sub-agents without passing kernel inheritance rules
- Edit compiled agents directly—always edit source and recompile
