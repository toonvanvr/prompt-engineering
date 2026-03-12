# prompt-engineering

AI agent plugin for VS Code GitHub Copilot and Claude Code. Pick **Orchestrator (toonvanvr)** from the agent dropdown to start.

## Quick Start

Enable `chat.plugins.enabled` in VS Code settings and add this repo as a marketplace source. See [README.md](README.md) for setup options.

## Agent Architecture

| Agent | Visibility | Purpose |
|-------|-----------|---------|
| **Orchestrator (toonvanvr)** | User-facing | Coordination, delegates to subagents |
| Researcher (toonvanvr) | Subagent | Codebase analysis, dependency mapping |
| Designer (toonvanvr) | Subagent | Architecture specs, trade-off analysis |
| Implementer (toonvanvr) | Subagent | Code execution per design contract |
| Compiler (toonvanvr) | Subagent | Prompt compression (50-70% reduction) |
| Copilot Setup (toonvanvr) | User-facing | VS Code settings configuration |

## Directory Overview

| Path | Purpose | Edit? |
|------|---------|-------|
| `.github/plugin/` | Marketplace index (marketplace.json) | YES |
| `plugins/orchestrator/` | Main plugin directory | YES |
| `plugins/orchestrator/agents/` | Compiled agent files | NO (generated) |
| `plugins/orchestrator/skills/` | Agent skills | YES |
| `plugins/orchestrator/src/` | Agent & skill sources | YES |
| `plugins/orchestrator/src/shared/` | Composable source fragments | YES |
| `plugins/orchestrator/src/kernel/` | Compile-time reference | NO (migrated) |
| `plugins/orchestrator/docs/examples/` | Example prompts | YES |
| `docs/` | Project documentation | YES |
| `.ai/` | Workspace for scratch/feedback/library | YES (temporary) |

## Key Workflows

### Edit Agent
1. Edit `plugins/orchestrator/src/{agent}.src.md`
2. Invoke Compiler (toonvanvr) agent
3. Output: `plugins/orchestrator/agents/{agent}.agent.md`

### Compilation Pipeline
```
src/*.src.md → src/precompiled/*.pre.md → agents/*.agent.md
```

No deploy step — compiled output IS the deployed location.

## Conventions

- All paths relative to workspace root
- TODO annotations: `TODO(0-4)` priority system
- Modes: EXPLORE (discovery) / EXPLOIT (execution)
- Gates: Every phase has quality gate verification

## Never

- Edit `plugins/orchestrator/agents/` directly (generated files)
- Skip quality gates
- Implement without design approval (high stakes)

