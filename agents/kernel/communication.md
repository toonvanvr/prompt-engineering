# Communication Protocol

Simplified human-AI communication via single file interface.

---

## Core Principle

> Human writes to `communication/ai_status.md` "Human Input" section. AI reads and processes.
> AI writes status updates to `communication/ai_status.md`. Human reads for progress.
> Single file. Lower cognitive load.

**Model:** Single file with sections. Human appends to designated section.

---

## Folder Structure

```
.ai/scratch/{session}/communication/
├── ai_status.md       # AI status + Human Input section
├── findings.md        # Accumulated discoveries
└── queue.md           # Task queue (optional)
```

> **Single-file communication.** There is NO separate `human_input.md`. All human input goes through `communication/ai_status.md`'s `## Human Input` section. One file = lower cognitive load.

---

## Human Input Protocol

### Writing Input

Human appends to the **Human Input** section of `communication/ai_status.md`:

```markdown
## Human Input

### [YYYY-MM-DDTHH:MM:SS]

ACTION: {action}
{additional fields per action type}
```

### Supported Actions

|Action|Effect|Required Fields|
|-|-|-|
|`pause`|Halt at next checkpoint|REASON|
|`resume`|Continue after pause|—|
|`abort`|Stop task, cleanup|REASON (optional)|
|`redirect`|Change direction|OBJECTIVE|
|`feedback`|Apply adjustment, continue|CONTENT|
|`context`|Add information|CONTENT|

### Examples

```markdown
## [2026-01-19T14:30:00] Human Input

ACTION: pause
REASON: Need to review design before proceeding

---

## [2026-01-19T15:00:00] Human Input

ACTION: feedback
CONTENT: Also consider error handling in the auth flow

---

## [2026-01-19T15:30:00] Human Input

ACTION: resume
```

---

## AI Status Protocol

AI updates `communication/ai_status.md`:

```markdown
# Session Status

**Updated**: {ISO8601}
**Phase**: {current_phase}
**Status**: {running|paused|blocked|complete}

## Current Task
{task_description}

## Progress
- [x] Completed step
- [ ] Pending step

## Blockers
{none OR description}

## Next Action
{what AI will do next}

## Human Input
<!-- Human: append timestamped entries below. Format: -->
<!-- ### [YYYY-MM-DDTHH:MM:SS] -->
<!-- ACTION: pause | resume | abort | redirect | feedback | context -->
```

---

## Processing Protocol

```
1. Scan `communication/ai_status.md` Human Input section at checkpoints
2. IF empty or no unprocessed entries → continue
3. FOR each unprocessed entry (by timestamp):
   a. Parse ACTION
   b. Apply action effect
   c. Archive entry to `.ai/scratch/{session}/00_prompts/{seq}_{action}.md`
   d. Mark as processed in communication/ai_status.md
4. IF abort → HALT
5. ELSE → continue
```

### Checkpoint Protocol

#### Orchestrator Checkpoints (3 structural events)

|Checkpoint|When|
|-|-|
|Session-start|After orchestrator startup completes|
|Pre-SA-dispatch|Before dispatching any sub-agent|
|Pre-handoff|Before writing final session handoff|

#### SA Checkpoints (2 structural events)

|Checkpoint|When|
|-|-|
|SA-start|During SA startup protocol (first action)|
|SA-pre-handoff|Before SA writes handoff document (last action)|

**Scaling property**: Orchestrator checks = SA_count + 2 (startup + handoff). SA count scales naturally with task complexity.

**Do NOT scan** at any other time. Do NOT scan between Post-SA Protocol steps, during file operations, or on a time-based schedule. No frequency words ("regularly", "periodically", "at key points").

### Status Update Frequency (MANDATORY)

communication/ai_status.md MUST be updated:
1. After initial creation (startup)
2. After each SA completes (Post-SA Protocol Step 5)
3. At session completion

**Stale communication/ai_status.md = invisible session.** The human has no other way to track progress. Status files stuck at "Startup" phase for an entire session is a protocol failure.

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

---

## Agent Integration

Add to startup:
```md
1. Create `.ai/scratch/{session}/communication/` folder
2. Initialize `communication/ai_status.md` with session metadata + empty Human Input section
3. Check for existing Human Input entries in communication/ai_status.md
```

Add to ALWAYS list:
```md
- Scan `communication/ai_status.md` Human Input section at checkpoints
```
