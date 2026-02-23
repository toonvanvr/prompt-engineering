# prompt-engineering

AI agent system for GitHub Copilot. Only **@orchestrator** is user-facing — all other agents are hidden subagents.

## Quick Start

```bash
# Install into your project
curl -fsSL https://raw.githubusercontent.com/toonvanvr/prompt-engineering/main/bin/install.sh | bash -s -- .
```

Open VS Code → Copilot Chat → Agent mode → **@orchestrator**. See `README.md` for full documentation.

## Agent Architecture

| Agent | Visibility | Purpose |
|-------|-----------|------|
| **Orchestrator** | User-facing | Coordination, delegates to subagents |
| Researcher | Hidden subagent | Codebase analysis, dependency mapping |
| Designer | Hidden subagent | Architecture specs, trade-off analysis |
| Implementer | Hidden subagent | Code execution per design contract |
| Compiler | Hidden subagent | Prompt compression (50-70% reduction) |

## Directory Overview

|Path|Purpose|Edit?|
|-|-|-|
|`bin/`|Installer script (`install.sh`)|YES|
|`agents/source/`|Human-readable agent definitions|YES|
|`agents/compiled/`|Generated, token-optimized|NO (generated)|
|`agents/precompiled/`|Resolved intermediary files (.pre.md)|NO (generated)|
|`agents/shared/`|Composable source fragments (@include targets)|YES|
|`agents/reference/`|Detail tables/schemas for compilation|YES|
|`agents/kernel/`|Inherited behavioral rules|YES (carefully)|
|`.github/skills/`|Agent Skills (committed, VS Code native)|YES|
|`.ai/scratch/`|Ephemeral working space|YES (temporary)|
|`.ai/feedback/`|Auto-collected learnings (gitignored)|NO (machine-specific)|
|`.ai/library/`|Persistent knowledge (patterns, domain, quirks)|YES|

## Key Workflows

### Edit Agent
1. Edit `agents/source/{agent}.src.md`
2. Invoke Compiler agent
3. Output: `agents/compiled/{agent}.agent.md`
4. Deploy: re-run `install.sh` (copies snapshot to `.github/agents/`)

### Add Knowledge
- **Skills** → `.github/skills/` (committed, [Agent Skills](https://agentskills.io/) format)
- **Patterns/domain/quirks** → `.ai/library/{topic}.md` (gitignored in target repos, committed in source repo)

## Conventions

- TODO annotations: `TODO(0-4)` priority system
- Modes: EXPLORE (discovery) / EXPLOIT (execution)
- Gates: Every phase has quality gate verification
- Stakes: LOW/MEDIUM/HIGH for tool calls
- Agent format: `.agent.md` with YAML frontmatter (name, description, tools)
- Paths: All paths in agent files are relative to the workspace root directory

## Never

- Edit `agents/compiled/` directly
- Skip quality gates
- Implement without design approval (high stakes)

## Related

See also `.github/copilot-instructions.md` for detailed conventions.
