---
name: Self-Verification
description: Verify agent framework integrity after changes. Only loaded in the prompt-engineering source repo.
repo-only: true
---

# Self-Verification

## When to Use
After any source, kernel, or structural change to the agent framework. Run before committing.

## Verification Checklist

### 1. Pipeline Integrity
- `grep -c 'UNRESOLVED' plugins/orchestrator/src/precompiled/*.pre.md` — must all be 0
- `grep -rn '^```' plugins/orchestrator/src/*.src.md plugins/orchestrator/agents/*.agent.md plugins/orchestrator/skills/*/SKILL.md | grep -v templates/` — fence check (expect 0 for non-template files)

### 2. Compilation Freshness
- For each agent: precompiled must not be newer than compiled
- `stat -c '%Y %n' plugins/orchestrator/src/precompiled/*.pre.md plugins/orchestrator/agents/*.agent.md`

### 3. Reference Integrity
- `grep -roh '`[a-zA-Z/._-]*\.md`' plugins/orchestrator/src/ plugins/orchestrator/src/kernel/ plugins/orchestrator/agents/ plugins/orchestrator/skills/ | sort -u` → verify each path exists
- Check for stale references to old path prefixes (should use `plugins/orchestrator/` prefix)

### 4. Skill Integrity
- All SKILL.md files must start with `---` (YAML frontmatter) or `# ` (heading), never ` ``` `
- `head -1 plugins/orchestrator/skills/*/SKILL.md` — verify no fence guards
- Count: `ls -d plugins/orchestrator/skills/*/SKILL.md | wc -l` — should match expected count

### 5. Structure Verification
- `plugins/orchestrator/agents/*.agent.md` files exist (5 agents)
- `plugins/orchestrator/src/kernel/` directory has all kernel files
- `plugins/orchestrator/skills/*/SKILL.md` files exist
- `test -f plugins/orchestrator/agents/*.agent.md && echo exists` — verify compiled output

### 6. Version Identification
- `cat VERSION` — source version
