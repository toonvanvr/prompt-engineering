# Feedback System

How feedback is collected, stored, and synced.

## Overview

Feedback is automatically collected during task execution and stored in `.ai/feedback/`. This solves the problem of learnings being lost.

## Feedback Categories

| Category | File | When Collected |
|----------|------|----------------|
| Tool Quirks | `tool_quirks.md` | Unexpected tool behavior |
| Pattern Successes | `pattern_successes.md` | Approach worked well |
| Pattern Failures | `pattern_failures.md` | Approach didn't work |
| Scope Overruns | `scope_overruns.md` | Task grew beyond estimate |
| Escalations | `escalations.md` | 3+ attempt failures |
| Human Interventions | `human_interventions.md` | User injected instructions |

## Collection Triggers

### Automatic (No Action Required)

1. **Tool Quirk**: When a tool behaves unexpectedly
   ```markdown
   ## 2026-01-19 | tool_quirk | project-name
   
   **Context**: Terminal command returned no output
   
   **Discovery**: Need to run `exec zsh` first for output capture
   
   **Recommendation**: Add to terminal initialization
   
   **Tags**: [tool:terminal] [pattern:initialization]
   ```

2. **Escalation**: When escalation protocol triggers (3 failed attempts)

### During Handoff

3. **Pattern Success/Failure**: Reflect on what worked or didn't

4. **Scope Overrun**: If final scope > initial by >50%

## Entry Format

```markdown
## {date} | {category} | {project}

**Context**: [One sentence describing the situation]

**Discovery**: [What was learned]

**Recommendation**: [Actionable improvement]

**Tags**: [tool:X] [pattern:Y] [phase:Z]
```

## Syncing to prompt-engineering

Feedback is automatically synced via symlinks created by QUICKSTART.sh:

- `.github/feedback` → `.ai/feedback`
- `.github/lib` → `.ai/library`

No sync script needed. Feedback written to `.ai/feedback/` is immediately available to the prompt-engineering repo.

## Processing Feedback

The Compiler agent can process incoming feedback to update kernel rules:

1. Read `.ai/library/feedback/incoming/`
2. Extract actionable patterns
3. Update relevant kernel files
4. Archive processed feedback

## Agent Responsibilities

| Agent | Collects |
|-------|----------|
| Orchestrator | Scope overruns, human interventions |
| Researcher | Analysis pattern discoveries |
| Designer | Design pattern successes/failures |
| Implementer | Tool quirks, implementation patterns |

## Directory Structure

```
.ai/
├── feedback/                    # Project-level feedback
│   ├── tool_quirks.md
│   ├── pattern_successes.md
│   ├── pattern_failures.md
│   ├── scope_overruns.md
│   ├── escalations.md
│   └── human_interventions.md
│
└── library/                     # Permanent knowledge
    └── feedback/
        └── incoming/            # Synced from other projects
```

## Non-Blocking

Feedback collection MUST NOT:
- Block task completion
- Require user approval
- Slow down critical path

If in doubt, append to feedback file and continue.
