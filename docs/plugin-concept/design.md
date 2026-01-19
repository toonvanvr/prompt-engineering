# Plugin Design: Agent Dashboard

## Architecture

```
┌─────────────────────────────────────────────────────────────┐
│ VS Code Extension                                           │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│  ┌──────────────┐    ┌──────────────┐    ┌──────────────┐   │
│  │ FileWatcher  │    │ TreeProvider │    │ ActionPanel  │   │
│  │              │────│              │    │              │   │
│  │ .ai/scratch  │    │ Phase View   │    │ [Approve]    │   │
│  │ .human/      │    │ Queue View   │    │ [Pause]      │   │
│  │ STATE.md     │    │ Files View   │    │ [Redirect]   │   │
│  └──────────────┘    └──────────────┘    └──────────────┘   │
│         │                   │                   │           │
│         └───────────────────┴───────────────────┘           │
│                             │                               │
│                    ┌────────▼────────┐                      │
│                    │ WorkspaceState  │                      │
│                    │                 │                      │
│                    │ - activeFolder  │                      │
│                    │ - phase         │                      │
│                    │ - queue[]       │                      │
│                    │ - files[]       │                      │
│                    └─────────────────┘                      │
│                                                             │
└─────────────────────────────────────────────────────────────┘
```

## Component Design

### 1. FileWatcher

Watches for changes in `.ai/` and `.human/`.

```typescript
interface WatchedPaths {
  scratch: '.ai/scratch/*/STATE.md';
  queue: '.ai/scratch/*/communication/queue.md';
  findings: '.ai/scratch/*/communication/findings.md';
  instructions: '.human/instructions/*.md';
  feedback: '.ai/feedback/*.md';
}
```

**Debounce:** 100ms to batch rapid writes

### 2. STATE.md Parser

```typescript
interface AgentState {
  phase: 'interpretation' | 'analysis' | 'design' | 'review' | 
         'implementation' | 'impl_review' | 'done';
  step: string;
  status: 'in_progress' | 'blocked' | 'complete';
  progress: { done: number; total: number };
  blockers: string[];
  lastUpdated: Date;
}

function parseStateMd(content: string): AgentState {
  // YAML frontmatter + markdown sections
}
```

### 3. TreeProvider

VS Code TreeDataProvider with sections:

```typescript
type TreeSection = 
  | { type: 'phase'; state: AgentState }
  | { type: 'queue'; items: QueueItem[] }
  | { type: 'files'; items: FileChange[] };

interface QueueItem {
  id: string;
  title: string;
  priority: 'high' | 'normal' | 'low';
  status: 'pending' | 'active' | 'done';
}
```

### 4. ActionPanel

Commands exposed to UI:

```typescript
const commands = {
  'agent.approve': () => writeInstruction('approve.md', approveTemplate),
  'agent.pause': () => writeInstruction('pause.md', pauseTemplate),
  'agent.redirect': () => promptAndWrite('redirect.md'),
  'agent.abort': () => confirmAndWrite('abort.md'),
  'agent.addFeedback': (category: FeedbackCategory) => appendFeedback(),
};
```

## File Formats

### STATE.md (read)

```yaml
phase: implementation
step: Writing AuthController
status: in_progress
---
## Progress
- [x] Create auth routes
- [x] Add JWT validation
- [ ] Implement login endpoint
- [ ] Implement logout endpoint
- [ ] Add rate limiting

## Blockers
(none)

## Next Action
Implementing login endpoint

## Last Updated: 2024-01-19T14:30:00Z
```

### queue.md (read/write)

```markdown
# Task Queue

## Active
- [>] Implement login endpoint

## Pending
- [ ] Implement logout endpoint !high
- [ ] Add rate limiting
- [ ] Write tests

## Completed
- [x] Create auth routes
- [x] Add JWT validation
```

### approve.md (write)

```yaml
type: approve
timestamp: 2024-01-19T14:35:00Z
---
Approved. Proceed with implementation.
```

## Extension Points

### Notification Integration
```typescript
vscode.window.showInformationMessage(
  'Review gate reached. Approve implementation?',
  'Approve', 'View Details'
).then(selection => {
  if (selection === 'Approve') commands['agent.approve']();
});
```

### Status Bar
```typescript
const statusBar = vscode.window.createStatusBarItem();
statusBar.text = '$(robot) Implementation 40%';
statusBar.tooltip = 'Click to open Agent Dashboard';
```

### WebView (Future)
Richer UI with drag-drop queue, charts, etc.

## Package.json Contributions

```json
{
  "contributes": {
    "views": {
      "explorer": [
        {
          "id": "agentDashboard",
          "name": "Agent Dashboard"
        }
      ]
    },
    "commands": [
      { "command": "agent.approve", "title": "Approve Gate" },
      { "command": "agent.pause", "title": "Pause Agent" },
      { "command": "agent.redirect", "title": "Redirect Task" },
      { "command": "agent.abort", "title": "Abort Task" }
    ],
    "menus": {
      "view/title": [
        { "command": "agent.approve", "when": "view == agentDashboard" }
      ]
    }
  }
}
```

## State Machine

```
                    ┌─────────────┐
                    │   IDLE      │
                    │ (no active) │
                    └──────┬──────┘
                           │ STATE.md detected
                           ▼
┌─────────────┐     ┌─────────────┐     ┌─────────────┐
│   PAUSED    │◀────│  RUNNING    │────▶│   WAITING   │
│             │pause│             │gate │ (approval)  │
└──────┬──────┘     └──────┬──────┘     └──────┬──────┘
       │                   │                   │
       │ resume            │ complete          │ approve
       └───────────────────┴───────────────────┘
                           │
                           ▼
                    ┌─────────────┐
                    │  COMPLETE   │
                    │ (_handoff)  │
                    └─────────────┘
```

## Error Handling

| Error | Recovery |
|-------|----------|
| STATE.md not found | Show "No active workflow" |
| Parse failure | Show raw file, log error |
| Write failure | Retry + user notification |
| Multiple workflows | Picker dialog |

## Development Phases

### v0.1 — Observer
- [ ] FileWatcher for STATE.md
- [ ] TreeView with phase display
- [ ] Status bar indicator

### v0.2 — Actor
- [ ] Approve/Pause/Abort buttons
- [ ] Instruction file templates
- [ ] Confirmation dialogs

### v0.3 — Manager
- [ ] Queue parsing
- [ ] Drag-drop reorder
- [ ] Priority badges

### v0.4 — Analyst
- [ ] Feedback viewer
- [ ] One-click categorization
- [ ] Sync button

---

*Design spec for future implementation. File-based protocol already works without plugin.*
