# Prompt Engineering

AI agent system for VS Code GitHub Copilot. Specialized subagents handle research, design, and implementation phases with quality-gated handoffs and isolated contexts. Installed files are gitignored — each developer runs the installer after checkout, like `npm install`.

## Quick Start

```bash
curl -fsSL https://raw.githubusercontent.com/toonvanvr/prompt-engineering/main/bin/install.sh | bash -s -- .
```

Open VS Code → Copilot Chat → Agent mode → pick **Orchestrator** from the agent picker.

## Agents

| Agent | Visibility | Role |
|-------|-----------|------|
| **Orchestrator** | User-facing | Task decomposition, delegation, never implements |
| Researcher | Hidden subagent | Codebase analysis, dependency mapping |
| Designer | Hidden subagent | Architecture specs, trade-off analysis |
| Implementer | Hidden subagent | Code execution per design contract |
| Compiler | Hidden subagent | Prompt compression (50-70% token reduction) |

Subagents communicate via files, run in isolated contexts, and pass through quality gates. You never interact with them directly.

## Usage

Talk to the Orchestrator naturally:

- *"Add authentication to the API"* — Full research → design → implement cycle
- *"Investigate why tests are failing"* — Spawns researcher
- *"Review the payment module architecture"* — Spawns researcher + designer

To intervene mid-task, write to `.ai/scratch/{session}/communication/ai_status.md`:

```markdown
ACTION: pause | resume | abort | redirect | feedback | context
REASON: Your message here
```

## Project Structure

```
bin/
└── install.sh        # Installer with modes (install/update/check/uninstall)

agents/
├── source/           # Human-editable .src.md definitions (EDIT THESE)
├── shared/           # Composable fragments (@include targets)
├── reference/        # Detail tables/schemas for compilation
├── precompiled/      # Resolved intermediary .pre.md (generated)
├── compiled/         # Deployed .agent.md files (generated, DO NOT EDIT)
├── kernel/           # Inherited behavioral rules (all agents)
├── modes/            # EXPLORE/EXPLOIT specifications
└── templates/        # Sub-agent dispatch templates

.github/skills/       # Agent Skills (committed, VS Code native)

.ai/                  # Created by installer (gitignored)
├── scratch/          # Timestamped working folders (ephemeral)
├── feedback/         # Auto-collected learnings (machine-specific)
└── library/          # Persistent knowledge
    ├── patterns/     # Reusable solutions
    ├── domain/       # Business concepts
    └── quirks/       # Tool oddities
```

## Editing Agents

```
1. Edit:       agents/source/{agent}.src.md
2. Precompile: Resolve @includes → agents/precompiled/{agent}.pre.md
3. Compile:    Token compression → agents/compiled/{agent}.agent.md
4. Deploy:     bin/install.sh (copies snapshot to .github/agents/)
```

Invoke the **Compiler** agent to run steps 2-3.

## Compilation Pipeline

Agent sources are compiled in two phases:

```
source (.src.md) → precompiled (.pre.md) → compiled (.agent.md)
```

| Phase | Input | Output | What happens |
|-------|-------|--------|-------------|
| **Precompile** | `agents/source/*.src.md` | `agents/precompiled/*.pre.md` | Resolves `<!-- @include path -->` directives |
| **Compile** | `agents/precompiled/*.pre.md` | `agents/compiled/*.agent.md` | Token compression (50-70% reduction) |

The `@include` directive (e.g., `<!-- @include agents/shared/architecture.md -->`) inlines shared fragments at build time. Source fragments live in `agents/shared/` (composable blocks) and `agents/reference/` (detail tables).

## Installation

```bash
# Install (first time — full setup)
curl -fsSL https://raw.githubusercontent.com/toonvanvr/prompt-engineering/main/bin/install.sh | bash -s -- .

# Update (re-deploys agents, skips setup)
curl -fsSL https://raw.githubusercontent.com/toonvanvr/prompt-engineering/main/bin/install.sh | bash -s -- . --mode=update

# Check (CI — exits 1 if outdated)
curl -fsSL https://raw.githubusercontent.com/toonvanvr/prompt-engineering/main/bin/install.sh | bash -s -- . --mode=check

# Uninstall (removes installed files, not settings)
curl -fsSL https://raw.githubusercontent.com/toonvanvr/prompt-engineering/main/bin/install.sh | bash -s -- . --mode=uninstall

# Verbose output
curl -fsSL https://raw.githubusercontent.com/toonvanvr/prompt-engineering/main/bin/install.sh | bash -s -- . --verbose
```

| Mode | Creates dirs | Writes settings | Deploys agents | Use case |
|------|-------------|----------------|---------------|----------|
| `install` | Yes | Yes | Yes | First setup |
| `update` | No | No | Yes | Re-deploy after source changes |
| `check` | No | No | Compare only | CI pipeline validation |
| `uninstall` | No | No | Removes | Clean removal of installed files |

Uses `cmp -s` for change detection — only overwrites files that actually changed.

Creates the following structure in your project:

```
.github/
├── agents/        # Agent files + kernel (snapshot, gitignored)
└── skills/        # Agent Skills (committed, skipped if exists)
.ai/               # Workspace for scratch/feedback/library (gitignored)
.vscode/
└── settings.json  # Recommended Copilot settings
```

## VS Code Settings

The installer configures `.vscode/settings.json` with recommended Copilot settings.

| Setting | Purpose | Reference |
|---------|---------|-----------|
| [`chat.customAgentInSubagent.enabled`](vscode://settings/chat.customAgentInSubagent.enabled) | Allow agents to spawn custom subagents | [v1.106 Release Notes](https://code.visualstudio.com/updates/v1_106) |
| [`chat.agent.thinking.collapsedTools`](vscode://settings/chat.agent.thinking.collapsedTools) | Collapse tool calls in thinking display | [Copilot Customization](https://code.visualstudio.com/docs/copilot/copilot-customization) |
| [`chat.tools.autoExpandFailures`](vscode://settings/chat.tools.autoExpandFailures) | Auto-expand details on tool failures | [Copilot Customization](https://code.visualstudio.com/docs/copilot/copilot-customization) |
| [`github.copilot.chat.searchSubagent.enabled`](vscode://settings/github.copilot.chat.searchSubagent.enabled) | Use isolated search subagent | [v1.107 Release Notes](https://code.visualstudio.com/updates/v1_107) |
| [`github.copilot.chat.copilotMemory.enabled`](vscode://settings/github.copilot.chat.copilotMemory.enabled) | Cross-session memory persistence | [v1.108 Release Notes](https://code.visualstudio.com/updates/v1_108) |
| [`github.copilot.chat.anthropic.thinking.budgetTokens`](vscode://settings/github.copilot.chat.anthropic.thinking.budgetTokens) | Extended thinking budget (32000 tokens) | [v1.109 Release Notes](https://code.visualstudio.com/updates/v1_109) |
| [`github.copilot.chat.anthropic.toolSearchTool.enabled`](vscode://settings/github.copilot.chat.anthropic.toolSearchTool.enabled) | Tool search for Anthropic models | [v1.109 Release Notes](https://code.visualstudio.com/updates/v1_109) |
| [`chat.useAgentSkills`](vscode://settings/chat.useAgentSkills) | Enable Agent Skills for domain knowledge | [v1.108 Release Notes](https://code.visualstudio.com/updates/v1_108) |
| [`github.copilot.chat.anthropic.contextEditing.enabled`](vscode://settings/github.copilot.chat.anthropic.contextEditing.enabled) | Efficient context management for long sessions | [v1.109 Release Notes](https://code.visualstudio.com/updates/v1_109) |
| [`github.copilot.chat.githubMcpServer.enabled`](vscode://settings/github.copilot.chat.githubMcpServer.enabled) | Built-in GitHub MCP server | [v1.108 Release Notes](https://code.visualstudio.com/updates/v1_108) |
| [`chat.tools.terminal.sandbox.enabled`](vscode://settings/chat.tools.terminal.sandbox.enabled) | Terminal sandboxing for agent commands | [Copilot Customization](https://code.visualstudio.com/docs/copilot/copilot-customization) |
| [`chat.tools.terminal.autoApproveWorkspaceNpmScripts`](vscode://settings/chat.tools.terminal.autoApproveWorkspaceNpmScripts) | Auto-approve npm scripts from workspace | [Copilot Customization](https://code.visualstudio.com/docs/copilot/copilot-customization) |
| [`chat.tools.terminal.preventShellHistory`](vscode://settings/chat.tools.terminal.preventShellHistory) | Exclude agent commands from shell history | [Copilot Customization](https://code.visualstudio.com/docs/copilot/copilot-customization) |

## References

- [Agent Skills](https://agentskills.io/) — Open standard for skill definitions
- [VS Code Copilot Customization](https://code.visualstudio.com/docs/copilot/copilot-customization) — Agent and chat settings
- [VS Code v1.106 Release Notes](https://code.visualstudio.com/updates/v1_106) — Subagent support
- [VS Code v1.107 Release Notes](https://code.visualstudio.com/updates/v1_107) — Search subagent
- [VS Code v1.108 Release Notes](https://code.visualstudio.com/updates/v1_108) — Memory, GitHub MCP, Agent Skills
- [VS Code v1.109 Release Notes](https://code.visualstudio.com/updates/v1_109) — Extended thinking, tool search

