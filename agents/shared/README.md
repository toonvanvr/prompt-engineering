# agents/shared/

Composable text fragments included by source files via `<!-- @include -->` directives.

## Purpose

Shared fragments eliminate duplication across agent source files. Each file contains one coherent concept at the right granularity for full-file inclusion.

## Edit Rules

- Edit HERE, not in sources — all includers inherit changes at next compilation
- Keep files at right granularity — if you need partial inclusion, split the file
- No `@include` inside shared files (leaf content only)
- Changes affect all agents that include the file — review impact before editing

## Files

|File|Lines|Included By|
|-|-|-|
|`architecture.md`|~8|All 5 agents|
|`startup-protocol.md`|~20|Researcher, Designer, Implementer, Compiler|
|`handoff-format.md`|~25|Researcher, Designer, Implementer, Compiler|
|`constraints.md`|~30|All 5 agents|
