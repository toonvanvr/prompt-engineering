# Prompting Guide

How to talk to the Orchestrator — from one-liners to stream-of-consciousness.

## Quick Rules

- Talk naturally — no special syntax or formatting needed
- Be as specific or vague as you want; the orchestrator will clarify if needed
- One prompt = one task (or one coherent batch of related tasks)
- You don't need to tell it which agents to use

## Prompt Styles

### One-liner
Best for: targeted fixes, small additions, single-concern tasks.
See [one-liner.md](one-liner.md) for examples.

### Multi-concern
Best for: related changes across a few files, 2-5 bullet points.
See [multi-concern.md](multi-concern.md) for examples.

### Stream-of-consciousness
Best for: large refactors, new features, exploratory work. Write everything you're thinking.
See [stream-of-consciousness.md](stream-of-consciousness.md) for examples.

## What to Expect

- **Short prompts** → fast turnaround (research → implement, may skip design)
- **Medium prompts** → standard pipeline (research → design → implement)
- **Long prompts** → full pipeline with work breakdown and parallel sub-agents

## Tips

- If you have context (error messages, file names, function names), include them
- It's okay to be vague — "make this better" works; the orchestrator will investigate
- You can interrupt and redirect at any time via the chat
