# Setup Guide

## Prerequisites

- **VS Code 1.111+** with GitHub Copilot extension
- GitHub Copilot subscription (Individual, Business, or Enterprise)

## Installation Methods

### Direct GitHub Install (Recommended)

1. Open VS Code User Settings (`Ctrl/Cmd+Shift+P` → `Preferences: Open User Settings (JSON)`)
2. Enable agent plugins:
   ```jsonc
   {
     "chat.plugins.enabled": true,
   }
   ```
3. Install the plugin:
  ```bash
  copilot plugin install toonvanvr/prompt-engineering:plugins/orchestrator
  ```
4. Open Copilot Chat → Agent mode → pick **Orchestrator (toonvanvr)** from the agent dropdown

### Marketplace

Use this if you want the plugin to appear in marketplace browse results and to manage it as `orchestrator@toonvanvr-prompt-engineering`.

1. Open VS Code User Settings (`Ctrl/Cmd+Shift+P` → `Preferences: Open User Settings (JSON)`)
2. Enable agent plugins:
  ```jsonc
  {
    "chat.plugins.enabled": true,
  }
  ```
3. Add the marketplace:
  ```bash
  copilot plugin marketplace add toonvanvr/prompt-engineering
  ```
4. Install from the marketplace:
  ```bash
  copilot plugin install orchestrator@toonvanvr-prompt-engineering
  ```
5. Browse `@agentPlugins` in the Extensions sidebar
6. Open Copilot Chat → Agent mode → pick **Orchestrator (toonvanvr)** from the agent dropdown

### Local Clone

Use this for local development or if you want the plugin to track your checked-out repo.

1. Clone the repository:
   ```bash
   git clone https://github.com/toonvanvr/prompt-engineering.git /path/to/prompt-engineering
   ```
2. Add to VS Code settings:
   ```jsonc
   {
     "chat.plugins.enabled": true,
     "chat.plugins.paths": {
       "/path/to/prompt-engineering/plugins/orchestrator": true,
     },
   }
   ```
3. Open Copilot Chat → Agent mode → pick **Orchestrator (toonvanvr)** from the agent dropdown

## Interactive Setup

Pick **Copilot Setup (toonvanvr)** from the agent dropdown in Copilot Chat. It will walk you through configuring VS Code settings interactively.

## VS Code Settings Reference

### Required

| Setting | Default | Description | Reference |
|---------|---------|-------------|-----------|
| [`chat.plugins.enabled`](vscode://settings/chat.plugins.enabled) | `false` | Enable agent plugins in VS Code | [Copilot Customization](https://code.visualstudio.com/docs/copilot/copilot-customization) |

### Plugin Source (one required)

| Setting | Default | Description | Reference |
|---------|---------|-------------|-----------|
| [`chat.plugins.paths`](vscode://settings/chat.plugins.paths) | `{}` | Map of local plugin directory paths | [Copilot Customization](https://code.visualstudio.com/docs/copilot/copilot-customization) |
| [`chat.plugins.marketplaces`](vscode://settings/chat.plugins.marketplaces) | `[]` | Marketplace repository sources | [Copilot Customization](https://code.visualstudio.com/docs/copilot/copilot-customization) |

### Recommended

| Setting | Default | Description | Reference |
|---------|---------|-------------|-----------|
| [`chat.customAgentInSubagent.enabled`](vscode://settings/chat.customAgentInSubagent.enabled) | `false` | Allow agents to spawn custom subagents | [v1.106 Release Notes](https://code.visualstudio.com/updates/v1_106) |
| [`chat.useAgentSkills`](vscode://settings/chat.useAgentSkills) | `false` | Enable Agent Skills for domain knowledge | [v1.108 Release Notes](https://code.visualstudio.com/updates/v1_108) |
| [`github.copilot.chat.searchSubagent.enabled`](vscode://settings/github.copilot.chat.searchSubagent.enabled) | `false` | Use isolated search subagent | [v1.107 Release Notes](https://code.visualstudio.com/updates/v1_107) |
| [`github.copilot.chat.copilotMemory.enabled`](vscode://settings/github.copilot.chat.copilotMemory.enabled) | `false` | Cross-session memory persistence | [v1.108 Release Notes](https://code.visualstudio.com/updates/v1_108) |
| [`github.copilot.chat.anthropic.thinking.budgetTokens`](vscode://settings/github.copilot.chat.anthropic.thinking.budgetTokens) | `0` | Extended thinking budget in tokens (e.g. `32000`) | [v1.109 Release Notes](https://code.visualstudio.com/updates/v1_109) |
| [`github.copilot.chat.anthropic.toolSearchTool.enabled`](vscode://settings/github.copilot.chat.anthropic.toolSearchTool.enabled) | `false` | Deferred tool search for Anthropic models | [v1.109 Release Notes](https://code.visualstudio.com/updates/v1_109) |
| [`github.copilot.chat.anthropic.contextEditing.enabled`](vscode://settings/github.copilot.chat.anthropic.contextEditing.enabled) | `false` | Efficient context management for long sessions | [v1.109 Release Notes](https://code.visualstudio.com/updates/v1_109) |
| [`github.copilot.chat.githubMcpServer.enabled`](vscode://settings/github.copilot.chat.githubMcpServer.enabled) | `false` | Built-in GitHub MCP server | [v1.108 Release Notes](https://code.visualstudio.com/updates/v1_108) |

### Terminal

| Setting | Default | Description | Reference |
|---------|---------|-------------|-----------|
| [`chat.tools.terminal.sandbox.enabled`](vscode://settings/chat.tools.terminal.sandbox.enabled) | `true` | Terminal sandboxing for agent commands | [Copilot Customization](https://code.visualstudio.com/docs/copilot/copilot-customization) |
| [`chat.tools.terminal.autoApproveWorkspaceNpmScripts`](vscode://settings/chat.tools.terminal.autoApproveWorkspaceNpmScripts) | `false` | Auto-approve npm scripts defined in workspace | [Copilot Customization](https://code.visualstudio.com/docs/copilot/copilot-customization) |
| [`chat.tools.terminal.preventShellHistory`](vscode://settings/chat.tools.terminal.preventShellHistory) | `false` | Exclude agent-run commands from shell history | [Copilot Customization](https://code.visualstudio.com/docs/copilot/copilot-customization) |

### Full JSON Example

```jsonc
{
  "chat.plugins.enabled": true,
  "chat.plugins.marketplaces": ["toonvanvr/prompt-engineering"],
  "chat.customAgentInSubagent.enabled": true,
  "chat.useAgentSkills": true,
  "github.copilot.chat.searchSubagent.enabled": true,
  "github.copilot.chat.copilotMemory.enabled": true,
  "github.copilot.chat.anthropic.thinking.budgetTokens": 32000,
  "github.copilot.chat.anthropic.toolSearchTool.enabled": true,
  "github.copilot.chat.anthropic.contextEditing.enabled": true,
  "github.copilot.chat.githubMcpServer.enabled": true,
  "chat.tools.terminal.sandbox.enabled": true,
  "chat.tools.terminal.autoApproveWorkspaceNpmScripts": true,
  "chat.tools.terminal.preventShellHistory": true,
}
```

## Claude Code Setup

Claude Code reads `.agent.md` files from the plugin directory. Point your Claude Code configuration to the compiled agents:

```
plugins/orchestrator/agents/orchestrator.agent.md
```

Claude Code supports AGENTS.md files natively. The root `AGENTS.md` and `plugins/orchestrator/AGENTS.md` provide project context automatically.

## Troubleshooting

### Agent doesn't appear in dropdown
- Verify `chat.plugins.enabled` is `true` in **User Settings** (not just workspace)
- Check that `chat.plugins.paths` or `chat.plugins.marketplaces` is configured
- Restart VS Code after changing plugin settings

### Subagents don't spawn
- Enable `chat.customAgentInSubagent.enabled` — this is required for the orchestrator to delegate
- Ensure VS Code is 1.106+ (subagent support was added in this version)

### Agent skills not loading
- Enable `chat.useAgentSkills` in settings
- Verify skill files exist in `plugins/orchestrator/skills/`

### Extended thinking not working
- Set `github.copilot.chat.anthropic.thinking.budgetTokens` to a value like `32000`
- Only applies when using Anthropic models (Claude) in Copilot

### Plugin not found after clone
- Ensure the path in `chat.plugins.paths` points to `plugins/orchestrator/` (not the repo root)
- Use absolute paths in the settings

### Marketplace install says "Plugin source directory not found"
- Refresh the cached marketplace checkout:
  ```bash
  copilot plugin marketplace remove toonvanvr-prompt-engineering
  copilot plugin marketplace add toonvanvr/prompt-engineering
  copilot plugin install orchestrator@toonvanvr-prompt-engineering
  ```
- If you want the shortest path instead, bypass the marketplace and install directly:
  ```bash
  copilot plugin install toonvanvr/prompt-engineering:plugins/orchestrator
  ```
