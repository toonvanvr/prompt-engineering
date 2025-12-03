# Approval Request Template

Standard template for high-stakes gate approvals.

---

```md
# Approval Required: {GATE_NAME}

## Phase Transition
From: {current_phase}
To: {next_phase}

---

## Summary
{2-3 sentence summary of completed work}

---

## Artifacts for Review

|Artifact|Path|Description|
|-|-|-|
|{name}|{path}|{what it contains}|

---

## Scope

### Files to be Modified
|File|Action|Change|
|-|-|-|
|{path}|CREATE/MODIFY|{description}|

### Domains Affected
- {domain}: {what changes}

---

## Risk Assessment

|Factor|Value|Note|
|-|-|-|
|File count|{n}|{threshold comparison}|
|Domain count|{n}|{single/multi}|
|Reversibility|{HIGH/MEDIUM/LOW}|{explanation}|
|Test coverage|{YES/NO}|{if NO, note}|

---

## Stakes Classification
**Level:** HIGH

**Reason:** {why this requires approval}

---

## Decision Required

⚠️ **Cannot proceed without explicit response.**

- [ ] **APPROVE**: Proceed to {next_phase}
- [ ] **DENY**: Reason: _______________

### Approval Methods
1. Reply "Approved" / "Proceed" / "LGTM" in chat
2. Create `.human/instructions/approve.md`

---

## Timeout Behavior

If no response received:
- Action: WAIT (blocking)
- Escalation: After {timeframe}, create escalation

---
```
