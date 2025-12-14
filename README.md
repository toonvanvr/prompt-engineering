# Prompt Engineering

GitHub Copilot agents that coordinate complex tasks—analyze, design, implement, verify.

## Quick Start

1. Run: `./QUICKSTART.sh /path/to/your/project`
2. Open VS Code → Copilot Chat → Agent mode
3. Select **Orchestrator** → describe the task

Re-run script to update agents.

## What It Does

Describe a task (e.g., "add authentication"). The Orchestrator:
- Analyzes codebase
- Designs solution → asks approval
- Delegates to sub-agents
- Verifies before finishing

Async `.human/` folder for override—control without interrupting.

## Agents

|Agent|Purpose|When to use|
|-|-|-|
|Orchestrator|Planning & coordination|Most tasks|
|Implementer|Code changes|Auto-spawned|
|Compiler|Token optimization|Maintainer use|

## Project Structure

```
agents/
├── compiled/     # Deployed (don't edit)
├── source/       # Edit here
├── kernel/       # Core rules
└── templates/    # Dispatch formats
```

## For Maintainers

1. Edit `agents/source/*.src.md`
2. Run Compiler → outputs `agents/compiled/*.agent.md`

## References

- [humanlayer/humanlayer](https://github.com/humanlayer/humanlayer) — Human-in-the-loop inspiration
