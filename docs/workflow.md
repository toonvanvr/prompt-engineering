# Workflow Guide

How phases, gates, and the scratch folder structure work.

## Phase Flow

```
User Request
    ↓
┌─────────────────────┐
│ 01_interpretation   │  ← Prompt parsing, scope definition
└─────────────────────┘
    ↓
┌─────────────────────┐
│ 02_analysis         │  ← @researcher: codebase exploration
└─────────────────────┘
    ↓
┌─────────────────────┐
│ 03_design           │  ← @designer: architecture specs
└─────────────────────┘
    ↓
⛔ IMPLEMENTATION GATE ⛔
    ↓
┌─────────────────────┐
│ 04_implementation   │  ← @implementer: code execution
└─────────────────────┘
    ↓
┌─────────────────────┐
│ Review & Handoff    │  ← Verification, _handoff.md
└─────────────────────┘
```

## Scratch Folder Structure

Created at task start:

```
.ai/scratch/2026-01-19_feature-name/
├── STATE.md              # Current phase, status, blockers
├── queue.md              # Task backlog with status
├── findings.md           # Accumulated discoveries
├── context_log.md        # Files accessed audit trail
├── _handoff.md           # Final completion document
│
├── 00_prompts/           # Original + processed instructions
│   └── 00_initial_request.md
│
├── 01_interpretation/    # Prompt parsing results
│   └── interpretation.md
│
├── 02_analysis/          # Research findings
│   ├── models.md
│   ├── jobs.md
│   └── patterns.md
│
├── 03_design/            # Design documents
│   ├── architecture.md
│   ├── _approval.md
│   └── implementation_plan.md
│
├── 04_implementation/    # Implementation notes
│   └── status.md
│
└── communication/        # Inter-agent coordination
    ├── queue.md          # Detailed task queue
    └── findings.md       # Shared discoveries
```

## Quality Gates

### Gate: Analysis Complete

- [ ] Patterns documented in `02_analysis/`
- [ ] Dependencies mapped
- [ ] Gaps identified

### Gate: Design Approved

- [ ] `03_design/_approval.md` exists
- [ ] Status: approved
- [ ] All trade-offs documented

### Gate: Implementation Complete

- [ ] All tests pass
- [ ] No blocking errors
- [ ] Verification logged

### Gate: Handoff Ready

- [ ] `_handoff.md` created
- [ ] Summary complete
- [ ] Artifacts listed

## STATE.md Format

```markdown
# Orchestration State

## Current Phase
**Phase 2: Analysis** — 🔄 IN PROGRESS

## Last Updated
2026-01-19 14:30 UTC

## Progress
- [x] Interpretation complete
- [x] Research SA dispatched
- [ ] Analysis complete
- [ ] Design started

## Blockers
- None

## Next Action
Wait for @researcher handoff
```

## Task Queue Format

```markdown
# Task Queue

## Task 1: Explore seed infrastructure
**Status**: `DONE`
**Completed**: 2026-01-19 10:15

## Task 2: Analyze model relationships
**Status**: `IN_PROGRESS`
**Assigned**: @researcher

## Task 3: Design builder pattern
**Status**: `PENDING`
**Depends On**: Task 2
```

## Multi-Day Resumption

If a task spans multiple sessions:

1. Check for existing scratch folders with today's date or incomplete STATE.md
2. Offer to resume (exception to no-ask rule for session continuity)
3. Read STATE.md to understand current phase
4. Continue from where left off

## Human Intervention

At any checkpoint, check `.human/instructions/`:

| File | Effect |
|------|--------|
| `pause.md` | Halt and wait |
| `redirect.md` | Change direction |
| `feedback.md` | Apply adjustments |
| `abort.md` | Stop immediately |
| `approve.md` | Clear pending gate |

Processed instructions move to `00_prompts/`.
