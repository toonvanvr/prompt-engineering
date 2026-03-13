# Workspace Setup

## Description
Configure the current workspace's `.vscode/settings.json` to support the Orchestrator agent plugin. Invoke when asked to "set up workspace", "configure workspace settings", or "set up VS Code for this plugin".

## Prerequisites (User Settings)
These settings must be in VS Code **User Settings** (not workspace). They cannot be set per-workspace:
- `chat.plugins.enabled`: `true` — enables agent plugin support
- `chat.plugins.marketplaces`: `["toonvanvr/prompt-engineering"]` — registers the marketplace

Instruct the user to add these manually via Ctrl/Cmd+Shift+P → "Preferences: Open User Settings (JSON)".

## Core Settings (required for plugin functionality)

|Setting|Value|Description|
|-|-|-|
|`chat.customAgentInSubagent.enabled`|`true`|Allows custom agents to spawn subagents via `runSubagent`. Required for orchestrator to delegate to Researcher, Designer, Implementer, and Compiler.|
|`chat.useAgentSkills`|`true`|Enables discovery and invocation of agent skills (SKILL.md files). Required for skills like this one to work.|

## Recommended Settings (applied by default — significantly enhances experience)

|Setting|Value|Description|
|-|-|-|
|`github.copilot.chat.searchSubagent.enabled`|`true`|Enables a dedicated search subagent for codebase exploration. Dispatches a lightweight isolated sub-agent for code search instead of sequential grep/file reads.|
|`github.copilot.chat.copilotMemory.enabled`|`true`|Enables persistent memory across conversations (repo, user, and session scoped). Allows agents to accumulate knowledge about the codebase over time.|
|`github.copilot.chat.anthropic.thinking.budgetTokens`|`32000`|Sets the token budget for Anthropic extended thinking (chain-of-thought reasoning). Higher values allow deeper reasoning for complex multi-file tasks. 32000 is a good balance between depth and cost.|
|`github.copilot.chat.anthropic.toolSearchTool.enabled`|`true`|Enables lazy-loading of deferred tools via regex search. Allows the model to work with more than 128 tools by loading them on-demand as needed.|
|`github.copilot.chat.githubMcpServer.enabled`|`true`|Enables the built-in GitHub MCP server providing direct access to GitHub API tools (issues, PRs, repos, search) without requiring external MCP configuration.|
|`chat.tools.terminal.sandbox.enabled`|`false`|Disables terminal sandboxing for agent commands. The sandbox restricts filesystem and network access and frequently interferes with legitimate operations like running build tools, git commands, and package managers.|
|`chat.tools.terminal.preventShellHistory`|`true`|Prevents agent-executed terminal commands from appearing in shell history. Keeps your shell history clean of AI-generated commands.|

## Optional Extras (suggest but do not apply automatically)

|Setting|Value|Description|
|-|-|-|
|`github.copilot.chat.anthropic.contextEditing.enabled`|`true`|Enables context editing for Anthropic models — allows the model to manage its own context window more efficiently during long sessions with many tool calls.|
|`chat.tools.terminal.autoApproveWorkspaceNpmScripts`|`true`|Auto-approves npm scripts defined in the workspace's `package.json`. Reduces approval friction for trusted project scripts.|

## Full JSON Block (Core + Recommended — paste-ready)

```jsonc
{
  // Core — required for plugin functionality
  "chat.customAgentInSubagent.enabled": true,
  "chat.useAgentSkills": true,

  // Recommended — significantly enhances experience
  "github.copilot.chat.searchSubagent.enabled": true,
  "github.copilot.chat.copilotMemory.enabled": true,
  "github.copilot.chat.anthropic.thinking.budgetTokens": 32000,
  "github.copilot.chat.anthropic.toolSearchTool.enabled": true,
  "github.copilot.chat.githubMcpServer.enabled": true,
  "chat.tools.terminal.sandbox.enabled": false,
  "chat.tools.terminal.preventShellHistory": true
}
```

## Behavior

When invoked:
1. Read `.vscode/settings.json` (if it exists)
2. Apply all **Core** and **Recommended** settings (merge with existing, don't overwrite unrelated settings)
3. List **Optional Extras** and ask if the user wants any of them enabled
4. If `.vscode/settings.json` doesn't exist, create it with Core + Recommended settings
5. Remind the user about User Settings prerequisites if not already configured
6. Handle JSONC format (preserve comments in existing files)
