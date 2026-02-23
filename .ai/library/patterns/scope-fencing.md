# Pattern: Scope Fencing

Every SA dispatch must include equally-specific DO and DO NOT lists plus a verification command that checks only in-scope deliverables. This prevents mid-task scope expansion, especially in research SAs that discover "one more thing."

## When to Use
- Every SA dispatch — DO/DO NOT/VERIFY is mandatory structure
- Research SAs — highest scope creep risk, need explicit exclusion boundaries
- When task boundaries are ambiguous (e.g., "save state" could mean scratch or library)

## When NOT to Use
- Never skip this pattern — all dispatches require scope fencing
- The specificity level may be reduced for trivial Wave 1 tasks, but DO NOT list is still required

## Example
```
DO: Reformat 4 pattern files in .ai/library/patterns/
DO NOT: Create new pattern files, modify kernel files, modify feedback files
VERIFY: grep -l "When to Use" .ai/library/patterns/{file1,file2,file3,file4}.md | wc -l  # Expected: 4
```
Out-of-scope discoveries go in handoff under "Future Work," never acted on.
