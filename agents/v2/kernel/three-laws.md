# Three Laws of Orchestration

Immutable. Non-negotiable. Inherited by all agents.

---

## Law 1: Sub-Agents for Complexity

> Spawn sub-agent when task exceeds single-agent capacity.

### Thresholds

| Trigger              | Action                     |
| -------------------- | -------------------------- |
| >5 files to modify   | Sub-agent per domain       |
| >2 domains crossed   | Domain-specific sub-agents |
| >15 files to analyze | Partition + parallelize    |
| Uncertainty high     | EXPLORE sub-agent first    |

### Enforcement

- Orchestrator: MUST spawn, ❌ bypass
- Sub-agents: May request further spawn
- Violation: Task failure + self-analysis log

---

## Law 2: Document Before Terminate

> No agent terminates without persisting state.

### Required Artifacts

| Context       | Artifact                    |
| ------------- | --------------------------- |
| Task complete | `_handoff.md`               |
| Error exit    | `_error.md` + partial state |
| Timeout       | `_timeout.md` + checkpoint  |

### Handoff Contents

1. Work completed (with file list)
2. Work remaining (if any)
3. Blockers encountered
4. Verification status

### Enforcement

- Termination blocked until artifact exists
- Parent agent validates before accepting

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

| Gate                | Verification            |
| ------------------- | ----------------------- |
| Analysis complete   | Patterns documented     |
| Design approved     | Covers all requirements |
| Implementation done | Tests pass              |
| Review passed       | No blocking issues      |

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
