# Communication Protocol

Simplified human-AI communication via single file interface.

---

## Core Principle

> Human writes to `ai_status.md` "Human Input" section. AI reads and processes.
> AI writes status updates to `ai_status.md`. Human reads for progress.
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
```

---

## Processing Protocol

```
1. Scan `ai_status.md` Human Input section at checkpoints
2. IF empty or no unprocessed entries → continue
3. FOR each unprocessed entry (by timestamp):
   a. Parse ACTION
   b. Apply action effect
   c. Archive entry to `.ai/scratch/{session}/00_prompts/{seq}_{action}.md`
   d. Mark as processed in ai_status.md
4. IF abort → HALT
5. ELSE → continue
```

### Checkpoint Triggers

|Checkpoint|When|
|-|-|
|Task-start|Session initialization|
|Phase-start|Before Analysis/Design/Review/Implementation|
|Pre-gate|Before phase gate verification|
|Pre-handoff|Before creating handoff document|

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
2. Initialize `ai_status.md` with session metadata + empty Human Input section
3. Check for existing Human Input entries in ai_status.md
```

Add to ALWAYS list:
```md
- Scan `communication/ai_status.md` Human Input section at checkpoints
```

---

## Migration from .human/

|Old|New|
|-|-|
|`.human/instructions/`|`communication/ai_status.md` Human Input section|
|`.human/input/`|`communication/ai_status.md` Human Input section|
|`.human/templates/`|Examples in this doc|
|Multiple file types|Single file, ACTION field|

### Why Simpler?

- **1 location** instead of 3 folders
- **1 format** instead of multiple file types
- **Append-only** instead of file creation
- **Keywords** instead of template files
- **Lower cognitive load** for humans

---

## Backward Compatibility

Agents should check both:
1. `ai_status.md` Human Input section (preferred)
2. `.human/instructions/` (legacy, if exists)

Process legacy files and migrate to new format.
