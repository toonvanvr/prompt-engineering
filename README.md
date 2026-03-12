# Prompt Engineering

AI agent system for VS Code GitHub Copilot (primary) and Claude Code. Specialized sub-agents handle research, design, and implementation with quality-gated handoffs.

## Setup

### Marketplace (Recommended)
1. Enable plugins in VS Code User Settings (`Ctrl/Cmd+Shift+P` → `Preferences: Open User Settings (JSON)`):
   ```json
   { "chat.plugins.enabled": true }
   ```
2. Add marketplace in workspace or user settings:
   ```json
   { "chat.plugins.marketplaces": ["toonvanvr/prompt-engineering"] }
   ```
3. Browse `@agentPlugins` in the Extensions sidebar
4. Pick **Orchestrator (toonvanvr)** from the agent dropdown in Copilot Chat

### Local Clone
1. Clone: `git clone https://github.com/toonvanvr/prompt-engineering.git /path/to/prompt-engineering`
2. Add to VS Code settings:
   ```json
   {
     "chat.plugins.enabled": true,
     "chat.plugins.paths": {
       "/path/to/prompt-engineering/plugins/orchestrator": true
     }
   }
   ```
3. Pick **Orchestrator (toonvanvr)** from the agent dropdown

### Remote Plugin
```json
{
  "chat.plugins.enabled": true,
  "chat.plugins.marketplaces": ["https://github.com/toonvanvr/prompt-engineering.git"]
}
```

> Pick **Copilot Setup (toonvanvr)** from the agent dropdown for interactive setup guidance.
> See [docs/setup.md](docs/setup.md) for full settings reference.

## Agents

| Agent | Visibility | Role |
|-------|-----------|------|
| **Orchestrator (toonvanvr)** | User-facing | Task decomposition, delegation, never implements |
| Researcher (toonvanvr) | Subagent | Codebase analysis, web research, dependency mapping |
| Designer (toonvanvr) | Subagent | Architecture specs, trade-off analysis |
| Implementer (toonvanvr) | Subagent | Code execution per design contract |
| Compiler (toonvanvr) | Subagent | Prompt compression (50-70% token reduction) |
| **Copilot Setup (toonvanvr)** | User-facing | VS Code settings configuration |

Sub-agents communicate via files, run in isolated contexts, and pass through quality gates. You never interact with them directly.

## Usage

Talk to the Orchestrator naturally:

- *"Add authentication to the API"*
- *"Investigate why tests are failing"*
- *"Review the payment module architecture"*
- *"Refactor the config module to use builder pattern"*

See [example prompts](plugins/orchestrator/docs/examples/) for detailed scenarios.

## Development

### Plugin Structure
```
plugins/orchestrator/
├── agents/         # Compiled .agent.md files (generated, DO NOT EDIT)
├── skills/         # Agent Skills (committed)
├── src/            # Source files (EDIT THESE)
│   ├── *.src.md    # Agent source definitions
│   ├── shared/     # Composable fragments (@include targets)
│   ├── reference/  # Detail tables for compilation
│   └── kernel/     # Compile-time reference
└── docs/examples/  # Example prompts
```

### Compilation
```
src/*.src.md → src/precompiled/*.pre.md → agents/*.agent.md
```

Edit sources in `src/`, invoke **Compiler (toonvanvr)** to recompile.

## License

MIT

