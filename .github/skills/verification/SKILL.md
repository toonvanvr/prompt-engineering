```skill
# Verification Methods

## Description
Lightweight verification for post-SA review and phase transitions. Verify outcomes, not content.

## Method Table

|Method|Command|When|
|-|-|-|
|SA handoff trust|Read `_handoff.md`|After every SA|
|File existence|`test -f {file} && echo exists`|Verify creation|
|Change scope|`git diff --stat`|Verify modifications|
|File size|`wc -l {file}`|Verify non-trivial output|
|Content spot-check|`head -5 / tail -5`|Verify structure|
|Pattern presence|`grep -c "pattern" {file}`|Verify specific content|
|Test execution|`npm test` / `pytest`|Verify correctness|
|Status check|`git status --short`|Verify working tree|

## After SA Completes
1. Read `_handoff.md` — Status, Confidence, Deliverables
2. COMPLETE + HIGH confidence → gate passes
3. PARTIAL or LOW → run lightweight checks from table above

## Rules
- NEVER re-read full output artifacts for verification
- NEVER re-run SA analysis on completed work
- Between phases: `git diff --stat` + `git status --short` + test execution
```
