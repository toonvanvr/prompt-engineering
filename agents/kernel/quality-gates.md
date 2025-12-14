# Quality Gates

Phase transition requirements. No-skip enforcement.

---

## Core Principle

> Phase N complete ≠ start Phase N+1. Gate must pass.

```
Phase N → [GATE] → Phase N+1
             ↓ fail
          Fix → Retry
```

---

## Standard Gates

### Analysis Gate

|Check|Verification|
|-|-|
|Scope defined|IN/OUT documented|
|Patterns identified|Pattern list exists|
|Dependencies mapped|Dependency graph exists|
|Risks documented|Risk list with severity|

**Pass Condition:** All checks documented with evidence.

### Design Gate

|Check|Verification|
|-|-|
|Covers all requirements|Traceability matrix|
|Addresses all patterns|Design maps to patterns|
|Feasibility confirmed|No blocking constraints|
|Approach approved|User sign-off (if required)|

**Pass Condition:** Design document complete + covers scope.

### Implementation Gate

|Check|Verification|
|-|-|
|Matches design|Code implements spec|
|Tests pass|Test execution log|
|No regressions|Prior tests still pass|
|Style consistent|Linter/formatter clean|

**Pass Condition:** All tests pass + style clean.

### Review Gate

|Check|Verification|
|-|-|
|Blocking issues resolved|Zero blockers|
|Warnings addressed|Acknowledged or fixed|
|Documentation updated|Reflects changes|
|Handoff complete|`_handoff.md` exists|

**Pass Condition:** No blockers + handoff exists.

---

## Gate Verification Template

```md
## Gate: {gate_name}

### Checks
- [ ] {check_1}: {evidence}
- [ ] {check_2}: {evidence}
- [ ] {check_3}: {evidence}

### Result
- Status: {PASS | FAIL}
- Blockers: {list if FAIL}
- Next: {next phase or fix action}
```

---

## No-Skip Enforcement

### FORBIDDEN

- "Gate is probably passing"
- Partial verification
- Assumed success
- Skipping due to time pressure
- Soft pass (with caveats)
- Asking human "should I proceed?" (use `.human/instructions/` instead)
- Halting for confirmation on clear requests

### REQUIRED

- Explicit verification for each check
- Evidence documented
- PASS/FAIL determination before proceed
- FAIL → fix → re-verify

---

## Self-Approval Fast Path

Enterprise flows proceed autonomously unless escalation triggers.

### Conditions for Self-Approval

|Gate|Self-Approve IF|Require Human IF|
|-|-|-|
|Analysis→Design|Analysis complete|Never|
|Design→Implementation|Design spec exists + ≤2 domains|>2 domains AND public API change|
|Implementation→Review|Tests pass|Tests fail after 3 attempts|

### Self-Approval Protocol

```
1. Gate checks pass? → Self-approve, log decision, proceed
2. Gate checks fail? → Fix, retry (3 attempts max)
3. 3 failures? → Escalation protocol
```

### Rationale

User prompt = implicit approval for the entire flow. Human checkpoints via `.human/instructions/` folder, not blocking confirmation dialogs.

---

## Gate Failure Protocol

```
FAIL detected
    ↓
1. Document failure reason
2. Identify fix action
3. Execute fix
4. Re-run gate
5. If still FAIL after 3 attempts → escalate
```

### Escalation Trigger

- 3 consecutive gate failures
- Blocker outside agent scope
- Missing information for verification

---

## Gate Evidence Types

|Evidence|Use Case|Example|
|-|-|-|
|File exists|Artifact created|`design.md` exists|
|Content matches|Structure correct|Required sections present|
|Command output|Tests/tools|`npm test` exit 0|
|Explicit statement|User approval|"Design approved" in chat|

---

## Phase-Gate Matrix

|Phase|Gate|Evidence|Next|
|-|-|-|-|
|Analysis|Analysis complete|`analysis.md`|Design|
|Design|Design approved|`design.md` + approval|Implementation|
|Implementation|Tests pass|Test log|Review|
|Review|No blockers|`review.md`|Complete|

---

## Integration with Handoff

Every handoff includes gate status:

```md
## Verification

### Gate: {gate_name}
- Status: {PASS}
- Evidence: {file/command}
- Timestamp: {when}
```

---

## Summary

```
Every phase → Gate verification → Next phase
Gate = explicit checks + evidence
FAIL = fix + re-verify
Skip = violation → self-analysis log
```

---

## High-Stakes Gates

### Definition

Gates that require explicit human approval before proceeding.

### Default High-Stakes Gates

|Gate|Trigger|Rationale|
|-|-|-|
|Design → Implementation|Always|Implementation is irreversible work|
|Multi-domain changes|>2 domains|Cross-cutting impact|
|Public interface changes|API/schema|Breaking change risk|

### High-Stakes Gate Template

```md
## High-Stakes Gate: {gate_name}

### Verification Status
|Check|Status|Evidence|
|-|-|-|
|{check}|{PASS/FAIL}|{reference}|

### Approval Required

⚠️ This gate requires explicit approval.

### Summary for Approver
{2-3 sentence summary of what was completed}

### Artifacts for Review
- {artifact}: {path}

### Risk Assessment
|Factor|Level|Note|
|-|-|-|
|File count|{n}|{within/exceeds threshold}|
|Domain count|{n}|{domains involved}|
|Reversibility|{HIGH/LOW}|{explanation}|

### Decision
- [ ] APPROVE: Proceed to {next_phase}
- [ ] DENY: {reason}

⚠️ Requires gate pass OR escalation. Self-approval enabled for standard flows.
```

### Approval Sources (Priority Order)

1. **User message in chat**: "Approved" / "Proceed" / "LGTM"
2. **File**: `.human/instructions/approve.md` present
3. **Pre-approval in dispatch**: Scope explicitly approved upstream

### Override: Low-Risk Fast Path

For changes meeting ALL criteria:
- ≤2 files modified
- Single domain
- Non-breaking (internal only)
- Test coverage exists (tests cover modified functionality, or documentation-only change)

May use **self-approval with documentation**:

```md
## Self-Approval: {gate_name}

### Low-Risk Criteria Met
- [ ] ≤2 files: {YES}
- [ ] Single domain: {YES}
- [ ] Non-breaking: {YES}
- [ ] Tests cover changes: {YES}

### Proceeding with self-approval.
```
