# .ai/

AI working directory for knowledge and execution artifacts.

## Structure

|Path|Purpose|Persistence|
|-|-|-|
|`library/`|Permanent knowledge|PERMANENT|
|`scratch/`|Ephemeral working space|TEMPORARY|
|`self-analysis/`|Execution improvement logs|PERMANENT|
|`memory/`|Ultra-dense AI-readable notes|PERMANENT|
|`suggestions/`|Improvement ideas|SEMI-PERMANENT|

## scratch/ Usage

Ephemeral. Deleted after task completion.

```
.ai/scratch/{topic}/
├── 01_interpretation/
├── 02_analysis/
├── 03_design/
├── 04_implementation/
└── _handoff.md
```

### Rules
- Create topic directory per task
- Number phases
- Always create `_handoff.md` before completing

## library/ Usage

Permanent. Grows organically.

```
.ai/library/
├── {topic}.md           # Start simple
├── {topic}/             # Evolve to folders
│   ├── overview.md
│   └── details/
```

### Rules
- Extract reusable patterns from scratch
- Keep files focused (one concept per file)
- No version suffixes (git handles versioning)

## self-analysis/ Usage

Log execution issues for continuous improvement.

```
.ai/self-analysis/
├── sessions/{date}-{topic}.md
├── compilations/{date}-{file}.md
└── violations/{date}-{category}.md
```

### Categories
- `DRIFT` — Deviated from task
- `OVERFLOW` — Context exceeded
- `GATE_SKIP` — Skipped verification
- `LAW_VIOLATION` — Three Laws breach
- `STAKES_BYPASS` — Stakes protocol ignored

## Never

- Leave scratch files after completion
- Delete library files without extraction
- Ignore self-analysis patterns (they indicate improvements)
