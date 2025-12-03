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

|Agent|Purpose|Mode|
|-|-|-|
|Orchestrator|Multi-phase coordination|EXPLORE/EXPLOIT|
|Implementer|Code implementation|EXPLOIT only|
|Compiler|Prompt compression|EXPLOIT|

## Edit Workflow

```
1. Edit: agents/source/{agent}.src.md
2. Compile: Invoke Compiler agent
3. Output: agents/compiled/{agent}.agent.md
4. Deploy: Via .github/agents symlink
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
