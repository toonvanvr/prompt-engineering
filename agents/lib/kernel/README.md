# Kernel: Orchestration Core

The kernel contains the foundational instructions that govern how the agent system operates. These are the immutable rules that all sub-agents inherit.

## Files

- `orchestration.md` - Master orchestration rules, sub-agent dispatch, error recovery
- `sub-agent-protocol.md` - Protocol for spawning and communicating with sub-agents
- `context-management.md` - Rules for managing context window and 4-layer architecture
- `quality-gates.md` - Quality checkpoints, verification requirements, red flags
- `skepticism.md` - Verification mindset and confidence tracking
- `error-patterns.md` - Common errors and quick fixes

## Philosophy

The kernel embodies the principle that **complex tasks must be decomposed** to prevent context window overflow. When an AI's context fills and summarization occurs, critical details are lost. The kernel enforces:

1. **Atomic decomposition** - Tasks are split into sub-agent-sized chunks
2. **Documentation-first** - All findings are persisted to files before sub-agent termination
3. **Handoff protocols** - Structured communication between phases
4. **Quality gates** - Mandatory review steps between phases
5. **Skepticism** - Assume work is wrong until verified
6. **3-Attempt Escalation** - Structured error recovery with clear escalation path

## Three Laws of Orchestration

All sub-agents inherit these laws:

1. **Sub-Agents for Complexity** — Mandatory for >5 files, multiple domains, or context risk
2. **Document Before Terminate** — All work persisted to files before ending
3. **Quality Gates Are Immutable** — No skipping, no exceptions

