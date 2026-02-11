# Library System

Knowledge persistence layer for per-repo learning.

---

## Core Principle

> Knowledge discovered during execution persists in `.ai/library/`.
> Skills live at `.github/skills/` (VS Code native format).
> Library grows organically; index.md files generated automatically.

---

## Directory Reference

|Directory|Purpose|Content Type|Lifetime|
|-|-|-|-|
|`.ai/library/`|GENERIC reusable knowledge|Patterns, domain facts, conventions|Permanent|
|`.ai/scratch/`|TEMPORAL phase-specific work|Drafts, WIP, phase outputs, debug logs|Session|
|`.ai/feedback/`|Cross-session learning|Pattern failures, successes, quirks|Permanent|

NEVER put phase-specific or temporal content in library/. NEVER put reusable knowledge only in scratch/.

---

## Folder Structure

```
.ai/library/
├── patterns/         # WHAT works (structural)
├── domain/           # WHAT things mean (conceptual)
├── quirks/           # WHAT to watch out for (operational)
└── index.md          # Auto-generated directory
```

Skills are stored separately at `.github/skills/` using the VS Code native skills format.

### Category Definitions

|Folder|Content|Examples|
|-|-|-|
|`patterns/`|Reusable solutions, templates|"Builder pattern for test data"|
|`domain/`|Business/technical concepts|"FIBO transfer lifecycle"|
|`quirks/`|Tool oddities, workarounds|"exec zsh for terminal capture"|

---

## Skills (VS Code Native)

Skills follow the [Agent Skills](https://agentskills.io/) open standard and are stored at `.github/skills/` — the VS Code native location discovered via `chat.agentSkillsLocations`.

```
.github/skills/{skill-name}/
├── SKILL.md           # Skill definition (YAML frontmatter + instructions)
├── examples/          # Example files
└── resources/         # Scripts, templates
```

Skills are NOT stored in `.ai/library/`. They are a separate concern managed at the repository root level.

---

## Library Content Format

Library folders (patterns/, domain/, quirks/) use plain markdown:

```markdown
# {Title}

**Category**: patterns | domain | quirks
**Created**: {ISO8601}
**Updated**: {ISO8601}

---

## Summary
{Brief description}

## Content
{Main content}

## Related
- [{link}]({path})
```

---

## Growth Protocol

### Adding Knowledge

During execution, when discovering reusable knowledge:

1. **Identify category**: HOW/WHAT works/WHY/WHAT means/WHAT breaks
2. **Check existing**: Search `.ai/library/{category}/` for duplicates
3. **Create or update**: 
   - New topic → create file/folder
   - Existing topic → append/update
4. **Update index**: Add entry to `{category}/index.md`

### Folder Hierarchy

Start flat, add depth when needed:

```
# Initial
.ai/library/patterns/
├── builder-pattern.md
└── factory-pattern.md

# After growth
.ai/library/patterns/
├── testing/
│   ├── builder-pattern.md
│   └── factory-pattern.md
├── api/
│   └── versioning.md
└── index.md
```

---

## Agent Integration

### Startup

```md
1. Scan `.github/skills/` for available skills
2. Load skill descriptions (YAML frontmatter only)
3. Scan `.ai/library/` for patterns, domain knowledge, quirks
```

### During Execution

```md
- When task matches skill description → load skill from `.github/skills/`
- When discovering new knowledge → write to `.ai/library/`
- Before termination → update index.md files
```

### Skill Matching

Compare task description against skill descriptions:

```
Task: "Write integration tests for the API"
Matched: .github/skills/testing/SKILL.md (description mentions "integration tests")
Action: Load skill instructions
```

---

## Index Generation

Each category has `index.md`:

```markdown
# {Category} Index

Auto-generated. Last updated: {ISO8601}

## Contents

|Name|Path|Description|
|-|-|-|
|{name}|{path}|{summary}|
```

Update when:
- New content added
- Existing content modified
- Periodic maintenance

---

## Maintenance

Maintenance includes:
- Validating patterns still apply
- Verifying quirks still exist
- Updating domain knowledge
- Regenerating indexes
- Checking `.github/skills/` for outdated skills

---

## Cross-Tool Compatibility

|Tool|Skill Location|Format|
|-|-|-|
|VS Code Copilot|`.github/skills/`|SKILL.md|
|Claude Code|`.claude/skills/`|SKILL.md|

Skills live at `.github/skills/` — the VS Code native default. VS Code discovers them via the `chat.agentSkillsLocations` setting.

### Install Strategy

Files are copied (snapshot) during `bin/install.sh`. No symlinks are used.

|Installed Path|Source|Purpose|
|-|-|-|
|`.github/agents/*.agent.md`|`agents/compiled/`|Agent definitions|
|`.github/agents/kernel/`|`agents/kernel/`|Behavioral rules|
|`.github/skills/`|`.github/skills/` (source repo)|Reusable skills (VS Code native)|

**Git Handling:**
- Copied files are checked in
- `.gitignore` already ignores `.ai/` contents as needed
- Enables tools that read `.github/` to access shared knowledge

**Verification:**
```bash
# Check installed files exist
test -d .github/agents && test -d .ai/library
```
