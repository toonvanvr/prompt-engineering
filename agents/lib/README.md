# GitHub Copilot Custom Agents

The parent directory contains custom GitHub Copilot agents for the FiBO project.

## Agents

### `end-to-end.agent.md`

The primary orchestration agent. Use this for complex, multi-phase development tasks.

**When to use:**

- Feature development spanning multiple files
- Tasks requiring analysis, design, and implementation phases
- Work that crosses backend/frontend boundaries
- Any task where sub-agent decomposition improves quality

**How to invoke:**

1. Open VS Code Chat
2. Select "End-to-End" from the agents dropdown
3. Describe your task

### `training-processor.agent.md`

Processes new training data to improve the agent system.

**When to use:**

- After adding new prompt files to training data
- To incorporate lessons learned from past runs

## Directory Structure

```
.github/agents/
├── end-to-end.agent.md         # Main orchestration agent
├── training-processor.agent.md # Training data processor
├── README.md                   # This file
└── lib/                        # Supporting library
    ├── kernel/                 # Core orchestration rules
    │   ├── orchestration.md    # Master orchestration logic
    │   ├── sub-agent-protocol.md # Sub-agent communication
    │   ├── context-management.md # Context window management
    │   └── quality-gates.md    # Quality checkpoints
    ├── templates/              # Reusable templates
    │   ├── dispatch-analysis.md
    │   ├── dispatch-design.md
    │   ├── dispatch-implementation.md
    │   ├── dispatch-review.md
    │   ├── phase-interpretation.md
    │   └── phase-handoff.md
    ├── training/               # Training data
    │   ├── data/              # Prompt and comment files
    │   │   ├── 001.prompt.md
    │   │   └── 002.prompt.md
    │   └── README.md
    └── state/                  # Processing state
        ├── processed.json      # File tracking state
        └── README.md
```

## Core Concepts

### Sub-Agent Architecture

The system is designed around **mandatory sub-agent decomposition**. This prevents context window overflow that degrades AI quality.

**Key principle:** When your context fills and the AI summarizes, critical details are lost. Sub-agents prevent this by:

1. Starting fresh with documented context
2. Persisting findings to files
3. Handing off through structured documents

### Phase Structure

Complex tasks follow this phase flow:

```
Interpretation → Analysis → Design → Design Review → Implementation → Implementation Review
```

Each phase can be its own sub-agent depending on scope.

### Quality Gates

Mandatory checkpoints between phases ensure:

- Work meets standards before progressing
- No blocking issues remain
- Context is sufficient for next phase

### Documentation-First

All findings are persisted to `.ai/scratch/<topic>/` directories. Sub-agents communicate through `_handoff.md` files.

## Adding Training Data

1. Create a new file: `lib/training/data/NNN.prompt.md`
2. Include the full prompt used
3. Optionally create `NNN.comment.md` with feedback
4. Run the Training-Processor agent to incorporate learnings

## Customization

### Adjusting Sizing Heuristics

Edit `lib/kernel/orchestration.md` to change:

- File count thresholds for sub-agent spawning
- Line count limits per implementation
- Context budget allocations

### Adding New Templates

Create new templates in `lib/templates/` following the existing patterns.

### Modifying Quality Gates

Edit `lib/kernel/quality-gates.md` to add or modify checkpoints.

## Troubleshooting

### "Context seems to be getting lost"

- Check that sub-agents are being used for large operations
- Verify handoff documents are being created
- Ensure context budget guidelines are being followed

### "Sub-agent didn't do what I expected"

- Check that KERNEL INHERITANCE was included in dispatch
- Verify input context was complete
- Review the handoff document for missing context

### "Quality gate failed"

- Review the specific checks that failed
- Check if work needs revision or clarification
- Consider if scope should be adjusted
