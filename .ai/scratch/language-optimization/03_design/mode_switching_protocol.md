# Mode Switching Protocol Specification

## Overview

Explicit protocol for transitioning between EXPLORE (creative) and EXPLOIT (consistent) modes. Prevents mode confusion that causes implementation drift.

---

## Mode Definitions

### EXPLORE Mode

**Purpose:** Discover, analyze, design — generate options

| Attribute    | Value                              |
| ------------ | ---------------------------------- |
| Creativity   | ENABLED within guardrails          |
| Constraints  | Hard boundaries only               |
| Deviation    | Encouraged (novel solutions)       |
| Output       | Options, recommendations, analysis |
| Verification | Light (validate feasibility)       |

**Active during:**

- Interpretation
- Analysis
- Design
- Brainstorming

### EXPLOIT Mode

**Purpose:** Execute, implement, verify — follow spec exactly

| Attribute    | Value                       |
| ------------ | --------------------------- |
| Creativity   | DISABLED                    |
| Constraints  | Full consistency stack      |
| Deviation    | NONE without approval       |
| Output       | Exact implementation        |
| Verification | Mandatory after each change |

**Active during:**

- Implementation
- Code modification
- Structured output generation
- Verification tasks

---

## Mode Signals

### Entering EXPLORE

Triggers:

- Phase is Analysis, Design, or Interpretation
- Task includes: "explore", "investigate", "consider options"
- Explicit signal: "MODE: EXPLORE"

Behavior changes:

```
+ Generate multiple options (3-5 minimum)
+ Question assumptions
+ Draw from other domains
+ Propose unconventional solutions
+ Challenge constraints (within guardrails)
```

### Entering EXPLOIT

Triggers:

- Phase is Implementation or Review
- Design document is approved
- Task includes: "implement", "execute", "build"
- Explicit signal: "MODE: EXPLOIT"

Behavior changes:

```
- No feature additions not in spec
- No refactoring not in scope
- No creative interpretation of requirements
- Verify after each change
- Document any forced deviations
```

---

## Transition Protocol

### EXPLORE → EXPLOIT

```
┌─────────────────────────────────────────────────────────────────┐
│                    MODE TRANSITION: EXPLORE → EXPLOIT           │
│                                                                 │
│  Prerequisites:                                                 │
│  ✓ Design document exists                                       │
│  ✓ Design review passed                                         │
│  ✓ Success criteria defined                                     │
│  ✓ Scope boundaries clear                                       │
│                                                                 │
│  Transition signal in sub-agent dispatch:                       │
│                                                                 │
│  ════════════════════════════════════════════════════           │
│  ⚠️ MODE: EXPLOIT                                               │
│                                                                 │
│  Exploration complete. Design approved.                         │
│  You are now in IMPLEMENTATION mode.                            │
│                                                                 │
│  • Creativity: DISABLED                                         │
│  • Deviation: NONE without approval                             │
│  • Follow design EXACTLY                                        │
│  • Verify after each change                                     │
│  ════════════════════════════════════════════════════           │
│                                                                 │
│  Behavior locked until task completion.                         │
└─────────────────────────────────────────────────────────────────┘
```

### EXPLOIT → EXPLORE (Rare)

Only when:

- Spec is impossible as written
- New requirements discovered
- Explicit user request

Signal:

```markdown
⚠️ MODE SWITCH: EXPLOIT → EXPLORE

Reason: {justification}
Scope: {what needs re-exploration}

Previous progress preserved at: `.ai/scratch/{topic}/_checkpoint.md`

Mode will return to EXPLOIT after design update.
```

---

## Sub-Agent Mode Inheritance

### Mode Propagation

Parent mode propagates to sub-agents unless explicitly overridden.

```markdown
## Sub-Agent Dispatch

### Inherited Mode: {EXPLORE | EXPLOIT}

{If EXPLORE}
You may propose alternatives if you identify improvements.
Guardrails still apply.

{If EXPLOIT}
Follow spec exactly. No creative additions.
Document impossibilities, do not solve creatively.
```

### Mode Override

Sub-agent may request mode change:

```markdown
## Mode Change Request

Current: EXPLOIT
Requested: EXPLORE
Reason: Spec requirement X cannot be implemented as written

Options:

1. Alternative A: {description}
2. Alternative B: {description}

Awaiting approval before proceeding.
```

---

## Guardrails (Active in Both Modes)

### Hard Boundaries (Never Cross)

```markdown
Regardless of mode, NEVER:

- Violate security constraints
- Delete production data
- Change public APIs without approval
- Skip documentation requirements
- Proceed without handoff on termination
```

### EXPLORE-Specific Guardrails

```markdown
In EXPLORE mode, creativity bounded by:

- Technical feasibility
- Resource constraints (time, budget)
- Regulatory requirements
- Backward compatibility needs
```

---

## Mode Indicators in Output

### During EXPLORE

Outputs should include:

```markdown
## Mode: EXPLORE

### Options Considered

1. {Option A}: {pros/cons}
2. {Option B}: {pros/cons}
3. {Option C}: {pros/cons}

### Recommendation

{Selected approach with rationale}

### Trade-offs Accepted

- {trade-off}: {why acceptable}
```

### During EXPLOIT

Outputs should include:

```markdown
## Mode: EXPLOIT

### Spec Reference

Following: `.ai/scratch/{topic}/design.md`

### Implementation Status

- [x] Component A (verified)
- [ ] Component B (in progress)

### Deviations

None | {deviation with approval reference}
```

---

## Decision Matrix

| Situation                    | Mode    | Rationale                         |
| ---------------------------- | ------- | --------------------------------- |
| Understanding vague request  | EXPLORE | Need to discover intent           |
| Analyzing unknown codebase   | EXPLORE | Need to discover patterns         |
| Designing new feature        | EXPLORE | Need to generate options          |
| Reviewing design             | MIXED   | Creative feedback + strict checks |
| Implementing approved design | EXPLOIT | Spec is the contract              |
| Fixing specific bug          | EXPLOIT | Solution already determined       |
| Refactoring per plan         | EXPLOIT | Changes are predefined            |
| Debugging unknown issue      | EXPLORE | Need to discover cause            |
| Writing documentation        | EXPLOIT | Structure is defined              |

---

## Mode Conflict Resolution

### When Unsure

```markdown
Mode uncertainty detected.

Indicators:

- EXPLORE: {list}
- EXPLOIT: {list}

Default: {chosen mode}
Rationale: {why}

If incorrect, signal: "MODE: {other mode}"
```

### Implicit vs Explicit

| Signal Type          | Priority |
| -------------------- | -------- |
| Explicit in dispatch | Highest  |
| Phase-based default  | Medium   |
| Task verb inference  | Lowest   |

Explicit always wins.

---

## Integration with Quality Gates

### Gate Behavior by Mode

| Gate                 | EXPLORE Behavior                | EXPLOIT Behavior            |
| -------------------- | ------------------------------- | --------------------------- |
| Design Review        | Must pass before implementation | N/A (already passed)        |
| Implementation Check | N/A                             | Must pass before completion |
| Verification         | Feasibility check               | Full test suite             |

### Mode-Specific Success Criteria

**EXPLORE phase success:**

- [ ] Multiple options generated
- [ ] Trade-offs documented
- [ ] Recommendation justified
- [ ] Risks identified

**EXPLOIT phase success:**

- [ ] Spec fully implemented
- [ ] All changes verified
- [ ] No unauthorized deviations
- [ ] Tests pass

---

## ALWAYS / NEVER

### ALWAYS

1. Declare mode at start of sub-agent dispatch
2. Include mode-specific constraints
3. Signal mode transitions explicitly
4. Respect guardrails in both modes
5. Document mode conflicts when detected

### NEVER

1. Mix EXPLORE behavior in EXPLOIT phase
2. Transition modes without explicit signal
3. Skip guardrails in EXPLORE mode
4. Add features creatively in EXPLOIT mode
5. Assume mode from context alone
