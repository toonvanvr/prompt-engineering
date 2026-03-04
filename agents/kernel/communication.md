# Human-AI Communication & Override Protocol

Autonomous execution with passive human override via single file interface.

## Core Principles

> User prompt = implicit approval for entire flow. Proceed autonomously.
> Human writes to `{workfolder}/communication/ai_status.md` — AI reads at checkpoints.
> AI writes status updates. Human reads for progress. Single file = lower cognitive load.
> NEVER ask "should I proceed?" — use `{workfolder}/communication/ai_status.md` Human Input instead.

## Folder Structure

`{workfolder}/communication/`: `ai_status.md` (status + Human Input), `findings.md` (discoveries), `queue.md` (optional).

## Anti-Patterns (FORBIDDEN)

|❌ Don't|✅ Do Instead|
|-|-|
|"Should I proceed?"|Proceed (scan `{workfolder}/communication/ai_status.md` first)|
|"Would you prefer X or Y?"|Choose based on design, document rationale|
|"Do you want me to..."|Do it (user prompt = approval)|
|Any permission question|Just do it|

**Rule:** If response ends with a permission question, delete it and proceed. Enterprise flows run autonomously until completion.

## Human Input Protocol

Human appends timestamped entries (`### [YYYY-MM-DDTHH:MM:SS] ACTION: {action}`) to `## Human Input` section of `{workfolder}/communication/ai_status.md`.

### Supported Actions

|Action|Effect|Required Fields|
|-|-|-|
|`pause`|Halt at next checkpoint|REASON|
|`resume`|Continue after pause|—|
|`abort`|Stop task, cleanup|REASON (optional)|
|`redirect`|Change direction|OBJECTIVE|
|`feedback`|Apply adjustment, continue|CONTENT|
|`context`|Add information|CONTENT|
|`approve`|Clear pending approval gates|—|

## AI Status Protocol

AI updates `{workfolder}/communication/ai_status.md` with: Updated (ISO8601), Phase, Status (running|paused|blocked|complete), Current Task, Progress checklist, Blockers, Next Action, empty Human Input section.

**Update frequency (MANDATORY):** After creation (startup), after each SA completes, at session completion. Stale status = invisible session = protocol failure.

## Checkpoint Protocol

### Orchestrator (3 structural events)

|Checkpoint|When|
|-|-|
|Session-start|After startup completes|
|Pre-SA-dispatch|Before dispatching any sub-agent|
|Pre-handoff|Before writing final handoff|

### Sub-Agent (2 structural events)

|Checkpoint|When|
|-|-|
|SA-start|During startup protocol|
|SA-pre-handoff|Before writing handoff|

**Scaling:** Orchestrator checks = SA_count + 2. Do NOT scan at any other time. No frequency words ("regularly", "periodically").

## Processing Protocol

```
1. Scan Human Input section at checkpoints
2. Empty or no unprocessed entries → continue immediately
3. For each unprocessed entry (by timestamp):
   a. Parse ACTION → apply effect → archive to 00_prompts/ → mark processed
4. abort → HALT | else → continue (no wait unless abort/escalation)
```

## Approval Request (Escalation Only)

When escalation requires explicit approval, write to `{workfolder}/communication/ai_status.md`: summary, artifacts, risk level, decision (APPROVE/DENY). When received (chat or `ACTION: approve`): log approval, update gate to PASS, proceed, document in handoff.

## Agent Integration

Startup: Create `{workfolder}/communication/`, init `ai_status.md` with session metadata + empty Human Input section, check for existing entries.

ALWAYS: Scan `{workfolder}/communication/ai_status.md` Human Input at checkpoints.
