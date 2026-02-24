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
|workfolder|Session directory: `.ai/scratch/{YYYY-MM-DD}_{topic-slug}/`|
|ai_status.md|`{workfolder}/communication/ai_status.md` — status file with Human Input section for ACTION entries|
|_handoff.md|`{workfolder}/_handoff.md` — completion artifact; MUST exist before agent terminates|
|_error.md|`{workfolder}/_error.md` — error exit artifact; created on failure|
|kernel|Core behavioral rules in `agents/kernel/` inherited by all agents|
|feedback/|`.ai/feedback/*.md` — persistent cross-session failure/success patterns|
|library/|`.ai/library/` — reusable knowledge (patterns, domain, conventions)|
|scratch/|`.ai/scratch/` — temporal session work (NOT reusable)|

## Architecture

- **Orchestrator** is the only user-facing agent — coordinates all work
- **Sub-agents** (Implementer, Designer, Researcher, Compiler) are hidden (`user-invokable: false`)
- **File flow**: `agents/source/*.src.md` → (Compiler) → `agents/compiled/*.agent.md`
- **Communication**: via `{workfolder}/communication/` directory
- **Knowledge persistence**: via `.ai/library/` directory
- **State transfer**: file-mediated, NEVER conversation-mediated

> Note: Kernel paths use `agents/kernel/` (source repo). Deployed path: `.github/agents/kernel/`.
