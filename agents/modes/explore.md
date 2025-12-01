# Mode: EXPLORE

Discovery and analysis mode. Creativity enabled within guardrails.

---

## Activation

```markdown
## Mode: EXPLORE

Creativity: enabled within guardrails
Constraints: hard boundaries only
Output: options + recommendations
```

---

## Purpose

Use EXPLORE when:

- Understanding new codebase
- Analyzing patterns
- Designing solutions
- Evaluating options
- Investigating issues
- Uncertainty is high

---

## Characteristics

| Aspect           | EXPLORE Behavior      |
| ---------------- | --------------------- |
| Creativity       | ✅ Enabled            |
| Multiple options | ✅ Expected           |
| Questions        | ✅ Encouraged         |
| Deviation        | ⚠️ Within guardrails  |
| Output format    | 📝 Flexible structure |
| Uncertainty      | ✅ Acceptable         |

---

## Guardrails (Always Apply)

Even in EXPLORE mode:

### ALWAYS

1. Follow Three Laws
2. Stay within scope boundaries
3. Document findings
4. Create handoff on terminate
5. Log violations to self-analysis

### NEVER

1. Modify code without explicit task
2. Skip documentation
3. Exceed context budget
4. Ignore quality gates
5. Bypass sub-agent thresholds

---

## What's Relaxed

| Constraint               | Status in EXPLORE        |
| ------------------------ | ------------------------ |
| Exact output format      | Flexible                 |
| Single-path execution    | Multiple paths OK        |
| Step-by-step sequence    | Can explore non-linearly |
| Predetermined conclusion | Options > answers        |

---

## Output Patterns

### Analysis Output

```markdown
## Findings

### Pattern 1: {name}

- Location: {where found}
- Frequency: {how common}
- Impact: {significance}

### Pattern 2: {name}

...

## Recommendations

- Option A: {description} — Tradeoffs: {list}
- Option B: {description} — Tradeoffs: {list}

## Questions

- {clarification needed}
```

### Design Output

```markdown
## Options

### Option 1: {approach}

- Pros: {list}
- Cons: {list}
- Effort: {estimate}
- Risk: {level}

### Option 2: {approach}

...

## Recommendation

{preferred option with rationale}

## Open Questions

{what needs resolution}
```

---

## Mode Transition

### EXPLORE → EXPLOIT Trigger

When:

- Design approved
- Option selected
- Plan confirmed
- Implementation requested

```markdown
Analysis complete + Design approved → MODE: EXPLOIT
```

### Signal in Output

```markdown
## Recommendation

{recommendation}

⚠️ On approval: Switch to EXPLOIT mode for implementation.
```

---

## Example Dispatch

```markdown
# Task: Analyze authentication patterns

## Mode: EXPLORE

Creativity: enabled
Goal: Understand current auth implementation

## Scope

IN: Authentication-related files
OUT: Unrelated modules

## Deliverables

- Pattern analysis document
- Recommendations for improvement
- Open questions for design phase

## Guardrails

- Don't modify any code
- Document all findings
- Stay within auth scope
```

---

## Summary

```
EXPLORE = Find the right thing

✅ Creativity on
✅ Multiple options
✅ Questions OK
⚠️ Guardrails still apply
📝 Flexible output

Transition: Approval → EXPLOIT
```
