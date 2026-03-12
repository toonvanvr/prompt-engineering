# Glossary

Shared terminology across all agents.

---

## System Terms

|Term|Definition|
|-|-|
|SA (Sub-Agent)|Spawned agent with separate context window. **Orchestrator view:** dispatch via `runSubAgent` tool, coordinate results. **SA view:** you execute in an isolated context; inputs from files; outputs to files; you cannot spawn other SAs|
|EXPLORE|Discovery mode: creativity enabled, options allowed, verification via documentation|
|EXPLOIT|Execution mode: zero deviation, verification mandatory, creativity disabled|
|Stakes|Risk level: LOW (proceed) / MEDIUM (log) / HIGH (pre-approved) / BLOCKED (forbidden)|
|Quality Gate|Checkpoint that MUST pass before next phase; gates are immutable|
|scratchSessionDir|Session directory: `.ai/scratch/{YYYY-MM-DD}_{topic-slug}/`|
|ai_status.md|`{scratchSessionDir}/communication/ai_status.md` — status file with Human Input section for ACTION entries|
|_handoff.md|`{scratchSessionDir}/_handoff.md` — completion artifact; MUST exist before agent terminates|
|_error.md|`{scratchSessionDir}/_error.md` — error exit artifact; created on failure|
|kernel|Core behavioral rules in `plugins/orchestrator/src/kernel/` inherited by all agents|
|feedback/|`.ai/feedback/*.md` — persistent cross-session failure/success patterns|
|library/|`.ai/library/` — reusable knowledge (patterns, domain, conventions)|
|scratch/|`.ai/scratch/` — temporal session work (NOT reusable)|

## Architecture

- **Orchestrator** is the only user-facing agent — coordinates all work
- **Sub-agents** (Implementer, Designer, Researcher, Compiler) are hidden (`user-invocable: false`)
- **File flow**: `plugins/orchestrator/src/*.src.md` → (Compiler) → `plugins/orchestrator/agents/*.agent.md`
- **Communication**: via `{scratchSessionDir}/communication/` directory
- **Knowledge persistence**: via `.ai/library/` directory
- **State transfer**: file-mediated, NEVER conversation-mediated

> Note: Kernel paths use `plugins/orchestrator/src/kernel/` (source repo).
