# Agents

AI-optimized prompt agents for autonomous development tasks. Only **@orchestrator** is user-facing — all others are hidden subagents spawned automatically.

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

### Orchestrator (user-facing)
Master coordinator. The only agent users interact with directly. Decomposes complex tasks and delegates to hidden subagents.

**Key behaviors:**
- Never implements inline (spawns sub-agents)
- Mandatory quality gates
- Context-aware delegation

### Researcher (hidden subagent)
Codebase analysis and dependency mapping specialist.

**Key behaviors:**
- Deep code investigation
- Pattern finding across codebase
- Produces findings for downstream agents

### Designer (hidden subagent)
Architecture spec and trade-off analysis specialist.

**Key behaviors:**
- Creates design contracts for implementer
- Evaluates trade-offs
- Produces approved specs

### Implementer (hidden subagent)
Implementation specialist operating in permanent EXPLOIT mode.

**Key behaviors:**
- Follows 1-1-1 rule (1 file, 1 verification, 1 outcome)
- Design = contract, no deviation
- Atomic changes only

### Compiler (hidden subagent)
Prompt optimization. Compresses source → compiled with 50-70% token reduction.

**Key behaviors:**
- Preserves semantics
- Keeps critical anchors (examples, emphasis, code)
- Reports metrics on every compilation

## Workflow

1. Edit `source/{agent}.src.md`
2. Invoke Compiler agent
3. Outputs to `compiled/{agent}.agent.md`
4. `bin/install.sh` copies agents to `.github/agents/`

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
