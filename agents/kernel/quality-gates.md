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

| Check               | Verification            |
| ------------------- | ----------------------- |
| Scope defined       | IN/OUT documented       |
| Patterns identified | Pattern list exists     |
| Dependencies mapped | Dependency graph exists |
| Risks documented    | Risk list with severity |

**Pass Condition:** All checks documented with evidence.

### Design Gate

| Check                   | Verification                |
| ----------------------- | --------------------------- |
| Covers all requirements | Traceability matrix         |
| Addresses all patterns  | Design maps to patterns     |
| Feasibility confirmed   | No blocking constraints     |
| Approach approved       | User sign-off (if required) |

**Pass Condition:** Design document complete + covers scope.

### Implementation Gate

| Check            | Verification           |
| ---------------- | ---------------------- |
| Matches design   | Code implements spec   |
| Tests pass       | Test execution log     |
| No regressions   | Prior tests still pass |
| Style consistent | Linter/formatter clean |

**Pass Condition:** All tests pass + style clean.

### Review Gate

| Check                    | Verification          |
| ------------------------ | --------------------- |
| Blocking issues resolved | Zero blockers         |
| Warnings addressed       | Acknowledged or fixed |
| Documentation updated    | Reflects changes      |
| Handoff complete         | `_handoff.md` exists  |

**Pass Condition:** No blockers + handoff exists.

---

## Gate Verification Template

```markdown
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

### REQUIRED

- Explicit verification for each check
- Evidence documented
- PASS/FAIL determination before proceed
- FAIL → fix → re-verify

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

| Evidence           | Use Case          | Example                   |
| ------------------ | ----------------- | ------------------------- |
| File exists        | Artifact created  | `design.md` exists        |
| Content matches    | Structure correct | Required sections present |
| Command output     | Tests/tools       | `npm test` exit 0         |
| Explicit statement | User approval     | "Design approved" in chat |

---

## Phase-Gate Matrix

| Phase          | Gate              | Evidence               | Next           |
| -------------- | ----------------- | ---------------------- | -------------- |
| Analysis       | Analysis complete | `analysis.md`          | Design         |
| Design         | Design approved   | `design.md` + approval | Implementation |
| Implementation | Tests pass        | Test log               | Review         |
| Review         | No blockers       | `review.md`            | Complete       |

---

## Integration with Handoff

Every handoff includes gate status:

```markdown
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
