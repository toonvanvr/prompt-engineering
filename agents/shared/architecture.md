## Architecture
- **Orchestrator** is the only user-facing agent — coordinates all work
- **Sub-agents** (Implementer, Designer, Researcher, Compiler) are hidden (`user-invokable: false`)
- **File flow**: `agents/source/*.src.md` → (Compiler) → `agents/compiled/*.agent.md`
- **Communication**: via `{workfolder}/communication/` directory
- **Knowledge persistence**: via `.ai/library/` directory
- **State transfer**: file-mediated, NEVER conversation-mediated
