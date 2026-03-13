# Changelog

## [3.0.0-beta.1] - 2026-03-13

### Added
- Parallel compilation instruction file (`.github/instructions/parallel-compilation.instructions.md`)
- Plugin README for VS Code Extensions panel (`plugins/orchestrator/README.md`)
- Prompting guide with real-world examples organized by prompt style
- Safe file swap protocol with atomic `mv` rename for compiler self-compilation

### Changed
- Simplified root README setup to single JSONC code block with commented alternative
- Replaced fabricated example prompts with authentic natural-language examples (one-liner, multi-concern, stream-of-consciousness)
- All JSONC code blocks now have trailing commas for paste-safety
- Orchestrator startup: `edit/createDirectory` for root + terminal bulk `mkdir -p` for subdirs (UX improvement)
- Mandatory prompt interpretation enforced as first SA with explicit gate
- Added interpretation → research decision criteria table to orchestrator source
- Version bumped from 3.0.0-alpha.2 to 3.0.0-beta.1

### Fixed
- Stale `../compiled/` path reference in orchestrator source (→ `../agents/`)
- Broken `agents/AGENTS.md` and `skills/AGENTS.md` references in kernel AGENTS.md

### Removed
- Fabricated example files (bug-fix.md, cli-tool.md, documentation-site.md, feature-addition.md, refactoring.md, ticket-board.md)
- "Remote Plugin" section from README
- Separate Marketplace/Local Clone setup subsections (consolidated into single block)

## [3.0.0-alpha.2] - 2026-03-12

### Breaking Changes
- Restructured to VS Code Agent Plugin format with marketplace.json
- Moved all files from `agents/` and `skills/` into `plugins/orchestrator/`
- Removed `bin/install.sh` — replaced by documentation and Copilot Setup agent
- Removed `.github/agents/` snapshot deployment — compiled agents served directly from `plugins/orchestrator/agents/`
- Removed all backward compatibility with pre-plugin layout

### Added
- Marketplace index at `.github/plugin/marketplace.json` (compatible with awesome-copilot)
- Per-plugin manifest at `plugins/orchestrator/.github/plugin/plugin.json`
- Claude Code support via `plugins/orchestrator/.claude-plugin/plugin.json`
- Copilot Setup (toonvanvr) agent — interactive VS Code settings configuration
- Web tool awareness — orchestrator delegates web research to sub-agents
- Example prompts (replaced in 3.0.0-beta.1)
- Detailed setup guide at `docs/setup.md`

### Changed
- All agents renamed with `(toonvanvr)` suffix for namespace safety
- Numeric SA thresholds replaced with principle-based delegation guidance
- Hard SA batch limit (5) removed — parallelism encouraged by design
- Task sizing scoring formula replaced with qualitative scaling
- Context budget fixed checkpoints replaced with awareness-based assessment
- Compilation pipeline paths: `plugins/orchestrator/src/` → `plugins/orchestrator/agents/`
- README fully rewritten for plugin-native setup (marketplace, local, remote)
- Release workflow updated for plugin archive format

### Removed
- `bin/install.sh` (485-line bash installer)
- `bin/verify-agent-regressions.sh`
- `tests/install/` (installer tests)
- `.github/agents/` snapshot directory
- `.github/skills/` directory
- `examples/` top-level directory (moved to `plugins/orchestrator/docs/examples/`)
- Dummy agent (`.github/agents/dummy.agent.md`)

## [3.0.0-alpha.1] - 2026-03-12

### Breaking Changes
- Removed runtime kernel dependency — kernel rules now inlined at compile time
- Removed `handoffs:` from frontmatter (deprecated by VS Code)
- Changed orchestrator from terminal writes (`cat`/`echo`) to native `create_file`/`create_directory` tools

### Added
- WBS-driven wave planning replaces hard task/SA caps
- Mandatory prompt interpretation via @Researcher SA for all prompts
- Parallel compilation support (5 @Compiler SAs simultaneously)
- Enhanced self-repo awareness with path/cross-file validation
- `.github/agents/dummy.agent.md` tool catalog

### Changed
- Kernel files migrated: 3 → shared/@include, 3 → skills, 2 → AGENTS.md, 7 deleted, 6 confirmed already-inlined
- Install script simplified (no kernel installation)
- Release workflow updated (no kernel in archive)
- SA batch limit increased from 3 to 5 concurrent
- Version bump from 2.3.0 to 3.0.0-alpha.1

## [2.3.0] - 2026-03-05


### Added
- Fence guard in `install.sh` to skip skills with wrapping code fences
- Fence Guard Check in verification skill
- Self-verification skill (`agents/skills/self-verify/SKILL.md`, repo-only)
- Small-Task Protocol in orchestrator for graduated pipeline skip
- Compiler tool availability documentation
- Agent regression gate script (`bin/verify-agent-regressions.sh`) for source/compiled/snapshot tools parity and orchestrator anchor checks

### Changed
- Relocated skills from `.github/skills/` to `agents/skills/` (source of truth)
- Updated `bin/install.sh` to source skills from `agents/skills/`
- Extended Compiler Code Block Guard to cover all framework file types
- Expanded orchestrator with Small-Task Protocol (score 30-50)
- **Orchestrator source overhaul** — tool rationalization, verbatim prompt resolution, variable rename, parallelization guidance, changelog convention, mode derivation
- Canonicalized `tools:` frontmatter in all `agents/source/*.src.md` to match `.github/agents/` snapshot
- Updated release workflow to run regression verification and package `.github/agents/` in release archives
- Hardened orchestrator CHANGELOG instruction to require version check and release metadata backfill from prior section patterns

### Fixed
- Updated CI/release flow to materialize `.github/agents/` snapshots and let regression parity checks fall back to source tools when snapshots are missing.
- Aligned release archive skills path to `agents/skills/` to prevent missing-path failures
- Removed `three-laws` assumption that delegation depends on orchestrator tool removal; delegation now enforced as structural law independent of frontmatter tool set
- Removed wrapping code fences from 8 SKILL.md files
- Removed wrapping code fence from `agents/source/implementer.src.md`
- Fixed stale `.github/skills/` references in source-context files

## [2.3.0-alpha.1] - 2026-03-04

### Added
- **8 new VS Code skills** — feedback-loop, output-format, prompt-audit, reference-integrity, self-diagnosis, tool-risk, vagueness-handling, verification
- **`agents/reference/consistency-stack.md`** — moved from kernel to reference (detail table)
- **`.github/.gitignore`** — gitignore for skills directory

### Changed
- **Kernel consolidation** — merged `human-loop.md` into `communication.md`, `escalation.md` into `quality-gates.md`, `pattern-system.md` into `library-system.md`, `sub-agent-mandate.md` inlined into orchestrator, `consistency-stack.md` moved to `agents/reference/`
- **`agents/kernel/context-budget.md`** — simplified, checkpoints moved to quality-gates
- **`agents/kernel/quality-gates.md`** — restructured with merged escalation content
- **`agents/kernel/communication.md`** — consolidated with human-loop protocol
- **`agents/kernel/library-system.md`** — merged with pattern-system
- **`agents/kernel/mode-protocol.md`** — added skill reference
- **`agents/kernel/three-laws.md`** — added skill cross-references
- **All 5 agent source files** — updated kernel references for consolidation
- **`agents/templates/dispatch-base.md`** — updated references
- **`agents/templates/dispatch-implement.md`** — updated references
- **`bin/install.sh`** — skill installation support
- **`agents/kernel/AGENTS.md`** — updated file reference with redirects for merged files
- **`post-sa-review` skill** — updated for consolidated kernel

## [2.2.1] - 2026-03-04

### Fixed
- **`communication/ai_status.md`** — path qualification and reference corrections
- **`agents/kernel/quality-gates.md`** — expanded checkpoint protocol
- **`agents/kernel/tool-stakes.md`** — path corrections
- **`agents/kernel/prompt-preservation.md`** — path fix
- **`agents/shared/constraints.md`** — constraint clarification
- **`agents/source/orchestrator.src.md`** — reference fixes
- **`agents/templates/dispatch-base.md`** — template path fixes
- **`agents/templates/dispatch-implement.md`** — template path fixes

### Changed
- **`agents/kernel/AGENTS.md`** — updated file reference
- **`agents/source/compiler.src.md`** — minor updates
- **`agents/source/implementer.src.md`** — reference correction

## [2.2.0] - 2026-02-24

### Added
- **`agents/kernel/verification-methods.md`** — lightweight SA verification methods
- **`agents/kernel/model-behavior.md`** — cross-model consistency rules

### Changed
- **`agents/kernel/communication.md`** — expanded communication protocol
- **`agents/kernel/context-budget.md`** — simplified budget rules
- **`agents/kernel/feedback-collection.md`** — immediate feedback capture
- **`agents/kernel/thoroughness.md`** — updated context reading rules
- **`agents/kernel/output-budget.md`** — adjusted output limits
- **`agents/kernel/quality-gates.md`** — added checkpoint rules
- **`agents/source/orchestrator.src.md`** — ai_status integration, tools update
- **`agents/source/designer.src.md`** — minor update
- **`agents/source/researcher.src.md`** — minor update
- **`agents/templates/dispatch-base.md`** — simplified dispatch template
- **`agents/shared/constraints.md`** — constraint update
- **`agents/shared/startup-protocol.md`** — startup update
- **`bin/install.sh`** — improvements

## [2.1.0] - 2026-02-23

### Added
- **Source deduplication via @include directives** — 3963 → 1210 lines (69% reduction) across all 5 agent source files
- **`agents/shared/` directory** — 5 composable fragments: architecture, startup-protocol, handoff-format, constraints, README
- **`agents/reference/` directory** — 3 detail files: compression-tables, frontmatter-schema, README
- **Two-phase compilation pipeline** — source → precompiled (`.pre.md`, @include resolved) → compiled (`.agent.md`, token-compressed)
- **`agents/precompiled/` directory** — 5 resolved intermediary files + README
- **Post-compaction handbook** — orchestrator recovery system with mandatory read (`agents/templates/handbook.md`)
- **8 new kernel rules** — Read-Before-Write Guard, Purpose Clarity, 3-Call Rule, Failure Budget, Deliverable Gate, Concept Compression, 80% Ceiling, End-of-Session Processing
- **`agents/kernel/pattern-system.md`** — Pattern conflict prevention + naming conventions

### Changed
- **`bin/install.sh`** — Smart change detection (`cmp -s`), 3 modes (`--mode=install|update|check`), `--verbose`, per-file reporting, pipeline staleness warnings
- **`README.md`** — Reworked with pipeline docs, new structure, install modes
- **Root `AGENTS.md`** — Updated directory structure overview
- **`agents/AGENTS.md`** — Added shared/, reference/, precompiled/ directories
- **`agents/kernel/AGENTS.md`** — Added new kernel rules to file reference
- **6 kernel files** — New rules appended (context-budget, output-budget, quality-gates, self-analysis, thoroughness, tool-stakes)
- **All 5 agent source files** — Deduplicated via @include directives

## [2.0.0] - 2026-02-08

### Added
- **Standalone bash installer** (`bin/install.sh`) — Download, extract, install with one command
- **VS Code native skills** (`.github/skills/`) — Skills follow the Agent Skills standard, auto-discovered by VS Code
- **Curl one-liner install** — `curl -fsSL .../install.sh | bash -s -- .`
- **Idempotent gitignore management** — Lines added only if missing
- **Self-install detection** — Installer handles the prompt-engineering repo itself

### Changed
- **Skills location** — `.ai/library/skills/` → `.github/skills/` (committed, VS Code native)
- **Library scope** — `.ai/library/` now contains only patterns, domain, quirks (runtime knowledge)
- **GitHub workflow** — Tag sets VERSION file (not validates against it)
- **Release archive** — Includes `.github/skills/`, `bin/install.sh`; excludes ASDF scripts
- **Gitignore templates** — `.ai/.gitignore` simplified to `*` wildcard
- **Documentation** — Complete rewrite for v2 install flow

### Removed
- **mise/ASDF plugin** — `bin/download`, `bin/install`, `bin/list-all`, `mise.toml`
- **`tvv-pe` CLI** — Replaced by `bin/install.sh`
- **`lib/init.sh`** — Logic consolidated into `bin/install.sh`
- **Cross-repo feedback CLI** — `tvv-pe ls`, `tvv-pe feedback *` commands
- **`~/.config/tvv-pe/repos`** — Feedback registry removed
- **`QUICKSTART.sh`** — Deprecated artifact removed
- **`docs/` folder** — Consolidated into README.md
- **`.ai/library/skills/`** — Moved to `.github/skills/`
- **`.ai/library/research/`** — Empty, unused, removed from structure
- **`skills:` YAML frontmatter** — Not supported by VS Code, removed from agents
