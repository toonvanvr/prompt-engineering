# Thoroughness Protocol

Read-completeness guarantees for critical operations.

---

## Core Principle

> MUST read entire file before modifying. MUST read entire document before analyzing AS PRIMARY TARGET.

**Scope:** Applies to files the agent is WORKING ON (modifying, analyzing as primary target). Does NOT apply to files read for routing, reporting to other agents, or verification. See `model-behavior.md`.

**Budget:** No artificial speed pressure on critical files. Thoroughness > speed, within context budget (`context-budget.md` 80% ceiling).

---

## Size-Aware Strategy

|Size|Strategy|Verification|
|-|-|-|
|<100 lines|Single read|Implicit|
|100-300 lines|Single read|State total lines|
|300-500 lines|Chunked reads|List section inventory|
|>500 lines|Multi-pass|Full inventory + verification|

---

## Mandatory Assertions

### Before Modifying Any File

- MUST: Read to file end before editing
- MUST: Acknowledge if partial read (state what's missing)
- NEVER: Assume first N lines = complete file
- NEVER: Edit based on truncated context

### For Design Documents

- MUST: Read entire design before implementation
- MUST: Cross-reference all sections mentioned
- MUST: Verify no sections skipped

---

## Verification Protocol

### For Files 100-300 Lines

```md
Read complete: {filename} ({N} lines total)
```

### For Files 300-500 Lines

```md
Section inventory for {filename}:
- Lines 1-50: {section name}
- Lines 51-120: {section name}
- ...
- Lines {N-50}-{N}: {section name}
All sections read: YES
```

### For Files >500 Lines

```md
## File Inventory: {filename}

Total lines: {N}
Read passes: {count}

### Structure
|Section|Lines|Status|
|-|-|-|
|{name}|1-100|✓|
|{name}|101-250|✓|
|...|...|...|

Verification: All sections read
```

---

## Time Budget Declaration

For critical files (modify targets, primary analysis targets, design docs):

- Multiple read passes: ALLOWED (within context budget)
- Re-read for own verification: ALLOWED
- Extended analysis time: ALLOWED
- Timeout pressure: IGNORED
- Context budget ceiling: ALWAYS APPLIES (`context-budget.md`)

**Rationale:** Incomplete reads cause errors. But unbounded reading causes context overflow — balance thoroughness with budget.

---

## Ellipsis Expansion

When generating ANY list ending with `..`, `...`, or similar:
1. STOP — do not emit the ellipsis
2. Spend reasoning time: what concrete items remain unstated?
3. Either enumerate them explicitly or state "N additional items omitted: {category}"
4. Ellipsis in OUTPUT = specification defect

Applies to: agent output, design specs, dispatch scopes, handoffs. Does NOT apply to quoting user input that contains ellipsis.

---

## Integration

Add to agent ALWAYS lists:

```md
- **Full-read critical files** — modify targets, design docs (thoroughness.md)
```

### Critical File Types

|File Type|Thoroughness Level|Applies To|
|-|-|-|
|Files being modified|MANDATORY|Implementer|
|Files being analyzed (primary targets)|MANDATORY|Researcher|
|Research findings being consumed|MANDATORY|Designer|
|Design documents|MANDATORY|Implementer, Designer|
|Kernel files (when reviewing/modifying)|MANDATORY|All|
|Files for routing decisions|SKIM ONLY|Orchestrator|
|SA output for verification|HANDOFF ONLY|Orchestrator|
|Reference files|RECOMMENDED|All|
|Examples|OPTIONAL|All|

### Read-Before-Write Guard
Before creating/modifying any output file: read existing content at that path (or confirm it doesn't exist). Writing without reading = overwrite risk. Applies to all agents, all stakes levels.
