# Core Prompt Patterns

Universal patterns extracted from research. Use in all agents.

---

## Identity Matrix

4-dimensional persona anchor. Prevents drift.

```markdown
Role: {primary function}
Mindset: {decision driver}
Style: {communication mode}
Superpower: {key capability}
```

**Example:**
```markdown
Role: Implementation Specialist
Mindset: Code wrong until verified
Style: Atomic, precise
Superpower: Targeted fixes
```

---

## Three Laws

Exactly 3 immutable behavioral anchors. Evokes authority.

**Structure:**
```markdown
## Three Laws

1. **{Law}** — {1-line explanation}
2. **{Law}** — {1-line explanation}
3. **{Law}** — {1-line explanation}
```

**Why 3:** Cognitive limit. Easy recall. Forces prioritization.

---

## ALWAYS/NEVER Lists

Binary constraints. Eliminate ambiguity.

```markdown
### ALWAYS
1. {mandatory action}
2. {mandatory action}

### NEVER
1. {forbidden action}
2. {forbidden action}
```

**Guidelines:**
- 5-7 items max per list
- Order by importance
- Use emphatic formatting
- Include consequences for violations

---

## Sub-Agent Delegation Template

5-part structure for clean handoffs.

```markdown
## Sub-Agent: {Name}

### Objective
{1-line goal}

### Context
{structured input}

### Task
1. {step}
2. {step}

### Return Format
{exact output structure}

### Constraints
- {what NOT to do}
```

**CRITICAL:** Always include all 5 sections.

---

## 3-Attempt Escalation

Prevents loops + ensures effort.

| Attempt | Action |
|---------|--------|
| 1 | Targeted fix |
| 2 | Different approach |
| 3 | Deep diagnosis |
| 4+ | ESCALATE |

**Escalation Template:**
```markdown
## ESCALATION

Task: {name}
Error: {message}

### Attempts
1. {action} → {result}
2. {action} → {result}
3. {action} → {result}

### Hypothesis
{root cause}

### Need
{specific help}
```

---

## Compression Rules

### Safe (Always Apply)
| Pattern | Action |
|---------|--------|
| Filler phrases | DELETE |
| Articles (the, a, an) | DELETE |
| "In order to" | → "To" |
| Connectors | → symbols (→ & = !) |
| Prose | → markdown structure |

### Never Compress
| Element | Reason |
|---------|--------|
| Examples | Anchor interpretation |
| MUST/NEVER/ALWAYS | Behavioral weight |
| Code blocks | Syntax-sensitive |
| Numbers/thresholds | Exact values |

---

## State Persistence

```yaml
# STATE.md
project: {name}
current_task: {task}
progress: {X/Y}
verification: pending|pass|fail
decisions:
  - {decision}: {rationale}
```

Update after EVERY task, not just phases.

---

## Verification Protocol

```
STOP → READ → DIAGNOSE → FIX → VERIFY
```

| Check | When |
|-------|------|
| Quick (lint) | Every file |
| Full (test) | Every task |
| Comprehensive | Every phase |

**Rule:** Never mark complete without verification pass.

---

## Red Flags 🚩

Trigger immediate verification:
- "I think this should work"
- "I've done this before"
- `as any` in TypeScript
- Empty catch blocks
- `// @ts-ignore`

---

## 1-1-1 Rule

```
1 FILE per edit
1 VERIFICATION per edit
1 OUTCOME per edit
```

If task requires >2 files → decompose.

---

*Extracted: 2025-12-01*
