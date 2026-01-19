# Communication Protocol

Simplified human-AI communication via single file interface.

---

## Core Principle

> Human writes to `communication/human_input.md`. AI reads and processes.
> AI writes to `communication/ai_status.md`. Human reads for progress.
> Single folder. Simple files. Low cognitive load.

**Model:** Append-only input file. AI clears processed entries.

---

## Folder Structure

```
.ai/scratch/{session}/communication/
├── human_input.md     # Human writes here
├── ai_status.md       # AI writes status here
├── findings.md        # Accumulated discoveries
└── queue.md           # Task queue (optional)
```

---

## Human Input Protocol

### Writing Input

Human appends to `communication/human_input.md`:

```markdown
## [YYYY-MM-DDTHH:MM:SS] Human Input

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
1. Scan `communication/human_input.md` at checkpoints
2. IF empty or no unprocessed entries → continue
3. FOR each unprocessed entry (by timestamp):
   a. Parse ACTION
   b. Apply action effect
   c. Move entry to `.ai/scratch/{session}/00_prompts/{seq}_{action}.md`
   d. Log in ai_status.md
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
2. Initialize `ai_status.md` with session metadata
3. Check for existing `human_input.md` entries
```

Add to ALWAYS list:
```md
- Scan `communication/human_input.md` at checkpoints
```

---

## Migration from .human/

|Old|New|
|-|-|
|`.human/instructions/`|`communication/human_input.md`|
|`.human/input/`|`communication/human_input.md`|
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
1. `communication/human_input.md` (preferred)
2. `.human/instructions/` (legacy, if exists)

Process legacy files and migrate to new format.
