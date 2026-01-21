# Three Laws of Orchestration

Immutable. Non-negotiable. Inherited by all agents.

---

## Law 1: Sub-Agents for Complexity

> Spawn sub-agent when task exceeds single-agent capacity.

### Thresholds

|Trigger|Action|
|-|-|
|>5 files to modify|Sub-agent per domain|
|>2 domains crossed|Domain-specific sub-agents|
|>15 files to analyze|Partition + parallelize|
|Uncertainty high|EXPLORE sub-agent first|

### Enforcement

- Orchestrator: MUST spawn, ❌ bypass
- Sub-agents: May request further spawn
- Violation: Task failure + self-analysis log

---

## Law 2: Document Before Terminate

> No agent terminates without persisting state.

### MANDATORY Termination Requirements

1. **MUST create termination artifact** — `_handoff.md` OR `_error.md` before ANY termination
2. **MUST persist discoveries** — Reusable knowledge → `.ai/library/` before termination
3. **No exceptions** — Violation = task failure

### Required Artifacts

|Context|Artifact|
|-|-|
|Task complete|`_handoff.md`|
|Error exit|`_error.md` + partial state|
|Timeout|`_timeout.md` + checkpoint|

### Handoff Contents

1. Work completed (with file list)
2. Work remaining (if any)
3. Blockers encountered
4. Verification status
5. **Feedback captured** (mandatory section, even if "none")

### Knowledge Persistence

Before termination, check for reusable discoveries:
- New patterns → `.ai/library/patterns/`
- Tool quirks → `.ai/library/quirks/`
- Domain knowledge → `.ai/library/domain/`

### Enforcement

- Termination blocked until artifact exists
- Parent agent validates before accepting
- Missing feedback section = handoff rejected

---

## Law 3: Quality Gates Are Immutable

> No phase proceeds without gate verification.

### Gate Structure

```
Phase N → [GATE: condition] → Phase N+1
              ↓ (fail)
         Fix → Re-verify
```

### Gate Types

|Gate|Verification|
|-|-|
|Analysis complete|Patterns documented|
|Design approved|Covers all requirements|
|Implementation done|Tests pass|
|Review passed|No blocking issues|

### No-Skip Clause

- Gates cannot be bypassed
- "Soft pass" = fail
- Partial verification = fail
- Gate skip → immediate escalation

---

## Summary

```
1. COMPLEXITY → Sub-agent
2. TERMINATE → Document
3. GATE → Must pass
```

Violations logged to `.ai/self-analysis/` with category: `LAW_VIOLATION`.
