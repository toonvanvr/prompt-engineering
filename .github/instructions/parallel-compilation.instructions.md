---
applyTo: "plugins/orchestrator/agents/*.agent.md"
---

# Parallel Compilation Rule

When recompiling agents on the prompt-engineering source repo (self-repo awareness), spawn one @Compiler SA per agent source file in parallel.

## Source Files
- `plugins/orchestrator/src/orchestrator.src.md`
- `plugins/orchestrator/src/implementer.src.md`
- `plugins/orchestrator/src/designer.src.md`
- `plugins/orchestrator/src/researcher.src.md`
- `plugins/orchestrator/src/compiler.src.md`

## Safe Swap Protocol
Each @Compiler SA MUST:
1. Write compiled output to `plugins/orchestrator/agents/{agent}.agent.md.new` (not directly to `.agent.md`)
2. Validate the `.new` file: YAML frontmatter present, markdown syntax valid, >10 lines, reduction metrics reported
3. On validation PASS: rename via terminal `mv {agent}.agent.md.new {agent}.agent.md` (atomic rename)
4. On validation FAIL: keep `.new` file, report error, do NOT overwrite existing `.agent.md`

## Why .new First
The `compiler.agent.md` may be in use by the compiler SA compiling itself. Writing to `.new` first ensures the original remains readable throughout compilation. The `mv` command performs an atomic `rename(2)` syscall on the same filesystem.

## Failure Handling
- If any compiler SA fails validation, its `.agent.md` remains unchanged
- Other parallel compiler SAs are NOT affected by one SA's failure
- Failed `.new` files are kept for debugging
