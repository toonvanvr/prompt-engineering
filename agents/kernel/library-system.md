# Library System

Knowledge persistence layer for per-repo learning.

---

## Core Principle

> Knowledge discovered during execution persists in `.ai/library/`.
> Skills source: `agents/skills/`. Installed to `.github/skills/` by `bin/install.sh`.
> Library grows organically; index.md files generated automatically.

## Directory Reference

|Directory|Purpose|Content Type|Lifetime|
|-|-|-|-|
|`.ai/library/`|GENERIC reusable knowledge|Patterns, domain facts, conventions|Permanent|
|`.ai/scratch/`|TEMPORAL phase-specific work|Drafts, WIP, phase outputs, debug logs|Session|
|`.ai/feedback/`|Cross-session learning|Pattern failures, successes, quirks|Permanent|

NEVER put temporal content in library/. NEVER put reusable knowledge only in scratch/.

## Folder Structure

```
.ai/library/
├── patterns/         # WHAT works (structural)
├── domain/           # WHAT things mean (conceptual)
├── quirks/           # WHAT to watch out for (operational)
└── index.md          # Auto-generated directory
```

|Folder|Content|Examples|
|-|-|-|
|`patterns/`|Reusable solutions, templates|"Builder pattern for test data"|
|`domain/`|Business/technical concepts|"FIBO transfer lifecycle"|
|`quirks/`|Tool oddities, workarounds|"exec zsh for terminal capture"|

## Pattern Management (from pattern-system.md)

**Conflict Prevention:** Before adding a pattern, check existing patterns for contradictions. If found, document the conflict in the new pattern file with resolution rationale.

**Naming:** Use descriptive names: `{what-it-solves}.md`. No abbreviations, no version numbers in filenames.

**Format:** Each pattern file: 1-paragraph description → when to use → when NOT to use → example (≤5 lines).

## Skills (VS Code Native)

Skills follow the [Agent Skills](https://agentskills.io/) open standard. Source: `agents/skills/`. Installed to `.github/skills/` (VS Code native location via `chat.agentSkillsLocations`).

```
agents/skills/{skill-name}/
├── SKILL.md           # Skill definition (YAML frontmatter + instructions)
├── examples/          # Example files
└── resources/         # Scripts, templates
```

Skills are NOT stored in `.ai/library/`. Separate concern at repo root level.

## Growth Protocol

1. **Identify category**: HOW/WHAT works → patterns/ | WHAT means → domain/ | WHAT breaks → quirks/
2. **Check existing**: Search `.ai/library/{category}/` for duplicates
3. **Create or update**: New topic → create file. Existing → append/update.
4. **Update index**: Add entry to `{category}/index.md`

Start flat, add depth when needed (e.g., `patterns/testing/builder-pattern.md`).

## Agent Integration

**Startup:** Scan `.github/skills/` for available skills (YAML frontmatter). Scan `.ai/library/` for patterns, domain knowledge, quirks.

**During Execution:** Task matches skill description → load from `.github/skills/`. New knowledge discovered → write to `.ai/library/`. Before termination → update index.md.

## Cross-Tool Compatibility

|Tool|Skill Location|Format|
|-|-|-|
|VS Code Copilot|`.github/skills/`|SKILL.md|
|Claude Code|`.claude/skills/`|SKILL.md|

## Install Strategy

Files copied (snapshot) during `bin/install.sh`. No symlinks.

|Installed Path|Source|Purpose|
|-|-|-|
|`.github/agents/*.agent.md`|`agents/compiled/`|Agent definitions|
|`.github/agents/kernel/`|`agents/kernel/`|Behavioral rules|
|`.github/skills/`|`agents/skills/` (source repo)|Reusable skills|
