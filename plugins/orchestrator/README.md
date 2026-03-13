# Orchestrator (toonvanvr)

Multi-phase AI task coordinator for VS Code GitHub Copilot. Decomposes complex tasks into specialized sub-agent operations with quality-gated handoffs.

## What It Does

The orchestrator breaks your request into phases — research, design, implementation, verification — each handled by a specialized sub-agent. You talk to the orchestrator; it manages everything else.

## Agents

| Agent | Role |
|-------|------|
| **Orchestrator** | Task decomposition, delegation, quality gates |
| Researcher | Codebase analysis, dependency mapping, web research |
| Designer | Architecture specs, trade-off analysis, interface design |
| Implementer | Code execution per design contract |
| Compiler | Prompt compression (50-70% token reduction) |

## How It Works

1. You describe a task in natural language
2. The orchestrator interprets your prompt and plans the approach
3. Specialized sub-agents execute each phase
4. Quality gates verify each handoff
5. You get the implemented result

Sub-agents communicate through files, run in isolated contexts, and generally don't interact with you directly.

## Setup

See the [repository README](../../README.md) for installation instructions.
