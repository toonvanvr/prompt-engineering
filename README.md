# Prompt Engineering

A self-evolving AI agent system for prompt optimization and compilation.

## Quick Start

```sh
./QUICKSTART.sh /path/to/your/workspace
```

This installs:
- **Agents** → `.github/agents/*.agent.md` (symlinks)
- **Templates** → `.github/agents/lib/templates/` (symlink)
- **Human Loop** → `.human/` (copied, workspace-local)

Re-run to update with newer versions.

## Structure

```
.ai/
├── library/          # Permanent knowledge (indexed, on-demand)
├── scratch/          # Working space (deleted after compilation)
└── self-analysis/    # Execution logs for continuous improvement

.human/
├── templates/        # Instruction templates (copy to instructions/)
├── instructions/     # Active instructions (AI reads)
└── processed/        # Completed instructions (AI archives)

agents/
├── compiled/         # AI-optimized agents (deployed)
├── source/           # Human-readable source (edit here)
├── kernel/           # Core behavioral rules
├── modes/            # EXPLORE/EXPLOIT specifications
└── templates/        # Dispatch templates for sub-agents
```

## Agents

|Agent|Purpose|
|-|-|
|Orchestrator|Multi-phase coordination, sub-agent delegation|
|Implementer|Code implementation in EXPLOIT mode|
|Compiler|Prompt compression (50-70% token reduction)|

## Human-in-the-Loop

Inject instructions during long-running tasks:

1. Copy template from `.human/templates/` → `.human/instructions/`
2. Edit checkboxes/values
3. Save — agent processes at next checkpoint

Templates: `abort`, `approve`, `context`, `feedback`, `pause`, `priority`, `redirect`, `skip-phase`

## Workflow

1. **Edit** source in `agents/source/`
2. **Compile** using Compiler agent
3. **Extract** reusable knowledge to `.ai/library/`
4. **Clean** scratch directory

## Principles

- **No version folders** — Git handles versioning
- **No WIP after completion** — Only definitive files remain
- **Library grows organically** — 1 file → folders → subfolders
- **Scratch is ephemeral** — Knowledge extracted, then deleted

## References

- [humanlayer/humanlayer](https://github.com/humanlayer/humanlayer) (Apache Software License 2.0)

---

*Versioned with git, not folders.*
