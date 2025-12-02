# Human-in-the-Loop Protocol

Asynchronous human intervention for long-running tasks.

---

## Core Principle

> Check `.human/instructions/` at key checkpoints. Process if present. Continue if empty.

---

## Folder Structure

```
.human/
├── templates/       # Pre-defined instruction templates (user source)
├── instructions/    # Active instructions (AI reads)
└── processed/       # Completed instructions (AI writes)
```

---

## Checkpoint Triggers

### Orchestrator Checkpoints

|Trigger|When|Priority|
|-|-|-|
|Pre-dispatch|Before spawning sub-agent|HIGH|
|Post-gate|After gate verification passes|MEDIUM|
|Pre-phase|Before starting new phase|MEDIUM|
|Escalation|Before escalating to user|HIGH|

### Implementer Checkpoints

|Trigger|When|Priority|
|-|-|-|
|Pre-phase|Before each implementation phase|MEDIUM|
|Multi-file|Before modifying 3+ files|HIGH|
|Deviation|Before deviating from design|HIGH|

### Sub-Agent Checkpoints

|Trigger|When|Priority|
|-|-|-|
|Start|At sub-agent initialization|LOW|
|Pre-handoff|Before creating handoff|LOW|

---

## Check Protocol

```
1. List `.human/instructions/` contents
2. If empty → continue normally
3. If files present:
   a. Read all instruction files (sorted by name)
   b. Parse checkbox states and values
   c. Execute instruction actions
   d. Move each file to `.human/processed/` with timestamp prefix
   e. Document instruction effect in current task log
4. Resume task (may be modified by instructions)
```

---

## Instruction Processing

### File Movement

```
.human/instructions/feedback.md
    ↓ processed
.human/processed/20241201-143052-feedback.md
```

### Parse Rules

|Checkbox|Interpretation|
|-|-|
|`- [x]`|Selected / true|
|`- [ ]`|Not selected / false|
|`___`|Fill-in field (use value after colon if present)|

### Conflict Resolution

Multiple instructions processed in filename alphabetical order. If conflicting:
- Later instruction overrides earlier
- Abort/Pause take precedence over all
- Log conflict to self-analysis

---

## Instruction Actions

|Template|Effect|
|-|-|
|abort|Stop task, optionally rollback|
|redirect|Change task scope/direction|
|pause|Halt and wait for resume|
|skip-phase|Skip specified phase(s)|
|feedback|Apply adjustments, continue|
|approve|Clear pending approval gates|
|priority|Reorder task queue|
|context|Inject new information|

---

## Implementation in Agents

### Check Function (Pseudocode)

```md
## Human Check

1. Read `.human/instructions/` directory
2. IF empty:
   - Log: "Human check: no instructions"
   - CONTINUE
3. FOR each file:
   - Parse instruction
   - Apply action
   - Move to processed with timestamp
   - Log: "Human instruction processed: {action}"
4. IF abort/pause:
   - HALT
5. ELSE:
   - CONTINUE with modifications
```

### Agent Integration

Add to ALWAYS list:
```md
- **Check human instructions** at checkpoints — process before proceeding
```

Add to dispatch templates:
```md
## Human Override

Check `.human/instructions/` at: start, pre-handoff
Process any instructions before continuing.
```

---

## Inheritance

Sub-agents inherit human-check protocol. Checkpoints:
- Start of sub-agent execution
- Before handoff creation

---

## Non-Blocking Behavior

- Empty folder = immediate continue
- Check is fast (directory listing)
- Only blocks when instruction present
- Enables async human intervention without polling

---

## Logging

All instruction processing logged to:
- Current scratch space: `.ai/scratch/{topic}/human_instructions.log`
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
