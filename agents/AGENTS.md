# agents/

Agent framework for orchestrated AI task execution.

## Structure

|Path|Purpose|Edit?|
|-|-|-|
|`source/`|Human-readable definitions (.src.md)|YES|
|`compiled/`|Token-optimized deployment (.agent.md)|NO|
|`kernel/`|Compile-time reference only (not deployed at runtime)|NO (migrated)|
|`modes/`|EXPLORE/EXPLOIT specifications|RARELY|
|`templates/`|Sub-agent dispatch templates|YES|
|`shared/`|Composable text fragments for source files|YES|
|`reference/`|Detailed tables/schemas for compilation|YES|
|`precompiled/`|Resolved intermediary files (.pre.md)|NO (generated)|

## Agent Types

Only the **Orchestrator** is user-facing. All others are hidden subagents (`user-invocable: false`).

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
2. Resolve: Phase 1 — @include resolution → agents/precompiled/{agent}.pre.md
3. Compile: Phase 2 — Token compression → agents/compiled/{agent}.agent.md
4. Deploy: bin/install.sh (copies snapshot to .github/agents/)
```

## Kernel Status

Kernel files (`kernel/`) are compile-time reference only — not deployed at runtime. Rules are inlined into agents at compile time via `@include` directives and the two-phase compilation pipeline. Content has been migrated to:
- `agents/shared/` — glossary, thoroughness, model-behavior (@include targets)
- `skills/` — feedback-loop, self-analysis, verification
- `AGENTS.md` files — TODO conventions, library system

See `kernel/AGENTS.md` for the full migration table.

## Never

- Edit files in `compiled/` or `precompiled/` — they are generated
- Skip kernel references in dispatches
- Bypass quality gates

## TODO Conventions

Standardized TODO annotations for consistent priority handling.

|Tag|Priority|Description|Action|
|-|-|-|-|
|`TODO(0)`|Critical|Never merge with this|Block release|
|`TODO(1)`|High|Architectural flaws, major bugs|Fix before PR|
|`TODO(2)`|Medium|Minor bugs, missing features|Fix soon|
|`TODO(3)`|Low|Polish, tests, documentation|Backlog|
|`TODO(4)`|Question|Investigation needed|Research|
|`PERF`|Special|Performance optimization|Profile first|

**Rules:** `TODO(0)` blocks all merges. Always include priority number. On discovery: log to analysis artifacts, do not fix TODOs outside scope. On creation: match to severity.
