# Changelog

All notable changes to the agent system.

## [Unreleased] - 2025-12-14 (continued)

### Removed
- **agents/lib/** folder — Empty concept, eliminated
- **.ai/suggestions/** — Unused, replaced by feedback
- **.ai/feedback-outbox/** — Replaced by `.github/agents/feedback/`

### Changed
- **QUICKSTART.sh** — Now creates `.human/` folder with templates + agent symlinks
- **Feedback location** — Consolidated to `.github/agents/feedback/`
- **Async scan checkpoints** — Expanded from 4 to 6 (added Phase-start, Pre-gate for planning phases)

### Added
- **.github/agents/README.md** — Usage instructions for third-party repos
- **.github/agents/.source** — Stores source repo path for on-demand features
- **QUICKSTART .gitignore handling** — Appends 3 agent symlink entries if not present

## [Unreleased] - 2025-12-14

### Added
- **Autonomous execution model** — Agents run autonomously; async `.human/` scans at 6 checkpoints (Task-start, Phase-start, Pre-gate, Pre-impl, Deviation, Escalation)
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

### Why 6 checkpoints instead of 18?
The goal is autonomous execution with async override capability. Original 18 checkpoints created friction requiring "skip human checks" commands. The 6 remaining checkpoints cover:
1. **Task-start** — Capture pre-seeded instructions
2. **Phase-start** — Before Analysis/Design/Review phases begin
3. **Pre-gate** — Before phase gates (last chance to influence planning)
4. **Pre-implementation** — Last chance before irreversible changes
5. **Deviation** — Contract violation requires intervention
6. **Escalation** — Write to `.human/` and halt

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
