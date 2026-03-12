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
|`agents/kernel/`|Compile-time reference only (not deployed at runtime)|NO (migrated)|
|`skills/`|Agent Skills (committed, VS Code native)|YES|
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
- **Skills** → `skills/` (committed, [Agent Skills](https://agentskills.io/) format)
- **Patterns/domain/quirks** → `.ai/library/{topic}.md` (gitignored in target repos, committed in source repo)

## Library System

Knowledge persistence layer for per-repo learning.

|Directory|Purpose|Content Type|Lifetime|
|-|-|-|-|
|`.ai/library/`|GENERIC reusable knowledge|Patterns, domain facts, conventions|Permanent|
|`.ai/scratch/`|TEMPORAL phase-specific work|Drafts, WIP, phase outputs, debug logs|Session|
|`.ai/feedback/`|Cross-session learning|Pattern failures, successes, quirks|Permanent|

NEVER put temporal content in library/. NEVER put reusable knowledge only in scratch/.

### Library Structure

```
.ai/library/
├── patterns/         # WHAT works (structural)
├── domain/           # WHAT things mean (conceptual)
├── quirks/           # WHAT to watch out for (operational)
└── index.md          # Auto-generated directory
```

### Skills (VS Code Native)

Skills follow the [Agent Skills](https://agentskills.io/) open standard. Source: `skills/`. Installed to `.github/skills/` (VS Code native location via `chat.agentSkillsLocations`).

### Growth Protocol

1. **Identify category**: HOW/WHAT works → patterns/ | WHAT means → domain/ | WHAT breaks → quirks/
2. **Check existing**: Search `.ai/library/{category}/` for duplicates
3. **Create or update**: New topic → create file. Existing → append/update.
4. **Update index**: Add entry to `{category}/index.md`

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

