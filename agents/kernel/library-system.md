# Library System

Knowledge persistence layer for per-repo learning.

---

## Core Principle

> Knowledge discovered during execution persists in `.ai/library/`.
> Skills follow Agent Skills standard for cross-tool portability.
> Library grows organically; index.md files generated automatically.

---

## Folder Structure

```
.ai/library/
├── skills/           # HOW to do things (procedural)
├── patterns/         # WHAT works (structural)
├── research/         # WHY things are (exploratory)
├── domain/           # WHAT things mean (conceptual)
├── quirks/           # WHAT to watch out for (operational)
└── index.md          # Auto-generated directory
```

### Category Definitions

|Folder|Content|Examples|
|-|-|-|
|`skills/`|Teachable procedures, step-by-step|"How to debug Rails tests"|
|`patterns/`|Reusable solutions, templates|"Builder pattern for test data"|
|`research/`|Investigation findings, comparisons|"Auth library comparison"|
|`domain/`|Business/technical concepts|"FIBO transfer lifecycle"|
|`quirks/`|Tool oddities, workarounds|"exec zsh for terminal capture"|

---

## Skills Format (Agent Skills Standard)

Skills follow the [Agent Skills](https://agentskills.io/) open standard:

```markdown
---
name: skill-name
description: What this skill does (max 1024 chars)
---

# Skill Instructions

## When to Use
- Condition 1
- Condition 2

## Steps
1. Step one
2. Step two

## Examples
...

## Resources
- [helper script](./helper.sh)
```

### Progressive Disclosure

1. **Discovery**: Agent reads `name` + `description` from YAML
2. **Instructions**: If relevant, loads full body
3. **Resources**: Accesses files only when referenced

### Skill Folder Structure

```
.ai/library/skills/{skill-name}/
├── SKILL.md           # Skill definition
├── examples/          # Example files
└── resources/         # Scripts, templates
```

---

## Non-Skill Content

Other library folders use plain markdown:

```markdown
# {Title}

**Category**: patterns | research | domain | quirks
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
1. Scan `.ai/library/skills/` for available skills
2. Load skill descriptions (YAML frontmatter only)
3. Keep skill names in context for matching
```

### During Execution

```md
- When task matches skill description → load skill body
- When discovering new knowledge → write to library
- Before termination → update index.md files
```

### Skill Matching

Compare task description against skill descriptions:

```
Task: "Write integration tests for the API"
Matched: skills/testing/SKILL.md (description mentions "integration tests")
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

See `skills/maintain-library/SKILL.md` for maintenance procedures.

Maintenance includes:
- Validating skills still apply
- Flagging outdated research
- Verifying quirks still exist
- Regenerating indexes

---

## Cross-Tool Compatibility

|Tool|Skill Location|Format|
|-|-|-|
|VS Code Copilot|`.github/skills/`|SKILL.md|
|Claude Code|`.claude/skills/`|SKILL.md|
|This system|`.ai/library/skills/`|SKILL.md|

Skills can be symlinked to `.github/skills/` for VS Code compatibility.

### Symlink Strategy

For maximum tool compatibility, create symlinks at project install:

|Symlink|Target|Purpose|
|-|-|-|
|`.github/lib/`|`.ai/library/`|VS Code Copilot skill access|
|`.github/feedback/`|`.ai/feedback/`|Unified feedback collection|

**Install Script Creates:**

```bash
# In project-level install.sh or QUICKSTART.sh
mkdir -p .github
ln -sf ../.ai/library .github/lib
ln -sf ../.ai/feedback .github/feedback
```

**Git Handling:**
- Symlinks checked in (not targets)
- `.gitignore` already ignores `.ai/` contents as needed
- Enables tools that read `.github/` to access shared knowledge

**Verification:**
```bash
# Check symlinks exist and point correctly
test -L .github/lib && test -L .github/feedback
```
