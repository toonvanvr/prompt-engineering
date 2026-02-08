# Changelog

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
