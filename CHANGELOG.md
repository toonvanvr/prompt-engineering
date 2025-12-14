# Changelog

All notable changes to the agent system.

## [Unreleased] - 2025-12-14 (continued)

### Removed
- **agents/lib/** folder — Empty concept, eliminated
- **.ai/suggestions/** — Unused, replaced by feedback
- **.ai/feedback-outbox/** — Replaced by `.github/agents/feedback/`
- **QUICKSTART scaffolding** — .human/, lib/ no longer created at install

### Changed
- **QUICKSTART.sh** — Now creates only agent symlinks + README (87.5% folder reduction)
- **Feedback location** — Consolidated to `.github/agents/feedback/`

### Added
- **.github/agents/README.md** — Usage instructions for third-party repos
- **.github/agents/.source** — Stores source repo path for on-demand features

## [Unreleased] - 2025-12-14

### Added
- **Autonomous execution model** — Agents now run autonomously by default; human checkpoints reduced from 18 to 4 (Task-start, Pre-impl, Deviation, Escalation)
- **Thoroughness kernel** — New `kernel/thoroughness.md` with read-completeness guarantees and size-aware strategies
- **Multi-lens review** — 5-persona review lenses (Adversary, Simplifier, Tired User, Newcomer, Maintainer) for design review phase
- **VSCode sub-agent optimization** — Agent descriptions optimized for `chat.customAgentInSubagent.enabled` inference
- **Startup timestamp** — Orchestrator now captures timestamp for workfolder naming
- **Interpretation sub-agent** — Size M/L tasks use sub-agent for pre-analysis
- **Feedback outbox** — QUICKSTART.sh creates `.ai/feedback-outbox/` for bidirectional feedback

### Changed
- **Prompt archival** — Processed instructions now move to `.ai/scratch/{workfolder}/00_prompts/` instead of `.human/processed/`
- **Agent descriptions** — Orchestrator, Implementer, Compiler YAML frontmatter updated for distinct trigger words
- **Phase flow diagrams** — Converted from ASCII to Mermaid format
- **Human-loop checkpoints** — Passive scan model (no blocking except abort/escalation)

### Deprecated
- `pause.md` template — Conflicts with autonomous execution model
- `priority.md` template — Sub-agents don't have task queues

### Removed
- `.human/processed/` path — Replaced by scratch folder archival

## Design Decisions

### Why 4 checkpoints instead of 18?
The goal is autonomous execution. Original 18 checkpoints created friction requiring "skip human checks" commands. The 4 remaining checkpoints cover:
1. **Task-start** — Capture pre-seeded instructions
2. **Pre-implementation** — Last chance before irreversible changes
3. **Deviation** — Contract violation requires intervention
4. **Escalation** — Human already involved

### Why Mermaid over ASCII?
Human feedback: "ASCII charts are forbidden and should all be done in mermaid." Mermaid provides:
- Consistent rendering across environments
- Better accessibility
- Easier maintenance
- Interactive features in supporting viewers

### Why sub-agent for interpretation?
Human feedback: "Make sure that also the prompt pre-analysis/investigation phase is handled using a subagent." Benefits:
- Context isolation for large tasks
- Parallel investigation possible
- Cleaner orchestrator focus on synthesis
