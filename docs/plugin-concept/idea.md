# VS Code Plugin Concept: Human-in-the-Loop Interface

## Problem Statement

When AI agents execute multi-phase tasks (orchestrator workflows), humans struggle to:
1. **See progress** — Task state hidden in chat scrollback
2. **Intervene** — File-based overrides require switching contexts
3. **Prioritize** — No way to reorder task queue mid-execution
4. **Review** — Approvals scattered across `.human/instructions/`
5. **Learn** — Feedback collection is passive, not curated

## Current Mechanism

```
Human                    Agent
  │                        │
  │  Place file in         │
  │  .human/instructions/  │
  │ ───────────────────────▶
  │                        │ Scan at checkpoint
  │                        │ Process instruction
  │                        │ Move to scratch/00_prompts/
  │                        │
  │  Read _handoff.md      │
  │ ◀───────────────────── │
```

**Pain Points:**
- Manual file creation
- No visual feedback on agent state
- Queue is markdown, not interactive
- Approval requires copying template + editing

## Vision: Agent Dashboard

A VS Code sidebar panel that surfaces agent state and provides one-click interactions.

```
┌─────────────────────────────────────┐
│ 🤖 Agent Dashboard                  │
├─────────────────────────────────────┤
│ ▶ Current: Implementing Auth API    │
│   Phase: Implementation (EXPLOIT)   │
│   Files: 3/8                        │
│   ██████░░░░░░░░ 40%                │
├─────────────────────────────────────┤
│ 📋 Queue                            │
│   ┌───────────────────────────────┐ │
│   │ 1. Implement AuthController   │ │
│   │ 2. Add middleware             │ │
│   │ 3. Write unit tests           │ │
│   │ 4. Integration tests          │ │
│   └───────────────────────────────┘ │
│   [↑] [↓] Reorder  [⏸] Pause        │
├─────────────────────────────────────┤
│ ⚡ Quick Actions                     │
│   [Approve] [Redirect] [Abort]      │
├─────────────────────────────────────┤
│ 📁 Recent Files                     │
│   • src/auth/controller.ts (mod)    │
│   • src/middleware/jwt.ts (new)     │
└─────────────────────────────────────┘
```

## File-Based Foundation

The plugin **reads and writes the same files** agents already use. No new protocol needed.

| UI Action | File Operation |
|-----------|----------------|
| View progress | Read `.ai/scratch/*/STATE.md` |
| View queue | Read `.ai/scratch/*/communication/queue.md` |
| Approve | Write `.human/instructions/approve.md` |
| Pause | Write `.human/instructions/pause.md` |
| Redirect | Write `.human/instructions/redirect.md` |
| Abort | Write `.human/instructions/abort.md` |
| Reorder queue | Edit `queue.md` |
| Add feedback | Append to `.ai/feedback/*.md` |

## Minimal Implementation Path

### Phase 1: Read-Only Dashboard
- Watch `.ai/scratch/*/STATE.md` for changes
- Parse phase, progress, blockers
- Display in TreeView sidebar
- Zero writes, pure observation

### Phase 2: Quick Actions
- Buttons that write template files to `.human/instructions/`
- Template content pre-filled
- File watcher confirms delivery (file moved to `00_prompts/`)

### Phase 3: Queue Management
- Parse `queue.md` into draggable list
- Reorder = rewrite file
- Priority annotations (`!high`, `!low`) → visual indicators

### Phase 4: Feedback Curation
- Show `.ai/feedback/` categories
- One-click "add observation"
- Mark entries for sync

## Future: MCP Integration

When VS Code supports MCP (Model Context Protocol), plugin could:
- Receive structured state updates via MCP
- Send typed interventions (not just files)
- Get real-time progress without file watching
- Share context between plugin and agent

But **file-based works today**. MCP is enhancement, not prerequisite.

## Key Design Principles

1. **No Agent Changes** — Plugin adapts to existing file conventions
2. **Graceful Degradation** — Without plugin, file-based still works
3. **Observation First** — Read-only mode valuable on its own
4. **One-Click UX** — Every action ≤2 clicks
5. **Trust Model** — Plugin is visualization layer, not authority

## Open Questions

1. How to detect "active" scratch folder? (Most recent with non-complete STATE.md?)
2. Multiple concurrent workflows? (Tabs or picker?)
3. Notification on gate? (VS Code notification API?)
4. Mobile/remote access? (Out of scope for v1)

## Success Metrics

| Metric | Before Plugin | After Plugin |
|--------|---------------|--------------|
| Time to pause | 30s (navigate + create file) | 1 click |
| Approval latency | Minutes (notice + template) | Seconds |
| Intervention error rate | ~10% (typos, wrong folder) | ~0% |
| Progress visibility | Manual check | Real-time |

## Next Steps

1. Prototype TreeView with STATE.md watcher
2. Validate file watching performance
3. Design action button UX
4. Test with real orchestrator workflow
5. Iterate on queue reordering

---

*This is a concept document. No code yet.*
