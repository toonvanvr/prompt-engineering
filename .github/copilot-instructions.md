# Copilot Instructions

This is a **self-evolving AI agent system** for prompt optimization and compilation. The codebase contains prompt engineering patterns, agent definitions, and a compilation workflow.

## Architecture

```
agents/
├── source/       # Human-readable source (EDIT HERE)
├── compiled/     # AI-optimized output (DO NOT EDIT)
├── kernel/       # Core behavioral rules (inherited by all agents)
├── modes/        # EXPLORE/EXPLOIT specifications
└── templates/    # Sub-agent dispatch templates

.ai/
├── library/      # Permanent knowledge (indexed, referenced on-demand)
├── scratch/      # Ephemeral working space (deleted after compilation)
└── self-analysis/# Execution logs for continuous improvement
```

## Key Workflows

### Editing Agents
1. Edit source in `agents/source/{agent}.src.md`
2. Invoke the Compiler agent to generate `agents/compiled/{agent}.agent.md`
3. Extract reusable patterns to `.ai/library/`
4. Clean `.ai/scratch/` directory
5. Symlink `.github/agents → agents/compiled/` exposes agents for deployment

### Agent Types
| Agent | Purpose |
|-------|---------|
| Orchestrator | Multi-phase coordination, mandatory sub-agent delegation |
| Implementer | Code implementation in permanent EXPLOIT mode |
| Compiler | Prompt compression (50-70% token reduction) |

## Core Patterns

### The Three Laws (Immutable)
1. **Sub-Agents for Complexity** — >5 files OR implementation → spawn sub-agent
2. **Document Before Terminate** — Create `_handoff.md` before termination
3. **Quality Gates Are Immutable** — No skip, no shortcuts, no exceptions

### EXPLORE vs EXPLOIT Modes
| Mode | When | Creativity |
|------|------|------------|
| EXPLORE | Analysis, Design | Enabled within guardrails |
| EXPLOIT | Implementation | Disabled, zero deviation |

Mode is declared explicitly in every sub-agent dispatch, never inferred.

### Kernel Inheritance
All agents inherit from `agents/kernel/` rules. Key files:
- `three-laws.md` — Immutable behavioral anchors
- `mode-protocol.md` — EXPLORE↔EXPLOIT switching
- `quality-gates.md` — Phase transition verification
- `escalation.md` — 3-attempt error recovery protocol

## Conventions

### File Locations
- **Never edit** files in `agents/compiled/` — these are generated
- **Source files** use `.src.md` extension
- **Compiled agents** use `.agent.md` extension with YAML frontmatter (name, description, tools)

### Documentation Principles
- Git handles versioning — no version folders
- Only definitive files remain after completion — no WIP
- `.ai/library/` grows organically: 1 file → folders → subfolders
- `.ai/scratch/` is ephemeral — knowledge extracted, then deleted

### Compression Rules (for Compiler)
- ALWAYS preserve: examples, emphasis (MUST/NEVER/ALWAYS), code blocks, format specs
- NEVER compress: numbers/thresholds, behavioral anchors
- Target: 50-70% token reduction without semantic drift
