# agents/

Agent framework for orchestrated AI task execution.

## Structure

|Path|Purpose|Edit?|
|-|-|-|
|`source/`|Human-readable definitions (.src.md)|YES|
|`compiled/`|Token-optimized deployment (.agent.md)|NO|
|`kernel/`|Inherited behavioral rules|YES (carefully)|
|`modes/`|EXPLORE/EXPLOIT specifications|RARELY|
|`templates/`|Sub-agent dispatch templates|YES|

## Agent Types

Only the **Orchestrator** is user-facing. All others are hidden subagents (`user-invokable: false`).

|Agent|Visibility|Purpose|Mode|
|-|-|-|-|
|**Orchestrator**|User-facing|Multi-phase coordination|EXPLORE/EXPLOIT|
|Researcher|Hidden subagent|Codebase analysis, dependency mapping|EXPLORE|
|Designer|Hidden subagent|Architecture specs, trade-offs|EXPLORE|
|Implementer|Hidden subagent|Code implementation|EXPLOIT only|
|Compiler|Hidden subagent|Prompt compression|EXPLOIT|

## Edit Workflow

```
1. Edit: agents/source/{agent}.src.md
2. Compile: Invoke Compiler agent
3. Output: agents/compiled/{agent}.agent.md
4. Deploy: bin/install.sh (copies snapshot to .github/agents/)
```

## Kernel Inheritance

All agents inherit rules from `kernel/`:
- `three-laws.md` — Immutable behavioral anchors
- `quality-gates.md` — Phase transition verification
- `mode-protocol.md` — EXPLORE↔EXPLOIT switching
- `tool-stakes.md` — Risk classification
- `human-loop.md` — Human intervention protocol

## Never

- Edit files in `compiled/` — they are generated
- Skip kernel inheritance in dispatches
- Bypass quality gates
