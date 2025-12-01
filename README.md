# Prompt Engineering

A self-evolving AI agent system for prompt optimization and compilation.

## Structure

```
.ai/
├── library/          # Permanent knowledge (indexed, on-demand)
│   ├── index.md      # Catalog of all knowledge
│   ├── patterns/     # Reusable prompt patterns
│   └── research/     # Permanent findings
├── scratch/          # Working space (deleted after compilation)
└── self-analysis/    # Execution logs for continuous improvement

agents/
├── compiled/         # AI-optimized agents (deployed)
├── source/           # Human-readable source (edit here)
├── kernel/           # Core behavioral rules
├── modes/            # EXPLORE/EXPLOIT specifications
└── templates/        # Dispatch templates for sub-agents

.github/
└── agents → ../agents/compiled/  # Symlink for deployment
```

## Agents

| Agent | Purpose |
|-------|---------|
| Orchestrator | Multi-phase coordination, sub-agent delegation |
| Implementer | Code implementation in EXPLOIT mode |
| Compiler | Prompt compression (50-70% token reduction) |

## Workflow

1. **Edit** source in `agents/source/`
2. **Compile** using Compiler agent
3. **Extract** reusable knowledge to `.ai/library/`
4. **Clean** scratch directory
5. **Commit** via git (history preserved in version control)

## Principles

- **No version folders** — Git handles versioning
- **No WIP after completion** — Only definitive files remain
- **Library grows organically** — 1 file → folders → subfolders
- **Scratch is ephemeral** — Knowledge extracted, then deleted

## Philosophy

> A living, self-learning organism with a clear goal.

The system learns from each compilation, extracts reusable patterns to the library, and maintains a clean repository state. Git provides full history; the repo shows only the current state.

---

*Versioned with git, not folders.*
