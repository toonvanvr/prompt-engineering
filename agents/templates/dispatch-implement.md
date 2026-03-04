````markdown
# Implementation Dispatch Template

Sub-agent dispatch for code implementation.

---

## ⚠️ MANDATORY: EXPLOIT MODE

Implementation sub-agents operate in **EXPLOIT mode only**.

```
┌─────────────────────────────────────────────────────────────────┐
│ IMPLEMENTATION = EXPLOIT MODE                                   │
│                                                                 │
│ Creativity: DISABLED                                            │
│ Deviation: ZERO without approval                                │
│ Verification: MANDATORY per change                              │
│                                                                 │
│ FOLLOW THE DESIGN. NO FREELANCING.                              │
└─────────────────────────────────────────────────────────────────┘
```

---

## The 1-1-1 Rule

```
┌─────────────────────────────────────────────────────────────────┐
│ 1 FILE    — Maximum 2 files changed per task                    │
│ 1 VERIFY  — Specific verification step per task                 │
│ 1 OUTCOME — Clear, checkable completion criterion               │
│                                                                 │
│ If task needs more → DECOMPOSE FURTHER                          │
└─────────────────────────────────────────────────────────────────┘
```

---

## Task Decomposition (MANDATORY)

Before executing, explicitly decompose the task:

```md
## Decomposition
|Step|File(s)|Change|Verify|Depends On|
|-|-|-|-|-|
|1|{path}|{what}|{how}|—|
|2|{path}|{what}|{how}|Step 1|
```

**Rules:**
- List ALL steps before starting ANY
- Identify dependencies between steps
- Execute in dependency order
- Verify each step before proceeding
- Document completion status

---

````markdown
# Sub-Agent Dispatch: Implementation — {COMPONENT}

# MANDATORY: Sub-Agent Prime Directives

You are a SUB-AGENT. DOCUMENT → SCOPE → PERSIST → INHERIT.

---

## Task

Implement {component} per approved design.

## Mode: EXPLOIT (mandatory)

Creativity: disabled
Deviation: zero without approval
Verification: mandatory per change

FULL CONSTRAINT STACK:

- Three Laws: enforced
- ALWAYS/NEVER: strict
- Gates: sequential
- Format: exact

⚠️ MODE SWITCH → EXPLORE: Only on blocker (requires escalation)

---

## Input Context

|Source|Path|
|-|-|
|Design|`.ai/scratch/YYYY-MM-DD_{topic}/design.md`|
|Analysis|`.ai/scratch/YYYY-MM-DD_{topic}/analysis_*.md`|
|Review|`.ai/scratch/YYYY-MM-DD_{topic}/review_*.md`|
|Domain|`.ai/library/domain/`|

---

## Domain Verification Gate (MANDATORY)

Before implementation, verify against `.ai/library/domain/`:

- [ ] Check domain constraints still apply
- [ ] Verify no conflicting patterns exist
- [ ] Confirm terminology matches domain glossary
- [ ] Validate assumptions against domain rules

**Gate FAIL → escalate.** Do not proceed with outdated domain assumptions.

---

## Implementation Scope

### Files to Create

|File|Purpose|Verification|
|-|-|-|
|{path}|{what}|{how to verify}|

### Files to Modify

|File|Changes|Verification|
|-|-|-|
|{path}|{what}|{how to verify}|

---

## Implementation Guidelines

|Guideline|Requirement|
|-|-|
|Style|Match existing patterns|
|Changes|Atomic, reversible|
|Docs|Comments for non-obvious code|
|Errors|Handle per design, meaningful messages|

---

## Async Scan Points

|Trigger|When|Action|
|-|-|-|
|Task-start|Before reading design|Check `{workfolder}/communication/ai_status.md` Human Input section|
|Pre-impl|Before modifying files|Check `{workfolder}/communication/ai_status.md` Human Input section|
|Pre-handoff|Before creating handoff|Check `{workfolder}/communication/ai_status.md` Human Input section|

Process instructions if found. Archive to `00_prompts/`.
Continue immediately (halt only on `ACTION: abort`).

### Human Input Section Format
```md
## Human Input
<!-- Human can write feedback/redirects here; agent checks at checkpoints -->
<!-- Format: [YYYY-MM-DD HH:MM] ACTION: {details} -->
<!-- Actions: pause, resume, redirect, feedback, abort -->
```

---

## Constraints

|Limit|Value|Action if Exceeded|
|-|-|-|
|Lines/file|250|Split task|
|Files modified|8|Spawn sub-agent|
|Design deviation|0|Document + escalate|

---

## Scope-Break Detection (MANDATORY)

If during implementation you discover:
- New bugs unrelated to current task
- Refactoring opportunities outside scope
- Missing features not in design
- Technical debt requiring attention

**DO NOT debug inline.** Instead:
1. Document issue in `findings.md` with full context
2. Add to handoff "Spawned Issues" section
3. Continue with original task
4. Recommend separate session for discovered issues

Scope creep is the #1 cause of incomplete implementations.

---

## File Operation Constraints

⛔ **FORBIDDEN** (causes task failure):
- `cat > file`, `cat >> file`
- `echo > file`, `echo >> file`
- Shell redirects (`>`, `>>`, `2>`)
- `sed -i`, `awk -i inplace`

✅ **REQUIRED**: Use VS Code tools (`create_file`, `replace_string_in_file`, `multi_replace_string_in_file`)

---

## FORBIDDEN Actions

- ❌ Adding features not in design
- ❌ Refactoring unrelated code
- ❌ Changing public interfaces without approval
- ❌ Skipping error handling
- ❌ Skipping verification

---

## Output Requirements

### Changes Applied

Use edit tools to apply changes to files.

### Change Log: `.ai/scratch/YYYY-MM-DD_{topic}/implementation_{component}.md`

```md
# Implementation: {Component}

## Summary
{what was implemented}

## Files Created
|File|Purpose|Lines|
|-|-|-|
|{path}|{why}|{n}|

## Files Modified
|File|Change|Lines|Reason|
|-|-|-|-|
|{path}|{what}|{range}|{why}|

## Design Deviations
|Deviation|Original|Actual|Reason|
|-|-|-|-|
|{what}|{planned}|{done}|{why}|

## Verification Log
|Step|Command/Check|Result|
|-|-|-|
|1|{what}|{PASS/FAIL}|

## Test Considerations
- {what to test}

## Known Limitations
- {limitation}: {explanation}
```
````

### Handoff: `.ai/scratch/YYYY-MM-DD_{topic}/_handoff.md`

```md
# Implementation Handoff: {Component}

## Summary
{what was implemented}

## Changes Made
|File|Type|Status|Verified|
|-|-|-|-|
|{path}|NEW/MOD|DONE|✓|

## Verification Needed
- [ ] {check}

## Ready for Review
{focus areas for reviewer}

## Gate: Implementation Complete
- [ ] Matches design
- [ ] Tests pass
- [ ] No regressions
- [ ] Style consistent
- Status: {PASS|FAIL}
```

---

## Success Criteria

- [ ] Human instructions checked at start
- [ ] All design components implemented
- [ ] Code compiles/parses
- [ ] Project conventions followed
- [ ] Changes documented
- [ ] Each change verified
- [ ] Human instructions checked before handoff
- [ ] Handoff complete
- [ ] Gate passed

```

```
````
