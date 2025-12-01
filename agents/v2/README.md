# v2 Agent System

Optimized prompt architecture with source/compiled separation.

---

## Overview

```
agents/v2/
├── compiled/     # AI-optimized prompts (generated)
├── source/       # Human-readable source (edit here)
├── kernel/       # Core behavior rules (inherited)
├── templates/    # Dispatch templates
├── modes/        # Mode specifications
└── README.md     # This file
```

---

## Structure

### `/compiled/` — AI-Optimized Agents

Generated from source. Used at runtime.

| Agent                   | Purpose                               |
| ----------------------- | ------------------------------------- |
| `orchestrator.agent.md` | Master coordinator, spawns sub-agents |
| `analyst.agent.md`      | Code analysis, pattern discovery      |
| `designer.agent.md`     | Architecture, solution design         |
| `implementer.agent.md`  | Code creation/modification            |
| `reviewer.agent.md`     | Quality verification                  |
| `compiler.agent.md`     | Prompt compilation (meta-agent)       |

Format: Compressed, 50-70% token reduction.

### `/source/` — Human-Readable Source

Edit here. Compile to `/compiled/`.

Format: Full prose, examples, rationale.

### `/kernel/` — Inherited Rules

Core behaviors. Referenced by all agents.

| File                   | Content                      |
| ---------------------- | ---------------------------- |
| `three-laws.md`        | Immutable orchestration laws |
| `consistency-stack.md` | 5-layer anchoring template   |
| `mode-protocol.md`     | EXPLORE ↔ EXPLOIT switching  |
| `sub-agent-mandate.md` | Mandatory spawning rules     |
| `context-budget.md`    | Token/file limits            |
| `quality-gates.md`     | Phase transition checks      |
| `self-analysis.md`     | Flaw documentation protocol  |
| `escalation.md`        | 3-attempt error protocol     |

### `/modes/` — Mode Specifications

| Mode         | Use Case                    |
| ------------ | --------------------------- |
| `explore.md` | Discovery, analysis, design |
| `exploit.md` | Implementation, execution   |

### `/templates/` — Dispatch Templates

Pre-formatted sub-agent prompts (to be created).

---

## Usage

### Running Compiled Agents

```markdown
# Reference compiled agent

@agent: agents/v2/compiled/analyst.agent.md
```

### Editing Agents

1. Edit in `/source/`
2. Run compiler agent
3. Output goes to `/compiled/`

### Kernel Inheritance

Agents inherit kernel rules via reference:

```markdown
## Kernel

@inherit: three-laws, sub-agent-mandate, escalation
```

---

## Modes

| Mode    | Creativity | Constraints     | Output  |
| ------- | ---------- | --------------- | ------- |
| EXPLORE | Enabled    | Guardrails only | Options |
| EXPLOIT | Disabled   | Full stack      | Exact   |

Transition: Design approved → EXPLOIT

---

## Migration from v1

```
Current: .github/agents → ./agents/
Future:  .github/agents → ./agents/v2/compiled/
```

### Steps

1. Build v2 alongside current (now)
2. Verify v2 agents work
3. Switch symlink
4. Deprecate legacy

---

## Token Budgets

| Component      | Target Lines | Target Tokens |
| -------------- | ------------ | ------------- |
| Compiled agent | 150-200      | 800-1200      |
| Source agent   | 300-400      | 2000-3000     |
| Kernel rule    | 50-100       | 300-600       |
| Mode spec      | 60-80        | 300-500       |

---

## Key Concepts

### Three Laws

1. **Sub-Agents for Complexity** — Spawn when threshold met
2. **Document Before Terminate** — Persist state always
3. **Quality Gates Are Immutable** — No skip ever

### 5-Layer Stack

1. Identity Matrix (who)
2. Three Laws (immutable)
3. ALWAYS/NEVER (binary)
4. Phases/Gates (sequential)
5. Output Format (exact)

### Self-Analysis

Log flaws to `.ai/self-analysis/` for continuous improvement.

---

## Quick Reference

```
Kernel: agents/v2/kernel/
Modes: agents/v2/modes/
Compiled: agents/v2/compiled/
Source: agents/v2/source/

EXPLORE = creativity on, options OK
EXPLOIT = creativity off, exact output

>5 files → sub-agent
>2 domains → sub-agents per domain
Gate fail → fix + re-verify
Error 3x → escalate
```
