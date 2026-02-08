# Prompt Engineering

AI agent system for GitHub Copilot. Install into your project, use with `@orchestrator`.

## Quick Start

```bash
# Install into your project (one-liner)
curl -fsSL https://raw.githubusercontent.com/toonvanvr/prompt-engineering/main/bin/install.sh | bash -s -- .

# Or clone and run locally
git clone https://github.com/toonvanvr/prompt-engineering.git
./prompt-engineering/bin/install.sh /path/to/project
```

Open VS Code → Copilot Chat (Agent mode) → **@orchestrator**. It handles everything — spawns specialized subagents as needed.

## What It Does

You talk to **@orchestrator**. It coordinates your task by spawning hidden subagents:

- **Researcher** — Analyzes codebase, maps dependencies
- **Designer** — Creates architecture specs, evaluates trade-offs
- **Implementer** — Writes code per design contract
- **Compiler** — Optimizes agent prompts (50-70% token reduction)

Subagents run in isolated contexts, communicate via files, and hand off results through quality gates. You never interact with them directly.

## VS Code Settings

The installer writes recommended settings to `.vscode/settings.json`. If the file exists, it merges (requires `jq`).

| Setting | Purpose | Reference |
|---------|---------|-----------|
| `chat.customAgentInSubagent.enabled` | Allow agents to spawn custom subagents | [v1.106 Release Notes](https://code.visualstudio.com/updates/v1_106) |
| `chat.agent.thinking.collapsedTools` | Collapse tool calls in thinking display | [Copilot Customization](https://code.visualstudio.com/docs/copilot/copilot-customization) |
| `chat.tools.autoExpandFailures` | Auto-expand details on tool failures | [Copilot Customization](https://code.visualstudio.com/docs/copilot/copilot-customization) |
| `github.copilot.chat.searchSubagent.enabled` | Use isolated search subagent | [v1.107 Release Notes](https://code.visualstudio.com/updates/v1_107) |
| `github.copilot.chat.copilotMemory.enabled` | Cross-session memory persistence | [v1.108 Release Notes](https://code.visualstudio.com/updates/v1_108) |
| `github.copilot.chat.anthropic.thinking.budgetTokens` | Extended thinking budget (rec: 10000) | [v1.109 Release Notes](https://code.visualstudio.com/updates/v1_109) |
| `github.copilot.chat.anthropic.toolSearchTool.enabled` | Tool search for Anthropic models | [v1.109 Release Notes](https://code.visualstudio.com/updates/v1_109) |
| `chat.useAgentSkills` | Enable Agent Skills for domain knowledge | [v1.108 Release Notes](https://code.visualstudio.com/updates/v1_108) |
| `github.copilot.chat.anthropic.contextEditing.enabled` | Efficient context management for long sessions | [v1.109 Release Notes](https://code.visualstudio.com/updates/v1_109) |
| `github.copilot.chat.githubMcpServer.enabled` | Built-in GitHub MCP server | [v1.108 Release Notes](https://code.visualstudio.com/updates/v1_108) |
| `chat.tools.terminal.sandbox.enabled` | Terminal sandboxing for agent commands | [Copilot Customization](https://code.visualstudio.com/docs/copilot/copilot-customization) |
| `chat.tools.terminal.autoApproveWorkspaceNpmScripts` | Auto-approve npm scripts from workspace | [Copilot Customization](https://code.visualstudio.com/docs/copilot/copilot-customization) |
| `chat.tools.terminal.preventShellHistory` | Exclude agent commands from shell history | [Copilot Customization](https://code.visualstudio.com/docs/copilot/copilot-customization) |

## How It Works

1. You describe a task to **@orchestrator**
2. Orchestrator decomposes it into phases (research → design → implement)
3. Each phase spawns a subagent with a focused dispatch
4. Subagents work in isolated context windows with file-mediated state
5. Quality gates verify each phase before proceeding
6. Results accumulate in `.ai/scratch/{session}/`

Communication happens through files — `human_input.md` (you write), `ai_status.md` (agent writes), `findings.md` (shared knowledge).

All paths in agent instructions are relative to the workspace root directory.

## Agent Architecture

| Agent | Visibility | Mode | Role |
|-------|-----------|------|------|
| **Orchestrator** | User-facing | EXPLORE→EXPLOIT | Decomposes tasks, delegates, never implements |
| Researcher | Hidden subagent | EXPLORE | Codebase analysis, dependency mapping |
| Designer | Hidden subagent | EXPLORE | Architecture specs, trade-off analysis |
| Implementer | Hidden subagent | EXPLOIT | Code execution per design contract |
| Compiler | Hidden subagent | EXPLOIT | Prompt compression (50-70% reduction) |

## Project Structure

```
bin/
└── install.sh    # Installer (curl-pipe or local clone)

agents/
├── compiled/     # Deployed .agent.md files (auto-generated, DO NOT EDIT)
├── source/       # Human-editable .src.md definitions
├── kernel/       # Inherited behavioral rules (all agents)
├── modes/        # EXPLORE/EXPLOIT specifications
└── templates/    # Sub-agent dispatch templates

.github/skills/   # Agent Skills (committed, VS Code native)

.ai/              # Created by installer (gitignored — local workspace)
├── scratch/      # Timestamped working folders (ephemeral)
├── feedback/     # Auto-collected learnings
└── library/      # Persistent knowledge
    ├── patterns/ # WHAT works (reusable solutions)
    ├── domain/   # WHAT things mean (business concepts)
    └── quirks/   # WHAT to watch out for (tool oddities)
```

## Customizing

Edit agent source files, then recompile:

1. Edit `agents/source/{agent}.src.md`
2. Invoke the compiler agent to regenerate: `agents/compiled/{agent}.agent.md`
3. Re-run `install.sh` to update installed snapshots

Kernel rules in `agents/kernel/` are inherited by all agents. Edit carefully.

## Knowledge Persistence

- **Skills** at `.github/skills/` — [Agent Skills](https://agentskills.io/) open standard (GA in VS Code 1.109), committed to repo
- **Library** at `.ai/library/` — patterns, domain knowledge, quirks — gitignored, local to each developer
- Agents read from and write to these locations automatically

## Feedback System

`.ai/feedback/` captures operational learnings automatically — tool quirks, pattern successes/failures, scope overruns, escalations. Used to improve kernel rules and agent behavior over time. Feedback files are gitignored (machine-specific, per-checkout).

## Installation

```bash
# Install into your project (one-liner)
curl -fsSL https://raw.githubusercontent.com/toonvanvr/prompt-engineering/main/bin/install.sh | bash -s -- .

# Or clone and run locally
git clone https://github.com/toonvanvr/prompt-engineering.git
./prompt-engineering/bin/install.sh /path/to/project

# Pin a specific version
curl -fsSL https://raw.githubusercontent.com/toonvanvr/prompt-engineering/main/bin/install.sh | bash -s -- . --version=2.0.0
```

This creates:
- `.github/agents/` — Agent files + kernel (snapshot, gitignored)
- `.github/skills/` — Agent Skills (committed, skipped if exists)
- `.ai/` — Local workspace for scratch, feedback, library (gitignored)
- `.vscode/settings.json` — Recommended Copilot settings

To update, re-run the installer.

> **Why gitignored?** Installed agent files are snapshots. Each developer runs the installer after checkout — like `npm install`. Your `.ai/` data is machine-local.

## Uninstall

```bash
rm -rf .github/agents .github/skills .ai .vscode/settings.json
```

## Commands

Talk to `@orchestrator` naturally. Examples:

- *"Add authentication to the API"* — Full research → design → implement cycle
- *"Investigate why tests are failing"* — Spawns researcher
- *"Review the architecture of the payment module"* — Spawns researcher + designer

To intervene mid-task, write to `.ai/scratch/{session}/communication/human_input.md`:

```markdown
ACTION: pause | resume | abort | redirect | feedback | context
REASON: Your message here
```

## Links

- [Agent Skills](https://agentskills.io/) — Open standard for skill definitions
- [VS Code Copilot Customization](https://code.visualstudio.com/docs/copilot/copilot-customization) — Agent and chat settings
- [VS Code v1.106 Release Notes](https://code.visualstudio.com/updates/v1_106) — Subagent support
- [VS Code v1.107 Release Notes](https://code.visualstudio.com/updates/v1_107) — Search subagent
- [VS Code v1.108 Release Notes](https://code.visualstudio.com/updates/v1_108) — Memory, GitHub MCP, Agent Skills
- [VS Code v1.109 Release Notes](https://code.visualstudio.com/updates/v1_109) — Extended thinking, tool search

