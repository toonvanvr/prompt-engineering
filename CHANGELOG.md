# Changelog

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
