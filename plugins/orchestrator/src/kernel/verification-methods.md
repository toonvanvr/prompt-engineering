# Verification Methods
Lightweight verification for orchestrator phase transitions. Replaces full file re-reads.

## Core Principle
> SA handoff with `Status: COMPLETE` = evidence for gate passage. Verify outcomes, not content.

## Method Table
|Method|Command|Tokens|When|Reliability|
|-|-|-|-|-|
|SA handoff trust|Read `_handoff.md`|~30|After every SA|HIGH|
|File existence|`test -f {file} && echo exists`|~3|Verify creation|HIGH|
|Change scope|`git diff --stat`|~15/file|Verify modifications|HIGH|
|File size|`wc -l {file}`|~5/file|Verify non-trivial output|HIGH|
|Content spot-check|`head -5 / tail -5`|~50|Verify structure|MEDIUM|
|Pattern presence|`grep -c "pattern" {file}`|~5|Verify specific content|HIGH|
|Test execution|`npm test` / `pytest`|20-100|Verify correctness|HIGH|
|Status check|`git status --short`|~10/file|Verify working tree|HIGH|

## Orchestrator Verification Protocol
### After SA Completes
1. Read `_handoff.md` — Status, Confidence, Deliverables (≤80 lines)
2. COMPLETE + HIGH → gate passes
3. PARTIAL or LOW → lightweight checks from table
4. NEVER re-read full output artifacts for verification

### Between Phases
`git diff --stat` + `git status --short` + test execution + `find .ai/scratch/ -name "*.md" -size +20k`

### NEVER for Verification
- Full file re-reads of SA-processed files
- Re-running SA analysis on completed work
- Reading full output artifacts when handoff provides summary

## Integration
Referenced by: `orchestrator.src.md`, `quality-gates.md`, `model-behavior.md`
