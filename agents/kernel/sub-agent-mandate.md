# Sub-Agent Mandate

Mandatory spawning rules. Non-bypassable.

---

## Core Principle

> Task exceeds capacity → Spawn sub-agent. No exceptions.

---

## Spawning Thresholds

|Condition|Action|Rationale|
|-|-|-|
|>5 files to modify|Sub-agent per file group|Context overflow prevention|
|>15 files to analyze|Partition + parallel sub-agents|Analysis quality|
|>2 domains crossed|Domain-specific sub-agent|Expertise isolation|
|Uncertainty high|EXPLORE sub-agent first|Risk reduction|
|Task >2000 tokens estimated|Consider partition|Output quality|

---

## Domain Crossing Rules

### Domain Definition

|Domain|Scope|
|-|-|
|Frontend|UI, components, styling|
|Backend|API, services, data|
|Infrastructure|Config, CI/CD, deployment|
|Testing|Tests, fixtures, mocks|
|Documentation|Docs, comments, READMEs|

### Cross-Domain Detection

```
Touch frontend + backend? → 2 sub-agents
Touch tests + implementation? → 2 sub-agents
Touch infra + any code? → 2 sub-agents
```

### Example

```markdown
Task: Add user auth with tests

Domain analysis:

- Backend (auth service) → Sub-agent 1
- Frontend (login UI) → Sub-agent 2
- Tests (auth tests) → Sub-agent 3

Spawn: 3 domain-specific sub-agents
```

---

## No Bypass Clause

### FORBIDDEN

- "I'll handle it myself" (if threshold met)
- "Just this once" (no exceptions)
- "It's simpler without" (complexity is the reason)
- Spawning incomplete sub-agents

### REQUIRED

- Evaluate thresholds before starting
- Document spawn decision
- Wait for sub-agent completion
- Verify sub-agent handoff
- Check `.human/instructions/` before dispatch

---

## Sub-Agent Requirements

Every sub-agent dispatch MUST include:

```md
# MANDATORY: Sub-Agent Prime Directives

1. **DOCUMENT EVERYTHING** — Write to designated scratch space
2. **STAY IN SCOPE** — Only touch assigned files/domains
3. **PERSIST BEFORE TERMINATING** — Create \_handoff.md
4. **FOLLOW DESIGN** — Implement exactly what specs define (if EXPLOIT)
5. **CHECK HUMAN INSTRUCTIONS** — Check `.human/instructions/` at start and before handoff

## Human Override

Check `.human/instructions/` at: start, pre-handoff
Process any instructions found. Move processed files to `.human/processed/`.

## Task: {specific task}

## Scope
IN: {explicit list}
OUT: {explicit exclusions}

## Mode: {EXPLORE | EXPLOIT}

## Output Requirements
{exact artifacts expected}
```

---

## Orchestrator Responsibilities

1. **Partition** — Split task into coherent sub-tasks
2. **Dispatch** — Spawn sub-agents with complete context
3. **Coordinate** — Manage dependencies between sub-agents
4. **Integrate** — Merge sub-agent outputs
5. **Verify** — Validate all handoffs complete

---

## Handoff Chain

```
Orchestrator
    ↓ dispatch
Sub-agent executes
    ↓ handoff
Orchestrator validates
    ↓ integrate
Next sub-agent (or complete)
```

### Handoff Validation

- [ ] `_handoff.md` exists
- [ ] All artifacts listed
- [ ] Scope not exceeded
- [ ] Verification passed

---

## Violation Handling

Sub-agent threshold met but not spawned:

1. Log to `.ai/self-analysis/` with `LAW_VIOLATION`
2. Mark task as potentially incomplete
3. Escalate to user if output quality degraded

---

## Summary

```
>5 files → Sub-agent
>2 domains → Sub-agents per domain
Uncertain → EXPLORE sub-agent

NO BYPASS. EVER.
```
