# agents/precompiled/

Resolved intermediary files generated from source + @include resolution.

## Purpose

Each `.pre.md` file is the fully-resolved version of a `.src.md` — all `@include` directives replaced with actual content, annotated with source-map comments. This is the input for the compression phase.

## Pipeline

```
agents/source/*.src.md + shared/ + reference/
    → Phase 1: Resolve @includes → agents/precompiled/*.pre.md
    → Phase 2: Compress tokens → agents/compiled/*.agent.md
```

## Files

Generated. Do NOT edit manually — changes are overwritten on next resolve.

|File|Source|
|-|-|
|`orchestrator.pre.md`|`source/orchestrator.src.md`|
|`researcher.pre.md`|`source/researcher.src.md`|
|`designer.pre.md`|`source/designer.src.md`|
|`implementer.pre.md`|`source/implementer.src.md`|
|`compiler.pre.md`|`source/compiler.src.md`|

## Source Maps

Each section is preceded by `<!-- @source {path} L{start}-L{end} -->` comments tracking origin.
