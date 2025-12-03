# prompt-engineering

Self-evolving AI agent system for prompt optimization and compilation.

## Quick Start

1. Read `.github/copilot-instructions.md` for project conventions
2. Check `agents/README.md` for agent system overview
3. Use `agents/kernel/` rules as behavioral foundation

## Directory Overview

|Path|Purpose|Edit?|
|-|-|-|
|`agents/source/`|Human-readable agent definitions|YES|
|`agents/compiled/`|Generated, token-optimized|NO (generated)|
|`agents/kernel/`|Inherited behavioral rules|YES (carefully)|
|`.ai/scratch/`|Ephemeral working space|YES (temporary)|
|`.ai/library/`|Permanent knowledge|YES|

## Key Workflows

### Edit Agent
1. Edit `agents/source/{agent}.src.md`
2. Invoke Compiler agent
3. Output: `agents/compiled/{agent}.agent.md`

### Add Knowledge
1. Create file in `.ai/library/{topic}.md`
2. Reference in agent dispatches as needed

## Conventions

- TODO annotations: `TODO(0-4)` priority system
- Modes: EXPLORE (discovery) / EXPLOIT (execution)
- Gates: Every phase has quality gate verification
- Stakes: LOW/MEDIUM/HIGH for tool calls
- Agent format: `.agent.md` with YAML frontmatter (name, description, tools)

## Never

- Edit `agents/compiled/` directly
- Skip quality gates
- Implement without design approval (high stakes)

## Related

See also `.github/copilot-instructions.md` for detailed conventions.
