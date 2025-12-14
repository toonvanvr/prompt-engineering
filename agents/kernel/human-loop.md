# Human-in-the-Loop Protocol

Autonomous execution with passive human override capability.

---

## Core Principle

> Scan `.human/instructions/` at checkpoints. Process immediately if present. Continue without waiting.

**Model:** Autonomous by default, intervention by exception.

---

## Folder Structure

```
.human/
├── templates/       # Pre-defined instruction templates (copy to instructions/)
└── instructions/    # Active instructions (AI scans at checkpoints)
```

Processed instructions move to `.ai/scratch/{workfolder}/00_prompts/`.

---

## Checkpoint Triggers (6 Total)

|Checkpoint|When|Behavior|
|-|-|-|
|Task-start|Session init|Passive scan|
|Phase-start|Before Analysis/Design/Review|Passive scan|
|Pre-gate|Before phase gate (Analysis/Design/Review)|Passive scan|
|Pre-impl|Before Implementation Gate|Passive scan|
|Deviation|Before design deviation|Passive scan|
|Escalation|Before escalating|Write to `.human/`, halt|

**Passive scan:** Check → process if present → continue immediately (no wait).
**Halt:** Only `abort` and `escalation` scenarios block execution.

---

## Check Protocol

```
1. Scan `.human/instructions/` contents
2. If empty → continue immediately
3. If files present:
   a. Read all instruction files (sorted by name)
   b. Parse checkbox states and values
   c. Execute instruction actions
   d. Move to `.ai/scratch/{workfolder}/00_prompts/{seq}_{name}.md`
   e. Document instruction effect in current task log
4. Continue task (no wait unless abort/escalation)
```

---

## Instruction Processing

### File Movement

```
.human/instructions/feedback.md
    ↓ processed
.ai/scratch/{workfolder}/00_prompts/01_feedback.md
```

### Naming Convention

|Source|Target Pattern|
|-|-|
|User's first prompt|`00_initial_request.md`|
|feedback.md processed|`01_feedback.md`|
|redirect.md processed|`02_redirect.md`|
|Custom file|`{seq}_{slug}.md`|

### Parse Rules

|Checkbox|Interpretation|
|-|-|
|`- [x]`|Selected / true|
|`- [ ]`|Not selected / false|
|`___`|Fill-in field (use value after colon if present)|

### Conflict Resolution

Multiple instructions processed in filename alphabetical order. If conflicting:
- Later instruction overrides earlier
- Abort takes precedence over all
- Log conflict to self-analysis

---

## Instruction Actions

|Template|Effect|
|-|-|
|abort|Stop task, optionally rollback|
|redirect|Change task scope/direction|
|skip-phase|Skip specified phase(s)|
|feedback|Apply adjustments, continue|
|approve|Clear pending approval gates|
|context|Inject new information|

---

## Implementation in Agents

### Async Scan Function (Pseudocode)

```md
## Async Scan (.human/instructions/)

1. Scan `.human/instructions/` directory
2. IF empty:
   - CONTINUE immediately (no log needed)
3. FOR each file:
   - Parse instruction
   - Apply action
   - Move to `.ai/scratch/{workfolder}/00_prompts/`
   - Log: "Instruction processed: {action}"
4. IF abort:
   - HALT
5. ELSE:
   - CONTINUE immediately
```

### Agent Integration

Add to ALWAYS list:
```md
- **Async scan** `.human/instructions/` at checkpoints — process without waiting
```

---

## Inheritance

Sub-agents inherit passive scan protocol. Checkpoints:
- Task-start (session init)
- Pre-impl (before implementation)
- Deviation (before design deviation)

---

## Non-Blocking Behavior

- Empty folder = immediate continue
- Check is fast (directory scan)
- Only blocks on abort or escalation
- Enables autonomous execution with human override capability

---

## Logging

Instruction processing logged to:
- Current scratch space: `.ai/scratch/{topic}/00_prompts/`
- Self-analysis if issues: `.ai/self-analysis/`

Log format:
```md
## Human Instruction Processed

Timestamp: {ISO8601}
Checkpoint: {trigger}
File: {filename}
Action: {instruction_type}
Effect: {what changed}
```

---

## Approval Request Pattern

### For Escalation Scenarios Only

When escalation requires explicit approval:

```md
## Approval Required: {gate_name}

### Summary
{what needs approval}

### Artifacts for Review
|Artifact|Path|
|-|-|
|{name}|{path}|

### Risk Level
- Stakes: HIGH
- Impact: {description}

### Decision Required
- [ ] APPROVE: Proceed to {next_phase}
- [ ] DENY: {reason} — return to {previous_phase}

⚠️ Escalation scenario — waiting for response.
```

### Approval Processing

When approval received:

1. Log approval to scratch space
2. Update gate status to PASS
3. Proceed to next phase
4. Document approver in handoff
