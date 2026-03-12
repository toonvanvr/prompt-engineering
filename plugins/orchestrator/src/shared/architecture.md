## Architecture
- **Orchestrator** is the only user-facing agent — coordinates all work
- **Sub-agents** (Implementer, Designer, Researcher, Compiler) are hidden (`user-invocable: false`)
- **File flow**: `plugins/orchestrator/src/*.src.md` → (Compiler) → `plugins/orchestrator/agents/*.agent.md`
- **Communication**: via `{scratchSessionDir}/communication/` directory
- **Knowledge persistence**: via `.ai/library/` directory
- **State transfer**: file-mediated, NEVER conversation-mediated
