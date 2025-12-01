# Mode Protocol: EXPLORE ↔ EXPLOIT

Two operational modes. Different constraint levels.

---

## Mode Definitions

| Aspect      | EXPLORE                   | EXPLOIT              |
| ----------- | ------------------------- | -------------------- |
| Creativity  | Enabled                   | Disabled             |
| Constraints | Guardrails only           | Full stack           |
| Deviation   | Within bounds             | Zero tolerance       |
| Output      | Options + recommendations | Exact implementation |
| Uncertainty | Expected                  | Unacceptable         |

---

## EXPLORE Mode

Use when: Discovery, analysis, design, options needed.

### Characteristics

```markdown
Mode: EXPLORE

Creativity: enabled within guardrails
Constraints: hard boundaries only
Output: multiple options with tradeoffs
Questions: encouraged before commitment
```

### Guardrails (Still Apply)

- Three Laws: ALWAYS enforced
- Scope boundaries: ALWAYS enforced
- Documentation: ALWAYS required
- Quality gates: STILL apply

### What's Relaxed

- Exact output format (flexible structure)
- Single-path execution (can explore branches)
- Step-by-step sequence (can jump around)

### Example Tasks

- Codebase analysis
- Architecture design
- Option evaluation
- Root cause investigation

---

## EXPLOIT Mode

Use when: Implementation, execution, following spec.

### Characteristics

```markdown
Mode: EXPLOIT

Creativity: disabled
Deviation: none without approval
Verification: mandatory after each change
Output: exact match to specification
```

### Full Constraint Stack

- Layer 1: Identity (anchored)
- Layer 2: Three Laws (enforced)
- Layer 3: ALWAYS/NEVER (strict)
- Layer 4: Phases/Gates (sequential)
- Layer 5: Output Format (exact)

### What's Enforced

- Exact output format
- Sequential phase execution
- Verification after each step
- Zero scope expansion

### Example Tasks

- Code implementation
- File creation from spec
- Bug fixes with defined solution
- Refactoring per plan

---

## Mode Transitions

### EXPLORE → EXPLOIT

**Trigger:** Design/plan approved

```
Analysis complete → Design approved → MODE: EXPLOIT
        ↓                  ↓                ↓
    EXPLORE            EXPLORE          EXPLOIT
```

### EXPLOIT → EXPLORE

**Trigger:** Unexpected complexity, blocked, uncertainty

```
Implementation → Blocker found → Uncertainty high → MODE: EXPLORE
       ↓              ↓                ↓
   EXPLOIT        (pause)          EXPLORE
```

After EXPLORE resolves → return to EXPLOIT.

---

## Inheritance Rules

### Parent → Child Mode Transfer

| Parent Mode | Child Default                        |
| ----------- | ------------------------------------ |
| EXPLORE     | EXPLORE (unless implementation task) |
| EXPLOIT     | EXPLOIT                              |

### Override Allowed?

| Direction         | Allowed | Condition              |
| ----------------- | ------- | ---------------------- |
| EXPLORE → EXPLOIT | ✅      | Implementation subtask |
| EXPLOIT → EXPLORE | ⚠️      | Only on escalation     |

---

## Mode Declaration

Every dispatch includes:

```markdown
## Mode: {EXPLORE | EXPLOIT}

{mode-specific constraints}

⚠️ MODE SWITCH: {trigger condition} → {new mode}
```

---

## Summary

```
EXPLORE = Find the right thing
EXPLOIT = Do the thing right

EXPLORE: guardrails, options, flexibility
EXPLOIT: full stack, single path, exactness
```
