# Human-in-the-Loop Protocol

Autonomous execution with passive human override capability.

---

## Core Principle

> User prompt = implicit approval for entire flow. Proceed autonomously.
> Scan `communication/ai_status.md` Human Input section at checkpoints. Empty → continue immediately.
> NEVER ask "should I proceed?" or "would you prefer?" — use communication/ai_status.md Human Input instead.

**Model:** Autonomous execution. Human intervenes via `communication/ai_status.md` entries, not confirmation dialogs.

---

## Anti-Patterns (FORBIDDEN)

|❌ Don't|✅ Do Instead|
|-|-|
|"Should I proceed?"|Proceed (scan communication/ai_status.md Human Input first)|
|"Would you prefer X or Y?"|Choose based on design, document rationale|
|"Do you want me to..."|Do it (user prompt = approval)|
|"Ready to proceed to X phase?"|Proceed to X phase|
|"Shall I continue?"|Continue|
|"Is this what you wanted?"|Deliver result, iterate if feedback|
|Any question asking permission|Just do it|

**Rule: No permission questions.** If your response ends with a question asking whether to proceed/continue/start/implement, delete the question and proceed instead.

**Enterprise flows run autonomously until completion.** Halting to ask = failure.

---

## Pause/Resume Mechanism

To pause execution, human appends to `communication/ai_status.md` Human Input section:

```markdown
### [YYYY-MM-DDTHH:MM:SS]
ACTION: pause
REASON: [Why pausing]
```

Agent detects at next checkpoint, halts, and logs pause reason.

To resume, human appends:

```markdown
### [YYYY-MM-DDTHH:MM:SS]
ACTION: resume
```

Human can add feedback/context/redirect entries while paused. Agent processes all entries when resuming.

---

## Supported Actions

|Action|Effect|Required Fields|
|-|-|-|
|`pause`|Halt at next checkpoint|REASON|
|`resume`|Continue after pause|—|
|`abort`|Stop task, cleanup|REASON (optional)|
|`redirect`|Change direction|OBJECTIVE|
|`feedback`|Apply adjustment, continue|CONTENT|
|`context`|Add information|CONTENT|
|`approve`|Clear pending approval gates|—|

---

## Checkpoint Triggers

See `communication.md` § Checkpoint Protocol for the definitive checkpoint schedule.

Orchestrator: 3 structural events (session-start, pre-SA-dispatch, pre-handoff).
Sub-agents: 2 structural events (SA-start, SA-pre-handoff).

**Passive scan:** Check communication/ai_status.md Human Input → process if entries exist → continue immediately (no wait, no questions).
**Halt:** ONLY `abort` action OR escalation protocol (3 failed attempts) blocks execution.
**Never halt to ask human for confirmation** — that defeats autonomous execution.

---

## Check Protocol

```
1. Scan communication/ai_status.md Human Input section for unprocessed entries
2. If empty or no unprocessed entries → continue immediately
3. If entries present:
   a. Read all entries (sorted by timestamp)
   b. Parse ACTION and fields
   c. Execute action effects
   d. Archive to .ai/scratch/{session}/00_prompts/{seq}_{action}.md
   e. Mark as processed in communication/ai_status.md
4. Continue task (no wait unless abort/escalation)
```

---

## Action Effects

|Action|Behavior|
|-|-|
|`pause`|Set status=paused, halt until resume|
|`resume`|Clear paused status, continue|
|`abort`|Set status=aborted, cleanup, create `_abort.md`|
|`redirect`|Update objective, restart from current phase|
|`feedback`|Apply adjustment inline, continue|
|`context`|Add to session context, continue|
|`approve`|Clear pending approval gates, proceed|

---

## Inheritance

Sub-agents inherit passive scan protocol. See `communication.md` § Checkpoint Protocol for SA checkpoints:
- SA-start (during startup protocol)
- SA-pre-handoff (before writing handoff document)

---

## Non-Blocking Behavior

- No unprocessed entries = immediate continue
- Check is fast (section scan)
- Only blocks on abort or escalation
- Enables autonomous execution with human override capability

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

When approval received (via chat or `ACTION: approve` in communication/ai_status.md):

1. Log approval to scratch space
2. Update gate status to PASS
3. Proceed to next phase
4. Document approver in handoff
