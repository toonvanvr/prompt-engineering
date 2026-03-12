# Approval Request Template

Standard template for high-stakes gate approvals.

> **SCOPE:** Use ONLY for escalation scenarios (3+ failed attempts per escalation protocol).
> Standard enterprise flows self-approve. This template is NOT for asking "should I proceed?"

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

⚠️ **Escalation scenario — requires explicit response.**

- [ ] **APPROVE**: Proceed to {next_phase}
- [ ] **DENY**: Reason: _______________

### Context
This request was triggered by escalation protocol (3+ failed attempts). Standard flows self-approve.

---

## Timeout Behavior

If no response received:
- Action: WAIT (blocking)
- Escalation: After {timeframe}, create escalation

---
```
