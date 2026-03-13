# Orchestrator Plugin (toonvanvr)

Agent plugin for VS Code GitHub Copilot and Claude Code. Provides orchestrated multi-phase task coordination.

## Quick Start

Enable `chat.plugins.enabled` in VS Code settings, add this repo as a marketplace or local plugin path, then pick **Orchestrator (toonvanvr)** from the agent dropdown.

See [docs/setup.md](../../docs/setup.md) for detailed configuration.

## Agent Architecture

| Agent | Visibility | Purpose |
|-------|-----------|---------|
| **Orchestrator (toonvanvr)** | User-facing | Coordination, delegates to subagents |
| Researcher (toonvanvr) | Subagent | Codebase analysis, dependency mapping |
| Designer (toonvanvr) | Subagent | Architecture specs, trade-off analysis |
| Implementer (toonvanvr) | Subagent | Code execution per design contract |
| Compiler (toonvanvr) | Subagent | Prompt compression (50-70% reduction) |

## Directory Overview

| Path | Purpose | Edit? |
|------|---------|-------|
| `agents/` | Compiled agent files (generated) | NO |
| `skills/` | Agent skills (committed) | YES |
| `src/` | Agent & skill sources | YES |
| `src/shared/` | Composable source fragments | YES |
| `src/reference/` | Detail tables/schemas for compilation | YES |
| `src/kernel/` | Compile-time reference only | NO (migrated) |
| `src/templates/` | Sub-agent dispatch templates | YES |
| `src/precompiled/` | Resolved intermediary files | NO (generated) |
| `docs/examples/` | Example prompts | YES |

## Editing Agents

1. Edit `src/{agent}.src.md`
2. Invoke Compiler (toonvanvr) to precompile + compile
3. Output: `agents/{agent}.agent.md`

No deploy step — compiled output IS the deployed location.

## Compilation Pipeline

```
src/*.src.md → src/precompiled/*.pre.md → agents/*.agent.md
```

| Phase | Input | Output | What happens |
|-------|-------|--------|-------------|
| **Precompile** | `src/*.src.md` | `src/precompiled/*.pre.md` | Resolves `@include` directives |
| **Compile** | `src/precompiled/*.pre.md` | `agents/*.agent.md` | Token compression (50-70% reduction) |

## Conventions

- TODO annotations: `TODO(0-4)` priority system
- Modes: EXPLORE (discovery) / EXPLOIT (execution)
- Gates: Every phase has quality gate verification
- Agent format: `.agent.md` with YAML frontmatter
- All paths relative to this plugin directory
