# Verification Methods

## Description
Lightweight verification for post-SA review and phase transitions. Verify outcomes, not content. SA handoff with `Status: COMPLETE` = evidence for gate passage.

## Method Table

|Method|Command|When|Reliability|
|-|-|-|-|
|SA handoff trust|Read `_handoff.md`|After every SA|HIGH|
|File existence|`test -f {file} && echo exists`|Verify creation|HIGH|
|Change scope|`git diff --stat`|Verify modifications|HIGH|
|File size|`wc -l {file}`|Verify non-trivial output|HIGH|
|Content spot-check|`head -5 / tail -5`|Verify structure|MEDIUM|
|Pattern presence|`grep -c "pattern" {file}`|Verify specific content|HIGH|
|Test execution|`npm test` / `pytest`|Verify correctness|HIGH|
|Status check|`git status --short`|Verify working tree|HIGH|

## After SA Completes
1. Read `_handoff.md` — Status, Confidence, Deliverables
2. COMPLETE + HIGH confidence → gate passes
3. PARTIAL or LOW → run lightweight checks from table above

## Between Phases
`git diff --stat` + `git status --short` + test execution + `find .ai/scratch/ -name "*.md" -size +20k`

## Rules
- NEVER re-read full output artifacts for verification
- NEVER re-run SA analysis on completed work

### Fence Guard Check
Scan framework files for wrapping code fences:
- `grep -n '^```' plugins/orchestrator/src/*.src.md plugins/orchestrator/agents/*.agent.md skills/*/SKILL.md`
- Expected: 0 matches for source and compiled files
- SKILL.md: first line must NOT start with ```
- Templates (`plugins/orchestrator/src/templates/`): quad-backtick markdown allowed

