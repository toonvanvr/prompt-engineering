# Kernel: Orchestration Core

The kernel contains the foundational instructions that govern how the agent system operates. These are the immutable rules that all sub-agents inherit.

## Files

- `orchestration.md` - Master orchestration rules and sub-agent dispatch logic
- `sub-agent-protocol.md` - Protocol for spawning and communicating with sub-agents
- `context-management.md` - Rules for managing context window and documentation
- `quality-gates.md` - Quality checkpoints and review criteria

## Philosophy

The kernel embodies the principle that **complex tasks must be decomposed** to prevent context window overflow. When an AI's context fills and summarization occurs, critical details are lost. The kernel enforces:

1. **Atomic decomposition** - Tasks are split into sub-agent-sized chunks
2. **Documentation-first** - All findings are persisted to files before sub-agent termination
3. **Handoff protocols** - Structured communication between phases
4. **Quality gates** - Mandatory review steps between phases
