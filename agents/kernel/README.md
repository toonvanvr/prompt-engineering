# agents/kernel/

Core behavioral rules inherited by all agents.

## File Index

| File                     | Purpose                                                      | Mutability  |
| ------------------------ | ------------------------------------------------------------ | ----------- |
| `three-laws.md`          | Fundamental laws                                             | IMMUTABLE   |
| `quality-gates.md`       | Phase transition + error recovery + checkpoints              | STABLE      |
| `mode-protocol.md`       | EXPLORE/EXPLOIT definitions                                  | STABLE      |
| `tool-stakes.md`         | Risk classification                                          | STABLE      |
| `todo-conventions.md`    | TODO priority system                                         | STABLE      |
| `communication.md`       | Human-AI communication & override protocol                   | STABLE      |
| `context-budget.md`      | Read strategy & quality constraints                          | ADJUSTABLE  |
| `self-analysis.md`       | Logging categories                                           | STABLE      |
| `feedback-collection.md` | Automatic feedback capture                                   | STABLE      |
| `library-system.md`      | Knowledge persistence                                        | STABLE      |
| `prompt-preservation.md` | Prompt audit trail                                           | STABLE      |
| `output-budget.md`       | Output token limits                                          | ADJUSTABLE  |
| `thoroughness.md`        | Context reading rules                                        | STABLE      |
| `glossary.md`            | Shared terminology                                           | STABLE      |
| `model-behavior.md`      | Cross-model consistency                                      | STABLE      |
| `verification-methods.md`| Lightweight SA verification                                  | STABLE      |

### Redirects (merged/moved)

| File                   | Status                                          |
| ---------------------- | ----------------------------------------------- |
| `human-loop.md`        | → Merged into `communication.md`                |
| `escalation.md`        | → Merged into `quality-gates.md` § Error Recovery|
| `pattern-system.md`    | → Merged into `library-system.md`               |
| `sub-agent-mandate.md` | → Core triggers inlined in orchestrator source  |
| `consistency-stack.md` | → Moved to `agents/reference/consistency-stack.md`|

## Usage

Kernel files are referenced, not copied. Agent compilation injects relevant sections.

## Modification Rules

- **IMMUTABLE** files: Do not modify without explicit approval
- **STABLE** files: Changes require review; preserve existing behavior; additions preferred over modifications
- **ADJUSTABLE** files: Can be tuned per project needs
