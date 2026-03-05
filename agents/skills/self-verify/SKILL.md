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
- `bin/install.sh . --mode=check --local` — exit 0 = all current
- `grep -c 'UNRESOLVED' agents/precompiled/*.pre.md` — must all be 0
- `grep -rn '^```' agents/source/*.src.md agents/compiled/*.agent.md agents/skills/*/SKILL.md | grep -v templates/` — fence check (expect 0 for non-template files)

### 2. Compilation Freshness
- For each agent: precompiled must not be newer than compiled
- `stat -c '%Y %n' agents/precompiled/*.pre.md agents/compiled/*.agent.md`
- install.sh --mode=check reports staleness automatically

### 3. Reference Integrity
- `grep -roh '`[a-zA-Z/._-]*\.md`' agents/source/ agents/kernel/ agents/compiled/ agents/skills/ | sort -u` → verify each path exists
- Check for stale references to `.github/skills/` (should be `agents/skills/` in source context)

### 4. Skill Integrity
- All SKILL.md files must start with `---` (YAML frontmatter) or `# ` (heading), never ` ``` `
- `head -1 agents/skills/*/SKILL.md` — verify no fence guards
- Count: `ls -d agents/skills/*/SKILL.md | wc -l` — should match expected count

### 5. Install Verification (self-install)
- `bin/install.sh . --local` succeeds with 0 errors
- `.github/agents/*.agent.md` files exist (5 agents)
- `.github/agents/kernel/` directory has all kernel files
- `.github/skills/*/SKILL.md` files exist (installed from agents/skills/)
- `.github/agents/.tvv-pe` version marker exists

### 6. Version Identification
- `cat .github/agents/.tvv-pe` — check version and install timestamp
- `cat VERSION` — source version
