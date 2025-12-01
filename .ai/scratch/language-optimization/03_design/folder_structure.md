# v2 Agent Folder Structure

## Overview

New structure separates concerns: compiled (AI-optimized) vs source (human-readable), with explicit mode protocols.

## Directory Layout

```
agents/
├── v2/                           # New optimized structure
│   ├── compiled/                 # AI-optimized prompts (generated)
│   │   ├── orchestrator.agent.md
│   │   ├── analyst.agent.md
│   │   ├── designer.agent.md
│   │   ├── implementer.agent.md
│   │   ├── reviewer.agent.md
│   │   └── compiler.agent.md
│   │
│   ├── source/                   # Human-readable source
│   │   ├── orchestrator.src.md
│   │   ├── analyst.src.md
│   │   ├── designer.src.md
│   │   ├── implementer.src.md
│   │   ├── reviewer.src.md
│   │   └── compiler.src.md
│   │
│   ├── kernel/                   # Core behavior rules
│   │   ├── README.md
│   │   ├── three-laws.md         # Immutable laws
│   │   ├── consistency-stack.md  # 5-layer anchoring
│   │   ├── mode-protocol.md      # Explore/Exploit switching
│   │   ├── sub-agent-mandate.md  # Mandatory spawning rules
│   │   ├── context-budget.md     # Token/file limits
│   │   ├── quality-gates.md      # Phase transition checks
│   │   ├── self-analysis.md      # Flaw documentation protocol
│   │   └── escalation.md         # 3-attempt protocol
│   │
│   ├── templates/                # Dispatch templates (compressed)
│   │   ├── dispatch-base.md      # Common dispatch prefix
│   │   ├── dispatch-analysis.md
│   │   ├── dispatch-design.md
│   │   ├── dispatch-implement.md
│   │   ├── dispatch-review.md
│   │   └── handoff.md
│   │
│   ├── modes/                    # Mode-specific behaviors
│   │   ├── explore.md            # Analysis/Design creativity
│   │   └── exploit.md            # Implementation consistency
│   │
│   └── training/                 # Learning from execution
│       ├── examples/             # Good prompt examples
│       └── anti-patterns/        # What to avoid
│
├── legacy/                       # Current agents (moved here)
│   └── ... (current structure)
│
└── README.md                     # Routing: symlink target docs
```

## File Purposes

### `/v2/compiled/` — AI-Optimized Agents

| File                    | Purpose                               | Source                       |
| ----------------------- | ------------------------------------- | ---------------------------- |
| `orchestrator.agent.md` | Master coordinator, spawns sub-agents | `source/orchestrator.src.md` |
| `analyst.agent.md`      | Code analysis, pattern discovery      | `source/analyst.src.md`      |
| `designer.agent.md`     | Architecture, solution design         | `source/designer.src.md`     |
| `implementer.agent.md`  | Code creation/modification            | `source/implementer.src.md`  |
| `reviewer.agent.md`     | Quality verification                  | `source/reviewer.src.md`     |
| `compiler.agent.md`     | Prompt compilation (meta-agent)       | `source/compiler.src.md`     |

Format: Compressed, Technical Documentation register, ~50-70% token reduction.

### `/v2/source/` — Human-Readable Source

Same agents in verbose format. Humans edit here, compilation generates `/compiled/`.

Format: Full prose, examples, rationale included.

### `/v2/kernel/` — Inherited Behaviors

| File                   | Content                         |
| ---------------------- | ------------------------------- |
| `three-laws.md`        | Immutable orchestration laws    |
| `consistency-stack.md` | 5-layer anchoring template      |
| `mode-protocol.md`     | Explore ↔ Exploit transitions   |
| `sub-agent-mandate.md` | When/how to spawn sub-agents    |
| `context-budget.md`    | Token limits by task type       |
| `quality-gates.md`     | Phase transition requirements   |
| `self-analysis.md`     | How to document execution flaws |
| `escalation.md`        | 3-attempt error protocol        |

All kernel files use compressed format — inherited via reference.

### `/v2/templates/` — Dispatch Templates

Pre-formatted dispatch prompts for sub-agents. Each includes:

- Kernel inheritance section
- Task-specific structure
- Output requirements
- Mode declaration (EXPLORE vs EXPLOIT)

### `/v2/modes/` — Mode Behaviors

Separate files for mode-specific rules:

- `explore.md`: Creativity enabled, guardrails only
- `exploit.md`: Strict consistency, no deviation

### `/v2/training/` — Learning Repository

Store examples for future prompt optimization:

- `examples/`: Successful prompts (annotated)
- `anti-patterns/`: Failed patterns (annotated)

## Migration Strategy

```
Phase 1: Build v2 structure alongside current
         - .github/agents → ./agents (current, unchanged)

Phase 2: Verify v2 agents work correctly
         - Test in isolated sessions
         - Compare output quality

Phase 3: Switch symlink
         - .github/agents → ./agents/v2/compiled
         - Move current to ./agents/legacy

Phase 4: Deprecate legacy
         - Remove after 2 weeks stable
```

## Symlink Configuration

Current: `.github/agents` → `./agents`
Future: `.github/agents` → `./agents/v2/compiled`

## Naming Conventions

| Type           | Pattern               | Example                 |
| -------------- | --------------------- | ----------------------- |
| Compiled agent | `<role>.agent.md`     | `orchestrator.agent.md` |
| Source agent   | `<role>.src.md`       | `orchestrator.src.md`   |
| Kernel rule    | `<concept>.md`        | `three-laws.md`         |
| Template       | `dispatch-<phase>.md` | `dispatch-analysis.md`  |
| Mode spec      | `<mode>.md`           | `explore.md`            |

## Token Budget Estimates

| File Type      | Target Lines | Target Tokens |
| -------------- | ------------ | ------------- |
| Compiled agent | 150-200      | 800-1200      |
| Source agent   | 300-400      | 2000-3000     |
| Kernel rule    | 50-100       | 300-600       |
| Template       | 80-120       | 400-700       |
| Mode spec      | 60-80        | 300-500       |

Orchestrator may be larger (250-300 lines) due to coordination complexity.
