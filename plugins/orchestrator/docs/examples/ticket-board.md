# Ticket Board: Full Web App from Spec Folder

## Prompt

> Execute the prompts in `docs/specs/`. Build a ticket board app.

## What Happens

Multi-prompt folder pattern — the orchestrator reads all spec files, orders them by dependency, and executes them as a coordinated build plan.

### Spec Folder Contents

```
docs/specs/
├── 01-data-model.md      # Ticket, Board, User schemas
├── 02-api-endpoints.md   # REST API spec
├── 03-auth.md            # JWT auth flow
├── 04-board-ui.md        # Kanban board component
├── 05-drag-drop.md       # Drag-and-drop reording
└── 06-notifications.md   # Real-time updates via WebSocket
```

### Pipeline: Research → Design → Sequential Implement

**Research phase** reads all spec files and maps dependencies:
- 01 → standalone (data model, no deps)
- 02 → depends on 01
- 03 → depends on 02
- 04-06 → depend on 02, can partially parallelize

**Design phase** produces:
- Tech stack decisions (framework, DB, auth library)
- Shared interfaces across specs
- Implementation order with parallelization opportunities
- Integration points between specs

**Implementation phase** executes specs in order:
1. Data model and database setup
2. API endpoints
3. Auth middleware
4. UI components (board, drag-drop, notifications can overlap)

Each spec becomes its own implementation sub-task with its own verification gate.

## When to Use This Pattern

Use a spec folder when your project is too large for a single prompt. Break it into focused spec files, each describing one vertical slice. The orchestrator handles sequencing and cross-cutting concerns.
