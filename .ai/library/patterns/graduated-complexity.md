# Pattern: Graduated Complexity Delegation

Sort tasks by complexity and delegate in ascending waves — trivial batched, small individual, cross-cutting isolated, architectural researched first. Never mix complexity levels in a single SA dispatch.

## When to Use
- Planning multi-SA work with tasks of varying complexity
- Orchestrator is deciding how to batch deliverables across SAs
- Wave 3+ tasks — always dispatch a research SA before implementation

## When NOT to Use
- Single-task dispatches where complexity is uniform
- When all tasks are the same wave level — just batch appropriately per SA limits

## Example
Wave 1: Batch 5 config tweaks into one SA. Wave 2: One SA per single-file feature (1-2 deliverables each). Wave 3: One SA for cross-cutting multi-file change (max 3 deliverables). Wave 4: Researcher SA analyzes architecture → Designer SA produces spec → Implementer SA executes. Each wave completes before the next starts.
