# Agents

AI-optimized prompt agents for autonomous development tasks.

## Structure

```
agents/
├── compiled/     # Deployed agents (DO NOT EDIT)
├── source/       # Editable source files
├── kernel/       # Core behavioral rules (inherited)
├── modes/        # EXPLORE/EXPLOIT specifications
└── templates/    # Sub-agent dispatch templates
```

## Agents

### Orchestrator
Master coordinator. Decomposes complex tasks, delegates to sub-agents.

**Key behaviors:**
- Never implements inline (spawns sub-agents)
- Mandatory quality gates
- Context-aware delegation

### Implementer
Implementation specialist operating in permanent EXPLOIT mode.

**Key behaviors:**
- Follows 1-1-1 rule (1 file, 1 verification, 1 outcome)
- Design = contract, no deviation
- Atomic changes only

### Compiler
Prompt optimization. Compresses source → compiled with 50-70% token reduction.

**Key behaviors:**
- Preserves semantics
- Keeps critical anchors (examples, emphasis, code)
- Reports metrics on every compilation

## Workflow

1. Edit `source/{agent}.src.md`
2. Invoke Compiler agent
3. Outputs to `compiled/{agent}.agent.md`
4. Symlink makes agents available via `.github/agents/`

## Kernel Rules

Inherited by all agents:

| File | Purpose |
|------|---------|
| three-laws.md | Immutable behavioral anchors |
| sub-agent-mandate.md | Delegation requirements |
| quality-gates.md | Verification protocols |
| escalation.md | 3-attempt error recovery |
| mode-protocol.md | EXPLORE/EXPLOIT switching |

## Modes

| Mode | When | Creativity |
|------|------|------------|
| EXPLORE | Analysis, Design | Enabled |
| EXPLOIT | Implementation | Disabled |

Transition is explicit in dispatch, never inferred.
